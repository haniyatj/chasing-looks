using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using static WebApplication5.product;
using Newtonsoft.Json;
using System.Globalization;
using System.Web.UI;

namespace WebApplication5
{
    public partial class checkout : System.Web.UI.Page
    {
        string connectionString = @"Data Source=HANIYATJ\SQLEXPRESS;Initial Catalog=chasinglooks1;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void BtnConfirmOrder_Click(object sender, EventArgs e)
        {
            if (Page.IsValid) // Check if the page is valid
            {
                // Call the ProcessOrder method
                ProcessOrder();
            }
        }

        private void ProcessOrder()
        {
            try

            {

                // Get customer information from form
                string firstName = txtFirstName.Text;
                string lastName = txtLastName.Text;
                string phoneNumber = txtPhoneNumber.Text;
                string houseNumber = txtHouseNumber.Text;
                string streetNumber = txtStreetNumber.Text;
                string state = txtState.Text;
                string email = txtEmail.Text;
                string paymentType = rbtnCashOnDelivery.Checked ? "COD" : "Card";



                // Insert customer information into the Customer table
                InsertCustomer(firstName, lastName, phoneNumber, houseNumber, streetNumber, state, email);

                // Get payment information from form
                string cardNumber = txtCardNumber.Text;
                string expirationDate = txtExpirationDate.Text;
                string cvv = txtCVV.Text;

                // Insert payment information into the Payment and CARD1 tables
                int customerId = GetCustomerId(email); // Get the customer ID for the foreign key
                int transactionId = InsertPayment(customerId, cardNumber, expirationDate, cvv, paymentType);

                //Change the method call to use dynamic[]
               var cartItems = RetrieveCartItems();

                //// Insert order information into Order1 and OrderItem tables
                int orderId = InsertOrder(customerId, cartItems);
                //// Insert order item information into the OrderItem table and update product quantity
                InsertOrderItems(orderId, customerId, cartItems);


                // Display success message or redirect to a confirmation page
                // Response.Write("<script>alert('Order confirmed!');</script>");

                txtFirstName.Text = string.Empty;
                txtLastName.Text = string.Empty;
                txtPhoneNumber.Text = string.Empty;
                txtHouseNumber.Text = string.Empty;
                txtStreetNumber.Text = string.Empty;
                txtState.Text = string.Empty;
                txtEmail.Text = string.Empty;
                txtCardNumber.Text = string.Empty;
                txtExpirationDate.Text = string.Empty;
                txtCVV.Text = string.Empty;

            }
            catch (Exception ex)
            {
                // Handle exceptions
                Response.Write($"<script>alert('Error: {ex.Message}');</script>");
            }
        }

        private void InsertCustomer(string firstName, string lastName, string phoneNumber, string houseNumber, string streetNumber, string state, string email)
        {

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Check if the email already exists
                string checkQuery = "SELECT COUNT(*) FROM Customer WHERE Email = @Email";
                using (SqlCommand checkCommand = new SqlCommand(checkQuery, connection))
                {
                    checkCommand.Parameters.AddWithValue("@Email", email);
                    int existingCount = Convert.ToInt32(checkCommand.ExecuteScalar());

                    if (existingCount > 0)
                    {
                        // Email already exists, update the existing record
                        string updateQuery = "UPDATE Customer " +
                                             "SET First_name = @FirstName, Last_name = @LastName, Phone_no = @PhoneNumber, " +
                                             "House_no = @HouseNumber, StreetNo = @StreetNumber, State1 = @State " +
                                             "WHERE Email = @Email";

                        using (SqlCommand updateCommand = new SqlCommand(updateQuery, connection))
                        {
                            updateCommand.Parameters.AddWithValue("@FirstName", firstName);
                            updateCommand.Parameters.AddWithValue("@LastName", lastName);
                            updateCommand.Parameters.AddWithValue("@PhoneNumber", phoneNumber);
                            updateCommand.Parameters.AddWithValue("@HouseNumber", houseNumber);
                            updateCommand.Parameters.AddWithValue("@StreetNumber", streetNumber);
                            updateCommand.Parameters.AddWithValue("@State", state);
                            updateCommand.Parameters.AddWithValue("@Email", email);

                            updateCommand.ExecuteNonQuery();
                        }
                    }
                    else
                    {
                        
                    }
                }
            }
        }



