<%@page import="com.enuri.bean.main.deal.CrazyDeal_VO"%>
<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%
String strFb_title = "[에누리 가격비교] CRAZY DEAL!";
String strFb_description = "오전 10시! 세상에 없던 미친 할인이 온다!";
String strFb_img = "http://img.enuri.info/images/mobilefirst/etc/crazysns.jpg";

String flow = ChkNull.chkStr(request.getParameter("flow"));

if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){
}else{
	String redirectUrl = "http://www.enuri.com/evt/CrazyDeal.jsp";
	if(!"".equals(flow)) {
		redirectUrl += "?flow=" + flow;
	}
    response.sendRedirect(redirectUrl);
    return;
}

CrazyDeal_VO commingSoonVO = new CrazyDeal_VO();

String chkId   = ChkNull.chkStr(request.getParameter("chk_id"),"");

String cUserId = cb.GetCookie("MEM_INFO","USER_ID");
String cUserNick = cb.GetCookie("MEM_INFO","USER_NICK");

Members_Proc members_proc = new Members_Proc();
String cUsername = members_proc.getUserName(cUserId);
String userArea = cUsername;

long cTime = System.currentTimeMillis();
SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMdd");
String sdt =dayTime.format(new Date(cTime));//진짜시간

dayTime = new SimpleDateFormat("yyyyMMddHHmmss");
String todayAtMidn = dayTime.format(new Date(cTime));

//test
if( request.getServerName().equals("dev.enuri.com") &&  request.getParameter("sdt")!=null && !"".equals(request.getParameter("sdt"))){
	sdt= request.getParameter("sdt");
} 

String strUrl = request.getRequestURI();
String snsUserYN = "";

if(!cUserId.equals("")){
    cUsername = members_proc.getUserName(cUserId);
    userArea = cUsername;

    if(cUsername.equals(""))	userArea = cUserNick;
    if(userArea.equals(""))		userArea = cUserId;
   	
    String snsType = ChkNull.chkStr(cb.GetCookie("MEM_INFO","SNSTYPE"));
	if( "K".equals(snsType) ||  "N".equals(snsType) ){//sns 계정일 경우 닉네임을 넣어준다
		snsUserYN = "Y";
	}else{
		snsUserYN = "N";
	}
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
	<title>크레이지딜 - 최저가 쇼핑은 에누리</title>
	<META NAME="description" CONTENT="오전 10시! 세상에 없던 미친 할인 혜택을 제공합니다!"> 
	<META NAME="keyword" CONTENT="에누리, 크레이지딜, 할인, 미친 할인, 오전10시, 초특가, 최저가">
	<link rel="stylesheet" href="/css/event/com.enuri.event.m.css" type="text/css">
	<link rel="stylesheet" type="text/css" href="/css/event/y2018/crazydeal_m.css?v=20180816"/>
	<link rel="stylesheet" type="text/css" href="http://m.enuri.com/mobilefirst/css/lib/slick.css"/>
	<script type="text/javascript" src="http://m.enuri.com/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="http://m.enuri.com/mobilefirst/js/lib/slick.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/event_regular.js?v=2018072301"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js?v=202020"></script>
	<style type="text/css">
	    .enuri_deal .deal_goods li .thum_sub {display:none; width:100%; height:100%;}
	    .enuri_deal .deal_goods li .thum_first {display:block; width:100%; height:100%;  } 
	</style>
</head>
<script type="text/javascript">
Kakao.init('5cad223fb57213402d8f90de1aa27301');
</script>
<body>
<!-- layer-->
<div class="layer_back" id="app_only" style="display:none;">
	<div class="appLayer">
		<h4>모바일 앱 전용 이벤트</h4>
		<a href="javascript:///" class="close" onclick="$('#app_only').hide();">창닫기</a>
		<p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br />에누리앱을 설치합니다.</p>
		<p class="btn_close"><button type="button" onclick="install_btt();" >설치하기</button></p>
	</div>
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
						<span id="txtURL" class="txt__share_url">http://m.enuri.com/mobilefirst/evt/mobile_deal.jsp</span>
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
			clipboard.on('success', function(e) {	alert('주소가 복사되었습니다');	});
			clipboard.on('error', function(e) {				console.log(e);			});
		});
	</script>
</div>
<!-- 구매방법 -->
<div class="layer_back" style="display: none;" id="buyway">
	<div class="noteLayer buyway">
		<div class="inner">
			<h4><span>CRAZY DEAL 구매방법</span></h4>
			<div class="cont">
				<dl>
					<dt>인터파크 상품페이지에서 [쿠폰받기] 후,</dt>
					<dd>
						<div class="price">
							<del><b>180,400</b>원</del>
							<span class="prc"><b>157,400</b>원</span>
							<a href="javascript:///" class="btn_coupon">쿠폰받기</a>
						</div>
					</dd>
					<dt>결제페이지에서 [쿠폰사용] 선택!</dt>
					<dd>
						<div class="coudis">
							<p class="tit">할인/포인트</p>
							<div class="disc">
								<span>쿠폰할인(1장)</span><em>0원</em><a href="javascript:///" class="btn_change">변경</a>
							</div>
						</div>
					</dd>
				</dl>
			</div>
			<div class="tip">쿠폰은 ID당 한 번만 사용할 수 있으며, <br />쿠폰미사용시 특가할인을 받을 수 없습니다.</div>
			<div class="tac"><a href="javascript:///" class="btn_submit" onclick="$('#buyway').hide();">확인</a></div>
			<a href="javascript:///" class="close" onclick="$('#buyway').hide();">창닫기</a>
		</div>
	</div>
