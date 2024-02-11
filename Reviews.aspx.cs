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
    public partial class Reviews: System.Web.UI.Page
    {
      

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGridView();
            }
        }

        private void BindGridView()
        {
            // Connection string for your database
            string connectionString = @"Data Source=HANIYATJ\SQLEXPRESS;Initial Catalog=chasinglooks1;Integrated Security=True";

            // SQL query to retrieve reviews along with product information
            string query = "SELECT Review.Review_ID, Review.Product_ID, Review.Size, Review.Content, " +
                           "Product.Product_ID AS ProductID, Product.Price, Product.Quantity, " +
                           "Product.Product_name, Product.Descriptionn, Product.Loyalty_discount " +
                           "FROM Review " +
                           "INNER JOIN Product ON Review.Product_ID = Product.Product_ID";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                using (SqlDataAdapter adapter = new SqlDataAdapter(query, connection))
                {
                    DataTable dataTable = new DataTable();
                    adapter.Fill(dataTable);

                    GridViewReviews.DataSource = dataTable;
                    GridViewReviews.DataBind();
                }
            }
        }


    }
}