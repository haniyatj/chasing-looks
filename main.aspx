<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="main.aspx.cs" Inherits="WebApplication5.main" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Welcome to Chasing Looks</title>
    <style>

        @import url('https://fonts.googleapis.com/css2?family=Calistoga&family=EB+Garamond:ital,wght@1,500&family=Elsie:wght@400;900&family=IBM+Plex+Sans:wght@600&family=Marcellus&family=Montserrat:wght@100;500&family=Outfit&family=Poppins:ital@1&family=Quattrocento&display=swap');
        body, html {
            margin: 0;
            padding: 0;
            background-color: rgb(241, 241, 241);
            font-family:Quattrocento;
           
        }
        #outer{
             display: flex;
            flex-direction: row;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
        }
        #left-container {
            flex: 1;
            margin: 20px;
        }

        #right-container {
            flex: 1;
            text-align: center;
             margin-right:90px;

        }

        .button-container {
            text-align: center;
            margin-top: 20px;
        }

        .shop-button, .admin-button {
            background-color: rgb(196, 176, 235);
            padding: 10px 30px;
            font-size: 18px;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
            display: inline-block;
            margin-left: 20px;
            color: black;
        }

        .shop-button:hover, .admin-button:hover {
            background-color:rgb(255,243,128);
        }

        img {
            width: 100%;
            height: auto;
            margin-top:8%;
        }

        h1 {
            text-align: center;
            margin-bottom: 20px;
            font-family:Elsie;
            font-size:40px;
        }
    </style>
</head>
<body>
    <form id="form2" runat="server">
        <div id="outer">
             <div id="left-container">
            <img src="https://fireartstudio.s3-accelerate.amazonaws.com/wp-content/uploads/2020/06/image_processing20200605-19846-1l4c5ys.gif" alt="Your GIF Alt Text" />
        </div>

        <div id="right-container">
            <div class="button-container">
                            <h1>Welcome to Chasing Looks</h1>

                <asp:HyperLink ID="shopButton" runat="server" CssClass="shop-button" NavigateUrl="signup.aspx" Text="Shop" OnServerClick="BtnShop_Click" />
                <asp:HyperLink ID="AdminButton" runat="server" CssClass="admin-button" NavigateUrl="adminlogin.aspx" Text="Admin" OnServerClick="BtnShop_Click" />
            </div>
        </div>

        </div>
       
    </form>
</body>
</html>
