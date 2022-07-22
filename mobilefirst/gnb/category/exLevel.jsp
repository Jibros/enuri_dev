<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.main.Mobile_Category_Proc"%>
<%@ page import="com.enuri.bean.main.Mobile_Category_Data"%>
<jsp:useBean id="Mobile_Category_Data" class="com.enuri.bean.main.Mobile_Category_Data" scope="page" />
<jsp:useBean id="Mobile_Category_Proc" class="com.enuri.bean.main.Mobile_Category_Proc" scope="page" />

<%
	Mobile_Category_Proc mobile_category_proc = new Mobile_Category_Proc();
	Mobile_Category_Data[] mobile_category_data = null;

	String strCate = ChkNull.chkStr(request.getParameter("cate"));
	String strC_name = "";
	
	mobile_category_data = mobile_category_proc.getExCategory(strCate);	

	out.println(" [ ");
	for(int i = 0; i < mobile_category_data.length ; i++){ 
		if(i > 0){  
			out.println(" , "); 
		}
		strC_name = mobile_category_data[i].getC_name().replace("<br>"," ").replace("<Br>"," ").replace("<BR>"," ");
		out.println("{\"m_group_flag\":0,\"g_cate\":\""+mobile_category_data[i].getCa_code()+"\",\"g_name\":\""+strC_name+"\",\"g_parent\":1"+mobile_category_data[i].getCa_code().substring(0,6)+",\"g_seqno\":1"+mobile_category_data[i].getCa_code()+",\"g_level\":4}");
	}
	out.println(" ] ");
%>