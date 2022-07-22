<%@page import="com.enuri.bean.member.Sns_Login"%>
<%@page import="com.enuri.bean.main.Member_Point_Proc"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.event.Members_Friend_Proc"%>
<%@ page import="com.enuri.bean.event.Members_Friend_Proc2"%>
<%@ page import="org.json.*"%>
<%@ page import="com.enuri.bean.member.Join_Data"%>
<%
Members_Friend_Proc Members_Friend_Proc = new Members_Friend_Proc();
Members_Friend_Proc2 members_Friend_Proc2 = new Members_Friend_Proc2();

String cUserId = cb.GetCookie("MEM_INFO","USER_ID");

String recUserid = ChkNull.chkStr(request.getParameter("rec_userid"),"");
String strChk = ChkNull.chkStr(request.getParameter("chk"),"1");

cUserId = cUserId.toLowerCase();
recUserid = recUserid.toLowerCase();

boolean bRecUserIdChk = false;

JSONObject jSONObject = new JSONObject();

if(cUserId.trim().equals("")){
}else{
	
	//sns 인증회원 확인
	boolean bcertify= new Sns_Login().isSnsMemberCertify2(cUserId);
	if(!bcertify){
		jSONObject.put("result", -5);
		out.println(jSONObject.toString());
		return;
	}
	bcertify = Members_Friend_Proc.WelcomPayBackChk(cUserId);
	if(!bcertify){
		jSONObject.put("result", -101);
		out.println(jSONObject.toString());
		return;
	}
	
	if(strChk.equals("1")){						// 탈퇴, 휴면 체크	( true:정상 / false: 탈퇴,휴면ID 등)
		if(!cUserId.equals(recUserid)){
			bRecUserIdChk = Members_Friend_Proc.RecUserIdChk(cUserId, recUserid);
			if(bRecUserIdChk){
				
				JSONObject recUserJson = members_Friend_Proc2.getMyUrl(recUserid);//초대받은사람
				
				if(recUserJson.length() > 0){ //친구코드 받은 아이디
					Join_Data Join_Data = new Join_Data();
					Join_Data = members_Friend_Proc2.getMemberData(cUserId);
					String conf_ci_key = Join_Data.getConf_ci_key();
					
					if(conf_ci_key.equals("")){
						jSONObject.put("result", "UE"); //인증이 안됐다
					}else if(conf_ci_key.equals(recUserJson.getString("cikey"))){
						jSONObject.put("result", "UO"); //추천인과 유저의 인증값이 같다
					}else{
						
						JSONObject getMembersNomiee =  members_Friend_Proc2.getMembersNomiee(conf_ci_key);
						int nomieeCikey = getMembersNomiee.getInt("cnt");
						
						if(nomieeCikey > 0){
							jSONObject.put("result", "UO"); //인증한 계정이 있다
						}else{
							jSONObject.put("result", "Y"); //정상아이디
						}
					}
				}else{
					jSONObject.put("result", "RE"); //정상아이디
				}
			} else {
				jSONObject.put("result", "N"); //탈퇴 휴면 아이디
			}
		}else{
			jSONObject.put("result", "SAME"); // 초대 아이디 본인 아이디 같다
		}
	
	}else if(strChk.equals("2")){			// 추천아이디 업데이트
		if(!cUserId.equals(recUserid)){
			
			Join_Data Join_Data = new Join_Data();
			Join_Data = members_Friend_Proc2.getMemberData(cUserId);
			String conf_ci_key = Join_Data.getConf_ci_key();
			
			if(conf_ci_key.equals("")){
				jSONObject.put("result", "UE"); //인증이 안됐다
			}else{
				
				JSONObject getMembersNomiee =  members_Friend_Proc2.getMembersNomiee(conf_ci_key);
				
				int nomieeCikey = getMembersNomiee.getInt("cnt");
				
				if(nomieeCikey > 0){
					jSONObject.put("result","UO"); //이미 있다
				}else{
					
					bRecUserIdChk = Members_Friend_Proc.RecUserIdChk2(cUserId); // 추천자가 있는지 확인 true 없다 (등록해도 된다) , false 있다 (등록하면 안된다)
					
					//맞초대 막음 2017-05-25 shwoo
					//초대자아이디 (recUserid)의 REC_USERID가 cUserId 같으면 막음.
					String recId = Members_Friend_Proc.RecUserIdChk3(recUserid);	//추천인의 추천인
					
					if(recId.equals(cUserId)){	//추천인의 추천인이 지금 회원이면
						jSONObject.put("result","RSAME");
					}else{
						if(bRecUserIdChk){		//추천자 등록		// true:정상
							
							//기존 인증된 사람중에 초대자를 등록한 건수가 없을 경우만 첫구매 등록해준다  
							//2018-07-24 노병원 and rec_userid is not null 추가 함
							int memberCikeyCnt = members_Friend_Proc2.getMembersCikey(conf_ci_key);
							
							if(memberCikeyCnt == 0){//
								bRecUserIdChk = Members_Friend_Proc.udp_members(cUserId, recUserid);
								
								if(bRecUserIdChk){//정상적으로 친구초대가 등록 되었을 경우
									Member_Point_Proc member_Point_Proc = new Member_Point_Proc();
									String returnCode = member_Point_Proc.upd_emoney_friend_point_ins(cUserId);
									jSONObject.put("result","Y");									
								}else{
									jSONObject.put("result","UO");	
								}
								
							}else{
								jSONObject.put("result","UU");								
							}
							
						}else{					//  false: 이미  입력된 추천 아이디 있음
							jSONObject.put("result","O"); //이미 있다
						}  
					}
					
				}
				
			}
		}
	
	}else if(strChk.equals("3")){
		String recId = Members_Friend_Proc.RecUserIdChk3(cUserId);
		//out.println(recId.trim());
		jSONObject.put("result", recId);
		return;
	}else if(strChk.equals("4")){ // 본인인증 확인
		Join_Data Join_Data = new Join_Data();
		Join_Data = members_Friend_Proc2.getMemberData(cUserId);
		String conf_ci_key = Join_Data.getConf_ci_key();
	}
}
out.println(jSONObject.toString().trim());
%>