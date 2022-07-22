<%@ page contentType="text/html; charset=utf-8" %>
<%@include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@ page import="com.enuri.bean.event.Members_Friend_Proc"%>
<%@ page import="com.enuri.util.http.ShortUrl"%>
<jsp:useBean id="Members_Friend_Proc" class="com.enuri.bean.event.Members_Friend_Proc" scope="page" />
<jsp:useBean id="ShortUrl" class="com.enuri.util.http.ShortUrl" scope="page" />
<%
String strFb_title = "[에누리 가격비교] WELCOME 혜택!";
String strFb_description = "첫 구매 고객이라면 누구나 최대 e머니 17,000점!";
String strFb_img = "http://img.enuri.info/images/mobilefirst/etc/welcomesns.jpg";
String oc = ChkNull.chkStr(request.getParameter("oc"));
SimpleDateFormat prevFormat = new SimpleDateFormat("yyyyMMdd");
SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy. M. d");

//String strGTmpid    = cb.GetCookie("GATEP","TMP_ID");
//String strGkind     = cb.GetCookie("GATEP","GKIND");
//String strGno       = cb.GetCookie("GATEP","GNO");
String browser = request.getHeader("User-Agent");
String pd = ChkNull.chkStr(request.getParameter("pd"));

//초대받고 온사람용
int recSeq = ChkNull.chkInt(request.getParameter("rec_seq"));
String remId = ChkNull.chkStr(Members_Friend_Proc.getRecommenderid(recSeq),"");

if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1
|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1
|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1
|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){

}else{
	response.sendRedirect("/event2017/new_friend_20179.jsp?rec_seq="+recSeq);
	return;
}

String appYN = ChkNull.chkStr(request.getParameter("app"),"");
String strTab = ChkNull.chkStr(request.getParameter("tab"),"");

if(remId != null && !remId.equals(""))	strTab = "2";

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

String cUserId = cb.GetCookie("MEM_INFO","USER_ID");
String cUserNick = cb.GetCookie("MEM_INFO","USER_NICK");
String recUserid = Members_Friend_Proc.getRec_UserId2(cUserId);

String strUuid = "";
String a_chk_id  = "";
String i_chk_id  = "";

Cookie[] carr = request.getCookies();
String strChk_id = "";

try {
	for(int i=0;i<carr.length;i++){
	    if(carr[i].getName().equals("chk_id")){
	    	strChk_id = carr[i].getValue();
	    	break;
	    }
	}
} catch(Exception e) {}

if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){
	if(appYN.equals("Y")){
		a_chk_id 	= ChkNull.chkStr(request.getParameter("chk_id"), "").trim();
		i_chk_id 	= ChkNull.chkStr(request.getParameter("i_chk_id"), "").trim();

		if(i_chk_id.equals(""))			i_chk_id = a_chk_id;

		cb.SetCookie("MOBILEWEBIUUID", "I_UUID", i_chk_id);
		cb.SetCookieExpire("MOBILEWEBIUUID", 3600*24*14);
		cb.responseAddCookie(response);
	}
}else{
	if(!strChk_id.equals("")){
		appYN = "Y";

		a_chk_id 	= strChk_id ;
		i_chk_id 	= ChkNull.chkStr(request.getParameter("i_chk_id"), "").trim();

		if(i_chk_id.equals(""))			i_chk_id = a_chk_id;

		cb.SetCookie("MOBILEWEBIUUID", "I_UUID", i_chk_id);
		cb.SetCookieExpire("MOBILEWEBIUUID", 3600*24*14);
		cb.responseAddCookie(response);
	}else{
		a_chk_id 	=  ChkNull.chkStr(request.getParameter("chk_id"), "").trim();
	}
}
Members_Proc members_proc = new Members_Proc();

String cUsername = "";
String userArea = "";

if(!cUserId.equals("")){
    cUsername = members_proc.getUserName(cUserId);
    userArea = cUsername;

    if(cUsername.equals("")) userArea = cUserNick;
    if(userArea.equals(""))  userArea = cUserId;

}
if(appYN.isEmpty()){
	appYN = "N";
	try{
		Cookie[] cookies = request.getCookies();

		if(cookies!=null){
			for(int i=0; i<cookies.length; i++){
				if(cookies[i].getName().equals("appYN")){
					appYN = cookies[i].getValue();
					break;
				}
			}
		}
	}catch(Exception e){
		appYN = "N";
	}finally{}
}else{
	appYN = "Y";
}

long cTime = System.currentTimeMillis();
SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMdd");
String sdt = ChkNull.chkStr(request.getParameter("sdt"));

if(sdt.equals("")){
	sdt = dayTime.format(new Date(cTime));//진짜시간
}

if(Integer.parseInt(sdt)>=20210701){
	response.sendRedirect("/m/event/invite.jsp"); //url 변경
	return;
}

int numSdt = Integer.parseInt(sdt);
String startDate = "";
String  endDate = "";

boolean isNext = false;

int point = 9000;
int point2 = 900;

if( numSdt >= 20210301 ){
	isNext = true;
	startDate = "20210301";
	endDate="20210331";
	point2 = 500;
/* 	strFb_title = "[에누리 가격비교] WELCOME 혜택!";
	strFb_description = "첫 구매 고객이라면 누구나 최대 e머니 17,000점!";
	strFb_img = "http://img.enuri.info/images/mobilefirst/etc/welcomesns.jpg"; */
}else{
	startDate = "20210101";
	endDate="20210131";
	point2 = 500;
}

////////////////////////////
//친구초대 스템프 변경 사항
//upd_reward_nomiee_ranking_stamp_point_ins
//스템프 프로시져 기준 날짜 오픈 날짜로 변경
//friend_getlist2.jsp 스템프 찍히는 기준날짜 변경
//소스에 오픈날짜 , 유의사항 날짜 수정
///////////////////////////
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
	<link rel="stylesheet" href="/css/event/com.enuri.event.m.css" type="text/css">
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/lib/slick.css">
	<link rel="stylesheet" type="text/css" href="/css/swiper.css">
	<link rel="stylesheet" href="/css/event/y2021_rev/buyfirst_may_m.css" type="text/css">
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/event/layer_pop.css">
	<script type="text/javascript" src="http://m.enuri.com/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
	<script type="text/javascript" src="/js/swiper.min.js"></script>
	<script type="text/javascript" src="/common/js/function.js"></script>
	<script type="text/javascript">
	var APPLYCNT = 0;
	var shareUrl = "http://" + location.host + "/mobilefirst/evt/new_friend_20179.jsp?oc=mo";
	var shareTitle = "<%=strFb_title%> <%=strFb_description%>";
	//카카오톡 키

	(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
		(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
		m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
		})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
		//런칭할때 UA-52658695-3 으로 변경
		ga('create', 'UA-52658695-3', 'auto');
	//레이어
	function onoff(id) {
		var mid=document.getElementById(id);

		if(id == "eventJoin"){
			if(!islogin()){
				location.href = "/mobilefirst/login/login.jsp?backUrl="+encodeURIComponent(document.location.href);
				return false;
			}
			if( $(".invcode").text()  == ""  ){

				alert("나의 초대코드를 확인하고 친구를 초대하세요!");

				var evt2 = $("#evt2").offset().top;
				$('html, body').stop().animate({scrollTop: evt2}, 500);

				return false;
			}
			if(APPLYCNT > 0 ){
				alert("이미 참여하셨습니다!\n이벤트 기간 동안 초대한 친구가 코드 입력하면 자동 집계되며,\n초대한 친구 수는 익일 반영됩니다. ");
				return false;
			}
		}
		if(mid.style.display=='') mid.style.display='none';
		else		              mid.style.display='';
	}
	</script>

<script>
(function(a_,i_,r_,_b,_r,_i,_d,_g,_e){if(!a_[_b]){var d={queue:[]};_r.concat(_i).forEach(function(a){var i_=a.split("."),a_=i_.pop();i_.reduce(function(a,i_){return a[i_]=a[i_]||{}},d)[a_]=function(){d.queue.push([a,arguments])}});a_[_b]=d;a_=i_.getElementsByTagName(r_)[0];i_=i_.createElement(r_);i_.onerror=function(){d.queue.filter(function(a){return 0<=_i.indexOf(a[0])}).forEach(function(a){a=a[1];a=a[a.length-1];"function"===typeof a&&a("error occur when load airbridge")})};i_.async=1;i_.src="//static.airbridge.io/sdk/latest/airbridge.min.js";a_.parentNode.insertBefore(i_,a_)}})(window,document,"script","airbridge","init fetchResource setBanner setDownload setDownloads setDeeplinks sendSMS sendWeb setUserAgent setUserAlias addUserAlias setMobileAppData setUserId setUserEmail setUserPhone setUserAttributes clearUser setDeviceIFV setDeviceIFA setDeviceGAID events.send events.signIn events.signUp events.signOut events.purchased events.addedToCart events.productDetailsViewEvent events.homeViewEvent events.productListViewEvent events.searchResultViewEvent".split(" "),["events.wait"]);
airbridge.init({
    app: 'enuri',
    webToken: 'f430f10352c54cc9aa2203b98e67be9e'
});
</script>
</head>
<body>
<div class="lay_only_mw" style="display: none;">
	<div class="lay_inner">
		<div class="lay_head">
			앱에서는 득템의 기회 <em>타임특가</em>에 참여할 수 있어요!
		</div>
		<!-- 버튼 : 에누리앱으로 보기 -->
		<button class="btn_go_app" onclick="view_moapp();">에누리앱으로 보기</button>
		<!-- 버튼 : 모바일웹으로 보기 -->
		<a href="javascript:void(0);" class="btn_keep_mw" onclick="$('.lay_only_mw').fadeOut(100);">괜찮아요. 모바일 웹으로 볼래요</a>
	</div>
</div>
<!-- URL 레이어 -->
<div class="layerPop" id="layer_geturl" style="display:none;">
	<div class="layerPopInner">
		<div class="layerPopCont">
			<h1>URL 복사</h1>
			<button class="btnClose" type="button" onclick="onoff('layer_geturl')">창 닫기</button>
			<div class="contents">
				<p class="url_txt">
					<span id="url_text">아래의 URL을 길게 누르면 복사할 수 있습니다.</span>
					<span class="input_copy"><input type="text" class="urlCopy" id="txt_getUrl" value="" /></span>
				</p>
			</div>
			<div class="layerBtn"><button class="btnTxt" type="button" onclick="onoff('layer_geturl')">닫기</button></div>
		</div>
	</div>
</div>
<!--// URL 레이어 -->
<!-- 초대 하기 유의사항																		(2017-08-22 내용수정) -->
<div class="layer_back" id="Caution1" style="display:none;">
	<div class="noteLayer">
		<h4>꼭! 확인하세요</h4>
		<a href="javascript:///" class="close" onclick="onoff('Caution1')">창닫기</a>
		<dl class="txtlist">
			<dt>초대하는 회원</dt>
			<dd>친구가 앱 첫구매 후 초대혜택을 받을 때, 초대한 회원에게도 자동적립됩니다. (앱 푸쉬메시지 알림)</dd>
			<dd>본인인증하고 이벤트 정보수집에 동의해야 초대코드가 유효하며, 인증정보는 이벤트 종료 시까지 보관합니다.</dd>
			<dd>본인인증된 ID가 여러 개인 경우, 처음 초대코드를 받은 ID만 유효하며, 다른 ID로는 초대할 수 없습니다.</dd>
			<dd>초대하는 친구 수에는 제한이 없습니다.</dd>

			<dt>초대받은 친구</dt>
			<!-- <dd>첫 구매 후 마이에누리&gt;적립내역에서 '적립받기'로 구매적립 받아야 초대혜택 적립됩니다.</dd> -->
			<dd>본인인증하고 이벤트 정보수집에 동의해야 초대코드를 등록할 수 있으며, 인증정보는 이벤트 종료 시까지 보관합니다.</dd>
			<dd>ID당 1개의 초대코드만 등록, 1회 참여 가능</dd>
			<dd>기존 구매이력이 있는 휴대폰 기기에서는 첫구매 혜택 받을 수 없습니다.</dd>

			<dt>유의사항</dt>
			<dd>초대 받은 친구와 초대한 친구가 서로 초대 불가 (기준: ID, 휴대폰기기, 본인인증)</dd>
			<dd>부정 참여 시 적립이 취소 될 수 있습니다.</dd>
			<dd>본 이벤트는 당사의 사정에 따라 사전고지 없이 변경 또는 조기종료 될 수 있습니다.</dd>
		</dl>
	</div>
</div>

<!-- 초대받기 유의사항																		(2017-08-22 내용수정) -->
<div class="layer_back topfixed" id="Caution2" style="display:none;">
	<div class="noteLayer">
		<h4>꼭! 확인하세요</h4>
		<a href="javascript:///" class="close" onclick="onoff('Caution2')">창닫기</a>
        <!-- 200609 유의사항 교체-->
        <div class="txt">
            <h5>[ 초대하기 &gt; 혜택 1 ]</h5>
            <strong>이벤트 대상 및 혜택</strong>
            <ul class="txt_indent">
                <li>이벤트 대상 : 이벤트 기간 내 나의 초대코드를 등록한 친구가 3명인 고객</li>
                <li>이벤트 기간 : 매월 1일 ~ 말일</li>
                <li>이벤트 혜택 : 맥카페 아메리카노 (e머니 1,500점)</li>
                <li>혜택 지급일 : 스탬프 완성일로부터 7일 후 적립</li>
                <li><span class="stress">e머니 유효기간 : 적립일로부터 15일 (유효기간 만료 후 재적립 불가)</span><br>
                    ※ 적립된 e머니는 e쿠폰 스토어에서 다양한 쿠폰으로 교환가능합니다.</li>
            </ul>
            <strong>이벤트 참여방법 및 유의사항</strong>
            <ul class="txt_indent">
                <li>참여방법 : 에누리 가격비교 모바일 앱 로그인 → 초대코드 확인 → 친구에게 초대코드 전달 → 친구가 초대코드 등록 시 스탬프 자동 참여<br>
                    ※ 나의 초대코드는 PC 및 모바일 앱/웹에서 로그인 후에도 확인 가능합니다. </li>
                <li>본 이벤트는 초대하는 친구 수에는  제한이 없습니다. </li>
                <li>본 이벤트는 본인인증 및 이벤트 정보 활용 동의 후 확인 가능합니다.</li>
                <li>본 이벤트는 처음 초대코드 받은 ID만 유효하며, 동일한 본인인증으로 가입한 다른 ID의 경우 초대가 불가합니다.</li>
                <li><span class="stress">이벤트 대상 제외 :</span>&nbsp;아래의 경우에는 이벤트 대상 및 혜택 지급에서 제외됩니다.<br>
                    <ul>
                        <li>- 나의 초대코드 등록한 친구가 3명 미만인 경우</li>
                        <li>- 동일한 본인인증으로 가입한 다수의 ID로 중복 참여한 경우</li>
                    </ul>
                </li>
            </ul>
            <br>
            <h5>[ 초대하기 &gt; 혜택 2 ]</h5>
            <strong>이벤트 대상 및 혜택</strong>
            <ul class="txt_indent">
                <li>이벤트 대상 : 이벤트 기간 내 초대한 친구가 초대코드 등록 후 에누리 가격비교 모바일 앱에서 첫 구매한 고객  (※ 자동 적립)<br>
                    <span class="stress">※ 구매 유의사항 및 구매적립 제외 카테고리는 초대받기 유의사항 내 ▶e머니 구매적립 기준 및 유의사항◀을 꼭 확인하세요.</span>
                </li>
                <li>이벤트 기간 : 첫 구매일로부터 30일 이내 (※ 초대한 친구의 첫 구매일)</li>
                <li>이벤트 혜택 : e머니 9,000점 (※ 초대한 친구 &amp; 초대받은 친구 각각 지급)</li>
                <li>혜택 지급일 : 구매일로부터 최대 30일 이내 적립 (※ 해외직구 상품 구매 시 최대 70일 소요)</li>
                <li><span class="stress">e머니 유효기간 : 적립일로부터 15일 (유효기간 만료 후 재적립 불가)</span><br>
                    ※ 적립된 e머니는 e쿠폰 스토어에서 다양한 쿠폰으로 교환가능합니다.</li>
            </ul>
            <strong>공통 이벤트 유의사항</strong>
            <ul class="txt_indent">
                <li>부정 참여 시 본 이벤트 대상 제외 및 혜택 지급이 취소될 수 있습니다. </li>
                <li>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</li>
            </ul>
        </div>
		<!-- // -->
		<div class="btn_close">
			<button type="button" onclick="onoff('Caution2')">닫기</button>
		</div>
    </div>
