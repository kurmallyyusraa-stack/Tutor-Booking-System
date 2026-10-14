using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Net.Mail;
using System.Net.Configuration;
using System.Configuration;

namespace coursework_29153
{
    public partial class admindashboard : System.Web.UI.Page
    {
        private string _conString =
        WebConfigurationManager.ConnectionStrings["MoProfCS"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Admin_Id"] == null)
            {
                Response.Redirect("login.aspx");
            }

            if (!IsPostBack)
            {
                loadAnalytics();
                loadRegistrationStatus();
                loadPendingTutors();
                loadCategories();
                loadGrades();
                loadDistricts();

                loadUsers("");
            }
        }

        private void loadCategories()
        {
            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = "SELECT Category_Id, Category_Name FROM Category ORDER BY Category_Id";
            cmd.Connection = con;

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();

            da.Fill(dt);

            gvCategory.DataSource = dt;
            gvCategory.DataBind();
        }

        private void loadAnalytics()
        {
            SqlConnection con = new SqlConnection(_conString);
            con.Open();

            SqlCommand studentCmd = new SqlCommand("SELECT COUNT(*) FROM Student", con);
            SqlCommand tutorCmd = new SqlCommand("SELECT COUNT(*) FROM Tutor", con);
            SqlCommand subjectCmd = new SqlCommand("SELECT COUNT(*) FROM Subject", con);

            lblTotalStudents.Text = studentCmd.ExecuteScalar().ToString();
            lblTotalTutors.Text = tutorCmd.ExecuteScalar().ToString();
            lblTotalSubjects.Text = subjectCmd.ExecuteScalar().ToString();

            con.Close();
        }

        private void loadRegistrationStatus()
        {
            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = @"SELECT Setting_Name, Setting_Value
                        FROM SiteSetting
                        WHERE Setting_Name IN 
                        ('StudentRegistrationStatus', 'TutorRegistrationStatus')";

            cmd.Connection = con;

            con.Open();

            SqlDataReader dr = cmd.ExecuteReader();

            while (dr.Read())
            {
                if (dr["Setting_Name"].ToString() == "StudentRegistrationStatus")
                {
                    ddlStudentRegistrationStatus.SelectedValue = dr["Setting_Value"].ToString();
                }

                if (dr["Setting_Name"].ToString() == "TutorRegistrationStatus")
                {
                    ddlTutorRegistrationStatus.SelectedValue = dr["Setting_Value"].ToString();
                }
            }

            con.Close();
        }

        private void loadPendingTutors()
        {
            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = @"SELECT
                            Tutor_Id,
                            Tutor_Name,
                            Tutor_Email,
                            Qualification,
                            Skills,
                            Experience,
                            Approval_Status
                        FROM Tutor
                        WHERE Approval_Status = 'Pending'
                        ORDER BY Tutor_Id DESC";

            cmd.Connection = con;

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();

            da.Fill(dt);

            gvPendingTutors.DataSource = dt;
            gvPendingTutors.DataBind();
        }

        private void sendTutorApprovalEmail(string tutorEmail, string tutorName, string status)
        {
            MailMessage mail = new MailMessage();

            mail.To.Add(tutorEmail);

            if (status == "Accepted")
            {
                mail.Subject = "MoProf Tutor Registration Accepted";

                mail.Body = "Dear " + tutorName + ",<br/><br/>" +
                            "Your tutor registration has been accepted by the MoProf administrator.<br/>" +
                            "You can now log in and start adding your subjects.<br/><br/>" +
                            "Regards,<br/>MoProf Team";
            }
            else
            {
                mail.Subject = "MoProf Tutor Registration Denied";

                mail.Body = "Dear " + tutorName + ",<br/><br/>" +
                            "We are sorry to inform you that your tutor registration has been denied by the MoProf administrator.<br/><br/>" +
                            "Regards,<br/>MoProf Team";
            }

            mail.IsBodyHtml = true;

            SmtpSection smtpSection =
                (SmtpSection)ConfigurationManager.GetSection("system.net/mailSettings/smtp");

            mail.From = new MailAddress(smtpSection.From);

            SmtpClient smtp = new SmtpClient();
            smtp.Send(mail);
        }

        private void loadGrades()
        {
            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = "SELECT Grade_Id, Grade_Name FROM Grade ORDER BY Grade_Id";
            cmd.Connection = con;

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();

            da.Fill(dt);

            gvGrade.DataSource = dt;
            gvGrade.DataBind();
        }

