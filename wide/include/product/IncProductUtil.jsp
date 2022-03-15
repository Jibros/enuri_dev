<%@ page import="com.enuri.bean.main.Factory_Certification_Proc"%>
<%!
	//특수문자 제거 하기
	public static String StringReplace(String str){
		String match = "[\\p{Cc}\\p{Cf}\\p{Co}\\p{Cn}\\p{Cs}]";
		str =str.replaceAll(match, " ");
		return str;
	}

	/* public static String getDate() {
		DecimalFormat df = new DecimalFormat("00");
		Calendar calendar = Calendar.getInstance();

		String year = Integer.toString(calendar.get(Calendar.YEAR)); //년도를 구한다
		String month = df.format(calendar.get(Calendar.MONTH) + 1); //달을 구한다
		String day = df.format(calendar.get(Calendar.DATE)); //날짜를 구한다
		String date = month+"월" + day+"일"; 

		return date;
	} */

	public static String toDateText(String str, String strSearch){	//목록에서 사용하는 날짜(출시일)
		Calendar cal = Calendar.getInstance();
		if(str.length()==10) {
			String nowYear = cal.get(cal.YEAR) + "";

			// 현재 년도랑 같을 경우에만  년, 월로 표시
			if(str.substring(0, 4).equals(nowYear)) {
				str = str.substring(2, 7);
				if(strSearch.equals("Y")) {
					str = "'" + ReplaceStr.replace(str, "-0", "년 ") + "월";
				} else {
					str = "'" + ReplaceStr.replace(str, "-0", "년 ") + "월 출시";
				}
			} else {
				if(strSearch.equals("Y")) {
					str = str.substring(2, 4) + "년";
				} else {
					str = str.substring(2, 4) + "년 출시";
				}
			}
		}
		return str;
	}

	// ************************************************************************************************
	// pricelist를 가져오기 위한 함수들
	public String replaceModelNmSpecialCharJson(String strCate, String strModelNm) {
		strModelNm = ChkNull.chkStr(strModelNm,"");
		strCate = ChkNull.chkStr(strCate,"");
		String strReturn = strModelNm;
		strReturn = strReturn.replaceAll("'","`");
		strReturn = strReturn.replaceAll("(`|!|#|[*])]","]");
		strReturn = strReturn.replaceAll("\\[일반\\]","==");
		if(CutStr.cutStr(strCate,4).equals("0304") || CutStr.cutStr(strCate,4).equals("0305") || CutStr.cutStr(strCate,4).equals("0363") || CutStr.cutStr(strCate,8).equals("02332217")) {
			strReturn = ReplaceStr.replace(strReturn,"[,","[");
			strReturn = ReplaceStr.replace(strReturn,"[.","[");
		}
		return strReturn;
	}

	
	boolean IsOptionCompCate(String szCategory) {
		boolean optionCompCateFlag = false;
		if(ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,4),"0201","0355","0356","0353","0211","0212","0214","0218","0354","0222","0691","0318",
			"0401","0402","0405","0408","0513","0514","0712","1005","1007","1020","1213","2113",
			"0352","0908","0401","0905","0702","0217","0705","0710","0903","0313","0404","0919","0920","0503","0602",
			"0692","0410","0515","0519","0526","0610","0609","0605",
			"2101","2103","2104","2105","2106","2109","2114","2117","2120","1001","1003",
			"0801","0802","0803","0804","0810","0907","0925","0929",
			"1202","1205","1207","1204","1208","1602","1605","1225","1629","1635",
			"0210","0502","0505","0510","0606","0608","0620","0704","0806","0807","0904","0909","0912",
			"0913","0923","0924","1004","1009","1012","1219","1625","1626","1632","2108",
			"1614","0504","0305","0335",
			//2020-03-10 카테고리 변경작업.shwoo. 0807 > 1654 ,1602 > 2144,1635 > 2145
			"1654","2144","2145"
			})) {
			optionCompCateFlag = true;
		}
		optionCompCateFlag = true;

		return optionCompCateFlag;
	}

	boolean isInArray(String target, String[] source) {
		Arrays.sort(source);
		int find = Arrays.binarySearch(source, target);
		if( find < 0 ) return false;
		else return true;
	}
	// ************************************************************************************************
	
	//제조사 인증 판매자 로고
	public String getAuthLogoCheck(String szCategory, String szFactory){
		String rtnValue = "";

		try{
			Factory_Certification_Proc fcp = new Factory_Certification_Proc();
			org.json.JSONArray maker_list_jSONArray = fcp.MakerManagerList2();
			for(int i=0;i<maker_list_jSONArray.length();i++){
				org.json.JSONObject order = maker_list_jSONArray.getJSONObject(i);
				String[] cate_number = order.getString("maker_category_number").split(",");

				for(int c=0;c<cate_number.length;c++){
					if(!order.getString("maker_title_second").equals("")){
						if(ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,4),cate_number[c]}) && (szFactory.equals(order.getString("maker_title")) || szFactory.indexOf(order.getString("maker_title_second"))>-1)) {
							rtnValue = order.getString("maker_logo_name");
						}
					}else{
						if(ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,4),cate_number[c]}) && szFactory.equals(order.getString("maker_title"))) {
							rtnValue = order.getString("maker_logo_name");
						}
					}
				}

			}
		}catch(Exception e){
			rtnValue = "";
		}
		return rtnValue;
	}

	// 카드할인 이벤트중인 카드명 리턴
	public String getCardName(HashMap<String,String> cardNameHash, int intShopCode, String strPlGoodsNmM, long mPrice,long lnCardPrice, List<Integer> aryNewCardShop){
		String[] arrCard = null;
		String rtnCard = "";
		String tempCardName = "";
		String tempCardGoodsnm = "";
		boolean isNoNeedCardName = false; //카드명이 상품명에 없어도 인정
		boolean isShopCardNameCorrect = false;
		String szVcode = String.valueOf(intShopCode);
		
		String nowDateTime = com.enuri.util.date.DateStr.nowStr("yyyy.MM.dd. HH:mm");
		//일부 업체 제외하고 5만원 미만이면 카드특가 아님
		if(!ControlUtil.compareValOR(new String[]{szVcode,"6641","47","55","374","806","5910","6165","6193","6665","6688","6780","4027"}) && mPrice<50000){
			return rtnCard;
		}
		//
		if(lnCardPrice == 0){
			return rtnCard;
		}
	
		strPlGoodsNmM = ReplaceStr.replace(strPlGoodsNmM, "롯데백화점", "");
		strPlGoodsNmM = ReplaceStr.replace(strPlGoodsNmM, "현대백화점", "");
	
		//인터파크 상품명 문제로 예외처리
		if(szVcode.equals("55") || szVcode.equals("6780")){
			if(strPlGoodsNmM.indexOf("[")>-1 && strPlGoodsNmM.indexOf("]")>-1){
				int tempCheckTextIndex1 = strPlGoodsNmM.indexOf("[");
				int tempCheckTextIndex2 = strPlGoodsNmM.indexOf("]");
				if(tempCheckTextIndex1<tempCheckTextIndex2){
					String tempCheckText = strPlGoodsNmM.substring(tempCheckTextIndex1, tempCheckTextIndex2);
					String tempCheckCardNm = "";
					if(tempCheckText.indexOf("국민")>=0 && tempCheckText.indexOf("%카드청구할인")>=0){
						tempCheckText = ReplaceStr.replace(tempCheckText, "국민", "KB카드");
					}else if(tempCheckText.indexOf("농협")>=0 /*&& tempCheckText.indexOf("%카드청구할인")>=0*/){
						tempCheckText = ReplaceStr.replace(tempCheckText, "농협", "NH카드");
					} //상품명 內 카드문구 치환 로직 수정 2017.01.04 요청
					strPlGoodsNmM = strPlGoodsNmM.substring(0, tempCheckTextIndex1) + tempCheckText + strPlGoodsNmM.substring(tempCheckTextIndex2);
				}
			}
		}
		// Hmall 예외처리
		if(szVcode.equals("57")){
			if(mPrice<50000){
				strPlGoodsNmM = ReplaceStr.replace(strPlGoodsNmM, "[KB국민카드5%할인~08/13]", "");
			}
			strPlGoodsNmM = ReplaceStr.replace(strPlGoodsNmM, "신한카드1원할인~09/17+", "");
		}
	
		// 홈앤쇼핑 예외처리
		if(szVcode.equals("6588") && mPrice<50000){
			strPlGoodsNmM = ReplaceStr.replace(strPlGoodsNmM, "[신한카드7%할인]", "");
		}
	
		strPlGoodsNmM = ReplaceStr.replace(strPlGoodsNmM, "비씨카드", "BC카드");
		strPlGoodsNmM = ReplaceStr.replace(strPlGoodsNmM, "국민카드", "KB카드");
		strPlGoodsNmM = ReplaceStr.replace(strPlGoodsNmM, "KB국민", "KB카드");
		strPlGoodsNmM = ReplaceStr.replace(strPlGoodsNmM, "농협카드", "NH카드");
		strPlGoodsNmM = ReplaceStr.replace(strPlGoodsNmM, "NH농협카드", "NH카드");
		strPlGoodsNmM = ReplaceStr.replace(strPlGoodsNmM, "NHNH카드", "NH카드");
		strPlGoodsNmM = ReplaceStr.replace(strPlGoodsNmM, "KBKB카드", "KB카드");
		strPlGoodsNmM = ReplaceStr.replace(strPlGoodsNmM, "외한카드", "외환카드");
		strPlGoodsNmM = ReplaceStr.replace(strPlGoodsNmM, "카드카드", "카드");
		//EP 2.0 규칙 적용
		if(aryNewCardShop.contains(intShopCode)){
			String regExp = "\\[([가-힣a-zA-z]{2}카드)\\]";
			java.util.regex.Pattern pattern = java.util.regex.Pattern.compile(regExp);
			java.util.regex.Matcher matcher = pattern.matcher(strPlGoodsNmM);
			if(matcher.find()) {
				 rtnCard = matcher.group(1);
			}
			//System.out.println(rtnCard);
			if(rtnCard.equals("") && (szVcode.equals("5910") || szVcode.equals("6641")) ){
				//43325 11번가 카드명 노출
				if(cardNameHash.containsKey(szVcode)){
					tempCardName = (String)cardNameHash.get(szVcode);
					arrCard = tempCardName.split(":");
					for(int i=0; i<arrCard.length; i++){
						if(arrCard[i].indexOf("|")>-1){
							rtnCard = arrCard[i].substring(0,arrCard[i].indexOf("|")).trim();
						}else{
							rtnCard = arrCard[i];
						}
					}
				}
			}
		}else{
			//현재 진행중인 카드할인 쇼핑몰 
			if(cardNameHash.containsKey(szVcode)) {
				tempCardName = (String)cardNameHash.get(szVcode);
				arrCard = tempCardName.split(":");
				for(int i=0; i<arrCard.length; i++){
					tempCardName = arrCard[i];
					tempCardGoodsnm = "";
					if(!tempCardName.equals("")) {
						if(tempCardName.indexOf("|")>0){
							tempCardGoodsnm = tempCardName.substring(tempCardName.indexOf("|")+1).trim();
							if(tempCardGoodsnm.indexOf("|")>=0) tempCardGoodsnm = tempCardGoodsnm.substring(0,tempCardGoodsnm.indexOf("|"));
							tempCardName = tempCardName.substring(0, tempCardName.indexOf("|"));
							tempCardName = ReplaceStr.replace(tempCardName, "비씨카드", "BC카드");
							tempCardName = ReplaceStr.replace(tempCardName, "국민카드", "KB카드");
							tempCardName = ReplaceStr.replace(tempCardName, "KB국민", "KB카드");
							tempCardName = ReplaceStr.replace(tempCardName, "농협카드", "NH카드");
							tempCardName = ReplaceStr.replace(tempCardName, "NH농협카드", "NH카드");
							tempCardName = ReplaceStr.replace(tempCardName, "NHNH카드", "NH카드");
							tempCardName = ReplaceStr.replace(tempCardName, "KBKB카드", "KB카드");
							tempCardName = ReplaceStr.replace(tempCardName, "외한카드", "외환카드");
							tempCardName = ReplaceStr.replace(tempCardName, "카드카드", "카드");
						}
						if(ControlUtil.compareValOR(new int[]{intShopCode,6361})){ //상품명에 카드명 없어도 특가인정
							isNoNeedCardName = true;
						};
						//상품명에 특정문구가 있을때만 해당
						if(!isNoNeedCardName && !tempCardGoodsnm.equals("")){
							String[] arrTempCardGoodsnm = tempCardGoodsnm.split(",");
							boolean existsTempCardGoodsnm = true;
							for(int cni=0; cni<arrTempCardGoodsnm.length; cni++){
								if(strPlGoodsNmM.indexOf(arrTempCardGoodsnm[cni])<0){
									existsTempCardGoodsnm = false;
								}
							}
							if(!existsTempCardGoodsnm){ //해당 문구가 상품명에 없으면 무효
								tempCardName = "";
								tempCardGoodsnm = "";
							}
						}
						
						//카드명이 상품명에 있어야 인정
						if(!isNoNeedCardName && !tempCardName.equals("")){
							if(strPlGoodsNmM.indexOf("[")>-1 && strPlGoodsNmM.indexOf("]")>-1 && strPlGoodsNmM.indexOf("[")<strPlGoodsNmM.indexOf("]") && strPlGoodsNmM.indexOf("카드")>0 && strPlGoodsNmM.indexOf("할인")>0) {
								String tempCardPlGoodsNmM = strPlGoodsNmM;
								String tempRemoveCardNm = "";
								isShopCardNameCorrect = false;
							
								while(tempCardPlGoodsNmM.indexOf("[")>-1 && tempCardPlGoodsNmM.indexOf("]")>-1 && tempCardPlGoodsNmM.indexOf("[")<tempCardPlGoodsNmM.indexOf("]")){
									tempRemoveCardNm = tempCardPlGoodsNmM.substring(tempCardPlGoodsNmM.indexOf("["), tempCardPlGoodsNmM.indexOf("]")+1);
		
									if(tempRemoveCardNm.indexOf("%")>0 && tempRemoveCardNm.indexOf("카드")>0 && tempRemoveCardNm.indexOf("할인")>0 && tempRemoveCardNm.indexOf(tempCardName.replaceAll("카드",""))>=0){
										isShopCardNameCorrect = true;
										break;
									}
									tempCardPlGoodsNmM = tempCardPlGoodsNmM.substring(tempCardPlGoodsNmM.indexOf("]")+1);
									tempRemoveCardNm = "";
								}
								if(!isShopCardNameCorrect){
									tempCardName = "";
								}
							}
						}
		
		
						if(!tempCardName.equals("")){
							if(!rtnCard.equals("")) rtnCard += ",";
							rtnCard += tempCardName;
						}
					}
				}
			}
			//기간이 지난 등록건이 있으면 상품명 카드가 정보대로 
			if(rtnCard.equals("") && cardNameHash.containsKey(szVcode+"N")) { 
				int nowH = ChkNull.chkInt(nowDateTime.substring(12, 14));
				//11시 기준 삭제  shwoo 2017-12-05
				//if(nowH>=11 && nowH<24){ //11시 이후부터 상품명 정보대로
		
					if(strPlGoodsNmM.indexOf("[")>-1 && strPlGoodsNmM.indexOf("]")>-1 && strPlGoodsNmM.indexOf("[")<strPlGoodsNmM.indexOf("]") && strPlGoodsNmM.indexOf("카드")>0 && strPlGoodsNmM.indexOf("할인")>0) {
						String tempCatchCardPlGoodsNm = strPlGoodsNmM;
						String tempCatchCardNm = "";
						
						while(tempCatchCardPlGoodsNm.indexOf("[")>-1 && tempCatchCardPlGoodsNm.indexOf("]")>-1 && tempCatchCardPlGoodsNm.indexOf("[")<tempCatchCardPlGoodsNm.indexOf("]")){
							tempCatchCardNm = tempCatchCardPlGoodsNm.substring(tempCatchCardPlGoodsNm.indexOf("[")+1, tempCatchCardPlGoodsNm.indexOf("]"));
							
							if(tempCatchCardNm.indexOf("%")>0 && tempCatchCardNm.indexOf("카드")>=2 && tempCatchCardNm.indexOf("할인")>0){
								//상품명에 있는 카드명 추출
		
								tempCatchCardNm = tempCatchCardNm.substring(tempCatchCardNm.indexOf("카드")-2, tempCatchCardNm.indexOf("카드")+2);
		
								tempCatchCardNm = ReplaceStr.replace(tempCatchCardNm, "비씨카드", "BC카드");
								tempCatchCardNm = ReplaceStr.replace(tempCatchCardNm, "농협카드", "NH카드");
								tempCatchCardNm = ReplaceStr.replace(tempCatchCardNm, "NH농협카드", "NH카드");
								tempCatchCardNm = ReplaceStr.replace(tempCatchCardNm, "NHNH카드", "NH카드");
								tempCatchCardNm = ReplaceStr.replace(tempCatchCardNm, "국민카드", "KB카드");
								tempCatchCardNm = ReplaceStr.replace(tempCatchCardNm, "KB국민", "KB카드");
								tempCatchCardNm = ReplaceStr.replace(tempCatchCardNm, "KBKB카드", "KB카드");
								tempCatchCardNm = ReplaceStr.replace(tempCatchCardNm, "외한카드", "외환카드");
								tempCatchCardNm = ReplaceStr.replace(tempCatchCardNm, "카드카드", "카드");
		
								if(tempCatchCardNm.equals("BC카드")) rtnCard = "BC카드";
								if(tempCatchCardNm.equals("KB카드")) rtnCard = "KB카드";
								if(tempCatchCardNm.equals("롯데카드")) rtnCard = "롯데카드";
								if(tempCatchCardNm.equals("삼성카드")) rtnCard = "삼성카드";
								if(tempCatchCardNm.equals("신한카드")) rtnCard = "신한카드";
								if(tempCatchCardNm.equals("씨티카드")) rtnCard = "씨티카드";
								if(tempCatchCardNm.equals("우리카드")) rtnCard = "우리카드";
								if(tempCatchCardNm.equals("외환카드")) rtnCard = "외환카드";
								if(tempCatchCardNm.equals("하나카드")) rtnCard = "하나카드";
								if(tempCatchCardNm.equals("현대카드")) rtnCard = "현대카드";
								if(tempCatchCardNm.equals("CJ카드")) rtnCard = "CJ카드";
								if(tempCatchCardNm.equals("NH카드")) rtnCard = "NH카드";
								if(tempCatchCardNm.equals("SC은행카드")) rtnCard = "SC은행카드";
		
								if(!rtnCard.equals("")){
									break;
								}
							}
							tempCatchCardPlGoodsNm = tempCatchCardPlGoodsNm.substring(tempCatchCardPlGoodsNm.indexOf("]")+1);
							tempCatchCardNm = "";
						}
					}
				//}
			}
			if(!rtnCard.equals("") && rtnCard.indexOf(",")>0){
				rtnCard = ReplaceStr.replace(rtnCard,"카드","");
			}
			
		}
		return rtnCard;
	}
	//카드특가 이벤트 문구 추출
	public String getCardEventText(int szVcode, String strPlGoodsNmM, long intPrice_card, String tempCardName, String[] arrTempCardName){
		String strCardEvent = "";
		String nowDateTime = com.enuri.util.date.DateStr.nowStr("yyyy.MM.dd. HH:mm");

		//홈플러스(6361) 예외처리 - 카드문구 CHECK X --> ADMIN에서 O 일경우 적용카드 기준으로 노출
		if(szVcode == 6361){
			return strCardEvent;
		}
		//상품명에서 회원,카드특가 문구 추출하기
		if((!tempCardName.equals("") && (strPlGoodsNmM.indexOf(tempCardName)==0 || (tempCardName.indexOf(",")>0 && (strPlGoodsNmM.indexOf(arrTempCardName[0])==0 || strPlGoodsNmM.indexOf(arrTempCardName[1])==0)))) || (strPlGoodsNmM.indexOf("[")>-1 && strPlGoodsNmM.indexOf("]")>-1 && strPlGoodsNmM.indexOf("[")<strPlGoodsNmM.indexOf("]"))) {
			String tempCardPlGoodsNmM2 = strPlGoodsNmM;
			while(tempCardPlGoodsNmM2.indexOf("[")>-1 && tempCardPlGoodsNmM2.indexOf("]")>-1 && tempCardPlGoodsNmM2.indexOf("[")<tempCardPlGoodsNmM2.indexOf("]")){
				String tempEvent = tempCardPlGoodsNmM2.substring(tempCardPlGoodsNmM2.indexOf("[")+1, tempCardPlGoodsNmM2.indexOf("]"));
				tempEvent = ReplaceStr.replace(tempEvent, "[", ""); //대괄호를 연속으로 두개이상 쓰는경우 체크[[xx카드 할인]]
				//EP 1.0 규칙
				//상품명에서 [OO카드 N%할인] 문구 CHECK
				//카드할인가 존재

				if(tempEvent.indexOf("CJ단독")<0 && tempEvent.indexOf("WOW")<0 && tempEvent.indexOf("여행용가방")<0 && tempEvent.indexOf("깜짝")<0
					&& tempEvent.indexOf("%")>-1 && tempEvent.indexOf("카드")>-1)
				{
					if(ControlUtil.compareValOR(new int[]{szVcode,806,6165,6688}) || tempEvent.indexOf("쿠폰")<0){
						if(tempEvent.indexOf("할인")>-1) {
							strCardEvent = tempEvent.substring(0, tempEvent.indexOf("할인")+2);
						} else if(tempEvent.indexOf("혜택")>-1) {
							strCardEvent = tempEvent.substring(0, tempEvent.indexOf("혜택")+2);
						} else if(tempEvent.indexOf("적립")>-1) {
							strCardEvent = tempEvent.substring(0, tempEvent.indexOf("적립")+2);
						}
						break;
					}
				}
				tempCardPlGoodsNmM2 = tempCardPlGoodsNmM2.substring(tempCardPlGoodsNmM2.indexOf("]")+1);
			}

			if(!tempCardName.equals("") && (strPlGoodsNmM.indexOf(tempCardName)==0 || (tempCardName.indexOf(",")>0 && (strPlGoodsNmM.indexOf(arrTempCardName[0])==0 || strPlGoodsNmM.indexOf(arrTempCardName[1])==0))) && strPlGoodsNmM.indexOf(",")>0){ //대괄호([])없이 카드명이 맨앞에
				String tempEventFirst = strPlGoodsNmM.substring(0, strPlGoodsNmM.indexOf(","));
				if(tempEventFirst.indexOf("할인")>-1) {
					strCardEvent = tempEventFirst.substring(0, tempEventFirst.indexOf("할인")+2);
				} else if(tempEventFirst.indexOf("혜택")>-1) {
					strCardEvent = tempEventFirst.substring(0, tempEventFirst.indexOf("혜택")+2);
				} else if(tempEventFirst.indexOf("적립")>-1) {
					strCardEvent = tempEventFirst.substring(0, tempEventFirst.indexOf("적립")+2);
				}
			}
			// [[삼성카드 들어갈때 예외처리
			if(strCardEvent.length()>0 && strCardEvent.indexOf("[삼성카드")>-1) {
				strCardEvent = strCardEvent.substring(0, strCardEvent.indexOf("[삼성카드")) + strCardEvent.substring(strCardEvent.indexOf("[삼성카드")+1);
			}
		}
		if(ControlUtil.compareValOR(new int[]{szVcode,6165}) && intPrice_card>0){
			if(strCardEvent.equals("") && tempCardName.indexOf("CJ")>=0){
				strCardEvent = "The CJ카드 5% 할인";
			}
		}
		//최대금액 추출
		if(intPrice_card>0 && !tempCardName.equals("")){
			strCardEvent = strCardEvent.replace("할인 적용가", "할인");
			if(strPlGoodsNmM.indexOf("(최대20만원")>0){
				strCardEvent = strCardEvent.replace("할인", "할인(최대20만원)");
			}else if(strPlGoodsNmM.indexOf("(최대10만원")>0){
				strCardEvent = strCardEvent.replace("할인", "할인(최대10만원)");
			}else if(strPlGoodsNmM.indexOf("(최대5만원")>0){
				strCardEvent = strCardEvent.replace("할인", "할인(최대5만원)");
			}else if(strPlGoodsNmM.indexOf("(최대2만원")>0){
				strCardEvent = strCardEvent.replace("할인", "할인(최대2만원)");
			}
		}

		return strCardEvent;
	}
	
	// 무이자정보 DB관리방식
	public String getForceFreeInterest2(int szVcode, String szCategory, String strFreeinterest, long mPrice, String[][] cardFreeAry){
		//if(!strFreeinterest.equals("") && mPrice>=50000 && cardFreeAry!=null){
		//조건 변경. Freeinterest값이 있건 없건 다 나오면된다. 관리자에서 메이저 쇼핑몰만 등록되어있으니... shwoo. 2018-01-03. feat김선희
		if(cardFreeAry!=null){
			for(int i=0; i<cardFreeAry.length; i++){
				int shop_code = ChkNull.chkInt(cardFreeAry[i][0]);
				int s_price = ChkNull.chkInt(cardFreeAry[i][3])*10000;
				int e_price = ChkNull.chkInt(cardFreeAry[i][4])*10000;
				String free_txt = ChkNull.chkStr(cardFreeAry[i][5]);
				String cate_list = ChkNull.chkStr(cardFreeAry[i][6]);
				String cate_type = ChkNull.chkStr(cardFreeAry[i][7]);

				if(szVcode==shop_code){
					if(mPrice>=s_price && (e_price==0 || (e_price>0 && mPrice<e_price))){
						if(!cate_list.equals("")){ //분류제한조건이 있을때
							String[] arrCate = cate_list.split(",");
							boolean isInCate = false;
							for(int j=0; j<arrCate.length; j++){
								int cate_len = arrCate[j].length();
								isInCate = ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,cate_len),arrCate[j]});
								if(isInCate) break;
							}
							if(cate_type.equals("N") && isInCate){ //N:제외, E:노출
								strFreeinterest = "";
							}else if(cate_type.equals("E") && !isInCate){
								strFreeinterest = "";
							}else{
								strFreeinterest = free_txt;
								break;
							}
						}else{
							strFreeinterest = free_txt;
							break;
						}
					}else{
						strFreeinterest = "";
					}
				}
			}
		}else{
			strFreeinterest = "";
		}
		if(strFreeinterest.equals("1")){
			strFreeinterest = "";
		}
		if(ChkNull.chkNumber(strFreeinterest)){
			strFreeinterest = "";
		}
		return strFreeinterest;
	}
	// 무이자정보 DB관리방식
	public String getForceFreeInterest3(int szVcode, String szCategory, String strFreeinterest, long mPrice, String[][] cardFreeAry){
		//if(!strFreeinterest.equals("") && mPrice>=50000 && cardFreeAry!=null){
		//조건 변경. Freeinterest값이 있건 없건 다 나오면된다. 관리자에서 메이저 쇼핑몰만 등록되어있으니... shwoo. 2018-01-03. feat김선희
		if(cardFreeAry!=null){
			int cardFreeArray_len = cardFreeAry.length;
			int max_price = 0;
			for(int i=0; i<cardFreeAry.length; i++){
				int shop_code = ChkNull.chkInt(cardFreeAry[i][0]);
				int s_price = ChkNull.chkInt(cardFreeAry[i][3])*10000;
				int e_price = ChkNull.chkInt(cardFreeAry[i][4])*10000;
				String free_txt = ChkNull.chkStr(cardFreeAry[i][5]);
				String cate_list = ChkNull.chkStr(cardFreeAry[i][6]);
				String cate_type = ChkNull.chkStr(cardFreeAry[i][7]);

				if(szVcode==shop_code){
					if(max_price < s_price){
						max_price = s_price;
						if(!cate_list.equals("")){ //분류제한조건이 있을때
							String[] arrCate = cate_list.split(",");
							boolean isInCate = false;
							for(int j=0; j<arrCate.length; j++){
								int cate_len = arrCate[j].length();
								isInCate = ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,cate_len),arrCate[j]});
								if(isInCate) break;
							}
							if(cate_type.equals("N") && isInCate){ //N:제외, E:노출
								strFreeinterest = "";
							}else if(cate_type.equals("E") && !isInCate){
								strFreeinterest = "";
							}else{
								strFreeinterest = free_txt;
							}
						}else{
							strFreeinterest = free_txt;
						}
					}
				}
			}
		}else{
			strFreeinterest = "";
		}
		if(strFreeinterest.equals("1")){
			strFreeinterest = "";
		}
		if(ChkNull.chkNumber(strFreeinterest)){
			strFreeinterest = "";
		}
		return strFreeinterest;
	}

