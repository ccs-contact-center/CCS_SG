Imports System.Web.Http
Imports Newtonsoft.Json

Public Class Login
    Inherits System.Web.UI.Page

    Dim conteo As Integer

    Dim x As New Funciones
    Dim Alerta As New Alertas
    Dim msgtipo(20) As Integer
    Dim msgmensaje(20) As String

    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click

        If Funciones.Autenticar(TextBox1.Text, x.Passcrypt(TextBox2.Text)) = True Then
            FormsAuthentication.RedirectFromLoginPage(TextBox1.Text, False)





            Dim cadena As String = x.ConvertDataTabletoString(x.GetUserData(TextBox1.Text))
            Dim MyChar As Char() = {"[", "]"}
            Dim cadenaok As String = cadena.Trim(MyChar)

            Dim byt As Byte() = System.Text.Encoding.UTF8.GetBytes(cadenaok)
            Dim bs64 As String = Convert.ToBase64String(byt)

            Response.Cookies("UserSettings")("UserData") = bs64
            Session("UserName") = TextBox1.Text
            Session("Area") = x.GetUserArea(TextBox1.Text)

            'Dim b As Byte() = Convert.FromBase64String(bs64)
            'Dim json As String = System.Text.Encoding.UTF8.GetString(b)

        Else
            msgtipo(0) = 4
            msgmensaje(0) = "¡El usuario o la contraseña son incorrectas!"
            Alerta.NewShowAlert(msgtipo, msgmensaje, Me)

        End If

        'If conteo > 0 Then

        '    Session("UserName") = x.cargar_agenda_hora(Session("UserName"))

        '    Session("mensajito") = "'Cuenta con " & conteo & " tickets con vencidos y sera redirigido a ellos'"

        '    Response.Redirect("index.aspx")

        'End If





    End Sub




End Class

Public Class UserModel

    Public Property id As Integer

    Public Property status As Integer

    Public Property su As Integer

    Public Property id_ccs As String

    Public Property reclutador As Object

    Public Property pass_ccs As String

    Public Property instructor As Object

    Public Property fecha_tronco As Object

    Public Property fecha_capacitacion As Object

    Public Property generacion As Object

    Public Property entrada_capa As Object

    Public Property salida_capa As Object

    Public Property evaluacion_final As Object

    Public Property pago_capa As Integer

    Public Property fecha_alta As DateTime

    Public Property fecha_baja As Object

    Public Property motivo_baja As Object

    Public Property comentario_baja As Object

    Public Property no_empleado As Object

    Public Property entrada As DateTime

    Public Property salida As DateTime

    Public Property area As Integer

    Public Property puesto As Integer

    Public Property jefe_directo As Integer

    Public Property analista As Object

    Public Property __invalid_name__campaña As Integer

    Public Property id_acd1 As String

    Public Property id_acd2 As String

    Public Property id_app1 As Object

    Public Property id_app2 As Object

    Public Property id_app3 As Object

    Public Property nombres As String

    Public Property paterno As String

    Public Property materno As String

    Public Property fecha_nacimiento As DateTime

    Public Property sexo As String

    Public Property estado_civil As String

    Public Property curp As String

    Public Property rfc As String

    Public Property nss As String

    Public Property dependientes_economicos As Object

    Public Property escolaridad As Object

    Public Property mail_ccs As String

    Public Property calle As String

    Public Property delegacion_municipio As String

    Public Property estado As String

    Public Property cp As String

    Public Property celular As String

    Public Property telefono As String

    Public Property firma_correo As String

    Public Property curso As Object

    Public Property es_tutor As Object

    Public Property tutor As Object
End Class
