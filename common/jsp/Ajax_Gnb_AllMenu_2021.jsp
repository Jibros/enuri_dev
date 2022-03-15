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
	int clicklogNo = 24250;
	if( gnb_list_0!=null && gnb_list_0.length>0 ){
		for(int i=0; i<gnb_list_0.length; i++){
			if(i==0) sbGnbList.append("<li class=\"cate-item--depth1 is--on\">");
			else sbGnbList.append("<li class=\"cate-item--depth1\">");
			sbGnbList.append("<p class=\"cate__tit\">"+gnb_list_0[i].getG_name()+"</p>");
			GNB_List_Data[] gnb_list_1 = GNB_List_Proc.getGNB_List(2, gnb_list_0[i].getG_seqno()); //대분류 목록
			if(gnb_list_1!=null && gnb_list_1.length>0){
			    for(int j=0; j<gnb_list_1.length; j++){
			    	
			    	
			    	
		    		if(j==0){
				    	sbGnbList.append("<div class=\"cate-item__expend\">");
				    	sbGnbList.append("	<ul class=\"cate--depth2\">");
		    		}
	            	
		    		GNB_List_Data[] cnt = GNB_List_Proc.getGNB_List(3, gnb_list_1[j].getG_seqno()); //중분류 목록
	                if(cnt.length > 0){
	                	sbGnbList.append("		<li class=\"cate-item--depth2\">");	
	                }
		    		
			    	//sbGnbList.append("		<li class=\"cate-item--depth2\">");
		    		sbGnbList.append("		<p class=\"cate__tit--depth2\">");
		    		if(gnb_list_1[j].getG_link()!=""){
		    			sbGnbList.append("			<a href=\""+gnb_list_1[j].getG_link()+"\">");
		    		}
		    			sbGnbList.append(gnb_list_1[j].getG_name());
		    		if(gnb_list_1[j].getG_link()!=""){	
		    			sbGnbList.append("			</a>");
		    		}
		    		sbGnbList.append("		</p>");
			    			
			    	GNB_List_Data[] gnb_list_2 = GNB_List_Proc.getGNB_List(3, gnb_list_1[j].getG_seqno()); //중분류 목록
					if(gnb_list_2!=null && gnb_list_2.length>0){
						sbGnbList.append("			<ul class=\"cate--depth3\">");
			            for(int k=0; k<gnb_list_2.length && k<12; k++){
			            	
                        	sbGnbList.append("			<li class=\"cate-item--depth3\">");
	                    	sbGnbList.append("				<a href=\""+gnb_list_2[k].getG_link()+"\" onclick=\"insertLog("+(clicklogNo+i)+");\" >"+gnb_list_2[k].getG_name().replaceAll("\\<(br|BR)/{0,1}\\>",""));
	                    	sbGnbList.append("				</a>");
	                    	sbGnbList.append("			</li>");
			            }
			                    
			            sbGnbList.append("			</ul>");
			         }
			    	
					if(cnt.length > 0){
			         sbGnbList.append("			</li>");
					}
			         
			         if(j==gnb_list_1.length-1){
						 sbGnbList.append("		</ul>");
						 sbGnbList.append("</div>");
			         }
				}
			}
			sbGnbList.append("</li>");
		}
	}
    out.println(sbGnbList.toString().replaceAll("(\\>)([\\s\\t\\r\\n]+)(\\<)","$1$3"));
}
%>