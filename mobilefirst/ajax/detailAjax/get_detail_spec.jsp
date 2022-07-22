<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.mobile.Goods_Spec_Detail_Data"%>
<%@ page import="com.enuri.bean.mobile.Goods_Spec_Detail_Proc"%>
<jsp:useBean id="Goods_Spec_Detail_Data" class="com.enuri.bean.mobile.Goods_Spec_Detail_Data" scope="page" />
<jsp:useBean id="Goods_Spec_Detail_Proc" class="com.enuri.bean.mobile.Goods_Spec_Detail_Proc" scope="page" />
<%
	int intModelno = ChkNull.chkInt(request.getParameter("modelno"),0);
%>
{
<%
try {
	Goods_Spec_Detail_Data[] spec_list = null;
	spec_list = Goods_Spec_Detail_Proc.get_list(intModelno);
	
	String strTitle = "";
	String strContent = "";
	String strCenncnt = "";
	String strGroupnm = "";
	
	if(spec_list != null && spec_list.length > 0){
		out.println("	\"detailSpec\": [");
		for(int i=0;i<spec_list.length; i++) {
			strTitle = spec_list[i].getTitle();
			strContent = spec_list[i].getContent();
			strCenncnt = spec_list[i].getCellcnt()+"";
			strGroupnm = spec_list[i].getGroupnm();
			
			if(strContent == null) strContent = "";
			
			strTitle = strTitle.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
			strContent = strContent.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
			strGroupnm = strGroupnm.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
			
			if(i>0) out.print(",\r\n");
			
			out.print("		{ ");
			if(spec_list[i].getTitle().equals("-")){
				out.print(" \"specTitle\":\"\", ");
			}else{
				out.print(" \"specTitle\":\""+ toJS(strTitle)+"\", ");
			}
				out.print(" \"specContent\":\""+ toJS(strContent) +"\", ");
				out.print(" \"specCellcnt\":\""+ toJS(strCenncnt) +"\", ");
				
			if(spec_list[i].getGroupnm().equals("-") ){
				out.print(" \"specGroupname\":\"\" ");
			}else{
				out.print(" \"specGroupname\":\""+ toJS(strGroupnm) +"\" ");
			}
			out.print(" }");
		}
		out.println("\r\n	]");
	}
} catch(Exception e) {
}
%>
}