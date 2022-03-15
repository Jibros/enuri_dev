<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@ page import="com.enuri.include.RandomMain"%>
<%@ page import="com.enuri.bean.log.Log_main_Proc"%>
<%@ page import="com.enuri.bean.log.Log_main_Data"%>
<%@ page import="com.enuri.bean.main.Bnr_List_Proc"%>
<%@ page import="com.enuri.bean.main.Bnr_List_Data"%>
<%@ page import="com.enuri.bean.main.GNB_List_Proc"%>
<%@ page import="com.enuri.bean.main.GNB_List_Data"%>
<jsp:useBean id="Bnr_List_Data" class="com.enuri.bean.main.Bnr_List_Data" scope="page" />
<jsp:useBean id="Bnr_List_Proc" class="com.enuri.bean.main.Bnr_List_Proc" scope="page" />
<jsp:useBean id="GNB_List_Data" class="com.enuri.bean.main.GNB_List_Data" scope="page" />
<jsp:useBean id="GNB_List_Proc" class="com.enuri.bean.main.GNB_List_Proc" scope="page" />
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
    String strID = cb.GetCookie("MEM_INFO", "USER_ID");

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
    int intRanSearch = RandomMain.getRandomValue(9)+1;
    String strRanSearchImage = "";
//  if (DateStr.getYMD(DateStr.nowStr(),"M").equals("09")){
//      intRanSearch = 0;
//  }
    if (intRanSearch == 0){
        strRanSearchImage = ConfigManager.IMG_ENURI_COM + "/2010/images/view/search_txt.gif";
    }else{
        strRanSearchImage = ConfigManager.IMG_ENURI_COM + "/images/event/banner/search_tx_event_"+intRanSearch+".gif";
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
    boolean etc2010 = false;
    if (request.getServletPath().trim().indexOf("/tour2012/") >= 0 || request.getServletPath().trim().indexOf("Insurance_Insvalley") >= 0 ||  request.getServletPath().trim().indexOf("Flower365") >= 0  || request.getServletPath().trim().indexOf("Tour_Tourjockey") >= 0 || request.getServletPath().trim().indexOf("move_mall") >= 0 || request.getServletPath().trim().indexOf("EventReviewAll") >= 0){
        etc2010 = true;
    }
    HttpSession sessionPrevCateMenuSet = request.getSession();
        String strFavoriteCate = cb.GetCookie("MYFAVORITEVIEW","MYFAVORITECATE");
        String[] astrFavoriteCate = strFavoriteCate.split(",");

        String[] strPrevCateName = { "", "", "", ""};
        String[] strLinkPageMid = { "", "", "" , ""};
        String[] strLinkPage = { "", "", "", ""};
        String strPrevCateList = "";
        int cateIdx = 0;
        if(strFavoriteCate.trim().length() > 0 && astrFavoriteCate !=  null && astrFavoriteCate.length > 0 ) {
            for(int i=0; i<astrFavoriteCate.length; i++) {

            if(CutStr.cutStr(astrFavoriteCate[i],4).equals("9301")) continue;

            if(astrFavoriteCate[i].trim().length() > 0) {
                if(strPrevCateList.indexOf(astrFavoriteCate[i])<0) {
                    if(astrFavoriteCate[i].trim().equals("211100")) {
                        strLinkPage[cateIdx] = "/car/Index.jsp";
                        strPrevCateName[cateIdx] = "<span style=\"font-family:'맑은 고딕';font-size:11px;line-height:15px;color:#5e5e5e;border-bottom:1px solid;cursor:pointer;\" onclick=insertLog(1470);top.location.href='"+strLinkPage[cateIdx]+"';>에누리 신차비교</span>";
                    } else if(astrFavoriteCate[i].trim().equals("910000")) {
                        strLinkPage[cateIdx] = "/tour2012/Tour_Index.jsp";
                        strPrevCateName[cateIdx] = "<span style=\"font-family:'맑은 고딕';font-size:11px;line-height:15px;color:#5e5e5e;border-bottom:1px solid;cursor:pointer;\" onclick=insertLog(1470);top.location.href='"+strLinkPage[cateIdx]+"';>에누리 여행상품 검색</span>";
                    } else {
                        strLinkPage[cateIdx] = "/view/List.jsp?cate="+astrFavoriteCate[i];
                        strLinkPageMid[cateIdx] = "/view/List.jsp?cate="+CutStr.cutStr(astrFavoriteCate[i],4);
                        strPrevCateName[cateIdx] = Category_Proc.Category_Name_DetailTitle_One(astrFavoriteCate[i]);
                        strPrevCateName[cateIdx] = ReplaceStr.replace(strPrevCateName[cateIdx]," > ",">");
                        strPrevCateName[cateIdx] = "<span style=\"font-family:'맑은 고딕';font-size:11px;line-height:15px;color:#5e5e5e;border-bottom:1px solid;cursor:pointer;\" onclick=insertLog(1470);top.location.href='"+strLinkPageMid[cateIdx]+"';>"+ReplaceStr.replace(strPrevCateName[cateIdx],">","</span> <span class='prevCateGap'> &gt; </span> <span style=\"font-family:'맑은 고딕';font-size:11px;line-height:15px;color:#5e5e5e;border-bottom:1px solid;cursor:pointer;\" onclick=insertLog(1470);top.location.href='"+strLinkPage[cateIdx]+"';>")+"</span>";
                        strPrevCateName[cateIdx] = "<span onclick=\"insertLog(10077);top.location.href='"+strLinkPageMid[cateIdx]+"'\" style=\"font-family:'맑은 고딕';font-size:11px;line-height:15px;color:#5e5e5e;cursor:pointer;\">"+ReplaceStr.replace(strPrevCateName[cateIdx]," > ","</span> <span style=\"font-family:'맑은 고딕';color:#000000;\"> &gt; </span> <span style=\"font-family:'맑은 고딕';font-size:11px;line-height:15px;color:#5e5e5e;cursor:pointer;\" onclick=\"insertLog(10077);top.location.href='"+strLinkPage[cateIdx]+"'\">")+"</span>";
                    }

                    if(strPrevCateName[cateIdx].indexOf("temp")<0 && strPrevCateName[cateIdx].indexOf("관리용")<0) {
                        strPrevCateList += "|"+astrFavoriteCate[i]+"|";
                        cateIdx++;
                    } else {
                         strLinkPage[cateIdx] = "";
                         strLinkPageMid[cateIdx] = "";
                         strPrevCateName[cateIdx] = "";
                    }
                }
            }
        }
    }
    int outPrintCnt = 0;

    for(int i=strPrevCateName.length-1; i>-1; i--) {
        if(strPrevCateName[i].length()>0) {
            if(outPrintCnt>0)

            outPrintCnt++;
        }
    }
    if(outPrintCnt<4) {
        for(int i=outPrintCnt; i<strPrevCateName.length; i++) {
            if(outPrintCnt>1)

            outPrintCnt++;
        }
    }

    String[] strPrevCateNameOut = { "", "", "", "" };

     for(int i=strPrevCateName.length-1; i>-1; i--) {
          if(strPrevCateName[i].length()>0) {
           strPrevCateNameOut[outPrintCnt] = strPrevCateName[i];
           outPrintCnt++;
          }
     }
     if (cateIdx == 0) {
                strPrevCateNameOut[1] = "<span style=\"font-family:'맑은 고딕';font-size:11px;color:#5e5e5e;\">최근 방문 목록이 없습니다.</span>";
     }
%>
<style type="text/css">
.cut_checkList {text-overflow:ellipsis;white-space:nowrap;word-wrap:normal;width:170px;}
</style>
<script language="javascript">
var varRanSearch = <%=intRanSearch%>;
</script>
<script type="text/javascript" src="<%=ConfigManager.ENURI_COMMON%>/common/js/autocom_search_2010.js"></script>
<script type="text/javascript" src="<%=ConfigManager.ENURI_COMMON%>/common/js/exception_keyword.js"></script>
<script src="/common/js/common_top.js"></script>
<jsp:include page="/join/join2009/IncJoin2009_2010.jsp" flush="true">
<jsp:param name="pagenm" value="<%=strPagenm%>"/>
</jsp:include>
<jsp:include page="/include/Inc_Common_LayerControl_2010.jsp" flush="true"></jsp:include>
<%/*도서 경고 레이어%>
<div id="booklayer" style="align:center; display:none;position:absolute;z-index:999;width:452px;height:189px; top:0px;left:0px;">
<img src="<%=ConfigManager.IMG_ENURI_COM %>/images/main/booklayer_121231.png" usemap="#booklayerMap">
<map name="booklayerMap" id="booklayerMap">
<area shape="rect" coords="387,16,401,30" href="JavaScript:booklayerClose();"/>
</map>
</div>
<%도서 경고 레이어*/%>
<%/*모바일 레이어*/%>
<div id="mobilelayer" style="display:none;position:absolute;z-index:999;width:380px;height:324px; top:0px;left:0px;">
<img src="<%=ConfigManager.IMG_ENURI_COM %>/images/main/m_app_down_0404.png" usemap="#mobilelayerMap">
<map name="mobilelayerMap" id="mobilelayerMap">
<area shape="rect" coords="340,9,371,37" href="JavaScript:mobilelayerClose();" onfocus="this.blur();"/>
</map>
</div>
<%/*고정위치 레이어들*/%>
<iframe width="911" height="100%" border="0" src="" id="frmAllMenu" name="frmAllMenu" allowTransparency="true" style="display:none;position:absolute;left:8px;top:15px;z-index:365;"  frameborder="0"   onload="syncWHAllMenu()"></iframe>
<%/*저장상품 레이어*/%>
<iframe width="885" height="580" border="0" src="" id="frmSaveGoods" name="frmSaveGoods" allowTransparency="true"  style="display:none;position:absolute;left:15px;top:15px;z-index:365;" scrolling="no" frameborder="0"   onload="syncWHSaveGoods()"></iframe>
<div id="nonbanking_site1" style="font-size:8pt;width:131px; height:211px; position:absolute;  top:45px; z-index:103; display:none; overflow:hide; " onMouseOver="showNonbanking_site();"  onmouseout="hideNonbanking_site();"></div>
<div id="m_menu_div" onMouseOver="clearTimeout(TimeHandler);" onMouseOut="CmdMenuCheck();" align="center" style="background-color:#f1f1f1;border:1px solid #151515;padding:0 0 0 0;margin:0 0 0 0;position:absolute;display:none;z-index:200;border-1:1px solid #7E7E7E;"></div>
<div id="topmenucolorDiv" style="position:absolute;overflow:hidden;display:none;background-color:#f1f1f1;width:1px;height:1px;z-index:202;display:none;"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/blank.gif" height="1" width="1"></div>
<div id="c_menu_div" onMouseOver="clearTimeout(TimeHandler);" onMouseOut="CmdMenuCheck();" style="border:1px solid #7c7c7c;background-color:#fafafa;position:absolute;display:none;z-index:201;"></div>
<div id="menucolorDiv" style="position:absolute;display:none;background-color:#fafafa;width:1px;height:19px;z-index:202;display:none;"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/blank.gif" height="1" width="1"></div>
<div id="LayerM_KBMenu" style="position:absolute;z-index:203;width:110px;display:none;"></div>
<div id="LayerS_KBMenu" style="position:absolute;z-index:204;width:140px;display:none;"></div>
<div id="menucolorKBDiv1" style="position:absolute;background-color:#FFFFFF;display:none;z-index:206;height:1px;overflow:hidden;"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/blank.gif" height="1" width="1"></div>
<div id="menucolorKBDiv2" style="position:absolute;background-color:#FFFFFF;display:none;z-index:206;"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/blank.gif" height="1" width="1"></div>
<div id="menuFashionImg" style="position:absolute;z-index:206;display:none;"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/main_2008/topmenu/top_info.gif" onmouseover="clearTimeout(TimeHandler);mDivOver();$('m_menu_div').style.display='inline';" onMouseOut="CmdMenuCheck();" usemap="#Map_FashionImg"></div>
<map name="Map_FashionImg" id="Map_FashionImg"><area shape="rect" coords="0,0,144,35" href="#" onclick="insertLog(3745);location.href='/fashion/clothes/Clothes_Index.jsp'" /></map>
<%/*기존 fieldset을 대신하는 감싸는 레이어 이 레어어 안에 있으면 스크롤안쪽에 있게된다.*/%>
<div id="wrap">
<div id="ac_layer" name="ac_layer" border=0 style='display:none;border:0;position:absolute;top:0;left:0;width:0;z-index:90;background-image:url(<%=ConfigManager.IMG_ENURI_COM%>/2012/search/shadow_01.png);background-position:left top;background-repeat:no-repeat;padding-left:4px;'>
<iframe id="ifr_ac" name="ifr_ac" src='/search/Autocom_MainSearch_2010.jsp'  frameborder=0 marginwidth=0 marginheight=0 topmargin=0 scrolling=no></iframe>
</div>
<%/*로그인레이어*/%>
<jsp:include page="/login/Inc_LoginTop_2010.jsp" flush="true"></jsp:include>
<%/*구글 레이어 */%>
<iframe name="ifrmMainSearch" id="ifrmMainSearch" frameborder="0" style="position:absolute;height:0;width:0;z-index:0;"></iframe>
<%/*탑메뉴 들어갈자리*/%>
<div id="header">
<%@ include file="/common/jsp/eb/header.jsp" %>
</div>
<div id="bodyFactoryTab" style="display:none;"></div>
<div id="bodyPriceTab" style="display:none;"></div>

<script language="JavaScript">
function goJoin(){
    if (location.pathname=="/view/SaveGoodsList_2010.jsp" || location.pathname=="/knowbox/List_read.jsp"){
        CmdJoin(1);
        hideLoginLayer();
    }else{
        if (location.pathname == "/event/EventFavorite.jsp"){
            insertLog(3391);
        }
        CmdJoin(1); //회원가입페이지 레이어 호출(join/join2009/IncJoin2009_2010.jsp)
        hideLoginLayer(); //로그인레이어 숨김
    }
}
<!--
var TimeHandler;    //setTimeout()의 리턴 핸들러

function CmdHideMenu() {
    try {
        onTopMenuonclickFlag = true;
        CmdMenuClose();

        <%if(menuType.equals("1")) {%>
        document.getElementById("tmenu_03").src = "<%=ConfigManager.IMG_ENURI_COM%>/images/topmenu/menu_2/main_03.gif";
        document.getElementById("tmenu_05").src = "<%=ConfigManager.IMG_ENURI_COM%>/images/topmenu/menu_2/main_05.gif";
        document.getElementById("tmenu_07").src = "<%=ConfigManager.IMG_ENURI_COM%>/images/topmenu/menu_2/main_07.gif";
        document.getElementById("tmenu_09").src = "<%=ConfigManager.IMG_ENURI_COM%>/images/topmenu/menu_2/main_09.gif";
        document.getElementById("tmenu_21").src = "<%=ConfigManager.IMG_ENURI_COM%>/images/topmenu/menu_2/main_21.gif";
        document.getElementById("tmenu_10").src = "<%=ConfigManager.IMG_ENURI_COM%>/images/topmenu/menu_2/main_10.gif";
        document.getElementById("tmenu_12").src = "<%=ConfigManager.IMG_ENURI_COM%>/images/topmenu/menu_2/main_12.gif";
        document.getElementById("tmenu_16").src = "<%=ConfigManager.IMG_ENURI_COM%>/images/topmenu/menu_2/main_16.gif";
        document.getElementById("tmenu_14").src = "<%=ConfigManager.IMG_ENURI_COM%>/images/topmenu/menu_2/main_14.gif";
        document.getElementById("tmenu_08").src = "<%=ConfigManager.IMG_ENURI_COM%>/images/topmenu/menu_2/main_08.gif";
        document.getElementById("tmenu_15").src = "<%=ConfigManager.IMG_ENURI_COM%>/images/topmenu/menu_2/main_15.gif";
        document.getElementById("all_menu").src = "<%=ConfigManager.IMG_ENURI_COM%>/images/topmenu/menu_2/all_menu.gif";
        <%} else {%>
        document.getElementById("tmenu_03").src = "<%=ConfigManager.IMG_ENURI_COM%>/images/topmenu/menu_2/main_03.gif";
        document.getElementById("tmenu_05").src = "<%=ConfigManager.IMG_ENURI_COM%>/images/topmenu/menu_2/main_05.gif";
        document.getElementById("tmenu_07").src = "<%=ConfigManager.IMG_ENURI_COM%>/images/topmenu/menu_2/main_07.gif";
        document.getElementById("tmenu_09").src = "<%=ConfigManager.IMG_ENURI_COM%>/images/topmenu/menu_2/main_09.gif";
        document.getElementById("tmenu_21").src = "<%=ConfigManager.IMG_ENURI_COM%>/images/topmenu/menu_2/main_21.gif";
        document.getElementById("tmenu_10").src = "<%=ConfigManager.IMG_ENURI_COM%>/images/topmenu/menu_2/main_10.gif";
        document.getElementById("tmenu_12").src = "<%=ConfigManager.IMG_ENURI_COM%>/images/topmenu/menu_2/main_12.gif";
        document.getElementById("tmenu_16").src = "<%=ConfigManager.IMG_ENURI_COM%>/images/topmenu/menu_2/main_16.gif";
        document.getElementById("tmenu_14").src = "<%=ConfigManager.IMG_ENURI_COM%>/images/topmenu/menu_2/main_14.gif";
        document.getElementById("tmenu_08").src = "<%=ConfigManager.IMG_ENURI_COM%>/images/topmenu/menu_2/main_08.gif";
        document.getElementById("tmenu_15").src = "<%=ConfigManager.IMG_ENURI_COM%>/images/topmenu/menu_2/main_15.gif";
        document.getElementById("all_menu").src = "<%=ConfigManager.IMG_ENURI_COM%>/images/topmenu/menu_2/all_menu.gif";
        <%}%>

    } catch(e) {
        window.status ="CmdHideMenu : " + e;
    }
    clearTimeout(TimeHandler);
}

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
//브라우져 버전 확인
var useragent = navigator.userAgent;
var appversion = navigator.appVersion;
var ieVer = getBrowserType();
function getBrowserType() {
    var trident = useragent.match(/Trident\/(\d.\d)/i);
    var rtnValue = "";

    if(useragent.toLowerCase().indexOf("safari")>-1) {
        rtnValue = "safari";
    }
    if(useragent.toLowerCase().indexOf("firefox")>-1) {
        rtnValue = "firefox";
    }
    if(useragent.toLowerCase().indexOf("chrome")>-1) {
        rtnValue = "chrome";
    }
    if(useragent.toLowerCase().indexOf("msie 7.0")>-1) {
        rtnValue = "ie7";
    }
    if(trident != null && trident[1] == "4.0") {
        if(useragent.toLowerCase().indexOf("msie 8.0")>-1) {
            rtnValue = "ie8";
        }
    }
    if(trident != null && trident[1] == "5.0") {
        rtnValue = "ie9";
    }
    if(trident != null && trident[1] == "6.0") {
        rtnValue = "ie10";
    }

    return rtnValue;
}
function Cmd_Event_Link(param){
    if(param == "1"){
        insertLog(6431);
        top.location.href = "/event/Resell.jsp";
    }else if(param == "3"){
        insertLog(6430);
        top.location.href = "/event/EventReviewAll.jsp?status=";
    }else if(param == "4"){
//      insertLog(5101);
//      top.location.href = "/event/EventGuide.jsp";
//      insertLog(5610);
        top.location.href = "/event/Event_Guide_Travel.jsp";
    }else if(param == "7"){
        //insertLog(8355);
        top.location.href = "/event/Tour_event.jsp";
    }else if(param == "8"){
        insertLog(8001);
        mobilelayerShow();
    }else if(param == "10"){ //여행
        top.location.href = "/tour2012/Tour_Index.jsp";
    }else if(param == "11"){ //도서
        OpenWindow_book('55','http://book.interpark.com/gate/ippgw.jsp?biz_cd=P13392&url=http://book.interpark.com/bookPark/html/book.html','sc.prdNo');
    }else if(param == "12"){ //보험비교
        top.location.href = "/view/Insurance_Insvalley.jsp?rtnurl=https://enuri.insvalley.com/join_site/layout/enuri/insu_main.jsp?h_targetPage=/goods/gallerylist.jsp||market_cd=D04||market_point_cd=PLA_20100825004&ac=SNU_B_2010082500003";
    }else if(param == "13"){ //소셜쇼핑
        insertLog(8174);
        top.location.href = "/view/Sslist_2013.jsp";
    }else if(param == "14"){ //골프이벤트
        insertLog(8208);
        top.location.href = "/event/EventGolf.jsp";
    }else if(param == "35"){ //툴바이벤트
        insertLog(8208);
        top.location.href = "/event/EventToolBar.jsp";
    }else if(param == "15"){ //이사견적
        top.location.href = "/view/move_mall.jsp";
    }else if(param == "39"){ //툴바스타벅스 이벤트
        top.location.href = "/event/EventToolBarGiftBalloon.jsp";
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

function Cmd_TopLayer_On(param_no, onoff){
    if(onoff == "on"){
        $("topLayer_"+param_no).src = "<%=ConfigManager.IMG_ENURI_COM%>/images/topmenu/"+param_no+"_ov.gif";
    }else if(onoff == "off"){
        $("topLayer_"+param_no).src = "<%=ConfigManager.IMG_ENURI_COM%>/images/topmenu/"+param_no+".gif";
    }
}
function Cmd_Tc_Tab(param){
    CmdKBHideMenu();
    Cmd_2010_Close(3);
    if(param == "1"){
        $("div_Tc_Tab").style.display = "inline";
        $("div_Tc_Tab").style.top =  "0px";
        $("div_Tc_Tab").style.left = (Position.cumulativeOffset($("tcImg"))[0] - 26) + "px";
    }else{
        Cmd_2010_Close(4);
    }
}

function Cmd_Event_Tab(param){
    CmdKBHideMenu();
    Cmd_2010_Close(3);
    if(param == "1"){
        $("div_Event_Tab").style.display = "inline";
        $("div_Event_Tab").style.top =  "0px";
        $("div_Event_Tab").style.left = (Position.cumulativeOffset($("event_tab"))[0] - 23) + "px";
    }else{
        Cmd_2010_Close(2);
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
        $("event_tab").src = "<%=ConfigManager.IMG_ENURI_COM%>/images/topmenu/open_r_130225.gif";
        $("div_Event_Tab").style.display = "none";
        $("div_Tc_Tab").style.display = "none";
    }else if (param ==3){
        $("div_Event_Tab").style.display = "none";
        $("div_Tc_Tab").style.display = "none";
        $("div_Car_Layer").style.display = "none";
    }else if (param ==4){
        $("div_Tc_Tab").style.display = "none";
    }
}

function Cmd_Sitemap_All(){
    //document.getElementById("frmAllMenu").src = "/etc/All_Menu_2010.jsp?lcate=03&exlink=false";
    //CmdKBHideMenu();
    if (top.document.body.scrollTop){
        top.document.body.scrollTop = "0px";
    }else{
        top.document.documentElement.scrollTop = "0px";
    }
    $("#gnb > ul > .allMenuBtn > a").trigger("focusin");
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
function mobilelayerClose() {
        $("mobilelayer").style.display = "none";
    }
function mobilelayerShow() {
        Cmd_Tc_Tab(2);
        var w = document.body.offsetWidth;
        var h = document.body.offsetHeight;
        if($("mobilelayer").style.display=="none") {
            $("mobilelayer").style.left = "620px";
            $("mobilelayer").style.top = "70px";
            $("mobilelayer").style.display = "";

        } else {
            mobilelayerClose();
        }
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
    function showLoginStatus() {
        if(islogin()) {
            try {
                if(document.getElementById("frmMainLogin") && document.getElementById("frmMainLogin").contentWindow.document.body.innerHTML.length<200) {
                    document.getElementById("frmMainLogin").src = "/login/Loginstatus_2010.jsp?main=Y&logintop_menu=top";
                }
            } catch(e) {}
            if(document.getElementById("list_login_btn")) document.getElementById("list_login_btn").style.display = "none";
            if(document.getElementById("loginDiv2")) document.getElementById("loginDiv2").style.display = "";
            if(document.getElementById("utilMenuLogin")) document.getElementById("utilMenuLogin").display = "none";
            if(document.getElementById("utilMenuLogout")) document.getElementById("utilMenuLogout").display = "";
        } else {
            if(document.getElementById("list_login_btn")) document.getElementById("#list_login_btn").style.display = "";
            if(document.getElementById("loginDiv2")) document.getElementById("loginDiv2").style.display = "none";
            if(document.getElementById("utilMenuLogin")) document.getElementById("utilMenuLogin").display = "";
            if(document.getElementById("utilMenuLogout")) document.getElementById("utilMenuLogout").display = "none";
        }
    }
    function goMyPage(url){
        parent.top.location.href=url;
    }

    function favoriteURL_NEW(param, param_text){
        if (window.sidebar){ // 파폭
            window.sidebar.addPanel(param_text, param, "");
        }else if (document.all){ // IE
            try{
                window.external.AddFavorite(param, param_text);
            }catch(e){
                alert("이 브라우저에서는 즐겨찾기를 추가 할수 없습니다.")
            }
        }else if (navigator.appName=="Netscape") { //크롬
            //alert("Please click OK, then press <Ctrl-D> to bookmark this page.");
            alert("확인을 누르시고 <Ctrl-D>를 사용하여 이 페이지를 즐겨찾기 하세요.");
        }
        //if(document.getElementById("incFavoriteLayer")) document.getElementById("incFavoriteLayer").style.display = "none";
        //if(document.getElementById("div_favorite")) document.getElementById("div_favorite").style.display = "none";
    }

    function fav_check() {
        if(document.getElementById("ifBodyRead")) {
            document.getElementById('ifBodyRead').contentWindow.CmdGetInfo(0);
        }
        if(document.getElementById("enuriMenuFrame")) {
            document.getElementById('enuriMenuFrame').contentWindow.makeFavorite();
        }
        if(document.getElementById("tx_favorite_1203")) {
            makeFavorite(tx_favorite_1203);
        }
        if(document.getElementById("tx_favorite_1203_2")) {
            makeFavorite(tx_favorite_1203_2);
        }
        if(document.getElementById("menu_openprd_1203")) {
            favoriteURL_NEW('http://www.enuri.com/event/EventReviewAll.jsp', '에누리(체험단)');
        }
        if (document.getElementById("searchListFrame")){
            fireEvent(document.getElementById("search_makefav"),"click")
        }
    }

    function showConvTopMenu() {
        if (document.getElementById("div_inconv").style.display == "") {
            document.getElementById("div_inconv").style.display = "none";
            //document.getElementById("inconv_txt").value = "";
            //document.getElementById("inconv_email").value = "";
        } else {
            //document.getElementById("inconv_txt").style.backgroundImage = "url(http://img.enuri.gscdn.com/images/view/error/error_webFont01.gif)";
            //document.getElementById("inconv_email").style.backgroundImage = "url(http://img.enuri.gscdn.com/images/view/error/error_webFont02.gif)";
            var mainRightDivObj = $("#mainRightDiv");
            var topPos =  145;
            document.getElementById("div_inconv").style.top = topPos + "px";
            if(document.getElementById("tx_favorite_1203")) {
                document.getElementById("div_inconv").style.left = "192px";
            }else if(document.getElementById("menu_openprd_1203")) {
                 document.getElementById("div_inconv").style.left = "192px";
             }else if(document.getElementById("tx_favorite_1203_2")) {
                 document.getElementById("div_inconv").style.left = "315px";
            }else{
                document.getElementById("div_inconv").style.left = "340px";
            }
            document.getElementById("div_inconv").style.display = "";
            insertLog(2067);

        }
    }
    function loginLayerMouseOut() {
        if(document.getElementById("nonbanking_site1")) {
            if(document.getElementById('nonbanking_site1').style.display!='none') {
    //          document.getElementById('nonbanking_site1').style.display = 'none';
            }
        }
    }
    function loginLayerMouseOut_2() {
        if(document.getElementById("nonbanking_site1")) {
            if(document.getElementById('nonbanking_site1').style.display!='none') {
    //          document.getElementById('nonbanking_site1').style.display = 'none';
            }
        }
    }

    function checkBackground(obj){
        if (obj.value.trim().length == 0 ){
            if (obj.id == "inconv_txt"){
                obj.style.backgroundImage = "url(http://img.enuri.gscdn.com/images/view/error/error_webFont01.gif)";
            }else{
                obj.style.backgroundImage = "url(http://img.enuri.gscdn.com/images/view/error/error_webFont02.gif)";
            }
        }
    }

    function More_layerClose() {
            <%if ((request.getRequestURI().indexOf("Flower365.jsp") >= 0) || (request.getRequestURI().indexOf("move_mall.jsp") >= 0 )|| (request.getRequestURI().indexOf("Insurance_Insvalley.jsp") >= 0) ){%>
              document.getElementById("More_layer_3").style.display = "none";
              //document.getElementById("tx_more").src = "<%=ConfigManager.IMG_ENURI_COM%>/images/topmenu/tx_more.gif";
            <%}else{%>
             document.getElementById("More_layer_2").style.display = "none";
             //document.getElementById("tx_more").src = "<%=ConfigManager.IMG_ENURI_COM%>/images/topmenu/tx_more.gif";
            <%}%>
    }

    function More_btnon() {
        //document.getElementById("tx_more").src = "<%=ConfigManager.IMG_ENURI_COM%>/images/topmenu/tx_more_on.gif";
    }

    function More_btnout() {
      if((document.getElementById("More_layer_3").style.display=="none") && (document.getElementById("More_layer_2").style.display=="none")) {
        //document.getElementById("tx_more").src = "<%=ConfigManager.IMG_ENURI_COM%>/images/topmenu/tx_more.gif";
      }else{
        //document.getElementById("tx_more").src = "<%=ConfigManager.IMG_ENURI_COM%>/images/topmenu/tx_more_on.gif";
      }
    }

    function More_layerShow() {
    	alert("11111111");
        var w = document.body.offsetWidth;
        alert("22222");
        var h = document.body.offsetHeight;

        //CmdHideMenu();
        var eObj = event.srcElement || event.target;
        <%if ((request.getRequestURI().indexOf("Flower365.jsp") >= 0) || (request.getRequestURI().indexOf("move_mall.jsp") >= 0 )|| (request.getRequestURI().indexOf("Insurance_Insvalley.jsp") >= 0) ){%>
        alert("22222222");
            if(document.getElementById("More_layer_3").style.display=="none") {
                //document.getElementById("tx_more").src = "<%=ConfigManager.IMG_ENURI_COM%>/images/topmenu/tx_more_on.gif";
                document.getElementById("More_layer_3").style.left =  $(eObj).offset().left-260 + "px";
                document.getElementById("More_layer_3").style.top = 25+"px";
                document.getElementById("More_layer_3").style.display = "";
             }else{
                document.getElementById("More_layer_3").style.display ="none";
                //document.getElementById("tx_more").src = "<%=ConfigManager.IMG_ENURI_COM%>/images/topmenu/tx_more.gif";
            }
       <% }else if ((request.getRequestURI().indexOf("Index.jsp") >= 0 || request.getRequestURI().indexOf("PlanTravel.jsp") >= 0)){%>
       		alert("333333");
           if(document.getElementById("More_layer_2").style.display=="none") {
               //document.getElementById("tx_more").src = "<%=ConfigManager.IMG_ENURI_COM%>/images/topmenu/tx_more_on.gif";
               document.getElementById("More_layer_2").style.left = jQuery(eObj).offset().left - 248 - (document.getElementById("main_body") ? document.getElementById("main_body").offsetLeft : 0) + "px";
               document.getElementById("More_layer_2").style.top = 25+"px";
               document.getElementById("More_layer_2").style.display = "";
            }else{
               document.getElementById("More_layer_2").style.display ="none";
               //document.getElementById("tx_more").src = "<%=ConfigManager.IMG_ENURI_COM%>/images/topmenu/tx_more.gif";
           }
       <% }else if ((request.getRequestURI().indexOf("Tour_Index.jsp") >= 0 )){%>
       		alert("44444");
           if(document.getElementById("More_layer_2").style.display=="none") {
               //document.getElementById("tx_more").src = "<%=ConfigManager.IMG_ENURI_COM%>/images/topmenu/tx_more_on.gif";
               document.getElementById("More_layer_2").style.left = JQuery(eObj).offset().left - 248 - (document.getElementById("main_body") ? document.getElementById("main_body").offsetLeft : 0) + "px";
               document.getElementById("More_layer_2").style.top = 25+"px";
               document.getElementById("More_layer_2").style.display = "";
            }else{
               document.getElementById("More_layer_2").style.display ="none";
               //document.getElementById("tx_more").src = "<%=ConfigManager.IMG_ENURI_COM%>/images/topmenu/tx_more.gif";
           }
       <%}else{%>
       	alert("55555");
            if(document.getElementById("More_layer_2").style.display=="none") {
                //document.getElementById("tx_more").src = "<%=ConfigManager.IMG_ENURI_COM%>/images/topmenu/tx_more_on.gif";
                document.getElementById("More_layer_2").style.left = $(eObj).offset().left-260 + "px";
                document.getElementById("More_layer_2").style.top = 25+"px";
                document.getElementById("More_layer_2").style.display = "";
             }else{
                document.getElementById("More_layer_2").style.display ="none";
                //document.getElementById("tx_more").src = "<%=ConfigManager.IMG_ENURI_COM%>/images/topmenu/tx_more.gif";
            }
        <%}%>
    }

    function app_dn_layerShow() {
            if (document.getElementById("app_dn_layer").style.display == "" || document.getElementById("app_dn_layer_car").style.display=="") {
                document.getElementById("app_dn_layer").style.display = "none";
                app_dn_layer_carClose();
            } else {
                var w = document.body.offsetWidth;
                var h = document.body.offsetHeight;
                if(document.getElementById("app_dn_layer").style.display=="none") {
                 //var target = e.target || e.srcElement;
                 document.getElementById("app_dn_layer").style.left =  $(caller).position().left-610 + "px";
                 var topPos =  145;
                <%if ((request.getRequestURI().indexOf("Flower365.jsp") >= 0) || (request.getRequestURI().indexOf("move_mall.jsp") >= 0 )|| (request.getRequestURI().indexOf("Insurance_Insvalley.jsp") >= 0) ){%>
                 document.getElementById("app_dn_layer").style.top = topPos + "px";
                 <%}else{%>
                 document.getElementById("app_dn_layer").style.top = topPos + "px";
                <%}%>
                  document.getElementById("app_dn_layer").style.display = "";
                }
           }
        }

    function app_dn_layerShow1205() {
            if(document.getElementById("app_dn_layer_car").style.display=="") {
                app_dn_layer_carClose();
            }
            var w = document.body.offsetWidth;
            var h = document.body.offsetHeight;
            if(document.getElementById("app_dn_layer").style.display=="none") {
             document.getElementById("app_dn_layer").style.left = $(event.srcElement).offset().left-610 + "px";
             var topPos =  145;
            <%if ((request.getRequestURI().indexOf("Flower365.jsp") >= 0) || (request.getRequestURI().indexOf("move_mall.jsp") >= 0 )|| (request.getRequestURI().indexOf("Insurance_Insvalley.jsp") >= 0) ){%>
             document.getElementById("app_dn_layer").style.top = topPos + "px";
             <%}else{%>
             document.getElementById("app_dn_layer").style.top = topPos + "px";
            <%}%>
              document.getElementById("app_dn_layer").style.display = "";
            }
        }

    function app_dn_layerClose() {
            document.getElementById("app_dn_layer").style.display = "none";
    }

    function app_dn_layer_carShow() {
            if(document.getElementById("app_dn_layer").style.display=="") {
                app_dn_layerClose();
            }
            var w = document.body.offsetWidth;
            var h = document.body.offsetHeight;
            var topPos =  145;
            if(document.getElementById("app_dn_layer_car").style.display=="none") {
             document.getElementById("app_dn_layer_car").style.left = $(event.srcElement).offset().left-610 + "px";
            <%if ((request.getRequestURI().indexOf("Flower365.jsp") >= 0) || (request.getRequestURI().indexOf("move_mall.jsp") >= 0 )|| (request.getRequestURI().indexOf("Insurance_Insvalley.jsp") >= 0) ){%>
             document.getElementById("app_dn_layer_car").style.top = topPos + "px";
            <%}else{%>
             document.getElementById("app_dn_layer_car").style.top = topPos + "px";
            <%}%>
            document.getElementById("app_dn_layer_car").style.display = "";
            }
        }
    function app_dn_layer_carClose() {
            document.getElementById("app_dn_layer_car").style.display = "none";
    }
    // 최근본, 찜상품 전체보기
function showMyAllList(type) {
/*
    if (top.document.body.scrollTop){
        top.document.body.scrollTop = "0";
    }else{
        top.document.documentElement.scrollTop = "0";
    }
*/
    if(type=="today") {
        insertLog(2668);
        //top.document.getElementById("frmSaveGoods").src = "/view/SaveGoodsList_2010.jsp";
        resentZzimOpen(1);
    }
    if(type=="save") {
        insertLog(2668);
        //top.document.getElementById("frmSaveGoods").src = "/view/SaveGoodsList_2010.jsp?tbln=save";
        resentZzimOpen(2);
    }
}
    if (document.URL.indexOf("/search/Searchlist.jsp") < 0 && document.getElementById("keyword")){
        document.getElementById("keyword").value = "";
    }
-->
</SCRIPT>
    <div id="div_inconv" style="display:none;"></div>
    <!--더보기2-->
    <div id="More_layer_2"  style="position:absolute;display:none;z-index:50;">
        <div class="cut_checkList" style="overflow:hidden;height:16px;width:180px;position:absolute;margin: 130px 120px 120px 110px;"><%=strPrevCateNameOut[0]%></div>
        <div class="cut_checkList" style="overflow:hidden;height:16px;width:180px;position:absolute;margin: 150px 120px 120px 110px;"><%=strPrevCateNameOut[1]%></div>
        <div class="cut_checkList" style="overflow:hidden;height:16px;width:180px;position:absolute;margin: 170px 120px 120px 110px;"><%=strPrevCateNameOut[2]%></div>
        <img src="<%=ConfigManager.IMG_ENURI_COM %>/images/main/layer_more_B.png" width="302" height="203" border="0" usemap="#More_layer_2" />
        <map name="More_layer_2" id="More_layer_2">
        <area shape="rect" coords="15,45,86,59" onfocus="this.blur();" href="/event/Resell.jsp" onclick="insertLog(10335);" />
        <area shape="rect" coords="15,62,49,76" onfocus="this.blur();" href="/event/EventReviewAll.jsp?status=" onclick="insertLog(10339);" />
        <area shape="rect" coords="15,78,49,94" onfocus="this.blur();" href="/view/Flower365.jsp" />
        <area shape="rect" coords="204,43,290,60" onfocus="this.blur();" href="/view/Insurance_Insvalley.jsp" />
        <area shape="rect" coords="111,62,157,76" onfocus="this.blur();" href="/view/move_mall.jsp" />
        <area shape="rect" coords="204,61,289,78" onfocus="this.blur();" href="/view/Listbrand.jsp?cate=2112" />
        <area shape="rect" coords="112,45,157,59" onfocus="this.blur();" href="/view/Insurance_Insvalley.jsp?rtnurl=https://enuri.insvalley.com/join_site/layout/enuri/insu_main.jsp?h_targetPage=/goods/gallerylist.jsp||market_cd=D04||market_point_cd=PLA_20100825004&ac=SNU_B_2010082500003" />
        <area shape="rect" coords="14,112,58,126" onfocus="this.blur();"  href="JavaScript:fav_check();insertLog(10073);" />
        <area shape="rect" coords="13,129,74,143" onfocus="this.blur();"  href="JavaScript:app_dn_layerShow();insertLog(10074);" />
        <area shape="rect" coords="15,146,60,160" onfocus="this.blur();"   href="JavaScript:notice(5);insertLog(10075); " />
        <area shape="rect" coords="217,113,280,129" onfocus="this.blur();" href="JavaScript:showMyAllList('today');insertLog(10076);" />
        <area shape="rect" coords="277,12,291,26" onfocus="this.blur();"  href="JavaScript:More_layerClose();" />
        </map>
    </div>
    <!--더보기2끝-->
    <!--더보기3-->
    <div id="More_layer_3"  style="position:absolute;display:none;z-index:50;">
        <img src="<%=ConfigManager.IMG_ENURI_COM %>/images/main/layer_more_S.png" width="302" height="125" border="0" usemap="#More_layer_3" />
        <map name="More_layer_3" id="More_layer_3">
            <area shape="rect" coords="272,8,295,30" onfocus="this.blur();" href="#" onclick="More_layerClose();return false;" />
            <area shape="rect" coords="15,45,86,59" onfocus="this.blur();" href="/event/Resell.jsp"  onclick="insertLog(10335);" />
            <area shape="rect" coords="15,62,50,77" onfocus="this.blur();" href="/event/EventReviewAll.jsp?status=" onclick="insertLog(10339);" />
            <area shape="rect" coords="121,79,157,93" onfocus="this.blur();" href="/view/Flower365.jsp" />
            <area shape="rect" coords="206,44,288,59" onfocus="this.blur();" href="/view/Insurance_Insvalley.jsp" />
            <area shape="rect" coords="121,62,169,77" onfocus="this.blur();" href="/view/move_mall.jsp" />
            <area shape="rect" coords="205,62,288,77" onfocus="this.blur();" href="/view/Listbrand.jsp?cate=2112" />
            <area shape="rect" coords="122,44,169,59" onfocus="this.blur();" href="/view/Insurance_Insvalley.jsp?rtnurl=https://enuri.insvalley.com/join_site/layout/enuri/insu_main.jsp?h_targetPage=/goods/gallerylist.jsp||market_cd=D04||market_point_cd=PLA_20100825004&ac=SNU_B_2010082500003" />
            <area shape="rect" coords="14,79,76,93" onfocus="this.blur();"  href="JavaScript:app_dn_layerShow();insertLog(10074);" />
            <area shape="rect" coords="228,98,291,114" onfocus="this.blur();" href="JavaScript:showMyAllList('today');insertLog(10076);" />
            <area shape="rect" coords="277,11,292,26" onfocus="this.blur();"  href="JavaScript:More_layerClose();" />
            </map>
    </div>
    <!--더보기3끝-->
    <!--앱다운로드 가격비교-->
    <div id="app_dn_layer" style="display:none;position:absolute;z-index:50;width:330px;top:235px;left:230px;">
        <table width="330" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td height="208" align="center" valign="bottom"><img src="<%=ConfigManager.IMG_ENURI_COM %>/images/main/app_dn_layer.png" width="330" height="208" border="0" usemap="#app_dn_layer" /></td>
          </tr>
        </table>
        <map name="app_dn_layer" id="app_dn_layer">
        <area shape="rect" coords="22,42,99,62" onfocus="this.blur();" href="JavaScript:app_dn_layerShow1205();" />
        <area shape="rect" coords="99,42,176,62" onfocus="this.blur();" href="JavaScript:app_dn_layer_carShow();" />
        <area shape="rect" coords="300,17,312,30" onfocus="this.blur();" href="JavaScript:app_dn_layerClose();" />
        </map>
    </div>
    <!--앱다운로드 가격비교끝-->
    <!--앱다운로드 신차-->
    <div id="app_dn_layer_car" style="display:none;position:absolute;z-index:50;width:330px;top:235px;left:230px;">
        <table width="330" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td height="208" align="center" valign="bottom"><img src="<%=ConfigManager.IMG_ENURI_COM %>/images/main/app_dn_layer_car.png" width="330" height="208" border="0" usemap="#app_dn_layer_car" /></td>
          </tr>
        </table>
        <map name="app_dn_layer_car" id="app_dn_layer_car">
        <area shape="rect" coords="22,42,99,62" onfocus="this.blur();" href="JavaScript:app_dn_layerShow1205();" />
        <area shape="rect" coords="99,42,176,62" onfocus="this.blur();" href="JavaScript:app_dn_layer_carShow();" />
        <area shape="rect" coords="300,17,312,30" onfocus="this.blur();" href="JavaScript:app_dn_layer_carClose();" />
        </map>
    </div>
    <!--앱다운로드 신차끝-->
<%
    /*로딩 이미지*/

    if (request.getRequestURI().equals("/view/Listmp3.jsp") || request.getRequestURI().equals("/fashion/brand/Clothes_Brand_List.jsp") || request.getRequestURI().equals("/fashion/clothes/Clothes_StyleList.jsp")
    || request.getRequestURI().equals("/view/fusion/Fusion.jsp") || request.getRequestURI().equals("/view/fusion/Fusion_Masterpiece.jsp")

    ){
        boolean bFashionList = false;
        int intLoadingTop = 400;
        if (request.getRequestURI().equals("/fashion/brand/Clothes_Brand_List.jsp") || request.getRequestURI().equals("/fashion/clothes/Clothes_StyleList.jsp") || request.getRequestURI().equals("/view/fusion/Fusion.jsp")
        || request.getRequestURI().equals("/view/fusion/Fusion_Masterpiece.jsp")
        ){
            bFashionList = true;
            intLoadingTop = 175;
        }
%>
    <div id="loadingListBg" style="z-index:100;position:absolute;top:<%=intLoadingTop%>px;left:0px;display:none;background-image:url(<%=ConfigManager.IMG_ENURI_COM%>/2012/list/loading/bg_pattern.gif);width:100%;height:1560px;"><!--  --></div>
<%
    }
    /*사이트 느려질때 true*/
    if(false){
%>
<div id="loading" style="z-index:999;position:absolute;display:none;background-color:#e6e7e7;">
    <img id="loading_img" src="<%=ConfigManager.IMG_ENURI_COM%>/2012/search/loading_list_1126.gif" border="0" style="position:absolute" usemap="#loadingMap">
</div>
<map name="loadingMap" id="loadingMap">
<area shape="rect" coords="412,132,461,148" href="#" onclick="insertLog(7776);document.location.reload();"/>
<area shape="rect" coords="498,132,579,148"  href="#" onclick="insertLog(8456);history.back();" />
</map>
<%
    }else{
%>
<div id="loading" style="z-index:199;position:absolute;display:none;width:215px;height:90px;">
    <div style="width:70px;height:25px;margin:auto;font-family:'맑은 고딕','돋움';font-size: 21px;color:#212121;font-weight:bold;">로딩중</div>
    <div style="width:194px;height:20px;margin:20px auto 10px auto;"><img id="loading_img" src="<%=ConfigManager.IMG_ENURI_COM%>/2012/list/loading/loading_bar.gif" border="0" ></div>
    <div style="width:200px;height:25px;margin:auto;font-family:'맑은 고딕','돋움';font-size: 11px;color:#464646;">
        <span style="text-decoration:underline;margin-left:15px;cursor:pointer;" onclick="insertLog(7776);document.location.reload();return false;">다시시도</span>
        <span style="text-decoration:underline;margin-left:50px;cursor:pointer;" onclick="insertLog(8456);history.back();return false;">중지(이전화면)</span>
    </div>
</div>
<img src="<%=ConfigManager.IMG_ENURI_COM%>/2012/list/loading/loading_jejo_1.gif" border="0" id="img_spec_search_loading"  style="z-index:149;position:absolute;left:300px;top:230px;display:none;">
<%
    }
%>