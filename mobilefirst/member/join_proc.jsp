<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@ page import="com.enuri.bean.knowbox.Know_box_Proc"%>
<jsp:useBean id="Know_box_Proc" class="com.enuri.bean.knowbox.Know_box_Proc" scope="page" />
<%@ page import="com.enuri.bean.main.Goods_BBS_Proc"%>
<jsp:useBean id="Goods_BBS_Proc" class="com.enuri.bean.main.Goods_BBS_Proc" scope="page" />
<%@ page import="com.enuri.bean.log.Log_main_Proc"%>
<%@ page import="com.enuri.bean.log.Log_main_Data"%>
<%@ page import="com.enuri.util.seed.Seed_Proc"%>
<jsp:useBean id="Seed_Proc" class="com.enuri.util.seed.Seed_Proc"/>
<%@ page import="com.enuri.bean.member.Join_Data"%>
<%@ page import="com.enuri.bean.member.Join_Proc"%>
<jsp:useBean id="Join_Data" class="com.enuri.bean.member.Join_Data"/>
<jsp:useBean id="Join_Proc" class="com.enuri.bean.member.Join_Proc"/>
<%@ include file="/member/join/IncCheckPass.jsp"%>
<!-- 회원가입 공통변수 -->
<%@ include file="/member/join/joinConfig.jsp"%>
<%
request.setCharacterEncoding("UTF-8");
String strApp = ChkNull.chkStr(request.getParameter("app"),"");
//APP
	Cookie[] carr = request.getCookies();
	try {
		for(int i=0;i<carr.length;i++){
		    if(carr[i].getName().equals("appYN")){
		    	strApp = carr[i].getValue();
		    }
		}
	} catch(Exception e) {
	}
setJoinUrlParameter(strApp);
//out.println("strApp : "+strApp);
%>
<%!
// 약관 동의
//static final String AGREE_URL = "https://dev.enuri.com/mobilefirst/member/agree.jsp";
static final String AGREE_URL = "https://m.enuri.com/mobilefirst/member/agree.jsp";
// 회원 가입 페이지



// dev, real 분기처리 필요함.;
//static final String JOIN_URL = "https://dev.enuri.com/mobilefirst/member/join.jsp";
static final String JOIN_URL = "/mobilefirst/member/join.jsp";



static String APP_PARAMETER = "";
//static final String BACK_SCRIPT = "location.href='" + JOIN_URL + APP_PARAMETER + "'";

public void setJoinUrlParameter(String appYn) {

 if(appYn != null && appYn.length() > 0)
	 	APP_PARAMETER = "?app=" + appYn;
}

public String getAlertScript(String msg) {
	String script = "<script>"
				+ "alert('" + msg + "');"
				//+ "alert('" + JOIN_URL + APP_PARAMETER + "');"
				+ "location.href='https://m.enuri.com/mobilefirst/member/join.jsp"+ APP_PARAMETER +"'"
				//+ "location.href='https://dev.enuri.com/mobilefirst/member/join.jsp"+ APP_PARAMETER +"'"
				//+ BACK_SCRIPT
				+ "</script>";
	return script;
}

%>
<%
/***************************************************
이 파일은 SSL 서버에 업로드해야 합니다.
***************************************************/
//IDC이전 서비스 다운시

