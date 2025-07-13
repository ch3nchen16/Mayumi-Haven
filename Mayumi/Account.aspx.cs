using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Mayumi
{
    public partial class Account : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["email"] != null)
                {
                    string email = Session["email"].ToString();
                    LoadMemberDetails(email); 
                    LoadBookings(email);
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
            }
        }
        private void LoadBookings(string email)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DBCon"].ConnectionString;
            string query = @"
            SELECT b.bookId, b.checkIn, b.checkOut, b.totalPrice, rc.className 
            FROM Booking b
            INNER JOIN BookingRoom br ON b.bookId = br.bookId
            INNER JOIN Room r ON br.roomId = r.roomId
            INNER JOIN RoomClass rc ON r.roomClassId = rc.roomClassId
            WHERE b.memId = (SELECT TOP 1 memId FROM Member WHERE email = @email)";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                da.SelectCommand.Parameters.AddWithValue("@email", email);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvBookings.DataSource = dt;
                gvBookings.DataBind();
            }
        }


        private void LoadMemberDetails(string email)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DBCon"].ConnectionString;
            string query = "SELECT fn, sn, email, phone FROM Member WHERE email = @email";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@email", email);
                con.Open();

                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        txtFirstName.Text = reader["fn"].ToString();
                        txtLastName.Text = reader["sn"].ToString();
                        txtEmail.Text = reader["email"].ToString();
                        txtPhone.Text = reader["phone"].ToString();
                    }
                }

                con.Close();
            }
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            string firstName = txtFirstName.Text.Trim();
            string lastName = txtLastName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string phone = txtPhone.Text.Trim();

            // Ensures the email and phone are not empty
            if (string.IsNullOrEmpty(firstName) || string.IsNullOrEmpty(lastName) || string.IsNullOrEmpty(email) || string.IsNullOrEmpty(phone))
            {
                Response.Write("<script>alert('Please fill in all fields.');</script>");
                return;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["DBCon"].ConnectionString;
            string query = "UPDATE Member SET fn = @firstName, sn = @surName, email = @email, phone = @phone WHERE email = @email";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@firstName", firstName);
                cmd.Parameters.AddWithValue("@surName", lastName);
                cmd.Parameters.AddWithValue("@email", email);
                cmd.Parameters.AddWithValue("@phone", phone);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();

                Response.Write("<script>alert('Account details updated successfully.');</script>");
            }
        }
    }
}