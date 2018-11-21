package com.focussight;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.focussight.stored.SQLToolkit;

import java.sql.*;

/**
 * Servlet implementation class CreateProject
 */
@WebServlet("/CreateProject")
public class CreateProject extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreateProject() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//getDatabase Connection
		SQLToolkit toolkit = new SQLToolkit();
		Connection conn = toolkit.Connect();
		
		int userid = (Integer) request.getSession().getAttribute("id");
		
		String projectname = (String)request.getParameter("projectname");
		System.out.println(projectname);
		String requirements = (String)request.getAttribute("requirements");
		
		//Doing insert into the database
		String CreateProjectSQL = "INSERT INTO project(pname, manager_id, requirements, progress) VALUES(?,?,?,0)";
		
		//SQL for checking newly created pid
		String ProjectIdCheck = "SELECT * FROM project WHERE pname= ? AND manager_id = ?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(CreateProjectSQL);
			pstmt.setString(1,  projectname);
			pstmt.setInt(2, userid);
			pstmt.setString(3, requirements);
			//From this point here, we have all the parameters prepared
			
			pstmt.executeUpdate();
			
			
			//Then we are getting the project id so that we could redirect users into
			pstmt = conn.prepareStatement(ProjectIdCheck);
			pstmt.setString(1, projectname);
			pstmt.setInt(2, userid);
			
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			int pid = rs.getInt("pid");				
			
			conn.close();
			response.sendRedirect("project.jsp?pid="+pid);
		
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
