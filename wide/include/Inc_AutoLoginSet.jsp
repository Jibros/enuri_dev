<%@page import="com.enuri.bean.member.Sns_Login"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<jsp:useBean id="Members_Data" class="com.enuri.bean.knowbox.Members_Data"  />
<jsp:useBean id="Members_Proc" class="com.enuri.bean.knowbox.Members_Proc"  />
<%@ page import="com.enuri.bean.main.Sdul_Member_Data"%>
<%@ page import="com.enuri.bean.main.Sdul_Member_Proc"%>
<jsp:useBean id="Sdul_Member_Data" class="com.enuri.bean.main.Sdul_Member_Data" scope="page" />
<jsp:useBean id="Sdul_Member_Proc" class="com.enuri.bean.main.Sdul_Member_Proc" scope="page" />
<%@ page import="com.enuri.bean.log.Sdu_login_Data"%>
<%@ page import="com.enuri.bean.log.Sdu_login_Proc"%>
<jsp:useBean id="Sdu_login_Data" class="com.enuri.bean.log.Sdu_login_Data"  />
<jsp:useBean id="Sdu_login_Proc" class="com.enuri.bean.log.Sdu_login_Proc"  />
<%@ page import="com.enuri.bean.log.Log_main_Proc"%>
<%@ page import="com.enuri.bean.log.Log_main_Data"%>
<%@ page import="com.enuri.util.seed.Seed_Proc"%>
<jsp:useBean id="Seed_Proc" class="com.enuri.util.seed.Seed_Proc"  />
<%
//자동로그인 처리
String strLogintop_AutoLoginFlag = cb.GetCookie("MYINFO","AUTOLOGIN");
String strLogintop_AutoLoginId = cb.GetCookie("MYINFO","AUTOLOGINID");
boolean isLogintop_AutoLoginOk = false;

String domainLoginId = "";
String domainLogoutYN = "";
Cookie[] cookiesDomain = request.getCookies();
if(cookiesDomain!=null) {
	for(int ci=0; ci<cookiesDomain.length; ci++) {
		try {
			if(cookiesDomain[ci]!=null && cookiesDomain[ci].getName().equals("DOMAIN_LOGIN_ID")) {
				if(cookiesDomain[ci].getValue().length()>12) {
					domainLoginId = Seed_Proc.DePass_Seed(cookiesDomain[ci].getValue());
				} else {
					domainLoginId = cookiesDomain[ci].getValue();
				}
			}
			if(cookiesDomain[ci]!=null && cookiesDomain[ci].getName().equals("DOMAIN_LOGOUT_YN")) {
				domainLogoutYN = cookiesDomain[ci].getValue();
			}
		} catch(Exception e) {}
	}
}

