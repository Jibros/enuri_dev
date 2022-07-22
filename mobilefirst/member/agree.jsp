<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="sun.misc.BASE64Encoder"%>
<%@ page import="sun.misc.BASE64Decoder"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%!
String LOGIN_URL = "https://m.enuri.com/member/login/login.jsp";
String BACK_URL = "location.href='" + LOGIN_URL + "'";
public String getAlertScript(String msg){
	String script = "<script>"
                   + "alert('" + msg + "');"
                   + BACK_URL
                   + "</script>";
	return script;
}
%>

<%
/**
이 파일은 SSL 서버에 업로드해야 합니다.
*/
String strApp = ChkNull.chkStr(request.getParameter("app"),"");	 //	Y일때 앱
String strAppid = ChkNull.chkStr(request.getParameter("appid"),"");

//APP
Cookie[] carr = request.getCookies();
try {
	for(int i=0;i<carr.length;i++){
	    if(carr[i].getName().equals("appYN")){
	    	strApp = carr[i].getValue();
	    	break;
	    }
	}
	for(int i=0;i<carr.length;i++){
	    if(carr[i].getName().equals("appid")){
	    	strAppid = carr[i].getValue();
	    	break;
	    }
	}
} catch(Exception e) {
}
String referer = request.getHeader("referer");
String rtnurl = referer;

if( request.getParameter("rtnurl") != null ){
	rtnurl = request.getParameter("rtnurl");
}

if(rtnurl == null) rtnurl = "/";
BASE64Encoder encoder = new BASE64Encoder();
String encode = encoder.encode( rtnurl.getBytes() );

//디바이스가 PC일 경우 해당페이지로

if(!strApp.equals("Y")){
	if (!((ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Linux") >= 0 ) ||  (ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Mac") >= 0))){
		response.sendRedirect("/member/join/join.jsp");
		return;
	}
}

//SSL
	String ENURI_COM_SSL = "https://m.enuri.com";

	String serverName = request.getServerName();
	/* if(serverName.indexOf("stagedev.enuri.com")>-1) {
		ENURI_COM_SSL = "http://"+serverName;
	}else if(serverName.indexOf("100.100.100.151")>-1 || serverName.indexOf("dev.enuri.com")>-1){
		ENURI_COM_SSL = "https://"+serverName;
	}else{
		ENURI_COM_SSL = "https://"+serverName;
	} */
		ENURI_COM_SSL = "https://"+serverName;

	//http -> https 로 넘겨줌
	String pUrl = request.getRequestURL().toString();
	String pUrl2 = request.getQueryString();

	/*if(pUrl.indexOf("http://www.enuri.com/") > -1 || pUrl.indexOf("http://m.enuri.com/") > -1 || pUrl.indexOf("http://dev.enuri.com/") > -1 || pUrl.indexOf("http://stagedev.enuri.com/") > -1){
		pUrl = pUrl.replace("http://","https://");
		if(pUrl2 != null){
			pUrl = pUrl + "?"+pUrl2;
		}
		response.sendRedirect(pUrl);
		return;
	}*/

/* //SSL
String ENURI_COM_SSL = "https://m.enuri.com";

String serverName = request.getServerName();
if(serverName.indexOf("stagedev.enuri.com")>-1 || serverName.indexOf("124.243.126.151")>-1 || serverName.indexOf("dev.enuri.com")>-1) {
	ENURI_COM_SSL = "http://"+serverName;
} */


/* boolean bRefererOk = false;
String header =     StringUtils.defaultString(request.getHeader("referer"), "");
bRefererOk = header.contains(LOGIN_URL);
if(!bRefererOk){
    out.println(getAlertScript("잘못된 경로로 이 페이지에 접근하셨습니다"));
    return;
}  */
%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
	<meta property="og:title" content="에누리 가격비교">
	<meta property="og:description" content="에누리 모바일 가격비교">
	<meta property="og:image" content="/images/mobilefirst/images/logo_enuri.png">
	<meta name="format-detection" content="telephone=no" />
	<script type="text/javascript" src="/common/js/lib/jquery-1.9.1.min.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=ENURI_COM_SSL%>/css/home/default.css">
	<link rel="stylesheet" type="text/css" href="<%=ENURI_COM_SSL%>/css/home/member.css"/>
	<script>
	(function(a_,i_,r_,_b,_r,_i,_d,_g,_e){if(!a_[_b]){var d={queue:[]};_r.concat(_i).forEach(function(a){var i_=a.split("."),a_=i_.pop();i_.reduce(function(a,i_){return a[i_]=a[i_]||{}},d)[a_]=function(){d.queue.push([a,arguments])}});a_[_b]=d;a_=i_.getElementsByTagName(r_)[0];i_=i_.createElement(r_);i_.onerror=function(){d.queue.filter(function(a){return 0<=_i.indexOf(a[0])}).forEach(function(a){a=a[1];a=a[a.length-1];"function"===typeof a&&a("error occur when load airbridge")})};i_.async=1;i_.src="//static.airbridge.io/sdk/latest/airbridge.min.js";a_.parentNode.insertBefore(i_,a_)}})(window,document,"script","airbridge","init fetchResource setBanner setDownload setDownloads setDeeplinks sendSMS sendWeb setUserAgent setUserAlias addUserAlias setMobileAppData setUserId setUserEmail setUserPhone setUserAttributes clearUser setDeviceIFV setDeviceIFA setDeviceGAID events.send events.signIn events.signUp events.signOut events.purchased events.addedToCart events.productDetailsViewEvent events.homeViewEvent events.productListViewEvent events.searchResultViewEvent".split(" "),["events.wait"]);
	airbridge.init({
	    app: 'enuri',
	    webToken: 'f430f10352c54cc9aa2203b98e67be9e'
	});
	</script>
</head>
<body>

