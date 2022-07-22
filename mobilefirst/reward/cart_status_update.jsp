<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.mobile.Reward_Data"%>
<%@ page import="com.enuri.bean.mobile.Reward_Proc"%>
<jsp:useBean id="Reward_Data" class="Reward_Data" scope="page" />
<jsp:useBean id="Reward_Proc" class="Reward_Proc" scope="page" />
<%
int intTid = ChkNull.chkInt(request.getParameter("tid"));

String strUserid = cb.GetCookie("MEM_INFO","USER_ID");

Reward_Proc.Update_Cart_Status(intTid, strUserid);
%>
