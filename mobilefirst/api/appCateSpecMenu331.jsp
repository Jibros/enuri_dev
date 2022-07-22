<%@ page contentType="text/html; charset=utf-8"%>
<%@ page pageEncoding="utf-8"%>
<%@ page import="com.enuri.util.common.*"%>
<%@ page import="com.enuri.bean.mobile.CateSpecMenu_Proc"%>
<%
//Android iOS 버전 3.3.1 부터 LP의 제조사 브랜드 상세검색 탭 카드가 빠지고 LP 상세검색이(SRP AB타입과 유사)들어가서 API를 따로 생성함
//기존의 API는 하위버전에서 제조사 브랜드 상세검색이 모두 보이게 만들었기 때문이다
	String cate = ConfigManager.RequestStr(request, "cate", "");
	String pType = ConfigManager.RequestStr(request, "pType", "");
	String gb1 = ConfigManager.RequestStr(request, "gb1", "");
	String gb2 = ConfigManager.RequestStr(request, "gb2", "");
	String random_seq = ConfigManager.RequestStr(request, "random_seq", "");
	boolean fFactory =  ConfigManager.RequestStr(request, "factory", "N").equals("Y");
	boolean fBrand =  ConfigManager.RequestStr(request, "brand", "N").equals("Y");
	boolean fSpec =  true;//ConfigManager.RequestStr(request, "spec", "N").equals("Y");
	String cateGroup="";
	try{
		CateSpecMenu_Proc proc = new CateSpecMenu_Proc();
		cateGroup = proc.getCateSpecMenuGroup(cate);
	}catch(Exception e)
	{
		
	}
	
%>
{
"fFactory":<%=fFactory %>,
"fBrand":<%=fBrand %>,
<%if(fFactory){%>
	"getFactory_ajax":
		<jsp:include page="/lsv2016/ajax/getFactory_ajax.jsp" flush="false">
		<jsp:param name="cate" value="<%=cate%>" />
		<jsp:param name="random_seq" value="<%=random_seq%>" />
		<jsp:param name="gb1" value="<%=gb1%>" />
		<jsp:param name="gb2" value="<%=gb2%>" />
		</jsp:include>
	,
<%}%>
<%if(fBrand){%>
		"getBrand_ajax":
		<jsp:include page="/lsv2016/ajax/getBrand_ajax.jsp" flush="false">
		<jsp:param name="cate" value="<%=cate%>" />
		<jsp:param name="random_seq" value="<%=random_seq%>" />
		<jsp:param name="gb1" value="<%=gb1%>" />
		<jsp:param name="gb2" value="<%=gb2%>" />
		</jsp:include>
	,
<%}%>

<%if(fSpec){%>
		"getCateSpecMenu_ajax":
		<jsp:include page="/lsv2016/ajax/getCateSpecMenu_ajax.jsp" flush="false">
		<jsp:param name="cate" value='<%=cate + "," + cateGroup%>' />
		<jsp:param name="random_seq" value="<%=random_seq%>" />
		<jsp:param name="gb1" value="<%=gb1%>" />
		<jsp:param name="gb2" value="<%=gb2%>" />
		<jsp:param name="deviceType" value="M" />
		</jsp:include>
		,
<%}%>
		"getPriceRange_ajax":
		<jsp:include page="/lsv2016/ajax/getPriceRange_ajax.jsp" flush="false">
		<jsp:param name="cate" value="<%=cate%>" />
		<jsp:param name="random_seq" value="<%=random_seq%>" />
		<jsp:param name="gb1" value="<%=gb1%>" />
		<jsp:param name="gb2" value="<%=gb2%>" />
		</jsp:include>
	
}