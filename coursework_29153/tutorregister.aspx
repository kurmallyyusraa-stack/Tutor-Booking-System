<%@ Page Title="" Language="C#" MasterPageFile="~/guestmaster.Master" AutoEventWireup="true" CodeBehind="tutorregister.aspx.cs" Inherits="coursework_29153.tutorregister" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <section class="page-title-section overlay" data-background="assets/images/backgrounds/page-title.jpg">
        <div class="container">
            <div class="row">
                <div class="col-md-8">
                    <ul class="list-inline custom-breadcrumb">
                        <li class="list-inline-item">
                            <a class="h2 text-primary font-secondary" href="TutorRegister.aspx">Tutor Registration</a>
                        </li>
                    </ul>
                    <p class="text-lighten">
                        Register as a tutor on MoProf. Your account will be reviewed by the administrator.
               
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

    <h4>New tutor registrations are currently disabled.</h4>
    <p>Please try again later.</p>

</asp:Panel>

<asp:Panel ID="pnlRegistrationForm" runat="server">

    <section class="section">
        <div class="container">
            <div class="row justify-content-center">

                <div class="col-lg-8">
                    <div class="card border-0 rounded-0 hover-shadow p-5">

                        <h2 class="section-title">Tutor Registration Form</h2>

                        <asp:ValidationSummary
                            ID="ValidationSummary1"
                            runat="server"
                            ForeColor="Red" />


                        <div class="form-group">
                            <label>Full Name</label>
                            <asp:TextBox ID="txtTutorName"
                                runat="server"
                                CssClass="form-control"
                                Placeholder="Enter full name">

                            </asp:TextBox>

                            <asp:RequiredFieldValidator
                                ID="reqTutorName"
                                runat="server"
                                ControlToValidate="txtTutorName"
                                ErrorMessage="Tutor name is required"
                                Text="(Required)"
                                ForeColor="Red" />

                        </div>

                        <div class="form-group">
                            <label>Email</label>
                            <asp:TextBox ID="txtTutorEmail" runat="server" CssClass="form-control" placeholder="example@gmail.com"></asp:TextBox>

                            <asp:RequiredFieldValidator
                                ID="reqTutorEmail"
                                runat="server"
                                ControlToValidate="txtTutorEmail"
                                ErrorMessage="Email is required"
                                Text="(Required)"
                                ForeColor="Red" />

                            <asp:RegularExpressionValidator
                                ID="regTutorEmail"
                                runat="server"
                                ControlToValidate="txtTutorEmail"
                                ErrorMessage="Invalid email address"
                                Text="(Invalid Email)"
                                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                ForeColor="Red" />

                        </div>

                        <div class="form-group">
                            <label>Phone Number</label>
                            <asp:TextBox ID="txtTutorPhone" runat="server" CssClass="form-control" Placeholder="Enter phone number"></asp:TextBox>

                            <asp:RequiredFieldValidator
                                ID="reqTutorPhone"
                                runat="server"
                                ControlToValidate="txtTutorPhone"
                                ErrorMessage="Phone number is required"
                                Text="(Required)"
                                ForeColor="Red" />

                            <asp:RegularExpressionValidator
                                ID="regTutorPhone"
                                runat="server"
                                ControlToValidate="txtTutorPhone"
                                ErrorMessage="Phone number must contain 8 digits"
                                Text="(Invalid Phone)"
                                ValidationExpression="^\d{8}$"
                                ForeColor="Red" />

                        </div>

                        <div class="form-group">
                            <label>Password</label>
                            <asp:TextBox ID="txtTutorPassword" runat="server" CssClass="form-control" TextMode="Password" Placeholder="Enter password"></asp:TextBox>

                            <asp:RequiredFieldValidator
                                ID="reqTutorPassword"
                                runat="server"
                                ControlToValidate="txtTutorPassword"
                                ErrorMessage="Password is required"
                                Text="(Required)"
                                ForeColor="Red" />

                        </div>

                        <div class="form-group">
                            <label>Confirm Password</label>
                            <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password" Placeholder="Confirm password"></asp:TextBox>

                            <asp:RequiredFieldValidator
                                ID="reqConfirmPassword"
                                runat="server"
                                ControlToValidate="txtConfirmPassword"
                                ErrorMessage="Confirm password is required"
                                Text="(Required)"
                                ForeColor="Red" />

                            <asp:CompareValidator
                                ID="cmpPassword"
                                runat="server"
                                ControlToValidate="txtConfirmPassword"
                                ControlToCompare="txtTutorPassword"
                                ErrorMessage="Passwords do not match"
                                Text="(Passwords do not match)"
                                ForeColor="Red" />

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

                            <asp:RequiredFieldValidator
                                ID="reqDistrict"
                                runat="server"
                                ControlToValidate="ddlDistrict"
                                InitialValue=""
                                ErrorMessage="Please select a district"
                                Text="(Select District)"
                                ForeColor="Red" />

                        </div>

                        <div class="form-group">
                            <label>Qualification</label>
                            <asp:TextBox ID="txtQualification" runat="server" CssClass="form-control" Placeholder="Example: BSc Mathematics"></asp:TextBox>

                            <asp:RequiredFieldValidator
                                ID="reqQualification"
                                runat="server"
                                ControlToValidate="txtQualification"
                                ErrorMessage="Qualification is required"
                                Text="(Required)"
                                ForeColor="Red" />

                        </div>

                        <div class="form-group">
                            <label>Skills</label>
                            <asp:TextBox ID="txtSkills" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" Placeholder="Enter your teaching skills"></asp:TextBox>

                            <asp:RequiredFieldValidator
                                ID="reqSkills"
                                runat="server"
                                ControlToValidate="txtSkills"
                                ErrorMessage="Skills field is required"
                                Text="(Required)"
                                ForeColor="Red" />

                        </div>

                        <div class="form-group">
                            <label>Teaching Experience</label>
                            <asp:TextBox ID="txtExperience" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" Placeholder="Describe your teaching experience"></asp:TextBox>

                            <asp:RequiredFieldValidator
                                ID="reqExperience"
                                runat="server"
                                ControlToValidate="txtExperience"
                                ErrorMessage="Experience field is required"
                                Text="(Required)"
                                ForeColor="Red" />

                        </div>

                        <asp:Button ID="btnTutorRegister" runat="server" Text="Register as Tutor" CssClass="btn btn-primary" OnClick="btnTutorRegister_Click" />


                        &nbsp;&nbsp;

                     

                        <asp:Button
                            ID="btnClear"
                            runat="server"
                            Text="Clear"
                            CssClass="btn btn-primary"
                            OnClick="btnClear_Click"
                            CausesValidation="false" />

                        <br />
                        <br />

                        <asp:Label ID="lblMessage" runat="server" ForeColor="Green"></asp:Label>





                    </div>
                </div>

            </div>
        </div>
    </section>
    </asp:Panel>

</asp:Content>
