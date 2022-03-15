<%@page import="com.enuri.bean.lsv2016.Category_Set_Proc"%>
<%@page import="com.enuri.bean.lsv2016.Category_Set_Data"%>
<%@page import="com.enuri.bean.lsv2016.Goods_Spec_Compare"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="javax.servlet.http.Cookie"%>
<%@ page contentType="text/html; charset=utf-8" %>
<%@page import="org.json.*"%>
<%@ page import="java.util.*"%>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@ include file="/include/IncGroupTool_2010.jsp"%>
<%@ page import="com.enuri.bean.main.Main_SuggestGoods_Proc"%>
<%
	Goods_Spec_Compare gsc = new Goods_Spec_Compare ();

	Main_SuggestGoods_Proc msp = new Main_SuggestGoods_Proc(); 

	String strCate = ChkNull.chkStr(request.getParameter("cate"),"A");
	String modelno = ChkNull.chkStr(request.getParameter("modelno"));
    
	String adult= ChkNull.chkStr(cb.GetCookie("MEM_INFO","ADULT"));
	
    JSONObject resultJson = new JSONObject (); 
    
   	resultJson = msp.getGoodsFromSelectCate(strCate,adult,modelno);
	out.println(resultJson.toString());
%>	    