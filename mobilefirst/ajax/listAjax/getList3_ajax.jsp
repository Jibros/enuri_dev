<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%//System.out.println("JSP-START : " + DateStamp.nowStamp().toString());%>
<%@ include file="/include/IncGroupTool_2010.jsp"%>
<%@ page import="com.enuri.bean.main.Fusion_Popular_Data"%>
<%@ page import="com.enuri.bean.main.Fusion_Popular_Proc"%>
<%@ page import="com.enuri.bean.main.Goods_copycate_Proc"%>
<%@ page import="com.enuri.bean.main.Goods_copycate_Data"%>
<%@ page import="com.enuri.bean.main.Goods_Proc"%>
<%@ page import="com.enuri.bean.main.Goods_Data"%>
<%@ page import="com.enuri.bean.main.Goods_Brand_Data"%>
<%@ page import="com.enuri.bean.main.Fusion_Brand_Proc"%>
<%@ page import="com.enuri.bean.main.Pricelist_Data"%>
<%@ page import="com.enuri.bean.main.Pricelist_Proc"%>
<%@ page import="com.enuri.bean.main.Goods_Fashion_Proc"%>
<%@ page import="com.enuri.bean.main.Goods_Brand_Proc"%>
<%@ page import="com.enuri.bean.main.fashion.Fashion_Brand_Data"%>
<%@ page import="com.enuri.bean.main.fashion.Fashion_Brand_Proc"%>
<%@ page import="com.enuri.bean.main.Dcate_manager_Data"%>
<%@ page import="com.enuri.bean.main.Dcate_manager_Proc"%>
<%@ page import="com.enuri.bean.main.Fusion_Hot_Cate_Data"%>
<%@ page import="com.enuri.bean.main.Fusion_Hot_Cate_Proc"%>
<jsp:useBean id="Fusion_Popular_Data" class="com.enuri.bean.main.Fusion_Popular_Data" scope="page" />
<jsp:useBean id="Fusion_Popular_Proc" class="com.enuri.bean.main.Fusion_Popular_Proc" scope="page" />
<jsp:useBean id="Goods_Proc" class="com.enuri.bean.main.Goods_Proc" scope="page" />
<jsp:useBean id="Pricelist_Proc" class="com.enuri.bean.main.Pricelist_Proc" scope="page" />
<jsp:useBean id="Goods_copycate_Proc" class="com.enuri.bean.main.Goods_copycate_Proc" scope="page" />
<jsp:useBean id="Goods_Fashion_Proc" class="com.enuri.bean.main.Goods_Fashion_Proc" scope="page" />
<jsp:useBean id="Fashion_Brand_Proc" class="com.enuri.bean.main.fashion.Fashion_Brand_Proc" scope="page" />
<jsp:useBean id="Dcate_manager_Proc" class="com.enuri.bean.main.Dcate_manager_Proc" scope="page" />

