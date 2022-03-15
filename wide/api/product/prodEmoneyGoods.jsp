<%@ page contentType="text/html; charset=utf-8" %>\
<%@ include file="/lsv2016/include/IncAjaxHeader.jsp"%>\
<%@ page import="com.enuri.bean.main.Goods_Proc"%>\
<%@ page import="com.enuri.bean.main.Goods_Data"%>\
<%@ page import="com.enuri.bean.main.Pricelist_Data"%>\
<%@ page import="com.enuri.bean.lsv2016.Pricelist_Lsv_Proc"%>\
<%@ page import="com.enuri.bean.main.Pricelist_Proc"%>\
<jsp:useBean id="Pricelist_Proc" class="com.enuri.bean.main.Pricelist_Proc" scope="page" />\
<jsp:useBean id="Pricelist_Lsv_Proc" class="com.enuri.bean.lsv2016.Pricelist_Lsv_Proc" scope="page" />\
<%@ page import="com.enuri.bean.main.Goods_Ajax_Proc"%>\
<jsp:useBean id="Goods_Ajax_Proc" class="com.enuri.bean.main.Goods_Ajax_Proc" scope="page" />\
<%@ include file="/include/IncGroupTool_2010.jsp"%>

<%
	int modelno = ChkNull.chkInt(request.getParameter("modelno"), 0);
	String deliveryFlag = ConfigManager.RequestStr(request, "deliveryFlag", "false");
		
	if(modelno<=0) {
		return;
	}
%>
{
<%
	long modelminpirce = 0;
	long modelinstance_price = 0;

	Goods_Proc goods_proc = new Goods_Proc();
	Goods_Data goods_data = goods_proc.Goods_Detailmulti_One(modelno, "Detailmulti");
	
	// 가격 리스트를 저장하는 배열
	Pricelist_Data[] aszAllPlist = null;
	Pricelist_Data[] aszPlist = null;
	
	if(goods_data != null){
		String szFactory = goods_data.getFactory();
		String szCategory = goods_data.getCa_code();
		long minprice = goods_data.getMinprice();
		long minprice3 = goods_data.getMinprice3();
		int mallcnt = goods_data.getMallcnt();
		int mallcnt3 = goods_data.getMallcnt3();
		
		// 가격 가져오기 (미정 및 없음 포함)
		long price = 0;
		String reloadPricelist = "";
		String strListViewType = "";
		String deliveryinfo = "";
		int deliveryinfo2 = 0;
		int deliverytype2 = 0;
		String goodsnm = "";
		int minShop_code = 0;
		String minShop_name = "";
		long instance_price = 0;
		String imgurl = "";
		long pl_no = 0;
		
		boolean bShopListAll = false;
		boolean bDeliveryFlag = false;

		if (deliveryFlag.equals("true")) {
			bDeliveryFlag = true;
		} else {
			bDeliveryFlag = false;
		}
		
		//이머니 적립가능몰 유무
		boolean bemoney = true;
		
		//모바일 전용
		boolean onlyMobile = false;
		
		//쇼핑몰로고 표시유무
		boolean shoplogo = false;
		
		//타이틀케이스
		int titlecase = 1;
		
		//통합 최저가
		aszAllPlist = Pricelist_Proc.Pricelist_DetailMulti_List3(reloadPricelist, modelno, szFactory, szCategory, strListViewType, bShopListAll, minprice, false);
		if(aszAllPlist!=null){
			int intj=0;
			for(intj=0; intj < aszAllPlist.length; intj++){
				if(aszAllPlist[intj].getInstance_price()>0 && !aszAllPlist[intj].getOption_flag2().equals("1")){
					modelminpirce = aszAllPlist[intj].getPrice();
					modelinstance_price = aszAllPlist[intj].getInstance_price();
					break;
				}
			}
			if(modelinstance_price > 0 && modelminpirce > modelinstance_price) modelminpirce = modelinstance_price;
		}
		
		//이머니적립가능몰 4027,536,5910,55,806,75,6641 
		aszPlist = Pricelist_Lsv_Proc.Pricelist_DetailMulti_List(reloadPricelist, modelno, szFactory, szCategory, strListViewType, bShopListAll, minprice, false, bemoney);
		int inti = 0;
		if(aszPlist!=null){
			for(inti = 0; inti<aszPlist.length; inti++){
				if(!aszPlist[inti].getOption_flag2().equals("1") ){ 
					pl_no = aszPlist[inti].getPl_no();
					imgurl = aszPlist[inti].getImgurl();
					goodsnm = aszPlist[inti].getGoodsnm();
					minShop_code = aszPlist[inti].getShop_code();
					minShop_name = aszPlist[inti].getShop_name();
					price = aszPlist[inti].getPrice();
					//이머니 적립가능쇼핑몰만이 아닌 통합최저가로 반영 20161116 한지민대리요청
					instance_price = minprice3;

					deliveryinfo = aszPlist[inti].getDeliveryinfo();
					deliveryinfo2 = aszPlist[inti].getDeliveryinfo2(); 
					deliverytype2 = aszPlist[inti].getDeliverytype2(); 
					break; //옵션필수 상품제외
				}
			}
			
			//모바일전용
			if(mallcnt <= 0 && mallcnt3 > 0) {
				onlyMobile = true;
				price = instance_price;
			}
			if(instance_price < modelminpirce) {
				titlecase = 2;
			}else if(instance_price == modelminpirce) {
				titlecase = 1;
				if(minprice > instance_price) titlecase = 2; 
			}else{
				titlecase = 3;
				shoplogo = true;
			}
			
			//배송비포함가격
			if(bDeliveryFlag && (deliverytype2==1 || deliveryinfo.indexOf("조건부무료")>-1)) price = price + deliveryinfo2;
			
			out.println("			\"pl_no\" : \""+pl_no+"\", ");
			out.println("			\"imgurl\" : \""+imgurl+"\", ");
			out.println("			\"goodsnm\" : \""+goodsnm+"\", ");
			out.println("			\"minShop_code\" : \""+minShop_code+"\", ");
			out.println("			\"minShop_name\" : \""+minShop_name+"\", ");
			out.println("			\"instance_price\" : \""+instance_price+"\", ");
			out.println("			\"onlyMobile\" : \""+onlyMobile+"\", ");
			out.println("			\"titlecase\" : \""+titlecase+"\", ");
			out.println("			\"shoplogo\" : \""+shoplogo+"\" ");
		}
	}

%>
}