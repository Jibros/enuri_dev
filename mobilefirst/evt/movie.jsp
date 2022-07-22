<%@ page contentType="text/html; charset=utf-8"%>
<%@include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@page import="com.enuri.bean.mobile.Movie_Event_Proc"%>
<%
     String event_id=ChkNull.chkStr(request.getParameter("event_id"), "");
	 String movie_name=ChkNull.chkStr(request.getParameter("movie_name"), "");
     String appYN = ChkNull.chkStr(request.getParameter("app"), "");
     String appYnImg = "";
     String strGkind = cb.GetCookie("GATEP", "GKIND");
     String strGno = cb.GetCookie("GATEP", "GNO");
     String cUserId = cb.GetCookie("MEM_INFO", "USER_ID");
     String cUserNick = cb.GetCookie("MEM_INFO", "USER_NICK");
     Members_Proc members_proc = new Members_Proc();
     String cUsername = members_proc.getUserName(cUserId);
     String userArea = cUsername;
     if (cUsername.equals("")) {
           userArea = cUserNick;
     }
     if (userArea.equals("")) {
           userArea = cUserId;
     }
     if (appYN.isEmpty()) {//string 개체가 갖고 있는 문자열이 비어있는지 조사
           appYN = "N";
           try {
                Cookie[] cookies = request.getCookies();
                if (cookies != null) {
                     for (int i = 0; i < cookies.length; i++) {
                           if (cookies[i].getName().equals("appYN")) {
                                appYN = cookies[i].getValue();
                                break;
                           }
                     }
                }
           } catch (Exception e) {
                appYN = "N";
           } finally {
           }
     } else {
           appYN = "Y";
     }
     if (appYN.equals("Y")) {
           appYnImg = "_app";
     }
     String referer = ChkNull.chkStr(request.getHeader("referer"), "");
     long cTime = System.currentTimeMillis();
     SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMddHHmm");
     String nowDt = dayTime.format(new Date(cTime));
     //pc면 pc로 센딩
     if ((ChkNull.chkStr(request.getHeader("User-Agent")).indexOf(
                "Android") >= 0 && ChkNull.chkStr(
                request.getHeader("User-Agent")).indexOf("Linux") >= 0)
                || (ChkNull.chkStr(request.getHeader("User-Agent"))
                           .indexOf("iPhone") >= 0 && ChkNull.chkStr(
                          request.getHeader("User-Agent")).indexOf("Mac") >= 0)
                || (ChkNull.chkStr(request.getHeader("User-Agent"))
                           .indexOf("iPad") >= 0 && ChkNull.chkStr(
                          request.getHeader("User-Agent")).indexOf("Mac") >= 0)
                || (ChkNull.chkStr(request.getHeader("User-Agent"))
                           .indexOf("iPod") >= 0 && ChkNull.chkStr(
                          request.getHeader("User-Agent")).indexOf("Mac") >= 0)) {
     } else {
          response.sendRedirect("http://www.enuri.com/evt/movie.jsp?event_id="+event_id);
           return;
     }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">     
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" /> 
<meta property="og:title" content="에누리 가격비교">
<meta property="og:description" content="에누리 모바일 가격비교">
<meta property="og:image" content="http://imgenuri.enuri.gscdn.com/images/mobilenew/images/logo_enuri.png">
<meta name="format-detection" content="telephone=no" />
<link rel="stylesheet" type="text/css" href="/mobilefirst/css/event/m_movie.css"/>
<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/jquery.cookie.js"></script>
<script type="text/javascript">
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
     (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
     m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
     })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
     //런칭할때 UA-52658695-3 으로 변경
     ga('create', 'UA-52658695-3', 'auto');
                
/*레이어*/
function onoff(id){
     var mid = $("#"+id);
     var doc_ht = $(window).height();
     if(mid.css("display") !== "none"){
           mid.css("display","none");
     }else{
           mid.css("display","");
           var lay_ht = mid.find(".noteLayer,.appLayer").outerHeight();
           if(lay_ht>= doc_ht ){
                //console.log(lay_ht,doc_ht)
                $(".layer_back").height($(document).height()).css("position","absolute");
                mid.find(".noteLayer,.appLayer").css({
                     "top":$(document).scrollTop() + 10,
                     "margin":"0px 0px 0px -150px"
                });
           }else{
                //console.log(lay_ht,doc_ht)
                $(".layer_back").css({
                     "position":"fixed",
                     "height":"100%"
                });
           }
     }
}
function getPoint(){
     $.ajax({
           type: "GET",
           url: "/mobilefirst/emoney/emoney_get_point.jsp",
           async: false,
           dataType:"JSON",
           success: function(json){
                remain = json.POINT_REMAIN;     //적립금
                $("#my_emoney").html(CommaFormattedN(remain) +""+json.POINT_UNIT);
           }
     });
}
                
