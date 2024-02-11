using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication5
{
    public partial class update : System.Web.UI.Page
    {
        string connectionString = @"Data Source=HANIYATJ\SQLEXPRESS;Initial Catalog=chasinglooks1;Integrated Security=True";

        protected void btnUpdateProduct_Click(object sender, EventArgs e)
        {
            try
            {
                int productId = int.Parse(TextBox5.Text);
                string productName = txtProductName.Text;
                string description = string.IsNullOrEmpty(TextBox2.Text) ? "" : TextBox2.Text;
                string category = string.IsNullOrEmpty(TextBox1.Text) ? "" : TextBox1.Text;
                decimal price = string.IsNullOrEmpty(txtPrice.Text) ? 0 : decimal.Parse(txtPrice.Text);
                int loyalty = string.IsNullOrEmpty(TextBox6.Text) ? 0 : int.Parse(TextBox6.Text);
                string front = string.IsNullOrEmpty(TextBox3.Text) ? "" : TextBox3.Text;
                string back = string.IsNullOrEmpty(TextBox4.Text) ? "" : TextBox4.Text;

                UpdateProductInDatabase(productId, productName, description, category, price, loyalty, front, back);

                Response.Redirect("ProductManagement.aspx");
            }
            catch (Exception ex)
            {
                Response.Write("Error: " + ex.Message + "<br/>");
            }
        }

        private void UpdateProductInDatabase(int productId, string productName, string description, string category, decimal price, int loyalty, string front, string back)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                string updateQuery = "UPDATE Product SET ";
                string updateImageQuery = "UPDATE Product_images SET ";

                bool updateNeeded = false;

                if (!string.IsNullOrEmpty(productName))
                {
                    updateQuery += "Product_name = @productName, ";
                    updateNeeded = true;
                }

                if (!string.IsNullOrEmpty(description))
                {
                    updateQuery += "Descriptionn = @description, ";
                    updateNeeded = true;
                }

                if (loyalty >= 0)
                {
                    updateQuery += "Loyalty_discount = @loyalty, ";
                    updateNeeded = true;
                }

                if (!string.IsNullOrEmpty(category))
                {
                    updateQuery += "Category_ID = @category, ";
                    updateNeeded = true;
                }

                if (price >= 0)
                {
                    updateQuery += "Price = @price, ";
                    updateNeeded = true;
                }

                if (updateNeeded)
                {
                    updateQuery = updateQuery.TrimEnd(' ', ',');
                    updateQuery += " WHERE Product_ID = @productId";

                    using (SqlCommand updateCmd = new SqlCommand(updateQuery, conn))
                    {
                        updateCmd.Parameters.AddWithValue("@productId", productId);
                        updateCmd.Parameters.AddWithValue("@productName", productName);
                        updateCmd.Parameters.AddWithValue("@description", description);
                        updateCmd.Parameters.AddWithValue("@category", category);
                        updateCmd.Parameters.AddWithValue("@price", price);
                        updateCmd.Parameters.AddWithValue("@loyalty", loyalty);

                        updateCmd.ExecuteNonQuery();
                    }
                }

                if (!string.IsNullOrEmpty(front))
                {
                    string updateFrontImageQuery = "UPDATE Product_images SET Imagee = @front WHERE Product_ID = @productId";
                    using (SqlCommand updatefCmd = new SqlCommand(updateFrontImageQuery, conn))
                    {
                        updatefCmd.Parameters.AddWithValue("@productId", productId);
                        updatefCmd.Parameters.AddWithValue("@front", front);

                        updatefCmd.ExecuteNonQuery();
                    }
                }

                if (!string.IsNullOrEmpty(back))
                {
                    string updateBackImageQuery = "UPDATE Product_images SET Imagee = @back WHERE Product_ID = @productId";
                    using (SqlCommand updatebCmd = new SqlCommand(updateBackImageQuery, conn))
                    {
                        updatebCmd.Parameters.AddWithValue("@productId", productId);
                        updatebCmd.Parameters.AddWithValue("@back", back);

                        updatebCmd.ExecuteNonQuery();
                    }
                }
            }
        }
    }
}