<div class="memberwrap">
	<header>
		<a href="javascript:history.back(-1);" class="back"></a>
		<h1>회원가입</h1>
		<h2>ENURI</h2>
	</header>


	<form method="post" name="agreeForm" action="/mobilefirst/member/join.jsp">
		<input type="hidden" id="agree_chk1" name="agree_chk1" value=""/>
		<input type="hidden" id="agree_chk2" name="agree_chk2" value=""/>
		<input type="hidden" id="agree_chk3" name="agree_chk3" value=""/> <!-- 개인정보 수집 및 이용안내 -->
		<input type="hidden" id="agree_chk4" name="agree_chk4" value=""/> <!-- SMS/이메일 마케팅 수신동의  -->
		<input type="hidden" id="agree_all" name="agree_all" value=""/>
		<input type="hidden" id="app" name="app" value="<%=strApp%>"/>
		<input type="hidden" id="appid" name="appid" value="<%=strAppid%>"/>
		<input type="hidden" name="rtnurl" value="<%=encode%>">

	<div class="memberfield">
		<p class="txt_basic">에누리 회원가입을 위해 이용약관과 개인정보 수집 및 이용에 동의해주세요</p>

		<!-- 약관 영역 -->
			<ul class="terms_div">
				<li>
					<div class="terms_chk">
						<input type="checkbox" class="in_chk terms" id="terms_enuri01" name="in_chk"><label for="terms_enuri01" class="chkarea">에누리 이용약관 <b>(필수)</b></label>
						<a href="javascript:///" target="_new" class="ex_all"  onclick="showTerms()">전체</a>
					</div>
					<!-- scroll area -->
					<div class="terms_box">
						<div>
							<h3>제1조 (목적)</h3>

							<p>이 약관은 주식회사 써머스플랫폼이 운영하는 인터넷사이트 및/또는 모바일어플리케이션(이하 “회사”라 한다)에서 제공하는 에누리가격비교, 광고•마케팅 관련 서비스 등(이하 “서비스”라 한다)을 이용함에 있어 회사와 이용자의 권리•의무 및 책임 사항을 규정함을 목적으로 합니다. </p>
						</div>

						<div>
							<h3>제2조 (정의)</h3>

							<p>①“회사”라 함은 재화 또는 용역을 이용자에게 제공하기 위하여 컴퓨터 등 정보통신설비를 이용하여 재화 또는 용역을 거래할 수 있도록 설정한 가상의 영업장인 인터넷 쇼핑몰 및 그 인터넷쇼핑몰에서 제공하는 재화 또는 용역에 관한 정보를 제공하기 위하여 주식회사 써머스플랫폼이 설정한 인터넷사이트 및/또는 모바일어플리케이션을 말하며, 아울러 “서비스”를 운영하는 사업자의 의미로도 사용합니다.</p>
							<p>②“이용자”라 함은 회사의 인터넷사이트 및/또는 모바일어플리케이션에 접속하여 이 약관에 따라 회사가 제공하는 서비스를 받는 회원 및 비회원을 말합니다.</p>
							<p>③“회원”이라 함은 회사에 개인정보를 제공하여 회원등록을 한 자로서, 회사의 정보를 지속적으로 제공받으며 회사가 제공하는 서비스를 계속적으로 이용할 수 있는 자를 말합니다.</p>
							<p>④“비회원”이라 함은 회원등록을 하지 않고 회사가 제공하는 서비스를 이용하는 자를 말합니다.</p>
							<p>⑤“구매자”라 함은 인터넷 쇼핑몰에서 제공하는 재화 또는 용역을 구입할 의사를 회사가 온라인으로 제공하는 양식에 맞추어 밝힌 이용자를 말합니다.</p>
							<p>⑥“제휴사”라 함은 회사와 계약 하에 재화 또는 용역의 노출 및 광고를 목적으로 회사에 정보를 제공하고 있는 인터넷쇼핑몰을 말합니다.</p>
						</div>

						<div>
							<h3>제3조 (약관의 명시와 개정)</h3>

							<p>①“회사”는 이 약관의 내용과 상호, 영업소 소재지, 대표자의 성명, 사업자등록번호, 연락처를 이용자가 알 수 있도록 “회사”의 서비스화면에 게시합니다.</p>
							<p>②“회사”는 약관의 규제에 관한 법률, 전자문서 및 전자거래기본법, 전자서명법, 정보통신망이용촉진 및 정보보호 등에 관한 법률, 소비자기본법 등 관련법을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다.</p>
							<p>③“회사”가 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행약관과 함께 공지사항 및 초기화면에 그 적용 일자 30일 이전부터 적용일자 전일까지 공지합니다.</p>
							<p>④이 약관에서 정하지 아니한 사항과 이 약관의 해석에 관하여는 관계법령 또는 상관례에 따릅니다.</p>
							<p>⑤”회사”가 전 항에 따라 개정약관을 공지할 때에 이용자가 명시적으로 거부의 의사를 표시하지 않거나 이용계약을 해지하지 않는 경우 개정약관에 동의한 것으로 봅니다.</p>
							<p>⑥”회사”가 이용자에게 이용약관의 변경을 공지하였음에도 불구하고 이용자가 이를 알지 못하여 발생하는 피해에 대하여 “회사”는 책임지지 않습니다.</p>
						</div>

						<div>
							<h3>제4조 (서비스의 제공 및 한계)</h3>

							<p>①“회사”는 다음과 같은 업무를 수행합니다.
								<span>가. 제휴사에서 판매하는 재화 또는 용역의 가격 및 상품정보를 제공</span>
								<span>나. 재화 또는 용역에 대한 정보 제공 및 이용자와 제휴사의 구매계약의 중개</span>
								<span>다.기타 본 조항에서 정한 업무에 부수한 업무</span>
							</p>
							<p>②이용자는 “회사”가 별도 고지한 서비스에 있어서 이용약관, 개인정보처리방침 및 기타 “회사”가 공지하는 사항을 항상 숙지해야 하며, 이를 숙지하지 못해 생기는 불이익은 이용자에게 있습니다.</p>
							<p>③“회사”가 제공하는 서비스는 이용자와 제휴사 간에 재화 또는 용역을 거래할 수 있도록 “회사”의 이용을 허락하거나 제휴사의 재화 또는 용역의 정보를 제공하는 것만을 목적으로 합니다. “회사”는 제휴사가 “회사”에 제공하는 재화 또는 용역의 정보에 관해 제휴사의 판매의사의 존부 및 진정성, 제휴사 상품 또는 용역의 품질, 완전성, 적법성 및 타인의 권리에 대한 비침해성, 제휴사가 “회사”에 제공하는 상품 또는 용역에 관련된 정보의 진실성, 적법성 등 일체에 대하여 보증하지 아니하며, 이와 관련한 일체의 위험과 책임(배송, 교환, 반품 등 상품 판매에 관한 모든 사항을 포함)을 부담하지 않습니다.</p>
						</div>

						<div>
							<h3>제5조 (서비스의 중단)</h3>

							<p>①“회사”는 컴퓨터 등 정보통신설비의 보수점검•교체 및 고장, 통신의 두절 등의 사유가 발생한 경우에는 서비스의 제공을 사전 예고 없이 일시적으로 또는 상당한 기간 동안 중단할 수 있습니다.</p>
							<p>②제1항에 의한 서비스 중단의 경우에는 “회사”는 제8조에서 정한 방법으로 이용자에게 통지합니다.</p>
							<p>③”회사”는 국가비상사태, 정전, 서비스 설비의 장애, 서비스 이용의 폭주, 기타 이에 준하는 불가항력으로 정상적인 서비스 이용에 지장이 있는 때에는 서비스의 전부 또는 일부의 이용을 제한하거나 정지할 수 있습니다.</p>

						</div>

						<div>
							<h3>제6조 (회원가입)</h3>

							<p>①이용자는 “회사”가 정한 가입 양식에 따라 회원정보를 기입한 후 이 약관에 동의한다는 의사 표시를 함으로서 회원가입을 신청합니다.</p>
							<p>②“회사”는 제1항과 같이 회원으로 가입할 것을 신청한 이용자 중 다음 각 호에 해당하지 않는 한 회원으로 등록합니다. </p>
								<span>가.가입신청자가 이 약관 제7조 제3항에 의하여 이전에 회원자격을 상실한 적이 있는 경우, 다만 제7조 제3항에 의한 회원자격 상실 후 3년이 경과한 자로서 “회사”의 회원 재가입 승낙을 얻은 경우에는 예외로 한다.</span>
								<span>나.등록 내용에 허위, 기재누락, 오기가 있는 경우</span>
								<span>다.버그 및 악성 프로그램을 이용하거나 시스템 취약점을 악용하여 부정한 방법으로 회원가입 신청을 한 경우</span>
								<span>라.14세 미만 아동인 경우</span>
								<span>마.다른 회원의 “서비스”이용을 방해하거나, 다른 회원의 정보나 명의를 임의 또는 무단으로 사용하는 경우</span>
								<span>바.사회공공질서나 미풍양속에 저해되는 회원이름 또는 아이디를 사용하는 경우</span>
								<span>사.부정한 용도나 영리를 추구할 목적으로 “회사”의 “서비스”를 이용하고자 하는 경우</span>
								<span>아.기타 “회사” 내부서비스 기준에 적합하지 않는 회원으로 판단되는 경우나 “서비스”의 제공이 곤란한 경우</span>
							<p></p>
							<p>③회원가입 계약의 성립시기는 “회사”의 승낙이 회원에게 도달한 시점으로 합니다.</p>
							<p>④회원은 제9조제1항에 의한 등록사항에 변경이 있는 경우, 즉시 전자우편 및 기타 방법으로 “회사”에 그 변경 사항을 알려야 합니다.</p>
							<p>⑤제1항에 따른 신청에 있어 “회사”는 회원의 종류에 따라 전문기관을 통한 실명확인 및 본인인증을 요청할 수 있습니다.</p>
							<p>⑥제2항에 따라 회원가입신청의 승낙을 하지 아니하거나 유보한 경우, “회사”는 원칙적으로 이를 가입신청자에게 알리도록 합니다.</p>
							<p>⑦”회사”는 회원에 대하여 “영화및비디오물의진흥에관한법률” 및 “청소년보호법”등에 따른 등급 및 연령 준수를 위해 이용제한이나 등급별 제한을 할 수 있습니다.</p>
						</div>

						<div>
							<h3>제7조 (회원 탈퇴 및 자격 상실 등)</h3>

							<p>①회원은 “회사”에 언제든지 탈퇴를 요청할 수 있으며 “회사”는 즉시 회원탈퇴를 처리합니다. 이 경우 회원탈퇴로 인한 불이익은 회원 본인이 부담하여야 합니다. 회원탈퇴 후 “회사”는 회원에게 부가적으로 제공한 각종 혜택을 회수할 수 있습니다.</p>
							<p>②탈퇴를 요청하여 회원 탈퇴가 이루어진 회원에 대해서는 “회사”는 탈퇴한 날로부터 7일이 경과할 때까지 회원 가입을 제한할 수 있습니다.</p>
							<p>③회원이 다음 각 호의 사유에 해당하는 경우, “회사”는 회원자격을 제한 또는 정지시킬 수 있습니다.
								<span>가.가입 신청 시에 허위 내용을 등록한 경우</span>
								<span>나.다른 사람의 “서비스” 이용을 방해하거나 그 정보를 도용하는 등 전자거래질서를 위협하는 경우</span>
								<span>다.“회사”를 이용하여 이 약관이 금지하거나 법령, 공서양속에 반하는 행위를 하는 경우</span>
								<span>라.기타 “회사”가 합리적인 판단에 기하여 “서비스”의 제공을 거부할 필요가 있다고 인정할 경우</span>
							</p>
							<p>④“회사”가 회원 자격을 제한•정지 시킨 후, 동일한 행위가 2회 이상 반복되거나 30일 이내에 그 사유가 시정되지 아니하는 경우 “회사”는 회원자격을 상실 시킬 수 있습니다.</p>
							<p>⑤“회사”가 회원자격을 상실 시키는 경우에는 회원등록을 말소합니다. 이 경우 회원에게 이를 통지하고, 회원등록 말소 전에 소명할 기회를 부여합니다. 단, “회사”는 제3항 각호의 사유에 해당하는 행위를 한 회원에 대해서는 제6조 제2항 가호에 의하여 회원자격 상실일로부터 3년간 정보를 보유합니다.</p>
							<p>⑥탈퇴하거나 회사가 회원자격을 상실시킨 회원 아이디의 재사용으로 인한 혼선 및 악의적인 도용을 방지하기 위해 “회사”는 탈퇴하거나 회원자격을 상실시킨 회원의 아이디 재사용을 금지할 수 있습니다.</p>
						</div>
						<div>
							<h3>제8조 (회원에 대한 통지)</h3>

							<p>①“회사”가 회원에 대한 통지를 하는 경우, 회원이 “회사”에 제출한 e-mail, SMS, 전화, 기타의 방법으로 통지할 수 있습니다.</p>
							<p>②“회사”는 불특정다수 회원에 대한 통지의 경우 1주일 이상 “회사” 게시판에 게시함으로써 개별 통지에 갈음할 수 있습니다.</p>
						</div>
						<div>
							<h3>제9조 (개인정보보호)</h3>

							<p>①“회사”는 이용자의 정보수집 시 최소한의 정보를 수집합니다. 다음의 각 목의 사항을 필수사항으로 하고, 그 외 사항은 선택사항으로 합니다.
								<span>가.성명</span>
								<span>나.희망ID</span>
								<span>다.비밀번호</span>
								<span>라.휴대폰 번호</span>
								<span>마.이메일주소</span>
							</p>
							<p>②“회사”는 이용자의 개인식별이 가능한 개인정보를 수집하는 때에는 반드시 당해 이용자의 동의를 받습니다.</p>
							<p>③“회사”는 수집한 개인정보를 당해 이용자의 동의 없이 수집목적 외로 이용하거나 제3자에게 제공할 수 없으며, 이에 대한 모든 책임은 “회사”가 집니다. 단, 제3자에게 제공되는 경우에는 “회사”의 귀책 사유가 있는 경우에만 책임을 집니다. 다만, 다음의 경우에는 예외로 합니다.
								<span>가.통계작성, 학술연구 또는 시장조사를 위하여 필요한 경우로서 특정 개인을 식별할 수 없는 형태로 제공하는 경우</span>
								<span>나.이용자의 제세공과금(원천징수 세금 포함) 관련 해당 기관(세무서 등)에 통보하는 경우</span>
								<span>다.“회사”가 제공하는 서비스의 질을 향상시키기 위한 당사의 비즈니스 파트너와의 제휴 서비스, 당사가 운영하거나 제휴한 콜센터의 텔레마케팅 서비스(보험, 신용카드 등)를 위하여 최소한의 정보(성명, 주소, 전화번호)를 이용하거나 보험사, 신용카드사 등의 비즈니스 파트너에게 제공하여 고객의 보험, 신용카드 관련 정보를 제공받는 경우</span>
								<span>라.“회사”의 사후 불만처리 업무 및 고객서비스 업무를 수행하는 제3자에게 최소한의 정보(성명, 주소, 전화번호)를 제공하는 경우</span>
							</p>
							<p>④“회사”가 제2항과 제3항에 의해 이용자의 동의를 받아야 하는 경우에는 개인정보관리 책임자의 신원(소속, 성명 및 전화번호 기타 연락처), 정보의 수집목적 및 이용목적, 제3자에 대한 정보제공 관련사항(제공 받는 자, 제공목적 및 제공할 정보의 내용) 등 정보통신망이용촉진및정보보호등에관한법률이 규정한 사항을 미리 명시하거나 고지해야 하며, 이용자는 언제든지 위 동의를 철회할 수 있습니다.</p>
							<p>⑤이용자는 언제든지 “회사”가 가지고 있는 자신의 개인정보에 대해 열람 및 오류정정을 요구할 수 있으며 “회사”는 이에 대해 지체 없이 필요한 조치를 취해야 합니다. 이용자가 오류의 정정을 요구한 경우에는 “회사”는 그 오류를 정정할 때까지 당해 개인정보를 이용하지 않습니다. 또한 회원이 수정하지 않은 정보로 인하여 발생하는 손해는 회원이 전적으로 부담하며, “회사”는 이에 대하여 아무런 책임을 지지 않습니다.</p>
							<p>⑥“회사”는 개인정보 보호를 위하여 관리자를 한정하고 그 수를 최소화하며, “회사”의 귀책사유로 인한 이용자의 개인정보의 분실, 도난, 유출, 변조 등으로 인한 이용자의 손해에 대하여 책임을 집니다.</p>
							<p>⑦“회사” 또는 그로부터 개인정보를 제공받은 제3자는 개인정보의 수집목적 또는 제공받은 목적을 달성한 때에는 당해 개인정보를 지체 없이 파기합니다.</p>
							<p>⑧이용계약이 종료된 경우,“회사”는 당해 회원의 정보를 파기하는 것을 원칙으로 합니다. 다만, 아래의 경우에는 회원 정보를 보관합니다. 이 경우 “회사”는 보관하고 있는 회원정보를 그 보관의 목적으로만 이용합니다.
								<span>가.상법, 전자상거래 등에서의 소비자보호에 관한 법률 등 관계법령의 규정에 의하여 보존할 필요가 있는 경우 “회사”는 관계법령에서 정한 일정한 기간 동안 회원 정보를 보관합니다.</span>
								<span>나.기타 정보수집에 관한 동의를 받을 때 보유기간을 명시한 경우에는 그 보유기간까지 회원정보를 보관합니다.</span>
							</p>
							<p>⑨“회사”는 회원정보의 보호와 관리에 관한 개인정보처리방침을 회원과 “회원”의 서비스를 이용하고자 하는 자가 알 수 있도록 서비스 초기화면에 게재합니다.</p>
						</div>

						<div>
							<h3>제10조 (정보의 제공 및 광고의 게재)</h3>

							<p>①“회사”는 회원이 서비스 이용 중 필요하다고 인정되는 다양한 정보를 공지사항이나 전자우편, 푸시메시지, SMS 등의 방법으로 회원에게 제공할 수 있습니다.</p>
							<p>②“회사”는 서비스의 운영과 관련하여 서비스 화면, 홈페이지, 전자우편 등에 광고를 게재할 수 있습니다. 광고가 게재된 전자우편, 푸시메시지 등을 수신한 "회원"은 필요 시 언제든지 수신거절을 할 수 있습니다.</p>
							<p>③제1항 및 제2항의 정보 중 전자우편, 푸시메시지, SMS를 전송하려고 하는 경우에는 회원의 사전 동의를 받아서 전송합니다. 다만, 회원의 거래관련 정보 및 고객문의 등에 대한 회신에 있어서는 제외됩니다.</p>
							<p>④이용자는 “회사”가 제공하는 서비스와 관련하여 게시물 또는 기타 정보를 변경, 수정, 제한하는 등의 조치를 취하지 않습니다.</p>
						</div>

						<div>
							<h3>제11조 (“회사”의 의무)</h3>

							<p>①“회사”는 법령과 이 약관이 금지하거나 공서양속에 반하는 행위를 하지 않으며 이 약관이 정하는 바에 따라 지속적이고, 안정적으로 서비스를 제공하는데 최선을 다하여야 합니다.</p>
							<p>②“회사”는 이용자가 안전하게 인터넷 서비스를 이용할 수 있도록 이용자의 개인정보 (신용정보포함)보호를 위한 보안 시스템을 갖추어야 합니다.</p>
							<p>③“회사”는 이용자가 원하지 않는 영리목적의 광고성 전자우편을 발송하지 않습니다.</p>
						</div>

						<div>
							<h3>제12조 (회원의 ID 및 비밀번호에 대한 의무)</h3>

							<p>①ID와 비밀번호에 관한 관리책임은 회원에게 있습니다.</p>
							<p>②회원은 자신의 ID 및 비밀번호를 제3자에게 이용하게 해서는 안됩니다.</p>
							<p>③회원이 자신의 ID 및 비밀번호를 도난 당하거나 제3자가 사용하고 있음을 인지한 경우에는 바로 “회사”에 통보 하고 “회사”의 안내가 있는 경우에는 그에 따라야 합니다.</p>
						</div>

						<div>
							<h3>제13조 (이용자의 의무)</h3>

							<p>이용자는 다음 행위를 하여서는 안됩니다.
								<span>가.신청 또는 변경 시 허위 내용의 기재</span>
								<span>나.“회사”에 게시된 정보의 무단변경</span>
								<span>다.“회사”가 정한 정보 이외의 정보(컴퓨터 프로그램 등)의 송신 또는 게시</span>
								<span>라.“회사” 또는 제3자의 저작권 등 지적재산권에 대한 침해</span>
								<span>마.“회사” 또는 제3자의 명예를 손상시키거나 업무를 방해하는 행위</span>
								<span>바.외설, 폭력, 기타 공서양속에 반하는 정보(화상, 음성 포함)를 “회사”에 공개 또는 게시하는 행위</span>
								<span>사. “회사”의 서비스를 이용자의 영리 목적으로 활용하는 행위</span>
							</p>
						</div>

						<div>
							<h3>제14조 (게시판 관련 규정)</h3>

							<p>①게시판 이용 원칙
								<span>가.“회사”는 이용자들이 게재하는 모든 정보를 임의로 통제하거나 제한하지 않습니다. 단, 제3항에서와 같은 사유로 인해 “회사”에서 임의의 조치를 취할 수 있습니다.</span>
								<span>나.게시물(이미지, 문구 및 첨부파일 등을 포함)로 인해 발생하는 저작권 침해를 비롯한 민,형사 상의 모든 책임은 당해 게시물의 게시자에게 있으며, “회사”는 이에 대해 책임지지 않습니다.</span>
							</p>
							<p>②게시물의 저작권
								<span>가.“회사”의 게시판에 등록된 게시물의 저작권은 제3자의 권리를 침해하지 않는 한, 게시한 이용자에게 속합니다.</span>
								<span>나.“회사”는 게시물 저작권자의 동의를 통해 이를 홍보 및 기타의 자료로 사용할 수 있습니다.</span>
							</p>
							<p>③게시물의 관리<br>
							“회사”는 다음과 같은 내용의 게시물의 등록을 금하며, 사전 통보 없이 게시물을 삭제하거나, 열람을 제한하거나, 쓰기를 금지하거나, 게시자의 회원자격을 박탈할 수 있습니다.
								<span>가.공공질서나 공서양속에 위배되는 내용</span>
								<span>나.타인의 권리나 개인정보, 명예, 신용 기타 정당한 이익을 침해하는 내용을 포함하는 경우</span>
								<span>다.범죄행위와 관련된 내용을 포함하는 경우</span>
								<span>라.허위 또는 과장 광고 내용을 포함하는 경우</span>
								<span>마.정치, 경제적 분쟁을 야기하는 내용을 포함하는 경우</span>
								<span>바.정보통신 설비의 오동작을 유발하거나, 혼란을 유발하는 컴퓨터 바이러스 또는 데이터를 포함하는 경우</span>
								<span>사.물품의 판매처, 연락처 등의 내용을 기재하여 물품의 직거래를 유도하는 경우</span>
								<span>아.“회사”의 영업행위의 원활한 진행을 방해한다고 판단되는 경우</span>
								<span>자.기타 대한민국의 관례, 법령에 위반되는 내용을 포함하는 경우</span>
							</p>
						</div>

						<div>
							<h3>제15조 (저작권의 귀속 및 이용제한)</h3>

							<p>①“회사”에 등록된 게시물의 저작권은 제3자의 권리를 침해하지 않는 한, 게시한 이용자에게 속합니다.</p>
							<p>②“회사”가 작성한 저작물에 대한 저작권, 기타 지적재산권은 “회사”에 귀속합니다.</p>
							<p>③이용자는 “회사”의 “서비스”를 이용함으로써 얻은 정보를 “회사”의 사전 승낙 없이 복제, 송신, 출판, 배포, 방송 기타 방법에 의하여 영리목적으로 이용하거나 제3자에게 이용하게 하여서는 안됩니다.</p>
							<p>④이용자가 창작하여 “회사”의 “서비스”에 게재 또는 등록한 게시물에 대한 저작권은 이용자 본인에게 있으며 해당 게시물이 제3자의 저작권, 기타 지적재산권을 침해하여 발생되는 모든 책임은 회원 본인에게 있습니다.</p>
							<p>⑤“회사”의 “서비스”에 게시물을 게재 또는 등록한 이용자는 해당 게시물의 영구적이고 사용료 없는 사용권을 “회사”에 부여하는 것에 동의한 것으로 간주합니다. 사용권은 회원 탈퇴 이후에도 유효하며, 세부사항은 아래와 같습니다.
								<span>가. “회사”가 제공하는 관련 “서비스” 내에서 게시물에 대한 복제, 전시, 배포, 편집 저작물 작성</span>
								<span>나. “회사” 제휴 파트너에게 이용자의 게시물 내용을 제공. 단, 아이디 외의 개인정보는 제공하지 않음</span>
								<span>다. 상기 사용권 외에 게시물을 상업적으로 이용하고자 할 경우 이용자의 사전동의를 얻어야 함. “회사”가 게시물을 상업적으로 이용할 경우 별도의 보상제도를 운영할 수 있음.</span>
							</p>
							<p>⑥이용자의 게시물에 대해 제3자로부터 저작권, 기타 권리의 침해로 이의가 제기된 경우 “회사”는 해당 게시물을 임의로 삭제할 수 있습니다. 해당 게시물을 게시한 이용자가 해당 게시물에 대한 법적 문제가 종결된 후 이를 근거로 “회사”에 신청을 하는 경우 “회사”는 삭제된 게시물을 다시 게재할 지 여부를 “회사”의 판단으로 결정합니다.</p>
							<p>⑦”회사”는 게시물이 다음 각 호에 해당하는 경우 사전 통보 없이 해당 게시물을 삭제하거나 게시한 이용자에 대하여 특정 서비스의 이용제한, 회원탈퇴 등의 조치를 할 수 있습니다.
								<span>가.대한민국의 법령을 위반하는 내용을 포함하는 경우</span>
								<span>나.관계 법령에 의거 판매가 금지된 불법제품 또는 음란물을 게시, 광고하는 경우</span>
								<span>다.허위 또는 과대광고의 내용을 포함하는 경우</span>
								<span>라.타인의 권리나 명예, 신용 기타 정당한 이익을 침해하는 경우</span>
								<span>마.직거래 유도 또는 타 사이트의 링크를 게시하는 경우</span>
								<span>바.정보통신기기의 오작동을 일으킬 수 있는 악성코드나 데이터를 포함하는 경우</span>
								<span>사.사회 공공질서나 미풍양속에 위배되는 경우</span>
								<span>아.“회사”가 제공하는 서비스의 원활한 진행을 방해하는 것으로 판단되는 경우</span>
							</p>
						</div>

						<div>
							<h3>제16조 (“회사”의 면책)</h3>

							<p>① “회사”가 이용자에게 제공하는 서비스는 거래중개 및 제휴사와의 온라인 거래를 위한 광고 마케팅이므로 제휴사와 이용자 상호 간의 거래와 관련된 제반 문제 즉, 거래이행, 물품배송, 청약철회 또는 반품, 물품하자로 인한 분쟁해결 등 필요한 사후처리는 거래당사자인 제휴사와 이용자가 직접 수행하여야 합니다. “회사”는 이에 대하여 관여하지 않으며 어떠한 책임도 부담하지 않습니다.</p>
							<p>② “회사”는 제5조 1항과 3항의 사유로 일시적 또는 종국적으로 서비스를 제공할 수 없는 경우, 서비스 제공에 관한 책임이 면제됩니다. 이 경우 “회사”는 제8조에서 정한 방법으로 이용자에게 통지합니다. 단, 부득이한 사유가 있는 경우에는 사후 통지도 가능합니다.</p>
							<p>③ “회사”는 인터넷 이용자 또는 제휴사 귀책사유로 인한 서비스 이용의 장애에 대하여 책임을 지지 않습니다.</p>
							<p>④ “회사”는 거래중개 서비스 및 광고•마케팅을 통하여 거래되는 물품의 하자, 물품등록정보의 오류, 미비 등으로 인하여 구매자가 입는 손해에 대해서는 책임(제조물 책임 포함)을 지지 않습니다.</p>
							<p>⑤ “회사”는 제휴사 혹은 이용자가 다른 제휴사 혹은 이용자가 게재한 정보, 자료, 사실의 정확성 등을 신뢰함으로써 입은 손해에 대하여 책임을 지지 않습니다.</p>
							<p>⑥ “회사”와 제휴사는 독자적으로 운영되며, “회사”는 제휴사와 이용자 간에 이루어진 거래에 대하여는 책임을 지지 않습니다.</p>
							<p>⑦ 이 약관은 “회사”와 이용자 간에 성립되는 서비스이용계약의 기본약정입니다. “회사”는 필요한 경우 특정 서비스에 관하여 적용될 사항(이하 "개별약관"이라고 합니다)을 정하여 미리 공지할 수 있습니다. 이용자가 이러한 개별약관에 동의하고 특정 서비스를 이용하는 경우에는 개별약관이 우선적으로 적용되고, 이 약관은 보충적인 효력을 갖습니다.</p>
							<p>⑧ 회원이 자신의 개인정보를 타인에게 유출 또는 제공함으로써 발생하는 피해에 대해서 “회사”는 일체의 책임을 지지 않습니다.</p>
							<p>⑨ “회사”는 무료로 제공하는 서비스 이용과 관련하여 관련 법령에 특별한 규정이 없는 한 이용자에게 손해가 생기더라도 책임지지 않습니다.</p>
						</div>

						<div>
							<h3>제17조 (재판관할 및 준거법)</h3>

							<p>①“회사”와 이용자 간에 발생한 분쟁에 관한 소송은 제소 당시의 이용자의 주소에 의하고, 주소가 없는 경우 거소를 관할하는 지방법원의 전속관할로 합니다. 단, 제소 당시 이용자의 주소 또는 거소가 명확하지 아니한 경우의 관할법원은 민사소송법에 따라 정합니다. </p>
							<p>②“회사”와 이용자 간에 제기된 소송에는 대한민국 법률을 적용합니다.</p>
						</div>

						<div>
							<p>(부칙) 본 약관은 2018년 8월 29일부터 시행됩니다.</p>
						</div>

					</div>
					<!-- //scroll area -->
				</li>
				<li>
					<div class="terms_chk">
						<input type="checkbox" class="in_chk terms" id="terms_enuri02"  name="in_chk"><label for="terms_enuri02" class="chkarea">개인정보 수집 및 이용안내 <b>(필수)</b></label>
						<a href="javascript:///" target="_new" class="ex_all" onclick="showPrivacy()">전체</a>
					</div>
					<!-- scroll area -->
										<div class="terms_box">
						<div>
							<p>회사는 이용자에게 다양하고 편리한 서비스를 제공하기 위하여 아래와 같은 개인정보를 수집하고 있습니다.</p>
						</div>
						<div>
							<h3>■	수집하는 개인정보 항목</h3>
							<p>- 필수입력 항목: 이름, ID, 비밀번호, 휴대폰 번호, 이메일주소, 쇼핑몰 결제정보(주문일자, 주문액, 주문ID, 주문품번, 배송상태), 디바이스 정보(기기 식별번호, Android/iOS ID), 광고ID, 에누리 모바일앱 설치 정보</p>
							<!-- <p>- 선택입력 항목: 성별, 생년월일, 주소, 닉네임, 휴대폰본인인증결과값(CI,DI,휴대폰번호,성별,생년월일)</p> -->
							<p>- 자동수집 항목: 접속IP, 쿠키(Cookie), 로그인 일자, 이용정지/해지 기록<!-- , 쇼핑몰 결제정보(주문일자, 주문액, 주문ID, 주문품번, 배송상태, 디바이스 정보(기기 식별번호, Android/iOS ID), 광고ID, 에누리 모바일앱 설치 정보 --></p>
						</div>

						<div>
							<h3>■	개인정보의 수집ㆍ 이용 목적</h3>

							<h4>[회원관리]</h4>
							<p>- 고지사항 전달, 본인의사 확인, 불만처리 등의 원활한 의사소통 경로의 확보</p>
							<p>- 개인정보 유효기간제 준수</p>
							<p>- 분쟁조정을 위한 기록보존</p>
							<p>- 불만처리 등 민원처리</p>
							<p>- 모바일앱 설치 및 구매 활동에 따른 이벤트 등 전용 서비스 제공을 위한 사용</p>

							<br />

							<h4>[서비스제공에 관한 계약의 이행 및 서비스 제공에 따른 요금 정산]</h4>
							<p>- 경품과 쇼핑 물품 배송에 대한 정확한 배송지의 확보</p>
							<p>- 각종 이벤트 관련 정보안내 및 당첨자 발표를 위한 ID 사용</p>

							<br />

							<h4>[에누리 이용에 대한 상담에 활용]</h4>
							<p>- 회원의 에누리 이용 전반에 대한 상담 및 안내</p>

							<br />

							<p>또한 회사는 회원가입을 만14세 이상인 경우에 가능하도록 하며, 법정대리인의 동의가 필요한 만14세 미만 아동의 개인정보는 수집 및 이용하지 않습니다.</p>
						</div>

						<div>
							<h3>■	개인정보의 보유 및 이용기간</h3>

							<p>에누리는 원칙적으로 이용자의 개인정보 수집 및 이용 목적이 달성되면 개인정보를 지체 없이 파기합니다. 또한 1년 이상 로그인하지 않은 미사용 계정의 경우 개인정보를 접속권한이 제한되어 있는 별도의 서버에 안전하게 분리 저장합니다.</p>

							<br />

							<p>단, 다음의 경우는 예외로 합니다.
								<span>1) 소비자불만 또는 분쟁처리에 관한 기록 (최대3년 보관)</span>
								<span>2) 계약 또는 청약철회 등에 관한 기록 (최대5년 보관) </span>
								<span>3) 대금결제 및 재화 등의 공급에 관한 기록 (최대5년 보관)</span>
								<span>4) 웹사이트 방문기록 (최대 3개월 보관)</span>
								<span>5) 회원탈퇴, 회원에서 제명된 경우의 회원 식별정보
									<span>- 재가입방지를 위함 (최대3년 보관)</span>
								</span>
								<span>6) 부정거래기록(IP주소, 쿠키, 기기정보)
									<span>- 부정거래 방지 및 다른 선량한 이용자의 보호를 위함 (최대3년 보관)</span>
								</span>
								<span>7) 회원ID와 게시물 기록
									<span>- 서비스이용의 혼선 방지를 위함 (영구보관)</span>
								</span>
							</p>
							<p>다만 이용자에게 개인정보 보관기간에 대해 별도의 동의를 얻은 경우, 또는 관련법령에서 일정 기간 정보보관 의무를 부과하는 경우에는 해당기간 동안 개인정보를 안전하게 보관합니다.</p>
						</div>
					</div>
					<!-- //scroll area -->
 				</li>
				<!--
				<li>
					<div class="terms_chk">
						<input type="checkbox" class="in_chk" id="terms_enuri03"  name="in_chk"><label for="terms_enuri03" class="chkarea">개인정보 마케팅 및 광고에 이용 (선택)</label>
						<a href="javascript:///" target="_new" class="ex_all" onclick="showMarketing()">전체</a>
					</div>
					<div class="terms_box">
						<div>
							<p>아래 목적을 위한 용도로 개인정보를 수집 및 활용할 수 있습니다.<br /><br />
								<span>- 마케팅 및 광고에 활용하고, 신규 서비스(제품) 개발 및 특화 이벤트 등 광고성 정보를 전달</span>
								<span>- 인구통계학적 특성에 따른 서비스 제공 및 광고 게재</span>
								<span>- 접속 빈도 파악 또는 회원의 서비스 이용에 대한 통계 등을 위함</span>
							</p>
						</div>
					</div>
				</li>
				 -->
				<li>
					<div class="terms_chk">
						<input type="checkbox" class="in_chk" id="terms_enuri03" name="in_chk"><label for="terms_enuri03" class="chkarea">개인정보 수집 및 이용안내 <b>(선택)</b></label>
					</div>
					<!-- scroll area -->
					<div class="terms_box">
						<div>
							<p>고객님께서는 동의를 거부하실 수 있으며, 동의를 거부하시는 경우에도 서비스는 이용이 가능합니다.</p>
						</div>
						<div>
							<h3>■	수집하는 개인정보 항목</h3>
							<p>- 선택항목: 성별, 생년월일, 주소, 닉네임, 휴대폰본인인증결과값(CI,DI,휴대폰번호,성별,생년월일), 일반전화번호</p>
						</div>

						<div>
							<h3>■	개인정보의 수집ㆍ 이용 목적</h3>

							<p>- 신규 서비스 개발과 마케팅 및 광고에 활용</p>
							<p>- 본인식별 절차에 이용, 성인컨텐츠 이용시 성인인증, 부정사용 방지</p>
							<p>- 에누리 조립PC 서비스 이용에 따른 주문, 배송업무를 위해 사용</p>
						</div>

						<div>
							<h3>■	개인정보의 보유 및 이용기간</h3>

							<p>선택항목으로 수집한 개인정보는 회원탈퇴 즉시 파기합니다.</p>
						</div>
					</div>
					<!-- //scroll area -->
				</li>
				 <!-- 191022 마케팅 수신동의 추가 / 14세 이동 동의 추가 마크업 위치 변경 -->
				<li>
					<div class="terms_chk">
						<input type="checkbox" class="in_chk" id="terms_enuri04" name="in_chk"><label for="terms_enuri04" class="chkarea">SMS/이메일 마케팅 수신동의 <b>(선택)</b></label>
					</div>
				</li>
				 <li>
					 <div class="terms_chk">
						<input type="checkbox" class="in_chk" id="terms_enuri05" name="in_chk"><label for="terms_enuri05" class="chkarea">만 14세 이상 서비스이용 동의 <b>(필수)</b></label>
					 </div>
				 </li>
				<!-- // -->
			</ul>
			<!-- //약관 영역 -->
		<!-- <p class="txt_basic">에누리 이용약관, 개인정보 수집 및 이용안내에 모두 동의해 주세요</p>
 -->
		<button type="button" class="btn_agree" id="btn_agree"><span class="ag">모두 동의</span></button>
		<button type="button" class="btn_agree next" id="btn_join">다음 단계</button>

		<!-- <button type="submit" class="btn_agree on"><span class="ag">모두 동의<em>(선택항목 포함)</em></span></button>
		<button type="submit" class="btn_join">다음 단계</button> -->

		<!-- 20190327 카피라이터 추가 -->
		<div class="mb_footer">
			<!-- container -->
			<div class="container">
				<p class="copyright">Copyright ⓒ SummercePlatform Inc. All rights reserved.</p>
			</div>
		</div>
		<!-- // -->

	</div>
	</form>
