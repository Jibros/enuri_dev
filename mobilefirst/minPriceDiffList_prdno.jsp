<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.regex.*"%>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="com.enuri.bean.mobile.RSAMains"%>
<%@ page import="org.apache.commons.lang3.StringUtils"%>
<%@ page import="com.enuri.bean.main.Mobile_Main_Proc"%>
<%@ page import="com.enuri.bean.mobile.Mobile_Push_Proc"%>
<jsp:useBean id="mobile_Main_Proc"
	class="com.enuri.bean.main.Mobile_Main_Proc" scope="page" />
<%//String url = "http://itempage3.auction.co.kr/DetailView.aspx?ITEMNo=B237513692";
			//String url = "http://item2.gmarket.co.kr/Item/DetailView/Item.aspx?goodscode=533633241";
			//String url = "http://www.11st.co.kr/product/SellerProductDetail.tmall?method=getSellerProductDetail&prdNo=1252164502";
			//String url = "http://www.interpark.com/product/MallDisplay.do?_method=detail&sc.prdNo=3433255845";
			//String url = "http://www.lotteimall.com/goods/viewGoodsDetail.lotte?goods_no=1087756031&chl_dtl_no=&chl_no=20";
			//String url = "http://www.wemakeprice.com/deal/adeal/569773/";
			//String url = "http://m.akmall.com/goods/GoodsDetail.do?goods_id=72193567";
			//String url = "http://www.ssg.com/item/itemView01.ssg?itemId=1000006342739";
			//String url = "http://www.cjmall.com/prd/detail_cate.jsp?item_cd=28096627";
			//String url = "http://www.e-himart.co.kr/store/prditm.jsp?prdid=5089&prditmid=67487&fromShop=enuri";
			//String url = "http://with.gsshop.com/prd/prd.gs?prdid=16273496&utm_source=price&utm_medium=affiliate&utm_campaign=enuri";
			//String url = "http://www.hyundaihmall.com/front/pda/itemPtc.do?ReferCode=022&slitmCd=2034535571";
			//String url = "http://www.okmall.com/product/view.html?no=105432"
			//String url = "http://m.ticketmonster.co.kr/deal/detailDaily/198261149"

			//Mobile_Main_Proc mobile_Main_Proc = new com.enuri.bean.main.Mobile_Main_Proc();

			String strT1 = StringUtils.stripToNull(request.getParameter("t1"));
			String strPd = StringUtils.stripToNull(request.getParameter("pd"));

			//System.out.println("1111111111111111111111");

			Mobile_Push_Proc mobile_push_proc = new Mobile_Push_Proc();

			boolean fDebug = false;
			//out.println("strPd_ori>>>"+strPd + "<br>");
			if (strPd != null && !strPd.equals("")) {
				strPd = strPd.replaceAll("[-]", "+");
				strPd = strPd.replaceAll("[_]", "/");
			}

			//System.out.println("222222222222222222222222");

			//out.println("strPd_rep>>>"+strPd + "<br>");

			boolean blCheck = false;

			String url = StringUtils.stripToNull(request.getParameter("url"));
			if (fDebug)
				System.out.println("--------------0--------------url : " + url);
			if (strPd != null && !strPd.equals("")) {

				url = mobile_push_proc.longdecrypt3(strPd);
				if (url != null)
					blCheck = true;
				/*
					//pd??? ?????? ?????????, ??? ????????? ?????? ??????
					String strPd_rsa = mobile_push_proc.longdecrypt3(strPd);   
					
					//fire_date??? ???????????? ????????? ???????????? ?????? ??????
					//id & user_data ?????? ?????? ????????? ??????
					//????????? OK
					System.out.println("----------strPd_rsa>>>"+strPd_rsa + "<br>");
					
					if(strPd_rsa != null){
						String[] arrPd_rsa = strPd_rsa.split("[&]");
						
						if(arrPd_rsa != null && arrPd_rsa.length > 0){
							for(int i = 0; i < arrPd_rsa.length; i++){
							System.out.println("----------arrPd_rsa>>>"+i+" "+arrPd_rsa[i]);
								//out.println("arrPd_rsa["+ i +"]==="+arrPd_rsa[i] + "<br>");
								//if(i == 1){
								//	strPd_fdate = arrPd_rsa[i];
								//}else if(i == 2){
								//	strPd_enuriid  = arrPd_rsa[i];
								//}else if(i == 3){
								//	strPd_userdata  = arrPd_rsa[i];
								//}
								
								if(arrPd_rsa[i].indexOf("url=") > -1){
									url = arrPd_rsa[i].replace("url=","");
								}
							}

							blCheck = true;
						}
					}*/

			} else if (url != null && !url.equals("")) {
				blCheck = true;
			}
			if (fDebug)
				System.out.println("--------------1--------------url : " + url);
			if (blCheck) {
				//System.out.println("3333333333333333333");
				// ??? ????????? ????????? ?????? 
				final String AUCTION = "auction.co.kr";
				final String GMARKET = "gmarket.co.kr";
				final String INTERPARK = "interpark.com";
				final String MOBILE_INTERPARK = "m.interpark.com";
				final String MOBILE_SHOP_INTERPARK = "m.shop.interpark.com";
				final String _11ST = "11st.co.kr";
				final String LOTTEIMALL = "lotteimall.com";
				final String WEMAKEPRICE = "wemakeprice.com";
				final String AKMALL = "akmall.com";
				final String SSG = "ssg.com"; // ????????? ????????? , ?????????, ???????????? 
				final String CJMALL = "cjmall.com";
				final String HIMART = "e-himart.co.kr";
				final String LOTTEMART = "lottemart.com";

				final String LOTTE = "lotte.com";
				final String GSSHOP = "gsshop.com";
				final String HMALL = "hyundaihmall.com";
				final String GALLERIA = "galleria.co.kr";
				final String HNSMALL = "hnsmall.com";
				final String OKMALL = "okmall.com";
				final String NSMALL = "nsmall.com";
				final String HOME_PLUS = "homeplus.co.kr";
				final String TICKET_MONSTER = "ticketmonster.co.kr";

				final String _11ST_CODE = "5910";
				final String INTERPARK_CODE = "55";
				final String GMARKET_CODE = "536";
				final String AUCTION_CODE = "4027";
				final String LOTTE_CODE = "49";
				final String LOTTEIMALL_CODE = "663";
				final String AKMALL_CODE = "90";
				final String SSG_CODE = "47";
				final String CJMALL_CODE = "806";
				final String HIMART_CODE = "6252";
				final String LOTTEMART_CODE = "7455";

				final String TICKET_MONSTER_CODE = "6641";
				final String WEMAKEPRICE_CODE = "6508";

				String modelno = "";
				String shopcode = "";

				if (StringUtils.isEmpty(url)) {
					out.println("request require parameter ");
					return;
				}

				url = URLDecoder.decode(url);

				Pattern pattern = null;
				Matcher match = null;

				// ????????? ?????? ?????? 
				String domain = "";
				int index = url.indexOf("://");
				if (index != -1) {
					//  "://" ?????? ?????? ?????? 
					domain = url.substring(index + 3);
				}

				index = domain.indexOf('/');
				if (index != -1) {

					domain = domain.substring(0, index);
				}
				// ?????? ????????? ????????? ?????? 
				domain = domain.replaceFirst("^www.*?\\.", "");

				// url ??? ?????? ????????? ?????? ????????????  ??????   
				String prdNo = ""; //  ???????????? 
				if (domain.indexOf(AUCTION) > -1) {

					url = url.replace("#", "");

					if (url.toLowerCase().indexOf("itemno=") > -1) {
						pattern = Pattern.compile("(?i)itemNo=([0-9a-zA-Z]*)");
					} else if (url.toLowerCase().indexOf("/item/vip/") > -1) {
						//out.println(url);
						pattern = Pattern.compile("(?i)vip/([0-9a-zA-Z]*)");
					} else if (url.toLowerCase().indexOf("/vip?") > -1) {
						//out.println(url);
						pattern = Pattern.compile("(?i)vip?([0-9a-zA-Z]*)");
					}else {
						pattern = Pattern.compile("(?i)p=([0-9a-zA-Z]*)");
					}

					shopcode = AUCTION_CODE;

				} else if (domain.indexOf(GMARKET) > -1) {
					pattern = Pattern.compile("(?i)goodscode=([0-9a-zA-Z]*)");
					shopcode = GMARKET_CODE;

				} else if (domain.indexOf(_11ST) > -1 || domain.indexOf(INTERPARK) > -1) {
					if (domain.indexOf(MOBILE_INTERPARK) > -1 || domain.indexOf(MOBILE_SHOP_INTERPARK) > -1) {
						pattern = Pattern.compile("(?i)product/([0-9a-zA-Z]*)");
					} else {
						pattern = Pattern.compile("(?i)prdNo=([0-9a-zA-Z]*)");
					}

					if (domain.indexOf(_11ST) > -1) {
						shopcode = _11ST_CODE;
					} else {
						shopcode = INTERPARK_CODE;
					}

				} else if (domain.indexOf(LOTTEIMALL) > -1) {
					pattern = Pattern.compile("(?i)goods_no=([0-9a-zA-Z]*)");
					shopcode = LOTTEIMALL_CODE;
				} else if (domain.indexOf(LOTTE) > -1) {
					pattern = Pattern.compile("(?i)goods_no=([0-9a-zA-Z]*)");
					shopcode = LOTTE_CODE;

				} else if (domain.indexOf(LOTTEMART) > -1) {
					pattern = Pattern.compile("(?i)ProductCD=([0-9a-zA-Z]*)");
					shopcode = LOTTEMART_CODE;

				} else if (domain.indexOf(WEMAKEPRICE) > -1) {
					if (url.toLowerCase().indexOf("adeal/") > -1) {
						pattern = Pattern.compile("(?i)adeal/([0-9a-zA-Z]*)");
					} else { // http://mapi.wemakeprice.com/mobile_app/direct_to_app/818772
						pattern = Pattern.compile("(?i)direct_to_app/([0-9a-zA-Z]*)");
					}
					shopcode = WEMAKEPRICE_CODE;
				} else if (domain.indexOf(AKMALL) > -1) {
					pattern = Pattern.compile("(?i)goods_id=([0-9a-zA-Z]*)");
					shopcode = AKMALL_CODE;

				} else if (domain.indexOf(SSG) > -1) {
					pattern = Pattern.compile("(?i)itemId=([0-9a-zA-Z]*)");
					shopcode = SSG_CODE;

				} else if (domain.indexOf(CJMALL) > -1) {

					pattern = Pattern.compile("(?i)item/([0-9a-zA-Z]*)");

					shopcode = CJMALL_CODE;

				} else if (domain.indexOf(HIMART) > -1 || domain.indexOf(GSSHOP) > -1) {
					pattern = Pattern.compile("(?i)prdid=([0-9a-zA-Z]*)");
				} else if (domain.indexOf(HMALL) > -1) {
					if (url.toLowerCase().indexOf("itemcode=") > -1)
						pattern = Pattern.compile("(?i)ItemCode=([0-9a-zA-Z]*)");
					else
						pattern = Pattern.compile("(?i)slitmCd=([0-9a-zA-Z]*)");

					if (fDebug)
						System.out.println("---------pattern");
				} else if (domain.indexOf(GALLERIA) > -1) {
					pattern = Pattern.compile("(?i)item_id=([0-9a-zA-Z]*)");
				} else if (domain.indexOf(HNSMALL) > -1) {
					pattern = Pattern.compile("(?i)goods_code=([0-9a-zA-Z]*)");
				} else if (domain.indexOf(OKMALL) > -1) {
					pattern = Pattern.compile("(?i)no=([0-9a-zA-Z]*)");
				} else if (domain.indexOf(NSMALL) > -1) {
					pattern = Pattern.compile("(?i)partNumber=([0-9a-zA-Z]*)");
				} else if (domain.indexOf(HOME_PLUS) > -1) {
				
					if (url.toLowerCase().indexOf("i_style=") > -1) {
						pattern = Pattern.compile("(?i)i_style=([0-9a-zA-Z]*)");
					} else if (url.toLowerCase().indexOf("good_id=") > -1) {
						pattern = Pattern.compile("(?i)good_id=([0-9a-zA-Z]*)");
					}
					
				} else if (domain.indexOf(TICKET_MONSTER) > -1) {
				
					if(url.toLowerCase().indexOf("opt_deal_srl=") > -1) {
						pattern = Pattern.compile("(?i)opt_deal_srl=([0-9a-zA-Z]*)");
					}else if (url.toLowerCase().indexOf("detaildaily/") > -1) {
						pattern = Pattern.compile("(?i)detailDaily/([0-9a-zA-Z]*)");
					}else if (url.toLowerCase().indexOf("deal/") > -1){ // ?????? http://ticketmonster.co.kr/deal/198229601/
						pattern = Pattern.compile("(?i)deal/([0-9a-zA-Z]*)");
					}else { // ?????? http://ticketmonster.co.kr/deal/198229601/
						pattern = Pattern.compile("(?i)deals/([0-9a-zA-Z]*)");
					}
					shopcode = TICKET_MONSTER_CODE;
				} else {
					out.println("no support url : " + domain);
					return;
				}

				// ???????????? ????????? ????????? ????????? ?????? 
				if (pattern != null) {
					match = pattern.matcher(url);

					if (fDebug) {
						System.out.println("---------match " + match);
						System.out.println("---------match url " + url);
						System.out.println("---------match pattern " + pattern);
					}

				}

				if (match != null && match.find()) { // ??????????????? ????????? ??????
					prdNo = match.group(0);
					if (fDebug)
						System.out.println("---------match prdNo " + prdNo);
					if (domain.indexOf(WEMAKEPRICE) > -1 || domain.indexOf(MOBILE_INTERPARK) > -1 
					|| domain.indexOf(MOBILE_SHOP_INTERPARK) > -1 || domain.indexOf(TICKET_MONSTER) > -1 
					|| domain.indexOf(CJMALL) > -1) {
					
						prdNo = prdNo.substring(prdNo.indexOf("/") + 1);
						if (fDebug)
							System.out.println("22222prdNo : " + prdNo);
						if(url.toLowerCase().indexOf("opt_deal_srl=") > -1) {
							prdNo = prdNo.replace("opt_deal_srl=","");
						}

						if ("0".equals(prdNo)) {
							return;
						}
					} else {
						if (prdNo.indexOf("vip/") > -1) {
							prdNo = prdNo.substring(prdNo.indexOf("vip/") + "vip/".length());
						} else {
							prdNo = prdNo.substring(prdNo.indexOf("=") + 1);
						}
					}
					if(domain.indexOf(AUCTION) > -1)
						prdNo = prdNo.toUpperCase();
				} else {
					//
				}
				if (fDebug)
					System.out.println("----------------------------url : " + url);
				if (fDebug)
					System.out.println("----------------------------prdNo : " + prdNo);

				if (!StringUtils.isEmpty(prdNo)) {
					if (domain.indexOf(WEMAKEPRICE) > -1) {
						modelno = mobile_Main_Proc.getModel4WemakeNoFromGoodsCode(prdNo);
					} else {
						if(domain.indexOf(AUCTION) > -1)
							modelno = mobile_Main_Proc.getModelNoFromGoodsCode(prdNo.toUpperCase());
						else 
							modelno = mobile_Main_Proc.getModelNoFromGoodsCode(prdNo);
					}

					if (StringUtils.isEmpty(modelno)) {
						if (fDebug)
							System.out.println("----------------------------no has modelno");
						return;
					}
					if (fDebug)
						out.println("modelno : " + modelno);
				}
		if(fDebug)
		System.out.print("----------------------------modelno : ./ajax/detailAjax/mini_price_list.jsp?modelno=" + modelno +"&t1="+strT1);
		response.sendRedirect("./ajax/detailAjax/get_has_enuricode_url.jsp?modelno=" + modelno +"&t1="+strT1+"&prdno="+prdNo);
	}
%>