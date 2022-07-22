<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.enuri.bean.main.brandplacement.DBDataTable"%>
<%@ page import="com.enuri.util.seed.Seed_Proc"%>
<%@ page import="com.enuri.bean.main.brandplacement.DBWrap"%>
<%@ page import="com.enuri.bean.mobile.Reward_Data"%>
<%@ page import="com.enuri.bean.mobile.Emoney_Proc"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@ page import="com.enuri.bean.mobile.RSAMains"%>
<%@ page import="com.enuri.bean.mobile.CRSA"%>
<%@ page import="com.enuri.util.date.DateUtil"%>
<%@ page import="java.text.ParseException"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="com.enuri.bean.mobile.Mobile_Push_Proc"%>
<%@ page import="com.enuri.bean.member.Sns_Login"%>
<jsp:useBean id="Reward_Data" class="com.enuri.bean.mobile.Reward_Data" scope="page" />
<jsp:useBean id="Emoney_Proc" class="com.enuri.bean.mobile.Emoney_Proc" scope="page" />
<jsp:useBean id="Mobile_Push_Proc" class="com.enuri.bean.mobile.Mobile_Push_Proc" scope="page" />
<jsp:useBean id="Members_Proc" class="com.enuri.bean.knowbox.Members_Proc" scope="page" />
<jsp:useBean id="Sns_Login" class="com.enuri.bean.member.Sns_Login" scope="page" />
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%
CRSA rsa = new CRSA();
String strRSA = ChkNull.chkStr(request.getParameter("pd"));

Mobile_Push_Proc mobile_push_proc = new Mobile_Push_Proc();

int vReturn = 0;

boolean vTrue = false;

String strRSA2 = "";

boolean blCheck_t1 = false;
boolean blCheck_pd = false;

String strT1_fdate = "";
String strT1_enuriid = "";
String strT1_userdata = "";

String sApp_type 				= "";
String sTime		 			= "";
String sUuid						= "";
String sEnuri_id				= "";

String strFdate = "";

String strR_id = "";
String strT1_Rsa = "";
String strR_code = "";
String strR_msg = "";

if(strRSA != null && !strRSA.equals("")){
	strRSA = strRSA.replaceAll("[-]","+");
	strRSA = strRSA.replaceAll("[_]","/");

	if(strRSA.length() > 0){
		strRSA2	= mobile_push_proc.longdecrypt3(strRSA);   //RSA 타는것
	}

	if(strRSA2 != null && !strRSA2.equals("")){
		if(strRSA2.indexOf("appid") > -1 && strRSA2.indexOf("time") > -1 && strRSA2.indexOf("uuid") > -1 && strRSA2.indexOf("id") > -1){
			vTrue = true;
		}

		if(vTrue){
			String astrRSA[] = strRSA2.split("&");

			int intRSACnt = astrRSA.length;

			if(vTrue && strRSA2.length() > 0 && (intRSACnt >= 4 && intRSACnt <= 6)){

				for (int i=0 ; i<intRSACnt ; i++){
					if(i == 0)	 sApp_type 		= astrRSA[i].substring(astrRSA[i].indexOf("=") + 1, astrRSA[i].length()).trim();
					if(i == 1)	 sTime 				= astrRSA[i].substring(astrRSA[i].indexOf("=") + 1, astrRSA[i].length()).trim();
					if(i == 2)	 sUuid 				= astrRSA[i].substring(astrRSA[i].indexOf("=") + 1, astrRSA[i].length()).trim();
					if(i == 3)	 sEnuri_id 			= astrRSA[i].substring(astrRSA[i].indexOf("=") + 1, astrRSA[i].length()).trim();
				}

				//System.out.println("sApp_type>>"+sApp_type +"<br>");
				//System.out.println("sTime>>"+sTime +"<br>");
				//System.out.println("sUuid>>>"+sUuid +"<br>");
				//System.out.println("sEnuri_id>>>"+sEnuri_id +"<br>");
				blCheck_pd = true;
			}
		}
	}
}

//System.out.println("sUuid>>>"+sUuid);

String cUserId = cb.GetCookie("MEM_INFO","USER_ID");
String cUserNick = cb.GetCookie("MEM_INFO","USER_NICK");
String cSnsuser = cb.GetCookie("MEM_INFO","SNSTYPE");	//sns 회원 구분 추가. 2019-03-08. shwoo

String strChk_id = ChkNull.chkStr(request.getParameter("chk_id"),"");

