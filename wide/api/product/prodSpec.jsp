<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/lsv2016/include/IncAjaxHeader.jsp"%>
<%@ page import="com.enuri.bean.main.Goods_Proc"%>
<%@ page import="com.enuri.bean.main.Goods_Data"%>
<jsp:useBean id="Goods_Proc" class="com.enuri.bean.main.Goods_Proc" scope="page" />
<%@page import="org.json.*"%>
<%@ include file="/include/IncGroupTool_2010.jsp"%>
<%
int nModelNo = ChkNull.chkInt(request.getParameter("modelno"));
JSONObject jSONData = new JSONObject();
ImageUtil_lsv imageutil_lsv = new ImageUtil_lsv ();
Goods_Data goods_data = Goods_Proc.Goods_Detailmulti_One(nModelNo, "Detailmulti"); 

String PHOTO_ENURI_COM = ConfigManager.PHOTO_ENURI_CDN_COM;

if(goods_data==null){
	jSONData.put("success", false);
	out.println(jSONData);
	return;
}

String fImgChk = goods_data.getImgchk().trim();
String strImgUrl = "";
String szSpec = goods_data.getSpec(); 
strImgUrl = imageutil_lsv.getVIPImageSrc(goods_data);

/* if(fImgChk.equals("1") || fImgChk.equals("2") || fImgChk.equals("4") ||  fImgChk.equals("6") || fImgChk.equals("7")){
	//큰이미지 있음
	strImgUrl = PHOTO_ENURI_COM + "/data/images/service/big/"+ImageUtil.ImgFolder(nModelNo)+"/"+nModelNo+".jpg";
}else{
	strImgUrl = PHOTO_ENURI_COM + "/data/images/service/small/"+ImageUtil.ImgFolder(nModelNo)+"/"+nModelNo+".gif";
} */
szSpec = szSpec.replaceAll("</", "--brTagShow--"); 
szSpec = szSpec.replaceAll("/", "&nbsp;&nbsp;/&nbsp;&nbsp;"); 
szSpec = szSpec.replaceAll("--brTagShow--", "</");

jSONData.put("success", true);
jSONData.put("specText", toJS3(szSpec)); 
jSONData.put("image", strImgUrl); 

out.println(jSONData);
%>