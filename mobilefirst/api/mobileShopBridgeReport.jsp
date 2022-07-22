<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.mobile.Mobile_Shop_Bridge_Log_Data"%>
<%@ page import="com.enuri.bean.mobile.Mobile_Shop_Bridge_Log_Proc"%>
<jsp:useBean id="Mobile_Shop_Bridge_Log_Data" class="com.enuri.bean.mobile.Mobile_Shop_Bridge_Log_Data"
	scope="page" />
<jsp:useBean id="Mobile_Shop_Bridge_Log_Proc" class="com.enuri.bean.mobile.Mobile_Shop_Bridge_Log_Proc"
	scope="page" />


<%
	
	String search_date = ChkNull.chkStr(request.getParameter("search_date"),"");
	String mobl_mchnt_dcd = ChkNull.chkStr(request.getParameter("app_type"),"");
	
	int con_frst_cnt = 0;
	int con_tot_cnt = 0;
	int con_usr_cnt = 0;
	int spm_con_e_cnt = 0;
	int con_usr_e_cnt = 0;

	
	if(search_date.length()>0){
		//a. 쇼핑몰 연결수(1회차)
		con_frst_cnt = Mobile_Shop_Bridge_Log_Proc.getShopBridgeLogFirst(search_date, mobl_mchnt_dcd);
		
		//b. 쇼핑몰 연결수(합계)
		con_tot_cnt = Mobile_Shop_Bridge_Log_Proc.getShopBridgeLogTot(search_date, mobl_mchnt_dcd, "Y");
		
		Mobile_Shop_Bridge_Log_Data[] msbld = null;
		//c. 쇼핑몰 연결 활성 사용자 
		msbld = Mobile_Shop_Bridge_Log_Proc.getShopBridgeLogUserTot(search_date, mobl_mchnt_dcd);
		if(msbld!=null){
			String returnVal = "";
			for(int i=0; i<msbld.length; i++){
				returnVal = Moble_Shop_Bridge_Log_Proc.getMemberServiceFlag(msbld[i].getEnr_usr_id());
				if(returnVal.equals("0") || returnVal.equals("5")){
					con_usr_cnt++;
				}
			}
		}
		
		//d. 쇼핑몰 연결 종료
		spm_con_e_cnt = Mobile_Shop_Bridge_Log_Proc.getShopBridgeLogTot(search_date, mobl_mchnt_dcd, "N");
		
		Mobile_Shop_Bridge_Log_Data[] msbld2 = null;
		//e. 쇼핑몰 비활성 사용자 
		msbld2 = Mobile_Shop_Bridge_Log_Proc.getShopBridgeLogUserETot(search_date, "N", mobl_mchnt_dcd);
		if(msbld!=null){
			String returnVal = "";
			for(int i=0; i<msbld2.length; i++){
				returnVal = Mobile_Shop_Bridge_Log_Proc.getMemberServiceFlag(msbld2[i].getEnr_usr_id());
				if(returnVal.equals("0") || returnVal.equals("5")){
					con_usr_e_cnt++;
				}
			}
		}
		
		out.println("{");
		out.println("	   \"search_date\": \""+ search_date +"\", ");
		out.println("	   \"con_frst_cnt\": \""+ con_frst_cnt +"\", ");
		out.println("	   \"con_tot_cnt\": \""+ con_tot_cnt +"\", ");
		out.println("	   \"con_usr_cnt\": \""+ con_usr_cnt +"\", ");
		out.println("	   \"spm_con_e_cnt\": \""+ spm_con_e_cnt +"\", ");
		out.println("	   \"con_usr_e_cnt\": \""+ con_usr_e_cnt +"\" ");
		out.println("}");
	}
%>