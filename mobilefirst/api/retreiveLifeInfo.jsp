<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.enuri.bean.main.brandplacement.DBDataTable"%>
<%@ page import="com.enuri.util.seed.Seed_Proc"%>
<%@ page import="com.enuri.bean.main.brandplacement.DBWrap"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="org.json.JSONObject"%>
<%@ page import="com.enuri.util.date.DateUtil"%>
<%@ page import="java.text.ParseException"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="com.enuri.util.seed.Seed_Proc"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@ page import="com.enuri.bean.member.Login_Data"%>
<%@ page import="com.enuri.bean.member.Login_Proc"%>
<jsp:useBean id="Login_Data" class="com.enuri.bean.member.Login_Data" />
<jsp:useBean id="Login_Proc" class="com.enuri.bean.member.Login_Proc" />
<jsp:useBean id="Members_Data" class="com.enuri.bean.knowbox.Members_Data" />
<jsp:useBean id="Members_Proc" class="com.enuri.bean.knowbox.Members_Proc" />
<jsp:useBean id="Seed_Proc" class="com.enuri.util.seed.Seed_Proc" />
<jsp:useBean id="Mobile_Push_Proc" class="com.enuri.bean.mobile.Mobile_Push_Proc" scope="page" />
<%@ page import="com.enuri.bean.mobile.PDManager_Proc"%>
<%@ page import="com.enuri.bean.mobile.PDManager_PD_Data"%>
<%@ page import="com.enuri.bean.mobile.PDManager_T1_Data"%>
<%
	//20171113 손진욱 t1 pd 모듈
	PDManager_Proc pdmanager = new PDManager_Proc();
	PDManager_T1_Data t1Data = pdmanager.getT1(request);
	PDManager_PD_Data pdData = pdmanager.chkT1PD(request, t1Data);

	String strRtn_msg = "";
	String strRtn_nohpmail_msg = "";
	String strAdult = "0";
	String strR_code = "";
	String strR_msg = "";
	String strR_id = "";


	String strT1_enuriid = "";
	String strT1_userdata = "";
	String sApp_type = "";
	String sUuid = "";
	String sEnuri_id = "";
	String sEnuri_nm = "";
	String sNickname = "";
	String strSnsDcd = "";


	boolean isService = false;
	boolean isNOhpmail = false; //핸드폰이나 이메일 없을때

	boolean blCheck_t1 = false;
	boolean blCheck_pd = false;
	boolean bl_Certify = false; //본인인증여부
	if (t1Data != null && t1Data.isData()) {
		strT1_enuriid = t1Data.getStrT1_enuriid();
		strT1_userdata = t1Data.getStrT1_userdata();
		blCheck_t1 = true;
	}
	if (pdData != null && pdData.isData()) {
		sApp_type = pdData.getAppid();
		sUuid = pdData.getUuid();
		sEnuri_id = pdData.getEnuri_id();
		strSnsDcd = pdData.getSnsDcd();
		blCheck_pd = true;

		//userid 로 adult 값 검색해서 넘겨줌.
		// 1: 인증회원, 0: 안인증회원
// 		Members_Data members_data = Members_Proc.Login_Check_Id( sEnuri_id ); //사용자 정보
		Members_Data members_data = Members_Proc.Login_Check_Id_Certify(sEnuri_id); //사용자 정보
		//요까지~
		String errCode = ChkNull.chkStr(members_data.getErrCode());
		String userid = ChkNull.chkStr(members_data.getUserid());
		String name = ChkNull.chkStr(members_data.getName());
		String nickname = ChkNull.chkStr(members_data.getNickname());
		String service_flag = ChkNull.chkStr(members_data.getService_flag());
		String m_group = ChkNull.chkStr(members_data.getM_group());
		String start_date = ChkNull.chkStr(members_data.getStart_date());
		String classname = ChkNull.chkStr(members_data.getClassname());
		String ap_yn = ChkNull.chkStr(members_data.getAp_yn());
		String yyyymmdd = ChkNull.chkStr(members_data.getYyyymmdd());
		String chkAdult = ""; //성인여부 (0:미성년자, 1:성인, 2:판단불가-판매자 또는 주민번호 없이 가입)

		String strCertify = ChkNull.chkStr(members_data.getCetify());
		String strConf_ci_key = ChkNull.chkStr(members_data.getConf_ci_key());
		String strConf_di_key = ChkNull.chkStr(members_data.getConf_di_key());
		String strTel1_p = ChkNull.chkStr(members_data.getTel1_p());
		String strTel2_p = ChkNull.chkStr(members_data.getTel2_p());
		String strTel3_p = ChkNull.chkStr(members_data.getTel3_p());

		int nowYear = ChkNull.chkInt(DateStr.nowStr().substring(0, 4));
		int birthYear = 0;
		if (!yyyymmdd.equals("") && yyyymmdd.length() >= 4) {
			birthYear = ChkNull.chkInt(yyyymmdd.substring(0, 4));
			if (nowYear - birthYear >= 19) {
				strAdult = "1";
			} else {
				strAdult = "0";
			}
		} else {
			strAdult = "2";
		}
		if (m_group.equals("1") || m_group.equals("2") || m_group.equals("6")) { //운영자는 성인처리
			strAdult = "1";
		}

		//System.out.println("strCertify>>>"+strCertify);
		//System.out.println("service_flag>>>"+service_flag);
		//System.out.println("strConf_ci_key>>>"+strConf_ci_key);
		//System.out.println("strConf_di_key>>>"+strConf_di_key);
		//System.out.println("strTel1_p>>>"+strTel1_p);
		//System.out.println("strTel2_p>>>"+strTel2_p);
		//System.out.println("strTel3_p>>>"+strTel3_p);
		//System.out.println("strCertify>>>"+strCertify);

		//실명인증 여부. 안전을 위해 정상회원인지, 키가 제대로 있는지, 전화번호도 제대로 있는지까지 확인함.
		if (strCertify.equals("2") && service_flag.equals("0") && !strConf_ci_key.equals("")
				&& !strConf_di_key.equals("") && !strTel1_p.equals("") && !strTel2_p.equals("")
				&& !strTel3_p.equals("")) {
			bl_Certify = true;
		}
		//자기 인증 여부를 유실한 회원
		if (strCertify.equals("0")) {
			strRtn_msg = userid + "님과 동일한 휴대폰 번호로 다른 회원이 본인인증을 하였습니다. PC로 에누리 접속 후 휴대폰 번호를 다시 저장해주세요.";
		}

		if (service_flag.equals("0")) { //	0 - 정상,1 - 자진탈퇴,2 - 강제탈퇴,3 - 이용정지,4 - 해외이용자 삭제,5 - 임시비밀번호,6 - 이용정지(ID도용),7 - 해외거주자(가입신청),8 - 1년 이상 미사용 탈퇴 (=휴면)
			isService = true;
		}

		if (!bl_Certify) {
			//휴대폰/이메일 없을때 alert
			Login_Data login_data = Login_Proc.isNotiMember(userid); //사용자 정보

			if (login_data != null) {
				String strCetify = login_data.getCetify();
				String strM_email = login_data.getM_email();
				String strModifydate = login_data.getModifydate();
				String strHp = login_data.getHp_tel1() + "-" + login_data.getHp_tel2() + "-"
						+ login_data.getHp_tel3();

				if (strM_email.equals("") || strHp.length() < 3) {
					//이메일 OR 핸드폰 누락
					isNOhpmail = true;
					if (!sApp_type.equals("I1001")) { // iOS 버그 일주일동안 보지않기해도 다음번에 뜸. v325 (2017-04-27)
						//strRtn_nohpmail_msg = userid + "님, 휴대폰, 이메일은 서비스이용을 위한 필수입력 정보입니다. PC에 접속하신후 마이페이지에서 꼭 입력해 주세요.";

						//메세지 삭제요청 2017-05-23 shwoo
						//strRtn_nohpmail_msg = userid + "님의 회원정보를 최신정보로 업데이트 해주세요. 회원정보는 PC 사이트에서 수정하실 수 있습니다.";
						strRtn_nohpmail_msg = "";
					}
				}
			}
		}

		sNickname = nickname;
		sEnuri_nm = name;
	}

	/*
	 구분 					code 				message
	 1 	성공 					100 				ok 　
	 2 	data오류 			200 				t1오류
	 3 	request 오류 		300 				pd오류
	 4 	server 오류 			400 				t1과 pd의 user_data가 다름

	 */

	if (blCheck_t1 && blCheck_pd) {
		strR_code = "100";
		strR_msg = "ok";
	} else if (!blCheck_t1) {
		strR_code = "200";
		strR_msg = "t1오류";
	} else if (!blCheck_pd) {
		strR_code = "300";
		strR_msg = "pd오류";
	}
	/* else {
		if (blCheck_t1 && blCheck_pd) {
			if (!strT1_userdata.trim().equals(sUuid.trim())) {
				strR_code = "400";
				strR_msg = "t1과 pd의 user_data가 다름";
			}
		}
	} */

	java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMddHHmmss");
	String today = formatter.format(new java.util.Date());

	JSONObject obj = new JSONObject();
	obj.put("code", strR_code);
	obj.put("message", strR_msg);
	obj.put("result_id", strR_id);
	obj.put("adult", strAdult);
	obj.put("certify", String.valueOf(bl_Certify));
	//android 오타가 있어 대응함 20190115
	obj.put("cerify", String.valueOf(bl_Certify));
	obj.put("nohpmail", String.valueOf(isNOhpmail));
	obj.put("certify_msg", strRtn_msg);
	obj.put("nohpmail_msg", strRtn_nohpmail_msg);
	obj.put("userid", sEnuri_id);
	obj.put("usernm", sEnuri_nm);
	obj.put("snslogin", strSnsDcd);
	obj.put("nickname", sNickname);
	obj.put("realtime", today);
	JSONObject UserMtcObj = Login_Proc.getUsrMtcId(sEnuri_id);
	obj.put("usrMtcEnc", ChkNull.chkStr(UserMtcObj.has("usr_mtc_enc")?UserMtcObj.getString("usr_mtc_enc"):"")); // #36211
	out.println(obj.toString());
%>