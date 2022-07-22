<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@page import="com.enuri.bean.main.Mobile_Main_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.json.*"%>
<%
	String type = StringUtils.defaultString(request.getParameter("type"),"best01");
	
	type = StringUtils.trim(type);
	type = StringUtils.replace(type,"ico ","");
	type = StringUtils.replace(type," on","");
	
	ArrayList cate = new ArrayList();
	
	if("best01".equals(type)){
		//전체		
	}else if("best02".equals(type)){//노트북
		cate.add("0404");
	}else if("best03".equals(type)){//카메라
		cate.add("0232");
	}else if("best04".equals(type)){//휴대폰악세서리
		cate.add("2211");
	}else if("best05".equals(type)){//블루투스 스마트 시계
		cate.add("0318");
	}
		
	Mobile_Main_Proc mobile_Main_Proc = new Mobile_Main_Proc();
	
	JSONObject jSONObject = new JSONObject();
	jSONObject = mobile_Main_Proc.getMobileAllBestToJson(cate,type);
	
	out.println(jSONObject);

	
	
%>