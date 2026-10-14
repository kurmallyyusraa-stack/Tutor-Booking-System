using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.Configuration;
using System.Net.Mail;
using System.Net.Configuration;
using System.Configuration;
namespace coursework_29153
{
    public partial class tutorprofile : System.Web.UI.Page
    {
        private string _conString =
        WebConfigurationManager.ConnectionStrings["MoProfCS"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["Tutor_Id"] == null)
            {
                Response.Redirect("login.aspx");
            }

            if (!IsPostBack)
            {
                loadTutorProfile();

                loadCategory();
                loadGrade();
                loadDistrict();

                loadEditCategory();
                loadEditGrade();
                loadEditDistrict();
                loadManageSubjects();

                loadMyAnnouncements();

                loadBookingRequests();

                loadEnrolledStudents();

                loadStudentResults();

            }
        }

        private void sendBookingConfirmationEmail(int reservationId)
        {
            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = @"SELECT
                            st.Student_Name,
                            st.Student_Email,
                            sub.Subject_Name,
                            sub.Timetable,
                            sub.Location,
                            t.Tutor_Name
                        FROM StudentSubjectReservation r
                        INNER JOIN Student st
                            ON r.Student_Id = st.Student_Id
                        INNER JOIN Subject sub
                            ON r.Subject_Id = sub.Subject_Id
                        INNER JOIN Tutor t
                            ON sub.Tutor_Id = t.Tutor_Id
                        WHERE r.Reservation_Id = @Reservation_Id";

            cmd.Parameters.AddWithValue("@Reservation_Id", reservationId);
            cmd.Connection = con;

            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                string studentName = dr["Student_Name"].ToString();
                string studentEmail = dr["Student_Email"].ToString();
                string subjectName = dr["Subject_Name"].ToString();
                string timetable = dr["Timetable"].ToString();
                string location = dr["Location"].ToString();
                string tutorName = dr["Tutor_Name"].ToString();

                MailMessage mail = new MailMessage();

                mail.To.Add(studentEmail);
                mail.Subject = "MoProf Seat Reservation Confirmed";

                mail.Body = "Dear " + studentName + ",<br/><br/>" +
                            "Your seat reservation has been accepted.<br/><br/>" +
                            "<strong>Subject:</strong> " + subjectName + "<br/>" +
                            "<strong>Tutor:</strong> " + tutorName + "<br/>" +
                            "<strong>Timetable:</strong> " + timetable + "<br/>" +
                            "<strong>Location:</strong> " + location + "<br/><br/>" +
                            "Thank you for using MoProf.<br/><br/>" +
                            "Regards,<br/>MoProf Team";

                mail.IsBodyHtml = true;

                SmtpSection smtpSection =
                    (SmtpSection)ConfigurationManager.GetSection("system.net/mailSettings/smtp");

                mail.From = new MailAddress(smtpSection.From);

                SmtpClient smtp = new SmtpClient();
                smtp.Send(mail);
            }

