<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@ page import="com.enuri.util.common.ConfigManager"%>
<%
if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){
}else{
    response.sendRedirect("http://www.enuri.com/event2021/newyear_2021.jsp"); //PC경로
    return;
}
SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMddHHmm");  //오늘 날짜
String strToday = formatter.format(new Date());
String chkId   = ChkNull.chkStr(request.getParameter("chk_id"),"");
String userId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"),"");
String userNick = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_NICK"),"");
Members_Proc members_proc = new Members_Proc();
String userName = members_proc.getUserName(userId);
String userArea = userName;
String strUrl = request.getRequestURI();
if(!userId.equals("")){
    userName = members_proc.getUserName(userId);
    userArea = userName;
    if(userName.equals("")){
        userArea = userNick;
    }
    if(userArea.equals("")){
        userArea = userId;
    }
}
String tab = ChkNull.chkStr(request.getParameter("tab"));
String protab = ChkNull.chkStr(request.getParameter("protab"));
%>
<!DOCTYPE html> 
<html lang="ko">
<head>
<meta charset="utf-8">	
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />	
<meta name="keyword" content="에누리가격비교, 통합기획전, 설날, 새해, 명절선물, 신축년">
<meta property="og:title" content="2021 설날 통합기획전 – 최저가 쇼핑은 에누리">
<meta property="og:description" content="100% 당첨 설~프라이즈 이벤트를 만나보세요!">
<meta property="og:image" content="http://imgenuri.enuri.gscdn.com/images/mobilenew/images/logo_enuri.png">
<meta name="format-detection" content="telephone=no" />
<!-- 프로모션 공통 CSS (Mobile) -->
<link rel="stylesheet" href="/css/event/com.enuri.event.m.css" type="text/css">
<!-- 프로모션별 커스텀 CSS  -->
<link rel="stylesheet" href="/css/event/y2021/newyear_m.css" type="text/css">
<link rel="stylesheet" type="text/css" href="http://m.enuri.com/mobilefirst/css/lib/slick.css"/>
<script type="text/javascript" src="http://m.enuri.com/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="http://m.enuri.com/mobilefirst/js/lib/slick.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/ga.js"></script>
<script type="text/javascript" src="/event2016/js/event_common.js"></script>
<title>에누리 가격비교 - 최저가 쇼핑은 에누리 가격비교 사이트</title>
<script>
    var userId = "<%=userId%>";
    var tab = "<%=tab%>"; //파라미터 tab
    var username = "<%=userArea%>"; //개인화영역 이름
    var vChkId = "<%=chkId%>";
    var vEvent_page = "<%=strUrl%>"; //경로
    var ssl = "<%=ConfigManager.ENURI_COM_SSL%>";
