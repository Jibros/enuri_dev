<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.mobile.RSAMains"%>
<%@ page import="com.enuri.bean.mobile.CRSA"%>
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
<jsp:useBean id="Know_termdic_title_Proc" class="com.enuri.bean.knowbox.Know_termdic_title_Proc" scope="page" />
<jsp:useBean id="Pricelist_Proc" class="com.enuri.bean.main.Pricelist_Proc" scope="page" />
<%@ page import="com.enuri.bean.mobile.FactoryBrand_Proc"%>
<%@ page import="com.enuri.bean.mobile.FactoryBrand_Data"%>
<jsp:useBean id="FactoryBrand_Proc" class="com.enuri.bean.mobile.FactoryBrand_Proc" scope="page" />
<%
CRSA rsa = new CRSA();

String strT1 = ChkNull.chkStr(request.getParameter("t1"));

//out.println("strT11>>>"+strT1 + "<br>");

strT1 = strT1.replaceAll("[-]","+");
strT1 = strT1.replaceAll("[_]","/");

//out.println("strT12>>>"+strT1 + "<br>");

boolean blCheck_t1 = false;

String strT1_fdate = "";
String strT1_enuriid = "";
String strT1_userdata = "";
String strR_code = "";
String strR_msg = "";

String sEnuri_id 				= "";
String sShop_code 			= "";
String sOrder_no				= "";
String sUser_data				= "";

if(!strT1.equals("")){
	//t1에 값이 있으면, 값 해독후 판단 진행
	String strT1_rsa = rsa.decryptByPrivate_mobile(strT1);
	//fire_date가 현재보다 큰지만 비교해서 크면 반환
	//id & user_data 비교 해서 다르면 반환
	//아니면 OK
	//out.println("strT1_rsa>>>"+strT1_rsa + "<br>");
	
	if(strT1_rsa != null){
		String[] arrT1_rsa = strT1_rsa.split("[|][|]");
		
		if(arrT1_rsa != null && arrT1_rsa.length > 0){
			for(int i = 0; i < arrT1_rsa.length; i++){
				//out.println("arrT1_rsa["+ i +"]==="+arrT1_rsa[i] + "<br>");
				if(i == 1){
					strT1_fdate = arrT1_rsa[i];
				}else if(i == 2){
					strT1_enuriid  = arrT1_rsa[i];
				}else if(i == 3){
					strT1_userdata  = arrT1_rsa[i];
				}
			}
			//fire_date가 현재보다 큰지만 비교해서 크면 반환	
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			
			Date dayToday = new Date();
			
			if(Double.parseDouble(sdf.format(dayToday)) > Double.parseDouble(strT1_fdate)){
				//out.println("error");
			}else{
				//out.println("success");
				blCheck_t1 = true;
			}
		}
	}
}

//blCheck_t1 = true;
//strT1_enuriid = "cherub1004";

