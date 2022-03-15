<%@page import="com.enuri.bean.main.Nw_GNB_List_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.enuri.util.common.*"%>
<%@ page import="com.enuri.include.RandomMain"%>
<%@ page import="com.enuri.bean.main.GNB_List_Data"%>
<%@ page import="com.enuri.bean.main.GNB_List_2021_Proc"%>
<%
	String ajax_flag   = ChkNull.chkStr(request.getParameter("ajax"));     //y:Ajax호출=미사용
	int g_seq          = ChkNull.chkInt(request.getParameter("g_seq"),1);  //대대분류코드
	String stype       = ChkNull.chkStr(request.getParameter("stype"));    //"":카테고리, detail:자세히보기, allmenu:전체메뉴, banner:gnb배너
	
	//GNB_List_2021_Proc     GNB_List_Proc       = new GNB_List_2021_Proc();
	Nw_GNB_List_Proc     GNB_List_Proc       = new Nw_GNB_List_Proc();
	GNB_List_Data gnb_one = GNB_List_Proc.getGNB_One(g_seq); //대대분류 정보
	GNB_List_Data[] gnb_list_0     = GNB_List_Proc.getGNB_List(1, 0); //대대분류 목록
	StringBuilder sbGnbList     = new StringBuilder();
	
//gnb 카테고리
if(stype.equals("")){
	
	if( gnb_list_0!=null && gnb_list_0.length>0 ){
		for(int i=0; i<gnb_list_0.length; i++){
			
			String active = "";
			
			if(i == 0){
				active = "active";
			}
			sbGnbList.append("<li class='cate-item--depth1 "+active+"' id='gnbTop"+gnb_list_0[i].getG_seqno()+"' >");
				sbGnbList.append("<div class='cate__tit'>"+gnb_list_0[i].getG_name()+"</div>");

				GNB_List_Data[] gnb_list_1 = GNB_List_Proc.getGNB_List(2,gnb_list_0[i].getG_seqno()); //대분류 목록

				if(gnb_list_1!=null && gnb_list_1.length>0){
					
					String groupCate = "";
					sbGnbList.append("<div class='cate--depth2_bundle'>");
					for(int j=0; j<gnb_list_1.length; j++){
					
						String bd_lcate_nm = gnb_list_1[j].getBd_lcate_nm();

						GNB_List_Data[] gnb_list_2 = GNB_List_Proc.getGNB_List(3, gnb_list_1[j].getG_seqno()); //중분류 목록

						if(j != 0){
							if(!StringUtils.equals(groupCate, bd_lcate_nm)){
								if(gnb_list_2.length > 0){
									sbGnbList.append("</ul>");	
								}
								
							}
						}
						
						if(!StringUtils.equals(groupCate, bd_lcate_nm)){
							//sbGnbList.append("<a href='"+link+"' class='cate--depth2_bundle__title'>"+bd_lcate_nm+"</a>");
							if(gnb_list_2.length > 0){
								sbGnbList.append("<div class='cate--depth2_bundle__title'>"+bd_lcate_nm+"</div>");
								sbGnbList.append("<ul class='cate--depth2'>");	
							}
						}
						
						if(gnb_list_2.length > 0){
						
						sbGnbList.append("<li class='cate-item--depth2'>");
						String insertLog = "";
						
				        if((i+1) == 1)			insertLog = "onclick='insertLog(26539)'";
				        else if((i+1) == 2)		insertLog = "onclick='insertLog(26540)'";
				        else if((i+1) == 3)		insertLog = "onclick='insertLog(26541)'";
				        else if((i+1) == 4)		insertLog = "onclick='insertLog(26542)'";
				        else if((i+1) == 5)		insertLog = "onclick='insertLog(26543)'";
				        else if((i+1) == 6)		insertLog = "onclick='insertLog(26544)'";
				        else if((i+1) == 7)		insertLog = "onclick='insertLog(26545)'";
				        else if((i+1) == 8)		insertLog = "onclick='insertLog(26546)'";
				        else if((i+1) == 9)		insertLog = "onclick='insertLog(26547)'";
				        else if((i+1) == 10)	insertLog = "onclick='insertLog(26548)'";
				        else if((i+1) == 11)	insertLog = "onclick='insertLog(26549)'";
						
				        String link = ChkNull.chkStr(gnb_list_1[j].getG_link());	
						
				        if(link.equals("")){
				        	link = "javascript:///";
				        }
				        
						sbGnbList.append("<a href='"+link+"' "+insertLog+"  class='cate__tit'>"+gnb_list_1[j].getG_name()+"</a>");
						sbGnbList.append("<ul class='cate--depth3'>");
						
					        for(int k=0; k<gnb_list_2.length; k++){
					        
					        if(k == 0){
					        	
						        if((i+1) == 1)			insertLog = "onclick='insertLog(26550)'";
						        else if((i+1) == 2)		insertLog = "onclick='insertLog(26551)'";
						        else if((i+1) == 3)		insertLog = "onclick='insertLog(26552)'";
						        else if((i+1) == 4)		insertLog = "onclick='insertLog(26553)'";
						        else if((i+1) == 5)		insertLog = "onclick='insertLog(26554)'";
						        else if((i+1) == 6)		insertLog = "onclick='insertLog(26555)'";
						        else if((i+1) == 7)		insertLog = "onclick='insertLog(26556)'";
						        else if((i+1) == 8)		insertLog = "onclick='insertLog(26557)'";
						        else if((i+1) == 9)		insertLog = "onclick='insertLog(26558)'";
						        else if((i+1) == 10)	insertLog = "onclick='insertLog(26559)'";
						        else if((i+1) == 11)	insertLog = "onclick='insertLog(26560)'";
					        	
						        if(!link.equals("javascript:///")){
						        	sbGnbList.append("<li class='cate-item--depth3' >");
						        	sbGnbList.append("<a href='"+link+"' "+insertLog+"  class='cate__tit'>전체보기</a>");
						        	sbGnbList.append("</li>");	
						        }
					        		
							}
					        	
							sbGnbList.append("<li class='cate-item--depth3'  >");
							
							String glink = ChkNull.chkStr(gnb_list_2[k].getG_link());
							
					        if((i+1) == 1)			insertLog = "onclick='insertLog(26561)'";
					        else if((i+1) == 2)		insertLog = "onclick='insertLog(26562)'";
					        else if((i+1) == 3)		insertLog = "onclick='insertLog(26563)'";
					        else if((i+1) == 4)		insertLog = "onclick='insertLog(26564)'";
					        else if((i+1) == 5)		insertLog = "onclick='insertLog(26565)'";
					        else if((i+1) == 6)		insertLog = "onclick='insertLog(26566)'";
					        else if((i+1) == 7)		insertLog = "onclick='insertLog(26567)'";
					        else if((i+1) == 8)		insertLog = "onclick='insertLog(26568)'";
					        else if((i+1) == 9)		insertLog = "onclick='insertLog(26569)'";
					        else if((i+1) == 10)	insertLog = "onclick='insertLog(26570)'";
					        else if((i+1) == 11)	insertLog = "onclick='insertLog(26571)'";
							
							sbGnbList.append("<a href='"+glink+"' "+insertLog+" class='cate__tit'>"+gnb_list_2[k].getG_name()+"</a>");
							sbGnbList.append("</li>");
							}
						sbGnbList.append("</ul>");
						sbGnbList.append("</li>");

						}
						
						groupCate = bd_lcate_nm;
					}
					sbGnbList.append("</div>");
				}

			sbGnbList.append("</li>");
		}
	}
    out.println(sbGnbList.toString().replaceAll("(\\>)([\\s\\t\\r\\n]+)(\\<)","$1$3"));
}
%>