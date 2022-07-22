<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ include file="/include/IncMoneyStyle_2010.jsp"%>
<%@ page import="com.enuri.bean.main.Pricelist_Proc"%>
<%@ page import="com.enuri.bean.main.Pricelist_Data"%>
<jsp:useBean id="Pricelist_Data" class="com.enuri.bean.main.Pricelist_Data"  />
<jsp:useBean id="Pricelist_Proc" class="com.enuri.bean.main.Pricelist_Proc"  />
<%@ page import="com.enuri.bean.main.Shoplist_Data"%>
<%@ page import="com.enuri.bean.main.Shoplist_Proc"%>
<jsp:useBean id="Shoplist_Data" class="com.enuri.bean.main.Shoplist_Data"  />
<jsp:useBean id="Shoplist_Proc" class="com.enuri.bean.main.Shoplist_Proc"  />
<%
	long iPlno = ChkNull.chkLong(request.getParameter("plno"));

	Pricelist_Proc pricelist_proc = new Pricelist_Proc();
	Pricelist_Data pricelist_data = pricelist_proc.getData_Delivery(iPlno);
	
	//boolean blOpenmarket = pricelist_proc.isPricelistOpenmarket(iPlno);
	boolean blOpenmarket = false;
	
	//System.out.println("blOpenmarket>>>>>>>>>>"+blOpenmarket);
	//getData_Plno(int plno)

	String szRedirect = "";
	String mPrice = ""; 
	String PriceCard = "";
	String strSum_price = "";	
	String strDeliveryinfo = "";
	int intDeliveryinfo2 = 0;
	int intDeliverytype2 = 0;
	String goodsfactory = "";
	String strPlGoodsNmM = "";
	String strUrl = "";
	long lngShopprice = 0;
	long lngInstance_price = 0;
	int intVcode = 0; 
	String mobileUrl = "";
	int iPrice = 0;
	String strVersion = "";
	String strGoodscode = "";
	boolean bShopChk = false;
	int iModelno = 0;
	String  strCate = ""; 
	String strShopName ="";
	int iCoupon = 0;
	String strCoupon = "";
	String strType = "";
	int intShop_code = 0;
	int intPricecard = 0;
	String strShopType = "";
	
	if(pricelist_data!=null){

		strDeliveryinfo = pricelist_data.getDeliveryinfo();
		intDeliveryinfo2 = pricelist_data.getDeliveryinfo2();
		intDeliverytype2 = pricelist_data.getDeliverytype2();
		lngShopprice = pricelist_data.getPrice_long();
		szRedirect = pricelist_data.getUrl();
		mPrice = pricelist_data.getPrice_long()+"";
		lngInstance_price = pricelist_data.getInstance_price();
		goodsfactory = pricelist_data.getGoodsfactory();
		strPlGoodsNmM = pricelist_data.getGoodsnm();
		strGoodscode = pricelist_data.getGoodscode();
		strUrl = pricelist_data.getUrl();
		intVcode = pricelist_data.getShop_code();
		strPlGoodsNmM = pricelist_data.getGoodsnm();
		iModelno = pricelist_data.getModelno();
		strCate = pricelist_data.getCa_code(); 
		iCoupon = pricelist_data.getCoupon(); 
		intShop_code = pricelist_data.getShop_code();
		lngInstance_price = pricelist_data.getInstance_price();
		intPricecard = pricelist_data.getPrice_card();
		
		if(intVcode==4027 || intVcode==536 || intVcode==663){
			strType = "2";				//case2. 모바일 제휴& 할인 자동 적용
			//if (intVcode==55 && lngInstance_price == 0){
			//	 strType = "7";	
			//}
		}else if(intVcode==75  ){	
			strType = "6";	
			//strType = "4";				//cate4. 모바일 제휴 & 쿠폰 다운이 필요한 경우
		}else if(intVcode==57){	
			strType = "6";	
			//strType = "5";				//case5. 모바일 제휴 & 결제단에서 할인 적용이 필요한 경우
		}else if(intVcode==55 || intVcode==806 || intVcode==90  || intVcode==1878){	
			strType = "6";				//case6. 모바일 제휴 & 쿠폰 유무를 모를 때
		}else if(intVcode==5910 || intVcode==49 || intVcode==47 || intVcode==6547 || intVcode==6588  || intVcode==6603 ){	
			strType = "7";				//case7. 모바일 제휴 & CTU 적용 불가
		}else if(intVcode==6620){		// 특이. 갤러리아몰은 쿠폰필드 1이면 case6, 쿠폰필드0이면 case2
			if(iCoupon == 1){
				strType = "6";	
			}else{
				strType = "2";	 
			}
		}else if(intVcode==663){		// 특이. 롯데아이몰은 쿠폰필드 1이면 case5, 쿠폰필드0이면 case2
			if(iCoupon == 1){
				strType = "5";	
			}else{
				strType = "2";	 
			}
		}else if(intVcode==6665){		
			if(iCoupon == 1){
				strType = "6";	
			}else{
				strType = "2";	 
			}			
		}else{
			strType = "7";				//case7. 모바일 비제휴 ---> 일단 case2로...
		}
		if(strCate.length() >= 4){
			if(strCate.substring(0,4).equals("0304") && (intVcode==806 || intVcode==663 || intVcode==55 || intVcode==57) ){
				strType = "7";
			}
		}
		
		Shoplist_Data sdata = Shoplist_Proc.getData_One(intVcode);
		strShopName = sdata.getShop_name();
		strShopType = sdata.getShop_type();
		if(strPlGoodsNmM.indexOf("에누리") > -1 && strPlGoodsNmM.indexOf("추가할인") > -1){
			strCoupon = strPlGoodsNmM.substring(0, strPlGoodsNmM.indexOf("추가할인")+4);
			if( strCoupon.indexOf("추가할인") > strCoupon.indexOf("에누리")){
				strCoupon = strCoupon.substring(strCoupon.indexOf("에누리")+3, strCoupon.indexOf("추가할인"));
			}
		} 
		//디앤샵(1878) 쿠폰 관련 
		//if(strPlGoodsNmM.indexOf("에누리고객추가") > -1 && strPlGoodsNmM.indexOf("%할인") > -1 ){
		//	strCoupon = strPlGoodsNmM;
		//	strCoupon = strCoupon.substring(strCoupon.indexOf("에누리고객추가")+7, strCoupon.indexOf("%할인")+1);
		//}
		
		//SSG(6665) 쿠폰 관련 (모델명에 할인문구 있을경우 케이스 추가)
		if(intVcode == 6665 && strType.equals("6") && strPlGoodsNmM.indexOf("에누리") > -1 && strPlGoodsNmM.indexOf("더블할인쿠폰") > -1 ){
			strCoupon = strPlGoodsNmM;
			strCoupon = strCoupon.substring(strCoupon.indexOf("에누리")+3, strCoupon.indexOf("더블할인쿠폰")+1).replace(" ","");
			strType = "4";	
		}
		
		if(intVcode != 663 && (strType.equals("4") || strType.equals("5")) && strCoupon.trim().length() <  1 ){ 	//쿠폰이 없으면 case2에 포함
			strType = "2";	
		} 		 
		
		//2022.01.04 성인카테 변경 1640->163630
		//strCate.substring(0,4).equals("1640") -> strCate.substring(0,6).equals("163630")
		if(strCate.length() >= 6){
			if(strCate.substring(0,6).equals("163630") && (intVcode==536 || intVcode==4027 || intVcode==806 || intVcode==663) ){
				strType = "7";
			} 
		} 
		mobileUrl = toUrlCode(strUrl);
	}
	
