<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*,java.text.*,java.net.*"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.simple.*"%>
<%@page import="java.io.*"%>
<%@page import="com.enuri.util.common.*"%>
<%
	if (!valideIp(request.getRemoteAddr())){
		System.out.println("uplus Invalid Request Ip : " + request.getRemoteHost());
		return;
	}

    String pg = StringUtils.defaultString(request.getParameter("page"),"1");

    StringBuilder sbJson = new StringBuilder(); 
    //FileReader fr = new FileReader("/mobilefirst/api/main/mobile_mainlistfix.json"); 
    
    String filepath = "/was/lena/1.3/depot/lena-application/ROOT/mobilefirst/api/main/mobile_mainlistfix.json";
	try{
	    FileInputStream fis = new FileInputStream(new File(filepath)); 
	    InputStreamReader isr = new InputStreamReader(fis,"UTF-8"); 
	    BufferedReader br = new BufferedReader(isr);    
	
	    while(true){
	        String str = br.readLine();
	        if(str==null) break;
	        sbJson.append(str);
	    }
	}catch(Exception e){
	    e.printStackTrace();
	}
    org.json.simple.parser.JSONParser jSONParser = new org.json.simple.parser.JSONParser();  
    
    JSONObject jsonObject = (JSONObject) jSONParser.parse(sbJson.toString());
    JSONArray jSONArray = (JSONArray)jsonObject.get("MainJsonfix"); 
    
    JSONArray jSONArrayTmp = new JSONArray(); 
    
    for(int i = 0  ; i < jSONArray.size(); i++ ){
	    JSONObject jsonTmp =  (JSONObject)jSONArray.get(i);
	    
	    if( (String)jsonTmp.get("price") == null ) continue;
	    if( (String)jsonTmp.get("enuri_img") == null ) continue;
	    if( (String)jsonTmp.get("category") == null ) continue;
	    
	    String modelno = StringUtils.defaultString((String)jsonTmp.get("modelno"),"");
	    if( modelno.equals("18832714") ) continue;
	    
	    String categorySubstr = StringUtils.substring((String)jsonTmp.get("category"), 0 , 2) ;
	    String category = (String)jsonTmp.get("category");
	    
	    if(categorySubstr.equals("08")) continue;
	    if(categorySubstr.equals("14")) continue;
	    
	    if(category.equals("0304")) continue; 
	    if(category.equals("0709")) continue;
		if(category.equals("0305")) continue;
		if(category.equals("0318")) continue;
	    
	    int mallCnt = Integer.parseInt((String)jsonTmp.get("mallcnt"));
	    if(mallCnt <= 1) continue;
	    
	    jSONArrayTmp.add(jsonTmp);
    }
    //System.out.println("size:"+jSONArrayTmp.size());
    int size = jSONArrayTmp.size();
    JSONArray jsonCpp1 =  cpp1Read();
    //jsonCpp1.toJSONString();
    
    Collections.shuffle(jsonCpp1);
    
    if(size <= 18){
    	if(jsonCpp1.size() > 0){
    		for(int i= 0 ; i < jsonCpp1.size();i++){
    			
    			JSONObject jsonTmp =  (JSONObject)jsonCpp1.get(i);
    			String category = StringUtils.defaultString((String)jsonTmp.get("category"));
    			String part = StringUtils.defaultString((String)jsonTmp.get("part"));
    			
    			category = StringUtils.substring(category, 0,4); 
    			
    		    if(category.equals("0304")) continue; 
    		    if(category.equals("0709")) continue;
    			if(category.equals("0305")) continue;
    			if(category.equals("0318")) continue;
    			
    			jSONArrayTmp.add(jsonTmp);
    			if(i == 20) break;
    			//jSONArrayTmp.add((JSONObject));	
    		}
    	}
    }
    
    String callback = StringUtils.defaultString(request.getParameter("callback"));
	StringBuilder  uplusHtml = new StringBuilder();
	uplusHtml.append("<link rel='stylesheet' type='text/css' href='http://imgenuri.enuri.gscdn.com/images/mobilefirst/css/enuri_new_up.css?v=20180327'>");

				uplusHtml.append("<h2>가격비교</h2>");
				uplusHtml.append("<ul class='enuri_mall'>");
				    int goodscnt = 0;
				    for(int i = 0  ; i < jSONArrayTmp.size(); i++ ){
				        JSONObject jsonTmp =  (JSONObject)jSONArrayTmp.get(i);
				        
				        String modelno = (String)jsonTmp.get("modelno");
				        String modelnm = (String)jsonTmp.get("modelnm");
				        String enuri_img = StringUtils.defaultString((String)jsonTmp.get("enuri_img"),"");
				        
				        if(enuri_img == "")	enuri_img = StringUtils.defaultString((String)jsonTmp.get("img"),"");
				        
				        String shopcode = (String)jsonTmp.get("shopcode");
				        String pl_no = (String)jsonTmp.get("pl_no");
				        String category = (String)jsonTmp.get("category");
				        String img = StringUtils.defaultString((String)jsonTmp.get("img"),"");
				        
				        //if( category.equals("0304") || category.equals("0709") || category.equals("0305") || category.equals("0318") ) {
				        //	continue;
				        //}else{
						goodscnt++;
				        //}
				        
				        String price = StringUtils.defaultString((String)jsonTmp.get("price"),"0");
				        int priceInt = Integer.parseInt(price);
				            price = String.format("%,d", priceInt);
				        
				        enuri_img = StringUtils.replace(enuri_img , "http://photo3.enuri.com/" , "http://photo3.enuri.gscdn.com/");
				        
						uplusHtml.append("<li data-id='"+modelno+"' data-code='"+shopcode+"' data-no='"+pl_no+"'>");
							uplusHtml.append("<a href='javascript:;' class='enuri_list'>");
							uplusHtml.append("<span class='img'><img src='"+enuri_img+"' alt='"+modelnm+"'></span>");
							  uplusHtml.append("<strong class='title'>"+modelnm+"</strong>");
							uplusHtml.append("<span class='low'><em>에누리가</em><strong>"+price+"</strong>원</span>");
							uplusHtml.append("</a>");
						uplusHtml.append("<a href='javascript:;' class='list_go'><b>가격비교</b>("+(String)jsonTmp.get("mallcnt")+")</a>");
						uplusHtml.append("</li>");
						
						if(goodscnt == 18) break;
						//if(i == 11) break;
	               }
	               uplusHtml.append("</ul>");
    uplusHtml.append("<script type='text/javascript' src='http://imgenuri.enuri.gscdn.com/images/mobilefirst/js/uplusList.js'></script>");
    //uplusHtml.append("<script type='text/javascript' src='http://dev.enuri.com/mobilefirst/js/uplusList.js'></script>");
	JSONObject jSONObject = new JSONObject(); 
	jSONObject.put("uplusGoodsList",uplusHtml.toString());
	
	if(!callback.equals("")){
	   out.println(callback+"("+jSONObject.toString()+")");
	}
