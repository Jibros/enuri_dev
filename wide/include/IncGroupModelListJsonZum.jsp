<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONObject"%>
<%
HashMap<Integer, HashMap<String,Object>> groupModelListMap = new HashMap<Integer, HashMap<String,Object>>();
HashMap<String,Object> groupDataMap = new HashMap<String,Object>();

//20191219 현금몰 가격 보완 처리
long lngCalcCashPrice = 0;
String strCalcTlcMinPrcYn = "N";
if(goods_data!=null && goods_data.length>0) {
	for(int i=0;i<goods_data.length;i++) {
		
		groupDataMap = new HashMap<String,Object>();
		
		String strCa_code = goods_data[i].getCa_code();
		
		///////////////////////////////////////////////////////////////////////////////////////////
		//////////////////////////그룹 모델 처리 시작 ///////////////////////////////////////
		//////////////////////////////////////////////////////////////////////////////////////////
		Goods_Data[] now_goods_group_data = null;
		
		// 전체 카테 노출 제외
		String[] noMinpriceTxt = null;
		// 특정 카테 노출 제외 예외1
		String[] noMinpriceTxtCate1 = null;
		String[] noMinpriceCateCode1 = null;
		
		// 스폰서나 인포애드에서 제한 하는 항목들
		// 테스트
		String[] noAdMinpriceTxt = { "리퍼,중고","중고품", "A급리퍼", "S급리퍼", "렌탈" }; // 실섭 배포용
		//String[] noAdMinpriceTxt = { "리퍼,중고","중고품" }; // 테스트용

		if(goods_data[i].getIsgroup()==1) {
			ArrayList arrayListGoods_group = new ArrayList();
			ArrayList arrayListGoods_group_c1 = new ArrayList();
			ArrayList arrayListGoods_group_c2 = new ArrayList();
	
			if(goods_all_group_data!=null) {
				for(int ai=0; ai<goods_all_group_data.length; ai++) {
					if(goods_data[i].getModelno()==goods_all_group_data[ai].getModelno_group()) {
						boolean bEquals = false;
						arrayListGoods_group_c1.add(goods_all_group_data[ai]);
					}
				}
			}
			
			arrayListGoods_group.addAll(arrayListGoods_group_c1);
			arrayListGoods_group.addAll(arrayListGoods_group_c2);
			if(arrayListGoods_group.size()>0) {
				now_goods_group_data = (Goods_Data[])arrayListGoods_group.toArray(new Goods_Data[0]);
			} else {
				now_goods_group_data = new Goods_Data[1];
				now_goods_group_data[0] = goods_data[i];
			}
		} else {
			now_goods_group_data = new Goods_Data[1];
			now_goods_group_data[0] = goods_data[i];
		}
		
		Integer intGoodsGroupPopular[][] = new Integer[3][2];
		int intNowGoodsGroupDataLength = (goods_data[i].getModelno() == 0) ? 0 : now_goods_group_data.length;
	
		for(int j=0; j<intNowGoodsGroupDataLength; j++) {
			if(!(now_goods_group_data[j].getCondiname().indexOf("리퍼")>=0 || now_goods_group_data[j].getCondiname().indexOf("전시")>=0 || 
				now_goods_group_data[j].getCondiname().indexOf("옵션필수")>=0)) {
				
				if(intGoodsGroupPopular[0][1]==null) {
					intGoodsGroupPopular[0][0] = now_goods_group_data[j].getModelno();
					intGoodsGroupPopular[0][1] = now_goods_group_data[j].getPopular();
				} else if(intGoodsGroupPopular[1][1]==null) {
					if(intGoodsGroupPopular[0][1]<now_goods_group_data[j].getPopular()) {
						intGoodsGroupPopular[1][0] = intGoodsGroupPopular[0][0];
		  				intGoodsGroupPopular[1][1] = intGoodsGroupPopular[0][1];
						intGoodsGroupPopular[0][0] = now_goods_group_data[j].getModelno();
						intGoodsGroupPopular[0][1] = now_goods_group_data[j].getPopular();
					} else {
						intGoodsGroupPopular[1][0] = now_goods_group_data[j].getModelno();
						intGoodsGroupPopular[1][1] = now_goods_group_data[j].getPopular();
					}
				} else if (intGoodsGroupPopular[2][1]==null) {
					if(intGoodsGroupPopular[0][1]<now_goods_group_data[j].getPopular()) {
						intGoodsGroupPopular[2][0] = intGoodsGroupPopular[1][0];
		  				intGoodsGroupPopular[2][1] = intGoodsGroupPopular[1][1];
						intGoodsGroupPopular[1][0] = intGoodsGroupPopular[0][0];
		  				intGoodsGroupPopular[1][1] = intGoodsGroupPopular[0][1];
						intGoodsGroupPopular[0][0] = now_goods_group_data[j].getModelno();
						intGoodsGroupPopular[0][1] = now_goods_group_data[j].getPopular();
					} else if(intGoodsGroupPopular[1][1]<now_goods_group_data[j].getPopular()) {
						intGoodsGroupPopular[2][0] = intGoodsGroupPopular[1][0];
		  				intGoodsGroupPopular[2][1] = intGoodsGroupPopular[1][1];
						intGoodsGroupPopular[1][0] = now_goods_group_data[j].getModelno();
						intGoodsGroupPopular[1][1] = now_goods_group_data[j].getPopular();
					} else {
			  			intGoodsGroupPopular[2][0] = now_goods_group_data[j].getModelno();
			  			intGoodsGroupPopular[2][1] = now_goods_group_data[j].getPopular();
					}
				} else if(intGoodsGroupPopular[0][1] < now_goods_group_data[j].getPopular()) {
					if(intGoodsGroupPopular[1][1]!=null) {
						intGoodsGroupPopular[2][0] = intGoodsGroupPopular[1][0];
						intGoodsGroupPopular[2][1] = intGoodsGroupPopular[1][1];
					}
					intGoodsGroupPopular[1][0] = intGoodsGroupPopular[0][0];
					intGoodsGroupPopular[1][1] = intGoodsGroupPopular[0][1];
					intGoodsGroupPopular[0][0] = now_goods_group_data[j].getModelno();
					intGoodsGroupPopular[0][1] = now_goods_group_data[j].getPopular();
				} else if (intGoodsGroupPopular[1][1]!=null && intGoodsGroupPopular[1][1]<now_goods_group_data[j].getPopular()) {
					intGoodsGroupPopular[2][0] = intGoodsGroupPopular[1][0];
					intGoodsGroupPopular[2][1] = intGoodsGroupPopular[1][1];
					intGoodsGroupPopular[1][0] = now_goods_group_data[j].getModelno();
					intGoodsGroupPopular[1][1] = now_goods_group_data[j].getPopular();
				} else if(intGoodsGroupPopular[2][1]!=null && intGoodsGroupPopular[2][1]<now_goods_group_data[j].getPopular()) {
					intGoodsGroupPopular[2][0] = now_goods_group_data[j].getModelno();
					intGoodsGroupPopular[2][1] = now_goods_group_data[j].getPopular();
				}
			}
		}
		
		int int15j = 0;
		int intPopj = 0;
		int intRepj = 0;
		boolean b15j = true;
		int intTempPopular = 0;
		int intPopularModelNo = 0;
		int intResizeModelNo = 0;
		for(int j=0; j<intNowGoodsGroupDataLength; j++) {
			if(now_goods_group_data[j].getPopular()>=intTempPopular) {
				intPopularModelNo = now_goods_group_data[j].getModelno();
				intTempPopular = now_goods_group_data[j].getPopular();
				intPopj = j;
			}
			if(now_goods_group_data[j].getRsiflag2().equals("1")) {
				intResizeModelNo = now_goods_group_data[j].getModelno();
			}
			if(now_goods_group_data[j].getP_pl_no()>0 && now_goods_group_data[j].getP_imgurlflag().equals("1") && b15j) {
				int15j = j;
				b15j = false;
			}
			if(now_goods_group_data[j].getModelno()==goods_data[i].getModelno()) {
				intRepj = j;
			}
		}
		
		String strIndividualChangeUnitOrg = "";
	
		int intNowPos = 0;
	
		if(now_goods_group_data != null) {
			boolean bZero = true;
			boolean bNormal = true;
			for(int nj=0;nj<intNowGoodsGroupDataLength;nj++) {
				if(now_goods_group_data[nj].getMinprice()>0) {
					bZero = false;
				}
				if(!now_goods_group_data[nj].getCondiname().equals("일반") && now_goods_group_data[nj].getCondiname().trim().length()>0) {
					bNormal = false;
				}
			}
			if(bZero || bNormal) {
				strIndividualChangeUnitOrg = "";
			}
		} else {
			strIndividualChangeUnitOrg = "";
		}
		String strIndividualChangeUnit = strIndividualChangeUnitOrg;
		String strOverTitle = "";
		String strArrowTitle = "";
	
		if(strIndividualChangeUnit.trim().length()>0) {
			if(now_goods_group_data[intNowPos].getChange()==1) {
				strIndividualChangeUnit = strIndividualChangeUnit + "당가격";
			} else {
				strIndividualChangeUnit = now_goods_group_data[intNowPos].getChange() + strIndividualChangeUnit+"당가격";
			}
		}
	
		int intGroup_Count = 0;
		HashMap h_popular = new HashMap();
		int intMorelessCnt = 0;
	
		long lngIndividualChangeUnitPrice = 999999999;
		boolean bGrayBlank = false;
		boolean bNoBorder = false;
		boolean bCty = false;
	
		int showGroupCnt = 0;
	
		// 인기 순위로 정렬하기 위해 저장하는 인기순위
		int groupOrderPopular = 0;
		int k = 0;
	
		arrGroupModel = new ArrayList<JSONObject>();
	
		// 모델별 최저가 가격을 저장하는 맵 <모델번호, 가격>
		HashMap<Integer, Object> minPriceMap = new HashMap<Integer, Object>();
		long lngTmpMinPrice = 0;
		int intMutilModelNoGroup = 0;
		
		// 모델별 단위당 최저가 가격을 저장하는 맵 <모델번호, 단위당 최저가> 
		HashMap<Integer, Object> minUnitPriceMap = new HashMap<Integer, Object>();
		long lngTmpMinUnitPrice = 0;
		
		// 태그정보들을 저장하는 객체
		Map<String, Object> groupTagAttr = null;
		
		if(intNowGoodsGroupDataLength>0) {
			for(int j=0; j<intNowGoodsGroupDataLength; j++) {
				
				JSONObject objGroupData = new JSONObject();
				groupTagAttr = new HashMap<String, Object>();
				
				strCa_code = now_goods_group_data[j].getCa_code();
			
				intGroup_Count = intGroup_Count+1;
				int intMutilModelNo = now_goods_group_data[j].getModelno();
				intMutilModelNoGroup = now_goods_group_data[j].getModelno_group();
				long lngMutilModelMinPrice = now_goods_group_data[j].getMinprice3();
				
				// 배송비 포함체크 시 minPrice2 로 변경
				if(strIsDelivery.equals("Y")) {
					//lngMutilModelMinPrice = now_goods_group_data[j].getMinprice2();
				}
				if (CutStr.cutStr(strCa_code,6).trim().equals("210813") || CutStr.cutStr(strCa_code,4).trim().equals("1803") || CutStr.cutStr(strCa_code,4).trim().equals("2131")){
					strIsDelivery = "N";
				}else{
					strIsDelivery = "Y";
				}
				
				if(now_goods_group_data[j].getOpenexpectflag().equals("1")) {
					lngMutilModelMinPrice = 0;
					now_goods_group_data[j].setMallcnt(0);
					now_goods_group_data[j].setMallcnt3(0);
				}
				String strMoreViewClass = "";
			
				String strOrderTag = "";
				String strOrderTagStyle = "";
			
				if(intGoodsGroupPopular[0][0]!=null && intMutilModelNo==intGoodsGroupPopular[0][0] && intNowGoodsGroupDataLength>=3) {
					strOrderTag = "1";
				} else if(intGoodsGroupPopular[1][0]!=null &&intMutilModelNo==intGoodsGroupPopular[1][0] && intNowGoodsGroupDataLength>=4) {
					strOrderTag = "2";
				} else if(intGoodsGroupPopular[2][0]!=null && intMutilModelNo==intGoodsGroupPopular[2][0] && intNowGoodsGroupDataLength>=8) {
					strOrderTag = "3";
				}
			
				String strCondiname = now_goods_group_data[j].getCondiname();
				if(strCate4.equals("0235") || strCate4.equals("0363")) {
					if(strCondiname.indexOf("!")==0) {
						strCondiname = strCondiname.substring(1,strCondiname.length());
					}
				}
			
				String strBeginnerDicCondiname = strCondiname;
			
				strBeginnerDicCondiname = replaceSpecialCharacter(strCate4,strBeginnerDicCondiname);
				if(strCate4.equals("0235") || strCate4.equals("0242") || strCate4.equals("0901")) {
					strBeginnerDicCondiname = ReplaceStr.replace(strBeginnerDicCondiname,"!"+strCondiname,strCondiname);
				}
				if(strCate4.equals("1010") || strCate4.equals("0363")) {
					strBeginnerDicCondiname = ReplaceStr.replace(strBeginnerDicCondiname,"."+strCondiname,strCondiname);
				}
			
				String strIndividualChangeUnitPrice = "";
				String strGoodsGroupMinPrice = "";
			
				String strGroupCdate = now_goods_group_data[j].getC_date();
				strGroupCdate = CutStr.cutStr(strGroupCdate,10);
				int intMinusMallCnt = 0;
			
				if(now_goods_group_data[j].getMallcnt()==0 && now_goods_group_data[j].getMallcnt3()==0) {
					if(now_goods_group_data[j].getOpenexpectflag().equals("1") || DateUtil.getDaysBetween(strGroupCdate,DateStr.nowStr())>0) {
						strGoodsGroupMinPrice = "미정";
					} else {
						strGoodsGroupMinPrice = "없음";
					}
				} else {
					if(now_goods_group_data[j].getMallcnt()==1 && DateUtil.getDaysBetween(strGroupCdate,DateStr.nowStr())>0) {
						strGoodsGroupMinPrice = "미정";
						intMinusMallCnt = 1;
					} else if((now_goods_group_data[j].getOpenexpectflag().equals("1") || DateUtil.getDaysBetween(strGroupCdate,DateStr.nowStr())>0) && goods_data[i].getIsgroup()!=1) {
						strGoodsGroupMinPrice = "미정";
						now_goods_group_data[j].setMallcnt(0);
						now_goods_group_data[j].setMallcnt3(0);
					} else {
						if(now_goods_group_data[j].getCondiname().trim().equals("렌탈(월)")) { //렌탈상품 옵션가격으로 변경처리, 추후 서비스시에 "렌탈(월)"로변경
							lngMutilModelMinPrice = rental_model_proc.getModelPrice(intMutilModelNo);
							strGoodsGroupMinPrice = lngMutilModelMinPrice + now_goods_group_data[j].getRsiflag();
						} else {
							strGoodsGroupMinPrice = formatter.format(lngMutilModelMinPrice);
						}
					}
				}
				
				if (now_goods_group_data[j].getOpenexpectflag().equals("1")){
					objGroupData.put("isexpect","Y");
				}else{
					objGroupData.put("isexpect","N");
				}
			
				// 성인구분 넣어줘야함
				String strSmallImg = "";
				now_goods_group_data[j].setAdultChk(IsAdultFlag);
				strSmallImg = ImageUtil_lsv.getImageSrc(now_goods_group_data[j]);
				//objGroupData.put("strSmallImg", strSmallImg);
				
				long longMinprice = now_goods_group_data[j].getMinprice();
				long longMinprice2 = now_goods_group_data[j].getMinprice2();
				int intMallcnt = now_goods_group_data[j].getMallcnt();
				long longMinprice3 = now_goods_group_data[j].getMinprice3();
				int intMallcnt3 = now_goods_group_data[j].getMallcnt3();
				int intSale_cnt = now_goods_group_data[j].getSale_cnt();
				String strCdate2 = now_goods_group_data[j].getC_date();
				strCdate2 = CutStr.cutStr(strCdate2,10);
			
				// 배송 포함가
				long lngDeliveryPrice = now_goods_group_data[j].getMinprice2();
			
				// 광고 일 경우 보여줄 조건명에 제한을 둠
				if(goods_data[i].getAdType().length()>0 && noAdMinpriceTxt!=null && noAdMinpriceTxt.length>0) {
					boolean IsGroupShow = true;
					for(int ai=0; ai<noAdMinpriceTxt.length; ai++) {
						if(noAdMinpriceTxt[ai].equals(strBeginnerDicCondiname)) {
							IsGroupShow = false;
							break;
						}
					}
			
					if(!IsGroupShow) continue;
				}
				
				// 20191106 현금몰 & 해외직구 관련 필드 추가 jinwook
				// lngCashMinPrice ( 현금최저가 )
				// strCashMinFlag ( 현금최저가여부 )
				// strOvsMinFlag ( 해외최저가여부 ) 
				long lngCashMinPrice = now_goods_group_data[j].getCash_min_prc();
				String strCashMinFlag = now_goods_group_data[j].getCash_min_prc_yn();
				String strOvsMinFlag =  now_goods_group_data[j].getOvs_min_prc_yn();
			
				// 20191219 현금몰 가격 보완 처리
				// 현금몰 구분플래그 가 Y 이면서 저장된 값이 0 원이거나 저장된 값보다 작을 경우 해당 값을 세팅한다.
				if(strCashMinFlag.equals("Y") && ( lngCalcCashPrice == 0 || lngCalcCashPrice > lngCashMinPrice ) ) {
					goods_data[i].setCalc_cash_min_prc_yn("Y");
					goods_data[i].setCalc_cash_min_prc(lngCashMinPrice);
				}
				
				// #46975 [PC/MW/APP] 현금몰 최저가 노출 제외 요청
				if(strCashMinFlag.equals("Y") && strGoodsGroupMinPrice.equals("0") && lngCashMinPrice>0) {
					strGoodsGroupMinPrice = formatter.format(lngCashMinPrice);
				}
				/* 
				// 태그정보 추가
				if(strCashMinFlag.equals("Y")) {
					JSONObject cashObject = new JSONObject();
					cashObject.put("price", formatter.format(lngCashMinPrice));
					groupTagAttr.put("cash", cashObject); // 현금몰"
				}
				*/
				
				if(strOvsMinFlag.equals("Y")) {
					groupTagAttr.put("ovs", new JSONObject()); // 해외직구
				}
				
				// 20191126 TLC 카드 할부 추가 jinwook 
				// 2020년 부로 TLC 는 사라졌지만, 위와 같은 목적으로 재활용
				// lngTlcMinPrice ( TLC카드할부가 )
				long lngTlcMinPrice = now_goods_group_data[j].getTlc_min_prc();
			
				Goods_Change_Data groupModelnosInfoOne = groupModelnosInfoHash.get(intMutilModelNo);
				
				long unitPrice = 0;
				String unit = "";
				int change = 0;
				long unitPriceTxt = 0;
				int standard = 0;
				if(groupModelnosInfoOne!=null && goods_data[i].getIsgroup()==1) {
					int modelno = groupModelnosInfoOne.getModelno();
					standard = groupModelnosInfoOne.getStandard();
					int amount = groupModelnosInfoOne.getAmount();
					String all_component = groupModelnosInfoOne.getAll_component();
					change = groupModelnosInfoOne.getChange();
					unit = groupModelnosInfoOne.getUnit();
					unitPrice = 0;
	
					if(standard>0 && amount>0 && change>0) {
					
						// 개당환산가를 배송비 포함으로 계산
						if(strIsDelivery.equals("Y")) {
							lngDeliveryPrice = now_goods_group_data[j].getMinprice2();
						} else {
							lngDeliveryPrice = now_goods_group_data[j].getMinprice();
						}
	
						long lngTempIndividualChangeUnitPrice = lngTempIndividualChangeUnitPrice = (long)((double)lngDeliveryPrice/(double)(standard*(double)amount)*(double)change+0.5);
	
						unitPrice = lngTempIndividualChangeUnitPrice;
						unitPriceTxt =  (long)((double)now_goods_group_data[j].getMinprice()/(double)(standard*(double)amount)*(double)change+0.5);
					}
				}
						
				// 최저가 보정, 랜탈과 중고가 아닌 상품중에서 가장 최저가
				if((now_goods_group_data.length==1) || (showGroupCnt==0 || (showGroupCnt>0 && goods_data[i].getMinprice3()>now_goods_group_data[j].getMinprice3()))) {
					goods_data[i].setModelno(now_goods_group_data[j].getModelno());
					goods_data[i].setMinprice(now_goods_group_data[j].getMinprice());
					goods_data[i].setMinprice2(now_goods_group_data[j].getMinprice2());
					goods_data[i].setMinprice3(now_goods_group_data[j].getMinprice3());
					goods_data[i].setImgchk(now_goods_group_data[j].getImgchk());
					goods_data[i].setImgchk2(now_goods_group_data[j].getImgchk2());
					goods_data[i].setImgchk3(now_goods_group_data[j].getImgchk3());
					goods_data[i].setP_imgurl(now_goods_group_data[j].getP_imgurl());
					goods_data[i].setP_imgurl2(now_goods_group_data[j].getP_imgurl2());
					goods_data[i].setP_imgurlflag(now_goods_group_data[j].getP_imgurlflag());
					goods_data[i].setMallcnt(now_goods_group_data[j].getMallcnt());
					goods_data[i].setCondiname(now_goods_group_data[j].getCondiname());			
					goods_data[i].setMallcnt3(now_goods_group_data[j].getMallcnt3());
					if(now_goods_group_data[j].getCa_code().length()>0) goods_data[i].setCa_code(now_goods_group_data[j].getCa_code());
					goods_data[i].setP_pl_no(now_goods_group_data[j].getP_pl_no());
		
					showGroupCnt++;
				}
				
				// 단위당 환산가 정보
				if(j==0) {
					//objGroupData.put("change", String.valueOf(change));
				
					//상품 뱃지 관련 리스트 (유동 데이터)
					if(CutStr.cutStr(goods_data[i].getCa_code(),6).equals("163604") && standard > 0 && unitPriceTxt > 0) {
						String unitPriceMsg = formatter.format(change) + unit + "당 " + formatter.format(unitPriceTxt) + "원";
						objGroupData.put("unitPriceMsg", unitPriceMsg);
					}
				}
				//objGroupData.put("unitprice",formatter.format(strIndividualChangeUnit));
				if(change>0){
					objGroupData.put("unit", String.valueOf(change)+unit+"당");
				}else{
					objGroupData.put("unit", "");
				}
				if(unitPrice>0){
					objGroupData.put("unitprice",formatter.format(unitPrice).replaceAll("\\,", ""));
				}else{
					objGroupData.put("unitprice","");
				}
				objGroupData.put("isdelivery",strIsDelivery);
				//objGroupData.put("strRank",strOrderTag);
				//objGroupData.put("strModelNo",String.valueOf(intMutilModelNo));
				String strLandingUrl = "http://www.enuri.com/move/zumRedirect.jsp?modelno="+String.valueOf(intMutilModelNo);
				objGroupData.put("op_landingurl",strLandingUrl);
				/*if(intMutilModelNo==intMutilModelNoGroup) {
					objGroupData.put("strModelNoRepYN","Y");
				} else {
					objGroupData.put("strModelNoRepYN","N");
				}*/
				
				// 임시 가격 , 해당 그룹모델에 대한 최저가를 알아내기 위함.
				if(lngTmpMinPrice==0 || lngMutilModelMinPrice<lngTmpMinPrice) {
					lngTmpMinPrice = lngMutilModelMinPrice;
				}
				objGroupData.put("price",strGoodsGroupMinPrice.replaceAll("\\,", ""));
				objGroupData.put("intTmpPrice",lngMutilModelMinPrice);
				//objGroupData.put("strMinPriceYN","N"); // 초기값
				//objGroupData.put("tag", groupTagAttr); // 태그정보
				
				String strTmpCate4 = strCa_code;
				if(strTmpCate4 != null && strTmpCate4.length() >=4){
					strTmpCate4 = strTmpCate4.substring(0,4);
				}
				
				HashMap<String,Integer> intermdictitle_data  = tHashMap.get(strTmpCate4);
				
				/*if(intermdictitle_data != null){
					if(intermdictitle_data.containsKey(strBeginnerDicCondiname)){
						objGroupData.put("strDicKbNo",String.valueOf(intermdictitle_data.get(strBeginnerDicCondiname)));
					}else{
						objGroupData.put("strDicKbNo","0");
					}	
				}else{
					objGroupData.put("strDicKbNo","0");
				}*/
				objGroupData.put("condiname",toJS2(strBeginnerDicCondiname));
	
				
				// 모바일최저가 여부 (PC에서 사용 )
				String strMobileMinPriceYn = "N";
				if(intMallcnt==0 && intMallcnt3!=0) {
					strMobileMinPriceYn = "Y";
				}
				if(intMallcnt!=0 && intMallcnt3!=0 && longMinprice3<longMinprice) {
					strMobileMinPriceYn = "Y";
				}
				//objGroupData.put("strMobileMinPriceYn", strMobileMinPriceYn);
				
				String strMallCnt = "";
				if(strDevice.equals("pc")) {
					strMallCnt = String.valueOf(intMallcnt);
					if(intMallcnt3>9999) {
						strMallCnt = "9999+";
					}
				} else {
					strMallCnt = String.valueOf(intMallcnt3);
				}
				objGroupData.put("op_mallcnt",strMallCnt);
				
				// 해당 그룹모델에 대한 단위당 환산가 최저가를 구한다. 
				if(lngTmpMinUnitPrice==0 || unitPrice<lngTmpMinUnitPrice) {
					lngTmpMinUnitPrice = unitPrice;
				}
				objGroupData.put("intTmpUnitPrice",unitPrice);
				//objGroupData.put("strMinUnitPriceYN","N"); // 초기값
				
				// 찜 선택 여부
				String strGroupZzimYN = "N";
				if(zzimModelSet.contains(intMutilModelNo)) {
					strGroupZzimYN = "Y";
				}
				//objGroupData.put("strZzimYN",strGroupZzimYN);
				
				// 그룹모델 내 이미지형태 광고 여부 
				if(intMutilModelNo==71706645 || intMutilModelNo==71706625) {
					JSONObject imageADObject = new JSONObject();
					imageADObject.put("modelno", String.valueOf(intMutilModelNo));
					imageADObject.put("url", "http://img.enuri.info/images/rev/ad_brand_samsung.png");
					groupDataMap.put("groupImageAD",imageADObject);
				}
				
				arrGroupModel.add(objGroupData);
			}
			
			// 모델 별 최저가를 저장
			minPriceMap.put(intMutilModelNoGroup, lngTmpMinPrice);
			
			// 옵션 들을 순회하면서 최저가여부를 체크 
			JSONObject tmpPriceParseObj = null;
			if(arrGroupModel.size()>0) {
				List<JSONObject> arrParseGroupModel = new ArrayList<JSONObject>();
				
				for(int m=0;m<arrGroupModel.size();m++) {
					tmpPriceParseObj = arrGroupModel.get(m);
					// 최저가 여부
					long parseTmpPrice = Long.valueOf(String.valueOf(tmpPriceParseObj.get("intTmpPrice")));
					if(parseTmpPrice==lngTmpMinPrice && lngTmpMinPrice>0) {
						//tmpPriceParseObj.put("strMinPriceYN","Y");
					}
					// 단위당 환산가
					long parseTmpUnitPrice = Long.valueOf(String.valueOf(tmpPriceParseObj.get("intTmpUnitPrice")));
					if(parseTmpUnitPrice==lngTmpMinUnitPrice && lngTmpMinUnitPrice>0) {
						//tmpPriceParseObj.put("strMinUnitPriceYN","Y");
					}
					tmpPriceParseObj.remove("intTmpPrice");
					tmpPriceParseObj.remove("intTmpUnitPrice");
					arrParseGroupModel.add(tmpPriceParseObj);
				
				}
				
				groupDataMap.put("list", arrParseGroupModel);
			} else {
				groupDataMap.put("list", arrGroupModel);
			}
			
			// 옵션 뷰 모드 ( model : 옵션정보, shop : 쇼핑몰최저가정보, '' : 비노출  )
			String strTmpOptionViewType = "";
			if(arrGroupModel.size()>0 && goods_data[i].getCondiname().length()>0) {
				strTmpOptionViewType = "model";
			} else if(goods_data[i].getMallcnt3()>0) {
				strTmpOptionViewType = "shop";
			}
			groupDataMap.put("optionViewType", strTmpOptionViewType);
			
			groupModelListMap.put(goods_data[i].getModelno(), groupDataMap);
		}
		///////////////////////////////////////////////////////////////////////////////////////////
		////////////////////////// 그룹 모델 처리 끝 /////////////////////////////////////////
		//////////////////////////////////////////////////////////////////////////////////////////
	}
}
%>