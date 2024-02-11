using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication5
{
    public partial class Inventory_Management : System.Web.UI.Page
    {
       
        string connectionstring = @"Data Source=HANIYATJ\SQLEXPRESS;Initial Catalog=chasinglooks1;Integrated Security=True";
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                UpdateTotalStock();
            }

        }

        public void UpdateTotalStock()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionstring))
                {
                    conn.Open();

                    string query = "SELECT COUNT(Product_ID) FROM Product";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        int totalStock = Convert.ToInt32(cmd.ExecuteScalar());

                        // Print debugging information
                        //Response.Write("Total Stock: " + totalStock);

                        lblTotalStock.Text = totalStock.ToString();

                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("Error in UpdateTotalStock: " + ex.Message);
            }
        }
    }
}