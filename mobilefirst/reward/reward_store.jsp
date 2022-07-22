<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.mobile.Reward_Data"%>
<%@ page import="com.enuri.bean.mobile.Reward_Proc"%>
<jsp:useBean id="Reward_Data" class="Reward_Data" scope="page" />
<jsp:useBean id="Reward_Proc" class="Reward_Proc" scope="page" />
<%
/*

	String cUserId = cb.GetCookie("MEM_INFO","USER_ID");
	String cUserNick = cb.GetCookie("MEM_INFO","USER_NICK");
	
	String strChk_id = ChkNull.chkStr(request.getParameter("chk_id"),"");	
%>
<!DOCTYPE html> 
<html lang="ko">
<head> 
	<meta charset="utf-8">	
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />	
	<meta property="og:title" content="에누리 가격비교">
	<meta property="og:description" content="에누리 모바일 가격비교">
	<meta property="og:image" content="http://img.enuri.info/images/mobilenew/images/logo_enuri.png">
	<meta name="format-detection" content="telephone=no" />
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/default.css">
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/mybag.css">
	<script type="text/javascript" src="/carm/js/src/spin.js"></script>
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
		<li class="sgnb_btt btt_2"><a href="javascript:///"  class="on">라면교환소</a></li>
		<li class="sgnb_btt btt_3"><a href="javascript:///">쿠폰함</a></li>
		<li class="sgnb_btt btt_4"><a href="javascript:///">문의</a></li>
	</ul> 
</nav>

<section class="content">
<div id="loadingLayer" style="display:none;position:absolute;z-index:999999;width:1px;height:1px;"></div>
	<div class="w_box">
		<p class="number">라면쿠폰 교환권 <strong  id="point_remain"></strong>개</p>
	</div>
	<!-- 편의점 선택 레이어 -->
	<script type="text/javascript">
		//쿠폰선택
		$(document).ready(function(){
			$( ".storeimg>li>" ).click(function() {
			$(this).parent().addClass("on").siblings().removeClass("on");
			return false;
			});
		});

		//레이어
		function onoff(id) {
			var mid=document.getElementById(id);
			if(mid.style.display=='') {
			mid.style.display='none';
		}else{
			mid.style.display='';
			}
		}
	</script>
	<div class="dim" id="store_sel" style="display:none;">
		<div class="choice">
			<div class="store_list"> 
				<h2><span>비빔면</span> 쿠폰을 받으실<br />편의점을 선택해주세요</h2>
				<ul class="storeimg">
					<li id="cu"><label><input type="radio" name="radio" /><img src="http://img.enuri.info/images/mobilefirst/reward/cu.gif" alt="CU" /></label></li>
					<li id="gs25"><label><input type="radio" name="radio" /><img src="http://img.enuri.info/images/mobilefirst/reward/gs.gif" alt="GS25" /></label></li>
				</ul>
				<ul class="btnaera">
					<li><button type="button" class="cancel" onclick="onoff('store_sel')">취소</button></li>
					<li><button type="button" class="ok">확인</button></li>
				</ul>
			</div> 
		</div>
	</div>
	<!--// 편의점 선택 레이어 -->
	<p class="ch_txt">* 교환을 원하시는 라면을 선택하시면 쿠폰이 지급됩니다.</p>
	<!-- 쿠폰받기 -->
	<div id="goodsDiv">
	</div>
	<div id="storeDiv" style="display:none;position:absolute;top:0px;left:0px;background-color:#ffffff;border:1px solid #000000;margin:5px;">
	</div>
	<!--// 쿠폰받기 -->
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

var remain = 0.0;		//적립금
var prefix = 0.0;		//적립예정

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
		location.href = "/mobilefirst/reward/reward_main.jsp?title=My%20%EB%9D%BC%EB%A9%B4%EB%B0%B1";
	}
	
	getPoint();			//라면교환권갯수

	getRamenList();	//라면리스트

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
	
	ga('send', 'pageview', {
		'page': '/mobilefirst/reward/reward_store.jsp',
		'title': 'mf_라면백_라면교환소'
	}); 
	
});

function couponUse(gifts){
	var gift_seq = "";
	var gift_code = "";
	
	if(gifts.indexOf("_") > 0){
		
		gift_seq = gifts.substring(0, gifts.indexOf("_")); 
		gift_code = gifts.substring(gifts.indexOf("_")+1, gifts.length);
		
		CmdSpin('on');
		//alert("gift_seq=="+gift_seq+" , gift_code=="+gift_code);
		
		//alert("이용에 불편을 드려 죄송합니다.\n시스템 점검 중이오니 내일 확인해 주세요.\n\n오류 발생 시 고객센터로 연락해 주세요.");
		//CmdSpin('off');
		//return;

		$.ajax({
			type: "GET",
			url: "/mobilefirst/ajax/rewardAjax/couponUse.jsp",
			data: "gift_seq="+gift_seq+"&gift_code="+gift_code+"&chk_id=<%=strChk_id%>",
			success: function(data){
				CmdSpin('off');
				 
				if(data.indexOf("00") > -1){
					alert("교환 되었습니다.\n\n쿠폰함에서 쿠폰을 확인하여 주세요.");
					onoff('store_sel');
					getPoint(); 
				}else{ 
					alert("쿠폰발행 중 오류가 발생했습니다. \n\n잠시후 다시 시도하세요.");
					onoff('store_sel');
				}
			}, 
			error : function(result) { 
				alert("error");
				CmdSpin('off');
				onoff('store_sel');
			}
		});
	}
}

function getPoint(){
	$.ajax({ 
		type: "GET",
		url: "/mobilefirst/reward/reward_get_point.jsp",
		async: false,
		dataType:"JSON",
		success: function(json){
			remain = parseFloat(json.POINT_REMAIN);	//적립금
			//prefix = parseFloat(json.POINT_PRE_FIX);	//적립예정
			
			//test
			//remain = 1.5;
			//prefix = 2.0; 
			
			$("#point_remain").html(remain);
			//$("#point_prefix").html(prefix +"<em>개</em>");
		}
	});
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
function getRamenList(){
	 
	var template = "";
	var vNo = 0;
	var item_seq = 0;
	
	$.ajax({  
		type: "GET",
		url: "/mobilefirst/reward/ramen_list.jsp",
		async: false,
		dataType:"JSON",
		success: function(json){
			if(json.length > 0){
				for(var i=0;i<json.length;i++){
					if(i == 0){
						item_seq = json[i].item_seq;
					}
					if(i == 0 || item_seq !=  json[i].item_seq){
						if(i > 0){
							template += "</a></li>";
						}
						if( (vNo % 3) == 0){		
							template += "</ul>"; 
						} 
						if(vNo == 0 || vNo % 3 == 0){				
							template += "<ul class=\"goods_list\">";
						} 
						template += "<li  id=\"gift_"+json[i].item_seq+"\" ><a href=\"javascript:;\">";
						template += "<img src=\"http://img.enuri.info/images/mobilefirst/reward/gift/"+json[i].item_seq+".jpg\" alt=\"\">";
						template += "<span>"+json[i].item_name+"</span>"; 
						template += "<button type=\"button\" class=\"btncoupon\">쿠폰받기</button>";
						template += "<input type=\"hidden\" id=\""+json[i].store_name+"\" value=\""+json[i].gift_seq+"_"+json[i].gift_code+"\" >";
						vNo = vNo + 1;	 
					}else{
						template += "<input type=\"hidden\" id=\""+json[i].store_name+"\" value=\""+json[i].gift_seq+"_"+json[i].gift_code+"\" >";
					}
					item_seq = json[i].item_seq; 
				}   
				if( i == json.length-1){		 
					template += "</ul>";   
				} 
			}
			$("#goodsDiv").html(template);
		}
	});
	
	var cu_no = "";
	var gs25_no = ""; 
	
	$(".goods_list li").click(function(){
		var template2 = "";
		
		$( ".storeimg>li" ).removeClass("on");
		
		if(remain >= 1 ){
			var thisId 			= this.id.replace("gift_","");
			var thisName		= $("#gift_"+thisId+" span").text();
			cu_no 		= $("#gift_"+thisId+" #CU").val();
			gs25_no 	= $("#gift_"+thisId+" #GS25").val();
			
			$(".store_list span").text(thisName);
			
			if(cu_no == undefined){
				$("#cu").hide();
				$("#gs25").addClass("on"); 
			}else{  
				$("#cu").show();
			}
			if(gs25_no == undefined){
				$("#gs25").hide();
				$("#cu").addClass("on");
			}else{
				$("#gs25").show();
			}

			onoff('store_sel');
		}else{
			alert("교환권이 부족합니다.");
		} 
	});
	$(".ok").click(function(){
		var gifts = "";
		if($("#cu").hasClass("on")){
			gifts = cu_no;
			couponUse(gifts);
		}else if($("#gs25").hasClass("on")){
			gifts = gs25_no;
			couponUse(gifts);
		}else{
			alert("편의점을 선택하세요.");
		}
	});

}
</script>
<%
*/
%>