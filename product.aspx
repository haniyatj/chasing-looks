<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="product.aspx.cs" Inherits="WebApplication5.product"    ViewStateMode="Enabled"%>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Product Information</title>
    <style>
    @import url('https://fonts.googleapis.com/css2?family=Calistoga&family=EB+Garamond:ital,wght@1,500&family=Elsie:wght@400;900&family=IBM+Plex+Sans:wght@600&family=Marcellus&family=Montserrat:wght@100;500&family=Outfit&family=Poppins:ital@1&family=Quattrocento&display=swap');

        body {
            font-family:Quattrocento;
            margin: 0;
            padding: 0;
            background-color: rgb(241,241,241);
        }

        h2{
          font-family:Elsie;

        }

        #productContainer {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            padding: 20px;
        }

        #productImage {
            width: 20%;
            margin-left:90px;
            margin-top:30px;
        }

        #productDetails {
            width: 55%;
            padding-left: 20px;
        }

        #sizeDropdown {
            margin-bottom: 10px;
              color:#FFF3ED;


        }

        #popupLink {
            color:rgb(38,192,146) ;
            cursor: pointer;
            text-decoration: underline;
        }

      
        #btnAddToCart,#btnReview
         {
            margin-top: 10px;
            background-color:rgb(254,217,217);
          border: 2px solid black;
            padding: 10px;
            cursor: pointer;
            transition: background-color 0.3s;
             border-radius: 10px;

        }

         #btnAddToCart:hover {
            background-color: rgb(170,170,170);
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


            .popup {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            border: 1px solid double;
            background-color: rgb(196,176,235);
            padding: 50px;
            z-index: 9999;
            display: none;
        }

        .popup img {
            max-width: 60%;
            height: auto;
            margin-left:90px;
        }
            .popup a {
        position: absolute;
        top: 10px;
        left: 10px;
        color: rgb(52,82,93);
        text-decoration: none;
        font-size: 20px;
        cursor: pointer;
            }

        .popup form {
            text-align: center;
        }

        .popup h2 {
            font-family: 'Poppins', sans-serif;
            color: rgb(69, 133, 227);
        }

        .popup input[type="text"],
        .popup textarea {
            width: 80%;
            padding: 8px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .popup textarea {
            resize: vertical;
        }

        .button {
            background-color: rgb(38, 192, 146);
            color: black;
            padding: 10px;
            border: 2px solid black;
            border-radius: 10px;
            cursor: pointer;
            transition: background-color 0.3s;
            display: block;
              margin: 15px auto;
        }


        .button:hover {
            background-color: rgb(170, 170, 170);
        }

        .popup a {
            position: absolute;
            top: 10px;
            right: 10px;
            color: rgb(52, 82, 93);
            text-decoration: none;
            font-size: 20px;
            cursor: pointer;
        }


          h3{
             margin-left:30px;
             }

        .reviewPanel {
            padding: 15px;
            border: 2px solid rgb(69,133,227); /* Red border color */
            background-color: #f9f9f9;
            margin: 20px 30px; /* Adjusted margin for spacing */
            border-radius: 10px; /* Rounded corners */
        }

        .reviewSection {
            margin-top: 30px;
            text-align: center;
        }

        .reviewSection h3 {
            font-family: 'Poppins', sans-serif; /* Use Poppins font for the heading */
            color: rgb(69,133,227)
        }

        .reviewSection p {
            font-family: 'Quattrocento', sans-serif; /* Use Quattrocento font for the reviews */
            color: #555;
            margin-bottom: 10px;
        }

        .reviewSection strong {
            color: #333;
        }

     #btn{
             background-color: #FFF3ED;
               margin-left:30px;
             border: 2px solid black ;
            border-radius: 4px;
            cursor: pointer;
            margin-top:15px;
            height:120%;
            padding:12px;
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

      .image-slider-container {
            position: relative;
            overflow: hidden;
            width: 100%;
            max-width: 300px; /* Adjust the maximum width as needed */
            height: 400px; /* Adjust the height as needed */
            margin-right: 10px;
            margin-left:150px;

        }
   .image-slider {
            display: flex;
            transition: transform 0.5s ease-in-out;
        }

        .image-slide {
            width: 100%;
            flex: 0 0 auto;
              border: 2px solid rgb(255,243,128); /* Red border color for the image */
    border-radius: 10px; /* Rounded corners for the image */
        }

        /* Navigation Arrows */
        .slider-arrow {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            font-size: 24px;
            color: rgb(38,192,146); /* Adjust arrow color */
        }

        .prev-arrow {
            left: 10px;
        }

        .next-arrow {
            right: 10px;
        }

    </style>

     
</head>
<body>
    <form id="form4" runat="server">
                <asp:ScriptManager runat="server"></asp:ScriptManager>

         <div id="searchBar">

              <input type="text"  id="text" placeholder="Search" onkeypress="handleKeyPress(event)" />

             <a id="cartLink" href="javascript:void(0);" class="cart-icon" runat="server" >
                    <img src="icon.png" alt="Cart Icon" />
              </a>  
             
        </div>
        <div id="productContainer">
             <div class="image-slider-container">
      
             <div class="image-slider">
                <div class="image-slide">
                    <asp:Image ID="imgProduct1" runat="server" ImageUrl="https://lp2.hm.com/hmgoepprod?set=quality%5B79%5D%2Csource%5B%2Fad%2F15%2Fad158f01dcdfd762140719e951d253f834df6fbf.jpg%5D%2Corigin%5Bdam%5D%2Ccategory%5B%5D%2Ctype%5BLOOKBOOK%5D%2Cres%5Bm%5D%2Chmver%5B1%5D&call=url[file:/product/main]" style="max-width: 100%;" />
                </div>
                <div class="image-slide">
                    <asp:Image ID="imgProduct2" runat="server" ImageUrl="https://lp2.hm.com/hmgoepprod?set=format%5Bwebp%5D%2Cquality%5B79%5D%2Csource%5B%2Fb3%2F83%2Fb383e7c02f5c1f234727f1582fbad4854f6a541c.jpg%5D%2Corigin%5Bdam%5D%2Ccategory%5B%5D%2Ctype%5BLOOKBOOK%5D%2Cres%5Bm%5D%2Chmver%5B1%5D&call=url%5Bfile%3A%2Fproduct%2Fmain%5D"  style="max-width: 100%;"/>
                </div>
            </div>

            <div class="slider-arrow prev-arrow" onclick="prevSlide()"  >&#9665;</div>
            <div class="slider-arrow next-arrow" onclick="nextSlide()"  >&#9655;</div>
                 </div>
            <div id="productDetails">
                <h2><asp:Label ID="lblProductName" runat="server" Text="Cotton T-shirt" /></h2>
                <p><asp:Label ID="lblDescription" runat="server" Text="Straight-cut T-shirt in soft cotton jersey with ribbed crew neck and gently dropped shoulders." /></p>
                <div id="sizeDropdown">
                    <asp:DropDownList ID="ddlSizes" runat="server">
                        <asp:ListItem Text="Small" Value="S" />
                        <asp:ListItem Text="Medium" Value="M" />
                        <asp:ListItem Text="Large" Value="L" />
                    </asp:DropDownList>
                </div>
                <p>
                    <strong> Discount:</strong>
                    <asp:Label ID="hdnLoyaltyDiscount" runat="server" />
                </p>
                <p>
                    <strong>Price:</strong>
                    <asp:Label ID="lblPrice" runat="server" Text="$8.99" />

                </p>
                <p>
                    <a id="popupLink" runat="server" href="javascript:void(0);">View Size Chart</a>
                </p>


            <div>
                <strong>Quantity:</strong>
                <asp:TextBox ID="txtQuantity" runat="server" CssClass="input-field" Text="1" style="width: 40px; text-align: center;"></asp:TextBox>
                <asp:Button ID="btnDecrease" runat="server" Text="-" CssClass="quantity-control" OnClientClick="decreaseQuantity(); return false;" />
                <asp:Button ID="btnIncrease" runat="server" Text="+" CssClass="quantity-control" OnClientClick="increaseQuantity(); return false;" />
            </div>


            <asp:Button ID="btnAddToCart" runat="server" Text="Add to Cart"  OnClientClick="addToCart(); return false;"  AutoPostBack="false" UseSubmitBehavior="false"/>

                <!-- Add the Review button next to the Add to Cart button -->
            <asp:Button ID="btnReview" runat="server" Text="Review" OnClientClick="toggleReviewPopup(); return false;" CssClass="btn" />

            <!-- Review Popup Form -->
            <asp:Panel ID="reviewPopup" runat="server" CssClass="popup" Style="display: none;">
                <h2>Leave a Review</h2>
               <asp:TextBox ID="txtSizeBought" runat="server" CssClass="input-field" placeholder="Size Bought"></asp:TextBox>

                <asp:TextBox ID="txtContent" runat="server" CssClass="input-field" placeholder="Content" TextMode="MultiLine" Rows="4"></asp:TextBox>
                <asp:Button ID="btnSubmitReview" runat="server" Text="Submit" OnClick="SubmitReview_Click" CssClass="button" />
                <a href="javascript:void(0);" onclick="toggleReviewPopup();">×</a>
            </asp:Panel>
            </div>
        </div>

       <div class="reviewSection" runat="server" id="reviews" >
           <h3>Reviews</h3>
           
        </div>

    <asp:Panel ID="imagePopup" runat="server" CssClass="popup" Style="display: none;">
        <asp:Image ID="imgPopup" runat="server" ImageUrl="https://cdn.shopify.com/s/files/1/0243/9663/files/Size-Guide_1.jpg?v=1660935716" />
            <a href="javascript:void(0);" onclick="togglePopup();">×</a>

    </asp:Panel>

          
       <asp:Panel ID="cartPopup" CssClass="cartpopup" runat="server" Style="display: none;">
            <a href="javascript:void(0);" onclick="toggleCartPopup();">×</a>

          <asp:Table ID="orderTable" runat="server" Width="100%">
     
           </asp:Table>

       <asp:Button ID="checkoutButton" runat="server" Text="Checkout" OnClick="CheckoutButton_Click" />
        </asp:Panel>


    <script type="text/javascript">
        var currentSlideIndex = 0;
        var totalSlides = document.querySelectorAll('.image-slide').length;
        // Example call in the script section of your HTML file
        window.onload = function () {
            // Check if the cartItems exist in localStorage
            var cartItems = JSON.parse(localStorage.getItem('cartItems')) || [];
            console.log('Retrieved Cart Items:', cartItems);

            // Display cart items if there are any
            if (cartItems.length > 0) {
                displayCartItems();
            }
        };


        document.getElementById('<%= popupLink.ClientID %>').addEventListener('click', togglePopup);
        document.getElementById('<%= cartLink.ClientID %>').addEventListener('click', toggleCartPopup);

        function togglePopup() {
            console.log("hii");
            var popup = document.getElementById('<%= imagePopup.ClientID %>');
            if (popup.style.display === 'none' || popup.style.display === '') {
                popup.style.display = 'block';
            } else {
                popup.style.display = 'none';
            }
        }


        function toggleCartPopup() {
            var cartPopup = document.getElementById('<%= cartPopup.ClientID %>');
            if (cartPopup.style.display === 'none' || cartPopup.style.display === '') {
                cartPopup.style.display = 'block';
            } else {
                cartPopup.style.display = 'none';
            }
        }


        function prevSlide() {
            currentSlideIndex = (currentSlideIndex - 1 + totalSlides) % totalSlides;
            updateSlider();
        }

        function nextSlide() {
            currentSlideIndex = (currentSlideIndex + 1) % totalSlides;
            updateSlider();
        }

        function updateSlider() {
            var translateValue = -currentSlideIndex * 100 + '%';
            document.querySelector('.image-slider').style.transform = 'translateX(' + translateValue + ')';
        }

        function toggleReviewPopup() {
            var reviewPopup = document.getElementById('<%= reviewPopup.ClientID %>');
            if (reviewPopup.style.display === 'none' || reviewPopup.style.display === '') {
                reviewPopup.style.display = 'block';
            } else {
                reviewPopup.style.display = 'none';
            }
        }

        function increaseQuantity() {
            var txtQuantity = document.getElementById('<%= txtQuantity.ClientID %>');
        var currentQuantity = parseInt(txtQuantity.value);
        txtQuantity.value = currentQuantity + 1;
                 }

    function decreaseQuantity() {
        var txtQuantity = document.getElementById('<%= txtQuantity.ClientID %>');
        var currentQuantity = parseInt(txtQuantity.value);
        if (currentQuantity > 1) {
            txtQuantity.value = currentQuantity - 1;
        }
        }

        function addToCart() {

            console.log("Add to Cart button clicked on the client-side");


            var productName = document.getElementById('<%= lblProductName.ClientID %>').innerText;
            var price = parseFloat(document.getElementById('<%= lblPrice.ClientID %>').innerText.replace('$', ''));
            var quantity = parseInt(document.getElementById('<%= txtQuantity.ClientID %>').value);
            var loyaltyDiscount = parseFloat(document.getElementById('<%= hdnLoyaltyDiscount.ClientID %>').innerText);
            var size = document.getElementById('<%= ddlSizes.ClientID %>').value;

            // Calculate total price
            updateCartPopupOnClient(productName, quantity, price * quantity, size, loyaltyDiscount);

          // Add the item to the session variable

            addToCartSessionOnClient(productName, quantity, price * quantity, size, loyaltyDiscount);


        }
        function updateCartPopupOnClient(productName, quantity, totalPrice,size, loyaltyDiscount) {
            // Your logic to update the cart popup on the client-side
            console.log("Updating cart popup on the client-side");

            // Example: Create a new table row for the cart
            var cartRow = document.createElement('tr');

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

        function addToCartSessionOnClient(productName, quantity, totalPrice, size, loyaltyDiscount) {
            // Your logic to update the cart session on the client-side
            console.log("Adding item to cart session on the client-side");

            // Check if sessionStorage is supported
            if (typeof (Storage) !== "undefined")
            {
                // Retrieve existing cart items from sessionStorage or create a new array
                var cartItems = JSON.parse(localStorage.getItem("cartItems")) || [];

                // Check if the product is already in the cart
                var existingItem = cartItems.find(item => item.productName === productName);

                if (existingItem) {
                    // Update the quantity and total price for existing items
                    existingItem.quantity += quantity;
                    existingItem.totalPrice += totalPrice;
                } else
                {
                    // Add a new item to the cart
                    cartItems.push({
                        productName: productName, quantity: quantity, totalPrice: totalPrice, size: size,
                        loyaltyDiscount: loyaltyDiscount });
                }

                // Update sessionStorage with the modified cart items
                localStorage.setItem("cartItems", JSON.stringify(cartItems));

                console.log('Updated Cart Items:', cartItems);

            } else {
                console.log("Session storage is not supported");
            }
        }

        function CreateTableCell(label, text, labelCssClass, textCssClass)
        {
            var cell = document.createElement('td');

            // Example: Create a new Label element for the label
            var labelControl = document.createElement('span');
            labelControl.textContent = label;
            labelControl.classList.add(labelCssClass);

            // Example: Create a new Label element for the text
            var textControl = document.createElement('span');
            textControl.textContent = text;
            textControl.classList.add(textCssClass);

            // Example: Add the Label elements to the TableCell
            cell.appendChild(labelControl);
            cell.appendChild(textControl);

            return cell;
        }

        // Function to get cart items from session storage
        function getCartItems() {
            var cartItemsJson = localStorage.getItem('cartItems');
            return JSON.parse(cartItemsJson) || [];
        }

        // Function to display cart items in the popup
        function displayCartItems() {
            var cartItems = getCartItems();
            var orderTable = document.getElementById('<%= orderTable.ClientID %>');
            console.log('Cart Items:', cartItems);

            // Clear existing rows from the table
            orderTable.innerHTML = '';

            // Loop through cart items and update the popup
            for (var i = 0; i < cartItems.length; i++)
            {
                var cartItem = cartItems[i];

                // Update the cart popup with the cart item details
                updateCartPopupOnClient(cartItem.productName, cartItem.quantity, cartItem.totalPrice);
            }
        }



    </script>
    </form>

   
</body>
</html>
