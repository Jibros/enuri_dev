<%@page import="com.enuri.bean.member.Join_Data"%>
<%@page import="com.enuri.bean.member.Sns_Login"%>
<%@page import="com.enuri.bean.member.Login_Data"%>
<%@page import="com.enuri.bean.bizm.Bizm_Proc"%>
<%@page import="com.enuri.bean.bizm.Bizm_Data"%>
<%@page import="org.json.JSONObject"%>
<%@page import="com.surem.Mobile_TextMessage_Proc"%>
<%@page import="com.enuri.bean.member.Login_Proc"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<jsp:useBean id="Login_Proc" class="com.enuri.bean.member.Login_Proc" scope="page" />

<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<jsp:useBean id="Members_Data" class="com.enuri.bean.knowbox.Members_Data" scope="page" />
<jsp:useBean id="Members_Proc" class="com.enuri.bean.knowbox.Members_Proc" scope="page" />

<%@ page import="com.enuri.bean.knowbox.Hp_all_log_Data"%>
<%@ page import="com.enuri.bean.knowbox.Hp_all_log_Proc"%>
<jsp:useBean id="Hp_all_log_Data" class="com.enuri.bean.knowbox.Hp_all_log_Data" scope="page" />
<jsp:useBean id="Hp_all_log_Proc" class="com.enuri.bean.knowbox.Hp_all_log_Proc" scope="page" />
<%
//REFERER 체크
String referer = ChkNull.chkStr(request.getHeader("REFERER"), "");

/*
if(referer.isEmpty() || referer.indexOf("pw.jsp") < 0 || referer.indexOf("/member/login/modifyPw.jsp") < 0){
	out.print("비정상적 접근 입니다. ");
	return;
}
*/
HttpSession ttsession = request.getSession(true);

String strSession_no = (String)ttsession.getAttribute("MEMJOIN_SELF_CONF");
System.out.println(strSession_no);

JSONObject jSONObject = new JSONObject();

String strTmpPass="";

//임시 비번 생성
	int iMin =10000000;
	int iMax=20000000;
	int x = iMin + (int)( Math.random() * (iMax-iMin) );
	String tmpRandomCode = Integer.toString(x);
	int iRandomASCII=0;
	for(int i=0; i<8; i = i+2)
	{

	    iMin=97;
	    iMax=122;
	    iRandomASCII = iMin + (int)( Math.random() * (iMax-iMin) );
	    tmpRandomCode = tmpRandomCode.replaceAll( tmpRandomCode.substring(i, 1+i), String.valueOf( (char)iRandomASCII ) );
	    //System.out.println("i=" + i);
	}
	strTmpPass = tmpRandomCode;
	
		
	String user_id = ChkNull.chkStr(request.getParameter("userid"));
	String strPhoneNum = ChkNull.chkStr(request.getParameter("phoneno"), "");
	
	//System.out.println("user_id : "+user_id);
	//System.out.println("strPhoneNum : "+strPhoneNum);
	//System.out.println("strTmpPass : "+strTmpPass);

	
	Sns_Login Sns_Login = new Sns_Login();
	Join_Data join_Data = Sns_Login.getMemberData(user_id);
	String tel1 = join_Data.getTel1_p();
	String tel2 = join_Data.getTel2_p();
	String tel3 = join_Data.getTel3_p();
	
	String dbTel =tel1+tel2+tel3;
	//System.out.println("dbTel : "+dbTel);
	
	boolean rtnValue = false;
	
	if( dbTel.equals(strPhoneNum) ){
		//비밀번호 변경
		rtnValue = Login_Proc.Update_NewPass(user_id, strTmpPass) ;
		jSONObject.put("updatePass", rtnValue);
		
		if(rtnValue){
			
			String cookieName = ChkNull.chkStr(request.getParameter("cookiename"),"MEMJOIN_SELF_CONF");

				String strMsg = ""; 
				strMsg += user_id+ "님이 요청하신 임시 비밀번호는 다음과 같습니다.\n\n";
				strMsg += strTmpPass;
				strMsg +="\n\n 임시 비밀번호를 사용해서 로그인 하신 후 바로 새 비밀번호로 변경하시길 바랍니다.감사합니다.";

				if(strMsg.equals("") || strPhoneNum.equals("")){

					jSONObject.put("result","N");

				}else{
					//int iCont_cnt = ChkNull.chkInt(cb.GetCookie("MEMJOIN_SELF_CONF","CONF_CNT"));
					int iCont_cnt = ChkNull.chkInt(cb.GetCookie(cookieName,"CONF_CNT"));

					if(iCont_cnt > 10){
						//10번 이상 참여
						jSONObject.put("result","T");

					}else{

						/*
						strPhoneNum =  strPhoneNum.replaceAll("-", "");

						Mobile_TextMessage_Proc TextMessage_Proc = new Mobile_TextMessage_Proc();
						boolean result = TextMessage_Proc.sendTextMessage("", strPhoneNum, strMsg);

						if(result){

							iCont_cnt++;
							cb.SetCookie("MEMJOIN_SELF_CONF","CONF_CNT",""+iCont_cnt);
							cb.SetCookieExpire("MEMJOIN_SELF_CONF", 3600*24);
							cb.responseAddCookie(response);

							//문자 전송 성공
							jSONObject.put("result","S");

						}else{
							//문자 전송 실패
							jSONObject.put("result","N");
						}
						*/
						
						String receiver_num = ""; // 
						receiver_num = "82" + strPhoneNum.substring(1, strPhoneNum.length()); 
						String serverType = "";
						serverType = "real"; // 알림톡 실제용
					// 데이터 세팅
					Bizm_Data bizm_data = new Bizm_Data();
						Bizm_Proc bizm_proc = new Bizm_Proc();
						bizm_data.setBtn_name("에누리가격비교 홈");
					bizm_data.setBtn_url("http://m.enuri.com");
						bizm_data.setTemplate_code("enuri_0001");
						bizm_data.setProfile_key( "5febb2c1491bbbc3a069834f38e80c802fa584ff");
						bizm_data.setSend_message("[에누리가격비교 임시비밀번호] 임시비밀번호는 ["+strTmpPass+"] 입니다. 정확히 입력해주세요");
					bizm_data.setEnuri_id(user_id);
						bizm_data.setReceiver_num(receiver_num);
						bizm_data.setServerType(serverType);

						bizm_proc.insCommonBizMsg(bizm_data);
						
						//문자 전송 성공
						jSONObject.put("result","S");
						

					}
				}
		
		}else{
			jSONObject.put("result","N");
			out.println(jSONObject.toString());
		}
	}else{
		jSONObject.put("result","f");
		out.println(jSONObject.toString());
	}

	
	
			out.println(jSONObject.toString());
	
%>


