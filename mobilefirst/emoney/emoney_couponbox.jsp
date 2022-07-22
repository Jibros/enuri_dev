<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.mobile.Emoney_Proc"%>
<jsp:useBean id="Emoney_Proc" class="com.enuri.bean.mobile.Emoney_Proc" scope="page" />
<%
String cUserId = cb.GetCookie("MEM_INFO","USER_ID");
String cUserNick = cb.GetCookie("MEM_INFO","USER_NICK");

String strChk_id = ChkNull.chkStr(request.getParameter("chk_id"),"");
String strPath = ChkNull.chkStr(request.getParameter("path"),"");
 
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
	    	//break;
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

String szRemoteHost = request.getRemoteHost().trim();
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
if(strVerios.length() > 5){
	strVerios = strVerios.substring(0, 5).replace(".", "");
}else{
	strVerios = "0";
}
if(strVerand.length() > 0){
	strVerand = strVerand.replace(".","");
}else{
	strVerand = "0";
}
   
   boolean blTopbar_show = true;
   if(strAppyn.equals("Y")){
       if(i_Log == 5940){
       	intVerand = Integer.parseInt(strVerand);
           if(intVerand >= 320){
               blTopbar_show = false;
           }
       }else if(i_Log == 5939){
       		intVerios = Integer.parseInt(strVerios);
           if(intVerios >= 32000){
               blTopbar_show = false;
           }
       }
   }
   
 //쿠프 정기정검
	long cTime = System.currentTimeMillis(); 
	SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMddHHmm");
	String nowDt = dayTime.format(new Date(cTime));

	//String strStart_time = "202204271430";
	//String strEnd_time 	 = "202204271600";
	String strStart_time = "202204280100";
	String strEnd_time =   "202204280900";
	
   boolean blTime_check = false;

   //System.out.println("nowDt>>>>>>>>>>>>"+nowDt);
   //System.out.println("strStart_time>>>>"+strStart_time);
   //System.out.println("strEnd_time>>>>>>"+strEnd_time);

   if((Long.parseLong(nowDt) > Long.parseLong(strStart_time)) && (Long.parseLong(nowDt) < Long.parseLong(strEnd_time))){
	   	//System.out.println("11111");
	   	blTime_check = true;
	   	out.println("<script>");
	   	out.println("	alert('안정적이고 보다 나은 서비스 제공을 위해 시스템 점검 중입니다.\\n점검 중에는 쿠폰 교환 및 환불, 쿠폰사용이 제한됩니다.\\n\\n점검시간 : 4/28(목) 01:00 ~ 09:00');");
	   	if(!strAppyn.equals("Y")){
	   		out.println("	history.back();");	
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
	<link rel="stylesheet" type="text/css" href="/css/mobile_v2/common.css"/>
	<script type="text/javascript" src="/mobilefirst/js/lib/spin.js"></script>
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
			'page': '/mobilefirst/emoney/emoney_couponbox.jsp',
			'title': 'emoney_couponbox'
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
				<div class="header_top_page_name">보유e쿠폰</div>
			</div>
		</div>
	</header>
	<div class="fixed_top_empty"></div>
	<%}%>
	<div class="shop_contents">
		<div id="loadingLayer" style="display:none;position:absolute;z-index:999999;width:1px;height:1px;"></div>	
		<section class="w_box">
			<h2 class="shop" id="shop_start">사용가능 <em></em>개<button type="button" class="refresh"  id="reBtn" style="display:none;">새로고침</button></h2>
			<!-- 160316 쿠폰 없을 때 메세지 -->
			<div class="no_msg_wrap"  style="display:none;">
				<div class="no_msg" style="display:block;">
					<em>사용 가능한 쿠폰이 없습니다.</em>
					e머니로 쿠폰을 교환해 보세요!
				</div>
			</div>
			<ul class="couponList" id="coupon_ing"></ul>
		</section>
		<section class="w_box" style="display:none;">
			<h2 class="shop end" id="shop_end">사용/환불완료 <em></em>개<button type="button" class="refresh"  id="reBtn_use" style="display:none;">새로고침</button></h2>
			<ul class="couponList" id="coupon_end">
			</ul>
		</section>
 	    <p class="a_c"><button type="button" class="btn_default" id="link_faq">자주묻는 질문</button></p>
	</div>
	<div class="newquick" id='aaaa'>
		<p class="TBtn" style="display:none" />
		<!-- <p class="cateBtn gift"> -->
	</div>
	<%@ include file="/mobilefirst/event2016/event_footer.jsp"%>
</div>
</body>
</html>
<script>
var appYn = "<%=strAppyn%>";
var vTitle = "보유e쿠폰";

if('<%=strAppyn%>' != 'Y'){
	$('#header .btn__sr_back').click(function(){
		history.back(-1);
	});

	$('#header .btn_close_page').click(function(){
		window.location.replace("http://"+location.host+"/m/index.jsp");
	});
}else{
	ga('send', 'pageview', {
		'page': '/mobilefirst/emoney/emoney_couponbox.jsp', 
		'title': 'mf_emoney_'+vTitle
	}); 
	
	//title생성
	try{ 
			window.android.getEmoneyTitle(vTitle);
	}catch(e){}

	$('.wrap .shop_contents').css({"padding-top":0});
}

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
var vGiftcode = "";
var vCouponNumber = "";
var vGiftcode_use = "";
var vCouponNumber_use = "";
var bRefresh = false;
var blTopbar_show = <%=blTopbar_show%>;

$(function() {
    //상품정보 Bar 3.2.0 부터 사라짐 app에서만
	if(blTopbar_show==false){
		$(".top").hide();
	}
	getPoint();
	
	getCouponbox();	
	 
	$("#link_faq").click(function(){
		ga('send', 'event', 'mf_emoney',  'click', '쿠폰함_자주묻는 질문');
		location.href = "/mobilefirst/emoney/emoney_faq.jsp?freetoken=emoney_sub";
	});
	
	$("#saving").click(function(){ 
		location.href = "/mobilefirst/emoney/emoney.jsp?freetoken=emoney";
	});
	$("#store").click(function(){
		location.href = "/mobilefirst/emoney/emoney_store.jsp?freetoken=emoney";
	});
	$("#couponbox").click(function(){
		getCouponbox();
	});
	$("#notice").click(function(){
		//$(".sgnb > li").removeClass("on");
		//$(this).addClass("on");
		//혜택안내 창 팝업  
		location.href = "/mobilefirst/emoney/benefit.jsp?freetoken=emoney";
	});
	$("#reBtn").click(function(){
		couponChk();
	});
	$("#reBtn_use").click(function(){
		couponChk_use();
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

function  getCouponbox(){
	$(".coupon_ing").html(null);
	$(".coupon_end").html(null);

	vGiftcode = "";
	vCouponNumber = "";
	vGiftcode_use = "";
	vCouponNumber_use = "";
	
	var vTxt = "";
	var vTxt_0 = "";
	var vTxt_1 = "";
	
	var date = new Date();
	var cDate = "";
	var cDate2 = "";

	if(Number(date.getMonth()) < 9){
		if(Number(date.getDate()) < 9){
			cDate = date.getFullYear() +"0"+ (date.getMonth()+1) +"0"+ date.getDate();
			cDate2 = date.getFullYear() +"-0"+ (date.getMonth()+1) +"-0"+ date.getDate();
		}else{
			cDate = date.getFullYear() +"0"+ (date.getMonth()+1) +""+ date.getDate();
			cDate2 = date.getFullYear() +"-0"+ (date.getMonth()+1) +"-"+ date.getDate();
		}
	}else{ 
		if(Number(date.getDate()) < 9){
			cDate = date.getFullYear() +""+ (date.getMonth()+1) +"0"+ date.getDate();
			cDate2 = date.getFullYear() +"-"+ (date.getMonth()+1) +"-0"+ date.getDate();
		}else{	
			cDate = date.getFullYear() +""+ (date.getMonth()+1) +""+ date.getDate();
			cDate2 = date.getFullYear() +"-"+ (date.getMonth()+1) +"-"+ date.getDate();
		}
	}
	
	var today = new Date();
	today.setDate(today.getDate() + 7);


	var year = today.getFullYear();
	var month = today.getMonth() + 1;
	var day = today.getDate();
	
	month = month +"";
	day = day +"";
		
	if(month.length < 2){
		month = "0"+month;
	}
		 
	if(day.length < 2){
		day = "0"+day;
	}
		
	var cDate_7 = year +""+ month +""+ day;
	
	$.ajax({ 
		type: "GET",
		url: "/mobilefirst/emoney/emoney_get_couponlist.jsp",
		data: "isuse=0",		//미사용쿠폰, 사용가능
		async: false,
		dataType:"JSON",
		success: function(data){
			if(data.couponlist.length > 0){
				$("#reBtn").show();
			}else{
				$("#reBtn").hide();
			}
			$.each(data.couponlist, function(i, item) {
				var vEdate = item.coupon_edate;
				
				var oneDay = 24 * 60 * 60 * 1000;
				
				var sDate = new Date(cDate2.replace(/-/g, '/'));
				var eDate = new Date(vEdate);

				var diffDays = Math.round(Math.abs((sDate - eDate) / (oneDay)));

				if(diffDays.length < 2){
					diffDays = "0"+diffDays;
				}
				vTxt_0 += "		<li id=\"c_"+item.coupon_seq+"\" device=\""+ item.device +"\"><a href=\"javascript:void(0);\">";
				
				//if(item.coupon_edate.replace(/-/gi,"") > cDate && item.coupon_edate.replace(/-/gi,"") < cDate_7 ){
				//	vTxt_0 += "			<span class=\"near\">기간<br />임박</span>";
				//} 
				
				//if("<%=cUserId%>" == "flyght"){
				//	diffDays = 0;
				//}
				
				if(item.device == "P"){
					vTxt_0 += "			<em class=\"mark ico_big_pc\">PC</em>";
				}else{
					vTxt_0 += "			<em class=\"mark ico_big_mobile\">mobile</em>";
				}
				if(diffDays == "0" || diffDays < 1){
					vTxt_0 += "			<span class=\"label_day end\">오늘<br />까지</span>";
				}else{
					vTxt_0 += "			<span class=\"label_day day\">D-"+ (diffDays) +"</span>";
				}
				vTxt_0 += "			<div class=\"thumbnail_img\"><img src=\"http://img.enuri.info/images/mobilefirst/emoney/item/@"+item.item_seq+".jpg\" alt=\""+item.item_name+"\" /></div>";
				vTxt_0 += "			<span class=\"tit\">";
				if(item.item_maker){
					vTxt_0 += "["+item.item_maker+"] "; 
				}
				vTxt_0 += item.item_name+"</span>";
				vTxt_0 += "		</a></li>";
			
				if(vGiftcode == ""){  
					vGiftcode = item.gift_code;
					vCouponNumber = item.coupon_number;
				}else{
					vGiftcode = vGiftcode + "," +item.gift_code;
					vCouponNumber = vCouponNumber + "," + item.coupon_number;	
				}
			});
			
			$("#shop_start em").html(data.couponlist.length);

			$("#coupon_ing").html(vTxt_0); 
			
			if(data.couponlist.length < 1){ 
				$(".no_msg_wrap").show();
			}
			if(!bRefresh){
				bRefresh = true;
				//쿠폰상태 강제 갱신. 트레픽 과다 임시 차단 조치 2018-10-10 shwoo
				//재오픈 2019-01-07
				couponChk(); //쿠폰함 리프레시 여기여기
			}
		}
	});  
	 
	$.ajax({  
		type: "GET",
		url: "/mobilefirst/emoney/emoney_get_couponlist.jsp",
		data: "isuse=1",		//사용완료쿠폰
		async: false,
		dataType:"JSON",
		success: function(data){
			if(data.couponlist.length > 0){
				$("#reBtn_use").show();
			}

			$.each(data.couponlist, function(i, item) {
				vTxt_1 += "		<li id=\"c_"+item.coupon_seq+"\" device=\""+ item.device +"\"><a href=\"javascript:void(0);\">";

				if(item.device == "P"){
					vTxt_1 += "			<em class=\"mark ico_big_pc\">PC</em>";
				}else{
					vTxt_1 += "			<em class=\"mark ico_big_mobile\">mobile</em>";
				}
				
				if(item.is_use == "1"){
					vTxt_1 += "		<span class=\"label_day end\">사용<br />완료</span>";
				}else if(item.refund_status == "1"){
					vTxt_1 += "		<span class=\"label_day end\">환불<br />완료</span>"; 
				}else if(item.coupon_edate.replace(/-/gi,"") < cDate){
					vTxt_1 += "		<span class=\"label_day end\">기간<br />만료</span>";
				}
				vTxt_1 += "			<div class=\"thumbnail_img\"><img src=\"http://img.enuri.info/images/mobilefirst/emoney/item/@"+item.item_seq+".jpg\" alt=\""+item.item_name+"\" /></div>";
				vTxt_1 += "			<span class=\"tit\">";
				if(item.item_maker){
					vTxt_1 += "["+item.item_maker+"] ";
				}
				vTxt_1 += item.item_name+"</span>";
				vTxt_1 += "		</a></li>";

				if(vGiftcode_use == ""){  
					vGiftcode_use = item.gift_code;
					vCouponNumber_use = item.coupon_number;
				}else{
					vGiftcode_use = vGiftcode_use + "," +item.gift_code;
					vCouponNumber_use = vCouponNumber_use + "," + item.coupon_number;	
				}
			}); 
			
			//$("#shop_end").html("사용완료쿠폰 "+ data.couponlist.length+"개");
			$("#shop_end em").html(data.couponlist.length);

			$("#coupon_end").html(vTxt_1);
			
			if(data.couponlist.length < 1){
				$(".shop_contents section:eq(1)").hide();
			}else{
				$(".shop_contents section:eq(1)").show();
			}
		} 
	}); 
	
	$(".couponList li").click(function(){
		if(appYn !== "Y"){
			alert("쿠폰 상세정보는 에누리 앱 > [보유 e쿠폰] 에서 확인 가능합니다.");
		}else{
			var thisId = this.id.replace("c_","");
			var thisDevice = $(this).attr("device");
			location.href = "/mobilefirst/emoney/emoney_couponbox_detail.jsp?freetoken=emoney_sub&coupon_seq="+thisId+"&device="+thisDevice;
		}
	});
}

function couponChk(){
	var gift_code = vGiftcode;
	var coupon_number = vCouponNumber;

	if(gift_code.length > 0){
		CmdSpin('on'); 
		 
		$.ajax({
			type: "GET", 
			url: "/mobilefirst/ajax/rewardAjax/couponUse_Check.jsp",
			data: "gift_code="+gift_code+"&coupon_number="+coupon_number+"&chk_id=<%=strChk_id%>",
			success: function(data){
				CmdSpin('off');
				getCouponbox();
				//document.location.reload();
			},
			error : function(result) { 
 
			}
		});
	}
}

function couponChk_use(){	//사용완료쿠폰도 재확인버튼
	var gift_code_use = vGiftcode_use;
	var coupon_number_use = vCouponNumber_use;

	if(gift_code_use.length > 0){
		CmdSpin('on'); 
		 
		$.ajax({
			type: "GET", 
			url: "/mobilefirst/ajax/rewardAjax/couponUse_Check.jsp",
			data: "gift_code="+gift_code_use+"&coupon_number="+coupon_number_use+"&chk_id=<%=strChk_id%>&nouse=1",
			success: function(data){
				CmdSpin('off');
				//getCouponbox();
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