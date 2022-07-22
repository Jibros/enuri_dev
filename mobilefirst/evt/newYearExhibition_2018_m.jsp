<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.parser.ParseException"%>
<%@ page import="com.enuri.util.common.*"%>
<%@ page import="java.util.LinkedList"%>
<%@page import="java.io.*"%>
<%@ page import="java.util.*,java.text.*,java.net.*"%>
<%!
public static String Comma_won(String junsu) {
	String result_int = "0";
	if(junsu == null || junsu.equals("null")|| junsu.isEmpty() || junsu.equals("")){
		result_int = "0";
	}else{
		int inValues = Integer.parseInt(junsu);
		DecimalFormat Commas = new DecimalFormat("#,###");
		result_int = (String)Commas.format(inValues);
	}
	return result_int;
}
%>
<%
if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){
}else{
    response.sendRedirect("http://www.enuri.com/event2018/newYearExhibition_2018.jsp");
    return;
}

String chkId   = ChkNull.chkStr(request.getParameter("chk_id"),"");
String cUserId = cb.GetCookie("MEM_INFO","USER_ID");
String cUserNick = cb.GetCookie("MEM_INFO","USER_NICK");

Members_Proc members_proc = new Members_Proc();
String cUsername = members_proc.getUserName(cUserId);
String userArea = cUsername;

long cTime = System.currentTimeMillis();
SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMdd");
String sdt =dayTime.format(new Date(cTime));//진짜시간

//test
if( request.getServerName().equals("dev.enuri.com") && request.getParameter("sdt")!=null && !request.getParameter("sdt").equals("")){
 sdt= request.getParameter("sdt");
}

String strUrl = request.getRequestURI();

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

//탭 앵커
String tab = ChkNull.chkStr(request.getParameter("tab"),"0");

String strFb_title = "[에누리 가격비교]";
String strFb_description = "최저가만 찾지말고 알차게 누리세요! 복 받아가는 혜택 이벤트";
String strFb_img = "http://imgenuri.enuri.gscdn.com/images/mobilenew/images/enuri_logo_facebook200.gif";
String snsMsg = "[에누리 가격비교]\n누리야~ 추석을 부탁해!\n베스트 선물 고르고\n달토끼의 인절미 받으세요!";

JSONParser parser = new JSONParser();
JSONObject jsonObject = new JSONObject();
JSONArray jsonArray = new JSONArray();	// 제품의 json 배열
String referer = ChkNull.chkStr(request.getHeader("referer"));
String jsonUrl = "http://www.enuri.com/mobilefirst/evt/newyear_201801_ajax.jsp";

String result = "";
String line = null;
try {
	InputStreamReader isr = new InputStreamReader(new URL(jsonUrl).openStream(),"utf-8");
	BufferedReader br = new BufferedReader(isr); 

	while((line = br.readLine()) != null){
		result += line;
	}

}catch (MalformedURLException e) {
    e.printStackTrace();
} catch (IOException e) {
    e.printStackTrace();
}

try{
	if(result!=null){
		Object obj = parser.parse(result);
		jsonObject = (JSONObject) obj;
	}
} catch (ParseException e) {
	e.printStackTrace();
} 

JSONArray dataR = new JSONArray();
JSONArray dataT = new JSONArray();
JSONArray dataB = new JSONArray();
JSONArray dataL = new JSONArray();
dataR = (JSONArray)jsonObject.get("R");		// 상단 롤링 상품
dataT = (JSONArray)jsonObject.get("T");		// 탭별 대표상품, 상품리스트
dataB = (JSONArray)jsonObject.get("B");		// 기획전 배너
dataL = (JSONArray)jsonObject.get("L");		// 가격대별 추천선물
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
<link rel="stylesheet" type="text/css" href="/css/event/y2018/newyear_m.css"/>
<link rel="stylesheet" type="text/css" href="/mobilefirst/css/lib/slick.css"/>
<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/ejs.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/ga.js"></script>
<script type="text/javascript" src="/mobilefirst/js/utils.js"></script>
<script>

</script>
</head>
<body>

