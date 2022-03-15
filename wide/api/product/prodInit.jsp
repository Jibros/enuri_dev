<%@ page contentType="text/html; charset=utf-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@ include file="/common/jsp/COMMON_CONST.jsp"%>
<%@ page import="com.enuri.bean.lsv2016.Category_Set_Proc"%>
<%@ page import="com.enuri.bean.lsv2016.Category_Set_Data"%>
<%@ page import="com.enuri.bean.main.Goods_Data"%>
<%@ page import="com.enuri.bean.main.Goods_Proc"%>
<%@ page import="com.enuri.bean.main.Pricelist_Data"%>
<%@ page import="com.enuri.bean.main.Pricelist_Proc"%>
<%@ page import="com.enuri.bean.main.Mobile_Category_Proc"%>
<%@ page import="com.enuri.bean.main.Mobile_Category_Data"%>
<%@ page import="com.enuri.bean.wide.Wide_Prod_Proc"%>
<%@ page import="com.enuri.bean.main.Save_Goods_Proc"%>
<%@ page import="com.enuri.bean.main.Goods_Detail_Proc"%>
<%@ page import="com.enuri.bean.main.Goods_Detail_Data"%>
<%@ page import="com.enuri.bean.mobile.Mobile_Pricelist_Proc"%>
<%@ page import="com.enuri.bean.event.every.HitBrandProc_2020"%>
<%@ page import="com.enuri.bean.lsv2016.Goods_Spec_Compare"%>
<%@ page import="com.enuri.util.common.JsonResponse"%>
<%@ page import="com.google.gson.*"%>
<%@ page import="org.json.*"%>


