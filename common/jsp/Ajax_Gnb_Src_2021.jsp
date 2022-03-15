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
<%@ page import="com.enuri.bean.main.GNB_List_2020_Proc"%>
<%@ page import="com.enuri.bean.main.Bnr_List_Data"%>
<%@ page import="com.enuri.bean.main.Bnr_List_Proc_2018"%>
<%
	String ajax_flag   = ChkNull.chkStr(request.getParameter("ajax"));     //y:Ajax호출=미사용
	int g_seq          = ChkNull.chkInt(request.getParameter("g_seq"),1);  //대대분류코드
	String stype       = ChkNull.chkStr(request.getParameter("stype"));    //"":카테고리, detail:자세히보기, allmenu:전체메뉴, banner:gnb배너
	
	GNB_List_2020_Proc     GNB_List_Proc       = new GNB_List_2020_Proc();
	GNB_Keyword_Proc   GNB_Keyword_Proc    = new GNB_Keyword_Proc();
	Bnr_List_Proc_2018      Bnr_List_Proc       = new Bnr_List_Proc_2018();
	
	GNB_List_Data gnb_one = GNB_List_Proc.getGNB_One(g_seq); //대대분류 정보
	
	Bnr_List_Data[] bnr_one_list   = Bnr_List_Proc.getBnr_List(gnb_one.getG_seqno());
	GNB_List_Data[] gnb_list_0     = GNB_List_Proc.getGNB_List(1, 0); //대대분류 목록
	
	GNB_Keyword_Data[] gnb_keyword_data;
	
	StringBuilder sbAllCateList = new StringBuilder();
	StringBuilder sbGnbList     = new StringBuilder();
	
