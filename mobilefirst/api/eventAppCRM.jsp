<%@page import="com.enuri.bean.event.Event_FirstbuyCpn_Proc"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.enuri.bean.mobile.CRSA"%>
<%@ page import="java.io.*"%>
<%@ page import="java.lang.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<jsp:useBean id="ChkNull" class="com.enuri.util.common.ChkNull" />
<%@page import="java.net.*"%>
<%@ page import="com.enuri.bean.mobile.Event_Welcome_Proc"%>
<%@ page import="com.enuri.bean.mobile.Mobile_Stamp_Proc"%>
<%@ page import="com.enuri.bean.mobile.Mobile_BirthDay_Proc"%>  
<%@ page import="com.enuri.bean.event.Event_FirstbuyCpn_Proc"%>
<%@ page import="com.enuri.bean.mobile.PDManager_Proc"%>
<%@ page import="com.enuri.bean.mobile.PDManager_PD_Data"%>

<%
	//20171113 손진욱 t1 pd 모듈
	PDManager_Proc pdmanager = new PDManager_Proc();
	PDManager_PD_Data pdData = pdmanager.chkT1PD(request);
	if (pdData != null)
		
	{

		
		//////////////////////////////////////////////////////////////////////////////////////////
		//11월의 예
		/**
		2017-08-01 twomonthago
		2017-11-01 start
		2017-11-30 end
		2017110101 dbid
		 */
		String userID = pdData.getEnuri_id();
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		Calendar three_month_ago_cal = Calendar.getInstance();
		three_month_ago_cal.add(Calendar.MONTH, -3);
		three_month_ago_cal.set(Calendar.DATE, 1);
		String threemonthago = formatter.format(three_month_ago_cal.getTime());

		Calendar start_cal = Calendar.getInstance();
		start_cal.set(Calendar.DATE, 1);
		String start = formatter.format(start_cal.getTime());

		Calendar end_cal = Calendar.getInstance();
		end_cal.add(Calendar.MONTH, 1);
		end_cal.set(Calendar.DATE, 1);
		end_cal.add(Calendar.DATE, -1);
		String end = formatter.format(end_cal.getTime());

		/* SimpleDateFormat formatter_dbid = new SimpleDateFormat("yyyyMM");
		String dbid = formatter_dbid.format(new Date()) + "0101"; */
		//////////////////////////////////////////////////////////////////////////////////////////
		boolean fCRMResult = false;
		String result = null;

	
		
		result = getBanner_10_limited(userID);
		
		if (result == null || result.equals(""))
		{
			
			//스템프 이벤트
			String stamp = getBanner_11_Stamp(userID, "2021-09-03", "2021-09-30", "2021090101");
			//생일자 이벤트 .. 달은 01,09,12 이런식으로 텍스트 들어와야된다 
			//String birth = getBirthDayUser(userID, "01", "2020-01-01", "2020-02-02");
			//http://10.10.10.140:30002/issues/48690
			//c추가 적립이벤트 
			String birth = getBanner_moreRewardEvent(userID, "2021-09-03", "2021-09-30", "2021090110");
	
			
			if(!stamp.equals("")&&!birth.equals("")){
				int r = (int)((Math.random()* 10)%2);
			
				if(r == 0)
					result = stamp;
				else 
					result = birth;
			}else if(!stamp.equals("")) {
				result = stamp;
			}else if(!birth.equals("")) {
				result = birth;
			}
		}
		if (result == null || result.equals(""))
			result = getFirstBuyCoupon(userID);
		if (result == null || result.equals(""))
			result = getNoFirstBuyCouponAndNoBuy(userID);
	 	 

		if (!(result == null || result.equals("")))
			fCRMResult = true;

		//엠크로니 딤팝업 종류
		//http://adsvc.enuri.mcrony.com/enuri_M/m_fp/M6/bundle?bundlenum=12
		out.println("{");
		out.println("   \"event\": \"" + fCRMResult + "\", ");
		//	out.println("   \"stamp\": \"" + start+","+end+","+dbid+","+userID + "\", ");		
		if (result == null || result.equals(""))
			out.println("   \"TXT1\": \"\" ");
		else
			out.println("   \"TXT1\": \"" + result + "\" ");
		out.println("}");
	}
%>

<%!//특수문자 제거 하기
	public static String StringReplace(String str) {
		String match = "[^\uAC00-\uD7A3xfe0-9a-zA-Z\\s]";
		str = str.replaceAll(match, "").trim();
		return str;
	}%>
