using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication5
{
    public partial class adminlogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
     
        protected void BtnLogin_Click(object sender, EventArgs e)
        {
            // Get the provided username and password
            string enteredUsername = txtUsername.Text;
            string enteredPassword = txtPassword.Text;

            // Check the credentials against the database
            if (CheckCredentials(enteredUsername, enteredPassword))
            {
                // Redirect to Admin Landing page
                Response.Redirect("Admin_Landing.aspx");
            }
            else
            {
                // Display alert for incorrect credentials
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Incorrect username or password.');", true);
            }
        }

        private bool CheckCredentials(string username, string password)
        {
            // Replace 'YourConnectionString' with your actual connection string
            using (SqlConnection connection = new SqlConnection("Data Source=HANIYATJ\\SQLEXPRESS;Initial Catalog=chasinglooks1;Integrated Security=True"))

            {
                connection.Open();

                // Check if the provided username and password match the records in the Admin1 table
                string query = "SELECT COUNT(*) FROM Admin1 WHERE Username = @Username AND Password1 = @Password";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Username", username);
                    command.Parameters.AddWithValue("@Password", password);

                    int count = Convert.ToInt32(command.ExecuteScalar());

                    return count > 0;
                }
            }
        }
    }
}