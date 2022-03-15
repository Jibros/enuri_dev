<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@page import="org.json.*"%>
<%@ page import="com.enuri.include.RandomMain"%>
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
<link rel="stylesheet" type="text/css" href="/css/swiper.css"/>    
<link rel="stylesheet" type="text/css" href="/css/rev/common.css"/> <!-- reset -->
<link rel="stylesheet" type="text/css" href="/css/rev/template.css"/> <!-- template -->
<!-- <div id="nonbanking_site1" style="font-size:8pt;width:131px; height:211px; position:absolute;  top:45px; z-index:10003; display:none; overflow:hide; " onMouseOver="showNonbanking_site();" onmouseout="hideNonbanking_site();"></div> -->
<%-- <%@ include file="/login/Inc_Login_MyMenu.jsp" --%>
<div id="wrap">
	<jsp:include page="/login/Inc_LoginTop_2015.jsp" flush="true"></jsp:include><!-- 로그인레이어 -->
    <iframe name="ifrmMainSearch" id="ifrmMainSearch" frameborder="0" style="position:absolute;height:0;width:0;z-index:0;"></iframe><!-- 구글 레이어 -->
    <%
	if(request.getServletPath().trim().equals("/Index.jsp") || request.getServletPath().trim().equals("/Index_lazyload.jsp") ){
	%>
    <!-- [AD] 메인 탑 배너 -->
    <div class="header-top-over">
        <div class="header-top-over__bnr" style="background-color: rgb(238, 238, 238);">
            <a href="#" style="background-image: url('http://ad-api.enuri.info/vimp/c_id/56/a_id/785/i_id/6491/site_id/22/slot_id/29/?rand=9316&amp;r=6518');"></a>
        </div>
        <!-- 버튼 : 닫기 -->
        <button class="header-top__btn--close comm__sprite" onclick="$(this).parent().slideUp(300);">닫기</button>
        <!-- // -->
    </div>
    <!-- // -->
<%
	}