// 다른 서브 도메인에서 로그아웃을 햇을 경우 로그 아웃시킴
if(!cb.GetCookie("MEM_INFO","USER_ID").equals("") && domainLogoutYN.equals("Y")) {
	cb.SetCookie("MEM_INFO", "USER_ID", "");
	cb.SetCookie("MEM_INFO", "USER_NAME", "");
	cb.SetCookie("MEM_INFO", "USER_NICK", "");
	cb.SetCookie("MEM_INFO", "USER_GROUP", "");
	cb.SetCookie("MEM_INFO", "USER_BROWSERNO", "");
	cb.SetCookie("MEM_INFO", "USER_REGDATE", "");
	cb.SetCookie("MEM_INFO", "LOGIN_RECONFIRM", "");
	cb.SetCookie("MEM_INFO", "ADULT", "");
	cb.SetCookie("MEM_INFO", "LOGIN_NICK", "");
	cb.SetCookie("MEM_INFO", "SNSTYPE", "");
	cb.SetCookieExpire("MEM_INFO",0);

	cb.setCookie_One("LSTATUS", "");
	cb.SetCookieExpire("LSTATUS",0);

	cb.SetCookie("SDU", "SHOP_ID", "");
	cb.SetCookie("SDU", "SHOP_CODE", "");
	cb.SetCookie("SDU", "SHOP_NAME", "");
	cb.SetCookie("SDU", "SHOP_OPT", "");
	cb.SetCookie("SDU", "SHOP_AUTH", "");
	cb.SetCookie("SDU", "SHOP_GRADE", "");
	cb.SetCookie("SDU", "SHOP_MAX_UNIT", "");
	cb.SetCookie("SDU", "SHOP_COUPON", "");
	cb.SetCookie("SDU", "ES_AGREEMENT_YN", "");
	cb.SetCookie("SDU", "SHOP_NO","");
	cb.SetCookieExpire("SDU",0);

	cb.setCookie_One("AUTO", "");
	cb.SetCookieExpire("AUTO",0);

	cb.SetCookie("CAR","DEALERID", "");
	cb.SetCookie("CAR","DEALERTYPE", "");
	cb.SetCookieExpire("CAR",0);

	cb.responseAddCookie(response);

	//자동로그인 설정상태 초기화
	cb.SetCookie("MYINFO","AUTOLOGIN","");
	cb.SetCookie("MYINFO","AUTOLOGINID","");
	cb.SetCookieExpire("MYINFO", 3600*24*30);
	cb.responseAddCookie(response);

	out.println("<script language=javascript>");
	out.println("window.location.reload();");
	out.println("</script>");
	return;
}

