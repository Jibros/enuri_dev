<%! 
public String getLeftRightTitle(String szCallDataOpt, String strCategory, String strFactory,  String cur_date, String dDate, String IsLeftRight,  boolean optionEssentialFlag, String optionEssentialDel, String priceListShowType, String airconFlag, boolean authShfowFlag, int junggoShowType, String strCondi, int nModelNo, boolean phonePriceAllFlag, String phonePlan, String phonePlanNm) {
	String IMG_ENURI_COM = ConfigManager.IMG_ENURI_COM;
	String szTmpStr = "";

	//System.out.println("optionEssentialFlag>>>"+optionEssentialFlag);
	//System.out.println("szCallDataOpt>>>"+szCallDataOpt);
	//System.out.println("optionEssentialDel>>>"+optionEssentialDel);
	
	if(optionEssentialFlag && !szCallDataOpt.equals("opt_card") && optionEssentialDel.equals("N")) { // 옵션필수 빼기
		if(IsLeftRight.equals("left")) {
			szTmpStr = "무료배송";
		} else {
			szTmpStr = "옵션필수";
		}
	} else if(szCallDataOpt.equals("opt_term")) {
		if(IsLeftRight.equals("left")) {
			if(priceListShowType.equals("1")){
				szTmpStr = "배송비 포함 쇼핑몰";
			}else{
				szTmpStr = "무료배송";
			}
		} else {
			if(priceListShowType.equals("1")){
				szTmpStr = "배송비 유무료 쇼핑몰";
			}else{
				szTmpStr = "배송비 유무료 쇼핑몰";
			}
		}
	} else if(szCallDataOpt.equals("opt_scale")) {
		if(CutStr.cutStr(strCategory,4).equals("0304") || CutStr.cutStr(strCategory,8).equals("02332217")) {
			if(IsLeftRight.equals("left")) {
				szTmpStr = "대형몰";
			} else {
				szTmpStr = "전문쇼핑몰";
			}
		} else {
			if(IsLeftRight.equals("left")) {
				szTmpStr = "오픈마켓";
			} else {
				szTmpStr = "일반쇼핑몰";
			}
		}
	} else if(szCallDataOpt.equals("opt_home")) {
		if(IsLeftRight.equals("left")) {
			szTmpStr = "일반쇼핑몰";
		} else {
			szTmpStr = "홈쇼핑";
		}
	} else if(szCallDataOpt.equals("opt_shocking2")) {
		if(IsLeftRight.equals("left")) {
			szTmpStr = "보상(2G→3G)";
		} else {
			szTmpStr = "보상(3G→3G)";
		}
	} else if(szCallDataOpt.equals("opt_card")) {
		if(IsLeftRight.equals("left")) {
			szTmpStr = "일반 결제조건 가격";
		} else {
			szTmpStr = "특정카드 할인가";
		}
	} else if(szCallDataOpt.equals("opt_tariff")) {
		if(IsLeftRight.equals("left")) {
			szTmpStr = "세금, 배송비 무료";
		} else {
			szTmpStr = "세금, 배송비 유무료";
		}
	} else if(szCallDataOpt.equals("opt_nboption")) {
		if(IsLeftRight.equals("left")) {
			if(priceListShowType.equals("1")){
				szTmpStr = "배송비 포함 쇼핑몰";
			}else{
				szTmpStr = "필수옵션 없음 (추천!)";
			}
		} else {
			if(priceListShowType.equals("1")){
				szTmpStr = "배송비 유무료 쇼핑몰";
			}else{
				szTmpStr = "필수옵션 확인요망";
			}
		}
	} else if(szCallDataOpt.equals("opt_freeset")) {
		if(IsLeftRight.equals("left")) {
			szTmpStr = "전국 무료장착";
		} else {
			szTmpStr = "일부지역 무료장착";
		}
	} else{
		if(IsLeftRight.equals("left")) {
			szTmpStr = "좌측쇼핑몰";
		} else {
			szTmpStr = "우측쇼핑몰";
		}
	}
	if(DateUtil.DateDiff("d", cur_date, dDate) > 0 || IsLeftRight.equals("NoMall")) {
		szTmpStr = "";
	}
	
	//에어콘 설치비 기준
	if(szCallDataOpt.equals("opt_aircon")){
		if(airconFlag.equals("1")){ //멀티형 - 인버터X
			if(IsLeftRight.equals("left")) {
				szTmpStr = "기본설치비 포함<br/>(스탠드+벽걸이)";
			}else{
				szTmpStr = "<table style=\"width:96%;height:28px;\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\"><tr><td align=\"center\"><div>기본설치비 확인요망<img id=\"title_info\" src=\""+IMG_ENURI_COM+"/images/view/detail/pricelist/toptab/bt_q_120626.gif\" align='absmiddle' /></div>";
				szTmpStr += "<div id=\"title_info_img\" style=\"top:25px\"><div id=\"title_info_close\">&nbsp</div><img src=\""+IMG_ENURI_COM+"/images/view/detail/pricelist/sp_layer_aircon_1.png\" /></div></td></tr></table>";
			}
		}else if(airconFlag.equals("2")){ //멀티형 - 인버터
			if(IsLeftRight.equals("left")) {
				szTmpStr = "기본설치비 포함<br/>(스탠드+벽걸이+진공비)";
			}else{
				szTmpStr = "<table style=\"width:96%;height:28px;\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\"><tr><td align=\"center\"><div>기본설치비 확인요망<img id=\"title_info\" src=\""+IMG_ENURI_COM+"/images/view/detail/pricelist/toptab/bt_q_120626.gif\" align='absmiddle' /></div>";
				szTmpStr += "<div id=\"title_info_img\" style=\"top:25px\"><div id=\"title_info_close\">&nbsp</div><img src=\""+IMG_ENURI_COM+"/images/view/detail/pricelist/sp_layer_aircon_2.png\" /></div></td></tr></table>";
			}
		}else if(airconFlag.equals("3")){ //벽걸이,스탠드형 - 인버터X
			if(IsLeftRight.equals("left")) {
				szTmpStr = "기본설치비 포함<br/>(오픈마켓)";
			} else {
				szTmpStr = "기본설치비 포함<br/>(일반쇼핑몰)";
			}
		}else if(airconFlag.equals("4")){ //벽걸이,스탠드형 - 인버터
			if(IsLeftRight.equals("left")) {
				szTmpStr = "기본설치비+진공비 포함";
			}else{
				szTmpStr = "<div class='title_txt'>기본설치비 포함<img id=\"title_info\" src=\""+IMG_ENURI_COM+"/images/view/detail/pricelist/toptab/bt_q_120626.gif\" align='absmiddle' /><br/>(진공비 확인요망)</div>";
				szTmpStr += "<div id=\"title_info_img\" style=\"top:25px\"><div id=\"title_info_close\">&nbsp</div><img src=\""+IMG_ENURI_COM+"/images/view/detail/pricelist/sp_layer_aircon_4.png\" /></div>";
			}
		}
	}
	
	if(optionEssentialFlag) {
		if(optionEssentialDel.equals("Y")) {
		} else {
			if(priceListShowType.equals("1")) {
				if(IsLeftRight.equals("left")) {
					szTmpStr = "배송비 포함 쇼핑몰";
				}
			}
		}
	}
	
	// 전시,중고,반품 구분
	if(junggoShowType==3 && !optionEssentialDel.equals("N")) {
		if(CutStr.cutStr(strCategory,4).equals("0304") || (CutStr.cutStr(strCategory,4).equals("0305") && !strCondi.equals("중고품") && strCondi.indexOf("리퍼,중고")<0) || CutStr.cutStr(strCategory,8).equals("02332217")) {
			if(IsLeftRight.equals("left")) {
				szTmpStr = "중고";
			}else{
				//if(CutStr.cutStr(strCategory,4).equals("0304")){
					szTmpStr = "가개통";
				//}else{
				//	szTmpStr = "가개통/공기계";
				//}
			}
		} else {
			if(IsLeftRight.equals("left")) {
				szTmpStr = "전시/중고";// <img src='"+IMG_ENURI_COM+"/images/view/detail/pricelist/toptab/bt_q_120626.gif' align='absmiddle' style='cursor:pointer;' onClick='junggoInfoInfoDivShow(1);'/>";
			} else {
				szTmpStr = "반품/리퍼";// <img src='"+IMG_ENURI_COM+"/images/view/detail/pricelist/toptab/bt_q_120626.gif' align='absmiddle' style='cursor:pointer;' onClick='junggoInfoInfoDivShow(2);'/>";
			}
		}
	}
	// 제조사 인증 예외 처리
	if(authShfowFlag){
		if(priceListShowType.equals("1")){ //배송비탭에서 제조사인증
			if(IsLeftRight.equals("right")) {
				szTmpStr = "<div class='title_txt'>배송비 포함 쇼핑몰<img id=\"title_info\" src=\""+IMG_ENURI_COM+"/images/view/detail/pricelist/toptab/bt_q_120626.gif\" align='absmiddle' /></div>";
				szTmpStr += "<div id=\"title_info_img\"><div id=\"title_info_img_close\">&nbsp</div><img src=\""+IMG_ENURI_COM+"/images/view/detail/pricelist/auth/sp_auth_delivery.png\" /></div>";
			}else{
				szTmpStr = getAuthLogo(strCategory, strFactory);
				// 제조사 로고가 붙음
				if(szTmpStr.length()>0) {
					if(ControlUtil.compareValOR(new int[]{nModelNo,9895923,10159587})){
						szTmpStr = szTmpStr + "직거래 쇼핑몰";
					}else{
						szTmpStr = szTmpStr + "인증판매자";
					}
				} else {
					szTmpStr = "인증판매자";
				}
			}
		}else if(priceListShowType.equals("0") || priceListShowType.equals("3")) { //기본탭
			if(IsLeftRight.equals("right")) {
				szTmpStr = "일반쇼핑몰";
			} else {
				szTmpStr = getAuthLogo(strCategory, strFactory);
				// 제조사 로고가 붙음
				if(szTmpStr.length()>0) {
					if(ControlUtil.compareValOR(new int[]{nModelNo,9895923,10159587})){
						szTmpStr = szTmpStr + "직거래 쇼핑몰";
					}else{
						szTmpStr = szTmpStr + "인증판매자";
					}
				} else {
					szTmpStr = "인증판매자";
				}
			}
		}
	}

	// 휴대폰에 표시가 및 기본가가 있을 경우 예외처리
	if(phonePriceAllFlag) {
		if(!phonePlan.equals("")){
			if(IsLeftRight.equals("left")) {
				szTmpStr = ""+phonePlanNm+"";
			} else {
				szTmpStr = "전체 쇼핑몰";
			}
		}else{
			if(CutStr.cutStr(strCategory,4).equals("0304")){
				if(IsLeftRight.equals("left")) {
					szTmpStr = "일시불 구매 쇼핑몰";
				} else {
					szTmpStr = "할부 구매 쇼핑몰";
				}
			}else{
				if(IsLeftRight.equals("right")) {
					szTmpStr = "수수료 쇼핑몰";
					szTmpStr += "<br/>(쇼핑몰에서 판매가를 확인)";
				} else {
					szTmpStr = "판매가 쇼핑몰";
					szTmpStr += "<br/>(최저 판매가 = 최저가)";
				}
			}
		}
	}

	return szTmpStr;
}

//제조사 인증 로고를 가져오는 함수
public String getAuthLogo(String strCategory, String strFactory) {
	String rtnValue = "";
	String IMG_ENURI_COM = ConfigManager.IMG_ENURI_COM;
	rtnValue = getAuthLogoCheck_text(strCategory, strFactory);

	//if(rtnValue.length()>0) {
	//	rtnValue = "<img style='margin:0px 5px 0px 0px;' src='" + IMG_ENURI_COM + "/images/view/detail/pricelist/auth/"+rtnValue+"' border=0 align=absmiddle>";
	//}

	return rtnValue;
}

