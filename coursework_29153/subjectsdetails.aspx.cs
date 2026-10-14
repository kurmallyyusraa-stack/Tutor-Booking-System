using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace coursework_29153
{
    public partial class subjectsdetails : System.Web.UI.Page
    {
        private string _conString =
        WebConfigurationManager.ConnectionStrings["MoProfCS"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                getSubjectDetails();
            }

        }

        private void getSubjectDetails()
        {
            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();

            int qs = Convert.ToInt32(Request.QueryString["id"]);

            cmd.CommandText = @"SELECT Subject.Subject_Id,
                                       Subject.Subject_Name,
                                       Category.Category_Name,
                                       Grade.Grade_Name,
                                       District.District_Name,
                                       Tutor.Tutor_Name,
                                       Tutor.Qualification,
                                       Tutor.Skills,
                                       Tutor.Experience
                                FROM Subject
                                INNER JOIN Category
                                    ON Subject.Category_Id = Category.Category_Id
                                INNER JOIN Grade
                                    ON Subject.Grade_Id = Grade.Grade_Id
                                INNER JOIN District
                                    ON Subject.District_Id = District.District_Id
                                INNER JOIN Tutor
                                    ON Subject.Tutor_Id = Tutor.Tutor_Id
                                WHERE Subject.Subject_Id = @id";

            cmd.Parameters.AddWithValue("@id", qs);
            cmd.Connection = con;

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();

            using (da)
            {
                da.Fill(dt);
            }

            if (dt.Rows.Count > 0)
            {
                lblSubjectName.Text = dt.Rows[0]["Subject_Name"].ToString();
                lblCategory.Text = dt.Rows[0]["Category_Name"].ToString();
                lblGrade.Text = dt.Rows[0]["Grade_Name"].ToString();
                lblDistrict.Text = dt.Rows[0]["District_Name"].ToString();

                lblTutorName.Text = dt.Rows[0]["Tutor_Name"].ToString();
                lblQualification.Text = dt.Rows[0]["Qualification"].ToString();
                lblSkills.Text = dt.Rows[0]["Skills"].ToString();
                lblExperience.Text = dt.Rows[0]["Experience"].ToString();

                lblAboutSubject.Text =
                    "This subject is offered by MoProf. Students receive guidance from qualified tutors through interactive lessons and structured learning activities to improve their academic performance.";
            }

            DetailsView1.DataSource = dt;
            DetailsView1.DataBind();
        }


        protected void btnReserveSubject_Click(object sender, EventArgs e)
        {

            if (Session["Student_Id"] == null)
            {
                Response.Redirect("login.aspx");
                return;
            }

            int studentId = Convert.ToInt32(Session["Student_Id"]);
            int subjectId = Convert.ToInt32(Request.QueryString["id"]);

            using (SqlConnection con = new SqlConnection(_conString))
            {
                con.Open();

                // Check if reservation already exists
                SqlCommand checkCmd = new SqlCommand(
                    "SELECT COUNT(*) FROM StudentSubjectReservation WHERE Student_Id=@Student_Id AND Subject_Id=@Subject_Id",
                    con);

                checkCmd.Parameters.AddWithValue("@Student_Id", studentId);
                checkCmd.Parameters.AddWithValue("@Subject_Id", subjectId);

                int count = Convert.ToInt32(checkCmd.ExecuteScalar());

                if (count > 0)
                {
                    ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "exists",
                        "alert('You have already reserved this subject.');",
                        true);

                    return;
                }

                // Insert reservation
                SqlCommand insertCmd = new SqlCommand(
                    "INSERT INTO StudentSubjectReservation (Student_Id, Subject_Id) VALUES (@Student_Id, @Subject_Id)",
                    con);

                insertCmd.Parameters.AddWithValue("@Student_Id", studentId);
                insertCmd.Parameters.AddWithValue("@Subject_Id", subjectId);

                insertCmd.ExecuteNonQuery();

                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "success",
                    "alert('Subject reserved successfully!');",
                    true);
            }
        
    }



    }
}