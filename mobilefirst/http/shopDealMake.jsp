<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.mobile.Mobile_GoodsToPricelist_Proc"%>
<%@ page import="com.enuri.bean.mobile.Mobile_GoodsToPricelist_Data"%>
<%@ page import="java.net.HttpURLConnection"%>
<%@ page import="java.net.URL"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page import="java.io.OutputStreamWriter"%>
<%@ page import="java.io.OutputStream"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="org.json.*"%>
<%@ page import="org.jsoup.*"%>
<%@ page import="org.jsoup.nodes.*"%>
<%@ page import="org.jsoup.select.*"%>
<%@ page import="java.util.HashMap"%>
<%@ include file="/mobilefirst/include/urlConversion.jsp"%>
<%!
// url
// type=1 : get
// type=2 : post
// post일 경우는 param이 필요하지만 get일경우는 그냥 url에 포함시키면됨
public String getHttpSource(String url, String param, String encodingStr, int type) {
	String rtnValue = "";
	StringBuffer html = new StringBuffer();

	try {
		// get로 데이터를 읽어옴
		if(type==1) {
			URL urlObj = new URL(url);
			HttpURLConnection conn = (HttpURLConnection) urlObj.openConnection();
			conn.setRequestMethod("GET");
			conn.setConnectTimeout(20000);
			conn.setReadTimeout(5000);
			conn.setRequestProperty("Accept-Charset", encodingStr);
//			conn.addRequestProperty("Accept-Language", "en-US,en;q=0.8");
//			conn.addRequestProperty("User-Agent", "Mozilla");
//			conn.addRequestProperty("Referer", "google.com");
			conn.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.6) Gecko/20100625 Firefox/3.6.6");
			conn.setDoInput(true);
			conn.setDoOutput(true);
			/*
			String line;
			StringBuilder builder = new StringBuilder();
			BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			while((line = reader.readLine()) != null) {
				builder.append(line);
			}
			*/

			BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream(), encodingStr));
			
			String inputLine;
			while ((inputLine = in.readLine()) != null) {
				html.append(inputLine);
			}

//			System.out.println("html="+html.length());
			rtnValue = html.toString();

			in.close();

			conn.disconnect();
		}

		// post로 데이터를 읽어옴
		if(type==2) {
			String body = param;

			URL urlObj = new URL(url);

			HttpURLConnection conn = (HttpURLConnection) urlObj.openConnection();
			conn.setRequestMethod("POST");
			conn.setDoInput(true);
			conn.setDoOutput(true);
			conn.setUseCaches(false);
			conn.setConnectTimeout(5000);
			conn.setAllowUserInteraction(true);
			conn.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.6) Gecko/20100625 Firefox/3.6.6");

			conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

			PrintWriter pw = new PrintWriter(new OutputStreamWriter(conn.getOutputStream(), encodingStr));
			pw.write(body.toString());
			pw.flush();
			
			BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream(), encodingStr), conn.getContentLength());
			String inputLine;
			while ((inputLine = in.readLine()) != null) {
				html.append(inputLine);
			}
			pw.close();
			in.close();

			rtnValue = html.toString();
		}

	} catch (Exception e) {
		rtnValue = "";

		e.printStackTrace();
	}

	return rtnValue;
}
%>
<%
// dealType=1 : 옥션
// dealType=2 : 지마켓
// dealType=3 : 11번가
String dealType = ConfigManager.RequestStr(request, "dealType", "0");

// url 읽어오기 위한 기본 정보를 저장하는 변수
String url = "";
String encodingStr = "";
int shop_code = 0;

//dealType=1 : 옥션
//- get
//- http://mobile.auction.co.kr/Home/mBestSeller.aspx?pagesize=100
if(dealType.equals("1")) {
	url = "http://mobile.auction.co.kr/ajax/Arche.MobileWeb.Home.AllKillRecommendSlide,Arche.MobileWeb.Web.ashx?_method=GetAllKillRecommendInfo&_session=no";
	encodingStr = "euc-kr";
	shop_code = 4027;
}

