using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Globalization;
using System.Web.UI;

namespace WebApplication5
{
    public partial class Analytics : System.Web.UI.Page
    {
        string connectionstring = @"Data Source=HANIYATJ\SQLEXPRESS;Initial Catalog=chasinglooks1;Integrated Security=True";
        float avg;
        float revenue;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DisplayOrderDetails();
                DisplayCustomerDetails();
                DisplayTotalRevenue();
                DisplayAverageOrderValue();
                DisplaySalesChart();
                DisplayProfitsChart();
                CalculateAndInsertData();
                // Add other code as needed for initialization
            }
        }

        private void DisplayOrderDetails()
        {
            using (SqlConnection conn = new SqlConnection(connectionstring))
            {
                conn.Open();

                string query = "SELECT COUNT(*) FROM Order1";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    int numberOfOrders = (int)cmd.ExecuteScalar();

                    // Display the number of orders (you can customize this part)
                    lblNumberOfOrders.Text = $"Number of Orders: {numberOfOrders}";
                }
            }
        }

        private void DisplayCustomerDetails()
        {
            using (SqlConnection conn = new SqlConnection(connectionstring))
            {
                conn.Open();

                string query = "SELECT COUNT(*) FROM Customer";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    int numberOfCustomers = (int)cmd.ExecuteScalar();

                    // Display the number of customers (you can customize this part)
                    lblNumberOfCustomers.Text = $"Number of Customers: {numberOfCustomers}";
                }
            }
        }

        private void DisplayTotalRevenue()
        {
            using (SqlConnection conn = new SqlConnection(connectionstring))
            {
                conn.Open();

                string query = "SELECT SUM(Total_Price) FROM Order1";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    object totalRevenue = cmd.ExecuteScalar();

                    if (totalRevenue != DBNull.Value)
                    {
                        // Display the total revenue (you can customize this part)
                        lblTotalRevenue.Text = $"Total Revenue: ${totalRevenue:N2}";

                    }
                    else
                    {
                        lblTotalRevenue.Text = "Total Revenue: $0.00";
                    }
                }
            }
        }

        private void DisplayAverageOrderValue()
        {
            using (SqlConnection conn = new SqlConnection(connectionstring))
            {
                conn.Open();

                string query = "SELECT AVG(Total_Price) FROM Order1";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    object averageOrderValue = cmd.ExecuteScalar();

                    if (averageOrderValue != DBNull.Value)
                    {
                        // Display the average order value (you can customize this part)
                        lblAverageOrderValue.Text = $"Average Order Value: ${averageOrderValue:N2}";
                    }
                    else
                    {
                        lblAverageOrderValue.Text = "Average Order Value: $0.00";
                    }
                }
            }
        }

        private List<decimal> GetSalesData()
        {
            List<decimal> salesData = new List<decimal>();

            using (SqlConnection conn = new SqlConnection(connectionstring))
            {
                conn.Open();

                string query = "SELECT Total_Price FROM Order1";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            decimal totalSales = Convert.ToDecimal(reader["Total_Price"]);
                            salesData.Add(totalSales);
                        }
                    }
                }
            }

            return salesData;
        }

        private Dictionary<string, decimal> GetProfitsData()
        {
            Dictionary<string, decimal> profitsData = new Dictionary<string, decimal>();

            using (SqlConnection conn = new SqlConnection(connectionstring))
            {
                conn.Open();

                string query = "SELECT FORMAT(Payment_date, 'yyyy-MM') AS MonthYear, SUM(Amount) AS TotalProfit " +
                               "FROM Payment " +
                               "GROUP BY FORMAT(Payment_date, 'yyyy-MM')";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            string monthYear = reader["MonthYear"].ToString();
                            decimal totalProfit = Convert.ToDecimal(reader["TotalProfit"]);
                            profitsData.Add(monthYear, totalProfit);
                        }
                    }
                }
            }

            return profitsData;
        }

        private void DisplayProfitsChart()
        {
            Dictionary<string, decimal> profitsData = GetProfitsData();

            // Generate JavaScript code to display the profits chart
            string profitsDataJson = new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(profitsData);

            string script = $@"
    var profitsData = {profitsDataJson};
    var profitsChartCanvas = document.getElementById('profitsChart').getContext('2d');
    var profitsChart = new Chart(profitsChartCanvas, {{
        type: 'bar',
        data: {{
            labels: Object.keys(profitsData),
            datasets: [{{
                label: 'Total Profits',
                data: Object.values(profitsData),
                backgroundColor: 'rgba(192, 75, 192, 0.2)',
                borderColor: 'rgba(192, 75, 192, 1)',
                borderWidth: 1
            }}]
        }},
        options: {{
            scales: {{
                x: {{
                    type: 'category',
                    position: 'bottom'
                }}
            }}
        }}
    }});
";

            // Register the JavaScript code on the page
            ScriptManager.RegisterStartupScript(this, GetType(), "displayProfitsChart", script, true);
        }



        private void DisplaySalesChart()
        {
            List<decimal> salesData = GetSalesData();

            // Generate JavaScript code to display the sales chart
            string salesDataJson = new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(salesData);

            string script = $@"
    var salesData = {salesDataJson};
    var salesChartCanvas = document.getElementById('salesChart').getContext('2d');
    var salesChart = new Chart(salesChartCanvas, {{
        type: 'bar',
        data: {{
            labels: salesData.map((_, index) => index + 1),
            datasets: [{{
                label: 'Total Sales',
                data: salesData,
                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                borderColor: 'rgba(75, 192, 192, 1)',
                borderWidth: 1
            }}]
        }},
        options: {{
            scales: {{
                x: {{
                    type: 'linear',
                    position: 'bottom',
                    stepSize: 1, // Set the step size to 1
                    beginAtZero: true // Start the axis from zero
                }}
            }}
        }}
    }});
";

            // Register the JavaScript code on the page
            ScriptManager.RegisterStartupScript(this, GetType(), "displaySalesChart", script, true);
        }


        private void CalculateAndInsertData()
        {
            // Calculate profits data
            Dictionary<string, decimal> profitsData = GetProfitsData();

            // Calculate sales data
            List<decimal> salesData = GetSalesData();

            // Insert data into the reportt table
            using (SqlConnection conn = new SqlConnection(connectionstring))
            {
                conn.Open();

                // Insert profits data
                foreach (var kvp in profitsData)
                {
                    InsertReportData(conn, kvp.Key, "Profits", kvp.Value);
                }

                // Insert sales data
                foreach (decimal totalSales in salesData)
                {
                    InsertReportData(conn, DateTime.Now.ToString("yyyy-MM"), "Sales", totalSales);
                }
            }
        }

        private void InsertReportData(SqlConnection conn, string monthYear, string reportType, decimal value)
        {
            string insertQuery = "INSERT INTO reportt (Report_type, created_date, total_revenue) " +
                                 "VALUES (@ReportType, @CreatedDate, @TotalRevenue)";

            using (SqlCommand cmd = new SqlCommand(insertQuery, conn))
            {
                cmd.Parameters.AddWithValue("@ReportType", reportType);
                cmd.Parameters.AddWithValue("@CreatedDate", DateTime.ParseExact(monthYear, "yyyy-MM", CultureInfo.InvariantCulture));

                cmd.Parameters.AddWithValue("@TotalRevenue", value);

                cmd.ExecuteNonQuery();
            }
        }


    }


}