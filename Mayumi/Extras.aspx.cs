using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace Mayumi
{
    public partial class Extras : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadFeaturePrices();
            }
        }

        private void LoadFeaturePrices()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DBCon"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM Feature";
                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                DataTable dt = new DataTable();
                dt.Load(reader);

                //this binds the features to the repeater
                rptFeatures.DataSource = dt;
                rptFeatures.DataBind();

                
                lblFeaturePrice.Text = "Total Features: €0.00";

                reader.Close();
            }
        }

        protected void btnNextConfirm_Click(object sender, EventArgs e)
        {
            decimal totalFeaturePrice = Convert.ToDecimal(hiddenFeaturePrice.Value);
            Session["totalFeaturePrice"] = totalFeaturePrice;

            Response.Redirect("ConfirmBooking.aspx");
        }


    }
}
 