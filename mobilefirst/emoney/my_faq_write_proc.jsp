<%@ page contentType="text/html;charset=utf-8" %>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.enuri.bean.mobile.Faq_Data"%>
<%@ page import="com.enuri.bean.mobile.Faq_Proc"%>
<%@ page import="com.enuri.bean.member.Sns_Login"%>
<%@ page import="java.io.File"%>
<%@ page import="org.json.JSONObject" %>
<jsp:useBean id="Faq_Data" class="com.enuri.bean.mobile.Faq_Data" scope="page"  />
<jsp:useBean id="Faq_Proc" class="com.enuri.bean.mobile.Faq_Proc" scope="page"  />
<jsp:useBean id="Sns_Login" class="com.enuri.bean.member.Sns_Login" scope="page"/>
<%

String strReferer = ChkNull.chkStr(request.getHeader("REFERER"),"");

if(strReferer == null || strReferer.equals("") || strReferer.indexOf(".enuri.com/mobilefirst/emoney/my_faq_write.jsp") < 0 ){
	out.println("잘못된 접근입니다.");
	return;
}

MultipartRequest multi= new MultipartRequest(request, ConfigManager.ConstFileUpload+"faq/", 10*1024*1024 , "utf-8", new DefaultFileRenamePolicy());

//SQL Injection 체크
if( !ChkNull.chkReqInj(multi) ) {
	out.println("잘못된 접근입니다.");
	return;
}

String strMsg="";
Random random = new Random();
SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMddHHmmss");
String strCheck_day = formatter.format(new Date())+random.nextInt(100); //현재시간(yyyyMMddHHmmss) + 0~99난수

String strJob_type = ChkNull.chkStr(multi.getParameter("job_type"),"");
String strFile1 = "";
String strFile1_name = "";

int intFaq_seq = ChkNull.chkInt(multi.getParameter("faq_seq"),0);
int intFaq_type = ChkNull.chkInt(multi.getParameter("faq_type"),2);
int intKind = ChkNull.chkInt(multi.getParameter("kind"),8);
int strType = ChkNull.chkInt(multi.getParameter("type"),1);
String strUserid = ChkNull.chkStr(multi.getParameter("userid"));
String strTitle = ChkNull.chkStr(multi.getParameter("title"));
String strShopname = ChkNull.chkStr(multi.getParameter("shopname"));
String strOrdid = ChkNull.chkStr(multi.getParameter("ordid"));
String strOrddate = ChkNull.chkStr(multi.getParameter("orddate"));
String strGoodscode = ChkNull.chkStr(multi.getParameter("goodscode"));
String strContent = ChkNull.chkStr(multi.getParameter("content"));
String strFile = ChkNull.chkStr(multi.getParameter("faq_file1"));
String strTel = ChkNull.chkStr(multi.getParameter("tel"));
String strFile_app = ChkNull.chkStr(multi.getParameter("faq_file1_app"));		//app용 이미지 이름

//아이디 체크
if(cb.GetCookie("MEM_INFO","USER_ID").equals("") || !strUserid.equals(cb.GetCookie("MEM_INFO","USER_ID"))){
	out.println("잘못된 접근입니다.");
	return;
}

if(strTitle.equals("") || strContent.equals("")) {
	out.println("잘못된 접근입니다.");
	return;
}

boolean isSnsUser = false;
String strUsername = "";
JSONObject snsMember = Sns_Login.getSnsMemberData(strUserid, null);
if(snsMember != null){
	isSnsUser = true;
	strUsername = snsMember.getString("nickname");
}

Cookie[] carr = request.getCookies();
String strAppyn = "";
String strVerios = "";
String strAd_id = "";
int intVerios = 0;

try {
	for(int i=0;i<carr.length;i++){
	    if(carr[i].getName().equals("appYN")){
	    	strAppyn = carr[i].getValue();
	    	break;
	    }
	}
	for(int i=0;i<carr.length;i++){
	    if(carr[i].getName().equals("verios")){
	    	strVerios = carr[i].getValue();
	    	break;
	    }
	}
	for(int i=0;i<carr.length;i++){
	    if(carr[i].getName().equals("adid")){
	    	strAd_id = carr[i].getValue();
	    	break;
	    }
	}
} catch(Exception e) {
}

UpLoad upload = new UpLoad(multi);
String strReq_file = upload.getName("faq_file1");

String strRename = "";

if(strAppyn.equals("Y")  && strVerios.equals("")){
	strReq_file = strFile_app;
	strRename = strReq_file;
}else{
	if(!strReq_file.equals("")){
		// 파일 인젝션 체크
		if( ChkNull.chkInj(strReq_file).equals("") ) {
			out.println("파일 업로드 실패");
			return;
		}

		strRename = strCheck_day+strReq_file.substring(strReq_file.indexOf("."),strReq_file.length());

		File uploadFile = new File(ConfigManager.ConstFileUpload+"faq/"+strReq_file);
		if (uploadFile.isFile()){
			File reNameFile = new File(ConfigManager.ConstFileUpload+"faq/"+strRename);
			uploadFile.renameTo(reNameFile);
			Runtime.getRuntime().exec("chmod 777  /Web_Storage/pic_upload/faq/"+strRename);
		}
	}
}

String strFile1_old = ChkNull.chkStr(multi.getParameter("file1_old"));

// Xss 키워드 치환
SecurityUtil strXss = new SecurityUtil();
strTitle =  strXss.Xss(strTitle);
strContent = strXss.Xss(strContent);

Faq_Data faq_data_inup = new Faq_Data();

faq_data_inup.setFaq_seq(intFaq_seq);
faq_data_inup.setFaq_type(intFaq_type);
faq_data_inup.setKind(intKind);
faq_data_inup.setUserid(strUserid);
faq_data_inup.setTitle(strTitle);
faq_data_inup.setOrd_shop_name(strShopname);
faq_data_inup.setOrd_id(strOrdid);
faq_data_inup.setOrd_date(strOrddate);
faq_data_inup.setOrd_shop_goods_no(strGoodscode);
faq_data_inup.setContent(strContent);
faq_data_inup.setTel(strTel);
faq_data_inup.setFile1(strRename);
faq_data_inup.setFile1_name(strReq_file);
if(isSnsUser)
	faq_data_inup.setUsername(strUsername);

intFaq_seq = Faq_Proc.Faq_Board_Insert(faq_data_inup);
%>
<script language=javascript>

	alert("문의가 정상적으로 등록되었습니다.");

	<% if(strAppyn.equals("Y")){ %>
		window.location.href = "close://";
	<% }else{ %>
		history.go(-2);
	<% } %>
//	location.replace("/mobilefirst/emoney/emoney_faq.jsp#1");
// 	history.back();
</script>
