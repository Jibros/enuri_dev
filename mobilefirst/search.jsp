<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.main.Mobile_Category_Proc"%>
<%@ page import="com.enuri.bean.main.Mobile_Category_Data"%>
<jsp:useBean id="Srp_Log_Pc_Proc" class="com.enuri.bean.logdata.Srp_Log_Pc_Proc" scope="page" />

<%
if(true){
	response.sendRedirect("/m/search.jsp?"+request.getQueryString()+"");
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
	String strfrom = ChkNull.chkStr(request.getParameter("from"),"");			//넘어온 페이지 list에서 넘어올 경우 처리


	//스마트쇼핑 from=st 처리
	if(strfrom.equals("swt")){
	    cb.setCookie_One("FROM",strfrom);
	    cb.SetCookieExpire("FROM",-1);
	    cb.responseAddCookie(response);
	}

	if(strCate.equals("00000000")){
		//strCate = "0304";
	}

	strKeyword = HtmlStr.removeHtml(strKeyword);

	if (CutStr.cutStr(strKeyword,2).equals("%u")){
		strKeyword = CvtStr.unescape(strKeyword);
	}
	if (strKeyword.indexOf("%u") >= 0 || strKeyword.indexOf("%20") >= 0){
		strKeyword = CvtStr.unescape(strKeyword);

	}else if(strKeyword.indexOf("%25") >= 0){
		strKeyword = CvtStr.unescape(CvtStr.unescape(strKeyword));
	}

	//카테고리명(중분류)
	Mobile_Category_Proc mobile_category_proc = new Mobile_Category_Proc();
	Mobile_Category_Data[] mobile_category_name_data = mobile_category_proc.Mobile_Category_Name(strCate);

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

	if(strCate.length() > 2){
		if(strCate.length() > 3){
			strMCate = strCate.substring(0,4);
		}else{
			strMCate = strCate;
		}

		if(strSubCate.length() > 0){
		   strCateNm = Category_Proc.getData_Name(CutStr.cutStr(strCate,4)+"01"+strSubCate,4);
	    }else if(mobile_category_name_data != null && mobile_category_name_data.length > 0 ){
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
	    		strCateNM6 = mobile_category_name_data[0].getC_name6();
				if(strCateNM6.indexOf("_") > 0){
					strCateNM6 = strCateNM6.substring(0, strCateNM6.indexOf("_"));
				}
				strCateNm = strCateNM6;
				strCate6 = strCate.substring(0,6);
	    	}
			if(strCate.length() > 7){
				strCateNM8 = mobile_category_name_data[0].getC_name8();
				if(strCateNM8.indexOf("_") > 0){
					strCateNM8 = strCateNM8.substring(0, strCateNM8.indexOf("_"));
				}
				//strCateNm = strCateNM8;
				strCate8 = strCate.substring(0,8);
	    	}
			if(strCate.length() > 9){
				strCateNM10 = mobile_category_name_data[0].getC_name10();
				if(strCateNM10.indexOf("_") > 0){
					strCateNM10 = strCateNM8.substring(0, strCateNM10.indexOf("_"));
				}
				strCateNm = strCateNM10;
				//strCate10 = strCate.substring(0,10);
			}
		}
	}

	String strTmpId = cb.GetCookie("MYINFO","TMP_ID");
	String M_Ip = request.getRemoteAddr();
	String userid = cb.GetCookie("MEM_INFO","USER_ID");

	Cookie[] carr = request.getCookies();
	String strAd_id = "";

	try {
		for(int i=0;i<carr.length;i++){
		    if(carr[i].getName().equals("adid")){
		    	strAd_id = carr[i].getValue();
		    	break;
		    }
		}
	} catch(Exception e) {
	}

	try{
		boolean return_aa = Srp_Log_Pc_Proc.srpLogMobileInsert( strTmpId,  userid,  M_Ip,  strKeyword,  strAd_id);
	} catch(Exception e) {
	}


	if(!strfrom.equals("list") && !strfrom.equals("searchOrg")) {
%>

<%@ include file="/mobilefirst/include/inc_searchgolistpage.jsp"%>
<%
	}

	//meta tag 설정 2018-12-10
	String titleStr = "'"+strKeyword+"' 최저가 검색 - 에누리가격비교";
	String metaDescript = "'"+ strKeyword +"'의 최저가 정보 및 종류별 제품의 모든 정보를 자세히 안내해 드립니다.";
	String metaKeyword = "";
