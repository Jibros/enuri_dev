<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%
long iPlno = ChkNull.chkLong(request.getParameter("pl_no"));
int intVcode = ChkNull.chkInt(request.getParameter("shopcode"));
int iModelno = ChkNull.chkInt(request.getParameter("modelno"),0);
String strCate = ChkNull.chkStr(request.getParameter("cate"),"");

String strParam = "cate="+strCate+"&modelno="+iModelno+"&pl_no="+iPlno+"&vcode="+intVcode;

//System.out.println("strParam>>>>"+strParam);

response.sendRedirect("/mobilefirst/include/m4_move_log.jsp?"+strParam);
//앱에서 http 통신으로 호출하면 script 는 실행안됨.
%>
<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
<script>
	(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
	(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
	m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
	})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
	//런칭할때 UA-52658695-3 으로 변경
	ga('create', 'UA-52658695-3', 'auto');

	$(function() {
	 	var logParam = "<%=strParam %>";
	 	
	 	//alert(logParam);

		$.ajax({  
			type: "POST", 
			url: "/mobilefirst/include/m4_move_log.jsp",
			data: logParam,
			success: function(result){
				//alert("ok");
			} 
		}); 
	 	
	 	var ua = navigator.userAgent.toLowerCase();
		var isAndroid = ua.indexOf("android") > -1;
		
		if(isAndroid) {
			ga('send', 'event', 'mf_buy', 'click_AOS앱' ,  'buy_<%=intVcode %>');	
		}else{
			ga('send', 'event', 'mf_buy', 'click_IOS앱' ,  'buy_<%=intVcode %>');
		}
	});
</script>