<%@ page contentType="text/html; charset=utf-8"%>
<%@ page pageEncoding="utf-8"%>
<%@ page import="com.enuri.util.common.*"%>


<%String cate = ConfigManager.RequestStr(request, "cate", "");//cond cate 
			String paramcate = ConfigManager.RequestStr(request, "paramcate", "");// cate 
			String keyword = ConfigManager.RequestStr(request, "keyword", "");
			String in_keyword = ConfigManager.RequestStr(request, "in_keyword", "");
			String strversion = ConfigManager.RequestStr(request, "version", "0.0.0");
			String app_type = ConfigManager.RequestStr(request, "app_type", "N");

			int version = 0;
			if (strversion.length() >= 5) {
				try {
					version = Integer.parseInt(strversion.substring(0, 1)) * 100 + Integer.parseInt(strversion.substring(2, 3)) * 10 + Integer.parseInt(strversion.substring(4, 5));
				} catch (Exception e) {
				}
			}%>
{
<%if (cate.length() > 0) {%>
"getCateSpecMenu_ajax":
<jsp:include page="/lsv2016/ajax/getCateSpecMenu_ajax.jsp" flush="false">
	<jsp:param name="cate" value="<%=cate%>" />
</jsp:include>
<%
	}
	if (version >= 325) {
		if (!app_type.equals("A")) {
			//제조사 브랜드는 안드로이드에서는 3.2.5버전 이상일 경우 appSRP 에서 가져온다
			if(cate.length()>0)
			{
%>
				,
<%			} %>
"getSearchInfoList_ajax":
<jsp:include page="/lsv2016/ajax/getSearchInfoList_ajax.jsp"
	flush="false">
	<jsp:param name="cate" value="<%=paramcate%>" />

	<jsp:param name="keyword" value="<%=keyword%>" />
</jsp:include>
<%
		}
	} else {
if(cate.length()>0)
			{
%>
				,
<%			} %>

"getSearchInfoList_ajax":
<jsp:include page="/lsv2016/ajax/getSearchInfoList_ajax.jsp"
	flush="false">
	<jsp:param name="keyword" value="<%=keyword%>" />
</jsp:include>
<%
	}
%>

}


