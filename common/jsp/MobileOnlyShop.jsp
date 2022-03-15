<%@page import="com.enuri.bean.main.Goods_Data"%>
<%@page import="com.enuri.util.http.CookieBean"%>
<%@page import="com.enuri.bean.main.Save_Goods_Proc"%>
<%@page import="com.enuri.bean.main.brandplacement.DBDataTable"%>
<%@page import="com.enuri.bean.main.brandplacement.DBWrap"%>
<%@page import="java.util.Arrays"%>
<%!
public class MobileOnlyShop{
	HttpServletRequest _request = null;
	int[] _shop = null;
	DBDataTable _modelShop = null;
	Goods_Data[] goods_save_data = null;
	DBDataTable _price_save_data = null;
  /*nova Lee 0816*/    
	boolean bMobileOnlyShop = false;

	private void setShop(){
		this._shop = new int[]{7870};
		// for test
		// 5910 11번가 , 4027 옥션, 536 지마켓
		// this._shop = new int[]{5910, 4027, 536};
		//this._shop = new int[]{4027};
	}

	public MobileOnlyShop(){
		this.setShop();
	}

	public MobileOnlyShop(HttpServletRequest request){
		this._request = request;
		this.setShop();

	}
	/*nova Lee 0816*/
	public MobileOnlyShop(HttpServletRequest request,int intShopcode){
		this._request = request;
		this.setShop();
    	this.bMobileOnlyShop = isMobileOnlyShop(intShopcode);
	}
	
	public void setRequest(HttpServletRequest request){
		this._request = request;
	}
	// 이 모델들에 해당하는 최저가 shop_code 목록을 _modelShop에 넣음.
	public void setMobileMinShopModel(String modelnoStr){
		/*
		String query = "";
		query +="  ";
		query +=" SELECT ";
		query +=" T1.MODELNO, T1.SHOP_CODE ";
		query +=" FROM ";
		query +=" TBL_PRICELIST T1 ";
		query +=" INNER JOIN ";
		query +=" ( ";
		query +="   SELECT ";
		query +="   MODELNO ";
		query +="   ,MIN(PRICE) PRICE ";
		query +="   FROM TBL_PRICELIST ";
		query +="   WHERE ";
		query +="   MODELNO IN ";
		query +="   ( ";
		query +="   " + modelnoStr + " ";
		query +="   ) ";
		query +="   GROUP BY ";
		query +="   MODELNO ";
		query +=" ) T2 ";
		query +=" ON T1.MODELNO = T2.MODELNO AND T1.PRICE = T2.PRICE ";
		query +=" ORDER BY ";
		query +=" T1.MODELNO, T1.SHOP_CODE ";
		*/
		
		String query = "";
		query +=" " + "\n";
		query +=" SELECT" + "\n";
		query +=" T2.MODELNO, T2.SHOP_CODE" + "\n";
		query +=" FROM" + "\n";
		query +=" TBL_GOODS T1" + "\n";
		query +=" INNER JOIN" + "\n";
		query +=" TBL_PRICELIST T2" + "\n";
		query +=" ON T1.MODELNO =  T2.MODELNO  AND T1.MINPRICE3 = T2.PRICE" + "\n";
		query +=" AND T1.MODELNO IN (" + "\n";
		query +="   " + modelnoStr + " ";
		query +=" )" + "\n";
		query +=" WHERE" + "\n";
		query +=" T1.MODELNO > 0" + "\n";
		query +=" AND T2.MODELNO > 0" + "\n";
		query +=" " + "\n";

		this._modelShop = new DBWrap("main2004").setQuery(query).selectAllTry();
	}

	// 모바일 샵인지 여부 체크
	public boolean isMobileOnlyShop(int shopcode){
		for (int i=0;i<this._shop.length;i++){
			if (this._shop[i] == shopcode){
				return true;
			}
		}

		return false;
	}

	// 모델번호로 최저가 샵이 있는지 체크.
	public boolean isMinpriceShopModel(String modelno){
		for (int i=0;i<this._modelShop.count();i++){
			String modelShopNo = this._modelShop.parse(i, "MODELNO", "");
			int shopCode = this._modelShop.parse(i, "SHOP_CODE", 0);

			if (modelShopNo.equals(modelno) && isMobileOnlyShop(shopCode)){
				return true;
			}
		}

		return false;
	}

