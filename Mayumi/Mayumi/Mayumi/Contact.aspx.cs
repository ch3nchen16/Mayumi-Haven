using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace Mayumi
{
    public partial class Contact : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
           
            string name = txtName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string subject = txtSubject.Text.Trim();
            string message = txtMessage.Text.Trim();

            string adminEmail = ConfigurationManager.AppSettings["Email"];
            string appPassword = ConfigurationManager.AppSettings["AppPassword"];

            
            if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(email) || string.IsNullOrEmpty(subject) || string.IsNullOrEmpty(message))
            {
                Response.Write("<script>alert('Please fill in all fields.');</script>");
                return;
            }


            try
            {
                
                MailMessage mail = new MailMessage();
                mail.From = new MailAddress(email); 
                mail.To.Add("chenylle.geronimo@gmail.com"); 
                mail.Subject = subject;
                mail.Body = $"Name: {name}\nEmail: {email}\nMessage:\n{message}";

                //SMTP server
                SmtpClient smtp = new SmtpClient();
                smtp.Host = "smtp.gmail.com"; 
                smtp.Port = 587; 
                smtp.Credentials = new NetworkCredential(adminEmail, appPassword);
                smtp.EnableSsl = true;

                smtp.Send(mail);

                Response.Write("<script>alert('Your message has been sent successfully!');</script>");

                //clear form fields
                txtName.Text = "";
                txtEmail.Text = "";
                txtSubject.Text = "";
                txtMessage.Text = "";
            }
            catch (Exception ex)
            {
                
                Response.Write("<script>alert('Error sending message. Please try again later.');</script>");
                Console.WriteLine("Error: " + ex.Message); 
            }
        }
    }
}
    
