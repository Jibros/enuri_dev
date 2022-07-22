<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Mobile_HitBrand_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="java.util.*"%>
<%@page import="org.json.*"%>
<%
    String userId  =  ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"));
    
    String reqModelno = StringUtils.defaultString(request.getParameter("modelno"),"");
    
    String phone = StringUtils.defaultString(request.getParameter("cellPhone"),"");
    
	HashMap map = new HashMap();
	map.put("tab", StringUtils.defaultString(request.getParameter("tab"),""  ) );
	map.put("userid", userId );
	map.put("cellPhone",  phone);
	map.put("device", StringUtils.defaultString(request.getParameter("device"),"") );
	map.put("modelno", reqModelno );
	map.put("modelnm", StringUtils.defaultString(request.getParameter("modelnm") ,"" ) );
	
	Mobile_HitBrand_Proc mobile_HitBrand_Proc = new Mobile_HitBrand_Proc();
    JSONArray jSONArray = new JSONArray();
    jSONArray =  mobile_HitBrand_Proc.getVoteIdCnt(userId); //현재날짜 투표한 COUNT
	
	int voteCnt = jSONArray.length();
    boolean overlap = true;
	for(int i = 0 ;i <jSONArray.length() ; i++ ){
	   
	   JSONObject jsonObj =  (JSONObject)jSONArray.get(i);
	   String modelno = (String)jsonObj.getString("MODELNO");
	   
	   if(reqModelno.equals(modelno)  ){
	       overlap = false;
	   }
	   map.put("cellPhone",  (String)jsonObj.getString("CELLPHONE") );
	}
	
	JSONObject jSONObject = new JSONObject();//return value; 
	
	if(voteCnt == 0){ //당일 처음 등록 일 경우 전화번호 등록 띠워준다
		if(phone.equals("")){
			jSONObject.put("result","R"); // 대기
		}else{
		   jSONObject.put("result","S"); // 성공
		   JSONObject result = mobile_HitBrand_Proc.ins_vote(map);
		}
	}else if(voteCnt >2 ){
       jSONObject.put("result","E"); // 3번 기회 만료
    
    }else if(!overlap){ // 오늘 하루 모델 중복일 경우
	   jSONObject.put("result","O"); // 중복
	}else if(voteCnt > 0 || voteCnt < 3){
		jSONObject.put("result","S"); // 성공
   		JSONObject result = mobile_HitBrand_Proc.ins_vote(map);
	   if(result.getString("result").equals("1") && voteCnt == 2){
	       jSONObject.put("result","E"); // 3번 기회 만료
	   }
	   //jSONObject.put("code",result.toString()); //DB코드 확인
	}
	
	jSONArray =  mobile_HitBrand_Proc.getVoteIdCnt(userId); //현재날짜 투표한 COUNT
	voteCnt = jSONArray.length();
    jSONObject.put("cnt",voteCnt);

	out.println(jSONObject.toString());

%>