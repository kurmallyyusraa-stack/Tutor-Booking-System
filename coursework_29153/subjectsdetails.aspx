<%@ Page Title="" Language="C#" MasterPageFile="~/guestmaster.Master" AutoEventWireup="true" CodeBehind="subjectsdetails.aspx.cs" Inherits="coursework_29153.subjectsdetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<section class="page-title-section overlay" data-background="assets/images/backgrounds/page-title.jpg">
    <div class="container">
        <div class="row">
            <div class="col-md-8">
                <ul class="list-inline custom-breadcrumb">
                    <li class="list-inline-item">
                        <a class="h2 text-white font-secondary" href="subjects.aspx">Subject Details</a>
                    </li>
                </ul>
                <p class="text-white">View full details of the selected MoProf subject.</p>
            </div>
        </div>
    </div>
</section>

<section class="section-sm">
    <div class="container">

        <div class="row">
            <div class="col-12 mb-4">
                <img src="assets/images/courses/course-single.jpg" class="img-fluid w-100" alt="Subject Details" />
            </div>
        </div>

        <div class="row align-items-center mb-5">
            <div class="col-xl-3 col-sm-6 mb-4 mb-xl-0">
                <h2><asp:Label ID="lblSubjectName" runat="server"></asp:Label></h2>
            </div>

            <div class="col-xl-6 col-12">
                <ul class="list-inline text-xl-center">
                    <li class="list-inline-item mr-4 mb-3">
                        <h6 class="mb-0">CATEGORY</h6>
                        <p><asp:Label ID="lblCategory" runat="server"></asp:Label></p>
                    </li>

                    <li class="list-inline-item mr-4 mb-3">
                        <h6 class="mb-0">GRADE</h6>
                        <p><asp:Label ID="lblGrade" runat="server"></asp:Label></p>
                    </li>

                    <li class="list-inline-item mr-4 mb-3">
                        <h6 class="mb-0">DISTRICT</h6>
                        <p><asp:Label ID="lblDistrict" runat="server"></asp:Label></p>
                    </li>
                </ul>
            </div>

            <div class="col-xl-3 col-sm-6 mb-4 mb-xl-0 text-sm-right">
                <asp:Button
                    ID="btnReserveSubject"
                    runat="server"
                    Text="Reserve Subject"
                    CssClass="btn btn-primary"
                    OnClick="btnReserveSubject_Click" />
            </div>

            <div class="col-12 mt-4">
                <div class="border-bottom border-primary"></div>
            </div>
        </div>

        <div class="row">

            <div class="col-12 mb-4">
                <h3>About Subject</h3>
                <p>
                    <asp:Label ID="lblAboutSubject" runat="server"></asp:Label>
                </p>
            </div>

            <div class="col-12 mb-4">
                <asp:DetailsView
                    ID="DetailsView1"
                    runat="server"
                    Visible="false"
                    AutoGenerateRows="true">
                </asp:DetailsView>
            </div>

            <div class="col-12 mb-4">
                <h3 class="mb-3">Student Requirements</h3>
                <div class="row">
                    <div class="col-md-6">
                        <ul class="list-styled">
                            <li>The student must be registered on MoProf.</li>
                            <li>The student must select the correct grade level.</li>
                            <li>The student should attend lessons regularly.</li>
                            <li>The student should complete assigned homework.</li>
                        </ul>
                    </div>

                    <div class="col-md-6">
                        <ul class="list-styled">
                            <li>The student should bring required learning materials.</li>
                            <li>The student may upload previous results if requested.</li>
                            <li>The student must reserve the subject before joining.</li>
                            <li>The student should follow the tutor's instructions.</li>
                        </ul>
                    </div>
                </div>
            </div>

            <div class="col-12 mb-4">
                <h3 class="mb-3">How to Reserve</h3>
                <ul class="list-styled">
                    <li>Login using a registered student account.</li>
                    <li>Browse the available subjects on the Subjects page.</li>
                    <li>Click View More Details to view subject information.</li>
                    <li>Click Reserve Subject to reserve the selected subject.</li>
                    <li>The reservation will be stored in the StudentSubjectReservation table.</li>
                </ul>
            </div>

            <div class="col-12 mb-5">
                <h3>Payment Information</h3>
                <p>
                    After a student reserves a subject, the payment details can be recorded in the Payment table.
                    Each payment is linked to a reservation record.
                </p>
            </div>

            <div class="col-12">
                <h3 class="mb-3">Tutor</h3>

                <div class="media mb-2">
                    <img class="mr-4 img-fluid" src="assets/images/teachers/teacher-1.jpg" alt="Tutor" width="120" />

                    <div class="media-body">
                        <h4 class="mt-0">
                            <asp:Label ID="lblTutorName" runat="server"></asp:Label>
                        </h4>

                        <p>
                            <strong>Qualification:</strong>
                            <asp:Label ID="lblQualification" runat="server"></asp:Label><br />

                            <strong>Skills:</strong>
                            <asp:Label ID="lblSkills" runat="server"></asp:Label><br />

                            <strong>Experience:</strong>
                            <asp:Label ID="lblExperience" runat="server"></asp:Label>
                        </p>
                    </div>
                </div>

                <div class="border-bottom border-primary mt-4"></div>
            </div>

        </div>
    </div>
</section>

</asp:Content>