boolean IsOptionCompCate(String szCategory) {
	String target = CutStr.cutStr(szCategory,4);
	String[] source = new String[] {
		"0201","0235","0236","0233","0210","0211","0212","0214","0217","0218",
		"0234","0222","0232","0305","0313","0318","0335","0401","0401","0402",
		"0404","0405","0408","0410","0502","0503","2405","2402","0510","0513",
		"0514","0515","2407","0526","0602","0605","0606","0608","0609","0610",
		"0620","0691","0692","0702","0704","0705","0710","0712","0801","0802",
		"0803","0804","0806","0807","0810","0903","0904","0905","0907","0908",
		"0909","0912","0913","0919","0920","0923","0924","0925","0929","1001",
		"1003","1004","1005","1007","1009","1012","1020","1202","1204","1205",
		"1207","1208","1213","1219","1602","1605","1225","1614","2302","1626",
		"2305","1632","1635","0364","2103","2104","2105","2106","2108","2109",
		"0362","2114","0363","2120"
	};
	Arrays.sort(source);
	int find = Arrays.binarySearch(source, target);
	if( find < 0 ) return false;
	else return true;
}

//제조사 인증 판매자 로고(txt화)
public String getAuthLogoCheck_text(String szCategory, String szFactory){
	String rtnValue = "";
	if(ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,4),"0201","0208","0211","0305","0318","0402","0404","0405","0420","0502","0503","0602","0603","0609","0621","0702","0712","0713","2401","2403","2406","2407"}) && (szFactory.equals("LG") || szFactory.indexOf("LG(")>-1)) {
		rtnValue = "LG전자";
	}
	if(ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,4),"0201","0241","0402","0404","0405","0502","0503","0602","0609","0621","0713","2406"}) && (szFactory.equals("삼성") || szFactory.indexOf("삼성(")>-1)) {
		rtnValue = "삼성전자";
	}
	if(ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,4),"0402"}) && szFactory.equals("브라더")) {
		rtnValue = "브라더";
	}
	if(ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,4),"0211"}) && szFactory.equals("이노아이오")) {
		rtnValue = "SK텔레콤";
	}
	if(ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,4),"0232","0234"}) && szFactory.equals("소니")) {
		rtnValue = "소니";
	}
	if(ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,4),"2401","2403","2406","0609"}) && szFactory.equals("대유위니아")) {
		rtnValue = "위니아";
	}
	if(ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,4),"0402"}) && szFactory.equals("캐논")) {
		rtnValue = "캐논";
	}
	if(ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,4),"0362","0363"}) && szFactory.equals("팅크웨어")) {
		rtnValue = "아이나비";
	}
	/**
	if(ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,4),"2405","2406","2403","0610"}) && szFactory.equals("위닉스")) {
		rtnValue = "title_logo_winix.gif";
	}
	if(ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,4),"0234"}) && szFactory.equals("니콘")) {
		rtnValue = "title_logo_nikon.gif";
	}
	if(ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,4),"0526"}) && szFactory.equals("브라운(오랄-B)")) {
		rtnValue = "title_logo_oralb.gif";
	}
	if(ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,4),"0502","0621"}) && szFactory.equals("동부대우전자")) {
		rtnValue = "title_logo_daewoo.gif";
	}
	if(ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,4),"0402"}) && szFactory.equals("HP")) {
		rtnValue = "sp_logo_hp.gif";
	}
	if(CutStr.cutStr(szCategory,4).equals("0212") && szFactory.equals("아이리버")) {
		rtnValue = "sp_logo_iriver.gif";
	}
	if(ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,4),"0363"}) && szFactory.equals("피타소프트")) {
		rtnValue = "title_logo_pittasoft.gif";
	}
	if(ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,4),"0232","0233","0234"}) && szFactory.equals("올림푸스")) {
		rtnValue = "sp_logo_olympus.gif";
	}
	if(CutStr.cutStr(szCategory,4).equals("0709") && szFactory.equals("Bless")) {
		rtnValue = "sp_logo_zio.gif";
	}
	if(CutStr.cutStr(szCategory,4).equals("0402") && szFactory.equals("엡손")) {
		rtnValue = "sp_epson.gif";
	}
	**/
	return rtnValue;
}

