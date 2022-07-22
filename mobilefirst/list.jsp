<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.main.Mobile_Category_Proc"%>
<%@ page import="com.enuri.bean.main.Mobile_Category_Data"%>
<%@ page import="com.enuri.bean.mobile.Mobile_Today_Proc"%>
<%@ page import="com.enuri.bean.mobile.Mobile_Today_Data"%>
<jsp:useBean id="Model_log_Proc" class="com.enuri.bean.logdata.Model_log_Proc" scope="page" />
<%@ page import="com.enuri.bean.lsv2016.Goods_Search_Lsv_Proc"%>
<%@ page import="com.enuri.bean.lsv2016.Goods_Search_Lsv_Data"%>
<jsp:useBean id="Goods_Search_Lsv" class="com.enuri.bean.lsv2016.Goods_Search_Lsv_Proc" scope="page" />


<%
	if(true){
	response.sendRedirect("/m/list.jsp?"+request.getQueryString()+"");
	return;
	}

	String strCate = ChkNull.chkStr(request.getParameter("cate"),"00000000");		//카테고리
	String strCateNm = ChkNull.chkStr(request.getParameter("cateName"),"");	    //카테고리명
	String strMCate = "";
	String strSubCate = "";
	int cPage = ChkNull.chkInt(request.getParameter("page"),1);					//현재페이지
	String strKey = ChkNull.chkStr(request.getParameter("key"),"popular DESC");	//정렬
	String strInKeyword = ChkNull.chkStr(request.getParameter("in_keyword"),"");//결과내검색, 키워드
	String strKeyword = ChkNull.chkStr(request.getParameter("keyword"),"");//결과내검색, 키워드
	String strSKeyword = ChkNull.chkStr(request.getParameter("skeyword"),"");	//분류검색어
	String strStartPrice = ChkNull.chkStr(request.getParameter("start_price"));	//가격대 검색 _ 시작값
	String strEndPrice = ChkNull.chkStr(request.getParameter("end_price"));		//가격대 검색 _ 끝값
	String strMPrice = ChkNull.chkStr(request.getParameter("m_price"));			//가격대검색 값
	String strGetFactory = ChkNull.chkStr(request.getParameter("factory"));		//제조사
	String strGetBrand = ChkNull.chkStr(request.getParameter("brand"));		//브랜드
	String strSpec = ChkNull.chkStr(request.getParameter("spec"));  		 	//사양선택
	String strSelSpec = ChkNull.chkStr(request.getParameter("sel_spec"));
	String strfrom = ChkNull.chkStr(request.getParameter("from"),"");			//넘어온 페이지 search에서 넘어올 경우 처리
	String strGseq = ChkNull.chkStr(request.getParameter("gseq"),"");
	String adultVal = cb.GetCookie("MEM_INFO", "ADULT");						//성인 쿠키값
	boolean boolAdult = false;

	if(adultVal.equals("1")){
		boolAdult = true;																				//성인인증 여부 확인
	}

	String AdultPopUpCookie = "";				//성인 인증 쿠키
	Cookie[] myCookies = request.getCookies();    //생성된 쿠키를 가져온다.

	if(myCookies != null && myCookies.length > 0){
		for(int i= 0; i<myCookies.length;i++){
			Cookie c = myCookies[i];
			String cName = c.getName();
			if(cName.equals("showAdultAuth")) {
				AdultPopUpCookie = c.getValue();
				break;
			}
		}
	}

	//스마트쇼핑 from=st 처리
	if(strfrom.equals("swt")){
	    cb.setCookie_One("FROM",strfrom);
	    cb.SetCookieExpire("FROM",-1);
	    cb.responseAddCookie(response);
	}

	Cookie[] carr = request.getCookies();

	String strAd_id = "";
	String strVerios = "";

	try {
		for(int i=0;i<carr.length;i++){
		    if(carr[i].getName().equals("adid")){
		    	strAd_id = carr[i].getValue();
		    	break;
		    }
		}
		for(int i=0;i<carr.length;i++){
		    if(carr[i].getName().equals("verios")){
		    	strVerios = carr[i].getValue();
		    	break;
		    }
		}
	} catch(Exception e) {
	}

	if(strCate.equals("00000000")){
		strCate = "0304";
	}

	// 사용 분류 확인
	boolean useCategory = Goods_Search_Lsv.IsUseLPCategory(strCate);
	// 예외분류를 루트로 보내도록 처리
	if(strCate.equals("9101") || strCate.equals("9501")) {
		useCategory = false;
	}

	if(!useCategory) {
		response.sendRedirect("/");
		return;
	}

	//카테고리명(중분류)
	Mobile_Category_Proc mobile_category_proc = new Mobile_Category_Proc();
	Mobile_Category_Data[] mobile_category_name_data = mobile_category_proc.Mobile_Category_Name_N(strCate);

	String strCate2 = "";
	String strCate4 = "";
	String strCate6 = "";
	String strCate8 = "";
	String strCate10 = "";

	String strCateNM2 = "";
	String strCateNM4 = "";
	String strCateNM6 = "";
	String strCateNM8 = "";
	String strCateNM10 = "";
	String strCateNM6_Group = "";

	if(strCate.length() > 2){
		strMCate = strCate.substring(0,4);

		if(strSubCate.length() > 0){
		   strCateNm = Category_Proc.getData_Name(CutStr.cutStr(strCate,4)+"01"+strSubCate,4);
	    }else if(mobile_category_name_data != null && mobile_category_name_data.length > 0 ){
	    	if(!mobile_category_name_data[0].getM_group_cacode().equals("")){
    			String strMgroup = mobile_category_name_data[0].getM_group_cacode();
	    		if(strMgroup.length() >= 6){
	    			strMgroup = mobile_category_name_data[0].getM_group_cacode().substring(0,6);

		    		Mobile_Category_Data[] mobile_Gcate_data = mobile_category_proc.Mobile_getGroupName(strMgroup);
		    		if(mobile_Gcate_data != null && mobile_Gcate_data.length > 0 ){
		    			strCateNM6_Group = mobile_Gcate_data[0].getC_name();
		    			if(strCateNM6_Group.indexOf("_") >-1){
		    				strCateNM6_Group = strCateNM6_Group.substring(0, strCateNM6_Group.indexOf("_"));
		    			}
		    		}
	    		}
	    	}
	    	if(strCate.length() > 1){
	    		strCateNM2 = mobile_category_name_data[0].getC_name2();
	    		strCateNm = strCateNM2;
	    		strCate2 = strCate.substring(0,2);
	    	}
	    	if(strCate.length() > 3){
	    		strCateNM4 = mobile_category_name_data[0].getC_name4();
	    		strCateNm = strCateNM4;
	    		strCate4 = strCate.substring(0,4);
			}
	    	if(strCate.length() > 5){
	    		strCateNM6 = mobile_category_name_data[0].getC_name6().replaceAll("<br>", "");
				if(strCateNM6.indexOf("_") > 0){
					strCateNM6 = strCateNM6.substring(0, strCateNM6.indexOf("_"));
				}
				if(strCateNM6_Group.length() > 0 && !strCateNM6_Group.equals(strCateNM6)){
					strCateNm = strCateNM6_Group+"_"+strCateNM6;
				}else{
					strCateNm = strCateNM6;
				}
				strCateNM6 = strCateNm;
				strCate6 = strCate.substring(0,6);
	    	}
			if(strCate.length() > 7){
				strCateNM8 = mobile_category_name_data[0].getC_name8().replaceAll("<br>", "");
				if(strCateNM8.indexOf("_") > 0){
					strCateNM8 = strCateNM8.substring(0, strCateNM8.indexOf("_"));
				}
				//strCateNm = strCateNM8;
				strCate8 = strCate.substring(0,8);
	    	}
			if(strCate.length() > 9){
				strCateNM10 = mobile_category_name_data[0].getC_name10().replaceAll("<br>", "");
				if(strCateNM10.indexOf("_") > 0){
					strCateNM10 = strCateNM8.substring(0, strCateNM10.indexOf("_"));
				}
				strCateNm = strCateNM10;
				//strCate10 = strCate.substring(0,10);
			}
		}
	}
	//카테고리명(전부)
	String strCate_name_all = Category_Proc.Category_Name_One(strCate).replaceAll(">","/").replaceAll(" ","");

	String serverName = request.getServerName();

	String strServerName = "";

	if( serverName.indexOf("dev.enuri.com")>-1) {
		strServerName = "dev";
	}

	String M_Ip = request.getRemoteAddr();

	// 떠있는 레이어(기획전 페이지 이동)

	Mobile_Today_Proc mobile_today_proc = new Mobile_Today_Proc();
	Mobile_Today_Data[] mobile_today_data = mobile_today_proc.getSpecialLayer(strCate4, strServerName);

	boolean bSpecial_Layer = false; 	//하단 플루팅 배너 노출 여부
	boolean bSpecial_Layer_Ex = false; 	//하단 플루팅 배너 추가 변태 예외 노출 여부
	String strToday_id = "";
	String strToday_title = "";
	String strBgcolor = "";

 	boolean b11stevent = false;	//하단 플로팅 배너 11번가

	if(mobile_today_data != null){
		strToday_id 	= mobile_today_data[0].getToday_id();
		strToday_title 	= mobile_today_data[0].getToday_title();
		strBgcolor	= mobile_today_data[0].getBgcolor();
		if(strBgcolor.trim().length() > 0){
			bSpecial_Layer = true;
		}
	}else{
		/*
		mobile_today_data = mobile_today_proc.getSpecialLayer("0501", strServerName);
		if(mobile_today_data != null){
			strToday_id 	= mobile_today_data[0].getToday_id();
			strToday_title 	= mobile_today_data[0].getToday_title();
			strBgcolor	= mobile_today_data[0].getBgcolor();
			bSpecial_Layer = true;
			if(strToday_id.equals("20160705111111")){
				bSpecial_Layer = false;
			}
		}else{
			strToday_id 	= "20160705111111";
			strToday_title 	= "여름을 싹~ 통합기획전";
			strBgcolor	= "#0057b4";
			bSpecial_Layer = false;
		}
		*/
		//2016-12-13 예외처리 하단 플루팅
		//2017-01-09 예외처리 하단 플루팅
		bSpecial_Layer_Ex = true;
	}

	String RightMenuFactory = "Y", RightMenuBrand = "Y";
	try {
		if (strCate4.length() > 0) {
			if (strCate4.length() >= 4) {
				Goods_Search_Lsv_Proc  goods_search_lsv_proc = new Goods_Search_Lsv_Proc();
				int[] showCntList = goods_search_lsv_proc.getCategorySpecShowNum(strCate4);
				Goods_Search_Lsv_Data optionInfo = goods_search_lsv_proc.getSearchOptionSet(strCate4);
				RightMenuFactory = optionInfo.getTab_factory_flag().equals("1") ? "Y" : "N";
				RightMenuBrand = optionInfo.getTab_brand_flag().equals("1") ? "Y" : "N";
			}
		}
	} catch (Exception e) {
	}

	//meta tag 설정 2018-12-10
	// 카테고리 정보 보여주기
	Category_Proc category_proc = new Category_Proc();
	String cateName = "";
	if(strCate.length()>=4) {
		cateName = category_proc.getData_Catename(strCate.substring(0, 4), 2);
	}

	String titleStr = "'"+cateName + "' 최저가 검색 - 에누리가격비교";

	String metaDescript = "";
	String metaKeyword = "";

	String catePathName = "";
	String lastCatename = "";
	String cateLMname = "";	//대중만 meta keywords에 사용

	if(strCate.length()>=2) {
		for(int i=1; i<=(strCate.length()/2); i++) {
			String subCateName = category_proc.getData_Catename(strCate.substring(0, i*2), i);

			if(i>1) catePathName += " > ";
			if(i< 3){
				if(cateLMname.equals("")){
					cateLMname = subCateName;
				}else{
					cateLMname += ", "+ subCateName;
				}
			}
			catePathName += subCateName;
			lastCatename = subCateName;
		}
	}

	//metaDescript = catePathName;
	//마지막 분류의 카테명으로 수정. 2018-12-10
	metaDescript = "'"+ cateName + "'의 최저가 정보 및 종류별 제품의 모든 정보를 자세히 안내해 드립니다.";

	/*
	메타테그 수정. 2018-12-10
	metaKeyword = catePathName + ",";
	Enuri_Keyword_Proc enuri_keyword_proc = new Enuri_Keyword_Proc();
	Enuri_Keyword_Data[] enuri_keyword_data = enuri_keyword_proc.getKeywordsFromCate(strCate, 10);
	if(enuri_keyword_data!=null && enuri_keyword_data.length>0) {
		for(int i=0; i<enuri_keyword_data.length; i++) {
			metaKeyword += enuri_keyword_data[i].getEnuri_keyword() + ",";
		}
	}
	*/
	metaKeyword += cateLMname+", 인기상품, 가격비교, 상품추천, 최저가";

