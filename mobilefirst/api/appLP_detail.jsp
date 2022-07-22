<%@ page contentType="text/html; charset=utf-8"%>
<%@ page pageEncoding="utf-8"%>
<%@ page import="com.enuri.util.common.*"%>
<%
//플러스 링크 ip 검사 해서 따로 생성 필요

	String cate = ConfigManager.RequestStr(request, "cate", "");
		String catename = ConfigManager.RequestStr(request, "catename", "");
			String pType = ConfigManager.RequestStr(request, "pType", "");
			String gb1 = ConfigManager.RequestStr(request, "gb1", "");
			String gb2 = ConfigManager.RequestStr(request, "gb2", "");
			String deviceType = ConfigManager.RequestStr(request, "deviceType", "");


			String constrain = ConfigManager.RequestStr(request, "constrain", "");
			String ca_arr_code = ConfigManager.RequestStr(request, "ca_arr_code", "");
			String order = ConfigManager.RequestStr(request, "order", "");
			String sponsor_modelno_type = ConfigManager.RequestStr(request, "sponsor_modelno_type", "");
			String openexpectflag = ConfigManager.RequestStr(request, "openexpectflag", "");
			String ca_arr_lcode = ConfigManager.RequestStr(request, "ca_arr_lcode", "");
			String mallcntAll = ConfigManager.RequestStr(request, "mallcntAll", "");
			String IsDeliverySumPrice = ConfigManager.RequestStr(request, "IsDeliverySumPrice", "");
			String jobcode = ConfigManager.RequestStr(request, "jobcode", "");
			String m_price = ConfigManager.RequestStr(request, "m_price", "");
			String start_price = ConfigManager.RequestStr(request, "start_price", "");
			String end_price = ConfigManager.RequestStr(request, "end_price", "");
			String brand_arr = ConfigManager.RequestStr(request, "brand_arr", "");
			String factory_arr = ConfigManager.RequestStr(request, "factory_arr", "");
			String spec = ConfigManager.RequestStr(request, "spec", "");
			String sel_spec = ConfigManager.RequestStr(request, "sel_spec", "");
			String random_seq = ConfigManager.RequestStr(request, "random_seq", "");
			String pageNum = ConfigManager.RequestStr(request, "pageNum", "");
			String pageGap = ConfigManager.RequestStr(request, "pageGap", "");
			String tabType = ConfigManager.RequestStr(request, "tabType", "");

			String keyword = ConfigManager.RequestStr(request, "keyword", "");
			String brand = ConfigManager.RequestStr(request, "brand", "");
			String factory = ConfigManager.RequestStr(request, "factory", "");
			String prtmodelno = ConfigManager.RequestStr(request, "prtmodelno", "");

			String sponsorList = ConfigManager.RequestStr(request, "sponsorList", "");
			String infoAdList = ConfigManager.RequestStr(request, "infoAdList", "");

			String procType = ConfigManager.RequestStr(request, "procType", "");



			String szCategory = ConfigManager.RequestStr(request, "szCategory", cate);
			String ad_command = ConfigManager.RequestStr(request, "ad_command", "");
			String ad_command2 = ConfigManager.RequestStr(request, "ad_command2", catename);
			String referrer = ConfigManager.RequestStr(request, "referrer", "list.jsp");
			String url = ConfigManager.RequestStr(request, "url", "list.jsp");
			String strCh = ConfigManager.RequestStr(request, "strCh", "m_enuri.ch2");
			
			

			
			String groupflag= ConfigManager.RequestStr(request, "groupflag", "0");
			String chk_id= ConfigManager.RequestStr(request, "chk_id", "");
			String adult= ConfigManager.RequestStr(request, "adult", "0");
			
			
			
			
			String miseCate ="";
			String listInfoCate="";
			%>
			
			