	// 사용안함. isMobileOnlyShopByPlno로 대체
	/*
	public boolean isMobileOnlyShopByGoodscode(String goodscode){
		if (this.bMobileOnlyShop){
  			DBDataTable dt = new DBWrap("main2004").simplesSelect("TBL_PRICELIST", "GOODSCODE", goodscode);
  			for (int i=0;i<dt.count();i++){
  				if (isMobileOnlyShop(dt.parse(i, "SHOP_CODE", 0))){
  					return true;
  				}
  			}  	
  			return false;
  		}else{
  	  		return false;
  		}
	}
	*/
	public boolean isMobileOnlyShopByPlno(long pl_no){
		if (this.bMobileOnlyShop){
  			DBDataTable dt = new DBWrap("main2004").simplesSelect("TBL_PRICELIST", "pl_no", pl_no);
  			return dt.count() > 0 && isMobileOnlyShop( dt.parse(0, "SHOP_CODE", 0));  			
  		}else{
  	  		return false;
  		}
	}

	// 일반상품의 동일모델 중 최저가인지 체크.
	// 안쓰나?
	/*
	public boolean isMinPriceShopGoods(String goodscode){

		String query = "";
		query +="  ";
		query +="  ";
		query +=" SELECT * ";
		query +=" FROM ";
		query +=" TBL_PRICELIST ";
		query +=" WHERE ";
		query +=" GOODSCODE = ? ";
		query +=" AND ";
		query +="   ( ";
		query +="     PRICE = ( ";
		query +="     SELECT MIN(PRICE) FROM TBL_PRICELIST ";
		query +="     WHERE MODELNO = ";
		query +="     (SELECT MAX(MODELNO) FROM TBL_PRICELIST WHERE GOODSCODE = ?) ";
		query +="     AND SRVFLAG IN ('0','R','L') AND NVL(ESSTOCKFLAG, '0') = '0' AND (STATUS < '3' OR STATUS > '5') AND NVL(OPTION_FLAG2, '0') = '0' ";
		query +="     AND DELIVERYINFO2 = 0 ";
		query +="     ) ";
		query +="     OR ";
		query +="     PRICE + DELIVERYINFO2 = ( ";
		query +="     SELECT MIN(PRICE + DELIVERYINFO2) FROM TBL_PRICELIST ";
		query +="     WHERE MODELNO = ";
		query +="     (SELECT MAX(MODELNO) FROM TBL_PRICELIST WHERE GOODSCODE = ?) ";
		query +="     AND SRVFLAG IN ('0','R','L') AND NVL(ESSTOCKFLAG, '0') = '0' AND (STATUS < '3' OR STATUS > '5') AND NVL(OPTION_FLAG2, '0') = '0' ";
		query +="     AND DELIVERYINFO2 > 0 ";
		query +="     ) ";
		query +=" ) ";

		DBDataTable dt = new DBWrap("main2004").setQuery(query).addParameter(goodscode).addParameter(goodscode).addParameter(goodscode) .selectAllTry();
		return dt.count() > 0 && isMobileOnlyShop(dt.parse(0, "SHOP_CODE", 0));
	}
	*/

	// 메서드 형태 수정.
	public String getGoodsName(long pl_no){
	  if (this.bMobileOnlyShop){	
  		DBDataTable dt = new DBWrap("main2004").simplesSelect("TBL_PRICELIST", "PL_NO", pl_no);
  		return dt.count() > 0 ? dt.parse(0, "GOODSNM", "") : "";
	  	}else{
	    	return "";
	  	}
	}

	// LP, SRP에서 모바일 아이콘 띄우는 태그 반환
	protected String getIconTag_LP_SRP(String jsOnclick){
		return "<span class=\"ico_cellphone\"><em onmouseover=\"this.className='on';\" onmouseout=\"this.className='';\" onclick=\"" + jsOnclick + "event.cancelBubble = true; if(event.stopPropagation){event.stopPropagation();};return false;\" title=\"모바일 최저가 상품 팝업\">모바일</em></span>";
	}

	protected String getIconTag_LP_SRP_blank(){
		return "<span class=\"ico_cellphone\"></span>";
	}

	// LP, SRP에서 모바일 아이콘 띄우는 태그 반환 - 모델있음	
	public String getIconTag_LP_SRP_ModelLayer(String modelNo){
		String jsOnclick = "top.showMobileOnlyModelLayer('" + modelNo + "');";		
		jsOnclick += "top.addmobileOnlyLayerClass('mobileOnlyLayerLeft');";
		jsOnclick += "event.cancelBubble = true; if(event.stopPropagation){event.stopPropagation();};return false;";

		return this.isMinpriceShopModel(modelNo) ? getIconTag_LP_SRP(jsOnclick): getIconTag_LP_SRP_blank();
	}

