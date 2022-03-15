<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@ page import="com.enuri.include.RandomMain"%>
<%@ page import="com.enuri.bean.log.Log_main_Proc"%>
<%@ page import="com.enuri.bean.log.Log_main_Data"%>
<jsp:useBean id="RandomMain" class="com.enuri.include.RandomMain" scope="page" />
<%
	//request.setCharacterEncoding("ISO-8859-1");

	// 메뉴 타입 1:메인, 2:리스트, 3:패션, 4:자동차, 5:리스트 리뉴얼, 6:지식통 리뉴얼, 7: 여행, 8: 여행 개편,9: 외부 업체 플라워365
	// Common_Top_2010.jsp는 기본적으로 5번 리스트 리뉴얼을 사용함

	String userAgentStr = "";
	if (request.getHeader("User-Agent") != null){
		userAgentStr = request.getHeader("User-Agent");
	}
	String menuType = ConfigManager.RequestStr(request, "menuType", "5");
	String strPagenm = ConfigManager.RequestStr(request, "strPagenm", "");
	// 여행 페이지에서 LogoLayerImg 겹치는것을 방지하기위한 변수

	String strLogoLayerImg = ConfigManager.RequestStr(request, "strLogoLayerImg", "T");
	if(menuType.equals("6")) strPagenm = "knowbox";
	boolean IsLogin = false;
	if(cb.GetCookie("MEM_INFO","USER_ID").trim().length()> 0) IsLogin = true;
	 
	/*즐겨찾기 이벤트 및 바탕화면 바로가기 이벤트를 위한 세션 처리*/
	String strEventRefererCheck = ChkNull.chkStr(request.getHeader("REFERER"),"");
	//HttpSession Eventsession = request.getSession(true);
	/*
	if (!(strEventRefererCheck.indexOf("enuri.com") >= 0 || strEventRefererCheck.trim().length() == 0)){
		Eventsession.setAttribute("favorite_event","no");
	}
	if (ChkNull.chkStr((String)Eventsession.getAttribute("favorite_event"),"").trim().equals("no") && strEventRefererCheck.trim().length() == 0){
		Eventsession.removeAttribute("favorite_event");
	}
	
	String strEventBatang = ChkNull.chkStr(request.getParameter("event_chk"),"");
	if(strEventBatang.equals("icon") || ChkNull.chkStr((String)Eventsession.getAttribute("batang_event"),"").trim().equals("Y")){
		Eventsession.setAttribute("batang_event","Y");
	}else{
		Eventsession.removeAttribute("batang_event");
	}
	*/
	String strCate = ChkNull.chkStr(request.getParameter("cate"),"");
	boolean bMain = true;
	if (!request.getServletPath().trim().equals("/Index.jsp") && !request.getServletPath().trim().equals("/search/Searchlist.jsp") && !request.getServletPath().trim().equals("/search/WebSearchlist.jsp")){
		bMain = false;
	}	
	boolean bExLink = false;
	String strExLink = "";
	if (request.getRequestURI().indexOf("Smilecat.jsp") >= 0 || request.getRequestURI().indexOf("Paxinsu.jsp") >= 0 || request.getRequestURI().indexOf("Flower_Easyflower.jsp") >= 0){
		bExLink = true;
		strExLink = "?exlink=Y";
	}	
	int intRanSearch = RandomMain.getRandomValue(8)+1;
	String strRanSearchImage = "";
//	if (DateStr.getYMD(DateStr.nowStr(),"M").equals("09")){
//		intRanSearch = 0;
//	}
	if (intRanSearch == 0){
		strRanSearchImage = ConfigManager.IMG_ENURI_COM + "/2010/images/view/search_txt.gif";
	}else{
		strRanSearchImage = ConfigManager.IMG_ENURI_COM + "/images/event/banner/search_tx_"+intRanSearch+".gif";	
	}		
	String strShopFrom = ChkNull.chkStr(request.getParameter("_pfrom"),"");
	if (strShopFrom.trim().length() > 0){
		if (strShopFrom.equals("6351")){
			Log_main_Proc log_main_proc = new Log_main_Proc();
			Log_main_Data log_main_data = new Log_main_Data();
			log_main_data.setLm_kind(5382);
			log_main_data.setLm_userid("");
			log_main_data.setLm_userip(request.getRemoteAddr());
			log_main_data.setLm_category("");
			log_main_data.setLm_modelno(0);
			log_main_data.setLm_vcode(0);	
			log_main_proc.Log_main_Insert(log_main_data);
		}
	}
	String topWidth = "";
	if(menuType.equals("6")){
		topWidth = "width:990px;";
	}else if(menuType.equals("7")){
		topWidth = "width:788px;"; 
	}else if(menuType.equals("8")){
		topWidth = "width:850px;";
	}else if(menuType.equals("9")){
		topWidth = "width:975px;";
	}else{
		topWidth = "width:100%;";
	}
	boolean bTour = false;
	if (request.getServletPath().trim().indexOf("/tour/") >= 0 || request.getServletPath().trim().indexOf("/tour2012/") >= 0){
		bTour = true; 
	}
