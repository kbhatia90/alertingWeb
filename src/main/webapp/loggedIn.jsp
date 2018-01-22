<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

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
		
		var emailIdFromIndex = {
				emailId: $("#emailIDCaptured").text()
		}
    		$.post("OnLoadServlet",$.param(emailIdFromIndex),function(responseJson){
    			$("#nameId").text("Welcom "+responseJson.name+"!");
    			$("#balanceId").text("Your account balance is: €"+responseJson.balance);
    			if (responseJson.pushPreference == "true")
    				$("#pushPrefId").prop('checked',true);
    			if (responseJson.emailPreference == "true")
    				$("#emailPrefId").prop('checked',true);
    			if (responseJson.smsPreference == "true")
    				$("#smsPrefId").prop('checked',true);
    			if (responseJson.allTransactionsCheck == "true")
    				$("#allTransactionsId").prop('checked',true);
    			if (responseJson.lowerLimitCheck == "true")
    				$("#balanceCheckId").prop('checked',true);
    			if (responseJson.transactionAmountCheck == "true")
    				$("#transactionCheckId").prop('checked',true);
    			$("#lowerLimitId").val(responseJson.lowerLimit);
    			$("#transactionLimitId").val(responseJson.transactionAmountLimit);
    			
    			
    		});
    		
    		$(":checkbox").change(function(){
    			var preferences = {
    					pushRequest: $("#pushPrefId").is(":checked"),
    					smsRequest: $("#smsPrefId").is(":checked"),
    					emailRequest: $("#emailPrefId").is(":checked"),
    					allTransactionsCheck: $("#allTransactionsId").is(":checked"),
    					lowerLimitCheck: $("#balanceCheckId").is(":checked"),
    					lowerLimit: $("#lowerLimitId").val(),
    					transactionAmountCheck: $("#transactionCheckId").is(":checked"),
    					transactionAmountLimit: $("#transactionLimitId").val(),
    					emailId: $("#emailIDCaptured").text()
    			}
    			$.post("ChannelPrefChangeServlet", $.param(preferences), function(response){
        			
        		});
    		});
    		
    		$(document).on("click", "#logoutId", function(){
    			$("#emailIDCaptured").html(null);
    		});
    		
    		$(document).on("click", "#purchaseBitcoinId", function(){
    			var details = {
    					emailId: $("#emailIDCaptured").text(),
    					debitAmount: 100,
    					type: "debit"
    			}
			$.post("RuleEngineServlet", $.param(details), function(response){
				
        			if(response == "notifyDebitAmount"){
        				alert("Your account is debited with €100");
        			}
        			else if(response == "notifyLowerLimit"){
        				alert("Your account balance is less than "+ $("#lowerLimitId").val());
        			}
        			else if(response == "notifyBigAmount"){
        				alert("Your have made a purchase greater than "+ $("#transactionLimitId").val());
        			}
        			else if(response == "insufficient"){
        				alert("insufficient funds");
        			}
        			location.reload();
        		});
    			
    		});
    		
    		$(document).on("click", "#addMoney", function(){
    			var details = {
    					emailId: $("#emailIDCaptured").text(),
    					creditAmount: 1000,
    					type: "credit"
    			}
			$.post("RuleEngineServlet", $.param(details), function(response){
				location.reload();
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
<%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Expires", "0");
	if(null == request.getParameter("emailId"))
	{%>
		<jsp:forward page="index.jsp"/>
	<%} 
%>

	<!-- Top-->
	<div id="emailIDCaptured" class="w3-hide"><%String _emailId = request.getParameter("emailId");out.print(_emailId);%></div>
	
	<div class="w3-row">
		<div class="w3-light-grey w3-card w3-center" style="height: 700px">
		<a href="index.jsp" class="w3-button w3-right w3-padding-8" id="logoutId">Logout</a>
			<div class="w3-padding-32">
				<h1 class="w3-teal w3-card">DX Bank</h1>
			</div>
			<div class="w3-row">
				<h3 id="nameId"></h3>
				<h3 id="balanceId"></h3>
			</div>
			<img src="resources/growth.png" class="w3-margin w3-circle"
				alt="DX-Bank" style="width: 10%">
			<div class="w3-padding-32">
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
			<div class="w3-left w3-half" style="padding-left:150px; padding-top:120px">
			<h4 class="w3-left">Push Notifications</h4>
			</div>
			<div class="w3-right w3-half" style="padding-right:150px; padding-top:130px">
			<label class="switch w3-padding-16"> 
				<input type="checkbox" name="pushPreference" id="pushPrefId">
				<span class="slider round"></span>
			</label>
			</div>
			</div>
			
			<hr>
			
			<div class="w3-row w3-padding-8"></div>
			<div class="w3-row w3-padding-32"></div>
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
			
			<div class="w3-row w3-padding-32"></div>
			
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
		<div class="w3-half w3-indigo w3-center" style="min-height: 800px">
			<div class="w3-padding-32">
				<h2>Communication Preferences</h2>
				<p>When do you want us to contact you?</p>
			</div>
			
			<div>
			<div class="w3-left w3-half" style="padding-left:60px; padding-top:120px">
			<h4 class="w3-left">On All Transactions</h4>
			</div>
			<div class="w3-right w3-half" style="padding-top:130px">
			<label class="switch w3-padding-16"> 
				<input type="checkbox" name="allTransactions" id="allTransactionsId">
				<span class="slider round"></span>
			</label>
			</div>
			</div>
			<hr>
			<div class="w3-row w3-padding-32"></div>
			
			<div class="w3-row">
			<div class="w3-left w3-half" style="padding-left:60px; padding-top:25px">
			<h4 class="w3-left">When Balance drops below €</h4>
			<input id="lowerLimitId" class="w3-input w3-border" type="text" style="width:30%">
			</div>
			<div class="w3-right w3-half" style="padding-top:30px">
			<label class="switch w3-padding-16"> 
				<input type="checkbox" name="balanceCheck" id="balanceCheckId">
				<span class="slider round"></span>
			</label>
			</div>
			</div>
			
			<div class="w3-row w3-padding-16"></div>
			
			<div class="w3-row">
			<div class="w3-left w3-half" style="padding-left:60px; padding-top:25px">
			<h4 class="w3-left">Transaction amount &gt; €</h4>
			<input id="transactionLimitId" class="w3-input w3-border" type="text" style="width:30%">
			</div>
			<div class="w3-right w3-half" style="padding-top:30px">
			<label class="switch w3-padding-16"> 
				<input type="checkbox" name="transactionCheck" id="transactionCheckId">
				<span class="slider round"></span>
			</label>
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
			<button type="button" id="purchaseBitcoinId" class="w3-btn w3-teal w3-padding-large w3-large w3-margin-top w3-round">€ 100</button>
			<button type="button" id="addMoney" class="w3-btn w3-teal w3-padding-large w3-large w3-margin-top w3-round">Add Money</button>
			
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
