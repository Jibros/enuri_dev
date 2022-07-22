<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ include file="/include/IncSearch.jsp"%>
<%@ page import="com.enuri.bean.main.Goods_Data"%>
<%@ page import="com.enuri.bean.main.Goods_Search"%>
<%@ page import="com.enuri.bean.main.Pricelist_Data"%>
<%@ page import="com.enuri.bean.main.Pricelist_Proc"%>
<%@ page import="com.enuri.bean.mobile.Mobile_Pricelist_Proc"%>
<%@ page import="com.enuri.bean.mobile.FactoryBrand_Data"%>
<%@ page import="com.enuri.bean.mobile.FactoryBrand_Proc"%>
<%@ page import="com.enuri.util.common.Ca_Ad_Keyword"%>
<%@ page import="com.enuri.bean.main.Mobile_Category_Proc"%>
<%@ page import="com.enuri.bean.main.Mobile_Category_Data"%>
<%@ page import="com.enuri.util.common.Ca_Ad_Keyword"%>

<jsp:useBean id="Goods_Search" class="com.enuri.bean.main.Goods_Search" scope="page" />
<jsp:useBean id="Searchfunction" class="com.enuri.bean.search.SearchFunction" />
<jsp:useBean id="Pricelist_Proc" class="com.enuri.bean.main.Pricelist_Proc" scope="page" />
<jsp:useBean id="Mobile_Pricelist_Proc" class="com.enuri.bean.mobile.Mobile_Pricelist_Proc" scope="page" />
<jsp:useBean id="FactoryBrand_Proc" class="com.enuri.bean.mobile.FactoryBrand_Proc" scope="page" />
<jsp:useBean id="Ca_Ad_Keyword" class="com.enuri.util.common.Ca_Ad_Keyword" scope="page" />

