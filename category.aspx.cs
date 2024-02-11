using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace WebApplication5
{
    public partial class category : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if the categoryId parameter is present in the query string
                if (Request.QueryString["categoryId"] != null)
                {
                    // Retrieve the category ID from the query string
                    string categoryId = Request.QueryString["categoryId"];
                    Console.WriteLine($"CategoryId: {categoryId}");


                    // Call a method to fetch and display items based on the category ID
                    DisplayCategoryItems(categoryId);
                }
                else
                {

                    // Handle the case where no category ID is specified

                }
            }
        }


        private void DisplayCategoryItems(string categoryId)
        {
            // Implement your logic to fetch and display items based on the category ID
            // You might need to query the database using the categoryId
            // Populate your page with the specific items related to the category

            string connectionString = @"Data Source=HANIYATJ\SQLEXPRESS;Initial Catalog=chasinglooks1;Integrated Security=True";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = @"
             SELECT 
                p.Product_ID,
                p.Product_name,
                p.Price,             
                (
                    SELECT TOP 1 pi.Imagee
                    FROM Product_images pi
                    WHERE pi.Product_ID = p.Product_ID
                ) AS ImageUrl
            FROM 
                Product p  WHERE
                Category_ID = @CategoryId";
   

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@CategoryId", categoryId);

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {

                            Image productImage = new Image();
                            productImage.ImageUrl = reader["ImageUrl"].ToString();
                            productImage.AlternateText = reader["Product_name"].ToString();

                            // Create the HyperLink control
                            HyperLink productLink = new HyperLink();
                            productLink.NavigateUrl = $"product.aspx?productId={reader["Product_ID"]}"; // Add your actual URL here
                            productLink.Target = "_blank"; // Add your desired target attribute
                            productLink.Controls.Add(productImage); // Add the Image control to the HyperLink

                            // Create the product info div
                            Panel productInfoPanel = new Panel();
                            productInfoPanel.CssClass = "product-info";
                            productInfoPanel.Controls.Add(new LiteralControl($"<h3>{reader["Product_name"]}</h3>"));
                            productInfoPanel.Controls.Add(new LiteralControl($"<p>${reader["Price"]}</p>"));

                            // Create the main product box div
                            Panel productBoxPanel = new Panel();
                            productBoxPanel.CssClass = "product-box";
                            productBoxPanel.Controls.Add(productLink);
                            productBoxPanel.Controls.Add(productInfoPanel);

                            // Add the main product box div to the products div
                            products.Controls.Add(productBoxPanel);
                        }
                    }
                }
            }
        }


    }
}