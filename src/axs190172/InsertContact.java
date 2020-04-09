package axs190172;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Contacts
 */

enum SQLOp{
	INSERT("INSERT INTO "),
	DELETE("DELETE FROM "),
	SELECT("SELECT "),
	SELECTSTARFROM("SELECT * FROM "),
	FROM(" FROM "),
	UPDATE("UPDATE "),
	WHERE(" WHERE "),
	VALUES(" VALUES ('");
	
	private String query;
	SQLOp(String q) {
		query = q;
	}
	public String toString() {
       return this.query;
    }
}

enum Contact{
contact_id, fname, mname, lname;
}
enum Address{
address_id, contact_id, address_type, address, city, state,zip;
}
enum Phone{
phone_id, contact_id, phone_type, area_code, number;
}
enum Date{
date_id, contact_id, date_type, date;
}

public class InsertContact extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public InsertContact() {
        // TODO Auto-generated constructor stub
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html");
		 try {
			 Class.forName("com.mysql.jdbc.Driver");
			 Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/contactlist","root","root");
			 Statement stmt=con.createStatement();
			 ResultSet rs=stmt.executeQuery("select * from contact");
			 while(rs.next())
				 response.getWriter().println(rs.getInt(1)+"  "+rs.getString(2)+"  "+rs.getString(3) + " " +rs.getString(4) + "<br/>");  

			 con.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}


	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
		int contactID = 0;
		Statement stmt = null;
		Connection con = null;
		try {
			String fname = request.getParameter("fname");
			String mname = request.getParameter("mname");
			String lname = request.getParameter("lname");
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/contactlist","root","root");
	    stmt=con.createStatement();

	    String qry= SQLOp.INSERT.toString() + Contact.class.getSimpleName().toLowerCase() + "( " + Contact.fname + "," + Contact.mname + ","+ Contact.lname + ") " + SQLOp.VALUES.toString() + fname + "','" + mname+"','"+lname +"')";
	    stmt.executeUpdate(qry, Statement.RETURN_GENERATED_KEYS);
	    ResultSet rs = stmt.executeQuery("select last_insert_id()");
	    while(rs.next())
	    	contactID = rs.getInt(1);
		
		//out.println("The list of Address types are...");
		String addr_types[] = request.getParameterValues("addr_type");
		String addresses[] = request.getParameterValues("address");
		String cities[] = request.getParameterValues("city");
		String states[] = request.getParameterValues("state");
		String zips[] = request.getParameterValues("zip");
		for(int i=0;i<addr_types.length;i++) {
//			out.println("Addr_type= " + addr_types[i] +"; Address= "+ addresses[i] + "; city= " + cities[i] + "; state= " + states[i]+  "; zip= " + zips[i] +"<br/>");
			qry= SQLOp.INSERT.toString()+ Address.class.getSimpleName().toLowerCase() + "( " + Contact.contact_id + "," + Address.address_type+ ","+ Address.address+ ","+ Address.city + ","+ Address.state + ","+ Address.zip+ ") " +SQLOp.VALUES.toString()+contactID +"','"+addr_types[i] + "','" + addresses[i]+"','"+cities[i]+"','"+states[i]+"','"+zips[i] +"')";
		    stmt.executeUpdate(qry);
		}
		
		//out.println("The list of Phone types are...");
		
		String phone_types[] = request.getParameterValues("phone_type");
		String area_codes[] = request.getParameterValues("area_code");
		String phone_numbers[] = request.getParameterValues("phone_number");

		for(int i=0;i<phone_types.length;i++) {
//			out.println("ph_type= " + phone_types[i] +"; area code= "+ area_codes[i] + "; phone no= " + phone_numbers[i]);
			qry= SQLOp.INSERT.toString()+ Phone.class.getSimpleName().toLowerCase() + "( " + Contact.contact_id + "," + Phone.phone_type+ ","+ Phone.area_code+ ","+ Phone.number +  ") " +SQLOp.VALUES.toString()+contactID +"','"+phone_types[i] + "','" + area_codes[i]+"','"+phone_numbers[i]+"')";
		    stmt.executeUpdate(qry);
		}
		
		String date_types[] = request.getParameterValues("date_type");
		String dds[] = request.getParameterValues("date_mm");
		String mms[] = request.getParameterValues("date_dd");
		String yys[] = request.getParameterValues("date_yy");
		//out.println("The list of phone types are...");

		DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
		for(int i=0;i<date_types.length;i++) {
			if(mms[i] == null || "".equals(mms[i]) || dds[i] == null || "".equals(dds[i]) || yys[i] == null || "".equals(yys[i])) {
				continue;
			}
			Calendar cal = Calendar.getInstance();
			cal.set(Calendar.MONTH,  Integer.parseInt(mms[i])-1); 
			cal.set(Calendar.DATE, Integer.parseInt(dds[i])); 
			cal.set(Calendar.YEAR, Integer.parseInt(yys[i])); 
			cal.set(Calendar.HOUR_OF_DAY, 1);cal.getTimeInMillis();
			long timeMillis = cal.getTimeInMillis();
			//out.println("dateType= " + date_types[i] + "; date = " + df.format(cal.getTime()) + "; dateInMillis = " + df.format(cal.getTime()) );
			qry= SQLOp.INSERT.toString()+ Date.class.getSimpleName().toLowerCase() + "( " + Contact.contact_id + "," + Date.date_type+ ","+ Date.date + ") " +SQLOp.VALUES.toString()+contactID +"','"+date_types[i] +"','" + timeMillis +  "')";
		    stmt.executeUpdate(qry);
		}
		
	}catch (Exception e) {
		out.println("@@@Exception "+ e);
	}finally{
	      //finally block used to close resources
	      try{
	         if(stmt!=null)
	            con.close();
	      }catch(SQLException se){
	    	  out.println("@@@SQLException "+ se);
	      }// do nothing
	      try{
	         if(con!=null)
	            con.close();
	      }catch(SQLException se){
	         out.println("@@@SQLException "+ se);
	      }//end finally try
	   }
		response.setContentType("text/html");
		out = response.getWriter();
		out.println("<h3>Contact Inserted Successfully!!</h3>");
		out.println("<a href=\"index.jsp\"><h3>Go To HOME </h3></a>");

	}
}