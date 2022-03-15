<%@ page contentType="text/html; charset=utf-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@ include file="/common/jsp/COMMON_CONST.jsp"%>
<%@ include file="/login/Inc_AutoLoginSet_2010.jsp"%>
<%@ page import="com.enuri.bean.lsv2016.Category_Set_Proc"%>
<%@ page import="com.enuri.bean.lsv2016.Category_Set_Data"%>
<%@ page import="com.enuri.bean.lsv2016.Goods_Spec_Compare"%>
<%@ page import="com.enuri.bean.main.Goods_Data"%>
<%@ page import="com.enuri.bean.main.Goods_Proc"%>
<%@ page import="com.enuri.bean.main.Pricelist_Data"%>
<%@ page import="com.enuri.bean.main.Pricelist_Proc"%>
<%@ page import="com.enuri.bean.main.Mobile_Category_Proc"%>
<%@ page import="com.enuri.bean.main.Mobile_Category_Data"%>
<%@ page import="com.enuri.bean.main.Goods_Detail_Proc"%>
<%@ page import="com.enuri.bean.main.Goods_Detail_Data"%>
<%@ page import="com.enuri.bean.main.Save_Goods_Proc"%>
<%@ page import="com.enuri.bean.wide.Wide_Prod_Proc"%>
<%@ page import="com.enuri.bean.main.Category_Data"%>
<%@ page import="com.enuri.bean.logdata.Model_log_Proc"%>
<%@ page import="com.enuri.bean.mobile.Mobile_Pricelist_Proc"%>
<%@ page import="com.enuri.bean.event.every.HitBrandProc_2020"%>
<%@ page import="com.enuri.bean.lsv2016.InfoAd_Proc"%>
<%@ page import="com.enuri.bean.search.SearchFunction"%>
<%@ page import="org.json.JSONArray"%>
<%@ page import="org.json.JSONObject"%>

