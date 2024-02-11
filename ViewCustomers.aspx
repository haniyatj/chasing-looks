<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewCustomers.aspx.cs" Inherits="WebApplication5.ViewCustomers" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>View Customers</title>
    <style>
      @import url('https://fonts.googleapis.com/css2?family=Calistoga&family=EB+Garamond:ital,wght@1,500&family=Elsie:wght@400;900&family=IBM+Plex+Sans:wght@600&family=Marcellus&family=Montserrat:wght@100;500&family=Outfit&family=Poppins:ital@1&family=Quattrocento&display=swap');

        body {
           font-family:Quattrocento;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        form {
             max-width: 900px;
          margin: 20px auto;
          background-color: lightgray;
          padding: 20px;
          border-radius: 5px;
           box-shadow: 0 0 70px  rgb(255,243,128,3); 
                }

        h2 {
            color:rgb(57,68,87);

            margin-bottom: 10px;
        }

        .grid-container {
            margin-top: 10px;
        }

        /* Style for GridView */
        .gridview {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.8);
        }

        .gridview th, .gridview td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }

        .gridview th {
           background-color: rgb(196,176,235);
            font-weight: bold;
        }

        .gridview tr:hover {
            background-color: #f5f5f5;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>Customer Details</h2>
            <asp:GridView ID="gvCustomers" runat="server" AutoGenerateColumns="False" DataKeyNames="Customer_id" CssClass="gridview">
                <Columns>
                    <asp:BoundField DataField="Customer_id" HeaderText="Customer ID" ReadOnly="True" SortExpression="Customer_id" />
                    <asp:BoundField DataField="StreetNo" HeaderText="Street No" SortExpression="StreetNo" />
                    <asp:BoundField DataField="House_no" HeaderText="House No" SortExpression="House_no" />
                    <asp:BoundField DataField="Password1" HeaderText="Password" SortExpression="Password1" />
                    <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                    <asp:BoundField DataField="First_name" HeaderText="First Name" SortExpression="First_name" />
                    <asp:BoundField DataField="Last_name" HeaderText="Last Name" SortExpression="Last_name" />
                    <asp:BoundField DataField="Phone_no" HeaderText="Phone No" SortExpression="Phone_no" />
                </Columns>
            </asp:GridView>

            <h2>Payment Details</h2>
            <asp:GridView ID="gvPayments" runat="server" AutoGenerateColumns="False" DataKeyNames="Transaction_id" CssClass="gridview">
                <Columns>
                    <asp:BoundField DataField="Transaction_id" HeaderText="Transaction ID" ReadOnly="True" SortExpression="Transaction_id" />
                    <asp:BoundField DataField="Payment_date" HeaderText="Payment Date" SortExpression="Payment_date" />
                    <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount" />
                    <asp:BoundField DataField="Customer_id" HeaderText="Customer ID" SortExpression="Customer_id" />
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>

