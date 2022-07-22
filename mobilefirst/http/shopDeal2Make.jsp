<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ include file="/mobilefirst/include/urlConversion.jsp"%>
<%@ page import="com.enuri.bean.mobile.Mobile_GoodsToPricelist_Proc"%>
<%@ page import="com.enuri.bean.mobile.Mobile_GoodsToPricelist_Data"%>
<%@page import="java.util.zip.GZIPInputStream"%>
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
<%@ page import="org.apache.commons.lang3.*"%>
<%
// url
// type=1 : get
// type=2 : post
// post일 경우는 param이 필요하지만 get일경우는 그냥 url에 포함시키면됨
	String bestType = StringUtils.defaultString(request.getParameter("bestType"));
	
	int shopCode = 0;
	
	if(bestType.equals("1")) {
		
		shopCode = 6641; //티몬
		try {
			JSONObject rootObj = getTmonJSON();
			
			JSONArray dataList = rootObj.optJSONArray("data");
	
			Mobile_GoodsToPricelist_Proc proc = new Mobile_GoodsToPricelist_Proc();
			JSONObject resultObject = new JSONObject();
			JSONArray goodsList = new JSONArray();
			ArrayList<HashMap<String, String>> itemList = new ArrayList<HashMap<String, String>>();
			
			JSONArray jSONArray = new JSONArray();
			
			if (dataList != null) {
				for (int i=0; i<dataList.length(); i++) {
					
					JSONObject data = dataList.getJSONObject(i);
					JSONObject priceInfo = data.getJSONObject("priceInfo");
					JSONObject deal = data.getJSONObject("priceInfo");
					JSONObject dealMax = data.getJSONObject("dealMax");
					
					String code = data.getString("dealNo");
					//String pCnt = deal.optString("buyCount", "0").replaceAll("[^0-9]", "");
					
					String pCnt = dealMax.optString("buyCount", "0").replaceAll("[^0-9]", ""); 
					
					String orgPrice = priceInfo.optString("originalPrice", "").replaceAll("[^0-9]", "");
					String title = data.optString("titleName", "");
					String imgSrc = data.getJSONObject("imageInfo").getString("mobile3ColImageUrl");
					
					try {
						Mobile_GoodsToPricelist_Data mgtpd = proc.getPrictListOne(shopCode, code);
						if(mgtpd != null){
							
							String o_imgurl = mgtpd.getImgurl();
							String o_url = mgtpd.getUrl();
							long o_price = mgtpd.getPrice();
							String o_goodsnm = mgtpd.getGoodsnm();
							long plNo = mgtpd.getPl_no();
							int modelno = mgtpd.getModelno();
						    String o_ca_code = mgtpd.getCa_code();
	                        String goodscode = mgtpd.getGoodscode();
	                        
	                        String ca_code4 = "";
	                        String ca_codeName4 = "";
	                        
	                        if(o_ca_code.length() > 4) ca_code4 = o_ca_code.substring(0, 4);
	                        else ca_code4 = o_ca_code;
	                        Category_Proc category_proc = new Category_Proc();
	                        ca_codeName4 = category_proc.getData_Catename(ca_code4, 2);
						    
						    //모바일 수익코드
						    o_url = toUrlCode(o_url);
						    o_url = StringUtils.substringBefore(o_url, "<<<");
						    
							JSONObject jSONObject = new JSONObject();
							
							jSONObject.put("gd_cd",goodscode);
							jSONObject.put("gd_kn_cd","H");
							jSONObject.put("view_ord",i);
							jSONObject.put("spm_cd",shopCode);
							
							jSONObject.put("goodsnm",""+title+"");
							jSONObject.put("shopImageUrl",imgSrc);
							
							jSONObject.put("url",o_url);
							
							jSONObject.put("pc_url", mgtpd.getUrl());
							jSONObject.put("modelno",modelno+"");
							jSONObject.put("ca_code4",ca_code4);
							jSONObject.put("deliveryinfo","");
							jSONObject.put("price",""+o_price+"");
							jSONObject.put("deliverytype2","");
							jSONObject.put("ca_code",o_ca_code);
							jSONObject.put("pl_no",plNo+"");
							jSONObject.put("deliveryinfo2","");
							jSONObject.put("ca_codeName",ca_codeName4);
							jSONObject.put("imgurl",imgSrc);
							jSONObject.put("pcnt",pCnt);
							jSONObject.put("orgPrice",orgPrice);
							//jSONObject.put("option",option);
							jSONObject.put("imgtype","2");
							jSONObject.put("goodscode",goodscode);
							
							jSONObject.put("option", "");
							
							if(!orgPrice.equals("")){
	                            float f_orgPrice = Float.valueOf(orgPrice);
	                            float f_Price = (float)o_price;
	                            
	                            if(f_orgPrice != f_Price){
	                                int discount_rate = (int) Math.floor(((f_orgPrice-f_Price)/f_orgPrice)*100);
	                                jSONObject.put("discount_rate",""+discount_rate+"");
	                            }
	                        }
							
							try{
								jSONObject = urlConversion(jSONObject,shopCode);
								//jSONArray.put(jSONObject);
								
							}catch(Exception ex){
								System.out.println("핫딜크롤링 URL:"+ex);
							}
							
							goodsList.put(jSONObject);
							
						}
					} catch (Exception e) {
						
					}
					
				}
				
				resultObject.put("goodsList",goodsList);
				resultObject.put("totalCnt",goodsList.length());
				resultObject.put("imgtype","2");
				resultObject.put("shopCode",shopCode);
				out.println(resultObject.toString());
				
				//proc.hotDealInsUpd(jSONArray);
				
			}
		} catch (Exception e) {
			out.println(e.toString());
		}
	}

	//bestType=2 : 슈퍼딜
	if(bestType.equals("22")) {
		
		//getGmaket();
		
		try {
			
			ArrayList<HashMap> al = new ArrayList<HashMap>();
			
			String nowUrl = "https://m.gmarket.co.kr/n/superdeal";
	     	//Document doc = Jsoup.connect("https://m.gmarket.co.kr/n/superdeal").timeout(0).userAgent("Chrome").get(); //웹에서 내용을 가져온다.
	     	
	     	//getGmarketJSON(nowUrl);
	     	//getHttpsGmarketJSON(nowUrl);
	     	
	     	//Document doc = Jsoup.connect(nowUrl).timeout(0).maxBodySize(1024*1024*1).get();
	      	
	     	shopCode = 536; //지마켓
	     	//getGmaket();
	     	//jsonObjectUrlParsing("http://corners.gmarket.co.kr/SuperDeals");
	     	//jsonObjectUrlParsing("http://m.gmarket.co.kr/n/superdeal?categoryCode=400000135&categoryLevel=1");
	     	
	     	
	     	/*
			ArrayList<HashMap> al = new ArrayList<HashMap>();  
	    	
	    	Elements itemLink = doc.select("div.box__itemcard-superdeal--inner a");
	    	
			for (Element link : itemLink) {
				String linkUrl = link.attr("href");
				
				System.out.println("linkUrl :"+linkUrl);
				
				Elements imgElm = link.select("img.image");
				String imgSrc = StringUtils.defaultString(imgElm.attr("src"));
				
				Elements scriptElm = link.select("noscript");
				
				String imgSS = StringUtils.trim(StringUtils.substringBetween(scriptElm.toString(), "src=", "alt"));
				
				imgSrc = "http:"+StringUtils.replace(imgSS, "\"", "");

				Elements orgElm = link.select("del.text__price--sale strong.text__price");
                String orgPrice = StringUtils.defaultString(orgElm.text(),"");
                
                if(!orgPrice.equals("")){
                    orgPrice = orgPrice.replaceAll("[^0-9]", ""); 
                }
                
                Elements pcntElm = link.parent().select("span.text__num");         
                String pcnt = pcntElm.text();
                pcnt = pcnt.replaceAll("[^0-9]", "");
                
				String item = StringUtils.trim(StringUtils.substringAfter(linkUrl,"goodscode="));
				
				Elements freeElm = link.getElementsByClass("free");
				String ic_free = ChkNull.chkStr(freeElm.text(),"");
				Elements smartElm = link.getElementsByClass("smart");
				String ic_smart = ChkNull.chkStr(smartElm.text(),"");
				Elements hplusElm = link.getElementsByClass("hplus");
				String ic_hplus = ChkNull.chkStr(hplusElm.text(),"");
				
				Elements discntElm = link.select("span.text__price--percent");           
				String discnt = discntElm.text();
				discnt = discnt.replaceAll("[^0-9]", "");
				
				Elements delevery = link.select("span.text__addinfo");           
                String option = delevery.text();
				
				HashMap map = new HashMap(); 
				if(!item.isEmpty() && !imgSrc.isEmpty()){
					map.put("item",item);
					map.put("imgSrc",imgSrc);
					map.put("pcnt",StringUtils.defaultString(pcnt,"0"));
					map.put("orgPrice",orgPrice);
					map.put("option",option);
					map.put("discount_rate",discnt);
					//map.put("title",title);
				}
				al.add(map);
			}
			*/

			Mobile_GoodsToPricelist_Proc mobile_goodstopricelist_proc = new Mobile_GoodsToPricelist_Proc();
			
			JSONObject jSONGoodsList = new JSONObject(); 
			JSONArray jSONArray = new JSONArray();
			
			int totalCnt = 0;
			
			for(int i =0 ; i < al.size(); i++){
				HashMap map = new HashMap();
				map = (HashMap)al.get(i);
				String item = StringUtils.trim((String)map.get("item"));
				String imgSrc = StringUtils.trim((String)map.get("imgSrc"));
				String pcnt = StringUtils.trim((String)map.get("pcnt"));
				String orgPrice = StringUtils.trim((String)map.get("orgPrice"));
				//String option = StringUtils.trim((String)map.get("option"));
				String option = "";
				//String discount_rate = StringUtils.trim((String)map.get("discount_rate"));
				String title = StringUtils.trim((String)map.get("title"));
				
				Mobile_GoodsToPricelist_Data mgtpd = mobile_goodstopricelist_proc.getPrictListOne(shopCode, item);
				
				if(mgtpd != null){
					
					int o_modelno = mgtpd.getModelno();
					long o_pl_no = mgtpd.getPl_no();
					String o_ca_code = mgtpd.getCa_code();
					String o_imgurl = mgtpd.getImgurl();
					String o_url = mgtpd.getUrl();
					long o_price = mgtpd.getPrice();
					String o_goodsnm = mgtpd.getGoodsnm();
					String o_goodscode = mgtpd.getGoodscode();
					String shopImageUrl = "";
		    		String deliveryinfo = mgtpd.getDeliveryinfo();
		    		int deliveryinfo2 = mgtpd.getDeliveryinfo2();
		    		String deliverytype2 = mgtpd.getDeliverytype2();
		    		String goodscode = mgtpd.getGoodscode();
					
		    		///System.out.println("o_goodsnm:"+o_goodsnm);
		    		
					String ca_code4 = "";
	    			String ca_codeName4 = "";
					
					//중카테로 변경 2015-12-02
		    		if(o_ca_code.length()>4) ca_code4 = o_ca_code.substring(0, 4);
		    		else ca_code4 = o_ca_code;
		    		Category_Proc category_proc = new Category_Proc();
		    		ca_codeName4 = category_proc.getData_Catename(ca_code4, 2);
		    		
		    		if(ca_codeName4.equals("")){
		    			 continue;
		    		}
					//if(imageUrlHash.containsKey(o_goodscode)) {
						//shopImageUrl = imageUrlHash.get(o_goodscode);
					//}
					o_url = toUrlCode(o_url);
					
					JSONObject jSONObject = new JSONObject();
					
					jSONObject.put("gd_cd",goodscode);
					jSONObject.put("gd_kn_cd","H");
					jSONObject.put("view_ord",i);
					jSONObject.put("spm_cd",shopCode);
					
					jSONObject.put("goodsnm",o_goodsnm);
					jSONObject.put("shopImageUrl",imgSrc);
					jSONObject.put("url",o_url);
					jSONObject.put("pc_url", mgtpd.getUrl());
					jSONObject.put("modelno",""+o_modelno+"");
					jSONObject.put("ca_code4",""+ca_code4+"");
					jSONObject.put("deliveryinfo",""+deliveryinfo+"");
					jSONObject.put("price",""+o_price+"");
					jSONObject.put("deliverytype2",""+deliverytype2+"");
					jSONObject.put("ca_code",""+o_ca_code+"");
					jSONObject.put("pl_no",""+o_pl_no+"");
					jSONObject.put("deliveryinfo2",""+deliveryinfo2+"");
					jSONObject.put("ca_codeName",""+ca_codeName4+"");
					jSONObject.put("imgurl",o_imgurl);
					jSONObject.put("pcnt",pcnt);
					//jSONObject.put("orgPrice",orgPrice);
					
					if("".equals(orgPrice) ){
						jSONObject.put("orgPrice",""+o_price+"");	
					}else{
						jSONObject.put("orgPrice",""+orgPrice+"");
					}
					
					jSONObject.put("option",option);
					jSONObject.put("imgtype","2");
					//jSONObject.put("discount_rate",discount_rate);
					jSONObject.put("goodscode",goodscode);
					
					if(!orgPrice.equals("")){
                        float f_orgPrice = Float.valueOf(orgPrice);
                        float f_Price = (float)o_price;
                        
                        if(f_orgPrice != f_Price){
                            int discount_rate = (int) Math.floor(((f_orgPrice-f_Price)/f_orgPrice)*100);
                            
                            if(0 < discount_rate){
                            	jSONObject.put("discount_rate",""+discount_rate+"");	
                            }else{
                            	jSONObject.put("discount_rate","0");
                            }
                            
                        }
                    }
					
					try{
						jSONObject = urlConversion(jSONObject,shopCode);
					}catch(Exception ex){
						System.out.println("핫딜크롤링 URL:"+ex);
					}
					
					jSONArray.put(jSONObject);
					totalCnt++;
				}
			
				if(i > 200) break;
				
			}
			
			jSONGoodsList.put("goodsList",jSONArray);
			jSONGoodsList.put("totalCnt",totalCnt);
			jSONGoodsList.put("imgtype","2");
			jSONGoodsList.put("shopCode",shopCode);
			out.println(jSONGoodsList.toString());
	      
			
			
		} catch (IOException e) { //Jsoup의 connect 부분에서 IOException 오류가 날 수 있으므로 사용한다.   
		      e.printStackTrace();
		}
		
	}
	
	
	//bestType=2 : 슈퍼딜
		if(bestType.equals("2")) {
			
			//getGmaket();
			
			try {
				String nowUrl = "http://m.gmarket.co.kr/n/superdeal";
		     	//Document doc = Jsoup.connect("https://m.gmarket.co.kr/n/superdeal").timeout(0).userAgent("Chrome").get(); //웹에서 내용을 가져온다.
		     	
		     	Document doc = Jsoup.connect(nowUrl).timeout(0).userAgent("Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.21 (KHTML, like Gecko) Chrome/19.0.1042.0 Safari/535.21").get();
		      	
		     	shopCode = 536; //지마켓
				ArrayList<HashMap> al = new ArrayList<HashMap>();  

		    	Elements itemLink = doc.select("div.box__itemcard-superdeal--inner a");
		    	
				for (Element link : itemLink) {
					String linkUrl = link.attr("href");
					
					Elements imgElm = link.select("img.image");
					String imgSrc = StringUtils.defaultString(imgElm.attr("src"));
					
					Elements scriptElm = link.select("noscript");
					
					String imgSS = StringUtils.trim(StringUtils.substringBetween(scriptElm.toString(), "src=", "alt"));
					
					imgSrc = "http:"+StringUtils.replace(imgSS, "\"", "");
					
					/*
					if(StringUtils.contains(imgSrc, "superdeal_loading.png") ){
						imgSrc = imgElm.attr("data-original"); //lazy 로드 때문에 src 이미지가 아닌 data-original 를 사용 한다
					}
					*/
					
					/*
	                Elements orgElm = link.select("del.price2");
	                String orgPrice = StringUtils.defaultString(orgElm.text(),"");
	                
	                if(!orgPrice.equals("")){
	                    orgPrice = orgPrice.replaceAll("[^0-9]", ""); 
	                }
	                */
					Elements orgElm = link.select("del.text__price--sale strong.text__price");
	                String orgPrice = StringUtils.defaultString(orgElm.text(),"");
	                
	                if(!orgPrice.equals("")){
	                    orgPrice = orgPrice.replaceAll("[^0-9]", ""); 
	                }
	                
	                /*
	                Elements pcntElm = link.parent().select("span.num");                
	                String pcnt = pcntElm.text();
	                pcnt = pcnt.replaceAll("[^0-9]", "");
	                */
	                
	                Elements pcntElm = link.parent().select("span.text__num");         
	                String pcnt = pcntElm.text();
	                pcnt = pcnt.replaceAll("[^0-9]", "");
	                
					String item = StringUtils.trim(StringUtils.substringAfter(linkUrl,"goodscode="));
					
					Elements freeElm = link.getElementsByClass("free");
					String ic_free = ChkNull.chkStr(freeElm.text(),"");
					Elements smartElm = link.getElementsByClass("smart");
					String ic_smart = ChkNull.chkStr(smartElm.text(),"");
					Elements hplusElm = link.getElementsByClass("hplus");
					String ic_hplus = ChkNull.chkStr(hplusElm.text(),"");
					
					/*
					Elements discntElm = link.select("span.sale");           
					String discnt = discntElm.text();
					discnt = discnt.replaceAll("[^0-9]", "");
					*/
					
					Elements discntElm = link.select("span.text__price--percent");           
					String discnt = discntElm.text();
					discnt = discnt.replaceAll("[^0-9]", "");
					
					
					/*
					String option = "";
					if(ic_free != ""){
						option += ic_free;
					}
					if(option != "" && ic_smart != ""){
						option += ",";
					}
					if(ic_smart != ""){
						option += ic_smart;
					}
					if(option != "" && ic_hplus != ""){
						option += ",";
					}
					if(ic_hplus != ""){
						option += ic_hplus;
					}
					*/
					
					Elements delevery = link.select("span.text__addinfo");           
	                String option = delevery.text();
					
					
					HashMap map = new HashMap(); 
					if(!item.isEmpty() && !imgSrc.isEmpty()){
						map.put("item",item);
						map.put("imgSrc",imgSrc);
						map.put("pcnt",StringUtils.defaultString(pcnt,"0"));
						map.put("orgPrice",orgPrice);
						map.put("option",option);
						map.put("discount_rate",discnt);
						//map.put("title",title);
					}
					al.add(map);
				}

				Mobile_GoodsToPricelist_Proc mobile_goodstopricelist_proc = new Mobile_GoodsToPricelist_Proc();
				
				JSONObject jSONGoodsList = new JSONObject(); 
				JSONArray jSONArray = new JSONArray();
				
				int totalCnt = 0;
				
				for(int i =0 ; i < al.size(); i++){
					HashMap map = new HashMap();
					map = (HashMap)al.get(i);
					String item = StringUtils.trim((String)map.get("item"));
					String imgSrc = StringUtils.trim((String)map.get("imgSrc"));
					String pcnt = StringUtils.trim((String)map.get("pcnt"));
					String orgPrice = StringUtils.trim((String)map.get("orgPrice"));
					//String option = StringUtils.trim((String)map.get("option"));
					String option = "";
					//String discount_rate = StringUtils.trim((String)map.get("discount_rate"));
					String title = StringUtils.trim((String)map.get("title"));
					
					Mobile_GoodsToPricelist_Data mgtpd = mobile_goodstopricelist_proc.getPrictListOne(shopCode, item);
					
					if(mgtpd != null){
						
						int o_modelno = mgtpd.getModelno();
						long o_pl_no = mgtpd.getPl_no();
						String o_ca_code = mgtpd.getCa_code();
						String o_imgurl = mgtpd.getImgurl();
						String o_url = mgtpd.getUrl();
						long o_price = mgtpd.getPrice();
						String o_goodsnm = mgtpd.getGoodsnm();
						String o_goodscode = mgtpd.getGoodscode();
						String shopImageUrl = "";
			    		String deliveryinfo = mgtpd.getDeliveryinfo();
			    		int deliveryinfo2 = mgtpd.getDeliveryinfo2();
			    		String deliverytype2 = mgtpd.getDeliverytype2();
			    		String goodscode = mgtpd.getGoodscode();
						
			    		///System.out.println("o_goodsnm:"+o_goodsnm);
			    		
						String ca_code4 = "";
		    			String ca_codeName4 = "";
						
						//중카테로 변경 2015-12-02
			    		if(o_ca_code.length()>4) ca_code4 = o_ca_code.substring(0, 4);
			    		else ca_code4 = o_ca_code;
			    		Category_Proc category_proc = new Category_Proc();
			    		ca_codeName4 = category_proc.getData_Catename(ca_code4, 2);
			    		
			    		if(ca_codeName4.equals("")){
			    			 continue;
			    		}
						//if(imageUrlHash.containsKey(o_goodscode)) {
							//shopImageUrl = imageUrlHash.get(o_goodscode);
						//}
						o_url = toUrlCode(o_url);
						
						JSONObject jSONObject = new JSONObject();
						
						jSONObject.put("gd_cd",goodscode);
						jSONObject.put("gd_kn_cd","H");
						jSONObject.put("view_ord",i);
						jSONObject.put("spm_cd",shopCode);
						
						jSONObject.put("goodsnm",o_goodsnm);
						jSONObject.put("shopImageUrl",imgSrc);
						jSONObject.put("url",o_url);
						jSONObject.put("pc_url", mgtpd.getUrl());
						jSONObject.put("modelno",""+o_modelno+"");
						jSONObject.put("ca_code4",""+ca_code4+"");
						jSONObject.put("deliveryinfo",""+deliveryinfo+"");
						jSONObject.put("price",""+o_price+"");
						jSONObject.put("deliverytype2",""+deliverytype2+"");
						jSONObject.put("ca_code",""+o_ca_code+"");
						jSONObject.put("pl_no",""+o_pl_no+"");
						jSONObject.put("deliveryinfo2",""+deliveryinfo2+"");
						jSONObject.put("ca_codeName",""+ca_codeName4+"");
						jSONObject.put("imgurl",o_imgurl);
						jSONObject.put("pcnt",pcnt);
						//jSONObject.put("orgPrice",orgPrice);
						
						if("".equals(orgPrice) ){
							jSONObject.put("orgPrice",""+o_price+"");	
						}else{
							jSONObject.put("orgPrice",""+orgPrice+"");
						}
						
						jSONObject.put("option",option);
						jSONObject.put("imgtype","2");
						//jSONObject.put("discount_rate",discount_rate);
						jSONObject.put("goodscode",goodscode);
						
						if(!orgPrice.equals("")){
	                        float f_orgPrice = Float.valueOf(orgPrice);
	                        float f_Price = (float)o_price;
	                        
	                        if(f_orgPrice != f_Price){
	                            int discount_rate = (int) Math.floor(((f_orgPrice-f_Price)/f_orgPrice)*100);
	                            
	                            if(0 < discount_rate){
	                            	jSONObject.put("discount_rate",""+discount_rate+"");	
	                            }else{
	                            	jSONObject.put("discount_rate","0");
	                            }
	                            
	                        }
	                    }
						
						try{
							jSONObject = urlConversion(jSONObject,shopCode);
						}catch(Exception ex){
							System.out.println("핫딜크롤링 URL:"+ex);
						}
						
						jSONArray.put(jSONObject);
						totalCnt++;
					}
				
					if(i > 200) break;
					
				}
				
				jSONGoodsList.put("goodsList",jSONArray);
				jSONGoodsList.put("totalCnt",totalCnt);
				jSONGoodsList.put("imgtype","2");
				jSONGoodsList.put("shopCode",shopCode);
				out.println(jSONGoodsList.toString());
		      
				
				
			} catch (IOException e) { //Jsoup의 connect 부분에서 IOException 오류가 날 수 있으므로 사용한다.   
			      e.printStackTrace();
			}
			
		}
		
	
	
	//bestType=4 : 옥션
	if(bestType.equals("4")) {
		
		JSONArray jsonArray = jsonUrlParsing("http://mobile.auction.co.kr/ajax/Arche.MobileWeb.Home.AllKillRecommendSlide,Arche.MobileWeb.Web.ashx?_method=GetAllKillRecommendInfo&_session=no");
    	
    	try {
				shopCode = 4027; //
				
				ArrayList<HashMap> al = new ArrayList<HashMap>();  
				JSONObject jSONObjectTemp = new JSONObject();
		    	
		    	for (int i=0;i< jsonArray.length();i++) {
		    		
		    		jSONObjectTemp = (JSONObject)jsonArray.get(i);
		    		if(!jSONObjectTemp.isNull("Item")){
			    		
						String item = (String)((JSONObject)jSONObjectTemp.get("Item")).get("ItemNo");
						String imgSrc = (String)((JSONObject)jSONObjectTemp.get("Item")).get("ItemImageUrl");
						String SellPrice = (String)((JSONObject)jSONObjectTemp.get("Item")).get("SellPrice");
						String payCount = (String)((JSONObject)jSONObjectTemp.get("Item")).get("PayCount");
						String ServiceText = (String)((JSONObject)jSONObjectTemp.get("Item")).get("ServiceText");
						
						if(!SellPrice.equals("")){
		                    SellPrice = SellPrice.replaceAll("[^0-9]", ""); 
		                }
						
						if(!payCount.equals("")){
                            payCount = payCount.replaceAll("[^0-9]", ""); 
                        }
						
						HashMap map = new HashMap(); 
						map.put("item",item);
						map.put("imgSrc",imgSrc);
						map.put("orgPrice",SellPrice);
						map.put("pcnt",StringUtils.defaultString(payCount,"0"));
						map.put("title",ServiceText);
						
						al.add(map);
		    		}
				}
				
				Mobile_GoodsToPricelist_Proc mobile_goodstopricelist_proc = new Mobile_GoodsToPricelist_Proc();
				
				JSONObject jSONGoodsList = new JSONObject(); 
				JSONArray jSONArray = new JSONArray();
				
				int totalCnt = 0;
				
				for(int i =0 ; i < al.size(); i++){
					HashMap map = new HashMap();
					map = (HashMap)al.get(i);
					String item = StringUtils.trim((String)map.get("item"));
					String imgSrc = StringUtils.trim((String)map.get("imgSrc"));
					String orgPrice = StringUtils.trim((String)map.get("orgPrice"));
					String pcnt = StringUtils.trim((String)map.get("pcnt"));
					String title = StringUtils.trim((String)map.get("title"));
					
					Mobile_GoodsToPricelist_Data mgtpd = mobile_goodstopricelist_proc.getPrictListOne(shopCode, item);
					
					if(mgtpd != null){
						
						int o_modelno = mgtpd.getModelno();
						
						if(o_modelno == 41541478){
							continue;
						}
						
						long o_pl_no = mgtpd.getPl_no();
						String o_ca_code = mgtpd.getCa_code();
						String o_imgurl = mgtpd.getImgurl();
						String o_url = mgtpd.getUrl();
						long o_price = mgtpd.getPrice();
						String o_goodsnm = mgtpd.getGoodsnm();
						String o_goodscode = mgtpd.getGoodscode();
						String shopImageUrl = "";
			    		String deliveryinfo = mgtpd.getDeliveryinfo();
			    		int deliveryinfo2 = mgtpd.getDeliveryinfo2();
			    		String deliverytype2 = mgtpd.getDeliverytype2();
						String goodscode = mgtpd.getGoodscode();
						
						String ca_code4 = "";
		    			String ca_codeName4 = "";
						
						//중카테로 변경 2015-12-02
			    		if(o_ca_code.length()>4) ca_code4 = o_ca_code.substring(0, 4);
			    		else ca_code4 = o_ca_code;
			    		Category_Proc category_proc = new Category_Proc();
			    		ca_codeName4 = category_proc.getData_Catename(ca_code4, 2);
			    		
			    		if(ca_codeName4.equals("")){
			    			 continue;
			    		}
			    		
						//if(imageUrlHash.containsKey(o_goodscode)) {
							//shopImageUrl = imageUrlHash.get(o_goodscode);
						//}
						o_url = toUrlCode(o_url);
						imgSrc = toUrlCode(imgSrc);
						
						JSONObject jSONObject = new JSONObject(); 
						
						jSONObject.put("gd_cd",goodscode);
						jSONObject.put("gd_kn_cd","H");
						jSONObject.put("view_ord",i);
						jSONObject.put("spm_cd",shopCode);
						
						jSONObject.put("goodsnm",""+title+"");
						jSONObject.put("shopImageUrl",imgSrc);
						jSONObject.put("url",""+o_url+"");
						jSONObject.put("pc_url", mgtpd.getUrl());
						jSONObject.put("modelno",""+o_modelno+"");
						jSONObject.put("ca_code4",""+ca_code4+"");
						jSONObject.put("deliveryinfo",""+deliveryinfo+"");
						jSONObject.put("price",""+o_price+"");
						jSONObject.put("deliverytype2",""+deliverytype2+"");
						jSONObject.put("ca_code",""+o_ca_code+"");
						jSONObject.put("pl_no",""+o_pl_no+"");
						jSONObject.put("deliveryinfo2",""+deliveryinfo2+"");
						jSONObject.put("ca_codeName",""+ca_codeName4+"");
						jSONObject.put("imgurl",o_imgurl);
						jSONObject.put("orgPrice",orgPrice);
						jSONObject.put("pcnt",pcnt);
						jSONObject.put("option","");
						jSONObject.put("imgtype","1");
						jSONObject.put("goodscode",goodscode);
						
						if(!orgPrice.equals("")){
	                        float f_orgPrice = Float.valueOf(orgPrice);
	                        float f_Price = (float)o_price;
	                        
	                        if(f_orgPrice != f_Price){
	                            int discount_rate = (int) Math.floor(((f_orgPrice-f_Price)/f_orgPrice)*100);
	                            
	                            if(0 < discount_rate)	jSONObject.put("discount_rate",""+discount_rate+"");	
	                            else                   	jSONObject.put("discount_rate","0");
	                        }
                        }
						jSONObject = urlConversion(jSONObject,shopCode);
						jSONArray.put(jSONObject);
						
						totalCnt++;
					}
				}
				
				jSONGoodsList.put("goodsList",jSONArray);
				jSONGoodsList.put("totalCnt",totalCnt);
				jSONGoodsList.put("imgtype","1");
				jSONGoodsList.put("shopCode",shopCode);
				
				out.println(jSONGoodsList.toString());
		    	   
		} catch (IOException e) { //Jsoup의 connect 부분에서 IOException 오류가 날 수 있으므로 사용한다.   
		      e.printStackTrace();
		}
		
	}
	//11st
	if(bestType.equals("temp")) {
		int a =1;
		try {
		       shopCode = 5910; //11st
		      
		       Document doc = Jsoup.connect("http://m.11st.co.kr/MW/Shockingdeal/main.html").get(); //웹에서 내용을 가져온다.
		       //Elements contents = doc.select("div.deal_area li.lcl "); //내용 중에서 원하는 부분을 가져온다.
		       //String text = contents.text(); //원하는 부분은 Elements형태로 되어 있으므로 이를 String 형태로 바꾸어 준다.
		       //String href = contents.attr("href"); //원하는 부분은 Elements형태로 되어 있으므로 이를 String 형태로 바꾸어 준다.
				
				ArrayList al = new ArrayList();
				ArrayList alMov = new ArrayList();
				
		    	Elements itemLink = doc.select("div ul.list_skdcard a");

				for (Element link : itemLink) {
					String linkUrl = link.attr("href");
					Elements imgElm = link.select("img");
					String imgSrc = imgElm.attr("src");
                    Elements buyElm = link.select("div.buy");
                    
                    String pcnt = StringUtils.defaultString(buyElm.text(),"0");
                    
		            if(!pcnt.equals("")){
		                pcnt = pcnt.replaceAll("[^0-9]", ""); 
		            }
					String item = StringUtils.trim(StringUtils.substringBetween(linkUrl,"prdNo=","&trTypeCd=MW003"));

                    Elements delElm = link.select("del");
                    String orgPrice = StringUtils.defaultString(delElm.text(),"");
                    
                    if(!orgPrice.equals("")){
                        orgPrice = getOnlyNumberString(orgPrice);
                    }
                    
                    String option = "";
                    Elements bfElm = link.getElementsByClass("bf");
    				String ic_bf = ChkNull.chkStr(bfElm.text(),"");
    				if(StringUtils.trim(StringUtils.substring(ic_bf, 0, 4)).equals("무료배송")){
    					ic_bf = StringUtils.replace(ic_bf, StringUtils.substringBetween(ic_bf,"송","맘"), ",내");
    				}
    				
    				Elements titleElm = link.select("span.name");
    				String title = titleElm.text();
    				
					HashMap map = new HashMap(); 
					map.put("item",item);
					map.put("imgSrc",imgSrc);
					map.put("orgPrice",orgPrice);
					map.put("pcnt",StringUtils.defaultString(pcnt,"0"));
					map.put("imgtype","1");
					map.put("option", ic_bf);
					map.put("title", title);
					
					Elements em = link.select(".mov");
					String movLink = StringUtils.defaultString(em.attr("data-movie"));
					
					if(!movLink.equals("")){
						JSONObject jo = new JSONObject (movLink);
						
						String prdNo = (String)jo.getString("prdNo");
						String prdNm = (String)jo.getString("prdNm");
						map.put("item",prdNo);
						map.put("title",prdNm);
						
						JSONObject movObj = (JSONObject)jo.getJSONObject("movie");
						JSONObject amovObj = (JSONObject)movObj.getJSONObject("aMovies");
						JSONObject imovObj = (JSONObject)movObj.getJSONObject("iMovies");
						
						map.put("amov", amovObj.getString("HQ"));
						map.put("imov", imovObj.getString("HQ"));
						alMov.add(map);
					}else{
						al.add(map);	
					}
				}
				ArrayList alUrl = new ArrayList();
               //패션
               alUrl.add("http://m.11st.co.kr/MW/Shockingdeal/categoryProductList.tmall?dispCtgrNo=947157&dispCtgrLevel=1&lDispCtgrNo=947157&pageSize=60");
               alUrl.add("http://m.11st.co.kr/MW/Shockingdeal/categoryProductList.tmall?dispCtgrNo=947158&dispCtgrLevel=1&lDispCtgrNo=947158&pageSize=60");
               alUrl.add("http://m.11st.co.kr/MW/Shockingdeal/categoryProductList.tmall?dispCtgrNo=947159&dispCtgrLevel=1&lDispCtgrNo=947159&pageSize=60");
               alUrl.add("http://m.11st.co.kr/MW/Shockingdeal/categoryProductList.tmall?dispCtgrNo=947160&dispCtgrLevel=1&lDispCtgrNo=947160&pageSize=60");
               alUrl.add("http://m.11st.co.kr/MW/Shockingdeal/categoryProductList.tmall?dispCtgrNo=947161&dispCtgrLevel=1&lDispCtgrNo=947161&pageSize=60");
               alUrl.add("http://m.11st.co.kr/MW/Shockingdeal/categoryProductList.tmall?dispCtgrNo=947162&dispCtgrLevel=1&lDispCtgrNo=947162&pageSize=60");
               alUrl.add("http://m.11st.co.kr/MW/Shockingdeal/categoryProductList.tmall?dispCtgrNo=947163&dispCtgrLevel=1&lDispCtgrNo=947163&pageSize=60");
               alUrl.add("http://m.11st.co.kr/MW/Shockingdeal/categoryProductList.tmall?dispCtgrNo=947167&dispCtgrLevel=1&lDispCtgrNo=947167&pageSize=60");
               alUrl.add("http://m.11st.co.kr/MW/Shockingdeal/categoryProductList.tmall?dispCtgrNo=947164&dispCtgrLevel=1&lDispCtgrNo=947164&pageSize=60");
               alUrl.add("http://m.11st.co.kr/MW/Shockingdeal/categoryProductList.tmall?dispCtgrNo=947165&dispCtgrLevel=1&lDispCtgrNo=947165&pageSize=60");
               alUrl.add("http://m.11st.co.kr/MW/Shockingdeal/categoryProductList.tmall?dispCtgrNo=947166&dispCtgrLevel=1&lDispCtgrNo=947166&pageSize=60");
               alUrl.add("http://m.11st.co.kr/MW/Shockingdeal/categoryProductList.tmall?dispCtgrNo=947168&dispCtgrLevel=1&lDispCtgrNo=947168&pageSize=60");
               alUrl.add("http://m.11st.co.kr/MW/Shockingdeal/categoryProductList.tmall?dispCtgrNo=952153&dispCtgrLevel=1&lDispCtgrNo=952153&pageSize=60");
               alUrl.add("http://m.11st.co.kr/MW/Shockingdeal/categoryProductList.tmall?dispCtgrNo=947169&dispCtgrLevel=1&lDispCtgrNo=947169&pageSize=60");
               alUrl.add("http://m.11st.co.kr/MW/Shockingdeal/categoryProductList.tmall?dispCtgrNo=952351&dispCtgrLevel=1&lDispCtgrNo=952351&pageSize=60");
               
               ArrayList alTemp = new ArrayList(); 
               
               for(int i = 0 ; i < alUrl.size(); i++){
                   
	               InputStream input = new URL((String)alUrl.get(i)).openStream();
	               Document docFirst = Jsoup.parse(input, "euc-kr", (String)alUrl.get(i));
	               Elements itemLink3 = docFirst.select("div ul.list_skdcard a");

	               for (Element link : itemLink3) {
	                    String linkUrl = link.attr("href");
	                    Elements imgElm = link.select("img");
	                    String imgSrc = imgElm.attr("src");
	                    Elements buyElm = link.select("div.buy");
	                    
	                    String pcnt = StringUtils.defaultString(buyElm.text(),"0");
	                    
	                    if(!pcnt.equals("")){
	                        pcnt = pcnt.replaceAll("[^0-9]", ""); 
	                    }
	                    String item = StringUtils.trim(StringUtils.substringBetween(linkUrl,"prdNo=","&trTypeCd="));
	                    
	                    Elements delElm = link.select("del");
	                    String orgPrice = StringUtils.defaultString(delElm.text(),"");
	                    
	                    if(!orgPrice.equals("")){
	                        orgPrice = getOnlyNumberString(orgPrice);
	                    }
	                    
	                    String option = "";
	                    Elements bfElm = link.select("span.bf");
	                    //String ic_bf = new String(bfElm.text().getBytes("8859_1"), "utf-8");
	                    String ic_bf = bfElm.text();
	                    
	                    if(StringUtils.trim(StringUtils.substring(ic_bf, 0, 4)).equals("무료배송")){
	                        ic_bf = StringUtils.replace(ic_bf, StringUtils.substringBetween(ic_bf,"송","맘"), ",내");
	                    }
	                    
	                    Elements titleElm = link.select("span.name");
                        String title = titleElm.text();

        				Elements em = link.select(".mov");
    					String movLink = StringUtils.defaultString(em.attr("data-movie"));
						
	                    HashMap map = new HashMap(); 
	                    map.put("item",item);
	                    map.put("imgSrc",imgSrc);
	                    map.put("orgPrice",orgPrice);
	                    map.put("pcnt",StringUtils.defaultString(pcnt,"0"));
	                    map.put("imgtype","1");
	                    map.put("option", ic_bf);
	                    map.put("title", title);
	                    
	                    if(!movLink.equals("")){
    						JSONObject jo = new JSONObject (movLink);
    						
    						String prdNo = (String)jo.getString("prdNo");
    						String prdNm = (String)jo.getString("prdNm");
    						map.put("item",prdNo);
    						map.put("title",prdNm);
    						
    						JSONObject movObj = (JSONObject)jo.getJSONObject("movie");
    						JSONObject amovObj = (JSONObject)movObj.getJSONObject("aMovies");
    						JSONObject imovObj = (JSONObject)movObj.getJSONObject("iMovies");
    						
    						map.put("amov", amovObj.getString("HQ"));
    						map.put("imov", imovObj.getString("HQ"));
    						alMov.add(map);	
    					}else{
    						alTemp.add(map);	
    					}
	                }
				}
				Collections.shuffle(alTemp);
				
				for(int i=0 ; i < alTemp.size() ; i++){
				    al.add(alTemp.get(i));
				}
				
				for(int i=0 ; i < alMov.size() ; i++){
				    HashMap map = (HashMap)alMov.get(i);
				    String item = (String)map.get("item");
				    String amov = (String)map.get("amov");
				    String imov = (String)map.get("imov");
				    
				    for(int j=0 ; j < al.size() ; j++){
				    	
				    	HashMap mapTemp = (HashMap)al.get(j);
				    	String tempItem = (String)mapTemp.get("item");
				    	
				    	if(item.equals(tempItem)){
				    		mapTemp.put("amov",amov);
				    		mapTemp.put("imov",imov);
				    		al.set(j,mapTemp);
					    }
					}
				}
				
				Mobile_GoodsToPricelist_Proc mobile_goodstopricelist_proc = new Mobile_GoodsToPricelist_Proc();
				
				JSONObject jSONGoodsList = new JSONObject(); 
				JSONArray jSONArray = new JSONArray();
				
				int totalCnt = 0;
				
				for(int i =0 ; i < al.size(); i++){
					HashMap map = new HashMap();
					map = (HashMap)al.get(i);
					String item = StringUtils.trim((String)map.get("item"));
					String imgSrc = StringUtils.trim((String)map.get("imgSrc"));
					String orgPrice = StringUtils.trim((String)map.get("orgPrice"));
					String pcnt = StringUtils.trim((String)map.get("pcnt"));
					String imgtype = StringUtils.trim((String)map.get("imgtype"));
					//String option = StringUtils.trim((String)map.get("option"));
					String option = "";
					String title = StringUtils.trim((String)map.get("title"));
					String amov = StringUtils.trim(StringUtils.defaultString((String)map.get("amov")));
					String imov = StringUtils.trim(StringUtils.defaultString((String)map.get("imov")));
                    
					Mobile_GoodsToPricelist_Data mgtpd = mobile_goodstopricelist_proc.getPrictListOne(shopCode, item);
					
					if(mgtpd != null){
						
						String o_imgurl = mgtpd.getImgurl();
						String o_url = mgtpd.getUrl();
						long o_price = mgtpd.getPrice();
						String o_goodsnm = mgtpd.getGoodsnm();
						int modelno = mgtpd.getModelno();
						long plNo = mgtpd.getPl_no();
						String o_ca_code = mgtpd.getCa_code();
						String goodscode = mgtpd.getGoodscode();
						
						String ca_code4 = "";
						String ca_codeName4 = "";
						
						if(o_ca_code.length()>4) ca_code4 = o_ca_code.substring(0, 4);
	                    else ca_code4 = o_ca_code;
	                    Category_Proc category_proc = new Category_Proc();
	                    ca_codeName4 = category_proc.getData_Catename(ca_code4, 2);
						
						//if(imageUrlHash.containsKey(o_goodscode)) {
						//shopImageUrl = imageUrlHash.get(o_goodscode);
						//}
						o_url = toUrlCode(o_url);
						JSONObject jSONObject = new JSONObject(); 
						
						jSONObject.put("gd_cd",goodscode);
						jSONObject.put("gd_kn_cd","H");
						jSONObject.put("view_ord",i);
						jSONObject.put("spm_cd",shopCode);
						
						jSONObject.put("goodsnm",""+title+"");
						jSONObject.put("shopImageUrl",imgSrc);
						jSONObject.put("url",o_url);
						jSONObject.put("pc_url", mgtpd.getUrl());
						jSONObject.put("modelno",""+modelno+"");
						jSONObject.put("ca_code4","");
						jSONObject.put("deliveryinfo","");
						jSONObject.put("price",""+o_price+"");
						jSONObject.put("deliverytype2","");
						jSONObject.put("ca_code",o_ca_code);
						jSONObject.put("pl_no",""+plNo+"");
						jSONObject.put("deliveryinfo2","");
						jSONObject.put("ca_codeName",ca_codeName4);
						jSONObject.put("imgurl",o_imgurl);
						jSONObject.put("pcnt",pcnt);
						jSONObject.put("orgPrice",orgPrice);
						jSONObject.put("imgtype",imgtype);
						jSONObject.put("option",option);
						jSONObject.put("imgtype","1");
						jSONObject.put("goodscode",goodscode);
						
						if(!amov.equals("")){
							jSONObject.put("amov",imov);	
						}
						if(!imov.equals("")){
							jSONObject.put("imov",imov);	
						}
						if(!amov.equals("")){//웹용
							jSONObject.put("wmov",amov);	
						}
						
                        if(!orgPrice.equals("")){
                            float f_orgPrice = Float.valueOf(orgPrice);
                            float f_Price = (float)o_price;
                            
                            if(f_orgPrice != f_Price){
                                int discount_rate = (int) Math.floor(((f_orgPrice-f_Price)/f_orgPrice)*100);
                                if(discount_rate > 0){
                                	jSONObject.put("discount_rate",""+discount_rate+"");	
                                }else{
                                	continue;	
                                }
                                
                            }
                        }
                        jSONObject = urlConversion(jSONObject,shopCode);
						jSONArray.put(jSONObject);
						totalCnt++;
					}
				}
				jSONGoodsList.put("goodsList",jSONArray);
				jSONGoodsList.put("totalCnt",totalCnt);
				jSONGoodsList.put("imgtype","1");
				jSONGoodsList.put("shopCode",shopCode);
				out.println(jSONGoodsList.toString());
		      
		} catch (IOException e) { //Jsoup의 connect 부분에서 IOException 오류가 날 수 있으므로 사용한다.   
		      e.printStackTrace();
		}
	}
