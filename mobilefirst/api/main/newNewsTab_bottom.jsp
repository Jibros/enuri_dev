<%@page import="com.enuri.bean.knowbox.Knowcom_Proc"%>
<%@page import="com.enuri.exception.ExceptionManager"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@page import="com.enuri.bean.mobile.Shopping_Guide_Proc"%>
<%@page import="java.util.*"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>
<%
String topNews = StringUtils.defaultString(request.getParameter("topNews"));

JSONObject jSONObject = new JSONObject();
//String[] notInnewsArray ;
ArrayList notInnewsArray = new ArrayList();

Shopping_Guide_Proc shopping_guide_proc = new Shopping_Guide_Proc();

//2017 08 07 뉴 뉴스 텝 리뉴얼
HashMap<String, String> paramMap = new HashMap<String, String>();
paramMap.put("bigCate", "");
paramMap.put("midCate", "");
paramMap.put("searchStr", "");
paramMap.put("searchCate", "Title");
paramMap.put("startNo", "1");
paramMap.put("endNo", "5");
paramMap.put("kk_code", "");
paramMap.put("startdate", "");
paramMap.put("enddate", "");
paramMap.put("thumbnailCheck", "yes");
paramMap.put("exclude_yn", "Y");

JSONObject newsBottomJson2  = shopping_guide_proc.getNewsList(paramMap);//메인뉴스_하단

JSONArray  newsjSONArray = newsBottomJson2.getJSONArray("resultList");

JSONArray newsjSONArrayTemp = new JSONArray();
for(int i= 0; i < newsjSONArray.length() ; i++){

	JSONObject jSONObjectTemp = newsjSONArray.getJSONObject(i);
	jSONObjectTemp.put("name", jSONObjectTemp.get("kb_title"));
	jSONObjectTemp.put("kbno", jSONObjectTemp.get("kb_no"));
	jSONObjectTemp.put("url", "/mobilefirst/news_detail.jsp?kbno="+jSONObjectTemp.get("kb_no")+"&freetoken=news");

	newsjSONArrayTemp.put(jSONObjectTemp);
	notInnewsArray.add((String)jSONObjectTemp.get("kb_no"));

}
if(topNews != null && !topNews.equals("")){

	String[] topNewsArray = StringUtils.split(topNews,"|");
	for(int i = 0 ; i < topNewsArray.length ; i ++ ){
		notInnewsArray.add(topNewsArray[i]);
	}
}

//5개의 대표카테고리
String[][] ArrKbCategory = new String[5][];
int cateIdx = 0;
int pagesize2= 100;//갯수

JSONArray cateNewsJson = new JSONArray();
JSONObject[] kbCategoryJson = new JSONObject[5];
ArrKbCategory[cateIdx] = CateParser("02,03,24,05,06,22");
//new news
kbCategoryJson[cateIdx] = shopping_guide_proc.getNews_cate(pagesize2,ArrKbCategory[cateIdx],"kb_regdate","desc",notInnewsArray);
kbCategoryJson[cateIdx].put("category_name","디지털/가전");
kbCategoryJson[cateIdx].put("tip_no","01");

ArrKbCategory[++cateIdx] = CateParser("04,07");
//new news
kbCategoryJson[cateIdx] = shopping_guide_proc.getNews_cate(pagesize2,ArrKbCategory[cateIdx],"kb_regdate","desc",notInnewsArray);
kbCategoryJson[cateIdx].put("category_name","컴퓨터");
kbCategoryJson[cateIdx].put("tip_no","02");


ArrKbCategory[++cateIdx] = CateParser("21,09");
//new news
kbCategoryJson[cateIdx] = shopping_guide_proc.getNews_cate(pagesize2,ArrKbCategory[cateIdx],"kb_regdate","desc",notInnewsArray);
kbCategoryJson[cateIdx].put("category_name","스포츠/자동차");
kbCategoryJson[cateIdx].put("tip_no","03");


ArrKbCategory[++cateIdx] = CateParser("08,10,12,14,15,16,18");
//new news
kbCategoryJson[cateIdx] = shopping_guide_proc.getNews_cate(pagesize2,ArrKbCategory[cateIdx],"kb_regdate","desc",notInnewsArray);
kbCategoryJson[cateIdx].put("category_name","유아/라이프");
kbCategoryJson[cateIdx].put("tip_no","04");


for(int i=0;i<=cateIdx;i++){
	cateNewsJson.put(kbCategoryJson[i]);
}
jSONObject.put("category_tip", cateNewsJson);
jSONObject.put("newsTab_bottom", newsjSONArrayTemp);

Knowcom_Proc knowcomProc = new Knowcom_Proc();
jSONObject.put("today_hop_clip", knowcomProc.getKnowboxListCertain("news", new String[] {"26", "27", "29"}, 10, false, true, true, 2).getJSONArray("list"));

out.println(jSONObject.toString());
%>

<%!  
public String[] CateParser(String strCateList){
    return strCateList.replaceAll(" ","").split(",");
}
%>  