	// LP,SRP에서 모바일 자바스크립트 반환 - 일반상품
	// 완료?
	protected String getIconTag_LP_SRP_Goods_Onclick(long pl_no, int shopcode){		
		 String goodsname = getGoodsName(pl_no);
		 
		 String jsOnclick = "top.showMobileOnlyGoodsLayer('" +  String.valueOf(pl_no) + "', '" + goodsname + "');";
		 jsOnclick += "top.addmobileOnlyLayerClass('mobileOnlyLayerLeft');";
		 jsOnclick += "event.cancelBubble = true; if(event.stopPropagation){event.stopPropagation();};return false;";
		 jsOnclick += "return false;";

		 return jsOnclick;
	}

	// LP, SRP에서 모바일 아이콘 띄우는 태그 반환 - 일반상품
	// 완료.
	public String getIconTag_LP_SRP_GoodsLayer(long pl_no, int shopcode){
		 String jsOnclick = getIconTag_LP_SRP_Goods_Onclick(pl_no, shopcode);
		 return this.isMobileOnlyShop(shopcode) ? getIconTag_LP_SRP(jsOnclick): getIconTag_LP_SRP_blank();
	}

	// LP, SRP에서 가격이나 다른 거 눌렀을 때 처리. - 일반상품
	// 완료
	public String getIconTag_LP_SRP_Goods_Click(long pl_no, int shopcode){
		String jsOnclick = getIconTag_LP_SRP_Goods_Onclick(pl_no, shopcode);
		return this.isMobileOnlyShop(shopcode) ? jsOnclick : "";
	}

	// VIP에서 모바일 자바스크립트 반환
	// 완료.
	protected String getIconTag_VIPJsOnclick(String modelNo){		
		String jsOnclick = "top.showMobileOnlyModelLayer('" + modelNo + "');";
		jsOnclick += "event.cancelBubble = true; if(event.stopPropagation){event.stopPropagation();};"; // 이벤트 버블링 캔슬
		jsOnclick += "return false;";

		return jsOnclick;
	}

	// VIP에서 모바일 아이콘 띄우는 태그 반환
	// 완료.
	public String getIconTag_VIP(String modelNo, long pl_no){
		String jsOnclick = getIconTag_VIPJsOnclick(modelNo);
		return this.isMobileOnlyShopByPlno(pl_no) ? "<span class=\"ico_cellphone_vip\" onclick=\""+ jsOnclick + "\"></span>" : "";
	}

	// VIP에서 가격이나 다른 거 눌렀을 때 처리.
	// 완료
	public String getIconTag_VIP_Click(String modelNo, long pl_no){
		String jsOnclick = getIconTag_VIPJsOnclick(modelNo);
		return this.isMobileOnlyShopByPlno(pl_no) ? jsOnclick : "";
	}

	// 요약보기에서 모바일 자바스크립트 반환
	// 완료.
	protected String getIconTag_toolbarJsOnclick(String modelNo){		
		String jsOnclick = "top.showMobileOnlyModelLayer('" + modelNo + "');";
		jsOnclick += "top.addmobileOnlyLayerClass('mobileOnlyLayerLeft');";
		jsOnclick += "if(document.referrer.indexOf('Comparemulti.jsp') > -1) {top.mobileOnlyRemoveZzim();};"; // 비교창에서는 찜 버튼 없음
		jsOnclick += "event.cancelBubble = true; if(event.stopPropagation){event.stopPropagation();};return false;";

		return jsOnclick;
	}

	// 요약보기에서 모바일 아이콘 띄우는 태그 반환
	// 완료.
	public String getIconTag_toolbar(String modelNo, long pl_no){
		String jsOnclick = getIconTag_toolbarJsOnclick(modelNo);
		return this.isMobileOnlyShopByPlno(pl_no) ? "<span class=\"ico_cellphone_vip\" style='float:right;' onclick=\"" + jsOnclick + "\"></span>" : "";
	}

	// 요약보기에서 가격이나 다른 거 눌렀을 때 처리.
	// 완료.
	public String getIconTag_toolbar_Click(String modelNo, long pl_no){
		String jsOnclick = getIconTag_toolbarJsOnclick(modelNo);
		return this.isMobileOnlyShopByPlno(pl_no) ? jsOnclick : "";
	}
}
%>