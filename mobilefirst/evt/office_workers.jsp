<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.diquest.ir.util.common.StringUtil"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%
String event_id=ChkNull.chkStr(request.getParameter("event_id"), "");
//String event_name=ChkNull.chkStr(request.getParameter("event_name"), "");
String server=ChkNull.chkStr(request.getParameter("server"), "");

boolean isTest = false;
if(server.equals("test")){
	isTest=true;
}


long cTime = System.currentTimeMillis();
SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMdd");
String sdt = dayTime.format(new Date(cTime));//진짜시간

//pc면 pc로 센딩
if(
	(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Linux") >= 0 ) ||
	(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Mac") >= 0) ||
	(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Mac") >= 0) ||
	(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Mac") >= 0) ||
	"2017111403".equals(event_id)){
}else{
	response.sendRedirect("/evt/office_workers.jsp?event_id="+event_id);
	return;
}
if(event_id.equals("2017122801")){ //조립pc 프로모션은 pc버전으로만
	event_id = "2017122109";
}
/* 79  캠페인 직장공감3차 20170320 2017-03-20 9999-01-01  */
String chkId = ChkNull.chkStr(request.getParameter("chk_id"));
String strApp = ChkNull.chkStr(request.getParameter("app"),"");
String cUserId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"),"");
String cUserNick = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_NICK"),"");
//String EVENTID="2017032001";
//String EVENTID="2017070301";
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

String sPageType = "main";
String strAgent = "pc_o";

String strFrom = ConfigManager.RequestStr(request, "from", "");
if(strFrom.equals("mo")){
}else{
	if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") >= 0){
		strAgent = "mobile";
	}else if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") >= 0 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") >= 0){
		strAgent = "mobile";
	}
}

boolean isFooterBanner = true;
if(event_id.equals("2018012201") || event_id.equals("2018012301")){
	isFooterBanner = false;
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
	<link rel="stylesheet" type="text/css" href="/css/event/workers_6th_m.css?v=20180226"/>
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/lib/slick.css"/>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery.cookie.js"></script>
	<script src="/mobilefirst/js/lib/jquery.easy-paging.js"></script>
    <script src="/mobilefirst/js/lib/jquery.paging.min.js"></script>
    <script src="/common/js/function.js?v=20190102"></script>
	<script src="/mobilefirst/js/utils.js"></script>
	<script src="/mobilefirst/js/lib/ga.js"></script>
	<%if(event_id.equals("2018012201")){ %>
	<link rel="stylesheet" href="/css/knowcom/common.css" type="text/css">
	<link rel="stylesheet" href="/css/knowcom/default.css" type="text/css">
	<link rel="stylesheet" href="/css/knowcom/swiper.min.css" type="text/css">
	<script type="text/javascript" src="/js/swiper.min.js"></script>
	<script type="text/javascript">
	function CmdRightLogin_m(param){
		if(islogin()){
			location.href = "/knowcom/mybox.jsp?tno="+param+"&freetoken=eventclone";
		}else{
			location.href = "/mobilefirst/login/login.jsp?backUrl="+encodeURIComponent(document.location.href)+"&freetoken=event";
		}
		return false;
	}
	</script>
	<%} %>
</head>

<body class="<%=strAgent %>">
<div class="wrap" id="MainWrap">

	<%if(event_id.equals("2018012201")){ %>
		<%@ include file="/knowcom/include/common.jsp"%>
	<%}else{ %>
	<div class="myarea">
		<a href="javascript:///" class="win_close">창닫기</a>
	    <%if(cUserId.equals("")){%>
	        <p class="name">나의 e머니는 얼마일까?<button type="button" class="btn_login">로그인</button></p>
	   	<%}else{%>
	        <p class="name"><%=userArea%> 님<span id="my_emoney"></span></p>
	   	<%}%>
	</div>
	<%} %>
	<div class="mainvisual" style="margin-top:35px;" >
		<div class="img_box" id="office_img_box">
			<div class="ir_txt">
				<h1>직장공감 6탄</h1>
				<p>회사에 지친 당신을 위해 준비했다!</p>
			</div>
			<%-- <img src="http://storage.enuri.gscdn.com/Web_Storage/<%=office_event_img1%>" alt="" /> --%>

			<%if(event_id.equals("2018012201")){ %>
			<!-- 쇼핑지식 개편맞이 이벤트 -->
			<div class="btn_group">
				<a href="http://www.enuri.com/knowcom/detail.jsp?bbsname=notice&kbno=682484&freetoken=shoppingknow" target="_blank" class="btn_abs btn01">최적의 커뮤니티 알아보기</a>
				<a href="http://www.enuri.com/knowcom/detail.jsp?bbsname=notice&kbno=682527&freetoken=shoppingknow" target="_blank" class="btn_abs btn02">모바일 글쓰기 알아보기</a>
				<a href="http://www.enuri.com/knowcom/detail.jsp?bbsname=notice&kbno=683090&freetoken=shoppingknow" target="_blank" class="btn_abs btn03">e-MONEY 리워드 알아보기</a>
				<a href="http://www.enuri.com/knowcom/detail.jsp?bbsname=notice&kbno=683109&freetoken=shoppingknow" target="_blank" class="btn_abs btn04">마이페이지 신설 알아보기</a>

				<a href="#" class="btn_abs btn05" onclick="onoff('notetxt')">당첨안내 및 유의사항</a>
			</div>
			<!-- //쇼핑지식 개편맞이 이벤트 -->
			<%} %>
		</div>
	</div>

	<!-- 직장공감 콘텐츠 -->
	<div class="cont_area">

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
                <ul class="list" id="paging" style="display:none;">
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

<!-- 1 이벤트 유의사항 -->
<div class="layer_back over_ht" id="notetxt" style="display:none">
	<div class="appLayer">
		<h4>유의사항</h4>
		<a href="javascript:///" class="close" onclick="onoff('notetxt')">창닫기</a>
		<div class="txt">
			<ul class="txt_indent">
				<li>쇼핑지식 개편 이벤트는 쇼핑지식에 로그인 한 회원만 참여 가능합니다.</li>
				<li>재고 소진 시 경품이 변경 될 수 있습니다.</li>
				<li>경품발송을 위해 수집된 정보는 당첨자의 확인 및 경품발송을 위한 본인확인 이외의 목적으로 활용되지 않으며, 이용 후 파기됩니다.</li>
				<li>입력한 정보는 수정하실 수 없으며, 잘못된 정보 입력으로 인한 경품 수령의 불이익은 책임지지 않습니다.</li>
				<li>부정 참여 시 당첨이 취소될 수 있습니다.</li>
				<li>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</li>
			</ul>
		</div>
		<p class="btn_close"><button type="button" onclick="onoff('notetxt'); return false;">확인</button></p>
	</div>
</div>

<script>
var vOs_type = "";
var logNm = "";

var pageno = 1;
var pagesize = 4;
var totalcnt = 0;

var event_id = "<%=event_id%>";
var isTest=false;
var start_date = "";
var end_date = "";
var office_event_img1 = "";
var office_event_img2 = "";
var office_event_img3 = "";
var office_event_img4 = "";
var office_event_img5 = "";
var office_event_img6 = "";
var office_event_img7 = "";
var btn_img ="";
var btn_url ="";
var event_name ="";
var textCnt = 0;
var isFooterBanner = <%=isFooterBanner %>;
$(function() {
	if($.cookie('appYN') == 'Y' && '<%=strApp %>' == 'Y'){
	     logNm = "APP";
	     if(navigator.userAgent.indexOf("Android") > -1)           vOs_type = "MAA";
	     else           vOs_type = "MAI";
	}else{
	     logNm = "Web";
	     if(navigator.userAgent.indexOf("Android") > -1)           vOs_type = "MWA";
	     else           vOs_type = "MWI";
	}

	$.ajax({
        type: "POST",
        url: '/mobilefirst/evt/officeworker_getlist.jsp',
        data : "event_id="+event_id,
        dataType: "JSON",
        async : false,
        success: function(result){
           try{
                event_id = result.event_id;
                event_name = result.event_name;
                $("#event_name").text(event_name);
                start_date = result.start_date;
                end_date = result.end_date;
                office_event_img1 = result.office_event_img1;
                office_event_img2 = result.office_event_img2;
                office_event_img3 = result.office_event_img3;
                office_event_img4 = result.office_event_img4;
                office_event_img5 = result.office_event_img5;
                office_event_img6 = result.office_event_img6;
                office_event_img7 = result.office_event_img7;
                btn_img = result.btn_img;
                btn_url = result.btn_url;
                isTest = <%=isTest%>;
                //오픈전이고 테스트용이 아니면
                if(!isTest && !startChk()){
                    alert("이벤트 오픈 전입니다.");
                  	document.location.href = "/mobilefirst/index.jsp"
                    return;
                }

                if( office_event_img1.indexOf(".jpg") > -1 )	$("#office_img_box").append("<img src=\""+office_event_img1+"\" alt=\"\" />");
                if( office_event_img2.indexOf(".jpg") > -1 )	$("#office_img_box").append("<img src=\""+office_event_img2+"\" alt=\"\" />");
                
                if( btn_img.indexOf(".jpg") > -1 )     	$("#office_img_box").append("<img src='"+btn_img+"' alt='' / onclick=goUrl('"+btn_url+"'); >");
    			
                if(office_event_img3.indexOf(".jpg") > -1 )	$("#office_img_box").append("<img src=\""+office_event_img3+"\" alt=\"\" />");
                if(office_event_img4.indexOf(".jpg") > -1 ) $("#office_img_box").append("<img src=\""+office_event_img4+"\" alt=\"\" />");
                if(office_event_img5.indexOf(".jpg") > -1 )	$("#office_img_box").append("<img src=\""+office_event_img5+"\" alt=\"\" />");
                if(office_event_img6.indexOf(".jpg") > -1 )	$("#office_img_box").append("<img src=\""+office_event_img6+"\" alt=\"\" />");
                if(office_event_img7.indexOf(".jpg") > -1)	$("#office_img_box").append("<img src=\""+office_event_img7+"\" alt=\"\" />");

           } catch (exception){
                console.log('exception : ' + exception);
           }
           if ( ! ( 'event_id' in result ) ) {
        	   alert("잘못된 접근입니다.");
        	   document.location.href = "/mobilefirst/index.jsp"
               return;
           }

        },error: function (xhr, ajaxOptions, thrownError) {
           }
     }); // End of ajax (movie_getlist.jsp)

	getEventlist();

    if(isFooterBanner){
    	footerBannerLoading();
    }else{
    	$(".other_list").hide();
    }

	getPoint();
	 /*
	 $(".img_box").click(function(){
	     ga('send', 'event', 'mf_event', '2017_직장공감', '페이스북에 남기기');
	     if("<%=strApp %>" == 'Y')    window.location.href = "https://m.facebook.com/story.php?story_fbid=1424401737619767&substory_index=0&id=160451777348109&freetoken=outlink";
	     else window.open("https://m.facebook.com/story.php?story_fbid=1424401737619767&substory_index=0&id=160451777348109&freetoken=outlink");
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

	 ga('send', 'pageview', {
	 	    'page': '/mobilefirst/evt/office_workers.jsp?event_id='+event_id,
	 	    'title': '[모바일]'+event_name
	 	});

});

function goUrl(btn_url){
	ga('send', 'event', 'mf_event', event_name+'_'+logNm, event_name+'_버튼클릭');

	if(logNm=="Web"){
		window.open(btn_url);
		return false;
	}else if (logNm=="APP"){
		window.location.href = btn_url;
		return false;
	}
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

function getEventlist(){
$.ajax({
          type: "GET",
          url: "/event2016/mobile_award_getlist.jsp",
          data: "pageno="+pageno+"&pagesize="+pagesize+"&event_id="+event_id+"&del_yn=N",
          dataType: "JSON",
          success: function(json){
                $("#xams_msg").html(null);

                if(json.eventlist){

                     var template = "";
                     if(json.eventlist.length>0){
                    	 totalcnt = json.eventlist[0].totalcnt;
                     }

                     $("#paging").easyPaging(totalcnt, {
                    	 perpage : 4,
                    	 onSelect: function(page) {
                    		 perpage = 4;
                    		 pageno = page;
                    		 getEventlist2();
                		 }
                     });
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
	  ga('send', 'event', 'mf_event', event_name, '등록하기');
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

		if(count == 0){
		  alert("내용을 입력해주세요!");
		}else{
		   var vData = {replyMsg:reply, osType:vOs_type, eventId:event_id,replyType:"O"};
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
		           }else if(result==-5){
						
		        	   var r = confirm("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?");
					   if(r){
						   location.href = "https://m.enuri.com/mobilefirst/member/myAuth.jsp?cmdType=&f=m&freetoken=login_title";
					   }

		           }else{
		            	alert("이미 참여하셨습니다. \n1일 1회 참여가능합니다.");
		           }
		      },
		        error: function (xhr, ajaxOptions, thrownError) {}
		   });
		}
	}else{
		alert('이벤트가 종료되었습니다.');
	}
}

function getEventlist2(){
$.ajax({
          type: "GET",
          url: "/event2016/mobile_award_getlist.jsp",
          data: "pageno="+pageno+"&pagesize="+pagesize+"&event_id="+event_id+"&del_yn=N",
          dataType: "JSON",
          success: function(json){
                $("#xams_msg").html(null);
                if(json.eventlist){
                     var template = "";

                     for(var i=0;i<json.eventlist.length;i++){
                        var userId = json.eventlist[i].user_id;
						if(userId.length>9) id = userId.substring(0,4)+"**"+"..";
						else  id = userId.substring(0, userId.length-2)+"**";

						var reply_date = json.eventlist[i].reply_date;
						var year = reply_date.substring(0,4);
						var month = reply_date.substring(6,4);
						var day = reply_date.substring(8,6);
						var date = year+"-"+month+"-"+day;
                        var reply_msg = XSSfilters(json.eventlist[i].reply_msg);
						if(i==0) totalcnt = json.eventlist[i].totalcnt;

                        template += "<li>";
                        template += "<div class='head'>";
                        template += "	<p class='user'>"+id+"</p>";
                        template += "	<p class='date'>"+date+"</p>";
                        template += "</div>";
                        template += "<p class='cont'>"+reply_msg+"</p>";
                    	template += "</li>";
                     }
                     $(".view_area > ul").html(template);
                }
                $("#paging").show();
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
	var sdt = "<%=sdt%>";
	var limit_year = end_date.substr(0,4);
	var limit_month = end_date.substr(5,2);
	var limit_day = end_date.substr(8,2);

	var endDate = limit_year + limit_month + limit_day;
	if(sdt > endDate){
		return false;
   	}else{
   		return true;
   	}

   //var limit = new Date(limit_year, limit_month-1, limit_day+1);
   //alert(limit_day);
   //return new Date().getTime() <= limit.getTime();
}
function startChk(){
	var sdt = "<%=sdt%>";
	var start_year = start_date.substr(0,4);
	var start_month = start_date.substr(5,2);
	var start_day = start_date.substr(8,2);

	var startDate = start_year + start_month + start_day;
	if(sdt < startDate){
		return false;
   	}else{
   		return true;
   	}
}

function XSSfilters(content) {
	return content.replace(/\</g, "&lt;").replace(/\>/g, "&gt;");
}


</script>
</body>
<script language="JavaScript" src="http://imgenuri.enuri.gscdn.com/common/js/Log_Tail_Mobile.js"></script>
</html>
