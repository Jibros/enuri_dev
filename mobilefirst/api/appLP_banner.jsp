<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.main.Banner_List_Proc"%>
<%@ page import="com.enuri.bean.main.Banner_List_Data"%>
<%
/******************************************
	title : app용 LP 상단 배너 api
	auth : 2016-11-15 shwoo
	info : 손진욱팀장 요청 banner_target 두개로 운영
******************************************/
Banner_List_Proc banner_list_proc_new = new Banner_List_Proc();
Banner_List_Data[] banner_list_data_new = null;
String bannerUrlEx = "";

String strCate = ChkNull.chkStr(request.getParameter("cate"),"00000000");	//카테고리
			
banner_list_data_new = banner_list_proc_new.getDetailmultiBannerList(strCate,"T");
			
int intBannerCount = 0; 
			
if (banner_list_data_new != null && banner_list_data_new.length > 0 ){ 
	out.println("{");
		for (int i=0;i<1;i++){ 
			if(banner_list_data_new[i].getRedirect_url().indexOf("http://m.enuri.com/mobilefirst/event/event_shopping.jsp") > -1){
				bannerUrlEx = "event"; 
			}else if(banner_list_data_new[i].getRedirect_url().indexOf("/mobilefirst/") > -1){
				bannerUrlEx = "event";
			}else{
				bannerUrlEx = "outlink";
			}
			out.println("	\"banner_name\": \""+ banner_list_data_new[i].getBanner_name() +"\", ");
			out.println("	\"banner_target_and\": \"/move/Redirectad.jsp?register_no="+ banner_list_data_new[i].getBanner_no() + "&pageNm=list&from=m&freetoken="+ bannerUrlEx +"\", ");
			out.println("	\"banner_target_ios\": \"/move/Redirectad.jsp?register_no="+ banner_list_data_new[i].getBanner_no() + "&pageNm=list&from=m&freetoken="+ bannerUrlEx +"\", ");
			out.println("	\"banner_image\": \""+ ConfigManager.STORAGE_ENURI_COM + "/banner/"+ banner_list_data_new[i].getBanner_source_file() +"\", ");
			out.println("	\"banner_cate\": \""+ banner_list_data_new[i].getCa_code() +"\" ");
			
		}
	out.println("}");
}else{
	out.println("{}");
}
%>