</div>
<!-- 앱설치 유의사항 -->
<div class="layer_back topfixed" id="Caution3" style="display:none;">

	<div class="noteLayer">
		<h4>꼭! 확인하세요</h4>
        <a href="javascript:///" class="close" onclick="onoff('Caution3')">창닫기</a>
        <!-- 200609 유의사항 교체-->
        <div class="txt">
            <h5>[ 초대받기 &gt; 혜택 1 ]</h5>
            <strong>이벤트 대상 및 혜택</strong>
            <ul class="txt_indent">
                <li>이벤트 대상 : 이벤트 기간 내 친구에게 받은 초대코드를 등록한 고객</li>
                <li>이벤트 기간 : 매월 1일 ~ 말일</li>
                <li>이벤트 혜택 : e머니 500점</li>
                <li>혜택 지급일 : 초대코드 등록 시 즉시 적립</li>
                <li><span class="stress">e머니 유효기간 : 적립일로부터 15일 (유효기간 만료 후 재적립 불가)</span><br>
                    ※ 적립된 e머니는 e쿠폰 스토어에서 다양한 쿠폰으로 교환가능합니다.</li>
            </ul>
            <strong>이벤트 참여방법 및 유의사항</strong>
            <ul class="txt_indent">
                <li>참여방법 : 에누리 가격비교 모바일 앱 로그인 → 친구에게 받은 초대코드 등록</li>
                <li>본 이벤트는 ID당 1회만 참여 가능합니다.</li>
                <li>본 이벤트는 본인인증 및 이벤트 정보 활용 동의 후 가능합니다.</li>
                <li><span class="stress">이벤트 대상 제외 :</span>&nbsp;아래의 경우에는 이벤트 대상 및 혜택 지급에서 제외됩니다.<br>
                    <ul>
                        <li>- 친구에게 받은 초대코드를 등록하지않은 경우</li>
                        <li>- 동일한 본인인증으로 가입한 다수의 ID로 중복 참여한 경우</li>
                    </ul>
                </li>
            </ul>
            <br>
            <h5>[ 초대받기 &gt; 혜택 2 ]</h5>
            <strong>이벤트 대상 및 혜택</strong>
            <ul class="txt_indent">
                <li>이벤트 대상 : 이벤트 기간 내 초대코드 등록 후 에누리 가격비교 모바일 앱에서 1만원 이상 첫 구매한 고객 (※ 1만원 이상 첫 구매 후 첫구매 혜택 이벤트 신청한 고객)</li>
                <li>이벤트 기간 : 첫 구매일로부터 30일 이내 </li>
                <li>이벤트 혜택 : e머니 9,000점 (※ 초대한 친구 &amp; 초대받은 친구 각각 지급)</li>
                <li>혜택 지급일 : 구매일로부터 최대 30일 이내 적립 (※ 해외직구 상품 구매 시 최대 70일 소요)</li>
                <li><span class="stress">e머니 유효기간 : 적립일로부터 15일 (유효기간 만료 후 재적립 불가)</span><br>
                    ※ 적립된 e머니는 e쿠폰 스토어에서 다양한 쿠폰으로 교환가능합니다.</li>
            </ul>
            <strong>이벤트 참여방법 및 유의사항</strong>
            <ul class="txt_indent">
                <li>참여방법 : 에누리 가격비교 모바일 앱 로그인 → 초대코드  등록 →&nbsp;적립대상 쇼핑몰 이동 →&nbsp;<span class="stress">1만원 이상 구매</span>&nbsp;→  첫구매 혜택 이벤트 신청</li>
                <li>본 이벤트는 ID당 1회만 참여 가능합니다.</li>
                <li>적립대상 쇼핑몰 : G마켓, 옥션, 11번가, 인터파크, 티몬, 위메프, 쿠팡, GS SHOP, Cjmall, SSG (신세계몰, 신세계백화점, 이마트몰, 트레이더스), 에누리 해외직구관, SK스토아, 홈플러스<br>
                    <span class="stress">※ 구매 유의사항 및 구매적립 제외 카테고리는 유의사항 내 ▶e머니 구매적립 기준 및 유의사항◀을 꼭 확인하세요.</span>
                </li>
                <li>본 이벤트는 ID당 1회 참여 가능합니다.  </li>
                <li>본 이벤트는 ID와 구매한 모바일 기기 모두 첫 구매일 경우에만 참여 가능합니다. (※ 구매한 모바일 기기에 구매이력이 있으면 참여 불가)</li>
                <li>본 이벤트는 본인인증 및 이벤트 정보 활용 동의 후 참여 가능합니다.</li>
                <li><span class="stress">본 이벤트는 모바일 앱에서만 참여가 가능한 모바일 앱전용 프로모션 입니다.</span></li>
                <li><span class="stress">본 이벤트는 첫 설치한 모바일 앱이  아니더라도 해당 ID, 모바일 기기에서 구매이력이 없다면 참여 가능합니다.</span></li>
                <li><span class="stress">본 이벤트는 ID(본인인증), 초대코드 등록, 첫 구매, 첫구매 혜택 신청을 모두 동일한 모바일 기기에서 진행한 경우에만 혜택 지급 가능합니다.</span></li>
                <li>구매금액은 배송비, 설치비, 할인, 쇼핑몰 포인트 등 제외한 금액만 반영됩니다.</li>
                <li><span class="stress">이벤트 대상 제외 :</span>&nbsp;아래의 경우에는 이벤트 대상 및 혜택 지급에서 제외됩니다.<br>
                    <ul>
                        <li>- 첫구매 혜택 이벤트 신청하지 않은 경우 </li>
                        <li>- 실제 구매금액이 1만원 미만의 구매일 경우</li>
                        <li>- 구매적립 제외 카테고리 구매일 경우 (※ 첫구매 혜택 신청일로부터 30일 이내 재구매 시 혜택 지급 가능)</li>
                        <li>- 구매 후 취소/환불/교환/반품한 경우 (※ 첫구매 혜택 신청일로부터 30일 이내 재구매 시 혜택 지급 가능)</li>
                        <li>- 동일한 본인인증으로 가입한 다수의 ID로 중복 참여한 경우</li>
                        <li><span class="stress">- 웰컴백 첫구매 페이백 받은 고객 (중복 지급 불가)</span></li>
                    </ul>
                </li>
            </ul>
            <strong>공통 이벤트 유의사항</strong>
            <ul class="txt_indent">
                <li>부정 참여 시 본 이벤트 대상 제외 및 혜택 지급이 취소될 수 있습니다. </li>
                <li>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</li>
            </ul>
            <strong>▶e머니 구매적립 기준 및 유의사항◀</strong>
            <ul class="txt_indent">
                <li>구매적립 e머니는 구매일로부터 10 ~ 30일간 취소/환불/교환/반품여부 확인 후 적립 됩니다.</li>
                <li><span class="stress">구매적립 e머니 유효기간 : 적립일로부터 60일 (유효기간 만료 후 재적립 불가)</span><br>※ 적립된 e머니는 e쿠폰 스토어에서 다양한 쿠폰으로 교환가능합니다.</li>
                <li>구매적립 e머니는 최소 10점(구매금액 1천원 이상)부터 적립되며, 1원 단위 e머니는 적립되지 않습니다.</li>
                <li>구매적립 e머니는 구매확정(구매일로부터 최대 30일) 시점부터 MY 에누리 적립내역 페이지에서 확인 가능합니다.</li>
                <li>구매금액은 배송비, 설치비, 할인, 쇼핑몰 포인트 등 제외한 금액만 반영됩니다. </li>
                <li>적립대상 쇼핑몰에서 장바구니에 여러 상품을 담아 한 번에 결제하는 경우, 구매건수는 1건이며 구매금액은 통합된 금액으로 e머니 적립 됩니다.</li>
                <li>구매적립 e머니는 카테고리별 차등 적립됩니다.<br><br>
                    ※ 카테고리별 적립률
                    <div class="tb">
                        <table>
                            <colgroup>
                                <col width="70%"><col width="30%">
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th>카테고리</th>
                                    <th>적립률</th>
                                </tr>
                                <tr>
                                    <td>유아,완구</td>
                                    <td>1.5%</td>
                                </tr>
                                <tr>
                                    <td>식품/스포츠,레저/자동차/화장품</td>
                                    <td>1.0%</td>
                                </tr>
                                <tr>
                                    <td>컴퓨터/도서/문구,사무/PC부품</td>
                                    <td>0.8%</td>
                                </tr>
                                <tr>
                                    <td>디지털/영상,디카</td>
                                    <td rowspan="4">0.3%</td>
                                </tr>
                                <tr>
                                    <td>가전(생활,주방,계절)</td>
                                </tr>
                                <tr>
                                    <td>패션/잡화</td>
                                </tr>
                                <tr>
                                    <td>가구,인테리어</td>
                                </tr>
                                <tr>
                                	<td>생활,취미</td>
                                	<td rowspan="2">0.2%</td>
                                </tr>
                                <tr>
                                    <td>모바일쿠폰,상품권<br>
                                        <p style="font-size:10px;margin-top:4px;color:#e91030">*특정 상품에 한하여 적립되오니<br>적립가능 상품은 하단에서 확인해주세요.</p>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </li>
            </ul>
            <strong><span class="stress">[모바일쿠폰,상품권 ] 구매적립 기준</span></strong>
            <ul class="txt_indent">
                <li>적립가능 쇼핑몰 : 티몬, G마켓, 옥션</li>
                <li>적립가능 상품 (0.2% 적립) : 문화상품권(해피머니, 컬쳐랜드), 도서상품권, 백화점상품권, 영화예매권, 국민관광 상품권</li>
                <li>백화점상품권 기준
                    <ul>
                        <li>1) 상품명에 '백화점 상품권' 명시된 상품 또는 백화점에서만 사용할 수 있는 상품권만 적립가능</li>
                        <li>2) 복합상품권 적립불가 (삼성 상품권, 신세계 기프트카드, 롯데카드 상품권, 이랜드 상품권, AK플라자 상품권, 통합 상품권 등)<br>- 복합 상품권의 경우 사용처에 백화점이 기재되어 있는 경우에도 적립불가</li>
                        <li>3) 백화점 상품권으로 전환 가능한 포인트 구매 시 적립불가</li>
                    </ul>
                </li>
            </ul>
            <strong>적립대상 쇼핑몰 중 구매적립 제외 카테고리 및 서비스</strong>
            <ul class="txt_indent">
                <li>에누리 가격비교에서 검색되지 않는 상품</li>
                <li>모바일쿠폰,상품권 : 상품권, 지역쿠폰, e교환권, e쿠폰 등 </li>
                <li>쇼핑몰 제휴 서비스(배달, 티켓, 해외직구 등) 및 일부 카테고리
                    <ul>
                        <li>- G마켓 : 중고장터, 실시간 여행, 항공권, 도서/음반, 모바일쿠폰/상품권(일부 적립가능)</li>
                        <li>- 옥션 : 중고장터, 실시간 여행, 항공권, 모바일쿠폰/상품권(일부 적립가능)</li>
                        <li>- 11번가 : 여행/숙박/항공, 모바일쿠폰/상품권</li>
                        <li>- 인터파크 : 라이프 서비스(티켓, 투어, 아이마켓 등), 모바일쿠폰/상품권(웰컴팩 상품만 적립가능) </li>
                        <li>- 티몬 : 특가 판매 상품(슈퍼꿀딜, 슈퍼마트 등), 모바일쿠폰/상품권(일부 적립가능)</li>
                        <li>- 위메프 : 모바일쿠폰/상품권</li>
                        <li>- GS SHOP, CJmall : 모바일쿠폰/상품권</li>
                        <li>- SSG : 도서/음반/문구/취미/여행, 모바일쿠폰/상품권</li>
                    </ul>
                </li>
            </ul>
            <strong>공통 구매 유의사항</strong>
            <ul class="txt_indent">
                <li>아래의 경우에는 구매 확인 및 구매적립이 불가합니다.
                    <ul>
                        <li>- 에누리 가격비교 모바일 앱이 아닌 다른 모바일 앱을 통해서 장바구니 또는 관심상품 등록 후 에누리 가격비교 모바일 앱으로 결제만 한 경우</li>
                        <li>- 에누리 가격비교 미 로그인 후 구매한 경우</li>
                        <li>- 에누리 가격비교 PC 및 모바일 웹에서 구매한 경우 (※ 티몬 및 에누리 해외직구관은 PC 및 모바일 앱/웹 구매 시에도 가능)</li>
                    </ul>
                </li>
            </ul>
        </div>
		<!-- // -->
		<div class="btn_close">
			<button type="button" onclick="onoff('Caution3')">닫기</button>
		</div>
	</div>


</div>
<!-- 첫구매 유의사항 -->
<div class="layer_back" id="Caution4" style="display:none;">
	<div class="noteLayer">
		<h4>꼭! 확인하세요</h4>
		<a href="javascript:///" class="close" onclick="onoff('Caution4')">창닫기</a>
		<dl class="txtlist">
			<dt>친구초대 이벤트 유의사항</dt>
			<!-- <dd>첫 구매 후 마이에누리>적립내역에서 ‘적립받기’로 구매적립 받아야 초대혜택 적립됩니다.</dd> -->
			<dd>초대코드 등록 → 앱에서 1만원 이상 첫 구매 → 30일 내 초대혜택 신청 </dd>
			<dd>앱을 새로 설치하지 않아도, 첫구매 조건에 해당하면 혜택을 받을 수 있습니다.</dd>
			<dd>첫 구매를 취소하고, 다시 구매하는 경우는 첫 구매로 인정되지 않습니다.</dd>
			<dd>친구초대혜택을 받으면, 다른 첫구매혜택은 받을 수 없습니다.</dd>
			<dd><b class="emp">e머니 유효기간 : 15일 (유효기간 만료 후 재적립 불가)</b></dd>
			<dt>구매 유의사항</dt>
			<dd>적립대상 쇼핑몰: G마켓, 옥션, 11번가, 인터파크, 티몬, GS SHOP, CJmall, SSG (신세계몰, 신세계백화점, 이마트몰, 트레이더스), 위메프 ,  SK스토아, 홈플러스 </dd>
			<dd>구매금액은 배송비, 설치비, 할인, 쇼핑몰 포인트 등 제외한 상품 결제금액만 반영</dd>
		</dl>
	</div>
</div>

<div class="layer_back" id="Caution5" style="display:none;">
	<div class="noteLayer">
		<h4>유의사항</h4>
		<a href="javascript:///" class="close" onclick="onoff('Caution5')">창닫기</a>
		<dl class="txtlist">
			<dt>이벤트 유의사항</dt>
			<dd>초대킹 랭킹 순위 : 초대코드 등록한 친구가 많은 순으로 순위 정해지며, 친구 수가 동일할 경우 먼저 이벤트 참여한 순으로 순위 발표</dd>
			<dd>당첨자 발표 : 2018년 5월 31일 목요일 [모바일APP &gt; 이벤트탭 &gt; 당첨자 발표]</dd>
			<dd>실물 경품 당첨 시, 응모 시 입력한 휴대폰 번호로 개별연락 드립니다.</dd>
			<dd>휴대폰 번호를 잘못 기입했거나 연락이 닿지 않아 발생하는 불이익에 대해서는 책임지지 않습니다.</dd>
			<dd>e머니 유효기간 : 15일 (유효기간 만료 후 재적립 불가)</dd>
			<dd>부정 참여 시 적립이 취소 될 수 있습니다.</dd>
			<dd>본 이벤트는 당사의 사정에 따라 사전고지 없이 변경 또는 조기종료 될 수 있습니다.</dd>
		</dl>
	</div>
</div>

<!-- layer 개인정보수집 이용동의 -->
<div class="layer_back" id="agree" style="display:none;">
	<div class="agreeLayer">
		<h3>개인정보 수집 및 이용동의</h3>
		<a href="javascript:///" class="close" onclick="onoff('agree')">창닫기</a>
		<div class="agree_txt">
			<span class="code_num">입력한 코드<em id="code_num"><%=remId%></em></span>
			<p>이벤트 참여를 위해 초대한 친구에게<br />앱설치, 첫구매 정보가 공유됩니다.<br />(쇼핑몰ID, 구매내역 등은 제공되지 않음)</p>
			<p><label><input type="checkbox" class="chkbox" id="invitedCheck" checked>정보 공유 동의</label></p>
			<button class="agreebtn" id="agreebtn" >동의 후 초대코드 등록</button>
		</div>
	</div>
