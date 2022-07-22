<%@ page contentType="text/html; charset=utf-8" trimDirectiveWhitespaces="true" %>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="com.enuri.bean.wide.LP_RightContent_Proc"%>
<%@page import="org.json.simple.JSONArray"%>
<%@ include file="/lsv2016/include/IncAjaxHeader.jsp"%>
<%@ page import="com.enuri.bean.wide.LP_RightContent_Proc"%>
<%@ page import="com.enuri.bean.lsv2016.KnowboxContent_Proc"%>
<%@ page import="com.enuri.bean.lsv2016.KnowboxContent_Data"%>
<%@ page import="com.enuri.bean.main.Goods_Proc"%>
<%@ page import="com.enuri.bean.main.Goods_Data"%>
<%@ page import="com.enuri.bean.wide.Lp_Header_Proc"%>
<%

	/**
	 * @history
	 	2022.03.18. 최조작성
	 */

	/** Parameter Sets */
	String strCate = ConfigManager.RequestStr(request, "cate", ""); // 카테고리
	String strListType = ConfigManager.RequestStr(request, "listType", "list"); // list / search
	String strServerNm = request.getServerName();
	boolean blDevFlag = false;
	if (strServerNm.indexOf("dev.enuri.com") > -1) {
		blDevFlag = true;
	}
	
	JsonResponse ret = null;
	
	if(strCate.length()==0) {
		ret = new JsonResponse(false).setMessage("카테고리 없음");
		out.print(ret);
		return;
		
	}
	
	String strCate4 = strCate;
	if(strCate4.length()>4) strCate4 = strCate4.substring(0, 4);

	Map<String, Object> retMap = new JsonMap<String, Object>();
	
	LP_RightContent_Proc rightContent_proc = new LP_RightContent_Proc();
	Lp_Header_Proc lp_header_proc = new Lp_Header_Proc();
	KnowboxContent_Proc knowboxcontent_proc = new KnowboxContent_Proc();
	int displayCnt = 10; // 10개 노출
	
	// 카테고리 이름
	String strCatenm = "";
	if(strCate != null && !strCate.equals("") && strCate.length() >= 4){
		JSONObject cateInfoObj = lp_header_proc.getUnionCate_info(strCate.substring(0, 4), "pc", blDevFlag);
		strCatenm = cateInfoObj.containsKey("cate_nm") ? (String) cateInfoObj.get("cate_nm") : "";
	}
	
	// 기획전
	JSONArray cmExhibitionArray = new JSONArray();
	try {
		cmExhibitionArray = rightContent_proc.getExhibitionData(strCate, displayCnt, strListType);
		Collections.shuffle(cmExhibitionArray);
	} catch(Exception e) {
		retMap.put("error", "\" exhibition error " + e.getLocalizedMessage() + "\"");
	}
	
	// 구매 가이드
	JSONArray guideArray = new JSONArray();
	try {
		guideArray = rightContent_proc.getGuideData(strCate, displayCnt, strListType);
		Collections.shuffle(guideArray);
	} catch(Exception e) {
		retMap.put("error", "\" guide error " + e.getLocalizedMessage() + "\"");
	}
	
	// 리뷰
	KnowboxContent_Data[] review = knowboxcontent_proc.getRightWingContentsReviewList(strCate4, "", null, displayCnt);
	JSONArray reviewArray = new JSONArray();
	if(review!=null && review.length>0) {
		for(int i=0;i<review.length;i++) {
			reviewArray.add(knowboxContentAdd((KnowboxContent_Data) review[i]));
		}
	}
	if(review.length<3) {
		// 먼저 대분류로 검색해 보고 가대 분류로 찾음
		String strCate2 = strCate4.substring(0, 2);
		KnowboxContent_Data[] review_more = knowboxcontent_proc.getRightWingContentsReviewList(strCate2, strCate4, null, 10);
		for(int j=0;j<review_more.length;j++) {
			reviewArray.add(knowboxContentAdd((KnowboxContent_Data) review_more[j]));
		}
	}
	
	// 뉴스
	KnowboxContent_Data[] news = knowboxcontent_proc.getRightWingContentsListAll(strCate4, "", 5, 1);
	JSONArray newsArray = new JSONArray();
	if(news!=null && news.length>0) {
		for(int i=0;i<news.length;i++) {
			newsArray.add(knowboxContentAdd((KnowboxContent_Data) news[i]));
		}
	}
	if(news.length<5) {
		// 먼저 대분류로 검색해 보고 가대 분류로 찾음
		String strCate2 = strCate4.substring(0, 2);
		KnowboxContent_Data[] news_more = knowboxcontent_proc.getRightWingContentsListAll(strCate2, strCate4, 10, 1);
		for(int j=0;j<news_more.length;j++) {
			newsArray.add(knowboxContentAdd((KnowboxContent_Data) news_more[j]));
		}
	}
	
	retMap.put("cateNm", "\"" + strCatenm + "\"");
	retMap.put("exhibition", cmExhibitionArray);
	retMap.put("guide", guideArray);
	retMap.put("review", reviewArray);
	retMap.put("news", newsArray);
	
	ret = new JsonResponse(true).setData(retMap);
	out.print(ret);
