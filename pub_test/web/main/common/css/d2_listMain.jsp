<div class="priceListTitle<%=((phonePriceAllFlag && !CutStr.cutStr(szCategory,4).equals("0304")) || (!authShowFlag && !(junggoShowType==3 && !optionEssentialDel.equals("N")) && (szCallDataOpt.equals("opt_aircon"))))?" phoneListTitle":""%>">

			<%// Start => @ include file="/view/include/pricelist/Incleftrighttitle2010.jsp"%>
<%

	szTmpStr = "";
	// 2012.09.13. 17.24. imzig
	// '배송비 유무료' 일 때 배송비 자간 -1 로 설정하기 위한 플래그
	flagDeliveryls = false;

	if(!strOpenExpectFlag.equals("1")) {
		szTmpStr = getLeftRightTitle(szCallDataOpt, szCategory, szFactory, cur_date, dDate, IsLeftRight, opt_termSumFlag, optionEssentialFlag, optionEssentialDel, priceListShowType, phonePriceTab);
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
		if(CutStr.cutStr(szCategory,4).equals("0304") || (CutStr.cutStr(szCategory,4).equals("0305") && !strCondi.equals("중고품") && strCondi.indexOf("리퍼,중고")<0) || CutStr.cutStr(szCategory,8).equals("02332217")) {
			if(IsLeftRight.equals("left")) {
				szTmpStr = "중고";
			}else{
				//if(CutStr.cutStr(szCategory,4).equals("0304")){
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
	if(authShowFlag){
		if(priceListShowType.equals("1")){ //배송비탭에서 제조사인증
			if(IsLeftRight.equals("right")) {
				szTmpStr = "<div class='title_txt'>배송비 포함 쇼핑몰<img id=\"title_info\" src=\""+IMG_ENURI_COM+"/images/view/detail/pricelist/toptab/bt_q_120626.gif\" align='absmiddle' /></div>";
				szTmpStr += "<div id=\"title_info_img\"><div id=\"title_info_img_close\">&nbsp</div><img src=\""+IMG_ENURI_COM+"/images/view/detail/pricelist/auth/sp_auth_delivery.png\" /></div>";
			}else{
				szTmpStr = getAuthLogo(szCategory, szFactory);
				// 제조사 로고가 붙음
				if(szTmpStr.length()>0) {
					if(ControlUtil.compareValOR(new int[]{nModelNo,9895923,10159587})){
						szTmpStr = szTmpStr + "직거래 쇼핑몰";
					}else{
						szTmpStr = szTmpStr + "인증 공식판매";// <img src='"+IMG_ENURI_COM+"/images/view/detail/pricelist/toptab/bt_q_120626.gif' align='absmiddle' />";
					}
				} else {
					szTmpStr = "인증 공식판매";// <img src='"+IMG_ENURI_COM+"/images/view/detail/pricelist/toptab/bt_q_120626.gif' align='absmiddle' />";
				}
			}
		}else if(priceListShowType.equals("0") || priceListShowType.equals("3")) { //기본탭
			if(IsLeftRight.equals("right")) {
				szTmpStr = "일반쇼핑몰";
			} else {
				szTmpStr = getAuthLogo(szCategory, szFactory);
				// 제조사 로고가 붙음
				if(szTmpStr.length()>0) {
					if(ControlUtil.compareValOR(new int[]{nModelNo,9895923,10159587})){
						szTmpStr = szTmpStr + "직거래 쇼핑몰";
					}else{
						szTmpStr = szTmpStr + "인증 공식판매";// <img src='"+IMG_ENURI_COM+"/images/view/detail/pricelist/toptab/bt_q_120626.gif' align='absmiddle' />";
					}
				} else {
					szTmpStr = "인증 공식판매";// <img src='"+IMG_ENURI_COM+"/images/view/detail/pricelist/toptab/bt_q_120626.gif' align='absmiddle' />";
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
			if(CutStr.cutStr(szCategory,4).equals("0304")){
				if(IsLeftRight.equals("right")) {
					szTmpStr = "할부 구매 쇼핑몰";
				} else {
					szTmpStr = "일시불 구매 쇼핑몰";
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

	if(!szCmd.equals("all_view"))	{
		if(ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,8),"05130201","05130202","05130203","05130204","05130205","05130206","05130212"})) {
			out.print(szTmpStr);
		} else {
			if(IsLeftRight.equals("left")) {
				if(nLCnt > 0 || nRCnt > 0) out.print(szTmpStr);
			} else {
				out.print(szTmpStr);
			}
		}
	}

%>


			<%// End => @ include file="/view/include/pricelist/Incleftrighttitle2010.jsp"%>

			</div>

			<ul>
			<%// <div id="< %=mainShopListID% >"> %>

			<%// Start => @ include file="/view/include/pricelist/Incdisplayeachmall2010.jsp"%>

<%// Start => @ include file="/view/include/ShopReadyList.jsp"%>
<%
// send to d2.jsp
%>
<%// End => @ include file="/view/include/ShopReadyList.jsp"%>

<%


	if(strFactory_etc.indexOf("혼합") > -1) intFetcCnt = 60;
	if(request.getServletPath().trim().indexOf("Comparemulti.jsp")>=0 || request.getServletPath().trim().indexOf("Comparemulti_Print.jsp")>=0) {
		intFetcCnt = 5;
	}

	// 마케팅 이베이 예외처리
	nowDateTime = com.enuri.util.date.DateStr.nowStr("yyyy.MM.dd. HH:mm");
	try {
		if((nowDateTime.compareTo("2012.01.20. 00:00")>=0 && nowDateTime.compareTo("2012.02.03 00:00")<0) &&
			ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,4),"0908","0923","0901","0920","0903","0904",
					"0905","0911","1007","1005","1020","1010","1205","1202","1201","1208","1605","2302","1626","1621"})
			) {
			int bannerRandom[] = RandomMain.getRandomValueNoDupe(2);
			if(bannerRandom[0]==0) {
				auctionEnuriEventFlag = true;
			}
		}
	} catch(Exception e) {}

	xaryAllViewPlist = null;

	if(IsLeftRight.equals("left")) {
			if(!strShopListAll.equals("YES")) {
				if(nLCnt > intFetcCnt) nLCnt = intFetcCnt;
			}
			if(aszLeftList != null) j = aszLeftList.length;
			else j = 0;
	} else if(IsLeftRight.equals("right")) {
			if(!strShopListAll.equals("YES")) {
				if(nRCnt > intFetcCnt) nRCnt = intFetcCnt;
			}
			if(aszRightList != null) j = aszRightList.length;
			else j = 0;
	} else {
		j = 0;
	}


	// 현재 보여지는 샵 리스트의 인덱스
	shopShowCnt = 0;

	for(i=0; i<j; i++) {
	if(i>19) break;
		Pricelist_Data aszTempList = null;




		// 배송비를 포함해서 정렬할 경우 최저가 구하기
		if(priceListShowType.equals("1") && szCallDataOpt.equals("opt_term")) {
			if(IsLeftRight.equals("left")) {
				aszTempList = aszLeftList[i];

				if(!aszLeftList[i].getSrvflag().equals("M")) {
					if(leftPrice2==0) {
						leftPrice2 = aszLeftList[i].getTmp_price();
						if(aszLeftList[i].getDeliverytype2()==1 || aszLeftList[i].getDeliveryinfo().indexOf("조건부무료")>-1) leftPrice2 += aszLeftList[i].getDeliveryinfo2();

						leftPrice = (int)leftPrice2;
					}
				}
			} else if(IsLeftRight.equals("right")) {
				aszTempList = aszRightList[i];

				if(!aszRightList[i].getSrvflag().equals("M")) {
					if(rightPrice2==0) {
						// 옵션 필수 상품인 경우 right 계산 안함
						if(!aszTmpPlist[i].getOption_flag2().equals("1") || !optionEssentialFlag) {
							rightPrice2 = aszRightList[i].getTmp_price();
							if(aszRightList[i].getDeliverytype2()==1 || aszRightList[i].getDeliveryinfo().indexOf("조건부무료")>-1) rightPrice2 += aszRightList[i].getDeliveryinfo2();

							rightPrice = (int)rightPrice2;
						}
					}
				}
			}
		} else {
			if(IsLeftRight.equals("left")) {
				aszTempList = aszLeftList[i];

				if(aszLeftList[0].getSrvflag().equals("M")) {
					if(aszLeftList.length>1) {
						if(aszLeftList[1].getSrvflag().equals("M")) {
							if(aszLeftList.length>2) {
								leftPrice = aszLeftList[2].getPrice();
								leftPrice2 = aszLeftList[2].getTmp_price();
							}
						} else {
							leftPrice = aszLeftList[1].getPrice();
							leftPrice2 = aszLeftList[1].getTmp_price();
						}
					}
				} else {
					leftPrice = aszLeftList[0].getPrice();
					leftPrice2 = aszLeftList[0].getTmp_price();
				}
				leftPrice = (int)leftPrice2;
			} else if(IsLeftRight.equals("right")) {
				aszTempList = aszRightList[i];

				if(aszRightList[0].getSrvflag().equals("M")) {
					if(aszRightList.length>1) {
						// 옵션 필수 상품인 경우 right 계산 안함
						if(!aszTmpPlist[i].getOption_flag2().equals("1") || !optionEssentialFlag) {
							rightPrice = aszRightList[1].getPrice();
							if(szCallDataOpt.equals("opt_card")) rightPrice2 = aszRightList[1].getPrice_card();
							else rightPrice2 = aszRightList[1].getTmp_price();
						}
					}
				} else {
					// 옵션 필수 상품인 경우 right 계산 안함
					if(!aszTmpPlist[i].getOption_flag2().equals("1") || !optionEssentialFlag) {
						rightPrice = aszRightList[0].getPrice();
						if(szCallDataOpt.equals("opt_card")) {
							rightPrice2 = aszRightList[0].getPrice_card();
						} else {
							// 옵션 필수 일 경우는 right최저가 계산이 0번째가 최저가가 아님(옵션인 경우는 빼야함)
							if(optionEssentialFlag) {
								if(rightPrice2==0 || rightPrice2>aszRightList[i].getTmp_price()) {
									rightPrice2 = aszRightList[i].getTmp_price();
								}
							} else {
								rightPrice2 = aszRightList[0].getTmp_price();
							}
						}
					}
				}
				rightPrice = (int)rightPrice2;
			}
		}

		if(aszTempList!=null) {
			intPlNo = aszTempList.getPl_no();
			szVcode = aszTempList.getShop_code();
			mPrice = aszTempList.getPrice();
			szUrl = aszTempList.getUrl();


			szSbName = aszTempList.getShop_name();
			szSbUrl = aszTempList.getSurl();
			szSbTel = aszTempList.getTel();
			szSbDelivery = aszTempList.getDelivery();
			szSbPay = aszTempList.getPay();

			fSbLogo = aszTempList.getLogo();
			fAuthFlag = aszTempList.getAuthflag();

			szEtc = aszTempList.getEtc();
			szBonus = "";  // aszTempList.getDel_column();

			strPublicAuthFlag = aszTempList.getPublic_auth();
			strMultiFlag = aszTempList.getMultiflag();
			strPlGoodsNm = aszTempList.getGoodsnm();
			strEsFlg = aszTempList.getEs_use();
			strEsBasis = aszTempList.getEs_basic();
			strPlCoupon = aszTempList.getCoupon();
			strCouponFlag = aszTempList.getCoupon_flag();
			strCouponUrl = aszTempList.getCoupon_url();
			strCouponSale1 = aszTempList.getCoupon_sale1();
			strCouponSale2 = aszTempList.getCoupon_sale2();
			szApflag = aszTempList.getApflag();
			szAccount_yn = aszTempList.getAccount_yn();

			// TV홈쇼핑용 아이콘을 출력하기 위한 데이터
			szHomeflag = aszTempList.getHomeflag();

			xstrDelFlag = aszTempList.getDeliveryflag();
			xstrDelFeeType = aszTempList.getDelfeetype();
			xstrDelAreaType = aszTempList.getDelareatype();
			xintPrice = aszTempList.getDelprice();
			xstrDelFeeDesc = aszTempList.getDelfeedesc();
			xstrDelAreaDesc = aszTempList.getDelareadesc();
			xintBasisFrom = aszTempList.getBasisfrom();
			xintBasisTo = aszTempList.getBasisto();
			strPl_jobType = aszTempList.getJobtype();
			xstrAirconFeeType	= aszTempList.getAirconfeetype();
			xintPlGoodsCnt = aszTempList.getGoods_cnt();
			xlongTmp_price = aszTempList.getTmp_price();
			xintSale_cnt = aszTempList.getSale_cnt();
			strDeliveryinfo = aszTempList.getDeliveryinfo();

			szCategoryCode1 = aszTempList.getCategorycode1();
			szCategoryComment1 = aszTempList.getCategorycomment1();
			szCategoryCode2 = aszTempList.getCategorycode2();
			szCategoryComment2 = aszTempList.getCagegorycomment2();
			szCategoryCode3 = aszTempList.getCategorycode3();
			szCategoryComment3 = aszTempList.getCategorycomment3();

			szDeliveryCode1 = aszTempList.getDeliverycode();
			szDeliveryFee1 = aszTempList.getDeliveryfee();
			xintOpt_savevalue = aszTempList.getOpt_savevalue();
			strNs_type = aszTempList.getNs_type();

			mPrice2 = (int)aszTempList.getTmp_price();

			strRightnleft = aszTempList.getRightnleft();

			//에버몰 적립금관련 shwoo 2006.10.02.
			szNoint_month = aszTempList.getNoint_month();
			szNoint_sdate = aszTempList.getNoint_sdate();
			szNoint_edate = aszTempList.getNoint_edate();
			intCashback = aszTempList.getCashback();

			strFreeinterest = aszTempList.getFreeinterest();

			//보조금관련 shwoo  2006.10.12.
			intSubside = aszTempList.getSubside();

			//계약기간 shwoo 2008.04.04.
			intAgree_month	= aszTempList.getAgree_month();

			// 배송비 관련 정보
			intDeliveryinfo2 = aszTempList.getDeliveryinfo2();
			intDeliverytype2 = aszTempList.getDeliverytype2();

			intPrice_card = aszTempList.getPrice_card();

			// GS쇼핑지원금
			strGoodsfactory = aszTempList.getGoodsfactory();
			// 파워셀러 유무 플래그
			szPower_flag = aszTempList.getPower_flag();
			// 파워셀러 아이디
			szEnuri_user_id = aszTempList.getEnuri_user_id();
			// goodscode
			strGoodscode = aszTempList.getGoodscode();
			// 제조사 인증
			strOpen_seller = aszTempList.getOpen_seller();
			//한정상품 플래그
			limitFlag = aszTempList.getSrvflag().equals("M");
			// 차등 배송비
			delivery_lev = aszTempList.getDelivery_lev();
			set_yn = aszTempList.getSet_yn();
			//쇼핑몰 상위입찰
			intShop_bid = aszTempList.getShop_bid();
			shop_bid_catetype = aszTempList.getShop_bid_catetype();
			shop_bid_goodscode = aszTempList.getShop_bid_goodscode();
			//스토어팜 정보
			shop_type = aszTempList.getShop_type();
		}
		if(!authShowFlag || !fAuthFlag.equals("Y")) strOpen_seller = "";

		// SKT 고객특가 적용
		if(aszTempList.getGoodsnm().indexOf("[SKT고객")>-1 && aszTempList.getGoodsnm().indexOf("추가할인]")>-1) {
			gmarketSamsumgCard = false;
			sktMemberFlag = true;
		}

		if(szFactory.equals("위니아만도(딤채)")) szFactory = "위니아만도";

		// 선택된 shop에 대해 보여줘야 할지 조건을 줌
		boolean tmpShowShopFlag = true;

		// 한정상품이 실제 최저가보다 가격이 비싸면 보여주지 않음
		//if(aszTempList.getSrvflag().equals("M") && (dj!=1 && intRealMinPrice<=mPrice2)) tmpShowShopFlag = false;
		if(limitFlag && (dj!=1 && intRealMinPrice<=mPrice2)) tmpShowShopFlag = false;

		if(tmpShowShopFlag) {
			shopShowCnt = shopShowCnt + 1;

			String tempStr = "";
			int iUrlType = 0;
			if(!ControlUtil.compareValOR(
					new int[]{szVcode,1965,1330,5701,5815,5822,5438,5832,1634,1421,1590,5830,5856,905,916,1590,5887,5325,5891,5790,5911,1594})) {
				if((nRCnt+nLCnt)>3 && !szApflag.equals("1") && intMinPrice>99999 && szCategory.length()>=6) {
					if(ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,2),"02","03","04","05","06","07"}) ||
						ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,4),"0364","0362","2116","0363"})) {
						if(mPrice2 == intMinPrice) {
							iUrlType = 12;
						}
					}
				}
			}

			//동일최저가 로그
			if(IsLeftRight.equals("left") && leftPrice==((priceListShowType.equals("1") && intDeliverytype2==1)?(mPrice2+intDeliveryinfo2):mPrice2)) {
				minPriceCnt_left++;
				if(szVcode==shopBid_logShop) shopBid_logShopCnt_left++;
			}
			if(IsLeftRight.equals("right") && rightPrice==((priceListShowType.equals("1") && intDeliverytype2==1)?(mPrice2+intDeliveryinfo2):mPrice2)) {
				minPriceCnt_right++;
				if(szVcode==shopBid_logShop) shopBid_logShopCnt_right++;
			}

			tempStr = "8";
			if(iUrlType==10||iUrlType==11) tempStr = "91";

			// 정검 중인 쇼핑몰 리스트 처리
			String[] shopReadyTerm = null;
			if(shopReadyInfo!=null) {
				for(int ri=0; ri<shopReadyInfo.length; ri++) {
					if(shopReadyInfo[ri][0].equals(""+szVcode)) {
						shopReadyTerm = new String[3];
						shopReadyTerm[0] = shopReadyInfo[ri][1];
						shopReadyTerm[1] = shopReadyInfo[ri][2];
						shopReadyTerm[2] = shopReadyInfo[ri][3];
					}
				}
			}

			boolean bShopCountCheck = true;

			String strData = "";

			// 상품권 분류 배송비 감추기위한 플래그 설정
			if(flagDeliveryinvisible){
				intDeliverytype2 = 2;
			}

			// 신용카드 정보를 보여줘야 할 경우 제목에 신용카드 정보를 입력함
			String tempCardName = "";
			tempCardName = getCardNmEvent(cardNameHash, szVcode+"", strPlGoodsNm, mPrice, szCategory);

			//if(intPlNo==691689164){
			//	System.out.println(" tempCardName : " + tempCardName);
			//}
			if(szVcode==75 && !strGoodsfactory.equals("쇼핑지원금")) {
				tempCardName = tempCardName.replaceAll("쇼핑지원금-", "");
				tempCardName = tempCardName.replaceAll("쇼핑지원금", "");
			}
			if(szCallDataOpt.equals("opt_card") && IsLeftRight.equals("right")) {
				if(!tempCardName.equals("")) {
					// GS 예외처리
					/**
					if(szVcode==75 && strGoodsfactory.equals("쇼핑지원금") && tempCardName.indexOf("-")>-1 && (intPrice_card==mPrice || mPrice<50000)) {
						String[] aryCardName = tempCardName.split(":");
						if(aryCardName!=null && aryCardName.length>1) {
							tempCardName = aryCardName[0];
						}
					}
					**/
					szSbName += "-";
					szSbName += tempCardName;
				}
				if(sktMemberFlag) {
					szSbName += "-";
					szSbName += "SKT회원";
				}
				if(gmarketSamsumgCard) {
					szSbName += "-";
					szSbName += "삼성카드";
				}
				//mPrice = intPrice_card; //카드특가 이벤트문구에 원가격 필요
				mPrice2 = intPrice_card;
				xlongTmp_price = intPrice_card;
			}
			//판매자 광고
			String[] seller_ad = {"",""};
			if(arrSellerAd!=null && arrSellerAd.length>0){
				for(int sad_i=0; sad_i<arrSellerAd.length; sad_i++){
					if(intPlNo==ChkNull.chkLong(arrSellerAd[sad_i][0])){
						seller_ad[0] = ChkNull.chkStr(arrSellerAd[sad_i][0]);
						seller_ad[1] = ChkNull.chkStr(arrSellerAd[sad_i][1]);
						break;
					}
				}
			}
			//옥션 마케팅 중복 할인 쿠폰 이벤트
			if(seller_ad[0].equals("") && seller_ad[1].equals("")){
				if(szVcode==4027 && nowDateTime.compareTo("2015.05.22. 15:30")>=0 && nowDateTime.compareTo("2015.05.31. 23:59")<=0 && mPrice>=100000 && ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,2),"02","03","04","05","06","07"})){
					seller_ad[0] = intPlNo+"";
					seller_ad[1] = "★ 5천원 추가 중복할인쿠폰";
				}
			}
            // 20160108 G9 광고문구
            if(seller_ad[0].equals("") && seller_ad[1].equals("")){
            	if(szVcode==7692 && nowDateTime.compareTo("2016.01.31. 23:59")<=0) {
                    seller_ad[0] = intPlNo+"";
                    seller_ad[1] = "첫구매딜 100원, 최대 20% 캐시백 중";
                    g9ProAdShowPlnos = g9ProAdShowPlnos + intPlNo + "|";
                    g9ProAdCnt++;
                    g9ProAdShowFlag = true;
            	}
            }
			// 20150630 KSH NH농협카드 광고문구 예외처리
			if(seller_ad[0].equals("") && seller_ad[1].equals("")){
				if(ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,4),"0201","0232","0234","0305","0402","0404","0405","0420","0502","0601","0602","2401"})) {
					if(((IsLeftRight.equals("left") && nhCardAdCntL==0) || (IsLeftRight.equals("right") && nhCardAdCntR==0)) &&
						szVcode==5910 && nowDateTime.compareTo("2016.05.31. 23:59")<=0) {
						seller_ad[0] = intPlNo+"";
						if(mPrice<30000) {
							seller_ad[1] = "NH농협카드 채움포인트 100% 사용가능";
						} else if(mPrice<300000) {
							seller_ad[1] = "NH농협카드 2000원 추가할인";
						} else {
							seller_ad[1] = "NH농협카드 7000원 추가할인";
						}
						nhCardAdShowPlnos = nhCardAdShowPlnos + intPlNo + "|";
						if(IsLeftRight.equals("left")) {
							nhCardAdCntL++;
							nhCardAdShowFlag = true;
						}
						if(IsLeftRight.equals("right")) {
							nhCardAdCntR++;
							nhCardAdShowFlag = true;
						}
					}
				}
			}
            // 쇼핑몰 광고 문구 추가
            if(seller_ad[0].equals("") && seller_ad[1].equals("") && arrShopAdCopy!=null && arrShopAdCopy.length>0){
                for(int sad_i=0; sad_i<arrShopAdCopy.length; sad_i++){
                    if(szVcode==ChkNull.chkInt(arrShopAdCopy[sad_i][0]) && strGoodscode.equals(arrShopAdCopy[sad_i][1])){
                        seller_ad[0] = intPlNo+"";
                        seller_ad[1] = ChkNull.chkStr(arrShopAdCopy[sad_i][2]);
	                    // 링크에 로그 추가
	                    shopAdCopyPlnos = shopAdCopyPlnos + intPlNo + "|";
	                    shopAdShowFlag = true;
                        break;
                    }
                }
            }

			// 2012.09.13. 17.24. imzig
			// '배송비 유무료' 일 때 배송비 자간 -1 로 설정하기 위한 플래그 설정
			if(szCallDataOpt.equals("opt_term")) {
				if(IsLeftRight.equals("right")) {
					if(!priceListShowType.equals("1")){
						flagDeliveryls = true;
					}
				}
			}


			// 배송비로 정렬하기 priceListShowType==1 일경우에 배송비 유무료는 보여주지않음

			if(bShopCountCheck) {

				// 옵션 필수가 아닐 경우 플래그 없앰

				long option_minprice = 0;
				if(optionEssentialFlag && optionEssentialSimple[0]!=null) {
					String[] optionShopInfoAry = optionEssentialSimple[0].split(":");

					if(optionShopInfoAry!=null && optionShopInfoAry.length>1) {
						try {
							option_minprice = Long.parseLong(optionShopInfoAry[1]);
						} catch(Exception e) {}
					}
				}

				// 상위입찰의 경우 로고 추가
				if(strGoodsfactory.equals("10") && (szVcode==5910 || szVcode==4027 || szVcode==536 || szVcode==55)) {
					//szSbName = "";
				}

				// 휴대폰 가격표시
				boolean phonePriceFlag = false;
				int phonePriceShowType = 0;
				String phonePriceShowInfo = "";
				phonePriceShowInfo = ChkNull.chkStr((String)phonePriceAllHash.get(intPlNo), "");

				// 쇼핑몰이나 길이에 따라 예외처리함
				if(phonePriceAllFlag) {
					phonePriceFlag = true;
				}

				//이베이 단독특가
				boolean isEbaySpecialPrice_goods = false;
				if(isEbaySpecialPrice_model) isEbaySpecialPrice_goods = Goods_Search.isSpcPriceShop_New(strGoodscode);

				// deliveryShowFlag 추가 false일 경우 배송비 보여주지 않음
				strData = getDisplayEachMallDetailJsp(szVcode, szCallDataOpt, IsLeftRight, i, mPrice, szSbName, fSbLogo, intPlNo, szModelNm,
						strCouponFlag, strPlCoupon, leftPrice, rightPrice, szSbDelivery, szSbTel, szCategory, szEtc, ConstImgSrv, xstrAirconFeeType,
						szApflag, xintOpt_savevalue, szAccount_yn, xlongTmp_price, mPrice2, strPlGoodsNm, nLCnt, nRCnt,	intMinPrice,
						strDeliveryinfo, szNoint_month, szNoint_sdate, szNoint_edate, intCashback, intSubside, strFreeinterest, intAgree_month,
						szHomeflag, iUrlType, shopReadyTerm,
						errMemberFlag, strFactory_etc, deliveryShowFlag, intDeliveryinfo2, intDeliverytype2, flagDeliveryinvisible, flagDeliveryls,
						opt_termSumFlag, priceListShowType, MsetNumber,
						optionEssentialFlag, option_minprice, longShowMinPrice, longShowMinPriceDeliveryInfo, longShowDeliveryInfoText,
						pintMallCnt, nModelNo, strGoodsfactory, intPrice_card, tempCardName, szEnuri_user_id, strGoodscode, szUrl, optionCompFlag,
						strOpen_seller, phonePriceFlag, phonePriceShowType, phonePriceShowInfo, cardNameHash, priceCardFlag, tariffFlag, phonePriceTab,
						limitFlag, isEbaySpecialPrice_goods, authShowFlag
						,delivery_lev, set_yn, intShop_bid, leftShopCnt, rightShopCnt, shop_bid_goodscode, shop_bid_catetype, seller_ad, szPower_flag
						,cardFreeAry, shop_type
						);

				// 현재 가격이 최저가 라면.
				if(strData.indexOf("icon_lowprice_new_081107.gif")>-1) {
					minPriceCnt++;
				}

				// 실재 개수를 카운트함
				if(IsLeftRight.equals("left")) leftShopCnt++;
				if(IsLeftRight.equals("right")) rightShopCnt++;

				// 배송비 정보가 불분명 할경우 레이어를 하나 둘러쌈(배송비 미상 제거를 위해)
				if(intDeliverytype2==0 && strDeliveryinfo.indexOf("조건부무료")==-1) {
					//strData = "<div id=\"deliverytypeZeros\" name=\"deliverytypeZeros\" style=\"margin:0px;padding:0px;overflow:hidden;\">" + strData + "</div>";
				//} else {
				//	deliveryType1Num++;
				}
				out.print(strData);

				if(strData.indexOf("icon_lowprice_new_081107.gif")>-1) {
					if(IsLeftRight.equals("left")) {
						if(priceTopLocGoodscodesLeft.indexOf(intPlNo+":"+strGoodscode+":"+szVcode)<0) {
							if(priceTopLocGoodscodesLeft.length()>0) priceTopLocGoodscodesLeft += ",";
							priceTopLocGoodscodesLeft += intPlNo+":"+strGoodscode+":"+szVcode+":"+aszTempList.getBid_flag();
						}
					}
					if(IsLeftRight.equals("right")) {
						if(priceTopLocGoodscodesRight.indexOf(intPlNo+":"+strGoodscode+":"+szVcode)<0) {
							if(priceTopLocGoodscodesRight.length()>0) priceTopLocGoodscodesRight += ",";
							priceTopLocGoodscodesRight += intPlNo+":"+strGoodscode+":"+szVcode+":"+aszTempList.getBid_flag();
						}
					}
				}

				if(IsLeftRight.equals("left")) {
					if(intTmp_Left > intFetcCnt && !strShopListAll.equals("YES")) {
						bLeftCut = true;
						break;
					}
					intTmp_Left++;
				}
				if(IsLeftRight.equals("right")) {
					if(intTmp_Right > intFetcCnt && !strShopListAll.equals("YES")) {
						bRightCut = true;
						break;
					}
					intTmp_Right++;
				}
			}
		}
