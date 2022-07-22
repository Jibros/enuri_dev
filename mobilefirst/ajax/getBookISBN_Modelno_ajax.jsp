<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.*,java.text.*,java.net.*,java.io.*"%>
<%@ page import="com.enuri.include.*"%>
<%@ page import="com.enuri.util.etc.*"%>
<%@ page import="com.enuri.util.common.*"%>
<%@ page import="com.enuri.util.image.*"%>
<%@ page import="com.enuri.util.http.*"%>
<%@ page import="com.enuri.util.date.*"%>
<%@ page import="com.enuri.dbcon.DBconnection" %>
<%@ page import="java.sql.*"%>
<%@ page import="com.enuri.exception.ExceptionManager"%>
<%
String goodscode = ChkNull.chkStr(request.getParameter("goodscode"));
int modelno = 0;

if(goodscode.length()>15 && goodscode.length()<7) {
	return;
}

Connection Conn = null;
DBconnection dbConn = null;
PreparedStatement  pstmt = null;
ResultSet rs = null;

try {
	dbConn = new DBconnection();

	Conn = dbConn.createDBConnection("main2004");

	String strQuery = "select modelno from tbl_pricelist where shop_code in (6367,6361,5910,374) and goodscode=? and modelno>0 and rownum=1";

	pstmt = Conn.prepareStatement(strQuery);
	pstmt.clearParameters();
	pstmt.setString(1, goodscode);			    

	rs = pstmt.executeQuery();

	if(rs.next()) {
		modelno = rs.getInt("modelno");
	}
	rs.close();   
	pstmt.close();
} catch (SQLException se) {
	System.out.println("BOOK_SQLException: " + se);
	//out.println("test ksh: " + se);
} catch (Exception e) {
	System.out.println("<BR>BOOK_Exception: " + e.toString());
	//out.println("test ksh: " + e.toString());
} finally {
	try {
		dbConn.closeConnection(Conn, pstmt, rs);
	} catch(Exception ex) {
//		System.out.println(ex.getLocalizedMessage());
	}
}
%>
{
	"modelno":"<%=modelno%>"
}