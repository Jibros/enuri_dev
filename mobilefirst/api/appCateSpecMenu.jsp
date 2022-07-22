<%@ page contentType="text/html; charset=utf-8"%>
<%@ page pageEncoding="utf-8"%>
<%@ page import="com.enuri.util.common.*"%>
<%
	String cate = ConfigManager.RequestStr(request, "cate", "");
	String pType = ConfigManager.RequestStr(request, "pType", "");
	String gb1 = ConfigManager.RequestStr(request, "gb1", "");
	String gb2 = ConfigManager.RequestStr(request, "gb2", "");
	String random_seq = ConfigManager.RequestStr(request, "random_seq", "");
	boolean fFactory =  true;//ConfigManager.RequestStr(request, "factory", "N").equals("Y");
	boolean fBrand =  true;//ConfigManager.RequestStr(request, "brand", "N").equals("Y");
	boolean fSpec =  true;//ConfigManager.RequestStr(request, "spec", "N").equals("Y");
%>
{
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
		<jsp:param name="cate" value="<%=cate%>" />
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