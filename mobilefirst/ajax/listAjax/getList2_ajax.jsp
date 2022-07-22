<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.main.fashion.Price_Shop_Popular_Data"%>
<%@ page import="com.enuri.bean.main.fashion.Price_Shop_Popular_Proc"%>
<%@ page import="com.enuri.bean.main.Goods_copycate_Data"%>
<%@ page import="com.enuri.bean.main.Goods_copycate_Proc"%>
<%@ page import="com.enuri.bean.main.Pricelist_Data"%>
<%@ page import="com.enuri.bean.main.Pricelist_Proc"%>
<%@ page import="com.enuri.bean.main.Goods_Data"%>
<%@ page import="com.enuri.bean.main.fashion.Fashion_Top_Proc"%>
<%@ page import="com.enuri.bean.main.fashion.Fashion_Top_Data"%>
<%@ page import="com.enuri.bean.main.Shoplist_Data"%>
<%@ page import="com.enuri.bean.main.Shoplist_Proc"%>
<jsp:useBean id="Price_Shop_Popular_Data" class="com.enuri.bean.main.fashion.Price_Shop_Popular_Data" scope="page" />
<jsp:useBean id="Price_Shop_Popular_Proc" class="com.enuri.bean.main.fashion.Price_Shop_Popular_Proc" scope="page" />
<jsp:useBean id="Fusion_Popular_Proc" class="com.enuri.bean.main.Fusion_Popular_Proc" scope="page" />
<jsp:useBean id="Pricelist_Data" class="com.enuri.bean.main.Pricelist_Data" scope="page" />
<jsp:useBean id="Pricelist_Proc" class="com.enuri.bean.main.Pricelist_Proc" scope="page" />
<jsp:useBean id="Goods_copycate_Data" class="com.enuri.bean.main.Goods_copycate_Data" scope="page" />
<jsp:useBean id="Goods_copycate_Proc" class="com.enuri.bean.main.Goods_copycate_Proc" scope="page" />
<jsp:useBean  id="Model_log_Proc" class="com.enuri.bean.logdata.Model_log_Proc" scope="page" />
<jsp:useBean id="Fashion_Top_Proc" class="com.enuri.bean.main.fashion.Fashion_Top_Proc" scope="page" />
<jsp:useBean id="Fashion_Top_Data" class="com.enuri.bean.main.fashion.Fashion_Top_Data" scope="page" />
<jsp:useBean id="Shoplist_Proc" class="Shoplist_Proc" scope="page" />
<jsp:useBean id="Searchfunction" class="com.enuri.bean.search.SearchFunction" />
<%@ include file="/include/IncSearch.jsp"%>
<%
	String strCate = ChkNull.chkStr(request.getParameter("cate"));
	
	/*파라미터로 넘어온 카테고리 코드에 대한 검증*/
	if(strCate.trim().length() < 4 || (!CvtStr.isNumeric(strCate)) ){
	//	response.sendRedirect("/Index.jsp");
	//	return;
	}else if (Integer.parseInt(strCate.trim()) == 0){
	//	response.sendRedirect("/Index.jsp");
	//	return;
	}

	
	//System.out.println("cate:"+strCate);
	String strCa_Code = "";
	String strSt_Code = "";
	
	if(strCate.length() > 8){
		strCa_Code = CutStr.cutStr(strCate,8);
		strSt_Code = ReplaceStr.replace(strCate, strCa_Code, "");
	}else{
		strCa_Code = strCate;
	}
	
	String strLCa_Code = "";
	String strLCa_Name = "";
	if(strCate.length() >= 4){
		strLCa_Code = CutStr.cutStr(strCate,4);
	}
	Fashion_Top_Data[] data = Fashion_Top_Proc.Fashion_getTitleNames(strLCa_Code);
	strLCa_Name = data[0].getCa_name3();
	// Integer.parseInt(strShop_Code)
	String strShop_Code =  ConfigManager.RequestStr(request,"shop_code","");
	//String strSort = ConfigManager.RequestStr(request,"key","");
	String strBigImgFlag = ConfigManager.RequestStr(request,"bigimg_flag","");
	
	
	
	String strSort = ConfigManager.RequestStr(request,"sort","POPULAR");
	String strSortType = ConfigManager.RequestStr(request,"sort_type","DESC");
	
	String strSearchKind = ConfigManager.RequestStr(request,"searchKind","2");
	// 패션 스타일 메뉴를  문자로 보는지 이미지로 보고있는지 구분 
	String strIsmenutype = ConfigManager.RequestStr(request,"ismenutype","T");
	String strAndEx = ChkNull.chkStr(request.getParameter("andEx")); //안드로이드 상품창에서 돌아가기 할때 리스팅 제대로 안됨.... 개선을 위해...
	
	int intPage = ChkNull.chkInt(request.getParameter("page"),1);
	int intPageCount = 10; //page cnt
	int intPageContentCnt = ChkNull.chkInt(request.getParameter("pagesize"),0);; //한페이지의 컨텐츠 개수
	int intTotalCnt = 0;
	
	int cPage = intPage;
	int nPageSize = intPageContentCnt;

	int[][] intPriceRangeAndCnt = null;
	
	String strGetShop = ChkNull.chkStr(request.getParameter("shop_code"),"");
	
	//최저가 파라미터
	String strMPrice = ChkNull.chkStr(request.getParameter("m_price"));
	String strStartPrice = ChkNull.chkStr(request.getParameter("start_price"));
	String strEndPrice = ChkNull.chkStr(request.getParameter("end_price"));	
	if (strStartPrice.trim().length() > 0 && strEndPrice.trim().length() > 0 ){
		strMPrice = strStartPrice + "~" + strEndPrice;
	}
	//System.out.println("strMPrice===="+strMPrice);
	/*다이퀘스트검색 검색어 처리 부분*/
	String strKeyword = ConfigManager.RequestStr(request,"keyword","");
	String strOrgKeyword = strKeyword;//원래키워드
	String strLogKeyword = strKeyword;//로그용 키워드
	String strSeperatedKeyword = seperate(strOrgKeyword);
	String strSearchKeyword = Searchfunction.removeExceptionKeyword(strSeperatedKeyword);
	//동의어 찾기
	if (bEnuriSynonym){
		strSearchKeyword = Searchfunction.getSynonym(strSearchKeyword);
	}
	/*다이퀘스트검색 검색어 처리 부분*/
	
	
	//정렬 전 단계
	String szMode = ChkNull.chkStr(request.getParameter("mode"),"wlist");
	String strKey = "";	
	if (szMode.trim().equals("wlist")){
		strKey = ChkNull.chkStr(request.getParameter("key"),"");
	}else{
		strKey = ChkNull.chkStr(request.getParameter("key"),"");
	}