function IsLogin() {
     var cName = "LSTATUS";
     var s = document.cookie.indexOf(cName +'=');
     if (s != -1){
           s += cName.length + 1;
           e = document.cookie.indexOf(';',s);
           if (e == -1){
                e = document.cookie.length
           }
           if( unescape(document.cookie.substring(s,e))=="Y"){
                try {
                     if(window.android){
                           if(vCheckfirst){
                                window.android.isLogin("true");
                                vCheckfirst = false;
                           }
                     }
                } catch(e) {}
                return true;
           }else{
                try {
                     if(window.android){
                           window.android.isLogin("false");
                     }
                } catch(e) {}
                return false;
           }
     }else{
           try {
                if(window.android){
                     window.android.isLogin("false");
                }    
           } catch(e) {}
           return false;
     }
}
                
function goLogin() {
     if($.cookie('appYN') != 'Y' && '<%=appYN%>' != 'Y'){
           document.location.href = "/mobilefirst/login/login.jsp?app=&backUrl="+encodeURIComponent(document.location.href);
     }else{
          if(window.android){        // 안드로이드               
                document.location.href = "/mobilefirst/login/login.jsp?app=&backUrl="+encodeURIComponent(document.location.href);
          }else{                          // 아이폰에서 호출
                document.location.href = "/mobilefirst/login/login.jsp";
          }
     }
     return false;
}
                
//콤마 옵션
function CommaFormattedN(amount) {
    var delimiter = ",";
    var i = parseInt(amount);
    if(isNaN(i)) { return ''; }
   
    var minus = '';
   
    if (i < 0) { minus = '-'; }
    i = Math.abs(i);
   
    var n = new String(i);
    var a = [];
    while(n.length > 3)
    {
        var nn = n.substr(n.length-3);
        a.unshift(nn);
        n = n.substr(0,n.length-3);
    }
    if (n.length > 0) { a.unshift(n); }
    n = a.join(delimiter);
    amount = minus + (n+ "");
    return amount;
}

function setLogInstall(){
    <%--  var strGkind = '<%=strGkind%>'+'';
     var strGno = '<%=strGno%>'+'';
     
     if(strGkind == "75" && strGno == "3136921"){
           ga('send', 'event', 'mf_event', '존윅영화이벤트_설치하기', '버즈빌_영화예매권_존윅');
     }else if(strGkind == "76" && strGno == "3139543"){
         ga('send', 'event', 'mf_event', '지니뮤직이벤트_설치하기', '애드립_영화예매권_존윅');
     }else if(strGkind == "74" && strGno == "3136922"){
         ga('send', 'event', 'mf_event', '존윅영화이벤트_설치하기', '페이스북_영화예매권_존윅');
     } --%>
}
                
function setLogBtn(){
<%--      var strGkind = '<%=strGkind%>'+'';
     var strGno = '<%=strGno%>'+'';
     
     if(strGkind == "75" && strGno == "3136921"){
         ga('send', 'event', 'mf_event', '존윅영화이벤트_버튼클릭', '버즈빌_영화예매권_존윅');
     }else if(strGkind == "76" && strGno == "3139543"){
         ga('send', 'event', 'mf_event', '지니뮤직이벤트_버튼클릭', '애드립_영화예매권_존윅');
     }else if(strGkind == "74" && strGno == "3136922"){
         ga('send', 'event', 'mf_event', '존윅영화이벤트_버튼클릭', '페이스북_영화예매권_존윅');
     } --%>
}
                
function webInstall(){
     var strGkind = '<%=strGkind%>'+'';
       var strGno = '<%=strGno%>'+'';
     var url;
     
     if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
         url = "https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8&freetoken=outlink";
     }else if(navigator.userAgent.indexOf("Android") > -1){
/*                 if(strGkind == "75" && strGno == "3136921"){
                 url = "https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=1917629&sub_referral=8844251";
                 window.location.href = url;
                 return false;
              }else if(strGkind == "74" && strGno == "3136922"){
                  url = "https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=4120949&sub_referral=3651652";
                  window.location.href = url;
                  return false;
              }else if(strGkind == "76" && strGno == "3139543"){
                  url = "https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=3535287&sub_referral=2159507";
                  window.location.href = url;
                  return false;
              } */
           url = "https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=8533332&sub_referral=4496088";
     }
     window.location.href = url;
}
                
