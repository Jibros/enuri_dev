<%@ page contentType="text/html;charset=utf-8" %>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@ page import="com.enuri.bean.main.Goods_BBS_Proc"%>
<%@ page import="com.enuri.bean.main.Goods_BBS_Data"%>
<jsp:useBean id="Goods_BBS_Proc" class="com.enuri.bean.main.Goods_BBS_Proc" scope="page" />
<%@ page import="com.enuri.bean.main.Goods_Proc"%>
<%@ page import="com.enuri.bean.main.Goods_Data"%>
<jsp:useBean id="Goods_Proc" class="com.enuri.bean.main.Goods_Proc" scope="page" />
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<jsp:useBean id="Members_Proc" class="com.enuri.bean.knowbox.Members_Proc" scope="page" />
<%@ page import="com.enuri.bean.knowbox.Know_box_Proc"%>
<jsp:useBean  id="Know_box_Proc" class="com.enuri.bean.knowbox.Know_box_Proc"  />
<%@ include file="/include/IncGroupTool_2010.jsp"%>
<%
/** 댓글 스팸등록 차단 */
Enumeration headerNames = request.getHeaderNames(); 
String headerName="";
String refer="";
while (headerNames.hasMoreElements()) { 
	headerName = (String)headerNames.nextElement(); 
	if(headerName.trim().equals("Referer")){	
		refer = request.getHeader(headerName);	
	}
}

String procType = ChkNull.chkStr(request.getParameter("procType"));
int modelno = ChkNull.chkInt(request.getParameter("modelno"));
boolean procSuccessFlag = false;

String szRemoteHost = request.getRemoteHost().trim();
//아이피 차단
String[] limitedIps = {"124.50.96.232", "114.30.10.37", "119.198.135.25", "222.122.19.71"};
for(int i=0; i<limitedIps.length; i++) {
	if(limitedIps[i].equals(szRemoteHost)) {
%>
		<script language="JavaScript">
		alert("판매홍보, 욕설, 근거없는 비난 글을 게시판에 적어 IP가 차단되었습니다.\r\n허위사실을 유포하는 경우 법적인 책임이 따르므로 주의해주시기 바랍니다.\r\nIP 차단 해제를 원하는 경우 메일 주시기 바랍니다.\r\nmaster@enuri.com");
		</script>
<%
		return;
	}
}

