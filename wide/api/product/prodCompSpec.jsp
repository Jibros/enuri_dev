<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.enuri.util.common.ChkNull"%>
<%@page import="com.enuri.bean.lsv2016.Goods_Spec_Compare"%>
<%@page import="com.enuri.bean.lsv2016.Category_Set_Proc"%>
<%@page import="com.enuri.bean.lsv2016.Category_Set_Data"%>
<%@ include file="/include/IncGroupTool_2010.jsp"%>
<%

    /**
    * title :VIP 스펙비교
    * author : scboys
    * param :
        type   ==>  S : 소카테, B : 소카테+동일브랜드, D : 미카테
        brand  ==> type이 B 일때 필수
        modelno ==> 현재 모델번호 필수
    *
    *
    **/
    
	if(!CvtStr.isNumeric(request.getParameter("modelno"))){
		return ;
	}

    String strType = ChkNull.chkStr(request.getParameter("type"),"I");
    String strBrand = ChkNull.chkStr(request.getParameter("brand"),"");
    String strCate = ChkNull.chkStr(request.getParameter("cate"),"");
    int    intModelno = ChkNull.chkInt(request.getParameter("modelno"),0);

    Goods_Spec_Compare gsc = new Goods_Spec_Compare();
    JSONObject rtnJsonObject =  new JSONObject();
    if(intModelno==0){
        //오류
    }else{

        Category_Set_Data[] category_set_data = null;
        Category_Set_Proc category_set_proc = new Category_Set_Proc();
        category_set_data = category_set_proc.getCategorySetList("");

        JSONArray totalArrayList = new JSONArray();
        JSONArray simArrayList = new JSONArray();
        JSONArray newArrayList = new JSONArray();
        HashMap<Integer,JSONObject> goodsHashMap = new HashMap<Integer,JSONObject>();
        HashMap<Integer,HashMap<Integer,JSONArray>> specListMap = new HashMap<Integer,HashMap<Integer,JSONArray>>();
        JSONObject arrMinPriceObj = new JSONObject();;
        JSONObject goodsData = new JSONObject();
        JSONObject specModelData = new JSONObject();

        int intMinPrice = 0;
        int arrMinPriceModelNo = 0;
        int arrMinPrice = 0;

        int scate_cnt = 0;
        int brnd_cnt = 0;
        int dcate_cnt = 0;
        int most_model = 0;

        String strModelnos = Integer.toString(intModelno);
        boolean blBestFlag = true;
        String[] arrModelNos = null;
        boolean IsAdultFlag = false;
        boolean blAdultCate = false;
        
        String strCate2 = "";
        String strCate4 = "";
        String strCate6 = "";
        String strCate8 = "";

        JSONArray specTitleArrayList = new JSONArray();
        String ADULTFLAG = cb.GetCookie("MEM_INFO","ADULT");
        if(ADULTFLAG!=null) {
                // 성인인증 됨
                if(ADULTFLAG.equals("1")) IsAdultFlag = true;
        }
      
        goodsData = gsc.getSpecCompareThisGoods(intModelno);
        if(goodsData.length() > 0){
            strCate = goodsData.getString("ca_code");
            strBrand = goodsData.getString("brand");
            intMinPrice = goodsData.getInt("minprice3");
            specModelData = gsc.getSpecCompareModelNo(strType,intModelno,strCate,strBrand);
            specTitleArrayList = gsc.getSpecTitleList(strCate);
            if(specModelData.length() > 0){
                scate_cnt = (specModelData.has("scate_cnt")) ? specModelData.getInt("scate_cnt") : 0 ;
                brnd_cnt = (specModelData.has("brnd_cnt")) ? specModelData.getInt("brnd_cnt") : 0;
                dcate_cnt = (specModelData.has("dcate_cnt")) ? specModelData.getInt("dcate_cnt"): 0;
                most_model = (specModelData.has("most_modelno")) ? specModelData.getInt("most_modelno") : 0;
                strModelnos = strModelnos + "," + specModelData.getString("modelnos");
            }

            arrModelNos= strModelnos.split(",");
            specListMap = gsc.getSpecList(strCate ,strModelnos);
            goodsHashMap = gsc.getSpecCompareGoodsData(strModelnos);
            int modelnoCnt = 0;
            
            if(strCate.length() > 1){
                strCate2 = strCate.substring(0,2);
            }
            if(strCate.length() > 3){
                strCate4 = strCate.substring(0,4);
            }
            if(strCate.length() > 5){
                strCate6 = strCate.substring(0,6);
            }
            if(strCate.length() > 7){
                strCate8 = strCate.substring(0,8);
            }

            //2022.01.04 성인카테 변경 1640->163630 
            if(strCate6.equals("163630") || strCate6.equals("931004") || strCate6.equals("051523") || strCate6.equals("051513")){
                blAdultCate = true;
            }
            for(int i = 0;i<arrModelNos.length;i++){
                JSONObject tmpObj = null;
                int tmpModelno = 0;
                int intBagdeCnt = 0;

                tmpModelno = Integer.parseInt(arrModelNos[i]);
                tmpObj = goodsHashMap.get(tmpModelno);
                if(tmpObj !=null){
                    int tmpMinPrice = tmpObj.getInt("minprice3");
                    String tmpCondiname = tmpObj.getString("condiname");
                    String tmpModelnm = tmpObj.getString("modelnm");
                    String tmpFactory = tmpObj.getString("factory");
                    String tmpBrand = tmpObj.getString("brand");
                    int tmpExtCondiFlag = tmpObj.getInt("ext_condi_flag");
                    if(tmpModelno != intModelno && tmpExtCondiFlag==1){
                        continue;
                    }else if(modelnoCnt > 8){
                        break;
                    }else{
                        modelnoCnt++;
                    }
                    String strModelnm = replaceModelNmSpecialChar(strCate, tmpModelnm);
                    String tmpModelNm_goodsinfo = strModelnm;

                    boolean blNewModelFlag = false;
                    boolean blSimModelFlag = false;
                    if(tmpFactory.equals("불명") || tmpFactory.equals("[불명]") || tmpFactory.equals("[추가]") || tmpFactory.equals("[호환업체]") || tmpFactory.equals("호환업체")){
                        tmpFactory = "";
                    }
                    if(tmpBrand.equals("불명") || tmpBrand.equals("[불명]") || tmpBrand.equals("[추가]") || tmpBrand.equals("[호환업체]") || tmpBrand.equals("호환업체")){
                        tmpBrand = "";
                    }

                    // 브랜드, 제조사 추가
                    String[] strModel_FBN = getModel_FBN_2016(strCate, strModelnm, tmpFactory, tmpBrand, category_set_data);
                    tmpModelNm_goodsinfo = strModel_FBN[1];
                    if(!tmpModelNm_goodsinfo.equals("")){
                        tmpModelNm_goodsinfo += " ";
                    }
                    tmpModelNm_goodsinfo += strModel_FBN[2];
                    if(!tmpModelNm_goodsinfo.equals("")){
                        tmpModelNm_goodsinfo += " ";
                    }
                    tmpModelNm_goodsinfo += strModel_FBN[0];

                    tmpModelnm = tmpModelNm_goodsinfo;

                    tmpObj.put("modelnm",tmpModelnm);
                    tmpObj.put("specList",specListMap.get(tmpModelno));

                    tmpObj.put("new_flag","N");
                    tmpObj.put("best_flag","N");
                    tmpObj.put("most_flag","N");

                    //최근 6개월 등록 상품 Searching
                    if(tmpObj.getInt("m_diff") < 7 ){
                    tmpObj.put("new_flag","Y");
                    intBagdeCnt += 2 ;
                    }
                    if(most_model==tmpModelno){
                        tmpObj.put("most_flag","Y");
                        intBagdeCnt += 4;
                    }

                    tmpObj.put("badge_cnt", intBagdeCnt);
                    if(blAdultCate && !IsAdultFlag) {
                        String strImageUrl =ConfigManager.IMG_ENURI_COM+"/images/home/thumb_adult_300.jpg";
                        tmpObj.put("p_imgurl", strImageUrl);
                        tmpObj.put("origin_img", strImageUrl);
                        tmpObj.put("p_imgurl2", strImageUrl);
                    }

                    if(tmpModelno != intModelno){
                        if(specTitleArrayList.length() > 0){
                            for(int j=0;j<specTitleArrayList.length();j++){
                                if(j>1) break;
                                JSONArray tmpArray = (specListMap.get(intModelno) == null) ? null : specListMap.get(intModelno).get(specTitleArrayList.getJSONObject(j).getInt("gp_no"));
                                JSONArray tmpArray2 = (specListMap.get(tmpModelno)==null) ? null : specListMap.get(tmpModelno).get(specTitleArrayList.getJSONObject(j).getInt("gp_no"));

                                if(tmpArray2 !=null && tmpArray != null){
                                    if(tmpArray.length()==tmpArray2.length()){
                                        for(int k=0;k<tmpArray.length();k++){
                                            blBestFlag = false;
                                            for(int p=0;p<tmpArray2.length();p++){
                                                if(tmpArray.getJSONObject(k).getInt("spec_no")  == tmpArray2.getJSONObject(p).getInt("spec_no") && Float.parseFloat(tmpObj.getString("bbs_point_avg")) >= 4){
                                                    blBestFlag = true;
                                                    break;
                                                }
                                            }
                                            if(!blBestFlag){
                                                break;
                                            }
                                        }
                                    }else{
                                        blBestFlag = false;
                                    }
                                }else{
                                    blBestFlag = false;
                                }
                                if(!blBestFlag) break;
                            }
                        }else{
                            blBestFlag = false;
                        }
                        if(blBestFlag){
                            if(arrMinPrice > tmpMinPrice && tmpMinPrice > 0) {
                                arrMinPrice = tmpMinPrice;
                                arrMinPriceModelNo = tmpModelno;
                                arrMinPriceObj = tmpObj;
                            }
                        }

                        //비슷한 가격대 Seaching
                        if(intMinPrice*0.85 < tmpMinPrice && intMinPrice*1.15 > tmpMinPrice){
                            simArrayList.put(tmpObj);
                        }
                        if(tmpObj.getInt("m_diff") < 7 ){
                            newArrayList.put(tmpObj);
                        }

                    }else{
                        arrMinPrice = tmpMinPrice;
                        arrMinPriceModelNo = tmpModelno;
                        arrMinPriceObj = tmpObj;
                    }

                    totalArrayList.put(tmpObj);
                }
            }
            if(arrMinPriceModelNo != intModelno){
                if(!arrMinPriceObj.isNull("badge_cnt")){
                    int thisBadgeCnt = arrMinPriceObj.getInt("badge_cnt") + 3;
                    arrMinPriceObj.put("badge_cnt",thisBadgeCnt);
                    arrMinPriceObj.put("best_flag","Y");
                }
            }

        }
        //모델및 속성 조회 위에서 나온 모델번호로 filter 적용 후 listing
        //+ 뱃지 check
        rtnJsonObject.put("specListTitle",specTitleArrayList);
        rtnJsonObject.put("totalArray",totalArrayList);
        rtnJsonObject.put("simArray",simArrayList);
        rtnJsonObject.put("newArray",newArrayList);
        rtnJsonObject.put("scate_cnt",scate_cnt);
        rtnJsonObject.put("brnd_cnt",brnd_cnt);
        rtnJsonObject.put("dcate_cnt",dcate_cnt);
    }

    out.println(rtnJsonObject.toString());



%>