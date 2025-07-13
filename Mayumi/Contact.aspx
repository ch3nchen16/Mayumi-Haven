<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="Mayumi.Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Contact Page</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <body>
    <div id="form-container">
        <form method="post" runat="server">
            <div class="top-row">
                <div id="contactForm">
                    <h1>Contact Us</h1>
                    <br/>
                    <div class="input-group">
                        <label>Name</label>
                        <asp:TextBox ID="txtName" runat="server" required="true" CssClass="input"></asp:TextBox>
                    </div>

                    <div class="input-group">
                        <label>Email</label>
                        <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" required="true" CssClass="input"></asp:TextBox>
                    </div>

                    <div class="input-group">
                        <label>Subject</label>
                        <asp:TextBox ID="txtSubject" runat="server" required="true" CssClass="input"></asp:TextBox>
                    </div>

                    <div class="input-group">
                        <label>Message</label>
                        <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" required="true" CssClass="input"></asp:TextBox>
                    </div>

                    <div>
                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" CssClass="btn-primary" />
                    </div>
                </div>
            </div>
        </form>
    </div>

    </body>
</asp:Content>
