<%@ page contentType="text/html;charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ include file="/mobile/include/IncGroupTool_2010.jsp"%>
<%@ page import="com.enuri.bean.main.Goods_Proc"%>
<%@ page import="com.enuri.bean.main.Goods_Data"%>
<%@ page import="com.enuri.bean.mobile.Mobile_Image_Proc"%>
<jsp:useBean id="Goods_Proc" class="Goods_Proc" scope="page" />
<jsp:useBean id="Mobile_Image_Proc" class="Mobile_Image_Proc" scope="page" />
<%
String PHOTO_ENURI_COM = ConfigManager.Photo_Image_Server(request);
String ConstBlankImgSrc = ConfigManager.ConstBlankImgSrc;

String szModelNm = ConfigManager.RequestStr(request, "szModelNm", "");
String CateName = ConfigManager.RequestStr(request, "CateName", "");
String szFactory = ConfigManager.RequestStr(request, "szFactory", "");
String szCategory = ConfigManager.RequestStr(request, "szCategory", "");
String sModelNo = ChkNull.chkStr(request.getParameter("modelno"));
String strImageChk = ChkNull.chkStr(request.getParameter("strImageChk"));
int nModelNo = 0;
String goodsBbsOpenType = ChkNull.chkStr(request.getParameter("goodsBbsOpenType"));
String sopnShowFlag = ChkNull.chkStr(request.getParameter("sopnShowFlag"));
String openModelLink = ChkNull.chkStr(request.getParameter("openModelLink"));
int intGetModelNo = Integer.parseInt(ConfigManager.RequestStr(request, "intGetModelNo", "0"));
String strBigImageUrl = "";

String szGsSize = "";
String strFuncImg = "";//휴대폰 아이콘 묶음(이통사, dmb유무등등 ) ex)1,2,3,4 
int intKbNo = 0;//동영상글 지식통 번호
String szEcatalog_flag = "";
String szEcatalog_url = "";
String szRefshop = "";
int modelno_group = 0;
String strConstrain = "";
String strP_imgurl2 = "";
int nMallCnt = Integer.parseInt(ConfigManager.RequestStr(request, "nMallCnt", "0"));

// 모델번호가 없다면 보여주지 않음
if(sModelNo.length()==0) return;

if(ChkNull.chkNumber(sModelNo)) {
	nModelNo = Integer.parseInt(sModelNo);
}

Goods_Data goods_data_bigimginfo = Goods_Proc.Goods_BigImgInfo_One(nModelNo);

String smodelnos = Goods_Proc.getData_Group_Modelnos(nModelNo);

if(goods_data_bigimginfo!=null){
	szModelNm = goods_data_bigimginfo.getModelnm();
	szGsSize = goods_data_bigimginfo.getG_size();
	strFuncImg = goods_data_bigimginfo.getFunc_img();//휴대폰 아이콘
	intKbNo = Goods_Proc.getKb_Goods_Vod(smodelnos);
	szEcatalog_flag = goods_data_bigimginfo.getEcatalog_flag(); // eCatalog 타입
	szEcatalog_url = goods_data_bigimginfo.getEcatalog_url();// eCatalog url
	szRefshop = goods_data_bigimginfo.getRefshop();
	szFactory = goods_data_bigimginfo.getFactory();
	strImageChk = goods_data_bigimginfo.getImgchk();
	modelno_group = goods_data_bigimginfo.getModelno_group();
	szCategory = goods_data_bigimginfo.getCa_code();
	strConstrain = goods_data_bigimginfo.getConstrain();
	strP_imgurl2 = goods_data_bigimginfo.getP_imgurl2();
}
if(modelno_group==0) modelno_group = nModelNo;

szModelNm = replaceModelNmSpecialChar(szCategory, szModelNm);
String tmpModelNm_goodsinfo = szModelNm;
if(CutStr.cutStr(szCategory,4).equals("0304")){
	tmpModelNm_goodsinfo = ReplaceStr.replace(tmpModelNm_goodsinfo, "(", "<span style='font-weight:bold'>(");
	tmpModelNm_goodsinfo = ReplaceStr.replace(tmpModelNm_goodsinfo, ")", ")</span>");
}
if(!CutStr.cutStr(szCategory,2).equals("14") && !CutStr.cutStr(szCategory,2).equals("93")){
	tmpModelNm_goodsinfo = ReplaceStr.replace(tmpModelNm_goodsinfo, "[", " <span style='font-weight:bold'>[");
	tmpModelNm_goodsinfo = ReplaceStr.replace(tmpModelNm_goodsinfo, "]", "]</span>");
}
if(szFactory.equals("[불명]") || szFactory.equals("[추가]")){
	szFactory = "";
}
// 특정 분류는 제조사 안보임
if(ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,8),"18120904","18121014","18192001","18192002","18192005","18192006","18192009","18192012"})
 || ControlUtil.compareValOR(new String[]{CutStr.cutStr(szCategory,6),"032406"})) {
	szFactory = "";
}

