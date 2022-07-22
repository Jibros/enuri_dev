<%@page import="com.enuri.bean.knowbox.Knowcom_Event"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%
if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){
}else{
	response.sendRedirect("/knowcom/knowcom_1st_pc.jsp");
	return;
}

String iPage = ChkNull.chkStr(request.getParameter("page"), "1");

String sUserid = cb.GetCookie("MEM_INFO","USER_ID");
String sUsergruop = cb.GetCookie("MEM_INFO", "USER_GROUP");
String sUsernick = cb.GetCookie("MEM_INFO", "USER_NICK");

String strApp = ChkNull.chkStr(request.getParameter("app"), "");	 //앱인지 체크
String os = "";		// PC/MAA,MAI,MWA,MWI
if(strApp.equals("Y")){	//앱일때
	if((ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Linux") >= 0 )){
		//MAA 모바일앱 안드로이드
		os = "MAA";
	}else{
		//MAI 모바일앱 IOS
		os = "MAI";
	}
}else{
	if((ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Linux") >= 0 )){
		// MWA 모바일웹 안드로이드
		os = "MWA";
	}else if(
			(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Mac") >= 0) ||
			(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Mac") >= 0) ||
			(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Mac") >= 0)){
		//MWI 모바일웹 IOS
		os = "MWI";
	}else{
		//PC
		os = "PC";
	}
}

// common.jsp
String sPageType = "main";
String strAgent = "pc_o";

String strFrom = ConfigManager.RequestStr(request, "from", "");
if (strFrom.equals("mo")) {
} else {
	if (ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") >= 0) {
		strAgent = "mobile";
	} else if (ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") >= 0 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") >= 0) {
		strAgent = "mobile";
	}
}

// 임직원여부
Knowcom_Event knowcomEvent = new Knowcom_Event();
boolean isEnuri = knowcomEvent.isEnuri(sUserid);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="utf-8">
	<title>에누리 쇼핑지식 – 모든 쇼핑 정보가 한 곳에!</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
	<meta name="description" content="국내 모든 쇼핑 정보가 모인 커뮤니티로 뉴스, 리뷰, 구매가이드의 정보를 제공합니다.">
	<meta name="keyword" content="에누리, 뉴스, 구매가이드, 리뷰, 에누리TV, 자유게시판, 특가게시판, 유머, 체험단, 쇼핑Q&A">
	<meta property="og:title" content="에누리 가격비교">
	<meta property="og:description" content="에누리 모바일 가격비교">
	<meta property="og:image" content="<%=IMG_ENURI_COM%>/images/mobilenew/images/logo_enuri.png">
	<meta name="format-detection" content="telephone=no" />
	<jsp:include page="/knowcom/include/header.jsp" flush="false">
		<jsp:param name="noRightWing" value="true" />
	</jsp:include>
	<link rel="stylesheet" type="text/css" href="/css/event/y2018/knowcom_1st_m.css?v=20190111"/>
</head>

<body class="mobile">
<%@ include file="/knowcom/include/common.jsp"%>
<!-- 쇼핑지식 1주년 맞이 event_wrap -->
<div class="wrap">
	<!-- Top영역 -->
	<div class="section visual">
		<div class="contents">
			<h1 class="blind">쇼핑지식 돌잔치 개편 1주년 축하이벤트</h1>
			<p class="blind">쇼핑지식이 새롭게 태어난 지 벌써 1년! 첫 돌 축하기념 이벤트에 초대합니다!</p>

			<a href="javascript:///" class="btn__notice" onclick="onoff('notetxt1'); return false;">당첨안내 및 유의사항</a>
		</div>

		<a href="javascript:///" class="win_close">창닫기</a>
	</div>
	<!-- //Top영역 -->

	<!-- 컨텐츠 -->
	<div class="section">
		<div class="contents">
			<!-- 이벤트1 돌잡이타임 -->
			<div class="eventbox event_1st">
				<div class="boxbg_inner">
					<h2 class="tit">이벤트 1 돌잡이 타임 최고의 게시판을 골라라</h2>
					<p class="blind">아래 4개의 게시판을 클릭하여 모두 확인 후 투표 참여 가능!</p>

					<!-- 돌잡이 선택 영역 -->
					<div class="selectboard">
						<span class="sprite absicon selecthand">손가락</span>

						<ul class="selectarea">
							<!-- 선택시, active -->
							<li>
								<a href="/knowcom/news.jsp" target="_blank" title="새 창 열림" class="linkarea">링크영역</a>
								<span>선택영역</span>
							</li>
							<li>
								<a href="/knowcom/guide.jsp" target="_blank" title="새 창 열림" class="linkarea">링크영역</a>
								<span>선택영역</span>
							</li>
							<li>
								<a href="/knowcom/board.jsp?bbsname=nuri" target="_blank" title="새 창 열림" class="linkarea">링크영역</a>
								<span>선택영역</span>
							</li>
							<li>
								<a href="/knowcom/enuritv.jsp?bbsname=enuritv" target="_blank" title="새 창 열림" class="linkarea">링크영역</a>
								<span>선택영역</span>
							</li>
						</ul>

						<a href="javascript:///" class="sprite btn_vote non-click">투표하기</a>

						<script type="text/javascript">
						$(function(){
							// 투표
							var $btns = $(".selectarea li span");
							$btns.click(function(e){
								$btns.parents().removeClass("active");
								$(this).parents().addClass("active");
							})
						})
						</script>
					</div>
					<!-- //돌잡이 선택 영역 -->

					<div class="infobox">
						<dl class="blind">
							<dt>참여방법</dt><dd>게시판 4개를 모두 클릭하여 확인하고 투표하면 참여 완료! 이벤트 종료 후 추첨을 통해 경품 증정</dd>
							<dt>이벤트 기간</dt><dd>2019년 1월 7일 ~ 1월 20일</dd>
							<dt>당첨자 발표</dt><dd>2019년 1월 24일</dd>
							<dt>이벤트 경품</dt><dd>애플 에어팟(제세공과금 별도부과), e머니 500점</dd>
						</dl>
					</div>
				</div>
			</div>
			<!-- //이벤트1 돌잡이타임 -->

			<!-- 이벤트2 성장앨범 감상타임 -->
			<div class="eventbox event_2st">
				<div class="boxbg_inner">
					<h2 class="tit">이벤트 2 성장앨범 감상 타임, 1년 동안 달라진 점은?</h2>
					<p class="blind">쇼핑지식 성장앨범 감상하고 도장받자!</p>

					<!-- 성장앨범 슬라이드 영역 -->
					<div class="album_list">
						<div class="album_item">
							<a href="/knowcom/detail.jsp?bbsname=notice&kbno=683109" target="_blank" title="새 창 열기">
								<img class="thumb" src="<%=IMG_ENURI_COM%>/images/event/2018/knowcom_1st/m_album_item01.jpg" alt="1~2월 활동지수 도입" />
							</a>
						</div>
						<div class="album_item">
							<a href="/knowcom/attend.jsp" target="_blank" title="새 창 열기">
								<img class="thumb" src="<%=IMG_ENURI_COM%>/images/event/2018/knowcom_1st/m_album_item02.jpg" alt="2~4월 출석체크 오픈" />
							</a>
						</div>
						<div class="album_item">
							<a href="/knowcom/news.jsp?cateno=5" target="_blank" title="새 창 열기">
								<img class="thumb" src="<%=IMG_ENURI_COM%>/images/event/2018/knowcom_1st/m_album_item03.jpg" alt="4~6월 뉴스 '스포츠연예' 추가" />
							</a>
						</div>
						<div class="album_item">
							<a href="/knowcom/enuritv.jsp?bbsname=enuritv" target="_blank" title="새 창 열기">
								<img class="thumb" src="<%=IMG_ENURI_COM%>/images/event/2018/knowcom_1st/m_album_item04.jpg" alt="6~8월 에누리 TV채널 확대" />
							</a>
						</div>
						<div class="album_item">
							<a href="/knowcom/board.jsp?bbsname=nuri&cateno=8" target="_blank" title="새 창 열기">
								<img class="thumb" src="<%=IMG_ENURI_COM%>/images/event/2018/knowcom_1st/m_album_item05.jpg" alt="8~10월 갤러리 게시판 신설" />
							</a>
						</div>
						<div class="album_item">
							<a href="/knowcom/lucky7.jsp" target="_blank" title="새 창 열기">
								<img class="thumb" src="<%=IMG_ENURI_COM%>/images/event/2018/knowcom_1st/m_album_item06.jpg" alt="10~12월 럭키세븐 오픈" />
							</a>
						</div>
					</div>
					<div class="infobox">
						<dl class="blind">
							<dt>참여방법</dt><dd>6개의 성장 앨범 보고 도장 6개를 받으면 참여 완료, 이벤트 종료 후 추첨을 통해 2천명에 경품 증정</dd>
							<dt>이벤트 기간</dt><dd>2019년 1월 7일 ~ 1월 20일</dd>
							<dt>당첨자 발표</dt><dd>2019년 1월 24일</dd>
							<dt>이벤트 경품</dt><dd>e머니 100점	</dd>
						</dl>
					</div>
				</div>
			</div>
			<!-- //이벤트2 성장앨범 감상타임 -->


			<!-- 이벤트3 덕담타임 -->
			<div class="eventbox event_3st">
				<div class="boxbg_inner">
					<h2 class="tit">이벤트 3 덕담 타임, 쇼핑지식에 더 필요한 점은?</h2>
					<p class="blind">여러분의 의견으로 더 성장할 쇼핑지식을 위해 필요한 것이 무엇일 지 덕담 한마디 해주세요!</p>

					<div class="infobox">
						<dl class="blind">
							<dt>참여방법</dt><dd>쇼핑지식 응원, 필요한 것 등 덕담 등록하면 참여 완료! 이벤트 종료 후 추첨을 통해 경품 증정! 적용 가능한 덕담의 경우 서비스에 반영될 수 있는 영광을~</dt>
							<dt>이벤트 기간</dt><dd>2019년 1월 7일 ~ 1월 20일</dd>
							<dt>당첨자 발표</dt><dd>2019년 1월 24일</dd>
							<dt>이벤트 경품</dt><dd>신세계 백화점 상품권 5만원권, e머니 500점</dd>
						</dl>
					</div>

					<!-- 게시판에 남기기 -->
					<div class="input_board">
						<h3>덕담 한마디 남겨주세요</h3>

						<div class="write_area">
							<div class="input logout">
								<textarea id="" class="txt_area" maxlength="1000" placeholder="쇼핑지식에 뼈가 되고 살이 될 수 있는 유익한 덕담을 남겨주시면 추첨을 통해 경품을 드립니다."></textarea>
								<button id="" class="sprite btn regist">등록하기</button>
							</div>

							<!-- 로그인 후 -->
							<div class="input login" style="display:none;">
								<div class="box1">
									<p class="user"><%=!"".equals(sUsernick)?sUsernick:sUserid.length()>2?sUserid.substring(0, sUserid.length()-2)+"**":"" %></p>
									<textarea id="" class="txt_area" maxlength="1000" placeholder="쇼핑지식에 뼈가 되고 살이 될 수 있는 유익한 덕담을 남겨주시면 추첨을 통해 경품을 드립니다."></textarea>
								</div>
								<div class="box2">
									<p class="word_num"><span>0</span>/1000</p>
									<button id="" class="sprite btn regist" onclick="insertTxt()">등록하기</button>
								</div>
							</div>
						</div>
						<div class="view_area">
							<ul></ul>
						</div>
						<div class="paging">
							<ul class="list"></ul>
						</div>
					</div>
					<!-- //게시판에 남기기 -->
				</div>
			</div>
			<!-- //이벤트3 덕담타임 -->
		</div>
	</div>
	<!-- //컨텐츠 -->
	<!-- footer -->
	<jsp:include page="/knowcom/include/footer.jsp" flush="true"></jsp:include>
</div>
<!-- //쇼핑지식 1주년 맞이 event_wrap -->

<!-- 앱전용 이벤트 LAYER -->
<div class="layer_back" id="app_only" style="display:none;">
	<div class="appLayer">
		<h4>모바일 앱 전용 쇼핑 혜택</h4>
		<a href="javascript:///" class="close" onclick="onoff('app_only')">창닫기</a>
		<p class="txt">에누리 앱(APP) 설치 후<br />e머니 적립내역 확인 및<br />다양한 e쿠폰 상품으로 교환할 수 있습니다.</p>
		<p class="btn_close"><button type="button">설치하기</button></p>
	</div>
</div>
<!-- //앱전용 이벤트 LAYER -->

<!-- 딤레이어 : 투표 완료 -->
<div class="layer_back" id="completeVote" style="display:none;">
    <div class="appLayer votebox">
		<h3 class="tit">투표 완료! 투표 중간 집계 공개!</h3>

		<div class="inner">
			<ul class="votelist"></ul>
			<p class="notice">최종 투표 결과는 이벤트 종료 후 자유게시판에 공개됩니다.</p>
		</div>
		<a class="sprite btn closelay" href="javascript:void(0);" onclick="onoff('completeVote');return false"><em>팝업 닫기</em></a>
	</div>
</div>
<!-- //딤레이어 : 투표 완료 -->

<!-- 딤레이어 : 앨범확인완료 -->
<div class="layer_back" id="completeAlbum" style="display:none;">
	<div class="appLayer albumcompbox">
		<h3 class="blind">성장 앨범 확인 완료!</h3>
		<p class="blind">답례품은 이벤트 종료 후 추첨을 통해 2천명에게 e머니 100점이 적립됩니다.</p>

		<a class="sprite btn closelay" href="javascript:void(0);" onclick="onoff('completeAlbum');return false"><em>팝업 닫기</em></a>
	</div>
</div>
<!-- //딤레이어 : 앨범확인완료 -->

<!-- 유의사항 -->
<div class="layer_back" id="notetxt1" style="display:none;">
	<div class="appLayer">
		<h4>유의사항</h4>
		<a href="javascript:///" class="close" onclick="onoff('notetxt1')">창닫기</a>
		<ul class="txtlist">
			<li><span class="th">당첨자 발표 :</span> 2019년 1월 24일<span class="sub">쇼핑지식 &gt; 자유게시판 공지 / 쇼핑지식 &gt; 공지</span></li>
			<li>해당 이벤트는 쇼핑지식에 로그인 한 회원만 참여 가능합니다.</li>
			<li>ID당 이벤트 별 1회 참여 가능합니다.<br />(동일인이 다른 ID로 중복 참여할 수 없으며 하나의 IP를 하나의 ID로 간주)</li>
			<li>경품 발송을 위해 수집된 정보는 당첨자의 확인 및 경품발송을 위한 본인확인 이외의 목적으로 활용되지 않으며, 이용 후 파기됩니다.</li>
			<li>입력한 정보는 수정하실 수 없으며, 잘못된 정보 입력으로 인한 경품 수령의 불이익은 책임지지 않습니다.</li>
			<li>부정 참여 시 당첨이 취소될 수 있습니다.</li>
			<li>일부 경품의 경우 제세공과금이 발생할 수 있습니다.</li>
			<li>재고 소진 시 경품이 변경 될 수 있습니다.</li>
			<li>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</li>
		</ul>
	</div>
</div>
<!-- //유의사항 -->

<script>
/*레이어*/
function onoff(id) {
	var mid=document.getElementById(id);
	if(mid.style.display=='') {
		mid.style.display='none';
	}else{
		mid.style.display='';
	}
}
</script>

<script type="text/javascript">
var page = "<%=iPage%>";
var cnt = 10;
var pageSize = 5;

var v1Code = 2019010701,
	v2Code = 2019010702;

var isEnuri = <%=isEnuri%>;

$(document).ready(function() {
	insertLog(18707);

	// 로그인 여부에 따른 댓글 영역
	if (islogin()) {
		$('.input.logout').hide();
		$('.input.login').show();
	} else {
		$('.input.logout').show();
		$('.input.login').hide();
	}

	$('div.input_board > div.write_area > div.input.logout > button').on("click", function() {
		if (confirm("로그인 후 작성할 수 있습니다.\n로그인 하시겠습니까?")) {
			Cmd_Login('');
		}
	});

	//닫기버튼
	if (getCookie("appYN") == 'Y') {
		$( ".win_close" ).hide();
	}
	$( ".win_close" ).click(function(){
		if(getCookie("appYN") == 'Y'){
// 			window.location.href = "close://";
		}else{
			window.location.replace("/mobilefirst/index.jsp");
		}
	});

	// 댓글페이지
	getTxtList(page);

	// 댓글 페이지 클릭시 css 적용 이벤트
	$('div.eventbox.event_3st > div > div.input_board > div.paging > ul.list > li > a').not('.btn').on("click", function() {
		$(this).parent().siblings().find('.selected').removeClass("selected");
		$(this).addClass("selected");
	});

	// 댓글 글자수 카운트
	$('div.input_board > div.write_area > div.input.login > div.box1 > textarea').on("keyup", function() {
		$('div.input_board > div.write_area > div.input.login > div.box2 > p > span').text($(this).val().length);
	});

	// 사용자 투표현황
	getVoteList(v1Code);
	getVoteList(v2Code);

	// 이벤트1
	$('div.eventbox.event_1st > div > div.selectboard > ul > li > a').on("click", function() {
		insertLog(18709);
	}).parent().on("click", function() {
		if (!islogin()) {
			if (confirm("로그인 후 작성할 수 있습니다.\n로그인 하시겠습니까?")) {
				Cmd_Login('');
			}
			return false;
		} else if(isEnuri) {
			alert("임직원은 참여가 불가합니다.");
			return false;
		} else {
			clicker('data', 1, $(this).index()+1, $(this));
		}
	});

	$('div.eventbox.event_1st > div > div.selectboard > a.non-click').on("click", function() {
		if(isEnuri) {
			alert("임직원은 참여가 불가합니다.");
			return false;
		}
		alert("미션 완료 후 참여가능합니다.");
	});

	// 이벤트2
	$('div.eventbox.event_2st > div > div.album_list > div.album_item > a').on("click", function() {
		insertLog(18711);
	}).parent().on("click", function() {
		if (!islogin()) {
			if (confirm("로그인 후 작성할 수 있습니다.\n로그인 하시겠습니까?")) {
				Cmd_Login('');
			}
			return false;
		} else if(isEnuri) {
			alert("임직원은 참여가 불가합니다.");
			return false;
		} else {
			clicker('data', 2, $(this).index()+1, $(this));
		}
	});
});

// 댓글 리스트
function getTxtList(page) {
	$.ajax({
		type    : "GET",
		url     : "/mobilefirst/evt/ajax/getKnowcom_1st_txt.jsp",
		data    : { "page" : page, "cnt" : cnt },
		dataType: "json",
		cache	: false,
		success : function(data) {
			paging(page, cnt, data.total);

			var makeHtml = "";
			$.each(data.list, function(i, v) {
				makeHtml += "<li>";
				makeHtml += 	"<p class=\"user\">"+v.nickname+" <span class=\"date\">"+v.insdate+"</span></p>";
				makeHtml += 	"<p class=\"cont\">"+v.ptcp_cts+"</p>";
				makeHtml += "</li>";
			});
			$('div.eventbox.event_3st > div > div.input_board > div.view_area ul').html(makeHtml);
		},
		error   : function(xhr, status, error) {
		}
	});
}

// 댓글 페이징
function paging(page, cnt, total) {
	var maxPage = Math.ceil(total / cnt);
	var beforePage = Math.floor((page-1) / pageSize) * pageSize;	// 0 ~ 5배수
	var nextPage = Math.ceil(page / pageSize) * pageSize + 1;
		nextPage = nextPage > maxPage ? maxPage + 1 : nextPage;		// 6 ~ 5배수 ~ maxPage + 1

	if (page < 1 || (maxPage > 1 && page > maxPage)) {
		window.location.replace(location.pathname);
	}

	var makeHtml = "";
	if (pageSize <= beforePage) {
		makeHtml += "<li><a data-page=\""+beforePage+"\" href=\"javascript:///\" onclick=\"javascript:getTxtList("+beforePage+");\" class=\"sprite btn prev\"></a></li>";
	}
	for (var i=beforePage+1; i<nextPage; i++) {
		makeHtml += "<li><a data-page=\""+i+"\" href=\"javascript:///\" onclick=\"javascript:getTxtList("+i+");\" ";
		if (i == page) {
			makeHtml += "class=\"selected\"";
		}
		makeHtml +=">"+i+"</a></li>";
	}
	if (nextPage <= maxPage) {
		makeHtml += "<li><a data-page=\""+nextPage+"\" href=\"javascript:///\" onclick=\"javascript:getTxtList("+nextPage+");\" class=\"sprite btn next\"></a></li>";
	}

	$('div.eventbox.event_3st > div > div.input_board > div.paging > ul.list').html(makeHtml);
}

// 댓글 입력
var isClick = true;
function insertTxt() {
	var txt = $('div.input_board > div.write_area > div.input.login > div.box1 > textarea').val().trim();

	if (!isClick) {
		return false;
	}
	isClick = false;

	if (!islogin()) {
		if (confirm("로그인 후 작성할 수 있습니다.\n로그인 하시겠습니까?")) {
			Cmd_Login('');
		}
		isClick = true;
		return false;
	}

	if (txt.length <= 0) {
		alert("댓글을 입력하여 주시기 바랍니다.");
		isClick = true;
		return false;
	} else if (txt.length < 5) {
		alert("5글자 이상 입력해주세요.");
		isClick = true;
		return false;
	} else if (txt.length > 1000) {
		alert("글자수가 초과되었습니다.\n글자수를 1,000자로 맞춰주시기 바랍니다.");
		isClick = true;
		return false;
	}

	$.ajax({
		type    : "POST",
		url     : "/mobilefirst/evt/ajax/setKnowcom_1st_txt.jsp",
		async   : false,
		data    : {
					"event_code": "2019010703"
					, "txt"		: txt
					, "os_type"	: "<%=os%>"
				},
		dataType: "json",
		success : function(data) {
			var result = data.result;
			switch (result) {
			case 1 :
				alert("등록 되었습니다.");
				$('div.input_board > div.write_area > div.input.login > div.box1 > textarea').val('').trigger("keyup");
				getTxtList(1);
				break;
			case -3 :
				alert("이미 참여했습니다.");
				break;
			case -4 :
				alert("임직원은 참여가 불가합니다.");
				break;
			case -5 :
        		if (confirm("로그인 후 작성할 수 있습니다.\n로그인 하시겠습니까?")) {
        			Cmd_Login('');	// 로그인 화면 이동
        		}
        		break;
			case -9 :
            	alert("SDU회원은 본인인증 후 적립 받을 수 있습니다.\n본인인증은 앱 설정 > 본인인증 또는 PC > 개인정보관리 화면을 이용해주세요.");
            	break;
			default :
				alert("잘못된 접근입니다.");
				break;
			}
		},
		error   : function(xhr, status, error) {
		},
		complete: function() {
			isClick = true;
		}
	});
}

var isClick2 = true;
function clicker(type, voteno, sctNo, $obj) {
	var event_code = voteno==1?v1Code:v2Code;

	if (!isClick2) {
		return false;
	}
	isClick2 = false;

	if (!islogin()) {
		if (confirm("로그인 후 작성할 수 있습니다.\n로그인 하시겠습니까?")) {
			Cmd_Login('');
		}
		isClick2 = true;
		return false;
	}

	if ("vote" == type && event_code == v1Code && sctNo <= 0) {
		alert("게시판을 선택 후 투표해주세요.");
		isClick2 = true;
		return false;
	}

	$.ajax({
		type    : "POST",
		url     : "/knowcom/api/setAnniv.jsp",
		data    : {
					"evnt_cd"	: event_code
					, "sctNo"	: sctNo
					, "osType"	: "<%=os%>"
					, "type"	: type
					, "voteNo"	: type=='vote'?sctNo:''
				},
		dataType: "json",
		success : function(data) {
			switch (data.result) {
			case 1 :
				if ("data" == type) {
					$obj.unbind("click");	// 이벤트 1,2 setApi unbind

					if (data.evnt_cd == v1Code && data.count2 == 4) {			// 4개 클릭시 투표하기 활성화
					$('div.eventbox.event_1st > div > div.selectboard > a').unbind("click").removeClass("non-click")
																			.bind("click", function() {
 																				clicker('vote', 1,  $(".selectarea li.active").index()+1);
																			});
					} else if (data.evnt_cd == v2Code) {
					$(".album_item a").eq(sctNo-1).append("<span class='sprite mark-confirm'>참 잘했어요</span>");

					if (data.count2 == 6) {	// 6개 클릭시 자동 투표
						isClick2 = true;
						clicker('vote', 2);
						onoff('completeAlbum');
					}
					}
				} else if ("vote" == type && event_code == v1Code) {
					voteCount();			// 투표 현황
					onoff('completeVote');
				}
				break;
			case -3 :
				if ("data" == type) {
					$obj.unbind("click");	// 이벤트 1,2 setApi unbind
				} else if ("vote" == type && event_code == v1Code) {	// 투표하기 버튼만 알럿
					alert("이미 참여했습니다.");
				}
				break;
			case -4 :
				alert("임직원은 참여가 불가합니다.");
				break;
			case -5 :
        		if (confirm("로그인 후 작성할 수 있습니다.\n로그인 하시겠습니까?")) {
        			Cmd_Login('');	// 로그인 화면 이동
        		}
        		break;
			case -9 :
            	alert("SDU회원은 본인인증 후 적립 받을 수 있습니다.\n본인인증은 앱 설정 > 본인인증 또는 PC > 개인정보관리 화면을 이용해주세요.");
            	break;
			default :
				alert("잘못된 접근입니다.");
				break;
			}
		},
		error	: function(xhr, status, error) {
		},
		complete: function() {
			isClick2 = true;
		}
	});
}

// 사용자의 투표현황
function getVoteList(event_code) {
	$.ajax({
		type    : "POST",
		url     : "/knowcom/api/getAnniv.jsp",
		data    : { "evnt_cd"	: event_code },
		dataType: "json",
		success : function(result) {
			if (event_code == v1Code && result.data.length == 4) {
				$('div.eventbox.event_1st > div > div.selectboard > ul > li').unbind("click");
				$('div.eventbox.event_1st > div > div.selectboard > a').unbind("click").removeClass("non-click")
																		.bind("click", function() {
 																			clicker('vote', 1,  $(".selectarea li.active").index()+1);
																		});
			} else if (event_code == v2Code) {
				$.each(result.data, function(i, v) {
					$(".album_item a").eq(v.sct_no-1).append("<span class='sprite mark-confirm'>참 잘했어요</span>");
				});

				if (result.data.length == 6) {
					$('div.eventbox.event_2st > div > div.album_list > div.album_item').unbind("click");
				}
			}
		}
	});
}

// 1번 투표결과
function voteCount() {
	$.ajax({
		type    : "GET",
		url     : "/knowcom/api/getAnniv.jsp",
		data    : {
					"evnt_cd"	: v1Code
					, "type"	: "voteCount"
				},
		dataType: "json",
		success : function(data) {
			var makeHtml = "";
			$.each(data.count, function(i, v) {
				var bbsname = ["뉴스", "구매가이드", "자유게시판", "에누리TV"];
				makeHtml += "<li";
				if (i == 0) {
					makeHtml += " class=\"top\"";
				}
				makeHtml += "><span class=\"boardname\">"+bbsname[v.voteNo-1]+"</span> <strong class=\"count\"><span class=\"num\">"+commaNum(v.voteCnt)+"</span>표</strong></li>";
			});
			$('#completeVote > div > div.inner > ul.votelist').html(makeHtml);
		}
	});
}
</script>
</body>
</html>