{

<% if (cate.length()>4 && groupflag.equals("0")|| groupflag.equals("2")){
if(cate.length()>6)
	miseCate = cate.substring(0,6);
else 
	miseCate = cate;
%>
	 "ajax_to_json_5category":
	 <jsp:include page="/mobilefirst/ajax/gnb/ajax_to_json_5category.jsp" flush="false">
		 <jsp:param name="cate" value="<%=miseCate%>" />
		 <jsp:param name="flag" value="<%=groupflag%>" />
	 </jsp:include>
	 ,
<%}%>

<%if(cate.length()>4)
	listInfoCate = cate.substring(0,4);
	else 
	listInfoCate = cate;
%>

"getListSettingInfo_ajax":
<jsp:include page="/lsv2016/ajax/getListSettingInfo_ajax.jsp"
	flush="false">
	<jsp:param name="cate" value="<%=listInfoCate%>" />
</jsp:include>
,



"getListGoods_ajax":
<jsp:include page="/lsv2016/ajax/getListGoods_ajax.jsp" flush="false">
	<jsp:param name="cate" value="<%=cate%>" />
	<jsp:param name="deviceType" value="2" />
	<jsp:param name="mobileAppAdult" value="Y" />
	<jsp:param name="gb1" value="<%=gb1%>" />
	<jsp:param name="gb2" value="<%=gb2%>" />
	<jsp:param name="constrain" value="<%=constrain%>" />
	<jsp:param name="ca_arr_code" value="<%=ca_arr_code%>" />
	<jsp:param name="order" value="<%=order%>" />
	<jsp:param name="sponsor_modelno_type" value="<%=sponsor_modelno_type%>" />

	<jsp:param name="openexpectflag" value="<%=openexpectflag%>" />
	<jsp:param name="ca_arr_lcode" value="<%=ca_arr_lcode%>" />
	<jsp:param name="mallcntAll" value="<%=mallcntAll%>" />
	<jsp:param name="IsDeliverySumPrice" value="<%=IsDeliverySumPrice%>" />
	<jsp:param name="jobcode" value="<%=jobcode%>" />
	<jsp:param name="m_price" value="<%=m_price%>" />
	<jsp:param name="start_price" value="<%=start_price%>" />
	<jsp:param name="end_price" value="<%=end_price%>" />
	<jsp:param name="brand_arr" value="<%=brand_arr%>" />
	<jsp:param name="factory_arr" value="<%=factory_arr%>" />
	<jsp:param name="spec" value="<%=spec%>" />
	<jsp:param name="sel_spec" value="<%=sel_spec%>" />
	<jsp:param name="random_seq" value="<%=random_seq%>" />
	<jsp:param name="pageNum" value="<%=pageNum%>" />
	<jsp:param name="pageGap" value="<%=pageGap%>" />
	<jsp:param name="tabType" value="<%=tabType%>" />

	<jsp:param name="keyword" value="<%=keyword%>" />
	<jsp:param name="brand" value="<%=brand%>" />
	<jsp:param name="factory" value="<%=factory%>" />
	<jsp:param name="prtmodelno" value="<%=prtmodelno%>" />

	<jsp:param name="sponsorList" value="<%=sponsorList%>" />
	<jsp:param name="infoAdList" value="<%=infoAdList%>" />
</jsp:include>
,

"getListDealMini_ajax":
<jsp:include page="/mobilefirst/ajax/listAjax/getListDealMini_ajax.jsp"
	flush="false">
	<jsp:param name="cate" value="<%=listInfoCate%>" />
</jsp:include>

,

"getSponsorLink_json":
<jsp:include page="/mobilenew/ajax/getSponsorLink_json.jsp" flush="false">
	<jsp:param name="cate" value="<%=cate%>" />

	<jsp:param name="szCategory" value="<%=szCategory%>" />
	<jsp:param name="ad_command" value="<%=ad_command%>" />
	<jsp:param name="ad_command2" value="<%=ad_command2%>" />

	<jsp:param name="referrer" value="<%=referrer%>" />
	<jsp:param name="url" value="<%=url%>" />
	<jsp:param name="strCh" value="<%=strCh%>" />

</jsp:include>
,

"banner_list":
<jsp:include page="/mobilefirst/http/json/banner_list.json" flush="false">
</jsp:include>
,

"appLP_banner":
<jsp:include page="/mobilefirst/api/appLP_banner.jsp" flush="false">
<jsp:param name="cate" value="<%=cate%>" />
</jsp:include>
}


