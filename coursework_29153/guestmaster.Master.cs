using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace coursework_29153
{
    public partial class guestmaster : System.Web.UI.MasterPage
    {
       private string _conString =
       WebConfigurationManager.ConnectionStrings["MoProfCS"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                loadAdvertisement();
            }
        }

        private void loadAdvertisement()
        {
            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = @"SELECT TOP 1
                                    Advertisement_Title,
                                    Advertisement_Text,
                                    Advertisement_Image,
                                    Advertisement_Link
                                FROM Advertisement
                                WHERE Advertisement_Status = 'Active'
                                ORDER BY NEWID()";

            cmd.Connection = con;

            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                pnlAdvertisement.Visible = true;

                lblAdTitle.Text = dr["Advertisement_Title"].ToString();
                lblAdText.Text = dr["Advertisement_Text"].ToString();
                imgAdvertisement.ImageUrl = dr["Advertisement_Image"].ToString();
                lnkAdvertisement.NavigateUrl = dr["Advertisement_Link"].ToString();
            }
            else
            {
                pnlAdvertisement.Visible = false;
            }

            con.Close();
        }
    }
}