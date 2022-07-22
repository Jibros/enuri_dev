<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Trend_Proc"%>
<%@page import="com.enuri.bean.mobile.Trend_Data"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.json.*"%>
<% 

	String strCa_code= ChkNull.chkStr(request.getParameter("ca_code"),"");	 
	
	Trend_Proc trend_Proc  = new Trend_Proc();   
	  
	JSONArray jsonSubjectArray		= trend_Proc.getSubjectList_2016(strCa_code).getJSONArray("subjectList");
	JSONArray jsonGoodsArray			= trend_Proc.getGoodsList2().getJSONArray("goodslist");
	JSONArray jsonKeywordArray		= trend_Proc.getKeywordsList().getJSONArray("keywordList");
	
	JSONArray jSONArray = new JSONArray();  

	int _idx = 0;
	boolean bList1 = false;
	int subCnt = 0;
	
	out.println("{");

    //앱에서 동적으로 탭 사용하기 위해 설정
    out.println("\"topcate\":[{\"title\":\"전체\",\"url\":\"/http/json/getTrend_list.json\"},{\"title\":\"컴퓨터,디지털\",\"url\": \"/http/json/getTrend_list_01.json\"},{\"title\":\"영상,가전\",\"url\": \"/http/json/getTrend_list_02.json\"},{\"title\":\"가구,리빙,FOOD\",\"url\": \"/http/json/getTrend_list_03.json\"},{\"title\":\"유아,스포츠,패션\",\"url\": \"/http/json/getTrend_list_04.json\"}]");
    //////////
    out.println(" ,\"trend\":[");  
	 
    for(int i=0;i<jsonSubjectArray.length();i++){ 
        if(i>0) out.println(",\r\n");
         
        out.println("{");
          
        out.println(" \"subject_idx\":\""		+ jsonSubjectArray.getJSONObject(i).get("subject_idx").toString().trim() + "\"");
        out.println(",\"cate2\":\""				+ jsonSubjectArray.getJSONObject(i).get("ca_code").toString().trim() + "\"");
        out.println(",\"subject\":\""				+ toJS2(jsonSubjectArray.getJSONObject(i).get("subject").toString().trim()) + "\"");
        out.println(",\"subject_sub\":\""		+ toJS2(jsonSubjectArray.getJSONObject(i).get("subject_sub").toString().trim()) + "\"");
        out.println(",\"url\":\""					+ getMobileUrl(jsonSubjectArray.getJSONObject(i).get("url").toString().trim()) + "\"");
        out.println(",\"reg_date\":\""			+ jsonSubjectArray.getJSONObject(i).get("reg_date").toString().trim() + "\"");
        out.println(",\"rec_yn\":\""			+ jsonSubjectArray.getJSONObject(i).get("rec_yn").toString().trim() + "\"");
        out.println(",\"img_nm\":\""			+ toJS2(jsonSubjectArray.getJSONObject(i).get("img_nm").toString().trim()) + "\"");
        out.println(",\"bg_color\":\""			+ jsonSubjectArray.getJSONObject(i).get("bg_color").toString().trim() + "\"");
        out.println(",\"link\":\""			+ jsonSubjectArray.getJSONObject(i).get("link").toString().trim() + "\"");
        out.println(",\"start_dt\":\""			+ jsonSubjectArray.getJSONObject(i).get("start_dt").toString().trim() + "\"");
        out.println(",\"end_dt\":\""			+ jsonSubjectArray.getJSONObject(i).get("end_dt").toString().trim() + "\"");
        out.println(",\"mobile_yn\":\""			+ jsonSubjectArray.getJSONObject(i).get("mobile_yn").toString().trim() + "\"");
          
        for(int j=0;j<jsonGoodsArray.length();j++){
    		if(jsonSubjectArray.getJSONObject(i).get("subject_idx").toString().trim().equals(jsonGoodsArray.getJSONObject(j).get("subject_idx").toString().trim())){
    			if(!jsonGoodsArray.getJSONObject(j).get("ref_model_img").toString().trim().equals("") && Integer.parseInt(jsonGoodsArray.getJSONObject(j).get("mallcnt3").toString()) > 0){
    				bList1 = true;
    			}
    			if(bList1 && subCnt <3){ 
    				if(subCnt == 0){ 
	    				out.println(" ,\"ref_model_no\":\""		+ jsonGoodsArray.getJSONObject(j).get("ref_model_no").toString().trim() + "\"");
			            out.println(" ,\"ref_modelnm\":\""		+ toJS2(jsonGoodsArray.getJSONObject(j).get("ref_modelnm").toString().trim()) + "\"");
			            out.println(" ,\"ref_model_img\":\"http://storage.enuri.gscdn.com/Web_Storage/pic_upload/main/trand/"	+ jsonGoodsArray.getJSONObject(j).get("ref_model_img").toString().trim() + "\"");
			            out.println(" ,\"mallcnt3\":\""       		+ jsonGoodsArray.getJSONObject(j).get("mallcnt3").toString().trim() + "\"");
			            out.println(" ,\"img_src\":\""				+ jsonGoodsArray.getJSONObject(j).get("imgsrc").toString().trim() + "\"");
			            out.println(" ,\"minprice3\":\""			+ getMoneyStyle(jsonGoodsArray.getJSONObject(j).get("minprice3").toString().trim()) + "\"");
			            out.println(" ,\"maxprice\":\""			+ getMoneyStyle(jsonGoodsArray.getJSONObject(j).get("maxprice").toString().trim()) + "\"");
			            out.println(" ,\"ca_code\":\""			+ jsonGoodsArray.getJSONObject(j).get("ca_code").toString().trim().substring(0,4) + "\"");
			            out.println(" ,\"c_name\":\""				+ toJS2(jsonGoodsArray.getJSONObject(j).get("c_name").toString().trim()) + "\"");
			            out.println(" ,\"mobile_url\":\""				+ toJS2(jsonGoodsArray.getJSONObject(j).get("mobile_url").toString().trim()) + "\"");
    				}else{
        				if(subCnt == 1){
        					out.println(",\"sublist\": [");  
        				}else{ 
        					 out.println(",");
        				}
	    				out.println("	{ \"ref_model_no\":\""		+ jsonGoodsArray.getJSONObject(j).get("ref_model_no").toString().trim() + "\"");
			            out.println("	,\"ref_modelnm\":\""		+ toJS2(jsonGoodsArray.getJSONObject(j).get("ref_modelnm").toString().trim()) + "\"");
			            out.println("	,\"mallcnt3\":\""       		+ jsonGoodsArray.getJSONObject(j).get("mallcnt3").toString().trim() + "\"");
			            out.println("	,\"img_src\":\""				+ jsonGoodsArray.getJSONObject(j).get("imgsrc").toString().trim() + "\"");
			            out.println("	,\"minprice3\":\""			+ getMoneyStyle(jsonGoodsArray.getJSONObject(j).get("minprice3").toString().trim()) + "\"");
			            out.println("  ,\"mobile_url\":\""				+ toJS2(jsonGoodsArray.getJSONObject(j).get("mobile_url").toString().trim()) + "\"");
			            out.println(" }");
			            if(subCnt == 2){
        					out.println(" ] ");
        				}    					
    				}
		            subCnt = subCnt + 1;
    			}
    		}else{
    			bList1 = false;
    			subCnt = 0;
    		}
        }  
        
        out.println(",\"keywordlist\": [");  
        
        _idx = 0;
        
        for(int j=0;j<jsonKeywordArray.length();j++){
        	 if(jsonSubjectArray.getJSONObject(i).get("subject_idx").toString().trim().equals(jsonKeywordArray.getJSONObject(j).get("subject_idx").toString().trim())){ 
        		if(_idx++ > 0) out.println(",\r\n");
                 
                out.println("{");
                out.println(" \"url\":\"" 					+ getMobileUrl(jsonKeywordArray.getJSONObject(j).get("url").toString().trim()) + "\"");
                out.println(",\"keywords\":\""			+ toJS2(jsonKeywordArray.getJSONObject(j).get("keyword").toString().trim()) + "\"");

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