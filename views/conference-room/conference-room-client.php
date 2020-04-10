<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">

    <link rel="stylesheet" href="https://unpkg.com/bootstrap@4.4.1/dist/css/bootstrap.min.css">

    <!-- IE 9 + Edge Polyfill -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/event-source-polyfill/0.0.9/eventsource.js"></script>
    <script src="https://www.unpkg.com/get-user-media-promise@1.1.4/lib/get-user-media-promise.js"></script>

    <script src="//www.unpkg.com/jquery@latest/dist/jquery.min.js"></script>
    <script src="//www.unpkg.com/bootstrap@4.4.1/dist/js/bootstrap.min.js"></script>
    <script src="https://unpkg.com/vue@2.6.11/dist/vue.min.js"></script>

    <title>Conference Room - Focussight</title>
</head>
<body>
<div class="conf-room-container">
    <video class="w-100" id="remoteVideo" autoplay="true" muted="muted"></video>
    <div class="position-absolute" style="bottom: 1em; right: 1em; width: 200px; height: auto;">
        <div class="embed-responsive embed-responsive-16by9">

        </div>
        <video class="w-100" id="localVideo" autoplay="true" muted="muted"></video>
    </div>
</div>

</html>

<script>
    var conference_room = new Vue({
        el: '.conf-room-container',
        data: {
            url: <?php echo json_encode(BASE_ROOT_API_URL . '/web-conference-event-source.php')?>,
            answer : 0,
            user_media: undefined,
            local_video_stream: undefined,
            event_source: undefined,
            rtc_peer_connection : undefined,
            peer_connection: undefined,
            config: {
                iceServers:  [
                    { urls : 'stun:stun.stunprotocol.org:3478'},
                    { urls : 'stun:stun.l.google.com:19302'},
                ]
            }
        },
        mounted: function(){
            this.startWebRTC();
        },
        methods:{
            initEventSource: function(){
                var self = this;
                try {
                    self.event_source = new EventSource(self.url);
                }
                catch(e) {
                    console.error("Could not create eventSource ",e);
                }
                //Self defined EventSource Sent and on message Hacks
                self.event_source.send = function(msg){
                    var xhttp = new XMLHttpRequest();
                    xhttp.onreadystatechange = function() {
                        if (this.readyState!=4) {
                            return;
                        }
                        if (this.status != 200) {
                            console.log("Error sending to "+ self.url + " with message: " +msg);
                        }
                    };
                    xhttp.open("POST", self.url , true);
                    xhttp.setRequestHeader("Content-Type","Application/X-Www-Form-Urlencoded");
                    xhttp.send(msg);
                }
                self.event_source.onmessage = function(e) {
                    if (e.data.includes("_MULTIPLEVENTS_")) {
                        var multiple = e.data.split("_MULTIPLEVENTS_");
                        for (var x=0 ; x < multiple.length ; x++) {
                            self.onReceiveSingleMessage(multiple[x]);
                        }
                    } else {
                        self.onReceiveSingleMessage(e.data);
                    }
                }
            },
            startWebRTC: function(){
                var self = this;
                navigator.mediaDevices.getUserMedia({
                    audio: true,
                    video: {
                        width: {
                            ideal: 1280
                        },
                        height: {
                            ideal: 720
                        },
                        facingMode: {
                            ideal : "user"
                        }
                    }
                }).then(function(stream){
                    $('#localVideo')[0].srcObject = stream;
                    self.local_video_stream = stream;
                    self.initEventSource();

                    // Broadcast myself
                    $('#localVideo').on('loadedmetadata',
                        function () {
                            self.publish('client-call', null);
                        }
                    );
                });

            },
            publish: function (event, data) {
                var self = this;
                console.log("sending ws.send: " + event);
                self.event_source.send(
                    JSON.stringify({event:event, data:data})
                );
            },
            onReceiveSingleMessage: function(data){
                var self = this;
                var package = JSON.parse(data);
                var data = package.data;
                console.log("received single message: " + package.event);
                switch (package.event) {
                    case 'client-call' : self.handleClientCall(); break;
                    case 'client-answer' : self.handleClientAnswer(data); break;
                    case 'client-offer' : self.handleClientOffer(); break;
                    case 'client-candidate' : self.handleClientCandidate(data);
                }
            },
            handleClientCall: function(){
                var self = this;
                self.setICECandidate(self.local_video_stream);
                self.peer_connection.createOffer({
                    offerToReceiveAudio: 1,
                    offerToReceiveVideo: 1
                }).then(function(success){
                    self.peer_connection.setLocalDescription(success).then(
                        function () {
                            self.publish('client-offer', self.peer_connection.localDescription);
                        }
                    ).catch(function (e) {
                        console.log("Problem with publishing client offer" + e);
                    });
                }).catch(function (e) {
                    console.log("Unable to handle client-call: "+ e);
                });
            },
            handleClientOffer: function(data){
                var self = this;
                self.setICECandidate(self.local_video_stream);
                self.peer_connection.setRemoteDescription(new RTCSessionDescription(data),
                    function(){
                        if(!self.answer){
                            self.peer_connection.createAnswer(function(description){
                                self.peer_connection.setLocalDescription(description, function () {
                                    self.publish('client-answer', self.peer_connection.localDescription);
                                    },
                                    function(e){
                                        //Fail to set local description
                                        console.log('Unable to set local description of answering client' + e);
                                    }
                                );
                            }, function(e){
                                console.log("Problem while doing client-offer: ",e);
                            });
                            self.answer = 1;
                        }
                    },
                    function (e) {
                    console.log('Unable to handle client offer: ' + e);
                });
            },
            handleClientAnswer: function(data){
                var self = this;
                if(self.peer_connection === undefined){
                    console.log('No client offer, unable to continue');
                }
                self.peer_connection.setConfiguration(new RTCSessionDescription(data), function(){},
                    function (e){
                        console.log('Unable to handle client answer: ' + e);
                    }
                );
            },
            handleClientCandidate: function(data){
                var self = this;
                if(self.peer_connection === null){
                    console.log('No client offer is available. Thus can\'t handle client candidate');
                    return;
                }
                //else
                self.peer_connection.addIceCandidate()
            },
            setICECandidate: function (stream) {
                var self = this;
                self.peer_connection = new RTCPeerConnection(self.config.iceServers);
                self.peer_connection.onicecandidate = function (event) {
                    if (event.candidate) {
                        self.publish('client-candidate', event.candidate);
                    }
                };
                try{
                    self.peer_connection.addStream(self.local_video_stream);
                }catch(e){
                    var tracks = self.local_video_stream.getTracks();
                    for(var i=0;i<tracks.length;i++){
                        self.addTrack(tracks[i], self.local_video_stream);
                    }
                }
                self.peer_connection.ontrack = function(e){
                    $('#remoteVideo')[0].srcObject = e.streams[0];
                }
            },

        }
    });

</script>