//dealType=2 : 지마켓
//- post
//- mobile.gmarket.co.kr/Best/GetBestItems
//- code=G00
if(dealType.equals("2")) {
	url = "http://mobile.gmarket.co.kr";
	encodingStr = "utf-8";
	shop_code = 536;
}
//dealType=3 : 11번가
//- get
//- http://m.11st.co.kr/MW/api/app/elevenst/rank/mobileBestRankingJson.tmall?refererType=sub&rkType=M
if(dealType.equals("3")) {
	url = "http://m.11st.co.kr/MW/html/main.html";
	encodingStr = "euc-kr";
	shop_code = 5910;
}
//영상가전
if(dealType.equals("4")) {
	//url = "http://corners.gmarket.co.kr/Bestsellers?viewType=G&groupCode=G06&subGroupCode=S059";
	url = "http://mobile.gmarket.co.kr/Best/Category?code=G06&subCode=S059";
	encodingStr = "utf-8";
	shop_code = 536;
}
//카메라
if(dealType.equals("5")) {
	url = "http://mobile.gmarket.co.kr/Best/Category?code=G06&subCode=S057";
	encodingStr = "utf-8";
	shop_code = 536;
}
//노트북/pc
if(dealType.equals("6")) {
	url = "http://mobile.gmarket.co.kr/Best/Category?code=G06&subCode=S141";
	encodingStr = "utf-8";
	shop_code = 536;
}
//컴퓨터/용품
if(dealType.equals("7")) {
	url = "http://mobile.gmarket.co.kr/Best/Category?code=G06&subCode=S056";
	encodingStr = "utf-8";
	shop_code = 536;
}
//11번가 타블릿
if(dealType.equals("8")) {
	url = "http://www.11st.co.kr/browsing/BestSeller.tmall?method=getBestSellerMain&cornerNo=10&dispCtgrNo=1001428";
	encodingStr = "euc-kr";
	shop_code = 5910;
}