//System.out.println("S_intPageContentCnt:"+intPageContentCnt);
//System.out.println("S_nPageSize:"+nPageSize);
%>
<%@ include file="/include/IncSetSortSession_Fusion.jsp"%>
<%
//변수 change필요함
//System.out.println("E_intPageContentCnt:"+intPageContentCnt);
//System.out.println("E_nPageSize:"+nPageSize);
	nPageSize = 20;
	
	intPageContentCnt = nPageSize;
	
	if (strKey.trim().equals("PRICE")){
		if(CutStr.cutStr(strCate,2).equals("14")){
			strKey = "PRICE DESC";//패션 정렬
		}
	}
	
	if (strKey.toUpperCase().trim().equals("MINPRICE") || strKey.toUpperCase().trim().equals("MINPRICE3")){
		if (szMode.trim().equals("wlist")){
		    strKey = "price asc";
		}else{
		   strKey = "minprice asc";
		}
	}	
	String strFusionOrder = "";	
	strKey = ReplaceStr.replace(strKey.toUpperCase(),"C_DATE","REGDATE");
	if (strKey.toUpperCase().trim().equals("MINPRICE DESC") || strKey.toUpperCase().trim().equals("MINPRICE3 DESC") ){
		if (szMode.trim().equals("wlist")){
		    strKey = "PRICE ASC";
		    strFusionOrder = "1";
		}else{
		   strKey = "minprice ASC";
		}	
	}
	 
	//정렬
	strSort = "";
	strSortType ="";
	strSort = strKey.trim().length() == 0 ? "POPULAR DESC" : strKey;
	if (strSort.trim().indexOf(" ") >= 0 ){
		strSortType = strSort.trim().substring(strSort.trim().indexOf(" "),strSort.trim().length());
		strSort = strSort.trim().substring(0,strSort.trim().indexOf(" "));		
	}else{
		strSortType = "DESC";
	}
	
	Price_Shop_Popular_Proc price_shop_popular_proc = new Price_Shop_Popular_Proc();
	Price_Shop_Popular_Data[] price_shop_popular_data = null;
	
	String gubun = "3";
	//boolean insert_check = Model_log_Proc.Cate_log_Insert(strCate,gubun);
	
	String strMName = "";
	if(strCate.length()>=4){
		Category_Data category_name_data = Category_Proc.Category_One_1(CutStr.cutStr(strCate,4));
		if(category_name_data!=null){
			strMName=category_name_data.getC_name();
		}	
	}
	
	Goods_Data[] goods_shop_data = null;

	int intGoods_No = 0;
	String strGoodsimgname = "";
	String strGoodsurl = "";
	String strGoods_Date = "";
	String strGoods_Etc = "";
	int intGoods_Count = 0;
	String strQueryOut = "";
	Long[] lngPricelist = null;
	String[] astrGetShop =null;
	strGetShop = ReplaceStr.replace(strGetShop,"+"," ");
	astrGetShop = strGetShop.split(",");
