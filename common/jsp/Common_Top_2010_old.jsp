<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@ page import="com.enuri.include.RandomMain"%>
<jsp:useBean id="RandomMain" class="com.enuri.include.RandomMain" scope="page" />
<%
	/*Common_Top에 포함된 자바스크립트는 /common/js/common_top.js 에 있습니다*/
	
	/*즐겨찾기 이벤트 및 바탕화면 바로가기 이벤트를 위한 세션 처리*/
	String strEventRefererCheck = ChkNull.chkStr(request.getHeader("REFERER"),"");
	HttpSession Eventsession = request.getSession(true);
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
	int intRanSearch = RandomMain.getRandomValue(15)+1;
	String strRanSearchImage = "";
	if (DateStr.getYMD(DateStr.nowStr(),"M").equals("08")){
		intRanSearch = 0;
	}
	if (intRanSearch == 0){
		strRanSearchImage = ConfigManager.IMG_ENURI_COM + "/2010/images/view/search_txt.gif";
	}else{
		strRanSearchImage = ConfigManager.IMG_ENURI_COM + "/images/event/banner/search_tx_event_"+intRanSearch+".gif";	
	}		
%>
<script language="javascript">
var varRanSearch = <%=intRanSearch%>;
</script>
<script type="text/javascript" src="/common/js/autocom_search_2010.js"></script>
<script type="text/javascript" src="/common/js/exception_keyword.js"></script>
<jsp:include page="/join/join2009/IncJoin2009_2010.jsp" flush="true"></jsp:include>
<jsp:include page="/include/Inc_Common_LayerControl_2010.jsp" flush="true"></jsp:include>
<%/*고정위치 레이어들*/%>
<div id="div_allmenu_bg" style="z-index:200;position:absolute;display:none;width:0%;height:0%;background-color:#FEFEFE;filter:Alpha(opacity=40);opacity:0.5;-moz-opacity:0.5;"></div>  
<div id="div_allmenu" style="z-index:201;position:absolute;display:none;width:0%;height:0%;overflow-y:auto;">
<iframe width="902" height="580" border="0" src="" id="frmAllMenu" name="frmAllMenu" style="display:none;margin-left:8px;margin-top:15px;"  frameborder="0"   onload="syncWHAllMenu()"></iframe>
</div>
<%/*저장상품 레이어*/%>
<div id="div_sagegoods_bg" style="z-index:200;position:absolute;display:none;width:0%;height:0%;background-color:#333333;filter:Alpha(opacity=40);opacity:0.4;-moz-opacity:0.4;"></div>   
<div id="div_savegoods" style="z-index:201;position:absolute;display:none;width:0%;height:0%;overflow-y:auto;">
<iframe width="797" height="580" border="0" src="" id="frmSaveGoods" name="frmSaveGoods" style="display:none;margin-top:25px;"  frameborder="0"   onload="syncWHSaveGoods()"></iframe>
</div>
<div id="nonbanking_site1" style="font-size:8pt;width:131px; height:211px; position:absolute;  top:45px; z-index:99; display:none; overflow:hide; " onMouseOver="showNonbanking_site('');"  onMouseOut="showNonbanking_site('none');"></div>
<div id="m_menu_div" onMouseOver="clearTimeout(TimeHandler);" onMouseOut="CmdMenuCheck();" align="center" style="border-top:0;padding:0 0 0 0;margin:0 0 0 0;position:absolute;display:none;z-index:100;background-color:#D6D6D6;"></div>
<div id="c_menu_div" onMouseOver="clearTimeout(TimeHandler);" onMouseOut="CmdMenuCheck();" style="border:1px solid #8B9197;background-color:#FFFEE9;position:absolute;display:none;z-index:101;"></div>
<div id="menucolorDiv" style="position:absolute;display:none;background-color:#FFFEE9;width:1px;height:19px;z-index:102;display:none;"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/blank.gif" height="1" width="1"></div>
<div id="LayerM_KBMenu" style="position:absolute;z-index:103;width:110px;display:none;"></div>
<div id="LayerS_KBMenu" style="position:absolute;z-index:104;width:140px;display:none;"></div>
<div id="menucolorKBDiv1" style="position:absolute;background-color:#FFFFFF;display:none;z-index:106;"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/blank.gif" height="1" width="1"></div>
<div id="menucolorKBDiv2" style="position:absolute;background-color:#FFFFFF;display:none;z-index:106;"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/blank.gif" height="1" width="1"></div>
<div id="menuFashionImg" style="position:absolute;z-index:106;display:none;"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/main_2008/topmenu/top_info.gif"></div>
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
<iframe width="670px" height="456px" border="0" src="" style="position:absolute;display:none;overflow:hidden" scrolling="no" id="frmGoogleSearch" name="frmGoogleSearch" frameborder="0" onload="syncWHGoogleSearch()"></iframe>
<%
	/*처음 사용자 안내 레이어 */
	boolean bHideCloudLayer = false;
	String strHideCloudLayer = "Flower_Easyflower.jsp,Paxinsu.jsp,Smilecat.jsp,Site_map.jsp,Faq_List.jsp,Listmall.jsp,Duty.jsp,Secure.jsp,Mallregister.jsp,Sdul_join_guide.jsp,Enuriintro.jsp,Crlisthandphone.jsp,Brand_View.jsp,Listguide.jsp,Kbmap.jsp,Plan_List.jsp,Kb0401list.jsp,Tour_Guide_Airline1.jsp,Tour_Hoteltrees.jsp,Enurivision.jsp,Enurici.jsp,Enurihistory.jsp,Enurijob.jsp,Enurinews.jsp,Enuricf.jsp,Enuriaffiliate.jsp,Enurimap.jsp,/mallregister/new/,/enurilink/,/event/,/tour/,/callrate/,/knowbox/";
	String astrHideCloudLayer[] = strHideCloudLayer.split(",");
	for (int hc=0;hc<astrHideCloudLayer.length;hc++){
		if (request.getRequestURI().indexOf(astrHideCloudLayer[hc]) >= 0 ){
			bHideCloudLayer = true;
		}
	}
	if (!bHideCloudLayer && !ChkNull.chkStr(request.getParameter("islist"),"").trim().equals("webzine")){
%>
<div id='div_map_detail_info' style="position:absolute;left:778px;top:600px;z-index:102;width:200px;padding: 5 0 5 0;display:none;">
<table width="194" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/view/layer_bg.gif" width="194" height="124" border="0" usemap="#Map_Detail_Info" /></td>
	</tr>
</table>
<map name="Map_Detail_Info" id="Map_Detail_Info">
<area shape="rect" coords="56,77,94,95" href="#" onClick="showDetailInfo();return false"/>
<area shape="rect" coords="102,78,141,96" href="#" onClick="fnSetCookie(7);return false"/>
</map>
</div>
<%
	}
