<%@ page contentType="text/html; charset=utf-8" %>
<%@page import="javax.servlet.http.Cookie"%>
<%@ include file="/lsv2016/include/IncAjaxHeader.jsp"%>
<%@ include file="/wide/include/IncSearch.jsp"%>
<%@ include file="/include/IncGroupTool_2010.jsp"%>
<%@ page import="com.enuri.bean.main.Goods_Proc"%>
<%@ page import="com.enuri.bean.main.Goods_Data"%>
<%@ page import="com.enuri.bean.lsv2016.Category_Set_Proc"%>
<%@ page import="com.enuri.bean.lsv2016.Category_Set_Data"%>
<%@ page import="com.enuri.bean.main.Pricelist_Proc"%>
<%@page import="com.enuri.bean.wide.Wide_List_Proc"%>
<%@page import="com.enuri.bean.lsv2016.Goods_Search_Lsv_Proc"%>
<%@ page import="com.enuri.bean.mobile.PDManager_Proc"%>
<%@ page import="com.enuri.bean.mobile.PDManager_PD_Data"%>
<%@ page import="com.enuri.bean.mobile.PDManager_T1_Data"%>
<%@page import="org.json.*"%>
<%
String relModelNo = ChkNull.chkStr(request.getParameter("relmodelno"), "") ; //연관상품 모델번호
String relModelNm = ChkNull.chkStr(request.getParameter("relmodelnm"), "") ;
int paramModelNo = ChkNull.chkInt(request.getParameter("modelno"), 0); //해당 상품
String strRelText = ChkNull.chkStr(request.getParameter("reltext"), ""); 
String strAppYN = ChkNull.chkStr(request.getParameter("appYN"), "N");
String strADYN = ChkNull.chkStr(request.getParameter("adProdYN"), "N");

