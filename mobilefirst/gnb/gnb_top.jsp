<%@ page import="com.enuri.bean.mobile.Event_Warr_Proc"%>
<jsp:useBean id="Event_Warr_Proc" class="com.enuri.bean.mobile.Event_Warr_Proc" scope="page" />
<%
	String strApp = ChkNull.chkStr(request.getParameter("app"),"");	 //	Y일때 앱
	String cate = ChkNull.chkStr(request.getParameter("cate"),"");	 //카테고리이름
	String gseq = ChkNull.chkStr(request.getParameter("gseq"),"");	 //gseq
	int indexYN = request.getRequestURL().toString().indexOf("/mobilenew/Index.jsp");
	int eventYN = request.getRequestURL().toString().indexOf("/mobilenew/event/roulette.jsp");
	int listYN = request.getRequestURL().toString().indexOf("/mobilenew/list.jsp");
	int searchYN = request.getRequestURL().toString().indexOf("/mobilenew/search.jsp");
	int bestYN = request.getRequestURL().toString().indexOf("/mobilenew/best_list.jsp");
	
	String best = ChkNull.chkStr(request.getParameter("best"),"");	 //best
	
	String strUuid = "";
	
	if(cb.GetCookie("MOBILEWEBUUID","UUID").equals("")){
		strUuid = Event_Warr_Proc.make_Uuid();

		cb.SetCookie("MOBILEWEBUUID", "UUID", strUuid);
		cb.SetCookieExpire("MOBILEWEBUUID", 3600*24*14);
		cb.responseAddCookie(response);
	
	}else{
		strUuid = cb.GetCookie("MOBILEWEBUUID","UUID");
	}
	
	//String strDefault = "가을 끝자락, 놓치지 말고 등반!";
	String strDefault = "";
	String strDefaultUrl = "/mobilenew/include/planlist.jsp?type=B20141016";
	
	HttpSession sessionMobileIndex = request.getSession(true);
	
	String goMove = ChkNull.chkStr(request.getParameter("goMove"),"");
	String version = ChkNull.chkStr(request.getParameter("version"),"0"); //IOS
	String ver = ChkNull.chkStr(request.getParameter("ver"),"0");
	if(ver.equals("null")) ver = "0";
	
	if(ver.equals("")){
		ver = ChkNull.chkStr((String)sessionMobileIndex.getAttribute("version"));
	}else{
		sessionMobileIndex.setAttribute("version", ChkNull.chkStr(request.getParameter("ver"),""));
	}
		
	String ua = request.getHeader("User-Agent");
	int verInt =  Integer.parseInt(ver.replace(".","")); //android
	int versionInt =  Integer.parseInt(version.replace(".","")); //ios
	
	//footer css 소셜, 백화점, 코어
	String css = "";
	String nowUrl = request.getRequestURL().toString();
	
	if(nowUrl.contains("mobiledepart")){
		css = "mobiledepart";
	}else if(nowUrl.contains("mobiledeal")){
		css = "mobiledeal";
	}else{
		css = "agreeWrap";
	}
	

%>
<%@ include file="/mobilefirst/login/login_check.jsp"%>