<%
    if(!CvtStr.isNumeric(request.getParameter("modelno"))){
		return ;
	}
    int intModelno = ChkNull.chkInt(request.getParameter("modelno"),0);
	int intPromotionNo = ChkNull.chkInt(request.getParameter("prono"), 0);

    // 현재 도메인을 저장
    String strServerName = request.getServerName().trim();
    // 접속자 아이피를 저장
    String strRemoteHost = request.getRemoteHost().trim();
    //referer 체크 
    String strReferer = ChkNull.chkStr(request.getHeader("REFERER"),"");
    //개발 서버 확인
    boolean bldevFlag = (strServerName.indexOf("dev.enuri.com") > -1 );
    //현재 시간
    String strNowDateTime = com.enuri.util.date.DateStr.nowStr("yyyy.MM.dd. HH:mm");
    
    // 프로모션 자동화 - 테스트 목적 항목

    
    Goods_Proc goodsProc = new Goods_Proc();
    Category_Data categoryData = new Category_Data();
    Mobile_Pricelist_Proc mobilePriceListProc = new Mobile_Pricelist_Proc();
    Goods_Spec_Compare goods_spec_compare = new Goods_Spec_Compare();
    Goods_Data goodsData = goodsProc.Goods_Detailmulti_One(intModelno, "Detailmulti");
    Goods_Detail_Data[] specList = null;
    JSONArray  specJson = new JSONArray ();
    boolean IsAdultFlag = false;
	boolean IsAdultAd = false;

	String USER_ID= cb.GetCookie("MEM_INFO","USER_ID");
    String TMPUSER_ID= cb.GetCookie("MEM_INFO","TMP_ID");
	String USER_NICK= cb.GetCookie("MEM_INFO","USER_NICK");
    String SNSTYPE = cb.GetCookie("MEM_INFO","SNSTYPE");

    int intModelnoGroup = 0;
    long lngMinPrice = 0, lngMinPrice2 = 0, lngMinPrice3 = 0, lngCashMinPrice =0;

    String strModelNm = "";
    String strCondiNm = "";
    String strBrand = "", strFactory = "", strSpec = "";
    String strCdate ="";
    String strConstrain = "";
    int intBbsNum = 0;
    float flBbsPointAvg = 0.0f;

    int intMallCnt = 0;
    int intMallCnt3 = 0;
    String strCategory = "";
    String strCate2 = "";
    String strCate4 = "";
    String strCate6 = "";
    String strCate8 = "";
    String strCateName2 = "";
    String strCateName4 = "";
    String strCateName6 = "";
    String strCateName8 = "";
    String strImageUrl = "";

    String strOvsMinYn = "";
    String strCashMinYn = "";
    long lnCashMinPrice = 0 ;

    //출시가
    String strRelease_price = "";
	String strReleaseTextView = "";

    String strModelNmView = "";
    String strModelNmViewTag = "";
    String strCdateView = "";
    String strMinPriceView = "";
    String strMinDeliveryTextView = "";   //배송비
    String strBbsNumView = "";
    String strMallCntView = "";
    long lngPlMinPlno = 0;
    long lngPlMinPrice = 0;
    long lngPlMinInstancePrice = 0;
    int intPlMinShopCode = 0;
    String strPlMinUrl = "";
    String strPlMinDeliveryInfo = "";
    int intPlMinDeliveryInfo2 = 0;
    int intPlMinDeliveryType2 = 0;
    //모바일 최저가일때
	String plMobileMinShopName = "";
    int plMobileMinShopCode = 0;
    
    boolean blSimiliarModelCheck = false;
    boolean blCashShopOnly =false;
    //찜관련
    boolean blZzim = false;
    boolean blCompare = false;
     //히트브랜드 관련
    boolean blHitBrandCheck = false;
    String strHitBrandEventCode = "2020112401";
     //제조사, 팩토리 노출 
    boolean blBrand = true;
    boolean blFactory = true;
    String strViewID = "";
    //할인율
    float flEsPriceDcRt = 0.0f;
    int intEsOpnPrc = 0;

    //meta 키워드
    String strKeyword2 = "";
    String strMetaKeyword = "";
    String strMetaTitleTag = "";
    String strMetaCateName = "";

    //해외배송 쇼핑몰
    List<Integer> aryOvsShopList = Arrays.asList(new Integer[]{8446,8447,8448,8826,8827,8828,8829,8830,16174});

    JSONArray arrayThumNailList = new JSONArray();
    JSONArray arrayVideoList = new JSONArray();
    JSONArray arrayCertiList = new JSONArray();
    JSONArray  arrayaAllergyList  = new JSONArray();
    JSONObject esVipObject = new JSONObject();

    SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
    SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy.MM");
    SimpleDateFormat sdf3 = new SimpleDateFormat("yyyy.MM.dd");
    SimpleDateFormat sdf4 = new SimpleDateFormat("yyyy-MM-dd");
    Date dtNowTime = new Date();
	Date tmpDate = new Date();

    String strGoogleDate = sdf4.format(dtNowTime);

    JsonResponse ret = null;
    JSONObject rtnJSONObject = new JSONObject();
   	Pricelist_Proc priceListProc = new Pricelist_Proc();
    Wide_Prod_Proc wide_prod_proc = new Wide_Prod_Proc();
    Goods_Detail_Proc goods_detail_proc = new Goods_Detail_Proc();
    HitBrandProc_2020 hitProc = new HitBrandProc_2020();
    
    if(goodsData == null){
        ret = new JsonResponse(false).setData(rtnJSONObject);
        out.println(ret.toString());
        return ;
    }else if(goodsData != null){
        intModelnoGroup = goodsData.getModelno_group();
        lngMinPrice = goodsData.getMinprice();
        lngMinPrice2 = goodsData.getMinprice2();
        lngMinPrice3 = goodsData.getMinprice3();
        intMallCnt = goodsData.getMallcnt();
        intMallCnt3 = goodsData.getMallcnt3();
        strModelNm = goodsData.getModelnm();
        strCondiNm = goodsData.getCondiname();
        strFactory = goodsData.getFactory();
        strBrand = goodsData.getBrand();
        strCategory = goodsData.getCa_code();
        strCdate = goodsData.getC_date();
        strImageUrl = ImageUtil_lsv.getVIPImageSrc(goodsData);
        intBbsNum = goodsData.getBbs_num();
        flBbsPointAvg = goodsData.getBbs_point_avg();
        strSpec = goodsData.getSpec();
        strOvsMinYn = goodsData.getOvs_min_prc_yn();
        strCashMinYn = goodsData.getCash_min_prc_yn();
        lngCashMinPrice = goodsData.getCash_min_prc();
        strConstrain = goodsData.getConstrain();
        strKeyword2 = goodsData.getKeyword2();

        if(strCategory.length() > 1){
            strCate2 = strCategory.substring(0,2);
        }
        if(strCategory.length() > 3){
            strCate4 = strCategory.substring(0,4);
        }
        if(strCategory.length() > 5){
            strCate6 = strCategory.substring(0,6);
        }
        if(strCategory.length() > 7){
            strCate8 = strCategory.substring(0,8);
        }

        categoryData = (strCategory.substring(6,8).equals("00")) 
        ? wide_prod_proc.getCategoryInfo(strCate6)
        : wide_prod_proc.getCategoryInfo(strCategory);

        if(categoryData != null){
            strCateName4 = categoryData.getC_name2();
            strCateName6 = categoryData.getC_name3();
            strCateName8 = categoryData.getC_name4();
        }

        if(cb.GetCookie("MEM_INFO","ADULT")!=null) {
            String adultStr = cb.GetCookie("MEM_INFO","ADULT");
            // 성인인증 됨
            if(adultStr.equals("1")) IsAdultFlag = true;
        }
        //2022.01.04 성인카테 변경 1640->163630 
        if(IsAdultFlag && strCate6.equals("163630")) IsAdultAd = true;
        // 프로모션 자동화 - 테스트 목적 항목

        //유사상품 체크
        if(strConstrain.equals("5")){
            blSimiliarModelCheck = true;
        }
        //브랜드/제조사 규칙
        if(strFactory.equals("불명") || strFactory.equals("[불명]") || strFactory.equals("[추가]") || strFactory.equals("[호환업체]") || strFactory.equals("호환업체")){
            strFactory = "";
        }
        if(strBrand.equals("불명") || strBrand.equals("[불명]") || strBrand.equals("[추가]") || strBrand.equals("[호환업체]") || strBrand.equals("호환업체")){
            strBrand = "";
        }
        //상품명 규칙
        if(strModelNm.indexOf("[일반]")>-1) {
            strModelNm = strModelNm.replace("[일반]","");
        }
        if(!strCondiNm.equals("")) {
            strModelNm = strModelNm.replaceAll("\\["," \\[");
        }
        Category_Set_Data[] category_set_data = null;
        Category_Set_Proc category_set_proc = new Category_Set_Proc();
        category_set_data = category_set_proc.getCategorySetList("");
        String exp_modelnm = strModelNm;
        String exp_factory = strFactory;
        String exp_brand = strBrand;

        if(category_set_data != null){
            for(int x=0; x<category_set_data.length; x++){
                if(category_set_data[x].getMd_brand_flag().equals("0")) {
                    if(strCate4.equals(category_set_data[x].getCate())) exp_brand = "";
                }
                if(category_set_data[x].getMd_factory_flag().equals("0")){
                    if(strCate4.equals(category_set_data[x].getCate())) exp_factory = "";
                }
            }
        }
         //제조사=브랜드시 브랜드 비노출
        if(strFactory.trim().toLowerCase().equals(strBrand.toLowerCase().trim())){
            if(!blBrand && !blFactory){     //제조사 off / 브랜드off => 제조사 노출
                blFactory = true;
            }else if(!blFactory){           //제조사 off => 브랜드 노출
                blBrand = true;
            }else{
                blBrand = false;            //제조사 on => 제조사 노출
                blFactory = true;
            }
            exp_brand = "";
        }else{
            if(!blBrand && !blFactory){     //제조사 off / 브랜드off => 제조사 노출
                blFactory = true;
            }else{
                blBrand = true; 
                blFactory = true;
            }
        }
        //제조사=브랜드시 브랜드 비노출
        if(exp_factory.toLowerCase().equals(exp_brand.toLowerCase())){
            exp_brand = "";
        }
        //제조사=브랜드=모델명 일때 모델명만 노출
        if(exp_factory.toLowerCase().equals(exp_modelnm.toLowerCase()) && exp_brand.toLowerCase().equals(exp_modelnm.toLowerCase())){
            exp_factory = "";
            exp_brand = "";
        }

        //제조사/브랜드가 모두 비노출되는 경우 선택 노출 (김원경대리 추가 요청_20160830)
        if(exp_factory.equals("") && exp_brand.equals("")){
            if(ControlUtil.compareValOR(new String[]{strCate4,"0304","0305"})){
                exp_factory = strFactory;
            }else if(ControlUtil.compareValOR(new String[]{strCate4,"0903","0912","0913","0919","0923","0937","1015","1001"})){
                exp_brand = strBrand;
            }else if(ControlUtil.compareValOR(new String[]{strCate2,"08","14"})){
                exp_brand = strBrand;
            }
        }

        //팩토리 + 브랜드 + 모델명
        String[] strModel_FBN = {exp_factory.trim(),exp_brand.trim(),exp_modelnm};
        
        strModelNmView = String.join(" ", strModel_FBN).replace("  "," ");
        strModelNmViewTag = (strCondiNm.equals("")) ? strModelNmView : strModelNmView.replaceAll("\\["," <span>\\[").replaceAll("]","\\]</span>");

        //strModelNmView = strModel_FBN[0]+ strModel_FBN[1]+strModel_FBN[2];

       	tmpDate = sdf.parse(strCdate);
        if(strCate2.equals("15") || strCate4.equals("1005")){
            strCdateView = "";
        }else if(tmpDate.compareTo(dtNowTime) > 0 ){	// 출시 예정
			strCdateView = "출시예정";
		}else {
            strCdateView = "등록일: " + sdf2.format(tmpDate);
        }
        	//배송비
    	Pricelist_Data pricelistData = priceListProc.get_Vip_minpricedata(intModelno);
    	if(pricelistData != null){
    		lngPlMinPlno = pricelistData.getPl_no();
			lngPlMinPrice = pricelistData.getPrice();
			lngPlMinInstancePrice = pricelistData.getInstance_price();
			intPlMinShopCode = pricelistData.getShop_code();
            strPlMinUrl = pricelistData.getUrl();
            strPlMinDeliveryInfo = pricelistData.getDeliveryinfo();
            intPlMinDeliveryInfo2 = pricelistData.getDeliveryinfo2();
            intPlMinDeliveryType2 = pricelistData.getDeliverytype2();
            if(aryOvsShopList.contains(intPlMinShopCode)){
                strMinDeliveryTextView = "해외배송별도";
            }else if(strPlMinDeliveryInfo.equals("무료배송")  ||
               	strPlMinDeliveryInfo.equals("착불")     ||
               	strPlMinDeliveryInfo.equals("배송비유료") ||
               	strPlMinDeliveryInfo.equals("유무료")    ||
               	strPlMinDeliveryInfo.equals("유료")     ||
               	strPlMinDeliveryInfo.equals("조건부무료") ){
            	strMinDeliveryTextView = strPlMinDeliveryInfo;
            }else{
                if(intPlMinDeliveryType2==0){
                    if (strPlMinDeliveryInfo.equals("")) {	//유무료
                        strMinDeliveryTextView = "유무료";
                } else {
                    strMinDeliveryTextView = String.valueOf(intPlMinDeliveryInfo2);
                }
                }else if(intPlMinDeliveryType2==1){
                    if(ChkNull.chkNumber(String.valueOf(intPlMinDeliveryInfo2))){
                        strMinDeliveryTextView = "배송비 " + FmtStr.moneyFormat(String.valueOf(intPlMinDeliveryInfo2)) +"원 별도" ;
                    }else {
                        strMinDeliveryTextView = "배송비 " + String.valueOf(intPlMinDeliveryInfo2) ;
                    }
                }
            }
    	}
        //모바일 최저가일때
		if(lngPlMinInstancePrice > 0 && lngMinPrice > lngPlMinInstancePrice){
			Pricelist_Data mPlist = new Pricelist_Data();
			mPlist = mobilePriceListProc.get_Vip_minpricedata(intModelno);

			plMobileMinShopName = mPlist.getShop_name();
            plMobileMinShopCode = mPlist.getShop_code();
		}
        //최저가
        if(lngMinPrice > 0 ){
            strMinPriceView = FmtStr.moneyFormat(String.valueOf(lngMinPrice));
        }else if(strCashMinYn.equals("Y")){
            strMinPriceView = FmtStr.moneyFormat(String.valueOf(lngCashMinPrice));
            lngMinPrice = lngCashMinPrice;
            blCashShopOnly = true;
        }
		//출시가
        //출시가 or 출고가 or 할인율
        try {
            esVipObject = wide_prod_proc.getEsVipModelData(request,intModelnoGroup);
            if(intModelno != intModelnoGroup){
                JSONArray esOptionArray = wide_prod_proc.getEsValue(esVipObject,"sub_models", new JSONArray());
                
                for(int i=0;i<esOptionArray.length();i++){
                    JSONObject tmpObject = esOptionArray.getJSONObject(i);
                    int tmpModelno =  wide_prod_proc.getEsValue(tmpObject,"modelno", 0);
                    if(intModelno==tmpModelno){
                        flEsPriceDcRt = wide_prod_proc.getEsValue(tmpObject,"dc_rt", flEsPriceDcRt);
                        intEsOpnPrc = wide_prod_proc.getEsValue(tmpObject,"opn_prc", intEsOpnPrc);
                        break;
                    }
                }
            }else{
                flEsPriceDcRt = wide_prod_proc.getEsValue(esVipObject,"dc_rt", flEsPriceDcRt);
                intEsOpnPrc = wide_prod_proc.getEsValue(esVipObject,"opn_prc", intEsOpnPrc);
            }
        } catch(Exception e) {}

        //출시가 존재
        if(intEsOpnPrc > 0){
            //출시가 or 출고가 분류로 판단
            int intExtraWordType = 0;
            switch(strCate2) {
                case "02" : intExtraWordType = 2; break;
                case "03" : intExtraWordType = 2; break;
                case "04" : intExtraWordType = 2; break;
                case "05" : intExtraWordType = 2; break;
                case "06" : intExtraWordType = 2; break;
                case "21" : intExtraWordType = 2; break;
                case "22" : intExtraWordType = 2; break;
                case "24" : intExtraWordType = 2; break;
                default : intExtraWordType = 1; break;
            }
            if(intExtraWordType == 1){
                strReleaseTextView = "출시가";
            }else{
                strReleaseTextView = "출고가";
            }
            strReleaseTextView = strReleaseTextView + ": "+ FmtStr.moneyFormat(String.valueOf(intEsOpnPrc)) + "원";
            if(flEsPriceDcRt > 1){
                strReleaseTextView = strReleaseTextView + "("+ (int)flEsPriceDcRt +"%↓)";
            }
        }

        //상품평
        strBbsNumView =  FmtStr.moneyFormat(String.valueOf(intBbsNum));
        //쇼핑몰 수
        strMallCntView = (tmpDate.compareTo(dtNowTime) > 0) ? "0" : FmtStr.moneyFormat(String.valueOf(intMallCnt));
        //썸내일
        arrayThumNailList = wide_prod_proc.getThumnailList(intModelno);
        //비디오
        arrayVideoList = wide_prod_proc.getVideoList(intModelno);

        //스펙리스트
        specList = goods_detail_proc.getSpecList(intModelno, strCategory);
        //arraylist to JSONArray : 기본 getter 노출 
        specJson = new JSONArray(new Gson().toJsonTree(specList).getAsJsonArray().toString());
        ///인증정보 및 알레르기 정보
	    arrayCertiList = wide_prod_proc.getGoodsAttributeList(intModelno, 1);
        
        arrayaAllergyList = wide_prod_proc.getGoodsAttributeList(intModelno, 2);
		
        //VIEW ID 
        if(SNSTYPE.equals("K") || SNSTYPE.equals("N")){
            strViewID = USER_NICK;
        }else {
            if(!USER_NICK.equals("")){
                strViewID = USER_NICK;
            }else{
                strViewID = USER_ID;
            }
        }
        //찜버튼용
		Save_Goods_Proc save_goods_proc = new Save_Goods_Proc();
		Goods_Data[] goods_save_data = null;
		if(!USER_ID.equals("")) {
			goods_save_data = save_goods_proc.getSaveGoodList(USER_ID,"MEMBER"); //저장상품 (로그인)
			if(goods_save_data!=null){
				for(int j=0;j<goods_save_data.length;j++){
					if(intModelno == goods_save_data[j].getModelno() ) blZzim = true;
                }
			}
		}

        //스펙비교 노출여부
	    if(!strCategory.equals("") && strCategory.length() >= 4){
	    	blCompare = goods_spec_compare.getSpecCompareFlag(strCategory, false);
	    }

        if(intModelno>0) {
            String strTodayGoods = cb.GetCookie("MYTODAYGOODS","MODELNOS");
            String strTodayGoodsCookie = "G:"+intModelno+",";
            //최근본상품 가격정보 추가
            String strTodayMinprice = cb.GetCookie("MYTODAYGOODS","MINPRICE");
            String strTodayMinpriceCookie = lngMinPrice+",";
            if(strTodayGoods != null & "".equals(strTodayGoods) == false) {
                String astrTodayGoods[] = strTodayGoods.split("\\,");
                String astrTodayMinprice[] = strTodayMinprice.split("\\,");
                int intMyTodayCnt = astrTodayGoods.length;
                if (intMyTodayCnt >= 50 ){
                    intMyTodayCnt = 50;
                }
                for (int i=0;i<intMyTodayCnt;i++){
                    if (!astrTodayGoods[i].equals(("G:"+intModelno))){
                        strTodayGoodsCookie = strTodayGoodsCookie + astrTodayGoods[i]+",";
                        if(astrTodayMinprice!=null && astrTodayMinprice.length>0 && astrTodayMinprice.length>i){
                            strTodayMinpriceCookie = strTodayMinpriceCookie + astrTodayMinprice[i]+",";
                        }
                    }
                }
            }
            strTodayGoodsCookie = CutStr.cutStr(strTodayGoodsCookie,strTodayGoodsCookie.length()-1);
            cb.SetCookie("MYTODAYGOODS", "MODELNOS", strTodayGoodsCookie);

            strTodayMinpriceCookie = CutStr.cutStr(strTodayMinpriceCookie,strTodayMinpriceCookie.length()-1);
            cb.SetCookie("MYTODAYGOODS", "MINPRICE", strTodayMinpriceCookie);

            cb.SetCookieExpire("MYTODAYGOODS", 3600*24*30);
            cb.responseAddCookie(response);
        }
        //히트브랜드 여부 
        if(Integer.parseInt(sdf.format(dtNowTime)) < 20210131 && Integer.parseInt(sdf.format(dtNowTime)) > 20201215){
            blHitBrandCheck = hitProc.hitProdCheck(intModelno, strHitBrandEventCode);
            if(!USER_ID.equals("") && blHitBrandCheck) {
                blHitBrandCheck = (hitProc.getModelStamp(USER_ID, strHitBrandEventCode, intModelno, 0) > 0) ? false : true;
            }
        }
        JSONObject gObject = new JSONObject();
        gObject.put("gModelno",intModelno);
        
        gObject.put("gCategory",strCategory);
        gObject.put("gCondiName",strCondiNm);
        gObject.put("gModelNmView",strModelNmView);
        gObject.put("gModelNmViewTag",strModelNmViewTag);
        gObject.put("gModelNm",strModelNm);
        gObject.put("gBrand",strBrand);
        gObject.put("gFactory",strFactory);
        gObject.put("gBrandCheck",blBrand);
        gObject.put("gFactoryCheck",blFactory);
        gObject.put("gBbsNum",intBbsNum);
        gObject.put("gBbsPointAvg",String.format("%.1f", flBbsPointAvg));
        gObject.put("gOvsMinPrcYn",strOvsMinYn);
        gObject.put("gCashShopOnly",blCashShopOnly);
        gObject.put("gCashMinPrcYn",strCashMinYn);
        gObject.put("gImageUrl",strImageUrl);
        gObject.put("gMinDeliveryView",strMinDeliveryTextView);
        gObject.put("gMinShopCode",intPlMinShopCode);
        gObject.put("gMinPrice",lngMinPrice);
        gObject.put("gMallCnt",intMallCnt);
        gObject.put("gCdate",sdf2.format(tmpDate));
        gObject.put("gCdateView",strCdateView);
        gObject.put("gConstrain",blSimiliarModelCheck);
        gObject.put("gThumNailList",arrayThumNailList);
        gObject.put("gVideoList",arrayVideoList);
        gObject.put("gZzim",blZzim);
        gObject.put("gCertiList",arrayCertiList);
        gObject.put("gAllergyList",arrayaAllergyList);
        gObject.put("gSpecList",specJson);
        gObject.put("gHitBrandCheck",blHitBrandCheck);
        //gObject.put("gReleasePrice",strRelease_price);
        gObject.put("gPriceDcRt",(int)flEsPriceDcRt);
        gObject.put("gReleasePrice",intEsOpnPrc);
        gObject.put("gReleaseText",strReleaseTextView);

        rtnJSONObject.put("gModelData",gObject);

        JSONObject metaObject = new JSONObject();
        // 신규 메타태그 개선안 로직
		String strMetaSpec = ReplaceStr.replace(ReplaceStr.replace(ReplaceStr.replace(strSpec,"'",""),"\"",""),"\r\n","");
		String [] MetaArray = strMetaSpec.split("/");

		strMetaTitleTag = "최저가 검색 - 에누리가격비교";
		strMetaTitleTag = "'"+ReplaceStr.replace(strModelNmView, "'", "")+"'" + " 최저가 쇼핑 정보 - 에누리가격비교";
		strMetaKeyword = strKeyword2;
		strMetaKeyword = ReplaceStr.replace(strMetaKeyword,"\r\n", "");
		strMetaKeyword = ReplaceStr.replace(strMetaKeyword,"  ", " ");
		strMetaKeyword = ReplaceStr.replace(strMetaKeyword,"★", "▶");
		strMetaKeyword = ReplaceStr.replace(strMetaKeyword,"▶", "");
		strMetaKeyword += " " + strMetaSpec;
        
        strMetaCateName = strModelNmView + " < " + strCateName6 + " < " + strCateName4 + " [에누리 가격비교]";
        metaObject.put("metaTitle",strMetaTitleTag);
        metaObject.put("metaKeyword",strMetaKeyword);
        metaObject.put("metaCateName",strMetaCateName);

        rtnJSONObject.put("gMetaData",metaObject);
        ret = new JsonResponse(true).setData(rtnJSONObject);
        out.println(ret.toString());
    }
%>