%>
<%
//11st
	if(bestType.equals("5")) {
		int a =1;
		try {
		       shopCode = 5910; //11st
		      
		       //Document doc = Jsoup.connect("http://m.11st.co.kr/MW/html/main.html#/home").get(); //웹에서 내용을 가져온다.
		       //Elements contents = doc.select("div.deal_area li.lcl "); //내용 중에서 원하는 부분을 가져온다.
		       //String text = contents.text(); //원하는 부분은 Elements형태로 되어 있으므로 이를 String 형태로 바꾸어 준다.
		       //String href = contents.attr("href"); //원하는 부분은 Elements형태로 되어 있으므로 이를 String 형태로 바꾸어 준다.
				
		       String url = "http://deal.11st.co.kr/html/nc/deal/main.html";
		       
		       ///InputStream input = new URL(url).openStream();
	           //Document doc = Jsoup.parse(input, "euc-kr", url);
		       
				ArrayList al = new ArrayList();
				ArrayList alMov = new ArrayList();
				
				//viewtype3 list_htype2 ui_templateContent
				//viewtype3 list_htype2 ui_templateContent
				
		    	//Elements itemLink = doc.select("div > ul > li");
		    	JSONObject dealBest = jsonUrl11stParsing(url);
		    	
		    	JSONObject jsonObj = dealBest.getJSONObject("dealBest");
		    	JSONArray jsonArr = jsonObj.getJSONArray("items");
		    	
				Mobile_GoodsToPricelist_Proc mobile_goodstopricelist_proc = new Mobile_GoodsToPricelist_Proc();
				
				JSONObject jSONGoodsList = new JSONObject(); 
				JSONArray jSONArray = new JSONArray();
				
				int totalCnt = 0;
				
				for(int i =0 ; i < jsonArr.length(); i++){
					
					JSONObject obj = jsonArr.getJSONObject(i);
					
					/*
					String item = StringUtils.trim((String)map.get("item"));
					String imgSrc = StringUtils.trim((String)map.get("imgSrc"));
					String orgPrice = StringUtils.trim((String)map.get("orgPrice"));
					String pcnt = StringUtils.trim((String)map.get("pcnt"));
					String imgtype = StringUtils.trim((String)map.get("imgtype"));
					//String option = StringUtils.trim((String)map.get("option"));
					String option = "";
					String title = StringUtils.trim((String)map.get("title"));
					String amov = StringUtils.trim(StringUtils.defaultString((String)map.get("amov")));
					String imov = StringUtils.trim(StringUtils.defaultString((String)map.get("imov")));
					*/
					
					//JSONObject logBody = obj.getJSONObject("logBody");
					//String content_no = logBody.getString("content_no");
					String prdNo = obj.getString("prdNo");
					String imgSrc = obj.getString("prdImgUrl");
					String orgPrice = StringUtils.replace(obj.getString("selPrc"), ",", "") ;
					String pcnt = StringUtils.replace(obj.getString("cmltSelQty"), ",", "") ;
					
					String imgtype = "2";
					//String option = StringUtils.trim((String)map.get("option"));
					String option = "";
					String title = obj.getString("prdNm");;
					String amov = "";
					String imov = "";
                    
					Mobile_GoodsToPricelist_Data mgtpd = mobile_goodstopricelist_proc.getPrictListOne(shopCode, prdNo);
					
					if(mgtpd != null){
						
						String o_imgurl = mgtpd.getImgurl();
						String o_url = mgtpd.getUrl();
						long o_price = mgtpd.getPrice();
						String o_goodsnm = mgtpd.getGoodsnm();
						int modelno = mgtpd.getModelno();
						long plNo = mgtpd.getPl_no();
						String o_ca_code = mgtpd.getCa_code();
						String goodscode = mgtpd.getGoodscode();
						
						String ca_code4 = "";
						String ca_codeName4 = "";
						
						if(o_ca_code.length()>4) ca_code4 = o_ca_code.substring(0, 4);
	                    else ca_code4 = o_ca_code;
	                    Category_Proc category_proc = new Category_Proc();
	                    ca_codeName4 = category_proc.getData_Catename(ca_code4, 2);
						
						//if(imageUrlHash.containsKey(o_goodscode)) {
						//shopImageUrl = imageUrlHash.get(o_goodscode);
						//}
						o_url = toUrlCode(o_url);
						JSONObject jSONObject = new JSONObject(); 
						
						jSONObject.put("gd_cd",goodscode);
						jSONObject.put("gd_kn_cd","H");
						jSONObject.put("view_ord",i);
						jSONObject.put("spm_cd",shopCode);
								
						jSONObject.put("goodsnm",""+title+"");
						//jSONObject.put("shopImageUrl",imgSrc);
						jSONObject.put("shopImageUrl",o_imgurl);
						jSONObject.put("url",o_url);
						jSONObject.put("pc_url", mgtpd.getUrl());
						jSONObject.put("modelno",""+modelno+"");
						jSONObject.put("ca_code4","");
						jSONObject.put("deliveryinfo","");
						jSONObject.put("price",""+o_price+"");
						jSONObject.put("deliverytype2","");
						jSONObject.put("ca_code",o_ca_code);
						jSONObject.put("pl_no",""+plNo+"");
						jSONObject.put("deliveryinfo2","");
						jSONObject.put("ca_codeName",ca_codeName4);
						jSONObject.put("imgurl",o_imgurl);
						jSONObject.put("pcnt",pcnt);
						jSONObject.put("orgPrice",orgPrice);
						jSONObject.put("imgtype",imgtype);
						jSONObject.put("option",option);
						jSONObject.put("imgtype","2");
						jSONObject.put("goodscode",goodscode);
						
						if(!amov.equals("")){
							jSONObject.put("amov",imov);	
						}
						if(!imov.equals("")){
							jSONObject.put("imov",imov);	
						}
						if(!amov.equals("")){//웹용
							jSONObject.put("wmov",amov);	
						}
						
                        if(!orgPrice.equals("")){
                            float f_orgPrice = Float.valueOf(orgPrice);
                            float f_Price = (float)o_price;
                            
                            if(f_orgPrice != f_Price){
                                int discount_rate = (int) Math.floor(((f_orgPrice-f_Price)/f_orgPrice)*100);
                                if(discount_rate > 0){
                                	jSONObject.put("discount_rate",""+discount_rate+"");	
                                }else{
                                	continue;	
                                }
                                
                            }
                        }
                        jSONObject = urlConversion(jSONObject,shopCode);
						jSONArray.put(jSONObject);
						totalCnt++;
					}
				}
				jSONGoodsList.put("goodsList",jSONArray);
				jSONGoodsList.put("totalCnt",totalCnt);
				jSONGoodsList.put("imgtype","2");
				jSONGoodsList.put("shopCode",shopCode);
				out.println(jSONGoodsList.toString());
		      
		} catch (IOException e) { //Jsoup의 connect 부분에서 IOException 오류가 날 수 있으므로 사용한다.   
		      e.printStackTrace();
		}
	}
