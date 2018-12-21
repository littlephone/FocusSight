package com.focussight.manbean;

public class FileMBean {
 int pid=0;
 int oid=0;
 int tid=0;
 int uid=0;
 String filename=null;
public int getPid() {
	return pid;
}
public void setPid(int pid) {
	this.pid = pid;
}
public int getOid() {
	return oid;
}
public void setOid(int oid) {
	this.oid = oid;
}
public int getTid() {
	return tid;
}
public void setTid(int tid) {
	this.tid = tid;
}
public int getUid() {
	return uid;
}
public void setUid(int uid) {
	this.uid = uid;
}
public String getFilename() {
	return filename;
}
public void setFilename(String filename) {
	this.filename = filename;
}
}
