<%@page import="com.enuri.util.common.ConfigManager"%>
<%@ page contentType="text/html; charset=utf-8" trimDirectiveWhitespaces="true"%>
<%@ page import="org.json.JSONArray"%>
<%@ page import="com.enuri.bean.home.Main_News_Proc"%>
<%@ page import="org.json.JSONObject"%>
<%
	JSONObject mainNewsObj = new JSONObject();
	Main_News_Proc mainNews = new Main_News_Proc();

	//'01','02','03','07'
	
	mainNewsObj = mainNews.getMainNewsList("01");
	
	StringBuilder sb = new StringBuilder(); 
	
	JSONArray arr = mainNewsObj.getJSONArray("todayNewsList");
	
	sb.append("<div class=\"tabs__cont\" style='display:none' id=\"mainNewsCont1\">");
	
		JSONArray jsonTxt = new JSONArray (); 
		
		for(int i=0;i<arr.length();i++){
			
			JSONObject json = arr.getJSONObject(i);
			String mn_sort = json.getString("mn_sort");
			String mn_title = json.getString("mn_title");
			String mn_img = json.getString("mn_img");
			String kb_no = json.getString("kb_no");
			String mn_idx = json.getString("mn_idx");
			if("1".equals(mn_sort)){
				sb.append("<div class='topnews'>");
				sb.append("	<a href='/knowcom/detail.jsp?kbno="+kb_no+"&bbsname=news&cateno=&page=1' onclick='insertLog(24343);insertMainNewsLog("+mn_idx+");' target='_self' class='thum__link'>");
				sb.append("		<span class='thum'><img src='"+ConfigManager.STORAGE_ENURI_COM+ "/pic_upload/main/news/"+mn_img+"' alt=''></span>");
				sb.append("		<span class='tx'>"+mn_title+"</span>");
				sb.append("	</a>");
				sb.append("</div>");	
			}else{
				jsonTxt.put(json);
			}
		}
		
		sb.append("<ul class='news'>");
		for(int i=0;i<jsonTxt.length();i++){
			JSONObject json = jsonTxt.getJSONObject(i);
			String mn_title = json.getString("mn_title");
			String kb_no = json.getString("kb_no");
			String mn_idx = json.getString("mn_idx");
			
			sb.append("	<li class='news-item'>");
			sb.append("		<a href='/knowcom/detail.jsp?kbno="+kb_no+"&bbsname=news&cateno=&page=1'  onclick='insertLog(24344);insertMainNewsLog("+mn_idx+");' target='_blank' title='새 창에서 열립니다' >"+mn_title+"</a>");
			sb.append("	</li>");
		}
		sb.append("</ul>");
	
	sb.append("</div>");
	
	mainNewsObj = mainNews.getMainNewsList("02");
	
	arr = mainNewsObj.getJSONArray("todayNewsList");
	
	sb.append("<div class=\"tabs__cont\"  style='display:none' id=\"mainNewsCont2\">");
	
		jsonTxt = new JSONArray (); 
		
		for(int i=0;i<arr.length();i++){
			
			JSONObject json = arr.getJSONObject(i);
			String mn_sort = json.getString("mn_sort");
			String mn_title = json.getString("mn_title");
			String mn_img = json.getString("mn_img");
			String kb_no = json.getString("kb_no");
			String mn_idx = json.getString("mn_idx");
			
			if("1".equals(mn_sort)){
				sb.append("<div class='topnews'>");
				sb.append("	<a href='/knowcom/detail.jsp?kbno="+kb_no+"&bbsname=news&cateno=&page=1' onclick='insertLog(24343);insertMainNewsLog("+mn_idx+");' target='_self' class='thum__link'>");
				sb.append("		<span class='thum'><img src='"+ConfigManager.STORAGE_ENURI_COM+ "/pic_upload/main/news/"+mn_img+"' alt=''></span>");
				sb.append("		<span class='tx'>"+mn_title+"</span>");
				sb.append("	</a>");
				sb.append("</div>");	
			}else{
				jsonTxt.put(json);
			}
		}
		
		sb.append("<ul class='news'>");
		for(int i=0;i<jsonTxt.length();i++){
			JSONObject json = jsonTxt.getJSONObject(i);
			String mn_title = json.getString("mn_title");
			String kb_no = json.getString("kb_no");
			String mn_idx = json.getString("mn_idx");
			
			sb.append("	<li class='news-item'>");
			sb.append("		<a href='/knowcom/detail.jsp?kbno="+kb_no+"&bbsname=news&cateno=&page=1' onclick='insertLog(24344);insertMainNewsLog("+mn_idx+");'  target='_blank' title='새 창에서 열립니다' >"+mn_title+"</a>");
			sb.append("	</li>");
		}
		sb.append("</ul>");
	
	sb.append("</div>");
	
	
	mainNewsObj = mainNews.getMainNewsList("03");
	
	arr = mainNewsObj.getJSONArray("todayNewsList");
	
	sb.append("<div class=\"tabs__cont\"  style='display:none' id=\"mainNewsCont3\">");
	
		jsonTxt = new JSONArray (); 
		
		for(int i=0;i<arr.length();i++){
			
			JSONObject json = arr.getJSONObject(i);
			String mn_sort = json.getString("mn_sort");
			String mn_title = json.getString("mn_title");
			String mn_img = json.getString("mn_img");
			String kb_no = json.getString("kb_no");
			String mn_idx = json.getString("mn_idx");
			
			if("1".equals(mn_sort)){
				sb.append("<div class='topnews'>");
				sb.append("	<a href='/knowcom/detail.jsp?kbno="+kb_no+"&bbsname=news&cateno=&page=1' onclick='insertLog(24343);insertMainNewsLog("+mn_idx+");'  target='_self' class='thum__link'>");
				sb.append("		<span class='thum'><img src='"+ConfigManager.STORAGE_ENURI_COM+ "/pic_upload/main/news/"+mn_img+"' alt=''></span>");
				sb.append("		<span class='tx'>"+mn_title+"</span>");
				sb.append("	</a>");
				sb.append("</div>");	
			}else{
				jsonTxt.put(json);
			}
		}
		
		sb.append("<ul class='news'>");
		for(int i=0;i<jsonTxt.length();i++){
			JSONObject json = jsonTxt.getJSONObject(i);
			String mn_title = json.getString("mn_title");
			String kb_no = json.getString("kb_no");
			String mn_idx = json.getString("mn_idx");
			
			sb.append("	<li class='news-item'>");
			sb.append("		<a href='/knowcom/detail.jsp?kbno="+kb_no+"&bbsname=news&cateno=&page=1' onclick='insertLog(24344);insertMainNewsLog("+mn_idx+");'  target='_blank' title='새 창에서 열립니다' >"+mn_title+"</a>");
			sb.append("	</li>");
		}
		sb.append("</ul>");
	
	sb.append("</div>");
	
	
	mainNewsObj = mainNews.getMainNewsList("07");
	
	arr = mainNewsObj.getJSONArray("todayNewsList");
	
	sb.append("<div class=\"tabs__cont\"  style='display:none' id=\"mainNewsCont4\">");
	
		jsonTxt = new JSONArray (); 
		
		for(int i=0;i<arr.length();i++){
			
			JSONObject json = arr.getJSONObject(i);
			String mn_sort = json.getString("mn_sort");
			String mn_title = json.getString("mn_title");
			String mn_img = json.getString("mn_img");
			String kb_no = json.getString("kb_no");
			String mn_idx = json.getString("mn_idx");
			
			if("1".equals(mn_sort)){
				sb.append("<div class='topnews'>");
				sb.append("	<a href='/knowcom/detail.jsp?kbno="+kb_no+"&bbsname=news&cateno=&page=1' onclick='insertLog(24343);insertMainNewsLog("+mn_idx+");'  target='_self' class='thum__link'>");
				sb.append("		<span class='thum'><img src='"+ConfigManager.STORAGE_ENURI_COM+ "/pic_upload/main/news/"+mn_img+"' alt=''></span>");
				sb.append("		<span class='tx'>"+mn_title+"</span>");
				sb.append("	</a>");
				sb.append("</div>");	
			}else{
				jsonTxt.put(json);
			}
		}
		
		sb.append("<ul class='news'>");
		for(int i=0;i<jsonTxt.length();i++){
			JSONObject json = jsonTxt.getJSONObject(i);
			String mn_title = json.getString("mn_title");
			String kb_no = json.getString("kb_no");
			String mn_idx = json.getString("mn_idx");
			
			sb.append("	<li class='news-item'>");
			sb.append("		<a href='/knowcom/detail.jsp?kbno="+kb_no+"&bbsname=news&cateno=&page=1' onclick='insertLog(24344);insertMainNewsLog("+mn_idx+");'  target='_blank' title='새 창에서 열립니다' >"+mn_title+"</a>");
			sb.append("	</li>");
		}
		sb.append("</ul>");
	
	sb.append("</div>");
	
	
	//패션/라이프
	mainNewsObj = mainNews.getMainNewsList("05");
	
	arr = mainNewsObj.getJSONArray("todayNewsList");
	
	sb.append("<div class=\"tabs__cont\" style='display:none' id=\"mainNewsCont5\">");
	
		jsonTxt = new JSONArray (); 
		
		for(int i=0;i<arr.length();i++){
			
			JSONObject json = arr.getJSONObject(i);
			String mn_sort = json.getString("mn_sort");
			String mn_title = json.getString("mn_title");
			String mn_img = json.getString("mn_img");
			String kb_no = json.getString("kb_no");
			String mn_idx = json.getString("mn_idx");
			
			if("1".equals(mn_sort)){
				sb.append("<div class='topnews'>");
				sb.append("	<a href='/knowcom/detail.jsp?kbno="+kb_no+"&bbsname=news&cateno=&page=1' onclick='insertLog(24343);insertMainNewsLog("+mn_idx+");'  target='_self' class='thum__link'>");
				sb.append("		<span class='thum'><img src='"+ConfigManager.STORAGE_ENURI_COM+ "/pic_upload/main/news/"+mn_img+"' alt=''></span>");
				sb.append("		<span class='tx'>"+mn_title+"</span>");
				sb.append("	</a>");
				sb.append("</div>");	
			}else{
				jsonTxt.put(json);
			}
		}
		
		sb.append("<ul class='news'>");
		for(int i=0;i<jsonTxt.length();i++){
			JSONObject json = jsonTxt.getJSONObject(i);
			String mn_title = json.getString("mn_title");
			String kb_no = json.getString("kb_no");
			
			sb.append("	<li class='news-item'>");
			sb.append("		<a href='/knowcom/detail.jsp?kbno="+kb_no+"&bbsname=news&cateno=&page=1' onclick='insertLog(24344);'  target='_blank' title='새 창에서 열립니다' >"+mn_title+"</a>");
			sb.append("	</li>");
		}
		sb.append("</ul>");
	
	sb.append("</div>");
	
	out.println(sb.toString());
%>