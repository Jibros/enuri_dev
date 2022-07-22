<script language="javascript">
/*
var user_agent; 

user_agent = "<%=request.getHeader("User-Agent")%>"; 
//alert(user_agent);
var agent_os = "";
var agent_ver = "";
var agent_model = ""; 
if(user_agent.indexOf("Android")>-1 ){ 
 agent_os = "Android_mobile_new";
 agent_ver = user_agent.substring(user_agent.indexOf("Android")+7,user_agent.indexOf("; ko"));
 agent_model = user_agent.substring(user_agent.indexOf("kr;")+4,user_agent.indexOf(" Build"));
 _TRK_CP = agent_os +"/"+ agent_ver +"/"+ agent_model;
}else if(user_agent.indexOf("iPhone")>-1){
 agent_os = "iOS_mobile_new"; 
 agent_ver = user_agent.substring(user_agent.indexOf("OS")+2,user_agent.indexOf(" like"));
 agent_model = "iPhone";
 _TRK_CP = agent_os +"/"+ agent_ver +"/"+ agent_model;
}else if(user_agent.indexOf("iPod")>-1){ 
 agent_os = "iOS_mobile_new";
 agent_ver = user_agent.substring(user_agent.indexOf("OS")+2,user_agent.indexOf(" like"));
 agent_model = "iPod";
 _TRK_CP = agent_os +"/"+ agent_ver +"/"+ agent_model;
}else if(user_agent.indexOf("iPad")>-1){  
 agent_os = "iOS_mobile_new"; 
 agent_ver = user_agent.substring(user_agent.indexOf("OS")+2,user_agent.indexOf(" like"));
 agent_model = "iPad"; 
 _TRK_CP = agent_os +"/"+ agent_ver +"/"+ agent_model; 
}
*/ 
</script>  
<%if(ChkNull.chkStr(request.getParameter("app"),"").equals("Y")){%> 
	<%if(HttpUtils.getRequestURL(request).toString().indexOf("/detail.jsp") > -1 ) { %>
		<script language="JavaScript">_TRK_CC=61</script> 
	<%}%>   
<%}else{%> 
	<%if(HttpUtils.getRequestURL(request).toString().indexOf("/detail.jsp") > -1 ) { %>
		<script language="JavaScript">_TRK_CC=62</script> 
	<%}%>
<%}%>

<script language="JavaScript" src="<%=ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script> 