<div class="wrap">

	<div class="myarea">
        <p class="name">나의 e머니는 얼마일까?<button type="button" class="btn_login">로그인</button></p>
		<a href="javascript:///" class="win_close">창닫기</a>
	</div>

	<!-- 상단비주얼 -->
	<div class="visual">
		<ul class="tab__list">
			<li><a href="/mobilefirst/evt/newYearExhibition_2018_m.jsp" onclick="ga_log(1);" class="tab1"><i>기획전 : 복주고 복받는 선물세트</i></a></li>
			<li><a href="/mobilefirst/evt/newyear.jsp?tab=1&freetoken=eventclone" onclick="ga_log(1);" class="tab2"><i>이벤트 : 세뱃돈 받으세요~</i></a></li>
		</ul>
		<img src="http://imgenuri.enuri.gscdn.com/images/event/2018/newyear/m_visual.png" alt="2018 모두 이루어져라" class="imgs" />
	</div>

	<div class="top_nav">
		<ul>
			<li><a href="#contArea1" onclick="ga_log(2);" class="movetab nav1"><i>이거 하나면 돼 BEST 선물세트</i></a></li>
			<li><a href="#contArea2" onclick="ga_log(3);" class="movetab nav2"><i>가성비 쩌는 가격대별 선물세트</i></a></li>
			<li><a href="#contArea3" onclick="ga_log(4);" class="movetab nav3" title="페이지 이동"><i>즐거운 연휴 책임지는 설날맞이 e쿠폰</i></a></li>
		</ul>
	</div>

	<!-- 이벤트 바로가기 영역 -->
	<div class="evt_area">
		<span class="blind">[2018년 설맞이 구매혜택]</span>
			<ul class="blind">
				<li>하나. 황금개띠 순금바 받자!</li>
				<li>둘. e머니 2배 적립 혜택!</li>
			</ul>
		<a href="/mobilefirst/evt/newyear.jsp?tab=2&freetoken=eventclone" onclick="ga_log(5);" class="btn_go">이벤트 바로가기</a>
	</div>
	<!-- //이벤트 바로가기 영역 -->
	
	
	<!-- 탭 컨텐츠 id #contArea1 / BEST 선물세트 -->
	<div id="contArea1" class="section bestWrap">
		<div class="contents">
			<div class="dw_tit">
				<h2 class="title">Grate! 설날 BEST 선물세트</h2>
			</div>

			<!-- box_keyword -->
			<div class="box_keyword" id="box_keyword">
				<div class="txt_key"></div>
			</div>
			<!-- //box_keyword -->

			<div class="dw_slide_wrap">
				
				<!-- 슬라이드 VIEW dw_wrap -->
				<div class="dw_wrap">
					<div id="dwSlide" class="dw_detail"></div>

					<!--<div class="custom_arrow">
						<button type="button" class="prev_arrow">&lt;</button>
						<button type="button" class="next_arrow">&gt;</button>
					</div>-->
				</div>
				<!-- //슬라이드 VIEW dw_wrap -->

				<!-- 슬라이드 LIST dw_list -->
				<div id="dwList" class="dw_list"></div>
				<!-- //슬라이드 LIST dw_list -->
			</div>

		</div>
	</div>
	<!-- //탭 컨텐츠 id #contArea1 / BEST 선물세트 -->

	<%
	try{
		JSONObject dataJson2 = null;
		JSONArray goodsArr = null;
		if(dataT !=null){
			dataJson2 = (JSONObject)dataT.get(0);
			if(dataJson2 != null){
				goodsArr = (JSONArray)dataJson2.get("GOODS");
			}
		}
		if(goodsArr != null && goodsArr.size() > 0){
			if(goodsArr.size() > 0){
	%>
	<!-- 탭 컨텐츠 id #contArea2 / 가격맞춤 실속선물 -->
	<div id="contArea2" class="section priceListWrap">
		
		<div class="contents conts_gift1">
			<h2>가격부담 줄이고 만족은 높이고 가격맞춤 실속선물</h2>
			<!-- liveProduct -->
			<div class="liveProduct">
				<ul class="tabs">
					<li><a href="#tab1" onclick="ga_log(14);" class="t1">1만원 미만</a></li>
					<li><a href="#tab2" onclick="ga_log(15);" class="t2">1~3만원</a></li>
					<li><a href="#tab3" onclick="ga_log(16);" class="t3">3~5만원</a></li>
					<li><a href="#tab4" onclick="ga_log(17);" class="t4">5~10만원</a></li>
				</ul>
	
				<!-- tab_container -->
				<div class="tab_container">
					<!-- tab1 -->
					<%
					int tSize = 4;
					for(int i = 0; i < tSize; i++){
					%>
					<div id="tab<%=(i + 1)%>" class="tab_content">
						<div class="lp_tabs_cont">
							<ul></ul>
						</div>
					</div>
					<%}%>
					<!-- //tab1 -->
				</div>
				<!-- //tab_container -->
			</div>
			<!-- //liveProduct -->
		</div>
	</div>
	<%
			}
		}
	}catch(Exception e){
		e.printStackTrace();
	}
	%>
	<!-- //탭 컨텐츠 id #contArea2 / 가격맞춤 실속선물 -->
	
	<!-- 오픈마켓 배너 -->
	<div class="banner_market">
		<div class="contents">
			<h2>2018년 설날 기획전</h2>
			<span class="newy1"></span>
			<div class="item_list">
				<ul class="sul_items">
					<!-- <li class="item">
						<a href="http://www.11st.co.kr/connect/Gateway.tmall?method=Xsite&tid=1001235769" target="_blank" title="새탭열기">
							<img class="thumb" src="http://imgenuri.enuri.gscdn.com/images/event/2018/newyear/pc_market1.jpg" alt="" />
							<div class="proinfo">
								<span class="logo"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/newyear/pc_logo_11st.gif" alt="11번가" /></span>
								<strong class="tit">설마중 설빔준비</strong>
							</div>
						</a>
					</li>
					<li class="item">
						<a href="http://www.11st.co.kr/connect/Gateway.tmall?method=Xsite&tid=1001235767" target="_blank" title="새탭열기">
							<img class="thumb" src="http://imgenuri.enuri.gscdn.com/images/event/2018/newyear/pc_market2.jpg" alt="" />
							<div class="proinfo">
								<span class="logo"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/newyear/pc_logo_11st.gif" alt="11번가" /></span>
								<strong class="tit">인기명절선물세트</strong>
							</div>
						</a>
					</li>  -->
					<li class="item">
						<a href="http://rpp.gmarket.co.kr/?exhib=15329&jaehuid=805" target="_blank" title="새탭열기">
							<img class="thumb" src="http://imgenuri.enuri.gscdn.com/images/event/2018/newyear/pc_market3.jpg" alt="" />
							<div class="proinfo">
								<span class="logo"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/newyear/pc_logo_gmarket.gif" alt="G마켓" /></span>
								<strong class="tit">설 건강용품관</strong>
							</div>
						</a>
					</li>
					<li class="item">
						<a href="http://rpp.gmarket.co.kr/?exhib=16369&jaehuid=805" target="_blank" title="새탭열기">
							<img class="thumb" src="http://imgenuri.enuri.gscdn.com/images/event/2018/newyear/pc_market4.jpg" alt="" />
							<div class="proinfo">
								<span class="logo"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/newyear/pc_logo_gmarket.gif" alt="G마켓" /></span>
								<strong class="tit">설 생활선물관</strong>
							</div>
						</a>
					</li>
					<li class="item">
						<a href="http://banner.auction.co.kr/bn_redirect.asp?ID=BN00243900" target="_blank" title="새탭열기">
							<img class="thumb" src="http://imgenuri.enuri.gscdn.com/images/event/2018/newyear/pc_market5.jpg" alt="" />
							<div class="proinfo">
								<span class="logo"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/newyear/pc_logo_auction.gif" alt="옥션" /></span>
								<strong class="tit">설 브랜드선물관</strong>
							</div>
						</a>
					</li>
					<li class="item">
						<a href="http://banner.auction.co.kr/bn_redirect.asp?ID=BN00243898" target="_blank" title="새탭열기">
							<img class="thumb" src="http://imgenuri.enuri.gscdn.com/images/event/2018/newyear/pc_market6.jpg" alt="" />
							<div class="proinfo">
								<span class="logo"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/newyear/pc_logo_auction.gif" alt="옥션" /></span>
								<strong class="tit">설 마트선물관</strong>
							</div>
						</a>
					</li>
				</ul>
			</div>
		</div>

		<script>
			$('.sul_items').slick({
				dots:true,
				slidesToShow: 1,
				slidesToScroll: 1,
				autoplay: true,
				autoplaySpeed: 3000
			});
		</script>
	</div>
	<!-- //오픈마켓 배너 -->
	
	<%
	if(dataL != null && dataL.size() > 0){
	%>
	<!-- 탭 컨텐츠 id #contArea3 / 설날연휴 선물 -->
	<div id="contArea3" class="section priceListWrap">
	
		<div class="contents conts_gift2">
			<h2>기나긴 설날연휴 알차게보내는 즐거운 설날연휴</h2>
			<span class="newy1"></span>
			<span class="newy2"></span>
	
			<!-- liveProduct -->
			<div class="liveProduct">
				<ul class="tabs">
					<li><a href="#tab5" onclick="ga_log(19);" class="t1">외식</a></li>
					<li><a href="#tab6" onclick="ga_log(20);" class="t2">E쿠폰</a></li>
					<li><a href="#tab7" onclick="ga_log(21);" class="t3">게임</a></li>
					<li><a href="#tab8" onclick="ga_log(22);" class="t4">설빔</a></li>
				</ul>
				
				<!-- tab_container -->
				<div class="tab_container">
					<!-- tab5 -->
					<%
					String [] moreUrl = {
							"/mobilefirst/list.jsp?cate=164716"
						,	"/mobilefirst/list.jsp?cate=16471824"
						,	"/mobilefirst/list.jsp?cate=0408"
						,	"/mobilefirst/list.jsp?cate=101508"
					};
					for(int i = 0; i < dataL.size(); i++){
						JSONObject dataJson = (JSONObject)dataL.get(i);	
					%>
					<div id="tab<%=(i + 5)%>" class="tab_content">
						<h3 class="stitle"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/newyear/m_stit<%=(i+1)%>.gif" alt="사랑하는 가족과 함께 즐기는 맛있는 식사" /></h3>
						<div class="lp_tabs_cont">
							<ul>
								<%
								JSONArray goodsList = (JSONArray)dataJson.get("CMEX_GOODS");
								
								ArrayList mainRandomList = new ArrayList();
							  	Random ra = new Random();
							  	int mainSize= goodsList.size(); //사이즈 따로 구해서
							  	for(int k=0; k<mainSize ;k++){
								   int rv = ra.nextInt(goodsList.size());
								   mainRandomList.add(goodsList.get(rv));
								   goodsList.remove(rv);
							  	}
								
								int endSize = 4;
								if(mainRandomList.size() < 5){
									endSize = mainRandomList.size();
								}
								for(int k = 0; k < endSize; k++){
									JSONObject goodsJson = (JSONObject)mainRandomList.get(k);
								%>
								<li>
									<a href="/mobilefirst/detail.jsp?modelno=<%=goodsJson.get("MODELNO")%>&freetoken=vip" onclick="ga_log(23);" target="_blank" title="새 탭에서 열립니다." class="btn">
										<div class="imgs">
											<img class="lazy" data-original="<%=goodsJson.get("GOODS_IMG")%>" alt="" />
											<%if(Integer.parseInt(goodsJson.get("MINPRICE3").toString())<=0){ %>
												<em class="soldout">SOLDOUT</em>
											<%}%>
										</div>
										<div class="info">
											<p class="pname"><%=goodsJson.get("MODELNAME")%></p>
											<p class="price"><span class="lowst">최저가</span><i><%=Comma_won(goodsJson.get("MINPRICE3").toString())%></i>원</p>
										</div>
									</a>
								</li>
								<%}%>
							</ul>
						</div>
						<p class="moreview"><a href="<%=moreUrl[i]%>" target="_blank" class="btn_promore">상품 더보기</a></p>
					</div>
					<!-- //tab5 -->
					<%}%>
				</div>
				<!-- //tab_container -->
			</div>
			<!-- //liveProduct -->
		</div>
	</div>
	<%}%>
	<!-- 탭 컨텐츠 id #contArea3 / 설날연휴 선물 -->
	<!-- //전문관 기획전 -->

	<!--  기획전 배너 모음 -->
	<div class="section morebanWrap">
		<div class="contents">
			<h2>복 받아가는 혜택 이벤트</h2>
			<div class="banners">
				<a href="javascript:///" class="ban_01" title="출석체크 새탭열기" onclick="goEvent(1);">출석체크</a>
				<a href="javascript:///" class="ban_02" title="구매혜택 새탭열기" onclick="goEvent(2);">첫구매</a>
				<a href="javascript:///" class="ban_03" title="웰컴룰렛 새탭열기" onclick="goEvent(3);">매일룰렛</a>
				<a href="javascript:///" class="ban_04" title="크레이지딜 새탭열기" onclick="goEvent(4);">크레이지딜</a>
				<a href="http://m.enuri.com/mobilefirst/plan_event.jsp" onclick="ga_log(24);" class="ban_more" title="더 많은 이벤트 새탭열기" target="_blank">더 많은 이벤트</a>
			</div>

		</div>
	</div>
	<!-- //기획전 배너 모음 -->

	<!-- layer-->
	<div class="layer_back" id="app_only" style="display:none;">
		<div class="appLayer">
			<h4>모바일 앱 전용 이벤트</h4>
			<a href="javascript:///" class="close" onclick="$('#app_only').hide();">창닫기</a>
			<p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br />에누리앱을 설치합니다.</p>
			<p class="btn_close"><button type="button">설치하기</button></p>
		</div>
	</div>
	<!-- //layer-->
	<!-- //170919 퀵메뉴 추가 -->

	<span class="go_top"><a onclick="$(window).scrollTop(0);">TOP</a></span>

