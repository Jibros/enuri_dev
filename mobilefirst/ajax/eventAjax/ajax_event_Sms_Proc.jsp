<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.util.http.ShortUrl"%>
<%@ page import="java.util.Random"%>
<%@ page import="com.surem.Mobile_TextMessage_Proc"%>
<%@page import="org.json.*"%>
<jsp:useBean id="RandomMain" class="com.enuri.include.RandomMain" scope="page" />
<jsp:useBean id="mobile_Event_Proc" class="com.enuri.bean.mobile.Mobile_Event_Proc" scope="page" />
<%

String strPhoneNum = ChkNull.chkStr(request.getParameter("phoneno"), "");
String username = ChkNull.chkStr(request.getParameter("username"), "");

String giftNo = ChkNull.chkStr(request.getParameter("gift_no"));

int cnt = mobile_Event_Proc.getCerkeySend(strPhoneNum,username);

String strGno = ChkNull.chkStr(cb.GetCookie("GATEP","GNO"));

JSONObject jSONObject = new JSONObject();


int iCont_cnt = ChkNull.chkInt(cb.GetCookie("MEMJOIN_SELF_CONF","CONF_CNT"));


if(iCont_cnt > 10){
	//10번 이상 참여
	jSONObject.put("result","T");
	
}else if(cnt > 0){
	//이미 참여하신 번호 입니다.
	jSONObject.put("result","D");

}else{
	
	GregorianCalendar gc = new GregorianCalendar();
	SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmss"); // 기본 데이타베이스 저장 타입
	Date d = gc.getTime(); // Date -> util 패키지
	String str = sf.format(d);
	
	String cs_no = "";
	
	for(int i = 0 ; i < 20 ; i++){
		
		int[] iT = RandomMain.getRandomValueNoDupe(10);
				
		cs_no = str.substring(6,8)+""+str.substring(8,10)+""+iT[0]+""+iT[1]+""+iT[2]+""+iT[3]+""+iT[4]+""+iT[5];

		if(mobile_Event_Proc.getCerkeyDuplicate(cs_no) > 0){
			
		}else{
			break;
		}
	
	}
	
	String gateUrl = "";
	
	//광고를 통한
	if(strGno.equals("1862991") || strGno.equals("1862992") || strGno.equals("1862993") || strGno.equals("1862994") || strGno.equals("1862995")){
		//MC
		gateUrl = "http://goo.gl/F1ozHx";
	}else if(strGno.equals("1862985") || strGno.equals("1862986") || strGno.equals("1862987") || strGno.equals("1862988") ){
		//LG
		gateUrl = "http://goo.gl/gSzksL";
	}else if(strGno.equals("1861615") ){
		//CR
		gateUrl = "http://goo.gl/sxmuPa";
	}else if(strGno.equals("1862990") || strGno.equals("1862996") || strGno.equals("1862997") || strGno.equals("1862998") || strGno.equals("1862999") ){
		//TG
		gateUrl = "http://goo.gl/xRypRd";
	}else if(strGno.equals("1863000") || strGno.equals("1863001") || strGno.equals("1863002") || strGno.equals("1863003") ){
		//CL
		gateUrl = "http://goo.gl/fcbtgF";
	}else{
		//광고 안통했을 경우
		gateUrl = "http://goo.gl/at2gJf";
	}
	
	String strMsg  =  "[에누리가격비교]\n";
		   strMsg += "교환번호:"+cs_no+"\n";
		   strMsg += "APP 설치하기\n";
		   strMsg += "▶ "+gateUrl+"\n";
	
	strPhoneNum =  strPhoneNum.replaceAll("-", "");
	
	Mobile_TextMessage_Proc TextMessage_Proc = new Mobile_TextMessage_Proc();
	boolean result = TextMessage_Proc.sendTextMessage("", strPhoneNum, strMsg);

	if(result){
		
		iCont_cnt++;
		cb.SetCookie("MEMJOIN_SELF_CONF","CONF_CNT",""+iCont_cnt);
		cb.SetCookieExpire("MEMJOIN_SELF_CONF", 3600*24);
		cb.responseAddCookie(response);
		
		String ostype = "";
		
		if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") >= 0){
			ostype = "A";
		}else if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") >= 0 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") >= 0){
			ostype = "I";
		}else if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") >= 0){
			ostype = "I";
		}else{
			ostype = "P";
		}
		mobile_Event_Proc.eventCerKeyInsert(cs_no,ostype, username, strPhoneNum, Integer.parseInt(giftNo), "","");
		
		//문자 전송 성공
		jSONObject.put("result","S");
		
	}else{
		//문자 전송 실패
		jSONObject.put("result","N");
	}


}
	out.println(jSONObject.toString());

%>
