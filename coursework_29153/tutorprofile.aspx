<%@ Page Title="" Language="C#" MasterPageFile="~/guestmaster.Master" AutoEventWireup="true" CodeBehind="tutorprofile.aspx.cs" Inherits="coursework_29153.tutorprofile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<section class="page-title-section overlay"
    data-background="assets/images/backgrounds/page-title.jpg">

    <div class="container">

        <div class="row">

            <div class="col-md-8">

                <ul class="list-inline custom-breadcrumb">
                    <li class="list-inline-item">
                        <a class="h2 text-primary font-secondary"
                           href="tutorprofile.aspx">
                            Tutor Dashboard
                        </a>
                    </li>
                </ul>

                <p class="text-lighten">
                    Manage your profile, subjects, password and account settings.
                </p>

            </div>

        </div>

    </div>

</section>


<style>
   .tutor-menu-card {
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
#addSubjectSection,
#manageSubjectSection,
#statusSection,
#announcementSection,
#bookingSection,
#enrolledStudentSection{
    scroll-margin-top: 170px;
}

</style>

<section class="section pt-0">
    <div class="container"> 
        <div class="row"> 

            <div class="col-md-3 mt-5">
                <div class="card p-3 shadow tutor-menu-card">
    
        <h5>Tutor Menu</h5>
        <a href="#profileSection" class="btn btn-primary btn-sm">My Profile</a>
        <a href="#passwordSection" class="btn btn-primary btn-sm">Change Password</a>
        <a href="#addSubjectSection" class="btn btn-primary btn-sm">Add Subject</a>
        <a href="#manageSubjectSection" class="btn btn-primary btn-sm">My Subjects</a>
        <a href="#statusSection" class="btn btn-primary btn-sm">Account Status</a>
        <a href="#announcementSection" class="btn btn-primary btn-sm">Announcements</a>
        <a href="#bookingSection" class="btn btn-primary btn-sm">Booking Requests</a> 
        <a href="#enrolledStudentsSection" class="btn btn-primary btn-sm">Enrolled Students</a>
        <a href="#studentResultsSection" class="btn btn-primary btn-sm">Student Results</a>
            </div>
            </div>

            <div class="col-md-9">

<section id="profileSection" class="section">
    <div class="container">
        <div class="card border-0 rounded-0 hover-shadow p-5">

            <h2 class="section-title">My Profile</h2>

            <div class="form-group">
                <label>Full Name</label>
                <asp:TextBox ID="txtTutorName" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Email</label>
                <asp:TextBox ID="txtTutorEmail" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Phone</label>
                <asp:TextBox ID="txtTutorPhone" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Qualification</label>
                <asp:TextBox ID="txtQualification" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Skills</label>
                <asp:TextBox ID="txtSkills" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Experience</label>
                <asp:TextBox ID="txtExperience" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
            </div>

            <div class="form-group">
    <label>Current Profile Picture</label><br />
    <asp:Image
        ID="imgTutor"
        runat="server"
        Width="120"
        Height="120"
        CssClass="mb-3" />
</div>

<div class="form-group">
    <label>Upload New Profile Picture</label>
    <asp:FileUpload
        ID="fuProfilePicture"
        runat="server"
        CssClass="form-control" />
</div>

            <asp:Button
                ID="btnUpdateProfile"
                runat="server"
                Text="Update Profile"
                CssClass="btn btn-primary"
                OnClick="btnUpdateProfile_Click" />

            <br /><br />

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

    <asp:TextBox ID="txtCurrentPassword"
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

    <asp:TextBox ID="txtNewPassword"
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

    <asp:TextBox ID="txtConfirmPassword"
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
    ValidationGroup="PasswordGroup"/>

<br /><br />

<asp:Label
    ID="lblPasswordMessage"
    runat="server">
</asp:Label>
</div>
</div>
</section>


<section id="addSubjectSection" class="section pt-0">
    <div class="container">
        <div class="card border-0 rounded-0 hover-shadow p-5">

<h2 class="section-title">📚 Add New Subject</h2>


<div class="form-group">
    <label>Subject Name</label>
    <asp:TextBox ID="txtSubjectName" runat="server"
        CssClass="form-control"></asp:TextBox>
</div>

<div class="form-group">
    <label>Category</label>
    <asp:DropDownList ID="ddlCategory"
        runat="server"
        CssClass="form-control">
    </asp:DropDownList>
</div>

<div class="form-group">
    <label>Grade</label>
    <asp:DropDownList ID="ddlGrade"
        runat="server"
        CssClass="form-control">
    </asp:DropDownList>
</div>

<div class="form-group">
    <label>Fees (Rs)</label>
    <asp:TextBox ID="txtFees"
        runat="server"
        CssClass="form-control"></asp:TextBox>
</div>

<div class="form-group">
    <label>Timetable</label>
    <asp:TextBox ID="txtTimetable"
        runat="server"
        CssClass="form-control"
        Placeholder="e.g. Mon & Wed 5PM - 7PM">
    </asp:TextBox>
