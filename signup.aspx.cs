using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace WebApplication5
{
    public partial class signup : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void BtnLogin_Click(object sender, EventArgs e)
        {
            string email = adminUsername.Text;
            string password = adminEmail.Text;

            // Your SQL connection and command (adjust the connection string)
            using (SqlConnection connection = new SqlConnection("Data Source=HANIYATJ\\SQLEXPRESS;Initial Catalog=chasinglooks1;Integrated Security=True"))
            {
                connection.Open();

                // Create a parameterized SQL query to check if the user exists
                string query = "SELECT * FROM Customer WHERE Email = @Email AND Password1 = @Password";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Email", email);
                    command.Parameters.AddWithValue("@Password", password);

                    // Execute the query
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            // User exists, redirect to home screen or another page as needed
                            Response.Redirect("homescreen.aspx");
                        }
                        else
                        {
                            // User does not exist or wrong credentials, show alert
                            ScriptManager.RegisterStartupScript(this, GetType(), "alertMessage",
                                "alert('Wrong credentials. Please try again.');", true);
                        }
                    }
                }
            }


        }

        protected void BtnSignup_Click(object sender, EventArgs e)
        {
            // Get values from the form
            string firstName = customerFirstName.Text;
            string lastName = customerLastName.Text;
            string email = customerEmail.Text;
            string password = customerPassword.Text;

            // Your SQL connection and command (adjust the connection string)
            using (SqlConnection connection = new SqlConnection("Data Source=HANIYATJ\\SQLEXPRESS;Initial Catalog=chasinglooks1;Integrated Security=True"))
            {
                connection.Open();

                // Create a parameterized SQL query to insert the data
                string query = "INSERT INTO Customer (First_name, Last_name, Email, Password1) " +
                               "VALUES (@FirstName, @LastName, @Email, @Password)";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@FirstName", firstName);
                    command.Parameters.AddWithValue("@LastName", lastName);
                    command.Parameters.AddWithValue("@Email", email);
                    command.Parameters.AddWithValue("@Password", password);

                    command.ExecuteNonQuery();
                }
            }

       

            customerFirstName.Text = string.Empty;
            customerLastName.Text = string.Empty;
            customerEmail.Text = string.Empty;


           
        }
    }
}
