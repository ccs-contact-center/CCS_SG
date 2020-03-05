<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Masterpages/Dash.Master" CodeBehind="Solicitud.aspx.vb" Inherits="SistemaCCS.Solicitud" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .button {
                  background-color: #555555;
                  border: none;
                  color: white;
                  padding: 15px 32px;
                  text-align: center;
                  border-radius: 12px;
                  text-decoration: none;
                  display: inline-block;
                  font-size: 12px;
                  margin: 4px 2px;
                  cursor: pointer;
                }
    </style>
    <script src="sweetalert2.all.min.js"></script>
    <!-- for IE11 and Android browser -->
    <script src="https://cdn.jsdelivr.net/npm/promise-polyfill"></script>
 
   <%-- <script type="text/javascript">
        function FixPath(Path)
         {
             var HiddenPath = Path.toString();
             alert(HiddenPath.indexOf("FakePath"));

             if (HiddenPath.indexOf("FakePath") > 1)
             {
                 var UnwantedLength = HiddenPath.indexOf("FakePath") + 7;
                 MainStringLength = HiddenPath.length - UnwantedLength;
                 var thisArray =[];
                 var i = 0;
                 var FinalString= "";
                 while (i < MainStringLength)
                 {
                     thisArray[i] = HiddenPath[UnwantedLength + i + 1];
                     i++;
                 }
                 var j = 0;
                 while (j < MainStringLength-1)
                 {
                     if (thisArray[j] != ",")
                     {
                         FinalString += thisArray[j];
                     }
                     j++;
                 }
                 FinalString = "~" + FinalString;
                 alert(FinalString);
                 return FinalString;
             }
             else
             {
                 return HiddenPath;
             }
         }
    </script>--%>

    <script type="text/javascript" >
        function diHola() {

            var path = document.getElementById('archivoInput').value;
            console.log(path)
            $.post("/UploadHandler1.ashx", { path: path }, function (data) {
                    var d = data.split(':');
                    $("#res").html("Nombre: " + d[0] + "<br> Tamaño: " + d[1] + "<br> Extensión: " + d[2]);
            });

            Swal.fire(
                'Archivo subido correctamente!',
                'You clicked the button!',
                'success'
            )
            
        }

        function validarExt() {
            var archivoInput = document.getElementById('archivoInput');
            var archivoRuta = archivoInput.value
            console.log(archivoRuta)
            var extPermitidas = /(.PDF|.PNG|.gif|.GIF|.jpg|.jpeg|.doc|.docx|.xlsx)$/i;

            if(!extPermitidas.exec(archivoRuta))
            { 
                Swal.fire(
                'Sube un archivo válido!',
                'Selecciona un archivo con extensión correcta!',
                'error')
                archivoInput.value='';
                return false;
            }
            else 
            {
                    if(archivoInput.files && archivoInput.files[0])
                    {
                     var visor=new FileReader();
                        visor.onload = function (e) {
                            //document.getElementById("visorArchivo").innerHTML=
                            document.getElementById('visorArchivo').innerHTML =
                                '<embed src="' + e.target.result + '" width="500" height="500"></embed>';
                            visor.readAsDataURL(archivoInput.files[0]);
                        };
                }
            }
            

        }
    </script>


    <script type="text/javascript">

        var servicios = []
        var areas = []

        function guardar() {
            

            if ($("#form1").validationEngine('validate') == true) {


                var area = JSON.parse(b64_to_utf8(Cookies.get('UserSettings').substr(9))).area
                var usuario = JSON.parse(b64_to_utf8(Cookies.get('UserSettings').substr(9))).usuario
                var mail = JSON.parse(b64_to_utf8(Cookies.get('UserSettings').substr(9))).correo

                $('body').loadingModal({text: 'Cargando...'});

                var ticket = callAjax("Solicitud.aspx", "NewTicket", '{"Solicitante":"' + usuario + '", "Area_Solcitante":"' + area + '","Servicio":"' + getSelectedText('servicio') + '","Solicitud":"' + document.getElementById('descripcion').value + '","Area_Atencion":"' + document.getElementById('area').value + '","Mail":"' + mail + '"}')
                

                swal({
                    title: '¡Correcto!',
                    html: '¡Se asignó el ticket No. <b>' + ticket[0].Ticket + '</b> correctamente!',
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
                    beforeSend: function () {
                        
                        $('#submitok').css('pointer-events', 'none')
                        $( "#submitok" ).removeClass("btn-primary").addClass("btn-secondary");
                    },
                    success: function (r) {
                        tmp = r.d
                        $('body').loadingModal('hide');
                        $('#submitok').css('pointer-events', 'auto')
                        $( "#submitok" ).removeClass("btn-secondary").addClass("btn-primary");

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

        function validar(e) { // 1

            tecla = (document.all) ? e.keyCode : e.which; // 2
            if (tecla == 8) return true; // 3
            patron = /^[a-zA-Z0-9\.\s]*$/; // Acepta letras y espacios
            te = String.fromCharCode(tecla); // 5
            return patron.test(te); // 6
        }

        $(document).ready(function () {

            
            $("#form1").validationEngine();
            
            var jsonData = callAjax('Solicitud.aspx', 'Areas', '{"":""}');
            servicios = callAjax('Solicitud.aspx', 'Servicios', '{"":""}')

            $('#area').append($('<option>', {
                value: '',
                text: '~Selecciona~'
            }));

            $.each(jsonData, function () {

                $('#area').append($('<option>', {
                    value: this.id,
                    text: this.area
                }));
            });

            $.each(servicios, function () {

                $('#servicio').append($('<option>', {
                    value: this.id_area,
                    text: this.servicio
                }));
            });
            $('#servicio option').hide();


            $("#area").change(function () {


                $('#servicio option').hide();
                $('#servicio option[value=""]').show()

                $('#servicio option[value="' + $(this).val() + '"]').show()
                $("#servicio")[0].selectedIndex = 0;


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
                        Nueva Solicitud </div>

                    <div class="card-body">

                        <div class="row">

                            <div class="form-group col-sm-6">
                                <label for="area">Area:</label>
                                <select id="area" class="form-control validate[required]">
                                </select>
                            </div>

                           
                            <div class="form-group col-sm-6">
                                <label for="servicio">Servicio:</label>
                                <select id="servicio" class="form-control validate[required]">
                                    <option value="">~Selecciona~</option>

                                </select>
                            </div>
                                
                            <div class="form-group col-sm">
                                <label for="seicio">Descripción de la Solicitud:</label>
                                <textarea style="text-transform: uppercase; resize: none" id="descripcion" class="form-control validate[required]" rows="5" onkeypress="return validar(event)"></textarea>
                            </div>
                                   
                           <%--  <div class="form-group col-sm">
                                                        
                                                             
                                  <asp:Label ID="Label113" runat="server" Text="Subir Archivos:"></asp:Label><br />
                                       
                                    <asp:UpdatePanel ID="UpdatePanel10" runat="server">
                                     <ContentTemplate>


                                                     <!--<asp:FileUpload ID="fuimage30" runat="server" BorderColor="#999966" /><br /><br />
                                                     <asp:Button ID="btSubir21" runat="server" style="display:none" Text="Subir Archivo"  class="button" />   -->

                                         <input type="file" id="archivoInput" onchange="return validarExt()"/> 
                                         <a href="#" id="myLink"  onclick="diHola();" class="btn btn-sm btn-primary">Subir Archivo</a>
                                    <br /><br />
                                         <div id="res"></div>
                                         <section id="visorArchivo">

                                         </section>
                                      </ContentTemplate>
                                    </asp:UpdatePanel>
                                       
                            </div>--%>
                        
                        </div>
                    </div>

                    
                    <div class="form-group" style="text-align: center;">
                       
                        <!-- DESDE ESTE ENLACE SOLO SE PUEDE EJECUTAR UNA FUNCION DE JS guardar() -->

                         <a href="#" id="submitok" onclick="guardar(); " class="btn btn-sm btn-primary">Guardar</a>
                       
                       
                        
                        <!-- DESDE ESTE BOTON SE PUEDE EJECUTAR UNA FUNCION DE JS Y ADEMÁS CODEBEHIND -->
                      
                       <!--<asp:Button ID="submitok" runat="server" Text="GUARDAR" CssClass="button"  />  -->
                       
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