</div>
<%@ include file="/mobilefirst/event2016/event_footer.jsp" %>
<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/event_season.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/jquery.lazyload.min.js"></script>
<script>
var username = "<%=userArea%>"; //개인화영역 이름
var vChkId = "<%=chkId%>";
var vEvent_page = "<%=strUrl%>"; //경로
var vEvent_title="설날 통합기획전";
var rdoval = "1";
var working = false;

$(document).ready(function(){
	ga_log(1); //PV
	
	ga('send', 'pageview', {'page': vEvent_page,'title': '[모바일] '+ vEvent_title});

	//로그인시 개인화영역d
	if(islogin()){
		$("#user_id").text("<%=cUserId%>");
		getPoint();//개인e머니 내역 노출
	}

	$(".conts_gift1 .tab_content").hide(); 
	setRandomTab($(".conts_gift1 ul.tabs li"), 1);
	$(".conts_gift1 ul.tabs li").click(function() {
		$(".conts_gift1 ul.tabs li").removeClass("active"); 
		$(this).addClass("active");
		$(".conts_gift1 .tab_content").hide(); 
		var activeTab = $(this).find("a").attr("href"); 
		$(activeTab).fadeIn();
		return false;
	});

	$(".conts_gift2 .tab_content").hide(); 
	setRandomTab($(".conts_gift2 ul.tabs li"), 5);
	$(".conts_gift2 ul.tabs li").click(function() {
		$(".conts_gift2 ul.tabs li").removeClass("active"); 
		$(this).addClass("active");
		$(".conts_gift2 .tab_content").hide(); 
		var activeTab = $(this).find("a").attr("href"); 
		$(activeTab).fadeIn();
		return false;
	});
	
	//선물세트 세팅
	loadGiftSet();
	
	//가격대별
	getTabProdJson();
	
	$(".lazy").lazyload({
		placeholder : "http://imgenuri.enuri.gscdn.com/images/m_home/noimg.png",
        effect: 'fadeIn',
        effectTime : 200 ,
        threshold : 500
    });

});

