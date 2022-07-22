<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Mobile_Event_Proc"%>
<%@page import="com.enuri.bean.mobile.Mobile_Push_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>
<%
	JSONObject jSONObject = new JSONObject();
	
	Mobile_Event_Proc mobile_Event_Proc = new Mobile_Event_Proc();
			 
	String userId  =  ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"),"");
	String userData =ChkNull.chkStr(request.getParameter("chkId"),"");
	
	int memberPointYNCnt = mobile_Event_Proc.getMemberPointYN(userId);
	
	//로그인 체크
	if(userId.equals("")){
		jSONObject.put("result","UN"); // 유저 아이디 없습니다. 로그인 하세요
		
	}else if(userData.equals("")){
		jSONObject.put("result","DN"); // 기기 아이디 없습니다. 
	}else if(memberPointYNCnt > 0 ){
		jSONObject.put("result","AR"); // 이미 적립군 등록 된사람 입니다.
	}else{
		
		JSONObject jsonToken = new JSONObject(); 
		jsonToken = mobile_Event_Proc.mobileTokenJson(userData,"");
		
		int cnt = (Integer)jsonToken.getInt("cnt");
		
		if( cnt > 0 ){
		
			String ver = StringUtils.replace(StringUtils.defaultString((String)jsonToken.get("VERSION_FIRST"),"0"),".","");
			//String ver = "30000";
			
			if(ver.length() >= 5){
				ver = StringUtils.substring(ver,0,3);
			}
						
			int version_first = Integer.parseInt(ver) ;
			
			//members point_YN 업데이트
			boolean result = mobile_Event_Proc.memberRevolutionUpdate(userId);
			
			if(result){
				//신규 설치 유저
				if(version_first >= 300){
					
					mobile_Event_Proc.upd_reward_event_point_ins(userId , "09", 500 );
					int  effect =  (Integer)mobile_Event_Proc.upd_reward_app_install_point_ins(userId , userData ,500 );
					
					if(effect == 1){
						jSONObject.put("result","S"); // 신규 설치 유저임
					}else{
						jSONObject.put("result","RU"); // 이미 등록된 기기 입니다.
					}
					
				} else { //신규 설치 유저 아님
					jSONObject.put("result","NN"); // 신규 설치 유저가 아님
					mobile_Event_Proc.upd_reward_event_point_ins(userId , "09", 500);
				}			
			}else{
				jSONObject.put("result","F"); // 등록 실패
			}
			
		
		}else{
			jSONObject.put("result","IN"); //install not 설치 확인 안됨
		}
		
		
	}
	
	out.println(jSONObject.toString());
%>