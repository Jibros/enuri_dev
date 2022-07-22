<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/lsv2016/include/IncAjaxHeader.jsp"%>
<%@ page import="com.enuri.bean.main.Goods_Proc"%>
<%@ page import="com.enuri.bean.main.Goods_Data"%>
<jsp:useBean id="Goods_Proc" class="com.enuri.bean.main.Goods_Proc" scope="page" />
<%@ page import="com.enuri.bean.main.Pricelist_Data"%>
<%@ page import="com.enuri.bean.main.Pricelist_Proc"%>
<jsp:useBean id="Pricelist_Proc" class="com.enuri.bean.main.Pricelist_Proc" scope="page" />
<%@ page import="com.enuri.bean.main.Goods_Ecatal_Data"%>
<%@ page import="com.enuri.bean.main.Goods_Ecatal_Proc"%>
<jsp:useBean id="Goods_Ecatal_Proc" class="com.enuri.bean.main.Goods_Ecatal_Proc" scope="page" />
<%@ page import="com.enuri.bean.main.Goods_Add_Data"%>
<%@ page import="com.enuri.bean.main.Goods_Add_Proc"%>
<jsp:useBean id="Goods_Add_Proc" class="com.enuri.bean.main.Goods_Add_Proc" scope="page" />
<%@ page import="com.enuri.bean.main.Goods_Detail_Data"%>
<%@ page import="com.enuri.bean.main.Goods_Detail_Proc"%>
<jsp:useBean id="Goods_Detail_Proc" class="com.enuri.bean.main.Goods_Detail_Proc" scope="page" />
<%@ page import="com.enuri.bean.knowbox.Know_termdic_title_Proc"%>
<%@ page import="com.enuri.bean.knowbox.Know_termdic_title_Data"%>
<jsp:useBean id="Know_termdic_title_Proc" class="com.enuri.bean.knowbox.Know_termdic_title_Proc" scope="page" />
<%@ page import="com.enuri.bean.main.Goods_Reference_Data"%>
<%@ page import="com.enuri.bean.main.Goods_Reference_Proc"%>
<jsp:useBean id="Goods_Reference_Proc" class="com.enuri.bean.main.Goods_Reference_Proc" scope="page" />
<%@ page import="com.enuri.bean.lsv2016.Goods_MallDesc_Proc"%>
<jsp:useBean id="Goods_MallDesc_Proc" class="com.enuri.bean.lsv2016.Goods_MallDesc_Proc" scope="page" />
<%@page import="com.enuri.bean.lsv2016.Goods_Attribute_Proc"%>
<%@page import="com.enuri.bean.lsv2016.Goods_Attribute_Data"%>
<jsp:useBean id="Goods_Attribute_Proc" class="com.enuri.bean.lsv2016.Goods_Attribute_Proc" scope="page" />
<%@page import="com.enuri.bean.lsv2016.Vip_Ecatal_Proc"%>
<%@page import="com.enuri.bean.lsv2016.Vip_Ecatal_Data"%>
<jsp:useBean id="Vip_Ecatal_Proc" class="com.enuri.bean.lsv2016.Vip_Ecatal_Proc" scope="page" />
<%@ page import="com.enuri.bean.lsv2016.KnowboxContent_Proc"%>
<jsp:useBean id="KnowboxContent_Proc" class="com.enuri.bean.lsv2016.KnowboxContent_Proc" scope="page" />
<%@ page import="com.enuri.bean.wide.Wide_Prod_Proc"%>
<%@ page import="com.enuri.bean.kcInfo.KcInfo_Proc"%>
<%@ page import="com.enuri.bean.kcInfo.KcInfo_Data"%>
<%@page import="org.json.*"%>
<%@ include file="/include/IncGroupTool_2010.jsp"%>
<%
if(!CvtStr.isNumeric(request.getParameter("modelno"))){
	return ;
}
//deviceType=1 : PC
//deviceType=2 : 모바일
int nModelNo = ChkNull.chkInt(request.getParameter("modelno"));
//procType=0 : all
//procType=1 : 외부 카탈로그 정보
//procType=2 : 쇼핑몰 크롤링 정보
//procType=3 : 에누리 정보
String procType = ChkNull.chkStr(request.getParameter("procType"), "0");

// 일반 시스템 변수들
String IMG_ENURI_COM = ConfigManager.IMG_ENURI_COM;
String PHOTO_ENURI_COM = ConfigManager.PHOTO_ENURI_COM;
String STORAGE_ENURI_COM = ConfigManager.STORAGE_ENURI_COM;

// dev인지 운영 인지 확인
String strUrl = ChkNull.chkStr(request.getRequestURL().toString(), "");
String strManTag = "";

if (strUrl.indexOf("http://dev.enuri.com/") > -1) {
	strManTag = "_man";
}

