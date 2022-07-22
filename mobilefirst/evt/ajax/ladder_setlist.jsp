<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="java.net.InetAddress"%>
<%@page import="com.enuri.bean.mobile.Event_Ladder_Proc"%>
<%

// getParameter 
	//String strJob = ChkNull.chkStr(request.getParameter("job"), "").trim();			//1: first insert, 2:lucky bag insert ......
	String strOsType = ChkNull.chkStr(request.getParameter("osType"), "").trim();
	String strEventId = ChkNull.chkStr(request.getParameter("eventId"),"");
    String endDate = ChkNull.chkStr(request.getParameter("endDate"),"");
    String strWishId = ChkNull.chkStr(request.getParameter("wishId"), "").trim();
	String sdt = ChkNull.chkStr(request.getParameter("sdt"), "");
	
	//String cUserId = ChkNull.chkStr(request.getParameter("userid"), "");
	int intResultValue = 0;
	int intChangeValue = 0;

	String cUserId = cb.GetCookie("MEM_INFO","USER_ID");
	
	SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMdd");	//오늘 날짜 (visitData, ins_date)
	String strToday = formatter.format(new Date());
	
	Calendar calendar = Calendar.getInstance();

	String year = Integer.toString(cal.get(Calendar.YEAR));
	String month = Integer.toString(cal.get(Calendar.MONTH)+1);
	String day = Integer.toString(cal.getMaximum(Calendar.DAY_OF_MONTH));

	if((cal.get(Calendar.MONTH)+1) < 10){
		month = "0"+month;
	}
	
	if(cal.getMaximum(Calendar.DAY_OF_MONTH) < 10){
		day = "0"+day;
	}
	
	String strEndDay = year+month+day;
	
	Event_Ladder_Proc event_proc = new Event_Ladder_Proc(); 
	
	if(!sdt.equals("")){
		strToday = sdt;
		strEndDay = endDate;
	}
	
	
	long lngToday = Long.parseLong(strToday);
	long endDay = Long.parseLong(strEndDay);
	if(lngToday > endDay){
		intResultValue = 0;
	}else{
		
		if (strOsType.length() > 0 && cUserId.length() > 0) {
			try {
					// return value -1:실패, 0:중복참여
					intResultValue = event_proc.ladder_event_ins(strEventId,cUserId,strToday,strOsType,strWishId);
					//if(intResultValue==1){
					//	intChangeValue=3;
					//}else if(intResultValue==2){
					//	intChangeValue=2;
					//}else if(intResultValue==3){
					//	intChangeValue=4;
					//}else if(intResultValue==4){
					//	intChangeValue=1;
					//}
					intChangeValue = intResultValue;
					
					
			} catch(Exception ex) {}
			
		}
	}
	
	
//out.println("strOsType:"+strOsType);
%>{"result" : "<%=intChangeValue%>" }
