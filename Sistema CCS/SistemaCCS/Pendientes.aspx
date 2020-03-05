<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Masterpages/Dash.Master" CodeBehind="Pendientes.aspx.vb" Inherits="SistemaCCS.Pendientes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


    <script>

        function b64_to_utf8 (str) {
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
                title: 'Cierre de Solicitud',
                showCancelButton: true,
                confirmButtonColor: '#C00327',
                cancelButtonColor: '#8C8C8C',
                confirmButtonText: 'Cerrar',
                cancelButtonText: 'Cancelar',
                allowOutsideClick: false,
                type: 'info',
                html:
                    '<textarea readonly="true" style="text-transform: uppercase; resize: none" id="detallesolicitud" class="form-control validate[required,custom[letras]]" rows="4">' + Detail + '</textarea> </br>' +
                    '<textarea placeholder="Ingresa tus comentarios del cierre" style="text-transform: uppercase; resize: none" id="detallecierre" class="form-control validate[required,custom[letras]]" rows="4"></textarea>'

            }).then((result) => {
                if (result.value) {

                    $("#example-table").tabulator("deleteRow", sessionStorage.getItem('selectedRow'))
                    var user = JSON.parse(b64_to_utf8(Cookies.get('UserSettings').substr(9))).usuario
                    var ajaxDatos = callAjax('CerrarTicket', '{"Detalles":"' + document.getElementById('detallecierre').value + '","Ticket":"' + sessionStorage.getItem("selectedRow") + '"}');

                    swal({
                        title: '¡Ticket Cerrado!',
                        text: 'El ticket se te cerro correctamente',
                        type: 'success',
                        allowOutsideClick: false,
                        confirmButtonText: 'Ok',
                        confirmButtonColor: "#C00327"
                    }
                    )
                }
            })




        }


        $(function () {

            var area = JSON.parse(b64_to_utf8(Cookies.get('UserSettings').substr(9))).area
            var usuario = JSON.parse(b64_to_utf8(Cookies.get('UserSettings').substr(9))).usuario
            var status = 1

            $("#form1").validationEngine();

            $("#example-table").tabulator({
                // height: 400, set height of table (in CSS or here), this enables the Virtual DOM and improves render speed dramatically (can be any valid css height value)
                layout: "fitColumns", //fit columns to width of table (optional)
                index: "Ticket",
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
      

                    guardar(row.getData().Detalle)


                },
            });

            var tabledata = callAjax('GetTickets', '{"Area":"' + area + '","Status":"' + status + '", "Usuario":"' + usuario + '"}');

  
            $("#example-table").tabulator("setData", tabledata);

        });

        function callAjax(funcion, parametrosJSON) {


            var AJAXData = function () {
                var tmp = null;

                $.ajax({
                    type: "POST",
                    async: false,
                    url: "Pendientes.aspx/" + funcion,
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
                        Tickets Pendientes
                    </div>
                    <div class="card-body">
                        <div id="example-table"></div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</asp:Content>