%>
<script language="javascript">
var varRanSearch = <%=intRanSearch%>;
</script>
<script type="text/javascript" src="<%=ConfigManager.ENURI_COMMON%>/common/js/autocom_search_2010.js"></script>
<script type="text/javascript" src="<%=ConfigManager.ENURI_COMMON%>/common/js/exception_keyword.js"></script>
<jsp:include page="/join/join2009/IncJoin2009_2010.jsp" flush="true">
<jsp:param name="pagenm" value="<%=strPagenm%>"/>
</jsp:include>
<jsp:include page="/include/Inc_Common_LayerControl_2010.jsp" flush="true"></jsp:include>
<%/*고정위치 레이어들*/%>
<iframe width="911" height="100%" border="0" src="" id="frmAllMenu" name="frmAllMenu" allowTransparency="true" style="display:none;position:absolute;left:8px;top:15px;z-index:365;"  frameborder="0"   onload="syncWHAllMenu()"></iframe>
<%/*저장상품 레이어*/%>
<iframe width="885" height="580" border="0" src="" id="frmSaveGoods" name="frmSaveGoods" allowTransparency="true"  style="display:none;position:absolute;left:15px;top:15px;z-index:365;" scrolling="no" frameborder="0"   onload="syncWHSaveGoods()"></iframe>
<div id="nonbanking_site1" style="font-size:8pt;width:131px; height:211px; position:absolute;  top:45px; z-index:103; display:none; overflow:hide; " onMouseOver="showNonbanking_site();"  onmouseout="hideNonbanking_site();"></div>
<div id="m_menu_div" onMouseOver="clearTimeout(TimeHandler);" onMouseOut="CmdMenuCheck();" align="center" style="border:1px solid #7E7E7E;padding:0 0 0 0;margin:0 0 0 0;position:absolute;display:none;z-index:200;background-color:#D6D6D6;"></div>
<div id="topmenucolorDiv" style="position:absolute;overflow:hidden;display:none;background-color:#D6D6D6;width:1px;height:1px;z-index:202;display:none;"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/blank.gif" height="1" width="1"></div>
<div id="c_menu_div" onMouseOver="clearTimeout(TimeHandler);" onMouseOut="CmdMenuCheck();" style="border:1px solid #8B9197;background-color:#FFFEE9;position:absolute;display:none;z-index:201;"></div>
<div id="menucolorDiv" style="position:absolute;display:none;background-color:#FFFEE9;width:1px;height:19px;z-index:202;display:none;"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/blank.gif" height="1" width="1"></div>
<div id="LayerM_KBMenu" style="position:absolute;z-index:203;width:110px;display:none;"></div>
<div id="LayerS_KBMenu" style="position:absolute;z-index:204;width:140px;display:none;"></div>
<div id="menucolorKBDiv1" style="position:absolute;background-color:#FFFFFF;display:none;z-index:206;height:1px;overflow:hidden;"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/blank.gif" height="1" width="1"></div>
<div id="menucolorKBDiv2" style="position:absolute;background-color:#FFFFFF;display:none;z-index:206;"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/blank.gif" height="1" width="1"></div>
<div id="menuFashionImg" style="position:absolute;z-index:206;display:none;"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/main_2008/topmenu/top_info.gif" onmouseover="clearTimeout(TimeHandler);mDivOver();$('m_menu_div').style.display='inline';" onMouseOut="CmdMenuCheck();" usemap="#Map_FashionImg"></div>
<map name="Map_FashionImg" id="Map_FashionImg"><area shape="rect" coords="0,0,144,35" href="#" onclick="insertLog(3745);location.href='/fashion/clothes/Clothes_Index.jsp'" /></map>
<!-- 
<fieldset id="FSETMAIN" name="FSETMAIN" style="padding-left:2; width:100%; height:100%;z-index:1; overflow:auto; background:#ffffff; border:1px ;BORDER-COLOR=#d4d4d4;display:block;" onScroll="mouseScroll=true;rePositionTodayFrameDiv()">
-->
<%/*기존 fieldset을 대신하는 감싸는 레이어 이 레어어 안에 있으면 스크롤안쪽에 있게된다.*/%>
<div id="wrap">
<div id="ac_layer" name="ac_layer" border=0 style='display:none;border:0;position:absolute;top:0;left:0;width:0;z-index:90;'>
<iframe id="ifr_ac" name="ifr_ac" src='/search/Autocom_MainSearch_2010.jsp'  frameborder=0 marginwidth=0 marginheight=0 topmargin=0 scrolling=no></iframe>
</div>
<%/*로그인레이어*/%>
<jsp:include page="/login/Inc_LoginTop_2010.jsp" flush="true"></jsp:include>
<div id="wndListDirectMenu"  style="width=0;height:0;overflow-x: hidden; overflow-y: auto;padding:0px;position:absolute;left:0px;top:0px;z-index:11"></div>
<%/*구글 레이어 */%>
<iframe width="670px" height="456px" border="0" src="" style="position:absolute;display:none;overflow:hidden;z-index:198" scrolling="no" id="frmGoogleSearch" name="frmGoogleSearch" frameborder="0" onload="syncWHGoogleSearch()"></iframe>
<iframe name="ifrmMainSearch" id="ifrmMainSearch" frameborder="0" style="position:absolute;height:0;width:0;z-index:0;"></iframe>
<%/*탑메뉴 들어갈자리*/%>
<table id="topMenuTable" border="0" cellspacing="0" cellpadding="0" style="position:relateive;<%=topWidth%>"><tr><td style="width:18px;height:64px;background-image:url(<%=ConfigManager.IMG_ENURI_COM%>/2010/images/view/top/top_sub01.gif);"></td><td>
<div id="LayerMenu" style="position:relateive;width:100%;height:64px;left:0px; top:0px; z-index:10;display:block;background-image:url(<%=ConfigManager.IMG_ENURI_COM%>/2010/images/view/top/top_sub_bg.gif)">
	<div id="layermenu_top" style="<%=(menuType.equals("6"))?"float:left;width:800px;overflow:hidden;":""%>">
		<div style="list-style:none;margin:0px;padding:0px;"> 
		<!-- 원래 로고이미지 경로 /2010/images/view/logo_sub.gif --> 
			<div style="display:inline;width:20%;height:33px;padding:0px 0px 0px 0px;margin:0px;float:left;" onclick="location.href='/Index.jsp?fromLogo=Y'"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/main_2008/topmenu/201101/logo_sub2.gif" width="162" height="33" usemap="#logo_sub2" style="margin:auto;display:block;cursor:pointer;" border="0" /><map name="logo_sub2" id="logo_sub2"><area shape="rect" coords="67,6,161,31" onmouseover="Cmd_Logo_Layer(1);" onmouseout="Cmd_Logo_Layer(2);"/></map></div>
			<div style="display:inline;float:left;width:<%=bTour ? "15%" :"18%"%>;"> 
				<div style="display:inline;float:right;margin-top:3px;margin-left:17px;padding-right:10px;"><span style="margin-left:2px;padding-right:2px;" id="topmenu_carlayer"  onclick="insertLog(1502);Cmd_AutoVisit();Cmd_Car_Layer(1);"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/main_2008/topmenu/top_car3.gif" style="cursor:pointer;"></span></div>
				<div style="display:inline;float:right;margin-top:3px;margin-left:20px;"><span onClick="OpenWindow_book('55','http://book.interpark.com/gate/ippgw.jsp?biz_cd=P13392&url=http://book.interpark.com/bookPark/html/book.html','sc.prdNo');insertLog(434);" style="letter-spacing:-1;cursor:pointer;"><img src="<%=ConfigManager.IMG_ENURI_COM %>/images/main_2008/topmenu/top_book.gif" style="cursor:pointer;margin:0px 0px 0px 0px;" border="0"></span></div>
