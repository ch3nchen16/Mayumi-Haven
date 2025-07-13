using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI;

namespace Mayumi
{
    public partial class Book : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                DateTime checkin = (DateTime)Session["checkin"];
                DateTime checkout = (DateTime)Session["checkout"];
                int nights = (checkout - checkin).Days;
                decimal roomPrice = Convert.ToDecimal(Session["roomPrice"]);
                decimal totalRoomPrice = roomPrice * nights;
                decimal totalFeaturePrice = Convert.ToDecimal(Session["totalFeaturePrice"]);
                decimal totalBookingPrice = totalRoomPrice + totalFeaturePrice;

                //displays prices
                lblFeaturePrice.Text = $"Total Feature Price: €{totalFeaturePrice:F2}";
                lblRoomPrice.Text = $"Total Room Price: €{totalRoomPrice:F2}";
                lblTotalBookingPrice.Text = $"Total Booking Price: €{totalBookingPrice:F2}";
            }
        }
        //to encrypt the password
        public static string ComputeMD5Hash(string input)
        {
            using (System.Security.Cryptography.MD5 md5 = System.Security.Cryptography.MD5.Create())
            {
                byte[] inputBytes = System.Text.Encoding.ASCII.GetBytes(input);
                byte[] hashBytes = md5.ComputeHash(inputBytes);

                // Convert byte array to hex string
                StringBuilder sb = new StringBuilder();
                foreach (byte b in hashBytes)
                {
                    sb.Append(b.ToString("x2"));
                }
                return sb.ToString();
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string firstName = txtFn.Text.Trim();
            string lastName = txtSn.Text.Trim();
            string email = txtRegEmail.Text.Trim();
            string phone = txtPhone.Text.Trim();
            string password = txtPassword1.Text.Trim();
            string confirmPassword = txtPassword2.Text.Trim();

            string hashedPassword = ComputeMD5Hash(password);

            //this checks whether the passwords match
            if (password != confirmPassword)
            {
                Response.Write("<script>alert('Passwords do not match.');</script>");
                return;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["DBCon"].ConnectionString;

            //to check if there is already a member with the same email
            string emailCheckQuery = "SELECT COUNT(*) FROM Member WHERE email = @email";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand emailCheckCmd = new SqlCommand(emailCheckQuery, con);
                emailCheckCmd.Parameters.AddWithValue("@email", email);

                con.Open();

                int emailExists = (int)emailCheckCmd.ExecuteScalar();

                //if email already exists
                if (emailExists > 0)
                {
                    Response.Write("<script>alert('Email already exists. Please use a different email.');</script>");
                    return;
                }

                //If email doesn't exist it will insert the member details to the Member table
                string memberQuery = "INSERT INTO Member (fn, sn, email, password, phone) VALUES (@fn, @sn, @email, @password, @phone)";

                SqlCommand cmd = new SqlCommand(memberQuery, con);
                cmd.Parameters.AddWithValue("@fn", firstName);
                cmd.Parameters.AddWithValue("@sn", lastName);
                cmd.Parameters.AddWithValue("@email", email);
                cmd.Parameters.AddWithValue("@password", hashedPassword);
                cmd.Parameters.AddWithValue("@phone", phone);

                cmd.ExecuteNonQuery();
                Session["email"] = email;
                con.Close();
            }
        }



        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtLoginEmail.Text.Trim();
            string password = txtLoginPassword.Text.Trim();
            string hashedPassword = ComputeMD5Hash(password);

            string connectionString = ConfigurationManager.ConnectionStrings["DBCon"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                //thie checks whether email and password matches with an existing email and password in the member table
                string query = "SELECT COUNT(*) FROM Member WHERE email = @email AND password = @password";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@email", email);
                cmd.Parameters.AddWithValue("@password", hashedPassword);

                con.Open();
                int userExists = (int)cmd.ExecuteScalar();

                //if the user exists
                if (userExists > 0)
                {
                    Session["email"] = email;

                }
                //if the password is wrong or user doesnt exist
                else
                {
                    Response.Write("<script>alert('Invalid email or password');</script>");
                }

                con.Close();
            }
        }

        protected void btnConfirmBooking_Click(object sender, EventArgs e)
        {
            if (Session["email"] == null)
            {
                Response.Write("<script>alert('You must log in or register');</script>");
                return;
            }
            string email = txtRegEmail.Text;
            string password = txtPassword1.Text; 
            string phone = txtPhone.Text; 
            string fn = txtFn.Text; 
            string sn = txtSn.Text; 

            DateTime checkin = (DateTime)Session["checkin"];
            DateTime checkout = (DateTime)Session["checkout"];
            int adultNum = (int)Session["num_adults"];
            int children = (int)Session["num_children"];
            int nights = (int)Session["nights"];
            int totalGuests = (int)Session["totalGuests"];
            decimal roomPrice = Convert.ToDecimal(Session["roomPrice"]);
            decimal totalFeaturePrice = Convert.ToDecimal(Session["totalFeaturePrice"]);
            decimal totalBookingPrice = roomPrice + totalFeaturePrice;

            int roomId = (int)Session["roomId"];  

            string connectionString = ConfigurationManager.ConnectionStrings["DBCon"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                int memId = 0;

                //if the user is logged in
                if (Session["email"] != null)
                {
                    //gets the memId for the logged-in user
                    string getMemIdQuery = "SELECT memId FROM Member WHERE email = @email";
                    SqlCommand getMemIdCmd = new SqlCommand(getMemIdQuery, con);
                    getMemIdCmd.Parameters.AddWithValue("@email", Session["email"].ToString());
                    memId = (int)getMemIdCmd.ExecuteScalar();
                    
                }
                else
                {
                    string hashedPassword = ComputeMD5Hash(password);
                    //If they are not logged in and they are registering, this inserts the member and gets the memId
                    string memberQuery = "INSERT INTO Member (fn, sn, email, password, phone) VALUES (@fn, @sn, @email, @password, @phone); " +
                                         "SELECT SCOPE_IDENTITY();";
                    SqlCommand memberCmd = new SqlCommand(memberQuery, con);
                    memberCmd.Parameters.AddWithValue("@fn", fn);
                    memberCmd.Parameters.AddWithValue("@sn", sn);
                    memberCmd.Parameters.AddWithValue("@email", email);
                    memberCmd.Parameters.AddWithValue("@password", hashedPassword);  
                    memberCmd.Parameters.AddWithValue("@phone", phone);
                    
                    //this gets the memId of the new member
                    memId = Convert.ToInt32(memberCmd.ExecuteScalar());
                    
                    
                }

                //Insert the booking details into the Booking table
                string bookQuery = "INSERT INTO Booking (memId, checkIn, checkOut, num_adults, num_children, totalGuests, nights, totalPrice) " +
                                   "VALUES (@memId, @checkin, @checkout, @adultNum, @children, @totalGuests, @nights, @totalPrice)";
                SqlCommand bookCmd = new SqlCommand(bookQuery, con);
                bookCmd.Parameters.AddWithValue("@memId", memId);
                bookCmd.Parameters.AddWithValue("@checkin", checkin);
                bookCmd.Parameters.AddWithValue("@checkout", checkout);
                bookCmd.Parameters.AddWithValue("@adultNum", adultNum);
                bookCmd.Parameters.AddWithValue("@children", children);
                bookCmd.Parameters.AddWithValue("@totalGuests", totalGuests);
                bookCmd.Parameters.AddWithValue("@nights", nights);
                bookCmd.Parameters.AddWithValue("@totalPrice", totalBookingPrice);
                bookCmd.ExecuteNonQuery();

                //This gets the newest bookId from the Booking table
                string getBookIdQuery = "SELECT TOP 1 bookId FROM Booking ORDER BY bookId DESC";
                SqlCommand getBookIdCmd = new SqlCommand(getBookIdQuery, con);
                int bookId = (int)getBookIdCmd.ExecuteScalar();

                //this inserts the selected room into the RoomBooking table
                string roomBookingQuery = "INSERT INTO BookingRoom (roomId, bookId) VALUES (@roomId, @bookId)";
                SqlCommand roomBookingCmd = new SqlCommand(roomBookingQuery, con);
                roomBookingCmd.Parameters.AddWithValue("@roomId", roomId);
                roomBookingCmd.Parameters.AddWithValue("@bookId", bookId);
                roomBookingCmd.ExecuteNonQuery();

                string getFeatureIdQuery = "SELECT TOP 1 featureId FROM Feature ORDER BY featureId DESC";
                SqlCommand getFeatureIdCmd = new SqlCommand(getFeatureIdQuery, con);
                int featureId = (int)getFeatureIdCmd.ExecuteScalar();


                //this inserts into BookingFeature table using bookId and featureId not fully working ;C
                string bookingFeatureQuery = "INSERT INTO BookingFeature (bookId, featureId, totalFeaturePrice) VALUES (@bookId, @featureId, @totalFeaturePrice)";

                SqlCommand bookingFeatureCmd = new SqlCommand(bookingFeatureQuery, con);
                bookingFeatureCmd.Parameters.AddWithValue("@bookId", bookId);
                bookingFeatureCmd.Parameters.AddWithValue("@featureId", featureId);
                bookingFeatureCmd.Parameters.AddWithValue("@totalFeaturePrice", totalFeaturePrice);

                bookingFeatureCmd.ExecuteNonQuery();
                Response.Write("<script>alert('You have successfully booked a room');</script>");

                con.Close();
            }

                Response.Redirect("Account.aspx");
        }
    }
}    
