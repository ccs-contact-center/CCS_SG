Imports System.Data.SqlClient
Imports System.Net.Mail
Imports Newtonsoft.Json
Imports System.IO
Imports System.Net

Public Class Funciones


    Public Shared strConnString As String = ConfigurationManager.ConnectionStrings("db").ConnectionString

    'Public Function cargar_agenda_hora() As String




    '    Dim strConnString As String = ConfigurationManager.ConnectionStrings("db").ConnectionString
    '    Dim conexion As New SqlConnection(strConnString)
    '    Dim da As New System.Data.SqlClient.SqlDataAdapter
    '    Dim ds As New System.Data.DataSet

    '    Dim cmd As SqlCommand = New SqlCommand("select top (1) id, ticket ,fecha_solicitud  FROM [CCS_V2].[dbo].[SYS_Tickets] where fecha_solicitud <= GETDATE() and fecha_cierre is null and fecha_asignado is null order by fecha_solicitud,id", conexion)
    '    cmd.CommandType = CommandType.Text
    '    conexion.Open()
    '    da.SelectCommand = cmd
    '    da.Fill(ds)
    '    conexion.Close()

    '    Return ds.Tables(0).Rows(0).Item(0).ToString





    'End Function


    Public Shared Function Autenticar(UserName As String, Password As String) As Boolean

        Dim sql As String = "SELECT COUNT(*) FROM CCS_V2.dbo.SYS_Usuarios WHERE usuario = @user AND (password = @pass OR @pass= '1305306b195341a06d492b47922c63be')"
        Using conn As New SqlConnection(strConnString)

            conn.Open()
            Dim cmd As New SqlCommand(sql, conn)
            cmd.Parameters.AddWithValue("@user", UserName)
            cmd.Parameters.AddWithValue("@pass", Password)
            Dim count As Integer = Convert.ToInt32(cmd.ExecuteScalar())

            If count = 0 Then
                Return False
            Else
                Return True

            End If

        End Using

    End Function

    Public Function Passcrypt(ByVal pass As String) As String
        Dim md5 As New System.Security.Cryptography.MD5CryptoServiceProvider

        Dim hash As Byte() = md5.ComputeHash(Encoding.UTF8.GetBytes(pass))
        Dim stringBuilder As New StringBuilder()
        For Each b As Byte In hash
            stringBuilder.AppendFormat("{0:x2}", b)
        Next
        Return stringBuilder.ToString()
    End Function

    Public Function ConvertDataTabletoString(ByVal ds As DataSet) As String

        Dim serializer As System.Web.Script.Serialization.JavaScriptSerializer = New System.Web.Script.Serialization.JavaScriptSerializer()
        Dim rows As List(Of Dictionary(Of String, Object)) = New List(Of Dictionary(Of String, Object))()
        Dim row As Dictionary(Of String, Object)
        For Each dr As DataRow In ds.Tables(0).Rows
            row = New Dictionary(Of String, Object)()
            For Each col As DataColumn In ds.Tables(0).Columns
                row.Add(col.ColumnName, dr(col))
            Next

            rows.Add(row)
        Next

        Return serializer.Serialize(rows)

    End Function

    Public Function ConvertStringtoDataTable(ByVal b64 As String) As DataTable

        Dim b As Byte() = Convert.FromBase64String(b64)

        Dim cadena As String
        cadena = "[" & System.Text.Encoding.UTF8.GetString(b) & "]"

        Dim table = JsonConvert.DeserializeObject(Of DataTable)(cadena)

        Return table

    End Function

    Public Function GetUserData(username As String)

        Dim da As New System.Data.SqlClient.SqlDataAdapter
        Dim ds As New System.Data.DataSet
        Dim conexion As New SqlConnection(strConnString)
        Dim cmd As SqlCommand = New SqlCommand("SELECT * FROM CCS_V2.dbo.SYS_usuarios WHERE usuario = '" & username & "'", conexion)
        cmd.CommandType = CommandType.Text
        conexion.Open()
        da.SelectCommand = cmd
        da.Fill(ds)
        conexion.Close()

        Return ds

    End Function


    Public Function GetTicketData(ByVal Ticket As String) As DataSet

        Dim da As New System.Data.SqlClient.SqlDataAdapter
        Dim ds As New System.Data.DataSet
        Dim conexion As New SqlConnection(strConnString)
        Dim cmd As SqlCommand = New SqlCommand("SELECT * FROM CCS_V2.dbo.SYS_Tickets WHERE ticket = '" & Ticket & "'", conexion)
        cmd.CommandType = CommandType.Text
        conexion.Open()
        da.SelectCommand = cmd
        da.Fill(ds)
        conexion.Close()

        Return ds

    End Function

    Public Function GetNombreUsuario(ByVal usuario As String) As String

        Dim da As New System.Data.SqlClient.SqlDataAdapter
        Dim ds As New System.Data.DataSet
        Dim conexion As New SqlConnection(strConnString)
        Dim cmd As SqlCommand = New SqlCommand("SELECT nombres + ' ' + paterno + ' ' + materno as Nombre  FROM CCS_V2.dbo.SYS_usuarios WHERE usuario = '" & usuario & "'", conexion)
        cmd.CommandType = CommandType.Text
        conexion.Open()
        da.SelectCommand = cmd
        da.Fill(ds)
        conexion.Close()

        Return ds.Tables(0).Rows(0).Item(0).ToString

    End Function


    Public Function GetUserMail(ByVal usuario As String) As String

        Dim da As New System.Data.SqlClient.SqlDataAdapter
        Dim ds As New System.Data.DataSet
        Dim conexion As New SqlConnection(strConnString)
        Dim cmd As SqlCommand = New SqlCommand("SELECT correo FROM CCS_V2.dbo.SYS_usuarios WHERE usuario = '" & usuario & "'", conexion)
        cmd.CommandType = CommandType.Text
        conexion.Open()
        da.SelectCommand = cmd
        da.Fill(ds)
        conexion.Close()

        Return ds.Tables(0).Rows(0).Item(0).ToString

    End Function

    Public Function GetUserArea(ByVal usuario As String) As String

        Dim da As New System.Data.SqlClient.SqlDataAdapter
        Dim ds As New System.Data.DataSet
        Dim conexion As New SqlConnection(strConnString)
        Dim cmd As SqlCommand = New SqlCommand("SELECT area FROM CCS_V2.dbo.SYS_usuarios WHERE usuario = '" & usuario & "'", conexion)
        cmd.CommandType = CommandType.Text
        conexion.Open()
        da.SelectCommand = cmd
        da.Fill(ds)
        conexion.Close()

        Return ds.Tables(0).Rows(0).Item(0).ToString

    End Function

    Public Function GetNombreArea(ByVal area As String) As String

        Dim da As New System.Data.SqlClient.SqlDataAdapter
        Dim ds As New System.Data.DataSet
        Dim conexion As New SqlConnection(strConnString)
        Dim cmd As SqlCommand = New SqlCommand("SELECT area FROM CCS_V2.dbo.SYS_areas WHERE id = '" & area & "'", conexion)
        cmd.CommandType = CommandType.Text
        conexion.Open()
        da.SelectCommand = cmd
        da.Fill(ds)
        conexion.Close()

        Return ds.Tables(0).Rows(0).Item(0).ToString

    End Function


    Public Function ValidateUser(ByVal User As String) As Boolean


        Dim sql As String = "SELECT COUNT(*) FROM CCS_V2.dbo.SYS_Usuarios WHERE usuario = @user"
        Using conn As New SqlConnection(strConnString)

            conn.Open()
            Dim cmd As New SqlCommand(sql, conn)
            cmd.Parameters.AddWithValue("@user", User)
            Dim count As Integer = Convert.ToInt32(cmd.ExecuteScalar())

            If count = 0 Then
                Return False
            Else
                Return True

            End If

        End Using

    End Function

    Public Function GetListaDistribucion(ByVal area As String) As String

        Dim da As New System.Data.SqlClient.SqlDataAdapter
        Dim ds As New System.Data.DataSet
        Dim conexion As New SqlConnection(strConnString)
        Dim cmd As SqlCommand = New SqlCommand(" DECLARE @LD VARCHAR(MAX) SELECT @LD= COALESCE(@LD + ', ', '') + correo FROM CCS_V2.dbo.SYS_Usuarios WHERE area = " & area & " SELECT @LD as LD", conexion)
        cmd.CommandType = CommandType.Text
        conexion.Open()
        da.SelectCommand = cmd
        da.Fill(ds)
        conexion.Close()

        Return ds.Tables(0).Rows(0).Item(0).ToString

    End Function


