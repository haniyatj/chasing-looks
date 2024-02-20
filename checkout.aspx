<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="checkout.aspx.cs" Inherits="WebApplication5.checkout" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Checkout</title>
    <style>
     @import url('https://fonts.googleapis.com/css2?family=Calistoga&family=EB+Garamond:ital,wght@1,500&family=Elsie:wght@400;900&family=IBM+Plex+Sans:wght@600&family=Marcellus&family=Montserrat:wght@100;500&family=Outfit&family=Poppins:ital@1&family=Quattrocento&display=swap');

   body {
            font-family:Quattrocento;

            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        .checkout-panel {
            background-color: rgb(238,232,224);
            margin: 20px;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                max-width: 700px;
                margin-left:400px;
        }

        h2 {
            color: #333;
        }

      .product-details div {
        display: inline-block;
        vertical-align: top; /* Align child elements to the top */
       }

        img {
            max-width: 100px;
            max-height: 100px;
            margin-right: 10px;
        }

        .product-info {
            margin-left: 10px;
        }

        span {
            display: block;
            margin-bottom: 10px;
        }

        h3 {
            margin-top: 10px;
            color: #333;
        }

        input[type="text"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            box-sizing: border-box;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        #btnConfirmOrder, #btnLogout {
           background-color:rgb(254,217,217);
                       font-family:Quattrocento;
 
            color: black;
            padding: 10px;
            font-size: 16px;
            border: 2px solid black;
            border-radius: 4px;
            cursor: pointer;


        }

        
          #searchBar {
                                
           background-color: rgb(196,176,235);
            color: #fff;
            padding: 20px;
            text-align: center;
            display:flex;
            flex-direction:row;

        }

          #buttonPanel {
        display: flex;
        margin-top: 10px;
        justify-content: center;
        gap: 20px;
    }

            .modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 9999; /* Sit on top */
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
        }

        .modal-content {
            background-color: rgb(254,217,217);
             font-family:Quattrocento;
            font-weight: bold;
            margin: 15% auto; /* 15% from the top and centered */
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 500px; /* Set max width */
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            position: relative;
        }

        .close {
            position: absolute;
            top: 10px;
            right: 10px;
            color: #aaa;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }

    </style>
</head>
<body>
    <form id="form5" runat="server">
        <div>

            <div id="searchBar">
            
             </div>

             <asp:Panel ID="orderDetailsPanel" runat="server" CssClass="checkout-panel">
              <asp:HiddenField ID="hdnCartItems" runat="server" />

            </asp:Panel>

                  <asp:Panel ID="customerInfoPanel" runat="server" CssClass="checkout-panel">
            <h2>Customer Information</h2>
            <asp:TextBox ID="txtFirstName" runat="server" placeholder="First Name"></asp:TextBox>
            <asp:TextBox ID="txtLastName" runat="server" placeholder="Last Name"></asp:TextBox>
            <asp:TextBox ID="txtPhoneNumber" runat="server" placeholder="Phone Number"></asp:TextBox>
            <asp:TextBox ID="txtHouseNumber" runat="server" placeholder="House Number"></asp:TextBox>
            <asp:TextBox ID="txtStreetNumber" runat="server" placeholder="Street Number"></asp:TextBox>
            <asp:TextBox ID="txtState" runat="server" placeholder="State"></asp:TextBox>
            <asp:TextBox ID="txtEmail" runat="server" placeholder="Email"></asp:TextBox>
        </asp:Panel>


            <asp:Panel ID="paymentInfoPanel" runat="server" CssClass="checkout-panel">
                <h2>Payment Information</h2>
                <asp:RadioButton ID="rbtnCashOnDelivery" runat="server" GroupName="paymentType" Text="Cash on Delivery (COD)" />
                <asp:RadioButton ID="rbtnCreditCard" runat="server" GroupName="paymentType" Text="Credit/Debit Card" />
                <br />
                <asp:TextBox ID="txtCardNumber" runat="server" placeholder="Card Number"></asp:TextBox>
                <br />
                <asp:TextBox ID="txtExpirationDate" runat="server" placeholder="Expiration Date"></asp:TextBox>
                <br />
                <asp:TextBox ID="txtCVV" runat="server" placeholder="CVV"></asp:TextBox>
            </asp:Panel>

            <asp:Panel ID="buttonPanel" runat="server">
         <button type="button" id="btnConfirmOrder" onclick="showCheckoutModal()">Confirm Order</button>
                <asp:Button ID="btnLogout" OnClientClick="Logout(event);" runat="server" Text="Logout" />
            </asp:Panel>

        </div>
        <!-- Checkout Modal -->
        <div id="checkoutModal" class="modal">
            <div class="modal-content">
        <asp:Button ID="btn2" CssClass="close" runat="server" Text="&times;" OnClientClick="return hideCheckoutModal();"  OnClick="BtnConfirmOrder_Click"/>
          <p id="checkoutMessage"></p>
            </div>
        </div>


         <script>

             window.onload = function () {
                 // Check if the cartItems exist in localStorage
                 var cartItems = JSON.parse(localStorage.getItem('cartItems')) || [];

                 // Display cart items if there are any
                 if (cartItems.length > 0) {
                     displayCartItems(cartItems);
                 }

                 // Set the value of the hidden field with the JSON representation of cart items
                 var hdnCartItems = document.getElementById('<%= hdnCartItems.ClientID %>');
                 hdnCartItems.value = JSON.stringify(cartItems);
             };

             function Logout(event) {
                 // Remove cartItems from localStorage
                 localStorage.removeItem('cartItems');

                 // Redirect to main.aspx
                 window.location.replace('main.aspx');

                 if (event) {
                     event.preventDefault();
                 }
             }

             function showCheckoutModal(message) {
                 var modal = document.getElementById("checkoutModal");
                 var modalContent = document.getElementById("checkoutMessage");
                 modalContent.innerHTML = 'order confirmed!';
                 modal.style.display = "block";
             }

             function hideCheckoutModal() {
                 var modal = document.getElementById("checkoutModal");
                 modal.style.display = "none";
                 return true;
             }

             function displayCartItems(cartItems) {
                 var orderDetailsPanel = document.getElementById('<%= orderDetailsPanel.ClientID %>');
                 var subtotal = 0;
                 // Iterate over each cart item and create HTML markup
                 cartItems.forEach(function (cartItem) {
                     var productDetailsDiv = document.createElement('div');
                     productDetailsDiv.className = 'product-details';

                     // Create a span for product name
                     var productNameSpan = document.createElement('span');
                     productNameSpan.innerText = cartItem.productName; // Set the actual property based on your cart item structure
                     productDetailsDiv.appendChild(productNameSpan);

                     // Create a span for quantity
                     var quantitySpan = document.createElement('span');
                     quantitySpan.innerText = 'Quantity: ' + cartItem.quantity; // Set the actual property based on your cart item structure
                     productDetailsDiv.appendChild(quantitySpan);

                     // Fetch discount from the server and apply it
                     var loyaltyDiscount = cartItem.loyaltyDiscount || 0; // Default to 0 if loyaltyDiscount is undefined
                     var discountedPrice = cartItem.totalPrice - (cartItem.totalPrice * (loyaltyDiscount / 100));


                     // Create a span for price
                     var priceSpan = document.createElement('span');
                     priceSpan.innerText = 'Price: $' + discountedPrice.toFixed(2);
                     productDetailsDiv.appendChild(priceSpan);

                     // Add the product details div to the orderDetailsPanel
                     orderDetailsPanel.appendChild(productDetailsDiv);

                     subtotal += discountedPrice;

                 });

                 // Calculate and display total order price
                 var totalOrderPriceDiv = document.createElement('div');
                 var totalOrderPriceHeader = document.createElement('h3');
                 var taxRate = 0.1; // Example tax rate (10%)
                 var taxAmount = subtotal * taxRate;
                 var totalOrderPrice = subtotal + taxAmount;

                 totalOrderPriceHeader.innerText = 'Total Order Price (Including Tax): $' + totalOrderPrice.toFixed(2);
                 totalOrderPriceDiv.appendChild(totalOrderPriceHeader);
                 orderDetailsPanel.appendChild(totalOrderPriceDiv);
             }


         </script>
    </form>
</body>
</html>
