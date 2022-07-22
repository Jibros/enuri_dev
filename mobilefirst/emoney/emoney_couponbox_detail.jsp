<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.mobile.Reward_Data"%>
<%@ page import="com.enuri.bean.mobile.Emoney_Proc"%>
<%@ page import="com.enuri.bean.member.Login_Proc"%>
<jsp:useBean id="Reward_Data" class="com.enuri.bean.mobile.Reward_Data" scope="page" />
<jsp:useBean id="Emoney_Proc" class="com.enuri.bean.mobile.Emoney_Proc" scope="page" />
<jsp:useBean id="Login_Proc" class="com.enuri.bean.member.Login_Proc"  />
<%
String cUserId = cb.GetCookie("MEM_INFO","USER_ID");
String cUserNick = cb.GetCookie("MEM_INFO","USER_NICK");
String strDevice = ChkNull.chkStr(request.getParameter("device"), "");
//cUserId = "cherub1004";  

if(cUserId.equals("yongcom")){
	out.println("<script>alert('이벤트 부정참여가\n발견되어 e머니 사용이\n중지 되었습니다.\n\n법적 손해배상청구를\n진행예정이오니\n고객센터로\n확인해주십시오.\n\n[고객센터 02-6354-3601]');history.go(-1);</script>");
}else{
	
	int iCoupon = ChkNull.chkInt(request.getParameter("coupon_seq"), 0);
	
	String strUserid = "";
	String strCoupon_img  = "";
	String strCode = "";
	String strIsuse = "";
	String strRefund_date = "";
	String strRefund_status = "";
	int intSeq = 0;
	
	Cookie[] carr = request.getCookies();
	String strAppyn = "";
	String strVerios = "";
	String strAd_id = "";
	int intVerios = 0;
	 
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
	if(!strAppyn.equals("Y") && szRemoteHost.indexOf("58.234.199.")<0){
		response.sendRedirect("/mobilefirst/Index.jsp");
	} 
	
	
	Emoney_Proc emoney_proc = new Emoney_Proc(); 
	Reward_Data reward_data[] = emoney_proc.get_CouponOne(iCoupon);
	
	// 현재 날짜
	Calendar calendar = Calendar.getInstance();
	SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
	String cur_date = format.format(calendar.getTime());
	
	int iEdate = 0;
	int iCdate = 0;
	
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
		//out.println("	alert('시스템 개선 작업 중입니다.\\n점검 중에는 쿠폰 교환 및 환불, 쿠폰사용이 제한됩니다.\\n\\n점검시간 : 7.28(금) 00:00~09:00');");
		out.println("	alert('안정적이고 보다 나은 서비스 제공을 위해 시스템 점검 중입니다.\\n점검 중에는 쿠폰 교환 및 환불, 쿠폰사용이 제한됩니다.\\n\\n점검시간 : 4/28(목) 01:00 ~ 09:00');");
		if(!strAppyn.equals("Y")){
			out.println("	history.back();");	
		}else{
			out.println("	location.href='close://'");
		}
		out.println("</script>");
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

<%if(reward_data.length > 0){%>
	<%
	int i =0;
	strUserid = reward_data[i].getUserid();
	strCoupon_img = reward_data[i].getCoupon_img();
	strCode = reward_data[i].getGift_code();
	strIsuse = reward_data[i].getIs_use();
	strRefund_date = reward_data[i].getRefund_date();
	strRefund_status = reward_data[i].getRefund_status();
	
	iEdate = Integer.parseInt(reward_data[i].getCoupon_edate().replaceAll("-",""));
	iCdate = Integer.parseInt(cur_date);
	String ltg_usr_id = Login_Proc.getEnuriOneID(strUserid);	//통합회원 id 

	%>
	<%if(cUserId.equals(strUserid) || cUserId.equals(ltg_usr_id)){%>
	
	<!-- 상품이미지 -->
	<div class="goods">
		<section class="w_box">
			<div class="coupon_img">
				<%if(strIsuse.equals("1")){%>
				<span class="end">사용<br />완료</span><p class="layer_back"></p><!-- 사용 완료일 경우 -->
				<%}else if(iEdate < iCdate){%>
				<span class="end">기간<br />만료</span><p class="layer_back"></p><!-- 기간 만료일 경우 -->
				<%}else if(strRefund_status.equals("1")){%>
				<span class="end">환불<br />완료</span><p class="layer_back"></p><!-- 환불 완료일 경우 -->
				<%}%>
				<img src="<%=strCoupon_img%>" alt="모바일쿠폰" />
			</div>
		</section>
		
		<% if(strDevice.equals("P")){ %>
		<p class="ico_txt"><em class="mark ico_big_pc">PC</em>PC 스토어에서 문자(MMS)와 함께 발급된 쿠폰입니다.</p>
		<% }else{ %>
		<p class="ico_txt"><em class="mark ico_big_mobile">PC</em>모바일 스토어에서 발급된 쿠폰입니다.</p>
		<% } %>
		
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
			<dd>쿠폰 유효기간 내 환불가능 ( 연장 불가 )<br />
			유효기간 경과 후 환불 및 연장 불가<br />
			단, 쿠폰 오류에 한해서는 기간 만료 후에도 환불가능 (연장 불가 )<br />
			<%if(cUserId.equals(strUserid)){%>
			<span class="refund"><button id="btt_refund">환불요청</button></span>
			<%}%>
			</dd>
			<dd>쿠폰문의 : 1644-5093<br />
			e머니 적립 문의 : 에누리 PC 고객센터<br />
			상담시간 : 09:30~18:00 (주말, 공휴일 휴무)</dd>
		</dl>
		<p class="a_c">
			<button type="button" class="btn_default" id="btnFAQ">FAQ/문의하기</button> <button type="button" class="btn_default" id="btnBack">목록으로</button>
		</p>
	</div>
	<!--// 상세정보/유의사항 -->
	<%}%>
<%}%>
</div>
</body>
</html>
<script>

var vTitle = "쿠폰 상세정보";


$(function() {

	var vData = {coupon_code: "<%=strCode %>", seq : "<%=intSeq %>"};
	var vApp = "<%=strAppyn%>";
	var giftCode = "<%=strCode %>";
	
	$.ajax({ 
		type: "GET",
		url: "/mobilefirst/emoney/emoney_get_detail_info.jsp",
		data : vData,
		dataType:"JSON",
		success: function(json){ 
			if(json.RESULTCODE == "00"){
				$("#use_company").html(json.COMP_NAME);
				$("#use_note").html("- "+ json.USE_NOTE.replace("���",""));
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
			}
		},
		error: function (xhr, ajaxOptions, thrownError) {
			alert(xhr.status);
			alert(thrownError);
		} 
		
	});
	
	$(".btn_default").click(function(){
		//history.go(-1);
		ga('send', 'event', 'mf_emoney',  'click', '쿠폰상세정보_목록으로');
		
		if(this.id == "btnFAQ"){
			location.href='/mobilefirst/emoney/emoney_faq.jsp?freetoken=emoney_sub';
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
		}
	});
	
	$("#btt_refund").click(function(){
	<% if(blTime_check){ %>
		alert("시스템 개선 작업 중입니다.\n	점검 중에는 쿠폰 교환 및 환불, 쿠폰사용이 제한됩니다.\n\n점검시간 : 7.3(월) 00:00~09:00");
		return false;
	<% }else{ %>
		<% if(strIsuse.equals("1") || iEdate < iCdate){%>
			alert("기간만료나 사용완료된 쿠폰입니다.");
			return false;
		<% }else if(strRefund_status.equals("1")){%>
			alert("환불 완료 쿠폰입니다.");
			return false;
		<% }else{ %>
			ga('send', 'event', 'mf_emoney',  'click', '환불 버튼');
			
			//환불 가능여부 확인
			if(confirm("쿠폰을 환불 하시겠습니까?\n\n최초 교환시 e머니 적립 시점에 따라 환불되는 e머니의 유효기간이 다를 수 있습니다.") > 0){
				
				var vCoupon_id = "<%=iCoupon %>";
				var vCoupon_number = "<%=strCode %>";
				
				//alert("vCoupon_id="+vCoupon_id);
				//alert("vCoupon_number="+vCoupon_number);

				$.ajax({
					type: "GET",
					url: "/mobilefirst/ajax/rewardAjax/couponCancel.jsp",
					data: "coupon_id="+vCoupon_id+"&coupon_number="+vCoupon_number,
					success: function(data){
						if(data.indexOf("true") > -1){
							//alert("쿠폰 교환이 완료되었습니다.");
							alert("정상적으로 처리 되었습니다.");
							location.href="/mobilefirst/emoney/emoney_couponbox.jsp"; 
						}else{ 
							//alert(data); 
							alert("쿠폰발행 중 오류가 발생했습니다. \n\n잠시후 다시 시도하세요.");
							return;
						}
					}, 
					error : function(result) { 
						alert("쿠폰발행 중 오류가 발생했습니다. \n\n잠시후 다시 시도하세요.");
					}
				});
			}
		<%}%>
	<% } %>	
	});
	
 
	ga('send', 'pageview', {
		'page': '/mobilefirst/emoney/emoney_couponbox_detail.jsp',
		'title': 'mf_emoney_'+vTitle
	}); 
});

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

//title생성
try{ 
		window.android.getEmoneyTitle(vTitle);
}catch(e){}

</script>
<% 
	}	
} 
%>