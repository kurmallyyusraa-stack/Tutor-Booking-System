<%@ Page Title="" Language="C#" MasterPageFile="~/guestmaster.Master" AutoEventWireup="true" CodeBehind="admindashboard.aspx.cs" Inherits="coursework_29153.admindashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<section class="page-title-section overlay"
    data-background="assets/images/backgrounds/page-title.jpg">

    <div class="container">
        <div class="row">
            <div class="col-md-8">

                <ul class="list-inline custom-breadcrumb">
                    <li class="list-inline-item">
                        <a class="h2 text-primary font-secondary"
                           href="admindashboard.aspx">
                            Admin Dashboard
                        </a>
                    </li>
                </ul>

                <p class="text-lighten">
                    Manage categories, grade levels, districts, users and system statistics.
                </p>

            </div>
        </div>
    </div>

</section>

<style>
    .admin-menu-card {
        position: sticky;
        top: 120px;
        margin-top: 40px;
    }

    html {
        scroll-behavior: smooth;
        scroll-padding-top: 100px;
    }

    #analyticsSection,
    #registrationSettingSection,
    #pendingTutorSection,
    #categorySection,
    #gradeSection,
    #districtSection,
    #usersSection,
    #freezeSection {
        scroll-margin-top: 170px;
    }
</style>

<section class="section pt-0">
    <div class="container">
        <div class="row">

            
            <div class="col-md-3 mt-5">
                <div class="card p-3 shadow admin-menu-card">

                    <h5>Admin Menu</h5>

                    <a href="#analyticsSection" class="btn btn-primary btn-sm">Analytics</a>
                    <a href="#categorySection" class="btn btn-primary btn-sm">Manage Categories</a>
                    <a href="#gradeSection" class="btn btn-primary btn-sm">Manage Grades</a>
                    <a href="#districtSection" class="btn btn-primary btn-sm">Manage Districts</a>
                    <a href="#usersSection" class="btn btn-primary btn-sm">View/Search Users</a>
                    <a href="#freezeSection" class="btn btn-primary btn-sm">Freeze/Unfreeze Users</a>
                    <a href="#pendingTutorSection" class="btn btn-primary btn-sm">Pending Tutors</a>
                    <a href="#registrationSettingSection" class="btn btn-primary btn-sm">Registration Settings</a>
                </div>
            </div>

            
            <div class="col-md-9">

                
                <section id="analyticsSection" class="section">
                    <div class="container">
                        <div class="card border-0 rounded-0 hover-shadow p-5">

                            <h2 class="section-title">📊 System Analytics</h2>

                            <div class="row text-center">

                                <div class="col-md-4 mb-3">
                                    <div class="card p-3">
                                        <h4>Total Students</h4>
                                        <asp:Label ID="lblTotalStudents" runat="server" CssClass="h3 text-primary"></asp:Label>
                                    </div>
                                </div>

                                <div class="col-md-4 mb-3">
                                    <div class="card p-3">
                                        <h4>Total Tutors</h4>
                                        <asp:Label ID="lblTotalTutors" runat="server" CssClass="h3 text-primary"></asp:Label>
                                    </div>
                                </div>

                                <div class="col-md-4 mb-3">
                                    <div class="card p-3">
                                        <h4>Total Subjects</h4>
                                        <asp:Label ID="lblTotalSubjects" runat="server" CssClass="h3 text-primary"></asp:Label>
                                    </div>
                                </div>

                            </div>

                        </div>
                    </div>
                </section>

<section id="registrationSettingSection" class="section pt-0">
    <div class="container">
        <div class="card border-0 rounded-0 hover-shadow p-5">

            <h2 class="section-title">⚙️ Registration Settings</h2>

            

                <div class="form-group">

    <label>Student Registration Status</label>

    <asp:DropDownList
        ID="ddlStudentRegistrationStatus"
        runat="server"
        CssClass="form-control">

        <asp:ListItem Value="Enabled">Enabled</asp:ListItem>
        <asp:ListItem Value="Disabled">Disabled</asp:ListItem>

    </asp:DropDownList>
</div>
         
            <div class="form-group">
    <label>Tutor Registration Status</label>

    <asp:DropDownList
        ID="ddlTutorRegistrationStatus"
        runat="server"
        CssClass="form-control">

        <asp:ListItem Value="Enabled">Enabled</asp:ListItem>
        <asp:ListItem Value="Disabled">Disabled</asp:ListItem>

    </asp:DropDownList>
