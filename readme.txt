#AXS190172
#Ashwin Subramaniam

***ContactList Web Application Using Java***

=====TECHNICAL DEPENDENCIES=====

---LANGUAGE---
Java version: 11

---DATABASE---
MySQL version: 5.7.29-0ubuntu0.18.04.1
Database username: root
Database password: root
Database port no :3306 (run on localhost)
Inside ContactList folder find the createschema.sql
Login to MySQL and run the createschema.sql (find the command below)
mysql> source </path/>/ContactList/createschema.sql
The database will be created.

---SERVER---
Apache Tomcat version: 8.5 or 9
Port no: 8080 (Run on localhost)

---STARTING THE APPLICATION---
Install Apache Tomcat server and Paste the ContactList.war in the webapps folder.
Start the Apache Tomcat server
Open http://localhost:8080/ContactList/index.jsp on browser.
The application is good to go

---OPERATING SYSTEM---
Ubunt 18.04.1 (preferable)

---NOTE---
Read the Quick Start User Guide to learn how the application works.
The ContactList.war is found inside ContactList folder. 
The project is compiled using ant in JDK 11 version. Find the build.xml along with the project.
If you want to make build on your own, install 'ant' and Run command 'ant war' in command line with current working directory at ContactList folder.
