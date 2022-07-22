<%@ page contentType="text/html; charset=utf-8"%>
<%@page import="java.util.logging.Logger" %>
<%@ page import="com.enuri.util.common.ChkNull"%>
<!DOCTYPE html> 
<html lang="ko">
<head>
	<meta charset="utf-8">	
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />	
	<script type="text/javascript" src="http://m.enuri.com/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<meta property="og:title" content="에누리 가격비교">
	<meta property="og:description" content="에누리 모바일 가격비교">
	<meta property="og:image" content="http://img.enuri.info/images/mobilenew/images/logo_enuri.png">
	<meta name="format-detection" content="telephone=no" />
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/default.css">
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/emoney.css">
	<script type="text/javascript">
			/*레이어*/
			function onoff(id) {
				var mid=document.getElementById(id);
				if(mid.style.display=='') {
				mid.style.display='none';
			}else{
				mid.style.display='';
				}
			}
	</script> 
</head>
<body class="layerbg">

<!--이용약관 -->
<div class="dim" id="agree" style="display:none;">
	<div class="myarea">
		<a  class="close" onclick="onoff('agree')">창닫기</a>
		<div class="my_info">
			<h4 class="lose"><em>e</em>머니 이용약관</h4>
			
			<div class="agree_list">
				<div class="scll">
					<dl class="infotxt">
					<dt>[e머니 이용약관]<br />제1조 (목적)</dt>
						<dd>이 약관은 회원이 에누리닷컴 주식회사(이하 "회사“)가 제공하는 에누리 리워드 서비스를 이용함에 있어 회사와 회원간의 권리, 의무 및 책임사항과 절차 등을 정하기 위해 마련되었습니다.</dd>
						<dt>제2조 (정의)</dt>
						<dd>이 약관에서 사용되는 용어의 정의는 다음과 같습니다.<br />
						1. 에누리 리워드 서비스(이하 “리워드서비스”)란 회원이 스마트폰 또는 특정 운영체제를 탑재한 모바일 기기(이하 “스마트폰 등 모바일 기기”)로 본 약관 제5조 1항에 기재한 행위를 완료할 경우, 회사가 그에 대한 포인트 또는 혜택을 제공하는 것을 말합니다.</dd>
						<dd>2. “회원”이란 본 약관에 동의한 후 리워드 서비스 이용계약을 체결하여 “리워드서비스”를 이용하는 고객을 말합니다.</dd>
						<dd>3."포인트"란 회원이 본 약관 제5조 1항에 기재한 행위를 완료하면 회사가 회원에게 혜택을 제공하기 위하여 무상으로 회사 시스템에 적립하는 리워드서비스 상의 데이터입니다. 회사는 포인트에 대해 “e머니”등의 명칭을 부여할 수 있습니다.</dd>
						<dd>4. "제휴컨텐츠"란 회사가 제3자(이하 “제휴사”)와 일정한 제휴 계약을 체결하여 회원에게 제공하는 컨텐츠를 말합니다.</dd>
						<dd>5. “e쿠폰”이란 일정한 금액이나 재화 또는 용역의 수량이 전자정보로 기재된 증표가 회원의 스마트폰 등 모바일 기기에 저장되고, 회원이 이를 제휴사에서 정한 몰 또는 오프라인 매장에 제시함으로써 증표에 기재된 내용에 따라 재화 또는 용역을 제공받을 수 있는 것을 말합니다.</dd>
						<dt>제3조 (약관의 게시 및 변경)</dt>
						<dd>1. 리워드서비스 이용계약은 회원이 본 약관에 동의하여 리워드서비스를 신청한 후, 회사가 이를 수락함으로써 체결됩니다.</dd>
						<dd>2. 이 약관을 회원이 알 수 있도록 리워드서비스 화면 및 회사 도메인(이하 "사이트")에 게시합니다.</dd>
						<dd>3. 회사는 필요에 따라 "약관의규제에관한법률", "정보통신망이용촉진및정보보호등에관한법률" 등 관련 법령을 위반하지 않는 범위 내에서 이 약관을 개정할 수 있습니다.</dd>
						<dd>4. 회사가 이 약관을 개정하는 경우 적용일자 및 개정사항을 명시하여 적용 30일 이전부터 적용일자 전일까지 공지합니다.</dd>
						<dd>5. 회사가 전항에 따라 개정약관을 공지할 때에 회원이 명시적으로 거부의 의사표시를 하지 않거나 회원 탈퇴 등 리워드서비스 이용계약을 해지하지 않는 경우 회원이 개정약관에 동의한 것으로 봅니다.</dd>
						<dd>6. 회사가 회원에게 본 약관의 개정을 공지하였음에도 불구하고 회원이 이를 알지 못하여 발생하는 피해에 대하여 회사는 책임지지 않습니다.</dd>
						<dt>제4조 (서비스 내용)</dt>
						<dd>1. 본 약관 제5조 1항에 기재된 행위를 완료한 회원에 대해 회사는 포인트를 제공하며, 회원은 본인의 포인트로 회사가 제휴한 e쿠폰 발급업체로부터 e쿠폰을 발급받을 수 있습니다.</dd>
						<dd>2. 회원은 발급받은 e쿠폰을 e쿠폰 발급업체가 지정한 사용처에서 사용처가 제공하는 재화 또는 용역 등을 제공받는 방법으로 시용할 수 있으며, 회사는 e쿠폰 발급업체가 지정한 사용처를 리워드서비스 화면에 게시합니다.</dd>
						<dd>3. 회원은 원활한 서비스 제공을 위해 리워드서비스와 관련된 상세한 내용을 사이트에서 확인 및 문의할 수 있습니다.</dd>
						<dd>4. 회사는 운영/기술상의 문제로 리워드서비스 내용을 변경/중지/종료할 수 있으며, 이 경우 회사는 회원의 기적립 된 포인트 혹은 적립예정 포인트에 대한 조치방법을 사이트에 공지합니다.</dd>
						<dd>5. 리워드서비스를 변경/중지/종료하는 경우 사유, 적용일자 등의 관련 내용을 그 적용일자 30일 이전부터 적용일자 전일까지 사이트에 공지합니다.</dd>
						<dt>제5조 (포인트의 적립과 사용)</dt>
						<dd>1. 회원이 사이트를 통해 상품을 구매하거나, 제휴컨텐츠 시청, 이벤트 참여 등의 일정한 행위를 완료하면 명시된 포인트가 적립됩니다.</dd>
						<dd>2. 회원은 리워드서비스를 이용하기 위하여 회사가 제공하는 가격비교 서비스를 통하여 회사와 제휴한 인터넷쇼핑몰에서 구매한 재화 또는 용역의 내역을 회사가 지정한 양식에 따라 회사에 제공하여야 하고, 회원은 스스로의 책임에 따른 판단으로 이러한 구매내역 제공 절차를 회사가 대행하도록 합니다. 회사의 대행은 회원이 재화 또는 용역을 구매한 인터넷쇼핑몰 등 제3자에 대한 관계에 있어서도 회원이 직접 구매내역을 제출하는 것과 완전히 동일하며, 회사는 회원의 스마트폰 등 모바일 기기 내에 저장된 정보 또는 기능에 접근하지 않으면 대행이 불가능한 경우 해당 정보 또는 기능에 접근할 수 있습니다.</dd>
						<dd>3. 회원은 참여하고자 하는 이벤트가 회원의 가족, 친구, 지인 등 제3자와 관련이 있는 경우 그 제3자의 동의 여부 등을 고려하여 스스로의 판단과 책임 하에 이벤트에 참여하는 것이며, 회원은 회사에 관련절차의 전부 또는 일부를 대행하도록 합니다.</dd>
						<dd>4. 회원은 적립된 포인트 내역을 리워드서비스 화면에서 확인할 수 있습니다.</dd>
						<dd>5. 포인트 적립 및 사용방법 등은 회사에서 정한 정책을 따르며, 회사는 해당 내용을 사이트에 게재 및 갱신합니다.</dd>
						<dd>6. 적립된 포인트 또는 포인트를 사용하여 발급 받은 e쿠폰의 사용처, 사용 방법 등은 제휴사와의 협의 상황에 따라 수시로 변경될 수 있습니다.</dd>
						<dd>7. 포인트 적립 한도는 전자금융거래법 등 관련 법령에 따라 수시로 변경될 수 있습니다.</dd>
						<dd>8. 포인트 적립 및 사용과 관련하여 발생하는 제세공과금은 회원의 부담으로 합니다.</dd>
						<dd>9. e쿠폰으로 사용처로부터 제공받은 재화 또는 용역에 관한 책임은 e쿠폰 발급업체나 사용처에 있습니다. 회사는 e쿠폰 또는 e쿠폰으로 사용처로부터 제공받은 재화 또는 용역 등에 대하여는 어떠한 책임도 지지 않습니다.</dd>
						<dd>10. 포인트로 발급받은 e쿠폰은 쿠폰상세설명에서 명시한 유효기간 내에는 포인트로 환불이 가능하며, 회원이 환불을 요청할 경우 회사는 e쿠폰을 중지/취소/소멸시키고 해당e쿠폰의 발급에 소요된 포인트의 100%를 해당 회원에게 재적립합니다. 단, 환불이 불가능한 일부 품목이 있을 수 있으며, 이 경우 쿠폰상세설명에 명시합니다.</dd>
						<dd>11. 쿠폰상세설명에서 명시한 유효기간이 만료된 미사용 e쿠폰은 포인트로 환불/재적립이 불가하며, e쿠폰에 기재된 재화 또는 용역의 제공, 금전 등의 지급이 불가합니다. 회사는 쿠폰상세설명에서 명시한 유효기간이 만료된 미사용 e쿠폰에 대해 어떠한 책임도 지지 않습니다.</dd>
						<dt>제6조 (포인트의 정정/취소/소멸)</dt>
						<dd>1. 포인트 적립에 오류가 발생한 경우 회원은 오류 발생일로부터 30일 이내에 회사에 정정을 신청 할 수 있으며, 정당한 요구임이 확인되면 회사는 정정신청일로부터 30일 이내에 정정합니다.</dd>
						<dd>2. 포인트의 적립, 유지, 사용, 소멸 조건은 회사의 사정에 따라 변경될 수 있으며, 이 경우 회사는 변경된 조건을 그 적용일자 30일 이전부터 적용일자 전일까지 사이트에 게재합니다. 해당 기간 내에 회원이 회사에 변경된 조건에 대한 거부의사를 표명하지 않은 경우, 변경된 소멸조건에 동의한 것으로 봅니다. 회원이 정당한 이유로 변경된 조건에 대해 거부의사를 표명한 경우, 회사는 해당 회원에 대해 합리적인 방법으로 조치합니다.</dd>
						<dd>3. 포인트는 회원탈퇴 즉시 소멸되며, 이에 대하여 회사는 어떠한 책임도 지지 않습니다.</dd>
						<dd>4. 회원이 제8조 1항의 내용을 위반한 경우 회사는 해당 회원의 포인트 적립, 사용과 e쿠폰 사용을 금하고, 기적립된 포인트는 0으로 정정시킬 수 있습니다. 단, 회사는 이러한 내용을 해당 회원에게 사유와 함께 즉시 개별 통보하며, 회원은 이에 대해 이의를 제기할 수 있습니다.</dd>
						<dd>5. 회사가 제공하는 가격비교 서비스를 통하여 회사와 제휴한 인터넷쇼핑몰에서 재화 또는 용역을 구매하여적립된 포인트는 적립일로부터 60일간 사용되지 않을 경우 적립일로부터 61일이 되는 날에 소멸됩니다. 회원은 소멸 예정 포인트를 포인트 내역 설정화면에서 확인할 수 있습니다. 단, 제휴컨텐츠를 시청/다운로드/설치/실행하거나 이벤트 참여 등을 통하여 적립된 포인트의 사용 기한은  해당 이벤트 페이지에 게재한 사용기한을 따릅니다.</dd>
						<dt>제7조 (회사의 의무)</dt>
						<dd>1. 회사는 관련 법령 또는 이 약관을 위반하지 않으며, 안정적인 서비스를 제공하기 위하여 최선을 다합니다.</dd>
						<dd>2. 회사는 회원의 개인정보 보호를 위해 보안시스템을 갖추어야 하며, 개인정보취급방침을 공시하고 준수합니다.</dd>
						<dd>3. 회사는 서비스와 관련된 회원의 의견이 정당하다고 인정할 경우 이를 처리하여야 합니다. 처리된 결과는 가능한 수단/채널을 통해 회원에게 통보합니다.</dd>
						<dt>제8조 (회원의 의무)</dt>
						<dd>1. 회원은 리워드서비스 이용과 관련하여 다음의 행위를 하여서는 안됩니다. 다음 행위를 한 것으로 판단되는 회원은 본 약관 제6조 4항의 적용을 받습니다<br />
						i. 회원가입 신청 시에 허위의 내용을 기재하거나, 제3자의 개인정보를 허락 없이 사용한 경우<br />
						ii. 포인트 부정적립, 부정사용 등 리워드서비스를 부정한 방법 또는 목적으로 이용한 경우<br />
						iii. 리워드서비스 이용 중 법률을 위반하거나 공공질서, 미풍양속을 해치는 경우<br />
						iv. 회사의 허락 없이 회사의 홈페이지, 사이트, 클라이언트 프로그램을 변경, 삭제 또는 해킹 등의 행위를 한 경우<br />
						v. 다른 회원의 ID, 이메일 계정 등의 개인정보를 수집하는 행위를 한 경우<br />
						vi. 범죄와의 결부, 법률 위반으로 판단되는 행위를 한 경우<br />
						vii. 본 약관상의 의무, 당사가 공지한 리워드서비스 운영 정책을 위반한 경우</dd>
						<dd>2. 회원은 본 약관 제5조 제2항에 따라 구매내역 제출을 회사에 대행하도록 함에 있어 회원과 제3자 또는 회사와 제3자 사이에 법적 분쟁이 발생할 경우 회원은 자신의 책임과 비용으로 회사를 면책시켜야 하며, 회사는 회원에게 어떠한 책임도 지지 아니합니다.</dd>
						<dd>3. 회원은 본 약관 제5조 제3항에 따른 제3자 관련 이벤트 등으로 인하여 회원과 제3자 또는 회사와 제3자사이에 법적 분쟁이 발생할 경우 회원은 자신의 책임과 비용으로 회사를 면책시켜야 하며, 회사는 회원에게 어떠한 책임도 지지 아니합니다.</dd>
						<dt>제9조 (저작권의 귀속 및 이용제한)</dt>
						<dd>1. 회사의 상표, 로고, 제공하는 서비스 및 광고내용에 관한 지적재산권 등의 권리는 회사에 귀속합니다.</dd>
						<dd>2. 회원은 서비스를 이용함으로써 얻은 정보를 회사의 사전 승낙 없이 복제, 송신, 출판, 배포, 방송 기타 방법에 의하여 영리목적으로 이용하거나 제3자에게 이용하도록 하여서는 안됩니다.</dd>
						<dt>제10조 (서비스 관련 분쟁해결)</dt>
						<dd>회사는 서비스 이용과 관련한 회원의 의견이나 불만 사항을 신속하게 처리합니다. 단, 신속한 처리가 곤란한 경우에는 그 사유와 처리일정을 회원에게 통보합니다.</dd>
						<dt>제11조 (개인정보보호의무)</dt>
						<dd>회사는 관련 법령이 정하는 바에 따라서 회원 정보를 포함한 개인정보를 보호하기 위하여 노력합니다. 이에 관해서는 관련 법령 및 회사의 "개인정보취급방침"에 의합니다.</dd>
						<dt>부칙</dt>
						<dd>(부칙) 본 약관은 2016년 09월 05일부터 시행됩니다.</dd>
				</div>
				<div class="a_c"><button type="button" class="btn_close" onclick="onoff('agree')">닫기</button></div>
			</div>

		</div>	
	</div>
</div>
<!--//이용약관 -->

<div  class="app_pop">
	<a  class="btnclose">닫기</a>
	<div class="mvisual">
		<h1>최저가 쇼핑하고 e머니로 적립 받자! 에누리 e머니 서비스 안내</h1>
	</div>

	<dl>
		<dt>에누리  e머니란?<!-- <button type="button" id="detail_emoney_info" class="btn_chg">혜택 상세보기</button></dt> -->
		<dd>에누리에서 결제금액의 일부를 e머니로 드립니다.</dd>
		<dd>적립된 e머니는 쿠폰스토어에서 사용 가능합니다.</dd>

		<dt>적립안내</dt>
		<dd>에누리에서 결제금액의 일부를 e머니로 드립니다.</dd>
		<dd>적립된 e머니는 쿠폰스토어에서 사용 가능합니다.</dd>
		<dd>배송비 및 취소, 환불 건은 제외됩니다.</dd>
		<dd>적립 종류에 따라 유효기간이 상이합니다.</dd>
	</dl>

	<div class="btnarea"><button type="button" class="btn_default" onclick="onoff('agree')">이용약관 보기</button> <button type="button" id="ramen_coupon_change_guide" class="btn_default">라면쿠폰 교환안내</button></div>
</div>

</body>
</html>

<%
	String strClose = ChkNull.chkStr(request.getParameter("close"),"Y");
%>
<script language="javascript">
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
	(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
	m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
	})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
	//런칭할때 UA-52658695-3 으로 변경
	ga('create', 'UA-52658695-3', 'auto');


