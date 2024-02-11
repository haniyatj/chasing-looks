using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication5
{
    public partial class ViewCustomers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Bind Customer data to GridView
                BindCustomerGrid();

                // Bind Payment data to GridView
                BindPaymentGrid();
            }
        }

        private void BindCustomerGrid()
        {
            // Replace the connection string with your actual database connection string
            string connectionString = @"Data Source=HANIYATJ\SQLEXPRESS;Initial Catalog=chasinglooks1;Integrated Security=True";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM Customer", con))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        gvCustomers.DataSource = dt;
                        gvCustomers.DataBind();
                    }
                }
            }
        }

        private void BindPaymentGrid()
        {
            // Replace the connection string with your actual database connection string
            string connectionString = @"Data Source=HANIYATJ\SQLEXPRESS;Initial Catalog=chasinglooks1;Integrated Security=True";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM Payment", con))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        gvPayments.DataSource = dt;
                        gvPayments.DataBind();
                    }
                }
            }
        }
    }
}