%>
<%!
	private JSONArray cpp1Read(){
		
		JSONArray jSONArray = new JSONArray();
	
		StringBuilder sbJson = new StringBuilder(); 
	    //FileReader fr = new FileReader("/mobilefirst/api/main/mobile_mainlistfix.json"); 
	    
	    String filepath = "/was/lena/1.3/depot/lena-application/ROOT/mobilefirst/http/json/cppJson1.json";
		try{
		    FileInputStream fis = new FileInputStream(new File(filepath)); 
		    InputStreamReader isr = new InputStreamReader(fis,"UTF-8"); 
		    BufferedReader br = new BufferedReader(isr);    
		
		    while(true){
		        String str = br.readLine();
		        if(str==null) break;
		        sbJson.append(str);
		    }
		}catch(Exception e){
		    e.printStackTrace();
		}
		
		try{
			org.json.simple.parser.JSONParser jSONParser = new org.json.simple.parser.JSONParser();  
		    
		    JSONObject jsonObject = (JSONObject) jSONParser.parse(sbJson.toString());
		    jSONArray = (JSONArray)jsonObject.get("cppList");
		    
		}catch(Exception e){}
				
		return jSONArray;
	}
%>
<%!
	public static JSONArray shuffleJsonArray (JSONArray array)  {

	        Random rnd = new Random();
	        for (int i = array.size() - 1; i >= 0; i--)
	        {
	          int j = rnd.nextInt(i + 1);
	          // Simple swap
	          Object object = array.get(j);
	          array.add(j, array.get(i));
	          array.add(i, object);
	        }
	    return array;
	}
%>
<%!
	private boolean valideIp(String strIp){
		boolean bReturn = false;
		String[] astrAcceptIp = {"112.175.191.131",
								 "112.175.191.147",
								 "112.175.191.157",
								 "112.175.191.174",
								 "112.175.191.175",
								 "112.175.191.179",
								 "112.175.191.186",
								 "112.175.191.187",
								 "121.189.40.130",
								 "121.170.135.148"
								 };
		
        for (int i=0;i<astrAcceptIp.length;i++){
            if(strIp.indexOf(astrAcceptIp[i]) >= 0 ){ 
                bReturn = true;
            }
        }
        return bReturn;
	}
%>
