<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ include file="/mobilefirst/include/urlConversion.jsp"%>
<%@ page import="com.enuri.bean.mobile.Mobile_GoodsToPricelist_Proc"%>
<%@ page import="com.enuri.bean.mobile.Mobile_GoodsToPricelist_Data"%>
<%@ page import="com.enuri.bean.main.Category_Proc"%>
<%@ page import="java.net.HttpURLConnection"%>
<%@ page import="java.net.URL"%>
<%@ page import="java.io.*"%>
<%@ page import="org.json.JSONArray"%>
<%@ page import="org.json.JSONObject"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
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
			conn.setReadTimeout(5000);
			conn.setRequestProperty("Accept-Charset", encodingStr);
//			conn.addRequestProperty("Accept-Language", "en-US,en;q=0.8");
//			conn.addRequestProperty("User-Agent", "Mozilla");
//			conn.addRequestProperty("Referer", "google.com");
			conn.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.6) Gecko/20100625 Firefox/3.6.6");

			BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream(), encodingStr));
			String inputLine;
			while ((inputLine = in.readLine()) != null) {
				html.append(inputLine);
			}
			in.close();
			rtnValue = html.toString();
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
// bestType=1 : 옥션
// bestType=2 : 지마켓
// bestType=3 : 11번가
String bestType = ConfigManager.RequestStr(request, "bestType", "0");

// url 읽어오기 위한 기본 정보를 저장하는 변수
String url = "";
String param = "";
String encodingStr = "";
int type = 0; // type=1 : get, type=2 : post
int shop_code = 0;

ArrayList alTemp = new ArrayList(); 
//bestType=1 : 옥션
//- get
//- http://mobile.auction.co.kr/Home/mBestSeller.aspx?pagesize=100
if(bestType.equals("1")) {
	url = "http://mobile.auction.co.kr/Home/mBestSeller.aspx?pagesize=100";
	param = "";
	encodingStr = "euc-kr";
	type = 1;
	shop_code = 4027;
}
//bestType=2 : 지마켓
//- post
//- mobile.gmarket.co.kr/Best/GetBestItems
//- code=G00
if(bestType.equals("2")) {
	url = "http://mobile.gmarket.co.kr/Best/GetBestItems";
	param = "code=G00";
	encodingStr = "utf-8";
	type = 2;
	shop_code = 536;
}
//bestType=3 : 11번가
//- get
//- http://m.11st.co.kr/MW/api/app/elevenst/rank/mobileBestRankingJson.tmall?refererType=sub&rkType=M
if(bestType.equals("3")) {
	url = "http://m.11st.co.kr/MW/api/app/elevenst/rank/mobileBestRankingJson.tmall?refererType=sub&rkType=M";
	param = "";
	encodingStr = "euc-kr";
	type = 1;
	shop_code = 5910;
}

