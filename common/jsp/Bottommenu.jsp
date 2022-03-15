<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/include/Base_Inc_New.jsp"%>
<%@ page import="com.enuri.bean.main.Sdul_Member_Data"%>
<%@ page import="com.enuri.bean.main.Sdul_Member_Proc"%>
<jsp:useBean id="Sdul_Member_Data" class="com.enuri.bean.main.Sdul_Member_Data" scope="page" />
<jsp:useBean id="Sdul_Member_Proc" class="com.enuri.bean.main.Sdul_Member_Proc" scope="page" />
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<jsp:useBean id="Members_Data" class="com.enuri.bean.knowbox.Members_Data" scope="page" />
<jsp:useBean id="Members_Proc" class="com.enuri.bean.knowbox.Members_Proc" scope="page" />
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
        rtn = "PR"
    }else if(typeof(jQuery) != "undefined"){
        rtn = "JQ"
    }
    return rtn;
}

function GotoSDUL_Login(p){
	var url = "/include/ajax/AjaxSduLoginCheck.jsp";
	var param = "";

/* 	var getRec = new Ajax.Request(
		url,
		{
			method:'get',parameters:param,onComplete:checkSdulLogin
		}
	); */
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
					//top.Cmd_Login('choicesdu');
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
<!-- //footer -->
<jsp:include page="/include/IncListFooter_2010.jsp" flush="true"></jsp:include>
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
}else if(top.location.href.indexOf("/view/detail.jsp")>=0){
	document.getElementById("tblFooter").style.width = "1000px";
}

function cmdShowFooterSellerMenuLayer(){
	top.location.href="/mallregister/new/SellerGuide2.jsp";
	/*레이어 안보이게 처리
	if ($("divFooterSellerMenuLayer")){
		$("divFooterSellerMenuLayer").style.left = Position.cumulativeOffset($("tdaSeller"))[0] - 10;
		$("divFooterSellerMenuLayer").style.top = Position.cumulativeOffset($("tdaSeller"))[1] - 67;
		$("divFooterSellerMenuLayer").style.display = "inline";
	}
	*/
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
    $("body").scrollTop();

	loadGnbAllMenu(1);
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
