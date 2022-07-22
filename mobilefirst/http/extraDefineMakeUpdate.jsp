<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

<%@ page import="java.util.regex.Matcher"%>
<%@ page import="java.util.regex.Pattern"%>

<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.parser.JSONParser"%>
<%@ page import="org.json.simple.parser.ParseException"%>
<%@ page import="com.enuri.util.common.CommonFtp"%>

<%@ include file="/include/Base_Inc.jsp"%>
<%@page import="com.enuri.bean.mobile.Mobile_Gnb_Proc"%>
<jsp:useBean id="GNB_mobile_List_Proc"
	class="com.enuri.bean.mobile.GNB_mobile_List_Proc" scope="page" />
<%
	String server = ChkNull.chkStr(request.getParameter("server"));
	String type = ChkNull.chkStr(request.getParameter("type"));

	String aos_buftab_img = null, ios_buftab_img = null, aos_buftab_link = null, ios_buftab_link = null, aos_buftab_bgcolor = null, ios_buftab_bgcolor = null;
	String btn_image_url = null, aos_btn_link = null, ios_btn_link = null, btn_check = null;
	//("extra >> "+type);
	if (type.equals("buffertab")) {
		aos_buftab_img = ChkNull.chkStr(request.getParameter("aos_buftab_img"));
		ios_buftab_img = ChkNull.chkStr(request.getParameter("ios_buftab_img"));
		aos_buftab_link = ChkNull.chkStr(request.getParameter("aos_buftab_link"));
		ios_buftab_link = ChkNull.chkStr(request.getParameter("ios_buftab_link"));
		aos_buftab_bgcolor = ChkNull.chkStr(request.getParameter("aos_buftab_bgcolor"));
		ios_buftab_bgcolor = ChkNull.chkStr(request.getParameter("ios_buftab_bgcolor"));
	} else if (type.equals("eventbtn")) {
		btn_image_url = ChkNull.chkStr(request.getParameter("btn_image_url"));
		aos_btn_link = ChkNull.chkStr(request.getParameter("aos_btn_link"));
		ios_btn_link = ChkNull.chkStr(request.getParameter("ios_btn_link"));
		btn_check = ChkNull.chkStr(request.getParameter("btn_check"));
	}
	//("extra1 >> "+type);
	String strJsonObject = null;

	Mobile_Gnb_Proc mobile_Gnb_Proc = new Mobile_Gnb_Proc();
	try {
		String dir = "/was/lena/1.3/depot/lena-application/ROOT/mobilefirst/ajax/appAjax/";
		//String dir = "C:/resin-pro-3.1.13/webapps/ROOT/mobilefirst/ajax/appAjax/";
		String filename = "getDefine_new_Extra_ajax.jsp";
		String news_data = "";
		StringBuffer news_buffer = new StringBuffer();
		InputStream inputStream = new FileInputStream(dir + filename);
		BufferedReader in = new BufferedReader(new InputStreamReader(inputStream, "utf-8"));
		while ((news_data = in.readLine()) != null) {
			news_buffer.append(news_data);
		}
		in.close();
		inputStream.close();
		String datas = news_buffer.toString();

		
		if (type.equals("buffertab")) {
			datas = changeData(datas, "BUF_TAB_COLOR_IOS", ios_buftab_bgcolor);
			datas = changeData(datas, "BUF_TAB_COLOR_AOS", aos_buftab_bgcolor);
			datas = changeData(datas, "BUF_TAB_IMAGE_IOS", ios_buftab_img);
			datas = changeData(datas, "BUF_TAB_IMAGE_AOS", aos_buftab_img);
			datas = changeData(datas, "BUF_TAB_LINK_IOS", ios_buftab_link);
			datas = changeData(datas, "BUF_TAB_LINK_AOS", aos_buftab_link);
		} else if (type.equals("eventbtn")) {
			datas = changeData(datas, "EVENT_BTN_YN", btn_check.equals("on") ? "Y" : "N");
			//("extra27 >> "+type);
			datas = changeData(datas, "EVENT_BTN_LINK_URL_AOS", aos_btn_link);
			//("extra28 >> "+type);
			datas = changeData(datas, "EVENT_BTN_LINK_URL_IOS", ios_btn_link);
			//("extra29 >> "+type);
			datas = changeData(datas, "EVENT_BTN_IMAGE_URL", btn_image_url);
			//("extra3 >> "+type);
		}
		 
		out.println(datas);

		//out.print(news_buffer.toString());
		/*
		JSONParser parser = new JSONParser();
		Object obj = parser.parse(str.substring(idx));

		JSONObject readObj = (JSONObject) obj;

		JSONObject wJson = new JSONObject();
		if (type.equals("buffertab")) {
			JSONObject buftab = new JSONObject();
			{
				buftab.put("BUF_TAB_COLOR_IOS", ios_buftab_bgcolor);
				buftab.put("BUF_TAB_COLOR_AOS", aos_buftab_bgcolor);
				buftab.put("BUF_TAB_IMAGE_IOS", ios_buftab_img);
				buftab.put("BUF_TAB_IMAGE_AOS", aos_buftab_img);
				buftab.put("BUF_TAB_LINK_IOS", ios_buftab_link);
				buftab.put("BUF_TAB_LINK_AOS", aos_buftab_link);
			}
			wJson.put("BUF_TAB", buftab);
		} else
			wJson.put("BUF_TAB", readObj.get("BUF_TAB"));

		if (type.equals("eventbtn")) {
			JSONObject btnVip = new JSONObject();
			{
				btnVip.put("EVENT_BTN_YN", btn_check.equals("on") ? "Y" : "N");
				btnVip.put("EVENT_BTN_LINK_URL_AOS", aos_btn_link);
				btnVip.put("EVENT_BTN_LINK_URL_IOS", ios_btn_link);
				btnVip.put("EVENT_BTN_IMAGE_URL", btn_image_url);
			}
			wJson.put("EVENT_BTN", btnVip);
		} else
			wJson.put("EVENT_BTN", readObj.get("EVENT_BTN"));

		if(readObj.containsKey("HOTDEAL"))
			wJson.put("HOTDEAL", readObj.get("HOTDEAL"));
		if(readObj.containsKey("DYNAMIC_TAB"))
			wJson.put("DYNAMIC_TAB", readObj.get("DYNAMIC_TAB"));
		
		if(readObj.containsKey("TABS"))
			wJson.put("TABS", readObj.get("TABS"));
		 */

		//strJsonObject = wJson.toString();

		//있는 파일 지우기 
		File del = new File(dir + filename);
		if (del.exists())
			del.delete();

		OutputStream outputStream = new FileOutputStream(dir + filename);
		BufferedWriter bout = new BufferedWriter(new OutputStreamWriter(outputStream, "utf-8"));
		bout.write(datas);
		bout.close();
		outputStream.close();

		//리얼 서버라면배포가 필요하다 
		if (server.equals("real")) {
			ArrayList ipList = new ArrayList();
			ipList.add("124.243.126.170");
			ipList.add("124.243.126.171");
			ipList.add("124.243.126.172");
			ipList.add("124.243.126.173");
			ipList.add("124.243.126.174");
			ipList.add("124.243.126.175");
			ipList.add("124.243.126.176");
			ipList.add("124.243.126.177");
			ipList.add("124.243.126.178");
			ipList.add("124.243.126.179");

			int port = 21;
			String ftpId = "lena";
			String ftpPw = "#cloud2021";

			for (int i = 0; i < ipList.size(); i++) {
				System.out.println(filename + " " + filename);
				CommonFtp commonFtp = new CommonFtp((String) ipList.get(i), port, ftpId, ftpPw);
				if (commonFtp.login()) {
					commonFtp.cd("/was/lena/1.3/depot/lena-application/ROOT/mobilefirst/ajax/appAjax");
					commonFtp.put(filename, filename, dir);
				}
				commonFtp.disconnect();
			}
		}
		//		out.println(datas);

	} catch (Exception e) {
		out.println("[" + e.toString() + "]");
	}
%>
type :
<%=type%></br>
server :
<%=server%></br>
</br>
</br>
write json
</br>
<%=strJsonObject%></br>
<%!public String changeData(String str, String key, String value) {
		String a = str.substring(str.indexOf(key) + key.length() + 3);
		int endindex = a.indexOf('\"');
		String origin = a.substring(0, endindex);
		return str.replace("\"" + key + "\":\"" + origin + "\"", "\"" + key + "\":\"" + value + "\"");
	}%>