</div>
<div id="eventWrap">
		<%@include file="/eventPlanZone/jsp/eventMovingTapMobile.jsp"%>
		<!-- tab_area -->
		<!-- <div class="tab_area">
			<div class="inner"  id="scrollTabs">
				<ul class="tabmenu">
					<li class="tab1 on"><a class="btn" href="#enuri_deal"><strong>CRAZY 최저가</strong></a></li>활성화 li class="on" 추가
					<li class="tab2"><a class="btn" href="#con2"><strong>CRAZY 이벤트</strong></a></li> 2017-11-30 수정 
				</ul>
			</div>
		</div> -->
		<span id="moveTack"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/event/2017/crazydeal/tack_mov.png" alt="" /></span>
		<div class="floating_bnr"  style="display:none">
			<img src="http://img.enuri.info/images/event/2019/crazyDeal/fl_bnr.png" alt="크레이지 프라이데이" onclick="goCrazyFriday()" >
			<a href="javascript:///" onclick="$('.floating_bnr').hide();return false;" class="btn_close">닫기</a>
		</div>
		<!-- 상단비주얼 -->
		<div class="visual">
			<button class="com__btn_share" onclick="$('.com__share_wrap').show();" style="top:90px">공유하기</button>
			<div class="content">
				<h1 class="blind">[CRAZY DEAL] 하루에 두 번! 세상에 없던 미친 할인이 온다!</h1>
				<span class="title"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/event/2017/crazydeal/pc_visual_tit2.png" alt="" /></span>
				
				<!--20180420 sns 추가  -->
				<!-- 
				<div class="sns">
					<span class="sns_share evt_ico" onclick="dealGA('SNS공유'); onoff('snslayer'); adClickGa(); ">sns 공유하기</span>
					<ul id="snslayer" style="display:none;">
						<li onclick="event_share('kakao');" id = "kakao-link-btn">카카오스토리</li>
						<li onclick="event_share('face');">페이스북</li>
					</ul>
				</div>
				 -->
			</div>
		</div>
		<!-- 에누리딜 -->
		<div class="crz_deal" id="crz_deal">
			<div class="crz_top">
				<span class="title" id="deal_title"></span>
			</div>
			<div class="enuri_deal" id="enuri_deal">
				<ul class="deal_goods" id="deal_goods"></ul>
			</div>
			<!-- <div class="deal_sm">
				<div class="innder_scroll">
					<ul class="swiper-wrapper" id="deal_s_goods"></ul>
				</div>
			</div> -->
			<div class="crz_bot">
				<a href="javascript:///" class="btn_check"><span>!</span><u>꼭! 확인하세요</u></a>
			</div>
			<!--  유의사항 -->
			<div class="moreview">
				<h4 class="blind">유의사항</h4>
				<div class="txt">
					<ul class="txt_indent">
						<!-- 
						<li><i>-</i> CRAZY DEAL 상품의 주문/배송/환불/보증 관련 책임은 해당 쇼핑몰의 판매자에게 있습니다.</li>
						<li><i>-</i> 부정한 방법으로 상품 구매 시 주문이 취소될 수 있습니다.</li>
						<li><i>-</i> 상품쿠폰을 발급받은 경우에도 판매마감 후 또는 다른 상품에는 사용이 불가합니다.</li>
						<li><i>-</i> 본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 조기종료 될 수 있습니다.</li>
						<li><i>-</i> 설날, 추석 등 시즌상품 또는 상품 특성에 따라 결제가 늦어질 경우 주문이 취소될 수 있으며, 이에 따른 보상은 이루어지지 않습니다.</li>
						<li><i>-</i>신규 앱설치 회원 전용 상품은 최근 3개월 내 앱 설치 회원만 구매가 가능합니다.
						
						<br>(ex. 3월 1일 진행상품의 경우 1월 1일 이후 앱설치자만 구매가능 – 진행월 포함/월기준)</li>
						<li><i>-</i>신규 앱설치 회원 전용 상품은 모바일 앱에서만 구매할 수 있습니다. (모바일 웹, PC에서 구매불가)</li>
						<li><i>-</i> 신규 앱설치 회원 전용 상품은 해당 기기와 ID의 앱설치일을 기준으로 하며, 앱 삭제 후 재설치시에도 기존 설치이력이 있는 경우에는 구매할 수 없습니다.</li>
						 -->
					 	<li> - 본인인증 완료된 에누리ID로만 참여가 가능합니다</li>
						<li> - 상품결제는 인터파크에서 이루어지며 인터파크 ID가 필요합니다.</li>
						<li> - CRAZY DEAL 상품의 주문/배송/환불/보증 관련 책임은 해당 쇼핑몰의 판매자에게 있습니다.</li>
						<li> - 부정한 방법으로 상품 구매 시 주문이 취소될 수 있습니다.</li>
						<li> - CRAZY DEAL은 선착순 한정수량 판매로 결제 진행 중 상품이 품절될 경우 판매가 종료될 수 있습니다</li>
						<li> - 상품쿠폰을 발급받은 경우에도 판매마감 후 또는 다른 상품에는 사용이 불가합니다.</li>
						<li> - 본 이벤트는 당사에 사정에 따라 사전고지 없이 변경 또는 조기종료 될 수 있습니다.</li>
					</ul>
				</div>
			</div>
			<!-- // 유의사항 -->
		</div>
		<!--// 에누리딜 -->
     <%@ include file="/mobilefirst/include/inc_ctu.jsp"%>
     <%@ include file="/mobilefirst/evt/crazydeal_shareEvt_main.jsp"%>
		<!-- cm추천 -->
		<div class="recommend" id="recommend_div" style="display:none;">
			<div class="content">
				<!-- 170912 수정 -->
				<h2 class="title">[추천상춤] 아쉽게 특가를 놓쳤다면? 인기상품 최저가로 구매하기</h2>
				<!-- //170912 수정 -->
				<ul class="sort" id="cm_recommend"></ul>
			</div>
		</div>
		<!-- //cm추천 -->
	<span class="go_top"><a href="javascript:///">TOP</a></span>
</div>
<%@ include file="/mobilefirst/event2016/event_footer.jsp" %><!-- 푸터 -->
</body>

<script>
var username = "<%=userArea%>"; //개인화영역 이름
var vChkId = "<%=chkId%>";
var vEvent_page = "<%=strUrl%>"; //경로
var app = getCookie("appYN"); //app인지 여부
var vEvent_title="[모바일]CRAZY DEAL";

var thumbIndex = 0; //첫 실행시 썸네일 이미지 위치

var $imgs="";
var faderOn; //현재 롤링중인 이미지
var interval; //롤링 동작함수
var frontIdx=0; //현재 보여줄 상품 인덱스
var isChange = false; //변하는 순간인가?
var isClick=true; //클릭가능여부

var dealJson = null;
		
var shareUrl = "http://" + location.host + "/mobilefirst/evt/mobile_deal.jsp";
var shareTitle = "[에누리 가격비교] CRAZY DEAL!\n오전 10시! 세상에 없던 미친 할인이 온다!";
		
