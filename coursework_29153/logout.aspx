<%@ Page Title="" Language="C#" MasterPageFile="~/guestmaster.Master" AutoEventWireup="true" CodeBehind="logout.aspx.cs" Inherits="coursework_29153.logout" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <section class="section">
    <div class="container">
        <div class="card border-0 rounded-0 hover-shadow p-5 text-center">

            <h2 class="section-title">You have logged out successfully</h2>

            <p class="mb-4">
                Thank you for using MoProf. You can return to the home page or log in again.
            </p>

            <a href="home.aspx" class="btn btn-primary">Go to Home</a>

            &nbsp;

            <a href="login.aspx" class="btn btn-secondary">Login Again</a>

        </div>
    </div>
</section>

</asp:Content>
