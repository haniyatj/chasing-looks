using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication5
{
    public partial class vieworders : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DisplayOrderData();
            }
        }

        private void DisplayOrderData()
        {
            // Connection string - Update it with your actual database connection string
            string connectionString = @"Data Source=HANIYATJ\SQLEXPRESS;Initial Catalog=chasinglooks1;Integrated Security=True";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                // Open the connection
                connection.Open();

                // Query to fetch data from both tables
                string query = "SELECT o.Order_ID, o.Order_Quantity, o.Total_Price AS Order_Total_Price, " +
                               "oi.OrderItem_ID, oi.Quantity AS OrderItem_Quantity, oi.Total_Price AS OrderItem_Total_Price, oi.ItemName AS ItemName, oi.Size AS sizeBought " +
                               "FROM Order1 o " +
                               "JOIN OrderItem oi ON o.Order_ID = oi.Order_ID";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        // Check if there are rows in the result set
                        if (reader.HasRows)
                        {
                            // Bind the reader result to the GridView
                            GridViewOrders.DataSource = reader;
                            GridViewOrders.DataBind();
                        }
                        else
                        {
                            // No data found
                            // You can add your own logic or message here
                        }
                    }
                }
            }
        }
    }
}