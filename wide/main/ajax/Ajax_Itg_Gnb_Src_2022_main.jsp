<%@page import="com.enuri.bean.main.Itg_GNB_List_2022_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
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
	String stype       = ChkNull.chkStr(request.getParameter("stype"));    //"":카테고리, allCate : 전체카테고리
	
	Itg_GNB_List_2022_Proc 		GNB_List_Proc       = new Itg_GNB_List_2022_Proc();
	Bnr_List_Proc_2018      Bnr_List_Proc       = new Bnr_List_Proc_2018();
	
	GNB_List_Data gnb_one = GNB_List_Proc.getGNB0Level(g_seq);
	
	Bnr_List_Data[] bnr_one_list   = Bnr_List_Proc.getBnr_List(gnb_one.getG_seqno());
	GNB_List_Data[] gnb_list_0     = GNB_List_Proc.getGNB_List(0, 0);
	
	
	StringBuilder sbAllCateList = new StringBuilder();
	StringBuilder sbGnbList     = new StringBuilder();
	
	int hg_gnb_no = gnb_one.getG_seqno();

if(stype.equals("")){ //gnb 카테고리
	
	if( gnb_list_0!=null && gnb_list_0.length>0 ){
			
			GNB_List_Data[] gnb_list_1 = GNB_List_Proc.getGNB_List(1, hg_gnb_no); 
			
			String catenm0 = gnb_list_0[g_seq-1].getG_name();
			
			if(gnb_list_1!=null && gnb_list_1.length>0){
				
				String groupCate = "";
				
			    for(int j=0; j<gnb_list_1.length; j++){
			    	
			    	String bd_lcate_nm = gnb_list_1[j].getBd_lcate_nm();
			    	
			    	GNB_List_Data[] gnb_list_2 = GNB_List_Proc.getGNB_List(2, gnb_list_1[j].getG_seqno()); 
			    	if(j != 0){
			    		if(!StringUtils.equals(groupCate, bd_lcate_nm)){
			    			
			    			if(gnb_list_2.length > 0){
				    			sbGnbList.append("</li>");
						    	sbGnbList.append("</ul>");
			    			}else{
			    				sbGnbList.append("</ul>");
			    			}
				    	}
			    	}
			    	
			    	
			    	if(!StringUtils.equals(groupCate, bd_lcate_nm)){
			    		
                        sbGnbList.append("<li class='cate-item--depth2 "+gnb_list_2.length+"'>");
                        
                        String insertLog = "";
                        if(g_seq == 1)			insertLog = "onclick='insertLog(26572)'";
                        else if(g_seq == 2)		insertLog = "onclick='insertLog(26573)'";
                        else if(g_seq == 3)		insertLog = "onclick='insertLog(26574)'";
                        else if(g_seq == 4)		insertLog = "onclick='insertLog(26575)'";
                        else if(g_seq == 5)		insertLog = "onclick='insertLog(26576)'";
                        else if(g_seq == 6)		insertLog = "onclick='insertLog(26577)'";
                        else if(g_seq == 7)		insertLog = "onclick='insertLog(26578)'";
                        else if(g_seq == 8)		insertLog = "onclick='insertLog(26579)'";
                        else if(g_seq == 9)		insertLog = "onclick='insertLog(26580)'";
                        else if(g_seq == 10)	insertLog = "onclick='insertLog(26581)'";
                        else if(g_seq == 11)	insertLog = "onclick='insertLog(26582)'";
                        
                        	if( gnb_list_1[j].getG_name().equals("")){                        	
		                      
		                      sbGnbList.append("<a href=\""+gnb_list_1[j].getG_link()+"\" class='cate__tit--depth2 "+j+"' "+insertLog+" >");
		                      sbGnbList.append(bd_lcate_nm);
		                      sbGnbList.append("</a>");
                        	}else{
                        		sbGnbList.append("<p class='cate__tit--depth2'>");
                            	sbGnbList.append(bd_lcate_nm);
                            	sbGnbList.append("</p>");	
                        	}

								
                        	if(gnb_list_2.length > 0){
                        		sbGnbList.append("<ul class='cate--depth3'>");
                        	}
                            
			    	}
			    		
			    		if(gnb_list_2.length > 0){
			    			if(j == 0)	sbGnbList.append("<li class='cate-item cate-item--depth3 is--on'>");	
				    		else		sbGnbList.append("<li class='cate-item cate-item--depth3'>");
			    		}
			    		
			    			if(!gnb_list_1[j].getG_name().equals("")){
			    				sbGnbList.append("<p>");	
			    				sbGnbList.append(gnb_list_1[j].getG_name());
			    				sbGnbList.append(gnb_list_1[j].getG_icon().equals("H") ? "<i class='ico-badge ico-badge--pop comm__sprite'>인기</i>" : (gnb_list_1[j].getG_icon().equals("N") ? "<i class='ico-badge ico-badge--new comm__sprite'>신규</i>" : (gnb_list_1[j].getG_icon().equals("A") ? "<i class='ico-badge ico-badge--a19 comm__sprite'>성인</i>" : "")));
			    				sbGnbList.append("</p>");
			    			}
			    			
			    			
					        if(gnb_list_2!=null && gnb_list_2.length>0){
					        	//sbGnbList.append("<ul class='twolist'>");
					        	sbGnbList.append("<div class='cate-item__expend--depth3'>");
					        	sbGnbList.append("<p class='cate__tit--depth3'>"+gnb_list_1[j].getG_name().trim());
					        	//sbGnbList.append("<div class='twogroup'>");
					        	//sbGnbList.append("<div class='twogroup__head'>");
                                //sbGnbList.append("<p class='twogroup__tit'>"+gnb_list_1[j].getG_name()+"</p>");
                              	//전체보기 버튼
	                            
					        	sbGnbList.append("</p>");
	                            
	                            sbGnbList.append("<ul class='cate--depth4'>");
	                            
	                            sbGnbList.append(	"<li class='cate-item cate-item--depth4'>");
	                            
	                            String strG_Link = gnb_list_1[j].getG_link();
        			        	if(strG_Link != null && strG_Link.length() > 0){
        			        		String strHtmlTarget = "";
        			        		if(strG_Link.indexOf("http") > -1) strHtmlTarget = "target = \"_blank\""; 
        			        		
        			        			if(g_seq == 1) sbGnbList.append( "<a href='"+strG_Link+"' onclick='insertLog(26597);' "+strHtmlTarget+">전체보기</a>");
        			        		else if(g_seq == 2) sbGnbList.append( "<a href='"+strG_Link+"' onclick='insertLog(26598);' "+strHtmlTarget+">전체보기</a>");
        			        		else if(g_seq == 3) sbGnbList.append( "<a href='"+strG_Link+"' onclick='insertLog(26599);' "+strHtmlTarget+">전체보기</a>");
        			        		else if(g_seq == 4) sbGnbList.append( "<a href='"+strG_Link+"' onclick='insertLog(26600);' "+strHtmlTarget+">전체보기</a>");
        			        		else if(g_seq == 5) sbGnbList.append( "<a href='"+strG_Link+"' onclick='insertLog(26601);' "+strHtmlTarget+">전체보기</a>");
        			        		else if(g_seq == 6) sbGnbList.append( "<a href='"+strG_Link+"' onclick='insertLog(26602);' "+strHtmlTarget+">전체보기</a>");
        			        		else if(g_seq == 7) sbGnbList.append( "<a href='"+strG_Link+"' onclick='insertLog(26603);' "+strHtmlTarget+">전체보기</a>");
        			        		else if(g_seq == 8) sbGnbList.append( "<a href='"+strG_Link+"' onclick='insertLog(26604);' "+strHtmlTarget+">전체보기</a>");
        			        		else if(g_seq == 9) sbGnbList.append( "<a href='"+strG_Link+"' onclick='insertLog(26605);' "+strHtmlTarget+">전체보기</a>");
        			        		else if(g_seq == 10) sbGnbList.append("<a href='"+strG_Link+"' onclick='insertLog(26606);' "+strHtmlTarget+">전체보기</a>");
        			        		else if(g_seq == 11) sbGnbList.append("<a href='"+strG_Link+"' onclick='insertLog(26607);' "+strHtmlTarget+">전체보기</a>");
        			        		
        			        	}
        			        	sbGnbList.append("</li>");
        			        	
					            for(int k=0; k<gnb_list_2.length && k<18; k++){
					            	
					                GNB_List_Data[] gnb_list_3 = GNB_List_Proc.getGNB_List(3, gnb_list_2[k].getG_seqno());
					
					                if(k == 0 ) sbGnbList.append("<li class='cate-item cate-item--depth4 is--on'>");	
					                else       	sbGnbList.append("<li class='cate-item cate-item--depth4'>");
					                
					                //sbGnbList.append("<a href='"+gnb_list_2[k].getG_link()+"' >");
        			        		
					                String strLev2Lnk = gnb_list_2[k].getG_link();
					                
					                if( g_seq == 1) sbGnbList.append(  "<a href='"+ (strLev2Lnk.length() > 0 ? strLev2Lnk : "javascript:void(0)")+"' onclick='insertLog(24300);'  "+(strLev2Lnk.indexOf("http") > -1 ? "target=\"_blank\"" : "")+">");
        			        		else if(g_seq == 2) sbGnbList.append( "<a href='"+(strLev2Lnk.length() > 0 ? strLev2Lnk : "javascript:void(0)")+"' onclick='insertLog(24301);' "+(strLev2Lnk.indexOf("http") > -1 ? "target=\"_blank\"" : "")+">");
        			        		else if(g_seq == 3) sbGnbList.append( "<a href='"+(strLev2Lnk.length() > 0 ? strLev2Lnk : "javascript:void(0)")+"' onclick='insertLog(24302);' "+(strLev2Lnk.indexOf("http") > -1 ? "target=\"_blank\"" : "")+">");
        			        		else if(g_seq == 4) sbGnbList.append( "<a href='"+(strLev2Lnk.length() > 0 ? strLev2Lnk : "javascript:void(0)")+"' onclick='insertLog(24303);' "+(strLev2Lnk.indexOf("http") > -1 ? "target=\"_blank\"" : "")+">");
        			        		else if(g_seq == 5) sbGnbList.append( "<a href='"+(strLev2Lnk.length() > 0 ? strLev2Lnk : "javascript:void(0)")+"' onclick='insertLog(24304);' "+(strLev2Lnk.indexOf("http") > -1 ? "target=\"_blank\"" : "")+">");
        			        		else if(g_seq == 6) sbGnbList.append( "<a href='"+(strLev2Lnk.length() > 0 ? strLev2Lnk : "javascript:void(0)")+"' onclick='insertLog(24305);' "+(strLev2Lnk.indexOf("http") > -1 ? "target=\"_blank\"" : "")+">");
        			        		else if(g_seq == 7) sbGnbList.append( "<a href='"+(strLev2Lnk.length() > 0 ? strLev2Lnk : "javascript:void(0)")+"' onclick='insertLog(24306);' "+(strLev2Lnk.indexOf("http") > -1 ? "target=\"_blank\"" : "")+">");
        			        		else if(g_seq == 8) sbGnbList.append( "<a href='"+(strLev2Lnk.length() > 0 ? strLev2Lnk : "javascript:void(0)")+"' onclick='insertLog(24307);' "+(strLev2Lnk.indexOf("http") > -1 ? "target=\"_blank\"" : "")+">");
        			        		else if(g_seq == 9) sbGnbList.append( "<a href='"+(strLev2Lnk.length() > 0 ? strLev2Lnk : "javascript:void(0)")+"' onclick='insertLog(24308);' "+(strLev2Lnk.indexOf("http") > -1 ? "target=\"_blank\"" : "")+">");
        			        		else if(g_seq == 10) sbGnbList.append( "<a href='"+(strLev2Lnk.length() > 0 ? strLev2Lnk : "javascript:void(0)")+"' onclick='insertLog(24309);' "+(strLev2Lnk.indexOf("http") > -1 ? "target=\"_blank\"" : "")+">");
        			        		else if(g_seq == 11) sbGnbList.append("<a href='"+(strLev2Lnk.length() > 0 ? strLev2Lnk : "javascript:void(0)")+"' onclick='insertLog(24310);' "+(strLev2Lnk.indexOf("http") > -1 ? "target=\"_blank\"" : "")+">");
        			        		
					                
					                sbGnbList.append(gnb_list_2[k].getG_name().replaceAll("\\<(br|BR)/{0,1}\\>",""));
					                
					                sbGnbList.append(gnb_list_2[k].getG_icon().equals("H") ? "<i class='ico-badge ico-badge--pop comm__sprite'>인기</i>" : (gnb_list_2[k].getG_icon().equals("N") ? "<i class='ico-badge ico-badge--new comm__sprite'>신규</i>" : (gnb_list_2[k].getG_icon().equals("A") ? "<i class='ico-badge ico-badge--a19 comm__sprite'>성인</i>" : "")));
					                //sbGnbList.append("<span class=\"icon arrow\">화살표</span>");
					                sbGnbList.append("</a>");
								                
					                if(gnb_list_3!=null && gnb_list_3.length>0){
					                	
					                	sbGnbList.append("<div class='cate-item__expend--depth4'>");
                                    	sbGnbList.append("	<p class='cate__tit--depth4'>"+gnb_list_2[k].getG_name().replaceAll("\\<(br|BR)/{0,1}\\>","")+"</p>");
                                    	
					                	boolean indentYN = false;
					                	
					                	/////////////level 4 시작
					                	sbGnbList.append("<ul class='cate--depth5'>");
					                	
					                    for(int l=0; l<gnb_list_3.length && l<18; l++){
					                       String strIconVal = ChkNull.chkStr(gnb_list_3[l].getG_icon());
					                       String strIconHtml = "";
											
					                       	if (strIconVal.length() > 0) {
						                       	if (strIconVal.equals("H")) {
						                       		strIconHtml = "<i class='ico-badge ico-badge--pop comm__sprite'>인기</i>";
							                    } else if (strIconVal.equals("N")) {
							                    	strIconHtml = "<i class='ico-badge ico-badge--new comm__sprite'>신규</i>";
							                    }else if (strIconVal.equals("A")) {
							                    	strIconHtml = "<i class='ico-badge ico-badge--a19 comm__sprite'>성인</i>";
							                    }
					                       	}

					                        String insertlog = "";
		        			        		
		        			        			 if(g_seq == 1)  insertlog = "onclick='insertLog(24322);'";
		        			        		else if(g_seq == 2)  insertlog = "onclick='insertLog(24323);'";
		        			        		else if(g_seq == 3)  insertlog = "onclick='insertLog(24324);'";
		        			        		else if(g_seq == 4)  insertlog = "onclick='insertLog(24325);'";
		        			        		else if(g_seq == 5)  insertlog = "onclick='insertLog(24326);'";
		        			        		else if(g_seq == 6)  insertlog = "onclick='insertLog(24327);'";
		        			        		else if(g_seq == 7)  insertlog = "onclick='insertLog(24328);'";
		        			        		else if(g_seq == 8)  insertlog = "onclick='insertLog(24329);'";
		        			        		else if(g_seq == 9)  insertlog = "onclick='insertLog(24330);'";
		        			        		else if(g_seq == 10)  insertlog = "onclick='insertLog(24331);'";
		        			        		else if(g_seq == 11) insertlog = "onclick='insertLog(24332);'";
					                        
											String strLev3Lnk = gnb_list_3[l].getG_link();	        			        		
				                        	sbGnbList.append("<li class='cate-item cate-item--depth5'>");
				                        	sbGnbList.append("	<a href='"+strLev3Lnk+"' "+insertlog+" "+(strLev3Lnk.indexOf("http") > -1 ? "target=\"_blank\"" : "")+"> "+gnb_list_3[l].getG_name().replaceAll("\\<(br|BR)/{0,1}\\>","") +" "); 
				                        	sbGnbList.append(strIconHtml);
				                        	sbGnbList.append("	</a>");
				                        	sbGnbList.append("</li>");
					                        
					                    }
					                    sbGnbList.append(	"</ul>");
					                   

					                    sbGnbList.append("</div>");
					                }
					                
					            }
					            sbGnbList.append("</div>");

					        }
			    	
			    	groupCate = bd_lcate_nm;
			    	
				}

			}
	}
    out.println(sbGnbList.toString().replaceAll("(\\>)([\\s\\t\\r\\n]+)(\\<)","$1$3"));
}else if(stype.equals("allCate")){ //전체카테고리
    
	for(int i=0; i<gnb_list_0.length; i++){
	    
		String insertLog = "";
		String moreLog = "";
		
        if((i+1) == 1) {
        	insertLog = "onclick='insertLog(24288)'";
        	moreLog = "onclick='insertLog(27019)'";
        }else if((i+1) == 2)	{
        	insertLog = "onclick='insertLog(24289)'";
        	moreLog = "onclick='insertLog(27020)'";
        }else if((i+1) == 3){
        	insertLog = "onclick='insertLog(24290)'";
        	moreLog = "onclick='insertLog(27021)'";
        }else if((i+1) == 4) {
        	insertLog = "onclick='insertLog(24291)'";
        	moreLog = "onclick='insertLog(27022)'";
        }else if((i+1) == 5) {
        	insertLog = "onclick='insertLog(24292)'";
        	moreLog = "onclick='insertLog(27023)'";
        }else if((i+1) == 6) {
        	insertLog = "onclick='insertLog(24293)'";
        	moreLog = "onclick='insertLog(27024)'";
        }else if((i+1) == 7) {
        	insertLog = "onclick='insertLog(24294)'";
        	moreLog = "onclick='insertLog(27025)'";
        }else if((i+1) == 8)	 {
        	insertLog = "onclick='insertLog(24295)'";
        	moreLog = "onclick='insertLog(27026)'";
        }else if((i+1) == 9)	 {
        	insertLog = "onclick='insertLog(24296)'";
        	moreLog = "onclick='insertLog(27027)'";
        }else if((i+1) == 10) {
        	insertLog = "onclick='insertLog(24297)'";
        	moreLog = "onclick='insertLog(27028)'";
        }else if((i+1) == 11){
        	insertLog = "onclick='insertLog(24298)'";
        	moreLog = "onclick='insertLog(27029)'";
        }
		
		
    	if(i == 0) sbAllCateList.append("<li class='cate-item--depth1 is--on'>");
    	else sbAllCateList.append("<li class='cate-item--depth1'>"); 
    	
	    sbAllCateList.append("    <div class='cate__tit'>"+gnb_list_0[i].getG_name().replaceAll("\\<(br|BR)/{0,1}\\>","") +"</div>");
	    sbAllCateList.append("    <div class='cate-item__expand'>");
	    sbAllCateList.append("        <ul class='cate--depth2'>");
	    GNB_List_Data[] gnb_list_1 = GNB_List_Proc.getGNB_List(1, gnb_list_0[i].getG_seqno()); //대분류 목록
	    
	    boolean moreFlag = false;
	    
        if(gnb_list_1!=null && gnb_list_1.length>0){
            for(int j=0; j<gnb_list_1.length && j<12; j++){

            	
        GNB_List_Data[] cnt = GNB_List_Proc.getGNB_List(2, gnb_list_1[j].getG_seqno()); //중분류 목록
        if(cnt.length == 0) continue;
        
        if(cnt.length > 11){
        	if(!gnb_list_1[j].getG_link().equals("")){
        		sbAllCateList.append("<li class='cate-item--depth2'>");	
        		moreFlag = true;
        	}else{
        		sbAllCateList.append("<li class='cate-item--depth2' style='width: 33.3333%;'>");
        		
        	}
        		
        }else{
        	sbAllCateList.append("<li class='cate-item--depth2'>");
        	moreFlag = false;
        }

        sbAllCateList.append("<div class='cate__tit'>");
        if(gnb_list_1[j].getG_link()!=""){
            sbAllCateList.append("<a href=\""+gnb_list_1[j].getG_link()+"\" "+insertLog+"  >");
        }
        sbAllCateList.append(gnb_list_1[j].getG_name().replaceAll("\\<(br|BR)/{0,1}\\>",""));
        if(gnb_list_1[j].getG_link()!=""){    
            sbAllCateList.append("</a>");
        }
        sbAllCateList.append("</div>");
	    sbAllCateList.append("<ul class='cate--depth3'>");
	    
        GNB_List_Data[] gnb_list_2 = GNB_List_Proc.getGNB_List(2, gnb_list_1[j].getG_seqno()); //중분류 목록
        
        if(gnb_list_2!=null && gnb_list_2.length>0){
            for(int k=0; k<gnb_list_2.length && k<18; k++){
	    
	    	sbAllCateList.append("<li class='cate-item--depth3'><a href='"+gnb_list_2[k].getG_link()+"' "+insertLog+" >"+gnb_list_2[k].getG_name().replaceAll("\\<(br|BR)/{0,1}\\>","")+"</a></li>");
            	if(moreFlag){
            		if(k == 9){
            			break;
            		}
            	}
            }
            if(moreFlag){
            	sbAllCateList.append("<li class='cate-item--depth3'><a href='"+gnb_list_1[j].getG_link()+"' class='view_morecate' "+moreLog+">카테고리 더보기</a></li>");
            }
        }
        
	    sbAllCateList.append("</ul>");
	    sbAllCateList.append("</li>");
	    
	    
            }
        }

	    sbAllCateList.append(		"</ul>");
	    sbAllCateList.append(	"</div>");
	    sbAllCateList.append("</li>");
    	
    }
    out.println(sbAllCateList.toString().replaceAll("(\\>)([\\s\\t\\r\\n]+)(\\<)","$1$3"));
}
%>
