<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.enuri.bean.main.Mobile_Category_Proc"%>
<%@ page import="com.enuri.bean.main.Mobile_Category_Data"%>
<jsp:useBean id="Mobile_Category_Data" class="com.enuri.bean.main.Mobile_Category_Data" scope="page" />
<jsp:useBean id="Mobile_Category_Proc" class="com.enuri.bean.main.Mobile_Category_Proc" scope="page" />
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>
<%
	/*
	분류키워드 패션 코드 넣어올 경우 
	미분류 데이터
	JSON
	*/
	String strCate = StringUtils.defaultString(request.getParameter("cate"),"148292");
	 
	Mobile_Category_Proc mobile_Category_Proc = new Mobile_Category_Proc();
	Mobile_Category_Data[] mobile_Category_List = mobile_Category_Proc.getCategoryInGoods2(strCate);
	
	Mobile_Category_Data mobile_Category_Data = new Mobile_Category_Data();
	
	JSONArray jsonArray = new JSONArray(); 
	
	for(int i = 0; i < mobile_Category_List.length ; i++ ){
			
			String cName = mobile_Category_List[i].getC_name();
			String cACode = mobile_Category_List[i].getCa_code();
			
			JSONObject jO = new JSONObject();
			jO.put("m_group_flag",0); 
			jO.put("g_name",cName);
			jO.put("g_cate",cACode);  
			jO.put("g_parent","1"+StringUtils.left(cACode,cACode.length()-2)); 
			jO.put("SUB_CATE",StringUtils.right(cACode,2));
			 
			jsonArray.put(jO);
	} 
	 
	//JSONObject jOFashionCate = new JSONObject();
	//jOFashionCate.put("fashion_Cate",jsonArray);
	
	//out.println(jOFashionCate.toString());
	out.println(jsonArray);
%>
