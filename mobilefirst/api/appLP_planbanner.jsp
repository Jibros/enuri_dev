<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.mobile.Mobile_Today_Proc"%>
<%@ page import="com.enuri.bean.mobile.Mobile_Today_Data"%>
<%@ page import="java.lang.*"%>
<%@ page import="java.text.*"%>
<%
/******************************************
	title : app용 LP 하단 플루팅 배너 api
	auth : 2017-01-04 shwoo
	info : 하단 플루팅 배너
******************************************/
String strCate4 = ChkNull.chkStr(request.getParameter("cate"),"0000");	//카테고리4자리만 
String serverName = request.getServerName();

String strServerName = "";

if(serverName.indexOf("100.100.100.151")>-1 || serverName.indexOf("dev.enuri.com")>-1) {
	strServerName = "dev";
}


Mobile_Today_Proc mobile_today_proc = new Mobile_Today_Proc();
Mobile_Today_Data[] mobile_today_data = mobile_today_proc.getSpecialLayer(strCate4, strServerName);	

boolean bSpecial_Layer = false; 	//하단 플루팅 배너 노출 여부
boolean bSpecial_Layer_Ex = false; 	//하단 플루팅 배너 추가 변태 예외 노출 여부
String strToday_id = "";
String strToday_title = "";
String strBgcolor = "";

/* public static boolean finishChk(){
String endDateString = "2017-01-25";
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
Date endDate = fromatter.format(endDateString);
//Date endDate = formatter(from);
	return new Date().getTime() < endDate.getTime();
}
 */

/* public boolean finishChk(){
	String limit_year = 2017;
    String limit_month = 01;	//01	
    String limit_day = 25;		//30
    String limit = new Date(limit_year, limit_month-1, limit_day+1);
    
    return new Date().getTime() < limit.getTime();
} */

if(mobile_today_data != null){
	strToday_id 	= mobile_today_data[0].getToday_id();
	strToday_title 	= mobile_today_data[0].getToday_title();
	strBgcolor	= mobile_today_data[0].getBgcolor();
	if(strBgcolor.trim().length() > 0){
		bSpecial_Layer = true;			
	} 
	//11번가 예외처리
	if(strToday_id.equals("20170914141826") || strToday_id.equals("20170914070707") ){
		if(!is11stFinish()){
			bSpecial_Layer_Ex = true;
		}
	}  
}  
     
if(bSpecial_Layer){ 
	if(bSpecial_Layer_Ex){
		out.println("{");
			out.println("	\"banner_name\": \""+ strToday_title +"\", ");
			out.println("	\"banner_img\": \"http://img.enuri.info/images/mobilefirst/planlist/B_"+ strToday_id +"/B_"+ strToday_id +"_banner.jpg\", ");
			out.println("	\"bgcolor\": \""+ strBgcolor +"\", ");
			out.println("	\"linkurl\": \"http://www.11st.co.kr/connect/Gateway.tmall?method=Xsite&tid=1001161302&freetoken=outlink\"");
		out.println("}");
	}else{
		out.println("{");
			out.println("	\"banner_name\": \""+ strToday_title +"\", ");
			out.println("	\"banner_img\": \"http://img.enuri.info/images/mobilefirst/planlist/B_"+ strToday_id +"/B_"+ strToday_id +"_banner.jpg\", ");
			out.println("	\"bgcolor\": \""+ strBgcolor +"\", ");
			out.println("	\"linkurl\": \"http://m.enuri.com/mobilefirst/planlist.jsp?t=B_"+ strToday_id +"\"");
		out.println("}");
	}
}else{
	//종료 처리 2017/5/21 23:59 가정의달 통합기획전
	if(!isEventFinish()){ 
	out.println("{");
		out.println("	\"banner_name\": \"가정의달 통합기획전\", ");
		out.println("	\"banner_img\": \"http://img.enuri.info/images/mobilefirst/planlist/event_family201704.jpg\", ");
		out.println("	\"bgcolor\": \"#ffece6\", ");
		out.println("	\"linkurl\": \"http://m.enuri.com/mobilefirst/evt/family_201705.jsp?freetoken=event\"");
	out.println("}");
	} 
}
%>
<%!
public static boolean isEventFinish(){
	String endDateString = "2017-05-21 23:59:59";
	SimpleDateFormat formater = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	Date endDate = null;
	try {
		endDate = formater.parse(endDateString);
		
	} catch (ParseException e){
		 
	}
	if(endDate == null){
		return true;
	} 
	else
		return new Date().getTime() > endDate.getTime();
}
public static boolean is11stFinish(){
	String endDateString = "2017-09-27 23:59:59";
	SimpleDateFormat formater = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	Date endDate = null;
	try {
		endDate = formater.parse(endDateString);
		
	} catch (ParseException e){
		 
	}
	if(endDate == null){
		return true;
	} 
	else
		return new Date().getTime() > endDate.getTime();
}
%>