String outPutStr = "";
if(url.length()>0 && type>0) {
	outPutStr = getHttpSource(url, param, encodingStr, type);
}
//out.println(outPutStr);
//out.println("<br><br>----------------------------------------------------------------------------------------------------------------------------------------------<br><br>");
// 상품코드를 저장하는 변수
String goodsCodeList = "";
//goodscode : imageUrlHash -> 선택된 쇼핑몰에서는 goodscode가 유일함
HashMap<String, String> imageUrlHash = new HashMap<String, String>();
if(outPutStr.length()>0) {
	//bestType=1 : 옥션
	if(bestType.equals("1")) {
		JSONObject inputJson = new JSONObject(outPutStr);
		JSONArray topList = inputJson.getJSONArray("Items");

		for(int i=0; i<topList.length(); i++) {
			JSONObject listItem = topList.getJSONObject(i);

			if(listItem.has("ItemID")) {
				if(goodsCodeList.length()>0) goodsCodeList += ",";
				goodsCodeList += listItem.getString("ItemID");

				if(listItem.has("ApiPictureUrl")) {
					imageUrlHash.put(listItem.getString("ItemID"), listItem.getString("ApiPictureUrl"));
				}
			}
		}
	}

	//bestType=2 : 지마켓
	if(bestType.equals("2")) {
		JSONArray topList = new JSONArray(outPutStr);
        ;
		for(int i=0; i<topList.length(); i++) {
			JSONObject listItem = topList.getJSONObject(i);

			if(listItem.has("GoodsCode")) {
				if(goodsCodeList.length()>0) goodsCodeList += ",";
				goodsCodeList += listItem.getString("GoodsCode");

				if(listItem.has("ImageUrl")) {
					imageUrlHash.put(listItem.getString("GoodsCode"), listItem.getString("ImageUrl"));
				}
			}
		}
	}
	//bestType=3 : 11번가
	if(bestType.equals("3")) {
		JSONObject inputJson = new JSONObject(outPutStr);
		JSONArray topList = inputJson.getJSONArray("data");

		for(int i=0; i<topList.length(); i++) {
			JSONObject commonItem = topList.getJSONObject(i);

			if(!commonItem.isNull("commonProduct")) {
				JSONObject listItem = commonItem.getJSONObject("commonProduct");

				if(listItem!=null) {
					if(listItem.has("prdNo")) {
						if(goodsCodeList.length()>0) goodsCodeList += ",";
						goodsCodeList += listItem.getString("prdNo");

						if(listItem.has("prdImgUrl")) {
							imageUrlHash.put(listItem.getString("prdNo"), listItem.getString("prdImgUrl"));
						}
					}
				}
			}
			//out.println(","+i+"=="+listItem.getString("ItemID"));
		}
	}
}
//인터파크 쎈딜
//bestType=4 인터파크
    if(bestType.equals("4")) {
        
        shop_code = 55;
       
        JSONArray JSONArray = new JSONArray(); 
        //1 페이지
        String interParkUrl1 = "http://m.shop.interpark.com/main/_ajax/get_best_prd_list.html?kind=00_000000_0_00&page=1&_=1487926808216";
        JSONObject jSONObject = jsonUrlParsing(interParkUrl1);
        JSONArray.put((JSONArray)jSONObject.get("list"));
        //2 페이지
        String interParkUrl2 = "http://m.shop.interpark.com/main/_ajax/get_best_prd_list.html?kind=00_000000_0_00&page=2&_=1487926808216";
        jSONObject = jsonUrlParsing(interParkUrl2);
        JSONArray.put((JSONArray)jSONObject.get("list"));
        //3 페이지
        String interParkUrl3 = "http://m.shop.interpark.com/main/_ajax/get_best_prd_list.html?kind=00_000000_0_00&page=3&_=1487926808216";
        jSONObject = jsonUrlParsing(interParkUrl3);
        JSONArray.put((JSONArray)jSONObject.get("list"));
        //4 페이지
        String interParkUrl4 = "http://m.shop.interpark.com/main/_ajax/get_best_prd_list.html?kind=00_000000_0_00&page=4&_=1487926808216";
        jSONObject = jsonUrlParsing(interParkUrl4);
        JSONArray.put((JSONArray)jSONObject.get("list"));
        //5 페이지
        String interParkUrl5 = "http://m.shop.interpark.com/main/_ajax/get_best_prd_list.html?kind=00_000000_0_00&page=5&_=1487926808216";
        jSONObject = jsonUrlParsing(interParkUrl5);
        JSONArray.put((JSONArray)jSONObject.get("list"));
        //6 페이지
        String interParkUrl6 = "http://m.shop.interpark.com/main/_ajax/get_best_prd_list.html?kind=00_000000_0_00&page=6&_=1487926808216";
        jSONObject = jsonUrlParsing(interParkUrl6);
        JSONArray.put((JSONArray)jSONObject.get("list"));
        //7 페이지
        String interParkUrl7 = "http://m.shop.interpark.com/main/_ajax/get_best_prd_list.html?kind=00_000000_0_00&page=7&_=1487926808216";
        jSONObject = jsonUrlParsing(interParkUrl7);
        JSONArray.put((JSONArray)jSONObject.get("list"));
        //8 페이지
        String interParkUrl8 = "http://m.shop.interpark.com/main/_ajax/get_best_prd_list.html?kind=00_000000_0_00&page=8&_=1487926808216";
        jSONObject = jsonUrlParsing(interParkUrl8);
        JSONArray.put((JSONArray)jSONObject.get("list"));
        //9 페이지
        String interParkUrl9 = "http://m.shop.interpark.com/main/_ajax/get_best_prd_list.html?kind=00_000000_0_00&page=9&_=1487926808216";
        jSONObject = jsonUrlParsing(interParkUrl9);
        JSONArray.put((JSONArray)jSONObject.get("list"));
        //10 페이지
        String interParkUrl10 = "http://m.shop.interpark.com/main/_ajax/get_best_prd_list.html?kind=00_000000_0_00&page=10&_=1487926808216";
        jSONObject = jsonUrlParsing(interParkUrl10);
        JSONArray.put((JSONArray)jSONObject.get("list"));
        //11 페이지
        String interParkUrl11 = "http://m.shop.interpark.com/main/_ajax/get_best_prd_list.html?kind=00_000000_0_00&page=11&_=1487926808216";
        jSONObject = jsonUrlParsing(interParkUrl11);
        JSONArray.put((JSONArray)jSONObject.get("list"));
        //12 페이지
        String interParkUrl12 = "http://m.shop.interpark.com/main/_ajax/get_best_prd_list.html?kind=00_000000_0_00&page=12&_=1487926808216";
        jSONObject = jsonUrlParsing(interParkUrl12);
        JSONArray.put((JSONArray)jSONObject.get("list"));
        //13 페이지
        String interParkUrl13 = "http://m.shop.interpark.com/main/_ajax/get_best_prd_list.html?kind=00_000000_0_00&page=13&_=1487926808216";
        jSONObject = jsonUrlParsing(interParkUrl13);
        JSONArray.put((JSONArray)jSONObject.get("list"));
        //14 페이지
        String interParkUrl14 = "http://m.shop.interpark.com/main/_ajax/get_best_prd_list.html?kind=00_000000_0_00&page=14&_=1487926808216";
        jSONObject = jsonUrlParsing(interParkUrl14);
        JSONArray.put((JSONArray)jSONObject.get("list"));
        //15 페이지
        String interParkUrl15 = "http://m.shop.interpark.com/main/_ajax/get_best_prd_list.html?kind=00_000000_0_00&page=15&_=1487926808216";
        jSONObject = jsonUrlParsing(interParkUrl15);
        JSONArray.put((JSONArray)jSONObject.get("list"));
        //16 페이지
        String interParkUrl = "http://m.shop.interpark.com/main/_ajax/get_best_prd_list.html?kind=00_000000_0_00&page=16&_=1487926808216";
        jSONObject = jsonUrlParsing(interParkUrl);
        
        JSONArray.put((JSONArray)jSONObject.get("list"));
        //17 페이지
        interParkUrl = "http://m.shop.interpark.com/main/_ajax/get_best_prd_list.html?kind=00_000000_0_00&page=17&_=1487926808216";
        jSONObject = jsonUrlParsing(interParkUrl);
        JSONArray.put((JSONArray)jSONObject.get("list"));
        //18 페이지
        //interParkUrl = "http://m.shop.interpark.com/main/_ajax/get_best_prd_list.html?kind=00_000000_0_00&page=18&_=1487926808216";
        //jSONObject = jsonUrlParsing(interParkUrl);
        //JSONArray.put((JSONArray)jSONObject.get("list"));
        
        for(int i=0;i<JSONArray.length();i++){
            JSONArray array= (JSONArray)JSONArray.get(i);
            for(int j=0; j < array.length() ; j++){
                JSONObject jSONObjectA = (JSONObject)array.get(j);
                String prdNo = jSONObjectA.getString("prdNoStr");
                String bannerImage = jSONObjectA.getString("mainImage");
                
                if(goodsCodeList.length()>0) goodsCodeList += ",";
                goodsCodeList += prdNo;
                imageUrlHash.put(prdNo,bannerImage);
                
            }
        }
    }