%><%@ include file="/lsv2016/include/IncSearch.jsp"%><%
	int intCsearchcnt = 0; 	//10개면 멈춤
	Search_Category_Proc search_category_proc = new Search_Category_Proc();

	String strLinkageWords[] = search_category_proc.getLinkageWordList(strKeyword);
	String strLinkageKeyword = "";

	//out.println("strLinkageWords.legnth="+strLinkageWords.length);

	if(strLinkageWords!=null && strLinkageWords.length>0) {
		int intCnt = 0;
		for(int sci=0; sci<strLinkageWords.length; sci++) {
			if(!strKeyword.equals(strLinkageWords[sci])) {
				if(intCnt>0) {
					strLinkageKeyword += ", ";
				}
				strLinkageKeyword += strLinkageWords[sci];
				intCnt++;

				intCsearchcnt++;
				if(intCsearchcnt > 8) break;
			}
		}
	}

	try {
		CSearch csearch = new CSearch();
		csearch.setIntPortSet(intEtcPortSet); //port
		csearch.setStrCollectionName(strAutoMakerCollectionName); //컬렉션명
		csearch.setStrHostSet(etcHostSet); //검색엔진 주소
		csearch.setStrUserIp(request.getRemoteAddr());
		csearch.setStrKeyword(strKeyword);
		csearch.setNPageSize(10);
		String strAutoMakerTemp = csearch.CSearchRunSmartMaker(); //실제 검색
		String astrAutoMakerTemp[] = strAutoMakerTemp.split("\\^");

		String strAutoMakerTemp2 = "";
		int intAutoMakeWCnt = 0;
		for(int i=0; i<astrAutoMakerTemp.length; i++) {
			if(CutStr.cutStr(astrAutoMakerTemp[i],2).equals("W:")) {
				boolean bWCheck = false;
				for(int j=0; j<i; j++) {
					if(CutStr.cutStr(astrAutoMakerTemp[j],2).equals("W:")) {
						if(astrAutoMakerTemp[i].equals(astrAutoMakerTemp[j])) {
							bWCheck = true;
						}
					}
				}
				boolean bAdultKeyword = false;
				String strAdultKeyword = "성인용품,자위,콘돔,딜도";
				String[] strArrayAdultKeyword = strAdultKeyword.split(",");
				for(int ai=0; ai<strArrayAdultKeyword.length; ai++) {
					if(astrAutoMakerTemp[i].indexOf(strArrayAdultKeyword[ai])>=0) {
						bAdultKeyword = true;
						break;
					}
				}
				if(!bWCheck && !bAdultKeyword && astrAutoMakerTemp[i].trim().length()<=10 && intAutoMakeWCnt<10 && !strKeyword.toUpperCase().equals(ReplaceStr.replace(astrAutoMakerTemp[i].toUpperCase(),"W:",""))) {
					if(strLinkageKeyword.trim().length()>0) {
						strLinkageKeyword += ", ";
					}
					strLinkageKeyword += ReplaceStr.replace(astrAutoMakerTemp[i],"W:","");
					intAutoMakeWCnt++;

					intCsearchcnt++;
					if(intCsearchcnt > 8) break;
				}
			}
		}
	} catch(Exception e) {
	} finally {
	}

	String strLinkageWords2[] = search_category_proc.getLinkageWordListByEnuriKeyword(strKeyword);
	if(strLinkageWords2!=null && strLinkageWords2.length>0) {
		int intCnt2 = 0;
		for(int sci2=0; sci2<strLinkageWords2.length; sci2++) {
			if(!strKeyword.equals(strLinkageWords2[sci2]) && strLinkageWords2[sci2].trim().length()<=8) {
				if(strLinkageKeyword.trim().length()>0) {
					strLinkageKeyword += ", ";
				}
				strLinkageKeyword += strLinkageWords2[sci2];
				intCnt2++;

				intCsearchcnt++;
				if(intCsearchcnt > 9) break;
			}
		}
	}

	metaKeyword = strKeyword +", "+ strLinkageKeyword;
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
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/home/default.css">
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/home/swiper.css">
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/home/lp.css?v=20200211"/>
	<link rel="canonical" href="http://m.enuri.com/mobilefirst/search.jsp?keyword=<%=strKeyword %>" />
	<title><%=titleStr%></title>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery.tmpl.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery.lazyload.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/spin.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/swiper.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery.paging.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery.easy-paging.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/banner_list.js"></script>
	<script type="text/javascript" src="/lsv2016/js/logTailFunc.js"></script>
	<script>
	(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
		(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
		m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
		})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
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
<body>
<div id="wrap">
	<%@ include file="/mobilefirst/include/common_top.jsp" %>
	<%@include file="/mobilefirst/renew/include/gnb.html"%>
	<%@ include file="/mobilefirst/ad_bridge.jsp"%>
	<input type="hidden" id="cate" name="cate" value="<%=strCate%>">
	<input type="hidden" id="select_cate" name="select_cate">
	<input type="hidden" id="page" name="page" value="<%=cPage%>">
	<input type="hidden" id="key" name="key" value="<%=strKey%>">
	<input type="hidden" id="start_price" name="start_price" value="<%=strStartPrice%>">
	<input type="hidden" id="end_price" name="end_price" value="<%=strEndPrice%>">
	<input type="hidden" id="m_price" name="m_price" value="<%=strMPrice%>">
	<input type="hidden" id="okeyword" name="okeyword" value="<%=strKeyword%>">
	<input type="hidden" id="inkeyword" name="inkeyword" value="<%=strInKeyword%>">
	<input type="hidden" id="factory" name="factory" value="<%=strGetFactory%>">
	<input type="hidden" id="brand" name="brand" value="<%=strGetBrand%>">
	<input type="hidden" id="sel_spec" name="sel_spec" value="<%=strSelSpec%>">
	<input type="hidden" id="spec" name="spec" value="<%=strSpec%>">
	<input type="hidden" id="all_keyword" name="all_keyword" value="<%=strKeyword%>">
	<input type="hidden" id="auto_keyword" name="auto_keyword" value="<%=strKeyword%>">
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
	<div  id="filter_search">
		<div class="filter_box">
			<!-- 필터검색 전체보기 -->
			<div class="filter_area allview" id="filter_all">
				<a href="#" class="ico_m back" onclick="$('#filter_all').hide();CmdFilterChk2();">이전</a>
				<h2>제조사<em>10</em></h2>
				<ul class="list_align">
					<li class="on">인기순</li>
					<li>가나다순</li>
				</ul>
				<p class="allview_search"><input type="text" placeholder="제조사명을 입력하세요."/></p>
				<div class="detail_sch" id="allview_search">
					<ul>
					</ul>
				</div>
			</div>
			<!--// 필터검색 전체보기 -->
			<!-- 검색 -->
			<div class="filter_area" >
				<h2><em>"빈폴"</em>추천카테고리</h2>
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
						<div id="sch_category">
						</div>
						<li id="sch_factory"><a href="#">제조사<span></span></a>
							<div class="sub">
								<ul></ul>
								<button class="all" onclick="CmdFilterAll('f');$('#filter_all').show();">전체보기</button>
							</div>
						</li>
						<li id="sch_brand"><a href="#">브랜드<span></span></a>
							<div class="sub">
								<ul></ul>
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
						<dd><span class="box"><input type="text"  id="srhPrice_s" maxlength="10"/></span><span class="txt">~</span><span class="box"><input type="text" id="srhPrice_e" maxlength="10"/></span></dd>
					</dl>
				</div>
			</div>
			<!--// 검색 -->

			<ul class="sch_btn">
				<li id="sch_refresh"><em>초기화</em></li>
				<li id="sch_go" onclick="ga('send', 'event', 'mf_srp', 'srp_filter', 'srp_적용');"><em>적용</em></li>
			</ul>
		</div>
		<div class="mask"></div>
	</div>
	<!--// 필터검색 -->

	<!-- 헤더영역 -->
	<%--
	<header class="sub">
		<div class="mainTop lp">
			<a href="javascript:///" class="btn_side"><span class="cate_m ico_m">주요 서비스 메뉴 펼치기</span></a>
			<h1 class="logo ico_m">에누리 가격비교</h1>
			<div class="searchbox srparea">
				<p class="search_in"><input type="text" id="searchtxt" name="searchtxt" placeholder="검색어를 입력해주세요" value="<%=strKeyword%>"/></p>
				<button class="srp"><span class="ico_m">검색</span></button>
			</div>
			<button class="mybtn"><span class="ico_m">마이메뉴</span></button>
		</div>
	</header>
	 --%>
	<!--// 헤더영역 -->

	<!-- 연관검색어 -->
	<section class="relate" id="relate" style="display:none;">
		<div class="relate_area">
			<ul>
			</ul>
		</div>
	</section>
	<!--// 연관검색어 -->
	<!-- 요악노출형-휴대폰 -->
	<section class="mobilephone"  style="display:none;">
		<span class="g_type">용량선택</span>
		<ul class="g_tab"></ul>
		<ul class="mobile_type"></ul>
	</section>
	<!--// 요악노출형-휴대폰 -->
	<!-- SRP 브랜드 테마 검색 -->
	<section class="brand_search" style="display:none;">
		<div class="innerbox">
		</div>
	</section>
	<!--// SRP 브랜드 테마 검색 -->
	<!-- 중소분류 -->
	<section class="sort_list"  style="display:none;">
		<!-- 중분류 -->
		<div class="mdl_sort">
			<div class="scll">
				<ul>
					<li data-id="tab01"><a href="javascript:///">카테고리</a></li>
					<li data-id="tab04"><a href="javascript:///">제조사</a></li>
					<li data-id="tab05"><a href="javascript:///">브랜드</a></li>
					<li data-id="tab06"><a href="javascript:///">상세검색</a></li>
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

		<div class="relate" id="relate_txt">
			<div class="relate_area">
				<ul>
				</ul>
			</div>
			<span class="reset"><em>초기화</em></span>
		</div>
	</section>
	<!--// 중소분류 -->

	<!-- 191122 중고차 추가 -->
	<div class="reborn_section con_box">
		<h3>프리미엄 중고차<a href="/enuricar/m/list.jsp" class="more">더보기</a></h3>
		<div class="reborn_goods">
			<div class="swiper-container">
				<div class="swiper-wrapper">
				</div>
			</div>
		</div>
	</div>
	<!-- // 중고차 -->

	<!-- LP리스트 -->
	<section class="lp_area">
		<div class="lp_list">
			<!-- 상품정렬 -->
			<div class="sort_opt srpview"><!-- SRP로 들어올 경우 srpview 추가 -->
				<p></p>
				<span class="sort">
					<select title="상품정렬 선택">
						<option value="popular DESC" selected="" >인기상품순</option>
						<option value="c_date DESC">신제품순</option>
						<option value="minprice3">낮은 가격순</option>
						<option value="minprice3 DESC">높은 가격순</option>
						<option value="sale_cnt DESC">판매량순</option>
						<option value="bbs_num DESC">상품평 많은순</option>
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
					<a href="https://m.searchad.naver.com/product/shopProduct" class="comm_btn_apply" target="_blank">신청하기</a>
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
			<!--// 상품리스트 -->
			<div class="loading"><span>로딩중입니다...</span>잠시만 기다려 주십시오.</div>
			<div class="no_txt" style="display:none;"><p><em></em>에 대한<br />검색결과가 없습니다.</p></div>
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
			<a href="https://ad.esmplus.com" class="comm_btn_apply cpcgo" target="_blank">신청하기</a>
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

	<!-- 이런 상품은 어떠세요? -->
	<div class="con_box" style="display:none;">
		<h3>이런 상품은 어떠세요?</h3>
		<div class="hit_scroll">
			<div class="hit_List_area">
				<ul class="hit_product">
				</ul>
			</div>
		</div>
	</div>
	<!--// 소셜 인기상품 -->
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
	<%@ include file="/mobilefirst/include/inc_ctu.jsp"%>
	<%@ include file="/mobilefirst/renew/include/footer.jsp"%>
	<%@ include file="/mobilefirst/resentzzim/zzimListInc.jsp"%>
