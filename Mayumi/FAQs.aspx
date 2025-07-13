<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FAQs.aspx.cs" Inherits="Mayumi.FAQs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>FAQs Page</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <body>
         <h1>FAQ</h1>
         <p>
             <br />
         </p>
        <div class="faq">
            <h1>Frequently Asked Questions</h1>
            <div id="accordion">
		                    <h4 class="question">What is the cancellation policy?</h4>
         		            <p class="answer">A guest can cancel free of charge 48 hours in advance of arrival by 15:30 local time with no charge.</p>
         	
           		            <h4 class="question">Credit Card Policy:</h4>
         		            <p class="answer">A valid credit card is required at check-in for additional charges and as a security deposit for the room. Pre-authorization will be processed and released after check-out, depending on your bank’s policies.</p>
             
             	            <h4 class="question">What time is check in & check out?</h4>
             	            <p class="answer">Check in is from 15.30 pm & check out is 12 noon local time.</p>

                            <h4 class="question">Can I store luggage?</h4>
                            <p class="answer">Yes, we can store your luggage for you, free of charge at our main reception desk.</p>

                            <h4 class="question">Do you have disabled access rooms?</h4>
                            <p class="answer">We have one wheelchair accessible room, grab rails in the bathroom, walk in shower.</p>
             
  
 	        </div>
        </div>

    </body>
</asp:Content>