public StringBuffer rtnList(Pricelist_Data[] arrList, String strZumFlag, String strCategory, String[][] cardFreeAry, String cardShopCodes, java.util.HashMap cardNameHash, String cardName, long lngInstanceMinPrice, long mMinPrice, String strCdate, String strCate4,long lngG9_plno, String tab_dminsort, HashMap<String, Goods_Lsv_11St_Data> goodsLsv11StMap){


	StringBuffer strOut = new StringBuffer();
	Goods_Lsv_11St_Proc goodsLsv11StProcAjax = new Goods_Lsv_11St_Proc();
	for(int i=0; i<arrList.length; i++) {
		if(arrList[i] != null ){
			if(!strZumFlag.equals("Y") || (strZumFlag.equals("Y") && arrList[i].getShop_code() != 6378 && arrList[i].getShop_code() != 6368 )){
				
				String strShop_name = arrList[i].getShop_name();
				String strPlGoodsNmM = arrList[i].getGoodsnm();
				long mPrice = arrList[i].getPrice();
				long instance_price = arrList[i].getInstance_price();
				String strGoodscode = arrList[i].getGoodscode();
				int deliveryType2 = arrList[i].getDeliverytype2();
				int deliveryInfo2 = arrList[i].getDeliveryinfo2();
				String strShop_url = arrList[i].getUrl();
				String strMobile_url = "";
				String deliveryInfo = arrList[i].getDeliveryinfo();
				String strPrice_flog = arrList[i].getDelivery();
				int Intmodelno = arrList[i].getModelno();
				int szVcode = arrList[i].getShop_code();
				int intPrice_card = arrList[i].getPrice_card();
				String strCa_code_l = arrList[i].getCa_code();
				long iPlno = arrList[i].getPl_no();
				String strGoodsfactory = arrList[i].getGoodsfactory();
				String strFreeinterest = arrList[i].getFreeinterest();
				String szSbName = strShop_name;
				String strAuthflag = arrList[i].getAuthflag().replace("0","");
				String strCardflag = "";
				String strCardfreeflag = "";
				String strFreeinterest_chk = "";
				String strCoupon = "";
				String strCouponflag = "";
				String strMinpriceflag = "";
				int intCoupon = arrList[i].getCoupon();
				String strDetail_url = arrList[i].getUrl1();
				
				//11번가 쿠폰 영역
				String eventCouponCheck = "";
				String eventCouponText = "";
				String eventCouponCss = "";
				//인터파크 쿠폰 영역 
				String interParkCouponCss = "";
				String interParkCouponPer = "";
				//다른 이벤트영역
				String eventCouponCheck_etc = "";
				String eventCouponText_etc = "";
				String eventCouponCss_etc = "";
				String eventCouponCss_link = "";
				
				String strShopBidFlag = "";
				
				//쇼핑몰 상위입찰용 개별로그번호
				String strLogno_view = "12628";  		//view 개별로그
				String strLogno_click = "12629";  		//click out 개별로그
				String strLogno_view_1 = "";
				String strLogno_click_1 = "";
				String strLogno_view_2 = "";
				String strLogno_click_2 = "";

				
				//G마켓 G9 리다이텍트 상품
				String strG9_model = "";
				if(lngG9_plno == iPlno){
					strG9_model =  "Y";
				}
				//쇼핑몰 상위입찰
				int intShop_bid = arrList[i].getShop_bid();
				String strShop_bid = "";

				if(intShop_bid > 0){
					strShop_bid = intShop_bid + "";
					
					strShopBidFlag = "Y";
				}
				//상위입찰 클릭번호 입력
				if(intShop_bid == 1){
					strLogno_view = strLogno_view_1;
					strLogno_click = strLogno_click_1;
				}else if(intShop_bid == 2){
					strLogno_view = strLogno_view_2;
					strLogno_click = strLogno_click_2;
				}else{
					strLogno_view = "";
					strLogno_click = "";
				}
				
				String strType = "";
		
				if(!strFreeinterest.equals("")){
					strFreeinterest_chk = "Y";	//할부내용은 필요없으며 할부여부만 필요.
				}
		
				if(arrList[i].getPrice_card()>0 && cardShopCodes.indexOf("|"+arrList[i].getShop_code())>-1 && checkEventCard(cardNameHash, arrList[i].getShop_code()+"", arrList[i].getGoodsnm(), arrList[i].getPrice(), strCategory)) {
					strCardflag = "Y";
				}
				if(!getForceFreeInterest2(arrList[i].getShop_code(), strCategory, arrList[i].getFreeinterest(), arrList[i].getPrice(), cardFreeAry).equals("")){
					strCardfreeflag = "Y";
				}
		
				String strPrice = "";
				String strInstance_Price = "";
				String strPrice_Card = "";
				
				if(instance_price > 0){
					instance_price = instance_price;
				}else{
					instance_price = 0;
				}
		
				// 신용카드 정보를 보여줘야 할 경우 제목에 신용카드 정보를 입력함
				String tempCardName = "";
		
				tempCardName = getCardNmEvent(cardNameHash, szVcode+"", strPlGoodsNmM, mPrice, strCa_code_l);
				/* if(szVcode==75 && !strGoodsfactory.equals("쇼핑지원금")) {
					tempCardName = tempCardName.replaceAll("쇼핑지원금:", "");
					tempCardName = tempCardName.replaceAll("쇼핑지원금", "");
				} */
		
				if(cardNameHash.containsKey(szVcode+"")) {
					// GS 쇼핑지원금
					if(szVcode==75 && tempCardName.indexOf(":")>-1 && (intPrice_card==mPrice || mPrice<50000)) {
						String[] aryCardName = tempCardName.split(":");
						if(aryCardName!=null && aryCardName.length>1) {
							tempCardName = aryCardName[0];
						}
					}
					szSbName += "-";
					szSbName += tempCardName;
				}
		
				if(szSbName.indexOf("-")>-1) {
					String[] szSbNameInfos = szSbName.split("-");
					if(szSbNameInfos!=null && szSbNameInfos.length>0){
						szSbName = szSbNameInfos[0];
						if(szSbNameInfos.length>1 && !tempCardName.equals("")){ //할인카드명이 있고 상품명에 카드명이 있을때만
							cardName = szSbNameInfos[1];
						}
					}
				}else{
					cardName = tempCardName;
				}
				
				if(szVcode==57 && cardName.length()>0) { //hmall
					if(strPlGoodsNmM.indexOf("[삼성카드")>-1) cardName = "삼성카드";
					if(strPlGoodsNmM.indexOf("[현대카드")>-1) cardName = "현대카드";
				}
				// 하이마트 예외처리
				if(szVcode==6252) {
					szSbName = szSbName.replace("하이마트쇼핑몰", "하이마트");
				}
				if(ControlUtil.compareValOR(new int[]{szVcode,806,6165}) && intPrice_card>0 && tempCardName.equals("CJ카드")){
					cardName = "CJ카드";
				}
				if(cardName.length()>0) {
					if(cardName.indexOf("CJ(씨티제외)")>-1) {
					} else {
						if(cardName.indexOf("쇼핑지원금")>-1) {
							if(cardName.indexOf(":")>-1) {
								String[] aryCardName = cardName.split(":");
								if(aryCardName!=null && aryCardName.length>1) {
									szSbName = aryCardName[1];
								}
							}
						}
					}
				}
		
				//상품명 강제변경
				strPlGoodsNmM = getGoodsNmReplace2(szVcode, strPlGoodsNmM, mPrice, strCa_code_l, true, strFreeinterest, cardFreeAry);
		
				String[] arrTempCardName = null;
				if(tempCardName.indexOf(",")>0){
					arrTempCardName = tempCardName.split(",");
				}
		
				//카드할인 문구 삭제
				strPlGoodsNmM = getGoodsNmCardReplace(szVcode, strPlGoodsNmM, tempCardName, arrTempCardName, mPrice, strCa_code_l, true);
		
				if(lngInstanceMinPrice == 0 && i == 0){
					mMinPrice = instance_price;
				}
		
				//쇼핑몰에 따른 모바일 url & 수입코드 변경
				strMobile_url = toUrlCode(strShop_url);
		
				// deliveryType2==0 : 배송비 정보가 불명확함
				// deliveryType2==1 : 배송비 정보가 정확학
				// 배송비 정보는 deliveryInfo2에 들어 있으며
				// deliveryInfo2==0 이면 무료배송
				// deliveryInfo의 정보는 배송비가 정해지는 규칙이 들어 있음(업체에서 입력)
				String tmpbbbbb = "";
				int ibbbbb_1 = 0;
				int ibbbbb_2 = 0;
				
				if(DateUtil.RtnDateComment(CutStr.cutStr(strCdate,10),"2010_list","").equals("예정")){
				}else if(instance_price==0 && ( strCate4.equals("0304") || strCate4.equals("0305") || strCate4.equals("0353"))){
				}else{
					if(instance_price == mMinPrice){
						strMinpriceflag = "Y";
						
						if(szVcode == 6641){	//티몬
							strDetail_url = "http://m.ticketmonster.co.kr/deal/detailDaily/bbbbb?page=review";
							//티몬은 strShop_url 에 p_no= 값 
							//strShop_url : http://www.ticketmonster.co.kr/entry/?jp=80024&ln=205013&p_no=175768289&o_no=175773197
							ibbbbb_1 = strShop_url.indexOf("&p_no=") + 6;
							if(strShop_url.indexOf("&o_no=") > ibbbbb_1){
								ibbbbb_2 = strShop_url.indexOf("&o_no=");	
							}else{
								ibbbbb_2 = strShop_url.length();
							}
							
							if(ibbbbb_1 < ibbbbb_2){
								tmpbbbbb = strShop_url.substring(ibbbbb_1, ibbbbb_2);
								strDetail_url = strDetail_url.replace("bbbbb", tmpbbbbb);
							}else{
								strDetail_url = strShop_url;
							}
						}else if(szVcode == 6508){	//위메프
							strDetail_url = "http://m.wemakeprice.com/m/deal/detail_expand/bbbbb";
							//위메프는 strShop_url 에 /enuri/982425/Y 사이값
							//strShop_url : http://www.wemakeprice.com/widget/aff_bridge_public/enuri/931477/Y/PRICE_af/931477/0240A7/enuri
							ibbbbb_1 = strShop_url.indexOf("/enuri/") + 7;
							ibbbbb_2 = strShop_url.indexOf("/Y/");
							if(ibbbbb_1 < ibbbbb_2){
								tmpbbbbb = strShop_url.substring(ibbbbb_1, ibbbbb_2);
								strDetail_url = strDetail_url.replace("bbbbb", tmpbbbbb);
							}else{
								strDetail_url = strShop_url;
							}
						}
					} 
				}
				if(strShopBidFlag.equals("Y") && intShop_bid < 1 && strMinpriceflag.equals("Y")){
					strMinpriceflag = "";
				}
				
				if(!deliveryInfo.equals("무료배송")){
					if(deliveryType2 != 0){
						if(deliveryType2 == 1 && deliveryInfo2 == 0){
						}else{
							if(tab_dminsort.equals("Y")){
								instance_price = instance_price + Long.parseLong(deliveryInfo2+"");
							}
						}
					}
				}
				
		
				/* 2015.01.13. 모바일가격으로 변경
				if(DateUtil.RtnDateComment(CutStr.cutStr(strCdate,10),"2010_list","").equals("예정")){
					strPrice = "미정";
				}else if(mPrice==0 && ( strCate4.equals("0304") || strCate4.equals("0305") || strCate4.equals("0353"))){
					//strPrice = "클릭";
					strPrice = toNumFormat(mPrice) + " 원";
				}else{
					strPrice = toNumFormat(mPrice) + " 원";
				}
				*/
		
				if(DateUtil.RtnDateComment(CutStr.cutStr(strCdate,10),"2010_list","").equals("예정")){
					strInstance_Price = "미정";
				}else if(instance_price==0 && ( strCate4.equals("0304") || strCate4.equals("0305") || strCate4.equals("0353"))){
					strInstance_Price = toNumFormat(instance_price)+"";
				}else{
					strInstance_Price = toNumFormat(instance_price)+"";
				}
		
		
				//쿠폰여부
				if(szVcode==4027 || szVcode==536 || szVcode==663){
					strType = "2";				//case2. 모바일 제휴& 할인 자동 적용
				}else if(szVcode==75  ){
					strType = "6";
				}else if(szVcode==57){
					strType = "6";
				}else if(szVcode==55 || szVcode==806 || szVcode==90  || szVcode==1878){
					strType = "6";				//case6. 모바일 제휴 & 쿠폰 유무를 모를 때
				}else if(szVcode==5910 || szVcode==49 || szVcode==47 || szVcode==6547 || szVcode==6588  || szVcode==6603 ){
					strType = "7";				//case7. 모바일 제휴 & CTU 적용 불가
				}else if(szVcode==6620){		// 특이. 갤러리아몰은 쿠폰필드 1이면 case6, 쿠폰필드0이면 case2
					if(intCoupon == 1){
						strType = "6";
					}else{
						strType = "2";
					}
				}else if(szVcode==663){		// 특이. 롯데아이몰은 쿠폰필드 1이면 case5, 쿠폰필드0이면 case2
					if(intCoupon == 1){
						strType = "5";
					}else{
						strType = "2";
					}
				}else if(szVcode==6665){
					if(intCoupon == 1){
						strType = "6";
					}else{
						strType = "2";
					}
				}else{
					strType = "7";				//case7. 모바일 비제휴 ---> 일단 case2로...
				}
		
				if(strCate4.equals("0304") && (szVcode==806 || szVcode==663 || szVcode==55 || szVcode==57) ){
					strType = "7";
				}
				/********************************************
		   		카카오페이 광고 문구 Start
		   		 - 노출 기간 
		   		    * 인터파크(55): 9/1 ~ 9/30
		   		    * CJ오쇼핑(806) : 9/5 ~ 9/23
		   		    * 위메프(6508) : 9/1 ~ 9/16
		 	  **********************************************/
	    		// 11월 카카오페이 광고 문구 노출
	    		if(szVcode == 55 && DateStr.nowStr("yyyy.MM.dd. HH:mm").compareTo("2018.11.01. 00:00") > 0 && DateStr.nowStr("yyyy.MM.dd. HH:mm").compareTo("2018.11.30. 23:59")<=0) {
					eventCouponCheck_etc = "1";
					eventCouponText_etc = "카카오페이 3만원이상 1천원 쿠폰";
					eventCouponCss_etc = "addtxt";
					eventCouponCss_link = "";	//없으면 클릭없음.
	    		}
	    		if(szVcode == 806 && DateStr.nowStr("yyyy.MM.dd. HH:mm").compareTo("2018.11.01. 00:00") > 0 &&  DateStr.nowStr("yyyy.MM.dd. HH:mm").compareTo("2018.11.30. 23:59")<=0) {
	    			eventCouponCheck_etc = "1";
					eventCouponText_etc = "카카오페이 7% 카드 청구할인";
					eventCouponCss_etc = "addtxt";
					//eventCouponCss_link = "";	//없으면 클릭없음.
	    		}
	    		if(szVcode == 6508 && DateStr.nowStr("yyyy.MM.dd. HH:mm").compareTo("2018.11.01. 00:00") > 0 &&  DateStr.nowStr("yyyy.MM.dd. HH:mm").compareTo("2018.11.15. 23:59")<=0) {
	    			eventCouponCheck_etc = "1";
					eventCouponText_etc = "카카오페이 5만원이상 5% 할인";
					eventCouponCss_etc = "addtxt";
					//eventCouponCss_link = "";	//없으면 클릭없음.
	    		}
	    		
	    		// 12월 카카오페이 광고 문구 노출
	    		// CJ 오쇼핑 날짜 지정
				String nowDate = DateStr.nowStr("yyyy.MM.dd.");
				boolean isCjView = false;
				if (nowDate.indexOf("2018.12.12.") > -1 || nowDate.indexOf("2018.12.13.") > -1 || nowDate.indexOf("2018.12.19.") > -1 || nowDate.indexOf("2018.12.20.") > -1
						 || nowDate.indexOf("2018.12.24.") > -1 || nowDate.indexOf("2018.12.25.") > -1 || nowDate.indexOf("2018.12.30.") > -1 || nowDate.indexOf("2018.12.31.") > -1){
					isCjView = true;
				}
				
	    		if(szVcode == 55 && DateStr.nowStr("yyyy.MM.dd. HH:mm").compareTo("2018.12.01. 00:00") > 0  && DateStr.nowStr("yyyy.MM.dd. HH:mm").compareTo("2018.12.31. 23:59")<=0) {
					eventCouponCheck_etc = "1";
					eventCouponText_etc = "카카오페이 3만원이상 1천원 쿠폰";
					eventCouponCss_etc = "addtxt";
					eventCouponCss_link = "";	//없으면 클릭없음.
	    		}
	    		if(szVcode == 806 && isCjView) {
	    			eventCouponCheck_etc = "1";
					eventCouponText_etc = "카카오페이 7% 카드 청구할인";
					eventCouponCss_etc = "addtxt";
					//eventCouponCss_link = "";	//없으면 클릭없음.
	    		}
	    		if(szVcode == 6508 && DateStr.nowStr("yyyy.MM.dd. HH:mm").compareTo("2018.12.01. 00:00") > 0  && DateStr.nowStr("yyyy.MM.dd. HH:mm").compareTo("2018.12.31. 23:59")<=0) {
	    			eventCouponCheck_etc = "1";
					eventCouponText_etc = "카카오페이 4~6% 쿠폰 할인";
					eventCouponCss_etc = "addtxt";
					//eventCouponCss_link = "";	//없으면 클릭없음.
	    		}
			   /********************************************
		   			카카오페이 광고 문구 End
		   		**********************************************/
				if(strPlGoodsNmM.indexOf("에누리") > -1 && strPlGoodsNmM.indexOf("추가할인") > -1){
					strCoupon = strPlGoodsNmM.substring(0, strPlGoodsNmM.indexOf("추가할인")+4);
					if( strCoupon.indexOf("추가할인") > strCoupon.indexOf("에누리")){
						strCoupon = strCoupon.substring(strCoupon.indexOf("에누리")+3, strCoupon.indexOf("추가할인"));
					}
				}
		
				//SSG(6665) 쿠폰 관련 (모델명에 할인문구 있을경우 케이스 추가)
				if(szVcode == 6665 && strType.equals("6") && strPlGoodsNmM.indexOf("에누리") > -1 && strPlGoodsNmM.indexOf("더블할인쿠폰") > -1 ){
					strCoupon = strPlGoodsNmM;
					strCoupon = strCoupon.substring(strCoupon.indexOf("에누리")+3, strCoupon.indexOf("% 더블할인쿠폰")+1).replace(" ","");
					strType = "4";
				}
		
				if(!strCoupon.equals("") || strType.equals("4") || strType.equals("5") || strType.equals("6") ){
					strCouponflag = "Y";
				}
		
				//if(szVcode==4027 || szVcode==55 || szVcode==536){
				//	strShop_name = "PC 최저가";
		
				//}
			
				
				//카드할인가 천단위콤마추가
				strPrice_Card = toNumFormat(intPrice_card)+"";

				// 프로모션 자동화
				String moblVipCpnViewDcd = "";			// VIP 쿠폰 노출 구분 코드 : 문구노출 M, 쿠폰 할인가노출 C, 비노출, N
				String moblVipCpnViewDcd_M = "";			
				String moblVipCpnViewDcd_C = "";
				String moblVipCpnViewStr = "";				// VIP 쿠폰 노출 문자열 : 문구 또는 할인가 문구
				String moblVipCpnIcnViewYn = "";			// VIP 쿠폰 아이콘 노출 여부 
				String moblVipCpnDcViewYn = "";			// VIP 쿠폰 할인 노출 여부
				String moblPromtnUrl = "";					// 프로모션 랜딩 URL
				String vipCpnDcCndCd = "";					// 정액 인지 정률 구분값
				int vipDcPrice = 0;								// VIP 상품 할인가
				String moblCouponTxt = "";
				String pcMiniVipIcnViewDcd = "";	//미니VIP 아이콘 노출 구분 코드 : 쿠폰 받기 노출 C, 이벤트 아이콘 노출: M
				String pcMiniVipIcnStr = "";			// 미니 VIP 아이콘 문자열
				
				if (goodsLsv11StMap.containsKey(strGoodscode)) {
					Goods_Lsv_11St_Data goodsLsv11StData = goodsLsv11StMap.get(strGoodscode);

					if (goodsLsv11StData != null) {
						vipCpnDcCndCd = goodsLsv11StData.getCpn_dc_cnd_cd();
						moblVipCpnViewDcd = goodsLsv11StData.getMobl_vip_cpn_view_dcd();					
						moblVipCpnViewStr = goodsLsv11StData.getMobl_vip_cpn_view_str();
						moblVipCpnIcnViewYn = goodsLsv11StData.getMobl_vip_cpn_icn_view_yn();
						moblVipCpnDcViewYn = goodsLsv11StData.getMobl_vip_cpn_dc_view_yn();
						vipDcPrice = goodsLsv11StProcAjax.accDiscountPrice(goodsLsv11StData, (int)mPrice);
						moblPromtnUrl = goodsLsv11StData.getMobl_promtn_url();

						if (!moblVipCpnIcnViewYn.equals("Y")) {moblVipCpnIcnViewYn = "";}
						
						if (moblVipCpnViewDcd.equals("M")) {
							moblVipCpnViewDcd_M = "Y";
						} else if (moblVipCpnViewDcd.equals("C")) {
							moblVipCpnViewStr = "(" + strShop_name + " " + moblVipCpnViewStr + " " + toNumFormat(vipDcPrice) + "원)";
							moblVipCpnViewDcd_C = "Y";
						}
						
						if (vipCpnDcCndCd.equals("R")) {					// 정률
							moblCouponTxt = Integer.toString(goodsLsv11StData.getCpn_dc_rt())+"%";
						} else if (vipCpnDcCndCd.equals("P")) {			// 정액
							if (goodsLsv11StData.getCpn_dc_amt() > 0) {
								moblCouponTxt = toNumFormat(goodsLsv11StData.getCpn_dc_amt())+"원";
							} else {
								moblCouponTxt = "";
							}
						}
					}
				}		
					
				
				if(i>0) strOut.append("	,\r\n");
				strOut.append("	{ ");
				strOut.append("		\"shopname\":\""+ toJS2(strShop_name) +"\", ");
				strOut.append("		\"shopurl\":\""+ toJS2(strShop_url) +"\", ");
				strOut.append("		\"shopcode\":\""+ toJS2(szVcode+"") +"\", ");
				strOut.append("		\"mobileurl\":\""+ toJS2(strMobile_url) +"\", ");
				strOut.append("		\"price\":\""+ strInstance_Price +"\", ");
				strOut.append("		\"instanceprice\":\""+ toJS2(instance_price+"") +"\", ");
				strOut.append("		\"goodscode\":\""+ toJS2(strGoodscode) +"\", ");
				strOut.append("		\"minprice\":\""+ mMinPrice +"\", ");
				strOut.append("		\"plno\":\""+ toJS2(iPlno+"") +"\", ");
				strOut.append("		\"ca_code\":\""+ toJS2(strCa_code_l) +"\", ");
				strOut.append("		\"category\":\""+ toJS2(strCategory) +"\", ");

				// 제휴 마케팅 요청으로 VIP title 강제 적용 : G마켓, 옥션 경우만	20180619	
				if (DateStr.nowStr("yyyy.MM.dd. HH:mm").compareTo("2018.08.31. 23:59")<=0 && (536 == szVcode || 4027 == szVcode) ) {
					strPlGoodsNmM = "[스마일카드,2% 캐시백] "+strPlGoodsNmM;
				}		
				
				// 제휴 마케팅 요청으로 VIP title 강제 적용 : 11번가 [신한카드 청구할인 2%] 20180725
				// 노출 제외 카테고리 정보 추가 : 1647 (모바일쿠폰, 상품권), 93 (도서), 145210 (패션 >쥬얼리,헤어액세서리 >순금/돌반지)
				boolean isNoCateCd = true;
				if (CutStr.cutStr(strCategory,4).equals("1647") || CutStr.cutStr(strCategory,2).equals("93") || CutStr.cutStr(strCategory,6).equals("145210") ) {
					isNoCateCd = false;
				}

				// VIP > 11번가 상품명 앞 카드 할인 문구 노출
/* 
				if (DateStr.nowStr("yyyy.MM.dd. HH:mm").compareTo("2019.02.18. 00:00") > 0 && DateStr.nowStr("yyyy.MM.dd. HH:mm").compareTo("2019.12.31. 23:59")<=0 && 5910 == szVcode && isNoCateCd ) {
					strPlGoodsNmM = " [신한카드 1% 청구할인] "+strPlGoodsNmM;
				}
*/					 
				 // 쿠팡이면서 상품코드에I가 있을 경우 로켓배송 추가
				 if (7861 == szVcode && strGoodscode.indexOf("I") > -1 ) {
					 strPlGoodsNmM = " [로켓배송] "+strPlGoodsNmM;
				}
				strOut.append("		\"plgoodsname\":\""+ toJS2(strPlGoodsNmM) +"\", ");
				strOut.append("		\"deliveryinfo1\":\""+ toJS2(deliveryInfo) +"\", ");
				strOut.append("		\"deliveryinfo2\":\""+ toJS2(deliveryInfo2+"") +"\", ");
				strOut.append("		\"cardname\":\""+ toJS2(cardName) +"\", ");
				strOut.append("		\"authflag\":\""+ toJS2(strAuthflag) +"\", ");
				strOut.append("		\"cardflag\":\""+ toJS2(strCardflag) +"\", ");
				strOut.append("		\"cardfreeflag\":\""+ toJS2(strCardfreeflag) +"\", ");
				strOut.append("		\"freeinterestflag\":\""+ toJS2(strFreeinterest_chk) +"\", ");
				strOut.append("		\"couponflag\":\""+ toJS2(strCouponflag) +"\", ");
				strOut.append("		\"mpriceflag\":\""+ toJS2(strMinpriceflag) +"\", ");
				strOut.append("		\"pricecard\":\""+ toJS2(strPrice_Card) +"\", ");
				strOut.append("		\"detail_url\":\""+  toJS2(strDetail_url) +"\", ");
				if(deliveryInfo.equals("무료배송")){
					strOut.append("		\"displaydelivery\":\"무료배송\", ");
				}else{
					if(deliveryType2 == 0){
						if (deliveryInfo.equals("")){	//유무료
							strOut.append("		\"displaydelivery\":\"유무료\", ");
						}else{
							strOut.append("		\"displaydelivery\":\""+deliveryInfo+"\", ");
						}
					}else{
						if(deliveryType2 == 1 && deliveryInfo2 == 0){
							strOut.append("		\"displaydelivery\":\"무료배송\", ");
						}else{
							if(tab_dminsort.equals("Y")){
								strOut.append("		\"displaydelivery\":\""+toNumFormat(Long.parseLong(deliveryInfo2+""))+"원 포함\" ");
							}else{
								strOut.append("		\"displaydelivery\":\""+toNumFormat(Long.parseLong(deliveryInfo2+""))+"원 별도\", ");
							}
						}
					}
				}
				strOut.append("		\"shop_bid\":\""+  strShop_bid +"\", ");
				if(intShop_bid > 0){
					strOut.append("	\"shopbidflag\":\"Y\",  ");
					strOut.append("	\"shopbidlogno_view\":\""+ strLogno_view +"\",  ");
					strOut.append("	\"shopbidlogno_click\":\""+ strLogno_click +"\",  ");
				}else{
					strOut.append("	\"shopbidflag\":\"\",  ");
					strOut.append("	\"shopbidlogno_view\":\"\",  ");
					strOut.append("	\"shopbidlogno_click\":\"\",  ");
				}
				if(!arrList[i].getMobile_bid_flag().equals("")){
					strOut.append("		\"mobile_bid_flag\":\""+ arrList[i].getMobile_bid_flag() +"\", ");
				}else{
					strOut.append("		\"mobile_bid_flag\":\"\", ");
				}
				//G마켓 G9 예외
				strOut.append("	\"gmarket_g9\":\""+ strG9_model +"\",  ");
				//11번가 쿠폰프로모션 2017-09-14 
				strOut.append("	\"eventCoupon\":\""+ eventCouponCheck +"\",  ");
				strOut.append("	\"eventCouponText\":\""+ eventCouponText +"\", ");
				strOut.append("	\"eventCouponCss\":\""+ eventCouponCss +"\",  ");
				//인터파크 쿠폰 프로모션 2018-04-03
				strOut.append("	\"interParkCouponPer\":\""+interParkCouponPer+"\",  ");
				strOut.append("	\"interParkCouponCss\":\""+interParkCouponCss+"\",  ");
				//다른 쿠폰프로모션 2017-12-04
				strOut.append("	\"eventCouponCheck_etc\":\""+ eventCouponCheck_etc +"\",  ");
				strOut.append("	\"eventCouponText_etc\":\""+ eventCouponText_etc +"\",  ");
				strOut.append("	\"eventCouponCss_etc\":\""+ eventCouponCss_etc +"\",  ");
				strOut.append("	\"eventCouponCss_link\":\""+ eventCouponCss_link +"\",  ");

				//11번가 쿠폰프로모션 2017-09-14 --- 여기 신규 파일명으로 다시 만들어서 내려 주도록 한다. 
				strOut.append("	\"mobl_vip_cpn_view_dcd\":\""+ moblVipCpnViewDcd +"\", ");
				strOut.append("	\"mobl_vip_cpn_view_dcd_M\":\""+ moblVipCpnViewDcd_M +"\", ");
				strOut.append("	\"mobl_vip_cpn_view_dcd_C\":\""+ moblVipCpnViewDcd_C +"\", ");
				strOut.append("	\"mobl_vip_cpn_view_str\":\""+ moblVipCpnViewStr +"\",  ");
				strOut.append("	\"mobl_vip_cpn_icn_view_yn\":\""+ moblVipCpnIcnViewYn +"\",  ");
				strOut.append("	\"mobl_vip_cpn_dc_view_yn\":\""+ moblVipCpnDcViewYn +"\", ");
				strOut.append("	\"mobl_promtn_url\":\""+ moblPromtnUrl +"\",  ");
				strOut.append("	\"mobl_coupon_txt\":\""+ moblCouponTxt +"\"  ");
				
				strOut.append("	}");
			}
		}
	}
	
	return strOut;
}

