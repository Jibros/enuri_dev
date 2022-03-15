<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.enuri.util.common.*"%>
<%@ page import="com.enuri.bean.main.View_Cate_Mngm_Data"%>
<%@ page import="com.enuri.bean.main.View_Cate_Mngm_Proc"%>
<%
int viewCnt = ChkNull.chkInt(request.getParameter("viewCnt"),3);  //노출갯수

View_Cate_Mngm_Proc view_cate_mngm_proc = new View_Cate_Mngm_Proc();
View_Cate_Mngm_Data[] data = view_cate_mngm_proc.getViewCate(viewCnt); 

StringBuilder sbGnbCate = new StringBuilder();
int logno = 24246;

//gnb 주요 카테고리
if(data!=null && data.length>0){
	for(int i=0; i<data.length; i++){
		sbGnbCate.append("<li class=\"header-cate__item\"><a href=\""+data[i].getLnk_url()+"\" onclick=\"insertLog("+data[i].getLog_no()+");insertLog("+(logno+i)+");\"><i class=\"ico\">");
		if(data[i].getIcn_url().length()>0){
			sbGnbCate.append("		<img src=\""+data[i].getIcn_url()+"\" width=\"18\" height=\"18\" alt=\"\" />");
		}
	    sbGnbCate.append("		</i>"+data[i].getView_cate_nm()+"</a></li>");
	}
}
out.println(sbGnbCate.toString().replaceAll("(\\>)([\\s\\t\\r\\n]+)(\\<)","$1$3"));
%>