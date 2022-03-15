<%@ page contentType="text/html; charset=utf-8" trimDirectiveWhitespaces="true" %>
<%@ page import="java.util.*"%>
<%@ page import="com.enuri.util.common.*"%>
<%@ page import="com.enuri.util.common.ConfigManager"%>
<%@ page import="com.enuri.util.common.ChkNull"%>
<%@ page import="com.enuri.util.common.ReplaceStr"%>
<%@ page import="com.enuri.util.common.JsonResponse"%>
<%@ page import="com.enuri.bean.main.Goods_Proc"%>
<%@ page import="com.enuri.bean.main.Goods_Data"%>
<%@ page import="com.enuri.bean.main.Pricelist_Data"%>
<%@ page import="com.enuri.bean.main.Pricelist_Proc"%>
<%@ page import="com.enuri.bean.main.Reward_Cate_Rate" %>
<%@ page import="com.enuri.bean.lsv2016.Goods_Lsv_11St_Proc"%>
<%@ page import="com.enuri.bean.lsv2016.Goods_Lsv_11St_Data"%>
<%@ page import="com.enuri.bean.lsv2016.Goods_Lsv_11St_Goods_Info_Data"%>
<%@ page import="com.enuri.bean.lsv2016.Coupon_Layer_Proc"%>
<%@ page import="com.enuri.bean.wide.Wide_Prod_Proc"%>
<%@ page import="com.enuri.bean.main.sad.Sad_Goods_Proc"%>
<%-- <%@ page import="com.google.common.collect.ArrayListMultimap"%>
<%@ page import="com.google.common.collect.Multimap"%>
<%@ page import="com.google.gson.Gson"%> --%>
<%@ page import="org.json.JSONObject"%>
<%@ page import="org.json.JSONArray"%>

