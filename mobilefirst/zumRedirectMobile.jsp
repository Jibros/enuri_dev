<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.main.Pricelist_Data"%>
<%@ page import="com.enuri.bean.main.Pricelist_Proc"%>
<jsp:useBean id="Pricelist_Data" class="com.enuri.bean.main.Pricelist_Data" scope="page" />
<jsp:useBean id="Pricelist_Proc" class="com.enuri.bean.main.Pricelist_Proc" scope="page" />
<%
long lngPlno = ChkNull.chkLong(request.getParameter("plno"),0);
String strFrom = ChkNull.chkStr(request.getParameter("from"),"");

if(strFrom.equals("zum")){
    cb.setCookie_One("FROM",strFrom);
    cb.SetCookieExpire("FROM",-1);
    cb.responseAddCookie(response);
}

Pricelist_Data pricelist_data = Pricelist_Proc.getData_Plno(lngPlno);

String strUrl = "";
String strGoodscode = "";
long mPrice = 0;
long instance_price = 0;
int szVcode = 0;
String strCa_code = "";
int intModelno = 0;

if(pricelist_data != null){
	
	strUrl = toUrlCode(pricelist_data.getUrl());
	strGoodscode = pricelist_data.getGoodscode();
	mPrice = pricelist_data.getPrice();
	instance_price = pricelist_data.getInstance_price();
	szVcode = pricelist_data.getShop_code();
	strCa_code = pricelist_data.getCa_code();
	intModelno = pricelist_data.getModelno();
	
}

%>
<!DOCTYPE html> 
<html lang="ko"> 
<head>
	<meta charset="utf-8">	 
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />	
	<meta http-equiv="Cache-Control" Content="no-cache" />
	<meta http-equiv="Pragma" Content="no-cache" />
	<meta http-equiv="Expires" Content="0" />
	<meta property="og:title" content="에누리 가격비교">
	<meta property="og:type" content="article">      
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script>
	(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
	(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
	m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
	})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
	//런칭할때 UA-52658695-3 으로 변경
	ga('create', 'UA-52658695-3', 'auto');
	</script> 
</head> 
<body>
<%@ include file="/mobilefirst/include/inc_ctu.jsp"%>
</body>
</html>
<script language="javascript">
$(function() {
	goShop('<%=strUrl %>', '<%=szVcode %>', '<%=lngPlno %>', '<%=strGoodscode %>', '<%=instance_price %>' , '<%=strCa_code %>', '<%=mPrice %>', '<%=mPrice %>',  this, '<%=intModelno %>');
});

function getCookie(cname) {
    var name = cname + "=";
    var ca = document.cookie.split(';');
    for(var i=0; i<ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1);
        if (c.indexOf(name) == 0) return c.substring(name.length,c.length);
    }
    return "";
}
</script>