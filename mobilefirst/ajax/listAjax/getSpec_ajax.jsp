<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilenew/include/Base_Inc_Mobile.jsp"%>

<%@ page import="com.enuri.bean.mobile.Spec_Group_Proc"%>
<%@ page import="com.enuri.bean.mobile.Spec_Group_Data"%>
<jsp:useBean id="Spec_Group_Proc" class="com.enuri.bean.mobile.Spec_Group_Proc" scope="page" />
<jsp:useBean id="Spec_Group_Data" class="com.enuri.bean.mobile.Spec_Group_Data" scope="page" />
 
<%
	String strCate = ChkNull.chkStr(request.getParameter("cate"),"00000000");
	String strSelSpec = ChkNull.chkStr(request.getParameter("sel_spec"));	
	String strChecked = "";
	
	if(strCate.length() >= 4){
		strCate = strCate.substring(0,4);
	}
	//strCate = "0201";
	int i = 0;
	int iGpno = 0;
	int iCnt = 0;
	
	String strTitle = "";
	 
	String[] astrGetSpec = strSelSpec.split(",");

%>
{
<%

try {
	Spec_Group_Data[] spec_group_list= null;
	spec_group_list = Spec_Group_Proc.Spec_Group_List2(strCate);
	
	for ( i=0 ; i < spec_group_list.length ; i++){
		strChecked = "";
		
		for (int j=0; j < astrGetSpec.length; j++){
			if (astrGetSpec[j].trim().equals(spec_group_list[i].getIntSpecNo()+"")){
				strChecked = "selected";
			}
		}	
		
		strTitle = spec_group_list[i].getStrSpecCateTitle();
		
		if(spec_group_list[i].getIntGpno() == 491){
			strTitle = "형태별";
		}
		
		if(i==0) out.print(" 	\"specList\":[ \r\n");
		if(iGpno != spec_group_list[i].getIntGpno()){
			if(i>0) out.print("	 				}	\r\n");
			if(i>0) out.print("	 			] \r\n");
			if(i>0) out.print("			 }, \r\n");
			out.print("			{ \"gpno\":\""+spec_group_list[i].getIntGpno()+"\",\r\n ");
			out.print("		 	  \"spec_group_title\":\""+strTitle+"\",\r\n "); 
			out.print("		 	  \"spec\": [ \r\n "); 
		}else{ 
			out.print("					 }, \r\n");
		}
			out.print("		 	  		{\"specno\":\""+spec_group_list[i].getIntSpecNo()+"\",\r\n "); 
			out.print("		 	  		\"specChk\":\""+strChecked+"\",\r\n "); 
			out.print("		  	  		\"spec_cate_title\":\""+spec_group_list[i].getStrSpecGroupTitle()+"\",\r\n "); 
			if(spec_group_list[i].getStrSpecGroupDelFlag().equals("9")){
				out.print("		  	  		\"spec_delflag\":\""+spec_group_list[i].getStrSpecGroupDelFlag()+"\",\r\n "); 
			}else{
				iCnt = iCnt + 1;
			}
			out.print("		  	  		\"gpno_aoflag\":\""+spec_group_list[i].getStrSpecCateAoflag()+"\",\r\n "); 
			out.print("		  	  		\"gpsno_aoflag\":\""+spec_group_list[i].getStrSpecCateDetailAoflag()+"\",\r\n "); 
			out.print("		  	  		\"gpsno\":\""+spec_group_list[i].getIntGpsno()+"\",\r\n "); 
			out.print("			  		\"ca_code\":\""+spec_group_list[i].getStrCacode()+"\" \r\n "); 

		if( i == spec_group_list.length-1 ) {
				out.println("}  ]	 ");
				out.println(" } \r\n	] ");
		}
		iGpno = spec_group_list[i].getIntGpno();
 
	}
	
} catch(Exception e) {
}
%>
}