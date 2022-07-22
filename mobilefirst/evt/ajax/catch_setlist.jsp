<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Event_Catch_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>
<%
  try{
    String strJob = ChkNull.chkStr(request.getParameter("job"),""); //1: catch Icon 2.decide to view Icon

    Event_Catch_Proc event_catch_proc = new Event_Catch_Proc();
	String userId  =  ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"));
    String eventId =ChkNull.chkStr(request.getParameter("eventId"),"");
    String goUrl =ChkNull.chkStr(request.getParameter("goUrl"),""); //이동할 페이지경로
    int modelNo = Integer.parseInt(ChkNull.chkStr(request.getParameter("modelNo"),"0"));
    JSONObject jSONObject = new JSONObject();  
    boolean bl_insert = false;
    boolean loginYN=false;
    
    //아이콘 보여주기(로그인 + 비로그인)
    if(strJob.equals("2") && goUrl!=""){
    	bl_insert = event_catch_proc.isView(eventId, userId, modelNo);
    	if(bl_insert){
			int intRan = (int) (Math.random() * 10);
			if(intRan<3) {
				bl_insert = true;
			}else{
				bl_insert = false;
			}
		}
      	jSONObject.put("result",bl_insert); 
    }
    //아이콘 잡기
    else if(strJob.equals("1") && goUrl!=""){
        //비로그인상태
        if(userId.equals("")){
        	loginYN=false;
            bl_insert=false;
        }
        //로그인상태(성공)
        else{
        	bl_insert = event_catch_proc.insertCatch(eventId, userId,modelNo);
    		loginYN=true;
        }
     	jSONObject.put("loginYN",loginYN);    
      	jSONObject.put("result",bl_insert); 
    }
    

   	out.println(jSONObject.toString());          
    }catch(Exception e){
    	out.println("{\"result\":false}");          
    }

%>