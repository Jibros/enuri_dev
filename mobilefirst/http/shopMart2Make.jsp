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
// url
// type=1 : get
// type=2 : post
// post일 경우는 param이 필요하지만 get일경우는 그냥 url에 포함시키면됨
	String bestType = StringUtils.defaultString(request.getParameter("bestType"));
	
	int shopCode = 0;
	String shopName = "";
	
	//bestType=1 : 티몬
	if(bestType.equals("1")) {
		try {
			shopCode = 6641; //티몬
			shopName = "티켓몬스터";
		
			//String outPutStr1 = jsonUrlParsing("http://mobile.ticketmonster.co.kr/api/mart/getDealNo?catNo=19010000&dealOnTop=&_=1469499318235");
			String outPutStr1 = jsonUrlParsing("http://mobile.ticketmonster.co.kr/api/mart/getDealNo?catNo=19070000&dealOnTop=&_=1496628681847");
			//String outPutStr2 = jsonUrlParsing("http://mobile.ticketmonster.co.kr/api/mart/getDealNo?catNo=19020000&dealOnTop=&_=1469499318235");
			String outPutStr2 = jsonUrlParsing("http://mobile.ticketmonster.co.kr/api/mart/getDealNo?catNo=19110000&dealOnTop=&_=1496629059158");
			//String outPutStr3 = jsonUrlParsing("http://mobile.ticketmonster.co.kr/api/mart/getDealNo?catNo=19030000&dealOnTop=&_=1469499318235");
			String outPutStr3 = jsonUrlParsing("http://mobile.ticketmonster.co.kr/api/mart/getDealNo?catNo=19120000&dealOnTop=&_=1496629096538");
			
			//System.out.println("outPutStr1:"+outPutStr1);
			
			JSONObject mainJson1 = new JSONObject(outPutStr1);
			JSONObject mainJson2 = new JSONObject(outPutStr2);
			JSONObject mainJson3 = new JSONObject(outPutStr3);
			
			JSONArray mainArr1 = mainJson1.getJSONArray("data");
			JSONArray mainArr2 = mainJson2.getJSONArray("data");
			JSONArray mainArr3 = mainJson3.getJSONArray("data");
			
			String data1 = mainArr1.toString().substring(1, mainArr1.toString().length()-1);
			String data2 = mainArr2.toString().substring(1, mainArr2.toString().length()-1);
			String data3 = mainArr3.toString().substring(1, mainArr3.toString().length()-1);
			
			String replaceData = "";
			/*
			for(int i = 0; i < mainArr1.length(); i++){
				int index = data1.indexOf(',');
				replaceData += data1.substring(0, index) + ",";
				data1 = data1.substring(index+1);
			}
			for(int i = 0; i < mainArr2.length(); i++){
				int index = data2.indexOf(',');
				replaceData += data2.substring(0, index) + ",";
				data2 = data2.substring(index+1);
			}
			for(int i = 0 ; i < mainArr3.length() ; i++){
			   if(i > 200) break;
			   replaceData += mainArr3.getInt(i)+",";
			}
			*/
			
			//replaceData = replaceData.substring(0, replaceData.length()-1);
	 		//out.println("replaceData="+replaceData);
		    String data = data1+","+data2+","+data3;
			String str = jsonUrlParsing("http://www2.ticketmonster.co.kr/api/mart/deals?dealNoList="+URLEncoder.encode(data,"UTF-8")+"&tlStartOrder=1&_=1465436329733");
	 		//out.println("str : "+str);
				
			JSONObject jsonObject = new JSONObject(str);
			JSONArray jsonArray = new JSONArray(jsonObject.getJSONObject("data").getJSONArray("dealList").toString());
//	 		out.println(jsonArray);
				
			ArrayList<List> a1 = new ArrayList<List>();
			ArrayList<List> a2 = new ArrayList<List>();
			ArrayList<List> a3 = new ArrayList<List>();
			ArrayList<List> a4 = new ArrayList<List>();
			ArrayList<List> a5 = new ArrayList<List>();

//	 		System.out.println("jsonArray.length()="+jsonArray.length());
				
	    	for (int i=0; i<jsonArray.length(); i++) {

	    		String dealNo = jsonArray.getJSONObject(i).get("dealNo").toString();
	    		String img = "";
	    		
	    		try{
	    			img = jsonArray.getJSONObject(i).get("imageUrl").toString();//PC
	    		}catch(Exception e){
	    			
	    		}
	    		
	    		String buyCnt = jsonArray.getJSONObject(i).get("buyCnt").toString();
	    		String oriPrice = jsonArray.getJSONObject(i).getJSONObject("price").get("originalPrice").toString();
				
	    		String option = jsonArray.getJSONObject(i).get("deliveryLabelList").toString();
	    		
	    		/*
	    		String optionType = jsonArray.getJSONObject(i).getJSONObject("label").get("type").toString();
				String optionFirst = jsonArray.getJSONObject(i).getJSONObject("label").get("firstLineDesc").toString();
				String optionSecond = "";
				boolean bSecond = jsonArray.getJSONObject(i).getJSONObject("label").has("secondLineDesc");
				if(bSecond)	optionSecond = jsonArray.getJSONObject(i).getJSONObject("label").get("secondLineDesc").toString();

				String option = "";
				String option2 = optionFirst+optionSecond;
				if(optionType.equals("PACKAGE_DELIVERY")){
					option = "슈퍼마트 묶음배송";
				}else if(optionType.equals("FREE")){
					option = "무료배송";
				}
				
				if(!option.equals("") && !option2.equals("")){
					option = option + "," + option2;
				}else if(option.equals("") && !option2.equals("")){
					option = option2;
				}
				*/
				
				List<String> map = new ArrayList<String>();
				List<String> map2 = new ArrayList<String>();
				List<String> map3 = new ArrayList<String>();
				List<String> map4 = new ArrayList<String>();
				List<String> map5 = new ArrayList<String>();
				
				//HashMap map = new HashMap(); 
				map.add(dealNo);
				map2.add(img);
				map3.add(buyCnt);
				map4.add(oriPrice);
				map5.add(option);
				
				a1.add(map);
				a2.add(map2);
				a3.add(map3);
				a4.add(map4);
				a5.add(map5);
				
			}

			Mobile_GoodsToPricelist_Proc mobile_goodstopricelist_proc = new Mobile_GoodsToPricelist_Proc();
			
			JSONObject jSONGoodsList = new JSONObject(); 
			JSONArray jSONArray = new JSONArray();
			
			int totalCnt = 0;
			
			for(int i =0 ; i < a1.size(); i++){
				String item = a1.get(i).toString();
				String item2 = item.replace("[", "");
				String item3 = item2.replace("]", "");
				String imgSrc = a2.get(i).toString();
				String imgSrc2 = imgSrc.replace("[", "");
				String imgSrc3 = imgSrc2.replace("]", "");
				String buyCnt = a3.get(i).toString();
				String buyCnt2 = buyCnt.replace("[", "");
				String buyCnt3 = buyCnt2.replace("]", "");
				String oriPrice = a4.get(i).toString();
				oriPrice = oriPrice.replace("[", "").replace("]", "");
				String option = a5.get(i).toString();
				
				option = StringUtils.replace(option, "[\"", "");
				option = StringUtils.replace(option, "\"]", "");
				
				option = option.replace("[", "").replace("]", "");
				

				if (buyCnt3 == ""){
					buyCnt3 = "0";
				}
				
				Mobile_GoodsToPricelist_Data mgtpd = mobile_goodstopricelist_proc.getPrictListOne(shopCode, item3);

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
					jSONObject.put("imgurl",""+imgSrc3+"");//가져온 이미지	
					jSONObject.put("pcnt",""+buyCnt3+"");//가져온 구매 개수
					jSONObject.put("url",""+o_url+"");
					jSONObject.put("modelno",""+o_modelno+"");
					jSONObject.put("ca_code4","");
					jSONObject.put("deliveryinfo",""+o_deliverinfo+"");
					jSONObject.put("price",""+o_price+"");
					jSONObject.put("deliverytype2",""+o_deliverytype2+"");
					jSONObject.put("ca_code",""+o_ca_code+"");
					jSONObject.put("pl_no",""+o_pl_no+"");
					jSONObject.put("deliveryinfo2",""+o_deliverinfo2+"");
					jSONObject.put("ca_codeName","");
					jSONObject.put("orgPrice",""+oriPrice+"");
					jSONObject.put("option",option);
					
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
	
	//bestType=2 : G마켓
	if(bestType.equals("2")) {
	
		try {
			shopCode = 536; //G마켓
			shopName = "G마켓";
			
			Mobile_GoodsToPricelist_Proc mobile_goodstopricelist_proc = new Mobile_GoodsToPricelist_Proc();
			
			JSONObject jSONGoodsList = new JSONObject(); 
			JSONArray jSONArray = new JSONArray();
			
			int totalCnt = 0;
			
			Document doc = Jsoup.connect("http://mobile.gmarket.co.kr/Mart").userAgent("Chrome").get(); //웹에서 내용을 가져온다.
		    //Elements contents = doc.select("div.deal_area li.lcl "); //내용 중에서 원하는 부분을 가져온다.
		    //String text = contents.text(); //원하는 부분은 Elements형태로 되어 있으므로 이를 String 형태로 바꾸어 준다.
		    //String href = contents.attr("href"); //원하는 부분은 Elements형태로 되어 있으므로 이를 String 형태로 바꾸어 준다.
		    //System.out.println("href : "+href);

			ArrayList<List> arrCateSeq = new ArrayList<List>();
			ArrayList<List> arrCateNm = new ArrayList<List>();
			ArrayList<List> arrCateCd = new ArrayList<List>();
			//System.out.println(doc.toString());		
				
			String docStr = doc.toString();
			String searchStr = "Data.MartCategoryList = ";
				
			int stIndex = docStr.indexOf(searchStr);
			int endIndex = docStr.indexOf("];",stIndex);
			String jsonStr = docStr.substring(stIndex+searchStr.length(), endIndex+1);

			JSONArray json = null;
			json = new JSONArray(jsonStr);
			//out.println(json.toString());	
			
	    	for (int i=0; i<json.length(); i++) {
    			String goodsCode = json.getJSONObject(i).get("Seq").toString();
    			String imageUrl = json.getJSONObject(i).get("MartCategoryNm").toString();
    			String oriPrice = json.getJSONObject(i).get("MartGdmcCd").toString();
    			
    			List<String> map = new ArrayList<String>();
				List<String> map2 = new ArrayList<String>();
				List<String> map3 = new ArrayList<String>();

				map.add(goodsCode);
				map2.add(imageUrl);
				map3.add(oriPrice);
				
				arrCateSeq.add(map);
				arrCateNm.add(map2);
				arrCateCd.add(map3);
			}
		    
	    	String cateCd = "";
	    	String cateSeq = "";

	    	for (int v=0; v<arrCateSeq.size(); v++) {
	    		cateCd = arrCateCd.get(v).toString().replace("[", "").replace("]", "");
	    		cateSeq = arrCateSeq.get(v).toString().replace("[", "").replace("]", "");
	    		
	    		doc = Jsoup.connect("http://mobile.gmarket.co.kr/Mart?categoryCode="+cateCd+"&categorySeq="+cateSeq).userAgent("Chrome").get(); //웹에서 내용을 가져온다.
	    	//	System.out.println("arrCateCd.get(v)="+arrCateCd.get(v).toString());	
	    	//	System.out.println("arrCateSeq.get(v)="+arrCateSeq.get(v).toString());	
	    		ArrayList<List> al = new ArrayList<List>();
				ArrayList<List> a2 = new ArrayList<List>();
				ArrayList<List> a3 = new ArrayList<List>();
				ArrayList<List> a4 = new ArrayList<List>();
				//System.out.println(doc.toString());	
				
				docStr = doc.toString();
				searchStr = "Data.ItemGroupList = ";
				//System.out.println(docStr);	
				stIndex = docStr.indexOf(searchStr);
				endIndex = docStr.indexOf("];",stIndex);
				jsonStr = docStr.substring(stIndex+searchStr.length(), endIndex+1);
				//System.out.println(jsonStr);	
				json = null;
				json = new JSONArray(jsonStr);
				//System.out.println(json.toString());	
				
				for (int i=0; i<json.length(); i++) {
		    		JSONArray arr = (JSONArray) json.getJSONObject(i).get("ItemList");
		    		//System.out.println("arr.length()="+arr.length());
		    		for(int j=0; j<arr.length(); j++){
		    			String goodsCode = arr.getJSONObject(j).get("GoodsCode").toString();
		    			String imageUrl = arr.getJSONObject(j).get("ImageUrl").toString();
		    			String oriPrice = arr.getJSONObject(j).get("OriginalPrice").toString();
		    			String option = arr.getJSONObject(j).get("DeliveryText").toString();
		    			
		    			List<String> map = new ArrayList<String>();
						List<String> map2 = new ArrayList<String>();
						List<String> map3 = new ArrayList<String>();
						List<String> map4 = new ArrayList<String>();
						//HashMap map = new HashMap(); 
						map.add(goodsCode);
						map2.add(imageUrl);
						map3.add(oriPrice);
						map4.add(option);
						
						al.add(map);
						a2.add(map2);
						a3.add(map3);
						a4.add(map4);
		    		}
				}
				
		    	System.out.println("al.size()="+al.size());
		    	for(int i =0 ; i < al.size(); i++){
		    		System.out.println(al.get(i).toString());
		    		System.out.println(a2.get(i).toString());
		    	}
				
				int cnt = 0;
				for(int i=0 ; i < al.size(); i++){
					String item = al.get(i).toString();
					item = item.replace("[", "").replace("]", "");
					
					String imgSrc = a2.get(i).toString();
					imgSrc = imgSrc.replace("[", "").replace("]", "");
					
					String oriPrice = a3.get(i).toString();
					oriPrice = oriPrice.replace("[", "").replace("]", "").replaceAll(",", "").trim();
					
					String option = a4.get(i).toString();
					option = option.replace("[", "").replace("]", "");

					Mobile_GoodsToPricelist_Data mgtpd = mobile_goodstopricelist_proc.getPrictListOne(shopCode, item);

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
						jSONObject.put("imgurl",""+imgSrc+"");//가져온 이미지						
						jSONObject.put("url",""+o_url+"");
						jSONObject.put("modelno",""+o_modelno+"");
						jSONObject.put("ca_code4","");
						jSONObject.put("deliveryinfo",""+o_deliverinfo+"");
						jSONObject.put("price",""+o_price+"");
						jSONObject.put("orgPrice",""+oriPrice+"");
						jSONObject.put("deliverytype2",""+o_deliverytype2+"");
						jSONObject.put("ca_code",""+o_ca_code+"");
						jSONObject.put("pl_no",""+o_pl_no+"");
						jSONObject.put("deliveryinfo2",""+o_deliverinfo2+"");
						jSONObject.put("ca_codeName","");
						jSONObject.put("option","");
						
						if(!oriPrice.equals("") && oriPrice != null){
							float f_orgPrice = Float.valueOf(oriPrice);
							float f_Price = (float)o_price;
							
							if(f_orgPrice != f_Price){
								
								int discount_rate = (int) Math.floor(((f_orgPrice-f_Price)/f_orgPrice)*100);
								jSONObject.put("discount_rate",""+discount_rate+"");
								//System.out.println(discount_rate);
							}
						}
						jSONObject = urlConversion(jSONObject,shopCode);
						jSONArray.put(jSONObject);
						
						cnt++;
						totalCnt++;
					}
					if(cnt >= 5){
						break;
					}
				}
	    	}

			jSONGoodsList.put("goodsList",jSONArray);
			jSONGoodsList.put("totalCnt",totalCnt);
			out.println(jSONGoodsList.toString());
		      
		} catch (IOException e) { //Jsoup의 connect 부분에서 IOException 오류가 날 수 있으므로 사용한다.   
		      e.printStackTrace();
		}
	}
%>
<%!
public String jsonUrlParsing(String strUrl) throws UnsupportedEncodingException, MalformedURLException, IOException, JSONException{
    
	
	BufferedReader br = new BufferedReader(new InputStreamReader((new URL(strUrl)).openConnection().getInputStream(),"UTF-8"));
	StringBuilder sbJson = new StringBuilder();
	String strLine = "";
	String rtnValue = "";
	    
	while ((strLine = br.readLine()) != null){
		//String str = StringUtils.substringBetween(strLine, "AllKillMainDeals\":", ",\"LargeCategories");
		sbJson.append(strLine);
	}
	   
	br.close();
	
	rtnValue = sbJson.toString();
	return rtnValue;
}
%>
