<%@ page contentType="text/html; charset=utf-8" trimDirectiveWhitespaces="true" %>
<%@ page import="java.util.*"%>
<%@ page import="com.enuri.util.common.*"%>
<%@ page import="com.enuri.util.image.*"%>
<%@ page import="com.enuri.util.common.ConfigManager"%>
<%@ page import="com.enuri.util.common.ChkNull"%>
<%@page import="com.enuri.util.image.ImageUtil"%>
<%@ page import="com.enuri.util.common.ReplaceStr"%>
<%@ page import="com.enuri.util.common.JsonResponse"%>
<%@ page import="org.json.JSONObject"%>
<%@ page import="com.enuri.bean.main.Goods_Data"%>
<%@ page import="com.enuri.bean.main.Goods_Proc"%>
<jsp:useBean id="Goods_Proc" class="com.enuri.bean.main.Goods_Proc" scope="page" />
<%@ page import="com.enuri.bean.wide.Wide_Prod_Proc"%>
<%@ page import="com.enuri.bean.lsv2016.Category_Set_Proc"%>
<%@ page import="com.enuri.bean.lsv2016.Category_Set_Data"%>

<%
	if(!CvtStr.isNumeric(request.getParameter("modelno"))){
		return ;
	}
	//모델 번호
	int intModelno = ChkNull.chkInt(request.getParameter("modelno"), 0);

	JSONObject jSONObject = new JSONObject(new TreeMap());

	if(intModelno < 0){
		return;
	}

	Goods_Data goods_data = Goods_Proc.Goods_Detailmulti_One(intModelno, "Detailmulti");
	Wide_Prod_Proc wideProdProd = new Wide_Prod_Proc();
	String strVIPImageUrl = "";
	String strFactory = "";
	String strBrand = "";
	String strModelNm = "";
	String strCate = "";
	String strCate2 = "";
	String strCate4 = "";
	String strModelNmView = "";

	if(goods_data != null){
		strVIPImageUrl = ImageUtil_lsv.getVIPImageSrc(goods_data);
		strFactory = goods_data.getFactory();
		strBrand = goods_data.getBrand();
		strModelNm = goods_data.getModelnm();
		strCate =  goods_data.getCa_code();
		if(strCate.length() >=2) {
			strCate2 = strCate.substring(0, 2);
		}
		if(strCate.length() >=4) {
			strCate4 = strCate.substring(0, 4);
		}

		/* 모델명 규칙 _ start */

		//브랜드/제조사 규칙
	    if(strFactory.equals("불명") || strFactory.equals("[불명]") || strFactory.equals("[추가]") || strFactory.equals("[호환업체]") || strFactory.equals("호환업체")){
	        strFactory = "";
	    }
	    if(strBrand.equals("불명") || strBrand.equals("[불명]") || strBrand.equals("[추가]") || strBrand.equals("[호환업체]") || strBrand.equals("호환업체")){
	        strBrand = "";
	    }
	    //상품명 규칙
	    if(strModelNm.indexOf("[일반]")>-1) {
	        strModelNm = strModelNm.replace("[일반]","");
	    }

	    Category_Set_Data[] category_set_data = null;
	    Category_Set_Proc category_set_proc = new Category_Set_Proc();
	    category_set_data = category_set_proc.getCategorySetList("");
	    String exp_modelnm = strModelNm;
	    String exp_factory = strFactory;
	    String exp_brand = strBrand;

	    if(category_set_data != null){
	        for(int x=0; x<category_set_data.length; x++){
	            if(category_set_data[x].getMd_brand_flag().equals("0")) {
	                if(strCate4.equals(category_set_data[x].getCate())) exp_brand = "";
	            }
	            if(category_set_data[x].getMd_factory_flag().equals("0")){
	                if(strCate4.equals(category_set_data[x].getCate())) exp_factory = "";
	            }
	        }
	    }
	    //제조사=브랜드시 브랜드 비노출
	    if(exp_factory.toLowerCase().equals(exp_brand.toLowerCase())){
	        exp_brand = "";
	    }
	    //제조사=브랜드=모델명 일때 모델명만 노출
	    if(exp_factory.toLowerCase().equals(exp_modelnm.toLowerCase()) && exp_brand.toLowerCase().equals(exp_modelnm.toLowerCase())){
	        exp_factory = "";
	        exp_brand = "";
	    }
	    //제조사/브랜드가 모두 비노출되는 경우 선택 노출 (김원경대리 추가 요청_20160830)
	    if(exp_factory.equals("") && exp_brand.equals("")){
	        if(ControlUtil.compareValOR(new String[]{strCate4,"0304","0305"})){
	            exp_factory = strFactory;
	        }else if(ControlUtil.compareValOR(new String[]{strCate4,"0903","0912","0913","0919","0923","0937","1015","1001"})){
	            exp_brand = strBrand;
	        }else if(ControlUtil.compareValOR(new String[]{strCate2,"08","14"})){
	            exp_brand = strBrand;
	        }
	    }
	    //팩토리 + 브랜드 + 모델명
	    String[] strModel_FBN = {exp_factory.trim(),exp_brand.trim(),exp_modelnm};
	    strModelNmView = strModel_FBN[0] +" "+ strModel_FBN[1]+" "+strModel_FBN[2];
	    strModelNmView = strModelNmView.replaceAll("  "," ");

	    /* 모델명 규칙 _ end */
	}

    jSONObject.put("goodsName", strModelNmView);
	jSONObject.put("goodsImage", strVIPImageUrl);
	jSONObject.put("goodsVideo", wideProdProd.getVideoList(intModelno));
	jSONObject.put("goodsThumnail", wideProdProd.getThumnailList(intModelno));

    out.println(jSONObject.toString());
%>

