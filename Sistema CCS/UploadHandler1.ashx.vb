Imports System.Web
Imports System.Web.Services
Imports System.Web.Script.Services
Imports System.IO
Imports System.IO.Directory

Public Class UploadHandler1
    Implements System.Web.IHttpHandler

    Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest

        'Directory.CreateDirectory("C:/fakepath")

        Dim path As String = context.Request("path")
        'MsgBox(path)
        Dim fn As FileInfo = New FileInfo(path)

        'MsgBox(context.Server.MapPath("~/Archivos/" & fn.Name))
        fn.CopyTo(context.Server.MapPath("~/Archivos/" + fn.Name))
        context.Response.Write(fn.Name & ":" & fn.Length & ":" + fn.Extension)

    End Sub

    ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class