<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.member.Login_Data"%>
<%@ page import="com.enuri.bean.member.Login_Proc"%>
<jsp:useBean id="Login_Data" class="com.enuri.bean.member.Login_Data" />
<jsp:useBean id="Login_Proc" class="com.enuri.bean.member.Login_Proc" />

<%
	String strCetify = "";
	String strM_email = "";
	String strModifydate = "";
	String strHp = "";
	String strLayer = "";
	
	String strUserId = cb.GetCookie("MEM_INFO","USER_ID");
	
	out.print("\r\n{"); 
	
	if(strUserId.length() > 0){
		Login_Data login_data = Login_Proc.isNotiMember(strUserId); //사용자 정보

		if(login_data != null ){
			strCetify = login_data.getCetify();
			strM_email = login_data.getM_email();
			strModifydate = login_data.getModifydate();
			strHp = login_data.getHp_tel1()+"-"+login_data.getHp_tel2()+"-"+login_data.getHp_tel3();

			if(strCetify.equals("0")){
				//뺏긴 아이디 - 우선순위 1(cetify 0이면 이메일, 핸드폰 없어도 1번 레이어)
				strLayer = "1"; 
			}  
			if(!strLayer.equals("1") && (strM_email.equals("") || strHp.length() < 3)){
				//이메일 OR 핸드폰 누락  
				strLayer = "2";
			}
		}else{
			strLayer = "0";
		}
	}else{
		strLayer = "0";
	}

	out.print("\r\n			\"loginLayer\":\""+strLayer+"\" ");
	out.print("\r\n}");
%>