<% 
	if (!bTour){
%>
				<div style="display:inline;float:right;margin-top:3px;margin-left:14px;"><span onClick="insertLog(710);location.href='/tour2012/Tour_Index.jsp';" style="cursor:pointer;"><img src="<%=ConfigManager.IMG_ENURI_COM %>/images/main_2008/topmenu/top_trv.gif" style="cursor:pointer;margin:0px 0px 0px 0px;" border="0"></span></div>
<%
	}
%>
			</div>
<%
	if (!request.getServletPath().trim().equals("/search/Searchlist.jsp") && !request.getServletPath().trim().equals("/search/WebSearchlist.jsp") 
		&& !request.getServletPath().trim().equals("/fashion/Fashion_Searchlist.jsp")){
%>
			<div style="display:inline;width:286px;;padding:0px;margin:0px;float:left;">
				<form name="fmMainSearch"  method="get" OnSubmit="return Cmd_MainSearch1();" style="margin:0px">
				<input type="hidden" name="issearchpage" value=''>
				<input type="hidden" name="searchkind" value="">
				<input type="hidden" name="es" value="">
			   	<input type=hidden name="c" value="">
			   	<input type=hidden name="ismodelno" value="">
			   	<input type="hidden" id="hyphen_2" name="hyphen_2" value="">						
<%
		if(bExLink){
%>
				<input type=hidden name="exlink" value="Y">
<%
		}
%>
				<table border="0" cellspacing="0" cellpadding="0" align="right"><tr><td>
				<!-- 
				<div style="width:296px;height:32px;">
					<div id="div_search_01" style="display:inline;padding:0px;margin:0px;float:left;width:25px;height:32px;background-image:url(<%=ConfigManager.IMG_ENURI_COM%>/2010/images/search/l1.gif);"></div>
					<div id="div_search_02" style="display:inline;padding:0px;margin:0px;float:left;width:195px;background-image:url(<%=ConfigManager.IMG_ENURI_COM%>/2010/images/search/bg2.gif);height:32px;"><input name="keyword" id="keyword" type="text" autocomplete="off" value="<%=request.getParameter("skeyword") == null ? "" : ChkNull.chkStr(request.getParameter("skeyword")) %>" 
							onkeydown="changeStyle(this,'on');oT_search(event);"
							onmousedown = "changeStyle(this,'on');oT_search(event);"	
							onBlur="changeStyle(this,'off');" 
							onFocus="changeStyle(this,'on');" 
							style="margin-top:9px;_margin-top:8px;padding-top:2px;width:175px;height:14px;border:0px;font-family:돋움;font-size:9pt;color:#FF0000;outline:none;<%=request.getParameter("skeyword") == null ? "background-image:url("+strRanSearchImage+");background-repeat: no-repeat;" : "" %>">
					</div>		
					<div style="display:inline;cursor:pointer;float:left;width:17px;height:32px;background-image:url(<%=ConfigManager.IMG_ENURI_COM%>/2012/search/main_sc1.gif);" id="img_close_auto" onclick="img_close_autoAction();" ></div>
					<div style="display:inline;cursor:pointer;padding:0px;margin:0px;float:left;width:34px;height:32px;background-image:url(<%=ConfigManager.IMG_ENURI_COM%>/2010/images/search/bg1.gif);" Onclick="Cmd_MainSearchSubmit();" id="btn_search_main" ><img src="<%=ConfigManager.IMG_ENURI_COM%>/2010/images/search/btn1.gif" border="0" style="margin-top:6px;margin-top:7px\0/;"></div>
					<div style="display:inline;float:left"><img src="<%=ConfigManager.IMG_ENURI_COM%>/2010/images/search/r1.gif" border="0"/></div>
				</div>
				 -->
			 	<div style="width:288px;height:30px;margin-top:2px;">
					<ul style="list-style:none;margin:0px;padding:0px">
						<li id="div_search_01" style="display:inline;padding:0px;margin:0px;float:left;width:24px;height:30px;background-image:url(<%=ConfigManager.IMG_ENURI_COM%>/2010/images/search/l1.gif);"></li>
						<li id="div_search_02" style="display:inline;padding:0px;margin:0px;float:left;width:195px;background-image:url(<%=ConfigManager.IMG_ENURI_COM%>/2010/images/search/bg2.gif);height:30px;"><input name="keyword"  id="keyword" type="text" autocomplete=off value="" 
								tabIndex="1"
								onkeydown="changeStyle(this,'on');oT_search(event);"
								onmousedown = "changeStyle(this,'on');oT_search(event);"	
								onBlur="changeStyle(this,'off');" 
								onFocus="changeStyle(this,'on');" 
								style="_margin-top:6px;padding-top:2px;width:190px;height:14px;border:0px;font-family:돋움;font-size:9pt;color:#FF0000;outline:none;<%=request.getParameter("skeyword") == null ? "background-image:url("+strRanSearchImage+");background-repeat: no-repeat;" : "" %>">
						</li>		
						<li style="display:inline;float:left;width:19px;height:30px;background-image:url(<%=ConfigManager.IMG_ENURI_COM%>/2012/search/main_sc1.gif);" id="img_close_auto" onclick="document.fmMainSearch.keyword.value='';document.fmMainSearch.keyword.focus();" ></li>
						<li style="display:inline;cursor:pointer;float:left;width:33px;height:30px;background-image:url(<%=ConfigManager.IMG_ENURI_COM%>/2010/images/search/bg1.gif);" onclick="Cmd_MainSearchSubmit();" id="btn_search_main" ><img src="<%=ConfigManager.IMG_ENURI_COM%>/2010/images/search/btn1.gif" border="0" width="33" height="21" style="margin-top:4px;VERTICAL-ALIGN:top;" id="btn_search_main_"></li>
						<li style="display:inline;float:left;width:17px;height:30px;background-image:url(<%=ConfigManager.IMG_ENURI_COM%>/2010/images/search/r1.gif);"></li>
					</ul>	
				</div>				
				</td>
				<!-- 
				<td style="padding-left:30px;padding-top:4px;">
					<img id="2010_Wt" src="<%=ConfigManager.IMG_ENURI_COM %>/images/main_2008/topmenu/wt_title.gif" onmouseover="Cmd_2010_Wt(1);" onmouseout="Cmd_2010_Wt(2);">
				</td>
				<tr>
				 -->
				</table>
				</form>		
			</div>
<%
	}