</script>
</head>
<body>
<div id="eventWrap">
<%@include file="/mobilefirst/event2021/newyear_header.jsp" %>
	<!-- T3 이벤트 : 추천 상품 영역 -->
	<div class="section pro_itemlist" id="evt1">
		<h1>인기 설 선물세트부터 온 가족을 위한 새해 연휴준비! 설날을 더욱 행복하게 할 쇼핑 가이드</h1>
		
		<!-- BEST 설날선물 -->
		<div id="prodGroup01" class="item_group item_group_01 scroll">
			<h3>
				<span class="txt_sub">마음을 전하기 딱 좋은</span>
				<strong class="txt_tit">BEST 설날선물</strong>
			</h3>
			<!-- 탭 -->
			<ul class="pro_tabs">
				<li class="active" ><a href="#protab1-1">축산/신선식품</a></li>
				<li><a href="#protab1-2">건강식품</a></li>
				<li><a href="#protab1-3">효도가전</a></li>
				<li><a href="#protab1-4">상품권</a></li>
			</ul>
			<!-- //탭 -->
			

			<!-- 템플릿 -->
			<div class="tab_container">
				<!-- 
					SLICK $(".itemlist")
					3개의 탭 콘텐츠가 있습니다. "tab_content"
					하나의 콘텐츠마다 ul 단위로 한 판(상품6개)씩 움직입니다. 				
				-->
				<!-- 축산/신선식품 상품-->
				<div id="protab1-1" class="tab_content">
					<div class="itemlist">
					<!--  -->
						<ul class="items clearfix">
						</ul>
						<ul class="items clearfix" >
						</ul>
						<ul class="items clearfix">
						</ul>
					</div>
					<a class="sprite btn_more" href="http://m.enuri.com/m/list.jsp?cate=150315" target="_blank">상품더보기</a>
				</div>
				<!-- //축산/신선식품 상품-->
				
				<!-- 건강식품 상품-->
				<div id="protab1-2" class="tab_content">
					<div class="itemlist">
						<ul class="items clearfix" >
						</ul>
						<ul class="items clearfix">
						</ul>
					</div>
					<a class="sprite btn_more" href="http://m.enuri.com/m/list.jsp?cate=1501" target="_blank">상품더보기</a>
				</div>
				<!-- //건강식품 상품-->
				
				<!-- 효도가전 상품 -->
				<div id="protab1-3" class="tab_content">
					<div class="itemlist" >
						<ul class="items clearfix">
						</ul>
						<ul class="items clearfix">
						</ul>
						<ul class="items clearfix">
						</ul>
					</div>
					<a class="sprite btn_more" href="http://m.enuri.com/m/list.jsp?cate=15020323" target="_blank">상품더보기</a>
				</div>
				<!-- //효도가전 상품 -->

				<!-- 상품권 상품 -->
				<div id="protab1-4" class="tab_content">
					<div class="itemlist">
						<ul class="items clearfix">
						</ul>
						<ul class="items clearfix">
						</ul>
						<ul class="items clearfix">
						</ul>
					</div>
					<a class="sprite btn_more" href="http://m.enuri.com/m/list.jsp?cate=164715" target="_blank">상품더보기</a>
				</div>
				<!-- //상품권 상품 -->
			</div>
			<!-- //템플릿 -->									
		</div>
		<!-- //BEST 설날선물 -->

		<!-- 가격대별 선물세트 -->
		<div id="prodGroup02" class="item_group item_group_02 scroll">
			<h3>
				<span class="txt_sub">예산에 맞게 전하는 진심</span>
				<strong class="txt_tit">가격대별 선물세트</strong>
			</h3>
			<!-- 탭 -->
			<ul class="pro_tabs">
				<li class="active"><a href="#protab2-1">1만원~3만원</a></li>
				<li><a href="#protab2-2">3만원~5만원</a></li>
				<li><a href="#protab2-3">5만원~10만원</a></li>
				<li><a href="#protab2-4">10만원 이상</a></li>
			</ul>
			<!-- //탭 -->

			<!-- 템플릿 -->
			<div class="tab_container">
				<!-- 1만원~3만원 상품 -->
				<div id="protab2-1" class="tab_content">
					<div class="itemlist">
						<ul class="items clearfix">
						</ul>
						<ul class="items clearfix">
						</ul>
						<ul class="items clearfix">
						</ul>
					</div>
					<a class="sprite btn_more" href="http://m.enuri.com/m/list.jsp?cate=151110" target="_blank">상품더보기</a>
				</div>
				<!-- //1만원~3만원 상품 -->
				
				<!-- 3만원~5만원 상품 -->
				<div id="protab2-2" class="tab_content">
					<div class="itemlist">
						<ul class="items clearfix" >
						</ul>
						<ul class="items clearfix">
						</ul>
					</div>
					<a class="sprite btn_more" href="http://m.enuri.com/m/list.jsp?cate=15080801" target="_blank">상품더보기</a>
				</div>
				<!-- //3만원~5만원 상품 -->
				
				<!-- 5만원~10만원 상품 -->
				<div id="protab2-3" class="tab_content">
					<div class="itemlist">
						<ul class="items clearfix">
						</ul>
						<ul class="items clearfix">
						</ul>
						<ul class="items clearfix">
						</ul>
					</div>
					<a class="sprite btn_more" href="http://m.enuri.com/m/list.jsp?cate=080106" target="_blank">상품더보기</a>
				</div>
				<!-- //5만원~10만원 상품 -->
				
				<!-- 10만원 이상 상품 -->
				<div id="protab2-4" class="tab_content" >
					<div class="itemlist" role="toolbar">
						<ul class="items clearfix">
						</ul>
						<ul class="items clearfix">
						</ul>
						<ul class="items clearfix">
						</ul>
					</div>
					<a class="sprite btn_more" href="http://m.enuri.com/m/list.jsp?cate=150315" target="_blank">상품더보기</a>
				</div>
				<!-- //10만원 이상 상품 -->		
			</div>
			<!-- //템플릿 -->			
		</div>
		<!-- //가격대별 선물세트 -->	

		<!-- 즐거운 귀성준비 -->
		<div id="prodGroup03" class="item_group item_group_03 scroll">
			<h3>
				<span class="txt_sub">우리우리 설날은 오늘이지요~</span>
				<strong class="txt_tit">즐거운 귀성준비</strong>
			</h3>
			<!-- 탭 -->
			<ul class="pro_tabs">
				<li class="active"><a href="#protab3-1">귀성길</a></li>
				<li><a href="#protab3-2">돈봉투</a></li>
				<li><a href="#protab3-3">보드게임</a></li>
				<li><a href="#protab3-4">유아한복</a></li>
			</ul>
			<!-- //탭 -->

			<!-- 템플릿 -->
			<div class="tab_container">
				<!-- 귀성길 상품 -->
				<div id="protab3-1" class="tab_content">
					<div class="itemlist">
						<ul class="items clearfix" >
						</ul>
						<ul class="items clearfix">
						</ul>
						<ul class="items clearfix" >
						</ul>
					</div>
					<a class="sprite btn_more" href="http://m.enuri.com/m/list.jsp?cate=211417" target="_blank">상품더보기</a>
				</div>
				<!-- //귀성길 상품 -->
				
				<!-- 돈봉투 상품 -->
				<div id="protab3-2" class="tab_content">
					<div class="itemlist">
						<ul class="items clearfix">
						</ul>
						<ul class="items clearfix">
						</ul>
					</div>
					<a class="sprite btn_more" href="http://m.enuri.com/m/list.jsp?cate=18020309" target="_blank">상품더보기</a>
				</div>
				<!-- //돈봉투 상품 -->
				
				<!-- 보드게임 상품 -->
				<div id="protab3-3" class="tab_content">
					<div class="itemlist" >
						<ul class="items clearfix">
						</ul>
						<ul class="items clearfix">
						</ul>
						<ul class="items clearfix">
						</ul>
					</div>
					<a class="sprite btn_more" href="http://m.enuri.com/m/list.jsp?cate=164404" target="_blank">상품더보기</a>
				</div>
				<!-- //보드게임 상품 -->
				
				<!-- 유아한복 상품 -->
				<div id="protab3-4" class="tab_content">
					<div class="itemlist" >
						<ul class="items clearfix">
						</ul>
						<ul class="items clearfix">
						</ul>
						<ul class="items clearfix">
						</ul>
					</div>
					<a class="sprite btn_more" href="http://m.enuri.com/m/list.jsp?cate=101508" target="_blank">상품더보기</a>
				</div>
				<!-- //유아한복 상품 -->		
			</div>
			<!-- //템플릿 -->			
		</div>
		<!-- //즐거운 귀성준비 -->	

		<!-- 알찬 설날 연휴준비 -->
		<div id="prodGroup04" class="item_group item_group_04 scroll">
			<h3>
				<span class="txt_sub">1인 가구를 위한</span>
				<strong class="txt_tit">알찬 설날 연휴준비</strong>
			</h3>
			<!-- 탭 -->
			<ul class="pro_tabs">
				<li class="active"><a href="#protab4-1">게임기</a></li>
				<li><a href="#protab4-2">간편가정식</a></li>
				<li><a href="#protab4-3">E쿠폰</a></li>
				<li><a href="#protab4-4">댕냥이한복</a></li>
			</ul>
			<!-- //탭 -->

			<!-- 템플릿 -->
			<div class="tab_container">
				<!-- 게임기 상품 -->
				<div id="protab4-1" class="tab_content">
					<div class="itemlist">
						<ul class="items clearfix">
						</ul>
						<ul class="items clearfix">
						</ul>
						<ul class="items clearfix">
						</ul>
					</div>
					<a class="sprite btn_more" href="http://m.enuri.com/m/list.jsp?cate=0408" target="_blank">상품더보기</a>
				</div>
				<!-- //게임기 상품 -->
				
				<!-- 간편가정식 상품 -->
				<div id="protab4-2" class="tab_content">
					<div class="itemlist">
						<ul class="items clearfix">
						</ul>
						<ul class="items clearfix">
						</ul>
					</div>
					<a class="sprite btn_more" href="http://m.enuri.com/m/list.jsp?cate=151112&parent=11511" target="_blank">상품더보기</a>
				</div>
				<!-- //간편가정식 상품 -->
				
				<!-- E쿠폰 상품 -->
				<div id="protab4-3" class="tab_content">
					<div class="itemlist">
						<ul class="items clearfix">
						</ul>
						<ul class="items clearfix" >
						</ul>
						<ul class="items clearfix">
						</ul>
					</div>
					<a class="sprite btn_more" href="http://m.enuri.com/m/list.jsp?cate=164721" target="_blank">상품더보기</a>
				</div>
				<!-- //E쿠폰 상품 -->
				
				<!-- 댕냥이한복 상품 -->
				<div id="protab4-4" class="tab_content">
					<div class="itemlist">
						<ul class="items clearfix">
						</ul>
						<ul class="items clearfix" >
						</ul>
						<ul class="items clearfix" >
						</ul>
					</div>
					<a class="sprite btn_more" href="http://m.enuri.com/m/list.jsp?cate=16420803" target="_blank">상품더보기</a>
				</div>
			</div>
				<!-- //댕냥이한복 상품 -->			
		</div>
			<!-- //템플릿 -->			
		</div>
		<!-- //알찬 설날 연휴준비 -->
	</div>
	<!-- // -->

	<!-- 에누리 기획전 -->
	<div class="enuriexhibition">
        <div class="inner">
            <h3>에누리 기획전</h3>
            <ul class="exb_list">
                <li><a href="http://m.enuri.com/m/planlist.jsp?t=B_20211123212121" target="_blank">명절 선물 비대면으로 준비하세요~!</a></li>
                <li><a href="http://m.enuri.com/m/planlist.jsp?t=B_20221223212121" target="_blank">설 아이선물 안전하게 주고받으세요</a></li>
                <li><a href="http://m.enuri.com/m/planlist.jsp?t=B_20210101040102" target="_blank">추울땐 집콕! 집콕할 땐 PC!</a></li>
                <li><a href="http://m.enuri.com/m/planlist.jsp?t=B_20201116144444" target="_blank">이어폰 or 헤드셋, 당신의 선택은?</a></li>
                <li><a href="http://m.enuri.com/m/planlist.jsp?t=B_20210113115830" target="_blank">설 명절 제수용품 준비하자!</a></li>
                <li><a href="http://m.enuri.com/m/planlist.jsp?t=B_20210108042410" target="_blank">신축년 화장품 설 선물 기획전</a></li>
                <li><a href="http://m.enuri.com/m/planlist.jsp?t=B_20210115140433" target="_blank">설특집주방가전BEST</a></li>
            </ul>
        </div>
	</div>
	<!-- // -->	

	<!-- 공통 : 하단 에누리 혜택 -->
	<div class="otherbene">
        <div class="inner">
            <h3 class="blind">놓칠 수  없는 특별한 혜택, 에누리 혜택</h3>
            <ul class="ben_list">
                <li class="ben_item--01"><a href="http://www.enuri.com/event2019/first_purchase_2019_evt.jsp?tab=evt1" target="_blank">첫구매 고객이라면! Welcome 혜택</a></li>
                <li class="ben_item--02"><a href="http://www.enuri.com/evt/visit.jsp" target="_blank">하루라도 농치면 손해 매일100% 당첨</a></li>
                <li class="ben_item--03"><a href="http://m.enuri.com/mobilefirst/evt/smart_benefits.jsp?#tab4" target="_blank">받고 또 받는 카테고리 혜택 최대적립 3만점</a></li>
                <li class="ben_item--04"><a href="http://www.enuri.com/eventPlanZone/jsp/shoppingBenefit.jsp" target="_blank">아직 끝나지 않은 혜택 더 많은 이벤트</a></li>
            </ul>
        </div>
	</div>
	<!-- // -->	
	
	<!-- //Contents -->	

	<!-- <span class="go_top"><a href="#">TOP</a></span> -->
