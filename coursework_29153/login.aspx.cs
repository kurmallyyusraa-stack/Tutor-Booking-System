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
    public partial class login : System.Web.UI.Page
    {
        private string _conString =
        WebConfigurationManager.ConnectionStrings["MoProfCS"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.Cookies["MoProfUsername"] != null &&
                    Request.Cookies["MoProfPassword"] != null &&
                    Request.Cookies["MoProfRole"] != null)
                {
                    txtUsername.Text = Request.Cookies["MoProfUsername"].Value;

                    txtPassword.Attributes["value"] =
                        Request.Cookies["MoProfPassword"].Value;

                    ddlRole.SelectedValue = Request.Cookies["MoProfRole"].Value;

                    chkRemember.Checked = true;
                }
            }
        }

        private void SaveLoginCookies()
        {
            if (chkRemember.Checked)
            {
                Response.Cookies["MoProfUsername"].Value = txtUsername.Text.Trim();
                Response.Cookies["MoProfPassword"].Value = txtPassword.Text.Trim();
                Response.Cookies["MoProfRole"].Value = ddlRole.SelectedValue;

                Response.Cookies["MoProfUsername"].Expires = DateTime.Now.AddDays(7);
                Response.Cookies["MoProfPassword"].Expires = DateTime.Now.AddDays(7);
                Response.Cookies["MoProfRole"].Expires = DateTime.Now.AddDays(7);
            }
            else
            {
                Response.Cookies["MoProfUsername"].Expires = DateTime.Now.AddDays(-1);
                Response.Cookies["MoProfPassword"].Expires = DateTime.Now.AddDays(-1);
                Response.Cookies["MoProfRole"].Expires = DateTime.Now.AddDays(-1);
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtUsername.Text = "";
            txtPassword.Text = "";
            ddlRole.SelectedIndex = 0;
            chkRemember.Checked = false;
            lblMessage.Text = "";

            Response.Cookies["MoProfUsername"].Expires = DateTime.Now.AddDays(-1);
            Response.Cookies["MoProfPassword"].Expires = DateTime.Now.AddDays(-1);
            Response.Cookies["MoProfRole"].Expires = DateTime.Now.AddDays(-1);
        }

        private void resetFailedAttempts(string role, int userId)
        {
            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();

            if (role == "Student")
            {
                cmd.CommandText = @"UPDATE Student
                            SET Failed_Attempts = 0
                            WHERE Student_Id = @User_Id";
            }
            else if (role == "Tutor")
            {
                cmd.CommandText = @"UPDATE Tutor
                            SET Failed_Attempts = 0
                            WHERE Tutor_Id = @User_Id";
            }

            cmd.Parameters.AddWithValue("@User_Id", userId);
            cmd.Connection = con;

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
        }

        private void recordFailedLogin(string role, string email)
        {
            SqlConnection con = new SqlConnection(_conString);
            SqlCommand selectCmd = new SqlCommand();

            if (role == "Student")
            {
                selectCmd.CommandText = @"SELECT Student_Id, Account_Status, Failed_Attempts
                                  FROM Student
                                  WHERE Student_Email = @Email";
            }
            else if (role == "Tutor")
            {
                selectCmd.CommandText = @"SELECT Tutor_Id, Account_Status, Failed_Attempts
                                  FROM Tutor
                                  WHERE Tutor_Email = @Email";
            }

            selectCmd.Parameters.AddWithValue("@Email", email);
            selectCmd.Connection = con;

            con.Open();

            SqlDataReader dr = selectCmd.ExecuteReader();

            if (dr.Read())
            {
                string accountStatus = dr["Account_Status"].ToString();
                int failedAttempts = Convert.ToInt32(dr["Failed_Attempts"]) + 1;

                int userId;

                if (role == "Student")
                {
                    userId = Convert.ToInt32(dr["Student_Id"]);
                }
                else
                {
                    userId = Convert.ToInt32(dr["Tutor_Id"]);
                }

                dr.Close();

                if (accountStatus == "Unavailable")
                {
                    lblMessage.Text = "Your account is locked. Please contact the administrator.";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    con.Close();
                    return;
                }

                SqlCommand updateCmd = new SqlCommand();

                if (role == "Student")
                {
                    if (failedAttempts >= 3)
                    {
                        updateCmd.CommandText = @"UPDATE Student
                                          SET Failed_Attempts = @Failed_Attempts,
                                              Account_Status = 'Unavailable'
                                          WHERE Student_Id = @User_Id";
                    }
                    else
                    {
                        updateCmd.CommandText = @"UPDATE Student
                                          SET Failed_Attempts = @Failed_Attempts
                                          WHERE Student_Id = @User_Id";
                    }
                }
                else if (role == "Tutor")
                {
                    if (failedAttempts >= 3)
                    {
                        updateCmd.CommandText = @"UPDATE Tutor
                                          SET Failed_Attempts = @Failed_Attempts,
                                              Account_Status = 'Unavailable'
                                          WHERE Tutor_Id = @User_Id";
                    }
                    else
                    {
                        updateCmd.CommandText = @"UPDATE Tutor
                                          SET Failed_Attempts = @Failed_Attempts
                                          WHERE Tutor_Id = @User_Id";
                    }
                }

                updateCmd.Parameters.AddWithValue("@Failed_Attempts", failedAttempts);
                updateCmd.Parameters.AddWithValue("@User_Id", userId);
                updateCmd.Connection = con;

                updateCmd.ExecuteNonQuery();

                if (failedAttempts >= 3)
                {
                    lblMessage.Text = "Too many failed login attempts. Your account has been locked.";
                }
                else
                {
                    lblMessage.Text = "Invalid password. Failed attempt " + failedAttempts + " of 3.";
                }

                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
            else
            {
                dr.Close();

                lblMessage.Text = "Invalid email or password.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }

            con.Close();
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                using (SqlConnection con = new SqlConnection(_conString))
                {
                    using (SqlCommand scmd = new SqlCommand())
                    {
                        scmd.Connection = con;
                        scmd.CommandType = CommandType.Text;

                        if (ddlRole.SelectedValue == "Admin")
                        {
                            scmd.CommandText = "SELECT * FROM Admin WHERE (Admin_Username=@Username OR Admin_Email=@Username) AND Admin_Password=@Password";
                        }
                        else if (ddlRole.SelectedValue == "Tutor")
                        {
                            scmd.CommandText = "sp_TutorLogin";
                            scmd.CommandType = CommandType.StoredProcedure;
                        }
                        else if (ddlRole.SelectedValue == "Student")
                        {
                            scmd.CommandText = "SELECT * FROM Student WHERE Student_Email=@Username AND Student_Password=@Password";
                        }

                        if (ddlRole.SelectedValue == "Tutor")
                        {
                            scmd.Parameters.AddWithValue("@Tutor_Email", txtUsername.Text.Trim());
                            scmd.Parameters.AddWithValue("@Tutor_Password", txtPassword.Text.Trim());
                        }
                        else
                        {
                            scmd.Parameters.AddWithValue("@Username", txtUsername.Text.Trim());
                            scmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());
                        }

                        con.Open();

                        SqlDataReader dr = scmd.ExecuteReader();

                        if (dr.Read())
                        {
                            if (ddlRole.SelectedValue == "Admin")
                            {
                                Session["Admin_Id"] = dr["Admin_Id"].ToString();
                                Session["username"] = txtUsername.Text;
                                Session["role"] = "Admin";
                                SaveLoginCookies();
                                Response.Redirect("admindashboard.aspx");
                            }

                            else if (ddlRole.SelectedValue == "Tutor")
                            {
                                if (dr["Approval_Status"].ToString() != "Accepted")
                                {
                                    lblMessage.Text = "Your tutor registration is not approved yet. Please wait for admin approval.";
                                    lblMessage.ForeColor = System.Drawing.Color.Red;
                                    return;
                                }

                                if (dr["Account_Status"].ToString() == "Unavailable")
                                {
                                    lblMessage.Text = "Your tutor account has been frozen. Please contact the administrator.";
                                    lblMessage.ForeColor = System.Drawing.Color.Red;
                                    return;
                                }

                                resetFailedAttempts("Tutor", Convert.ToInt32(dr["Tutor_Id"]));


                                Session["Tutor_Id"] = dr["Tutor_Id"].ToString();
                                Session["username"] = txtUsername.Text;
                                Session["role"] = "Tutor";
                                SaveLoginCookies();
                                Response.Redirect("tutorprofile.aspx");
                            }

                            else if (ddlRole.SelectedValue == "Student")
                            {
                                if (dr["Account_Status"].ToString() == "Unavailable")
                                {
                                    lblMessage.Text = "Your student account has been frozen. Please contact the administrator.";
                                    lblMessage.ForeColor = System.Drawing.Color.Red;
                                    return;
                                }

                                resetFailedAttempts("Student", Convert.ToInt32(dr["Student_Id"]));


                                Session["Student_Id"] = dr["Student_Id"].ToString();
                                Session["username"] = txtUsername.Text;
                                Session["role"] = "Student";
                                SaveLoginCookies();
                                dr.Close();

                                SqlCommand updateLoginCmd = new SqlCommand(
                                    "UPDATE Student SET Last_Login_Date=@Last_Login_Date WHERE Student_Id=@Student_Id", con);

                                updateLoginCmd.Parameters.AddWithValue("@Last_Login_Date", DateTime.Now);
                                updateLoginCmd.Parameters.AddWithValue("@Student_Id", Session["Student_Id"]);

                                updateLoginCmd.ExecuteNonQuery();

                                Response.Redirect("studentprofile.aspx");
                            }
                        }
                        else
                        {
                            dr.Close();

                            if (ddlRole.SelectedValue == "Student")
                            {
                                recordFailedLogin("Student", txtUsername.Text.Trim());
                            }
                            else if (ddlRole.SelectedValue == "Tutor")
                            {
                                recordFailedLogin("Tutor", txtUsername.Text.Trim());
                            }
                            else
                            {
                                lblMessage.Text = "Invalid username, password or role.";
                                lblMessage.ForeColor = System.Drawing.Color.Red;
                            }
                        }
                    }
                }
            }
        }
    }
}