//인터파크 특가모음
if(bestType.equals("5")) {
        
	shop_code = 55;
	JSONArray JSONArray = new JSONArray(); 
	//1 페이지
	String interCenDealUrl = "http://m.shop.interpark.com/ssendeal/_ajax/hotdeal_prd_list.html?page=1&dispTp=000&_=1487928511120";
	JSONObject jSONObj = jsonUrlParsing(interCenDealUrl);
	JSONArray.put((JSONArray)jSONObj.get("list"));
	//2 페이지
	interCenDealUrl = "http://m.shop.interpark.com/ssendeal/_ajax/hotdeal_prd_list.html?page=2&dispTp=000&_=1487928511120";
	jSONObj = jsonUrlParsing(interCenDealUrl);
	JSONArray.put((JSONArray)jSONObj.get("list"));
	//3 페이지
	interCenDealUrl = "http://m.shop.interpark.com/ssendeal/_ajax/hotdeal_prd_list.html?page=3&dispTp=000&_=1487928511120";
	jSONObj = jsonUrlParsing(interCenDealUrl);
	JSONArray.put((JSONArray)jSONObj.get("list"));
	
	for(int i=0;i<JSONArray.length();i++){
	    JSONArray array= (JSONArray)JSONArray.get(i);
	    for(int j=0; j < array.length() ; j++){
	        JSONObject jSONObjectA = (JSONObject)array.get(j);
	        String prdNo = jSONObjectA.getString("prdNoStr");
	        String bannerImage = jSONObjectA.getString("bannerImage");
	        String orderCnt = StringUtils.defaultString(jSONObjectA.getString("orderCnt"),"0");
	        String mktPr = StringUtils.defaultString(jSONObjectA.getString("mktPr"),"0");
	        
	        if(goodsCodeList.length()>0) goodsCodeList += ",";
	        goodsCodeList += prdNo;
	        imageUrlHash.put(prdNo,bannerImage);
	        
	        HashMap map = new HashMap(); 
	        map.put("orderCnt", orderCnt);
	        map.put("mktPr", mktPr);
	        alTemp.add(map);
	        
	    }
	}
}
//out.println("shop_code="+shop_code+", goodsCodeList="+goodsCodeList);
// 실제로 데이터베이스에서 에누리 상품정보를 읽어옴
// modelno가 0이하이면 매칭이 안된것임
if(goodsCodeList.length()>0) {
    
	String[] goodsCodeListAry = goodsCodeList.split(",");
	Mobile_GoodsToPricelist_Proc mobile_goodstopricelist_proc = new Mobile_GoodsToPricelist_Proc();
	out.println("{");
	
	if(bestType.equals("5")){
		out.println("	\"shopCode\": 55,");
		out.println("   \"imgtype\":\""+2+"\", ");
	}
	
	int outTotalCnt = 0;
	if(goodsCodeListAry!=null) {
		out.println("	\"goodsList\": [");
		for(int i=0; i<goodsCodeListAry.length; i++) {
			if(goodsCodeListAry[i].length()>0) {
				
				Mobile_GoodsToPricelist_Data mgtpd = mobile_goodstopricelist_proc.getPrictListOne(shop_code, goodsCodeListAry[i]);

				if(mgtpd!=null) {
					int o_modelno = mgtpd.getModelno();
					long o_pl_no = mgtpd.getPl_no();
					String o_ca_code = mgtpd.getCa_code();
					String o_imgurl = mgtpd.getImgurl();
					String o_url = mgtpd.getUrl();
					long o_price = mgtpd.getPrice();
					long o_Instance_price = mgtpd.getInstance_price();
					String o_goodsnm = mgtpd.getGoodsnm();
					String o_goodscode = mgtpd.getGoodscode();
					String shopImageUrl = "";
		    		String deliveryinfo = mgtpd.getDeliveryinfo();
		    		int deliveryinfo2 = mgtpd.getDeliveryinfo2();
		    		String deliverytype2 = mgtpd.getDeliverytype2();
		    		String ca_code4 = "";
		    		String ca_codeName4 = "";
		    		String pcnt = "";
                    
                    if(o_Instance_price != 0)	o_price = o_Instance_price;
                    
                    if(o_modelno == 11775708){ //다나와 예외처리
                        continue;
                    }
                    Long plno = Long.parseLong("2437236079");
                    
                    if(o_pl_no == plno){
                        continue;
                    }
                    
                    if( o_imgurl.indexOf(".jpg") == -1  ){
                        continue;                    
                    }
                    
		    		/*
		    		if(o_ca_code.length()>6) ca_code6 = o_ca_code.substring(0, 6);
		    		else ca_code6 = o_ca_code;
		    		Category_Proc category_proc = new Category_Proc();
		    		ca_codeName6 = category_proc.getData_Catename(ca_code6, 3);
		    		 */
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
					
                    Long plno2 = Long.parseLong("3001441531");
                    if(o_pl_no == plno2){
                    	o_imgurl = shopImageUrl;
                    }
					
					// 모바일로 수익코드 변경
					o_url = toUrlCode(o_url);

					if(outTotalCnt>0) out.print(",\r\n");
					/*
					out.println("		{");
					out.println("		\"modelno\":\""+o_modelno+"\", ");
					out.println("		\"pl_no\":\""+o_pl_no+"\", ");
					out.println("		\"ca_code\":\""+o_ca_code+"\", ");
					out.println("		\"ca_code4\":\""+ca_code4+"\", ");
					out.println("		\"ca_codeName\":\""+ca_codeName4+"\", ");
					out.println("        \"price\":\""+o_price+"\", ");
					if(shop_code == 55){
			    		if(bestType.equals("5")){
			    			//pcnt = StringUtils.replace((String)alTemp.get(i), ".0", "") ;
			    			
			    			HashMap map = (HashMap)alTemp.get(i);
			    			pcnt = StringUtils.replace((String)map.get("orderCnt"),".0","") ;
			    			String orgPrice = StringUtils.defaultString((String)map.get("mktPr")) ;
			    			
			    			out.println("       \"orgPrice\":\""+orgPrice+"\", ");
			    			
			    			out.println("       \"pcnt\":\""+pcnt+"\", ");
				    		out.println("       \"imgtype\":\""+2+"\", ");
			    		}
			    		//크롤링 한 이미지 사이즈 가 작아서 우리 이미지로 사용 
                        out.println("       \"imgurl\":\""+shopImageUrl+"\", ");
                        out.println("       \"shopImageUrl\":\""+o_imgurl+"\", ");
                        
					}else{
	                        out.println("       \"imgurl\":\""+o_imgurl+"\", ");
	                        out.println("       \"shopImageUrl\":\""+shopImageUrl+"\", ");	
					}
					out.println("		\"url\":\""+o_url+"\", ");
					out.println("		\"pc_url\":\""+mgtpd.getUrl()+"\", ");
					out.println("		\"deliveryinfo\":\""+deliveryinfo+"\", ");
					out.println("		\"deliveryinfo2\":\""+deliveryinfo2+"\", ");
					out.println("		\"deliverytype2\":\""+deliverytype2+"\", ");
					out.println("		\"goodsnm\":\""+toJS2(o_goodsnm)+"\" ");
					out.print("		}");
					*/
					
					JSONObject jSONObject = new JSONObject ();
					jSONObject.put("view_ord",i);
					jSONObject.put("spm_cd",shop_code);
					jSONObject.put("gd_kn_cd","B");
					jSONObject.put("gd_cd",goodsCodeListAry[i]);
										
					jSONObject.put("modelno",""+o_modelno+"");
					jSONObject.put("pl_no", ""+o_pl_no+"");
					jSONObject.put("ca_code",""+o_ca_code+"");
					jSONObject.put("ca_code4", ""+ca_code4+"");
					jSONObject.put("ca_codeName", ""+ca_codeName4+"");
					jSONObject.put("price", ""+o_price+"");
					jSONObject.put("url", o_url);
					jSONObject.put("pc_url", mgtpd.getUrl());
					jSONObject.put("deliveryinfo", ""+deliveryinfo+"");
					jSONObject.put("deliveryinfo2", ""+deliveryinfo2+"");
					jSONObject.put("deliverytype2", ""+deliverytype2+"");
					jSONObject.put("goodsnm", toJS2(o_goodsnm));
					
					if(shop_code == 55){
			    		if(bestType.equals("5")){
			    			//인터파크만 따로
			    			HashMap map = (HashMap)alTemp.get(i);
			    			pcnt = StringUtils.replace((String)map.get("orderCnt"),".0","") ;
			    			String orgPrice = StringUtils.defaultString((String)map.get("mktPr")) ;

				    		jSONObject.put("orgPrice", ""+orgPrice+"");
				    		jSONObject.put("pcnt", ""+pcnt+"");
				    		jSONObject.put("imgtype", "2");
				    		
			    		}
			    		//크롤링 한 이미지 사이즈 가 작아서 우리 이미지로 사용 
                        jSONObject.put("imgurl", shopImageUrl);
                        jSONObject.put("shopImageUrl", o_imgurl);
                        
                        
					}else{
                        jSONObject.put("imgurl", o_imgurl);
                        jSONObject.put("shopImageUrl", shopImageUrl);
					}
					
					jSONObject = urlConversion(jSONObject,shop_code);
					
					out.println(jSONObject.toString());
					outTotalCnt++;
					
					mobile_goodstopricelist_proc.hotDealInsUpd(jSONObject);
					
				}
			}
		}
		out.println("\r\n	], ");
	}
	out.println("	\"totalCnt\":\""+outTotalCnt+"\" ");
	out.println("}");
}

%>
<%!
public JSONObject jsonUrlParsing(String strUrl) throws UnsupportedEncodingException, MalformedURLException, IOException{

    BufferedReader br = new BufferedReader(new InputStreamReader((new URL(strUrl)).openConnection().getInputStream(),"UTF-8"));
    StringBuilder sbJson = new StringBuilder();
    String strLine = "";
        
    while ((strLine = br.readLine()) != null){
        sbJson.append(strLine);
    }
    br.close();
    
    if(sbJson != null){
        try {
            JSONObject JSONObject = new JSONObject(sbJson.toString());
            return JSONObject;
        } catch (Exception e) {
            System.out.println("********* shopDeal3Make jsonUrlParsing **************:"+strUrl+"======"+e);
        }
    }
    return null;
}
%>