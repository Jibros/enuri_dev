<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.mobile.Reward_Data"%>
<%@ page import="com.enuri.bean.mobile.Reward_Proc"%>
<jsp:useBean id="Reward_Data" class="Reward_Data" scope="page" />
<jsp:useBean id="Reward_Proc" class="Reward_Proc" scope="page" />
<%

	response.sendRedirect("/mobilefirst/index.jsp");
	

	String cUserId = cb.GetCookie("MEM_INFO","USER_ID");
	String cUserNick = cb.GetCookie("MEM_INFO","USER_NICK");
	
	String strChk_id = ChkNull.chkStr(request.getParameter("chk_id"),"");	
	
	int iCoupon = 0;
	
	Reward_Proc reward_proc = new Reward_Proc(); 
	Reward_Data reward_data[] =  reward_proc.get_CouponList(cUserId); 
	
	if(reward_data != null){
		iCoupon = reward_data.length;
	}
	
	String strGift_code = "";
	String strCoupon_number = "";

%>
<!DOCTYPE html> 
<html lang="ko">
<head> 
	<meta charset="utf-8">	
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />	
	<meta property="og:title" content="에누리 가격비교">
	<meta property="og:description" content="에누리 모바일 가격비교">
	<meta property="og:image" content="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilenew/images/logo_enuri.png">
	<meta name="format-detection" content="telephone=no" />
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/default.css">
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/mybag.css">	
	<script type="text/javascript" src="/mobilefirst/js/lib/spin.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script>
	(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
	(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
	m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
	})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
	//런칭할때 UA-52658695-3 으로 변경
	ga('create', 'UA-52658695-3', 'auto');
	</script> 
</head>
<body>
<div class="wrap">
<nav>
	<ul class="sgnb"> 
		<li class="sgnb_btt btt_1"><a href="javascript:///">홈</a></li>
		<li class="sgnb_btt btt_2"><a href="javascript:///">라면교환소</a></li>
		<li class="sgnb_btt btt_3"><a href="javascript:///" class="on">쿠폰함</a></li>
		<li class="sgnb_btt btt_4"><a href="javascript:///">문의</a></li>
	</ul> 
</nav>

<section class="content"> 
	<div id="loadingLayer" style="display:none;position:absolute;z-index:999999;width:1px;height:1px;"></div>
	<div class="w_box">
		<p class="number">라면쿠폰 <strong><%=iCoupon%></strong>개</p>
		<a href="#" class="btn_redo">새로고침</a>
	</div>
	<%if( reward_data.length > 0 ){%>	
		<div class="barcode"> 
			<!-- 쿠폰 -->
			<%for ( int i = 0; i < reward_data.length ; i ++){ %>
				<div class="br_box">
					<% if(reward_data[i].getIs_use().equals("1")){%>
					<em class="end_stamp">사용완료</em>
					<p class="layer_back"></p>
					<%}%>
					<span class="brand"><%=reward_data[i].getItem_name()%>(1개) </span>
					<p><img src="<%=reward_data[i].getCoupon_img()%>" alt="" /></p>
				</div>
				<%
					if(reward_data[i].getIs_use().equals("0")){
						if(strGift_code.equals("")){ 
							strGift_code = reward_data[i].getGift_code();
							strCoupon_number = reward_data[i].getCoupon_number();
						}else{
							strGift_code = strGift_code + "," +reward_data[i].getGift_code();
							strCoupon_number = strCoupon_number + "," +reward_data[i].getCoupon_number();							
						}
					}	
				%>
			<%}%> 
		</div>	
	<%}%>
</section>
 
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

var vChk_End = false;
var vAlert_ios = "※라면백 이벤트 종료※\n라면쿠폰은 쿠폰함에서 사용가능하며\n라면 교환권은 e머니로 교환됩니다.";
var vAlert_aos = "※라면백 이벤트 종료※\n라면쿠폰은 쿠폰함에서 사용가능하며\n라면 교환권은 e머니로 교환됩니다.";

$(function() {
	
	var vNowtime = new Date().format("yyyyMMddhhmm");
	vNowtime = vNowtime * 1;
	
	var limit_time = 201602142359;
	//var limit_time = 201602141600;
	
	if(vNowtime > limit_time){
		if(window.android){
			alert(vAlert_aos);
		}else{
			alert(vAlert_ios);
		}
		vChk_End = true;
	}
	
	$(".sgnb_btt").click(function(e){
		 if($(this).hasClass("btt_1")){
			 location.href = "/mobilefirst/reward/reward_main.jsp?title=My%20%EB%9D%BC%EB%A9%B4%EB%B0%B1";
		 }else if($(this).hasClass("btt_2")){
			 if(window.android){
				 alert(vAlert_aos);
			}else{
				 alert(vAlert_ios);
			}
		 }else if($(this).hasClass("btt_3")){
			 location.href = "/mobilefirst/reward/reward_coupon.jsp?title=My%20%EB%9D%BC%EB%A9%B4%EB%B0%B1";
		 }else if($(this).hasClass("btt_4")){
			 location.href = "/mobilefirst/reward/reward_cs.jsp?title=My%20%EB%9D%BC%EB%A9%B4%EB%B0%B1";
		 }
	});
	$(".btn_redo").click(function(e){
		//alert("<%=strGift_code%>");
		//alert("<%=strCoupon_number%>");
		couponChk();
	});
	
	ga('send', 'pageview', {
		'page': '/mobilefirst/reward/reward_coupon.jsp',
		'title': 'mf_라면백_쿠폰함'
	}); 
});

function couponChk(){
	
	var gift_code = "<%=strGift_code%>";
	var coupon_number = "<%=strCoupon_number%>";
	 
	if(gift_code.length > 0){
		CmdSpin('on');
		
		$.ajax({
			type: "GET", 
			url: "/mobilefirst/ajax/rewardAjax/couponUse_Check.jsp",
			data: "gift_code="+gift_code+"&coupon_number="+coupon_number+"&chk_id=<%=strChk_id%>",
			success: function(data){
				CmdSpin('off');
				document.location.reload();
			},
			error : function(result) { 

			}
		});
	}
}

function CmdSpin(param){
	if(param=="on"){
		$("#loadingLayer").css("top",$(window).height()/2);
		$("#loadingLayer").css("left",$(window).width()/2);
		$("#loadingLayer").fadeIn("fast");
		$("#loadingLayer").spin();	 
	}else{
		$("#loadingLayer").hide();
	}
}
</script>