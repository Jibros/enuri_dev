<%@page import="com.enuri.bean.event.Members_Friend_Proc"%>
<%@page import="com.enuri.bean.member.Join_Data"%>
<%@page import="com.enuri.bean.event.Members_Friend_Proc2"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>
<%@page import="com.enuri.bean.member.Sns_Login"%>
<jsp:useBean id="ShortUrl" class="com.enuri.util.http.ShortUrl" scope="page" />

<%
	String cUserId = cb.GetCookie("MEM_INFO","USER_ID");
	String cUserNick = cb.GetCookie("MEM_INFO","USER_NICK");

	Members_Friend_Proc members_Friend_Proc = new Members_Friend_Proc();
	Members_Friend_Proc2 members_Friend_Proc2 = new Members_Friend_Proc2();

	JSONObject jSONObject = new JSONObject();

	if( cUserId != null && !cUserId.equals("") ){

		Join_Data join_Data = new Join_Data();
		join_Data =  members_Friend_Proc2.getMemberData(cUserId);
		String ciKey = ChkNull.chkStr(join_Data.getConf_ci_key());//본인인증여부

		int cikeyCnt =  0;
		if(!ciKey.equals("")){
			cikeyCnt = members_Friend_Proc2.chk_cikey(ciKey);
		}
		jSONObject.put("cikeyCnt",cikeyCnt);

		//sns 인증회원 확인
		boolean bcertify= new Sns_Login().isSnsMemberCertify2(cUserId);
		if(!bcertify){
			jSONObject.put("result", -5);
			out.println(jSONObject.toString());
			return;
		}

		if(cikeyCnt > 1){
			jSONObject.put("result","O"); // 이미 인증한 아이디로 초대코드 받은 사람 OVERLAP
		}else{
			if(!ciKey.equals("")){ //본인 인증 완료한 사람

// 				JSONObject infoJson = members_Friend_Proc2.getMyUrl(cUserId);
				JSONObject infoJson = members_Friend_Proc2.getMyUrl2(ciKey);
				if(  infoJson.length() > 0 ){
					jSONObject.put("result","G"); // 본인인증 O, 초대코드 O
					jSONObject.put("myUrl",StringUtils.defaultString(infoJson.getString("shorturl")));
					jSONObject.put("userid",StringUtils.defaultString(infoJson.getString("userid")));
				}else{
					jSONObject.put("result","S"); // 본인인증 O, 초대코드 X
				}

			}else{
				jSONObject.put("result","N"); // 본인인증 안한 사람
			}
		}
	}else{
		jSONObject.put("result","LE"); // 로그인 안됨
	}
	out.println(jSONObject.toString());
%>