using System;
using System.Collections.Generic;
using System.Configuration; //added
using System.Data.SqlClient; //added
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data; // added 
using System.Drawing;



namespace Mayumi
{
    public partial class Home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnCheckAvailability_Click(object sender, EventArgs e)
        {
            string checkinDate = Request.Form["checkin"]; 
            string checkoutDate = Request.Form["checkout"];
            string adultNum = Request.Form["adult"];
            string childrenNum = Request.Form["children"];

            DateTime ci = DateTime.Parse(checkinDate);
            DateTime co = DateTime.Parse(checkoutDate);
            int an = int.Parse(adultNum);
            int cn = int.Parse(childrenNum);
            int nn = (co - ci).Days;
            int totalGuests = an + cn;

            if (nn <= 0)
            {
                
                return;
            }

            // the data is stored in session first before being put in the database
            Session["checkin"] = ci;
            Session["checkout"] = co;
            Session["num_adults"] = an;
            Session["num_children"] = cn;
            Session["nights"] = nn;
            Session["totalGuests"] = totalGuests;

            Response.Redirect($"RoomBooking.aspx?checkin={ci:yyyy-MM-dd}&checkout={co:yyyy-MM-dd}&guests={totalGuests}");
        }

    }
}