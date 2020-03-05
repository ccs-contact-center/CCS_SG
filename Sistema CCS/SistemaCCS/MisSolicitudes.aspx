<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Masterpages/Dash.Master" CodeBehind="MisSolicitudes.aspx.vb" Inherits="SistemaCCS.MisSolicitudes" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>


        function b64_to_utf8(str) {
            return decodeURIComponent(escape(window.atob(str)));
        }

        function getSelectedText(elementId) {
            var elt = document.getElementById(elementId);

            if (elt.selectedIndex == -1)
                return null;

            return elt.options[elt.selectedIndex].text;
        }

        function guardar(Detail) {

            swal({
                title: 'Consulta de Solicitud',
                confirmButtonColor: '#C00327',
                confirmButtonText: 'Ok',
                allowOutsideClick: false,
                type: 'info',
                html:
                    '<textarea readonly="true" style="text-transform: uppercase; resize: none" id="detallesolicitud" class="form-control validate[required,custom[letras]]" rows="4">' + Detail + '</textarea> </br>'
                   

            }).then((result) => {
                if (result.value) {

                  
             
                }
            })




        }


        $(function () {

            var user = JSON.parse(b64_to_utf8(Cookies.get('UserSettings').substr(9))).usuario
            var status = 1

            $("#form1").validationEngine();

            $("#example-table").tabulator({
                // height: 400, set height of table (in CSS or here), this enables the Virtual DOM and improves render speed dramatically (can be any valid css height value)
                layout: "fitColumns", //fit columns to width of table (optional)
                index:"Ticket",
                columns: [ //Define Table Columns
                    { title: "Ticket", field: "Ticket", width: 100, color: '#F0F3F5', headerFilter: true, headerFilterPlaceholder: "Buscar" },
                    { title: "Solicita", field: "Solicita", width: 220, align: "left", color: '#F0F3F5', headerFilter: true, headerFilterPlaceholder: "Buscar" },
                    { title: "Area", field: "Area Solicitud", align: "center", headerFilter: true, headerFilterPlaceholder: "Buscar" },
                    { title: "Fecha", field: "Fecha", align: "center", headerFilter: true, headerFilterPlaceholder: "Buscar" },
                    { title: "Servicio", field: "Servicio", align: "center", headerFilter: true, headerFilterPlaceholder: "Buscar" },
                    { title: "Detalle", field: "Detalle", align: "center", headerFilter: true, headerFilterPlaceholder: "Buscar" },
                    { title: "Status", field: "Status", align: "center", headerFilter: true, headerFilterPlaceholder: "Buscar" },
                    { title: "Dias", field: "Dias", align: "center", headerFilter: true, headerFilterPlaceholder: "Buscar" },


                ],
                rowClick: function (e, row) { //trigger an alert message when the row is clicked
                    //alert("Row " + row.getData().Ticket + " Clicked!!!!");
                    sessionStorage.setItem("selectedRow", row.getData().Ticket)
                    //window.location = "#miModa

                    guardar(row.getData().Detalle)


                },
            });

            var tabledata = callAjax('GetTickets', '{"Usuario":"' + user + '"}');

            //load sample data into the table
            $("#example-table").tabulator("setData", tabledata);

        });

        function callAjax(funcion, parametrosJSON) {


            var AJAXData = function () {
                var tmp = null;

                $.ajax({
                    type: "POST",
                    async: false,
                    url: "MisSolicitudes.aspx/" + funcion,
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


    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="container-fluid">
        <div id="ui-view">
            <div class="animated fadeIn">

                <div class="card">
                    <div class="card-header">
                        <i class="icon-note"></i>
                        Mis Solicitudes
                    </div>
                    <div class="card-body">
                        <div id="example-table"></div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</asp:Content>
