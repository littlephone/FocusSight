package com.focussight.bean;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class UploadHandleServlet extends HttpServlet {
	Connection conn = null;
	Statement stat = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	String[] arr=new String[4];
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
          
                String savePath = "C:/Users/yohhd/Documents/GitHub/FocusSight/WebContent/WEB-INF/upload";
        
               
                System.out.println("0"+savePath);
                File file = new File(savePath);
           
                if (!file.exists() && !file.isDirectory()) {
                    System.out.println(savePath+"目录不存在，需要创建");
                   
                    file.mkdir();
                }
              
                String message = "";
                try{
                    
                    DiskFileItemFactory factory = new DiskFileItemFactory();
                   
                    ServletFileUpload upload = new ServletFileUpload(factory);
                    
                    upload.setHeaderEncoding("UTF-8"); 
                   
                    if(!ServletFileUpload.isMultipartContent(request)){
                        
                        return;
                    }
                    int i=0;
           
                    List<FileItem> list = upload.parseRequest(request);
                    for(FileItem item : list){
                    
                        if(item.isFormField()){
                            String name = item.getFieldName();
                            
                            
                            String value = item.getString("UTF-8");
                            arr[i]=value;
                            i++;
                           
                            System.out.println(name + "=" + value);
                            
                        }else{
                           
                            String filename = item.getName();
                            System.out.println("1:"+filename);
                            arr[i]=filename;
                            if(filename==null || filename.trim().equals("")){
                                continue;
                            }
                    
                            filename = filename.substring(filename.lastIndexOf("\\")+1);
                            
                            System.out.println("2:"+filename);
                          
                            InputStream in = item.getInputStream();
               
                            FileOutputStream out = new FileOutputStream(savePath + "\\" + filename);
                            System.out.println("3."+savePath + "\\" + filename);
                        
                            byte buffer[] = new byte[1024];
              
                            int len = 0;
          
                            while((len=in.read(buffer))>0){
                            
                                out.write(buffer, 0, len);
                            }
                        
                            in.close();
                         
                            out.close();
                  
                            item.delete();
                            saveLocalPhotoInfo();
                            System.out.println("i am savelocalphoto");
                            message = "文件上传成功！";
                        }
                    }
                }catch (Exception e) {
                    message= "文件上传失败！";
                    e.printStackTrace();
                    
                }
                request.setAttribute("message",message);
                request.getRequestDispatcher("/message.jsp").forward(request, response);
    }

    public void saveLocalPhotoInfo() throws SQLException, ClassNotFoundException{
    	Class.forName("oracle.jdbc.driver.OracleDriver");
         String connectionstr = "jdbc:oracle:thin:@202.182.100.53:1521:XE";
         conn = DriverManager.getConnection(connectionstr, "system", "plyg2043");
    	int id = 0;
    	try{
    	stat = conn.createStatement();
    	int pid=Integer.parseInt(arr[0]);
    	System.out.println("i am pid"+pid);
    	int tid=Integer.parseInt(arr[1]);
    	System.out.println("i am tid"+tid);
    	String filename=arr[2];
    	System.out.println("i am filename"+filename);
    	String sql="insert into resources (pid,tid,path) values ("+pid+","+tid+",'"+filename+" ')";
    	System.out.println("I am insert");
    	ps = conn.prepareStatement(sql);
    	ps.executeUpdate();
    	}catch(Exception e){
    	e.printStackTrace();
    	}finally{
    	conn.close();
    	}
    	}
    
    
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request, response);
    }
}