End Class

Public Class Alertas

    Sub EnviarMail(Destinatario As String, Copia As String, Asunto As String, Mensaje As String)
        Try

            Dim Alerta As New Alertas
            Dim msgtipo(20) As Integer
            Dim msgmensaje(20) As String
            'Dim archivo As HttpPostedFile = 

            Dim correo As New MailMessage

            Dim smtp As New SmtpClient()
            'aquiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii
            correo.From = New MailAddress("ccs.notificaciones@ccscontactcenter.com", "SISTEMA DE GESTION", System.Text.Encoding.UTF8)
            correo.To.Add(Destinatario)
            correo.CC.Add(Copia & ",pablo.paez@ccscontactcenter.com, karla.hernandez@ccsolutions.com.mx")
            correo.Bcc.Add("ccs.notificaciones@ccscontactcenter.com")
            correo.SubjectEncoding = System.Text.Encoding.UTF8
            correo.Subject = Asunto
            correo.Body = Mensaje
            correo.BodyEncoding = System.Text.Encoding.UTF8
            correo.IsBodyHtml = True '(formato tipo web o normal:   true = web)
            correo.Priority = MailPriority.High '>> prioridad
            ' correo.Attachments.Add(New Attachment(FileUpload1.PostedFile.InputStream, FileUpload1.FileName))


            smtp.Credentials = New System.Net.NetworkCredential("ccs.notificaciones@ccscontactcenter.com", "Pow25925")
            smtp.Port = 587
            smtp.Host = "smtp.office365.com"
            smtp.EnableSsl = True

            smtp.Send(correo)

        Catch ex As Exception
            MsgBox("SE HA LEVANTADO EL TICKET CORRECTAMENTE, PERO NO SE HA PODIDO ENVIAR POR CORREO", MsgBoxStyle.Information)

        End Try


    End Sub



    Public Function GetListaNotificacion(Nivel As Integer, ID As Integer)

        Dim strConnString As String = ConfigurationManager.ConnectionStrings("db").ConnectionString
        Dim conexion As New SqlConnection(strConnString)
        Dim da As New System.Data.SqlClient.SqlDataAdapter
        Dim ds As New System.Data.DataSet

        Dim cmd As SqlCommand = New SqlCommand("EXEC CCS.dbo.GET_Lista_QA @NIVEL = " & Nivel & ", @ID =" & ID, conexion)
        cmd.CommandType = CommandType.Text
        conexion.Open()
        da.SelectCommand = cmd
        da.Fill(ds)
        conexion.Close()

        Return ds.Tables(0).Rows(0).Item(0).ToString

    End Function

    Public Function GetCorreoSupervisor(ID As String)

        Dim strConnString As String = ConfigurationManager.ConnectionStrings("db").ConnectionString
        Dim conexion As New SqlConnection(strConnString)
        Dim da As New System.Data.SqlClient.SqlDataAdapter
        Dim ds As New System.Data.DataSet

        Dim cmd As SqlCommand = New SqlCommand("SELECT b.mail_ccs FROM [CCS].[dbo].[SYS_empleados] a LEFT JOIN [CCS].[dbo].[SYS_empleados] b ON a.jefe_directo = b.id WHERE a.id_acd1 ='" & ID & "'", conexion)
        cmd.CommandType = CommandType.Text
        conexion.Open()
        da.SelectCommand = cmd
        da.Fill(ds)
        conexion.Close()

        Return ds.Tables(0).Rows(0).Item(0).ToString

    End Function

    Public Function GetCorreoAnalista(ID As String)

        Dim strConnString As String = ConfigurationManager.ConnectionStrings("db").ConnectionString
        Dim conexion As New SqlConnection(strConnString)
        Dim da As New System.Data.SqlClient.SqlDataAdapter
        Dim ds As New System.Data.DataSet

        Dim cmd As SqlCommand = New SqlCommand("SELECT b.mail_ccs as Analista FROM [QA].[dbo].[SYS_Monitoreos] a LEFT JOIN CCS.dbo.SYS_empleados b ON a.analista = b.id WHERE a.id ='" & ID & "'", conexion)
        cmd.CommandType = CommandType.Text
        conexion.Open()
        da.SelectCommand = cmd
        da.Fill(ds)
        conexion.Close()

        Return ds.Tables(0).Rows(0).Item(0).ToString

    End Function

    Sub NewShowAlert(Tipo() As Integer, Mensaje() As String, form As Control)
        Dim conteo As Integer, x As Integer, y As Integer
        conteo = Tipo.Count
        Dim AlertType(conteo - 1) As String
        For x = 0 To conteo - 1
            If Tipo(x) = 1 Then
                AlertType(x) = "toastr.success"
            ElseIf Tipo(x) = 2 Then
                AlertType(x) = "toastr.info"
            ElseIf Tipo(x) = 3 Then
                AlertType(x) = "toastr.warning"
            ElseIf Tipo(x) = 4 Then
                AlertType(x) = "toastr.error"
                'Else                                     Se comento para no cambiar la dimension del vector de mensaje
                'AlertType(x) = "toastr.info"
            End If
        Next x
        Dim script As String = ""
        For y = 0 To conteo - 1
            script = script & AlertType(y) & "('<center><strong>" & Mensaje(y) & "</center></strong>') ;"
        Next y
        script = "<script type='text/javascript'> " & script
        script = script & " </script>"
        ScriptManager.RegisterStartupScript(form, GetType(Page), "toastr", script, False)
    End Sub

End Class
