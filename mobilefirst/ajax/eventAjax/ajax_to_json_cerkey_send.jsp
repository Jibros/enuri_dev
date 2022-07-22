<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Mobile_Event_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>
<%
	String cerkey = StringUtils.defaultString(request.getParameter("cerkey"));
	String chk_id = StringUtils.defaultString(request.getParameter("chk_id"));
	
	Mobile_Event_Proc mobile_Event_Proc = new Mobile_Event_Proc();
	JSONObject jSONCerkeyMap = mobile_Event_Proc.cerkeyCnt(cerkey);
	
	int cerKeyCnt = Integer.parseInt(jSONCerkeyMap.getString("cnt"));
	
	String ostype = "";
		
	if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") >= 0){
		ostype = "A";
	}else if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") >= 0 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") >= 0){
		ostype = "I";
	}else if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") >= 0){
		ostype = "I";
	}else{
		ostype = "P";
	}
	
	JSONObject jSONObject = new JSONObject(); 
	
	
	//이미 참여 하셨습니다.
	if(StringUtils.defaultString(jSONCerkeyMap.getString("EVENT_CHECK_YN"),"").equals("Y")){
		
		jSONObject.put("result","D");
		mobile_Event_Proc.eventCerKeyInsertLog(cerkey,chk_id,ostype,"D");
	
	}else if(chk_id.equals("")){
		
		if(ostype.equals("I")){
			if( cerKeyCnt > 0 ){
				
				jSONObject.put("result","Y");
				mobile_Event_Proc.eventCerKeyInsertLog(cerkey,chk_id,ostype,"M");
				mobile_Event_Proc.eventCerKeyUpdate("SYSERROR",ostype,"Y",cerkey);
			}
			else //등록된 인증 번호가 아닙니다.
			{
				jSONObject.put("result","R");
			}
		}else{
			
			jSONObject.put("result","M");
			mobile_Event_Proc.eventCerKeyInsertLog(cerkey,chk_id,ostype,"M");
		}
		
	}else{
		
		int uuid = 0;
				
		if(!chk_id.equals("")){ //기기코드가 넘어왔을 경우
			uuid = mobile_Event_Proc.getUUID(chk_id);
		}
		
		//등록된 유저키가 있을경우
		if(uuid > 0 ){
			jSONObject.put("result","X");
			mobile_Event_Proc.eventCerKeyInsertLog(cerkey,chk_id,ostype,"X");
		
		}else if(cerKeyCnt > 0){
		
			JSONObject jSONOToken = new JSONObject(); 
			jSONOToken = mobile_Event_Proc.mobileTokenJson(chk_id,""); 
			
			boolean result = false;
			
			if(jSONOToken.getInt("cnt") > 0){ //설치자
				
				String versionFirst = StringUtils.defaultString(jSONOToken.getString("VERSION_FIRST"),"0");
				
				if(versionFirst.equals("2.2.3") || versionFirst.equals("2.2.6") || versionFirst.equals("2.2.4") || versionFirst.equals("2.2.7.08") ){ 
					result = mobile_Event_Proc.eventCerKeyUpdate(chk_id,ostype,"Y",cerkey);
					
					if(result){//등록 성공
						jSONObject.put("result","Y");
						mobile_Event_Proc.eventCerKeyInsertLog(cerkey,chk_id,ostype,"Y");
					}else{//등록 애러
						jSONObject.put("result","E");
					}
					
				}else{
					jSONObject.put("result","N"); //신규 설치자가 아니다
					mobile_Event_Proc.eventCerKeyInsertLog(cerkey,chk_id,ostype,"N");
				}
				
			}else{ 
				//아이폰 일 경우는 임시적으로 유저데이터가 없어도 당첨시키고	
				if(ostype.equals("I")){
				 	result = mobile_Event_Proc.eventCerKeyUpdate(chk_id,ostype,"Y",cerkey);
				 	jSONObject.put("result","Y");
				 	mobile_Event_Proc.eventCerKeyInsertLog(cerkey,chk_id,ostype,"A");
				}else{ // 	안드로이드 일 경우 일딴 막는다
					jSONObject.put("result","M");
					mobile_Event_Proc.eventCerKeyInsertLog(cerkey,chk_id,ostype,"H");
				}
			}
		}else{//인증번호가 잘못 되었습니다.
			
			jSONObject.put("result","R");
			mobile_Event_Proc.eventCerKeyInsertLog(cerkey,chk_id,ostype,"R");
			
		}
	
	}
	out.println(jSONObject.toString());
%>