</div>
<!-- // 프로모션 -->

<!-- LAYER WRAP -->
<div class="layerwrap">
	<!-- 공통 : SNS공유하기 -->
	<!-- // -->	

	<!-- 딤레이어 : 모바일 앱 전용 이벤트 -->
	<div id="onlyApp1" class="pop-layer" style="display:none;">
		<div class="popupLayer">
			<div class="dim"></div>
		</div>
		<!-- popup_box -->
		<div class="popup_box onlyapp">
			<h4>모바일 앱 전용 이벤트</h4>
			<div class="inner">
				<p class="exp">모바일 앱에서 참여해주세요</p>
				<p class="tit">앱 다운로드 SMS 보내기</p>
				<p class="input_area">
					<input type="text" name="" id="" maxlength="11" onfocus="this.value='';" value="휴대폰 번호 입력">
					<a class="btn laysend" href="javascript:void(0);" onclick="onoff('onlyApp1');return false"><em>문자발송</em></a>
				</p>
				<ul class="watchout">
					<li>문자 발송은 무료이며, 입력하신 번호는 저장되지 않습니다.</li>
				</ul>
			</div>
			<a class="btn layclose" href="javascript:void(0);" onclick="onoff('onlyApp1');return false"><em>팝업 닫기</em></a>
		</div>
		<!-- //popup_box -->
	</div>
	<!-- //딤레이어 : 모바일 앱 전용 이벤트 -->

	<!-- 딤레이어 : 모바일 앱 전용 쇼핑 혜택 -->
	<div id="onlyApp2" class="pop-layer" style="display:none;">
		<div class="popupLayer">
			<div class="dim"></div>
		</div>
		<!-- popup_box -->
		<div class="popup_box onlyapp">
			<h4>모바일 앱 전용 쇼핑 혜택</h4>
			<div class="inner">
				<p class="exp">에누리 앱(App)에서<br>e머니를 다양한 e쿠폰 상품으로 교환하세요!</p>
				<p class="tit">앱 다운로드 SMS 보내기</p>
				<p class="input_area">
					<input type="text" name="" id="" maxlength="11" onfocus="this.value='';" value="휴대폰 번호 입력">
					<a class="btn laysend" href="javascript:void(0);" onclick="onoff('onlyApp');return false"><em>문자발송</em></a>
				</p>
				<ul class="watchout">
					<li>문자 발송은 무료이며, 입력하신 번호는 저장되지 않습니다.</li>
				</ul>
			</div>
			<a class="btn layclose" href="javascript:void(0);" onclick="onoff('onlyApp2');return false"><em>팝업 닫기</em></a>
		</div>
		<!-- //popup_box -->
	</div>
	<!-- //딤레이어 : 모바일 앱 전용 쇼핑 혜택 -->