</div>
<!--// layer 개인정보수집 이용동의 -->
<!-- layer 인증하고초대코드받기								(2017-08-22 추가) -->
<div class="layer_back" id="myInvite1" style="display:none;">
	<div class="inviteLayer">
		<a href="javascript:///" class="close" onclick="onoff('myInvite1')">창닫기</a>
		<div class="agree_txt">
			<p class="txt1">이벤트 참여를 위해서<br />본인인증정보를 저장합니다.</p>
			<p class="txt2">인증정보는 이벤트 종료시까지 저장되며<br />이벤트 종료 후 파기됩니다.</p>
			<p class="ipt"><label><input type="checkbox" class="chkbox" id="myinfoYN" checked>정보 수집 동의</label></p>
			<button class="agreebtn" id="getCode" >초대코드받기</button>
			<p class="txt2">이벤트 참여 후에는 <br/> 다른 ID로 본인인증하여도<br/> 친구초대이벤트를 참여 할 수 없습니다.</p>
		</div>
	</div>
</div>
<!-- //layer 인증하고초대코드받기 -->
<!-- layer 본인인증후참여	(2017-08-22 추가) -->
<div class="layer_back" id="myInvite2" style="display:none;">
	<div class="inviteLayer">
		<a href="javascript:///" class="close" onclick="onoff('myInvite2')">창닫기</a>
		<div class="agree_txt">
			<p class="txt1">본인인증 후 참여 할 수 있습니다.</p>
			<p class="txt2">인증정보는 이벤트 종료시까지 저장되며<br />이벤트 종료 후 파기됩니다.</p>
			<p class="ipt"><label><input type="checkbox" class="chkbox myinfoYN2" id="myinfoYN2" checked="checked">정보 수집 동의</label></p>
			<button class="agreebtn" onclick="goMyauth(2)">인증하고 이벤트참여하기</button>
			<p class="txt2">이벤트 참여 후에는 <br/> 다른 ID로 본인인증하여도<br/> 친구초대이벤트를 참여 할 수 없습니다.</p>
		</div>
	</div>
</div>
<!-- //layer 본인인증후참여 -->
<div class="layer_back" id="myInvite3" style="display:none;">
	<div class="inviteLayer">
		<a href="javascript:///" class="close" onclick="onoff('myInvite3')">창닫기</a>
		<div class="agree_txt">
			<p class="txt1">본인인증 후 참여 할 수 있습니다.</p>
			<p class="txt2">인증정보는 이벤트 종료시까지 저장되며<br />이벤트 종료 후 파기됩니다.</p>
			<p class="ipt"><label><input type="checkbox" class="chkbox myinfoYN3" id="myinfoYN2" checked="checked">정보 수집 동의</label></p>
			<button class="agreebtn" onclick="goMyauth(3)">인증하고 이벤트참여하기</button>
			<p class="txt2">이벤트 참여 후에는 <br/> 다른 ID로 본인인증하여도<br/> 친구초대이벤트를 참여 할 수 없습니다.</p>
		</div>
	</div>
</div>
<div class="layer_back" id="benefit_layer" style="display:none;">
	<div class="appLayer">
		<h4>모바일 앱 전용 쇼핑 혜택</h4>
		<a href="javascript:///" class="close" onclick="onoff('benefit_layer')">창닫기</a>
		<p class="txt">에누리 앱(APP) 설치 후<br />e머니 적립내역 확인 및<br />다양한 e쿠폰 상품으로 교환할 수 있습니다.</p>
		<p class="btn_close"><button type="button">설치하기</button></p>
	</div>
</div>
<div id="eventWrap">

	<div class="myarea">
		<%if(cUserId.equals("")){%>
			<p class="name">나의 e머니는 얼마일까?<button type="button" class="btn_login">로그인</button></p>
		<%}else{%>
			<p class="name"><%=userArea%> 님<span id="my_emoney">0점</span></p>
		<%}%>
		<a href="#" class="win_close">창닫기</a>
	</div>

	<!-- 비쥬얼,플로팅탭 -->
	<div class="toparea">
		<!-- 공통 : 상단비주얼 -->
		<div class="visual intro end">
			<!-- 공통 : 공유하기 버튼  -->
			<button class="com__btn_share" onclick="$('.com__share_wrap').show();">공유하기</button>
			<!-- // -->
			<div class="inner">
				<span class="txt_01">WELCOME 혜택</span>
                <h2>첫만남에-누리다</h2>
                <span class="txt_02">에누리 첫 구매 고객이라면 누구나 최대 e머니 17,000점 혜택!</span>
                <span class="box_wrap"><!--상자--></span>
			</div>
            <div class="obj_flow_01"> <!-- 01 flow object -->
                <div class="bg_flow flow_obj_01"></div>
                <div class="bg_flow flow_obj_02"></div>
            </div>
            <div class="obj_flow_02"> <!-- 02 flow object -->
                <div class="bg_flow flow_obj_01"></div>
                <div class="bg_flow flow_obj_02"></div>
            </div>
			<div class="loader-box">
				<div class="visual-loader"></div>
			</div>
			<script>
				// 상단 타이틀 등장 모션
				$(window).load(function(){
					var $visual = $(".toparea .visual");
					 $visual.addClass("intro");
					setTimeout(function(){
						$visual.addClass("end");
					},100)
				})
			</script>
		</div>

		<!-- 공통 : 탭 -->
		<div class="section navtab">
			<div class="navtab_inner">
				<ul class="navtab_list">

					<li onclick="mo_ga(1);"><a href="/mobilefirst/evt/welcome_event.jsp" class="navtab_item--01">웰컴팩</a></li>
					<li onclick="mo_ga(2);" class="is-on"><a href="#" class="navtab_item--02">친구초대</a></li>
					<li onclick="mo_ga(3);"><a href="/mobilefirst/evt/powerbuy_event.jsp" class="navtab_item--03">파워적립</a></li>
				</ul>
			</div>
		</div>
		<!-- //탭 -->

	</div>
	<!-- // -->

	<!-- T2 혜택 리스트 -->
	<div class="section invite_join">
		<div class="contents">
			<h3><img src="http://img.enuri.info/images/event/2020/buy_first/sep/m_invite_sec1_tit.png" alt="친구초대 참여혜택"></h3>
			<div class="info">
				<p class="blind">초대받고 첫 구매하면 친구도 나도 e머니 9,000점! 첫 구매 후 100일간 최대 e머니 7,100점 파워적립까지~!</p>
			</div>
		</div>
	</div>
	<!-- // -->

    <!-- T2 초대하기 혜택 -->
	<div class="section clear invite_wrap" id="evt1">
		<h2><em>초대하기 혜택</em></h2>

		<!-- 01. 초대하기 -->
		<div class="invite_evt1">
			<div class="contents">
				<div class="invite_evt1_head">
					<h3 class="tit">01. 초대하기</h3>
					<p class="blind">친구에게 초대코드를 전하세요!</p>

					<!-- 나의 초대코드 확인하기 -->
					<span onclick="onoff('myInvite1'); $(this).hide();" class="my_code" style="display: none;">나의 초대코드 확인하기</span>
					<div id="btncode">
						<span class="out_code" id="out_code" style="display:none;"></span>
						<span class="out_code logout" id="out_code_logout"style="display:none">초대코드</span>
						<span class="out_code" id="no_certi"style="display:none">초대코드</span>
						<button type="button" onclick="mo_ga(4);" class="btn confirm">확인</button>
					</div>
				</div>

				<div class="invite_evt1_cont">
					<h3 class="blind">[초대혜택1] 친구가 초대코드만 등록해도 맥카페 아메리카노 e머니 1000점</h3>

					<div class="stamp_smile">
						<em class="sm1">스탬프1</em><em class="sm2">스탬프2</em><em class="sm3">스탬프3</em>
					</div>
				</div>
			</div>
		</div>
		<!-- // -->

		<!-- 02. 초대하고 e머니 더+ (APP전용) -->
		<div class="invite_evt2">
			<div class="contents">
				<div class="invite_evt2_head">
					<h3 class="tit">02. 초대하고 e머니 더+ (APP전용)</h3>
					<p class="blind">친구가 첫 구매했다면 e머니 더+ 받아가세요!</p>
				</div>

				<div class="invite_evt2_cont">
					<p class="blind">친구가 APP에서 첫 구매하면 친구도 나도 e머니 9,000점!</p>
				</div>
			</div>

			<!-- 버튼 : 꼭 확인하세요 -->
			<div class="com__evt_notice">
				<div class="evt_notice--btn_area"><button class="btn__evt_notice" data-laypop-id="slidePop1"><span>꼭! 확인하세요</span></button></div> <!-- 열기 : 유의사항 열기 -->
			</div>
			<div id="slidePop1" class="evt_notice--slide">
				<div class="evt_notice--inner">
					<div class="evt_notice--head">유의사항</div>
					<div class="evt_notice--cont">
						<div class="evt_notice--continner">
							<h1 class="htit">[혜택1. 초대하기]</h1>
							<dl>
								<dt>이벤트 대상 및 혜택</dt>
								<dd>
									<ul>
										<li>이벤트 대상 : 이벤트 기간 내 나의 초대코드를 등록한 친구가 3명인 고객</li>
										<li>이벤트 기간 : 매월 1일 ~ 말일</li>
										<li>이벤트 혜택 : 맥카페 아메리카노 (e머니 1,000점)</li>
										<li>혜택 지급일 :&nbsp;스탬프 완성일로부터 7일 후 적립</li>
										<li><span class="stress">e머니 유효기간 : 적립일로부터 15일 (유효기간 만료 후 재적립 불가)</span><br>
											<span class="noti">※ 적립된 e머니는 e쿠폰 스토어에서 다양한 쿠폰으로 교환가능합니다.</span>
										</li>
									</ul>
								</dd>
							</dl>
							<dl>
								<dt>이벤트 참여방법 및 유의사항</dt>
								<dd>
									<ul>
										<li>참여방법 : 에누리 가격비교 모바일 앱 로그인 → 초대코드 확인  → 친구에게 초대코드 전달 (※ 친구가 초대코드 등록 시 별도 신청 절차없이 자동 참여)<br>
											<span class="noti">※ 나의 초대코드는 PC 및 모바일 앱/웹에서 로그인 후에도 확인 가능합니다.</span>
										</li>
										<li>본 이벤트는 초대하는 친구 수에는 제한이 없습니다.</li>
										<li>본 이벤트는 본인인증 및 이벤트 정보 활용 동의 후 확인 가능합니다.</li>
										<li>본 이벤트는 처음 초대코드 받은 ID만 유효하며, 동일한 본인인증으로 가입한 다른 ID의 경우 초대가 불가합니다.</li>
										<li><span class="stress">이벤트 대상 제외 :</span> 아래의 경우에는 이벤트 대상 및 혜택 지급에서 제외됩니다. <br>
											<ul class="sub">
												<li>- 나의 초대코드 등록한 친구가 3명 미만인 경우</li>
												<li>- 동일한 본인인증으로 가입한 다수의 ID로 중복 참여한 경우</li>
											</ul>
										</li>
									</ul>
								</dd>
							</dl>

							<h1 class="htit">[혜택2. 초대하고 e머니 더+]</h1>
							<dl>
								<dt>이벤트 대상 및 혜택</dt>
								<dd>
									<ul>
										<li>이벤트 대상 : 이벤트 기간 내 초대받은 친구가 초대코드 등록 후 에누리 가격비교 모바일 앱에서 1만원 이상 첫 구매한 고객</li>
										<li>이벤트 기간 : 첫 구매일로부터 30일 이내</li>
										<li>이벤트 혜택 : e머니 9,000점 (※ 초대한 친구 &amp; 초대받은 친구 각각 지급)</li>
										<li>혜택 지급일 : 구매일로부터 최대 30일 이내 적립 (※ 해외직구 상품 구매 시 최대 70일 소요)</li>
										<li><span class="stress">e머니 유효기간 : 적립일로부터 15일 (유효기간 만료 후 재적립 불가)</span><br>
											<span class="noti">※ 적립된 e머니는 e쿠폰 스토어에서 다양한 쿠폰으로 교환가능합니다.</span>
										</li>
									</ul>
								</dd>
							</dl>
							<dl>
								<dt>공통 이벤트 유의사항</dt>
								<dd>
									<ul>
										<li>부정 참여 시 본 이벤트 대상 제외 및 혜택 지급이 취소될 수 있습니다. </li>
										<li>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</li>
									</ul>
								</dd>
							</dl>
						</div>
					</div>
					<div class="evt_notice--foot">
						<button class="btn__evt_confirm">확인</button> <!-- 닫기 : 유의사항 닫기 -->
					</div>
				</div>
			</div>
			<!-- // -->
		</div>
		<!-- // -->
	</div>
	<!-- // -->

	<!-- T2 초대받기 혜택 -->
	<div class="section clear beinvited_wrap" id="evt2">
		<h2><em>초대받기 혜택</em></h2>

		<!-- 01. 초대받기 -->
		<div class="beinvited_evt1">
			<div class="contents">
				<div class="beinvited_evt1_head">
					<h3 class="tit">01. 초대받기</h3>
					<p class="blind">친구에게 받은 초대코드를 등록하세요!</p>

					<!-- 초대코드 등록완료 시 -->
					<%if((!remId.equals("") && recUserid.equals("")) || recUserid.equals("") ){%>
						<div class="input_area" style="display:;">
						<%if(appYN.equals("Y")){%>
							<div id="app_bflogin">
								<input type="text" class="in_code" id="step01_text" value="<%=remId%>" placeholder="초대코드 입력" />
								<button type="button" class="btn_code" onclick="CmdSingUp(1);">등록하기</button>
							</div>
						<%}else{ %>
							<div onclick="$('.lay_only_mw').show(); return false;">
								<input type="text" class="in_code" placeholder="초대코드 입력" readonly="readonly" />
								<button type="button" class="btn_code">등록하기</button>
							</div>
						<%} %>
						</div>
					<%}else{%>
						<!-- 등록완료 -->
						<div class="input_area codein" >
							<input type="text" id="" class="in_code" maxlength="15" value="<%=recUserid%>" readonly="readonly">
							<button class="btn_code">등록완료</button>
						</div>
					<%}%>
					<!-- 초대코드 등록하기 -->
				</div>

				<div class="beinvited_evt1_cont">
					<h3 class="blind">초대코드 등록만 해도 e머니 <%=point2 %>점!</h3>
				</div>
			</div>
		</div>
		<!-- // -->

		<!-- 02. 초대받고 첫 구매 더+ (APP전용) -->
		<div class="beinvited_evt2">
			<div class="contents">
				<div class="beinvited_evt2_head">
					<h3 class="tit">02. 초대받고 첫 구매 더+ (APP전용)</h3>
					<p class="blind">초대코드 등록했다면 첫 구매하고 더+ 받아가세요!</p>
				</div>

				<div class="beinvited_evt2_cont">
					<p class="bg">친구가 APP에서 첫 구매하면 친구도 나도 e머니 9,000점!</p>
					<%if(appYN.equals("Y")){%>
						<a href="#" id="app_benefit_5000" class="btn_payback">첫 구매 혜택 신청하기(※ 첫 구매일로부터 30일 이내 신청 가능)</a>
					<%}else{%>
						<a href="#" onclick="$('.lay_only_mw').show();return false;" class="btn_payback"> </a>
					<%}%>
					<div class="event_noti">
						<div class="noti_cnt">
							<!-- 201015 : 내용 수정 -->
							<ul>
								<li class="stress">※ 본 이벤트는 ID(본인인증), 초대코드 등록, 첫 구매, 첫 구매 혜택 신청을 모두 동일한 모바일 기기에서 진행한 경우에만 혜택 지급 가능합니다. </li>
								<li class="stress">※ 본 이벤트는 모바일 앱에서만 참여 가능합니다.</li>
								<li class="stress">※ 웰컴 페이백 혜택과 중복 참여 불가합니다.</li>
							</ul>
							<!-- // -->
						</div>
					</div>
				</div>
			</div>

			<!-- 버튼 : 꼭 확인하세요 -->
			<div class="com__evt_notice">
				<div class="evt_notice--btn_area"><button class="btn__evt_notice" data-laypop-id="slidePop2"><span>꼭! 확인하세요</span></button></div> <!-- 열기 : 유의사항 열기 -->
			</div>
			<div id="slidePop2" class="evt_notice--slide">
				<div class="evt_notice--inner">
					<div class="evt_notice--head">유의사항</div>
					<div class="evt_notice--cont">
						<div class="evt_notice--continner">
							<h1 class="htit">[혜택1. 초대받기]</h1>
							<dl>
								<dt>이벤트 대상 및 혜택</dt>
								<dd>
									<ul>
										<li>이벤트 대상 : 이벤트 기간 내 친구에게 받은 초대코드를 등록한 고객</li>
										<li>이벤트 혜택 : e머니 <%=point2 %>점</li>
										<li>혜택 지급일 : 초대코드 등록 시 즉시 적립</li>
										<li><span class="stress">e머니 유효기간 : 적립일로부터 15일 (유효기간 만료 후 재적립 불가)</span><br>
											<span class="noti">※ 적립된 e머니는 e쿠폰 스토어에서 다양한 쿠폰으로 교환가능합니다.</span>
										</li>
									</ul>
								</dd>
							</dl>
							<dl>
								<dt>이벤트 참여방법 및 유의사항</dt>
								<dd>
									<ul>
										<li>참여방법 : 에누리 가격비교 모바일 앱 로그인 → 친구에게 받은 초대코드 등록</li>
										<li>본 이벤트는 본인인증 ID당 1회만 참여 가능합니다.</li>
										<li>본 이벤트는 본인인증 및 이벤트 정보 활용 동의 후 가능합니다.</li>
										<li><span class="stress">이벤트 대상 제외 :</span> 아래의 경우 본 이벤트 대상에서 제외됩니다. <br>
											<ul class="sub">
												<li>- 친구에게 받은 초대코드를 등록하지 않은 경우</li>
												<li>- 동일한 본인인증으로 가입한 다수의 ID로 중복 참여한 경우</li>
												<li>- <span class="stress">웰컴 페이백 혜택 받은 고객(중복 참여 불가)</span></li>
											</ul>
										</li>
									</ul>
								</dd>
							</dl>

							<h1 class="htit">[혜택2. 초대받고 첫 구매 더+]</h1>
							<dl>
								<dt>이벤트 대상 및 혜택</dt>
								<dd>
									<ul>
										<li>이벤트 대상 : 이벤트 기간 내 초대코드 등록 후 에누리 가격비교 모바일 앱에서 1만원 이상 첫 구매한 고객 <br>
										</li>
										<li>이벤트 기간 : 첫 구매일로부터 30일 이내 </li>
										<li>이벤트 혜택 : e머니 9,000점 (※ 초대한 친구 &amp; 초대받은 친구 각각 지급)</li>
										<li>혜택 지급일 : 구매일로부터 최대 30일 이내 적립 (※ 해외직구 상품 구매 시 최대 70일 소요)</li>
										<li><span class="stress">e머니 유효기간 : 적립일로부터 15일 (유효기간 만료 후 재적립 불가)</span><br>
											<span class="noti">※ 적립된 e머니는 e쿠폰 스토어에서 다양한 쿠폰으로 교환가능합니다.</span>
										</li>
									</ul>
								</dd>
							</dl>
							<dl>
								<dt>이벤트 참여방법 및 유의사항</dt>
								<dd>
									<ul>
										<li>참여방법 : 에누리 가격비교 모바일 앱 로그인 → 초대코드 등록 → 적립대상 쇼핑몰 이동  → <span class="stress">1만원 이상 구매</span> → 첫구매 혜택 이벤트 신청</li>
										<li>적립대상 쇼핑몰 : G마켓, 옥션, 11번가, 인터파크, 티몬, 위메프, 쿠팡, GS SHOP, Cjmall, SSG (신세계몰, 신세계백화점, 이마트몰, 트레이더스), 에누리 해외직구관, SK스토아, 홈플러스<br>
											<span class="stress">※ 구매 유의사항 및 구매적립 제외 카테고리는 이벤트 페이지 하단 'e머니 구매혜택' 유의사항을 꼭 확인하세요!</span>
										</li>
										<li>본 이벤트는 본인인증 ID당 1회 참여 가능합니다.</li>
										<li>본 이벤트는 ID(본인인증)와 구매한 모바일 기기 모두 첫 구매일 경우에만 참여 가능합니다. <span class="stress">(※ 구매한 기기에 구매이력 있으면 참여 불가)</span></li>
										<li>본 이벤트는 본인인증 및 이벤트 정보 활용 동의 후 참여 가능합니다.</li>
										<li><span class="stress">본 이벤트는 모바일 앱에서만 참여가 가능한 모바일 앱전용 프로모션 입니다.</span></li>
										<li><span class="stress">본 이벤트는 ID(본인인증), 초대코드 등록, 첫 구매, 첫구매 혜택 신청을 모두 동일한 모바일 기기에서 진행한 경우에만 혜택 지급 가능합니다.</span></li>
										<li>본 이벤트는 웰컴 선물(신규가입, 알림동의) 혜택 받은 고객도 참여 가능합니다.</li>
										<li>구매금액은 배송비, 설치비, 할인, 쇼핑몰 포인트 등 제외한 금액만 반영됩니다. </li>
										<li>
											<span class="stress">이벤트 대상 제외 :</span> 아래의 경우에는 이벤트 대상 및 혜택 지급에서 제외됩니다. <br>
											<ul class="sub">
												<li>- 첫구매 혜택 이벤트 신청하지 않은 경우 </li>
												<li>- 실제 구매금액이 1만원 미만의 구매일 경우</li>
												<li>- 구매적립 제외 카테고리 구매일 경우 (※ 첫구매 혜택 신청일로부터 30일 이내 재구매 시 혜택 지급 가능)</li>
												<li>- 구매 후 취소/환불/교환/반품한 경우 (※ 첫구매 혜택 신청일로부터 30일 이내 재구매 시 혜택 지급 가능)</li>
												<li>- 동일한 본인인증으로 가입한 다수의 ID로 중복 참여한 경우</li>
												<li><span class="stress">- 웰컴 페이백 혜택 받은 고객 (중복 지급 불가)</span></li>
											</ul>
										</li>
									</ul>
								</dd>
							</dl>
							<dl>
								<dt>공통 이벤트 유의사항</dt>
								<dd>
									<ul>
										<li>부정 참여 시 본 이벤트 대상 제외 및 혜택 지급이 취소될 수 있습니다. </li>
										<li>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</li>
									</ul>
								</dd>
							</dl>
						</div>
					</div>
					<div class="evt_notice--foot">
						<button class="btn__evt_confirm">확인</button> <!-- 닫기 : 레이어 닫기 -->
					</div>
				</div>
			</div>
			<!-- // -->
		</div>
		<!-- // -->
	</div>
	<!-- // -->
	<%if(numSdt<20201101){ %>

	<%}else{ %>
	<!-- 210518 : 5월 쿠팡배너 추가 -->
	<div class="bnr_wrap bnr3">
		<h3 class="blind">쿠팡 신규회원앱 혜택</h3>
		<a href="http://www.enuri.com/event2021/coupang_evt.jsp" target="_blank" title="새 창에서 열립니다.">신규 회원앱에서 구팡구매하면 최대 5배 적립과 쏟아지는 경품!</a>
	</div>
	<!-- // -->
    <div class="bnr_wrap bnr1">
		<h3 class="blind">구매혜택 배너</h3>
		<a href="http://m.enuri.com/mobilefirst/evt/smart_benefits.jsp" target="_blank" title="새 창에서 열립니다.">구매했다면 스탬프 찍고 추가적립까지! 쇼핑에-누리다 혜택 받기</a>
    </div>
    <div class="bnr_wrap bnr2">
		<h3 class="blind">더많은 이벤트 배너</h3>
		<a href="http://m.enuri.com/m/index.jsp#evt" target="_blank" title="새 창에서 열립니다.">놓칠 수 없는 특별한 에누리 혜택, 더 많은 이벤트 혜택 받기</a>
	</div>
	<%} %>
	<%@ include file="/mobilefirst/evt/event_bottom.jsp"%>
    <!-- 공통 : 하단 e머니 구매혜택 -->
		<%-- <div class="com_event_benefit">
			<div class="com_event__inner">
				<h3 class="blind">에누리에서 구매하고 현금같은 e머니 적립 받으세요!</h3>
				<div class="com_benefit_slide swiper-container">
					<div class="swiper-wrapper">
						<div class="swiper-slide">
							<img src="http://img.enuri.info/images/event/2020/common/m_com_evt_ben_slide_01.png" alt="STEP1. 에누리 앱에서 로그인 후 적립대상 쇼핑몰 이동하기">
						</div>
						<div class="swiper-slide">
							<img src="http://img.enuri.info/images/event/2020/common/m_com_evt_ben_slide_02.png" alt="STEP2. 상품 구매하기">
						</div>
						<div class="swiper-slide">
							<img src="http://img.enuri.info/images/event/2020/common/m_com_evt_ben_slide_03.png" alt="STEP3. 구매금액의 최대 1.5% E머니 적립!">
						</div>
						<div class="swiper-slide">
							<img src="http://img.enuri.info/images/event/2020/common/m_com_evt_ben_slide_04.png" alt="STEP4. e쿠폰 스토어에서 1,000여가지의 인기 e쿠폰으로 교환가능!">
						</div>
					</div>
					<div class="swiper-button-prev btn_prev"></div>
					<div class="swiper-button-next btn_prev"></div>
				</div>
				<div class="swiper-pagination"></div>
				<!-- 유의사항 버튼 -->
	                  <a href="#appinfo" class="btn_com_benefit_noti btn__evt_notice on" data-laypop-id="appinfo">유의사항</a>
			</div>
			<script>
				$(function(){
					var mySwiper = new Swiper('.com_benefit_slide',{
						prevButton : '.swiper-button-prev',
						nextButton : '.swiper-button-next',
						pagination : '.swiper-pagination',
						speed : 1000,
						loop : true,
						paginationClickable : true
					});

				});

			</script>
		</div>
