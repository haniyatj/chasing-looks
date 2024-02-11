using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static WebApplication5.ProductManagement;

namespace WebApplication5
{
    public partial class homescreen : System.Web.UI.Page
    {
        string connectionString = @"Data Source=HANIYATJ\SQLEXPRESS;Initial Catalog=chasinglooks1;Integrated Security=True";
        SqlCommand cmd;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if a search term is present in the query string
                string searchTerm = Request.QueryString["searchTerm"];
                string sortOrder = Request.QueryString["selectedOption"];

                if (!string.IsNullOrEmpty(searchTerm))
                {
                    // If a search term is present, bind products with the search term
                    BindProducts(searchTerm);
                }
                else if(!string.IsNullOrEmpty(sortOrder))
                   
                {
                    BindProducts(sortOrder);


                }
                else
                {
                    // If no search term is present, bind products without filtering
                    BindProducts("");
                }
            }

        }

        private void BindProducts(string s)
        {

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
                Product p ";

                string categoryQuery = @"
            SELECT Category_ID, Category_Name,Imagee
            FROM Category";

              
                if (!string.IsNullOrEmpty(s))
                {
                    switch (s)
                    {
                        case "highestPrice":
                            query += "ORDER BY p.Price DESC";
                            break;
                        case "lowestPrice":
                            query += "ORDER BY p.Price ASC";
                            break;
                        case "highestReviews":
                            query += "ORDER BY (SELECT COUNT(*) FROM Review pr WHERE pr.Product_ID = p.Product_ID) DESC";
                            break;
                        case "lowestReviews":
                            query += "ORDER BY (SELECT COUNT(*) FROM Review pr WHERE pr.Product_ID = p.Product_ID) ASC";
                            break;
                        default:
                            query += $"WHERE p.Product_name LIKE '%{s}%'";
                            break;

                      
                    }
                }

                cmd = new SqlCommand(query, connection);
               SqlDataReader reader = cmd.ExecuteReader();



                while (reader.Read())
                {
                    Image productImage = new Image();
                    productImage.ImageUrl = reader["ImageUrl"].ToString();
                    productImage.AlternateText = reader["Product_name"].ToString();

                    // Create the HyperLink control
                    HyperLink productLink = new HyperLink();
                    productLink.NavigateUrl =  $"product.aspx?productId={reader["Product_ID"]}"; // Add your actual URL here
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
                reader.Close();


                SqlCommand categoryCmd = new SqlCommand(categoryQuery, connection);
                SqlDataReader categoryReader = categoryCmd.ExecuteReader();

                while (categoryReader.Read())
                {
                    // Create instances of HyperLink and Image controls
                    HyperLink categoryLink = new HyperLink();
                    categoryLink.ToolTip = categoryReader["Category_Name"].ToString();
                    categoryLink.NavigateUrl = $"category.aspx?categoryId={categoryReader["Category_ID"]}";

                    Image categoryImage = new Image();
                    categoryImage.ImageUrl = categoryReader["Imagee"].ToString();
                    categoryImage.AlternateText = categoryReader["Category_Name"].ToString();
                    categoryLink.Controls.Add(categoryImage);

                    // Add the controls to the category box
                    Panel categoryBox = new Panel();
                    categoryBox.CssClass = "category-box";
                    categoryBox.Controls.Add(categoryLink);
                    

                    // Add the category label
                    Label categoryLabel = new Label();
                    categoryLabel.CssClass = "category-label";
                    categoryLabel.Text = categoryReader["Category_Name"].ToString();
                    categoryBox.Controls.Add(categoryLabel);

                    // Add the category box to the categories control
                    categories.Controls.Add(categoryBox);
                }
            }
        }
    

    protected void BtnCart_Click(object sender, EventArgs e)
        {
            // Toggle visibility of the cart popup
            cartPopup.Visible = !cartPopup.Visible;
        }

    
        protected void CheckoutButton_Click(object sender, EventArgs e)
        {

            Response.Redirect("checkout.aspx");
        }
        protected void ProductLink_Click(object sender, EventArgs e)
        {

           
        }


    }
}