// ga('send', 'pageview', {
// 	'page': '/mobilefirst/emoney/emoney_guid.jsp',
// 	'title': '[APP]라면백3차 설치프로모션>전면팝업'
// });
function isiPhone(){
    return (
        //Detect iPhone
        (navigator.platform.indexOf("iPhone") != -1) ||
        //Detect iPod
        (navigator.platform.indexOf("iPod") != -1) ||
        //Detect iPod
        (navigator.platform.indexOf("iPad") != -1)
    );
}


$(function() {	
	

	var Type;
	if("<%=strClose%>".indexOf("N")!=-1)
	{
		 $(".btnclose").hide();
		 Type = "popup";
	}
	else
	{ 
		 $(".btnclose").show();
		 Type = "detail";
	}
	$(".btnclose").click(function(){
				window.location.href = "close://";
		});

	$("#ramen_coupon_change_guide").click(function(){
		// ga('send','event','mf_event','[APP]라면백3차 설치프로모션>설치','이동');
		if(Type.indexOf("detail")!=-1)
		{
			if(isiPhone()){
				location.href ="/mobilefirst/emoney/info.jsp?freetoken=eventclone";
			}else{	
				location.href ="/mobilefirst/emoney/info.jsp?app=Y&freetoken=eventclone";
			}
		}else
		{
			if(isiPhone()){
				location.href ="eventdetailurl:///mobilefirst/emoney/info.jsp";
			}else{	
				location.href ="eventdetailurl:///mobilefirst/emoney/info.jsp?app=Y";
			}
		}
		
 	});
 	// $("#detail_emoney_info").click(function(){
		// // ga('send','event','mf_event','[APP]라면백3차 설치프로모션>구매','이동');
		// if(Type.indexOf("detail")!=-1)
		// {
		// 	if(isiPhone()){
		// 		location.href ="/mobilefirst/event/event_payback.jsp?freetoken=eventclone";
		// 	}else{	
		// 		location.href ="/mobilefirst/event/event_payback.jsp?app=Y&freetoken=eventclone";
		// 	}
		// }else
		// {
		// 	if(isiPhone()){
		// 		location.href ="eventdetailurl:///mobilefirst/event/event_payback.jsp";
		// 	}else {
		// 		location.href ="eventdetailurl:///mobilefirst/event/event_payback.jsp?app=Y";
		// 	}
		// }
		
 	// });
	
});

</script>
<script language="JavaScript" src="http://img.enuri.info/common/js/Log_Tail_Mobile.js"></script>