<%@page import="org.json.simple.JSONObject"%>
<%@page import="sun.java2d.pipe.SpanShapeRenderer.Simple"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
				pageEncoding="UTF-8"%>
<%@ page import="com.enuri.util.common.*"%>
<%@page import="java.util.Random"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="com.enuri.bean.main.Component_Proc"%>
<%@ page import="java.io.*"%>
<%@ page import="java.lang.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@page import="java.net.*"%>
<%@page import="org.json.JSONArray"%>
<%-- <%@page import="org.json.JSONObject"%> --%>
<%@page import="org.json.simple.JSONObject"%>
<%//플러스 링크 ip 검사 해서 따로 생성 필요
			try{
				//org.json.JSONException: Unterminated string at character 38746
				String str = getfromHttp(true, "http://dev.enuri.com/lsv2016/ajax/getSearchGoods_ajax.jsp?IsMobileApp=Y&in_keyword=&m_price=&start_price=&end_price=&brand_arr=&factory_arr=&keyword=%EC%9D%B8%EC%82%AC+K&brand=&factory=&spec=&deviceType=2&mobileAppAdult=Y&pageNum=1&pageGap=40&tabType=0&cate=&key=&IsDeliverySumPrice=");
			
				JSONObject obj = new JSONObject();
				obj.put("aaa", str);
				//obj.put("org_goodsnm","[로켓배송은 오늘 주문 내일 도착 / 로켓와우 고객 최대 3% 캐시 적립 / 로켓와우 30일 무료 체험 중]1358K 꽃들의 인사 화이트흑백 디자인액자");
				out.print(obj.toString());
			}catch(Exception e)
{
				out.print(e.toString());
}
			%>



<%!public String getfromHttp(boolean isJSONObject, String strurl) {
		String temp = null;
		try {
			String recv;
			StringBuffer recvbuff = new StringBuffer();
			URL jsonpage = new URL(strurl);
			URLConnection urlcon = jsonpage.openConnection();
			urlcon.setConnectTimeout(10000);
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

			temp = new String(arBytes, "UTF-8").trim();

		} catch (Exception e) { //return "{\"error\":\""+e.toString()+"\"}";
		}
		if (temp == null || temp.length() <= 0) {
			if (isJSONObject)
				return "{}";
			else
				return "[]";
		} else {
			if (isJSONObject) {
				if (temp.startsWith("{"))
					return temp;
				else
					return "{}";
			} else

				return temp;
		}

	}

	public String getfromFile(boolean isJSONObject, String filePath) {

		InputStream inputStream = null;

		String temp = null;
		try {
			inputStream = new FileInputStream(filePath);

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
			temp = new String(arBytes, "UTF-8").trim();
		} catch (Exception e) {

		}

		if (temp == null || temp.length() <= 0) {
			if (isJSONObject)
				return "{}";
			else
				return "[]";
		} else {
			if (isJSONObject) {
				if (temp.startsWith("{"))
					return temp;
				else
					return "{}";
			} else

				return temp;
		}
	}

	public String removenewline(String desc) {
		char buf[] = desc.toCharArray();
		char buf2[] = new char[buf.length];
		int cnt = 0;
		for (int i = 0; i < buf.length; i++) {

			if (buf[i] != '\"') {
				if (!((int) buf[i] == 10 || (int) buf[i] == 13))
					buf2[cnt++] = buf[i];

				else
					buf2[cnt++] = (char) 32;
			}
		}

		return new String(buf2).trim();
	}%>