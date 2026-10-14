<%@ Page Title="" Language="C#" MasterPageFile="~/guestmaster.Master" AutoEventWireup="true" CodeBehind="studentprofile.aspx.cs" Inherits="coursework_29153.studentprofile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <section class="page-title-section overlay"
        data-background="assets/images/backgrounds/page-title.jpg">

        <div class="container">
            <div class="row">
                <div class="col-md-8">

                    <ul class="list-inline custom-breadcrumb">
                        <li class="list-inline-item">
                            <a class="h2 text-primary font-secondary"
                                href="studentprofile.aspx">Student Dashboard
                        </a>
                        </li>
                    </ul>

                    <p class="text-lighten">
                        Manage your profile, academic results, reservations, payments and recommendations.
               
                    </p>

                </div>
            </div>
        </div>

    </section>

    <style>
        .student-menu-card {
            position: sticky;
            top: 120px;
            margin-top: 40px;
        }

        html {
            scroll-behavior: smooth;
            scroll-padding-top: 100px;
        }

        #profileSection,
        #passwordSection,
        #submitResultSection,
        #reservationSection,
        #paymentSection,
        #testimonialSection,
        #recommendationSection {
            scroll-margin-top: 170px;
        }
    </style>

    <section class="section pt-0">
        <div class="container">
            <div class="row">

                <!-- LEFT MENU -->
                <div class="col-md-3 mt-5">
                    <div class="card p-3 shadow student-menu-card">

                        <h5>Student Menu</h5>

                        <a href="#profileSection" class="btn btn-primary btn-sm">My Profile</a>
                        <a href="#passwordSection" class="btn btn-primary btn-sm">Change Password</a>
                        <a href="#submitResultSection" class="btn btn-primary btn-sm">Submit Result</a>
                        <a href="#reservationSection" class="btn btn-primary btn-sm">My Reservations</a>
                        <a href="#paymentSection" class="btn btn-primary btn-sm">Payments</a>
                        <a href="#testimonialSection" class="btn btn-primary btn-sm">Testimonials</a>
                        <a href="#recommendationSection" class="btn btn-primary btn-sm">Recommendations</a>

                    </div>
                </div>

                <div class="col-md-9">


                    <section id="profileSection" class="section">
                        <div class="container">
                            <div class="card border-0 rounded-0 hover-shadow p-5">

                                <h2 class="section-title">My Profile</h2>

                                <div class="form-group">
                                    <label>Full Name</label>

                                    <asp:TextBox
                                        ID="txtStudentName"
                                        runat="server"
                                        CssClass="form-control">
                                </asp:TextBox>

                                    <asp:RequiredFieldValidator
                                        ID="rfvStudentName"
                                        runat="server"
                                        ControlToValidate="txtStudentName"
                                        ErrorMessage="Student name is required."
                                        ForeColor="Red"
                                        ValidationGroup="ProfileGroup">
                                </asp:RequiredFieldValidator>
                                </div>

                                <div class="form-group">
                                    <label>Email</label>

                                    <asp:TextBox
                                        ID="txtStudentEmail"
                                        runat="server"
                                        CssClass="form-control">
                                </asp:TextBox>

                                    <asp:RequiredFieldValidator
                                        ID="rfvStudentEmail"
                                        runat="server"
                                        ControlToValidate="txtStudentEmail"
                                        ErrorMessage="Email is required."
                                        ForeColor="Red"
                                        ValidationGroup="ProfileGroup">
                                </asp:RequiredFieldValidator>

                                    <asp:RegularExpressionValidator
                                        ID="revStudentEmail"
                                        runat="server"
                                        ControlToValidate="txtStudentEmail"
                                        ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                                        ErrorMessage="Enter a valid email address."
                                        ForeColor="Red"
                                        ValidationGroup="ProfileGroup">
                                </asp:RegularExpressionValidator>
                                </div>

                                <div class="form-group">
                                    <label>Phone</label>

                                    <asp:TextBox
                                        ID="txtStudentPhone"
                                        runat="server"
                                        CssClass="form-control">
                                </asp:TextBox>

                                    <asp:RequiredFieldValidator
                                        ID="rfvStudentPhone"
                                        runat="server"
                                        ControlToValidate="txtStudentPhone"
                                        ErrorMessage="Phone number is required."
                                        ForeColor="Red"
                                        ValidationGroup="ProfileGroup">
                                </asp:RequiredFieldValidator>
                                </div>

                                <div class="form-group">
                                    <label>District</label>

                                    <asp:DropDownList
                                        ID="ddlDistrict"
                                        runat="server"
                                        CssClass="form-control">
                                    </asp:DropDownList>

                                    <asp:RequiredFieldValidator
                                        ID="rfvDistrict"
                                        runat="server"
                                        ControlToValidate="ddlDistrict"
                                        InitialValue=""
                                        ErrorMessage="Please select a district."
                                        ForeColor="Red"
                                        ValidationGroup="ProfileGroup">
                                </asp:RequiredFieldValidator>
                                </div>

                                <div class="form-group">
                                    <label>Grade</label>

                                    <asp:DropDownList
                                        ID="ddlGrade"
                                        runat="server"
                                        CssClass="form-control">
                                    </asp:DropDownList>

                                    <asp:RequiredFieldValidator
                                        ID="rfvGrade"
                                        runat="server"
                                        ControlToValidate="ddlGrade"
                                        InitialValue=""
                                        ErrorMessage="Please select a grade."
                                        ForeColor="Red"
                                        ValidationGroup="ProfileGroup">
                                </asp:RequiredFieldValidator>
                                </div>

                                <div class="form-group">
                                    <label>Last Login Date</label>

                                    <asp:TextBox
                                        ID="txtLastLogin"
                                        runat="server"
                                        CssClass="form-control"
                                        ReadOnly="true">
                                </asp:TextBox>
                                </div>

                                <asp:Button
                                    ID="btnUpdateProfile"
                                    runat="server"
                                    Text="Update Profile"
                                    CssClass="btn btn-primary"
                                    OnClick="btnUpdateProfile_Click"
                                    ValidationGroup="ProfileGroup" />

                                <br />
                                <br />

                                <asp:Label ID="lblMessage" runat="server"></asp:Label>

                            </div>
                        </div>
                    </section>


                    <section id="passwordSection" class="section pt-0">
                        <div class="container">
                            <div class="card border-0 rounded-0 hover-shadow p-5">

                                <h2 class="section-title">🔒 Change Password</h2>

                                <div class="form-group">
                                    <label>Current Password</label>

                                    <asp:TextBox
                                        ID="txtCurrentPassword"
                                        runat="server"
                                        CssClass="form-control"
                                        TextMode="Password">
                                </asp:TextBox>

                                    <asp:RequiredFieldValidator
                                        ID="rfvCurrentPassword"
                                        runat="server"
                                        ControlToValidate="txtCurrentPassword"
                                        ErrorMessage="Current password is required."
                                        ForeColor="Red"
                                        ValidationGroup="PasswordGroup">
                                </asp:RequiredFieldValidator>
                                </div>

                                <div class="form-group">
                                    <label>New Password</label>

                                    <asp:TextBox
                                        ID="txtNewPassword"
                                        runat="server"
                                        CssClass="form-control"
                                        TextMode="Password">
                                </asp:TextBox>

                                    <asp:RequiredFieldValidator
                                        ID="rfvNewPassword"
                                        runat="server"
                                        ControlToValidate="txtNewPassword"
                                        ErrorMessage="New password is required."
                                        ForeColor="Red"
                                        ValidationGroup="PasswordGroup">
                                </asp:RequiredFieldValidator>

                                    <asp:RegularExpressionValidator
                                        ID="revPassword"
                                        runat="server"
                                        ControlToValidate="txtNewPassword"
                                        ValidationExpression="^.{6,}$"
                                        ErrorMessage="Password must be at least 6 characters."
                                        ForeColor="Red"
                                        ValidationGroup="PasswordGroup">
                                </asp:RegularExpressionValidator>
                                </div>

                                <div class="form-group">
                                    <label>Confirm Password</label>

                                    <asp:TextBox
                                        ID="txtConfirmPassword"
                                        runat="server"
                                        CssClass="form-control"
                                        TextMode="Password">
                                </asp:TextBox>

                                    <asp:RequiredFieldValidator
                                        ID="rfvConfirmPassword"
                                        runat="server"
                                        ControlToValidate="txtConfirmPassword"
                                        ErrorMessage="Please confirm your password."
                                        ForeColor="Red"
                                        ValidationGroup="PasswordGroup">
                                </asp:RequiredFieldValidator>

                                    <asp:CompareValidator
                                        ID="cvPassword"
                                        runat="server"
                                        ControlToValidate="txtConfirmPassword"
                                        ControlToCompare="txtNewPassword"
                                        ErrorMessage="Passwords do not match."
                                        ForeColor="Red"
                                        ValidationGroup="PasswordGroup">
                                </asp:CompareValidator>
                                </div>

                                <asp:Button
                                    ID="btnChangePassword"
                                    runat="server"
                                    Text="Change Password"
                                    CssClass="btn btn-primary"
                                    OnClick="btnChangePassword_Click"
                                    ValidationGroup="PasswordGroup" />

                                <br />
                                <br />

                                <asp:Label
                                    ID="lblPasswordMessage"
                                    runat="server">
                            </asp:Label>

                            </div>
                        </div>
                    </section>

                    <section id="submitResultSection" class="section pt-0">
                        <div class="container">
                            <div class="card border-0 rounded-0 hover-shadow p-5">

                                <h2 class="section-title">📄 Submit Academic Result</h2>

                                <div class="form-group">
                                    <label>Select Subject</label>

                                    <asp:DropDownList
                                        ID="ddlResultSubject"
                                        runat="server"
                                        CssClass="form-control">
                                    </asp:DropDownList>

                                    <asp:RequiredFieldValidator
                                        ID="rfvResultSubject"
                                        runat="server"
                                        ControlToValidate="ddlResultSubject"
                                        InitialValue="0"
                                        ErrorMessage="Please select a subject."
                                        ForeColor="Red"
                                        ValidationGroup="ResultGroup">
                                </asp:RequiredFieldValidator>
                                </div>

                                <div class="form-group">
                                    <label>Qualification</label>

                                    <asp:TextBox
                                        ID="txtQualification"
                                        runat="server"
                                        CssClass="form-control"
                                        Placeholder="e.g. Grade 11, HSC, O Level">
                                </asp:TextBox>

                                    <asp:RequiredFieldValidator
                                        ID="rfvQualification"
                                        runat="server"
                                        ControlToValidate="txtQualification"
                                        ErrorMessage="Qualification is required."
                                        ForeColor="Red"
                                        ValidationGroup="ResultGroup">
                                </asp:RequiredFieldValidator>
                                </div>

                                <div class="form-group">
                                    <label>Year</label>

                                    <asp:TextBox
                                        ID="txtResultYear"
                                        runat="server"
                                        CssClass="form-control"
                                        Placeholder="e.g. 2025">
                                </asp:TextBox>

                                    <asp:RequiredFieldValidator
                                        ID="rfvResultYear"
                                        runat="server"
                                        ControlToValidate="txtResultYear"
                                        ErrorMessage="Year is required."
                                        ForeColor="Red"
                                        ValidationGroup="ResultGroup">
                                </asp:RequiredFieldValidator>

                                    <asp:RegularExpressionValidator
                                        ID="revResultYear"
                                        runat="server"
                                        ControlToValidate="txtResultYear"
                                        ValidationExpression="^\d{4}$"
                                        ErrorMessage="Enter a valid year, e.g. 2025."
                                        ForeColor="Red"
                                        ValidationGroup="ResultGroup">
                                </asp:RegularExpressionValidator>
                                </div>

                                <div class="form-group">
                                    <label>Marks</label>

                                    <asp:TextBox
                                        ID="txtMarks"
                                        runat="server"
                                        CssClass="form-control"
                                        Placeholder="e.g. 85">
                                </asp:TextBox>

                                    <asp:RequiredFieldValidator
                                        ID="rfvMarks"
                                        runat="server"
                                        ControlToValidate="txtMarks"
                                        ErrorMessage="Marks are required."
                                        ForeColor="Red"
                                        ValidationGroup="ResultGroup">
                                </asp:RequiredFieldValidator>

                                    <asp:RangeValidator
                                        ID="rvMarks"
                                        runat="server"
                                        ControlToValidate="txtMarks"
                                        MinimumValue="0"
                                        MaximumValue="100"
                                        Type="Integer"
                                        ErrorMessage="Marks must be between 0 and 100."
                                        ForeColor="Red"
                                        ValidationGroup="ResultGroup">
                                </asp:RangeValidator>
                                </div>

                                <asp:Button
                                    ID="btnSubmitResult"
                                    runat="server"
                                    Text="Submit Result"
                                    CssClass="btn btn-primary"
                                    OnClick="btnSubmitResult_Click"
                                    ValidationGroup="ResultGroup" />

                                <br />
                                <br />

                                <asp:Label
                                    ID="lblResultMessage"
                                    runat="server">
                            </asp:Label>

                            </div>
                        </div>
                    </section>


                    <section id="reservationSection" class="section pt-0">
                        <div class="container">
                            <div class="card border-0 rounded-0 hover-shadow p-5">

                                <h2 class="section-title">📅 My Reservations</h2>

                                <asp:GridView
                                    ID="gvReservations"
                                    runat="server"
                                    AutoGenerateColumns="False"
                                    CssClass="table table-bordered table-striped">

                                    <Columns>
                                        <asp:BoundField DataField="Reservation_Id" HeaderText="Reservation ID" />
                                        <asp:BoundField DataField="Subject_Name" HeaderText="Subject" />
                                        <asp:BoundField DataField="Tutor_Name" HeaderText="Tutor" />
                                        <asp:BoundField DataField="Timetable" HeaderText="Timetable" />
                                        <asp:BoundField DataField="Fees" HeaderText="Fees" />
                                        <asp:BoundField DataField="Status" HeaderText="Status" />
                                    </Columns>

                                </asp:GridView>

                            </div>
                        </div>
                    </section>


                    <section id="paymentSection" class="section pt-0">
                        <div class="container">
                            <div class="card border-0 rounded-0 hover-shadow p-5">

                                <h2 class="section-title">💳 Make Payment</h2>

                                <div class="form-group">
                                    <label>Select Accepted Reservation</label>

                                    <asp:DropDownList
                                        ID="ddlPaymentReservation"
                                        runat="server"
                                        CssClass="form-control">
                                    </asp:DropDownList>

                                    <asp:RequiredFieldValidator
                                        ID="rfvPaymentReservation"
                                        runat="server"
                                        ControlToValidate="ddlPaymentReservation"
                                        InitialValue="0"
                                        ErrorMessage="Please select a reservation."
                                        ForeColor="Red"
                                        ValidationGroup="PaymentGroup">
                                </asp:RequiredFieldValidator>
                                </div>

                                <div class="form-group">
                                    <label>Payment Amount</label>

                                    <asp:TextBox
                                        ID="txtPaymentAmount"
                                        runat="server"
                                        CssClass="form-control"
                                        Placeholder="e.g. 1500">
                                </asp:TextBox>

                                    <asp:RequiredFieldValidator
                                        ID="rfvPaymentAmount"
                                        runat="server"
                                        ControlToValidate="txtPaymentAmount"
                                        ErrorMessage="Payment amount is required."
                                        ForeColor="Red"
                                        ValidationGroup="PaymentGroup">
                                </asp:RequiredFieldValidator>

                                    <asp:RegularExpressionValidator
                                        ID="revPaymentAmount"
                                        runat="server"
                                        ControlToValidate="txtPaymentAmount"
                                        ValidationExpression="^\d+(\.\d{1,2})?$"
                                        ErrorMessage="Enter a valid amount."
                                        ForeColor="Red"
                                        ValidationGroup="PaymentGroup">
                                </asp:RegularExpressionValidator>
                                </div>

                                <asp:Button
                                    ID="btnMakePayment"
                                    runat="server"
                                    Text="Make Payment"
                                    CssClass="btn btn-primary"
                                    OnClick="btnMakePayment_Click"
                                    ValidationGroup="PaymentGroup" />

                                <br />
                                <br />

                                <asp:Label
                                    ID="lblPaymentMessage"
                                    runat="server">
                            </asp:Label>

                                <hr />

                                <h3>My Payments</h3>

                                <asp:GridView
                                    ID="gvPayments"
                                    runat="server"
                                    AutoGenerateColumns="False"
                                    CssClass="table table-bordered table-striped">

                                    <Columns>
                                        <asp:BoundField DataField="Payment_Id" HeaderText="Payment ID" />
                                        <asp:BoundField DataField="Payment_Amount" HeaderText="Amount" />
                                        <asp:BoundField DataField="Payment_Date" HeaderText="Payment Date" />
                                        <asp:BoundField DataField="Subject_Name" HeaderText="Subject" />
                                        <asp:BoundField DataField="Tutor_Name" HeaderText="Tutor" />
                                    </Columns>

                                </asp:GridView>

                            </div>
                        </div>
                    </section>


                    <section id="testimonialSection" class="section pt-0">
                        <div class="container">
                            <div class="card border-0 rounded-0 hover-shadow p-5">

                                <h2 class="section-title">⭐ Add Testimonial</h2>

                                <div class="form-group">
                                    <label>Rating</label>

                                    <asp:DropDownList
                                        ID="ddlRating"
                                        runat="server"
                                        CssClass="form-control">

                                        <asp:ListItem Value="">-- Select Rating --</asp:ListItem>
                                        <asp:ListItem Value="1">1 - Poor</asp:ListItem>
                                        <asp:ListItem Value="2">2 - Fair</asp:ListItem>
                                        <asp:ListItem Value="3">3 - Good</asp:ListItem>
                                        <asp:ListItem Value="4">4 - Very Good</asp:ListItem>
                                        <asp:ListItem Value="5">5 - Excellent</asp:ListItem>

                                    </asp:DropDownList>

                                    <asp:RequiredFieldValidator
                                        ID="rfvRating"
                                        runat="server"
                                        ControlToValidate="ddlRating"
                                        InitialValue=""
                                        ErrorMessage="Please select a rating."
                                        ForeColor="Red"
                                        ValidationGroup="TestimonialGroup">
    </asp:RequiredFieldValidator>
                                </div>


                                <div class="form-group">
                                    <label>Testimonial</label>

                                    <asp:TextBox
                                        ID="txtTestimonial"
                                        runat="server"
                                        CssClass="form-control"
                                        TextMode="MultiLine"
                                        Rows="4"
                                        Placeholder="Write your feedback about MoProf or your tutor">
                                </asp:TextBox>

                                    <asp:RequiredFieldValidator
                                        ID="rfvTestimonial"
                                        runat="server"
                                        ControlToValidate="txtTestimonial"
                                        ErrorMessage="Testimonial is required."
                                        ForeColor="Red"
                                        ValidationGroup="TestimonialGroup">
                                </asp:RequiredFieldValidator>
                                </div>

                                <asp:Button
                                    ID="btnAddTestimonial"
                                    runat="server"
                                    Text="Submit Testimonial"
                                    CssClass="btn btn-primary"
                                    OnClick="btnAddTestimonial_Click"
                                    ValidationGroup="TestimonialGroup" />

                                <br />
                                <br />

                                <asp:Label
                                    ID="lblTestimonialMessage"
                                    runat="server">
                            </asp:Label>

                                <hr />

                                <h3>My Testimonials</h3>

                                <asp:Repeater ID="rptMyTestimonials" runat="server">
    <ItemTemplate>
        <div class="card p-3 mb-3">
            <p><strong>Rating:</strong> <%# Eval("Rating") %> / 5</p>
            <p><%# Eval("Testimonial_Text") %></p>
        </div>
    </ItemTemplate>
