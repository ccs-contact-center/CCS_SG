<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Masterpages/Dash.Master" CodeBehind="Asignacion.aspx.vb" Inherits="SistemaCCS.Asignacion" %>

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

        function guardar(Detail, HTML) {

            swal({
                title: '¿Deseas tomar este ticket?',
                showCancelButton: true,
                confirmButtonColor: '#C00327',
                cancelButtonColor: '#8C8C8C',
                confirmButtonText: 'Sí',
                cancelButtonText: 'No',
                allowOutsideClick: false,
                type: 'info',
               html:
                    '<textarea readonly="true" style="text-transform: uppercase; resize: none" id="detallesolicitud" class="form-control validate[required,custom[letras]]" rows="4">' + Detail + '</textarea> </br>'+'<label for="postal-code">ASIGNAR:</label><select id="Reclutador" name="select2" class="form-control validate[required]"><option value=""></option> ' + HTML + ' </select>'
            }).then((result) => {
                if (result.value) {
                    if (getSelectedText('Reclutador') == 0) {
                        Swal.fire({
                            type: 'error',
                            title: 'ERROR...',
                            html: '<b><i>Necesitas asignar a alguien el ticket!</i></b>',
                           confirmButtonText:'<i class="fa fa-thumbs-up"></i> OK! '
                        })
                        //alert("SELECCIONA ALGO")
                    }
                    else {
                    $("#example-table").tabulator("deleteRow", sessionStorage.getItem('selectedRow'))
                    var user = JSON.parse(b64_to_utf8(Cookies.get('UserSettings').substr(9))).usuario
                      var ajaxDatos = callAjax('AsignarTicket', '{"Usuario":"' + getSelectedText('Reclutador') + '","Ticket":"' + sessionStorage.getItem("selectedRow") + '"}');
                    
                    swal({
                        title: '¡Ticket Asignado!',
                        text: 'El ticket se asigno correctamente',
                        type: 'success',
                        allowOutsideClick: false,
                        confirmButtonText: 'Ok',
                        confirmButtonColor: "#C00327"
                    }
                        )
                        }//cierre del if-else
                }
                
             })
            
        }
        //SE CREA LA FUNCION guardar2 PARA QUE DE ACUERDO AL PUESTO PUEDA ASIGNAR TICKETS O NO
        function guardar2(Detail, HTML) {

            swal({
                title: '¿Deseas tomar este ticket?',
                showCancelButton: true,
                confirmButtonColor: '#C00327',
                cancelButtonColor: '#8C8C8C',
                confirmButtonText: 'Sí',
                cancelButtonText: 'No',
                allowOutsideClick: false,
                type: 'info',
                html:
                    '<textarea readonly="true" style="text-transform: uppercase; resize: none" id="detallesolicitud" class="form-control validate[required,custom[letras]]" rows="4">' + Detail + '</textarea> </br>'+'<label for="postal-code" style="display:none">ASIGNAR:</label><select id="Reclutador" name="select2" style="display:none" class="form-control validate[required]"><option value="" >SELECCIONA</option> ' + HTML + ' </select>'
            }).then((result) => {
                if (result.value) {
                    
                    $("#example-table").tabulator("deleteRow", sessionStorage.getItem('selectedRow'))
                    var user = JSON.parse(b64_to_utf8(Cookies.get('UserSettings').substr(9))).usuario
                    var nombres=JSON.parse(b64_to_utf8(Cookies.get('UserSettings').substr(9))).nombres
                    var paterno=JSON.parse(b64_to_utf8(Cookies.get('UserSettings').substr(9))).paterno
                    var materno=JSON.parse(b64_to_utf8(Cookies.get('UserSettings').substr(9))).materno
                    var ajaxDatos = callAjax('AsignarTicket', '{"Usuario":"' + nombres +' '+ paterno +' '+ materno + '","Ticket":"' + sessionStorage.getItem("selectedRow") + '"}');
                  
                    swal({
                        title: '¡Ticket Asignado!',
                        text: 'El ticket se asigno correctamente',
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
            var puesto = JSON.parse(b64_to_utf8(Cookies.get('UserSettings').substr(9))).puesto
            //alert(puesto)
            var status = 1

            $("#form1").validationEngine();

            $("#example-table").tabulator({
               
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
                    //alert("Row " + row.getData().Ticket + " Clicked

                    if (puesto == 1) {
                        sessionStorage.setItem("selectedRow", row.getData().Ticket)
                       
                        var jsonData1 = callAjax('jefe', '{"Area":"' + area + '"}');
                        //alert(jsonData1);
                        var htmlOptions = ''
                        $.each(jsonData1, function () {

                            htmlOptions = htmlOptions + ' <option value="' + this.id + '">' + this.nombre + '</option>'
                            //console.log(htmlOptions)

                        });

                        guardar(row.getData().Detalle, htmlOptions)

                        // }
                    } else {
                        //alert("No ver ASIGNAR")
                        sessionStorage.setItem("selectedRow", row.getData().Ticket)
                        
                        var jsonData1 = callAjax('jefe', '{"Area":"' + area + '"}');
                       
                        var htmlOptions = ''
                        $.each(jsonData1, function () {

                            htmlOptions = htmlOptions + ' <option value="' + this.id + '">' + this.nombre + '</option>'
                            //console.log(htmlOptions)

                        });
                         guardar2(row.getData().Detalle, htmlOptions)
                    }
                    },

            });//cierre tabulator

            var tabledata = callAjax('GetTickets', '{"Area":"' + area + '","Status":"' + status + '", "Usuario":"' + usuario + '"}');

            //load sample data into the table
            $("#example-table").tabulator("setData", tabledata);

        });

        function callAjax(funcion, parametrosJSON) {
            
            var AJAXData = function () {
                var tmp = null;

                $.ajax({
                    type: "POST",
                    async: false,
                    url: "Asignacion.aspx/" + funcion,
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