String strCode = ChkNull.chkStr(request.getParameter("code"),"");
int intSeq = ChkNull.chkInt(request.getParameter("seq"),0);
int intItem = ChkNull.chkInt(request.getParameter("item"),0);

Cookie[] carr = request.getCookies();
String strAppyn = "";
String strVerios = "";
String strAd_id = "";
int intVerios = 0;

if(strChk_id.equals("") && !sUuid.equals("")){
	strChk_id = sUuid;
}

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
	    if(carr[i].getName().equals("adid")){
	    	strAd_id = carr[i].getValue();
	    	break;
	    }
	}
} catch(Exception e) {
}

String szRemoteHost = request.getRemoteHost().trim();

//쿠프 정기정검
long cTime = System.currentTimeMillis();
SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMddHHmm");
String nowDt = dayTime.format(new Date(cTime));

//String strStart_time = "202204271430"; 
//String strEnd_time 	 = "202204271600";
String strStart_time = "202204280100";
String strEnd_time =   "202204280900";
 
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

if( (Long.parseLong(nowDt) > Long.parseLong(strStart_time)) && (Long.parseLong(nowDt) < Long.parseLong(strEnd_time))){
	//System.out.println("11111");
	blTime_check = true;
	out.println("<script>");
	//out.println("	alert('시스템 개선 작업 중입니다.\\n점검 중에는 쿠폰 교환 및 환불, 쿠폰사용이 제한됩니다.\\n\\n점검시간 : 7.28(금) 00:00~09:00');");
	out.println("	alert('안정적이고 보다 나은 서비스 제공을 위해 시스템 점검 중입니다.\\n점검 중에는 쿠폰 교환 및 환불, 쿠폰사용이 제한됩니다.\\n\\n점검시간 : 4/28(목) 01:00 ~ 09:00');");
	if(!strAppyn.equals("Y")){
		//out.println("	window.close();");
		out.println("	history.back();");
	}else{
		out.println("	location.href='close://'");
	}
	out.println("</script>");
	return;
}else{

//emoney_get_detail_info.jsp?code=strCode
//☆★☆★☆★  가격은 우리쪽 DB에 저장된 값을 사용함.
//가격 get
Emoney_Proc emoney_proc = new Emoney_Proc();
int intItem_price = emoney_proc.get_ItemPrice(intSeq);

String strDomain = "https://m.enuri.com";
if (request.getRequestURL().indexOf("stagedev.enuri.com") > -1){
	strDomain = "http://stagedev.enuri.com";
}else if (request.getRequestURL().indexOf("dev.enuri.com") > -1){
	strDomain = "https://dev.enuri.com";
}

//sdu 회원 여부
boolean blSdumember = Members_Proc.SduCerify(cUserId);

//sns 인증 회원 여부
boolean blSnsCertify = Sns_Login.isSnsMemberCertify(cUserId);
boolean blSnsMember = false;

if(("K").equals(cSnsuser) || ("N").equals(cSnsuser)){	//K:카카오,N:네이버
	blSnsMember = true;
}
//System.out.println("cUserId>>>"+cUserId);
//System.out.println("cSnsuser>>>"+cSnsuser);
//System.out.println("blSnsCertify>>>"+blSnsCertify);
if(!strAppyn.equals("Y")) session.setAttribute("emoneyPagechk", "estore_detail");
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
	<script type="text/javascript" src="/mobilefirst/js/lib/spin.js"></script>
	<script>
	(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
		(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
		m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
		})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
		//런칭할때 UA-52658695-3 으로 변경
		ga('create', 'UA-52658695-3', 'auto');
		ga('send', 'pageview', {
			'page': '/mobilefirst/emoney/emoney_detail.jsp',
			'title': 'emoney_coupon_detail'
		});
	</script>
</head>
<body>
<div id="loadingLayer" style="display:none;position:absolute;z-index:999999;width:1px;height:1px;"></div>
<div class="wrap">
<%if(!strAppyn.equals("Y")){%>
<header id="header" class="page_header nomargin header_top_fixed">
	<div class="header_top">
			<div class="wrap">
				<button class="btn__sr_back comm__sprite2"><i class="icon_arrow_back comm__sprite2">뒤로</i></button>
				<div class="header_top_page_name">상품 상세정보</div>
			</div>
		</div>
</header>
<div class="fixed_top_empty"></div>
<%}%>
<!-- 상품이미지 -->
<div class="goods">
	<section class="w_box">
		<ul class="prodbox">
			<li>
				<span class="info_img" id="title_img"></span>
				<strong id="goods_nm"></strong>
				<span class="price" id="goods_price"></span>
				<button type="button" class="btn_buy">교환하기</button>
			</li>
		</ul>
	</section>
</div>
<!--// 상품이미지 -->

<!-- 상세정보/유의사항 -->
<div class="goods whitebg">
	<dl class="shop_info">
		<dt>사용처</dt>
		<dd id="use_company"></dd>
		<dt>유효기간</dt>
		<dd id="use_term"></dd>
	</dl>
	<dl class="infotxt">
		<dt id="use_area_tit">사용장소</dt>
		<dd id="use_area"></dd>
		<dt>유의사항</dt>
		<dd id="use_note"></dd>
		<dt>사용제한</dt>
		<dd id="use_limit"></dd>
		<dt>환불 및 문의</dt>
		<!--<dd id="use_info1">- 1644-5093</dd>
		<dd id="use_info2">- AM 09:30~PM18:00 (월~금 운영/공휴일휴무)</dd>-->
		<dd style="padding-bottom:0px;">쿠폰 유효기간 내 환불가능 ( 연장 불가 )</dd>
		<dd id="refund_info" style="display:none;padding-bottom:0px;"></dd>
		<dd style="padding-bottom:0px;">유효기간 경과 후 환불 및 연장 불가</dd>
		<dd style="padding-bottom:0px;">단, 쿠폰 오류에 한해서는 기간 만료 후에도 환불가능 (연장 불가 )</dd>
		<dd style="padding-bottom:0px;">쿠폰문의: 1644-5093 쿠프마케팅</dd>
		<dd style="padding-bottom:0px;">환불문의: 에누리 PC 고객센터</dd>
		<dd style="padding-bottom:0px;">상담시간: 9:30~18:00(주말, 공휴일 휴무)</dd>
	</dl>
	<p class="a_c">
		<button type="button" class="btn_default" id="btnFAQ">FAQ/문의하기</button> <button type="button" class="btn_default" id="btnBack">목록으로</button>
	</p>
</div>
<!--// 상세정보/유의사항 -->
<%@ include file="/mobilefirst/event2016/event_footer.jsp"%>
</div>
<div class="lay-check-password lay-comm" style="display: none;">
	<div class="lay-comm--body">
		<div class="form_title">비밀번호 확인</div>
		<div class="form_summary">본인확인을 위하여 비밀번호를 입력해주세요.</div>
		<input type="password" name="chk_password" id="user_pw" placeholder="비밀번호 입력">
		<button type="button" class="btn_check_pass" onclick="goPwChk();">확인</button>
	</div>
</div>
</body>
</html>
<script>
var vTitle = "상품 상세정보";
var vTerm = 0;
var gsYn = false;
var vPasschkcnt = 1;

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

var vPrice = <%=intItem_price %>;
var vItem = <%=intItem %>;
var vApp = "<%=strAppyn%>";
var isFormAction = false;

$(function() {
	if('<%=strAppyn %>' != 'Y'){
		$('#header .btn_hd_back').click(function(){
			history.back(-1);
		});

		$('#header .btn_hd_close').click(function(){
			window.location.replace("http://m.enuri.com/mobilefirst/index.jsp");
		});
  	}else{
		//title생성
		try{
				window.android.getEmoneyTitle(vTitle);
		}catch(e){}
	}

	var vData = {coupon_code: "<%=strCode %>"};
	var giftCode = "<%=strCode %>";

	$.ajax({
		type: "GET",
		url: "/mobilefirst/emoney/emoney_get_detail_info.jsp",
		data : vData,
		dataType:"JSON",
		success: function(json){
			if(json.RESULTCODE == "00"){
				<% if((Long.parseLong(nowDt) > Long.parseLong(strStart_time_sub)) && (Long.parseLong(nowDt) < Long.parseLong(strEnd_time_sub))){%>
					if(json.COMP_NAME == "해피콘"){
						alert("해피콘 시스템 개선 작업 중입니다.\n점검 중에는 해피콘 쿠폰 교환, 환불, 사용이 제한됩니다.\n점검시간 : 8.31(목) 23:50 ~ 9/1(금) 01:00");
						<%if(!strAppyn.equals("Y")){
							out.println("	window.close();");
						}else{
							out.println("	location.href='close://'");
						}%>
						return false;
					}

				<% }%>

				$("#title_img").html("<img src=\"https://image.multicon.co.kr/"+ json.COMP_CODE +"/"+ json.MENU_CODE +"/0002.jpg\" onerror=\"fn_img(this,'https://image.multicon.co.kr/"+ json.COMP_CODE +"/"+ json.MENU_CODE +"/0001.jpg');\" />");
				$("#goods_nm").html(json.COUPONNAME);
				$("#goods_price").html("<i class=\"icon_emoney_s16 comm__sprite\"></i>"+CommaFormattedN("<%=intItem_price %>") + "<em>점</em>");
				$("#use_company").html(json.COMP_NAME);
				$("#use_note").html(json.USE_NOTE.replace("���",""));
				$("#use_limit").html(json.USE_LIMIT.replace("���",""));
				$("#use_area_tit").hide();

				if( typeof json.USE_AREA == "undefined" ){
					$("#use_area").hide();
				}else{
					if( json.COMP_NAME.indexOf("나뚜루POP") > 0  ){
						$("#use_area").html("- "+ json.USE_AREA.replace("사용불가매장","/ 사용불가매장").replace("* 지급보증","<br>* 지급보증"));
					}else if(giftCode == "00A3840A00101" || giftCode == "00A3840G00101" || giftCode == "00A3840D00101" ){
						$("#use_area").html("- "+ json.USE_AREA.replace("(배달불가매장)","<br>- (배달불가매장)").replace("* 지급보증","<br>* 지급보증"));
					}else{
						$("#use_area").html(json.USE_AREA.replace("* 지급보증","<br>* 지급보증"));
					}
					$("#use_area_tit").show();
					$("#use_area").show();
				}

				$("#use_term").text("발급일로부터 "+ json.USE_TERM +"일");

				vTerm = json.USE_TERM;

				if(json.COUPONNAME.indexOf("[GS25] 모바일 금액권") > -1){
					$('#refund_info').text('편의점 모바일 상품권(플레이통) 금액권의 경우 쿠폰 사용 후 잔액 유효기간 내 환불 불가').show();
				}else if(json.COUPONNAME.indexOf("[Pay&apos;s] 한게임 디지털상품권") > -1){
					$('#refund_info').text('한게임(페이즈상품권) 금액권의 경우 쿠폰 사용 후 잔액 유효기간 내 환불 불가').show();
				}
			}
		},
		error: function (xhr, ajaxOptions, thrownError) {
			alert(xhr.status);
			alert(thrownError);
		}

	});

	$(".btn_default").click(function(){
		if(this.id == "btnFAQ"){
			location.href='http://m.enuri.com/mobilefirst/emoney/emoney_faq.jsp?freetoken=emoney_sub';
		}else{
			if(vApp=="Y"){
		    	if(window.android){		// 안드로이드
		    		window.location.href = "close://";
		    	}else{							// 아이폰에서 호출
		    		window.location.href = "close://";
		    	}
			}else{
				history.go(-1);
				return false;
			}

			ga('send', 'event', 'mf_emoney',  'click', '상점_쿠폰상세정보_목록으로');
		}
	});

 	 $(".btn_buy").click(function(){
		<% if(cUserId.equals("")){ %>
			alert('로그인 후 교환 가능합니다.');
			goLogin();
		<% }else { %>
			if(enuriOneIdChk()){
				goChangeChk();
			}
		<% } %>
	}); 
	ga('send', 'pageview', {
		'page': '/mobilefirst/emoney/emoney_detail.jsp',
		'title': 'mf_emoney_구매하기'
	});
});

function fn_img(obj,img){
	if((vItem >= 219 && vItem <= 228) || (vItem >= 401 && vItem <= 410)){
		obj.src = "http://img.enuri.info/images/mobilefirst/emoney/detail/@"+vItem+".jpg";
	}else{
		obj.src = img;
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

function buyCoupon(){
	if(confirm("교환하시겠습니까?") > 0){
		var gift_seq = "<%=intSeq %>";
		var gift_code = "<%=strCode %>";
		var url = "";

		(vApp === "Y")
		? url = "/mobilefirst/emoney/emoney_use.jsp"
		: url = "/estore/api/couponBuy.jsp";

		CmdSpin('on');
		
		$.ajax({
			type: "GET",
			url: url,
			data: "gift_seq="+gift_seq+"&gift_code="+gift_code+"&gift_term="+ vTerm +"&chk_id=<%=strChk_id%>",
			success: function(data){
				CmdSpin('off');
				if(data.indexOf("00") > -1){
					alert("교환완료! [보유 e쿠폰]에서 확인 가능합니다. \n※ 유효기간을 꼭 확인하세요!");
					CmdSpin('off');
					location.href="https://"+location.host+"/mobilefirst/emoney/emoney_couponbox.jsp";
				}else{
					alert("쿠폰발행 중 오류가 발생했습니다. \n\n잠시후 다시 시도하세요.");
					CmdSpin('off');
					return;
				}
			},
			error : function(result) {
				//alert("error");
				CmdSpin('off');
			}
		});
	}
}
function goChangeChk(){
    $.ajax({
        type: "POST",
        url: "/estore/api/getEcouponChangeChk.jsp",
        data: {"seq" : "<%=intSeq%>" },
        dataType : "JSON",
        success: function(result) {
            if(result.code==99){
                alert('이벤트 부정참여가\n발견되어 e머니 사용이\n중지 되었습니다.\n\n법적 손해배상청구를\n진행예정이오니\n고객센터로\n확인해주십시오.\n\n[고객센터 02-6354-3601]');
                return false;
            }else if(result.code==96){
                alert("SNS회원의 경우 에누리 앱에서만 교환 가능합니다.");
			    return false;
            }else if(result.code==97){
                if(confirm("e쿠폰 교환하기는 본인인증 후 가능합니다.\n본인인증 화면으로 이동할까요?")){
					location.href = "<%=strDomain %>/mobilefirst/member/myAuth.jsp?freetoken=login_title&cmdType=modify&f=m";
					return false;
				}else{
					return false;
				}
            }else if(result.code==95){
                alert('※시스템 점검 안내※\n안정적이고 보다 나은 서비스 제공을 위해\n시스템 점검 중입니다.\n점검 중에는 쿠폰 교환, 환불, 사용이 제한됩니다.\n\n점검시간 : 4/28(목) 01:00~09:00 ');
				return false;
            }else if(result.code==94){
                alert("e머니가 부족합니다.");
                return false;
            }else {
               (vApp=="Y")
				? buyCoupon()
				: openModalPopup('.lay-check-password');
            }
        },
        error: function() {		    	  
        }
    });
}

function goPwChk(){
	var user_pwObj = $("#user_pw");

	if(vPasschkcnt > 3){
		alert("비밀번호 확인 후 다시 시도 하십시오.");
		history.back();
		return false;
	}

	if(user_pwObj.val()=="") {
		alert("비밀번호를 입력해 주세요.");
		user_pwObj.focus();
		return false;
	}

	if(!isFormAction) {
		isFormAction = true;

		var res_data = '';

		$.ajax({
			type: "POST",
			url: '/member/ajax/infoPwChkAjax.jsp',
			data: {userId: '<%=cUserId%>', userPw: user_pwObj.val()},
			success: function(response) {
				res_data = response.trim();
				isFormAction = false;

				if(res_data=='true'){
					user_pwObj.val("");
					closeModalPopup('.lay-check-password');
					buyCoupon();
				} else {
					alert('비밀번호가 일치하지 않습니다.');
					user_pwObj.val("");
					vPasschkcnt++;
					return;
				}
			},
			error: function() {
				alert('잠시만 기다려 주십시오.');
				isFormAction = false;
			}
		});
	} else {
		alert("처리 중 입니다.");
	}
}

function openModalPopup(elem) {
	var target = $(elem);
	var target_pos_width = target.width();
	var target_pos_height = target.height();
	target.before('<div class="lay_overlay"></div>')
	target.css({
		'margin-top': -(target_pos_height/2),
		'margin-left': -(target_pos_width/2),
	})
	target.fadeIn();

	target.prev().on('click', function(){
		closeModalPopup(elem);
	});
	$('.btn_close', target).on('click', function(){
		closeModalPopup(elem);
	});
}

function closeModalPopup(elem) {
	var target = $(elem),
		target_overlay = $('.lay_overlay');
	target_overlay.fadeOut(function(){$(this).remove();});
	target.fadeOut();
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
function enuriOneIdChk(){ 
    var returnFlag = false;
	var blEnuriOneIdConfirm = true;
	
	if(blEnuriOneIdConfirm) {
		$.ajax({
			type : "POST",
			url : "/my/api/enuriOneIDCheck.jsp",
			async : false,
			dataType : "JSON",
			success : function(json){
				if(json.result.userid != "" && !json.result.checked){
					if(confirm("여러 개의 계정을 하나의 에누리 계정으로 통합하여 편리하게 서비스를 이용해보세요.")){
						location.href = "https://"+location.hostname+"/my/enuriOneID.jsp?freetoken=login_title";
					}
					returnFlag = false;
				}else {
					returnFlag = true;
				}
			}      
		});
	}
    return returnFlag;
}
//뒤로 #추가
$('#header .btn__sr_back').click(function(){
    history.back(-1);
});
</script>
<% } %>