%>

<%

	}
	if((IsLeftRight.equals("left") && leftShopCnt<=0) || (IsLeftRight.equals("right") && rightShopCnt<=0) || (j==1 && (
			(IsLeftRight.equals("left") && aszLeftList[0].getSrvflag().equals("M") && intMinPrice<aszLeftList[0].getTmp_price()) ||
			(IsLeftRight.equals("right") && aszRightList[0].getSrvflag().equals("M") && intMinPrice<aszRightList[0].getTmp_price())))) {
		if(!IsLeftRight.equals("NoMall")) {
			// sp_no_shop.gif : 판매중인 일반 쇼핑몰이 없습니다.
			// sp_no_open.gif : 판매중인 오픈마켓이 없습니다.
			// sp_no_shop03_2009.gif : 판매중인 무료배송 쇼핑몰이 없습니다.
			// sp_no_shop04_2009.gif : 판매중인 배송비 유료 쇼핑몰이 없습니다.
			// sp_no_shop05_2009.gif : 판매중인 [배송+설치비] 무료 쇼핑몰이 없습니다.
			// sp_no_shop06_2009.gif : 판매중인 [배송+설치비] 유무료 쇼핑몰이 없습니다.
			// sp_no_tariff_5.gif : 세금, 배송비 무료인 쇼핑몰이 없습니다.
			// sp_no_tariff_0.gif : 세금, 배송비 유무료인 쇼핑몰이 없습니다.
			String nomallImg = "";
			String nomallMsg = "";
			// 중고 반품의 경우 이미지 바뀜
			if(junggoShowType==3) {
				if(CutStr.cutStr(szCategory,4).equals("0304") || (CutStr.cutStr(szCategory,4).equals("0305") && !strCondi.equals("중고품") && strCondi.indexOf("리퍼,중고")<0) || CutStr.cutStr(szCategory,8).equals("02332217")) {
					if(IsLeftRight.equals("left")) {
						nomallImg = "sp_no_shop_old.gif";
						nomallMsg = "판매중인 중고<br>상품이 없습니다.";
					}else{
						nomallImg = "sp_no_shop_gong.gif";
						nomallMsg = "판매중인 공기계<br>상품이 없습니다.";
					}
				}else{
					if(IsLeftRight.equals("left")) {
						nomallImg = "sp_no_101220.gif";
						nomallMsg = "판매중인 전시/중고<br>상품이 없습니다.";
					}else{
						nomallImg = "sp_no_101220_1.gif";
						nomallMsg = "판매중인 반품<br>상품이 없습니다.";
					}
				}
			}else if(priceListShowType.equals("1") || priceListShowType.equals("2")) {
				if(IsLeftRight.equals("left")) {
					nomallImg = "sp_no_shop03_20101215_1.gif";
					nomallMsg = "판매중인 배송비 합산<br>쇼핑몰이 없습니다.";
				}else{
					nomallImg = "sp_no_shop03_20101215_3.gif";
					nomallMsg = "판매중인 배송비 미상<br>쇼핑몰이 없습니다.";
				}
			} else if(szCallDataOpt.equals("opt_term")) {
				if(IsLeftRight.equals("left")) {
					if(phonePriceAllFlag){
						nomallImg = "sp_no_shop_2012.gif";
						nomallMsg = "판매중인 쇼핑몰이<br>없습니다.";
					}else{
						nomallImg = "sp_no_shop03_2009.gif";
						nomallMsg = "판매중인 무료배송 쇼핑몰이<br>없습니다.";
						if(ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,8),"05130201","05130202","05130203","05130204","05130205","05130206","05130212"})) {
							nomallImg = "sp_no_shop05_2009.gif";
							nomallMsg = "판매중인 [배송+설치비]<br>무료 쇼핑몰이 없습니다.";
						}
					}
				} else {
					if(ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,8),"05130201","05130202","05130203","05130204","05130205","05130206","05130212"})) {
						nomallImg = "sp_no_shop06_2009.gif";
						nomallMsg = "판매중인 [배송+설치비]<br>유무료 쇼핑몰이 없습니다.";
					} else {
						nomallImg = "sp_no_shop04_2009.gif";
						nomallMsg = "판매중인 배송비 유료<br>쇼핑몰이 없습니다.";
					}
				}
			} else if(szCallDataOpt.equals("opt_scale")) {
				if(phonePriceAllFlag){
					nomallImg = "sp_no_shop_2012.gif";
					nomallMsg = "판매중인 쇼핑몰이<br>없습니다.";
				}else{
					if(CutStr.cutStr(szCategory,4).equals("0304") || CutStr.cutStr(szCategory,8).equals("02332217")) {
						if(IsLeftRight.equals("left")) {
							nomallImg = "sp_no_shop02_2009.gif";
							nomallMsg = "판매중인 대형몰이<br>없습니다.";
						} else {
							nomallImg = "sp_no_shop01_2009.gif";
							nomallMsg = "판매중인 전문 쇼핑몰이<br>없습니다.";
						}
					}else{
						if(IsLeftRight.equals("left")) {
							nomallImg = "sp_no_open.gif";
							nomallMsg = "판매중인 오픈마켓이<br>없습니다.";
						} else {
							nomallImg = "sp_no_shop.gif";
							nomallMsg = "판매중인 일반 쇼핑몰이<br>없습니다.";
						}
					}
				}
			} else if(szCallDataOpt.equals("opt_home")) {
				if(IsLeftRight.equals("left")) {
					nomallImg = "none_shoppingmall.gif";
					nomallMsg = "판매중인 쇼핑몰이<br>없습니다.";
				} else {
					nomallImg = "none_homeshopping.gif";
					nomallMsg = "판매중인 홈쇼핑이<br>없습니다.";
				}
			} else if(szCallDataOpt.equals("opt_shocking1") || szCallDataOpt.equals("opt_shocking2")) {
				if(IsLeftRight.equals("left")) {
					nomallImg = "none_shoppingmall.gif";
					nomallMsg = "판매중인 쇼핑몰이<br>없습니다.";
				} else {
					nomallImg = "none_shoppingmall.gif";
					nomallMsg = "판매중인 쇼핑몰이<br>없습니다.";
				}
			} else if(szCallDataOpt.equals("opt_card")) {
				if(IsLeftRight.equals("right")) {
					nomallImg = "none_shoppingmall.gif";
					nomallMsg = "판매중인 쇼핑몰이<br>없습니다.";
				} else {
					nomallImg = "none_shoppingmall.gif";
					nomallMsg = "판매중인 쇼핑몰이<br>없습니다.";
				}
			} else if(szCallDataOpt.equals("opt_tariff")) {
				if(IsLeftRight.equals("left")) {
					nomallImg = "sp_no_tariff_5.gif";
					nomallMsg = "세금, 배송비 무료인<br>쇼핑몰이 없습니다.";
				} else {
					nomallImg = "sp_no_tariff_0.gif";
					nomallMsg = "세금, 배송비 유무료인<br>쇼핑몰이 없습니다.";
				}
			} else if(szCallDataOpt.equals("opt_nboption")) {
				if(IsLeftRight.equals("left")) {
					nomallImg = "sp_no_nboption.gif";
					nomallMsg = "필수옵션 없는<br>쇼핑몰이 없습니다.";
				} else {
					nomallImg = "none_shoppingmall.gif";
					nomallMsg = "판매중인 쇼핑몰이<br>쇼핑몰이 없습니다.";
				}
			} else if(szCallDataOpt.equals("opt_aircon") || szCallDataOpt.equals("opt_freeset")) {
				nomallImg = "sp_no_shop_2012.gif";
				nomallMsg = "판매중인 쇼핑몰이<br>없습니다.";
			}

			nomallMsg = "해당 쇼핑몰이 없습니다.";
			if(szCallDataOpt.equals("opt_scale") && phonePriceAllFlag) {
				//nomallMsg = nomallMsg + "(" + phonePriceAllFlag + "," + IsLeftRight + "," + szCallDataOpt + "," +  phonePriceAllFlag + "," + IsLeftRight + "," + leftShopCnt + "," + szCategory + "," + aszTmpPlist.length + "," + nLCnt + "," + intTmp_Left + ")";
			}
			/*
%>
<pre>
<%if(szCallDataOpt.equals("opt_scale") && phonePriceAllFlag) { for(int ti = 0 ; ti<aszTmpPlist.length;ti++) { %>
aszTmpPlist[ti].getShop_code() / <%=aszTmpPlist[ti].getShop_code()%> / <%=aszTmpPlist[ti].getTmp_price()%> / <%=aszTmpPlist[ti].getSrvflag()%> / <%=isInArray(Integer.toString(aszTmpPlist[ti].getShop_code()), new String[] {"47","49","55","57","75","90","241","374","536","663","806","974","1878","3367","4027","5910","6252" })%>
<% } } %>
</pre>
<%
			*/


