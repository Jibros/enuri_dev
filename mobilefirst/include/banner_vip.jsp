<%
//2017-11-20 사용안함. 하단부분 HTML 만 사용.  >>>>vip_middle_banner<<<< 삭제하면 안됨. 
Banner_List_Proc banner_list_proc_new = new Banner_List_Proc();
Banner_List_Data[] banner_list_data_new = null;
String bannerUrlEx = "";
String strEx = "";
String strBanner_img = "";
int intBannerNo = 0;

if(!strAppyn.equals("Y")){
	strEx = "모바일마케팅";
}else{
	//app이면서 ios 일때 2-15일 update 까지 적용 - 안나오는애들 적는거임.  not like 'strEx%'
	if(i_Log == 5939){
		strEx = "CM그룹";
	}
}
 
banner_list_data_new = banner_list_proc_new.getDetailmultiBannerList_MobileVip(strCate,"V", strEx);
boolean vShow = false;

if (banner_list_data_new != null && banner_list_data_new.length > 0 ){ 
	 
	for (int i=0;i<1;i++){ 
		if(banner_list_data_new[i].getRedirect_url().indexOf("/mobilefirst/") > -1){
			if(banner_list_data_new[i].getBanner_name().indexOf("enuri_VIP") > -1 || banner_list_data_new[i].getBanner_name().indexOf("mobileVIP_") > -1 || banner_list_data_new[i].getBanner_name().indexOf("mobileVIP_event") > -1){
				bannerUrlEx = "&freetoken=event";	
			}else if(banner_list_data_new[i].getRedirect_url().indexOf("/mobilefirst/list.jsp") > -1){
				bannerUrlEx = "&freetoken=list";
			}else if(banner_list_data_new[i].getRedirect_url().indexOf("/mobilefirst/search.jsp") > -1){
				bannerUrlEx = "&freetoken=list";
			}else if(banner_list_data_new[i].getRedirect_url().indexOf("/mobilefirst/news_detail.jsp") > -1){
				bannerUrlEx = "&freetoken=news";
			}else{
				bannerUrlEx = "&freetoken=list";
			}
		} else bannerUrlEx = "&freetoken=outlink";
		
		intBannerNo = banner_list_data_new[i].getBanner_no();
		strBanner_img = banner_list_data_new[i].getBanner_source_file();
	}
}
%>
	<ul class="vip_middle_banner">    
		<li>
			<img src="<%=strBanner_img %>" border="0" width="100%"/>
		</li>
	</ul> 