<%
	String[][] shopReadyInfo = null;
    boolean auctionEnuriEventFlag = false;
    String nowDateTime = com.enuri.util.date.DateStr.nowStr("yyyy.MM.dd. HH:mm");

    // 개봉상품일 경우는 스폰서 안보여줌
    if(goodsBbsOpenType.equals("4") && sopnShowFlag) {
        sopnShowFlag = false;
    }

    //strFactory_etc.indexOf("혼합") > -1 을 정의 하는 변수
    String listEndScriptStr = "";

    int intFetcCnt = 30;
    if(strFactory_etc.indexOf("혼합") > -1) intFetcCnt = 60;
    if(request.getServletPath().trim().indexOf("Comparemulti.jsp")>=0 || request.getServletPath().trim().indexOf("Comparemulti_Print.jsp")>=0) {
        intFetcCnt = 5;
        strQuick = "Y";
    }

    //test
    // SDU/SDUL과 같은 특정 멤버들은 사이트 오류신고에 대한 기능을 강화해 줌
    boolean errMemberFlag = false;
    // 휴대폰의 특정 상황을 확인
    boolean hpFlag = false;

    // SDU/SDUL일 경우 errMemberFlag = true;
    if(singoshow.equals("Y")) {
        errMemberFlag = true;
    }

    // 이미지 명
    // goods_data를 이용해 모델명은 원본을 가져옴
    String imgBannerTagStr = getRightInfoBanner(szCategory, goods_data.getModelnm(), intRealMinPrice, errMemberFlag, sopnShowFlag, intMinPrice, IMG_ENURI_COM);

    // 설날,추석 연휴 고정배너
    /**
    if(imgBannerTagStr.length()==0) {
        try {
            java.util.Calendar calda = java.util.Calendar.getInstance();
            java.text.SimpleDateFormat sdfda = new java.text.SimpleDateFormat("yyyyMMddhh");
            String nowDateDa = sdfda.format(calda.getTime());
            if(nowDateTime.compareTo("2012.09.22. 23:59")<=0){
                imgBannerTagStr = " src=\""+IMG_ENURI_COM+"/images/detail/bannernew/sp_day_20120907.gif\"";
            }else{
                String[] dateAry = new String[]{"20120923","20120924","20120925","20120926","20120927","20120928","20120929","20120930","20121001","20121002","20121003"};

                for(int da=0; da<dateAry.length; da++) {
                    if(CutStr.cutStr(nowDateDa, 8).equals(dateAry[da])) {
                        if(dateAry[da].equals("20120926")) {
                            if(nowDateDa.compareTo("2012092612")==-1) {
                                imgBannerTagStr = " src=\""+IMG_ENURI_COM+"/images/detail/bannernew/sp_day_20120926_1.gif\"";
                            } else {
                                imgBannerTagStr = " src=\""+IMG_ENURI_COM+"/images/detail/bannernew/sp_day_20120926_2.gif\"";
                            }
                        } else {
                            imgBannerTagStr = " src=\""+IMG_ENURI_COM+"/images/detail/bannernew/sp_day_"+dateAry[da]+".gif\"";
                        }
                        break;
                    }
                }
            }
        } catch(Exception e) {
        }
    }
    if(errMemberFlag) {
        //판매자용 배너 삭제 2014.11.11
        //imgBannerTagStr = " src=\""+IMG_ENURI_COM+"/images/detail/quality_info_seller_s_122px.gif\" border=\"0\" style=\"cursor:pointer;\" onClick=\"parent.sdul_Error_popShow();\" ";
    }
	*/
    // 기사링크 추가
    boolean newsBannerFlag = false;