%>
<iframe name="ifrmMainSearch" id="ifrmMainSearch" frameborder="0" style="position:absolute;height:0;width:0;z-index:0;"></iframe>
<%/*탑메뉴 들어갈자리*/%>
<div id="LayerMenu" style="position:relateive;width:100%;height:61px;left:0px; top:0px; z-index:10;display:block;background-image:url(<%=ConfigManager.IMG_ENURI_COM%>/2010/images/view/top_sub_bg.gif)">
	<div id="layermenu_top">
		<div style="list-style:none;margin:0px;padding:0px">
			<div style="display:inline;width:24%;height:33px;padding:0px 0px 0px 0px;margin:0px;float:left;"><a href="/"><img src="<%=ConfigManager.IMG_ENURI_COM%>/2010/images/view/logo_sub.gif" width="162" height="33" style="margin:auto;display:block;"/></a></div>
<%
	if (!request.getServletPath().trim().equals("/search/Searchlist.jsp") && !request.getServletPath().trim().equals("/search/WebSearchlist.jsp") 
		&& !request.getServletPath().trim().equals("/fashion/Fashion_Searchlist.jsp")){
%>
			<div style="display:inline;width:43%;padding:0px;margin:0px;float:left;">
				<form name="fmMainSearch"  method="get" OnSubmit="return Cmd_MainSearch1();" style="margin:0px">
				<input type="hidden" name="issearchpage" value=''>
				<input type="hidden" name="searchkind" value="">
				<input type="hidden" name="es" value="">
			   	<input type=hidden name="c" value="">
			   	<input type=hidden name="ismodelno" value="">						
<%
		if(bExLink){
%>
				<input type=hidden name="exlink" value="Y">
<%
		}
%>
				<table border="0" cellspacing="0" cellpadding="0" align="right"><tr><td>
				<div style="width:231px;height:21px;background-image:url(<%=ConfigManager.IMG_ENURI_COM%>/2010/images/view/search_02.gif);margin-top:5px;">
					<div style="list-style:none;margin:0px;padding:0px;display:inline;">
						<span style="padding:0px;margin:0px;float:left;"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/main_2008/topmenu/search/search_01.gif" align='absmiddle' style='cursor:pointer'></span>
						<span style="padding:0px;margin:0px;float:left;padding-top:1px;"><input name="keyword"  id="keyword" type="text" autocomplete="off" value="<%=request.getParameter("skeyword") == null ? "" : request.getParameter("skeyword") %>" 
								onkeydown="oT_search(event);"
								onmousedown = "oT_search(event);"	
								onBlur="changeStyle(this,'off');" 
								onFocus="changeStyle(this,'on');" 
								style="margin-top:2px;padding-top:2px;width:177px;height:14px;border:0px;font-family:돋움;font-size:9pt;color:#FF0000;<%=request.getParameter("skeyword") == null ? "background-image:url("+strRanSearchImage+");background-repeat: no-repeat;" : "" %>">
						</span>		
						<span style="padding:0px;margin:0px;float:left;"><img src="<%=ConfigManager.IMG_ENURI_COM%>/2010/images/view/search_03.gif" border="0" onclick="if (oT){oT.toggle();}" style="cursor:pointer;"></span>
						<span style="padding:0px;margin:0px;float:left;"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/main_2008/topmenu/search/btn_search.gif" Onclick="Cmd_MainSearchSubmit();" id="btn_search_main" align='absmiddle' style='cursor:pointer'></span>
					</div>
				</div>
				</td><td style="padding-left:20px;padding-top:6px;">
					<img id="2010_Family" src="<%=ConfigManager.IMG_ENURI_COM %>/images/main_2008/topmenu/family.gif" onmouseover="Cmd_2010_Family(1);" onmouseout="Cmd_2010_Family(2);">
				</td><tr></table>
				</form>		
			</div>
<%
	}