<%
	String strKeyword = ChkNull.chkStr(request.getParameter("keyword"),"");//검색어
	String strInKeyWord = ChkNull.chkStr(request.getParameter("in_keyword"),"");//결과내 검색에서의 키워드
	String strCate = ChkNull.chkStr(request.getParameter("cate"),"");//분류조건
	String strPCate = "";
	String strAndEx = ChkNull.chkStr(request.getParameter("andEx")); //안드로이드 상품창에서 돌아가기 할때 리스팅 제대로 안됨.... 개선을 위해...
	 
	if (CutStr.cutStr(strKeyword,2).equals("%u")){
		strKeyword = CvtStr.unescape(strKeyword);
	}
	if (strKeyword.indexOf("%u") >= 0 || strKeyword.indexOf("%20") >= 0){
		strKeyword = CvtStr.unescape(strKeyword);
		
	}else if(strKeyword.indexOf("%25") >= 0){
		strKeyword = CvtStr.unescape(CvtStr.unescape(strKeyword));
	}

	/* 
	 * 제외어 검색기능 추가
	 * strExceptionKeyword : 제외단어 추출
	 * strKeyword 에서 제외단어 제거
	 */
	String strOrgKeyword = (strKeyword + " " + strInKeyWord).trim();	//원래 검색어
	String strLogKeyword = (strKeyword + " " + strInKeyWord).trim();	//로그용 검색어
	String strExceptionKeyword = Searchfunction.getExceptionKeyword(strOrgKeyword);//제외검색어 처리
	String strSeperatedKeyword = seperate(strOrgKeyword);//검색어 분리
	String strSearchKeyword = Searchfunction.removeExceptionKeyword(strSeperatedKeyword);//제외검색어 처리

	//동의어 찾기
	if (bEnuriSynonym){
		strSearchKeyword = Searchfunction.getSynonym(strSearchKeyword);
	}


	String strSort = "";
	String strSortType ="";
	//검색 관련 부가카테고리 찾기
	String strCateName2 = ChkNull.chkStr(request.getParameter("cate_name"),"");//선택된 분류명

	String strCopyCate = "";//추가검색
	if (strCate.trim().length() > 0){
		strCopyCate = Searchfunction.getCopyCate(strCate);
	}
	String strFrom = ChkNull.chkStr(request.getParameter("from"),"");//목록에서 왔는지 여부

	//제조사
	String strGetFactory= "";
	String[] astrGetFactory =null;
	strGetFactory = ChkNull.chkStr(request.getParameter("factory"),"");
	strGetFactory = ReplaceStr.replace(strGetFactory,"+","" );
	astrGetFactory = strGetFactory.split(",");

	//쇼핑몰
	String strGetShop= "";
	String[] astrGetShop =null;	
	strGetShop = ChkNull.chkStr(request.getParameter("shop_code"),"");
	strGetShop = ReplaceStr.replace(strGetShop,"+"," ");
	astrGetShop = strGetShop.split(",");

	//브랜드
	String strGetBrand= "";
	String[] astrGetBrand =null;
	strGetBrand = ChkNull.chkStr(request.getParameter("brand"),"");
	strGetBrand = ReplaceStr.replace(strGetBrand,"+","" );
	astrGetBrand = strGetBrand.split(",");


	//가격대
	String strStartPrice = ChkNull.chkStr(request.getParameter("start_price"));
	String strEndPrice = ChkNull.chkStr(request.getParameter("end_price"));
	String strMPrice = "";
	if (strStartPrice.trim().length() > 0 && strEndPrice.trim().length() > 0 ){
		strMPrice = strStartPrice + "~" + strEndPrice;
	}
	//가격대,제조사 추가 끝

	String strKey = ChkNull.chkStr(request.getParameter("key"),"popular DESC");	

	if (strSort.trim().indexOf(" ") >= 0 ){
		strSortType = strSort.trim().substring(strSort.trim().indexOf(" "),strSort.trim().length());
		strSort = strSort.trim().substring(0,strSort.trim().indexOf(" "));		
	}else{
		strSortType = "ASC";
	}

	//검색어 공백제거
	for(;;){
		if(strOrgKeyword.indexOf("  ")>=0){
	   		strOrgKeyword = ReplaceStr.replace(strOrgKeyword, "  "," ");
	   	}else{
	   		break;
	   	}
	}

	//최근검색어 쿠키 저장
	if (strKeyword.trim().length() > 0 && false){
		String strSearchHistory = cb.GetCookie("MOB_SEAR_HISTORY","SEARCHKEYWORD");
		
		String strSearchS = "";
		String strInsertSearchS = "";
		String strSearch1 = "";
		String strSearch2 = "";

		strSearchS = "S:"+strKeyword+"__"+getDate();
		strInsertSearchS = strSearchS;
		if(strSearchHistory != null & "".equals(strSearchHistory) == false) {
			String astrSearchHistory[] = strSearchHistory.split("\\,");
			int intSearchHistoryCnt = astrSearchHistory.length;
			if (intSearchHistoryCnt >= 15 ){
				intSearchHistoryCnt = 15;
			}
			for (int si=0;si<intSearchHistoryCnt;si++){
				strSearch1 = astrSearchHistory[si];
				strSearch2 = strSearchS;
				if(strSearch1.indexOf("__") > -1){
					strSearch1 = strSearch1.substring(0, strSearch1.indexOf("__"));
				}
				if(strSearch2.indexOf("__") > -1){
					strSearch2 = strSearch2.substring(0, strSearch2.indexOf("__"));
				}
				if (!strSearch1.equals(strSearch2)){
					strInsertSearchS = strInsertSearchS + ","+astrSearchHistory[si];
				}
			}
		}
		if (strInsertSearchS.trim().length() > 0){
			if (strInsertSearchS.substring(strInsertSearchS.length()-1,strInsertSearchS.length()).equals(",")){
				strInsertSearchS = CutStr.cutStr(strInsertSearchS,strInsertSearchS.length()-1);
			}
		}
		String strRecFlag = cb.GetCookie("MOB_REC_FLAG","RECFLAG");
		if(!strRecFlag.equals("N")){
			cb.SetCookie("MOB_SEAR_HISTORY", "SEARCHKEYWORD", strInsertSearchS);
			cb.SetCookieExpire("MOB_SEAR_HISTORY", 3600*24*30);
			cb.responseAddCookie(response);
		}
	}	
	// 마음열기 INFO AD 모델저장
	String[] arrInfoAdModelNo = null;

	//int intInfoAdModelNo = 0;
	int intInfoAdListCnt = 0;
	String strInfoadModels = "";

	
	//성인 검색어 
	boolean bAdultKeyword = false;
