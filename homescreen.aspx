<%@ Page Language="C#" AutoEventWireup="true"  CodeBehind="homescreen.aspx.cs" Inherits="WebApplication5.homescreen" %>

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
           margin-left:26%;
        }

        .category-box {
            text-align: center;
            margin-left:5%;
    margin-right: 15px; 
    display:flex;
    flex-direction:column;
    
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
    font-size: 14px; 
        }

        #products {
            display: grid;
    grid-template-columns: repeat(4, 1fr); /* Creates 4 equal-width columns */
    gap: 20px; /* Adjust the gap between columns */
    justify-content: space-around;
    padding: 20px;
        }

        .product-box {
            width:70%; /* Adjust the width as needed */
                margin: 0 1%;
                margin-bottom: 20px;
            background-color: floralwhite;

            border-radius: 8px;
            overflow: hidden;
            cursor: pointer;
             height: 300px;
             margin-top:2%;

        }

        .product-box img {
            height: 70%;
            border-bottom: 1px solid #ddd;
            margin-left:20%;
            width:50%;
            object-fit:cover;
        }

         .product-box:hover {
            box-shadow: 0 4px 8px  rgb(255,243,128,3); 
        }

        .product-info {
            padding: 10px;
        }

        .product-info h3 {
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

              <div id="sortDropdown" >
            <asp:DropDownList ID="sortOptions" runat="server" onchange="handleSortChange()" >
                <asp:ListItem Text="Sort By" Value="" Disabled="true" Selected="true"></asp:ListItem>
                <asp:ListItem Text="Highest Price" Value="highestPrice"></asp:ListItem>
                <asp:ListItem Text="Lowest Price" Value="lowestPrice"></asp:ListItem>
                <asp:ListItem Text="Highest Reviews" Value="highestReviews"></asp:ListItem>
                <asp:ListItem Text="Lowest Reviews" Value="lowestReviews"></asp:ListItem>
            </asp:DropDownList>
        </div>

            <input type="text"  id="text" placeholder="Search" onkeypress="handleKeyPress(event); " />

             <a id="cartLink" href="javascript:void(0);" class="cart-icon" runat="server" >
                    <img src="icon.png" alt="Cart Icon" />
              </a>            
        </div>
      
        <div id="categories"  runat="server">
           
        </div>

        <div id="products"  runat="server">
       
            </div>

        
           
       <asp:Panel ID="cartPopup" CssClass="cartpopup" runat="server" Style="display: none;">
            <a href="javascript:void(0);" onclick="toggleCartPopup();">×</a>

          <asp:Table ID="orderTable" runat="server" Width="100%">
      
    </asp:Table>
\
       <asp:Button ID="checkoutButton" runat="server" Text="Checkout" OnClick="CheckoutButton_Click" />
        </asp:Panel>


    </form>


    <script type="text/javascript">

        document.getElementById('<%= cartLink.ClientID %>').addEventListener('click', toggleCartPopup);

        window.onload = function () {
            // Check if the cartItems exist in localStorage
            var cartItems = JSON.parse(localStorage.getItem('cartItems')) || [];

            // Display cart items if there are any
            if (cartItems.length > 0) {
                displayCartItems();
            }
        };

        function toggleCartPopup() {
            var cartPopup = document.getElementById('<%= cartPopup.ClientID %>');
            if (cartPopup.style.display === 'none' || cartPopup.style.display === '') {
                cartPopup.style.display = 'block';

            } else {
                cartPopup.style.display = 'none';
            }
        }

        function handleCategoryClick(categoryId) {
            window.location.href = `category.aspx?categoryId=${categoryId}`;
        }


        function handleKeyPress(event) {
            if (event.key === 'Enter') {
                // Get the search term from the input field
                var searchTerm = document.getElementById('text').value;

                // Update the URL to include the search term and reload the page
                window.location.href = 'homescreen.aspx?searchTerm=' + searchTerm;
                event.preventDefault();

            }
        }

 
        function handleSortChange() {
            var selectedOption = document.getElementById('sortOptions').value;
            // You can add logic to handle the sorting based on the selected option
            // For now, let's just display an alert with the selected option

            window.location.href = 'homescreen.aspx?selectedOption=' + selectedOption;

        }

        function displayCartItems() {
            // Retrieve cartItems from localStorage
            var cartItems = JSON.parse(localStorage.getItem('cartItems')) || [];

            // Iterate over each cart item and update the cart popup
            cartItems.forEach(function (item) {
                UpdateCartPopup(item.productName, item.quantity, item.totalPrice,item.size,item.loyaltyDiscount);
            });
        }

        function UpdateCartPopup(productName, quantity, totalPrice,size,loyaltyDiscount) {
            // Create a new table row for the cart
            var cartRow = document.createElement('tr');

            productName = productName ? productName.toString() : '';
            quantity = quantity ? quantity.toString() : '';
            totalPrice = totalPrice ? totalPrice.toString() : '';

            // Add product name, quantity, and total price to the table row
            cartRow.appendChild(CreateTableCell("Item Name", productName, "formLabel", "formValue"));
            cartRow.setAttribute("class", "formRow");
            document.getElementById('<%= orderTable.ClientID %>').appendChild(cartRow);

            // Create another table row for quantity
            cartRow = document.createElement('tr');
            cartRow.appendChild(CreateTableCell("Quantity", quantity.toString(), "formLabel", "formValue"));
            cartRow.setAttribute("class", "formRow");
            document.getElementById('<%= orderTable.ClientID %>').appendChild(cartRow);

            // Create another table row for total price
            cartRow = document.createElement('tr');
            cartRow.appendChild(CreateTableCell("Total Price", totalPrice.toFixed(2), "formLabel", "formValue"));
            cartRow.setAttribute("class", "formRow");
            document.getElementById('<%= orderTable.ClientID %>').appendChild(cartRow);

            // Create another table row for size
            cartRow = document.createElement('tr');
            cartRow.appendChild(CreateTableCell("Size", size, "formLabel", "formValue"));
            cartRow.setAttribute("class", "formRow");
            document.getElementById('<%= orderTable.ClientID %>').appendChild(cartRow);
        }

        function CreateTableCell(label, text, labelCssClass, textCssClass) {
            var cell = document.createElement('td');

            // Create a new Label control for the label
            var labelControl = document.createElement('label');
            labelControl.innerHTML = label;
            labelControl.className = labelCssClass;

            // Create a new Label control for the text
            var textControl = document.createElement('label');
            textControl.innerHTML = text;
            textControl.className = textCssClass;

            // Add the Label controls to the TableCell
            cell.appendChild(labelControl);
            cell.appendChild(textControl);

            return cell;
        }


    </script>
</body>
</html>
