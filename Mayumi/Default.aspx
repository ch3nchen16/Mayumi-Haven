<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Mayumi.Home" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    <title>Mayumi Haven Hotel Home Page</title>
    <meta name="description" content="Stay at Mayumi Haven, a luxury hotel in the heart of Dublin City with premium rooms, a restaurant and bar. Book your stay now!" />
    <meta name="keywords" content="Best hotel in Dublin, luxury hotel, hotel booking, Mayumi Haven Hotel, 4 Star Hotel">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


  <body>

    <div class="banner" id="home" >
        <video autoplay loop muted plays="inline">
            <source src="video/MayumiBackground2.mp4" type="video/mp4">
        </video>
        <div class="content">
            <h1>Book A Room</h1>
            <div>
                <button class="btn-book" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasBottom" aria-controls="offcanvasBottom">Book Now</button>
                
            </div>
          
        <%-- Off Canvas--%>

     <div class="offcanvas offcanvas-bottom" tabindex="-1" id="offcanvasBottom" aria-labelledby="offcanvasBottomLabel">
            <div class="offcanvas-body p-0">  <!--this removes extra padding -->
              
            
          </div>
        
            <%--Booking Form--%>
            <div class="booking__container">
                <form  runat="server">
                  
                    <div class="form__group">
                        <div class="input__group">
                            <input name="checkin" id="checkin" type="datetime-local" placeholder=" " min="<%= DateTime.Today.ToString("yyyy-MM-dd") %>" required >
                            <label for="checkin" >Check In</label>
                        </div>
                        <p>Add Date</p>
                    </div>
                    <div class="form__group">
                        <div class="input__group">
                            <input name="checkout" id="checkout" type="datetime-local" placeholder=" " min="<%= DateTime.Today.ToString("yyyy-MM-dd") %>" required>
                            <label for="checkout">Check Out</label>
                        </div>
                        <p>Add Date</p>
                    </div>
                    <div class="form__group">
                        <div class="input__group">
                            <input name="adult" id="adult" type="number" placeholder=" " required>
                            <label for="adult">Adults</label>
                        </div>
                        <p>Number of Adults</p>
                    </div>
                    <div class="form__group">
                        <div class="input__group">
                            <input name="children" id="children" type="number" placeholder=" " required>
                            <label for="children">Children</label>
                        </div>
                        <p>Number of Children aged 3+</p>
                    </div>
                      
                    <asp:Button ID="btnCheckAvailability" runat="server" Text="Check Availability" CssClass="btn-primary" OnClick="btnCheckAvailability_Click" /> 
                    <%--<button type="submit" onclick="btnCheckAvailability_Click" class="btnCheckAvailability">Check Availability <i class="fa-solid fa-magnifying-glass"></i></button> --%>
                      
                </form>
                
                <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
            </div>
           </div>
            <%--Booking Form--%>

        
        
        </div>
    </div>

      <section id="services">Services</section>
      <section id="about">About</section>
      
</body>

</asp:Content>