<%@ include file="/wide/include/product/IncProductUtil.jsp"%>
<%
    /**
    * @history
    * 2021.01.05 (scboys) 최초 작성
    *
    */

    /** Parameter Sets */
    if(!CvtStr.isNumeric(request.getParameter("modelno"))){
		out.print("{}");
		return ;
	}
    //모델 번호
    int intModelno = ChkNull.chkInt(request.getParameter("modelno"), 0);
    //더보기 ( 'N' : 일반, Y : 더보기, strShopListAll )
    String strShopListAll = ChkNull.chkStr(request.getParameter("more"),"N");
    //정렬 타입 ( price : 판매가순, delivery : 배송비 포함, card : 카드할인가, sort = price만)
    String strSort = ChkNull.chkStr(request.getParameter("sort"), "price");
    //선택된 쇼핑몰 ( -로 구분, szSelectedShop)
    String strSelShop = ChkNull.chkStr(request.getParameter("selshop"),"");
    //카드할인가 적용 여부 (= 구(mix))
    String strCard = ChkNull.chkStr(request.getParameter("card"), "N");
    //배송비 포함 적용 여부 (=구 sort=delivery)
    String strDelivery = ChkNull.chkStr(request.getParameter("delivery"), "N");
    //쇼핑몰 프로모션 test여부 (intPromotionNo)
	int intPromotionNo = ChkNull.chkInt(request.getParameter("prono"), 0);
    //더보기 제한 갯수 (showLine)
    int intLeftMore = ChkNull.chkInt(request.getParameter("leftmore"), 0);
    int intRightMore = ChkNull.chkInt(request.getParameter("rightmore"), 0);

	/** 구 listType
	** 0 디폴트
	** 1 배송비 포함
	** 3 카드가정렬
	**/
	String priceListShowType = "0";

    /******************************/

	Goods_Proc goodsProc = new Goods_Proc();
	Pricelist_Proc priceListProc = new Pricelist_Proc();
    Wide_Prod_Proc wide_prod_proc = new Wide_Prod_Proc();
    Sad_Goods_Proc sad_goods_proc = new Sad_Goods_Proc();
	Pricelist_Data[] arrayPricelist = null;

    Goods_Data goodsData = goodsProc.Goods_Detailmulti_One(intModelno, "Detailmulti");

    if( goodsData == null ) {
        return ;
    }


    String strCategory = goodsData.getCa_code();
    String strFactory = goodsData.getFactory();
    String strBrand = goodsData.getBrand();
	String strModelName = goodsData.getModelnm();

	long lnMinPrice3 = goodsData.getMinprice3();
    long lnMinPrice = goodsData.getMinprice();
	String strCondiname = goodsData.getCondiname();
    String strSpec = goodsData.getSpec();
    String strConstrain = goodsData.getConstrain();

    String strCate2 = "";
    String strCate4 = "";
    String strCate6 = "";
    String strCate8 = "";

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

    //가격 리스트 Data Call
    //int modelno, String szCategory, boolean deliverOrderFlag, boolean cardOrderFlag, boolean mixCardPrice
    boolean blDelivery = strDelivery.equals("Y") ? true : false;
    boolean blCard = strCard.equals("Y") ? true : false;
    if(strSort.equals("price")){
        arrayPricelist = wide_prod_proc.Pricelist_DetailMulti_List5(intModelno, strCategory, blDelivery, blCard , false);
    }else if(strSort.equals("delivery")){
        arrayPricelist = wide_prod_proc.Pricelist_DetailMulti_List5(intModelno, strCategory, true,false , false);
    }else if(strSort.equals("card")){
        arrayPricelist = wide_prod_proc.Pricelist_DetailMulti_List5(intModelno, strCategory, false, true, false);
    }

    Map<String, Object> retMap = new JsonMap<String, Object>();
    //제조사 인증 조회
    boolean blAuthGoodsTierCheck = false;
  	//쇼핑몰 선택
  	boolean blSelShopCheck = false;
    //전시/중고
	boolean blUsedGoodsTierCheck = false;
	//해외쇼핑
	boolean blTariffGoodsTierCheck = false;
    //카드 할인가 여부
    boolean blCardSaleCheck = false;
    //유사상품 여부
    boolean blSimiliarModelCheck = false;
    //기타 쇼핑몰 포함 여부
    boolean etcShopFlag = false;

    // 프로모션 자동화 시작
	Goods_Lsv_11St_Proc goodsLsv11StProcAjax = new Goods_Lsv_11St_Proc();
	HashMap<String, Goods_Lsv_11St_Data> goodsLsv11StMap = null;

	if (intPromotionNo > 0) {
		goodsLsv11StMap = goodsLsv11StProcAjax.getPromotionGoodsList(intModelno, intPromotionNo);
	} else {
		goodsLsv11StMap = goodsLsv11StProcAjax.getPromotionGoodsList(intModelno);
	}
    //out.println(authCodeJSONObject.length());
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

    // 1:쿠폰레이어, 2:시스템점검 레이어
	//쇼핑몰 쿠폰 정보
    Coupon_Layer_Proc coupon_proc = new Coupon_Layer_Proc();
	String[][] couponLayerAry = coupon_proc.getCouponLayerList(1);

	//시스템점검 정보
	String[][] systemCheckLayerAry = coupon_proc.getCouponLayerList(2);

    //emoney 적립률
    Reward_Cate_Rate reward_cate_rate = new Reward_Cate_Rate();
    float flRewardRate =  reward_cate_rate.getRewardCateRate(strCategory);

    // 가격 리스트를 저장하는 배열

    ArrayList<Pricelist_Data> leftList = new ArrayList<Pricelist_Data>();
    ArrayList<Pricelist_Data> rightList = new ArrayList<Pricelist_Data>();

    ArrayList<Pricelist_Data> optionEssentialList = new ArrayList<Pricelist_Data>();

    //E머니 가능 쇼핑몰
    List<Integer> emonyShopList = Arrays.asList(new Integer[]{4027,536,5910,55,806,75,6641,47,374,6665,114,6508,7861,9011,19051,6361});

    //ep 2.0 카드가 쇼핑몰
    List<Integer> newCardShopList = Arrays.asList(new Integer[]{5910,6508,7861,6641,47,6665,374,9011,49,6547,7455,7870,55,6252,57,20883});

    //해외 쇼핑몰
    List<Integer> aryOvsShopList = Arrays.asList(new Integer[]{8446,8447,8448,8826,8827,8828,8829,8830,16174});

    //쇼핑몰로고 이미지
    List<Integer> aryShopLogoImgList = wide_prod_proc.getLogoImgShop();
    //선택 가능 쇼핑몰코드
    List<Integer> selectShopCodeList = Arrays.asList(new Integer[]{536,5910,4027,55,57,75,663,47,6508,6641,806,49,90,974,6547,6664,6361,374,7455,6588,6620,7851,7692,5438,6603,6252,6729,273,6095,6193,7695,5978,6389,6634,6644,6711,3367,4861,4858,6367,834,1783,2086,2970,5215,5829,6165,6199,6368,6377,6695,7857,7852,7685,7910,7908,7861,8446,8447,8448,8826,8827,8828,9011,16174,8830,19051,8094,9999});
    //pricelist 존재하는 쇼핑몰
    HashMap<Integer,JSONObject> shopListHash = new HashMap<Integer,JSONObject>();
    JSONArray selectShopJSONArray = new JSONArray();
    JSONArray selectShopOvsJSONArray = new JSONArray();
    JSONObject selectShopJSONObject = new JSONObject();
    //제조사 인증 로고v2
    JSONObject authCodeJSONObject = wide_prod_proc.getAuthInfo(intModelno);
    //제조사 인증 로고 IMG URL
    String strAuthCode = "";
    //옵션 필수 상품 갯수
    int optionEssentialCnt = 3;

    //판매자 광고문구
	String[][] arrSellerAd = null;

    //선택된 쇼핑몰
    List<String> selectShopList = new ArrayList<String>();

    if(strConstrain.equals("5")){
        blSimiliarModelCheck = true;
    }

    //제조사 인증
    if(authCodeJSONObject.length() > 0){
        strAuthCode = authCodeJSONObject.getString("logo_url");
        if(!strAuthCode.equals("")){
            blAuthGoodsTierCheck = true;
        }
    }
    //쇼핑몰 선택
    if(!strSelShop.equals("")){
    	selectShopList = Arrays.asList(strSelShop.split(","));
    }
	//상품명 기준
	if(strCondiname.indexOf("중고") > -1 && !(strModelName.indexOf("해외쇼핑") < 0 && strCate4.equals("0304")) ){
		blUsedGoodsTierCheck = true;
	}else if (strCondiname.indexOf("해외쇼핑") > -1){
		blTariffGoodsTierCheck = true;
	}
    //판매자 광고 노출
    if(!strSort.equals("card")){ //카드특가탭은 제외
        arrSellerAd = sad_goods_proc.getSadGoodsList(intModelno);
        //arrShopAdCopy = Sad_Goods_Proc.getShopadGoodsList(arrShopAd_shopcode, arrShopAd_goodscode);
    }

	//가격비교 티어 구분자..?
	String strGoodsCompareTier = "";

    /* 유사상품 별개
     * 판매가순  무료배송 | 배송비 유/무료 shippingTier
     * 		  오픈마켓 | 일반 쇼핑몰  shopscaleTier
     *		  세금 /배송비 유무료
     *	      제조사 인증예외
     * 		  중고품예외
     *
     * 배송비 포함가  배송비 포함 가격 [툴팁] | 착불/조건부배송 상품 deliveryTier
     * 카드할인가순   일반 결제조건 가격	 | 특정카드 할인가		 cardTier
 	 *
    **/
    //기본
    if(blSimiliarModelCheck){
        strGoodsCompareTier = "similiarTier";
    }else {
        if(strSort.equals("price")){
            if(lnMinPrice3 < 100000){ // 10만원 초과 카테고리 예외처리
                if(strCate4.equals("0304") || strCate4.equals("0602"))  strGoodsCompareTier = "shopScaleTier";
                else if (strCate4.equals("1647") &&
                        (strModelName.indexOf("PIN번호") > -1   ||
                            strSpec.indexOf("모바일상품권") > -1 ||
                            strSpec.indexOf("모바일쿠폰") > -1   ||
                            strSpec.indexOf("전송방식:문자") > -1
                        ) ){
                    strGoodsCompareTier = "shopScaleTier";
                }
                else strGoodsCompareTier = "freeShipTier";
            }else if(lnMinPrice3 >= 100000){ // ||  10만원 이상상품 예외처리
                if(blTariffGoodsTierCheck){
                    strGoodsCompareTier = "tariffTier";
                }else if(strCate4.equals("0601") || strCate4.equals("0621") || strCate4.equals("0405")){
                    strGoodsCompareTier = "freeShipTier";
                }else{
                    strGoodsCompareTier = "shopScaleTier";
                }
            }
        } else if(strSort.equals("delivery")){
            strGoodsCompareTier = "deliveryTier";       //배송비 포함가 순
            blUsedGoodsTierCheck = false;               //중고, 해외쇼핑 X
            blTariffGoodsTierCheck = false;             //제조사 인증은 체크해야함
        } else if(strSort.equals("card")){
            strGoodsCompareTier = "cardTier";           //카드가 정렬 순
            blUsedGoodsTierCheck = false;               //중고, 해외쇼핑 X
            blTariffGoodsTierCheck = false;             //제조사 인증 체크 X
            blAuthGoodsTierCheck = false;
        }
    }
    if(arrayPricelist != null){

        for(Pricelist_Data pricelistData : arrayPricelist){
            //중고,제조사인증,선택된쇼핑몰 찾기
            if(selectShopList.size() > 0){
                strGoodsCompareTier = "selectShopTier";
                break;
            } else if(blUsedGoodsTierCheck){
                if(pricelistData.getAirconfeetype().equals("3") || pricelistData.getAirconfeetype().equals("4")){
                    strGoodsCompareTier = "usedTier";
                    break;
                }
            } else if(blAuthGoodsTierCheck){
                if(!pricelistData.getOption_flag2().equals("1") && pricelistData.getAuthflag().equals("Y")){
                    strGoodsCompareTier = "authTier";
                    break;
                }
            }
        }
        for(Pricelist_Data pricelistData : arrayPricelist){
            //카드가 여부 확인
            if(!blCardSaleCheck){
                if(!(getCardName(cardNameHash,pricelistData.getShop_code(),pricelistData.getGoodsnm(),pricelistData.getPrice(),pricelistData.getPrice_card(),newCardShopList).equals(""))){
                    blCardSaleCheck =true;
                }
            }
            //옵션 필수 상품 처리
            if(strSort.equals("price") && pricelistData.getOption_flag2().equals("1") && optionEssentialList.size() < optionEssentialCnt ){
                if( pricelistData.getPrice() <= lnMinPrice){
                    optionEssentialList.add(pricelistData);
                }
               continue;
            }else{
                if(strGoodsCompareTier.equals("similiarTier")){                 //right만사용
                    /*50822
                    if(strSort.equals("card") && blCardSaleCheck){
                        if(!(getCardName(cardNameHash,pricelistData.getShop_code(),pricelistData.getGoodsnm(),pricelistData.getPrice(),pricelistData.getPrice_card(),newCardShopList).equals(""))){
                            pricelistData.setRightnleft("2");
                        }else {
                            pricelistData.setRightnleft("1");
                        }
                    }else{
                        pricelistData.setRightnleft("2");
                    }*/
                    pricelistData.setRightnleft("2");

                }else if(strGoodsCompareTier.equals("freeShipTier")){
                    if(CutStr.cutStr(strCategory,4).equals("2401")){             //에어컨 예외처리
                        if(pricelistData.getAirconfeetype().equals("1") && pricelistData.getRightnleft().equals("1")){
                            pricelistData.setRightnleft("1");
                        }else{
                            pricelistData.setRightnleft("2");
                        }

                    }else{
                        if((pricelistData.getDeliverytype2()==1 && pricelistData.getDeliveryinfo2()==0)) {
                            pricelistData.setRightnleft("1");
                        }else{
                            pricelistData.setRightnleft("2");
                        }
                    }
                }else if(strGoodsCompareTier.equals("shopScaleTier")){
                    if(((pricelistData.getScale().equals("1") || pricelistData.getScale().equals("2")) || pricelistData.getAuth().equals("5")) && !pricelistData.getJobtype().equals("2")){
                        pricelistData.setRightnleft("1");
                    }else{
                        pricelistData.setRightnleft("2");
                    }
                }else if(strGoodsCompareTier.equals("deliveryTier")){
                    if(pricelistData.getDeliverytype2()==1 && !pricelistData.getOption_flag2().equals("1")){
                        pricelistData.setRightnleft("1");
                    }else{
                        pricelistData.setRightnleft("2");
                    }
                }else if(strGoodsCompareTier.equals("cardTier")){
                    if(getCardName(cardNameHash,pricelistData.getShop_code(),pricelistData.getGoodsnm(),pricelistData.getPrice(),pricelistData.getPrice_card(),newCardShopList).equals("")){
                        pricelistData.setRightnleft("1");
                    }else{
                        pricelistData.setRightnleft("2");
                    }
                }else if(strGoodsCompareTier.equals("tariffTier")){
                    if(pricelistData.getAirconfeetype().equals("5")) {
                        pricelistData.setRightnleft("1");
                    }else{
                        pricelistData.setRightnleft("2");
                    }
                }else if(strGoodsCompareTier.equals("usedTier")){
                    if(pricelistData.getAirconfeetype().equals("4")) {
                        pricelistData.setRightnleft("2");
                    }else{
                        pricelistData.setRightnleft("1");
                    }
                }else if(strGoodsCompareTier.equals("authTier")){
                    if(pricelistData.getAuthflag().equals("Y")) {
                        pricelistData.setRightnleft("1");
                    }else{
                        pricelistData.setRightnleft("2");
                    }
                } else if(strGoodsCompareTier.equals("selectShopTier")){
                    if(blSimiliarModelCheck){
                    	if(selectShopList.contains("9999")){
	                        if((!selectShopCodeList.contains(pricelistData.getShop_code()) && !aryOvsShopList.contains(pricelistData.getShop_code())) || selectShopList.contains(pricelistData.getShop_code()+"")){
	                            pricelistData.setRightnleft("2");
	                        }else{
	                            pricelistData.setRightnleft("1");
	                        }
                    	}else{
	                        if(selectShopList.contains(pricelistData.getShop_code()+"")){
	                            pricelistData.setRightnleft("2");
	                        }else{
	                            pricelistData.setRightnleft("1");
	                        }
                    	}
                    }else{
                    	if(selectShopList.contains("9999")){
	                        if((!selectShopCodeList.contains(pricelistData.getShop_code()) && !aryOvsShopList.contains(pricelistData.getShop_code())) || selectShopList.contains(pricelistData.getShop_code()+"")){
	                            pricelistData.setRightnleft("1");
	                        }else{
	                            pricelistData.setRightnleft("2");
	                        }
                    	}else{
	                        if(selectShopList.contains(pricelistData.getShop_code()+"")){
	                            pricelistData.setRightnleft("1");
	                        }else{
	                            pricelistData.setRightnleft("2");
	                        }
                    	}
                    }
                }
            }
            JSONObject tmpShopObject = new JSONObject();

            if(selectShopCodeList.indexOf(pricelistData.getShop_code()) > -1){
                tmpShopObject.put("shopcode", pricelistData.getShop_code());
                tmpShopObject.put("shopname", pricelistData.getShop_name());
            } else{
                tmpShopObject.put("shopcode", 9999);
                tmpShopObject.put("shopname", "기타");
                etcShopFlag = true;
            }
           // shopListHash.put(pricelistData.getShop_code(),tmpShopObject);
            shopListHash.put(tmpShopObject.getInt("shopcode"),tmpShopObject);

            if(pricelistData.getRightnleft().equals("1")){
                leftList.add(pricelistData);
            }else{
                rightList.add(pricelistData);
            }
        }
        Iterator<Integer> shopCodekeys = shopListHash.keySet().iterator();

        while( shopCodekeys.hasNext() ){
            int shopcode = shopCodekeys.next();
            if(shopcode !=9999){
                if(shopcode == 8446 || shopcode == 8447 || shopcode == 8448 || shopcode == 8826
                    || shopcode == 8827 || shopcode == 8828 || shopcode == 8829 || shopcode == 8830 || shopcode == 16174
                ){
                    selectShopOvsJSONArray.put(shopListHash.get(shopcode));
                }else{
                    selectShopJSONArray.put(shopListHash.get(shopcode));
                }
            }
        }
        if(etcShopFlag){
            JSONObject tmpShopObject = new JSONObject();
            tmpShopObject.put("shopcode", 9999);
            tmpShopObject.put("shopname", "기타");
            selectShopJSONArray.put(tmpShopObject);
        }
    }

    selectShopJSONObject.put("krShopList",selectShopJSONArray);
    selectShopJSONObject.put("ovsShopList",selectShopOvsJSONArray);
	//카드가일때 재정렬
    /*50822
	if(strSort.equals("card")){
		Collections.sort(rightList, new Comparator<Pricelist_Data>() {
            @Override
            public int compare(Pricelist_Data p1, Pricelist_Data p2) {
                if (p1.getPrice_card() < p2.getPrice_card()) {
                    return -1;
                } else if (p1.getPrice_card() > p2.getPrice_card()) {
                    return 1;
                }
                return 0;
            }
        });
	}*/
    //티어
    //System.out.println("left_list > " + leftList.size());
    //System.out.println("right_list > " + rightList.size());

    //변수처리
    long lnPlno = 0;

    long lnPrice = 0;               //가격
    long lnPrice2 = 0;       //배송비 포함가

    long lnCardPrice = 0;           //카드가
    String strCardName = "";        //카드명
	String strCardEventText = "";	//카드특가문구
    String strFreeInterest = "";    //무이자할부
    String strSrvFlag = "";

    long lnInstancePrice = 0;       //모바일가
    long lnGoodsMinPrice = 9999999999l;
    long lnMixPrice = 0;

    String strGoodsName = "";       //상품명
    String strGoodsCode = "";       //상품코드

    String strDeliveryPriceText = "";   //배송비
    String strDeliveryInfo = "";
    int intDeliveryInfo2 = 0;
    int intDeliveryType2 = 0;

    String strBidFlag ="";

    int intCoupon =0;
    String strCouponContents = "";
    String strCouponURL = "";
    String strCouponLayer[] = null; //쿠폰레이어
    String strImageUrl = "";        //상품이미지

    int intShopCode = 0;            //쇼핑몰코드
    String strShopName = "";        //쇼핑몰명
    String strShopType = "";        //쇼핑몰타입
    String strAirconfeeType = "";

    String strBadgeName = "";       //뱃지이름


    boolean blOverseaCheck =false;
    boolean blOverseaShoppingCheck =false;
    boolean blOverseaEmoneyCheck =false;
    boolean blTlcCheck = false;
    boolean blMobilePriceCheck = false;
    boolean blAdGoodsCheck = false;
    boolean blShopLogoImageCheck = false;
    boolean blDeliveryCodCheck = false;
	// 프로모션 자동화
	String vipCpnViewDcd = "";			// VIP 쿠폰 노출 구분 코드 : 문구노출 M, 쿠폰 할인가노출 C, 비노출, N
	String vipCpnViewStr = "";			// VIP 쿠폰 노출 문자열 : 문구 또는 할인가 문구
	String vipCpnIcnViewYn = "";		// VIP 쿠폰 아이콘 노출 여부
	String vipCpnDcViewYn = "";			// VIP 쿠폰 할인 노출 여부
	int vipDcPrice = 0;					// VIP 상품 할인가
	String vipRanUrl = "";				// 프로모션 랜딩 URL
	String vipCpnDcCndCd = "";			// 정액 인지 정률 구분값
	int vipRate = 0;					// VIP 상품 할인율
	int vipDcAmt = 0;					// 할인 해주는 금액

	String pcMiniVipIcnViewDcd = "";	//미니VIP 아이콘 노출 구분 코드 : 쿠폰 받기 노출 C, 이벤트 아이콘 노출: M
	String pcMiniVipIcnStr = "";		// 미니 VIP 아이콘 문자열

    String strOptionFlag = "";

    String[] seller_ad = {"",""};

    boolean blOptionBtnCheck =false;
    boolean blOptionCompCate = IsOptionCompCate(strCategory);

    boolean blEmoneyRewardShop = false;
    int intEmoneyReward = 0;

    JSONObject rtnJSONObject = new JSONObject();


    JsonResponse ret = null;

    String[] arryTier = {"left","right"};
    String strGoodsCompareTierTitle = "";
    int totalCnt = 0;

    for(int i=0;i<arryTier.length;i++){
    	ArrayList<Pricelist_Data> tmpList = new ArrayList<Pricelist_Data>();
        JSONArray tmpJSONArray = new JSONArray();
        JSONObject tmpJSONObject = new JSONObject();
        int intShowLine = 9;
        int intLimitShow = 0;

        if(arryTier[i].equals("left")){
        	tmpList = leftList;
            intShowLine = intShowLine + intLeftMore*50;
        }else{
        	tmpList = rightList;
            intShowLine = intShowLine + intRightMore*50;
        }
        totalCnt += tmpList.size();
       // intLimitShow = tmpList.size();
        //for(Pricelist_Data pricelistData : tmpList){
            for(int j=0;j<tmpList.size();j++){
			// 카드 할인가에서 결제 정보 뒤에는 "적용가"를 붙임
			//if(szCallDataOpt.equals("opt_card") && IsLeftRight.equals("right") && strCardEvent.length()>0 && strCardEvent.indexOf("적용가")<0) {
			//	strCardEvent = strCardEvent.replace("할인", "할인 적용가");
			//}
            Pricelist_Data pricelistData = tmpList.get(j);
            lnPlno = pricelistData.getPl_no();
            lnPrice = strCard.equals("Y") ? pricelistData.getMinprice() :  Long.valueOf(pricelistData.getPrice());
            lnPrice2 = lnPrice;
            lnMixPrice = pricelistData.getMinprice();

            lnInstancePrice = pricelistData.getInstance_price();

            strGoodsName = StringReplace(pricelistData.getGoodsnm());
            strGoodsCode = pricelistData.getGoodscode();
            strBidFlag = pricelistData.getBid_flag();

            strDeliveryPriceText = "";
            strDeliveryInfo = pricelistData.getDeliveryinfo();
            intDeliveryInfo2 = pricelistData.getDeliveryinfo2();
            intDeliveryType2 = pricelistData.getDeliverytype2();

            strImageUrl = pricelistData.getImgurl();

            intShopCode = pricelistData.getShop_code();
            strShopName = pricelistData.getShop_name();
            strShopType = pricelistData.getShop_type();
            intCoupon = pricelistData.getCoupon();
            strOptionFlag = pricelistData.getOption_flag();
            strSrvFlag = pricelistData.getSrvflag();
            strAirconfeeType = pricelistData.getAirconfeetype();

            blOverseaCheck = false;
            blOverseaEmoneyCheck = false;
            blOverseaShoppingCheck = false;
            blTlcCheck = false;
            blOptionBtnCheck = false;
            blMobilePriceCheck = false;
            blAdGoodsCheck = false;
            blShopLogoImageCheck = false;
            blDeliveryCodCheck = false;
            
            strBadgeName = "";
            vipCpnViewDcd = "";			// VIP 쿠폰 노출 구분 코드 : 문구노출 M, 쿠폰 할인가노출 C, 비노출, N
            vipCpnViewStr = "";			// VIP 쿠폰 노출 문자열 : 문구 또는 할인가 문구
            vipCpnIcnViewYn = "";		// VIP 쿠폰 아이콘 노출 여부
            vipCpnDcViewYn = "";			// VIP 쿠폰 할인 노출 여부
            vipDcPrice = 0;					// VIP 상품 할인가
            vipRanUrl = "";				// 프로모션 랜딩 URL
            vipCpnDcCndCd = "";			// 정액 인지 정률 구분값
            vipRate = 0;					// VIP 상품 할인율
            vipDcAmt = 0;					// 할인 해주는 금액
            pcMiniVipIcnViewDcd = "";	//미니VIP 아이콘 노출 구분 코드 : 쿠폰 받기 노출 C, 이벤트 아이콘 노출: M
            pcMiniVipIcnStr = "";		// 미니 VIP 아이콘 문자열
            seller_ad[0] = "";       //판매자광고
            seller_ad[1] = "";       //판매자광고

            //쇼핑몰이미지로고 flag
            if(aryShopLogoImgList.contains(intShopCode)){
                blShopLogoImageCheck = true;
            }
            //쿠폰레이어
            int couponlistType = 1;
            if(strSort.equals("card")) couponlistType = 3;
            else couponlistType = 1;

            strCouponLayer = getCouponLayerInfo(intShopCode, intCoupon, pricelistData.getPrice(), couponlistType, couponLayerAry);

            if(strCouponLayer != null){
                strCouponContents = strCouponLayer[0];
                strCouponURL = strCouponLayer[1];
            }else{
                strCouponContents = "";
                strCouponURL = "";
            }

            //카드가설정
            lnCardPrice = Long.valueOf(pricelistData.getPrice_card());
            strCardName = getCardName(cardNameHash,intShopCode,strGoodsName,lnPrice,lnCardPrice,newCardShopList);
            strCardEventText = getCardEventText(intShopCode,strGoodsName,lnCardPrice,strCardName,strCardName.split(","));
            strFreeInterest = getForceFreeInterest2(intShopCode,strCategory,pricelistData.getFreeinterest(),lnPrice,cardFreeAry);


    		if (goodsLsv11StMap != null && goodsLsv11StMap.containsKey(strGoodsCode)) {
    			Goods_Lsv_11St_Data goodsLsv11StData = goodsLsv11StMap.get(strGoodsCode);

    			if (goodsLsv11StData != null) {
    				 vipCpnViewDcd = goodsLsv11StData.getPc_vip_cpn_view_dcd();
    				 vipCpnViewStr = goodsLsv11StData.getPc_vip_cpn_view_str();
    				 vipCpnIcnViewYn = goodsLsv11StData.getPc_vip_cpn_icn_view_yn();
    				 vipCpnDcViewYn = goodsLsv11StData.getPc_vip_cpn_dc_view_yn();
    				 vipDcPrice = goodsLsv11StProcAjax.accDiscountPrice(goodsLsv11StData, (int)lnPrice);
    				 vipRanUrl = goodsLsv11StData.getPc_promtn_url();
    				 vipCpnDcCndCd = goodsLsv11StData.getCpn_dc_cnd_cd();
    				 vipRate = goodsLsv11StData.getCpn_dc_rt();
    				 vipDcAmt = goodsLsv11StData.getCpn_dc_amt();

    				 pcMiniVipIcnViewDcd = goodsLsv11StData.getPc_minivip_icn_view_dcd();
    				 pcMiniVipIcnStr = goodsLsv11StData.getPc_minivip_icn_str();

    				// eventCouponCheck = true;
    			}
    		}
            //판매자 광고
            if(arrSellerAd!=null && arrSellerAd.length>0){
                for(int sad_i=0; sad_i<arrSellerAd.length; sad_i++){
                    if(lnPlno==ChkNull.chkLong(arrSellerAd[sad_i][0])){
                        seller_ad[0] = ChkNull.chkStr(arrSellerAd[sad_i][0]);
                        seller_ad[1] = ChkNull.chkStr(arrSellerAd[sad_i][1]);
                        break;
                    }
                }
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
                        lnPrice2 += intDeliveryInfo2;
    				}
                }else if(intDeliveryType2==1){
                        strDeliveryPriceText = String.valueOf(intDeliveryInfo2);
                        lnPrice2 += intDeliveryInfo2;
                }
            }

            //옵션 플래그 설정
            //2022.01.04 성인카테 변경 1640->163630 
            /*if(!strGoodsCompareTier.equals("cardTier")
                && ControlUtil.compareValOR(new int[]{intShopCode,49,90,536,4027,5910,6547})
                && !strCate6.equals("163630")){
                if(((blOptionCompCate && !strOptionFlag.equals("N")) || intDeliveryInfo2>0)){
                    blOptionBtnCheck = true;
                }else {
                    blOptionBtnCheck = false;
                }
            }*/


            intEmoneyReward = (int)(Math.floor(flRewardRate * 0.01 * lnPrice / 10) * 10);
            //배송 뱃지

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
            //해외 배송
            if(!strGoodsCompareTier.equals("tariffTier") && strAirconfeeType.trim().equals("6") && strGoodsName.indexOf("[해외쇼핑]")<0){
                blOverseaShoppingCheck = true;
            }
             if(aryOvsShopList.contains(intShopCode)){
                if( !(intShopCode == 16174 || intShopCode ==  8830) ){
                    blOverseaEmoneyCheck = true;
                }
                blOverseaCheck = true;
            }
            //TCL Check
            if(strSrvFlag.equals("T")){
                blTlcCheck = true;
            }
            //모바일 특가 체크
            if(lnInstancePrice > 0 && lnInstancePrice < lnPrice){
                blMobilePriceCheck = true;
            }
            //광고 뱃지
            if(!strBidFlag.equals("9")){
                blAdGoodsCheck = true;
            }

            //카드이벤트 동일 카드명 제거
            if(!strCardEventText.equals("")){
                strCardEventText = strCardEventText.replace(strCardName,"");
            }
            //상품 최저가 계산 (카드할인가 최저가 까지 )
            if(strSort.equals("price")){
                if(strDelivery.equals("Y")){
                    if(lnGoodsMinPrice > lnPrice2){
                        lnGoodsMinPrice = lnPrice2;
                    }
                }else if(strCard.equals("Y")){
                    if(lnGoodsMinPrice > lnMixPrice){
                        lnGoodsMinPrice = lnMixPrice;
                    }
                }else{
                    if(lnGoodsMinPrice > lnPrice){
                        lnGoodsMinPrice = lnPrice;
                    }
                }
            }
            JSONObject pObject = new JSONObject();
            pObject.put("plno", lnPlno);
            pObject.put("price", lnPrice);
            pObject.put("price2", lnPrice2);
            pObject.put("shopbid", strBidFlag);
            pObject.put("delivery_price", intDeliveryInfo2);
            pObject.put("cardevnt_text", strCardEventText);
            pObject.put("cardprice", lnCardPrice);
            pObject.put("cardname", strCardName);
            pObject.put("freeinterest", strFreeInterest);
            pObject.put("instanceprice", lnInstancePrice);
            pObject.put("goodsname", strGoodsName);
            pObject.put("goodscode", strGoodsCode);
            pObject.put("delivery_text", strDeliveryPriceText);
            pObject.put("deliveryCod_check", blDeliveryCodCheck);
            
            pObject.put("seller_ad", seller_ad[1]);

            //pObject.put("deliveryinfo", strDeliveryInfo);
            //pObject.put("deliveryinfo2", intDeliveryInfo2);
            //pObject.put("deliverytype2", intDeliveryType2);
            pObject.put("imageurl", strImageUrl);
            pObject.put("shopcode", intShopCode);
            pObject.put("shopname", strShopName);
            pObject.put("shoptype", strShopType);

			pObject.put("badgename", strBadgeName);
            pObject.put("option_check", blOptionBtnCheck);
            pObject.put("emoney_reward", intEmoneyReward);

            pObject.put("coupon", intCoupon);
            pObject.put("coupon_contents", strCouponContents);
            pObject.put("coupon_url", strCouponContents);

            pObject.put("overseaEmoney_check", blOverseaEmoneyCheck);
            pObject.put("oversea_check", blOverseaCheck);
            pObject.put("overseaShopping_check", blOverseaShoppingCheck);
            pObject.put("tlcshop_check", blTlcCheck);
            pObject.put("mobileprice_check", blMobilePriceCheck);
            pObject.put("ad_check", blAdGoodsCheck);

            pObject.put("shoplogo_check", blShopLogoImageCheck);

            pObject.put("promotion_cpnViewDcd", vipCpnViewDcd);
            pObject.put("promotion_cpnViewText", vipCpnViewStr);
            pObject.put("promotion_cpnIconView", vipCpnIcnViewYn);
            pObject.put("promotion_cpnDcView", vipCpnDcViewYn);
            pObject.put("promotion_cpnDcPrice", vipDcPrice);
            pObject.put("promotion_cpnRandUrl", vipRanUrl);
            pObject.put("promotion_cpnDcCode", vipCpnDcCndCd);
            pObject.put("promotion_cpnRate", vipRate);
            pObject.put("promotion_cpnDcAmt", vipDcAmt);
            pObject.put("promotion_cpnMiniVipIconView", pcMiniVipIcnViewDcd);
            pObject.put("promotion_cpnMiniVipIconViewText", pcMiniVipIcnStr);

        	//pObject.put("emoney_badge", blEmoneyRewardShop);

        	//쇼핑몰자동화

            tmpJSONArray.put(pObject);
        }
        if(arryTier[i].equals("left")){
            if(strSort.equals("price")){
                if(strGoodsCompareTier.equals("freeShipTier")) strGoodsCompareTierTitle = "무료배송";
                if(strGoodsCompareTier.equals("shopScaleTier")) strGoodsCompareTierTitle = "오픈마켓 ";
                if(strGoodsCompareTier.equals("deliveryTier")) strGoodsCompareTierTitle = "배송비 포함가격";
                if(strGoodsCompareTier.equals("cardTier")) strGoodsCompareTierTitle = "일반 결제조건 가격";
                if(strGoodsCompareTier.equals("tariffTier")) strGoodsCompareTierTitle = "세금,배송비 무료";
                if(strGoodsCompareTier.equals("usedTier")) strGoodsCompareTierTitle = "전시/중고 ";
                if(strGoodsCompareTier.equals("authTier")) strGoodsCompareTierTitle = "인증 공식 판매자";
                if(strGoodsCompareTier.equals("selectShopTier")) strGoodsCompareTierTitle = "선택 쇼핑몰";
            }else if(strSort.equals("delivery")){
                if(strGoodsCompareTier.equals("authTier")) strGoodsCompareTierTitle = "인증 공식 판매자";
                else strGoodsCompareTierTitle = "배송비 포함가격";
            } else if(strSort.equals("card")){
                if(strGoodsCompareTier.equals("cardTier")) strGoodsCompareTierTitle = "일반 결제조건 가격";
            }
        }else{
            if(strSort.equals("price")){
                if(strGoodsCompareTier.equals("freeShipTier")) strGoodsCompareTierTitle = "배송비 유/무료";
                if(strGoodsCompareTier.equals("shopScaleTier")) strGoodsCompareTierTitle = "일반 쇼핑몰 ";
                if(strGoodsCompareTier.equals("deliveryTier")) strGoodsCompareTierTitle = "착불/조건부배송 상품";
                if(strGoodsCompareTier.equals("cardTier")) strGoodsCompareTierTitle = "특정카드 할인가";
                if(strGoodsCompareTier.equals("tariffTier")) strGoodsCompareTierTitle = "세금,배송비 유/무료";
                if(strGoodsCompareTier.equals("usedTier")) strGoodsCompareTierTitle = "반품/리퍼";
                if(strGoodsCompareTier.equals("authTier")) strGoodsCompareTierTitle = "일반 쇼핑몰";
                if(strGoodsCompareTier.equals("selectShopTier")) strGoodsCompareTierTitle = "선택 외 쇼핑몰";
            }else if(strSort.equals("delivery")){
                if(strGoodsCompareTier.equals("authTier")) strGoodsCompareTierTitle = "착불/조건부배송 상품";
                else strGoodsCompareTierTitle = "착불/조건부배송 상품";
            } else if(strSort.equals("card")){
                if(strGoodsCompareTier.equals("cardTier")) strGoodsCompareTierTitle = "특정카드 할인가";
            }

        }
        tmpJSONObject.put("priceList",tmpJSONArray);
        tmpJSONObject.put("pricelistTitle",strGoodsCompareTierTitle);
        tmpJSONObject.put("pricelistCount",tmpList.size());
        if(arryTier[i].equals("right")){
            //VIP 주의사항
            JSONArray caution_info_All_data =  wide_prod_proc.getCautionInfoView(true, strCategory, strModelName, strFactory, strBrand, intModelno+"","3");
            String caution_nos = "";
            if(caution_info_All_data.length()> 0){
                JSONObject tmpObject = new JSONObject();
                for(int x=0;x<caution_info_All_data.length();x++){
                    if(x>0) caution_nos+=",";
                    caution_nos += caution_info_All_data.getJSONObject(x).getInt("seq_no");
                }
                tmpObject = caution_info_All_data.getJSONObject(0);
                tmpObject.put("imgmap_list",wide_prod_proc.getImgMap(tmpObject.getInt("seq_no")));
                tmpObject.put("content_list",wide_prod_proc.getCaution_Info_Content_List(true, caution_nos));
                tmpJSONObject.put("cautionInfo",tmpObject);
            }
              //옵션 필수 상품
            JSONArray optionEssentialJSONArray = new JSONArray();
            if(optionEssentialList.size() > 0){
                for(int o=0;o<optionEssentialList.size();o++){
                    Pricelist_Data pricelistData = optionEssentialList.get(o);
                    lnPlno = pricelistData.getPl_no();
                    lnPrice = Long.valueOf(pricelistData.getPrice());

                    strGoodsName = StringReplace(pricelistData.getGoodsnm());
                    strGoodsCode = pricelistData.getGoodscode();

                    strDeliveryPriceText = "";
                    strDeliveryInfo = pricelistData.getDeliveryinfo();
                    intDeliveryInfo2 = pricelistData.getDeliveryinfo2();
                    intDeliveryType2 = pricelistData.getDeliverytype2();

                    intShopCode = pricelistData.getShop_code();
                    strShopName = pricelistData.getShop_name();
                    strShopType = pricelistData.getShop_type();
                    blShopLogoImageCheck = false;

                    if(aryShopLogoImgList.contains(intShopCode)){
                        blShopLogoImageCheck = true;
                    }
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
                    JSONObject pObject = new JSONObject();
                    pObject.put("plno", lnPlno);
                    pObject.put("price", lnPrice);
                    pObject.put("goodscode", strGoodsCode);
                    pObject.put("delivery_text", strDeliveryPriceText);
                    pObject.put("shopcode", intShopCode);
                    pObject.put("shopname", strShopName);
                    pObject.put("shoplogo_check", blShopLogoImageCheck);
                    optionEssentialJSONArray.put(pObject);
                }
                tmpJSONObject.put("optInfo",optionEssentialJSONArray);
            }
        }
        rtnJSONObject.put(arryTier[i],tmpJSONObject);
    }
    //cash몰 추가
    Pricelist_Data[] arrayCashPricelist = null;
    /*
    if(strSort.equals("delivery")){
        arrayCashPricelist = wide_prod_proc.Pricelist_CashDetail_List(intModelno, true);
    }else{
        arrayCashPricelist = wide_prod_proc.Pricelist_CashDetail_List(intModelno, false);
    }*/

    arrayCashPricelist = wide_prod_proc.Pricelist_CashDetail_List(intModelno, blDelivery);

    JSONArray cashShopJSONArray = new JSONArray();
    JSONObject cashShopJSONObject = new JSONObject();
    if(arrayCashPricelist.length > 0){
        for(int i=0;i<arrayCashPricelist.length;i++){
			Pricelist_Data pricelistData = arrayCashPricelist[i];
			lnPlno = pricelistData.getPl_no();
            lnPrice = Long.valueOf(pricelistData.getPrice());
            lnPrice2 = lnPrice;
			lnInstancePrice = pricelistData.getInstance_price();

            strGoodsName = StringReplace(pricelistData.getGoodsnm());
            strGoodsCode = pricelistData.getGoodscode();

            strDeliveryInfo = pricelistData.getDeliveryinfo();
            intDeliveryInfo2 = pricelistData.getDeliveryinfo2();
            intDeliveryType2 = pricelistData.getDeliverytype2();

            strImageUrl = pricelistData.getImgurl();

            intShopCode = pricelistData.getShop_code();
            strShopName = pricelistData.getShop_name();
            intCoupon = pricelistData.getCoupon();
            strDeliveryPriceText = "";
            blShopLogoImageCheck = false;
            if(aryShopLogoImgList.contains(intShopCode)){
                blShopLogoImageCheck = true;
            }
            //배송비설정
            // deliveryType2==0 : 배송비 정보가 불명확함
    		// deliveryType2==1 : 배송비 정보가 정확학
    		// 배송비 정보는 deliveryInfo2에 들어 있으며
    		// deliveryInfo2==0 이면 무료배송
    		// deliveryInfo의 정보는 배송비가 정해지는 규칙이 들어 있음(업체에서 입력)
            if(aryOvsShopList.contains(intShopCode)){
                strDeliveryPriceText = "해외배송(별도)";
            }else if( strDeliveryInfo.equals("무료배송")  ||
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
                        lnPrice2 += intDeliveryInfo2;
    				}
                }else if(intDeliveryType2==1){
                        strDeliveryPriceText = String.valueOf(intDeliveryInfo2);
                        lnPrice2 += intDeliveryInfo2;
                }
            }
            JSONObject pObject = new JSONObject();
            pObject.put("plno", lnPlno);
            pObject.put("price", lnPrice);
            pObject.put("price2", lnPrice2);
            pObject.put("delivery_price", intDeliveryInfo2);
            pObject.put("instanceprice", lnInstancePrice);
            pObject.put("goodsname", strGoodsName);
            pObject.put("goodscode", strGoodsCode);
            pObject.put("delivery_text", strDeliveryPriceText);
            pObject.put("imageurl", strImageUrl);
            pObject.put("shopcode", intShopCode);
            pObject.put("shopname", strShopName);
            pObject.put("coupon", intCoupon);
            pObject.put("shoplogo_check", blShopLogoImageCheck);
            cashShopJSONArray.put(pObject);
            totalCnt++;
		}
    }

    cashShopJSONObject.put("priceList",cashShopJSONArray);
    cashShopJSONObject.put("pricelistCount", cashShopJSONArray.length());

    rtnJSONObject.put("cash",cashShopJSONObject);
    rtnJSONObject.put("selectShopList",selectShopJSONObject);
    rtnJSONObject.put("cardfilterCheck",blCardSaleCheck);
    rtnJSONObject.put("similarModelCheck",blSimiliarModelCheck);
    rtnJSONObject.put("goodsCompareTier",strGoodsCompareTier);
    rtnJSONObject.put("authCode",strAuthCode);
    rtnJSONObject.put("goodsMinPrice",lnGoodsMinPrice);

    ret = new JsonResponse(true).setData(rtnJSONObject).setTotal(totalCnt);
    out.println(ret.toString());
%>

