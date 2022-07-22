<%
	//카테고리
	String strCate_coupon = ChkNull.chkStr(request.getParameter("cate"),"00000000");	
	String strCate_coupon2 = "";
	String strCate_coupon4 = "";
	String strCate_coupon6 = "";
	
	if(strCate_coupon.length()>=2){
		strCate_coupon2 = CutStr.cutStr(strCate_coupon,2);
	}	
	if(strCate_coupon.length()>=4){
		strCate_coupon4 = CutStr.cutStr(strCate_coupon,4);
	}	
	if(strCate_coupon.length()>=6){
		strCate_coupon6 = CutStr.cutStr(strCate_coupon,6);
	}	
	
	//쿠폰 노출
	String thisUrl =  HttpUtils.getRequestURL(request).toString();
	String imgNo = "";
	
	//검색 10%		 : 05.png
	if(thisUrl.indexOf("/search.jsp") > 0){			
		imgNo = "05";
	}else{
		// 2,000원 할인 쿠폰 노출 카테고리 코드 : 02 ,03, 04, 05, 06, 07, 21, 22, 24, 0918	 : 04.png
		if(strCate_coupon2.equals("02") || strCate_coupon2.equals("03") || strCate_coupon2.equals("04") || strCate_coupon2.equals("05") || strCate_coupon2.equals("06") || strCate_coupon2.equals("07")
			|| strCate_coupon2.equals("21") ||  strCate_coupon2.equals("22") || strCate_coupon2.equals("24") || strCate_coupon4.equals("0918")	){	
			imgNo = "04";	
		//10% 할인 쿠폰 노출 카테고리 코드 : 08, 09(0918은 제외), 14(145210은 제외)	 : 03.png	
		}else if( strCate_coupon2.equals("08") || ( strCate_coupon2.equals("09")  &&  !strCate_coupon4.equals("0918"))  || ( strCate_coupon2.equals("14")  &&  !strCate_coupon6.equals("145210")) ){				
			imgNo = "03";	
		// 5% 할인 쿠폰 노출 카테고리 코드 : 10, 16, 18 : 01.png	
		}else if(strCate_coupon2.equals("10") || strCate_coupon2.equals("18") || strCate_coupon4.equals("1620")  || strCate_coupon4.equals("1643")  || strCate_coupon4.equals("1644")  || strCate_coupon4.equals("1645") ){				
			imgNo = "01";	
		// 7% 할인 쿠폰 노출 카테고리 코드: 12, 15		 : 02.png
		}else if(strCate_coupon2.equals("12") || strCate_coupon2.equals("15")  || strCate_coupon2.equals("16") ){				
			imgNo = "02";	
		} 
	}
	
%>
<style>

</style> 
<%if(imgNo.length() > 0){%>
<div class="aution_bnr">
	<a href="http://banner.auction.co.kr/bn_redirect.asp?ID=BN00194049" target="_new">
		<img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/bn_auction<%=imgNo%>.png" />
	</a>
</div>
<%}%>