</div><!--// lp_wrap -->

<script>
var szCategoryPower = "<%=strCate%>";
var ad_commandPower = encodeURIComponent("<%=strKeyword%>");		//검색어
var ad_commandPower2 = encodeURIComponent("<%=strCateNm%>");	//카테이름
var catePower = "<%=strCate%>";
var referrerPower = encodeURIComponent(document.referrer);
var urlPower = encodeURIComponent(document.URL);

var vAllKeyword= "<%=strKeyword%>";

	$(document).ready(function(){
		var vAppyn = getCookie("appYN");
		if(vAppyn == "Y"){
			$("header").hide();
		}
		$("#searchtxt").val(vAllKeyword);

		//상품 목록형식
		$( ".lp_list .btnview").click(function() {
			if($(".lp_list").hasClass("grid")){
				$(".lp_list").removeClass("grid");
				ga('send', 'event', 'mf_srp', 'srp_common', 'srp_리스트뷰');
			}else {
				$(".lp_list").addClass("grid").siblings().removeClass("grid");
				ga('send', 'event', 'mf_srp', 'srp_common', 'srp_갤러리뷰');
			}
			return false;
		});
		$(".logo").click(function(){
			ga('send', 'event', 'mf_srp', 'srp_GNB', 'GNB_home');
			goHome();
		})	;
		/*상세설명*/
		$('.prodtxt span').click(function(){
			if ($(this).parent().hasClass("txtmore")) {
				$(this).parent().removeClass("txtmore");
			} else {
				$(this).parent().addClass("txtmore");
		} });

		/*가격비교*/
		$('.pircelist dt').click(function(){
			if ($(this).parent().hasClass("pmore")) {
				$(this).parent().removeClass("pmore");
			} else {
				$(this).parent().addClass("pmore");
		} });

		/*찜*/
		$( ".prodList li .btnzzim" ).click(function() {
			$( this ).toggleClass( "on" );
		});

		/*필터검색*/
		/* $(".sch_list li a").click(function() {
			$( this ).toggleClass( "on" );
			$(this).next().slideToggle("fast").parent().siblings().children(".sub");
			return false;
		});*/


		/*필터검색bg*/
		function wrapWindowByMask(){
			var maskHeight = $(document).height();
			var maskWidth = $(window).width();
			$('.mask').css({'width':maskWidth,'height':maskHeight});
			$('.mask').fadeTo("fast",0.5);
			$('.filter_box').fadeTo("fast",1);
			$('.filter_box').show();
		}

		$('.openMask').click(function(e){
			e.preventDefault();
			wrapWindowByMask();
			$(".result_sch").show();

			if($(this).hasClass("btnsrp")){
				//제조사, 브랜드, 스펙
				CmdRightFilter();
			}else if($("#tab01").is(":visible") || $("#tab02").is(":visible") || $("#tab03").is(":visible")){
				//카테고리
				CmdRightCate();
				$(".result_sch").hide();
				ga('send', 'event', 'mf_srp', 'srp_common', 'click_카테고리 더보기');
			}else{
				//제조사, 브랜드, 스펙
				CmdRightFilter();
				if($("#tab04").is(":visible")){
					$(".detail_sch").scrollTop(0);
					$("#sch_factory .sub").show();
					$("#sch_brand .sub").hide();
				}else if($("#tab05").is(":visible")){
					$(".detail_sch").scrollTop(0);
					$("#sch_factory .sub").hide();
					$("#sch_brand .sub").show();
				}else if($("#tab06").is(":visible")){
					$("#sch_factory .sub").hide();
					$("#sch_brand .sub").hide();
					$("#srhKeyword").focus();
					ga('send', 'event', 'mf_srp', 'srp_common', 'click_상세검색 더보기');
				}
			}
			CmdCopyArr();
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

		$(".inSearch .del").click(function () {
			$("#srhRe").val("");
		});

		$(".inForm .del:first").click(function () {
			$("#srhPrice").val("");
		});
		$(".inForm .del:last").click(function () {
			$("#srhPrice2").val("");
		});
	});

	ga('send', 'pageview', {
		'page': '/mobilefirst/search.jsp',
		'title': 'mf_검색목록_new'
	});

</script>

<script type="text/javascript" src="/mobilefirst/js/powerShoppingMo.js?v=20200122"></script>
<script type="text/javascript" src="/mobilefirst/js/powerLinkMo.js?v=20200122"></script>
<script type="text/javascript" src="/mobilefirst/js/list2.js?v=20200210"></script>
<script type="text/javascript" src="/common/js/resellcar.js"></script>
<%@ include file="/mobilefirst/include/common_logger.html"%>
</body>
</html>