function setRandomTab(obj, num){
	var rannum = generateRandom(0, 3);
	var tab = '<%=tab%>';
	if(tab>0 && tab<5) rannum = (tab-1); 
	else if(tab>4 && tab<9) rannum = (tab-5); 
	$.each(obj, function(Index, listData) {
		if(Index==rannum) {
			$(this).addClass("active").show();
			$("#tab"+(Index+num)).show();
		}
	});
}

var loading = false;
function loadGiftSet(){
	
	$.ajax({
		type : "post",
		url : "/mobilefirst/evt/newyear_201801_ajax.jsp",
		async: true,
		dataType : "json",
		success: function(json) {
			var html = "";
			var box_keywordObj = $("#box_keyword .txt_key");
			var rObj = json["R"];
			var rannum = generateRandom(0, rObj.length-1);
			if(rObj!=null && rObj.length>0){
				$.each(rObj, function(Index, listData) {
					var title = listData["TITLE1"];
					var ga_logNum = Index + 6;
					
					html +="<a href=\"javascript:void(0);\" onclick=\"ga_log("+ga_logNum+");\"";
					if(Index==rannum) html +=" class=\"on\"";
					html +="idx=\""+Index+"\">#"+title+"</a>";
				});
				
				if(html!=""){
					box_keywordObj.html(html);
					
					//초기셋팅
					viewGiftSetGoods(rObj[rannum]);
					
					box_keywordObj.find("a").click(function() {
						box_keywordObj.find("a").removeClass("on");
						$(this).addClass("on");
						var idx = $(this).attr("idx");
						if(loading){
							$('#dwSlide').slick('unslick');
							$('#dwList').slick('unslick');
						}
						viewGiftSetGoods(rObj[idx]);
					});
				}
			}
			
		},
		error: function (xhr, ajaxOptions, thrownError) {
			//alert(xhr.status);
			//alert(thrownError);
		}
	});
} 

