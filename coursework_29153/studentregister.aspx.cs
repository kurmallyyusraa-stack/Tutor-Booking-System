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
    public partial class studentregister : System.Web.UI.Page
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
                        WHERE Setting_Name = 'StudentRegistrationStatus'";

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

        protected void btnStudentRegister_Click(object sender, EventArgs e)
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
                        scmd.CommandType = CommandType.Text;

                        scmd.CommandText = "INSERT INTO Student " +
                            "(Student_Name, Student_Email, Student_Phone, Student_Password, District_Id, Grade_Id) " +
                            "VALUES (@Student_Name, @Student_Email, @Student_Phone, @Student_Password, @District_Id, @Grade_Id)";

                        scmd.Parameters.AddWithValue("@Student_Name", txtStudentName.Text.Trim());
                        scmd.Parameters.AddWithValue("@Student_Email", txtStudentEmail.Text.Trim());
                        scmd.Parameters.AddWithValue("@Student_Phone", txtStudentPhone.Text.Trim());
                        scmd.Parameters.AddWithValue("@Student_Password", txtStudentPassword.Text.Trim());
                        scmd.Parameters.AddWithValue("@District_Id", ddlDistrict.SelectedValue);
                        scmd.Parameters.AddWithValue("@Grade_Id", ddlGrade.SelectedValue);

                        con.Open();
                        scmd.ExecuteNonQuery();
                    }
                }

                lblMessage.Text = "Student registered successfully!";
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
            txtStudentName.Text = "";
            txtStudentEmail.Text = "";
            txtStudentPhone.Text = "";
            txtStudentPassword.Text = "";
            txtConfirmPassword.Text = "";
            ddlDistrict.SelectedIndex = 0;
            ddlGrade.SelectedIndex = 0;
        }

    }
}