<jsp:useBean  id="Model_log_Proc" class="com.enuri.bean.logdata.Model_log_Proc" scope="page" />
<jsp:useBean  id="Fusion_Hot_Cate_Proc" class="com.enuri.bean.main.Fusion_Hot_Cate_Proc" scope="page" />
<jsp:useBean id="Searchfunction" class="com.enuri.bean.search.SearchFunction" />
<%@ include file="/include/IncSearch.jsp"%>
<%
	//System.out.println("==start==" + com.enuri.util.date.DateStamp.nowStamp().toString());
	
	String strCate = ChkNull.chkStr(request.getParameter("cate"));
	String strSubCate = ChkNull.chkStr(request.getParameter("sub_cate"));
	String strChkBrand = ChkNull.chkStr(request.getParameter("chk_brand"),"");
	String strChkBrand_c = ChkNull.chkStr(request.getParameter("chk_brand_c"),"");
	String strView=ChkNull.chkStr(request.getParameter("view"),"gp");
	String strBrand_page = ChkNull.chkStr(request.getParameter("brand_page"));
	String strAndEx = ChkNull.chkStr(request.getParameter("andEx")); //안드로이드 상품창에서 돌아가기 할때 리스팅 제대로 안됨.... 개선을 위해...

	String strWordType ="";			//고급검색에서 검색 조건
	String strOperator  ="";		//쿼리 내의 연산자 결정 strWordType 에 따라..
	String szCmd = ChkNull.chkStr(request.getParameter("cmd"),"imglist");
	String strChkModelNo = ChkNull.chkStr(request.getParameter("chk_modelno"));
	String TmpKeyword="";
	//검색용 변수

	String strKeyword_select = URLDecoder.decode(ChkNull.chkStr(request.getParameter("keyword_select")));
	String strKeyWordSearch = request.getParameter("bKeywordBtnClick") == null ? "false" : request.getParameter("bKeywordBtnClick").trim();
	String strSubCmd = "";
	
	String strGb2Name = ChkNull.chkStr(request.getParameter("gb2name"),"");
	String strGb2CateName = ChkNull.chkStr(request.getParameter("gb2catename"),"");
	
	//1458잡화 브랜드 스크롤 높이 관련

 

	int intScrollBrandRow_1458 = 0;
	String strNowLocation1458 = strGb2Name;
	String strNowLocation1458BrandCate = strGb2CateName;
	
	boolean blScatePage = true;
	
	Goods_Data[] goods_data = null;
	Goods_Data[] goods_factory_hot_data = null;
	
	String order_by = "";
	

	int nPageCntCnt = 20; //'page cnt
	
	//소분류명일때는 strDisCatename 변수에 지정해줘야함.
	String strCatename = ChkNull.chkStr(request.getParameter("catename"));
	String strDisCatename= "";
	
	//현재위치 셋팅
	String strSpecName=ChkNull.chkStr(request.getParameter("spec_name"));
	String strSpecs = ChkNull.chkStr(request.getParameter("spec"));
	String strCate4 = "";
	String strCate6 = "";	
	String strCate8 = "";
	
	String strSName="";
	String strDName="";
	//출시예정상품 확인할때
	boolean blnPgService=false;
	//int ret2 = Open_expect_Proc.Open_expect_category_Count(strCate4);
	//if(ret2 > 0 ){
	//	blnPgService = true;
	//}
	//System.out.println("JSP-START(GET CATEGORY) : " + DateStamp.nowStamp().toString());
	if(strCatename.equals("")){
		strCatename = Category_Proc.Category_Favorite_Name_One(strCate);
	}

	if(strCate.length()>6){
		strDisCatename = Category_Proc.Category_Favorite_Name_One(CutStr.cutStr(strCate,6));
	}else{	
		strDisCatename = strCatename;
	}	

	String strMName = "";
	if(strCate.length()>=4){
		Category_Data category_name_data = Category_Proc.Category_One_1(CutStr.cutStr(strCate,4));
		if(category_name_data!=null){
			strMName=category_name_data.getC_name();
		}	
	}
	
	String strMetaCateName = "";//상위분류 Name
	
	int intSubCateDepth = 0;// 하위 카테고리 depth
	String strSearchCate = "";// 페이지에 보여줄 하위 카테고리(최대 6자리)
	
	if(strCate.length() == 4){//depth 설정
		intSubCateDepth = 3;
	}else if(strCate.length() == 6 || strCate.length() == 8){
		intSubCateDepth = 4;
	}else{
		intSubCateDepth = 0;
	}
	
	if(strCate.length() == 8){//미분류(8자리)일 경우, 상위 6자리 표현
		strSearchCate = CutStr.cutStr(strCate,6);
		strMetaCateName = Category_Proc.Category_Favorite_Name_One( strSearchCate );
	}else{
		strSearchCate = strCate;
		strMetaCateName = Category_Proc.Category_Favorite_Name_One( strCate );
	}

	String strMoveUpCate = "";
	strMoveUpCate = strSearchCate;
	
	
	Goods_Brand_Data[] goods_brand_datas = null;
	Category_Data[] category_data_sub = null;
	if(strCate.equals("150709")){//식품 김치 브랜드 페이지 체크
		Fusion_Brand_Proc fusion_brand_proc = new Fusion_Brand_Proc();
		goods_brand_datas = fusion_brand_proc.getFusion_Brand_Category_List("15");
	}else{

		category_data_sub = Category_Proc.Category_sub_Bind_List(strSearchCate, intSubCateDepth);
	}
	
	//식품페이지 상위 롤링 베너
	Fusion_Popular_Data[] fusion_popular_data = Fusion_Popular_Proc.getData_List(CutStr.cutStr(strCate,4));

	int intGoods_No = 0;
	String strGoodsimgname = "";
	String strGoodsurl = "";
	String strGoods_Date = "";
	String strGoods_Etc = "";
	int intGoods_Count = 0;
	
	//검색관련 변수 선언및 setting
	String strSearchType=""; 
	strSearchType = "food";
	
	String strGetQuery = "";
	String strSearchKind = "";
	int intTotRsCnt = 0; //웹 전체 목록수
	int intEnuriCnt = 0;
	int intRsCnt=0;    //불러온 목록수



	int intPageCount=0;
	String [][]resultFactory = null;
	String [][]resultPrice = null;
	int[][] intPriceRangeAndCnt = null;
	int i = 0;
	int intHot = 0;
	/*
	if (CutStr.cutStr(strCate,2).equals("14")){
		strSearchType = "fashion";
		strSearchKind = "4";
	}else if(CutStr.cutStr(strCate,2).equals("15")){
		strSearchType = "food";
		strSearchKind = "5";
	}
	*/
	//임시
	int intBrand2No = Integer.parseInt(ConfigManager.RequestStr(request,"brand2no","0"));//4290
	String ConstServer = ConfigManager.ConstServer(request);
	String strCmdSearch_Keyword = ChkNull.chkStr(request.getParameter("search_keyword"));
	String strCmdSearch = ChkNull.chkStr(request.getParameter("search"));
	String strBrandName = "";
	String strBrandDCaCode = ChkNull.chkStr(request.getParameter("brandcate"),"");
	
	String strBrand = ConfigManager.RequestStr(request,"brand","");
	
	Goods_Data[] goods_factory_data = null;
	Pricelist_Data[] pricelist_data  = null;
	Goods_copycate_Data[] goods_copycate_data = null;
	String strCopyCate = Searchfunction.getCopyCate(strCate);	//검색관련 부 카테고리
	//키워드
	String strKeyword = ChkNull.chkStr(request.getParameter("keyword"),"");//키워드

	String strOrgKeyword = strKeyword;//원래키워드
	String strLogKeyword = strKeyword;//로그용 키워드
	String strSeperatedKeyword = seperate(strOrgKeyword);
	String strSearchKeyword = Searchfunction.removeExceptionKeyword(strSeperatedKeyword);
		//동의어 찾기
	if (bEnuriSynonym){
		strSearchKeyword = Searchfunction.getSynonym(strSearchKeyword);
	}
	String strZzimmodelnos = "";
	//제조사

	String strGetFactory= "";
	String[] astrGetFactory =null;
	//strGetFactory= ReplaceStr.replace(ConfigManager.RequestStr(request,"factory",""), "+"," ") ;
	strGetFactory = ReplaceStr.replace(ConfigManager.RequestStr(request,"factory",""),"#26;","&");
	astrGetFactory = strGetFactory.split(",");
	
	String strGetShop = ChkNull.chkStr(request.getParameter("shop_code"),"");
	strGetShop = ReplaceStr.replace(strGetShop,"+"," ");
	String[] astrGetShop = strGetShop.split("\\,");
	
	//최저가 파라미터
	String strMPrice = ChkNull.chkStr(request.getParameter("m_price"));
	String strStartPrice = ChkNull.chkStr(request.getParameter("start_price"));
	String strEndPrice = ChkNull.chkStr(request.getParameter("end_price"));	
	if (strStartPrice.trim().length() > 0 && strEndPrice.trim().length() > 0 ){
		strMPrice = strStartPrice + "~" + strEndPrice;
	} 	
	//페이지관련 변수

	int cPage = ChkNull.chkInt(request.getParameter("page"),1);
	int nPageSize = ChkNull.chkInt(request.getParameter("pagesize"),0); //'목록수
	nPageSize = 20;
	
	int iEndPage = cPage*20;
	String pageGubun = "";
	
	if(strAndEx.equals("Y")){ 
		iEndPage = cPage*20; 
		cPage = 1;
		nPageCntCnt =  iEndPage;
		nPageSize = iEndPage;
	}  
	 
	//정렬 전 단계
	String szMode = ChkNull.chkStr(request.getParameter("mode"),"wlist");
	
	String strKey = "";	
	if (szMode.trim().equals("wlist")){
		strKey = ChkNull.chkStr(request.getParameter("key"),"");
	}else{
		strKey = ChkNull.chkStr(request.getParameter("key"),"");
	}


