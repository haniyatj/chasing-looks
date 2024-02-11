using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication5
{

        public partial class CategoryManagement : System.Web.UI.Page
        {
            string connectionString = @"Data Source=HANIYATJ\SQLEXPRESS;Initial Catalog=chasinglooks1;Integrated Security=True";
            SqlCommand cmc;

            protected void Page_Load(object sender, EventArgs e)
            {
                if (!IsPostBack)
                {
                    PopulateCategories();
                }
            }


            protected void PopulateCategories()
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    try
                    {
                        conn.Open();

                        string query = "SELECT Category_Id, Category_Name FROM Category";
                        using (SqlCommand cmd = new SqlCommand(query, conn))
                        {
                            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                            {
                                DataTable dt = new DataTable();
                                da.Fill(dt);

                                // Bind the retrieved categories to the DropDownList
                                lstCategories.DataSource = dt;
                                lstCategories.DataTextField = "Category_Name";
                                lstCategories.DataValueField = "Category_Id";
                                lstCategories.DataBind();
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine(ex.ToString());
                        // Handle the exception, e.g., log or display an error message.
                    }
                }
            }

            protected void lstCategories_SelectedIndexChanged(object sender, EventArgs e)
            {
                string selectedCategoryId = lstCategories.SelectedValue;
                lblSelectedCategory.Text = "Products in " + lstCategories.SelectedItem.Text + " category";

                // Fetch and display products for the selected category
                DisplayProductsByCategory(selectedCategoryId);

                // Show the panel containing product information
                pnlProducts.Visible = true;
            }
            protected void btnAddCategory_Click(object sender, EventArgs e)
            {
                string categoryy = txtNewCategory.Text;
            string categoryImage = txtNewCategoryImage.Text; // New line to get the image URL

            using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    try
                    {
                        conn.Open(); // Open the connection here

                        // Your initial query for inserting into the Product table
                        String query = "INSERT INTO Category (Category_Name,Imagee) " +
                                       "VALUES (@categoryy, @categoryImage)";

                        using (SqlCommand cm = new SqlCommand(query, conn))
                        {
                            // Set parameters for the Product insert query
                            cm.Parameters.AddWithValue("@categoryy", categoryy);
                        cm.Parameters.AddWithValue("@categoryImage", categoryImage);

                      


                        cm.ExecuteNonQuery();
                            Response.Write("Category added successfully!");
                        }

                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine(ex.ToString());
                        Response.Write("Error: " + ex.Message);
                    }
                    // Add the new category to the database or any other storage
                    // AddNewCategoryToDatabase(newCategory);

                    // Add the new category to the list and re-populate the categories
                    /* lstCategories.Items.Add(newCategory);
             txtNewCategory.Text = ""; // Clear the text box after adding the category*/
                }

                // private void AddNewCategoryToDatabase(string newCategory)
                // {
                //     // Add the new category to the database
                // }
            }

            protected void DisplayProductsByCategory(string categoryId)
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    try
                    {
                        conn.Open();

                    // Query to retrieve products for the selected category
                    string query = "SELECT p.Product_ID, p.Product_name, p.Quantity, p.Price, p.Loyalty_discount, p.Descriptionn, p.Category_ID, MAX(i.Imagee) AS Front_URL, MIN(i.Imagee) AS Back_URL " +
              "FROM Product p " +
              "JOIN Product_images i ON p.Product_ID = i.Product_ID " +
              "WHERE p.Category_ID = @categoryId " +
              "GROUP BY p.Product_ID, p.Product_name, p.Quantity, p.Price, p.Loyalty_discount, p.Descriptionn, p.Category_ID";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                        {
                            cmd.Parameters.AddWithValue("@categoryId", categoryId);

                            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                            {
                                DataTable dt = new DataTable();
                                da.Fill(dt);

                                // Bind the retrieved products to a GridView
                                gvProducts.DataSource = dt;
                                gvProducts.DataBind();

                                // Add a "Select" button to each row in the GridView
                                if (gvProducts.Rows.Count > 0)
                                {
                                    gvProducts.HeaderRow.Cells[0].Text = "Select"; // Header text
                                    for (int i = 0; i < gvProducts.Rows.Count; i++)
                                    {
                                        Button btnSelect = new Button();
                                        btnSelect.Text = "Details";
                                        btnSelect.CssClass = "buttonStyle";

                                        // Set ToolTip to display all product details
                                        btnSelect.ToolTip = $"Product ID: {dt.Rows[i]["Product_Id"]}, Product Name: {dt.Rows[i]["Product_Name"]}, Quantity: {dt.Rows[i]["Quantity"]}, Price: {dt.Rows[i]["Price"]}, Loyalty Discount: {dt.Rows[i]["Loyalty_discount"]}, Description: {dt.Rows[i]["Descriptionn"]}, Category ID: {dt.Rows[i]["Category_ID"]}, Front URL: {dt.Rows[i]["Front_URL"]}, Back URL: {dt.Rows[i]["Back_URL"]}";

                                        //  btnSelect.Click += (sender, e) => SelectProductDetails(dt.Rows[i]["Product_Id"].ToString());

                                        gvProducts.Rows[i].Cells[0].Controls.Add(btnSelect);
                                    }
                                }
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine(ex.ToString());
                        // Handle the exception, e.g., log or display an error message.
                    }
                }
            }

            private void SelectProductDetails(string productId)
            {
                // Fetch and display details for the selected product
                DisplayProductDetails(Convert.ToInt32(productId));

                // Show the panel containing product information
                pnlProducts.Visible = true;
            }

            private void DisplayProductDetails(int productId)
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    string query = "SELECT Product_ID, Product_name, Quantity, Price, Loyalty_discount, Descriptionn, Category_ID FROM Product WHERE Product_ID = @productId";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@productId", productId);

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                int displayedProductId = reader.GetInt32(0);
                                string productName = reader.GetString(1);
                                int quantity = reader.GetInt32(2);
                                decimal price = reader.GetDecimal(3);
                                int loyaltyDiscount = reader.GetInt32(4);
                                string description = reader.GetString(5);
                                int categoryId = reader.GetInt32(6);

                                // Display complete product details (customize as needed)
                                Response.Write($"Product ID: {displayedProductId}<br/>");
                                Response.Write($"Product Name: {productName}<br/>");
                                Response.Write($"Quantity: {quantity}<br/>");
                                Response.Write($"Price: {price:C}<br/>");
                                Response.Write($"Loyalty Discount: {loyaltyDiscount}%<br/>");
                                Response.Write($"Description: {description}<br/>");
                                Response.Write($"Category ID: {categoryId}<br/>");
                            }
                        }
                    }
                }
            }

        }
    


}