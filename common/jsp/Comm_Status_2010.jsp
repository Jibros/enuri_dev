<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/include/Base_Inc_New_2010.jsp"%>
<%
	boolean bExLink = false;
	if (request.getRequestURI().indexOf("Smilecat.jsp") >= 0  || request.getRequestURI().indexOf("Flower_Easyflower.jsp") >= 0){
		bExLink = true;
	}
	String strLoginStyle = "";
	if (cb.GetCookie("MEM_INFO","USER_ID").trim().length() == 0 ){
		strLoginStyle="display:none";
	}
	int intLoginMainLeft = Integer.parseInt(ChkNull.chkStr(request.getParameter("lm"),"542"));	
	String strPageType = ChkNull.chkStr(request.getParameter("pt"),"1");    
	/*스타일 누리 탑메뉴 올리는 작업 때문에 추가*/
	/*
	String strIsFashion = "";
	int intFashionTopWidth = 0;
	if (request.getServletPath().trim().indexOf("/fashion/") >= 0){
		intFashionTopWidth = 15;
		strIsFashion = "?fashion=Y";
	}
	*/	
%>
<div id="LayerLoginMain" style="position:absolute;left:<%=intLoginMainLeft%>px; top:60px;width:115px;height:20px;z-index:0; overflow:hidden;<%=strLoginStyle%>;" >
	<iframe id="frmMainLogin" name="frmMainLogin" src="/login/Loginstatus_2010.jsp?pt=<%=strPageType%><%if (bExLink){out.print("&exlink=Y");}%>" frameborder=0  style="width:131px;height:20px;overflow:hidden;display:none;" onload="showLoginStatus()"></iframe>
</div>
<script language="javascript">
//메인 로딩시 로그인영역이 잠깐동안 다른 위치에 보이는것 방지 : 안보이는곳에 숨어있게
if($("LayerLoginMain") && $("knowbox_top2")){
	$("LayerLoginMain").style.left = -200;
}
</script>