<!-- 200207 구매적립 유의사항 이동 / 레이어 -> flip형으로 수정 / 문구수정 -->
			<div id="appinfo" class="evt_notice--slide">
				<div class="evt_notice--inner">
					<div class="evt_notice--head">유의사항</div>
					<!-- 200608 유의사항 문구 수정 -->
					<div class="evt_notice--cont">
						<div class="txt">
							<strong>e머니 구매적립 기준 및 유의사항</strong>
							<ul class="txt_indent">
								<li>적립 방법 : 에누리 가격비교 모바일 앱 로그인 &rarr; 적립대상 쇼핑몰 이동 &rarr; <span class="stress">1천원 이상 구매</span> &rarr; 구매확정(배송완료) 시 e머니 적립</li>
								<li>적립대상 쇼핑몰: G마켓, 옥션, 11번가, 인터파크, 티몬, 위메프, 쿠팡, GS SHOP, CJmall, SSG (신세계몰, 신세계백화점, 이마트몰, 트레이더스), 에누리 해외직구관, SK스토아, 홈플러스<br/>
									<span class="stress">※ 티몬 및 에누리 해외직구관의 경우 PC 및 모바일 앱/웹에서 로그인 후 구매시에도 구매적립 가능합니다.</span></li>
								<li>구매적립 e머니는 구매일로부터 10 ~ 30일간 취소/환불/교환/반품여부 확인 후 적립 됩니다.</li>
								<li><span class="stress">구매적립 e머니 유효기간 : 적립일로부터 60일 (유효기간 만료 후 재적립 불가)</span><br/>
									 ※ 적립된 e머니는 e쿠폰 스토어에서 다양한 쿠폰으로 교환가능합니다.</li>
								<li>구매적립 e머니는 최소 10점(구매금액 1천원 이상)부터 적립되며, 1원 단위 e머니는 적립되지 않습니다.</li>
								<li>구매적립 e머니는 구매확정(구매일로부터 최대 30일) 시점부터 MY 에누리 적립내역 페이지에서 확인 가능합니다.</li>
								<li>구매금액은 배송비, 설치비, 할인, 쇼핑몰 포인트 등 제외한 금액만 반영됩니다. </li>
								<li>적립대상 쇼핑몰에서 장바구니에 여러 상품을 담아 한 번에 결제하는 경우 구매건수는 1건이며 구매금액은 통합된 금액으로 e머니 적립 됩니다.</li>
								<li>구매적립 e머니는 카테고리별 차등 적립됩니다. <br/>※ 카테고리별 적립률
									<div class="tb">
										<table>
											<colgroup>
												<col width="70%" /><col width="30%" />
											</colgroup>
											<tbody>
												<tr>
													<th>카테고리</th>
													<th>적립률</th>
												</tr>
												<tr>
													<td>유아,완구</td>
													<td>1.5%</td>
												</tr>
												<tr>
													<td>식품/스포츠,레저/자동차/화장품</td>
													<td>1.0%</td>
												</tr>
												<tr>
													<td>컴퓨터/도서/문구,사무/PC부품</td>
													<td>0.8%</td>
												</tr>
												<tr>
													<td>디지털/영상,디카</td>
													<td rowspan="4">0.3%</td>
												</tr>
												<tr>
													<td>가전(생활,주방,계절)</td>
												</tr>
												<tr>
													<td>패션/잡화</td>
												</tr>
												<tr>
													<td>가구,인테리어</td>
												</tr>
												<tr>
													<td>생활,취미</td>
													<td rowspan="2">0.2%</td>
												</tr>
												<tr>
													<td>모바일쿠폰,상품권<br/>
														<p style="font-size:10px;margin-top:4px;color:#e91030">*특정 상품에 한하여 적립되오니<br/>적립가능 상품은 하단에서 확인해주세요.</p>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</li>
							</ul>

							<strong class="stress">[모바일쿠폰,상품권 ] 구매적립 기준</strong>
							<ul class="txt_indent">
								<li>적립가능 쇼핑몰 :<%if(numSdt < 20201101){ %>티몬,<%} %> G마켓, 옥션<%if(numSdt > 20201030){ %>, 인터파크<%} %> </li>
								<%if(numSdt < 20201101){ %><li><span class="stress">※ 2020년 11월 1일부터 티몬 상품권 e머니 구매적립이 종료될 예정입니다.</span></li><%} %>
								<li>적립가능 상품 (0.2% 적립) : 문화상품권(해피머니, 컬쳐랜드), 도서상품권, 백화점상품권, 영화예매권, 국민관광 상품권</li>
								<li>백화점상품권 기준 상세
									<ul>
										<li>1) 상품명에 '백화점 상품권' 명시된 상품 또는 백화점에서만 사용할 수 있는 상품권만 적립가능</li>
										<li>2) 복합상품권 적립불가 (삼성 상품권, 신세계 기프트카드, 롯데카드 상품권, 이랜드 상품권, AK플라자 상품권, 통합 상품권 등)<br/>
											- 복합 상품권의 경우 사용처에 백화점이 기재되어 있는 경우에도 적립불가</li>
										<li>3) 백화점 상품권으로 전환 가능한 포인트 구매 시 적립불가</li>
									</ul>
								</li>
							</ul>

							<strong>적립대상 쇼핑몰 중 구매적립 제외 카테고리 및 서비스</strong>
							<ul class="txt_indent">
								<li>에누리 가격비교에서 검색되지 않는 상품</li>
								<li>모바일쿠폰,상품권 : 상품권, 지역쿠폰, e교환권, e쿠폰 등 </li>
								<li>쇼핑몰 제휴 서비스(배달, 티켓, 해외직구 등) 및 일부 카테고리<br/>
									<ul>
										<li>- G마켓 : 중고장터, 실시간 여행, 항공권, 도서/음반, 모바일쿠폰/상품권(일부 적립가능)</li>
										<li>- 옥션 : 중고장터, 실시간 여행, 항공권, 모바일쿠폰/상품권(일부 적립가능)</li>
										<li>- 11번가 : 여행/숙박/항공, 모바일쿠폰/상품권</li>
										<li>- 인터파크 : 라이프 서비스(티켓, 투어, 아이마켓 등), 모바일쿠폰/상품권<%if(numSdt > 20201030){ %>(일부 적립가능)<%} %> </li>
										<li>- 티몬 : 특가 판매 상품(슈퍼꿀딜, 슈퍼마트 등), 모바일쿠폰/상품권<%if(numSdt < 20201101){ %>(일부 적립가능 <span class="stress">※2020년 11월 1일부터 적립불가</span> )<%} %></li>
										<li>- 위메프 : 모바일쿠폰/상품권</li>
										<li>- GS SHOP, CJmall : 모바일쿠폰/상품권</li>
										<li>- SSG : 도서/음반/문구/취미/여행, 모바일쿠폰/상품권</li>
									</ul>
								</li>
							</ul>

							<strong>공통 구매 유의사항</strong>
							<ul class="txt_indent">
								<li><b style="display:block;margin-bottom:4px">아래의 경우에는 구매 확인 및 구매적립이 불가합니다.</b>
									<ul>
										<li>- 에누리 가격비교 모바일 앱이 아닌 다른 모바일 앱을 통해서 장바구니 또는 관심상품 등록 후 에누리 가격비교 모바일 앱으로 결제만 한 경우</li>
										<li>- 에누리 가격비교 미 로그인 후 구매한 경우</li>
										<li>- 에누리 가격비교 PC 및 모바일 웹에서 구매한 경우 (※ 티몬 및 에누리 해외직구관은 PC 및 모바일 앱/웹 구매 시에도 가능)</li>
									</ul>
								</li>
							</ul>
						</div>
					</div>
					<!-- // -->
					<div class="evt_notice--foot">
						<button class="btn__evt_confirm">확인</button> <!-- 닫기 : 유의사항 닫기 -->
					</div>
				</div>
			</div>
	<%if( numSdt > 20201005 &&  numSdt < 20201229  ) {%>
		<div class="com_event_special">
			<div class="com_event__inner">
				<h3 class="blind">e머니 스페셜 적립 이벤트</h3>
				<div class="tab_event">
					<a href="javascript:void(0);" class="tab-item" data-tab-index="1">쿠팡</a>
					<!-- <a href="javascript:void(0);" class="tab-item" data-tab-index="2">티몬</a> -->
					<!-- <a href="javascript:void(0);" class="tab-item" data-tab-index="3">스토어팜</a> -->
				</div>
				<div class="tab_cnt swiper-container">
					<div class="swiper-wrapper">
						<div class="swiper-slide">
							<a href="http://m.enuri.com/mobilefirst/event2019/coupangevt.jsp" title="클릭시 새창이 열립니다." target="blank"><img src="http://img.enuri.info/images/event/2020/common/m_com_evt_special_coupang_oct.png" alt="에누리 앱을 경유하여 쿠팡에서 구매 시 e머니로 적립해 드립니다. 최대 5% 적립"></a>
						</div>
					</div>
				</div>
				<!--
				<div class="swiper-pagination"></div>
				 -->
			</div>
		</div>
	<%}%> --%>
    <!-- 200207 구매적립 유의사항 이동 / 레이어 -> flip형으로 수정 / 문구수정 -->


