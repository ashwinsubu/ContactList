package axs190172;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UpdateContact extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public UpdateContact() {}
	
	   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			// TODO Auto-generated method stub
			response.setContentType("text/html");
	    }
	   
		protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			String id = request.getParameter("id");
			String newVal = request.getParameter("newVal");
			
			String split[] = id.split("_");
			String contactID = split[0];
			String f = split[1];
			String field = null;
			String tableName = null;
			String IDtype= null;
			switch(f) {
				
				case "phonetype" : field = Phone.phone_type.toString(); 
									tableName = Phone.class.getSimpleName().toLowerCase(); 
									IDtype = Phone.phone_id.toString(); break;
				
				case "areacode" : field = Phone.area_code.toString();
									tableName = Phone.class.getSimpleName().toLowerCase();
									IDtype = Phone.phone_id.toString(); break;
									
				case "number": tableName = Phone.class.getSimpleName().toLowerCase(); 
								IDtype = Phone.phone_id.toString(); break;
				
				case "datetype" : field = Date.date_type.toString();
				case "date":tableName = Date.class.getSimpleName().toLowerCase();
							IDtype = Date.date_id.toString(); break;
				
				case "addresstype" : field = Address.address_type.toString();
				case "city":;
				case "address":;
				case "state":;
				case "zip":tableName = Address.class.getSimpleName().toLowerCase(); 
							IDtype = Address.address_id.toString(); break;
				
				case "fname":;
				case "lname":;
				case "mname": tableName = Contact.class.getSimpleName().toLowerCase(); 
								IDtype = Contact.contact_id.toString(); break;
				
				default: field = f;
			}
			
			field = field == null? f: field;
			boolean isDate = false;
			long dateMillis = 0;
			if("date".equalsIgnoreCase(field)) {
				isDate = true;
			    try {
					java.util.Date date=new SimpleDateFormat("MM/dd/yyyy HH:mm:ss").parse(newVal + " 01:01:01");
					dateMillis  = date.getTime();
				} catch (ParseException e) {
					
				}  

			}
			String qry;
			
			if(!isDate)
				qry = SQLOp.UPDATE.toString() + tableName + " SET " + field + "='" + newVal +"'" + SQLOp.WHERE + IDtype+"="+contactID ;
			else 
				qry = SQLOp.UPDATE.toString() + tableName + " SET " + field + "=" + dateMillis + SQLOp.WHERE + IDtype+"="+contactID ;
				
			Statement stmt = null;
			Connection con = null;
			try {
				Class.forName("com.mysql.jdbc.Driver");
				con = DriverManager.getConnection("jdbc:mysql://localhost:3306/contactlist","root","root");
			    stmt=con.createStatement();
			    stmt.executeUpdate(qry);
			    con.close();
			} catch(Exception e) {
				
			}
			
			
		}
}
