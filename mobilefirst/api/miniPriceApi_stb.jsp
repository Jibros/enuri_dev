<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ include file="/include/IncGroupTool_2010.jsp"%>
<%@ include file="/include/IncSearch.jsp"%>
<%@ page import="com.enuri.bean.main.Pricelist_Data"%>
<%@ page import="com.enuri.bean.main.Pricelist_Proc"%>
<%@ page import="com.enuri.bean.mobile.Mobile_Pricelist_Proc"%>
<%@ page import="com.enuri.bean.main.Goods_Data"%>
<%@ page import="com.enuri.bean.mobile.Mobile_Goods_Proc"%>
<%@ page import="com.enuri.bean.main.Goods_Search"%>
<jsp:useBean id="Goods_Data" class="com.enuri.bean.main.Goods_Data" scope="page" />
<jsp:useBean id="Mobile_Goods_Proc" class="com.enuri.bean.mobile.Mobile_Goods_Proc" scope="page" />
<jsp:useBean id="Pricelist_Proc" class="Pricelist_Proc" scope="page" />
<jsp:useBean id="Mobile_Pricelist_Proc" class="com.enuri.bean.mobile.Mobile_Pricelist_Proc" scope="page" />
<jsp:useBean id="Goods_Search" class="com.enuri.bean.main.Goods_Search" scope="page" />
<%
//스마트 택배 가격정보 API 
// modelno request, 최저가 쇼핑몰 
int intModelno = ChkNull.chkInt(request.getParameter("modelno"),0);

//필수요건 아님.
int intGroup = ChkNull.chkInt(request.getParameter("group"),0);
String strCate = ChkNull.chkStr(request.getParameter("ca_code"),"0201");

String tab_dminsort = ChkNull.chkStr(request.getParameter("tabyn_dminsort"),""); //배송비포함

String strSort = "";

int intModelno_group = 0;//goods_data_pop.getModelno_group();

if(tab_dminsort.equals("Y"))	strSort = "Y";

Goods_Data goods_data_pop = null;

String strTmp_modelnos = ChkNull.chkStr(request.getParameter("modelnos"),"");	//체크 항목 리스트
boolean blChk_group = false;

if(strTmp_modelnos.indexOf(",") > -1){
	intModelno= Mobile_Goods_Proc.get_Minpricemodelno_group(strTmp_modelnos);	//그룹모델일때 기본정보들은 그 그룹에서 제일 최저가를 가진 모델이 대표가 됨.
	blChk_group = true;
}

if(intModelno != 0) {

	if(blChk_group){
		goods_data_pop = Mobile_Goods_Proc.Goods_One_Group(intModelno, strTmp_modelnos);
	}else{
		goods_data_pop = Mobile_Goods_Proc.Goods_One_noGroup(intModelno);
	}

	if(goods_data_pop == null) {
		out.println("{");
		out.println("	\"result\":  \"99\",");
		out.println("	\"result_msg\":  \"no modelno\"");
		out.println("}");
		return;
	}
}else{
	out.println("{");
	out.println("	\"result\":  \"99\",");
	out.println("	\"result_msg\":  \"no modelno\"");
	out.println("}");
	return;
}

int intTotal = 0;
int intFstshop = 0;

String strCate4 = "";

if(strCate.length() > 2){
	strCate4 = strCate.substring(0,4);
}

String strModelnm = goods_data_pop.getModelnm();
String strCondi = goods_data_pop.getCondiname();
String strCdate = goods_data_pop.getC_date();
String strFactory = goods_data_pop.getFactory();
String strCategory = goods_data_pop.getCa_code();
long mMinPrice = goods_data_pop.getMinprice();
long mMinPrice_org = goods_data_pop.getMinprice();
String strBrand = goods_data_pop.getBrand();

//모델명 변경 2015.10.12.
String[] strModelno_new = getModel_FBN(strCategory, strModelnm, strFactory, strBrand);
String strView_modelnm = strModelno_new[1] + " "+ strModelno_new[2] + " "+ strModelno_new[0];

