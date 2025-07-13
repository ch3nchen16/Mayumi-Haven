using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace Mayumi
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        //ecrypt password
        public static string ComputeMD5Hash(string input)
        {
            using (System.Security.Cryptography.MD5 md5 = System.Security.Cryptography.MD5.Create())
            {
                byte[] inputBytes = System.Text.Encoding.ASCII.GetBytes(input);
                byte[] hashBytes = md5.ComputeHash(inputBytes);

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

            //checks if passwords match
            if (password != confirmPassword)
            {
                Response.Write("<script>alert('Passwords do not match.');</script>");
                return;
            }
            string hashedPassword = ComputeMD5Hash(password);

            string connectionString = ConfigurationManager.ConnectionStrings["DBCon"].ConnectionString;

            //Checks if email already exists
            string emailCheckQuery = "SELECT COUNT(*) FROM Member WHERE email = @email";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand emailCheckCmd = new SqlCommand(emailCheckQuery, con);
                emailCheckCmd.Parameters.AddWithValue("@email", email);

                con.Open();

                int emailExists = (int)emailCheckCmd.ExecuteScalar();

                if (emailExists > 0)
                {
                    Response.Write("<script>alert('Email already exists. Please use a different email.');</script>");
                    return;
                }

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
    }
}