</div>

<div class="form-group">
    <label>Availability</label>

    <asp:DropDownList
        ID="ddlAvailability"
        runat="server"
        CssClass="form-control">

        <asp:ListItem>Available</asp:ListItem>
        <asp:ListItem>Unavailable</asp:ListItem>

    </asp:DropDownList>
</div>

<div class="form-group">
    <label>District</label>

    <asp:DropDownList
        ID="ddlDistrict"
        runat="server"
        CssClass="form-control">
    </asp:DropDownList>
</div>

<div class="form-group">
    <label>Location</label>
    <asp:TextBox
        ID="txtLocation"
        runat="server"
        CssClass="form-control"
        Placeholder="e.g. Rose Hill, Online, At Student's Home">
    </asp:TextBox>
</div>

<div class="form-group">
    <label>Teaching Experience</label>
    <asp:TextBox ID="txtTeachingExperience"
        runat="server"
        CssClass="form-control"
        TextMode="MultiLine"
        Rows="3"></asp:TextBox>
</div>

<asp:Button
    ID="btnAddSubject"
    runat="server"
    Text="Add Subject"
    CssClass="btn btn-primary"
    OnClick="btnAddSubject_Click"
    CausesValidation="false"/>

<br /><br />

<asp:Label
    ID="lblSubjectMessage"
    runat="server">
</asp:Label>
</div>
</div>
</section>

<section id="manageSubjectSection" class="section pt-0">
    <div class="container">
        <div class="card border-0 rounded-0 hover-shadow p-5">

            <h2 class="section-title">📖 My Subjects</h2>

            <div class="form-group">
                <label>Select Subject</label>

                <asp:DropDownList
                    ID="ddlManageSubject"
                    runat="server"
                    CssClass="form-control"
                    AutoPostBack="True"
                    OnSelectedIndexChanged="ddlManageSubject_SelectedIndexChanged">
                </asp:DropDownList>

            </div>

            <div class="form-group">
                <label>Subject Name</label>
                <asp:TextBox ID="txtEditSubjectName"
                    runat="server"
                    CssClass="form-control">
                </asp:TextBox>
            </div>

            <div class="form-group">
                <label>Category</label>

                <asp:DropDownList
                    ID="ddlEditCategory"
                    runat="server"
                    CssClass="form-control">
                </asp:DropDownList>

            </div>

            <div class="form-group">
                <label>Grade</label>

                <asp:DropDownList
                    ID="ddlEditGrade"
                    runat="server"
                    CssClass="form-control">
                </asp:DropDownList>

            </div>

            <div class="form-group">
                <label>District</label>

                <asp:DropDownList
                    ID="ddlEditDistrict"
                    runat="server"
                    CssClass="form-control">
                </asp:DropDownList>

            </div>

            <div class="form-group">
                <label>Fees</label>

                <asp:TextBox
                    ID="txtEditFees"
                    runat="server"
                    CssClass="form-control">
                </asp:TextBox>

            </div>

            <div class="form-group">
                <label>Timetable</label>

                <asp:TextBox
                    ID="txtEditTimetable"
                    runat="server"
                    CssClass="form-control">
                </asp:TextBox>

            </div>

            <div class="form-group">
                <label>Availability</label>

                <asp:DropDownList
                    ID="ddlEditAvailability"
                    runat="server"
                    CssClass="form-control">

                    <asp:ListItem>Available</asp:ListItem>
                    <asp:ListItem>Unavailable</asp:ListItem>

                </asp:DropDownList>

            </div>

            <div class="form-group">
                <label>Location</label>

                <asp:TextBox
                    ID="txtEditLocation"
                    runat="server"
                    CssClass="form-control">
                </asp:TextBox>

            </div>

            <div class="form-group">
                <label>Teaching Experience</label>

                <asp:TextBox
                    ID="txtEditTeachingExperience"
                    runat="server"
                    CssClass="form-control"
                    TextMode="MultiLine"
                    Rows="3">
                </asp:TextBox>

            </div>

            <asp:Button
                ID="btnUpdateSubject"
                runat="server"
                Text="Update Subject"
                CssClass="btn btn-success"
                OnClick="btnUpdateSubject_Click" />

            &nbsp;

            <asp:Button
                ID="btnDeleteSubject"
                runat="server"
                Text="Delete Subject"
                CssClass="btn btn-danger"
                OnClick="btnDeleteSubject_Click" 
                OnClientClick="return confirm('Are you sure you want to delete this subject?');"/>

            <br /><br />

            <asp:Label
                ID="lblManageSubject"
                runat="server">
            </asp:Label>

        </div>
    </div>
