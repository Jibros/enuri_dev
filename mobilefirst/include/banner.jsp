		<div id="list_banner">
		<%
			Banner_List_Proc banner_list_proc_new = new Banner_List_Proc();
			Banner_List_Data[] banner_list_data_new = null;
			String bannerUrlEx = "";
			
			/*
			if(strCate.substring(0,4).equals("0931") || strCate.substring(0,4).equals("0905")){
			
				int result_ran = (int) ( 2 * Math.random() );
				if(result_ran == 1){
					banner_list_data_new = banner_list_proc_new.getDetailmultiBannerList(strCate,"T");				
				}else{
					banner_list_data_new = banner_list_proc_new.getDetailmultiBannerList("main","T");
				}
	
			}else{
				banner_list_data_new = banner_list_proc_new.getDetailmultiBannerList("main","T");
			}
			*/
			
			banner_list_data_new = banner_list_proc_new.getDetailmultiBannerList(strCate,"T");
			
			int intBannerCount = 0; 
			
			if (banner_list_data_new != null && banner_list_data_new.length > 0 ){ 
				
				for (int i=0;i<1;i++){ 
		%>  
		<li style="padding:6px 6px 3px 6px;">
		<% /*if(banner_list_data_new[i].getBanner_no() == 16707		|| banner_list_data_new[i].getBanner_no() == 16708
					|| banner_list_data_new[i].getBanner_no() == 16709	|| banner_list_data_new[i].getBanner_no() == 16710
					|| banner_list_data_new[i].getBanner_no() == 16711	|| banner_list_data_new[i].getBanner_no() == 16712
					|| banner_list_data_new[i].getBanner_no() == 16713	|| banner_list_data_new[i].getBanner_no() == 16714
					|| banner_list_data_new[i].getBanner_no() == 16715	|| banner_list_data_new[i].getBanner_no() == 16716
					|| banner_list_data_new[i].getBanner_no() == 16717  || banner_list_data_new[i].getBanner_no() == 16718
					|| banner_list_data_new[i].getBanner_no() == 16719  || banner_list_data_new[i].getBanner_no() == 16720   || banner_list_data_new[i].getBanner_no() == 16721
					){*/
			if(banner_list_data_new[i].getRedirect_url().indexOf("http://m.enuri.com/mobilefirst/event/event_shopping.jsp") > -1){
				bannerUrlEx = "&freetoken=event"; 
			}else if(banner_list_data_new[i].getRedirect_url().indexOf("/mobilefirst/") > -1){
				bannerUrlEx = "&freetoken=event";
			}else{
				bannerUrlEx = "&freetoken=outlink";
			}
		%> 
			<a href='/move/Redirectad.jsp?register_no=<%=banner_list_data_new[i].getBanner_no()%>&pageNm=list&from=m<%=bannerUrlEx%>' target='_blank'>
			<img src='<%=ConfigManager.STORAGE_ENURI_COM%>/banner/<%=banner_list_data_new[i].getBanner_source_file()%>' border='0' width="100%"/>
			</a>
		</li> 
		<%			
				}
			}
		%>
		</div>