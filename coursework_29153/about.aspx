<%@ Page Title="" Language="C#" MasterPageFile="~/guestmaster.Master" AutoEventWireup="true" CodeBehind="about.aspx.cs" Inherits="coursework_29153.about" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <section class="page-title-section overlay" data-background="assets/images/backgrounds/page-title.jpg">
    <div class="container">
        <div class="row">
            <div class="col-md-8">
                <ul class="list-inline custom-breadcrumb">
                    <li class="list-inline-item">
                        <a class="h2 text-primary font-secondary" href="About.aspx">About MoProf</a>
                    </li>
                </ul>
                <p class="text-lighten">
                    MoProf is an online platform that connects students with private tutors across Mauritius.
                </p>
            </div>
        </div>
    </div>
</section>

<section class="section">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <img class="img-fluid w-100 mb-4" src="assets/images/about/about-page.jpg" alt="About MoProf" />

                <h2 class="section-title">About MoProf</h2>

                <p>
                    MoProf is a web application designed to make private tutoring easier for students in Mauritius.
                    Students can search for tutors by subject, category, district and grade level.
                </p>

                <p>
                    The system allows tutors to register, add their qualifications, skills, teaching experience,
                    availability and subject details. Tutor accounts are reviewed by the administrator before activation.
                </p>

                <p>
                    Students can register, upload academic results, reserve seats, make payments, view announcements
                    and add recommendations or testimonials for tutors.
                </p>
            </div>
        </div>
    </div>
</section>

<section class="section-sm bg-primary">
    <div class="container">
        <div class="row">

            <div class="col-md-3 col-sm-6 mb-4 mb-md-0">
                <div class="text-center">
                    <h2 class="text-white">Students</h2>
                    <h5 class="text-white">Register & Reserve</h5>
                </div>
            </div>

            <div class="col-md-3 col-sm-6 mb-4 mb-md-0">
                <div class="text-center">
                    <h2 class="text-white">Tutors</h2>
                    <h5 class="text-white">Create Subjects</h5>
                </div>
            </div>

            <div class="col-md-3 col-sm-6 mb-4 mb-md-0">
                <div class="text-center">
                    <h2 class="text-white">Subjects</h2>
                    <h5 class="text-white">By Grade & Category</h5>
                </div>
            </div>

            <div class="col-md-3 col-sm-6 mb-4 mb-md-0">
                <div class="text-center">
                    <h2 class="text-white">Admin</h2>
                    <h5 class="text-white">Manage Platform</h5>
                </div>
            </div>

        </div>
    </div>
</section>

<section class="section bg-cover" data-background="assets/images/backgrounds/success-story.jpg">
    <div class="container">
        <div class="row">

            <div class="col-lg-6 col-sm-4 position-relative success-video">
                <a class="play-btn venobox" href="https://youtu.be/nA1Aqp0sPQo" data-vbtype="video">
                    <i class="ti-control-play"></i>
                </a>
            </div>

            <div class="col-lg-6 col-sm-8">
                <div class="bg-white p-5">
                    <h2 class="section-title">Our Purpose</h2>

                    <p>
                        MoProf helps reduce common tutoring problems such as distance, time constraints,
                        tutor availability and unreliable recommendations.
                    </p>

                    <p>
                        The platform is based on students, tutors, subjects, districts, grades, reservations,
                        recommendations, results, announcements and payments.
                    </p>
                </div>
            </div>

        </div>
    </div>
</section>

<section class="section">
    <div class="container">
        <div class="row justify-content-center">

            <div class="col-12">
                <h2 class="section-title">Why Choose MoProf?</h2>
            </div>

            <div class="col-lg-4 col-sm-6 mb-5">
                <div class="card border-0 rounded-0 hover-shadow">
                    <div class="card-body">
                        <h4>Search Easily</h4>
                        <p>Students can find tutors by subject, category, grade level and district.</p>
                    </div>
                </div>
            </div>

            <div class="col-lg-4 col-sm-6 mb-5">
                <div class="card border-0 rounded-0 hover-shadow">
                    <div class="card-body">
                        <h4>Approved Tutors</h4>
                        <p>Tutor accounts are checked and approved by the administrator before becoming active.</p>
                    </div>
                </div>
            </div>

            <div class="col-lg-4 col-sm-6 mb-5">
                <div class="card border-0 rounded-0 hover-shadow">
                    <div class="card-body">
                        <h4>Seat Reservation</h4>
                        <p>Students can reserve seats for subjects and tutors can accept or reject requests.</p>
                    </div>
                </div>
            </div>

        </div>
    </div>
</section>

</asp:Content>
