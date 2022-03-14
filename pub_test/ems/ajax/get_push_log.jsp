<%@page import="com.enuri.bean.mobile.EmsTower_Proc"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% out.println(new EmsTower_Proc().getPushLog(5)); %>
