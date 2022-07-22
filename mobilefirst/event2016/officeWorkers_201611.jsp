<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%

    String strGkind     = cb.GetCookie("GATEP","GKIND");
    String strGno       = cb.GetCookie("GATEP","GNO");

    //57  캠페인 직장인 2016111001  2016-11-10  9999-01-01  shwoo   2016-11-16 오후 5:18:32           수정

    Members_Proc members_proc = new Members_Proc();
    
    String cUserId  =  ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"),"");
    String cUserNick = cb.GetCookie("MEM_INFO","USER_NICK");
    
    String cUsername = "";
    String userArea = "";
    
    if(!cUserId.equals("")){
    
        cUsername = members_proc.getUserName(cUserId);
        userArea = cUsername;
        
        if(cUsername.equals("")){
            userArea = cUserNick;
        }
        if(userArea.equals("")){
            userArea = cUserId;
        }
    
    }
    long cTime = System.currentTimeMillis(); 
    SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMddHH");
    
    int sdt = Integer.parseInt(dayTime.format(new Date(cTime)));
    
    String param = ChkNull.chkStr(request.getParameter("sdt"));
    //int sdt = Integer.parseInt(param);
    
    if(!param.equals("")){
        sdt = Integer.parseInt(param);
    }
    
    String tab = ChkNull.chkStr(request.getParameter("tab"));
    
%>
<!DOCTYPE html> 
<html lang="ko">
<head>
    <meta charset="utf-8">  
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />    
    <meta property="og:title" content="에누리 가격비교">
    <meta property="og:description" content="에누리 모바일 가격비교">
    <meta property="og:image" content="http://imgenuri.enuri.gscdn.com/images/mobilenew/images/logo_enuri.png">
    <script type="text/javascript" src="http://m.enuri.com/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
    <script type="text/javascript" src="/mobilefirst/js/lib/jquery.cookie.js"></script>
    <script type="text/javascript" src="http://m.enuri.com/mobilefirst/js/utils.js"></script>
    <meta name="format-detection" content="telephone=no" />
    <link rel="stylesheet" type="text/css" href="/mobilefirst/css/event/com.css"/>
    <!-- <link rel="stylesheet" type="text/css" href="css/com.css"/> -->
    <script>(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)})(window,document,'script','//www.google-analytics.com/analytics.js','ga');ga('create', 'UA-52658695-3', 'auto');</script>
    <script type="text/javascript">
            //스크롤
            jQuery(document).ready(function($) { 
                $(".scroll").click(function(event){             
                event.preventDefault(); 
                $('html,body').animate({scrollTop:$(this.hash).offset().top}, 300); 
                }); 
            }); 
    </script>
</head>

<body><!-- 앱일 경우 class="app" 추가 -->

<!-- Layer -->
<!-- 앱전용 이벤트 --> 
<div class="layer_back" id="app_only" style="display:none;">
    <div class="appLayer">
        <h4>모바일 앱 전용 쇼핑 혜택</h4>
        <a href="javascript:///" class="close" onclick="onoff('app_only')">창닫기</a>
        <p class="txt">에누리 앱(APP) 설치 후<br />e머니 적립내역 확인 및<br />다양한 e쿠폰 상품으로 교환할 수 있습니다.</p>
        <p class="btn_close"><button type="button" id="install">설치하기</button></p>
    </div>
</div>

<!-- 개인영역 -->
<div class="nav-container">
    <a href="javascript:///" class="win_close" id="win_close">창닫기</a>
    <p class="name">나의 e머니는 얼마일까?<button type="button" class="btn_login">로그인</button></p>
</div>
<!--// 개인영역 -->


<div class="wrap">
    <div class="mainvisual">
        <div class="content">
            <h1>직장공감 회사에 지친 당신을 위해 준비했다!</h1>
            <ul class="go">
                <li><a href="#evt_tab01" href="javascript:void(0);" class="scroll" >내가 만난 최악의 직원</a></li>
                <% if( sdt >= 2016112810  ) {%>
                <li class="on" id="tab2"><a href="#evt_tab02" href="javascript:void(0);"class="scroll"  >오늘 당신의 점심은?</a></li><!-- 오픈시에 클래스 on추가  -->
                <%}else{%>
                <li id="tab2"><a href="#evt_tab02" href="javascript:void(0);"class="scroll"  >오늘 당신의 점심은?</a></li><!-- 오픈시에 클래스 on추가  -->
                <%}%>
            </ul>
        </div>
    </div>
    <% if( sdt >= 2016112810  ) {%>
    <div class="quest02" id="evt_tab02">
        <div class="content">
            <h2>회사에 이런 사람 꼭 있다! 내가 만난 최악의 직원</h2>
            <p>직장생활 중 내가 만난 최악의 직원을 남기면 따뜻한 아메리카노 드림!</p>
            <a href="javascript:///" onclick="goVote()">투표하기</a>
        </div>
    </div>
    <%}%>
    <div class="quest01" id="evt_tab01">
        <div class="content">
            <h2>회사에 이런 사람 꼭 있다! 내가 만난 최악의 직원</h2>
            <p>직장생활 중 내가 만난 최악의 직원을 남기면 따뜻한 아메리카노 드림!</p>
            <a href="javascript:///" onclick="goFaceBook()">최악의 직원 남기기</a>
        </div>
    </div>
    
    <span class="go_top"><a href="javascript:///">TOP</a></span>
    
