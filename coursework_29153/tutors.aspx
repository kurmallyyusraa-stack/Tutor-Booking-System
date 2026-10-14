<%@ Page Title="" Language="C#" MasterPageFile="~/guestmaster.Master" AutoEventWireup="true" CodeBehind="tutors.aspx.cs" Inherits="coursework_29153.tutors" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <section class="page-title-section overlay" data-background="assets/images/backgrounds/page-title.jpg">
        <div class="container">
            <div class="row">
                <div class="col-md-8">
                    <ul class="list-inline custom-breadcrumb">
                        <li class="list-inline-item">
                            <a class="h2 text-white font-secondary" href="tutors.aspx">Our Tutors</a>
                        </li>
                    </ul>
                    <p class="text-white">
                        Browse qualified tutors registered on MoProf.
               
                    </p>
                </div>
            </div>
        </div>
    </section>

    <section class="section">
        <div class="container">

            <div class="row mb-4">
                <div class="col-12">

                    <asp:Label
                        ID="lblWelcome"
                        runat="server"
                        CssClass="h4 text-primary">
                </asp:Label>

                    <br />

                    <asp:Label
                        ID="lblDate"
                        runat="server"
                        CssClass="text-muted font-weight-bold">
                </asp:Label>

                    <br />

                    <asp:Label
                        ID="lblTotalTutors"
                        runat="server"
                        CssClass="text-success font-weight-bold">
                </asp:Label>

                </div>
            </div>

            <div class="row mb-5">
                <div class="col-md-6">
                    <asp:TextBox ID="txtSearchTutor" runat="server" CssClass="form-control" Placeholder="Search tutor by name"></asp:TextBox>
                </div>
                <div class="col-md-3">
                    <asp:Button ID="btnSearchTutor" runat="server" Text="Search" CssClass="btn btn-primary" OnClick="btnSearchTutor_Click" />
                </div>
            </div>

            <div class="row">
                <asp:Repeater ID="rptTutors" runat="server">
                    <ItemTemplate>

                        <div class="col-lg-4 col-sm-6 mb-5">
                            <div class="card border-0 rounded-0 hover-shadow">

                                <img class="card-img-top rounded-0"
                                    src='<%# Eval("Profile_Picture") %>'
                                    alt="Tutor" />

                                <div class="card-body">
                                    <h4 class="card-title"><%# Eval("Tutor_Name") %></h4>

                                    <p><strong>Qualification:</strong> <%# Eval("Qualification") %></p>
                                    <p><strong>Skills:</strong> <%# Eval("Skills") %></p>
                                    <p><strong>Experience:</strong> <%# Eval("Experience") %></p>
                                    <p><strong>District:</strong> <%# Eval("District_Name") %></p>

                                    <p>
                                        <strong>Registered On:</strong>
                                        <%# Convert.ToDateTime(Eval("Registration_Date")).ToString("dd MMM yyyy") %>
                                    </p>

                                    <p>
    <strong>Recommended by:</strong>
    <%# Eval("RecommendationCount") %> student(s)
</p>

                                    <a href="subjects.aspx" class="btn btn-primary btn-sm">View Subjects</a>
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
                        OnClick="btnNext_Click" />

                </div>
            </div>

        </div>
    </section>


</asp:Content>
