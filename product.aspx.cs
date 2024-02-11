using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication5
{
    public partial class product: System.Web.UI.Page
    {
        string connectionString = @"Data Source=HANIYATJ\SQLEXPRESS;Initial Catalog=chasinglooks1;Integrated Security=True";
        public class CartItem
        {
            public string ProductName { get; set; }
            public int Quantity { get; set; }
            public decimal TotalPrice { get; set; }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)


            {

                Debug.WriteLine("YASS");

                // Check if the categoryId parameter is present in the query string
                if (Request.QueryString["ProductId"] != null)
                {
                    // Retrieve the category ID from the query string
                    string ProductId = Request.QueryString["ProductId"];


                    DisplayProductItems(ProductId);
                }
                else
                {

                    // Handle the case where no category ID is specified

                }


            }
         //   UpdateCartPopupFromSession();



        }
     
        private void DisplayProductItems(string productId)
        {


            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Fetch product information
                string productQuery = "SELECT Product_name, Descriptionn, Price , Loyalty_discount FROM Product WHERE Product_ID = @ProductId";

                using (SqlCommand command = new SqlCommand(productQuery, connection))
                {
                    command.Parameters.AddWithValue("@ProductId", productId);

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            // Set product information to the respective divs
                            string productName = reader["Product_name"].ToString();
                            string description = reader["Descriptionn"].ToString();
                            decimal price = Convert.ToDecimal(reader["Price"]);
                            int loyaltyDiscount = Convert.ToInt32(reader["Loyalty_discount"]);

                            SetProductInformation(productName, description, price, loyaltyDiscount);
                        }
                    }
                }

                // Fetch product images
                string imagesQuery = "SELECT Imagee FROM Product_images WHERE Product_ID = @ProductId";

                using (SqlCommand command = new SqlCommand(imagesQuery, connection))
                {
                    command.Parameters.AddWithValue("@ProductId", productId);

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        // Assuming you have Image controls for displaying images (imgProduct1 and imgProduct2)
                        if (reader.Read())
                        {
                            string imageUrl1 = reader["Imagee"].ToString();
                            imgProduct1.ImageUrl = imageUrl1; // Update the Image control ID accordingly
                        }

                        // Move to the next record (if available) for the second image
                        if (reader.Read())
                        {
                            string imageUrl2 = reader["Imagee"].ToString();
                            imgProduct2.ImageUrl = imageUrl2; // Update the Image control ID accordingly
                        }
                    }
                }

                string reviewsQuery = "SELECT Size, Content FROM Review WHERE Product_ID = @ProductId";

                using (SqlCommand command = new SqlCommand(reviewsQuery, connection))
                {
                    command.Parameters.AddWithValue("@ProductId", productId);

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            string size = reader["Size"].ToString();
                            string content = reader["Content"].ToString();

                            SetReviewInformation(size, content);

                        }
                    }
                }

            }
        }

        private void SetProductInformation(string productName, string description, decimal price, int loyaltyDiscount)
        {
            // Set product information to the respective divs or controls
            lblProductName.Text = productName; // Update accordingly
            lblDescription.Text = description; // Update accordingly
            lblPrice.Text = price.ToString("C"); // Currency format, update accordingly
            hdnLoyaltyDiscount.Text = loyaltyDiscount.ToString();

        }

        private void SetReviewInformation(string size, string content)
        {
            Panel reviewContainer = new Panel();
            reviewContainer.CssClass = "reviewPanel";

            // Set review information to the review container
            reviewContainer.Controls.Add(new LiteralControl("<p><strong>Size: " + size + "</strong></p>"));
            reviewContainer.Controls.Add(new LiteralControl("<p>" + content + "</p>"));

            // Add the review container to the "reviews" container
            reviews.Controls.Add(reviewContainer);
        }


        protected void CheckoutButton_Click(object sender, EventArgs e)
        {

            Response.Redirect("checkout.aspx");
        }

        protected void SubmitReview_Click(object sender, EventArgs e)
        {
            // Get the values from the popup form
            string sizeBought = txtSizeBought.Text;

            string content = txtContent.Text;

            // Get the Product_ID from the query parameter
            if (Request.QueryString["productId"] != null)
            {
                int productId = Convert.ToInt32(Request.QueryString["productId"]);

                // Insert the review into the Review table
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    string query = "INSERT INTO Review (Product_ID, Size, Content) VALUES (@ProductID, @Size, @Content)";
                    using (SqlCommand cmd = new SqlCommand(query, connection))
                    {
                        cmd.Parameters.AddWithValue("@ProductID", productId);
                        cmd.Parameters.AddWithValue("@Size", sizeBought);
                        cmd.Parameters.AddWithValue("@Content", content);
                        cmd.ExecuteNonQuery();
                    }
                }

                Response.Redirect(Request.RawUrl);

            }
        }

    
     



      


    }
}