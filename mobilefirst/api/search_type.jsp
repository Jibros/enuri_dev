<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.main.Goods_Data"%>
<%@ page import="com.enuri.bean.lsv2016.Goods_Change_Data"%>
<%@ page import="com.enuri.bean.main.Search_Type_Proc"%>
<%@ page import="com.enuri.bean.lsv2016.Category_Set_Proc"%>
<%@ page import="com.enuri.bean.lsv2016.Category_Set_Data"%>
<%@ page import="com.enuri.bean.lsv2016.Coupon_Layer_Proc"%>
<%@ page import="com.enuri.bean.lsv2016.Goods_Search_Lsv_Proc"%>
<%@ page import="com.enuri.bean.lsv2016.Goods_Search_Lsv_Data"%>
<%@ page import="com.enuri.bean.main.Pricelist_Data"%>
<%@ page import="com.enuri.bean.main.Pricelist_Proc"%>
<%@ page import="com.enuri.bean.main.Rental_Model_Proc"%>
<%@ page import="com.enuri.bean.knowbox.Know_termdic_title_Proc"%>
<jsp:useBean id="Search_Type_Proc" class="com.enuri.bean.main.Search_Type_Proc" scope="page" />
<jsp:useBean id="Coupon_Layer_Proc" class="com.enuri.bean.lsv2016.Coupon_Layer_Proc" scope="page" />
<jsp:useBean id="Goods_Search_Lsv" class="com.enuri.bean.lsv2016.Goods_Search_Lsv_Proc" scope="page" />
<jsp:useBean id="Pricelist_Proc" class="com.enuri.bean.main.Pricelist_Proc" />
<jsp:useBean id="Searchfunction" class="com.enuri.bean.search.SearchFunction" />
<jsp:useBean id="Know_termdic_title_Proc" class="com.enuri.bean.knowbox.Know_termdic_title_Proc" scope="page" />
<%@ include file="/lsv2016/include/IncSearch.jsp"%>
<%@page import="org.json.*"%>
<%@ page import="java.util.regex.*"%>
<%

	Search_Type_Proc search_type_proc = new Search_Type_Proc();
	Goods_Data[] goods_data = null;
	Goods_Data[] goods_all_group_data = null;
	 
	//deviceType=1 : PC
	//deviceType=2 : 모바일 
	String deviceType = ConfigManager.RequestStr(request, "deviceType", "2");
	String IsMobileApp = ConfigManager.RequestStr(request, "IsMobileApp", "N");// 모바일 앱에서는 무조건 성인 이미지 상관없이 보이도록함(deviceType=2)
	String mobileAppAdult = ConfigManager.RequestStr(request, "mobileAppAdult", "N");
	String tabType = ConfigManager.RequestStr(request, "tabType", "0");
	String IsDeliverySumPrice = ConfigManager.RequestStr(request, "IsDeliverySumPrice", "N");
	String IsJungoPriceRemove = ConfigManager.RequestStr(request, "IsJungoPriceRemove", "N");
	String strCate = ConfigManager.RequestStr(request, "cate", ""); 
	
	String strKeyword = ChkNull.chkStr(request.getParameter("keyword"));
	String strKeywordTmp = strKeyword.replaceAll(" ","");
	String strModelType = ""; 

	String serverName = request.getServerName();
	String strServerName = "";
	String tmpstrCate4 = "";
	if(strCate.length()>4) {
		tmpstrCate4 = strCate.substring(0,4);
	}else{
		tmpstrCate4 = strCate;
	}
	HashMap<String,Integer> termdictitle_data  = Know_termdic_title_Proc.getCondiNameToDic(tmpstrCate4);
	if(serverName.indexOf("dev.enuri.com") > -1 ) {
		strServerName = "dev";
	}else{ 
		strServerName = "real";
	} 
	
	/***************************************************************************************
		PC VIP 휴대폰/스마트폰(0304) SRP2 C타입 추가 Start : 2018..09.11
	****************************************************************************************/
	String isVip = ConfigManager.RequestStr(request, "isVip", "N");
	int intVipModelNo = ChkNull.chkInt(ConfigManager.RequestStr(request, "vipModelNo", "0"));

	// db에 있는 키워드 정보를 가져 옴.
	if ("Y".equals(isVip) && intVipModelNo > 0) {
		//strKeywordTmp = search_type_proc.getVipSearchType(strKeyword, strServerName);
		strKeywordTmp = search_type_proc.getVipModelNoSearchType(intVipModelNo, strServerName);
	}	
	/***************************************************************************************
		PC VIP 휴대폰/스마트폰(0304) SRP2 C타입 추가 End
	***************************************************************************************/
	
	int iModelno = 0;  
	String type_cd = "";
	JSONArray jSONObject = new JSONArray();
	jSONObject = search_type_proc.getSearchTypeJson(strKeywordTmp, strServerName); 
	
	JSONObject jsonObject = new JSONObject();
    boolean bDtypeAuto = false;
    
	if(jSONObject.length() == 0){ 
		jSONObject = new JSONArray();
		strKeywordTmp = strKeyword.replaceAll("-","").replaceAll(" ","");
		jSONObject = search_type_proc.getSearchTypeJsonByGoodsModelnm(strKeywordTmp);		//기본 C,D가 아닐때 D타입 자동화 로직
		bDtypeAuto = true;	// D타입 자동화 로직은 영문+숫자+4자이상 제한있음
	}  
	 
	if(jSONObject.length() == 0){ 
		jSONObject = new JSONArray();
		jSONObject = search_type_proc.getSearchTypeJsonByEnuriKeyword(strKeyword);		//기본 C,D가 아닐때 C타입 동의어태움
		bDtypeAuto = false;
	}  
	 
	for(int j = 0 ; j < jSONObject.length() ; j ++){ 
		JSONObject jSONGoods = (JSONObject)jSONObject.get(j);
 
		if(strModelType.equals("")){
			strModelType = (String)jSONGoods.get("MODEL_TYPE");
			iModelno = Integer.parseInt((String)jSONGoods.get("MODELNO"));
		} 
	}
	
	out.print(" {  " );

	out.print(" \"type\": { ");
	if(bDtypeAuto && !numCheck(strKeywordTmp)){
		out.print(" \r\n			\"type\":\"\" ");
	}else{
		
		if(strModelType.equals("C")){
			type_cd=jSONObject.getJSONObject(0).getString("TYPE_CD");
			String strType_cd = (type_cd.equals("T")) ?  "통신선택" : "용량선택";
			out.print(" \r\n			\"title_name\":\""+strType_cd+"\", ");
		}
		
		out.print(" \r\n			\"type\":\""+strModelType+"\" ");
		
		
	}

 	out.print(" }   " );

	if(strModelType.equals("C")){
		out.print(",  \"list\": [  ");
	 
		for(int j = 0 ; j < jSONObject.length() ; j ++){
			JSONObject jSONGoods = (JSONObject)jSONObject.get(j);
			if(j > 0){
				out.print("\r\n			,  "); 
			}
			out.print("\r\n			{  ");
			out.print("\r\n			\"option_3\":\""+(String)jSONGoods.get("OPTION_3")+"\", ");
			out.print("\r\n			\"option_2\":\""+(String)jSONGoods.get("OPTION_2")+"\", ");
			out.print("\r\n			\"option_1\":\""+(String)jSONGoods.get("OPTION_1")+"\", ");
			out.print("\r\n			\"keyword\":\""+(String)jSONGoods.get("KEYWORD")+"\", ");
			out.print("\r\n			\"modelno\":\""+(String)jSONGoods.get("MODELNO")+"\", ");
			out.print("\r\n			\"minprice\":\""+(String)jSONGoods.get("MINPRICE")+"\", ");
			out.print("\r\n			\"minprice3\":\""+(String)jSONGoods.get("MINPRICE3")+"\", ");
			out.print("\r\n			\"mallcnt\":\""+(String)jSONGoods.get("MALLCNT")+"\", ");
			out.print("\r\n			\"mallcnt3\":\""+(String)jSONGoods.get("MALLCNT3")+"\" ");
			out.print("\r\n			}  ");
		}
 
		out.print("  ]   " );
	}else if(strModelType.equals("D") && !deviceType.equals("1")){
		if(bDtypeAuto && !numCheck(strKeywordTmp)){
			
		}else{
			out.print(",  \"list\": { ");    
			 
			//for(int j = 0 ; j < jSONObject.length() ; j ++){ 
			for(int j = 0 ; j < 1 ; j ++){
				JSONObject jSONGoods = (JSONObject)jSONObject.get(j);
				out.print("\r\n			\"keyword\":\""+(String)jSONGoods.get("KEYWORD")+"\", ");
				out.print("\r\n			\"modelno\":\""+(String)jSONGoods.get("MODELNO")+"\" ");
				iModelno = Integer.parseInt((String)jSONGoods.get("MODELNO"));
			}
			out.print(" }  " );
	  
			out.print(" ,  \"srpModelList\": [ { "); 
			goods_data = Search_Type_Proc.Goods_Bind_Search_Dtype(iModelno);
			int intGoodsDataCnt = 0;
			if (goods_data != null){
			    intGoodsDataCnt = goods_data.length;
			}
			boolean IsAdultFlag = false; 
	
			int itemShowCnt = 0;
			int intTempPopular = 0;
			int intPopularModelNo = 0;
			int intResizeModelNo = 0;
			boolean bSearchPage = false;
			int intPopularOrder = 0;
			String strModelNos = "";
			String strorgFactory = "";
			String strSearckKeywordSynonym = "";
			
			for(int i=0; i<intGoodsDataCnt; i++) {
				
			%>
			<%@ include file="/include/IncGroupTool_2010.jsp"%>
			<%
				int intModelNo = goods_data[i].getModelno(); 
				String strCa_code = goods_data[i].getCa_code();
				String strImgChk = goods_data[i].getImgchk();
				String strImgChk2 = goods_data[i].getImgchk2();
				String strImgChk3 = goods_data[i].getImgchk3();
				
				Category_Set_Proc category_set_proc = new Category_Set_Proc();
				Category_Set_Data[] category_set_data = category_set_proc.getCategorySetList("");
				
				if(cb.GetCookie("MEM_INFO","ADULT")!=null) {
					String adultStr = cb.GetCookie("MEM_INFO","ADULT");
					// 성인인증 됨 
					if(adultStr.equals("1")) IsAdultFlag = true;
				}
	
				HashMap<Integer, int[]> modelnosInfoHash = new HashMap<Integer, int[]>();
				HashMap<Integer, String> modelnosKeywordHash = new HashMap<Integer, String>();
				HashMap<Integer, Goods_Change_Data> groupModelnosInfoHash = new HashMap<Integer, Goods_Change_Data>();
				int[] modelnosParamAry2 = null; 
				modelnosParamAry2 = new int[1];
	
				for(int j=0; j<modelnosParamAry2.length; j++) {
					modelnosParamAry2[j] = iModelno;
				}
	
				Goods_Change_Data[] goods_change_data = Goods_Search_Lsv.getGoods_Bind_Change(modelnosParamAry2);
				
				int[][] rtnList = Goods_Search_Lsv.getGroupModelKbNum(modelnosParamAry2);
				if(rtnList!=null && rtnList.length>0) {
					for(int ii=0; ii<rtnList.length; ii++) {
						if(rtnList[ii]!=null) modelnosInfoHash.put(rtnList[ii][0], rtnList[ii]);
					}
				}
				
				if(goods_change_data!=null && goods_change_data.length>0) {
					for(int ii=0; ii<goods_change_data.length; ii++) {
						groupModelnosInfoHash.put(goods_change_data[ii].getModelno(), goods_change_data[ii]);
					}
				}
					
				// 쿠폰 레이어 정보
				// 1:쿠폰레이어, 2:시스템점검 레이어
				String[][] CouponLayerAry = Coupon_Layer_Proc.getCouponLayerList(1);
				
				Rental_Model_Proc rental_model_proc = new Rental_Model_Proc();
	
				// 정기 점검 정보 가져오기
				String[][] SystemCheckLayerAry = Coupon_Layer_Proc.getCouponLayerList(2);
	
				// 없음(품절), 미정(출시예정), 클릭(핸드폰) 세가지 종류가 있음
				String prodStatusTxt = "";
			
				String strCate2 = "";
				String strCate4 = "";
				String strCate6 = "";
				String strCate8 = "";
				
				String strLCode = "";
				String strMCode = "";
				String strSCode = "";
				String strDCode = "";
				int  listType = 0;
				
				String[] arrCondi = null;
				String strCondi = "";
				
				if(strCondi.trim().length()>0) {
					arrCondi = strCondi.split("\\^");
					strCondi = strCondi.replace("\"","&quot;");
				}
				goods_all_group_data = Search_Type_Proc.Goods_Bind_Search_Dtype_Group(intModelNo);
				
				// 광고 타입
				// "" : 광고 아님
				// "1" : 스폰서
				// "2" : 마음열기
				String intAdType = "";
			
				goods_data[i].setAdType(intAdType);
			
				out.print("\r\n			\"intModelNoOrg\":\""+intModelNo+"\", ");
			 
				if(intModelNo>0) {
			%><%@ include file="/lsv2016/include/IncGroupModelListJson.jsp"%><%
				}
				
				strModelNos = strModelNos + intModelNo + ",";
				String strFactory = goods_data[i].getFactory();
				strorgFactory = strFactory;
				strFactory = Searchfunction.IsIn(strFactory, strSearckKeywordSynonym);
			
				//제조사 브랜드 수정
				String strBrand = goods_data[i].getBrand();
			
				if(strFactory.indexOf("불명")>-1) strFactory = "";
				if(strBrand.indexOf("불명")>-1) strBrand = "";
			
				String strOrgFactory = goods_data[i].getFactory();
				String strModelName = "";
				if(goods_data[i].getModelnm()!=null) {
					strModelName = goods_data[i].getModelnm();
				}
			
				if(intModelNo>0) {
					if(!(strCate2.equals("93"))) {
						if(strModelName.lastIndexOf("[")>0) {
							strModelName = strModelName.substring(0,strModelName.lastIndexOf("["));
						}
					}
				}
			
				String strTempModelName = strModelName;
				
				boolean bAdultKeyword = false;
				%><%@ include file="/include/IncAdultKeywordCheck_2010.jsp" %><%					
				//쇼핑몰 카드 무이자 할부 정보
				String[][] cardFreeAry = Pricelist_Proc.getPriceList_CardFree();
	
				HashMap cardNameHash = getCardNameHash();
	
				 
				//제조사 브랜드 수정
			    String[] strModel_FBN = getModel_FBN_2016(strCate, strModelName, strorgFactory, strBrand, category_set_data);
				String strNewModelnm = strModelName;
			
				if(intModelNo>0) {
					strNewModelnm = strModel_FBN[1] +" "+  strModel_FBN[2] +" "+ strModel_FBN[0];
				} else {
					String[] tempPriceCodeAry = goods_data[i].getSpec().split(":");
					if(tempPriceCodeAry!=null && tempPriceCodeAry.length>0) {
						int intShopCode = 0;
						try {
							intShopCode = Integer.parseInt(tempPriceCodeAry[0]);
						} catch(Exception e) {}
			
						if(intShopCode>0) {
							strNewModelnm = getRemoveCardSale(cardNameHash, strNewModelnm, intShopCode, goods_data[i].getMinprice(), strCa_code, goods_data[i].getFactory_etc(), cardFreeAry);
						}
					}
			
					if(strModel_FBN[1].trim().length()>0 && strModel_FBN[1].trim().indexOf("기타")<0 && strModel_FBN[1].trim().indexOf("없음")<0 && strModel_FBN[1].indexOf("상품")<0 && strModel_FBN[1].trim().indexOf("상세")<0) {
						strNewModelnm = "["+strModel_FBN[1].trim()+"]"+strNewModelnm;
					}
				}
			
				strNewModelnm = Searchfunction.IsIn(strNewModelnm,strSearckKeywordSynonym);
			
				strModelName = Searchfunction.IsIn(strModelName, strSearckKeywordSynonym);
				String strOpenExpectFlag = goods_data[i].getOpenexpectflag();
			    String strConstrain = goods_data[i].getConstrain();
				int intKbNum = goods_data[i].getKb_num();
				//String strImgChkRolling = goods_data[i].getImgchk_rolling();
				String strSpec = goods_data[i].getSpec_group();
				String[] astrSpecException = {"24040101","24040102","24040103","24040106","24040201","24040202","24040203","24040206","24040209",
						"24040301","24040302","24040303","24040313","24040314","24040501","24040502","24040601","24040602","24040607","24040701","24040702",
						"24040703","24041101","24041102","24041103","24041106","24041107","24041108","24041109","24041110","24041301","24041302","24041303","24041304"};
				String strSpecTag = goods_data[i].getSpec_tag();
			
				boolean bSpecException = false;
				for(int si=0;si<astrSpecException.length;si++) {
					if(strCate.equals(astrSpecException[si])) {
						bSpecException = true;
					}
				}
				if(bSpecException || strSpec.trim().length()==0) {
					strSpec = ChkNull.chkStr(goods_data[i].getSpec(), "");
				}
				if(strCate2.equals("15") && strSpec.trim().length()==0) {
					strSpec = strModelName;
				}
				//String strBeginnerDicSpec = strSpec;
				//String strBeginnerDicCate = strCate;
				String strCdate = goods_data[i].getC_date();
				strCdate = CutStr.cutStr(strCdate,10);
			
				int intSaleCnt = goods_data[i].getSum_sale_cnt();
			
				long lngMinPrice = goods_data[i].getMinprice();
				long lngMinPrice2 = goods_data[i].getMinprice2();
				int intMallCnt  = goods_data[i].getMallcnt();
				long lngMinPrice3 = goods_data[i].getMinprice3();
				int intMallCnt3  = goods_data[i].getMallcnt3();
				long intP_Pl_No = goods_data[i].getP_pl_no();
				String strPImageUrl = goods_data[i].getP_imgurl();
				String strPImageUrlFlag = goods_data[i].getP_imgurlflag();
				int intGbCnt = goods_data[i].getGbcnt();
				//String strRsiFlag = goods_data[i].getRsiflag2();
				String strAddSale = goods_data[i].getRsiflag(); //추가할인 여부
				String strKb_title = HtmlStr.removeHtml(goods_data[i].getKb_title()); // 일반상품의 경우에는 shop_name을 저장
				String strGroupCondiName = goods_data[i].getCondiname();
				strKb_title = ReplaceStr.replace(ReplaceStr.replace(ReplaceStr.replace(strKb_title,"'",""),"\"",""),"[뉴스]","");
				//String strImageUrl =  ImageUtil.getImageSrc(strCate4,intModelNo,strImgChk,intP_Pl_No,strPImageUrl,strPImageUrlFlag);
			
				// 프린터 소모품일 경우 카테코드를 안 읽어옴
				if(listType==2) strCa_code = strCate;
			
				String strCopyPhrase = goods_data[i].getKeyword2();
				float fltBbsPoint = goods_data[i].getBbs_point_avg();
				if(strOpenExpectFlag.equals("1")) {
					lngMinPrice = 0;
					intMallCnt = 0;
					lngMinPrice3 = 0;
					intMallCnt3 = 0;
				}
			
				String strMinPrice = "";
				String strGoogle_flag = goods_data[i].getGoogle_flag();
				//String strEcatalog_flag = goods_data[i].getEcatalog_flag();
				//String strEcatalog_url = goods_data[i].getEcatalog_url();
				//String strViewCdate = DateUtil.RtnDateComment(strCdate,"2010_list","");
			
				// 성인구분 넣어줘야함
				goods_data[i].setAdultChk(IsAdultFlag);
			
				String strImageUrl = goods_data[i].getP_imgurl2();
				String adultYN = "N";
			
				if(intModelNo>0) {
					strImageUrl = ImageUtil_lsv.getImageSrc(goods_data[i]);
					
					// 모바일 앱일 경우 성인 상관없이 무조건 이미지를 그대로 보여줌
					if(deviceType.equals("2") && mobileAppAdult.equals("Y")) {
						goods_data[i].setAdultChk(true);
					} else {
						// 성인구분 넣어줘야함
						goods_data[i].setAdultChk(IsAdultFlag);
					}
					strImageUrl = ImageUtil_lsv.getImageSrc(goods_data[i]);
			
					if(isAdultCate(strCate)) adultYN = "Y";
			
				} else {
					boolean bAdult = false;
					//if(bAdultKeyword || adultKeywordCheck(strModelName) || adultCategoryCheck(strCa_code) || strSrvFlag.equals("S")) {
					if(bAdultKeyword || adultKeywordCheck(strModelName) || adultCategoryCheck(strCa_code)) {
						bAdult = true;
					}
			
					if(bAdult) adultYN = "Y";
			
					String strAdultCookie = "";
					if(cb.GetCookie("MEM_INFO","ADULT")!=null) {
						strAdultCookie = cb.GetCookie("MEM_INFO","ADULT");
					}
			
					// 모바일 앱일 경우 성인 상관없이 무조건 이미지를 그대로 보여줌
					if(deviceType.equals("2") && mobileAppAdult.equals("Y")) {
						strImageUrl = getSearchGoodsImage(false, strAdultCookie, strImageUrl, true);
					} else {
						strImageUrl = getSearchGoodsImage(bAdult, strAdultCookie, strImageUrl, true);
					}
			
					// plno상품의 경우는 getSearchGoodsImage를 이용해 성인용 체크를 하고 이미지는
					// 아래와 같이 변경해야함
					if(strImageUrl.indexOf("2012/search/19_50.gif")>-1) {
						strImageUrl = ConfigManager.IMG_ENURI_COM + "/images/home/thum_adult.gif";
					}
				}
			
				//int intPopularOrder = 0;
				if(intAdType.equals("")) intPopularOrder++;
			
				String strHotIcon = "";
	
				String strFactory_etc = goods_data[i].getFactory_etc();
				String strCouponContents = "";
				String strCouponURL = "";
				String systemText = "";
			
				if(intModelNo==0 && strGroupCondiName.length()>0) {
					strSpec = goods_data[i].getSpec();
			
					if(strGroupCondiName.trim().length()>0) {
						String strTempDeliveryInfo = strGroupCondiName;
						strTempDeliveryInfo = ReplaceStr.replace(strTempDeliveryInfo,",","");
						strTempDeliveryInfo = ReplaceStr.replace(strTempDeliveryInfo,"원","");
						if(strTempDeliveryInfo.indexOf("무료배송")>=0 || strTempDeliveryInfo.indexOf("유료")>=0 || strTempDeliveryInfo.indexOf("유무료")>=0) {
							strTempDeliveryInfo = ReplaceStr.replace(strTempDeliveryInfo,"유료","배송유료");
							strGroupCondiName = ReplaceStr.replace(strTempDeliveryInfo,"유무료","배송유무료");
						} else {
							if(ChkNull.chkNumber(strTempDeliveryInfo)) {
								strGroupCondiName = "배송:"+FmtStr.moneyFormat(strTempDeliveryInfo)+"원";
							} else {
								strGroupCondiName = "배송:"+strTempDeliveryInfo;
							}
						}
					}
			
					int intShopCode = 0;
					String[] strSpecAry = strSpec.split(":");
					if(strSpecAry!=null && strSpecAry.length>0) {
						try {
							intShopCode = Integer.parseInt(strSpecAry[0]);
						} catch(Exception e) {}
					}
			
					if(intShopCode>0) {
						strFactory_etc = getForceFreeInterest2(intShopCode, goods_data[i].getCa_code(), strFactory_etc, lngMinPrice, cardFreeAry);
					}
			
					String strSystemLayer[] = getSystemLayerInfo(intShopCode, SystemCheckLayerAry);
					if(strSystemLayer!=null && strSystemLayer.length>0) systemText = strSystemLayer[0];
			
					if(strFactory_etc.trim().length()>0) {
						strFactory_etc = "할부: " + strFactory_etc;
					}
					//strFactory_etc = "할부 : KB, 롯데, 삼성, 신한, 현대, NH농협, BC, 씨티, 하나SK 최대12개월, 롯데 최대 6개월";
			
					int coupon = goods_data[i].getHeight();
					String[] strcoponLayer = getCouponLayerInfo(intShopCode, coupon, (int)lngMinPrice, 1, CouponLayerAry);
					if(strcoponLayer != null){
						strCouponContents = strcoponLayer[0];
						strCouponURL = strcoponLayer[1];
					}
				}
			
				String bigImgShowFlag = "N";
	
				if(!strImgChk.equals("4") && !strImgChk.equals("8") && !strImgChk.equals("9") && !strImgChk.equals("5")) bigImgShowFlag = "Y";
				//out.println("strCa_code="+strCa_code+", strImgChk="+strImgChk);
			
				if(prodStatusTxt.length()==0) {
					if(intMallCnt3==0 && intMallCnt==0) {
						if(strOpenExpectFlag.equals("1") || DateUtil.getDaysBetween(strCdate,DateStr.nowStr())>0) { // 출시예정
							prodStatusTxt = "미정";
						} else { // 품절
							prodStatusTxt = "없음";
						}
			
					} else {
						if(intMallCnt==1 && DateUtil.getDaysBetween(strCdate,DateStr.nowStr())>0) { // 출시예정
							prodStatusTxt = "미정";
						} else if((strOpenExpectFlag.equals("1") || DateUtil.getDaysBetween(strCdate,DateStr.nowStr())>0) && goods_data[i].getIsgroup()!=1) { // 출시예정
							prodStatusTxt = "미정";
							intMallCnt = 0;
							intMallCnt3 = 0;
						} else {
							if((CutStr.cutStr(strCa_code,4).equals("0304") || CutStr.cutStr(strCa_code,4).equals("0305") || CutStr.cutStr(strCa_code,4).equals("0233")) && lngMinPrice3==0) {
								prodStatusTxt = "클릭";
							}
						}
					}
				}
				String intAdNotTopType = "";
			
				out.print("\r\n			\"intAdType\":\""+intAdType+"\", ");
				out.print("\r\n			\"intAdNotTopType\":\""+intAdNotTopType+"\", ");
				out.print("\r\n			\"strConstrain\":\""+strConstrain+"\", ");
				out.print("\r\n			\"strModelNos\":\""+strModelNos+"\", ");
				out.print("\r\n			\"strFactory\":\""+toJS2(strFactory)+"\", ");
				out.print("\r\n			\"strBrand\":\""+toJS2(strBrand)+"\", ");
				out.print("\r\n			\"strModelName\":\""+toJS2(strNewModelnm)+"\", ");
				out.print("\r\n			\"strOpenExpectFlag\":\""+strOpenExpectFlag+"\", ");
				out.print("\r\n			\"intKbNum\":\""+intKbNum+"\", ");
				//out.print("\r\n			\"strImgChkRolling\":\""+strImgChkRolling+"\", ");
				if(intModelNo==0) {
					out.print("\r\n			\"strSpec\":\""+toJS2(strSpec)+"\", "); // 일반 상품일 경우는 shop_code:goodscode
				} else {
					out.print("\r\n			\"strSpec\":\"\", "); // 가격비교 상품은 안씀
				}
				out.print("\r\n			\"strCdate\":\""+strCdate+"\", ");
				out.print("\r\n			\"intSaleCnt\":\""+intSaleCnt+"\", ");
				out.print("\r\n			\"prodStatusTxt\":\""+prodStatusTxt+"\", ");
				out.print("\r\n			\"lngMinPrice\":\""+lngMinPrice+"\", ");
				out.print("\r\n			\"lngMinPrice2\":\""+lngMinPrice2+"\", ");
				out.print("\r\n			\"intMallCnt\":\""+intMallCnt+"\", ");
				out.print("\r\n			\"lngMinPrice3\":\""+lngMinPrice3+"\", ");
				out.print("\r\n			\"intMallCnt3\":\""+intMallCnt3+"\", ");
				//out.print("\r\n			\"strImgChk\":\""+strImgChk+"\", ");
				//out.print("\r\n			\"strImgChk2\":\""+strImgChk2+"\", ");
				//out.print("\r\n			\"strImgChk3\":\""+strImgChk3+"\", ");
				out.print("\r\n			\"bigImgShowFlag\":\""+bigImgShowFlag+"\", ");
				out.print("\r\n			\"intP_Pl_No\":\""+intP_Pl_No+"\", ");
				out.print("\r\n			\"strPImageUrl\":\""+strPImageUrl+"\", ");
				out.print("\r\n			\"strPImageUrlFlag\":\""+strPImageUrlFlag+"\", ");
				out.print("\r\n			\"intGbCnt\":\""+intGbCnt+"\", ");
				//out.print("\r\n			\"strRsiFlag\":\""+strRsiFlag+"\", ");
				out.print("\r\n			\"strAddSale\":\""+strAddSale+"\", ");
				out.print("\r\n			\"strGroupCondiName\":\""+toJS2(strGroupCondiName)+"\", "); // 일반 상품일 경우는  (CASE WHEN p.deliverytype2='1' THEN CASE WHEN p.deliveryinfo2=0 THEN '무료배송' ELSE p.deliveryinfo2||'' END ELSE p.deliveryinfo END) deliveryinfo
				out.print("\r\n			\"strKb_title\":\""+strKb_title+"\", ");
				out.print("\r\n			\"strImageUrl\":\""+strImageUrl+"\", ");
				out.print("\r\n			\"strCopyPhrase\":\""+toJS2(strCopyPhrase)+"\", ");
				out.print("\r\n			\"fltBbsPoint\":\""+fltBbsPoint+"\", ");
				out.print("\r\n			\"strMinPrice\":\""+strMinPrice+"\", ");
				//out.print("\r\n			\"strGoogle_flag\":\""+strGoogle_flag+"\", ");
				//out.print("\r\n			\"strEcatalog_flag\":\""+strEcatalog_flag+"\", ");
				//out.print("\r\n			\"strEcatalog_url\":\""+strEcatalog_url+"\", ");
				out.print("\r\n			\"intPopularOrder\":\""+intPopularOrder+"\", ");
				out.print("\r\n			\"strFactory_etc\":\""+strFactory_etc+"\", ");
				out.print("\r\n			\"strCouponContents\":\""+toJS2(strCouponContents)+"\", ");
				out.print("\r\n			\"strCouponURL\":\""+toJS2(strCouponURL)+"\", ");
				out.print("\r\n			\"systemText\":\""+toJS2(systemText)+"\", ");
			
				// 그룹데이터 설정후 실제로 보여줄 모델을 다시 세팅할 수 있음
				intModelNo = goods_data[i].getModelno();
				strCa_code = goods_data[i].getCa_code();
			
				int[] intModelnosInfoHash = modelnosInfoHash.get(intModelNo);
				String strModelnosKeywordHash = modelnosKeywordHash.get(intModelNo);
				if(intModelnosInfoHash!=null && intModelnosInfoHash.length==3) {
					out.print("\r\n			\"kbnum\":\""+intModelnosInfoHash[1]+"\", ");
					out.print("\r\n			\"eMoneyFlag\":\""+intModelnosInfoHash[2]+"\", ");
				}
				if(strModelnosKeywordHash!=null && strModelnosKeywordHash.length()>0) {
					out.print("\r\n			\"keyword2\":\""+toJS2(strModelnosKeywordHash)+"\", ");
				}
				Goods_Change_Data modelnosInfoOne = groupModelnosInfoHash.get(intModelNo);
	
				if(modelnosInfoOne!=null) {
					String spec_lp_tag = modelnosInfoOne.getSpec_lp_tag();
					String spec_lp_tag2 = modelnosInfoOne.getSpec_lp_tag2();
					String spec_vip_tag = modelnosInfoOne.getSpec_vip_tag();
			
					spec_lp_tag2 = Goods_Search_Lsv.getSpecTagDelLink(spec_lp_tag2);
			
					out.print("\r\n			\"spec_lp_tag\":\""+toJS2(spec_lp_tag)+"\", ");
					out.print("\r\n			\"spec_lp_tag2\":\""+toJS2(spec_lp_tag2)+"\", ");
					out.print("\r\n			\"spec_vip_tag\":\""+toJS2(spec_vip_tag)+"\", ");
				}
			
				out.print("\r\n			\"intModelNo\":\""+intModelNo+"\", ");
				out.print("\r\n			\"strCa_code\":\""+strCa_code+"\", ");
				out.print("\r\n			\"strHotIcon\":\""+strHotIcon+"\", ");
				out.print("\r\n			\"adultYN\":\""+adultYN+"\" ");
			
	
				itemShowCnt++;
			}
			out.print("\r\n		} ]");
		}
	//	out.print(jsonObject); 
	} 
	out.print("\r\n		}");
%>
<%!
	public static boolean numCheck(String str) {
		//영어 + 숫자 + 4자 이상
		Pattern p = Pattern.compile("[A-Za-z][0-9]{4,}");
	    Matcher m = p.matcher(str);
 
	    return m.find();
	}
%>   