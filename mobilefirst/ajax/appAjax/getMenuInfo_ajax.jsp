 <%@page contentType="text/html; charset=UTF-8"%>
  <%@page import="org.json.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	String ver = request.getParameter("ver");
	//System.out.println("start");
	if (ver == null)
		ver = "0.0.0";
	//System.out.println("ver "+ver);
	
	int version = Integer.parseInt(ver.substring(0, 1)) * 100 + Integer.parseInt(ver.substring(2, 3)) * 10 + Integer.parseInt(ver.substring(4, 5));
	
	//System.out.println("version "+version);
	
	
	String andMenuList []={
				 "name","line_gap", "link","", "type","1" ,"web_link","",
				 "name","로그인", "link","LOGIN", "type","0" ,"web_link","javascript:goLogin()",
				 "name","line_gap", "link","", "type","1" ,"web_link","",
				 "name","최근 본 상품(#1)", "link","RESENT", "type","0" ,"web_link","javascript:goResent()",
				 "name","찜 한 상품(#2)", "link","ZZIM", "type","0" ,"web_link","javascript:goZzim()",
				 "name","line_gap", "link","", "type","1" ,"web_link","",
				 "name","소셜모아", "link", (version==0?"http://m.enuri.com/deal/mobile/main.deal":"http://m.enuri.com/deal/mobile/main.deal"), "type","0" ,"web_link","http://m.deal.enuri.com",
				 "name","백화점 가격비교", "link","http://m.enuri.com/mobiledepart/Index.jsp", "type","0" ,"web_link","http://m.enuri.com/mobiledepart/Index.jsp",
				 "name","line_gap", "link","", "type","1" ,"web_link","",
				 "name","APP 다운로드", "link","http://m.enuri.com", "type","1" ,"web_link","",
				 "name","스마트택배", "link","http://enuri.sweettracker.net/parcel/lists/", "type","0" ,"web_link","http://enuri.sweettracker.net/parcel/lists/",
				 "name","line_gap", "link","", "type","1" ,"web_link","",
				 "name","전체 카테고리 펼쳐보기", "link","http://m.enuri.com/mobilenew/layerMenu_ajax.jsp?type=1&app=Y", "type","0" ,"web_link","http://m.enuri.com/mobilenew/layerMenu_ajax.jsp?type=1",
				 "name","line_gap", "link","", "type","1" ,"web_link","",
				 "name","설정", "link","SETUP", "type","2" ,"web_link",""};
	
	String iosMenuList[] = { "name","line_gap", "link","", "type","1" ,"web_link","",
	        		 "name","로그인", "link","LOGIN", "type","0" ,"web_link","javascript:goLogin()",
	        		 "name","line_gap", "link","", "type","1" ,"web_link","",
	        		 "name","최근 본 상품(#1)", "link","RESENT", "type","0" ,"web_link","javascript:goResent()",
	        		 "name","찜 한 상품(#2)", "link","ZZIM", "type","0" ,"web_link","javascript:goZzim()",
	        		 "name","line_gap", "link","", "type","1" ,"web_link","",
	        		 "name","소셜모아", "link", "http://m.deal.enuri.com", "type","0" ,"web_link","http://m.deal.enuri.com",
	        		 "name","백화점 가격비교", "link","http://m.enuri.com/mobiledepart/Index.jsp", "type","0" ,"web_link","http://m.enuri.com/mobiledepart/Index.jsp",
	        		 "name","line_gap", "link","", "type","1" ,"web_link","",
	        		 "name","APP 다운로드", "link","http://m.enuri.com", "type","1" ,"web_link","",
	        		 "name","스마트택배", "link","http://enuri.sweettracker.net/parcel/lists/", "type","0" ,"web_link","http://enuri.sweettracker.net/parcel/lists/",
	        		 "name","line_gap", "link","", "type","1" ,"web_link","",
	        		 "name","전체 카테고리 펼쳐보기", "link","http://m.enuri.com/mobilenew/layerMenu_ajax.jsp?type=1&app=Y", "type","0" ,"web_link","http://m.enuri.com/mobilenew/layerMenu_ajax.jsp?type=1",
	        		 "name","line_gap", "link","", "type","1" ,"web_link","",
	        		 "name","설정", "link","SETUP", "type","2" ,"web_link",""};
	        	
	        			
	        			
	JSONObject jsonObject = new JSONObject();
	
	
	
	JSONArray jAndArr = new JSONArray();
	JSONArray jIosArr = new JSONArray();

	for (int i = 0; i < andMenuList.length; i += 8) {
		JSONObject temp1 = new JSONObject();
		//System.out.println(andMenuList[i]+" "+andMenuList[i+1]);
		temp1.put(andMenuList[i], andMenuList[i + 1]);
		temp1.put(andMenuList[i + 2], andMenuList[i + 3]);
		temp1.put(andMenuList[i + 4], andMenuList[i + 5]);
		temp1.put(andMenuList[i + 6], andMenuList[i + 7]);
		jAndArr.put(temp1);

	}
	
	for (int i = 0; i < iosMenuList.length; i += 8) {
		JSONObject temp1 = new JSONObject();
		//System.out.println(iosMenuList[i]+" "+iosMenuList[i+1]);
		temp1.put(iosMenuList[i], iosMenuList[i + 1]);
		temp1.put(iosMenuList[i + 2], iosMenuList[i + 3]);
		temp1.put(iosMenuList[i + 4], iosMenuList[i + 5]);
		temp1.put(iosMenuList[i + 6], iosMenuList[i + 7]);
		jIosArr.put(temp1);

	}
	
	

	jsonObject.put("andMenuList", jAndArr);
	jsonObject.put("iosMenuList", jIosArr);
	
	 out.print(jsonObject);
	 out.flush();
	
%>
