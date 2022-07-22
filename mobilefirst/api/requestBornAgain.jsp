<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.enuri.bean.main.brandplacement.DBDataTable"%>
<%@ page import="com.enuri.util.seed.Seed_Proc"%>
<%@ page import="com.enuri.bean.main.brandplacement.DBWrap"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.mobile.RSAMains"%>
<%@ page import="com.enuri.bean.mobile.CRSA"%>
<%@ page import="com.enuri.bean.mobile.Mobile_Push_Proc"%>
<%@ page import="com.enuri.util.date.DateUtil"%>
<%@ page import="java.text.ParseException"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="com.enuri.util.seed.Seed_Proc"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="com.enuri.bean.member.Sns_Login"%>
<jsp:useBean id="Members_Data"
	class="com.enuri.bean.knowbox.Members_Data" />
<jsp:useBean id="Members_Proc"
	class="com.enuri.bean.knowbox.Members_Proc" />
<jsp:useBean id="Seed_Proc" class="com.enuri.util.seed.Seed_Proc" />
<jsp:useBean id="Mobile_Push_Proc"
	class="com.enuri.bean.mobile.Mobile_Push_Proc" scope="page" />
<%@ page import="com.enuri.bean.mobile.PDManager_Proc"%>
<%@ page import="com.enuri.bean.mobile.PDManager_PD_Data"%>
<%@ page import="com.enuri.bean.mobile.PDManager_T1_Data"%>
<%!public static Date addDays(Date date, int days) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.DATE, days); //minus number would decrement the days
		return cal.getTime();
	}

	public static Date addMins(Date date, int mins) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.MINUTE, mins);
		return cal.getTime();
	}%>
<%
/**
fTEST_minute fTEST_minute fTEST_minute fTEST_minute fTEST_minute fTEST_minute
fTEST_minute fTEST_minute fTEST_minute fTEST_minute fTEST_minute fTEST_minute
fTEST_minute fTEST_minute fTEST_minute fTEST_minute fTEST_minute fTEST_minute
*/

	boolean fTEST_minute = false;