%>
<%@ include file="/include/IncAdultKeywordCheck_2010.jsp" %>
<%
	/*기존 로직에서 공통으로 사용하는 변수들*/
	Goods_Data[] goods_data = null;
	Goods_Data[] goods_factory_data = null;
	Goods_Data[] goods_factory_hot_data= null;
	Goods_Data[] goods_shop_data = null;
	Goods_Data[] goods_all_group_data = null;
	Goods_Data[] goods_factory_hot_model_data = null;
	Goods_Data[] goods_brand_data = null;
	Goods_Data[] goods_brand_hot_data= null;
	
	Pricelist_Data[] pricelist_data  = null;
	int[][] intPriceRangeAndCnt = null;
	Long[] lngPricelist = null;
		
	String [][]resultFactory = null;
	String [][]resultShop = null;
	String [][]resultBrand = null;
	
	String [][]resultCategoryLarge = null;
	String resultCategoryLargeName[] = null;
	
	String [][]resultCategoryMiddle = null;
	String resultCategoryMiddleName[] = null;
	String [][]resultCategorySmall = null;
	String resultCategorySmallName[] = null;

	String [][]resultPrice = null;

	/*페이징 관련 변수*/
	int nPageCntCnt = 20; //'page cnt
	int cPage = ChkNull.chkInt(request.getParameter("page"),1);
	int nPageSize=ChkNull.chkInt(request.getParameter("pagesize"),20); //'목록수

	/*카운트 관련 변수*/
	int intHot = 0;
	int intHotNo = 0;
	int intTotRsCnt = 0;
	int intRsCnt = 0;	
	int intEnuriCnt = 0; 
	int intWebCnt = 0;

	int iEndNum3 = 0;

	if(strAndEx.equals("Y")){
		iEndNum3 = cPage*20; 
		cPage = 1;
		nPageCntCnt =  iEndNum3;
		nPageSize = iEndNum3;
	}

	String strModelNo_Group=""; //검색엔진에서 가져온 modelno의 집합
	String strPlNos = "";//추가상품검색결과 Pl_no

	/*include에서 사용하는 변수 선언 컴파일 오류 제거용*/
	String strCate2 = "";
	String strCate4 = "";
	String strCate6 = "";
	String strCate8 = "";
	String strSearchKind = "";
	String strNoSale = "";
	String strEtype = "";
	String strCate4_name = "";

	String strCondi=ChkNull.chkStr(request.getParameter("condi"),"");

	String[] arrCondi = null;
	if (strCondi.trim().length() > 0 ){
		arrCondi = strCondi.split("_");
	}

	int i,j = 0;