%>
			<div style="float:left;width:18%;z-index:90;">
				<div style="display:inline;float:left;padding-top:8px;padding-left:20px;"><span onclick="Cmd_Event_Tab(1);"><img src="<%=ConfigManager.IMG_ENURI_COM %>/images/main_2008/topmenu/tab_eventno5_120702.gif" style="cursor:pointer;margin:0px 10px 0px 14px;" border="0" id="event_tab"></span></div>
				<%if(menuType.equals("6")) {%>
				<div style="display:inline;float:left;padding-top:9px;"><img src="<%=ConfigManager.IMG_ENURI_COM %>/images/main_2008/topmenu/all_off.gif"  border="0" onclick="insertLog(1503);Cmd_Sitemap_All();" style="cursor:pointer;margin:0px 4px 0px 5px;" onmouseover="this.src='<%=ConfigManager.IMG_ENURI_COM %>/images/main_2008/topmenu/all_on.gif';" onmouseout="this.src='<%=ConfigManager.IMG_ENURI_COM %>/images/main_2008/topmenu/all_off.gif';"></div>
				<%}%>  
				<div style="position:absolute;display:inline;float:left;height:18px;padding-top:3px;"> 
					<img id="knowbox_top" src="<%=ConfigManager.IMG_ENURI_COM%>/images/main_2008/topmenu/knowbox.gif" onClick="insertLog(793);CmdKBOver(event);this.blur();return false;" style="cursor:pointer;margin:0px 0px 0px 7px;<%if(userAgentStr.toLowerCase().indexOf("msie 9")>-1) {%>padding-left:2px;<%}%>" onmouseout="CmdKBMenuCheck();" />
				</div>
			</div>
			<%if(!menuType.equals("6")) {%>
				<%if(!menuType.equals("7")) {%>
					<div style="display:inline;float:right;margin-top:10px;margin-left:10px;"><img src="<%=ConfigManager.IMG_ENURI_COM %>/images/main_2008/topmenu/all_off.gif"  border="0" align='absmiddle' onclick="insertLog(1503);Cmd_Sitemap_All();" style='cursor:pointer;margin:0 2 0 5;' onmouseover="this.src='<%=ConfigManager.IMG_ENURI_COM %>/images/main_2008/topmenu/all_on.gif';" onmouseout="this.src='<%=ConfigManager.IMG_ENURI_COM %>/images/main_2008/topmenu/all_off.gif';"></div>
				<%}else{%>
					<div style="display:inline;float:right;margin-top:10px;margin-left:2px;"><img src="<%=ConfigManager.IMG_ENURI_COM %>/images/main_2008/topmenu/all_off.gif"  border="0" align='absmiddle' onclick="insertLog(1503);Cmd_Sitemap_All();" style='cursor:pointer;margin:0 2 0 5;' onmouseover="this.src='<%=ConfigManager.IMG_ENURI_COM %>/images/main_2008/topmenu/all_on.gif';" onmouseout="this.src='<%=ConfigManager.IMG_ENURI_COM %>/images/main_2008/topmenu/all_off.gif';"></div>
				<%}%>
			<%}%>
		</div>
		<div id="topmenu" style="clear:both;">
		<jsp:include page="/common/jsp/Topmenu_2010.jsp">
		<jsp:param name="menuType" value="<%=menuType%>"/>
		</jsp:include>
		</div>
	</div> 
	<%if(menuType.equals("6")) {%>
	<SCRIPT language="JavaScript">
	<!-- 
	function setShortMenu() {
		var rootWidth = 980;

		$("topMenuTable").style.width = rootWidth + "px";
		$("layermenu_top").style.width = (rootWidth - 160) + "px";
	}

	function setLongMenu() {
		var rootWidth = 1210;

		$("topMenuTable").style.width = rootWidth + "px";
		$("layermenu_top").style.width = (rootWidth - 160) + "px";
	}

	function showMyFavor() {
		document.getElementById("frmSaveGoods").src = "/view/SaveGoodsList_2010.jsp";	
	}

	function showMyZzim() {
		if(islogin()) {
			document.getElementById("frmSaveGoods").src = "/view/SaveGoodsList_2010.jsp?tbln=save";	
		} else {
			Cmd_Login("showzzim2010");
		}
	}

	var timerAccountLayer;
	function showNonbanking_site() {
		if (timerAccountLayer != null && typeof(timerAccountLayer) != "undefined"){
			clearTimeout(timerAccountLayer)
		}
		if (document.getElementById("nonbanking_site1").style.display == "none"){
			document.getElementById("nonbanking_site1").style.left = (document.getElementById("aside").offsetLeft + 3)+"px";
			document.getElementById("nonbanking_site1").style.top = getBodyScrollTop() + "px";	
			document.getElementById("nonbanking_site1").style.display = "";
		}
	}

	function hideNonbanking_site() {
		timerAccountLayer = setTimeout("hideAccountLayer()", 500);
	}

	function hideAccountLayer(){
		document.getElementById("nonbanking_site1").style.display = "none";
		try {
			if($("frmMainLogin").contentWindow.document.getElementById("div_loginid")) {
				$("frmMainLogin").contentWindow.document.getElementById("div_loginid").style.display = "";
			}
		} catch(e) {}
	}

	function showLoginStatus() {
		if(islogin()) {
			try {
				if($("frmMainLogin") && $("frmMainLogin").contentWindow.document.body.innerHTML.length<200) {
					$("frmMainLogin").src = "/login/Loginstatus_2010.jsp?main=Y&logintop_menu=knowbox";
				}
			} catch(e) {}
			if($("loginDiv1")) $("loginDiv1").style.display = "none";
			if($("loginDiv2")) $("loginDiv2").style.display = "";
		} else {
			if($("loginDiv1")) $("loginDiv1").style.display = "";
			if($("loginDiv2")) $("loginDiv2").style.display = "none";
		}
	}
	-->
	</SCRIPT>
	<div id="rightMenuButtonDiv" style="float:right;width:150px;height:50px;top:0px;margin:0px 0px 0px 0px;">
		<div style="float:left;width:6px;height:50px;margin:0px 0px 0px 6px;overflow:hidden;">
			<img src="<%=ConfigManager.IMG_ENURI_COM%>/images/main_2010/topmenu/line.gif" />
		</div>
		<div style="float:right;width:130px;height:50px;margin:0px 0px 0px 0px;overflow:hidden;">
			<div id="loginDiv1" style="width:130px;height:20px;margin:11px 0px 3px 0px;overflow:hidden;<%=(IsLogin)?"display:none;":""%>">
				<div onClick="Cmd_Login('knowbox');" style="float:left;overflow:hidden;cursor:pointer;font-size:8pt;font-family:돋움;color:#014c90;">로그인</div>
				<div onClick="CmdJoin(1);" style="float:right;overflow:hidden;cursor:pointer;font-size:8pt;font-family:돋움;color:#014c90;">회원가입</div>
			</div>
			<div id="loginDiv2" style="width:130px;height:20px;margin:7px 0px 7px 0px;overflow:hidden;<%=(IsLogin)?"":"display:none;"%>">
				<iframe id="frmMainLogin" name="frmMainLogin" src="/login/Loginstatus_2010.jsp?main=Y&logintop_menu=knowbox" frameborder=0 style="background-image:url(<%=ConfigManager.IMG_ENURI_COM%>/2010/images/view/top_sub_bg.gif);width:131px;height:20px;overflow:hidden;" scrolling="no" onload="showLoginStatus();"></iframe>
			</div>
			<div style="width:130px;height:20px;overflow:hidden;">
				<div style="float:right;">
					<img style="cursor:pointer;" onClick="showMyFavor();" src="<%=ConfigManager.IMG_ENURI_COM%>/images/main_2010/topmenu/bt1_off.gif" onMouseOver="this.src='<%=ConfigManager.IMG_ENURI_COM%>/images/main_2010/topmenu/bt1_ov.gif';" onMouseOut="this.src='<%=ConfigManager.IMG_ENURI_COM%>/images/main_2010/topmenu/bt1_off.gif';" />
					<img style="cursor:pointer;" onClick="showMyZzim();" src="<%=ConfigManager.IMG_ENURI_COM%>/images/main_2010/topmenu/bt2_off.gif" onMouseOver="this.src='<%=ConfigManager.IMG_ENURI_COM%>/images/main_2010/topmenu/bt2_ov.gif';" onMouseOut="this.src='<%=ConfigManager.IMG_ENURI_COM%>/images/main_2010/topmenu/bt2_off.gif';" />
				</div>
			</div>
		</div>
	</div>
	<%}%>
