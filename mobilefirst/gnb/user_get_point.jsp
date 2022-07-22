<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.mobile.Reward_Proc"%>
<%@ page import="org.json.*"%>
<%@ page import="com.enuri.bean.mobile.RSAMains"%>
<%@ page import="com.enuri.bean.mobile.CRSA"%>
<%
	CRSA rsa = new CRSA();
	
	String strT1 = ChkNull.chkStr(request.getParameter("t1"));
	
	//out.println("strT11>>>"+strT1 + "<br>");
	
	strT1 = strT1.replaceAll("[-]","+");
	strT1 = strT1.replaceAll("[_]","/");
	
	//out.println("strT12>>>"+strT1 + "<br>");
	
	boolean blCheck_t1 = false;
	
	String strT1_fdate = "";
	String strT1_enuriid = "";
	String strT1_userdata = "";
	String strR_code = "";
	String strR_msg = "";
	
	String sEnuri_id 				= "";
	String sShop_code 			= "";
	String sOrder_no				= "";
	String sUser_data				= "";
	
	if(!strT1.equals("")){
		//t1에 값이 있으면, 값 해독후 판단 진행
		String strT1_rsa = rsa.decryptByPrivate_mobile(strT1);
		//fire_date가 현재보다 큰지만 비교해서 크면 반환
		//id & user_data 비교 해서 다르면 반환
		//아니면 OK
		//out.println("strT1_rsa>>>"+strT1_rsa + "<br>");
		
		if(strT1_rsa != null){
			String[] arrT1_rsa = strT1_rsa.split("[|][|]");
			
			if(arrT1_rsa != null && arrT1_rsa.length > 0){
				for(int i = 0; i < arrT1_rsa.length; i++){
					//out.println("arrT1_rsa["+ i +"]==="+arrT1_rsa[i] + "<br>");
					if(i == 1){
						strT1_fdate = arrT1_rsa[i];
					}else if(i == 2){
						strT1_enuriid  = arrT1_rsa[i];
					}else if(i == 3){
						strT1_userdata  = arrT1_rsa[i];
					}
				}
				//fire_date가 현재보다 큰지만 비교해서 크면 반환	
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
				
				Date dayToday = new Date();
				
				if(Double.parseDouble(sdf.format(dayToday)) > Double.parseDouble(strT1_fdate)){
					//out.println("error");
				}else{
					//out.println("success");
					blCheck_t1 = true;
				}
			}
		}
	}
	
	if(blCheck_t1){
		String strUserid = strT1_enuriid;
	
		JSONArray jSONArray = new JSONArray(); 
		
		Reward_Proc reward_proc = new Reward_Proc(); 
	//try{
		JSONObject jSONPoint = reward_proc.get_Point(strUserid);
		
		//값에 ".0" 있으면 없에고 return;
		String sPOINT_REMAIN = (String)jSONPoint.get("POINT_REMAIN");
		String sPOINT_PRE_FIX = (String)jSONPoint.get("POINT_PRE_FIX");
		String sREVOLUTION = (String)jSONPoint.get("REVOLUTION");
		//String sUSERID = (String)jSONPoint.get("USERID");
		
		if(sPOINT_REMAIN != null && sPOINT_REMAIN.indexOf(".0") > -1){
			sPOINT_REMAIN = sPOINT_REMAIN.replace(".0","");
		}
		if(sPOINT_PRE_FIX != null && sPOINT_PRE_FIX.indexOf(".0") > -1){
			sPOINT_PRE_FIX = sPOINT_PRE_FIX.replace(".0","");
		}

		JSONObject jSONData = new JSONObject(); 
		
		jSONData.put("POINT_REMAIN", sPOINT_REMAIN);
		jSONData.put("POINT_PRE_FIX",sPOINT_PRE_FIX);
		jSONData.put("REVOLUTION","Y");
		jSONData.put("USERID",strUserid);
		jSONData.put("POINT_UNIT","개");
		
		out.println(jSONData.toString());
	//} catch (Exception e) {}
	}
%>