function numComma(x) {
	if(x>0) return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	else return 0;
}

var generateRandom = function (min, max) {
  	var ranNum = Math.floor(Math.random()*(max-min+1)) + min;
  	return ranNum;
}

function viewGiftSetGoods(obj){
	var dwSlideObj = $("#dwSlide");
	var html2 = "";
	var dwListObj = $("#dwList");
	var html3 = "";
	var goodsObj = obj["GOODS"];
	shuffle(goodsObj);
	dwSlideObj.html("");
	dwListObj.html("");
	if(goodsObj!=null && goodsObj.length>0){
		$.each(goodsObj, function(pdIndex, pdlistData) {
			var img_src = pdlistData["IMG_SRC"];
			var goods_img = pdlistData["GOODS_IMG"];
			if(img_src =="") img_src = goods_img;
			var title1 = pdlistData["TITLE1"];
			var minprice = pdlistData["MINPRICE3"];
			var modelno = pdlistData["MODELNO"];
			if(minprice>0){
				html2 +="<div class=\"d_item\">";
				html2 +="	<div class=\"_photo\">";
				html2 +="		<div class=\"fade_list\">";
				html2 +="			<a href=\"/mobilefirst/detail.jsp?modelno="+modelno+"&freetoken=vip\" onclick=\"ga_log(12);\" target=\"_blank\"><img data-lazy=\""+img_src+"\" src=\"http://imgenuri.enuri.gscdn.com/images/m_home/noimg.png\" alt=\""+title1+"\" class=\"\"/>";
				html2 +="				<div class=\"pro_info\">";
				html2 +="					<span class=\"title cutPara\">"+title1+"</span>";
				html2 +="					<span class=\"discount\">최저가 <b>"+numComma(minprice)+"</b>원</span>";
				html2 +="				</div>";
				html2 +="			</a>";
				html2 +="		</div>";
				html2 +="	</div>";
				html2 +="</div>";
				
				html3 +="<div num=\""+pdIndex+"\" class=\"d_item active\" onclick=\"ga_log(13);\">";
				html3 +="	<div class=\"d_img\">";
				html3 +="		<span class=\"cover\"></span>";
				html3 +="		<img data-lazy=\""+img_src+"\" src=\"http://imgenuri.enuri.gscdn.com/images/m_home/noimg.png\" width=\"138\" height=\"138\" alt=\""+title1+"\" />";
				html3 +="	</div>";
				/*html3 +="	<div class=\"d_name\">";
				html3 +="		<span class=\"tit\">"+title1+"</span>";
				html3 +="		<span class=\"price\"><b>"+numComma(minprice)+"</b>원</span>";
				html3 +="	</div>";*/
				html3 +="</div>";
			}
			
		});
		
		if(html2!="" && html3!="") {
			dwSlideObj.html(html2);
			dwListObj.html(html3);
			
			$('#dwSlide').slick({
				slidesToShow: 1,
				slidesToScroll: 1,
				swipe: false,
				fade: true,
				dots: false,
				arrows: false,
				speed: 300,
				lazyLoad: 'ondemand',
				asNavFor: '#dwList'
			});

			// 딜 상품 목록 플리킹
			$('#dwList').slick({
				initialSlide: 0,
				slidesToShow: 4,
				slidesToScroll: 1,
				swipe: false,
				fade: false,
				arrows: true,
				speed: 150,
				lazyLoad: 'ondemand',
				asNavFor: '#dwSlide',
				//centerMode: true,
				focusOnSelect: true
			});
			loading = true;
			
		}
	}
}

