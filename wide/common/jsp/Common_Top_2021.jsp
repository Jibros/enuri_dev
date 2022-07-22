<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@page import="org.json.*"%>
<%@ page import="com.enuri.bean.log.Log_main_Proc"%>
<%@ page import="com.enuri.bean.log.Log_main_Data"%>
<%@ page import="com.enuri.bean.main.GNB_List_Proc"%>
<%@ page import="com.enuri.bean.main.GNB_List_Data"%>
<%@page import="com.enuri.util.http.CookieBean"%>
<%@page import="com.enuri.bean.main.Save_Goods_Proc"%>
<%@page import="com.enuri.bean.main.Sdul_Goods_Proc"%>
<%@page import="com.enuri.bean.main.Sdul_Member_Data"%>
<%@page import="com.enuri.bean.main.Sdul_Member_Proc"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<jsp:useBean id="Members_Data" class="com.enuri.bean.knowbox.Members_Data" scope="page" />
<jsp:useBean id="Members_Proc" class="com.enuri.bean.knowbox.Members_Proc" scope="page" />
<jsp:useBean id="GNB_List_Data" class="com.enuri.bean.main.GNB_List_Data" scope="page" />
<jsp:useBean id="GNB_List_Proc" class="com.enuri.bean.main.GNB_List_Proc" scope="page" />

<%
    String userAgentStr = "";

    if (request.getHeader("User-Agent") != null){
        userAgentStr = request.getHeader("User-Agent");
    }

    String strID = cb.GetCookie("MEM_INFO", "USER_ID");

    boolean IsLogin = false;

    if(cb.GetCookie("MEM_INFO","USER_ID").trim().length()> 0)
        IsLogin = true;

    /*즐겨찾기 이벤트 및 바탕화면 바로가기 이벤트를 위한 세션 처리*/
    String strEventRefererCheck = ChkNull.chkStr(request.getHeader("REFERER"),"");
    String strCate              = ChkNull.chkStr(request.getParameter("cate"),"");
    
    String strPageNm = ChkNull.chkStr(request.getParameter("pagenm"));      //페이지구분

    boolean bIsMain = false;
    if (request.getRequestURI().indexOf("Index.jsp") >= 0){
        strPageNm = "main";
        bIsMain = true;
    }
    
  	//성인인증 정보를 쿠키에서 가져온다.
    String isAdult = ChkNull.chkStr(cb.GetCookie("MEM_INFO", "ADULT"), "");
    String nowtime = new SimpleDateFormat("yyyyMMdd").format(new Date());

%> 
<script language=javascript src="/common/js/Log_Header.js?v=20210826"></script>
<script type="text/javascript" src="/common/js/common_top_2022.js?v=20220712"></script>
<!-- <link rel="stylesheet" type="text/css" href="/css/rev/header.css?v=20210930"/> -->
<style>
.header-cate__item > a .ico-cate--aircontrol {background-position:-60px 0 !important}
.header-cate__item > a .ico-cate--toy {background-position:-80px 0 !important}
</style>

