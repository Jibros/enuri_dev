<%@ include file="/lsv2016/include/IncAjaxHeader.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Knowcom_Data3"%>
<%@ page import="com.enuri.bean.knowbox.Knowbox2_data"%>
<%@ page import="com.enuri.bean.knowbox.Knowbox2_review_data"%>
<%@ page import="org.json.JSONArray"%>
<%@ page import="org.json.JSONObject"%>
<%@ page import="com.enuri.util.common.JsonResponse"%>
<%
	
	/*
	parameter 
		page : page 번호 ( list 필수 )
		type : insert or list ( CI : insert , CL : list )
		modelno : 모델 번호 ( insert or list 필수 )
		ca_code : ca_code ( insert 필수 )
		title : 제목 ( insert 필수 )
		content : 내용 (insert 필수 )
	*/
	if(!CvtStr.isNumeric(request.getParameter("modelno"))){
		return ;
	}
	String strReferer = ChkNull.chkStr(request.getHeader("referer"));
	int intModelno = ChkNull.chkInt(request.getParameter("modelno"),0);
	String strCa_code = ChkNull.chkStr(request.getParameter("ca_code"),"");
	int intPage = ChkNull.chkInt(request.getParameter("page"),1);
	String strType = ChkNull.chkStr(request.getParameter("type"),"");
	String strkb_title = HtmlStr.replaceHtmlTags(ChkNull.chkStr(request.getParameter("title"),""));
	String strkb_content = HtmlStr.replaceHtmlTags(ChkNull.chkStr(request.getParameter("content"),""));
	
	JsonResponse ret = null;
    String memberId = cb.GetCookie("MEM_INFO","USER_ID");
	String userGroup = cb.GetCookie("MEM_INFO","USER_GROUP");// 0:일반사용자, 1:관리자
	String sKb_nickname = cb.GetCookie("MEM_INFO","USER_NICK");
	String sUser_ip = request.getRemoteAddr();
	
	boolean referer = false;
	String resultMsg = "";
	Knowbox2_review_data knowbox2_review_data = new Knowbox2_review_data();
	Knowcom_Data3 knowcom3 = new Knowcom_Data3();
	JSONObject jSONObject = new JSONObject();
	
	if( (strReferer != null && !strReferer.equals("") && strReferer.indexOf(".enuri.com") > -1) || 
		request.getServerName().trim().equals("dev.enuri.com") || request.getServerName().trim().equals("stagedev.enuri.com") || request.getServerName().trim().equals("my.enuri.com")){
		referer = true;
	}
	
	if(!referer){
		return;
	}else{
		if(strType.equals("CI")){
			if(memberId.equals("")){
				resultMsg = "fail";
			}else{
				int kb_no = -1; 
				int result = 0 ;
				String sLCateCode = strCa_code.substring(0,2);
				String sMCateCode = strCa_code;
				kb_no = knowbox2_review_data.SaveInsert(kb_no, "17", intModelno, strCa_code, memberId, strkb_title, strkb_content, "1", "0", "", "", "", "", "", "", "", "0", "", "", "0", "", "", sKb_nickname, "001", sUser_ip, "", "", "", "0", "");	
				if(kb_no>0){
					result = knowbox2_review_data.SaveCateInsert(kb_no, sLCateCode, sMCateCode);
					if(result>0){
						resultMsg = "success";
					}else{
						resultMsg = "fail";
					}
				}else{
					resultMsg = "fail";
				}
			}
		}else if(strType.equals("CL")){
			if(intModelno>0){
				resultMsg = "success";
				jSONObject = knowcom3.getCmQnaList(strCa_code, intModelno,intPage,10);
			}
		}
	} 
	ret = new JsonResponse(true).setData(jSONObject).setTotal(knowcom3.getCmQnaCnt(intModelno));
    out.println(ret.toString());
%>