function getTabProdJson(){
	var url = "/mobilefirst/evt/newyear_201801_ajax.jsp";
	var params;
	var callback = function(json){
		if(json!=null && typeof(json.T[0])!= "undefined"){
			jsonObj = json.T[0].GOODS;
			exhibitionList();
		}
	}
	$.get(url,params,callback,"json");
}


function exhibitionList(){
	var tabsList = jsonObj;
	if(tabsList.length > 0){
		
		shuffle(tabsList);
		var tab1Cnt = 0;
		var tab2Cnt = 0;
		var tab3Cnt = 0;
		var tab4Cnt = 0;
		
		$("#tab1, #tab2, #tab3, #tab4").find("ul").empty();
		$.each(tabsList,function(idx,val){
			var str = "";
			var tabNum = 0;
			var minPrice = val.MINPRICE3;
			var maxcnt = 6;
			if(minPrice == null || typeof minPrice == "undefined"){
				return true;
			}
			var targetTab = "";
			if((minPrice < 10000) && tab1Cnt < maxcnt){
				targetTab = "tab1";
				tabNum = tab1Cnt;
				++tab1Cnt;
			}else if((10000 <= minPrice && minPrice < 30000) && tab2Cnt < maxcnt){
				targetTab = "tab2";
				tabNum = tab2Cnt;
				++tab2Cnt;
			}else if((30000 <= minPrice && minPrice < 50000) && tab3Cnt < maxcnt){
				targetTab = "tab3";
				tabNum = tab3Cnt;
				++tab3Cnt;
			}else if((50000 <= minPrice ) && tab4Cnt < maxcnt){
				targetTab = "tab4";
				tabNum = tab4Cnt;
				++tab4Cnt;
			}else{
				return true;
			}
			

			str += "<li>";
			str += "	<a href='/mobilefirst/detail.jsp?modelno="+val.MODELNO+"&freetoken=vip' target='_blank' onclick=\"ga_log(18);\" title='새 탭에서 열립니다.' class='btn'>";
			str += "		<div class='imgs'>";
			str += "			<img class=\"lazy\" data-original='" + val.GOODS_IMG + "' alt='상품 이미지' />";
			if(minPrice<=0){
				str += "			<em class=\"soldout\">SOLDOUT</em>";
			}
			str += "		</div>";
			str += "		<div class='info'>";
			str += "			<p class='pname'>" + val.TITLE1 + " " + val.TITLE2 + "</p>";
			str += "			<p class='price'><span class=\"lowst\">최저가</span><i>" + numComma(String(minPrice)) + "</i>원</p>";
			str += "		</div>";
			str += "	</a>";
			str += "</li>";
			
				
			$("#"+targetTab).find("ul").append(str);
		});
		
		$(".lazy").lazyload({
			placeholder : "http://imgenuri.enuri.gscdn.com/images/m_home/noimg.png",
	        effect: 'fadeIn',
	        effectTime : 200 ,
	        threshold : 500
	    });
	}
}

