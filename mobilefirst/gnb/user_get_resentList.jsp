<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.mobile.RSAMains"%>
<%@ page import="com.enuri.bean.mobile.CRSA"%>
<%
	String strResentList = ChkNull.chkStr(request.getParameter("resentlist"),"");
	String strResentListAll = "";	//정리한 값

	
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
		
		if(strResentList.equals("")){
			javax.servlet.http.Cookie[] cookies = request.getCookies(); 
			if(cookies!=null){
				for(int i = 0 ; i<cookies.length; i++){                            // 쿠키 배열을 반복문으로 돌린다.
					if(cookies[i].getName().equals("resentList")){
						strResentList = cookies[i].getValue();
					}
				}
			}
			//out.println("strResentList1>>>"+strResentList);
			strResentList = java.net.URLDecoder.decode(strResentList);
		}
		//최근본 상품 갯수
		int intCnt = 0;
		
		if (strResentList != null) {
			String[] strResentListAry = strResentList.split(",");
			for (int i = 0; i < strResentListAry.length; i++) {
				//if(i < 10){
					if(i > 0) strResentListAll += ",";
					strResentListAll += strResentListAry[i];
				//}
				intCnt++;
			}
		}
	//out.println("strResentListAll>>>"+strResentListAll);
%>
<jsp:include page="/mobilefirst/ajax/resentZzim/Ajax_goodsListNew.jsp" flush="true">
	<jsp:param name="goodsNumList" value="<%=strResentListAll%>"/>
	<jsp:param name="listType" value="1"/>
</jsp:include>
<%
	}
%>