//쿠폰레이어 정보
//COUPON_FIELD : pricelist> COUPON 테이블 쿠폰필드정보 (0:쿠폰해당없음, 1:쿠폰상품)
//PRICE_TYPE : 정렬기준에 의한 1:기본정렬, 3 : 카드특가 (listType> :1 기본, 3:신용카드특가)
public String[] getCouponLayerInfo(int p_shop_code, int p_coupon_field, int p_mPrice, int p_price_type, String[][] CouponLayerAry){
	String c_contents = "";
	String c_coupon_url = "";
	String[] strcoponLayer = {"",""};
	if(CouponLayerAry!=null){
		for(int i=0; i<CouponLayerAry.length; i++){
			int c_shop_code = ChkNull.chkInt(CouponLayerAry[i][2]);
			int c_con_flag = ChkNull.chkInt(CouponLayerAry[i][3]);
			int c_coupon_field = ChkNull.chkInt(CouponLayerAry[i][4]);
			int c_price_range = ChkNull.chkInt(CouponLayerAry[i][5]);
			int c_price_type = ChkNull.chkInt(CouponLayerAry[i][6]);
			c_contents = ChkNull.chkStr(CouponLayerAry[i][7]);
			c_coupon_url = ChkNull.chkStr(CouponLayerAry[i][8]);
			try{
				if(p_shop_code==c_shop_code && ((c_con_flag==1 && (( (CouponLayerAry[i][4]!=null && p_coupon_field==c_coupon_field) || (CouponLayerAry[i][4]==null)) && p_mPrice>=c_price_range)) || c_con_flag==2) && p_price_type==c_price_type){
					strcoponLayer[0] = c_contents;
					strcoponLayer[1] = c_coupon_url;
				}
			}catch(Exception e){
				strcoponLayer = null;
			}
		}
	}else{
		strcoponLayer = null;
	}
	return strcoponLayer;
}
public static String toUrlCode(String strShop_url){

	String strMobile_url = "";

	//쇼핑몰에 따른 모바일 url & 수익코드 변경
	if(strShop_url.indexOf("auction.co.kr") > 0){
		if(strShop_url.indexOf("&pc=589") > 0){
			strMobile_url = strShop_url.replace("&pc=589","&pc=805");
		}else{
			strMobile_url = strShop_url;
		}
	}else if(strShop_url.indexOf("gmarket.co.kr") > 0){
			if(strShop_url.indexOf("jaehuid=200002673") > 0){
				strMobile_url = strShop_url.replace("jaehuid=200002673","jaehuid=200006254");
			}else{
				strMobile_url = strShop_url;
			}
	}else if(strShop_url.indexOf("11st") > 0){
		if(strShop_url.indexOf("prdNo=") > 0){
			strMobile_url = strShop_url.substring(strShop_url.indexOf("prdNo=")+6,strShop_url.length());
			if(strMobile_url.indexOf("&tid=1000000125") > 0 ){
				strMobile_url = strMobile_url.replace("&tid=1000000125","");
			}
			strMobile_url = "http://www.11st.co.kr/connect/Gateway.tmall?method=Xsite&tid=1000993624&prdNo="+strMobile_url+"&apInfo=5910_mobile";
		}else{
			strMobile_url = strShop_url+"&apInfo=5910_mobile";
		}
	}else if(strShop_url.indexOf("lotteimall.com") > 0){
		if(strShop_url.indexOf("goods_no=") > -1){
			strMobile_url = strShop_url.substring(strShop_url.indexOf("goods_no=")+9,strShop_url.length());
			strMobile_url = "http://m.lotteimall.com/coop/affilGate.lotte?chl_no=140764&chl_dtl_no=2540376&returnUrl=/goods/viewGoodsDetail.lotte?goods_no="+strMobile_url;
		}else{
			strMobile_url = strShop_url;
		}
	}else if(strShop_url.indexOf("dnshop") > 0){
		strMobile_url = strShop_url.replace("dnshop_partner_02","dnshop_partner_54").replace("Sid=0024_A8000000_00_00","Sid=0024_M8000000_00_00").replace("Psid=010000","Psid=010001");
	}else if(strShop_url.indexOf(".lotte.com") > 0){
		if(strShop_url.indexOf("goods_no=") > 0){
			strMobile_url = strShop_url.substring(strShop_url.indexOf("goods_no=")+9,strShop_url.length());
			strMobile_url = "http://m.lotte.com/product/product_view.do?c=mlotte&udid=&v=&cn=120632&cdn=984879&goods_no="+strMobile_url;
		}else{
			strMobile_url = strShop_url;
		}
	}else if(strShop_url.indexOf("emart") > 0){
		if(strShop_url.indexOf("item_id=") > 0){
			strMobile_url = strShop_url.substring(strShop_url.indexOf("item_id=")+8,strShop_url.length());
			strMobile_url = "http://m.emartmall.com/mobile/MobileItem.do?method=getItemInfoViewDtl&item_id="+strMobile_url;
		}else{
			strMobile_url = strShop_url;
		}
	}else if(strShop_url.indexOf("cjmall") > 0){
		if(strShop_url.indexOf("item_cd=") > 0){
			strMobile_url = strShop_url.substring(strShop_url.indexOf("item_cd=")+8,strShop_url.length());
			strMobile_url = "http://mw.cjmall.com/m/prd/detail_cate.jsp?app_cd=ENURI&item_cd="+strMobile_url;
		}else if(strShop_url.indexOf("infl_cd=I0647") > 0){
			strMobile_url = strShop_url.replace("infl_cd=I0647", "infl_cd=I0580");
		}else{
			strMobile_url = strShop_url;
		}
	}else if(strShop_url.indexOf("galleria.co.kr") > 0){
		if(strShop_url.indexOf("channel_id=2763") > 0){
			strMobile_url = strShop_url.replace("channel_id=2763","channel_id=2764");
		}else{
			strMobile_url = strShop_url;
		}
	/*
		* 2017.01.10. shwoo. 이재환 요청으로 우체국 모바일 예외처리 제외.
	}else if(strShop_url.indexOf("epost.go.kr") > 0){
		//https://mall.epost.go.kr/cgi-bin/epostpartner_bbr.cgi?p=enuri&Gbn=1&CateCode=130804&GoodsIdn=33393
		//-->변환
		//http://mall.epost.go.kr/hybrid.goods.RetrieveNewMobileWebEcGoodsDetailInfo.mall?cateCode=130804&goodsIdn=33393
		if(strShop_url.indexOf("?") > 0){
			strMobile_url = strShop_url.substring(strShop_url.indexOf("?")+1,strShop_url.length()).replace("CateCode=","cateCode=").replace("GoodsIdn=","goodsIdn=");
			strMobile_url = "http://mall.epost.go.kr/hybrid.goods.RetrieveNewMobileWebEcGoodsDetailInfo.mall?"+strMobile_url;
		}
	*/
	}else if(strShop_url.indexOf("g9.co.kr") > 0){
		if(strShop_url.indexOf("200006435") > 0){
			strMobile_url = strShop_url.replace("200006435","200006436");
		}else{
			strMobile_url = strShop_url;
		}
	}else if(strShop_url.indexOf("coupang.com") > 0){
		strMobile_url = strShop_url;
		
		if(strMobile_url.indexOf("utm_campaign=PC_EP") > 0){
			strMobile_url = strMobile_url.replace("utm_campaign=PC_EP","utm_campaign=Mobile_EP");
		}
		if(strMobile_url.indexOf("src=1032035") > 0){
			strMobile_url = strMobile_url.replace("src=1032035","src=1033035");
		}
		if(strMobile_url.indexOf("src=1032001") > 0){
			strMobile_url = strMobile_url.replace("src=1032001", "src=1033035");
		}
	}else if(strShop_url.indexOf("qoo10.com") > 0){
		strMobile_url = strShop_url;
		
		if(strMobile_url.indexOf("2026003151") > 0){
			strMobile_url = strMobile_url.replace("2026003151","2026048152");
		}
	}else if(strShop_url.indexOf("www.elandmall.com") > 0){
		strMobile_url = strShop_url;
		
		if(strMobile_url.indexOf("chnl_no=ENW") > 0){
			strMobile_url = strMobile_url.replace("chnl_no=ENW", "chnl_no=ENM");
		}
	//}else if(strShop_url.indexOf(".istyle24.com") > 0){
	//	strMobile_url = strShop_url;
		
	//	if(strMobile_url.indexOf("cid=enuri") > 0){
	//		strMobile_url = strMobile_url.replace("cid=enuri", "cid=menuri");
	//	}
	}else if(strShop_url.indexOf("www.akmall.com") > 0){
		strMobile_url = strShop_url;
		
		if(strMobile_url.indexOf("assc_comp_id=12189") > 0){
			strMobile_url = strMobile_url.replace("assc_comp_id=12189", "assc_comp_id=26392");
		}
	}else if(strShop_url.indexOf("www.hyundaihmall.com") > 0){
		//2018-10-10.shwoo 추가 (#30674)
		strMobile_url = strShop_url;
		
		if(strMobile_url.indexOf("ReferCode=022") > 0){
			strMobile_url = strMobile_url.replace("ReferCode=022", "ReferCode=s49");
		}
	}else{
		strMobile_url = strShop_url;
	}

	return strMobile_url;
}
%>
