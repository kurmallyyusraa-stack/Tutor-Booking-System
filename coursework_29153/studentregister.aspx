<%@ Page Title="" Language="C#" MasterPageFile="~/guestmaster.Master" AutoEventWireup="true" CodeBehind="studentregister.aspx.cs" Inherits="coursework_29153.studentregister" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<section class="page-title-section overlay" data-background="assets/images/backgrounds/page-title.jpg">
    <div class="container">
        <div class="row">
            <div class="col-md-8">
                <ul class="list-inline custom-breadcrumb">
                    <li class="list-inline-item">
                        <a class="h2 text-primary font-secondary" href="StudentRegister.aspx">Student Registration</a>
                    </li>
                </ul>
                <p class="text-lighten">
                    Register as a student to reserve seats, upload results and recommend tutors.
                </p>
            </div>
        </div>
    </div>
</section>

<asp:Panel
    ID="pnlRegistrationClosed"
    runat="server"
    Visible="false"
    CssClass="alert alert-danger text-center">

    <h4>New student registrations are currently disabled.</h4>
    <p>Please try again later.</p>

</asp:Panel>

<asp:Panel ID="pnlRegistrationForm" runat="server">

<section class="section">
    <div class="container">
        <div class="row justify-content-center">

            <div class="col-lg-8">
                <div class="card border-0 rounded-0 hover-shadow p-5">

                    <h2 class="section-title">Student Registration Form</h2>

                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" />

                    <div class="form-group">
                        <label>Full Name</label>
                        <asp:TextBox ID="txtStudentName" runat="server" CssClass="form-control" Placeholder="Enter full name"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqStudentName" runat="server" ControlToValidate="txtStudentName"
                            ErrorMessage="Student name is required" Text="(Required)" ForeColor="Red" />
                    </div>

                    <div class="form-group">
                        <label>Email</label>
                        <asp:TextBox ID="txtStudentEmail" runat="server" CssClass="form-control" Placeholder="Enter email"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqStudentEmail" runat="server" ControlToValidate="txtStudentEmail"
                            ErrorMessage="Email is required" Text="(Required)" ForeColor="Red" />
                        <asp:RegularExpressionValidator ID="regStudentEmail" runat="server" ControlToValidate="txtStudentEmail"
                            ErrorMessage="Invalid email address" Text="(Invalid Email)"
                            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ForeColor="Red" />
                    </div>

                    <div class="form-group">
                        <label>Phone Number</label>
                        <asp:TextBox ID="txtStudentPhone" runat="server" CssClass="form-control" Placeholder="Enter phone number"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqStudentPhone" runat="server" ControlToValidate="txtStudentPhone"
                            ErrorMessage="Phone number is required" Text="(Required)" ForeColor="Red" />
                        <asp:RegularExpressionValidator ID="regStudentPhone" runat="server" ControlToValidate="txtStudentPhone"
                            ErrorMessage="Phone number must contain 8 digits" Text="(Invalid Phone)"
                            ValidationExpression="^\d{8}$" ForeColor="Red" />
                    </div>

                    <div class="form-group">
                        <label>Password</label>
                        <asp:TextBox ID="txtStudentPassword" runat="server" CssClass="form-control" TextMode="Password" Placeholder="Enter password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqStudentPassword" runat="server" ControlToValidate="txtStudentPassword"
                            ErrorMessage="Password is required" Text="(Required)" ForeColor="Red" />
                    </div>

                    <div class="form-group">
                        <label>Confirm Password</label>
                        <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password" Placeholder="Confirm password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqConfirmPassword" runat="server" ControlToValidate="txtConfirmPassword"
                            ErrorMessage="Confirm password is required" Text="(Required)" ForeColor="Red" />
                        <asp:CompareValidator ID="cmpPassword" runat="server" ControlToValidate="txtConfirmPassword"
                            ControlToCompare="txtStudentPassword" ErrorMessage="Passwords do not match"
                            Text="(Passwords do not match)" ForeColor="Red" />
                    </div>

                    <div class="form-group">
                        <label>District</label>
                        <asp:DropDownList ID="ddlDistrict" runat="server" CssClass="form-control">
                            <asp:ListItem Text="-- Select District --" Value=""></asp:ListItem>
                            <asp:ListItem Text="Port Louis" Value="1"></asp:ListItem>
                            <asp:ListItem Text="Pamplemousses" Value="2"></asp:ListItem>
                            <asp:ListItem Text="Rivière du Rempart" Value="3"></asp:ListItem>
                            <asp:ListItem Text="Flacq" Value="4"></asp:ListItem>
                            <asp:ListItem Text="Grand Port" Value="5"></asp:ListItem>
                            <asp:ListItem Text="Savanne" Value="6"></asp:ListItem>
                            <asp:ListItem Text="Black River" Value="7"></asp:ListItem>
                            <asp:ListItem Text="Plaines Wilhems" Value="8"></asp:ListItem>
                            <asp:ListItem Text="Moka" Value="9"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="reqDistrict" runat="server" ControlToValidate="ddlDistrict"
                            InitialValue="" ErrorMessage="Please select a district" Text="(Select District)" ForeColor="Red" />
                    </div>

                    <div class="form-group">
                        <label>Grade</label>
                        <asp:DropDownList ID="ddlGrade" runat="server" CssClass="form-control">
                            <asp:ListItem Text="-- Select Grade --" Value=""></asp:ListItem>
                            <asp:ListItem Text="Grade 7" Value="1"></asp:ListItem>
                            <asp:ListItem Text="Grade 8" Value="2"></asp:ListItem>
                            <asp:ListItem Text="Grade 9" Value="3"></asp:ListItem>
                            <asp:ListItem Text="Grade 10" Value="4"></asp:ListItem>
                            <asp:ListItem Text="Grade 11" Value="5"></asp:ListItem>
                            <asp:ListItem Text="Grade 12" Value="6"></asp:ListItem>
                            <asp:ListItem Text="Grade 13" Value="7"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="reqGrade" runat="server" ControlToValidate="ddlGrade"
                            InitialValue="" ErrorMessage="Please select a grade" Text="(Select Grade)" ForeColor="Red" />
                    </div>

                    <asp:Button ID="btnStudentRegister" runat="server" Text="Register as Student"
                        CssClass="btn btn-primary" OnClick="btnStudentRegister_Click" />

                    &nbsp;&nbsp;

                    <asp:Button ID="btnClear" runat="server" Text="Clear"
                        CssClass="btn btn-primary" OnClick="btnClear_Click" CausesValidation="false" />

                    <br /><br />

                    <asp:Label ID="lblMessage" runat="server"></asp:Label>

                </div>
            </div>

        </div>
    </div>
</section>
</asp:Panel>

</asp:Content>
