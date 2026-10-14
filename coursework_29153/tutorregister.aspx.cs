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
    public partial class tutorregister : System.Web.UI.Page
    {

        private string _conString =
        WebConfigurationManager.ConnectionStrings["MoProfCS"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                checkRegistrationStatus();

            }
        }

        private void checkRegistrationStatus()
        {
            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = @"SELECT Setting_Value
                        FROM SiteSetting
                        WHERE Setting_Name = 'TutorRegistrationStatus'";

            cmd.Connection = con;

            con.Open();

            object value = cmd.ExecuteScalar();

            con.Close();

            if (value != null && value.ToString() == "Disabled")
            {
                pnlRegistrationClosed.Visible = true;
                pnlRegistrationForm.Visible = false;
            }
            else
            {
                pnlRegistrationClosed.Visible = false;
                pnlRegistrationForm.Visible = true;
            }
        }

        protected void btnTutorRegister_Click(object sender, EventArgs e)
        {
            checkRegistrationStatus();

            if (pnlRegistrationForm.Visible == false)
            {
                return;
            }

            if (Page.IsValid)
            {
                using (SqlConnection con = new SqlConnection(_conString))
                {
                    using (SqlCommand scmd = new SqlCommand())
                    {
                        scmd.Connection = con;
                        scmd.CommandText = "sp_RegisterTutor";
                        scmd.CommandType = CommandType.StoredProcedure;

                        scmd.Parameters.AddWithValue("@Tutor_Name", txtTutorName.Text.Trim());
                        scmd.Parameters.AddWithValue("@Tutor_Email", txtTutorEmail.Text.Trim());
                        scmd.Parameters.AddWithValue("@Tutor_Phone", txtTutorPhone.Text.Trim());
                        scmd.Parameters.AddWithValue("@Tutor_Password", txtTutorPassword.Text.Trim());
                        scmd.Parameters.AddWithValue("@Qualification", txtQualification.Text.Trim());
                        scmd.Parameters.AddWithValue("@Skills", txtSkills.Text.Trim());
                        scmd.Parameters.AddWithValue("@Experience", txtExperience.Text.Trim());
                        scmd.Parameters.AddWithValue("@District_Id", ddlDistrict.SelectedValue);
                        scmd.Parameters.AddWithValue("@Registration_Date", DateTime.Now);
                        scmd.Parameters.AddWithValue("@Profile_Picture", "assets/images/teachers/teacher-1.jpg");

                        con.Open();
                        scmd.ExecuteNonQuery();
                    }
                }

                lblMessage.Text = "Tutor registered successfully!";
                lblMessage.ForeColor = System.Drawing.Color.Green;

                ClearFields();
            }

        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ClearFields();
            lblMessage.Text = "";
        }

        private void ClearFields()
        {
            txtTutorName.Text = "";
            txtTutorEmail.Text = "";
            txtTutorPhone.Text = "";
            txtTutorPassword.Text = "";
            txtConfirmPassword.Text = "";
            ddlDistrict.SelectedIndex = 0;
            txtQualification.Text = "";
            txtSkills.Text = "";
            txtExperience.Text = "";
        }

    }
}