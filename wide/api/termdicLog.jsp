<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="com.enuri.bean.knowbox.Know_termdic_title_Proc"%>
<%@ page import="com.enuri.bean.knowbox.Know_termdic_title_Data"%>
<%@ page import="com.enuri.bean.knowbox.Know_box_Proc"%>
<jsp:useBean id="Know_termdic_title_Proc" class="com.enuri.bean.knowbox.Know_termdic_title_Proc" scope="page" />
<jsp:useBean id="Know_termdic_title_Data" class="com.enuri.bean.knowbox.Know_termdic_title_Data" scope="page" />
<jsp:useBean id="Know_box_Proc" scope="page" class="com.enuri.bean.knowbox.Know_box_Proc"/>
<%@ include file="/include/Base_Inc.jsp"%>
<%
String vmode = ChkNull.chkStr(request.getParameter("vmode"), "read");
String kb_no = ChkNull.chkStr(request.getParameter("kbnos"),"");
String vtype = ChkNull.chkStr(request.getParameter("vtype"));
String nowUserIp = request.getRemoteAddr()+"XXXXXXXXXXX";
String strUserid = cb.GetCookie("MEM_INFO","USER_ID");
//사내에서 호출은 로그 안남김
if(!nowUserIp.substring(0, 10).equals("58.234.199")) {
	String[] kbnos = kb_no.split(",");
	if (kb_no.length() >0 ){
		for(int i=0; i<kbnos.length; i++){
			if (vmode.equals("read")){
				Know_termdic_title_Proc.insert_ReadLog(Integer.parseInt(kbnos[i]), cb.GetCookie("MEM_INFO","USER_ID"), request.getRemoteAddr(), vtype);
			}else if (vmode.equals("link")){
				//Know_termdic_title_Proc.updateLinkLog(kb_no);
				Know_termdic_title_Proc.insert_LinkLog(Integer.parseInt(kbnos[i]), cb.GetCookie("MEM_INFO","USER_ID"), request.getRemoteAddr(), vtype);
			}
			Know_box_Proc.updateReadCnt(intKbno, strUserid);
		}
	}
}
%>