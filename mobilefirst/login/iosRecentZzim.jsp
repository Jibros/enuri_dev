<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/login/Inc_AutoLoginSet_2010.jsp"%><%
	String loginCheck_strID = cb.GetCookie("MEM_INFO","USER_ID");
	
	boolean IsAutoLogin = false;
	if(loginCheck_strID.length()>0) {
		String tempAutoLogin = cb.GetCookie("MYINFO","AUTOLOGIN");
		String tempAutoLoginID = cb.GetCookie("MYINFO","AUTOLOGINID");

		if(tempAutoLogin.equals("Y") && loginCheck_strID.equals(tempAutoLoginID)) {
			IsAutoLogin = true;
		}
	}
%>
<script language="JavaScript">
<!--
var recentZzimIOSList = "";
// 최근본과 찜을 가져오는 함수
function loadRecentZzimList(listType, pageGap) {
	var loadUrl = "/mobilefirst/ajax/resentZzim/Ajax_goodsListNew.jsp?listType="+listType+"&folder_id=1&deviceType=m&pageNum=1&pageGap="+pageGap;

	$.getJSON(loadUrl, null, function(data) {
		var jsonObj = data["goodsList"];
		var resentImgList = "";

		if(jsonObj) {
			$.each(jsonObj, function(indexI, listObj) {
				var modelno = listObj["modelno"];
				var p_pl_no = listObj["p_pl_no"];
				var factory = listObj["factory"];
				var modelname = listObj["modelnm"];
				var minprice = listObj["minprice"];
				var middleImageUrl = listObj["smallImageUrl"];
				var itemStr = "";

				if(modelno=="0") {
					itemStr = "P"+"|"+p_pl_no+"|"+middleImageUrl+"|"+factory+"|"+modelname+"|"+minprice;
				} else {
					itemStr = "G"+"|"+modelno+"|"+middleImageUrl+"|"+factory+"|"+modelname+"|"+minprice;
				}
				recentZzimIOSList += itemStr + "#";
			});
		}
	});
}
-->
</script>