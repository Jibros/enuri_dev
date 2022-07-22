<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.mobile.Reward_Data"%>
<%@ page import="com.enuri.bean.mobile.Emoney_Proc"%>
<jsp:useBean id="Reward_Data" class="com.enuri.bean.mobile.Reward_Data" scope="page" />
<jsp:useBean id="Emoney_Proc" class="com.enuri.bean.mobile.Emoney_Proc" scope="page" />
<%
String cUserId = cb.GetCookie("MEM_INFO","USER_ID");
String cUserNick = cb.GetCookie("MEM_INFO","USER_NICK");

String strChk_id = ChkNull.chkStr(request.getParameter("chk_id"),"");
String strPath = ChkNull.chkStr(request.getParameter("path"),"");
//ssl로 redirect 
String strHost = ChkNull.chkStr(request.getRequestURL().toString(), "");
if (strHost.indexOf("http://dev.enuri.com/") > -1 ) {
	response.sendRedirect("https://dev.enuri.com/mobilefirst/emoney/emoney_store.jsp");
	return;
}
if (strHost.indexOf("http://m.enuri.com/") > -1 || strHost.indexOf("http://www.enuri.com/") > -1) {
	response.sendRedirect("https://m.enuri.com/mobilefirst/emoney/emoney_store.jsp");
	return;
}
Cookie[] carr = request.getCookies();
String strAppyn = "";
String strVerios = "";
String strVerand = "";
String strAd_id = "";
int intVerios = 0;
int intVerand = 0;
try {
	for(int i=0;i<carr.length;i++){
	    if(carr[i].getName().equals("appYN")){
	    	strAppyn = carr[i].getValue(); 
	    	break;
	    }
	}
	for(int i=0;i<carr.length;i++){
	    if(carr[i].getName().equals("verios")){
	    	strVerios = carr[i].getValue();
	    	break;
	    }
	}
	for(int i=0;i<carr.length;i++){
	    if(carr[i].getName().equals("verand")){
	    	strVerand = carr[i].getValue();
	    	break;
	    }
	}
	for(int i=0;i<carr.length;i++){
	    if(carr[i].getName().equals("adid")){
	    	strAd_id = carr[i].getValue();
	    	break;
	    } 
	}
} catch(Exception e) { 
}

   int i_Log = 5941;
   int i_Log_pad = 0;
   if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") >= 0){
       i_Log = 5940;
   }else if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") >= 0 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") >= 0){
       i_Log = 5939;
   }else if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") >= 0){
       i_Log = 5939;
       i_Log_pad = 1;
   }else{ 
       i_Log = 5941;
   }
String szRemoteHost = request.getRemoteHost().trim();
if(!strAppyn.equals("Y") && szRemoteHost.indexOf("58.234.199.")<0){
	//response.sendRedirect("/m/index.jsp");
	//return; 
}  
if(strVerios.length() > 5) {
	strVerios = strVerios.substring(0, 5).replace(".","");		
}else{
	strVerios = strVerios.replace(".", "");
}
if(strVerand.length() > 0){
	strVerand = strVerand.replace(".","");
}
   

   //상품정보 Bar 3.2.0 부터 사라짐 app에서만
   boolean blTopbar_show = true;

   try{
    if(strAppyn.equals("Y")){
        if(i_Log == 5940){
        	intVerand = Integer.parseInt(strVerand);
            if(intVerand >= 320){
                blTopbar_show = false;
            }
        }else if(i_Log == 5939){
        	intVerios = Integer.parseInt(strVerios);
            if(intVerios >= 320){
                blTopbar_show = false;
            }
        }
    }
   }catch(Exception e){}
   
//쿠프 정기정검
long cTime = System.currentTimeMillis(); 
SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMddHHmm");
String nowDt = dayTime.format(new Date(cTime));

String strStart_time = "202111240130";
String strEnd_time =   "202111240630";