%>


<%
//11st
	if(bestType.equals("6")) {
		int a =1;
		try {
		       shopCode = 5910; //11st
		      
		       //Document doc = Jsoup.connect("http://m.11st.co.kr/MW/html/main.html#/home").get(); //웹에서 내용을 가져온다.
		       //Elements contents = doc.select("div.deal_area li.lcl "); //내용 중에서 원하는 부분을 가져온다.
		       //String text = contents.text(); //원하는 부분은 Elements형태로 되어 있으므로 이를 String 형태로 바꾸어 준다.
		       //String href = contents.attr("href"); //원하는 부분은 Elements형태로 되어 있으므로 이를 String 형태로 바꾸어 준다.
				
		       String url = "http://m.11st.co.kr/MW/html/mainTabData/mobileWeb_DEAL.json";
		       
		       ///InputStream input = new URL(url).openStream();
	           //Document doc = Jsoup.parse(input, "euc-kr", url);
		       
				ArrayList al = new ArrayList();
				ArrayList alMov = new ArrayList();
				
				//viewtype3 list_htype2 ui_templateContent
				//viewtype3 list_htype2 ui_templateContent
				
		    	//Elements itemLink = doc.select("div > ul > li");
		    	JSONObject dealBest = jsonUrl11sDealtParsing(url);
		    	
		    	//JSONArray jsonObj = dealBest.getJSONObject("data");
		    	JSONArray jsonArr = dealBest.getJSONArray("data");
		    	
		    	for(int i =0 ; i < jsonArr.length(); i++){
		    		
		    		JSONObject obj = jsonArr.getJSONObject(i);
		    		//JSONObject obj = obj.getJSONArray("blockList");	
		    		
		    	}
		    	
		    	
		    	
		    	
				Mobile_GoodsToPricelist_Proc mobile_goodstopricelist_proc = new Mobile_GoodsToPricelist_Proc();
				
				JSONObject jSONGoodsList = new JSONObject(); 
				JSONArray jSONArray = new JSONArray();
				
				int totalCnt = 0;
				
				for(int i =0 ; i < jsonArr.length(); i++){
					
					JSONObject obj = jsonArr.getJSONObject(i);
					
					/*
					String item = StringUtils.trim((String)map.get("item"));
					String imgSrc = StringUtils.trim((String)map.get("imgSrc"));
					String orgPrice = StringUtils.trim((String)map.get("orgPrice"));
					String pcnt = StringUtils.trim((String)map.get("pcnt"));
					String imgtype = StringUtils.trim((String)map.get("imgtype"));
					//String option = StringUtils.trim((String)map.get("option"));
					String option = "";
					String title = StringUtils.trim((String)map.get("title"));
					String amov = StringUtils.trim(StringUtils.defaultString((String)map.get("amov")));
					String imov = StringUtils.trim(StringUtils.defaultString((String)map.get("imov")));
					*/
					
					//JSONObject logBody = obj.getJSONObject("logBody");
					//String content_no = logBody.getString("content_no");
					String prdNo = obj.getString("prdNo");
					String imgSrc = obj.getString("prdImgUrl");
					String orgPrice = StringUtils.replace(obj.getString("selPrc"), ",", "") ;
					String pcnt = obj.getString("cmltSelQty");
					
					String imgtype = "2";
					//String option = StringUtils.trim((String)map.get("option"));
					String option = "";
					String title = obj.getString("prdNm");;
					String amov = "";
					String imov = "";
                    
					Mobile_GoodsToPricelist_Data mgtpd = mobile_goodstopricelist_proc.getPrictListOne(shopCode, prdNo);
					
					if(mgtpd != null){
						
						String o_imgurl = mgtpd.getImgurl();
						String o_url = mgtpd.getUrl();
						long o_price = mgtpd.getPrice();
						String o_goodsnm = mgtpd.getGoodsnm();
						int modelno = mgtpd.getModelno();
						long plNo = mgtpd.getPl_no();
						String o_ca_code = mgtpd.getCa_code();
						String goodscode = mgtpd.getGoodscode();
						
						String ca_code4 = "";
						String ca_codeName4 = "";
						
						if(o_ca_code.length()>4) ca_code4 = o_ca_code.substring(0, 4);
	                    else ca_code4 = o_ca_code;
	                    Category_Proc category_proc = new Category_Proc();
	                    ca_codeName4 = category_proc.getData_Catename(ca_code4, 2);
						
						//if(imageUrlHash.containsKey(o_goodscode)) {
						//shopImageUrl = imageUrlHash.get(o_goodscode);
						//}
						o_url = toUrlCode(o_url);
						JSONObject jSONObject = new JSONObject(); 
						
						jSONObject.put("gd_cd",goodscode);
						jSONObject.put("gd_kn_cd","H");
						jSONObject.put("view_ord",i);
						jSONObject.put("spm_cd",shopCode);
								
						jSONObject.put("goodsnm",""+title+"");
						//jSONObject.put("shopImageUrl",imgSrc);
						jSONObject.put("shopImageUrl",o_imgurl);
						jSONObject.put("url",o_url);
						jSONObject.put("pc_url", mgtpd.getUrl());
						jSONObject.put("modelno",""+modelno+"");
						jSONObject.put("ca_code4","");
						jSONObject.put("deliveryinfo","");
						jSONObject.put("price",""+o_price+"");
						jSONObject.put("deliverytype2","");
						jSONObject.put("ca_code",o_ca_code);
						jSONObject.put("pl_no",""+plNo+"");
						jSONObject.put("deliveryinfo2","");
						jSONObject.put("ca_codeName",ca_codeName4);
						jSONObject.put("imgurl",o_imgurl);
						jSONObject.put("pcnt",pcnt);
						jSONObject.put("orgPrice",orgPrice);
						jSONObject.put("imgtype",imgtype);
						jSONObject.put("option",option);
						jSONObject.put("imgtype","2");
						jSONObject.put("goodscode",goodscode);
						
						if(!amov.equals("")){
							jSONObject.put("amov",imov);	
						}
						if(!imov.equals("")){
							jSONObject.put("imov",imov);	
						}
						if(!amov.equals("")){//웹용
							jSONObject.put("wmov",amov);	
						}
						
                        if(!orgPrice.equals("")){
                            float f_orgPrice = Float.valueOf(orgPrice);
                            float f_Price = (float)o_price;
                            
                            if(f_orgPrice != f_Price){
                                int discount_rate = (int) Math.floor(((f_orgPrice-f_Price)/f_orgPrice)*100);
                                if(discount_rate > 0){
                                	jSONObject.put("discount_rate",""+discount_rate+"");	
                                }else{
                                	continue;	
                                }
                                
                            }
                        }
                        jSONObject = urlConversion(jSONObject,shopCode);
						jSONArray.put(jSONObject);
						totalCnt++;
					}
				}
				jSONGoodsList.put("goodsList",jSONArray);
				jSONGoodsList.put("totalCnt",totalCnt);
				jSONGoodsList.put("imgtype","2");
				jSONGoodsList.put("shopCode",shopCode);
				out.println(jSONGoodsList.toString());
		      
		} catch (IOException e) { //Jsoup의 connect 부분에서 IOException 오류가 날 수 있으므로 사용한다.   
		      e.printStackTrace();
		}
	}
