<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%
String strNowUrl = request.getRequestURL().toString();
String strNowContext = request.getContextPath();
String strNowUri = request.getRequestURI();
String strNowPath = request.getServletPath();
String strID = cb.GetCookie("MEM_INFO", "USER_ID");

String userAgentStr = "";
String strMetaDescription = "";
String strMetaKeywords = "";
String strMetaOgTitle = "";
String strMetaOgDescription = "";
String strMetaTitle = "";

if(strNowUrl.indexOf("list.jsp") > -1){
	strMetaDescription = "에누리 LP Description";
	strMetaKeywords = "에누리 LP Keywords";
	strMetaOgTitle = "에누리 LP OG title";
	strMetaOgDescription = "에누리 LP OG Description";
	strMetaTitle = "에누리 LP title";
}else{
	strMetaDescription = "에누리 통합 Description";
	strMetaKeywords = "에누리 통합 Keywords";
	strMetaOgTitle = "에누리 통합 OG title";
	strMetaOgDescription = "에누리 통합 OG Description";
	strMetaTitle = "에누리 통합 title";
}

%>
<!doctype html>
<meta charset="utf-8">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<META NAME="description" CONTENT="<%=strMetaDescription %>">
<META NAME="keyword" CONTENT="<%=strMetaKeywords %>">
<meta property="og:title" content="<%=strMetaOgTitle %>">
<meta property="og:description" content="<%=strMetaOgDescription %>">
<meta property="og:image" content="<%=ConfigManager.IMG_ENURI_COM%>/images/event/2021/standardpc/sns_1200_630_1.jpg">
<title><%=strMetaTitle %></title>
<link rel="shortcut icon" href="http://img.enuri.info/2014/layout/favicon_enuri.ico">
<link rel="stylesheet" href="/css/slick.css" type="text/css">
<link rel="stylesheet" type="text/css" href="/css/swiper.css"/>
<link rel="stylesheet" href="/css/rev/common.css" type="text/css">
<link rel="stylesheet" href="/css/rev/template.css" type="text/css">
<link rel="stylesheet" href="/css/rev/header.css" type="text/css"/>
<!-- 프로모션 공통 CSS (PC) -->
<link rel="stylesheet" href="/css/event/com.enuri.event.css" type="text/css">
<!-- 프로모션별 커스텀 CSS  -->
<script type="text/javascript" src="/wide/util/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="/js/swiper.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js"></script>
<script language=javascript src="/common/js/Log_Header.js"></script>
<script type="text/javascript" src="/common/js/common_top_2021.js?v=20210603"></script>
<script type="text/javascript" src="/common/js/function.js"></script>
<script type="text/javascript" src="/common/js/exception_keyword.js"></script>
<script type="text/javascript" src="/common/js/incfavoritelayer.js"></script>
<script type="text/javascript" src="/common/js/incfavoritelayer_body.js"></script>
<script type="text/javascript" src="/common/js/eb/gnbTopRightBanner_2021.js"></script>
<script type="text/javascript" src="/lsv2016/js/vsChange.js"></script>
<script type="text/javascript" src="/common/js/getTopBanner_2021.js"></script>
</head>
<body>
<jsp:include page="/wide/common/jsp/Gnb.jsp" /> <!-- 공통 헤더 -->