//public Pricelist_Data[][] orderPricelist(Goods_Data goods_data, Pricelist_Data[] aszPlist, String szCallDataOpt, boolean opt_termSumFlag, boolean phonePriceAllFlag, boolean tariffFlag, boolean authShowFlag, String cardShopCodes, java.util.HashMap cardNameHash, boolean jungoModelFind, java.util.HashMap phonePriceAllHash) {
public Pricelist_Data[][] orderPricelist(Goods_Data goods_data, Pricelist_Data[] aszPlist) {
	Goods_Search Goods_Search = new Goods_Search();
	Pricelist_Proc Pricelist_Proc = new Pricelist_Proc();
	//좌측 우측값 구분.
	Pricelist_Data[] aszLeftList = null;
	Pricelist_Data[] aszRightList = null;
	Pricelist_Data[][] result_list = new Pricelist_Data[2][];

	Pricelist_Data pl_data = null;
	Pricelist_Data[] aszTmpPlist = null;
	Pricelist_Data[] aszPlistAccuracy = null;

	try{

		java.util.ArrayList left_list = new java.util.ArrayList();
		java.util.ArrayList right_list = new java.util.ArrayList();

		if(goods_data==null || aszPlist==null){
			return null;
		}

		int nModelNo = goods_data.getModelno();
		String strOpenExpectFlag = goods_data.getOpenexpectflag();
		String szModelNm = goods_data.getModelnm();
		String szFactory = goods_data.getFactory();
		String szCategory = goods_data.getCa_code();
		String szSpec = goods_data.getSpec();
		String strFactory_etc = goods_data.getFactory_etc().trim();
		String strConstrain = goods_data.getConstrain();
		String strCondi = goods_data.getCondiname();
		long mMinPrice = goods_data.getMinprice();
		int pintMallCnt = goods_data.getMallcnt();
		long intMinPrice = 0;

		if(strOpenExpectFlag.equals("1")){ //출시예정은 목록 없음
			return null;
		}

		if(szFactory.equals("[불명]")){
			szFactory = "";
		}
		// 특정 분류는 제조사 안보임
		if(CutStr.cutStr(szCategory,8).equals("16420904") || CutStr.cutStr(szCategory,8).equals("16421014") || CutStr.cutStr(szCategory,6).equals("032406")){
			szFactory = "";
		}
		szModelNm = replaceModelNmSpecialChar(szCategory, szModelNm);

		int nAuthLCnt = 0;
		String szCallDataOpt = "";
		boolean opt_termSumFlag = false;
		boolean phonePriceAllFlag = false;
		boolean tariffFlag = false; //해외쇼핑 관세상품여부
		boolean authShowFlag = false; // 제조사 인증 공식판매자 여부 확인
		int junggoShowType = 0;
		java.util.HashMap phonePriceAllHash = new java.util.HashMap();

		int i = 0;
		int dj = 0;
		int nLCnt = 0;
		int nRCnt = 0;

		phonePriceAllFlag = checkPhonePriceAllFlag(szCategory, szModelNm);

		String phoneNetworkType = "3G";
		int iPhoneNetworkCate = 0;
		if(CutStr.cutStr(szCategory,4).equals("0304") || CutStr.cutStr(szCategory,8).equals("02332217")){
			iPhoneNetworkCate = Goods_Search.getCountModelCate(nModelNo, "030448");
		}else if(CutStr.cutStr(szCategory,4).equals("0305")){
			iPhoneNetworkCate = Goods_Search.getCountModelCate(nModelNo, "03051901");
		}
		if(iPhoneNetworkCate>0) phoneNetworkType = "LTE";
		if(CutStr.cutStr(szCategory,8).equals("02332217") && szModelNm.indexOf("LTE")>-1) phoneNetworkType = "LTE";
		String phoneCompany = ""; //통신사(SKT, KT, LGT)
		if(szModelNm.indexOf("(SKT")>=0 || szModelNm.indexOf("[SKT")>=0){
			phoneCompany = "SKT";
		}else if(szModelNm.indexOf("(LG")>=0 || szModelNm.indexOf("[LG")>=0){
			phoneCompany = "LGT";
		}else if(szModelNm.indexOf("(KT")>=0 || szModelNm.indexOf("[KT")>=0){
			phoneCompany = "KT";
		}

		if(ChkNull.chkStr(szCallDataOpt).equals("")) {
			if(mMinPrice > 100000) {
				szCallDataOpt = "opt_scale";
			} else {
				if(ChkNull.chkStr(szCallDataOpt).equals("") || (ChkNull.chkStr(szCallDataOpt).equals("opt_auth") && nAuthLCnt == 0))	{
					szCallDataOpt = "opt_term";
				}
			}

			if((szCategory.length() >= 2 && ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,2),"14"})) && mMinPrice<100000) {
				szCallDataOpt = "opt_term";
				opt_termSumFlag = false;
			}
			if(ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,8),"02010109","02010110"})) {
				szCallDataOpt = "opt_term";
				opt_termSumFlag = false;
			}
			if(ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,6),"090503","090504","090505","090506","090508","090509","090511","090519"})) {
				szCallDataOpt = "opt_term";
				opt_termSumFlag = false;
			}
			if(ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,4),"1242","2406","2403"})) {
				szCallDataOpt = "opt_term";
				opt_termSumFlag = false;
			}
		}
		if((szCategory.length() >= 2 && ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,2),"14"})) && mMinPrice<100000) {
			opt_termSumFlag = false;
		}
		//영상음향 > TV > 브라운관 정렬기준 변경  : 대형몰 / 전문 쇼핑몰 → 무료배송 쇼핑몰 / 배송비 유료 쇼핑몰
		if(ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,6),"020101","020102"})) {
			opt_termSumFlag = false;
		}
		if(ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,6),"090503","090504","090505","090506","090508","090509","090511","090519"})) {
			opt_termSumFlag = false;
		}
		if(CutStr.cutStr(szCategory,2).equals("14")) {
			opt_termSumFlag = false;
		}
		if(ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,4),"0405","0503","0527","0601","0604","0621","1220","1201","1202","1203","1204","1205","1207"})
			|| ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,6),"031502","031503"})
		){
			szCallDataOpt = "opt_term";
			opt_termSumFlag = false;
		}
		// 오픈마켓/일반몰 기준
		if(CutStr.cutStr(szCategory,6).equals("033308") || CutStr.cutStr(szCategory,6).equals("080710") || CutStr.cutStr(szCategory,8).equals("03330501")) {
			szCallDataOpt = "opt_scale";
		}
		// 오픈마켓/일반몰 기준 : 상품권
		if(ControlUtil.compareValOR(new int[]{nModelNo,1248637,1720032,1720028,1247170,1248620,1248888,1248623,1370212,1370216,1267468,1248613,1267467,1248860,1243685})
			|| ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,8),"03330501"})
			|| CutStr.cutStr(szCategory,4).equals("0304")
			|| CutStr.cutStr(szCategory,8).equals("02332217")
			|| ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,4),"0404","0501","2401"})
		){
			szCallDataOpt = "opt_scale";
			opt_termSumFlag = false;
		}
		if(szModelNm.indexOf("[")>=0 && szModelNm.indexOf("]")>=0 && szModelNm.indexOf("[렌탈")>=0){
			szCallDataOpt = "opt_scale";
			opt_termSumFlag = false;
		}
		if(ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,4),"0527"}) && szModelNm.indexOf("약정조건")>=0) {
			szCallDataOpt = "opt_scale";
			opt_termSumFlag = false;
		}
		if(ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,6),"033316","033317","033318","033319","033305","033308","090813","090816","090817"})
			|| (ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,6),"033301"}) && szModelNm.indexOf("PIN번호")>-1)
			|| (ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,4),"1647"}) && szModelNm.indexOf("PIN번호")>-1)
			|| (ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,4),"1647"}) && szSpec.indexOf("모바일상품권")>-1)
			|| (ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,4),"1647"}) && szSpec.indexOf("모바일쿠폰")>-1)
		){
			szCallDataOpt = "opt_scale";
			opt_termSumFlag = false;
		}
		//에어컨
		String airconFlag = "";
		if(CutStr.cutStr(szCategory,4).equals("0501") || CutStr.cutStr(szCategory,4).equals("2401")){
			//airconFlag = Goods_Search.getAirconFlag(nModelNo);
			if(!airconFlag.equals("")){
				szCallDataOpt = "opt_aircon";
			}
		}
		if(CutStr.cutStr(szCategory,6).equals("030403") && szModelNm.indexOf("지정요금제-보상")>-1) {
			szCallDataOpt = "opt_shocking2";
			opt_termSumFlag = false;
		}
		// 전시,중고,반품 구분이 있는지 확인
		boolean jungoModelFind = false;
		try {
			if(!phonePriceAllFlag && szModelNm.indexOf("[")>-1 && szModelNm.substring(szModelNm.indexOf("[")).indexOf("중고")>-1 && !((ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,4),"0304","0305"}) || CutStr.cutStr(szCategory,8).equals("02332217")) && szModelNm.indexOf("해외쇼핑")>-1)) {
				jungoModelFind = true;
			}
		} catch(Exception e) {}
		//해외쇼핑 관세기준
		if(szModelNm.indexOf("[")>-1 && szModelNm.substring(szModelNm.indexOf("[")).indexOf("해외쇼핑")>-1){
			if(mMinPrice>=100000){
				szCallDataOpt = "opt_tariff";
				jungoModelFind = false;
				tariffFlag = true;
			}else{
				szCallDataOpt = "opt_term";
				opt_termSumFlag = false;
			}
		}

		// 옵션필수는 목록에서 제거
		try {
			Pricelist_Data[] aszDelPlist = (Pricelist_Data[])aszPlist.clone();
			int newPricelistCnt = 0;
			for(int deli=0; deli<aszDelPlist.length; deli++) {
				if(!aszDelPlist[deli].getOption_flag2().equals("1")) {
					newPricelistCnt++;
				}
			}
			if(newPricelistCnt>0) {
				aszPlist = new Pricelist_Data[newPricelistCnt];
				int aszCnt = 0;
				for(int deli=0; deli<aszDelPlist.length; deli++) {
					if(!aszDelPlist[deli].getOption_flag2().equals("1")) {
						aszPlist[aszCnt] = aszDelPlist[deli].cloneMe();
						aszCnt++;
					}
				}
			} else {
				aszPlist = null;
			}
		} catch(Exception e) {
		}

		// 옵션 필수,비교 상품이 있는지 확인
		if(aszPlist!=null) {
			for(int deli=0; deli<aszPlist.length; deli++) {
				// 제조사 인증 공식판매자 여부 확인
				if(!authShowFlag && !aszPlist[deli].getOption_flag2().equals("1") && aszPlist[deli].getAuthflag().equals("Y")) {
					if(!getAuthLogoCheck(szCategory, szFactory).equals("")){
						authShowFlag = true;
					}
				}
				//노트북 분류 필수옵션 좌우구분 (7:필수옵션확인요망-우측)
				if(!szCallDataOpt.equals("opt_nboption") && (CutStr.cutStr(szCategory,4).equals("0404") || (!phonePriceAllFlag && CutStr.cutStr(szCategory,4).equals("0305"))) && aszPlist[deli].getAirconfeetype().equals("7")){
					szCallDataOpt = "opt_nboption";
				}
				//타이어 분류 무료장착 좌우구분 (2:전국무료장착-좌측)
				if(!szCallDataOpt.equals("opt_freeset") && CutStr.cutStr(szCategory,4).equals("2115") && szModelNm.indexOf("무료장착")>0){
					szCallDataOpt = "opt_freeset";
				}
			}
		}
		if(aszPlist != null)	{
			dj = aszPlist.length;
		}
		if(aszPlist!=null) {
			// 휴대폰 가격표시
			if(phonePriceAllFlag) {
				try {
					// 클래스 읽기는 임시 주석처리
					String phonePriceInfoList = "";
					boolean dbDataReadFlag = false;

					String plnos = "";
					for(i=0; i<aszPlist.length; i++) {
						if(aszPlist[i].getPrice_flag().equals("0")){
							if(!plnos.equals("")) plnos += ",";
							plnos += aszPlist[i].getPl_no();
							if(i>0 && i%900==0) plnos += "=";
							if(!dbDataReadFlag) {
								dbDataReadFlag = true;
							}
						}
					}

					if(dbDataReadFlag) {
						String[] plnosAry = plnos.split("=");
						if(plnosAry!=null) {
							for(int pi=0; pi<plnosAry.length; pi++) {
								String phonePriceInfoListTemp = "";
								try {
									phonePriceInfoListTemp = Pricelist_Proc.getPhonePriceInfo(plnosAry[pi], phoneNetworkType, phoneCompany); //판매가 추가정보 테이블에서 데이터 가져오기
									phonePriceInfoList = phonePriceInfoList + phonePriceInfoListTemp;
								} catch(Exception e) {}
							}
						}
					}
					phonePriceInfoList = "\r\n" + phonePriceInfoList;

					if(phonePriceInfoList.length()>0) {
						String[] phonePriceInfoListAry = phonePriceInfoList.split("\r\n");
						if(phonePriceInfoListAry!=null) {
							for(i=0; i<phonePriceInfoListAry.length; i++) {
								if(phonePriceInfoListAry[i].length()>=4) {
									String[] phonePriceInfoAry = phonePriceInfoListAry[i].split("\t");
									if(phonePriceInfoAry.length>=7) {
										long tempPlno = 0;
										try {
											tempPlno = Long.parseLong(phonePriceInfoAry[0]);
										} catch(Exception e) {}
										if(tempPlno>0) {
											String tempPhonePriceInfo = phonePriceInfoAry[1]+","+phonePriceInfoAry[2]+","+phonePriceInfoAry[3]+","+phonePriceInfoAry[4]+","+((phonePriceInfoAry.length>7)?phonePriceInfoAry[7]:"");
											phonePriceAllHash.put(tempPlno, tempPhonePriceInfo);
										}
									}
								}
							}
						}
					}
					//판매가몰이면서 강제추가(추가정보가 없는 상품)의 경우 세팅
					/**
					for(i=0; i<aszPlist.length; i++) {
						if(aszPlist[i].getPrice_flag().equals("0")){
							if(!phonePriceAllHash.containsKey(aszPlist[i].getPl_no())){
								String tempPhonePriceInfo = ",,,0,";
								phonePriceAllHash.put(aszPlist[i].getPl_no(), tempPhonePriceInfo);
							}
						}
					}
					*/


					//가격재정렬 : 휴대폰 판매가기준에서 특정 요금제 선택시 판매가업체가 오른쪽으로 이동될때 오른쪽에서 상위에 먼저 노출되어야 함
					for(int sorti=0; sorti<aszPlist.length-1; sorti++) {
						for(int sortj=sorti+1; sortj<aszPlist.length; sortj++) {
							long tempPlnoI = aszPlist[sorti].getPl_no();
							long tempPlnoJ = aszPlist[sortj].getPl_no();

							String tempPhonePriceAllHashI = ChkNull.chkStr((String)phonePriceAllHash.get(tempPlnoI), "");
							String tempPhonePriceAllHashJ = ChkNull.chkStr((String)phonePriceAllHash.get(tempPlnoJ), "");

							if(tempPhonePriceAllHashI!=null && tempPhonePriceAllHashI.length()>0) {

							}else if(tempPhonePriceAllHashJ!=null && tempPhonePriceAllHashJ.length()>0) {
								Pricelist_Data tempData = null;

								tempData = aszPlist[sorti].cloneMe();
								aszPlist[sorti] = aszPlist[sortj].cloneMe();
								aszPlist[sortj] = tempData.cloneMe();
								break;
							}else{
								long priceI = (int)aszPlist[sorti].getTmp_price();
								long priceJ = (int)aszPlist[sortj].getTmp_price();

								if(sorti>0){
									int priceI_pre = (int)aszPlist[sorti-1].getTmp_price();
									if(priceI>priceI_pre){
										//aszPlist[sorti].setBid_flag(""); //최저가가 아니면 상위입찰 상태 무시 => 여기서 하면 오류
									}
								}

								if(priceI>priceJ) {
									//aszPlist[sorti].setBid_flag(""); //최저가가 아니면 상위입찰 상태 무시 => 여기서 하면 오류
									Pricelist_Data tempData = null;

									tempData = aszPlist[sorti].cloneMe();
									aszPlist[sorti] = aszPlist[sortj].cloneMe();
									aszPlist[sortj] = tempData.cloneMe();
								}
							}
						}
					}
				} catch(Exception e) {

				}
			}

			aszTmpPlist = (Pricelist_Data[])aszPlist.clone();
		}
		for(i=0; i<dj; i++) {
			if(jungoModelFind && junggoShowType!=3) {
				if(aszTmpPlist[i].getAirconfeetype().equals("3")) junggoShowType = 3;
				if(aszTmpPlist[i].getAirconfeetype().equals("4")) junggoShowType = 3;
			}
		}
		for(i=0; i<dj; i++) {
			if(phonePriceAllFlag) {
				aszTmpPlist[i].setCalldataopt("phone_sale"); //판매가 쇼핑몰-수수료 쇼핑몰
				String tempPhonePriceAllHash = ChkNull.chkStr((String)phonePriceAllHash.get(aszTmpPlist[i].getPl_no()), "");
				int tempPhonePrice2 = 10; //판매가몰의 수수료 금액(0원인 업체만 골라내기 위해 기본값을 10으로 세팅)
				if(tempPhonePriceAllHash.length()>0){ //특정 요금제 선택일때 요금제명이 필요함
					String[] tempPhonePriceInfoAry = tempPhonePriceAllHash.split(",");
					if(tempPhonePriceInfoAry!=null && tempPhonePriceInfoAry.length>0) {
						if(tempPhonePriceInfoAry.length>3){
							tempPhonePrice2 = ChkNull.chkInt(tempPhonePriceInfoAry[3],10);
						}
					}
				}
				if(CutStr.cutStr(szCategory,4).equals("0304")){ //일시불구매/할부구매 기준
					if(aszTmpPlist[i].getPrice_flag().equals("0")){
						if(tempPhonePrice2==0 && ControlUtil.compareValOR(new int[]{aszTmpPlist[i].getShop_code(),47,49,55,57,806,2562,6547,6665,6696,6705,7645})){ //수수료 사용업체중 0원이면 일시불 구매몰
							nLCnt = nLCnt +1;
							pl_data = new Pricelist_Data();
							pl_data = makePricelistData(aszTmpPlist[i]);
							left_list.add(pl_data);
						}else{
							nRCnt = nRCnt + 1;
							pl_data = new Pricelist_Data();
							pl_data = makePricelistData(aszTmpPlist[i]);
							right_list.add(pl_data);
						}
					}
				}else{ //판매가/수수료 기준, 요금제 선택
					if(tempPhonePriceAllHash.length()>0){
						nLCnt = nLCnt +1;
						pl_data = new Pricelist_Data();
						pl_data = makePricelistData(aszTmpPlist[i]);
						left_list.add(pl_data);
					}else{
						nRCnt = nRCnt + 1;
						pl_data = new Pricelist_Data();
						pl_data = makePricelistData(aszTmpPlist[i]);
						right_list.add(pl_data);
					}
				}
			// 제조사 인증 공식판매자 여부 확인
			} else if(authShowFlag) {
				aszTmpPlist[i].setCalldataopt("auto_factory"); //인증 공식판매-일반쇼핑몰
				if(authShowFlag && aszTmpPlist[i].getAuthflag().equals("Y")) {
					nLCnt = nLCnt +1;
					pl_data = new Pricelist_Data();
					pl_data = makePricelistData(aszTmpPlist[i]);
					left_list.add(pl_data);
				} else {
					nRCnt = nRCnt + 1;
					pl_data = new Pricelist_Data();
					pl_data = makePricelistData(aszTmpPlist[i]);
					right_list.add(pl_data);
				}
			// 전시,중고,반품 구분 airconfeetype필드를 이용해서 구분, left만 있을 경우는 1, right만 있을 경우는 2, 둘다 있을 경우는 3
			} else if(junggoShowType==3) {
				if(CutStr.cutStr(szCategory,4).equals("0304") || (CutStr.cutStr(szCategory,4).equals("0305") && !strCondi.equals("중고품")) || CutStr.cutStr(szCategory,8).equals("02333201")) {
					aszTmpPlist[i].setCalldataopt("junggo"); //중고-가개통
				}else{
					aszTmpPlist[i].setCalldataopt("junggo_recall"); //전시/중고-반품/리퍼
				}
				if(aszTmpPlist[i].getAirconfeetype().equals("4")) {
					nRCnt = nRCnt + 1;
					pl_data = new Pricelist_Data();
					pl_data = makePricelistData(aszTmpPlist[i]);
					right_list.add(pl_data);
				} else {
					nLCnt = nLCnt +1;
					pl_data = new Pricelist_Data();
					pl_data = makePricelistData(aszTmpPlist[i]);
					left_list.add(pl_data);
				}
			} else if(szCallDataOpt.equals("opt_aircon") && !airconFlag.equals("3")) {
				aszTmpPlist[i].setCalldataopt("opt_aircon");
				if(aszTmpPlist[i].getAirconfeetype().equals("1")){
					aszTmpPlist[i].setRightnleft("1");
				} else {
					aszTmpPlist[i].setRightnleft("2");
				}
				if(aszTmpPlist[i].getRightnleft().equals("1")) {
					nLCnt = nLCnt +1;
					pl_data = new Pricelist_Data();
					pl_data = makePricelistData(aszTmpPlist[i]);
					left_list.add(pl_data);
				} else {
					nRCnt = nRCnt + 1;
					pl_data = new Pricelist_Data();
					pl_data = makePricelistData(aszTmpPlist[i]);
					right_list.add(pl_data);
				}
			} else if(szCallDataOpt.equals("opt_term")) {	// 	좌측
				aszTmpPlist[i].setCalldataopt("delivery"); //무료배송-배송비 유무료 쇼핑몰
				if(CutStr.cutStr(szCategory,4).equals("0501") || CutStr.cutStr(szCategory,4).equals("2401")) {	//에어컨은 일반업체 체크 안함 aszTmpPlist[i].getScale().equals("0")
					if(aszTmpPlist[i].getAirconfeetype().equals("1") && aszTmpPlist[i].getRightnleft().equals("1"))	{	//업체설치비 미확인, 일반업체, 배송정보 없을때 무조건 유료
						aszTmpPlist[i].setRightnleft("1");
					} else {
						aszTmpPlist[i].setRightnleft("2");
					}
					if(aszTmpPlist[i].getRightnleft().equals("1")) {
						nLCnt = nLCnt +1;
						pl_data = new Pricelist_Data();
						pl_data = makePricelistData(aszTmpPlist[i]);
						left_list.add(pl_data);
					} else {
						nRCnt = nRCnt + 1;
						pl_data = new Pricelist_Data();
						pl_data = makePricelistData(aszTmpPlist[i]);
						right_list.add(pl_data);
					}
				} else {
					if(((aszTmpPlist[i].getScale().equals("0") && aszTmpPlist[i].getRightnleft().equals("0"))
								|| aszTmpPlist[i].getDeliveryinfo().equals(""))) { //일반업체인 경우 무조건 유료	//에어컨 외 카테고리에서 일반업체, 배송정보 없을때 무조건 유료
						aszTmpPlist[i].setRightnleft("2");
						if(aszTmpPlist[i].getJobtype().equals("2")) {
							if(aszTmpPlist[i].getDelfeetype().equals("0"))
								aszTmpPlist[i].setRightnleft("1");
							else
								aszTmpPlist[i].setRightnleft("2");
						}
					}
					/**
					if(aszTmpPlist[i].getPl_no()==1038089858){
						System.out.println(">>opt_termSumFlag : "+opt_termSumFlag);
						System.out.println(">>type2 : "+aszTmpPlist[i].getDeliverytype2());
						System.out.println(">>info2 : "+aszTmpPlist[i].getDeliveryinfo2());
					}
					*/
					if(opt_termSumFlag) {
						if(aszTmpPlist[i].getDeliverytype2()==1 && aszTmpPlist[i].getDeliveryinfo2()==0) {
							nLCnt = nLCnt +1;
							pl_data = new Pricelist_Data();
							pl_data = makePricelistData(aszTmpPlist[i]);
							left_list.add(pl_data);
						} else {
							nRCnt = nRCnt + 1;
							pl_data = new Pricelist_Data();
							pl_data = makePricelistData(aszTmpPlist[i]);
							right_list.add(pl_data);
						}
					} else {
						if(aszTmpPlist[i].getRightnleft().equals("1") || (aszTmpPlist[i].getDeliverytype2()==1 && aszTmpPlist[i].getDeliveryinfo2()==0)) {  //if(aszTmpPlist[i].getSrightnleft().equals("0")) 20060523 배송정보변경
							nLCnt = nLCnt +1;
							pl_data = new Pricelist_Data();
							pl_data = makePricelistData(aszTmpPlist[i]);
							left_list.add(pl_data);
						} else {
							nRCnt = nRCnt + 1;
							pl_data = new Pricelist_Data();
							pl_data = makePricelistData(aszTmpPlist[i]);
							right_list.add(pl_data);
						}
					}
				}
			} else if(szCallDataOpt.equals("opt_scale") || airconFlag.equals("3")) {
				aszTmpPlist[i].setCalldataopt("scale"); //대형몰-전문몰
				if(CutStr.cutStr(szCategory,4).equals("0304") || CutStr.cutStr(szCategory,8).equals("02332217")) {
					// 현재 대형몰 구분하는 MP세팅 필드는 오픈마켓에서 사용중이므로 대형몰을 지정해서 샵코드를 이용해
					// 왼쪽 오른쪽을 구분함
					if(ControlUtil.compareValOR(new int[]{aszTmpPlist[i].getShop_code(),47,49,55,57,75,90,374,536,663,806,974,1878,4027,5910,6252,6665,7692})) {
						nLCnt = nLCnt + 1;
						pl_data = new Pricelist_Data();
						pl_data = makePricelistData(aszTmpPlist[i]);
						left_list.add(pl_data);
					} else {
						nRCnt = nRCnt + 1;
						pl_data = new Pricelist_Data();
						pl_data = makePricelistData(aszTmpPlist[i]);
						right_list.add(pl_data);
					}
				} else {
					aszTmpPlist[i].setCalldataopt("scale_open"); //오픈마켓-일반몰
					if(((aszTmpPlist[i].getScale().equals("1") || aszTmpPlist[i].getScale().equals("2")) ||
				   		aszTmpPlist[i].getAuth().equals("5")) && !aszTmpPlist[i].getJobtype().equals("2")) {
						nLCnt = nLCnt + 1;
						pl_data = new Pricelist_Data();
						pl_data = makePricelistData(aszTmpPlist[i]);
						left_list.add(pl_data);
					} else {
						nRCnt = nRCnt + 1;
						pl_data = new Pricelist_Data();
						pl_data = makePricelistData(aszTmpPlist[i]);
						right_list.add(pl_data);
					}
				}
			} else if(szCallDataOpt.equals("opt_shocking2")) { // KT 신규, 보상 일 경우 처리
				aszTmpPlist[i].setCalldataopt("shocking"); //보상(2G→3G)-보상(3G→3G)
				if(!aszTmpPlist[i].getAirconfeetype().equals("1")) {
					nLCnt = nLCnt + 1;
					pl_data = new Pricelist_Data();
					pl_data = makePricelistData(aszTmpPlist[i]);
					left_list.add(pl_data);
				} else {
					nRCnt = nRCnt + 1;
					pl_data = new Pricelist_Data();
					pl_data = makePricelistData(aszTmpPlist[i]);
					right_list.add(pl_data);
				}
			}else if(szCallDataOpt.equals("opt_tariff")) { //해외쇼핑 관세기준
				aszTmpPlist[i].setCalldataopt("tariff"); //세금, 배송비 무료-세금, 배송비 유무료
				if(aszTmpPlist[i].getAirconfeetype().equals("5")) {
					nLCnt = nLCnt + 1;
					pl_data = new Pricelist_Data();
					pl_data = makePricelistData(aszTmpPlist[i]);
					left_list.add(pl_data);
				} else {
					nRCnt = nRCnt + 1;
					pl_data = new Pricelist_Data();
					pl_data = makePricelistData(aszTmpPlist[i]);
					right_list.add(pl_data);
				}
			}else if(szCallDataOpt.equals("opt_nboption")){ //노트북 필수옵션확인요망
				aszTmpPlist[i].setCalldataopt("nboption"); //필수옵션 없음-필수옵션 확인요망
				if(!aszTmpPlist[i].getAirconfeetype().equals("7")) {
					nLCnt = nLCnt + 1;
					pl_data = new Pricelist_Data();
					pl_data = makePricelistData(aszTmpPlist[i]);
					left_list.add(pl_data);
				} else {
					nRCnt = nRCnt + 1;
					pl_data = new Pricelist_Data();
					pl_data = makePricelistData(aszTmpPlist[i]);
					right_list.add(pl_data);
				}
			}else if(szCallDataOpt.equals("opt_freeset")){ //타이어 무료장착
				if(aszTmpPlist[i].getAirconfeetype().equals("2")) {
					nLCnt = nLCnt + 1;
					pl_data = new Pricelist_Data();
					pl_data = makePricelistData(aszTmpPlist[i]);
					left_list.add(pl_data);
				} else {
					nRCnt = nRCnt + 1;
					pl_data = new Pricelist_Data();
					pl_data = makePricelistData(aszTmpPlist[i]);
					right_list.add(pl_data);
				}
			}
		}

		int tmpShopBidCate_price = 0;
		if(!left_list.isEmpty()) {
			aszLeftList = (Pricelist_Data[])left_list.toArray(new Pricelist_Data[0]);
			tmpShopBidCate_price = (int)aszLeftList[0].getInstance_price();

			//판매자 상위입찰 재정렬
			try {
				aszPlist = (Pricelist_Data[])aszLeftList.clone();
				aszLeftList = null;

				int findIdx1 = -1;
				int findIdx2 = -1;
				int gfactoryNum1 = 100;
				int gfactoryNum2 = 100;

				int[] findBidIdxAry = new int[10];
				int findBidIdx = 0;
				for(int deli=0; deli<findBidIdxAry.length; deli++) findBidIdxAry[deli] = -1;

				for(int deli=0; deli<aszPlist.length; deli++) {
					if(aszPlist[0].getInstance_price()<aszPlist[deli].getInstance_price()){ //최저가가 아닐때 상위입찰 무시
						break;
					}
					if(aszPlist[deli].getMobile_bid_flag().equals("1") || aszPlist[deli].getMobile_bid_flag().equals("2") || aszPlist[deli].getMobile_bid_flag().equals("3")) {
						aszPlist[deli].setGoodsfactory("10"); //상위입찰상품 10으로 설정
						findBidIdxAry[findBidIdx] = deli;
						findBidIdx++;
					}
					if(aszPlist[deli].getGoodsfactory().length()==2 && CutStr.cutStr(szCategory,2).equals("03")) {
						int getGoodsFactoryNum = 0;
						try {
							getGoodsFactoryNum = Integer.parseInt(aszPlist[deli].getGoodsfactory());
						} catch(Exception e) {}
						if(getGoodsFactoryNum>10) {
							if(getGoodsFactoryNum>20) {
								if(getGoodsFactoryNum<gfactoryNum2) {
									gfactoryNum2 = getGoodsFactoryNum;
									findIdx2 = deli;
								}
							} else {
								if(getGoodsFactoryNum<gfactoryNum1) {
									gfactoryNum1 = getGoodsFactoryNum;
									findIdx1 = deli;
								}
							}
						}
					}
				}
				Pricelist_Data[] aszPlist03 = new Pricelist_Data[aszPlist.length];
				int aszPlistIdx = 0;

				for(int deli=0; deli<findBidIdxAry.length; deli++) {
					if(findBidIdxAry[deli]>-1) {
						aszPlist03[aszPlistIdx] = aszPlist[findBidIdxAry[deli]].cloneMe();
						aszPlistIdx++;
					}
				}
				if(findIdx1>-1) {
					aszPlist03[aszPlistIdx] = aszPlist[findIdx1].cloneMe();
					aszPlistIdx++;
				}
				if(findIdx2>-1) {
					aszPlist03[aszPlistIdx] = aszPlist[findIdx2].cloneMe();
					aszPlistIdx++;
				}
				for(int deli=0; deli<aszPlist.length; deli++) {
					boolean aryFindIdx = true;
					for(int delix=0; delix<findBidIdxAry.length; delix++) {
						if(deli==findBidIdxAry[delix]) {
							aryFindIdx = false;
							break;
						}
					}
					if(aryFindIdx && findIdx1!=deli && findIdx2!=deli) {
						aszPlist03[aszPlistIdx] = aszPlist[deli].cloneMe();
						aszPlistIdx++;
					}
				}
				aszLeftList = (Pricelist_Data[])aszPlist03.clone();

			} catch(Exception e) {

			}

			//판매자 상위입찰 상태 체크
			for(int ii=0; ii<aszLeftList.length; ii++){
				long priceI = (int)aszLeftList[ii].getInstance_price();
				if(ii>0){
					if(priceI>tmpShopBidCate_price){ //최저가가 아니면 상위입찰 상태 무시
						if(!aszLeftList[ii].getMobile_bid_flag().equals("")){
							aszLeftList[ii].setMobile_bid_flag("");
							aszLeftList[ii].setGoodsfactory("");
						}
					}
				}
			}
		}

		if(!right_list.isEmpty()) {
			aszRightList = (Pricelist_Data[])right_list.toArray(new Pricelist_Data[0]);
			tmpShopBidCate_price = (int)aszRightList[0].getInstance_price();
			//판매자 상위입찰 재정렬
			try {
				aszPlist = (Pricelist_Data[])aszRightList.clone();
				aszRightList = null;

				int findIdx1 = -1;
				int findIdx2 = -1;
				int gfactoryNum1 = 100;
				int gfactoryNum2 = 100;

				int[] findBidIdxAry = new int[10];
				int findBidIdx = 0;
				for(int deli=0; deli<findBidIdxAry.length; deli++) findBidIdxAry[deli] = -1;

				for(int deli=0; deli<aszPlist.length; deli++) {
					if(aszPlist[0].getInstance_price()<aszPlist[deli].getInstance_price()){ //복수구매수량 검색일때, 최저가가 아닐때 상위입찰 무시
						break;
					}
					if(aszPlist[deli].getMobile_bid_flag().equals("1") || aszPlist[deli].getMobile_bid_flag().equals("2") || aszPlist[deli].getMobile_bid_flag().equals("3")) {
						aszPlist[deli].setGoodsfactory("10"); //상위입찰상품 10으로 설정
						findBidIdxAry[findBidIdx] = deli;
						findBidIdx++;
					}
					if(aszPlist[deli].getGoodsfactory().length()==2 && CutStr.cutStr(szCategory,2).equals("03")) {
						int getGoodsFactoryNum = 0;
						try {
							getGoodsFactoryNum = Integer.parseInt(aszPlist[deli].getGoodsfactory());
						} catch(Exception e) {}
						if(getGoodsFactoryNum>10) {
							if(getGoodsFactoryNum>20) {
								if(getGoodsFactoryNum<gfactoryNum2) {
									gfactoryNum2 = getGoodsFactoryNum;
									findIdx2 = deli;
								}
							} else {
								if(getGoodsFactoryNum<gfactoryNum1) {
									gfactoryNum1 = getGoodsFactoryNum;
									findIdx1 = deli;
								}
							}
						}
					}
				}
				Pricelist_Data[] aszPlist03 = new Pricelist_Data[aszPlist.length];
				int aszPlistIdx = 0;

				for(int deli=0; deli<findBidIdxAry.length; deli++) {
					if(findBidIdxAry[deli]>-1) {
						aszPlist03[aszPlistIdx] = aszPlist[findBidIdxAry[deli]].cloneMe();
						aszPlistIdx++;
					}
				}
				if(findIdx1>-1) {
					aszPlist03[aszPlistIdx] = aszPlist[findIdx1].cloneMe();
					aszPlistIdx++;
				}
				if(findIdx2>-1) {
					aszPlist03[aszPlistIdx] = aszPlist[findIdx2].cloneMe();
					aszPlistIdx++;
				}
				for(int deli=0; deli<aszPlist.length; deli++) {
					boolean aryFindIdx = true;
					for(int delix=0; delix<findBidIdxAry.length; delix++) {
						if(deli==findBidIdxAry[delix]) {
							aryFindIdx = false;
							break;
						}
					}
					if(aryFindIdx && findIdx1!=deli && findIdx2!=deli) {
						aszPlist03[aszPlistIdx] = aszPlist[deli].cloneMe();
						aszPlistIdx++;
					}
				}
				aszRightList = (Pricelist_Data[])aszPlist03.clone();

			} catch(Exception e) {

			}
			//판매자 상위입찰 상태 체크
			for(int ii=0; ii<aszRightList.length; ii++){
				long priceI = (int)aszRightList[ii].getInstance_price();
				if(ii>0){
					if(priceI>tmpShopBidCate_price){ //최저가가 아니면 상위입찰 상태 무시
						if(!aszRightList[ii].getMobile_bid_flag().equals("")){
							aszRightList[ii].setMobile_bid_flag("");
							aszRightList[ii].setGoodsfactory("");
						}
					}
				}
			}
		}

		result_list[0] = aszLeftList;
		result_list[1] = aszRightList;
	}catch(Exception ex){

	}
	return result_list;
}

