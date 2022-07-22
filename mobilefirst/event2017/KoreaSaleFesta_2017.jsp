<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.event.every.Korea_Sale_Festa"%>
<%@page import="com.enuri.bean.mobile.Event_Lina_Proc"%>
<%
    String strGkind = cb.GetCookie("GATEP", "GKIND");
    String strGno = cb.GetCookie("GATEP", "GNO");
    String tab =  ChkNull.chkStr(request.getParameter("tab"));
    
    String strApp  = ChkNull.chkStr(request.getParameter("app"),"");
    
    Event_Lina_Proc event_Lina_Proc = new  Event_Lina_Proc(); 
    
    String uuid = ChkNull.chkStr(request.getParameter("chk_id"));
    String hCode = event_Lina_Proc.sha1("enuriShip");
    
    String shipCode = event_Lina_Proc.sha1(uuid);
    String shipCode_hcode = "";
    
    if(!uuid.equals("")){
        shipCode_hcode = event_Lina_Proc.sha1(shipCode+"enuriShip");
    }

if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){
}else{
    response.sendRedirect("/eventPlanZone/jsp/KoreaSaleFesta_2017.jsp");
}
%>
<html>
<head>
<title>에누리(가격비교) eNuri.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="최저가 에누리 - 가격비교 사이트 에누리닷컴입니다."> 
<meta name="keyword" content="휴대폰, 사무, 생활가전, 용품, 영상음향, 컴퓨터, 자동차, 명품, 잡화, 스포츠, 유아, 완구, 가구, 화장품, 식품, 가격비교, 쇼핑몰, 최저가">
<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<meta name="format-detection" content="telephone=no">

<script type="text/javascript" src="http://m.enuri.com/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
<script type="text/javascript"src="/mobilefirst/js/lib/jquery.cookie.js"></script>
<script type="text/javascript" src="http://cdn.jsdelivr.net/jquery.slick/1.6.0/slick.min.js"></script>
<script type="text/javascript" src="http://jsgetip.appspot.com"></script><!-- IP() CLIENT 아이피 가져오기-->
<script type="text/javascript">
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
//런칭할때 UA-52658695-3 으로 변경
ga('create', 'UA-52658695-3', 'auto');
</script>
<script type="text/javascript">
//레이어
function onoff(id) {
	var mid=document.getElementById(id);
	if(mid.style.display=='') {
	mid.style.display='none';
}else{
	mid.style.display='';
	}; 
}
$(function(){
   var menupos = $("#topFix").offset().top;
   $(window).scroll(function(){
		var ht = $("#topFix").outerHeight(true) + 1;
		var sc = $(window).scrollTop() + ht;
		if(sc >= menupos + ht) {
			$("#topFix").css("position","fixed");
			$("#topFix").css("top","0");
			$("#topFix .win_close").show();
			} else {
			$("#topFix").css("position","absolute");
			$("#topFix").css("top","");
			$("#topFix .win_close").hide();
		};
		if(sc > 0 && sc <= $("#con2").offset().top){
			$("#topFix li").removeClass("on");
			$("#topFix li:eq(0)").addClass("on");
		}else if(sc > $("#con2").offset().top){
			$("#topFix li").removeClass("on");
			$("#topFix li:eq(1)").addClass("on");
		}
   });

	$("#topFix li").click(function(){
		var idx = $(this).index();
		var ht = $("#topFix").outerHeight(true);
		//$("body").animate({"scrollTop":},500)
		$('html, body').animate({
            scrollTop: parseInt($("#con"+(idx+1)).offset().top - ht)
        }, 500);
		return false;
	})
	
	$('.slider').slick({
	  infinite: true,
	  slidesToShow: 2,
	  slidesToScroll: 2
	});

	$('.bn_slide').slick({
	  infinite: true,
	  slidesToShow: 1,
	  slidesToScroll: 1,
	  autoplay:true,
	  autoplaySpeed:5000,
	  adaptiveHeight:true
	});
	//2016-09-13
	$(".btn_info").click(function(){
		$(".over_ht").height($(document).height());   
	})
	$(".win_close").click(function(){
        if($.cookie('appYN') == 'Y' ){
            window.location.href = "close://";
        }else{
            window.location.replace("/mobilefirst/Index.jsp");
        }
    });
});
</script>
<script>
$(document).ready(function(){
	ga('send', 'pageview', {
	    'page': '/mobilefirst/event2017/KoreaSaleFesta_2017.jsp',
	    'title': '메가쇼핑 페이지뷰'
	}); 
});
// 메가세일 
function logGo(code,flag){
    $.ajax({
        type: "GET", 
        url: "/mobilefirst/ajax/eventAjax/ajax_log_ins_proc.jsp?code="+code+"&flag="+flag+"&ip="+ip()+"&eventId=2017092801",
        async: true,
        dataType:"JSON",   
        success: function(json){

        }
    });   
}