function checklogin(){
     var vUserId = "<%=cUserId%>"
     if(finishChk()){
           if($.cookie('appYN') == 'Y' && '<%=appYN%>' == 'Y'){
                if(vUserId == ""){
                     alert("로그인 후 참여할 수 있습니다.")
                     goLogin(); //login_check.jsp
                }else{
                     onoff('event_enter');
                }
           }else{
                onoff('event_app');
           }
     }else{
           return false;
     }
}    
                
function resultRendering(isResult) {
     if (isResult == "true") {
           alert("응모해주셔서 감사합니다.");
           onoff('event_enter');
           
     }else{
           alert("기존에 응모해주신 이력이 있습니다! \n발표일까지 조금만 더 기다려주세요 ^^");
           onoff('event_enter');
     }
}
                
var event_id = "<%=event_id%>";
var start_date = "";
var end_date = "";
var m_poster = "";
var url_trailer = "";
var m_notice = "";
var m_enter_app = "";
var m_enter_web = "";
var m_trailer = "";
var m_steelcut = "";
var movie_name ="";

           
$(function(){
     $.ajax({
        type: "POST",
        url: '/mobilefirst/evt/movie_getlist.jsp',
        data : "event_id="+event_id,
        dataType: "JSON",
        success: function(result){
           try{
                event_id = result.event_id;
                movie_name = result.movie_name;
                $("#movie_name").text(movie_name);
                start_date = result.start_date;
                end_date = result.end_date;
                m_poster = result.m_poster;
                url_trailer = result.url_trailer;
                m_notice = result.m_notice;
                m_enter_app = result.m_enter_app;
                m_enter_web = result.m_enter_web;
                m_trailer = result.m_trailer;
                m_steelcut = result.m_steelcut;
           } catch (exception){
                console.log('exception : ' + exception);
           }
           if ( ! ( 'event_id' in result ) ) {
        	   alert("잘못된 접근입니다.");
        	   document.location.href = "/mobilefirst/IndexNew.jsp"
               return;
           }
           startPage();
           getDiv();
           
        },
           error: function (xhr, ajaxOptions, thrownError) {
           }
     }); // End of ajax (movie_getlist.jsp)
    
}); // End of $(function())

 
function parseDate(input) {
  var parts = input.match(/(\d+)/g);
  return new Date(parts[0], parts[1]-1, parts[2], parts[3], parts[4]);
}

function finishChk() {
   var vStart = parseDate(start_date);
   var vEnd = parseDate(end_date);
   var vNow = new Date();
   
   if(vNow >= vStart && vNow <= vEnd){
         return true;
   }else if(vNow < vStart){
         alert("이벤트 오픈전입니다.");
         return false;
   }else{
         alert("이벤트가 종료되었습니다.");
         return false;
   }
   //return new Date().getTime() < limit.getTime();
} 
                
                
function getDiv(){   
     var temp = "";
     $(".wrap").html(null);
     temp += "<img src='"+m_poster+"' alt= ''/>";
     temp += "<img src='"+m_notice+"' alt='' />";
     if($.cookie('appYN') != 'Y' && '<%=appYN%>' != 'Y') { // 웹에서 호출
           temp += "<a href='javascript:///' onclick='checklogin(); setLogBtn(); ga_log(1);'><img src='"+m_enter_web+"' alt='앱에서 응모하기' /></a>";
     } else {
           temp += "<a href='javascript:///' onclick='checklogin(); ga_log(2);'><img src='"+m_enter_app+"' alt='응모하기' /></a>";
     }
     temp += "<img src='"+m_trailer+"' alt='' />";
     temp += "<iframe style='width:100%;height:100%' src='" + url_trailer + "' frameborder='0' allowfullscreen></iframe>";
     temp +=    "<img src='"+m_steelcut+"' alt='' />"
     temp += "<span class='go_top'><a href='#'>TOP</a></span>";
                     
     $(".wrap").html(temp);
}
                
