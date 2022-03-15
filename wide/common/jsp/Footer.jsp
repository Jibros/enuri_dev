<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@ page import="com.enuri.bean.main.Sdul_Member_Data"%>
<%@ page import="com.enuri.bean.main.Sdul_Member_Proc"%>
<jsp:useBean id="Sdul_Member_Data" class="com.enuri.bean.main.Sdul_Member_Data" scope="page" />
<jsp:useBean id="Sdul_Member_Proc" class="com.enuri.bean.main.Sdul_Member_Proc" scope="page" />
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<jsp:useBean id="Members_Data" class="com.enuri.bean.knowbox.Members_Data" scope="page" />
<jsp:useBean id="Members_Proc" class="com.enuri.bean.knowbox.Members_Proc" scope="page" />
<%@ include file="/common/jsp/COMMON_CONST.jsp"%>

<%
	String strID = cb.GetCookie("MEM_INFO","USER_ID");
	String isMenuType = ChkNull.chkStr(request.getParameter("isHome"),"N");
	//판매자 정보 가져 오기
	boolean bSdulMember = false;
	boolean bSduMember = false;
	Sdul_Member_Data ndata = null;
	Members_Data mdata = null;

	if (strID.trim().length() > 0){
		ndata = Sdul_Member_Proc.getSdulmember(strID);
		if(ndata!=null){
			bSdulMember = true;
		}
		mdata = Members_Proc.Login_Check_Free(strID);
		if(mdata!=null){
			if(mdata.getM_group().equals("3")){
				bSduMember = true;
			}
		}
	}

	String strPageuri = request.getRequestURI();
%>
    <!-- <link rel="stylesheet" type="text/css" href="/css/rev/footer.css"/>  -->
    <div id="sdulLoginAfterDiv" style="display:none;position:absolute;">
        <%if(bSdulMember && bSduMember) {%>
        <img src="<%=ConfigManager.IMG_ENURI_COM %>/images/main/layer_01.gif" usemap="#sdulMap1">
        <map name="sdulMap1" id="sdulMap1">
            <area shape="rect" coords="6,4,135,23" href="JavaScript:document.location.href='/sdu/Index.jsp'"/>
            <area shape="rect" coords="6,27,158,47" href="JavaScript:document.location.href='https://seller.enuri.com'" />
            <area shape="rect" coords="149,3,157,13" href="JavaScript:sdulLoginAfterDivClose();" />
        </map>
        <%}%>
        <%if(!bSdulMember && bSduMember) {%>
        <img src="<%=ConfigManager.IMG_ENURI_COM %>/images/main/layer_02.gif" usemap="#sdulMap3">
        <map name="#sdulMap3" id="sdulMap3">
            <area shape="rect" coords="7,5,135,23" href="JavaScript:document.location.href='/sdu/Index.jsp'" />
            <area shape="rect" coords="7,30,102,45" href="JavaScript:document.location.href='https://seller.enuri.com/member/join/joinSDUL.jsp'" />
            <area shape="rect" coords="136,4,145,14" href="JavaScript:sdulLoginAfterDivClose();" />
        </map>
        <%}%>
    </div>
      <jsp:include page="/wide/include/IncAlarm.jsp" />