<div id="wrap">
	<jsp:include page="/login/Inc_LoginTop_2015.jsp" flush="true"></jsp:include><!-- 로그인레이어 -->
    <iframe name="ifrmMainSearch" id="ifrmMainSearch" frameborder="0" style="position:absolute;height:0;width:0;z-index:0;"></iframe><!-- 구글 레이어 -->

    <!-- [C] 헤더 wrap -->
    <header class="header">
        <!-- [C] 헤더 탑 -->
        <div class="header-top">
            <div class="header-top__inner cont__inner">
                <!-- 헤더탑 탭 -->
                <ul class="header-top__tab">
                	<li class="is--new"><a href="https://www.enuri.com/my/eclub.jsp" onclick="insertLog(25698);" target="_blank">e클럽혜택</a></li>
                    <li><a href="/knowcom/index.jsp" onclick="insertLog(24209);" target="_blank">쇼핑지식</a></li>
                    <li><a href="/pick/pick_index.jsp" onclick="insertLog(26874);" target="_blank">기획전</a></li>
                    <li class="is--new"><a href="http://auto.enuri.com/" onclick="insertLog(24212);" target="_blank">자동차</a></li>
                    <li><a href="/enuripc/" target="_blank">조립PC</a></li>
                </ul>
                <!-- // 헤더 탭 -->

                <!-- 헤더탑 메뉴 -->
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
                            <i class="ico-grade ico-grade--sm " id="header-top_grade">VIP</i>
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
                                <div class="user-info__lay__detail">
                                    <div class="user-info__lay__row">
                                    	<a class="user-info--name" href="<%=strMyInfoUrl%>/member/info/infoPwChk.jsp" target="_blank" onclick="insertLog(24216);">
                                            <em id="myid"></em> 님
                                            <i class="ico-lock comm__sprite"></i>
                                        </a>
                                    </div>
                                    <div class="user-info__lay__row">
                                        <a href="/estore/estore.jsp" target="_blank" title="새 창에서 열립니다" onclick="insertLog(24222);" class="user-info--emoney">
                                            <dl>
                                                <dt>e머니</dt>
                                                <dd><em id="myinfo_emoney"></em></dd>
                                            </dl>
                                        </a>
                                        <a href="https://www.enuri.com/my/eclub.jsp?t=emoney" onclick="insertLog(25699);" class="ico-store comm__sprite" target="_blank">e머니 사용하기</a>
                                    </div>
                                    <div class="user-info__lay__row">
                                        <a href="/knowcom/mybox.jsp?tno=2" target="_blank" title="새 창에서 열립니다" onclick="insertLog(24223);" class="user-info--score">
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
                                    <button type="button" class="user-info__btn--logout comm__sprite" onclick="insertLog(24214);logout();">로그아웃</button>
                                </div>
                            </div>
                            <div class="header-top__lay--foot">
                            	<a href="https://www.enuri.com/my/my_enuri.jsp" target="_blank" title="새 창에서 열립니다">마이e클럽</a>
								<!--<a href="/knowcom/mybox.jsp?tno=4" target="_blank" title="새 창에서 열립니다" onclick="insertLog(24218);">최근 본 글</a>-->
								<a href="https://www.enuri.com/my/eclub.jsp" onclick="insertLog(25702)" target="_blank" title="새 창에서 열립니다">e클럽혜택</a>
								<a href="/knowcom/qna.jsp" target="_blank" title="새 창에서 열립니다" onclick="insertLog(24219);">쇼핑Q&A</a>
								<a href="<%=strMyInfoUrl%>/member/info/infoPwChk.jsp" target="_blank" title="새 창에서 열립니다" onclick="insertLog(24220);">개인정보관리</a>
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
                        <a href="/estore/estore.jsp" target="_blank" title="새 창에서 열립니다" onclick="insertLog(24222);">e머니 <em class="menu__tx--emoney" id="menu__tx--emoney"></em></a>
                    </li>
                    <!-- 로그인 : 쇼핑지식 활동점수 -->
                    <li class="is--login" style="<%=cb.GetCookie("MEM_INFO","USER_ID").trim().length()> 0 ? "":"display:none;"%>">
                        <a href="/knowcom/mybox.jsp?tno=2" target="_blank" title="새 창에서 열립니다" onclick="insertLog(24223);">활동점수 <em class="menu__tx--act" id="menu__tx--act"></em></a>
                    </li>
                    <!-- 로그아웃 : 로그인 버튼 -->
                    <li id='utilMenuLogin' class="is--logout" style="<%=cb.GetCookie("MEM_INFO","USER_ID").trim().length()> 0 ? "display:none;" : ""%>">
                        <a href="JavaScript:" onclick="setLogintopMygoods(4);Cmd_Login('');document.getElementById('divLoginLayer').style.zIndex='99997';insertLog(24213);"><i class="ico-login comm__sprite"></i> 로그인</a>
                    </li>
                    <!-- 로그아웃 : 회원가입 버튼 -->
                    <li id='utilMenuJoin' class="is--logout" style="<%=cb.GetCookie("MEM_INFO","USER_ID").trim().length()> 0 ? "display:none;" : ""%>">
                        <a href="JavaScript:" onclick="insertLog(24215);goJoin();"><i class="ico-join comm__sprite"></i> 회원가입</a>
                    </li>           
                    <li id="utilMenuAlarm">
                        <a href="JavaScript:"><i class="ico-alarm comm__sprite"></i> MY알림</a>
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
                                            <!-- <li><a href="/deal/newdeal/index.deal" target="_new" onclick="insertLog(24224);">소셜비교</a></li> -->
                                            <li><a href="https://www.enuri.com/my/eclub.jsp" target="_blank">e클럽혜택</a></li>
                                            <li><a href="/enuripc/" target="_blank" onclick="insertLog(24225);">조립PC</a></li>
                                            <li><a href="/global/Index.jsp" target="_new" onclick="insertLog(24226);">해외직구</a></li>
                                            <li><a href="/tour2012/Tour_Index.jsp" onclick="insertLog(24227);">여행비교</a></li>
                                            <li><a href="http://auto.enuri.com" onclick="insertLog(24228);">자동차</a></li>
                                        </ul>
                                        <ul class="sitemap__list">
                                            <li><a href="/view/shopBest.jsp" target="_blank" onclick="insertLog(24229);">쇼핑BEST</a></li>
                                            <li><a href="/view/move_mall.jsp" onclick="insertLog(24230);">이사견적</a></li>
                                            <li><a href="/view/Flower365.jsp" onclick="insertLog(24231);">꽃배달</a></li>
                                            <li><a href="/brandstore/recommand.jsp" onclick="insertLog(27675);">브랜드스토어</a></li>
                                        </ul>
                                    </dd>
                                </dl>
                                <dl class="sitemap__group group--comm">
                                    <dt>커뮤니티</dt>
                                    <dd>
                                        <ul class="sitemap__list">
                                            <li><a href="/knowcom/index.jsp" onclick="insertLog(24232);">쇼핑지식</a></li>
                                            <li><a href="/knowcom/news.jsp" onclick="insertLog(24233);">뉴스</a></li>
                                            <li><a href="/knowcom/guide.jsp" onclick="insertLog(24234);">구매가이드</a></li>
                                            <li><a href="/knowbox2/review/index.jsp" onclick="insertLog(24235);">사용기</a></li>
                                            <li><a href="/knowbox2/nuri/index.jsp" onclick="insertLog(24236);">자유게시판</a></li>
                                        </ul>
                                        <ul class="sitemap__list">
                                            <li><a href="/knowcom/enuritv.jsp" onclick="insertLog(24237);">에누리TV</a></li>
                                            <li><a href="/knowcom/eventzone.jsp" onclick="insertLog(24238 );">이벤트존</a></li>
                                            <li><a href="/knowcom/nurigo.jsp" onclick="insertLog(24239);">누리GO</a></li>
                                            <li><a href="/knowcom/qna.jsp" onclick="insertLog(24240);">쇼핑Q&amp;A</a></li>
                                            <li><a href="/pick/pick_index.jsp" onclick="insertLog(24241);">PICK</a></li>
                                        </ul>
                                    </dd>
                                </dl>
                            </div>
                            <div class="header-top__lay--foot">
                                <a href="/etc/Site_map.jsp" class="enuri_all" target="_new" onclick="insertLog(24242);">에누리 서비스 전체보기 <i class="ico-arrr comm__sprite"></i></a>
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
                <h1><a class="header-core__bi comm__sprite" href="/Index.jsp">에누리 가격비교</a></h1>
                <!-- 헤더 - 검색 -->
                <!-- .is--focused : input 포커스됨 ( 광고문구 가림 / 하단 레이어 활성화 / 저장된 검색어 노출 ) -->
                <!-- .is--active : input 값 입력됨 ( 광고문구 가림 / 연관검색어 노출 ) -->
                <jsp:include page="/search/Autocom_MainSearch_2021.jsp" />
                
                <!-- 헤더 - 카테고리 -->
                <div class="header-cate">
                	<!-- 버튼 : 전체카테고리 열기 -->
                    <button type="button" class="header-cate__btn--all" onclick="allMenuLayer();">
                        <i class="ico-cate--all comm__sprite"></i>
                        	<span>전체카테고리</span>
                        <i class="ico-cate--arrow-down comm__sprite"></i>
                    </button>
                    <ul class="header-cate__list">
                        <!-- <li class="header-cate__item"><a href="/list.jsp?cate=2401" onclick="insertLog(24246);"><i class="ico-cate ico-cate--aircontrol"></i>에어컨</a></li>
                        <li class="header-cate__item"><a href="/list.jsp?cate=1501" onclick="insertLog(24247);"><i class="ico-cate ico-cate--health"></i>건강식품</a></li>
                        <li class="header-cate__item"><a href="/list.jsp?cate=1024" onclick="insertLog(24248);"><i class="ico-cate ico-cate--toy"></i>장난감</a></li> -->
                        <% if( request.getServerName().equals("dev.enuri.com") ){ %>
                        <%@ include file="/common/jsp/Ajax_Gnb_ViewCate.jsp"%>
                        <%}else{ %>
                        <%@ include file="/wide/main/ajax/TopViewCate_2021.jsp"%>
                        <% }%>
                    </ul>
                    
                    <div class="lay-cate-all border-box is--hide">
                        <div class="lay-cate-all__inner">
                            <ul class="cate--depth1" id="gnbAllMenu"></ul>
                        </div>
                    </div>
                </div>
                <!-- // -->

                <!-- 헤더 - 우측광고 -->
                <div class="header-ad">
                    <!-- 배너 -->
                    <div id="bannerList"></div>
                    <!-- // -->                        
                    <button type="button" id="move_banner_left" class="header-ad__btn header-ad__btn--prev comm__sprite">이전</button>
                    <button type="button" id="move_banner_right" class="header-ad__btn header-ad__btn--next comm__sprite">다음</button>
                </div>
            </div>
        </div>
    </header>        
    <!-- // [C] 헤더 wrap -->        

    <!-- [레이어] 전체 카테고리 -->
    <%/*
    <div class="lay-cate-all is--hide">
        <div class="lay-cate-all__inner">
            <div class="lay-cate-all__head">
                전체 카테고리
                <!-- 버튼 : 닫기 -->
                <button class="lay-cate-all__btn" onclick="cls_cate_all();"><i class="ico-cls--big">닫기</i></button>
                <!-- // -->
            </div>
            <!-- [레이어] > 전체 카테고리 커스텀 -->
            <!-- 홈메인 > 전체 카테고리 와 마크업 동일합니다. -->
            <!-- template.html 참고 -->
            <div class="cate-all-old">
                <!-- 카테고리 리스트 -->
                <ul class="cate--depth1" id="gnbAllMenu">
                </ul>
                <!-- // -->
            </div>
            <!-- // -->                
        </div>
        <div class="lay-cate-all__dim" onclick="cls_cate_all();"></div>
    </div>
    <!-- // -->
    */
    %>
    



    <!-- [C] 컨테이너  -->
    <div class="container">

        <!-- [C] 좌측윙 -->
        
        <!-- // -->

        <!-- [C] 우측윙 -->
        <!-- // -->
		<%--@ include file="/common/jsp/include/IncRightWing_2021.jsp"--%>
    	<!-- [C] 컨텐츠영역  -->
        <!-- <div class="contents cont__inner">


        </div>

    </div> -->
    <!-- // [HM] 메인 컨텐츠  -->
