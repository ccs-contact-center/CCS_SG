Imports System.Data.SqlClient
Imports Newtonsoft.Json
Public Class Dash
    Inherits System.Web.UI.MasterPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Session("Area") = 6 Or Session("Area") = 10 Then
            altaImple.Visible = True

        Else
            altaImple.Visible = False
        End If

    End Sub

    Private Sub LoginStatus1_LoggedOut(sender As Object, e As EventArgs) Handles LoginStatus1.LoggedOut


    End Sub



End Class