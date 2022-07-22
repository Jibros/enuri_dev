<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.mobile.Reward_Data"%>
<%@page import="com.enuri.bean.mobile.Emoney_Proc"%>
<jsp:useBean id="Reward_Data" class="com.enuri.bean.mobile.Reward_Data" scope="page" />
<jsp:useBean id="Emoney_Proc" class="com.enuri.bean.mobile.Emoney_Proc" scope="page" />
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.simple.*"%>
<%
	String strUserid = cb.GetCookie("MEM_INFO","USER_ID");
	String strWhere = "";  
	int intCoupon_seq = ChkNull.chkInt(request.getParameter("coupon_seq"),0);
	
	//쿠폰의 기본정보 가지고 오기
	Emoney_Proc emoney_proc = new Emoney_Proc(); 
	Reward_Data reward_data[] = emoney_proc.get_CouponOne(intCoupon_seq);
	
	String strCoupon_img  = "";
	String strCode = "";
	String strRefund_date = "";
	String strRefund_status = "";
	
	int iEdate = 0;
	int iCdate = 0;
	int iGift_seq = 0;
	String strCoupon_id = "";
	String strGift_code = "";
	String strC_date = "";
	String strDevice = "";
	
	if(reward_data != null && reward_data.length > 0){

		iGift_seq = reward_data[0].getGift_seq();		//우리쪽 쿠폰번호
		strCoupon_id = reward_data[0].getCoupon_id();	//쿠폰id
		
		strRefund_date = reward_data[0].getRefund_date();	//환불일
		strRefund_status = reward_data[0].getRefund_status();	//환불상태
		
		strGift_code = reward_data[0].getGift_code();	//쿠폰코드(기본정보 검사용)
		strC_date = reward_data[0].getRegdate();		//쿠폰 생성일
		strDevice  = reward_data[0].getDevice();		//쿠폰 생성 기기
	}
	
	//System.out.println("iGift_seq>>>>"+iGift_seq);
	//System.out.println("strCoupon_id>>>>"+strCoupon_id);
	//System.out.println("iEdate>>>>"+iEdate);
	//System.out.println("iCdate>>>>"+iCdate);
	
	JSONArray jSONArray = new JSONArray(); 

	//환불 상세 리스트 get
	jSONArray =  emoney_proc.get_Uselist_Refund_Detail(strUserid, intCoupon_seq); 
  
	JSONObject jSONObject = new JSONObject();  
	
	if(iGift_seq > 0){
		//쿠폰정보로 기본정보 알아옴.
		jSONObject.put("gift_seq", iGift_seq);
		jSONObject.put("coupon_id", strCoupon_id);
		jSONObject.put("gift_code", strGift_code);
		jSONObject.put("refund_date", strRefund_date);
		jSONObject.put("c_date", strC_date);
		jSONObject.put("device", strDevice);
	}
	
	jSONObject.put("refundlist", jSONArray);
	
	out.println(jSONObject.toString());
	
%>