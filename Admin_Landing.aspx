<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin_Landing.aspx.cs" Inherits="WebApplication5.Admin_Landing" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Portal</title>
     <style>
        body {
            font-family: Arial, sans-serif;
            background-color: floralwhite;
            margin: 0;
            padding: 0;
           /* background-image: url('ChasingLooks.png');*/
           /* background-size: cover;*/
           
            background-position: center center; /* Center the background image */
            background-repeat: no-repeat; 
           
        }
         

.gif {
    position: fixed;
    top: 0;
    left: 0;
    width: 74%;
    height: 100%;
    overflow: hidden;
}

.gif img {
    width: 74%;
    height: 100%;
    object-fit: cover;
}
#form1 {
    max-width: 500px;
    height:300px;
    padding: 50px;
    background-color: lightgray;
    border-radius: 8px;
    box-shadow: 0 0 20px rgba(0, 0, 0, 1.0);
    margin-top: 10%; /* Adjusted margin-top */
    margin-left: 59%; /* Adjusted margin-left */
    
}

#form1 div {
    text-align: center;
    margin-top: 20%; /* Adjusted margin-top */
    margin-left: 27%; /* Adjusted margin-left */
    
   
}
         
      .buttonStyle {
    display: block;
    padding: 10px 20px;
    font-size: 20px;
    line-height: 30px; /* Set line-height equal to the height of the button */
    cursor: pointer;
    background-color: whitesmoke; /* Set your desired background color */
    color: #000; /* Change color to black */
    border: double;
    border-radius: 4px;
    margin-bottom: 10px; /* Add margin to create space between buttons */
}
        .buttonStyle:hover {

            background-color: gray;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Button ID="btnViewAnalytics" runat="server" Text="View System Analytics" OnClick="btnViewAnalytics_Click" CssClass="buttonStyle" />
            <asp:Button ID="btnInventoryManagement" runat="server" Text="Inventory Management" OnClick="btnInventoryManagement_Click" CssClass="buttonStyle" />
        </div>
        
    </form>
    <div class="gif">
    <img src="https://i.pinimg.com/originals/84/cf/45/84cf459061b9229caef85e2d26aaa67d.gif" alt="Your GIF" />
</div>
</body>
</html>