%>

<%!
public JSONObject jsonObjectUrlParsing(String strUrl) throws UnsupportedEncodingException, MalformedURLException, IOException, JSONException{
    
			System.out.println("strUrl : "+strUrl);
	
    		URL urlObj = new URL(strUrl);
			HttpURLConnection conn = (HttpURLConnection) urlObj.openConnection();
			conn.setRequestMethod("GET");
			conn.setConnectTimeout(20000);
			conn.setReadTimeout(5000);
			conn.setRequestProperty("Accept-Charset", "UTF-8");
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

			BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream(),  "UTF-8"));
			
			StringBuilder html = new StringBuilder();  
			
			String inputLine;
			while ((inputLine = in.readLine()) != null) {
				html.append(inputLine);
			}

			System.out.println("html="+html.length());
			//rtnValue = html.toString();
			in.close();
			conn.disconnect();
    
	BufferedReader br = new BufferedReader(new InputStreamReader((new URL(strUrl)).openConnection().getInputStream(),"UTF-8"));
	StringBuilder sbJson = new StringBuilder();
	String strLine = "";
	    
	while ((strLine = br.readLine()) != null){
	   	
		//String str = StringUtils.substringBetween(strLine, "AllKillMainDeals\":", ",\"LargeCategories");
		sbJson.append(strLine);
	}
	br.close();
	try {
		JSONObject jSONObject = new JSONObject(sbJson.toString());
		//JSONObject JSONObject = new JSONObject(sbJson.toString());
		
		return jSONObject;
		
	} catch (JSONException e) {	}
	return null;
}
public JSONArray jsonUrlParsing(String strUrl) throws UnsupportedEncodingException, MalformedURLException, IOException, JSONException{
	BufferedReader br = new BufferedReader(new InputStreamReader((new URL(strUrl)).openConnection().getInputStream(),"euc-kr"));
	StringBuilder sbJson = new StringBuilder();
	String strLine = "";
    
	while ((strLine = br.readLine()) != null){
		String str = StringUtils.substringBetween(strLine, "AllKillMainDeals\":", ",\"LargeCategories");
		str = StringUtils.replace(str,"\\\\\"","'");
		str = StringUtils.replace(str,"\\\\/","/");
		sbJson.append(str);
	}
	br.close();
	try {
	   
		JSONArray jsonArray = new JSONArray(sbJson.toString());
		//JSONObject JSONObject = new JSONObject(sbJson.toString());
		return jsonArray;
		
	} catch (JSONException e) {
	   System.out.println(e);
	}
	return null;
}


