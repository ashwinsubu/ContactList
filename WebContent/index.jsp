<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<style>
a:hover{
	color:grey;
}

a{
text-decoration:none;
}
</style>

<H1> CONTACT LIST WEB APPLICATION</H1>
<h3>Developed and Designed by Ashwin Subramaniam AXS190172</h3>

<a href="javascript:;" onclick="goToSearch()"> <h4> Search for Contact  (update and delete after search)</h4></a>
<a href="javascript:;" onclick="goToInsert()"> <h4> Insert a Contact </h4></a>


<script>
function goToSearch(){
	window.location.href = "search.jsp";
}

function goToInsert(){
	window.location.href = "insert.jsp";
}
</script>


</body>
</html>