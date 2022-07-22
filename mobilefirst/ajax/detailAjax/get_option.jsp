<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.mobile.Mobile_Goods_Proc"%>
<%@ page import="com.enuri.bean.main.Goods_Data"%>
<%@ page import="com.enuri.bean.main.Rental_Model_Proc"%>
<%@ page import="com.enuri.bean.main.Pricelist_Data"%>
<%@ page import="com.enuri.bean.main.Pricelist_Proc"%>
<jsp:useBean id="Mobile_Goods_Proc" class="com.enuri.bean.mobile.Mobile_Goods_Proc" scope="page" />
<jsp:useBean id="Rental_Model_Proc" class="com.enuri.bean.main.Rental_Model_Proc" scope="page" />
<jsp:useBean id="Pricelist_Proc" class="com.enuri.bean.main.Pricelist_Proc" scope="page" />
<%
	int intModelno = ChkNull.chkInt(request.getParameter("modelno"),0);
	int intGroup = ChkNull.chkInt(request.getParameter("group"),0);
	String strPreview = ChkNull.chkStr(request.getParameter("preview"),"0");
	String strCate_LP = ChkNull.chkStr(request.getParameter("cate"),"");	//LP에서만 넘겨줌. 추가분류 구분하기 위한(리스트의 카테고리)
	String strDelivery = ChkNull.chkStr(request.getParameter("delivery"),"0");	//배송비 최저가 옵션
	
	//String strReferer = ChkNull.chkStr(request.getHeader("referer"));	//앱에서 사용시 referer가 없어 다시 막고 배포. 2019-04-04

	//if(strReferer == null || strReferer.equals("") ){
	//	out.println("{}");
	//	return;	
	//}
	
	int intModelno_group = 0;
	//strPreview 1:5개만.
	Goods_Data spec_view = null;
	

	if(intModelno != 0) {
		int intTop_modelno = Mobile_Goods_Proc.get_Topmodelno(intModelno);
		
		//out.println("intTop_modelno>>>"+intTop_modelno);
		spec_view = Mobile_Goods_Proc.Goods_One(intTop_modelno);
		
	}else{
		return;
	}

	String strCa_code = "";
	String strCondiname_org = "";
	
	long mMinPrice = 0;
	long mInstance_price = 0;	//모바일 최저가.
		
	if(spec_view != null){
		strCa_code = spec_view.getCa_code();
		strCondiname_org = spec_view.getCondiname();
		intModelno_group = spec_view.getModelno_group();
		mMinPrice = spec_view.getMinprice();
	}

	if(intModelno_group < 1){
		intModelno_group = intModelno;
	}
	
	//out.println("mMinPrice>>>"+mMinPrice);
	//out.println("mMinPricePC>>>"+mMinPricePC);
	//out.println("mMinPriceMobile>>>"+mMinPriceMobile);

	String strIndividualChangeUnitPrice = "";
	String strIndividualChangeUnitOrg = "";
	String strIndividualChangeUnit = "";
	String strCate2 = "";
	String strCate4 = "";
	String strCate6 = "";
	String strCate8 = "";
	int i;
	String strCondiname = "";
	
	if(strCa_code.length() > 0){
		strCate2 = strCa_code.substring(0,2);
	}
	if(strCa_code.length() > 2){
		strCate4 = strCa_code.substring(0,4);
	}
	if(strCa_code.length() > 4){
		strCate6 = strCa_code.substring(0,6);
	}
	if(strCa_code.length() > 7){
		strCate8 = strCa_code.substring(0,8);
	}
	

	boolean bIndividualChangeUnitModel = false;
	
	int intGoodsDataCnt = 0;
		
	long intDeliveryPrice1=0;//무료배송 최저가
	long intDeliveryPrice2=0;//배송비 포함 가격
	long lngIndividualChangeUnitPrice = 999999999;	
	int iIndividualChangeUnitModelno = 0;
	
	String strCdate2 = "";
	String strViewCdate2 = "";
	long mPriceG = 0;
	String strPrice_g = "";
	String strUnit = "";
	boolean bMobilePrice = false;
	boolean bThismodel = false;
	int intGmodelno = intModelno;  
	int intRankno = 0;
	int intMallcnt = 0;
	String strUnitprice = "";
	String strMinpriceflag = "";
	String strMinpircePcflag = "";
	long lngTlcMinPrice = 0;					// TLC 카드가
	//렌탈여부 판단 (x > 0 = 렌탈모델그룹)
	//long lngRental_price = Rental_Model_Proc.getModelPrice_Group(intModelno_group);
	long lngRental_price = 0;
