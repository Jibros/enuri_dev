<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/include/Base_Inc_New_2010.jsp"%>
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
	String intTbWidth = "0";
	// 여행 페이지 확인 여부
	String isTour = "Y";
	if (request.getServletPath().trim().indexOf("Listbody.jsp") >= 0 || request.getServletPath().trim().indexOf("Listbody_Mp3.jsp") >= 0  ||
		request.getServletPath().trim().indexOf("Listbody_Handphone.jsp") >= 0 || request.getServletPath().trim().indexOf("Listbody_Printer.jsp") >= 0
		|| request.getServletPath().trim().indexOf("/sdul/") >= 0 || request.getServletPath().trim().indexOf("/reuse/") >= 0 || request.getServletPath().trim().indexOf("Listguide.jsp") >= 0
		|| request.getServletPath().trim().indexOf("Luxuryheader.jsp") >= 0 || request.getServletPath().trim().indexOf("Brandlistheader.jsp") >= 0 || request.getServletPath().trim().indexOf("Brandlistheader_Simple.jsp") >= 0
		|| request.getServletPath().trim().indexOf("Mallregister.jsp") >= 0 || request.getServletPath().trim().indexOf("Mallregisterinfo.jsp") >= 0
		|| request.getServletPath().trim().indexOf("Myfavoriteselectlist.jsp") >= 0 || request.getServletPath().trim().indexOf("Mytodayviewselectlist.jsp") >= 0
	){
		intTbWidth = "850";
	}else if (request.getServletPath().trim().indexOf("Fusion") >= 0 ){
		intTbWidth = "850";
	}else if (request.getServletPath().trim().indexOf("/knowbox/") >= 0 || request.getServletPath().trim().indexOf("Listpopulargoods_New.jsp") >= 0
		|| request.getServletPath().trim().indexOf("Listfungoods_New.jsp") >= 0 || request.getServletPath().trim().indexOf("Listnewgoods_New.jsp") >= 0
	){
		intTbWidth = "100%";
	}else if (request.getServletPath().trim().indexOf("/auto_2008/") >= 0 ){
		intTbWidth = "850";
	}else if (request.getServletPath().trim().indexOf("/fashion/") >= 0 ){
		intTbWidth = "850";
	//이벤트 관련 width 넓힘(미반영) 09.08.12
	}else if (request.getServletPath().trim().indexOf("/mallregister/new/") >= 0 || (request.getServletPath().trim().indexOf("/event/") >= 0 && request.getServletPath().trim().indexOf("/event/Resell") < 0)){
		intTbWidth = "860";
	}else if (request.getServletPath().trim().indexOf("/etc/enuri_intro/") >= 0){
		intTbWidth = "1000";
	}else if (request.getServletPath().trim().indexOf("Tourjockey") >= 0 ){
		isTour = "N";
		intTbWidth = "850";
	}else if (request.getServletPath().trim().indexOf("Insurance_Insvalley.jsp") >= 0 ){
		intTbWidth = "985";
	}else if (request.getServletPath().trim().indexOf("Site_map.jsp") >=0 ){
		intTbWidth = "978";
	}else if (request.getServletPath().trim().indexOf("move_mall.jsp") >= 0 ){
		intTbWidth = "985";
	}else{
		intTbWidth = "850";
	}

	String strUserId = cb.GetCookie("MEM_INFO","USER_ID");
//	판매자 정보 가져 오기
	boolean bSdulMember = false;
	boolean bSduMember = false;

	Sdul_Member_Data ndata = null;
	Members_Data mdata = null;

	if (strUserId.trim().length() > 0){
		ndata = Sdul_Member_Proc.getSdulmember(strUserId);
		if(ndata!=null){
			bSdulMember = true;
		}
		mdata = Members_Proc.Login_Check_Free(strUserId);
		if(mdata!=null){
			if(mdata.getM_group().equals("3")){
				bSduMember = true;
			}
		}
	}

	String mainWidth = "808";
	if(request.getServletPath().trim().indexOf("/tour/") >= 0){
		mainWidth = "765";
	}
%>

