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
    public partial class studentprofile : System.Web.UI.Page
    {
       private string _conString =
       WebConfigurationManager.ConnectionStrings["MoProfCS"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Student_Id"] == null)
            {
                Response.Redirect("login.aspx");
            }

            if (!IsPostBack)
            {
                loadDistrict();
                loadGrade();
                loadStudentProfile();

                loadResultSubjects();

                loadReservations();

                loadPaymentReservations();
                loadPayments();

                loadMyTestimonials();

                loadRecommendationSubjects();
                loadRecommendations();
            }
        }

        private void loadDistrict()
        {
            SqlConnection con = new SqlConnection(_conString);

            SqlCommand cmd = new SqlCommand(
                "SELECT District_Id, District_Name FROM District", con);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();

            da.Fill(dt);

            ddlDistrict.DataSource = dt;
            ddlDistrict.DataTextField = "District_Name";
            ddlDistrict.DataValueField = "District_Id";
            ddlDistrict.DataBind();

            ddlDistrict.Items.Insert(0, new ListItem("-- Select District --", ""));
        }

        private void loadGrade()
        {
            SqlConnection con = new SqlConnection(_conString);

            SqlCommand cmd = new SqlCommand(
                "SELECT Grade_Id, Grade_Name FROM Grade", con);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();

            da.Fill(dt);

            ddlGrade.DataSource = dt;
            ddlGrade.DataTextField = "Grade_Name";
            ddlGrade.DataValueField = "Grade_Id";
            ddlGrade.DataBind();

            ddlGrade.Items.Insert(0, new ListItem("-- Select Grade --", ""));
        }

        private void loadStudentProfile()
        {
            int studentId = Convert.ToInt32(Session["Student_Id"]);

            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = "SELECT * FROM Student WHERE Student_Id=@Student_Id";
            cmd.Parameters.AddWithValue("@Student_Id", studentId);
            cmd.Connection = con;

            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                txtStudentName.Text = dr["Student_Name"].ToString();
                txtStudentEmail.Text = dr["Student_Email"].ToString();
                txtStudentPhone.Text = dr["Student_Phone"].ToString();

                if (dr["District_Id"] != DBNull.Value && dr["District_Id"].ToString() != "")
                {
                    ddlDistrict.SelectedValue = dr["District_Id"].ToString();
                }

                if (dr["Grade_Id"] != DBNull.Value && dr["Grade_Id"].ToString() != "")
                {
                    ddlGrade.SelectedValue = dr["Grade_Id"].ToString();
                }

                if (dr["Last_Login_Date"] != DBNull.Value)
                {
                    txtLastLogin.Text = dr["Last_Login_Date"].ToString();
                }
                else
                {
                    txtLastLogin.Text = "No login date recorded.";
                }
            }

            con.Close();
        }

        private void loadResultSubjects()
        {
            int studentId = Convert.ToInt32(Session["Student_Id"]);

            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = @"SELECT DISTINCT
                            sub.Subject_Id,
                            sub.Subject_Name
                        FROM Subject sub
                        INNER JOIN StudentSubjectReservation r
                            ON sub.Subject_Id = r.Subject_Id
                        WHERE r.Student_Id = @Student_Id
                        AND r.Status = 'Accepted'
                        ORDER BY sub.Subject_Name";

            cmd.Parameters.AddWithValue("@Student_Id", studentId);
            cmd.Connection = con;

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();

            da.Fill(dt);

            ddlResultSubject.DataSource = dt;
            ddlResultSubject.DataTextField = "Subject_Name";
            ddlResultSubject.DataValueField = "Subject_Id";
            ddlResultSubject.DataBind();

            ddlResultSubject.Items.Insert(0, new ListItem("-- Select Subject --", "0"));
        }

        private void loadReservations()
        {
            int studentId = Convert.ToInt32(Session["Student_Id"]);

            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = @"SELECT
                            r.Reservation_Id,
                            sub.Subject_Name,
                            t.Tutor_Name,
                            sub.Timetable,
                            sub.Fees,
                            r.Status
                        FROM StudentSubjectReservation r
                        INNER JOIN Subject sub
                            ON r.Subject_Id = sub.Subject_Id
                        INNER JOIN Tutor t
                            ON sub.Tutor_Id = t.Tutor_Id
                        WHERE r.Student_Id = @Student_Id
                        ORDER BY r.Reservation_Id DESC";

            cmd.Parameters.AddWithValue("@Student_Id", studentId);
            cmd.Connection = con;

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();

            da.Fill(dt);

            gvReservations.DataSource = dt;
            gvReservations.DataBind();
        }

        private void loadPaymentReservations()
        {
            int studentId = Convert.ToInt32(Session["Student_Id"]);

            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = @"SELECT
                            r.Reservation_Id,
                            sub.Subject_Name,
                            t.Tutor_Name
                        FROM StudentSubjectReservation r
                        INNER JOIN Subject sub
                            ON r.Subject_Id = sub.Subject_Id
                        INNER JOIN Tutor t
                            ON sub.Tutor_Id = t.Tutor_Id
                        WHERE r.Student_Id = @Student_Id
                        AND r.Status = 'Accepted'
                        ORDER BY r.Reservation_Id DESC";

            cmd.Parameters.AddWithValue("@Student_Id", studentId);
            cmd.Connection = con;

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();

            da.Fill(dt);

            ddlPaymentReservation.DataSource = dt;
            ddlPaymentReservation.DataTextField = "Subject_Name";
            ddlPaymentReservation.DataValueField = "Reservation_Id";
            ddlPaymentReservation.DataBind();

            ddlPaymentReservation.Items.Insert(0, new ListItem("-- Select Reservation --", "0"));
        }

        private void loadPayments()
        {
            int studentId = Convert.ToInt32(Session["Student_Id"]);

            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = @"SELECT
                            p.Payment_Id,
                            p.Payment_Amount,
                            p.Payment_Date,
                            sub.Subject_Name,
                            t.Tutor_Name
                        FROM Payment p
                        INNER JOIN StudentSubjectReservation r
                            ON p.Reservation_Id = r.Reservation_Id
                        INNER JOIN Subject sub
                            ON r.Subject_Id = sub.Subject_Id
                        INNER JOIN Tutor t
                            ON sub.Tutor_Id = t.Tutor_Id
                        WHERE r.Student_Id = @Student_Id
                        ORDER BY p.Payment_Id DESC";

            cmd.Parameters.AddWithValue("@Student_Id", studentId);
            cmd.Connection = con;

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();

            da.Fill(dt);

            gvPayments.DataSource = dt;
            gvPayments.DataBind();
        }

        private void loadMyTestimonials()
        {
            int studentId = Convert.ToInt32(Session["Student_Id"]);

            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = @"SELECT
                            Testimonial_Text,
                            Rating
                        FROM Testimonial
                        WHERE Student_Id = @Student_Id
                        ORDER BY Testimonial_Id DESC";

            cmd.Parameters.AddWithValue("@Student_Id", studentId);
            cmd.Connection = con;

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();

            da.Fill(dt);

            rptMyTestimonials.DataSource = dt;
            rptMyTestimonials.DataBind();
        }
        private void loadRecommendationSubjects()
        {
            int studentId = Convert.ToInt32(Session["Student_Id"]);

            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = @"SELECT DISTINCT
                            sub.Subject_Id,
                            sub.Subject_Name
                        FROM Subject sub
                        INNER JOIN StudentSubjectReservation r
                            ON sub.Subject_Id = r.Subject_Id
                        WHERE r.Student_Id = @Student_Id
                        AND r.Status = 'Accepted'
                        ORDER BY sub.Subject_Name";

            cmd.Parameters.AddWithValue("@Student_Id", studentId);
            cmd.Connection = con;

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();

            da.Fill(dt);

            ddlRecommendSubject.DataSource = dt;
            ddlRecommendSubject.DataTextField = "Subject_Name";
            ddlRecommendSubject.DataValueField = "Subject_Id";
            ddlRecommendSubject.DataBind();

            ddlRecommendSubject.Items.Insert(0, new ListItem("-- Select Subject --", "0"));
        }

        private void loadRecommendations()
        {
            int studentId = Convert.ToInt32(Session["Student_Id"]);

            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = @"SELECT
                            sub.Subject_Name,
                            t.Tutor_Name
                        FROM StudentSubjectRecommendation rec
                        INNER JOIN Subject sub
                            ON rec.Subject_Id = sub.Subject_Id
                        INNER JOIN Tutor t
                            ON sub.Tutor_Id = t.Tutor_Id
                        WHERE rec.Student_Id = @Student_Id
                        ORDER BY rec.Recommendation_Id DESC";

            cmd.Parameters.AddWithValue("@Student_Id", studentId);
            cmd.Connection = con;

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();

            da.Fill(dt);

            gvRecommendations.DataSource = dt;
            gvRecommendations.DataBind();
        }

        protected void btnUpdateProfile_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            int studentId = Convert.ToInt32(Session["Student_Id"]);

            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = @"UPDATE Student
                        SET Student_Name=@Student_Name,
                            Student_Email=@Student_Email,
                            Student_Phone=@Student_Phone,
                            District_Id=@District_Id,
                            Grade_Id=@Grade_Id
                        WHERE Student_Id=@Student_Id";

            cmd.Parameters.AddWithValue("@Student_Name", txtStudentName.Text.Trim());
            cmd.Parameters.AddWithValue("@Student_Email", txtStudentEmail.Text.Trim());
            cmd.Parameters.AddWithValue("@Student_Phone", txtStudentPhone.Text.Trim());
            cmd.Parameters.AddWithValue("@District_Id", ddlDistrict.SelectedValue);
            cmd.Parameters.AddWithValue("@Grade_Id", ddlGrade.SelectedValue);
            cmd.Parameters.AddWithValue("@Student_Id", studentId);

            cmd.Connection = con;

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            lblMessage.Text = "Profile updated successfully.";
            lblMessage.ForeColor = System.Drawing.Color.Green;
        
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            int studentId = Convert.ToInt32(Session["Student_Id"]);

            SqlConnection con = new SqlConnection(_conString);
            con.Open();

            SqlCommand checkCmd = new SqlCommand(
                "SELECT Student_Password FROM Student WHERE Student_Id=@Student_Id", con);

            checkCmd.Parameters.AddWithValue("@Student_Id", studentId);

            string currentPassword = checkCmd.ExecuteScalar().ToString();

            if (currentPassword != txtCurrentPassword.Text.Trim())
            {
                lblPasswordMessage.Text = "Current password is incorrect.";
                lblPasswordMessage.ForeColor = System.Drawing.Color.Red;

                con.Close();
                return;
            }

            SqlCommand updateCmd = new SqlCommand(
                "UPDATE Student SET Student_Password=@Password WHERE Student_Id=@Student_Id", con);

            updateCmd.Parameters.AddWithValue("@Password", txtNewPassword.Text.Trim());
            updateCmd.Parameters.AddWithValue("@Student_Id", studentId);

            updateCmd.ExecuteNonQuery();

            con.Close();

            lblPasswordMessage.Text = "Password changed successfully.";
            lblPasswordMessage.ForeColor = System.Drawing.Color.Green;

            txtCurrentPassword.Text = "";
            txtNewPassword.Text = "";
            txtConfirmPassword.Text = "";
        }

        protected void btnSubmitResult_Click(object sender, EventArgs e)
        {

            if (!Page.IsValid)
            {
                return;
            }

            int studentId = Convert.ToInt32(Session["Student_Id"]);

            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = @"INSERT INTO [Result]
                        (Qualification, [Year], Marks, Student_Id, Subject_Id)
                        VALUES
                        (@Qualification, @Year, @Marks, @Student_Id, @Subject_Id)";

            cmd.Parameters.AddWithValue("@Qualification", txtQualification.Text.Trim());
            cmd.Parameters.AddWithValue("@Year", txtResultYear.Text.Trim());
            cmd.Parameters.AddWithValue("@Marks", txtMarks.Text.Trim());
            cmd.Parameters.AddWithValue("@Student_Id", studentId);
            cmd.Parameters.AddWithValue("@Subject_Id", ddlResultSubject.SelectedValue);

            cmd.Connection = con;

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            lblResultMessage.Text = "Academic result submitted successfully.";
            lblResultMessage.ForeColor = System.Drawing.Color.Green;

            txtQualification.Text = "";
            txtResultYear.Text = "";
            txtMarks.Text = "";
            ddlResultSubject.SelectedIndex = 0;

        }

        protected void btnMakePayment_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = @"INSERT INTO Payment
                        (Payment_Amount, Payment_Date, Reservation_Id)
                        VALUES
                        (@Payment_Amount, @Payment_Date, @Reservation_Id)";

            cmd.Parameters.AddWithValue("@Payment_Amount", txtPaymentAmount.Text.Trim());
            cmd.Parameters.AddWithValue("@Payment_Date", DateTime.Now);
            cmd.Parameters.AddWithValue("@Reservation_Id", ddlPaymentReservation.SelectedValue);

            cmd.Connection = con;

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            lblPaymentMessage.Text = "Payment recorded successfully.";
            lblPaymentMessage.ForeColor = System.Drawing.Color.Green;

            txtPaymentAmount.Text = "";
            ddlPaymentReservation.SelectedIndex = 0;

            loadPayments();

        }

        protected void btnAddTestimonial_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            int studentId = Convert.ToInt32(Session["Student_Id"]);

            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = @"INSERT INTO Testimonial
                        (Testimonial_Text, Student_Id, Rating)
                        VALUES
                        (@Testimonial_Text, @Student_Id, @Rating)";

            cmd.Parameters.AddWithValue("@Testimonial_Text", txtTestimonial.Text.Trim());
            cmd.Parameters.AddWithValue("@Student_Id", studentId);
            cmd.Parameters.AddWithValue("@Rating", ddlRating.SelectedValue);

            cmd.Connection = con;

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            lblTestimonialMessage.Text = "Testimonial submitted successfully.";
            lblTestimonialMessage.ForeColor = System.Drawing.Color.Green;

            txtTestimonial.Text = "";
            ddlRating.SelectedIndex = 0;

            loadMyTestimonials();
        }

        protected void btnRecommendSubject_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            int studentId = Convert.ToInt32(Session["Student_Id"]);
            int subjectId = Convert.ToInt32(ddlRecommendSubject.SelectedValue);

            SqlConnection con = new SqlConnection(_conString);
            con.Open();

            SqlCommand checkCmd = new SqlCommand();

            checkCmd.CommandText = @"SELECT COUNT(*)
                         FROM StudentSubjectRecommendation rec
                         INNER JOIN Subject sub1
                            ON rec.Subject_Id = sub1.Subject_Id
                         INNER JOIN Subject sub2
                            ON sub1.Tutor_Id = sub2.Tutor_Id
                         WHERE rec.Student_Id = @Student_Id
                         AND sub2.Subject_Id = @Subject_Id";

            checkCmd.Parameters.AddWithValue("@Student_Id", studentId);
            checkCmd.Parameters.AddWithValue("@Subject_Id", subjectId);
            checkCmd.Connection = con;

            int count = Convert.ToInt32(checkCmd.ExecuteScalar());

            if (count > 0)
            {
                lblRecommendationMessage.Text = "You have already recommended this tutor.";
                lblRecommendationMessage.ForeColor = System.Drawing.Color.Red;

                con.Close();
                return;
            }

            SqlCommand insertCmd = new SqlCommand();

            insertCmd.CommandText = @"INSERT INTO StudentSubjectRecommendation
                              (Student_Id, Subject_Id)
                              VALUES
                              (@Student_Id, @Subject_Id)";

            insertCmd.Parameters.AddWithValue("@Student_Id", studentId);
            insertCmd.Parameters.AddWithValue("@Subject_Id", subjectId);
            insertCmd.Connection = con;

            insertCmd.ExecuteNonQuery();

            con.Close();

            lblRecommendationMessage.Text = "Subject recommended successfully.";
            lblRecommendationMessage.ForeColor = System.Drawing.Color.Green;

            ddlRecommendSubject.SelectedIndex = 0;

            loadRecommendations();
        }
    }
}