</div>
<div class="com__share_wrap dim" style="z-index: 10000;display:none">
	<div class="com__layer share_layer">
		<div class="lay_head">공유하기</div>
		<a href="#close" class="lay_close" onclick="$(this).closest('.dim').fadeOut(200);return false;">닫기</a>
		<div class="lay_inner">
			<ul id="eventShr">
				<li class="share_fb" id="fbShare" >페이스북 공유하기</li>
				<li class="share_kakao" id="kakao-link-btn">카카오톡 공유하기</li>
				<li class="share_tw" id="twShare" >트위터 공유하기</li>
			</ul>
			<!-- 메인보내기 버튼클릭시 .mail_on 추가해 주세요 -->
			<div class="btn_wrap">
				<div class="btn_group">
					<!-- 주소복사하기 -->
					<div class="btn_item">
						<span id="txtURL" class="txt__share_url">http://m.enuri.com/mobilefirst/evt/new_friend_20179.jsp</span>
						<button class="btn__share_copy" data-clipboard-target="#txtURL">복사</button>
					</div>
					<!-- 이메일주소 입력하기 -->
					<div class="btn_item">
						<input type="text" class="txt__share_mail" placeholder="이메일 주소 입력해 주세요">
						<button class="btn__share_mail">보내기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript" src="/js/clipboard.min.js"></script>
	<script>
		$(function(){
			var clipboard = new ClipboardJS('.com__share_wrap .btn__share_copy');
			clipboard.on('success', function(e) {
				alert('주소가 복사되었습니다');
			});
			clipboard.on('error', function(e) {
				console.log(e);
			});
		});
	</script>
</div>
<div class="layer_back" id="app_only" style="display:none;">
	<div class="appLayer">
		<h4>모바일 앱 전용 이벤트</h4>
		<a href="javascript:///" class="close" onclick="onoff('app_only')">창닫기</a>
		<p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br>에누리앱을 설치합니다.</p>
		<p class="btn_close"><button type="button">설치하기</button></p>
	</div>
</div>

<div class="event_layer" id="eventJoin" style="display:none">
	<div class="inner_layer">
		<div class="head">
			<h2 class="p_tit stripe_layer">이벤트 응모하기</h2>
		</div>
		<h3 class="tit stripe_layer">참여해주셔서 감사합니다. 당첨 시 경품배송을 위해 정확한 정보를 입력해 주세요.</h3>
		<a href="javascript:///" class="stripe_layer close" onclick="onoff('eventJoin')">창닫기</a>

		<div class="viewer">
			<fieldset>
				<legend>경품 발송을 위한 정보 입력</legend>
				<!--
				<label>
					<p>이름</p>
					<input type="text" id="" name="" class="ipt_box" value="" placeholder="이름을 입력해 주세요" />
				</label>
				 -->
				<label>
					<p>휴대폰번호</p>
					<input type="number" id="ipt_box" name="ipt_box" class="ipt_box" max="11" value="" placeholder="휴대폰 번호를 입력해 주세요">
				</label>
				<div class="agree_chk">
					<span id="agree_chk"  class="unchk" onclick="agreechk(this);"><input type="checkbox" id="agreechk" name="agreechk">위 개인 정보 활용에 동의 합니다.</span>
					<a href="javascript:///" class="btn_detail stripe_layer" onclick="onoff('privacy')">자세히보기</a>
				</div>
			</fieldset>
		</div>
		<p class="btn_close"><button type="button" class="stripe_layer complete">응모완료</button></p>

		<p class="caution_info stripe_layer">
			<strong>꼭 알아두세요!</strong>
			입력하신 정보는 당첨자의 확인 및 경품 발송을 위해서만 이용 후 파기합니다.<br>잘못된 정보 입력으로 인한 경품 수령의 불이익은 책임지지 않습니다
		</p>
	</div>
</div>

<!-- 개인정보 수집 이용안내 레이어 -->
<div class="event_layer" id="privacy" style="display:none;">
	<div class="inner_layer privacy">
		<h3 class="tit stripe_layer">개인정보 수집·이용안내</h3>

		<div class="viewer">
			<!-- 개인정보 -->
			<div class="privacy__area">
				<p>에누리 가격비교는 이벤트 참여확인 및 경품 발송을 위하여 아래와 같이 개인 정보를 수집하고 있습니다. </p>
				<dl>
					<dt>1. 개인정보 수집 항목</dt>
					<dd>휴대폰 번호, 회원ID, 참여 일시</dd>
					<dt>2. 개인정보 수집 및 이용 목적</dt>
					<dd>이벤트를 위해 수집된 개인정보는 이벤트 참여확인 및 경품 발송을 위한 본인확인 이외의 목적으로 활용되지 않습니다.</dd>
					<dt>3. 개인정보 보유 및 이용 기간</dt>
					<dd>개인 정보 수집자(에누리 가격비교)는 개인 정보의 수집 및 이용 목적이 달성되면 개인 정보를 즉시 파기합니다.</dd>
				</dl>
			</div>
			<!-- //개인정보 -->
		</div>
		<p class="btn_close"><button type="button" class="stripe_layer privacy__close" onclick="onoff('privacy')">닫기</button></p>
	</div>
</div>

<%@ include file="/mobilefirst/include/inc_ctu.jsp"%>
<%@ include file="/mobilefirst/event2016/event_footer.jsp" %>

<script>
//공통 : 유의사항 레이어 열기/닫기
$(function(){
	/* var el = {
		btnSlide: $(".btn__evt_notice"), // 열기 버튼
		btnSlideClose : $(".btn__evt_confirm") // 닫기 버튼
	}
	el.btnSlide.click(function(){ // 슬라이드 유의사항 열기
		$(this).toggleClass('on');
		$("#"+$(this).attr("data-laypop-id")).slideToggle();
	})
	el.btnSlideClose.click(function(){ // 슬라이드 유의사항 닫기
		var thisClosest = $(this).closest('.evt_notice--slide')
		$(thisClosest).slideToggle();
		$('html,body').stop(0).animate({scrollTop:$(thisClosest).siblings(".com__evt_notice").offset().top - 50});
	}) */

})
var sdt = <%=numSdt%>;
//공통 : 상단 탭 고정
(function (global, $) {
	var $nav = $('.navtab'); // 탭
	var $myarea = $('.myarea');
    $(window).scroll(function () {
    	var scroll = $(window).scrollTop();
        if (scroll > $nav.offset().top) {
        	$nav.addClass("is-fixed")
			$myarea.addClass("f-nav");
        }else{
        	$nav.removeClass("is-fixed")
			$myarea.removeClass("f-nav");
        }
    });
}(window, window.jQuery));

//공통 :  하단 컨텐츠로 바로 진입시 포지션 보정을 위한 스크립트 처리
$(function(){
	if(window.location.hash) {
		var $hash = $("#"+window.location.hash.substring(1));
		var navH = $(".navtab").outerHeight();
		if ( $hash.length ){
			$("html,body").stop(true,false).animate({"scrollTop": $hash.offset().top - navH},"slow");
		}
		}
})

//레이어
function onoff(id) {
	var mid = $("#"+id);
	if(mid.css("display") !== "none"){
		mid.css("display","none");
	}else{
		mid.css("display","");
	}
}

/*checkbox*/
function agreechk(obj){
	if (obj.className== 'unchk') {
		obj.className = 'chk';
	} else {
		obj.className = 'unchk';
	}
}
</script>
</body>
<script type='text/javascript'>
//상단 탭 이동
var sdt = <%=numSdt%>;
if(sdt<20209001){
	$(document).on('click', '.floattab__list > li > a, .movetab', function(e) {

		var $anchor = $($(this).attr('href')).offset().top-68;
		var hef = $(this).attr('href');

		if(hef == "#evt1")			ga('send', 'event', 'mf_event', '친구초대', '텝 초대왕');
		else if(hef == "#evt2")		ga('send', 'event', 'mf_event', '친구초대', '텝 초대받기');
		else if(hef == "#evt3")		ga('send', 'event', 'mf_event', '친구초대', '텝 적립신청');

		$('html, body').stop().animate({scrollTop: $anchor}, 500);
		e.preventDefault();
	});
}

function view_moapp(){
	var chrome25;
	var kitkatWebview;
	var uagentLow = navigator.userAgent.toLocaleLowerCase();
	var openAt = new Date;
	var goApp = "enuri://freetoken/?url=http%3A%2F%2Fm.enuri.com%2Fmobilefirst%2Fevt%2Fnew_friend_20179.jsp";
	if(navigator.userAgent.indexOf("Android") > -1){ // 안드로이드
		goApp = "enuri://event?eventurl=&eventstartdate=&eventrepeatday=&eventdetailurl=http://m.enuri.com/mobilefirst/evt/new_friend_20179.jsp";
		chrome25 = uagentLow.search("chrome") > -1 && navigator.appVersion.match(/Chrome\/\d+.\d+/)[0].split("/")[1] > 25;
		kitkatWebview = uagentLow.indexOf("naver") != -1 || uagentLow.indexOf("daum") != -1;
		setTimeout( function() {
			if (new Date - openAt < 4000) {
				if (uagentLow.search("android") > -1) {
					location.href = "market://details?id=com.enuri.android";
				}
			}
		}, 1000);
		if(uagentLow.search("android") > -1){
			window.open(goApp);
		}
	}else{
		setTimeout( function() {
			window.open("https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8");
		}, 1000);
		location.href = goApp;
	}
}
function firstBuy100Go(){
	var chkid= "<%=ChkNull.chkStr(request.getParameter("chk_id"))%>";
	location.href ="/mobilefirst/evt/welcome_event.jsp?freetoken=event&chk_id="+chkid;
}
(function (global, $) {
	var $nav = $('.navtab'); // 탭
	var $myarea = $('.myarea');
	$(window).scroll(function () {
		var scroll = $(window).scrollTop();
		if (scroll > $nav.offset().top) {
			$nav.addClass("is-fixed")
			$myarea.addClass("f-nav");
		}else{
			$nav.removeClass("is-fixed")
			$myarea.removeClass("f-nav");
		}
	});
	// 공통 :  하단 컨텐츠로 바로 진입시 포지션 보정을 위한 스크립트 처리
	if(window.location.hash) {
		var $hash = $("#"+window.location.hash.substring(1));
		var navH = $(".navtab").outerHeight();
		if ( $hash.length ){
			$("html,body").stop(true,false).animate({"scrollTop": $hash.offset().top - navH},"slow");
		}
	}

}(window, window.jQuery));

function eventLink(sel){
	if(sel == 1)		window.open("/mobilefirst/evt/office_workers.jsp?event_id=2018033009&freetoken=event");
	else if(sel == 2)		window.open("/mobilefirst/evt/visit_event.jsp?tab=1&freetoken=event");
	else if(sel == 3)		window.open("/mobilefirst/evt/visit_event.jsp?tab=2&freetoken=event");
	else if(sel == 4)		window.open("/mobilefirst/evt/mobile_deal.jsp?freetoken=event"); //크디
}

function agentCheck(){
    var iphoneAndroid = "";
    if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1)        iphoneAndroid ="I";
    else if(navigator.userAgent.indexOf("Android") > -1)        iphoneAndroid ="A";
    return iphoneAndroid;
}

function goEventLink(link,title){
	ga('send', 'event', 'mf_event', 'event', title);

	if(  link == ""){
		alert("이벤트 준비중 입니다.");
		return false;
	}else{
		location.href = link;
	}
}
//getEventBanner();
function getEventBanner(){
    var loadUrl = "/mobilefirst/http/json/plan_banner.json";

    $.ajax({
        url: loadUrl,
        dataType: 'json',
        async: false,
        success: function(json){

            Date.prototype.format = function(f) {
                if (!this.valueOf()) return " ";

                var weekName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
                var d = this;

                return f.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|a\/p)/gi, function($1) {
                    switch ($1) {
                        case "yyyy": return d.getFullYear();
                        case "yy": return (d.getFullYear() % 1000).zf(2);
                        case "MM": return (d.getMonth() + 1).zf(2);
                        case "dd": return d.getDate().zf(2);
                        case "E": return weekName[d.getDay()];
                        case "HH": return d.getHours().zf(2);
                        case "hh": return d.getHours().zf(2);
                        case "mm": return d.getMinutes().zf(2);
                        case "ss": return d.getSeconds().zf(2);
                        case "a/p": return d.getHours() < 12 ? "오전" : "오후";
                        default: return $1;
                    }
                });
            };

            String.prototype.string = function(len){var s = '', i = 0; while (i++ < len) { s += this; } return s;};
            String.prototype.zf = function(len){return "0".string(len - this.length) + this;};
            Number.prototype.zf = function(len){return this.toString().zf(len);};

            var today = new Date().format("yyyyMMddhhmm");
            today = today * 1;

//          var today = "201609010000";
            var template = "";

            if(json.planList){
                for(var i=0;i<json.planList.length;i++){
                    if((agentCheck=="I" && json.planList[i].iosYN == "N") || (agentCheck=="A" && json.planList[i].androidYN == "N")){
                        continue;
                    }
                    var title = json.planList[i].title;

                    if( title.indexOf("출석") > -1 ||  title.indexOf("직장공감")  > -1 ||  title.indexOf("룰렛") > -1 ||  title.indexOf("CRAZY DEAL") > -1 ){

	                    if(json.planList[i].event_yn == "Y" && json.planList[i].startDate == "" && json.planList[i].endDate == ""){
	                        template += "<li>";
	                        template += "<a href=\"javascript:goEventLink(\'"+json.planList[i].link+"\',\'"+json.planList[i].title+"\')\" >";
	                        template += "<img src=\""+json.planList[i].imgSrc+"\" >";
	                        template += "</a>";
	                        template += "</li>";
	                    }else{
	                        if(json.planList[i].event_yn == "Y" && today > json.planList[i].startDate && today < json.planList[i].endDate){
	                            template += "<li>";
	                            template += "<a href=\"javascript:goEventLink(\'"+json.planList[i].link+"\',\'"+json.planList[i].title+"\')\" >";
	                            template += "<img src=\""+json.planList[i].imgSrc+"\" >";
	                            template += "</a>";
	                            template += "</li>";
	                        }
	                    }
                    }
                }
            }
            $(".eventlist").html(template);
        }
    });
}

