<%@ page contentType="text/html; charset=utf-8"%>
<%@ page pageEncoding="utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ include file="/mobiledepart/include/common.jsp"%>
<%@ page import="com.enuri.api.Pricelist_Api"%>
<%@ page import="com.enuri.bean.mobile.depart.Save_Goods_Proc"%>
<%@ page import="com.enuri.bean.main.Save_Goods_Data"%>
<%@ page import="com.enuri.bean.main.Save_PriceList_Data"%>
<%@ page import="com.enuri.bean.main.Goods_Data"%>
<%@ page import="com.enuri.bean.main.Goods_Proc"%>
<%@ page import="com.enuri.bean.main.depart.Depart_Goods_Proc"%>
<%@ page import="com.enuri.bean.main.depart.Depart_Goods_Data"%>
<%@ page import="com.enuri.bean.main.Pricelist_Data"%>
<%@ page import="com.enuri.bean.main.Pricelist_Proc"%>
<%@ page import="com.enuri.bean.knowbox.Know_termdic_title_Proc"%>
<%@ page import="com.enuri.bean.knowbox.Know_termdic_title_Data"%>
<jsp:useBean id="Searchfunction" class="com.enuri.bean.search.SearchFunction" />
<jsp:useBean id="Know_termdic_title_Proc" class="Know_termdic_title_Proc" scope="page" />
<jsp:useBean id="Pricelist_Proc" class="com.enuri.bean.main.Pricelist_Proc" scope="page" />
<%@ page import="com.enuri.bean.mobile.FactoryBrand_Proc"%>
<%@ page import="com.enuri.bean.mobile.FactoryBrand_Data"%>
<jsp:useBean id="FactoryBrand_Proc" class="FactoryBrand_Proc" scope="page" />
<%@ include file="/include/IncSearch.jsp"%>
<%@ include file="/include/IncGroupTool_2010.jsp"%>
<%
	boolean bAdultKeyword = false;
	String strCate = "";
