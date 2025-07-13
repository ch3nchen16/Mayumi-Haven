<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RoomBooking.aspx.cs" Inherits="Mayumi.RoomBooking" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Rooms Page</title>
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
                    style="width: 33%">
   
                </div>
              </div>
        </div>

        <div class="content-choose">
           <h1>
               Choose a Room
           </h1>
        </div>

       <form id="availableRooms" runat="server">
        <div class="container mt-4">
            <div class="row">
                <asp:Repeater ID="info" runat="server">
                    <ItemTemplate>
                        <div class="col-md-4 mb-4 d-flex">
                            <div class="card room-card">
                                <img class="card-img-top" src='<%# Eval("imageURL") %>' alt="Room Image">
                                <div class="card-body">
                                    <h5 class="card-title"><%# Eval("className") %></h5>
                                    <p class="card-text">Max Guests: <%# Eval("maxGuest") %></p>
                                    <p class="card-text">Price: €<%# Eval("roomPrice") %> per night</p>
                                    <asp:Button ID="btnSelectRoom" runat="server" Text="Book Now" CssClass="btn btn-primary"
                                        CommandArgument='<%# Eval("className") %>' OnClick="btnSelectRoom_Click" />                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </form>
    </body>
</asp:Content>
