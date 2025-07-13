<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Account.aspx.cs" Inherits="Mayumi.Account" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Account Page</title>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <body>
        <div class="container">
        <form runat="server">
        <!-- Previous Bookings -->
        <h2>Your Bookings</h2>
        <div class="dgv">
            <asp:GridView ID="gvBookings" runat="server" CssClass="table table-striped" AutoGenerateColumns="False" >
                <Columns>
                    <asp:BoundField DataField="bookId" HeaderText="Booking ID" SortExpression="bookId" />
                    <asp:BoundField DataField="checkIn" HeaderText="Check-in Date" SortExpression="checkIn" />
                    <asp:BoundField DataField="checkOut" HeaderText="Check-out Date" SortExpression="checkOut" />
                    <asp:BoundField DataField="className" HeaderText="Room Type" SortExpression="className" />
                    <asp:BoundField DataField="totalPrice" HeaderText="Total Price" SortExpression="totalPrice" />
                </Columns>
            </asp:GridView>
        </div>

        <div class="account-details">
           <h2>Edit Your Account Details</h2>
            <br/>
        <!-- Member Details -->
       
            <div class="row mb-3">
                <label class="col-sm-2">First Name:</label>
                <div class="col-sm-6">
                    <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-2">Last Name:</label>
                <div class="col-sm-6">
                    <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-2">Email:</label>
                <div class="col-sm-6">
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    <!--ReadOnly email so that it cant be changed -->
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-2">Phone:</label>
                <div class="col-sm-6">
                    <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-sm-6 offset-sm-2">
                    <asp:Button ID="btnSave" runat="server" Text="Save Changes" OnClick="btnSave_Click" CssClass="btn btn-primary" />
                </div>
            </div>
        </div>
        </form>

    </div>

    </body>
</asp:Content>
