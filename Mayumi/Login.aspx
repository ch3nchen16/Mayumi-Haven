<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Mayumi.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
	<title>Login Page</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <body>
		<div id="form-container">	
			<form runat="server">
				<div class="top-row">
					<div id="loginPageForm">
							  
						<h1>Login Form</h1>
						<br/>
							<div class="input-group">
								<label>Email</label>
								<asp:TextBox ID="txtLoginEmail" runat="server" TextMode="Email" />
							</div>
							<div class="input-group">
								<label>Password</label>
								<asp:TextBox ID="txtLoginPassword" runat="server" TextMode="Password" />
							</div>

							<asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" CssClass="btn-primary" />
					</div>
				</div>
			</form>
		</div>
    </body>
</asp:Content>
