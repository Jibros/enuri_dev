<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<META NAME="description" CONTENT="최저가 에누리 - 가격비교 사이트 에누리닷컴입니다.">
<META NAME="keyword" CONTENT="휴대폰, 사무, 생활가전, 용품, 영상음향, 컴퓨터, 자동차, 명품, 잡화, 스포츠, 유아, 완구, 가구, 화장품, 식품, 가격비교, 쇼핑몰, 최저가">
<meta name="format-detection" content="telephone=no">
<link rel="shortcut icon" href="http://imgenuri.enuri.gscdn.com/2014/layout/favicon_enuri.ico">
<title>에누리(가격비교) eNuri.com</title>
<script type="text/javascript" src="http://www.enuri.com/common/js/lib/jquery-1.9.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="http://imgenuri.enuri.gscdn.com/common/css/eb/default_main.css">
<link rel="stylesheet" type="text/css" href="http://imgenuri.enuri.gscdn.com/common/css/eb/common_main.css">


</head>
<body>
<div id="main_body">
    <!-- 탑메뉴-->
    



<div id="nonbanking_site1" style="font-size:8pt;width:131px; height:211px; position:absolute;  top:45px; z-index:10001; display:none; overflow:hide; " onMouseOver="showNonbanking_site();"  onmouseout="hideNonbanking_site();"></div>
<div id="wrap">

<!-- 로그인레이어 -->
<div id="divLoginLayer" style="display:none;position:absolute;z-index:99997;"></div>
<!-- 자동로그인 경고레이어 -->
<div id="divLoginAutoAlert" style="display:none;position:absolute;width:306px;height:155px;overflow:hidden;z-index:99998;">
    <img src="http://imgenuri.enuri.gscdn.com/images/topmenu/login_info.png" id="divLoginAutoAlertImg" width="306" height="155" border="0" usemap="#divLoginAutoAlert" />
    <map name="divLoginAutoAlert" id="divLoginAutoAlert"><area shape="rect" coords="289,18,301,31" onclick="hideLoginAutoAlert()" onmouseover="document.getElementById('divLoginAutoAlertImg').style.cursor='pointer'" onmouseout="document.getElementById('divLoginAutoAlertImg').style.cursor='default'" /></map>
</div>
<div id="divEventAddr" style="display:none;position:absolute;z-index:99997;"><img id="imgEventAddr" border="0"></div>
<map name="MapEventAddr1" id="MapEventAddr1">
	<area shape="rect" coords="92,192,163,205" href="/event/EventMain.jsp" target="_new" />
	<area shape="rect" coords="215,190,289,207" href="JavaScript:top.CmdJoin(3);" />
	<area shape="rect" coords="169,247,224,269" href="JavaScript:closeEventAddr();" />
</map>
<map name="MapEventAddr2" id="MapEventAddr2">
	<area shape="rect" coords="93,192,161,205" href="/event/EventMain.jsp" target="_new" />
	<area shape="rect" coords="214,190,290,206" href="JavaScript:top.CmdJoin(3);" />
	<area shape="rect" coords="168,247,225,268" href="JavaScript:closeEventAddr();" />
</map>
<map name="MapEventAddr3" id="MapEventAddr3">
	<area shape="rect" coords="91,190,161,205" href="/event/EventMain.jsp" target="_new" />
	<area shape="rect" coords="215,191,290,206" href="JavaScript:top.CmdJoin(3);" />
	<area shape="rect" coords="169,248,224,268" href="JavaScript:closeEventAddr();" />
</map>
<div id="Bid_Event" style="display:none;position:absolute;z-index:80;top:140px;left:70px;;">
    <img src="http://imgenuri.enuri.gscdn.com/images/main/top_login_layer_130146(1).png" onclick="z_change()" usemap="#Bid_Map">
	<map name="Bid_Map" id="Bid_Map">
		<area shape="rect" coords="568,-2,594,24" href="JavaScript:Bid_EventClose();"/>
		<area shape="rect" coords="413,601,523,638" href="JavaScript:Top_View_Pop();" />
	</map>
</div>
<div id="bid_layer" style="display:none;position:absolute;top:79px;left:10px;z-index:50;">
	<img src="http://imgenuri.enuri.gscdn.com/images/main/top_login_layer_130401.png" onclick="z_change1()" usemap="#sdulMap2" border=0>
	<map name="sdulMap2" id="sdulMap2">
		<area shape="rect" coords="567,0,594,25" href="JavaScript:bid_layerClose();"/>
		<area shape="rect" coords="393,691,566,741" href="JavaScript:document.location.href='/sdul/mallregister/SellerMain.jsp?sm=2'" />
	</map>
</div>
<script language="JavaScript">
    function viewLoginAutoAlert(){
        var byLeft     = document.getElementById("frmLoginLayer").contentWindow.getPositionLeftAutoAlert();
        var byTop      = document.getElementById("frmLoginLayer").contentWindow.getPositionTopAutoAlert();
        var varLeft    = getCumulativeOffset(document.getElementById("frmLoginLayer"))[0];
        var varTop     = getCumulativeOffset(document.getElementById("frmLoginLayer"))[1];
        var obj        = document.getElementById("divLoginAutoAlert");
        
        if(obj.style.display!="none"){
            hideLoginAutoAlert();
        }else{
            
            obj.style.left = (byLeft+varLeft+86) + "px";
            
            obj.style.top = (byTop+varTop) + 10 + "px";
            obj.style.display = "";
        }
    }
</script>
<script src="/login/Inc_LoginTop_2015.js"></script><!-- 로그인레이어 -->
    <iframe name="ifrmMainSearch" id="ifrmMainSearch" frameborder="0" style="position:absolute;height:0;width:0;z-index:0;"></iframe><!-- 구글 레이어 -->

    <div id="header">
            
            <div class="skipMenu">
                <a href="#">상단 메뉴 바로가기</a>
                <a href="#">본문 바로가기</a>
            </div>
            <div class="utilMenu" id="utilMenu">
                <div class="headerArea"><!-- div 추가_simple hearder -->
                    <ul class="sp_header">
                        <li><a href="/deal/main.deal"           target="_blank" onclick="insertLog(12160);">소셜비교</a></li>
                        <li><a href="/department/index.jsp"     target="_blank" onclick="insertLog(12160);">백화점비교</a></li>
                        <li><a href="javascript://" class="enuriApp" onclick="onoff('simpleHeader')">에누리 앱 다운로드</a></li>
						<li><a class="benefit" href="/eventPlanZone/jsp/shoppingBenefit.jsp" onclick="insertLog(13426);"><img alt="[쇼핑 혜택존] 만원만 사도 5만원으로 돌려받는!" src="http://imgenuri.enuri.gscdn.com/images/main/ico_shop_benefit.gif"></a></li>
                    </ul>
                    <!-- 심플헤더 -->
                    <link rel="stylesheet" href="http://dev.enuri.com/common/css/simple_header.css" type="text/css">