//상단 탭 이동
$(document).on('click', '.top_nav ul > li > a.movetab', function(e) {
	var $anchor = $($(this).attr('href')).offset().top,
		$navHgt = $(".top_nav").height() + 30;

	$('html, body').stop().animate({scrollTop: $anchor - $navHgt}, 500);	
	e.preventDefault();
});

//탭 활성화
$(window).load(function(){
	var app = getCookie("appYN"); //app인지 여부
	
	//닫기버튼
	$( ".win_close" ).click(function(){
		if(app == 'Y'){
			window.location.href = "close://";
		}      
		else{
			window.location.replace("/mobilefirst/Index.jsp");
		}                    
	});

	$('a[href="#"]').click(function(event) {
	    event.preventDefault();      
	});
	
	// scroll tabs
	var $nav = $(".top_nav"), 
	$navTop = $nav.offset().top; 
	$myHgt = $(".myarea").height();

	$ares1 = $("#contArea1").offset().top - $nav.outerHeight(),
	$ares2 = $("#contArea2").offset().top - $nav.outerHeight();
	$ares3 = $("#contArea3").offset().top - $nav.outerHeight();
	
	// 상단 탭 position 변경 및 버튼 활성화
	$(window).scroll(function(){
		var $currY = $(this).scrollTop() + $myHgt // 현재 scroll
	
		if ($currY > $navTop) {
			$nav.addClass("_fixed");
			$("#contArea1").css("margin-top", $nav.outerHeight());
	
			if($ares1 <= $currY && $ares2 >= $currY){
				$nav.find("a").removeClass("on");
				$(".nav1").addClass("on");
			}else if($ares2 <= $currY && $ares3 > $currY){
				$nav.find("a").removeClass("on");
				$(".nav2").addClass("on");
			}else if($ares3 <= $currY){
				$nav.find("a").removeClass("on");
				$(".nav3").addClass("on");
			}
		} else{
			$nav.removeClass("_fixed");
			$("#contArea1").css("margin-top", 0);
		}
	});
	//$(".lp_tabs_cont img").load(function(){setTab();});
	
});

