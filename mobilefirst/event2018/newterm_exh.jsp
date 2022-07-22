<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%
if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){
}else{
    response.sendRedirect("/event2018/newterm_exh.jsp");
}

String strApp = ChkNull.chkStr(request.getParameter("app"),"");

String chkId   = ChkNull.chkStr(request.getParameter("chk_id"),"");
String cUserId = cb.GetCookie("MEM_INFO","USER_ID");
String cUserNick = cb.GetCookie("MEM_INFO","USER_NICK");

Members_Proc members_proc = new Members_Proc();
String cUsername = members_proc.getUserName(cUserId);
String userArea = cUsername;

if(!cUserId.equals("")){
    cUsername = members_proc.getUserName(cUserId);
    userArea = cUsername;

    if(cUsername.equals("")) userArea = cUserNick;
    if(userArea.equals(""))  userArea = cUserId;
}
String subTab = ChkNull.chkStr(request.getParameter("subtab"));
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
	<link rel="stylesheet" type="text/css" href="/css/event/y2018/newterm_m.css?ver=20180226"/>
	<link rel="stylesheet" type="text/css" href="http://m.enuri.com/mobilefirst/css/lib/slick.css"/>
	<script type="text/javascript" src="http://m.enuri.com/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="http://m.enuri.com/mobilefirst/js/lib/slick.min.js"></script>
	<script src="/mobilefirst/js/lib/ga.js"></script>
</head>
<body>

