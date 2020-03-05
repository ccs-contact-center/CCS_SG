Imports System.Data
Imports System.Text
Imports System.Web.Services
Imports System.Data.SqlClient
Imports System.Configuration
Imports Newtonsoft.Json

Partial Public Class Index
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub





    <System.Web.Services.WebMethod()>
    Public Shared Function GetData()


        Dim conexion As New SqlConnection(ConfigurationManager.ConnectionStrings("db").ToString)
        Dim da As New System.Data.SqlClient.SqlDataAdapter
        Dim ds As New System.Data.DataSet
        Dim cmd As SqlCommand = New SqlCommand("SELECT a.Hora, ISNULL(B.Mensajes,0) as Mensajes FROM Redes_Sociales.dbo.SYS_Hours a LEFT JOIN (SELECT CASE WHEN LEN(CONVERT(VARCHAR(MAX),DATEPART(HOUR,ini))+':00') = 4 THEN '0' + CONVERT(VARCHAR(MAX),DATEPART(HOUR,ini))+':00' ELSE CONVERT(VARCHAR(MAX),DATEPART(HOUR,ini))+':00' END as Hora,COUNT(*) as Mensajes FROM [Redes_Sociales].[dbo].[SYS_Messages] GROUP BY DATEPART(HOUR,ini)) B on a.hora = b.hora", conexion)


        conexion.Open()
        cmd.CommandType = CommandType.Text
        da.SelectCommand = cmd
        da.Fill(ds)
        conexion.Close()

        Dim json As String = JsonConvert.SerializeObject(ds)

        Return json

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetConversations()

        Dim x As New Funciones
        Dim da As New SqlDataAdapter
        Dim ds As New DataSet
        Dim sql As String = "SELECT COUNT(*) as Conversaciones FROM Redes_Sociales.dbo.SYS_Conversations"
        Using conn As New SqlConnection(Funciones.strConnString)

            conn.Open()
            Dim cmd As New SqlCommand(sql, conn)
            da.SelectCommand = cmd
            da.Fill(ds)

        End Using

        Dim json As String = x.ConvertDataTabletoString(ds)

        Return json

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetClosed()

        Dim x As New Funciones
        Dim da As New SqlDataAdapter
        Dim ds As New DataSet
        Dim sql As String = "SELECT COUNT(*) as Closed FROM Redes_Sociales.dbo.SYS_Conversations WHERE status = 0"
        Using conn As New SqlConnection(Funciones.strConnString)

            conn.Open()
            Dim cmd As New SqlCommand(sql, conn)
            da.SelectCommand = cmd
            da.Fill(ds)

        End Using

        Dim json As String = x.ConvertDataTabletoString(ds)

        Return json

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetMPC()

        Dim x As New Funciones
        Dim da As New SqlDataAdapter
        Dim ds As New DataSet
        Dim sql As String = "SELECT SUM(messages)/CONVERT(FLOAT,COUNT(*)) as MPC FROM [Redes_Sociales].[dbo].[SYS_Conversations]"
        Using conn As New SqlConnection(Funciones.strConnString)

            conn.Open()
            Dim cmd As New SqlCommand(sql, conn)
            da.SelectCommand = cmd
            da.Fill(ds)

        End Using

        Dim json As String = x.ConvertDataTabletoString(ds)

        Return json

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function CierraSesion(ByVal ID As String, ByVal Status As String) As String





        Dim x As New Funciones
        Dim sql As String = "EXEC Redes_Sociales.dbo.SYS_Update_Status @Agente = @ID, @EdoNuevo = @Status"
        Using conn As New SqlConnection(Funciones.strConnString)

            conn.Open()
            Dim cmd As New SqlCommand(sql, conn)
            cmd.Parameters.AddWithValue("@ID", ID)
            cmd.Parameters.AddWithValue("@Status", Status)



            cmd.ExecuteNonQuery()

        End Using


        Return False
    End Function


End Class



