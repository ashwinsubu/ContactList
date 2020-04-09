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

.submit_btn {
  padding: 15px 25px;
  font-size: 19px;
  text-align: center;
  cursor: pointer;
  outline: none;
  color: #fff;
  background-color: #4CAF50;
  border: none;
  border-radius: 15px;
  box-shadow: 0 9px #999;
}

.submit_btn:hover {background-color: #3e8e41}

.submit_btn:active {
  background-color: #3e8e41;
  box-shadow: 0 5px #666;
  transform: translateY(4px);
}

.label{
display:inline-block;
width:130px;
}
</style>


<H1> CONTACT LIST </H1>

<a href="javascript:;" onclick="goToSearch()"> <h3> Search for Contact </h3></a>

<h2>Insert Contact </h2>

 <form action="insert" method="post" id="contact_form">
	<p><div class="label">First name <b style="color:tomato">*</b>:</div>  <input type="text" name="fname" id="fname" onkeypress="return isAlphaKey(event)" maxlength="20" required ><br/></p>
	<p><div class="label">Middle name:</div> <input type="text" name="mname" id="mname" onkeypress="return isAlphaKey(event)" maxlength="20" ><br/></p>
	<p><div class="label">Last name:</div>   <input type="text" name="lname" id="lname" onkeypress="return isAlphaKey(event)" maxlength="20" ><br/></p>
	
	
	<div id="address_list">
	  <div id="address">
	  	<h4>____Address Information____</h4>
		<p><div class="label">Address Type:</div>   <input type="text" name="addr_type" id="addr_type" maxlength="20" ><br/></p>
		<p><div class="label">Address:</div>   <input type="text" name="address" id="address" maxlength="40"><br/></p>
		<p><div class="label">City:</div>   <input type="text" name="city" id="city" onkeypress="return isAlphaKey(event)" maxlength="20" ><br/></p>
		<p><div class="label">State:</div>   <input type="text" name="state" id="state" onkeypress="return isAlphaKey(event)" maxlength="20"><br/></p>
		<p><div class="label">Zip:</div>   <input type="text" name="zip" id="zip" onkeypress="return isNumberKey(event)" maxlength="8" ><br/></p>
	  </div>
	  
	</div>
	<a href="javascript:;" onclick="addAddress()">+ Add Address </a>
	
	<div id="phone_list">
	  <div id="phone">
	  	<h4>____Phone Information____</h4>
		<p><div class="label">Phone Type:</div>   <input type="text" name="phone_type" id="phone_type" maxlength="20" ><br/></p>
		<p><div class="label">Area Code:</div>   <input type="text" name="area_code" id="area_code" onkeypress="return isNumberKey(event)" maxlength="3" ><br/></p>
		<p><div class="label">Number:</div>		<input type="text" name="phone_number" id="phone_number" onkeypress="return isNumberKey(event)" maxlength="7"><br/></p>
		
	  </div>
	
	</div>
	  <a href="javascript:;" onclick="addPhone()">+ Add Phone </a>
	
	<div id="date_list">
		<div id="date">
		<h4>___Date Info___</h4>
		<p><div class="label">Date Type:</div>   <input type="text" name="date_type" id="date_type" maxlength="20"><br/></p>
		<p><div class="label">Date:(MM/DD/YYYY)</div>   <input type="text" name="date_mm" id="date_mm" maxlength="2" style="width: 25px;" > /  <input type="text" name="date_dd" id="date_dd" maxlength="2" style="width: 25px;"> / <input type="text" name="date_yy" id="date_yy" maxlength="4" style="width: 50px;"><br/></p>
		</div>
	</div>
		  <a href="javascript:;" onclick="addDate()">+ Add Date</a><br/><br/>
	
	
	
	
	<input type="submit" class="submit_btn" value="Submit"  />
 </form>  


<script>

function addAddress(){
	 var itm = document.getElementById("address");
	 var cln = itm.cloneNode(true);
	 document.getElementById("address_list").appendChild(cln);
}

function addPhone(){
	 var itm = document.getElementById("phone");
	 var cln = itm.cloneNode(true);
	 document.getElementById("phone_list").appendChild(cln);
}

function addDate(){
	 var itm = document.getElementById("date");
	 var cln = itm.cloneNode(true);
	 document.getElementById("date_list").appendChild(cln);
}

function goToSearch(){
	window.location.href = "search.jsp";
}

function isNumberKey(evt){
	var charCode = (evt.which) ? evt.which : event.keyCode;
    if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57))
        return false;

    return true;
}

function isAlphaKey(evt){
	var charCode = (evt.which) ? evt.which : event.keyCode;
    if (charCode >=97 && charCode <= 122 || (charCode >= 65 && charCode <=90))
        return true;

    return false;
}


</script>


</body>
</html>