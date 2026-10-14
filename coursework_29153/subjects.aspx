<%@ Page Title="" Language="C#" MasterPageFile="~/guestmaster.Master" AutoEventWireup="true" CodeBehind="subjects.aspx.cs" Inherits="coursework_29153.subjects" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<section class="page-title-section overlay" data-background="assets/images/backgrounds/page-title.jpg">
    <div class="container">
        <div class="row">
            <div class="col-md-8">
                <ul class="list-inline custom-breadcrumb">
                    <li class="list-inline-item">
                        <a class="h2 text-white font-secondary" href="subjects.aspx">Our Subjects</a>
                    </li>
                </ul>
                <p class="text-white">
                    Browse subjects offered by MoProf tutors.
                </p>
            </div>
        </div>
    </div>
</section>

<section class="section">
    <div class="container">

     <asp:Label
    ID="lblWelcome"
    runat="server"
    CssClass="h4 text-primary">
</asp:Label>

<br /><br />

        <asp:Label ID="lblDate" runat="server"
    CssClass="text-muted font-weight-bold"></asp:Label>

<br /><br />

<asp:Label ID="lblTotalSubjects"
    runat="server"
    CssClass="text-success font-weight-bold">
</asp:Label>

<br /><br />

<div id="announcementBox" runat="server" class="card border-0 rounded-0 hover-shadow p-4 mb-5">

    <h2 class="section-title">📢 Latest Announcements</h2>

    <div style="height:250px; overflow-y:auto; border:1px solid #ddd; padding:10px;">
        <asp:Repeater ID="rptAnnouncements" runat="server">
            <ItemTemplate>
                <div class="card p-3 mb-3">
                    <p><%# Eval("Announcement_Text") %></p>
                    <small>
                        Posted by: <%# Eval("Tutor_Name") %>
                    </small>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

</div>

        <div class="row mb-5">
            <div class="col-md-6">
                <asp:TextBox ID="txtSearchSubject" 
                    runat="server" 
                    CssClass="form-control" 
                    Placeholder="Search by subject, category or district">

                </asp:TextBox>
            </div>
            <div class="col-md-3">
                <asp:Button ID="btnSearchSubject" runat="server" Text="Search" CssClass="btn btn-primary" OnClick="btnSearchSubject_Click" />
            </div>
        </div>

        <div class="row">
            <asp:Repeater ID="rptSubjects" runat="server">
                <ItemTemplate>
                    <div class="col-lg-4 col-sm-6 mb-5">
                        <div class="card p-0 border-primary rounded-0 hover-shadow">

                            <img class="card-img-top rounded-0" src="assets/images/courses/course-1.jpg" alt="Subject" />

                            <div class="card-body">
                                <h4 class="card-title"><%# Eval("Subject_Name") %></h4>

                                <p><strong>Category:</strong> <%# Eval("Category_Name") %></p>
                                <p><strong>Grade:</strong> <%# Eval("Grade_Name") %></p>
                                <p><strong>District:</strong> <%# Eval("District_Name") %></p>
                                <p><strong>Tutor:</strong> <%# Eval("Tutor_Name") %></p>

                                <asp:Button
                                    ID="btnViewDetails"
                                    runat="server"
                                    Text="View More Details"
                                    CssClass="btn btn-primary btn-sm"
                                    CommandArgument='<%# Eval("Subject_Id") %>'
                                    OnClick="btnViewDetails_Click1" />
                            </div>

                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <div class="row mt-4">
            <div class="col-12 text-center">

                <asp:Button
                    ID="btnPrevious"
                    runat="server"
                    Text="Previous"
                    CssClass="btn btn-primary"
                    OnClick="btnPrevious_Click" />

                &nbsp;&nbsp;

                <asp:Button
                    ID="btnNext"
                    runat="server"
                    Text="Next"
                    CssClass="btn btn-primary"
                    OnClick="btnNext_Click"/>

            </div>
        </div>

    </div>
</section>


</asp:Content>