<script type="text/javascript">
	/*레이어 열고닫고*/
	function onoff(id) {
	 	var mid=document.getElementById(id);
		if(mid.style.display=='') {
			insertLog(11716);
			mid.style.display='none';
		}else{
	 		mid.style.display='';
		}
	}

	/*tab*/
	function clickEvent(nIdx){
		clearPhonenum();
		if ( nIdx == 1 ){
			$(".sp_enuri").show(); $(".sp_car").hide(); $(".sp_hotdeal").hide(); $(".sp_depart").hide();}
		if ( nIdx == 2 ){
			$(".sp_car").show(); $(".sp_enuri").hide(); $(".sp_hotdeal").hide(); $(".sp_depart").hide();}
		if ( nIdx == 3 ){
			$(".sp_hotdeal").show(); $(".sp_enuri").hide(); $(".sp_car").hide(); $(".sp_depart").hide();}
		if ( nIdx == 4 ){
			$(".sp_depart").show(); $(".sp_enuri").hide(); $(".sp_car").hide(); $(".sp_hotdeal").hide();}
	}
	
	function clearPhonenum(){
		$("#phonenum_enuri").val("");
		$("#phonenum_car").val("");
		$("#phonenum_hotdeal").val("");
	}
	
	function checkForNumber() {
	  var key = event.keyCode;
	  if(!(key==8||key==9||key==13||key==46||key==144||
	      (key>=48&&key<=57)||key==110||key==190)) {
	      alert("숫자만 입력해주세요.");
	      event.returnValue = false;
	  }
	}
	
	function clickSendSms(type){
		var myphone = $("#phonenum_"+type).val();
		var title = "";
		var rurl = "";
		if(type=="enuri"){
			title = "에누리가격비교";
			rurl = "http://goo.gl/O8CUnn";
		}else if(type=="car"){
			title = "신차비교";
			rurl = "http://goo.gl/muoqQ9";
		}else if(type=="hotdeal"){
			title = "스마트핫딜";
			rurl = "http://goo.gl/j62WKU";
		}else if(type=="depart"){
			title = "에누리가격비교";
			rurl = "http://goo.gl/O8CUnn";
		}
		if(myphone==""){
			alert("휴대폰 번호가 입력되지않았습니다.");
			return;
		}
		var rgEx = /(01[016789])(\d{4}|\d{3})\d{4}$/g;  
		var chkFlg = rgEx.test(myphone);   
		if(!chkFlg){
    		alert("잘못된 형식의 휴대폰 번호입니다.");
    		return; 
   		}
   		
   		//document.getElementById("ifSimpleheader").src = "/common/jsp/Ajax_Simpleheader_Sms_Proc.jsp?procType="+proctype+"&phoneno="+myphone;
   		document.getElementById("ifSimpleheader").src = "/common/jsp/Ajax_ListHeader_Sms_Proc.jsp?part="+type+"&rurl="+rurl+"&phoneno="+myphone+"&title="+encodeURIComponent(title);
   		clearPhonenum();
	}
</script>
<div class="simple_h">
	<!-- <a href="#n" class="enuriApp" onclick="onoff('simpleHeader')">에누리앱 설치</a>  -->
	<div class="spbox" id="simpleHeader" style="display: none;">
		<a href="#n" class="ly_close" onclick="onoff('simpleHeader')">close</a>
		<ul class="sp_tab">
			<li><a href="javascript:void(0);" onclick="javascript:clickEvent('1');">에누리 가격비교</a></li>
			<li><a href="javascript:void(0);" onclick="javascript:clickEvent('3');">소셜비교</a></li>
			<li><a href="javascript:void(0);" onclick="javascript:clickEvent('4');">백화점비교</a></li>
			<li><a href="javascript:void(0);" onclick="javascript:clickEvent('2');">신차비교</a></li>
		</ul>
		
		<!-- 에누리 -->
		<div class="sp_enuri">
			<h2>에누리 가격비교 </h2>
			<p>모바일로 더욱 특별해진 가격비교!</p>
			
			<dl>
				<dt>QR코드 스캔</dt>
				<dd>QR코드</dd>
				<dt>앱 다운로드</dt>
				<dd><a href="https://play.google.com/store/apps/details?id=com.enuri.android" class="goole" target="_new">구글 PLAY스토어</a></dd>
				<dd><a href="https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8" class="apple" target="_new">애플 스토어</a></dd>
				<dt>다운로드 SMS 보내기</dt>
				<dd>
					<fieldset>
						<legend>SMS보내기</legend>
						<input type="text" onfocus="this.className='focus'" title="휴대폰 번호 입력" class="mobile" name="phonenum_enuri" id="phonenum_enuri" onkeypress="checkForNumber();" style="ime-mode:disabled;"><button type="button" class="send" onclick="clickSendSms('enuri')"></button>
					</fieldset>
				</dd>
				<dd>앱 설치페이지 주소를 무료문자로 발송해 드립니다.</dd>
				<dd>입력하신 번호는 저장되지 않습니다.</dd>
			</dl>
		</div>
		
		<!-- 신차비교 -->
		<div class="sp_car" style="display:none">
			<h2>신차비교</h2>
			<p>신차정보부터 견적까지 모두 모바일로 즐기세!</p>
			<dl>
				<dt>QR코드 스캔</dt>
				<dd>QR코드</dd>
				<dt>앱 다운로드</dt>
				<dd><a href="https://play.google.com/store/apps/details?id=com.enuri_car.android" class="goole" target="_new">구글 PLAY스토어</a></dd>
				<dd><a href="https://itunes.apple.com/kr/app/enuli-sinchabigyo/id623149329?mt=8" class="apple" target="_new">애플 스토어</a></dd>
				<dt>다운로드 SMS 보내기</dt>
				<dd>
					<fieldset>
						<legend>SMS보내기</legend>
						<input type="text" onfocus="this.className='focus'" title="휴대폰 번호 입력" class="mobile" name="phonenum_car" id="phonenum_car" onkeypress="checkForNumber();" style="ime-mode:disabled;"><button type="button" class="send" onclick="clickSendSms('car')"></button>
					</fieldset>
				</dd>
				<dd>앱 설치페이지 주소를 무료문자로 발송해 드립니다.</dd>
				<dd>입력하신 번호는 저장되지 않습니다.</dd>
			</dl>
		</div>
		
		<!-- 스마트 핫딜 -->
		<div class="sp_hotdeal" style="display:none">
			<h2>스마트 핫딜</h2>
			<p>소셜커머스는 물론 오픈마켓, 종합몰의 핫딜 상품을 한곳에!</p>
			<dl>
				<dt>QR코드 스캔</dt>
				<dd>QR코드</dd>
				<dt>앱 다운로드</dt>
				<dd><a href="https://play.google.com/store/apps/details?id=com.enuri.deal" class="goole" target="_new">구글 PLAY스토어</a></dd>
				<dd><a href="https://itunes.apple.com/kr/app/seumateuhasdil-sosyeolkeomeoseu/id944887654?mt=8" class="apple" target="_new">애플 스토어</a></dd>
				<dt>다운로드 SMS 보내기</dt>
				<dd>
					<fieldset>
						<legend>SMS보내기</legend>
						<input type="text" onfocus="this.className='focus'" title="휴대폰 번호 입력" class="mobile" name="phonenum_hotdeal" id="phonenum_hotdeal" onkeypress="checkForNumber();" style="ime-mode:disabled;"><button type="button" class="send" onclick="clickSendSms('hotdeal')"></button>
					</fieldset>
				</dd>
				<dd>앱 설치페이지 주소를 무료문자로 발송해 드립니다.</dd>
				<dd>입력하신 번호는 저장되지 않습니다.</dd>
			</dl>
		</div>
		
		<!-- 백화점비교 -->
		<div class="sp_depart" style="display:none">
			<h2>백화점비교</h2>
			<p>백화점 상품도 최저가로, 프리미엄 가격비교도 에누리 모바일에서!</p>
			<a href="http://www.enuri.com/common/jsp/App_Landing.jsp" class="enuri_m" target="_new">에누리모바일</a>
			<dl>
				<dt>QR코드 스캔</dt>
				<dd>QR코드</dd>
				<dt>앱 다운로드</dt>
				<dd><a href="https://play.google.com/store/apps/details?id=com.enuri.android" class="goole" target="_new">구글 PLAY스토어</a></dd>
				<dd><a href="https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8" class="apple" target="_new">애플 스토어</a></dd>
				<dt>다운로드 SMS 보내기</dt>
				<dd>
					<fieldset>
						<legend>SMS보내기</legend>
						<input type="text" onfocus="this.className='focus'" title="휴대폰 번호 입력" class="mobile" name="phonenum_depart" id="phonenum_depart" onkeypress="checkForNumber();" style="ime-mode:disabled;"><button type="button" class="send" onclick="clickSendSms('depart')"></button>
					</fieldset>
				</dd>
				<dd>앱 설치페이지 주소를 무료문자로 발송해 드립니다.</dd>
				<dd>입력하신 번호는 저장되지 않습니다.</dd>
			</dl>
		</div>

	</div>