</div>
<div style="display:none;position:absolute;z-index:230;" id="div_Event_Tab">   
	<div style="position:absolute;">
		<img src="<%=ConfigManager.IMG_ENURI_COM %>/images/main_2008/topmenu/layer_eventno4n.gif" border="0" usemap="#eventno" onmouseover="Cmd_Event_Tab(1);"/>
		<map name="eventno" id="eventno">  
			<area shape="rect" coords="69,3,79,12" href="javascript:;" onclick="Cmd_Event_Tab(2);"/>
		</map>
		<div style="position:absolute;top:<%if(userAgentStr.toLowerCase().indexOf("msie 6")>-1) {%>8px;<%}else{%>7px<%}%>;left:0;line-height:13px;padding-left:6px;font-family:돋움;font-size:8pt;color:#000000;cursor:pointer;" onmouseover="this.style.color='#800000'" onmouseout="this.style.color='#000000'" onclick="Cmd_Event_Link(3);">체험단</div>
		<div style="position:absolute;top:<%if(userAgentStr.toLowerCase().indexOf("msie 6")>-1) {%>24px;<%}else{%>23px<%}%>;left:0;line-height:13px;padding-left:6px;font-family:돋움;font-size:8pt;color:#000000;cursor:pointer;" onmouseover="this.style.color='#800000'" onmouseout="this.style.color='#000000'" onclick="Cmd_Event_Link(1);">개봉상품판매</div>
		<div style="position:absolute;top:<%if(userAgentStr.toLowerCase().indexOf("msie 6")>-1) {%>40px;<%}else{%>40px<%}%>;left:0;line-height:13px;padding-left:6px;font-family:돋움;font-size:8pt;color:#000000;cursor:pointer;" onmouseover="this.style.color='#800000'" onmouseout="this.style.color='#000000'" onclick="Cmd_Event_Link(7);">여행 이벤트</div>
		<div style="position:absolute;top:<%if(userAgentStr.toLowerCase().indexOf("msie 6")>-1) {%>56px;<%}else{%>56px<%}%>;left:0;line-height:13px;padding-left:6px;font-family:돋움;font-size:8pt;color:#000000;cursor:pointer;" onmouseover="this.style.color='#800000'" onmouseout="this.style.color='#000000'" onclick="Cmd_Event_Link(8);">모바일</div>
	</div>
</div>
<div style="display:none;position:absolute;z-index:130;" id="div_Car_Layer">
	<div style="position:absolute;">
		<img src="<%=ConfigManager.IMG_ENURI_COM %>/images/main_2008/topmenu/bg_layer_sincha3.gif" border="0" usemap="#sincha" onmouseover="Cmd_Car_Layer(1);">
		<map name="sincha" id="sincha">
			<area shape="rect" coords="53,4,61,11" href="javascript:;"  onclick="Cmd_Car_Layer(2);"/> 
		</map>  
		<div style="position:absolute;top:<%if(userAgentStr.toLowerCase().indexOf("msie 6")>-1) {%>8px;<%}else{%>7px<%}%>;left:0;line-height:13px;padding-left:6px;font-family:돋움;font-size:8pt;color:#000000;cursor:pointer;" onmouseover="this.style.color='#800000'" onmouseout="this.style.color='#000000'" onclick="insertLog(5965);location.href='/car/Index.jsp?stp=4';">초기화면</div>
		<div style="position:absolute;top:<%if(userAgentStr.toLowerCase().indexOf("msie 6")>-1) {%>24px;<%}else{%>23px<%}%>;left:0;line-height:13px;padding-left:6px;font-family:돋움;font-size:8pt;color:#000000;cursor:pointer;" onmouseover="this.style.color='#800000'" onmouseout="this.style.color='#000000'" onclick="insertLog(5966);location.href='/car/Index.jsp?stp=1';">비교목록</div>
	</div>
</div> 
</td><td style="width:18px;height:64px;background-image:url(<%=ConfigManager.IMG_ENURI_COM%>/2010/images/view/top/top_sub02.gif);"></td></tr></table>
<script language="JavaScript">
<!-- 
// 검색관련 함수
function img_close_autoAction() {
	if($("ac_layer")) $("ac_layer").style.display = "none";
	if($("img_close_auto")){
		$("img_close_auto").style.backgroundImage = "url(<%=ConfigManager.IMG_ENURI_COM %>/2012/search/main_sc1.gif)";
		$("img_close_auto").style.cursor="arrow";
	}
}

