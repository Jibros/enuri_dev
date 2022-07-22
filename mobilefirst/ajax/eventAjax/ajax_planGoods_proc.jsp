<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.mobile.Mobile_Today_Data"%>
<%@ page import="com.enuri.bean.mobile.Mobile_Today_Proc"%>
<%@ include file="/include/IncGroupTool_2010.jsp"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>
<%
	String type=StringUtils.defaultString(request.getParameter("type"));
	
	Mobile_Today_Proc mobile_today_proc = new Mobile_Today_Proc(); 
    Mobile_Today_Data plan_goods_data[] =  mobile_today_proc.getPlanList("B", "2016081282115");
	                                                                                                           
	JSONObject jSONObject = new JSONObject();
	JSONArray  array = new JSONArray();
	JSONArray  arrayGift = new JSONArray();
	
	String todayId = "B_2016081282115";
	
	int cnt = 0;
	String partNo = "0";
	
	if(plan_goods_data != null){
	    
	    for (int i = 0 ; i < plan_goods_data.length; i++ ){
	                String strImageUrl = ImageUtil.getImageSrc(CutStr.cutStr(plan_goods_data[i].getCa_code(),4), plan_goods_data[i].getModelno(), plan_goods_data[i].getImgchk(), plan_goods_data[i].getP_pl_no(), plan_goods_data[i].getP_imgurl(), plan_goods_data[i].getP_imgurlflag());
	        
	                String strImageUrl_middle = strImageUrl;
	 
	                String smallImgUrlFinder = "/data/images/service/small/";
	                int smallFinderIdx = strImageUrl.indexOf(smallImgUrlFinder);
	                // 500이미지로 변경
	                if(smallFinderIdx>-1) {
	                    strImageUrl_middle = strImageUrl.substring(0, smallFinderIdx);
	                    strImageUrl_middle += "/data/images/service/middle/";
	                    strImageUrl_middle += strImageUrl.substring(smallFinderIdx + smallImgUrlFinder.length());
	
	                    int lastDotIdx = strImageUrl_middle.lastIndexOf(".");
	                    strImageUrl_middle = strImageUrl_middle.substring(0, lastDotIdx) + ".jpg";
	                }
	
	                String strKeyword2 = plan_goods_data[i].getKeyword2();
	                strKeyword2 = ReplaceStr.replace(strKeyword2,"★","");
	                strKeyword2 = ReplaceStr.replace(strKeyword2,"▶","");
	                strKeyword2 = ReplaceStr.replace(strKeyword2,"\"","&quot;");
	                String strFactory = plan_goods_data[i].getFactory();
	                String strBrand = plan_goods_data[i].getBrand();
	                String strModelName = ChkNull.chkStr(plan_goods_data[i].getModelnm()," "); 
	                
	                String strModelnmText[] = getModel_FBN(plan_goods_data[i].getCa_code(), strModelName, strFactory, strBrand);
	                
	                if (strFactory.trim().equals("[불명]") || strFactory.trim().equals("없음")){
	                    strFactory = "&nbsp;";
	                }            
	         
	                jSONObject = new JSONObject();
                    jSONObject.put("partNo",plan_goods_data[i].getPart_no());
	                jSONObject.put("img",strImageUrl_middle);
	                jSONObject.put("modelno",plan_goods_data[i].getModelno());
	                jSONObject.put("title",toJS2(strModelnmText[1] + " "+ strModelnmText[2] + " "+ strModelnmText[0]));
	                jSONObject.put("minprice",plan_goods_data[i].getMinprice3());
	                jSONObject.put("type",type);
	                jSONObject.put("strKeyword2",strKeyword2);
	                
	                if(plan_goods_data[i].getPart_no().equals(partNo)){
	                   jSONObject.put("titleSrc","");
	                   
	                }else{
	                   String imgSrc = "http://img.enuri.info/images/mobilefirst/planlist/"+todayId+"/"+todayId+"_txt"+plan_goods_data[i].getPart_no()+".png";
                       jSONObject.put("titleSrc",imgSrc);
	                }
	                
	                array.put(jSONObject);
	                
	                partNo = plan_goods_data[i].getPart_no();
	                
	    }
	
	}
	
	
	Mobile_Today_Data plan_goods_data2[] =  mobile_today_proc.getPlanList("B", "2016081182115");
	
	todayId = "B_2016081182115";
	
	if(plan_goods_data2 != null){
        
        for (int i = 0 ; i < plan_goods_data2.length; i++ ){
                    String strImageUrl = ImageUtil.getImageSrc(CutStr.cutStr(plan_goods_data2[i].getCa_code(),4), plan_goods_data2[i].getModelno(), plan_goods_data2[i].getImgchk(), plan_goods_data2[i].getP_pl_no(), plan_goods_data2[i].getP_imgurl(), plan_goods_data2[i].getP_imgurlflag());
            
                    String strImageUrl_middle = strImageUrl;
     
                    String smallImgUrlFinder = "/data/images/service/small/";
                    int smallFinderIdx = strImageUrl.indexOf(smallImgUrlFinder);
                    // 500이미지로 변경
                    if(smallFinderIdx>-1) {
                        strImageUrl_middle = strImageUrl.substring(0, smallFinderIdx);
                        strImageUrl_middle += "/data/images/service/middle/";
                        strImageUrl_middle += strImageUrl.substring(smallFinderIdx + smallImgUrlFinder.length());
    
                        int lastDotIdx = strImageUrl_middle.lastIndexOf(".");
                        strImageUrl_middle = strImageUrl_middle.substring(0, lastDotIdx) + ".jpg";
                    }
    
                    String strKeyword2 = plan_goods_data2[i].getKeyword2();
                    strKeyword2 = ReplaceStr.replace(strKeyword2,"★","");
                    strKeyword2 = ReplaceStr.replace(strKeyword2,"▶","");
                    strKeyword2 = ReplaceStr.replace(strKeyword2,"\"","&quot;");
                    String strFactory = plan_goods_data2[i].getFactory();
                    String strBrand = plan_goods_data2[i].getBrand();
                    String strModelName = ChkNull.chkStr(plan_goods_data2[i].getModelnm()," "); 
                    
                    String strModelnmText[] = getModel_FBN(plan_goods_data2[i].getCa_code(), strModelName, strFactory, strBrand);
                    
                    if (strFactory.trim().equals("[불명]") || strFactory.trim().equals("없음")){
                        strFactory = "&nbsp;";
                    }            
             
                    jSONObject = new JSONObject();
                    jSONObject.put("partNo",plan_goods_data2[i].getPart_no());                    
                    jSONObject.put("img",strImageUrl_middle);
                    jSONObject.put("modelno",plan_goods_data2[i].getModelno());
                    jSONObject.put("title",toJS2(strModelnmText[1] + " "+ strModelnmText[2] + " "+ strModelnmText[0]));
                    jSONObject.put("minprice",plan_goods_data2[i].getMinprice3());
                    jSONObject.put("type",type);
                    jSONObject.put("strKeyword2",strKeyword2);
                    
                    if(plan_goods_data2[i].getPart_no().equals(partNo)){
                       jSONObject.put("titleSrc","");
                       
                    }else{
                       String imgSrc = "http://img.enuri.info/images/mobilefirst/planlist/"+todayId+"/"+todayId+"_txt"+plan_goods_data2[i].getPart_no()+".png";
                       jSONObject.put("titleSrc",imgSrc);
                    }
                    
                    arrayGift.put(jSONObject);
                    
                    partNo = plan_goods_data2[i].getPart_no();
                    
        }
    
    }
	
	JSONObject jSONData = new JSONObject();
	
	if(array.length() > 0){
	
		if(type.equals("A")){
	        
	        JSONArray jSONArray = new JSONArray();
	        array = shuffleJsonArray(array);
	        
	        JSONArray jSONArray2 = new JSONArray();
            arrayGift = shuffleJsonArray(arrayGift);
		     
		    for(int i = 0 ; i < 10; i++ ){
		       jSONArray.put(array.get(i));
		       jSONArray2.put(arrayGift.get(i));
		    }
		    jSONData.put("present", jSONArray);
	        jSONData.put("setTable",jSONArray2);
		}else{
		   jSONData.put("present",array);
	       jSONData.put("setTable",arrayGift);
		}
	
	}
	out.println(jSONData.toString());
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