</div>
<iframe frameborder="0" src="" id="ifSimpleheader" style="width:0px;height:0px;display:none"></iframe>
                    <!-- 심플헤더 끝-->
                    <ul class="right_navi" id="right_navi">
                        <li id='utilMenuLogin'  style="display:none;"><a href="#" onclick="setLogintopMygoods(4);Cmd_Login('');document.getElementById('divLoginLayer').style.zIndex='99997';insertLog(4661);">로그인</a></li>
                        <li id="loginDiv2" style="/*background-color:#f3f4f5;*/height:28px;vertical-align:top;overflow:hidden;">
                            <iframe id="frmMainLogin" name="frmMainLogin" src="/login/Loginstatus_2010.jsp?logintop_menu=top" frameborder=0 style="/*background-color:#f3f4f5;*/width:100px;height:20px;overflow:hidden;margin-right:7px;margin-top:7px;display:none" scrolling="no" onload="this.style.display=''"></iframe>
                        </li>
                        <li id='utilMenuJoin'   style="display:none;"><a href="#" onclick="insertLog(10519);goJoin()">회원가입</a></li>
                        <li id='utilMenuLogout' style=""><a href="#" onclick="javascript:document.getElementById('frmMainLogin').contentWindow.logout();">로그아웃</a></li>
                        <li><a href="#" onclick="insertLog(12165);top.location.href='/knowbox/List.jsp?kbcate=kbALL&kbcode=kc9';return false;">쇼핑Q&amp;A</a></li>
                        <li><a href="#" class="more" onclick="insertLog(12182);More_layerShow();return false;" id='viewMore'>더보기</a></li>
                    </ul>
                </div><!-- div 추가_simple hearder 끝-->
            </div>
            <!-- 더보기 레이어 -->
            <div class="s_more" id="divViewMore" style="display:none;">
                <a href="#n" class="ly_close" onclick="onoff('divViewMore')">close</a>
                <h2>주요서비스</h2>
                <ul class="service_list first">
                     <li><a href="http://www.enuri.com/department/index.jsp" target="_new">백화점비교</a></li>
                     <li><a href="http://www.enuri.com/deal/main.deal" target="_new">소셜비교</a></li>
                     <li><a href="#" onclick="insertLog(1502);window.open('/car/Index.jsp?stp=4','','width=1005px, left=0,top=0,toolbar=no,directories=no,status=yes,scrollbars=no,resizable=yes,menubar=no');return false;" href="#">신차비교</a></li>
                </ul>
                <ul class="service_list">
                     <li><a href="http://soho.enuri.com/" target="_new">소호스타일</a></li>
                     <li><a href="http://mrkoon.enuri.com/" target="_new">해외직구</a></li>
                     <li><a href="http://itvstyle.enuri.com/" target="_new">TV속 상품</a></li>
                     <li><a href="http://enuri.com/view/move_mall.jsp">이사견적</a></li>
                     <li><a href="http://www.enuri.com/view/Flower365.jsp">꽃배달</a></li>
                     <li><a  href="http://www.enuri.com/view/Insurance_Insvalley.jsp?rtnurl=http://insvalley.enuri.com/join_site/layout/compare/compare_main.jsp?h_targetPage=/goods/gallerylist.jsp||market_cd=D04||market_point_cd=PLA_20100825004&ac=SNU_B_2010082500003">보험비교</a></li>
                     <li><a href="http://www.enuri.com/tour2012/Tour_Index.jsp">여행비교</a></li>
                </ul>
                <h2>커뮤니티</h2>
                <ul class="service_list">
                     <li><a href="http://www.enuri.com/knowbox/List.jsp">지식통</a></li>
                     <li><a href="http://www.enuri.com/knowbox/List.jsp?kbcate=kbALL&kbcode=kc9">쇼핑Q&A</a></li>
                     <li><a href="/eventPlanZone/jsp/shoppingBenefit.jsp?tab_ty=exhibition">쇼핑기획전</a></li>
                     <li><a href="http://www.enuri.com/knowbox/List.jsp?kbcate=&kbcode=kc8&kbsort=regdate&kbno=0&smart_tap_menu=1&modelno=0&kb_keyword=&page=0&menuno=&iskc9flag=false&iscar=&isGuide=false" >블로그</a></li>
                     <li><a href="http://www.enuri.com/event/EventReviewAll.jsp?status=">체험단</a></li>
                </ul>
                <p class="all_view"><a href="http://www.enuri.com/etc/Site_map.jsp">에누리 서비스 전체보기</a></p>
            </div>
            <!--// 더보기 레이어 -->
            <div id="enuriBi" class="enuriBi">
                <H1 class="logoArea"><A onclick="insertLog(10520);top.location.href='http://dev.enuri.com/Index.jsp?fromLogo=Y';return false" title="에누리 가격비교" href="#">에누리 가격비교</A></H1>
                <div class="search_new">
                    <span class="searchForm">
                        <form name="fmMainSearch"  method="get" onsubmit="return Cmd_formMainSearch();" style="margin:0px;padding:0px;">
                        <input type="hidden"    name="nosearchkeyword"  value="">
                        <input type="hidden"    name="issearchpage"     value=''>
                        <input type="hidden"    name="searchkind"       value="">
                        <input type="hidden"    name="es"               value="">
                        <input type="hidden"    name="c"                value="">
                        <input type="hidden"    name="ismodelno"        value="">
                        <input type="hidden"    name="hyphen_2"         value="" id="hyphen_2" >
                        <input type="hidden"    name="from"             value="" id="from" >
                        <input type="hidden"    name="owd"              value="" id="owd" >
                        <input name="keyword"  id="keyword" type="text" autocomplete="off" tabIndex="1" class="txt">
                        <a href="#" class="keywordDel">최저가검색</a>
                        <a href="#" class="toggleAuto" style="margin-left:-20px" ><img id="imgToggleAutoMake" src="http://imgenuri.enuri.gscdn.com/images/home/ico_arrow_down.gif"  /></a>
                        
                        </form>
                    </span>
                    <a class="searchbtn" href="#" onclick="insertLog(10780);insertLog(10521);Cmd_MainSearchSubmit();return false;"></a>
                    <div id="ac_layer_main" name="ac_layer_main" border="0" style="position:absolute;top:44px;left:0;width:454px;background:#fff;border:1px solid #0081e6;display:none">
                        <iframe id="ifr_ac_main" name="ifr_ac_main" src="http://dev.enuri.com/search/Autocom_MainSearch_2010.jsp" frameborder="0" marginwidth="0" marginheight="0" topmargin="0" scrolling="no" style="width:100%;height:100%"></iframe>
                    </div>
                    <iframe name="ifrmMainSearch" id="ifrmMainSearch" frameborder="0" style="height:0;width:0;z-index:0;"></iframe>
                </div>
                
				<div class="headBanner">
                        <!-- 배너 영역 -->
                    <div id="adbox">
                        <div class="nowrap" id="bannerList" style="height: 75px; overflow: hidden;"><div style="display: none;">	<a href="javascript:goBannerLink('1', 'http://ad.enuri.com/click/PC_Enuri_Site/GNB_Enuri/GNB@GNB_Upper_right?ads_id=159&amp;creative_id=275&amp;click_id=274&amp;event=');">		<img src=" http://ad.enuri.com/NetInsight/image/PC_Enuri_Site/GNB_Enuri/GNB@GNB_Upper_right?ads_id=159&amp;creative_id=275">	</a></div><div>	<a href="javascript:goBannerLink('3', 'http://ad.enuri.com/click/PC_Enuri_Site/GNB_Enuri/GNB@GNB_Upper_right?ads_id=160&amp;creative_id=276&amp;click_id=275&amp;event=');">		<img src=" http://ad.enuri.com/NetInsight/image/PC_Enuri_Site/GNB_Enuri/GNB@GNB_Upper_right?ads_id=160&amp;creative_id=276">	</a></div><div style="display: none;">	<a href="javascript:goBannerLink('1', 'http://ad.enuri.com/click/PC_Enuri_Site/GNB_Enuri/GNB@GNB_Upper_right?ads_id=161&amp;creative_id=320&amp;click_id=319&amp;event=');">		<img src=" http://ad.enuri.com/NetInsight/image/PC_Enuri_Site/GNB_Enuri/GNB@GNB_Upper_right?ads_id=161&amp;creative_id=320">	</a></div><div style="display: none;">	<a href="javascript:goBannerLink('1', 'http://ad.enuri.com/click/PC_Enuri_Site/GNB_Enuri/GNB@GNB_Upper_right?ads_id=162&amp;creative_id=278&amp;click_id=277&amp;event=');">		<img src=" http://ad.enuri.com/NetInsight/image/PC_Enuri_Site/GNB_Enuri/GNB@GNB_Upper_right?ads_id=162&amp;creative_id=278">	</a></div></div>
                        <div class="bnr_bullet"><span id="move_banner_left">이전</span><span id="move_banner_right">다음</span> </div>
                    </div>
                </div>

            </div>