CateName = ReplaceStr.replace(CateName, "< temp ", "");
CateName = ReplaceStr.replace(CateName, "temp < ", "");
CateName = ReplaceStr.replace(CateName, "< ★관리용 ", "");
CateName = ReplaceStr.replace(CateName, "★관리용 < ", "");
CateName = szModelNm + " < " + CateName + " [에누리닷컴 가격비교]";

boolean bigImageDisplayFlag = false;

String[] bigImages = Mobile_Image_Proc.getBigImg_List(nModelNo);

long lngTmpplno = 0;
//이미지 없을때 처리
String strImageurl = ImageUtil.getImageSrc(szCategory,modelno_group,strImageChk,lngTmpplno,strP_imgurl2,"");


String strImageurl_middle = strImageurl;
String smallImgUrlFinder = "/data/images/service/small/";
int smallFinderIdx = strImageurl.indexOf(smallImgUrlFinder);
// 500이미지로 변경
if(smallFinderIdx>-1) {
	strImageurl_middle = strImageurl.substring(0, smallFinderIdx);
	strImageurl_middle += "/data/images/service/middle/";
	strImageurl_middle += strImageurl.substring(smallFinderIdx + smallImgUrlFinder.length());

    int lastDotIdx = strImageurl_middle.lastIndexOf(".");
    strImageurl_middle = strImageurl_middle.substring(0, lastDotIdx) + ".jpg";
}
	
	

Cookie[] carr = request.getCookies();
String strAppyn = "";

for(int i=0;i<carr.length;i++){
    if(carr[i].getName().equals("appYN")){
    	strAppyn = carr[i].getValue();
    	break;
    }
}

if(bigImages==null) {
	if(strImageChk.equals("3") || strImageChk.equals("9") || strImageChk.equals("4") || strImageChk.equals("5") ||  strImageChk.equals("0") ||  strImageChk.equals("8")) {
		bigImageDisplayFlag = false;
	} else { 
		bigImageDisplayFlag = true;
		if(intGetModelNo>0) {
			strBigImageUrl = PHOTO_ENURI_COM + "/data/images/service/big/"+ImageUtil.ImgFolder(intGetModelNo)+"/"+intGetModelNo+".jpg";
		} else {
			strBigImageUrl = PHOTO_ENURI_COM + "/data/images/service/big/"+ImageUtil.ImgFolder(nModelNo)+"/"+nModelNo+".jpg";
		}
		if(request.getServletPath().indexOf("EnuriQuick.jsp")>=0) {
			if(intGetModelNo>0) {
				strBigImageUrl = PHOTO_ENURI_COM + "/data/images/service/big_quick/"+ImageUtil.ImgFolder(intGetModelNo)+"/"+intGetModelNo+"_y.jpg";
			} else {
				strBigImageUrl = PHOTO_ENURI_COM + "/data/images/service/big_quick/"+ImageUtil.ImgFolder(nModelNo)+"/"+nModelNo+"_y.jpg";
			}
		}
	}
	if(ControlUtil.compareValOR(new String[]{nModelNo+"","9221825","9223613","9221822","9223615","9222080","9221824","9221821"}) && CutStr.cutStr(ChkNull.chkStr(request.getParameter("cate")),4).equals("0304")) {
		strBigImageUrl = IMG_ENURI_COM+"/2012/detail/9221824.jpg";
	}
	// 유사상품
	if(strImageChk.equals("G") && !strP_imgurl2.equals("")) {
		strBigImageUrl = strP_imgurl2;
		if(strBigImageUrl.indexOf("gmarket.co.kr")>=0) {
			strBigImageUrl = ReplaceStr.replace(strBigImageUrl,"/large_img/","/large_jpgimg/");
		}
	}
	if(strBigImageUrl.trim().length() == 0 || strBigImageUrl.trim().equals("BIGIMAGEISNULL")) {
		bigImageDisplayFlag = false;
	}
}
%>
{
<%
	out.print("	\"strBigImageUrl\": \""+ strBigImageUrl +"\", ");
	out.print("	\"strImageurl_middle\": \""+ strImageurl_middle +"\" ");
	if(bigImages != null &&  bigImages.length > 0){
		out.print("	,");
		out.print("	\"bigImageList\": [");
			for(int i=0; i<bigImages.length; i++) {
				if(i>0) out.print(",\r\n");
				out.print("		{ ");
				out.print(" \"bigImages\": \""+ bigImages[i] +"\"");		
				out.print(" }");
			}
		out.println("\r\n	]");
	}
%>
}