//try{

	JSONObject jSONData = new JSONObject();
	JSONArray jsonArray = new JSONArray();

	jSONData.put("ecatal_out_yn", "N");		//외부 카탈로그 존재 여부
	jSONData.put("mall_desc_yn", "N");		//쇼핑몰 크롤링 상세정보 존재 여부
	jSONData.put("enuri_desc_yn", "N");		//에누리 상세정보 존재여부(에누리카탈로그/요약설명/큰이미지/상세설명)
	jSONData.put("enuri_knwocom_guide_yn", "N"); // 구매가이드

	Wide_Prod_Proc wideProdProc = new Wide_Prod_Proc();

	String smodelnos = Goods_Proc.getData_Group_Modelnos(nModelNo);
	Goods_Data goods_data_bigimginfo = Goods_Proc.Goods_BigImgInfo_One(nModelNo);

	Goods_Data goods_data = Goods_Proc.Goods_Detailmulti_One(nModelNo, "Detailmulti");

	if(goods_data==null){
		out.println(jSONData);
		return;
	}

	String strBigImageUrl = "";
	String szModelNm = goods_data.getModelnm();
	String szSpec = goods_data.getSpec();
	String szGdFunc = goods_data.getFunc();
	String szKeyword2 = goods_data.getKeyword2();
	String strConstrain = goods_data.getConstrain();
	String strP_imgurl2 = goods_data.getP_imgurl2();
	String szCategory = goods_data.getCa_code();
	String strRsiflag = goods_data.getRsiflag().trim();
	String szRefshop = goods_data.getRefshop();
	String szFactory = goods_data.getFactory();
	String szBrand = goods_data.getBrand();

	String fImgChk = goods_data.getImgchk().trim();
	int nShopCnt = goods_data.getMallcnt();
	int nRefid = goods_data.getRefid();
	String ManualLink = goods_data.getManual_link();
	String Linkservicefalg = goods_data.getLinkserviceflag();
	String szCondiNm = goods_data.getCondiname();
	int nModelNoGroup = goods_data.getModelno_group();
	szModelNm = replaceModelNmSpecialChar(szCategory, szModelNm);

	String strCategoryIcon = "";
	String szGsSize = "";
	String szGsSize_1 = "";
	String szGsSize_2 = "";
	String strFuncImg = "";//휴대폰 아이콘 묶음(이통사, dmb유무등등 ) ex)1,2,3,4
	String strFuncImgArray[] = new String[20];//아이콘 묶음 배열


	String strCate6 = (szCategory.length() > 5) ? szCategory.substring(0,6) : "";

	jsonArray = new JSONArray();
	jsonArray = KnowboxContent_Proc.getPCVipList(nModelNo,strCate6);

	jSONData.put("enuri_knowcom_guide", jsonArray);
	if(jsonArray.length() > 0){
		jSONData.put("enuri_knwocom_guide_yn", "Y");
	}

	long nPlNo = 0;
	String strShopName = "";
	JSONArray caution_info_All_data =  wideProdProc.getCautionInfoView(true, szCategory, szModelNm, szFactory, szBrand, nModelNo+"","4");
	//VIP 설명 상단 주의사항
	String caution_nos = "";
	if(caution_info_All_data.length()> 0){
		JSONObject tmpObject = new JSONObject();
		for(int x=0;x<caution_info_All_data.length();x++){
			if(x>0) caution_nos+=",";
			caution_nos += caution_info_All_data.getJSONObject(x).getInt("seq_no");
		}
		tmpObject = caution_info_All_data.getJSONObject(0);
		tmpObject.put("imgmap_list",wideProdProc.getImgMap(tmpObject.getInt("seq_no")));
		tmpObject.put("content_list",wideProdProc.getCaution_Info_Content_List(true, caution_nos));
		jSONData.put("enuri_caution",tmpObject);
	}
	//System.out.println("getKcIfno_ajax.jsp] strCate : " + strCate + "strModelno : " + strModelno);
	
	KcInfo_Proc kcInfoProc = new KcInfo_Proc();
	jSONData.put("enuri_kc_info",kcInfoProc.getKcInfoUseYnJson(szCategory, nModelNo));

	//모델 사이즈 정보
	if(goods_data_bigimginfo!=null){
		szGsSize = goods_data_bigimginfo.getG_size();
		strFuncImg = goods_data_bigimginfo.getFunc_img();//휴대폰 아이콘
	}
	if(!szGsSize.equals("")){
		szGsSize = ReplaceStr.replace(szGsSize,"\r\n","<BR>");
		if(szGsSize.indexOf("detail_text02_0716.gif")>-1){
			szGsSize_1 = szGsSize.substring(0,szGsSize.indexOf("detail_text02_0716.gif"));
			szGsSize_2 = szGsSize.substring(szGsSize.indexOf("detail_text02_0716.gif"),szGsSize.length());


			szGsSize = szGsSize_1 + szGsSize_2 ;
		}else{
		}
		szGsSize = szGsSize.replaceAll("<img src='http://img.enuri.gscdn.com/images/blank.gif' width='1' height='3px'>\r\n<br><img src='http://img.enuri.gscdn.com/images/blank.gif' border=0 height=10><br>","<img src='http://img.enuri.info/images/blank.gif' width='1' height='3px'>\n");

		if(szGsSize == null || szGsSize.length() < 5){
			szGsSize = "";
			szGsSize = szGsSize.replaceAll(" ", "&nbsp;");
		}
		szGsSize = ReplaceStr.replace(szGsSize,"\"","&quot;");

		if(procType.equals("0") || procType.equals("3")){
			jSONData.put("enuri_size", szGsSize);
		}
		jSONData.put("enuri_desc_yn", "Y");
	}
	
	//인증정보 및 알레르기
	Goods_Attribute_Data[] goods_attribute_certi_data = null;
	Goods_Attribute_Data[] goods_attribute_allergy_data = null;
	String strIconNo = "";
	if(CutStr.cutStr(szCategory,4).equals("1502") || CutStr.cutStr(szCategory,4).equals("1508") || CutStr.cutStr(szCategory,4).equals("1005")) {
		goods_attribute_certi_data = Goods_Attribute_Proc.getGoodsAttributeList(nModelNo, 1); //인증정보
		goods_attribute_allergy_data = Goods_Attribute_Proc.getGoodsAttributeList(nModelNo, 2); //알레르기
		
		jsonArray = new JSONArray();
		if(goods_attribute_certi_data!=null && goods_attribute_certi_data.length>0){
			for(int ci=0;ci<goods_attribute_certi_data.length;ci++){
				if(strIconNo.length()>0) strIconNo +=",";
				strIconNo += goods_attribute_certi_data[ci].getIcon_no();
				JSONObject json_list = new JSONObject();
				json_list.put("attribute_id", goods_attribute_certi_data[ci].getAttribute_id());
				json_list.put("attribute_element_id", goods_attribute_certi_data[ci].getAttribute_element_id());
				json_list.put("iconno", goods_attribute_certi_data[ci].getIcon_no());
				json_list.put("attribute_element", goods_attribute_certi_data[ci].getAttribute_element());
				json_list.put("ref_kb_no", goods_attribute_certi_data[ci].getRef_kb_no());
				
				jsonArray.put(json_list);
			}
		}
		jSONData.put("goods_attribute_certi", jsonArray);
		
		jsonArray = new JSONArray();
		if(goods_attribute_allergy_data!=null && goods_attribute_allergy_data.length>0){
			for(int ai=0;ai<goods_attribute_allergy_data.length;ai++){
				if(strIconNo.length()>0) strIconNo +=",";
				strIconNo += goods_attribute_allergy_data[ai].getIcon_no();
				
				JSONObject json_list = new JSONObject();
				json_list.put("attribute_id", goods_attribute_allergy_data[ai].getAttribute_id());
				json_list.put("attribute_element_id", goods_attribute_allergy_data[ai].getAttribute_element_id());
				json_list.put("iconno", goods_attribute_allergy_data[ai].getIcon_no());
				json_list.put("attribute_element", goods_attribute_allergy_data[ai].getAttribute_element());
				json_list.put("ref_kb_no", goods_attribute_allergy_data[ai].getRef_kb_no());
				
				jsonArray.put(json_list);
			}
		}
		jSONData.put("goods_attribute_allergy", jsonArray);
	}
	
	if(!strFuncImg.equals("")){
		strFuncImgArray = strFuncImg.split(",");

		jsonArray = new JSONArray();
		for(int tempImg_i=0;tempImg_i < strFuncImgArray.length; tempImg_i++){
		    JSONObject json_list = new JSONObject();
			if((goods_attribute_certi_data!=null && goods_attribute_certi_data.length>0) || (goods_attribute_allergy_data!=null && goods_attribute_allergy_data.length>0)){
				if(!(strIconNo.indexOf(strFuncImgArray[tempImg_i].trim())>-1)){
					json_list.put("iconno", strFuncImgArray[tempImg_i].trim());
				}
			}else{
				 json_list.put("iconno", strFuncImgArray[tempImg_i].trim());
			}

		    jsonArray.put(json_list);
		}
		if(procType.equals("0") || procType.equals("3")){
			jSONData.put("enuri_func_icon", jsonArray);
		}
		jSONData.put("enuri_desc_yn", "Y");
	}

	if(!szGsSize.equals("") && (CutStr.cutStr(szCategory,2).equals("12") || CutStr.cutStr(szCategory,2).equals("10") || CutStr.cutStr(szCategory,2).equals("16") || CutStr.cutStr(szCategory,2).equals("09")) && szCategory.trim().length() == 8 ){
		strCategoryIcon = Category_Proc.getCategoryIcon(szCategory);
		if(strCategoryIcon.trim().equals("1")){
			if(procType.equals("0") || procType.equals("3")){
				jSONData.put("enuri_cateicon", IMG_ENURI_COM+"/images/view/blueprint/category/"+szCategory+".gif");
			}
			jSONData.put("enuri_desc_yn", "Y");
		}
	}

	if(fImgChk.equals("1") || fImgChk.equals("2") || fImgChk.equals("6") || fImgChk.equals("7")){
		//큰이미지 있음
		strBigImageUrl = PHOTO_ENURI_COM + "/data/images/service/big/"+ImageUtil.ImgFolder(nModelNo)+"/"+nModelNo+".jpg";
	}else{ //3,9,4,5,0,8,S
		//쇼핑몰 이미지로
		String strShopInfo[] = new String[2];
		strShopInfo = Pricelist_Proc.getMinPriceImageUrl(nModelNo);
		strBigImageUrl = ReplaceStr.replace(strShopInfo[0],"\"","&quot;");
		strShopName =  ReplaceStr.replace(strShopInfo[1],"\"","&quot;");
		if (ChkNull.chkNumber(strShopInfo[4])){
			nPlNo =  Long.parseLong(strShopInfo[4]);
		}
		if(!strBigImageUrl.equals("")){
			if(strBigImageUrl.trim().equals("BIGIMAGEISNULL")){
				strBigImageUrl = "";
			}
			if(fImgChk.equals("3") || fImgChk.equals("4") || fImgChk.equals("8") || fImgChk.equals("9") || fImgChk.equals("S") || fImgChk.equals("G")){
				if((ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,2),"04","07"}))){
					strBigImageUrl = "";
				}
			}
			if(((fImgChk.equals("9") || fImgChk.equals("4")) && nShopCnt==0) || fImgChk.equals("5")) { //웹이미지도 없음, 작업중, (이미지코드=5)인 경우, 비노출 처리 20161128
				strBigImageUrl = "";
			}
			if(!strBigImageUrl.equals("")){
				if(procType.equals("0") || procType.equals("3")){
					jSONData.put("bigimage_webshopnm", strShopName);
					jSONData.put("bigimage_webplno", nPlNo);
				}
				jSONData.put("enuri_desc_yn", "Y");
			}
		}
	}

	//성인용품 19금 이미지 처리
	String adultImageFlag = "N";
	//2022.01.04 성인카테 변경 1640->163630 
	if(nModelNo>0) {
		if((szCategory.substring(0,6).equals("163630") || szCategory.substring(0,6).equals("931004") || szCategory.substring(0,6).equals("051523") || szCategory.substring(0,6).equals("051513") ) && !cb.GetCookie("MEM_INFO", "ADULT").equals("1")) { //성인용품+미성년or인증안됨
			adultImageFlag = "Y";
		} 
	}
	if(adultImageFlag.equals("Y")) {
		strBigImageUrl = ConfigManager.IMG_ENURI_COM + "/images/home/thumb_adult_300.jpg";
		if(procType.equals("0") || procType.equals("3")){
			jSONData.put("enuri_under19_yn", adultImageFlag);
		}
	}
	// 유사상품
	if(strConstrain.equals("5") && !strP_imgurl2.equals("")){
		strBigImageUrl = strP_imgurl2;
		if (strBigImageUrl.indexOf("gmarket.co.kr") >= 0){
		     strBigImageUrl = ReplaceStr.replace(strBigImageUrl,"/large_img/","/large_jpgimg/");
		}
	}
	if(procType.equals("0") || procType.equals("3")){
		jSONData.put("bigimage", strBigImageUrl);
	}
	jSONData.put("fImgChk", fImgChk);
	if(!strBigImageUrl.equals("")){
		jSONData.put("enuri_desc_yn", "Y");
	}

	// PC 견적 파라미터 새로 내려 줌.
	//업체 카탈로그 이미지 제휴사: A, PC견적: B -  minjae
	Vip_Ecatal_Data vedPc = Vip_Ecatal_Proc.getViewItem(nModelNo, "B", strManTag);
	
	if (vedPc != null) {
		String viewDcd = vedPc.getView_dcd();		// 0: 미노출, 1: PC견적, 2 : 에누리 이미지
		String imgUrl = vedPc.getImg_url();

		if ("1".equals(viewDcd)) {
			jSONData.put("enuripc_view_yn", "Y");
			jSONData.put("enuripc_img_url", imgUrl);
		} else {
			jSONData.put("enuripc_view_yn", "");
			jSONData.put("enuripc_img_url", "");
		}
	}
	
	//에누리 카탈로그
	int intEcatal_modelno = Goods_Ecatal_Proc.getModelnoCatal(nModelNo, smodelnos);	// 더이상 사용 안하는 함수 같음 15년 06월 03일이 마지막 insert 임
	//에누리 카탈로그 추가 동영상/비교표이미지
	String strEcatal_Movie = ""; //동영상
	String strEcatal_CompareImg = ""; //비교표이미지
	String strEcatal_CompareModelnos = ""; //비교표링크 모델번호들
	String strEcatal_CompareModelLink = "";
	String existsFunc = "N";
	Goods_Ecatal_Data[] ecatal_data = null;
	if(intEcatal_modelno>0){
		if(procType.equals("0") || procType.equals("3")){
			JSONObject jSONData_ecatal_enuri = new JSONObject();

			//동영상/비교표이미지
			ecatal_data = Goods_Ecatal_Proc.getFileList(intEcatal_modelno);
			if(ecatal_data!=null && ecatal_data.length>0){
				for(int i=0; i<ecatal_data.length; i++){
					if(strEcatal_Movie.equals("") && ecatal_data[i].getFile_kind().equals("0")){
						strEcatal_Movie = ecatal_data[i].getFile_name();
					}else if(strEcatal_CompareImg.equals("") && ecatal_data[i].getFile_kind().equals("1")){
						strEcatal_CompareImg = ecatal_data[i].getFile_name();
						strEcatal_CompareModelnos = ecatal_data[i].getMemo();
					}
				}
			}
			if(!strEcatal_CompareModelnos.equals("")){
				String[] arrCompareModelnos = strEcatal_CompareModelnos.split(",");
				for(int i=0; i<arrCompareModelnos.length && existsFunc.equals("N"); i++){
					Goods_Data compare_goods = Goods_Proc.Goods_One(ChkNull.chkInt(arrCompareModelnos[i]));
					if(compare_goods!=null){
						if(!compare_goods.getFunc().equals("")){
							existsFunc = "Y";
						}
					}
				}
			}

			jSONData_ecatal_enuri.put("movie", strEcatal_Movie);
			jSONData_ecatal_enuri.put("compare_img", strEcatal_CompareImg);
			jSONData_ecatal_enuri.put("compare_modelnos", strEcatal_CompareModelnos);
			jSONData_ecatal_enuri.put("compare_func_yn", existsFunc);
			//jSONData.put("ecatal_enuri_info", jSONData_ecatal_enuri);
		}
		jSONData.put("enuri_desc_yn", "Y");
	}

	//업체 카탈로그 이미지 제휴사: A, PC견적: B -  minjae
	Vip_Ecatal_Data ved = Vip_Ecatal_Proc.getViewItem2(nModelNo, "A", strManTag);
	
	if(ved != null){
		jSONData.put("ecatal_out_yn", "Y");
		
		jSONData.put("ecatal_out_src", ved.getImg_url().split(","));
		jSONData.put("ecatal_out_from", ved.getTupcmp_nm());
	}
	
	/* // 업체 카탈로그 관리자 신규 성성에 따른 table 및 class 변경 됨 : 2019-02-21
	Goods_Add_Data[] add_ecatal_list = Goods_Add_Proc.getAddList(nModelNo, "3");
	if(add_ecatal_list!=null && add_ecatal_list.length>0){
		jSONData.put("ecatal_out_yn", "Y");
		if(procType.equals("0") || procType.equals("1")){
			jSONData.put("ecatal_out_src", toJS2(add_ecatal_list[0].getVideo_url()));
			jSONData.put("ecatal_out_from", add_ecatal_list[0].getVideo_source());
		}
	}
	 */
	
	//업체 카탈로그 동영상
	if(procType.equals("0") || procType.equals("3")){
		Goods_Add_Data[] add_movie_list = null;
		//if(ControlUtil.compareValOR(new String[]{fImgChk,"1","2","6","7"}) || add_ecatal_list!=null){
			if(ControlUtil.compareValOR(new String[]{fImgChk,"1","2","6","7"}) || ved != null){
			add_movie_list = Goods_Add_Proc.getAddList(nModelNo, "2");
			if(add_movie_list!=null && add_movie_list.length>0){
				jsonArray = new JSONArray();
				for(int i=0; i<add_movie_list.length; i++){
				    JSONObject json_list = new JSONObject();

				    json_list.put("title", add_movie_list[i].getVideo_title());
				    json_list.put("src", add_movie_list[i].getVideo_url());
				    json_list.put("from", add_movie_list[i].getVideo_source());

				    jsonArray.put(json_list);

				}
				jSONData.put("enuri_out_movie",jsonArray);
			}
		}
	}

	//요약설명 표 형태
	Goods_Detail_Data[] spec_list = null;
	spec_list = Goods_Detail_Proc.getSpecList(nModelNo, szCategory);

	String strTitle = "";
	String strContent = "";
	String strCenncnt = "";
	String strGroupnm = "";
	int intAttribute_id = 0; //속성id
	int intAttribute_el_id = 0; //속성원id
	int intAttribute_kbno = 0; //속성-용어사전
	int intAttribute_el_kbno = 0; //속성원-용어사전

	if(spec_list != null && spec_list.length > 0){
		//jSONData.put("enuri_desc_yn", "Y");
		if(procType.equals("0") || procType.equals("3")){
			// 데이터 정리
			int lastTitleId = -1; // 제목이 있는 마지막 번호
			for(int i=0;i<spec_list.length; i++) {
				strTitle = spec_list[i].getTitle();
				strContent = spec_list[i].getContent();
				strCenncnt = spec_list[i].getCellcnt()+"";
				strGroupnm = spec_list[i].getGroupnm();

				if(strTitle.equals("-")) {
					
				} else {
					lastTitleId = i;
				}
			}
			jsonArray = new JSONArray();
			for(int i=0;i<spec_list.length; i++) {
				strTitle = spec_list[i].getTitle();
				strContent = spec_list[i].getContent();
				strCenncnt = spec_list[i].getCellcnt()+"";
				strGroupnm = spec_list[i].getGroupnm();
				intAttribute_id = spec_list[i].getAttribute_id();
				intAttribute_el_id = spec_list[i].getAttribute_element_id();
				intAttribute_kbno = spec_list[i].getAttribute_kbno();
				intAttribute_el_kbno = spec_list[i].getAttribute_element_kbno();

				if(strContent == null) strContent = "";

				//if(spec_list[i].getTitle().equals("-")) continue;

				strTitle = strTitle.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
				strContent = strContent.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
				strGroupnm = strGroupnm.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");

			    JSONObject json_list = new JSONObject();

				if(spec_list[i].getTitle().equals("-")){
					json_list.put("specTitle", "");
				}else{
					json_list.put("specTitle", strTitle);
				}
				json_list.put("specContent", strContent);
				json_list.put("specCellcnt", strCenncnt);

				if(spec_list[i].getGroupnm().equals("-") ){
					json_list.put("specGroupname", "");
				}else{
					json_list.put("specGroupname", strGroupnm);
				}
				json_list.put("att_id", intAttribute_id);
				json_list.put("att_el_id", intAttribute_el_id);
				json_list.put("att_kbno", intAttribute_kbno);
				json_list.put("att_el_kbno", intAttribute_el_kbno);

			    jsonArray.put(json_list);
			}
			jSONData.put("enuri_spec_table", jsonArray);
		}
	}

	if(procType.equals("0") || procType.equals("3")){
		//요약설명 텍스트 형태(구버전)
		szSpec = szSpec.replaceAll("</", "--brTagShow--");
		szSpec = szSpec.replaceAll("/", "&nbsp;&nbsp;/&nbsp;&nbsp;");
		szSpec = szSpec.replaceAll("--brTagShow--", "</");

		jSONData.put("enuri_spec_text", toJS3(szSpec));
		jSONData.put("enuri_func_scrap", "N"); //퍼가기 가능여부

		//상세설명
		szGdFunc = ReplaceStr.replace(szGdFunc, "color=red", "color=#BD0F0E");
		szGdFunc = ReplaceStr.replace(szGdFunc, "color='red'", "color=#BD0F0E");
		szGdFunc = ReplaceStr.replace(szGdFunc, "color=\"red\"", "color=#BD0F0E");

		// 상품설명이 카피문구만 있을 경우 보여주지 않음
		if(szGdFunc.indexOf("▶")>-1 && szGdFunc.length()<610 && szGdFunc.indexOf("\r\n\r\n")<0) {
			szGdFunc = "";
		}
		// 상품설명없이 추가설명만 있는경우
		if(szGdFunc.indexOf("<추가 설명>")>0 && szGdFunc.substring(0, szGdFunc.indexOf("<추가 설명>")).indexOf("^")<0 && szGdFunc.substring(0, szGdFunc.indexOf("<추가 설명>")).indexOf("※")<0){
			if(szGdFunc.indexOf("<주의사항") > -1) {

			}else{
				szGdFunc = szGdFunc.substring(szGdFunc.indexOf("<추가 설명>"));
			}
		}
		int whileLoopBreak = 0;
		String strFunc = szGdFunc;
		String strFuncAdd = "";

		if(strFunc.indexOf("<추가 설명>")>-1) {
			strFunc = szGdFunc.substring(0,szGdFunc.indexOf("<추가 설명>"));
			if(strFunc.length()-2==strFunc.lastIndexOf("\r\n")){ //마지막 엔터 제거
				strFunc = strFunc.substring(0, strFunc.length()-2);
			}
			strFuncAdd = szGdFunc.substring(szGdFunc.indexOf("<추가 설명>"),szGdFunc.length());
		} else {
			strFunc = szGdFunc;
		}
		strFunc = ReplaceStr.replace(strFunc,"<img src=http://img.enuri.info/images/detail/ielogo.gif border=0>","");
		// 너비
		int maxWidth = 850;
		// 패턴사용을 위한 변수 선언
		java.util.regex.Pattern p1 = null;
		java.util.regex.Matcher m1 = null;

		if(strFunc.length()>0) { //상품설명+용어사전, 상품설명

			if(strFunc.indexOf("<주의사항")>-1) {
				p1 = java.util.regex.Pattern.compile("<주의사항.*?>\r\n");
				m1 = p1.matcher(strFunc);
				whileLoopBreak = 0;
				while(m1.find()) {
					String tempStr = m1.group();

					strFunc = ReplaceStr.replace(strFunc, m1.group(), "");

					if(whileLoopBreak++>20) break;
				}
				p1 = java.util.regex.Pattern.compile("<주의사항.*?>");
				m1 = p1.matcher(strFunc);
				whileLoopBreak = 0;
				while(m1.find()) {
					String tempStr = m1.group();

					strFunc = ReplaceStr.replace(strFunc, m1.group(), "");

					if(whileLoopBreak++>20) break;
				}
			}

			String tempStrFunc = strFunc;
			int strFuncTitleIdx = tempStrFunc.indexOf("^");
			String strFuncTitle = "";
			// 타이틀 뽑아오기
			strFuncTitle = szKeyword2;
			if(tempStrFunc.length()>0 && szKeyword2.length()>0) {
				strFunc = ReplaceStr.replace(tempStrFunc, szKeyword2, "");
			}

			//dev서버에는 주석 풀려져올려져 있음. 한지민 대리요청 20161018 (실서버 미적용)
			//strFunc = ReplaceStr.replace(strFunc,"<img src="+ConfigManager.IMG_ENURI_COM+"/images/detail/more_btn.gif border=0>","");
			//strFunc = ReplaceStr.replace(strFunc,"http://img.enuri.gscdn.com/images/detail/more_btn.gif","http://img.enuri.gscdn.com/images/blank.gif");

			int div_location = 0;
			String strFunc1="";
			String strFunc2="";
			String strFunc3="";
			
			// 태그사이에 있는 데이터는 trim() 함(엔터와 스페이스만 있을경우)
			strFunc = strFunc.replaceAll(">\r\n<img", ">\r\n\r\n<img");
			strFunc = strFunc.replaceAll(">\r\n<", "><");
			strFunc = strFunc.replaceAll("</font>\r\n\r\n<img", "</font>--------<img");
			strFunc = strFunc.replaceAll(">\r\n\r\n<img", ">\r\n<img");
			strFunc = strFunc.replaceAll("</font>--------<img", "</font>\r\n\r\n<img");
			strFunc = strFunc.replaceAll(" \r\r\n", " ");

			p1 = java.util.regex.Pattern.compile(">\r\n.*?<");
			m1 = p1.matcher(strFunc);
			whileLoopBreak = 0;
			while(m1.find()) {
				String tempStr = m1.group();

				if(tempStr.length()>2) {
					int startIndex = strFunc.indexOf(m1.group());
					tempStr = tempStr.substring(1, tempStr.length()-1);

					// 뒤에 불릿(<img)이 올경우는  제거 안함
					int imgFindIndex = strFunc.substring(startIndex+m1.group().length()).indexOf("img");
					if(tempStr.trim().length()==0 && (imgFindIndex<0 || imgFindIndex>3)) {
						strFunc = strFunc.substring(0, startIndex) + "><" + strFunc.substring(startIndex+m1.group().length());
					}
				}

				if(whileLoopBreak++>500) break;
			}

			// 엔터 3개가 연속으로 있다면 이상한 상황임 2개로 변환
			strFunc = strFunc.replaceAll("\r\n\r\n\r\n", "\r\n\r\n");
			if(strFunc.length()>0) {

				java.util.regex.Pattern pfunc = java.util.regex.Pattern.compile("\r\n");
				java.util.regex.Matcher mfunc = pfunc.matcher(strFunc);
				int enter_cnt = 0;

				for(int j=0; mfunc.find(j); j=mfunc.end()) enter_cnt++;

				String strFunc_tmp = strFunc.toLowerCase();
				//table태그 쓴경우 엔터갯수 조정 : 필요없음, html태그를 쓸때는 엔터 사용 안하고 편집하고있음
				if(strFunc_tmp.indexOf("<table")>=0 && strFunc_tmp.indexOf("</table>")>0 && strFunc_tmp.indexOf("<table")<strFunc_tmp.indexOf("</table>")){
					String strFunc_table = strFunc_tmp.substring(strFunc_tmp.indexOf("<table"), strFunc_tmp.indexOf("</table>")+8);
					p1 = java.util.regex.Pattern.compile("\r\n");
					m1 = p1.matcher(strFunc_table);
					while(m1.find()) {
						enter_cnt--;
					}
				}

				int div_location1=0;
				int div_location2=0;
				int tmp_cnt=0;
				int tmp_location=0;
				String tmpFunc = strFunc;

				if(enter_cnt > 4) { //4줄 이하일때는 첫번째 단락에 몰아서 전부 노출
					div_location = (enter_cnt / 3);
				}else{
					div_location = enter_cnt;
				}

				while(true) {
					tmp_cnt++;
					tmp_location = tmpFunc.indexOf("\r\n", tmp_location + 1);
					if(tmp_cnt==div_location) {
						div_location1 = tmp_location;
					} else if(tmp_cnt==(div_location * 2)) {
						div_location2 = tmp_location;
					}
					if(tmp_location==-1) {
						break;
					}
				}

				div_location1 = strFunc.indexOf("^", div_location1);
				if(div_location1>-1 && enter_cnt>5) {
					strFunc1 = strFunc.substring(0, div_location1);
					div_location2 = strFunc.indexOf("^", div_location2);
					if(div_location2>-1) {
						strFunc2 = strFunc.substring(div_location1, div_location2);
						strFunc3 = strFunc.substring(div_location2, strFunc.length());
						if(strFunc2.length()==0) {
							strFunc2 = strFunc3;
							strFunc3 = "";
						}
					} else {
						strFunc2 = strFunc.substring(div_location1, strFunc.length());
					}
				} else {
					strFunc1=strFunc;
				}
				
			}

			strFuncTitle = strFuncTitle.replaceAll("\r\n", "<br>");
			if(strFuncTitle.indexOf("<br><br>")>-1) strFuncTitle = strFuncTitle.substring(0, strFuncTitle.indexOf("<br><br>"));
			strFuncTitle = strFuncTitle.replaceAll("<br>", "<!--br-->"); //줄넘기지 않고 한줄로 노출

			// ^ 를 특정 이미지로 변환
			int loopLimitedMaxCnt = 100;
			int loopCnt = 0;
			for(int i=0; i<loopLimitedMaxCnt; i++){
				int idxFuncPartTitleStart = strFunc1.indexOf("^");
				if(idxFuncPartTitleStart>-1){
					strFunc1 = strFunc1.substring(0, idxFuncPartTitleStart) + ((loopCnt==0 && strFunc1.substring(0, idxFuncPartTitleStart).indexOf("※")>-1)?"<br>":"") + "<strong class='func_part_title" + ((loopCnt==0 && !(strFunc1.indexOf("▶")>-1)) ?"_first":"") + "'>" + strFunc1.substring(idxFuncPartTitleStart+1);
					int idxFuncPartTitleEnd = idxFuncPartTitleStart + strFunc1.substring(idxFuncPartTitleStart).indexOf("\r\n");
					if(idxFuncPartTitleEnd>idxFuncPartTitleStart){
						strFunc1 = strFunc1.substring(0, idxFuncPartTitleEnd) + "</strong>" + strFunc1.substring(idxFuncPartTitleEnd);
					}else{
						strFunc1 = strFunc1 + "</strong>";
					}

					loopCnt++;
				}
				if(loopCnt>loopLimitedMaxCnt) break;
			}
			loopCnt = 0;
			for(int i=0; i<loopLimitedMaxCnt; i++){
				int idxFuncPartTitleStart = strFunc2.indexOf("^");
				if(idxFuncPartTitleStart>-1){
					strFunc2 = strFunc2.substring(0, idxFuncPartTitleStart) + "<strong class='func_part_title" + (loopCnt==0?"_first":"") + "'>" + strFunc2.substring(idxFuncPartTitleStart+1);
					int idxFuncPartTitleEnd = idxFuncPartTitleStart + strFunc2.substring(idxFuncPartTitleStart).indexOf("\r\n");
					if(idxFuncPartTitleEnd>idxFuncPartTitleStart){
						strFunc2 = strFunc2.substring(0, idxFuncPartTitleEnd) + "</strong>" + strFunc2.substring(idxFuncPartTitleEnd);
					}else{
						strFunc2 = strFunc2 + "</strong>";
					}

					loopCnt++;
				}
				if(loopCnt>loopLimitedMaxCnt) break;
			}
			loopCnt = 0;
			for(int i=0; i<loopLimitedMaxCnt; i++){
				int idxFuncPartTitleStart = strFunc3.indexOf("^");
				if(idxFuncPartTitleStart>-1){
					strFunc3 = strFunc3.substring(0, idxFuncPartTitleStart) + "<strong class='func_part_title" + (loopCnt==0?"_first":"") + "'>" + strFunc3.substring(idxFuncPartTitleStart+1);
					int idxFuncPartTitleEnd = idxFuncPartTitleStart + strFunc3.substring(idxFuncPartTitleStart).indexOf("\r\n");
					if(idxFuncPartTitleEnd>idxFuncPartTitleStart){
						strFunc3 = strFunc3.substring(0, idxFuncPartTitleEnd) + "</strong>" + strFunc3.substring(idxFuncPartTitleEnd);
					}else{
						strFunc3 = strFunc3 + "</strong>";
					}

					loopCnt++;
				}
				if(loopCnt>loopLimitedMaxCnt) break;
			}

			strFunc1 = strFunc1.replaceAll("\r\n", "<br>");
			strFunc2 = strFunc2.replaceAll("\r\n", "<br>");
			strFunc3 = strFunc3.replaceAll("\r\n", "<br>");

			strFuncTitle = toJS3(strFuncTitle.trim());
			strFunc1 = strFunc1.trim();
			strFunc2 = strFunc2.trim();
			strFunc3 = strFunc3.trim();

			// 특수 기호는 삭제
			strFuncTitle = ReplaceStr.replace(strFuncTitle, "●", "");
			
			//불필요한 스페이스 발생 제거
			strFunc1 = strFunc1.replaceAll("<br><br>", "");
			
			if(strFunc1.indexOf("▶")>-1 && !(strFunc1.indexOf("<p><br>▶")>-1)) strFunc1 = ReplaceStr.replace(strFunc1,"▶", "<p><br>▶");
			if(strFunc1.indexOf("▶")>-1 && !(strFunc1.indexOf("▶<strong><span style=\"font-size: 13px;\">")>-1)) strFunc1 = ReplaceStr.replace(strFunc1, "▶", "▶<strong><span style=\"font-size: 13px;\">");
			if(strFunc1.indexOf("<br>")>-1 && !(strFunc1.indexOf("<br></span></strong>")>-1)) strFunc1 = ReplaceStr.replace(strFunc1, "<br>", "<br></span></strong>");
			
			if(strFunc2.indexOf("▶")>-1 && !(strFunc2.indexOf("<p><br>▶")>-1)) strFunc2 = ReplaceStr.replace(strFunc2,"▶", "<p><br>▶");
			if(strFunc2.indexOf("▶")>-1 && !(strFunc2.indexOf("▶<strong><span style=\"font-size: 13px;\">")>-1)) strFunc2 = ReplaceStr.replace(strFunc2, "▶", "▶<strong><span style=\"font-size: 13px;\">");
			if(strFunc2.indexOf("<br>")>-1 && !(strFunc2.indexOf("<br></span></strong>")>-1)) strFunc2 = ReplaceStr.replace(strFunc2, "<br>", "<br></span></strong>");
			
			if(strFunc3.indexOf("▶")>-1 && !(strFunc3.indexOf("<p><br>▶")>-1)) strFunc3 = ReplaceStr.replace(strFunc3,"▶", "<p><br>▶");
			if(strFunc3.indexOf("▶")>-1 && !(strFunc3.indexOf("▶<strong><span style=\"font-size: 13px;\">")>-1)) strFunc3 = ReplaceStr.replace(strFunc3, "▶", "▶<strong><span style=\"font-size: 13px;\">");
			if(strFunc3.indexOf("<br>")>-1 && !(strFunc3.indexOf("<br></span></strong>")>-1)) strFunc3 = ReplaceStr.replace(strFunc3, "<br>", "<br></span></strong>");
			
			jSONData.put("enuri_func_title", strFuncTitle);
			jSONData.put("enuri_func_1", strFunc1);
			jSONData.put("enuri_func_2", strFunc2);
			jSONData.put("enuri_func_3", strFunc3);

			if(strFunc.length()>20) {
				if((CutStr.cutStr(szCategory,6).equals("050309") && szFactory.equals("모뉴엘"))
					|| (ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,4),"0305","0404","0201","0401","0402","0405","0420","2211","2241","0304","0305","0318","0357","0360","0211","0233","0241","0702","0709","0712","0713"}) && szFactory.equals("삼성"))
					|| (ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,2),"05","06"}) && szFactory.equals("한경희생활과학"))
					|| ControlUtil.compareValOR(new int[]{nModelNo,10516019,8361362 ,7820366 ,11372296 ,11439697 ,11476890 ,11476883 , 11476887 , 11372322 , 11435489 , 11495006 , 11495001,11874713,11893759,11895731,11895724,11895743,11895750,11895748,11895749,11892326,11896209,11874479,11892496,11895438,11895445,11895440,11895444,11892495,11895477,11895486,11895481,11895484,11892385,11895420, 11895418, 11895416, 11895417,11892497,11893833,11893846,11893840,11893842,11895751,11895759,11895752,11895757,11895758,11896237,11896498,11896525,11896522,11896519})
					|| ControlUtil.compareValOR(new int[]{nModelNoGroup,10516019,8361362 ,7820366 ,11372296 ,11439697 ,11476890 ,11476883 , 11476887 , 11372322 , 11435489 , 11495006 , 11495001,11874713,11893759,11895731,11895724,11895743,11895750,11895748,11895749,11892326,11896209,11874479,11892496,11895438,11895445,11895440,11895444,11892495,11895477,11895486,11895481,11895484,11892385,11895420, 11895418, 11895416, 11895417,11892497,11893833,11893846,11893840,11893842,11895751,11895759,11895752,11895757,11895758,11896237,11896498,11896525,11896522,11896519,11823364,11439264})
					|| ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,2),"14","15"})
					|| (ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,2),"02","03","04","07","22"}) && szFactory.equals("로지텍")) //2019-05-14. #33990
				){

				}else{
					jSONData.put("enuri_func_scrap", "Y");
				}
			}
		}

		//용어설명
		Goods_Attribute_Data[] goods_attribute_kb_data = null;
		if(nModelNo>0) goods_attribute_kb_data = Goods_Attribute_Proc.getGoodsKb_no(nModelNo); //용어사전
		if(goods_attribute_kb_data!=null && goods_attribute_kb_data.length>0){

			Know_termdic_title_Data[] know_termdic_title_data = null;

			String miniguide_no = "";

			//용어사전에 조건명 추가
			int[] tempRef_kbnos = null;
			if(!szCondiNm.equals("")) {
				tempRef_kbnos = Know_termdic_title_Proc.getDetailmultiRef_kbnos(CutStr.cutStr(szCategory,4), szCondiNm);
				if(tempRef_kbnos!=null && tempRef_kbnos.length>0) {
					for(int ki=0; ki<tempRef_kbnos.length; ki++){
						if(miniguide_no.equals("")){
							miniguide_no = tempRef_kbnos[ki] + "";
						} else {
							miniguide_no = miniguide_no + ":" + tempRef_kbnos[ki];
						}
					}
				}
			}
			
			//용어사전번호 추가
			if(goods_attribute_kb_data!=null && goods_attribute_kb_data.length>0){	
				for(int i=0;i<goods_attribute_kb_data.length;i++) {
					if(miniguide_no.length()>0) miniguide_no += ":";
					miniguide_no += goods_attribute_kb_data[i].getRef_kb_no();
				}
			}
			
			Know_termdic_title_Data[] know_termdic_title_dataTemp = null;
			if(miniguide_no.length()>0) {
				know_termdic_title_dataTemp = Know_termdic_title_Proc.getData_TermdicTitleKbnos(miniguide_no);
			}

			// 리스트의 최대값
			int maxKttdNum = 0;
			if(know_termdic_title_dataTemp!=null) maxKttdNum = know_termdic_title_dataTemp.length;
			
			know_termdic_title_data = new Know_termdic_title_Data[maxKttdNum];

			for(int i=0; i<know_termdic_title_data.length; i++) {
				know_termdic_title_data[i] = new Know_termdic_title_Data();
			}
			//직접입력 용어 세팅
			int addKttdCnt = 0;

			if(know_termdic_title_dataTemp!=null) {
				for(int i=0; i<know_termdic_title_dataTemp.length; i++) {
					if(!know_termdic_title_dataTemp[i].getKtt_func_content().equals("")){
						know_termdic_title_data[addKttdCnt].setKtt_idx(know_termdic_title_dataTemp[i].getKtt_idx());
						know_termdic_title_data[addKttdCnt].setRef_kbno(know_termdic_title_dataTemp[i].getRef_kbno());
						know_termdic_title_data[addKttdCnt].setKtt_cate(know_termdic_title_dataTemp[i].getKtt_cate());
						know_termdic_title_data[addKttdCnt].setKtt_title(know_termdic_title_dataTemp[i].getKtt_title());
						know_termdic_title_data[addKttdCnt].setKtt_titleimg(know_termdic_title_dataTemp[i].getKtt_titleimg());
						know_termdic_title_data[addKttdCnt].setKtt_titleimg_width(know_termdic_title_dataTemp[i].getKtt_titleimg_width());
						know_termdic_title_data[addKttdCnt].setKtt_titleimg_height(know_termdic_title_dataTemp[i].getKtt_titleimg_height());
						know_termdic_title_data[addKttdCnt].setKtt_func_option(know_termdic_title_dataTemp[i].getKtt_func_option());
						know_termdic_title_data[addKttdCnt].setKtt_func_content(know_termdic_title_dataTemp[i].getKtt_func_content());
	
						String tempContent = know_termdic_title_dataTemp[i].getKtt_content();
						
						// 링크 제거
						p1 = java.util.regex.Pattern.compile("[\r]*[ \n]*<[aA] [hH][rR][eE][fF].*?</[aA]>");
						m1 = p1.matcher(tempContent);
						whileLoopBreak = 0;
						while(m1.find()) {
							int startIndex = tempContent.indexOf(m1.group());
	
							if(startIndex>0) {
								tempContent = tempContent.substring(0, startIndex) + tempContent.substring(startIndex+m1.group().length());
							}
	
							if(whileLoopBreak++>30) break;
						}
						//System.out.println("tempContent>>>"+tempContent.indexOf("<break>"));
						know_termdic_title_data[addKttdCnt].setKtt_content(tempContent);
	
						addKttdCnt++;
					}

				}
			}
			//3단으로 나누기
			String strKtt_content = "";
			int idxObjectStart = 0;
			int idxObjectEnd = 0;
			int maxCnt1 = 0;
			int maxCnt2 = 0;
			int maxCnt3 = 0;
			if(addKttdCnt>0){
				maxCnt1 = addKttdCnt/3;
				maxCnt2 = maxCnt1;
				maxCnt3 = maxCnt1;

				if((addKttdCnt%3)==1){
					maxCnt1++;
				}
				if((addKttdCnt%3)==2){
					maxCnt1++;
					maxCnt2++;
				}
				//1단
				if(maxCnt1>0){
					jsonArray = new JSONArray();
					for(int i=0;i<maxCnt1;i++) {
					    JSONObject json_list = new JSONObject();

						json_list.put("kbno", know_termdic_title_data[i].getRef_kbno());
						json_list.put("title", know_termdic_title_data[i].getKtt_title());
						json_list.put("titmeimg", know_termdic_title_data[i].getKtt_titleimg());
						json_list.put("img_width", know_termdic_title_data[i].getKtt_titleimg_width());
						json_list.put("img_height", know_termdic_title_data[i].getKtt_titleimg_height());
						json_list.put("func_content", know_termdic_title_data[i].getKtt_func_content());
						json_list.put("func_option", know_termdic_title_data[i].getKtt_func_option());
						
					    jsonArray.put(json_list);
					}
					jSONData.put("enuri_termdic1", jsonArray);
				}
				//2단
				if(maxCnt2>0){
					jsonArray = new JSONArray();
					for(int i=maxCnt1;i<maxCnt1+maxCnt2;i++) {
					    JSONObject json_list = new JSONObject();

						json_list.put("kbno", know_termdic_title_data[i].getRef_kbno());
						json_list.put("title", know_termdic_title_data[i].getKtt_title());
						json_list.put("titmeimg", know_termdic_title_data[i].getKtt_titleimg());
						json_list.put("img_width", know_termdic_title_data[i].getKtt_titleimg_width());
						json_list.put("img_height", know_termdic_title_data[i].getKtt_titleimg_height());
						json_list.put("func_content", know_termdic_title_data[i].getKtt_func_content());
						json_list.put("func_option", know_termdic_title_data[i].getKtt_func_option());

					    jsonArray.put(json_list);
					}
					jSONData.put("enuri_termdic2", jsonArray);
				}
				//3단
				if(maxCnt3>0){
					jsonArray = new JSONArray();
					for(int i=maxCnt1+maxCnt2;i<maxCnt1+maxCnt2+maxCnt3;i++) {
					    JSONObject json_list = new JSONObject();

						json_list.put("kbno", know_termdic_title_data[i].getRef_kbno());
						json_list.put("title", know_termdic_title_data[i].getKtt_title());
						json_list.put("titmeimg", know_termdic_title_data[i].getKtt_titleimg());
						json_list.put("img_width", know_termdic_title_data[i].getKtt_titleimg_width());
						json_list.put("img_height", know_termdic_title_data[i].getKtt_titleimg_height());
						json_list.put("func_content", know_termdic_title_data[i].getKtt_func_content());
						json_list.put("func_option", know_termdic_title_data[i].getKtt_func_option());

					    jsonArray.put(json_list);
					}
					jSONData.put("enuri_termdic3", jsonArray);
				}
			}
		}

		//제조사, 설명서
		String szTelNm = "", szTel = "", szUrl1Nm = "", szUrl2Nm = "", szUrl1 = "", szUrl2 = "", strUrl3 = "";
	    //제조사 정보
	    Goods_Reference_Data goods_reference_data = null;
	    if(!CutStr.cutStr(szCategory,8).equals("16420904") && !CutStr.cutStr(szCategory,8).equals("16421014")){
	        goods_reference_data = Goods_Reference_Proc.Goods_Reference_One(nRefid);
	    }
	    int iRefcnt = 0;
	    if(goods_reference_data != null){
	    	iRefcnt = goods_reference_data.getRefid();
	        if(!goods_reference_data.getTelflag().equals("1")) {
	            szTelNm = goods_reference_data.getTelnm();
	            szTel = goods_reference_data.getTel();
	        }
	        if(!goods_reference_data.getUrl1flag().equals("1")) {
	            szUrl1 = goods_reference_data.getUrl1();
	            szUrl1Nm = goods_reference_data.getUrl1nm();
				if(szUrl1.indexOf("http://") < 0){
					szUrl1 = "http://"+szUrl1;
				}
	        }
	        if(!goods_reference_data.getUrl2flag().equals("1")) {
	            szUrl2Nm = goods_reference_data.getUrl2nm();
	            szUrl2 = goods_reference_data.getUrl2();
				if(szUrl2.indexOf("http://") < 0){
					szUrl2 = "http://"+szUrl2;
				}
	        }
	    }
	    jSONData.put("enuri_factory_tel", szTel);
	    jSONData.put("enuri_factory_telnm", szTelNm);
	    jSONData.put("enuri_factory_url1", szUrl1);
	    jSONData.put("enuri_factory_url1nm", szUrl1Nm);
	    jSONData.put("enuri_factory_url2", szUrl2);
	    jSONData.put("enuri_factory_url2nm", szUrl2Nm);

	    //설명서 유무 url3 이 있으면 바로가기 만들어준다.
	    strUrl3 = Goods_Reference_Proc.Goods_Reference_Url3(nRefid);

		int breakCnt = 0;
		while(ManualLink.indexOf("\\")>-1) {
			ManualLink = ManualLink.substring(0,ManualLink.indexOf("\\")) + "/" + ManualLink.substring(ManualLink.indexOf("\\")+1);
			breakCnt++;
			if(breakCnt==50) break;
		}

		// 설명서 유효성체크
		if((ManualLink.indexOf("www.lge.co.kr")>-1 || ManualLink.indexOf("www.lgservice.co.kr")>-1) && ManualLink.indexOf("pdfpath=")>-1) {
			String[] ManualLinkAry = ManualLink.split("pdfpath=");

			if(!IsUrlTrue(ManualLinkAry[1])) ManualLink = "";
		} else {
			if(ManualLink.indexOf("https")==-1 && ManualLink.toLowerCase().indexOf("pdf")==-1) {
				if(ManualLink.indexOf("global-download.acer.com")==-1) {
					if(!IsUrlTrue(ManualLink)) ManualLink = "";
				}
			}
		}
		if(((ManualLink.length()>0 && (ControlUtil.compareValOR(new String[]{Linkservicefalg,"O","2","3","4","5","6"}))) || strUrl3.length()>1)) {
			//설명서 뷰어
			String viewerName = "";
			String viewerLink = "";
			if(Linkservicefalg.equals("2") || Linkservicefalg.equals("3")) {
				viewerName = "Adobe Reader";
				viewerLink = "http://ardownload.adobe.com/pub/adobe/reader/win/8.x/8.1.2/kor/AdbeRdr812_ko_KR.exe";
			}
			if(Linkservicefalg.equals("4") || Linkservicefalg.equals("5")) {
				viewerName = "DjVu Viewer";
				viewerLink = "http://www.lgservice.co.kr/upload/doc/DJVUCNTL_601_KR.EXE";
			}
			jSONData.put("enuri_manual_viewernm", viewerName);
			jSONData.put("enuri_manual_viewerlink", viewerLink);
			//설명서보기 링크
			if(ManualLink.length()>0 && (ControlUtil.compareValOR(new String[]{Linkservicefalg,"O","2","3","4","5","6"}))) {
				ManualLink = ManualLink.replaceAll(" ", "%20");
				jSONData.put("enuri_manual", ManualLink);
			}
			//제조사 설명서 목록 링크
			if(strUrl3.length()>1) {
				if(strUrl3.length()>=7 && !strUrl3.substring(0, 7).equals("http://")) strUrl3 = "http://" + strUrl3;
				jSONData.put("enuri_manual_factory", strUrl3);
			}
		}
	}

	//쇼핑몰 크롤링 정보
	String[] arrMallDescInfo = Goods_MallDesc_Proc.getGoodsMallDesc(nModelNo, szCategory);
	if(!arrMallDescInfo[2].equals("")){
		if(arrMallDescInfo[3].equals("663")){
			jSONData.put("mall_desc_yn", "N");
		}else{
			jSONData.put("mall_desc_yn", "Y");
			arrMallDescInfo[2] = arrMallDescInfo[2].replace("id=\"guidance\">","");
			if(procType.equals("0") || procType.equals("2")){
				
				jSONData.put("mall_desc_plno", arrMallDescInfo[0]);
				jSONData.put("mall_desc_shopnm", arrMallDescInfo[1]);
				jSONData.put("mall_desc_shopcd", arrMallDescInfo[3]);
				jSONData.put("mall_desc_contents", arrMallDescInfo[2]);
			}
		}
	}

	out.println(jSONData);
%>
<%!
	public boolean IsUrlTrue(String urlStr) {
		boolean returnVal = false;

		if(urlStr.length()>7) {
			if(!urlStr.toLowerCase().substring(0, 7).equals("http://")) {
				urlStr = "http://" + urlStr;
			}
		}
		//System.out.println("urlStr="+urlStr);

		try {
			URL url = new java.net.URL(urlStr);
			URLConnection urlcon = url.openConnection();
			urlcon.setConnectTimeout(3000);
			urlcon.setReadTimeout(3000);
			HttpURLConnection conn = (HttpURLConnection)urlcon;
			int urlCode = conn.getResponseCode();

			if(urlCode==200) returnVal = true;
		} catch(Exception e) {
			//System.out.println("error = "+e.toString());
		}

		return returnVal;
	}
%>