function startPage(){      
     var vUserId = "<%=cUserId%>";
     var event_id = "<%=event_id%>";
    // alert(movie_name);           
     getPoint();     
                
     ga('send', 'pageview', {
                'page': '/mobilefirst/evt/movie.jsp?event_id='+event_id,
                'title': '모바일 영화예매권 페이지뷰'
     });        
                
     $("#event_enter .btn_detail").click(function(){
           $("#event_enter > .noteLayer").hide()
     });
     
     $("#privacy .btn_close").click(function(){
           $("#event_enter > .noteLayer").show()
     })
                
     $(".myBtn").click(function(){   
           setLogInstall();
           webInstall();
     });
                
     $("#my_emoney").click(function(){    
           if($.cookie('appYN') != 'Y' && '<%=appYN%>' != 'Y'){     // 웹에서 호출
                onoff('app_only');
           }else{
                window.location.href = "/mobilefirst/emoney/emoney.jsp?freetoken=emoney";   //e머니 적립내역
           }
     });
                
     $(".win_close").on('click', function(){
           if($.cookie('appYN') != 'Y' && '<%=appYN%>' != 'Y'){     // 웹에서 호출
                location.href="/mobilefirst/Index.jsp";
           } else {   // 앱에서 호출
                if(window.android){        // 안드로이드               
                    window.location.href = "close://";
                } else {                        // 아이폰에서 호출
                    window.location.href = "close://";
                }
           }
     });
                
     $(".btn_login").click(function(){
           location.href = "/mobilefirst/login/login.jsp?backUrl="+encodeURIComponent(document.location.href);
           return false;
     });
                
     $("#main_close").on('click', function(){
           if($.cookie('appYN') != 'Y' && '<%=appYN%>' != 'Y'){     // 웹에서 호출
                event.preventDefault();
                history.back(1);
           } else { // 앱에서 호출
                if(window.android){        // 안드로이드               
                    window.location.href = "close://";
                } else {                        // 아이폰에서 호출
                    window.location.href = "close://";
                }
           }
     }); // End of (#main_close).click()
     $(".btn_ok").click(function(){
                                           
           var name = $("#u_id").val();
           var phone = $("#u_phone").val();
           var result = $("#u_check").is(":checked");
                     
           var strLen = name.length;
           var oneChar = "";
           var totalByte = 0;
                     
           if(name == ""){
                alert("실명을 입력해주세요.");
                return false;
           }else{
                var kor_check = /([^가-힣ㄱ-ㅎㅏ-ㅣ\x20])/i;
                if (kor_check.test(name)) {
                     alert("한글만 입력할 수 있습니다.");
                     return false;
                }
           }
           if(phone == ""){
                alert("휴대폰번호를 입력해주세요.");
                return false;
           } else {
                if(isNaN(phone) == true) {
                     alert("숫자만 입력해 주세요.");
                     return false;
                }
           }
           if(!result){
                alert("개인 정보 수집에 동의해주셔야 응모가 가능합니다.");
                return false;
           } else {
                <%-- var eventId = <%=EVENTID%>; --%>
                var vData = {u_name:name, u_phone:phone, u_eventId:event_id};
                $.ajax({
                   type: "POST",
                   url: "/mobilefirst/evt/movie_setlist.jsp",
                   data : vData ,
                   dataType: "JSON",
                   success: function(result){
                      resultRendering(result.result);
                   },
                     error: function (xhr, ajaxOptions, thrownError) {
                     }
                });
           }
     });  // End of (.btn_ok ).click()
} // End of startPage();
function ga_log(param){
    var vGa_label = "";
    if(param == 1){
          vGa_label = "앱에서 응모하기";
    }else if(param == 2){
          vGa_label = "응모하기";
    }
    if($.cookie('appYN') != 'Y' && '<%=appYN%>' != 'Y')
    {
          ga("send", "event", "mf_event", movie_name+"영화이벤트_WEB", vGa_label);
    }
    else
    {
          ga("send", "event", "mf_event", movie_name+"영화이벤트_APP", vGa_label);
    }
}
</script>
</head>
<body><!-- 앱일 경우 class="app" 추가 -->
<!-- 앱전용 이벤트 -->
<div class="layer_back" id="app_only" style="display:none;">
     <div class="appLayer">
           <h4>모바일 앱 전용 이벤트</h4>
           <a href="javascript:///" class="close" onclick="onoff('app_only')">창닫기</a>
           <p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br>에누리앱을 설치합니다.</p>
           <p class="btn_close"><button type="button" class="myBtn">설치하기</button></p>
     </div>
</div>
<!-- 앱전용 이벤트 -->
<div class="layer_back" id="event_app" style="display:none;">
     <div class="appLayer">
           <h4>모바일 앱 전용 이벤트</h4>
           <a href="javascript:///" class="close" onclick="onoff('event_app')">창닫기</a>
           <p class="txt">&lt;<span id="movie_name"></span>&gt; 
           <% if(event_id.equals("2017040701")||event_id.equals("2017041301")){ %>
           	뮤지컬 초대
           	<% }else{ %>
           	영화 예매권 
           	<% } %>
          	이벤트에<br/>응모하기 위해<br/>에누리 앱을 설치합니다.</p>
           <p class="btn_close"><button type="button" class="myBtn">설치하기</button></p>
     </div>