//상품코드를 저장하는 변수
String goodsCodeList = "";
// goodscode : imageUrlHash -> 선택된 쇼핑몰에서는 goodscode가 유일함
HashMap<String, String> imageUrlHash = new HashMap<String, String>();
if(url.length()>0) {
	
	Document doc = Jsoup.connect(url).get();

	//dealType=1 : 옥션
	// 옥션은 쇼핑몰의 이상한 JSP를 알아서 파싱해서 가져와야함
	if(dealType.equals("1")) {
		String listScript = getHttpSource(url, "", encodingStr, 1);
		//out.println("listScriptLength="+listScript.length());
		listScript = listScript.replace("\\\\", "");
		if(listScript.indexOf("'{\"AllKillBanner")>-1) {
			listScript = listScript.substring(listScript.indexOf("'{\"AllKillBanner")+1);
		}
		//listScript = listScript.substring(0, listScript.length()-1);

		StringBuffer listScriptSB = new StringBuffer(listScript);

		JSONObject inputJson = new JSONObject(listScript);
		JSONArray topList = inputJson.getJSONArray("AllKillMainDeals");

		for(int i=0; i<topList.length(); i++) {
			JSONObject listItemMain = topList.getJSONObject(i);
			String tempJsonMain = listItemMain.getString("Item");
			tempJsonMain = tempJsonMain.replace("\\\\", "");
			
			// json파싱이 안되서 그냥 자름
			String itemNoStr = "ItemNo\":\"";
			String itemImageUrlStr = "ItemImageUrl\":\"";
			String goodsCodeTemp = "";
			String shopImgUrlTemp = "";

			if(tempJsonMain.indexOf(itemNoStr)>-1) {
				goodsCodeTemp = tempJsonMain.substring(tempJsonMain.indexOf(itemNoStr) + itemNoStr.length());
				goodsCodeTemp = goodsCodeTemp.substring(0, goodsCodeTemp.indexOf("\""));
			}

			if(tempJsonMain.indexOf(itemImageUrlStr)>-1) {
				shopImgUrlTemp = tempJsonMain.substring(tempJsonMain.indexOf(itemImageUrlStr) + itemImageUrlStr.length());
				shopImgUrlTemp = shopImgUrlTemp.substring(0, shopImgUrlTemp.indexOf("\""));
			}

			//JSONObject listItem = new JSONObject(tempJsonMain);
			//out.println(tempJsonMain);
			//out.println("goodsCodeTemp="+goodsCodeTemp);

			if(goodsCodeTemp.length()>0) {
				if(goodsCodeList.length()>0) goodsCodeList += ",";
				goodsCodeList += goodsCodeTemp;

				imageUrlHash.put(goodsCodeTemp, shopImgUrlTemp);
			}
		}
	}

	//dealType=2 : 지마켓
	if(dealType.equals("2")) {
		String goodsCodeFinder = "goodsCode%3d";

		Elements itemLink = doc.select(".super_deal .bx_prd a");
		for (Element link : itemLink) {
			String linkUrl = link.attr("href");
			String itemGoodsCode = "";

			if(linkUrl.indexOf(goodsCodeFinder)>-1) {
				itemGoodsCode = linkUrl.substring(linkUrl.indexOf(goodsCodeFinder) + goodsCodeFinder.length());

				if(goodsCodeList.length()>0) goodsCodeList += ",";
				goodsCodeList += itemGoodsCode;

				Elements imgElm = link.select("img");
				String imgUrl = imgElm.attr("src");

				imageUrlHash.put(itemGoodsCode, imgUrl);
			}
		}
	}
	//dealType=3 : 11번가
	if(dealType.equals("3")) {
		String goodsCodeFinder = "prdNo=";
		Elements itemLink = doc.select(".m_skdealing .list_skd .skdbox .dft");
		for (Element link : itemLink) {
			String linkUrl = link.attr("href");
			String itemGoodsCode = "";

			if(linkUrl.indexOf(goodsCodeFinder)>-1) {
				itemGoodsCode = linkUrl.substring(linkUrl.indexOf(goodsCodeFinder) + goodsCodeFinder.length());

				if(goodsCodeList.length()>0) goodsCodeList += ",";
				goodsCodeList += itemGoodsCode;

				Elements imgElm = link.select(".thumb img");
				String imgUrl = imgElm.attr("src");

				imageUrlHash.put(itemGoodsCode, imgUrl);
			}
//			out.println(itemGoodsCode + ", linkUrl="+linkUrl);
		}
	}

	//dealType=4 : 지마켓
	if(dealType.equals("4") || dealType.equals("5") || dealType.equals("6") || dealType.equals("7") ) {
		String goodsCodeFinder = "goodsCode";

		Elements itemLink = doc.select(".best_lst  > li > a");
		for (Element link : itemLink) {
			String linkUrl = link.attr("href");
			String itemGoodsCode = "";
			
			//System.out.println(linkUrl);
			
			if(linkUrl.indexOf(goodsCodeFinder)>-1) {
						
				//itemGoodsCode = StringUtils.substringBetween(linkUrl, "goodscode=", "&ver=");
				//http://mitem.gmarket.co.kr/Item?goodsCode=2260453745
				
				itemGoodsCode = StringUtils.substringAfterLast(linkUrl, "goodsCode=");
				//itemGoodsCode = StringUtils.remove(linkUrl, "http://mitem.gmarket.co.kr/Item?goodsCode=") ;
				
				//System.out.println("itemGoodsCode :"+itemGoodsCode);
				
				if(goodsCodeList.length()>0) goodsCodeList += ",";
				goodsCodeList += itemGoodsCode;
				
				Elements imgElm = link.select("img");
				String imgUrl = imgElm.attr("src");

				imageUrlHash.put(itemGoodsCode, imgUrl);
			}
		}
	}
	
	//dealType=8 : 11번가
	if(dealType.equals("8")) {
		String goodsCodeFinder = "prdNo=";
		Elements itemLink = doc.select(".viewtype.catal_ty > ul > li > div > a");
		for (Element link : itemLink) {
			String linkUrl = link.attr("href");
			String itemGoodsCode = "";
			
			if(linkUrl.indexOf(goodsCodeFinder)>-1) {
				//itemGoodsCode = linkUrl.substring(linkUrl.indexOf(goodsCodeFinder) + goodsCodeFinder.length());

				itemGoodsCode = StringUtils.substringBetween(linkUrl, "prdNo=", "&trTypeCd");
				
				if(goodsCodeList.length()>0) goodsCodeList += ",";
				goodsCodeList += itemGoodsCode;

				Elements imgElm = link.select(".thumb img");
				String imgUrl = imgElm.attr("src");

				imageUrlHash.put(itemGoodsCode, imgUrl);
			}

		}
	}
	
}
//out.println("goodsCodeList="+goodsCodeList);

