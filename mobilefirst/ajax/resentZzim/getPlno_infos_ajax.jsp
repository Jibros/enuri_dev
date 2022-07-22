<%@ page contentType="text/html; charset=utf-8"%>
<%@ page pageEncoding="utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.main.Save_Goods_Proc"%>
<%@ page import="com.enuri.bean.main.Pricelist_Data"%>
{
<%
	long plno = Long.parseLong(ChkNull.chkStr(request.getParameter("plno"), "0"));

	Save_Goods_Proc save_goods_proc = new Save_Goods_Proc();

	if(plno>0) {
		Pricelist_Data pricelist_data = save_goods_proc.getPricelistData(plno);
		
		String strCa_codel = pricelist_data.getCa_code();
		long lngPl_no = pricelist_data.getPl_no();
		String strShop_url = pricelist_data.getUrl();
		String strShop_MoUrl = pricelist_data.getMobile_url();
		int strShop_code = pricelist_data.getShop_code();
		
		String strMobile_url = "";
		
		//쇼핑몰에 따른 모바일 url & 수익코드 변경
		if(strShop_MoUrl.length()>0 && strShop_MoUrl.indexOf("http")>-1) {
			strMobile_url = toUrlCode(strShop_MoUrl);
		} else {
			strMobile_url = toUrlCode(strShop_url);
		}
		
		if (strMobile_url.indexOf("/mobilefirst/move.jsp") <= 0) {
		    // 현재 도메인
		    String szServerName = request.getServerName().trim();
		    
		    if (ChkNull.chkStr(szServerName).isEmpty()) {
		    	szServerName = "m.enuri.com";
		    }
		    
		  	//해외직구 상품일경우 몰리 게이트 페이지로 전달
		    //2019-11-07 shwoo

		    if(",8446,8447,8448,8826,8827,8828,8829,".indexOf(","+strShop_code+",") > -1){
		    	//업체 맵핑
				String strOvsShopcode = "";
		    	if(strShop_code == 8446)	strOvsShopcode = "1739";
		    	if(strShop_code == 8447)	strOvsShopcode = "440";
		    	if(strShop_code == 8448)	strOvsShopcode = "1270";
		    	if(strShop_code == 8826)	strOvsShopcode = "7650";
		    	if(strShop_code == 8827)	strOvsShopcode = "782";
		    	if(strShop_code == 8828)	strOvsShopcode = "469";
		    	if(strShop_code == 8829)	strOvsShopcode = "7714";
	        	
	        	strMobile_url = "http://" + szServerName + "/global/m/portal.jsp?freetoken=outbrowser&muid="+strOvsShopcode+"&url="+ URLEncoder.encode(strMobile_url) +"&ch="+System.currentTimeMillis() +"&from=en";		// 브릿지 페이지 작업
		    }else{
		    	strMobile_url = "http://" + szServerName + "/mobilefirst/move.jsp?freetoken=outlink&vcode="+strShop_code+"&plno="+ lngPl_no +"&url="+ URLEncoder.encode(strMobile_url) +"&ch="+System.currentTimeMillis() +"&from=en";		// 브릿지 페이지 작업		    	
		    }
		}
		
		if(pricelist_data!=null) {
			out.println("	\"shop_code\":\""+pricelist_data.getShop_code()+"\",");
			out.println("	\"ca_code\":\""+strCa_codel+"\",");
			out.println("	\"pl_no\":\""+lngPl_no+"\",");
			out.println("	\"url\":\""+strMobile_url+"\"");
		}
	}
%>
}