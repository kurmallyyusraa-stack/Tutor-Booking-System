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
    public partial class home : System.Web.UI.Page
    {
        private string _conString =
        WebConfigurationManager.ConnectionStrings["MoProfCS"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                loadHomeTestimonials();
            }
        }

        private void loadHomeTestimonials()
        {
            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = @"SELECT TOP 6
                            t.Testimonial_Text,
                            t.Rating,
                            s.Student_Name
                        FROM Testimonial t
                        INNER JOIN Student s
                            ON t.Student_Id = s.Student_Id
                        ORDER BY t.Testimonial_Id DESC";

            cmd.Connection = con;

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();

            da.Fill(dt);

            rptHomeTestimonials.DataSource = dt;
            rptHomeTestimonials.DataBind();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string search = txtSearch.Text.Trim().ToLower();

            if (search == "")
            {
                lblSearchMessage.Text = "Please enter something to search.";
            }
            else if (search.Contains("home"))
            {
                Response.Redirect("home.aspx");
            }
            else if (search.Contains("about") || search.Contains("about us") || search.Contains("who are we"))
            {
                Response.Redirect("about.aspx");
            }
            else if (search.Contains("contact") || search.Contains("phone") || search.Contains("email"))
            {
                Response.Redirect("contact.aspx");
            }
            else if (search.Contains("tutor") || search.Contains("teacher") || search.Contains("teachers"))
            {
                Response.Redirect("tutors.aspx");
            }
            else if (search.Contains("subject") || search.Contains("course") || search.Contains("courses"))
            {
                Response.Redirect("subjects.aspx");
            }
            else if (search.Contains("login") || search.Contains("sign in"))
            {
                Response.Redirect("login.aspx");
            }
            else if (search.Contains("student register") || search.Contains("student registration"))
            {
                Response.Redirect("studentregister.aspx");
            }
            else if (search.Contains("tutor register") || search.Contains("tutor registration"))
            {
                Response.Redirect("tutorregister.aspx");
            }
            else
            {
                lblSearchMessage.Text = "No matching page found.";
                lblSearchMessage.ForeColor = System.Drawing.Color.Red;
            }
        }
    }
}