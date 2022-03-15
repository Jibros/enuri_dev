<%@page import="com.enuri.bean.main.Nw_GNB_List_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="com.enuri.bean.main.GNB_Keyword_Data"%>
<%@page import="com.enuri.bean.main.GNB_Keyword_Proc"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.enuri.util.common.*"%>
<%@ page import="com.enuri.include.RandomMain"%>
<%@ page import="com.enuri.bean.main.GNB_List_Data"%>
<%@ page import="com.enuri.bean.main.Bnr_List_Data"%>
<%@ page import="com.enuri.bean.main.Bnr_List_Proc_2018"%>
<%
	String strEnter = System.getProperty("line.separator");

	String ajax_flag   = ChkNull.chkStr(request.getParameter("ajax"));     //y:Ajax호출=미사용
	int g_seq          = ChkNull.chkInt(request.getParameter("g_seq"),1);  //대대분류코드
	String stype       = ChkNull.chkStr(request.getParameter("stype"));    //"":카테고리, detail:자세히보기, allmenu:전체메뉴, banner:gnb배너
	
	Nw_GNB_List_Proc 		GNB_List_Proc       = new Nw_GNB_List_Proc();	
	//GNB_List_2021_Proc     GNB_List_Proc       = new GNB_List_2021_Proc();
	GNB_Keyword_Proc   GNB_Keyword_Proc    = new GNB_Keyword_Proc();
	Bnr_List_Proc_2018      Bnr_List_Proc       = new Bnr_List_Proc_2018();
	
	GNB_List_Data gnb_one = GNB_List_Proc.getGNB_OneLevel(g_seq); //대대분류 정보
	
	Bnr_List_Data[] bnr_one_list   = Bnr_List_Proc.getBnr_List(gnb_one.getG_seqno());
	GNB_List_Data[] gnb_list_0     = GNB_List_Proc.getGNB_List(1, 0); //대대분류 목록
	
	GNB_Keyword_Data[] gnb_keyword_data;
	
	StringBuilder sbAllCateList = new StringBuilder();
	StringBuilder sbGnbList     = new StringBuilder();
	
	int dispno = gnb_one.getG_seqno();