// 히트브랜드
function hitbrandLogMO(uniqueCode){
	// 히트브랜드 logFlag = H
	var url = "/mobilefirst/event2016/ajax/ajax_click_proc.jsp";
	var params = "uniqueCode=" + uniqueCode + "&logFlag=H&device=M&eventId=2017061201";
	$.post(url,params);
}
</script>
<link rel="shortcut icon" href="<%=ConfigManager.IMG_ENURI_COM%>/2014/layout/favicon_enuri.ico">
<link rel="stylesheet" type="text/css" href="http://dev.enuri.com/mobilefirst/css/home/gnb.css"/>
<link rel="stylesheet" type="text/css" href="http://dev.enuri.com/mobilefirst/css/home/default.css"/>
<link rel="stylesheet" type="text/css" href="http://m.enuri.com/mobilefirst/css/home/footer.css">
<link rel="stylesheet" type="text/css" href="http://cdn.jsdelivr.net/jquery.slick/1.6.0/slick.css"/>
<link rel="stylesheet" type="text/css" href="/css/event/m_korea_sale_festa.css">

</head>

<body>
	<div class="layer_back" id="benefit_layer" style="display:none;">
		<div class="appLayer">
			<h4>모바일 앱 전용 쇼핑 혜택</h4>
			<a href="javascript:///" class="close" onclick="onoff('benefit_layer')">창닫기</a>
			<p class="txt">에누리 앱(APP) 설치 후<br />e머니 적립내역 확인 및<br />다양한 e쿠폰 상품으로 교환할 수 있습니다.</p>
			<p class="btn_close"><button type="button">설치하기</button></p>
		</div>
	</div>

	<div class="event_wrap">
		<a href="#" class="win_close">창닫기</a>
		<!-- visual -->
		<div class="section visual">
			<div class="contents">
				<img src="<%=ConfigManager.IMG_ENURI_COM%>/images/event/2016/korea_sale_festa/visual_m.png" alt="" />
			</div>
		</div>
		<!-- //visual -->
	
		<!-- tab_area -->
		<div id="topFix" class="tab_area" style="position: absolute;">
			<div class="inner">
				<ul class="tabmenu">
					<li class="tab1 on"><a class="btn" href="#con1">메가 세일상품</a></li>
					<li class="tab2"><a class="btn" href="#con2">메가 히트상품</a></li>
				</ul>
			</div>
			<a href="#" class="win_close">창닫기</a>
		</div>
		<!-- //tab_area -->
		
		<!-- 메가세일 -->
		<div id="con1" class="section">
			<h3>대한민국 진짜 최저가! 메가 세일상품</h3>
			<div class="contents">
				<ul class="itemlist">
					<%
					for(Map<String, String> resultMap : new Korea_Sale_Festa().getKSF_GoodsList("2017092801")){
						double priceAvg = Integer.parseInt(resultMap.get("priceAvg").replaceAll(",", "").trim());
						double price = Integer.parseInt(resultMap.get("price").replaceAll(",", "").trim());
						int salePercent = (int) Math.round(((1 - price / priceAvg) * 100));
						
						String goodsType = resultMap.get("goods_type");
						String strUrl = resultMap.get("url");
						String goodsCode = resultMap.get("goods_code");
						String caCode = resultMap.get("ca_code");
						String ksfgNo = resultMap.get("ksfg_no");
						String moveUrl = "";
						if("V".equals(goodsType)){
							moveUrl = "/mobilefirst/detail.jsp?modelno=" + goodsCode;
							moveUrl = "location.href = '" + moveUrl + "';";
						}else{
							if(strUrl.indexOf("http://") > -1){
								moveUrl = strUrl;
							}else{
								moveUrl = "http://" + strUrl;
							}
							if(strUrl.indexOf("?") > -1){
								moveUrl = moveUrl + "&freetoken=outlink";
								
							}else{
								moveUrl = moveUrl + "?freetoken=outlink";
								
							}
							
							moveUrl = "window.open('" + moveUrl + "');";
						}
						moveUrl += "logGo('" + ksfgNo + "','G');";
						
						
					%>
					<li onclick="<%=moveUrl%>">
						<div class="inner">
							<div class="img_box"><img src="http://storage.enuri.gscdn.com/pic_upload/exhibition/<%=resultMap.get("goods_img")%>" alt="" width="236.5" height="236.5"/></div>
							<div class="txt_box">
								<strong class="tit"><%=resultMap.get("modelname")%></strong>
								<div class="price">
									<%if(priceAvg > 0){%>									
									<span class="sale"><%=salePercent%>%</span>
									<p>
										<del><%=resultMap.get("priceAvg")%>원</del>
										<%=resultMap.get("price")%><span>원</span>
									</p>
									<%}else{%>									
									<em>핫세일특가</em>                                  
									<p><%=resultMap.get("price")%><span>원</span></p>                                               
									<%}%>									
								</div>
							</div>
						</div>
					</li>
					<%						
					}
					%>
					
				</ul>
			</div>
		</div>
		<!-- //메가세일 -->
	
		<!-- 메가히트 -->
		<div id="con2" class="section">
			<div class="contents">
				<h3>대한민국 진짜 최저가! 메가 세일상품</h3>
				<h4><span>디지털</span></h4>
				<ul class="itemlist slider">
					<%
					for(Map<String, String> resultMap : new Korea_Sale_Festa().getHitBrandList("digital","2017061201")){
						if(!"0".equals(resultMap.get("minprice3_mobile"))){
							String modelno = resultMap.get("modelno");
							String hitBrandNo = resultMap.get("hit_brand_no");
							String moveUrl = "location.href = '/mobilefirst/detail.jsp?modelno=" + modelno + "';";
							
							moveUrl += "hitbrandLogMO('" + hitBrandNo + "');";
					%>
					<li onclick="<%=moveUrl%>">
						<div class="inner">
							<div class="img_box"><img src="http://storage.enuri.gscdn.com/pic_upload/exhibition/<%=resultMap.get("goods_image")%>" alt="" width="237" height="237"/></div>
							<div class="txt_box">
								<strong class="tit2"><%=resultMap.get("choice_part")%><span>부문</span></strong>
								<span class="name"><%=resultMap.get("modelname")%></span>
								<div class="price">
									<em>최저가</em>
									<p><%=resultMap.get("minprice3_mobile")%><span>원</span></p>
								</div>
							</div>
						</div>
					</li>
					<%
						}
					}
					%>
				</ul>
	
				<div class="line"></div>
				<h4><span>가전</span></h4>
	
				<ul class="itemlist slider">
					<%
					for(Map<String, String> resultMap : new Korea_Sale_Festa().getHitBrandList("appliance","2017061201")){
						if(!"0".equals(resultMap.get("minprice3_mobile"))){
							String modelno = resultMap.get("modelno");
							String hitBrandNo = resultMap.get("hit_brand_no");
							String moveUrl = "location.href = '/mobilefirst/detail.jsp?modelno=" + modelno + "';";
							moveUrl += "hitbrandLogMO('" + hitBrandNo + "');";
					%>
					<li onclick="<%=moveUrl%>">
						<div class="inner">
							<div class="img_box"><img src="http://storage.enuri.gscdn.com/pic_upload/exhibition/<%=resultMap.get("goods_image")%>" alt="" width="237" height="237"/></div>
							<div class="txt_box">
								<strong class="tit2"><%=resultMap.get("choice_part")%><span>부문</span></strong>
								<span class="name"><%=resultMap.get("modelname")%></span>
								<div class="price">
									<em>최저가</em>
									<p><%=resultMap.get("minprice3_mobile")%><span>원</span></p>
								</div>
							</div>
						</div>
					</li>
					<%
						}
					}
					%>
				</ul>
	
				<div class="line"></div>
				<h4><span>컴퓨터</span></h4>
	
				<ul class="itemlist slider">
					<%
					for(Map<String, String> resultMap : new Korea_Sale_Festa().getHitBrandList("computer","2017061201")){
						if(!"0".equals(resultMap.get("minprice3_mobile"))){
							String modelno = resultMap.get("modelno");
							String hitBrandNo = resultMap.get("hit_brand_no");
							String moveUrl = "location.href = '/mobilefirst/detail.jsp?modelno=" + modelno + "';";
							moveUrl += "hitbrandLogMO('" + hitBrandNo + "');";
					%>
					<li onclick="<%=moveUrl%>">
						<div class="inner">
							<div class="img_box"><img src="http://storage.enuri.gscdn.com/pic_upload/exhibition/<%=resultMap.get("goods_image")%>" alt="" width="237" height="237"/></div>
							<div class="txt_box">
								<strong class="tit2"><%=resultMap.get("choice_part")%><span>부문</span></strong>
								<span class="name"><%=resultMap.get("modelname")%></span>
								<div class="price">
									<em>최저가</em>
									<p><%=resultMap.get("minprice3_mobile")%><span>원</span></p>
								</div>
							</div>
						</div>
					</li>
					<%
						}
					}
					%>
				</ul>
	
				<div class="line"></div>
				<h4><span>라이프</span></h4>
	
				<ul class="itemlist slider">
					<%
					for(Map<String, String> resultMap : new Korea_Sale_Festa().getHitBrandList("life","2017061201")){
						if(!"0".equals(resultMap.get("minprice3_mobile"))){
							String modelno = resultMap.get("modelno");
							String hitBrandNo = resultMap.get("hit_brand_no");
							String moveUrl = "location.href = '/mobilefirst/detail.jsp?modelno=" + modelno + "';";
							moveUrl += "hitbrandLogMO('" + hitBrandNo + "');";
					%>
					<li onclick="<%=moveUrl%>">
						<div class="inner">
							<div class="img_box"><img src="http://storage.enuri.gscdn.com/pic_upload/exhibition/<%=resultMap.get("goods_image")%>" alt="" width="237" height="237"/></div>
							<div class="txt_box">
								<strong class="tit2"><%=resultMap.get("choice_part")%><span>부문</span></strong>
								<span class="name"><%=resultMap.get("modelname")%></span>
								<div class="price">
									<em>최저가</em>
									<p><%=resultMap.get("minprice3_mobile")%><span>원</span></p>
								</div>
							</div>
						</div>
					</li>
					<%
						}
					}
					%>
				</ul>
			</div>
		</div>
		<!-- //메가히트 -->
		
	</div>
	<!--// 모바일 이벤트 푸터 -->
	<%@ include file="/mobilefirst/event2016/event_footer.jsp"%>
</body>
</html>
<script language="JavaScript" src="<%=ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>