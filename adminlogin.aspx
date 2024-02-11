<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="adminlogin.aspx.cs" Inherits="WebApplication5.adminlogin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>

    </title>

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

        #formContainer {
            display: relative;
            gap: 20px;
            background-color: lightgray;
            padding: 20px;
            max-width: 500px;
            width: 80%;
           box-shadow: 0 0 70px  rgb(255,243,128,3); 
            border-radius: 10px;
            flex-direction: column; 
            margin-left:26%;
        }

        .form-container {
            margin-bottom: 20px;
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
            width: 100%; 
            padding: 8px;
            margin-bottom: 16px;
            box-sizing: border-box;
        }

        .form-container h2 {
            text-align: center;
            margin-bottom: 20px;
        }

       #btnCustomerSignup , #btnCustomerLogin
       {
            background-color: rgb(254,217,217);
            color:black;

       }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>

              <div id="formContainer">

            <div class="form-container">
                <h2>Log in</h2>
                <label for="adminUsername">Username:</label>
                <asp:TextBox ID="txtUsername" runat="server"></asp:TextBox>

                <label for="adminEmail">Password:</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>

                <asp:Button ID="btnCustomerLogin" runat="server" Text="Login" OnClick="BtnLogin_Click" />
            </div>


        </div>
        </div>

    </form>
</body>
</html>