%>
<%@ include file="/include/Inclistsearch_Search_2010.jsp"%>
<%@ include file="/include/IncMoneyStyle_2010.jsp"%>
<%@ include file="/include/IncGroupTool_2010.jsp"%>
<%@ include file="/include/IncSponsorGoods_2010.jsp"%>
<%@ include file="/include/IncIsGoogleSearchCate_2010.jsp"%>
<%@ include file="/include/Inc_Order_Result_Category_2010.jsp"%>
<%
	int intDisTotRsCnt = intEnuriCnt + intWebCnt;
	int iCateCnt = 0;
	String strUl = "";

	boolean bOxy = false;
	String strKeywordOxy = strKeyword.trim().replaceAll(" ","").toUpperCase();
	
	/*
    #33351 검색 금지어 전체 삭제 2019.04.08, 최서진 선임 
    #35507 "수퍼굽 스킨 수딩 미네랄 선스크린" 외 15건 결과없음 처리 2019.08.19, jinwook 
    #35971 조개젓 관련 키워드 결과 없음 처리 2019.09.18. shwoo
    #36492 삼성 셀리턴 외 2019.10.23 jinwook
    #36741 베이비드림 키워드 결과 없음 처리 2019.11.07. shwoo
    */
	
	//단어 일치 할 경우 
	String strNoUseKwd[] = {"SKINSOOTHINGMINERALSUNSCREENSPF40","SOOTHINGMINERALSUNSCREENSPF40","수퍼굽스킨수딩미네랄선스크린SPF40"
            ,"수퍼굽스킨수딩미네랄선스크린","수퍼굽스킨수딩미네랄","수퍼굽스킨수딩","수퍼굽스킨","수퍼굽수딩","수퍼굽선스크린"
            ,"수퍼굽미네랄선스크린","수퍼굽수딩미네랄선스크린","AUSTRALIANGOLDLOTIONSUNSCREENSPF15"
            ,"오스트레일리안골드로션선스크린SPF15","오스트레일리안골드선스크린SPF15","CERAVESUNSCREENBODYLOTIONSPF30","세라베선스크린바디로션SPF30"
            ,"조개젓", "조개젓갈", "whrowjt","삼성셀리턴","삼성전자셀리턴","삼성LED마스크","삼성전자LED마스크","베이비드림"};

	//단어가 포함될 경우 
	String strNoUseContainKwd[] = {"조개젓", "조개젓갈", "whrowjt","삼성셀리턴","삼성전자셀리턴","삼성LED마스크","삼성전자LED마스크"};
	
	for(int idx=0; idx<strNoUseKwd.length; idx++) {
		if(strNoUseKwd[idx].equals(strKeywordOxy.trim())) {
			bOxy = true;
			break;
		}
	}
	if(!bOxy) {
		for(int idx=0; idx<strNoUseContainKwd.length; idx++) {
			if(strKeywordOxy.indexOf(strNoUseContainKwd[idx])>-1) {
				bOxy = true;
				break;
			}
		}
	}
	
	/*
	// 상위의 조건에서 isNotWord = false 로 걸려있더라도, 정확히 일치하는 경우 다시 isNotword = true 로 변환 시켜준다.
	#36771 LP/SRP 검색결과없음 처리 보완 2019.11.18 jinwook
	*/
	String[] matchArray = {"베이비 드림"};
	for(int mIdx=0; mIdx<matchArray.length; mIdx++) {
		if (matchArray[mIdx].equalsIgnoreCase(strKeywordOxy.trim())) {
			bOxy = false;
			break;
		}
	}

	//if (intTotRsCnt <= 0 || resultCategoryLarge == null || resultCategoryMiddle == null){
	if (bOxy){
		out.println("{	 \"goodsCnt\" : [{ \"cnt\" : \"0\" ,  \"oxy\" : \"1\" }]} ");
	}else{
		if(resultCategoryMiddle != null){

			out.println("{	\"chu_category\": [   ");
			
			for (int li=0;li<resultCategoryMiddle.length;li++){
				if(!resultCategoryMiddleName[li].equals("추가기타")){
					if(iCateCnt < 2){
						if (iCateCnt > 0) out.println(" , ");
						out.println("		{\"name\":\""+toJS(resultCategoryMiddleName[li].replace("&#44;",","))+"\" ,  \"code\":\""+resultCategoryMiddle[li][0]+"\" ,  \"cnt\":\""+FmtStr.moneyFormat(resultCategoryMiddle[li][1])+"\" }  ");
						iCateCnt = iCateCnt + 1; 
					}
				} 
			}	
			out.println(" ]   , "); 
			
			iCateCnt = 0;
			out.println("	\"m_category\": [   ");
			 
			for (int li=0;li<resultCategoryMiddle.length;li++){
				if (li > 0) out.println(" , ");
				if ( li % 10 == 9 ) {
					strUl = "Y";
				}else{
					strUl = "";
				}
				out.println("		{\"name\":\""+toJS(resultCategoryMiddleName[li].replace("&#44;",","))+"\" ,  \"pg\":\""+(li/10+1)+"\" ,  \"code\":\""+resultCategoryMiddle[li][0]+"\" ,  \"cnt\":\""+FmtStr.moneyFormat(resultCategoryMiddle[li][1])+"\" ,  \"ul\":\""+strUl+"\"  }  ");
				if(strCate.length() >= 4){
					strCate4 = strCate.substring(0,4);
					if(strCate4.equals(resultCategoryMiddle[li][0])){
						strCate4_name = toJS(resultCategoryMiddleName[li].replace("&#44;",","));
					}
				} 
			}	
			out.println(" ]   , "); 
			
			out.println("	\"m_category_title\": [   ");
			out.println("		{\"length\":\""+resultCategoryMiddle.length+"\" ,  \"cnt\":\""+FmtStr.moneyFormat(intDisTotRsCnt+"")+"\"  ,  \"name4\":\""+strCate4_name+"\"  }  ");
			out.println(" ]   , ");

			out.println("   \"rekeyword\": \""+strRpSearchKeyword+"\" , ");
		}else{
			out.println("{   ");
		}
%>
		<%@ include file="/mobilefirst/ajax/listAjax/get_IncViewGoodsData.jsp" %>
<%
	}
%>