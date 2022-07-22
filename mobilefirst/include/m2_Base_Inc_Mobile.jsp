<%@ page import="java.util.*,java.text.*,java.net.*"%>
<%@ page import="com.enuri.include.*"%>
<%@ page import="com.enuri.util.etc.*"%>
<%@ page import="com.enuri.util.common.*"%>
<%@ page import="com.enuri.util.image.*"%>
<%@ page import="com.enuri.util.http.*"%>
<%@ page import="com.enuri.util.date.*"%>
<%@ page import="com.enuri.bean.main.Category_Data"%>
<%@ page import="com.enuri.bean.main.Category_Proc"%>
<jsp:useBean id="Category_Data" class="com.enuri.bean.main.Category_Data" scope="page" /> 
<jsp:useBean id="Category_Proc" class="com.enuri.bean.main.Category_Proc" scope="page" />
<%
	response.setContentType("text/html;charset=UTF-8");
	response.setHeader("Pragma","No-cache");
	response.setDateHeader("Expires",-1);
	response.setHeader("Cache-Control","no-cache");
	
	CookieBean cb = null;
	cb = new CookieBean( request.getCookies()); 
	String output = cb.GetCookie( "MYINFO","TMP_ID");
	
	if(output.equals("")){
		output = Category_Proc.getTmpID();
		cb.SetCookie("MYINFO","TMP_ID", output);
		cb.SetCookieExpire("MYINFO", 3600*24*30);
		cb.responseAddCookie(response);	
	}
	if( CvtStr.isNumeric(cb.GetCookie("MYINFO","TMP_ID"))==false){
		output = Category_Proc.getTmpID();
		cb.SetCookie("MYINFO","TMP_ID", output);
		cb.SetCookieExpire("MYINFO", 3600*24*30);
		cb.responseAddCookie(response);	
	}
	
	Calendar cal = Calendar.getInstance();
	
%>
<%!
	private String getBrowserName(String strAgent){
		String strReturn = "";
		if(strAgent.toLowerCase().indexOf("msie 6")>-1 && strAgent.toLowerCase().indexOf("msie 7")==-1 && strAgent.toLowerCase().indexOf("msie 8")==-1) {
			strReturn = "msie6";
		}else if(strAgent.toLowerCase().indexOf("msie 7")>-1 && strAgent.toLowerCase().indexOf("msie 8")==-1) {
			strReturn = "msie7";
		}else if(strAgent.toLowerCase().indexOf("msie 8")>-1) {
			strReturn = "msie8";
		}else if(strAgent.toLowerCase().indexOf("msie")!=-1) {
			strReturn = "msie";
		}else if(strAgent.toLowerCase().indexOf("firefox")>-1) {
			strReturn = "firefox";
		}else if(strAgent.toLowerCase().indexOf("opera")>-1) {
			strReturn = "opera";
		}else if(strAgent.toLowerCase().indexOf("chrome")>-1) {
			strReturn = "chrome";
		}else{
		
		}
		return strReturn;
	}
	
	public static String getDate()
	{
	   DecimalFormat df = new DecimalFormat("00");
	   Calendar calendar = Calendar.getInstance();
	
	
	   String year = Integer.toString(calendar.get(Calendar.YEAR)); //년도를 구한다
	   String month = df.format(calendar.get(Calendar.MONTH) + 1); //달을 구한다
	   String day = df.format(calendar.get(Calendar.DATE)); //날짜를 구한다
	   String date = month+"월" + day+"일"; 

	   return date;
	}
	
%>