<div class="wrap">
	
	<div class="myarea">
	<%if(cUserId.equals("")){%>	
	<p class="name">나의 e머니는 얼마일까?<button type="button" class="btn_login">로그인</button></p>	
	<%}else{%>
	<p class="name"><%=userArea%> 님<span id="my_emoney">0점</span></p>
	<%}%>
	<a href="javascript:///" class="win_close">창닫기</a>
	</div>
	
	<!-- 상단비주얼 -->
	<div class="visual">
		<ul class="tab__list">
			<li><a href="javascript:///" class="tab1"><i>기획전 : 새학기 필수템</i></a></li>
			<li><a href="javascript:///" class="tab2" onclick="goEventTab()"><i>이벤트 : 닌텐도 스위치 득템</i></a></li>
		</ul>
		<img src="http://imgenuri.enuri.gscdn.com/images/event/2018/newterm/m_visual.png" alt="새학기 필수템 100% 완벽준비" class="imgs" />
	</div>

	<div class="top_nav">
		<ul>
			<li class="nav1"><a href="#contArea1" class="movetab" onclick="ga('send', 'event', '새학기통합기획전' ,'button', '초등학생');"><i>유치원</i></a></li>
			<li class="nav2"><a href="#contArea2" class="movetab" onclick="ga('send', 'event', '새학기통합기획전' ,'button', '중고생');"><i>중고등학생</i></a></li>
			<li class="nav3"><a href="#contArea3" class="movetab" onclick="ga('send', 'event', '새학기통합기획전' ,'button', '대학생');"><i>대학생</i></a></li>
		</ul>
	</div>
	
	<!-- 이벤트 바로가기 영역 -->
		<div class="evt_area">
			<div class="contents">
				<span class="blind">앱에서 새학기 필수템 사고닌텐도 스위치 받자!</span>
				<a href="javascript:///" class="btn_go" target="_blank">이벤트 바로가기</a>
			</div>
		</div>
		<!-- //이벤트 바로가기 영역 -->

	<!-- 탭 컨텐츠 id #contArea1 -->
	<div id="contArea1" class="section priceListWrap">
		
		<div class="contents conts_gift1">
			<h2>두근두근 새로운발걸음 우리아이 첫시작 필수템</h2>
			<!-- liveProduct -->
			<div class="liveProduct">
				<ul class="tabs" id="navTab1">
					<li><a  class="t1" id="ttab1" data-id="1">첫시작 필수템 가방</a></li>
					<li><a  class="t2" id="ttab2" data-id="2">열공필수품 학용품</a></li>
					<li><a  class="t3" id="ttab3" data-id="3">공부도 척척! 학생가구</a></li>
					<li><a  class="t4" id="ttab4" data-id="4">엄마걱정마세요! 스마트워치</a></li>
				</ul>

				<!-- tab_container -->
				<div class="tab_container">
					<!-- tab1 -->
					<div id="tab1" class="tab_content" >
						<div class="lp_tabs_cont tab1">
						</div>
						<p class="moreview"><a href="javascript:///" class="btn_promore">상품 더보기</a></p>
					</div>
				</div>
				<!-- //tab_container -->
			</div>
			<!-- //liveProduct -->
		</div>
	</div>
	<!-- //탭 컨텐츠 id #contArea1 -->
	
	<!-- 탭 컨텐츠 id #contArea2 -->
	<div id="contArea2" class="section priceListWrap">
	
		<div class="contents conts_gift2">
			<h2>열정가득 설렘가득 빠질수 없는 중/고등생 필수템</h2>
			
			<!-- liveProduct -->
			<div class="liveProduct">
				<ul class="tabs" id="navTab2">
					<li><a  class="t1" id="ttab5" data-id="5">열공하자! 학용품</a></li>
					<li><a  class="t2" id="ttab6" data-id="6">간지작살 가방/신발</a></li>
					<li><a  class="t3" id="ttab7" data-id="7">집중력 상승! 학생가구</a></li>
					<li><a  class="t4" id="ttab8" data-id="8">인강필수템 테블릿PC</a></li>
				</ul>
				
				<!-- tab_container -->
				<div class="tab_container">
					<!-- tab5 -->
					<div id="tab2" class="tab_content">
						<div class="lp_tabs_cont tab2">
						</div>
						<p class="moreview"><a href="javascript:///" class="btn_promore">상품 더보기</a></p>
					</div>
				</div>
				<!-- //tab_container -->
			</div>
			<!-- //liveProduct -->
		</div>
		<!-- 탭 컨텐츠 id #contArea2 -->
	</div>
		<!-- 탭 컨텐츠 id #contArea3 -->
	<div id="contArea3" class="section priceListWrap">
	
		<div class="contents conts_gift3">
			<h2>설렘가득 대학생활 완벽준비 캠퍼스 필수아이템</h2>
			
			<!-- liveProduct -->
			<div class="liveProduct">
				<ul class="tabs" id="navTab3">
					<li><a class="t1" id="ttab9"  data-id="9">과제걱정NO! 노트북</a></li>
					<li><a class="t2" id="ttab10" data-id="10">나만의 it템 가방 / 신발</a></li>
					<li><a class="t3" id="ttab11" data-id="11">자기관리템 화장품/향수</a></li>
					<li><a class="t4" id="ttab12" data-id="12">자취방꾸미기 1인가구</a></li>
				</ul>
				<!-- tab_container -->
				<div class="tab_container">
					<!-- tab9 -->
					<div id="tab3" class="tab_content">
						<div class="lp_tabs_cont tab3"></div>
						<p class="moreview"><a href="javascript:///" class="btn_promore">상품 더보기</a></p>
					</div>
					<!-- //tab9 -->
				</div>
				<!-- //tab_container -->
			</div>
			<!-- //liveProduct -->
		</div>
		<!-- 탭 컨텐츠 id #contArea3 -->

	<!-- 기획전 배너 -->
	<div class="banner_market">
		<div class="contents">
			<h2>신학기 완벽준비를 위한 필수 2018년 신학기 기획전</h2>
			<div class="item_list">
				<ul class="sp_items">
					<li class="item"><a href="javascript:///" onclick="goPlan(1);" title="새탭열기" target="_blank"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/newterm/m_ban1.png" alt="신학기 가구대전" /></a></li>
					<li><a href="javascript:///"  onclick="goPlan(2);" title="새탭열기" target="_blank"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/newterm/m_ban2.png" alt="신학기 가방" /></a></li>
					<li><a href="javascript:///"  onclick="goPlan(3);" title="새탭열기" target="_blank"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/newterm/m_ban3.png" alt="신학기 잇템" /></a></li>
				</ul>
			</div>
		</div>
	</div>
	<!-- //기획전 배너 -->

	<!-- layer--> 
	<div class="layer_back" id="app_only" style="display:none;">
		<div class="appLayer">
			<h4>모바일 앱 전용 이벤트</h4>
			<a href="javascript:///" class="close" onclick="$('#app_only').hide();">창닫기</a>
			<p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br />에누리앱을 설치합니다.</p>
			<p class="btn_close"><button type="button">설치하기</button></p>
		</div>
	</div>
	<span class="go_top"><a href="javascript:///" >TOP</a></span>
