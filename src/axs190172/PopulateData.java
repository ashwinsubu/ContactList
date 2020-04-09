package axs190172;

import java.io.BufferedReader;
import java.io.FileReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class PopulateData {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		int count = 0;
		int workAddressCount=0;
		boolean workaddr = false, homeaddr=false;
		boolean workphone = false, homephone = false;
		boolean isFirstIter = false;
		List<List<String>> records = new ArrayList<>();
		try (BufferedReader br = new BufferedReader(new FileReader("C:\\Users\\ashwi\\Downloads\\Contacts.csv"))) {
			String line;
			Class.forName("com.mysql.jdbc.Driver");  

			 Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/contactlist","root","root");  
			 Statement stmt=con.createStatement();  
			 
			 
			 con.close();  
			
		    while ((line = br.readLine()) != null) {
		    	if(!isFirstIter) {
			    	isFirstIter = true; 
			    	continue;
			    }
		        String[] values = line.split(",",-1);
		        
		        /*Insert into Contact Table*/
		        String fName = values[1];
		        String mName = values[2];
		        String lName = values[3];
		        String record1="INSERT INTO contact (fname, mname, lname) " + "VALUES ("+ fName+","+ mName+","+ lName +" )";
				stmt.executeUpdate(record1);
		        
				/*Insert into Phone Table*/
		        
				//String areacode = "insert into phone ()"
		        
		        
		        if(values[6] != null && !"".equals(values[6]) ) {
		        	count++;
		        	homeaddr = true;
		        }
		        if(values[11] != null && !"".equals(values[11])) {
		        	workAddressCount++;
		        	workaddr = true;
		        }
		        
		        
		        
		        //records.add(Arrays.asList(values));
		    }
//		    System.out.println("home addr count= " + count);
//		    System.out.println("work addr count= " + workAddressCount);
		} catch(Exception e) {
			System.out.println("Error/// " + e);
		}
		 System.out.println("home addr count= " + count);
		 System.out.println("work addr count= " + workAddressCount);
		 try {
			 Class.forName("com.mysql.jdbc.Driver");  

			 Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/contactlist","root","root");  
			 Statement stmt=con.createStatement();  
			 ResultSet rs=stmt.executeQuery("select * from contact");  
				 
			 con.close();  
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}

}
