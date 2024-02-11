<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="signup.aspx.cs" Inherits="WebApplication5.signup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
      @import url('https://fonts.googleapis.com/css2?family=Calistoga&family=EB+Garamond:ital,wght@1,500&family=Elsie:wght@400;900&family=IBM+Plex+Sans:wght@600&family=Marcellus&family=Montserrat:wght@100;500&family=Outfit&family=Poppins:ital@1&family=Quattrocento&display=swap');

        body {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
            background-color: #f4f4f4;
            max-width: 1200px;
            margin: auto;
            font-family:Quattrocento;

        }

        #formContainer1 {
            gap: 20px;
            background-color: lightgray;
            padding: 20px;
            max-width: 500px;
            width: 200%;
           box-shadow: 0 0 70px  rgb(255,243,128,3); 
            border-radius: 10px;
            display:flex;
             flex-direction: row; /* Change flex-direction to row */
            justify-content: space-between; /* Distribute space evenly between forms */
            margin-left:30%;
        }

        .form-container {
            margin-bottom: 20px; /* Add spacing between form containers */
        }

        form {
            flex: 1;
            border: 1px solid #ddd;
            padding: 20px;
            border-radius: 8px;
        }

        .form-container label {
            display: block;
            margin-bottom: 8px;
        }

        .form-container input {
            width: 100%; /* Take up the full width of the container */
            padding: 8px;
            margin-bottom: 16px;
            box-sizing: border-box;
        }

        .form-container h2 {
            text-align: center;
            margin-bottom: 20px;
        }

     #btnCustomerLogin
       {
            color:black;
            cursor:pointer;
              font-family:Quattrocento;
                font-weight: bold;
            background-color: rgb(254,217,217);

       }

         #btnCustomerSignup 
         {
                   color:black;
            cursor:pointer;
              font-family:Quattrocento;
                font-weight: bold;
            background-color: rgb(254,217,217);
               width: 100%;
               height:35px;
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
    <form id="form1" runat="server">
        <div id="formContainer1">

            <div class="form-container">
                <h2>Log in</h2>
                <label for="adminUsername">Email:</label>
                <asp:TextBox ID="adminUsername" runat="server"></asp:TextBox>

                <label for="adminEmail">Password:</label>
                <asp:TextBox ID="adminEmail" runat="server" TextMode="Password"></asp:TextBox>

                <asp:Button ID="btnCustomerLogin" runat="server" Text="Login"  OnClick="BtnLogin_Click" />
            </div>


            <div class="form-container">
                 <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

                <h2>Sign up</h2>
                <label for="customerFirstName">First Name:</label>
                <asp:TextBox ID="customerFirstName" runat="server"></asp:TextBox>

                <label for="customerLastName">Last Name:</label>
                <asp:TextBox ID="customerLastName" runat="server"></asp:TextBox>

                <label for="customerEmail">Email:</label>
                <asp:TextBox ID="customerEmail" runat="server"></asp:TextBox>

                <label for="customerPassword">Password:</label>
                <asp:TextBox ID="customerPassword" runat="server" TextMode="Password"></asp:TextBox>

                <button type="button" id="btnCustomerSignup" onclick="validateSignup()">Signup</button>
            </div>

        </div>


           <!-- Modal -->
<div id="registrationModal" class="modal">
    <div class="modal-content">
        <asp:Button ID="btnCustomerSignup1" CssClass="close" runat="server" Text="&times;" OnClientClick="return hideModal();"  OnClick="BtnSignup_Click"/>
        <p id="registrationMessage"></p>
    </div>
</div>
    </form>



    <!-- JavaScript for modal -->
    <script>
        function showModal(message) {
            var modal = document.getElementById("registrationModal");
            var modalContent = document.getElementById("registrationMessage");
            modalContent.innerHTML = message;
            modal.style.display = "block";
            console.log("Modal displayed with message: ", message);

        }

        function hideModal() {
            var modal = document.getElementById("registrationModal");
            modal.style.display = "none";
            return true;
        }

        function validateSignup() {
            var firstName = document.getElementById("customerFirstName").value.trim();
            var lastName = document.getElementById("customerLastName").value.trim();
            var email = document.getElementById("customerEmail").value.trim();
            var password = document.getElementById("customerPassword").value.trim();

            if (!firstName || !lastName || !email || !password) {
                showModal("All fields are required.");
                return false;
            }
            showModal("Registration successful. you can log in.");

            return false;
        }

        // When the user clicks anywhere outside of the modal, close it
        window.onclick = function (event) {
            var modal = document.getElementById("registrationModal");
            if (event.target == modal) {
                hideModal();
            }
        }
    </script>
</body>
</html>