%>
<%!
public static boolean isEventFinish(){
	String endDateString = "2017-08-06 23:59:59";
	SimpleDateFormat formater = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	Date endDate = null;
	try {
		endDate = formater.parse(endDateString);

	} catch (ParseException e){

	}
	if(endDate == null){
		return true;
	}
	else
		return new Date().getTime() > endDate.getTime();
}
public static boolean is11stFinish(){
	String endDateString = "2017-09-27 23:59:59";
	SimpleDateFormat formater = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	Date endDate = null;
	try {
		endDate = formater.parse(endDateString);

	} catch (ParseException e){

	}
	if(endDate == null){
		return true;
	}
	else
		return new Date().getTime() > endDate.getTime();
}
%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />

	<!-- DNS prefetch 테스트 -->
	<meta http-equiv="x-dns-prefetch-control" content="on" />
	<link rel="dns-prefetch" href="//enuri.com" />
	<link rel="dns-prefetch" href="//storage.enuri.info" />
	<link rel="dns-prefetch" href="//adimg.daumcdn.net" />
	<link rel="dns-prefetch" href="//img.enuri.com" />
	<link rel="dns-prefetch" href="//photo3.enuri.com" />
	<link rel="dns-prefetch" href="//ad-api.enuri.info" />
	<link rel="dns-prefetch" href="//www.mallree.com" />
	<link rel="dns-prefetch" href="//storage.enuri.gscdn.com" />
	<link rel="dns-prefetch" href="//image.enuri.info" />
	<link rel="dns-prefetch" href="//img.enuri.info" />

	<meta name="description" content="<%=metaDescript%>">
	<meta name="keyword" content="<%=metaKeyword%>">
	<meta property="og:title" content="에누리 가격비교">
	<meta property="og:description" content="에누리 모바일 가격비교">
	<meta property="og:image" content="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/images/logo_enuri.png">
	<meta name="format-detection" content="telephone=no" />
	<title><%=titleStr%></title>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery.tmpl.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery.lazyload.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/spin.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/swiper.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery.paging.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery.easy-paging.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/banner_list.js"></script>
	<script type="text/javascript" src="/lsv2016/js/logTailFunc.js?v=20181231"></script>
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/home/default.css"/>
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/home/lp.css?v=20200211"/>
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/home/swiper.css"/>
	<link rel="canonical" href="http://m.enuri.com/mobilefirst/list.jsp?cate=<%= strCate %>"/>
	<script>
	(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
		(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
		m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
		})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
	</script>
	<script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
	<script>
	(adsbygoogle = window.adsbygoogle || []).push({
	google_ad_client: "pub-6805902076937187",
	enable_page_level_ads: true
	});
	</script>
	<!-- Global site tag (gtag.js) - Google Ads: 966646648 -->
	<script async src="https://www.googletagmanager.com/gtag/js?id=AW-966646648"></script>
	<script>
	  window.dataLayer = window.dataLayer || [];
	  function gtag(){dataLayer.push(arguments);}
	  gtag('js', new Date());
	  gtag('config', 'AW-966646648');
	</script>
