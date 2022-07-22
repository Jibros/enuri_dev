<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.mobile.Reward_Proc"%>
<%@ page import="org.json.*"%>

<%
	String strUserid = cb.GetCookie("MEM_INFO","USER_ID");

	JSONArray jSONArray = new JSONArray();

	Reward_Proc reward_proc = new Reward_Proc();
	//try{
		JSONObject jSONPoint = reward_proc.get_Point(strUserid);

		//값에 ".0" 있으면 없에고 return;
		String sPOINT_REMAIN = (String)jSONPoint.get("POINT_REMAIN");
		String sPOINT_PRE_FIX = (String)jSONPoint.get("POINT_PRE_FIX");
		String sREVOLUTION = (String)jSONPoint.get("REVOLUTION");
		//String sUSERID = (String)jSONPoint.get("USERID");

		if(sPOINT_REMAIN != null && sPOINT_REMAIN.indexOf(".0") > -1){
			sPOINT_REMAIN = sPOINT_REMAIN.replace(".0","");
		}
		if(sPOINT_PRE_FIX != null && sPOINT_PRE_FIX.indexOf(".0") > -1){
			sPOINT_PRE_FIX = sPOINT_PRE_FIX.replace(".0","");
		}

		//"mobilefirst/ajax/resentZzim/Ajax_goodsListNew.jsp?listType=2&folder_id=1&deviceType=m&pageNum=1&pageGap=10"

		String strResentList = "";	//쿠키에 있는값
		String strResentListAll = "";	//정리한 값

		javax.servlet.http.Cookie[] cookies = request.getCookies();
		if(cookies!=null){
			for(int i = 0 ; i<cookies.length; i++){                            // 쿠키 배열을 반복문으로 돌린다.
				if(cookies[i].getName().equals("resentList")){
					strResentList = cookies[i].getValue();
				}
			}
		}


		//최근본 상품 갯수
		int intCnt = 0;

		if (strResentList != null) {
			String[] strResentListAry = strResentList.split(",");
			for (int i = 0; i < strResentListAry.length; i++) {
				if(i < 10){
					if(i > 0) strResentListAll += ",";
					strResentListAll += strResentListAry[i];
				}
				intCnt++;
			}
		}
		// 쿠키 를 통해 데이터를 읽어옴(resentList)
		//var loadUrl = "/mobilefirst/ajax/resentZzim/Ajax_goodsListNew.jsp?listType=9&goodsNumList=" + resentListStr2;
%>
<jsp:include page="/mobilefirst/ajax/resentZzim/Ajax_goodsListNew.jsp" flush="true">
	<jsp:param name="listType" value="9"/>
	<jsp:param name="goodsNumList" value="<%=strResentListAll%>"/>
</jsp:include>

<%
		JSONObject jSONData = new JSONObject();

		jSONData.put("POINT_REMAIN", sPOINT_REMAIN);
		jSONData.put("POINT_PRE_FIX",sPOINT_PRE_FIX);
		jSONData.put("REVOLUTION",sREVOLUTION);
		jSONData.put("USERID",strUserid);
		jSONData.put("POINT_UNIT","개");

		out.println(jSONData.toString());
	//} catch (Exception e) {}
%>