using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Mayumi
{
    public partial class RoomBooking : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DateTime? checkin = Session["checkin"] as DateTime?;
                DateTime? checkout = Session["checkout"] as DateTime?;
                int? totalGuests = Session["totalGuests"] as int?;

                if (checkin.HasValue && checkout.HasValue && totalGuests.HasValue && totalGuests.Value > 0)
                {
          
                    info.DataSource = GetData(checkin.Value, checkout.Value, totalGuests.Value);
                    info.DataBind();
                }
                else
                {
                    Response.Redirect("Default.aspx");
                }
            }
        }

        protected void btnSelectRoom_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string selectedRoomType = btn.CommandArgument;

            Session["selectedRoomType"] = selectedRoomType;

            (int roomId, decimal roomPrice) = GetRoomDetailsFromDatabase(selectedRoomType);

            Session["roomId"] = roomId;
            Session["roomPrice"] = roomPrice;

            Response.Redirect("Extras.aspx"); 
        }

        private (int, decimal) GetRoomDetailsFromDatabase(string roomType)
        {
            int roomId = 0;
            decimal roomPrice = 0.00M; //default value in case there is no price found
            string connectionString = ConfigurationManager.ConnectionStrings["DBCon"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"
                SELECT r.roomId, rc.roomPrice
                FROM RoomClass rc
                JOIN Room r ON r.roomClassId = rc.roomClassId
                WHERE rc.className = @RoomType";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@RoomType", roomType);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    roomId = Convert.ToInt32(reader["roomId"]);
                    roomPrice = Convert.ToDecimal(reader["roomPrice"]);
                }
            }

            return (roomId, roomPrice);
        }

        private DataTable GetData(DateTime checkIn, DateTime checkOut, int totalGuests)
        {
            DataTable dt = new DataTable();
            string connectionString = ConfigurationManager.ConnectionStrings["DBCon"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string select = @"
                    SELECT r.roomId, r.room_num, r.maxGuest, rc.className, rc.roomPrice, r.imageURL
                    FROM Room r
                    JOIN RoomClass rc ON r.roomClassId = rc.roomClassId
                    WHERE r.maxGuest >= @totalGuests  
                    AND r.roomId NOT IN (
                        SELECT br.roomId
                        FROM BookingRoom br
                        JOIN Booking b ON br.bookId = b.bookId
                        WHERE (@checkin BETWEEN b.checkIn AND b.checkOut)
                           OR (@checkout BETWEEN b.checkIn AND b.checkOut)
                           OR (b.checkIn BETWEEN @checkin AND @checkout)
                           OR (b.checkOut BETWEEN @checkin AND @checkout)
                    )";

                using (SqlCommand cmd = new SqlCommand(select, con))
                {
                    cmd.Parameters.AddWithValue("@totalGuests", totalGuests);
                    cmd.Parameters.AddWithValue("@checkin", checkIn);
                    cmd.Parameters.AddWithValue("@checkout", checkOut);

                    con.Open();
                    dt.Load(cmd.ExecuteReader());
                }
            }
            return dt;
        }
    }
}
