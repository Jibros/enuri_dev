<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Mobile_Event_Proc"%>
<%@page import="com.enuri.bean.mobile.Event_Friend_Proc"%>
<%@page import="com.enuri.bean.mobile.Mobile_Push_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>
<%
	JSONObject jSONObject = new JSONObject();
	
	Mobile_Event_Proc mobile_Event_Proc = new Mobile_Event_Proc();
			 
	String userId  =  ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"),"");
	String userData =ChkNull.chkStr(request.getParameter("chkId"),"");
	
	//int memberPointYNCnt = 0;
	int memberPointYNCnt = mobile_Event_Proc.getMemberPointYN(userId); //두대 같은계정은 500원 받을수 없다.
   
   //친구 추천 여부
   boolean nomieeYN = false; 
   
   memberPointYNCnt = 1;//이벤트 종료
   
	//로그인 체크
	if(userId.equals("")){
		jSONObject.put("result","UN"); // 유저 아이디 없습니다. 로그인 하세요
		
	}else if(userData.equals("")){
		jSONObject.put("result","DN"); // 기기 아이디 없습니다. 
	}else if(memberPointYNCnt > 0 ){
		jSONObject.put("result","AR"); // 이미 적립군 등록 된사람 입니다.
	}else{
		
		Mobile_Push_Proc mobile_push_proc = new Mobile_Push_Proc();
		mobile_push_proc.insertEvent3(userId, userData, "" , "20160215"); //insert 한다.
		
		JSONObject jsonToken = new JSONObject(); 
		//jsonToken = mobile_Event_Proc.mobileTokenJson(userData,"");
		jsonToken = mobile_Event_Proc.getInstalllData(userId,userData);
		
		int cnt = jsonToken.length();
		
		if( cnt > 0 ){
		
			String ver = StringUtils.replace(StringUtils.defaultString((String)jsonToken.get("version_first"),"0"),".","");
			//String ver = "30000";
			
			if(ver.length() >= 5){
				ver = StringUtils.substring(ver,0,3);
			}
						
			int version_first = Integer.parseInt(ver) ;
			
			//members point_YN 업데이트
			boolean result = mobile_Event_Proc.memberRevolutionUpdate(userId);
			
			if(result){
			
				//신규 설치 유저
				if(version_first >= 304){
					
					Calendar calendar = Calendar.getInstance();
					calendar.add(Calendar.DATE, 29);
					SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					String cur_date = format.format(calendar.getTime());
					
					//int  effect =  (Integer)mobile_Event_Proc.upd_reward_app_install_point_ins(userId , userData ,500 );
					
				    //String sEventChk = mobile_push_proc.insertEvent2(userId, userData, 500, cur_date, ver, "20160215");
					String sEventChk = mobile_push_proc.updateEvent3 (userId, userData, 500, cur_date, ver, "20160215"); //update
					
					//upd_reward_app_install_point_udp_ver3 (userId, userData, 500, cur_date, ver, "20160215");
					
					if(sEventChk.equals("1")){
						jSONObject.put("result","S"); // 신규 설치 유저임
						Event_Friend_Proc event_Friend_Proc = new Event_Friend_Proc();
						nomieeYN = event_Friend_Proc.getNomieeUserYN(userId);
						
					}else{
						jSONObject.put("result","RU"); // 이미 등록된 기기 입니다.
					}
					
				}else{
					jSONObject.put("result","UV"); // 최소설치 버전이 옛날버전
				} 
					
			}else{
				jSONObject.put("result","F"); // 등록 실패
			}
			
		
		}else{
			//members point_YN 업데이트
			mobile_Event_Proc.memberRevolutionUpdate(userId);
			jSONObject.put("result","IN"); //install not 설치 확인 안됨
		}
		
	}
	
	jSONObject.put("nomieeYN",nomieeYN); // 신규 설치 유저임
	
	out.println(jSONObject.toString());
%>