</div>
    <!-- // [HM] 메인 컨텐츠  -->

    <!-- [C] 푸터  -->
    <footer class="footer">
        <!-- 푸터 : 푸터 메뉴 -->
        <div class="footer-menu">
            <div class="footer__inner">
                <ul class="footer-menu__list">
                    <li class="footer-menu__item"><a href='/etc/enuri_intro/Enuriintro.jsp' target="_top" onclick="insertLog(24261);"><%= COMMON_CONST.CORP_INTRODUCTION %></a></li>
                    <li class="footer-menu__item"><a href='/ad' target="_new" onclick="insertLog(24262);"><%= COMMON_CONST.CORP_ADVERTISEMENT_INFORMATION %></a></li>
                    <li class="footer-menu__item"><a href="https://seller.enuri.com/sdul/Sdu_Guide.jsp" onclick="insertLog(24263);" target="_blank"><%=COMMON_CONST.CORP_LAUNCHING%></a></li>
                    <li class="footer-menu__item"><a href='https://seller.enuri.com' target="_blank" onclick="insertLog(24264);"><strong><%= COMMON_CONST.CORP_SELLER_GUIDE %></strong></a></li>
                    <li class="footer-menu__item"><a href="#" id="sdulogin" onclick="this.blur();insertLog(24265);GotoSDUL_Login();return false;">판매자SDU(L)</a></li>
                    <li class="footer-menu__item"><a href='/etc/provision.jsp' onclick="insertLog(24263);" target="_top">이용약관</a></li>
                    <li class="footer-menu__item"><a href="/etc/Secure.jsp" target="_top" onclick="insertLog(24267);"><strong><%= COMMON_CONST.CORP_PERSONAL_INFORMATION %></strong></a></li>
                    <li class="footer-menu__item"><a href="/etc/Duty.jsp" target="_top" onclick="insertLog(24268);"><%= COMMON_CONST.CORP_LEGAL_NOTICE %></a></li>
                    <li class="footer-menu__item"><a href="/view/mallsearch/Listmall.jsp" target="_top" onclick="insertLog(24269);"><%= COMMON_CONST.CORP_SHOPPINGMALL_SEARCH %></a></li>
                    <li class="footer-menu__item"><a href="/faq/Faq_List.jsp" target="_top" onclick="insertLog(24270);"><%= COMMON_CONST.CORP_CUSTOMER_CENTER %></a></li>
                    <li class="footer-menu__item"><a href="#" onclick="this.blur();insertLog(24271);allMenuLayer();return false;" ><%= COMMON_CONST.CORP_WHOLE_MENU %></a></li>
                    <li class="footer-menu__item"><a href="/etc/Site_map.jsp" target="_top" onclick="insertLog(24272);"><%= COMMON_CONST.CORP_SITEMAP %></a></li>
                </ul>
            </div>
        </div>
        <!-- // -->
        <!-- 푸터 : 앱 다운로드 -->
        <div class="footer-appdown">
            <ul class="footer-appdown__menu">
                <li class="footer-appdown__item">
                    <a href="#" class="appdown-item appdown-item--enuri" onclick="return false;">
                        <i class="ico-app-enuri comm__sprite"></i>
                        <span class="appdown-item__tit">에누리 가격비교</span>
                        앱 다운로드
                    </a>
                </li>
                <!-- <li class="footer-appdown__item">
                    <a href="#" class="appdown-item appdown-item--social" onclick="return false;">
                        <i class="ico-app-social comm__sprite"></i>
                        <span class="appdown-item__tit">소셜가격비교</span>
                        앱 다운로드
                    </a>
                </li> -->
            </ul>
            <!-- [레이어] 공통 > 푸터 > 앱다운로드 -->
            <!-- template.html 참고 -->
            <div class="footer__lay appdown__lay">
                <ul class="appdown__menu">
                    <!-- 앱다운로드 > 에누리 가격비교 -->
                    <li class="appdown__item appdown__item--enuri is--active">
                        <a class="appdown__item--tit" href="#" onclick="return false;">에누리 가격비교</a>
                        <div class="appdown__item--cont">
                            <div class="appdown__item--body">
                                <!-- 앱다운로드 : 앱설명 -->
                                <div class="appdown__info">
                                    <i class="ico-app-enuri--big comm__sprite"></i>
                                    <span class="appdown__info--tit">에누리 가격비교</span>
                                    <span class="appdown__info--desc">모바일로<br/>더욱 특별해진 가격비교!</span>
                                </div>
                                <!-- // -->
                                <!-- 앱다운로드 : QR코드 -->
                                <div class="appdown__qrcode qr-code--enuri"><!-- QRCODE --></div>
                                <!-- // -->
                            </div>
                            <div class="appdown__item--foot">
                                <!-- 앱다운로드 : 다운로드 링크 -->
                                <div class="appdown__link">
                                    <span class="appdown__link--tit">앱 다운로드</span>
                                    <a href="https://play.google.com/store/apps/details?id=com.enuri.android" onclick="insertLog(24274);" class="appdown__btn appdown__btn--google" target="_blank">
                                        <i class="ico-store-google comm__sprite"></i>구글 PLAY
                                    </a>
                                    <a href="https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8" onclick="insertLog(24275);" class="appdown__btn appdown__btn--apple" target="_blank">
                                        <i class="ico-store-apple comm__sprite"></i>애플 앱스토어
                                    </a>
                                </div>
                                <!-- // -->
                                <!-- 앱다운로드 : 링크보내기 -->
                                <div class="appdown__send-url">
                                    <span class="appdown__send-url--tit">다운로드 SMS 보내기</span>
                                    <div class="appdown__form">
                                        <fieldset>
                                            <legend>SMS보내기</legend>
                                            <input type="text" title="휴대폰 번호 입력" class="appdown__form--inp" name="phonenum_enuri" id="phonenum_enuri" onkeypress="checkForNumber();" style="ime-mode:disabled;">
                                            <button class="appdown__form--btn" onclick="clickSendSms('enuri');insertLog(24273);">전송</button>
                                        </fieldset>
                                    </div>
                                    <span class="appdown__send-url--tx">- 앱 설치 페이지 주소를 무료 문자로 발송해 드립니다.</span>
                                    <span class="appdown__send-url--tx">- 입력하신 번호는 저장되지 않습니다.</span>
                                </div>
                                <!-- // -->
                            </div>
                        </div>
                    </li>
                </ul>
            </div>
            <!-- // -->                
        </div>
        <!-- // -->
        <!-- 푸터 : 회사정보 -->
        <div class="footer-info footer__inner">                
            <div class="footer-info__com">
                <span class="footer-info__tx-tit">써머스플랫폼</span>
                <addr class="footer-info__tx-adder">서울시 금천구 가산디지털1로 186, 제이플라츠빌딩 13층</addr>
                <span class="footer-info__tx-owner"><b>대표이사 :</b> 김기범</span>
                <span class="footer-info__tx-num"><b>사업자등록번호 :</b> <span class="tx_num">206-81-18164</span></span>        
                <span class="footer-info__tx-num"><b>통신판매신고 :</b> <span class="tx_num">2020-서울금천-1949호</span></span><br/>
                <span class="footer-info__tx-tel"><b>대표전화 :</b> <span class="tx_num">02-6354-3601</span></span>
                <span class="footer-info__tx-fax"><b>팩스 :</b> <span class="tx_num">02-6354-3600</span></span>
                <span class="footer-info__tx-mail"><b>문의 :</b> <a href="mailto:master@enuri.com">master@enuri.com</a></span>
            </div>
            <span class="footer-info__tx-noti">㈜써머스플랫폼은 통신판매 정보제공자로서 통신판매의 거래당사자가 아니며, 상품의 주문/배송/환불에 대한 의무와 책임은 각 쇼핑몰(판매자)에게 있습니다.</span>
            <span class="footer-info__tx-copyright">Copyright ⓒ SummercePlatform Inc. All rights reserved.</span>
        </div>
        <!-- // -->

    </footer>
    <!-- // -->                 