        private int GetCustomerId(string email)
        {
            // Retrieve the customer ID based on the email
            // You may want to add error handling and check if the email exists in the database
            // This is a simplified example
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string query = "SELECT Customer_id FROM Customer WHERE Email = @Email";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Email", email);
                    object result = command.ExecuteScalar();
                    if (result != null)
                    {
                        return Convert.ToInt32(result);
                    }
                }
            }
            return -1; // Return -1 if the customer ID is not found (you should handle this case appropriately)
        }

        private int InsertPayment(int customerId, string cardNumber, string expirationDate, string cvv,string paymentType)
        {
            // Insert payment information into the Payment table
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string query = "INSERT INTO Payment (Customer_id, Amount, Payment_Status,Payment_Type) " +
                               "VALUES (@CustomerId, @Amount, @PaymentStatus, @PaymentType); " +
                               "SELECT SCOPE_IDENTITY()"; // Retrieve the last inserted identity value
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@CustomerId", customerId);
                    // You may need to adjust the amount and payment status based on your requirements
                    var cartItems = RetrieveCartItems();
                    decimal subtotal = cartItems.Sum(item => item.totalPrice);

                    // Apply tax to the subtotal
                    // Example tax rate (10%)
                    decimal taxAmount = subtotal * (decimal)0.1;
                    decimal totalAmount = subtotal + taxAmount;

                    command.Parameters.AddWithValue("@Amount", totalAmount); // Placeholder for amount

                    if (paymentType.Equals("COD", StringComparison.OrdinalIgnoreCase))
                    {
                        command.Parameters.AddWithValue("@PaymentStatus", "Pending");
                    }
                    else
                    {
                        command.Parameters.AddWithValue("@PaymentStatus", "Successful");
                    }

                    command.Parameters.AddWithValue("@PaymentType", paymentType); // Add payment type parameter

                    int transactionId = Convert.ToInt32(command.ExecuteScalar());

                    if (paymentType.Equals("Card", StringComparison.OrdinalIgnoreCase))
                    {
                        // Insert card information into the CARD1 table
                        InsertCardInformation(transactionId, cardNumber, expirationDate, cvv);
                    }

                    return transactionId;
                }
            }
        }

        private void InsertCardInformation(int transactionId, string cardNumber, string expirationDate, string cvv)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string query = "INSERT INTO CARD1 (Transaction_id, CardNumber, ExpirationDate, CVV) " +
                               "VALUES (@TransactionId, @CardNumber, @ExpirationDate, @CVV)";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@TransactionId", transactionId);
                    command.Parameters.AddWithValue("@CardNumber", cardNumber);

                    // Parse the expiration date and format it as 'YYYY-MM-DD'
                    if (DateTime.TryParseExact(expirationDate, "yyyy-MM-dd", CultureInfo.InvariantCulture, DateTimeStyles.None, out DateTime parsedExpirationDate))
                    {
                        command.Parameters.AddWithValue("@ExpirationDate", parsedExpirationDate.ToString("yyyy-MM-dd"));
                    }
                    else
                    {
                        // Handle the case where parsing fails (perhaps log an error or throw an exception)
                        // For now, let's use a default value or set it to null
                        command.Parameters.AddWithValue("@ExpirationDate", DBNull.Value);
                    }

                    command.Parameters.AddWithValue("@CVV", cvv);
                    command.ExecuteNonQuery();
                }
            }
        }


        // Change the method signature to accept an array of dynamic objects
        private int InsertOrder(int customerId, dynamic[] cartItems)
        {
            // Calculate total quantity and total price from cart items
            int totalQuantity = cartItems.Sum(item => item.quantity);
            decimal subtotal = cartItems.Sum(item => item.totalPrice - (item.totalPrice * (item.loyaltyDiscount / 100)));


            // Apply tax to the subtotal
            // Example tax rate (10%)
            decimal taxAmount = subtotal * (decimal)0.1;
            decimal totalPrice = subtotal + taxAmount;

            // Insert order information into the Order1 table
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string query = "INSERT INTO Order1 (Order_Quantity, Total_Price, Customer_ID) " +
                                "VALUES (@OrderQuantity, @TotalPrice, @CustomerId); " +
                                "SELECT SCOPE_IDENTITY()"; // Retrieve the last inserted identity value
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@OrderQuantity", totalQuantity);
                    command.Parameters.AddWithValue("@TotalPrice", totalPrice);
                    command.Parameters.AddWithValue("@CustomerId", customerId);
                    int orderId = Convert.ToInt32(command.ExecuteScalar());

                    // Insert order item information into the OrderItem table

                    return orderId;
                }
            }
        }

        private void InsertOrderItems(int orderId, int customerId, dynamic[] cartItems)
        {
            // Insert order item information into the OrderItem table and update product quantity
            string queryInsertOrderItem = "INSERT INTO OrderItem (Quantity, Total_Price,ItemName, Size, Order_ID) " +
                                          "VALUES (@Quantity, @TotalPrice,@ItemName, @Size, @OrderId)";
            string queryUpdateProductQuantity = "UPDATE Product SET Quantity = Quantity - @Quantity WHERE Product_name = @ProductName";


            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                using (SqlTransaction transaction = connection.BeginTransaction())
                {
                    try
                    {
                        using (SqlCommand commandInsertOrderItem = new SqlCommand(queryInsertOrderItem, connection, transaction))
                        using (SqlCommand commandUpdateProductQuantity = new SqlCommand(queryUpdateProductQuantity, connection, transaction))
                        {
                            foreach (var cartItem in cartItems)
                            {
                                // Assuming that the properties are named quantity, totalPrice, and productName
                                int quantity = cartItem.quantity;
                                decimal totalPrice = cartItem.totalPrice;
                                string productName = cartItem.productName;
                                string size = cartItem.size;

                                decimal loyaltyDiscount = cartItem.loyaltyDiscount ?? 0;
                                decimal discountedPrice = cartItem.totalPrice - (cartItem.totalPrice * (loyaltyDiscount / 100));

                                // Insert order item
                                commandInsertOrderItem.Parameters.Clear();
                                commandInsertOrderItem.Parameters.AddWithValue("@Quantity", quantity);
                                commandInsertOrderItem.Parameters.AddWithValue("@TotalPrice", discountedPrice);
                                commandInsertOrderItem.Parameters.AddWithValue("@OrderId", orderId);
                                commandInsertOrderItem.Parameters.AddWithValue("@ItemName", productName);
                                commandInsertOrderItem.Parameters.AddWithValue("@Size", size);
                                commandInsertOrderItem.ExecuteNonQuery();

                                // Update product quantity
                                commandUpdateProductQuantity.Parameters.Clear();
                                commandUpdateProductQuantity.Parameters.AddWithValue("@Quantity", quantity);
                                commandUpdateProductQuantity.Parameters.AddWithValue("@ProductName", productName);
                                commandUpdateProductQuantity.ExecuteNonQuery();
                            }

                            // Commit the transaction if everything is successful
                            transaction.Commit();
                        }
                    }
                    catch (Exception)
                    {
                        // An error occurred, rollback the transaction
                        transaction.Rollback();
                        throw; // Rethrow the exception to handle it at a higher level
                    }
                }
            }
        }


        // Retrieve cart items from local storage and pass it to the modified method
        private dynamic[] RetrieveCartItems()
        {
            var cartItemsJson = hdnCartItems.Value;
            var cartItems = JsonConvert.DeserializeObject<dynamic[]>(cartItemsJson) ?? new dynamic[0];

            System.Diagnostics.Debug.WriteLine("Cart Items:");
            foreach (var item in cartItems)
            {
                System.Diagnostics.Debug.WriteLine($"Item: {item}");
            }

            return cartItems;
        }




    }
}
