<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@page import="org.json.*"%>
<%@ page import="com.enuri.include.RandomMain" %>
<%@ page import="com.enuri.bean.log.Log_main_Proc"%>
<%@ page import="com.enuri.bean.log.Log_main_Data"%>
<%@ page import="com.enuri.bean.main.GNB_List_Proc"%>
<%@ page import="com.enuri.bean.main.GNB_List_Data"%>
<%@ page import="com.enuri.bean.main.Main_Cm_Plan_Proc"%>
<%@page import="com.enuri.util.http.CookieBean"%>
<%@page import="com.enuri.bean.lsv2016.Msgoods_Sale_Log_Proc"%>
<%@page import="com.enuri.bean.main.Save_Goods_Proc"%>
<%@page import="com.enuri.bean.main.Sdul_Goods_Proc"%>
<%@page import="com.enuri.bean.main.Sdul_Member_Data"%>
<%@page import="com.enuri.bean.main.Sdul_Member_Proc"%>
<jsp:useBean id="GNB_List_Data" class="com.enuri.bean.main.GNB_List_Data" scope="page" />
<jsp:useBean id="GNB_List_Proc" class="com.enuri.bean.main.GNB_List_Proc" scope="page" />
<jsp:useBean id="RandomMain" class="com.enuri.include.RandomMain" scope="page" />
<%
//2016.6.13 toodoo
//개편용 gnb헤더
    String userAgentStr = "";

    if (request.getHeader("User-Agent") != null){
        userAgentStr = request.getHeader("User-Agent");
    }

    String menuType  = ConfigManager.RequestStr(request, "menuType", "5");
    String strPagenm = ConfigManager.RequestStr(request, "strPagenm", "");

    // 여행 페이지에서 LogoLayerImg 겹치는것을 방지하기위한 변수
    String strID = cb.GetCookie("MEM_INFO", "USER_ID");

    String strLogoLayerImg = ConfigManager.RequestStr(request, "strLogoLayerImg", "T");

    if(menuType.equals("6"))
        strPagenm = "knowbox";

    boolean IsLogin = false;

    if(cb.GetCookie("MEM_INFO","USER_ID").trim().length()> 0)
        IsLogin = true;

    /*즐겨찾기 이벤트 및 바탕화면 바로가기 이벤트를 위한 세션 처리*/
    String strEventRefererCheck = ChkNull.chkStr(request.getHeader("REFERER"),"");
    String strCate              = ChkNull.chkStr(request.getParameter("cate"),"");

    boolean bMain = true;

    if (!request.getServletPath().trim().equals("/Index.jsp") && !request.getServletPath().trim().equals("/search/Searchlist.jsp") && !request.getServletPath().trim().equals("/search/WebSearchlist.jsp") && !request.getServletPath().trim().equals("/search.jsp")){
        bMain = false;
    }

    boolean bExLink = false;

    String strExLink = "";

    if (request.getRequestURI().indexOf("Smilecat.jsp") >= 0 || request.getRequestURI().indexOf("Paxinsu.jsp") >= 0 || request.getRequestURI().indexOf("Flower_Easyflower.jsp") >= 0){
        bExLink = true;
        strExLink = "?exlink=Y";
    }

    int intRanSearch = RandomMain.getRandomValue(6)+1;
    String strRanSearchImage = "";

    if (intRanSearch == 0){
        strRanSearchImage = ConfigManager.IMG_ENURI_COM + "/2010/images/view/search_txt.gif";
    }else{
        strRanSearchImage = ConfigManager.IMG_ENURI_COM + "/images/event/banner/search_tx_0522_"+intRanSearch+".gif";
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

    HttpSession sessionPrevCateMenuSet = request.getSession();

    String strFavoriteCate = cb.GetCookie("MYFAVORITEVIEW","MYFAVORITECATE");

    String[] astrFavoriteCate   = strFavoriteCate.split(",");
    String[] strPrevCateName    = { "", "", "", "" };
    String[] strLinkPageMid     = { "", "", "", "" };
    String[] strLinkPage        = { "", "", "", "" };
    String strPrevCateList      = "";

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
                        strLinkPage[cateIdx] = "/list.jsp?cate="+astrFavoriteCate[i];
                        strLinkPageMid[cateIdx] = "/list.jsp?cate="+CutStr.cutStr(astrFavoriteCate[i],4);
                        strPrevCateName[cateIdx] = Category_Proc.Category_Name_DetailTitle_One(astrFavoriteCate[i]);
                        strPrevCateName[cateIdx] = ReplaceStr.replace(strPrevCateName[cateIdx]," > ",">");
                        strPrevCateName[cateIdx] = "<span style=\"font-family:'맑은 고딕';font-size:11px;line-height:15px;color:#5e5e5e;border-bottom:1px solid;cursor:pointer;\" onclick=insertLog(1470);top.location.href='"+strLinkPageMid[cateIdx]+"';>"+ReplaceStr.replace(strPrevCateName[cateIdx],">","</span> <span class='prevCateGap'> &gt; </span> <span style=\"font-family:'맑은 고딕';font-size:11px;line-height:15px;color:#5e5e5e;border-bottom:1px solid;cursor:pointer;\" onclick=insertLog(1470);top.location.href='"+strLinkPage[cateIdx]+"';>")+"</span>";
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

    boolean bIsMain = false;

    if(request.getServletPath().indexOf("Index.jsp") >= 0 ){
        bIsMain = true;
    }

    int intAutoComWidth = 293;
    String strSearchBtn = ConfigManager.IMG_ENURI_COM + "/2014/layout/btn_search.gif";
    int intBgTopPos = -2;

    strSearchBtn = ConfigManager.IMG_ENURI_COM + "/2014/main/images/btn_search.gif";
   	//cpc 광고 영역 추가로 인한 width 변경
	//intAutoComWidth = 361;
    intAutoComWidth = 454;
    //intBgTopPos = 9;
    intBgTopPos = 6;

	/* Main_Cm_Plan_Proc cmplan_proc = new Main_Cm_Plan_Proc();
	JSONObject jSONObject = new JSONObject();
	JSONObject jSONObject2 = new JSONObject();
	jSONObject = cmplan_proc.getMainCMPlanCnt();
	jSONObject2 = cmplan_proc.getMainCMPlanData();
	int num = Integer.parseInt(jSONObject.get("cnt").toString()); */

    int intRanSearch2 = RandomMain.getRandomValue(6)+1;
   // int intRanSearch3 = RandomMain.getRandomValue(20)+1;
    //int intRanSearch3 = RandomMain.getRandomValue(num)+1;

    strRanSearchImage = ConfigManager.IMG_ENURI_COM + "/images/event/banner/search_tx_20150605_"+intRanSearch2+".gif";

    if (request.getRequestURI().indexOf("Smilecat.jsp") >= 0 || request.getRequestURI().indexOf("Paxinsu.jsp") >= 0 || request.getRequestURI().indexOf("Flower_Easyflower.jsp") >= 0){
        bExLink = true;
        strExLink = "?exlink=Y";
    }

    String strPageNm = ChkNull.chkStr(request.getParameter("pagenm"));      //페이지구분

    if (request.getRequestURI().indexOf("Index.jsp") >= 0){
        strPageNm = "main";
    }

    boolean onevent = false;

    if(com.enuri.util.date.DateStr.nowStr("yyyy.MM.dd. HH:mm").compareTo("2015.08.06. 00:00")>=0 && com.enuri.util.date.DateStr.nowStr("yyyy.MM.dd. HH:mm").compareTo("2015.09.02. 00:00")<0){
        onevent = true;
    }
%>
<%@ include file="/common/jsp/getTopBanner.jsp" %>
<style type="text/css">
	.cut_checkList {text-overflow:ellipsis;white-space:nowrap;word-wrap:normal;width:170px;}
	div.nowrap {white-space:nowrap;margin:0;padding:0;position:relative;overflow:hidden;}
	#adbox{margin:0px;height:75px;text-align:right;}
	bannerList div {display:none;}
	.divCheckViewArea {
	    position: relative;
	    top: -20px;
	    left: 1000px;
	    width: 1000px;
	    color: #ffffff;
	    margin: 0 auto;
	    z-index:1;
	}

	.downbnr{position:absolute; left:0; top:0; width:100%; height:410px; background: url(http://imgenuri.enuri.gscdn.com/images/main/home_top_bg_160704.png) repeat-x; z-index:99997; display:none; }
	.bnrtxt{width:1000px; margin:0 auto; height:410px; position:relative; }
	.bnrtxt a{display:block; height:440px}
	.btclose{position:absolute; left:470px; bottom:-20px; width:80px; height:80px; cursor:pointer; background: url(http://imgenuri.enuri.gscdn.com/images/main/btnClose_160517.png) 0 0; text-indent:-9999em}
	.btn_benefit{position:absolute; right:35px; top:20px; width:140px; height:30px; text-indent:-9999em;}
	.s_more.col_4 {width:453px; height:197px; background: url(http://imgenuri.enuri.gscdn.com/images/main/tit_service2.gif) 13px 19px no-repeat #ffffff;}
	.s_more .all_view{width:440px;}
	.s_more .service_list li {width: 98px;line-height: 21px !important;padding: 1px 10px 0px;}
</style>
<!-- <div id="nonbanking_site1" style="font-size:8pt;width:131px; height:211px; position:absolute;  top:45px; z-index:10003; display:none; overflow:hide; " onMouseOver="showNonbanking_site();" onmouseout="hideNonbanking_site();"></div> -->
<%-- <%@ include file="/login/Inc_Login_MyMenu.jsp" --%>
<div id="wrap">
    <jsp:include page="/login/Inc_LoginTop_2015.jsp" flush="true"></jsp:include><!-- 로그인레이어 -->
    <iframe name="ifrmMainSearch" id="ifrmMainSearch" frameborder="0" style="position:absolute;height:0;width:0;z-index:0;"></iframe><!-- 구글 레이어 -->

    <div id="header" datavalue="2015">
 <!-- [PC] 탑배너 > 홈메인에서만 노출되도록 처리 2017-06-23 지원 #23098 -->
<%
	if(request.getServletPath().trim().equals("/Index.jsp") || request.getServletPath().trim().equals("/Index_lazyload.jsp") ){
%>
 <!-- 탑배너 미노출 2016-10-25 지원 #18707 -->
 		            <div id='topBannerNew' class="top_banner" style="display:block;">
		                 <a class="banner_inner" href="javascript://">
		                     <button class="btn_close" id="top_banner_closer">닫기</button>
		                </a>
<!--                <div class="divCheckViewArea">
                	<dl>
                		<dt style="float:left;padding-right:5px;"><input type="checkbox" id="cbNoMoreViewTopBanner"></dt>
                		<dd><label for="cbNoMoreViewTopBanner">오늘 하루 이 배너를 보지 않습니다</label></dd>
                	</dl>
                	</div> -->
	             </div>
<%
	}
%>
			<!-- <div class="downbnr">
	            <div class="bnrtxt">
	                <a href="/eventPlanZone/jsp/shoppingBenefit.jsp" target="_blank">
	                    <img src="http://imgenuri.enuri.gscdn.com/images/main/home_top_b160704.png" alt="쓰지 못하는 혜택은 NO! 500가지 생활혜택을 자유롭게! 내맘대로 생활혜택!" />
	                </a>
	                <span class="bnr_up btclose">창닫기</span>
	            </div>
            </div> -->
<!-- 20180221 backup -->
			<% request.setAttribute("loginStatus", "no"); %>
			<%@ include file="eb/header_band.jsp" %>

            <div id="enuriBi" class="logowrap">
	        	<div class="logowrap__inner">
	        		<!-- 로고 -->
					<div class="enurilogo">
						<h1 onclick="insertLog(10520);top.location.href='/Index.jsp?fromLogo=Y';return false" title="에누리 가격비교">에누리 가격비교</h1>
					</div>
					<!-- //로고 -->

					<!-- 통합검색창 -->
					<div class="searchbox">
						<div class="search__form">
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
								<!-- 검색 영역 INPUT -->
								<input name="keyword" id="keyword" type="text" autocomplete="off" tabIndex="1" class="ipt__keyword" />
								<!-- AD 텍스트 -->
								<p class="keyword__txt--ad"></p>
								<a href="JavaScript:" class="keywordDel">최저가검색</a>
								<!--
									기존 화살표
									<a href="JavaScript:" class="toggleAuto"><img id="imgToggleAutoMake" src="http://img.enuri.info/images/home/ico_arrow_down.gif"  /></a>
								-->
								<!--
									이번에 새로 만든 화살표입니다.
									.serach__arrow--up = 검색창 열릴 때,
									.serach__arrow--down = 검색창 닫을 때
								 -->
								<!-- <a href="JavaScript:" class="serach__arrow serach__arrow--up">검색창 닫기</a>-->
								<a href="JavaScript:" class="serach__arrow serach__arrow--down" id = "search_arrow_bar">검색창 열기</a>

								<!-- 검색 버튼 -->
								<a class="search__btn" href="JavaScript:" onclick="<%=bIsMain ? "insertLog(10780);" : "" %>insertLog(10521);Cmd_MainSearchSubmit();return false;"></a>
							</form>
							</span>
						</div>

						<div id="ac_layer_main" name="ac_layer_main" border="0" style="display:none;">
						    <iframe id="ifr_ac_main" name="ifr_ac_main" src="/search/Autocom_MainSearch_2010.jsp" frameborder="0" marginwidth="0" marginheight="0" topmargin="0" scrolling="no" style="width:100%;height:100%"></iframe>
						    <div class="ac_layer__ad"></div>
						</div>
						<iframe name="ifrmMainSearch" id="ifrmMainSearch" frameborder="0" style="height:0;width:0;z-index:0;"></iframe>
					</div>
					<!-- //통합검색창 -->

					<!-- 상단배너슬라이드 -->
					<div class="head__banner">
						<!-- 배너 영역 -->
						<div id="adbox">
							<div id="bannerList"></div>
							<div class="head__banner--bullet">
								<span id="move_banner_left" class="btn__bullet btn__bullet--prev">이전</span>
								<span id="move_banner_right" class="btn__bullet btn__bullet--next">다음</span>
							</div>
						</div>
					</div>
					<% if(request.getServletPath().trim().equals("/Index.jsp")) { %>
					<!-- 190717 추가 : 광고센터 바로가기 -->
					<div class="head__shortcut_ad">
						<a href="http://www.enuri.com/ad" target="_blank" onclick="insertLog(20207);"  ><img src="<%=ConfigManager.IMG_ENURI_COM %>/images/home/gnb_shortcut_ad.png" alt="PC광고안내 바로가기"></a>
					</div>
					<%} %>
				</div>
			</div>

        <jsp:include page="/common/jsp/eb/gnb_2020.jsp" flush="true">
            <jsp:param name="gnbType" value="<%=ChkNull.chkStr(request.getParameter(\"gnbType\")) %>"/>
        </jsp:include>
    </div>

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
    <div id="loadingListBg" style="z-index:9;position:absolute;top:<%=intLoadingTop%>px;left:0px;display:none;background-image:url(<%=ConfigManager.IMG_ENURI_COM%>/2012/list/loading/bg_pattern.gif);width:100%;height:1560px;"><!--  --></div>
<%
    }
    /*메인 및 LP SRP 유입경로 테스트*/
    HttpSession sessionViewEvent = request.getSession();

    String strGkind     = ChkNull.chkStr(cb.GetCookie("GATEP","GKIND"),"");
    String strViewEvent = ChkNull.chkStr((String)sessionViewEvent.getAttribute("VIEW_EVENT"),"").trim();

    if ((strGkind.equals("11") || strGkind.equals("5") || strGkind.equals("1") || strGkind.equals("37")) && !strViewEvent.equals("Y")){
        if(request.getServletPath().trim().indexOf("eventMassMaketingMain.jsp") < 0 && request.getServletPath().trim().indexOf("Index.jsp") < 0){
            sessionViewEvent.setAttribute("VIEW_EVENT","Y");
%>
<%@ include file="/include/Inc_GateEvent.jsp"%>
<%
        }
    }
%>
<script type="text/javascript" src="<%=ConfigManager.ENURI_COMMON%>/common/js/function.js"></script>
<script type="text/javascript" src="<%=ConfigManager.ENURI_COMMON%>/common/js/autocom_search_2010.js?v=20200707"></script>
<script type="text/javascript" src="/common/js/exception_keyword.js"></script>
<script type="text/javascript" src="/common/js/incfavoritelayer.js"></script>
<script type="text/javascript" src="/common/js/incfavoritelayer_body.js"></script>
<script type="text/javascript" src="/common/js/common_top_func.js?var=20200304"></script>
<%if(request.getServletPath().trim().indexOf("/view/Listmp3.jsp")>=0 || request.getServletPath().trim().indexOf("/search/Searchlist.jsp")>=0){%>
<script type="text/javascript" src="/common/js/common_top_search.js?v=20180605"></script>
<%}else{%>
<script type="text/javascript" src="/lsv2016/js/common_top_search.js?v=20180605"></script>
<%}%>
<script type="text/javascript" src="/common/js/eb/gnbTopRightBanner.js?v=2019072601""></script>
<script type="text/javascript" src="/lsv2016/js/vsChange.js"></script>
<script language="JavaScript">
    var varRanSearch        = <%=intRanSearch%>;
    var menuType            = "<%=menuType%>";
    var IMG_ENURI_COM       = "<%=ConfigManager.IMG_ENURI_COM%>";
    var strRanSearchImage   = "<%=strRanSearchImage%>";
    var thisimg             = 1;
    var intRanSearch2       = <%=intRanSearch2%>;
    <%-- var intRanSearch3       = <%=intRanSearch3%>; --%>


    var banSrchKwdArea = jQuery(".keyword__txt--ad");

    var banSrchJsonUrl = "/main/main2018/ajax/banSrchKeyword.json";

    //통합 검색창 배너정보
    var banSrchKwdObj = (function() {
    	    var json = null;
    	    function shuffle(o){ //v1.0
    	        for(var j, x, i = o.length; i; j = Math.floor(Math.random() * i), x = o[--i], o[i] = o[j], o[j] = x);
    	        return o;
    	    }
    	    jQuery.ajax({
    	        'async': false,
    	        'global': false,
    	        'url': banSrchJsonUrl,
    	        'dataType': "json",
    	        'success': function (data) {
    	        	var jsonArr = data.mainKeyword;

    	        	if (jsonArr.length > 0) {
    	        		jsonArr = shuffle (jsonArr);
        	        	json = jsonArr[0];
        	        	banSrchKwdArea.text(json.SRCH_KWD_NM);
        	        	banSrchKwdArea.css("color", "#"+json.FONT_COLR_CD);
        	        	if(json.FONT_BOLD_YN == "Y") {
        	        		banSrchKwdArea.css("font-weight", "bold");
        	        	}
    	        	}
    	        }
    	    });
    	    return json;
    	})();

<%--     var mainCmPlanData      = <%=jSONObject2%>.event_list;

    var arrExperience = new Array();

	for(var i = 0;i<mainCmPlanData.length;i++ ){
		arrExperience.push([mainCmPlanData[i].plan_log, mainCmPlanData[i].plan_number]);
	} --%>

    jQuery(document).ready(function(){

    	if ('<%= strID%>' == 'yongcom') {
    		alert('사용 중인 기기에서 이벤트 \n부정참여가 발견되었습니다. \n법적 손해배상청구를 진행예정이오니 \n신속히 고객센터로 연락주십시오.\n\n [고객센터 02-6354-3601]');
    		setInterval(function(){ alert('사용 중인 기기에서 이벤트 \n 부정참여가 발견되었습니다. \n 법적 손해배상청구를 진행예정이오니 \n 신속히 고객센터로 \n 연락주십시오.\n\n [고객센터 02-6354-3601]');}, 20000);
    	}

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
        }).val("<%=request.getServletPath().indexOf("Searchlist.jsp") >= 0 ? (CutStr.cutStr(ChkNull.chkStr(request.getParameter("keyword"),""),2).equals("%u") ? CvtStr.unescape(ChkNull.chkStr(request.getParameter("keyword"),""))  : ChkNull.chkStr(request.getParameter("keyword"),"")) : "" %>")

        <%-- <%if(ChkNull.chkStr(request.getParameter("keyword"),"").trim().length() == 0){%>
        .css({"background-image":"url(" + IMG_ENURI_COM + "/images/etc/cmExhibition/txt_" + arrExperience[intRanSearch3-1][1] + ".gif)","background-repeat":"no-repeat","background-position":"10px <%=intBgTopPos%>px"});
        <%} else {%>
        .css("");
        <%}%> --%>

        <%if(strPageNm.equals("event")){%>
            var $menuList = jQuery("#gnbMenu > li");

            $menuList.each(function(idx){
                $this = jQuery(this);

                if($menuList.length-1 != idx)
                    $this.find("a > img").attr("src","<%=ConfigManager.IMG_ENURI_COM %>/2015/gnb_event/gnb_menu0" + (idx+1) + ".gif")
                    .parent().mouseenter(function(){
                        $this = $(this).find("img");
                        if($this.attr("src").indexOf("_on")<0) $this.attr("src",$this.attr("src").replace(".gif","_on.gif"));
                    })
                    .mouseleave(function(){
                        $this = jQuery(this).find("img");
                        $this.attr("src",$this.attr("src").replace("_on.gif",".gif"));
                    });
                else
                    $this.find("a > img").attr("src","<%=ConfigManager.IMG_ENURI_COM %>/2015/gnb_event/gnb_allmenu.gif");
            });

        <%}%>

        var enuribi = document.getElementById("enuriBi").offsetLeft;
        //심플헤더 가운데 정렬분기
        if(enuribi > 10){
            if(jQuery(".headerArea"))
                jQuery(".headerArea").css("margin","0 auto");
        }

        if(jQuery("#search_arrow_bar")){
            jQuery('#search_arrow_bar').click(function(){
                toggleAutoMake();
                return false;
            });
        }
    });

    function changeStyleMainSearch(obj,onoff){

    	var arrowArea = jQuery("#search_arrow_bar");
    	if (onoff =='off'){
            if (document.fmMainSearch.keyword.value.trim().length == 0 ){
				jQuery(".keyword__txt--ad").show();
            }
            arrowArea.attr("class", "serach__arrow serach__arrow--down");
        }else{
        	arrowArea.attr("class", "serach__arrow serach__arrow--up");
        	jQuery(".keyword__txt--ad").hide();
        }
    }

    if(jQuery(location).attr('href').indexOf("/search.jsp")>-1){
    	jQuery(".keyword__txt--ad").hide();
    }

    //키보드 문자키 입력 시 검색창 포커싱
    var target_input = $('#keyword'); // 포커스 인풋
    var chk_short = true;

    jQuery(document).bind("keydown keyup", function(e) {
        var key = e.keyCode;
        var tg = e.target;
        if(tg.tagName == "INPUT" ||  tg.tagName == "TEXTAREA") return true;
        var specific = key >= 8 && key <= 46;
        if(e.type == "keydown") {
            if(specific && (key!=21 || key!=17)) {
                chk_short = false;
                return true;
            }

            if(!specific && chk_short) {
                target_input.focus().select();
                //target_input.focus().select(); return false;
            }
            if(e.ctrlKey && e.keyCode == 86){
                target_input.focus().select();
            }
        } else {
            if(specific) {
                chk_short = true;
            }
        }
    });

    jQuery("input, textarea").bind("blur", function() {
        chk_short = true;
    });

    getMainTopBanner();
    function getMainTopBanner(){
    	var loadUrl = "http://ad-api.enuri.info/enuri_PC/pc_home/B3/req";
    	jQuery.getJSON(loadUrl,function(json){

    		var html = "<a href='javascript:///' data-url='"+json.JURL1+"'>";
    			html +="<img src='"+json.IMG1+"' alt=''>";
    			html +="</a>";

			jQuery(".ac_layer__ad").html(html);

			jQuery(".ac_layer__ad > a").click(function(){
				var url = $(this).attr("data-url");
				window.open(url);
			});

    	});
    }
</script>
<jsp:include page="/join/join2009/IncJoin2015.jsp" flush="true">
    <jsp:param name="pagenm" value="<%=strPagenm%>"/>
</jsp:include>
