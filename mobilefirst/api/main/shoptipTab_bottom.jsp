<%@page import="com.enuri.bean.mobile.News_Proc"%>
<%@page import="java.io.IOException"%>
<%@page import="java.net.MalformedURLException"%>
<%@page import="java.io.UnsupportedEncodingException"%>
<%@page import="java.net.URL"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="com.enuri.exception.ExceptionManager"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@page import="com.enuri.bean.mobile.Shopping_Guide_Proc"%>
<%@page import="java.util.*"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>

<%
String type = request.getParameter("type");
JSONObject jSONObject = new JSONObject();
Shopping_Guide_Proc shopping_guide_proc = new Shopping_Guide_Proc();

//5개의 대표카테고리
String[][] ArrKbCategory = new String[5][]; 
int cateIdx = 0;
int pagesize= 3;//갯수
JSONArray cateShoppingGuideJson = new JSONArray();
JSONObject[] kbCategoryJson = new JSONObject[5];

ArrKbCategory[cateIdx] = CateParser("14,08");
kbCategoryJson[cateIdx] = shopping_guide_proc.getShoppingGuide_cate(pagesize,ArrKbCategory[cateIdx],"guide_date","desc"); 
kbCategoryJson[cateIdx].put("category_name","패션/뷰티");
kbCategoryJson[cateIdx].put("tip_no","01");

ArrKbCategory[++cateIdx] = CateParser("12,10,15,18,16,93,95");
kbCategoryJson[cateIdx] = shopping_guide_proc.getShoppingGuide_cate(pagesize,ArrKbCategory[cateIdx],"guide_date","desc"); 
kbCategoryJson[cateIdx].put("category_name","유아/라이프");
kbCategoryJson[cateIdx].put("tip_no","02");

ArrKbCategory[++cateIdx] = CateParser("02,03,24,05,06,22"); 
kbCategoryJson[cateIdx] = shopping_guide_proc.getShoppingGuide_cate(pagesize,ArrKbCategory[cateIdx],"guide_date","desc"); 
kbCategoryJson[cateIdx].put("category_name","디지털/가전");
kbCategoryJson[cateIdx].put("tip_no","03");

ArrKbCategory[++cateIdx] = CateParser("21,09");
kbCategoryJson[cateIdx] = shopping_guide_proc.getShoppingGuide_cate(pagesize,ArrKbCategory[cateIdx],"guide_date","desc"); 
kbCategoryJson[cateIdx].put("category_name","스포츠/자동차");
kbCategoryJson[cateIdx].put("tip_no","04");

ArrKbCategory[++cateIdx] = CateParser("04,07");
kbCategoryJson[cateIdx] = shopping_guide_proc.getShoppingGuide_cate(pagesize,ArrKbCategory[cateIdx],"guide_date","desc"); 
kbCategoryJson[cateIdx].put("category_name","컴퓨터");
kbCategoryJson[cateIdx].put("tip_no","05");

for(int i=0;i<=cateIdx;i++){
	cateShoppingGuideJson.put(kbCategoryJson[i]);
}
jSONObject.put("category_tip", cateShoppingGuideJson);


String tabAdminUrl = "http://m.enuri.com/mobilefirst/api/main/shoptipTab_admin.json";
JSONObject tabAdminJson = jsonUrlParsing(tabAdminUrl);

JSONArray jSONArray = tabAdminJson.getJSONArray("weekly_push");
JSONArray jSONArrayTemp = new JSONArray(); 

News_Proc news_Proc = new News_Proc();

for (int i = 0; i < jSONArray.length(); i++) {
	
	JSONObject weekly = jSONArray.getJSONObject(i);
	int kbno = weekly.getInt("kbno");
	
	JSONObject jsonObject = (JSONObject) news_Proc.getData_Kbno(kbno);
	JSONArray array = jsonObject.getJSONArray("NewsDetail");
	
	if(array.length() > 0){
		jSONArrayTemp.put(weekly);	
	}
}
tabAdminJson.put("weekly_push",jSONArrayTemp);
tabAdminJson.put("category_tip", jSONObject.get("category_tip"));
out.println(tabAdminJson.toString());
%>

<%!  
public String[] CateParser(String strCateList){
    return strCateList.replaceAll(" ","").split(",");
}
%> 
<%!
private JSONObject jsonUrlParsing(String strUrl) throws UnsupportedEncodingException, MalformedURLException, IOException, JSONException{
    
	BufferedReader br = new BufferedReader(new InputStreamReader((new URL(strUrl)).openConnection().getInputStream(),"UTF-8"));
	StringBuilder sbJson = new StringBuilder();
	String strLine = "";
	    
	JSONObject jSONObject = new JSONObject();
	
	while ((strLine = br.readLine()) != null){
	   	sbJson.append(strLine);
	}
	br.close();
	
	if(sbJson != null){
		jSONObject = new JSONObject(sbJson.toString());
		return jSONObject;
	}
	return jSONObject ;
}
%>
