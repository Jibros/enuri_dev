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
int pagesize= 100;//갯수
int limitDay = 30; 
JSONArray cateNewsJson = new JSONArray();
JSONObject[] kbCategoryJson = new JSONObject[5];
ArrKbCategory[cateIdx] = CateParser("02,03,24,05,06,22"); 
kbCategoryJson[cateIdx] = shopping_guide_proc.getNews(ArrKbCategory[cateIdx],"kb_no","desc",limitDay,pagesize); 
kbCategoryJson[cateIdx].put("category_name","디지털/가전");
kbCategoryJson[cateIdx].put("tip_no","01");

ArrKbCategory[++cateIdx] = CateParser("04,07");
kbCategoryJson[cateIdx] = shopping_guide_proc.getNews(ArrKbCategory[cateIdx],"kb_no","desc",limitDay,pagesize); 
kbCategoryJson[cateIdx].put("category_name","컴퓨터");
kbCategoryJson[cateIdx].put("tip_no","02");

ArrKbCategory[++cateIdx] = CateParser("21,09");
kbCategoryJson[cateIdx] = shopping_guide_proc.getNews(ArrKbCategory[cateIdx],"kb_no","desc",limitDay,pagesize); 
kbCategoryJson[cateIdx].put("category_name","스포츠/자동차");
kbCategoryJson[cateIdx].put("tip_no","03");

ArrKbCategory[++cateIdx] = CateParser("08,10,12,14,15,16,18,24");
kbCategoryJson[cateIdx] = shopping_guide_proc.getNews(ArrKbCategory[cateIdx],"kb_no","desc",limitDay,pagesize); 
kbCategoryJson[cateIdx].put("category_name","유아/라이프");
kbCategoryJson[cateIdx].put("tip_no","04");

/* ArrKbCategory[++cateIdx] = CateParser("14,08");
kbCategoryJson[cateIdx] = shopping_guide_proc.getNews(ArrKbCategory[cateIdx],"kb_no","desc",limitDay); 
kbCategoryJson[cateIdx].put("category_name","패션/뷰티");
kbCategoryJson[cateIdx].put("tip_no","05"); */

for(int i=0;i<=cateIdx;i++){
	cateNewsJson.put(kbCategoryJson[i]);
}
jSONObject.put("category_tip", cateNewsJson);

out.println(jSONObject.toString());
%>

<%!  
public String[] CateParser(String strCateList){
    return strCateList.replaceAll(" ","").split(",");
}
%>  
