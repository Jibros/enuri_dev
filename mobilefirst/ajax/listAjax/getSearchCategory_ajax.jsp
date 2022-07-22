<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.enuri.bean.main.Goods_Data"%>
<%@ include file="/mobilenew/include/Base_Inc_Mobile.jsp"%>
<%@ include file="/include/IncSearch.jsp"%>
<jsp:useBean id="Searchfunction" class="com.enuri.bean.search.SearchFunction" />
<%
	String strKeyword = ChkNull.chkStr(request.getParameter("keyword"),"");//키워드
	String strInKeyWord = ChkNull.chkStr(request.getParameter("in_keyword"),"");//결과내 검색에서의 키워드
	String strOrgKeyword = (strKeyword + " " + strInKeyWord).trim();
	String strSeperatedKeyword = seperate(strOrgKeyword);		
	String strSearchKeyword = Searchfunction.removeExceptionKeyword(strSeperatedKeyword);
	if (bEnuriSynonym){
		strSearchKeyword = Searchfunction.getSynonym(strSearchKeyword);
	}
	String strSearchKind = ChkNull.chkStr(request.getParameter("searchkind"),"");//(1:에누리,2:추가검색)
	String strNoSale = ConfigManager.RequestStr(request, "nosale", "0"); //판매종료상품 포함여부(1:포함, 0:미포함)
	String strEtype = ConfigManager.RequestStr(request, "etype", "2");   //가격비교상품 검색범위(1:모델명/제조사, 2:스펙포함)
	String strCate = ConfigManager.RequestStr(request, "cate", "");
	String strIsModelNo = ConfigManager.RequestStr(request, "ismodelno", "");
	String strPgCate = ChkNull.chkStr(request.getParameter("pgcate"));
	String strTotCnt = ChkNull.chkStr(request.getParameter("totcnt"));
	String strSC = ChkNull.chkStr(request.getParameter("sc"));

	String strEnuriModelNo_s = "";   
	if (strKeyword.length()==8 && ChkNull.chkNumber(CutStr.cutStr(strKeyword,3)) && ChkNull.chkNumber(strKeyword.substring(4,8)) && strIsModelNo.trim().equals("true")){
		strEnuriModelNo_s = CutStr.cutStr(strKeyword,3) +strKeyword.substring(4,8);
	}    	
	String strCopyCate = CutStr.cutStr(strCate,4);
	
	CSearch csearch = new CSearch();
	
	csearch.setIntPortSet(intPortSet);//port
	csearch.setStrCollectionName(strCollectionName);//컬렉션명
	csearch.setStrHostSet(strHostSet);//검색엔진 주소
	//csearch.setStrHostSet("124.243.126.210");//검색엔진 주소
	csearch.setStrUserIp(request.getRemoteAddr());
	csearch.setStrKeyword(strSearchKeyword);
	csearch.setStrOrgKeyword(strOrgKeyword.trim());
	csearch.setStrSearchKind(strSearchKind);//1:가격비교 2:추가검색 "" 이면 전체
	/*
	if (strSearchKind.equals("1")){
		csearch.setStrNotCate("92,90,93,91");
	}else{
		csearch.setStrNotCate("92,90");
	}
	*/	
	boolean bNoSale = false;
	if (strNoSale.equals("0")){
		bNoSale = true;
	}
	if (strEtype.equals("2")){
		strEtype = "";
	}
	csearch.setStrEtype(strEtype);//1: 모델명/제조사에서만 , ""이면 전체
	csearch.setBNoSale(bNoSale);//판매중단,출시예정상품 검색 여부(ture :제외 , false: 포함)
	
	csearch.setStrCate(strCopyCate);//분류조건("0201,0202")
	//csearch.setStrRealCate(strCopyCate);//분류조건("0201,0202")
	csearch.setStrMPrice("");//가격조건("10000~20000,30000~40000")
	csearch.setStrCondiName("");//조건명("3M,5M")
	csearch.setStrFactory("");//제조사("LG,삼성")
	csearch.setStrShop("");//쇼핑몰코드("55,509")
	
	csearch.setBInSearch(false);//결과내 검색 여부
	csearch.setStrOrgCate("");//결과내검색에서 현재 분류
	
	boolean bModelNo = false;
	if (strEnuriModelNo_s.trim().length() > 0 ){
		bModelNo = true;
	}
	csearch.setBModelNo(bModelNo);//모델번호검색여부
	csearch.setBCount(false);//카운트 여부
		
	csearch.setBCateGroup1(false);//대분류 그룹핑 여부
	if (strCate.trim().length() == 2 ){
		csearch.setBCateGroup2(true);//중분류 그룹핑 여부
		csearch.setBCateGroup3(false);//소분류 그룹핑 여부
	}else if (strCate.trim().length() >= 4 ){
		csearch.setBCateGroup2(false);//중분류 그룹핑 여부
		csearch.setBCateGroup3(true);//소분류 그룹핑 여부	
	}
	csearch.setBCondiGroup(false);//조건명 그룹핑 여부
	csearch.setBFacgoryGroup(false);//제조사 그룹핑 여부
	csearch.setBPriceGroup(false);//가격대 그룹핑 여부
	csearch.setBShopGroup(false);//쇼핑몰 그룹핑 여부
	
	csearch.setStrKey("popular DESC");//정렬
	csearch.setCPage(1);//현재 페이지
	csearch.setNPageSize(1);//현재 페이지에 나올 상품갯수
	csearch.setBThesaurusOption(bThesaurusOption);
	csearch.setStrSearchArea("1111");	//단종상품일때도 나오도록
	csearch.setStrMobile_flag("1"); //모바일 상품만
	    
	if (strSC.equals("y")){
		csearch.setStrSamsungCard("mo");
	}	
	CSearchResult cSearchResult = csearch.CSearchRun();//실제 검색
	String strQueryOut = csearch.getStrQuery();
	//System.out.println("getSearchCate_Ajax----strQueryOut===="+strQueryOut);	

	String strUl = "";
	int iCateCnt = 0;
	int iAllCnt = 0;
	int iPg = 0;
	
	//System.out.println("cSearchResult.getIntErrorCode()="+cSearchResult.getIntErrorCode());					
	if (cSearchResult.getIntErrorCode() >= 0 ){
		String resultCategoryMiddle[][] = null;
		String resultCategoryMiddleName[] = null;
			
		String resultCategorySmall[][] = null; 
		String resultCategorySmallName[] = null;

		String strMiddelNm = "";
				
		out.println("{  ");
		//System.out.println("strCate.trim().length()="+strCate.trim().length());
		if (strCate.trim().length() >= 4 ){
			resultCategoryMiddle = cSearchResult.getResultCategoryMiddle();//중분류 코드및 카운트
			resultCategoryMiddleName = cSearchResult.getResultCategoryMiddleName();//중분류명
			
			resultCategorySmall = cSearchResult.getResultCategorySmall();//소분류 코드및 카운트
			resultCategorySmallName = cSearchResult.getResultCategorySmallName();//소분류명
			
			//out.println(resultCategorySmall+" , "+resultCategorySmallName);
			//System.out.println("resultCategorySmall.length="+resultCategorySmall.length);
			if(resultCategorySmall != null && resultCategorySmall.length > 0){
				for (int i = 0; i < resultCategorySmall.length; i++){
					if (i == 0) {
						out.println("	\"s_category\": [   ");
					}
					if (i > 0) out.println(" , ");
					if ( i == 8 ) {
						strUl = "Y"; 
					}else if ( i > 8  &&  i % 10 == 8 ) {
						strUl = "Y";
					}else{
						strUl = ""; 
					} 
					
					iPg = ((i+1)/10)+1;

					out.println("		{\"name\":\""+toJS(resultCategorySmallName[i].replace("&#44;",","))+"\" , \"pg\":\""+iPg+"\" , \"code\":\""+resultCategorySmall[i][0]+"\" ,  \"cnt\":\""+FmtStr.moneyFormat(resultCategorySmall[i][1])+"\" ,  \"ul\":\""+strUl+"\"  }  ");
					 
					iCateCnt = iCateCnt + 1;
					iAllCnt = iAllCnt + Integer.parseInt(resultCategorySmall[i][1]);
					
					if (i == resultCategorySmall.length - 1)  {
						out.println(" ] , ");
						out.println("	\"s_category_title\": [   ");
						out.println("		{\"length\":\""+resultCategorySmall.length+"\" ,  \"cnt\":\""+FmtStr.moneyFormat(iAllCnt+"")+"\"  }  ");
						out.println(" ]  ");
					}
				} 
			}
		}
		out.println("  } ");
	}
%>
