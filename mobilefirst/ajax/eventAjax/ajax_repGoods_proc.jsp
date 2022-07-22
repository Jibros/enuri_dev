<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Mobile_Goods_Proc"%>
<%@page import="com.enuri.api.Pricelist_Api "%>
<%@page import="com.enuri.bean.main.Goods_Data"%>
<%@page import="com.enuri.bean.main.Pricelist_Data"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>
<%
//2677565 14242222 11522648 2688100
    JSONArray tableArray = new JSONArray();
    
    JSONObject map = new JSONObject();
    
    map = new JSONObject(); 
    map.put("modelno",2677565); //상차림    
    map.put("align","left"); 
    tableArray.put(map);
    
    map = new JSONObject(); 
    map.put("modelno",14242222); //상차림
    map.put("align","right");
    tableArray.put(map);
    
    map = new JSONObject(); 
    map.put("modelno",11522648); //상차림
    map.put("align","left");
    tableArray.put(map);

    map = new JSONObject(); 
    map.put("modelno",2688100); //상차림
    map.put("align","right");
    tableArray.put(map);

    JSONArray giftArray = new JSONArray();
//13005535 14242242 1596487 10350386     
    map = new JSONObject(); 
    map.put("modelno",13005535); //선물    
    map.put("align","left"); 
    giftArray.put(map);
    
    map = new JSONObject(); 
    map.put("modelno",14242242); //선물    
    map.put("align","right"); 
    giftArray.put(map);
    
    map = new JSONObject(); 
    map.put("modelno",10350386); //선물
    map.put("align","left");
    giftArray.put(map);
    
    map = new JSONObject(); 
    map.put("modelno",1596487); //선물    
    map.put("align","right"); 
    giftArray.put(map);

    JSONObject jSONObj = new JSONObject();

    Mobile_Goods_Proc mobile_Goods_Proc = new Mobile_Goods_Proc();
    
    Pricelist_Api pricelist_Api = new Pricelist_Api(); 
    
    Goods_Data goods_data = null;
    
    JSONArray array = new JSONArray();
    
    for(int i = 0 ; i < giftArray.length(); i++){
        
        JSONObject tmp =  (JSONObject) giftArray.get(i);
        int modelno = tmp.getInt("modelno") ;
        String align = tmp.getString("align") ;
        
        goods_data = new Goods_Data();
        goods_data = mobile_Goods_Proc.Goods_One_Top(modelno);
        
        //Pricelist_Data pricelist_data[] = pricelist_Api.getPricelistByModelNo(modelno,1); 
        
        if(goods_data.getMinprice() == 0 && goods_data.getMallcnt() == 0) continue;
        
        JSONObject jSONObject = new JSONObject();
        jSONObject.put("modelno",goods_data.getModelno());
        jSONObject.put("modelnm",goods_data.getModelnm());
        jSONObject.put("minprice",goods_data.getMinprice());
        jSONObject.put("factory",goods_data.getFactory());
        jSONObject.put("align",align);
        jSONObject.put("imgSrc","http://imgenuri.enuri.gscdn.com/images/mobilefirst/event/goods/m_"+modelno+".jpg");
        //jSONObject.put("url",pricelist_data[0].getUrl());
        //jSONObject.put("shopcode",pricelist_data[0].getShop_code());
        
        array.put(jSONObject);
            
    }
    jSONObj.put("gift",array);
    
    array = new JSONArray();
    for(int i = 0 ; i < tableArray.length(); i++){
        
        JSONObject tmp =  (JSONObject) tableArray.get(i);
        int modelno = tmp.getInt("modelno") ;
        String align = tmp.getString("align") ;
        
        goods_data = new Goods_Data();
        goods_data = mobile_Goods_Proc.Goods_One_Top(modelno);
        //Pricelist_Data pricelist_data[] = pricelist_Api.getPricelistByModelNo(modelno,1);
        
        
        if(goods_data.getMinprice() == 0 && goods_data.getMallcnt() == 0) continue;
        
        JSONObject jSONObject = new JSONObject();
        jSONObject.put("modelno",goods_data.getModelno());
        jSONObject.put("modelnm",goods_data.getModelnm());
        jSONObject.put("minprice",goods_data.getMinprice());
        jSONObject.put("factory",goods_data.getFactory());
        jSONObject.put("align",align);
        jSONObject.put("imgSrc","http://imgenuri.enuri.gscdn.com/images/mobilefirst/event/goods/m_"+modelno+".jpg");
        //jSONObject.put("url",pricelist_data[0].getUrl());
        //jSONObject.put("shopcode",pricelist_data[0].getShop_code());
        
        array.put(jSONObject);
    }
    jSONObj.put("table",array);
	
	out.println(jSONObj.toString());
	
%>