<link rel="stylesheet" type="text/css" href="http://dev.enuri.com/css/gnb.css" >
<script>jQuery.getScript("http://dev.enuri.com/common/js/eb/gnb.js");</script>
<div class="gnbgroup" id="gnb">
    <div class="gnbarea "><!-- 중앙정렬<div class=\"gnbarea\"> 좌측정렬<div class=\"gnbarea Left\"> 프로모션<div class=\"gnbarea w_bg\"> -->
        <ul id="gnbMenu" class="menuList">
			<li>
			    <a href="javascript:///"><em>디지털/가전</em></a>
			    <div class="back_img">
			        <div class="snblist">
                        <ul class="first_depth" id="first_depth0"></ul>
			            <div class="ad_area">
			                <div class="adarea_h">
			                    <ul></ul>
			                </div>
			                <div class="bnr_dot"></div>
			            </div>
			            <a href="javascript:///" class="btn_close">창닫기</a>
			        </div>
			    </div>
			</li>
			<li>
			    <a href="javascript:///"><em>컴퓨터</em></a>
			    <div class="back_img">
			        <div class="snblist">
                        <ul class="first_depth" id="first_depth1"></ul>
			            <div class="ad_area">
			                <div class="adarea_h">
			                    <ul></ul>
			                </div>
			                <div class="bnr_dot"></div>
			            </div>
			            <a href="javascript:///" class="btn_close">창닫기</a>
			        </div>
			    </div>
			</li>
			<li>
			    <a href="javascript:///"><em>스포츠/레저/자동차</em></a>
			    <div class="back_img">
			        <div class="snblist">
                        <ul class="first_depth" id="first_depth2"></ul>			        
			            <div class="ad_area">
			                <div class="adarea_h">
			                    <ul></ul>
			                </div>
			                <div class="bnr_dot"></div>
			            </div>
			            <a href="javascript:///" class="btn_close">창닫기</a>
			        </div>
			    </div>
			</li>
			<li>
			    <a href="javascript:///"><em>유아/식품</em></a>
			    <div class="back_img">
			        <div class="snblist">
                        <ul class="first_depth" id="first_depth3"></ul>   			        
			            <div class="ad_area">
			                <div class="adarea_h">
			                    <ul></ul>
			                </div>
			                <div class="bnr_dot"></div>
			            </div>
			            <a href="javascript:///" class="btn_close">창닫기</a>
			        </div>
			    </div>
			</li>
			<li>
			    <a href="javascript:///"><em>가구/생활/건강</em></a>
			    <div class="back_img">
			        <div class="snblist">
                        <ul class="first_depth" id="first_depth4"></ul>   			        
			            <div class="ad_area">
			                <div class="adarea_h">
			                    <ul></ul>
			                </div>
			                <div class="bnr_dot"></div>
			            </div>
			            <a href="javascript:///" class="btn_close">창닫기</a>
			        </div>
			    </div>
			</li>
			<li>
			    <a href="javascript:///"><em>패션/화장품</em></a>
			    <div class="back_img">
			        <div class="snblist">
                        <ul class="first_depth" id="first_depth5"></ul>			        
			            <div class="ad_area">
			                <div class="adarea_h">
			                    <ul></ul>
			                </div>
			                <div class="bnr_dot"></div>
			            </div>
			            <a href="javascript:///" class="btn_close">창닫기</a>
			        </div>
			    </div>
			</li>
			<li>
			    <a href="javascript:///"><em>도서/여행/취미</em></a>
			    <div class="back_img">
			        <div class="snblist">
                        <ul class="first_depth" id="first_depth6"></ul>			        
			            <div class="ad_area">
			                <div class="adarea_h">
			                    <ul></ul>
			                </div>
			                <div class="bnr_dot"></div>
			            </div>
			            <a href="javascript:///" class="btn_close">창닫기</a>
			        </div>
			    </div>
			</li>
			<li class="all"><a href="javascript:///">전체보기</a></li>
       </ul>
	   <div class="other_menu">
			<a href="/knowbox/List.jsp" target="_new" onclick="insertLog(14205);">쇼핑지식</a>
	   </div>
    </div>
    <div class="gnbarea allview_gnb " style="display:none;">
        <ul id="gnbAllMenu" class="menuList">          
        </ul>
    </div>
