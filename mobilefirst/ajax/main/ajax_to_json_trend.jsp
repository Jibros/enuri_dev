<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@page import="com.enuri.bean.mobile.Trend_Proc"%>
<%@page import="com.enuri.bean.mobile.Trend_Data"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.json.*"%>
<% 

	Trend_Proc Trend_Proc = new Trend_Proc();
	
	Trend_Proc trend_Proc  = new Trend_Proc();   
	 
	JSONArray jsonSubjectArray		= trend_Proc.getSubjectList().getJSONArray("subjectList");
	JSONArray jsonGoodsArray			= trend_Proc.getGoodsList().getJSONArray("goodslist");
	JSONArray jsonKeywordArray		= trend_Proc.getKeywordsList().getJSONArray("keywordList");
	
	JSONArray jSONArray = new JSONArray(); 

	int _idx = 0;
	
	out.println("{ \"trend\":[");  
	 
    for(int i=0;i<jsonSubjectArray.length();i++){ 
        if(i>0) out.println(",\r\n");
         
        out.println("{");
          
        out.println(" \"subject_idx\":\""		+ jsonSubjectArray.getJSONObject(i).get("subject_idx").toString().trim() + "\"");
        out.println(",\"cate2\":\""				+ jsonSubjectArray.getJSONObject(i).get("ca_code").toString().trim() + "\"");
        out.println(",\"subject\":\""				+ jsonSubjectArray.getJSONObject(i).get("subject").toString().trim() + "\"");
        out.println(",\"subject_sub\":\""		+ jsonSubjectArray.getJSONObject(i).get("subject_sub").toString().trim() + "\"");
        out.println(",\"url\":\""					+ getMobileUrl(jsonSubjectArray.getJSONObject(i).get("url").toString().trim()) + "\"");
        out.println(",\"reg_date\":\""			+ jsonSubjectArray.getJSONObject(i).get("reg_date").toString().trim() + "\"");
        out.println(",\"rec_yn\":\""			+ jsonSubjectArray.getJSONObject(i).get("rec_yn").toString().trim() + "\"");
          
        for(int j=0;j<jsonGoodsArray.length();j++){
			if(jsonSubjectArray.getJSONObject(i).get("subject_idx").toString().trim().equals(jsonGoodsArray.getJSONObject(j).get("subject_idx").toString().trim())){
        		out.println(",\"ref_model_no\":\""		+ jsonGoodsArray.getJSONObject(j).get("ref_model_no").toString().trim() + "\"");
                out.println(",\"ref_modelnm\":\""		+ jsonGoodsArray.getJSONObject(j).get("ref_modelnm").toString().trim() + "\"");
                out.println(",\"ref_model_img\":\"http://storage.enuri.gscdn.com/Web_Storage/pic_upload/main/trand/"	+ jsonGoodsArray.getJSONObject(j).get("ref_model_img").toString().trim() + "\"");
                //out.println(",\"ref_model_img\":\"http://photo3.enuri.com/data/images/service/middle/11193000/11193082.jpg\"");
                out.println(",\"mallcnt3\":\""       		+ jsonGoodsArray.getJSONObject(j).get("mallcnt3").toString().trim() + "\"");
                out.println(",\"img_src\":\""				+ jsonGoodsArray.getJSONObject(j).get("imgsrc").toString().trim() + "\"");
                out.println(",\"minprice3\":\""			+ getMoneyStyle(jsonGoodsArray.getJSONObject(j).get("minprice3").toString().trim()) + "\"");
                out.println(",\"maxprice\":\""			+ getMoneyStyle(jsonGoodsArray.getJSONObject(j).get("maxprice").toString().trim()) + "\"");
                out.println(",\"ca_code\":\""			+ jsonGoodsArray.getJSONObject(j).get("ca_code").toString().trim().substring(0,4) + "\"");
                out.println(",\"c_name\":\""				+ jsonGoodsArray.getJSONObject(j).get("c_name").toString().trim() + "\"");
            } 
		} 
		 
        out.println(",\"keywordlist\": [");  
        
        _idx = 0;
         
        for(int j=0;j<jsonKeywordArray.length();j++){
        	 if(jsonSubjectArray.getJSONObject(i).get("subject_idx").toString().trim().equals(jsonKeywordArray.getJSONObject(j).get("subject_idx").toString().trim())){ 
        		if(_idx++ > 0) out.println(",\r\n");
                 
                out.println("{");
                out.println(" \"url\":\"" 					+ getMobileUrl(jsonKeywordArray.getJSONObject(j).get("url").toString().trim()) + "\"");
                out.println(",\"keywords\":\""			+ jsonKeywordArray.getJSONObject(j).get("keyword").toString().trim() + "\"");

                out.println("}");
            }            
        }
        out.println("]}");

	}
    out.println("]");
    out.println("}");
%>
<%!
private String getMoneyStyle(String strMoney){
    String strMoneyTemp = "";
    
    if(strMoney.length() > 3){
        strMoneyTemp = strMoney.substring(0,strMoney.length()-3);
        strMoney = "," + strMoney.substring(strMoney.length()-3,strMoney.length());

        strMoney = getMoneyStyle(strMoneyTemp) + strMoney;
    }
    
    return strMoney;
}
private String getMobileUrl(String strUrl){
    String strUrlTemp = "";
     
    if(strUrl.length() > 0){
    	strUrl = strUrl.replace("http://www.enuri.com/view/Listmp3.jsp", 								"/mobilefirst/list.jsp");
    	strUrl = strUrl.replace("http://www.enuri.com/view/Listbody_Mp3.jsp",						"/mobilefirst/list.jsp");
    	strUrl = strUrl.replace("http://www.enuri.com/view/List.jsp",									"/mobilefirst/list.jsp");
    	strUrl = strUrl.replace("http://www.enuri.com/fashion/brand/Clothes_Brand_List.jsp", 	"/mobilefirst/list.jsp");
    	strUrl = strUrl.replace("http://www.enuri.com/view/Listmp3.jsp", 								"/mobilefirst/list.jsp");
    	strUrl = strUrl.replace("http://www.enuri.com/view/Listmp3.jsp", 								"/mobilefirst/list.jsp");
    	strUrl = strUrl.replace("http://www.enuri.com/search/Searchlist.jsp", 						"/mobilefirst/search.jsp");
    	if(strUrl.indexOf("cate=") > -1 && strUrl.indexOf("&keyword=") > -1){
    		strUrl = strUrl.replace("&keyword=", 						"&in_keyword=");
    	}
    }
     
    return strUrl;
}
%>