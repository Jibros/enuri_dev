<%@page import="com.enuri.exception.ExceptionManager"%>
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
<%@ page import="org.apache.commons.lang3.*"%>
<%
	try {
		String[] shopCode = {"536", "4027", "5910", "6641", "6508","55"};
		String[] shopName = {"슈퍼딜", "올킬", "쇼킹딜", "티몬", "위메프","쎈딜"};
		String[] shopEng = {"superdeal", "allkill", "shockingdeal", "ticketmonster", "wemakeprice","ssendeal"};
		String[] shopUrl = {"http://m.enuri.com/mobilefirst/http/json/superDeal.json",
							"http://m.enuri.com/mobilefirst/http/json/allKill.json",
							"http://m.enuri.com/mobilefirst/http/json/shocking.json",
							"http://m.enuri.com/mobilefirst/http/json/tmon.json",
							"http://m.enuri.com/mobilefirst/http/json/wemake.json",
							"http://m.enuri.com/mobilefirst/http/json/ssenDeal.json"
							};
		JSONObject jSONHotDealList = new JSONObject(); 
		
		Mobile_GoodsToPricelist_Proc mgp = new Mobile_GoodsToPricelist_Proc();
		ArrayList al = new ArrayList();
		al = mgp.getPlno();
		
		String strPlnos = "";
		for(int j = 0; j < al.size(); j++){
			if(strPlnos != "") strPlnos += ",";
			strPlnos += al.get(j);
		}
		strPlnos = ","+ strPlnos + ",";
		
		for(int i = 0; i < shopCode.length ; i++){
			
			String outPutStr = jsonUrlParsing(shopUrl[i]);
			JSONObject object = new JSONObject(outPutStr);
			JSONArray array = new JSONArray(object.getJSONArray("goodsList").toString());
			
			JSONArray jSONArray = new JSONArray();
	 		
			for (int k = 0; k < array.length(); k++) {	
	    		int rank = k+1;
	    		String img = array.getJSONObject(k).get("shopImageUrl").toString();
	    		String bbs_cnt = "";
	    		String subtitle_bg = "";
	    		String title_bg = "";
	    		String part = "S";
	    		String modelnm = array.getJSONObject(k).get("goodsnm").toString();
	    		String cp_id = "";
	    		String section = "";
	    		String modelno = array.getJSONObject(k).get("modelno").toString();
	    		String title = "";
	    		String shopcode = shopCode[i];
	    		String price = array.getJSONObject(k).get("price").toString();
	    		String bbs_staravg = "";
	    		String click_cnt = "";
	    		String popular_cnt = "";
	    		String section_url = "";
	    		String section_txt = "";
	    		String badge_yn = "";
	    		String factory = "";
	    		String subtitle_color = "";
	    		String mallcnt = "";
	    		String item_id = "";
	    		String title_color = "";
	    		String fix_location = "";
	    		String url = array.getJSONObject(k).get("url").toString();
	    		String show_yn = "";
	    		String subtitle = "";
	    		String pl_no = array.getJSONObject(k).get("pl_no").toString();
	    		String categorynm = array.getJSONObject(k).get("ca_codeName").toString();
	    		String subject_idx = "";
	    		String category = array.getJSONObject(k).get("ca_code4").toString();
	    		String pcnt = array.getJSONObject(k).get("pcnt").toString();
	    		String discount_rate = "";
	    		
	    		if(modelnm.indexOf("다이어트도시락") > -1) continue;
	    		if(modelnm.indexOf("다이어트 도시락") > -1) continue;
	    		
	    		if(array.getJSONObject(k).has("discount_rate")){
	    			discount_rate = array.getJSONObject(k).get("discount_rate").toString();
	    		}
	    		String orgPrice = array.getJSONObject(k).get("orgPrice").toString();
	    		
	    		String tag_txt = "";
	    		String amov = "";
	    		String imov = "";
	    		String wmov = "";
				try{
					tag_txt = array.getJSONObject(k).get("option").toString();
					amov = StringUtils.defaultString(array.getJSONObject(k).get("amov").toString());
		    		imov = StringUtils.defaultString(array.getJSONObject(k).get("imov").toString());
		    		wmov = StringUtils.defaultString(array.getJSONObject(k).get("wmov").toString());
				}catch(Exception e){}
	    		
	    		JSONObject jSONObject = new JSONObject(); 
	    		if(strPlnos.indexOf(","+pl_no+",") < 0){
	    			jSONObject.put("rank", ""+rank+"");
					jSONObject.put("img", ""+img+"");
					jSONObject.put("bbs_cnt", ""+bbs_cnt+"");
					jSONObject.put("subtitle_bg", ""+subtitle_bg+"");
					jSONObject.put("title_bg", ""+title_bg+"");
					jSONObject.put("part", ""+part+"");
					jSONObject.put("modelnm", ""+modelnm+"");
					jSONObject.put("cp_id", ""+cp_id+"");
					jSONObject.put("section", ""+section+"");
					jSONObject.put("modelno", ""+modelno+"");
					jSONObject.put("title", ""+title+"");
					jSONObject.put("shopcode", ""+shopcode+"");
					jSONObject.put("price", ""+price+"");
					jSONObject.put("bbs_staravg", ""+bbs_staravg+"");
					jSONObject.put("click_cnt", ""+click_cnt+"");
					jSONObject.put("popular_cnt", ""+popular_cnt+"");
					jSONObject.put("section_url", ""+section_url+"");
					jSONObject.put("section_txt", ""+section_txt+"");
					jSONObject.put("badge_yn", ""+badge_yn+"");
					jSONObject.put("factory", ""+factory+"");
					jSONObject.put("subtitle_color", ""+subtitle_color+"");
					jSONObject.put("mallcnt", ""+mallcnt+"");
					jSONObject.put("item_id", ""+item_id+"");
					jSONObject.put("title_color", ""+title_color+"");
					jSONObject.put("fix_location", ""+fix_location+"");
					jSONObject.put("url", ""+url+"");
					jSONObject.put("show_yn", ""+show_yn+"");
					jSONObject.put("subtitle", ""+subtitle+"");
					jSONObject.put("pl_no", ""+pl_no+"");
					jSONObject.put("categorynm", ""+categorynm+"");
					jSONObject.put("tag_txt", ""+tag_txt+"");
					jSONObject.put("subject_idx", ""+subject_idx+"");
					jSONObject.put("category", ""+category+"");
					jSONObject.put("pcnt", ""+pcnt+"");
					jSONObject.put("discount_rate", ""+discount_rate+"");
					jSONObject.put("orgPrice", ""+orgPrice+"");
					
					//티몬,위메프,인터파크 정사각형 이미지 노출
					if(shopCode[i].equals("6641") || shopCode[i].equals("6508") || shopCode[i].equals("55") || shopCode[i].equals("5910") )	jSONObject.put("imgtype", "2");
					else															jSONObject.put("imgtype", "1");
					
					if(!amov.equals("")) jSONObject.put("amov", amov);
					if(!imov.equals("")) jSONObject.put("imov", imov);
					if(!wmov.equals("")) jSONObject.put("wmov", wmov);
					
					jSONObject = urlConversion(jSONObject,Integer.parseInt(shopcode));
					jSONArray.put(jSONObject);
	    		}
	    		
	    		int limitCnt = 19; //옥션 지마켓 11번가만 40개 나머지는 20개
	    		
	    		//String[] shopCode = {"536", "4027", "5910", "6641", "6508"};
	    		//String[] shopName = {"슈퍼딜", "올킬", "쇼킹딜", "티몬", "위메프"};
	    		if( shopCode[i].equals("536") || shopCode[i].equals("4027") ||  shopCode[i].equals("5910")){
	    			limitCnt = 39;
	    		}
				if(k == limitCnt){
					System.out.println("limitCnt : "+limitCnt);
					break;
				}
			}
	 		jSONHotDealList.put(shopEng[i],jSONArray);
		}
		out.println(jSONHotDealList.toString());
		
	} catch (IOException e) { //Jsoup의 connect 부분에서 IOException 오류가 날 수 있으므로 사용한다.   
		pushMsgGo(e.toString());  
		e.printStackTrace();
	} catch (JSONException je){
		pushMsgGo(je.toString());
		je.printStackTrace();
	} catch (ExceptionManager em){
		pushMsgGo(em.toString());
		em.printStackTrace();
	}
%>
<%!
public String jsonUrlParsing(String strUrl) throws UnsupportedEncodingException, MalformedURLException, IOException, JSONException{
	
	BufferedReader br = new BufferedReader(new InputStreamReader((new URL(strUrl)).openConnection().getInputStream(),"UTF-8"));
	StringBuilder sbJson = new StringBuilder();
	String strLine = "";
	String rtnValue = "";
	    
	while ((strLine = br.readLine()) != null)		sbJson.append(strLine);
	br.close();
	
	rtnValue = sbJson.toString();
	return rtnValue;
}
%>
