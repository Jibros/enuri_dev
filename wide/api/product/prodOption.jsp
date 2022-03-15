<%@ page contentType="text/html; charset=utf-8" trimDirectiveWhitespaces="true" %>
<%@ page import="java.util.*"%>
<%@ page import="com.enuri.util.common.*"%>
<%@ page import="com.enuri.util.common.ConfigManager"%>
<%@ page import="com.enuri.util.common.ChkNull"%>
<%@ page import="com.enuri.util.common.ReplaceStr"%>
<%@ page import="com.enuri.util.common.JsonResponse"%>
<%@ page import="com.enuri.bean.lsv2016.Vip_View_Proc"%>
<%@ page import="com.enuri.bean.lsv2016.Goods_Lsv_Proc"%>
<%@ page import="com.enuri.bean.main.Goods_Proc"%>
<%@ page import="com.enuri.bean.main.Goods_Data"%>
<%@ page import="com.enuri.bean.main.Pricelist_Data"%>
<%@ page import="com.enuri.bean.main.Pricelist_Proc"%>
<%@ page import="com.enuri.bean.wide.Wide_Prod_Proc"%>
<%@ page import="org.json.*"%>

<%
    if(!CvtStr.isNumeric(request.getParameter("modelno"))){
		return ;
	}
    int intModelno = ChkNull.chkInt(request.getParameter("modelno"), 0);
    String strDeliveryFlag = ChkNull.chkStr(request.getParameter("delivery"), "N");
	String strUnitFlag = ChkNull.chkStr(request.getParameter("unit"),"N");	//단위당 최저가 순 정렬
    

    Goods_Proc goodsProc = new Goods_Proc();
    Wide_Prod_Proc wide_prod_proc = new Wide_Prod_Proc();
    Goods_Data goodsData = goodsProc.Goods_Detailmulti_One(intModelno,"Detailmulti");
    JsonResponse ret = null;
    JSONObject rtnJSONObject = new JSONObject();
     if( goodsData == null ) {
        ret = new JsonResponse(false).setData(rtnJSONObject);
        out.println(ret.toString());
        return ;
    }

    int intModelnoGroup = goodsData.getModelno_group();
    String strCategory = goodsData.getCa_code();
    String strFactory = goodsData.getFactory();  
	String strModelName = goodsData.getModelnm();
	
	long lnMinPrice3 = goodsData.getMinprice3();
	String strCondiname = goodsData.getCondiname();
    String strSpec = goodsData.getSpec();
    String strConstrain = goodsData.getConstrain();

    String strCate2 = "";
    String strCate4 = "";
    String strCate6 = "";
    String strCate8 = "";
    boolean blUnit = false;
    boolean blDelivery = false;

    if(strUnitFlag.equals("Y")){
        blUnit = true;
    }
    if(strDeliveryFlag.equals("Y")){
        blDelivery = true;
    }

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
    
    Goods_Data[] arrayOptionList = wide_prod_proc.Goods_Group_Condiname_List3(intModelnoGroup, blDelivery,blUnit);
    Vip_View_Proc vip_view_proc = new Vip_View_Proc();
	String strViewType = vip_view_proc.getViewType(strCate4);

    int intOptionModelno = 0;
    String strOptionModelNm = "";
    long lnOptionMinPrice = 0;
    long lnOptionMinPrice2 = 0;
    long lnOptionMinPrice3 = 0;
    int intOptionMallCnt = 0;
    String strOptionSpec = "";

    String strOptionCondiname = "";
    String strOptionOpenExpectFlag = "";
    int intOptionPopular = 0;
    int intOptionRankNo = 0;
    String strOptionCdate = "";
    
    float flOptionStandard = 0.0f;
    int intOptionAmount = 0;
    int intOptionChange = 0;

    String strOptionUnit = "";
    String strOptionUnitText = "";
    
    String strOptionOvsMinYn = "";
    String strOptionCashMinYn = "";
    long lnOptionCashMinPrice = 0 ;
    boolean blCashCheck = false;

    String strDeliveryPriceText = "";   //배송비
    String strDeliveryInfo = "";
    int intDeliveryInfo2 = 0;
    int intDeliveryType2 = 0;
    long lnUnitPerPrice = 0;

    boolean blOptionUnitType = false;
    String strOtionUnit = "";

    String strCondiLogo = "";

    JSONArray rtnJSONArray = new JSONArray();

    if(arrayOptionList.length > 0){
        Pricelist_Data[] arrayPricelist = null;
        Pricelist_Proc priceListProc = new Pricelist_Proc();
        int intOptionLength = arrayOptionList.length;
        for(Goods_Data optionData : arrayOptionList){
            intOptionModelno = optionData.getModelno();
            lnOptionMinPrice = Long.valueOf(optionData.getMinprice());
            lnOptionMinPrice2 = Long.valueOf(optionData.getMinprice2());
            lnOptionMinPrice3 = Long.valueOf(optionData.getMinprice3());
            intOptionMallCnt = optionData.getMallcnt();
            strOptionSpec = optionData.getSpec();
            strOptionCondiname = optionData.getCondiname();
            strOptionOpenExpectFlag = optionData.getOpenexpectflag();
            intOptionPopular = optionData.getPopular();
            strOptionCdate = optionData.getC_date();
            flOptionStandard = optionData.getStandard();
            intOptionAmount = optionData.getAmount();
            intOptionChange = optionData.getChange();
            strOptionUnit = optionData.getUnit();
            intOptionRankNo = optionData.getRankno();
            strOptionOvsMinYn = optionData.getOvs_min_prc_yn();
            strOptionCashMinYn = optionData.getCash_min_prc_yn();
            lnOptionCashMinPrice = optionData.getCash_min_prc();
            blCashCheck = false;
            strCondiLogo = "";
            //랭킹 규칙
            if(strOptionCondiname.indexOf("리퍼") > -1 || strOptionCondiname.indexOf("전시") > -1  || strOptionCondiname.indexOf("옵션필수") > -1 ){
                intOptionRankNo = 0;
            }
            if(strOptionCondiname.equals("삼성닷컴")){
                strCondiLogo = "http://img.enuri.info/images/rev/ad_brand_samsung.png";
            }
            //구매옵션 현금몰 제외 (#47152)
            if(!strOptionCashMinYn.equals("Y")){
                if(lnOptionCashMinPrice > 0){
                    lnOptionCashMinPrice = 0;           //Y->N으로 떨어졌을때 가격 유지여서 0원으로 만들어줌 
                }
            }else { //현금최저가일때 min2,min3 업거나 포함되지않기때문에 cashminprice로 세팅 
                if(lnOptionMinPrice3 == 0 && intOptionMallCnt>0){
                    lnOptionMinPrice2 = lnOptionCashMinPrice;
                    lnOptionMinPrice3 = lnOptionCashMinPrice;
                    blCashCheck = true;
                }
            }

            //단위당 환산가 규칙
            long tmpPrice = 0;
            if(strDeliveryFlag.equals("Y")){
                tmpPrice = lnOptionMinPrice2;
            }else {
                tmpPrice = lnOptionMinPrice3;
            }

            if(tmpPrice > 0 && !strOptionUnit.equals("") && strOptionCondiname.trim().length() > 0 && (!(strOptionCondiname.equals("일반") || strOptionCondiname.equals("옵션필수")))){
                if(intOptionChange == 1){
                    strOptionUnitText = strOptionUnit;
                }else {
                    strOptionUnitText = intOptionChange + strOptionUnit;
                }
                blOptionUnitType = true;
                strOtionUnit = strOptionUnitText;
                lnUnitPerPrice = (long)((double)tmpPrice/(double)(flOptionStandard*(double)intOptionAmount)*(double)intOptionChange+0.5);
            }



             //배송비설정
            // deliveryType2==0 : 배송비 정보가 불명확함
    		// deliveryType2==1 : 배송비 정보가 정확학
    		// 배송비 정보는 deliveryInfo2에 들어 있으며
    		// deliveryInfo2==0 이면 무료배송
    		// deliveryInfo의 정보는 배송비가 정해지는 규칙이 들어 있음(업체에서 입력)
            if(strDeliveryFlag.equals("Y")){
                arrayPricelist = priceListProc.Pricelist_DetailMulti_List4("", intOptionModelno, "", strCategory, "", false, 0, true,false);
            }else{
                arrayPricelist = priceListProc.Pricelist_DetailMulti_List4("", intOptionModelno, "", strCategory, "", false, 0, false,false);
            }
            if(arrayPricelist != null && arrayPricelist.length > 0){
                for(Pricelist_Data pricelistData : arrayPricelist){
                    if(!pricelistData.getOption_flag2().equals("1")){
                        strDeliveryPriceText = "";   
                        strDeliveryInfo = pricelistData.getDeliveryinfo();
                        intDeliveryInfo2 = pricelistData.getDeliveryinfo2();
                        intDeliveryType2 = pricelistData.getDeliverytype2();
                        break;
                    }
                }
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
                        if(strOptionCashMinYn.equals("Y") && lnOptionCashMinPrice > 0){ //현금최저가일때min2 없음 min2 계산
                            lnOptionMinPrice2 = lnOptionCashMinPrice + intDeliveryInfo2;
                        }
                        strDeliveryPriceText = String.valueOf(intDeliveryInfo2);
                    }
                }else if(intDeliveryType2==1){
                    if(strOptionCashMinYn.equals("Y") && lnOptionCashMinPrice > 0){  //현금최저가일때min2 없음 min2 계산
                        lnOptionMinPrice2 = lnOptionCashMinPrice + intDeliveryInfo2;
                    }
                    strDeliveryPriceText = String.valueOf(intDeliveryInfo2);
                }
            }

            JSONObject oObject = new JSONObject();
            oObject.put("modelno",intOptionModelno);
            oObject.put("condiname",strOptionCondiname);
            oObject.put("price",lnOptionMinPrice3);
            oObject.put("price2",lnOptionMinPrice2);
            oObject.put("cash_check",blCashCheck);
            oObject.put("mallcnt",intOptionMallCnt);
            oObject.put("unit",strOptionUnitText);
            oObject.put("unit_per_price",lnUnitPerPrice);
            oObject.put("delivery_text",strDeliveryPriceText);
            oObject.put("condilogo",strCondiLogo);
            oObject.put("rank",intOptionRankNo);

            
            rtnJSONArray.put(oObject);
        }
        rtnJSONObject.put("optionList",rtnJSONArray);
        
        rtnJSONObject.put("optionViewType",strViewType);
        rtnJSONObject.put("optionUnit",strOtionUnit);
        rtnJSONObject.put("optionUnitType",blOptionUnitType);
    }
    ret = new JsonResponse(true).setData(rtnJSONObject).setTotal(rtnJSONArray.length());
    out.println(ret.toString());
%>