//  if(imgBannerTagStr.length()==0 && (ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,4),"0401","0404"}) ||
//          ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,6),"071301","071302","070209","070202","070203","070213"}))) {
//      imgBannerTagStr = " src=\""+IMG_ENURI_COM+"/images/detail/bannernew/bn_virus_111221.gif\" style=\"margin:3px 0px 0px 0px;\" useMap=\"#newsBannerMap\"";
//      newsBannerFlag = true;
//  }

    // 옵션 배너 추가.
    if(!CutStr.cutStr(szCategory,4).equals("0304") && !CutStr.cutStr(szCategory,4).equals("0305") && imgBannerTagStr.length()==0 && optionCompFlag && optionContCnt>0 && ConfigManager.RequestStr(request, "priceListShowType", "").length()==0 && !szCallDataOpt.equals("opt_card") && szSelectedShop.length()==0) {
        if(nowDateTime.compareTo("2012.08.27. 00:00")<0 && (CutStr.cutStr(szCategory,4).equals("0908") || CutStr.cutStr(szCategory,4).equals("0930") || CutStr.cutStr(szCategory,4).equals("0913"))){
            imgBannerTagStr = " src=\""+IMG_ENURI_COM+"/images/view/detail/pricelist/sp_golf_bn.gif\" useMap=\"#golfEventMap\""; //골프 이벤트 배너(2012.8.6 반영예정)
        }else if(szCallDataOpt.equals("opt_nboption")){
            imgBannerTagStr = " src=\""+IMG_ENURI_COM+"/images/view/detail/pricelist/optioncomp/bn_nboption.gif\" style=\"margin:2px 0px 0px 0px;\" useMap=\"#nbOptionDetailMap\"";
        }else{
            imgBannerTagStr = " src=\""+IMG_ENURI_COM+"/images/view/detail/pricelist/optioncomp/bn_option20110824.gif\" style=\"margin:2px 0px 0px 0px;\" useMap=\"#optionMap\"";
        }
    }
    // 휴대폰에 표시가 및 기본가가 있을 경우 예외처리
    if(phonePriceAllFlag) {
        if(CutStr.cutStr(szCategory,4).equals("0304")){
            imgBannerTagStr = " src=\""+IMG_ENURI_COM+"/images/view/detail/pricelist/phone/sp_phone_bn_150624.gif\" border=0 usemap=\"#phoneShowPriceMap\" style=\"margin:2px 0px 0px 0px;\"";
        }else{
            imgBannerTagStr = " src=\""+IMG_ENURI_COM+"/images/view/detail/pricelist/phone/sp_tablet_bn_150402.gif\" border=0 usemap=\"#tabShowPriceMap\" style=\"margin:2px 0px 0px 0px;\"";
        }
    }
    // 좌측배너 안보이기
    // 배송비로 정렬 했을 경우나 SDUL로긴의 경우 안보임
    if(priceListShowType.equals("1")) {
        imgBannerTagStr = "";
    }
    // 영업그룹 유료광고 배너로 교체
	//nh농협카드 배너
	if(nowDateTime.compareTo("2016.06.01. 00:00")<0 &&
        ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,2),"08","09","10","14","15","16","18"})
	) {
		if(bannerRandom_nh[0]==0){
			imgBannerTagStr = " src=\""+IMG_ENURI_COM+"/images/view/detail/pricelist/sp_nhcard_A.jpg\" style=\"margin:1px 0px 0px 0px;cursor:pointer;\" border=\"0\" onload=\"logInsert(13450)\" onClick=\"goNHCard('A');\" ";
		}else{
			imgBannerTagStr = " src=\""+IMG_ENURI_COM+"/images/view/detail/pricelist/sp_nhcard_B.jpg\" style=\"margin:1px 0px 0px 0px;cursor:pointer;\" border=\"0\" onload=\"logInsert(13451)\" onClick=\"goNHCard('B');\" ";
		}
    }else if(
        ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,4),"0401","0402","0404","0405","0408","0414","0418","0420","0422",
        "0423","0701","0702","0703","0704","0705","0707","0708","0709","0710","0711","0712","0713","0715"})
	) {
		imgBannerTagStr = " src=\""+IMG_ENURI_COM+"/images/view/detail/pricelist/sp_enuripc.jpg\" style=\"margin:1px 0px 0px 0px;cursor:pointer;\" border=\"0\" onload=\"logInsert(12997)\" onClick=\"goEnuriPC();\" ";
	/**
    }else if((nowDateTime.compareTo("2012.01.20. 00:00")>=0 && nowDateTime.compareTo("2012.02.03. 00:00")<0) &&
        ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,4),"0908","0923","0901","0920","0903","0904",
                "0905","0911","1007","1005","1020","1010","1205","1202","1201","1208","1605","1625","1626","1621"})
        ) {
        int bannerRandom[] = RandomMain.getRandomValueNoDupe(2);
        if(bannerRandom[0]==0) {
            imgBannerTagStr = " src=\""+IMG_ENURI_COM+"/images/view/detail/pricelist/sp_ebay_bn3.gif\" style=\"margin:2px 0px 0px 0px;cursor:pointer;\" border=\"0\" onClick=\"goEnuriAuctionEvent();\" ";
            auctionEnuriEventFlag = true;
        }
	**/
    }

    // 쇼핑몰을 보여주는 메인 div의 스타일이 상품 타입에 따라 변함(높이 조절)
    String mainDivStyle = "viewdetail";
    String noShopStyle = "viewdetail_empty";
    String sponEtcStyle = "viewdetail_announce";

    xaryAllViewPlist = null;

    if(IsLeftRight.equals("left")) {
        if(strDetailPrint.equals("YES") && nLCnt > 10) {
            j = 10;
        } else if(strDetailMail.equals("YES") && nLCnt > 30) {
            j = 30;
        } else {
            if(!strShopListAll.equals("YES")) {
                if(nLCnt > intFetcCnt) nLCnt = intFetcCnt;
            }
            if(aszLeftList != null) j = aszLeftList.length;
            else j = 0;
        }
    } else if(IsLeftRight.equals("right")) {
        if(strDetailPrint.equals("YES") && nRCnt > 10) {
            j = 10;
        } else if(strDetailMail.equals("YES") && nRCnt > 30) {
            j = 30;
        } else {
            if(!strShopListAll.equals("YES")) {
                if(nRCnt > intFetcCnt) nRCnt = intFetcCnt;
            }
            if(aszRightList != null) j = aszRightList.length;
            else j = 0;
        }
    } else {
        j = 0;
    }

    // 11번가(5910)가 최저가 이면서 옥선(4027), 인터파크(55), G마켓(536)도 최저가일때 클릭로그 남기기
    boolean MinPriceLogFlag = false;
    boolean minProceFind11 = false;

    // 현재 보여지는 샵 리스트의 인덱스
    int shopShowCnt = 0;

    // NH농협카드 광고문구 예외처리
    int nhCardAdCnt = 0;

    for(i=0; i<j; i++) {
        boolean limitedModelShow = false;
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
            xstrAirconFeeType   = aszTempList.getAirconfeetype();
            xintPlGoodsCnt = aszTempList.getGoods_cnt();
            xlongTmp_price = aszTempList.getTmp_price();
            xintSale_cnt = aszTempList.getSale_cnt();
            strDeliveryinfo = aszTempList.getDeliveryinfo();

//          xaryAllViewPlist = (Pricelist_Data[])aszTempList.getPl_data_array().clone();

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
            intAgree_month  = aszTempList.getAgree_month();

            // 배송비 관련 정보
            intDeliveryinfo2 = aszTempList.getDeliveryinfo2();
            intDeliverytype2 = aszTempList.getDeliverytype2();

            intPrice_card = aszTempList.getPrice_card();

            // 옵션 필수 플래그
            strOption_flag2 = aszTempList.getOption_flag2();
            // 옵션 비교 플래그
            strOption_flag = aszTempList.getOption_flag();
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
            strSoldflag = aszTempList.getSoldflag();
            intInstance_price = aszTempList.getInstance_price();
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
        // G마켓 삼성 카드 할인 제거
//      if(szVcode==6300 && mPrice>=100000) {
//          gmarketSamsumgCard = true;
//          sktMemberFlag = false;
//      }

        if(szFactory.equals("위니아만도(딤채)")) szFactory = "위니아만도";

        // 선택된 shop에 대해 보여줘야 할지 조건을 줌
        boolean tmpShowShopFlag = true;

        // 한정상품이 실제 최저가보다 가격이 비싸면 보여주지 않음
//      out.println("intMinPrice = "+intMinPrice+", mPrice2="+mPrice2+", dj="+dj);
        if(aszTempList.getSrvflag().equals("M") && (dj!=1 && intRealMinPrice<=mPrice2)) tmpShowShopFlag = false;
        // 한정상품일 경우 보여 주기 위한 플래그 세팅
        if(aszTempList.getSrvflag().equals("M")) limitedModelShow = true;

        if(tmpShowShopFlag) {
//          out.println("shopShowCnt = "+shopShowCnt+", mMinPrice = "+mMinPrice+", mPrice2 = "+mPrice2);
//          out.println("intPlNo = "+intPlNo);
            shopShowCnt = shopShowCnt + 1;

            String tempStr = "";
            String xstrBuyUrl = "";
            String singolink = "";
            int iUrlType = 0;

            // 김민희씨 요청
            // 11번가(5910)가 최저가 이면서 옥선(4027), 인터파크(55), G마켓(536)도 최저가일때 클릭로그 남기기
            String logInsertText = "";
            if(MinPriceLogFlag && minProceFind11 && mPrice2==intMinPrice) {
                if(mPrice2==intMinPrice) {
                    if(szVcode==5910) logInsertText = "logInsert(3062);";
                    if(szVcode==4027) logInsertText = "logInsert(3063);";
                    if(szVcode==55) logInsertText = "logInsert(3061);";
                    if(szVcode==536) logInsertText = "logInsert(3060);";
                }
            }
            int idx = 0;
            //if(IsLeftRight.equals("left")) idx = leftShopCnt + 1;
            //if(IsLeftRight.equals("right")) idx = rightShopCnt + 1;

            // 숫자를 지그재그로 만들기
            if(IsLeftRight.equals("left")) {
                if(aszRightList==null || aszRightList.length==0) {
                    priceListIdx = leftShopCnt + 1;
                } else {
                    if(leftShopCnt>aszRightList.length) {
                        priceListIdx = leftShopCnt + aszRightList.length + 1;
                    } else {
                        if(imgBannerTagStr.length()>0 && priceListIdx>6) {
                            priceListIdx = leftShopCnt * 2;
                        } else {
                            priceListIdx = leftShopCnt * 2 + 1;
                        }
                    }
                }
            }
            if(IsLeftRight.equals("right")) {
                if(aszLeftList==null || aszLeftList.length==0) {
                    priceListIdx = rightShopCnt + 1;
                } else {
                    if(leftShopCnt<=(rightShopCnt+1)) {
                        priceListIdx = rightShopCnt + leftShopCnt + 1;
                    } else {
                        if(imgBannerTagStr.length()>0 && rightShopCnt>2) {
                            priceListIdx = rightShopCnt * 2 + 3;
                        } else {
                            priceListIdx = rightShopCnt * 2 + 2;
                        }
                    }
                }
            }
            idx = priceListIdx;

            // 'showprice' 는 상품창에서 변경해줘야함 (2군데서 수정하지 않기 위해 치환하는 형식으로 만듬)
            tempStr = "CmdGotoURL2("+iUrlType+",'move_link','"+szVcode+"','"+szSbName.replaceAll(" ","")+"','"+nModelNo+"','','"+java.net.URLEncoder.encode(szFactory)+"','"+mPrice+"','"+strMultiFlag+"','"+intPlNo+"','','"+szUrl+"','"+tempStr+"','"+strPlCoupon+"', "+idx+", 'showprice',"+intInstance_price+",'"+strGoodscode+"');"+logInsertText;
            if(aszTempList.getSrvflag().equals("M")) {
                tempStr += "logInsert(3526);";
            }
            // 주문버튼 클릭시 무조건 로그 입력
            tempStr += "logInsert(5459);";

            // 비교창이 아닐 경우에 클릭하면 표시함
            // 비교창의 경우는 같은 이름의 레이어가 여러개임
            // 현재 위의 선언과 같이 strQuick=="Y" 일경우 비교창~
            if(!strQuick.equals("Y")) {
                tempStr += "cmdViewdetailClick('VIEW_DETAIL_"+IsLeftRight+"_"+i+"');";

                // 2011-04-27 마케팅 요청(상품창의 최저가 순서대로(4등까지) 로그 남기기
                // 4개의 가격을 저장하고 같은 가격이 여러 개 있는지 표시
//              if(CutStr.cutStr(szCategory, 4).equals("0304")) {
//                  for(int r=0; r<priceRank.length; r++) {
//                      if(mPrice==priceRank[r]) {
//                          tempStr += "LogMoveRank("+intPlNo+","+(r+1)+","+idx+","+priceduple[r]+");";
//                      }
//                  }
//              }
            }
            // left, right 로그 넣기
            // 5393 [상품창] 쇼핑몰 클릭수 - 좌측1번
            // 5394 [상품창] 쇼핑몰 클릭수 - 좌측2번
            // 5395 [상품창] 쇼핑몰 클릭수 - 좌측3번
            // 5396 [상품창] 쇼핑몰 클릭수 - 우측1번
            // 5397 [상품창] 쇼핑몰 클릭수 - 우측2번
            // 5398 [상품창] 쇼핑몰 클릭수 - 우측3번
            // 정품인증 상품일 경우만 로그 남기게 변경
            if(authShowFlag) {
                if(IsLeftRight.equals("left")) {
                    if(leftShopCnt==0) tempStr += "logInsert(5393);";
                    if(leftShopCnt==1) tempStr += "logInsert(5394);";
                    if(leftShopCnt==2) tempStr += "logInsert(5395);";
                    if(leftShopCnt==3) tempStr += "logInsert(7363);";
                }
                if(IsLeftRight.equals("right")) {
                    if(rightShopCnt==0) tempStr += "logInsert(5396);";
                    if(rightShopCnt==1) tempStr += "logInsert(5397);";
                    if(rightShopCnt==2) tempStr += "logInsert(5398);";
                }
            }
            // 휴대폰 로그
            if(phonePriceAllFlag) {
                if(IsLeftRight.equals("left")) {
                    tempStr += "logInsert(7607);";
                }
                if(IsLeftRight.equals("right")) {
                    tempStr += "logInsert(7608);";
                }
            }
            // 상위 입찰일 경우 스크립트 추가 실행
            if(buycnt<=1){
                if(aszTempList.getBid_flag().equals("1") || aszTempList.getBid_flag().equals("2") || aszTempList.getBid_flag().equals("3")) {
                    tempStr += "clickBid_flag("+intPlNo+");";
                }
            }
            //동일최저가 로그
            if(IsLeftRight.equals("left") && leftPrice==((priceListShowType.equals("1") && intDeliverytype2==1)?(mPrice2+intDeliveryinfo2):mPrice2)) {
                if(leftShopCnt==0) tempStr += "logInsertLeftMinprice(10639);";
                if(leftShopCnt==1) tempStr += "logInsertLeftMinprice(10638);";
                if(leftShopCnt==2) tempStr += "logInsertLeftMinprice(10637);";
                minPriceCnt_left++;
                if(szVcode==shopBid_logShop) shopBid_logShopCnt_left++;
                tempStr += "logShopBidMinpriceClick('left',"+szVcode+","+intPlNo+");";
            }
            if(IsLeftRight.equals("right") && rightPrice==((priceListShowType.equals("1") && intDeliverytype2==1)?(mPrice2+intDeliveryinfo2):mPrice2)) {
                if(rightShopCnt==0) tempStr += "logInsertRightMinprice(10636);";
                if(rightShopCnt==1) tempStr += "logInsertRightMinprice(10635);";
                if(rightShopCnt==2) tempStr += "logInsertRightMinprice(10634);";
                minPriceCnt_right++;
                if(szVcode==shopBid_logShop) shopBid_logShopCnt_right++;
                tempStr += "logShopBidMinpriceClick('right',"+szVcode+","+intPlNo+");";
            }
            //카드특가탭 광고 로그 추가
            if(cardTabAdFlag){
            	if(cardTabAd_plnos.indexOf(","+intPlNo+",")>=0){
            		if(IsLeftRight.equals("left")){
            			tempStr += "logInsert(12791);";
	            	}else{
            			tempStr += "logInsert(12792);";
            		}
            	}
            }

            xstrBuyUrl = " onclick=\""+tempStr+"\" style=\"cursor:pointer;\" ";



            // 도메인 제약 주문 링크 제거, 메일 보낼때도 제거
            if(nowServerNameLimitedFlag || strDetailMail.equals("YES")) xstrBuyUrl = "";

            // 메일 보낼때 사용하는 링크
            String sendMailOrderLink = "";
            if(strDetailMail.equals("YES")) {
                sendMailOrderLink = "http://www.enuri.com/move/Redirect.jsp?cmd=move_link&vcode="+szVcode+"&modelno="+nModelNo+"&price="+mPrice+"&multiflag="+strMultiFlag+"&pl_no="+intPlNo+"&factory="+java.net.URLEncoder.encode(szFactory)+"&modelnm="+java.net.URLEncoder.encode(szModelNm)+"&url="+ReplaceStr.replace(szUrl, "&", "^").replaceAll("%26", "|");
            }

            tempStr = "8";
            if(iUrlType==10||iUrlType==11) tempStr = "91";
            singolink = " onClick=\"parent.showEP(this,4,"+intPlNo+","+szVcode+",'"+szSbName+"');\"";

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

            //배송비 안보이게 예외처리
            if(!deliveryShowFlag){
                intDeliverytype2 = 2;
            }

            // 신용카드 정보를 보여줘야 할 경우 제목에 신용카드 정보를 입력함
            String tempCardName = "";
            if(intPrice_card>0){
                tempCardName = getCardNmEvent(cardNameHash, szVcode+"", strPlGoodsNm, mPrice, szCategory);
            }
            if(szVcode==75 && !strGoodsfactory.equals("쇼핑지원금")) {
                tempCardName = tempCardName.replaceAll("쇼핑지원금-", "");
                tempCardName = tempCardName.replaceAll("쇼핑지원금", "");
            }
            if(szCallDataOpt.equals("opt_card") && IsLeftRight.equals("right")) {
                if(!tempCardName.equals("")) {
                    // GS 쇼핑지원금
                    /**
                    if(szVcode==75 && strGoodsfactory.equals("쇼핑지원금") && tempCardName.indexOf("-")>-1 && (intPrice_card==mPrice || mPrice<50000)) {
                        String[] aryCardName = tempCardName.split("-");
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
            	/**
            	if(szVcode==4027 && nowDateTime.compareTo("2015.05.22. 15:30")>=0 && nowDateTime.compareTo("2015.05.31. 23:59")<=0 && mPrice>=100000 && ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,2),"02","03","04","05","06","07"})){
                    seller_ad[0] = intPlNo+"";
                    seller_ad[1] = "★ 5천원 추가 중복할인쿠폰";
                }
                **/
            }
            // 20160108 G9 광고문구
            if(seller_ad[0].equals("") && seller_ad[1].equals("")){
            	/**
            	if(szVcode==7692 && nowDateTime.compareTo("2016.01.31. 23:59")<=0) {
                    seller_ad[0] = intPlNo+"";
                    seller_ad[1] = "첫구매딜 100원, 최대 20% 캐시백 중";
                    g9ProAdCnt++;
                    g9ProAdShowFlag = true;
            	}
            	**/
            }
           	// 20150630 KSH NH농협카드 광고문구 예외처리
            if(seller_ad[0].equals("") && seller_ad[1].equals("")){
	            if(ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,4),"0201","0232","0234","0305","0402","0404","0405","0420","0502","0601","0602","2401"})) {
	                if(nhCardAdCnt==0 && szVcode==5910 && nowDateTime.compareTo("2016.05.31. 23:59")<=0) {
                        seller_ad[0] = intPlNo+"";
                        if(mPrice<30000) {
                            seller_ad[1] = "NH농협카드 채움포인트 100% 사용가능";
                        } else if(mPrice<300000) {
                            seller_ad[1] = "NH농협카드 2000원 추가할인";
                        } else {
                            seller_ad[1] = "NH농협카드 7000원 추가할인";
                        }
                    }
                    nhCardAdCnt++;
                    nhCardAdShowFlag = true;

                    // 링크에 로그 추가
                    xstrBuyUrl = xstrBuyUrl.replaceAll("\" style=",";logInsert(12517);\" style=");
                }
            }
            // 쇼핑몰 광고 문구 추가
            if(seller_ad[0].equals("") && seller_ad[1].equals("") && arrShopAdCopy!=null && arrShopAdCopy.length>0){
                for(int sad_i=0; sad_i<arrShopAdCopy.length; sad_i++){
                    if(szVcode==ChkNull.chkInt(arrShopAdCopy[sad_i][0]) && strGoodscode.equals(arrShopAdCopy[sad_i][1])){
                        seller_ad[0] = intPlNo+"";
                        seller_ad[1] = ChkNull.chkStr(arrShopAdCopy[sad_i][2]);
	                    // 링크에 로그 추가
	                    xstrBuyUrl = xstrBuyUrl.replaceAll("\" style=",";logInsert(12819);\" style=");
	                    shopAdShowFlag = true;
                        break;
                    }
                }
            }

            if(limitedModelShow && limitedPriceModelNum>0) bShopCountCheck = false;

            // 배송비로 정렬하기 priceListShowType==1 일경우에 배송비 유무료는 보여주지않음