if(false){ //IDC이전중 로그아웃 처리 => 오픈후 true->false 변경

	cb.SetCookie("MEM_INFO", "USER_ID", "");
	cb.SetCookie("MEM_INFO", "USER_NAME", "");
	cb.SetCookie("MEM_INFO", "USER_NICK", "");
	cb.SetCookie("MEM_INFO", "USER_GROUP", "");
	cb.SetCookie("MEM_INFO", "USER_BROWSERNO", "");
	cb.SetCookie("MEM_INFO", "USER_REGDATE", "");
	cb.SetCookie("MEM_INFO", "LOGIN_RECONFIRM", "");
	cb.SetCookie("MEM_INFO", "ADULT", "");
	cb.SetCookie("MEM_INFO", "LOGIN_NICK", "");
	cb.SetCookie("MEM_INFO", "SNSTYPE", "");
	cb.SetCookieExpire("MEM_INFO",0);

	cb.setCookie_One("LSTATUS", "");
	cb.SetCookieExpire("LSTATUS",0);

	cb.SetCookie("SDU", "SHOP_ID", "");
	cb.SetCookie("SDU", "SHOP_CODE", "");
	cb.SetCookie("SDU", "SHOP_NAME", "");
	cb.SetCookie("SDU", "SHOP_OPT", "");
	cb.SetCookie("SDU", "SHOP_AUTH", "");
	cb.SetCookie("SDU", "SHOP_GRADE", "");
	cb.SetCookie("SDU", "SHOP_MAX_UNIT", "");
	cb.SetCookie("SDU", "SHOP_COUPON", "");
	cb.SetCookie("SDU", "ES_AGREEMENT_YN", "");
	cb.SetCookie("SDU", "SHOP_NO","");
	cb.SetCookieExpire("SDU",0);

	cb.setCookie_One("AUTO", "");
	cb.SetCookieExpire("AUTO",0);

	cb.SetCookie("CAR","DEALERID", "");
	cb.SetCookie("CAR","DEALERTYPE", "");
	cb.SetCookieExpire("CAR",0);

	cb.responseAddCookie(response);

	//자동로그인 설정상태 초기화
	cb.SetCookie("MYINFO","AUTOLOGIN","");
	cb.SetCookie("MYINFO","AUTOLOGINID","");
	cb.SetCookieExpire("MYINFO", 3600*24*30);
	cb.responseAddCookie(response);

}else if (cb.GetCookie("MEM_INFO","USER_ID").equals("") && ((strLogintop_AutoLoginFlag.equals("Y") && !strLogintop_AutoLoginId.equals("")) || (domainLoginId.length()>0 && !domainLogoutYN.equals("Y")))){
	Members_Data logintop_members_data = null;
	if(domainLoginId.length()>0) {
		logintop_members_data = Members_Proc.Login_Check_Free(domainLoginId); //사용자 정보
	} else {
		logintop_members_data = Members_Proc.Login_Check_Free(strLogintop_AutoLoginId); //사용자 정보
	}
	String strLogintop_userid       = "";
	String strLogintop_nickname     = "";
	String strLogintop_service_flag = "";
	String strLogintop_m_group      = "";
	String strLogintop_start_date   = "";
	String strLogintop_ap_yn        = "";
	String strLogintop_adult		= ""; //성인여부 (0:미성년자, 1:성인, 2:판단불가-판매자 또는 주민번호 없이 가입)
	String strLogintop_yyyymmdd		= "";

	if (logintop_members_data!=null){

		strLogintop_userid       = ChkNull.chkStr(logintop_members_data.getUserid());
		strLogintop_nickname     = ChkNull.chkStr(logintop_members_data.getNickname());
		strLogintop_service_flag = ChkNull.chkStr(logintop_members_data.getService_flag());
		strLogintop_m_group      = ChkNull.chkStr(logintop_members_data.getM_group());
		strLogintop_start_date   = ChkNull.chkStr(logintop_members_data.getStart_date());
		strLogintop_ap_yn        = ChkNull.chkStr(logintop_members_data.getAp_yn());
		strLogintop_yyyymmdd     = ChkNull.chkStr(logintop_members_data.getYyyymmdd());
		isLogintop_AutoLoginOk = true;

		if(strLogintop_service_flag.equals("0") || strLogintop_service_flag.equals("2") || strLogintop_service_flag.equals("3")){
	 		String strLogintop_s = DateStr.nowStr();
		 	if (strLogintop_start_date.trim().length() == 0 ){
		 		strLogintop_start_date = "2055-12-31";
		 	}else{
		 		if (strLogintop_start_date.trim().length() > 10){
		 			strLogintop_start_date = strLogintop_start_date.substring(0,10);
		 		}
		 	}
		 	int intLogintop_diff = DateUtil.getDaysDiff(strLogintop_start_date, strLogintop_s);
		 	if(strLogintop_service_flag.equals("2") &&  intLogintop_diff >0 ){
		 		//강제탈퇴 기간임
		 		isLogintop_AutoLoginOk = false;
		 	}else if (strLogintop_service_flag.equals("3") &&  intLogintop_diff >0 ){
		 		//이용정지 기간임
		 		isLogintop_AutoLoginOk = false;
		 	}
		}else if (strLogintop_service_flag.equals("1")){
			//자진탈퇴
			isLogintop_AutoLoginOk = false;
		}else if (strLogintop_service_flag.equals("4")){
		 	//해외거주자(삭제) - 해외가입 신청후 일주일내에 신분증 미제출시
			isLogintop_AutoLoginOk = false;
		}else if (strLogintop_service_flag.equals("5")){
		 	//임시비밀번호 - 비밀번호 찾기 신청후

			isLogintop_AutoLoginOk = false;
		}else if (strLogintop_service_flag.equals("6")){
		 	// 이용정지(ID도용) - 아이디 도용 신고시

			isLogintop_AutoLoginOk = false;
		}else if (strLogintop_service_flag.equals("7")){
		 	//해외거자주(가입) - 해외거주자 가입신청
			isLogintop_AutoLoginOk = false;
		}else if (strLogintop_service_flag.equals("8")){
			//휴면 계정
			isLogintop_AutoLoginOk = false;
		}
	}
	if(isLogintop_AutoLoginOk){
		int isLogintop_nowYear = ChkNull.chkInt(DateStr.nowStr().substring(0,4));
		int isLogintop_birthYear = 0;
		if(!strLogintop_yyyymmdd.equals("") && strLogintop_yyyymmdd.length()>=4){
			isLogintop_birthYear = ChkNull.chkInt(strLogintop_yyyymmdd.substring(0,4));
			if(isLogintop_nowYear-isLogintop_birthYear>=19){
				strLogintop_adult = "1";
			}else{
				strLogintop_adult = "0";
			}
		}else{
			strLogintop_adult = "2";
		}
		//자동로그인 처리
	    if(strLogintop_m_group.equals("3") || strLogintop_m_group.equals("5")){
	         cb.SetCookie(  "SDU", "SHOP_ID", strLogintop_userid);
	         cb.SetCookie(  "SDU", "SHOP_NO", Integer.toString(logintop_members_data.getShopNo()));
	         cb.SetCookie(  "SDU", "SHOP_CODE", logintop_members_data.getShopVcode());
			 cb.SetCookie(  "SDU", "SHOP_NAME", logintop_members_data.getShopName());
			 cb.SetCookie(  "SDU", "SHOP_OPT", logintop_members_data.getShopOpt());
			 cb.SetCookie(  "SDU", "SHOP_AUTH", logintop_members_data.getShopAuth());
			 cb.SetCookie(  "SDU", "SHOP_GRADE", logintop_members_data.getShopGrade());
			 cb.SetCookie(  "SDU", "SHOP_MAX_UNIT", logintop_members_data.getShopUnit());
			 cb.SetCookie(  "SDU", "SHOP_COUPON", logintop_members_data.getShopCoupon());
			 cb.SetCookie(  "SDU", "SHOP_SDU_CLASS", logintop_members_data.getShopSduClass());
			 cb.SetCookieExpire("SDU",-1);
		}

		cb.SetCookie("MEM_INFO", "USER_ID", strLogintop_userid);
		cb.SetCookie("MEM_INFO", "USER_NICK", strLogintop_nickname);
		cb.SetCookie("MEM_INFO", "USER_GROUP", strLogintop_m_group);
		cb.SetCookie("MEM_INFO", "USER_BROWSERNO", "1");
		cb.SetCookie("MEM_INFO", "USER_REGDATE", cb.GetCookie("MYINFO","TMP_ID"));
		cb.SetCookie("MEM_INFO", "AP_YN", strLogintop_ap_yn);
		cb.SetCookie("MEM_INFO", "ADULT", strLogintop_adult);
		cb.SetCookie("MEM_INFO", "SNSTYPE", new Sns_Login().getSnsDcd(strLogintop_userid));	// K/N/""
		cb.SetCookieExpire("MEM_INFO",-1);
		cb.setCookie_One(  "LSTATUS","Y");
		cb.SetCookieExpire("LSTATUS",-1);
		cb.responseAddCookie(response);

		//자동로그인 로그기록
		Log_main_Proc log_main_procPC = new Log_main_Proc();
		Log_main_Data log_main_dataPC = new Log_main_Data();
		log_main_dataPC.setLm_kind(2306);
		log_main_dataPC.setLm_userid("");
		log_main_dataPC.setLm_userip(request.getRemoteAddr());
		log_main_dataPC.setLm_category("");
		log_main_dataPC.setLm_modelno(0);
		log_main_dataPC.setLm_vcode(0);
		log_main_procPC.Log_main_Insert(log_main_dataPC);

		boolean bReturn = Members_Proc.Login_Log_Ins(strLogintop_userid, cb.GetCookie("MYINFO","TMP_ID"), request.getRemoteAddr(), 1);

		out.println("<script language=javascript>");
		out.println("window.location.reload();");
		out.println("</script>");
		return;
	}else{
		//자동로그인 불가=>자동로그인 설정상태 초기화

		cb.SetCookie("MYINFO","AUTOLOGIN","");
		cb.SetCookie("MYINFO","AUTOLOGINID","");
		cb.SetCookieExpire("MYINFO", 3600*24*30);
		cb.responseAddCookie(response);
	}
}
%>