//2014-08-26 변경	-- 2015-07-31 원별도 삭제,DB 그대로 넘겨줌
	/*
	if( intDeliverytype2==0 && intDeliveryinfo2==0 ){
		if(strDeliveryinfo.equals("")){
			strDeliveryinfo = "배송비 유무료";  
		}else{
			strDeliveryinfo = "배송비 : "+strDeliveryinfo; 
		}
	}else{  
		if((intDeliverytype2==1 && intDeliveryinfo2>0) || (intDeliverytype2==1 && intDeliveryinfo2==0 ) ||  strDeliveryinfo.indexOf("착불") > -1) { 
			if(intDeliveryinfo2==0){ 
				if( strDeliveryinfo.indexOf("착불") > -1 ){ 
					strDeliveryinfo = "착불";
				}else{
					strDeliveryinfo = "무료배송";
				}	  
			}else{
				strDeliveryinfo = toNumFormat(intDeliveryinfo2) +"원 별도";				
			}
		} else if(intDeliverytype2==1 && intDeliveryinfo2==0) {
				strDeliveryinfo = "무료배송";
		}
	}
	*/
	//pc-ctu 		: shopcode, url, minprice, pricecard, coupon, category, get_modelno, deliveryinfo, goodscode
	//mobile-ctu 	: shopcode, goodscode, instanceprice, category
%>
{
<%
	out.println("		\"shopcode\":"+ intShop_code +", ");
	out.println("		\"url\":\""+ strUrl +"\", ");
	out.println("		\"minprice\":"+ mPrice +", ");
	out.println("		\"pricecard\":"+ intPricecard +", ");
	out.println("		\"coupon\":"+ iCoupon +", ");
	out.println("		\"category\":\""+ toJS2(strCate) +"\", ");
	out.println("		\"modelno\":"+ iModelno +", ");
	out.println("		\"deliveryinfo\":\""+ toJS2(strDeliveryinfo) +"\", ");
	out.println("		\"goodscode\":\""+ toJS2(strGoodscode) +"\", ");
	out.println("		\"instanceprice\":"+ lngInstance_price +", ");
	out.println("		\"openShopCheck\":"+ blOpenmarket +", ");
	out.println("		\"shoptype\":"+ strShopType +" ");
	
%>
}