boolean blTime_check = false;

//특정상품 하나만 걸때
String strStart_time_sub = "201708312349";
String strEnd_time_sub =   "201709010059";

//테스트
//strStart_time_sub = "201708310957";
//strEnd_time_sub =   "201709011030";

//System.out.println("nowDt>>>>>>>>>>>>"+nowDt);
//System.out.println("strStart_time>>>>"+strStart_time);
//System.out.println("strEnd_time>>>>>>"+strEnd_time);

String strDomain = "https://m.enuri.com";
if (request.getRequestURL().indexOf("dev.enuri.com") > -1){
	strDomain = "https://dev.enuri.com";
}

if((Long.parseLong(nowDt) > Long.parseLong(strStart_time)) && (Long.parseLong(nowDt) < Long.parseLong(strEnd_time))){
	//System.out.println("11111");
	blTime_check = true;
	out.println("<script>");
	out.println("	alert(\'※시스템 점검 안내※\\n안정적이고 보다 나은 서비스 제공을 위해\\n시스템 점검 중입니다.\\n점검 중에는 쿠폰 교환, 환불, 사용이 제한됩니다.\');");
	if(!strAppyn.equals("Y")){
		out.println("	window.close();");	
	}else{
		out.println("	location.href='close://'");
	}
	out.println("</script>");
	return;
}else{
%> 
<!DOCTYPE html> 
<html lang="ko">
<head>
	<meta charset="utf-8">	
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />	
	<meta property="og:title" content="에누리 가격비교">
	<meta property="og:description" content="에누리 모바일 가격비교">
	<meta property="og:image" content="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilenew/images/logo_enuri.png">
	<meta name="format-detection" content="telephone=no" />
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/default.css">
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/emoney.css">
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery.cookie.js"></script>
	<script>
	(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
		(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
		m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
		})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
		//런칭할때 UA-52658695-3 으로 변경
		ga('create', 'UA-52658695-3', 'auto');
		
		ga('send', 'pageview', {
			'page': '/mobilefirst/emoney/emoney_store.jsp',
			'title': 'emoney_coupon (store)'
		});
	</script>
</head>
<body>
<div class="wrap">
	<%if(!strAppyn.equals("Y")){%>
	<header id="header" class="page_header nomargin header_top_fixed">
		<div class="header_top">
			<div class="wrap">
				<button class="btn__sr_back comm__sprite2"><i class="icon_arrow_back comm__sprite2">뒤로</i></button>
				<div class="header_top_page_name">e머니 사용하기</div>
			</div>
		</div>
	</header>
	<div class="fixed_top_empty"></div>
	<%}%>
	<section class="top" style="display:none;">
		<h1>사용가능 <span>e</span>머니</h1>
		<div class="my_e"></div>
		<nav>
			<ul class="sgnb">
				<li id="saving">적립내역</li>
				<li id="store" class="on">스토어</li>
				<li id="couponbox">쿠폰함</li>
				<li id="notice">혜택안내</li>
			</ul>
		</nav> 
	</section>
	<ul class="cate">
		<li  id="cate_5"><a href="#group_5"><span>커피/음료</span></a></li>
		<li  id="cate_1"><a href="#group_1"><span>편의점</span></a></li> 
		<li  id="cate_3"><a href="#group_3"><span>라이프</span></a></li>
		<li  id="cate_4"><a href="#group_4"><span>외식</span></a></li>
		<li  id="cate_2"><a href="#group_2"><span>케익/도넛</span></a></li>
	</ul>  
	<div class="shop_contents">
		<div id="popularList"></div>
		<div id="itemtList"></div>
	</div>
	<%@ include file="/mobilefirst/event2016/event_footer.jsp"%>
</div>
</body>
</html>
<script>
var spin_opts = {
	lines: 5, // The number of lines to draw
	length: 30, // The length of each line
	width: 4, // The line thickness
	radius: 10, // The radius of the inner circle
	corners: 1, // Corner roundness (0..1)
	rotate: 0, // The rotation offset
	color: '#000', // #rgb or #rrggbb
	speed: 1, // Rounds per second
	trail: 60, // Afterglow percentage
	shadow: false, // Whether to render a shadow
	hwaccel: false, // Whether to use hardware acceleration
	className: 'spinner', // The CSS class to assign to the spinner
	zIndex: 2e9, // The z-index (defaults to 2000000000)
	top: 'auto', // Top position relative to parent in px
	left: 'auto' // Left position relative to parent in px
};
 
$.fn.spin = function(spin_opts) {
	this.each(function() {
		var $this = $(this), 
			data = $this.data(); 

		if (data.spinner) {
			data.spinner.stop();
			delete data.spinner; 
		}
		if (spin_opts !== false) {
			data.spinner = new Spinner($.extend({color: $this.css('color')}, spin_opts)).spin(this);
		}
	});
	return this;
};

var vView = "<%=strPath %>";

jQuery(window).on('hashchange', function () {
	goToHash('hash');
});
 
jQuery(window).on('load', function () {
    goToHash('onload');
});
var vTitle = "e머니 사용하기";
var vStore_nm = "";

var vVerios = "<%=strVerios %>";
var vVerand = "<%=strVerand %>";

$(function() {
	if($.cookie('appYN') != 'Y' && '<%=strAppyn %>' != 'Y'){	// 웹에서 호출 
		$('#header .btn__sr_back').click(function(){
			history.back(-1);
		});
		
	/*
		$('#header .btn_close_page').click(function(){
			window.location.replace("http://m.enuri.com/mobilefirst/index.jsp");
		}); 
	*/
  	}else{
  		// 앱에서 호출 
		if(window.android){		// 안드로이드
			if(vVerand != "" && Number(vVerand) < 304){
				if(confirm("e머니 적립내역 확인 및 e쿠폰 교환을 위해서는 업데이트가 필요합니다.\n\n업데이트 하시겠습니까?")>0){
					window.location.href = "market://details?id=com.enuri.android";
					setTimeout("location.href='close://';", 2000);
					return;
				}else{
					window.location.href = "close://";	    				
				}
			}
		}else{					// 아이폰에서 호출 
			if(vVerios != "" && Number(vVerios.substring(0,3)) < 304){
				if(confirm("e머니 적립내역 확인 및 e쿠폰 교환을 위해서는 업데이트가 필요합니다.\n\n업데이트 하시겠습니까?")>0){
					window.location.href = "https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8&freetoken=outlink";
					setTimeout("location.href='close://';", 2000);
					return;
				}else{
					window.location.href = "close://";	    				
				}
			}
		}

		//title생성
		try{ 
				window.android.getEmoneyTitle(vTitle);
		}catch(e){}
  	}
	
	getPoint();
	
	getStore();
	
	getPopularItemList();
	
	$("#saving").click(function(){
		location.href = "/mobilefirst/emoney/emoney.jsp?freetoken=emoney";
	});
	$("#store").click(function(){
		getStore();
	});
	$("#couponbox").click(function(){
		location.href = "/mobilefirst/emoney/emoney_couponbox.jsp?freetoken=emoney";
	});
	$("#notice").click(function(){
		location.href = "/mobilefirst/emoney/benefit.jsp?freetoken=emoney";
	});

	
	ga('send', 'pageview', {
		'page': '/mobilefirst/emoney/emoney_store.jsp',
		'title': 'mf_emoney_스토어'
	}); 
	
	/*하단 top버튼 & 작은따라다니는 배너_시작*/
	$(window).scroll(function(){
		$(".TBtn").show();
        
        if ( $(window).scrollTop() < 50 ){
        	$(".TBtn").hide();
        }
    });
    
    $("body").on('click', '.TBtn', function(event) {
		scrollTo(0,0);    
    });
    
	$(".cateBtn.gift").click(function(){
			ga('send', 'event', 'mf_footer', 'footer', 'footer_선물박스');
			location.href = "/mobilefirst/event/benefit.jsp?freetoken=event";
	});
	/*하단 top버튼 & 작은따라다니는 배너_끝*/
});

var vHash_check = false;
function goToHash(a) {
    var hashtag = location.hash.substring(1, location.hash.length);
    var target = "";
    var frame = "";
    var cate_no = "";
	
    if(hashtag == ""){
    	$(".cate").show();
    	$("#popularList").show();
    	getStore();
    }else if(hashtag.indexOf("group_") > -1){
		(hashtag.indexOf('&') > -1)
		? target = hashtag.substring(0, hashtag.indexOf('&'))
		: target = hashtag;

    	getStore();
    	//$(".cate li").removeClass("on");
    	
    	cate_no = hashtag.replace("group_","");
    	
    	if(cate_no == 5){
    		ga('send', 'event', 'mf_emoney',  'store', 'click_커피음료');
    	}else if(cate_no == 4){ 
    		ga('send', 'event', 'mf_emoney',  'store', 'click_외식');
    	}else if(cate_no == 3){
    		ga('send', 'event', 'mf_emoney',  'store', 'click_라이프');
    	}else if(cate_no == 2){
    		ga('send', 'event', 'mf_emoney',  'store', 'click_케익도넛');
    	}else if(cate_no == 1){
    		ga('send', 'event', 'mf_emoney',  'store', 'click_편의점');
    	} 

    	//$("#cate_"+cate_no).addClass("on");
		
    	//setTimeout(function(){
    	//	$(".cate li").removeClass("on");
		//}, 1500);  
    	
    	$(".cate").show();
    	$("#popularList").show();

		if(target.length !== ""){
			($.cookie('appYN') != 'Y' && '<%=strAppyn %>' != 'Y')
			? $('html, body').stop().animate({scrollTop: Math.ceil($("#"+target).offset().top - $("#header").outerHeight())}, 0)
			: $('html, body').stop().animate({scrollTop: Math.ceil($("#"+target).offset().top)}, 0);
		}
    }else if(hashtag != ""){
    	if(a == 'hash'){
    		vHash_check = true;
    	}
   		 $(".cate").hide();
   		$("#popularList").hide();

   		<% if((Long.parseLong(nowDt) > Long.parseLong(strStart_time_sub)) && (Long.parseLong(nowDt) < Long.parseLong(strEnd_time_sub))){ %>
		if(hashtag == 48){
			alert("해피콘 시스템 개선 작업 중입니다.\n점검 중에는 해피콘 쿠폰 교환, 환불, 사용이 제한됩니다.\n점검시간 : 8.31(목) 23:50 ~ 9/1(금) 01:00");
			location.href = "/mobilefirst/emoney/emoney_store.jsp";
			return false;
		}
		<% } %>
    	getItemList(hashtag);
    }

}

function getPoint(){
	$.ajax({ 
		type: "GET",
		url: "/mobilefirst/emoney/emoney_get_point.jsp",
		async: false,
		dataType:"JSON",
		success: function(json){
			remain = json.POINT_REMAIN;	//적립금
			
			$(".my_e").html("<span>"+CommaFormattedN(remain) +"<em>"+json.POINT_UNIT+"</em></span>");
		}
	});
}

function getStore(){
	$("#itemtList").html(null);
	
	var vTxt = "";
	
	$.ajax({ 
		type: "GET",
		url: "/mobilefirst/emoney/emoney_get_store.jsp",
		data: "part=1",
		async: false,
		dataType:"JSON",
		success: function(data){
		$("#itemtList").html(null);
			
			var vTxt = "";
			var vGroup_name = "";
			
			$.each(data.storelist, function(i, item) {
				if(vTxt == ""){
					vTxt += "<a id=\"group_"+item.group_seq+"\"></a>"; 
					vTxt += "<section class=\"w_box\">";
					vTxt += "	<h2>"+ item.group_name +"</h2>";
					vTxt += "	<ul class=\"shopList\">";
				}else if(vGroup_name != item.group_name){
					vTxt += "</section>"; 
					vTxt += "<a id=\"group_"+item.group_seq+"\"></a>";
					vTxt += "<section class=\"w_box\">";
					vTxt += "	<h2>"+ item.group_name +"</h2>";
					vTxt += "	<ul class=\"shopList\">";
				}

				//내용
				vTxt += "		<li><a href=\"#"+ item.store_seq +"\" onclick=\"vStore_nm='"+ item.store_name +"';\">";
				vTxt += "			<img src=\"http://img.enuri.info/images/mobilefirst/emoney/store/@"+ item.store_seq +".jpg\" alt=\""+ item.store_name +"\" /><span class=\"tit\">"+ item.store_name +"</span>";
				vTxt += "		</a></li>";
				
				vGroup_name = item.group_name;
				
			});
			
			if(vTxt != ""){
				vTxt += "</section>";
			}
			
			vTxt += "<p class=\"a_c\"><button type=\"button\" class=\"btn_default\">자주묻는 질문</button></p>";
			
			$("#itemtList").html(vTxt);
			
			$(".btn_default").unbind("click");
			$(".btn_default").click(function(){
				location.href = "/mobilefirst/emoney/emoney_faq.jsp?freetoken=emoney_sub";
				ga('send', 'event', 'mf_emoney',  'click', '스토어_자주묻는 질문');
			});
		}
	});
}

function getItemList(store_seq){
	$("#itemtList").html(null);
	
	$("body").scrollTop(0);
	
	var vTxt = "";

	if(!vHash_check){
		ga('send', 'event', 'mf_emoney',  'store', 'click_'+vStore_nm);
	}
	vHash_check = false;
	
	$.ajax({ 
		type: "GET",
		url: "/mobilefirst/emoney/emoney_get_store.jsp",
		data: "tab=2&store_seq="+store_seq,
		async: false,
		dataType:"JSON",
		success: function(data){
		$("#itemtList").html(null);
			
			var vTxt = "";
			var vStore_name = "";
			
			$.each(data.itemlist, function(i, item) {
				if(vTxt == ""){
					vTxt += "<section class=\"w_box\">";
					vTxt += "	<h2 class=\"shop\"><img src=\"http://img.enuri.info/images/mobilefirst/emoney/store/@"+ item.store_seq +".jpg\" alt=\""+ item.store_name+"\" />"+ item.store_name+"</h2>";
					vTxt += "	<ul class=\"shopList\">";
				}else if(vStore_name != item.store_name){
					vTxt += "</section>";
					vTxt += "<section class=\"w_box\">";
					vTxt += "	<h2 class=\"shop\"><img src=\"http://img.enuri.info/images/mobilefirst/emoney/store/@"+ item.store_seq +".jpg\" alt=\""+ item.store_name+"\" />"+ item.store_name+"</h2>";
					vTxt += "	<ul class=\"shopList\">";
				}

				//내용
				vTxt += "		<li><a href=\"javascript:///\" class=\"item_box\" code=\""+ item.gift_code +"\" seq=\""+ item.gift_seq +"\" item=\""+ item.item_seq +"\">";
				vTxt += "			<img src=\"http://img.enuri.info/images/mobilefirst/emoney/item/@"+ item.item_seq +".jpg\" alt=\""+  item.item_name +"\" /><span class=\"tit\">"+  item.item_name +"</span>";
				vTxt += "			<strong>"+ CommaFormattedN(item.gift_price) +"<em>점</em></strong>";
				vTxt += "			<button type=\"button\" class=\"btn_chg\">교환하기</button>";
				vTxt += "		</a></li>";
				
				vStore_name = item.store_name;
			});
			
			if(vTxt != ""){
				vTxt += "</section>";
			}
			
			vTxt += "<p class=\"a_c\"><button type=\"button\" class=\"btn_default\">자주묻는 질문</button></p>";
			
			$("#itemtList").html(vTxt);
			
			$(".item_box").each(function(){
				$(this).unbind("click");
				$(this).click(function(){
					var vCode = $(this).attr("code");
					var vSeq = $(this).attr("seq");
					var vItem = $(this).attr("item");
					
					var vUrl = "<%=strDomain %>/mobilefirst/emoney/emoney_detail.jsp?freetoken=emoney_sub&enurineedlogin=N&code="+vCode+"&seq="+vSeq+"&item="+ vItem;
					
					location.href = vUrl;
					
					if(vStore_nm == ""){
						vStore_nm = $(".shop").text();				
					}
					
					ga('send', 'event', 'mf_emoney',  'store', 'click_'+ vStore_nm +'_교환하기');
				});
			});
			
			$(".btn_default").unbind("click");
			$(".btn_default").click(function(){
				location.href = "/mobilefirst/emoney/emoney_faq.jsp?freetoken=emoney_sub&enurineedlogin=N";
			});
		}
	});
}

function getPopularItemList(){
	$("#popularList").html(null);
	
	var vTxt = ""; 
	
	$.ajax({ 
		type: "GET",
		url: "/mobilefirst/emoney/emoney_get_popular_item_list.jsp",
		async: false,
		dataType:"JSON",
		success: function(data){
		$("#popularList").html(null);
			
			var vTxt2 = "";

			$.each(data.itemlist, function(i, item) {
				if(vTxt2 == ""){
					vTxt2 += "<section class=\"w_box\">"; 
					vTxt2 += "<h2>인기 e쿠폰 BEST</h2>";
					vTxt2 += "<ul class=\"shopList type02\">";
				} 
					vTxt2 += "<li><a href=\"javascript:///\" class=\"popular_item\" gift_code=\""+ item.gift_code +"\" gift_seq=\""+ item.gift_seq +"\" item_seq=\""+ item.item_seq +"\" item_name=\""+ item.item_name +"\" >";
					vTxt2 += "	<img src=\"http://img.enuri.info/images/mobilefirst/emoney/item/@"+ item.item_seq +".jpg\" alt=\""+ item.item_name +"\" /><span class=\"tit\"><i class=\"icon_emoney_s14 comm__sprite\"></i>"+ CommaFormattedN(item.gift_price) +"</span>";
					vTxt2 += "</a></li>";
			});
			
			if(vTxt != ""){
				vTxt += "</ul>";
				vTxt += "</section>"; 
			}
			
			$("#popularList").html(vTxt2); 

			$(".popular_item").each(function(){
				$(this).click(function(){
					var vGift_code = $(this).attr("gift_code");
					var vGift_seq = $(this).attr("gift_seq");
					var vItem_seq = $(this).attr("item_seq");
					var vItem_name = $(this).attr("item_name");
					 
					ga('send', 'event', 'mf_emoney',  'store', 'click_인기상품_'+ vItem_name);
					
					var vUrl = "<%=strDomain %>/mobilefirst/emoney/emoney_detail.jsp?freetoken=emoney_sub&enurineedlogin=N&code="+vGift_code+"&seq="+vGift_seq+"&item="+ vItem_seq;
					
					location.href = vUrl;
				}); 
			}); 
		}
	}); 
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

    while(n.length > 3)
    {
        var nn = n.substr(n.length-3);
        a.unshift(nn);
        n = n.substr(0,n.length-3);
    }

    if (n.length > 0) { a.unshift(n); }

    n = a.join(delimiter);

    amount = minus + (n+ "");

    return amount;

}
</script>
<script language="JavaScript" src="<%=ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
<% } %>