//gnb 카테고리
if(stype.equals("")){
	
	if( gnb_list_0!=null && gnb_list_0.length>0 ){
			
			GNB_List_Data[] gnb_list_1 = GNB_List_Proc.getGNB_List(2, g_seq); //대분류 목록
			
			String catenm0 = gnb_list_0[g_seq-1].getG_name();
			
			if(gnb_list_1!=null && gnb_list_1.length>0){
				
				String groupCate = "";
				sbGnbList.append("<li class=\"onelist__item\" >");
			    for(int j=0; j<gnb_list_1.length && j<12; j++){
			    	
			    	String bd_lcate_nm = gnb_list_1[j].getBd_lcate_nm();
			    	
			    	if(!StringUtils.equals(groupCate, bd_lcate_nm)){
				    	sbGnbList.append("</div>");
				    	sbGnbList.append("</ul>");
				    	//sbGnbList.append("</li>");
			    	}
			    	
			    	if(!StringUtils.equals(groupCate, bd_lcate_nm)){
			    		
				    	sbGnbList.append("<div class='onegroup'>");
			    			sbGnbList.append("<p class=\"onegroup__tit\">"+bd_lcate_nm+"</p>");	
			    			sbGnbList.append("<ul class='onegroup__list'>");
			    	}
			    	
			    		if(j == 0)	sbGnbList.append("<li class='is-on'>");	
			    		else		sbGnbList.append("<li>");
			    		
			    			sbGnbList.append("<a href='javascript:' class='onelist__trigger'><i>·</i>"+gnb_list_1[j].getG_name()+"</a>");
			    			
			    			GNB_List_Data[] gnb_list_2 = GNB_List_Proc.getGNB_List(3, gnb_list_1[j].getG_seqno()); //중분류 목록
					        if(gnb_list_2!=null && gnb_list_2.length>0){
					        	sbGnbList.append("<ul class='twolist'>");
					        	sbGnbList.append("<div class='twogroup'>");
					        	
					        	sbGnbList.append("<div class='twogroup__head'>");
                                sbGnbList.append("<p class='twogroup__tit'>"+gnb_list_1[j].getG_name()+"</p>");
                              //전체보기 버튼
        				        String strG_Link = gnb_list_1[j].getG_link();
        			        	if(strG_Link != null && strG_Link.length() > 0){
        			        		
        			        			 if(g_seq == 1) sbGnbList.append("<a href='"+strG_Link+"' onclick='insertLog(23751);' class='twogroup__tit--btn'>전체보기 <span class='icon arrow'>화살표</span></a>");
        			        		else if(g_seq == 2) sbGnbList.append("<a href='"+strG_Link+"' onclick='insertLog(23752);' class='twogroup__tit--btn'>전체보기 <span class='icon arrow'>화살표</span></a>");
        			        		else if(g_seq == 3) sbGnbList.append("<a href='"+strG_Link+"' onclick='insertLog(23753);' class='twogroup__tit--btn'>전체보기 <span class='icon arrow'>화살표</span></a>");
        			        		else if(g_seq == 4) sbGnbList.append("<a href='"+strG_Link+"' onclick='insertLog(23754);' class='twogroup__tit--btn'>전체보기 <span class='icon arrow'>화살표</span></a>");
        			        		else if(g_seq == 5) sbGnbList.append("<a href='"+strG_Link+"' onclick='insertLog(23755);' class='twogroup__tit--btn'>전체보기 <span class='icon arrow'>화살표</span></a>");
        			        		else if(g_seq == 6) sbGnbList.append("<a href='"+strG_Link+"' onclick='insertLog(23756);' class='twogroup__tit--btn'>전체보기 <span class='icon arrow'>화살표</span></a>");
        			        		else if(g_seq == 7) sbGnbList.append("<a href='"+strG_Link+"' onclick='insertLog(23757);' class='twogroup__tit--btn'>전체보기 <span class='icon arrow'>화살표</span></a>");
        			        		else if(g_seq == 8) sbGnbList.append("<a href='"+strG_Link+"' onclick='insertLog(23758);' class='twogroup__tit--btn'>전체보기 <span class='icon arrow'>화살표</span></a>");
        			        		
        			        	}
	                            sbGnbList.append("</div>");
					        	
					            for(int k=0; k<gnb_list_2.length && k<10; k++){
					                GNB_List_Data[] gnb_list_3 = GNB_List_Proc.getGNB_List(4, gnb_list_2[k].getG_seqno()); //중분류 목록
					
					                if(k == 0 ) sbGnbList.append("<li class='twolist__item is-on'>");	
					                else       	sbGnbList.append("<li class='twolist__item'>");
					                
					                sbGnbList.append("<a href='"+gnb_list_2[k].getG_link()+"' class='twolist__trigger'>");
					                sbGnbList.append(gnb_list_2[k].getG_name().replaceAll("\\<(br|BR)/{0,1}\\>",""));
					                
					                sbGnbList.append(gnb_list_2[k].getG_icon().equals("H") ? "<span class=\"gbadge hot\">HOT</span>" : (gnb_list_2[k].getG_icon().equals("N") ? "<span class=\"gbadge new\">NEW</span>" : (gnb_list_2[k].getG_icon().equals("A") ? "<span class=\"gbadge adult\">ADULT</span>" : "")));
					                sbGnbList.append("<span class=\"icon arrow\">화살표</span>");
					                sbGnbList.append("</a>");

					                if(gnb_list_3!=null && gnb_list_3.length>0){
										
					                	sbGnbList.append("<div class='threelist'>");
					                	sbGnbList.append("<div class='threegroup'>");
					                	sbGnbList.append("<div class='threegroup__head'>");
                                        sbGnbList.append("	<p class='threegroup__tit'>"+gnb_list_2[k].getG_name().replaceAll("\\<(br|BR)/{0,1}\\>","")+"</p>");
                                    	sbGnbList.append("</div>");
					                	
					                	boolean indentYN = false;
					                	//boolean hasTree = false;
					                	
					                	sbGnbList.append("<ul class='threegroup__list'>");
					                	
					                    for(int l=0; l<gnb_list_3.length && l<10; l++){
					                        
					                        String g_indent =  ChkNull.chkStr(gnb_list_3[l].getG_indent());
					                        
					                        if("Y".equals(g_indent) && !indentYN){  //들여쓰기여부
					                        	sbGnbList.append("<li class='threelist__item has-tree'>");
					                        	sbGnbList.append("<ul class=\"subtree\">");
					                        	indentYN = true;
					                        }
					                        
					                        if("Y".equals(g_indent)){
					                        	sbGnbList.append("<li class='subtree__item'>");
						                    	sbGnbList.append("	<a href='"+gnb_list_3[l].getG_link()+"' >"+gnb_list_3[l].getG_name().replaceAll("\\<(br|BR)/{0,1}\\>",""));
						                    	sbGnbList.append(		(gnb_list_3[l].getG_icon().equals("H") ? "<span class=\"gbadge hot\">hot</span>" : (gnb_list_3[l].getG_icon().equals("N") ? "<span class=\"gbadge new\">new</span>" : (gnb_list_3[l].getG_icon().equals("A") ? "<span class=\"gbadge adult\">adult</span>" : ""))));
						                    	sbGnbList.append(	"</a>");
						                    	sbGnbList.append("</li>");

					                        }else{
					                        	
					                        	if( l != gnb_list_3.length-1 && gnb_list_3[l+1].getG_indent().equals("Y")){
					                        		sbGnbList.append("<li class='threelist__item has-tree'>");	
					                        	}else{
					                        		sbGnbList.append("<li class='threelist__item'>");
					                        	}
					                        	
						                    	sbGnbList.append("	<a href='"+gnb_list_3[l].getG_link()+"' class='threelist__trigger'>"+gnb_list_3[l].getG_name().replaceAll("\\<(br|BR)/{0,1}\\>",""));
						                    	sbGnbList.append(		(gnb_list_3[l].getG_icon().equals("H") ? "<span class=\"gbadge hot\">hot</span>" : (gnb_list_3[l].getG_icon().equals("N") ? "<span class=\"gbadge new\">new</span>" : (gnb_list_3[l].getG_icon().equals("A") ? "<span class=\"gbadge adult\">adult</span>" : ""))));
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
					                    sbGnbList.append("	 </div>");
					                    sbGnbList.append("	 </div>");
					                }
					                
					            }
					            sbGnbList.append("</div>");
					          	sbGnbList.append("</ul>");
					        }
			    			
			    		sbGnbList.append("</li>");
	    			//sbGnbList.append("</ul>");
			    	
			    	groupCate = bd_lcate_nm;
			    	
				}
			    
			    sbGnbList.append("</li>");
			    
			}
	}

    out.println(sbGnbList.toString().replaceAll("(\\>)([\\s\\t\\r\\n]+)(\\<)","$1$3"));
}else if(stype.equals("allCate")){
    for(int i=0; i<gnb_list_0.length; i++){
        sbAllCateList.append("<li class=\"gmenu__item menu__item-"+(i+1)+"\" ><a class=\"submenu-trigger js-trigger\" ><em>" + gnb_list_0[i].getG_name().replaceAll("\\<(br|BR)/{0,1}\\>","") + "</em></a>");
        sbAllCateList.append("    <div class=\"submenu submenu-all is-hidden\"><div class=\"submenu__box submenu__box-all\">");
        sbAllCateList.append("         <div class=\"allmenu\">");
        
        GNB_List_Data[] gnb_list_1 = GNB_List_Proc.getGNB_List(2, gnb_list_0[i].getG_seqno()); //대분류 목록
        
        if(gnb_list_1!=null && gnb_list_1.length>0){
            for(int j=0; j<gnb_list_1.length && j<10; j++){
            	sbAllCateList.append("<div class=\"allmenu__box "+(j>=5 ? " two-line" : "") +"\" >");
            	sbAllCateList.append("<a class=\"allmenu__head\" >" + gnb_list_1[j].getG_name().replaceAll("\\<(br|BR)/{0,1}\\>","") + "</a>");
                sbAllCateList.append("            <ul class=\"allmenu__list\" >");
                
                GNB_List_Data[] gnb_list_2 = GNB_List_Proc.getGNB_List(3, gnb_list_1[j].getG_seqno()); //중분류 목록
                
                if(gnb_list_2!=null && gnb_list_2.length>0){
                    for(int k=0; k<gnb_list_2.length && k<10; k++){
                        sbAllCateList.append("                        <li><a href=\"" + gnb_list_2[k].getG_link() + "\">" + gnb_list_2[k].getG_name().replaceAll("\\<(br|BR)/{0,1}\\>","") + "</a></li>");
                    }
                }
                
                sbAllCateList.append("				</ul>");             
                sbAllCateList.append("</div>");             
            }
        }
        
        sbAllCateList.append("        </div>");
        sbAllCateList.append("        <a href=\"javascript:///\" class=\"btn_close\">창닫기</a>");        
        sbAllCateList.append("    </div></div>");
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
                
                for(int k=gnb_list_2_length; k<10; k++){
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
    
    //광고그룹 배너관리자에서 등록하는 배너 추가
    Bnr_List_Data bnr_ad_data_1 = null;
    Bnr_List_Data bnr_ad_data_2 = null;
    Bnr_List_Data bnr_ad_data_3 = null;
    Bnr_List_Data bnr_ad_data_4 = null;
    Bnr_List_Data bnr_ad_data_5 = null;
    Bnr_List_Data bnr_ad_data_6 = null;
    Bnr_List_Data bnr_ad_data_7 = null;
    Bnr_List_Data bnr_ad_data_8 = null;
    
    for(int i=0; i<gnb_list_0.length; i++){
        if(i==0) bnr_list_data_1 = Bnr_List_Proc.getBnr_List(gnb_list_0[i].getG_seqno());
        if(i==1) bnr_list_data_2 = Bnr_List_Proc.getBnr_List(gnb_list_0[i].getG_seqno());
        if(i==2) bnr_list_data_3 = Bnr_List_Proc.getBnr_List(gnb_list_0[i].getG_seqno());
        if(i==3) bnr_list_data_4 = Bnr_List_Proc.getBnr_List(gnb_list_0[i].getG_seqno());
        if(i==4) bnr_list_data_5 = Bnr_List_Proc.getBnr_List(gnb_list_0[i].getG_seqno());
        if(i==5) bnr_list_data_6 = Bnr_List_Proc.getBnr_List(gnb_list_0[i].getG_seqno());
        if(i==6) bnr_list_data_7 = Bnr_List_Proc.getBnr_List(gnb_list_0[i].getG_seqno());
        if(i==7) bnr_list_data_8 = Bnr_List_Proc.getBnr_List(gnb_list_0[i].getG_seqno());
        
        if(i==0) bnr_ad_data_1 = Bnr_List_Proc.getAdBnr_List("1");
        if(i==1) bnr_ad_data_2 = Bnr_List_Proc.getAdBnr_List("2");
        if(i==2) bnr_ad_data_3 = Bnr_List_Proc.getAdBnr_List("3");
        if(i==3) bnr_ad_data_4 = Bnr_List_Proc.getAdBnr_List("4");
        if(i==4) bnr_ad_data_5 = Bnr_List_Proc.getAdBnr_List("5");
        if(i==5) bnr_ad_data_6 = Bnr_List_Proc.getAdBnr_List("6");
        if(i==6) bnr_ad_data_7 = Bnr_List_Proc.getAdBnr_List("7");
        if(i==7) bnr_ad_data_8 = Bnr_List_Proc.getAdBnr_List("8");
    }

    Bnr_List_Data[][] bnr_list = {bnr_list_data_1, bnr_list_data_2, bnr_list_data_3, bnr_list_data_4, bnr_list_data_5, bnr_list_data_6, bnr_list_data_7,bnr_list_data_8 } ;
    Bnr_List_Data[] bnr_ad_list = {bnr_ad_data_1, bnr_ad_data_2, bnr_ad_data_3, bnr_ad_data_4, bnr_ad_data_5, bnr_ad_data_6, bnr_ad_data_7,bnr_ad_data_8} ;

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
	
	return iconNm;
}
%>