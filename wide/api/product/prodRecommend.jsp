<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/lsv2016/include/IncAjaxHeader.jsp"%>
<%@ page import="org.json.JSONObject"%>
<%@ page import="org.json.JSONArray"%>
<%@ page import="com.enuri.util.common.JsonResponse"%>
<%@ page import="com.enuri.bean.lsv2016.Category_Set_Proc"%>
<%@ page import="com.enuri.bean.lsv2016.Category_Set_Data"%>
<%@ page import="com.enuri.bean.main.Goods_Brand_Proc"%>
<%@ page import="com.enuri.bean.main.Goods_Proc"%>
<%@ page import="com.enuri.bean.main.Goods_Data"%>
<%@ page import="com.enuri.bean.main.Save_Goods_Proc"%>
<%@ page import="com.enuri.bean.lsv2016.Recommend_Goods_Proc"%>
<%@ page import="com.enuri.bean.lsv2016.InfoAd_Proc"%>
<%@ page import="com.enuri.bean.lsv2016.Recommend_Additions_Proc"%>
<jsp:useBean id="Goods_Proc" class="com.enuri.bean.main.Goods_Proc" scope="page" />
<jsp:useBean id="Goods_Data" class="com.enuri.bean.main.Goods_Data" scope="page" />
<jsp:useBean id="Recommend_Goods_Proc" class="com.enuri.bean.lsv2016.Recommend_Goods_Proc" scope="page" />
<jsp:useBean id="Goods_Brand_Proc" class="com.enuri.bean.main.Goods_Brand_Proc" scope="page" />
<jsp:useBean id="category_set_proc" class="com.enuri.bean.lsv2016.Category_Set_Proc" scope="page" />
<jsp:useBean id="InfoAd_Proc" class="com.enuri.bean.lsv2016.InfoAd_Proc" scope="page" />
<jsp:useBean id="Recommend_Additions_Proc" class="com.enuri.bean.lsv2016.Recommend_Additions_Proc" scope="page" />
<%
if(!CvtStr.isNumeric(request.getParameter("modelno"))){
    return ;
}
boolean bAccessoryShowFlag = ChkNull.chkStr(request.getParameter("accessoryShowFlag")).equals("true");
int intRefernum = ChkNull.chkInt(request.getParameter("refernum"), 0);
int intReferModelno = ChkNull.chkInt(request.getParameter("refermodelno"), 0);
int intModelno = ChkNull.chkInt(request.getParameter("modelno"), 0);
int intRecomType = ChkNull.chkInt(request.getParameter("recomtype"), 1);
String strBrand = ChkNull.chkStr(request.getParameter("brand"), "");
String strCategory = ChkNull.chkStr(request.getParameter("cate"), "");
String strCategory6 = CutStr.cutStr(strCategory, 6);
String strUserId = cb.GetCookie("MEM_INFO","USER_ID");
String strKey = "";

//???????????? ??????
JSONObject rtnJsonObject = new JSONObject();
JsonResponse result = null;
String[] keyArr = {"consumables","sameSeries","buyTogether","sameBrand","diffBrand","sameCate"}; //key

//????????????
Save_Goods_Proc save_goods_proc = new Save_Goods_Proc();
Goods_Data[] goods_save_data = null;
if(strUserId != "") {
	goods_save_data = save_goods_proc.getSaveGoodList(strUserId,"MEMBER"); //???????????? (?????????)
}

strKey = keyArr[intRecomType-1];
Goods_Data[] recommend_goods_data = null;
JSONObject jsonObject = new JSONObject();
JSONArray recomgoodsList = new JSONArray();
JSONArray modelnos = new JSONArray();
String strModelnos = "";
int total = 0;

if(intRecomType==1){
    //?????????????????????1
    if(bAccessoryShowFlag && !CutStr.cutStr(strCategory,4).equals("0402")){
        recommend_goods_data = Recommend_Goods_Proc.RecommendGoods_List(intModelno, "popular desc", 0, 0 ,"", 0, strBrand, intRecomType, 1, 30);
    }else{
        recommend_goods_data = Recommend_Goods_Proc.RecommendGoods_List(intModelno, "popular desc", 0, 0 ,"", 0, strBrand, intRecomType, 1, 30);
    }
}else if(intRecomType==2){
    //?????????????????????2
    if(intRefernum > 1){
        recommend_goods_data = Recommend_Goods_Proc.RecommendGoods_List(intModelno, "popular desc", 0, 0, "", 0, strBrand, intRecomType, 1, 30);
    }
}else if(intRecomType==3){
    //????????????????????? 3 ?????? ?????? ??? ??????
    int relSetChk = Recommend_Goods_Proc.RecommendGoods_RelSetCheck(strCategory6);

    if(relSetChk==1 || relSetChk==3){
        recommend_goods_data = Recommend_Goods_Proc.RecommendGoods_List(intModelno, "", 0, 0, strCategory6, 0, strBrand, intRecomType, 1, 30);
    }
}else{
    //????????????????????? 4?????? ????????? ?????? ??????,5?????? ????????? ????????????,6?????? ???????????? ????????????
    recommend_goods_data = Recommend_Goods_Proc.RecommendGoods_List(intModelno, "", 0, 0, strCategory6, 0, strBrand, intRecomType, 1, 30);
}