</div>
    </div>
    <div id="bodyFactoryTab"    style="display:none;"></div>
    <div id="bodyPriceTab"      style="display:none;"></div>
    <div id="div_inconv"        style="display:none;"></div>
    <!--더보기2-->
    <!-- 더보기 레이어 -->
    <div class="s_more" id="More_layer_2" style="position:absolute;display:none;z-index:10000;">
        <a href="#n" class="ly_close" onclick="More_layerClose();return false;">close</a>
        <h2>주요서비스</h2>
        <ul class="service_list first">
             <li><a href="http://dev .enuri.com/department/index.jsp" target="_new" onclick="insertLog(12166);">백화점비교</a></li>
             <li><a href="http://dev.enuri.com/deal/main.deal" target="_new" onclick="insertLog(12167);">소셜비교</a></li>
             <li><a href="#" onclick="insertLog(12168);window.open('/car/Index.jsp?stp=4','','width=1005px, left=0,top=0,toolbar=no,directories=no,status=yes,scrollbars=no,resizable=yes,menubar=no');return false;" href="#">신차비교</a></li>
        </ul>

        <ul class="service_list">
             <li><a href="http://enuri.xgolf.com" target="_new" onclick="insertLog(12170);">골프장 부킹</a></li>
             <li><a href="http://soho.enuri.com/" target="_new" onclick="insertLog(12169);">소호스타일</a></li>
             <li><a href="http://itvstyle.enuri.com/" target="_new" onclick="insertLog(12171);">TV속 상품</a></li>
             <li><a href="/view/move_mall.jsp" onclick="insertLog(12172);">이사견적</a></li>
             <li><a href="/view/Flower365.jsp" onclick="insertLog(12173);">꽃배달</a></li>
             <li><a  href="/view/Insurance_Insvalley.jsp?rtnurl=http://insvalley.enuri.com/join_site/layout/compare/compare_main.jsp?h_targetPage=/goods/gallerylist.jsp||market_cd=D04||market_point_cd=PLA_20100825004&ac=SNU_B_2010082500003" onclick="insertLog(12174);">보험비교</a></li>
             <li><a href="/tour2012/Tour_Index.jsp" onclick="insertLog(12175);">여행비교</a></li>
        </ul>

        <h2>커뮤니티</h2>
        <ul class="service_list">
             <li><a href="/knowbox/List.jsp" onclick="insertLog(12176);">지식통</a></li>
             <li><a href="/knowbox/List.jsp?kbcate=kbALL&kbcode=kc9" onclick="insertLog(12177);">쇼핑Q&A</a></li>
             <li><a href="/eventPlanZone/jsp/shoppingBenefit.jsp?tab_ty=exhibition" onclick="insertLog(12178);">쇼핑기획전</a></li>
             <li><a href="/knowbox/List.jsp?kbcate=&kbcode=kc8&kbsort=regdate&kbno=0&smart_tap_menu=1&modelno=0&kb_keyword=&page=0&menuno=&iskc9flag=false&iscar=&isGuide=false" onclick="insertLog(12179);">블로그</a></li>
             <li><a href="/event/EventReviewAll.jsp?status=" onclick="insertLog(10339);">체험단</a></li>
             <li><a href="/infoad_event/eventMain.jsp" onclick="">이벤트</a></li>
        </ul>

        <p class="all_view"><a href="http://www.enuri.com/etc/Site_map.jsp" onclick="insertLog(12181);">에누리 서비스 전체보기</a></p>
    </div>
    <!--// 더보기 레이어 -->
    <!--더보기2끝-->
    <!--더보기3-->
    <!-- 더보기 레이어 -->
    <div class="s_more" id="More_layer_3" style="position:absolute;display:none;z-index:10000;">
        <a href="#n" class="ly_close" onclick="More_layerClose();return false;">close</a>
        <h2>주요서비스</h2>
        <ul class="service_list first">
             <li><a href="/department/index.jsp" target="_new" onclick="insertLog(12166);">백화점비교</a></li>
             <li><a href="/deal/main.deal" target="_new" onclick="insertLog(12167);">소셜비교</a></li>
             <li><a href="#" onclick="insertLog(12168);window.open('/car/Index.jsp?stp=4','','width=1005px, left=0,top=0,toolbar=no,directories=no,status=yes,scrollbars=no,resizable=yes,menubar=no');return false;" href="#">신차비교</a></li>
        </ul>

        <ul class="service_list">
             <li><a href="http://enuri.xgolf.com" target="_new" onclick="insertLog(12170);">골프장 부킹</a></li>
             <li><a href="http://soho.enuri.com/" target="_new" onclick="insertLog(12169);">소호스타일</a></li>
             <li><a href="http://itvstyle.enuri.com/" target="_new" onclick="insertLog(12171);">TV속 상품</a></li>
             <li><a href="/view/move_mall.jsp" onclick="insertLog(12172);">이사견적</a></li>
             <li><a href="/view/Flower365.jsp" onclick="insertLog(12173);">꽃배달</a></li>
             <li><a  href="/view/Insurance_Insvalley.jsp?rtnurl=http://insvalley.enuri.com/join_site/layout/compare/compare_main.jsp?h_targetPage=/goods/gallerylist.jsp||market_cd=D04||market_point_cd=PLA_20100825004&ac=SNU_B_2010082500003" onclick="insertLog(12174);">보험비교</a></li>
             <li><a href="/tour2012/Tour_Index.jsp" onclick="insertLog(12175);">여행비교</a></li>
        </ul>

        <h2>커뮤니티</h2>
        <ul class="service_list">
             <li><a href="/knowbox/List.jsp" onclick="insertLog(12176);">지식통</a></li>
             <li><a href="/knowbox/List.jsp?kbcate=kbALL&kbcode=kc9" onclick="insertLog(12177);">쇼핑Q&A</a></li>
             <li><a href="/eventPlanZone/jsp/shoppingBenefit.jsp?tab_ty=exhibition" onclick="insertLog(12178);">쇼핑기획전</a></li>
             <li><a href="/knowbox/List.jsp?kbcate=&kbcode=kc8&kbsort=regdate&kbno=0&smart_tap_menu=1&modelno=0&kb_keyword=&page=0&menuno=&iskc9flag=false&iscar=&isGuide=false" onclick="insertLog(12179);">블로그</a></li>
             <li><a href="/event/EventReviewAll.jsp?status=" onclick="insertLog(10339);">체험단</a></li>
        </ul>

        <p class="all_view"><a href="http://www.enuri.com/etc/Site_map.jsp" onclick="insertLog(12181);">에누리 서비스 전체보기</a></p>
    </div>
    <!--// 더보기 레이어 -->
    <!--더보기3끝-->
    <!--앱다운로드 가격비교-->
    <div id="app_dn_layer" style="display:none;position:absolute;z-index:1002;width:330px;top:235px;left:230px;">
        <table width="330" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td height="208" align="center" valign="bottom"><img src="http://imgenuri.enuri.gscdn.com/images/main/app_dn_layer.png" width="330" height="208" border="0" usemap="#app_dn_layer" /></td>
            </tr>
        </table>
        <map name="app_dn_layer" id="app_dn_layer">
        <area shape="rect" coords="22,42,99,62"     onfocus="this.blur();" href="JavaScript:app_dn_layerShow1205();" />
        <area shape="rect" coords="99,42,176,62"    onfocus="this.blur();" href="JavaScript:app_dn_layer_carShow();" />
        <area shape="rect" coords="300,17,312,30"   onfocus="this.blur();" href="JavaScript:app_dn_layerClose();" />
        </map>
    </div>
    <!--앱다운로드 가격비교끝-->
    <!--앱다운로드 신차-->
    <div id="app_dn_layer_car" style="display:none;position:absolute;z-index:1002;width:330px;top:235px;left:230px;">
        <table width="330" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td height="208" align="center" valign="bottom"><img src="http://imgenuri.enuri.gscdn.com/images/main/app_dn_layer_car.png" width="330" height="208" border="0" usemap="#app_dn_layer_car" /></td>
            </tr>
        </table>
        <map name="app_dn_layer_car" id="app_dn_layer_car">
        <area shape="rect" coords="22,42,99,62"     onfocus="this.blur();" href="JavaScript:app_dn_layerShow1205();" />
        <area shape="rect" coords="99,42,176,62"    onfocus="this.blur();" href="JavaScript:app_dn_layer_carShow('_car');" />
        <area shape="rect" coords="300,17,312,30"   onfocus="this.blur();" href="JavaScript:app_dn_layer_carClose();" />
        </map>
    </div>
    <!--앱다운로드 신차끝-->