<%!//http://58.234.199.100/redmine/issues/25429
//스템프 이벤트
	public String getBanner_11_WelcomComeback(String id, String start, String end, String threemonthago) {
		if (isRunning(start, end)) {
			try {
				Event_Welcome_Proc mEvent_Welcome_Proc = new Event_Welcome_Proc();
				if (mEvent_Welcome_Proc.appEventComeBackUser(id, "2016-02-01", threemonthago, threemonthago, start) > 0) {
					return "banner_crm101";
				}
			} catch (Exception e) {

			}
		}
		return "";
	}

//http://58.234.199.100/redmine/issues/35791
//생일자 이벤트 .. 달은 01,09,12 이런식으로 텍스트 들어와야된다 
  	public String getBirthDayUser(String userID,String checmMonthInclude0Length2, String start, String end)
	{
		if (isRunning(start, end)) {
			try{
				Mobile_BirthDay_Proc proc = new Mobile_BirthDay_Proc();
				
				if(proc.isBirthDayUser(userID, checmMonthInclude0Length2))
				{
					return "banner_crm101";
				}
			}catch(Exception e)
			{
				
			}
		}
		return "";
	}  

	//http://58.234.199.100/redmine/issues/28424
	//선쿠폰을 다운 받았으나 앱 구매 이력없는 회원
	public String getFirstBuyCoupon(String id) {
		if (isRunning("2018-01-18", "2018-03-03")) {
			try {
				Event_FirstbuyCpn_Proc prc = new Event_FirstbuyCpn_Proc();
				if (prc.getIsAppCrmBanner(id))
					return "banner_crm113";
			} catch (Exception e) {

			}
		}
		return "";
	}

	//http://58.234.199.100/redmine/issues/32176
	//첫구매적립이 없고 앱 체결 이력이 없는 회원
	public String getNoFirstBuyCouponAndNoBuy(String id) {
		if (isRunning("2019-01-18", "2019-03-03")) {
			try {
				Event_FirstbuyCpn_Proc prc = new Event_FirstbuyCpn_Proc();
				if (prc.getIsNoFirstBuyCouponAndNoBuy(id))
					return "banner_crm113";
			} catch (Exception e) {

			}
		}
		return "";
	}

	//http://58.234.199.100/redmine/issues/30553#change-131106
	//스템프 이벤트
	public String getBanner_11_Stamp(String id, String start, String end, String db_id) {
		if (isRunning(start, end)) {
			try {
				Mobile_Stamp_Proc mMobile_Stamp_Proc = new Mobile_Stamp_Proc();
				if (mMobile_Stamp_Proc.isNotStampAndBuyLog(db_id, id, start + " 00:00:00", end + " 23:59:00"))
					return "banner_crm101";
			} catch (Exception e) {
			}
		}

		return "";
	}
	
	
	//구매혜택 이벤트
	public String getBanner_moreRewardEvent(String id, String start, String end, String db_id) {
		if (isRunning(start, end)) {
			try {
				Mobile_Stamp_Proc mMobile_Stamp_Proc = new Mobile_Stamp_Proc();
				if (mMobile_Stamp_Proc.isNotMoreRewardAndBuyLog(db_id, id, start + " 00:00:00", end + " 23:59:00"))
					return "banner_crm121";
			} catch (Exception e) {
			}
		}

		return "";
	}
	
	

	//http://58.234.199.100/redmine/issues/29416
	//[모바일] 앱 실행 레이어배너 노출: 더블적립 혜택안내
	public String getBanner_10_limited(String id) {

		//출기간: 7/6(금)~7/19(목) 23시 59분

		if (isRunning("2019-12-26", "2020-01-12")) {
			String idlist[] = {
					"sonane45",
					"omom1",
					"omom2",
					"omom3",
					"omom4",
					"omom8",
					"omom9",
					"omom11",
				
 };

			for (int i = 0; i < idlist.length; i++) {
				if (idlist[i].equals(id)) {
					return "banner_crm131";
				}
			}
		}
		return "";
	}

	//-----------------------------------------------------------------------------------------------------------------------------
	//-----------------------------------------------------------------------------------------------------------------------------
	//-----------------------------------------------------------------------------------------------------------------------------
	//-----------------------------------------------------------------------------------------------------------------------------
	public boolean isRunning(String start, String end) {

		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date dateStart = sdf.parse(start);
			Date dateEnd = sdf.parse(end);
			Date dateCurrunt = new Date();
			return dateCurrunt.compareTo(dateStart) >= 0 && dateCurrunt.compareTo(dateEnd) <= 0;

		} catch (Exception e) {

		}
		return false;

	}

	public JSONArray getJSONArrayfromHttp(String strurl) {
		try {
			String recv;
			StringBuffer recvbuff = new StringBuffer();
			URL jsonpage = new URL(strurl);
			URLConnection urlcon = jsonpage.openConnection();
			urlcon.setConnectTimeout(2000);

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

			return new JSONArray(new String(arBytes, "utf-8"));
		} catch (Exception e) {

		}
		return null;
	}%>