</div>

</body>
<script type="text/javascript">
		var vApp = "<%=strApp%>";

		if(vApp === 'Y'){
			$(window).load(function(){
				if(confirm('신규 가입은 업데이트된 버전에서만 가능합니다. 신규 버전으로 앱을 업데이트 하시겠습니까?')){
					if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
						window.location.href = "https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8";
					}else if(navigator.userAgent.indexOf("Android") > -1){
							window.location.href = "market://details?id=com.enuri.android&referrer=utm_source%3Denuri%26utm_medium%3DTop_banner%26utm_campaign%3Ddowloadbanner_201504";
					}
				}else{
					window.location.href = 'close://';
				}
			}); 
		}else{ 
			location.href="/m/index.jsp";
		}
		
		/*
		if(vApp == "Y")			$("h1").hide();

		$(document).ready(function() {
			//location.reload(true);
			$("#btn_agree").click(function(){
				if($(".btn_agree").hasClass("on")){
					$('input:checkbox[name="in_chk"]').each(function(){
						this.checked = false;
					});
					clickAgree("");
					clickJoin("");
				}else{
					$('input:checkbox[name="in_chk"]').each(function(){
						this.checked = true;
					});
					clickAgree("on");
					clickJoin("on");
				}
			});

			$("#btn_join").click(function(){
				//console.log('btn_join click');
				if($("#btn_join").hasClass("btn_join")){

					var chk3 = $('input:checkbox[name="in_chk"]')[2].checked ? "Y" : "N";
					var chk4 = $('input:checkbox[name="in_chk"]')[3].checked ? "Y" : "N";

					$('#agree_chk1').val("Y");
					$('#agree_chk2').val("Y");
					$('#agree_chk3').val(chk3);
					$('#agree_chk4').val(chk4);
					if($('input:checkbox[name="in_chk"]')[0].checked && $('input:checkbox[name="in_chk"]')[1].checked
							&& $('input:checkbox[name="in_chk"]')[2].checked && $('input:checkbox[name="in_chk"]')[3].checked && $('input:checkbox[name="in_chk"]')[4].checked ){
						$('#agree_all').val("Y");
					}
 					$('input:checkbox[name="in_chk"]').each(function(){
						this.checked = false;
					});
 					clickAgree("");
 					clickJoin("");
					document.agreeForm.submit();
					//location.href = "join.jsp";
				}else{
					alert("이용약관과 개인정보 수집 및 이용안내,\n만 14세 이상 이용에 모두 동의해주세요.");
				}
			});

			$('input:checkbox[name="in_chk"]').click(function(){
				var chkAgreeBtn = false;
				var chkJoinBtn = false;

				$('input:checkbox[name="in_chk"]').each(function(){
					/*if(this.checked && !chkAgreeBtn){
						chkAgreeBtn = true;
					}else{
						chkAgreeBtn = false;
					}
					*/
					/*if($('input:checkbox[name="in_chk"]')[0].checked && $('input:checkbox[name="in_chk"]')[1].checked
							&& $('input:checkbox[name="in_chk"]')[4].checked ){
						chkJoinBtn = true;
						if($('input:checkbox[name="in_chk"]')[2].checked && $('input:checkbox[name="in_chk"]')[3].checked  ){
							chkAgreeBtn = true;
						}
					}else{
						chkJoinBtn = false;
						chkAgreeBtn = false;
					}
				});

				if(chkAgreeBtn){
					clickAgree("on");
				}else{
					clickAgree("");
				}

				if(chkJoinBtn){
					clickJoin("on");
				}else{
					clickJoin("");
				}

			});

		});

		function clickAgree(param){
			if(param == "on"){
				$(".btn_agree").addClass("on");
				$(".btn_agree .next").hide();
			}else{
				$(".btn_agree").removeClass("on");
			}
		}

		function clickJoin(param){
			if(param == "on"){
				$("#btn_join").removeClass("btn_agree");
				$("#btn_join").removeClass("on");
				$("#btn_join").addClass("btn_join");
			}else{
				$(".btn_agree").removeClass("on");
				$("#btn_join").addClass("btn_agree");
				$("#btn_join").removeClass("btn_join");
			}
		}

		function showTerms(){
			if(vApp == "Y"){
				location.href = "http://m.enuri.com/mobilefirst/login/termsWrap.jsp?cssType=agreeWrap&freetoken=login_sub";
			}else{
				window.open("http://m.enuri.com/mobilefirst/login/termsWrap.jsp?freetoken=event");
			}
		}

		function showPrivacy(){
			if(vApp == "Y"){
				location.href = "http://m.enuri.com/mobilefirst/login/privacyWrap.jsp?cssType=agreeWrap&freetoken=login_sub";
			}else{
				window.open("http://m.enuri.com/mobilefirst/login/privacyWrap.jsp?freetoken=event");
			}
		}

		//title생성
		var vTitle = "회원가입";

		try{
			window.android.getTitle(vTitle);
		}catch(e){}

		// 애드브릭스 적용: 회원가입_시도 _ 타이머 추가
		setTimeout(function(){
			if(vApp == "Y")	{
				var strEvent = "member_agree";
				try{
				    if(window.android){            // 안드로이드
				        //window.android.igaworksEventForApp(strEvent);
				        window.android.airbridgeEventForApp("member_agree","member","","");
				    }else{                                                        // 아이폰에서 호출
				    	//window.location.href = "enuriappcall://igaworksEventForApp?strEvent="+ strEvent +"";
				    	window.location.href = "enuriappcall://airbridgeEventForApp?p1=member_agree&p2=member&p3=&p4=";
				    }  
				}catch(e){}
			}
		}, 2000);
		*/
</script>
</html>