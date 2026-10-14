<%@ Page Title="" Language="C#" MasterPageFile="~/guestmaster.Master" AutoEventWireup="true" CodeBehind="home.aspx.cs" Inherits="coursework_29153.home" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


 <section class="hero-section overlay bg-cover" data-background="assets/images/banner/banner-1.jpg">
  <div class="container">
    <div class="hero-slider">
      <div class="hero-slider-item">
        <div class="row">
          <div class="col-md-8">
            <h1 class="text-white">Find Your Perfect Tutor with MoProf</h1>
            <p class="text-muted mb-4">
              MoProf helps students across Mauritius find qualified private tutors quickly and easily.
            </p>
            <a href="StudentRegister.aspx" class="btn btn-primary">Register as Student</a>
            <a href="TutorRegister.aspx" class="btn btn-secondary">Register as Tutor</a>

              <br /><br />

<div class="row">
    <div class="col-md-10">
        <div class="input-group">

            <asp:TextBox
                ID="txtSearch"
                runat="server"
                CssClass="form-control"
                Placeholder="Search pages (Tutors, Subjects, About, Contact...)">
            </asp:TextBox>

            <div class="input-group-append">

                <asp:Button
                    ID="btnSearch"
                    runat="server"
                    Text="Go"
                    CssClass="btn btn-primary"
                    OnClick="btnSearch_Click" />

            </div>

        </div>

        <br />

        <asp:Label
            ID="lblSearchMessage"
            runat="server"
            ForeColor="Yellow">
        </asp:Label>

    </div>
</div>

          </div>
        </div>
      </div>
    </div>
  </div>
</section>

<section class="bg-gray">
  <div class="container-fluid p-0">
    <div class="row no-gutters">
      <div class="col-xl-4 col-lg-5 align-self-end">
        <img class="img-fluid w-100" src="assets/images/banner/banner-feature.png" alt="MoProf feature">
      </div>

      <div class="col-xl-8 col-lg-7">
        <div class="row feature-blocks bg-gray justify-content-between">

          <div class="col-sm-6 col-xl-5 mb-4 text-center text-sm-left">
            <i class="ti-search mb-4 feature-icon"></i>
            <h3 class="mb-3">Search Tutors</h3>
            <p>Students can search tutors by subject, category, name, and district.</p>
          </div>

          <div class="col-sm-6 col-xl-5 mb-4 text-center text-sm-left">
            <i class="ti-user mb-4 feature-icon"></i>
            <h3 class="mb-3">Qualified Tutors</h3>
            <p>Tutors can register with their qualifications, skills, and teaching experience.</p>
          </div>

          <div class="col-sm-6 col-xl-5 mb-4 text-center text-sm-left">
            <i class="ti-calendar mb-4 feature-icon"></i>
            <h3 class="mb-3">Reserve Seats</h3>
            <p>Students can reserve seats and wait for tutor approval.</p>
          </div>

          <div class="col-sm-6 col-xl-5 mb-4 text-center text-sm-left">
            <i class="ti-star mb-4 feature-icon"></i>
            <h3 class="mb-3">Recommendations</h3>
            <p>Students can add testimonials and ratings for tutors.</p>
          </div>

        </div>
      </div>
    </div>
  </div>
</section>

<section class="section">
  <div class="container">
    <div class="row align-items-center">
      <div class="col-md-6 order-2 order-md-1">
        <h2 class="section-title">About MoProf</h2>
        <p>
          MoProf is an online tutoring platform designed to connect students with private tutors in Mauritius.
          The system allows students to browse subjects, view tutors, reserve seats, and access learning materials.
        </p>
        <p>
          Tutors can register, manage their subjects, update availability, and accept or reject student bookings.
        </p>
        <a href="About.aspx" class="btn btn-primary-outline">Learn More</a>
      </div>

      <div class="col-md-6 order-1 order-md-2 mb-4 mb-md-0">
        <img class="img-fluid w-100" src="assets/images/about/about-us.jpg" alt="About MoProf">
      </div>
    </div>
  </div>
</section>

