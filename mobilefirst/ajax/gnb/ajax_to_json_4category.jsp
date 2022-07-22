<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.io.*"%>
<%
	
	String cateCode = StringUtils.defaultString(request.getParameter("cate"));
	String req_g_parent = StringUtils.defaultString(request.getParameter("gseq"));
	
	JSONParser parser = new JSONParser();
	
	try {
		Object obj = parser.parse(new FileReader("webapps/ROOT/mobilefirst/gnb/category/category.json"));
		JSONObject jsonObject = (JSONObject) obj;
		JSONArray jsonArray = (JSONArray) jsonObject.get("4category");
		
		JSONArray jsonOutArray = new JSONArray();
		
		for(int i= 0 ; i < jsonArray.size(); i++){
			JSONObject jsonTemp = (JSONObject)jsonArray.get(i);
			String cate = StringUtils.defaultString((String)jsonTemp.get("G_CATE"));
			String cateName = StringUtils.defaultString((String)jsonTemp.get("G_NAME"));
			String g_parent = StringUtils.defaultString((String)jsonTemp.get("G_PARENT"));
			
			if(req_g_parent.equals(g_parent)){
				jsonOutArray.add(jsonTemp);
			}
			
		}
		
		JSONObject jsonOut = new JSONObject();
		jsonOut.put("4category",jsonOutArray);
		
		out.println(jsonOut);
		
	} catch (FileNotFoundException e) {
		e.printStackTrace();
	} catch (IOException e) {
		e.printStackTrace();
	} 
	
	
	
	
	
%>