try{
	DecimalFormat formatter = new DecimalFormat("###,###");
	JSONObject resultObj = new JSONObject();
	if (relModelNo.length() > 0 && paramModelNo > 0 && relModelNm.length() > 0) { //필수 파라미터 O
		
		String strUserId = "";
		if (strAppYN.equals("N")) {
			if(cb.GetCookie("MEM_INFO","USER_ID")!=null) {
				strUserId = cb.GetCookie("MEM_INFO", "USER_ID");
			}
		} else {
			PDManager_Proc pdmanager = new PDManager_Proc();
			PDManager_T1_Data t1Data = pdmanager.getT1(request);
			
			if (t1Data != null && t1Data.isData() && t1Data.isInFireDate()) {
				strUserId = t1Data.getStrT1_enuriid();
			}
		}
		
		Goods_Search_Lsv_Proc Goods_Search_Lsv_Proc = new Goods_Search_Lsv_Proc();
		Goods_Data[] goods_save_data = Goods_Search_Lsv_Proc.getSaveGoodList(strUserId);
		
		JSONArray jarray = new JSONArray();
		ImageUtil_lsv imageutil_lsv = new ImageUtil_lsv ();
		String totalModelNoArr [] = (paramModelNo + "," + relModelNo).split(","); // 해당상품모델번호 + 연관상품 모델번호들
		String totalModelNmArr [] =  ("temp" + "," + relModelNm).split(","); //temp + 연관상품 모델명들 - > totalModelNoArr랑 크기 맞춤
		
		for ( int i = 0; i < totalModelNoArr.length; i++ ){ 
			int intModelNo = Integer.parseInt(totalModelNoArr[i]);
			Goods_Proc Goods_Proc = new Goods_Proc();
			Goods_Data goods_data = Goods_Proc.Goods_Detailmulti_One(intModelNo, "Detailmulti");
			
			//goods_data X
			if(goods_data==null){
				resultObj.put("success", false);
				resultObj.put("returnMsg", "ProdData Null");
				resultObj.put("modelno", intModelNo);
				out.println(resultObj);
				return;
			}
			
			String strModelno = ""+goods_data.getModelno();
			String strImgUrl = imageutil_lsv.getVIPImageSrc(goods_data);
			long lnPrice = goods_data.getMinprice3();
			String openexpectflag = goods_data.getOpenexpectflag(); // 1일 때 출시예정
			String strExtraText = "";
			
			if (lnPrice == 0 && !openexpectflag.equals("1")) {
				strExtraText = "일시품절";
			} else if (lnPrice == 0 && openexpectflag.equals("1")) {
				strExtraText = "출시예정";
			}
			
			if (i == 0) { //해당상품
				JSONObject prodObj = new JSONObject();
				HashMap	cardNameHash = getCardNameHash();
				Pricelist_Proc Pricelist_Proc = new Pricelist_Proc();
				String[][] cardFreeAry = Pricelist_Proc.getPriceList_CardFree();
				
				Category_Set_Proc category_set_proc = new Category_Set_Proc();
				Category_Set_Data[] category_set_data = category_set_proc.getCategorySetList("");
				String strFactory = goods_data.getFactory();
				String strBrand = goods_data.getBrand();
				String strModelNm = goods_data.getModelnm();
				String strCate = goods_data.getCa_code();
				
				
				if(strModelNm.lastIndexOf("[")>0) {
					strModelNm = strModelNm.substring(0,strModelNm.lastIndexOf("["));
				}
				
				String[] strModel_FBN = getModel_FBN_2016(strCate, strModelNm, strFactory, strBrand, category_set_data);
				String strFormatModelnm = strModelNm;
				strFormatModelnm = strModel_FBN[1] +" "+  strModel_FBN[2] +" "+ strModel_FBN[0];
				
				prodObj.put("modelnm", strFormatModelnm);
				prodObj.put("modelno", strModelno);
				prodObj.put("price", formatter.format(lnPrice));
				prodObj.put("extraText",strExtraText);
				prodObj.put("imgUrl", strImgUrl);
				resultObj.put("prodData", prodObj);
			} else { //연관상품들
				JSONObject relProdObj = new JSONObject();
				Wide_List_Proc Wide_List_Proc = new Wide_List_Proc();
				String strModelNm = totalModelNmArr[i];
				
				if (strModelNm.length() > 20) {
					strModelNm = strModelNm.substring(0,20) + "...";
				}
				
				String strSpecText = goods_data.getSpec();
				strSpecText = strSpecText.replaceAll("</", "--brTagShow--"); 
				strSpecText = strSpecText.replaceAll("/", "&nbsp;&nbsp;/&nbsp;&nbsp;"); 
				strSpecText = strSpecText.replaceAll("--brTagShow--", "</");
				
				Set<Integer> zzimModelSet = new HashSet<Integer>();
				// 찜
				String strZzimYN = "N";
				if(goods_save_data!=null && goods_save_data.length>0) {
					for(int j=0; j<goods_save_data.length; j++) {
						int zzimModelno = goods_save_data[j].getModelno();
						if(zzimModelno>0) {
							zzimModelSet.add(zzimModelno);
						}
					}
				}
				if(zzimModelSet.contains(intModelNo)) {
					strZzimYN = "Y";
				} 
				
				relProdObj.put("modelno", strModelno);
				relProdObj.put("modelnm", strModelNm);
				relProdObj.put("specText", toJS3(strSpecText));
				relProdObj.put("price",formatter.format(lnPrice));
				relProdObj.put("extraText",strExtraText);
				relProdObj.put("imgUrl", strImgUrl);
				relProdObj.put("zzimYN", strZzimYN);
				jarray.put(relProdObj);
			}
		}
		resultObj.put("layerText", strRelText);
		resultObj.put("relProdList", jarray);
		resultObj.put("success", true);
	} else { //필수 파라미터 X
		resultObj.put("success", false);
		resultObj.put("returnMsg", "Invalid Parameter");
	}
	resultObj.put("adYN", strADYN);
	out.println(resultObj.toString());
}catch(Exception e){}
%>