<%
    
    int intModelno = ChkNull.chkInt(request.getParameter("modelno"),0);
	int intPromotionNo = ChkNull.chkInt(request.getParameter("prono"), 0);
    String strFocus = ChkNull.chkStr(request.getParameter("focus"), "");
    // 서비스 워커 추가
	String swPushId = ChkNull.chkStr(request.getParameter("pushid"), "");

    String userAgentStr = request.getHeader("User-Agent");
     // 현재 도메인을 저장
    String strServerName = request.getServerName().trim();
    // 접속자 아이피를 저장
    String strRemoteHost = ConfigManager.szConnectIp(request);
    //referer 체크
    String strReferer = ChkNull.chkStr(request.getHeader("referer"),"");
    //개발 서버 확인
    boolean bldevFlag = (strServerName.indexOf("dev.enuri.com") > -1 );

    String browserInfoStr = "";
    if(userAgentStr!=null) {
        if(userAgentStr.indexOf("Chrome")>-1) browserInfoStr = "chrome";
        else if(userAgentStr.indexOf("Firefox")>-1) browserInfoStr = "firefox";
        else if(userAgentStr.indexOf("Safari")>-1) browserInfoStr = "safari";
        else if(userAgentStr.indexOf("MSIE")>-1 || userAgentStr.toLowerCase().indexOf("Trident")>-1) browserInfoStr = "ie";
    }

    String strZumCheck = "";
	Cookie[] cookies_zumchk = request.getCookies();
	if(cookies_zumchk!=null){
		for(int i=0;i<cookies_zumchk.length;i++){
			if(cookies_zumchk[i].getName().equals("FROMZUM")){
				strZumCheck = cookies_zumchk[i].getValue();
			}
		}
	}
	if(strZumCheck.equals("Y")){
		 response.sendRedirect("/view/detail.jsp?"+request.getQueryString());
		 return;
	}
     if(request.getRequestURL().indexOf("m.enuri.com/") > -1){
        response.setStatus(HttpServletResponse.SC_MOVED_PERMANENTLY);
        response.setHeader("Location", "http://www.enuri.com/detail.jsp?"+request.getQueryString());
        return ;
    }
    if(ChkNull.chkStr(request.getQueryString()).equals("")){
        out.println("<BR><BR>정상적인 접근이 아닌 경우 에누리를 차단을 하고 있습니다.");
        return;
    }
     if(intModelno==0) {
        //이후 모델번호로 품절상품 검색하는부분체크해서 srp로 redirection
        response.setStatus(HttpServletResponse.SC_MOVED_PERMANENTLY);
        response.setHeader("Location", "http://www.enuri.com/Index.jsp?frm=vip&frmmsg=0");
        return;
    }
  
    //현재 시간
    String strNowDateTime = com.enuri.util.date.DateStr.nowStr("yyyy.MM.dd. HH:mm");
	boolean IsAdultFlag = false;
    boolean blAdultCate = false;
	boolean blAdultAd = false;

	String USER_ID= cb.GetCookie("MEM_INFO","USER_ID");
    String TMPUSER_ID= cb.GetCookie("MEM_INFO","TMP_ID");
	String USER_NICK= cb.GetCookie("MEM_INFO","USER_NICK");
    String SNSTYPE = cb.GetCookie("MEM_INFO","SNSTYPE");
    String ADULTFLAG = cb.GetCookie("MEM_INFO","ADULT");
    
    
    Goods_Proc goodsProc = new Goods_Proc();
    Goods_Data goodsData = goodsProc.Goods_Detailmulti_One(intModelno, "Detailmulti");
    
    if(goodsData == null) {
        //302 > 301방식으로 변경
        //이후 모델번호로 품절상품 검색하는부분체크해서 srp로 redirection. 2021-01-22. shwoo
        response.setStatus(HttpServletResponse.SC_MOVED_PERMANENTLY);
		response.setHeader("Location", "http://www.enuri.com/Index.jsp?frm=vip&frmmsg=0");
        return;
    }

    //모바일 redirection
    HttpSession Mobilesession = request.getSession(true);
    boolean bRedirectMobile = false;
    if ( !ChkNull.chkStr(request.getParameter("from"),"").equals("mo") &&
        (
            (ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Linux") >= 0 ) ||
            (ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Mac") >= 0)
        )
       ){

        bRedirectMobile = true;
    }
    if (ChkNull.chkStr(request.getParameter("from"),"").equals("mo")){
        bRedirectMobile = false;
        Mobilesession.setAttribute("fromMobile","Y");
    }
    if ((String)Mobilesession.getAttribute("fromMobile") != null ){
        String strFromMobile = (String)Mobilesession.getAttribute("fromMobile");
        if (strFromMobile.equals("Y")){
            bRedirectMobile = false;
        }
    }
    if (
        ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") >= 0 ||
        ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad2") >= 0 ||
        ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("SHW-M380W") >= 0 ||
        ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("SHW-M380") >= 0 ||
        ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("SHV-E140S") >= 0 ||
        ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("SHV-E140L") >= 0 ||
        ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("SHW-M305W") >= 0 ||
        ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("LG-LU8300") >= 0 ||
        ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Nexus 7") >= 0 ||
        ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("IM-A850S") >= 0 ||
        ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("IM-A850K") >= 0 ||
        ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("IM-A850L") >= 0 ||
        ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("SCH-I815") >= 0 ||
        ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Nexus 10") >= 0)
    {
        bRedirectMobile = false;
    }
    if (ChkNull.chkStr(request.getParameter("fromLogo"),"").equals("Y")){
        bRedirectMobile = false;
    }
    if(request.getRemoteAddr().indexOf("58.234.199") >= 0 || request.getRemoteAddr().equals("14.39.184.145")) {
        bRedirectMobile = false;
    }
    if (bRedirectMobile && intModelno > 0){
        response.sendRedirect("/m/vip.jsp?modelno="+intModelno);
        return;
    }
    
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
	String strRelease_text = "";

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
    //크리테오 
    boolean blCriteo = false;
    //히트브랜드 관련
    boolean blHitBrandCheck = false;
    boolean blHitbrandIconCheck = false;
    //제조사, 팩토리 노출 
    boolean blBrand = true;
    boolean blFactory = true;

    String strHitBrandEventCode = "2021061601";
    int intHitBrandStartDate = 20210615;
    int intHitBrandEndDate = 20210730;

    String strViewID = "";
    String strEnrReferer  = "";
    //meta 키워드
    String strKeyword2 = "";
    String strMetaKeyword = "";
    String strMetaTitleTag = "";
    String strMetaCateName = "";
    //해외배송 쇼핑몰
    List<Integer> aryOvsShopList = Arrays.asList(new Integer[]{8446,8447,8448,8826,8827,8828,8829,8830,16174});
    //동일 시리즈 상품
    int intReferModelno = 0;
    int intRefernum = 0;

    JSONArray arrayThumNailList = new JSONArray();
    JSONArray arrayVideoList = new JSONArray();
    JSONArray arrayCertiList = new JSONArray();
    JSONArray  arrayaAllergyList  = new JSONArray();
    SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
    SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy.MM");
    SimpleDateFormat sdf3 = new SimpleDateFormat("yyyy.MM.dd");
    SimpleDateFormat sdf4 = new SimpleDateFormat("yyyy-MM-dd");
    Date dtNowTime = new Date();
	Date tmpDate = new Date();

    String strGoogleDate = sdf4.format(dtNowTime);

   	Pricelist_Proc priceListProc = new Pricelist_Proc();
    Category_Data categoryData = new Category_Data();
    Mobile_Pricelist_Proc mobilePriceListProc = new Mobile_Pricelist_Proc();
    Wide_Prod_Proc wide_prod_proc = new Wide_Prod_Proc();
    Goods_Detail_Proc goods_detail_proc = new Goods_Detail_Proc();
    Goods_Spec_Compare goods_spec_compare = new Goods_Spec_Compare();
    HitBrandProc_2020 hitProc = new HitBrandProc_2020();
    InfoAd_Proc infoAdProc = new InfoAd_Proc();
    Goods_Detail_Data[] specList = null;
    if(goodsData != null){
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
        
        intBbsNum = goodsData.getBbs_num();
        flBbsPointAvg = goodsData.getBbs_point_avg();
        strSpec = goodsData.getSpec();
        strOvsMinYn = goodsData.getOvs_min_prc_yn();
        strCashMinYn = goodsData.getCash_min_prc_yn();
        lngCashMinPrice = goodsData.getCash_min_prc();
        strConstrain = goodsData.getConstrain();
        strKeyword2 = goodsData.getKeyword2();
        intReferModelno = goodsData.getRefermodelno();

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
        //2022.01.04 성인카테 변경 1640->163630 
        if(strCate6.equals("163630") || strCate6.equals("931004") || strCate6.equals("051523") || strCate6.equals("051513")){
            blAdultCate = true;
        }
        if(ADULTFLAG!=null) {
                // 성인인증 됨
                if(ADULTFLAG.equals("1")) IsAdultFlag = true;
        }
        goodsData.setAdultChk(IsAdultFlag);
        strImageUrl = ImageUtil_lsv.getVIPImageSrc(goodsData);

        if(IsAdultFlag && blAdultCate) blAdultAd = true;
    
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
       

        Category_Set_Data[] category_set_data = null;
        Category_Set_Proc category_set_proc = new Category_Set_Proc();
        category_set_data = category_set_proc.getCategorySetList(strCate4);
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
                if(category_set_data[x].getTab_brand_flag().equals("0")){
                    blBrand = false;
                }
                if(category_set_data[x].getTab_factory_flag().equals("0")){
                    blFactory = false;
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
            strCdateView = "등록일 : " + sdf2.format(tmpDate);
        }
        //배송비
    	Pricelist_Data pricelistData = priceListProc.get_Vip_minpricedata(intModelno);
    	if(pricelistData != null){
    		lngPlMinPlno = pricelistData.getPl_no();
			lngPlMinPrice = pricelistData.getPrice();
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
		if(lngMinPrice > lngMinPrice3 && lngMinPrice3 > 0){
			Pricelist_Data mPlist = new Pricelist_Data();
			mPlist = mobilePriceListProc.get_Vip_minpricedata(intModelno);

			plMobileMinShopName = mPlist.getShop_name();
            plMobileMinShopCode = mPlist.getShop_code();
            lngPlMinInstancePrice = mPlist.getInstance_price();
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
		if(strSpec.indexOf("출시가:")  > -1){
			strRelease_text = "출시가";
			strRelease_price = strSpec.substring(strSpec.indexOf("출시가:")+4,strSpec.length());
		}else if(strSpec.indexOf("출고가:")  > -1){
			strRelease_text = "출고가";
			strRelease_price = strSpec.substring(strSpec.indexOf("출고가:")+4,strSpec.length());
		}

		if(strRelease_price.length()>0 && strRelease_text.length()>0){
			strRelease_price = strRelease_price.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>|", "");
			strRelease_price = strRelease_price.replaceAll("원","");
			if(strRelease_price.indexOf("/") > -1 ){
				strRelease_price = strRelease_price.substring(0,strRelease_price.indexOf("/"));
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

        ///인증정보 및 알레르기 정보
	    arrayCertiList = wide_prod_proc.getGoodsAttributeList(intModelno, 1);
        
        arrayaAllergyList = wide_prod_proc.getGoodsAttributeList(intModelno, 2);
		
        //히트브랜드 아이콘
        HashMap<Integer, JSONObject> h_infoAdIcon = infoAdProc.getIconList(bldevFlag);
        //광고아이콘
        JSONObject adIconObject = (intModelnoGroup >0) ? h_infoAdIcon.get(intModelnoGroup) : h_infoAdIcon.get(intModelno);
        if(adIconObject != null){
            if(adIconObject.getString("icon_type").equals("2")){
                blHitbrandIconCheck = true;
            }
        }

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

            
            if(TMPUSER_ID.equals("")) {
                //임시 ID 생성  날짜로 17자리로 생성 (select TO_CHAR(SYSTIMESTAMP, 'YYYYMMDDHH24MISSFF3') from dual)
                TMPUSER_ID = Category_Proc.getTmpID();
                cb.SetCookie("MYINFO", "TMP_ID", TMPUSER_ID);
            }
            //라이벌댓글 이벤트페이지에서 뜬경우 인기도로그 제외(toodoo 2009.10.01)
            if(!ChkNull.chkStr(request.getParameter("NewGoods")).trim().equals("1")) {
                boolean insertchk2 = false;
                int intPopularOrder = 0;
                try {
                    intPopularOrder = Integer.parseInt(ChkNull.chkStr(request.getParameter("porder"),"0"));
                    if(intPopularOrder > 10 ) intPopularOrder = 0;
                } catch(Exception pe) {
                }
                //인기도 조작 관련 Referer체크
                //Referer가 없거나 (상세창이 팝업창으로 뜬경우) Referer에 enuri.com 이 있을경우에만 사이트내에서 뜬 경우라고 판단함.
                //외부 사이트에서 우리쪽 상세창이나 Redirect페이지를 불러오는 경우 인기도 증가 시키지 않음
                //예)<img src="http://www.enuri.com/view/Detailmulti.jsp?modelno=XXXXXX">
                if (strReferer.trim().length() == 0 || strReferer.trim().toLowerCase().indexOf("enuri.com") >= 0 ) {
                    Model_log_Proc mlp = new Model_log_Proc();
                    try {
                        String strRefererM = strReferer;
                        if (strRefererM.indexOf("?") >= 0){
                            strRefererM = strRefererM.substring(0,strRefererM.lastIndexOf("?"));
                        }
                        if(strRefererM.indexOf("/list.jsp") >=0 ) strEnrReferer = "lp";
                        else if(strRefererM.indexOf("/search.jsp") >=0 ) strEnrReferer = "srp";
                        else if(strRefererM.indexOf("/Index.jsp") >=0 || strRefererM.equals("http://1dev.enuri.com/")) strEnrReferer = "home";
                        else if(strRefererM.indexOf("/exhibition_view_E.jsp") >=0 ) strEnrReferer = "exhibi";
                        if(request.getHeader("X-Forwarded-For").split(",")[0] == null){
                            System.out.println("strRemoteHost >> " + strRemoteHost);
                            //strRemoteHost = request.getHeader("X-Forwarded-For").split(",")[1];
                            System.out.println("requestRemoteAddr >> " + request.getRemoteAddr());
                            System.out.println("X-Forwarded-For >> " + request.getHeader("X-Forwarded-For"));
                            System.out.println("Proxy-Client-IP >> " + request.getHeader("Proxy-Client-IP"));
                            System.out.println("WL-Proxy-Client-IP >> " + request.getHeader("WL-Proxy-Client-IP"));
                            System.out.println("HTTP_CLIENT_IP >> " + request.getHeader("HTTP_CLIENT_IP"));
                            System.out.println("HTTP_X_FORWARDED_FOR >> " + request.getHeader("HTTP_X_FORWARDED_FOR"));
                        }
                        insertchk2 = mlp.Model_log_Insert2(intModelno, strCategory, TMPUSER_ID, strRemoteHost, intPopularOrder,strRefererM, USER_ID);  //20150917
                       
                    } catch(Exception pe) {
                    }
                }
            }
            
            //동일 시리즈 상품
            intRefernum = goodsProc.Goods_refermodelno_Count(intModelno, intReferModelno);
        }
        //크리테오 여부 
        if(ControlUtil.compareValOR(new String[]{CutStr.cutStr(strCategory,4),"0201", "0211", "0232", "0235", "0237", "0305", "0404", "0408", "0502", "0503", "0508", "0511", "0550", "0601", "0602", "0603", "0605", "0607", "0609", "2401", "2402", "2403", "2406", "0703", "0705", "0707", "0713"}) ) {
	        if(!strFactory.contains("바디프랜드")){
                blCriteo = true;
            }
        }
        //히트브랜드 여부 
        if(Integer.parseInt(sdf.format(dtNowTime)) <= intHitBrandEndDate && Integer.parseInt(sdf.format(dtNowTime)) >= intHitBrandStartDate){
            blHitBrandCheck = hitProc.hitProdCheck(intModelno, strHitBrandEventCode);
            if(!USER_ID.equals("") && blHitBrandCheck) {
                blHitBrandCheck = (hitProc.getModelStamp(USER_ID, strHitBrandEventCode, intModelno, 0) > 0) ? false : true;
            }
        }
        // 신규 메타태그 개선안 로직
		strMetaTitleTag = "최저가 검색 - 에누리가격비교";
		strMetaTitleTag = "'"+ReplaceStr.replace(strModelNmView, "'", "")+"'" + " 최저가 쇼핑 정보 - 에누리가격비교";
		String strMetaSpec = ReplaceStr.replace(ReplaceStr.replace(ReplaceStr.replace(strSpec,"'",""),"\"",""),"\r\n","");
		String [] MetaArray = strMetaSpec.split("/");
		strMetaKeyword = strKeyword2;
		strMetaKeyword = ReplaceStr.replace(strMetaKeyword,"\r\n", "");
		strMetaKeyword = ReplaceStr.replace(strMetaKeyword,"  ", " ");
		strMetaKeyword = ReplaceStr.replace(strMetaKeyword,"★", "▶");
		strMetaKeyword = ReplaceStr.replace(strMetaKeyword,"▶", "");
        strMetaKeyword = ReplaceStr.replace(strMetaKeyword,"\"", "&#34;"); //따옴표처리
		strMetaKeyword += " " + strMetaSpec;
        
        strMetaCateName = strModelNmView + " < " + strCateName6 + " < " + strCateName4 + " [에누리 가격비교]";

    }
%>

<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="description" content="<%=ReplaceStr.replace(strModelNmView,"'","")%> 최저가 - <%=strMetaKeyword%>">
        <meta name="keywords" content="<%=ReplaceStr.replace(strModelNmView,"'","")%> 최저가 - <%=strMetaKeyword%>">
        <meta name="format-detection" content="telephone=no">
        <!-- facebook -->
        <meta property="og:title" content="<%=strMetaCateName.replaceAll("<", "&lt;")%>">
        <meta property="og:description" content="<%=ReplaceStr.replace(strModelNmView,"'","")%>">
        <meta property="og:image" content="<%=strImageUrl %>">
        <!-- twitter -->
        <meta property="twitter:title" content="<%=strMetaCateName.replaceAll("<", "&lt;")%>">
        <meta property="twitter:description" content="<%=ReplaceStr.replace(strModelNmView,"'","")%>">
        <meta property="twitter:image" content="<%=strImageUrl %>">
        <!-- me2 -->
        <meta property="me2:title" content="<%=strMetaCateName.replaceAll("<", "&lt;")%>">
        <meta property="me2:description" content="<%=ReplaceStr.replace(strModelNmView,"'","")%>">
        <meta property="me2:image" content="<%=strImageUrl %>">

        <link rel="preconnect" href="//enuri.com" />
        <link rel="preconnect" href="//photo3.enuri.com" />
        <link rel="preconnect" href="//storage.enuri.gscdn.com" />
        <link rel="preconnect" href="//storage.enuri.info" />
        <link rel="preconnect" href="//ad-api.enuri.info" />
        <link rel="preconnect" href="//img.enuri.info" />

        <link rel="shortcut icon" href="http://img.enuri.info/2014/layout/favicon_enuri.ico">
        <link rel="canonical" href="http://www.enuri.com/detail.jsp?modelno=<%=intModelno%>"/>
        <link rel="alternate" media="only screen and (max-device-width: 640px)" href="http://m.enuri.com/m/vip.jsp?modelno=<%=intModelno%>"/>
        <title><%=strMetaTitleTag%></title>
        <!-- Stylesheet -->
        <link rel="preload" as="style"  href="/css/rev/common.css"/>
        <link rel="preload" as="style"  href="/css/swiper.css"/>
        <link rel="preload" as="style"  href="/css/rev/vip.css?v=20210804"/> <!-- vip -->
        <link rel="preload" as="style"  href="/css/rev/template.css?v=20210503"/> <!-- template -->
        <link rel="stylesheet" type="text/css" href="/css/swiper.css"/>
        <link rel="stylesheet" type="text/css" href="/css/rev/common.css"/>
        <link rel="stylesheet" type="text/css" href="/css/rev/template.css?v=20210503"/> <!-- template -->
        <link rel="stylesheet" type="text/css" href="/css/rev/vip.css?v=20210804"/> <!-- vip -->
        <script type="text/javascript" src="/wide/util/jquery-3.5.1.min.js"></script>
        <script type="text/javascript" src="/lsv2016/js/lib/jquery.lazyload.min.js"></script>
    	<script type="text/javascript" src="/common/js/function.js"></script>
        <script type="text/javascript" src="/wide/script/common/util.js"></script>
        <script defer type="text/javascript" src="/js/clipboard.min.js"></script> 
        <script defer type="text/javascript" src="/js/highcharts.js"></script>
        <script defer type="text/javascript" src="/js/swiper.min.js"></script>
        <script defer type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js?v=20180611"></script>
        
        <script defer type="text/javascript" src="/common/js/common_top_2021.js?v=20210603"></script>
        <script defer type="text/javascript" src="/common/js/getTopBanner_2021.js"></script>
        <script defer type="text/javascript" src="/common/js/eb/gnbTopRightBanner_2021.js"></script>
        <script defer type="text/javascript" src="/wide/script_min/common/nav.min.js"></script>
        <script defer type="text/javascript" src="/wide/script_min/ad/powerLink.min.js"></script>
        <script defer type="text/javascript" src="/wide/script/common/common_layer.js"></script>
        <script defer type="text/javascript" src="/wide/script/common/common_script.js"></script>
        
        <script defer type="text/javascript" src="/wide/script/common/zzim.js"></script>
        <script defer type="text/javascript" src="/wide/script/product/prod_powerclick.js?v=20210409"></script>
        <script defer type="text/javascript" src="/wide/script/product/prod_etc.js?v=20210503"></script>
        <script type="text/javascript" src="/common/js/babel.min.js"></script>
        <script type="text/javascript" src="/common/js/polyfill.min.js"></script>
        <script type="text/javascript">
            let gModelData = {
                gModelno : <%=intModelno%>,
                gCategory : "<%=strCategory%>",
                gCate4 : "<%=strCate4%>",
                gModelNmView : "<%=strModelNmView%>",
                gModelNmViewTag : "<%=strModelNmViewTag%>",
                gModelNm : "<%=strModelNm%>",
                gBrand : "<%=strBrand%>",
                gFactory : "<%=strFactory%>",
                gBbsNum : <%=intBbsNum%>,
                gBbsPointAvg  : "<%=String.format("%.1f", flBbsPointAvg)%>",
                gOvsMinPrcYn :"<%=strOvsMinYn%>",
                gCashShopOnly : <%=blCashShopOnly%>,
                gCashMinPrcYn : "<%=strCashMinYn%>",
                gImageUrl : "<%=strImageUrl%>",
                gMinDeliveryView : "<%=strMinDeliveryTextView%>",
                gMinPrice : <%=lngMinPrice%>,
                gMallCnt : <%=intMallCnt%>,
                gCdate : "<%=sdf2.format(tmpDate)%>",
                gCdateView : "<%=strCdateView%>",
                gConstrain : <%=blSimiliarModelCheck%>,
                gThumNailList : <%=arrayThumNailList.toString()%>,
                gVideoList : <%=arrayVideoList.toString()%>,
                gZzim : <%=blZzim%>,
                gCertiList : <%=arrayCertiList.toString()%>,
                gAllergyList : <%=arrayaAllergyList.toString()%>,
                gCompare : <%=blCompare%>,
                gCate4Nm : "<%=strCateName4%>",
                gCate6Nm : "<%=strCateName6%>",
                gCate8Nm : "<%=strCateName8%>", 
                gReferNm : <%=intRefernum%>, 
                gReferModelNm : <%=intReferModelno%> ,
                gHitBrandCheck : <%=blHitBrandCheck%>
            }
            const USER_ID = '<%=USER_ID%>';
            const TMPUSER_ID = '<%=TMPUSER_ID%>';
            const SNSTYPE = '<%=SNSTYPE%>';
            const USER_NICK = '<%=USER_NICK%>';
            const blAdultCate = <%=blAdultCate%>;
            const blAdult = <%=IsAdultFlag%>;
            const maintainanceShopCode = "5910";
            const minCheck = 202106100200;
            const maxCheck = 202106100400;
            
            let ie8Chk = false;
            let promo = <%=intPromotionNo%>;
            let blCriteo = <%=blCriteo%>;
            let focusName = "<%=strFocus%>";
            let enrRefer ="<%=strEnrReferer%>";
            var param_cate = "<%=strCategory%>";
            var param_keyword = "";
            var serviceWorker = "<%=swPushId%>";
        </script>
        <script src="/wide/script/product/prod_common.js" type="text/babel" data-plugins="transform-es2015-modules-umd" data-presets="es2015,stage-2"></script>
        <script src="/wide/script/product/prod_shopprice.js" type="text/babel" data-plugins="transform-es2015-modules-umd" data-presets="es2015,stage-2"></script>
        <script src="/wide/script/product/prod_pricecomp.js" type="text/babel" data-plugins="transform-es2015-modules-umd" data-presets="es2015,stage-2"></script>
        <script src="/wide/script/product/prod_qna.js" type="text/babel" data-plugins="transform-es2015-modules-umd" data-presets="es2015,stage-2"></script>
        <script src="/wide/script/product/prod_recomm.js" type="text/babel" data-plugins="transform-es2015-modules-umd" data-presets="es2015,stage-2"></script>
        <script src="/wide/script/product/prod_review.js" type="text/babel" data-plugins="transform-es2015-modules-umd" data-presets="es2015,stage-2"></script>
        <script src="/wide/script/product/prod_compspec.js" type="text/babel" data-plugins="transform-es2015-modules-umd" data-presets="es2015,stage-2"></script>
        <script src="/wide/script/product/prod_bbs.js" type="text/babel" data-plugins="transform-es2015-modules-umd" data-presets="es2015,stage-2"></script>
        <script src="/wide/script/product/prod_graph.js" type="text/babel" data-plugins="transform-es2015-modules-umd" data-presets="es2015,stage-2"></script>
        <script src="/wide/script/product/prod_desc.js" type="text/babel" data-plugins="transform-es2015-modules-umd" data-presets="es2015,stage-2"></script>
        <script src="/wide/script/product/prod_cate.js" type="text/babel" data-plugins="transform-es2015-modules-umd" data-presets="es2015,stage-2"></script>
        <script src="/wide/script/product/prod_option.js" type="text/babel" data-plugins="transform-es2015-modules-umd" data-presets="es2015,stage-2"></script>
        <script src="/wide/script/product/prod_init.js" type="text/babel" data-plugins="transform-es2015-modules-umd" data-presets="es2015,stage-2"></script>

        <%-- <script nomodule defer src="/wide/script/product/babel/prod_common.js" type="text/javascript"></script>
        <script nomodule defer src="/wide/script/product/babel/prod_shopprice.js" type="text/javascript"></script>
        <script nomodule defer src="/wide/script/product/babel/prod_pricecomp.js" type="text/javascript"></script>
        <script nomodule defer src="/wide/script/product/babel/prod_qna.js" type="text/javascript"></script>
        <script nomodule defer src="/wide/script/product/babel/prod_recomm.js" type="text/javascript"></script>
        <script nomodule defer src="/wide/script/product/babel/prod_review.js" type="text/javascript"></script>
        <script nomodule defer src="/wide/script/product/babel/prod_compspec.js" type="text/javascript"></script>
        <script nomodule defer src="/wide/script/product/babel/prod_bbs.js" type="text/javascript"></script>
        <script nomodule defer src="/wide/script/product/babel/prod_graph.js" type="text/javascript"></script>
        <script nomodule defer src="/wide/script/product/babel/prod_desc.js" type="text/javascript"></script>
        <script nomodule defer src="/wide/script/product/babel/prod_cate.js" type="text/javascript"></script>
        <script nomodule defer src="/wide/script/product/babel/prod_option.js" type="text/javascript"></script>
        <script nomodule defer src="/wide/script/product/babel/prod_init.js" type="text/javascript"></script> --%>

        <script src="/wide/script/product/prod_init.js" type="module"></script>
        <!--[if lte IE 8]>
        <script type="text/javascript">
        ie8Chk = true;
        </script>
        <![endif]-->
    </head>

    <body>
        <div class="comm-loader">
            <div class="comm-loader__inner">로딩중</div>
        </div>
        <!-- 히트브랜드 배너 -->
        <div class="hit_stamp" <%=(blHitBrandCheck ? " " : "style='display:none;'") %> >
            <a href="javascript:void(0);"><img src="http://img.enuri.info/images/event/2020/hitbrand/stamp_pc.png" title="클릭하시면 HIT 스탬프를 획득합니다." alt="HIT스탬프"></a>
            <button class="btn_stamp_close" onclick="$('.hit_stamp').fadeOut(100)">닫기</button>
        </div>
        <jsp:include page="/wide/common/jsp/Gnb.jsp" />
        <%@ include file="/wide/main/include/main_advod.jsp"%>
        <div class="container">
                <%@ include file="/wide/include/IncListLeftWing.jsp"%>
                <%@ include file="/wide/include/IncListRightWing.jsp"%>
                <div class="contents cont__inner">

                    <!-- [VIP] VIP 컨텐츠 -->
                    <div class="vip-page">
                        <div class="vip__top">
                            <div class="location"></div>

                            <div class="output">
                                <ul class="output__list">
                                     <li><button type="button" class="btn btn--zzim <%=(blZzim) ? "is--on":""%>" onclick="showLayZzim(this,gModelData.gModelno);insertLogLSV(14465,'<%=strCategory%>','<%=intModelno%>');"><span>찜</span></button></li>
                                    <li><button type="button" class="btn btn--share" onclick="insertLogLSV(18622,'<%=strCategory%>','<%=intModelno%>');" ><span>공유</span></button>

                                        <!-- 레이어:공유 -->
                                        <div class="lay-share lay-comm">
                                            <div class="lay-comm--head">
                                                <strong class="lay-comm__tit">공유하기</strong>
                                            </div>
                                            <div class="lay-comm--body">
                                                <div class="lay-comm--inner">
                                                    <ul class="lay-share__btn">
                                                        <li><a href="javascript:void(0);" class="lay-share__btn--fb">페이스북 공유하기</a></li>
                                                        <li><a href="javascript:void(0);" class="lay-share__btn--kakao">카카오톡 공유하기</a></li>
                                                        <li><a href="javascript:void(0);" class="lay-share__btn--tw">트위터 공유하기</a></li>
                                                    </ul>
                                                    <!-- 메인보내기 버튼클릭시 .mod--send-mail 추가해 주세요 -->
                                                    <div class="lay-share__form">
                                                        <div class="lay-share__group">
                                                            <!-- 주소복사하기 -->
                                                            <div class="lay-share__form--item">
                                                                <span id="txtURL" class="lay-share__tx--url"></span>
                                                                <button class="lay-comm__btn lay-share__btn--copy lay-btn--color--blue" data-clipboard-target="#txtURL">복사</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- 버튼 : 레이어 닫기 -->
                                            <button class="lay-comm__btn--close comm__sprite" onclick="$(this).parent().hide()">레이어 닫기</button>
                                        </div>
                                    </li>
                                    <li><button type="button" class="btn btn__declaration" onclick="insertLogLSV(14462,'<%=strCategory%>','<%=intModelno%>');"><span>신고하기</span></button></li>
                                    <li><button type="button" class="btn btn__print" onclick="insertLogLSV(18621,'<%=strCategory%>','<%=intModelno%>');"><span>출력하기</span></button></li>
                                    
                                </ul>
                            </div>
                        </div>

                        <!-- [상단] 상품 가격비교 요약 -->
                        <div class="prodsummary" >
                            <!-- 좌 -->
                            <div id="prod_summary_left" class="prodsummary__left">
                                <div class="inner">
                                    <!-- 상품 이미지/정보 -->
                                    <div class="proddetail">
                                        <div class="proddetail__thum">
                                            <div class="thum__cont">
                                                <%
												boolean directSdu = false;
											    boolean blSdul_ch = false;

											    if(ControlUtil.compareValOR(new String[]{cb.GetCookie("MEM_INFO","USER_ID"), "enuri007","auction","goodsdaq","icoda","joyup","compuzone"})){
													directSdu = true;
												}

											    if(cb.GetCookie("MEM_INFO","USER_ID") != "") blSdul_ch = Sdul_Member_Proc.Check_user(cb.GetCookie("MEM_INFO","USER_ID"));

												if(blSdul_ch || directSdu) {
												%>
                                                <!-- SDUL 회원 노출 -->
                                                <div class="sdul__member">
                                                    <ul>
                                                    	<%if(blSdul_ch) {%>
                                                        <li><a onclick="sdul_update_price();"><img src="http://img.enuri.info/images/view/catalog/btn_price.gif" onmouseover="this.src='http://img.enuri.info/images/view/catalog/btn_price_ov.gif';" onmouseout="this.src='http://img.enuri.info/images/view/catalog/btn_price.gif';" alt="가격수정"></a></li>
                                                        <li><a onclick="sdul_add();"><img src="http://img.enuri.info/images/view/catalog/btn_speed.gif" onmouseover="this.src='http://img.enuri.info/images/view/catalog/btn_speed_ov.gif';" onmouseout="this.src='http://img.enuri.info/images/view/catalog/btn_speed.gif';" alt="현재상품 Speed 등록"></a></li>
                                                        <li><a onclick="modelno_copy();"><img src="http://img.enuri.info/images/view/catalog/md-btn.gif" onmouseover="this.src='http://img.enuri.info/images/view/catalog/md-btn_ov.gif';" onmouseout="this.src='http://img.enuri.info/images/view/catalog/md-btn.gif';" alt="모델번호 확인"></a></li>
                                                        <%}		// sdul button if End
														if(directSdu) {%>
                                                        <li><a onclick="sdul_add2();"><img src="http://img.enuri.info/images/view/catalog/dr-btn_off.gif" onmouseover="this.src='http://img.enuri.info/images/view/catalog/dr-btn_on.gif';" onmouseout="this.src='http://img.enuri.info/images/view/catalog/dr-btn_off.gif';" alt="현재상품 Direct 등록"></a></li>
                                                        <%}%>
                                                    </ul>
                                                </div>
                                                <!-- // -->
                                                <%
                                            	}
												// EN ID 로그인 시 관리자 버튼 뷰 여부
												if(cb.GetCookie("MEM_INFO", "USER_GROUP").equals("1") || cb.GetCookie("MEM_INFO", "USER_GROUP").equals("2")){
													String tempSearchKeyword = "";
                                                    long tempMinPrice1 = (long)(lngMinPrice * 0.6);
						                            long tempMinPrice2 = (long)(lngMinPrice * 1.6);
													String tempCateLen2 = "";

													if(strCategory.length()>=2) {
														tempCateLen2 = strCategory.substring(0, 2);
													} else {
														tempCateLen2 = CutStr.cutStr(strCategory,2);
													}

													if(tempCateLen2.equals("08")) {
													    tempSearchKeyword = strFactory+" "+strModelNm;
													} else {
													    boolean addSearchFlag = true;
													    for(int wsi=0; wsi<strModelNm.length(); wsi++) {
													        if(strModelNm.charAt(wsi)=='(') addSearchFlag = false;
													        if(addSearchFlag && strModelNm.charAt(wsi)!='(' && strModelNm.charAt(wsi)!=')') tempSearchKeyword = tempSearchKeyword + strModelNm.charAt(wsi);
													        if(strModelNm.charAt(wsi)==')') addSearchFlag = true;
													    }
													}
													SearchFunction Searchfunction = new SearchFunction();
													tempSearchKeyword = Searchfunction.DelCharacterForQuery(tempSearchKeyword);
												%>
                                                <!-- EN아이디 회원 노출 -->
                                                <div class="en__member">
                                                    <ul>
                                                        <li><a href="javascript:///" onclick="openWebSearch('<%=ReplaceStr.replace(tempSearchKeyword, "'", "&#39;")%>','<%=tempCateLen2%>','<%=tempMinPrice1%>~<%=tempMinPrice2%>'); return false;">웹검색</a></li>
                                                        <li><a href="/knowcom/index.jsp" target="_blank">정보글작성</a></li>
                                                        <%	// 관리자가 로그인 할경우 뉴스를 관리할수있는 링크
														String isCompare = ConfigManager.RequestStr(request, "isCompare", "N");
                                                        if(!isCompare.equals("Y") && cb.GetCookie("MEM_INFO", "USER_GROUP").equals("1") || cb.GetCookie("MEM_INFO", "USER_GROUP").equals("2") || cb.GetCookie("MEM_INFO", "USER_GROUP").equals("6")) {
														%>
                                                        <li><a href="javascript:///" onclick="knowBoxNewsSetPopup(); return false;">뉴스관리팝업</a></li>
                                                        <%
														}
														%>
                                                    </ul>
                                                </div>
                                                <%}%>
                                                <!-- // -->

                                                <!-- 상품 이미지 -->
                                                <span class="thum__img"><img src="<%=strImageUrl%>" alt="<%=strModelNmView%>" /></span>
                                                <!-- 성인인증 이미지 -->
                                                <a href="javascript:void(0);" class="thum__adult" style="display:none;" onclick="$('#lay_adult_wrap').show();"><img src="http://img.enuri.info/images/rev/thumb_adult.png" alt="" /></a>
                                                <!-- 히트브랜드 아이콘 -->
                                                <%if(blHitbrandIconCheck) out.println("<span class=\"ico ico--hitbrand\"></span>");%>
                                                
                                                <!-- 스폰서 아이콘 
                                                <span class="ico ico--sponsor"></span>-->

                                                <button type="button" class="btn btn__dimm" onclick="$('#THUMNAILLAYER').show()"><!-- vod 일때 노출 --></button>

                                                <div class="lay-box" style="<%=(blSimiliarModelCheck) ? "" : " display:none; "   %>">
                                                    <button type="button" class="btn btn__tooltip">유사상품 비교<i class="ico ico--question"></i></button>
                                                    <!-- 툴팁 -->
                                                    <div class="lay__tooltip">
                                                        <div class="lay__inner">
                                                            <p class="tx_info">쇼핑몰 상품들 중에서 동일 상품으로 판단되는 상품들을 자동으로 모았습니다.</p>
                                                        </div>
                                                    </div>
                                                </div>
 
                                                <!-- 인증정보 -->
                                                <div class="lay-box" style="<%=(blSimiliarModelCheck) ? "left:110px; " : "" %><%=(arrayCertiList.length() > 0 || arrayaAllergyList.length() > 0) ? "" : " display:none; "   %> ">
                                                    <button type="button" class="btn btn__tooltip" onclick="$(this).siblings('.lay-mark').toggle()">
                                                        <%if(arrayCertiList.length() > 0 && arrayaAllergyList.length() > 0){%>
                                                            인증정보/알레르기정보
                                                        <%}else if(arrayCertiList.length() > 0){%>
                                                            인증정보
                                                        <%}else if(arrayaAllergyList.length() > 0){%>
                                                            알레르기정보 
                                                        <%}%>
                                                        <i class="ico ico--question"></i>
                                                    </button>

                                                    <!-- 레이어 : 인증정보 클릭시 -->
                                                    <div class="lay-mark lay-comm">
                                                        <div class="lay-comm--head">
                                                         <%if(arrayCertiList.length() > 0 && arrayaAllergyList.length() >0){%>
                                                            <strong class="lay-comm__tit">식품인증/알레르기 정보</strong>
                                                        <%}else if(arrayCertiList.length() > 0){%>
                                                            <strong class="lay-comm__tit">식품 인증정보</strong>
                                                        <%}else if(arrayaAllergyList.length() > 0){%>
                                                            <strong class="lay-comm__tit">알르레기 정보</strong>
                                                        <%}%>
                                                            
                                                        </div>
                                                        <div class="lay-comm--body">
                                                            <div class="lay-comm__inner">
                                                                <div class="markbox">
                                                                    <%if(arrayCertiList.length() > 0 && arrayaAllergyList.length() >0){%>
                                                                    <%}else if(arrayCertiList.length() > 0){%>
                                                                    <p class="tx_info"><strong>Tip.</strong> 인증마크를 클릭하면 상세 인증내용을 확인할 수 있습니다.</p>
                                                                    <%}else if(arrayaAllergyList.length() > 0){%>
                                                                        <p class="tx_info"><strong>Tip.</strong> 인증마크를 클릭하면 상세 인증내용을 확인할 수 있습니다.</p>
                                                                    <%}%>
                                                                    <%if(arrayCertiList.length() > 0){
                                                                        String html = "";
                                                                        for(int i=0;i<arrayCertiList.length();i++){
                                                                            JSONObject tmpJSONObject = arrayCertiList.getJSONObject(i);
                                                                            int intIconno = tmpJSONObject.getInt("iconno");
                                                                            int intAttribute_id = tmpJSONObject.getInt("attribute_id");
                                                                            int intAttribute_el_id = tmpJSONObject.getInt("attribute_element_id");
                                                                            int intRef_kb_no = tmpJSONObject.getInt("ref_kb_no");
                                                                            html += "<li>";
                                                                            if(intRef_kb_no > 0){
                                                                                html += "  <a href=\"javascript:void(0);\" onclick=\"showDicLayer(this);\"  data-attr_id=\""+intAttribute_id+"\" data-attr_el_id=\""+intAttribute_el_id+"\">";
                                                                            }else{
                                                                                  html += "  <a href=\"javascript:void(0);\" style=\"cursor:default;\">";
                                                                            }
                                                                            html += "   <img src=\"http://img.enuri.info/images/f_icon/"+intIconno+"_b.gif\" alt=\"\" />";
                                                                            html += "  </a>";
                                                                            html += "</li>";
                                                                        }
                                                                    %>
                                                                    <p class="tx_tit">식품 인증정보</p>
                                                                    <ul class="mark__list">
                                                                        <%out.println(html);%>
                                                                    </ul>    
                                                                    <%}%>

                                                                    <%if(arrayaAllergyList.length() > 0){
                                                                        String html = "";
                                                                        for(int i=0;i<arrayaAllergyList.length();i++){
                                                                           JSONObject tmpJSONObject = arrayaAllergyList.getJSONObject(i);
                                                                            int intIconno = tmpJSONObject.getInt("iconno");
                                                                            int intAttribute_id = tmpJSONObject.getInt("attribute_id");
                                                                            int intAttribute_el_id = tmpJSONObject.getInt("attribute_element_id");
                                                                            int intRef_kb_no = tmpJSONObject.getInt("ref_kb_no");
                                                                            html += "<li>";
                                                                            if(intRef_kb_no > 0){
                                                                                html += "  <a href=\"javascript:void(0);\" onclick=\"showDicLayer(this);\"  data-attr_id=\""+intAttribute_id+"\" data-attr_el_id=\""+intAttribute_el_id+"\">";
                                                                            }else{
                                                                                  html += "  <a href=\"javascript:void(0);\" style=\"cursor:default;\" >";
                                                                            }
                                                                            html += "   <img src=\"http://img.enuri.info/images/f_icon/"+intIconno+"_b.gif\" alt=\"\" />";
                                                                            html += "  </a>";
                                                                            html += "</li>";
                                                                        }
                                                                    %>
                                                                    <p class="tx_tit">알레르기 정보</p>
                                                                    <ul class="mark__list">
                                                                        <%out.println(html);%>
                                                                    </ul>    
                                                                    <%}%>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <!-- 버튼 : 레이어 닫기 -->
                                                        <button class="lay-comm__btn--close comm__sprite" onclick="$(this).closest('.lay-comm').hide()">레이어 닫기</button>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="thum__slide">
                                                <div class="swiper-container">
                                                    <ul class="swiper-wrapper thum__list">
                                                        <%
                                                        String thumHtml = "<li class=\"swiper-slide\"><button type=\"button\" onclick=\"insertLogLSV(24448,'"+strCategory+"','"+intModelno+"');\" class=\"btn btn--modal\"><img src=\""+strImageUrl+"\" alt=\"\" /></button></li>";
                                                        if(arrayVideoList.length() > 0){
                                                            JSONObject tmpObject = new JSONObject();
                                                            for(int i=0;i<arrayVideoList.length();i++){
                                                                tmpObject = arrayVideoList.getJSONObject(i);

                                                                String strSource = tmpObject.getString("video_url");
                                                                String strVideoThum = "";
                                                                if(strSource.indexOf("youtu.be") > 0 || strSource.indexOf("youtube") > 0){
                                                                    int srcIndex = strSource.lastIndexOf("/");
                                                                    int descIndex = 0 ;
                                                                    
                                                                    if(strSource.lastIndexOf("?list") > 0){
                                                                        descIndex = strSource.lastIndexOf("?list"); 
                                                                    } else if(strSource.lastIndexOf("?autoplay") > 0){
                                                                        descIndex = strSource.lastIndexOf("?autoplay"); 
                                                                    } else{
                                                                        descIndex = strSource.length(); 
                                                                    }
                                                                    strVideoThum = strSource.substring(srcIndex+1,descIndex);
                                                                }
                                                                if(!strVideoThum.equals("")){
                                                                    thumHtml += "<li class=\"swiper-slide has-vod\"><span class=\"dimm\"></span><button type=\"button\" class=\"btn btn--modal\" onclick=\" insertLogLSV(24448,'"+strCategory+"','"+intModelno+"')\" ><img src=\"//img.youtube.com/vi/"+strVideoThum+"/hqdefault.jpg\" alt=\"\" /></button></li>";

                                                                }
                                                            }
                                                        }
                                                        if(arrayThumNailList.length() > 0){
                                                            for(int i=0;i<arrayThumNailList.length();i++){
                                                                String strSource = arrayThumNailList.getString(i);
                                                                thumHtml += "<li class=\"swiper-slide\"><button type=\"button\" class=\"btn btn--modal\" onclick=\" insertLogLSV(24448,'"+strCategory+"','"+intModelno+"')\" ><img src=\""+strSource+"\" alt=\"\" /></button></li>" ;
                                                            }
                                                        }
                                                        out.println(thumHtml);
                                                        %>
                                                    </ul>
                                                </div>
                                                <button type="button" class="arr arr-prev">이전</button>
                                                <button type="button" class="arr arr-next">다음</button>
                                            </div>
                                        </div>

                                        <!-- 제품사양 확장시 클래스 toggle : is-expand -->
                                        <div class="proddetail__spec" <%=specList.length > 0 ? "" : "style=display:none"%> >
                                            <div class="inner">
                                                <div class="swiper-container specswipe">
                                                    <div class="swiper-wrapper">
                                                        <!-- [LOOP] -->
                                                            <%
                                                                StringBuffer specHtmlBuffer = new StringBuffer();
                                                                String strSpecHtml ="";
                                                                if(specList != null){
                                                                    String specContentView ="";
                                                                    String specTitleView = "";
                                                                    int liCnt = 0;
                                                                    int liSize = 5;
                                                                    for(int i=0; i<specList.length;){
                                                                        if(liCnt%5==0){
                                                                            specHtmlBuffer.append("<ul class=\"swiper-slide specswipe__item\">");
                                                                        }

                                                                        String specTitle = specList[i].getTitle();
                                                                        int specAttrbute_id = specList[i].getAttribute_id();
                                                                        int specAttrbute_el_id = specList[i].getAttribute_element_id();
                                                                        int specCellcnt = specList[i].getCellcnt();
                                                                        int specKbno = specList[i].getAttribute_element_kbno();
                                                                        if(specCellcnt > 1){
                                                                            int j=0;
                                                                            specTitleView = specList[i].getTitle();
                                                                            specContentView = "";
                                                                            for(j=0;j<specCellcnt;j++){
                                                                                if(j>0) specContentView +=",";
                                                                                
                                                                                specContentView += specList[i+j].getContent();
                                                                            }
                                                                            i += j;
                                                                        }else{
                                                                            specContentView = specList[i].getContent();
                                                                            specTitleView = specList[i].getTitle();
                                                                            i++;
                                                                        }
                                                                        specHtmlBuffer.append(" <li>");
                                                                        specHtmlBuffer.append("     <span class=\"tx_spec\">"+specTitleView+"</span>");
                                                                        specHtmlBuffer.append("     <span class=\"tx_detail\">"+specContentView+"</span>");
                                                                        specHtmlBuffer.append(" </li>");
                                                                        liCnt++;
                                                                        if(liCnt%5==0){
                                                                            specHtmlBuffer.append("</ul>");
                                                                        }
                                                                    }
                                                                    out.println(specHtmlBuffer.toString());
                                                                }
                                                            %>
                                                    </div>
                                                    <div class="swiper-pagination swiper-pagination-hidden"></div>
                                                </div>
                                                    <!-- 좌/우 ARROW -->
                                                <div class="arrows arrows--rect">
                                                    <div class="arrows__inner">
                                                        <button type="button" class="arr arr-prev">이전</button>
                                                        <button type="button" class="arr arr-next">다음</button>
                                                    </div>
                                                </div>
                                                <a class="btn btn__more" onclick="insertLogLSV(24449,'<%=strCategory%>','<%=intModelno%>');" style="display:none;">더보기</a>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- // -->

                                    <!-- 상품 가격비교 정보 -->
                                    <div class="prodpricecomp">
                                        <!-- 상품 가격비교 상단 -->
                                        <div class="pricecomp__head" id="prod_summary_top">
                                            <!-- 상품명&스펙&기능 -->
                                            <div class="prodinfo">
                                                <h1 class="prodinfo__tit"><%=strModelNmViewTag%></h1>
                                                <ul class="prodinfo__spec">
                                                    <%if(!strFactory.equals("") && blFactory) {%><li>제조사: <%=strFactory%></li><%}%>
                                                    <%if(!strBrand.equals("") && blBrand) {%><li>브랜드: <%=strBrand%></li><%}%>
                                                    <%if(!strCdateView.equals("")) {%><li><%=strCdateView%></li><%}%>
                                                </ul>
                                                
                                            </div>
                                            <!-- // -->

                                            <!-- 상품 최저가 -->
                                            <div class="prodminprice" <%=(intMallCnt > 0 && !strCdateView.equals("출시예정") ? "" : "style=\"display:none;\"")%> >
                                                <div class="box__minprice">
                                                    <p class="box__line1">
                                                        <!-- <span class="tx_msg">TLC카드가</span>-->
                                                        <%if(strOvsMinYn.equals("Y")){%>
                                                        <span class="tx_msg">직구 최저가</span>
                                                        <%}else if(blCashShopOnly) {%>
                                                        <span class="tx_msg">현금 최저가</span>
                                                        <%} else {%>
                                                        <span class="tx_msg">최저가</span>
                                                        <%}%>
                                                        <span class="tx_delivery"><%=strMinDeliveryTextView%></span>
                                                    </p>
                                                    <p class="box__line2">
                                                        <span class="tx_price"><em><%=strMinPriceView%></em>원</span>
                                                        <%if(!strRelease_price.equals("")){%><s class="tx_cost"><%=strRelease_price%>원</s><%}%>
                                                    </p>
                                                    <div class="btn__prod">
                                                        <button type="button" class="btn__alarm" onclick="minPriceAlarmInfo();insertLogLSV(14464,'<%=strCategory%>','<%=intModelno%>');">가격 알림</button>
                                                        <div class="lay-tooltip" style="display:block">
                                                            <div class="lay__inner">
                                                                <p class="tx_msg"><em>TIP</em><strong>원하는 가격이 되었을 때 알려드립니다.</strong></p>
                                                            </div>
                                                        </div>
                                                        <a href="javascript:void(0);" class="btn__purchase" target="_blank"><span class="txt">최저가 구매하기</span></a>
                                                    </div>
                                                </div>
                                                <%if(lngMinPrice > lngMinPrice3 && lngPlMinInstancePrice > 0){%>
                                                <div class="mobile__buy">
                                                    <button type="button" class="btn" onclick="$(this).siblings('.lay-mobile-min').toggle()">
                                                        <span class="tx_logo"><img src="//img.enuri.info/images/home/malllogo/<%=plMobileMinShopCode%>_m.jpg" alt="<%=plMobileMinShopName%>" onerror="$(this).replaceWith('<%=plMobileMinShopName%>')" /></span>
                                                        <span class="tx_msg">모바일에서 구매하면<span class="tx_price"><em><%=FmtStr.moneyFormat(String.valueOf(lngPlMinInstancePrice))%></em>원</span></span>
                                                    </button>

                                                    <!-- 레이어 : 모바일특가 -->
                                                    <div id="mobile_min_layer" class="lay-mobile-min lay-comm">
                                                        <div class="lay-comm--head">
                                                            <strong class="lay-comm__tit">모바일에서 구매 시 더 저렴합니다.</strong>
                                                        </div>
                                                        <div class="lay-comm--body">
                                                            <div class="lay-comm--inner">
                                                                <div class="ph--qr">
                                                                    <img src="//img.enuri.info/images/rev/qr_loader.gif" alt="">
                                                                </div>
                                                                <div class="lay-mobile__qr">
                                                                    <img src="//img.enuri.info/images/home/@qr.gif" alt="">
                                                                </div>
                                                                <div class="lay-mobile__cont">
                                                                    <p class="tx_price"><em><%=FmtStr.moneyFormat(String.valueOf(lngPlMinInstancePrice))%></em>원</p>
                                                                    <div class="lay-mobile__tx">
                                                                        핸드폰 전송 또는 QR 코드를 스캔하시거나, <br>
                                                                        에누리앱을 통해 구매해 주세요!
                                                                    </div>
                                                                    <div class="lay-mobile__btn">
                                                                        <button class="btn-mobile--zzim <%=(blZzim) ? "is--on":"" %>" >찜</button>
                                                                        <button class="btn-mobile--sendsms" onclick="$(this).closest('.lay-comm').find('.lay-mobile-sendsms').toggle();">핸드폰 전송</button>
                                                                        <button class="btn-mobile--app">에누리앱 설치</button>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="lay-mobile-sendsms" style="display:none">
                                                                <div class="sendsms__form">
                                                                    <fieldset>
                                                                        <legend>SMS보내기</legend>
                                                                        <input type="text" class="sendsms__form--inp" placeholder="- 없이 입력하세요">
                                                                        <button class="sendsms__form--btn">전송</button>
                                                                    </fieldset>
                                                                </div>
                                                                <span class="sendsms__send-url--tx">- 상품 상세 주소를 무료문자로 발송해드립니다.</span>
                                                                <span class="sendsms__send-url--tx">- 입력하신 번호는 저장되지 않습니다.</span>
                                                            </div>
                                                        </div>
                                                        <!-- 버튼 : 레이어 닫기 -->
                                                        <button class="lay-comm__btn--close comm__sprite" onclick="$(this).parent().hide()">레이어 닫기</button>
                                                    </div>
                                                </div>
                                                <%}%>
                                            </div>
                                            <!-- // -->
                                        </div>
                                        <!-- // -->

                                        <!-- 상품 가격비교 하단 -->
                                        <div class="pricecomp__cont" <%=(intMallCnt > 0) ? "" : "style=\"display:none\"" %>>
                                            <!-- 구매옵션, 프로모션/특별가 -->
                                            <div class="prodoption" id="prod_option_top" style="display:none">
                                                <div class="buyoption"></div>
                                            </div>
                                            <!-- // -->
                                            <!-- 프로모션/특별가 -->
                                            <div class="specialprice" id="special_price" style="display:none">
                                                <ul class="s_price__list"></ul>
                                            </div>
                                            <!-- // -->

                                             <!-- 쇼핑몰별 최저가 -->
                                            <div class="prodmallprice" id="prod_shopprice" style="display:none">
                                                <div class="m_price__head"> 
                                                    <h3 class="m_price__tit">쇼핑몰별 최저가</h3>

                                                    <ul class="m_price__toggle">
                                                        <li>
                                                            <p class="toggle__chk is-off card">
                                                                <span class="switch"><span class="btn"><em>on/off</em></span><strong>카드할인가 포함</strong></span>
                                                            </p>
                                                        </li>
                                                        <li>
                                                            <p class="toggle__chk is-off delivery">
                                                                <span class="switch"><span class="btn"><em>on/off</em></span><strong>배송비 포함</strong></span>
                                                            </p>
                                                            <div class="lay-tooltip">
                                                                <div class="lay__inner">
                                                                    <p class="tx_msg"><em>TIP</em><strong>배송비를 포함한 가격</strong>으로 최저가 쇼핑몰을 비교합니다.</p>
                                                                </div>
                                                            </div>
                                                        </li>
                                                    </ul>
                                                </div>
                                                <ul class="m_price__list"></ul>
                                            </div>
                                            <!-- // -->

                                        </div>
                                        <!-- 예외 -->
                                        <div id="prod_top_left_except" class="prod--exception" <%=(intMallCnt > 0 && !strCdateView.equals("출시예정") ? "style=\"display:none;\"" : "")%> >
                                            <div class="except_box">
                                            <%if(strCdateView.equals("출시예정")) {%>
                                                 <p class="tx_exception"><strong>출시예정</strong> 상품입니다.</p>
                                            <%}else if (intMallCnt==0) {%>
                                                <p class="tx_exception"><strong>일시품절</strong> 상품입니다.</p>
                                            <%}%>
                                            <button type="button" class="btn btn--black btn--alarm" onclick="minPriceAlarmInfo();insertLogLSV(24632,'<%=strCategory%>','<%=intModelno%>');">가격 알림 설정</button>
                                            </div>
                                        </div>
                                        <!-- // -->
                                    </div>
                                </div>
                            </div>
                            <!-- 좌 -->

                            <!-- 우 -->
                            <div id="prod_summary_right" class="prodsummary__right">
                                <div class="inner">
                                    <!-- 예외 -->
                                    <div id="prod_top_right_except" class="prod--exception" <%=(strCdateView.equals("출시예정") ? "" : "style=\"display:none;\"")%> >
                                        <div class="tx_box">
                                            <p class="tx_exception">출시예정 상품으로<br>판매중인 쇼핑몰이 없습니다.<br><strong></strong>상품설명, 블로그/동영상 리뷰,<br>추천상품</strong> 컨텐츠를 즐겨보세요.</p>
                                        </div>
                                    </div>

                                    <!-- 상품평 목록 -->
                                    <div class="prodreview" id="prod_bbs_top" <%=(strCdateView.equals("출시예정") ? "style=\"display:none;\"" : "")%>  >
                                        <div class="preview__head">
                                            <p class="preview__tit">상품평(<span><%=strBbsNumView%></span>건)</p>
                                            <%if(intBbsNum > 3) { %>
                                                <a href="javascript:void(0);" class="btn btn__more">더보기</a>
                                            <%}%>
                                            <!-- 0점일 때, is-active 삭제 -->
                                            <div class="preview__grade is-active"><i class="ico ico--star"></i> <em><%=String.format("%.1f", flBbsPointAvg)%></em>점</div>
                                        </div>

                                        <div class="preview__cont">
                                            <ul class="preview__list">
                                                <li class="no-data" style="display:none;">
                                                    <p class="tx_msg">등록된 상품평이 없습니다.<br>상품평을 등록해주세요!</p>
                                                    <a href="javascript:void(0)" class="btn btn__write" onclick=" $('html,body').stop(true,false).animate({'scrollTop': $('#prodReview').offset().top - 150},500);"><span>상품평 쓰기</span></a> 
                                                </li>
                                                 <li class="no-adult" style="display:none;">
                                                    <p class="tx_msg">상품 이미지를 확인하기 위해서는<br>성인인증이 필요합니다.</p>
                                                    <a href="javascript:void(0);" class="btn btn__certificate" onclick="$('#lay_adult_wrap').show();"><span>성인인증</span></a> 
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                    <!-- //상품평 목록 -->

                                    <!-- 가격추세 -->
                                    <div class="prodgraph" id="prod_graph" <%=(strCdateView.equals("출시예정") ? "style=\"display:none;\"" : "")%>  >
                                        <div class="pgraph__head">
                                            <p class="pgraph__tit">가격추세</p>

                                            <ul class="pgraph__filter" style="display:none;">
                                                <li><input type="radio" id="radioGRAPH_01" name="radioGRAPH1" class="input--radio-item" value="1"><label for="radioGRAPH_01">1개월</label></li>
                                                <li><input type="radio" id="radioGRAPH_02" name="radioGRAPH1" class="input--radio-item" value="3" checked="checked"><label for="radioGRAPH_02">3개월</label></li>
                                                <li><input type="radio" id="radioGRAPH_03" name="radioGRAPH1" class="input--radio-item" value="6"><label for="radioGRAPH_03">6개월</label></li>
                                            </ul>
                                        </div>

                                        <div class="pgraph__cont">
                                            <div class="monthpraph" id="vip_graph_container"></div>
                                        </div>
                                    </div>
                                    <!-- //가격추세 -->
                                    <div class="prodexparts" id="prod_consumable" style="display:none;"></div>
                                </div>
                            </div>
                            <!-- 우 -->
                        </div>
                        <!-- //[상단] 상품 가격비교 요약 -->

                        <!-- [CM등록컨텐츠] 관련상품 : 이미지  .is-thum 추가 -->
                        <div id="caution1" class="row__prodrelated" style="display:none;"></div>
                        <!-- //[CM등록컨텐츠] 관련상품 : 이미지 -->

                        <!-- [화장품 전성분] -->
                        <div id="cosComponent" class="row__cosmetic" style="display:none;">
                            <div class="inner">
                                <table class="tb__cosmetic">
                                    <colgroup>
                                        <col width="25%" />
                                        <col width="25%" />
                                        <col width="25%" />
                                        <col width="25%" />
                                    </colgroup>
                                    <thead>
                                        <tr>
                                            <th>피부타입별 적합도 <button type="button" class="ico ico--question">?</button>
                                                <div class="lay-tooltip lay-comm lay-comm--sm">
                                                    <div class="lay-comm--head">
                                                        <strong class="lay-comm__tit">피부타입별 적합도</strong>
                                                    </div>
                                                    <div class="lay-comm--body">
                                                        <div class="lay-comm__inner">
                                                            <strong>%가 높을 수록 해당 피부타입에 적합한 제품</strong>이며, 적합도는 전성분의 특성을 분석하여 산출된 값입니다.
                                                        </div>
                                                    </div>
                                                </div>
                                            </th>
                                            <th>좋은성분</th>
                                            <th>주의성분</th>
                                            <th>전성분</th>
                                        </tr>
                                    </thead>
                                    <tbody>

                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <!-- //[화장품 전성분] -->

                        <!-- [핸드폰 분류/속성] : SRP 마크업 동일 -->
                        <div id="mobileType" class="srp-type--c" style="display:none;">
                            <ul class="srp-type__list"></ul>
                        </div>
                        <!-- //[핸드폰 분류/속성] -->

                        <!-- [가구 카테고리] -->
                        <div id="furniture" class="row__fungrade" style="display:none;">
                            <div class="inner"></div>
                        </div>
                        <!-- //[가구 카테고리] -->

                        <!-- [AD] 1280 광고배너 -->
                        <div id="midBanner" class="mid__bnr__band" style="background-color:#d2d5c4; display:none;" >
                        </div>
                        <!-- // -->

                        <!-- [인터파크특가상품] -->
                        <div class="row__interpark" style="display:none;">
                            <ul class="interpark__list">
                                <li class="interpark__item">
                                    <div class="col col-1">
                                    </div>
                                    <div class="col col-2">
                                        <a href="#" class="tx_link"></a>

                                        <div class="btn__group">
                                            <ul class="btn__list">
                                                <li><button type="button" class="btn">이벤트 바로가기</button></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="col col-3">
                                        <div class="box--price">
                                            <div class="box--price-line">
                                                <span class="box--price-lt">
                                                    <strong class="tx_info"></strong>
                                                    <span class="tx_saleprice">(판매가 1,120,000원)</span>
                                                </span>

                                                <a href="#" class="box--price-rt tx_price"><em>3,395,590</em>원</a>
                                            </div>
                                            <a href="#" class="btn btn__coupon"><i class="ico ico--coupon"></i> <span>쿠폰받기</span></a>
                                        </div>

                                    </div>
                                </li>
                            </ul>
                        </div>
                        <!-- //[인터파크특가상품] -->

                        <!-- 탭 컨테이너 섹션 -->
                        <div class="container__section">
                            <!-- 탭 영역 -->
                            <div class="prodtabbox" id="prod_topfix">
                                <!-- 상단고정 상품정보 -->
                                <div class="prodtabinfo">
                                    <div class="inner">
                                        <div class="prodtabinfo__lt">
                                            <div class="prod__thum"><img src="<%=strImageUrl%>" alt="<%=strModelNmView%>" /></div>

                                            <p class="prod__name"><%=strModelNmView%></p>

                                            <div class="prod__select" style="display:none;">
                                                <div class="select-box--basic">
                                                    <div class="select-box--selected"><span id="changeOpt"><%=strCondiNm%></span><i class="ico-arr-select-box lp__sprite"></i></div>
                                                    <ul class="select-box__list"></ul>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="prodtabinfo__rt">
                                            <div class="box__minprice" <%=(intMallCnt > 0 && !strCdateView.equals("출시예정") ? "" : "style=\"display:none;\"")%>>
                                                <p class="box__line1">
                                                    <span class="tx_delivery"><%=strMinDeliveryTextView%></span>
                                                </p>
                                                <p class="box__line2">
                                                    <span class="tx_price is-min">
                                                    <%if(strOvsMinYn.equals("Y")){%>
                                                    <span class="tx_msg">직구 최저가</span>
                                                    <%}else if(blCashShopOnly) {%>
                                                    <span class="tx_msg">현금 최저가</span>
                                                    <%} else {%>
                                                    <span class="tx_msg">최저가</span>
                                                    <%}%>
                                                    <em id="detail_minprice"><%=strMinPriceView%></em>원</span>
                                                </p>
                                                <div class="btn__prod">
                                                    <button type="button" class="btn__alarm" onclick="minPriceAlarmInfo();insertLogLSV(14464,'<%=strCategory%>','<%=intModelno%>');">가격 알림</button>
                                                    <div class="lay-tooltip">
                                                        <div class="lay__inner">
                                                            <p class="tx_msg"><em>TIP</em><strong>원하는 가격이 되었을 때 알림</strong>을 받을 수 있습니다.</p>
                                                        </div>
                                                    </div>
                                                    <a href="javascript:void(0);" class="btn__purchase" target="_blank"><span class="txt">최저가 구매하기</span></a>
                                                </div>
                                            </div>
                                            <div class="box__exception" <%=(intMallCnt > 0 && !strCdateView.equals("출시예정") ? "style=\"display:none;\"" : "")%>>
                                                <%if(strCdateView.equals("출시예정")) {%>
                                                    <p class="tx_exception" ><em>출시예정</em> 상품입니다.</p>
                                                <%}else if (intMallCnt==0) {%>
                                                    <p class="tx_exception"><em>일시품절</em> 상품입니다.</p>
                                                <%}%>
                                            </div>
                                        </div>

                                    </div>
                                </div>

                                <!-- [상품정보 탭 목록] : 고정시 is-fixed 추가 -->
                                <div class="prodtab">
                                    <ul class="prodtab__list">
                                        <li class="prodtab__item is-on" id="tabPrice" >
                                            <a href="#prodComparison" class="tab__link" onclick="insertLogLSV(14450,'<%=strCategory%>','<%=intModelno%>');">가격비교 <em>(<%=strMallCntView%>)</em></a>
                                        </li>
                                        <li class="prodtab__item" id="tabDesc">
                                            <a href="#prodDetail" class="tab__link" onclick="insertLogLSV(14451,'<%=strCategory%>','<%=intModelno%>');">상품설명</a>
                                        </li>
                                        <li class="prodtab__item compspec" id="tabSpec" style="display:none;">
                                            <a href="#prodSpecComparison" class="tab__link">스펙비교</a>
                                        </li>
                                        <li class="prodtab__item" id="tabBbs" onclick="insertLogLSV(14452,'<%=strCategory%>','<%=intModelno%>');">
                                            <%if(intBbsNum > 0) {%>
                                                <a href="#prodReview" class="tab__link">상품평 <em>(<%=strBbsNumView%>)</em></a>
                                            <%}else {%>
                                                <a href="#prodReview" class="tab__link">상품평 <em></em></a>
                                            <%}%>
                                        </li>
                                        <li class="prodtab__item" id="tabQna">
                                            <a href="#prodQnA" class="tab__link">CM Q&A <em></em></a>
                                        </li>
                                        <li class="prodtab__item" id="tabReview" onclick="insertLogLSV(14453,'<%=strCategory%>','<%=intModelno%>');">
                                            <a href="#prodBlogReview" class="tab__link">블로그/동영상 리뷰</a>
                                        </li>
                                        <li class="prodtab__item" id="tabRecomm" onclick="insertLogLSV(14454,'<%=strCategory%>','<%=intModelno%>');">
                                            <a href="#prodRecommend" class="tab__link">추천상품</a>
                                        </li>
                                    </ul>
                                </div>
                                <!-- //[상품정보 탭] -->
                            </div>

                            <!-- 구매유의사항 -->
                            <div class="row__section row__alertbox">
                                <div class="inner">
                                    <p class="tx_tit">쇼핑몰에서 정확한 가격과 상품정보를 꼭 다시 확인 하시고 구매하세요!</p>
                                    <p class="tx_sub">"에누리"와 쇼핑몰의 상품정보, 가격이 일치하지 않을 수 있습니다. 쇼핑몰 이동 후 반드시 상품정보 및 가격을 다시 한번 확인하세요. <a href="/etc/disclaimer.jsp" target="_blank">(법적고지 보기)</a><br>
                                        "에누리"를 운영하는 (주)써머스플랫폼은 통신판매 정보제공자로 상품의 주문/배송/환불에 대한 의무와 책임은 각 쇼핑몰(판매자)에게 있습니다.</p>
                                </div>
                            </div>
                            <!-- //구매유의사항 -->
                            <div class="row__section row__pricereset">
                                <p class="tx_date_reset">가격 갱신일 : <%=sdf3.format(dtNowTime)%></p>
                            </div>
                            <!-- [CM등록컨텐츠] 관련상품  -->
                            <div class="row__section row__prodrelated" style="display:none;">
                            </div>
                            <!-- //[CM등록컨텐츠] 관련상품 -->

                            <!-- [탭 - 가격비교] -->
                            <div id="prodComparison" class="row__section tab__scroll">
                                <div class="section__inner">
                                    <div class="section__head">
                                        <h2 class="section__tit">가격비교</h2>
                                    </div>

                                    <div class="section__cont">
                                        <div class="pricecomp" id="prod_option" style="display:none;"></div>
                                        <!-- 파워클릭 -->
                                        <div id="prodPowerClick" class="ad__powerclick" style="display:none;">
                                            <div class="powerclick">
                                                <div class="powerclick__head">
                                                    <p class="tx_tit">파워클릭 <i class="ico ico--ad">AD</i></p>
                                                    <p class="tx_sub">판매자 상황에 따라 가격이 일치하지 않을 수 있습니다.</p>

                                                    <a href="https://ad.esmplus.com/Member/SignIn/LogOn?ReturnUrl=%2f" target="_blank" class="btn btn__adjoin">광고신청</a>
                                                </div>
                                            </div>
                                            <div class="powerclick__cont">
                                                <div class="inner">
                                                    <ul id="prodPowerClickList" class="powerclick__list" style="display:none;"></ul>
                                                    <ul id="prodSponsorPowerClick" class="powerclick__list is-sponsor" style="display:none;"></ul>
                                                </div>
                                            </div>
                                        </div>
                                        <div id="prod_comp_except" class="row__section prod--exception" <%=(intMallCnt > 0 && !strCdateView.equals("출시예정") ? "style=\"display:none;\"" : "")%>>
                                            <div class="tx_box">
                                            <%if(strCdateView.equals("출시예정")){ %>
                                                <p class="tx_tit">출시예정</p>
                                                <p class="tx_exception">출시예정 상품으로 아직 판매중인 쇼핑몰이 없습니다.<br><strong>상품설명, 블로그/동영상 리뷰, 추천상품</strong><br> 컨텐츠를 즐겨보세요.</p>
                                            <%} else if (intMallCnt==0) { %>
                                                <p class="tx_tit">일시품절</p>
                                                <p class="tx_exception">일시 품절 또는 단종되어 판매중인 쇼핑몰이 없습니다.<br><strong>상품설명, 블로그/동영상 리뷰, 추천상품</strong><br> 컨텐츠를 즐겨보세요.</p>
                                            <%}%>
                                            </div>
                                        </div>
                                        <div class="prodcomparison" style="" id="prod_pricecomp" <%=(intMallCnt > 0 && !strCdateView.equals("출시예정") ? "" : "style=\"display:none;\"")%>>
                                            <div class="comparison__head" style="display:none;">
                                                <!-- 스펙별 정렬 -->
                                                <ul class="comparison__sort">
                                                    <li class="is-on" data-sort="price"><button type="button" class="btn">판매가순</button></li>
                                                    <li data-sort="delivery"><button type="button" class="btn">배송비 포함순</button></li>
                                                    <li data-sort="card"><button type="button" class="btn">카드할인가순</button></li>
                                                </ul>

                                                <ul class="comparison__select">
                                                    <!-- 레이어 노출 : li class="is-on" -->
                                                    <li id="kr_shoplist">
                                                        <p class="mall__select"><button type="button" class="btn btn__sel">국내쇼핑몰 선택</button></p>

                                                        <div class="lay-mallsel lay-comm">
                                                            <div class="lay-comm--head">
                                                                <strong class="lay-comm__tit">쇼핑몰 선택하기</strong>
                                                            </div>
                                                            <div class="lay-comm--body">
                                                                <div class="lay-comm--inner">
                                                                    <ul class="lay-mall__list"></ul>
                                                                    <div class="btn__group">
                                                                        <button type="button" class="btn btn__cancel" onclick="$(this).closest('.lay-mallsel').hide()">취소</button>
                                                                        <button type="button" class="btn btn__apply" onclick="$(this).closest('.lay-mallsel').hide()">완료</button>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <!-- 버튼 : 레이어 닫기 -->
                                                            <button class="lay-comm__btn--close comm__sprite" onclick="$(this).closest('.lay-mallsel').hide()">레이어 닫기</button>
                                                        </div>
                                                    </li>
                                                    <li  id="ovs_shoplist">
                                                        <p class="mall__select"><button type="button" class="btn btn__sel">해외쇼핑몰 선택</button></p>

                                                        <div class="lay_tooltip" onmouseleave="$(this).fadeOut(300);">
                                                            <div class="lay_inner">
                                                                <em>해외직구</em> 쇼핑몰만 선별하여 볼 수 있습니다.
                                                            </div>
                                                        </div>

                                                        <div class="lay-mallsel lay-comm">
                                                            <div class="lay-comm--head">
                                                                <strong class="lay-comm__tit">쇼핑몰 선택하기</strong>
                                                            </div>
                                                            <div class="lay-comm--body">
                                                                <div class="lay-comm--inner">
                                                                    <ul class="lay-mall__list"></ul>

                                                                    <div class="btn__group">
                                                                        <button type="button" class="btn btn__cancel" onclick="$(this).closest('.lay-mallsel').hide()">취소</button>
                                                                        <button type="button" class="btn btn__apply" onclick="$(this).closest('.lay-mallsel').hide()">완료</button>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <!-- 버튼 : 레이어 닫기 -->
                                                            <button class="lay-comm__btn--close comm__sprite" onclick="$(this).closest('.lay-mallsel').hide()">레이어 닫기</button>
                                                        </div>
                                                    </li>
                                                </ul>
                                            </div>

                                            <div class="comparison__cont" style="display:none;">
                                                <div class="comparison__lt">
                                                    <div class="head__box"></div>
                                                    <div class="head__opt">
                                                        <p class="toggle__chk is-off">
                                                            <span class="switch"><span class="btn"><em>on/off</em></span><strong>카드할인가 포함</strong></span>
                                                        </p>
                                                    </div>
                                                    <div class="cont__box">
                                                        <ul class="comprod__list">
                                                        </ul>
                                                        <button class="adv-search__btn--more" style="display:none;">더보기<i class="ico-adv-arr-down lp__sprite"></i></button>
                                                        <button class="adv-search__btn--close" style="display:none;">닫기<i class="ico-adv-arr-up lp__sprite"></i></button>
                                                    </div>
                                                </div>

                                                <div class="comparison__rt">
                                                    <div class="head__box">
                                                        <h3 class="head__tit">일반쇼핑몰</h3>
                                                    </div>
                                                    <div class="head__opt">
                                                        <p class="toggle__chk is-off">
                                                            <span class="switch"><span class="btn"><em>on/off</em></span><strong>카드할인가 포함</strong></span>
                                                        </p>
                                                    </div>
                                                    <div class="cont__box">
                                                        <ul class="comprod__list">
                                                        </ul>
                                                        <button class="adv-search__btn--more" style="display:none;">더보기<i class="ico-adv-arr-down lp__sprite"></i></button>
                                                        <button class="adv-search__btn--close" style="display:none;">닫기<i class="ico-adv-arr-up lp__sprite"></i></button>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- //가격비교 티어 CASE(가변) -->

                                            <!-- 현금몰(고정) -->
                                            <div class="cashmall__cont" style="display:none;">
                                                <div class="head__box">
                                                    <h3 class="head__tit">일반전문 <button type="button" class="btn btn__question" onclick="$(this).parent('.head__tit').siblings('.lay-cashmall').toggle()">?</button></h3>
                                                    <div class="lay-cashmall lay-tooltip lay-comm" style="display: none;">
                                                    <div class="lay-comm--head">
                                                        <strong class="lay-comm__tit">일반 전문몰</strong>
                                                    </div>
                                                    <div class="lay-comm--body">
                                                        <div class="lay-comm__inner">
                                                            무통장 입금을 이용한 현금 결제 쇼핑몰입니다.<br>
                                                            구매하기 전 재고 및 가격 확인을 꼭 해주세요.
                                                        </div>
                                                    </div>
                                                    <button class="lay-comm__btn--close comm__sprite" onclick="$(this).closest('.lay-comm').hide()">레이어 닫기</button>
                                                </div>
                                                </div>
                                                <div class="cashmall__ct">
                                                    <ul class="cashmall__list"></ul>
                                                </div>

                                                <button class="adv-search__btn--more" style="display:none;">더보기<i class="ico-adv-arr-down lp__sprite"></i></button>
                                                <button class="adv-search__btn--close" style="display:none;">닫기<i class="ico-adv-arr-up lp__sprite"></i></button>
                                            </div>
                                            <!-- //현금몰(고정) -->

                                            <!-- 유사상품 -->
                                            <div class="similar__cont" style="display:none;">
                                                <ul class="similar__list">
                                                </ul>
                                                <button class="adv-search__btn--more" style="display:none;">더보기<i class="ico-adv-arr-down lp__sprite"></i></button>
                                                <button class="adv-search__btn--close" style="display:none;">닫기<i class="ico-adv-arr-up lp__sprite"></i></button>
                                            </div>
                                            <!-- //유사상품 -->

                                            <!-- [VIP] AD 파워링크 -->
                                            <!-- 개편전 마크업과 동일 -->
                                            <!-- .lp-ad--powerlink 클래스만 추가 -->
                                            <div class="comm_ad ad_powerlink lp-ad--powerlink" style="display:none;">
                                                <div class="comm_ad_tit">
                                                    <em>파워링크</em>
                                                    <a href="https://saedu.naver.com/adbiz/searchad/intro.nhn" target="_blank" class="comm_btn_apply">신청하기</a>
                                                </div>

                                                <!-- 광고 1개  x 최대 3개 노출 -->
                                                <div class="comm_ad_list ad_link">
                                                    <ul>
                                                    </ul>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- //[탭 - 가격비교] -->

                            
                            <!-- // -->

                            <!-- 예외 : 모바일에서 구매가능한상품 -->
                            <div class="row__section prod--exception" style="display:none">
                                <div class="tx_box">
                                    <p class="tx_tit">모바일에서 구매 가능한 상품입니다.</p>
                                    <p class="tx_exception">지금 바로 <em>"모바일 찜하기"</em> 후 가격비교 해 보세요.</p>

                                    <div class="btn__group">
                                        <ul class="btn__list">
                                            <li><a href="#" class="btn btn--black">모바일 찜하기</a></li>
                                            <li><a href="#" class="btn">앱 설치하기</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <!-- // -->

                            <!-- 예외 : 성인인증 케이스 : is-adult -->
                            <div class="row__section prod--exception is-adult" style="display:none;">
                                <div class="tx_box">
                                    <p class="tx_exception">본 건텐츠는 청소년 유해 매체물로서 정보통신망 이용 및<br>정보보호 등에 관한 법률, 청소년 보호법 규정에 의하여<br>19세 미만의 청소년이 이용할 수 없습니다.</p>

                                    <div class="btn__group">
                                        <ul class="btn__list">
                                            <li><a href="javscript:void(0);" class="btn btn--black" onclick="$('#lay_adult_wrap').show();">성인인증 후 사진보기</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <!-- // -->

                            <!-- [탭 - 상품설명] -->
                            <div id="prodDetail" class="row__section tab__scroll">
                                <div class="section__inner">
                                    <div class="section__head">
                                        <h2 class="section__tit">상품설명</h2>
                                    </div>

                                    <div class="section__cont">
                                        <div class="row__prodrelated is-thum"></div>

                                        <div class="spectable">
                                            <dl id="enuri_spec_table" class="spectable__list"></dl>
                                            <dl id="enuri_kc_info" class="spectable__list"></dl>
                                        </div>

                                        <div class="specdetail">
                                            <div class="sd__tabs">
                                                <ul class="tab__list">
                                                    <li id="opt_ecatal_out" style="display:none"><a href="javascript:void(0);" class="btn btn--tab" onclick="insertLogLSV(14520,'<%=strCategory%>','<%=intModelno%>');">제조사 제공</a></li>
                                                    <li id="opt_enuri_desc" style="display:none"><a href="javascript:void(0);" class="btn btn--tab"onclick="insertLogLSV(14522,'<%=strCategory%>','<%=intModelno%>');">에누리 상세정보</a></li>
                                                    <li id="opt_mall_desc" style="display:none"><a href="javascript:void(0);" class="btn btn--tab" onclick="insertLogLSV(14521,'<%=strCategory%>','<%=intModelno%>');">쇼핑몰 제공</a></li>
                                                </ul>
                                            </div>

                                            <div class="sd__container">
                                                <div class="sd__cont"></div>
                                            </div>

                                            <div class="btn__group">
                                                <!-- 확장 -->
                                                <button class="btn btn__unfold">상세정보 더보기</button>
                                                <!-- 닫기 -->
                                                <button class="btn btn__fold">상세정보 닫기</button>
                                            </div>
                                        </div>
                                        <!-- -->
                                    </div>
                                </div>
                            </div>
                            <!-- //[탭 - 상품설명] -->

                            <!-- [탭 - 스펙비교] -->
                            <div id="prodSpecComparison" class="row__section tab__scroll" style="display:none;">
                                <div class="section__inner">
                                    <div class="section__head">
                                        <h2 class="section__tit">스펙비교</h2>
                                        <p class="section__sub">인기 상품의 주요 스펙을 한 번에 비교해 보세요.</p>
                                    </div>

                                    <div class="section__cont">
                                        <!-- 스펙비교 -->
                                        <div class="speccomp">
                                            <div class="speccomp__head">
                                            <ul class="speccomp__sort">
                                                    <li class="is-on" data-type="S"><button type="button" class="btn"></button></li>
                                                    <li data-type="B"><button type="button" class="btn"></button></li>
                                                    <li data-type="D"><button type="button" class="btn"></button></li>
                                                </ul>

                                                <!-- 스펙 내 상품별 정렬 -->
                                                <ul class="speccomp__insort">
                                                    <li class="is-on" data-arr="total"><button type="button" class="btn">인기상품</button></li>
                                                        <li data-arr="sim"><button type="button" class="btn">비슷한 가격대</button></li>
                                                        <li data-arr="new"><button type="button" class="btn">신상품</button></li>
                                                </ul>
                                            </div>
                                            <div class="speccomp__cont">
                                                <div class="speccomp__list">
                                                    <!-- 스펙비교 항목 -->
                                                    <div class="comp_item">
                                                        <table class="tb_compspec">
                                                            <tbody></tbody>
                                                        </table>
                                                    </div>
                                                    <!-- 선택상품 -->
                                                    <div class="comp_origin">
                                                        <table class="tb_compspec">
                                                            <tbody></tbody>
                                                        </table>
                                                    </div>
                                                    <!-- 비교상품 리스트 -->
                                                    <div class="comp_prod">
                                                        <button class="btn_comp btn_comp_prev">이전</button>
                                                        <button class="btn_comp btn_comp_next">다음</button>
                                                        <ul class="comp_prod_list"></ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- //스펙비교 -->
                                    </div>
                                </div>
                            </div>
                            <!-- //[탭 - 스펙비교] -->

                            <!-- [탭 - 상품평] -->
                            <div id="prodReview" class="row__section tab__scroll">
                                <div class="section__inner">
                                    <div class="section__head">
                                        <h2 class="section__tit">상품평</h2>
                                    </div>

                                    <div class="section__cont">
                                        <!-- 사용자별점&평점 -->
                                        <div class="userpoint" id="prod_bbs_chart">
                                            <div class="col userscope">
                                                <p class="col__tit">사용자 평점</p>

                                                <p class="tx_score"><strong>0</strong> / 5</p>

                                                <div class="prodscope">
                                                    <i class="ico ico--scope">
                                                        <span class="ico--scope-active"></span>
                                                    </i>
                                                </div>
                                            </div>
                                            <div class="col useraval">
                                                <p class="col__tit">평점비율</p>

                                                <div class="prodgraph--stick">
                                                    <ul>
                                                        <!-- 제일 높은 평점 .is-top -->
                                                        <li class="is-top" data-point="5">
                                                            <span class="tx_cnt">0</span>
                                                            <span class="stick">
                                                                <span class="stick--gauge"></span>
                                                            </span>
                                                            <span class="tx_grade">5점</span>
                                                        </li>
                                                        <li data-point="4">
                                                            <span class="tx_cnt">0</span>
                                                            <span class="stick">
                                                                <span class="stick--gauge"></span>
                                                            </span>
                                                            <span class="tx_grade">4점</span>
                                                        </li>
                                                        <li data-point="3">
                                                            <span class="tx_cnt">0</span>
                                                            <span class="stick">
                                                                <span class="stick--gauge"></span>
                                                            </span>
                                                            <span class="tx_grade">3점</span>
                                                        </li>
                                                        <li data-point="2">
                                                            <span class="tx_cnt">0</span>
                                                            <span class="stick">
                                                                <span class="stick--gauge"></span>
                                                            </span>
                                                            <span class="tx_grade">2점</span>
                                                        </li>
                                                        <li data-point="1">
                                                            <span class="tx_cnt">0</span>
                                                            <span class="stick">
                                                                <span class="stick--gauge"></span>
                                                            </span>
                                                            <span class="tx_grade">1점</span>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- //사용자별점&평점 -->
                                        <div id="prod_bbs_exception"  class="row__section prod--exception is-adult"  style="display:none;">
                                            <div class="tx_box">
                                                <p class="tx_exception">본 건텐츠는 청소년 유해 매체물로서 정보통신망 이용 및<br>정보보호 등에 관한 법률, 청소년 보호법 규정에 의하여<br>19세 미만의 청소년이 이용할 수 없습니다.</p>

                                                <div class="btn__group">
                                                    <ul class="btn__list">
                                                        <li><a href="javascript:void(0);" class="btn btn--black" onclick="$('#lay_adult_wrap').show();">성인인증 후 사진보기</a></li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- 포토리뷰 리스트 -->
                                        <div class="photoreview" id="prod_image_bbs" style="display:none;">
                                            <div class="photoreview__head">
                                                <p class="photoreview__tit">포토상품평 <em class="tx_cnt"></em></p>
                                            </div>
                                            <div class="photoreview__cont">
                                                <ul class="thum__list"></ul>
                                            </div>
                                        </div>

                                        <div class="reviewall" id="prod_bbs" style="display:none;"> 
                                            <div class="reviewall__head">
                                                <p class="reviewall__tit">전체상품평 <em class="tx_cnt"></em></p>

                                                <div class="abs--right">
                                                    <div class="reviewall__onlyphoto">
                                                        <p class="toggle__chk is-off">
                                                            <span class="switch"><strong>포토상품평만 보기</strong><span class="btn"><em>on/off</em></span></span>
                                                        </p>
                                                    </div>
                                                    <div class="reviewall__select">
                                                        <div class="select-box--basic">
                                                            <div class="select-box--selected">쇼핑몰 선택<i class="ico-arr-select-box lp__sprite"></i></div>
                                                            <ul class="select-box__list"></ul>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="reviewall__cont">
                                                <div class="reviewfilter" >
                                                    <ul class="point__filter">
                                                        <li class="is-on" data-point="0"><button type="button">전체</button></li>
                                                        <li class="is-disabled" data-point="5"><button type="button">5점<span class="tx-num"></span></button></li>
                                                        <li class="is-disabled" data-point="4"><button type="button">4점<span class="tx-num"></span></button></li>
                                                        <li class="is-disabled" data-point="3"><button type="button">3점<span class="tx-num"></span></button></li>
                                                        <li class="is-disabled" data-point="2"><button type="button">2점<span class="tx-num"></span></button></li>
                                                        <li class="is-disabled" data-point="1"><button type="button">1점<span class="tx-num"></span></button></li>
                                                    </ul>
                                                    <div class="subject__filter" style="display:none">
                                                        <ul></ul>
                                                    </div>
                                                </div>
                                               <%--  <div class="reviewall__loader">
                                                    <div class="loader">
                                                        <div class="circle1"></div>
                                                        <div class="circle2"></div>
                                                        <div class="circle3"></div>
                                                        <div class="circle4"></div>
                                                    </div>
                                                </div> --%>
                                                <ul class="reviewall__list" >
                                                    <li class="reviewall__loader" style="display:none;">
                                                        <div class="loader">
                                                            <div class="circle1"></div>
                                                            <div class="circle2"></div>
                                                            <div class="circle3"></div>
                                                            <div class="circle4"></div>
                                                        </div>
                                                    </li>
                                                    <li class="reviewall__item no-data" style="display:none;">
                                                        <p class="tx_msg">등록된 상품평이 없습니다.</p>
                                                    </li>
                                                </ul>

                                                <div class="comm__paging">
                                                    <ul class="paging"></ul>
                                                </div>
                                                <div class="reviewwrite">
                                                    <fieldset>
                                                        <legend>상품평 작성 폼</legend>
                                                    </fieldset>
                                                    <div class="reviewwrite__head">
                                                        <p class="tx_tit">상품평쓰기</p>
                                                        <%if(USER_ID.equals("")){%>
                                                            <a href="javascript:Cmd_Login('');" class="btn btn__login">로그인</a>
                                                            <a href="javascript:goJoin();" class="tx_join">회원가입</a>
                                                        <%}else{%>
                                                            <div class="userinfo">
                                                                <p class="tx_user">작성자 : <button type="button" class="btn btn__user" onclick="$(this).parents().siblings('.lay-userinfo').toggle()"><%=strViewID%></button></p>
                                                                <div class="lay-userinfo lay-comm">
                                                                    <div class="lay-comm--head">
                                                                        <strong class="lay-comm__tit"><span class="tx_nick"><%=strViewID%></span> 님</strong>
                                                                    </div>
                                                                    <div class="lay-comm--body">
                                                                        <div class="lay-comm__inner">
                                                                            <ul class="my_list">
                                                                                <li><a href="javascript:CmdJoin(3);">회원정보 변경</a></li>
                                                                                <li><a href="javascript:logout();">로그아웃</a></li>
                                                                            </ul>
                                                                        </div>
                                                                    </div>
                                                                    <button class="lay-comm__btn--close comm__sprite" onclick="$(this).closest('.lay-comm').hide();">레이어 닫기</button>
                                                                </div>
                                                            </div>
                                                        <%}%>
                                                    </div>
                                                    <div class="reviewwrite__cont">
                                                        <textarea cols="60" rows="5" class="txt__input" placeholder="<%=USER_ID.equals("") ? "로그인을 하시면 글을 작성하실 수 있습니다." : "상품평을 작성해 주세요."%>"></textarea>
                                                        <button type="button" class="btn btn__register">등록</button>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- 검색결과 컨텐츠 -->
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- //[탭 - 상품평] -->

                            <!-- [탭 - CM Q&A] -->
                            <div id="prodQnA" class="row__section tab__scroll">
                                <div class="section__inner">
                                    <div class="section__head">
                                        <h2 class="section__tit">CM Q&A</h2>
                                    </div>

                                    <div class="section__cont">
                                        <!-- CM Q&A -->
                                        <div class="cmqna">
                                            <div class="cmqna__info">
                                                <p class="tx_info"><strong>상품에 대해 궁금하신 점을 남겨주시면, CM이 자세하게 답변드립니다.</strong>상품 문의 이외에 배송 및 교환/취소/환불/AS 등의 문의는 해당 쇼핑몰에 확인 부탁드립니다.</p>
                                                <button type="button" class="btn btn__question">문의하기</button>
                                            </div>

                                            <div class="cmqna__cont">
                                                <div class="no-data" style="display:none;">
                                                    <p class="tx_msg">등록된 문의글이 없습니다.</p>
                                                </div>

                                                <table class="cmqna__table" style="display:none;">
                                                    <caption></caption>
                                                    <colgroup>
                                                        <col width="110">
                                                        <col width="90">
                                                        <col width="760">
                                                        <col width="180">
                                                        <col width="140">
                                                    </colgroup>
                                                    <thead>
                                                        <tr>
                                                            <th>번호</th>
                                                            <th>답변상태</th>
                                                            <th>문의제목</th>
                                                            <th>작성자</th>
                                                            <th>작성일</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                    </tbody>
                                                </table>

                                                <div class="comm__paging">
                                                    <ul class="paging"></ul>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- //CM Q&A -->
                                    </div>
                                </div>
                            </div>
                            <!-- //[탭 - CM Q&A] -->

                            <!-- [탭 - 블로그/동영상 리뷰] -->
                            <div id="prodBlogReview" class="row__section tab__scroll">
                                <div class="section__inner">
                                    <div class="section__head">
                                        <h2 class="section__tit">블로그/동영상 리뷰</h2>
                                    </div>

                                        <div class="section__cont">
                                            <!-- 블로그/동영상 -->
                                            <div class="blogreview" style="display:none">
                                                <div class="blogreview__head">
                                                    <p class="blogreview__tit"><strong></strong> 쇼핑지식</p>
                                                </div>

                                                <div class="blogreview__cont">
                                                    <ul class="blogreview__list"></ul>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="srchresult" data-about="blog" style="display:none">
                                            <div class="srchresult__head">
                                                <p class="srchresult__tit"><strong></strong> 검색결과</p>

                                                <p class="srch__support">검색지원 : <strong class="ico ico--zum">zum</strong></p>
                                            </div>

                                            <div class="srchresult__cont">
                                                <div class="srchcnt">
                                                    <p class="tx_tit">블로그 <span class="tx_cnt"></span></p>

                                                    <a href="" class="btn btn__more" target="_blank">검색결과 더 보기</a>
                                                </div>
                                                <ul class="vodresult__list">
                                                </ul>
                                            </div>
                                        </div>

                                        <!-- //블로그/동영상 -->
                                        <div class="srchresult"  data-about="video" style="display:none">
                                            <div class="srchresult__head">
                                                <p class="srchresult__tit"><strong></strong> 검색결과</p>

                                                <p class="srch__support">검색지원 : <strong class="ico ico--zum">zum</strong></p>
                                            </div>

                                            <div class="srchresult__cont">
                                                <div class="srchcnt">
                                                    <p class="tx_tit">동영상 <span class="tx_cnt"></span></p>

                                                    <a href="" class="btn btn__more"  target="_blank">검색결과 더 보기</a>
                                                </div>
                                                <ul class="blogresult__list">
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- //[탭 - 블로그/동영상 리뷰] -->
                            <!-- [VIP] AD 파워클릭 -->
                            <!-- 개편전 마크업 동일 (신청하기 레이어 마크업 수정)-->
                            <!-- .lp-ad--openad 클래스만 추가 -->
                            <div id="prodPowerClickBottom" class="comm_ad ad_powerclick lp-ad--openad">
                                <div class="comm_ad_tit">
                                    <em>파워클릭</em>
                                    <a href="https://ad.esmplus.com/Member/SignIn/LogOn?ReturnUrl=%2f" target="_blank" class="comm_btn_apply" >신청하기</a>
                                </div>
                                <!-- // -->
                                <div class="comm_ad_list ad_goods">
                                    <ul></ul>
                                </div>
                            </div>
                            <!-- // -->
                            <div id="prodRecommend" class="row__section tab__scroll" style="display:none;">
                                <div class="section__inner">
                                    <div class="section__head">
                                        <h2 class="section__tit">추천상품</h2>
                                    </div>

                                    <div class="section__cont">
                                        <div class="recommbox" data-target="consumables" style="display:none;">
                                        </div>
                                        <div class="recommendprod">
                                            <div class="recommendprod__head">
                                                <ul class="recommendprod__sort">
                                                    <li style="display:none;"><button type="button" class="btn">동일 브랜드 상품</button></li>
                                                    <li style="display:none;"><button type="button" class="btn">다른 브랜드 상품</button></li>
                                                    <li style="display:none;"><button type="button" class="btn">동일 카테고리 상품</button></li>
                                                </ul>
                                            </div>
                                            <div class="recommendprod__cont">
                                                <div class="recommendprod__list" style="display:none;">
                                                    <!-- 추천상품 항목 -->
                                                    <div class="comp_item">
                                                        <table class="tb_compspec">
                                                            <!-- 상품정보 .spec_info -->
                                                            <tbody>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                    <!-- 비교상품 리스트 -->
                                                    <div class="comp_prod">
                                                        <button class="btn_comp btn_comp_prev">이전</button>
                                                        <button class="btn_comp btn_comp_next">다음</button>

                                                        <ul class="comp_prod_list">
                                                        </ul>
                                                    </div>
                                                </div>
                                                <div class="recommendprod__list" style="display:none;">
                                                    <!-- 추천상품 항목 -->
                                                    <div class="comp_item">
                                                        <table class="tb_compspec">
                                                            <!-- 상품정보 .spec_info -->
                                                            <tbody>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                    <!-- 비교상품 리스트 -->
                                                    <div class="comp_prod">
                                                        <button class="btn_comp btn_comp_prev">이전</button>
                                                        <button class="btn_comp btn_comp_next">다음</button>

                                                        <ul class="comp_prod_list">
                                                        </ul>
                                                    </div>
                                                </div>
                                                <div class="recommendprod__list" style="display:none;">
                                                    <!-- 추천상품 항목 -->
                                                    <div class="comp_item">
                                                        <table class="tb_compspec">
                                                            <!-- 상품정보 .spec_info -->
                                                            <tbody>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                    <!-- 비교상품 리스트 -->
                                                    <div class="comp_prod">
                                                        <button class="btn_comp btn_comp_prev">이전</button>
                                                        <button class="btn_comp btn_comp_next">다음</button>

                                                        <ul class="comp_prod_list">
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="recommbox" data-target="sameBrand" style="display:none;">
                                        </div>
                                        <div class="recommbox" data-target="diffBrand" style="display:none;">
                                        </div>
                                        <div class="recommbox" data-target="sameCate" style="display:none;">
                                        </div>
                                        <div class="recommbox" data-target="sameSeries" style="display:none;">
                                        </div>
                                        <div class="recommbox" data-target="buyTogether" style="display:none;">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- //탭 컨테이너 섹션 -->
                    </div>
                </div>
                <!-- // -->
                <!-- [LAYER]상품이미지 확대보기(딤레이어) -->
                <div id="THUMNAILLAYER" class="lay--dimm-wrap"></div>

                <!-- [LAYER]포토상품평 레이어 -->
                <div id="PHOTOLAYER" class="lay--dimm-wrap" style="display:none;">
                    <div class="dimmed"></div>

                    <div class="lay-photoreview lay-comm">
                        <div class="lay-comm--head">
                            <button type="button" class="btn btn__viewtype" data-all-visible="false">전체보기</button>
                        </div>
                        <div class="lay-comm--body">
                            <!-- 리뷰 상세보기 -->
                            <div class="photoreview__view">
                                <!-- 화살표 -->
                                <div class="arrows arrows--dark">
                                    <button type="button" class="arr arr-prev">이전</button>
                                    <button type="button" class="arr arr-next">다음</button>
                                </div>

                                <div class="photoreview__lt"></div>
                                <div class="photoreview__rt"></div>
                            </div>

                            <!-- 리뷰 전체보기 -->
                            <div class="photoreview__all" style="display:none;">
                                <ul class="photoreview__list">
                                </ul>
                                <div class="limit__alarm" style="display: none;">
                                    <p class="tx_alarm">포토 상품평 전체보기는 500개 까지만 제공됩니다.<br>더 많은 상품평은  전체상품평 리스트에서 확인해 주세요.</p>
                                </div>
                            </div>
                        </div>
                        <!-- 버튼 : 레이어 닫기 -->
                        <button class="lay-comm__btn--close comm__sprite" onclick="$(this).closest('.lay--dimm-wrap').hide()">레이어 닫기</button>
                    </div>
                </div>
                <!-- 포토상품평 레이어 -->
                <div id="TEXTLAYER" class="lay--dimm-wrap" style="display: none;">
                    <div class="dimmed"></div>
                    
                    <div class="lay-textreview lay-comm">
                        <div class="lay-comm--head">
                            <strong class="lay-comm__tit">일반 상품평</strong>
                        </div>
                        <div class="lay-comm--body">
                            <!-- 리뷰 상세보기 -->
                            <div class="textreview__view">
                                
                            </div>
                        </div>
                        <!-- 버튼 : 레이어 닫기 -->
                        <button class="lay-comm__btn--close comm__sprite" onclick="$(this).closest('.lay--dimm-wrap').hide()">레이어 닫기</button>
                    </div>
                </div>
                <!-- [LAYER]CMQ&A 상세보기 레이어 -->
                <div id="QNAVIEWLAYER" class="lay--dimm-wrap"></div>
                <!-- //[LAYER]CMQ&A 상세보기 레이어 -->

                <!-- [LAYER]CMQ&A 등록 레이어 -->
                <div id="QNAWRITELAYER" class="lay--dimm-wrap">
                    <div class="dimmed"></div>

                    <div class="lay-cmqna lay-comm">
                        <div class="lay-comm--head">
                            <strong class="lay-comm__tit">CM Q&amp;A</strong>
                        </div>
                        <div class="lay-comm--body">
                            <div class="lay-comm--inner">
                                <form>
                                    <div class="line__write">
                                        <div class="row__ipt">
                                            <label for="inputCMQNA_01">제목</label>
                                            <input type="text" class="ipt" id="inputCMQNA_01" name="" placeholder="제목을 입력해주세요." />
                                        </div>
                                        <div class="row__ipt">
                                            <label for="inputCMQNA_02">내용</label>
                                            <textarea class="ipt ipt--text" rows="" cols="" id="inputCMQNA_02" name="" placeholder="내용을 입력해주세요."></textarea>
                                        </div>
                                    </div>

                                    <div class="lay-comm__btn-group">
                                        <button type="button" class="lay-comm__btn lay-btn--md" onclick="$(this).closest('.lay--dimm-wrap').hide()">취소</button>
                                        <button type="button" class="lay-comm__btn lay-btn--md lay-btn--color--blue">등록하기</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <!-- 버튼 : 레이어 닫기 -->
                        <button class="lay-comm__btn--close comm__sprite" onclick="$(this).closest('.lay--dimm-wrap').hide()">레이어 닫기</button>
                    </div>
                </div>
                <!-- //[LAYER]CMQ&A 등록 레이어 -->

                <div id="SINGOLAYER" class="lay--dimm-wrap">
                    <div class="dimmed">
                        <div class="lay-singo lay-comm">
                            <div class="lay-comm--head">
                                <strong class="lay-comm__tit">불편 오류 신고</strong>
                            </div>
                            <div class="lay-comm--body">
                                <div class="lay-comm--inner">

                                    <div class="error-report">
                                        <dl class="error-report--target">
                                            <dt>상품 오류 신고</dt>
                                            <dd>
                                                <div class="error-report__box"></div>
                                            </dd>
                                        </dl>
                                        <dl class="error-report--item">
                                            <dt>신고항목</dt>
                                            <dd>
                                                <ul class="list-form--radio">
                                                </ul>
                                            </dd>
                                        </dl>
                                        <dl class="error-report--content">
                                            <dt>신고내용</dt>
                                            <dd>
                                                <textarea class="error-report__box" name="inconv_txt" id="inconv_txt" cols="30" rows="5" placeholder="항목에 없거나 추가하실 내용을 적어주세요. 신고내용을 상세히 작성해주시면 담당자가 더욱 빠르게 처리할 수 있습니다."></textarea>
                                            </dd>
                                        </dl>
                                        <dl class="error-report--feedback">
                                            <dt>답변알림
                                                <input type="checkbox" name="chkEmail" id="chkEmail" class="input--checkbox-item"><label for="chkEmail">처리결과 받기</label>
                                            </dt>
                                            <dd>
                                                <input type="text" name="inconv_email" id="inconv_email" class="error-report__box" placeholder="이메일 주소를 입력해 주세요">
                                            </dd>
                                        </dl>
                                    </div>

                                    <div class="lay-comm__btn-group">
                                        <button class="lay-comm__btn lay-btn--md">취소</button>
                                        <button class="lay-comm__btn lay-btn--md lay-btn--color--blue">완료</button>
                                    </div>
                                </div>
                            </div>
                            <!-- 버튼 : 레이어 닫기 -->
                            <button class="lay-comm__btn--close comm__sprite">레이어 닫기</button>
                            <!-- // -->
                        </div>
                    </div>
                </div>
                <!-- 상품 옵션 보기 레이어(DIMMED) -->
                <div id="PRODOPTIONVIEW" class="lay--dimm-wrap">
                    <div class="dimmed">
                        <div class="lay-optsel lay-comm">
                            <div class="lay-comm--head">
                                <strong class="lay-comm__tit">상품 옵션 보기</strong>
                            </div>
                            <div class="lay-comm--body">
                                <div class="lay-comm__inner">
                                    <div class="optsel__wrap">
                                        <div class="optsel__box">
                                            <div class="col col-1">
                                                <ul class="optsel__list">
                                                </ul>
                                            </div>

                                            <div class="col col-2">
                                                <ul class="optsel__list">
                                                </ul>
                                            </div>

                                            <div class="col col-3">
                                                <p class="tx_tit">선택한 옵션</p>
                                                <ul class="optsel__list">
                                                </ul>
                                            </div>
                                        </div>

                                        <div class="optsel__price">
                                            <p class="line__price"></p>
                                            <a class="btn btn__mall" href="#" target="_blank">쇼핑몰로 이동</a>
                                        </div>

                                    </div>

                                </div>
                            </div>
                            <!-- 버튼 : 레이어 닫기 -->
                            <button class="lay-comm__btn--close comm__sprite" onclick="$(this).closest('.lay--dimm-wrap').hide()">레이어 닫기</button>
                        </div>
                    </div>
                </div>

                <!-- e머니구매적립안내 레이어(DIMMED) -->
                <div id="EMONEYLAYER" class="lay--dimm-wrap">
                    <div class="dimmed">
                        <div class="lay-emoney lay-comm">
                            <div class="lay-comm--head">
                                <strong class="lay-comm__tit">e머니 구매적립 안내</strong>
                            </div>
                            <div class="lay-comm--body">
                                <div class="lay-emoney__cont">
                                    <dl>
                                        <dt>적립방법</dt>
                                        <dd>
                                            에누리 가격비교 모바일 앱 로그인 → 적립대상 쇼핑몰 이동 →<br> 1천원 이상 구매 → 구매확정(배송완료) 시 e머니 적립
                                            <span class="tx_em">※ 티몬 및 에누리 해외직구관의 경우 PC 및 모바일 앱/웹에서 로그인 후 구매시에도 구매적립 가능합니다.</span>
                                        </dd>
                                        <dt>사용안내</dt>
                                        <dd>
                                            - 적립된 e머니는 e쿠폰 스토어에서 다양한 쿠폰으로 교환가능합니다
                                        </dd>
                                        <!-- dt.cont-fold 클릭시 .unfold 클래스 토글 -->
                                        <dt class="cont-fold">예상 적립금 안내</dt>
                                        <dd>
                                            <ul>
                                                <li>예상 적립금은 기본 적립률을 적용한 금액입니다.</li>
                                                <li>실제 적립금과는 다를 수 있습니다.</li>
                                            </ul>
                                        </dd>
                                        <dt class="cont-fold">적립대상 쇼핑몰</dt>
                                        <dd>
                                            <ul>
                                                <li>모바일 앱 : G마켓, 옥션, 11번가, 인터파크, 티몬, 위메프, 쿠팡, GS SHOP, CJmall, SSG (신세계몰, 신세계백화점, 이마트몰, 트레이더스), SK스토아, 홈플러스</li>
                                                <li class="tx_blue">PC : 티몬</li>
                                            </ul>
                                        </dd>
                                        <dt class="cont-fold">적립대상 쇼핑몰 중 e머니 구매적립 제외 카테고리 및 서비스</dt>
                                        <dd>
                                            <ul>
                                                <li>에누리 가격비교에서 검색되지 않는 상품</li>
                                                <li>모바일쿠폰,상품권 : 상품권, 지역쿠폰, e교환권, e쿠폰 등</li>
                                                <li>쇼핑몰 제휴 서비스(배달, 티켓, 해외직구 등) 및 일부 카테고리</li>
                                                <li>G마켓 : 중고장터, 실시간 여행, 항공권, 도서/음반,<br>모바일쿠폰/상품권(일부 적립가능)</li>
                                                <li>옥션 : 중고장터, 실시간 여행, 항공권, 모바일쿠폰/상품권(일부 적립가능)</li>
                                                <li>11번가 : 여행/숙박/항공, 모바일쿠폰/상품권</li>
                                                <li>인터파크 : 라이프 서비스(티켓, 투어, 아이마켓 등), 모바일쿠폰/상품권(일부<br> 적립가능)</li>
                                                <li>티몬 : 특가 판매 상품(슈퍼꿀딜, 슈퍼마트 등), 모바일쿠폰/상품권</li>
                                                <li>위메프 : 모바일쿠폰/상품권</li>
                                                <li>GS SHOP, CJmall : 모바일쿠폰/상품권</li>
                                                <li>SSG : 도서/음반/문구/취미/여행, 모바일쿠폰/상품권</li>
                                            </ul>
                                        </dd>
                                    </dl>
                                    <script>
                                        $(function(){ // 적립e머니 레이어용
                                            var $btnFold = $(".lay-emoney .cont-fold")
                                            $btnFold.click(function(){
                                                var $this = $(this);
                                                $this.toggleClass("unfold");
                                                setTimeout(function(){
                                                    if ( $this.hasClass("unfold") ){
                                                        var $wrap = $this.closest('.lay-comm--body');
                                                        var $dd = $this.next('dd');
                                                        if ( $wrap.outerHeight() < $dd.position().top + $dd.outerHeight() ){
                                                            $wrap.scrollTop($this.position().top + $wrap.scrollTop() - 60);
                                                        }
                                                    }
                                                },100);
                                            })
                                        })
                                    </script>
                                </div>
                            </div>
                            <div class="lay-comm--foot">
                                <div class="lay-emoney-sendsms">
                                    <div class="sendsms__tit">SMS전송</div>
                                    <div class="sendsms__form">
                                        <fieldset>
                                            <legend>SMS전송</legend>
                                            <input type="text" class="sendsms__form--inp" placeholder="- 없이 입력하세요">
                                            <button class="sendsms__form--btn"  onclick="sendDetailSms(this, 'enuri');">전송</button>
                                        </fieldset>
                                    </div>
                                    <span class="sendsms__send-url--tx">- APP 다운로드 페이지를 전송해 드립니다</span>
                                    <span class="sendsms__send-url--tx">- 입력하신 번호는 저장되지 않습니다.</span>
                                    <a href="http://www.enuri.com/eventPlanZone/jsp/shoppingBenefit.jsp" target="_blank" class="sendsms__btn--benefit"> &gt; 모바일혜택 더보기</a>
                                </div>
                            </div>
                            <!-- 버튼 : 레이어 닫기 -->
                            <button class="lay-comm__btn--close comm__sprite" onclick="$(this).closest('.lay--dimm-wrap').hide()">레이어 닫기</button>
                        </div>
                    </div>
                </div>
                <div id="MINPRICEALARMLAYER" class="lay--dimm-wrap" style="display: none;"></div>

                <div id="TERMDICLAYER" class="lay-dic lay-comm" style="display:none"></div> 
                <!-- 찜 레이어 -->
                <div class="lay-zzim is--off">
                    <div class="lay-zzim__icon"></div>
                    <div class="lay-zzim__tx--tit">찜이 완료되었습니다.</div>
                    <div class="lay-zzim__tx--tit tx--off">찜이 해제되었습니다.</div>
                    <button class="lay-zzim__btn" onclick="resentZzimOpen(2);">찜 목록보기 &gt;</button>
                </div>
                <% if (!IsAdultFlag && blAdultCate) { %>
                <%@ include file="/lsv2016/include/IncAdultDim.jsp"%>
                <% } %>
        </div>
        <iframe id="hFrame" style="width:0px;height:0px;border:0px;overflow:hidden;" scrollbar="no" frameborder="0" src=""></iframe>
        <!-- // [HM] 메인 컨텐츠  -->
    <jsp:include page="/wide/common/jsp/Footer.jsp" />


<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-53076228-1', 'auto');
  ga('require', 'displayfeatures');
  ga('require', 'linkid', 'linkid.js');
  ga('send', 'pageview');//{'page': '/view/Detailmulti.jsp','title': '상품상세창'}
    _TRK_PI="PDV";
    _TRK_PN = "<%=ReplaceStr.replace(strModelNmView, "\"", "''")%>";
    _TRK_MF = "<%=ReplaceStr.replace(strFactory, "\"", "''")%>";
</script>
<%
	if(!swPushId.isEmpty()) {
%>
	<!-- Global site tag (gtag.js) - Google Analytics -->
	<script async src="https://www.googletagmanager.com/gtag/js?id=UA-54506142-3"></script>
	<script>
	  window.dataLayer = window.dataLayer || [];
	  function gtag(){dataLayer.push(arguments);}
		gtag('js', serviceWorker);
		gtag('config', 'UA-54506142-3');
		gtag('event','serviceworker_click',{
			'event_category' : 'serviceworker',
			 'event_label': 'serviceworker_click_'+serviceWorker
		});
	</script>
<%
	}
%>
<%
//크리테오
if(blCriteo){
%>
<script type="text/javascript" src="//static.criteo.net/js/ld/ld.js" async="true"></script>
<script type="text/javascript">

window.criteo_q = window.criteo_q || [];
window.criteo_q.push(
        { event: "setAccount", account: 17070 },
        { event: "setSiteType", type: "d" },
        { event: "viewItem", item: "<%=intModelno%>" }
);
</script>
<%
}
%>
<% if (!(strCdateView.equals("출시예정") || (intMallCnt <= 0 && intMallCnt3 <=0)) && lngMinPrice > 0) { %>
<script id="SEOSCRIPT" type="application/ld+json">
{
    "@context": "http://schema.org/",
    "@type": "Product",
    "name": "<%=strModelNmView%>",
    "image": [
        "<%=strImageUrl%>"
    ],
    "description": "<%=ReplaceStr.replace(ReplaceStr.replace(strSpec,"'",""),"\"","")%>",
    "brand": {
        "@type": "Thing",
        "name": "<%=strFactory%>"
    },
    "sku" : "<%=strCategory%>",
    "mpu" : "<%=intModelno%>",
    "offers": {
        "@type": "Offer",
        "url": "<%=strPlMinUrl %>",
        "priceCurrency": "KRW",
        "price": "<%=lngMinPrice%>",
        "priceValidUntil": "<%=strGoogleDate %>",
        "itemCondition": "<%=strPlMinUrl %>",
        "availability": "https://schema.org/InStock",
        "seller": {
        "@type": "Organization",
        "name": "<%=intPlMinShopCode %>"
        }
    },
<%if(flBbsPointAvg > 0) {%>
    "aggregateRating" : {
        "@type" : "AggregateRating",
        "ratingValue" : "<%=flBbsPointAvg%>",
        "reviewCount" : "<%=intBbsNum%>"
    },
    "review" : {
        "@type" : "Review",
        "reviewRating" : {
            "@type" : "Rating",
            "ratingValue" : "<%=flBbsPointAvg%>",
            "bestRating" : "5"
        },
        "author" : {
            "@type" : "Person",
            "name" : "enuri"
        }
    }
}
<%} else {%>
    "aggregateRating" : {
            "@type" : "AggregateRating",
            "ratingValue" : "",
            "reviewCount" : ""
        },
    "review" : {
        "@type" : "Review",
        "reviewRating" : {
            "@type" : "Rating",
            "ratingValue" : "",
            "bestRating" : "5"
        },
        "author" : {
            "@type" : "Person",
            "name" : "nobody"
        }
    }
}
<%}%>
</script>
<%}%>
<script id="LOGGERSCRIPT" language=javascript src="http://img.enuri.info/common/js/Log_Tail.js?v=202002191"></script>