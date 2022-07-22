<%@ page import="com.enuri.bean.log.Gatepage_buylog_Proc"%>
<% 
	try{
	
	HttpSession sessionViewEvent = request.getSession();	
	
	String strGkind_AD   = ChkNull.chkStr(cb.GetCookie("GATEP","GKIND"),"");
	String strGno_AD     = ChkNull.chkStr(cb.GetCookie("GATEP","GNO"),"");
	String strViewEvent_AD = ChkNull.chkStr((String)sessionViewEvent.getAttribute("VIEW_EVENT"),"").trim();
	
	//if(request.getRemoteAddr().equals("58.234.199.46")){
	//	out.println("strGkind_AD=="+strGkind_AD+"<br>");
	//	out.println("strViewEvent_AD=="+strViewEvent_AD+"<br>");
	//}   
	 
	//strGkind_AD = "42";
	//strGno_AD = "4493225";  
	 
	String strKeyword_AD = ""; 
		
	Gatepage_buylog_Proc gatepage_buylog_proc = new Gatepage_buylog_Proc();
	
	int intGKind = 0; 
	int intGNo   = 0; 
 
	if(strGkind_AD.length() > 0){
		if (ChkNull.chkNumber(strGkind_AD)){ 
			intGKind = Integer.parseInt(strGkind_AD);
		}
		
		if (ChkNull.chkNumber(strGno_AD)){
			intGNo = Integer.parseInt(strGno_AD);  
		}  
		
		strKeyword_AD = gatepage_buylog_proc.getGatePageKeyword(intGNo,intGKind);
		 
		if(strKeyword_AD.length() > 0 && !strViewEvent_AD.equals("Y") ){
			sessionViewEvent.setAttribute("VIEW_EVENT","Y");
			 
	 %>
		<div id="main" > 
			<script type="text/javascript">
				var vGkind = "<%=strGkind_AD%>";
				 
				function onoffAd(id) {
					var mid=document.getElementById(id);
					if(mid.style.display=='') {
						mid.style.display='none';
					}else{ 
						mid.style.display='';
					}
				}
				
				function CmdAdBridge(){ 
					//ga('send', 'event', 'mf_event', '광고브릿지', '실행완료');
					if(vGkind == "42"){  
						ga('send', 'event', 'mf_event', '광고브릿지_신청', 'SA 42 M_Naver');
					}else if(vGkind == "43"){
						ga('send', 'event', 'mf_event', '광고브릿지_신청', 'SA 43 M_Daum');
					}else if(vGkind == "44"){
						ga('send', 'event', 'mf_event', '광고브릿지_신청', 'SA 44 M_Google');
					}else if(vGkind == "72"){
						ga('send', 'event', 'mf_event', '광고브릿지_신청', 'DA 72 M_icover');
					}
					//location.href='/mobilefirst/event/event_three.jsp?freetoken=event';
					//location.href='/mobilefirst/event/event_three.jsp?freetoken=event&loc=con02';
					//location.href = '/mobilefirst/event2016/allpayback_201608.jsp?loc=con04';
					//location.href = '/mobilefirst/event2016/purchase_event.jsp?freetoken=event';
					location.href='/mobilefirst/evt/welcome_event.jsp?tab=1&freetoken=event';

				}
			</script>     
		 <% //if(1==2 && strGkind_AD.equals("42") || strGkind_AD.equals("43") || strGkind_AD.equals("44") || strGkind_AD.equals("72")){ %>  
		 <% if(false){ %>
			<div class="dim" id="brLayer"  style="">
			<% if(strGkind_AD.equals("72")){ %>
				<div class="bridge none">
					<a href="#" class="btn_close" onclick="onoffAd('brLayer')">닫기</a>
					<a href="#" class="go" onclick="CmdAdBridge();">첫 구매 혜택신청</a>
				</div>
			<% }else{ %>
				<div class="bridge">
					<a href="#" class="btn_close" onclick="onoffAd('brLayer')">닫기</a>
					<span><%=strKeyword_AD%></span>
					<h1>검색하신 고객님께 첫 구매 혜택!</h1>
					<a href="#" class="go" onclick="CmdAdBridge();">첫 구매 혜택신청</a>
				</div>
			<% } %>
			</div> 
		<% } %>
		</div>
	<%}%>
<%}%> 

<%}catch(Exception e) {}%>