%>
<%@ include file="/include/IncSetSortSession_Fusion.jsp"%>
<%
	
	if (strKey.trim().equals("PRICE")){
		if(CutStr.cutStr(strCate,2).equals("14")){
			strKey = "PRICE DESC";//패션 정렬
		}
	}
	
	if (strKey.toUpperCase().trim().equals("MINPRICE") || strKey.toUpperCase().trim().equals("MINPRICE3") ){
		//if (szMode.trim().equals("wlist")){
		    strKey = "price asc";
		//}else{
		 //  strKey = "minprice asc";
		//}
	}
	String strFusionOrder = "";	
	strKey = ReplaceStr.replace(strKey.toUpperCase(),"C_DATE","RDATE");
	if (strKey.toUpperCase().trim().equals("MINPRICE DESC") || strKey.toUpperCase().trim().equals("MINPRICE3 DESC") ){
		//if (szMode.trim().equals("wlist")){
		    strKey = "PRICE ASC";
		    strFusionOrder = "1";
		//}else{
		 //  strKey = "minprice ASC";
		///}	
	}
 
	//정렬
	String strSort = "";
	String strSortType ="";
	strSort = strKey.trim().length() == 0 ? "POPULAR DESC" : strKey;
	if (strSort.trim().indexOf(" ") >= 0 ){
		strSortType = strSort.trim().substring(strSort.trim().indexOf(" "),strSort.trim().length());
		strSort = strSort.trim().substring(0,strSort.trim().indexOf(" "));		
	}else{
		strSortType = "DESC";
	}
	/*가격대 검색용 시작*/
	Long[] lngPricelistSearch = null;
	Long[] lngPricelist = null;
	int j = 0;	
	/*가격대 검색용 끝*/	
	//System.out.println("JSP-END(GET CATEGORY) : " + DateStamp.nowStamp().toString());
	//디버그 모드
	boolean bDebugMode = false;
	boolean bEnuriModel = false;
	Goods_Data[] goods_fashion_data = null;
	Goods_Data[] goods_shop_data = null;
	String strPlNos = "";
	String strpstrModelNos = "";
	
	//out.println("<div id='f_loading' style='margin:30px auto;width:200px;height:100px;text-align:center;padding-top:110px;'><img src='"+ConfigManager.IMG_ENURI_COM+"/images/mobile4/m_loading.gif' width='82' height='86'/><br><br>화면을 불러오고 있습니다.</div>");
	//out.flush();
		 
	//=========================================================================================
	//서브카테고리 검색
	//=========================================================================================
	goods_copycate_data = Goods_copycate_Proc.Goods_copycate_Bind_List(strCate);
	//=========================================================================================
		
	if(CutStr.cutStr(strCate,4).equals("1458")){//잡화 브랜드
%>
<%@ include file="/include/Inclistsearch_Fashion_Brand_2010.jsp"%>
<%			
	}else{
%>
<%@ include file="/include/Inclistsearch_Fashion_2010.jsp"%>
<%		
	}
	
	String strOrgGetFactory = strGetFactory; //제조사 임시
	int intWebListCnt = intTotRsCnt;//웹상품 검색 갯수

	if(iEndPage > intTotRsCnt){
		iEndPage = intTotRsCnt;
	}

	String pagingBar = iEndPage + ""  ;	//페이징 텍스트부분
	
	//즐겨찾은 메뉴 쿠키 세팅
   	String strTmpFavorite = cb.GetCookie("MYFAVORITEVIEW","TMP_MYFAVORITEVIEW");
	String[] strTmpFavorite1 = null;
	String[] strTmpFavorite2 = null;
	String strNewFavorite1 = "";
	strTmpFavorite1 = strTmpFavorite.split(":");
	boolean bChange2 = true;
	String strCnt = "";
	int intExist1 = -1;
	boolean chkFlag = true;
	String strTotCookie = "";
	int intMaxCookieCnt = strTmpFavorite1.length;
	if( strTmpFavorite != null & "".equals(strTmpFavorite) == false){
		//쿠키세트 갯수만큼 반복
		for( i=0; i<intMaxCookieCnt; i++){
			strTmpFavorite2 = strTmpFavorite1[i].split(",");
			for(int k=0; k<strTmpFavorite2.length; k++){
				//잘못된 쿠키
				if( strTmpFavorite2.length < 3 ){
					bChange2 = true;
					strTotCookie = "Y";
				}else{
					//잘못된 쿠키
					if( !( strTmpFavorite2[0].equals("list") || strTmpFavorite2[0].equals("mp3") || strTmpFavorite2[0].equals("handphone")
					       || strTmpFavorite2[0].equals("brand") || strTmpFavorite2[0].equals("luxury") || strTmpFavorite2[0].equals("printer")
					       || strTmpFavorite2[0].equals("fusion")|| strTmpFavorite2[0].equals("fashion") || strTmpFavorite2[0].equals("brandView") )){
							//System.out.println("================");
							bChange2 = true;
							strTotCookie = "Y";
					}
					//이미 담겨있는 카테고리는 쿠키에 Set하지 않는다
					if( strCate.equals(strTmpFavorite2[1])){
						bChange2 = false;
					}
					//이미 담겨있는 중분류의 경우 새로운 쿠키로 담는다;
					if(strTmpFavorite2[1].length() >= 4){
						if( strCate4.equals(strTmpFavorite2[1].substring(0,4))){
							intExist1 = i;
						}				
					}
				}
			}
		}
		int Rz = 0;
		if( intMaxCookieCnt < 3){
			Rz = 0;
		}else{
			//중복되는 쿠키가 있을 경우
			if( intExist1 != -1){
				Rz = 0;
			}else{
				Rz = 1;
			}
		}
		//해당 중분류의 경우 기존 쿠키를 담지 않는다.;;
		//쿠키 중 2개만 담는다 최근 것부터 
		if ( intMaxCookieCnt > 3 ){
			Rz = Rz + (intMaxCookieCnt - 3);
		}
 		for( int z = Rz ; z < intMaxCookieCnt ; z++){
			if( intExist1 != z){
				if("".equals(strNewFavorite1) || strNewFavorite1 == null){
					strNewFavorite1 = strNewFavorite1 + strTmpFavorite1[z];
				}else{
					strNewFavorite1 = strNewFavorite1 + ":" + strTmpFavorite1[z];
				}
			}
		}
	}
	//기존 쿠키가 잘못된 쿠키일 경우 삭제
	if( "Y".equals(strTotCookie)){
			strTmpFavorite = "list," + strCate + "," + strMName + ",";
	}else{
		if( strNewFavorite1 != null & "".equals(strNewFavorite1) == false){
			strTmpFavorite = strNewFavorite1 + ":list," + strCate + "," + strMName + ",";
		}else{
			strTmpFavorite = strNewFavorite1 + "list," + strCate + "," + strMName + ",";
		}
	}
	if( bChange2 ){
	   	cb.SetCookie("MYFAVORITEVIEW", "TMP_MYFAVORITEVIEW", strTmpFavorite);
	   	cb.SetCookieExpire("MYFAVORITEVIEW", 3600*24*30);
	   	cb.responseAddCookie(response);
	}