%>
<%!
public JSONObject knowboxContentAdd(KnowboxContent_Data knowboxContent) throws Exception {
	JSONObject retObject = new JSONObject();
	
	if(knowboxContent!=null) {
		int kb_no = knowboxContent.getKb_no();
		int modelno = knowboxContent.getG_modelno();
		String sort_num = knowboxContent.getSort_num();
		String kk_code = knowboxContent.getKk_code();
		String kb_title = knowboxContent.getKb_title();
		String kb_thumbnail_img = knowboxContent.getKb_thumbnail_img();
		String kb_thumbnail = knowboxContent.getKb_thumbnail();
		String kb_top_write_flag = knowboxContent.getKb_top_write_flag();
		String mo_img = knowboxContent.getMo_img();
		String mo_img2 = knowboxContent.getMo_img2();
		String rss_thumbnail = knowboxContent.getRss_thumbnail();
		String rp_thumbnail_img_url = knowboxContent.getRp_thumbnail_img_url();
		String movie_id = knowboxContent.getMovie_id();
		String showThumbImg = "";
		String showErrorImg = "";

		if(rp_thumbnail_img_url.length() > 0){
			showThumbImg = rp_thumbnail_img_url;
		}else if(mo_img.length() > 0) {
			showThumbImg = ConfigManager.STORAGE_ENURI_COM + "/pic_upload/enurinews/" + mo_img;
		}else if(rss_thumbnail.length() > 0){
			showThumbImg = rss_thumbnail;
		}else if(kb_thumbnail_img.length() > 0){
			showThumbImg = "http://storage.enuri.info/pic_upload/knowbox2/"+kb_thumbnail;
		}else if(mo_img2.length() > 0){
			showThumbImg = "http://storage.enuri.info/pic_upload/enurinews/"+mo_img2;
		}else{
			showThumbImg = kb_thumbnail;
		}

		if(sort_num.equals("3")) {
			Goods_Proc goods_proc = new Goods_Proc();
			Goods_Data goods_data = goods_proc.Goods_Detailmulti_One(modelno, "Detailmulti");
			if(goods_data!=null && goods_data.getModelno()>0) {
				if(showThumbImg.equals("")){
					showErrorImg = ImageUtil_lsv.getImageSrc(goods_data);
					// 100이미지를 가져오기 위해 사용함
					goods_data.setImgchk2("1");
					showThumbImg = ImageUtil_lsv.getVIPImageSrc(goods_data);
				}
			}
		}

		//동영상일때 예외처리 타이틀, 이미지
		if(kk_code.equals("20")){
			kb_title = "[동영상] "+kb_title;
			showThumbImg = "http://img.youtube.com/vi/"+movie_id+"/mqdefault.jpg";
		}

		retObject.put("kb_no", kb_no);
		retObject.put("kb_title", kb_title);
		retObject.put("kk_code", kk_code);
		retObject.put("showThumbImg", showThumbImg);
	}
	
	return retObject;
}
%>