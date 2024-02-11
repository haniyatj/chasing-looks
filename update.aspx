<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="update.aspx.cs" Inherits="WebApplication5.update" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Product Management</title>
    <style>
     @import url('https://fonts.googleapis.com/css2?family=Calistoga&family=EB+Garamond:ital,wght@1,500&family=Elsie:wght@400;900&family=IBM+Plex+Sans:wght@600&family=Marcellus&family=Montserrat:wght@100;500&family=Outfit&family=Poppins:ital@1&family=Quattrocento&display=swap');

        body {
            font-family:Quattrocento;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            text-align: center;
        }

        form {
            max-width: 1000px;
            margin: 20px auto;
            background-color:lightgray;
            padding: 20px;
            border-radius: 8px;
           box-shadow: 0 0 70px  rgb(255,243,128,3); 
        }

        h1 {
             color:rgb(57,68,87);
                text-align: center; 
                margin-top:3%; 
            margin-bottom:30px;
           font-family:Elsie;
            border: 2px solid black;

        }

        #form1 div {
            text-align: left;
        }

        #form1 div > * {
            margin-bottom: 10px;
        }

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .inputStyle {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .dropdownStyle {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .buttonStyle {
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            background-color: rgb(254,217,217);
            color: black;
            border:double;
            border-radius: 4px;
            margin: 20px auto; 
            display: block; 
            transition: background-color 0.3s;
                font-family:Quattrocento;
                font-weight: bold;

        }

        .buttonStyle:hover {
            background-color: rgb(255,243,128);
        }

        .listBoxStyle {
            width: 100%;
            padding: 10px;
            font-size: 16px;
        }

        .productImage {
            max-width: 100%;
            height: 400px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1>UPDATE PRODUCT</h1>

           
           
            <label for="txtProductName">Front Image URL:</label>
            <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox> <br />
            <label for="txtProductName">Back Image URL:</label>
            <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox><br />

            <div>
                <label for="txtProductName">Product ID:</label>
                        <asp:TextBox ID="TextBox5" runat="server" CssClass="inputStyle"></asp:TextBox>

                        <br />
                <label for="txtProductName">Product Name:</label>
                <asp:TextBox ID="txtProductName" runat="server" CssClass="inputStyle"></asp:TextBox>
                 
                <label for="txtProductName">Product Description :</label>
                <asp:TextBox ID="TextBox2" runat="server" CssClass="inputStyle"></asp:TextBox>

                <br />
                <label for="txtProductName">Discount:</label>
                <asp:TextBox ID="TextBox6" runat="server" CssClass="inputStyle"></asp:TextBox>

                <br />
                <label for="ddlCategory">Category:</label>
                <asp:TextBox ID="TextBox1" runat="server" CssClass="inputStyle"></asp:TextBox>
                <br />
               
                <label for="txtPrice">Price:</label>
                <asp:TextBox ID="txtPrice" runat="server" CssClass="inputStyle"></asp:TextBox>
                <asp:Button ID="btnUpdateProduct" runat="server" Text="Update Product" OnClick="btnUpdateProduct_Click" CssClass="buttonStyle" />
            </div>

            <hr />

           

            <br />
        </div>
    </form>
</body>
</html>