var strRanSearchImage = "<%=strRanSearchImage%>";
var book_name;
function OpenWindow_book(shop_code,body_frame,book_key_name) {
	if(BrowserDetect.browser!="Explorer"){
		//alert("도서가격비교는 Internet Explorer 6,7,8  버전에서만 사용가능합니다.");
			booklayerShow();
		return;
	}

	var site_url="http://<%=request.getServerName()%>";
	url = "?head_frame="+site_url+"/book/book_no_price_next.jsp&body_frame="+body_frame+"&head_price="+site_url+"/book/book_price.jsp&head_no_price="+site_url+"/book/book_no_price_next.jsp&shop_code="+shop_code
	var targeturl="/book/enuri_book2.jsp"+url;
	if(book_name==null) {
		book_name=window.open(targeturl,"","top=0,left=0,toolbar=no,directories=no,status=no,scrollbars=no,resizable=yes,menubar=no");
	} else {
		try{
			book_name.focus();
		}catch(e){
			book_name=window.open(targeturl,"","top=0,left=0,toolbar=no,directories=no,status=no,scrollbars=no,resizable=yes,menubar=no");
		}
	}
}
-->
</script>
<%/*도서 경고 레이어*/%>
<div id="booklayer" style="align:center; display:none;position:absolute;z-index:50;width:452px;height:189px; top:0px;left:0px;">
<img src="<%=ConfigManager.IMG_ENURI_COM %>/images/main/booklayer_111117.png" usemap="#booklayerMap">
<map name="booklayerMap" id="booklayerMap">
<area shape="rect" coords="417,-15,505,24" href="JavaScript:booklayerClose();"/>
</map>
</div>
<SCRIPT language="JavaScript">
<!--

function booklayerShow() {
		var w = document.body.offsetWidth;
		var h = document.body.offsetHeight;
		if($("booklayer").style.display=="none") {
			
			//alert("document.body.offsetWidth="+document.body.offsetWidth);
			//if(w==1024) {
			//$("booklayer").style.left = "270px";
			//$("booklayer").style.top = "220px";
			//}else if(w>1024){
			//$("booklayer").style.left = "419px";
			//$("booklayer").style.top = "320px";
			//}
			//alert(w/2+","+h/2)
			$("booklayer").style.left = w/2 - 250+ "px";
			$("booklayer").style.top = "320px";
			$("booklayer").style.display = "";
			
		} else {
			booklayerClose();
		}
	}

	function booklayerClose() {
		$("booklayer").style.display = "none";
	}

	function initBodyResize(){
		booklayerShow();
	}

-->
</SCRIPT>
<%/*구글 검색 레이어 */%>
<%
	// 자동차 보험 예외처리
	String carInfoStr = "";
	if(request.getRequestURL().indexOf("Paxinsu.jsp")>-1 || request.getRequestURL().indexOf("Flower_Easyflower.jsp")>-1) {
		carInfoStr = "Y";
	}
%>
<%if(!menuType.equals("6")) {%>
<IFRAME id="menuDataFrm" name="menuDataFrm" src="/common/jsp/Ajax_TopmenuDummy.jsp?carInfoStr=<%=carInfoStr%>" style="height:0px;width:0px;position:absolute;" frameBorder="0"></IFRAME>
<%}%>
<div style="display:none;position:absolute;z-index:230;" id="div_2010_Wt">
	<table width="74"  height="134" border="0" cellspacing="0" cellpadding="0">
		<tr height="16">
			<td width="74"><img src="<%=ConfigManager.IMG_ENURI_COM %>/images/main_2008/topmenu/wt_on.gif" border="0" onmouseover="Cmd_2010_Wt(1);" onmouseout="Cmd_2010_Wt(2);" usemap="#wt_map"><br></td>
		</tr>
		<tr height="118">
			<td width="74" background="<%=ConfigManager.IMG_ENURI_COM %>/images/main_2008/topmenu/wt_bg.gif" onmouseover="Cmd_2010_Wt(1);" onmouseout="Cmd_2010_Wt(2);">
				<table border="0" cellspacing="0" cellpadding="0">
					<tr><td height="3"></td></tr>
					<tr>
						<td style="line-height:18px;width:88px;padding-left:7px;font-family:돋움;font-size:8pt;color:#000000;cursor:pointer;" onmouseover="this.style.color='#800000'" onmouseout="this.style.color='#000000'" onclick="Cmd_Wt_Link('1');">전기히터</td>
						</tr>
					<tr>
						<td style="line-height:18px;width:88px;padding-left:7px;font-family:돋움;font-size:8pt;color:#000000;cursor:pointer;" onmouseover="this.style.color='#800000'" onmouseout="this.style.color='#000000'" onclick="Cmd_Wt_Link('2');">온풍기</td>
						</tr>
					<tr>
						<td style="line-height:18px;width:88px;padding-left:7px;font-family:돋움;font-size:8pt;color:#000000;cursor:pointer;" onmouseover="this.style.color='#800000'" onmouseout="this.style.color='#000000'" onclick="Cmd_Wt_Link('3');">전기요</td>
					</tr>
					<tr>
						<td style="line-height:18px;width:88px;padding-left:7px;font-family:돋움;font-size:8pt;color:#000000;cursor:pointer;" onmouseover="this.style.color='#800000'" onmouseout="this.style.color='#000000'" onclick="Cmd_Wt_Link('4');">옥/건강매트</td>
					</tr>
					<tr>
						<td style="line-height:18px;width:88px;padding-left:7px;font-family:돋움;font-size:8pt;color:#000000;cursor:pointer;" onmouseover="this.style.color='#800000'" onmouseout="this.style.color='#000000'" onclick="Cmd_Wt_Link('5');">손난로</td>
					</tr>
					<tr>
						<td style="line-height:18px;width:88px;padding-left:7px;font-family:돋움;font-size:8pt;color:#000000;cursor:pointer;" onmouseover="this.style.color='#800000'" onmouseout="this.style.color='#000000'" onclick="Cmd_Wt_Link('6');">어그부츠</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<map name="wt_map" id="wt_map">
		<area shape="rect" coords="60,2,70,13" onclick="document.getElementById('div_2010_wt').style.display='none'" href="javascript:;"/>
	</map>