%>
<%@ include file="/include/IncSponsorGoods_2010.jsp"%>
<%@ include file="/include/IncAdultKeywordCheck_2010.jsp" %>
{
<%

String pageString = ChkNull.chkStr(request.getParameter("pageNum"),"1");
if(pageString.equals("NaN")) pageString = "1"; 

// 페이징 관련 추가
int pageNum = Integer.parseInt(pageString);
int pageGap = Integer.parseInt(ChkNull.chkStr(request.getParameter("pageGap"), "10"));
int totalCnt = 0;
int allTotalCnt = 0;
int pageStart = (pageNum-1) * pageGap + 1;
int pageEnd = pageStart + pageGap - 1;
int pageMax = 1;

String strUserId = "";

String goodsList = ChkNull.chkStr(request.getParameter("goodsList"), ""); 

int goodsCnt = 0;
long priceSum = 0;

Save_Goods_Proc save_goods_proc = new Save_Goods_Proc();
Goods_Data[] goods_data = null;
HashMap cardNameHash  = getCardNameHash();

//쇼핑몰 카드 무이자 할부 정보
String[][] cardFreeAry = Pricelist_Proc.getPriceList_CardFree();

strUserId = cb.GetCookie("MYINFO","TMP_ID");

String strTodayGoods = "";
strTodayGoods = goodsList;

if(pageNum>0) {
	String tempListStr = "";
	String[] tempListAry = strTodayGoods.split("\\,");

	// 불필요한 데이터를 먼저 제거
	totalCnt = 0;
	for(int i=0; i<tempListAry.length; i++) {
		if(tempListAry[i].indexOf(":") > 0) {
			totalCnt++;
			
			if(totalCnt>=pageStart && totalCnt<=pageEnd) {
				if(tempListStr.length()>0) tempListStr += ",";
				tempListStr += tempListAry[i];
			}
		}
	}

	pageMax = (int)Math.ceil((double)totalCnt/pageGap);

	strTodayGoods = tempListStr;
}
allTotalCnt = totalCnt;

Goods_Proc goods_proc = new Goods_Proc();
ArrayList arrayTodayGoods = new ArrayList();

if(strTodayGoods.trim().length()>0) {
	
	String astrTodayGoods[] = strTodayGoods.split("\\,");
	for(int i=0; i<astrTodayGoods.length; i++) {
		String strTodayGoodsOne = astrTodayGoods[i];
		if(strTodayGoodsOne.indexOf(":") > 0) {
		
			if(strTodayGoodsOne.split(":")[0].equals("G") && ChkNull.chkNumber(strTodayGoodsOne.split(":")[1])) {
				int nModelNo = Integer.parseInt(strTodayGoodsOne.split(":")[1]);
				Goods_Data goods_data_one = save_goods_proc.Goods_One(nModelNo,0);

				if(goods_data_one != null) {
					goods_data_one.setModelno(nModelNo);
					goods_data_one.setKb_num1(goods_data_one.getKb_num());
					arrayTodayGoods.add(goods_data_one);
				}
			} else if (strTodayGoodsOne.split(":")[0].equals("P") && ChkNull.chkNumber(strTodayGoodsOne.split(":")[1])) {
			
				long nPlNo = Long.parseLong(strTodayGoodsOne.split(":")[1]);
				Pricelist_Data pricelist_data_info = save_goods_proc.getPricelistData(nPlNo);

				if(pricelist_data_info != null) {
					// 상품명 자동변경 적용
					String tempGoodsnm = getGoodsNmReplace2(pricelist_data_info.getShop_code(), pricelist_data_info.getGoodsnm(), pricelist_data_info.getPrice(), pricelist_data_info.getCa_code(), false, pricelist_data_info.getFreeinterest(), cardFreeAry);
					pricelist_data_info.setGoodsnm(tempGoodsnm);
					Goods_Data goods_data_one = new Goods_Data();
					goods_data_one.setP_pl_no(nPlNo);
					goods_data_one.setCa_code(pricelist_data_info.getCa_code());
					goods_data_one.setModelnm(pricelist_data_info.getGoodsnm());
					goods_data_one.setMinprice(pricelist_data_info.getPrice_long());
					goods_data_one.setMinprice3(pricelist_data_info.getPrice_long());
					goods_data_one.setFactory(pricelist_data_info.getShop_name());
					goods_data_one.setP_imgurl(pricelist_data_info.getImgurl());
					goods_data_one.setGb1_no(pricelist_data_info.getShop_code());
					goods_data_one.setGoods_info(pricelist_data_info.getDeliveryinfo());
					goods_data_one.setUrl1(pricelist_data_info.getUrl());
					goods_data_one.setCa_code(pricelist_data_info.getCa_code());
					goods_data_one.setGoods_info_date(pricelist_data_info.getFreeinterest());
					goods_data_one.setMallcnt(1);
					goods_data_one.setP_imgurl2("SHOP");
					goods_data_one.setFunc(pricelist_data_info.getSrvflag());
					goods_data_one.setProduct_id(pricelist_data_info.getGoodscode());
					goods_data_one.setC_date(pricelist_data_info.getU_date());
					goods_data_one.setFactory_etc(pricelist_data_info.getGoodsfactory());
					goods_data_one.setModelno_group(pricelist_data_info.getModelno());
					// 모바일 가격
					goods_data_one.setTmp_price(pricelist_data_info.getInstance_price());

					arrayTodayGoods.add(goods_data_one);
				}
			}
		}
	}
	goods_data = (Goods_Data[])arrayTodayGoods.toArray(new Goods_Data[0]);
}

int totalLength = 0;

totalLength = totalCnt;

out.println("	\"myGoodsTotalCnt\":\""+totalLength+"\",");
out.println("	\"myGoodsAllTotalCnt\":\""+allTotalCnt+"\",");

if(goods_data!=null && goods_data.length>0) {
	String strSearckKeywordSynonym = "";

	out.println("	\"goodsList\": [");
	boolean listFirstPrintFlag = false;
	for(int i=0; i<goods_data.length; i++) {

		int modelno = goods_data[i].getModelno();
		long p_pl_no = goods_data[i].getP_pl_no();
		String ca_code = goods_data[i].getCa_code();
		String modelnm = goods_data[i].getModelnm();
		long minprice = goods_data[i].getMinprice3();
		int sale_cnt = goods_data[i].getSale_cnt();
		String factory = goods_data[i].getFactory();
		String imgchk = goods_data[i].getImgchk();
		String p_imgurl = goods_data[i].getP_imgurl();
		int gb1_no = goods_data[i].getGb1_no();
		String url1 = goods_data[i].getUrl1();
		String p_imgurlflag = goods_data[i].getP_imgurlflag();
		String smallImageUrl = ImageUtil.getImageSrc(CutStr.cutStr(ca_code,4), modelno, imgchk, p_pl_no, p_imgurl, p_imgurlflag);
		String middleImageUrl = "";


		String departImgSrc ="";

		String dept_yn = ChkNull.chkStr(goods_data[i].getDept_yn());

	//	System.out.println("dept_yn : "+dept_yn);

		int intDept_code = 0;
		String departlogo = "";
		int szVcode = 0;
		String strShopnm = "";
		//String maxprice = "";
		String departName = "";

		long maxprice = goods_data[i].getMaxprice();

		if("Y".equals(dept_yn)){

			departImgSrc = getDepartImgSrc(ca_code,modelno,imgchk, p_pl_no , p_imgurl, p_imgurlflag);

			Depart_Goods_Proc depart_goods_proc =  new Depart_Goods_Proc();
			Depart_Goods_Data depart_goods_data = new Depart_Goods_Data();
			depart_goods_data = depart_goods_proc.getMinShop(modelno);

			if(depart_goods_data !=null){
				intDept_code = depart_goods_data.getMin_pl_dept();
				szVcode =  depart_goods_data.getMin_pl_shop();
				strShopnm = getShopName(_shop_code, szVcode+"");
				maxprice = depart_goods_data.getMax_pl_price();

				minprice = depart_goods_data.getMin_pl_price();

				departName = getDeptName(_dept_code, intDept_code+"");
				departlogo = getDepartLogo(intDept_code+"");

			}
		}
		
		String strFactory = ChkNull.chkStr(goods_data[i].getFactory());
		String strBrand = ChkNull.chkStr(goods_data[i].getBrand());
		
		if(modelno > 0){

			String strModelnmText[] = getModel_FBN(ca_code, modelnm, strFactory ,strBrand);
			String strNm_factory = toJS2(strModelnmText[1]);
			String strNm_brand   = toJS2(strModelnmText[2]); 
			String strNm_model  = toJS2(strModelnmText[0]);

			if(!ca_code.equals("93")){ 
				if(strNm_model.lastIndexOf("[")>0){ 
					strNm_model = strNm_model.substring(0,strNm_model.lastIndexOf("["));
				} 
			}
			
			String modelName = strNm_factory + " "+ strNm_brand+ " "+ strNm_model; 
			modelnm = toJS2(modelName.replace("  "," ").trim());
		
		}

		// 유사상품일 경우 이미지 경로가 바뀜
		if(imgchk.equals("G")) smallImageUrl = goods_data[i].getP_imgurl2();

		int kb_num = goods_data[i].getKb_num();
		String kb_title = HtmlStr.removeHtml(goods_data[i].getKb_title());
		kb_title = ReplaceStr.replace(ReplaceStr.replace(ReplaceStr.replace(kb_title,"'",""),"\"",""),"[뉴스]","");

		String keyword2 = goods_data[i].getKeyword2();
		keyword2 = ReplaceStr.replace(keyword2,"\r\n", "");
		keyword2 = ReplaceStr.replace(keyword2,"  ", " ");
		keyword2 = ReplaceStr.replace(keyword2,"★", "");
		keyword2 = ReplaceStr.replace(keyword2,"▶", "");
		//keyword2 = ReplaceStr.replace(keyword2,"★", "▶");

		String strSpec = goods_data[i].getSpec_group();
		if(strSpec.trim().length()==0) strSpec = goods_data[i].getSpec();
        if(CutStr.cutStr(ca_code,2).equals("15") && strSpec.trim().length()==0) strSpec = modelnm;

		// 출시일
		String c_date = goods_data[i].getC_date();
		c_date = CutStr.cutStr(c_date,10);
		String c_dateStr = c_date;

		if(c_dateStr.length()==10) {
			java.util.Calendar calend = java.util.Calendar.getInstance();
			String nowYear = calend.get(cal.YEAR) + "";

			// 현재 년도랑 같을 경우에만  년, 월로 표시
			if(c_dateStr.substring(0, 4).equals(nowYear)) {
				c_dateStr = c_dateStr.substring(2, 7);
				c_dateStr = ReplaceStr.replace(c_dateStr, "-0", "-");
			} else {
				c_dateStr = c_dateStr.substring(2, 4);
			}
		}
		if(c_dateStr.indexOf("-")>-1) {
			c_dateStr = "'" + ReplaceStr.replace(c_dateStr, "-", "년 ") + "월";
		} else {
			c_dateStr = "'" + c_dateStr+ "년";
		}

		// 요약 / 좌우 공백 안들어가 있음
		strSpec = ReplaceStr.replace(strSpec, "</", "****");
		strSpec = ReplaceStr.replace(strSpec, "/", " / ");
		strSpec = ReplaceStr.replace(strSpec, "****", "</");

		// 패션(14), 유사상품 모델은 요약칸에 모델명 나오도록 함
		// 유사상품은 스펙에 모델명이 나오지 않게~
		//if(imgchk.equals("G") || CutStr.cutStr(ca_code,2).equals("14")) {
		if((CutStr.cutStr(ca_code,2).equals("14") || CutStr.cutStr(ca_code,2).equals("15")) && strSpec.trim().length() == 0 ) {
			strSpec = modelnm;
			strSpec = ReplaceStr.replace(strSpec, "특가!", "");
		}

		modelnm = ReplaceStr.replace(modelnm,"[일반]","");

		// 모델명과 조건명[ 사이 한칸 공백
		modelnm = ReplaceStr.replace(modelnm, "[", " [");
		/*
		// 조건명 []는 볼드체 제외
		// ※패션(14), 도서,음반(93) 모델명의 []는 조건명 아니므로 볼드체로 나오도록 함
		if(!CutStr.cutStr(ca_code,2).equals("14") && !CutStr.cutStr(ca_code,2).equals("93")) {
			if(modelnm.indexOf("[")>-1 && modelnm.indexOf("]")>-1) {
				modelnm = ReplaceStr.replace(modelnm, "[", "<span class=normalWeight>[") + "</span>";
			}
		}
		// 휴대폰(0304) 모델명-조건명 앞의 ()내용은 볼드체 제외
		if(CutStr.cutStr(ca_code,4).equals("0304")) {
			int sIdx = modelnm.indexOf("(");
			int eIdx = modelnm.indexOf(")") + 1;

			if(sIdx>0 && eIdx>0) {
				modelnm = modelnm.substring(0, sIdx) + "<span class=normalWeight>" + modelnm.substring(sIdx, eIdx) + "</span>" + modelnm.substring(eIdx);
			}
		}
		*/

		// 찜한 날짜
		String moddate = goods_data[i].getModdate();

		// yyyy-mm-dd/hh24:mi 이런 형태를 변환함
		// 년도 제거하기
		//if(moddate.indexOf("-")>-1 && moddate.indexOf("-")!=moddate.lastIndexOf("-")) {
		//	moddate = moddate.substring(moddate.indexOf("-")+1);
		//}
		//if(moddate.length()>1 && moddate.charAt(0)=='0') moddate = moddate.substring(1);
		//moddate = ReplaceStr.replace(moddate, "-0", "-");
		//moddate = ReplaceStr.replace(moddate, "-", "월 ");
		//moddate = ReplaceStr.replace(moddate, "/", "일 ");

        int mallcnt = goods_data[i].getMallcnt3();

		keyword2 = ReplaceStr.replace(keyword2,"\"","&quot;");
		modelnm = ReplaceStr.replace(modelnm,"\"","&quot;");
		strSpec = ReplaceStr.replace(strSpec,"\"","&quot;");

		strSpec = ReplaceStr.replace(strSpec,"\r\n"," ");
		strSpec = ReplaceStr.replace(strSpec,"\n"," ");
		strSpec = ReplaceStr.replace(strSpec,"\r"," ");


		// 더큰 사진 여부 체크
		String bBigImageYN = "N";
		if(imgchk.equals("6")) {
			bBigImageYN = "Y";
		}

		// 배송비 정보 읽어오기
		String goods_info = goods_data[i].getGoods_info();
		if(!goods_info.equals("무료배송")) {
			int intGoods_info = -1;
			try {
				intGoods_info = Integer.parseInt(goods_info);
			} catch(Exception e) {}
			if(intGoods_info>-1) {
				goods_info = "배송:" + FmtStr.moneyFormat(goods_info) + "원";
			}
		}

		// 가격 정보 보여주기
		String minPriceText = "";
		if(goods_data[i].getMallcnt3()==1 && DateUtil.getDaysBetween(c_date,DateStr.nowStr())>0) {
			minPriceText = "미정";
			mallcnt = 0;
		} else if((goods_data[i].getOpenexpectflag().equals("1") || DateUtil.getDaysBetween(c_date,DateStr.nowStr())>0 ) && goods_data[i].getIsgroup() != 1) {
			minPriceText = "미정";
			mallcnt = 0;
		} else {
			if ((CutStr.cutStr(ca_code,4).equals("0304") || CutStr.cutStr(ca_code,4).equals("0305") || CutStr.cutStr(ca_code,4).equals("0353")) && minprice==0){
				minPriceText = "클릭";
				if(goods_data[i].getMallcnt3()==0){
					minPriceText = "별도확인";
				}
			}
		}

		if(minPriceText.length()==0 && minprice==0) { 
			minPriceText = "단종/품절";
		}
		if(minPriceText.equals("미정")) {
			c_dateStr = "출시예정";
			mallcnt = 0; 
		} else {
			if(p_pl_no==0) {
				c_dateStr += " 출시";
			}
		}
		if(c_dateStr.indexOf("예정") > -1){
			minPriceText = "출시예정";
			c_dateStr = "출시예정"; 
		}   
  
		String strAdultCookie = "";
		if(cb.GetCookie("MEM_INFO","ADULT") != null) {
			strAdultCookie = cb.GetCookie("MEM_INFO","ADULT");
		}


		String adultImageFlag = "N";
		if(modelno>0) {
			if(isAdultCate(goods_data[i].getCa_code()) && !cb.GetCookie("MEM_INFO", "ADULT").equals("1")){ //성인용품+미성년or인증안됨
				adultImageFlag = "Y";
			}
		} else {
			boolean bAdult = false;
			if (adultKeywordCheck(modelnm) || adultCategoryCheck(goods_data[i].getCa_code())){
				bAdult = true;
			}
			smallImageUrl = getSearchGoodsImage(bAdult,strAdultCookie,smallImageUrl,false);
			// plno상품의 경우는 getSearchGoodsImage를 이용해 성인용 체크를 하고 이미지는
			// 아래와 같이 변경해야함
			if(smallImageUrl.indexOf("2012/search/19_50.gif")>-1) {
				adultImageFlag = "Y";
			}
		}
//		adultImageFlag = "Y";
		if(adultImageFlag.equals("Y")) {
			smallImageUrl = ConfigManager.IMG_ENURI_COM+"/2014/mobilenew/contents/img_19.jpg";
		}

		if(smallImageUrl.indexOf("gmarket.co.kr") >= 0) {
			smallImageUrl = ReplaceStr.replace(smallImageUrl,"/large_img/","/large_jpgimg/");
		}

		// 무이자 할부 정보
		String strFreeinterest = goods_data[i].getGoods_info_date();

		modelnm = getRemoveCardSale(cardNameHash, modelnm, goods_data[i].getGb1_no(), minprice, ca_code, strFreeinterest, cardFreeAry);

		/*
		if (goods_data[i].getFactory_etc().trim().length() > 0 && !goods_data[i].getFactory_etc().trim().equals("기타") && !goods_data[i].getFactory_etc().trim().equals("없음") && !goods_data[i].getFactory_etc().trim().equals("(기타)")
			&& !goods_data[i].getFactory_etc().trim().equals("기타제조사") && !goods_data[i].getFactory_etc().trim().equals("알수없음")
			&& !goods_data[i].getFactory_etc().trim().equals("상품상세설명 참조")
			&& !goods_data[i].getFactory_etc().trim().equals("상세 설명 참조")
		){
			modelnm = "["+goods_data[i].getFactory_etc()+"]"+modelnm;
		}
		*/


		strFreeinterest = getForceFreeInterest2(goods_data[i].getGb1_no(), ca_code, strFreeinterest, minprice, cardFreeAry);

		if(strFreeinterest.trim().length() > 0) {
			strFreeinterest = "할부: " + strFreeinterest;
		}

		// 해당 분류로 이동
		String modelCateLink = "";
		String strTempCateGory = "";
		String strCategoryName = "";
		if(ca_code.trim().length()>=6) {
			strTempCateGory = CutStr.cutStr(ca_code,6);
		} else {
			strTempCateGory = ca_code;
		}

		if(strTempCateGory.trim().length()>=4) {
			strCategoryName = Category_Proc.Category_Name_DetailTitle_One(strTempCateGory);
		}
		if(strCategoryName.trim().length()>0 && !CutStr.cutStr(strTempCateGory,2).equals("93") && !isAdultCate(strTempCateGory)) {
			strCategoryName = "&quot;"+strCategoryName+"&quot; 분류로 이동";
			strCategoryName = ReplaceStr.replace(strCategoryName, "\"", "&quot;");

			if(strCategoryName.indexOf("temp") >= 0  && strTempCateGory.trim().length() >= 4 ) {
				strTempCateGory = CutStr.cutStr(strTempCateGory,4);
				strCategoryName = "&quot;"+Category_Proc.Category_Name_DetailTitle_One(strTempCateGory)+"&quot; 분류로 이동";
			}
			modelCateLink = "/view/List.jsp?cate="+strTempCateGory;
		}
		// 최근본 찜에서는 불명 제조사명 노출 안함
		if(factory.equals("불명") || factory.equals("[불명]")) {
			factory = "";
		}

		String modelnoID = "";
		if(modelno==0) {
			modelnoID = "P" + p_pl_no;
		} else {
			modelnoID = "G" + modelno;
		}

		middleImageUrl = smallImageUrl;

		String smallImgUrlFinder = "/data/images/service/small/";
		int smallFinderIdx = smallImageUrl.indexOf(smallImgUrlFinder);
		// 500이미지로 변경
		if(smallFinderIdx>-1) {
			middleImageUrl = smallImageUrl.substring(0, smallFinderIdx);
			middleImageUrl += "/data/images/service/middle/";
			middleImageUrl += smallImageUrl.substring(smallFinderIdx + smallImgUrlFinder.length());

			int lastDotIdx = middleImageUrl.lastIndexOf(".");
			middleImageUrl = middleImageUrl.substring(0, lastDotIdx) + ".jpg";
		}

		if(middleImageUrl.equals(smallImageUrl)) {
			smallImageUrl = "http://photo3.enuri.com/data/working.gif";
		}

		// 스폰서 상품 찾기
		//스폰서 엠블럼
		String IsSponsor = "";
		if (getIsSponserGoods(modelno)) {
			IsSponsor = "Y";
		}

		// 추가 검색 상품 플래그
		String plnoGoodFlag = "";
		String minpriceTextFlag = "Y";
		if(minPriceText.length()>0 && minprice==0) {
			minpriceTextFlag = "";
		}
		if(modelno==0 && p_pl_no>0) {
			minpriceTextFlag = "";
			plnoGoodFlag = "Y";
		}

		String factory_etc = goods_data[i].getFactory_etc();
		if (factory_etc.equals("불명") || factory_etc.equals("없음")){
			factory_etc = "";
		}

		factory_etc = ReplaceStr.replace(factory_etc, "[", "");
		factory_etc = ReplaceStr.replace(factory_etc, "]", "");

		String strFactoryCate = "";
		if(!ca_code.equals("")){
			if(ca_code.length() > 2 ){
				strFactoryCate = ca_code.substring(0,2);
			}
		}

		
			
			
			
			
   		if(!strFactory.equals("")){
   			strFactory = strFactory.replace("["," ").replace("]","");
   		}

		String strFactoryCateFlag = "";
		if(strFactoryCate.length() > 0){
			FactoryBrand_Data[] factorybrand_data = FactoryBrand_Proc.FactoryBrand_flag(strFactoryCate);
			if(strFactoryCateFlag!=null && factorybrand_data.length>0) {
				strFactoryCateFlag = factorybrand_data[0].getStrFactory_view_flag();
			}
		}

		if(strFactoryCateFlag.equals("1")){
			factory = strFactory;
		}else if(strFactoryCateFlag.equals("2")){
			factory = strBrand;
		}else if(strFactoryCateFlag.equals("3")){
			if(strBrand.length() > 0){
				if(strFactory.equals(strBrand) || strFactory.indexOf(strBrand) > -1 ){
					factory = factory;
				}else{
					factory = factory +" "+ strBrand;
				}
			}
		}else if(strFactoryCateFlag.equals("4")){
			factory = "";
		}

		factory = ReplaceStr.replace(factory, "[", "");
		factory = ReplaceStr.replace(factory, "]", "");
		factory_etc = CutStr.cutStr(factory_etc, 9);
		factory_etc = factory_etc.replace("㈜","(주)");

		modelnm = ReplaceStr.replace(modelnm, "특가! ", "");
		modelnm = ReplaceStr.replace(modelnm, "특가!", "");
        
		if(modelnm.length()>0) {
			if(listFirstPrintFlag) out.print(",\r\n");

			// 금액의 총합을 구함
			priceSum += minprice;
 
			out.println("			{");
			out.println("			\"modelno\":\""+modelno+"\", ");
			out.println("			\"p_pl_no\":\""+p_pl_no+"\", ");
			out.println("			\"plnoGoodFlag\":\""+plnoGoodFlag+"\", ");
			out.println("			\"factory_etc\":\""+factory_etc+"\", ");
			out.println("			\"smallImageUrl\":\""+smallImageUrl+"\", ");
			out.println("			\"middleImageUrl\":\""+middleImageUrl+"\", ");
			out.println("			\"goodscode\":\""+goods_data[i].getProduct_id()+"\", ");
			out.println("			\"instance_price\":\""+goods_data[i].getTmp_price()+"\", ");
			out.println("			\"maxprice\":\""+FmtStr.moneyFormat(maxprice+"")+"\", ");
			out.println("			\"dept_yn\":\""+dept_yn+"\", ");
			out.println("			\"departImgSrc\":\""+departImgSrc+"\", ");
			out.println("			\"departName\":\""+departName+"\", ");
			out.println("			\"strShopnm\":\""+strShopnm+"\", ");
			out.println("			\"departLogo\":\""+departlogo+"\", ");
			out.println("			\"shopCode\":\""+szVcode+"\", ");
			
			if(minPriceText.length()>0 && minprice==0) {
				out.println("			\"minprice\":\"\", ");
			} else {
				out.println("			\"minprice\":\""+FmtStr.moneyFormat(minprice+"")+"\", ");
			}
			out.println("			\"minPriceText\":\""+minPriceText+"\", ");
			out.println("			\"minpriceTextFlag\":\""+minpriceTextFlag+"\", ");
			out.println("			\"factory\":\""+factory+"\", ");
			out.println("			\"strFreeinterest\":\""+strFreeinterest+"\", ");
			out.println("			\"c_date\":\""+c_date+"\", ");
			out.println("			\"c_dateStr\":\""+c_dateStr+"\", ");
			out.println("			\"moddate\":\""+moddate+"\", ");
			out.println("			\"gb1_no\":\""+gb1_no+"\", ");
			out.println("			\"IsSponsor\":\""+IsSponsor+"\", ");
			out.println("			\"adultImageFlag\":\""+adultImageFlag+"\", ");

			out.println("			\"kb_num\":\""+kb_num+"\", ");
			out.println("			\"kb_title\":\""+toJS(kb_title)+"\", ");
			out.println("			\"url1\":\""+ toUrlCode(url1) +"\", ");
			out.println("			\"bBigImageYN\":\""+bBigImageYN+"\", ");
			out.println("			\"modelCateLink\":\""+modelCateLink+"\", ");
			out.println("			\"goods_info\":\""+toJS(goods_info)+"\", ");
			
			if(goods_data[i].getBbs_num() > 1 ){
				out.println("			\"bbsNum\":\""+FmtStr.moneyFormat(goods_data[i].getBbs_num()+"")+"\", ");
			}
			
			if(goods_data[i].getBbs_num() > 1 && sale_cnt > 9){
				out.println("			\"sale_cnt\":\"판매량("+FmtStr.moneyFormat(sale_cnt+"")+")\", ");
			}
			
			//out.println("			\"mallcnt\":\""+((mallcnt==0)?"":FmtStr.moneyFormat(mallcnt+""))+"\", ");
			out.println("			\"mallcnt\":\""+FmtStr.moneyFormat(mallcnt+"")+"\", ");
			out.println("			\"ca_code\":\""+ca_code+"\", ");
			out.println("			\"modelnm\":\""+modelnm+"\", ");
			//out.println("			\"modelnm\":\""+modelName+"\", ");
			out.println("			\"keyword2\":\""+keyword2+"\", ");
			out.println("			\"strCategoryName\":\""+toJS(strCategoryName)+"\", ");
			out.println("			\"price_txt1\":\""+goods_data[i].getPic_txt_1()+"\", ");
			out.println("			\"price_txt2\":\""+goods_data[i].getPic_txt_2()+"\", ");
			out.println("			\"price_txt3\":\""+goods_data[i].getPic_txt_3()+"\", ");
			out.println("			\"strSpec\":\""+toJS(strSpec)+"\", ");
			out.println("			\"modelnoID\":\""+modelnoID+"\", ");

			out.println("			\"pList_modelno\":\""+goods_data[i].getModelno_group()+"\" ");

			out.print("			}");

			goodsCnt++;
			listFirstPrintFlag = true;
		}
	}
	out.println("\r\n	], ");
}
out.println("	\"goodsCnt\":\""+goodsCnt+"\",");
out.println("	\"priceSum\":\""+FmtStr.moneyFormat(priceSum+"")+"\" ");

%>
}