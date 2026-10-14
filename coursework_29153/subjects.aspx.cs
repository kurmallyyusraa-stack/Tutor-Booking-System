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
    public partial class subjects : System.Web.UI.Page
    {
        private string _conString =
           WebConfigurationManager.ConnectionStrings["MoProfCS"].ConnectionString;

        int pageSize = 6;
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

            lblDate.Text = "Today's Date: " + DateTime.Now.ToString("dd MMMM yyyy");


            if (!IsPostBack)
            {
                getSubjects("");


                if (Session["username"] != null)
                {
                    lblWelcome.Text = "Welcome, " + Session["username"] + " (" + Session["role"] + ")";
                }
                else
                {
                    lblWelcome.Text = "Welcome to MoProf!";
                }

                lblDate.Text = "Today's Date: " + DateTime.Now.ToString("dd MMMM yyyy");

                if (!IsPostBack)
                {
                    getSubjects("");

                    if (Session["Student_Id"] != null)
                    {
                        announcementBox.Visible = true;
                        loadStudentAnnouncements();
                    }
                    else if (Session["Tutor_Id"] != null)
                    {
                        announcementBox.Visible = false;
                        
                    }
                    else
                    {
                        announcementBox.Visible = false;
                    }
                }

            }

        }

        private void loadStudentAnnouncements()
        {
            int studentId = Convert.ToInt32(Session["Student_Id"]);

            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = @"SELECT DISTINCT
                        Announcement.Announcement_Id,
                        Announcement.Announcement_Text,
                        Tutor.Tutor_Name
                    FROM Announcement
                    INNER JOIN Tutor
                        ON Announcement.Tutor_Id = Tutor.Tutor_Id
                    INNER JOIN Subject
                        ON Tutor.Tutor_Id = Subject.Tutor_Id
                    INNER JOIN StudentSubjectReservation
                        ON Subject.Subject_Id = StudentSubjectReservation.Subject_Id
                    WHERE StudentSubjectReservation.Student_Id = @Student_Id
                    AND StudentSubjectReservation.Status = 'Accepted'
                    ORDER BY Announcement.Announcement_Id DESC";

            cmd.Parameters.AddWithValue("@Student_Id", studentId);
            cmd.Connection = con;

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();

            da.Fill(dt);

            rptAnnouncements.DataSource = dt;
            rptAnnouncements.DataBind();
        }


        private void getSubjects(string search)
        {
            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = @"SELECT Subject.Subject_Id,
                           Subject.Subject_Name,
                           Category.Category_Name,
                           Grade.Grade_Name,
                           District.District_Name,
                           Tutor.Tutor_Name
                    FROM Subject
                    INNER JOIN Category ON Subject.Category_Id = Category.Category_Id
                    INNER JOIN Grade ON Subject.Grade_Id = Grade.Grade_Id
                    INNER JOIN District ON Subject.District_Id = District.District_Id
                    INNER JOIN Tutor ON Subject.Tutor_Id = Tutor.Tutor_Id
                    WHERE Subject.Subject_Name LIKE @search
                    OR Category.Category_Name LIKE @search
                    OR District.District_Name LIKE @search";

            cmd.Parameters.AddWithValue("@search", "%" + search + "%");
            cmd.Connection = con;

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();

            using (da)
            {
                da.Fill(dt);
            }

            lblTotalSubjects.Text = "Total Subjects Available : " + dt.Rows.Count;

            PagedDataSource pg = new PagedDataSource();
            pg.DataSource = dt.DefaultView;
            pg.AllowPaging = true;
            pg.PageSize = pageSize;

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

            rptSubjects.DataSource = pg;
            rptSubjects.DataBind();
        }


        private void loadAnnouncements()
        {
            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = @"SELECT 
                            Announcement.Announcement_Text,
                            Tutor.Tutor_Name
                        FROM Announcement
                        INNER JOIN Tutor
                            ON Announcement.Tutor_Id = Tutor.Tutor_Id
                        ORDER BY Announcement.Announcement_Id DESC";

            cmd.Connection = con;

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();

            da.Fill(dt);

            rptAnnouncements.DataSource = dt;
            rptAnnouncements.DataBind();
        }


        protected void btnSearchSubject_Click(object sender, EventArgs e)
        {
            getSubjects(txtSearchSubject.Text.Trim());
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

            Response.Redirect("subjects.aspx?page=" + page);
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            int page = 0;

            if (Request.QueryString["page"] != null)
            {
                page = Convert.ToInt32(Request.QueryString["page"]);
            }

            page++;

            Response.Redirect("subjects.aspx?page=" + page);
        }

        protected void btnViewDetails_Click1(object sender, EventArgs e)
        {

            Button btn = (Button)sender;
            Response.Redirect("subjectsdetails.aspx?id=" + btn.CommandArgument);
        }
    }
    }
