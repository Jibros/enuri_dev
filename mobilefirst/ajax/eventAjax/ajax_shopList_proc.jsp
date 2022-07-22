<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>
<%
    
    JSONArray array = new JSONArray(); 
    JSONObject jsonObj = new JSONObject();
    
    jsonObj.put("title","#효도할게요");
    jsonObj.put("shopLink","/mobilefirst/planlist.jsp?t=B_20160823115900");
    jsonObj.put("imgSrc","http://imgenuri.enuri.gscdn.com/images/mobilefirst/event/shoplist/M_piety.jpg");
    jsonObj.put("subTitle","부모님 추석선물");
    array.put(jsonObj);
    
    jsonObj = new JSONObject();
    jsonObj.put("title","#실속선물");
    jsonObj.put("shopLink","/mobilefirst/planlist.jsp?t=B_20160822102600");
    jsonObj.put("imgSrc","http://imgenuri.enuri.gscdn.com/images/mobilefirst/event/shoplist/M_set.jpg");
    jsonObj.put("subTitle","1만원대 선물세트");
    array.put(jsonObj);
    
    jsonObj = new JSONObject();
    jsonObj.put("title","#명절상차림");
    jsonObj.put("shopLink","/mobilefirst/planlist.jsp?t=B_20160822060000");
    jsonObj.put("imgSrc","http://imgenuri.enuri.gscdn.com/images/mobilefirst/event/shoplist/M_table.jpg");
    jsonObj.put("subTitle","추석차례상 준비");
    array.put(jsonObj);
    
    jsonObj = new JSONObject();
    jsonObj.put("title","#풍요로운추석");
    jsonObj.put("shopLink","/mobilefirst/planlist.jsp?t=B_20160812061900");
    jsonObj.put("imgSrc","http://imgenuri.enuri.gscdn.com/images/mobilefirst/event/shoplist/M_rich.jpg");
    jsonObj.put("subTitle","신석식품 선물세트");
    array.put(jsonObj);
    
    jsonObj = new JSONObject();
    jsonObj.put("title","#선물세트가격");
    jsonObj.put("shopLink","/mobilefirst/planlist.jsp?t=B_20160812144900");
    jsonObj.put("imgSrc","http://imgenuri.enuri.gscdn.com/images/mobilefirst/event/shoplist/M_price.jpg");
    jsonObj.put("subTitle","가격대별 가공식품");
    array.put(jsonObj);

	
	out.println(shuffleJsonArray(array).toString());
	
%>
<%!
    public static JSONArray shuffleJsonArray (JSONArray array) throws JSONException {
        // Implementing Fisher–Yates shuffle
            Random rnd = new Random();
            for (int i = array.length() - 1; i >= 0; i--)
            {
              int j = rnd.nextInt(i + 1);
              // Simple swap
              Object object = array.get(j);
              array.put(j, array.get(i));
              array.put(i, object);
            }
        return array;
    }
%>
