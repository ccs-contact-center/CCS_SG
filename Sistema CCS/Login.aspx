<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Login.aspx.vb" Inherits="SistemaCCS.Login" EnableEventValidation="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

 

    <title>Login</title>

    <!-- Icons -->
    <link href="node_modules/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <link href="node_modules/simple-line-icons/css/simple-line-icons.css" rel="stylesheet">

    <!-- Main styles for this application -->
    <link href="css/style.css" rel="stylesheet">


    <!-- Scripts required by this views -->
    <script src="node_modules/jquery/dist/jquery.min.js"></script>
    <script src="node_modules/popper.js/dist/umd/popper.min.js"></script>
    <script src="node_modules/bootstrap/dist/js/bootstrap.min.js"></script>

     

    <script src="JS/toastr.min.js"></script>
    <script src="JS/Options.js"></script>

    <script src="js/jquery.validationEngine-en.js"></script>
    <script src="js/jquery.validationEngine.js"></script>

    <!-- Styles required by this views -->

    <link href="CSS/toastr.css" rel="stylesheet" />
    <link href="CSS/ValidationEngine.css" rel="stylesheet" type="text/css" />

    <script id="grid" type="text/javascript">function pageLoad() {jQuery("#form1").validationEngine();}</script>


</head>

<body class="app flex-row align-items-center">



    <div class="container">
        <div class="row justify-content-center">

            <div class="col-md-8">
                <form id="form1" runat="server">


                    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"></asp:ToolkitScriptManager>
              



                            <div class="card-group">
                                <div class="card p-4">
                                    <div class="card-body">
                                        <h1>Login</h1>
                                        <p class="text-muted">Ingresa a tu cuenta</p>
                                        <div class="input-group mb-3">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text"><i class="icon-user"></i></span>
                                            </div>
                                            <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control validate[required,custom[letras]]" placeholder="Username"></asp:TextBox>

                                        </div>
                                        <div class="input-group mb-4">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text"><i class="icon-lock"></i></span>
                                            </div>
                                            <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control validate[required]" placeholder="Password" TextMode="Password"></asp:TextBox>

                                        </div>
                                        <div class="row">
                                            <div class="col-6">
                                                <asp:Button ID="Button1" runat="server" Text="Login" CssClass="btn btn-primary px-4" />

                                            </div>
                                            <div class="col-6 text-right">
                                                <a href="#" class="btn btn-link px-0">Olvidaste tu password?</a>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="card text-white d-md-down-none" style="width: 44%">
                                    <img src="./img/BootScreen.png" width="400px" height="400px" />
                                </div>
                            </div>

                
                </form>
            </div>
        </div>
    </div>


    <!-- Bootstrap and necessary plugins -->


</body>

</html>
