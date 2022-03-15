<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@ page import="org.json.JSONObject"%>
<%@ page import="org.json.JSONArray"%>
<%@ page import="com.enuri.util.common.ChkNull"%>
<%@ page import="com.enuri.util.image.ImageUtil_lsv"%>
<%@ page import="com.enuri.util.common.ConfigManager"%>
<%@ page import="com.enuri.util.common.JsonResponse"%>
<%@ page import="com.enuri.bean.lsv2016.KnowboxContent_Data"%>
<%@ page import="com.enuri.bean.lsv2016.KnowboxContent_Proc"%>
<%@ page import="com.enuri.bean.main.Goods_Data"%>
<%@ page import="com.enuri.bean.main.Goods_Proc"%>
<jsp:useBean id="KnowboxContent_Proc" class="com.enuri.bean.lsv2016.KnowboxContent_Proc" scope="page" />
<jsp:useBean id="Goods_Proc" class="com.enuri.bean.main.Goods_Proc" scope="page" />
<%
if(!CvtStr.isNumeric(request.getParameter("modelno"))){
    return ;
}
int intModelno = ChkNull.chkInt(request.getParameter("modelno"));
int intMaxLength = 10;
String strCate = ChkNull.chkStr(request.getParameter("cate"));
String strCate4 = strCate;
KnowboxContent_Data[] knowboxContent_Data = null;
JSONObject rtnJSONObject = new JSONObject();
JSONArray rtnJSONArray = new JSONArray();
JsonResponse ret = null;

if(strCate.length() > 4) strCate4 = strCate.substring(0, 4);

knowboxContent_Data = KnowboxContent_Proc.get_AdByContentList2(strCate4, intModelno, 1, 15);

if(knowboxContent_Data.length < 10) intMaxLength = knowboxContent_Data.length;

if(knowboxContent_Data == null || knowboxContent_Data.length == 0) {
	ret = new JsonResponse(false).setData(rtnJSONObject);
    out.println(ret.toString());
    return ;
} else {
	for(int i=0; i < intMaxLength; i++) {
		String strKkcodeNm = knowboxContent_Data[i].getKk_name();
		String strRssImg = knowboxContent_Data[i].getRss_thumbnail();
		String strThumbnail = "";
		String strMovieId = knowboxContent_Data[i].getMovie_id();
		JSONObject oObject = new JSONObject();

		if(knowboxContent_Data[i].getKk_code().equals("20") && strMovieId.length() > 0) {
			strThumbnail = "http://img.youtube.com/vi/"+strMovieId+"/mqdefault.jpg";
		}else if (knowboxContent_Data[i].getRp_thumbnail_img_url().length() > 0) {
			strThumbnail = knowboxContent_Data[i].getRp_thumbnail_img_url();
		} else if (knowboxContent_Data[i].getRss_thumbnail().length() > 0) {
			strThumbnail = knowboxContent_Data[i].getRss_thumbnail();
		} else if (knowboxContent_Data[i].getKb_thumbnail_img().length() > 0) {
			strThumbnail = ConfigManager.ConstStorage+"/enurinews_thumbnail/"+knowboxContent_Data[i].getKb_thumbnail_img();
		} else if (knowboxContent_Data[i].getMo_img().length() > 0) {
			strThumbnail = ConfigManager.ConstStorage+"/enurinews/"+ knowboxContent_Data[i].getMo_img();
		} else if (knowboxContent_Data[i].getMo_img2().length() > 0) {
			strThumbnail = ConfigManager.ConstStorage+"/enurinews/"+ knowboxContent_Data[i].getMo_img2();
		}else{
			strThumbnail = "http://img.enuri.info/images/home/thumb_subst.jpg";
		}

		oObject.put("kb_no", knowboxContent_Data[i].getKb_no());
		oObject.put("kk_code", knowboxContent_Data[i].getKk_code());
		oObject.put("kb_title", knowboxContent_Data[i].getKb_title());
		oObject.put("kk_codeNm", strKkcodeNm);
		oObject.put("thumbnail", strThumbnail);

		rtnJSONArray.put(oObject);
	}
	rtnJSONObject.put("know_list", rtnJSONArray);
}

ret = new JsonResponse(true).setData(rtnJSONObject).setTotal(rtnJSONArray.length());
out.println(ret.toString());
%>