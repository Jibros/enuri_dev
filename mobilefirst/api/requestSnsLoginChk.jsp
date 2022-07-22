<%@ page contentType="text/html; charset=utf-8"%>
<%@page import="com.enuri.bean.mobile.PDManager_PD_Data"%>
<%@page import="com.enuri.bean.mobile.PDManager_Proc"%>
<%@page import="org.json.JSONObject"%>
<%@page import="com.enuri.util.common.ChkNull"%>
<%@page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@page import="com.enuri.bean.knowbox.Members_Data"%>
<%@page import="com.enuri.bean.member.Login_Data"%>
<%@page import="com.enuri.bean.member.Login_Proc"%>
<%@page import="com.enuri.bean.member.SnsType"%>
<%@page import="com.enuri.bean.member.Sns_Login"%>
<%
	PDManager_Proc pdmanager = new PDManager_Proc();
	PDManager_PD_Data pdData = pdmanager.chkPD(request);
	Sns_Login snsLogin = new Sns_Login();

	JSONObject jsonObject = new JSONObject();
	String strEnuriId = "";
	String nextpage = "";
	boolean isCertified = false;
    String strAppid = "";

	if (pdData != null && pdData.isData()) {
		strEnuriId = pdData.getEnuri_id();	// sns_usr_id

		//회원가입페이지 보낼때 app_id 넘겨야함
		strAppid = pdData.getAppid();
		if(strAppid != null && strAppid.length() > 4){
			strAppid = strAppid.substring(1,5);
		}

		SnsType snsDcd = snsLogin.getSnsType(pdData.getSnsDcd());
		// SNS 로그인
		if (snsLogin.isSnsMember(strEnuriId, snsDcd)) {
			// 에누리 회원
			strEnuriId = snsLogin.getSnsEnuriId(strEnuriId, snsDcd);

			// 본인인증 여부
			Members_Data members_data = new Members_Proc().Login_Check_Id_Certify(strEnuriId); //사용자 정보
			String strCertify = ChkNull.chkStr(members_data.getCetify());
			String service_flag = ChkNull.chkStr(members_data.getService_flag());
			String strConf_ci_key = ChkNull.chkStr(members_data.getConf_ci_key());
			String strConf_di_key = ChkNull.chkStr(members_data.getConf_di_key());
			String strTel1_p = ChkNull.chkStr(members_data.getTel1_p());
			String strTel2_p = ChkNull.chkStr(members_data.getTel2_p());
			String strTel3_p = ChkNull.chkStr(members_data.getTel3_p());

			if (strCertify.equals("2") && service_flag.equals("0") && !strConf_ci_key.equals("")
					&& !strConf_di_key.equals("") && !strTel1_p.equals("") && !strTel2_p.equals("")
					&& !strTel3_p.equals("")) {
				isCertified = true;
			}
		} else {
			// 에누리 비회원
			strEnuriId = "";
			//nextpage = request.getHeader("X-Forwarded-Proto") + "://" + request.getServerName() + (80 == request.getServerPort()?"":":"+request.getServerPort()) + "/member/join/join_sns.jsp?freetoken=login_title&appid="+strAppid;
			nextpage = "https://" + request.getServerName()  + "/member/join/join.jsp?freetoken=login_title&appid="+strAppid;
		}
		jsonObject.put("userid", strEnuriId);				// 에누리 사용자 ID
		jsonObject.put("nextpage", nextpage);				// 비회원시 회원가입 url
		jsonObject.put("certification", isCertified);
	}
	out.println(jsonObject.toString());
%>