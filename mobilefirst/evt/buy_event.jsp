<%@page import="javax.servlet.http.Cookie"%>
<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@page import="org.json.*"%>
<%
request.setCharacterEncoding("utf-8");

//facebook 썸네일 관련
String strFb_title = "[에누리 가격비교] 에누리 VIP 혜택!";
String strFb_description = "특별한 회원들을 위한 Special 혜택!";
String strFb_img = "http://img.enuri.info/images/mobilefirst/etc/vipsns2.jpg";

String strApp = ChkNull.chkStr(request.getParameter("app"),"");

Cookie[] carr1 = request.getCookies();
try {
	for(int i=0;i<carr1.length;i++){
	    if(carr1[i].getName().equals("appYN")){
	    	strApp = carr1[i].getValue();
	    }
	}
} catch(Exception e) {
}

    String chkId   = ChkNull.chkStr(request.getParameter("chk_id"),"");
    String cUserId = cb.GetCookie("MEM_INFO","USER_ID");
    String cUserNick = cb.GetCookie("MEM_INFO","USER_NICK");
    String strloc  = ChkNull.chkStr(request.getParameter("loc"),"");
    /*광고 */
    String gno = cb.GetCookie("GATEP", "GNO");
    String gkind = cb.GetCookie("GATEP", "GKIND");
    String oc  = ChkNull.chkStr(request.getParameter("oc"),"");
    Members_Proc members_proc = new Members_Proc();
    String cUsername = members_proc.getUserName(cUserId);
    String userArea = cUsername;

    if(cUsername.equals(""))	userArea = cUserNick;
    if(userArea.equals(""))		userArea = cUserId;

    long cTime = System.currentTimeMillis();
	SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMdd");
	String sdt = dayTime.format(new Date(cTime));//진짜시간

	if(request.getParameter("sdt")==null || request.getParameter("sdt").equals("") ) sdt = dayTime.format(new Date(cTime));
	else sdt= request.getParameter("sdt");

    if(Integer.parseInt(sdt)>=20210701){
        response.sendRedirect("/m/event/buy_vip.jsp");
        return;
    }

    String strUrl = request.getRequestURI();
    String tab = ChkNull.chkStr(request.getParameter("tab"));
	if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1
    	    || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1
    	    || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1
    	    || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){
     }else{
        response.sendRedirect("http://www.enuri.com/event2017/allpayback.jsp");
        return;
     }

 	String strCss =  "/css/event/y2021_rev/vip_may_m.css";
	String includeFile = "/mobilefirst/event2021/buy_main202105.jsp";

	String eventCode1 = "2021050303"; //맞춤적립
    String eventCode2 = "2021050302"; //트리플적립
    String eventCode3 = "2019090108"; //첫 더블 적립
    String startDate = "20210503";
    String endDate="20210531";
    String dday = "20210722";
    String inflowType = ChkNull.chkStr(request.getParameter("inflow"));
    int numSdt = Integer.parseInt(sdt);
    boolean isNext = false;

	if(numSdt >= 20210601){
		isNext = true;
		includeFile = "/mobilefirst/event2021/buy_main202106.jsp";
		strCss = "/css/event/y2021_rev/vip_may_m.css";

		eventCode1 = "2021060103"; //맞춤적립
		eventCode2 = "2021050302"; //트리플적립

		startDate = "20210601";
		endDate="20210630";

		dday = "20210819";
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
<meta name="format-detection" content="telephone=no" />
<title>에누리(가격비교) eNuri.com</title>
<link rel="stylesheet" href="/css/event/com.enuri.event.m.css?v=20201222" type="text/css">
<link rel="stylesheet" type="text/css"  href="<%=strCss%>" />
<link rel="stylesheet" type="text/css"  href="/mobilefirst/css/lib/slick.css" />
<link rel="stylesheet" type="text/css" href="/css/swiper.css">
<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/jquery.cookie.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/flick.event.js"></script>
<script type="text/javascript" src="/mobilefirst/js/event_regular.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
<script type="text/javascript" src="/js/swiper.min.js"></script> <!-- 200115 추가 -->
<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js?v=202020"></script>
<script>
var shareUrl = "http://" + location.host + "/mobilefirst/evt/buy_event.jsp?oc=mo";
Kakao.init('5cad223fb57213402d8f90de1aa27301');
</script>
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
     <jsp:param name = "chkId" value="<%=chkId %>"/>
     <jsp:param name = "eventCode1" value="<%=eventCode1 %>"/>
     <jsp:param name = "eventCode2" value="<%=eventCode2 %>"/>
     <jsp:param name = "eventCode3" value="<%=eventCode3 %>"/>
     <jsp:param name = "startDate" value="<%=startDate %>"/>
     <jsp:param name = "endDate" value="<%=endDate %>"/>
     <jsp:param name = "inflowType" value="<%=inflowType %>"/>
     <jsp:param name = "dday" value="<%=dday %>"/>
     <jsp:param name = "strFb_title" value="<%=strFb_title %>"/>
     <jsp:param name = "strFb_description" value="<%=strFb_description %>"/>
     <jsp:param name = "strFb_img" value="<%=strFb_img %>"/>
     <jsp:param name = "oc" value="<%=oc %>"/>
</jsp:include>
<%@ include file="/mobilefirst/event2016/event_footer.jsp" %>
<script>
var vApp = "<%=strApp%>";
if(vApp == "Y")	{
	// 애드브릭스 적용: 프로모션
	var strEvent = "event_vipbuy_view";

	try{
		if(window.android){            // 안드로이드
			window.android.igaworksEventForApp(strEvent);
			window.android.airbridgeEventForApp(strEvent,"event","vipbuy","");
		}else{                               // 아이폰에서 호출
			window.location.href = "enuriappcall://igaworksEventForApp?strEvent="+ strEvent +"";
			window.location.href = "enuriappcall://airbridgeEventForApp?p1="+strEvent+"&p2=event&p3=vipbuy&p4=";
		}
	}catch(e){}
}
</script>