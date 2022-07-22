<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Emoney_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.simple.*"%>
<%
	String strUserid = cb.GetCookie("MEM_INFO","USER_ID");
	String strWhere = "";  
	String strPointInOut = ChkNull.chkStr(request.getParameter("point_in_out"),"");
	 
	int iPage = ChkNull.chkInt(request.getParameter("page"),1);
	int iPageSize = ChkNull.chkInt(request.getParameter("pagesize"),50);
	
	JSONArray jSONArray = new JSONArray(); 

	if(!strPointInOut.equals("in_refund")){	//환불
		strWhere = " and userid = '"+strUserid+"'";
	
		if(strPointInOut.equals("in_buy")){				//적립받기
			strWhere = strWhere + "  and cart_status = '08' ";
		}else if(strPointInOut.equals("in_event")){	//적립내역
			//strWhere = strWhere + "  and cnp_code in ('10', '11')  ";
		}else if(strPointInOut.equals("out")){			//사용
			strWhere = strWhere + " and point_in_out < 0 "; 
		}

		
		if(strPointInOut.equals("in_buy")){				//적립받기
			Emoney_Proc emoney_proc = new Emoney_Proc();  
			jSONArray =  emoney_proc.get_Uselist_cart_ver2(iPage, iPageSize, strWhere); 
			
		}else if(strPointInOut.equals("in_event")){		//적립내역
			Emoney_Proc emoney_proc = new Emoney_Proc();  
			jSONArray =  emoney_proc.get_Uselist_cart(iPage, iPageSize, strWhere); 
		}else{											//사용
			Emoney_Proc emoney_proc = new Emoney_Proc();  
			jSONArray =  emoney_proc.get_Uselist_ver3(iPage, iPageSize, strWhere);
		}
				
	}else{
		//환불 리스트 get
		strWhere = " and userid = '"+strUserid+"'";
		
		Emoney_Proc emoney_proc = new Emoney_Proc();  
		jSONArray =  emoney_proc.get_Uselist_Refund(iPage, iPageSize, strWhere); 
	}
  
	JSONObject jSONObject = new JSONObject();  
	  
	jSONObject.put("pointlist", jSONArray);
	
	out.println(jSONObject.toString());
	
%>