public Pricelist_Data makePricelistData(Pricelist_Data pricelistdata) {
	Pricelist_Data pl_data = new Pricelist_Data();
	pl_data.setPl_no(pricelistdata.getPl_no());
	pl_data.setModelno(pricelistdata.getModelno());
	pl_data.setShop_code(pricelistdata.getShop_code());
	pl_data.setPrice(pricelistdata.getPrice());
	pl_data.setUrl(pricelistdata.getUrl());
	pl_data.setEtc(pricelistdata.getEtc());
	pl_data.setAuthflag(pricelistdata.getAuthflag());
	pl_data.setDel_column(pricelistdata.getDel_column());
	pl_data.setRightnleft(pricelistdata.getRightnleft());
	pl_data.setShop_name(pricelistdata.getShop_name());
	pl_data.setSurl(pricelistdata.getSurl());
	pl_data.setTel(pricelistdata.getTel());
	pl_data.setSrightnleft(pricelistdata.getSrightnleft());
	pl_data.setDelivery(pricelistdata.getDelivery());
	pl_data.setPay(pricelistdata.getPay());
	pl_data.setCategory(pricelistdata.getCategory());
	pl_data.setPriceflag(pricelistdata.getPriceflag());
	pl_data.setScale(pricelistdata.getScale());
	pl_data.setLogo(pricelistdata.getLogo());
	pl_data.setAscii_code(pricelistdata.getAscii_code());
	pl_data.setDel_OrderBonus(pricelistdata.getDel_OrderBonus());
	pl_data.setOrderRnd(pricelistdata.getOrderRnd());
	pl_data.setPublic_auth(pricelistdata.getPublic_auth());
	pl_data.setMultiflag(pricelistdata.getMultiflag());
	// 가끔 업체에서 <등의 태그를 넣어 제목에 입력하는 경우가 발생해서 생기는 문제임
	pl_data.setGoodsnm(pricelistdata.getGoodsnm().replace("<","&lt;"));
	pl_data.setEs_use(pricelistdata.getEs_use());
	pl_data.setEs_enddate(pricelistdata.getEs_enddate());
	pl_data.setEs_basic(pricelistdata.getEs_basic());
	pl_data.setCoupon(pricelistdata.getCoupon());
	pl_data.setCoupon_flag(pricelistdata.getCoupon_flag());
	pl_data.setCoupon_url(pricelistdata.getCoupon_url());
	pl_data.setCoupon_sale1(pricelistdata.getCoupon_sale1());
	pl_data.setCoupon_sale2(pricelistdata.getCoupon_sale2());
	pl_data.setCategorycode1(pricelistdata.getCategorycode1());
	pl_data.setCategorycomment1(pricelistdata.getCategorycomment1());
	pl_data.setCategorycode2(pricelistdata.getCategorycode2());
	pl_data.setCagegorycomment2(pricelistdata.getCagegorycomment2());
	pl_data.setCategorycode3(pricelistdata.getCategorycode3());
	pl_data.setCategorycomment3(pricelistdata.getCategorycomment3());
	pl_data.setDeliverycode(pricelistdata.getDeliverycode());
	pl_data.setDeliveryfee(pricelistdata.getDeliveryfee());
	pl_data.setDelfeetype(pricelistdata.getDelfeetype());
	pl_data.setDelareatype(pricelistdata.getDelareatype());
	pl_data.setDelprice(pricelistdata.getDelprice());
	pl_data.setDelfeedesc(pricelistdata.getDelfeedesc());
	pl_data.setDelareadesc(pricelistdata.getDelareadesc());
	pl_data.setBasisfrom(pricelistdata.getBasisfrom());
	pl_data.setBasisto(pricelistdata.getBasisto());
	pl_data.setJobtype(pricelistdata.getJobtype());
	pl_data.setAirconfeetype(pricelistdata.getAirconfeetype());
	pl_data.setGoods_cnt(pricelistdata.getGoods_cnt());
	pl_data.setAuth(pricelistdata.getAuth());
	pl_data.setAccount_yn(pricelistdata.getAccount_yn());
	pl_data.setApflag(pricelistdata.getApflag());
	pl_data.setOpt_savevalue(pricelistdata.getOpt_savevalue());
	pl_data.setNs_type(pricelistdata.getNs_type());
	pl_data.setTmp_price(pricelistdata.getTmp_price());
	pl_data.setSale_cnt(pricelistdata.getSale_cnt());
	pl_data.setDeliveryinfo(pricelistdata.getDeliveryinfo());
	pl_data.setEver_shopcode(pricelistdata.getEver_shopcode());
	pl_data.setCashback(pricelistdata.getCashback());
	pl_data.setNoint_month(pricelistdata.getNoint_month());
	pl_data.setNoint_sdate(pricelistdata.getNoint_sdate());
	pl_data.setNoint_edate(pricelistdata.getNoint_edate());
	pl_data.setFreeinterest(pricelistdata.getFreeinterest());
	pl_data.setSubside(pricelistdata.getSubside());
	pl_data.setAgree_month(pricelistdata.getAgree_month());
	pl_data.setHomeflag(pricelistdata.getHomeflag()); //TV홈쇼핑을 위한 데이터 셋
	pl_data.setDeliveryinfo2(pricelistdata.getDeliveryinfo2());
	pl_data.setDeliverytype2(pricelistdata.getDeliverytype2());
	pl_data.setPrice_card(pricelistdata.getPrice_card());
	pl_data.setU_date(pricelistdata.getU_date());
	pl_data.setOption_flag2(pricelistdata.getOption_flag2());
	pl_data.setOption_flag(pricelistdata.getOption_flag());
	// goodsfactory
	pl_data.setGoodsfactory(pricelistdata.getGoodsfactory());
	// 최저가를 알기 위한 플래그
	pl_data.setSrvflag(pricelistdata.getSrvflag());
	// 파워셀러 플래그
	pl_data.setPower_flag(pricelistdata.getPower_flag());
	// 파워셀러 아이디
	pl_data.setEnuri_user_id(pricelistdata.getEnuri_user_id());
	// 상위 입찰
	pl_data.setBid_flag(pricelistdata.getBid_flag());
	// 상위 입찰(모바일)
	pl_data.setMobile_bid_flag(pricelistdata.getMobile_bid_flag());
	// goodscode
	pl_data.setGoodscode(pricelistdata.getGoodscode());
	// 제조사 인증
	pl_data.setOpen_seller(pricelistdata.getOpen_seller());
	//재고확인요망
	pl_data.setSoldflag(pricelistdata.getSoldflag());
	pl_data.setInstance_price(pricelistdata.getInstance_price());
	pl_data.setCalldataopt(pricelistdata.getCalldataopt());
	pl_data.setPrice_flag(pricelistdata.getPrice_flag());
	pl_data.setUrl1(pricelistdata.getUrl1());

	if(pricelistdata.getPl_data_array() != null) {
		pl_data.setPl_data_array((Pricelist_Data[])pricelistdata.getPl_data_array().clone());
	}
	return pl_data;
}