if(recommend_goods_data != null && recommend_goods_data.length > 0){
    int intGoodsModelno = 0;
    int intGoodsBbsnm = 0;
    int intMallCnt = 0;
    long lnGoodsPrice = 0;
    float flGoodsBbsPointAvg = 0;
    String strGoodsModelnm = "";
    String strGoodsFactory = "";
    String strGoodsBrand = "";
    String strGoodsCdate = "";
    String strGoodsImageUrl = "";
    boolean bAdultChk = false;
    DecimalFormat df = new DecimalFormat("#.#");
    Category_Set_Data[] category_set_data = null;
    category_set_data = category_set_proc.getCategorySetList("");

    total = recommend_goods_data.length;

    //?????????, ????????????
    for(int a=0; a<recommend_goods_data.length; a++){
        modelnos.put(recommend_goods_data[a].getModelno());
    }

    strModelnos = modelnos.toString();
    strModelnos = strModelnos.replace("[","");
    strModelnos = strModelnos.replace("]","");

    JSONArray gpTitles = Recommend_Additions_Proc.getAdditionTitle(CutStr.cutStr(strCategory, 4), strModelnos, 6);
    HashMap<Integer,JSONObject> gpList = Recommend_Additions_Proc.getAdditionList2(CutStr.cutStr(strCategory, 4), strModelnos, modelnos.length());

    //???????????? ????????? set
    for(int i=0; i<recommend_goods_data.length; i++){
        JSONObject goodsData = new JSONObject();
        intGoodsModelno = recommend_goods_data[i].getModelno();
        strGoodsModelnm = recommend_goods_data[i].getModelnm();
        strGoodsFactory = recommend_goods_data[i].getFactory();
        strGoodsBrand = recommend_goods_data[i].getBrand();
        lnGoodsPrice = recommend_goods_data[i].getMinprice3();
        flGoodsBbsPointAvg = Float.parseFloat(df.format(recommend_goods_data[i].getBbs_point_avg()));
        intGoodsBbsnm = recommend_goods_data[i].getBbs_num();
        strGoodsCdate = recommend_goods_data[i].getC_date();
        intMallCnt = recommend_goods_data[i].getMallcnt();
        String exp_modelnm = strGoodsModelnm != null ? strGoodsModelnm : "";
        String exp_factory = strGoodsFactory != null ? strGoodsFactory : "";
        String exp_brand = strGoodsBrand != null ? strGoodsBrand : "";

        if(category_set_data != null){
            for(int x=0; x<category_set_data.length; x++){
                if(category_set_data[x].getMd_brand_flag().equals("0")) {
                    if(CutStr.cutStr(strCategory,4).equals(category_set_data[x].getCate())) exp_brand = "";
                }
                if(category_set_data[x].getMd_factory_flag().equals("0")){
                    if(CutStr.cutStr(strCategory,4).equals(category_set_data[x].getCate())) exp_factory = "";
                }
            }
        }

        //?????????=???????????? ????????? ?????????
        if(exp_factory.toLowerCase().equals(exp_brand.toLowerCase())){
            exp_brand = "";
        }
        if(exp_factory.equals("??????") || exp_factory.equals("[??????]") || exp_factory.equals("????????????") || exp_factory.equals("[????????????]")){
            exp_factory = "";
            strGoodsFactory = "";
        }
        if(exp_brand.equals("??????") || exp_brand.equals("[??????]") || exp_brand.equals("????????????") || exp_brand.equals("[????????????]")){
            exp_brand = "";
            strGoodsBrand = "";
        }

        //?????????=?????????=????????? ?????? ???????????? ??????
        if(exp_factory.toLowerCase().equals(strGoodsModelnm.toLowerCase()) && exp_brand.toLowerCase().equals(strGoodsModelnm.toLowerCase())){
            exp_factory = "";
            exp_brand = "";
        }

        //?????????/???????????? ?????? ??????????????? ?????? ?????? ?????? (??????????????? ?????? ??????_20160830)
        if(exp_factory.equals("") && exp_brand.equals("")){
            if(ControlUtil.compareValOR(new String[]{CutStr.cutStr(strCategory,4),"0304","0305"})){
                exp_factory = strGoodsFactory;
            }else if(ControlUtil.compareValOR(new String[]{CutStr.cutStr(strCategory,4),"0903","0912","0913","0919","0923","0937","1015","1001"})){
                exp_brand = strGoodsBrand;
            }else if(ControlUtil.compareValOR(new String[]{CutStr.cutStr(strCategory,2),"08","14"})){
                exp_brand = strGoodsBrand;
            }
        }

        /* ?????????, ????????? ??????*/
        String[] strModel_FBN = {exp_modelnm, exp_factory, exp_brand};
        String tmpModelNm_goodsinfo = strModel_FBN[1];

        if(!tmpModelNm_goodsinfo.equals("")) tmpModelNm_goodsinfo += " ";
        tmpModelNm_goodsinfo += strModel_FBN[2];
        if(!tmpModelNm_goodsinfo.equals("")) tmpModelNm_goodsinfo += " ";
        tmpModelNm_goodsinfo += strModel_FBN[0];

        strGoodsModelnm = tmpModelNm_goodsinfo;

        if(!CutStr.cutStr(strCategory,2).equals("14") && !CutStr.cutStr(strCategory,2).equals("93")){
            strGoodsModelnm = ReplaceStr.replace(strGoodsModelnm, "[", " [");
        }

        if(cb.GetCookie("MEM_INFO", "ADULT").equals("1")) bAdultChk = true;
        recommend_goods_data[i].setAdultChk(bAdultChk);

        strGoodsImageUrl = ImageUtil_lsv.getImageSrc(recommend_goods_data[i]);

        /* ????????? ??????????????? ?????? ?????? ?????? ????????? ?????? */
//  			InfoAd_Proc infoAdProc = new InfoAd_Proc();
//  			boolean sopnShowFlag = infoAdProc.getIsSponserGoods(strCategory, modelno, "2");

        //?????????,???????????? ?????? ?????? (2019.11.06)
        long cashMinPrc = recommend_goods_data[i].getCash_min_prc();
        String cashMinPrcYn =  recommend_goods_data[i].getCash_min_prc_yn();
        String ovsMinPrcYn =  recommend_goods_data[i].getOvs_min_prc_yn();

        //tlc ?????? ?????? (2019.12.12)
        long tlc_min_prc = recommend_goods_data[i].getTlc_min_prc();

        //?????? ??????
        JSONObject gpDetail = new JSONObject();
        if(gpList.containsKey(intGoodsModelno)) gpDetail = gpList.get(intGoodsModelno);

        //??? ??????
        boolean blZzim = false;
        if(goods_save_data!=null){
            for(int j=0;j<goods_save_data.length;j++){
                if(intGoodsModelno == goods_save_data[j].getModelno() ) blZzim = true;
            }
        }

        long lnPrice = 0;
        //????????? ?????? (#47152)
        if(cashMinPrcYn.equals("Y") && cashMinPrc > 0 && lnGoodsPrice==0 && intMallCnt > 0) {
            lnPrice = cashMinPrc;
        } else if(tlc_min_prc > 0 && lnGoodsPrice == 0) {
            lnPrice = tlc_min_prc;
        } else {
            lnPrice = lnGoodsPrice;
        }

        goodsData.put("modelno", intGoodsModelno);
        goodsData.put("modelnm", strGoodsModelnm);
        goodsData.put("strImageUrl", strGoodsImageUrl);
        goodsData.put("price", lnPrice);
        goodsData.put("c_date", strGoodsCdate);
//     		goodsData.put("sopnShowFlag", sopnShowFlag);
        goodsData.put("bbs_point_avg", flGoodsBbsPointAvg);
        goodsData.put("bbs_num", intGoodsBbsnm);
// 			goodsData.put("tlcMinPrc", tlc_min_prc);
        goodsData.put("gp_detail", gpDetail);
        goodsData.put("zzim", blZzim);

        recomgoodsList.put(goodsData);
    }

    jsonObject.put("recomgoods_list", recomgoodsList);
    jsonObject.put("gp_titles", gpTitles);
}
jsonObject.put("total", total);

result = new JsonResponse(true).setData(jsonObject).setTotal(total);

out.println(result);
%>