//gnb 카테고리
if(stype.equals("")){
	
	if( gnb_list_0!=null && gnb_list_0.length>0 ){
			
			GNB_List_Data[] gnb_list_1 = GNB_List_Proc.getGNB_List(2, dispno); //대분류 목록
			
			String catenm0 = gnb_list_0[g_seq-1].getG_name();
			
			if(gnb_list_1!=null && gnb_list_1.length>0){
				
				String groupCate = "";
				
			    for(int j=0; j<gnb_list_1.length; j++){
			    	
			    	String bd_lcate_nm = gnb_list_1[j].getBd_lcate_nm();
			    	
			    	if(j != 0){
			    		if(!StringUtils.equals(groupCate, bd_lcate_nm)){
					    	sbGnbList.append("</li>");
					    	sbGnbList.append("</ul>");
				    	}
			    	}
			    	
			    	if(!StringUtils.equals(groupCate, bd_lcate_nm)){
                        sbGnbList.append("<li class='cate-item--depth2'>");
                        //sbGnbList.append("<p class='cate__tit--depth2'>"+bd_lcate_nm+"</p>");
                        sbGnbList.append("<p class='cate__tit--depth2'>");
                        if(gnb_list_1[j].getG_link()!=""){
                            //sbGnbList.append("<a href=\""+gnb_list_1[j].getG_link()+"\">");
                        }
                            sbGnbList.append(bd_lcate_nm);
                        if(gnb_list_1[j].getG_link()!=""){    
                            //sbGnbList.append("           </a>");
                        }
                        sbGnbList.append("</p>");
                            sbGnbList.append("<ul class='cate--depth3'>");
			    	}
			    	
			    		if(j == 0)	sbGnbList.append("<li class='cate-item cate-item--depth3 is--on'>");	
			    		else		sbGnbList.append("<li class='cate-item cate-item--depth3'>");
			    		
			    			sbGnbList.append("<p>"+gnb_list_1[j].getG_name()+"</p>");
			    			
			    			GNB_List_Data[] gnb_list_2 = GNB_List_Proc.getGNB_List(3, gnb_list_1[j].getG_seqno()); //중분류 목록
					        if(gnb_list_2!=null && gnb_list_2.length>0){
					        	//sbGnbList.append("<ul class='twolist'>");
					        	sbGnbList.append("<div class='cate-item__expend--depth3'>");
					        	sbGnbList.append("<p class='cate__tit--depth3'>"+gnb_list_1[j].getG_name().trim());
					        	//sbGnbList.append("<div class='twogroup'>");
					        	//sbGnbList.append("<div class='twogroup__head'>");
					        	
                                //sbGnbList.append("<p class='twogroup__tit'>"+gnb_list_1[j].getG_name()+"</p>");
                              //전체보기 버튼
        				        String strG_Link = gnb_list_1[j].getG_link();
        			        	if(strG_Link != null && strG_Link.length() > 0){
        			        		String strHtmlTarget = "";
        			        		if(strG_Link.indexOf("http") > -1) strHtmlTarget = "target = \"_blank\""; 
        			        			 if(g_seq == 1) sbGnbList.append( "<a href='"+strG_Link+"' onclick='insertLog(24311);' class='cate__btn--all comm__sprite' "+strHtmlTarget+">전체보기</a>");
        			        		else if(g_seq == 2) sbGnbList.append( "<a href='"+strG_Link+"' onclick='insertLog(24312);' class='cate__btn--all comm__sprite' "+strHtmlTarget+">전체보기</a>");
        			        		else if(g_seq == 3) sbGnbList.append( "<a href='"+strG_Link+"' onclick='insertLog(24313);' class='cate__btn--all comm__sprite' "+strHtmlTarget+">전체보기</a>");
        			        		else if(g_seq == 4) sbGnbList.append( "<a href='"+strG_Link+"' onclick='insertLog(24314);' class='cate__btn--all comm__sprite' "+strHtmlTarget+">전체보기</a>");
        			        		else if(g_seq == 5) sbGnbList.append( "<a href='"+strG_Link+"' onclick='insertLog(24315);' class='cate__btn--all comm__sprite' "+strHtmlTarget+">전체보기</a>");
        			        		else if(g_seq == 6) sbGnbList.append( "<a href='"+strG_Link+"' onclick='insertLog(24316);' class='cate__btn--all comm__sprite' "+strHtmlTarget+">전체보기</a>");
        			        		else if(g_seq == 7) sbGnbList.append( "<a href='"+strG_Link+"' onclick='insertLog(24317);' class='cate__btn--all comm__sprite' "+strHtmlTarget+">전체보기</a>");
        			        		else if(g_seq == 8) sbGnbList.append( "<a href='"+strG_Link+"' onclick='insertLog(24318);' class='cate__btn--all comm__sprite' "+strHtmlTarget+">전체보기</a>");
        			        		else if(g_seq == 9) sbGnbList.append( "<a href='"+strG_Link+"' onclick='insertLog(24319);' class='cate__btn--all comm__sprite' "+strHtmlTarget+">전체보기</a>");
        			        		else if(g_seq == 10) sbGnbList.append("<a href='"+strG_Link+"' onclick='insertLog(24320);' class='cate__btn--all comm__sprite' "+strHtmlTarget+">전체보기</a>");
        			        		else if(g_seq == 11) sbGnbList.append("<a href='"+strG_Link+"' onclick='insertLog(24321);' class='cate__btn--all comm__sprite' "+strHtmlTarget+">전체보기</a>");
        			        		
        			        	}
	                            
					        	sbGnbList.append("</p>");
	                            
	                            sbGnbList.append("<ul class='cate--depth4'>");
	                            
					            for(int k=0; k<gnb_list_2.length && k<14; k++){
					            	
					                GNB_List_Data[] gnb_list_3 = GNB_List_Proc.getGNB_List(4, gnb_list_2[k].getG_seqno()); //중분류 목록
					
					                if(k == 0 ) sbGnbList.append("<li class='cate-item cate-item--depth4 is--on'>");	
					                else       	sbGnbList.append("<li class='cate-item cate-item--depth4'>");
					                
					                //sbGnbList.append("<a href='"+gnb_list_2[k].getG_link()+"' >");
        			        		
					                if(k == 0) sbGnbList.append( 	  "<a href='"+gnb_list_2[k].getG_link()+"' onclick='insertLog(24300);'  "+(gnb_list_2[k].getG_link().indexOf("http") > -1 ? "target=\"_blank\"" : "")+">");
        			        		else if(k == 1) sbGnbList.append( "<a href='"+gnb_list_2[k].getG_link()+"' onclick='insertLog(24301);' "+(gnb_list_2[k].getG_link().indexOf("http") > -1 ? "target=\"_blank\"" : "")+">");
        			        		else if(k == 2) sbGnbList.append( "<a href='"+gnb_list_2[k].getG_link()+"' onclick='insertLog(24302);' "+(gnb_list_2[k].getG_link().indexOf("http") > -1 ? "target=\"_blank\"" : "")+">");
        			        		else if(k == 3) sbGnbList.append( "<a href='"+gnb_list_2[k].getG_link()+"' onclick='insertLog(24303);' "+(gnb_list_2[k].getG_link().indexOf("http") > -1 ? "target=\"_blank\"" : "")+">");
        			        		else if(k == 4) sbGnbList.append( "<a href='"+gnb_list_2[k].getG_link()+"' onclick='insertLog(24304);' "+(gnb_list_2[k].getG_link().indexOf("http") > -1 ? "target=\"_blank\"" : "")+">");
        			        		else if(k == 5) sbGnbList.append( "<a href='"+gnb_list_2[k].getG_link()+"' onclick='insertLog(24305);' "+(gnb_list_2[k].getG_link().indexOf("http") > -1 ? "target=\"_blank\"" : "")+">");
        			        		else if(k == 6) sbGnbList.append( "<a href='"+gnb_list_2[k].getG_link()+"' onclick='insertLog(24306);' "+(gnb_list_2[k].getG_link().indexOf("http") > -1 ? "target=\"_blank\"" : "")+">");
        			        		else if(k == 7) sbGnbList.append( "<a href='"+gnb_list_2[k].getG_link()+"' onclick='insertLog(24307);' "+(gnb_list_2[k].getG_link().indexOf("http") > -1 ? "target=\"_blank\"" : "")+">");
        			        		else if(k == 8) sbGnbList.append( "<a href='"+gnb_list_2[k].getG_link()+"' onclick='insertLog(24308);' "+(gnb_list_2[k].getG_link().indexOf("http") > -1 ? "target=\"_blank\"" : "")+">");
        			        		else if(k == 9) sbGnbList.append( "<a href='"+gnb_list_2[k].getG_link()+"' onclick='insertLog(24309);' "+(gnb_list_2[k].getG_link().indexOf("http") > -1 ? "target=\"_blank\"" : "")+">");
        			        		else if(k == 10) sbGnbList.append("<a href='"+gnb_list_2[k].getG_link()+"' onclick='insertLog(24310);' "+(gnb_list_2[k].getG_link().indexOf("http") > -1 ? "target=\"_blank\"" : "")+">");
        			        		else if(k == 11) sbGnbList.append("<a href='"+gnb_list_2[k].getG_link()+"' onclick='insertLog(24311);' "+(gnb_list_2[k].getG_link().indexOf("http") > -1 ? "target=\"_blank\"" : "")+">");
        			        		else if(k == 12) sbGnbList.append("<a href='"+gnb_list_2[k].getG_link()+"' onclick='insertLog(24312);' "+(gnb_list_2[k].getG_link().indexOf("http") > -1 ? "target=\"_blank\"" : "")+">");
        			        		else if(k == 13) sbGnbList.append("<a href='"+gnb_list_2[k].getG_link()+"' onclick='insertLog(24313);' "+(gnb_list_2[k].getG_link().indexOf("http") > -1 ? "target=\"_blank\"" : "")+">");
        			        		else if(k == 14) sbGnbList.append("<a href='"+gnb_list_2[k].getG_link()+"' onclick='insertLog(24314);' "+(gnb_list_2[k].getG_link().indexOf("http") > -1 ? "target=\"_blank\"" : "")+">");
					                
					                sbGnbList.append(gnb_list_2[k].getG_name().replaceAll("\\<(br|BR)/{0,1}\\>",""));
					                
					                sbGnbList.append(gnb_list_2[k].getG_icon().equals("H") ? "<i class='ico-badge ico-badge--pop comm__sprite'>인기</i>" : (gnb_list_2[k].getG_icon().equals("N") ? "<i class='ico-badge ico-badge--new comm__sprite'>신규</i>" : (gnb_list_2[k].getG_icon().equals("A") ? "<i class='ico-badge ico-badge--a19 comm__sprite'>성인</i>" : "")));
					                //sbGnbList.append("<span class=\"icon arrow\">화살표</span>");
					                sbGnbList.append("</a>");
								                
					                if(gnb_list_3!=null && gnb_list_3.length>0){
										
					                	sbGnbList.append("<div class='cate-item__expend--depth4'>");
					                	//sbGnbList.append("<div class='threegroup'>");
					                	//sbGnbList.append("<div class='threegroup__head'>");
                                        //sbGnbList.append("	<p class='threegroup__tit'>"+gnb_list_2[k].getG_name().replaceAll("\\<(br|BR)/{0,1}\\>","")+"</p>");
                                    	//sbGnbList.append("</div>");
					                	
                                    	sbGnbList.append("	<p class='cate__tit--depth4'>"+gnb_list_2[k].getG_name().replaceAll("\\<(br|BR)/{0,1}\\>","")+"</p>");
                                    	
					                	boolean indentYN = false;
					                	//boolean hasTree = false;
					                	
					                	sbGnbList.append("<ul class='cate--depth5'>");
					                	
					                    for(int l=0; l<gnb_list_3.length && l<12; l++){
					                        
					                        String g_indent =  ChkNull.chkStr(gnb_list_3[l].getG_indent());
					                        
					                        String insertlog = "";
		        			        		
		        			        			 if(l == 0)  insertlog = "onclick='insertLog(24322);'";
		        			        		else if(l == 1)  insertlog = "onclick='insertLog(24323);'";
		        			        		else if(l == 2)  insertlog = "onclick='insertLog(24324);'";
		        			        		else if(l == 3)  insertlog = "onclick='insertLog(24325);'";
		        			        		else if(l == 4)  insertlog = "onclick='insertLog(24326);'";
		        			        		else if(l == 5)  insertlog = "onclick='insertLog(24327);'";
		        			        		else if(l == 6)  insertlog = "onclick='insertLog(24328);'";
		        			        		else if(l == 7)  insertlog = "onclick='insertLog(24329);'";
		        			        		else if(l == 8)  insertlog = "onclick='insertLog(24330);'";
		        			        		else if(l == 9)  insertlog = "onclick='insertLog(24331);'";
		        			        		else if(l == 10) insertlog = "onclick='insertLog(24332);'";
					                        
					                        if("Y".equals(g_indent) && !indentYN){  //들여쓰기여부
					                        	sbGnbList.append("<li class='cate-item cate-item--depth5 has--tree'>");
					                        	sbGnbList.append("<ul class='cate-item--tree'>");
					                        	indentYN = true;
					                        }
					                        
					                        if("Y".equals(g_indent)){
					                        	sbGnbList.append("<li class='cate-item cate-item--depth5 33'>");
						                    	sbGnbList.append("	<a href='"+gnb_list_3[l].getG_link()+"' "+insertlog+" >"+gnb_list_3[l].getG_name().replaceAll("\\<(br|BR)/{0,1}\\>",""));
						                    	sbGnbList.append(		(gnb_list_3[l].getG_icon().equals("H") ? "<i class=\"ico-badge ico-badge--pop comm__sprite\">인기</i>" : (gnb_list_3[l].getG_icon().equals("N") ? "<i class=\"ico-badge ico-badge--new comm__sprite\">신규</i>" : (gnb_list_3[l].getG_icon().equals("A") ? "<span class=\"gbadge adult\">adult</span>" : ""))));
						                    	sbGnbList.append(	"</a>");
						                    	sbGnbList.append("</li>");

					                        }else{
					                        	
					                        	if( l != gnb_list_3.length-1 && gnb_list_3[l+1].getG_indent().equals("Y")){
					                        		sbGnbList.append("<li class='cate-item cate-item--depth5 11'>");	
					                        	}else{
					                        		sbGnbList.append("<li class='cate-item cate-item--depth5 22' >");
					                        	}
					                        	
						                    	sbGnbList.append("	<a href='"+gnb_list_3[l].getG_link()+"' "+insertlog+" >"+gnb_list_3[l].getG_name().replaceAll("\\<(br|BR)/{0,1}\\>",""));
						                    	sbGnbList.append(		(gnb_list_3[l].getG_icon().equals("H") ?
						                    			"<i class='ico-badge ico-badge--pop comm__sprite'>인기</i>" : (gnb_list_3[l].getG_icon().equals("N") ? 
						                    					"<i class=\"ico-badge ico-badge--new comm__sprite\">신규</i>" : (gnb_list_3[l].getG_icon().equals("A") ? 
						                    							"<i class='ico-badge ico-badge--a19 comm__sprite'>성인</i>" : ""))));
						                    							//"<span class=\"gbadge adult\">adult</span>" : ""))));
						                    	sbGnbList.append("</a>");
						                    	
						                    	if( l == gnb_list_3.length-1 || gnb_list_3[l+1].getG_indent().equals("N") ) {
						                    		sbGnbList.append("</li>");	
						                    	}
						                    	
					                        }
					                    	
					                        if( (l == gnb_list_3.length-1 || gnb_list_3[l+1].getG_indent().equals("N")) && indentYN   ){
					                        	sbGnbList.append("</ul>");
					                        	sbGnbList.append("</li>");
					                        	indentYN = false;
					                        }
					                    
					                    }
					                    sbGnbList.append("	 </ul>");
					                    //sbGnbList.append("	 </div>");
					                    sbGnbList.append("	 </div>");
					                }
					                
					            }
					            sbGnbList.append("</div>");
					          	//sbGnbList.append("</ul>");
					          	//sbGnbList.append("</div>");
					          	//sbGnbList.append("</ul>");
					        }
			    	
			    	groupCate = bd_lcate_nm;
			    	
				}
			    //sbGnbList.append("</li>");
			}
	}
    out.println(sbGnbList.toString().replaceAll("(\\>)([\\s\\t\\r\\n]+)(\\<)","$1$3"));
}else if(stype.equals("allCate")){
    for(int i=0; i<gnb_list_0.length; i++){
       
    	if(i == 0) sbAllCateList.append("<li class='cate-item--depth1 is--on'>");
    	else sbAllCateList.append("<li class='cate-item--depth1'>"); 
    	
	    sbAllCateList.append("    <p class='cate__tit'>"+gnb_list_0[i].getG_name().replaceAll("\\<(br|BR)/{0,1}\\>","") +"</p>");
	    sbAllCateList.append("    <div class='cate-item__expend'>");
	    sbAllCateList.append("        <ul class='cate--depth2'>");
	    GNB_List_Data[] gnb_list_1 = GNB_List_Proc.getGNB_List(2, gnb_list_0[i].getG_seqno()); //대분류 목록
	    
        if(gnb_list_1!=null && gnb_list_1.length>0){
            for(int j=0; j<gnb_list_1.length && j<10; j++){
	    
	    sbAllCateList.append("            <li class='cate-item--depth2'>");
        //sbAllCateList.append("                <p class='cate__tit--depth2'>"+gnb_list_1[j].getG_name().replaceAll("\\<(br|BR)/{0,1}\\>","")+"</p>");
        sbAllCateList.append("<p class='cate__tit--depth2'>");
        if(gnb_list_1[j].getG_link()!=""){
            sbAllCateList.append("         <a href=\""+gnb_list_1[j].getG_link()+"\">");
        }
        sbAllCateList.append(gnb_list_1[j].getG_name().replaceAll("\\<(br|BR)/{0,1}\\>",""));
        if(gnb_list_1[j].getG_link()!=""){    
            sbAllCateList.append("         </a>");
        }
        sbAllCateList.append("</p>");
	    sbAllCateList.append("                <ul class='cate--depth3'>");
	    
        GNB_List_Data[] gnb_list_2 = GNB_List_Proc.getGNB_List(3, gnb_list_1[j].getG_seqno()); //중분류 목록
        
        if(gnb_list_2!=null && gnb_list_2.length>0){
            for(int k=0; k<gnb_list_2.length && k<12; k++){
	    
	    sbAllCateList.append("                    <li class='cate-item--depth3'><a href='"+gnb_list_2[k].getG_link()+"'>"+gnb_list_2[k].getG_name().replaceAll("\\<(br|BR)/{0,1}\\>","")+"</a></li>");
            }
        }
	    sbAllCateList.append("                </ul>");
	    sbAllCateList.append("            </li>");
	    
            }
        }
	    
	    sbAllCateList.append("        </ul>");
	    sbAllCateList.append("    </div>");
	    sbAllCateList.append("</li>");
    	
    }
    //sbAllCateList.append("    <li class=\"all\">");
    //sbAllCateList.append("       <a href=\"javascript:///\"><em>전체보기</em></a>");
    //sbAllCateList.append("    </li>");
    
    out.println(sbAllCateList.toString().replaceAll("(\\>)([\\s\\t\\r\\n]+)(\\<)","$1$3"));
}else if(stype.equals("detail")){
    GNB_List_Data[] gnb_list_1 = GNB_List_Proc.getGNB_List(2, gnb_one.getG_seqno()); //대분류 목록
    if(gnb_list_1!=null && gnb_list_1.length>0){
        for(int j=0; j<gnb_list_1.length; j++){
%>
                        <li seq="<%=gnb_list_1[j].getG_seqno()%>"><a href="#"><span><%=gnb_list_1[j].getG_name()%></span></a>
                            <div class="detailDepth2">
                                <ul>
<%
            GNB_List_Data[] gnb_list_2 = GNB_List_Proc.getGNB_List(3, gnb_list_1[j].getG_seqno()); //중분류 목록
            int gnb_list_2_length = 0;
            if(gnb_list_2!=null && gnb_list_2.length>0){
                for(int k=0; k<gnb_list_2.length; k++){
                    if(gnb_list_2[k].getG_cate().equals("전문관")){
                        break;
                    }
%>
                                    <li><a target="<%=CutStr.cutStr(gnb_list_2[k].getG_link(),4).equals("http")?"_new":""%>" href="<%=gnb_list_2[k].getG_link()%>"><span><%=gnb_list_2[k].getG_name()%></span></a>
                                        <div class="detailDepth3">
                                            <ul>
<%
                    GNB_List_Data[] gnb_list_3 = GNB_List_Proc.getGNB_List(4, gnb_list_2[k].getG_seqno()); //소분류 목록
                    if(gnb_list_3!=null && gnb_list_3.length>0){
                        for(int l=0; l<gnb_list_3.length; l++){
%>
                                                <li><a target="<%=CutStr.cutStr(gnb_list_2[k].getG_link(),4).equals("http")?"_new":""%>" href="<%=gnb_list_3[l].getG_link()%>"><%=gnb_list_3[l].getG_name()%></a></li>
<%
                        }
                    }
%>
                                            </ul>
                                        </div>
                                    </li>
<%
                    gnb_list_2_length++;
                }
                
                for(int k=gnb_list_2_length; k<12; k++){
                    out.println("<li class='detailDepth2_blank'><a href='#'></a></li>");
                }
            }
%>
                                </ul>
                            </div>
                        </li>
<%
        }
        
        for(int j=gnb_list_1.length; j<10; j++){
            out.println("<li class='detailDepth1_blank'><a href='javascript:///'></a></li>");
        }
    }
}else if(stype.equals("allmenu")){
    for(int i=0; i<gnb_list_0.length; i++){
        out.println("<li><a href=\"javascript:///\"><em>디지털/가전</em></a>");
        out.println("    <div class=\"snblist\">");
        out.println("         <div class=\"all_view\">");
        out.println("            <ul class=\"all_sub\">");
        out.println("                <li><a href=\"\">스마트폰, 태블릿 PC</a>");
        out.println("                    <ul>");
        out.println("                        <li><a href=\"\">휴대폰,스마트폰</a></li>");
        out.println("                        <li><a href=\"\">스마트폰용 액세서리</a></li>");
        out.println("                        <li><a href=\"\">태블릿PC, 전자책</a></li>");
        out.println("                        <li><a href=\"\">태블릿PC용 액세서리</a></li>");
        out.println("                        <li><a href=\"\">블루투스,스마트워치</a></li>");
        out.println("                        <li><a href=\"\">메모리카드,카드리더</a></li>");
        out.println("                        <li><a href=\"\">스마트라이프</a></li>");
        out.println("                    </ul>");
        out.println("                </li>");
        out.println("            </ul>");
        out.println("        </div>");
        out.println("    </div>");
        out.println("</li>");
    }
                    
}else if(stype.equals("banner")){
    Bnr_List_Data[] bnr_list_data_1 = null;
    Bnr_List_Data[] bnr_list_data_2 = null;
    Bnr_List_Data[] bnr_list_data_3 = null;
    Bnr_List_Data[] bnr_list_data_4 = null;
    Bnr_List_Data[] bnr_list_data_5 = null;
    Bnr_List_Data[] bnr_list_data_6 = null;
    Bnr_List_Data[] bnr_list_data_7 = null;
    Bnr_List_Data[] bnr_list_data_8 = null;
    Bnr_List_Data[] bnr_list_data_9 = null;
    Bnr_List_Data[] bnr_list_data_10 = null;
    Bnr_List_Data[] bnr_list_data_11 = null;
    
    //광고그룹 배너관리자에서 등록하는 배너 추가
    Bnr_List_Data bnr_ad_data_1 = null;
    Bnr_List_Data bnr_ad_data_2 = null;
    Bnr_List_Data bnr_ad_data_3 = null;
    Bnr_List_Data bnr_ad_data_4 = null;
    Bnr_List_Data bnr_ad_data_5 = null;
    Bnr_List_Data bnr_ad_data_6 = null;
    Bnr_List_Data bnr_ad_data_7 = null;
    Bnr_List_Data bnr_ad_data_8 = null;
    Bnr_List_Data bnr_ad_data_9 = null;
    Bnr_List_Data bnr_ad_data_10 = null;
    Bnr_List_Data bnr_ad_data_11 = null;
    
    for(int i=0; i<gnb_list_0.length; i++){
    	
    	/*
        if(i==0) bnr_list_data_1 = Bnr_List_Proc.getBnr_List(gnb_list_0[i].getG_seqno());
        if(i==1) bnr_list_data_2 = Bnr_List_Proc.getBnr_List(gnb_list_0[i].getG_seqno());
        if(i==2) bnr_list_data_3 = Bnr_List_Proc.getBnr_List(gnb_list_0[i].getG_seqno());
        if(i==3) bnr_list_data_4 = Bnr_List_Proc.getBnr_List(gnb_list_0[i].getG_seqno());
        if(i==4) bnr_list_data_5 = Bnr_List_Proc.getBnr_List(gnb_list_0[i].getG_seqno());
        if(i==5) bnr_list_data_6 = Bnr_List_Proc.getBnr_List(gnb_list_0[i].getG_seqno());
        if(i==6) bnr_list_data_7 = Bnr_List_Proc.getBnr_List(gnb_list_0[i].getG_seqno());
        if(i==7) bnr_list_data_8 = Bnr_List_Proc.getBnr_List(gnb_list_0[i].getG_seqno());
        if(i==8) bnr_list_data_9 = Bnr_List_Proc.getBnr_List(gnb_list_0[i].getG_seqno());
        if(i==9) bnr_list_data_10 = Bnr_List_Proc.getBnr_List(gnb_list_0[i].getG_seqno());
        if(i==10) bnr_list_data_11 = Bnr_List_Proc.getBnr_List(gnb_list_0[i].getG_seqno());
        */
        
        if(i==0) bnr_list_data_1 = Bnr_List_Proc.getBnr_List(gnb_list_0[i].getG_dispno());
        if(i==1) bnr_list_data_2 = Bnr_List_Proc.getBnr_List(gnb_list_0[i].getG_dispno());
        if(i==2) bnr_list_data_3 = Bnr_List_Proc.getBnr_List(gnb_list_0[i].getG_dispno());
        if(i==3) bnr_list_data_4 = Bnr_List_Proc.getBnr_List(gnb_list_0[i].getG_dispno());
        if(i==4) bnr_list_data_5 = Bnr_List_Proc.getBnr_List(gnb_list_0[i].getG_dispno());
        if(i==5) bnr_list_data_6 = Bnr_List_Proc.getBnr_List(gnb_list_0[i].getG_dispno());
        if(i==6) bnr_list_data_7 = Bnr_List_Proc.getBnr_List(gnb_list_0[i].getG_dispno());
        if(i==7) bnr_list_data_8 = Bnr_List_Proc.getBnr_List(gnb_list_0[i].getG_dispno());
        if(i==8) bnr_list_data_9 = Bnr_List_Proc.getBnr_List(gnb_list_0[i].getG_dispno());
        if(i==9) bnr_list_data_10 = Bnr_List_Proc.getBnr_List(gnb_list_0[i].getG_dispno());
        if(i==10) bnr_list_data_11 = Bnr_List_Proc.getBnr_List(gnb_list_0[i].getG_dispno());
        
        if(i==0) bnr_ad_data_1 = Bnr_List_Proc.getAdBnr_List("1");
        if(i==1) bnr_ad_data_2 = Bnr_List_Proc.getAdBnr_List("2");
        if(i==2) bnr_ad_data_3 = Bnr_List_Proc.getAdBnr_List("3");
        if(i==3) bnr_ad_data_4 = Bnr_List_Proc.getAdBnr_List("4");
        if(i==4) bnr_ad_data_5 = Bnr_List_Proc.getAdBnr_List("5");
        if(i==5) bnr_ad_data_6 = Bnr_List_Proc.getAdBnr_List("6");
        if(i==6) bnr_ad_data_7 = Bnr_List_Proc.getAdBnr_List("7");
        if(i==7) bnr_ad_data_8 = Bnr_List_Proc.getAdBnr_List("8");
        if(i==8) bnr_ad_data_9 = Bnr_List_Proc.getAdBnr_List("9");
        if(i==9) bnr_ad_data_10 = Bnr_List_Proc.getAdBnr_List("10");
        if(i==10) bnr_ad_data_11 = Bnr_List_Proc.getAdBnr_List("11");
    }

    Bnr_List_Data[][] bnr_list = {bnr_list_data_1, bnr_list_data_2, bnr_list_data_3, bnr_list_data_4, bnr_list_data_5, bnr_list_data_6, bnr_list_data_7,bnr_list_data_8,bnr_list_data_9,bnr_list_data_10,bnr_list_data_11 } ;
    Bnr_List_Data[] bnr_ad_list = {bnr_ad_data_1, bnr_ad_data_2, bnr_ad_data_3, bnr_ad_data_4, bnr_ad_data_5, bnr_ad_data_6, bnr_ad_data_7,bnr_ad_data_8,bnr_ad_data_9,bnr_ad_data_10,bnr_ad_data_11} ;

    JSONObject  jsonBannerList  = new JSONObject();
    JSONArray   jsonArray       = new JSONArray();
    JSONObject  jsonBanner      = new JSONObject();
    
    JSONObject  jsonGnbBanner = new JSONObject();
    JSONArray   jsonArrayGnbBanner = new JSONArray();
    
    for(int i=0; i<gnb_list_0.length; i++){
        jsonBannerList  = new JSONObject();
        jsonArray       = new JSONArray();
        
        for(int j=0; j<bnr_list[i].length; j++){
            jsonBanner = new JSONObject();
            
            jsonBanner.put("img"        ,bnr_list[i][j].getBanner_img());
            jsonBanner.put("linktype"   ,bnr_list[i][j].getBanner_linktype());
            jsonBanner.put("link"       ,bnr_list[i][j].getBanner_link());
            jsonBanner.put("source"     ,0);    //배너출처(0:GNB관리자에서 CM이 등록, 1:배너관리자에서 광고그룹이 등록)
            jsonBanner.put("no"         ,0);    //배너관리자에서 등록한 배너일때 banner_no (pk값)
            
            jsonArray.put(jsonBanner);
        }
        
        if(bnr_ad_list!=null && bnr_ad_list[i]!=null){
            jsonBanner = new JSONObject();
            
            jsonBanner.put("img"        ,ConfigManager.STORAGE_ENURI_COM+"/banner/" + bnr_ad_list[i].getBanner_img());
            jsonBanner.put("linktype"   ,1);
            jsonBanner.put("link"       ,bnr_ad_list[i].getBanner_link());
            jsonBanner.put("source"     ,1);    //배너출처(0:GNB관리자에서 CM이 등록, 1:배너관리자에서 광고그룹이 등록)
            jsonBanner.put("no"         ,bnr_ad_list[i].getBanner_no() );    //배너관리자에서 등록한 배너일때 banner_no (pk값)
            
            jsonArray.put(jsonBanner);
        }
        
        jsonBannerList.put("seq"    ,gnb_list_0[i].getG_seqno());
        jsonBannerList.put("banner" ,jsonArray);
        
        jsonArrayGnbBanner.put(jsonBannerList);
    }
    
    out.println(jsonGnbBanner.put("gnbBanner", jsonArrayGnbBanner).toString());
}
%>
<%!
private String iconNameGet(int seq){
	
	String 			  iconNm = "";
	if(seq == 1) 	  iconNm = "icon icon-1";
	else if(seq == 2) iconNm = "icon icon-2";
	else if(seq == 3) iconNm = "icon icon-3";
	else if(seq == 4) iconNm = "icon icon-4";
	else if(seq == 5) iconNm = "icon icon-5";
	else if(seq == 6) iconNm = "icon icon-6";
	else if(seq == 7) iconNm = "icon icon-7";
	else if(seq == 8) iconNm = "icon icon-8";
	else if(seq == 9) iconNm = "icon icon-9";
	else if(seq == 10) iconNm = "icon icon-10";
	else if(seq == 11) iconNm = "icon icon-11";
	
	return iconNm;
}
%>