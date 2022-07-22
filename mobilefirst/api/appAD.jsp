
<%@page import="com.enuri.bean.main.Component_Proc"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page pageEncoding="utf-8"%>
<%@ page import="com.enuri.util.common.*"%>
<%@ page import="com.enuri.bean.lsv2016.Goods_Search_Lsv_Proc"%>
<%@ page import="com.enuri.bean.lsv2016.Goods_Search_Lsv_Data"%>
<%@ page import="com.enuri.bean.main.Component_Proc"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>

<%@ page import="java.io.*"%>
<%@ page import="java.lang.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@page import="java.net.*"%>
<%
	String cate = ConfigManager.RequestStr(request, "cate", "0404");
	String strversion = ConfigManager.RequestStr(request, "version", "0.0.0");
	String os = ConfigManager.RequestStr(request, "os", "aos");
	String enuri = request.getServerName();
	
	int version = 0;
	if (strversion.length() >= 5) {
		try {
	version = Integer.parseInt(strversion.substring(0, 1)) * 100 + Integer.parseInt(strversion.substring(2, 3)) * 10 + Integer.parseInt(strversion.substring(4, 5));
		} catch (Exception e) {
		}
	}

	
	//0304 a타입 휴대폰
	//0609 b타입 김치냉장고
	
	JSONObject obj = new JSONObject();
	

	
		obj.put("infoad", new JSONObject(getfromHttp(true, "http://localhost/lsv2016/ajax/getInfoAd_showList2_ajax.jsp?deviceType=2&division=1&cate=" + cate)));
	
	if (version >= 343) //type=A or B로 타입에 맞게 값 받을 수 있음
	
			obj.put("sponsorad",
					new JSONObject(getfromHttp(true, "http://localhost/lsv2016/ajax/getInfoAd_showList2_ajax.jsp?deviceType=2&division=2&type=A&cate=" + cate)));
	
	out.println(obj.toString());
%>




<%!public String getfromHttp(boolean isJSONObject, String strurl) {
		try {
			String recv;
			StringBuffer recvbuff = new StringBuffer();
			URL jsonpage = new URL(strurl);
			URLConnection urlcon = jsonpage.openConnection();
			//urlcon.setConnectTimeout(10000);
			InputStream inputStream = urlcon.getInputStream();

			ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
			byte[] arBytes = null;
			byte[] readByte = new byte[1024];
			int readLen;
			while ((readLen = inputStream.read(readByte)) != -1) {
				outputStream.write(readByte, 0, readLen);
			}
			arBytes = outputStream.toByteArray();
			outputStream.close();
			inputStream.close();

			String str = new String(arBytes, "UTF-8").trim();
			if(str.contains("{"))
				return str;
			else 
			{
				if (isJSONObject)
					return "{}";
				else
					return "[]";
			}
			
		} catch (Exception e) {

		}
		if (isJSONObject)
			return "{}";
		else
			return "[]";
	}

	
	%>



