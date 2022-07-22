<%@page import="javax.servlet.http.Cookie"%>
<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@page import="com.enuri.bean.mobile.Visit_Event_Proc"%>
<%@page import="org.json.*"%>
<%
request.setCharacterEncoding("utf-8");

String browser = request.getHeader("User-Agent");
long cTime = System.currentTimeMillis();
SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMdd");
String sdt = dayTime.format(new Date(cTime));//진짜시간
String oc = ChkNull.chkStr(request.getParameter("oc"),"");
Visit_Event_Proc visit_event_proc = new Visit_Event_Proc();
JSONObject jSONObject = new JSONObject();
String queryString =request.getQueryString();
if(Integer.parseInt(sdt)>=202107){
	if(queryString !=null){
		response.sendRedirect("/m/event/visit.jsp?"+request.getQueryString());
	}else{
		response.sendRedirect("/m/event/visit.jsp");
	}
	return;
}
if( request.getServerName().indexOf("dev2.enuri.com") > -1 || request.getServerName().indexOf("dev.enuri.com") > -1 || request.getServerName().indexOf("m.enuri.com") > -1){
	if(request.getParameter("sdt")!=null && !request.getParameter("sdt").equals("")){
		sdt= request.getParameter("sdt");
	}
    jSONObject = visit_event_proc.getEventList_DEV(sdt);
}else{
	jSONObject = visit_event_proc.getEventList(sdt);
}
String cUserId  =  ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"),"");
String cUserNick = cb.GetCookie("MEM_INFO","USER_NICK");

Members_Proc members_proc = new Members_Proc();
String cUsername = "";
String userArea = "";

if(!cUserId.equals("")){
    cUsername = members_proc.getUserName(cUserId);
    userArea = cUsername;
    if(cUsername.equals(""))        userArea = cUserNick;
    if(userArea.equals(""))        userArea = cUserId;
}

String chkId = ChkNull.chkStr(request.getParameter("chk_id"));
String strUrl = request.getRequestURI();

String strFb_title = "[에누리 가격비교] 매일 출석&룰렛 이벤트";
String strFb_description = "매일 출석체크하면, e머니가 팡팡!";
String strFb_img = "http://img.enuri.info/images/event/2021/attance/sns_1200_630.jpg";

String strCss = (String)jSONObject.get("m_css_file");
String includeFile = (String)jSONObject.get("m_file");
String eventCode = (String)jSONObject.get("event_code");
String startDate = (String)jSONObject.get("start_date");
String endDate = (String)jSONObject.get("end_date");
String luckeyList = (String)jSONObject.get("luckeyday_list");
String pcUrl = (String)jSONObject.get("pc_url");
if(Integer.parseInt(sdt)>=20210601){
	strCss="/css/event/y2021_rev/attance_may_m.css";
}else{
	strCss="/css/event/y2021_rev/attance_may_m.css";
}
if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){
        }else{
            response.sendRedirect(pcUrl);
            return;
        }
ArrayList<String> luckeyDayList = new ArrayList<String>();
String[] luckeyDay = luckeyList.split(",");
request.setAttribute("luckeyDay", luckeyDay);

String strApp = ChkNull.chkStr(request.getParameter("app"),"");

Cookie[] carr = request.getCookies();
try {
	for(int i=0;i<carr.length;i++){
	    if(carr[i].getName().equals("appYN")){
	    	strApp = carr[i].getValue();
	    }
	}
} catch(Exception e) {
}

%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
    <meta property="og:title" content="<%=strFb_title%>">
    <meta property="og:description" content="<%=strFb_description%>">
    <meta property="og:image" content="<%=strFb_img%>">
	<meta property="og:url" content="http://m.enuri.com/mobilefirst/visit_event.jsp">
    <meta name="format-detection" content="telephone=no" />
    <title>에누리(가격비교) eNuri.com</title>
    <script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
    <link rel="stylesheet" href="/css/event/com.enuri.event.m.css" type="text/css">
    <link rel="stylesheet" type="text/css" href="/css/swiper.css"/> <!-- 200115 추가 -->
    <link rel="stylesheet" type="text/css" href="<%=strCss%>"/>
    <link rel="stylesheet" type="text/css" href="/mobilefirst/css/lib/slick.css"/>
    <script type="text/javascript" src="/mobilefirst/js/event_regular.js?v=20180724"></script>
    <script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
    <script type="text/javascript" src="/js/swiper.min.js"></script> <!-- 200115 추가 -->
    <script>
	(function(a_,i_,r_,_b,_r,_i,_d,_g,_e){if(!a_[_b]){var d={queue:[]};_r.concat(_i).forEach(function(a){var i_=a.split("."),a_=i_.pop();i_.reduce(function(a,i_){return a[i_]=a[i_]||{}},d)[a_]=function(){d.queue.push([a,arguments])}});a_[_b]=d;a_=i_.getElementsByTagName(r_)[0];i_=i_.createElement(r_);i_.onerror=function(){d.queue.filter(function(a){return 0<=_i.indexOf(a[0])}).forEach(function(a){a=a[1];a=a[a.length-1];"function"===typeof a&&a("error occur when load airbridge")})};i_.async=1;i_.src="//static.airbridge.io/sdk/latest/airbridge.min.js";a_.parentNode.insertBefore(i_,a_)}})(window,document,"script","airbridge","init fetchResource setBanner setDownload setDownloads setDeeplinks sendSMS sendWeb setUserAgent setUserAlias addUserAlias setMobileAppData setUserId setUserEmail setUserPhone setUserAttributes clearUser setDeviceIFV setDeviceIFA setDeviceGAID events.send events.signIn events.signUp events.signOut events.purchased events.addedToCart events.productDetailsViewEvent events.homeViewEvent events.productListViewEvent events.searchResultViewEvent".split(" "),["events.wait"]);
	airbridge.init({
	    app: 'enuri',
	    webToken: 'f430f10352c54cc9aa2203b98e67be9e'
	});
	</script>
</head>
<jsp:include page="<%=includeFile %>">
	<jsp:param name = "sdt" value="<%=sdt %>"/>
	<jsp:param name = "userArea" value="<%=userArea %>"/>
	<jsp:param name = "cUserId" value="<%=cUserId %>"/>
	<jsp:param name = "chkId" value="<%=chkId %>"/>
	<jsp:param name = "eventCode" value="<%=eventCode %>"/>
	<jsp:param name = "luckeyDay" value="<%=luckeyDay %>"/>
	<jsp:param name = "startDate" value="<%=startDate %>"/>
	<jsp:param name = "endDate" value="<%=endDate %>"/>
	<jsp:param name = "oc" value="<%=oc%>"/>
</jsp:include>
<%@ include file="/mobilefirst/event2016/event_footer.jsp" %>
<script>
var vApp = "<%=strApp%>";
if(vApp == "Y")	{
	// 애드브릭스 적용: 프로모션
	var strEvent = "event_visit_view";
	  
	try{
		if(window.android){            // 안드로이드
			window.android.airbridgeEventForApp(strEvent,"event","visit","");
		}else{                               // 아이폰에서 호출
			window.location.href = "enuriappcall://airbridgeEventForApp?p1="+strEvent+"&p2=event&p3=visit&p4=";
		} 
	}catch(e){} 
}
</script>
</html>