</div>
<!-- // -->
<%@ include file="/mobilefirst/event2016/event_footer.jsp"%>
<script type="text/javascript" src="/js/clipboard.min.js"></script>
<script type="text/javascript" src="<%= ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
<script type="text/javascript">
var cnt = 0;
var $navHgt = 0;
var app = getCookie("appYN"); //app인지 여부
var makeHtml = "";
var vOs_type = getOsType();

//탭별 ga로그
function tabLog(evt,no){
	var index = 0;
	$(evt + ' .pro_tabs li a').click(function(){
		index = $(this).parents().index() + no;
		ga_log(index);
	});
}

//더보기 ga로그
function moreViewLog(evt,no){
	$(evt + ' .tab_container .btn_more').click(function(){
		ga_log(no);
	});
}

var isClick = true;
var sdt = "<%=strToday.substring(0,8) %>";

$(document).ready(function() {
	var oc = '<%=oc%>';
	var tablo = '<%=tab%>';

	// 에누리 기획전 브릿지 ga로그(new)
	$(".exb_list a").click(function(){
		ga_log(35);
	});

	$(".ben_item--04").click(function(){
		var url = (app != "Y" ? "/mobilefirst/index.jsp#evt" : "/mobilefirst/renew/plan.jsp?freetoken=main_tab|event");
		window.open(url);
	});

	//상품 영역
	var loadUrl = "/event/ajax/exhibition_ajax.jsp?exh_id=42";

	$.ajax({
		  dataType : "json"
		, url	   : loadUrl
		, cache : false
		, success  : function(result){
			var banner = result.R;
			var tab = result.T;
			var tabSize = 4; //컨텐츠 별 탭 개수
			var listSize = 4; //노출 상품 개수
			var logNo = [15,21,27,33];
			var no = 0;
			var minprice = 0;

			for(var idx = 0; idx < tab.length; idx ++){
				makeHtml = "";
				no = logNo[parseInt(idx/tabSize)];
				$.each(tab[idx].GOODS, function(i,v){
					minprice = (v.MINPRICE == null) ? 0 : v.MINPRICE;

					if((i % listSize) == 0)	makeHtml += "<ul class='items clearfix'>";
					makeHtml += "<li class='item'>";
					makeHtml +=	"	<a href='javascript:void(0);' onclick='itemClick("+v.MODELNO+", "+minprice+"); ga_log("+no+")'>";
					makeHtml +=	"		<span class='thumb'>";
					makeHtml += "			<img src='"+v.GOODS_IMG+"' alt='상품이미지' onerror = 'replaceImg(this);'>";
					if(minprice == 0 || minprice == null) makeHtml += "<span class='soldout'>soldout</span> <!-- 품절시 노출 -->";
					makeHtml +=	"		</span>";
					makeHtml +=	"		<span class='pro_info'>";
					makeHtml +=	"			<span class='pro_name'>"+v.TITLE1+"<br>"+v.TITLE2+"</span>";
					makeHtml +=	"			<span class='price'>";
					makeHtml +=	"				<span class='price_label'>최저가</span>";
					makeHtml +=	"				<em>"+commaNum(minprice)+"</em>";
					makeHtml +=	"				<span class='pro_unit'>원</span>";
					makeHtml +=	"			</span>";
					makeHtml +=	"		</span>";
					makeHtml +=	"	</a>";
					makeHtml += "</li>";
					if(i % listSize == (listSize - 1) || i == tab[idx].GOODS.length) makeHtml += "</ul>";
				});
				$('#protab'+ (parseInt((idx / tabSize) + 1)) + '-' + ((idx % tabSize) + 1) +' .itemlist').html(makeHtml);
			}
		}
		, complete : function(){
			$navHgt = Math.ceil($(".floattab__list").height());

			//상품 슬릭
			prodSlick();

			var vThisUrl =location.href;
			if(tablo == '01'){
				$('html, body').stop().animate({scrollTop: Math.ceil($('.item_group_01').offset().top- $(".navtab").outerHeight())}, 0);
			}else if(tablo == '02'){
				$('html, body').stop().animate({scrollTop: Math.ceil($('.item_group_02').offset().top- $(".navtab").outerHeight())}, 0);
			}else if(tablo == '03'){
				$('html, body').stop().animate({scrollTop: Math.ceil($('.item_group_03').offset().top- $(".navtab").outerHeight())}, 0);
			}else if(tablo == '04'){
				$('html, body').stop().animate({scrollTop: Math.ceil($('.item_group_04').offset().top- $(".navtab").outerHeight())}, 0);
			}else if(tablo == '05'){
				$('html, body').stop().animate({scrollTop: Math.ceil($('.item_group_05').offset().top- $(".navtab").outerHeight())}, 0);
			}

		}
	});

	//ga > 탭
	tabLog('#prodGroup01', 11);
	tabLog('#prodGroup02', 17);
	tabLog('#prodGroup03', 23);
	tabLog('#prodGroup04', 29);

	//ga > 더보기
	moreViewLog('#prodGroup01',16);
	moreViewLog('#prodGroup02',22);
	moreViewLog('#prodGroup03',28);
	moreViewLog('#prodGroup04',34);

});