if(blCheck_t1){
%>
	<%@ include file="/include/IncSearch.jsp"%>
	<%
		boolean bAdultKeyword = false;
		String strCate = "";
%>
	<%@ include file="/include/IncSponsorGoods_2010.jsp"%>
	<%@ include file="/include/IncAdultKeywordCheck_2010.jsp" %>
	{
	<%
	// 데이터의 타입
	// 보여줘야할 데이터를 구분해서 필요없는 것을 뺌
	// 최근본 찜 목록에서는 모든 데이터가 필요하고 목록이나 메인의 간략 보기에는 단순 정보만 필요
	// dataType이 2인 경우 이미지와 상품번호만 노출
	int dataType = Integer.parseInt(ChkNull.chkStr(request.getParameter("dataType"), "1"));
	int appType = Integer.parseInt(ChkNull.chkStr(request.getParameter("appType"), "1"));

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

	String deviceType = ChkNull.chkStr(request.getParameter("deviceType"), "");
	String listTypeStr = ChkNull.chkStr(request.getParameter("listType"), "1");
	String folder_idStr = ChkNull.chkStr(request.getParameter("folder_id"), "0");
	String strUserId = "";

	String mailYN = ChkNull.chkStr(request.getParameter("mailYN"), "");
	String goodsNumList = ChkNull.chkStr(request.getParameter("goodsNumList"), "");

	// listType:1 최근본
	// listType:2 찜
	// listType:9 검색에서 최근본 보기
	int listType = 1;
	int folder_id = 0;
	try {
		listType = Integer.parseInt(listTypeStr);
	} catch(Exception e) {}
	try {
		folder_id = Integer.parseInt(folder_idStr);
	} catch(Exception e) {}

	int goodsCnt = 0;
	long priceSum = 0;

	Save_Goods_Proc save_goods_proc = new Save_Goods_Proc();
	Goods_Data[] goods_data = null;
	HashMap cardNameHash  = getCardNameHash();

	//쇼핑몰 카드 무이자 할부 정보
	String[][] cardFreeAry = Pricelist_Proc.getPriceList_CardFree();

	// 찜 상품일 때 폴더 정보 읽어옴
	strUserId = strT1_enuriid;
	totalCnt = save_goods_proc.getSaveGoodListCnt(strUserId, folder_id);
	
	allTotalCnt = save_goods_proc.getSaveGoodListCnt(strUserId, 0);

	if(pageNum>0) {
		pageMax = (int)Math.ceil((double)totalCnt/pageGap);
		goods_data = save_goods_proc.getSaveGoodListPage(strUserId, folder_id, pageNum, pageGap);

	} else {
		goods_data = save_goods_proc.getSaveGoodList(strUserId, folder_id);
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

			int intDept_code = 0;
			String departlogo = "";
			int szVcode = 0;
			String strShopnm = "";
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
			if((CutStr.cutStr(ca_code,2).equals("14") || CutStr.cutStr(ca_code,2).equals("15")) && strSpec.trim().length() == 0 ) {
				strSpec = modelnm;
				strSpec = ReplaceStr.replace(strSpec, "특가!", "");
			}

			modelnm = ReplaceStr.replace(modelnm,"[일반]","");

			// 모델명과 조건명[ 사이 한칸 공백
			modelnm = ReplaceStr.replace(modelnm, "[", " [");

			// 찜한 날짜
			String moddate = goods_data[i].getModdate();

			// 즐겨찾기나 목록 저장의 경우는 찜한 날짜를 보여주지 않음
			if(mailYN.equals("Y") && goodsNumList.length()>0) {
				moddate = "";
			}

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
			// 찜의 경우는 배송비 정보가 필요없음
			// goods_info에 불필요한 정보가 들어있음, 제거
			if(listType==2) {
				goods_info = "";
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
					if(deviceType.equals("m") && goods_data[i].getMallcnt3()==0){
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

			String adultImageFlag = "N";
			if(modelno>0) {
				if(isAdultCate(goods_data[i].getCa_code())){ //성인용품+미성년or인증안됨
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
//					adultImageFlag = "Y";
			if(adultImageFlag.equals("Y")) {
				smallImageUrl = ConfigManager.IMG_ENURI_COM+"/2014/mobilenew/contents/img_19.jpg";
			}

			if(smallImageUrl.indexOf("gmarket.co.kr") >= 0) {
				smallImageUrl = ReplaceStr.replace(smallImageUrl,"/large_img/","/large_jpgimg/");
			}

			// 무이자 할부 정보
			String strFreeinterest = goods_data[i].getGoods_info_date();

			modelnm = getRemoveCardSale(cardNameHash, modelnm, goods_data[i].getGb1_no(), minprice, ca_code, strFreeinterest, cardFreeAry);

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
			if(listType!=9) {
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

			String strFactory = ChkNull.chkStr(goods_data[i].getFactory());
			String strBrand = ChkNull.chkStr(goods_data[i].getBrand());

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
				//out.println("			\"plnoGoodFlag\":\""+plnoGoodFlag+"\", ");
				//out.println("			\"factory_etc\":\""+factory_etc+"\", ");
				out.println("			\"smallImageUrl\":\""+smallImageUrl+"\", ");
				out.println("			\"middleImageUrl\":\""+middleImageUrl+"\", ");
				//out.println("			\"goodscode\":\""+goods_data[i].getProduct_id()+"\", ");
				//out.println("			\"instance_price\":\""+goods_data[i].getTmp_price()+"\", ");
				//out.println("			\"maxprice\":\""+FmtStr.moneyFormat(maxprice+"")+"\", ");
				//out.println("			\"dept_yn\":\""+dept_yn+"\", ");
				//out.println("			\"departImgSrc\":\""+departImgSrc+"\", ");
				//out.println("			\"departName\":\""+departName+"\", ");
				//out.println("			\"strShopnm\":\""+strShopnm+"\", ");
				//out.println("			\"departLogo\":\""+departlogo+"\", ");
				//out.println("			\"shopCode\":\""+szVcode+"\", ");
				
				if(minPriceText.length()>0 && minprice==0) {
					out.println("			\"minprice\":\"\", ");
				} else {
					out.println("			\"minprice\":\""+FmtStr.moneyFormat(minprice+"")+"\", ");
				}
				out.println("			\"minPriceText\":\""+minPriceText+"\", ");
				out.println("			\"minpriceTextFlag\":\""+minpriceTextFlag+"\", ");
				out.println("			\"factory\":\""+factory+"\" ");
				//out.println("			\"strFreeinterest\":\""+strFreeinterest+"\", ");
				//out.println("			\"c_date\":\""+c_date+"\", ");
				//out.println("			\"c_dateStr\":\""+c_dateStr+"\", ");
				//out.println("			\"moddate\":\""+moddate+"\", ");
				//out.println("			\"gb1_no\":\""+gb1_no+"\", ");
				//out.println("			\"IsSponsor\":\""+IsSponsor+"\", ");
				//out.println("			\"adultImageFlag\":\""+adultImageFlag+"\", ");
				//out.println("			\"pList_modelno\":\""+goods_data[i].getModelno_group()+"\" ");

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
<%
}
%>