%>
<%@ include file="/include/IncGroupTool_2010.jsp"%>
<%
	boolean bAdultKeyword = false;
%>
<%@ include file="/include/IncAdultKeywordCheck_2010.jsp" %>
{
<%
//try {

	Goods_Data[] aryCondinameList = null;
	String strRtn_copycate = "";
	
	if(!strCate_LP.equals("")){
		//strRtn_copycate = Mobile_Goods_Proc.get_Copycate(strCate_LP) ;
		//out.println("strRtn_copycate>>>>"+strRtn_copycate);
	}
	if(strRtn_copycate.equals("")){
		strRtn_copycate = "'" +strCate_LP+ "'";
	}

	String strOrderby = "model_sort , condiname";
	
	//if(strDelivery.equals("1")){	//배송비포함 최저가 
	//	strOrderby = "";
	//}
	
	aryCondinameList = Mobile_Goods_Proc.Goods_Group_List(intModelno_group, strOrderby, strRtn_copycate);

	if(aryCondinameList.length == 0){
		aryCondinameList = Mobile_Goods_Proc.Goods_Group_Condiname_List3(intModelno_group, strOrderby);
	}
	
	if (aryCondinameList != null){
		intGoodsDataCnt = aryCondinameList.length;
	}
	String[] astrMinIndividualChangeUnitModelNo = new String[intGoodsDataCnt];
	int intNowGoodsGroupDataLength = aryCondinameList.length;	
		
	if(aryCondinameList != null && aryCondinameList.length > 0) { 
						
		int intNowPos = 0; 
		if (!strCate6.equals("070205")){
			for (int nj=0;nj<aryCondinameList.length;nj++){
				if (aryCondinameList[nj].getUnit().trim().length() > 0 ){
					strIndividualChangeUnitOrg = aryCondinameList[nj].getUnit().trim();
					intNowPos = nj;
					break;
				}
			}		
		}
		
		if (aryCondinameList != null){
			boolean bZero = true;
			boolean bNormal = true;
			for (int nj=0;nj<aryCondinameList.length;nj++){
				if (aryCondinameList[nj].getMinprice() > 0 ){
					bZero = false;
				}
				if (!aryCondinameList[nj].getCondiname().equals("일반") && aryCondinameList[nj].getCondiname().trim().length() > 0){
					bNormal = false;
				}
			}
			if (bZero || bNormal){
				strIndividualChangeUnitOrg = "";
			}		
		}else{
			strIndividualChangeUnitOrg = "";
		}	
		
		strIndividualChangeUnit = strIndividualChangeUnitOrg;

		if (strIndividualChangeUnit.trim().length() > 0 ){
			/*개당 환산가 수정*/
			if (aryCondinameList[intNowPos].getChange() == 1 ){
				strIndividualChangeUnit = strIndividualChangeUnit+"당 최저가";
				//strIndividualChangeUnit = strIndividualChangeUnit;
			}else{
				strIndividualChangeUnit = aryCondinameList[intNowPos].getChange()+ strIndividualChangeUnit+"당 최저가";
				//strIndividualChangeUnit = aryCondinameList[intNowPos].getChange()+ strIndividualChangeUnit;
			}
			if (!(strCa_code.equals("16470704") || strCa_code.equals("16470708"))){
				if(isDeliveryCate(strCa_code)){
					strIndividualChangeUnit = "<em class=\"unit\">*"+strIndividualChangeUnit + "</em>(배송포함)";
				}else{
					strIndividualChangeUnit = "<em class=\"unit\">*"+strIndividualChangeUnit + "</em>(배송미포함)";
				}
			}
	
			bIndividualChangeUnitModel = true;
			if (aryCondinameList != null && aryCondinameList.length == 1 ){
				if (aryCondinameList[0].getCondiname().equals("옵션필수")){
					strIndividualChangeUnit = "";
					bIndividualChangeUnitModel = false;
				}
			}
		}	
					
		if (strIndividualChangeUnit.trim().length() > 0 ){
			strIndividualChangeUnit = ReplaceStr.replace(strIndividualChangeUnit,"배송포함","배송포함");
			strIndividualChangeUnit = ReplaceStr.replace(strIndividualChangeUnit,"배송미포함","배송미포함");
		}else{
			strIndividualChangeUnit = "";
		}
						
		out.println("	\"optionUnit\": \""+ toJS(strIndividualChangeUnit)+"\" ,");
		out.println("	\"optionDetail\": [");
		
		int j = 0;
		int intAllmall = 0;
		
		if(mMinPrice == 0){
			//대표모델을 가지고 왔는데 대표모델의 가격이 0 일때 있는 모델중에서 최저가를 산출
			for (i=0;i<aryCondinameList.length;i++){ 
				if(mMinPrice >= 0){
					mMinPrice = aryCondinameList[i].getMinprice3();
				}
			}
		}
					
		for (i=0;i<aryCondinameList.length;i++){ 
			if (!(aryCondinameList[i].getCondiname().trim().equals("리퍼") || aryCondinameList[i].getCondiname().trim().equals("전시"))){
				if(j==5 && strPreview.equals("1")){
					break;
				}
				strCdate2 = aryCondinameList[i].getC_date();
				strViewCdate2 = DateUtil.RtnDateComment(strCdate2,"2010_list","");
				mPriceG = 0;
				bMobilePrice = false;
				intRankno = aryCondinameList[i].getRankno();
				
				intGmodelno = aryCondinameList[i].getModelno();
				lngTlcMinPrice = aryCondinameList[i].getTlc_min_prc();	
				long lngCashMinPrice = aryCondinameList[i].getCash_min_prc();						// 현금몰 최저가
				String cashflag = aryCondinameList[i].getCash_min_prc_yn();					// 현금몰 최저가 유무
				String ovsflag = aryCondinameList[i].getOvs_min_prc_yn();						// 해외직구 최저가 유무
				
				if(aryCondinameList[i].getTlc_min_prc() > 0){
					mPriceG = aryCondinameList[i].getTlc_min_prc();
				}else if(aryCondinameList[i].getMinprice() < aryCondinameList[i].getMinprice3() || aryCondinameList[i].getMinprice3() == 0){
					mPriceG = aryCondinameList[i].getMinprice3();
				}else{
					mPriceG = aryCondinameList[i].getMinprice3();
					bMobilePrice = true;
				}

				if (strIndividualChangeUnit.trim().length() > 0 && strIndividualChangeUnitOrg.trim().length() > 0 ){
					long lngDeliveryPrice = 0;
					if(isDeliveryCate(strCa_code)){
						lngDeliveryPrice = aryCondinameList[i].getMinprice2();
					}else{
						lngDeliveryPrice = aryCondinameList[i].getMinprice();
					}
					
					//if(i == 0){
					//	out.println("lngDeliveryPrice>>>>"+lngDeliveryPrice);
					//	out.println("aryCondinameList[i].getStandard()>>>>"+aryCondinameList[i].getStandard());
					//	out.println("aryCondinameList[i].getAmount()>>>>"+aryCondinameList[i].getAmount());
					//	out.println("aryCondinameList[i].getChange()>>>>"+aryCondinameList[i].getChange());
					//}
					
					
					/*개별 요약설명 마지막 항목으로 환산가 타이틀 가져오는지 여부*/
					long lngTempIndividualChangeUnitPrice = 0;
					/*개당 환산가 수정*/
					lngTempIndividualChangeUnitPrice = (long)((double)lngDeliveryPrice/(double)(aryCondinameList[i].getStandard()*(double)aryCondinameList[i].getAmount())*(double)aryCondinameList[i].getChange()+0.5);
			    	strIndividualChangeUnitPrice = FmtStr.moneyFormat(lngTempIndividualChangeUnitPrice+"");
			    
			    	if (intNowGoodsGroupDataLength > 0 && lngTempIndividualChangeUnitPrice > 0){
				    	if (lngIndividualChangeUnitPrice == lngTempIndividualChangeUnitPrice){
				    		astrMinIndividualChangeUnitModelNo[i] = astrMinIndividualChangeUnitModelNo[i] + "," + aryCondinameList[i].getModelno(); 
				    	}else if(lngIndividualChangeUnitPrice > lngTempIndividualChangeUnitPrice){
			    			lngIndividualChangeUnitPrice = lngTempIndividualChangeUnitPrice;
			    			iIndividualChangeUnitModelno = aryCondinameList[i].getModelno();
			    			astrMinIndividualChangeUnitModelNo[i] = aryCondinameList[i].getModelno()+"";
			    		}
			    	} 
			    }
			    
			    strCondiname = aryCondinameList[i].getCondiname();
				//strCondiname = ReplaceStr.replace(strCondiname, "특가!", "");
				strCondiname = strCondiname.replace("`","");
				strCondiname = strCondiname.replace("!",""); 
				strCondiname = strCondiname.replace("#","");
				strCondiname = strCondiname.replace("&","");
				if(strCate4.equals("0304") || strCate4.equals("0305") || strCate4.equals("2117") || CutStr.cutStr(strCa_code,8).equals("03532217") ){
					strCondiname = strCondiname.replace(".","");
				}
				if(strCondiname.length() > 1 ) {
					if(strCondiname.substring(0,1).equals(".")){
						strCondiname = strCondiname.substring(1,strCondiname.length());
					}
				}
				//if(strCondiname.equals("일반")){
				//	strCondiname = "기본구성";
				//}

				//단위환산가 & 업체수
				if (strIndividualChangeUnitPrice.trim().length() > 0 && !strIndividualChangeUnitPrice.trim().equals("0")){
					strUnit = strIndividualChangeUnitPrice;
				}else if (strIndividualChangeUnitPrice.trim().length() > 0 && strIndividualChangeUnitPrice.trim().equals("0")){
					strUnit = "";
				}else{
					if(strViewCdate2.equals("예정")){
						strUnit = "0개";
					}else{
						strUnit	= aryCondinameList[i].getMallcnt3() +"개";
					}
				}
				
				//업체수
				intMallcnt = aryCondinameList[i].getMallcnt3();
				//pricelist에 min(instance_price)
				mInstance_price = aryCondinameList[i].getTmp_price();
				
				if(!strIndividualChangeUnitPrice.equals("") && !strIndividualChangeUnitPrice.trim().equals("0")){
					strUnitprice = "<em>"+strIndividualChangeUnitPrice + "</em>원";					
				}else{
					strUnitprice = "";
				}
				strIndividualChangeUnitPrice = "";
				
				//가격
				if(strViewCdate2.equals("예정")){
					strPrice_g = "미정";
				}else if(aryCondinameList[i].getMinprice() == 0 && ( strCate4.equals("0304") || strCate4.equals("0305") || strCate4.equals("0353"))){
					strPrice_g = "별도확인";
					//strPrice_g = toNumFormat(mPriceG) + " 원";
				}else{
					if(lngCashMinPrice > 0 && cashflag.equals("Y")){
						strPrice_g = toNumFormat(lngCashMinPrice) + " 원";	
					}else{
						strPrice_g = toNumFormat(mPriceG) + " 원";	
					}
					if(mPriceG != 0 && mMinPrice > mPriceG  && lngTlcMinPrice==0) {
						mMinPrice = mPriceG;
					}
				}

				if(mMinPrice == mPriceG && mMinPrice > 0){
					strMinpriceflag = "Y";
					//strMinpriceflag = "";
				}else{
					strMinpriceflag = "";
				}
				if(mInstance_price  > mPriceG || aryCondinameList[i].getMallcnt3() == 0){
					strMinpircePcflag = "Y";
				}else{
					strMinpircePcflag = "";
				}

				//현재상품유무
				if(intGmodelno == intModelno && intGroup == 0){
					bThismodel = true;
				}else{
					bThismodel = false;
				}
				
				boolean bDeliveryFlag = false;
				if (strDelivery.equals("1")) {
					//tempPrice = aryCondinameList[i].getMinprice2();
					bDeliveryFlag = true;
				} else {
					//tempPrice = aryCondinameList[i].getMinprice();
					bDeliveryFlag = false;
				}
				
				// 가격 리스트를 저장하는 배열
				Pricelist_Data[] aszPlist = null;
				String deliveryinfo = "";
				int deliveryinfo2 = 0;
				int deliverytype2 = 0;
				
				//배송비 정보
				aszPlist = Pricelist_Proc.Pricelist_DetailMulti_List3("", intGmodelno, "", strCa_code, "", true, 0, bDeliveryFlag);
				if(aszPlist!=null){
					for(int inti=0; inti < aszPlist.length; inti++){
						if(!aszPlist[inti].getOption_flag2().equals("1") ){ 
							deliveryinfo = aszPlist[inti].getDeliveryinfo();
							deliveryinfo2 = aszPlist[inti].getDeliveryinfo2(); 
							deliverytype2 = aszPlist[inti].getDeliverytype2(); 
							break;
						}
					}
				}
				
				String minprice_delivery = "0";
				if(deliveryinfo.equals("무료배송")){
					minprice_delivery = "0";
				}else if(deliveryinfo.equals("착불")){
					minprice_delivery = deliveryinfo;
				}else if(deliveryinfo.equals("유무료") || deliveryinfo.equals("유료")){
					minprice_delivery = "배송비"+deliveryinfo;
				}else if(deliverytype2==1){
					minprice_delivery = deliveryinfo2+"";
				}else{
					if(deliveryinfo.length()<=0){
						minprice_delivery = "0";
					}else{
						minprice_delivery = deliveryinfo;
					}
				}
				
				String strDisplay_deliveryinfo = "";
				
				if(deliveryinfo.equals("무료배송")){
					strDisplay_deliveryinfo = "무료배송";
				}else{
					if(deliverytype2 == 0){
						if (deliveryinfo.equals("")){	//유무료
							strDisplay_deliveryinfo = "유무료";
						}else{
							strDisplay_deliveryinfo = deliveryinfo;
						}
					}else{
						if(deliverytype2 == 1 && deliveryinfo2 == 0){
							strDisplay_deliveryinfo = "무료배송";
						}else{
							strDisplay_deliveryinfo = toNumFormat(Long.parseLong(deliveryinfo2+""))+"원 별도";
						}
					}
				}
				
				String strPrice_Delivery = "";
				long instance_price = 0;
				
				if(!deliveryinfo.equals("무료배송")){
					if(deliverytype2 != 0){
						if(deliverytype2 == 1 && deliveryinfo2 == 0){
						}else{
							if(strDelivery.equals("1")){
								if(lngCashMinPrice > 0){
									strPrice_Delivery = toNumFormat(lngCashMinPrice + Long.parseLong(deliveryinfo2+"")) + " 원";
								}else{
									strPrice_Delivery = toNumFormat(mPriceG + Long.parseLong(deliveryinfo2+"")) + " 원";	
								}
								
							}
						}
					}
				}else{
					strPrice_Delivery = strPrice_g;
				}
				
				String strRental = "";
				//렌탈(월)
				if(strCondiname.indexOf("렌탈(월)") > -1){
					strRental = "Y";
					strPrice_g = toNumFormat(Rental_Model_Proc.getModelPrice(intGmodelno)) + " 원";
				}
				
				if(j>0) out.print(",\r\n");
				out.print("		{ ");
					out.print(" \"optionModelno\":"+ intGmodelno +",");								//현재모델번호
					out.print(" \"optionCondiname\":\""+ toJS(strCondiname) +"\",");				//그룹이름
					out.print(" \"optionPrice\":\""+ toJS(strPrice_g) +"\",");								//가격
					out.print(" \"optionUnitcnt\":\""+ toJS(strUnit) +"\",");								//상품창사용시 사용할 몰수 or 단위환산가
					out.print(" \"optionThis\":"+ bThismodel +" ,");										//현재상품유무
					if(intRankno <= 3){
						out.print(" \"optionRank\":\""+ intRankno +"\",");								//순위
					}else{
						out.print(" \"optionRank\":\"\",");													//순위
					}
					if(intMallcnt > 0){ 
						out.print(" \"optionMallcnt\":\""+ intMallcnt +"\",");							//몰수
					}else{
						out.print(" \"optionMallcnt\":\"\",");												//몰수
					} 
					out.print(" \"optionUnitprice\":\""+ strUnitprice +"\",");							//단위환산가
					out.print(" \"optionCnt\":\""+ aryCondinameList.length +"\",");					//조건 갯수.
					out.print(" \"optionMinpriceflag\":\""+ strMinpriceflag +"\", ");					//최저가 여부
					out.print(" \"optionMinpricePcflag\":\""+ strMinpircePcflag +"\", ");				//PC가격인지 유무
					out.print(" \"optionRentalflag\":\""+ strRental +"\", ");								//렌탈유무
					out.print(" \"delivery_price\" : \""+minprice_delivery+"\", "); 						//최저가 배송비
					out.print(" \"minprice_delivery\" : \""+strPrice_Delivery+"\", "); 					//최저가 배송비+최저가
					out.print(" \"display_deliveryinfo\" : \""+strDisplay_deliveryinfo+"\", "); 		//최저가 배송비+최저가
					
					out.print(" \"lngCashMinPrice\" : \""+lngCashMinPrice+"\", ");
					out.print(" \"cashflag\" : \""+cashflag+"\", ");
					out.print(" \"ovsflag\" : \""+ovsflag+"\", ");
					
					
					out.print(" \"lngTlcMinPrice\" : \""+lngTlcMinPrice+"\" ");
				out.print("   }");
				j++;
				intAllmall += intMallcnt;
			}
		}
		//렌탈모델이면 렌탈 추가
		if(lngRental_price > 0){
			if(aryCondinameList.length>0) out.print(",\r\n");
			out.print("		{ ");
				out.print(" \"optionModelno\":"+ intGmodelno +",");									//현재모델번호
				out.print(" \"optionCondiname\":\"렌탈(월)\",");											//그룹이름
				out.print(" \"optionPrice\":\""+ toNumFormat(lngRental_price) + " 원" +"\",");		//가격
				out.print(" \"optionUnitcnt\":\"\",");														//상품창사용시 사용할 몰수 or 단위환산가
				out.print(" \"optionThis\":false ,");															//현재상품유무
				out.print(" \"optionRank\":\"\",");															//순위
				out.print(" \"optionMallcnt\":\"1\",");														//몰수
				out.print(" \"optionUnitprice\":\"\",");														//단위환산가
				out.print(" \"optionCnt\":\"\",");															//조건 갯수.
				out.print(" \"optionMinpriceflag\":\"\", ");												//최저가 여부
				out.print(" \"optionMinpricePcflag\":\"\", ");												//PC가격인지 유무
				out.print(" \"optionRentalflag\":\"true\", ");												//렌탈유무
				out.print(" \"delivery_price\" : \"\", "); 													//최저가 배송비
				out.print(" \"minprice_delivery\" : \"\", "); 												//최저가 배송비+최저가
				out.print(" \"display_deliveryinfo\" : \"\", "); 												//최저가 배송비+최저가
				out.print(" \"lngCashMinPrice\" : \"\", ");											// 현금몰 최저가
				out.print(" \"cashflag\" : \"\", ");												// 현금몰 최저가 유무
				out.print(" \"ovsflag\" : \"\", ");													// 해외직구 최저가 유무
				out.print(" \"lngTlcMinPrice\" : \"\" ");											// TLC카드 최저가
			out.print("   }");
		}
		
		out.println("\r\n	]");
		out.println(" , \"optionUnitBestModel\":\""+ iIndividualChangeUnitModelno +"\" ");
		out.println(" , \"optionAllmallCnt\":\""+ intAllmall +"\" ");
		out.println(" , \"optionMinprice\":\""+ mMinPrice +"\" ");
	}


	/*
	Goods_Spec_Detail_Data[] spec_list = null;
	spec_list = Goods_Spec_Detail_Proc.get_list(intModelno);
	
	if(spec_list != null && spec_list.length > 0){
		out.println("	\"detailSpec\": [");
		for(int i=0;i<spec_list.length; i++) {
			if(i>0) out.print(",\r\n");
			out.print("		{ \"specTitle\":\""+spec_list[i].getTitle()+"\", \"specContent\":\""+spec_list[i].getContent()+"\" }");
		}
		out.println("\r\n	]");
	}
	*/
//} catch(Exception e) {
//}
%>
}