<%@ page contentType="text/html; charset=utf-8" %>
<%@include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.knowbox.Members_Proc"%>
<jsp:useBean id="Members_Proc" class="com.enuri.bean.knowbox.Members_Proc" scope="page" />
<%
	String browser = request.getHeader("User-Agent");
	
	if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1 
	|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1 
	|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1
	|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){
	}else{ 
		//pc 로그인 경우 pc 페이지로 redirect
		response.sendRedirect("/event2018/time_coupon.jsp");
	} 
	
	String appYN = ChkNull.chkStr(request.getParameter("app"),""); //app 여부
	String cUserId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID")); //로그인쿠키 아이디
	String cUserNick = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_NICK")); //로그인 닉네임
	
	String cUsername = "";
	String userArea = "";

	if(!cUserId.equals("")){
	    cUsername = Members_Proc.getUserName(cUserId);
	    userArea = cUsername;
		//로그인 닉네임 우선 정책 
	    if(cUsername.equals("")) userArea = cUserNick;
	    if(userArea.equals(""))  userArea = cUserId;
	}
	
	String chkId = ChkNull.chkStr(request.getParameter("chk_id"));
	
%>
<!DOCTYPE html> 
<html lang="ko">
<head>
	<meta charset="utf-8">	
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />	
	<meta property="og:title" content="에누리 가격비교">
	<meta property="og:description" content="에누리 모바일 가격비교">
	<meta property="og:image" content="http://imgenuri.enuri.gscdn.com/images/mobilenew/images/logo_enuri.png">
	<meta name="format-detection" content="telephone=no" />
	<link rel="stylesheet" type="text/css" href="/css/event/y2018/time_coupon_m.css"/>
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/lib/slick.css"/>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/event_regular.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/ga.js"></script>
</head>
<body>
<!-- layer--> 
<div class="layer_back" id="app_only" style="display:none;">
	<div class="appLayer">
		<h4>모바일 앱 전용 이벤트</h4>
		<a href="javascript:///" class="close" onclick="onoff('app_only')">창닫기</a>
		<p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br />에누리앱을 설치합니다.</p>
		<p class="btn_close"><button type="button" onclick="install_btt();" >설치하기</button></p>
	</div>
</div>