<script type="text/javascript" src="http://dev.enuri.com/common/js/function.js"></script>
<script type="text/javascript" src="http://dev.enuri.com/common/js/autocom_search_2010.js"></script>
<script>
	jQuery.getScript("http://dev.enuri.com/common/js/exception_keyword.js");
	jQuery.getScript("http://dev.enuri.com/common/js/incfavoritelayer.js");
	jQuery.getScript("http://dev.enuri.com/common/js/incfavoritelayer_body.js");
	jQuery.getScript("http://dev.enuri.com/common/js/common_top_func.js");
	jQuery.getScript("http://dev.enuri.com/common/js/common_top_search.js");
	jQuery.getScript("http://dev.enuri.com/common/js/eb/gnbTopRightBanner.js");
</script>	




<script>
var expTopBanner = false;

jQuery(document).ready(function(){
    setTimeout("topBannerInit()",1000);
});


function fnInitExpTopBanner(){
    jQuery(".bnr_up.btclose").click(function(){
        jQuery(".downbnr").slideUp();
        insertLog(13676);
    });

    jQuery(".bnrtxt > a").click(function(){
        insertLog(13675);
    });
    
    var loc = location.href.toString().replace(/http:\/\/.*\/(.*)/,"$1");
    
    if(loc == "" || loc.indexOf("Index.jsp")==0){
        if(!eval(fnGetCookie2010("expTopBanner"))){
            expTopBanner = true;
            
            fnSetCookie2010("expTopBanner","true",3);
            jQuery(".downbnr").slideDown();
            insertLog(13674);
            setTimeout("jQuery('.downbnr').slideUp();",4000);
        }
    }
}

function topBannerInit(){
    var bannerList = new Array();
    var validList  = new Array();
    
    var rndValue  = 0;
    bannerList.push(['2016041800','2016051518','','/pic_upload/banner/160418104243_main.jpg','http://www.enuri.com/event2016/jsp/event_home_2016.jsp',0,50,60,'#c7e5b3','가정의달 프로모션']);
bannerList.push(['2016050200','2016060100','','/pic_upload/banner/160502132200_main.jpg','http://www.enuri.com/event/emoney/jsp/firstInstall_201604.jsp',0,50,64,'#f4a621','PC_신규_상단배너']);

    bannerList.push(['2016030200','2016123100','','/pic_upload/banner/home_top_s.gif','/eventPlanZone/jsp/shoppingBenefit.jsp',0,30,999,'#bfebf5','3월 VIP 구매 혜택 이벤트']);

    for(i=0;i<bannerList.length;i++)
        if(parseInt(fnGetDate2()) >= parseInt(bannerList[i][0]) && parseInt(fnGetDate2()) <= parseInt(bannerList[i][1]) && fnGetCookie2010("topbanner_"+bannerList[i][7])=="")
            validList.push(bannerList[i]);

    if(validList.length>0){
        if(validList.length>1){
            var accumulativeValue = 0;
            
            for(i=0;i<validList.length;i++){
                validList[i].push(accumulativeValue += validList[i][6]);
            }
            
            rndValue = Math.floor(Math.random()*accumulativeValue);
            
            var i = 0;
            
            while(rndValue > validList[i][10] && i < validList.length){
                i++;
            }
            
            rndValue = i;
            
            if(expTopBanner || fnGetDate()=="20160331")
                rndValue = (bannerList.length-1);
        }

        var exceptionPage = new Array();
        var isException;
        
        jQuery.ajax({
            url : "http://storage.enuri.gscdn.com/Web_Storage/pic_upload/main/json/bannerExceptList.json",
            dataType : "jsonp",
            jsonpCallback : "callback_banner",
            success : function(jsonObj){
                var data = jsonObj["bannerExceptList"];

                exceptionPage = data.split(",");
                
                isException = false;
                
                for(i=0;i<exceptionPage.length && !isException;i++)
                    if(top.location.href.indexOf(exceptionPage[i]) > 0)
                        isException = true;
                
                if(!isException){
                    if(validList[rndValue][2]==""){
                        jQuery("#topBannerNew").css("background-color", validList[rndValue][8] );
                    }else{
                        jQuery("#topBannerNew").css({"background-image":"url(http://storage.enuri.gscdn.com" + validList[rndValue][2] + ")","background-repeat":"repeat-x"});   
                    }

                    jQuery("#topBannerNew > .banner_inner")
                    .css("background-image","url(http://storage.enuri.gscdn.com" + validList[rndValue][3] + ")")
                    .click(function(e){
                        fnGoPage(validList[rndValue][4],validList[rndValue][5]);
                        fnInsertHitLog(validList[rndValue][7],4);
                        
                        setGEventLog('탑배너', validList[rndValue][9],'이동'); 
                        
                        e.stopPropagation();
                        e.preventDefault();
                    });

                    // 예외 탑배너 처리
                    if(validList[rndValue][7] == 999){
                        jQuery("#topBannerNew > a > button").after("<span class=\"bnr_up btn_benefit\">혜택보기</span>").parent("a").find("span").click(function(e){
                            insertLog(13678);
                            jQuery(".downbnr").slideDown();
                            insertLog(13674);
                            
                            e.stopPropagation();
                            e.preventDefault();                         
                        });
                        jQuery("#topBannerNew > a").css({"background-position":"-15px 0px"});
                        jQuery("#topBannerNew > .banner_inner").click(function(){
                            insertLog(13677);
                        });
                    }
                    
                    jQuery("#top_banner_closer").click(function(e){
                        var offsetHeight = 69;

                        jQuery("#topBannerNew").slideUp().queue(function(){
                            jQuery("#aside").css("top","-=" + offsetHeight );
                            
                            if(borwserName!="msie8")
                                jQuery("#bannerId56").css("top","-=" + offsetHeight);
                            
                            jQuery("#div_speed_reg").css("top","-=" + offsetHeight);

                            if($("#rightBanner > div").length > 1)
                                $("#rightBanner > div").eq(1).css("top","-=" + offsetHeight);
                        });

                        e.stopPropagation();
                        e.preventDefault();
                    });

                    jQuery("#cbNoMoreViewTopBanner").attr("seqno",validList[rndValue][7]).click(function(e){
                        jQuery("#top_banner_closer").trigger("click");
                        fnSetCookie2010("topbanner_"+validList[rndValue][7],"checked",1);
                    });
                    
                    fnOpenTopBanner();
                }
            }
        });
    }
}

function fnGoPage(url,log){
    window.open(url);

    if(log != null && log != undefined)
        insertLog(log);
}