$(document).ready(function(){
	//로그인시 개인화영역
	if(islogin()){
		$("#user_id").text("<%=cUserId%>");
		getPoint();//개인e머니 내역 노출
	}

	$("#eventShr > li").click(function(){
		var sel = $(this).attr("id");
		//var shareTitle = "크레이지딜";
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
	
	getDealItem(); //크레이지딜 판매상품
	var todayDeal = {"SEQ":"", "GOODS_COMPANY":""}; 
	function getDealItem(){
		var rList;//추천상품		
		$.ajax({
	    	type: "GET",
	        url: "/mobilefirst/http/json/mobile_deal_list.json",
	        dataType: "JSON",
	        success: function(json){
	        	dealJson = json;
	        	var deal_tmpl = "";
	        	var s_deal_tmpl = "";
	        	var i=0;
	        	var default_src = "<%=ConfigManager.STORAGE_ENURI_COM%>";
	        	var obj;
	        	var todayAtMidn = parseInt("<%=todayAtMidn%>");
    			var realIdx = 0;
	        	if(json){
					var smallRemainTime = 10000000000000;
					var sdt = parseInt("<%=sdt%>");
					var term = 0;
					var idx = 0;      
					//첫번째로 표시할 상품 셋팅
					for(i=0; i<json.length;i++){
						obj=json[i];
						//노출되는 상품만 체크
						if(todayAtMidn >= obj.GOODS_ST_EXPODATE_DIF && todayAtMidn <= obj.GOODS_END_EXPODATE_DIF && obj.GOODS_EXPO_FLAG == "Y"){
							//판매기간 내 있고 구매가 가능한 상품
	 						if(todayAtMidn >= obj.GOODS_ST_SELLDATE_DIF && todayAtMidn <= obj.GOODS_END_SELLDATE_DIF && obj.GOODS_EXPO_FLAG == "Y"
	 								&& (("Y" != obj.GOODS_SOLD_FLAG && "1"==obj.GOODS_URL_TYPE)  || ("Y" != obj.EVENT_SOLDOUT_YN && "2"==obj.GOODS_URL_TYPE && "" != obj.EVENT_NO))){
 	 							frontIdx = idx;
								realIdx = i;
 								break;
							}
							//구매가능상태가 아닌 상품(판매기간이 지났거나 솔드아웃)
							else {
								term = parseInt(obj.GOODS_ST_SELLDATE_DIF) - todayAtMidn; 
								//솔드아웃이 아닌것 즉, 판매예정상품들
			        			if( term >= 0 && (("Y" != obj.GOODS_SOLD_FLAG && "1"==obj.GOODS_URL_TYPE) || ("Y" != obj.EVENT_SOLDOUT_YN && "2"==obj.GOODS_URL_TYPE && "" != obj.EVENT_NO) )){
			        				if( term < smallRemainTime){
			        					smallRemainTime = term;
			        					frontIdx= idx;
			        					realIdx = i;
			        				}
			        			}
		        			}
							idx++;
						}
	        		}
					viewDate(json[realIdx].GOODS_ST_SELLDATE_DIF, json[realIdx].GOODS_URL_TYPE);
		        	for(i=0; i<json.length;i++){
	        			obj=json[i];
		        		//지금시간이 게시 시작 날짜보다 크고 / 게시 종료 날짜보다 작으며 / 노출여부플래그가 Y 이면
	        	    	if((todayAtMidn > obj.GOODS_ST_EXPODATE_DIF) && (todayAtMidn < obj.GOODS_END_EXPODATE_DIF) && (obj.GOODS_EXPO_FLAG == "Y")){
			        		if(obj.GOODS_URL_TYPE=="1"){
			        			deal_tmpl += "<li data-modelno=\""+obj.GOODS_MODELNO+"\" data-seq=\""+obj.SEQ+"\" data-stselldate = \""+obj.GOODS_ST_SELLDATE_DIF+"\" data-goodstype = \""+obj.GOODS_URL_TYPE+"\">";
			        		}else if(obj.GOODS_URL_TYPE=="2"){
			        			deal_tmpl += "<li class=\"event\"data-seq=\""+obj.SEQ+"\" data-stselldate = \""+obj.GOODS_ST_SELLDATE_DIF+"\" data-goodstype = \""+obj.GOODS_URL_TYPE+"\">";
			        		}
			        		deal_tmpl += "<a href=\"javascript:///\">";
			        		if(obj.GOODS_URL_TYPE=="1"){
			        			deal_tmpl += "<span class=\"num\"><span><b>"+obj.GOODS_SALE_PER+"</b>%</span>"+obj.GOODS_QUANTITY+"개</span>";
			        		}else{
			        			deal_tmpl += "<span class=\"num\"><span><b>EVENT</b></span></span>";
			        		}
			        		deal_tmpl += "<div class=\"fader\">";
			        		deal_tmpl += "<span class=\"thum\" style=\"overflow:hidden;\">";
			        		if((todayAtMidn > obj.GOODS_END_SELLDATE_DIF || obj.GOODS_SOLD_FLAG=="Y") && obj.GOODS_URL_TYPE=="1"){
			        			deal_tmpl +="<em class=\"endsale\">크레이지딜<br />판매종료</em>";
			        		}else if((todayAtMidn > obj.GOODS_END_SELLDATE_DIF || obj.EVENT_SOLDOUT_YN=="Y") && (obj.GOODS_URL_TYPE=="2" && "" != obj.EVENT_NO)){
			        			deal_tmpl +="<em class=\"endsale\">크레이지딜<br />판매종료</em>";
			        		}
		    				deal_tmpl += "<img class=\"thum_first\" src=\""+ default_src + obj.GOODS_BIG_IMG + "\" onclick=\"imgClick('"+obj.IMG_M_LINK+"')\"alt=\"\">";
		    				//서브 이미지
		    				for(var j=0; j<obj.SUB_IMG.length;j++){
		        				deal_tmpl += "<img class=\"thum_sub\" src=\""+ default_src + obj.SUB_IMG[j].IMG_SRC + "\" onclick=\"imgClick('"+obj.SUB_IMG[j].IMG_M_LINK+"')\"alt=\"\">";
		    				}
		    				deal_tmpl += "</span>";
			        		deal_tmpl += "</div>";
			        		deal_tmpl += "<div class=\"bt_info\">";
			        		deal_tmpl += "<strong class=\"pronm\">"+obj.GOODS_NAME+"<br>"+obj.GOODS_NAME_SUB+"</strong>";
			        		deal_tmpl += "<div class=\"detail\">"+obj.CONTENTS+"</div>";
		        			
			        		//obj.GOODS_COMPANY = "8090";
			        		
			        		deal_tmpl += "<div class=\"mark\">";
			        		if(obj.GOODS_COMPANY=="55"){
			        			deal_tmpl += "<span class=\"market1\">인터파크</span>";
			        		}else if(obj.GOODS_COMPANY=="6641"){
			        			deal_tmpl += "<span class=\"market2\">티몬</span>";
			        		}else if(obj.GOODS_COMPANY=="8090"){
			        			deal_tmpl += "<span class=\"market3\">테일리스트</span>";
			        		}
		        			deal_tmpl += "</div>";
			        		
			        		if(obj.GOODS_URL_TYPE=="1"){
								
			        			//obj.GOODS_PRICE_MARK_HEAD = "$";
				        		//obj.GOODS_PRICE_MARK_TAIL = "";
			        			
			        			if(obj.GOODS_PRICE_MARK_HEAD == "" && obj.GOODS_PRICE_MARK_TAIL == ""){
					        		deal_tmpl += "<div class=\"price\">";
					        		deal_tmpl += "<span class=\"tit\">정상판매가</span>";
						        		deal_tmpl += "<del>";
						        			deal_tmpl += "<b>"+commaNum(obj.GOODS_PRICE)+"</b>원";
						        		deal_tmpl += "</del>";
					        		deal_tmpl += "</div>";
			        			}else if(obj.GOODS_PRICE_MARK_HEAD != "" && obj.GOODS_PRICE_MARK_TAIL == ""){
			        				deal_tmpl += "<div class=\"price\">";
					        		deal_tmpl += "<span class=\"tit\">정상판매가</span>";
						        		deal_tmpl += "<del>";
						        			deal_tmpl += "<b>$"+commaNum(obj.GOODS_PRICE)+"</b>";
						        		deal_tmpl += "</del>";
					        		deal_tmpl += "</div>";	
			        			}else if(obj.GOODS_PRICE_MARK_HEAD == "" && obj.GOODS_PRICE_MARK_TAIL != ""){
			        				deal_tmpl += "<div class=\"price\">";
					        		deal_tmpl += "<span class=\"tit\">정상판매가</span>";
						        		deal_tmpl += "<del>";
						        			deal_tmpl += "<b>"+commaNum(obj.GOODS_PRICE)+"$</b>";
						        		deal_tmpl += "</del>";
					        		deal_tmpl += "</div>";
			        			}
				        		
				        		if(obj.GOODS_PRICE_MARK_HEAD == "" && obj.GOODS_PRICE_MARK_TAIL == ""){
				        			deal_tmpl += "<div class=\"crazy\">";
					        		deal_tmpl += "<span class=\"tit\">크레이지특가</span>";
					        			deal_tmpl += "<del class=\"prc\">";
						        			deal_tmpl += "<b>"+commaNum(obj.GOODS_SALE_PRICE)+"</b>원";
						        		deal_tmpl += "</del>";
					        		deal_tmpl += "</div>";	
				        		}else if(obj.GOODS_PRICE_MARK_HEAD != "" && obj.GOODS_PRICE_MARK_TAIL == ""){
				        			deal_tmpl += "<div class=\"crazy dollar\">";
				        				deal_tmpl += "<span class=\"tit\">크레이지특가</span><del class=\"prc\"><b>$"+obj.GOODS_SALE_PRICE+"</b></del>";
				        			deal_tmpl += "</div>";				        			
				        		}else if(obj.GOODS_PRICE_MARK_HEAD == "" && obj.GOODS_PRICE_MARK_TAIL != ""){
				        			deal_tmpl += "<div class=\"crazy dollar\">";
			        					deal_tmpl += "<span class=\"tit\">크레이지특가</span><del class=\"prc\"><b>"+obj.GOODS_SALE_PRICE+"$</b></del>";
			        				deal_tmpl += "</div>";
				        		}
				        		
	        	    		}else if(obj.GOODS_URL_TYPE=="2" && "" != obj.EVENT_NO){
	        	    			deal_tmpl += "<div class=\"price\">";
				        		deal_tmpl += "<span class=\"tit\">정상판매가</span>";
				        		deal_tmpl += "<del>";
				        		deal_tmpl += "<b>"+commaNum(obj.GOODS_PRICE)+"</b>점";
				        		deal_tmpl += "</del>";
				        		deal_tmpl += "</div>";
				        		deal_tmpl += "<div class=\"crazy\">";
				        		deal_tmpl += "<span class=\"tit\">크레이지특가</span>";
			        			deal_tmpl += "<del class=\"prc\">";
				        		deal_tmpl += "<b>0</b>점";
				        		deal_tmpl += "</del>";
				        		deal_tmpl += "</div>";
	        	    		}
			        		deal_tmpl += "<div class=\"btn_area\">";
			        		//상품
			        		if(obj.GOODS_URL_TYPE=="1"){
			        			//판매예정
			        			if(todayAtMidn < obj.GOODS_ST_SELLDATE_DIF && "N" == obj.GOODS_SOLD_FLAG){
			        				deal_tmpl += "<button type=\"button\" class=\"btn_go\" onclick=\"goVip('"+obj.GOODS_MODELNO+"','"+obj.GOODS_TITLE+"');\">상품보기</button>";
			        				deal_tmpl += "<button type=\"button\" class=\"btn_buy\" id=\"buybtn_"+obj.SEQ+"\" data-no='"+obj.EVENT_NO+"' data-type="+obj.GOODS_URL_TYPE+" data-apl-dt = '"+ obj.DEAL_APL_DT +"' >판매예정</button>";
			        			}else if(todayAtMidn < obj.GOODS_END_SELLDATE_DIF){
			        				//판매중
			        				if("N" == obj.GOODS_SOLD_FLAG){
			        					todayDeal.SEQ = obj.SEQ;
			        					todayDeal.GOODS_COMPANY=obj.GOODS_COMPANY ;
			        					deal_tmpl += "<button type=\"button\" class=\"btn_go\" onclick=\"goVip('"+obj.GOODS_MODELNO+"','"+obj.GOODS_TITLE+"');\">상품보기</button>";
			        					deal_tmpl += "<button type=\"button\" class=\"btn_buy on\" id=\"buybtn_"+obj.SEQ+"\" data-no='"+obj.EVENT_NO+"' data-type="+obj.GOODS_URL_TYPE+" data-apl-dt = '"+ obj.DEAL_APL_DT +"'>구매하기</button>";
			        				}
			        				//다팔림
			        				else{
						        		deal_tmpl += "<button type=\"button\" class=\"btn_blcok\"onclick=\"goVip('"+obj.GOODS_MODELNO+"','"+obj.GOODS_TITLE+"');\">최저가로 구매하기</button>";
			        				}
			        			}else{
			        				//판매기간 종료
					        		deal_tmpl += "<button type=\"button\" class=\"btn_blcok\"onclick=\"goVip('"+obj.GOODS_MODELNO+"','"+obj.GOODS_TITLE+"');\">최저가로 구매하기</button>";
			        			}
			        		} else if(obj.GOODS_URL_TYPE=="2"){  		//프로모션
			        			if(obj.EVENT_NO){
			        				//판매예정
			        				if(todayAtMidn < obj.GOODS_ST_SELLDATE_DIF && "N" == obj.EVENT_SOLDOUT_YN){
				        				deal_tmpl += "<button type=\"button\" class=\"btn_blcok\" id=\"buybtn_"+obj.SEQ+"\" data-no='"+obj.EVENT_NO+"' data-type="+obj.GOODS_URL_TYPE+">판매예정</button>";
				        			}else if(todayAtMidn < obj.GOODS_END_SELLDATE_DIF){
				        				//판매중
				        				if("N" == obj.EVENT_SOLDOUT_YN){
				        					todayDeal.SEQ = obj.SEQ;
				        					todayDeal.GOODS_COMPANY=obj.GOODS_COMPANY ;
				        					deal_tmpl += "<button type=\"button\" class=\"btn_blcok on\" id=\"buybtn_"+obj.SEQ+"\"  data-no='"+obj.EVENT_NO+"' data-type="+obj.GOODS_URL_TYPE+">구매하기</button>";
				        				}else{	//다팔림
							        		deal_tmpl += "<button type=\"button\" class=\"btn_blcok\">판매종료</button>";
				        				}
				        			}else{
				        				//판매기간 종료
						        		deal_tmpl += "<button type=\"button\" class=\"btn_blcok\">판매종료</button>";
				        			}
			        			}else{
				        			deal_tmpl += "<button type=\"button\" class=\"btn_blcok\"onclick=\"goUrl('"+obj.GOODS_URL+"');\">자세히 보기</button>";
			        			}
			        		}
			        		deal_tmpl += "</div>";
			        		
			        		//상품별 조건노출 추가
			        		deal_tmpl +="<div class=\"deal_bot\">";
			        		//이벤트(GOODS_URL_TYPE이 2) 일때는 상품별 조건 비노출
			        		if(obj.GOODS_URL_TYPE=="1"){
			        			
			        			//신규회원 전용 상품 유의사항 문구 추가
			        			if (obj.DEAL_APL_DT != "" && typeof obj.DEAL_APL_DT != "undefined") {
				        			deal_tmpl += "<span class=\"deal_txt2\">※ <em class=\"txt_pt\">신규 앱설치 회원전용 / 앱 전용상품</em> / 쿠폰적용 필수</span>";
			        			} else if(obj.GOODS_COMPANY=="55"){
				        			deal_tmpl += "<span class=\"deal_txt2\">※ ID당 1회  / 무료배송</span>";
				        		}else if(obj.GOODS_COMPANY=="6641"){
				        			deal_tmpl += "<span class=\"deal_txt2\">※ <em class=\"txt_pt\">쇼핑몰 로그인 필수</em> / ID당 1회  / 무료배송</span>";
				        		}else if(obj.GOODS_COMPANY=="8090"){
				        			deal_tmpl += "<span class=\"deal_txt2\">※ <em class=\"txt_pt\">회원가입필수</em> / 무통장 불가 <button type=\"button\" class=\"sprite taildetail\" onclick=\"$('.taillist_layer').show();\" tabindex=\"0\">자세히보기</button></span>";
				        		}
			        		}
			        		deal_tmpl +="</div>";
			        		
			        		deal_tmpl += "</div>";
			        		deal_tmpl += "</a>";
			    			
			    			deal_tmpl += "<div id=\"taillistLayer\" class=\"taillist_layer\" style=\"display:none\">";
			    			deal_tmpl += "	<div class=\"taillist_inner\">";
			    			deal_tmpl += "		<img src=\"<%=ConfigManager.IMG_ENURI_COM%>/images/event/2017/crazydeal/m_layer_taillistdetail.jpg\" alt='' />";
			    			deal_tmpl += "		<div class=\"blind\">";
			    			deal_tmpl += "			<p>테일리스트 해외직구 구매방법!</p>";
			    			deal_tmpl += "			<ul>";
			    			deal_tmpl += "				<li>1. 회원가입 필수</li>";
			    			deal_tmpl += "				<li>2. 개인통관고유부호 회원가입하기</li>";
			    			deal_tmpl += "				<li>3. 할인코드 입력 필수! 발급받기</li>";
			    			deal_tmpl += "				<li>4. 무통장입금 불가 (카드결제만 가능)</li>";
			    			deal_tmpl += "			</ul>";
			    			deal_tmpl += "		</div>";
			    					
			    			deal_tmpl += "		<a href='javascript:///' onclick=\"window.open('http://post.malltail.com/members/regist1?freetoken=outlink')\" class=\"tailbtn tailbtn_1\" >회원가입하기</a>";
			    			deal_tmpl += "		<a href='javascript:///' onclick=\"window.open('https://unipass.customs.go.kr/csp/persIndex.do?freetoken=outlink')\" class=\"tailbtn tailbtn_2\">발급받기</a>";
			    			deal_tmpl += "		<button type='button' class='tailbtn stripe tailclose' onclick=\"$('.taillist_layer').hide();\">레이어 닫기</button>"; 
			    			deal_tmpl += "	</div>";
			    			deal_tmpl += "</div>";
			        		deal_tmpl += "</li>";

		        			s_deal_tmpl += "<li data-index=\""+i+"\" data-stselldate = \""+obj.GOODS_ST_SELLDATE_DIF+"\" data-goodstype = \""+obj.GOODS_URL_TYPE+"\"  >";
			        		s_deal_tmpl += "<a href=\"javascript:///\">";
			        		
			        		var st_selldate = obj.GOODS_ST_SELLDATE_DIF;
			        		
			        		
			        		s_deal_tmpl += "<span class=\"date\">";
			        		s_deal_tmpl += parseInt(st_selldate.substring(4,6))+"월 " + parseInt(st_selldate.substring(6,8))+"일 " + parseInt(st_selldate.substring(8,10))+"시";
			        		s_deal_tmpl += "</span>";
			        		
			        		s_deal_tmpl += "<div class=\"thumb\">";
			        		if((todayAtMidn > obj.GOODS_END_SELLDATE_DIF || "Y"==obj.GOODS_SOLD_FLAG) && "1"==obj.GOODS_URL_TYPE){
			        			s_deal_tmpl +="<em class=\"endsale\">크레이지딜<br />판매종료</em>";
			        		}else if((todayAtMidn > obj.GOODS_END_SELLDATE_DIF || "Y"==obj.EVENT_SOLDOUT_YN) && ("2" == obj.GOODS_URL_TYPE && "" != obj.EVENT_NO)){
			        			s_deal_tmpl +="<em class=\"endsale\">크레이지딜<br />판매종료</em>";
			        		}
		    				s_deal_tmpl += "<img src=\""+ default_src + obj.GOODS_BIG_IMG + "\" alt=\"\">";

			        		if(obj.GOODS_URL_TYPE=="1"){
				        		s_deal_tmpl += "<span class=\"dis\">";
				        		s_deal_tmpl += "<b>"+ obj.GOODS_SALE_PER+"</b>%";
				        		s_deal_tmpl += "</span>";
			        		}
			        		s_deal_tmpl += "</div>";
			        		s_deal_tmpl += "<span class=\"tit\">"+obj.GOODS_TITLE.substring(0,10)+"</span>";
			        		s_deal_tmpl += "<i></i>";
			        		s_deal_tmpl += "</a>";
			        		s_deal_tmpl += "</li>";
	        	    	}
		        	}
	        		if(json[realIdx].DISPLAY_YN=='Y'){
	        			rList = json[realIdx].R_LIST;//오늘날짜의 추천상품 저장
	        		}
		        	$("#deal_goods").html(deal_tmpl);
		        	/* $("#deal_s_goods").html(s_deal_tmpl); */
	        	}
	        	
	        	//판매가 임박한 상품 버튼 change
	            $.ajax({
	                type: "get",
	                url: "/mobilefirst/evt/ajax/ajax_commingdeal.jsp",
	                dataType: "JSON",
	                async : true,
	                success: function(result){
	                	if(result.isSaleSoon){
	                		var soonSeq = result.soonSeq;
	                		var remainTime = result.remainTime;
	                		var soonGoodsCompany = result.soonGoodsCompany;
	                		var soonBtn = $("#buybtn_"+soonSeq);
	                		var result = result.result;
	                		setTimeout(function(e){
	                			$("#soon_"+soonSeq).hide();
	                			soonBtn.text("구매하기");
	        					soonBtn.addClass("on");
	        					soonBtn.click(function(e){
	        						dealGA('구매하기');
	        						var _this = $(this);
	        						
	        						var dataType = _this.attr("data-type");
	        						var eventno = _this.attr("data-no");
	        						var aplDate = _this.attr("data-apl-dt");
	        						
	        						if("2" == dataType){
	        							if(eventno){//타임이벤트 일경우
	        								
	        								if( result == -5 ){
		        								var r = confirm("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?");
		        								if(r){
		        									location.href = "/mobilefirst/member/myAuth.jsp?cmdType=&f=m";
		        									return false;
		        								}
	        								}
	        								goLuckyTime(soonSeq);	
	        							}
	        						}else{
	        							if(getCookie("appYN") != "Y" && aplDate != "" && typeof aplDate != "undefined"){
	        								alert("모바일 앱에서만 구매 가능합니다!")
	        								return false;
	        							} 
	        							if(!islogin()){
	        								alert("로그인 후 구매하실 수 있습니다.");
	        								goLogin();
	        								return false;
	        							}else{
	        								if( result == -5 ){
		        								var r = confirm("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?");
		        								if(r){
		        									location.href = "/mobilefirst/member/myAuth.jsp?cmdType=&f=m";
		        								}
	        								}
	        							}
	        							goDealShop('',soonGoodsCompany,soonSeq);	
	        						}
	        					});
	                		}, remainTime);
	                	}
	                }
	            });
	        },complete: function(e){
	        	try{
	        		//추천상품 뿌려주기
		        	var r_modelnos = "";
		        	var rList_length = rList.length;
		        	var rlist_tmpl = "";
		        	
		        	if(rList_length > 0){
		        		for(var k=0; k<rList_length-1; k++){
			        		r_modelnos += rList[k].R_MODELNO + ",";
			        	}
			        	r_modelnos += rList[rList_length-1].R_MODELNO;
			        	$.ajax({
			    	    	type: "GET",
			    	        url: "/mobilefirst/evt/ajax/getGoodsList.jsp",
			    	        data: "modelnos="+r_modelnos,
			    	        dataType: "JSON",
			    	        success: function(result){
			    	        	for(var i=0; i<rList.length; i++){
			    	        		var goodsData = result.goodsList[i];
			    	        		//api에 있으면 상품 그려주기 시작
			    	        		if(goodsData){
			    	        			rlist_tmpl +="<li data-modelno='"+goodsData.modelno+"'>";
			    	        			rlist_tmpl +="<a>";
			    	        			rlist_tmpl +="<div class=\"box\">";
			    	        			rlist_tmpl +="<span class=\"arrow_top\">"+rList[i].R_TXT+"</span>";
			    	        			rlist_tmpl +="<img src=\""+goodsData.imgUrl+" \" alt=\"\" />";
			    	        			rlist_tmpl +="</div>";
			    	        			rlist_tmpl +="<div class=\"btminfo\">";
			    	        			rlist_tmpl +="<span class=\"proname\">"+goodsData.modelnm+"</span>";
			    	        			rlist_tmpl +="<span class=\"value\">";
			    	        			rlist_tmpl +="<span class=\"star_graph ico_m\"><span class=\"ico_m\" id=\"review_status_width\" style=\"width:"+goodsData.bbs_point_avg * 20+"%>">별점</span></span>";
			    	        			rlist_tmpl +="<span class=\"price\"><b>"+commaNum(goodsData.minprice3)+"</b>원</span>";
			    	        			rlist_tmpl +="</span>";
			    	        			rlist_tmpl +="</div>";
			    	        			rlist_tmpl +="</a>";
			    	        			rlist_tmpl +="</li>";
			    	        		}
			    	        	}
			    	        	$("#recommend_div").show();
			    	        	$("#cm_recommend").html(rlist_tmpl);
			    	        },complete:function(e){
			    	        	//추천상품 이미지 클릭
			    	            $("body").on('click', '#cm_recommend > li', function(event) {
			    	            	//alert();
			    	            	dealGA("추천상품");
			    	            	adClickGa();
			    	        		var modelno = $(this).attr("data-modelno");
			    	        		if(getCookie("appYN")=='Y'){
			    	        			location.href= "/mobilefirst/detail.jsp?modelno="+modelno+"&freetoken=vip";	
			    	        		}else{
			    	        			window.open("/mobilefirst/detail.jsp?modelno="+modelno, '_blank'); 
			    	        		}
			    	            });
			    	        }
			        	});
		        	}
	        	}catch(e){}
	        	finally {
	        		//플리킹영역(이딜 상품)
		        	var thumb_target = $(".innder_scroll .swiper-wrapper").find("li");
		        	//슬릭 활성화
		        	$('.deal_goods').slick({
		        		dots: false,
		        		arrows: false,
		        		infinite: true,
		        		speed: 300,
		        		slidesToShow: 1,
		        		adaptiveHeight: true,
		        		autoplay: false,
		        		autoplaySpeed: 3000
		        	});
		        	//첫번째 상품 선택
		        	setFirstDealGoods(frontIdx);
		        	//상품 swipe
		        	$('.deal_goods').on('swipe', function(event, slick, direction) {
		        		
		                var currentIndex = $('.deal_goods').slick("slickCurrentSlide");//슬릭의 현재슬라이드값
		                var prevIndex;
		                if(direction=="left"){
		                	prevIndex=currentIndex-1;
		                }else if(direction=="right"){
		                	prevIndex=currentIndex+1;
		                }
		                resetRolling(prevIndex,currentIndex);
		                //하단 이미지 따라오기
		                var position =  thumb_target.eq(currentIndex).offset(); // 하단의 위치값
		                thumb_target.removeClass("on");
		                thumb_target.eq(currentIndex).addClass("on");
		                var point = 125*currentIndex;
		                $('.innder_scroll').animate({ scrollLeft : point }, 800); // 이동
		                	
		                /* viewDate($("#deal_s_goods li").eq(currentIndex).attr("data-stselldate"), $("#deal_s_goods li").eq(currentIndex).attr("data-goodstype")); */
		            });
		        	//thmb 이미지 클릭
		            $("body").on('click', '.innder_scroll .swiper-wrapper > li', function(e) {
						var _this = $(this);
						var index = _this.index();
		            	dealGA("상품리스트");
		            	adClickGa();
		            	
		            	resetRolling(thumbIndex,index);
		            	thumbIndex= index;
		            	$('.deal_goods').slick('slickGoTo',index, true);
		            	thumb_target.removeClass("on");
		            	thumb_target.eq(index).addClass("on");
		            	
		            	viewDate(_this.attr("data-stselldate"),_this.attr("data-goodstype"));
		            });
		        	
		        	//판매중인 상품 있을시 클릭이벤트 활성화
		        	if(todayDeal.SEQ != ""){
		        		var todaySeq = todayDeal.SEQ;
						$("#buybtn_"+todaySeq).click(function(e){
							dealGA('구매하기');
							var _this = $(this);
							
							var dataType = _this.attr("data-type");
							var eventno = _this.attr("data-no");
							var aplDate = _this.attr("data-apl-dt");
							
							if(!islogin()){
								alert("로그인 후 구매하실 수 있습니다.");
								goLogin();
								return false;
							}
							
							if("Y" == "<%=snsUserYN%>"){
								
								var goUrl = "/member/ajax/getMemberCetify.jsp";
								$.getJSON(goUrl,function(data){
									
									if(!data.certify){
										
        								var r = confirm("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?");
        								if(r){
        									location.href = "/mobilefirst/member/myAuth.jsp?cmdType=&f=m";
        									return false;
        								}
	    								
									}else{
										
										if("2" == dataType){
											if(eventno){//타임이벤트 일경우
												goLuckyTime(todaySeq);	
											}
										}else{
											if(getCookie("appYN") != "Y" && aplDate != "" && typeof aplDate != "undefined"){
												alert("모바일 앱에서만 구매 가능합니다!")
												return false;
											} 
											goDealShop('',todayDeal.GOODS_COMPANY,todaySeq);	
										}
										
									}
								});
							}else{
								
								if("2" == dataType){
									if(eventno){//타임이벤트 일경우
										goLuckyTime(todaySeq);	
									}
								}else{
									if(getCookie("appYN") != "Y" && aplDate != "" && typeof aplDate != "undefined"){
										alert("모바일 앱에서만 구매 가능합니다!")
										return false;
									} 
									goDealShop('',todayDeal.GOODS_COMPANY,todaySeq);	
								}
								
							}
							
						});						
		        	}
	        	}
	        }
		});
	}
	function setFirstDealGoods(frontIdx){
		$('.deal_goods').slick('slickGoTo',frontIdx, true);
		//$("#deal_goods li .fader").removeClass("on");
		$("#deal_goods .slick-slide").eq(frontIdx+1).find(".fader").addClass("on");
	
		thumbIndex= frontIdx;
		
		$imgs=$(".fader.on > span > img");
    	startRolling();
    	
    	//하단 이미지 따라오기
    	var thumb_target = $(".innder_scroll .swiper-wrapper").find("li");
        var position =  thumb_target.eq(frontIdx).offset(); // 하단의 위치값
        thumb_target.eq(frontIdx).addClass("on");
        var point = 125*frontIdx;
        $('.innder_scroll').animate({ scrollLeft 
        	: point }, 800); // 이동
	}
	function resetRolling(prevIndex, currentIndex){
		/*
		isChange=true;
		clearInterval(interval);
		
		var faderOut = $("#deal_goods .slick-slide").eq(prevIndex+1);
        faderOn = $("#deal_goods .slick-slide").eq(currentIndex+1);
        
        faderOut.find("img").css("display","none");
        faderOut.find(".thum_first").css("display","block");
        faderOut.find(".fader").removeClass("on");

        $imgs=faderOn.find("img");//롤링되는 이미지
        faderOn.find("img").css("display","none");
        faderOn.find(".thum_first").css("display","block");
        faderOn.find(".fader").addClass("on");
        */
        startRolling();
	}
});

$(window).ready(function(){
	//닫기버튼
	$( ".win_close" ).click(function(){
		if(app == 'Y'){
			window.location.href = "close://";
		}else{
			window.location.replace("/mobilefirst/index.jsp");
		}
	});
	
	//ga (ios/aos 구분)
	var mType = "";
	if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
		mType = "I";
	}else if(navigator.userAgent.indexOf("Android") > -1){
		mType = "A";
	}
 	if(mType=="I"){
		ga('send', 'pageview', {'page': vEvent_page,'title': '[모바일] '+vEvent_title+' PV(IOS)'});
 	}else if(mType=="A"){
		ga('send', 'pageview', {'page': vEvent_page,'title': '[모바일] '+vEvent_title+' PV(AOS)'});
 	}
 	
 	if("<%=flow%>" == "share") {
 		dealGA("크레이지딜 외부유입");
 	}
 	if("<%=flow%>" == "sfb")				dealGA("이벤트액션: 크레이지딜 페이스북");
	else if("<%=flow%>" == "sad")			dealGA("이벤트액션: 크레이지딜 검색광고");
	else if("<%=flow%>" == "sap")			dealGA("이벤트액션: 크레이지딜 앱설치");
 	
	//탭 클릭
    $("body").on('click', '.tabmenu > li > a ', function(e) {
    	e.preventDefault();
    	var $anchor = $(this);
        var viewIndex = $anchor.parent().index();
        var depth = 0;
        dealGA('상단 탭');
        if(viewIndex==0){
        	depth=120;
        }else{
        	depth=68;
        }
        $('html, body').stop().animate({
            scrollTop: $($anchor.attr('href')).offset().top - depth
        }, 500);
   	});
	 //스크롤 2017-11-30 수정
	var nav = $('.myarea');
	$(window).scroll(function () {
		//상단탭메뉴 픽스조절
		if ($(this).scrollTop() > 80) {
			nav.addClass("f-nav");
		} else {
			nav.removeClass("f-nav");
		};
	
		//상단탭메뉴 활성화
		var tabareaH = $(".tab_area").outerHeight();
	
		/* if ($(this).scrollTop() <= $("#con2").offset().top - tabareaH){
			$(".tabmenu .tab1").addClass("on").siblings().removeClass("on");
		}else if ($(this).scrollTop() > $("#con2").offset().top - tabareaH){
			$(".tabmenu .tab2").addClass("on").siblings().removeClass("on");
		}
	 */
	});
	//유의사항
	$('.crz_deal .btn_check').click(function(){
		if($(this).hasClass("more_on")) 	$(this).removeClass("more_on");
		else 								$(this).addClass("more_on");
		
		$('.crz_deal .moreview').toggle();

		if($('.crz_deal .moreview').is(':visible')) $(this).val('Hide');
		else 										$(this).val('Show');
		
	});
	//유의사항2 (이벤트)
	$('.vote .btn_check').click(function(){
		if ($(this).hasClass("more_on")) {
			$(this).removeClass("more_on");
		} else {
			$(this).addClass("more_on");
		};
		$('.vote .moreview').toggle();
		 if($('.vote .moreview').is(':visible')) {
			$(this).val('Hide');
		} else {
			$(this).val('Show');
		};
	});
	//top 버튼
	$(".go_top").click(function(){
		$(window).scrollTop(0);
	});
	
});
function startRolling(){
	var i=1;
    interval = setInterval(function(e){
  		if($imgs.length > 1){
			var next = (i % $imgs.length);
  	    	$($imgs.get(next - 1)).fadeOut(500,function(){
				if(isChange){
				}else{
					$($imgs.get(next)).fadeIn(500).css('display','block');
  				}
  				isChange=false;
  			});
	    	isChange=false;  
	    	/* $($imgs.get(next - 1)).fadeOut(500);
	    	$($imgs.get(next)).fadeIn(500).css("display","block");  */
			//$($imgs.get(next - 1)).fadeOut(1000).next().fadeIn(1000).css('display','block').end();
 			i++;
   		}
	}, 2000);
}
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
			$(".layer_back").height($(document).height()).css("position","absolute");
			mid.find(".noteLayer,.appLayer").css({
				"top":$(document).scrollTop() + 10,
				"margin":"0px 0px 0px -150px"
			});
		}else{
			$(".layer_back").css({
				"position":"fixed",
				"height":"100%"
			});
		}
	}
}

