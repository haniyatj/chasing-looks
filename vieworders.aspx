<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="vieworders.aspx.cs" Inherits="WebApplication5.vieworders" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>View Orders</title>
    <style>
       @import url('https://fonts.googleapis.com/css2?family=Calistoga&family=EB+Garamond:ital,wght@1,500&family=Elsie:wght@400;900&family=IBM+Plex+Sans:wght@600&family=Marcellus&family=Montserrat:wght@100;500&family=Outfit&family=Poppins:ital@1&family=Quattrocento&display=swap');

        body {
            margin: 0;
            padding: 0;
             font-family:Quattrocento;
            background-color: #f4f4f4;
        }

        form {
            max-width: 800px;
            margin: 20px auto;
            background-color: lightgray;
            padding: 20px;
            border-radius: 8px;
           box-shadow: 0 0 70px  rgb(255,243,128,3); 
            text-align: center;
        }

        h2 {
             color:rgb(57,68,87);
;
        }

        #GridViewOrders {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
            overflow-x: auto;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        #GridViewOrders th, #GridViewOrders td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }

        #GridViewOrders th {
           background-color: rgb(196,176,235);
            color: #fff;
        }

        #GridViewOrders tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        #GridViewOrders tr:hover {
            background-color: #e0e0e0;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>Order Details</h2>

            <asp:GridView ID="GridViewOrders" runat="server" AutoGenerateColumns="False">
                <Columns>
                    <asp:BoundField DataField="Order_ID" HeaderText="Order ID" SortExpression="Order_ID" />
                    <asp:BoundField DataField="Order_Quantity" HeaderText="Order Quantity" SortExpression="Order_Quantity" />
                    <asp:BoundField DataField="Order_Total_Price" HeaderText="Order Total Price" SortExpression="Order_Total_Price" />
                    <asp:BoundField DataField="OrderItem_ID" HeaderText="OrderItem ID" SortExpression="OrderItem_ID" />
                    <asp:BoundField DataField="OrderItem_Quantity" HeaderText="OrderItem Quantity" SortExpression="OrderItem_Quantity" />
                    <asp:BoundField DataField="OrderItem_Total_Price" HeaderText="OrderItem Total Price" SortExpression="OrderItem_Total_Price" />
                        <asp:BoundField DataField="ItemName" HeaderText="OrderItem ItemName" SortExpression="ItemName" />
                  <asp:BoundField DataField="sizeBought" HeaderText="OrderItem Total Price" SortExpression="sizeBought" />


                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
