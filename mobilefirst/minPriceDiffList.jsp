<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.regex.*"%>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="com.enuri.bean.mobile.RSAMains"%>
<%@ page import="org.apache.commons.lang3.StringUtils"%>
<%@ page import="com.enuri.bean.main.Mobile_Main_Proc"%>
<%@ page import="com.enuri.bean.mobile.Mobile_Push_Proc"%>
<%@ page import="com.enuri.bean.mobile.PDManager_Proc"%>
<%@ page import="java.io.UnsupportedEncodingException"%>

<jsp:useBean id="mobile_Main_Proc"
				class="com.enuri.bean.main.Mobile_Main_Proc" scope="page" />
<%
	//String url = "http://itempage3.auction.co.kr/DetailView.aspx?ITEMNo=B237513692";
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
	//String strPd = StringUtils.stripToNull(request.getParameter("pd"));

	//20171113 손진욱 t1 pd 모듈
	PDManager_Proc pdmanager = new PDManager_Proc();
	String strPd = pdmanager.chkPDOrigin(request);
	//System.out.println("1111111111111111111111");
	
//	out.println(strPd);

	Mobile_Push_Proc mobile_push_proc = new Mobile_Push_Proc();

	boolean fDebug = false;

	boolean blCheck = false;

	String url = StringUtils.stripToNull(request.getParameter("url"));
	
	if (fDebug)
		out.println("--------------0--------------url : " + url);
	if (strPd != null && !strPd.equals(""))
		url = strPd;
	if (url != null && !url.equals(""))
		blCheck = true;

	if (fDebug)
		out.println("--------------1--------------url : " + url +" "+blCheck);
	if (blCheck) {
		//System.out.println("3333333333333333333");
		// 각 쇼핑몰 도메인 주소 
		final String AUCTION = "auction.co.kr";
		final String GMARKET = "gmarket.co.kr";
		final String INTERPARK = "interpark.com";
		final String MOBILE_INTERPARK = "m.interpark.com";
		final String MOBILE_SHOP_INTERPARK = "m.shop.interpark.com";
		final String _11ST = "11st.co.kr";
		final String LOTTEIMALL = "lotteimall.com";
		final String WEMAKEPRICE = "wemakeprice.com";
		final String AKMALL = "akmall.com";
		final String SSG = "ssg.com"; // 신세계 이마트 , 백화점, 신세계몰 
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

		try {
			url = decode(url, "UTF-8");
		} catch (Exception e) {
			if(fDebug)
			out.println(e.toString());
			
		}

		Pattern pattern = null;
		Matcher match = null;

		// 도메인 추출 로직 
		String domain = "";
		int index = url.indexOf("://");
		if (index != -1) {
			//  "://" 이후 값만 추출 
			domain = url.substring(index + 3);
		}

		index = domain.indexOf('/');
		if (index != -1) {

			domain = domain.substring(0, index);
		}
		// 실제 도메인 주소만 추출 
		domain = domain.replaceFirst("^www.*?\\.", "");

		// url 에 따라 쇼핑몰 상품 아이디값  추출   
		String prdNo = ""; //  상품번호 
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
			} else {
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
				out.println("---------pattern");
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

			if (url.toLowerCase().indexOf("opt_deal_srl=") > -1) {
				pattern = Pattern.compile("(?i)opt_deal_srl=([0-9a-zA-Z]*)");
			} else if (url.toLowerCase().indexOf("detaildaily/") > -1) {
				pattern = Pattern.compile("(?i)detailDaily/([0-9a-zA-Z]*)");
			} else if (url.toLowerCase().indexOf("deal/") > -1) { // 예시 http://ticketmonster.co.kr/deal/198229601/
				pattern = Pattern.compile("(?i)deal/([0-9a-zA-Z]*)");
			} else { // 예시 http://ticketmonster.co.kr/deal/198229601/
				pattern = Pattern.compile("(?i)deals/([0-9a-zA-Z]*)");
			}
			shopcode = TICKET_MONSTER_CODE;
		} else {
			out.println("no support url : " + domain);
			return;
		}

		// 쇼핑몰을 찾았을 경우에 정규식 실행 
		if (pattern != null) {
			match = pattern.matcher(url);

			if (fDebug) {
				out.println("---------match " + match);
				out.println("---------match url " + url);
				out.println("---------match pattern " + pattern);
			}

		}

		if (match != null && match.find()) { // 상품번호를 찾았을 경우
			prdNo = match.group(0);
			if (fDebug)
				out.println("---------match prdNo " + prdNo);
			if (domain.indexOf(WEMAKEPRICE) > -1 || domain.indexOf(MOBILE_INTERPARK) > -1
					|| domain.indexOf(MOBILE_SHOP_INTERPARK) > -1 || domain.indexOf(TICKET_MONSTER) > -1
					|| domain.indexOf(CJMALL) > -1) {

				prdNo = prdNo.substring(prdNo.indexOf("/") + 1);
				if (fDebug)
					out.println("22222prdNo : " + prdNo);
				if (url.toLowerCase().indexOf("opt_deal_srl=") > -1) {
					prdNo = prdNo.replace("opt_deal_srl=", "");
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
			if (domain.indexOf(AUCTION) > -1)
				prdNo = prdNo.toUpperCase();
		} else {
			//
		}
		if (fDebug) {
			out.println("----------------------------url : " + url);
			out.println("----------------------------prdNo : " + prdNo);
			out.println("----------------------------shopcode : " + shopcode);
		}

		if (!StringUtils.isEmpty(prdNo)) {
			if (domain.indexOf(WEMAKEPRICE) > -1) {
				modelno = mobile_Main_Proc.getModel4WemakeNoFromGoodsCode(prdNo);
			} else {
				if (domain.indexOf(AUCTION) > -1)
					modelno = mobile_Main_Proc.getModelNoFromGoodsCode(shopcode, prdNo.toUpperCase());
				else
					modelno = mobile_Main_Proc.getModelNoFromGoodsCode(shopcode, prdNo);
			}

			if (StringUtils.isEmpty(modelno)) {
				if (fDebug)
					out.println("----------------------------no has modelno");
				return;
			}
			if (fDebug)
				out.println("modelno : " + modelno);
		}
		if (fDebug)
			out
					.print("----------------------------modelno : ./ajax/detailAjax/mini_price_list.jsp?modelno="
							+ modelno + "&t1=" + strT1);
		response.sendRedirect("./ajax/detailAjax/mini_price_list.jsp?modelno=" + modelno + "&t1=" + strT1
				+ "&prdno=" + prdNo);
	}
%>
<%!public String decode(String s, String enc) throws UnsupportedEncodingException {

		boolean needToChange = false;
		int numChars = s.length();
		StringBuffer sb = new StringBuffer(numChars > 500 ? numChars / 2 : numChars);
		int i = 0;

		if (enc.length() == 0) {
			throw new UnsupportedEncodingException("URLDecoder: empty string enc parameter");
		}

		char c;
		byte[] bytes = null;
		while (i < numChars) {
			c = s.charAt(i);
			switch (c) {
			case '+':
				sb.append(' ');
				i++;
				needToChange = true;
				break;
			case '%':
				/*
				 * Starting with this instance of %, process all consecutive
				 * substrings of the form %xy. Each substring %xy will yield a
				 * byte. Convert all consecutive bytes obtained this way to
				 * whatever character(s) they represent in the provided
				 * encoding.
				 */
				try {

					// (numChars-i)/3 is an upper bound for the number
					// of remaining bytes
					if (bytes == null)
						bytes = new byte[(numChars - i) / 3];
					int pos = 0;
					//System.out.println("numChars " + numChars);
					while (((i + 2) < numChars) && (c == '%')) {
						//System.out.println(i + " " + s.length());
						int v = Integer.parseInt(s.substring(i + 1, i + 3), 16);

						//System.out.println(v + " " + s.substring(i + 1, i + 3));
						if (v < 0)
							throw new IllegalArgumentException(
									"URLDecoder: Illegal hex characters in escape (%) pattern1 - negative value");
						bytes[pos++] = (byte) v;
						i += 3;
						if (i < numChars)
							c = s.charAt(i);
					}

					// A trailing, incomplete byte encoding such as
					// "%x" will cause an exception to be thrown

					if ((i < numChars) && (c == '%')) {
						sb.append("%");
						i++;
						//								 throw new IllegalArgumentException("URLDecoder: Incomplete trailing escape (%) pattern2");
					}

					sb.append(new String(bytes, 0, pos, enc));
				} catch (NumberFormatException e) {
					throw new IllegalArgumentException("URLDecoder: Illegal hex characters in escape (%) pattern3 - "
							+ e.getMessage());
				}
				needToChange = true;
				break;
			default:
				sb.append(c);
				i++;
				break;
			}
		}

		return (needToChange ? sb.toString() : s);
	}%>