</div>
<%
if(strLogoLayerImg.equals("T")){
%>
<div id="Logo_Layer" style="display:none;width:275px;height:109px;position:absolute;left:90px;top:1px;z-index:998;">
  <table width="275" border="0" cellspacing="0" cellpadding="0">
      <tr>
          <td height="109" onmouseover="Cmd_Logo_Layer(1);" onmouseout="Cmd_Logo_Layer(2);"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/main_2008/topmenu/201101/main_layer_110310_list.gif" id="LogoLayerImg" width="275" height="109" border="0" usemap="#LogoLayerImg" /></td>
      </tr>
      <map name="LogoLayerImg" id="LogoLayerImg"> 
        <area shape="rect" coords="258,6,270,17" href="javascript:;" onclick="fnSetCookie_MainLogo('Logo_Layer','1');$('Logo_Layer').style.display='none';" onmouseover="Cmd_Logo_Layer(1);"/>
		<area shape="rect" coords="182,87,240,102" href="javascript:;" onclick="$('T_Banner_L').style.display='inline';" style="cursor:pointer;" onfocus="this.blur();" onmouseover="Cmd_Logo_Layer(1);"/>
      </map>
  </table> 
</div>
<% 
}
%>

<div style="display:none;position:absolute;z-index:230;" id="div_2010_White">
	<table width="77"  height="114" border="0" cellspacing="0" cellpadding="0">
		<tr height="15">
			<td><img border="0" src="<%=ConfigManager.IMG_ENURI_COM %>/images/main_2008/topmenu/wday2_on.gif" onmouseover="Cmd_2010_White(1);" onmouseout="Cmd_2010_White(2);" usemap="#white_map"><br></td>
		</tr>
		<tr height="99">
			<td background="<%=ConfigManager.IMG_ENURI_COM %>/images/main_2008/topmenu/wday2_bg.gif" onmouseover="Cmd_2010_White(1);" onmouseout="Cmd_2010_White(2);">
				<table border="0" cellspacing="0" cellpadding="0">
						<tr><td style="line-height:15px;padding-top:4px;padding-left:9px;font-family:돋움;font-size:8pt;color:#000000;cursor:pointer;" onmouseover="this.style.color='#800000'" onmouseout="this.style.color='#000000'" onclick="Cmd_White_Link(1);">초콜릿/사탕</td></tr>
						<tr><td style="line-height:15px;padding-left:9px;font-family:돋움;font-size:8pt;color:#000000;cursor:pointer;" onmouseover="this.style.color='#800000'" onmouseout="this.style.color='#000000'" onclick="Cmd_White_Link(2);">커플쥬얼리</td></tr>
						<tr><td style="line-height:15px;padding-left:9px;font-family:돋움;font-size:8pt;color:#000000;cursor:pointer;" onmouseover="this.style.color='#800000'" onmouseout="this.style.color='#000000'" onclick="Cmd_White_Link(3);">여성핸드백</td></tr>
						<tr><td style="line-height:15px;padding-left:9px;font-family:돋움;font-size:8pt;color:#000000;cursor:pointer;" onmouseover="this.style.color='#800000'" onmouseout="this.style.color='#000000'" onclick="Cmd_White_Link(4);">향수</td></tr>
						<tr><td style="line-height:15px;padding-left:9px;font-family:돋움;font-size:8pt;color:#000000;cursor:pointer;" onmouseover="this.style.color='#800000'" onmouseout="this.style.color='#000000'" onclick="Cmd_White_Link(5);">꽃배달</td></tr>
						<tr><td style="line-height:15px;padding-left:9px;font-family:돋움;font-size:8pt;color:#000000;cursor:pointer;" onmouseover="this.style.color='#800000'" onmouseout="this.style.color='#000000'" onclick="Cmd_White_Link(6);">파티용품</td></tr>
				</table>	
			</td>
		</tr>
	</table>
</div>
<map name="wc_map" id="wc_map">
	<area shape="rect" coords="64,4,76,11" onclick="$('div_2010_Wc').style.display='none'" href="#"/>
</map>
<map name="white_map" id="white_map">
	<area shape="rect" coords="66,2,77,11" onclick="$('div_2010_White').style.display='none'" href="#"/>
</map>
<SCRIPT language="JavaScript">
<!--
var tid_wt;
var tid_Event;

function Cmd_Wt_Link(param){
	if(param == "1"){
		insertLog(5024);
		top.location.href = "/view/List.jsp?cate=050416";
	}else if(param == "2"){
		insertLog(5025);
		top.location.href = "/view/List.jsp?cate=050408";	
	}else if(param == "3"){
		insertLog(5026);
		top.location.href = "/view/List.jsp?cate=051606";	
	}else if(param == "4"){
		insertLog(5027);
		top.location.href = "/view/List.jsp?cate=051608";	
	}else if(param == "5"){
		insertLog(5028);
		top.location.href = "/view/List.jsp?cate=09201101";	
	}else if(param == "6"){
		insertLog(5029);
		top.location.href = "/view/fusion/Fusion.jsp?cate=14540109&factory=&keyword=";	
	}else{
	}
}
function Cmd_2010_Wt(param){
 	if(param == "1"){
 		clearTimeout(tid_wt);
 		$("div_2010_Wt").style.display = "inline";
 		$("div_2010_Wt").style.top = (Position.cumulativeOffset($("2010_Wt"))[1] - 5) + "px";
		$("div_2010_Wt").style.left = (Position.cumulativeOffset($("2010_Wt"))[0] - 13) + "px";
 	}else{
 		tid_wt = setTimeout("Cmd_2010_Close(1)", 300);
 	}
}
function Cmd_Event_Link(param){
	if(param == "1"){
		insertLog(6431);
		top.location.href = "/event/Resell.jsp";
	}else if(param == "3"){
		insertLog(6430);
		top.location.href = "/event/EventReviewAll.jsp?status=";	
	}else if(param == "4"){
//		insertLog(5101);
//		top.location.href = "/event/EventGuide.jsp";	
//		insertLog(5610);
		top.location.href = "/event/Event_Guide_Travel.jsp";	
	}else if(param == "7"){
		insertLog(7936); 
		top.location.href = "/event/EventTourAll.jsp";	
	}else if(param == "8"){
		insertLog(8001); 
		QR_pop();
	}else{
	}
}

function QR_pop(){
	//var QR_pop = window.open("/include/main/main2010/QR_POP.jsp","QR_POP1","width=690,height=434,left=0,top=0,toolbar=no,directories=no,status=no,scrollbars=no,resizable=no, menubar=no");
	//QR_pop.focusinc();
	var QR_pop2 = "var QR_POP=window.open('/mobile/popup.jsp','QR_pop2','width=361,height="+window.screen.availHeight+",left="+(window.screen.availWidth-361)+",top=0,toolbar=no,directories=no,status=no,scrollbars=no,resizable=no, menubar=no');QR_POP.focus();"
	QR_pop2 = QR_pop2 + " ";	 
	eval(QR_pop2); 
}


