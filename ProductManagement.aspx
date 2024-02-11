<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductManagement.aspx.cs" Inherits="WebApplication5.ProductManagement" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Product Management</title>
     <style>
         @import url('https://fonts.googleapis.com/css2?family=Calistoga&family=EB+Garamond:ital,wght@1,500&family=Elsie:wght@400;900&family=IBM+Plex+Sans:wght@600&family=Marcellus&family=Montserrat:wght@100;500&family=Outfit&family=Poppins:ital@1&family=Quattrocento&display=swap');
        body, html {
            margin: 0;
            padding: 0;
            background-color: rgb(241, 241, 241);
            font-family:Quattrocento;
           
        }
    

        form {
            max-width: 1000px;
            margin: 20px auto;
            background-color: lightgray;
            padding: 20px;
            border-radius: 8px;
            margin-left:16%;
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
            background-color: rgb(38,192,146);
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

        .productContainer {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
            margin-top: 20px;
        }

        .productItem {
            flex-basis: calc(33.33% - 20px);
            box-sizing: border-box;
            padding: 10px;
            background-color: rgb(196,176,235);
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        .productName {
            font-weight: bold;
            margin-bottom: 10px;
        }

                    .buttonContainer {
                display: flex;
                justify-content: space-between;
                margin-top: 6px;
            }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1>Product Management</h1>

            <label for="txtProductName">Front Image URL:</label>
            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
          
   <br />
            <label for="txtProductName">Back Image URL:</label>
            <asp:TextBox ID="TextBox6" runat="server" ></asp:TextBox>
            


            <div>
                <label for="txtProductName">Product Name:</label>
                <asp:TextBox ID="txtProductName" runat="server" CssClass="inputStyle"></asp:TextBox><br />

     
                 <label for="txtProductName">Quantity:</label>
                 <asp:TextBox ID="TextBox3" runat="server" CssClass="inputStyle"></asp:TextBox>

                  <label for="txtProductName"> Discount:</label>
                  <asp:TextBox ID="TextBox4" runat="server" CssClass="inputStyle"></asp:TextBox>

                 <label for="txtProductName">Description:</label>
                 <asp:TextBox ID="TextBox5" runat="server" CssClass="inputStyle"></asp:TextBox>
                <br />
                   <br />
                 
                  <label for="txtProductName">Category id</label>
                  <asp:TextBox ID="TextBox2" runat="server" CssClass="inputStyle"></asp:TextBox>
<br />
   <br />
 
               
                <label for="txtPrice">Price:</label>
                <asp:TextBox ID="txtPrice" runat="server" CssClass="inputStyle"></asp:TextBox>

                <div class="buttonContainer">

                <asp:Button ID="btnAddNewProduct" runat="server" Text="Add New Product" OnClick="BtnAddNewProduct_Click" CssClass="buttonStyle" />
                <asp:Button ID="btnRemoveProduct" runat="server" Text="Delete Product"  OnClick="OnDelete"   CssClass="buttonStyle"  />
                <asp:Button ID="btnUpdateProduct" runat="server" Text="Update Product" OnClick="onupdate" CssClass="buttonStyle" />
                    </div>
            </div>

            <hr />

         
            <br />

            <asp:Image ID="imgDisplay" runat="server" />
            <div class="productContainer" runat="server" id="productDisplayContainer"></div>
        </div>
    </form>
</body>
</html>
