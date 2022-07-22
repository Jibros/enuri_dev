<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%
//원본소스 확인 firstbuy100_event_org.jsp 에서 확인
//sendRedirect때문에 소스 오류 나서 소스 삭제함 2021/06/02 노병원 소스 수정
String strFb_title = "[에누리 가격비교] 100원에누리다!";
String strFb_description = "에누리 첫 구매라면 누구나! 인기상품 단돈 100원에 구매하고 파워적립 받으세요!";
String strFb_img = "http://img.enuri.info/images/mobilefirst/etc/first100sns2.jpg";

response.sendRedirect("/mobilefirst/evt/welcome_event.jsp"); //100원딜 종료
return;
%>