strView_modelnm = strView_modelnm.replace("  "," ");

strModelnm = strView_modelnm;

if(strModelnm.indexOf("[") > 0){
	strModelnm = strModelnm.replace("[","<span class=\"strModelnm\">");
	strModelnm = strModelnm.replace("]","</span>");
}

strModelnm = strModelnm.replaceAll("'","`");		//따옴표처리
strModelnm = strModelnm.replaceAll("`]","]");		//특정문자삭제
strModelnm = strModelnm.replaceAll("!]","]");		//특정문자삭제
if(strModelnm.indexOf("*]")>-1) {
	try {
		strModelnm = strModelnm.substring(0, strModelnm.indexOf("*]")) + strModelnm.substring(strModelnm.indexOf("*]")+1);
	} catch(Exception e) {}
}
strModelnm = strModelnm.replaceAll("#]","]");		//특정문자삭제

// [일반] 제거
if(strModelnm.indexOf("[일반]")>-1) {
	try {
		strModelnm = CutStr.cutStr(strModelnm, strModelnm.indexOf("[일반]")) + strModelnm.substring(strModelnm.indexOf("[일반]")+4);
	} catch(Exception e) {}
}
//특수문자 제거
strModelnm = strModelnm.replace("!","");
strModelnm = strModelnm.replace("`","");
strModelnm = strModelnm.replace("'","");
strModelnm = strModelnm.replace("#","");
strModelnm = strModelnm.replace("*","");
strModelnm = removeTag(strModelnm);

if (strCate.trim().length() == 0 ){
	strCate = strCategory;
}
Pricelist_Data pricelist_data = new Pricelist_Data();
pricelist_data aszPlist = null;
aszPlist = Mobile_Pricelist_Proc.get_list_first_all(intModelno, strCategory, intGroup, strSort, 1, 10);
%>
{
<%
	String strZumFlag = "N";
	Cookie[] cookies = request.getCookies();
	if(cookies!=null && cookies.length>0) {
		for(int i=0; i<cookies.length; i++) {
			if(cookies[i].getName().equals("FROMZUM")) {
				strZumFlag = cookies[i].getValue();
			}
		}
	}
	if(strZumFlag.equals("N") || strZumFlag.equals("")){
		strZumFlag = cb.getCookie_One("FROMZUM");
	}

//try {
	if(aszPlist != null && aszPlist.length > 0){
		intTotal = aszPlist[0].getAll_cnt();
		intFstshop = aszPlist[0].getShop_code();
		String strShop_name = aszPlist[0].getShop_name();

		out.println("	\"result\":  \"00\",");
		out.println("	\"result_msg\":  \"ok\",");
		out.println("	\"modelno\":  \"" + intModelno + "\",");
		out.println("	\"modelnm\":  \"" + chk_Webapp_tojs(request, strModelnm) + "\",");
		out.println("	\"url\":  \"http://m.enuri.com/mobilefirst/detail.jsp?modelno=" + intModelno + "&from=stb\",");
		out.println("	\"shop\":\""+ strShop_name +"\",  ");
		out.println("	\"price\":\""+ mMinPrice +"\"  ");
	}else{
		out.println("	\"result\":  \"99\",");
		out.println("	\"result_msg\":  \"no modelno\"");
	}
//} catch(Exception e) {
//}
%>
}
<%!

public String removeTag(String html) throws Exception {
	return html.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
} 

public String chk_Webapp_tojs(HttpServletRequest request, String str) throws Exception{
	
	String userAgent = request.getHeader("user-agent");

	//System.out.println("userAgent>>"+userAgent);
	
	if(userAgent.indexOf("enuriApp")  > -1|| userAgent.indexOf("Android") > -1){
		str = str.replace("&nbsp;"," ");
		return toJS2(str);
	}else{
		return toJS2(str);
	}
}
%>