function Cmd_Event_Tab(param){
	CmdKBHideMenu();
	Cmd_2010_Close(3);
 	if(param == "1"){
 		//clearTimeout(tid_Event);
 		$("div_Event_Tab").style.display = "inline";
 		$("div_Event_Tab").style.top =  "6px";
		$("div_Event_Tab").style.left = (Position.cumulativeOffset($("event_tab"))[0] - 27) + "px";
		//$("event_tab").src = "<%=ConfigManager.IMG_ENURI_COM%>/images/main_2008/topmenu/tab_shim.gif";
 	}else{
 		Cmd_2010_Close(2);
 		//tid_Event = setTimeout("Cmd_2010_Close(2)", 300);
 	}
}
function Cmd_Car_Layer(param){
	CmdKBHideMenu();
	Cmd_2010_Close(2); 
 	if(param == "1"){ 
 		//clearTimeout(tid_Event);
 		$("div_Car_Layer").style.display = "inline";
 		$("div_Car_Layer").style.top = "6px";
		$("div_Car_Layer").style.left = (Position.cumulativeOffset($("topmenu_carlayer"))[0] - 9 ) + "px";
 	}else{
 		Cmd_2010_Close(3);
 		//tid_Event = setTimeout("Cmd_2010_Close(3)", 300);
 	}
}
function Cmd_2010_Close(param){
	if(param == 1){
		$("div_2010_Wt").style.display = "none";
	}else if (param ==2){
		$("event_tab").src = "<%=ConfigManager.IMG_ENURI_COM%>/images/main_2008/topmenu/tab_eventno5_120702.gif";
		$("div_Event_Tab").style.display = "none";
	}else if (param ==3){
		$("div_Car_Layer").style.display = "none";
	}
}

function Cmd_Sitemap_All(){
	document.getElementById("frmAllMenu").src = "/etc/All_Menu_2010.jsp?exlink=<%=bExLink%>";	
	CmdKBHideMenu();
}
function fnGetCookie( name ){
    var nameOfCookie = name + "=";
    var x = 0;
    while ( x <= document.cookie.length )
    {
            var y = (x+nameOfCookie.length);
            if ( document.cookie.substring( x, y ) == nameOfCookie ) {
                    if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 )
                            endOfCookie = document.cookie.length;
                    return unescape( document.cookie.substring( y, endOfCookie ) );
            }
            x = document.cookie.indexOf( " ", x ) + 1;
            if ( x == 0 )
                    break;
    }
    return "";
}
function fnSetCookie(maxage){
    var todayDate = new Date();
    todayDate.toGMTString()
    todayDate.setDate( todayDate.getDate() + maxage );
    document.cookie = "DetailInfo" + "=" + escape( "CHECKED" ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
    document.getElementById("div_map_detail_info").style.display = "none";
}
if ( fnGetCookie("DetailInfo") == "" ) {
	if (document.getElementById("div_map_detail_info") != null){
		var varDivMapDetailInfo = "";
		varDivMapDetailInfo = "<table width=\"194\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">";
		varDivMapDetailInfo += "<tr>";
		varDivMapDetailInfo += "<td><img src=\"<%=ConfigManager.IMG_ENURI_COM%>/images/view/layer_bg.gif\" width=\"194\" height=\"124\" border=\"0\" usemap=\"#Map_Detail_Info\" /></td>";
		varDivMapDetailInfo += "</tr>";
		varDivMapDetailInfo +="</table>";
		varDivMapDetailInfo += "<map name=\"Map_Detail_Info\" id=\"Map_Detail_Info\">";
		varDivMapDetailInfo += "<area shape=\"rect\" coords=\"56,77,94,95\" href=\"#\" onClick=\"openGoodsDetailInfoLayer();return false\"/>";
		varDivMapDetailInfo += "<area shape=\"rect\" coords=\"102,78,141,96\" href=\"#\" onClick=\"fnSetCookie(7);return false\"/>";
		varDivMapDetailInfo += "</map>"; 
		
		document.getElementById("div_map_detail_info").innerHTML = varDivMapDetailInfo;
		document.getElementById("div_map_detail_info").style.display = "";
		try{
			var url = "/include/ajax/AjaxRecentRight_2010.jsp";
			var param = "";
			var getRecentRight = new Ajax.Request(
				url,
				{
					method:'get',parameters:param,onComplete:showDetailInfo
				}
			);		
			function showDetailInfo(originalRequest){
				if (originalRequest.responseText.indexOf("최근 본 상품 없음") < 0 ){
					document.getElementById("div_map_detail_info").style.display = "none";
				}
			}
		}catch(e){
		}
	}
}
var logolayerTimer = null;

function Cmd_Logo_Layer(param){
}
function Cmd_Logo_Layer2(param){
/*
	if (fnGetCookie("Logo_Layer") == "1"){
	 
	}else{
		if(param==1){
			clearTimeout(logolayerTimer);
			$('Logo_Layer').style.display='inline';
		}else if(param==2){
			logolayerTimer = setTimeout("Cmd_Logo_Layer(3)",100);
		}else if(param==3){
			clearTimeout(logolayerTimer);
			if($("T_Banner_L").style.display == "inline") {
				$('Logo_Layer').style.display='inline';	
			}else{
				$('Logo_Layer').style.display='none';	
			}
		}
	}
*/
}
function Cmd_Tgate(){
	window.open("http://tgate.kca.go.kr/itemCompare/comparison_view.jsp?main=Y&npage=1&main_code=19&sub_main_code=99&seq=1115&product_name=가격비교%20","tgate_pop2","toolbar=yes,menubar=yes,status=yes,location=yes,scrollbars=yes,resizable=yes,top=0,left=0,width="+screen.availWidth+",height="+screen.availHeight);
	//window.open("http://article.joins.com/article/article.asp?total_id=3424469","tgate_pop2","toolbar=yes,menubar=yes,status=yes,location=yes,scrollbars=yes,resizable=yes,top=0,left=0,width="+screen.availWidth+",height="+screen.availHeight);
}
function fnSetCookie_MainLogo( name, value ){
	if (typeof(expiredays) == "undefined" || expiredays == null) {
		expiredays = "";
	}
	if (expiredays == ""){
		document.cookie = name + "=" + escape( value ) + "; path=/;"
	}else{
		var todayDate = new Date();
		todayDate.toGMTString();
		todayDate.setDate( todayDate.getDate() + expiredays );	
		document.cookie = name + "=" + escape( value ) + "; path=/;"
	}
	
}

function goMyPage(url){
	parent.top.location.href=url;
}
-->
</SCRIPT>