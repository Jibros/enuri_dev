<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.simple.*"%>
<%@ page import="java.util.*,java.text.*,java.net.*,java.io.*"%>
<%@ page import="com.enuri.include.*"%>
<%@ page import="com.enuri.util.etc.*"%>
<%@ page import="com.enuri.util.common.*"%>
<%@ page import="com.enuri.util.image.*"%>
<%@ page import="com.enuri.util.http.*"%>
<%@ page import="com.enuri.util.date.*"%>
<%@ page import="com.enuri.dbcon.DBconnection"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.enuri.exception.ExceptionManager"%>
<%@ page import="com.enuri.bean.mobile.FCM_Push_Proc"%>
<%
	String type = ChkNull.chkStr(request.getParameter("type"));
    String ad_push_yn = ChkNull.chkStr(request.getParameter("ad_push_yn"));
    String info_push_yn = ChkNull.chkStr(request.getParameter("info_push_yn"));
    String enuri_id = ChkNull.chkStr(request.getParameter("enuri_id"));
    String topic = ChkNull.chkStr(request.getParameter("topic"));
    String token = ChkNull.chkStr(request.getParameter("token"));

	FCM_Push_Proc proc = new FCM_Push_Proc();
	if(token.equals("")){
		out.println("{'result':'fail'}");
	}else{
		if(type.equals("regist")){
			out.println( proc.registTokensToTopic( token, topic ));
		}else if(type.equals("insert")){
			String result = "" ;
			if(!proc.isPushTokenExist(token)){
				int seq = proc.getSeq();
				seq++;
				result = proc.setPushToken(seq, ad_push_yn, token, topic, enuri_id );
			}
			out.println(result);
		}else if(type.equals("infoupdate")){
			out.println( proc.setInfoToToken( token ));
		}else if(type.equals("getinfo")){
			out.println( proc.getTokenInfo( token ));
		}else if(type.equals("unregist")){
			String result = proc.unregistTokensToTopic( token, topic );
			if(!result.equals("")){
				proc.UpdateADPushYN( token );
				out.println( "{'result':'success'}" +result );
			}else{
				out.println( "{'result':'fail'}" +result );
			}
		}else{
			out.println( "{'result':'fail'}" );
		}
	}

%>