function fnOpenTopBanner(){
    var offsetHeight = 69;

    jQuery("#topBannerNew").css({"height" : offsetHeight+"px","overflow":"hidden"}).slideDown();

    jQuery("#aside").css("top","+=" + offsetHeight);
    jQuery("#div_speed_reg").css("top","+=" + offsetHeight);
    jQuery("#bannerId56").css("top","+=" + offsetHeight);

    if($("#rightBanner > div").length > 1)
        $("#rightBanner > div").eq(1).css("top","+=" + offsetHeight);
    
    setTimeout("fnInitExpTopBanner()",1000);
}
</script>
<script language="JavaScript">
    var varRanSearch        = 1;
    var menuType            = "5";
    var IMG_ENURI_COM       = "http://imgenuri.enuri.gscdn.com";
    var strRanSearchImage   = "http://imgenuri.enuri.gscdn.com/images/event/banner/search_tx_20150605_4.gif";
    var thisimg             = 1;
    var intRanSearch2       = 4;
    var intRanSearch3       = 10;
    
    var arrExperience = new Array();

    arrExperience.push([13849,184]);
    arrExperience.push([13850,185]);
    arrExperience.push([13851,186]);
    arrExperience.push([13852,188]);
    arrExperience.push([13853,189]);
    arrExperience.push([13569,136]);
    arrExperience.push([13573,142]);
    arrExperience.push([13627,144]);
    arrExperience.push([13630,147]);
    arrExperience.push([13634,151]);
    arrExperience.push([13636,152]);
    arrExperience.push([13659,159]);
    arrExperience.push([13660,160]);
    arrExperience.push([13694,161]);
    arrExperience.push([13723,169]);
    arrExperience.push([13725,171]);
    arrExperience.push([13810,172]);
    arrExperience.push([13727,174]);
    arrExperience.push([13818,175]);
    arrExperience.push([13811,177]);
    arrExperience.push([13812,178]);
    arrExperience.push([13813,179]);
    arrExperience.push([13814,180]);
    arrExperience.push([13815,181]);
    arrExperience.push([13816,182]);
    arrExperience.push([13817,183]);
    
    jQuery(document).ready(function(){
        jQuery("#keyword").keydown(function(){
            changeStyleMainSearch(this,'on');
            oT_Main_search(event);
        }).keyup(function(){
            toggleRemoveKeywodBtn();
        }).mousedown(function(){
            changeStyleMainSearch(this,'on');
            oT_Main_search(event);
        }).blur(function(){
            changeStyleMainSearch(this,'off');
        }).focus(function(){
            cmdLoginLayerHide();
        }).val("")
        
        .css({"background-image":"url(" + IMG_ENURI_COM + "/images/etc/cmExhibition/txt_" + arrExperience[intRanSearch3-1][1] + ".gif)","background-repeat":"no-repeat","background-position":"10px 9px"});
        

        

        var enuribi = document.getElementById("enuriBi").offsetLeft;
        //심플헤더 가운데 정렬분기
        if(enuribi > 10){
            if(jQuery(".headerArea"))
                jQuery(".headerArea").css("margin","0 auto");
        }

        if(jQuery(".toggleAuto")){
            jQuery('.toggleAuto').click(function(){
                toggleAutoMake();
                return false;
            });
        }
    });

    function changeStyleMainSearch(obj,onoff){
        if (onoff =='off'){
            if (document.fmMainSearch.keyword.value.trim().length == 0 ){

                obj.style.backgroundImage = "url(" + IMG_ENURI_COM + "/images/etc/cmExhibition/txt_" + arrExperience[(intRanSearch3-1)][1] + ".gif)";
                obj.style.backgroundPosition = "10px 9px";
                obj.style.backgroundRepeat="no-repeat";

            }
        }else{
            obj.style.backgroundImage ='none';
        }
    }
</script>


<div id="divJoinLayer_film" style="z-index:99997;position:absolute;display:none;width:0%;height:0%;background-color:#000000;filter:Alpha(opacity=40);opacity:0.4;-moz-opacity:0.4;border:0px solid blue;"></div>
<div id="divJoinLayer_screen" style="z-index:99998;position:absolute;display:none;width:0%;height:0%;overflow:auto;border:0px solid red;">
    <table id="divJoinLayer" style="display: block; margin:70px auto 0; height: 470px;" width="630" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="15" class="bgJoinLayerBox1"><div style="width:20px;height:15px;overflow:hidden;"></div></td>
        </tr>
        <tr>
            <td width="630" id="bgJoinLayerBox2" class="bgJoinLayerBox2" align="center"></td>
        </tr>
        <tr>
            <td height="15" class="bgJoinLayerBox3"><div style="width:20px;height:15px;overflow:hidden;"></div></td>
        </tr>
    </table>
</div>
<div id="divSystemWarnning" style="display:none;position:absolute;width:459px;height:335px;z-index:99997;">
    <div class="service_layer1">
        <div class="inner">
            <h2>서비스 정기점검 안내</h2>
            <p>에누리 가격비교에서는 고객님께 더 나은 서비스 제공을 위해 정기점검을 실시하고 있습니다.
                서비스 이용에 일부 제한이 있을 수 있으니 많은 양해 부탁 드리며, 더 편리한 서비스로 찾아 뵙겠습니다.
            </p>
            <dl>
                <dt>점검 시간</dt><dd>05.23(토) 12:00 PM ~ 05.24(일) 02:00 AM</dd>
                <dt>서비스 제한</dt><dd>반회원 : 회원가입 및 로그인
                판매자 :  SDU(L) 및 상위입찰 서비스</dd>
            </dl>
        </div>
        <a href="#" onclick="document.getElementById('divSystemWarnning').style.display='none';return false;" class="btn_close">닫기</a>
    </div>
</div>
<script src="http://dev.enuri.com/join/join2009/IncJoin2015.js"></script>

    
    





<!-- 160503 LP개편 -->
<%@ include file="/pub_test/web/home/wing.html"%>
<%@ include file="/pub_test/web/home/lp.html"%>








<SCRIPT language="JavaScript">
<!--
function cumulativeOffset(element) {
    var valueT = 0, valueL = 0;

    do {
        valueT += element.offsetTop || 0;
        valueL += element.offsetLeft || 0;
        element = element.offsetParent;
    } while (element);

    return [valueL, valueT];
}

function sdulLoginAfterDivShow() {
	if(document.getElementById("sdulLoginAfterDiv").style.display=="none") {
		document.getElementById("sdulLoginAfterDiv").style.display = "";
		document.getElementById("sdulLoginAfterDiv").style.top = (cumulativeOffset(document.getElementById("sdulLoginAfterDiv"))[1] - 100) + "px";
		document.getElementById("sdulLoginAfterDiv").style.left = (cumulativeOffset(document.getElementById("sdulLoginAfterDiv"))[0]+ 100) + "px";
	} else {
		sdulLoginAfterDivClose();
	}
}

function sdulLoginAfterDivClose() {
	document.getElementById("sdulLoginAfterDiv").style.display = "none";
}
-->
</SCRIPT>
<div class="bnr_area">
     <ul>
         <li><a href="/event/stampEvent_ReviewPage.jsp" target="_new" onclick="insertLog(12158);">에누리 추가할인 평균 -8.3% 혜택</a></li>
         <li><a href="/common/jsp/App_Landing.jsp" target="_new" onclick="insertLog(12159);">에누리되는 가격비교 모바일 에누리</a></li>
     </ul>
