<%@page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.enuri.util.common.ChkNull"%>
<%@page import="org.json.*"%>
<%@page import="com.enuri.bean.event.Event_FirstbuyCpn_Proc"%>
<%
	String sdt = ChkNull.chkStr(request.getParameter("sdt")).trim(); 				//	테스트 날짜
	String userId = StringReplace(ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID")));
	String referer = ChkNull.chkStr(request.getHeader("referer"));
	String osType = ChkNull.chkStr(request.getParameter("osType"), "web").trim(); 	// 	참여 os type

    JSONObject jSONObject = new JSONObject();

    int resultType = 0; //유형체크
    
    SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMdd");
    String strToday = formatter.format(new Date()); 	
    if ( referer.indexOf("enuri.com") > -1 &&  !"".equals(userId)) {
		if ( referer.indexOf("dev") > -1 &&  !"".equals(sdt)) {
			strToday = sdt;
		}
	} else {
		return;
	}
    
	//sdu 회원이 인증이 안되어 있다면 true
	//이벤트 참여 불가 
	//노병원 2018/10/11
	Members_Proc mp = new Members_Proc();
	if(mp.SduCerify(userId)){
		jSONObject.put("result", -4);
		out.println(jSONObject.toString());
		return;
	}
    
    
	/*
	procCode
		1 : 대상자 유형체크
		2 : 대상자 유형체크 + 쿠폰 지급
		3 : 쿠폰 받은 USER의 정보
		4 : MY PAGE 내 쿠폰노출 여부 및 정보
	*/
	int procCode = ChkNull.chkInt(request.getParameter("procCode"), 0);
	Event_FirstbuyCpn_Proc event_firstbuycpn_proc = new Event_FirstbuyCpn_Proc();
	
	if (procCode == 1 || procCode == 2) {
		resultType = event_firstbuycpn_proc.firstCpnChk(userId, osType);
		
		if (procCode == 1) {
			jSONObject.put("result",resultType); 
		} else if (procCode == 2) {
			
			boolean isInsert = false;
			// 대상자를 체크 후 insert
			if(resultType == 1) {
				
				/*
					선쿠폰 테이블 내 제약조건이 걸려있으므로 선쿠폰 프로모션의 금액이 변경될시
					제약조건 반드시 추가
					([POINT_PAY_AMT]=(5000))
				*/
				isInsert = event_firstbuycpn_proc.insertFirstbuyCoupon(userId, 5000);
			}
			jSONObject.put("result",isInsert); 
		}
		
	} else if (procCode == 3) {

		jSONObject = event_firstbuycpn_proc.getApplyUserInfo(userId);
		jSONObject.put("strToday",strToday);
	} else if (procCode == 4) {
		// 친구초대/일반/선쿠폰 첫구매의 이벤트 seqNo
		int[] eventSeqs = {5, 24, 345};
		jSONObject = event_firstbuycpn_proc.getApplyUserMyPageInfo(userId, eventSeqs, strToday);
		
		if(!jSONObject.isNull("cpn_expire_dt")) {
			String tmp = jSONObject.getString("cpn_expire_dt");
			jSONObject.put("cpn_expire_dt", tmp.substring(0,4) + "-" + tmp.substring(4, 6) + "-" + tmp.substring(6, 8));
		}
	}
	out.println(jSONObject.toString());
%>
<%!
//특수문자 제거 하기
public String StringReplace(String str){       
	String match = "[^\uAC00-\uD7A3xfe0-9a-zA-Z\\s]";
	str =str.replaceAll(match, "").trim();
	return str;
}
%>