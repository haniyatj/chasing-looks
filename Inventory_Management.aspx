<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Inventory_Management.aspx.cs" Inherits="WebApplication5.Inventory_Management" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Inventory Management</title>
    <style>
    @import url('https://fonts.googleapis.com/css2?family=Calistoga&family=EB+Garamond:ital,wght@1,500&family=Elsie:wght@400;900&family=IBM+Plex+Sans:wght@600&family=Marcellus&family=Montserrat:wght@100;500&family=Outfit&family=Poppins:ital@1&family=Quattrocento&display=swap');

       body {
            font-family:Quattrocento;
              background-color: #f4f4f4;
              margin: 0;
              padding: 0;
              text-align: center;
              background-size: cover;
              background-position: center -20%;  
            }

        form {
            max-width: 600px;
            margin: 50px auto;
             background-color: lightgray;
            padding: 40px;
            border-radius: 8px;
           box-shadow: 0 0 70px  rgb(255,243,128,3); 
        }

        h1 {
                color:rgb(57,68,87);
            font-size: 32px;
            margin-bottom: 20px;
              font-family:Elsie;
               border: 2px solid black;


        }

        h3 {
            color: #555;
            font-size: 18px;
            margin-bottom: 20px;
                       font-family:Elsie;

        }

        p {
                color:rgb(57,68,87);
            font-size: 16px;
            margin-bottom: 20px;
        }

        ul {
            list-style-type: none;
            padding: 0;
            margin: 20px 0;
                        font-family:Quattrocento;
                                                      font-weight: bold;


        }

        li {
            margin-bottom: 15px;
        }

        .linkStyle {
            display: inline-block;
            padding: 15px 30px;
            font-size: 18px;
            text-decoration: none;
            color: #fff;
            background-color:whitesmoke;
            border-radius: 8px;
            border:double;
             color: #000;
              margin-right: 10px;
               margin-bottom: 20px;
                                             font-weight: bold;

          /*  transition: background-color 0.3s;*/
        }

        .linkStyle:hover {
            background-color: #E6D7FF;
        }

        .stock-info {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }

        .stock-info div {
            flex: 1;
            text-align: left;
            background-color: #fff;
            padding: 10px;
            border-radius: 8px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px; /* Add margin to create space between divs */
        }

        .stock-info i {
            font-size: 24px;
            margin-right: 10px;
        }

        .buts {
            margin-left: 15px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        
            <h1>Welcome to Inventory Management</h1>
            <p>What would you like to manage?</p>
        <div>
            <ul>
                <asp:HyperLink ID="lnkCategoryManagement" runat="server" NavigateUrl="CategoryManagement.aspx" CssClass="linkStyle">Category Management</asp:HyperLink>
                <asp:HyperLink ID="lnkProductManagement" runat="server" NavigateUrl="ProductManagement.aspx" CssClass="linkStyle">Product Management</asp:HyperLink>
                <asp:HyperLink ID="lnkCustomerview" runat="server" NavigateUrl="ViewCustomers.aspx" CssClass="linkStyle">View Customers</asp:HyperLink>
                <asp:HyperLink ID="lnkvieworders" runat="server" NavigateUrl="vieworders.aspx" CssClass="linkStyle">View Orders</asp:HyperLink>
                 <asp:HyperLink ID="lnkviewreviews" runat="server" NavigateUrl="Reviews.aspx" CssClass="linkStyle">View Reviews</asp:HyperLink>
            </ul>

            <div class="stock-info">
    <div class="buts">
        <i class="fas-fa-box"></i>
        <span>Total Stock: <asp:Label ID="lblTotalStock" runat="server" Text="0"></asp:Label></span>
    </div>
    <div class="buts">
        <i class="fas fa-exclamation-triangle"></i>
        <span>Minimum Stock: 10 </span>
    </div>
</div>

        </div>
    </form>
</body>
</html>
