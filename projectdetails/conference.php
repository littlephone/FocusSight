<html>


<Title>Try</Title>

<body>

<script src="https://rtcmulticonnection.herokuapp.com/dist/RTCMultiConnection.min.js"></script>
<script src="https://rtcmulticonnection.herokuapp.com/socket.io/socket.io.js"></script>

<button id="btn-open-or-join-room">Open or Join Room</button>

</body>
<script>
var conn = new RTCMultiConnection();
conn.socketURL = "https://labstry.com:443/";

conn.session ={
  audio : true, 
  video : true
}

conn.openOrJoin('fwefwefwfgwr3');
</script>