</section>
    
  <section id="statusSection" class="section pt-0"> 
    <div class="container">
        <div class="card border-0 rounded-0 hover-shadow p-5">

            <h2 class="section-title">🟢 Account Status</h2>

            <div class="form-group">
                <label>Status</label>
                <asp:DropDownList ID="ddlAccountStatus" runat="server" CssClass="form-control">
                    <asp:ListItem>Available</asp:ListItem>
                    <asp:ListItem>Unavailable</asp:ListItem>
                </asp:DropDownList>
            </div>

            <asp:Button
                ID="btnUpdateStatus"
                runat="server"
                Text="Update Status"
                CssClass="btn btn-primary"
                OnClick="btnUpdateStatus_Click" />

            <br /><br />

            <asp:Label ID="lblStatusMessage" runat="server"></asp:Label>

        </div>
    </div>
</section>
                

<section id="announcementSection" class="section pt-0">
    <div class="container">
        <div class="card border-0 rounded-0 hover-shadow p-5">

            <h2 class="section-title">📢 Post Announcement</h2>

            <div class="form-group">
                <label>Announcement</label>
                <asp:TextBox
                    ID="txtAnnouncement"
                    runat="server"
                    CssClass="form-control"
                    TextMode="MultiLine"
                    Rows="4"
                    Placeholder="Enter announcement for students">
                </asp:TextBox>
                <asp:RequiredFieldValidator
    ID="reqAnnouncement"
    runat="server"
    ControlToValidate="txtAnnouncement"
    ValidationGroup="Announcement"
    ErrorMessage="Announcement is required"
    Text="(Required)"
    ForeColor="Red" />


            </div>

            <asp:Button
                ID="btnPostAnnouncement"
                runat="server"
                Text="Post Announcement"
                CssClass="btn btn-primary"
                ValidationGroup="Announcement"
                OnClick="btnPostAnnouncement_Click" />

            <br /><br />

            <asp:Label ID="lblAnnouncementMessage" runat="server"></asp:Label>

            <hr />

<h3>My Announcements</h3>
<div style="height:300px; overflow-y:auto; border:1px solid #ddd; padding:10px;">
<asp:Repeater ID="rptMyAnnouncements" runat="server">
    <ItemTemplate>
        <div class="card p-3 mb-3">
            <p><%# Eval("Announcement_Text") %></p>
        </div>
    </ItemTemplate>
</asp:Repeater>

        </div>



    </div>
        </div>
</section>

                <section id="bookingSection" class="section pt-0">
    <div class="container">
        <div class="card border-0 rounded-0 hover-shadow p-5">

            <h2 class="section-title">📅 Booking Requests</h2>

            <asp:GridView
    ID="gvBookingRequests"
    runat="server"
    AutoGenerateColumns="False"
    DataKeyNames="Reservation_Id"
    OnRowCommand="gvBookingRequests_RowCommand"
    CssClass="table table-bordered table-striped">

                <Columns>
                    <asp:BoundField DataField="Reservation_Id" HeaderText="ID" />
                    <asp:BoundField DataField="Student_Name" HeaderText="Student" />
                    <asp:BoundField DataField="Subject_Name" HeaderText="Subject" />
                    <asp:BoundField DataField="Status" HeaderText="Status" />

                    <asp:ButtonField
                        Text="Accept"
                        CommandName="AcceptBooking"
                        ButtonType="Button" />

                    <asp:ButtonField
                        Text="Reject"
                        CommandName="RejectBooking"
                        ButtonType="Button" />
                </Columns>
            </asp:GridView>

            <br />

            <asp:Label ID="lblBookingMessage" runat="server"></asp:Label>

        </div>
    </div>
</section>


<section id="enrolledStudentsSection" class="section pt-0">
    <div class="container">
        <div class="card border-0 rounded-0 hover-shadow p-5">

            <h2 class="section-title">👨‍🎓 My Enrolled Students</h2>

            <asp:GridView
                ID="gvEnrolledStudents"
                runat="server"
                AutoGenerateColumns="False"
                CssClass="table table-bordered table-striped">

                <Columns>
                    <asp:BoundField DataField="Student_Id" HeaderText="Student ID" />
                    <asp:BoundField DataField="Student_Name" HeaderText="Student Name" />
                    <asp:BoundField DataField="Subject_Name" HeaderText="Subject" />
                    <asp:BoundField DataField="Last_Login_Date" HeaderText="Last Login Date" />
                </Columns>

            </asp:GridView>

        </div>
    </div>
</section>

<section id="studentResultsSection" class="section pt-0">
    <div class="container">
        <div class="card border-0 rounded-0 hover-shadow p-5">

            <h2 class="section-title">📄 Student Results</h2>

            <asp:GridView
                ID="gvStudentResults"
                runat="server"
                AutoGenerateColumns="False"
                CssClass="table table-bordered table-striped">

                <Columns>
                    <asp:BoundField DataField="Student_Name" HeaderText="Student" />
                    <asp:BoundField DataField="Subject_Name" HeaderText="Subject" />
                    <asp:BoundField DataField="Qualification" HeaderText="Qualification" />
                    <asp:BoundField DataField="Year" HeaderText="Year" />
                   <asp:BoundField DataField="Marks" HeaderText="Marks" />
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