</head>
<%@ include file="/mobilefirst/include/common_top.jsp" %>
<%
if(strApp.equals("Y") && (ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") < 0 && strVerios.indexOf("3.0.2.") > -1 )){
	bSpecial_Layer = false;
	bSpecial_Layer_Ex = false;
}
if(strToday_id.equals("20170914141826") || strToday_id.equals("20170914070707") ){
	if(!is11stFinish()){
		b11stevent = true;
		bSpecial_Layer = false;
		bSpecial_Layer_Ex = false;
	}
}
//bSpecial_Layer = false;
%>

<%
try{
	//Model_log_Proc.Mobile_Cate_log_Insert(output, M_Ip, strCate);
	//Model_log_Proc.Mobile_Cate_log_Insert2(output, M_Ip, strCate, loginCheck_strID);
	Model_log_Proc.Mobile_Cate_log_Insert5(output, M_Ip, strCate, loginCheck_strID, strAd_id);
} catch(Exception e) {
}
%>
<body>
<%if(bSpecial_Layer){%>
<div class="app_miniPop" style="z-index:10;" onclick="head_banner_go()">
	<div class="app_main_mini">
	<img src="http://img.enuri.info/images/mobilefirst/planlist/B_<%=strToday_id%>/B_<%=strToday_id%>_banner.jpg" onerror="$('.evtgo').css({'background':'url(http://img.enuri.info/images/mobilefirst/planlist/B_<%=strToday_id%>/B_<%=strToday_id%>_banner.jpg)  center 0 no-repeat <%=strBgcolor%>'}).css('background-size','320px 50px');" style="display:none;">
	<a href="javascript:///" class="evtgo" style="text-indent:-9999em;width:100%;background:url(http://img.enuri.info/images/mobilefirst/planlist/B_<%=strToday_id%>/B_<%=strToday_id%>_banner.jpg) center 0 no-repeat <%=strBgcolor%>;background-size: 320px 50px;">APP신규설치자용</a>
	</div>
</div>
<%}else if(b11stevent){%>
	<div class="app_miniPop" style="z-index:10;" onclick="head_banner_go_11st()">
		<div class="app_main_mini">
		<img src="http://img.enuri.info/images/mobilefirst/planlist/B_<%=strToday_id%>/B_<%=strToday_id%>_banner.jpg" onerror="$('.evtgo').css({'background':'url(http://img.enuri.info/images/mobilefirst/planlist/B_<%=strToday_id%>/B_<%=strToday_id%>_banner.jpg)  center 0 no-repeat <%=strBgcolor%>'}).css('background-size','320px 50px');" style="display:none;">
		<a href="javascript:///" class="evtgo" style="text-indent:-9999em;width:100%;background:url(http://img.enuri.info/images/mobilefirst/planlist/B_<%=strToday_id%>/B_<%=strToday_id%>_banner.jpg) center 0 no-repeat <%=strBgcolor%>;background-size: 320px 50px;"></a>
		</div>
	</div>
<%}else if(bSpecial_Layer_Ex){%>
	<%if(!isEventFinish()){%>
		<div class="app_miniPop" style="z-index:10;" onclick="head_banner_go_ex()">
			<div class="app_main_mini">
			<a href="javascript:///" class="evtgo" style="text-indent:-9999em;width:100%;background:url(http://img.enuri.info/images/mobilefirst/planlist/event_summer201707.jpg) center 0 no-repeat #42BEF2;background-size: 247px 57px;">여름기획전</a>
			</div>
		</div>
	<%}%>
<%} if(!strCate.equals("") && strCate.length() >= 4 && strCate.substring(0, 4).equals("1640") && !boolAdult && !AdultPopUpCookie.equals("false")){%>
 <div class="lay_adult_wrap dim" style="z-index:9999" id="isAdultPopUp">
	<div class="lay_adult_gate">
		<div class="lay_img">
			<img src="http://img.enuri.info/images/home/adult/@adult_gate.jpg" alt="">
		</div>
		<div class="lay_info">
			<span class="txt_tit">본 페이지는 <em>성인인증</em>이 필요합니다.</span>
			<button class="btn_cert_adult" id="adult_login">인증 후 상품확인</button>
		</div>
		<button class="btn_close_gate" id="turnOffBtn" onclick="turnOff(this.id)">닫기</button>
	</div>
 </div>
<%}%>

<div id="wrap">
	<%@include file="/mobilefirst/renew/include/gnb2.html"%>
	<%@ include file="/mobilefirst/ad_bridge.jsp"%>
	<input type="hidden" id="cate" name="cate" value="<%=strCate%>">
	<input type="hidden" id="page" name="page" value="<%=cPage%>">
	<input type="hidden" id="key" name="key" value="<%=strKey%>">
	<input type="hidden" id="start_price" name="start_price" value="<%=strStartPrice%>">
	<input type="hidden" id="end_price" name="end_price" value="<%=strEndPrice%>">
	<input type="hidden" id="m_price" name="m_price" value="<%=strMPrice%>">
	<input type="hidden" id="okeyword" name="okeyword" value="<%=strKeyword%>">
	<input type="hidden" id="inkeyword" name="inkeyword" value="<%=strInKeyword%>">
	<input type="hidden" id="auto_keyword" name="auto_keyword" value="<%=strSKeyword%>">
	<input type="hidden" id="factory" name="factory" value="<%=strGetFactory%>">
	<input type="hidden" id="brand" name="brand" value="<%=strGetBrand%>">
	<input type="hidden" id="sel_spec" name="sel_spec" value="<%=strSelSpec%>">
	<input type="hidden" id="spec" name="spec" value="<%=strSpec%>">
	<input type="hidden" id="from" name="from" value="<%=strfrom%>">
	<input type="hidden" id="gseq" name="gseq" value="<%=strGseq%>">
	<input type="hidden" id="applist" name="applist" value="<%=strApp%>">
	<div id="loadingLayer" style="display:none;position:absolute;z-index:999999;width:1px;height:1px;"></div>
	<!-- pc최저가 레이어 -->
	<div class="dim" id="onlypc" style="display:none;">
		<div class="pc_layer">
			<p>에누리 PC웹으로 접속 시 더 저렴하게<br />구매 가능합니다.<br />찜 하신 후 PC웹으로 접속해<br />구매해주세요</p>
			<ul class="btnarea">
				<li>찜하기</li>
				<li onclick="$('#onlypc').hide();">닫기</li>
			</ul>
		</div>
	</div>
	<!-- 필터검색 -->
	<div  id="filter_search" >
		<div class="filter_box">
			<!-- 필터검색 전체보기 -->
			<div class="filter_area allview" id="filter_all">
				<a href="#" class="ico_m back" onclick="$('#filter_all').hide();">이전</a>
				<h2>제조사<em>10</em></h2>
				<ul class="list_align">
					<li class="on">인기순</li>
					<li>가나다순</li>
				</ul>
				<p class="allview_search"><input type="text" placeholder="제조사명을 입력하세요."/></p>
				<div class="detail_sch" id="allview_search">
					<ul>
						<li class="chk">삼성 (455)</li>
						<li>LG(34)</li>
						<li class="chk">애플 (42)</li>
						<li>팬택(20)</li>
						<li>삼성 (455)</li>
						<li>LG(34)</li>
						<li>애플 (42)</li>
						<li>팬택(20)</li>
					</ul>
				</div>
			</div>
			<!--// 필터검색 전체보기 -->

			<!-- 검색 -->
			<div class="filter_area" >
				<h2>상세검색</h2>
				<a href="#" class="ico_m filter_close">닫기</a>
				<div class="detail_sch">
					<!-- 션택카테고리 -->
					<div class="tag_scroll" style="display:none;">
						<div class="tag_area">
							<ul class="s_tag">
							</ul>
						</div>
					</div>
					<!--// 션택카테고리 -->

					<ul class="sch_list">
						<li id="sch_factory"><a href="javascript:;">제조사<span></span></a>
							<div class="sub">
								<ul>
								</ul>
								<button class="all" onclick="CmdFilterAll('f');$('#filter_all').show();">전체보기</button>
							</div>
						</li>
						<li id="sch_brand"><a href="javascript:;">브랜드<span></span></a>
							<div class="sub">
								<ul>
								</ul>
								<button class="all" onclick="CmdFilterAll('b');$('#filter_all').show();">전체보기</button>
							</div>
						</li>
						<div id="sch_spec">
						</div>
					</ul>

					<dl class="result_sch">
						<dt>결과 내 검색</dt>
						<dd><input type="text"  id="srhKeyword"/></dd>
						<dt>가격대 검색</dt>
						<dd><span class="box"><input type="text"  id="srhPrice_s" maxlength="10" /></span><span class="txt">~</span><span class="box"><input type="text" id="srhPrice_e" maxlength="10"/></span></dd>
					</dl>
				</div>
			</div>
			<!--// 검색 -->

			<ul class="sch_btn">
				<li id="sch_refresh"><em>초기화</em></li>
				<li id="sch_go"  onclick="ga('send', 'event', 'mf_lp', 'lp_filter', 'lp_적용');"><em>적용</em></li>
			</ul>
		</div>
		<div class="mask"></div>
	</div>
	<!--// 필터검색 -->

	<!-- 헤더영역 -->

	<nav class="page_breadcrumb">
		<div class="top_location"><%if(strCateNM2.length() > 0) {%><%=strCateNM2%><%}%>
			<%if(strCateNM4.length() > 0) {%><span class="arrow">&gt;</span><a href="javascript:///" onclick="CmdList('<%=strCate4%>');"><%=strCateNM4%></a><%}%>
			<%if(strCateNM6.length() > 0) {%><span class="arrow">&gt;</span><a href="javascript:///" onclick="CmdList('<%=strCate6%>');"><%=strCateNM6%></a><%}%>
			<%if(strCateNM8.length() > 0) {%><span class="arrow">&gt;</span><a href="javascript:///" onclick="CmdList('<%=strCate8%>');"><%=strCateNM8%></a><%}%>
		</div>
		<div id="foldingCate" class="folding_cate">
		</div>
	</nav>
	<!--// 헤더영역 -->


	<!-- 미카테고리 -->
	<section class="cate_area">
		<div class="small_cate">
			<div class="scll">
			</div>
		</div>
		<p class="bnr" style="display:none;"><img src="" alt="" /></p>
	</section>
	<!--// 미카테고리 -->


	<!-- LP리스트 -->
	<section class="lp_area">
		<%if(strfrom.equals("search")) {
			if(!strInKeyword.equals("") && strSKeyword.equals("")){
				strSKeyword = strInKeyword;
			}
		%>
		<div class="search_mnt">본 화면은<span>'<%=strSKeyword%>'</span>상품만 보여지는 카테고리 페이지 입니다.
			<% if(request.getQueryString().toString().indexOf("&gseq=") < 0 ) { %>
			<button class="btn_result" onClick="document.location.href='/mobilefirst/search.jsp?from=list&cate2=<%=strCate%>&keyword=<%=strSKeyword%>'">검색결과</button>
			<%}else{%>
			<button class="btn_result" onClick="document.location.href='/mobilefirst/search.jsp?from=list&cate2=<%=strCate%>&gseq=<%=strGseq%>&keyword=<%=strSKeyword%>'">검색결과</button>
			<%}%>
		</div>
		<%}%>
		<div class="tag_scroll2" style="display:none;">
			<div class="tag_area">
				<ul class="s_tag" style="display:none;">
				</ul>
			</div>
		</div>
		<!-- 중소분류 -->
		<section class="sort_list" style="display:none;">
			<!-- 중분류 -->
			<div class="mdl_sort">
				<div class="scll">
					<ul>
						<li data-id="tab01"><a href="javascript:///">제조사</a></li>
						<li data-id="tab02"><a href="javascript:///">브랜드</a></li>
						<li data-id="tab03" style="display:none;"><a href="javascript:///"></a></li>
						<li data-id="tab04" style="display:none;"><a href="javascript:///"></a></li>
						<li data-id="tab05" style="display:none;"><a href="javascript:///"></a></li>
						<li data-id="tab06" style="display:none;"><a href="javascript:///"></a></li>
						<li data-id="tab07" style="display:none;"><a href="javascript:///"></a></li>
						<li data-id="tab08" style="display:none;"><a href="javascript:///"></a></li>
						<li data-id="tab09" style="display:none;"><a href="javascript:///"></a></li>
						<li data-id="tab10"><a href="javascript:///">상세검색</a></li>
					</ul>
				</div>
			</div>

			<!-- 소분류 -->
			<div class="contarea" id="tab01">
				<div class="swiper-container sm_name sw_tab01">
					<ul class="swiper-wrapper">
					</ul>
					<div class="swiper-pagination"></div>
				</div>
			</div>
			<div class="contarea" id="tab02">
				<div class="swiper-container sm_name sw_tab02">
					<ul class="swiper-wrapper">
					</ul>
					<div class="swiper-pagination"></div>
				</div>
			</div>
			<div class="contarea" id="tab03">
				<div class="swiper-container sm_name sw_tab03">
					<ul class="swiper-wrapper">
					</ul>
					<div class="swiper-pagination"></div>
				</div>
			</div>
			<div class="contarea" id="tab04">
				<div class="swiper-container sm_name sw_tab04">
					<ul class="swiper-wrapper">
					</ul>
					<div class="swiper-pagination"></div>
				</div>
			</div>
			<div class="contarea" id="tab05">
				<div class="swiper-container sm_name sw_tab05">
					<ul class="swiper-wrapper">
					</ul>
					<div class="swiper-pagination"></div>
				</div>
			</div>
			<div class="contarea" id="tab06">
				<div class="swiper-container sm_name sw_tab06">
					<ul class="swiper-wrapper">
					</ul>
					<div class="swiper-pagination"></div>
				</div>
			</div>
			<div class="contarea" id="tab07">
				<div class="swiper-container sm_name sw_tab07">
					<ul class="swiper-wrapper">
					</ul>
					<div class="swiper-pagination"></div>
				</div>
			</div>
			<div class="contarea" id="tab08">
				<div class="swiper-container sm_name sw_tab08">
					<ul class="swiper-wrapper">
					</ul>
					<div class="swiper-pagination"></div>
				</div>
			</div>
			<div class="contarea" id="tab09">
				<div class="swiper-container sm_name sw_tab09">
					<ul class="swiper-wrapper">
					</ul>
					<div class="swiper-pagination"></div>
				</div>
			</div>
			<div class="contarea" id="tab10">
				<div class="swiper-container sm_name sw_tab10">
				<ul class="swiper-wrapper">
					<li class="swiper-slide">
						<div class="detailSort">
							<p>
								<label for="srhRe">결과 내 검색</label>
								<span class="inSearch">
									<input type="text" id="srhRe">
									<button type="button" class="del">검색어 삭제</button>
								</span>
								<button class="search_chk" onclick="CmdInSearch();">조회</button>
							</p>
							<p>
								<label for="srhPrice">가격대 검색</label>
								<span class="inForm">
									<span><input type="text" id="srhPrice"><button type="button" class="del">검색어 삭제</button></span><span style="width:20px;"> ~</span>
									<span><input type="text" id="srhPrice2"><button type="button" class="del">검색어 삭제</button></span>
								</span>
								<button class="search_chk" onclick="CmdPriceSearch();">조회</button>
							</p>
						</div>
					</li>
				</ul>
				<div class="swiper-pagination"></div>
			</div>
			</div>
			<span class="more openMask"><em>더보기</em></span>

			<div class="relate"  id="relate_txt" style="display:none;">
				<div class="relate_area" >
					<ul>
					</ul>
				</div>
				<span class="reset"><em>초기화</em></span>
			</div>
		</section>



		<!--// 중소분류 -->
		<!-- <ul class="lp_tab">
			<li>제조사</li>
			<li>브랜드</li>
			<li>상세검색</li>
			<li class="openMask">상품상세검색</li>
		</ul>-->

		<div class="lp_list">
			<!-- 상품정렬 -->
			<div class="sort_opt srpview">
				<p>1,809개 상품</p>
				<span class="sort">
					<select title="상품정렬 선택">
						<option value="popular DESC" selected="" >인기상품순</option>
						<option value="c_date DESC">신제품순</option>
						<option value="minprice3">낮은 가격순</option>
						<%if(strCate4.equals("1471") || strCate4.equals("1472") || strCate4.equals("1473")  || ( (strCate4.equals("1482")  || strCate4.equals("1483")  || strCate4.equals("1484")  || strCate4.equals("1485") ) )){%>
						<option value="price DESC" <%if(strKey.equals("price DESC")){%> selected <%}%>>높은 가격순</option>
						<%}else{%>
						<option value="minprice3 DESC">높은 가격순</option>
						<%}%>
						<option value="sale_cnt DESC">판매량순</option>
						<option value="bbs_num DESC">상품평 많은순</option>
						<option value="newGoods">출시예정상품</option>
					</select>
				</span>
				<button type="button" class="btnview">상품 목록형식 보기</button>
				<button type="button" class="btnsrp openMask">상품상세검색</button>
			</div>
			<!-- //상품정렬 -->

			<!-- 200102 SR#37608 네이버 파워쇼핑 추가 -->
			<div class="comm_ad ad_powershopping mobile" style="display:none;">
				<div class="comm_ad_tit">
					<em>파워쇼핑</em>
					<a href="http://m.searchad.naver.com/product/shopProduct" class="comm_btn_apply" target="_blank">신청하기</a>
				</div>
				<div class="comm_ad_list ad_goods swiper-container">
					<ul class="swiper-wrapper">
						<!-- 광고 상품 1개  x 6 반복 -->
					</ul>
					<div class="swiper-scrollbar"></div>
				</div>
				<script>

				</script>
			</div>
			<!-- // 네이버 파워쇼핑 추가 -->

			<!-- 상품리스트 -->
			<ul class="prodList" id="prodListUl">

			</ul>
			<div class="loading"><span>로딩중입니다...</span>잠시만 기다려 주십시오.</div>
			<!--// 상품리스트 -->
			<div class="no_txt" style="display:none;"><p>검색결과가 없습니다.</p></div>
		</div>

		<ul class="paging" id="paging" style="display:none;">
			<li></li>
	        <li>#n</li>
	        <li>#n</li>
	        <li>#c</li>
	        <li>#n</li>
	        <li>#n</li>
	        <li></li>
		</ul>
		<%@ include file="/mobilefirst/edplatform/ebay_cpc.jsp"%>
		<%@ include file="/infoad/include/getInfoAd_Item_mobile.jsp"%>
	</section>
	<!--// LP리스트 -->

	<!-- 200102 SR#37608 파워클릭 수정 : -->
	<!-- mobile에는 mobile클래스 붙여주세요. -->
	<!-- 모바일 하단 파워클릭에는 .ad_slide붙여주세요 -->
	<div class="comm_ad ad_powerclick ad_slide mobile" data-type="bottom" style="display:none">
		<div class="comm_ad_tit">
			<em>파워클릭</em>
			<a href="https://m.searchad.naver.com/product/shopProduct" class="comm_btn_apply cpcgo" target="_blank">신청하기</a>
		</div>
		<div class="comm_ad_list ad_goods swiper-container">
			<ul class="swiper-wrapper">
			<!-- 광고 상품 1개  x 6 반복 -->
			</ul>
			<div class="swiper-scrollbar"></div>
		</div>
	</div>

	<!-- 200102 SR#37608 파워링크 수정-->
	<!-- mobile에는 mobile클래스 붙여주세요. -->
	<div class="comm_ad ad_powerlink mobile" data-type="bottom" style="display:none">
		<div class="comm_ad_tit">
			<em>파워링크</em>
			<a href="https://m.searchad.naver.com/product/shopProduct" class="comm_btn_apply" target="_blank">신청하기</a>
		</div>
		<div class="comm_ad_list ad_link">
			<ul>
				<!-- 광고 1개  x 10개 반복 -->
			</ul>
		</div>
	</div>

	<!-- 소셜 인기상품
	<div class="con_box">
		<h3>소셜 인기상품<a href="#" class="more">더보기</a></h3>
		<div class="hit_scroll">
			<div class="hit_List_area">
				<ul class="hit_product">
				</ul>
			</div>
		</div>
	</div> -->
	<!--// 소셜 인기상품 -->
	<%@ include file="/mobilefirst/include/inc_ctu.jsp"%>
	<%@ include file="/mobilefirst/include/inc_ad_guide.jsp"%>
	<ul class="paging second" id="paging2" style="display:none;">
		<li></li>
        <li>#n</li>
        <li>#n</li>
        <li>#c</li>
        <li>#n</li>
        <li>#n</li>
        <li></li>
	</ul>
	<ul class="paging second">
		<script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
		<!-- M_LP_bottom_DA -->
		<ins class="adsbygoogle"
		     style="display:inline-block;width:320px;height:50px"
		     data-ad-client="pub-6805902076937187"
		     data-ad-slot="5895439952"></ins>
		<script>
		     (adsbygoogle = window.adsbygoogle || []).push({});
		</script>
	</ul>
	<%@ include file="/mobilefirst/renew/include/footer.jsp"%>
	<%@ include file="/mobilefirst/resentzzim/zzimListInc.jsp"%>
	<iframe name=infoUrl id=infoUrl src="" width=0 height=0 frameborder=0 marginheight=0 marginwidth=0 scrolling=auto style=visible:false></iframe>
</div><!--// lp_wrap -->

<script>
var szCategoryPower = "<%=strCate%>";
var ad_commandPower = encodeURIComponent("");					//검색어
var ad_commandPower2 = encodeURIComponent("<%=strCateNm%>");	//카테이름
var catePower = "<%=strCate%>";
var referrerPower = encodeURIComponent(document.referrer);
var urlPower = encodeURIComponent(document.URL);
var vAppyn = getCookie("appYN");
var rFactory = "<%=RightMenuFactory%>";
var rBrand = "<%=RightMenuBrand%>";
var isAdult = "<%=boolAdult%>";

$(document).ready(function(){
		if(vAppyn == "Y"){
			$("header").hide();
		}
		CmdFilterBox();
		lpViewType();
		//소분류명
		/* var swiper = new Swiper('.sm_name', {
			pagination: '.swiper-pagination',
			paginationClickable: true
		 });
*/
		//중소분류
		$(".contarea").hide();
		$(".mdl_sort li:first").addClass("on").show();
		$(".contarea:first").show();

		$(".mdl_sort li").click(function() {
			$(".mdl_sort li").removeClass("on");
			$(this).addClass("on");
			$(".contarea").hide();


			if(activeTab== "1"){
				ga('send', 'event', 'mf_lp', 'lp_common', 'click_제조사탭');
			}else if(activeTab== "2"){
				ga('send', 'event', 'mf_lp', 'lp_common', 'click_브랜드탭');
			}else if(activeTab== "10"){
				ga('send', 'event', 'mf_lp', 'lp_common', 'click_상세검색탭');
			}else{
				ga('send', 'event', 'mf_lp', 'lp_common', 'click_속성탭');
			}
			var activeTab = $(this).attr("data-id");
			$("#"+activeTab).fadeIn();

			//var swiper = new Swiper('.sm_name', {
			//pagination: '.swiper-pagination',
			//paginationClickable: true
			//});
			swiper = undefined;
			$("#"+activeTab+" span:first").click();
			setTimeout(function(){
				 swiper = new Swiper('.sw_'+activeTab, {
						pagination: '.sw_'+activeTab+' .swiper-pagination',
						paginationClickable: true,
						onSlideChangeStart : function(swiper){
							var index = swiper.activeIndex;
				            $('.sw_'+activeTab+' .swiper-pagination-bullets span').removeClass('swiper-pagination-bullet-active');
				            $('.sw_'+activeTab+' .swiper-pagination-bullets  span:eq(' + index + ')').addClass('swiper-pagination-bullet-active');
						}
					 });
			},500);

			return false;
		});

		//중카테 레이어 모션 (20181001 JSH)
		var foldCateState = false,							// 레이어 상태
			foldCateTop = $(".top_location").outerHeight();	// 현재카테고리 위치 영역 높이만큼 메뉴 레이어를 위에서 띄어줌. "top:49px"

		$("div.cate_layer > a").click(function() {
			var foldCate = $(this).attr("href");

			$(foldCate).css("top", foldCateTop);

			if($(foldCate).html().length < 10){
				cmdOpenList();
			}
			if($(".cate_type").css("display")=="block"){
				foldCateState=false;
			}
			if(!foldCateState){
				$(foldCate).children(".dimm").fadeIn();
				$(foldCate).slideDown();
				foldCateState = true;
			}else{
				$(foldCate).children(".dimm").fadeOut();
				$(foldCate).slideUp();
				foldCateState = false;
			}

			// dimm 클릭시,
			$(".dimm").click(function(){
				$(foldCate).children(".dimm").fadeOut();
				$(foldCate).slideUp();
				foldCateState = false;
			});

			return false;
			/*
			$(this).next(".open_list").toggle();
			if($(".open_list").is(":visible")){
				$(".open_list").hide();
			}else{
				$(".open_list").show();
				ga('send', 'event', 'mf_lp', 'lp_GNB', 'GNB_카테고리');
			}
			if($(".open_list").html().length < 10){
				cmdOpenList();
			}
			//	return false;
			*/
		});
		$("div.cate_layer > ul > li").click(function() {
			$(this).parent().hide().parent("div.cate_layer").children("a").text($(this).text());
		});
		$(".cate_layer .logo").click(function(){
			ga('send', 'event', 'mf_lp', 'lp_GNB', 'GNB_home');
			goHome();
		})	;

		$(".srp").click(function(){
			$("#searchWrap").show();
			$(".sch_box_area").show();
			searchLockScroll();
			ga('send', 'event', 'mf_lp', 'lp_GNB', 'GNB_검색');
		});
		/*
		//탭top스크롤
		var nav = $('.lp_tab, .mainTop');
			$(window).scroll(function () {
			if ($(this).scrollTop() > 300) {
				nav.addClass("topnav");
				} else {
				nav.removeClass("topnav");
			}
		});
		*/

		//탭top스크롤 -> 상단 영역 스크롤 시, 새로 만든 메뉴도 같이 이동, ".page_breadcrumb" 영역 추가 (20181001 JSH)
		var nav = $('.lp_tab, .mainTop, .page_breadcrumb');
			$(window).scroll(function () {
			if ($(this).scrollTop() > 300) {
				nav.addClass("topnav");
			} else {
				nav.removeClass("topnav");
			}
		});

		$(".lp_tab li").click(function (e){
			e.preventDefault();
			wrapWindowByMask();
			//CmdFilterBox();

			if($(this).text() == "제조사"){
				$(".detail_sch").scrollTop(0);
				$("#sch_factory .sub").show();
				$("#sch_brand .sub").hide();
				$("#sch_factory a").addClass("on");
				$("#sch_brand a").removeClass("on");
				ga('send', 'event', 'mf_lp', 'lp_common', 'click_제조사탭');
			}else if($(this).text() == "브랜드"){
				$(".detail_sch").scrollTop(0);
				$("#sch_factory .sub").hide();
				$("#sch_brand .sub").show();
				$("#sch_factory a").removeClass("on");
				$("#sch_brand a").addClass("on");
				ga('send', 'event', 'mf_lp', 'lp_common', 'click_브랜드탭');
			}else if($(this).text() == "상세검색"){
				$("#sch_factory .sub").hide();
				$("#sch_brand .sub").hide();
				$("#srhKeyword").focus();
				$("#sch_factory a").removeClass("on");
				$("#sch_brand a").removeClass("on");
				ga('send', 'event', 'mf_lp', 'lp_common', 'click_상세검색탭');
			}
		})	;
		//상품 목록형식
		//리스트형 : 1, 갤러리형 : 2 (setcookie)
		$( ".lp_list .btnview").click(function() {
			if($(".lp_list").hasClass("grid")){
				$(".lp_list").removeClass("grid");
				fnListSetCookie_tmp("listGridType", 1);
				ga('send', 'event', 'mf_lp', 'lp_common', 'lp_리스트뷰');
			}else {
				$(".lp_list").addClass("grid").siblings().removeClass("grid");
				fnListSetCookie_tmp("listGridType", 2);
				ga('send', 'event', 'mf_lp', 'lp_common', 'lp_갤러리뷰');
			}
			return false;
		});
		$(".btn_result").click(function() {
			ga('send', 'event', 'mf_lp', 'lp_common', 'click_go srp');
			ga('send', 'event', 'mf_lp', 'lp_common', 'click_통합검색 버튼');
		});
		/*필터검색bg*/
		function wrapWindowByMask(){
			var maskHeight = $(document).height();
			var maskWidth = $(window).width();
			$('.mask').css({'width':maskWidth,'height':maskHeight});
			$('.mask').fadeTo("fast",0.5);
			$('.filter_box').fadeTo("fast",1);
			$('.filter_box').show();
			$(".open_list").hide();
		}

		$('.openMask').click(function(e){
			e.preventDefault();
			wrapWindowByMask();
			CmdFilterBox();
			$(".detail_sch").scrollTop(0);
			$("#sch_spec .sub").hide();

			$(".sch_list > li > a").removeClass("on");
			$(".sch_list > div > li > a").removeClass("on");

			if($("#tab01").is(":visible")){
				$("#sch_factory .sub").show();
				$("#sch_brand .sub").hide();
			}else if($("#tab02").is(":visible")){
				$("#sch_factory .sub").hide();
				$("#sch_brand .sub").show();
			}else if($("#tab10").is(":visible")){
				$("#sch_factory .sub").hide();
				$("#sch_brand .sub").hide();
				$("#srhKeyword").focus();
			}else{
				$("#sch_factory .sub").hide();
				$("#sch_brand .sub").hide();

				var aTab = $(".mdl_sort div ul li");

				$.each(aTab, function(i,v){
					if($("[data-id='tab0"+i+"']").hasClass("on")){
						$("#"+i+" > a").click();
					}
				});

			}

			CmdCopyArr();
			//ga('send', 'event', 'mf_lp', 'lp_common', 'click_필터');
			if($(this).hasClass("more")){
				ga('send', 'event', 'mf_lp', 'lp_common', 'click_더보기');
			}else{
				ga('send', 'event', 'mf_lp', 'lp_common', 'click_필터');
			}
		});

		//닫기 버튼
		$('.filter_close').click(function (e) {
			e.preventDefault();
			$('.mask, .filter_box').hide();
		});

		//딤
		$('.mask').click(function () {
			$(this).hide();
			$('.filter_box').hide();
		});
	});

	var vSpecial_Layer = "<%=strToday_id%>";

	if(vSpecial_Layer.length > 0){
		$("#app_miniPop").hide();
	}else{
		if(vAppyn == "Y"){
			$("#app_miniPop").show();
		}
	}

	/*
	$(document).on('touchstart', function() {
    	setTimeout(function(){
    		$(".app_miniPop").hide();
    	}, 300);
	});
	*/

	$(window).scroll(function(){
    	setTimeout(function(){
    		$(".app_miniPop").hide();
    	}, 300);
	});

	/*
	$(".app_miniPop").on('click', function(){
		alert(2);
		if(vSpecial_Layer.length > 0){
			if(vSpecial_Layer == "20160705111111"){
				ga('send', 'event', 'mf_lp', '플로팅배너', '여름기획전');
			}else{
				ga('send', 'event', 'mf_lp', 'CM_planbanner', 'plan_'+vSpecial_Layer);
			}
			location.href = "/mobilefirst/planlist.jsp?t=B_"+vSpecial_Layer;
		}
	});
	*/
	//LP View Type 세팅
	//리스트형 : 1, 갤러리형 : 2
	function lpViewType(viewType){
		var cListGridType = getCookie("listGridType");
		if(cListGridType){
			if(cListGridType == 1){
				$(".lp_list").removeClass("grid");
			}else{
				$(".lp_list").addClass("grid");
			}
		}else{
			if(viewType == "1"){
				$(".lp_list").removeClass("grid");
			}else if(viewType == "2"){
				$(".lp_list").addClass("grid");
			}
		}
	}
	function head_banner_go(){
		if(vSpecial_Layer.length > 0){
			if(vSpecial_Layer == "20160705111111"){
				ga('send', 'event', 'mf_lp', '플로팅배너', '여름기획전');
			}else{
				ga('send', 'event', 'mf_lp', 'CM_planbanner', 'plan_'+vSpecial_Layer);
			}
			location.href = "/mobilefirst/planlist.jsp?t=B_"+vSpecial_Layer;
		}
	}

	function head_banner_go_ex(){
		ga('send', 'event', 'mf_lp', '플로팅배너', '2017 여름기획전');
		location.href = "/mobilefirst/evt/summer_201707.jsp?freetoken=event";
	}
	function head_banner_go_11st(){
		window.open("http://www.11st.co.kr/connect/Gateway.tmall?method=Xsite&tid=1001161302&freetoken=outlink");
	}
	//쿠키 날짜 대로
	function fnListSetCookie_tmp( name, value, expiredays )
	{
		var todayDate = new Date();
		todayDate.toGMTString();
		todayDate.setDate( todayDate.getDate() + expiredays );
		document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
	}
	function fnListSetCookie(name,value,path) {
		 var expires = "";
		 var date = new Date();
		 var midnight = new Date(date.getFullYear(), date.getMonth(), date.getDate(), 23, 59, 59);
		 expires = "; expires=" + midnight.toGMTString();
		 if (!path) {
		  path = "/";
		 }
		 document.cookie = name + "=" + value + expires + "; path=" + path;
	}

	var GA_Title = "mf_카테고리목록_new";

	<%if(strfrom.equals("search")) { %>
		GA_Title  = "mf_카테고리목록(분류검색어)_new";
	<%}%>

	ga('send', 'pageview', {	'page': '/mobilefirst/list.jsp',	'title': GA_Title	});

	_TRK_CP = "<%=strCate_name_all %>";

</script>
<script type="text/javascript" src="/mobilefirst/js/powerShoppingMo.js?v=20200122"></script>
<script type="text/javascript" src="/mobilefirst/js/powerLinkMo.js?v=20200122"></script>
<script type="text/javascript" src="/mobilefirst/js/list2.js?v=20200210"></script>
<%@ include file="/mobilefirst/include/common_logger.html"%>
</body>
</html>
