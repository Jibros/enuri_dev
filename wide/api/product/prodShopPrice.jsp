<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@ page import="com.enuri.bean.main.Goods_Data"%>
<%@ page import="com.enuri.bean.main.Pricelist_Data"%>
<%@ page import="com.enuri.bean.main.Pricelist_Proc"%>
<%@ page import="com.enuri.bean.wide.Wide_Prod_Proc"%>
<%@page import="com.enuri.bean.lsv2016.Goods_Lsv_11St_Proc"%>
<%@page import="com.enuri.bean.lsv2016.Goods_Lsv_11St_Data"%>
<%@page import="com.enuri.bean.lsv2016.Goods_Lsv_11St_Goods_Info_Data"%>
<%@ page import="com.enuri.bean.lsv2016.InfoAd_Proc"%>
<%@ page import="com.enuri.util.common.JsonResponse"%>
<jsp:useBean id="Pricelist_Data" class="com.enuri.bean.main.Pricelist_Data" scope="page" />
<%@ page import="org.json.*"%>
<%@ include file="/wide/include/product/IncProductUtil.jsp"%>
<%
    if(!CvtStr.isNumeric(request.getParameter("modelno"))){
		return ;
	}
	int intModelNo = ChkNull.chkInt(request.getParameter("modelno"),0);
	String strCard = ChkNull.chkStr(request.getParameter("card"),"");
    String strDelivery = ChkNull.chkStr(request.getParameter("delivery"),"");
    int intPromotionNo = ChkNull.chkInt(request.getParameter("prono"), 0);
    String strCategory = ChkNull.chkStr(request.getParameter("cate"),"");
    String strSort = "";
    String strServerName = request.getServerName().trim();
    boolean bldevFlag = (strServerName.indexOf("dev.enuri.com") > -1 );
    if(strCard.equals("Y") && strDelivery.equals("Y")) {
        strSort = "card_delivery";
    }else if(strCard.equals("Y")){
        strSort = "card";
    }else if(strDelivery.equals("Y")){
        strSort = "delivery";
    }else {
        strSort = "price";
    }
    String strCate2 = "";
	String strCate4 = "";
	String strCate6 = "";

	if(strCategory.length() > 1){
		strCate2 = strCategory.substring(0,2);
	}
	if(strCategory.length() > 3){
		strCate4 = strCategory.substring(0,4);
	}
	if(strCategory.length() > 5){
		strCate6 = strCategory.substring(0,6);
	}
    Pricelist_Data[] arrayShopPricelist = null;
    Pricelist_Data[] arrayCashPricelist = null;
    Pricelist_Data[] arrayCardPricelist = null;
    Pricelist_Data[] arrayTmpPricelist = null;
    Pricelist_Proc priceListProc = new Pricelist_Proc();
    Wide_Prod_Proc wideProdProc = new Wide_Prod_Proc();
    if(strSort.equals("price")){
        arrayShopPricelist = wideProdProc.getCardSortShopList_v2(intModelNo, false, false);
        arrayCashPricelist = wideProdProc.getCashShopList(intModelNo, false, false);
        arrayCardPricelist = wideProdProc.getCardSortShopList_v2(intModelNo, false, true);
    }else if(strSort.equals("delivery")){
		arrayShopPricelist = wideProdProc.getCardSortShopList_v2(intModelNo, true, false);
        arrayCashPricelist = wideProdProc.getCashShopList(intModelNo, false, false);
    }else if(strSort.equals("card")){
        arrayShopPricelist = wideProdProc.getCardSortShopList_v2(intModelNo, false, true);
    }else if(strSort.equals("card_delivery")){
        arrayShopPricelist = wideProdProc.getCardSortShopList_v2(intModelNo, true, true);
    }
    //쇼핑몰 카드특가 정보 (dbdata)
    List<Integer> newCardShopList = Arrays.asList(new Integer[]{5910,6508,7861,6641,47,6665,374,9011,49,6547,7455,7870,55,6252,57,20883});

    //해외쇼핑몰
    List<Integer> aryOvsShopList = Arrays.asList(new Integer[]{8446,8447,8448,8826,8827,8828,8829,8830,16174});
     //쇼핑몰로고 이미지
    List<Integer> aryShopLogoImgList = wideProdProc.getLogoImgShop();
    //쇼핑몰 카드 무이자 할부 정보
	String[][] cardFreeAry = priceListProc.getPriceList_CardFree();

    //쇼핑몰 카드특가 정보 (dbdata)
	String[][] cardInfoAry = priceListProc.getPriceList_CardEvent();
	String cardShopCodes = "|"; //카드할인중인 쇼핑몰 목록
	String cardName = "";
    HashMap<String,String> cardNameHash = new HashMap<String,String>();
	if(cardInfoAry!=null) {
		for(int i=0; i<cardInfoAry.length; i++) {
			cardName = "";
			cardShopCodes += cardInfoAry[i][0]+"|";
			%>
			<%@ include file="/common/jsp/IncCardName.jsp"%>
			<%
			cardName += "|"+cardInfoAry[i][4]; //카드 제한 문구
			if(cardNameHash.containsKey(cardInfoAry[i][0])) {
				cardName = (String)cardNameHash.get(cardInfoAry[i][0]) + ":" + cardName;
			}
			cardNameHash.put(cardInfoAry[i][0], cardName);
		}
	}
    //변수처리
    long lnPlno = 0;
    long lnMinPlno = 0;
    long lnPrice = 0;               //가격
    long lnPrice2 = 0;               //가격2

    String strDeliveryPriceText = "";   //배송비
    String strDeliveryInfo = "";
    int intDeliveryInfo2 = 0;
    int intDeliveryType2 = 0;

    long lnCardPrice = 0;           //카드가
    String strCardName = "";        //카드명
    String strFreeInterest = "";    //무이자할부

    long lnInstancePrice = 0;       //모바일가

    String strGoodsName = "";       //상품명
    String strGoodsCode = "";       //상품코드

    int intShopCode = 0;            //쇼핑몰코드
    String strShopName = "";        //쇼핑몰명
    String strShopType = "";        //쇼핑몰타입
    int intCoupon =0;
    long lnMinPrice = 0;

    String strBadgeName = "";

    boolean blCashPriceCheck = false;
    boolean blCardBadge = false;
    boolean blOvsBadge =false;
    boolean blOverseaCheck = false;
    boolean blCardShopCheck = false;
    boolean blShopLogoImageCheck = false;
    boolean blDeliveryCodCheck = false;

    JSONArray tmpJSONArray = new JSONArray();
    JSONObject pObject = new JSONObject();

    JSONObject specialJSONObject = new JSONObject();
    JSONObject visitJSONObject = new JSONObject();
    JSONObject rntJSONObject = new JSONObject();
    JsonResponse ret = null;
    HashMap<String,Pricelist_Data> cardNcashMap = new HashMap<String,Pricelist_Data>();
    if(arrayShopPricelist !=null){                  //기본 쇼핑몰
        arrayTmpPricelist = arrayShopPricelist;
         if(arrayCashPricelist !=null && arrayCashPricelist.length > 0) cardNcashMap.put("first_cash",arrayCashPricelist[0]);
         if(arrayCardPricelist !=null && arrayCardPricelist.length > 0) cardNcashMap.put("first_card",arrayCardPricelist[0]);
    }else if(arrayCashPricelist.length > 0){
        arrayTmpPricelist = arrayCashPricelist;     //현금몰만
    }
    if(arrayTmpPricelist !=null && arrayTmpPricelist.length > 0){
        for(int i=0;i<arrayTmpPricelist.length;i++){
            lnPlno = arrayTmpPricelist[i].getPl_no();
            lnPrice = arrayTmpPricelist[i].getMinprice();              //카드가와 최저가 혼합 최저가

            lnPrice2 = lnPrice;

            lnInstancePrice = arrayTmpPricelist[i].getInstance_price();

            strGoodsName = StringReplace(arrayTmpPricelist[i].getGoodsnm());
            strGoodsCode = arrayTmpPricelist[i].getGoodscode();

            strDeliveryPriceText = "";
            strDeliveryInfo = arrayTmpPricelist[i].getDeliveryinfo();
            intDeliveryInfo2 = arrayTmpPricelist[i].getDeliveryinfo2();
            intDeliveryType2 = arrayTmpPricelist[i].getDeliverytype2();

            intShopCode = arrayTmpPricelist[i].getShop_code();
            strShopName = arrayTmpPricelist[i].getShop_name();
            strShopType = arrayTmpPricelist[i].getShop_type();

            intCoupon = arrayTmpPricelist[i].getCoupon();

            lnCardPrice = Long.valueOf(arrayTmpPricelist[i].getPrice_card());
            strCardName = getCardName(cardNameHash,intShopCode,strGoodsName,lnPrice,lnCardPrice,newCardShopList);
            strFreeInterest = getForceFreeInterest3(intShopCode,strCategory,arrayTmpPricelist[i].getFreeinterest(),lnPrice,cardFreeAry);

            blCashPriceCheck = arrayTmpPricelist[i].getSrvflag().equals("C");
            blOverseaCheck = false;
            blShopLogoImageCheck = false;
            blDeliveryCodCheck = false;

            //쇼핑몰이미지로고 flag
            if(aryShopLogoImgList.contains(intShopCode)){
                blShopLogoImageCheck = true;
            }
            //해외 쇼핑몰 여부
            if(aryOvsShopList.contains(intShopCode)){
                blOverseaCheck = true;
            }
            if(!strCardName.equals("") && strCard.equals("Y")){
                blCardBadge = true;
            }else {
                blCardBadge = false;
            }
            if(!strCardName.equals("") && !blCardShopCheck){
                blCardShopCheck = true;
            }
            strBadgeName = "";

            if(i==0) {
                lnMinPrice = lnPrice;
                lnMinPlno = lnPlno;
            }
            if(lnMinPrice > lnPrice){
                lnMinPrice = lnPrice;
                lnMinPlno = lnPlno;
            } 
            //배송비설정
            // deliveryType2==0 : 배송비 정보가 불명확함
            // deliveryType2==1 : 배송비 정보가 정확학
            // 배송비 정보는 deliveryInfo2에 들어 있으며
            // deliveryInfo2==0 이면 무료배송
            // deliveryInfo의 정보는 배송비가 정해지는 규칙이 들어 있음(업체에서 입력)
            if(aryOvsShopList.contains(intShopCode)){
                strDeliveryPriceText = "해외배송별도";
            }else if( strDeliveryInfo.equals("무료배송")  ||
                strDeliveryInfo.equals("착불")     ||
                strDeliveryInfo.equals("배송비유료") ||
                strDeliveryInfo.equals("유무료")    ||
                strDeliveryInfo.equals("유료")     ||
                strDeliveryInfo.equals("조건부무료") ){
                strDeliveryPriceText = strDeliveryInfo;
                if(strDeliveryInfo.equals("착불")){
                    blDeliveryCodCheck = true;
                }
            }else{
                if(intDeliveryType2==0){
                    if (strDeliveryInfo.equals("")) {	//유무료
                        strDeliveryPriceText = "유무료";
                    } else {
                        strDeliveryPriceText = String.valueOf(intDeliveryInfo2);
                        if(blCashPriceCheck && strDelivery.equals("Y")){
                            lnPrice +=intDeliveryInfo2;
                        }
                    }
                }else if(intDeliveryType2==1){
                    strDeliveryPriceText = String.valueOf(intDeliveryInfo2);
                    if(blCashPriceCheck && strDelivery.equals("Y")){
                        lnPrice +=intDeliveryInfo2;
                    }
                }
            }
            if(strShopType.equals("4")){
                strBadgeName = "npay";
            }else if(intShopCode== 7861 && strGoodsName.indexOf("[로켓배송]") > -1 ){
                strBadgeName = "rocket";
            }else if((intShopCode==374 || intShopCode==6665)  && strGoodsName.indexOf("[오늘도착][쓱배송]") > -1 ){
                strBadgeName = "ssg";
            }else {
                 if(intShopCode==6508 && strGoodsName.indexOf("[오늘출발]") > -1 ){
                    strBadgeName = "quick";
                 }else if(intShopCode==5910 && strGoodsName.indexOf("[오늘출발]") > -1 ){
                    strBadgeName = "quick";
                 }else if(intShopCode==19051 && strGoodsName.indexOf("[오늘도착]") > -1 ){
                    strBadgeName = "quick";
                 }else if((intShopCode==49 || intShopCode==7455) && strGoodsName.indexOf("[매장배송]") > -1 ){
                    strBadgeName = "quick";
                 }else if(intShopCode==6641 && (strGoodsName.indexOf("당일발송") > -1 || strGoodsName.indexOf("당일배송") > -1 ) ){
                    strBadgeName = "quick";
                 }
            }

            pObject = new JSONObject();
            pObject.put("plno", lnPlno);
            pObject.put("price", lnPrice);
            pObject.put("price2", lnPrice2);
            pObject.put("delivery_price", intDeliveryInfo2);
            pObject.put("freeinterest", strFreeInterest);
            pObject.put("cardprice", lnCardPrice);
            pObject.put("cardname", strCardName);
            pObject.put("goodsname", strGoodsName);
            pObject.put("goodscode", strGoodsCode);
            pObject.put("delivery_text", strDeliveryPriceText);
            pObject.put("shopcode", intShopCode);
            pObject.put("shopname", strShopName);
            pObject.put("shoptype", strShopType);
            pObject.put("shoplogo_check", blShopLogoImageCheck);
            pObject.put("cashmall_check", blCashPriceCheck);
            pObject.put("deliveryCod_check", blDeliveryCodCheck);
            pObject.put("badgename", strBadgeName);
            pObject.put("cardbadge", blCardBadge);
            pObject.put("oversea_check", blOverseaCheck);
            pObject.put("coupon", intCoupon);
            tmpJSONArray.put(pObject);
        }

        for( String key : cardNcashMap.keySet() ){
            long comparePrice = 0;                                         // 최저가와만 비교
            Pricelist_Data comparePriceData = cardNcashMap.get(key);       //순서는 front에서
            if(key.equals("first_cash")){
                comparePrice = comparePriceData.getPrice();
            }else if(key.equals("first_card")){
                comparePrice = comparePriceData.getPrice_card();
            }
            if(comparePrice <= lnMinPrice){
                lnPlno = comparePriceData.getPl_no();
                lnPrice = Long.valueOf(comparePriceData.getPrice());

                lnPrice2 = lnPrice;

                lnInstancePrice = comparePriceData.getInstance_price();

                strGoodsName = StringReplace(comparePriceData.getGoodsnm());
                strGoodsCode = comparePriceData.getGoodscode();

                strDeliveryPriceText = "";
                strDeliveryInfo = comparePriceData.getDeliveryinfo();
                intDeliveryInfo2 = comparePriceData.getDeliveryinfo2();
                intDeliveryType2 = comparePriceData.getDeliverytype2();

                intShopCode = comparePriceData.getShop_code();
                strShopName = comparePriceData.getShop_name();
                strShopType = comparePriceData.getShop_type();
                intCoupon = comparePriceData.getCoupon();

                blCashPriceCheck = comparePriceData.getSrvflag().equals("C");
                blShopLogoImageCheck = false;


                lnCardPrice = Long.valueOf(comparePriceData.getPrice_card());
                strCardName = getCardName(cardNameHash,intShopCode,strGoodsName,lnPrice,lnCardPrice,newCardShopList);
                if(aryShopLogoImgList.contains(intShopCode)){
                    blShopLogoImageCheck = true;
                }
                //배송비설정
                // deliveryType2==0 : 배송비 정보가 불명확함
                // deliveryType2==1 : 배송비 정보가 정확학
                // 배송비 정보는 deliveryInfo2에 들어 있으며
                // deliveryInfo2==0 이면 무료배송
                // deliveryInfo의 정보는 배송비가 정해지는 규칙이 들어 있음(업체에서 입력)
                if( strDeliveryInfo.equals("무료배송")  ||
                    strDeliveryInfo.equals("착불")     ||
                    strDeliveryInfo.equals("배송비유료") ||
                    strDeliveryInfo.equals("유무료")    ||
                    strDeliveryInfo.equals("유료")     ||
                    strDeliveryInfo.equals("조건부무료") ){
                    strDeliveryPriceText = strDeliveryInfo;
                }else{
                    if(intDeliveryType2==0){
                        if (strDeliveryInfo.equals("")) {	//유무료
                            strDeliveryPriceText = "유무료";
                        } else {
                            strDeliveryPriceText = String.valueOf(intDeliveryInfo2);
                        }
                    }else if(intDeliveryType2==1){
                            strDeliveryPriceText = String.valueOf(intDeliveryInfo2);
                    }
                }
                pObject = new JSONObject();
                pObject.put("plno", lnPlno);
                pObject.put("price", lnPrice);
                pObject.put("delivery_price", intDeliveryInfo2);
                pObject.put("cardprice", lnCardPrice);
                pObject.put("cardname", strCardName);
                pObject.put("goodsname", strGoodsName);
                pObject.put("goodscode", strGoodsCode);
                pObject.put("delivery_text", strDeliveryPriceText);
                pObject.put("shopcode", intShopCode);
                pObject.put("shopname", strShopName);
                pObject.put("shoptype", strShopType);
                pObject.put("shoplogo_check", blShopLogoImageCheck);
                pObject.put("cashmall", blCashPriceCheck);
                pObject.put("coupon", intCoupon);
                if(key.equals("first_cash") ){
                    specialJSONObject.put("cashSpecialPrice",pObject);
                }else if(key.equals("first_card") && !strCardName.equals("") && lnCardPrice > 0 ){
                    specialJSONObject.put("cardSpecialPrice",pObject);
                }
            }
        }
        // 프로모션 자동화 : 상품 상단 선언
        Goods_Lsv_11St_Proc goodsLsv11StProc2 = new Goods_Lsv_11St_Proc();
        Goods_Lsv_11St_Data goodsLsv11StData = null;
        JSONObject promotionObject = new JSONObject();

        if (intPromotionNo > 0) {
            goodsLsv11StData = goodsLsv11StProc2.getPromotionGoodsInfo(intModelNo, intPromotionNo);
        } else {
            goodsLsv11StData = goodsLsv11StProc2.getPromotionGoodsInfo(intModelNo);
        }
        String strVipHgViewYn = "";
        String strVipHgViewStr = "";
        int intSpmCd = 0;
        String strSpmName = "";
        String strPcPromtnUrl = "";
        String strVipLsViewYn = "";
        String strVipLsViewStr = "";
        long longVipProPlNo = 0;
        String strProRedirectUrl = "";

        int discountPrice = 0;
        int eventOriginPrice = 0;

        String strPromotionGoodsNm  = "";
        String strPromotionImgUrl = "";

        if (goodsLsv11StData != null) {

            strVipHgViewYn = goodsLsv11StData.getPc_vip_hg_view_yn();		// VIP 상단 쿠폰 할인가 노출 여부
            strVipHgViewStr = goodsLsv11StData.getPc_vip_hg_view_str();		// VIP 상단 쿠폰 할인가 문구

            strVipLsViewYn = goodsLsv11StData.getPc_vip_ls_view_yn();			// VIP 리스트 상단 영역 노출 여부
            strVipLsViewStr = goodsLsv11StData.getPc_vip_ls_view_str();			// VIP 리스트 상단 영역 할인가 문구

            intSpmCd = goodsLsv11StData.getSpm_cd();								// 샵코드
            strSpmName = goodsLsv11StData.getSpm_name();						// 샵 이름
            strPcPromtnUrl = goodsLsv11StData.getPc_promtn_url();				// PC 랜딩 URL
            blShopLogoImageCheck = false;

            if(aryShopLogoImgList.contains(intShopCode)){
                blShopLogoImageCheck = true;
            }
            Goods_Lsv_11St_Goods_Info_Data goodsLsvGoodsInfoData = goodsLsv11StData.getGoodsInfo();		// 상품정보 Object

            if (goodsLsvGoodsInfoData != null) {
                discountPrice = goodsLsvGoodsInfoData.getDiscount_price();		// 할인가격 노출
                eventOriginPrice = goodsLsvGoodsInfoData.getPrice();				// 프로모션 원 가격
                strPromotionGoodsNm = goodsLsvGoodsInfoData.getGoodsnm();
                strPromotionImgUrl = goodsLsvGoodsInfoData.getImgUrl();
                longVipProPlNo = goodsLsvGoodsInfoData.getPl_no();

                strProRedirectUrl = "/move/Redirect.jsp?cmd=move_link&vcode=" + intSpmCd + "&modelno=" + intModelNo
                        + "&pl_no=" + longVipProPlNo + "&from=detail&showPrice=" + eventOriginPrice;

            }
            if(!strVipHgViewYn.isEmpty() && strVipHgViewYn.equals("Y") && discountPrice > 0) {
                pObject = new JSONObject();
                pObject.put("discountPrice",discountPrice);
                pObject.put("eventOriginPrice",eventOriginPrice);
                pObject.put("goodsname",strPromotionGoodsNm);
                pObject.put("imgurl",strPromotionImgUrl);
                pObject.put("plno",longVipProPlNo);
                pObject.put("promourl",strPcPromtnUrl);
                pObject.put("shopname",strSpmName);
                pObject.put("shopcode",intSpmCd);
                pObject.put("promotext",strVipHgViewStr);
                pObject.put("shoplogo_check", blShopLogoImageCheck);

                specialJSONObject.put("promoSpecialPrice",pObject);
            }
        }
        //직방가
        
        //visitJSONObject = wideProdProc.getVisitPriceInfo(lnMinPlno);
        if(visitJSONObject.length() > 0){
            int intDiffPrice = 0;
            int intDcRt = 0;
            long lnVisitPrice = visitJSONObject.getLong("visitPrice");
            intDiffPrice =(int)(lnMinPrice - lnVisitPrice)*(-1);
            intDcRt = (intDiffPrice * 100 / (int)lnVisitPrice);
            visitJSONObject.put("diffPrice",intDiffPrice);
            visitJSONObject.put("goodsMinPrice",lnMinPrice);
            visitJSONObject.put("dc_ratio",intDcRt);
        }
    }

    InfoAd_Proc infoad_proc = new InfoAd_Proc();
    org.json.simple.JSONObject infoad_data = infoad_proc.getPriceTop(intModelNo, strCate4, "2", "", "", "");
    JSONObject priceTopJsonObject = new JSONObject();
    JSONArray priceTopJson = new JSONArray();
    if(!infoad_data.isEmpty()){
        if(infoad_data.get("sponsorads") != null){
            org.json.simple.JSONObject tmpObj = (org.json.simple.JSONObject)infoad_data.get("sponsorads");
            if(tmpObj.get("ads") != null){
                org.json.simple.JSONArray tmpArray = (org.json.simple.JSONArray)tmpObj.get("ads");
                if(tmpArray.size() > 0){
                    for(int i=0;i<tmpArray.size();i++){
                        org.json.simple.JSONObject targetObj = (org.json.simple.JSONObject)tmpArray.get(i);
                        Pricelist_Data tmpPlData = new Pricelist_Data();
                        int intAdShopCode = !targetObj.get("shop_code").equals("") ? Integer.parseInt(String.valueOf(targetObj.get("shop_code"))) : 0;
                        String strAdGoodsCode = targetObj.get("prd_code")!=null ? String.valueOf(targetObj.get("prd_code")) : "";
                        String strAdPrice = String.valueOf(targetObj.get("price"));
                        String strAdShippingfeeFreeYn = targetObj.get("shippingfee_free_yn")!=null ? String.valueOf(targetObj.get("shippingfee_free_yn")) : "";
                        String strAdUrl = targetObj.get("ad_pc_url")!=null ? String.valueOf(targetObj.get("ad_pc_url")) : "";
                        String strAdMobileUrl = targetObj.get("ad_pc_url")!=null ? String.valueOf(targetObj.get("ad_pc_url")) : "";

                        long lnAdInstancePrice = 0;
                        long lnAdPrice = 0;
                        String strAdDeliveryTxt = "";
                        long lnAdPl_no = 0;
                        String strAdInstancePrice = "";
                        blShopLogoImageCheck = false;

                        if(aryShopLogoImgList.contains(intShopCode)){
                            blShopLogoImageCheck = true;
                        }
                        if(strAdUrl.equals("") && !strAdGoodsCode.equals("")){
                            tmpPlData = priceListProc.getPriceListGoodsCodeAndShopCode(intAdShopCode,strAdGoodsCode);
                            if(tmpPlData!=null){
                                lnAdPl_no = tmpPlData.getPl_no();
                                lnAdPrice = tmpPlData.getPrice();
                                lnAdInstancePrice = tmpPlData.getInstance_price();
                            //    strAdUrl = tmpPlData.getUrl();
                                strAdMobileUrl =  tmpPlData.getUrl();

                                if(tmpPlData.getDeliverytype2()==1){
                                    if(tmpPlData.getDeliveryinfo2()==0){
                                        strAdDeliveryTxt = "무료배송";
                                    }else{
                                        
                                        //strAdDeliveryTxt = FmtStr.moneyFormat(tmpPlData.getDeliveryinfo2()+"") + "원";
										//strAdDeliveryTxt = "***원";//2021.04.07 손현수과장 요청사항
                                        strAdDeliveryTxt = FmtStr.moneyFormat(tmpPlData.getDeliveryinfo2()+"") + "원";//2022.01.05 손현수과장 요청사항(#50557)
                                    }
                                }else{
                                    strAdDeliveryTxt = "유무료";
                                }
                                strAdPrice = FmtStr.moneyFormat(lnAdPrice+"");
                                strAdInstancePrice = FmtStr.moneyFormat(lnAdInstancePrice+"");
                            }
                        }else{
                            strAdInstancePrice = strAdPrice;
                            if(strAdShippingfeeFreeYn.equals("Y")){
                                strAdDeliveryTxt  = "무료배송";
                            }else if(strAdShippingfeeFreeYn.equals("N")){
                                strAdDeliveryTxt  = "유료배송";
                            }
                        }
                        priceTopJsonObject.put("model_name",(String)targetObj.get("model_name"));
                        priceTopJsonObject.put("shop_code",intAdShopCode);

                        priceTopJsonObject.put("url",strAdUrl);
                        priceTopJsonObject.put("mobile_url",strAdMobileUrl);
                        priceTopJsonObject.put("pl_no",lnAdPl_no);
                        priceTopJsonObject.put("prd_code",strAdGoodsCode);
                        priceTopJsonObject.put("shippingfee_free_yn",strAdShippingfeeFreeYn);
                        priceTopJsonObject.put("click_image",(String)targetObj.get("click_image"));
                        priceTopJsonObject.put("click_subs",(String)targetObj.get("click_subs"));
                        priceTopJsonObject.put("click_title",(String)targetObj.get("click_title"));
                        priceTopJsonObject.put("imgurl",(String)targetObj.get("imgurl"));
                        priceTopJsonObject.put("copytext",(String)targetObj.get("copytext"));
                        priceTopJsonObject.put("mall_name",(String)targetObj.get("mall_name"));
                        priceTopJsonObject.put("price",strAdPrice);
                        priceTopJsonObject.put("instance_price",strAdInstancePrice);
                        priceTopJsonObject.put("shoppingfee",strAdDeliveryTxt);
                        priceTopJsonObject.put("shoplogo_check", blShopLogoImageCheck);
                        priceTopJsonObject.put("ad_type", (String)targetObj.get("ad_type"));

                        //priceTopJson.put(priceTopJsonObject);
                    }
                }
            }
        }
    }

    rntJSONObject.put("cardshop_check", blCardShopCheck);
    rntJSONObject.put("shopPricelist",tmpJSONArray);
    rntJSONObject.put("specialPrice",specialJSONObject);
    rntJSONObject.put("priceTop",priceTopJsonObject);
    rntJSONObject.put("visitPrice",visitJSONObject);
    if(bldevFlag){
        rntJSONObject.put("priceTopOrg",infoad_data);
    }

    ret = new JsonResponse(true).setData(rntJSONObject).setTotal(tmpJSONArray.length());

    out.println(ret.toString());
%>