            con.Close();
        }



        private void loadTutorProfile()
        {
            int tutorId = Convert.ToInt32(Session["Tutor_Id"]);

            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = "SELECT * FROM Tutor WHERE Tutor_Id=@Tutor_Id";
            cmd.Parameters.AddWithValue("@Tutor_Id", tutorId);
            cmd.Connection = con;

            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                txtTutorName.Text = dr["Tutor_Name"].ToString();
                txtTutorEmail.Text = dr["Tutor_Email"].ToString();
                txtTutorPhone.Text = dr["Tutor_Phone"].ToString();
                txtQualification.Text = dr["Qualification"].ToString();
                txtSkills.Text = dr["Skills"].ToString();
                txtExperience.Text = dr["Experience"].ToString();

                if (dr["Profile_Picture"] != DBNull.Value && dr["Profile_Picture"].ToString() != "")
                {
                    imgTutor.ImageUrl = dr["Profile_Picture"].ToString();
                }
                else
                {
                    imgTutor.ImageUrl = "assets/images/teachers/teacher-1.jpg";
                }

                if (dr["Account_Status"] != DBNull.Value)
                {
                    ddlAccountStatus.SelectedValue = dr["Account_Status"].ToString();
                }

            }

            con.Close();
        }


        private void loadCategory()
        {
            SqlConnection con = new SqlConnection(_conString);

            SqlCommand cmd = new SqlCommand(
                "SELECT Category_Id, Category_Name FROM Category", con);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();

            da.Fill(dt);

            ddlCategory.DataSource = dt;
            ddlCategory.DataTextField = "Category_Name";
            ddlCategory.DataValueField = "Category_Id";
            ddlCategory.DataBind();
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
        }

        private void loadManageSubjects()
        {
            int tutorId = Convert.ToInt32(Session["Tutor_Id"]);

            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = "SELECT Subject_Id, Subject_Name FROM Subject WHERE Tutor_Id=@Tutor_Id";
            cmd.Parameters.AddWithValue("@Tutor_Id", tutorId);
            cmd.Connection = con;

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            ddlManageSubject.DataSource = dt;
            ddlManageSubject.DataTextField = "Subject_Name";
            ddlManageSubject.DataValueField = "Subject_Id";
            ddlManageSubject.DataBind();

            ddlManageSubject.Items.Insert(0, new ListItem("-- Select Subject --", ""));
        }

        private void loadEditCategory()
        {
            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand("SELECT Category_Id, Category_Name FROM Category", con);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            ddlEditCategory.DataSource = dt;
            ddlEditCategory.DataTextField = "Category_Name";
            ddlEditCategory.DataValueField = "Category_Id";
            ddlEditCategory.DataBind();
        }

        private void loadEditGrade()
        {
            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand("SELECT Grade_Id, Grade_Name FROM Grade", con);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            ddlEditGrade.DataSource = dt;
            ddlEditGrade.DataTextField = "Grade_Name";
            ddlEditGrade.DataValueField = "Grade_Id";
            ddlEditGrade.DataBind();
        }

        private void loadEditDistrict()
        {
            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand("SELECT District_Id, District_Name FROM District", con);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            ddlEditDistrict.DataSource = dt;
            ddlEditDistrict.DataTextField = "District_Name";
            ddlEditDistrict.DataValueField = "District_Id";
            ddlEditDistrict.DataBind();
        }

        private void loadMyAnnouncements()
        {
            int tutorId = Convert.ToInt32(Session["Tutor_Id"]);

            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = @"SELECT Announcement_Text 
                        FROM Announcement 
                        WHERE Tutor_Id=@Tutor_Id
                        ORDER BY Announcement_Id DESC";

            cmd.Parameters.AddWithValue("@Tutor_Id", tutorId);
            cmd.Connection = con;

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();

            da.Fill(dt);

            rptMyAnnouncements.DataSource = dt;
            rptMyAnnouncements.DataBind();
        }


        private void loadBookingRequests()
        {
            int tutorId = Convert.ToInt32(Session["Tutor_Id"]);

            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = @"SELECT
                        r.Reservation_Id,
                        st.Student_Name,
                        sub.Subject_Name,
                        r.Status
                    FROM StudentSubjectReservation r
                    INNER JOIN Student st
                        ON r.Student_Id = st.Student_Id
                    INNER JOIN Subject sub
                        ON r.Subject_Id = sub.Subject_Id
                    WHERE sub.Tutor_Id = @Tutor_Id
                    AND r.Status = 'Pending'";

            cmd.Parameters.AddWithValue("@Tutor_Id", tutorId);
            cmd.Connection = con;

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvBookingRequests.DataSource = dt;
            gvBookingRequests.DataBind();
        }

        private void loadEnrolledStudents()
        {
            int tutorId = Convert.ToInt32(Session["Tutor_Id"]);

            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = @"SELECT
                            st.Student_Id,
                            st.Student_Name,
                            sub.Subject_Name,
                            st.Last_Login_Date
                        FROM StudentSubjectReservation r
                        INNER JOIN Student st
                            ON r.Student_Id = st.Student_Id
                        INNER JOIN Subject sub
                            ON r.Subject_Id = sub.Subject_Id
                        WHERE sub.Tutor_Id = @Tutor_Id
                        AND r.Status = 'Accepted'";

            cmd.Parameters.AddWithValue("@Tutor_Id", tutorId);

            cmd.Connection = con;

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();

            da.Fill(dt);

            gvEnrolledStudents.DataSource = dt;
            gvEnrolledStudents.DataBind();
        }

        private void loadStudentResults()
        {
            int tutorId = Convert.ToInt32(Session["Tutor_Id"]);

            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = @"SELECT
                            st.Student_Name,
                            sub.Subject_Name,
                            r.Qualification,
                            r.Year,
                            r.Marks
                        FROM Result r
                        INNER JOIN Student st
                            ON r.Student_Id = st.Student_Id
                        INNER JOIN Subject sub
                            ON r.Subject_Id = sub.Subject_Id
                        WHERE sub.Tutor_Id = @Tutor_Id";

            cmd.Parameters.AddWithValue("@Tutor_Id", tutorId);
            cmd.Connection = con;

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();

            da.Fill(dt);

            gvStudentResults.DataSource = dt;
            gvStudentResults.DataBind();
        }


        protected void btnUpdateProfile_Click(object sender, EventArgs e)
        {
            int tutorId = Convert.ToInt32(Session["Tutor_Id"]);

            string profilePicturePath = "";

            if (fuProfilePicture.HasFile)
            {
                string fileName = Path.GetFileName(fuProfilePicture.FileName);
                string folderPath = Server.MapPath("~/assets/images/teachers/");
                string fullPath = folderPath + fileName;

                fuProfilePicture.SaveAs(fullPath);

                profilePicturePath = "assets/images/teachers/" + fileName;
            }
            else
            {
                profilePicturePath = imgTutor.ImageUrl;
            }

            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = @"UPDATE Tutor
                                SET Tutor_Name=@Tutor_Name,
                                    Tutor_Email=@Tutor_Email,
                                    Tutor_Phone=@Tutor_Phone,
                                    Qualification=@Qualification,
                                    Skills=@Skills,
                                    Experience=@Experience,
                                    Profile_Picture=@Profile_Picture
                                WHERE Tutor_Id=@Tutor_Id";

            cmd.Parameters.AddWithValue("@Tutor_Name", txtTutorName.Text.Trim());
            cmd.Parameters.AddWithValue("@Tutor_Email", txtTutorEmail.Text.Trim());
            cmd.Parameters.AddWithValue("@Tutor_Phone", txtTutorPhone.Text.Trim());
            cmd.Parameters.AddWithValue("@Qualification", txtQualification.Text.Trim());
            cmd.Parameters.AddWithValue("@Skills", txtSkills.Text.Trim());
            cmd.Parameters.AddWithValue("@Experience", txtExperience.Text.Trim());
            cmd.Parameters.AddWithValue("@Profile_Picture", profilePicturePath);
            cmd.Parameters.AddWithValue("@Tutor_Id", tutorId);

            cmd.Connection = con;

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            lblMessage.Text = "Profile updated successfully.";
            lblMessage.ForeColor = System.Drawing.Color.Green;

            imgTutor.ImageUrl = profilePicturePath;
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            int tutorId = Convert.ToInt32(Session["Tutor_Id"]);

            SqlConnection con = new SqlConnection(_conString);
            con.Open();

            
            SqlCommand checkCmd = new SqlCommand(
                "SELECT Tutor_Password FROM Tutor WHERE Tutor_Id=@Tutor_Id", con);

            checkCmd.Parameters.AddWithValue("@Tutor_Id", tutorId);

            string currentPassword = checkCmd.ExecuteScalar().ToString();

            if (currentPassword != txtCurrentPassword.Text.Trim())
            {
                lblPasswordMessage.Text = "Current password is incorrect.";
                lblPasswordMessage.ForeColor = System.Drawing.Color.Red;

                con.Close();
                return;
            }

          
            SqlCommand updateCmd = new SqlCommand(
                "UPDATE Tutor SET Tutor_Password=@Password WHERE Tutor_Id=@Tutor_Id", con);

            updateCmd.Parameters.AddWithValue("@Password", txtNewPassword.Text.Trim());
            updateCmd.Parameters.AddWithValue("@Tutor_Id", tutorId);

            updateCmd.ExecuteNonQuery();

            con.Close();

            lblPasswordMessage.Text = "Password changed successfully.";
            lblPasswordMessage.ForeColor = System.Drawing.Color.Green;

            txtCurrentPassword.Text = "";
            txtNewPassword.Text = "";
            txtConfirmPassword.Text = "";
        }

        protected void btnAddSubject_Click(object sender, EventArgs e)
        {
            int tutorId = Convert.ToInt32(Session["Tutor_Id"]);

            using (SqlConnection con = new SqlConnection(_conString))
            {
                SqlCommand cmd = new SqlCommand();

                cmd.CommandText = @"INSERT INTO Subject
                            (Subject_Name, Category_Id, Tutor_Id, District_Id, Grade_Id,
                             Fees, Timetable, Availability, Location, Teaching_Experience)
                            VALUES
                            (@Subject_Name, @Category_Id, @Tutor_Id, @District_Id, @Grade_Id,
                             @Fees, @Timetable, @Availability, @Location, @Teaching_Experience)";

                cmd.Parameters.AddWithValue("@Subject_Name", txtSubjectName.Text.Trim());
                cmd.Parameters.AddWithValue("@Category_Id", ddlCategory.SelectedValue);
                cmd.Parameters.AddWithValue("@Tutor_Id", tutorId);
                cmd.Parameters.AddWithValue("@District_Id", ddlDistrict.SelectedValue);
                cmd.Parameters.AddWithValue("@Grade_Id", ddlGrade.SelectedValue);
                cmd.Parameters.AddWithValue("@Fees", txtFees.Text.Trim());
                cmd.Parameters.AddWithValue("@Timetable", txtTimetable.Text.Trim());
                cmd.Parameters.AddWithValue("@Availability", ddlAvailability.SelectedValue);
                cmd.Parameters.AddWithValue("@Location", txtLocation.Text.Trim());
                cmd.Parameters.AddWithValue("@Teaching_Experience", txtTeachingExperience.Text.Trim());

                cmd.Connection = con;

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();

                lblSubjectMessage.Text = "Subject added successfully.";
                lblSubjectMessage.ForeColor = System.Drawing.Color.Green;
                loadManageSubjects();
                txtSubjectName.Text = "";
                txtFees.Text = "";
                txtTimetable.Text = "";
                txtLocation.Text = "";
                txtTeachingExperience.Text = "";

                ddlCategory.SelectedIndex = 0;
                ddlGrade.SelectedIndex = 0;
                ddlDistrict.SelectedIndex = 0;
                ddlAvailability.SelectedIndex = 0;
            }
        }

        protected void ddlManageSubject_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlManageSubject.SelectedValue == "")
            {
                return;
            }

            int tutorId = Convert.ToInt32(Session["Tutor_Id"]);
            int subjectId = Convert.ToInt32(ddlManageSubject.SelectedValue);

            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = @"SELECT *
                        FROM Subject
                        WHERE Subject_Id=@Subject_Id
                        AND Tutor_Id=@Tutor_Id";

            cmd.Parameters.AddWithValue("@Subject_Id", subjectId);
            cmd.Parameters.AddWithValue("@Tutor_Id", tutorId);
            cmd.Connection = con;

            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                txtEditSubjectName.Text = dr["Subject_Name"].ToString();
                ddlEditCategory.SelectedValue = dr["Category_Id"].ToString();
                ddlEditGrade.SelectedValue = dr["Grade_Id"].ToString();
                ddlEditDistrict.SelectedValue = dr["District_Id"].ToString();
                txtEditFees.Text = dr["Fees"].ToString();
                txtEditTimetable.Text = dr["Timetable"].ToString();
                ddlEditAvailability.SelectedValue = dr["Availability"].ToString();
                txtEditLocation.Text = dr["Location"].ToString();
                txtEditTeachingExperience.Text = dr["Teaching_Experience"].ToString();
            }

            con.Close();
        }

        protected void btnUpdateSubject_Click(object sender, EventArgs e)
        {
            if (ddlManageSubject.SelectedValue == "")
            {
                lblManageSubject.Text = "Please select a subject to update.";
                lblManageSubject.ForeColor = System.Drawing.Color.Red;
                return;
            }

            int tutorId = Convert.ToInt32(Session["Tutor_Id"]);
            int subjectId = Convert.ToInt32(ddlManageSubject.SelectedValue);

            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = @"UPDATE Subject
                        SET Subject_Name=@Subject_Name,
                            Category_Id=@Category_Id,
                            Grade_Id=@Grade_Id,
                            District_Id=@District_Id,
                            Fees=@Fees,
                            Timetable=@Timetable,
                            Availability=@Availability,
                            Location=@Location,
                            Teaching_Experience=@Teaching_Experience
                        WHERE Subject_Id=@Subject_Id
                        AND Tutor_Id=@Tutor_Id";

            cmd.Parameters.AddWithValue("@Subject_Name", txtEditSubjectName.Text.Trim());
            cmd.Parameters.AddWithValue("@Category_Id", ddlEditCategory.SelectedValue);
            cmd.Parameters.AddWithValue("@Grade_Id", ddlEditGrade.SelectedValue);
            cmd.Parameters.AddWithValue("@District_Id", ddlEditDistrict.SelectedValue);
            cmd.Parameters.AddWithValue("@Fees", txtEditFees.Text.Trim());
            cmd.Parameters.AddWithValue("@Timetable", txtEditTimetable.Text.Trim());
            cmd.Parameters.AddWithValue("@Availability", ddlEditAvailability.SelectedValue);
            cmd.Parameters.AddWithValue("@Location", txtEditLocation.Text.Trim());
            cmd.Parameters.AddWithValue("@Teaching_Experience", txtEditTeachingExperience.Text.Trim());
            cmd.Parameters.AddWithValue("@Subject_Id", subjectId);
            cmd.Parameters.AddWithValue("@Tutor_Id", tutorId);

            cmd.Connection = con;

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            lblManageSubject.Text = "Subject updated successfully.";
            lblManageSubject.ForeColor = System.Drawing.Color.Green;

            loadManageSubjects();
        }

        protected void btnDeleteSubject_Click(object sender, EventArgs e)
        {

            if (ddlManageSubject.SelectedValue == "")
            {
                lblManageSubject.Text = "Please select a subject to delete.";
                lblManageSubject.ForeColor = System.Drawing.Color.Red;
                return;
            }

            int tutorId = Convert.ToInt32(Session["Tutor_Id"]);
            int subjectId = Convert.ToInt32(ddlManageSubject.SelectedValue);

            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = @"DELETE FROM Subject
                        WHERE Subject_Id=@Subject_Id
                        AND Tutor_Id=@Tutor_Id";

            cmd.Parameters.AddWithValue("@Subject_Id", subjectId);
            cmd.Parameters.AddWithValue("@Tutor_Id", tutorId);

            cmd.Connection = con;

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            lblManageSubject.Text = "Subject deleted successfully.";
            lblManageSubject.ForeColor = System.Drawing.Color.Green;

            txtEditSubjectName.Text = "";
            txtEditFees.Text = "";
            txtEditTimetable.Text = "";
            txtEditLocation.Text = "";
            txtEditTeachingExperience.Text = "";

            loadManageSubjects();
        }

        protected void btnUpdateStatus_Click(object sender, EventArgs e)
        {
            int tutorId = Convert.ToInt32(Session["Tutor_Id"]);

            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = "UPDATE Tutor SET Account_Status=@Account_Status WHERE Tutor_Id=@Tutor_Id";

            cmd.Parameters.AddWithValue("@Account_Status", ddlAccountStatus.SelectedValue);
            cmd.Parameters.AddWithValue("@Tutor_Id", tutorId);

            cmd.Connection = con;

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            lblStatusMessage.Text = "Account status updated successfully.";
            lblStatusMessage.ForeColor = System.Drawing.Color.Green;
        }


        protected void btnPostAnnouncement_Click(object sender, EventArgs e)
        {
            int tutorId = Convert.ToInt32(Session["Tutor_Id"]);

            using (SqlConnection con = new SqlConnection(_conString))
            {
                SqlCommand cmd = new SqlCommand();

                cmd.CommandText = @"INSERT INTO Announcement
                            (Announcement_Text, Tutor_Id)
                            VALUES
                            (@Announcement_Text, @Tutor_Id)";

                cmd.Parameters.AddWithValue("@Announcement_Text",
                    txtAnnouncement.Text.Trim());

                cmd.Parameters.AddWithValue("@Tutor_Id", tutorId);

                cmd.Connection = con;

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }

            lblAnnouncementMessage.Text = "Announcement posted successfully.";
            lblAnnouncementMessage.ForeColor = System.Drawing.Color.Green;

            txtAnnouncement.Text = "";
            loadMyAnnouncements();

        }

        protected void gvBookingRequests_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "AcceptBooking" || e.CommandName == "RejectBooking")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                int reservationId = Convert.ToInt32(gvBookingRequests.DataKeys[rowIndex].Value);

                string status;

                if (e.CommandName == "AcceptBooking")
                {
                    status = "Accepted";
                }
                else
                {
                    status = "Rejected";
                }

                SqlConnection con = new SqlConnection(_conString);
                SqlCommand cmd = new SqlCommand();

                cmd.CommandText = @"UPDATE StudentSubjectReservation
                            SET Status = @Status
                            WHERE Reservation_Id = @Reservation_Id";

                cmd.Parameters.AddWithValue("@Status", status);
                cmd.Parameters.AddWithValue("@Reservation_Id", reservationId);

                cmd.Connection = con;

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();

                if (status == "Accepted")
                {
                    sendBookingConfirmationEmail(reservationId);
                }

                lblBookingMessage.Text = "Booking request has been " + status.ToLower() + ".";
                lblBookingMessage.ForeColor = System.Drawing.Color.Green;

                loadBookingRequests();

                lblBookingMessage.Text = "Booking request has been " + status.ToLower() + ".";
                lblBookingMessage.ForeColor = System.Drawing.Color.Green;

                loadBookingRequests();
            }
        }
    }
}