<%
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
<script type="text/javascript" src="<%=ConfigManager.ENURI_COMMON%>/common/js/function.js?20210126"></script>
<script type="text/javascript" src="/common/js/exception_keyword.js"></script>
<script type="text/javascript" src="/common/js/incfavoritelayer.js"></script>
<script type="text/javascript" src="/common/js/incfavoritelayer_body.js"></script>
<script type="text/javascript" src="/common/js/eb/gnbTopRightBanner_2021.js"></script>
<script language="JavaScript">
    var IMG_ENURI_COM       = "<%=ConfigManager.IMG_ENURI_COM%>";
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
       	        	if (typeof(param_keyword) != 'undefined' && param_keyword.length>0){
       	        	}else{
       	        		banSrchKwdArea.text(json.SRCH_KWD_NM);
	       	        	//banSrchKwdArea.css("color", "#"+json.FONT_COLR_CD);
	       	        	if(json.FONT_BOLD_YN == "Y") {
	       	        		banSrchKwdArea.css("font-weight", "bold");
	       	        	}
       	        	}
   	        	}
   	        }
   	    });
   	    return json;
   	})();

    jQuery(document).ready(function(){
         if(location.pathname.split("/")[1] == "" || location.pathname.split("/")[1] == "Index.jsp"){
            enuriOneIdChk();
        }
    	if ('<%= strID%>' == 'yongcom') {
    		alert('사용 중인 기기에서 이벤트 \n부정참여가 발견되었습니다. \n법적 손해배상청구를 진행예정이오니 \n신속히 고객센터로 연락주십시오.\n\n [고객센터 02-6354-3601]');
    		setInterval(function(){ alert('사용 중인 기기에서 이벤트 \n 부정참여가 발견되었습니다. \n 법적 손해배상청구를 진행예정이오니 \n 신속히 고객센터로 \n 연락주십시오.\n\n [고객센터 02-6354-3601]');}, 20000);
    	}
    	if (typeof(param_keyword) != 'undefined' && param_keyword.length>0){
       	}else{
			jQuery("#search_keyword").val("");
    	}

        jQuery('body').on('click','.header-cate__btn--all', function(){
			jQuery(this).addClass('is--on');
			jQuery('.lay-cate-all').removeClass('is--hide').before('<div class="lay-cate-all-overlay"></div>')
		
			jQuery('body').on('click','.lay-cate-all-overlay', function(){
				jQuery('.header-cate__btn--all').removeClass('is--on');
				jQuery('.lay-cate-all').addClass('is--hide');
				jQuery(this).remove();
			})
		});
    });
    //키보드 문자키 입력 시 검색창 포커싱
    /*var target_input = jQuery('#search_keyword'); // 포커스 인풋
    var chk_short = true;

    jQuery(document).bind("keydown keyup", function(e) {
        var key = e.keyCode;
        var tg = e.target;
        if(tg.tagName == "INPUT" ||  tg.tagName == "TEXTAREA") return true;
        var specific = key >= 48 && key <= 90;
        if(e.type == "keydown") {
            if(!specific) {
                chk_short = false;
                return true;
            }

            if(specific && chk_short) {
            	if(key!=116 && key!=123)  target_input.focus().select();
            	else {
            		  chk_short = false;
                      return true;
            	}
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
    });*/

    jQuery("input, textarea").bind("blur", function() {
        chk_short = true;
    });

    //검색창 내 배너
    getMainTopBanner();
    function getMainTopBanner(){
    	var loadUrl = "http://ad-api.enuri.info/enuri_PC/pc_home/B3/req";
    	jQuery.getJSON(loadUrl,function(json){

    		var html = "<a href='javascript:///' data-url='"+json.JURL1+"'>";
    			html +="<img src='"+json.IMG1+"' alt=''>";
    			html +="</a>";
			jQuery(".sr-related__bnr").html(html);

			jQuery(".sr-related__bnr > a").click(function(){
				var url = jQuery(this).attr("data-url");
				window.open(url);
			});

    	});
    }
    
    jQuery(function(){ // GNB Sticky
        var position = jQuery(window).scrollTop(); 
        var stickyHeader = function(){
            var $cont = jQuery(".container"); // 컨텐츠 박스
            var $wing = jQuery(".wing"); // 윙
            var $head = jQuery("header.header, .wing"); // 헤더
            var scrTop = jQuery(window).scrollTop(); // 현재 스크롤 위치
            if ( scrTop  > $head.offset().top + 103 ){
                $head.addClass("is--sticky");
                (scrTop > $cont.offset().top + 100 ) ? $head.addClass("is--show") : $head.removeClass("is--show")
            }else{
                $head.removeClass("is--sticky");
            }
        };       
        jQuery(window).on({
            "load" : stickyHeader,
            "scroll" : stickyHeader
        })
    })
    function enuriOneIdChk(){
        var returnFlag = false;
        var confirmFlag = false;
        if(islogin()){
            var today = <%=nowtime%>;
            //var yesterDay = new Date(new Date().setDate(today.getDate()-1));
            var blEnuriOneIdConfirm = false;
            if(location.pathname.split("/")[1] == "" || location.pathname.split("/")[1] == "Index.jsp"){
                if( localStorage.getItem("enuri_one_chk") !== null){
                    var obj = JSON.parse(localStorage.getItem("enuri_one_chk"));
                    var tmpObj = obj["<%=cb.GetCookie("MEM_INFO","USER_ID")%>"];
                    if(tmpObj == null){
                        blEnuriOneIdConfirm = true;
                    }else{
                        if(tmpObj < today) blEnuriOneIdConfirm = true;
                    }
                }else{
                    blEnuriOneIdConfirm = true;
                }
            }else{
                blEnuriOneIdConfirm = true;
            }
            if(blEnuriOneIdConfirm) {
                $.ajax({
                    type : "POST",
                    url : "/my/api/enuriOneIDCheck.jsp",
                    async : false,
                    dataType : "JSON",
                    success : function(json){
                        if(json.result.userid != "" && !json.result.checked){
                            if(confirm("여러 개의 계정을 하나의 에누리 계정으로 통합하여 편리하게 서비스를 이용해보세요.")){
                                location.href = "<%=strMyInfoUrl%>/my/enuriOneID.jsp";
                            }
                        }else{
                            returnFlag = true;
                        }
                    },complete : function(json){
                         if( localStorage.getItem("enuri_one_chk") !== null){
                            var obj = JSON.parse(localStorage.getItem("enuri_one_chk"));
                            obj[json.responseJSON.result.userid] = today;
                         }else{
                             var obj = new Object();
                             obj[json.responseJSON.result.userid] = today;
                         }
                        localStorage.setItem("enuri_one_chk",JSON.stringify(obj))
                    }        
                });
            }
        }
        return returnFlag;
    }
</script>
<jsp:include page="/join/join2009/IncJoin2015_rev.jsp" flush="true"/>