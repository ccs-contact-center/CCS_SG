Imports System.Data.SqlClient
Imports Newtonsoft.Json
Imports System.Web.Script.Services

Public Class AltaServicio
    Inherits System.Web.UI.Page


    <Services.WebMethod()>
    Public Shared Function NewService(ByVal Servicio As String, ByVal Area_Solcitante As String) As String

        Dim x As New Funciones

        Dim da As New SqlDataAdapter
        Dim ds As New DataSet
        Dim sql As String = "INSERT INTO CCS_V2.dbo.SYS_Servicios (id_area,servicio) OUTPUT Inserted.Servicio VALUES(@Area_Solicitante,@Servicio)"
        Using conn As New SqlConnection(Funciones.strConnString)

            conn.Open()
            Dim cmd As New SqlCommand(sql, conn)

            cmd.Parameters.AddWithValue("@Area_Solicitante", Area_Solcitante)
            cmd.Parameters.AddWithValue("@Servicio", Servicio.ToUpper)

            da.SelectCommand = cmd
            da.Fill(ds)

        End Using

        Dim result As String = x.ConvertDataTabletoString(ds)

        Return result

    End Function
End Class