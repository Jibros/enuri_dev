<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*,java.text.*,java.net.*"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.simple.*"%>
<%@page import="java.io.*"%>
<%@page import="com.enuri.util.common.*"%>
<%
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
	    
	    String category = StringUtils.substring((String)jsonTmp.get("category"), 0 , 2) ;
	    if(category.equals("08")) continue;
	    if(category.equals("14")) continue;
	    
	    int mallCnt = Integer.parseInt((String)jsonTmp.get("mallcnt"));
	    if(mallCnt <= 1) continue;
	    
	    jSONArrayTmp.add(jsonTmp);
    }
    
    String callback = StringUtils.defaultString(request.getParameter("callback"));
	StringBuilder  uplusHtml = new StringBuilder();
	uplusHtml.append("<link rel='stylesheet' type='text/css' href='http://imgenuri.enuri.gscdn.com/images/mobilefirst/css/enuri_up.css'>");

				uplusHtml.append("<h2>가격비교</h2>");
				uplusHtml.append("<ul class='enuri_mall'>");
				    int goodscnt = 0;
				    for(int i = 0  ; i < jSONArrayTmp.size(); i++ ){
				        JSONObject jsonTmp =  (JSONObject)jSONArrayTmp.get(i);
				        
				        String modelno = (String)jsonTmp.get("modelno");
				        String modelnm = (String)jsonTmp.get("modelnm");
				        String enuri_img = (String)jsonTmp.get("enuri_img");
				        String shopcode = (String)jsonTmp.get("shopcode");
				        String pl_no = (String)jsonTmp.get("pl_no");
				        String category = (String)jsonTmp.get("category");
				        
				        String img = (String)jsonTmp.get("img");
				        
				        if( category.equals("0304") || category.equals("0709") || category.equals("0305") || category.equals("0318") ) {
				        	continue;
				        }else{
				        	goodscnt++;
				        }
				        
				        String price = (String)jsonTmp.get("price");
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
						
						if(goodscnt == 12) break;
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