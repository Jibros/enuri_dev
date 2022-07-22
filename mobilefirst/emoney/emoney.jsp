<%
	Cookie[] carr = request.getCookies();
	String strAppyn = "";
	try {
		for (int i=0;i<carr.length;i++){
		    if (carr[i].getName().equals("appYN")) {
		    	strAppyn = carr[i].getValue();
		    	break;
		    }
		}
	} catch(Exception e) {}

	// 앱이 아닐 경우
	String szRemoteHost = request.getRemoteHost().trim();
	if(!strAppyn.equals("Y") && szRemoteHost.indexOf("58.234.199.")<0){
		response.sendRedirect("/mobilefirst/Index.jsp");
		return;
	}

	// 신규 emoney 페이지로 이동
	RequestDispatcher dispatcher = request.getRequestDispatcher("/m/emoney.jsp?"+request.getQueryString());
	dispatcher.forward(request, response);
%>