function godirectshop(no){
	var shopurl = '';

	if (no == 1){shopurl = 'http://www.11st.co.kr/connect/Gateway.tmall?method=Xsite&tid=1000997249&DEVICE_BROWSER=Y';}
	if (no == 2){shopurl = 'http://www.gmarket.co.kr/index.asp?jaehuid=200006254&DEVICE_BROWSER=Y';}
	if (no == 3){shopurl = 'http://mobile.auction.co.kr/HomeMain?BCODE=BN00149093&DEVICE_BROWSER=Y';}
	if (no == 4){shopurl = 'http://m.interpark.com/mobileGW.html?svc=Shop&bizCode=P14126&url=http://m.shop.interpark.com&DEVICE_BROWSER=Y';}
	if (no == 5){shopurl = 'http://with.gsshop.com/jsp/jseis_withLGeshop.jsp?DEVICE_BROWSER=Y&media=Pg&gourl=http://m.gsshop.com';}
	if (no == 6){shopurl = 'http://mw.cjmall.com/m/main.jsp?app_cd=ENURI&DEVICE_BROWSER=Y';}
	if (no == 7){shopurl = 'http://m.shinsegaemall.ssg.com/mall/main.ssg?ckwhere=s_enuri&DEVICE_BROWSER=Y';}
	if (no == 8){shopurl = 'http://m.ticketmonster.co.kr/entry/?jp=80025&ln=214285&DEVICE_BROWSER=Y';}
	if (no == 9){shopurl = 'http://www.wemakeprice.com/widget/aff_bridge_public/enuri_m/0/Y/PRICE_af?DEVICE_BROWSER=Y';}
	if (no == 10){shopurl = 'http://landing.coupang.com/pages/M_home?src=1033035&amp;spec=10305201&amp;lptag=Enuri_M_logo&amp;forceBypass=Y';}

	<%if(appYN.equals("Y")){%>
	location.href=shopurl;
	<%} else{ %>
	window.open(shopurl, '_blank');
	<%} %>
}

function getBaselist(param){
	$(".tab_deal li").removeClass("on");

	var shop_code = "536";
	var shop_name = "슈퍼딜";
	var json_url = "/mobilefirst/http/json/superDeal.json";
	var logo_img="<%=IMG_ENURI_COM%>/images/event/2016/m_firstbuy/logo_gmarket.png"; //로고 이미지

	if(param == 1){
		shop_code = "536";
		shop_name = "슈퍼딜";
		json_url = "/mobilefirst/http/json/superDeal.json";
		logo_img="<%=IMG_ENURI_COM%>/images/event/2016/m_firstbuy/logo_gmarket.png";
		if(mType=="A")			shop_url="/mobilefirst/renew/hotShop.jsp?freetoken=main_tab|bestdeal#1";
		else			shop_url="/mobilefirst/renew/hotShop.jsp?freetoken=main_tab|bestdeal";

		$("#deal_1").addClass("on");
	}else if(param == 2){
		shop_code = "4027";
		shop_name = "올킬";
		json_url = "/mobilefirst/http/json/allKill.json";
		logo_img="<%=IMG_ENURI_COM%>/images/event/2016/m_firstbuy/logo_auction.png";
		if(mType=="A")			shop_url="/mobilefirst/renew/hotShop.jsp?freetoken=main_tab|bestdeal#2";
		else			shop_url="/mobilefirst/renew/hotShop.jsp?freetoken=main_tab|bestdeal";
		$("#deal_2").addClass("on");
	}else if(param == 3){
		shop_code = "5910";
		shop_name = "쇼킹딜";
		json_url = "/mobilefirst/http/json/shocking.json";
		logo_img="<%=IMG_ENURI_COM%>/images/event/2016/m_firstbuy/logo_11st.png";
		if(mType=="A")			shop_url="/mobilefirst/renew/hotShop.jsp?freetoken=main_tab|bestdeal#3";
		else			shop_url="/mobilefirst/renew/hotShop.jsp?freetoken=main_tab|bestdeal";
		$("#deal_3").addClass("on");
	}else if(param == 4){
		shop_code = "6641";
		shop_name = "티몬";
		json_url = "/mobilefirst/http/json/tmon.json";
		logo_img="<%=IMG_ENURI_COM%>/images/event/2016/m_firstbuy/logo_tmon.png";
		if(mType=="A")			shop_url="/mobilefirst/renew/hotShop.jsp?freetoken=main_tab|bestdeal#4";
		else			shop_url="/mobilefirst/renew/hotShop.jsp?freetoken=main_tab|bestdeal";
		$("#deal_4").addClass("on");
	}
	//$(".btn_moreview").attr("href",shop_url); //상품더보기 이동url설정
	$(".btn_moreview .logomall img").attr("src",logo_img);//로고이미지 설정
	$(".btn_moreview").attr("href",shop_url);// 링크 설정.
	$(".btn_moreview").attr("target","_blank");// 링크 설정.
	ga("send", "event", "mf_hotdeal", "hotdeal_tab", "tab_"+ shop_name);

	$.ajax({
		type: "GET",
		url: json_url,
		dataType: "JSON",
		success: function(json){
			$("#today_list").html(null);
			$("#mart_list").html(null);

			if(json.goodsList){
				var temp = "";
				var template = "";
				var g_list = json.goodList;
				var list_size = json.goodsList.length; //상품갯수 100
				var divided_size= parseInt(list_size/3); // 33

				var index_1 = Math.floor(Math.random() * divided_size); // 1/3구간에서 랜덤뽑기
				var index_2 = Math.floor(Math.random() * divided_size) + divided_size; // 2/3 구간에서 랜덤뽑기
				var index_3 = Math.floor(Math.random() * divided_size) + divided_size*2; // 3/3 구간에서 랜덤뽑기

				var randomNum = new Array();
				randomNum[0]= index_1;
				randomNum[1] = index_2;
				randomNum[2] = index_3;
				//console.log("number1:"+ index_1);
				//console.log("number2:"+ index_2);
				for(var i=0;i<randomNum.length;i++){
					if(shop_code=="6641" || shop_code=="6508"){
						template += "<li>";
						template += "<a href=\"javascript:///\" modelnm=\""+ json.goodsList[randomNum[i]].goodsnm +"\" class=\"best_area\" url=\""+ json.goodsList[randomNum[i]].url +"\" modelno=\""+ json.goodsList[randomNum[i]].modelno +"\" pl_no=\""+ json.goodsList[randomNum[i]].pl_no +"\">";
						template += "<div class=\"thum sq\"><img src=\""+json.goodsList[randomNum[i]].shopImageUrl+"\" alt=\"\" /></div>";
						template += "<strong>"+json.goodsList[randomNum[i]].goodsnm+"</strong>";
						template += "<div class=\"price\">";
						if(json.goodsList[randomNum[i]].discount_rate){
							if((json.goodsList[randomNum[i]].discount_rate != "" && json.goodsList[randomNum[i]].discount_rate != 0) && (json.goodsList[randomNum[i]].orgPrice != "" && json.goodsList[randomNum[i]].orgPrice != 0)){
								template += "<span class=\"sale\"><b>"+json.goodsList[randomNum[i]].discount_rate+"</b>%</span>";
								template += "<span class=\"prc\"><b>"+CommaFormattedN(json.goodsList[randomNum[i]].price)+"</b>원";
								template += "<del>"+CommaFormattedN(json.goodsList[randomNum[i]].orgPrice)+"원</del>";
							}else if((json.goodsList[randomNum[i]].discount_rate == "" || json.goodsList[randomNum[i]].discount_rate == "0") || (json.goodsList[randomNum[i]].orgPrice == "" || json.goodsList[randomNum[i]].orgPrice == "0")){
								template += "<span class=\"sale\"><b>특별가 </b></span>";
								template += "<span class=\"prc\"><b>"+CommaFormattedN(json.goodsList[randomNum[i]].price)+"</b>원";
							}
						}else{
							template += "<span class=\"sale\"><b>특별가 </b></span>";
							template += "<span class=\"prc\"><b>"+CommaFormattedN(json.goodsList[randomNum[i]].price)+"</b>원";
						}
						template += "</span>";
						template += "</div>";
						template += "</a>";

						if(json.goodsList[randomNum[i]].option){
							var option = json.goodsList[randomNum[i]].option;
							var optSplit = option.split(',');
							for(var j=0;j<optSplit.length;j++){
								if(optSplit[j] == "무료배송"){
									template += "<em>"+optSplit[j]+"</em>";
								}
							}
						}
						template += "</div>";
						template += "</li>";
					}else{
						template += "<li>";
						template += "<a href=\"javascript:///\" modelnm=\""+ json.goodsList[randomNum[i]].goodsnm +"\" class=\"best_area\" url=\""+ json.goodsList[randomNum[i]].url +"\" modelno=\""+ json.goodsList[randomNum[i]].modelno+"\" pl_no=\""+ json.goodsList[randomNum[i]].pl_no +"\">";
						template += "<div class=\"thum\"><img src=\""+json.goodsList[randomNum[i]].shopImageUrl+"\" alt=\"\" /></div>";
						template += "<strong>"+json.goodsList[randomNum[i]].goodsnm+"</strong>";
						template += "<div class=\"price\">";
						if(json.goodsList[randomNum[i]].discount_rate){
							if((json.goodsList[randomNum[i]].discount_rate != "" && json.goodsList[randomNum[i]].discount_rate != 0) && (json.goodsList[randomNum[i]].orgPrice != "" && json.goodsList[randomNum[i]].orgPrice != 0)){
								template += "<span class=\"sale\"><b>"+json.goodsList[randomNum[i]].discount_rate+"</b>%</span>";
								template += "<span class=\"prc\"><b>"+CommaFormattedN(json.goodsList[randomNum[i]].price)+"</b>원";
								template += "<del>"+CommaFormattedN(json.goodsList[randomNum[i]].orgPrice)+"원</del>";
							}else if((json.goodsList[randomNum[i]].discount_rate == "" || json.goodsList[randomNum[i]].discount_rate == "0") || (json.goodsList[randomNum[i]].orgPrice == "" || json.goodsList[randomNum[i]].orgPrice == "0")){
								template += "<span class=\"sale\"><b>특별가 </b></span>";
								template += "<span class=\"prc\"><b>"+CommaFormattedN(json.goodsList[randomNum[i]].price)+"</b>원";
							}
						}else{
							template += "<span class=\"sale\"><b>특별가 </b></span>";
							template += "<span class=\"prc\"><b>"+CommaFormattedN(json.goodsList[randomNum[i]].price)+"</b>원";
						}
						template += "</span>";
						template += "</div>";
						template += "</a>";

						if(json.goodsList[randomNum[i]].option){
							var option = json.goodsList[randomNum[i]].option;
							var optSplit = option.split(',');
							for(var j=0;j<optSplit.length;j++){
								if(optSplit[j] == "무료배송"){
									template += "<em>"+optSplit[j]+"</em>";
								}
							}
						}
						template += "</div>";
						template += "</li>";
					}
				}
				$("#today_list").html(template);
				$(".best_area").each(function(){
					$(this).on("click",function(event) {
						goShop($(this).attr("url"),shop_code,$(this).attr("pl_no"),'','','','','',this,$(this).attr("modelno"));

						ga('send','event','mf_event','앱첫구매 프로모션','button','핫딜상품');
					});
				});
			}
		},
		error : function(result) {
			alert("error occured. Status:" + result.status  + ' --Status Text:' + result.statusText + " --Error Result:" + result);
		}
	});
}
</script>
<script language="javascript" type="text/javascript" >
Kakao.init('5cad223fb57213402d8f90de1aa27301');
var setPoint = "<%=point%>";

var mType = "";
if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1)	mType = "I";
else if(navigator.userAgent.indexOf("Android") > -1)	mType = "A";
var oc = '<%=oc%>';
var vUserId = "<%=cUserId %>";

var app_pageno = 1;
var buy_pageno = 1;
var pagesize = 5;
var vlink = location.href;

var gateURL = "";
var Code = "";
var gaGubun = "";

if("<%=appYN %>" != "Y")	gaGubun = "web";
else	gaGubun = "app";

