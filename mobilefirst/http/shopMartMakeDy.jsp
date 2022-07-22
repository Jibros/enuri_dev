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
<%@ page import="org.apache.commons.lang3.*"%>
<%
	String bestType = StringUtils.defaultString(request.getParameter("bestType"));
	int shopCode = 0;
	String shopName = "";
	
	//bestType=1 : 롯데마트몰
	if(bestType.equals("1")) {
		try {
			shopCode = 7455; //롯데마트몰
			shopName = "롯데마트몰";
			Document doc = Jsoup.connect("http://m.lottemart.com/mobile/main.do").get();
			ArrayList<HashMap> al = new ArrayList<HashMap>();  
			ArrayList<HashMap> al_1 = new ArrayList<HashMap>();
		  	Elements itemLink = doc.select("ul.goods-list li.goods");
// 		  	Elements itemLink = doc.select("div.dontworry-list-wrap ");
		  	
		  	for (Element link : itemLink) {
		  		Elements linkElm = link.select("a");
				String linkUrl = linkElm.attr("href");
				Elements imgElm = link.select("img");
				String imgSrc = imgElm.attr("src");
				String img = imgSrc.substring(0, 4);
				if(!img.equals("http")){
					imgSrc = "http:" + imgSrc;
				}
				String item = StringUtils.trim(StringUtils.substringBetween(linkUrl,"?ProductCD=","&"));
				
				Elements iconcom2 = link.getElementsByClass("gic-delivery-type11");
				String option = iconcom2.text();
				
				HashMap map = new HashMap(); 
				map.put("item",item);
				map.put("imgSrc",imgSrc);
				map.put("option",option);
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
				String option = StringUtils.trim((String)map.get("option"));

				Mobile_GoodsToPricelist_Data mgtpd = mobile_goodstopricelist_proc.getPrictListOne(shopCode, item);

				if(mgtpd != null){
					String o_ca_code = mgtpd.getCa_code();
					long o_modelno = mgtpd.getModelno();
					String o_deliveryinfo = mgtpd.getDeliveryinfo();
					long o_deliveryinfo2 = mgtpd.getDeliveryinfo2();
					String o_deliverytype2 = mgtpd.getDeliverytype2();
					String o_imgurl = mgtpd.getImgurl();
					String o_url = mgtpd.getUrl();
					long o_price = mgtpd.getPrice();
					String o_goodsnm = mgtpd.getGoodsnm();
					long o_pl_no = mgtpd.getPl_no();
					
					o_url = toUrlCode(o_url);
					
					JSONObject jSONObject = new JSONObject(); 
					jSONObject.put("shopCode",""+shopCode+"");
					jSONObject.put("shopName",""+shopName+"");
					jSONObject.put("goodsnm",""+o_goodsnm+"");
					jSONObject.put("shopImageUrl",o_imgurl);
					jSONObject.put("url",o_url);
					jSONObject.put("modelno",""+o_modelno+"");
					jSONObject.put("ca_code4","");
					jSONObject.put("deliveryinfo",""+o_deliveryinfo+"");
					jSONObject.put("price",""+o_price+"");
					jSONObject.put("deliverytype2",""+o_deliverytype2+"");
					jSONObject.put("ca_code",""+o_ca_code+"");
					jSONObject.put("pl_no",""+o_pl_no+"");
					jSONObject.put("deliveryinfo2",""+o_deliveryinfo2+"");
					jSONObject.put("ca_codeName","");
					jSONObject.put("imgurl",imgSrc);
					//jSONObject.put("option",option);
					jSONObject.put("option","");
					
					jSONObject = urlConversion(jSONObject,shopCode);
					jSONArray.put(jSONObject);
					totalCnt++;
				}
				
				jSONGoodsList.put("goodsList",jSONArray);
				jSONGoodsList.put("totalCnt",totalCnt);
			}

			out.println(jSONGoodsList.toString());
			
		} catch (IOException e) { //Jsoup의 connect 부분에서 IOException 오류가 날 수 있으므로 사용한다.   
			e.printStackTrace();
		}
	}
	
	
	//bestType=2 : 홈플러스
	/*
	if(bestType.equals("2")) {
		try {
			shopCode = 6361; //롯데마트몰
			shopName = "홈플러스";
			Document doc = Jsoup.connect("http://m.homeplus.co.kr/promotion/weeklyMain.do?gnb_seq=3&MT.ac=GNB_menu_leaflet&wiselogDummy=").get();
			ArrayList<HashMap> al = new ArrayList<HashMap>();  
		  	Elements itemLink = doc.select("div.box-content ul.list-product1 li");
		  	
			for (Element link : itemLink) {
				String linkUrl = link.attr("href");
				Elements imgElm = link.select("img");
				String imgSrc = imgElm.attr("src");
				
				Elements delElm = link.getElementsByClass("value2");
				Elements del = delElm.select("strong");
				String org = del.text();
				String orgPrice = org.replace(",","");
				
				Elements iconcom2 = link.getElementsByClass("icon-com2");
				String option = iconcom2.text();
				
				String item = StringUtils.trim(StringUtils.substringBetween(imgSrc,"/204/","_"));

				HashMap map = new HashMap(); 
				map.put("item",item);
				map.put("imgSrc",imgSrc);
				map.put("orgPrice", orgPrice);
				map.put("option", option);
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
				String orgPrice = ChkNull.chkStr(StringUtils.trim((String)map.get("orgPrice")),"");
				String option = StringUtils.trim((String)map.get("option"));
				
				Mobile_GoodsToPricelist_Data mgtpd = mobile_goodstopricelist_proc.getPrictListOne(shopCode, item);

				if(mgtpd != null){
					String o_ca_code = mgtpd.getCa_code();
					long o_modelno = mgtpd.getModelno();
					String o_deliveryinfo = mgtpd.getDeliveryinfo();
					long o_deliveryinfo2 = mgtpd.getDeliveryinfo2();
					String o_deliverytype2 = mgtpd.getDeliverytype2();
					String o_imgurl = mgtpd.getImgurl();
					String o_url = mgtpd.getUrl();
					long o_price = mgtpd.getPrice();
					String o_goodsnm = mgtpd.getGoodsnm();
					long o_pl_no = mgtpd.getPl_no();
					
					JSONObject jSONObject = new JSONObject(); 
					jSONObject.put("shopCode",""+shopCode+"");
					jSONObject.put("shopName",""+shopName+"");
					jSONObject.put("goodsnm",""+o_goodsnm+"");
					jSONObject.put("shopImageUrl",o_imgurl);
					jSONObject.put("url",o_url);
					jSONObject.put("modelno",""+o_modelno+"");
					jSONObject.put("ca_code4","");
					jSONObject.put("deliveryinfo",""+o_deliveryinfo+"");
					jSONObject.put("price",""+o_price+"");
					jSONObject.put("deliverytype2",""+o_deliverytype2+"");
					jSONObject.put("ca_code",""+o_ca_code+"");
					jSONObject.put("pl_no",""+o_pl_no+"");
					jSONObject.put("deliveryinfo2",""+o_deliveryinfo2+"");
					jSONObject.put("ca_codeName","");
					jSONObject.put("imgurl",imgSrc);
					jSONObject.put("orgPrice",orgPrice);
					jSONObject.put("option",option);
					
					if(orgPrice != ""){
						float f_orgPrice = Float.valueOf(orgPrice);
						float f_Price = (float)o_price;
						
						if(f_orgPrice != f_Price){
							int discount_rate = (int) Math.floor(((f_orgPrice-f_Price)/f_orgPrice)*100);
							jSONObject.put("discount_rate",""+discount_rate+"");
						}
					}
					
					jSONArray.put(jSONObject);
					totalCnt++;
				}
				
				jSONGoodsList.put("goodsList",jSONArray);
				jSONGoodsList.put("totalCnt",totalCnt);
			}

			out.println(jSONGoodsList.toString());
			
		} catch (IOException e) { //Jsoup의 connect 부분에서 IOException 오류가 날 수 있으므로 사용한다.   
			e.printStackTrace();
		}
	}
	*/
	//bestType=2 : 홈플러스
	if(bestType.equals("2")) {
	
		try {
			shopCode = 6361; //홈플러스
			shopName = "홈플러스";
			
			JSONObject jSONGoodsList = new JSONObject(); 
			JSONArray jSONArray = new JSONArray();
			
			int totalCnt = 0;
			
			Mobile_GoodsToPricelist_Proc mobile_goodstopricelist_proc = new Mobile_GoodsToPricelist_Proc();
			
			Document doc = Jsoup.connect("http://www.homeplus.co.kr/app.exhibition.eplacard.Eplacard.ghs?comm=usr.eplacard.inf&WT.ac=Utility_leaflet_menu").get();
			Elements divLink = doc.select(".paper-case");
			
			ArrayList<List> arrlist1 = new ArrayList<List>();
			ArrayList<List> arrlist2 = new ArrayList<List>();
			ArrayList<List> arrlist3 = new ArrayList<List>();
			ArrayList<List> arrlist4 = new ArrayList<List>();
			ArrayList<List> arrlist5 = new ArrayList<List>();
			ArrayList<List> arrlist6 = new ArrayList<List>();
			
			for (Element eleDiv : divLink) {				
				if(!eleDiv.hasClass("best")){
					Elements liLink = eleDiv.select(".exh-thumb ul li");
				  	
					for(Element eleLi : liLink){
						String strSrc = eleLi.select(".blank176").attr("src");
					  	
					  	String strTitle = eleLi.select(".name").text();
					  	
					  	String strCode = eleLi.select(".name").attr("onclick");
					  	strCode = strCode.replace("jsGoodDetail('", "").replace("', ''); return false;", "");
					  	
					  	String strIco = eleLi.select(".ico-pro3").text();

					  	String strDelPrice = eleLi.select(".cost").text();
			    		String strBuyPrice = eleLi.select(".buy").text();
			    		
			    		List<String> map = new ArrayList<String>();
						List<String> map2 = new ArrayList<String>();
						List<String> map3 = new ArrayList<String>();
						List<String> map4 = new ArrayList<String>();
						List<String> map5 = new ArrayList<String>();
						List<String> map6 = new ArrayList<String>();

						map.add("http:"+strSrc);	//이미지
						map2.add(strTitle);	//타이틀
						map3.add(strCode);	//상품코드
						map4.add(strIco);	//옵션
						map5.add(strDelPrice);	//원가
						map6.add(strBuyPrice);	//혜택가
						
						arrlist1.add(map);	
						arrlist2.add(map2);	
						arrlist3.add(map3);	
						arrlist4.add(map4);	
						arrlist5.add(map5);	
						arrlist6.add(map6);	
					}
				}
			}
				
			for(int i=0 ; i < arrlist1.size(); i++){
				String strImg = arrlist1.get(i).toString();
				strImg = strImg.replace("[", "").replace("]", "");
				String title = arrlist2.get(i).toString();
				title = title.replace("[", "").replace("]", "");
				String itemCd = arrlist3.get(i).toString();
				itemCd = itemCd.replace("[", "").replace("]", "");
				String option = arrlist4.get(i).toString();
				option = option.replace("[", "").replace("]", "");
				String delPrice = arrlist5.get(i).toString();
				delPrice = delPrice.replace("[", "").replace("]", "").replaceAll(",", "");
				String buyPrice = arrlist6.get(i).toString();
				buyPrice = buyPrice.replace("[", "").replace("]", "").replaceAll(",", "");

				Mobile_GoodsToPricelist_Data mgtpd = mobile_goodstopricelist_proc.getPrictListOne(shopCode, itemCd);

				if(mgtpd != null){
					
					String o_goodsnm = mgtpd.getGoodsnm();
					String o_imgurl = mgtpd.getImgurl();
					String o_url = mgtpd.getUrl();
					long o_modelno = mgtpd.getModelno();
					String o_deliverinfo = mgtpd.getDeliveryinfo();
					long o_price = mgtpd.getPrice();
					String o_deliverytype2 = mgtpd.getDeliverytype2();		
					String o_ca_code = mgtpd.getCa_code();
					long o_pl_no = mgtpd.getPl_no();
					long o_deliverinfo2 = mgtpd.getDeliveryinfo2();
				    
				    o_url = toUrlCode(o_url);
				    
					JSONObject jSONObject = new JSONObject(); 
					jSONObject.put("shopCode",""+shopCode+"");
					jSONObject.put("shopName",""+shopName+"");
					jSONObject.put("goodsnm",""+o_goodsnm+"");
					jSONObject.put("shopImageUrl",""+o_imgurl+"");//DB이미지
					jSONObject.put("imgurl",""+strImg+"");//가져온 이미지						
					jSONObject.put("url",""+o_url+"");
					jSONObject.put("modelno",""+o_modelno+"");
					jSONObject.put("ca_code4","");
					jSONObject.put("deliveryinfo",""+o_deliverinfo+"");
					jSONObject.put("price",""+o_price+"");
					jSONObject.put("orgPrice",""+delPrice+"");
					jSONObject.put("deliverytype2",""+o_deliverytype2+"");
					jSONObject.put("ca_code",""+o_ca_code+"");
					jSONObject.put("pl_no",""+o_pl_no+"");
					jSONObject.put("deliveryinfo2",""+o_deliverinfo2+"");
					jSONObject.put("ca_codeName","");
// 					jSONObject.put("option",""+option+"");
					jSONObject.put("option","");
					
					if(!delPrice.equals("") && delPrice != null){
						float f_orgPrice = Float.valueOf(delPrice);
						float f_Price = (float)o_price;
						
						if(f_orgPrice != f_Price){
							
							int discount_rate = (int) Math.floor(((f_orgPrice-f_Price)/f_orgPrice)*100);
							jSONObject.put("discount_rate",""+discount_rate+"");
							//System.out.println(discount_rate);
						}
					}
					
					jSONObject = urlConversion(jSONObject,shopCode);
					
					jSONArray.put(jSONObject);
					totalCnt++;
				}
			}

			jSONGoodsList.put("goodsList",jSONArray);
			jSONGoodsList.put("totalCnt",totalCnt);
			out.println(jSONGoodsList.toString());
		
		} catch (IOException e) { //Jsoup의 connect 부분에서 IOException 오류가 날 수 있으므로 사용한다.   
		      e.printStackTrace();
		}
		
	}
	
	
	//bestType=3 : 11st
	if(bestType.equals("3")) {
		try {
			shopCode = 5910; //11st
			shopName = "11st";
			

			int[] subCtgrNo = {158999, 152781, 152782, 159002, 152783, 152784, 152785, 152786, 152787, 152788, 152789, 152790, 152791, 152792, 152793, 152794, 152795};
			int[] dispCtgrNo = {1058375,1013276,1001380,1058630,1013278,1013279,1001339,1001337,1013283,1013284,1013285,1013286,1001362,1001355,1001356,1001357,1013291};

			ArrayList<HashMap> al = new ArrayList<HashMap>();  
			
			for(int i = 0; i < subCtgrNo.length; i++){
		            InputStream input = new URL("http://www.11st.co.kr/browsing/MainThemeAction.tmall?method=listingData&ctgrNo=152714&subCtgrNo="+subCtgrNo[i]+"&dispCtgrNo="+dispCtgrNo[i]).openStream();
		            Document docFirst = Jsoup.parse(input, "euc-kr", "http://www.11st.co.kr/browsing/MainThemeAction.tmall?method=listingData&ctgrNo=152714&subCtgrNo="+subCtgrNo[i]+"&dispCtgrNo="+dispCtgrNo[i]);
		            String doc = docFirst.toString();
		            
		            String item = "{ goodsList:"+StringUtils.trim(StringUtils.substringBetween(doc,"favoritePrdList = ",";"))+"}";
		            
		            JSONObject object = new JSONObject(item);
					JSONArray array = new JSONArray(object.getJSONArray("goodsList").toString());
					
// 					out.println(array.length());
					
					for (int k = 0; k < array.length(); k++) {
			            String frgftYn = array.getJSONObject(k).get("frgftYn").toString(); // 사은품 Y
			            String cardDscRtYN = array.getJSONObject(k).get("cardDscRtYN").toString(); // 카드할인 Y
			            int sellerOcb = Integer.parseInt(array.getJSONObject(k).get("sellerOcb").toString()); // OK캐쉬백 >0
			            String mileageDscRtYN = array.getJSONObject(k).get("mileageDscRtYN").toString(); // 마일리지 Y
			            String tmemDscRtYN = array.getJSONObject(k).get("tmemDscRtYN").toString(); // T멤버쉽 Y 
			            String prdNo = array.getJSONObject(k).get("prdNo").toString();
			            
			            //String strMywayDscRt = StringUtils.defaultString((String)array.getJSONObject(k).get("mywayDscRt"));
			            
			            int mywayDscRt = 0;// Integer.parseInt(strMywayDscRt); // 내맘대로 >0
			            String brandshopPointYn = array.getJSONObject(k).get("brandshopPointYn").toString(); // 포인트 Y
			            String martPrmtCd = array.getJSONObject(k).get("martPrmtCd").toString(); // 1+1 03
			            String dlvCstInstBasiCd = array.getJSONObject(k).get("dlvCstInstBasiCd").toString(); // 무료배송 01
			            String dlv =  array.getJSONObject(k).get("dlv").toString(); // 당일배송 day
			            String imgUrl = array.getJSONObject(k).get("imgUrl").toString();
			            String orgPrice = "";
			            
			            String option = "";
			            if(mywayDscRt > 0){
		 					option = "내맘대로 "+mywayDscRt+"%";
		 				}else if(dlvCstInstBasiCd.equals("01")){
		 					option = "무료배송";
		 				}else if(dlv.equals("day")){
		 					option = "당일배송";
		 				}else if(martPrmtCd.equals("03")){
		 					option = "1+1";
		 				}else if(frgftYn.equals("Y")){
		 					option = "사은품";
		 				}else if(brandshopPointYn.equals("Y")){
		 					option = "포인트";
		 				}else if(mileageDscRtYN.equals("Y")){
		 					option = "T멤버쉽";
		 				}else if(sellerOcb > 0){
		 					option = "OK캐쉬백";
		 				}else if(cardDscRtYN.equals("Y")){
		 					option = "카드할인";
		 				}
		
			            HashMap map = new HashMap(); 
						map.put("item",prdNo);
						map.put("imgSrc",imgUrl);
						map.put("orgPrice", orgPrice);
						map.put("option", option);
						
						al.add(map);
						
						if(k == 4){
							break;
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
				String orgPrice = ChkNull.chkStr(StringUtils.trim((String)map.get("orgPrice")),"");
				String option = StringUtils.trim((String)map.get("option"));

				Mobile_GoodsToPricelist_Data mgtpd = mobile_goodstopricelist_proc.getPrictListOne(shopCode, item);

				if(mgtpd != null){
					String o_ca_code = mgtpd.getCa_code();
					long o_modelno = mgtpd.getModelno();
					String o_deliveryinfo = mgtpd.getDeliveryinfo();
					long o_deliveryinfo2 = mgtpd.getDeliveryinfo2();
					String o_deliverytype2 = mgtpd.getDeliverytype2();
					String o_imgurl = mgtpd.getImgurl();
					String o_url = mgtpd.getUrl();
					long o_price = mgtpd.getPrice();
					String o_goodsnm = mgtpd.getGoodsnm();
					long o_pl_no = mgtpd.getPl_no();
					
					o_url = toUrlCode(o_url);
					
					JSONObject jSONObject = new JSONObject(); 
					jSONObject.put("shopCode",""+shopCode+"");
					jSONObject.put("shopName",""+shopName+"");
					jSONObject.put("goodsnm",""+o_goodsnm+"");
					jSONObject.put("shopImageUrl",o_imgurl);
					jSONObject.put("url",o_url);
					jSONObject.put("modelno",""+o_modelno+"");
					jSONObject.put("ca_code4","");
					jSONObject.put("deliveryinfo",""+o_deliveryinfo+"");
					jSONObject.put("price",""+o_price+"");
					jSONObject.put("deliverytype2",""+o_deliverytype2+"");
					jSONObject.put("ca_code",""+o_ca_code+"");
					jSONObject.put("pl_no",""+o_pl_no+"");
					jSONObject.put("deliveryinfo2",""+o_deliveryinfo2+"");
					jSONObject.put("ca_codeName","");
					jSONObject.put("imgurl",imgSrc);
					jSONObject.put("orgPrice",orgPrice);
// 					jSONObject.put("option",option);
					jSONObject.put("option","");
					
					if(orgPrice != ""){
						float f_orgPrice = Float.valueOf(orgPrice);
						float f_Price = (float)o_price;
						
						if(f_orgPrice != f_Price){
							int discount_rate = (int) Math.floor(((f_orgPrice-f_Price)/f_orgPrice)*100);
							jSONObject.put("discount_rate",""+discount_rate+"");
						}
					}
					jSONObject = urlConversion(jSONObject,shopCode);
					jSONArray.put(jSONObject);
					totalCnt++;
				}
				
				jSONGoodsList.put("goodsList",jSONArray);
				jSONGoodsList.put("totalCnt",totalCnt);
			}

			out.println(jSONGoodsList.toString());
			
		} catch (IOException e) { //Jsoup의 connect 부분에서 IOException 오류가 날 수 있으므로 사용한다.   
			e.printStackTrace();
		}
	}
	
	
%>