function goLuckyTime(seq){
	var goUrl = "/mobilefirst/evt/ajax/setDealTime.jsp?seq="+seq;
	
	$.getJSON(goUrl,function(data){
		if(data.result == 0){
			alert("품절입니다.");
			location.reload();
		}else if(data.result == 1){
			alert("축하합니다!\n앱에서 e쿠폰으로 교환 할 수 있는\ne머니가 적립되었습니다."); //문구 수정요청
		}else if(data.result == 2){
			alert("이미 참여 하셨습니다.");
		}else if(data.result == 4){
			alert("로그인 후 구매하실 수 있습니다.");
			goLogin();
		}else if(data.result == 99){
			alert("임직원은 참여가 불가합니다.");
		}else{
			alert("새로고침 하시고 다시 구매하기 눌러주세요");
		}
		return false;
	});
}

function event_share(part) {
	var shareUrl = "http://" + location.host + "/mobilefirst/evt/mobile_deal.jsp";
	if(part == 'kakao') {
		
		dealGA('SNS 공유 > 카카오톡');
		try{
			Kakao.Link.createDefaultButton({
				container: '#kakao-link-btn',
				objectType: 'feed',
				content: {
					title: '<%=strFb_title%>',
			        description: '<%=strFb_description%>',
			        imageUrl: "<%=strFb_img%>",
					link: {
						mobileWebUrl: shareUrl,
						webUrl: shareUrl
					}
				},
				buttons: [
				{
					title: '크레이지딜',
					link: {
						mobileWebUrl: shareUrl,
						webUrl: shareUrl
					}
				}
				]
			});
		}catch(e){
			//alert("카카오 톡이 설치 되지 않았습니다.");
			alert(e.message);
		}
	} else if (part == 'face') {
		dealGA('SNS 공유 > 페이스북');
		window.open("http://www.facebook.com/sharer.php?u=" + shareUrl);
	}
}

