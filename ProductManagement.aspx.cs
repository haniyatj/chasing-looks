using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Web.UI.HtmlControls;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication5
{
    public partial class ProductManagement : System.Web.UI.Page
    {
        string connectionstring = @"Data Source=HANIYATJ\SQLEXPRESS;Initial Catalog=chasinglooks1;Integrated Security=True";


        public class Product


        {
            public string ProductName { get; set; }
            public string Category { get; set; }
            public decimal Price { get; set; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Display all products from the database
                DisplayAllProducts();
            }
        }
        private void DisplayProductDetails(int productId)
        {
            using (SqlConnection conn = new SqlConnection(connectionstring))
            {
                conn.Open();

                string query = "SELECT Product_ID, Product_name FROM Product WHERE Product_ID = @productId";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@productId", productId);

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            int displayedProductId = reader.GetInt32(0);
                            string productName = reader.GetString(1);

                            // Display product details (you can customize this part)
                            Response.Write($"Product ID: {displayedProductId}, Product Name: {productName}<br/>");
                        }
                    }
                }
            }
        }
        private void DisplayAllProducts()
        {
            using (SqlConnection conn = new SqlConnection(connectionstring))
            {
                conn.Open();

                string query = "SELECT p.Product_ID, p.Product_name, p.Quantity, p.Price, p.Loyalty_discount, p.Descriptionn, p.Category_ID, MAX(i.Imagee) AS Front_URL, MIN(i.Imagee) AS Back_URL " +
      "FROM Product p " +
      "JOIN Product_images i ON p.Product_ID = i.Product_ID " +
      "GROUP BY p.Product_ID, p.Product_name, p.Quantity, p.Price, p.Loyalty_discount, p.Descriptionn, p.Category_ID";


                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            int productId = reader.GetInt32(0);
                            string productName = reader.GetString(1);
                            int quantity = reader.GetInt32(2);
                            decimal price = reader.GetDecimal(3);
                            int loyaltyDiscount = reader.GetInt32(4);
                            string description = reader.GetString(5);
                            int categoryid = reader.GetInt32(6);
                            string frontUrl = reader.GetString(7);
                            string backUrl = reader.GetString(8);


                            // Display product details dynamically
                            DisplayProductDiv(productId, productName, quantity, price, loyaltyDiscount, description, categoryid, frontUrl, backUrl);
                        }
                    }
                }
            }
        }

        private void DisplayProductDiv(int productId, string productName, int quantity, decimal price, int loyaltyDiscount, string description, int categoryid, string frontUrl, string backUrl)
        {
            // Create a div for each product dynamically
            HtmlGenericControl productDiv = new HtmlGenericControl("div");
            productDiv.Attributes["class"] = "productItem";

            // Create a label for the product name
            Label lblProductName = new Label();
            lblProductName.Text = productName;
            lblProductName.CssClass = "productName";

            // Create a button to view product details
            Button btnViewDetails = new Button();
            btnViewDetails.Text = "View Details";
            btnViewDetails.CssClass = "buttonStyle";
            btnViewDetails.ToolTip = $"Product ID: {productId}\nQuantity: {quantity}\nPrice: {price:C}\nLoyalty Discount: {loyaltyDiscount}%\nDescription: {description}\nCategory ID: {categoryid}\nFront URL: {frontUrl}\nBack URL: {backUrl}";
            btnViewDetails.Click += (sender, e) => ViewProductDetails(productId);

            // Add controls to the product div
            productDiv.Controls.Add(lblProductName);
            productDiv.Controls.Add(new LiteralControl("<br />"));
            productDiv.Controls.Add(btnViewDetails);

            // Add the product div to the container
            productDisplayContainer.Controls.Add(productDiv);
        }


        private void ViewProductDetails(int productId)
        {

            DisplayProductDetails(productId);
        }


       
        protected void BtnAddNewProduct_Click(object sender, EventArgs e)
        {
            // Logic to add a new product
            string productName = txtProductName.Text;
            int price = int.Parse(txtPrice.Text);
            int quantity = int.Parse(TextBox3.Text);
            int loyaltyDiscount = int.Parse(TextBox4.Text);
            string Description = TextBox5.Text;
            string fronturl = TextBox1.Text;
            string backurl = TextBox6.Text;

            if (string.IsNullOrEmpty(TextBox2.Text))
            {
                TextBox2.Text = "1"; // Set a default value or any valid category ID
            }
            int categoryid = int.Parse(TextBox2.Text);
            //Response.Write("Category ID entered: " + categoryid + "<br/>");
            //Response.Write("Front URL: " + fronturl + "<br/>");
            //Response.Write("Back URL: " + backurl + "<br/>");

            using (SqlConnection conn = new SqlConnection(connectionstring))
            {
                try
                {
                    conn.Open(); // Open the connection here

                    // Your initial query for inserting into the Product table
                    String query = "INSERT INTO Product (Product_name, Quantity, Price, Descriptionn, Loyalty_discount, Category_ID) " +
                                   "VALUES (@productName, @quantity, @price, @Description, @loyaltyDiscount, " +
                                   "(SELECT Category_ID FROM Category WHERE Category_ID = @categoryid))";

                    using (SqlCommand cm = new SqlCommand(query, conn))
                    {
                        // Set parameters for the Product insert query
                        cm.Parameters.AddWithValue("@productName", productName);
                        cm.Parameters.AddWithValue("@quantity", quantity);
                        cm.Parameters.AddWithValue("@price", price);
                        cm.Parameters.AddWithValue("@Description", Description);
                        cm.Parameters.AddWithValue("@loyaltyDiscount", loyaltyDiscount);
                        cm.Parameters.AddWithValue("@categoryid", categoryid);
                        cm.ExecuteNonQuery();
                    }

                    // Fetch the last inserted Product_ID
                    int productId;
                    using (SqlCommand getIdCmd = new SqlCommand("SELECT MAX(Product_ID) FROM Product", conn))
                    {
                        productId = Convert.ToInt32(getIdCmd.ExecuteScalar());
                      //  Response.Write("Product ID: " + productId + "<br/>");
                    }

                    // Insert into ProductImages table for fronturl
                    using (SqlCommand imageCmdFront = new SqlCommand("INSERT INTO Product_images (Imagee, Product_ID) VALUES (@fronturl, @productId)", conn))
                    {
                        imageCmdFront.Parameters.AddWithValue("@fronturl", fronturl);
                        imageCmdFront.Parameters.AddWithValue("@productId", productId);
                        imageCmdFront.ExecuteNonQuery();
                    }

                    // Insert into ProductImages table for backurl
                    using (SqlCommand imageCmdBack = new SqlCommand("INSERT INTO Product_images (Imagee, Product_ID) VALUES (@backurl, @productId)", conn))
                    {
                        imageCmdBack.Parameters.AddWithValue("@backurl", backurl);
                        imageCmdBack.Parameters.AddWithValue("@productId", productId);
                        imageCmdBack.ExecuteNonQuery();
                    }
                    conn.Close();
                    using (SqlCommand getIdCmd = new SqlCommand("SELECT MAX(Product_ID) FROM Product", conn))
                    {
                        productId = Convert.ToInt32(getIdCmd.ExecuteScalar());
                      //  Response.Write("Product ID: " + productId + "<br/>");
                    }

                    // Display the details of the newly added product

                    DisplayProductDetails(productId);
                    Server.Transfer("Inventory_Management.aspx", true);

                }
                catch (Exception ex)
                {
                    // Handle exceptions appropriately, log or display an error message
                    Response.Write("Error: " + ex.Message + "<br/>");
                }
            }
        }

        protected void onupdate(object sender, EventArgs e)
        {
            Response.Redirect("update.aspx");


        }

        protected void OnDelete(object sender, EventArgs e)
        {
            string deleteName = txtProductName.Text;

            using (SqlConnection conn = new SqlConnection(connectionstring))
            {
                string query = "DELETE FROM Product WHERE Product_name = @productName";
                Console.WriteLine("Executing SQL query: " + query);

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@productName", deleteName);

                    try
                    {
                        conn.Open();
                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            Response.Write("Product deleted successfully!");
                        }
                        else
                        {
                            Response.Write("No product found with the given name.");
                        }
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine(ex.ToString());
                        Response.Write("Error: " + ex.Message);
                    }
                    finally
                    {
                        if (conn.State == ConnectionState.Open)
                        {
                            conn.Close();
                        }
                    }
                }
            }
        }




  
    }


}