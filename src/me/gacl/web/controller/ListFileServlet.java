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
        //��ȡ�ϴ��ļ���Ŀ¼
        String uploadFilePath = "C:/Users/yohhd/Documents/GitHub/FocusSight/WebContent/WEB-INF/upload";
        System.out.println("ListFile"+uploadFilePath);
        //�洢Ҫ���ص��ļ���
        Map<String,String> fileNameMap = new HashMap<String,String>();
        //�ݹ����filepathĿ¼�µ������ļ���Ŀ¼�����ļ����ļ����洢��map������
        
        
        
        
        try {
			listfile(fileNameMap);
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}//File�ȿ��Դ���һ���ļ�Ҳ���Դ���һ��Ŀ¼
        //��Map���Ϸ��͵�listfile.jspҳ�������ʾ
        
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
        	String sql="select * from presource";  //��ʱ����ô洢���� where��pid��tid
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
        	   map.put(a,"��������д���ļ���");  //ǰ����select����������
        }   
    
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}