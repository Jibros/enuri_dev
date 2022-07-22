<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.io.*"%>
<%@ page import="org.json.JSONArray"%>
<%@ page import="org.json.JSONObject"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.net.*"%>


<!DOCTYPE HTML>
<html>
<%
	String id = request.getParameter("worker");
	if (!id.equals("supersons") && !id.equals("mho")
			&& !id.equals("koara") && !id.equals("kyr6192143")
			&& !id.equals("hello") && !id.equals("baegopha1230")
			&& !id.equals("jtj134") && !id.equals("kkimabs")) {

		response.sendRedirect("http://m.enuri.com");
	}
%>
<script type="text/javascript"
	src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>

<head>
<meta charset="UTF-8">
<title>앱전용 광고 관리자</title>
<style>
table, th, td {
	border: 1px solid black;
	border-collapse: collapse;
	padding: 5px
}

input[type="text"] {
	width: 100%;
	box-sizing: border-box;
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
}

input[type="button"] {
	width: 100%;
	box-sizing: border-box;
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
}
</style>
</head>

<body>
	<%
		String strJson = null;
		String BUF_TAB_LINK_AOS = null, BUF_TAB_COLOR_AOS = null, BUF_TAB_IMAGE_IOS = null, BUF_TAB_COLOR_IOS = null, BUF_TAB_LINK_IOS = null, BUF_TAB_IMAGE_AOS = null;

		String EVENT_BTN_LINK_URL_IOS = null, EVENT_BTN_LINK_URL_AOS = null, EVENT_BTN_YN = null, EVENT_BTN_IMAGE_URL = null;

		try {

			String news_data = "";
		
			String recv;
			StringBuffer recvbuff = new StringBuffer();
			
			URL jsonpage = new URL("http://dev.enuri.com/mobilefirst/ajax/appAjax/getDefine_new_Extra_ajax.jsp");
			
			URLConnection urlcon = jsonpage.openConnection();
			
			BufferedReader buffread = new BufferedReader(
					new InputStreamReader(urlcon.getInputStream(), "utf-8"));
			while ((recv = buffread.readLine()) != null)
				recvbuff.append(recv);
			buffread.close();


			
			
			JSONObject jsonObject = new JSONObject(recvbuff.toString());

			JSONObject objBufTab = (JSONObject) jsonObject.get("BUF_TAB");
			BUF_TAB_IMAGE_AOS = (String) objBufTab.get("BUF_TAB_IMAGE_AOS");
			BUF_TAB_LINK_AOS = (String) objBufTab.get("BUF_TAB_LINK_AOS");
			BUF_TAB_COLOR_AOS = (String) objBufTab.get("BUF_TAB_COLOR_AOS");

			BUF_TAB_IMAGE_IOS = (String) objBufTab.get("BUF_TAB_IMAGE_IOS");
			BUF_TAB_LINK_IOS = (String) objBufTab.get("BUF_TAB_LINK_IOS");
			BUF_TAB_COLOR_IOS = (String) objBufTab.get("BUF_TAB_COLOR_IOS");

			JSONObject objEventBtn = (JSONObject) jsonObject
					.get("EVENT_BTN");
			EVENT_BTN_LINK_URL_IOS = (String) objEventBtn
					.get("EVENT_BTN_LINK_URL_IOS");
			EVENT_BTN_LINK_URL_AOS = (String) objEventBtn
					.get("EVENT_BTN_LINK_URL_AOS");
			EVENT_BTN_YN = (String) objEventBtn.get("EVENT_BTN_YN");
			EVENT_BTN_IMAGE_URL = (String) objEventBtn
					.get("EVENT_BTN_IMAGE_URL");

		} catch (Exception e) {
			e.printStackTrace();
			out.println(" " + e.toString());
		}
	%>


	<h1>앱전용 광고 관리자</h1>
	적용될 서버 설정
	<select id="server">
		<option value="dev">dev</option>
		<option value="real">real</option>
	</select>


	<h2>버퍼탭</h2>
	<div id="buffertab">
		<form name="buffertabForm" id="buffertabForm"
			action="extraDefineMakeUpdate.jsp" method="post"
			onSubmit="return Cmd_Submit1(this);">
			<input type="hidden" name="server" id="serverformBufferTab" /> <input
				type="hidden" name="type" id="buffertabid" />
			<table>
				<tr>
					<td></td>
					<td>AOS</td>
					<td>IOS</td>
				</tr>
				<tr>
					<td>버퍼탭 이미지</td>
					<td><input type="text" name="aos_buftab_img"
						value=<%=BUF_TAB_IMAGE_AOS%> />
						VALUE>>/images/mobilefirst/extra_tab/buftab/extratab_bg_YYYYMMDD</br>
						FILE>>extratab_bg_YYYYMMDD_aos.jpg(720x970)</br></td>
					<td><input type="text" name="ios_buftab_img"
						value=<%=BUF_TAB_IMAGE_IOS%> />
						VALUE>>/images/mobilefirst/extra_tab/buftab/extratab_bg_YYYYMMDD
						FILE>>extratab_bg_YYYYMMDD_ios.jpg(720x970)</br></td>
				</tr>
				<tr>
					<td>버퍼탭 링크</td>
					<td><input type="text" name="aos_buftab_link"
						value=<%=BUF_TAB_LINK_AOS%> /></td>
					<td><input type="text" name="ios_buftab_link"
						value=<%=BUF_TAB_LINK_IOS%> /></td>
				</tr>
				<tr>
					<td>버퍼탭 배경색</td>
					<td><input type="text" name="aos_buftab_bgcolor"
						value=<%=BUF_TAB_COLOR_AOS%> /></td>
					<td><input type="text" name="ios_buftab_bgcolor"
						value=<%=BUF_TAB_COLOR_IOS%> /></td>
				</tr>
				<tr>
					<td colspan="3"><input type="button"
						onclick="insertExtraDefineBufferTab()" name="" value="저장" /></td>
				</tr>
			</table>
		</form>

	</div>


	<h2>이벤트 버튼</h2>
	<div id="eventBtn">
		<form name="eventBtnForm" id="eventBtnForm"
			action="extraDefineMakeUpdate.jsp" method="post"
			onSubmit="return Cmd_Submit1(this);">
			<input type="hidden" name="server" id="serverformEventBtn" /> <input
				type="hidden" name="type" id="eventbtnid" />
			<table>
				<tr>
					<td></td>
					<td>AOS</td>
					<td>IOS</td>
				</tr>
				<tr>
					<td>이벤트 이미지</td>
					<td colspan="2"><input type="text" name="btn_image_url"
						value=<%=EVENT_BTN_IMAGE_URL%> />
						VALUE>>/images/mobilefirst/floating_event/event_floating0415</br>
						FILE>>event_floating_YYYYMMDD_aos_xhdpi.png(90x90)</br>
						FILE>>event_floating_YYYYMMDD_aos_xxhdpi.png(136x136)</br>
						FILE>>event_floating_YYYYMMDD_ios6.png(94x94)</br>
						FILE>>event_floating_YYYYMMDD_ios6p.png(156x156)</br></td>

				</tr>
				<tr>
					<td>이벤트 링크</td>
					<td><input type="text" name="aos_btn_link"
						value=<%=EVENT_BTN_LINK_URL_AOS%> /></td>
					<td><input type="text" name="ios_btn_link"
						value=<%=EVENT_BTN_LINK_URL_IOS%> /></td>
				</tr>
				<tr>
					<td>이벤트 사용 여부</td>
					<td colspan="2">
						<%
							if (EVENT_BTN_YN != null && EVENT_BTN_YN.equals("Y")) {
						%> <input type="checkbox" name="btn_check" checked /> 이벤트 버튼
						사용시체크 <%
 	} else {
 %> <input type="checkbox" name="btn_check" /> 이벤트 버튼 사용시 체크 <%
 	}
 %>
					</td>

				</tr>

				<tr>
					<td colspan="3"><input type="button"
						onclick="insertExtraDefineEventBtn()" name="" value="저장" /></td>
				</tr>
			</table>
		</form>

	</div>

