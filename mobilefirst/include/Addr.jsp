<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Post_Data"%>
<%@ page import="com.enuri.bean.knowbox.Post_Proc"%>
<jsp:useBean id="Post_Data" class="com.enuri.bean.knowbox.Post_Data"  />
<jsp:useBean id="Post_Proc" class="com.enuri.bean.knowbox.Post_Proc"  />

<%
	String strNewType = ChkNull.chkStr(request.getParameter("newtype"),"N"); 	//Y:도로명주소, N:지번주소
	String strKeyword = ChkNull.chkStr(request.getParameter("keyword"));
	
	String strZip1 = "";
	String strZip2 = "";
	String strNewZip = "";
	String strAddrDetail = "";
	String strAddr = "";
	
	if(!strKeyword.equals("")){
		Post_Data[] post_data = null;
		if(strNewType.equals("Y")){ //도로명 주소
			String road_name = strKeyword;
			String bd_code1 = ""; 
			String bd_code2 = "";
			if(strKeyword.indexOf(" ")>0){
				road_name = strKeyword.substring(0, strKeyword.indexOf(" "));
				bd_code1 = strKeyword.substring(strKeyword.indexOf(" ")+1);
				if(bd_code1.indexOf(" ")>0){
					bd_code1 = bd_code1.substring(bd_code1.indexOf(" "));
				}
				if(bd_code1.indexOf("-")>0){
					bd_code2 = bd_code1.substring(bd_code1.indexOf("-")+1);
					bd_code1 = bd_code1.substring(0, bd_code1.indexOf("-"));
				}
			}
			post_data = Post_Proc.getRoad_List(road_name, bd_code1, bd_code2);
		}else{
			post_data = Post_Proc.getData_List(strKeyword);
		}
		
		int lenAddr = 0;
		
		if(post_data!=null){
			lenAddr = post_data.length;
		}
		
		if(lenAddr >= 13){
			
	    }else{
	    
	    }
		
		out.println(" { ");
		out.println(" 	\"addrList\": [ "); 
		
		if(lenAddr>0){
			for(int i=0; i < lenAddr; i++){ 
				strZip1 = post_data[i].getP_code().substring(0,3);
				strZip2 = post_data[i].getP_code().substring(post_data[i].getP_code().length()-3,post_data[i].getP_code().length());
				strNewZip = post_data[i].getP_code();
				
				if(strNewType.equals("Y")){ //도로명 주소
					strAddr = post_data[i].getCity() + " " + post_data[i].getGu() + " " + post_data[i].getRoad_name();
					if(!post_data[i].getBd_code_main().equals("0")){
						strAddr += " " + post_data[i].getBd_code_main();
						if(!post_data[i].getBd_code_sub().equals("0")){
							strAddr += "-" + post_data[i].getBd_code_sub();
						}
					} 
					if(!post_data[i].getBatch_name().equals("")){
						strAddr += " " + post_data[i].getBatch_name();
					}
					strAddrDetail = strAddr;
				}else{
					strAddrDetail = post_data[i].getDong_detail();
					strAddr = post_data[i].getDong_d();
				} 
				//out.println("strAddrDetail=="+strAddrDetail+"<br>");
				//out.println("strAddr=="+strAddr+"<br>");
				out.println("			{ ");
				//out.println("			\"zip1\":\""+strZip1+"\", ");
				//out.println("			\"zip2\":\""+strZip2+"\", ");
				out.println("			\"newzip\":\""+strNewZip+"\", ");
				out.println("			\"strAddr\":\""+strAddr+"\", ");
				out.println("			\"strAddrDetail\":\""+strAddrDetail+"\" ");
				out.println("			} ");
				out.println("\r\n	   ");	
				if( i < lenAddr-1 ) out.println(" , ");	
			}
		}else{ 
			out.println("			{ }");
		}
		out.println("			] "); 
		out.println(" } ");
	}
%>	
	