<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.diquest.ir.util.common.StringUtil"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%
//pc면 pc로 센딩
if(
	(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Linux") >= 0 ) ||
	(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Mac") >= 0) ||
	(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Mac") >= 0) ||
	(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Mac") >= 0)){
}else{
	response.sendRedirect("http://www.enuri.com/event2017/workers_201707.jsp");
	return;
}
/* 79  캠페인 직장공감3차 20170320 2017-03-20 9999-01-01  */
String chkId = ChkNull.chkStr(request.getParameter("chk_id"));
String strApp = ChkNull.chkStr(request.getParameter("app"),"");
String cUserId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"),"");
String cUserNick = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_NICK"),"");
//String EVENTID="2017032001";
String EVENTID="2017070301";
Members_Proc members_proc = new Members_Proc();
String cUsername = "";
if(!cUserId.equals(""))	cUsername = members_proc.getUserName(cUserId);
String userArea = cUsername;
if(cUsername.equals(""))     userArea = cUserNick;
if(userArea.equals(""))     userArea = cUserId;

if(strApp.isEmpty()){
     strApp = "N";    
     try{
           Cookie[] cookies = request.getCookies();         
           if(cookies!=null){
                for(int i=0; i<cookies.length; i++){        
                     if(cookies[i].getName().equals("appYN")){      
                           strApp =cookies[i].getValue();   
                           break;
                     }
                }
           }
     }catch(Exception e){
           strApp = "N";
     }finally{     }
}else{
     strApp = "Y";
}
String strGno     = ChkNull.chkStr(cb.GetCookie("GATEP","GNO"),"");
String strGkind     = ChkNull.chkStr(cb.GetCookie("GATEP","GKIND"),"");
String referer = ChkNull.chkStr(request.getHeader("referer"),"");
long cTime = System.currentTimeMillis();
SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMddHHmmss");
String nowDt = dayTime.format(new Date(cTime));
//접속자가 에누리 직원 인지 확인하는 플래그
String szRemoteHost = request.getRemoteHost().trim();
boolean enuriLocalMemberFlag = false;
if((szRemoteHost.length()>=11 && szRemoteHost.substring(0, 11).equals("211.206.100")) || (szRemoteHost.length()>=11 && szRemoteHost.substring(0, 11).equals("211.116.248"))) {
	if(szRemoteHost.equals("211.116.248.46") || szRemoteHost.equals("211.116.248.48") || szRemoteHost.equals("211.116.248.55") ||
		szRemoteHost.equals("211.116.248.61") || szRemoteHost.equals("211.116.248.72") || szRemoteHost.equals("211.116.248.74") ||
		szRemoteHost.equals("211.116.248.141")) {
		enuriLocalMemberFlag = false;
	} else {
		enuriLocalMemberFlag = true;
	}
}
%>
<!DOCTYPE html> 
<html lang="ko">
<head>
	<meta charset="utf-8">	
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />	
	<meta name="description" content="에누리 가격비교 - 오픈마켓, 종합몰, 백화점, 소셜 등 국내 주요 쇼핑몰의 상품 정보 및 가격비교 제공">
	<meta name="keyword" content="스마트폰, 가전, 컴퓨터, PC견적, 스포츠, 자동차, 유아, 식품, 가구, 패션, 화장품, 이벤트, 고객센터">
	<meta property="og:title" content="세상의 모든 최저가!">
	<meta property="og:description" content="에누리 모바일 가격비교">
	<meta property="og:image" content="http://imgenuri.enuri.gscdn.com/images/mobilenew/images/logo_enuri.png">
	<meta name="format-detection" content="telephone=no" />
	<link rel="stylesheet" type="text/css" href="/css/event/workers_6th_m.css"/>
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/lib/slick.css"/>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery.cookie.js"></script>
	<script src="/mobilefirst/js/lib/jquery.easy-paging.js"></script>
    <script src="/mobilefirst/js/lib/jquery.paging.min.js"></script>
	<script src="/mobilefirst/js/utils.js"></script>
	<script src="/mobilefirst/js/lib/ga.js"></script>
</head>
<body><!-- 앱일 경우 class="app" 추가 -->

<div class="wrap">
	
	<div class="myarea">
		<a href="javascript:///" class="win_close">창닫기</a>
	    <%if(cUserId.equals("")){%> 
	        <p class="name">나의 e머니는 얼마일까?<button type="button" class="btn_login">로그인</button></p>
	   	<%}else{%>
	        <p class="name"><%=userArea%> 님<span id="my_emoney"></span></p>        
	   	<%}%>
	</div>
	
	<div class="mainvisual">
		<div class="img_box">
			<img src="http://imgenuri.enuri.gscdn.com/images/event/2017/workers/6th/m_visual.jpg" alt="" />
			<div class="ir_txt">
				<h1>직장공감 6탄</h1>
				<p>회사에 지친 당신을 위해 준비했다!</p>
			</div>
		</div>
	</div>
	
	<!-- 직장공감 콘텐츠 -->
	<div class="cont_area">		
		<div class="worker_cont">
			<div class="img_box">
				<img src="http://imgenuri.enuri.gscdn.com/images/event/2017/workers/6th/m_cont1_info01.jpg" alt="" />
				<div class="ir_txt">
					<p>솔로 직장인들 주목!</p>
					<h1>올 여름! 운명의 상대를 만날 여름휴가 장소는?</h1>
				</div>

				<a href="javascript:///" target="_blank"><img src="http://imgenuri.enuri.gscdn.com/images/event/2017/workers/6th/m_cont1_info02.jpg" alt="운명의 여행지 찾기" onclick="goDoDo();event.cancelBubble=true;" /></a>

				<div class="img_box">
					<img src="http://imgenuri.enuri.gscdn.com/images/event/2017/workers/6th/m_cont1_info03.jpg" alt="" />
					<div class="ir_txt">
						<ul>
							<li>이벤트 기간: 2017년 7월 3일 ~ 7월 31일</li>
							<li>이벤트 경품: 이디야 카페아메리카노 ICE (e머니 2,800점)</li>
							<li>당첨자 발표: 8월 7일 당첨자 발표 페이지 내 공지</li>
							<li>참여방법: 나의 운명의 여행지 찾고 아래 댓글로 남기면 응모 완료!</li>
							<li>&lt;Tip&gt; 페이스북에서 친구소환하면 당첨확률 Up! </li>
						</ul>
						<p>※ 경품은 e쿠폰으로 교환 가능한 e머니로 적립해드립니다.</p>
					</div>
				</div>
			</div>
		</div>
		
		<div class="board_wrap">
			<div class="write_area">
				<!-- 로그인 전 class="logout", 로그인 후 class="login" -->
				<%if(cUserId.equals("")){%> 
				<div class="input logout">
					<textarea id="" class="txt_area" placeholder="글을 입력해 주세요."></textarea>
					<!--
						로그인 전, placeholder="글을 입력해 주세요."
						로그인 후, placeholder="이벤트와 무관한 부적절한 글은 관리자에 의해 삭제될 수 있습니다."
					-->
					<button class="btn regist stripe" onclick="goEnter()">등록하기</button>
				</div>
				<%}else{ %>
				<!-- 로그인 후 -->
				<div class="input login">
					<div class="box1">
						<p class="user"><%=cUserId%></p>
						<textarea id="txt_area" class="txt_area" maxlength="150"  placeholder="이벤트와 무관한 부적절한 글은 관리자에 의해 삭제될 수 있습니다."></textarea>
					</div>
					<div class="box2">
						<p class="word_num"><span>0</span>/150</p>
						<button id="" class="btn regist stripe" onclick="goEnter()">등록하기</button>
					</div>
				</div>
				<%} %> 
			</div>
			<div class="view_area"><ul></ul></div>
			<div class="paging">
                <ul class="list" id="paging">
                    <li></li>
                    <li>#n</li>
                    <li>#n</li>
                    <li>#c</li>
                    <li>#n</li>
                    <li>#n</li>
                    <li></li>
                </ul>
            </div>
		</div>

		<div class="other_list">
			<h2 class="tit stripe">더 많은 공감하기</h2>

			<div class="ol_wrap">
				<ul class="slick_area"></ul>
			</div>
		</div>
	</div>
	<!--// 직장운세 -->
	<span class="go_top"><a href="javascript:///">TOP</a></span>
</div>
<!-- 푸터 -->
<%@ include file="/mobilefirst/event2016/event_footer.jsp" %>
<!--// 푸터 -->
<!-- 앱전용 이벤트 LAYER --> 
<div class="layer_back" id="app_only" style="display:none;">
	<div class="appLayer">
		<h4>모바일 앱 전용 쇼핑 혜택</h4>
		<a href="javascript:///" class="close" onclick="onoff('app_only')">창닫기</a>
		<p class="txt">에누리 앱(APP) 설치 후<br />e머니 적립내역 확인 및<br />다양한 e쿠폰 상품으로 교환할 수 있습니다.</p>
		<p class="btn_close"><button type="button" id="myBtn">설치하기</button></p>
	</div>
</div>
<!-- //앱전용 이벤트 LAYER --> 
<script>
var vOs_type = "";
var logNm = "";
if($.cookie('appYN') == 'Y' && '<%=strApp %>' == 'Y'){
     logNm = "APP";
     if(navigator.userAgent.indexOf("Android") > -1)           vOs_type = "MAA";     
     else           vOs_type = "MAI";               
}else{ 
     logNm = "Web";
     if(navigator.userAgent.indexOf("Android") > -1)           vOs_type = "MWA";     
     else           vOs_type = "MWI";               
}
var eventid = "<%=EVENTID%>";
var pageno = 1;
var pagesize = 4;
var totalcnt = 0;

function goDoDo(){
	
	ga('send', 'event', 'mf_event', '2017_직장공감', '운명의여행지찾기');
	
	if("<%=strApp %>" == 'Y')    window.location.href = "http://doo-doo.co.kr/content/167/2718?freetoken=outlink";
    else                     	window.open("http://doo-doo.co.kr/content/167/2718?freetoken=outlink");
}

function webInstall(param){
        var url;
   
        if(navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
             url = "https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8&freetoken=outlink";
        }else if(navigator.userAgent.indexOf("Android") > -1){
             url = "market://details?id=com.enuri.android&referrer=utm_source%3Denuri.%26utm_medium%3Dreview_event%26utm_campaign%3Dreview_promotion_20151231%2520";
        }
        window.location.href = url;
}

function fnCut(str,lengths) // str은 inputbox에 입력된 문자열이고,lengths는 제한할 문자수 이다.
{
      var len = 0;
      var newStr = '';
  
      for (var i=0;i<str.length; i++) 
      {
        var n = str.charCodeAt(i); // charCodeAt : String개체에서 지정한 인덱스에 있는 문자의 unicode값을 나타내는 수를 리턴한다.
        // 값의 범위는 0과 65535사이이여 첫 128 unicode값은 ascii문자set과 일치한다.지정한 인덱스에 문자가 없다면 NaN을 리턴한다.
        
       var nv = str.charAt(i); // charAt : string 개체로부터 지정한 위치에 있는 문자를 꺼낸다.
        

        if ((n>= 0)&&(n<256)) len ++; // ASCII 문자코드 set.
        else len += 2; // 한글이면 2byte로 계산한다.
        
        if (len>lengths) break; // 제한 문자수를 넘길경우.
        else newStr = newStr + nv;
      }
      return len;
}

var textCnt = 0;

$(function() {
     ga('send', 'pageview'); 
     getEventlist();
     footerBannerLoading();
     getPoint();
     /*
     $(".img_box").click(function(){  
         ga('send', 'event', 'mf_event', '2017_직장공감', '페이스북에 남기기');
         if("<%=strApp %>" == 'Y')    window.location.href = "https://m.facebook.com/story.php?story_fbid=1424401737619767&substory_index=0&id=160451777348109&freetoken=outlink";
         else                     window.open("https://m.facebook.com/story.php?story_fbid=1424401737619767&substory_index=0&id=160451777348109&freetoken=outlink");         
     });
     */
     
     $("#txt_area").bind({
         keydown:function(event){},
	     keyup:function(){
	    	 
			var cnt = fnCut($(this).val(),150);
        	 
        	 textCnt = cnt;
        	 
        	 var kEvt = window.event;
             if (kEvt.keyCode == 13){
             }else{
           		 $(".word_num > span").empty();
    	   	 	 $(".word_num > span").append($(this).val().length);                  
             }
         },
         blur:function(){
         },
         focus:function(){
         }
     });
     $("#myBtn").click(function(){  
         webInstall('1');
     });
     // placeholder
    $('#wish_txt').focus(function(){
        if ($('#wish_txt').val() == '이벤트와 무관한 부적절한 글은 관리자에 의해 삭제될 수 있습니다'){
            $('#wish_txt').val('');
        }
    });
    $('#wish_txt').focusout(function(){
        if ($('#wish_txt').val() == ''){
            $('#wish_txt').val('이벤트와 무관한 부적절한 글은 관리자에 의해 삭제될 수 있습니다');
        }
    });
     $(".btn_login").click(function(){
         if($.cookie('appYN') != 'Y' && '<%=strApp %>' != 'Y'){
               document.location.href = "/mobilefirst/login/login.jsp?app=&backUrl="+encodeURIComponent(document.location.href);
         }else{
              if(window.android){        // 안드로이드           
                    document.location.href = "/mobilefirst/login/login.jsp?app=&backUrl="+encodeURIComponent(document.location.href);
              }else{                          // 아이폰에서 호출
                    document.location.href = "/mobilefirst/login/login.jsp";
              }
         }
         return false;
     });
     $(".btn.facebook.stripe").click(function(){
        ga('send', 'event', 'mf_event', '2017_직장공감', '페이스북에 남기기');
        if("<%=strApp %>" == 'Y')    window.location.href = "https://m.facebook.com/story.php?story_fbid=1424401737619767&substory_index=0&id=160451777348109&freetoken=outlink";
        else                     window.open("https://m.facebook.com/story.php?story_fbid=1424401737619767&substory_index=0&id=160451777348109&freetoken=outlink");
     });
     $("#my_emoney").click(function(){
          ga('send', 'event', 'mf_event', '2017_직장공감', '2017 직장공감_개인화_emoney');
          if($.cookie('appYN') != 'Y' && '<%=strApp %>' != 'Y')           $('#app_only').show();
          else  window.location.href = "/mobilefirst/emoney/emoney.jsp?freetoken=emoney";   //e머니 적립내역
     });
    $(".go_top").click(function(){        $(window).scrollTop(0);    });
    $( ".win_close" ).click(function(){
        if("<%=strApp %>" == 'Y')    window.location.href = "close://";
        else                     window.location.replace("/mobilefirst/IndexNew.jsp");
    });
     $("body").on('click', ".slick-track > li", function(event) {
        var link = $(this).attr("data-link");
        var copy = $(this).find(".copy").text();
        ga('send', 'event', 'mf_event', '2017_직장공감', '공감하기_'+copy);
        window.open(link);
     });
});
function getEventlist(){
$.ajax({
          type: "GET",
          url: "/mobilefirst/event2016/xmas_getlist.jsp",
          data: "pageno="+pageno+"&pagesize="+pagesize+"&eventId="+eventid,
          dataType: "JSON",
          success: function(json){
                $("#xams_msg").html(null);
            
                if(json.eventlist){
                     
                     var template = "";
                     for(var i=0;i<json.eventlist.length;i++){
                        
                        if(i==0) totalcnt = json.eventlist[i].totalcnt;
                        var userId = json.eventlist[i].user_id;
                        if(userId.length>9)       id = userId.substring(0,4)+"**"+"..";
                        else                           id = userId.substring(0, userId.length-2)+"**";
                        
						var reply_date = json.eventlist[i].reply_date;
						var year = reply_date.substring(0,4);
						var month = reply_date.substring(6,4);
						var day = reply_date.substring(8,6);
						var date = year+"-"+month+"-"+day;
                        
                        template += "<li>";
	                        template += "<div class='head'>";
	                        template += "	<p class='user'>"+id+"</p>";
	                        template += "	<p class='date'>"+date+"</p>";
	                        template += "</div>";
	                        template += "<p class='cont'>"+json.eventlist[i].reply_msg+"</p>";
                        template += "</li>";
                        
                     }
                     $(".view_area > ul").html(template);
                     $("#paging").easyPaging(totalcnt, {    perpage : 4,    onSelect: function(page) {    perpage = 4;    pageno = page; getEventlist2();   }   });
                }
          },error: function (xhr, ajaxOptions, thrownError) {}
     });
}
  //등록하기
  function goEnter(){
	  if(!IsLogin()){
          alert("로그인 후 참여 가능합니다.");
          goLogin();
          return false;
      }
	  var txtcnt = $("#txt_area").val().length;
      
		  if(txtcnt > 150){
			  alert("150글자 까지만 입력 가능합니다.");
			  return false;
		  }
		  
          if(finishChk()){
          ga('send', 'event', 'mf_event', '2017_직장공감', '등록하기');
          var reply = $(".txt_area").val();
          var count = reply.length;
          
          if(reply == "이벤트와 무관한 부적절한 글은 관리자에 의해 삭제될 수 있습니다"){
            alert("내용을 입력해주세요!");
            $(".txt_area").focus();
            return false;
          }
          
          var blank_pattern = /^\s+|\s+$/g;
          if( $("#txt_area").val().replace( blank_pattern, '' ) == "" ){
              alert(' 내용을 입력해주세요! ');
              return false;
          }
          
          if(count == 0)             alert("내용을 입력해주세요!");
          else{
               var vData = {replyMsg:reply, osType:vOs_type, eventId:eventid};
               $("#wish_reply").val("");
               $.ajax({
                  type: "POST",
                  url: "./ajax/reply_setlist.jsp",
                  data : vData ,
                  dataType: "JSON",
                  success: function(json){
                       if( json.result == "true"){ 
                        getEventlist2(); 
                        alert("등록되었습니다!");
                        $(".txt_area").val("");
                        $(".word_num > span").text("0");
                       }else{                             
                        alert("이미 참여하셨습니다. \n1일 1회 참여가능합니다.");
                       }
                  },
                    error: function (xhr, ajaxOptions, thrownError) {}
               });
            }
         } else {                   alert('이벤트가 종료되었습니다.');         }
}

function getEventlist2(){
$.ajax({
          type: "GET",
          url: "/mobilefirst/event2016/xmas_getlist.jsp",
          data: "pageno="+pageno+"&pagesize="+pagesize+"&eventId="+eventid,
          dataType: "JSON",
          success: function(json){
                $("#xams_msg").html(null);
                if(json.eventlist){
                     var template = "";
                     
                     for(var i=0;i<json.eventlist.length;i++){
                        var userId = json.eventlist[i].user_id;
						if(userId.length>9)       id = userId.substring(0,4)+"**"+"..";
						else                           id = userId.substring(0, userId.length-2)+"**";
						
						var reply_date = json.eventlist[i].reply_date;
						var year = reply_date.substring(0,4);
						var month = reply_date.substring(6,4);
						var day = reply_date.substring(8,6);
						var date = year+"-"+month+"-"+day;
						
						if(i==0) totalcnt = json.eventlist[i].totalcnt;
                        
                        template += "<li>";
                        template += "<div class='head'>";
                        template += "	<p class='user'>"+id+"</p>";
                        template += "	<p class='date'>"+date+"</p>";
                        template += "</div>";
                        template += "<p class='cont'>"+json.eventlist[i].reply_msg+"</p>";
                    	template += "</li>";
                     }
                     $(".view_area > ul").html(template);
                }
          },error: function (xhr, ajaxOptions, thrownError) {}
     });
}
function footerBannerLoading(){
$.ajax({
          type: "GET",
          url: "/mobilefirst/api/officeBanner.json",
          dataType: "JSON",
          success: function(json){
                if(json.promotionList){
                    var listTemp = "";
                    $.each( json.promotionList , function(i , v){
                        listTemp += "<li data-link='"+v.mobile_url+"'>";
	                        listTemp += "<a href=\"javascript:///\">";
	                            listTemp += "<div class='img_box'>";
	                                listTemp += "<img src='"+v.img_src+"' alt='' />";
	                                
	                                var title = v.title;
	                                if (title.length > 6) { // title
			                            title = v.title.substring(0, 6) + "<br>" + v.title.substring(6, 12) 
			                            + "<br>" + v.title.substring(12, 18);
			                        }
	                                listTemp += "<span class='copy'>"+title+"</span>";
	                                listTemp += "<span class='dim'></span>";
	                            listTemp += "</div>";
	                        listTemp += "</a>";
	                    listTemp += "</li>";
                    });
                    $(".slick_area").html(listTemp);
                    slickLoading();
                }
          },error: function (xhr, ajaxOptions, thrownError) {}
     });
}
function getPoint(){
     $.ajax({
          type: "GET",
          url: "/mobilefirst/emoney/emoney_get_point.jsp",
          async: false,
          dataType:"JSON",
          success: function(json){
                remain = json.POINT_REMAIN;     //적립금
               $("#my_emoney").html(commaNum(remain) +""+json.POINT_UNIT);
          }
     });
}
function slickLoading(){
 	// 월급도둑 공개수배 SLICK
 	$('.wslick').slick({
 		infinite: true,
 		slidesToShow: 1,
 		speed: 300,
 		cssEase : "ease-in"
 	});
 	// 더 많은 공감하기 SLICK
 	$('.slick_area').slick({
 		infinite: false,
 		slidesToShow: 3,
 		swipeToSlide: true,
 		speed: 150,
 		cssEase : "ease-in"
 	});
 	$('.slick_area').on('afterChange', function(event, slick, direction){
 		var e = event,
 			s = slick,
 			d = direction,
 			total = s.slideCount - 1;
 		if(d == 0) 			alert("첫 페이지입니다!");
 		else if(d == total) alert("마지막 페이지입니다!");
 	});
}
function onoff(id) {
    var mid=document.getElementById(id);
    if(mid.style.display=='')         mid.style.display='none';
    else        mid.style.display='';
}
// 이벤트 기간 체크
function finishChk() {
   var limit_year = 2017;
   var limit_month = 7;
   var limit_day = 31;
   var limit = new Date(limit_year, limit_month-1, limit_day+1);
   return new Date().getTime() < limit.getTime();
}           
</script>
</body>
<script language="JavaScript" src="http://imgenuri.enuri.gscdn.com/common/js/Log_Tail_Mobile.js"></script>
</html>