<%@ Page Title="" Language="C#" MasterPageFile="~/guestmaster.Master" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="coursework_29153.login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">



<section class="page-title-section overlay" data-background="assets/images/backgrounds/page-title.jpg">
    <div class="container">
        <div class="row">
            <div class="col-md-8">
                <ul class="list-inline custom-breadcrumb">
                    <li class="list-inline-item">
                        <a class="h2 text-primary font-secondary" href="Login.aspx">Login</a>
                    </li>
                </ul>
                <p class="text-lighten">
                    Sign in to access your MoProf account.
                </p>
            </div>
        </div>
    </div>
</section>

<section class="section">
    <div class="container">
        <div class="row align-items-center">

            <div class="col-md-5">
                <img src="assets/images/logo.png" class="img-fluid" alt="MoProf Login" />
            </div>

            <div class="col-md-7">
                <div class="card border-0 rounded-0 hover-shadow p-5">

                    <h2 class="section-title">Member Login</h2>

                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" />

                    <div class="form-group">
                        <label>Email / Username</label>
                        <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" Placeholder="Enter email or username"></asp:TextBox>

                        <asp:RequiredFieldValidator
                            ID="reqUsername"
                            runat="server"
                            ControlToValidate="txtUsername"
                            ErrorMessage="Username or email is required"
                            Text="(Required)"
                            ForeColor="Red" />
                    </div>

                    <div class="form-group">
                        <label>Password</label>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" Placeholder="Enter password"></asp:TextBox>

                        <asp:RequiredFieldValidator
                            ID="reqPassword"
                            runat="server"
                            ControlToValidate="txtPassword"
                            ErrorMessage="Password is required"
                            Text="(Required)"
                            ForeColor="Red" />
                    </div>

                    <div class="form-group">
                        <label>Login As</label>
                        <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-control">
                            <asp:ListItem Text="-- Select Role --" Value=""></asp:ListItem>
                            <asp:ListItem Text="Student" Value="Student"></asp:ListItem>
                            <asp:ListItem Text="Tutor" Value="Tutor"></asp:ListItem>
                            <asp:ListItem Text="Admin" Value="Admin"></asp:ListItem>
                        </asp:DropDownList>

                        <asp:RequiredFieldValidator
                            ID="reqRole"
                            runat="server"
                            ControlToValidate="ddlRole"
                            InitialValue=""
                            ErrorMessage="Please select a role"
                            Text="(Select Role)"
                            ForeColor="Red" />
                    </div>

                    <div class="form-group">
                        <asp:CheckBox ID="chkRemember" runat="server" Text=" Remember me" />
                    </div>

                    <asp:Button
                        ID="btnLogin"
                        runat="server"
                        Text="Sign In"
                        CssClass="btn btn-primary"
                        OnClick="btnLogin_Click" />

                    &nbsp;&nbsp;

                    <asp:Button
                        ID="btnClear"
                        runat="server"
                        Text="Clear"
                        CssClass="btn btn-primary"
                        OnClick="btnClear_Click"
                        CausesValidation="false" />

                    <br /><br />

                    <asp:Label ID="lblMessage" runat="server"></asp:Label>

                    <br /><br />

                    <p>
                        Do not have an account?
                        <a href="studentregister.aspx">Register as Student</a>
                        or
                        <a href="tutorregister.aspx">Register as Tutor</a>
                    </p>

                </div>
            </div>

        </div>
    </div>
</section>




</asp:Content>
