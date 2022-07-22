<%@page import="org.json.JSONException"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.OutputStreamWriter"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%
// app 에서 품절 ctu 태우고 품절이면 품절 시킴
String strSeq = ChkNull.chkStr(request.getParameter("seq"),"");
String strShopcode = ChkNull.chkStr(request.getParameter("shopcode"),"");

if("".equals(strSeq)) return ;

String strUserip = request.getRemoteAddr(); 

//response.sendRedirect("/mobilefirst/include/m4_move_log.jsp?"+strParam);

try{
	String url = "";
	String url2 = "";
	if(request.getRequestURL().indexOf("dev.enuri.com") > -1){
		url = "http://dev.enuri.com/move/ctuV2.jsp";
		url2 = "http://dev.enuri.com/mobilefirst/include/inc_enurideal.jsp";
	}else{
		url = "http://localhost/move/ctuV2.jsp";
		url2 = "http://localhost/mobilefirst/include/inc_enurideal.jsp";
	}
		
		URL obj = new URL(url);
		URLConnection conn = obj.openConnection();
		
		String urlParameters = "ctu_test=N"+"&system_type=4&device=1&service=6&shop_code="+strShopcode+"&goods_seq="+strSeq+"&user_ip="+strUserip;
		
        // POST 값 전송일 경우 true
        conn.setDoOutput(true);
        OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
        // 파라미터를 wr에 넣어주고 flush
        wr.write(urlParameters);
        wr.flush();
    
        // in에 readLine이 null이 아닐때까지 StringBuffer에 append
		BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		String inputLine;			
		
		StringBuilder sbJson = new StringBuilder();
		
		while ((inputLine = in.readLine()) != null) {
			sbJson.append(inputLine);
		}
		in.close();
        wr.close();
        if(sbJson != null){
        	out.println(sbJson.toString());
			if(sbJson.toString().indexOf("SUCCESS") > -1  ){
				urlGo(url2+"?seq="+strSeq);
			} 
		}
}catch(Exception e){
	System.out.println("crazy deal error:"+e);
}
%>
<%!
public void urlGo(String strUrl) {
	try {
		BufferedReader br = new BufferedReader(new InputStreamReader((new URL(strUrl)).openConnection().getInputStream(),"UTF-8"));
		StringBuilder sbJson = new StringBuilder();
		String strLine = "";
		while ((strLine = br.readLine()) != null)	sbJson.append(strLine);
		br.close();
	} catch (Exception e) {
		System.out.println("********* error ************:"+e);
	}
}

//app 에서는 스크립트 동작안함
%>
<% /* %>
<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
<script>
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
//런칭할때 UA-52658695-3 으로 변경
ga('create', 'UA-52658695-3', 'auto');

var vcode = "<%=strShopcode %>";
var goods_seq = "<%=strSeq %>";
var vIp = "<%=strUserip %>";

$(function() {
	try{
		
		if(vcode != "7692"){	//G9예외처리
			var vDevice = "2";
			
			if(vcode == "7885"){
				vDevice = "1";
			}
			
			vDevice = "1";
			
			//var vData_M = {ctu_test: "N", system_type : "4" , device : vDevice, service: "6", shop_code: vcode, goods_seq: goods_seq, user_ip: vIp};
			var vData_M = {ctu_test: "Y", system_type : "4" , device : vDevice, service: "6", shop_code: vcode, goods_seq: goods_seq, user_ip: vIp};
	
			//alert(JSON.stringify(vData_M));
			
			$.ajax({  
				type: "POST",  
				url: "/move/ctuV2.jsp",
				data: vData_M,
				dataType:"JSON",
				success: function(json){
					if(json.resultMsg == "SUCCESS"){
						if(json.resultData.SoldOut == "1"){
							//품절처리
							$.ajax({  
								type: "POST",  
								url: "/mobilefirst/include/inc_enurideal2.jsp",
								data: "seq="+ goods_seq,
								dataType:"JSON",
								success: function(result){
									if(result.resultMsg){
										//json 배포
										/*
										$.ajax({  
											type: "POST",  
											url: "http://dev.enuri.com/jca/mobile_deal_dev.jsp"
										});
										*/
									}
								} 
							}); 
						}
					}
				} 
			});
		}
	}catch(e){
		
	}
			
	var ua = navigator.userAgent.toLowerCase();
	var isAndroid = ua.indexOf("android") > -1;
					
	if(isAndroid) 		ga('send', 'event', 'mf_buy', 'click_Deal_AOS앱' ,  'buy_'+vcode+'_'+goods_seq);
	else		ga('send', 'event', 'mf_buy', 'click_Deal_IOS앱' ,  'buy_'+vcode+'_'+goods_seq);
});

</script>
<%
*/
%>