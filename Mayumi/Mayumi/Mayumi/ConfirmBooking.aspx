<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ConfirmBooking.aspx.cs" Inherits="Mayumi.Book" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Booking Confirmation Page</title>
    <meta name="description" content="" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


  <body>
	 <div class="container mt-5">
           <div class="progress">
             <div class="progress-bar progress-bar-striped progress-bar-animated"
                  role="progressbar" 
                 aria-valuenow="75" 
                 aria-valuemin="0" 
                 aria-valuemax="100" 
                 style="width: 100%">

             </div>
           </div>
     </div>
	<div class="content-choose">
	  <h1>Confirm Your Booking</h1>
	</div>
      <div id="form-container">	
		<!-- Registration Form -->
		
			<form id="confirmationForm" runat="server">
			<!-- Registration Form -->
		<div class="top-row">
			
				<div id="regForm">
					<h2>Registration Form</h2>
					<br/>
					<div class="input-group">
						<label>Firstname</label>
						<asp:TextBox ID="txtFn" runat="server" />
					</div>
					<div class="input-group">
						<label>Surname</label>
						<asp:TextBox ID="txtSn" runat="server" />
					</div>
					<div class="input-group">
						<label>Email</label>
						<asp:TextBox ID="txtRegEmail" runat="server" TextMode="Email" />
					</div>
					<div class="input-group">
						<label>Phone</label>
						<asp:TextBox ID="txtPhone" runat="server" TextMode="Phone"/>
					</div>
					<div class="input-group">
						<label>Password</label>
						<asp:TextBox ID="txtPassword1" runat="server" TextMode="Password" />
					</div>
					<div class="input-group">
						<label>Confirm password</label>
						<asp:TextBox ID="txtPassword2" runat="server" TextMode="Password" />
					</div>

					<asp:Button ID="btnRegister" runat="server" Text="Register Now" OnClick="btnRegister_Click" CssClass="btn-primary" />
					<!-- Button to diplay Login Form -->
					<button id="btnDisplayLogin" type="button" class="btn-primary" onclick="displayLogin()"> Already have an account? Login </button>
					<!-- Button to diplay Login Form -->			
		  		</div>	
					
				<!-- Log in Form -->
							
				<div id="loginForm" style='display:none;'>
								  
					<h2>Login Form</h2>
						<div class="input-group">
							<label>Email</label>
							<asp:TextBox ID="txtLoginEmail" runat="server" TextMode="Email" />
						</div>
						<div class="input-group">
							<label>Password</label>
							<asp:TextBox ID="txtLoginPassword" runat="server" TextMode="Password"  />
						</div>

						<asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" CssClass="btn-primary" />
						<!-- Button to diplay Register Form -->
						<button id="btnDisplayRegister" type="button" class="btn-primary" onclick="displayRegister()">Back to Register</button>
				</div>
			
				<!-- Display labels -->
		
				<div id="table-total">
					<h2>Total:</h2> 
				
					<asp:Label ID="lblFeaturePrice" runat="server" Text=""></asp:Label><br /><br />
					<asp:Label ID="lblRoomPrice" runat="server" Text=""></asp:Label><br /><br />
					<asp:Label ID="lblTotalBookingPrice" runat="server" Text=""></asp:Label><br /><br />
				</div>
			
			</div>

				<!-- Transaction Form -->
			<div class="bottom-row">
				<div id="tm">
					<h2>Transaction Details</h2>
					<div class="input-group">
						<label>Card Number</label>
						<input type="text" name="card" id="card" maxlength="19" placeholder="Ex: 0123456789101112"/>
						</div>
				
						<div class="input-group">
							<label>CVV</label>
							<input type="text" name="cvv" id="cvv" maxlength="4" placeholder="Ex: 012" /> <!-- Most cards have a 3 digit cvv but 
							American Express has 4 (CID)	-->
						</div>
				
						<div class="input-group">
							<label>Expiry Date</label>
							<input type="text" name="expiryDate" id="expiryDate" placeholder="MM/YY" maxlength="5"/>
						</div>
	
						<asp:Button ID="btnConfirmBooking" runat="server" Text="Confirm" CssClass="btnConfirmBooking" OnClick="btnConfirmBooking_Click" /> 
				</div>
			<div/>
		</div>
		


				

		 
			
			</form>
		</div>
 
</body>

</asp:Content>