//if(false) return;
    String rtnurl = ConfigManager.RequestStr(request, "rtnurl", "https://m.enuri.com/member/login/login.jsp");  // 리턴 url
    //String rtnurl = ConfigManager.RequestStr(request, "rtnurl", "https://dev.enuri.com/member/login/login.jsp");  // 리턴 url
    if(rtnurl.equals("")){
          //rtnurl = join_ENURI_COM;
          rtnurl = "https://m.enuri.com/member/login/login.jsp";
    	  //rtnurl = "https://dev.enuri.com/member/login/login.jsp";
    }
    // 필수입력정보
    String strName = ConfigManager.RequestStr(request, "name", ""); // 이름
    String strID = ConfigManager.RequestStr(request, "user_id", ""); // 아이디
    String strPass = ConfigManager.RequestStr(request, "pass1", "");   // 비밀번호
    String strEmail = ConfigManager.RequestStr(request, "user_email", "");   // 개편전에는 이메일아이디, 도메인을 각각 받았다.
    String strRegGate = "1";   // 가입경로(0:pc, 1:모바일, 2:신차모바일). 모바일은 강제로 1으로 지정.
    // 인증정보
    String strCertify = ConfigManager.RequestStr(request, "certify", ""); // 인증구분(1:간편인증, 2:본인인증-e머니적립대상)

    String strTel1 = ConfigManager.RequestStr(request, "tel1", "");
    String strTel2 = ConfigManager.RequestStr(request, "tel2", "");
    String strTel3 = ConfigManager.RequestStr(request, "tel3", "");

    String strConfCIkey = ConfigManager.RequestStr(request, "conf_ci_key", "");
    String strConfDIkey = ConfigManager.RequestStr(request, "conf_di_key", "");
 	// CI, DI값 복호화
 	strConfCIkey = Seed_Proc.DePass(ChkNull.chkStr(strConfCIkey));
 	strConfDIkey = Seed_Proc.DePass(ChkNull.chkStr(strConfDIkey));
    String strConfPhoneco = ConfigManager.RequestStr(request, "conf_phoneco", "");
    String strConfYYYYMMDD = ConfigManager.RequestStr(request, "MEMJOIN_BIRTHDATE", "");
    String strConfSex = ConfigManager.RequestStr(request, "MEMJOIN_GENDER", "");

    // 선택상세정보
    String strNickname = ConfigManager.RequestStr(request, "nickname", "");
    String strSexUser = ConfigManager.RequestStr(request, "sex_user", "");
    String strYYYYMMDDUser = ConfigManager.RequestStr(request, "yyyymmdd_user", "");

    String strZip = ConfigManager.RequestStr(request, "newzip", "");
    String strAddr1 = ConfigManager.RequestStr(request, "r_address1", "");
    String strAddr2 = ConfigManager.RequestStr(request, "r_address2", "");

    String strNewsFlag = ConfigManager.RequestStr(request, "mailing", "0");
    String strAdSmsYn = ConfigManager.RequestStr(request, "ad_sms_yn", "N");
	String strAdEmailYn = ConfigManager.RequestStr(request, "ad_email_yn", "N");
    String strMarketingYn = ConfigManager.RequestStr(request, "marketing_use_yn", "N");
    String strUserIP = ConfigManager.szConnectIp(request);     // 유저 IP

    String strAdYn = ConfigManager.RequestStr(request, "ad_yn", "N");		//sms/이메일 수신 통합
	String strPinYn = ConfigManager.RequestStr(request, "pin_yn", "N");		//개인정보 수집 및 이용안내 (선택)

	//sms/이메일 수신 통합 체크
	if(strAdYn.equals("Y")){
		strAdSmsYn = "Y";
		strAdEmailYn = "Y";
	}

	String log_default = "strID : " + strID + "\n"
              + "strName : " + strName  + "\n"
              + "strPass : " + strPass  + "\n"
              + "strEmail : " + strEmail  + "\n"
              + "strRegGate : " + strRegGate  + "\n";
	String log_optional = "strNickname : " + strNickname + "\n"
               + "strSexUser : " + strSexUser + "\n"
               + "strYYYYMMDDUser : " + strYYYYMMDDUser + "\n"
               + "strZip : " + strZip + "\n"
               + "strAddr1 : " + strAddr1 + "\n"
               + "strAddr2 : " + strAddr2 + "\n"
               + "strNewsFlag : " + strNewsFlag + "\n"
               + "strAdSmsYn : " + strAdSmsYn + "\n"
               + "strAdEmailYn : " + strAdEmailYn + "\n"
               + "strMarketingYn : " + strMarketingYn + "\n"
               + "strUserIP : " + strUserIP + "\n";
	/* System.out.println(log_default);
	System.out.println(log_optional); */



     // 리퍼러 체크
     boolean bRefererOk = false;
     String header = StringUtils.defaultString(request.getHeader("referer"), "");
     bRefererOk = header.contains(JOIN_URL);
     if(!bRefererOk){
           out.println(getAlertScript("잘못된 경로로 이 페이지에 접근하셨습니다!"));
           return;
     }
     // 이메일 중복체크
     strID = strID.toLowerCase();
     strEmail = strEmail.toLowerCase();   // 소문자 처리
     if(strEmail.equals("") ) {
           out.println(getAlertScript("잘못된 경로로 이 페이지에 접근하셨습니다!!"));
           return;
     }else if (Integer.parseInt( Join_Proc.Check_Email(strEmail)) != -1){// 1이면 이메일이 있음, -1이면 없음.
			out.println(getAlertScript("이메일을 확인해주세요!"));
			return;
     }

     // 세션체크
     //boolean bSessOk = false;
     // 실제 입력한 핸드폰 번호와 저장하는 번호가 같은지 세션에 저장한 암호화된 값과 비교함.
     HttpSession ttsession = request.getSession(true);
     String errMsgCertify = ""+strCertify+" 인증에 성공하셔야 회원가입이 가능합니다.\\n본인인증 혹은 간편인증 중 선택하여 인증하세요.";

     if(strCertify.equals("1")){
      ttsession.setAttribute("MEMJOIN_CETIFY", "1");
     }else if(strCertify.equals("2")){
    	 ttsession.setAttribute("MEMJOIN_CETIFY", "2");
     }else if(strCertify.equals("0")){
    	 ttsession.setAttribute("MEMJOIN_CETIFY", "0");
     }else{
    	 out.println(getAlertScript(errMsgCertify));

    	 return;
     }


    String hpConf = (String) ttsession.getAttribute("MEMJOIN_HP_CONF");
    String cetify = (String) ttsession.getAttribute("MEMJOIN_CETIFY");
    String di = (String) ttsession.getAttribute("MEMJOIN_DI");
    String ci = (String) ttsession.getAttribute("MEMJOIN_CI");
    if( ttsession.getAttribute("MEMJOIN_DI") != null && ttsession.getAttribute("MEMJOIN_CI") != null ){
		if(strCertify.equals("2")){
			di = (String)ttsession.getAttribute("MEMJOIN_DI");
			ci = (String)ttsession.getAttribute("MEMJOIN_CI");
			// 본인인증 한 경우 nice에서 받은 데이터로 세팅. 이름, 인증생년월일, 인증성별
			strName = (String)ttsession.getAttribute("MEMJOIN_NAME");
			strConfYYYYMMDD = (String)ttsession.getAttribute("MEMJOIN_BIRTHDATE");
			strConfSex = (String)ttsession.getAttribute("MEMJOIN_GENDER");

			/* if(strConfDIkey.equals(di) && strConfCIkey.equals(ci)){
				bSessOk = true;
				//out.println("bSessOk_MEMJOIN_DICI: " + bSessOk);
			}	 */
		}
    }
    String strTel = strTel1 + strTel2 + strTel3;

     String log_phone = "hpConf : " + hpConf + "\n"			//01098259967
    		 + "strTel1 : " + strTel1 + "\n"
             + "strTel2 : " + strTel2 + "\n"
             + "strTel3 : " + strTel3 + "\n"
             + "strTel : " + strTel + "\n"					//01098259967
             + "cetify : " + cetify + "\n"					//1
             + "cetify : " + strCertify + "\n"				//1
             + "strConfDIkey : " + strConfDIkey + "\n"		//
             + "di : " + di + "\n"							//null
             + "ci : " + ci + "\n";							//null
     
     if(hpConf == null || cetify == null) {
           out.println(getAlertScript(errMsgCertify + "_1"));
           return;
     } else if(cetify.equals("2") && !(strConfDIkey.equals(di) && strConfCIkey.equals(ci))) {
           out.println(getAlertScript(errMsgCertify + "_4"+strConfDIkey + " , "+di));
           return;
     }


     // 필수값 체크
     String errMsg = "";

     /* System.out.println(strID);
     System.out.println(strName);
     System.out.println(strPass);
     System.out.println(strEmail);
     System.out.println(strRegGate); */

     if( strID.equals("") || strName.equals("") || strPass.equals("") || strEmail.equals("") || strRegGate.equals("") ){
           errMsg = "필수입력 항목이 모두 정상 입력되었는지 확인해주세요.";
     } else if(CvtStr.isNumeric(strID.substring(0,1)) || !CvtStr.isValidID(strID)){
           errMsg = "아이디의 첫글자는 반드시 영문이어야 하고, \\n영문과 숫자만 사용 가능합니다.";
     } else if (!getCheckSimple(strID, strPass).equals("0")){
    	 errMsg = "8~15자 영대, 소문자, 숫자, 특수문자 중 3가지를 조합해주세요.\n사용 가능한 특수문자 :  ! @ # $ % ^ & * ( ) , ";
     } else if (Integer.parseInt(Join_Proc.Check_ID(strID)) != 0) {
           errMsg = "사용할 수 없는 아이디 입니다.";
     } else if (Join_Proc.getDataCertifyPhone(strTel1, strTel2, strTel3, "") && cetify.equals("1")) {
           errMsg = "이미 등록된 전화번호입니다.\\n다른 번호를 입력하세요.";
     }
     if(!errMsg.equals("")){
           out.println(getAlertScript(errMsg));
    	 return;
     }
     //디비 저장


    Join_Data join_member = new Join_Data();

	join_member.setUserid(strID);
	join_member.setName(strName);
	join_member.setPassword(strPass);
	join_member.setM_email(strEmail);
	join_member.setReg_gate(strRegGate);
	join_member.setCetify(strCertify);
	join_member.setTel1_p(strTel1);
	join_member.setTel2_p(strTel2);
	join_member.setTel3_p(strTel3);
	join_member.setConf_ci_key(strConfCIkey);
	join_member.setConf_di_key(strConfDIkey);
	join_member.setConf_yyyymmdd(strConfYYYYMMDD);
	join_member.setConf_sex(strConfSex);
	join_member.setConf_phoneco(strConfPhoneco);
	join_member.setNickname(strNickname);
	join_member.setSex_user(strSexUser);
	join_member.setYyyymmdd_user(strYYYYMMDDUser);
	join_member.setZip(strZip);
	join_member.setM_juso(strAddr1);
	join_member.setS_juso(strAddr2);
	join_member.setNews_flag(strNewsFlag);
	join_member.setAd_sms_yn(strAdSmsYn);
	join_member.setAd_email_yn(strAdEmailYn);
	join_member.setMarketing_use_yn(strMarketingYn);
	join_member.setUserip(strUserIP);
	join_member.setPinfca_yn(strPinYn);


	boolean isSuccess = Join_Proc.InsertData2017(join_member);

    /*  boolean isSuccess = Join_Proc.InsertData2017(strID, strName, strPass, strEmail, strRegGate,    // 필수 값 id, 이름, 비밀번호, 이메일
                                                  strCertify, strTel1, strTel2, strTel3, strConfCIkey, strConfDIkey, strConfPhoneco,   //휴대폰 인증
                                                  strNickname, strSexUser, strYYYYMMDDUser,  //닉네임, 성별, 생년월일
                                                  strZip, strAddr1, strAddr2,  //주소
                                                  strNewsFlag, strAdSmsYn, strAdEmailYn, strMarketingYn, strUserIP);     //광고 수신동의, ip */
                // INSERT 결과에 따라서 아래 로직 처리.
     if(isSuccess){
           //회원 가입이 완료 되면 session 정보를 삭제 한다.
          //즉, 본인인증 간편인증 둘 다 시도할 경우, 마지막에 성공한 인증방법만 유효
           if(ttsession.getAttribute("MEMJOIN_HP_CONF") != null) {
                ttsession.removeAttribute("MEMJOIN_HP_CONF");
                ttsession.removeAttribute("MEMJOIN_CETIFY");
                ttsession.removeAttribute("MEMJOIN_DI");
                ttsession.removeAttribute("MEMJOIN_CI");
           }
           %>
           <!-- 얼럿 메시지 보여주는 페이지로 이동. 구글관련 작업도 포함. -->
           <script>(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)})(window,document,'script','//www.google-analytics.com/analytics.js','ga');ga('create', 'UA-52658695-3', 'auto');</script>
           <script language="JavaScript" src="https://www.googleadservices.com/pagead/conversion.js"></script>
           <noscript>
           <img height=1 width=1 border=0 src="https://www.googleadservices.com/pagead/conversion/1069433239/?value=1&label=Signup&script=0">
           </noscript>
           <form name="frmTemp" action="/login/LoginLayer_Proc_2010.jsp" method="post">
           <input type="hidden" name="loginid"  value="<%=strID %>">
           <input type="hidden" name="pass" value="<%=strPass %>">
           <input type="hidden" name="cmd" value="MEMBERJOIN">
           <input type="hidden" id="app" name="app" value="<%=strApp%>"/>
           </form>
           <script>
           var vApp = "<%=strApp%>";
           // 애드브릭스 적용: 회원가입_완료
           if(vApp == "Y"){
	           var strEvent = "member_complete";
	           try{
	               if(window.android){            // 안드로이드
	                   //window.android.igaworksEventForApp(strEvent);
	                   window.android.airbridgeEventForApp("airbridge.user.signup","member","enuri","");
	               }else{                                                        // 아이폰에서 호출
//  	                   window.location.href = "enuriappcall://igaworksEventForApp?strEvent="+ strEvent +"";
	               }
		       }catch(e){}
           } 

			//로그 추가 2019-12-24
			var vOs_type = "";
			if(vApp == "Y"){
				if(navigator.userAgent.indexOf("Android") > -1){
					 vOs_type = "MAA";
				 }else{
					 vOs_type = "MAI";
				 }
			}else{
				if(navigator.userAgent.indexOf("Android") > -1){
					 vOs_type = "MWA";
				 }else{
					 vOs_type = "MWI";
				 }
			}
			//Ga추가
			ga('send', 'event', 'members', 'join_'+vOs_type);

           if(vApp == "Y"){
	           var strEvent = "member_complete";
               if(window.android){            // 안드로이드
            	   alert("에누리 가격비교 회원이 되신 것을 축하드립니다.^^");
	       			document.location.href ="close://"; 
               }else{                                                        // 아이폰에서 호출
            	   alert("에누리 가격비교 회원이 되신 것을 축하드립니다.^^\nX버튼을 클릭하여 창을 닫아주세요");
            	   //window.location.href = "enuriappcall://igaworksEventForApp?strEvent="+strEvent+"&close://"
  		    	   window.location.href = "enuriappcall://airbridgeEventForApp?p1=airbridge.user.signup&p2=member&p3=enuri&p4=&close://"
               }
           }else{
        	   //모바일 웹 일반 회원가입 ga
        	   ga('send', 'event', 'mf_join_new', '회원가입', 'Join_complete_enuri');

          	   document.location.href="https://m.enuri.com/member/login/login.jsp";
        	   //document.location.href="https://dev.enuri.com/member/login/login.jsp";
           }
           </script>
     <% } else { %>
           <script>
                <%-- document.location.href="<%=rtnurl%>"; --%>
                document.location.href="https://m.enuri.com/member/login/login.jsp";
                //document.location.href="https://dev.enuri.com/member/login/login.jsp";
           </script>
     <%
     }
%>