//          if(priceListShowType.equals("1") && intDeliverytype2==0 && strDeliveryinfo.indexOf("조건부무료")==-1) bShopCountCheck = false;

            if(bShopCountCheck) {
                if(limitedModelShow) limitedPriceModelNum++;

                String tempStrDetailMail = strDetailMail;
                // 옵션 필수가 아닐 경우 플래그 없앰
                if(!optionEssentialFlag) strOption_flag2 = "";
                long option_minprice = 0;
                if(optionEssentialFlag && optionEssentialSimple[0]!=null) {
                    String[] optionShopInfoAry = optionEssentialSimple[0].split(":");

                    if(optionShopInfoAry!=null && optionShopInfoAry.length>1) {
                        try {
                            option_minprice = Long.parseLong(optionShopInfoAry[1]);
                        } catch(Exception e) {}
                    }
                }
                // 옵션 비교의 개수를 셈
                if(IsLeftRight.equals("left")) {
                    //if(leftShopCnt>9) strOption_flag = "";
                    //if(leftShopCnt>31) optionCompFlag=false;
                }
                if(IsLeftRight.equals("right")) {
                    //if(rightShopCnt>9) strOption_flag = "";
                    //if(rightShopCnt>31) optionCompFlag=false;
                }

                // 현재 보여지는 쇼핑몰중에 네이버 체크아웃 상품이 있는지 확인
                if(!naverCheckOutFlag && IsNaverCheckOut(szVcode)) {
                    naverCheckOutFlag = true;
                }
                if(intShop_bid>0 || (strGoodsfactory.equals("10") && (szVcode==5910 || szVcode==4027 || szVcode==536 || szVcode==55))) {
                    if(!szCallDataOpt.equals("opt_card")){
                        szSbName = "";
                    }
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
                if(phonePriceTab.equals("Y")){
                    phonePriceShowType = 1;
                }

                //이베이 단독특가
                boolean isEbaySpecialPrice_goods = false;
                if(isEbaySpecialPrice_model) isEbaySpecialPrice_goods = Goods_Search.isSpcPriceShop_New(strGoodscode);

                // deliveryShowFlag 추가 false일 경우 배송비 보여주지 않음
                strData = getDisplayEachMallDetailJsp(szVcode, szCallDataOpt, IsLeftRight, i, mPrice, szSbName, fSbLogo, intPlNo, szModelNm,
                        strCouponFlag, strPlCoupon, leftPrice, rightPrice, szSbDelivery, szSbTel, szCategory, szEtc, ConstImgSrv, xstrAirconFeeType,
                        szApflag, xintOpt_savevalue, szAccount_yn, xlongTmp_price, mPrice2, strPlGoodsNm, nLCnt, nRCnt, intMinPrice,
                        strDeliveryinfo, szNoint_month, szNoint_sdate, szNoint_edate, intCashback, intSubside, strFreeinterest, intAgree_month,
                        szHomeflag, mainDivStyle, iUrlType, xstrBuyUrl, singolink, nowServerNameLimitedFlag, strDetailPrint, shopReadyTerm,
                        tempStrDetailMail, sendMailOrderLink, errMemberFlag, strFactory_etc,strQuick, deliveryShowFlag, intDeliveryinfo2, intDeliverytype2,
                        opt_termSumFlag, limitedModelShow, priceListShowType, buycnt, MsetStr, detailmultiFlag, strOption_flag2,
                        optionEssentialFlag, option_minprice, strOption_flag, longShowMinPrice, longShowMinPriceDeliveryInfo, longShowDeliveryInfoText,
                        pintMallCnt, nModelNo, strGoodsfactory, intPrice_card, tempCardName, szEnuri_user_id, strGoodscode, szUrl, optionCompFlag,
                        priceListIdx, strOpen_seller, phonePriceFlag, phonePriceShowType, phonePriceShowInfo, cardNameHash, szSelectedShop, priceCardFlag,
                        strSoldflag, bMobile, tariffFlag, isEbaySpecialPrice_goods, authShowFlag
                        ,delivery_lev, set_yn, intShop_bid, leftShopCnt, rightShopCnt, shop_bid_goodscode, shop_bid_catetype, seller_ad, szPower_flag
                        ,cardFreeAry, shop_type
                        );
/*
                // 현재 화면에 보여지는 쇼핑몰들을 기준으로 쇼핑몰 선택기능을 위해 개수 저장
                // 개수세기 플래그
                boolean shopSelectCntFlag = true;
                if(szSelectedShop.length()>0 && IsLeftRight.equals("left")) shopSelectCntFlag = false;
                if(szCallDataOpt.equals("opt_card") && IsLeftRight.equals("right")) shopSelectCntFlag = false;

                try {
                    if(shopSelectCntFlag && shopSelectCode!=null) {
                        int shopSelectIdx = -1;
                        for(int ss=0; ss<shopSelectCode.length; ss++) {
                            if(shopSelectCode[ss]!=9999 && shopSelectCode[ss]==szVcode) {
                                shopSelectIdx = ss;
                                break;
                            }
                        }
                        if(shopSelectIdx==-1) {
                            if(shopSelectCodeEtc.indexOf("-"+szVcode+"-")<0) {
                                shopSelectCodeEtc += szVcode+"-";
                            }
                            shopSelectIdx = shopSelectCode.length - 1;
                        }
                        shopSelectNum[shopSelectIdx]++;
                    }
                } catch(Exception e) {}
*/
                // 현재 가격이 최저가 라면.
                if(strData.indexOf("icon_lowprice_new_081107.gif")>-1) {
                    minPriceCnt++;
                }

                if(deptFlag.equals("Y") && deptPricelistCnt>0) {
                    // 백화점 정보를 세팅할 수 있는 plno를 추가
                    strData = ReplaceStr.replace(strData, "class=\"viewdetail_line3\"", "class=\"viewdetail_line3\" id=\"deptDetail"+IsLeftRight+intPlNo+"\"");
                }

                // 실재 개수를 카운트함
                if(IsLeftRight.equals("left")) leftShopCnt++;
                if(IsLeftRight.equals("right")) rightShopCnt++;

                // 배송비 정보가 불분명 할경우 레이어를 하나 둘러쌈(배송비 미상 제거를 위해)
                if(intDeliverytype2==0 && strDeliveryinfo.indexOf("조건부무료")==-1) {
                    strData = "<div id=\"deliverytypeZeros\" name=\"deliverytypeZeros\" style=\"margin:0px;padding:0px;overflow:hidden;\">" + strData + "</div>";
                } else {
                    deliveryType1Num++;
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
//                  out.println("intTmp_Left = "+intTmp_Left+", intFetcCnt = "+intFetcCnt+"<BR>");
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
<%@include file="/view/include/pricelist/IncOptionGroupBanner.jsp"%>
<%
        // 추가 배너 보여주기
        if(imgBannerTagStr.length()>0){
            if(IsLeftRight.equals("right") && (j<2 || (j==2 && i==1) || (j>2 && i==2))) {
%>
<div class="<%=sponEtcStyle%>">
<img id="bannerImg" name="bannerImg" <%=imgBannerTagStr%> border="0" align="absmiddle">
</div>
<div class="detailcomparelist_dotblue"></div>
<%
            }
        }
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
                if(CutStr.cutStr(szCategory,4).equals("0304") || (CutStr.cutStr(szCategory,4).equals("0305") && !strCondi.equals("중고품") && strCondi.indexOf("리퍼,중고")<0)) {
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
                    if(CutStr.cutStr(szCategory,4).equals("0304")) {
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
                    nomallMsg = "판매중인 쇼핑몰이<br>없습니다.";
                }
            } else if(szCallDataOpt.equals("opt_aircon") || szCallDataOpt.equals("opt_freeset")) {
                nomallImg = "sp_no_shop_2012.gif";
                nomallMsg = "판매중인 쇼핑몰이<br>없습니다.";
            }
%>
<div class="<%=noShopStyle%>">
<img id="nullShopImg<%=IsLeftRight%>" name="nullShopImg<%=IsLeftRight%>" src=<%=ConstImgSrv%>/detail/<%=nomallImg%> border='0' <%if((priceListShowType.equals("1") || priceListShowType.equals("2")) && IsLeftRight.equals("left")) {%>style="margin:27px 0px 0px 0px;"<%}%>>
</div>
<div class="detailcomparelist_dotblue"></div>
<%@include file="/view/include/pricelist/IncOptionGroupBanner.jsp"%>
<%
            // 추가 배너 보여주기
            if(imgBannerTagStr.length()>0){
                if(IsLeftRight.equals("right") && (j < 2 || (j > 1 && i == 1))) {
%>
<div class="<%=sponEtcStyle%>">
<img id="bannerImg" name="bannerImg" <%=imgBannerTagStr%> border="0" align="absmiddle">
</div>
<div class="detailcomparelist_dotblue"></div>
<%
                }
            }
        }
    }
%>
<%
// 옵션필수 레이어가 있을경우 맨 밑에 오른쪽 한칸을 비움
if(IsLeftRight.equals("right") && optionEssentialFlag && optionEssentialDel.equals("Y")) {
%>
<div id="optionEssentialDummyDiv" class="<%=sponEtcStyle%>"></div>
<div class="detailcomparelist_dotblue"></div>
<%
}
%>
<%if(optionCompFlag && optionContCnt>0) {%>
<map name="optionMap" id="optionMap">
<area shape="rect" coords="135,79,171,96" href="JavaScript:parent.optionBannerLayerDivOpen();logInsert(5998);" />
</map>
<%}%>
<map name="nbOptionDetailMap" id="nbOptionDetailMap">
<area shape="rect" coords="137,79,173,97" href="JavaScript:parent.nbOptionDetailInfoShow();" />
</map>
<script language="JavaScript">
function golfEventShow() {
    logInsert(8143);
    var win = window.open('/event/EventGolf.jsp');
    win.focus();
}
function goEnuriPC(){
	logInsert(13333);
	var win = window.open('http://www.enuripc.com');
	win.focus();
}
function goNHCard(p){
	if(p=="A"){
		var win = window.open('http://www.cheumsketch.co.kr/funnyPrice.cheum?refer=ad_enuri_com/');
	}else{
		var win = window.open('https://card.nonghyup.com/content/html/ip/cn/ipgateway.html?SERVICE_ID=/ip/cc/ipcc1802c&amp;NAVIGATE_TYPE=2&amp;FromSite=03');
	}
	win.focus();
}
</script>
<%if(newsBannerFlag && IsLeftRight.equals("left")) {%>
<map name="newsBannerMap" id="newsBannerMap">
<area shape="rect" coords="183,84,234,97" href="JavaScript:newsBannerShow();" />
</map>
<script language="JavaScript">
function newsBannerShow() {
    window.open('http://news.inews24.com/php/news_view.php?g_menu=020800&g_serial=625945');
}
</script>
<%}%>
<%if(auctionEnuriEventFlag) {%>
<script language="JavaScript">
function goEnuriAuctionEvent() {
    window.open("http://promotion.auction.co.kr/promotion/MD/eventview.aspx?txtMD=048B6335FB");
    logInsert(7187);
}
</script>
<%}%>
<%if(errMemberFlag && IsLeftRight.equals("right")) {%>
<map name="detailalert_<%=nModelNo%>" id="detailalert"><area shape="rect" href="JavaScript:parent.sdul_Error_popShow();" coords="194,97,232,109"></map>
<%}%>
<%if(IsLeftRight.equals("right")) {%>
<map name="phoneShowPriceMap_used" id="phoneShowPriceMap_used">
<area shape="rect" coords="181,97,232,110" href="JavaScript:Main_OpenWindow('http://www.enuri.com/phone_word/phone_word.html#b4','phoneShowPrice','670','500','NO','NO',0,0);" /><!-- 가입비 -->
</map>
<%}%>
<%
if(phonePriceAllFlag && IsLeftRight.equals("right")) {
    if(CutStr.cutStr(szCategory,4).equals("0304")){
%>
<map name="phoneShowPriceMap" id="phoneShowPriceMap">
<area shape="rect" coords="14,46,52,64" href="JavaScript:Main_OpenWindow('/phone_word/new_phone_word.html#b2','phoneShowPrice','670','300','NO','NO',0,0);" /><!-- 유심비 -->
<area shape="rect" coords="80,55,128,72" href="JavaScript:Main_OpenWindow('/phone_word/new_phone_word.html#a7','phoneShowPrice','670','400','NO','NO',0,0);" /><!-- 요금제 -->
<area shape="rect" coords="153,40,222,56" href="JavaScript:Main_OpenWindow('/phone_word/new_phone_word.html#b9','phoneShowPrice','670','400','NO','NO',0,0);" /><!-- 할부구매가 -->
<area shape="rect" coords="12,78,52,94" href="JavaScript:Main_OpenWindow('/phone_word/new_phone_word.html#b7','phoneShowPrice','670','500','NO','NO',0,0);" /><!-- 초기납 -->
<area shape="rect" coords="114,91,164,106" href="JavaScript:Main_OpenWindow('/phone_word/new_phone_word.html#a9','phoneShowPrice','670','500','NO','NO',0,0);" /><!-- 월청구액 -->
</map>
<%  }else{ %>
<map name="tabShowPriceMap" id="tabShowPriceMap">
<area shape="rect" coords="16,47,49,63" href="JavaScript:Main_OpenWindow('/phone_word/phone_word.html#b2','phoneShowPrice','670','300','NO','NO',0,0);" /><!-- 유심비 -->
<area shape="rect" coords="15,79,50,93" href="JavaScript:Main_OpenWindow('/phone_word/phone_word.html#b7','phoneShowPrice','670','400','NO','NO',0,0);" /><!-- 초기납 -->
<area shape="rect" coords="84,56,124,69" href="JavaScript:Main_OpenWindow('/phone_word/phone_word.html#a9','phoneShowPrice','670','400','NO','NO',0,0);" /><!-- 요금제 -->
<area shape="rect" coords="165,41,198,53" href="JavaScript:Main_OpenWindow('/phone_word/phone_word.html#b8','phoneShowPrice','670','500','NO','NO',0,0);" /><!-- 판매가 -->
<area shape="rect" coords="114,91,166,104" href="JavaScript:Main_OpenWindow('/phone_word/phone_word.html#a11','phoneShowPrice','670','500','NO','NO',0,0);" /><!-- 월청구액 -->
</map>
<%
    }
%>
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
<map name="deliveryBannerMap" id="deliveryBannerMap"><area shape="rect" href="JavaScript:showSeoulDeliveryInfo();" coords="94,39,189,54"></map>