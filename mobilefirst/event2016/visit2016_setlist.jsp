<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="java.net.InetAddress"%>
<%@page import="com.enuri.bean.event.every.Event_Every_Visit_Proc"%>
<%

// getParameter 
	String strJob = ChkNull.chkStr(request.getParameter("job"), "").trim();			//1: first insert, 2:lucky bag insert ......
	String strOsType = ChkNull.chkStr(request.getParameter("osType"), "PC").trim();
	String strEventId = ChkNull.chkStr(request.getParameter("strEventId"),"");
	
	String sdt = ChkNull.chkStr(request.getParameter("sdt"), "");
	
	int intResultValue = 0;

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
	//String strEndDay = "20160630";
	
	Event_Every_Visit_Proc event_proc = new Event_Every_Visit_Proc(); 
	//cUserId = "daka1122";
	//strJob = "1"; 		//임시 임
	//strItemSeq = "1";
	
// 	strToday = sdt;
// 	strEndDay = "20160731";
	
	long lngToday = Long.parseLong(strToday);
	long endDay = Long.parseLong(strEndDay);

	if(lngToday > endDay){
		intResultValue = 0;
	}else{
		if (strJob.length() > 0 && strOsType.length() > 0 && cUserId.length() > 0) {
			try {
				if(strJob.equals("1")){
					if(strOsType == "MAI" || strOsType == "MAA"){
						// return value 0:실패, 1:중복참여
						intResultValue = event_proc.visit_event_ins(strEventId,cUserId,strToday,strOsType);
					}else{
						intResultValue = 0;
					}
				}
				
			} catch(Exception ex) {}
			
		}
	}

%>{"result" : "<%=intResultValue %>" }