public JSONObject jsonUrl11stParsing(String strUrl) throws UnsupportedEncodingException, MalformedURLException, IOException, JSONException{
	BufferedReader br = new BufferedReader(new InputStreamReader((new URL(strUrl)).openConnection().getInputStream(),"euc-kr"));
	StringBuilder sbJson = new StringBuilder();
	String strLine = "";
    
	while ((strLine = br.readLine()) != null){
		String str = strLine;
		//str = StringUtils.replace(str,"\\\\\"","'");
		//str = StringUtils.replace(str,"\\\\/","/");
		sbJson.append(str);
	}
	br.close();
	
	String aa = StringUtils.substringBetween(sbJson.toString(), "templateData =", "var isMoveNext = false");
	
	try {
	   
		//JSONArray jsonArray = new JSONArray(sbJson.toString());
		JSONObject jSONObject = new JSONObject(aa);
		
		return jSONObject;
		
	} catch (JSONException e) {
	   System.out.println(e);
	}
	return null;
}


public JSONObject jsonUrl11sDealtParsing(String strUrl) throws UnsupportedEncodingException, MalformedURLException, IOException, JSONException{
	BufferedReader br = new BufferedReader(new InputStreamReader((new URL(strUrl)).openConnection().getInputStream(),"euc-kr"));
	StringBuilder sbJson = new StringBuilder();
	String strLine = "";
    
	while ((strLine = br.readLine()) != null){
		String str = strLine;
		sbJson.append(str);
	}
	br.close();
	
	try {
	   
		//JSONArray jsonArray = new JSONArray(sbJson.toString());
		JSONObject jSONObject = new JSONObject(sbJson.toString());
		
		return jSONObject;
		
	} catch (JSONException e) {
	   System.out.println(e);
	}
	return null;
}


  public String getOnlyNumberString(String str){
        if(str == null) return str;

        StringBuffer sb = new StringBuffer();
        int length = str.length();
        for(int i = 0 ; i < length ; i++){
            char curChar = str.charAt(i);
            if(Character.isDigit(curChar)) sb.append(curChar);
        }

        return sb.toString();
    }
  public JSONObject getTmonJSON() {
		HttpURLConnection con = null;
		InputStreamReader in = null;
		JSONObject result = new JSONObject();
		try {
			URL obj = new URL(
					"http://m.tmon.co.kr/api/home/direct/v1/tabapi/api/best/dealInfoDeals?platformType=MOBILE_WEB&useHeader=AG&size=100&categoryNo=0&bestType=best_100&useCache=CACHE_S60");
			con = (HttpURLConnection) obj.openConnection();
			con.setRequestMethod("GET");
			con.setUseCaches(true);
			con.setRequestProperty("Accept","text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8");
			con.setRequestProperty("Accept-Encoding", "gzip, deflate");
			con.setRequestProperty("Accept-Language", "ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7");
			con.setRequestProperty("Cache-Control", "max-age=0");
			con.setRequestProperty("Connection", "keep-alive");
			con.setRequestProperty("Cookie", getTmonCookie());
			con.setRequestProperty("Host", "www.ticketmonster.co.kr");
			con.setRequestProperty("Upgrade-Insecure-Requests", "1");
			con.setRequestProperty("User-Agent","Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36");
			
			if (con.getResponseCode() == HttpURLConnection.HTTP_OK) { // success

				int size = con.getInputStream().available();
				
				in = new InputStreamReader("gzip".equals(con.getContentEncoding()) 
												? new GZIPInputStream(con.getInputStream())
												: con.getInputStream()
											, "UTF-8");

				StringBuilder sb = new StringBuilder();
				
				while (true) {
					int ch = in.read();
					if (ch == -1)
						break;
					sb.append((char) ch);
				}
				result = new JSONObject(sb.toString());
			}
		} catch (Exception e) {
		} finally {
			try {
				if (con != null)
					con.disconnect();
				if (in != null)
					in.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	public String getTmonCookie() {
		String m_cookies = "";
		HttpURLConnection con = null;
		try {

			URL url = new URL("http://www.ticketmonster.co.kr/home");
			con = (HttpURLConnection) url.openConnection();
			con.setRequestProperty("User-Agent",
					"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36");

			Map<String, List<String>> headerFields = con.getHeaderFields();
			Set<String> headerFieldsSet = headerFields.keySet();
			Iterator<String> hearerFieldsIter = headerFieldsSet.iterator();

			while (hearerFieldsIter.hasNext()) {

				String headerFieldKey = hearerFieldsIter.next();
				if ("Set-Cookie".equalsIgnoreCase(headerFieldKey)) {
					List<String> headerFieldValue = headerFields.get(headerFieldKey);
					for (String headerValue : headerFieldValue) {
						String[] fields = headerValue.split("; ");
						String cookieValue = fields[0];
						m_cookies += cookieValue + "; ";
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (con != null)
				con.disconnect();
		}
		return m_cookies;
	}
	
	public JSONObject getGmarketJSON(String url) {
		HttpURLConnection con = null;
		InputStreamReader in = null;
		JSONObject result = new JSONObject();
		try {
			URL obj = new URL(url);
			con = (HttpURLConnection) obj.openConnection();
			con.setRequestMethod("GET");
			con.setUseCaches(true);
			con.setRequestProperty("Accept","text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8");
			//con.setRequestProperty("Accept-Encoding", "gzip, deflate");
			con.setRequestProperty("Accept-Language", "ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7");
			con.setRequestProperty("Cache-Control", "max-age=0");
			con.setRequestProperty("Connection", "keep-alive");
			//con.setRequestProperty("Cookie", getTmonCookie());
			con.setRequestProperty("Host", "m.gmarket.co.kr");
			con.setRequestProperty("Upgrade-Insecure-Requests", "1");
			con.setRequestProperty("User-Agent","Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36");
			
			if (con.getResponseCode() == HttpURLConnection.HTTP_OK) { // success

				int size = con.getInputStream().available();
				
				in = new InputStreamReader(con.getInputStream()	, "UTF-8");

				//in = new BufferedReader(new InputStreamReader(con.getInputStream(),  "UTF-8"));
				
				StringBuilder sb = new StringBuilder();
				
				while (true) {
					int ch = in.read();
					if (ch == -1)	break;
					sb.append((char) ch);
					System.out.println(sb.toString());
				}
				
				result = new JSONObject(sb.toString());
			}
		} catch (Exception e) {
		} finally {
			try {
				if (con != null)
					con.disconnect();
				if (in != null)
					in.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	/*
	public JSONObject getHttpsGmarketJSON(String targetUrl) {

		JSONObject json = new JSONObject();
		
		try{
			String resultJson = "";
			
			String line = null; 
			
			InputStream in = null; 
	    	BufferedReader reader = null; 
	    	HttpsURLConnection httpsConn = null;
	    	
	    	StringBuilder strJson = new StringBuilder();
			
			sslTrustAllCerts();
			// Get HTTPS URL connection 
			URL url = new URL(targetUrl); 
			httpsConn = (HttpsURLConnection) url.openConnection(); 
			
			httpsConn.setDoInput(true); 
			// Output setting 
			//httpsConn.setDoOutput(true); 
			// Caches setting 
			httpsConn.setUseCaches(false); 
			// Read Timeout Setting 
			httpsConn.setReadTimeout(2000); 
			// Connection Timeout setting 
			httpsConn.setConnectTimeout(2000); 
			// Method Setting(GET/POST) 
			httpsConn.setRequestMethod("GET"); 
			// Header Setting 
			 
			httpsConn.setRequestProperty("Accept-Encoding","Accept-Encoding"); 
			httpsConn.setRequestProperty("Accept-Language","ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7"); 
			httpsConn.setRequestProperty("Connection","keep-alive"); 
			httpsConn.setRequestProperty("Cookie","pguid=21590980884473009442010000; cguid=11590980884473009442000000; PCUID=15909809417295235125744; _fbp=fb.2.1590980942142.1172656186; ssguid=316185265092820004622890000; sguid=31625462141690005182291000"); 
			httpsConn.setRequestProperty("Host","m.gmarket.co.kr"); 
			httpsConn.setRequestProperty("Referer","https://m.gmarket.co.kr/n/superdeal"); 
			httpsConn.setRequestProperty("sec-ch-ua","\" Not;A Brand\";v=\"99\", \"Google Chrome\";v=\"91\", \"Chromium\";v=\"91\""); 
			httpsConn.setRequestProperty("sec-ch-ua-mobile","?0"); 
			httpsConn.setRequestProperty("Sec-Fetch-Dest","document"); 
			httpsConn.setRequestProperty("Sec-Fetch-Mode","navigate");
			httpsConn.setRequestProperty("Sec-Fetch-Site","same-origin");
			httpsConn.setRequestProperty("Sec-Fetch-User","?1");
			httpsConn.setRequestProperty("Upgrade-Insecure-Requests","1");
			httpsConn.setRequestProperty("User-Agent","Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.114 Safari/537.36");
			
			int responseCode = httpsConn.getResponseCode(); 
    		
    		// SSL setting 
    		SSLContext context = SSLContext.getInstance("TLS"); 
    		context.init(null, null, null); 
    		// No validation for now 
    		httpsConn.setSSLSocketFactory(context.getSocketFactory()); 
    		// Connect to host 
    		httpsConn.connect(); 
    		httpsConn.setInstanceFollowRedirects(true); 
    		
    		// Print response from host 
    		if (responseCode == HttpsURLConnection.HTTP_OK){  // 정상 호출 200 
    			in = httpsConn.getInputStream();  
			} else { // 에러 발생 
    				in = httpsConn.getErrorStream(); 
    		} 
    		reader = new BufferedReader(new InputStreamReader(in)); 
    		
    		while ((line = reader.readLine()) != null) { 
    			System.out.printf("%s\n", line);
    			strJson.append(line);
    		} 
    		
    		resultJson = strJson.toString();
    		
    		//System.out.println("resultJson = " +resultJson);
    		
    		reader.close(); 
			
		}catch(Exception e){
			System.out.println("e:"+e);
		}
		return json;		
		
	}
	
	public static void sslTrustAllCerts(){ 
		TrustManager[] trustAllCerts = new TrustManager[] { 
			new X509TrustManager() { 
				public X509Certificate[] getAcceptedIssuers() { 
					return null; 
				} 
				public void checkClientTrusted(X509Certificate[] certs, String authType) { } 
				public void checkServerTrusted(X509Certificate[] certs, String authType) { }
			} 
		}; 

		SSLContext sc;

		try { 
			sc = SSLContext.getInstance("SSL"); 
			sc.init(null, trustAllCerts, new SecureRandom()); 
			HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory()); 
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

*/
%>


