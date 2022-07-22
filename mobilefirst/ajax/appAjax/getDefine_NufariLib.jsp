<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="org.json.*"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.enuri.util.common.ChkNull"%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page import="com.enuri.util.common.ConfigManager"%>
<%@ page import="java.net.*"%>
<%@include file="/mobilefirst/ajax/appAjax/getDefine_Core.jsp"%>

<%
/**
20190708 
getDefine_NufariLib는 
에누리 3.5.0, 소셜 2.1.5 버전 이상에서 적용 되어있다 
getDefine_NufariLib와 getDefine_new_ajax.jsp 는 getDefine_Core.jsp 를 include 해서 
더 필요한 데이터를 추가하거나 삭제해서 사용한다 

getDefine_NufariLib의 내용은 getDefine_Core와 동일해 추가하는 내용은 없지만 
만약 추가한다면 getDefine_new_ajax의 추가 방법을 참고하면된다 .

추가와 수정은 하위버전 공통 수정일경우는 getDefine_Core에 내용을 추가하고 
상위버전 내용 추가일 경우는 getDefine_NufariLib에 내용을 추가하면된다 (getDefine_new_ajax의 추가 로직 참고)

*/
	
	out.print(defineJson);

%>
