<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="category.aspx.cs" Inherits="WebApplication5.category" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Product Page</title>
    <style>
            @import url('https://fonts.googleapis.com/css2?family=Calistoga&family=EB+Garamond:ital,wght@1,500&family=Elsie:wght@400;900&family=IBM+Plex+Sans:wght@600&family=Marcellus&family=Montserrat:wght@100;500&family=Outfit&family=Poppins:ital@1&family=Quattrocento&display=swap');

       body {
            font-family:Quattrocento;
            margin: 0;
            padding: 0;
            background-color: rgb(241,241,241);
        }

        #searchBar {
                                
           background-color: rgb(196,176,235);
            color: #fff;
            padding: 10px;
            text-align: center;
            display:flex;
     
            justify-content: flex-end; 
            align-items: center;

        }

        #categories {
            display: flex;
            flex-direction:row;
            align-items: center;
            padding: 10px;
            background-color: #ecf0f1;
           margin-top:20px;
        }

        .category-box {
            text-align: center;
            margin-left:15%;
        }

        .category-box img {
            width: 90px;
            height: 90px;
            border-radius: 50%;
            cursor: pointer;
            border: 2px solid rgb(38,192,146)

        }

        .category-label {
            margin-top: 10px;
        }

        #products {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
            padding: 20px;
        }

        .product-box {
            width: 17%;
            margin-bottom: 20px;
            background-color: floralwhite;

            border-radius: 8px;
            overflow: hidden;
            cursor: pointer;
        }

        .product-box img {
            width: 50%;
            height: 200px;
            object-fit: cover;
            border-bottom: 1px solid #ddd;
            margin-left:20%;
        }

         .product-box:hover {
            box-shadow: 0 4px 8px  rgb(255,243,128,3); 
        }

        .product-info {
            padding: 10px;
        }

        .product-info h3 {
            margin: 0;
        }
      
 
        #text{
            width:15%;
            height:30px;
             margin-right:10px;
           background-color: rgb(196,176,235);
           margin-top:4px;
            border: none;
            border-bottom: 2px solid black; 
            outline: none; 
        }

            #text::placeholder {
            padding-left: 30px;
            background-image: url('https://img.icons8.com/android/24/000000/search.png'); 
            background-size: 20px;
            background-repeat: no-repeat;
            background-position: left center;
            color:black;
             font-family:Elsie;
            font-size:20px;
        }

        .cartpopup {
            display: none;
            position: fixed;
           top: 10px;
        right: 10px;
            background-color: #fff;
            padding: 30px;
            border: 1px solid #ddd;
            border-radius: 8px;
           

        }

        #closePopup {
            position: absolute;
            top: 10px;
            right: 10px;
            cursor: pointer;
        }


   
        .formLabel, .formValue {
            display: table-cell;
            padding: 5px;
            border-bottom: 1px solid #ddd;
        }

        #checkoutButton {
            margin-top: 10px;
            background-color:rgb(38,192,146);
            color: black;
            padding: 10px;
            border: 2px solid black ;
            border-radius: 4px;
            cursor: pointer;
            margin-left:30px;
        }

         .cartpopup a {
    position: absolute;
    top: 10px;
    left: 10px;
    color: rgb(52,82,93);
    text-decoration: none;
    font-size: 20px;
    cursor: pointer;
}

       #cartLink {
        text-decoration: none; 
    }

    #cartLink img {
          width: 40px; 
        height: 40px;  
         margin-right: 10px;
    }


        #sortDropdown {
            display: flex;
            align-items: center;
            margin-left: 10px; /* Adjust the margin as needed */
            margin-right:20px;

        }

        #sortOptions {
            padding: 8px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 4px;
            cursor: pointer;
                      background-color: rgb(196,176,235);

        }

        /* Style the arrow of the dropdown */
        #sortOptions::after {
            content: '\25BC'; /* Unicode character for down arrow */
            margin-left: 5px;
        }

        /* Style dropdown options */
        #sortOptions option {
            background-color: #fff;
            color: #000;
        }

        /* Style the selected option */
        #sortOptions option:checked {
            background-color: #3498db; /* Adjust the color as needed */
            color: #fff;
        }

    </style>


    

</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server"></asp:ScriptManager>
        <div id="searchBar">

              <div id="sortDropdown">
            <asp:DropDownList ID="sortOptions" runat="server">
                <asp:ListItem Text="Sort By" Value="" Disabled="true" Selected="true"></asp:ListItem>
                <asp:ListItem Text="Highest Price" Value="highestPrice"></asp:ListItem>
                <asp:ListItem Text="Lowest Price" Value="lowestPrice"></asp:ListItem>
                <asp:ListItem Text="Highest Reviews" Value="highestReviews"></asp:ListItem>
                <asp:ListItem Text="Lowest Reviews" Value="lowestReviews"></asp:ListItem>
            </asp:DropDownList>
              </div>
              <input type="text"  id="text" placeholder="Search" onkeypress="handleKeyPress(event)" />

             <a id="cartLink" href="javascript:void(0);" class="cart-icon" runat="server" >
                    <img src="icon.png" alt="Cart Icon" />
              </a>            
        </div>


          <div id="products"  runat="server">
       
            </div>


           
       <asp:Panel ID="cartPopup" CssClass="cartpopup" runat="server" Style="display: none;">
            <a href="javascript:void(0);" onclick="toggleCartPopup();">×</a>

          <asp:Table ID="orderTable" runat="server" Width="100%">
        <asp:TableRow CssClass="formRow">
            <asp:TableCell CssClass="formLabel">Item Name</asp:TableCell>
            <asp:TableCell CssClass="formValue">Product 1</asp:TableCell>
        </asp:TableRow>

        <asp:TableRow CssClass="formRow">
            <asp:TableCell CssClass="formLabel">Quantity</asp:TableCell>
            <asp:TableCell CssClass="formValue">2</asp:TableCell>
        </asp:TableRow>

        <asp:TableRow CssClass="formRow">
            <asp:TableCell CssClass="formLabel">Total Price</asp:TableCell>
            <asp:TableCell CssClass="formValue">$75.98</asp:TableCell>
        </asp:TableRow>
    </asp:Table>

       <asp:Button ID="checkoutButton" runat="server" Text="Checkout"  />
        </asp:Panel>


    </form>


    <script type="text/javascript">
        document.getElementById('<%= cartLink.ClientID %>').addEventListener('click', toggleCartPopup);

        function toggleCartPopup() {
            var cartPopup = document.getElementById('<%= cartPopup.ClientID %>');
            if (cartPopup.style.display === 'none' || cartPopup.style.display === '') {
                cartPopup.style.display = 'block';
            } else {
                cartPopup.style.display = 'none';
            }
        }


        function handleKeyPress(event) {
            if (event.key === 'Enter') {
                // Call your search function here
                searchFunction();
            }
        }

        function searchFunction() {
            // Replace this with your actual search logic
            alert('Search triggered!');
        }

        function handleSortChange() {
            var selectedOption = document.getElementById('sortOptions').value;
            // You can add logic to handle the sorting based on the selected option
            // For now, let's just display an alert with the selected option
            alert('Sort By: ' + selectedOption);
        }

    </script>
</body>
</html>

