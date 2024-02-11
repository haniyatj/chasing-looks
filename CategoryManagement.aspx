
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CategoryManagement.aspx.cs" Inherits="WebApplication5.CategoryManagement" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Category Management</title>
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
             width: 1700px;
  max-width: 1700px;
  flex-direction: row;
  margin: 20px auto;
  background-color: lightgray;
  padding: 20px;
  border-radius: 8px;
  box-shadow: 0 0 70px rgba(0, 0, 0, 0.6);
}

        h1, h2 {
           color:rgb(57,68,87);
            font-family:Elsie;


        }

        p {
            color: #555;
            margin-bottom: 20px;
        }

        #form1 div {
            text-align: left;
            
        }

        #form1 div > * {
            margin-bottom: 10px;
        }

        .inputStyle {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .buttonStyle {

            width: 100%;
            padding: 10px 20px;
            margin-left:0%;
            font-size: 16px;
            cursor: pointer;
            background-color: rgb(254,217,217);
            color: black;
            border: double;
            border-radius: 4px;
            transition: background-color 0.3s;
              font-family:Quattrocento;
                              font-weight: bold;


            
        }

        .buttonStyle:hover {
            background-color: rgb(38,192,146);
        }

        .panelStyle {
            margin-top: 20px;
          

        }

        .listStyle {
            list-style-type: none;
            padding: 0;
            margin: 0;
        }

        .listStyle li {
            margin-bottom: 10px;
        }

        .listBoxStyle {
            width: 100%;
            padding: 10px;
            font-size: 16px;
        }
         .productImage {
          max-width: 100%;
          height: 200px;
          margin-bottom: 20px;

            }
         .hoodie{
             max-width: 100%;
             height: 150px;
             margin-bottom: 20px;

         }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1>Category Management</h1>
            <asp:TextBox ID="txtNewCategory" runat="server" placeholder="Enter new category" CssClass="inputStyle" OnClick="btnAddCategory_Click"></asp:TextBox>
            <asp:TextBox ID="txtNewCategoryImage" runat="server" placeholder="Enter image URL" CssClass="inputStyle"></asp:TextBox>

            <asp:Button ID="btnAddCategory" runat="server" Text="ADD NEW CATEGORY" OnClick="btnAddCategory_Click" CssClass="buttonStyle" />
           <!--<img src="Productt.jpg" alt="Sample Product" class="productImage" />
            <asp:Panel ID="pnlProducts" runat="server" Visible="false" CssClass="panelStyle">
                <h2>Products in Selected Category </h2>
                <p>Quantity: 600</p>
                <asp:Label ID="lblSelectedCategory" runat="server" Text=""></asp:Label>
                <ul>
                    <li>T-Shirt </li>
                    <p>Quantity: 150</p>
                     <img src="tshirt.jpg" alt="Sample Product" class="productImage" />
                    <li>Hoodie</li>
                    <p>Quantity: 250</p>
                    <img src="hoodie.jpg" alt="Sample Product" class="hoodie" />
                    <li>Jeans</li>
                    <p>Quantity: 200</p>
                    <img src="jeans.jpg" alt="Sample Product" class="productImage" />
                </ul>
            </asp:Panel>
            -->
            <h2>Categories</h2>
                <asp:ListBox ID="lstCategories" runat="server" AutoPostBack="true" OnSelectedIndexChanged="lstCategories_SelectedIndexChanged" CssClass="listBoxStyle">
                <asp:ListItem Text="Tops " Value="Tops"></asp:ListItem>
                    
                <asp:ListItem Text="Jackets" Value="Jackets"></asp:ListItem>
                  
                <asp:ListItem Text="Bottoms" Value="Bottoms"></asp:ListItem>
                    
            </asp:ListBox>
        </div>
            <div>
        <asp:GridView ID="gvProducts" runat="server" AutoGenerateColumns="true" >
            
             <Columns>
   
        <asp:CommandField ShowSelectButton="False" />
    </Columns>
       </asp:GridView>
    </div>
    </form>

</body>
</html>