<!-- 이벤트 WRAPPER -->
<div class="wrap">
	<!-- 이벤트 상단 -->
	<div class="evt_head">
		<div class="myarea">
		<%if(cUserId.equals("")){%>	
		<p class="name">나의 e머니는 얼마일까?<button type="button" class="btn_login">로그인</button></p>	
		<%}else{%>
		<p class="name"><%=userArea%> 님<span id="my_emoney">0점</span></p>
		<%}%>
		<a href="javascript:///" class="win_close">창닫기</a>
	</div>
	</div>
	<!-- //이벤트 상단 -->
		
	<!-- 상단비주얼 -->
	<div class="evt_visual">
        <div class="contents">
            <div class="visual">
                <!-- 
                <ul class="sns">
                    <li><a href="javascript:///">카카오톡</a></li>
                    <li><a href="javascript:///">페이스북</a></li>
                </ul>
                -->
                <div id="neon" class="neon1"></div>
                <div class="blind">
                    <h1>TIME COUPON</h1>
                    <em>단,선착순 200명! 30% 페이백 누폰 지급!</em>
                </div>
            </div>
        </div>
	</div>
	<!-- //상단비주얼 -->
	
    <!-- 타임 쿠폰 -->
	<div class="evt_content">			
		<div class="time_coupon">
			<div class="contents">
				<div class="tc_head">
					<div class="blind">
						<em>3만원 이상 구매시 최대 1만점</em>
					</div>
					<a href="javascript:///" class="btn btn_join"  id="btn_join" >쿠폰받기</a>
				</div>
                <div class="inner">
                    <div class="txt_box">
                        <ul class="info">
                            <li class="space">이벤트 및 구매기간 : 2018년 9월 21일 - 9월 26일</li>
                            <li class="space">페이백 지급일 : 11월 26일 월요일 (※ 페이백은 e머니로 지급)</li>
                            <li class="space">참여 방법
                                <ol>
                                    <li>1) 9월 21일 오후 1시 선착순 200명에게 지급되는 타임쿠폰 받기!</li>
                                    <li>2) 이벤트기간 내 적립대상쇼핑몰에서 3만원 이상 구매하면 완료!</li>
                                </ol>
                            </li>
                            <li class="space">유의사항 (아래의 경우 경품지급불가)
                                <ul>
                                    <li>- 배송비/할인쿠폰/포인트 제외한 구매금액이 3만원 미만일 경우</li>
                                    <li>- e머니 적립 제외 카테고리의 상품 구매일 경우</li>
                                    <li>- 구매 후 취소/환불/교환/반품한 경우 </li>
                                    <li>- 동일번호로 가입한 다수의 ID로 참여할 경우 중복지급 불가</li>
                                    <li>- 타 구매프로모션 혜택과 중복지급 불가</li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </div>
                <a href="#" id="caution" class="btn_caution" onclick="onoff('notetxt'); return false;">꼭!확인하세요</a>
                <script type="text/javascript">
                    // 카테고리 레이어 현재위치에서 열리도록 top 조정
                    $("#caution").on("click", function(e){
                        var currTop = $(window).scrollTop(); // 현재 스크롤
                        $("#notetxt .appLayer").css("top", currTop);
                    })
                </script>
            </div>
        </div>
    </div>
    <!-- //타임 쿠폰  -->
    <!-- 생활혜택 -->
    
    <%@ include file="/mobilefirst/evt/emoney_guide.jsp"%><!-- 생활혜택 -->
    
    <!--// 생활혜택 -->
	<!-- 유의사항 -->
	<div class="layer_back topfix" id="notetxt" style="display:none;">
        <div class="appLayer al_position">
            <h4>유의사항</h4>
            <a href="javascript:///" class="close" onclick="onoff('notetxt');return false;">창닫기</a>
            <div class="inner">
                <dl class="txtlist">
                    <dt>이벤트 기간</dt>
                    <dd>2018년 9월 21일 ~ 2017년 9월 26일</dd>
                </dl>
                <dl class="txtlist">
                    <dt>참여방법 &amp; 유의사항</dt>
                    <dd>참여방법: 에누리 가격비교 앱 로그인 → 9월 21일 오후 1시 선착순 200명 포인트백 타임쿠폰 받기! → 적립대상 쇼핑몰 이동 → <em class="stress">~9/26까지 3만원 이상 구매</em>하면 완료!</dd>
                    <dd><strong>적립대상 쇼핑몰: </strong>G마켓, 옥션, 11번가, 인터파크, 티몬, 위메프, GS SHOP, Cjmall, SSG (신세계몰, 신세계백화점, 이마트몰, 트레이더스)</dd>
                    <dd>3만원 이상 구매금액은 배송비, 설치비, 할인쿠폰, 쇼핑몰 포인트 등 제외한 상품 실제 결제금액만 반영</dd>
                    <dd>1회 구매시 3만원 이상 구매할 경우에만 지급 (기간 내 누적 구매금액X)</dd>
                </dl>  
                <dl class="txtlist">
                    <dd><strong class="stress">경품지급 제외</strong>: 아래의 경우 이벤트 참여는 가능하나 경품 지급대상에서 제외됩니다.
                        <ul>
                            <li>실제 결제금액이 3만원 미만의 구매일 경우</li>
                            <li>e머니 적립 제외 카테고리의 상품 구매일 경우</li>
                            <li>구매 후 취소/환불/교환/반품한 경우</li>
                            <li><strong class="stress">동일번호로 가입한 다수의 ID로 참여할 경우 1개의 ID에만 지급되며, 다른 ID에는 중복지급 불가</strong></li>
                            <li><strong class="stress">타 구매프로모션 혜택과 중복지급 불가</strong></li>
                            <li>중복지급 불가 프로모션: 더블적립, 무제한적립, 카테고리추가적립, 첫구매, 친구초대</li>
                            <li>타 프로모션이 우선 지급 및 적용되며, 해당 프로모션에서 이벤트 적립된 경우 페이백 대상 제외</li>
                            <li>첫구매, 친구초대 프로모션의 경우 해당 프로모션에 적용된 구매 외에 추가 구매가 있을 경우 지급 가능</li>
                        </ul>
                    </dd>
                </dl>
                <dl class="txtlist">
                    <dt>당첨자 혜택</dt>
                    <dd><strong>이벤트 경품: 구매금액의 30% e머니로 페이백 (최대 1만점)</strong></dd>
                    <dd>당첨자 발표 및 페이백 지급일: 2017년 11월 26일<br />
                        - 에누리 가격비교 APP > 이벤트/기획전탭 > 이벤트혜택 > 하단 ‘당첨자 발표’에 공지
                        <p>※ 적립된 e머니는 e쿠폰 스토어에서 교환가능합니다.</p>
                    </dd>
                </dl>
                <dl class="txtlist">
                    <dt>아래의 경우에는 구매 확인 및 적립이 불가합니다.</dt>
                    <dd>에누리 가격비교 앱이 아닌 다른 앱을 통해서 장바구니 또는 관심상품 등록 후 에누리 가격비교 앱으로 결제만 한 경우<br>(에누리 가격비교 앱을 통해 쇼핑몰로 이동 후 장바구니/관심상품 등록 후 구매 시에는 가능)</dd>
                    <dd>구매 후 모바일 앱 적립내역 페이지에서 [적립받기]를 선택하지 않은 경우</dd>
                    <dd>에누리 가격비교 앱 미 로그인 후 구매한 경우 또는 에누리 가격비교 PC, 모바일 웹에서 구매한 경우</dd>
                    <dd><strong>적립대상쇼핑몰 중 e머니 적립 제외 카테고리/서비스</strong>
                        <ul>
                            <li>에누리 가격비교 앱에서 검색되지 않는 상품</li>								
                            <li>순금/돌반지, 중고상품, 지류상품권, e쿠폰 상품권, 지역쿠폰, e쿠폰 등 환금성 상품</li>
                            <li>인터파크: 에누리 특가상품(크레이지딜), 모바일쿠폰/상품권, 라이프 서비스(티켓, 투어, 아이마켓 등)</li>
                            <li>11번가: 여행/숙박/항공, 모바일쿠폰/상품권 전체</li>
                            <li>G마켓: 중고장터, 실시간 여행, 항공권, 도서/음반, 모바일쿠폰/상품권 전체</li>
                            <li>옥션: 중고장터, 실시간 여행, 항공권, 모바일쿠폰/상품권 전체</li>
                            <li>SSG: 도서/음반/문구/취미/여행, 모바일쿠폰/상품권/서비스 및 현금성 상품</li>
                            <li>티몬: 슈퍼꿀딜, 슈퍼마트 등 특가 판매 상품, 모바일쿠폰/상품권 전체</li>
                            <li>위메프: 모바일쿠폰/상품권 전체</li>
                            <li>CJ몰: 모바일쿠폰/상품권 전체</li>
                            <li>이 외 쇼핑몰에 입점한 제휴 서비스(배달, 티켓, 해외직구 등) 및 일부 카테고리 제외</li>
                        </ul>
                    </dd>
                </dl>
                <dl class="txtlist">
                    <dt>유의사항</dt>
                    <dd>부정 참여 시 적립이 취소될 수 있습니다.</dd>
                    <dd>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</dd>
                </dl>
            </div>
            <p class="btn_close">
                <button type="button" onclick="onoff('notetxt');return false;">닫기</button>
            </p>
            </div>
    </div>
    <!-- //유의사항  -->
	<span class="go_top"><a onclick="$(window).scrollTop(0);">TOP</a></span>