$(function() {
	if(oc!=""){
		$('.lay_only_mw').show();
	}
	if(vUserId==""){
		$('#app_bflogin').attr("onclick","CmdSingUp();");
	}

	$("#eventShr > li").click(function(){
		var sel = $(this).attr("id");

		if(sel == "fbShare"){
			try{
				window.android.android_window_open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(shareTitle)+"&u="+shareUrl);
			}catch(e){
				window.open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(shareTitle)+"&u="+shareUrl);
			}
		}else if(sel == "twShare"){
			try {
				window.android
						.android_window_open("http://twitter.com/intent/tweet?text="
								+ encodeURIComponent(shareTitle)
								+ "&url=" + shareUrl);
			} catch (e) {
				window.open("http://twitter.com/intent/tweet?text="
						+ encodeURIComponent(shareTitle) + "&url="
						+ shareUrl);
			}
		}
	});

	$(".go_top").click(function(){		$(window).scrollTop(0);	});

	if(vUserId == ""){
		$(".my").html("<a href='javascript:goLogin();'>로그인 해주세요.</a>");
	}else{
		getPoint();
		getBuyInfo();
	}
	var vHash = window.location.hash;
	// 첫구매 혜택 핫딜상품
	//getBaselist(<%//= new Random().nextInt(4) + 1 %>);

	$(".btn_login").click(function(){
		location.href = "/mobilefirst/login/login.jsp?backUrl="+encodeURIComponent("m.enuri.com/mobilefirst/evt/new_friend_20179.jsp");
		return false;
	});

	$(".share").click(function(){	setLog();	});

	$("#my_emoney").click(function(){
		window.location.href = "https://m.enuri.com/my/my_emoney_m.jsp?freetoken=emoney";	//e머니 적립내역
	});

	$(".save_go").click(function(){
		if('<%=appYN %>' != 'Y'){	// 웹에서 호출
			$('.lay_only_mw').show();
		}else{
			window.location.href = "/mobilefirst/emoney/emoney.jsp?freetoken=emoney";	//e머니 적립내역
		}
		ga('send', 'event', 'mf_event', '친구초대_회원탭', '적립내역확인');
	});

	//$('#kakaotalk_default').click(function(){	fn_share_on(1); 	});
	$('#facebook_default').click(function(){	fn_share_on(2);   	});

	/* $("#kakaotalk").on("click",function(){
		//alert("앱 첫설치혜택은\n안드로이드폰만 받을 수\n있습니다.\(아이폰은 첫구매혜택\n6,000점만 받을 수 있습니다.)");
		fn_share_on(1);
		ga('send', 'event', 'mf_event', '친구초대_회원탭', '초대-카카오톡');
		return false;
	}); */

	$("#facebook").on("click",function(){
		fn_share_on(2);
		ga('send', 'event', 'mf_event', '친구초대_회원탭', '초대-페이스북');
		return false;
	});

	$("#copy_url").on("click",function(){
		if(vUserId == ""){
			$(".btn_login").click();
			return false;
		}
		copyURL();
		ga('send', 'event', 'mf_event', '친구초대_회원탭', '초대-URL');
	});

	$("#app_benefit_5000").click(function(){	//앱 첫구매 혜택
		ga('send', 'event', 'mf_event', '친구초대_'+gaGubun+'친구탭', '첫구매 5000신청');
		//로그인 여부, 초대인이 있는지 먼저 체크
		if(vUserId == ""){
			if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
				location.href = "/mobilefirst/login/login.jsp";
			}else   if(navigator.userAgent.indexOf("Android") > -1){
				location.href = "/mobilefirst/login/login.jsp?backUrl=/mobilefirst/event/event_three.jsp?freetoken=event";
			}
			return false;
		}

		if('<%=recUserid%>' == ""){
			alert("초대코드 등록 후 참여해주세요.");
	      	return false;
		}else{
			$.ajax({
				type: "GET",
				url: "/mobilefirst/evt/ajax/friend_nomiee.jsp",
				async: false,
				dataType: "JSON",
				success: function(json){

					if(json.result == "Y"){
						firstShopping();
					}else if(json.result == "N"){
						//alert("아쉽네요^^;\n첫구매 대상자가 아닙니다.");
						firstShopping();

					}else if(json.result == "UE"){
						//alert("본인 인증을 하셔야 이용 가능합니다.");
						$("#myInvite2").show();
						return false;
					}else if( json.result == "UO"){
						alert("이미 초대혜택이 신청되었습니다.");
						return false;
					}else if(json.result == -5){

						var r = confirm("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?");
						if(r){
							location.href = "https://m.enuri.com/mobilefirst/member/myAuth.jsp?cmdType=&f=m&freetoken=login_title";
						}
						return false;
					}
				},error: function (xhr, ajaxOptions, thrownError) {}
			});
		}
	});
	$("#agreebtn").click(function(){		//동의 후 초대코드 등록
		var code_num = $("#code_num").text();

		if($('#invitedCheck').prop('checked') == false){
			alert("정보 공유에 동의하셔야 친구초대혜택을 받을 수 있습니다.");
		}else if(code_num.trim() == ""){
			alert("유효하지 않은 초대코드 입니다.\n 초대코드를 정확히 입력해주세요");
		}else{
			$.ajax({
				type: "GET",
				url: "/mobilefirst/evt/ajax/friend_chk.jsp?chk=2&rec_userid="+code_num,
				async: false,
				dataType: "JSON",
				success: function(json){

					if(json.result == "UO"){
						alert("이미 초대자를 등록한 계정이 있습니다.");
						return false;
					}else if(json.result == "UU"){
						alert("이미 초대자를 등록한 계정이 있습니다.");
						return false;
					}else if(json.result == "UE"){
						alert("본인 인증을 하셔야 합니다.");
						$("#myInvite2").show();
						return false;
					}else if(json.result == "Y"){
						alert("환영합니다!\n초대코드가 등록되었습니다.\n앱에서 초대 혜택을 받으세요!");
						$("#agree").hide();
						window.location.reload();
						return false;
					}else if(json.result == "RSAME" ){
						alert("내가 초대한 친구는 나를 초대할 수 없습니다.");
						return false;
					}else if( json.result == "O" ){
						alert("이미 초대코드가 등록되어 있습니다.");
						return false;
					} else if( json.result == -101 ){
						alert("웰컴 페이백 혜택과 중복 참여 불가합니다.");
						return false;
					}
				}
			});
		}
	});
	$(".win_close").click(function(){
		if("<%=appYN %>" == "Y")			window.location.href = "close://";
		else			window.location.replace("/m/index.jsp");
	});

	var vTab = '<%=strTab%>';
	var vTab2 = "회원";

	if(vTab == "2")		vTab2 = "친구";

	if(navigator.userAgent.indexOf("Android") > -1){
		ga('send', 'pageview', {
			'page': '/mobilefirst/evt/new_friend_20179.jsp',
			'title': '[모바일]친구추천 페이지뷰(AOS)_'+vTab2
		});
	 }else{
		ga('send', 'pageview', {
			'page': '/mobilefirst/evt/new_friend_20179.jsp',
			'title': '[모바일]친구추천 페이지뷰(IOS)_'+vTab2
		});
	 }

	var head = $(".nav").outerHeight();

	if(vTab == "3"){
		var offset = $(".frbuy_area").offset();
        $("html,body").stop(true).animate({scrollTop:offset.top - head - 30},500,"swing");
	}

	$(".btn_goevent").click(function(){
		ga('send', 'event', 'mf_event', '첫구매', '이벤트보러가기');
		location.href = "/mobilefirst/evt/welcome_event.jsp?tab=1";
		return false;
	});

	$(".stripe_layer.complete").click(function(){
		//onclick="onofftmp('eventJoin');"
		var uphone  = $("#ipt_box").val();

		if (!uphone.isValidHP()) {
	    	alert("잘못된 형식의 휴대폰 번호입니다.");
	        return false;
	    }

		var cls = $("#agree_chk").attr("class");

		if(cls == "unchk"){
	    	alert("개인정보 활용에 동의하셔야 합니다.");
	        return false;
		}

		$.ajax({
			type: "POST",
			url: "/mobilefirst/evt/ajax/newfriend_ranking_ins.jsp",
			data: "uphone="+uphone,
			dataType: "JSON",
			success: function(json){
				if(json.result == 1){
					alert("초대킹 이벤트 참여완료!\n이벤트기간 동안 초대한 친구가\n코드 입력하면 자동 집계되며,\n초대한 친구 수는 익일반영됩니다.");
					return false;
				}else if(json.result == -1){
					alert("이미 참여하셨습니다!\n이벤트 기간 동안 초대한 친구가 코드 입력하면 자동 집계되며,\n초대한 친구 수는 익일 반영됩니다. ");
					return false;
				}else{
					alert("시스템오류입니다. 다시 시도하세요");
					return false;
				}
			}
		});
	});
	//getRankingList();
});
// 전화번호 검증
String.prototype.isValidHP = function() {	return this.match(/^01[016789]{1}\d{3,4}\d{4}$/);}
function CmdSingUp(param){
	ga('send', 'event', 'mf_event', '친구초대', '초대코드 등록');

	newFriendGa("evt_newfriend_code");

	if(vUserId == ""){
		document.location.href = "/mobilefirst/login/login.jsp?app=&backUrl="+encodeURIComponent(document.location.href);
	}else{
		var rec_userid = $("#step0"+param+"_text").val();

		if(rec_userid.trim() == ""){
			alert("유효하지 않은 초대코드 입니다.\n 초대코드를 정확히 입력해주세요");
		}else{
			$.ajax({
				type: "GET",
				url: "/mobilefirst/evt/ajax/friend_chk.jsp?chk=1&rec_userid="+rec_userid,
				async: false,
				dataType: "JSON",
				success: function(json){

					if(json.result == "UO"){//이미 등록 코드있음
						alert("이미 초대자를 등록한 계정이 있습니다.");
						return false;
					}else if(json.result == "RE"){//코드발급 안했다
						alert("유효하지 않은 초대코드 입니다.\n 초대코드를 정확히 입력해주세요!");
					}else if(json.result == "Y"){
						onoff('agree');
						$("#code_num").text(rec_userid);
						return false;
					}else if(json.result == "SAME"){ //같다
						alert("초대자와 초대받은 사람이 같습니다.\n 초대자를 확인해주세요!");
						return false;
					}else if(json.result == "UE"){ //인증 안됐습니다.
						$("#myInvite3").show();
						return false;
					}else if(json.result == -5){

						var r = confirm("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?");
						if(r){
							location.href = "https://m.enuri.com/mobilefirst/member/myAuth.jsp?cmdType=&f=m&freetoken=login_title";
						}

					}else if(json.result == -101){
						alert("웰컴 페이백 혜택과 중복 참여 불가합니다");
						return false;
					}else{
						alert("유효하지 않은 초대코드 입니다.\n 초대코드를 정확히 입력해주세요");
						return false;
					}
				}
			});
		}
	}
}
function CmdTab1(){
	ga('send', 'event', 'mf_event', '친구초대_회원탭', '친구탭');
}
function getPoint(){
	$.ajax({
		type: "GET",
		url: "/mobilefirst/emoney/emoney_get_point.jsp",
		async: false,
		dataType:"JSON",
		success: function(json){
			remain = json.POINT_REMAIN;	//적립금
			$("#my_emoney").html(CommaFormattedN(remain) +""+json.POINT_UNIT);

		}
	});
}

function goAppStore(){
	//설치하기
	var url;
	if( navigator.userAgent.indexOf("iPhone") > -1 ||
		navigator.userAgent.indexOf("iPod") > -1 ||
		navigator.userAgent.indexOf("iPad") > -1){

		url = "https://itunes.apple.com/kr/app/" +
		"enuli-gagyeogbigyo/id476264124?mt=8&freetoken=outlink";
	}else if(navigator.userAgent.indexOf("Android") > -1){
		url = "market://details?id=com.enuri.android&referrer=" +
		"utm_source%3Denuri.%26utm_medium%3Dreview_event%26utm_campaign%3Dreview_promotion_20151231%2520";
	}
	window.location.href = url;
}
function getStore_random(param ,price1, price2){
	$.ajax({
		type: "GET",
		data: "price1="+price1+"&price2="+price2,
		url: "/mobilefirst/emoney/emoney_get_random2.jsp",
		async: false,
		dataType:"JSON",
		success: function(data){
			$("#"+param).html(null);

			var vTxt = "";

			$.each(data.itemlist, function(i, item) {
				vTxt +="<li>";
				vTxt +="	<a href=\"javascript:///\" onclick=\"goEmoneygoods('http://m.enuri.com/mobilefirst/emoney/emoney_detail.jsp?freetoken=emoney_sub&code="+ item.gift_code +"&seq="+ item.gift_seq +"&item="+ item.item_seq +"');\">";
				vTxt +="	<img src=\"<%=IMG_ENURI_COM%>/images/mobilefirst/emoney/item/@"+ item.item_seq +".jpg\" alt=\"\">";
				vTxt +="		<em class=\"ellipsis\">"+ item.item_name +"</em>";
				vTxt +="		<span><em class=\"e\">e머니</em>"+ CommaFormattedN(item.gift_price) +"</span>";
				vTxt +="	</a>";
				vTxt +="</li>";
			});
			$("#"+param).html(vTxt);
		}
	});

	if(param == "benefit_list_1"){			//6500
		ga('send', 'event', 'mf_event', '친구초대_회원탭', '스토어상품');
	}else if(param == "benefit_list_2"){	//1500
		ga('send', 'event', 'mf_event', '친구초대_'+gaGubun+'친구탭', '앱설치 스토어상품');
	}else if(param == "benefit_list_3"){	//5000
		ga('send', 'event', 'mf_event', '친구초대_'+gaGubun+'친구탭', '첫구매 스토어상품');
	}
}
function fn_share_on(no){

	if(vUserId == ""){
		$(".btn_login").click();
		return false;
	}

	if(no == "1"){
		share_no = "kakao";
		//sendTalkLink();
	}else{
		share_no = "face";
		sendFacebook();
	}
	ga('send', 'event', 'mf_event', '친구초대_회원탭', '초대하기');
}
<%-- function sendTalkLink(){

	var strlabel = "";
	if (vUserId != ''){
		strlabel += "<%=userArea%>님이\n[에누리 가격비교]로 초대합니다.\n\n";
	}

	strlabel += "추가할인 된 최저가비교!\n"
			+ "여러 쇼핑몰에서 구매해도 혜택을 한번에!\n\n"
			+ "초대받고 1만원만 사면 ⓔ<%=FmtStr.commaToMoney(point)%>\n"
			+ "커피,영화,상품권 생활쿠폰으로 교환하세요!\n\n";
	if (vUserId != ''){
		strlabel += "▶ 초대코드: "+vUserId+"\n";
	}

	strlabel += gateURL; // 웹 게이트로 가는 url임.
	// strlabel += "<a href=''>앱으로 연결</a>";

 	try{
		Kakao.Link.sendTalkLink({
			label: strlabel,
			image: {
				src: "<%=IMG_ENURI_COM%>/images/event/facebook_1228.jpg",
				width: '560',
				height: '292'
		    },
		    webButton: {
		    	text: "앱으로 연결",
				url: "http://m.enuri.com/mobilefirst/event/bridge.jsp"
			},
			fail : function() {
			    alert("카카오 톡이 설치 되지 않았습니다.");
			}
	    });
	}catch(e){
		alert(e);
		alert("카카오 톡이 설치 되지 않았습니다.");
	}
} --%>
function sendFacebook(){

	//var title = "[에누리가격비교] 친구 초대 이벤트\n"
	//			+ "추가할인 된 최저가쇼핑 + 초대혜택 ⓔ5000!\n"
	//			+ "커피,영화,편의점 생활쿠폰을 받으세요!\n";

	var title = "[에누리가격비교] 친구 초대 이벤트\n"
				+"평균8.3% 추가할인 + e머니 "+setPoint+" 혜택\n"
				+"스타벅스, CU, 상품권까지 1000가지 생활쿠폰을 받으세요!\n";

	try{
		window.android.android_window_open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(title)+"&u="+gateURL);
	}catch(e){
		window.open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(title)+"&u="+gateURL);
	}
}
function copyURL(){
	var ua = navigator.userAgent.toLowerCase();
	var isAndroid = ua.indexOf("android") > -1;

	$("#url_text").text("아래의 URL을 길게 누르면 복사할 수 있습니다.");
	$("#layer_geturl").show();

	var layerPopHeight = $("#layer_geturl").find('.layerPopInner').height();
	$("#layer_geturl").find('.layerPopInner').css('margin-top','-'+ layerPopHeight / 2 + 'px' );

	$("#txt_getUrl").val(gateURL);
	return false;
}
/*
function getAppInsInfo(){
	$.ajax({
		type: "GET",
		url: "/mobilefirst/event2017/friend_getlist.jsp",
		data: "osType=mobile&type=ins&pg="+app_pageno+"&pgsize="+pagesize,
		dataType: "JSON",
		success: function(json){
			//if(json.totalCnt){
			if(json.totalCnt != "undefined"){
				apptotalcnt = json.totalCnt;
				if(apptotalcnt > 999)	$("#invitepeople").html("999");
				else					$("#invitepeople").html(CommaFormattedN(apptotalcnt));
				getBuyInfo();
			}
		},
		error: function (xhr, ajaxOptions, thrownError) {
			//alert(xhr.status);
			//alert(thrownError);
		}
	});
}
*/
/*
function getRankingList(){
	$.ajax({
		type: "GET",
		url: "/mobilefirst/evt/ajax/ajax_rankingList.jsp",
		dataType: "JSON",
		success: function(json){

			var RANKINGLIST = json.RANKINGLIST;

			if(RANKINGLIST){
				$.each(RANKINGLIST,function(i,v){
					if(i == 0) $(".todayrank__list").append("<li class=\"top\"><span class=\"rank\">"+(i+1)+"등</span> "+v.user_id+"님</li>");
					else       $(".todayrank__list").append("<li><span class=\"rank\">"+(i+1)+"등</span> "+v.user_id+"님</li>");
				});
			}
			if( RANKINGLIST.length == 0 )	 $(".todayrank__list").append("<li class=\"firstgrade\">익일 순위 노출 됩니다.</li>");
		}
	});
}
*/

