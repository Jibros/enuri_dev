<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@page import="com.enuri.util.common.ChkNull"%>
<%@page import="java.text.*"%>
<%@page import="java.util.*"%>
<%@page import="com.enuri.bean.main.deal.CrazyDeal_VO"%>
<%@page import="com.enuri.bean.main.deal.CrazyDeal_Proc"%>
<%@page import="com.enuri.bean.member.Sns_Login"%>
<%@page import="org.json.*"%> 
<%
String type = ChkNull.chkStr(request.getParameter("type"),"C");

CrazyDeal_Proc cdp = null;
if(request.getServerName().indexOf("dev") > -1){
	cdp = new CrazyDeal_Proc("_DEV");	// dev
}else{
	cdp = new CrazyDeal_Proc();			// real
}
CrazyDeal_VO commingSoonVO = new CrazyDeal_VO();

boolean isSaleSoon = false; //판매예정인가
long remainTime = 0; //판매까지 남은시간

commingSoonVO = cdp.getSoonDeal(type); //곧 판매예정상품
int soonSeq = 0; //곧 판매예정인 상품의 seq
String soonGoodsCompany=""; //곧 판매예정인 상품의 shopcode
Calendar nowCal = Calendar.getInstance();
DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
Calendar ssCal = Calendar.getInstance();

try {
	Date date = formatter.parse(commingSoonVO.getGoodsStSelldate());
	//System.out.println(date.toString());
	ssCal.setTime(date);
} catch(Exception e) { }
JSONObject jSONObject = new JSONObject();
remainTime = ssCal.getTimeInMillis() - nowCal.getTimeInMillis();

//System.out.println("remainTime : "+remainTime);

if(remainTime>0 && remainTime<600000) {
	isSaleSoon = true;
	soonSeq = commingSoonVO.getSeq();
	soonGoodsCompany = commingSoonVO.getGoodsCompnay();
}else{
	remainTime = 0;
}

String userId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID")).trim(); 

//sns 인증회원 확인
boolean bcertify= new Sns_Login().isSnsMemberCertify2(userId);
int result = 0;
if(!bcertify){
	result = -5;
}

jSONObject.put("isSaleSoon", isSaleSoon);
jSONObject.put("soonSeq", soonSeq);
jSONObject.put("soonGoodsCompany", soonGoodsCompany);
jSONObject.put("remainTime", remainTime);
jSONObject.put("result", result);
out.println(jSONObject.toString());


%>