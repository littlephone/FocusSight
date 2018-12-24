package me.gacl.web.controller;

import java.io.File;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.focussight.stored.SQLToolkit;
import com.focussight.stored.TaskStored;

import oracle.jdbc.OracleTypes;



public class ListFileServlet extends HttpServlet {
	Connection conn = null;
	Statement stat = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	int pid =0;
	List<Map<String, Object>> listmap = new ArrayList<Map<String, Object>>();
   ArrayList<String> rlist=new ArrayList<String>(); 
	
    public void doGet(HttpServletRequest request, HttpServletResponse response)      
            throws ServletException, IOException {
    	
    	 String p=request.getParameter("pid");
    	 System.out.println("i am pid:"+p);
    	 pid=Integer.parseInt(p);
        
        String uploadFilePath = "C:/Users/yohhd/Documents/GitHub/FocusSight/WebContent/WEB-INF/upload";
        System.out.println("ListFile"+uploadFilePath);
       
        Map<String,String> fileNameMap = new HashMap<String,String>();
      
        
        
        
        
        try {
			listfile(fileNameMap);
		} catch (ClassNotFoundException | SQLException e) {
			
			e.printStackTrace();
		}
       
        
        request.setAttribute("fileNameMap", fileNameMap);
        request.getRequestDispatcher("/listfile.jsp").forward(request, response);
    }
    

    public void listfile(Map<String,String> map) throws SQLException, ClassNotFoundException{
        String a=null;
        try {
			SQLToolkit toolkit = new SQLToolkit();
			Connection conn = toolkit.Connect();
			CallableStatement cstmt = conn.prepareCall("{CALL XResources(?,?,?,?,?,?)}");
			cstmt.setInt(1, 1);
			cstmt.setInt(2, 0);
			cstmt.setInt(3, pid);
			cstmt.registerOutParameter(4, OracleTypes.TIMESTAMP);
			cstmt.setString(5, null);
			cstmt.registerOutParameter(6, OracleTypes.CURSOR);
			cstmt.execute();
			ResultSet rs = (ResultSet) cstmt.getObject(6);
			System.out.println("I am 1-2"+ pid);
			int i=0;
			while(rs.next()) {
				Map<String, Object> map1 = new HashMap<String, Object>();
				map1.put("path", rs.getString("path"));	
				System.out.println("path:"+ rs.getString("path"));
				listmap.add(map1);
				rlist.add(rs.getString("path"));
				System.out.println("list:"+ rlist.get(i));
				i++;
			}
			conn.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
     
        for (int i = 0; i < rlist.size(); i++)
        {  
        	String s1=rlist.get(i);
        	   s1=s1.trim();
        	   map.put(s1,s1);  
        
        }
        }   
    
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}