        private void loadDistricts()
        {
            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = "SELECT District_Id, District_Name FROM District ORDER BY District_Id";
            cmd.Connection = con;

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();

            da.Fill(dt);

            gvDistrict.DataSource = dt;
            gvDistrict.DataBind();
        }

       
        protected void btnAddCategory_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = @"INSERT INTO Category
                        (Category_Name)
                        VALUES
                        (@Category_Name)";

            cmd.Parameters.AddWithValue("@Category_Name", txtCategoryName.Text.Trim());
            cmd.Connection = con;

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            lblCategoryMessage.Text = "Category added successfully.";
            lblCategoryMessage.ForeColor = System.Drawing.Color.Green;

            txtCategoryId.Text = "";
            txtCategoryName.Text = "";

            loadCategories();
            loadAnalytics();
        }

        private void loadUsers(string search)
        {
            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = @"SELECT
                            Student_Id AS UserId,
                            Student_Name AS UserName,
                            Student_Email AS UserEmail,
                            'Student' AS Role,
                            Account_Status AS Status
                        FROM Student
                        WHERE Student_Name LIKE @Search
                        OR Student_Email LIKE @Search
                        OR Account_Status LIKE @Search

                        UNION ALL

                        SELECT
                            Tutor_Id AS UserId,
                            Tutor_Name AS UserName,
                            Tutor_Email AS UserEmail,
                            'Tutor' AS Role,
                            Account_Status AS Status
                        FROM Tutor
                        WHERE Tutor_Name LIKE @Search
                        OR Tutor_Email LIKE @Search
                        OR Account_Status LIKE @Search

                        ORDER BY Role, UserName";

            cmd.Parameters.AddWithValue("@Search", "%" + search + "%");
            cmd.Connection = con;

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();

            da.Fill(dt);

            gvUsers.DataSource = dt;
            gvUsers.DataBind();
        }

        protected void btnUpdateCategory_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            if (txtCategoryId.Text == "")
            {
                lblCategoryMessage.Text = "Please select a category to update.";
                lblCategoryMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = @"UPDATE Category
                        SET Category_Name=@Category_Name
                        WHERE Category_Id=@Category_Id";

            cmd.Parameters.AddWithValue("@Category_Name", txtCategoryName.Text.Trim());
            cmd.Parameters.AddWithValue("@Category_Id", txtCategoryId.Text.Trim());
            cmd.Connection = con;

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            lblCategoryMessage.Text = "Category updated successfully.";
            lblCategoryMessage.ForeColor = System.Drawing.Color.Green;

            txtCategoryId.Text = "";
            txtCategoryName.Text = "";

            loadCategories();
        }

        protected void btnDeleteCategory_Click(object sender, EventArgs e)
        {
            if (txtCategoryId.Text == "")
            {
                lblCategoryMessage.Text = "Please select a category to delete.";
                lblCategoryMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = @"DELETE FROM Category
                        WHERE Category_Id=@Category_Id";

            cmd.Parameters.AddWithValue("@Category_Id", txtCategoryId.Text.Trim());
            cmd.Connection = con;

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            lblCategoryMessage.Text = "Category deleted successfully.";
            lblCategoryMessage.ForeColor = System.Drawing.Color.Green;

            txtCategoryId.Text = "";
            txtCategoryName.Text = "";

            loadCategories();
            loadAnalytics();
        }

        protected void btnClearCategory_Click(object sender, EventArgs e)
        {
            txtCategoryId.Text = "";
            txtCategoryName.Text = "";
            lblCategoryMessage.Text = "";
        }

        protected void gvCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtCategoryId.Text = gvCategory.SelectedRow.Cells[1].Text;
            txtCategoryName.Text = gvCategory.SelectedRow.Cells[2].Text;
        
        }

        protected void btnAddGrade_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = @"INSERT INTO Grade
                        (Grade_Name)
                        VALUES
                        (@Grade_Name)";

            cmd.Parameters.AddWithValue("@Grade_Name", txtGradeName.Text.Trim());
            cmd.Connection = con;

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            lblGradeMessage.Text = "Grade added successfully.";
            lblGradeMessage.ForeColor = System.Drawing.Color.Green;

            txtGradeId.Text = "";
            txtGradeName.Text = "";