function setTab(){
	var tab = "<%=tab%>";
	var moveTab = "";
	$(function(){
		if(tab>0 && tab<5) moveTab = 2;
		else if(tab>4 && tab<9)  moveTab = 3;
		if(moveTab != ""){
			var $moveTabTop = $("#contArea" + moveTab).offset().top,
			$top_navHeight = $(".top_nav").height() + 30;

			$('html, body').stop().animate({scrollTop: $moveTabTop - $top_navHeight}, 500);	
		}
	});
}

function goEvent(param){
	ga_log(24);
	var vUrl = "";
	var app = getCookie("appYN");
	if(param == 1){
		vUrl = "/mobilefirst/evt/visit_event.jsp?tab=1&freetoken=event";
	}else if(param == 2){
		vUrl = "/mobilefirst/evt/welcome_event.jsp?tab=1&freetoken=event";
	}else if(param == 3){
		vUrl = "/mobilefirst/evt/visit_event.jsp?tab=2&freetoken=event";
	}else if(param == 4){
		vUrl = "/mobilefirst/evt/mobile_deal.jsp" + "?freetoken=eventclone";
	}else if(param == 5){
		if( app != "Y"){
			vUrl = "/mobilefirst/index.jsp#evt";
		}else{
			vUrl = "/mobilefirst/renew/plan.jsp?freetoken=main_tab|event";
		}
	}
	move(vUrl);
}

//ga
function ga_log(param){
	var vGa_label = "";
	if(param == 1)				vGa_label = "PV";
	else if(param == 2)			vGa_label = "상단탭 BEST선물세트";
	else if(param == 3)			vGa_label = "상단탭 실속선물세트";
	else if(param == 4)			vGa_label = "상단탭 설날맞이";
	else if(param == 5)			vGa_label = "구매이벤트";
	else if(param == 6)			vGa_label = "BEST선물_과일카테고리";
	else if(param == 7)			vGa_label = "BEST선물_가공카테고리";
	else if(param == 8)			vGa_label = "BEST선물_홍삼카테고리";
	else if(param == 9)			vGa_label = "BEST선물_화장품카테고리";
	else if(param == 10)		vGa_label = "BEST선물_안마기카테고리";
	else if(param == 11)		vGa_label = "BEST선물_상품권카테고리";
	else if(param == 12)		vGa_label = "BEST선물_대표상품";
	else if(param == 13)		vGa_label = "BEST선물_하단상품";
	else if(param == 14)		vGa_label = "탭_실속선물_1만원";
	else if(param == 15)		vGa_label = "실속선물탭 1~2만원";
	else if(param == 16)		vGa_label = "실속선물탭 3~4만원";
	else if(param == 17)		vGa_label = "실속선물탭 5만원";
	else if(param == 18)		vGa_label = "실속선물_상품";
	else if(param == 19)		vGa_label = "즐거운설날탭 외식";
	else if(param == 20)		vGa_label = "즐거운설날탭 e쿠폰";
	else if(param == 21)		vGa_label = "즐거운설날탭 게임";
	else if(param == 22)		vGa_label = "즐거운설날탭 설빔";
	else if(param == 23)		vGa_label = "즐거운설날_상품";
	else if(param == 24)		vGa_label = "즐거운설날_상품더보기";
	else if(param == 25)		vGa_label = "혜택이벤트_배너클릭";
	
	ga('send', 'event', 'mf_event', '설날 통합기획전', vGa_label);
	return false;
}	

function logo_error(obj){
	obj.src = "http://img.enuri.com/images/blank.gif";
	obj.height = "20px";
}

</script>
</body>

<script language="JavaScript" src="<%= ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
</html>