function viewDate(sellDate,goodsUrlType){
	
	var month = "<%=Integer.parseInt(sdt.substring(4,6))%>";
	var day = "<%=Integer.parseInt(sdt.substring(6,8))%>";

	try{
		month = parseInt(sellDate.substring(4,6));
		day = parseInt(sellDate.substring(6,8));
	}catch(ex){}
	$("#deal_title").html(month + "월 "+day + "일 <b>CRAZY</b> 최저가");
}
function dealGA(label){
	ga('send', 'event', 'mf_event', '통합딜',label);		
}
function goUrl(url){
	if(url!=""){
		location.href= url;
		return false;
	}
}
function imgClick(url){
	if(url!=""){
		dealGA('컨텐츠이미지');
		location.href=url;
		return false;
	}
}
function goVip(modelno,goodsTitle){
	dealGA('상품상세보기_'+goodsTitle);
	adClickGa();
	
	if(modelno=='0'){
		alert("최저가 상품이 없습니다!");
		return false;
	}
	window.open("/mobilefirst/detail.jsp?modelno="+modelno+"&freetoken=vip&tab=2", '_blank'); 
}
function adClickGa(){
	if("<%=flow%>" == "sfb")				dealGA("이벤트액션: 페이스북_유입클릭");
	else if("<%=flow%>" == "sap")			dealGA("이벤트액션: 앱설치_유입클릭");
	else if("<%=flow%>" == "sad")			dealGA("이벤트액션: 검색광고_유입클릭");
}
function goCrazyFriday(){
	location.href = "/mobilefirst/evt/crazy_Friday.jsp";
}

function welcomeGa(strEvent){
	if(app == "Y"){
		try{
	        if(window.android){            // 안드로이드                  
                 window.android.igaworksEventForApp (strEvent);
	        }else if(/iPhone|iPad|iPod/i.test(navigator.userAgent)){
        		// 아이폰에서 호출
                 location.href = "enuriappcall://igaworksEventForApp?strEvent="+strEvent;
	        }
		}catch(e){}
	}
}
setTimeout(function(){
	welcomeGa("evt_crazydeal_view");    
},500);
CmdShare();
function CmdShare(){
	Kakao.Link.createDefaultButton({
		  container: '#kakao-link-btn',
	      objectType: 'feed',
	      content: {
			title: '<%=strFb_title%>',
	        description: '<%=strFb_description%>',
	        imageUrl: "<%=strFb_img%>",
	        imageWidth: 380,
	        imageHeight: 198,
	        link: {
	          webUrl: shareUrl,
	          mobileWebUrl: shareUrl
	        }
	      },
		buttons: [{
	          title: '크레이지딜',
	          link: {
	            mobileWebUrl: shareUrl,
	            webUrl: shareUrl
	          }
		}]
    });
}
</script>
<script language="JavaScript" src="<%=ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
</html>
