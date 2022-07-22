<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="com.enuri.util.common.ChkNull"%>
<%@page import="com.enuri.bean.event.every.HitBrandProc_2020"%>
<jsp:useBean id="ShortUrl" class="com.enuri.util.http.ShortUrl" scope="page" /> 
<%
	if(!CvtStr.isNumeric(request.getParameter("modelno"))){
		return ;
	}
	/********************** 	PARAMS	*****************************/
	int procCode = ChkNull.chkInt(request.getParameter("procCode"));				//	이벤트 유형
	String sdt = ChkNull.chkStr(request.getParameter("sdt")).trim(); 				//	테스트 날짜
	int modelno = ChkNull.chkInt(request.getParameter("modelno"), 0);
	/********************** 	PARAMS	*****************************/

    SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMdd");
    String strToday = formatter.format(new Date()); 								//	오늘 날짜 (visitData, ins_date)
	String referer = ChkNull.chkStr(request.getHeader("referer")).trim();			//	레퍼러 체크
	int ktw_no = ChkNull.chkInt(request.getParameter("ktw_no"),0);
	String eventId = "2022062201";
	String deviceType = "";
	String userId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"),"");

	if (referer.indexOf("stagedev.enuri.com") > -1 || referer.indexOf("dev.enuri.com") > -1) {
		strToday = "20220622";
	}
	int intToday = Integer.parseInt(strToday);

    JSONObject jSONObject = new JSONObject();
    HitBrandProc_2020 hitProc = new HitBrandProc_2020();

	//POST가 아닐경우 RETURN
	if(!(request.getMethod().equals("POST"))){
		jSONObject.put("response", "fail");
		out.println(jSONObject.toString());
		return ;
	}else{
		jSONObject.put("response", "success");
	}

    //날짜 체크
    if((intToday > 20220731 || intToday < 20220622 )){
    	jSONObject.put("response", "fail ");
    }else{

    	//procCode==1(스탬프 노출)
    	//procCode==2(스탬프 획득)
    	if(modelno >0){
    		boolean blCheck = false;
    		int cnt = 0;
    		int resultCode = 0;
    		if(procCode==1){
    			blCheck = hitProc.hitProdCheck(modelno, eventId);					//히트 모델 상품인지 체크
    			if(blCheck){
    				if(!(userId.equals("")) && userId!=null){
    					cnt = hitProc.getModelStamp(userId, eventId, modelno, ktw_no);		//사용자가 해당모델의 스탬프를 받았는지 체크
    				}
    				jSONObject.put("result",cnt);
    			}else{
    				jSONObject.put("result",-1);									//히트모델 상품 x..
    			}
    		}else if(procCode==2){
    			cnt = hitProc.getModelStamp(userId, eventId, modelno, ktw_no);				//사용자가 해당모델의 스탬프를 받았는지 체크
    			if(cnt > 0 ){
    				jSONObject.put("result",-1);
    			}else{
    				blCheck = hitProc.addStamp(userId, eventId, modelno, ktw_no);			//스탬프 획득
    				if(blCheck){
    					cnt = hitProc.getModelStamp(userId, eventId, 0, 0);//스탬프 갯수 return
    					jSONObject.put("result",cnt);
    				}else{
    					jSONObject.put("result",-1);
    				}
    			}
    		}
    	}
    }
    out.println(jSONObject.toString());
%>