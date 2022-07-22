<%@ page import="com.enuri.bean.main.brandplacement.DBDataTable"%>
<%@ page import="com.enuri.util.seed.Seed_Proc"%>
<%@ page import="com.enuri.bean.main.brandplacement.DBWrap"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.mobile.Mobile_Push_Proc"%>
<%@ page import="com.enuri.util.date.DateUtil"%>
<%@ page import="java.text.ParseException"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="com.enuri.util.seed.Seed_Proc"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<jsp:useBean id="Members_Data"
	class="com.enuri.bean.knowbox.Members_Data" />
<jsp:useBean id="Members_Proc"
	class="com.enuri.bean.knowbox.Members_Proc" />
<jsp:useBean id="Seed_Proc" class="com.enuri.util.seed.Seed_Proc" />
<jsp:useBean id="Mobile_Push_Proc"
	class="com.enuri.bean.mobile.Mobile_Push_Proc" scope="page" />
<%@ page import="com.enuri.bean.mobile.PDManager_Proc"%>
<%@ page import="com.enuri.bean.mobile.PDManager_PD_Data"%>
<%@ page import="com.enuri.bean.mobile.PDManager_T1_Data"%>
<%@ page import="com.enuri.bean.member.Login_Data"%>
<%@ page import="com.enuri.bean.member.Login_Proc2"%>
<jsp:useBean id="Login_Data" class="com.enuri.bean.member.Login_Data"  />
<jsp:useBean id="Login_Proc2" class="com.enuri.bean.member.Login_Proc2"  />
<%@page import="org.json.JSONObject"%>
<%@page import="com.enuri.bean.member.AppleSignIn"%>
<%@page import="com.enuri.bean.member.Sns_Login"%>
<%@page import="com.enuri.bean.member.SnsType"%>

<%
System.out.println("11111");
	//20171113 손진욱 t1 pd 모듈
	PDManager_Proc pdmanager = new PDManager_Proc();
	PDManager_PD_Data pdData = pdmanager.chkPD(request);
	System.out.println("2222");
//	out.println(pdData.toString());
	String strType = "";
	String strDate = "";
	String strUserdata = "";
	String strFdate = ""; //만료일 = strDate + 28일
	String strApptype = "";
	String strAppNumber = "";
	String strEnuriId = "";
	String sNickname = "";
	String strEnuriPw = "";
	boolean blUpdate = false;
	int intSeqno = 0;
	String strT1 = "";
	String strT1_Rsa = "";
	String strR_code = "";
	String strR_msg = "";
	String strR_id = "";
	String ver = "";
	int iVer = 0;

	boolean blLogin_chk = false;
	boolean bFailLog = false;

	String errCode = "";

	int intLoginFail2 = 0;
	boolean bMyLock = false;
	boolean bNoId = false;

	int version = 0;

	JSONObject jsonObject = new JSONObject();
	boolean snslogin = false;
	boolean timeCheck = false;

	String strAppleEnuri = "";
	String strAppleEnuri2 = "";
