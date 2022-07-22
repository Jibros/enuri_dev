<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%

	String param = ChkNull.chkStr(request.getParameter("param"),""); 

	String cUserId = cb.GetCookie("MEM_INFO","USER_ID");
	String cUserNick = cb.GetCookie("MEM_INFO","USER_NICK");

	Cookie[] carr = request.getCookies();
	String strAppyn = "";
	String strVerios = "";
	String strAd_id = "";
	int intVerios = 0;
	 
	try {
		for(int i=0;i<carr.length;i++){
		    if(carr[i].getName().equals("appYN")){
		    	strAppyn = carr[i].getValue();
		    	break;
		    }
		}
		for(int i=0;i<carr.length;i++){
		    if(carr[i].getName().equals("verios")){
		    	strVerios = carr[i].getValue();
		    	break;
		    }
		}
		for(int i=0;i<carr.length;i++){
		    if(carr[i].getName().equals("adid")){
		    	strAd_id = carr[i].getValue();
		    	break;
		    } 
		}
	} catch(Exception e) {
	}
	 
	String szRemoteHost = request.getRemoteHost().trim();
	if(!strAppyn.equals("Y") && szRemoteHost.indexOf("58.234.199.")<0){
		//response.sendRedirect("/mobilefirst/Index.jsp");
	}
%>
<!DOCTYPE html> 
<html lang="ko">
<head>
	<meta charset="utf-8">	
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />	
	<meta property="og:title" content="에누리 가격비교">
	<meta property="og:description" content="에누리 모바일 가격비교">
	<meta property="og:image" content="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/images/logo_enuri.png">
	<meta name="format-detection" content="telephone=no" />
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/default.css">
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/emoney.css">
	<!-- <link rel="stylesheet" type="text/css" href="emoney.css"> -->
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
</head>
<body>
	<img src="http://storage.enuri.info/pic_upload/faq/<%=param%>" width="100%" alt='' />
</body>
</html>