</div>
<%@ include file="/mobilefirst/event2016/event_footer.jsp" %>
<script type="text/javascript">

ga('send', 'event', 'mf_event', '가정의달기획전', '전체PV');

var app = getCookie("appYN"); //app인지 여부
var vChkId = "<%=chkId %>";
function getPoint(){
	$.ajax({ 
		type: "GET",
		url: "/mobilefirst/emoney/emoney_get_point.jsp",
		async: false,
		dataType:"JSON",
		success: function(json){
			remain = json.POINT_REMAIN;	//현재 적립된 이머니
			$("#my_emoney").html(CommaFormattedN(remain) +""+json.POINT_UNIT);	
		}
	});
}
$(function(){
	//emoney를 가져온다
	getPoint();
	
	$(".btn_login").click(function(){
		location.href = "/mobilefirst/login/login.jsp?backUrl="+encodeURIComponent(document.location.href);
		return false;
	});

	
	$("#btn_join").click(function(){
		
		if(app != "Y"){//app 에서만 응모 가능
			onoff('app_only');
			return false;
		}
		
		var goUrl = "/mobilefirst/evt/ajax/setTimeCoupon.jsp";
		
		$.getJSON(goUrl,function(data){
			
			if (data.result == -1){
				alert(data.msg);
			}else if(data.result == 0){
				alert("선착순 수량이 마감되었습니다!");
				//location.reload();
			}else if(data.result == 1){
				alert("선착순 30% 페이백 쿠폰이 발급되었습니다!\n(~9/26까지 3만원 이상 구매시 최대 1만점 페이백)");
			}else if(data.result == 2){
				alert("이미 쿠폰 받으셨습니다.");
			}else if(data.result == 4){
				//alert("로그인 후 구매하실 수 있습니다.");
				goLogin();
			}else if(data.result == 99){
				alert("임직원은 참여가 불가합니다.");
			}else{
				alert("새로고침 하시고 다시 구매하기 눌러주세요");
			}
			return false;
		});
		
	});
	$("#my_emoney").click(function(){	
		if('<%=appYN %>' != 'Y'){	// 웹에서 호출 
			onoff('app_only');
		}else{
			window.location.href = "/mobilefirst/emoney/emoney.jsp?freetoken=emoney";	//e머니 적립내역
		}
	});
	
	// 유의사항 드롭다운
	$('.btn_check').click(function(){
		var _this = $(this);
		_this.siblings(".moreview").toggle();
		
		$(".btn_check_hide").click(function(){
			$(this).parents(".moreview").slideUp();
			$('html,body').stop().animate({scrollTop:_this.offset().top - 71});
			return false;
		})
	});
	
	$(window).scroll(function(){
		// 윈도우 닫기버튼
		if($(this).scrollTop() >= $(".evt_visual").offset().top){
			$(".myarea").addClass("f-nav");
		}else{
			$(".myarea").removeClass("f-nav");
		}
	});
	
	//닫기버튼
	 $( ".win_close" ).click( function() {
	        if(app == 'Y')            window.location.href = "close://";
	        else            window.location.replace("/mobilefirst/index.jsp");
	 });
	
});
    // 네온효과
    function closeLayer(IdName){
        var pop = document.getElementById(IdName);
        pop.style.display = "none";
    }

    var $neon = $("#neon"),
    neonArr = ["neon1","neon1","neon1","neon2","neon3","neon3","neon3"],
    neonIndex = 0,
    turn = false;
    
    function changeneon(){
        $neon.attr("class", neonArr[neonIndex]);

        if(!turn) neonIndex++;
        else neonIndex--;
        
        if(neonIndex > neonArr.length) turn = true;
        else if(neonIndex == 0) turn = false;
    } 
    setInterval(changeneon,40);
	// onoff 레이어
	function onoff(id) {var mid=document.getElementById(id);if(mid.style.display=='') mid.style.display='none';else mid.style.display='';}
	function CommaFormattedN(amount) {var delimiter = ",";var i = parseInt(amount);if(isNaN(i)) { return ''; }var minus = '';if (i < 0) { minus = '-'; }i = Math.abs(i);var n = new String(i);var a = [];while(n.length > 3){var nn = n.substr(n.length-3);a.unshift(nn);n = n.substr(0,n.length-3);}if (n.length > 0) { a.unshift(n); }n = a.join(delimiter);amount = minus + (n+ "");return amount;}
</script>
</body>
</html>