if(procType.equals("insert")) {
	if (refer.indexOf("enuri.com") < 0 && refer.indexOf("100.100.100.") < 0 && refer.indexOf("58.234.199.") < 0 ){
		return;
	}

	// 스팸성 댓글 방지를 위한 세션 검증
	/*
	HttpSession ttsession = request.getSession(true);
	String sessioinValue = "";

	if(ttsession.getAttribute("GOODS_BBS_USERTEST")!=null){
		sessioinValue = (String)ttsession.getAttribute("GOODS_BBS_USERTEST");
	}

	if(!sessioinValue.equals("true")) {
%>
		<script language="JavaScript">
		alert("오랫동안 사용하지 않아 연결이 끊겼거나\r\n글 입력 경로가 올바르지 않아, 스팸으로 처리되었습니다.\r\n글 내용을 수정해서 다시 입력해주세요.");
		</script>
<%
		return;
	} else {
		ttsession.setAttribute("GOODS_BBS_USERTEST", "false");
	}
	*/
	
	String usernm = cb.GetCookie("MEM_INFO","USER_NICK");
	String userid = (cb.GetCookie("MEM_INFO","USER_ID")).trim().replaceAll("[?]","");

	System.out.println("userid>>>>"+userid);
	
	if(userid.equals("")){
%>
		<script language="JavaScript">
		alert("로그인을 하시면 글을 작성할 수 있습니다.");
		</script>
<%
		return;
	}
	String ip = request.getRemoteAddr();
	String pwd = ChkNull.chkStr(request.getParameter("pass"));
	String contents = HtmlStr.removeHtml(ChkNull.chkStr(request.getParameter("contents")));
	String interest_flag = ChkNull.chkStr(request.getParameter("interest_flag"));
	String interest_email = ChkNull.chkStr(request.getParameter("interest_email"));
	
	contents =  ReplaceStr.replace(contents,"<","&lt");
	contents =  ReplaceStr.replace(contents,">","&gt");
	
	String smodelnos = Goods_Proc.getData_Group_Modelnos(modelno);
				
	//글내용 용량 체크
	byte[] bystStr = null;
	boolean cutFlag = false;
	try {
		bystStr = contents.getBytes();
		if(bystStr.length>=4000) {
			contents = new String(bystStr, 0, 3999);
			cutFlag = true;
		}
	} catch(Exception e) {
	}
	
	if(modelno>0) {
		if(!cutFlag) {
			procSuccessFlag = Goods_BBS_Proc.Goods_BBS_Insert(modelno, usernm, ip, "", "", contents, "", userid, "", 0);
			Know_box_Proc.update_Kbnum(modelno, 1); //글갯수 업데이트

			//댓글알림 메일 발송
			Goods_BBS_Data[] mail_list = null;
			mail_list = Goods_BBS_Proc.Goods_BBS_MailList(smodelnos, "");
			if(mail_list!=null && mail_list.length>0){
				String IMG_ENURI_COM = ConfigManager.IMG_ENURI_COM;
				String mailUrl = "http://www.enuri.com";
				String xstrLine = "";
				String xstrLine2 = "";
				int iModelno = modelno;
				
				Goods_Data goods_data = Goods_Proc.Goods_Detailmulti_One(iModelno, "Detailmulti");
				if(goods_data!=null) {
					String strConstrain = goods_data.getConstrain();
					String szFactory = goods_data.getFactory();
					String szCategory = goods_data.getCa_code();
					String szSpec = goods_data.getSpec();
					String strCdate = goods_data.getC_date();
					String fImgChk = goods_data.getImgchk();
					int intMallCnt = goods_data.getMallcnt();
					long nP_pl_no = goods_data.getP_pl_no();
					String strP_imgurl = goods_data.getP_imgurl().trim();
					String strP_imgurl2 = goods_data.getP_imgurl2().trim();
					String strP_imgurlflag = goods_data.getP_imgurlflag().trim();
					String szModelNm = goods_data.getModelnm();
					String strCopyPhrase = goods_data.getKeyword2();
					String strOpenExpectFlag = goods_data.getOpenexpectflag();
				
					//if(szModelNm.lastIndexOf("[")>0){
					//	szModelNm = szModelNm.substring(0,szModelNm.lastIndexOf("["));
					//}	
					szModelNm = replaceModelNmSpecialChar(szCategory, szModelNm);
					String szSubjectModelnm = szModelNm;
					if(CutStr.cutStr(szCategory,4).equals("0304") || CutStr.cutStr(szCategory,4).equals("0305")){
						szModelNm = ReplaceStr.replace(szModelNm, "(", "<span style='font-weight:normal'>(");
						szModelNm = ReplaceStr.replace(szModelNm, ")", ")</span>");
					}
					if(!CutStr.cutStr(szCategory,2).equals("14")){
						szModelNm = ReplaceStr.replace(szModelNm, "[", " <span style='font-weight:normal'>[");
						szModelNm = ReplaceStr.replace(szModelNm, "]", "]</span>");
					}
					
					String xstrFromName = "에누리닷컴";
					String xstrFromMail = "master@enuri.com";
					String xstrSubject = "[에누리] " + szSubjectModelnm + " 상품에 새댓글이 추가되었습니다.";
					
					if(szFactory.equals("[불명]") || strConstrain.equals("5")){
						szFactory = "";
					}
					// 특정 분류는 제조사 안보임
					if(CutStr.cutStr(szCategory,8).equals("18120904") || CutStr.cutStr(szCategory,8).equals("18121014") || CutStr.cutStr(szCategory,6).equals("032406")){
						szFactory = "";
					}
					String strCate4 = "";
					String strCate6 = "";
					if(szCategory.length()>=4){ 
						strCate4 = CutStr.cutStr(szCategory,4);
					}	
					if(szCategory.length()>=6){
						strCate6 = CutStr.cutStr(szCategory,6);
					}
					strCdate = CutStr.cutStr(strCdate,10);
					String strViewCdate = "";
					if(!CutStr.cutStr(strCate4,2).equals("15") && !strCate6.equals("161006") && !strCate6.equals("032406") && !strCate6.equals("181206")){
						if(strViewCdate.equals("예정")){
							strViewCdate = "<span style=\"font-family:돋움;line-height:15px;font-size:11px;color:#808080;\">출시예정</span>";
						}else{
							strViewCdate = DateUtil.RtnDateComment(strCdate,"2010_list","");
							strViewCdate += "<span style=\"font-family:돋움;line-height:15px;font-size:11px;color:#808080;\">출시</span>";
						}
					}else{
						strViewCdate = "&nbsp;";
					}
					strViewCdate = ReplaceStr.replace(strViewCdate, "<SUP>", "<SUP style=\"font-family:MS Serif;color:#6b6b6b;font-size:6pt;line-height:15px;\">");
					strViewCdate = ReplaceStr.replace(strViewCdate, "class=\"cdate_mon1\"", "style=\"font-family:돋움;line-height:15px;font-size:11px;font-weight:bold;\"");
					strViewCdate = ReplaceStr.replace(strViewCdate, "class=\"cdate_mon2\"", "style=\"font-family:돋움;line-height:15px;font-size:11px;\"");
					String strImageUrl = ImageUtil.getImageSrc(szCategory,iModelno,fImgChk,nP_pl_no,strP_imgurl,strP_imgurlflag);
					//2022.01.04 성인카테 변경 1640->163630
  					//szCategory.substring(0,4).equals("1640") -> strCate6.equals("163630")
					if(strCate6.equals("163630")){ //성인용품
						strImageUrl = IMG_ENURI_COM+"/images/home/thumb_adult_300.jpg";
						
					}
					if(strConstrain.equals("5")){
						strImageUrl = strP_imgurl2;
					}
					//요약설명 처리
					if(szSpec.indexOf(" > ")<0) { //즉시서비스 모델 패스
						szSpec = ReplaceStr.replace(szSpec, "</", "<^");
						szSpec = ReplaceStr.replace(szSpec, "/", " / ");
						szSpec = ReplaceStr.replace(szSpec, "<^", "</");
					}
					if(szSpec.equals("")){ //요약설명 없는 패션분류는 모델명 표시
						szSpec = szModelNm;
					}
					
					xstrLine += "<html>";
					xstrLine += "<head>";
					xstrLine += "<base href='" + mailUrl + "' />";
					xstrLine += "</head>";
					xstrLine += "<body><img src=\"http://img.enuri.info/images/blank.gif\" width=0 height=0/>";
					xstrLine += "<table width=\"737\" align=\"center\" border=\"0\" cellspacing=\"0\" cellpadding=\"1\">";
					xstrLine += "<tr>";
					xstrLine += "<td><table width=\"737\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">";
					xstrLine += "<tr>";
					xstrLine += "<td><table width=\"737\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">";
					xstrLine += "<tr>";
					xstrLine += "<td background=\""+IMG_ENURI_COM+"/images/mailing/mailimage/box_02.gif\"><div style=\"width:737px;height:20px;overflow:hidden;\"><img src=\""+IMG_ENURI_COM+"/images/mailing/mailimage/box_01.gif\" width=\"737\" height=\"20\" /></div><table width=\"660\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"margin-left:38px;\">";
					xstrLine += "<tr><td height=\"40\"><a href=\""+mailUrl+"\" title=\"에누리 가격비교\" target=\"_blank\"><img src=\""+IMG_ENURI_COM+"/images/mailing/mailimage/logo.gif\" width=\"121\" height=\"27\" border=0/></a></td></tr>";
					xstrLine += "<tr>";
					xstrLine += "<td><table width=\"647\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\"><tr>";
					xstrLine += "<td width=\"102\" align=\"center\" valign=\"top\" bgcolor=\"#FFFFFF\" style=\"border:1px solid #cccccc;border-right:none;\"><a href=\""+mailUrl+"/view/Detailmulti.jsp?cateListLayerFlag=Y&tailflag=Y&from=recmail&modelno="+iModelno+"\" title=\"에누리 가격비교\" target=\"_blank\"><img src=\""+strImageUrl+"\" width=\"100\" height=\"100\" border=\"0\" style=\"margin:1px;\"/></a></td>";
					xstrLine += "<td valign=\"top\" bgcolor=\"#FFFFFF\" style=\"border:1px solid #cccccc;\">";
					xstrLine += "<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"1\"><tr>";
					xstrLine += "<td height=\"25\" bgcolor=\"efefef\"><table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"1\">";
					xstrLine += "<tr>";
					xstrLine += "<td style=\"line-height:16px;padding-left:5px;\"><a href=\""+mailUrl+"/view/Detailmulti.jsp?cateListLayerFlag=Y&tailflag=Y&from=recmail&modelno="+iModelno+"\" title=\"에누리 가격비교\" target=\"_blank\" style=\"text-decoration:none;\"><span style=\"font-family:'맑은 고딕','돋움';color:#000000;font-size:12px;line-height:16px;\"><strong>"+szModelNm+"</strong>";
					if(!strCate6.equals("161006") && !strCate6.equals("032406") && !strCate6.equals("210317") && !strCate6.equals("181206")){
						xstrLine += "&nbsp;&nbsp;<span style=\"font-family:'맑은 고딕','돋움';color:#00789f\">"+szFactory+"</span>";
					}
					xstrLine += "</span></a></td>";
					xstrLine += "<td>&nbsp;</td>";
					xstrLine += "<td width=\"75\" style=\"font-family:'돋움';line-height:15px;font-size:11px;\">"+strViewCdate+"</td>";
					xstrLine += "</tr>";
					xstrLine += "</table></td>";
					xstrLine += "</tr>";
					if (strCopyPhrase.trim().length() > 0 && !strCate4.equals("0703") && !strCate4.equals("0714") && !strCate4.equals("0925") && !CutStr.cutStr(strCate4,2).equals("14") && !CutStr.cutStr(strCate4,2).equals("15") && (intMallCnt > 0  || strOpenExpectFlag.equals("1") ) && DateUtil.getDaysBetween(strCdate,"2000-12-31") >= 0){
						String strCopyPhraseTitle = "";
						strCopyPhrase = ReplaceStr.replace(strCopyPhrase,"★","▶");
						strCopyPhrase = ReplaceStr.replace(strCopyPhrase,"\"","&quot;");
						if (strCdate.trim().length() > 0 && DateStr.getYMD(strCdate,"Y").length() == 4 ){
							strCopyPhraseTitle = strCopyPhrase ;
							if (strOpenExpectFlag.equals("0") && DateUtil.getDaysBetween(strCdate,DateStr.nowStr()) < 0){
								strCopyPhraseTitle = strCopyPhraseTitle + " _" + DateStr.getYMD(strCdate,"Y").substring(2,4) + "년" + " " + Integer.parseInt(DateStr.getYMD(strCdate,"M")) + "월";
							}
						} 
						xstrLine += "<tr>";
						xstrLine += "<td height=\"20\" style=\"font-family:돋움;font-size:8px;padding-left:5px;\"><div style=\"width:540px;height:14px;overflow:hidden;\"><a href=\""+mailUrl+"/view/Detailmulti.jsp?cateListLayerFlag=Y&tailflag=Y&from=recmail&modelno="+iModelno+"\" title=\"에누리 가격비교\" target=\"_blank\" style=\"line-height:14px;text-decoration:none;\"><span style=\"font-family:'돋움';color:#00789f;font-size:11px;\">"+strCopyPhrase+"</span></a></div></td>";
						xstrLine += "</tr>";
					}else{
						xstrLine += "<tr><td><div style=\"width:10px;height:5px;overflow:hidden;\"></div></td></tr>";
					}
					xstrLine += "<tr>";
					xstrLine += "<td style=\"font-family:'돋움';font-size:12px;color:#444444;line-height:15px;padding-left:5px;\">"+szSpec+"</td>";
					xstrLine += "</tr>";
					xstrLine += "</table><div style=\"width:500px;height:15px;overflow:hidden;\"></div></td>";
					xstrLine += "</tr>";
					xstrLine += "</table></td>";
					xstrLine += "</tr>";
					xstrLine += "<tr>";
					xstrLine += "<td>";
					xstrLine += "<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\"><tr>";
					xstrLine += "<td align=\"center\"><div style=\"width:10px;height:12px;overflow:hidden;\"></div><a href=\""+mailUrl+"/view/Detailmulti.jsp?tailflag=Y&from=recmail&goodsBbsOpenType=2&modelno="+iModelno+"\" title=\"새로운 댓글 확인하러 가기\" target=\"_blank\"><img src=\"http://img.enuri.info/images/blank.gif\" width=0 height=0 border=0 /><img src=\""+IMG_ENURI_COM+"/images/mailing/mailimage/go_newbbs.gif\" border=0/></a><div style=\"width:10px;height:10px;overflow:hidden;\"></div></td>";
					xstrLine += "</tr>";
					xstrLine += "</table></td>";
					xstrLine += "</tr>";
					xstrLine += "</table></td>";
					xstrLine += "</tr>";
					xstrLine += "<tr><td><img src=\""+IMG_ENURI_COM+"/images/mailing/mailimage/box_03.gif\" width=\"737\" height=\"20\" /></td></tr>";
					xstrLine += "</table></td>";
					xstrLine += "</tr>";
					xstrLine += "</table></td>";
					xstrLine += "</tr>";
					xstrLine += "<tr>";
					xstrLine += "<td><div style=\"width:10px;height:20px;overflow:hidden;\"></div></td>";
					xstrLine += "</tr>";
					xstrLine += "<tr>";
					xstrLine += "<td>";
					
					for(int i=0; i<mail_list.length; i++){
						xstrLine2 = xstrLine;
						xstrLine2 += "<table width=\"700\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" align=\"center\">";
						xstrLine2 += "<tr>";
						xstrLine2 += "<td width=620 height=40 align=right style=\"font-family:'돋움';font-size:11px;\">메일을 받지 않으시려면 우측의 수신거부 버튼을 눌러주세요.</td>";
						xstrLine2 += "<td width=80 align=center><a href=\""+mailUrl+"/view/goodsbbs/Goods_bbs_proc.jsp?procType=refusemail&modelno="+iModelno+"&email="+mail_list[i].getEmail()+"&key="+SecurityUtil.encodeMD5Str(mail_list[i].getEmail())+"\" title=\"수신거부\" target=\"_blank\"><img src=\""+IMG_ENURI_COM+"/images/mailing/mailimage/refuse_mail.gif\" width=\"71\" height=\"22\" border=0/></a></td>";
						xstrLine2 += "</tr>";
						xstrLine2 += "</table>";
						xstrLine2 += "</td>";
						xstrLine2 += "</tr>";
						xstrLine2 += "</table>";
						xstrLine2 += "</body>";
						xstrLine2 += "</html>";
						boolean mailChk = com.enuri.util.mail.SendMail.sendMailAry(mail_list[i].getEmail(), xstrFromName, xstrFromMail, xstrSubject, xstrLine2);
					}
				}
			}
			if(interest_flag.equals("1") && !interest_email.equals("")){
				//댓글알림메일 등록
				mail_list = Goods_BBS_Proc.Goods_BBS_MailList(smodelnos, interest_email);
				if(mail_list==null || mail_list.length==0){
					Goods_BBS_Proc.Goods_BBS_MailIns(modelno, userid, usernm, interest_email);
				}
				cb.SetCookie("KNOWBOX", "TO_EMAIL", interest_email);
				cb.SetCookieExpire("KNOWBOX",-1); //창이 닫힐때 없앰
				cb.responseAddCookie(response);
			}
		}
		if(cutFlag){
%>
			<script language="JavaScript">
			alert("2000자 이상은 입력 하실 수 없습니다.");
			</script>
<%
			return;
		}else{
%>
			<script language="JavaScript">
			// 게시판 탭의 개수 맞추기
			try {
				var bbsNumObj = top.document.getElementById("tab2TD_txt");
				var bbsNum = 0;
				if(bbsNumObj.innerHTML!="") {
					bbsNum = parseInt(bbsNumObj.innerHTML)+1;
				} else {
					bbsNum = 1;
				}
				bbsNumObj.innerHTML = bbsNum;
			} catch(e) {
			}
			parent.cmdAfterKbWrite();
			</script>
<%
		}
	}
}else if(procType.equals("del")) {
	if (refer.indexOf("enuri.com") < 0 && refer.indexOf("100.100.100.") < 0 && refer.indexOf("58.234.199.") < 0 ){
		return;
	}
	int del_modelno = ChkNull.chkInt(request.getParameter("del_modelno"));
	int del_no = ChkNull.chkInt(request.getParameter("del_no"));
	String del_pass = ChkNull.chkStr(request.getParameter("del_pass"));
	
	String del_usernm = cb.GetCookie("MEM_INFO","USER_NICK");
	String del_userid = cb.GetCookie("MEM_INFO","USER_ID");
	if(del_userid.equals("")){
		del_usernm = cb.GetCookie("MEM_INFO","LOGIN_NICK");
	}
	String del_ip = request.getRemoteAddr();
	
	//비밀번호 체크
	Goods_BBS_Data gb_data = Goods_BBS_Proc.Goods_BBS_One(del_modelno, del_no);
	if(gb_data==null){
		return;
	}
	String userid = gb_data.getUserid();
	String usernm = gb_data.getUsernm();
	boolean validPwd = false; //비번체크 결과
	//System.out.println("userid:"+userid+",usernm:"+usernm);
	if(!userid.equals("")){ //회원 비번 체크
		String strIsPassCaps = Members_Proc.getUserIsPassCaps(userid);
		if(!strIsPassCaps.equals("1")){ //대문자 사용가능이 아니면 소문자로 변경
			del_pass = del_pass.toLowerCase();
		}
		Members_Data members_data = Members_Proc.Login_Check( userid , del_pass ); //사용자 정보
		String errCode = ChkNull.chkStr(members_data.getErrCode());
		if(errCode.trim().length() == 0){ //정상
			validPwd = true;
		}
	}else{ //비회원 비번 체크
		int iNickCheck = Members_Proc.Nick_Login_Check(usernm, del_pass);
		if(iNickCheck==0){
			validPwd = true;
		}
	}
	if(validPwd){
		int deleteRtn = Goods_BBS_Proc.Goods_BBS_Delete(del_modelno, del_no, del_ip, del_userid, del_usernm);
		Know_box_Proc.update_Kbnum(del_modelno, -1);
%>
		<script language="JavaScript">
		// 게시판 탭의 개수 맞추기
		try {
			var bbsNumObj = top.document.getElementById("tab2TD_txt");
			var bbsNum = 0;
			if(bbsNumObj.innerHTML!="") {
				bbsNum = parseInt(bbsNumObj.innerHTML)-1;
			}
			if(bbsNum!=0) {
				bbsNumObj.innerHTML = bbsNum;
			} else {
				bbsNumObj.innerHTML = "";
			}
		} catch(e) {
		}
		parent.cmdAfterKbDel();
		</script>
<%
	}else{
%>
		<script language="JavaScript">
		parent.showDelMsgFlase(<%=del_modelno%>, <%=del_no%>);
		</script>
<%
	}
}else if(procType.equals("refusemail")) { //메일 수신거부
	out.println("<script language=\"JavaScript\">");
	String email = ChkNull.chkStr(request.getParameter("email"));
	String key = ChkNull.chkStr(request.getParameter("key"));
	if(modelno>0 && !email.equals("") && !key.equals("")){
		if(SecurityUtil.encodeMD5Str(email).equals(key)){
			Goods_BBS_Proc.Goods_BBS_MailDel(modelno, email);
			out.println("alert('해당 상품의 댓글 알림이 중지되었습니다.');");
		}
	}
	out.println("location.replace('/');");
	out.println("</script>");
}
%>