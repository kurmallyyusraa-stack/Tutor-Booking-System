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
    public partial class tutors : System.Web.UI.Page
    {
        private string _conString =
        WebConfigurationManager.ConnectionStrings["MoProfCS"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] != null)
            {
                lblWelcome.Text = "Welcome, " + Session["username"] + " (" + Session["role"] + ")";
            }
            else
            {
                lblWelcome.Text = "Welcome to MoProf!";
            }



            if (!IsPostBack)
            {
                getTutors("");
            }
        }

        private void getTutors(string search)
        {
            SqlConnection con = new SqlConnection(_conString);

            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = @"SELECT
        Tutor.Tutor_Id,
        Tutor.Tutor_Name,
        Tutor.Tutor_Email,
        Tutor.Tutor_Phone,
        Tutor.Qualification,
        Tutor.Skills,
        Tutor.Experience,
        Tutor.Profile_Picture,
        Tutor.Registration_Date,
        District.District_Name,
        COUNT(DISTINCT StudentSubjectRecommendation.Student_Id) AS RecommendationCount

    FROM Tutor

    INNER JOIN District
        ON Tutor.District_Id = District.District_Id

    LEFT JOIN Subject
        ON Tutor.Tutor_Id = Subject.Tutor_Id

    LEFT JOIN StudentSubjectRecommendation
        ON Subject.Subject_Id = StudentSubjectRecommendation.Subject_Id

    WHERE Tutor.Tutor_Name LIKE @search

    GROUP BY
        Tutor.Tutor_Id,
        Tutor.Tutor_Name,
        Tutor.Tutor_Email,
        Tutor.Tutor_Phone,
        Tutor.Qualification,
        Tutor.Skills,
        Tutor.Experience,
        Tutor.Profile_Picture,
        Tutor.Registration_Date,
        District.District_Name";
            cmd.Parameters.AddWithValue("@search", "%" + search + "%");

            cmd.Connection = con;

            SqlDataAdapter da = new SqlDataAdapter(cmd);

            DataTable dt = new DataTable();

            using (da)
            {
                da.Fill(dt);
            }

            lblTotalTutors.Text = "Total Registered Tutors : " + dt.Rows.Count;

            PagedDataSource pg = new PagedDataSource();

            pg.DataSource = dt.DefaultView;
            pg.AllowPaging = true;
            pg.PageSize = 6;

            int page = 0;

            if (Request.QueryString["page"] != null)
            {
                page = Convert.ToInt32(Request.QueryString["page"]);
            }

            if (page >= pg.PageCount)
            {
                page = pg.PageCount - 1;
            }

            if (page < 0)
            {
                page = 0;
            }

            pg.CurrentPageIndex = page;

            btnPrevious.Enabled = !pg.IsFirstPage;
            btnNext.Enabled = !pg.IsLastPage;

            rptTutors.DataSource = pg;
            rptTutors.DataBind();
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            int page = 0;

            if (Request.QueryString["page"] != null)
            {
                page = Convert.ToInt32(Request.QueryString["page"]);
            }

            page++;

            Response.Redirect("tutors.aspx?page=" + page);
        
        }

        protected void btnPrevious_Click(object sender, EventArgs e)
        {
            int page = 0;

            if (Request.QueryString["page"] != null)
            {
                page = Convert.ToInt32(Request.QueryString["page"]);
            }

            page--;

            if (page < 0)
            {
                page = 0;
            }

            Response.Redirect("tutors.aspx?page=" + page);
        
        }

        protected void btnSearchTutor_Click(object sender, EventArgs e)
        {
            getTutors(txtSearchTutor.Text.Trim());
        }
    }
}