package me.gacl.web.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



public class ListFileServlet extends HttpServlet {
	Connection conn = null;
	Statement stat = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //获取上传文件的目录
        String uploadFilePath = "C:/Users/yohhd/Documents/GitHub/FocusSight/WebContent/WEB-INF/upload";
        System.out.println("ListFile"+uploadFilePath);
        //存储要下载的文件名
        Map<String,String> fileNameMap = new HashMap<String,String>();
        //递归遍历filepath目录下的所有文件和目录，将文件的文件名存储到map集合中
        
        
        
        
        try {
			listfile(fileNameMap);
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}//File既可以代表一个文件也可以代表一个目录
        //将Map集合发送到listfile.jsp页面进行显示
        
        request.setAttribute("fileNameMap", fileNameMap);
        request.getRequestDispatcher("/listfile.jsp").forward(request, response);
    }
    

    public void listfile(Map<String,String> map) throws SQLException, ClassNotFoundException{
        String a=null;
        	Class.forName("oracle.jdbc.driver.OracleDriver");
             String connectionstr = "jdbc:oracle:thin:@localhost:1521:ORCL";
             conn = DriverManager.getConnection(connectionstr, "system", "Ky77676849f");
        	int id = 0;
        	try{
        	stat = conn.createStatement();
        	String sql="select * from presource";  //到时候改用存储过程 where是pid和tid
        	System.out.println("I am select	1");	
        	ps = conn.prepareStatement(sql); 
        	 rs = ps.executeQuery();   
        		System.out.println("I am select	2");	
        	
        	rs.next();
        	 a= rs.getString("path");
        	
        	System.out.println(a);
        	}catch(Exception e){
        	e.printStackTrace();
        	}finally{
        	conn.close();
        	}         
        	   map.put("abc", "abcd");
        	   map.put(a,"这个是随便写的文件名");  //前面是select出来的名字
        }   
    
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}