</div>
<div class="footer" id="tblFooter">
		<ul class="footer_menu">
			<li><span onclick="insertLog(1059);"><a href='/etc/enuri_intro/Enuriintro.jsp' target="_top">회사소개</a></span></li>
			<li><span onclick="insertLog(1060);"><a href='/sdul/mallregister/SellerMain.jsp?sm=4&amp;guide=3' target="_top">광고안내</a></span></li>
			<li><span onclick="insertLog(1061);"><a href='/sdul/mallregister/SellerMain.jsp?sm=1&amp;lg=1' target="_top">판매자가이드</a></span></li>
			<li><span onclick="insertLog(1062);GotoSDUL_Login();"><a href="#" onclick="this.blur();return false;" >판매자SDU(L)&nbsp;</a></span></li>
			<!-- <li><span><a href='/etc/provision.jsp' target="_top">이용약관</a></span></li>  -->
			<li><span onclick="insertLog(4555);"><a href="/etc/Secure.jsp" target="_top"><strong>개인정보취급방침</strong></a></span></li>
			<li><span onclick="insertLog(1064);"><a href="/etc/Duty.jsp" target="_top">법적고지</a></span></li>
			<li><span onclick="insertLog(1065);"><a href="/view/mallsearch/Listmall.jsp" target="_top">쇼핑몰검색</a></span></li>
			<li><span><a href="/faq/Faq_List.jsp" target="_top">고객센터</a></span></li>
			<li><span onclick="insertLog(1067);Cmd_Sitemap_All_Bottom();"><a href="#" onclick="this.blur();return false;" >전체메뉴</a></span></li>
			<li><span onclick="insertLog(1068);"><a href="/etc/Site_map.jsp" target="_top">사이트맵</a></span></li>
		</ul>

		<div class="adr">
			<span>서울시 중구 퇴계로 18(남대문로5가) 9층, 에누리닷컴(주)</span>
			<span>대표이사 : 최문석</span>
			<span>사업자등록번호 : 206-81-18164</span>
			<span>통신판매신고 : 종로통신 제4406호</span><br>
			<span>전화 : 02-6354-3601</span>
			<span>팩스 : 02-6354-3600</span>
			문의 : master@enuri.com
			<a href="#"><img src="http://imgenuri.enuri.gscdn.com/images/layout/btn_faq.gif" alt="문의전클릭" style="cursor:pointer" onClick="insertLog(634);top.location.href='/faq/Faq_List.jsp'"></a> <a href="JavaScript:;" onClick="window.open('http://imgenuri.enuri.gscdn.com/html/etc/Noemail_popup.htm','noEmail','width=379,height=245,left=300,top=300')"><img src="http://imgenuri.enuri.gscdn.com/images/layout/btn_no_email.gif" alt="이메일주소 무단수집거부" /></a>
		</div>

		<ul class="award_list">
			<li>2015 소비자가 뽑은 가장 신뢰하는 브랜드 대상</li>
			<li>소비자가 뽑은 한국 소비자 만족지수 1위</li>
			<li>2014 공정거래 위원회 상품정보 일치율 1위</li>
			<li>2015, 2016 모바일어워드 코리아 가격비교서비스 2년연속 대상</li>
		</ul>

		<p class="copyright"><strong>에누리닷컴(주)는 통신판매 정보제공자이며, 상품의 주문/배송/환불에 대한 의무와 책임은 각 쇼핑몰에 있습니다.</strong>Copyright ⓒ eNuri.com Co., Ltd All rights reserved.</p><p>
     </p>
</div>

<div style="display:none;" id="ad_tpmn_footer_div_id"></div>
<script language="javaScript">
if (top.document.getElementById("gnbMenu")){
	document.getElementById("tblFooter").style.width = top.document.getElementById("gnbMenu").offsetWidth+"px";
}
var libType = function(){
    var rtn = "";
    if (typeof(Prototype) != "undefined" ){
        rtn = "PR"
    }else if(typeof(jQuery) != "undefined"){
        rtn = "JQ"
    }
    return rtn;
}

function commonAjaxRequest(url,param,callback){
    if (libType() == "PR"){
        var getInstProd = new Ajax.Request(
            url,
            {
                method:'post',parameters:param,onComplete:callback
            }
        );
    }else if(libType() == "JQ"){
        $.ajax({
            type: "POST",
            url: url,
            data: param,
            success: function(result){
                callback(result);
            }
        });
    }
}

function Cmd_Sitemap_All_Bottom(){
	top.CmdShowAllMenuHeader();
}
function GotoSDUL_Login(){
    function checkSdulLogin(originalRequest){
        var varReturn = (libType() == "PR" ? originalRequest.responseText : originalRequest).trim();
        if(varReturn=="1"){
            top.Cmd_Login('sdu');
        }else{
            if(varReturn=="2"){
                top.location.href = '/sdul/mallregister/SellerMain.jsp?sm=1';
            }else{
                if(varReturn=="24"){ //sdu, sdul 중복 회원
                    top.Cmd_Login('choicesdu');
                }else{
                    if(varReturn=="3") {
                        top.location.href = '/sdul/mallregister/SellerMain.jsp';
                    }else{
                        sdulLoginAfterDivShow();
                    }
                }
            }
        }
    }

	var url = "/include/ajax/AjaxSduLoginCheck.jsp";
	var param = "";

/* 	var getRec = new Ajax.Request(
		url,
		{
			method:'get',parameters:param,onComplete:checkSdulLogin
		}
	); */
	commonAjaxRequest(url,param,checkSdulLogin);
}
</script>





</body>
</html>
<script type="text/javascript">

  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-53076228-1', 'auto');
  ga('require', 'displayfeatures');
  ga('require', 'linkid', 'linkid.js');
  ga('send', 'pageview');
</script>
<script language=javascript src="http://imgenuri.enuri.gscdn.com/common/js/Log_Tail.js"></script>

<!-- 이하 GNB가 있는 페이지 전체에 삽입 -->
<!-- Google 리마케팅 태그 코드 -->
<!--------------------------------------------------
리마케팅 태그를 개인식별정보와 연결하거나 민감한 카테고리와 관련된 페이지에 추가해서는 안 됩니다. 리마케팅 태그를 설정하는 방법에 대해 자세히 알아보려면 다음 페이지를 참조하세요. http://google.com/ads/remarketingsetup
--------------------------------------------------->
<script type="text/javascript">
/* <![CDATA[ */
var google_conversion_id = 966646648;
var google_custom_params = window.google_tag_params;
var google_remarketing_only = true;
/* ]]> */
</script>
<script type="text/javascript" src="//www.googleadservices.com/pagead/conversion.js">
</script>
<noscript>
<div style="display:inline;">
<img height="1" width="1" style="border-style:none;" alt="" src="//googleads.g.doubleclick.net/pagead/viewthroughconversion/966646648/?value=0&amp;guid=ON&amp;script=0"/>
</div>
</noscript>
<!-- 다음 DDN -->
<script type="text/javascript">
    var roosevelt_params = {
        retargeting_id:'7Nkvme4SXizvSOykgyChpQ00',
        tag_label:'JZryQWV0TKCJsqPbMCgNyg'
    };
</script>
<script type="text/javascript" src="//adimg.daumcdn.net/rt/roosevelt.js"></script>


<noscript><img height="1" width="1" alt="" style="display:none" src="https://www.facebook.com/tr?id=1448547908729774&amp;ev=NoScript" /></noscript>



<script>w3IncludeHTML();</script>