<section class="section-sm">
  <div class="container">
    <div class="row">
      <div class="col-12">
        <div class="d-flex align-items-center section-title justify-content-between">
          <h2 class="mb-0 text-nowrap mr-3">Popular Subjects</h2>
          <div class="border-top w-100 border-primary d-none d-sm-block"></div>
          <div>
            <a href="Subjects.aspx" class="btn btn-sm btn-primary-outline ml-sm-3 d-none d-sm-block">See All</a>
          </div>
        </div>
      </div>
    </div>

    <div class="row justify-content-center">

      <div class="col-lg-4 col-sm-6 mb-5">
        <div class="card p-0 border-primary rounded-0 hover-shadow">
          <img class="card-img-top rounded-0" src="assets/images/courses/course-1.jpg" alt="Mathematics">
          <div class="card-body">
            <h4 class="card-title">Mathematics</h4>
            <p class="card-text mb-4">Find tutors for algebra, geometry, statistics, and exam preparation.</p>
            <a href="Subjects.aspx" class="btn btn-primary btn-sm">View Subject</a>
          </div>
        </div>
      </div>

      <div class="col-lg-4 col-sm-6 mb-5">
        <div class="card p-0 border-primary rounded-0 hover-shadow">
          <img class="card-img-top rounded-0" src="assets/images/courses/course-2.jpg" alt="Computer Science">
          <div class="card-body">
            <h4 class="card-title">Computer Science</h4>
            <p class="card-text mb-4">Learn programming, databases, web development, and software design.</p>
            <a href="Subjects.aspx" class="btn btn-primary btn-sm">View Subject</a>
          </div>
        </div>
      </div>

      <div class="col-lg-4 col-sm-6 mb-5">
        <div class="card p-0 border-primary rounded-0 hover-shadow">
          <img class="card-img-top rounded-0" src="assets/images/courses/course-3.jpg" alt="Science">
          <div class="card-body">
            <h4 class="card-title">Science</h4>
            <p class="card-text mb-4">Find tutors for Biology, Chemistry, Physics, and related subjects.</p>
            <a href="Subjects.aspx" class="btn btn-primary btn-sm">View Subject</a>
          </div>
        </div>
      </div>

    </div>
  </div>
</section>

<section class="section">
    <div class="container">

        <div class="row">
            <div class="col-12">
                <h2 class="section-title">Student Recommendations</h2>
            </div>
        </div>

        <div class="row">
            <asp:Repeater ID="rptHomeTestimonials" runat="server">
                <ItemTemplate>
                    <div class="col-lg-4 col-sm-6 mb-4">
                        <div class="card border-0 rounded-0 hover-shadow p-4">

                            <h5 class="text-primary">
                                <%# Eval("Student_Name") %>
                            </h5>

                            <p>
                                <strong>Rating:</strong>
                                <%# Eval("Rating") %> / 5
                            </p>

                            <p>
                                <%# Eval("Testimonial_Text") %>
                            </p>

                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

    </div>
</section>

<section class="section">
  <div class="container">
    <div class="row justify-content-center">
      <div class="col-12">
        <h2 class="section-title">Featured Tutors</h2>
      </div>

      <div class="col-lg-4 col-sm-6 mb-5 mb-lg-0">
        <div class="card border-0 rounded-0 hover-shadow">
          <img class="card-img-top rounded-0" src="assets/images/teachers/teacher-1.jpg" alt="Tutor">
          <div class="card-body">
            <h4 class="card-title">Kevin</h4>
            <p>Mathematics Tutor</p>
          </div>
        </div>
      </div>

      <div class="col-lg-4 col-sm-6 mb-5 mb-lg-0">
        <div class="card border-0 rounded-0 hover-shadow">
          <img class="card-img-top rounded-0" src="assets/images/teachers/teacher-2.jpg" alt="Tutor">
          <div class="card-body">
            <h4 class="card-title">Paul</h4>
            <p>Computer Science Tutor</p>
          </div>
        </div>
      </div>

      <div class="col-lg-4 col-sm-6 mb-5 mb-lg-0">
        <div class="card border-0 rounded-0 hover-shadow">
          <img class="card-img-top rounded-0" src="assets/images/teachers/teacher-3.jpg" alt="Tutor">
          <div class="card-body">
            <h4 class="card-title">Smith</h4>
            <p>Science Tutor</p>
          </div>
        </div>
      </div>

    </div>
  </div>
</section> 


</asp:Content>