</div>

            <asp:Button
                ID="btnUpdateRegistrationStatus"
                runat="server"
                Text="Update Registration Status"
                CssClass="btn btn-primary"
                OnClick="btnUpdateRegistrationStatus_Click"
                CausesValidation="false" />

            <br /><br />

            <asp:Label
                ID="lblRegistrationStatusMessage"
                runat="server">
            </asp:Label>

        </div>
    </div>
</section>

                <section id="pendingTutorSection" class="section pt-0">
    <div class="container">
        <div class="card border-0 rounded-0 hover-shadow p-4">

            <h2 class="section-title">✅ Pending Tutor Registrations</h2>
            
            <div style="overflow-x:auto; width:100%;">

<asp:GridView
    ID="gvPendingTutors"
                runat="server"
                AutoGenerateColumns="False"
                DataKeyNames="Tutor_Id"
                CssClass="table table-bordered table-striped"
                OnRowCommand="gvPendingTutors_RowCommand">

                <Columns>
                    <asp:BoundField DataField="Tutor_Id" HeaderText="ID" />
                    <asp:BoundField DataField="Tutor_Name" HeaderText="Tutor Name" />
                    <asp:BoundField DataField="Tutor_Email" HeaderText="Email" />
                    <asp:BoundField DataField="Qualification" HeaderText="Qualification" />
                    <asp:BoundField DataField="Skills" HeaderText="Skills" />
                    <asp:BoundField DataField="Experience" HeaderText="Experience" />
                    <asp:BoundField DataField="Approval_Status" HeaderText="Approval Status" />

                    <asp:ButtonField
                        Text="Accept"
                        CommandName="AcceptTutor"
                        ButtonType="Button" />

                    <asp:ButtonField
                        Text="Deny"
                        CommandName="DenyTutor"
                        ButtonType="Button" />
                </Columns>

            </asp:GridView>
            </div>
            <br />

            <asp:Label ID="lblPendingTutorMessage" runat="server"></asp:Label>

        </div>
    </div>