//초대 첫구매혜택
function getBuyInfo(){
	$.ajax({
		type: "GET",
		url: "/event2016/friend_getlist2.jsp",
		data: "osType=mobile&type=buy&pg="+buy_pageno+"&pgsize="+pagesize+"&stdate="+<%=startDate%>+"&sdt="+<%=sdt%>,
		dataType: "JSON",
		success: function(json){

			if(json.NOMIEE_POINT != "undefined"){
				var NOMIEE_POINT = json.NOMIEE_POINT;
				var NOMIEE_CNT = json.NOMIEE_CNT;
				var REC_CNT = json.REC_CNT; //스템프 갯수

				APPLYCNT = json.APPLYCNT; //초대랭킹 신청여부

				if(NOMIEE_POINT > 999999)	$("#inviteemoney").html("999,999");
				else						$("#inviteemoney").html(CommaFormattedN(NOMIEE_POINT));

				if(NOMIEE_CNT > 999)	$("#invitepeople").html("999");
				else					$("#invitepeople").html(CommaFormattedN(NOMIEE_CNT));

				//if(APPLYCNT > 0){
					//if( RANKINGNUM >= 1 && RANKINGNUM <= 2 )        $("#iconrank").prepend("<span class=\"icon rank1\">1~2위 : 왕관</span>");
					//else if( RANKINGNUM >= 3 && RANKINGNUM <= 10  )	$("#iconrank").prepend("<span class=\"icon rank2\">3~10위 : 왕관</span>");
					//else if( RANKINGNUM >= 3 && RANKINGNUM <= 10  )	$("#iconrank").prepend("<span class=\"icon rank3\">11위 ~ : 엄지척</span>");

					//$("#rankingArea").addClass("layer--rank view__rank");
				//}
				if(sdt<20200901){
					if(REC_CNT == 0)        $(".invitegift__coupon--bg").html("<span class=\"coupon have\"></span>");
					else if(REC_CNT > 3)	$(".invitegift__coupon--bg").html("<span class=\"coupon have3\"></span>");
					else					$(".invitegift__coupon--bg").html("<span class='coupon have"+REC_CNT+"'></span>");
				}else{
					for(i=1;i<REC_CNT+1;i++){
						//$(".stamp_smile").append("<em class=\"sm"+i+" on\">스탬프1</em>");
						$(".sm"+i).addClass("on");
						if(i > 3)	return false;
					}
				}
			}
		},
		error: function (xhr, ajaxOptions, thrownError) {}
	});
}
//첫구매 확인 5000점
function firstShopping(){
    var html_1 = "";
    var html_2 = "";
    var sdt = <%=numSdt%>;

    if(vUserId == ""){
    	if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
    		location.href = "/mobilefirst/login/login.jsp";
    	}else if(navigator.userAgent.indexOf("Android") > -1){
    		location.href = "/mobilefirst/login/login.jsp?backUrl=/mobilefirst/evt/new_friend_20179.jsp?freetoken=event";
    	}
    	return false;
	}

	if('<%=recUserid%>' == ""){
		alert("초대코드 등록 후 참여해주세요.");
		return false;
	}else{
		$.ajax({
			type: "GET",
			url: "/mobilefirst/ajax/eventAjax/mobileTokenAjaxFriend.jsp",
			data: { chkId: "<%=a_chk_id%>" },
			async: false,
			dataType:"JSON",
			success: function(json){
				var fdate = json.version_first_date; 		//설치 날짜
				var point_date = json.min_date_01; 		//첫구매 날짜
				//var fix_date = json.min_date_04;	 		//구매확정 날짜
				//--var fix_date_04 = json.min_date_04; 		//구매확정 날짜
				var version_first = json.version_first; 	//첫버전
				var firstYN = json.firstYN; 				//첫버전
				var cartChk = json.cartChk;
				var firstbuyeventid = json.firstbuyeventid;
				var diff_day = json.diff_day;				//구매일 30일 이내
				var point_seq = json.point_seq;			//첫구매 포인트 받았는지
				var cart_status = json.cart_status;		//==cartchk
				//var rec_date = json.rec_date				//초대인 등록일
				var cart_total_price = json.cart_total_price // 구매 가격
				cart_total_price = parseInt(cart_total_price);

				//fdate = '2016-02-15';
				//point_date = 0;
				//첫구매가 초대인 등록보다 빠를때....
				var rec_date2 = json.rec_date;
				var min_date_01 = json.min_date_01

				today = new Date();

				// 첫구매 이력
				// 앱 구매 체결 이력
				// 구매적립(2차대사) 여부
				// 체결액 1만원 이상/이하 체크

				var chkId = "<%=a_chk_id%>";

				if(firstbuyeventid.length > 0){
					html_1 = "아쉽지만 첫 구매 대상자가 아닙니다.";
					html_2 = "";
				}else if(cartChk == "S") {

					if(diff_day < 30 && point_seq == "0"){
						// 1만원 이상 구매했는지 확인
						if(cart_total_price >= 10000){
							//첫 구매일 30일 이내로 수정해야함.
							$.ajax({
								type: "POST",
								url: "/mobilefirst/ajax/eventAjax/ajax_FirstShoppingFriend_proc.jsp",
								async: false,
								data: { chkid: chkId },
								dataType:"JSON",
								success: function(json){

									if(diff_day < 30 && point_seq == "0"){
										if(json.result){
											//html_1 = "초대혜택이 신청되었습니다.\n\n첫번째 구매가 1만원 이상이면 10일 후 <%=FmtStr.commaToMoney(point)%>점이 적립됩니다.\n(첫구매를 취소하고 다시 구매하면 해당되지 않습니다.)";
											//html_1 = "초대혜택이 신청 완료!\n구매일로부터 약 7일(최대 30일) 후에\n구매적립받기 버튼 생성됩니다.\nMy페이지 > 구매 적립내역에서\n적립 신청해주세요.";
											html_1 = "친구초대 첫구매 혜택 신청 완료!\n구매일로부터 최대 30일 이내\ne머니 9,000점이 지급 됩니다.\nMy에누리 > My적립내역에서\n 확인해주세요!";
											html_2 = "";
										}else{
											if(json.pointUserCnt == "UX"){
												html_1 = "초대자를 등록 하지않으셨습니다. 초대자 등록 후 신청해주세요";
												html_2 = "";
											}else if(json.pointUserCnt == "UO"){
												html_1 = "이미 초대 받으신 계정이 존재 합니다.";
												html_2 = "";
											}else if(json.pointUserCnt == "UD"){
												html_1 = "아쉽지만 대상자가 아닙니다.";
												html_2 = "";
											}else{
												html_1 = "이미 초대 혜택이 신청 되었습니다.(1)";
												html_2 = "";
											}
										}
									}else{
										html_1 = "아쉽지만 첫구매 대상자가 아닙니다.";
										html_2 = "";
									}
								},error: function (xhr, ajaxOptions, thrownError) {
									alert("시스템 오류 입니다. 새로고침 후 다시 시도 하세요.(1)");
									return false;
								}
							});
						}else{
							html_1 = "1만원 이상 구매 후 신청하세요. \n";
							html_2 = "";
						}
					}else{
						html_1 = "아쉽지만 첫구매 대상자가 아닙니다. ";
						html_2 = "";
					}
				} else if(cartChk == "E") {

					html_1 = "구매후 신청하세요 \n\n";
					html_2 = "";

				}else {
					html_1 = "아쉽지만 첫구매 대상자가 아닙니다. ";
					html_2 = "";
				}

				alert(html_1);

				},error: function (xhr, ajaxOptions, thrownError) {
				alert("시스템 오류 입니다. 새로고침 후 다시 시도 하세요.(2)");
				return false;
			}
		});
	}
}
function goEmoneygoods(url){
	 if('<%=appYN %>' != 'Y'){
		$('.lay_only_mw').show();
	 }else{
		 if(islogin())		window.open(url);
		else		       	location.href = "/mobilefirst/login/login.jsp";
	}
}
function islogin() {
	var cName = "LSTATUS";
	var s = document.cookie.indexOf(cName +'=');
	if (s != -1){
		s += cName.length + 1;
		e = document.cookie.indexOf(';',s);
		if (e == -1){
			e 	= document.cookie.length;
		}
		if( unescape(document.cookie.substring(s,e))=="Y"){
			try {
				if(window.android){
						window.android.isLogin("true");
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
function getCookie(c_name) {
	var i,x,y,ARRcookies=document.cookie.split(";");
	for(i=0;i<ARRcookies.length;i++) {
		x = ARRcookies[i].substr(0,ARRcookies[i].indexOf("="));
		y = ARRcookies[i].substr(ARRcookies[i].indexOf("=")+1);
		x = x.replace(/^\s+|\s+$/g,"");
		if(x==c_name) {
			return unescape(y);
		}
	}
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

  while(n.length > 3){
      var nn = n.substr(n.length-3);
      a.unshift(nn);
      n = n.substr(0,n.length-3);
  }
  if (n.length > 0) { a.unshift(n); }
  n = a.join(delimiter);
  amount = minus + (n+ "");
  return amount;
}
function goMyauth(type){

	if(!$(".chkbox.myinfoYN"+type).is(":checked")){
		alert("이벤트참여를 위하여 정보 수집에 동의해주세요");
		return false;
	}

	var pd = "<%=pd%>";

	if('<%=appYN %>' == 'Y'){
		window.open("https://m.enuri.com/mobilefirst/member/myAuth.jsp?userid=<%=cUserId%>&app=Y&freetoken=login_title&pd="+pd);
	}else{
		window.open("https://m.enuri.com/mobilefirst/member/myAuth.jsp?userid=<%=cUserId%>&freetoken=login_title");
	}
	$("#myInvite2").hide();

	return false;
}

function createCode(){

	$.ajax({
	    type: "GET",
	    async : false,
	    url: "/event2017/ajax/friend_setUrl_2017.jsp",
	    dataType: "JSON",
	    success: function(json){
			if(json.shorturl == 1){
				alert("본인 인증을 하셔야 초대 코드를 발급 받으실수있습니다.");
				return;
			}else if(json.shorturl == 99){
				alert("이미 본인 인증을 한 계정이 존재합니다.");
				return;
			}else{
				gateURL = "http://m.enuri.com/short/"+json.shorturl;
				$("#myInvite1").hide();
				$(".my_code").hide();
				getUserCerti();
				return;
			}
	    },
		error: function (xhr, ajaxOptions, thrownError) {}
	});

}
function head_bar(param){
	if(param == 0)	$("#topFix").hide();
	else			$("#topFix").show();
}
function setLog(){
	//var strGkind = '<%//=strGkind%>'+'';
    //var strGno = '<%//=strGno%>'+'';
    /*
    if(strGkind == "71" && strGno == "2975776"){
        ga('send', 'event', 'mf_event', '설치이벤트_WEB', '망고_친구추천');
    }else if(strGkind == "68" && strGno == "2975775"){
        ga('send', 'event', 'mf_event', '설치이벤트_WEB', '모비온_친구추천');
    }
    */
}
function shuffle(a) {
    var j, x, i;
    for (i = a.length; i; i--) {
        j = Math.floor(Math.random() * i);
        x = a[i - 1];
        a[i - 1] = a[j];
        a[j] = x;
    }
}
function getUserCerti(){ //인증확인
	if (islogin()) {
		$.ajax({
			type: "GET",
			url: "/mobilefirst/evt/ajax/ajax_get_certi.jsp",
			dataType: "JSON",
			success: function(json){
				var sdt = <%=numSdt%>;
				var evt1_class = '';

				if(sdt < 20200901){
					evt1_class = '.invsend > dd';
				}else{
					evt1_class = '.invite_evt1_head';
				}
				if(json.result == "S"){ //인증완료 상태 // 코드 없는 상태
					//$(this).hide();
					//$("#myInvite1").show();
					if(sdt < 20200901){
					 	$(evt1_class).prepend("<span class='my_code' data-id='"+json.result+"' data-cnt="+json.cikeyCnt+" >나의 초대코드 확인하기</span><strong class='invcode'></strong>");
					}else{
						$("#no_certi").show();
						$("#no_certi").addClass("my_code");
					}
				}else if(json.result == "N" || json.result == -5){
					if(sdt < 20200901){
					 	$(evt1_class).prepend("<span class='my_code' data-id='"+json.result+"' data-cnt="+json.cikeyCnt+" >나의 초대코드 확인하기</span><strong class='invcode'></strong>");
					}else{
						$("#no_certi").show();
						$("#no_certi").addClass("my_code");
					}
				}else if(json.result == "G"){
					if(sdt < 20200901){
						$(evt1_class).prepend("<strong class='invcode'>"+vUserId+"</strong>");
					}else{
						$("#out_code").addClass("memberid");
						$("#out_code").html(vUserId);
						$("#out_code").show();
						$("#out_code_logout").hide()
						$("#btncode").attr("onclick", "");
					}
					gateURL = "http://m.enuri.com/short/"+json.myUrl;
				}else if(json.result == "LE"){
					//goLogin();
					if(sdt < 20200901){
						$(evt1_class).prepend("<span class='my_code' data-id='"+json.result+"' data-cnt="+json.cikeyCnt+" >나의 초대코드 확인하기</span>");
					}else{
						$("#out_code").hide();
						$("#out_code_logout").show();
						$("#btncode").attr("onclick", "goLogin();");
					}
				}else if(json.result == "O"){
					$(evt1_class).prepend("<span class='my_code' data-id='"+json.result+"' data-cnt="+json.cikeyCnt+" >나의 초대코드 확인하기</span>");
				}
				$(".my_code").click(function(){
					ga('send', 'event', 'mf_event', '친구초대_회원탭', '나의초대코드확인하기');
					$.ajax({
						type: "GET",
						url: "/mobilefirst/evt/ajax/ajax_get_certi.jsp",
						dataType: "JSON",
						success: function(json){

							var type = json.result;
							var cnt = json.cikeyCnt;

							if(cnt > 0){
						    	alert("이미 초대 코드를 받은 계정이 있습니다.");
						    	return false;
						    }else if(type == "N"){//인증없는 상태
								//$(this).hide();
								$("#myInvite2").show();
								return false;
							}else if(type=="S"){ //코드 없는 상태
								//$(this).hide();
								$("#myInvite1").show();
								return false;
							}else if(type == "LE"){
								goLogin();
								return false;
							}else if(type == -5){
								var r = confirm("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?");
								if(r){
									location.href = "https://m.enuri.com/mobilefirst/member/myAuth.jsp?cmdType=&f=m&freetoken=login_title";
								}
							}
						}
					});
					/*
					var type = $(this).attr("data-id");
					var cnt = $(this).attr("data-cnt");

				    if(cnt > 0){
				    	alert("이미 초대 코드를 받은 계정이 있습니다.");
				    	return false;
				    }else if(type == "N"){//인증없는 상태
						//$(this).hide();
						$("#myInvite2").show();
						return false;
					}else if(type=="S"){ //코드 없는 상태
						//$(this).hide();
						$("#myInvite1").show();
						return false;
					}else if(type == "LE"){
						goLogin();
						return false;
					}
				    */
				});
			}
		});
	}else{
		if(sdt < 20200901){
			$(evt1_class).prepend("<span class='my_code' data-id='"+json.result+"' data-cnt="+json.cikeyCnt+" >나의 초대코드 확인하기</span>");
		}else{
			$("#out_code").hide();
			$("#out_code_logout").show();
			$("#btncode").attr("onclick", "goLogin();");
		}
	}

}
function mo_ga(tab){

	if(tab==1){
		ga('send', 'event', 'mf_event', '친구초대', '상단탭_웰컴팩');
	}else if(tab==2){
		ga('send', 'event', 'mf_event', '친구초대', '상단탭_친구초대');
	}else if(tab==3){
		ga('send', 'event', 'mf_event', '친구초대', '상단탭_파워적립');
	}else if(tab==4){
		ga('send', 'event', 'mf_event', '친구초대', '초대코드 확인');
	}
}
$(document).ready(function(){
	ga('send', 'pageview', {'page': '/mobilefirst/evt/new_friend_20179.jsp','title': '친구초대_PV'});




	$("#getCode").click(function(){
		if($("#myinfoYN").is(":checked")){
			createCode();
		}else{
			alert("정보동의 체크 하셔야 참여 할수 있습니다.");
			return false;
		}
	});
	getUserCerti();
});
function agreechk(obj){
	if (obj.className== 'unchk') obj.className = 'chk';
	else 				         obj.className = 'unchk';
}
function newFriendGa(strEvent){
	/*if(gaGubun == "app"){
		try{
	        if(window.android){            // 안드로이드
	                 window.android.igaworksEventForApp (strEvent);
	        }else if(/iPhone|iPad|iPod/i.test(navigator.userAgent)){      // 아이폰에서 호출
	                 window.location.href = "enuriappcall://igaworksEventForApp?strEvent="+ strEvent;
	        }
		}catch(e){}
	}*/
}


CmdShare();
function CmdShare(){
	Kakao.Link.createDefaultButton({
		  container: '#kakao-link-btn',
	      objectType: 'feed',
	      content: {
	        title: '<%=strFb_title%>',
	        description: "<%=strFb_description%>",
	        imageUrl: "<%=strFb_img%>",
	        link: {
	          webUrl: shareUrl,
	          mobileWebUrl: shareUrl
	        }
	      },
		buttons: [{
	          title: '에누리 가격비교',
	          link: {
	            mobileWebUrl: shareUrl,
	            webUrl: shareUrl
	          }
		}]
    });
}

var vApp = "<%=strApp%>";
if(vApp == "Y")	{
	// 애드브릭스 적용: 프로모션
	var strEvent = "event_newfriend_view";

	try{
		if(window.android){            // 안드로이드
			window.android.airbridgeEventForApp(strEvent,"event","newfriend","");
		}else{                               // 아이폰에서 호출
			window.location.href = "enuriappcall://airbridgeEventForApp?p1="+strEvent+"&p2=event&p3=newfriend&p4=";
		}
	}catch(e){}
}
</script>
<script type="text/javascript" src="<%=ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
</html>