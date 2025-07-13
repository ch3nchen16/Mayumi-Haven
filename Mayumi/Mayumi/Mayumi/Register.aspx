<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Mayumi.Register" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
	<title>Registration Page</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <body>
		<div class="form-container">
			<form runat="server">
				<div class="top-row">
					<div id="regPageForm">
							<h1>Registration Form</h1>
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
								
					</div>
				</div>
			</form>
		</div>
    </body>
</asp:Content>