            loadGrades();
        }

        protected void btnUpdateGrade_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            if (txtGradeId.Text == "")
            {
                lblGradeMessage.Text = "Please select a grade to update.";
                lblGradeMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = @"UPDATE Grade
                        SET Grade_Name=@Grade_Name
                        WHERE Grade_Id=@Grade_Id";

            cmd.Parameters.AddWithValue("@Grade_Name", txtGradeName.Text.Trim());
            cmd.Parameters.AddWithValue("@Grade_Id", txtGradeId.Text.Trim());
            cmd.Connection = con;

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            lblGradeMessage.Text = "Grade updated successfully.";
            lblGradeMessage.ForeColor = System.Drawing.Color.Green;

            txtGradeId.Text = "";
            txtGradeName.Text = "";

            loadGrades();
        }

        protected void btnDeleteGrade_Click(object sender, EventArgs e)
        {
            if (txtGradeId.Text == "")
            {
                lblGradeMessage.Text = "Please select a grade to delete.";
                lblGradeMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = @"DELETE FROM Grade
                        WHERE Grade_Id=@Grade_Id";

            cmd.Parameters.AddWithValue("@Grade_Id", txtGradeId.Text.Trim());
            cmd.Connection = con;

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            lblGradeMessage.Text = "Grade deleted successfully.";
            lblGradeMessage.ForeColor = System.Drawing.Color.Green;

            txtGradeId.Text = "";
            txtGradeName.Text = "";

            loadGrades();
        }

        protected void btnClearGrade_Click(object sender, EventArgs e)
        {
            txtGradeId.Text = "";
            txtGradeName.Text = "";
            lblGradeMessage.Text = "";
        }

        protected void gvGrade_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtGradeId.Text = gvGrade.SelectedRow.Cells[1].Text;
            txtGradeName.Text = gvGrade.SelectedRow.Cells[2].Text;
        }

        protected void btnAddDistrict_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = @"INSERT INTO District
                        (District_Name)
                        VALUES
                        (@District_Name)";

            cmd.Parameters.AddWithValue("@District_Name", txtDistrictName.Text.Trim());
            cmd.Connection = con;

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            lblDistrictMessage.Text = "District added successfully.";
            lblDistrictMessage.ForeColor = System.Drawing.Color.Green;

            txtDistrictId.Text = "";
            txtDistrictName.Text = "";

            loadDistricts();
        }

        protected void btnUpdateDistrict_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            if (txtDistrictId.Text == "")
            {
                lblDistrictMessage.Text = "Please select a district to update.";
                lblDistrictMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = @"UPDATE District
                        SET District_Name=@District_Name
                        WHERE District_Id=@District_Id";

            cmd.Parameters.AddWithValue("@District_Name", txtDistrictName.Text.Trim());
            cmd.Parameters.AddWithValue("@District_Id", txtDistrictId.Text.Trim());
            cmd.Connection = con;

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            lblDistrictMessage.Text = "District updated successfully.";
            lblDistrictMessage.ForeColor = System.Drawing.Color.Green;

            txtDistrictId.Text = "";
            txtDistrictName.Text = "";

            loadDistricts();
        }

        protected void btnDeleteDistrict_Click(object sender, EventArgs e)
        {
            if (txtDistrictId.Text == "")
            {
                lblDistrictMessage.Text = "Please select a district to delete.";
                lblDistrictMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = @"DELETE FROM District
                        WHERE District_Id=@District_Id";

            cmd.Parameters.AddWithValue("@District_Id", txtDistrictId.Text.Trim());
            cmd.Connection = con;

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            lblDistrictMessage.Text = "District deleted successfully.";
            lblDistrictMessage.ForeColor = System.Drawing.Color.Green;

            txtDistrictId.Text = "";
            txtDistrictName.Text = "";

            loadDistricts();
        }

        protected void btnClearDistrict_Click(object sender, EventArgs e)
        {
            txtDistrictId.Text = "";
            txtDistrictName.Text = "";
            lblDistrictMessage.Text = "";
        }

        protected void gvDistrict_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtDistrictId.Text = gvDistrict.SelectedRow.Cells[1].Text;
            txtDistrictName.Text = gvDistrict.SelectedRow.Cells[2].Text;
        }

        protected void btnSearchUser_Click(object sender, EventArgs e)
        {
            loadUsers(txtSearchUser.Text.Trim());
        }

        protected void btnShowAllUsers_Click(object sender, EventArgs e)
        {
            txtSearchUser.Text = "";
            loadUsers("");
        }

        protected void btnUpdateFreezeStatus_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();

            if (ddlFreezeRole.SelectedValue == "Student")
            {
                cmd.CommandText = @"UPDATE Student
                            SET Account_Status=@Account_Status
                            WHERE Student_Id=@User_Id";
            }
            else if (ddlFreezeRole.SelectedValue == "Tutor")
            {
                cmd.CommandText = @"UPDATE Tutor
                            SET Account_Status=@Account_Status
                            WHERE Tutor_Id=@User_Id";
            }

            cmd.Parameters.AddWithValue("@Account_Status", ddlFreezeStatus.SelectedValue);
            cmd.Parameters.AddWithValue("@User_Id", txtFreezeUserId.Text.Trim());

            cmd.Connection = con;

            con.Open();
            int updated = cmd.ExecuteNonQuery();
            con.Close();

            if (updated > 0)
            {
                lblFreezeMessage.Text = "User status updated successfully.";
                lblFreezeMessage.ForeColor = System.Drawing.Color.Green;
            }
            else
            {
                lblFreezeMessage.Text = "User not found. Please check the role and ID.";
                lblFreezeMessage.ForeColor = System.Drawing.Color.Red;
            }

            txtFreezeUserId.Text = "";
            ddlFreezeRole.SelectedIndex = 0;
            ddlFreezeStatus.SelectedIndex = 0;

            loadUsers("");

        }

        protected void gvPendingTutors_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "AcceptTutor" || e.CommandName == "DenyTutor")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                int tutorId = Convert.ToInt32(gvPendingTutors.DataKeys[rowIndex].Value);

                string status;

                if (e.CommandName == "AcceptTutor")
                {
                    status = "Accepted";
                }
                else
                {
                    status = "Denied";
                }

                SqlConnection con = new SqlConnection(_conString);
                SqlCommand getCmd = new SqlCommand();

                getCmd.CommandText = @"SELECT Tutor_Name, Tutor_Email
                               FROM Tutor
                               WHERE Tutor_Id=@Tutor_Id";

                getCmd.Parameters.AddWithValue("@Tutor_Id", tutorId);
                getCmd.Connection = con;

                con.Open();

                SqlDataReader dr = getCmd.ExecuteReader();

                string tutorName = "";
                string tutorEmail = "";

                if (dr.Read())
                {
                    tutorName = dr["Tutor_Name"].ToString();
                    tutorEmail = dr["Tutor_Email"].ToString();
                }

                dr.Close();

                SqlCommand updateCmd = new SqlCommand();

                updateCmd.CommandText = @"UPDATE Tutor
                                  SET Approval_Status=@Approval_Status
                                  WHERE Tutor_Id=@Tutor_Id";

                updateCmd.Parameters.AddWithValue("@Approval_Status", status);
                updateCmd.Parameters.AddWithValue("@Tutor_Id", tutorId);
                updateCmd.Connection = con;

                updateCmd.ExecuteNonQuery();

                con.Close();

                sendTutorApprovalEmail(tutorEmail, tutorName, status);

                lblPendingTutorMessage.Text = "Tutor registration has been " + status.ToLower() + ".";
                lblPendingTutorMessage.ForeColor = System.Drawing.Color.Green;

                loadPendingTutors();
                loadUsers("");
                loadAnalytics();
            }
        }

        protected void btnUpdateRegistrationStatus_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(_conString);
            con.Open();

            SqlCommand studentCmd = new SqlCommand();

            studentCmd.CommandText = @"UPDATE SiteSetting
                               SET Setting_Value=@Setting_Value
                               WHERE Setting_Name='StudentRegistrationStatus'";

            studentCmd.Parameters.AddWithValue("@Setting_Value", ddlStudentRegistrationStatus.SelectedValue);
            studentCmd.Connection = con;

            studentCmd.ExecuteNonQuery();

            SqlCommand tutorCmd = new SqlCommand();

            tutorCmd.CommandText = @"UPDATE SiteSetting
                             SET Setting_Value=@Setting_Value
                             WHERE Setting_Name='TutorRegistrationStatus'";

            tutorCmd.Parameters.AddWithValue("@Setting_Value", ddlTutorRegistrationStatus.SelectedValue);
            tutorCmd.Connection = con;

            tutorCmd.ExecuteNonQuery();

            con.Close();

            lblRegistrationStatusMessage.Text = "Registration settings updated successfully.";
            lblRegistrationStatusMessage.ForeColor = System.Drawing.Color.Green;
        }
        }
}