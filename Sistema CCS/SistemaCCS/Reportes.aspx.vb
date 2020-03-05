Imports Microsoft.Reporting.WebForms
Imports System.Data.SqlClient
Imports Newtonsoft.Json
Public Class Reportes

    Inherits System.Web.UI.Page




    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim x As New Funciones


        If Not IsPostBack Then
            LoadReportes()

        End If

        Try

            If GetGrupoParam(DropDownList1.SelectedItem.Value) = 1 Then

            ElseIf GetGrupoParam(DropDownList1.SelectedItem.Value) = 2 Then

                'campaniasCombo.Visible = True

            Else

                'campaniasCombo.Visible = False
            End If

        Catch ex As Exception

        End Try


    End Sub

    Sub LoadReportes()

        Dim strConnString As String = ConfigurationManager.ConnectionStrings("db").ConnectionString
        Dim strQuery As String

        strQuery = "SELECT * FROM CCS.dbo.SYS_reportes WHERE status = 1 and campania=500 ORDER BY nombre_rep"


        Dim con As New SqlConnection(strConnString)
        Dim cmd As New SqlCommand()

        DropDownList1.Items.Add(New ListItem("-Selecciona-", ""))
        DropDownList1.AppendDataBoundItems = True

        cmd.CommandType = CommandType.Text
        cmd.CommandText = strQuery
        cmd.Connection = con

        con.Open()

        DropDownList1.DataSource = cmd.ExecuteReader()
        DropDownList1.DataTextField = "nombre_REP"
        DropDownList1.DataValueField = "id"
        DropDownList1.DataBind()

        con.Close()
        con.Dispose()



    End Sub

    Public Shared Function GetGrupoParam(id As Integer) As Integer

        Try

            Dim strConnString As String = ConfigurationManager.ConnectionStrings("db").ConnectionString
            Dim conexion As New SqlConnection(strConnString)
            Dim da As New System.Data.SqlClient.SqlDataAdapter
            Dim ds As New System.Data.DataSet

            Dim cmd As SqlCommand = New SqlCommand("SELECT grupo_parametros FROM CCS.dbo.SYS_reportes WHERE id = " & id, conexion)
            cmd.CommandType = CommandType.Text
            conexion.Open()
            da.SelectCommand = cmd
            da.Fill(ds)
            conexion.Close()

            Return ds.Tables(0).Rows(0).Item(0).ToString

        Catch ex As Exception
            Return 0
        End Try

    End Function




    Public Shared Function GetRSURL(id As Integer) As String

        Try

            Dim strConnString As String = ConfigurationManager.ConnectionStrings("db").ConnectionString
            Dim conexion As New SqlConnection(strConnString)
            Dim da As New System.Data.SqlClient.SqlDataAdapter
            Dim ds As New System.Data.DataSet

            Dim cmd As SqlCommand = New SqlCommand("SELECT url_RS FROM CCS.dbo.SYS_reportes WHERE id = " & id, conexion)
            cmd.CommandType = CommandType.Text
            conexion.Open()
            da.SelectCommand = cmd
            da.Fill(ds)
            conexion.Close()

            Return ds.Tables(0).Rows(0).Item(0).ToString

        Catch ex As Exception
            Return 0
        End Try

    End Function

    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click




        If GetGrupoParam(DropDownList1.SelectedValue) = 1 Then


            ReportViewer1.ServerReport.ReportPath = GetRSURL(DropDownList1.SelectedValue)
            ReportViewer1.ServerReport.ReportServerUrl = New System.Uri("http://10.0.0.40/reports")

            ReportViewer1.Visible = True
            Dim serverReport As ServerReport
            serverReport = ReportViewer1.ServerReport

            Dim Fecha_INI As New ReportParameter()
            Fecha_INI.Name = "FECHA_INI"
            Fecha_INI.Values.Add(CDate(CFECHA_INI.Value))
            Dim Fecha_FIN As New ReportParameter()
            Fecha_FIN.Name = "FECHA_FIN"
            Fecha_FIN.Values.Add(CDate(CFECHA_FIN.Value))
            Dim parameters() As ReportParameter = {Fecha_INI, Fecha_FIN}
            serverReport.SetParameters(parameters)

            serverReport.Refresh()



        Else

        End If



    End Sub
End Class