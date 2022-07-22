<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="java.io.UnsupportedEncodingException"%>
<%@page import="com.enuri.exception.ExceptionManager"%>
<%@page import="org.json.JSONObject"%>
<%@page import="com.enuri.bean.event.Members_Friend_Proc2"%>
<%@page import="com.enuri.bean.member.Join_Data"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.event.Members_Friend_Proc"%>
<%@page import="com.enuri.bean.member.Sns_Login"%>
<jsp:useBean id="Members_Friend_Proc" class="com.enuri.bean.event.Members_Friend_Proc" scope="page" />
<%
	String cUserId = cb.GetCookie("MEM_INFO","USER_ID");
	cUserId = StringReplace(cUserId);

	String strUuid = cb.GetCookie("MOBILEWEBUUID","UUID");
	String strI_Uuid = cb.GetCookie("MOBILEWEBIUUID", "I_UUID");
    String strChk = "1001"; //코어만 하게 변경 됨
	//cUserId = "omom1";
	//strI_Uuid = "103cef5c4cae5966";
	//String recUserid = "";

	//String useridTmp = StringUtils.substringBetween(cb.ShowCookie(), " USER_ID:", "==: USER_NICK:");

	boolean bNomieeInsert = false;

	Join_Data join_Data = new Join_Data();
	Members_Friend_Proc2 members_Friend_Proc2 = new Members_Friend_Proc2();

	System.out.println("****************친구초대파라메터************************");
	System.out.println("====strUuid:"+strUuid);
	System.out.println("====strI_Uuid:"+strI_Uuid);
	System.out.println("====cUserId:"+cUserId);
	System.out.println("====ShowCookie:"+cb.ShowCookie()+"=================");
	System.out.println("====strChk:"+strChk);
	System.out.println("********************************************************");

	join_Data =  members_Friend_Proc2.getMemberData(cUserId);
	String ciKey = join_Data.getConf_ci_key();//본인인증여부

	System.out.println("****************ciKey***********************************");
	System.out.println("====ciKey:"+ciKey);
	System.out.println("====cUserId:"+cUserId);
	System.out.println("====cUserId length :"+cUserId.length());
	System.out.println("********************************************************");

	//암호화상태 쿠키 로그 추가
	Cookie cookiecheck_cookies[] = request.getCookies();

	StringBuilder cookiecheck_sb = new StringBuilder();
	for(int i = 0; i < cookiecheck_cookies.length; i++){
		String cookiecheck_name = URLDecoder.decode(cookiecheck_cookies[i].getName(), "UTF-8");
		String cookiecheck_value = cookiecheck_cookies[i].getValue();

		cookiecheck_sb.append(cookiecheck_name);
		cookiecheck_sb.append("=");
		cookiecheck_sb.append(cookiecheck_value);
		cookiecheck_sb.append("&");
	}
	System.out.println("userid Error - friend_nomiee.jsp - native cookies >>>>"+cookiecheck_sb.toString()+"=====");
	//암호화상태 쿠키 로그 추가 end

	JSONObject jSONObject = new JSONObject();
	
	//sns 인증회원 확인
	boolean bcertify= new Sns_Login().isSnsMemberCertify2(cUserId);
	if(!bcertify){
		jSONObject.put("result", -5);
		out.println(jSONObject.toString());
		return;
	}
	
	//본인인증 확인 추가
	if( !"".equals(ciKey)){

		//본인 인증한 계정으로 포인트 발급여부 확인
		int pointUserCnt =  members_Friend_Proc2.getPointCikey(ciKey);

		if( pointUserCnt > 0 ){ //이미 추천한 적이 있다.
			jSONObject.put("result", "UO");

		}else{

			Members_Friend_Proc members_friend_proc = new Members_Friend_Proc();
			bNomieeInsert = Members_Friend_Proc.insertNomiee2(strUuid, strI_Uuid, cUserId, strChk);

			if(bNomieeInsert)	jSONObject.put("result", "Y");
			else				jSONObject.put("result", "N");

		}

	}else{
		jSONObject.put("result", "UE");
	}

 	out.println(jSONObject.toString());
%>

<%!
//특수문자 제거 하기
public String StringReplace(String str){       
	String match = "[^\uAC00-\uD7A3xfe0-9a-zA-Z\\s]";
	str =str.replaceAll(match, "").trim();
	//str =str.replaceAll("?","").trim();
	return str;
}
%>
