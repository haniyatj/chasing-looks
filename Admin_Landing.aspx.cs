using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication5
{
    public partial class Admin_Landing : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {


        }

        protected void btnViewAnalytics_Click(object sender, EventArgs e)
        {
            // Redirect to the Analytics page
            Response.Redirect("Analytics.aspx");
        }

        protected void btnInventoryManagement_Click(object sender, EventArgs e)
        {
            // Redirect to the Inventory Management page
            Response.Redirect("Inventory_Management.aspx");
        }
    }
}