</div>
<!-- 모바일 앱 전용 이벤트 -->
<div class="layer_back" id="event_enter" style="display:none;">
     <div class="noteLayer tc">
     		<% if(event_id.equals("2017040701")||event_id.equals("2017041301")){ %>
           	<h4>뮤지컬 초대이벤트</h4>
           	<% }else{ %>
           	<h4>영화예매권 응모하기</h4>
           	<% } %>
           <a href="javascript:///" class="close" onclick="onoff('event_enter')">창닫기</a>
           <div class="inner">
                <div class="form_box">
                     <dl>
                           <dt><label for="u_id">이름</label></dt>
                           <dd><input type="text" autocorrect="off" autocomplete="off" autocapitalize="off" id="u_id" placeholder="실명을 입력해주세요."/></dd>
                           <dt><label for="u_phone">휴대폰 번호</label></dt>
                           <dd><input type="number" id="u_phone" placeholder="'-'없이 숫자만 입력"/></dd>
                     </dl>
                </div>
                <div class="info01">
                     <label>
                           <input type="checkbox" id="u_check" value="1"/>
                           <span>개인정보 수집 정책을 확인하였으며 동의합니다.</span>
                     </label>
                     <a href="javascript:///" class="btn_detail" onclick="onoff('privacy')">자세히보기</a>
                </div>
                <p class="btn_close">
                <button type="button" id="coupon_down" class="btn_ok">응모하기</button>
<!--                 <button type="button" id="coupon_down" onclick="onoff('event_enter')">응모하기</button> -->
                </p>
                <div class="info02">
                     <strong>꼭 알아두세요!</strong>
                     <p>
                           이벤트 기간 내 ID 당 1회 응모가능합니다.<br />
                           잘못된 정보 입력으로 인한 
                  <% if(event_id.equals("2017040701")||event_id.equals("2017041301")){ %>
           			초대권
           		  <% }else{ %>
           			예매권
           		  <% } %>         
                           제공의 불이익은 <br />
                           책임지지 않습니다.
                     </p>
                </div>
           </div>
     </div>
     <!-- 개인정보 -->
     <div id="privacy" style="display:none;">
           <div class="noteLayer">
                <h4>개인정보 수집 · 이용안내</h4>
                <div class="privacy_txt">
                     <p>에누리 가격비교는 이벤트 참여확인 및 경품 발송을 위하여 아래와  같이 개인 정보를 수집하고 있습니다. </p>
                     <dl>
                           <dt>1. 개인정보 수집 항목</dt>
                           <dd>휴대폰 번호, 이름, 참여 일시</dd>
                           <dt>2. 개인정보 수집 및 이용 목적</dt>
                           <dd>이벤트를 위해 수집된 개인정보는 이벤트 참여확인 및 경품 발송을 위한 본인확인 이외의 목적으로 활용되지 않습니다.</dd>
                           <dt>3. 개인정보 보유 및 이용 기간</dt>
                           <dd>개인 정보 수집자(에누리 가격비교)는 개인 정보의 수집 및 이용 목적이 달성되면 개인 정보를 즉시 파기합니다.</dd>
                     </dl>
                </div>
                <p class="btn_close"><button type="button" onclick="onoff('privacy')">닫기 </button></p>
           </div>
     </div>
<!-- //개인정보 -->
</div>
<!-- 모바일 앱 전용 이벤트 -->
<!-- 탭 -->
<div class="nav-container" id="topFix">
     <a href="javascript:///" class="win_close">창닫기</a>
     <!--p class="name">나의 e머니는 얼마일까?<button type="button" class="btn_login">로그인</button></p-->
     <%
           if (cUserId.equals("")) {
     %>
     <p class="name">
           나의 e머니는 얼마일까?
           <button type="button" class="btn_login">로그인</button>
     </p>
     <%
           } else {
     %>
     <p class="name"><%=userArea%>
           님<span id="my_emoney"></span>
     </p>
     <%
           }
     %>
</div>
<!--// 탭 -->
<div class="wrap"></div>
<!-- 푸터 -->
<%@ include file="/mobilefirst/event2016/event_footer.jsp"%>
<!-- // 푸터 -->
</body>
</html>
<script language="JavaScript" src="http://imgenuri.enuri.gscdn.com/common/js/Log_Tail_Mobile.js"></script>