//상품 탭, 슬라이트 관련
function prodSlick(){
	var slickSlide = function(el){
		var $wrap = $(el);
		// 탭초기화
		$wrap.find(".tab_content").hide();
		$wrap.find("ul.pro_tabs li").eq(0).addClass("active").show();
		$wrap.find(".tab_content").eq(0).show();
		// 슬라이드 실행
		var proSlide = $(el + ' .itemlist').slick({
			dots:true,
			slidesToScroll: 1
		});
		// 클릭이벤트
		$wrap.find("ul.pro_tabs li").click(function() {
			if ( !$(this).hasClass("active") ){
				$wrap.find("ul.pro_tabs li").removeClass("active");
				$(this).addClass("active")
				$wrap.find(".tab_content").hide();
				var activeTab = $(this).find("a").attr("href");
				$(activeTab).fadeIn();
				proSlide.slick("setPosition");
			}
			return false;
		});
	}
	// 슬라이드 실행
	var slide1 = new slickSlide('.item_group_01');
	var slide2 = new slickSlide('.item_group_02');
	var slide3 = new slickSlide('.item_group_03');
	var slide4 = new slickSlide('.item_group_04');
	var slide5 = new slickSlide('.item_group_05');

	//상단 탭 이동
	//topTabMove();
}

/* 퍼블테스트 : 레이어 열고 닫기*/
function onoff(id){
	var mid = $("#"+id);
	if(mid.css("display") !== "none"){
		mid.css("display","none");
	}else{
		mid.css("display","");
	}
}
		
