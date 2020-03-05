Imports System.Data.SqlClient
Imports Newtonsoft.Json
Imports System.Web.Script.Services

Public Class MisSolicitudes
    Inherits System.Web.UI.Page

    <Services.WebMethod()>
    Public Shared Function GetTickets(ByVal Usuario As String) As String


        Dim x As New Funciones



        Dim da As New SqlDataAdapter
        Dim ds As New DataSet
        Dim sql As String = "SELECT Ticket ,b.nombres + ' ' + b.paterno as Solicita ,c.area as 'Area Solicitud',CONVERT(VARCHAR(10),fecha_solicitud,103) as Fecha,Servicio,Solicitud as Detalle ,CASE  WHEN usuario_asignado IS NULL AND fecha_cierre IS NULL THEN 'Sin Asignar' WHEN usuario_asignado IS NOT NULL AND fecha_cierre IS NULL THEN 'Proceso' WHEN usuario_asignado IS NOT NULL AND fecha_cierre IS NOT NULL THEN 'Cerrado' ELSE 'Desconocido' END as Status,DATEDIFF(DAY,fecha_solicitud,GETDATE()) as Dias FROM CCS_V2.dbo.SYS_Tickets a LEFT JOIN CCS_V2.dbo.SYS_Usuarios b ON a.solicitante = b.usuario LEFT JOIN CCS_V2.dbo.SYS_Areas c on a.area_solicitante = c.id WHERE solicitante = '" & Usuario & "'"
        Using conn As New SqlConnection(Funciones.strConnString)

            conn.Open()
            Dim cmd As New SqlCommand(sql, conn)
            da.SelectCommand = cmd
            da.Fill(ds)

        End Using

        Dim result As String = x.ConvertDataTabletoString(ds)
        'Dim corchetes As Char() = {"[", "]"}
        'Dim json As String = result.Trim(corchetes)

        Return result

    End Function

    <Services.WebMethod()>
    Public Shared Sub CerrarTicket(ByVal Detalles As String, ByVal Ticket As String)


        Dim x As New Funciones



        Dim da As New SqlDataAdapter
        Dim ds As New DataSet
        Dim sql As String = "UPDATE CCS_V2.dbo.SYS_Tickets SET detalle_cierre = '" & Detalles & "', fecha_cierre = GETDATE() WHERE ticket = '" & Ticket & "'"
        Using conn As New SqlConnection(Funciones.strConnString)

            conn.Open()
            Dim cmd As New SqlCommand(sql, conn)
            da.SelectCommand = cmd
            da.Fill(ds)

        End Using



    End Sub

End Class