%>
<%@ include file="/fashion/clothes/include/Inc_Clothes_List_Search_Proc.jsp"%>
<%
int intTotRsCnt = intTotalCnt;
int nPageCntCnt = 20;

int intWebListCnt = intTotRsCnt;//웹상품 검색 갯수


int iEndPage = intPage*20;
String pageGubun = "";

if(iEndPage > intTotRsCnt){
	iEndPage = intTotRsCnt;
}

String pagingBar = iEndPage + ""  ;	//페이징 텍스트부분
		
//System.out.println("goods_shop_data.length===="+goods_shop_data.length);
//System.out.println("price_shop_popular_data.length:"+price_shop_popular_data.length);
//System.out.println("intTotRsCnt:"+intTotRsCnt);
//System.out.println("nPageSize:"+nPageSize);
//System.out.println("nPageCntCnt"+nPageCntCnt);

if(price_shop_popular_data==null || price_shop_popular_data.length==0){
%>
<div>상품이 없습니다.</div>
<%
}else{
%>
<%
	int i = 0;
	int j = 0;
	
%>

<%
String strGoodsNm = "";
String tmpPopular = "";
String strPrice = "";
String strSearckKeywordSynonym = "";
String xstrImgurl = "";
String strPCa_Code = "";
String strPCate = "";
String strZzimmodelnos = "";
String strUdate = "";
String dateText = "";

out.println(" { ");
int intShopAllCnt = 0;

//상세검색내 가격대 
int intSelectedPriceCount = 0;
if ((strSearchKeyword.trim().length() == 0 && !isAddSearchCate(strCate) && Integer.parseInt(ConfigManager.RequestStr(request,"brand2no","0")) == 0) || ChkNull.chkStr(request.getParameter("prtmodelno")).trim().length() > 0 ){
	int intStartPrice = (int)(lngPricelist[0].longValue()/10000) * 10000; //시작가 (표시용)
	int intMinPriceRange = (int)lngPricelist[0].longValue();//최저가
	int intMaxPriceRange = (int)lngPricelist[lngPricelist.length-1].longValue();//최고가
	int intTerm  = 0;
	int intTermCnt = 0;
	if ( (intMaxPriceRange-intMinPriceRange) <= 240000 ){ //최저가와 최고가 가격차이가 24만원 이하면 
		intTerm = 10000; //한칸의 가격은 무조건  만원이고
		intTermCnt = (int)((intMaxPriceRange+10000)/10000)-(int)(intMinPriceRange/10000) + 1;
		intPriceRangeAndCnt = new int[intTermCnt][2];										
		for (i=0;i<intTermCnt;i++){
			intPriceRangeAndCnt[i][0] = intStartPrice + 10000 * i;
		}
		intPriceRangeAndCnt[intTermCnt-1][0] = ((int)lngPricelist[lngPricelist.length-1].longValue())/10000*10000+10000;
	}else{ //최저가와 최고가 가격차이가 25만원 이상이면
		int intPrevPrice = -1;
		float fltPlusTerm = ((float)lngPricelist.length/(float)25);
		intTermCnt = 0;		
		float fltTemp = 0;
		int intTemp = 0;
		for (int ii=0;ii<lngPricelist.length;ii=intTemp){	
			if (intPrevPrice < ((int)lngPricelist[ii].longValue())/10000*10000 ){
				intPrevPrice = ((int)lngPricelist[ii].longValue())/10000*10000;
				intTermCnt++;
			}else if (intPrevPrice == ((int)lngPricelist[ii].longValue())/10000*10000 ){
				for (int kkk=ii;kkk<lngPricelist.length;kkk++){
					if (intPrevPrice < ((int)lngPricelist[kkk].longValue())/10000*10000 ){
						ii=kkk;
						break;
					}
				}
			}
			fltTemp = fltTemp + fltPlusTerm + 0.5f;
			Float fltTemp2 = new Float(fltTemp);											
			intTemp = fltTemp2.intValue();
		}	
		if (intTermCnt == 25 || intTermCnt == 1){
			intTermCnt++;
		}
		intPriceRangeAndCnt = new int[intTermCnt][2];
		intTermCnt = 0;
		intPrevPrice = -1;
		fltTemp = 0;
		intTemp = 0;										
		for (int ii=0;ii<lngPricelist.length;ii=intTemp){	
			if (intPrevPrice < ((int)lngPricelist[ii].longValue())/10000*10000 ){
				intPrevPrice = ((int)lngPricelist[ii].longValue())/10000*10000;
				intPriceRangeAndCnt[intTermCnt][0] = intPrevPrice;
				intTermCnt++;
			}else if (intPrevPrice == ((int)lngPricelist[ii].longValue())/10000*10000 ){
				for (int kkk=ii;kkk<lngPricelist.length;kkk++){
					if (intPrevPrice < ((int)lngPricelist[ii].longValue())/10000*10000 ){
						ii=kkk;
						break;
					}												
				}
			}
			fltTemp = fltTemp + fltPlusTerm + 0.5f;
			Float fltTemp2 = new Float(fltTemp);											
			intTemp = fltTemp2.intValue();						
		}					
		if (intTermCnt == 25 || intTermCnt == 1){
			intTermCnt++;
		}
		intPriceRangeAndCnt[intTermCnt-1][0] = ((int)lngPricelist[lngPricelist.length-1].longValue())/10000*10000+10000;
	}
	String strStartTxtPrice = strStartPrice;
	String strEndTxtPrice = strEndPrice;
	
	for (j=0;j<intTermCnt-1;j++){	
		int intPriceRangeCount = 0;							
		int intF = intPriceRangeAndCnt[j][0];
		int intE = intPriceRangeAndCnt[j+1][0];
		for (i=0;i<lngPricelist.length;i++){	//가격갯수만큼 돌면서 각각의 가격대에 있으면 Count++	
			if ( (i == lngPricelist.length-1) && (j == intTermCnt-2) ){
				if ((int)lngPricelist[i].longValue() >= intF && (int)lngPricelist[i].longValue() <= intE ){
					intPriceRangeCount++;
				}										
			}else{
				if ((int)lngPricelist[i].longValue() >= intF && (int)lngPricelist[i].longValue() < intE ){
					intPriceRangeCount++;
				}
			}
		}
		intPriceRangeAndCnt[j][1] = intPriceRangeCount;	//두번째는 카운트								
	}

	if (strKeyword.trim().length() == 0 && !isAddSearchCate(strCate) && !CutStr.cutStr(strCate,2).equals("14") && !ChkNull.chkStr(request.getParameter("brand_add_search"),"").equals("Y")){
		if (strStartTxtPrice.trim().length() == 0 ){
			strStartTxtPrice = lngPricelist[0]+""; 
		}
		if (strEndTxtPrice.trim().length() == 0 ){ 
			strEndTxtPrice = lngPricelist[lngPricelist.length-1]+""; 
		}	
	}else{
		if (strStartTxtPrice.trim().length() == 0 ){
			strStartTxtPrice = intPriceRangeAndCnt[0][0]+""; 
		}
		if (strEndTxtPrice.trim().length() == 0 ){
			strEndTxtPrice = intPriceRangeAndCnt[intPriceRangeAndCnt.length-1][0]+""; 
		}
	}
	out.println("	\"priceList\":[ { \"minPirce\":\""+FmtStr.moneyFormat(strStartTxtPrice)+"\" ,  \"maxPirce\":\""+FmtStr.moneyFormat(strEndTxtPrice)+"\" } ] , ");		
}
//쇼핑몰탭 데이터	
if(goods_shop_data!=null){
	if(goods_shop_data.length>0 || (goods_shop_data.length==0)){
		ArrayList arrayAllShop = new ArrayList();
		Goods_Data[] goods_All_Shop_data = goods_shop_data;
		
 		if (goods_All_Shop_data != null) {
 			Arrays.sort(goods_All_Shop_data,new com.enuri.bean.main.Factory_Mallcount_Comparator());
 			intShopAllCnt = goods_All_Shop_data.length;
 		}
 		int intAllGoods = 0;
		for (int k3=0; k3 < goods_All_Shop_data.length ;k3++){
			intAllGoods = intAllGoods + goods_All_Shop_data[k3].getPopular();
		}	

		Goods_Data goods_Shop_single = new Goods_Data();
	
		int iPage = 0;
		String strNext = "";	// 줄넘김 구분자
		String strChecked = ""; // 선택된 제조사
		String strShopName = "";

		int iPage2 = 0;
		if(intShopAllCnt % 15 > 0){
			iPage2 = (intShopAllCnt / 15 ) + 1 ;
		}else{
			iPage2 = intShopAllCnt / 15;
		}
		
		j = -1;
		for (i=1 ;i < intShopAllCnt+1 ;i++){
			goods_Shop_single = goods_All_Shop_data[i-1];  
			if (goods_Shop_single.getFactory().trim().length() > 0){
				j = j+1; 							
				strChecked = "";
				strShopName = goods_Shop_single.getFactory().trim();
				if(j==0) out.println("	\"factoryPage\":[ { \"pageCnt\":\""+intShopAllCnt/5+"\" } ]  ");
				if(j==0) out.println("	,\"factoryNav\":[ { \"allCnt\":\""+intShopAllCnt+"\" , \"pageCnt\":\""+iPage2+"\"  } ]  ");
				if(j==0) out.println("	,\"factoryList\": [");
 
				for (int af=0;af<astrGetShop.length;af++){
					if (astrGetShop[af].trim().equals(goods_Shop_single.getFactory_etc().trim())){
						strChecked = "checked ";
					}
				}	
					if(j % 15 == 14 ) 	strNext = "0";
					if(j>0) out.print(",\r\n");
					//out.print("	{                                       \"factoryNo\":\""+i+"\", \"factoryId\":\""+goods_Shop_single.getFactory_etc()+"\", \"factoryHot\":\"\", \"factoryChk\":\""+strChecked+"\", \"factoryName\":\""+strShopName+"\", \"factoryCnt\":\""+goods_Shop_single.getPopular()+"\" , \"factoryNext\":\""+strNext+"\" }");
					out.print("		{  \"factoryGroup\":\""+((j/15)+1)+"\", \"factoryNo\":\""+j+"\", \"factoryId\":\""+goods_Shop_single.getFactory_etc()+"\", \"factoryHot\":\"\", \"factoryChk\":\""+strChecked+"\", \"factoryName\":\""+strShopName+"\", \"factoryCnt\":\""+goods_Shop_single.getPopular()+"\" , \"factoryNext\":\""+strNext+"\" }");
				if(i == intShopAllCnt ) out.println("\r\n	] 	,");
				strNext = "";
			} 
		}
		if(intShopAllCnt > 0 && i < intShopAllCnt ){
			out.println(" }"); 
		}	
		
	}
}
// 리스트데이터
out.println("   	\"ad_command\": \"\" , ");
out.println("	\"goodsCnt\": [ { \"cnt\":\""+FmtStr.moneyFormat(intTotRsCnt)+"\" } ] , ");
out.println("	\"goodsPageBar\": [ { \"pageBar\":\""+pagingBar+"\" ,  \"cnt\":\""+FmtStr.moneyFormat(intTotRsCnt)+"\" }] , ");
out.println(" 	\"goodsList\": [ ");
	
// 검색어 색 바꾸는 부분  Searchfunction.getNoRelaceSynonym(strKeyword)을 가져온뒤 Searchfunction.IsIn 통해 바꿔준다 
for(i = 0 ; i < price_shop_popular_data.length ;i++){
	if (strKeyword.trim().length() > 0 ){
		strSearckKeywordSynonym = Searchfunction.getNoRelaceSynonym(strKeyword);
	}
	xstrImgurl = price_shop_popular_data[i].getImageurl();
	strGoodsNm = price_shop_popular_data[i].getGoodsnm();
	strGoodsNm = java.net.URLEncoder.encode(strGoodsNm,"UTF-8");
						
	strPrice = "";
	//가격정보를 tbl_pricelist에서 가져옴
	Pricelist_Data pricelist_data_info = Pricelist_Proc.getPrice_info(price_shop_popular_data[i].getPl_no());
    if(pricelist_data_info!=null){
    	strPrice  = pricelist_data_info.getPrice()+"";
    }else{
    	strPrice = "" + price_shop_popular_data[i].getPrice();
    }
	strPCa_Code = price_shop_popular_data[i].getCa_code(); 
	if (strPCate.trim().length() == 0 ){ 
		strPCate = strPCa_Code;
	}	
	if(strZzimmodelnos.length() == 0 ){
		strZzimmodelnos = "P:"+price_shop_popular_data[i].getPl_no()+"";
	}else{
		strZzimmodelnos = strZzimmodelnos + ",P:"+price_shop_popular_data[i].getPl_no()+"";
	}	
			
								   
    long pl_no = 0;
    pl_no = price_shop_popular_data[i].getPl_no();
    
    String file_type = xstrImgurl.substring(xstrImgurl.lastIndexOf(".")+1,xstrImgurl.length()).toLowerCase();
    String strImageUrl = "";
    if(file_type.equals("jpg") || file_type.equals("gif")){
    	strImageUrl = ConfigManager.IMAGE_ENURI_COM + "/webimage2/" + ImageUtil.ImgFolder2(pl_no) + "/" + pl_no + "." + xstrImgurl.substring(xstrImgurl.lastIndexOf(".")+1,xstrImgurl.length()).toLowerCase();
    }else{
    	strImageUrl = ConfigManager.IMAGE_ENURI_COM + "/webimage2/" + ImageUtil.ImgFolder2(pl_no) + "/" + pl_no;
    }
	String strShopCode = price_shop_popular_data[i].getShop_code()+"";
	String strShopName = "";
	
	if(strShopCode.equals("55")){
		strShopName = "인터파크";
	}else if(strShopCode.equals("536")){
		strShopName = "G마켓";
	}else if(strShopCode.equals("4027")){
		strShopName = "옥션";
	}else if(strShopCode.equals("5910")){
		strShopName = "11번가";
	}else{
		strShopName = Shoplist_Proc.getShopname(ChkNull.chkInt(strShopCode));
		if(CutStr.LenH(strShopName)>10){
	 		strShopName = CutStr.MidH(strShopName,1,10);
	 	 }
	}
	
  	strUdate = price_shop_popular_data[i].getRegdate();
	dateText = "";
	 
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
	
	if( strUdate.length() >= 4 ){
		if( cdateYear < nowYear ) {
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
			out.println("			{");
 			out.println("			\"type\":\"\", ");
			out.println("			\"modelno\":\""+price_shop_popular_data[i].getPl_no()+"\", ");
			out.println("			\"popularmodelno\":\"\", ");
			out.println("			\"ca_code\":\""+price_shop_popular_data[i].getCa_code()+"\", ");
			out.println("			\"p_pl_no\":\""+price_shop_popular_data[i].getPl_no()+"\", ");
			out.println("			\"goodscode\":\""+price_shop_popular_data[i].getGoodscode()+"\", ");
			out.println("			\"modelnm\":\""+toJS2(price_shop_popular_data[i].getGoodsnm())+"\", ");
			out.println("			\"mall_YN\":\"\", ");
 			out.println("			\"option_YN\":\"\", ");
 			out.println("			\"factory\":\"\", ");
 			out.println("			\"minprice\":\""+FmtStr.moneyFormat(strPrice)+"\", ");
 			out.println("			\"minprice3\":\""+FmtStr.moneyFormat(strPrice)+"\", ");
 			out.println("			\"copyphrase\":\"\", ");
			out.println("			\"imgurl\":\""+xstrImgurl+"\", ");
			out.println("			\"imgurl_er\":\""+ConfigManager.PHOTO_ENURI_COM+"/data/working.gif\", ");
			out.println("			\"mobileurl\":\""+price_shop_popular_data[i].getUrl()+"\", ");
			out.println("			\"soldout_n\":\"y\", ");
			out.println("			\"date\":\""+dateText+"\", ");
			out.println("			\"shopcode\":\""+price_shop_popular_data[i].getShop_code()+"\", "); 
			out.println("			\"new\":\"1\" , ");
			out.println("			\"shopname\":\""+strShopCode+"\", ");
			out.println("			\"zzimId\":\"btn_zzim_P"+price_shop_popular_data[i].getPl_no()+"\", ");
			out.println("			\"mallcnt\":\""+strShopName+"\", ");
			out.println("			\"mallcnt3\":\""+strShopName+"\", ");
			out.println("			\"salecnt\":\"\" ");
			out.println("			}");
			out.println("\r\n	   ");	
			if( i < price_shop_popular_data.length-1 ) out.println(" , ");	
			
}
	 out.println(" 	] ,   ");	
	 out.println("	\"zzimModel\": [ { \"Model\":\""+strZzimmodelnos+"\"  }] , ");
	 out.println("	\"pcate\": [ { \"pcate\":\""+strPCate+"\"  }]  ");
	 out.println("  }  ");	
}
%>

