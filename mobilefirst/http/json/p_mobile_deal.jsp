<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@ page import="com.enuri.bean.main.Member_Point_Proc"%>
<jsp:useBean id="Members_Data" class="com.enuri.bean.knowbox.Members_Data" scope="page" />
<jsp:useBean id="Members_Proc" class="com.enuri.bean.knowbox.Members_Proc" scope="page" />
<jsp:useBean id="Member_Point_Proc" class="com.enuri.bean.main.Member_Point_Proc" scope="page" />
<%
	//이벤트 시간 설정
	/*if (DateStr.nowStr("yyyy.MM.dd. HH:mm").compareTo("2016.05.01. 00:00") >= 0){
		out.print("<script>alert('이벤트 기간이 종료 되었습니다.');location.href='http://www.enuri.com/';</script>");
		return;	
	}*/

	// 모바일 기기 접속 시 접속 페이지 변경
	if(
			(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Linux") >= 0 ) ||  
			(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Mac") >= 0) ||  
			(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Mac") >= 0) ||  
			(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Mac") >= 0)
	){
		response.sendRedirect("/mobilefirst/event2016/mobile_deal.jsp");
		return;	
	}

	String strCon = ChkNull.chkStr(request.getParameter("con"), "");
	
	//사용자 이름 미존재 시 ID로 표현
	String strEventID = cb.GetCookie("MEM_INFO", "USER_ID");
	String strUserNm = "";
	String eventUserInfo = strEventID;
	int intUserPoint = 0;
	
	if (!strEventID.isEmpty()) {
		strUserNm = Members_Proc.getUserName(strEventID);
		intUserPoint = Member_Point_Proc.getEmoneyEventPoint(strEventID);
		if (!strUserNm.isEmpty()) {
			eventUserInfo = strUserNm;
		}
	}
	/*이벤트 코드 수정*/
	//String eventId = "";
	
	long cTime = System.currentTimeMillis(); 
	SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMddHHmm");
	String nowDt = dayTime.format(new Date(cTime));

	String[] weekStr = {"2016/05/30 ~ 2016/06/05",
						"2016/06/06 ~ 2016/06/12",
						"2016/06/13 ~ 2016/06/19",
						"2016/06/20 ~ 2016/06/26"};
	
	String[] weekStartDt = {"201605300000",
							"201606060000",
							"201606130000",
							"201606200000"};
	
	String[] weekEndDt	 = {"20160605235959",
							"20160612235959",
							"20160619235959",
							"20160626235959"};
	int weekNo = 0;
	for(int i=0; i<weekStr.length; i++){
		if(Long.parseLong(nowDt) >= Long.parseLong(weekStartDt[i]) && Long.parseLong(nowDt) <= Long.parseLong(weekEndDt[i])){
			weekNo = i;
			break;
		}
	}
	
%>
<!--  Enuri Header Start -->
<!doctype html>
<head>
<!--  이벤트 공통 영역 -->
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<META NAME="description" CONTENT="최저가 에누리 - 가격비교 사이트 에누리닷컴입니다."> 
<META NAME="keyword" CONTENT="휴대폰, 사무, 생활가전, 용품, 영상음향, 컴퓨터, 자동차, 명품, 잡화, 스포츠, 유아, 완구, 가구, 화장품, 식품, 가격비교, 쇼핑몰, 최저가">
<link rel="shortcut icon" href="http://imgenuri.enuri.gscdn.com/2014/layout/favicon_enuri.ico">
<title>에누리(가격비교) eNuri.com</title>
<script type="text/javascript" src="/common/js/lib/mustache.js"></script>
<script type="text/javascript" src="/common/js/lib/jquery-1.9.1.min.js"></script>
<!-- jquery 플러그인. attrchange 될 때 이벤트 잡아줌. -->
<script type="text/javascript" src="/event/attrchange.js"></script>
<script type="text/javascript" src="/common/js/common_top_2015.js"></script>
<script type="text/javascript" src="/common/js/function.js"></script>
<script type="text/javascript" src="/common/js/paging.js"></script>
<script type="text/javascript" src="<%=ConfigManager.IMG_ENURI_COM%>/common/js/Log_Header.js"></script>
<script type="text/javascript" src="/event/Event_Common_Func.js"></script>	
 <!--  
<script type="text/javascript" src="/js/flick.event.js"></script>
<link rel="stylesheet" href="/css/event/flick.css" type="text/css">-->
<script type="text/javascript" src="/event2016/js/event_common.js"></script>

<%@ include file="/common/jsp/eb/head_2015.jsp"%>
<!--  Enuri Header End -->

<!-- 개별 영역 Start : 개발적으로 사용하는 js, css -->
<link rel="stylesheet" href="/css/event/enurideal.css" type="text/css">
  
<link rel="stylesheet" type="text/css" href="/css/slick.css"/>
<script type="text/javascript" src="/js/slick.min.js"></script>
<!-- 개별 영역 End -->
<script type="text/javascript">
		/*플리킹*/
		var varCon = "<%= strCon %>";		
</script>
<script type="text/javascript">
function openLayer(IdName){
	var pop = document.getElementById(IdName);
	pop.style.display = "block";
}
function closeLayer(IdName){
	var pop = document.getElementById(IdName);
	pop.style.display = "none";
}
</script>
<script type="text/javascript">
	$(document).ready(function(){
		var select = $("#select_box > select#sel");
		select.change(function(){
	        var select_name = $(this).children("option:selected").text();
	        $(this).siblings("label").text(select_name);
		});
    });
</script>
</head>
<body>

<div id="main_body">
<!--  Enuri Top Start -->
<jsp:include page="/common/jsp/Common_Top_2015.jsp" flush="true">
    <jsp:param value="w_bg" name="gnbType"/>
</jsp:include>
<!--  Enuri Top End -->

	<!-- 20160526 에누리딜 랜딩페이지 -->
	<div class="event_wrap">
	
	<!-- 딤레이어 : 앱전용 구매 -->
	<div  id="buyApp" class="pop-layer" style="display:none;">
		<div class="popupLayer">
			<div class="dim"></div>
		</div>
		<!-- popup_box -->
		<div class="popup_box app_install">
			<p class="txt">오직 에누리 앱에서만 구매 가능합니다.</p>
			  	<a class="go_app" href="#" onclick="goAppFirstInstallParam(1);">에누리 앱 설치하기</a>
				<a class="closebtn" href="#" onclick="closeLayer('buyApp');return false"><em>팝업 닫기</em></a>
		</div>
		<!-- //popup_box -->
	</div>
	<!-- //딤레이어 : 앱전용 구매 -->
	
	<!-- visual -->
	<div class="section visual">
		<div class="vinner">
			<div class="contents">
				<h2>[에누리 앱 전용 혜택] 최저가에서 한번 더 추가할인 eDEAL</h2>
				<p class="txt">에누리 앱에서만 만날 수 있는 단독특가 서비스</p>
			
				<!-- moving_tap -->
				<div class="moving_tap">
					<!-- 로그인 전 -->
					<div class="inner login_before" style="display:block;" id="emoney_event_login_before">
						<div class="left_area"><strong>나의 e머니는 얼마일까?</strong><span>로그인 후 확인하세요.</span></div>
						<div class="right_area">
							<a href="javascript:void(0);" id="emoney_login_btn" class="btn login" title="클릭 시 레이어팝업"><em>로그인</em></a>
						</div>
					</div>
					<!-- //로그인 전 -->
					<!-- 로그인 후 -->
					<div class="inner login_after" style="display:none;" id="emoney_event_login_after">
						<div class="left_area"><strong id="eventUserNm"> 님</strong><span>은 사는 혜택을 받고 계십니다.</span></div>
						<div class="right_area">
							<a href="javascript:void(0);" id="after_login_click_id">
								<span class="btn emoney"><em>e머니</em></span><strong id="user_point_id">0 점</strong>
							</a>
						</div>
					</div>
					<!-- //로그인 후 -->
				</div>
				<!-- //moving_tap -->
			
				<!-- laypop -->
				<div  id="layerEvent" class="laypop">
					<h4 class="alcenter">모바일 앱 전용 쇼핑 혜택</h4>
					<div class="inner alcenter">
						<p>에누리 앱(APP) 설치 후<br />e머니 적립내역 확인 및 <br />다양한 e쿠폰 상품으로 교환할 수 있습니다.</p>
					</div>
					<a class="btn layinstall" href="#" onclick="goAppFirstInstallParam(1);"><em>설치하기</em></a>
					<a class="btn layclose" href="#" onclick="closeLayer('layerEvent');return false"><em>팝업 닫기</em></a>
				</div>
				<!-- //laypop -->
			</div>
		</div>
	</div>
	<!-- //visual -->

	<!-- edeal -->
	<div class="section edeal">
		<div class="contents">
			<h3 class="txt">eDEAL</h3>
			<p class="period"><em><%=weekNo+1%>주차</em><%=weekStr[weekNo]%></p>
			<div class="deal_goods">
				
			</div>
		</div>
	</div>
	<!-- //edeal -->

	<!-- exhibition -->
	<div  class="section exhibition">
		<div class="contents">
			<div class="deal_sm">
			</div>
		</div>
	</div>
	<!-- //exhibition -->

	<!-- nextdeal -->
	<div class="section nextdeal" <%=weekNo>=weekStr.length-1 ? "style='display:none;'" : ""%>>
		<div class="contents">
			<h3>오전 10시 COMING SOON</h3>
			<p class="period"><em><%=weekNo>=weekStr.length-1 ? "" : weekNo+2%>주차</em><%=weekNo>=weekStr.length-1 ? "" : weekStr[weekNo+1]%></p>
		</div>
	</div>
	<!-- //nextdeal -->

	<!-- receive_benefits -->
	<div class="section receive_benefits">
		<div class="contents">
			<h3>e머니로 생활혜택 받기</h3>
			<ol class="txt">
				<li>1.앱에서 e머니 확인</li>
				<li>2.스토어에서 쿠폰 교환</li>
				<li>3.쿠폰함에서 생활쿠폰 사용</li>
			</ol>
		</div>
	</div>
	<!-- //receive_benefits -->
	
</div>
	<!-- 프로모션 Body 영역 End -->
	
	
	
</div>
<!--  Enuri Footer Start -->
<jsp:include page="/include/IncListFooter_2010.jsp" flush="true"></jsp:include>
<jsp:include page="/common/jsp/IncPageEnd.jsp" flush="true">
    <jsp:param name="pagenm" value="planevent" />
</jsp:include>	
<!--  Enuri Footer End -->

</body>
</html>
<script language="JavaScript">
//var btnYn = false;
var vNowtime = '<%=nowDt%>';
vNowtime = vNowtime * 1;

$(function() {
	insertLog(13589);
	$("#gnb").css("width", "100%");
	checkLogin();
	getGoodsJson();
	//initBtn();

	/*scrollEvent();
	mouseOverEvent();
	
	if (varCon != "" && varCon.length > 0) {
		firstBuyItemEvent(varCon);
	}*/
});
//기간 체크
function finishChk(){
	/*var limit_time = 201605312359;
	if(vNowtime > limit_time){
		alert('6월 이벤트가 준비중입니다.');
		return false;
	}else{
		return true;	
	}*/
	return true;
}
//로그인
function checkLogin() {
	if(!islogin()) {
		$("#emoney_event_login_before").show();
		$("#emoney_event_login_after").hide();
		
		$("#emoney_login_btn").unbind();
		$("#emoney_login_btn").click(function() {
			Cmd_Login('emoneyPoint');
			return;
		});
		
		$("#emoney_attend_Img_id").unbind();
		$("#emoney_attend_Img_id").click(function() {
			Cmd_Login('emoneyPoint2');
			return;
		});
		
	}  else {
		var varUserPoint = "<%= intUserPoint %>";
		
		$("#emoney_attend_Img_id").unbind();
		
		$("#emoney_event_login_before").hide();
		$("#emoney_event_login_after").show();
		$("#eventUserNm").text("<%= eventUserInfo %> 님");
		$("#user_point_id").text(numberFormat(varUserPoint) + " 점");
		
		$("#after_login_click_id").unbind();
		$("#after_login_click_id").click(function() {
			$("#layerEvent").show();
		});
		//getStamp();
	}
}

function getGoodsJson(){
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
	
	var loadUrl = "/mobilefirst/http/json/mobile_deal_list.json";
	$.ajax({
		url: loadUrl,
		dataType: 'json',
		async: false,
		success: function(json){
			var seq = [];
			var total = 0;
			var random = 0;
			var temp = "";
			var template = "";
			var todayAtMidn = new Date().format("yyyyMMddhhmmss");
			todayAtMidn = todayAtMidn * 1;
				
			if(json){
				for(var i=0; i<json.length; i++){ // 판매중인 상품
					if((todayAtMidn > json[i].GOODS_ST_EXPODATE_DIF) && (todayAtMidn < json[i].GOODS_END_EXPODATE_DIF) && (json[i].GOODS_EXPO_FLAG == "Y") && (json[i].GOODS_SOLD_FLAG == "N") && (todayAtMidn > json[i].GOODS_ST_SELLDATE_DIF) && (todayAtMidn < json[i].GOODS_END_SELLDATE_DIF) && (json[i].GOODS_QUANTITY != 0)){
						seq[seq.length] = json[i].SEQ;
					}
				}
				if( !seq.length ){
					for(var i=0; i<json.length; i++){ // 판매중인 상품이 없는 경우 판매 예정인 상품								
						if((todayAtMidn > json[i].GOODS_ST_EXPODATE_DIF) && (todayAtMidn < json[i].GOODS_END_EXPODATE_DIF) && (json[i].GOODS_EXPO_FLAG == "Y") && (json[i].GOODS_SOLD_FLAG == "N") && (todayAtMidn < json[i].GOODS_ST_SELLDATE_DIF) && (todayAtMidn < json[i].GOODS_END_SELLDATE_DIF) && (json[i].GOODS_QUANTITY != 0)){
							seq[seq.length] = json[i].SEQ;
						}
					}
					if( !seq.length ){
						for(var i=0; i<json.length; i++){ // 판매중도 판매 예정인 상품이 없는 경우 매진 상품
							if((todayAtMidn > json[i].GOODS_ST_EXPODATE_DIF) && (todayAtMidn < json[i].GOODS_END_EXPODATE_DIF) && (json[i].GOODS_EXPO_FLAG == "Y")){
								seq[seq.length] = json[i].SEQ;
							}
						}
					}
				}
				
				if( seq.length ){
					random = seq[Math.floor(Math.random() * seq.length)];
				}
				
				for(var i=0; i<json.length; i++){
					if((todayAtMidn > json[i].GOODS_ST_EXPODATE_DIF) && (todayAtMidn < json[i].GOODS_END_EXPODATE_DIF) && (json[i].GOODS_EXPO_FLAG == "Y")){
						temp += "<div class=\"item\" onClick=\"javascript:goUrl('"+json[i].GOODS_URL+"','"+json[i].GOODS_COMPANY+"','"+json[i].SEQ+"');\" title=\"클릭 시 레이어팝업\">";
						if(json[i].GOODS_SOLD_FLAG == "Y" || todayAtMidn > json[i].GOODS_END_SELLDATE_DIF || json[i].GOODS_QUANTITY == 0){
							//temp += "<li class='soldout'>";
							//temp += "<a href='javascript:////'>";
							temp += "<span class='soldout'>SOLD OUT</span>";
						}else{
							if(todayAtMidn <= json[i].GOODS_ST_SELLDATE_DIF){
							//	temp += "<li class='soon'>";
							//	temp += "<a href='javascript:////'>";
								temp += "<span class='soon' style='display:none;'>"+json[i].GOODS_TAG+"</span>";
							}else{
								//temp += "<li class='attand'>";
								//temp += "<a href='javascript:////'>";
							}
						}
						//temp += "<div id='zoom_img'>";
						temp += "<img src=\"http://storage.enuri.gscdn.com/Web_Storage"+json[i].GOODS_BIG_IMG+"\" alt=\"\" />";
						
						//temp += "<span class='mall'>";
						if(json[i].GOODS_COMPANY != ""){
						//	temp += "<img src='http://imgenuri.enuri.gscdn.com/images/view/ls_logo/2013/Ap_logo_"+json[i].GOODS_COMPANY+".png'>";
						}else{
						//	temp += "&nbsp;";
						}
						//temp += "</span>";
						
						temp += "<div class='proinfo'>";
						temp += "<p class='proname'>"+json[i].GOODS_NAME+"</p>";
						
						temp += "<p class='proprice'>";
						
						if(json[i].GOODS_SALE_PER != ""){
							temp += "<span class='percen'>"+json[i].GOODS_SALE_PER+"%</span>";
						}
						if(json[i].GOODS_SALE_PRICE != ""){
							temp += "<span class='price'>"+numberWithCommas(json[i].GOODS_SALE_PRICE)+"<span class='won'>원</span></span>";
						}
						if(json[i].GOODS_PRICE != ""){
							temp += "<span class='bon'>"+numberWithCommas(json[i].GOODS_PRICE)+"원</span>";
						}
						temp += "</p>";
						
						/*
						temp += "<ul class='e_info'>";
						if(json[i].GOODS_ETC1 != ""){
							temp += "<li>"+json[i].GOODS_ETC1+"</li>";
						}
						if(json[i].GOODS_ETC2 != ""){
							temp += "<li>"+json[i].GOODS_ETC2+"</li>";
						}
						if(json[i].GOODS_ETC3 != ""){
							temp += "<li>"+json[i].GOODS_ETC3+"</li>";
						}
						if(json[i].GOODS_ETC4 != ""){
							temp += "<li>"+json[i].GOODS_ETC4+"</li>";
						}
						if(json[i].GOODS_ETC5 != ""){
							temp += "<li>"+json[i].GOODS_ETC5+"</li>";
						}
						*/
						temp += "<span class=\"btn_appbuy\"><img src=\"http://imgenuri.enuri.gscdn.com/images/event/2016/enurideal/btn_appbuy.gif\" alt=\"앱에서 구매하기\" /></span>";
						temp += "</div>";
						//temp += "</a>";
						temp += "</div>";
					}else{
						
					}
				}
			}
			$(".deal_goods").html(temp);
			
			if(json){
				for(var i=0; i<json.length; i++){
					if((todayAtMidn > json[i].GOODS_ST_EXPODATE_DIF) && (todayAtMidn < json[i].GOODS_END_EXPODATE_DIF) && (json[i].GOODS_EXPO_FLAG == "Y")){
						total = total + 1;
					}
				}
							
				if(total == 0){
					$('.deal_sm').remove();
				}else if(total >= 1 && total <= 3){
					//template += "<div class='innder_scroll three'>";
				//	template += "<div id='swiper' class='swiper-wrapper thumb'>";
				}else if(total == 4){
					//template += "<div class='innder_scroll four'>";
				//	template += "<div id='swiper' class='swiper-wrapper thumb'>";
				}else{
					//template += "<div class='innder_scroll'>";
				//	template += "<div id='swiper' class='swiper-wrapper thumb'>";
				}
				
				for(var i=0; i<json.length; i++){
					if((todayAtMidn > json[i].GOODS_ST_EXPODATE_DIF) && (todayAtMidn < json[i].GOODS_END_EXPODATE_DIF) && (json[i].GOODS_EXPO_FLAG == "Y")){
						template += "<div class='item' id=\"deal_s_"+ i +"\">";
						template += "<a href='javascript://////' onclick=\"javascript:$('.deal_goods').slick('slickGoTo', "+ i +", true);mini_deal_click('"+json[i].GOODS_NAME+"', '"+json[i].SEQ+"')\">";
						//template += "<a href='javascript://////' onclick=\"javascript:mini_deal_click('"+json[i].GOODS_NAME+"', '"+json[i].SEQ+"')\">";
						
						
						template += "<input type='hidden' name='seq' id='seq' class='seq' value=\""+json[i].SEQ+"\">";
						if(json[i].GOODS_SOLD_FLAG == "Y" || todayAtMidn > json[i].GOODS_END_SELLDATE_DIF || json[i].GOODS_QUANTITY == 0){
							template += "<span class='soldout'>SOLD OUT</span>";
							template += "<img src=\"http://storage.enuri.gscdn.com/Web_Storage"+json[i].GOODS_SMALL_IMG+"\" alt=\"\" width=210 height=210>";
							template += "<em class='pc'>"+numberWithCommas(json[i].GOODS_SALE_PER)+"%할인</em>";
							if(json[i].GOODS_SALE_PRICE == ""){
								template += "<em class='pr'>&nbsp;</em>";
							}else{
								template += "<em class='pr'>"+numberWithCommas(json[i].GOODS_SALE_PRICE)+"원</em>";
							}
						}else{
							if(todayAtMidn <= json[i].GOODS_ST_SELLDATE_DIF){
								template += "<span class='soon'>COMING SOON</span>";
								template += "<img src=\"http://storage.enuri.gscdn.com/Web_Storage"+json[i].GOODS_SMALL_IMG+"\" alt=\"\" width=210 height=210>";
								if(json[i].GOODS_TAG == ""){
									template += "<em class='pc'>&nbsp;</em>";
								}else{
									template += "<em class='pc'>"+json[i].GOODS_TAG+"</em>";
								}
								if(json[i].GOODS_PRICE == ""){
									if(json[i].GOODS_SALE_PRICE == ""){
										template += "<em class='pr'>&nbsp;</em>";
									}else{
										template += "<em class='pr'>"+numberWithCommas(json[i].GOODS_SALE_PRICE)+"원</em>";
									}
								}else{
									template += "<em class='pr'>"+numberWithCommas(json[i].GOODS_PRICE)+"원</em>";
								}
							}else{
								template += "<img src=\"http://storage.enuri.gscdn.com/Web_Storage"+json[i].GOODS_SMALL_IMG+"\" alt=\"\" width=210 height=210>";
								template += "<em class='pc'>"+json[i].GOODS_TAG+"</em>";
								if(json[i].GOODS_SALE_PRICE == ""){
									template += "<em class='pr'>&nbsp;</em>";
								}else{
									template += "<em class='pr'>"+numberWithCommas(json[i].GOODS_SALE_PRICE)+"원</em>";
								}
							}
						}
						template += "</a>";
						template += "</div>";
					}else{
						
					}
				}
			//	template += "</div>";
			//	template += "</div>";
			}
			//console.log(template);
			$('.deal_sm').html(template);
							/*					
			var obj = document.getElementsByName("seq"); 
			for(var i=0; i<obj.length; i++){
				if(obj[i].value == random){
					$(obj[i]).parent().parent().addClass("on").siblings().removeClass("on");
						//img_click(obj[i].value);
				} 
			}
			*/
		},
		error: function (xhr, ajaxOptions, thrownError) {

		}
	});
	
	/*
	$(".deal_goods").owlCarousel({
		items:1,
		navigation : true, // Show next and prev buttons
		slideSpeed : 300,
		paginationSpeed : 400,
		singleItem:true,
		loop:true,
		autoPlay:3000
	 });
	$(".deal_sm").owlCarousel({
		items : 4,
		lazyLoad : true,
		navigation : true,
		slideSpeed : 300
	}); 
	*/
	
	
	$('.deal_goods').slick({
		  slidesToShow: 1,
		  slidesToScroll: 1,
		  arrows: true,
		  fade: false,
		  speed: 200
	}).slick('slickPrev')
         .find("button").on('click', function(e) {
        	 
         var index = $('.deal_goods').slick("slickCurrentSlide");
         
       //  $("#swiper div").removeClass("on");
        // $("#deal_s_"+index).addClass("on");
         //$(".innder_scroll").scrollLeft(100);
         
         var position =  $("#deal_s_"+index).offset(); // 위치값
         
         var point = 125*index;
         
         $('.deal_sm').animate({ scrollLeft : point }, 800); // 이동
         
     });
	
	$('.deal_sm').slick({
		  slidesToShow: 4,
		  slidesToScroll: 4,
		  arrows: true,
		  fade: false,
		  speed: 200
	}).slick('slickPrev')
       .find("button").on('click', function(e) {
       var index = $('.deal_sm').slick("slickCurrentSlide");
       
      // $("#swiper div").removeClass("on");
      // $("#deal_s_"+index).addClass("on");
       //$(".innder_scroll").scrollLeft(100);
       
       var position =  $("#deal_s_"+index).offset(); // 위치값
       
       var point = 125*index;
       
       //$('.deal_sm').animate({ scrollLeft : point }, 800); // 이동
       
   });
	
	$('.deal_sm').on('swipe', function(event, slick, direction) { 
	    /*
        var index = $('.deal_goods').slick("slickCurrentSlide");
        
        $("#swiper div").removeClass("on");
        $("#deal_s_"+index).addClass("on");
        
        var position =  $("#deal_s_"+index).offset(); // 위치값
        var point = 125*index;
        
        $('.innder_scroll').animate({ scrollLeft : point }, 100); // 이동
*/
    });

                
    $('.deal_goods').on('swipe', function(event, slick, direction) { 
    /*
        var index = $('.deal_goods').slick("slickCurrentSlide");
        
        $("#swiper div").removeClass("on");
        $("#deal_s_"+index).addClass("on");
        
        var position =  $("#deal_s_"+index).offset(); // 위치값
        var point = 125*index;
        
        $('.innder_scroll').animate({ scrollLeft : point }, 100); // 이동
*/
    });
	
	$(".deal_sm").on('touchstart', function(e){
		if(window.android && android.onTouchStart){
			//window.android.onTouchStart();
		}else if( $("#ios").val()){
			
		}
	});
	
	$(".go_app").click(function(){	
		webInstall();
	});
		/*
	$( ".thumb div a" ).click(function() {
		$(this).parent().addClass("on").siblings().removeClass("on");
			//img_click($(this).children().val());
		return false;
	});*/
}

function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}		
			
function webInstall(param){
	var url;
	if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
		url = "https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8";
	}else if(navigator.userAgent.indexOf("Android") > -1){
		url = "market://details?id=com.enuri.android&referrer=utm_source%3Denuri%26utm_medium%3Denuri_deal%26utm_campaign%3Denuri";
	}	
	window.location.href = url;
}
			
function mini_deal_click(GOODS_NAME, SEQ){
	/*
	if($("input[name=seq][value="+SEQ+"]").parent().children().eq(1).attr("class") == "soldout"){
		
			ga('send', 'event', 'mf_enuri_deal_detail', 'mini_'+GOODS_NAME+'_APP', '판매완료');
			if(navigator.userAgent.indexOf("Android") > -1){ //App
				ga('send', 'event', 'mf_home', 'enuri_deal_mini', '[APP]'+GOODS_NAME+'_AOS');		
			}else if(navigator.userAgent.indexOf("iPhone") > -1){
				ga('send', 'event', 'mf_home', 'enuri_deal_mini', '[APP]'+GOODS_NAME+'_iOS');				 
			}else{
				ga('send', 'event', 'mf_home', 'enuri_deal_mini', '[APP]'+GOODS_NAME+'_etc');
			}
		
	}else if($("input[name=seq][value="+SEQ+"]").parent().children().eq(1).attr("class") == "soon"){
		
			ga('send', 'event', 'mf_enuri_deal_detail', 'mini_'+GOODS_NAME+'_APP', '판매예정');
			if(navigator.userAgent.indexOf("Android") > -1){ //App
				ga('send', 'event', 'mf_home', 'enuri_deal_mini', '[APP]'+GOODS_NAME+'_AOS');		
			}else if(navigator.userAgent.indexOf("iPhone") > -1){
				ga('send', 'event', 'mf_home', 'enuri_deal_mini', '[APP]'+GOODS_NAME+'_iOS');				 
			}else{
				ga('send', 'event', 'mf_home', 'enuri_deal_mini', '[APP]'+GOODS_NAME+'_etc');
			}
	}else{
		
			ga('send', 'event', 'mf_enuri_deal_detail', 'mini_'+GOODS_NAME+'_WEB', '판매중');
			if(navigator.userAgent.indexOf("Android") > -1){ //Web
				ga('send', 'event', 'mf_home', 'enuri_deal_mini', '[WEB]'+GOODS_NAME+'_AOS');	
			}else if(navigator.userAgent.indexOf("iPhone") > -1){
				ga('send', 'event', 'mf_home', 'enuri_deal_mini', '[WEB]'+GOODS_NAME+'_iOS');			 
			}else{
				ga('send', 'event', 'mf_home', 'enuri_deal_mini', '[WEB]'+GOODS_NAME+'_etc');
			}
		
	}
	*/
}

function goUrl(url,shopcode,goods_seq){
	var param = getQuerystring(url,'freetoken');
	if(param == 'outlink'){//outlink
		document.getElementById('buyApp').style.display='';
	}else if(param == 'event'){//event
		location.href = url;
	}
}

function getQuerystring(urlName, paramName){
	var urlName = decodeURIComponent(urlName);
	var _tempUrl = urlName.substring( urlName.indexOf('?')+1, urlName.length );
	var _tempArray = _tempUrl.split('&'); 
	
	for(var i = 0; _tempArray.length; i++) {
		var _keyValuePair = _tempArray[i].split('='); 
		
		if(_keyValuePair[0] == paramName){ 
			return _keyValuePair[1];
		}
	}
}
</script>
<script language="JavaScript" src="http://imgenuri.enuri.gscdn.com/common/js/Log_Tail.js"></script>