/** 최저가 상품일때 좌/우 리턴 */
public String getBidLeftRight(long lngPl_no, Pricelist_Data[][] pl_list) {

	String strReturnLeftRight = "";

	int intLMinPrice = 0;
	int intRMinPrice = 0;

	int intLMinPrice2 = 0;
	int intRMinPrice2 = 0;

	Pricelist_Data[] left = pl_list[0];
	Pricelist_Data[] right = pl_list[1];

	for (int i=0; i<((left==null)?0:left.length); i++){
		if(left[i].getPl_no() == lngPl_no || intLMinPrice == 0 || intRMinPrice == 0 || intLMinPrice2 == 0 || intRMinPrice2 == 0){
			if (intLMinPrice == 0 ){
				intLMinPrice = left[i].getPrice();
			}else if(intLMinPrice2 == 0 ){
				intLMinPrice2 = left[i].getPrice();
			}
			if(left[i].getPl_no() == lngPl_no){
				strReturnLeftRight = "L";
				if (intLMinPrice < left[i].getPrice() ){
					strReturnLeftRight = "";
				}
			}
		}
	}
	for (int i=0; i<((right==null)?0:right.length); i++){
		if(right[i].getPl_no() == lngPl_no || intLMinPrice == 0 || intRMinPrice == 0 || intLMinPrice2 == 0 || intRMinPrice2 == 0){
			if (intRMinPrice == 0 ){
				intRMinPrice = right[i].getPrice();
			}else if(intRMinPrice2 == 0 ){
				intRMinPrice2 = right[i].getPrice();
			}
			if(right[i].getPl_no() == lngPl_no){
				strReturnLeftRight = "R";
				if (intRMinPrice < right[i].getPrice() ){
					strReturnLeftRight = "";
				}
			}
		}
	}
	if (strReturnLeftRight.equals("L")){
		if (intLMinPrice != intLMinPrice2){
			strReturnLeftRight = "";
		}
	}
	if (strReturnLeftRight.equals("R")){
		if (intRMinPrice != intRMinPrice2){
			strReturnLeftRight = "";
		}
	}

	return strReturnLeftRight;
}
/** 좌/우 리턴 **/
public String getLeftRight(long lngPl_no, Pricelist_Data[][] pl_list) {

	String strReturnLeftRight = "";

	Pricelist_Data[] left = pl_list[0];
	Pricelist_Data[] right = pl_list[1];

	for (int i=0; i<((left==null)?0:left.length); i++){
		if(left[i].getPl_no() == lngPl_no){
			strReturnLeftRight = "L";
		}
	}
	if(strReturnLeftRight.equals("")){
		for (int i=0; i<((right==null)?0:right.length); i++){
			if(right[i].getPl_no() == lngPl_no){
				strReturnLeftRight = "R";
			}
		}
	}

	return strReturnLeftRight;
}
%>