<%@ include file="/mobilefirst/event2016/event_footer.jsp" %>    
</div>
</body>

</html>
<script>
$(document).ready(function() {
    
    $(".scroll").click(function(event){             
        event.preventDefault(); 
        
    }); 
    
    var tab = "<%=tab%>";
    
    if(tab == 2){
        $('html,body').animate({scrollTop:$(".quest02").offset().top}, 300);          
    }
    
    if(tab == 1){
        $('html,body').animate({scrollTop:$(".quest01").offset().top}, 300);          
    }
    
    
    if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
        ga('send', 'pageview', {        'page': '/mobilefirst/event2016/officeWorkers_201611.jsp',        'title': '직장공감 pv_iphone'});
    }else if(navigator.userAgent.indexOf("Android") > -1){
	   ga('send', 'pageview', {        'page': '/mobilefirst/event2016/officeWorkers_201611.jsp',        'title': '직장공감 pv_android'});
	} 
   
	if(IsLogin()){
	    getPoint();
	}
	
	$("#install").click(function(){
	    
	    var strGkind = '<%=strGkind%>'+'';
        var strGno = '<%=strGno%>'+'';
	    
		if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
	       window.location.href = 'https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8';
	    }else if(navigator.userAgent.indexOf("Android") > -1){
	       
	        if(strGkind == "71" && strGno == "3043146"){
                url = "https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=9999961&sub_referral=7272272";
            } else{
                url = "market://details?id=com.enuri.android&referrer=utm_source%3Denuri%26utm_medium%3Denuri_deal%26utm_campaign%3Denuri";
            }
	       
	    }
	});
	
    $(".go_top").click(function(){
        $(window).scrollTop(0);
    });
    
    $( "#win_close" ).click(function(){
        if($.cookie('appYN') == 'Y' )          window.location.href = "close://";
        else            window.location.replace("/mobilefirst/Index.jsp");
    });
    
    $(".btn_login").click(function(){
        if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
            if($.cookie('appYN') == 'Y' ) location.href = "/mobilefirst/login/login.jsp";
            else location.href = "/mobilefirst/login/login.jsp?backUrl=/mobilefirst/event2016/officeWorkers_201611.jsp?freetoken=event";
        }else   if(navigator.userAgent.indexOf("Android") > -1){
            location.href = "/mobilefirst/login/login.jsp?backUrl=/mobilefirst/event2016/officeWorkers_201611.jsp?freetoken=event";
        }else{
            location.href = "/mobilefirst/login/login.jsp?backUrl=/mobilefirst/event2016/officeWorkers_201611.jsp?freetoken=event";
        }       
    });

});

function goVote(){
    setLog();
    if($.cookie('appYN') == 'Y' ){
        ga('send', 'event', 'mf_event', '직장공감_APP', '투표');
    }else{
        ga('send', 'event', 'mf_event', '직장공감_WEB', '투표');
    }
    location.href = "https://m.facebook.com/story.php?story_fbid=1225739404152669&substory_index=0&id=160451777348109?freetoken=outlink";
    return false;
}


function setLog(){
        //http://m.enuri.com/move/GateP.jsp?g_kind=71&g_no=3043146&keywd=mango&logger_kw=mango&source=logger_kw&_C_=54
        var strGkind = '<%=strGkind%>'+'';
        var strGno = '<%=strGno%>'+'';
        
        if(strGno == "3043146") ga('send', 'event', 'mf_event', '직장인캠페인', '망고_최악의직원');
        
}

function goFaceBook(){
    setLog();
    if($.cookie('appYN') == 'Y' ){
        ga('send', 'event', 'mf_event', '직장공감_APP', '최악의 직원 남기기');
    }else{
        ga('send', 'event', 'mf_event', '직장공감_WEB', '최악의 직원 남기기');
    }
    location.href = "https://m.facebook.com/story.php?story_fbid=1208946799165263&substory_index=0&id=160451777348109&freetoken=outlink";
    return false;
}

function getPoint(){

    var username = "<%=userArea%>";

    $.ajax({ 
        type: "GET",
        url: "/mobilefirst/emoney/emoney_get_point.jsp",
        async: false,
        dataType:"JSON",
        success: function(json){
            remain = json.POINT_REMAIN; //적립금
            
            $(".name").empty();
            $(".name").html(username+" 님<span onclick='myArea()'>"+commaNum(json.POINT_REMAIN)+"점</span></p>");
            
        }
    });
}

function myArea(){
    if($.cookie('appYN') == 'Y' ){
        location.href = "/mobilefirst/emoney/emoney_store.jsp?freetoken=emoney";
    }else{
        onoff('app_only');    
    }
    
}


function onoff(id) {
    var mid=document.getElementById(id);

    if(mid.style.display=='') {
        mid.style.display='none';
    }else{
        mid.style.display='';
    }
}
</script>
<script language="JavaScript" src="http://imgenuri.enuri.gscdn.com/common/js/Log_Tail_Mobile.js"></script>