// 실제로 데이터베이스에서 에누리 상품정보를 읽어옴
// modelno가 0이하이면 매칭이 안된것임
if(goodsCodeList.length()>0) {

	String[] goodsCodeListAry = goodsCodeList.split(",");
	Mobile_GoodsToPricelist_Proc mobile_goodstopricelist_proc = new Mobile_GoodsToPricelist_Proc();

	out.println("{");
	
	int outTotalCnt = 0;
	if(goodsCodeListAry!=null) {
		out.println("	\"goodsList\": [");
		for(int i=0; i<goodsCodeListAry.length; i++) {
			if(goodsCodeListAry[i].length()>0) {
				Mobile_GoodsToPricelist_Data mgtpd = mobile_goodstopricelist_proc.getPrictListOne(shop_code, goodsCodeListAry[i]);
				//out.println("shop_code="+shop_code+", goodsCodeListAry["+i+"]="+goodsCodeListAry[i]);

				if(mgtpd!=null) {
					int o_modelno = mgtpd.getModelno();
					long o_pl_no = mgtpd.getPl_no();
					String o_ca_code = mgtpd.getCa_code();
					String o_imgurl = mgtpd.getImgurl();
			
					String o_url = mgtpd.getUrl();
					
					String pc_url = "";
					
					long o_price = mgtpd.getPrice();
					String o_goodsnm = mgtpd.getGoodsnm();
					String o_goodscode = mgtpd.getGoodscode();
					String shopImageUrl = "";
		    		String deliveryinfo = mgtpd.getDeliveryinfo();
		    		int deliveryinfo2 = mgtpd.getDeliveryinfo2();
		    		String deliverytype2 = mgtpd.getDeliverytype2();
		    		String ca_code4 = "";
		    		String ca_codeName4 = "";
		    		String orgPrice = "";

		    		//중카테로 변경 2015-12-02
		    		if(o_ca_code.length()>4) ca_code4 = o_ca_code.substring(0, 4);
		    		else ca_code4 = o_ca_code;
		    		Category_Proc category_proc = new Category_Proc();
		    		ca_codeName4 = category_proc.getData_Catename(ca_code4, 2);
		    		
		    		if(ca_codeName4.equals("")){
		    			 continue;
		    		}
		    		
					if(imageUrlHash.containsKey(o_goodscode)) {
						shopImageUrl = imageUrlHash.get(o_goodscode);
					}

					// 모바일로 수익코드 변경
					o_url = toUrlCode(o_url);

					if(outTotalCnt>0) out.print(",\r\n");

					JSONObject jSONObject = new JSONObject();
					
					jSONObject.put("gd_cd", goodsCodeListAry[i].toString());
					jSONObject.put("modelno", o_modelno+"");
					jSONObject.put("spm_cd", shop_code+"");
					jSONObject.put("gd_kn_cd", "B");
					jSONObject.put("pcnt", "");
					jSONObject.put("imgtype", "");
					jSONObject.put("option", "");
					jSONObject.put("pl_no", o_pl_no+"");
					jSONObject.put("ca_code", o_ca_code+"");
					jSONObject.put("ca_code4", ca_code4+"");
					jSONObject.put("ca_codeName", ca_codeName4+"");
					jSONObject.put("imgurl", o_imgurl+"");
					jSONObject.put("shopImageUrl", shopImageUrl+"");
					jSONObject.put("url", o_url+"");
					jSONObject.put("pc_url", o_url+"");
					jSONObject.put("price", o_price+"");
					jSONObject.put("deliveryinfo", deliveryinfo+"");
					jSONObject.put("deliveryinfo2", deliveryinfo2+"");
					jSONObject.put("deliverytype2", deliverytype2+"");
					jSONObject.put("goodsnm", o_goodsnm+"");
					jSONObject.put("orgPrice", orgPrice+"");
					
					jSONObject = urlConversion(jSONObject,shop_code);
					
					out.println(jSONObject.toString());
					/*
					out.println("		{");
					out.println("		\"gd_cd\":\""+goodsCodeListAry[i]+"\", ");
					out.println("		\"modelno\":\""+o_modelno+"\", ");
					out.println("		\"spm_cd\":\""+shop_code+"\", ");
					out.println("		\"gd_kn_cd\":\"B\", ");
					out.println("		\"pcnt\":\"\", ");
					out.println("		\"imgtype\":\"\", ");
					out.println("		\"option\":\"\", ");
					out.println("		\"pl_no\":\""+o_pl_no+"\", ");
					out.println("		\"ca_code\":\""+o_ca_code+"\", ");
					out.println("		\"ca_code4\":\""+ca_code4+"\", ");
					out.println("		\"ca_codeName\":\""+ca_codeName4+"\", ");
					out.println("		\"imgurl\":\""+o_imgurl+"\", ");
					out.println("		\"shopImageUrl\":\""+shopImageUrl+"\", ");
					out.println("		\"url\":\""+o_url+"\", ");
					out.println("		\"pc_url\":\""+pc_url+"\", ");
					out.println("		\"price\":\""+o_price+"\", ");
					out.println("		\"deliveryinfo\":\""+deliveryinfo+"\", ");
					out.println("		\"deliveryinfo2\":\""+deliveryinfo2+"\", ");
					out.println("		\"deliverytype2\":\""+deliverytype2+"\", ");
					out.println("		\"goodsnm\":\""+o_goodsnm+"\", ");
					out.println("		\"orgPrice\":\""+orgPrice+"\" ");
					out.print("		}");
					*/
					outTotalCnt++;
				}
			}
		}
		out.println("\r\n	], ");
	}
	out.println("	\"totalCnt\":\""+outTotalCnt+"\" ");
	out.println("}");
}
%>
