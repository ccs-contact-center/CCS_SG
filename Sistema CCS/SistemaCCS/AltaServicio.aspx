<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Masterpages/Dash.Master" CodeBehind="AltaServicio.aspx.vb" Inherits="SistemaCCS.AltaServicio" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>

     

        function guardar() {


            if ($("#form1").validationEngine('validate') == true) {


                var area = JSON.parse(b64_to_utf8(Cookies.get('UserSettings').substr(9))).area
                var usuario = JSON.parse(b64_to_utf8(Cookies.get('UserSettings').substr(9))).usuario
                var mail = JSON.parse(b64_to_utf8(Cookies.get('UserSettings').substr(9))).correo


                var servicio = callAjax("AltaServicio.aspx", "NewService", '{"Servicio":"' + document.getElementById('service').value + '", "Area_Solcitante":"' + area + '"}')





                swal({
                    title: '¡Correcto!',
                    html: '¡Se dio de alta el servicio: <b>' + servicio[0].Servicio + '</b> correctamente!',
                    type: 'success',
                    confirmButtonText: 'OK',
                    confirmButtonColor: '#C00327',
                    allowOutsideClick: false

                })
                document.getElementById('form1').reset();

            } else {

            }
        }

        function callAjax(pagina, funcion, parametrosJSON) {


            var AJAXData = function () {
                var tmp = null;

                $.ajax({
                    type: "POST",
                    async: false,
                    url: pagina + "/" + funcion,
                    data: parametrosJSON,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        tmp = r.d

                    }
                });

                return tmp;
            }();

            var jsonData = JSON.parse(AJAXData);
            return jsonData

        }

   


        function b64_to_utf8(str) {
            return decodeURIComponent(escape(window.atob(str)));
        }



        $(document).ready(function () {


            $("#form1").validationEngine();



        });



    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container-fluid">
        <div id="ui-view">
            <div class="animated fadeIn">

                <div class="card">
                    <div class="card-header">
                        <i class="icon-pencil"></i>
                        Alta Servicio

                    </div>
                    <div class="card-body">




                        <div class="form-group row">
                            <div class="col-md-12">
                                <div class="input-group">
                                    <input id="service" class="form-control validate[required,custom[letras]]" placeholder="Nuevo Servicio" style="text-transform: uppercase">
                                    <span class="input-group-append">
                                        <a href="#" onclick="guardar();" class="btn btn-primary">Guardar</a>
                                    </span>
                                </div>
                            </div>
                        </div>

   

                    </div>

                 

                </div>



            </div>


        </div>
    </div>

</asp:Content>