function getOsType() {
	var osType = "";
	if (app == 'Y') {
		if (navigator.userAgent.indexOf("Android") > -1)
			osType = "MAA";
		else
			osType = "MAI";
	} else {
		if (navigator.userAgent.indexOf("Android") > -1)
			osType = "MWA";
		else
			osType = "MWI";
	}
	return osType;
}

function view_moapp(){
	var chrome25;
	var kitkatWebview;
	var uagentLow = navigator.userAgent.toLocaleLowerCase();
	var openAt = new Date;
	var goApp = "enuri://freetoken/?url=http%3a%2f%2fm.enuri.com%2fmobilefirst%2fevent2021%2fnewyear_2021.jsp%3ffreetoken%3devent";
	if(navigator.userAgent.indexOf("Android") > -1){ // 안드로이드
		goApp = "enuri://event?eventurl=&eventstartdate=&eventrepeatday=&eventdetailurl=http%3a%2f%2fm.enuri.com%2fmobilefirst%2fevent2021%2fnewyear_2021.jsp%3ffreetoken%3devent";
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
			chrome25 = uagentLow.search("chrome") > -1 && navigator.appVersion.match(/Chrome\/\d+.\d+/)[0].split("/")[1] > 25;
			kitkatWebview = uagentLow.indexOf("naver") != -1 || uagentLow.indexOf("daum") != -1;
			if (chrome25 && !kitkatWebview){
				window.open(goApp);
			} else{
				window.open(goApp);
			}
		}
	}else{
		setTimeout( function() {
			window.open("https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8");
		}, 1000);
		location.href = goApp;
	}
}
</script>
</body>
</html>