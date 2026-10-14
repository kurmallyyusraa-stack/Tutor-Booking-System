<%@ Page Title="" Language="C#" MasterPageFile="~/guestmaster.Master" AutoEventWireup="true" CodeBehind="contact.aspx.cs" Inherits="coursework_29153.contact" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<section class="page-title-section overlay" data-background="assets/images/backgrounds/page-title.jpg">
    <div class="container">
        <div class="row">
            <div class="col-md-8">
                <h2 class="text-primary font-secondary">Contact MoProf</h2>
                <p class="text-lighten">Send us your message or enquiry.</p>
            </div>
        </div>
    </div>
</section>

<section class="section">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card border-0 rounded-0 hover-shadow p-5">

                    <h2 class="section-title">Contact Form</h2>

                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" />

                    <div class="form-group">
                        <label>Full Name</label>
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" Placeholder="Enter your name"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqName" runat="server" ControlToValidate="txtName"
                            ErrorMessage="Name is required" Text="(Required)" ForeColor="Red" />
                    </div>

                    <div class="form-group">
                        <label>Email</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" Placeholder="Enter your email"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqEmail" runat="server" ControlToValidate="txtEmail"
                            ErrorMessage="Email is required" Text="(Required)" ForeColor="Red" />
                        <asp:RegularExpressionValidator ID="regEmail" runat="server" ControlToValidate="txtEmail"
                            ErrorMessage="Invalid email address" Text="(Invalid Email)"
                            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ForeColor="Red" />
                    </div>

                    <div class="form-group">
                        <label>Subject</label>
                        <asp:TextBox ID="txtSubject" runat="server" CssClass="form-control" Placeholder="Enter subject"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqSubject" runat="server" ControlToValidate="txtSubject"
                            ErrorMessage="Subject is required" Text="(Required)" ForeColor="Red" />
                    </div>

                    <div class="form-group">
                        <label>Message</label>
                        <asp:TextBox ID="txtMessage" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="5" Placeholder="Enter your message"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqMessage" runat="server" ControlToValidate="txtMessage"
                            ErrorMessage="Message is required" Text="(Required)" ForeColor="Red" />
                    </div>

                    <asp:Button ID="btnSend" runat="server" Text="Send Message"
                        CssClass="btn btn-primary" OnClick="btnSend_Click" />

                     &nbsp;&nbsp;

                    <asp:Button ID="btnClear" runat="server" Text="Clear"
                        CssClass="btn btn-primary" OnClick="btnClear_Click" CausesValidation="false" />

                    <br /><br />

                    <asp:Label ID="lblMessage" runat="server"></asp:Label>

                </div>
            </div>
        </div>
    </div>
</section>

</asp:Content>