</body>
</html>
<script>
	(function() {
		$('select option[value="dev"]').attr("selected", true);
	})();
	function insertExtraDefineBufferTab() {
		if (checkDatas()) {
			$('#buffertabid').val("buffertab");
			$("#serverformBufferTab").val($("#server").val());
			$("#buffertabForm").submit();
		} else {
			alert("데이터가 맞지 않습니다.");
		}
	}
	function insertExtraDefineEventBtn() {
		if (checkDatas()) {
			$('#eventbtnid').val("eventbtn");
			$("#serverformEventBtn").val($("#server").val());
			$("#eventBtnForm").submit();
		} else {
			alert("데이터가 맞지 않습니다.");
		}
	}

	function checkDatas() {
		var aosbuftabimg = $("input[name=aos_buftab_img]").val()
		var iosbuftabimg = $("input[name=ios_buftab_img]").val();

		if (aosbuftabimg == null)
			return false;
		if (iosbuftabimg == null)
			return false;

		var aoscolor = $("input[name=aos_buftab_bgcolor]").val();
		var ioscolor = $("input[name=ios_buftab_bgcolor]").val();

		if (aoscolor == null || aoscolor.length != 6)
			return false;
		if (ioscolor == null || ioscolor.length != 6)
			return false;

		if ($("input[name=btn_image_url]").val() == null)
			return false;
		if ($("input[name=aos_btn_link]").val() == null)
			return false;
		if ($("input[name=ios_btn_link]").val() == null)
			return false;

		return true;
	}
	function Cmd_Submit1() {

		return true;
	}
</script>