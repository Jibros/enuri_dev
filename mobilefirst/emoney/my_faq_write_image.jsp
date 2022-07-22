<%@ page contentType="text/html;charset=utf-8" %>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.enuri.bean.mobile.Faq_Data"%>
<%@ page import="com.enuri.bean.mobile.Faq_Proc"%>
<%@ page import="java.io.File"%>
<jsp:useBean id="Faq_Data" class="com.enuri.bean.mobile.Faq_Data" scope="page"  />
<jsp:useBean id="Faq_Proc" class="com.enuri.bean.mobile.Faq_Proc" scope="page"  />
<%

String strMsg=""; 

DecimalFormat df = new DecimalFormat("00");
Calendar currentCalendar = Calendar.getInstance();
String strHour   = df.format(currentCalendar.get(Calendar.HOUR));
String strMinute   = df.format(currentCalendar.get(Calendar.MINUTE));
String strSeconds   = df.format(currentCalendar.get(Calendar.SECOND));
String strDay   = df.format(currentCalendar.get(Calendar.DATE));
String strYYYY = Integer.toString(currentCalendar.get(Calendar.YEAR));
String strMM = df.format(currentCalendar.get(Calendar.MONTH)+1);

String strCheck_day = strYYYY+""+strMM+""+strMinute+""+strSeconds;

MultipartRequest multi= new MultipartRequest(request, ConfigManager.ConstFileUpload+"faq/", 10*1024*1024 , "utf-8", new DefaultFileRenamePolicy()); 

String strFile = ChkNull.chkStr(multi.getParameter("faq_file1"));


UpLoad upload = new UpLoad(multi);
String strReq_file = upload.getName("faq_file1");

String strRename = "";

if(!strReq_file.equals("")){
	strRename = strCheck_day+strReq_file.substring(strReq_file.indexOf("."),strReq_file.length());
	
	File uploadFile = new File(ConfigManager.ConstFileUpload+"faq/"+strReq_file);
	if (uploadFile.isFile()){
		File reNameFile = new File(ConfigManager.ConstFileUpload+"faq/"+strRename);
		uploadFile.renameTo(reNameFile);
	}
}

Runtime.getRuntime().exec("chmod 777  /Web_Storage/pic_upload/faq/"+strRename);

%>
{
"strRename":
	<%=strRename%>,
"strReq_file":
	<%=strReq_file%>
}
	
