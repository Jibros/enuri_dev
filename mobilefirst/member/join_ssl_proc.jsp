<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/include/Base_Inc_2010.jsp"%>

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
/**
이 파일은 SSL 서버에 업로드해야 합니다.
*/
//IDC이전 서비스 다운시
if(false) return;


	String strRtnUrl = ConfigManager.RequestStr(request, "rtnurl", "/");	// 리턴 url
	
	
	
	// 필수입력정보
	String strName = ConfigManager.RequestStr(request, "name", "");	// 이름
	String strID = ConfigManager.RequestStr(request, "id", "");	// 아이디
	String strPass = ConfigManager.RequestStr(request, "pass1", "");	// 비밀번호
	String strEmail = ConfigManager.RequestStr(request, "email1", "");	// 개편전에는 이메일아이디, 도메인을 각각 받았다.
	String strRegGate = "0";	// 가입경로(0:pc, 1:모바일, 2:신차모바일). PC는 강제로 0으로 지정.
		
	
	// 인증정보
	String strCertify = ConfigManager.RequestStr(request, "certify", "");	// 인증구분(1:간편인증, 2:본인인증-e머니적립대상)
	String strTel1 = ConfigManager.RequestStr(request, "tel1", "");
	String strTel2 = ConfigManager.RequestStr(request, "tel2", "");
	String strTel3 = ConfigManager.RequestStr(request, "tel3", "");	
	String strConfCIkey = ConfigManager.RequestStr(request, "conf_ci_key", "");
	String strConfDIkey = ConfigManager.RequestStr(request, "conf_di_key", "");
	String strConfPhoneco = ConfigManager.RequestStr(request, "conf_phoneco", "");
	
	
	// 선택상세정보
	String strNickname = ConfigManager.RequestStr(request, "nickname", "");
	String strSexUser = ConfigManager.RequestStr(request, "sex_user", "");
	String strYYYYMMDDUser = ConfigManager.RequestStr(request, "yyyymmdd_user", "");
	String strZip = ConfigManager.RequestStr(request, "zip1", "");
	String strAddr1 = ConfigManager.RequestStr(request, "addr1", "");
	String strAddr2 = ConfigManager.RequestStr(request, "addr2", "");
	
	String strNewsFlag = ConfigManager.RequestStr(request, "mailing", "0");		// news_flag 필드	
	String strAdSmsYn = ConfigManager.RequestStr(request, "ad_sms_yn", "N");
	String strAdEmailYn = ConfigManager.RequestStr(request, "ad_email_yn", "N");
	String strMarketingYn = ConfigManager.RequestStr(request, "marketing_use_yn", "N");
	String strUserIP = ConfigManager.szConnectIp(request);	// 유저 IP
	
	
	
	// 신규가입자의 비밀번호는 무조건 소문자로 변환
	//strPass = strPass.toLowerCase();

	
	// 리퍼러 체크
	boolean bRefererOk = false;
	if( request.getHeader("referer").indexOf(join_ENURI_COM+"/member/join/join_personal.jsp") > -1){		
		bRefererOk = true;
	}
	
	
	
	// 실제 입력한 핸드폰 번호와 저장하는 번호가 같은지 세션에 저장한 암호화된 값과 비교함.
	HttpSession ttsession = request.getSession(true);
	
	
	// 세션체크 - 폰번호
	String tsessHp =  "";
	String strTel = strTel1 + strTel2 + strTel3;
	tsessHp = (String)ttsession.getAttribute("MEMJOIN_HP_CONF");
	//if (Seed_Proc.EnPass_Seed(strTel).equals(tsessHp)) {
	if(strTel.equals(tsessHp)){
		bRefererOk = true;
		//out.println("bRefererOk_MEMJOIN_HP_CONF: " + bRefererOk);
	} else {
		bRefererOk = false;
	}
	
	
	// 세션체크 - 인증방법
	String tsessCetify = "";
	tsessCetify = (String)ttsession.getAttribute("MEMJOIN_CETIFY");
	if(strCertify.equals(tsessCetify)){
		bRefererOk = true;
		//out.println("bRefererOk_MEMJOIN_CETIFY: " + bRefererOk);
	} else {
		bRefererOk = false;
	}
	

	// 세션체크 DI, CI. 본인인증일 경우 DI, CI도 체크
	String tsessDI = "";
	String tsessCI = "";
	if(tsessCetify.equals("2")){
		
		tsessDI = (String)ttsession.getAttribute("MEMJOIN_DI");
		tsessCI = (String)ttsession.getAttribute("MEMJOIN_CI");
		
		if(strConfDIkey.equals(tsessDI) && strConfCIkey.equals(tsessCI)){
			bRefererOk = true;
			//out.println("bRefererOk_MEMJOIN_DICI: " + bRefererOk);
		} else {
			bRefererOk = false;
		}
		
	}
	
	
	
	if(!bRefererOk) {
		out.println("<script>");		
		out.println("alert('잘못된 경로로 이 페이지에 접근하셨습니다!!!')");
		out.println("location.href='/member/join/join_personal.jsp';");		
		out.println("</script>");
	}

	
	// 필수값 체크
	if( strID.equals("") || strName.equals("") || strPass.equals("") || strEmail.equals("") || strRegGate.equals("") ){
		
		out.println("<script>");		
		out.println("alert('필수 입력 사항 중 입력하지 않은 사항이 있습니다.')");		

		out.println("location.href='/member/join/join_personal.jsp';");
		//out.println("location.href='"+join_ENURI_COM+strRtnUrl+"';");
		
		out.println("</script>");
		
	} else {
		if(CvtStr.isNumeric(strID.substring(0,1)) || !CvtStr.isValidID(strID)) {
			out.println("<script>");
			out.println("alert('아이디의 첫글자는 반드시 영문이어야 하고, \\n영문과 숫자만 사용 가능합니다.')");
			out.println("location.href='/member/join/join_personal.jsp';");
			out.println("</script>");
		} else {
			String passCheck = "1";
			passCheck = getCheck(strID, strPass);
			if(!passCheck.equals("0")){
				out.println("<script>");				
				out.println("alert('8~15자의 영문, 숫자가 조합된 비밀번호로 다시 입력해 주세요.\\n(동일한 숫자, 연속숫자, 아이디 포함, 띄어쓰기, 특수문자 불가)')");
				out.println("location.href='/member/join/join_personal.jsp';");
				out.println("</script>");
			} else {
				int iReturn_id = Integer.parseInt( Join_Proc.Check_ID(strID) );
				if(iReturn_id!=0 || CvtStr.isNumeric(strID.substring(0,1)) || !CvtStr.isValidID(strID)){
					out.println("<script>");
					out.println("alert('사용할 수 없는 아이디 입니다.')");
					out.println("location.href='/member/join/join_personal.jsp';");
					out.println("</script>");
				}else{
					//전화번호 확인
					boolean isUsedPhone = false;

					isUsedPhone = Join_Proc.getDataCertifyPhone(strTel1, strTel2, strTel3, "");

					if(isUsedPhone){
						out.println("<script>");						
						out.println("alert('이미 등록된 전화번호입니다.\\n다른 번호를 입력하세요.')");
						out.println("location.href='/member/join/join_personal.jsp';");
						out.println("</script>");
					}else{

					    
						
						// DB INSERT
						boolean iRtn = Join_Proc.InsertData2017(
								strID, strName, strPass, strEmail, strRegGate, strCertify, strTel1, strTel2, strTel3, strConfCIkey, strConfDIkey, strConfPhoneco, 
								strNickname, strSexUser, strYYYYMMDDUser, strZip, strAddr1, strAddr2, strNewsFlag, strAdSmsYn, strAdEmailYn, strMarketingYn, strUserIP
								);
						
						
						
						// INSERT 결과에 따라서 아래 로직 처리.
						if(iRtn==true){

							
							/*
							이메일발송. 예전부터 안 쓰는 부분이라서 주석처리
							String strLine = "";
							String line = "";
							String strSubject = "에누리 회원가입을 환영합니다.";
							
							if(!strEmail.equals("")){ //이메일주소 필수입력항목이 아님
								java.io.File fs = new java.io.File( application.getRealPath("/join/mail/Mail_First.jsp"));
								java.io.FileReader dmgFile= new java.io.FileReader(fs);
									java.io.BufferedReader reader1= new java.io.BufferedReader(dmgFile);

								while((line = reader1.readLine()) !=null) {
									strLine += line +"\n";
								}

								//' 메일에 날짜 & 아이디 삽입
								strLine = ReplaceStr.replace(strLine,"[Date]", DateStr.nowStr("yyyy-MM-dd"));
								strLine = ReplaceStr.replace(strLine,"[USERID]",strID);
								strLine = ReplaceStr.replace(strLine,"[REGDATE]", DateStr.nowStr("yyyy-MM-dd"));
								strLine = ReplaceStr.replace(strLine,"[COPYYEAR]", DateStr.nowStr().substring(0,4));

								//메일발송 중지 : 2013.2.13 (이수희 차장)
								//com.enuri.util.mail.SendMail.daekkSendMail(strEmail, "에누리닷컴", "eunri@enuri.com", strSubject, strLine);
							}
							*/
							
							
							
							//회원 가입이 완료 되면 session 정보를 삭제 한다.
							if(ttsession.getAttribute("MEMJOIN_HP_CONF")!= null){
								ttsession.removeAttribute("MEMJOIN_HP_CONF");
								ttsession.removeAttribute("MEMJOIN_CETIFY");								
								ttsession.removeAttribute("MEMJOIN_DI");
								ttsession.removeAttribute("MEMJOIN_CI");
							}
							
							
							%>


							<!-- 얼럿 메시지 보여주는 페이지로 이동. 구글관련 작업도 포함. -->
							
							<script language="JavaScript" type="text/javascript">
							<!--
							// 구글 가입전환 데이터 뽑기 by hsw 2005.06.28 마케팅 이태훈씨 요청.
							var google_conversion_id = 1069433239;
							var google_conversion_language = "ko";
							var google_conversion_format = "1";
							var google_conversion_color = "336600";
							if(true) {
								var google_conversion_value = 1;
							}
							var google_conversion_label = "Signup";
							//-->
							</script>
							<script language="JavaScript" src="https://www.googleadservices.com/pagead/conversion.js">
							</script>
							<noscript>
							<img height=1 width=1 border=0 src="https://www.googleadservices.com/pagead/conversion/1069433239/?value=1&label=Signup&script=0">
							</noscript>
							<form name="frmTemp" action="/login/LoginLayer_Proc_2010.jsp" method="post">
							<input type="hidden" name="loginid"  value="<%=strID %>">
							<input type="hidden" name="pass" value="<%=strPass %>">
							<input type="hidden" name="cmd" value="MEMBERJOIN">
							</form>
							<script>
/*  						    var adWin = window.open("http://ipns.kr/pns/service_info?site_code=S035&ctg_code=1&sub_code=1","","resizable=no,toolbar=no,directories=no,status=no,menubar=no,location=no");

						    if(adWin)
						        adWin.focus(); */

							alert("회원가입이 완료되었습니다!");
							//document.frmTemp.submit();
							
							
							// 리턴 url로 리다이렉트
							
							
							//document.location.href="<%=join_ENURI_COM%>/join/join2009/Join_Close.jsp";
							
							document.location.href="<%=join_ENURI_COM + strRtnUrl%>";
							</script>
							
						<% } else { %>
						
							<script>
							//document.location.href="<%=join_ENURI_COM%>/join/join2009/Join_Close.jsp";
							
							document.location.href="<%=join_ENURI_COM + strRtnUrl%>";
							</script>
							
						<%
						}
					}
				}
			}
		}
	}
%>