</div>
</div>
</body>
	<script>
	function goEventTab(){
		ga('send', 'event', '새학기통합기획전' ,'button', '상단이벤트');
		location.href = "/mobilefirst/evt/newsemester_2018.jsp";
		return false;
	}
	
		// 상단 탭 이동
		$(document).on('click', '.top_nav ul > li > a.movetab', function(e) {
			var $anchor = $($(this).attr('href')).offset().top,
				$navHgt = $(".top_nav").height() + 30;

			$('html, body').stop().animate({scrollTop: $anchor - $navHgt}, 500);	
			e.preventDefault();
		});

		$(window).load(function(){
			var $nav = $(".top_nav"), // scroll tabs
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
						$nav.find("li").removeClass("on");
						$(".nav1").addClass("on");
					}else if($ares2 <= $currY && $ares3 > $currY){
						$nav.find("li").removeClass("on");
						$(".nav2").addClass("on");
					}else if($ares3 <= $currY){
						$nav.find("li").removeClass("on");
						$(".nav3").addClass("on");
					}
				} else{
					$nav.removeClass("_fixed");
					$nav.children().find("li").removeClass("on");
					$("#contArea1").css("margin-top", 0);
				}
			});
		});
		//선물 리스트
		$(document).ready(function() {
			
			var appYN = "<%=strApp%>";
			
			//닫기버튼
			$( ".win_close" ).click(function(){
				if(appYN == 'Y')			window.location.href = "close://";
				else			window.location.replace("/mobilefirst/index.jsp");
			});
			
			$("#navTab1 > li").click(function(){
				
				$("#navTab1 li").removeClass("active");
				
				$(this).addClass("active");
				var clas = $(this).children().attr("data-id");
				
				if(clas == 1)    	ga('send', 'event', '새학기통합기획전' ,'button', '초등탭_가방');
				else if(clas == 2)  ga('send', 'event', '새학기통합기획전' ,'button', '초등탭_학용품');
				else if(clas == 3)  ga('send', 'event', '새학기통합기획전' ,'button', '초등탭_학생가구');
				else if(clas == 4)  ga('send', 'event', '새학기통합기획전' ,'button', '초등탭_스마트워치');
					
				makeTab(clas);
				
			});
				
			$("#navTab2 > li").click(function(){
				
				$("#navTab2 li").removeClass("active");
				
				$(this).addClass("active");
				var clas = $(this).children().attr("data-id");
				
				if(clas == 5)      ga('send', 'event', '새학기통합기획전' ,'button', '중고탭_학용품');
				else if(clas == 6) ga('send', 'event', '새학기통합기획전' ,'button', '중고탭_가방/신발');
				else if(clas == 7) ga('send', 'event', '새학기통합기획전' ,'button', '중고탭_학생가구');
				else if(clas == 8) ga('send', 'event', '새학기통합기획전' ,'button', '중고탭_PC');
				makeTab(clas);
				
			});
			
			$("#navTab3 > li").click(function(){
				
				$("#navTab3 li").removeClass("active");
				$(this).addClass("active");
				var clas = $(this).children().attr("data-id");
				
				if(clas == 9)		ga('send', 'event', '새학기통합기획전' ,'button', '대학생탭_PC/노트북');
				else if(clas == 10)	ga('send', 'event', '새학기통합기획전' ,'button', '대학생탭_가방/신발');
				else if(clas == 11) ga('send', 'event', '새학기통합기획전' ,'button', '대학생탭_화장품/향수');
				else if(clas == 12) ga('send', 'event', '새학기통합기획전' ,'button', '대학생탭_1인가구');
				
				makeTab(clas);
			});
			getGoodsList();
			
			$('.sp_items').slick({
				dots:true,
				slidesToShow: 1,
				slidesToScroll: 1,
				autoplay: true,
				autoplaySpeed: 3000
			});
			$(".btn_go").click(function(){
				ga('send', 'event', '새학기통합기획전' ,'button', '구매이벤트');
				location.href = "/mobilefirst/evt/newsemester_2018.jsp?tab=2";
				return false;
			});
			ga('send', 'pageview', {'page': '/mobilefirst/event2018/newterm_exh.jsp',  'title': '전체PV'});
			
			getPoint();
			
		});
		
		var goodsList;
		function getGoodsList(){
			
			var getUrl = "/mobilefirst/evt/chuseok_201709_ajax.jsp?exh_id=11";
			
			$.ajax({
				type:"GET",
				url: getUrl,
				dataType: "JSON",
				success:function(json){
					
					goodsList = json;
					
					makeTab(1);
					makeTab(5);
					makeTab(9);
					
					$("#ttab1").parent().addClass("active");
					$("#ttab5").parent().addClass("active");
					$("#ttab9").parent().addClass("active");
					
				},complete : function(data) {
					//대표아이템 SLICK
					
					subTab = "<%=subTab%>";
					
					if(subTab != ""){
					
						if(subTab <= 4){
							$(".nav1 > a").trigger("click");
							
						}else if(subTab > 4 && subTab <= 8 ){
							$(".nav2 > a").trigger("click");
							
						}else if(subTab > 8 && subTab <= 12){
							$(".nav3 > a").trigger("click");
						}
					}
					//$("#ttab"+subTab).trigger("click");
					
		        }
			});
		}

		function getPoint(){
			$.ajax({ 
				type: "GET",
				url: "/mobilefirst/emoney/emoney_get_point.jsp",
				async: false,
				dataType:"JSON",
				success: function(json){
					remain = json.POINT_REMAIN;	//적립금
					$("#my_emoney").html(numberWithCommas(remain) +""+json.POINT_UNIT);	
				}
			});
		}
		$(".moreview").click(function() {
			
			var tabNum;
			$tabs = $(this).parent().parent().parent().find("ul.tabs");
			
			$.each($tabs.find("li"),function(i,v){
				var id = $(this).find("a").attr("id");
				if($(this).attr("class") == "active"){
					tabNum = id;
				}
			});
			
			if(tabNum == "ttab1"){
				ga('send', 'event', '새학기통합기획전' ,'button', '초등탭_상품더보기');
				window.open("/mobilefirst/list.jsp?cate=100103&freetoken=list");
				return false;
			}else if(tabNum == "ttab2"){
				ga('send', 'event', '새학기통합기획전' ,'button', '초등탭_상품더보기');
				window.open("/mobilefirst/list.jsp?cate=18012601&freetoken=list");
				return false;
			}else if(tabNum == "ttab3"){
				ga('send', 'event', '새학기통합기획전' ,'button', '초등탭_상품더보기');
				window.open("/mobilefirst/list.jsp?cate=126002&freetoken=list");
				return false;
			}else if(tabNum == "ttab4"){
				ga('send', 'event', '새학기통합기획전' ,'button', '초등탭_상품더보기');
				window.open("/mobilefirst/list.jsp?cate=030452&freetoken=list");
				return false;
			}else if(tabNum == "ttab5"){
				ga('send', 'event', '새학기통합기획전' ,'button', '중고탭_상품더보기');
				window.open("/mobilefirst/list.jsp?cate=180222&freetoken=list");
				return false;
			}else if(tabNum == "ttab6"){
				ga('send', 'event', '새학기통합기획전' ,'button', '중고탭_상품더보기');
				window.open("/mobilefirst/list.jsp?cate=09190509&freetoken=list");
				return false;
			}else if(tabNum == "ttab7"){
				ga('send', 'event', '새학기통합기획전' ,'button', '중고탭_상품더보기');
				window.open("/mobilefirst/list.jsp?cate=126006&freetoken=list");
				return false;
			}else if(tabNum == "ttab8"){
				ga('send', 'event', '새학기통합기획전' ,'button', '중고탭_상품더보기');
				window.open("/mobilefirst/list.jsp?cate=0305&freetoken=list");
				return false;
			}else if(tabNum == "ttab9"){
				ga('send', 'event', '새학기통합기획전' ,'button', '대학생탭_상품더보기');
				window.open("/mobilefirst/list.jsp?cate=0404&freetoken=list");
				return false;
			}else if(tabNum == "ttab10"){
				ga('send', 'event', '새학기통합기획전' ,'button', '대학생탭_상품더보기');
				window.open("/mobilefirst/list.jsp?cate=145520&freetoken=list");
				return false;
			}else if(tabNum == "ttab11"){
				ga('send', 'event', '새학기통합기획전' ,'button', '대학생탭_상품더보기');
				window.open("/mobilefirst/list.jsp?cate=0804&freetoken=list");
				return false;
			}else if(tabNum == "ttab12"){
				ga('send', 'event', '새학기통합기획전' ,'button', '대학생탭_상품더보기');
				window.open("/mobilefirst/list.jsp?cate=126010&freetoken=list");
				return false;
			}
			
		});
		function numberWithCommas(x) {   return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");		}
		function onoff(id) {var mid=document.getElementById(id);if(mid.style.display=='') 	mid.style.display='none';else mid.style.display='';}
		function openLayer(IdName){	var pop = document.getElementById(IdName);	pop.style.display = "block";}
		function closeLayer(IdName){	var pop = document.getElementById(IdName);		pop.style.display = "none";	}
		
		function goodsClick(modelno,tab){
			
			if(tab > 0 && tab <= 4)			ga('send', 'event', '새학기통합기획전' ,'button', '초등탭_상품');
			else if(tab > 4 && tab <= 8)	ga('send', 'event', '새학기통합기획전' ,'button', '중고탭_상품');	
			else if(tab > 8 && tab <= 12)	ga('send', 'event', '새학기통합기획전' ,'button', '대학생탭_상품');
			
			location.href = "/mobilefirst/detail.jsp?modelno="+modelno;
			return false;
		}

		
		function makeTab(tab){
			
			$.each(goodsList.T,function(i,v){
				var lihtml = "";
				
				if(tab == (i+1)){
					
					if(tab <= 4 )	lihtml +="<div class=\"items_area tab1\">";		
					else if( tab >= 5 && tab <= 8 )		lihtml +="<div class=\"items_area tab2\">";
					else						lihtml +="<div class=\"items_area tab3\">";
					
					$.each(v.GOODS,function(s,d){
						
						if( s!=0 && s % 4 == 0){
							
							lihtml += "</ul>"
							lihtml += "</div>";
						}
						
						if( s == 0 || s % 4 == 0){
							
							lihtml += "<div class=\"itembox\">";
							lihtml += "<ul class=\"itemlist\">";
						}
						lihtml += "<li class='goodsItem' onclick=\"goodsClick("+d.MODELNO+" , "+tab+"); \">";
						lihtml += "<a href=\"javascript:///\" target=\"_blank\" title=\"\" class=\"btn\">";
						lihtml += "<div class=\"imgs\">";
						lihtml += "<img src='"+d.GOODS_IMG+"' alt='' />";
						lihtml += "</div>";
						lihtml += "	<div class=\"info\">";
						lihtml += "		<p class=\"pname\">"+d.TITLE1+"</p>";
						lihtml += "		<p class=\"price\"><span class=\"lowst\">최저가</span><i>"+numberWithCommas(d.MINPRICE)+"</i>원</p>";
						lihtml += "	</div>";
						lihtml += "</a>";
						lihtml += "</li>";
						
					});
					
					lihtml += "</div>";
					
					if(tab <= 4 ){
						$(".lp_tabs_cont.tab1").html(lihtml);
						$(".items_area.tab1").slick({dots:true,slidesToScroll: 1});	
					}else if( tab >= 5 && tab <= 8 ){
						$(".lp_tabs_cont.tab2").html(lihtml);
						$(".items_area.tab2").slick({dots:true,slidesToScroll: 1});
					}else{
						$(".lp_tabs_cont.tab3").html(lihtml);
						$(".items_area.tab3").slick({dots:true,slidesToScroll: 1});
					}
				}
			});
		}
		
		function goPlan(num){
			
			ga('send', 'event', '새학기통합기획전' ,'button', '기획전배너');
			
			if(num == 1){
				location.href = "/mobilefirst/planlist.jsp?t=B_20180113070709";
			}else if(num == 2){
				location.href = "/mobilefirst/planlist.jsp?t=B_20180115070709";
			}else if(num == 3){
				location.href = "/mobilefirst/planlist.jsp?t=B_20180126045642";
			}
		}
	</script>
</html>