// 	System.out.println("<br>******************************requestLifeStyle.jsp***************************************");
// 	System.out.println("<br>authId_0=="+(String) session.getAttribute("authId"));
// 	System.out.println("<br>pdData=="+pdData);
// 	System.out.println("<br>pdData.isData()=="+pdData.isData());
// 	System.out.println("<br>pdData.isDataApple()=="+pdData.isDataApple());
	
	if (pdData != null && (pdData.isData() || pdData.isDataApple()) && !"".equals(pdData.getTimes())) {
		// pd 데이터 시간 체크
		Calendar pdTime = Calendar.getInstance();
		pdTime.setTime(new SimpleDateFormat("yyyyMMddHHmmss", Locale.KOREA).parse(pdData.getTimes()));
		Calendar now = Calendar.getInstance();

		// 앱 pd 데이터가 1시간 이내 데이터일 때
		if (now.getTimeInMillis() - pdTime.getTimeInMillis() <= 3600000) {
			timeCheck = true;
		}
	System.out.println("now.getTimeInMillis() >> " +now.getTimeInMillis());
	}
	String snsToken = ChkNull.chkStr(request.getParameter("snstoken"));
	String strAt1 = ChkNull.chkStr(request.getParameter("at"));		//앱에서 온 애플토큰
	String isJoin = ChkNull.chkStr(request.getParameter("isJoin"),"N");	//애플 회원가입에서 바로 넘어왔는지 체크

	if (timeCheck) {
		// SNS 로그인
		Sns_Login snsLogin = new Sns_Login();
		SnsType snsDcd = SnsType.NONE;

		if (pdData != null && pdData.isData()) {
			snsDcd = snsLogin.getSnsType(pdData.getSnsDcd());
			if (SnsType.NONE != snsDcd) {
				String snsId = snsLogin.getSnsInfo(snsDcd, snsToken);
				snslogin = snsId.equals(pdData.getEnuri_id());
			}
		}

		if (pdData != null && pdData.isDataApple()) {
			snsDcd = snsLogin.getSnsType("APPLE");
			String strApple = pdData.getAppleId(); //앱에서 넘어온 애플아이디
			String authId = isJoin.equals("Y") ? strApple : (String) session.getAttribute("authId"); //애플 유효성 검사 후 넘어온 appleId

// 			System.out.println("<br>authId_1=="+authId);
// 			System.out.println("<br>strApple=="+strApple);
			if (SnsType.NONE != snsDcd && !"".equals(strApple) && authId !=null && authId.equals(strApple)) {
				strAppleEnuri = snsLogin.getSnsEnuriId(strApple, SnsType.APPLE);    //앱에서 넘어온 애플아이디로 회원디비에서 에누리 아이디 가져온다
				if(!strAppleEnuri.equals("")){
					snslogin = true;
				}
			}
		}

		if (pdData != null && pdData.isDataLogin() || snslogin) {
			strType = pdData.getAppid();
			strDate = pdData.getTimes();
			strUserdata = pdData.getUuid();
			strEnuriId = pdData.getEnuri_id();
			strEnuriPw = pdData.getEnuri_pw();
			ver = request.getParameter("version");

			String os;

			if (ver == null){
				ver = "0.0.0";
			}

			if (ver.length() >= 5) {
				try {
					version = Integer.parseInt(ver.substring(0, 1)) * 100 + Integer.parseInt(ver.substring(2, 3)) * 10 + Integer.parseInt(ver.substring(4, 5));
				} catch (Exception e) {
				}
			}

			if(strUserdata.equals("")){
				bNoId = true;
			}

			if (!strType.equals("") && strType.indexOf("A") > -1) {
				strApptype = "A";
				strAppNumber = strType.substring(1);
			} else if (!strType.equals("") && strType.indexOf("I") > -1) {
				strApptype = "I";
				strAppNumber = strType.substring(1);
			}

			if (!strDate.equals("")) { //date가 있으면 fire date 생성
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");

				Date dayToday = new Date();

				cal.setTime(dayToday);
				cal.add(Calendar.DATE, 28);
				cal.add(Calendar.HOUR, 2);
				cal.add(Calendar.MINUTE, 30);
				cal.add(Calendar.SECOND, 11);

				strFdate = sdf.format(cal.getTime());
			}
	 		//회원여부 확인
			if (snslogin) {
				// SNS 로그인
				if(!strAppleEnuri.equals("")){
					strEnuriId = strAppleEnuri;
				}
				Members_Data members_data = snsLogin.Login_Check(strEnuriId, snsDcd);
				strEnuriId = members_data.getUserid();
				sNickname = members_data.getNickname();
				errCode = ChkNull.chkStr(members_data.getErrCode());
			} else {
			 	Members_Data members_data = Members_Proc.Login_Check(strEnuriId, strEnuriPw); //사용자 정보
			 	sNickname = members_data.getNickname();

				errCode = ChkNull.chkStr(members_data.getErrCode());
			}
			jsonObject.put("userid", strEnuriId);				// 에누리 사용자 ID
			jsonObject.put("snslogin", snsDcd.getStrValue());	// K/N
			jsonObject.put("nickname", sNickname);

			intLoginFail2 = Login_Proc2.getMyLoginFail(strEnuriId);
			bMyLock = Login_Proc2.getMyLockStatus(strEnuriId);
			int intCaptchaLimit = 0;
			int intLockLimit = 0;

		    Login_Data login_limit = null;
		    login_limit = Login_Proc2.getInfo();

		    intCaptchaLimit = login_limit.getCaptcha_limit();
		    intLockLimit = login_limit.getLock_limit();

			if(!bNoId){
		    	if(bMyLock){											//계정잠금 --> 잠금처리 된 상태
					blLogin_chk = false;
				}else if(intLoginFail2 >= intLockLimit  ) {	//계정잠금 --> 잠금처리는 아직 안된 상태, 이번이 잠금횟수에 걸림!
					boolean bLoginFail2 = Login_Proc2.Login_Log_lock(strEnuriId, "1");		//잠금처리
					blLogin_chk = false;
				}else if (errCode.trim().length() == 0) {  //정상
					//bFailLog = true;
					intSeqno = Mobile_Push_Proc.chk_reward_request_allapp(strUserdata, strEnuriId, strAppNumber);

					if (intSeqno > 0) {
						//update
						blUpdate = Mobile_Push_Proc.updatePush_reward(strDate, strFdate, intSeqno);
					} else {
						//IOS일때 seqno 없을때. token table에 insert를 한다
						//이리로 오는 경우는 ios 뿐이 없다  아니면 안드로이드 푸시 키 못받은 경우 들어오겠네
						//int vReturn = Mobile_Push_Proc.getPushChk2(strUserdata, "");
						int vReturn = Mobile_Push_Proc.getPushChk3(strUserdata, "", strAppNumber, strApptype);

						if (vReturn == 1) { //insert
							//boolean vReturn2 = Mobile_Push_Proc.insertPush("1001", strApptype, "ios_tokenpass", "ios_arnpass", strUserdata, strEnuriId, "", "3.0.0");
							boolean vReturn2 = Mobile_Push_Proc.insertPush(strAppNumber, strApptype, "ios_tokenpass",
									"ios_arnpass", strUserdata, strEnuriId, "", "3.0.5.00");//2016/04/08 릴리즈
						} else if (vReturn > 1) {
							//boolean vReturn2 = Mobile_Push_Proc.updatePush4(vReturn, "1001", strApptype, "ios_tokenpass", "ios_arnpass", strUserdata, strEnuriId, "", "3.0.0");
							boolean vReturn2 = Mobile_Push_Proc.updatePush6(vReturn, strAppNumber, strApptype, "", "",
									strUserdata, strEnuriId, "", "");
						}

						intSeqno = Mobile_Push_Proc.chk_reward_request(strUserdata, strEnuriId);

						blUpdate = Mobile_Push_Proc.updatePush_reward(strDate, strFdate, intSeqno);
					}

					//out.println("blUpdate>>>"+blUpdate +"<br>");

					//t1 : rsa256(request_date+fire_date+||+enuri_id)

					if (blUpdate) {
						//로그인정보 추가
						// 로그인 아이디 저장
						strR_id = Seed_Proc.EnPass_Seed(strEnuriId);
						strT1 = strDate + "||" + strFdate + "||" + strEnuriId + "||" + strUserdata;
						//RSA생성
						strT1_Rsa = pdmanager.makeT1(strT1);
						//out.println("strR_t12>>>"+strR_t1+"<br>");
						//out.println("strT1>>>"+strT1+"<br>");
						//out.println("strR_t1>>>"+strR_t1+"<br>");
						//out.println("strT1_Rsa_decrypt>>>"+rsa.decryptByPrivate_mobile(strT1_Rsa)+"<br>");
					}
					blLogin_chk = true;
				}
			}
		}
	}

	/*
	구분 					code 				message 							비고
	1 	성공 					100 				ok 　
	2 	data오류 				200 				data가 잘못 되었습니다.			RSA 오류 　
	3 	request 오류 			300 				data를 조회할 수 없습니다. 		입력값 오류
	4 	server 오류 			400 				data를 조회할 수 없습니다. 		서버 오류
	5 	Login  오류 			500 				로그인정보가 잘못되었습니다.			아이디비번오류
	6	휴면상태				600					휴면상태로 전환되었습니다.			휴면상태
	7	탈퇴회원				700					탈퇴하신 회원입니다.				탈퇴상태

	6 HTTS 에서만 노출
	 */

	String strUrl = request.getRequestURL().toString();

	boolean isHttps = false;

	if (strUrl.startsWith("https://")) {
		isHttps = true;
	}

	if (!timeCheck){
		// 앱 pd 데이터가 1시간 초과 데이터일 때
		strR_code = "500";
		strR_msg = "단말기의 날짜 및 시간이 맞지 않습니다.";
	}else if(bNoId){
		strR_code = "500";
		strR_msg = "ID 또는 비밀번호가 일치하지 않습니다.";
		strR_id = "";
		strT1_Rsa = "";
	}else if (blLogin_chk && blUpdate && strT1 != null && !strT1.equals("")) {
		strR_code = "100";
		strR_msg = "ok";
		session.removeAttribute("authId"); //애플 아이디 세션 삭제
		if(strApptype.equals("I") && strAt1.equals("")){
			String strAppleYn = "N";
			Sns_Login snsLogin = new Sns_Login();
			strAppleEnuri2 = snsLogin.getSnsEnuriId2(strEnuriId, SnsType.APPLE);    //에누리 아이디로 애플아이디 연동이 되어있는지 확인
// 			System.out.println("<br>strAppleEnuri2=="+strAppleEnuri2);

			if(strAppleEnuri2 != null && strAppleEnuri2.length() > 0) strAppleYn = "Y";

// 			System.out.println("<br>appleYn=="+strAppleYn);
			jsonObject.put("appleYn", strAppleYn);
		}
	} else if (errCode.equals("08") && isHttps) {
		strR_code = "600";
		strR_msg = "님은%5Cn최근 1년 간 로그인 이력이 없는 회원으로,%5Cn휴면 상태로 전환되었습니다.";
		if(version <= 340){   //휴면2 예외처리
			strR_code = "500";
			strR_msg = "고객님의 계정은 휴면 상태로 전환되었습니다. PC 또는 모바일 웹페이지로 로그인 하신 후 휴면 해제를 해주세요.";
		}
	} else if (errCode.equals("01") || errCode.equals("011")) {
		strR_code = "700";
		strR_msg = "탈퇴하신 회원 입니다.";
	} else if (!blLogin_chk) {
		strR_code = "500";
		if (errCode.equals("05") && !bMyLock) {
			strR_msg = "임시 비밀번호가 발급된 상태이므로\nPC환경에서 비밀번호를 변경해 주세요.";
		} else {

			//50회가 넘어간다면! --> 잠금처리
			if(bMyLock){										//계정잠금 --> 잠금처리 된 상태
				strR_msg = "의심스러운 로그인 활동이 감지되어 "+strEnuriId+"계정이 일시적으로 잠금 처리되었습니다. 해제하시려면 고객센터로 문의주세요.";
			//}else if(intLoginFail2 >= intLockLimit  ) {	//계정잠금 --> 잠금처리는 아직 안된 상태, 이번이 잠금횟수에 걸림!
			//	boolean bLoginFail2 = Login_Proc2.Login_Log_lock(strEnuriId, "1");		//잠금처리
			//	strR_msg = "의심스러운 로그인 활동이 감지되어 "+strEnuriId+"계정이 일시적으로 잠금 처리되었습니다. 해제하시려면, '해제하기' 또는 고객센터로 문의주세요.";
			}else{
				strR_msg = "ID 또는 비밀번호가 일치하지 않습니다.";
			}
			//id가 회원정보에 있으면 fail_log, fail_sum 쌓아준다!
			Login_Data lp = null;
			lp = Login_Proc2.getEmail(strEnuriId) ;
			if(lp == null){
				bFailLog = false;
			}else{
				bFailLog = true;
			}

			if(bFailLog){
				boolean bLoginFail = Login_Proc2.Login_Log_fail(strEnuriId, ConfigManager.szConnectIp(request), "MA"+strApptype, strUserdata);
			}
		}
	} else if (strType.equals("") || strApptype.equals("") || strUserdata.equals("") || strEnuriId.equals("")
			|| intSeqno == 0 || !blUpdate) {
		strR_code = "200";
		strR_msg = "잘못된 data입니다.";
	} else if (blUpdate && strT1 != null && strT1.equals("")) {
		strR_code = "300";
		strR_msg = "data를 조회할 수 없습니다.";
	} else {
		strR_code = "400";
		strR_msg = "data를 조회할 수 없습니다.";
	}
	/* if (strUrl.contains("dev")) {
		System.out.println("requestLifeStyle result -----------------------------");
		System.out.println("pdData " + pdData);
		System.out.println("errCode " + errCode);
		System.out.println("blLogin_chk " + blLogin_chk);
		System.out.println("blUpdate " + blUpdate);
		System.out.println("strT1 " + strT1);
		System.out.println("errCode " + errCode);
		System.out.println("strType " + strType);
		System.out.println("strApptype " + strApptype);
		System.out.println("strAppNumber " + strAppNumber);
		System.out.println("strUserdata " + strUserdata);
		System.out.println("strEnuriId " + strEnuriId);
		System.out.println("intSeqno " + intSeqno);
		System.out.println("strR_code " + strR_code);
		System.out.println("strR_msg " + strR_msg);
		System.out.println("-----------------------------");
	} */
	jsonObject.put("code", strR_code);
	jsonObject.put("message", strR_msg);
	jsonObject.put("result_id", strR_id);
	jsonObject.put("result", strT1_Rsa);

	out.println(jsonObject.toString());
%>