<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.sql.*" %>
<%@ page language="java" import="javax.sql.*" %>
<%@ page language="java" import="javax.naming.*" %>
<%@ page language="java" import="java.net.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>

Your IP Address = <%=request.getRemoteAddr()%><br>
Host IP Address = <%=InetAddress.getLocalHost().getHostAddress()%><br>

file.encoding = <%= System.getProperty("file.encoding") %><br>
file.client.encoding = <%= System.getProperty("file.client.encoding") %><br>
client.encoding.override = <%= System.getProperty("client.encoding.override") %>
<br>
Default.client.encoding = <%= System.getProperty("default.client.encoding") %><br><br>

<%
String jndi = "java:comp/env/jdbc/main2004";

Context context = new InitialContext();
DataSource ds = null;
Connection conn = null;

Context testctx;
DataSource testds = null;

try
{
    testctx = (Context)context.lookup("java:/comp/env/jdbc");
    out.println(testctx);
    testds = (DataSource)testctx.lookup("main2004");
    out.println(testctx);
    ds = (DataSource)context.lookup(jndi);
    out.println("DataSource lookup ..");
    out.println("<br /><br />");
}
catch (NamingException e)
{
    e.printStackTrace();
    out.println(". .. : " + e.getMessage());
    out.println("<br /><br />");
}
finally
{
    if (null != context) {
        try  {
            context.close();
        }  catch (NamingException e)  {
            e.printStackTrace();
        }  finally  {
            context = null;
        }
    }
}

try
{
    conn = ds.getConnection();

    out.println(".... .. : " + conn.getMetaData().getDriverVersion());
    out.println("<br /><br />");

    out.println("getConnection() - DB .. ..");
    out.println("<br /><br />");
}  catch (SQLException e)  {
    e.printStackTrace();
    out.println("getConnection() - DB .. .. : " + e.getMessage());
    out.println("<br /><br />");
}  finally  {
    if (null != conn)  {
        try  {
            conn.close();
        }  catch (Exception e)  {
            e.printStackTrace();
        }
        conn = null;
    }
}





%>

</body>
</html>

