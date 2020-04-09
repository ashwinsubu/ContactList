package axs190172;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashSet;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;


public class SearchContact extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public SearchContact() {}
	
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html");
    }
    
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String param = request.getParameter("searchfor");
		int noOfMatches = 0;
		try {
			 Class.forName("com.mysql.jdbc.Driver");
			 Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/contactlist","root","root");
			 Statement stmt=con.createStatement();
			 List<String> qryList = new ArrayList<String>();
			 HashSet<Integer> contactIDset = new HashSet<Integer>();
			 for (Contact col : Contact.values()) {
				 qryList.add(SQLOp.SELECT.toString() + Contact.contact_id +SQLOp.FROM +  Contact.class.getSimpleName().toLowerCase() + SQLOp.WHERE + col.toString() + " like '%" + param +"%'"); 
			 }
			 for (Address col : Address.values()) {
				 qryList.add(SQLOp.SELECT.toString() + Contact.contact_id +SQLOp.FROM + Address.class.getSimpleName().toLowerCase() + SQLOp.WHERE + col.toString() + " like '%" + param +"%'"); 
			 }
			 for (Phone col : Phone.values()) {
				 qryList.add(SQLOp.SELECT.toString() + Contact.contact_id +SQLOp.FROM + Phone.class.getSimpleName().toLowerCase() + SQLOp.WHERE + col.toString() + " like '%" + param +"%'");
			 }
			 for (Date col : Date.values()) {
				 qryList.add(SQLOp.SELECT.toString() + Contact.contact_id +SQLOp.FROM + Date.class.getSimpleName().toLowerCase() + SQLOp.WHERE + col.toString() + " like '%" + param +"%'");
			 }
			 
			 ResultSet rs=null;
			 for(String query: qryList) {
				 rs = stmt.executeQuery(query);
				 while(rs.next()) {
					 noOfMatches++;
					 contactIDset.add(rs.getInt(1));
				 }
			 }
			 qryList = new ArrayList<String>();
			 JSONObject entryJson = new JSONObject();
			 
			 for(int contactID : contactIDset) {
				//retrieve contact table entries for contactID
				 String qry = SQLOp.SELECT.toString() + Contact.fname + "," + Contact.mname + "," +Contact.lname + SQLOp.FROM +  Contact.class.getSimpleName().toLowerCase() + SQLOp.WHERE + Contact.contact_id + "=" + contactID;
				 rs = stmt.executeQuery(qry);
				 JSONObject json = new JSONObject();
				 while(rs.next()) {
					 json.put(Contact.fname.toString(),rs.getString(Contact.fname.toString())).put(Contact.mname.toString(),rs.getString(Contact.mname.toString())).put(Contact.lname.toString() ,rs.getString(Contact.lname.toString()));
				 }
				 JSONObject tableQuery = new JSONObject();
				 tableQuery.put("contact", json);
				 
				 //retrieve address table entries for contactID
				 qry = SQLOp.SELECT.toString() + Address.address_id + ","+ Address.address_type + ","+ Address.address + ","+ Address.city + ","+ Address.state + ","+ Address.zip + SQLOp.FROM +  Address.class.getSimpleName().toLowerCase() + SQLOp.WHERE + Contact.contact_id + "=" + contactID;
				 rs = stmt.executeQuery(qry);
				 JSONArray jarr = new JSONArray();
				 while(rs.next()) {
					 json = new JSONObject();
					 json.put(Address.address_id.toString(),rs.getString(Address.address_id.toString())).put(Address.address_type.toString(),rs.getString(Address.address_type.toString())).put(Address.address.toString(),rs.getString(Address.address.toString())).put(Address.city.toString(),rs.getString(Address.city.toString())).put(Address.state.toString(),rs.getString(Address.state.toString())).put(Address.zip.toString(),rs.getString(Address.zip.toString()));
					 jarr.put(json);
				 }
				 tableQuery.put("address", jarr);
				 
				 //retrieve phone table entries for contactID
				 qry = SQLOp.SELECT.toString() + Phone.phone_id+ ","+ Phone.phone_type+ ","+ Phone.area_code+ ","+ Phone.number+ SQLOp.FROM +  Phone.class.getSimpleName().toLowerCase() + SQLOp.WHERE + Contact.contact_id + "=" + contactID;
				 rs = stmt.executeQuery(qry);
				 jarr = new JSONArray();
				 while(rs.next()) {
					 json = new JSONObject();
					 json.put(Phone.phone_id.toString(),rs.getString(Phone.phone_id.toString())).put(Phone.phone_type.toString(),rs.getString(Phone.phone_type.toString())).put(Phone.area_code.toString(),rs.getString(Phone.area_code.toString())).put(Phone.number.toString(),rs.getString(Phone.number.toString()));
					 jarr.put(json);
				 }
				 tableQuery.put("phone", jarr);
				 
				//retrieve date table entries for contactID
				 qry = SQLOp.SELECT.toString() + Date.date_id+ ","+ Date.date_type + "," + Date.date + SQLOp.FROM +  Date.class.getSimpleName().toLowerCase() + SQLOp.WHERE + Contact.contact_id + "=" + contactID;
				 rs = stmt.executeQuery(qry);
				 jarr = new JSONArray();
				 while(rs.next()) {
					 json = new JSONObject();
					 long timemillis = Long.parseLong(rs.getString(3));
					 DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
					 java.util.Date theDate = new java.util.Date(timemillis);
					 String dateString = df.format(theDate);

					 json.put(Date.date_id.toString(),rs.getString(Date.date_id.toString())).put(Date.date_type.toString(),rs.getString(Date.date_type.toString())).put(Date.date.toString(),dateString);
					 jarr.put(json);
				 }
				 tableQuery.put("date", jarr);
				 
				 entryJson.put(contactID+"", tableQuery);
			 }
			 
			 
			 
			 response.setContentType("application/json");
			 response.setCharacterEncoding("UTF-8");
			 PrintWriter out = response.getWriter();
			 out.write(new JSONObject().put("resultText", entryJson).put("hits", noOfMatches).toString());
			 out.flush();
			 con.close();
		} catch (Exception e) {
			 response.getWriter().println("<h3 style=\"color:red\">Error Occured!</h3>");
			 response.getWriter().println("<a href=\"index.jsp\"><h3>Go To HOME </h3></a>");
		}
		
	}
	
}
