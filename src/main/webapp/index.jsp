<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<title>DX Bank</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="resources/jquery.redirect.min.js"></script>
<script>
jQuery(function($){

$(document).ready(function(){
	$(document).on("click", "#registerId", function(){
		var credentials = {
				email: $("#email").val(),
				nickname: $("#nickname").val(),
				psw: $("#psw").val()
		}
		$.post("RegisterServlet", $.param(credentials),function(response){
			if (response == "registered"){
				
				$.redirect("loggedIn.jsp", {'emailId': $("#email").val()});
			}
			else
				$("#alreadyRegisterdId").text("This email is already registered.");
		});
	});
	
	
	$(document).on("click", "#loginId", function(){
		var credentials = {
				email: $("#emailLogin").val(),
				psw: $("#pswLogin").val()
		}
		$.post("LoginServlet", $.param(credentials),function(response){
			if (response == "authenticated"){
				$.redirect("loggedIn.jsp", {'emailId': $("#emailLogin").val()});
			}
			else if(response == "badPassword")
				$("#wrongPassword").text("Bad Password.");
			else
				$("#wrongPassword").text("Email is not registered.");
		});
	});
	
});

});
	
</script>
</head>

<style>
/* Full-width input fields */
input[type=text], input[type=password] {
	width: 100%;
	padding: 12px 20px;
	margin: 8px 0;
	display: inline-block;
	border: 1px solid #ccc;
	box-sizing: border-box;
}

/* Set a style for all buttons */
button {
	background-color: #4CAF50;
	color: white;
	padding: 14px 20px;
	margin: 8px 0;
	border: none;
	cursor: pointer;
	width: 100%;
}

button:hover {
	opacity: 0.8;
}

/* Extra styles for the cancel button */
.cancelbtn {
	width: auto;
	padding: 10px 18px;
	background-color: #f44336;
}

/* Center the image and position the close button */
.imgcontainer {
	text-align: center;
	margin: 24px 0 12px 0;
	position: relative;
}

img.avatar {
	width: 40%;
	border-radius: 50%;
}

.container {
	padding: 16px;
}

span.psw {
	float: right;
	padding-top: 16px;
}

/* The Modal (background) */
.modal {
	display: none; /* Hidden by default */
	position: fixed; /* Stay in place */
	z-index: 1; /* Sit on top */
	left: 0;
	top: 0;
	width: 100%; /* Full width */
	height: 100%; /* Full height */
	overflow: auto; /* Enable scroll if needed */
	background-color: rgb(0, 0, 0); /* Fallback color */
	background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
	padding-top: 60px;
}

/* Modal Content/Box */
.modal-content {
	background-color: #fefefe;
	margin: 5% auto 15% auto;
	/* 5% from the top, 15% from the bottom and centered */
	border: 1px solid #888;
	width: 50%; /* Could be more or less, depending on screen size */
}

/* The Close Button (x) */
.close {
	position: absolute;
	right: 25px;
	top: 0;
	color: #000;
	font-size: 35px;
	font-weight: bold;
}

.close:hover, .close:focus {
	color: red;
	cursor: pointer;
}

/* Add Zoom Animation */
.animate {
	-webkit-animation: animatezoom 0.6s;
	animation: animatezoom 0.6s
}

@
-webkit-keyframes animatezoom {
	from {-webkit-transform: scale(0)
}

to {
	-webkit-transform: scale(1)
}

}
@
keyframes animatezoom {
	from {transform: scale(0)
}

to {
	transform: scale(1)
}

}

/* Change styles for span and cancel button on extra small screens */
@media screen and (max-width: 300px) {
	span.psw {
		display: block;
		float: none;
	}
	.cancelbtn {
		width: 100%;
	}
}
</style>

<body class="w3-content" style="max-width: 1300px">

