<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Reviews.aspx.cs" Inherits="WebApplication5.Reviews" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Reviews</title>
    <style>
               @import url('https://fonts.googleapis.com/css2?family=Calistoga&family=EB+Garamond:ital,wght@1,500&family=Elsie:wght@400;900&family=IBM+Plex+Sans:wght@600&family=Marcellus&family=Montserrat:wght@100;500&family=Outfit&family=Poppins:ital@1&family=Quattrocento&display=swap');

        body {
           font-family:Quattrocento;
            background-color: #f4f4f4;
            margin: 0;
        }

        form {
            max-width: 900px;
            margin: 20px auto;
            background-color: lightgray;
            padding: 20px;x
            border-radius: 5px;
           box-shadow: 0 0 70px  rgb(255,243,128,3); 
        }

        #GridViewReviews {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
        }

        #GridViewReviews th, #GridViewReviews td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }

        #GridViewReviews th {
           background-color: rgb(196,176,235);
            color: #fff;
        }

        #GridViewReviews tr:nth-child(even) {
            background-color: #f9f9f9
        }

        #GridViewReviews tr:hover {
            background-color: #e0e0e0;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:GridView ID="GridViewReviews" runat="server" AutoGenerateColumns="False">
                <Columns>
                    <asp:BoundField DataField="Review_ID" HeaderText="Review ID" SortExpression="Review_ID" />
                    
                    <asp:BoundField DataField="Size" HeaderText="Size" SortExpression="Size" />
                    <asp:BoundField DataField="Content" HeaderText="Content" SortExpression="Content" />
                    <asp:BoundField DataField="ProductID" HeaderText="Product ID (Product)" SortExpression="ProductID" />
                    <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price" />
                    <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity" />
                    <asp:BoundField DataField="Product_name" HeaderText="Product Name" SortExpression="Product_name" />
                    <asp:BoundField DataField="Descriptionn" HeaderText="Description" SortExpression="Descriptionn" />
                    <asp:BoundField DataField="Loyalty_discount" HeaderText="Loyalty Discount" SortExpression="Loyalty_discount" />
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