/**
fTEST_minute fTEST_minute fTEST_minute fTEST_minute fTEST_minute fTEST_minute
fTEST_minute fTEST_minute fTEST_minute fTEST_minute fTEST_minute fTEST_minute
fTEST_minute fTEST_minute fTEST_minute fTEST_minute fTEST_minute fTEST_minute
*/

	//20171113 손진욱 t1 pd 모듈
	PDManager_Proc pdmanager = new PDManager_Proc();
	PDManager_T1_Data t1Data = pdmanager.getT1(request);
	PDManager_PD_Data pdData = pdmanager.chkT1PD(request, t1Data);
	boolean blCheck_t1 = false;
	boolean blCheck_pd = false;
	boolean blCheck_logout = false;

	String strT1_fdate = "";
	String strT1_enuriid = "";
	String strT1_userdata = "";

	String sApp_type = "";
	String sTime = "";
	String sUuid = "";
	String sEnuri_id = "";
	String sNickname = "";

	String strFdate = "";

	String strR_id = "";
	String strT1_Rsa = "";
	String strR_code = "";
	String strR_msg = "";
	String strSnsDcd = "";
	long lng_today = 0;
	long lng_lastdate = 0;

	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
	Date dayToday = new Date();
	if (t1Data != null && t1Data.isData()) {

		strT1_fdate = t1Data.getStrT1_fdate();
		strT1_enuriid = t1Data.getStrT1_enuriid();
		strT1_userdata = t1Data.getStrT1_userdata();
		blCheck_t1 = true;
	}

	if (pdData != null && pdData.isData()) {
		sApp_type = pdData.getAppid();
		sUuid = pdData.getUuid();
		sEnuri_id = pdData.getEnuri_id();
		strSnsDcd = pdData.getSnsDcd();
		blCheck_pd = true;
	}

	if (blCheck_t1 && blCheck_pd) {
		//out.println("같음");

		//T1에 있는 strT1_fdate(종료일자) 보다 28일 후면 500 메세지 (강제 로그아웃) sending
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyyMMddHHmmss");
		Date to = transFormat.parse(strT1_fdate);

		String dateToday = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		String strLast_day;
		if (fTEST_minute == false)
			strLast_day = new SimpleDateFormat("yyyyMMddHHmmss").format(addDays(to, 28));
		else
			strLast_day = new SimpleDateFormat("yyyyMMddHHmmss").format(addMins(to, 28));

		//dateToday = "20170523204000";		//test

		//System.out.println("T1 F date>>>>"+strT1_fdate);	//토큰 만료시간
		//System.out.println("Today date>>>"+dateToday);		//오늘 날짜
		//System.out.println("T1 F date+28>>>>"+strLast_day);	//토큰 만료시간 +28일후

		lng_today = Long.parseLong(dateToday);
		lng_lastdate = Long.parseLong(strLast_day);

		if (lng_lastdate >= lng_today) { //만료일+28 한 날짜보다 오늘이 작을 경우만 T1값 생성
			//같을때 t1 재 생성

			cal.setTime(dayToday);
			if (fTEST_minute == false) {
				cal.add(Calendar.DATE, 28);
				cal.add(Calendar.HOUR, 2);
				cal.add(Calendar.MINUTE, 30);
				cal.add(Calendar.SECOND, 11);
			} else {
				//test 28분
				cal.add(Calendar.MINUTE, 28);
			}

			strFdate = sdf.format(cal.getTime());

			//System.out.println("new Final Date >>>>"+strFdate);

			//out.println("sEnuri_id>>>"+sEnuri_id);

			strR_id = Seed_Proc.EnPass_Seed(sEnuri_id);
			//out.println("strR_id>>>"+strR_id);

			//out.println("strT1 >>>>"+strT1);

			//RSA생성
			strT1_Rsa = pdmanager.makeT1(sTime + "||" + strFdate + "||" + sEnuri_id + "||" + sUuid);

			//out.println("strR_t11>>>"+strR_t1+"<br>");

			//out.println("strR_t12>>>"+strR_t1+"<br>");

			//out.println("strT1>>>"+strT1+"<br>");
			//out.println("strR_t1>>>"+strR_t1+"<br>");
			//out.println("strT1_Rsa_decrypt>>>"+rsa.decryptByPrivate_mobile(strT1_Rsa)+"<br>");
		} else {
			blCheck_logout = true;
		}
	}

	/*
	 구분 					code 				message
	 1 	성공 					100 				ok 　
	 2 	data오류 				200 				t1오류
	 3 	request 오류 			300 				pd오류
	 4 	server 오류 			400 				t1과 pd의 user_data가 다름
	 5	만료일초과				500				강제 로그아웃

	 */

	if (blCheck_t1 && blCheck_pd && strT1_Rsa != null && !strT1_Rsa.equals("")) {
		strR_code = "100";
		strR_msg = "ok";
	} else if (blCheck_logout) {
		strR_code = "500";
		strR_msg = "log out";
	} else if (!blCheck_t1) {
		strR_code = "200";
		strR_msg = "t1오류";
	} else if (!blCheck_pd) {
		strR_code = "300";
		strR_msg = "pd오류";
	}
	/* else {
		if (blCheck_t1 && blCheck_pd) {
			if (!strT1_userdata.trim().equals(sUuid.trim())) {
				strR_code = "400";
				strR_msg = "t1과 pd의 user_data가 다름";
			}
		}
	} */
	JSONObject jsonObject = new Sns_Login().getSnsNickName(sEnuri_id);
	if (jsonObject != null && jsonObject.has("getSnsNickName")) {
		JSONArray jsonArray = jsonObject.getJSONArray("getSnsNickName");
		if (jsonArray.length() > 0) {
			sNickname = jsonArray.getJSONObject(0).has("nickname")? jsonArray.getJSONObject(0).getString("nickname"):"";
		}
	}

	out.println("{");
	out.println("	   \"code\": \"" + strR_code + "\", ");
	out.println("	   \"message\": \"" + strR_msg + "\", ");
	out.println("	   \"result_id\": \"" + strR_id + "\", ");
	out.println("	   \"userid\": \"" + sEnuri_id + "\", ");
	out.println("	   \"snslogin\": \"" + strSnsDcd + "\", ");
	out.println("	   \"nickname\": \"" + sNickname + "\", ");
	out.println("	   \"result\": \"" + strT1_Rsa + "\" ");

	out.println("}");
%>