%>

    <!-- [C] 헤더 wrap -->
    <header class="header">
        <!-- [C] 헤더 탑 -->
        <div class="header-top">
            <div class="header-top__inner cont__inner">
                <!-- 헤더탑 탭 -->
                <ul class="header-top__tab">
                    <li><a href="/knowcom/index.jsp" onclick="insertLog(20883);" target="_blank">쇼핑지식</a></li>
                    <!-- 새로운 이슈가 있을때 .is--new 클래스 붙여주세요 -->
                    <li class="is--new"><a href="/eventPlanZone/jsp/shoppingBenefit.jsp" onclick="insertLog(20884);" target="_blank">혜택존</a></li>
                    <li><a href="/event2020/pick.jsp" onclick="insertLog(22644);" >PICK</a></li>
                </ul>
                <!-- // 헤더 탭 -->

                <!-- 헤더탑 메뉴 -->
                <!-- .is--login : 로그인 상태 전용 -->
                <!-- .is--logout : 로그아웃 상태 전용 -->
                <!-- 더보기는 둘다 노출 -->
                <ul class="header-top__menu">
                    <!-- 로그인 : 회원정보 -->
                    <li class="menu-user-info is--login" style="<%=cb.GetCookie("MEM_INFO","USER_ID").trim().length()> 0 ? "":"display:none;"%>">
                    	<%
				      		Object loginStatus = request.getAttribute("loginStatus");
				      		boolean isNoLoginStatus = loginStatus!=null && "no".equals(loginStatus.toString());
				      		if (!isNoLoginStatus) {
								String sMymenuID  = cb.GetCookie("MEM_INFO","USER_ID");
								String sNicknameNew = cb.GetCookie("MEM_INFO","USER_NICK");
								String strMyText = "".equals(sNicknameNew)?sMymenuID:sNicknameNew;
			            %>
                        <a id="frmMainLogin" href="JavaScript:">
                            <!-- 아이콘 : 등급 -->
                            <i class="ico-grade ico-grade--sm " id="header-top_grade">VIP</i>
                            <!-- <i class="ico-grade ico-grade--sm ico-grade--family">FAMILY</i> -->
                            <!-- <i class="ico-grade ico-grade--sm ico-grade--green">GREEN</i> -->
                            <!-- 유저 id/Nickname -->
                            <span class="user-info__name">
                                <em><%=(strMyText.length()>13)?strMyText.substring(0,12):strMyText%></em>님
                            </span>
                            <i class="ico-arr comm__sprite"></i>
                        </a>
					    <% } %>
					    <%
							String strMyInfoUrl = "";
							String myServerName = request.getServerName();
							if(myServerName.indexOf("stagedev.enuri.com")>-1) {
								strMyInfoUrl = "https://"+myServerName;
							}else if(myServerName.indexOf("100.100.100.151")>-1 || myServerName.indexOf("dev.enuri.com")>-1){
							strMyInfoUrl = "https://"+myServerName;
							}else{
								strMyInfoUrl = "https://"+myServerName;
							}
						%>
                        <!-- 오버시 : 레이어 -->
                        <div class="header-top__lay user-info__lay">
                            <div class="header-top__lay--body">
                                <!-- 아이콘 : 등급 -->
                                <i class="ico-grade ico-grade--big " id="myinfo_grade">VIP</i>
                                <!-- <i class="ico-grade ico-grade--big ico-grade--family">FAMILY</i> -->
                                <!-- <i class="ico-grade ico-grade--big ico-grade--green">GREEN</i> -->
                                <div class="user-info__lay__detail">
                                    <div class="user-info__lay__row">
                                    	<a class="user-info--name" href="<%=strMyInfoUrl%>/member/info/infoPwChk.jsp" target="_blank" onclick="insertLog(16982);">
                                            <em id="myid"></em> 님
                                            <i class="ico-lock comm__sprite"></i>
                                        </a>
                                    </div>
                                    <div class="user-info__lay__row">
                                        <a href="/estore/estore.jsp" target="_blank" title="새 창에서 열립니다" onclick="insertLog(16985);" class="user-info--emoney">
                                            <dl>
                                                <dt>e머니</dt>
                                                <dd><em id="myinfo_emoney"></em></dd>
                                            </dl>
                                        </a>
                                        <a href="/estore/estore.jsp" target="_blank" title="새 창에서 열립니다" onclick="insertLog(16985);" class="ico-store comm__sprite">쿠폰스토어</a>
                                    </div>
                                    <div class="user-info__lay__row">
                                        <a href="/knowcom/mybox.jsp?tno=2" target="_blank" title="새 창에서 열립니다" onclick="insertLog(16986);" class="user-info--score">
                                            <dl>
                                                <dt>활동점수</dt>
                                                <dd><em id="myinfo_score"></em></dd>
                                            </dl>
                                        </a>
                                        <a href="/knowcom/mybox.jsp?tno=2" target="_blank" title="새 창에서 열립니다" onclick="insertLog(16987);" class="user-info--rank">
                                            <dl>
                                                <dt>활동랭킹</dt>
                                                <dd><em id="myinfo_ranking"></em></dd>
                                            </dl>
                                        </a>
                                    </div>
                                    <!-- 버튼 : 로그아웃 -->
                                    <button class="user-info__btn--logout comm__sprite" onclick="insertLog(16983);logout();">로그아웃</button>
                                </div>
                            </div>
                            <div class="header-top__lay--foot">
                            	<a href="<%=strMyInfoUrl%>/my/my_enuri.jsp" target="_blank" title="새 창에서 열립니다" onclick="insertLog(20750);">MY에누리</a>
								<a href="/knowcom/mybox.jsp?tno=4" target="_blank" title="새 창에서 열립니다" onclick="insertLog(16989);">최근 본 글</a>
								<a href="/knowcom/qna.jsp" target="_blank" title="새 창에서 열립니다" onclick="insertLog(16990);">쇼핑Q&A</a>
								<a href="<%=strMyInfoUrl%>/member/info/info.jsp" target="_blank" title="새 창에서 열립니다" onclick="insertLog(16991);">개인정보관리</a>
                            </div>
                        </div>
                        <!-- // -->
                    </li>
                    <!-- 로그인 : SDU/SDUL회원 전용 -->
                    <!-- <li class="is--login">
                        <a href="#">SDU(L)</a>
                    </li> -->
                    <!-- 로그인 : e머니 노출 -->
                    <%
						CookieBean cbb = new CookieBean( request.getCookies());
						String strEnrUsr  = cbb.GetCookie("MEM_INFO","USER_ID");
						Sdul_Member_Data ndata = new Sdul_Member_Proc().getSdulmember(strEnrUsr);
					
						//MS 오피스 직판 구매 유무
						boolean isMSgoodsUser = false;
						isMSgoodsUser = new Msgoods_Sale_Log_Proc().getMsgoodsSaleUser(strEnrUsr);
					
						//SDUL
						int intSdulCnt = new Sdul_Goods_Proc().SdulGoodsRedyCount(strEnrUsr);
					
						//찜한상품건수
						int intFavoriteCnt = new Save_Goods_Proc().getSaveGoodCnt(strEnrUsr, "MEMBER");
					%>
					<%if(ndata != null) { %>
							<li class="is--login"><a href="javascript:goMyPage('/sdul/mallregister/SellerMain.jsp?sm=1');">SDUL(대기중) <em>(<%=intSdulCnt%>)</em></a></li> <!-- 판매자전용 -->
							<!-- <li class="is--login"><a href="javascript:goMyPage('/sdul/mallregister/SellerMain.jsp?sm=2');">상위노출입찰</a></li> -->
				    <%}%>
					<li class="is--login" style="<%=cb.GetCookie("MEM_INFO","USER_ID").trim().length()> 0 ? "":"display:none;"%>">
                        <a href="/estore/estore.jsp" target="_blank" title="새 창에서 열립니다" onclick="insertLog(16985);">e머니 <em class="menu__tx--emoney" id="menu__tx--emoney"></em></a>
                    </li>
                    <li class="is--login" style="<%=cb.GetCookie("MEM_INFO","USER_ID").trim().length()> 0 ? "":"display:none;"%>">
                        <a href="/estore/estore.jsp" target="_blank" title="새 창에서 열립니다" onclick="insertLog(16985);">e머니 <em class="menu__tx--emoney" id="menu__tx--emoney"></em></a>
                    </li>
                    <!-- 로그인 : 쇼핑지식 활동점수 -->
                    <li class="is--login" style="<%=cb.GetCookie("MEM_INFO","USER_ID").trim().length()> 0 ? "":"display:none;"%>">
                        <a href="/knowcom/mybox.jsp?tno=2" target="_blank" title="새 창에서 열립니다" onclick="insertLog(16986);">활동점수 <em class="menu__tx--act" id="menu__tx--act"></em></a>
                    </li>
                    <!-- 로그아웃 : 로그인 버튼 -->
                    <li id='utilMenuLogin' class="is--logout" style="<%=cb.GetCookie("MEM_INFO","USER_ID").trim().length()> 0 ? "display:none;" : ""%>">
                        <a href="JavaScript:" onclick="setLogintopMygoods(4);Cmd_Login('');document.getElementById('divLoginLayer').style.zIndex='99997';insertLog(4661);"><i class="ico-login comm__sprite"></i> 로그인</a>
                    </li>
                    <!-- 로그아웃 : 회원가입 버튼 -->
                    <li id='utilMenuJoin' class="is--logout" style="<%=cb.GetCookie("MEM_INFO","USER_ID").trim().length()> 0 ? "display:none;" : ""%>">
                        <a href="JavaScript:" onclick="insertLog(10519);goJoin();"><i class="ico-join comm__sprite"></i> 회원가입</a>
                    </li>                        
                    <!-- 로그아웃/인 공통 : 더보기 -->
                    <li class="menu-more">
                        <a href="#" onclick="return false;">더보기 <i class="ico-arr comm__sprite"></i></a>
                        <!-- 오버시 : 더보기 레이어 -->
                        <!-- template.html 참고 -->
                        <div class="header-top__lay sitemap__lay">
                            <div class="header-top__lay--body">
                                <dl class="sitemap__group group--core">
                                    <dt>주요 서비스</dt>
                                    <dd>
                                        <ul class="sitemap__list">
                                            <li><a href="/deal/newdeal/index.deal" target="_new">소셜비교</a></li>
                                            <li><a href="/enuripc/" target="_blank" onclick="insertLog(18618);">조립PC</a></li>
                                            <li><a href="/global/Index.jsp" target="_new" onclick="insertLog(20803);">해외직구</a></li>
                                            <li><a href="/tour2012/Tour_Index.jsp" onclick="insertLog(12175);">여행비교</a></li>
                                            <li><a href="http://auto.enuri.com" onclick="insertLog(21265);">자동차</a></li>
                                        </ul>
                                        <ul class="sitemap__list">
                                            <li><a href="/view/shopBest.jsp" target="_blank" onclick="insertLog(12171);">쇼핑BEST</a></li>
                                            <li><a href="/view/move_mall.jsp" onclick="insertLog(12172);">이사견적</a></li>
                                            <li><a href="/view/Flower365.jsp" onclick="insertLog(12173);">꽃배달</a></li>
                                        </ul>
                                    </dd>
                                </dl>
                                <dl class="sitemap__group group--comm">
                                    <dt>커뮤니티</dt>
                                    <dd>
                                        <ul class="sitemap__list">
                                            <li><a href="/knowcom/index.jsp" onclick="insertLog(12176);">쇼핑지식</a></li>
                                            <li><a href="/knowcom/news.jsp" onclick="insertLog(14864);">뉴스</a></li>
                                            <li><a href="/knowcom/guide.jsp" onclick="insertLog(14865);">구매가이드</a></li>
                                            <li><a href="/knowbox2/review/index.jsp" onclick="insertLog(12177);">사용기</a></li>
                                            <li><a href="/knowbox2/nuri/index.jsp" onclick="insertLog(12178);">자유게시판</a></li>
                                        </ul>
                                        <ul class="sitemap__list">
                                            <li><a href="/knowcom/enuritv.jsp" onclick="insertLog(16109);">에누리TV</a></li>
                                            <li><a href="/knowcom/eventzone.jsp" onclick="insertLog(22885 );">이벤트존</a></li>
                                            <li><a href="/knowcom/nurigo.jsp" onclick="insertLog(22444);">누리GO</a></li>
                                            <li><a href="/knowcom/qna.jsp" onclick="insertLog(12177);">쇼핑Q&amp;A</a></li>
                                            <li><a href="/eventPlanZone/jsp/shoppingBenefit.jsp?tab_ty=pick" onclick="insertLog(12178);">PICK</a></li>
                                        </ul>
                                    </dd>
                                </dl>
                            </div>
                            <div class="header-top__lay--foot">
                                <a href="/etc/Site_map.jsp" class="enuri_all" target="_new">에누리 서비스 전체보기 <i class="ico-arrr comm__sprite"></i></a>
                            </div>
                        </div>
                        <!-- // -->
                    </li>
                    <!-- // -->
                </ul>
            </div>
        </div>
        <!-- [C] 헤더 -->
        <!-- 스크롤 되어 가려질때 .is--show 클래스가 붙습니다 -->
        <div class="header-core">
            <div class="header__inner">
                <h1><a class="header-core__bi comm__sprite" href="/index.jsp">에누리 가격비교</a></h1>
                <!-- 헤더 - 검색 -->
                <!-- .is--focused : input 포커스됨 ( 광고문구 가림 / 하단 레이어 활성화 / 저장된 검색어 노출 ) -->
                <!-- .is--active : input 값 입력됨 ( 광고문구 가림 / 연관검색어 노출 ) -->
                <div class="header-sr">
                    <!-- 검색바 -->                        
                    <div class="header-sr__form">
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
							<input name="keyword" id="keyword" type="text" autocomplete="off" tabIndex="1" class="header-sr__form__inp" />
							<!-- AD 텍스트 -->
							<span class="header-sr__form__tx-ad keyword__txt--ad">워라벨의 시작은 주방가전으로부터</span>
							<!-- <a href="JavaScript:" class="keywordDel">최저가검색</a> -->
							<i class="header-sr__ico-arr comm__sprite" id = "search_arrow_bar_"></i>

							<!-- 검색버튼 -->
	                        <button type="text" class="header-sr__form__btn" onclick="<%=bIsMain ? "insertLog(10780);" : "" %>insertLog(10521);Cmd_MainSearchSubmit();return false;">
	                            <i class="comm__sprite">검색</i>                                
	                        </button>
						</form>
                        </span>
                    </div>
                    <!-- 저장/연관검색어 -->
                    <!-- .header-sr__form__inp 의 value length가 1이상일때 활성화 -->
                    <div class="sr-related" id="ac_layer_main" name="ac_layer_main">                            
                        <!-- 리스트 : 최근검색어 -->
                        <div class="sr-related__item" style="height: 236px;">
	                        <iframe id="ifr_ac_main" name="ifr_ac_main" src="/search/Autocom_MainSearch_2021.jsp" frameborder="0" marginwidth="0" marginheight="0" topmargin="0" scrolling="no" style="width:100%;height:100%"></iframe>
		                </div>
		                <iframe name="ifrmMainSearch" id="ifrmMainSearch" frameborder="0" style="height:0;width:0;z-index:0;"></iframe>
		                <div class="sr-related__bnr"></div>
						<!-- 하단 툴 -->
	                    <div class="sr-related__foot">
	                        <button class="related__btn--save--off" onclick="noSaveHistory();return false;" style="display: none">검색어 저장 끄기</button>
	                        <button class="related__btn--save--on" onclick="noSaveHistory();return false;" style="display: none">검색어 저장 켜기</button>
	                        <button class="related__btn--lay--off">닫기</button>
	                    </div>
                    </div>
                </div>
                <script>
                    // 검색창 관련 (퍼블테스트)
                    $(function(){
                        var $sr = $(".header-sr");
                        var $srInp = $(".header-sr__form__inp");
                        var $btnClose = $(".related__btn--lay--off");
                        var $dim = $(".container");
                        // 검색창이 focus 되어있을때 확장 레이어 노출
                        $srInp.on({
                            "focus": function(){
                                var inpLen = $srInp.val().length;
                                if ( !inpLen ){
                                    $sr.addClass("is--focused")
                                    $sr.removeClass("is--active");
                                    $dim.addClass("is--dim");
                                }else{
                                    $sr.addClass('is--focused is--active');
                                    $dim.addClass("is--dim");
                                }
                            },"keyup" : function(){
                                var inpLen = $srInp.val().length;
                                if ( !inpLen ){
                                    $sr.removeClass('is--active');
                                }else{
                                    $sr.addClass('is--active');
                                    $dim.addClass("is--dim");                                        
                                }
                            }
                        }); 
                        // 검색창 초기화 (닫기)
                        var resetSR = function(){
                            var inpLen = $srInp.val().length;
                            ( !inpLen ) ? $sr.removeClass('is--focused is--active') :$sr.removeClass('is--focused');
                            $dim.removeClass("is--dim");
                            $("#ac_layer_main").hide();
                        }
                        // 검색창 외부를 클릭했을때 초기화
                        $('html').on('click',function(e){ 
                            var $t = $(e.target);
                            if( !$t.closest('.header-sr').length ){
                                if ( !$srInp.is(":focus") ){
                                    resetSR();
                                    $("#ac_layer_main").hide();
                                }
                            }
                        });
                        // 버튼 : 닫기
                        $btnClose.click(resetSR);
                    })
                </script>
                <!-- // 검색 -->

                <!-- 헤더 - 카테고리 -->
                <div class="header-cate">
                    <ul class="header-cate__list">
                        <li class="header-cate__item"><a href="#"><i class="ico-cate"><img src="//img.enuri.info/images/rev/@header-top-cate.png" alt=""></i> 가전/TV</a></li>
                        <li class="header-cate__item"><a href="#"><i class="ico-cate"><img src="//img.enuri.info/images/rev/@header-top-cate.png" alt=""></i> 태블릿</a></li>
                        <li class="header-cate__item"><a href="#"><i class="ico-cate"><img src="//img.enuri.info/images/rev/@header-top-cate.png" alt=""></i> 카메라</a></li>
                    </ul>
                    <!-- 버튼 : 전체카테고리 열기 -->
                    <button class="header-cate__btn--all" onclick="$('.lay-cate-all').removeClass('is--hide');">
                        <i class="ico-cate--all comm__sprite"></i> 전체카테고리
                    </button>
                </div>
                <!-- // -->

                <!-- 헤더 - 우측광고 -->
                <div class="header-ad">
                    <!-- 배너 -->
                    <a href="#"><img src="//img.enuri.info/images/rev/@header-ad__bnr.png" alt=""></a>
                    <!-- // -->                        
                    <button class="header-ad__btn header-ad__btn--prev comm__sprite">이전</button>
                    <button class="header-ad__btn header-ad__btn--next comm__sprite">다음</button>
                </div>
            </div>
        </div>
    </header>        
    <!-- // [C] 헤더 wrap -->        

    <!-- [레이어] 전체 카테고리 -->
    <div class="lay-cate-all is--hide">
        <div class="lay-cate-all__inner">
            <div class="lay-cate-all__head">
                전체 카테고리
                <!-- 버튼 : 닫기 -->
                <button class="lay-cate-all__btn" onclick="$('.lay-cate-all').addClass('is--hide');"><i class="ico-cls--big">닫기</i></button>
                <!-- // -->
            </div>
            <!-- [레이어] > 전체 카테고리 커스텀 -->
            <!-- 홈메인 > 전체 카테고리 와 마크업 동일합니다. -->
            <!-- template.html 참고 -->
            <div class="cate-all">
                <!-- 카테고리 리스트 -->
                <ul class="cate--depth1">
                    <!-- [반복] Depth1 -->
                    <li class="cate-item--depth1 is--on">
                        <p class="cate__tit">가전TV</p>
                        <!-- 우측 확장메뉴 -->
                        <div class="cate-item__expend">
                            <ul class="cate--depth2">
                                <!-- [반복] Depth2 -->
                                <li class="cate-item--depth2">
                                    <p class="cate__tit--depth2">TV</p>
                                    <ul class="cate--depth3">
                                        <!-- [반복] Depth3 -->
                                        <li class="cate-item--depth3"><a href="#">직구TV</a></li>
                                        <!-- // -->
                                        <li class="cate-item--depth3"><a href="#">QLED TV</a></li>
                                        <li class="cate-item--depth3"><a href="#">80인치대</a></li>
                                        <li class="cate-item--depth3"><a href="#">70인치대</a></li>
                                        <li class="cate-item--depth3"><a href="#">50인치대</a></li>
                                        <li class="cate-item--depth3"><a href="#">43인치 이하</a></li>
                                        <li class="cate-item--depth3"><a href="#">LG전자</a></li>
                                        <li class="cate-item--depth3"><a href="#">삼성전자</a></li>
                                        <li class="cate-item--depth3"><a href="#">중소제조사</a></li>
                                    </ul>
                                </li>
                                <!-- // -->
                                <li class="cate-item--depth2">
                                    <p class="cate__tit--depth2">프로젝터,스크린</p>
                                    <ul class="cate--depth3">
                                        <li class="cate-item--depth3"><a href="#">홈시어터용</a></li>
                                        <li class="cate-item--depth3"><a href="#">회의실,강당용</a></li>
                                        <li class="cate-item--depth3"><a href="#">초소형</a></li>
                                        <li class="cate-item--depth3"><a href="#">스크린</a></li>
                                        <li class="cate-item--depth3"><a href="#">프로젝터 액세서리</a></li>
                                        <li class="cate-item--depth3"><a href="#">케이블,젠더</a></li>
                                    </ul>
                                </li>
                                <li class="cate-item--depth2">
                                    <p class="cate__tit--depth2">홈시어터,오디오</p>
                                    <ul class="cate--depth3">
                                        <li class="cate-item--depth3"><a href="#">사운드바</a></li>
                                        <li class="cate-item--depth3"><a href="#">AV리시버</a></li>
                                        <li class="cate-item--depth3"><a href="#">앰프/리시버</a></li>
                                        <li class="cate-item--depth3"><a href="#">플레이어</a></li>
                                        <li class="cate-item--depth3"><a href="#">턴테이블</a></li>
                                        <li class="cate-item--depth3"><a href="#">스피커</a></li>
                                        <li class="cate-item--depth3"><a href="#">블루레이,DVD,Divx</a></li>
                                        <li class="cate-item--depth3"><a href="#">오디오,카세트,라디오</a></li>
                                        <li class="cate-item--depth3"><a href="#">마이크,노래반주기</a></li>                            
                                        <li class="cate-item--depth3"><a href="#">방송음향기기</a></li>
                                    </ul>
                                </li>
                                <li class="cate-item--depth2">
                                    <p class="cate__tit--depth2">영상가전 액세서리</p>
                                    <ul class="cate--depth3">
                                        <li class="cate-item--depth3"><a href="#">셋톱박스,블루레이</a></li>
                                        <li class="cate-item--depth3"><a href="#">영상어댑터</a></li>
                                        <li class="cate-item--depth3"><a href="#">브라켓</a></li>
                                        <li class="cate-item--depth3"><a href="#">리모컨</a></li>
                                        <li class="cate-item--depth3"><a href="#">케이블,젠더</a></li>
                                    </ul>
                                </li>
                                <li class="cate-item--depth2">
                                    <p class="cate__tit--depth2">주방가전</p>
                                    <ul class="cate--depth3">
                                        <li class="cate-item--depth3"><a href="#">냉장고</a></li>
                                        <li class="cate-item--depth3"><a href="#">김치냉장고</a></li>
                                        <li class="cate-item--depth3"><a href="#">전기밥솥</a></li>
                                        <li class="cate-item--depth3"><a href="#">식기세척, 살균건조기</a></li>
                                        <li class="cate-item--depth3"><a href="#">가스, 전기레인지</a></li>
                                        <li class="cate-item--depth3"><a href="#">믹서, 분쇄기, 원액기</a></li>
                                        <li class="cate-item--depth3"><a href="#">커피메이커, 머신</a></li>
                                        <li class="cate-item--depth3"><a href="#">에어프라이어, 전기포트</a></li>
                                        <li class="cate-item--depth3"><a href="#">오븐, 전자레인지</a></li>
                                        <li class="cate-item--depth3"><a href="#">음식물처리, 진공포장기</a></li>
                                    </ul>
                                </li>
                                <li class="cate-item--depth2">
                                    <p class="cate__tit--depth2">생활가전</p>
                                    <ul class="cate--depth3">
                                        <li class="cate-item--depth3"><a href="#">세탁기</a></li>
                                        <li class="cate-item--depth3"><a href="#">의류건조기, 스타일러</a></li>
                                        <li class="cate-item--depth3"><a href="#">청소기</a></li>
                                        <li class="cate-item--depth3"><a href="#">다리미, 재봉틀, 보풀제거</a></li>
                                        <li class="cate-item--depth3"><a href="#">도어록, 비디오폰, 보안용품</a></li>
                                        <li class="cate-item--depth3"><a href="#">전화기, 무전기</a></li>
                                        <li class="cate-item--depth3"><a href="#">학습용 스탠드</a></li>
                                        <li class="cate-item--depth3"><a href="#">정수기, 냉온수기</a></li>
                                    </ul>
                                </li>
                                <li class="cate-item--depth2">
                                    <p class="cate__tit--depth2">계절가전</p>
                                    <ul class="cate--depth3">
                                        <li class="cate-item--depth3"><a href="#"></a></li>
                                    </ul>
                                </li>
                                <li class="cate-item--depth2">
                                    <p class="cate__tit--depth2">건강가전,의료,실버</p>
                                    <ul class="cate--depth3">
                                        <li class="cate-item--depth3"><a href="#"></a></li>
                                    </ul>
                                </li>
                                <li class="cate-item--depth2">
                                    <p class="cate__tit--depth2">미용,욕실가전</p>
                                    <ul class="cate--depth3">
                                        <li class="cate-item--depth3"><a href="#"></a></li>
                                    </ul>
                                </li>
                                <li class="cate-item--depth2">
                                    <p class="cate__tit--depth2">1인 필수가전</p>
                                    <ul class="cate--depth3">
                                        <li class="cate-item--depth3"><a href="#"></a></li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                        <!-- // -->
                    </li>
                    <!-- // 대대카테고리 -->
                    <li class="cate-item--depth1">
                        <p class="cate__tit">컴퓨터/노트북/조립PC</p>
                        <!-- 우측 확장메뉴 -->
                        <div class="cate-item__expend">
                            <ul class="cate--depth2">
                                <!-- [반복] Depth2 -->
                                <li class="cate-item--depth2">
                                    <p class="cate__tit--depth2">노트북</p>
                                    <ul class="cate--depth3">
                                        <!-- [반복] Depth3 -->
                                        <!-- // -->
                                        <li class="cate-item--depth3"><a href="#">직구TV</a></li>
                                        <li class="cate-item--depth3"><a href="#">QLED TV</a></li>
                                        <li class="cate-item--depth3"><a href="#">80인치대</a></li>
                                        <li class="cate-item--depth3"><a href="#">70인치대</a></li>
                                        <li class="cate-item--depth3"><a href="#">50인치대</a></li>
                                        <li class="cate-item--depth3"><a href="#">43인치 이하</a></li>
                                        <li class="cate-item--depth3"><a href="#">LG전자</a></li>
                                        <li class="cate-item--depth3"><a href="#">삼성전자</a></li>
                                        <li class="cate-item--depth3"><a href="#">중소제조사</a></li>
                                        <li class="cate-item--depth3"><a href="#">최대10개</a></li>
                                    </ul>
                                </li>
                                <!-- // -->
                                <li class="cate-item--depth2">
                                    <p class="cate__tit--depth2">데스크탑,일체형PC</p>
                                    <ul class="cate--depth3">
                                        <li class="cate-item--depth3"><a href="#">홈시어터용</a></li>
                                        <li class="cate-item--depth3"><a href="#">회의실,강당용</a></li>
                                        <li class="cate-item--depth3"><a href="#">초소형</a></li>
                                        <li class="cate-item--depth3"><a href="#">스크린</a></li>
                                        <li class="cate-item--depth3"><a href="#">프로젝터 액세서리</a></li>
                                        <li class="cate-item--depth3"><a href="#">케이블,젠더</a></li>
                                    </ul>
                                </li>
                                <li class="cate-item--depth2">
                                    <p class="cate__tit--depth2">태블릿PC</p>
                                    <ul class="cate--depth3">
                                        <li class="cate-item--depth3"><a href="#">사운드바</a></li>
                                        <li class="cate-item--depth3"><a href="#">AV리시버</a></li>
                                        <li class="cate-item--depth3"><a href="#">앰프/리시버</a></li>
                                        <li class="cate-item--depth3"><a href="#">플레이어</a></li>
                                        <li class="cate-item--depth3"><a href="#">턴테이블</a></li>
                                        <li class="cate-item--depth3"><a href="#">스피커</a></li>
                                        <li class="cate-item--depth3"><a href="#">블루레이,DVD,Divx</a></li>
                                        <li class="cate-item--depth3"><a href="#">오디오,카세트,라디오</a></li>
                                        <li class="cate-item--depth3"><a href="#">마이크,노래반주기</a></li>                            
                                        <li class="cate-item--depth3"><a href="#">방송음향기기</a></li>
                                    </ul>
                                </li>
                                <li class="cate-item--depth2">
                                    <p class="cate__tit--depth2">모니터</p>
                                    <ul class="cate--depth3">
                                        
                                    </ul>
                                </li>
                                <li class="cate-item--depth2">
                                    <p class="cate__tit--depth2">복합기,프린터,스캐너</p>
                                    <ul class="cate--depth3">
                                        
                                    </ul>
                                </li>
                                <li class="cate-item--depth2">
                                    <p class="cate__tit--depth2">조립PC,온라인견적</p>
                                    <ul class="cate--depth3">
                                        
                                    </ul>
                                </li>
                                <li class="cate-item--depth2">
                                    <p class="cate__tit--depth2">에누리 인텔존</p>
                                    <ul class="cate--depth3">
                                        
                                    </ul>
                                </li>
                                <li class="cate-item--depth2">
                                    <p class="cate__tit--depth2">PC주요부품</p>
                                    <ul class="cate--depth3">
                                        
                                    </ul>
                                </li>
                                <li class="cate-item--depth2">
                                    <p class="cate__tit--depth2">저장장치</p>
                                    <ul class="cate--depth3">
                                        
                                    </ul>
                                </li>
                                <li class="cate-item--depth2">
                                    <p class="cate__tit--depth2">주변기기,공유기,CCTV</p>
                                    <ul class="cate--depth3">
                                        
                                    </ul>
                                </li>
                            </ul>
                        </div>
                        <!-- // -->
                    </li>
                    <li class="cate-item--depth1">
                        <p class="cate__tit">태블릿/모바일/디카</p>
                        <div class="cate-item__expend">
                            <ul class="cate--depth2">
                                <!-- [반복] Depth2 -->
                                <li class="cate-item--depth2">
                                    <p class="cate__tit--depth2">노트북</p>
                                    <ul class="cate--depth3">
                                        <!-- [반복] Depth3 -->
                                        <!-- // -->
                                        <li class="cate-item--depth3"><a href="#">직구TV</a></li>
                                        <li class="cate-item--depth3"><a href="#">QLED TV</a></li>
                                        <li class="cate-item--depth3"><a href="#">80인치대</a></li>
                                        <li class="cate-item--depth3"><a href="#">70인치대</a></li>
                                        <li class="cate-item--depth3"><a href="#">50인치대</a></li>
                                        <li class="cate-item--depth3"><a href="#">43인치 이하</a></li>
                                        <li class="cate-item--depth3"><a href="#">LG전자</a></li>
                                        <li class="cate-item--depth3"><a href="#">삼성전자</a></li>
                                        <li class="cate-item--depth3"><a href="#">중소제조사</a></li>
                                        <li class="cate-item--depth3"><a href="#">최대10개</a></li>
                                    </ul>
                                </li>
                                <!-- // -->
                                <li class="cate-item--depth2"></li>
                                <li class="cate-item--depth2"></li>
                                <li class="cate-item--depth2"></li>
                                <li class="cate-item--depth2"></li>
                            </ul>
                        </div>
                    </li>
                    <li class="cate-item--depth1">
                        <p class="cate__tit">스포츠/자동차/공구</p>
                        <div class="cate-item__expend">
                            <ul class="cate--depth2">
                                <!-- [반복] Depth2 -->
                                <li class="cate-item--depth2">
                                    <p class="cate__tit--depth2">노트북</p>
                                    <ul class="cate--depth3">
                                        <!-- [반복] Depth3 -->
                                        <!-- // -->
                                        <li class="cate-item--depth3"><a href="#">직구TV</a></li>
                                        <li class="cate-item--depth3"><a href="#">QLED TV</a></li>
                                        <li class="cate-item--depth3"><a href="#">80인치대</a></li>
                                        <li class="cate-item--depth3"><a href="#">70인치대</a></li>
                                        <li class="cate-item--depth3"><a href="#">50인치대</a></li>
                                        <li class="cate-item--depth3"><a href="#">43인치 이하</a></li>
                                        <li class="cate-item--depth3"><a href="#">LG전자</a></li>
                                        <li class="cate-item--depth3"><a href="#">삼성전자</a></li>
                                        <li class="cate-item--depth3"><a href="#">중소제조사</a></li>
                                        <li class="cate-item--depth3"><a href="#">최대10개</a></li>                            
                                    </ul>
                                </li>
                                <!-- // -->
                                <li class="cate-item--depth2"></li>
                                <li class="cate-item--depth2"></li>
                                <li class="cate-item--depth2"></li>
                                <li class="cate-item--depth2"></li>
                            </ul>
                        </div>
                    </li>
                    <li class="cate-item--depth1">
                        <p class="cate__tit">가구/유아동</p>
                        <div class="cate-item__expend">
                            <ul class="cate--depth2">
                                <!-- [반복] Depth2 -->
                                <li class="cate-item--depth2">
                                    <p class="cate__tit--depth2">노트북</p>
                                    <ul class="cate--depth3">
                                        <!-- [반복] Depth3 -->
                                        <!-- // -->
                                        <li class="cate-item--depth3"><a href="#">직구TV</a></li>
                                        <li class="cate-item--depth3"><a href="#">QLED TV</a></li>
                                        <li class="cate-item--depth3"><a href="#">80인치대</a></li>
                                        <li class="cate-item--depth3"><a href="#">70인치대</a></li>
                                        <li class="cate-item--depth3"><a href="#">50인치대</a></li>
                                        <li class="cate-item--depth3"><a href="#">43인치 이하</a></li>
                                        <li class="cate-item--depth3"><a href="#">LG전자</a></li>
                                        <li class="cate-item--depth3"><a href="#">삼성전자</a></li>
                                        <li class="cate-item--depth3"><a href="#">중소제조사</a></li>
                                        <li class="cate-item--depth3"><a href="#">최대10개</a></li>
                                    </ul>
                                </li>
                                <!-- // -->
                                <li class="cate-item--depth2"></li>
                                <li class="cate-item--depth2"></li>
                                <li class="cate-item--depth2"></li>
                                <li class="cate-item--depth2"></li>
                            </ul>
                        </div>
                    </li>
                    <li class="cate-item--depth1">
                        <p class="cate__tit">식품/건강</p>
                        <div class="cate-item__expend">
                            <ul class="cate--depth2">
                                <!-- [반복] Depth2 -->
                                <li class="cate-item--depth2">
                                    <p class="cate__tit--depth2">노트북</p>
                                    <ul class="cate--depth3">
                                        <!-- [반복] Depth3 -->
                                        <!-- // -->
                                        <li class="cate-item--depth3"><a href="#">직구TV</a></li>
                                        <li class="cate-item--depth3"><a href="#">QLED TV</a></li>
                                        <li class="cate-item--depth3"><a href="#">80인치대</a></li>
                                        <li class="cate-item--depth3"><a href="#">70인치대</a></li>
                                        <li class="cate-item--depth3"><a href="#">50인치대</a></li>
                                        <li class="cate-item--depth3"><a href="#">43인치 이하</a></li>
                                        <li class="cate-item--depth3"><a href="#">LG전자</a></li>
                                        <li class="cate-item--depth3"><a href="#">삼성전자</a></li>
                                        <li class="cate-item--depth3"><a href="#">중소제조사</a></li>
                                        <li class="cate-item--depth3"><a href="#">최대10개</a></li>
                                    </ul>
                                </li>
                                <!-- // -->
                                <li class="cate-item--depth2"></li>
                                <li class="cate-item--depth2"></li>
                                <li class="cate-item--depth2"></li>
                                <li class="cate-item--depth2"></li>
                            </ul>
                        </div>
                    </li>
                    <li class="cate-item--depth1">
                        <p class="cate__tit">생활/주방/반려</p>
                        <div class="cate-item__expend">
                            <ul class="cate--depth2">
                                <!-- [반복] Depth2 -->
                                <li class="cate-item--depth2">
                                    <p class="cate__tit--depth2">노트북</p>
                                    <ul class="cate--depth3">
                                        <!-- [반복] Depth3 -->
                                        <!-- // -->
                                        <li class="cate-item--depth3"><a href="#">직구TV</a></li>
                                        <li class="cate-item--depth3"><a href="#">QLED TV</a></li>
                                        <li class="cate-item--depth3"><a href="#">80인치대</a></li>
                                        <li class="cate-item--depth3"><a href="#">70인치대</a></li>
                                        <li class="cate-item--depth3"><a href="#">50인치대</a></li>
                                        <li class="cate-item--depth3"><a href="#">43인치 이하</a></li>
                                        <li class="cate-item--depth3"><a href="#">LG전자</a></li>
                                        <li class="cate-item--depth3"><a href="#">삼성전자</a></li>
                                        <li class="cate-item--depth3"><a href="#">중소제조사</a></li>
                                        <li class="cate-item--depth3"><a href="#">최대10개</a></li>
                                    </ul>
                                </li>
                                <!-- // -->
                                <li class="cate-item--depth2"></li>
                                <li class="cate-item--depth2"></li>
                                <li class="cate-item--depth2"></li>
                                <li class="cate-item--depth2"></li>
                            </ul>
                        </div>
                    </li>
                    <li class="cate-item--depth1">
                        <p class="cate__tit">명품/패션/화장품</p>
                        <div class="cate-item__expend">
                            <ul class="cate--depth2">
                                <!-- [반복] Depth2 -->
                                <li class="cate-item--depth2">
                                    <p class="cate__tit--depth2">노트북</p>
                                    <ul class="cate--depth3">
                                        <!-- [반복] Depth3 -->
                                        <!-- // -->
                                        <li class="cate-item--depth3"><a href="#">직구TV</a></li>
                                        <li class="cate-item--depth3"><a href="#">QLED TV</a></li>
                                        <li class="cate-item--depth3"><a href="#">80인치대</a></li>
                                        <li class="cate-item--depth3"><a href="#">70인치대</a></li>
                                        <li class="cate-item--depth3"><a href="#">50인치대</a></li>
                                        <li class="cate-item--depth3"><a href="#">43인치 이하</a></li>
                                        <li class="cate-item--depth3"><a href="#">LG전자</a></li>
                                        <li class="cate-item--depth3"><a href="#">삼성전자</a></li>
                                        <li class="cate-item--depth3"><a href="#">중소제조사</a></li>
                                        <li class="cate-item--depth3"><a href="#">최대10개</a></li>
                                    </ul>
                                </li>
                                <!-- // -->
                                <li class="cate-item--depth2"></li>
                                <li class="cate-item--depth2"></li>
                                <li class="cate-item--depth2"></li>
                                <li class="cate-item--depth2"></li>
                            </ul>
                        </div>
                    </li>
                </ul>
                <script>
                    $(function(){ // 헤더 > 카테고리 퍼블 테스트용
                        var $depth1 = $(".cate-all .cate-item--depth1");
                        var delayTimer;
                        var delayTime = 100;
                        $depth1.on({
                            "mouseenter" : function(){
                                var $t = $(this);
                                delayTimer = setTimeout(function(){
                                    $t.addClass("is--on").siblings().removeClass("is--on");
                                },delayTime)
                            },"mouseleave" : function(){
                                clearTimeout(delayTimer);
                            }
                        })
                    })
                </script>
                <!-- // -->
            </div>
            <!-- // -->                
        </div>
        <div class="lay-cate-all__dim" onclick="$('.lay-cate-all').addClass('is--hide');"></div>
    </div>
    <!-- // -->

    <!-- [C] 컨테이너  -->
    <div class="container">

        <!-- [C] 좌측윙 -->
        
        <!-- // -->

        <!-- [C] 우측윙 -->
        
        <!-- // -->

        

    <!-- </div>  -->
    <!-- // [HM] 메인 컨텐츠  -->
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

        if(jQuery("#search_arrow_bar")){
            jQuery('#search_arrow_bar').click(function(){
                toggleAutoMake();
                return false;// 20200302 임시처리 IncDetailTermDic.jsp
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
			jQuery(".sr-related__bnr").html(html);

			jQuery(".sr-related__bnr > a").click(function(){
				var url = $(this).attr("data-url");
				window.open(url);
			});

    	});
    }
    
    $(function(){ // GNB Sticky
        var position = $(window).scrollTop(); 
        var stickyHeader = function(){
            var $cont = $(".container"); // 컨텐츠 박스
            var $wing = $(".wing"); // 윙
            var $head = $("header.header, .wing"); // 헤더
            var scrTop = $(window).scrollTop(); // 현재 스크롤 위치
            if ( scrTop  > $head.offset().top + 103 ){
                $head.addClass("is--sticky");
                (scrTop > $cont.offset().top + 100 ) ? $head.addClass("is--show") : $head.removeClass("is--show")
            }else{
                $head.removeClass("is--sticky");
            }
        };       
        $(window).load(stickyHeader).scroll(stickyHeader);
    })
    
    //로그인 여부
	function islogin(){
		var cName = "LSTATUS";
		var s = document.cookie.indexOf(cName +'=');
		if (s != -1){
			s += cName.length + 1;
			e = document.cookie.indexOf(';',s);
			if (e == -1){
				e = document.cookie.length
			}
			if( unescape(document.cookie.substring(s,e))=="Y"){
				return true;
			}else{
				return false;
			}
		}else{
			return false;
		}
	}
    
    if(islogin()){
    	CmdMyArea();
    	CmdMyEmoney();
    }
    
    function CmdMyArea(){
    	loadUrl = "/main/main2018/ajax/get_main_myarea.jsp";

    	$.ajax({
    		url: loadUrl,
    		dataType: 'json',
    		async: true,
    		success: function(result){
    			$.each(result.MyInfo, function(i,v){
    				if(result.MyInfo[i].MyText){
    					$("#myid").html(result.MyInfo[i].MyText);
    				}
    				if(result.MyInfo[i].MyNewArticle == "Y"){
    					$(".icon__new").show();
    				}
    				if(result.MyInfo[i].MyKbcom){
    					$.each(result.MyInfo[i].MyKbcom, function(i2,v2){
    						var vGrade_eng = "";
    						if(result.MyInfo[i].MyKbcom[i2].member_grade == "1"){
    							vGrade_eng = "bronze";
    						}else if(result.MyInfo[i].MyKbcom[i2].member_grade == "2"){
    							vGrade_eng = "silver";
    						}else if(result.MyInfo[i].MyKbcom[i2].member_grade == "3"){
    							vGrade_eng = "gold";
    						}else if(result.MyInfo[i].MyKbcom[i2].member_grade == "4"){
    							vGrade_eng = "platinum";
    						}else if(result.MyInfo[i].MyKbcom[i2].member_grade == "5"){
    							vGrade_eng = "diamond";
    						}else if(result.MyInfo[i].MyKbcom[i2].member_grade == "6"){
    							vGrade_eng = "green";
    						}else if(result.MyInfo[i].MyKbcom[i2].member_grade == "7"){
    							vGrade_eng = "family";
    						}else if(result.MyInfo[i].MyKbcom[i2].member_grade == "8"){
    							vGrade_eng = "vip";
    						}

    						$("#myinfo_score").text(CommaFormattedN(result.MyInfo[i].MyKbcom[i2].score_sum));
    						$("#menu__tx--act").text(CommaFormattedN(result.MyInfo[i].MyKbcom[i2].score_sum));
    						$("#myinfo_ranking").text(result.MyInfo[i].MyKbcom[i2].member_ranking==""?"-":result.MyInfo[i].MyKbcom[i2].member_ranking);
    						$("#myinfo_grade").text(result.MyInfo[i].MyKbcom[i2].grade_name);
    						$("#myinfo_grade").addClass("ico-grade--"+vGrade_eng);
    						$("#header-top_grade").text(result.MyInfo[i].MyKbcom[i2].grade_name);
    						$("#header-top_grade").addClass("ico-grade--"+vGrade_eng);
    						
    					});
    					if(result.MyInfo[i].MyKbcom.length == 0){
    						$("#myinfo_score").text("0");
    						$("#menu__tx--act").text("0");
    						$("#myinfo_ranking").text("-");
    						$("#myinfo_grade").text("누리그린");
    						$("#myinfo_grade").addClass("ico-grade--green");
    						$("#header-top_grade").text("누리그린");
    						$("#header-top_grade").addClass("ico-grade--green");
    					}
    				}
    			});
    		}
    	});
    }

    function CmdMyEmoney(){
    	$.ajax({
    		type: "GET",
    		url: "/mobilefirst/emoney/emoney_get_point.jsp",
    		async: true,
    		dataType:"JSON",
    		success: function(json){
    			remain = json.POINT_REMAIN;	//적립금
    			$("#myinfo_emoney").text(CommaFormattedN(remain));
    			$("#menu__tx--emoney").text(CommaFormattedN(remain));
    			
    		}
    	});
    }
    
  	//콤마 옵션
    function CommaFormattedN(amount) {
        var delimiter = ",";
        var i = parseInt(amount);
        if(isNaN(i)) { return ''; }
        var minus = '';
        if (i < 0) { minus = '-'; }
        i = Math.abs(i);
        var n = new String(i);
        var a = [];
        while(n.length > 3)
        {
            var nn = n.substr(n.length-3);
            a.unshift(nn);
            n = n.substr(0,n.length-3);
        }

        if (n.length > 0) { a.unshift(n); }
        n = a.join(delimiter);
        amount = minus + (n+ "");
        return amount;
    }
  	
</script>
<jsp:include page="/join/join2009/IncJoin2015.jsp" flush="true">
    <jsp:param name="pagenm" value="<%=strPagenm%>"/>
</jsp:include>