%>
			<div style="display:inline;float:right;margin-top:4px;margin-left:10px;"><img id="knowbox_top" src="<%=ConfigManager.IMG_ENURI_COM%>/images/main_2008/topmenu/knowbox.gif" onClick="insertLog(793);CmdKBOver(event);this.blur();return false;" style='cursor:pointer;' onmouseout="CmdKBMenuCheck();" /></div>
			<div style="display:inline;float:right;margin-top:10px;margin-left:10px;"><img src="<%=ConfigManager.IMG_ENURI_COM %>/images/main_2008/topmenu/all_off.gif"  border="0" align='absmiddle' onclick="insertLog(1503);Cmd_Sitemap_All();" style='cursor:pointer;margin:3 2 0 5;' onmouseover="this.src='<%=ConfigManager.IMG_ENURI_COM %>/images/main_2008/topmenu/all_on.gif';" onmouseout="this.src='<%=ConfigManager.IMG_ENURI_COM %>/images/main_2008/topmenu/all_off.gif';"></div>
			<div style="display:inline;float:right;margin-top:10px;margin-left:10px;"><span onClick="insertLog(1502);location.href='/car/Index.jsp';Cmd_AutoVisit();" style="font-family:돋움;font-size:8pt;color:#484747;letter-spacing:-1;cursor:pointer;">신차비교</span></div>
			<div style="display:inline;float:right;margin-top:10px;margin-left:10px;"><span onClick="OpenWindow_book('55','http://book.interpark.com/bookPark/html/book_kor.html?bookblockname=b_gnb&booklinkname=국내도서','sc.prdNo');insertLog(434);" style="font-family:돋움;font-size:8pt;color:#484747;letter-spacing:-1;cursor:pointer;">책</span></div>
			<div style="display:inline;float:right;margin-top:10px;margin-left:10px;"><span onClick="insertLog(710);location.href='/tour2012/Tour_Index.jsp';" style="font-family:돋움;font-size:8pt;color:#484747;letter-spacing:-1;cursor:pointer;">여행</span></div>
			<div style="display:inline;float:right;margin-top:4px;margin-left:10px;"><img src="<%=ConfigManager.IMG_ENURI_COM %>/images/main_2008/topmenu/tab_event_2.gif" align="absmiddle" id="event_tab" border="0" onclick="Cmd_Event_Tab(1);" style="cursor:pointer;" !onmouseover="Cmd_Event_Tab(1);" !onmouseout="Cmd_Event_Tab(2);"></div>
		</div>
	</div>
	<div id="topmenu" style="clear:both">
	<jsp:include page="/common/jsp/Topmenu_2010.jsp">
	<jsp:param name="menuType" value="5"/>
	</jsp:include>
	</div>