</section>

            
                <section id="categorySection" class="section pt-0">
                    <div class="container">
                        <div class="card border-0 rounded-0 hover-shadow p-5">

                            <h2 class="section-title">📚 Manage Subject Categories</h2>

                            <div class="form-group">
                                <label>Category ID</label>
                                <asp:TextBox ID="txtCategoryId" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                            </div>

                            <div class="form-group">
                                <label>Category Name</label>
                                <asp:TextBox ID="txtCategoryName" runat="server" CssClass="form-control"></asp:TextBox>

                                <asp:RequiredFieldValidator
                                    ID="rfvCategoryName"
                                    runat="server"
                                    ControlToValidate="txtCategoryName"
                                    ErrorMessage="Category name is required."
                                    ForeColor="Red"
                                    ValidationGroup="CategoryGroup">
                                </asp:RequiredFieldValidator>
                            </div>

                            <asp:Button ID="btnAddCategory" runat="server" Text="Add"
                                CssClass="btn btn-primary"
                                ValidationGroup="CategoryGroup"
                                OnClick="btnAddCategory_Click" />

                            &nbsp;

                            <asp:Button ID="btnUpdateCategory" runat="server" Text="Update"
                                CssClass="btn btn-success"
                                ValidationGroup="CategoryGroup"
                                OnClick="btnUpdateCategory_Click" />

                            &nbsp;

                            <asp:Button ID="btnDeleteCategory" runat="server" Text="Delete"
                                CssClass="btn btn-danger"
                                ValidationGroup="CategoryGroup"
                                OnClick="btnDeleteCategory_Click"
                                OnClientClick="return confirm('Are you sure you want to delete this category?');" />

                            &nbsp;

                            <asp:Button ID="btnClearCategory" runat="server" Text="Clear"
                                CssClass="btn btn-secondary"
                                CausesValidation="false"
                                OnClick="btnClearCategory_Click" />

                            <br /><br />

                            <asp:Label ID="lblCategoryMessage" runat="server"></asp:Label>

                            <br /><br />

                            <asp:GridView
                                ID="gvCategory"
                                runat="server"
                                AutoGenerateColumns="False"
                                DataKeyNames="Category_Id"
                                CssClass="table table-bordered table-striped"
                                OnSelectedIndexChanged="gvCategory_SelectedIndexChanged">

                                <Columns>
                                    <asp:CommandField ShowSelectButton="True" />
                                    <asp:BoundField DataField="Category_Id" HeaderText="ID" />
                                    <asp:BoundField DataField="Category_Name" HeaderText="Category Name" />
                                </Columns>

                            </asp:GridView>

                        </div>
                    </div>
                </section>

          
                <section id="gradeSection" class="section pt-0">
                    <div class="container">
                        <div class="card border-0 rounded-0 hover-shadow p-5">

                            <h2 class="section-title">🎓 Manage Grade Levels</h2>

                            <div class="form-group">
                                <label>Grade ID</label>
                                <asp:TextBox ID="txtGradeId" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                            </div>

                            <div class="form-group">
                                <label>Grade Name</label>
                                <asp:TextBox ID="txtGradeName" runat="server" CssClass="form-control"></asp:TextBox>

                                <asp:RequiredFieldValidator
                                    ID="rfvGradeName"
                                    runat="server"
                                    ControlToValidate="txtGradeName"
                                    ErrorMessage="Grade name is required."
                                    ForeColor="Red"
                                    ValidationGroup="GradeGroup">
                                </asp:RequiredFieldValidator>
                            </div>

                            <asp:Button ID="btnAddGrade" runat="server" Text="Add"
                                CssClass="btn btn-primary"
                                ValidationGroup="GradeGroup"
                                OnClick="btnAddGrade_Click" />

                            &nbsp;

                            <asp:Button ID="btnUpdateGrade" runat="server" Text="Update"
                                CssClass="btn btn-success"
                                ValidationGroup="GradeGroup"
                                OnClick="btnUpdateGrade_Click" />

                            &nbsp;

                            <asp:Button ID="btnDeleteGrade" runat="server" Text="Delete"
                                CssClass="btn btn-danger"
                                ValidationGroup="GradeGroup"
                                OnClick="btnDeleteGrade_Click"
                                OnClientClick="return confirm('Are you sure you want to delete this grade?');" />

                            &nbsp;

                            <asp:Button ID="btnClearGrade" runat="server" Text="Clear"
                                CssClass="btn btn-secondary"
                                CausesValidation="false"
                                OnClick="btnClearGrade_Click" />

                            <br /><br />

                            <asp:Label ID="lblGradeMessage" runat="server"></asp:Label>

                            <br /><br />

                            <asp:GridView
                                ID="gvGrade"
                                runat="server"
                                AutoGenerateColumns="False"
                                DataKeyNames="Grade_Id"
                                CssClass="table table-bordered table-striped"
                                OnSelectedIndexChanged="gvGrade_SelectedIndexChanged">

                                <Columns>
                                    <asp:CommandField ShowSelectButton="True" />
                                    <asp:BoundField DataField="Grade_Id" HeaderText="ID" />
                                    <asp:BoundField DataField="Grade_Name" HeaderText="Grade Name" />
                                </Columns>

                            </asp:GridView>

                        </div>
                    </div>
                </section>

                <section id="districtSection" class="section pt-0">
                    <div class="container">
                        <div class="card border-0 rounded-0 hover-shadow p-5">

                            <h2 class="section-title">📍 Manage Districts</h2>

                            <div class="form-group">
                                <label>District ID</label>
                                <asp:TextBox ID="txtDistrictId" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                            </div>

                            <div class="form-group">
                                <label>District Name</label>
                                <asp:TextBox ID="txtDistrictName" runat="server" CssClass="form-control"></asp:TextBox>

                                <asp:RequiredFieldValidator
                                    ID="rfvDistrictName"
                                    runat="server"
                                    ControlToValidate="txtDistrictName"
                                    ErrorMessage="District name is required."
                                    ForeColor="Red"
                                    ValidationGroup="DistrictGroup">
                                </asp:RequiredFieldValidator>
                            </div>

                            <asp:Button ID="btnAddDistrict" runat="server" Text="Add"
                                CssClass="btn btn-primary"
                                ValidationGroup="DistrictGroup"
                                OnClick="btnAddDistrict_Click"/>

                            &nbsp;

                            <asp:Button ID="btnUpdateDistrict" runat="server" Text="Update"
                                CssClass="btn btn-success"
                                ValidationGroup="DistrictGroup"
                                OnClick="btnUpdateDistrict_Click" />

                            &nbsp;

                            <asp:Button ID="btnDeleteDistrict" runat="server" Text="Delete"
                                CssClass="btn btn-danger"
                                ValidationGroup="DistrictGroup"
                                OnClick="btnDeleteDistrict_Click"
                                OnClientClick="return confirm('Are you sure you want to delete this district?');" />

                            &nbsp;

                            <asp:Button ID="btnClearDistrict" runat="server" Text="Clear"
                                CssClass="btn btn-secondary"
                                CausesValidation="false"
                                OnClick="btnClearDistrict_Click" />

                            <br /><br />

                            <asp:Label ID="lblDistrictMessage" runat="server"></asp:Label>

                            <br /><br />

                            <asp:GridView
                                ID="gvDistrict"
                                runat="server"
                                AutoGenerateColumns="False"
                                DataKeyNames="District_Id"
                                CssClass="table table-bordered table-striped"
                                OnSelectedIndexChanged="gvDistrict_SelectedIndexChanged">

                                <Columns>
                                    <asp:CommandField ShowSelectButton="True" />
                                    <asp:BoundField DataField="District_Id" HeaderText="ID" />
                                    <asp:BoundField DataField="District_Name" HeaderText="District Name" />
                                </Columns>

                            </asp:GridView>

                        </div>
                    </div>
                </section>

                
                <section id="usersSection" class="section pt-0">
                    <div class="container">
                        <div class="card border-0 rounded-0 hover-shadow p-5">

                            <h2 class="section-title">👥 View and Search Users</h2>

                            <div class="form-group">
                                <label>Search User</label>
                                <asp:TextBox ID="txtSearchUser" runat="server" CssClass="form-control"
                                    Placeholder="Search by name, email or role"></asp:TextBox>
                            </div>

                            <asp:Button ID="btnSearchUser" runat="server" Text="Search"
                                CssClass="btn btn-primary"
                                OnClick="btnSearchUser_Click"
                                CausesValidation="false" />

                            &nbsp;

                            <asp:Button ID="btnShowAllUsers" runat="server" Text="Show All"
                                CssClass="btn btn-secondary"
                                OnClick="btnShowAllUsers_Click"
                                CausesValidation="false" />

                            <br /><br />

                            <asp:GridView
                                ID="gvUsers"
                                runat="server"
                                AutoGenerateColumns="False"
                                CssClass="table table-bordered table-striped">

                                <Columns>
                                    <asp:BoundField DataField="UserId" HeaderText="ID" />
                                    <asp:BoundField DataField="UserName" HeaderText="Name" />
                                    <asp:BoundField DataField="UserEmail" HeaderText="Email" />
                                    <asp:BoundField DataField="Role" HeaderText="Role" />
                                    <asp:BoundField DataField="Status" HeaderText="Status" />
                                </Columns>

                            </asp:GridView>

                        </div>
                    </div>
                </section>

                
                <section id="freezeSection" class="section pt-0">
                    <div class="container">
                        <div class="card border-0 rounded-0 hover-shadow p-5">

                            <h2 class="section-title">❄️ Freeze / Unfreeze User Membership</h2>

                            <div class="form-group">
                                <label>Select User Type</label>
                                <asp:DropDownList ID="ddlFreezeRole" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="">-- Select Role --</asp:ListItem>
                                    <asp:ListItem Value="Student">Student</asp:ListItem>
                                    <asp:ListItem Value="Tutor">Tutor</asp:ListItem>
                                </asp:DropDownList>

                                <asp:RequiredFieldValidator
                                    ID="rfvFreezeRole"
                                    runat="server"
                                    ControlToValidate="ddlFreezeRole"
                                    InitialValue=""
                                    ErrorMessage="Please select role."
                                    ForeColor="Red"
                                    ValidationGroup="FreezeGroup">
                                </asp:RequiredFieldValidator>
                            </div>

                            <div class="form-group">
                                <label>User ID</label>
                                <asp:TextBox ID="txtFreezeUserId" runat="server" CssClass="form-control"
                                    Placeholder="Enter Student_Id or Tutor_Id"></asp:TextBox>

                                <asp:RequiredFieldValidator
                                    ID="rfvFreezeUserId"
                                    runat="server"
                                    ControlToValidate="txtFreezeUserId"
                                    ErrorMessage="User ID is required."
                                    ForeColor="Red"
                                    ValidationGroup="FreezeGroup">
                                </asp:RequiredFieldValidator>
                            </div>

                            <div class="form-group">
                                <label>Status</label>
                                <asp:DropDownList ID="ddlFreezeStatus" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="Available">Unfreeze / Available</asp:ListItem>
                                    <asp:ListItem Value="Unavailable">Freeze / Unavailable</asp:ListItem>
                                </asp:DropDownList>
                            </div>

                            <asp:Button ID="btnUpdateFreezeStatus" runat="server" Text="Update Status"
                                CssClass="btn btn-primary"
                                ValidationGroup="FreezeGroup"
                                OnClick="btnUpdateFreezeStatus_Click" />

                            <br /><br />

                            <asp:Label ID="lblFreezeMessage" runat="server"></asp:Label>

                        </div>
                    </div>
                </section>

            </div>

        </div>
    </div>
    
</section>

</asp:Content>
