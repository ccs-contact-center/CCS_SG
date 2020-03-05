<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Masterpages/Dash.Master" CodeBehind="Reportes.aspx.vb" Inherits="SistemaCCS.Reportes" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script>
        jQuery(document).ready(function () {

            jQuery("#form1").validationEngine();


        });
        function getSelectedText(elementId) {
            var elt = document.getElementById(elementId);

            if (elt.selectedIndex == -1)
                return null;

            return elt.options[elt.selectedIndex].text;
        }

        function callAjax(funcion, parametrosJSON) {

            console.log(parametrosJSON)
            var AJAXData = function () {
                var tmp = null;

                $.ajax({
                    type: "POST",
                    async: false,
                    url: "Reportes.aspx/" + funcion,
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


        function ejecutar() {
            //try {

            //    var jsonData = callAjax('Ejecuta', '{"Fecha_Inicial":"' + document.getElementById('FECHA_INI').value + '", "Fecha_Final":"' + document.getElementById('FECHA_FIN').value + '", "Campania":"' + getSelectedText('CAMPANIA') + '"}');
            //} catch (err) {
                var jsonData = callAjax('Ejecuta', '{"Fecha_Inicial":"' + document.getElementById('FECHA_INI').value + '", "Fecha_Final":"' + document.getElementById('FECHA_FIN').value + '", "Campania":"0"}');
                
            //}
        }



    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    
            <div class="container-fluid">
                <div id="ui-view">
                    <div class="animated fadeIn">




                        <div class="card">
                            <div class="card-header">
                                Reportes

                            </div>
                            <div class="card-body">


                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                    <ContentTemplate>


                                <div class="row">
                                    <div class="form-group col-sm-5">
                                        <label for="city">Reporte:</label>
                                        <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-control validate[required]" AutoPostBack="true"></asp:DropDownList>
                                    </div>



                                </div>


                                <div class="row">
                                    <div class="form-group col-sm-5">
                                        <label for="city">Fecha Inicio:</label>
                                        <input type="date" name="fecha" min="" max="31/12/2001" class="form-control validate[required] " id="CFECHA_INI" data-date-format="DD MMMM YYYY" runat="server">
                                    </div>

                                    <div class="form-group col-sm-5">
                                        <label for="city">Fecha Final:</label>
                                        <input type="date" name="fecha" min="" max="31/12/2001" class="form-control validate[required] " id="CFECHA_FIN" data-date-format="DD MMMM YYYY" runat="server">
                                    </div>


                                </div>


                                           </ContentTemplate>
                                </asp:UpdatePanel>

                                <div style="margin-left:388px">
                                    <br />
                                    <asp:Button ID="Button1" runat="server" Text="Ejecutar" CssClass="btn btn-sm btn-primary" />
                                </div>


                                <br />




                                <div>
                                    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt" ProcessingMode="Remote" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="100%" Style="text-align: center" Visible="true" PageCountMode="Actual">

                                    </rsweb:ReportViewer>
                                    &nbsp;
                                </div>
                                  
                                <br />
                            </div>


                        </div>


                    </div>
                </div>
            </div>


</asp:Content>