</div>
<script language="JavaScript">
<!-- 
var book_name;
function OpenWindow_book(shop_code,body_frame,book_key_name) {
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
<%/*구글 검색 레이어 */%>
<%
	// 자동차 보험 예외처리
	String carInfoStr = "";
	if(request.getRequestURL().indexOf("Paxinsu.jsp")>-1 || request.getRequestURL().indexOf("Flower_Easyflower.jsp")>-1) {
		carInfoStr = "Y";
	}
%>
<IFRAME id="menuDataFrm" name="menuDataFrm" src="/common/jsp/Ajax_TopmenuDummy.jsp?carInfoStr=<%=carInfoStr%>" width="0" height="0" frameBorder="0"></IFRAME>
<!-- 어링이날 어버이날 -->
<div style="display:none;position:absolute;z-index:130;" id="div_2010_Family">
	<table width="141"  height="109" border="0" cellspacing="0" cellpadding="0">
		<tr height="16">
			<td><img src="<%=ConfigManager.IMG_ENURI_COM %>/images/main_2008/topmenu/family_on.gif" border="0" onmouseover="Cmd_2010_Family(1);" onmouseout="Cmd_2010_Family(2);" usemap="#family_map"><br></td>
		</tr>
		<tr height="93">
			<td background="<%=ConfigManager.IMG_ENURI_COM %>/images/main_2008/topmenu/family_bg.gif" onmouseover="Cmd_2010_Family(1);" onmouseout="Cmd_2010_Family(2);">
				<table border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td style="line-height:17px;width:63px;padding-top:2px;padding-left:6px;font-family:돋움;font-size:8pt;color:#000000;cursor:pointer;" onmouseover="this.style.color='#800000'" onmouseout="this.style.color='#000000'" onclick="Cmd_Family_Link('1');">완구</td>
							<td style="line-height:17px;width:75px;padding-top:2px;padding-left:2px;font-family:돋움;font-size:8pt;color:#000000;cursor:pointer;" onmouseover="this.style.color='#800000'" onmouseout="this.style.color='#000000'" onclick="Cmd_Family_Link('2');">안마기</td>
						</tr>
						<tr>
							<td style="line-height:17px;width:63px;font-family:돋움;padding-left:6px;font-size:8pt;color:#000000;cursor:pointer;" onmouseover="this.style.color='#800000'" onmouseout="this.style.color='#000000'" onclick="Cmd_Family_Link('3');">인라인</td>
							<td style="line-height:17px;width:75px;font-family:돋움;padding-left:2px;font-size:8pt;color:#000000;cursor:pointer;" onmouseover="this.style.color='#800000'" onmouseout="this.style.color='#000000'" onclick="Cmd_Family_Link('4');">인삼/홍삼</td>
						</tr>
						<tr>
							<td style="line-height:17px;width:63px;font-family:돋움;padding-left:6px;font-size:8pt;color:#000000;cursor:pointer;" onmouseover="this.style.color='#800000'" onmouseout="this.style.color='#000000'" onclick="Cmd_Family_Link('5');">자전거</td>
							<td style="line-height:17px;width:75px;font-family:돋움;padding-left:2px;font-size:8pt;color:#000000;cursor:pointer;" onmouseover="this.style.color='#800000'" onmouseout="this.style.color='#000000'" onclick="Cmd_Family_Link('6');">등산용품</td>
						</tr>
						<tr>
							<td style="line-height:17px;width:63px;font-family:돋움;padding-left:6px;font-size:8pt;color:#000000;cursor:pointer;" onmouseover="this.style.color='#800000'" onmouseout="this.style.color='#000000'" onclick="Cmd_Family_Link('7');">MP3</td>
							<td style="line-height:17px;width:75px;font-family:돋움;padding-left:2px;font-size:8pt;color:#000000;cursor:pointer;" onmouseover="this.style.color='#800000'" onmouseout="this.style.color='#000000'" onclick="Cmd_Family_Link('8');">내비게이션</td>
						</tr>
						<tr>
							<td style="line-height:15px;width:63px;font-family:돋움;padding-left:6px;font-size:8pt;color:#000000;cursor:pointer;" onmouseover="this.style.color='#800000'" onmouseout="this.style.color='#000000'" onclick="Cmd_Family_Link('9');">게임기</td>
							<td style="line-height:15px;width:75px;font-family:돋움;font-weight:bold;padding-top:2px;font-size:8pt;color:#000000;cursor:pointer;" onmouseover="this.style.color='#800000'" onmouseout="this.style.color='#000000'" onclick="Cmd_Family_Link('10');">추천선물모음</td>
						</tr>
				</table>	
			</td>
		</tr>
	</table>
</div>
<div style="display:none;position:absolute;z-index:130;" id="div_Event_Tab">
	<table width="82"  height="55px" border="0" cellspacing="0" cellpadding="0">
		<tr width="82" height="55px">
			<td height="55px" background="<%=ConfigManager.IMG_ENURI_COM %>/images/main_2008/topmenu/bg_layer_3.gif"  onmouseover="Cmd_Event_Tab(1);" onmouseout="Cmd_Event_Tab(2);">
				<table border="0" height="40px" cellspacing="0" cellpadding="0">
					<tr><td style="padding-top:3px;line-height:14px;padding-left:7px;">
					<div style="position:absolute;left:60px;top:3px;"><img src="<%=ConfigManager.IMG_ENURI_COM %>/images/main_2008/topmenu/icon_new_1.gif" align="absbottom"><div></td></tr>
					<tr><td height="15" width="77" style="line-height:14px;padding-left:6px;padding-top:4px;font-family:돋움;font-size:8pt;color:#000000;cursor:pointer;" onmouseover="this.style.color='#800000'" onmouseout="this.style.color='#000000'" onclick="Cmd_Event_Link(1);">개봉상품판매</td></tr>
					<tr><td height="16" width="77" style="line-height:14px;padding-left:6px;font-family:돋움;font-size:8pt;color:#000000;cursor:pointer;" onmouseover="this.style.color='#800000'" onmouseout="this.style.color='#000000'" onclick="Cmd_Event_Link(2);">95%대박할인</td></tr>
					<tr><td height="15" width="77" style="line-height:14px;padding-left:6px;font-family:돋움;paddig-bottom:1px;font-size:8pt;color:#000000;cursor:pointer;" onmouseover="this.style.color='#800000'" onmouseout="this.style.color='#000000'" onclick="Cmd_Event_Link(3);">체험단</td></tr>
				</table>		
			</td>
		</tr>
	</table>
</div>
<div style="display:none;position:absolute;z-index:130;" id="div_2010_White">
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
<map name="family_map" id="family_map">
	<area shape="rect" coords="128,4,138,12" onclick="$('div_2010_Family').style.display='none'" href="#"/>
</map>
<map name="white_map" id="white_map">
	<area shape="rect" coords="66,2,77,11" onclick="$('div_2010_White').style.display='none'" href="#"/>
</map>
<SCRIPT language="JavaScript">
<!--
var tid_Family;
var tid_Event;

function Cmd_Family_Link(param) {
	if(param == "1"){
		top.location.href = "/view/List.jsp?cate=1009";
	}else if(param == "2"){
		top.location.href = "/view/List.jsp?cate=051002";	
	}else if(param == "3"){
		top.location.href = "/view/List.jsp?cate=0906";	
	}else if(param == "4"){
		top.location.href = "/view/fusion/Fusion_Sub.jsp?cate=150105&search=YES&keyword=";	
	}else if(param == "5"){
		top.location.href = "/view/List.jsp?cate=0905";	
	}else if(param == "6"){
		top.location.href = "/view/List.jsp?cate=0903";	
	}else if(param == "7"){
		top.location.href = "/view/Listmp3.jsp?cate=0212&menu=true&islist=Y";	
	}else if(param == "8"){
		top.location.href = "/view/Listmp3.jsp?cate=2113&menu=true&islist=Y";
	}else if(param == "9"){
		top.location.href = "/view/List.jsp?cate=0408";
	}else if(param == "10"){
		top.location.href = "/view/List.jsp?cate=9005";
	}else{
	}
}

function Cmd_2010_Family(param) {
 	if(param == "1"){
 		clearTimeout(tid_Family);
 		$("div_2010_Family").style.display = "inline";
 		$("div_2010_Family").style.top = (Position.cumulativeOffset($("2010_Family"))[1] - 6) + "px";
		$("div_2010_Family").style.left = (Position.cumulativeOffset($("2010_Family"))[0] - 10) + "px";
 	}else{
 		//$("div_2010_Family").style.display = "none";
 		tid_Family = setTimeout("Cmd_2010_Close(1)", 300);
 	}
}

function Cmd_Event_Link(param){
	if(param == "1"){
		insertLog(3730);
		top.location.href = "/event/Resell.jsp";
	}else if(param == "2"){
		insertLog(3920);
		top.location.href = "/event/EventDiscount95.jsp";	
	}else if(param == "3"){
		insertLog(3401);
		top.location.href = "/event/EventReviewAll.jsp?status=";	
	}else{
	}
}

function Cmd_Event_Tab(param) {
 	if(param == "1"){
 		clearTimeout(tid_Event);
 		$("div_Event_Tab").style.display = "inline";
 		$("div_Event_Tab").style.top = (Position.cumulativeOffset($("event_tab"))[1]) + "px";
		$("div_Event_Tab").style.left = (Position.cumulativeOffset($("event_tab"))[0] - 30) + "px";
		//$("event_tab").src = "<%=ConfigManager.IMG_ENURI_COM%>/images/main_2008/topmenu/tab_shim.gif";
 	}else{
 		tid_Event = setTimeout("Cmd_2010_Close(2)", 300);
 	}
}

function Cmd_2010_Close(param) {
	if(param == 1){
		$("div_2010_Family").style.display = "none";
	}else if (param ==2){
		//$("event_tab").src = "<%=ConfigManager.IMG_ENURI_COM%>/images/main_2008/topmenu/tab_event_2.gif";
		$("div_Event_Tab").style.display = "none";
	}
}

function Cmd_Sitemap_All(){
	document.getElementById("frmAllMenu").src = "/etc/All_Menu.jsp?exlink=<%=bExLink%>";	
}
-->
</SCRIPT>