</asp:Repeater>

                            </div>
                        </div>
                    </section>

                    
                    <section id="recommendationSection" class="section pt-0">
                        <div class="container">
                            <div class="card border-0 rounded-0 hover-shadow p-5">

                                <h2 class="section-title">👍 Recommend Subject</h2>

                                <div class="form-group">
                                    <label>Select Subject to Recommend</label>

                                    <asp:DropDownList
                                        ID="ddlRecommendSubject"
                                        runat="server"
                                        CssClass="form-control">
                                    </asp:DropDownList>

                                    <asp:RequiredFieldValidator
                                        ID="rfvRecommendSubject"
                                        runat="server"
                                        ControlToValidate="ddlRecommendSubject"
                                        InitialValue="0"
                                        ErrorMessage="Please select a subject."
                                        ForeColor="Red"
                                        ValidationGroup="RecommendationGroup">
                                </asp:RequiredFieldValidator>
                                </div>

                                <asp:Button
                                    ID="btnRecommendSubject"
                                    runat="server"
                                    Text="Recommend Subject"
                                    CssClass="btn btn-primary"
                                    OnClick="btnRecommendSubject_Click"
                                    ValidationGroup="RecommendationGroup" />

                                <br />
                                <br />

                                <asp:Label
                                    ID="lblRecommendationMessage"
                                    runat="server">
                            </asp:Label>

                                <hr />

                                <h3>My Recommendations</h3>

                                <asp:GridView
                                    ID="gvRecommendations"
                                    runat="server"
                                    AutoGenerateColumns="False"
                                    CssClass="table table-bordered table-striped">

                                    <Columns>
                                        <asp:BoundField DataField="Subject_Name" HeaderText="Subject" />
                                        <asp:BoundField DataField="Tutor_Name" HeaderText="Tutor" />
                                    </Columns>

                                </asp:GridView>

                            </div>
                        </div>
                    </section>

                </div>

            </div>
        </div>
    </section>



</asp:Content>