</div>
<iframe frameborder="0" src="" id="ifSimpleheader" style="width:0px;height:0px;display:none"></iframe>
<jsp:include page="/join/join2009/IncJoin2015_rev.jsp" flush="true"></jsp:include>
<script>
$(function(){
    var $appDownItem = $(".footer-appdown__menu .footer-appdown__item");
    $appDownItem.on({
        'mouseenter' : function(){
            var _idx = $(this).index();
            $(".appdown__menu > li").eq(_idx).addClass("is--active").siblings().removeClass("is--active");
        }
    })
    
    // 탭 전환
    var $appItem = $(".appdown__item");
    $appItem.click(function(){
        $(this).addClass("is--active").siblings().removeClass("is--active");
    })
})
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
	}else if(type=="hotdeal"){
		title = "스마트핫딜";
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
		document.getElementById("ifSimpleheader").src = "/common/jsp/Ajax_ListHeader_Sms_Proc.jsp?part="+type+"&phoneno="+myphone+"&title="+encodeURIComponent(title);
		clearPhonenum();
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

function GotoSDUL_Login(){
    function checkSdulLogin(originalRequest){
        var varReturn = (libType() == "PR" ? originalRequest.responseText : originalRequest).trim();
        if(varReturn=="1"){ // sdu, 비회원도 여기로 들어옴
            Cmd_Login('sdu','',2);
        }else{
            if(varReturn=="2"){ // sdul
            	Cmd_Login('sdul','',2);
            }else{
                if(varReturn=="24"){ //sdu, sdul 중복 회원
                	Cmd_Login('choicesdu','',2);
                }else{
                    if(varReturn=="3") { // sdul,sdul 회원 X
                    	Cmd_Login('member');
                    }else{
                        sdulLoginAfterDivShow();
                    }
                }
            }
        }
    }

	var url = "/include/ajax/AjaxSduLoginCheck.jsp";
	var param = "";

	commonAjaxRequest(url,param,checkSdulLogin);
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

function sdulLoginAfterDivShow() {
	if(document.getElementById("sdulLoginAfterDiv").style.display=="none") {
		document.getElementById("sdulLoginAfterDiv").style.display = "";
		document.getElementById("sdulLoginAfterDiv").style.top = (cumulativeOffset(document.getElementById("sdulogin"))[1] - 265) + "px";
		document.getElementById("sdulLoginAfterDiv").style.left = (cumulativeOffset(document.getElementById("sdulogin"))[0] - 20) + "px";
	} else {
		sdulLoginAfterDivClose();
	}
}

function sdulLoginAfterDivClose() {
	document.getElementById("sdulLoginAfterDiv").style.display = "none";
}
</script>
<script type="text/javascript">
    (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
    (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
    m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
    })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

    ga('create', 'UA-53076228-1', 'auto');
    ga('require', 'displayfeatures');
    ga('require', 'linkid', 'linkid.js');
</script>

</body>
</html>