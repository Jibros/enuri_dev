<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="com.enuri.util.common.*"%>
<%@ page import="com.enuri.bean.main.Goods_Ad_Proc"%>
<%@ page import="com.enuri.bean.main.Goods_Ad_Data"%>
<%@ page import="com.enuri.bean.main.Mobile_Category_Proc"%>
<%@ page import="com.enuri.bean.main.Mobile_Category_Data"%>
<jsp:useBean id="Goods_Ad_Proc" class="com.enuri.bean.main.Goods_Ad_Proc" scope="page" />
<%@ page import="com.enuri.util.common.Ca_Ad_Keyword"%>
<jsp:useBean id="Ca_Ad_Keyword" class="com.enuri.util.common.Ca_Ad_Keyword" scope="page" />
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
{
<% 
	String szCategory = ConfigManager.RequestStr(request, "szCategory", "0000");
	String ad_command = ConfigManager.RequestStr(request, "ad_command", "");
	String ad_command2 = ConfigManager.RequestStr(request, "ad_command2", "");
	String strCate = ConfigManager.RequestStr(request, "cate", "");
	String data_cnt = ChkNull.chkStr(request.getParameter("data_cnt"),"w8");
	data_cnt = ReplaceStr.replace(data_cnt,"w","");
	String strUrl = ChkNull.chkStr(request.getParameter("url"),"");
	String strReferer = ChkNull.chkStr(request.getParameter("referrer"),"");
	String ConnectIp = ChkNull.chkStr(request.getRemoteAddr(),"");
	String strUserAgent = ChkNull.chkStr(request.getHeader("User-Agent"));
	String strCh = ChkNull.chkStr(request.getParameter("strCh"));
	String ad_command_tmp = "";
	
	//int showMaxCnt = 5;
	int showMaxCnt = 7;
	
	String replaceCmd = "";
	String strPage = ChkNull.chkStr(request.getHeader("REFERER"));
	String strPageChk = "";
	
	
	// 20200207 구버전 파워링크 신규 api 로 치환
	// 모바일앱만 쓴다는 가정.
	String baseNewUrl = "/lsv2016/ajax/connectApiPowerlink.jsp";
	if(strUrl.indexOf("list.jsp") > -1) {
		response.sendRedirect(baseNewUrl+"?type=LP&old=Y&device=mo&cate="+szCategory);
	} else if(strUrl.indexOf("search.jsp") > -1) {
		response.sendRedirect(baseNewUrl+"?keyword="+URLEncoder.encode(ad_command, "UTF-8")+"&type=SRP&old=Y&device=mo");
	} else {
		response.sendRedirect(baseNewUrl+"?keyword="+URLEncoder.encode(ad_command, "UTF-8")+"&type=SRP&old=Y&device=mo");
	}
	
	if(false) {
		if(strPage.indexOf("mobilenew/search.jsp") > -1){
			strPageChk = "#백화점관";
		}else if(strPage.indexOf("mobiledepart/search.jsp") > -1){
			strPageChk = "#통합검색";	
		}else{
			strPageChk = strCate;
		}
	
		if(strUrl.equals("search.jsp"))
		{
			strReferer="";
			strUrl = "http://m.enuri.com/mobilefirst/search.jsp?keyword="+ad_command;
			strCh= "m_enuri.ch4";
			Goods_Ad_Proc.setbMobile(true);
		}
		if(strUrl.equals("list.jsp"))
		{
			strReferer="";
			strUrl = "http://m.enuri.com/mobilefirst/list.jsp?cate="+szCategory;
			strCh = "m_enuri.ch5";		
			Goods_Ad_Proc.setbMobile(true);
		}
		
		if(strPage.indexOf("/search.jsp") > -1){
			
		}else{
			ad_command_tmp = Ca_Ad_Keyword.Ca_Ad_Google_Call(strCate);
			if(!ad_command_tmp.equals("")){
				ad_command = ad_command_tmp;
			}
		}
	
		//System.out.println("==========strReferer "+strReferer);
		//System.out.println("==========strUrl "+strUrl);
		//System.out.println("==========strCh "+strCh);
		//System.out.println("strPageChk===="+strPageChk);
		// 두번째 검색어가 없을 경우는 상품창 
		// 보여주는 최대개수는 상품창일 경우 4개 
		// 목록은 5개
		if(ad_command2.length()==0 && (strUrl.indexOf("detail.jsp")>-1  || strUrl.indexOf("vip.jsp")>-1)) {
			//showMaxCnt = 4;
			showMaxCnt = 5;
		}
		 
		//System.out.println("strUrl="+strUrl);
		//System.out.println("strReferer="+strReferer);
		
		// 추가분류가 없을 때 원분류를 사용함 
		if(strCate.length()<=2) strCate = szCategory;
		
		Goods_Ad_Data[] goods_ad_data = null;
	
		boolean bAdPost = false;
		if (com.enuri.util.date.DateUtil.getDaysDiff("2012-11-01",com.enuri.util.date.DateStr.nowStr()) <= 0 || request.getServerName().trim().equals("dev.enuri.com")){
			bAdPost = true;
		}
		
	
		replaceCmd = ad_command;
	
		if (!bAdPost){ 
			if(strPageChk.indexOf("백화점관") > -1 || strPageChk.indexOf("통합검색") > -1){
		//		goods_ad_data = Goods_Ad_Proc.Goods_ad_List_Overture(ad_command,ConnectIp,strUrl,data_cnt,"goods", strPageChk);
			}else{
		//		goods_ad_data = Goods_Ad_Proc.Goods_ad_List_Overture(ad_command,ConnectIp,strUrl,data_cnt,"goods", CutStr.cutStr(strCate,2));
			}	
		} else {
			int intCnt = 8; 
			if (ChkNull.chkNumber(data_cnt)){
				intCnt = Integer.parseInt(data_cnt);
			}
		//	goods_ad_data = Goods_Ad_Proc.Goods_ad_List_Adpost(strCh,intCnt,ad_command,ConnectIp,strUrl,strUserAgent,strReferer,request.getServerName(), strPageChk);
			
		
			
			if (goods_ad_data == null || (goods_ad_data != null && goods_ad_data.length == 0)){
				if(ad_command2.length()==0) {
					//카테고리명(중분류)
					Mobile_Category_Proc mobile_category_proc = new Mobile_Category_Proc();
					Mobile_Category_Data[] mobile_category_name_data = mobile_category_proc.Mobile_Category_Name(strCate);	
		
					if(strCate.length() > 2){
						if(mobile_category_name_data != null && mobile_category_name_data.length > 0 ){
							ad_command2 = mobile_category_name_data[0].getC_name4();
						}
					}
				}
	
			//	goods_ad_data = Goods_Ad_Proc.Goods_ad_List_Adpost(strCh,intCnt,ad_command2,ConnectIp,strUrl,strUserAgent,strReferer,request.getServerName(), strPageChk);
	
				replaceCmd = ad_command2;
			}
		}
	
		if(goods_ad_data!=null && goods_ad_data.length>0) {
			
			out.println("	\"adRequestLink\":\"http://searchad.naver.com/Event/WelcomePromotion\",");
			out.println("	\"adLinkList\":[");
	
			int showListCnt = goods_ad_data.length;
			if(showListCnt>showMaxCnt) showListCnt = showMaxCnt;
	
			for(int i=0; i<showListCnt;i++) {
				String line1 = goods_ad_data[i].getLine1();
				String line2 = goods_ad_data[i].getLine2();
	
				//line1 = ReplaceStr.replace(line1, replaceCmd, "<font style='font-weight:bold;'>"+replaceCmd+"</font>");
				//line2 = ReplaceStr.replace(line2, replaceCmd, "<font style='font-weight:bold;'>"+replaceCmd+"</font>");
				line1 = line1.replace(replaceCmd, "<font style='font-weight:bold;'>"+replaceCmd+"</font>");
				line2 = line2.replace(replaceCmd, "<font style='font-weight:bold;'>"+replaceCmd+"</font>");
	
				if(i>0) out.print(",\r\n");
				out.println("			{");
				out.println("			\"line1\":\""+toJS2(line1)+"\", ");
				out.println("			\"line2\":\""+toJS2(line2)+"\", ");
				out.println("			\"visible_url\":\""+goods_ad_data[i].getVisible_url()+"\", ");
				out.println("			\"url\":\""+goods_ad_data[i].getUrl()+"\" ");
				out.print("			}");
			}
			out.println("\r\n		]");
		}
	}
%>
}