out.println(" { ");
// 리스트데이터
out.println("   	\"ad_command\": \"\" , ");
out.println("	\"goodsCnt\": [ { \"cnt\":\""+FmtStr.moneyFormat(intTotRsCnt)+"\" } ] , ");
out.println("	\"goodsPageBar\": [ { \"pageBar\":\""+pagingBar+"\" ,  \"cnt\":\""+FmtStr.moneyFormat(intTotRsCnt)+"\" }] , ");
if(pricelist_data==null || pricelist_data.length==0){

}else{ 
	out.println(" 	\"goodsList\": [ ");
	
	String sExID="";
	String sExModelNo="";
	int sExMallcnt=0;
	String sExSearchflag = "";
	String sShopCode="";
	String sExCategory="";
	String sExGoodsNm="";
	String sExPrice="";
	String sExUrl="";
	String sDate="";
	String sShopName="";
	String sShopDeliveryflag="";
	String sDeliveryInfo="";
	String tmpGoodsNm="";
	String[] stmpArray= null;
	String xstrImgurl = "";
	String xstrImgurlflag ="";
	String sExFactory="";
	String strJobType = "";
	
	String dTmpDate ="";
	String tTmpDate = "";
	String pdata = "";
	
	//식품 마우스 오버시 이미지를 보여주기 위한 변수 선언
	String strP_imgurl = "";
	//업체 이미지가 있을경우 업체 이미지로 교체
	String strMouseOverImgChg = "";
	
	//업체 이미지 체크 (p_imgurl2가 없을경우 p_imgurl로 대체)
	String strP_imgurl_ori = "";//p_imgurl 을 변수 strP_imgurl_ori에 저장
	
	int xi=0;
	int xj=0;
	
	//쇼핑몰명을 이미지로 보여줌(2000921 ksay33)
	//  	search/Drawexenurilist2.jsp
	// 	 view/fusion/Fusion_Weblist.jsp
	//  	include/Inc_Popular_Shop.jsp      =>식품, 의류의 웹검색, 상품목록, 인기상품에 해당
	
	String fusion_shoplogo[] = {"47","49","52","55","57","75","90","241","251","281","307","374","397","536","663","5961","5962","4951",
												"806","922","949","1003","1050","1289","1320","1346","1519","1559","1627","1675","1729","1754","1788",
												"1840","1857","1869","1878","1885","1916","2002","2208","2220","2241","2305","2317","2337","2421","2467",
												"2647","3539","3549","3623","4027","4817","5052","5075","5112","5150","5217","5410","5438","5454","5473","6029",
												"5485","5516","5553","5567","5610","5736","974","5895","5900","5910","5943","5948","5949","5964","5978","5983","5987","2141","6067"};
	String strLogo = "";
	
	int intLoop = pricelist_data.length;
	String strBottomBorder = "";
	String strDeliveryInfo = "";
	int intKbnum = 0;
	String strPCate = ""; 
	String strMall_YN = "";
	String strOption_YN = "Y";
	String strBeginnerDicSpec = "";
	String strSpec = "";
	String strUdate = "";
	String strViewCdate = "";
	String dateText = "";
	
	for (i=0;i<intLoop;i++){
		sExID = String.valueOf(pricelist_data[i].getPl_no());
	    sExModelNo = String.valueOf(pricelist_data[i].getModelno());
	    sExMallcnt = pricelist_data[i].getMallcnt();
	    sExSearchflag = ChkNull.chkStr(String.valueOf(pricelist_data[i].getSearchflag()));
	    sShopCode = String.valueOf(pricelist_data[i].getShop_code());
	    sExCategory = ChkNull.chkStr(pricelist_data[i].getCa_code()).trim();
	    tmpGoodsNm = ChkNull.chkStr(pricelist_data[i].getGoodsnm()).trim();
	    sExFactory = ChkNull.chkStr(pricelist_data[i].getFactory()).trim();
	    if( tmpGoodsNm.endsWith("-분할")) tmpGoodsNm = tmpGoodsNm.substring(0, tmpGoodsNm.length()-3);
	    sExGoodsNm = Searchfunction.IsIn(tmpGoodsNm,strKeyword);
	    sExPrice = String.valueOf(pricelist_data[i].getPrice());
	    
		if (strPCate.trim().length() == 0 ){ 
			strPCate = sExCategory;
		}	 
		
		strMall_YN = "Y";
		strOption_YN = "";
		
	    //=========================================================
	    //DB확인 부분 (infolim)
	    //=========================================================
	    if(!sExModelNo.equals("0") && CvtStr.isNumeric(sExModelNo)){//에누리상품
		    Goods_Data goods_data_info = Goods_Proc.getGoods_Minprice(Integer.parseInt(sExModelNo));
		    if(goods_data_info!=null){
		    	sExPrice = goods_data_info.getMinprice3()+"";
		    	sExMallcnt = goods_data_info.getMallcnt3();
		    	strP_imgurl = goods_data_info.getP_imgurl2();
		    	strP_imgurl_ori = goods_data_info.getP_imgurl();
		    	intKbnum = goods_data_info.getKb_num();
		    	strSpec =  goods_data_info.getSpec_group();
		    	if(strSpec.equals("")){
		    		strSpec =  goods_data_info.getSpec();
		    	}
		    	strBeginnerDicSpec = strSpec;
		    	strUdate = goods_data_info.getC_date();
		    	
		    	//날짜
		    	strUdate = CutStr.cutStr(strUdate,10); 

				strViewCdate = DateUtil.RtnDateComment(strUdate,"2010_list",""); 
				
				if(!CutStr.cutStr(strCate4,2).equals("15")){
					if (strViewCdate.equals("예정")){
						dateText = "출시예정";
					}else{
						// 2012.03.07.imzig. 현재년도 이전 출시 상품은 출시월 정보 없이 출시년도만 표시
						int cdateYear = 0;
						int cdateMon = 0;
						 
						if(strUdate.length() > 0){
							cdateYear = Integer.parseInt(strUdate.substring(0,4));
							cdateMon =  Integer.parseInt(strUdate.substring(5,7));
						}
						int nowYear = Integer.parseInt(new java.text.SimpleDateFormat("yyyy").format(new java.util.Date()));
						int nowMon = ChkNull.chkInt(DateStr.getYMD(DateStr.nowStr(),"M"));
						
						if( strUdate.length() > 0 ){
							if( cdateYear < nowYear) {
								if(cdateYear == nowYear-1 && cdateMon > nowMon && nowMon < 3){
									if(strUdate.substring(5,6).equals("0")){
										dateText = "등록일 '"+strUdate.substring(2,4)+"년 "+strUdate.substring(6,7)+"월";
									}else{
										dateText = "등록일 '"+strUdate.substring(2,4)+"년 "+strUdate.substring(5,7)+"월";
									}	
								}else{
									dateText = "등록일 '"+strUdate.substring(2,4)+"년";
								}
							} else {			 
								if(strUdate.substring(5,6).equals("0")){
									dateText = "등록일 '"+strUdate.substring(2,4)+"년 "+strUdate.substring(6,7)+"월";
								}else{
									dateText = "등록일 '"+strUdate.substring(2,4)+"년 "+strUdate.substring(5,7)+"월";
								}
							}
						}
					}
				} 		
		    }else{
		    	sExPrice = "0";
		    	strP_imgurl = pricelist_data[i].getP_imgurl().trim();
		    }
	    }else{
	    	pricelist_data[i] = Pricelist_Proc.getPricelistData(Integer.parseInt(sExID));//추가검색상품
	        sShopCode = String.valueOf(pricelist_data[i].getShop_code());
	        sExCategory = ChkNull.chkStr(pricelist_data[i].getCa_code()).trim();
	        tmpGoodsNm = ChkNull.chkStr(pricelist_data[i].getGoodsnm()).trim();
	        sExFactory = ChkNull.chkStr(pricelist_data[i].getFactory()).trim();
	        if( tmpGoodsNm.endsWith("-분할")) tmpGoodsNm = tmpGoodsNm.substring(0, tmpGoodsNm.length()-3);
	        sExGoodsNm = Searchfunction.IsIn(tmpGoodsNm,strKeyword);
	        sExPrice = String.valueOf(pricelist_data[i].getPrice());    	
	        strP_imgurl = pricelist_data[i].getP_imgurl().trim();
		    strUdate = pricelist_data[i].getU_date();
		    //날짜, 출시일
	    	strUdate = CutStr.cutStr(strUdate,10);				
			int cdateYear = 0;
			int cdateMon = 0;
			
			if(strUdate.length() > 0){
				cdateYear = Integer.parseInt(strUdate.substring(0,4));
				cdateMon =  Integer.parseInt(strUdate.substring(5,7));
			}
			
			int nowYear = Integer.parseInt(new java.text.SimpleDateFormat("yyyy").format(new java.util.Date()));
	    	int nowMon = ChkNull.chkInt(DateStr.getYMD(DateStr.nowStr(),"M"));
			
			if( cdateYear < nowYear) {
				if(cdateYear == nowYear-1 && cdateMon > nowMon && nowMon < 3){
					if(strUdate.substring(5,6).equals("0")){
						dateText = "'"+strUdate.substring(2,4)+"년 "+strUdate.substring(6,7)+"월";
					}else{
						dateText = "'"+strUdate.substring(2,4)+"년 "+strUdate.substring(5,7)+"월";
					}	
				}else{
					dateText = "'"+strUdate.substring(2,4)+"년";
				}
			} else {			
				if(strUdate.substring(5,6).equals("0")){
					dateText = "'"+strUdate.substring(2,4)+"년 "+strUdate.substring(6,7)+"월";
				}else{
					dateText = "'"+strUdate.substring(2,4)+"년 "+strUdate.substring(5,7)+"월";
				}
			}
	    }
	    //========================================================
	    
	    if(sExPrice==null || sExPrice.equals(""))  sExPrice="0";
	    sExUrl = ChkNull.chkStr(pricelist_data[i].getUrl()).trim();
	    if(sDate.equals("") || sDate==null) sDate = "20050822";
	    dTmpDate =  DateUtil.RtnDateComment( sDate.substring(0,4)+"-"+sDate.substring(4,6)+"-"+sDate.substring(6,8), "list","");
	    tTmpDate = "등록일 : " +  sDate.substring(0,4) + "년 " + sDate.substring(4,6) + "월";
	    xstrImgurl = ChkNull.chkStr(pricelist_data[i].getImgurl()).trim();
	
	
	    sShopName = ChkNull.chkStr(pricelist_data[i].getShop_name()).trim();
	    sShopName = Searchfunction.IsIn(sShopName,strKeyword);
	    sShopName = ReplaceStr.replace(sShopName,"전자신문 이마켓","이마켓");
	    sShopDeliveryflag = ChkNull.chkStr(pricelist_data[i].getDeliveryflag()).trim();
		strJobType = ChkNull.chkStr(pricelist_data[i].getJobtype()).trim();
	    //배송관련추가.
	    String xstrTmpFeeType = "";
		int xintTmpPrice = 0;
		int xintTmpBasisFrom = 0;
		int xintTmpBasisTo = 0;
		String xstrTmpFeeDesc = "";
		String xstrTmpAreaType = "";
		String xstrTmpAreaDesc = "";
		String xstrTmpAirconFeeType = "";
		String xstrTmpEvent = "";
	
		sExGoodsNm = sExGoodsNm.replace("#amp;","&");
		sExGoodsNm = sExGoodsNm.replace("#per;","%");
		String strSearckKeywordSynonym = "";
		if (strKeyword.trim().length() > 0 ){
			strSearckKeywordSynonym = Searchfunction.getNoRelaceSynonym(strKeyword);
			sExGoodsNm = Searchfunction.IsIn(sExGoodsNm,strSearckKeywordSynonym);
		}	
		if(sExSearchflag.equals("3")){
			if (intBrand2No == 0 ){
				if (sExMallcnt > 1 ){
				}else{
					Pricelist_Data pData = null;
					if(Integer.parseInt(sExModelNo)>0){
						pData = Pricelist_Proc.getData_ModelnoUseViewBig(Integer.parseInt(sExModelNo));
						if (pData != null){
							sShopCode = pData.getShop_code()+"";
							sShopName = pData.getShop_name();
							sExUrl = pData.getUrl();
							sExID = pData.getPl_no()+"";
						}
					}
				}
			}else{
				if (sExMallcnt > 1 ){
				}else{
					Pricelist_Data pData = null;
					if(Integer.parseInt(sExModelNo)>0){
						pData = Pricelist_Proc.getData_ModelnoUseViewBig(Integer.parseInt(sExModelNo));
						if (pData != null){
							sShopCode = pData.getShop_code()+"";
							sShopName = pData.getShop_name();
							sExUrl = pData.getUrl(); 
							sExID = pData.getPl_no()+"";
						}
					}
				}
			}
		}else{
		}
		
		String strPopularCount = "";
		if (intTotRsCnt*0.3 > i && cPage == 1 && i < 3 ){
			if (strKey.trim().equals("POPULAR DESC") || strKey.trim().equals("POPULAR+DESC")){
				strPopularCount = ""+(i+1);
			}else{
				strPopularCount = "";
			}
		}
		
	    
		if(strZzimmodelnos.length() == 0 ){
			if(sShopName.length() == 0){
				strZzimmodelnos = "G:"+sExModelNo+"";
			}else{
				strZzimmodelnos = "P:"+sExID+"";
			}
		}else{
			if(sShopName.length() == 0){
				strZzimmodelnos = strZzimmodelnos + ",G:"+sExModelNo+"";
			}else{
				strZzimmodelnos = strZzimmodelnos + ",P:"+sExID+"";
			}
		}	  
		 
		strBeginnerDicSpec = Searchfunction.IsIn(strBeginnerDicSpec,strSearckKeywordSynonym);
		
		if(strBeginnerDicSpec.indexOf("> [") > -1){
			strBeginnerDicSpec = strBeginnerDicSpec.substring(strBeginnerDicSpec.indexOf("> [")+2, strBeginnerDicSpec.length());
		}
   
		strBeginnerDicSpec = ReplaceStr.replace(strBeginnerDicSpec, "</", "****");
		strBeginnerDicSpec = ReplaceStr.replace(strBeginnerDicSpec, "/", " / ");
		strBeginnerDicSpec = ReplaceStr.replace(strBeginnerDicSpec, "****", "</");
		strBeginnerDicSpec = ReplaceStr.replace(strBeginnerDicSpec, "   /   ", " / ");
		strBeginnerDicSpec = ReplaceStr.replace(strBeginnerDicSpec, "  /  ", " / ");
		strBeginnerDicSpec = ReplaceStr.replace(strBeginnerDicSpec, "<b>", "");
		strBeginnerDicSpec = ReplaceStr.replace(strBeginnerDicSpec, "</b>", "");
		
			out.println("			{");
			if(sShopName.length() == 0){
				out.println("			\"type\":\"list\", "); 
				out.println("			\"modelno\":\""+sExModelNo+"\", ");
			}else{
				out.println("			\"modelno\":\""+sExID+"\", ");
			}
			out.println("			\"popularmodelno\":\""+sExModelNo+"\", ");
			out.println("			\"ca_code\":\""+strCate+"\", "); 
			out.println("			\"p_pl_no\":\""+sExID+"\", ");
			out.println("			\"goodscode\":\"\", ");
			out.println("			\"modelnm\":\""+toJS2(sExGoodsNm)+"\", ");
			if(sShopName.length() == 0){ 
			out.println("			\"mall_YN\":\""+toJS2(strMall_YN)+"\", ");
 			out.println("			\"option_YN\":\""+toJS2(strOption_YN)+"\", ");
			}else{
				
			}
			out.println("			\"factory\":\"\", ");
			out.println("			\"minprice\":\""+FmtStr.moneyFormat(sExPrice)+"\", ");
			out.println("			\"minprice3\":\""+FmtStr.moneyFormat(sExPrice)+"\", ");
			out.println("			\"copyphrase\":\"\", ");
			out.println("			\"spec\":\""+toJS2(strBeginnerDicSpec)+"\", ");
			if(strBeginnerDicSpec.length() < 29){
				out.println("			\"spec_length\":\"Y\", ");
			} 
			out.println("			\"imgurl\":\""+xstrImgurl+"\", ");
			out.println("			\"imgurl_er\":\""+ConfigManager.PHOTO_ENURI_COM+"/data/working.gif\", ");
			out.println("			\"mobileurl\":\""+sExUrl+"\", ");
			out.println("			\"soldout_n\":\"y\", ");
			out.println("			\"date\":\""+dateText+"\", ");
			out.println("			\"shopcode\":\"\", "); 
			out.println("			\"hot\":\""+strPopularCount+"\", ");
			out.println("			\"new\":\"1\" , "); 
			out.println("			\"shopname\":\""+toJS2(sShopName)+"\", ");
			if(sShopName.length() == 0){
				out.println("			\"zzimId\":\"btn_zzim_G"+sExModelNo+"\", ");
			}else{
				out.println("			\"zzimId\":\"btn_zzim_P"+sExID+"\", ");
			}
			if(sShopName.length() == 0){ 
				out.println("			\"mallcnt\":\"업체 : "+sExMallcnt+"\", ");
				out.println("			\"mallcnt3\":\""+sExMallcnt+"\", ");
			}else{
				out.println("			\"mallcnt\":\""+sShopName+"\", ");
				out.println("			\"mallcnt3\":\""+sShopName+"\", ");
			}
			out.println("			\"salecnt\":\"\" ");
			out.println("			}");
			out.println("\r\n	   ");	
			if( i < pricelist_data.length-1 ) out.println(" , ");	
		}
		out.println(" 	] ,   ");	

}
out.println("	\"zzimModel\": [ { \"Model\":\""+strZzimmodelnos+"\"  }] , ");
out.println("	\"pcate\": [ { \"pcate\":\"\"  }]  ");
out.println("  }  ");	
%>