%>
<li class="noMall<%=(phonePriceAllFlag)?" phoneList":(szCategory.equals("93010000"))?" bookList":(tariffFlag)?" overseas":""%>"><div><%=nomallMsg%></div></li>
<%
		}
	}
%>

<%if(phonePriceAllFlag && IsLeftRight.equals("right")) {%>
<map name="phoneShowPriceMap" id="phoneShowPriceMap"><area shape="rect" href="JavaScript:phoneShowPriceOpen();" coords="198,6,235,21"></map>
<map name="phoneShowPriceMap_skt" id="phoneShowPriceMap_skt">
<area shape="rect" coords="14,41,45,54" href="JavaScript:Main_OpenWindow('http://www.enuri.com/phone_word/phone_word.html#a2','phoneShowPrice','670','200','NO','NO',0,0);" /><!-- 가입비 -->
<area shape="rect" coords="13,56,46,69" href="JavaScript:Main_OpenWindow('http://www.enuri.com/phone_word/phone_word.html#b2','phoneShowPrice','670','300','NO','NO',0,0);" /><!-- 유심비 -->
<area shape="rect" coords="11,79,47,93" href="JavaScript:Main_OpenWindow('http://www.enuri.com/phone_word/phone_word.html#b7','phoneShowPrice','670','400','NO','NO',0,0);" /><!-- 초기납 -->
<area shape="rect" coords="74,56,109,70" href="JavaScript:Main_OpenWindow('http://www.enuri.com/phone_word/phone_word.html#a9','phoneShowPrice','670','400','NO','NO',0,0);" /><!-- 요금제 -->
<area shape="rect" coords="146,41,179,55" href="JavaScript:Main_OpenWindow('http://www.enuri.com/phone_word/phone_word.html#b8','phoneShowPrice','670','500','NO','NO',0,0);" /><!-- 판매가 -->
<area shape="rect" coords="114,91,165,105" href="JavaScript:Main_OpenWindow('http://www.enuri.com/phone_word/phone_word.html#a11','phoneShowPrice','670','500','NO','NO',0,0);" /><!-- 월청구액 -->
</map>
<map name="phoneShowPriceMap_kt" id="phoneShowPriceMap_kt">
<area shape="rect" coords="13,35,45,48" href="JavaScript:Main_OpenWindow('http://www.enuri.com/phone_word/phone_word.html#a2','phoneShowPrice','670','200','NO','NO',0,0);" /><!-- 가입비 -->
<area shape="rect" coords="13,49,46,61" href="JavaScript:Main_OpenWindow('http://www.enuri.com/phone_word/phone_word.html#b2','phoneShowPrice','670','300','NO','NO',0,0);" /><!-- 유심비 -->
<area shape="rect" coords="12,63,45,73" href="JavaScript:Main_OpenWindow('http://www.enuri.com/phone_word/phone_word.html#b6','phoneShowPrice','670','200','NO','NO',0,0);" /><!-- 채권료 -->
<area shape="rect" coords="11,79,47,93" href="JavaScript:Main_OpenWindow('http://www.enuri.com/phone_word/phone_word.html#b7','phoneShowPrice','670','400','NO','NO',0,0);" /><!-- 초기납 -->
<area shape="rect" coords="74,56,109,70" href="JavaScript:Main_OpenWindow('http://www.enuri.com/phone_word/phone_word.html#a9','phoneShowPrice','670','400','NO','NO',0,0);" /><!-- 요금제 -->
<area shape="rect" coords="114,91,165,105" href="JavaScript:Main_OpenWindow('http://www.enuri.com/phone_word/phone_word.html#a11','phoneShowPrice','670','500','NO','NO',0,0);" /><!-- 월청구액 -->
<area shape="rect" coords="146,41,179,55" href="JavaScript:Main_OpenWindow('http://www.enuri.com/phone_word/phone_word.html#b8','phoneShowPrice','670','500','NO','NO',0,0);" /><!-- 판매가 -->
</map>
<SCRIPT language="JavaScript">
<!--
function phoneShowPriceOpen() {
	window.open("/knowbox/List.jsp?kbno=376774");
}
-->
</SCRIPT>
<%}%>
<%if(intMinPrice<=1000 && IsLeftRight.equals("right")) {%>
<map name="hPhoneBannerMap" id="hPhoneBannerMap"><area shape="rect" href="JavaScript:Main_OpenWindow('http://www.enuri.com/phone_word/phone_word.html#a7','phoneShowPrice','670','300','NO','NO',0,0);" coords="183,97,234,109"></map>
<%}%>


			<%// End => @ include file="/view/include/pricelist/Incdisplayeachmall2010.jsp"%>

			</ul>