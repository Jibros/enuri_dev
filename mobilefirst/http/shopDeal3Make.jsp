<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ include file="/mobilefirst/include/urlConversion.jsp"%>
<%@ page import="com.enuri.bean.mobile.Mobile_GoodsToPricelist_Proc"%>
<%@ page import="com.enuri.bean.mobile.Mobile_GoodsToPricelist_Data"%>
<%@ page import="java.net.HttpURLConnection"%>
<%@ page import="java.net.URL"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page import="java.io.OutputStreamWriter"%>
<%@ page import="java.io.OutputStream"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.io.*"%>
<%@ page import="org.json.*"%>
<%@ page import="org.jsoup.*"%>
<%@ page import="org.jsoup.nodes.*"%>
<%@ page import="org.jsoup.select.*"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="org.apache.commons.lang3.*"%>
<%
// url
// type=1 : get
// type=2 : post
// post일 경우는 param이 필요하지만 get일경우는 그냥 url에 포함시키면됨
	String bestType = StringUtils.defaultString(request.getParameter("bestType"));
	
	int shopCode = 0;
    //인터파크
    if(bestType.equals("5")) {
    
        JSONArray JSONArray = new JSONArray(); 
        //1 페이지
        String interParkUrl1 = "http://m.shop.interpark.com/ssendeal/_ajax/hotdeal_prd_list.html?page=1&dispTp=000&_=1487812647787";
        JSONObject jSONObject1 = jsonUrlParsing(interParkUrl1);
        JSONArray.put((JSONArray)jSONObject1.get("list"));
        //2 페이지
        String interParkUrl2 = "http://m.shop.interpark.com/ssendeal/_ajax/hotdeal_prd_list.html?page=2&dispTp=000&_=1487812647788";
        JSONObject jSONObject2 = jsonUrlParsing(interParkUrl2);
        JSONArray.put((JSONArray)jSONObject2.get("list"));
        //3 페이지
        String interParkUrl3 = "http://m.shop.interpark.com/ssendeal/_ajax/hotdeal_prd_list.html?page=3&dispTp=000&_=1487812647789";
        JSONObject jSONObject3 = jsonUrlParsing(interParkUrl3);
        JSONArray.put((JSONArray)jSONObject3.get("list"));
        
        for(int i=0;i<JSONArray.length();i++){
            JSONArray array= (JSONArray)JSONArray.get(i);
            for(int j=0; j < array.length() ; j++){
                JSONObject jSONObject = (JSONObject)array.get(j);
                String prdNo = jSONObject.getString("prdNoStr");
                
            }
        }
    }
    // 위메프 베스트
    if(bestType.equals("4")) {
    	String url = "https://front.wemakeprice.com/best";
    	Document doc = null;
    	Mobile_GoodsToPricelist_Proc proc = new Mobile_GoodsToPricelist_Proc();
    	Category_Proc category_proc = new Category_Proc();
    	JSONObject exportJsonObject = new JSONObject();
		JSONArray goodsJsonList = new JSONArray();
		shopCode = 6508; //위메프
		
    	try {
    		doc = Jsoup.connect(url).get();
    		
    		Elements elems = doc.select("head");
    		StringBuilder sb =new  StringBuilder(StringUtils.substringBetween(elems.toString().trim(), "'initialData', JSON.parse('" , "'))"));
    		
    		
    		sb = new  StringBuilder(StringUtils.replace( sb.toString() , "AAAAAA", "" ));
    		sb = new  StringBuilder(StringUtils.replace( sb.toString() , "\\\'#\\\'", "" ));
    		sb = new  StringBuilder(StringUtils.replace( sb.toString() , "\\\"", "'" ));
    		
    		JSONObject rootObj = new JSONObject();
    		if(sb.toString().length()>0) {
    			rootObj = new JSONObject(sb.toString());
    			
    		}
    		
    		
    		if(rootObj.has("deals")) {
    			JSONArray itemList = rootObj.getJSONArray("deals");
    			
    			
    			int matchedItemCount = 0;
    			int categoryPerMaxCnt = 20;
    			for(int i=0; i<itemList.length() && matchedItemCount<categoryPerMaxCnt; i++) {
    				JSONObject jsonGoods = itemList.getJSONObject(i);
    				
    				String itemCode = jsonGoods.getString("linkInfo");
    						
    				Mobile_GoodsToPricelist_Data mgtpd = proc.getPrictListOne(shopCode, itemCode);

    				if(mgtpd != null) {
    					
    					JSONObject exportJson = new JSONObject();

    					//상품 이미지
    					String imgSrc = jsonGoods.getString("originImgUrl");

    					String o_ca_code = mgtpd.getCa_code();
    					String ca_code4 = "";
    					String ca_codeName4 = "";

    					if(o_ca_code.length()>4) ca_code4 = o_ca_code.substring(0, 4);
    					else ca_code4 = o_ca_code;
    					ca_codeName4 = category_proc.getData_Catename(ca_code4, 2);
    					
    					String orgPrice = jsonGoods.getString("originPrice");
    					long salePrice = mgtpd.getPrice();
    					
    					exportJson.put("gd_cd",mgtpd.getGoodscode());
    					exportJson.put("gd_kn_cd","H");
    					exportJson.put("view_ord",i);
    					exportJson.put("spm_cd",shopCode);
    					
    					exportJson.put("goodsnm", mgtpd.getGoodsnm().replaceAll("\\[.*?\\]", "").trim());
    					exportJson.put("goodscode", mgtpd.getGoodscode());
    					
    						
    					exportJson.put("url", toUrlCode(mgtpd.getUrl()));
    						
    					
    					exportJson.put("pc_url", mgtpd.getUrl());

    					exportJson.put("imgurl", mgtpd.getImgurl());
    					exportJson.put("shopImageUrl",imgSrc);

    					exportJson.put("modelno", String.valueOf(mgtpd.getModelno()));
    					exportJson.put("pl_no", String.valueOf(mgtpd.getPl_no()));

    					exportJson.put("ca_code", o_ca_code);
    					exportJson.put("ca_code4", ca_code4);
    					exportJson.put("ca_codeName", String.valueOf(ca_codeName4));

    					exportJson.put("price", String.valueOf(salePrice));
    					//exportJson.put("discount_rate", jsonGoods.isNull("dc_rate") ? "0" : jsonGoods.get("dc_rate"));
    					
    					int discount_rate = 0;
    					if(orgPrice != "" ){
    						float f_orgPrice = Float.valueOf(orgPrice);
    						float f_Price = (float)salePrice;
    						
    						if(f_orgPrice > f_Price){
    							discount_rate = (int) Math.round(((f_orgPrice-f_Price)/f_orgPrice)*100);
    						}
    						exportJson.put("discount_rate", discount_rate);
    					}else{
    						exportJson.put("discount_rate", discount_rate);	
    					}
    					
    					if( discount_rate == 0 ){
    						exportJson.put("orgPrice", String.valueOf(salePrice));
    					}else{
    						exportJson.put("orgPrice", orgPrice);
    					}
    					
    					exportJson.put("pcnt", jsonGoods.getString("discountRate"));

    					exportJson.put("deliveryinfo", mgtpd.getDeliveryinfo());
    					exportJson.put("deliveryinfo2", mgtpd.getDeliveryinfo2());
    					exportJson.put("deliverytype2", mgtpd.getDeliverytype2());

    					exportJson.put("orgPrice", orgPrice);
    					exportJson.put("option", "");

    					exportJson.put("shopCode", shopCode);
    					exportJson.put("imgtype","2");
    					
    					exportJson = urlConversion(exportJson,shopCode);
    					
    					goodsJsonList.put(exportJson);
    					
    					matchedItemCount++;
    				}
    			}
    		}
    		
    		//Shuffle data
			Random rnd = new Random();
			rnd.setSeed(System.currentTimeMillis());
	        for (int i = goodsJsonList.length() - 1; i >= 0; i--){
	          int j = rnd.nextInt(i + 1);
	          // Simple swap
	          JSONObject object = goodsJsonList.getJSONObject(j);
	          goodsJsonList.put(j, goodsJsonList.get(i));
	          goodsJsonList.put(i, object);
	        }
			
			exportJsonObject.put("goodsList", goodsJsonList);
			exportJsonObject.put("totalCnt", goodsJsonList.length());
			exportJsonObject.put("shopCode", shopCode);
			exportJsonObject.put("imgtype","2");
			
    	} catch ( IOException e) {
    		e.printStackTrace();
    	}
		out.println(exportJsonObject.toString());
	}
    
	//bestType=4 : 위메프: 홈 _ 실시간베스트 
	if(bestType.equals("444")) {
		
		Mobile_GoodsToPricelist_Proc proc = new Mobile_GoodsToPricelist_Proc();
		Category_Proc category_proc = new Category_Proc();
		
		JSONObject exportJsonObject = new JSONObject();
		JSONArray goodsJsonList = new JSONArray();
		try {
			
			shopCode = 6508; //위메프
			
			for(int cateCode=1000001; cateCode<=1000010; cateCode++) {
			
				JSONObject rootObj = jsonUrlParsing("http://www.wemakeprice.com/main/get_main_best_list/" + cateCode);
				//JSONObject rootObj = jsonUrlParsing("http://www.wemakeprice.com/main/get_main_best_list/1000000");
				
				if(rootObj.has("result") && rootObj.getInt("result") == 1) {
					
					JSONArray itemList = rootObj.getJSONObject("result_data").getJSONArray("deal_list");
					
					int matchedItemCount = 0;
					int categoryPerMaxCnt = 20;
					for(int i=0; i<itemList.length() && matchedItemCount<categoryPerMaxCnt; i++) {
						JSONObject jsonGoods = itemList.getJSONObject(i);
						
						String itemCode = jsonGoods.getString("deal_id");
								
						Mobile_GoodsToPricelist_Data mgtpd = proc.getPrictListOne(shopCode, itemCode);
	
						if(mgtpd != null) {
							
							JSONObject exportJson = new JSONObject();
	
							//상품 이미지
							String imgSrc = jsonGoods.getString("deal_image_url");
	
							String o_ca_code = mgtpd.getCa_code();
							String ca_code4 = "";
							String ca_codeName4 = "";
	
							if(o_ca_code.length()>4) ca_code4 = o_ca_code.substring(0, 4);
							else ca_code4 = o_ca_code;
							ca_codeName4 = category_proc.getData_Catename(ca_code4, 2);
							
							String orgPrice = jsonGoods.getString("price_org");
							long salePrice = mgtpd.getPrice();
							
							exportJson.put("gd_cd",mgtpd.getGoodscode());
							exportJson.put("gd_kn_cd","H");
							exportJson.put("view_ord",i);
							exportJson.put("spm_cd",shopCode);
							
							exportJson.put("goodsnm", mgtpd.getGoodsnm().replaceAll("\\[.*?\\]", "").trim());
							exportJson.put("goodscode", mgtpd.getGoodscode());
							exportJson.put("url", toUrlCode(mgtpd.getUrl()));
							exportJson.put("pc_url", mgtpd.getUrl());
	
							exportJson.put("imgurl", mgtpd.getImgurl());
							exportJson.put("shopImageUrl",imgSrc);
	
							exportJson.put("modelno", String.valueOf(mgtpd.getModelno()));
							exportJson.put("pl_no", String.valueOf(mgtpd.getPl_no()));
	
							exportJson.put("ca_code", o_ca_code);
							exportJson.put("ca_code4", ca_code4);
							exportJson.put("ca_codeName", String.valueOf(ca_codeName4));
	
							exportJson.put("price", String.valueOf(salePrice));
							//exportJson.put("discount_rate", jsonGoods.isNull("dc_rate") ? "0" : jsonGoods.get("dc_rate"));
							
							int discount_rate = 0;
							if(orgPrice != ""){
								float f_orgPrice = Float.valueOf(orgPrice);
								float f_Price = (float)salePrice;
								
								if(f_orgPrice != f_Price){
									discount_rate = (int) Math.round(((f_orgPrice-f_Price)/f_orgPrice)*100);
								}
							}
							
							exportJson.put("discount_rate", String.valueOf(discount_rate));
							
							exportJson.put("pcnt", jsonGoods.getString("total_qty_saled"));
	
							exportJson.put("deliveryinfo", mgtpd.getDeliveryinfo());
							exportJson.put("deliveryinfo2", mgtpd.getDeliveryinfo2());
							exportJson.put("deliverytype2", mgtpd.getDeliverytype2());
	
							exportJson.put("orgPrice", orgPrice);
							exportJson.put("option", "");
	
							exportJson.put("shopCode", shopCode);
							exportJson.put("imgtype","2");
							
							exportJson = urlConversion(exportJson,shopCode);
							
							goodsJsonList.put(exportJson);
							
							matchedItemCount++;
						}
					}
				}
			}
			
			//Shuffle data
			Random rnd = new Random();
			rnd.setSeed(System.currentTimeMillis());
	        for (int i = goodsJsonList.length() - 1; i >= 0; i--){
	          int j = rnd.nextInt(i + 1);
	          // Simple swap
	          JSONObject object = goodsJsonList.getJSONObject(j);
	          goodsJsonList.put(j, goodsJsonList.get(i));
	          goodsJsonList.put(i, object);
	        }
			
			exportJsonObject.put("goodsList", goodsJsonList);
			exportJsonObject.put("totalCnt", goodsJsonList.length());
			exportJsonObject.put("shopCode", shopCode);
			exportJsonObject.put("imgtype","2");
			
		} catch (IOException e) { //Jsoup의 connect 부분에서 IOException 오류가 날 수 있으므로 사용한다.   
		      e.printStackTrace();
		}
		
		out.println(exportJsonObject.toString());
	}
	
	//사용안함
	if(bestType.equals("5")) {
		try {
			String url = "http://www.wemakeprice.com/m/main/100020/100021";
				
				URL urlObj = new URL(url);
				HttpURLConnection conn = (HttpURLConnection) urlObj.openConnection();
				conn.setRequestMethod("GET");
				conn.setConnectTimeout(20000);
				conn.setReadTimeout(10000);
				conn.setRequestProperty("Accept-Charset", "UTF8");
				conn.addRequestProperty("Accept-Language", "en-US,en;q=0.8");
				conn.addRequestProperty("User-Agent", "Mozilla");
				conn.addRequestProperty("Referer", "google.com");
				conn.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.6) Gecko/20100625 Firefox/3.6.6");
				conn.setDoInput(true);
				conn.setDoOutput(true);

				BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF8"));
				StringBuilder sbbHtml = new StringBuilder();
				String inputLine;
				while ((inputLine = in.readLine()) != null) {
					sbbHtml.append(inputLine);
				}
				
		      //Elements contents = doc.select("div.deal_area li.lcl "); //내용 중에서 원하는 부분을 가져온다.
		      //String text = contents.text(); //원하는 부분은 Elements형태로 되어 있으므로 이를 String 형태로 바꾸어 준다.
		      //String href = contents.attr("href"); //원하는 부분은 Elements형태로 되어 있으므로 이를 String 형태로 바꾸어 준다.
		      //System.out.println("href : "+href);

				shopCode = 6508; //위메프
				
		    	//deal_list: [{"
		    	//String sb = StringUtils.substringBetween(doc.toString().trim(), "deal_list:","brand_shop_list:");
		    	StringBuilder sb =new  StringBuilder(StringUtils.substringBetween(sbbHtml.toString().trim(), "var d_l = ","var d_c_l_id = 0;"));
		    	
		    	ArrayList al =new ArrayList();
		    	JSONArray ja = new JSONArray(sb.toString());
				
				Mobile_GoodsToPricelist_Proc mobile_goodstopricelist_proc = new Mobile_GoodsToPricelist_Proc();
				
				//jsonDataMake(mobile_goodstopricelist_proc,al,shopCode);
				
				JSONObject jSONGoodsList = new JSONObject(); 
				JSONArray jSONArray = new JSONArray();
				
				int totalCnt = 0;
				
				for(int i =0 ; i < ja.length(); i++){
					//HashMap map = new HashMap();
					//map = (HashMap)al.get(i);
					//String item = StringUtils.trim((String)map.get("item"));
					//String imgSrc = StringUtils.trim((String)map.get("imgSrc"));
					//String orgPrice = ChkNull.chkStr(StringUtils.trim((String)map.get("orgPrice")),"");
					//String pcnt = ChkNull.chkStr(StringUtils.trim((String)map.get("pcnt")),"");
					//String option = StringUtils.trim((String)map.get("option"));
					
					JSONObject jo = (JSONObject)ja.get(i);
					String item = jo.getString("deal_id");
					//String imgSrc = jo.getString("deal_image_url");
					String orgPrice = jo.getString("price_expose");
					String pcnt = jo.getString("total_qty_saled");
					
					
					String option = "";
					Mobile_GoodsToPricelist_Data mgtpd = mobile_goodstopricelist_proc.getPrictListOne(shopCode, item);
					
					if(pcnt.equals("")){
						pcnt = "0";
					}
					
					if(mgtpd != null){
						
						String o_imgurl = mgtpd.getImgurl();
						String o_url = mgtpd.getUrl();
						long o_price = mgtpd.getPrice();
						String o_goodsnm = mgtpd.getGoodsnm();
						int modelno = mgtpd.getModelno();
						long plno = mgtpd.getPl_no();
                        String o_ca_code = mgtpd.getCa_code();
                        String goodscode = mgtpd.getGoodscode();
                        
                        String ca_code4 = "";
                        String ca_codeName4 = "";
                        
                        if(o_ca_code.length()>4) ca_code4 = o_ca_code.substring(0, 4);
                        else ca_code4 = o_ca_code;
                        Category_Proc category_proc = new Category_Proc();
                        ca_codeName4 = category_proc.getData_Catename(ca_code4, 2);
                        
						//String imgSrc1 = imgSrc.replaceAll("\\\\", "");
						//if(imageUrlHash.containsKey(o_goodscode)) {
						//shopImageUrl = imageUrlHash.get(o_goodscode);
						//}
						
						o_url = toUrlCode(o_url);
						
						if(o_goodsnm.indexOf("다이어트도시락") > -1) continue ;
						if(o_goodsnm.indexOf("다이어트 도시락") > -1) continue ;
						
						JSONObject jSONObject = new JSONObject(); 
						
						jSONObject.put("gd_cd",goodscode);
						jSONObject.put("gd_kn_cd","H");
						jSONObject.put("view_ord",i);
						jSONObject.put("spm_cd",shopCode);
						
						
						jSONObject.put("shopCode",shopCode);
						jSONObject.put("goodsnm",o_goodsnm);
						jSONObject.put("shopImageUrl",o_imgurl);
						jSONObject.put("url",o_url);
						jSONObject.put("pc_url", mgtpd.getUrl());
						jSONObject.put("modelno",""+modelno+"");
						jSONObject.put("ca_code4",ca_code4);
						jSONObject.put("deliveryinfo","");
						jSONObject.put("price",""+o_price+"");
						jSONObject.put("deliverytype2","");
						jSONObject.put("ca_code",o_ca_code);
						jSONObject.put("pl_no",""+plno+"");
						jSONObject.put("deliveryinfo2","");
						jSONObject.put("ca_codeName",ca_codeName4);
						//jSONObject.put("imgurl",imgSrc1);
						jSONObject.put("imgurl",o_imgurl);
						jSONObject.put("orgPrice",orgPrice);
						jSONObject.put("pcnt",pcnt);
						jSONObject.put("option",option);
						jSONObject.put("imgtype","2");
						jSONObject.put("goodscode",goodscode);
						
						if(orgPrice != ""){
							
							float f_orgPrice = Float.valueOf(orgPrice);
							float f_Price = (float)o_price;
							
							if(f_orgPrice != f_Price){
								
								int discount_rate = (int) Math.round(((f_orgPrice-f_Price)/f_orgPrice)*100);
								jSONObject.put("discount_rate",""+discount_rate+"");
								System.out.println(discount_rate);
							}
						}
						jSONArray.put(jSONObject);
						totalCnt++;
					}
				}
				jSONGoodsList.put("goodsList",jSONArray);
				jSONGoodsList.put("totalCnt",totalCnt);
				jSONGoodsList.put("imgtype","2");
				jSONGoodsList.put("shopCode",shopCode);
				out.println(jSONGoodsList.toString());
		    	      
		} catch (Exception e) { //Jsoup의 connect 부분에서 IOException 오류가 날 수 있으므로 사용한다.   
		    System.out.println(e);  
			e.printStackTrace();
		}
	}
		
	
	/**
	*	@Deprecated
	*	위메프 원더배송
	*/
	if(bestType.equals("99")) {
		
		Mobile_GoodsToPricelist_Proc proc = new Mobile_GoodsToPricelist_Proc();
		Category_Proc category_proc = new Category_Proc();
		
		JSONObject exportJsonObject = new JSONObject();
		JSONArray goodsJsonList = new JSONArray();
		int tryCnt = 0;
		try {
			
			shopCode = 6508; //위메프
			
			String[] categoryCodeArray = new String[]{
					"100020"
					/* , "100010"
					,"100000"
					, "100030" */
					};
			//String[] categoryCodeArray = new String[]{"100010"};
			
			for(String categoryCode : categoryCodeArray) {
			
				JSONObject rootObj = jsonUrlParsing("http://www.wemakeprice.com/main/get_deal_more/" + categoryCode + "?curr_deal_cnt=0&r_cnt=2000");
				//JSONObject rootObj = jsonUrlParsing("http://www.wemakeprice.com/main/get_main_best_list/1000000");
				
				if(rootObj.has("result") && rootObj.getInt("result") == 1 && rootObj.has("html")) {
					
					String html = "<html><body>" + rootObj.getString("html") + "</body></html>";
					
					Document doc = Jsoup.parse(html.trim());
					Elements elements = doc.select("li");
					
					for(Element element : elements) {
						tryCnt++;
						
						String shopImgUrl = element.select(".lazy").attr("original");
						
						String itemCode = element.attr("deal_id");
						String saleCnt = element.select(".txt_num > .point").text().trim();
						String orgPrice = element.select(".price > .prime").text().trim().replaceAll(",", "").replace("원", "");
						
						Mobile_GoodsToPricelist_Data mgtpd = proc.getPrictListOne(shopCode, itemCode);
						
						if(mgtpd != null) {
							
							if(StringUtils.isEmpty(orgPrice) || !StringUtils.isNumeric(orgPrice)) {
								orgPrice = "";
							}
							
							JSONObject exportJson = new JSONObject();
	
							String o_ca_code = mgtpd.getCa_code();
							String ca_code4 = "";
							String ca_codeName4 = "";
	
							if(o_ca_code.length()>4) ca_code4 = o_ca_code.substring(0, 4);
							else ca_code4 = o_ca_code;
							ca_codeName4 = category_proc.getData_Catename(ca_code4, 2);
							
							long salePrice = mgtpd.getPrice();
	
							exportJson.put("shopItemCode", itemCode);
							//exportJson.put("goodsnm", mgtpd.getGoodsnm().replaceAll("\\[.*?\\]", "").trim());
							exportJson.put("goodsnm", mgtpd.getGoodsnm());
							exportJson.put("goodscode", mgtpd.getGoodscode());
							exportJson.put("url", toUrlCode(mgtpd.getUrl()));
							exportJson.put("pc_url", mgtpd.getUrl());
	
							exportJson.put("imgurl", mgtpd.getImgurl());
							exportJson.put("shopImageUrl", shopImgUrl);
	
							exportJson.put("modelno", String.valueOf(mgtpd.getModelno()));
							exportJson.put("pl_no", String.valueOf(mgtpd.getPl_no()));
	
							exportJson.put("ca_code", o_ca_code);
							exportJson.put("ca_code4", ca_code4);
							exportJson.put("ca_codeName", String.valueOf(ca_codeName4));
	
							exportJson.put("price", String.valueOf(salePrice));
							//exportJson.put("discount_rate", jsonGoods.isNull("dc_rate") ? "0" : jsonGoods.get("dc_rate"));
							
							if(!StringUtils.isEmpty(orgPrice)){
								float f_orgPrice = Float.valueOf(orgPrice);
								float f_Price = (float)salePrice;
								
								if(f_orgPrice != f_Price){
									int discount_rate = (int) Math.round(((f_orgPrice-f_Price)/f_orgPrice)*100);
									
									if(discount_rate > 0)
										exportJson.put("discount_rate", String.valueOf(discount_rate));
								}
							}
							
							exportJson.put("pcnt", saleCnt);
	
							exportJson.put("deliveryinfo", mgtpd.getDeliveryinfo());
							exportJson.put("deliveryinfo2", mgtpd.getDeliveryinfo2());
							exportJson.put("deliverytype2", mgtpd.getDeliverytype2());
	
							exportJson.put("orgPrice", orgPrice);
							exportJson.put("option", "");
	
							exportJson.put("shopCode", shopCode);
							exportJson.put("imgtype","2");
	
							goodsJsonList.put(exportJson);
							
						}
					}
				}
			}
			
			//Shuffle data
			Random rnd = new Random();
			rnd.setSeed(System.currentTimeMillis());
	        for (int i = goodsJsonList.length() - 1; i >= 0; i--){
	          int j = rnd.nextInt(i + 1);
	          // Simple swap
	          JSONObject object = goodsJsonList.getJSONObject(j);
	          goodsJsonList.put(j, goodsJsonList.get(i));
	          goodsJsonList.put(i, object);
	        }
	        
			exportJsonObject.put("goodsList", goodsJsonList);
			exportJsonObject.put("totalCnt", goodsJsonList.length());
			exportJsonObject.put("shopCode", shopCode);
			//exportJsonObject.put("tryCount", tryCnt);
			exportJsonObject.put("imgtype","2");
			
			
		} catch (IOException e) { //Jsoup의 connect 부분에서 IOException 오류가 날 수 있으므로 사용한다.   
		      e.printStackTrace();
		}
		out.println(exportJsonObject.toString());
	}
%>
<%!
public JSONObject jsonUrlParsing(String strUrl) throws UnsupportedEncodingException, MalformedURLException, IOException, JSONException{

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
	    } catch (JSONException e) {
	        System.out.println("********* shopDeal3Make jsonUrlParsing **************:"+strUrl+"======"+e);
	    }
	}
	return null;
}
%>