<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setHeader("Expires", "0");
%>
	<!-- Top-->
	<div class="w3-row" id="main">
		<div class="w3-white w3-card w3-center" style="height: 700px">
			<div class="w3-padding-32">
				<h1 class="w3-teal w3-card">DX Bank</h1>
			</div>
			<div class="w3-padding-32"></div>
			<img src="resources/growth.png" class="w3-margin-bottom w3-circle"
				alt="DX-Bank" style="width: 10%"> <br> <br>
			<div class="w3-margin-top">
				<a
					class="w3-btn w3-teal w3-padding-large w3-large w3-margin-top w3-round"
					onClick="document.getElementById('id01').style.display='block'"
					style="width: auto;">Sign In</a> <a
					class="w3-btn w3-teal w3-padding-large w3-large w3-margin-top w3-round"
					onClick="document.getElementById('id02').style.display='block'"
					style="width: auto;">Register</a>
			</div>
			<p
				style="font-size: 64px; font-family: serif; font-style: italic; color: grey">
				<span style="font-size: 70px">"</span>Sometimes all you need is a
				billion dollars!
			</p>
		</div>
	</div>

	<!-- Middle -->
	<div class="w3-row">
		<div class="w3-half w3-teal w3-center" style="min-height: 100px"
			id="work">
			<div class="w3-padding-16">
				<h2>Communication Catalog</h2>
				<br>
				<p>How do you want us to contact you?</p>
			</div>
		</div>
		<div class="w3-half w3-indigo w3-container" style="min-height: 100px">
			<div class="w3-padding-16 w3-center">
				<h2>Communication Preferences</h2>
				<br>
				<p>When do you want us to contact you?</p>
			</div>
		</div>
	</div>
	<div id="id01" class="modal">

		<form class="modal-content animate" action="/action_page.php">
			<div class="imgcontainer">
				<span onclick="document.getElementById('id01').style.display='none'"
					class="close" title="Close Modal">&times;</span> <img
					src="resources/growth.png" alt="Avatar" style="width: 20%">
			</div>

			<div class="container">
			<p id="wrongPassword" class="w3-red"></p>
				<label><b>Username</b></label> <input type="text"
					placeholder="Enter Email Id" id="emailLogin" required> <label><b>Password</b></label>
				<input type="password" placeholder="Enter Password" id="pswLogin"
					required>

				<button
					class="w3-btn w3-teal w3-padding-large w3-large w3-margin-top w3-round"
					type="button" id="loginId">Login</button>
			</div>

			<div class="container" style="background-color: #f1f1f1">
				<button type="button"
					onclick="document.getElementById('id01').style.display='none'"
					class="cancelbtn">Cancel</button>
				<span class="psw"><a href="#">Forgot password</a>?</span>
			</div>
		</form>
	</div>

	<div id="id02" class="modal">
		<span onclick="document.getElementById('id02').style.display='none'"
			class="close" title="Close Modal">&times;</span>
		<form class="modal-content animate">
			<div class="container">
				<h1>Sign Up</h1>
				<p>Please fill in this form to create an account.</p>
				<p id="alreadyRegisterdId" class="w3-red"></p>
				<hr>
				<label><b>Nick Name</b></label> 
				<input type="text" placeholder="Enter Nick Name" id="nickname" required> 
				<label><b>Email</b></label>
				<input type="text" placeholder="Enter Email" id="email" required>
				<label><b>Password</b></label>
				<input type="password" placeholder="Enter Password" id="psw" required> 
				<label><b>Repeat Password</b></label>
				<input type="password" placeholder="Repeat Password" name="psw-repeat" required>
				<button type="button" id="registerId" class="w3-btn w3-teal w3-padding-large w3-large w3-margin-top w3-round">Sign Up</button>
			</div>
			<div class="container" style="background-color: #f1f1f1">
				<button type="button"
					onclick="document.getElementById('id02').style.display='none'"
					class="cancelbtn">Cancel</button>
				<span class="psw"><a href="#main" onClick="">Already
						Registerd</a>?</span>
			</div>
		</form>
		
	</div>

	<script>
		// Get the modal
		var modal1 = document.getElementById('id01');
		var modal2 = document.getElementById('id02');
		// When the user clicks anywhere outside of the modal, close it
		window.onclick = function(event) {
			if (event.target == modal1) {
				modal1.style.display = "none";
			}
			if (event.target == modal2) {
				modal2.style.display = "none";
			}
		}
	</script>
</body>
</html>
