<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="ISO-8859-1">
<title>Insert title here</title>
<style>
table, td, th {
  border: 1px solid black;
}

td:hover {
  background-color: #cecdcd;
}

a:hover{
	color:white !important;
}

a{
text-decoration:none;
}

table {
  border-collapse: collapse;
  width: 100%;
}

th {
  height: 50px;
}

#heading td{
font-weight: 900; 
background-color:#efefef;
}
.menu a:hover
{
    color:grey ! important;
}
.submit_btn {
  padding: 8px 15px;
  font-size: 13px;
  text-align: center;
  cursor: pointer;
  outline: none;
  color: #fff;
  background-color: #4CAF50;
  border: none;
  border-radius: 9px;
  box-shadow: 0 6px #999;
}

.submit_btn:hover {background-color: #3e8e41}

.submit_btn:active {
  background-color: #3e8e41;
  box-shadow: 0 5px #666;
  transform: translateY(4px);
}
</style>
</head>
<body>
<h2>SEARCH Contact</h2>

<input type="text"  placeholder="Search" name="serach_field" id="search_field" ><br/><br/>
<button value="Search" onclick="search()" class="submit_btn" id="search_btn">Search</button>
<button value="Search" onclick="reload()" class="submit_btn" style="display:none" id="reload_btn">Reload and Search</button>
<div class="menu">
	<a href="javascript:;" onclick="goToHome()"> <h4> Go back to Home</h4></a>
	<a href="javascript:;" onclick="goToInsert()"> <h4> Insert a Contact </h4></a>
</div>

<div id="hits"></div>
<table id="disptable">
	<tr id ="heading">
		<td>ContactID</td> <td>FName</td> <td>MName</td> <td>LName</td> <td>AddrType</td> <td>Address</td> <td>City</td> <td>State</td> <td>Zip</td> <td>PhType</td> <td>AreaCode</td> <td>Number</td> <td>DateType</td> <td>Date</td> <td>Delete</td>
	</tr>

</table>

<script type="text/javascript">
var hits=0;
var noOfRecords = 0;
function search(){
	var inputid = document.getElementById("search_field");
	
	var xhttp = new XMLHttpRequest();
	  xhttp.onreadystatechange = function() {
	    if (this.readyState == 4 && this.status == 200) {
	      var resp = this.responseText;
	      var obj = JSON.parse(resp);
	      hits = obj.hits;
	      obj = obj.resultText;
	      
	      var keys = [];
	      for(var k in obj) keys.push(k);
	      noOfRecords = keys.length;
	      
	      insRow(obj, keys);
	 	 document.getElementById("search_btn").style.display="none";
	 	 document.getElementById("reload_btn").style.display="block";
   	 	 document.getElementById("search_field").disabled=true;
   	 	 document.getElementById("hits").innerHTML="<h4>No of matches = "+hits+"</h4>";
   		 document.getElementById("hits").innerHTML+="<h4>No of records = "+noOfRecords+"</h4>";
	    }
	  };
	  xhttp.open("POST", "search", true);
	  xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	  xhttp.send("searchfor=" + inputid.value);
	
}


function insRow(obj, keys) {
    var crossMark = String.fromCharCode(10008);
    for(i=0; i<keys.length; i++){
    	var filas = document.getElementById("disptable").rows.length;
        var x = document.getElementById("disptable").insertRow(filas);
        var editIcon = String.fromCharCode(9998);
    	var cell =0;
    	
    	var a = x.insertCell(cell++);
    	a.innerHTML = keys[i];
    	
    	a.id=keys[i] + "_contactid";
    	clickid = keys[i] + "_contactid";
    	
    	a= x.insertCell(cell++);
    	a.innerHTML = obj[keys[i]].contact.fname;
    	clickid = keys[i] + "_fname";
    	a.innerHTML += "<a href='javascript:;' onclick='update(\"" +clickid + "\")' style='text-align: right;'>"+ editIcon +"</a>";
    	a.id=keys[i] + "_fname";
    	
    	a= x.insertCell(cell++);
    	a.innerHTML = obj[keys[i]].contact.mname;
    	clickid = keys[i] + "_mname";
    	a.innerHTML += "<a href='javascript:;' onclick='update(\"" +clickid + "\")' style='text-align: right;'>"+ editIcon +"</a>";
    	a.id=keys[i] + "_mname";
    	
    	a= x.insertCell(cell++);
    	a.innerHTML = obj[keys[i]].contact.lname;
    	clickid = keys[i] + "_lname";
    	a.innerHTML += "<a href='javascript:;' onclick='update(\"" +clickid + "\")' style='text-align: right;'>"+ editIcon +"</a>";
    	a.id=keys[i] + "_lname";
    	
    	//Address
    	/*a= x.insertCell(cell++);
    	var addrLength = obj[keys[i]].address.length;
    	for(j=0;j<addrLength;j++){
    		var block_to_insert = document.createElement( 'div' );
    		var id = obj[keys[i]].address[j].address_id+ "_addressid";
    		block_to_insert.setAttribute("id", id);
    		block_to_insert.style.cssText = 'border: 1px solid black';
    		block_to_insert.innerHTML = obj[keys[i]].address[j].address_id;
    		a.appendChild(block_to_insert);
    	}*/
    	
    	a= x.insertCell(cell++);
    	addrLength = obj[keys[i]].address.length;
    	for(j=0;j<addrLength;j++){
    		var block_to_insert = document.createElement( 'div' );
    		var id = obj[keys[i]].address[j].address_id+ "_addresstype";
    		block_to_insert.setAttribute("id", id);
    		block_to_insert.style.cssText = 'border: 1px solid black';
    		block_to_insert.innerHTML = obj[keys[i]].address[j].address_type;
    		block_to_insert.innerHTML += "<a href='javascript:;' onclick='update(\"" +id + "\")' style='text-align: right;'>"+ editIcon +"</a>";
    		a.appendChild(block_to_insert);
    	}
    	
    	a= x.insertCell(cell++);
    	addrLength = obj[keys[i]].address.length;
    	for(j=0;j<addrLength;j++){
    		var block_to_insert = document.createElement( 'div' );
    		var id = obj[keys[i]].address[j].address_id+ "_address";
    		block_to_insert.setAttribute("id", id);
    		block_to_insert.style.cssText = 'border: 1px solid black';
    		block_to_insert.innerHTML = obj[keys[i]].address[j].address;
    		block_to_insert.innerHTML += "<a href='javascript:;' onclick='update(\"" +id + "\")' style='text-align: right;'>"+ editIcon +"</a>";
    		a.appendChild(block_to_insert);
    	}
    	a= x.insertCell(cell++);
    	addrLength = obj[keys[i]].address.length;
    	for(j=0;j<addrLength;j++){
    		var block_to_insert = document.createElement( 'div' );
    		var id = obj[keys[i]].address[j].address_id+ "_city";
    		block_to_insert.setAttribute("id", id);
    		block_to_insert.style.cssText = 'border: 1px solid black';
    		block_to_insert.innerHTML = obj[keys[i]].address[j].city;
    		block_to_insert.innerHTML += "<a href='javascript:;' onclick='update(\"" +id + "\")' style='text-align: right;'>"+ editIcon +"</a>";
    		a.appendChild(block_to_insert);
    	}
    	a= x.insertCell(cell++);
    	addrLength = obj[keys[i]].address.length;
    	for(j=0;j<addrLength;j++){
    		var block_to_insert = document.createElement( 'div' );
    		var id = obj[keys[i]].address[j].address_id+ "_state";
    		block_to_insert.setAttribute("id", id);
    		block_to_insert.style.cssText = 'border: 1px solid black';
    		block_to_insert.innerHTML = obj[keys[i]].address[j].state;
    		block_to_insert.innerHTML += "<a href='javascript:;' onclick='update(\"" +id + "\")' style='text-align: right;'>"+ editIcon +"</a>";
    		a.appendChild(block_to_insert);
    	}
    	a= x.insertCell(cell++);
    	addrLength = obj[keys[i]].address.length;
    	for(j=0;j<addrLength;j++){
    		var block_to_insert = document.createElement( 'div' );
    		var id = obj[keys[i]].address[j].address_id+ "_zip";
    		block_to_insert.setAttribute("id", id);
    		block_to_insert.style.cssText = 'border: 1px solid black';
    		block_to_insert.innerHTML = obj[keys[i]].address[j].zip;
    		block_to_insert.innerHTML += "<a href='javascript:;' onclick='update(\"" +id + "\")' style='text-align: right;'>"+ editIcon +"</a>";
    		a.appendChild(block_to_insert);
    	}
    	
    	//Phone
    	/*a= x.insertCell(cell++);
    	addrLength = obj[keys[i]].phone.length;
    	for(j=0;j<addrLength;j++){
    		var block_to_insert = document.createElement( 'div' );
    		var id = obj[keys[i]].phone[j].phone_id+ "_phoneid";
    		block_to_insert.setAttribute("id", id);
    		block_to_insert.setAttribute("title", "Edit/Delete");
    		block_to_insert.style.cssText = 'border: 1px solid black';
    		block_to_insert.innerHTML = obj[keys[i]].phone[j].phone_id;
    		a.appendChild(block_to_insert);
    	}*/
    	a= x.insertCell(cell++);
    	addrLength = obj[keys[i]].phone.length;
    	for(j=0;j<addrLength;j++){
    		var block_to_insert = document.createElement( 'div' );
    		var id = obj[keys[i]].phone[j].phone_id+ "_phonetype";
    		block_to_insert.setAttribute("id", id);
    		block_to_insert.style.cssText = 'border: 1px solid black';
    		block_to_insert.innerHTML = obj[keys[i]].phone[j].phone_type ? obj[keys[i]].phone[j].phone_type : "N/A";
    		block_to_insert.innerHTML += "<a href='javascript:;' onclick='update(\"" +id + "\")' style='text-align: right;'>"+ editIcon +"</a>";
    		a.appendChild(block_to_insert);
    	}
    	a= x.insertCell(cell++);
    	addrLength = obj[keys[i]].phone.length;
    	for(j=0;j<addrLength;j++){
    		var block_to_insert = document.createElement( 'div' );
    		var id = obj[keys[i]].phone[j].phone_id+ "_areacode";
    		block_to_insert.setAttribute("id", id);
    		block_to_insert.style.cssText = 'border: 1px solid black';
    		block_to_insert.innerHTML = obj[keys[i]].phone[j].area_code;
    		block_to_insert.innerHTML += "<a href='javascript:;' onclick='update(\"" +id + "\")' style='text-align: right;'>"+ editIcon +"</a>";
    		a.appendChild(block_to_insert);
    	}
    	a= x.insertCell(cell++);
    	addrLength = obj[keys[i]].phone.length;
    	for(j=0;j<addrLength;j++){
    		var block_to_insert = document.createElement( 'div' );
    		var id = obj[keys[i]].phone[j].phone_id+ "_number";
    		block_to_insert.setAttribute("id", id);
    		block_to_insert.style.cssText = 'border: 1px solid black';
    		block_to_insert.innerHTML = obj[keys[i]].phone[j].number;
    		block_to_insert.innerHTML += "<a href='javascript:;' onclick='update(\"" +id + "\")' style='text-align: right;'>"+ editIcon +"</a>";
    		a.appendChild(block_to_insert);
    	}
    	
    	//Date
    	/*a= x.insertCell(cell++);
    	addrLength = obj[keys[i]].date.length;
    	for(j=0;j<addrLength;j++){
    		var block_to_insert = document.createElement( 'div' );
    		var id = obj[keys[i]].date[j].date_id+ "_dateid";
    		block_to_insert.setAttribute("id", id);
    		block_to_insert.style.cssText = 'border: 1px solid black';
    		block_to_insert.innerHTML = obj[keys[i]].date[j].date_id;
    		a.appendChild(block_to_insert);
    	} */
    	a= x.insertCell(cell++);
    	addrLength = obj[keys[i]].date.length;
    	for(j=0;j<addrLength;j++){
    		var block_to_insert = document.createElement( 'div' );
    		var id = obj[keys[i]].date[j].date_id+ "_datetype";
    		block_to_insert.setAttribute("id", id);
    		block_to_insert.style.cssText = 'border: 1px solid black';
    		block_to_insert.innerHTML = obj[keys[i]].date[j].date_type;
    		block_to_insert.innerHTML += "<a href='javascript:;' onclick='update(\"" +id + "\")' style='text-align: right;'>"+ editIcon +"</a>";
    		a.appendChild(block_to_insert);
    	}
    	a= x.insertCell(cell++);
    	addrLength = obj[keys[i]].date.length;
    	for(j=0;j<addrLength;j++){
    		var block_to_insert = document.createElement( 'div' );
    		var id = obj[keys[i]].date[j].date_id+ "_date";
    		block_to_insert.setAttribute("id", id);
    		block_to_insert.style.cssText = 'border: 1px solid black';
    		block_to_insert.innerHTML = obj[keys[i]].date[j].date;
    		block_to_insert.innerHTML += "<a href='javascript:;' onclick='update(\"" +id + "\")' style='text-align: right;'>"+ editIcon +"</a>";
    		a.appendChild(block_to_insert);
    	}
    	a= x.insertCell(cell++);
    	clickid = keys[i] + "_contactid";
    	a.id=keys[i] + "_contactid";
    	a.innerHTML = "<a href='javascript:;' onclick='del(\"" +clickid + "\")' style='text-align: right; color:red'>"+ crossMark +"</a>";;
    	
    	
    }
}

function update(id){
	console.log("t= " + id);
	var newVal;
	var promptVal = id.endsWith("_date") ? "MM/DD/YYYY" : "New Value";
	  var person = prompt("Enter New Value:", promptVal);
	  if (person == null || person == "") {
		  return;
	  } 
	  newVal = person;
	  
	  var xhttp = new XMLHttpRequest();
	  xhttp.onreadystatechange = function() {
	    if (this.readyState == 4 && this.status == 200) {
	    	 var editIcon = String.fromCharCode(9998);
	    	document.getElementById(id).innerHTML=newVal;
	    	document.getElementById(id).innerHTML += "<a href='javascript:;' onclick='update(\"" +id + "\")' style='text-align: right;'>"+ editIcon +"</a>";
	    }
	  };
	  xhttp.open("POST", "update", true);
	  xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	  xhttp.send("id=" + id + "&newVal=" + newVal);
}

function del(id){
	console.log("t= " + id);
	var xhttp = new XMLHttpRequest();
	  xhttp.onreadystatechange = function() {
	    if (this.readyState == 4 && this.status == 200) {
	    	 var crossIcon = String.fromCharCode(10008);
	    	 document.getElementById(id).innerHTML=crossIcon;
	    	 document.getElementById(id).parentElement.style="background-color:red";
	    	 //delay
			setTimeout(function() {  document.getElementById(id).parentElement.remove();}, 2200);
	    	
	    }
	  };
	  xhttp.open("POST", "delete", true);
	  xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	  xhttp.send("id=" + id);
}

function goToHome(){
	window.location.href = "index.jsp";
}

function goToInsert(){
	window.location.href = "insert.jsp";
}
 
function reload(){
	window.location.href = "search.jsp";
}


</script>
</body>
</html>