<script LANGUAGE="JavaScript">
<!--
var libType = function(){
    var rtn = "";
    if (typeof(Prototype) != "undefined" ){
        rtn = "PR";
    }else if(typeof(jQuery) != "undefined"){
        rtn = "JQ";
    }
    return rtn;
}

function GotoSDUL_Login(p){
	var url = "/include/ajax/AjaxSduLoginCheck.jsp";
	var param = "";

	if (typeof(Prototype) != "undefined" ){
        var getInstProd = new Ajax.Request(
            url,
            {
                method:'post',parameters:param,onComplete:checkSdulLogin
            }
        );
    }else if(typeof(jQuery) != "undefined"){
        $.ajax({
            type: "POST",
            url: url,
            data: param,
            success: function(result){
            	checkSdulLogin(result);
            }
        });
    }

	function checkSdulLogin(originalRequest){
		var varReturn = (libType() == "PR" ? originalRequest.responseText : originalRequest).trim();
		if(varReturn=="1"){
			top.Cmd_Login('sdu');
		}else{
			if(varReturn=="2"){
				top.location.href = '/sdul/mallregister/SellerMain.jsp?sm=1';
			}else{
				if(varReturn=="24"){ //sdu, sdul 중복 회원
					top.location.href = '/sdul/mallregister/SellerMain.jsp?sm=1&lg=1';
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
}
-->
</script>
<style type="text/css">
<!--
.main_bottom td a:hover { font-family: "돋움", "돋움체"; font-size: 9pt; font-style: normal; color:FFFFFF; font-weight: normal; font-variant: normal; text-decoration: underline}
.main_bottom td a { font-family: "돋움", "돋움체"; font-size: 9pt; font-style: normal; color:FFFFFF; font-weight: normal; font-variant: normal;text-decoration: none}
.main_bottom td a:visited { font-family: "돋움", "돋움체"; font-size: 9pt; font-style: normal; color:FFFFFF; font-weight: normal; font-variant: normal; }
.main_bottom td a:active { font-family: "돋움", "돋움체"; font-size: 9pt; font-style: normal; color:FFFFFF; font-weight: normal; font-variant: normal; text-decoration: underline}
.main_bottom td { font-family: "돋움", "돋움체"; font-size: 9pt; font-style: normal; color:FFFFFF; font-weight: normal; font-variant: normal; text-decoration: none}
 -->
#tblFooter { width:883px;height:28px;background-color:#f3f3f3; }
#tblFooter .linkItem { float:left;margin:8px 0px 0px 24px;height:18px; }
#tblFooter .linkItem span { float:left;font-family:'돋움';font-size:11px;color:#757575;line-height:16px;text-decoration:none;cursor:pointer; }
#tblFooter .linkItem a { font-family:'돋움';font-size:11px;color:#757575;line-height:16px;text-decoration:none;cursor:pointer; }
#tblFooter .linkItem a:hover { font-family:'돋움';font-size:11px;color:#757575;line-height:16px;text-decoration:none;cursor:pointer; }

#m_footer {width:1000px;height:108px;margin-right:136px;}
.main #m_footer {width:883px;margin:0 auto;}
#m_footer .m_footInner {position:relative;padding:17px 0 0 146px;font:11px/1.6 '돋움', Dotum;letter-spacing:-1px;}
#m_footer .m_footInner .m_footLogo {position:absolute;top:20px;left:24px;}
#m_footer .m_footInner .m_enuriDec {font-size:12px;color:#4984b5;}
#m_footer .m_footInner address {float:left;margin:0 4px 0 0;color:#888;}
#m_footer .m_footInner .m_enuriInfo {color:#888;}
#m_footer .m_footInner .m_enuriInfo span {color:#888;margin:0 0 0 3px;padding:0 0 0 7px;background:url(http://imgenuri.enuri.gscdn.com/2014/layout/bg_foot_bar.gif) no-repeat 0 1px;}
#m_footer .m_footInner .m_enuriInfo img {vertical-align:middle;}
#m_footer .m_footInner .m_copyright {margin:8px 0 0;color:#686868;}
</style>
 <div id="tblFooter">
    <div class="linkItem"><span onclick="insertLog(4550);"><a href="/" target="_top"><%= COMMON_CONST.CORP_HOME %></a></span></div>
    <div class="linkItem"><span onclick="insertLog(1059);"><a href='/etc/enuri_intro/Enuriintro.jsp' target="_top"><%= COMMON_CONST.CORP_INTRODUCTION %></a></span></div>
    <div class="linkItem"><span onclick="insertLog(1060);"><a href='/sdul/mallregister/SellerMain.jsp?sm=4&amp;guide=3' target="_top"><%= COMMON_CONST.CORP_ADVERTISEMENT_INFORMATION %></a></span></div>
    <div class="linkItem"><span onclick="insertLog(1061);"><a href='/sdul/mallregister/SellerMain.jsp?sm=1&amp;lg=1' target="_top"><%= COMMON_CONST.CORP_SELLER_GUIDE %></a></span></div>
    <div class="linkItem"><span onclick="insertLog(1062);GotoSDUL_Login();"><a href="#" onclick="this.blur();return false;" ><%= COMMON_CONST.CORP_SELLER_SDU %>&nbsp;</a></span></div>
    <div class="linkItem"><span onclick="insertLog(1063);"><a href="/etc/Secure.jsp" target="_top"><b><%= COMMON_CONST.CORP_PERSONAL_INFORMATION %></b></a></span></div>
    <div class="linkItem"><span onclick="insertLog(1064);"><a href="/etc/Duty.jsp" target="_top"><%= COMMON_CONST.CORP_LEGAL_NOTICE %></a></span></div>
    <div class="linkItem"><span onclick="insertLog(1065);"><a href="/view/mallsearch/Listmall.jsp" target="_top"><%= COMMON_CONST.CORP_SHOPPINGMALL_SEARCH %></a></span></div>
    <div class="linkItem"><span><a href="/faq/Faq_List.jsp" target="_top"><%= COMMON_CONST.CORP_CUSTOMER_CENTER %></a></span></div>
    <div class="linkItem"><span onclick="insertLog(1067);Cmd_Sitemap_All_Bottom();"><a href="#" onclick="this.blur();return false;" ><%= COMMON_CONST.CORP_WHOLE_MENU %></a></span></div>
    <div class="linkItem"><span onclick="insertLog(1068);"><a href="/etc/Site_map.jsp" target="_top"><%= COMMON_CONST.CORP_SITEMAP %></a></span></div>
</div>
<!-- 에누리 Footer -->
<%
	String strPageuri = request.getRequestURI();
%>
<div id="m_footer">
    <div class="m_footInner">
    	<p class="m_footLogo"><a href="/Index.jsp?fromLogo=Y" target="_top"><img src="<%=ConfigManager.IMG_ENURI_COM %>/2014/logo/bg_foot_logo.gif" alt="에누리 가격비교" /></a></p>
        <p class="m_enuriDec"><b><%= COMMON_CONST.CORP_INFORMATION %></b></p>
        <address><%= COMMON_CONST.CORP_ADDRESS %></address><p class="m_enuriInfo"><span><%= COMMON_CONST.CORP_CEO %></span> <span><%= COMMON_CONST.CORP_REGISTRATION_NUMBER %></span> <span><%= COMMON_CONST.CORP_REGIST_NUMBER %></span><br />
        <%= COMMON_CONST.CORP_TELEPHONE %> <span><%= COMMON_CONST.CORP_FAX %></span> <span><%= COMMON_CONST.CORP_INQUIRE_MAIL %></span> <a href="#"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/layout/btn_faq.gif" alt="문의전클릭" style="cursor:pointer" <% if(strPageuri.indexOf("Detailmulti.jsp")>-1){%> onClick="logInsert(634);window.open('/faq/Faq_List.jsp')"><% }else if(strPageuri.indexOf("Resell")>-1){%>onClick="window.open('/faq/Faq_List.jsp')"><%}else{%>onClick="insertLog(634);top.location.href='/faq/Faq_List.jsp'"><%}%></a> <a href="JavaScript:;" onClick="window.open('<%=ConfigManager.IMG_ENURI_COM%>/html/etc/Noemail_popup.htm','noEmail','width=379,height=245,left=300,top=300');"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/layout/btn_no_email.gif" alt="" /></a></p>
        <p class="m_copyright"><%= COMMON_CONST.CORP_COPYRIGHT %></p>
    </div>
</div>
<!-- //footer -->
<form name="fmBtmLog2" 	style="margin:0px;">
	<input type="hidden" name="swidth" value="">
	<input type="hidden" name="sheight" value="">
</form>
<iframe name="ifrmBTMHidden1" id="ifrmBTMHidden1" style="display:none" width="0" height="0" border="0"></iframe>
<script language=javascript>
<!--
if (top.document.getElementById("gnbMenu")){
	document.getElementById("tblFooter").style.width = top.document.getElementById("gnbMenu").offsetWidth+"px";
}

function cmdShowFooterSellerMenuLayer(){
	top.location.href="/mallregister/new/SellerGuide2.jsp";
}

function cmdHideFooterSellerMenuLayer(){
	if ($("divFooterSellerMenuLayer")){
		$("divFooterSellerMenuLayer").style.display = "none";
	}
}

function CmdScreenLog(){
	try{
		var obj2 = document.fmBtmLog2;
		obj2.swidth.value = window.screen.width;
		obj2.sheight.value = window.screen.height;
		obj2.target="ifrmBTMHidden1";
		obj2.action="/include/Screenlog.jsp";
		obj2.submit();
	}catch(e){
		//alert(e);
		window.status="";
	}
}

function Cmd_Sitemap_All_Bottom(){
	if (top.document.body.scrollTop){
		top.document.body.scrollTop = "0px";
	}else{
		top.document.documentElement.scrollTop = "0px";
	}
	$("#gnb > ul > .allMenuBtn > a").trigger("click");
}

function cmdMoveSeller(url){
	top.location.href=url;
}
<%
	if(DateUtil.getDaysDiff(DateStr.nowStr("yyyy-MM-dd"),"2009-05-23") < 0){
%>
CmdScreenLog();
<%
	}
%>
//-->
</script>
<!-- sdul 신규 레이어 시작 -->
<div id="sdulLoginAfterDiv" style="display:none;position:absolute;">
<%if(bSdulMember && bSduMember) {%>
<img src="<%=ConfigManager.IMG_ENURI_COM %>/images/main/layer_01.gif" usemap="#sdulMap1">
<map name="sdulMap1" id="sdulMap1">
<area shape="rect" coords="6,4,135,23" href="JavaScript:document.location.href='/sdu/Index.jsp'"/>
<area shape="rect" coords="6,27,158,47" href="JavaScript:document.location.href='/sdul/list/sdul_list.jsp'" />
<area shape="rect" coords="149,3,157,13" href="JavaScript:sdulLoginAfterDivClose();" />
</map>
<%}%>
<%if(!bSdulMember && bSduMember) {%>
<img src="<%=ConfigManager.IMG_ENURI_COM %>/images/main/layer_02.gif" usemap="#sdulMap2">
<map name="sdulMap2" id="sdulMap2">
<area shape="rect" coords="7,5,135,23" href="JavaScript:document.location.href='/sdu/Index.jsp'" />
<area shape="rect" coords="7,30,102,45" href="JavaScript:document.location.href='/mallregister/new/SellerGuide1.jsp'" />
<area shape="rect" coords="136,4,145,14" href="JavaScript:sdulLoginAfterDivClose();" />
</map>
<%}%>
</div>
<SCRIPT language="JavaScript">
<!--
function sdulLoginAfterDivShow() {

	if(document.getElementById("sdulLoginAfterDiv").style.display=="none") {
		document.getElementById("sdulLoginAfterDiv").style.display = "";
		document.getElementById("sdulLoginAfterDiv").style.top = ($("#tblFooter").position().top - $("#sdulLoginAfterDiv").height()) + "px";
		document.getElementById("sdulLoginAfterDiv").style.left = ($("#tblFooter").position().left+ 300) + "px";

	} else {
		sdulLoginAfterDivClose();
	}
}

function sdulLoginAfterDivClose() {
	document.getElementById("sdulLoginAfterDiv").style.display = "none";
}
-->
</SCRIPT>
<!-- sdul 신규 레이어 끝 -->
<!-- sso 세션관리 스크립트 2016-12-22 -->
<%@ include file="/login/wrapSsoJs.jsp"%>