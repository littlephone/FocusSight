package com.focussight.stored;

import java.sql.*;


public class SQLToolkit{
	public Connection conn = null;
	public String JDBC_DRIVER = "oracle.jdbc.driver.OracleDriver";
	public String connectionstr = "jdbc:oracle:thin:@202.182.100.53:1521:XE";
	
	
	public Connection Connect() {
		try{
			Class.forName(JDBC_DRIVER);
			conn = DriverManager.getConnection(connectionstr, "system", "plyg2043");
			
		}catch(Exception cnfe) {
			cnfe.printStackTrace();
			
		}
		return conn;
	}
	public int countRows(ResultSet rs) {
		//Ensure that you have enabled ResultSet.TYPE_SCROLL_INSENSITIVE , ResultSet.CONCUR_READ_ONLY
		
		int numrows = 0;
		try{
			rs.last();
			numrows = rs.getRow();
			//For security, we choose to go back to the first row for future use
			System.out.println(numrows);
			rs.beforeFirst();
			
		}catch(Exception e) {
			e.printStackTrace();
			
		}
		return numrows;
	}
	
	public void Close() {
		try{
			conn.close();
		}catch(SQLException e) {
			
		}
	}
	
}
