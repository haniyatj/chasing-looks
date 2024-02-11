<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Analytics.aspx.cs" Inherits="WebApplication5.Analytics" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SALES ANALYTICS</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.7.0/chart.min.js"></script>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            text-align: center;
        }

        form {
            max-width: 800px;
            margin: 20px auto;
            background-color:lightgray;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.8);
        }

        div {
            text-align: left;
            margin-bottom: 10px;
        }

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }

        canvas {
            max-width: 100%;
            height: auto;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
         <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div>
            <asp:Label ID="lblNumberOfOrders" runat="server" Text="Number of Orders: 100"></asp:Label>
            <br />
            <asp:Label ID="lblNumberOfCustomers" runat="server" Text="Number of Customers: 500"></asp:Label>
            <br />
            <canvas id="salesChart" width="100" height="20"></canvas>
            <br />
            <canvas id="revenueChart" width="100" height="20"></canvas>
            <br />
            <canvas id="profitsChart" width="100" height="20"></canvas>
            <br />
            <asp:Label ID="lblAverageOrderValue" runat="server" Text="Average Order Value: $75"></asp:Label>
            <br />
            <asp:Label ID="lblTotalRevenue" runat="server" Text="Total Revenue: $50,000"></asp:Label>
            <br />
            <!--<asp:Label ID="lblPopularReferralSource" runat="server" Text="Popular Referral Source: Instagram"></asp:Label>-->
            <br />
        </div>

        <script>

</script>
    </form>
</body>
</html>