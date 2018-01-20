<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<title>DX Bank</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script>
$(document).ready(function(){

    		$.post("OnLoadServlet",function(responseJson){
    			$("#balanceId").text("Welcom "+responseJson.name+"! Your account balance is: €"+responseJson.balance);
    			if (responseJson.pushPreference == "true")
    				$("#pushPrefId").prop('checked',true);
    			if (responseJson.emailPreference == "true")
    				$("#emailPrefId").prop('checked',true);
    			if (responseJson.smsPreference == "true")
    				$("#smsPrefId").prop('checked',true);
    			
    		});
    		
    		$(":checkbox").change(function(){
    			var preferences = {
    					pushRequest: $("#pushPrefId").is(":checked"),
    					smsRequest: $("#smsPrefId").is(":checked"),
    					emailRequest: $("#emailPrefId").is(":checked"),
    			}
    			$.post("ChannelPrefChangeServlet", $.param(preferences), function(response){
        			
        		});
    		});
    		
});
</script>
</head>

<!--Styles for Toggle-->
<style>
.switch {
	position: relative;
	display: inline-block;
	width: 60px;
	height: 34px;
}

.switch input {
	display: none;
}

.slider {
	position: absolute;
	cursor: pointer;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background-color: #ccc;
	-webkit-transition: .4s;
	transition: .4s;
}

.slider:before {
	position: absolute;
	content: "";
	height: 26px;
	width: 26px;
	left: 4px;
	bottom: 4px;
	background-color: teal;
	-webkit-transition: .4s;
	transition: .4s;
}

input:checked+.slider {
	background-color: white;
}

input:focus+.slider {
	box-shadow: 0 0 1px #2196F3;
}

input:checked+.slider:before {
	-webkit-transform: translateX(26px);
	-ms-transform: translateX(26px);
	transform: translateX(26px);
}

/* Rounded sliders */
.slider.round {
	border-radius: 34px;
}

.slider.round:before {
	border-radius: 50%;
}
</style>

<body class="w3-content" style="max-width: 1300px">
	<!-- Top-->
	<div class="w3-row">
		<div class="w3-light-grey w3-card w3-center" style="height: 700px">
			<div class="w3-padding-32">
				<h1 class="w3-teal w3-card">DX Bank</h1>
			</div>
			<div class="w3-row">
				<h3 id="balanceId"></h3>
			</div>
			<img src="resources/growth.png" class="w3-margin w3-circle"
				alt="DX-Bank" style="width: 10%">
			<div class="w3-padding-32">
				<a href="#"
					class="w3-button w3-light-grey w3-block w3-hover-blue-grey w3-padding-16">Home</a>
				<a href="#work"
					class="w3-button w3-light-grey w3-block w3-hover-indigo w3-padding-16">Communication
					Catalog</a> <a href="#work"
					class="w3-button w3-light-grey w3-block w3-hover-dark-grey w3-padding-16">Communication
					Preferences</a> <a href="#contact"
					class="w3-button w3-light-grey w3-block w3-hover-brown w3-padding-16">Shop
					Now!</a>
			</div>
		</div>
	</div>

	<!-- Middle -->
	<div class="w3-row">
		<div class="w3-half w3-teal w3-center" style="min-height: 800px" id="work">
			<div class="w3-padding-32">
				<h2>Communication Catalog</h2>
				<p>How do you want us to contact you?</p>
			</div>
			
			<div>
			<div class="w3-left w3-half" style="padding-left:150px; padding-top:75px">
			<h4 class="w3-left">Push Notifications</h4>
			</div>
			<div class="w3-right w3-half" style="padding-right:150px; padding-top:80px">
			<label class="switch w3-padding-16"> 
				<input type="checkbox" name="pushPreference" id="pushPrefId">
				<span class="slider round"></span>
			</label>
			</div>
			</div>
			
			<div class="w3-row">
			<div class="w3-left w3-half" style="padding-left:150px; padding-top:25px">
			<h4 class="w3-left">E-mail</h4>
			</div>
			<div class="w3-right w3-half" style="padding-right:150px; padding-top:30px">
			<label class="switch w3-padding-16"> 
				<input type="checkbox" name="emailPreference" id="emailPrefId">
				<span class="slider round"></span>
			</label>
			</div>
			</div>
			
			<div class="w3-row">
			<div class="w3-left w3-half" style="padding-left:150px; padding-top:25px">
			<h4 class="w3-left">SMS</h4>
			</div>
			<div class="w3-right w3-half" style="padding-right:150px; padding-top:30px">
			<label class="switch w3-padding-16"> 
				<input type="checkbox" name="smsPreference" id="smsPrefId">
				<span class="slider round"></span>
			</label>
			</div>
			</div>
			
		</div>
		<div class="w3-half w3-indigo w3-container" style="min-height: 800px">
			<div class="w3-padding-32 w3-center">
				<h2>Communication Preferences</h2>
				<p>When do you want us to contact you?</p>
				<div class="w3-container w3-responsive">
					
				</div>
			</div>
		</div>
	</div>

	<!-- Bottom -->
	<div class="w3-card w3-dark-grey" id="contact">
		<div class="w3-white w3-container w3-center"	style="height: 700px">
			<div class="w3-padding-64">
				<h1>Shop Now!</h1>
			</div>
			
		</div>
	</div>

	<!-- Footer -->
	<footer class="w3-container w3-black w3-padding-16">
		<p>
			Powered by <a href="https://www.w3schools.com/w3css/default.asp"
				target="_blank">w3.css</a>
		</p>
	</footer>

</body>
</html>
