<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Masterpages/Dash.Master" CodeBehind="AltaUsuario.aspx.vb" Inherits="SistemaCCS.AltaUsuario" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>

        var servicios = []
        var areas = []

        function guardar() {


            if ($("#form1").validationEngine('validate') == true) {

               
                var area = JSON.parse(b64_to_utf8(Cookies.get('UserSettings').substr(9))).area
                var usuario = JSON.parse(b64_to_utf8(Cookies.get('UserSettings').substr(9))).usuario
                var mail = JSON.parse(b64_to_utf8(Cookies.get('UserSettings').substr(9))).correo


                var newUser = callAjax("AltaUsuario.aspx", "NewUser", '{"Nombres":"' + document.getElementById('nombres').value + '", "Paterno":"' + document.getElementById('apaterno').value + '","Materno":"' + document.getElementById('amaterno').value + '","Area":"' + document.getElementById('area').value + '","Correo":"' + document.getElementById('mail').value + '", "MyMail":"' + mail + '"}')
        


                console.log(newUser)

                if (newUser[0].Usuario == 'Duplicado') {
                     swal({
                    title: '¡Duplicado!',
                    html: '¡Este usuario ya existe en el sistema!',
                    type: 'error',
                    confirmButtonText: 'OK',
                    confirmButtonColor: '#C00327',
                    allowOutsideClick: false

                })
                } else {


                swal({
                    title: '¡Correcto!',
                    html: '¡Se dio de alta el usuario <b>' + newUser[0].Usuario + '</b> correctamente!',
                    type: 'success',
                    confirmButtonText: 'OK',
                    confirmButtonColor: '#C00327',
                    allowOutsideClick: false

                })
                document.getElementById('form1').reset();

                    }

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

        function getSelectedText(elementId) {
            var elt = document.getElementById(elementId);

            if (elt.selectedIndex == -1)
                return null;

            return elt.options[elt.selectedIndex].text;
        }


        function b64_to_utf8(str) {
            return decodeURIComponent(escape(window.atob(str)));
        }



        $(document).ready(function () {


            $("#form1").validationEngine();



            var jsonData = callAjax('AltaUsuario.aspx', 'Areas', '{"":""}');


            $('#area').append($('<option>', {
                value: '',
                text: '-Selecciona-'
            }));
            $.each(jsonData, function () {

                $('#area').append($('<option>', {
                    value: this.id,
                    text: this.area
                }));
            });


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
                        Alta Usuario

                    </div>
                    <div class="card-body">


                        <div class="row">

                            <div class="form-group col-sm-4">
                                <label>Nombres:</label>
                                <input id="nombres" class="form-control validate[required,custom[letras]]" placeholder="nombre" style="text-transform: uppercase">
                            </div>


                            <div class="form-group col-sm-4">
                                <label>Paterno:</label>
                                <input id="apaterno" class="form-control validate[required,custom[letras]]" placeholder="apellido paterno" style="text-transform: uppercase">
                            </div>

                            <div class="form-group col-sm-4">
                                <label>Materno:</label>
                                <input id="amaterno" class="form-control validate[required,custom[letras]]" placeholder="apellido materno" style="text-transform: uppercase">
                            </div>



                        </div>


                        <div class="row">

                            <div class="form-group col-sm-6">
                                <label>Area:</label>
                                <select id="area" class="form-control validate[required]">
                                </select>
                            </div>


                            <div class="form-group col-sm-6">
                                <label">Correo:</label>
                                <input id="mail" class="form-control validate[required,custom[email]]" placeholder="Correo CCS" style="text-transform: lowercase">
                            </div>



                        </div>

                    </div>

                    <div class="form-group" style="text-align: center;">
                        <a href="#" onclick="guardar();" class="btn btn-sm btn-primary">Guardar</a>
                    </div>

                </div>



            </div>


        </div>
    </div>

</asp:Content>
