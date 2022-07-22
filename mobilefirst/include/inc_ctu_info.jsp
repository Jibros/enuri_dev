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
	long iPlno = ChkNull.chkLong(request.getParameter("pl_no"));
	int buycnt = ChkNull.chkInt(request.getParameter("buycnt"),1);
	int iRank = ChkNull.chkInt(request.getParameter("rank"),0);
	String strApp = ChkNull.chkStr(request.getParameter("app"));
	String szType = ChkNull.chkStr(request.getParameter("type"),""); //에누리 상품 인지 웹상품인지 구분 : 웹상품 = "ex"
	Long lngPrice = ChkNull.chkLong(request.getParameter("instanceprice")); 	//ctu 타고 넘어온 가격..
	String strMinsort = ChkNull.chkStr(request.getParameter("minsort"),""); //minsort = 1 이면 배송비 포함 최저가순이므로, 배송비를 instance_price 에 포함시켜보여줌.
	boolean blMinsort = false;
	
	if(strMinsort.equals("1"))	blMinsort = true;
	
	String strPrice = toNumFormat(lngprice);
	

	Pricelist_Proc pricelist_proc = new Pricelist_Proc();
	Pricelist_Data pricelist_data = pricelist_proc.getData_Delivery(iPlno);

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

		if(intVcode==4027 || intVcode==536 || intVcode==663){
			strType = "2";				//case2. 모바일 제휴& 할인 자동 적용
			//if (intVcode==55 && intInstance_price == 0){
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
			strCoupon = strCoupon.substring(strCoupon.indexOf("에누리")+3, strCoupon.indexOf("% 더블할인쿠폰")+1).replace(" ","");
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
	
//2014-08-26 변경
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
				if(blMinsort){
					strDeliveryinfo = toNumFormat(intDeliveryinfo2) +"원 포함";
					lngShopprice = lngShopprice + intDeliveryinfo2;
					strPrice = toNumFormat(lngprice + intDeliveryinfo2);
				}else{
					strDeliveryinfo = toNumFormat(intDeliveryinfo2) +"원 별도";				
				}
			}
		} else if(intDeliverytype2==1 && intDeliveryinfo2==0) {
				strDeliveryinfo = "무료배송";
		}
	}
	/*
	String strPrice = "";
	
	if(strType.equals("1") || strType.equals("7")){
	}else{
		if(strType.equals("5")){
			strPrice = toNumFormat(intInstance_price);
		}else{
			if(strType.equals("4")){
				strPrice = toNumFormat(lngShopprice);
			}else{
				if(intVcode==6620 || intVcode==90 || intVcode==57 || intVcode==75 ){
					strPrice = toNumFormat(lngShopprice);
				}else{
					strPrice = toNumFormat(intInstance_price);
				}
			}
		} 
	}
	*/			
%>
<div class="layerPopInner" id="ctu_inner_layer">
	<div class="layerPopCont">
		<div class="headerPop">
			<h1><%=strShopName%></h1>
			<span style="position:absolute;top:7px;left:40%;"><img src="<%=ConfigManager.IMG_ENURI_COM %>/images/mobilenew/icon/icon_truck.png" width="20" border="0" /> <%=strDeliveryinfo %></span>
			<button class="btnClose">구매 알림 창 닫기</button>
		</div>
		<div class="half-contents">
			<div class="half-con join-pc">
				<h2>- PC 접속 시 -</h2>
				<div class="point-price">
					<em class="point-txt">에누리 PC쿠폰가</em>
					<strong class="price"><%=toNumFormat(lngShopprice)%> <span>원</span></strong>
				</div>
				<button class="btn" onclick="zzim_set(<%=iModelno%>);">찜하기</button>
			<% if(lngShopprice < lngprice){ %>	
				<p class="caution">‘찜하기 ’ 후 PC웹사이트에서 구매하시면 가장 저렴합니다.</p>
			<% }else{ %>
				<p style="height:10px;"></p>
			<% } %>
			</div>
			<div class="half-con join-mobile">
				<h2>- 모바일 접속 시 -</h2>
				<div class="point-price">
					<strong class="price"><%=strPrice %> <span>원</span></strong>
				</div>
				<div style="position:relative;">
				<button class="btn" onclick="goShop_ctu('','<%=iPlno%>','<%=mobileUrl%>','mobile','<%=strCate%>','<%=iModelno%>','<%=intVcode%>');">몰로 이동</button>
				</div>
			</div>
		</div>
	</div>
</div>
