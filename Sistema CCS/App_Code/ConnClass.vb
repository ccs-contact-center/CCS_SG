Imports System
Imports System.Collections.Generic
Imports System.Linq
Imports System.Web
Imports System.Data
Imports System.Data.SqlClient
Imports System.Configuration

Namespace SignalRChat

    Public Class ConnClass

        Public cmd As SqlCommand = New SqlCommand()

        Public sda As SqlDataAdapter

        Public sdr As SqlDataReader

        Public ds As DataSet = New DataSet()

        Public con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("db").ToString())






        <Obsolete("Please refactor code that uses this function, it is a simple work-around to simulate inline assignment in VB!")>
        Private Shared Function __InlineAssignHelper(Of T)(ByRef target As T, value As T) As T
            target = value
            Return value
        End Function
    End Class
End Namespace
