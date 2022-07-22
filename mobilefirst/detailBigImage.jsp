<%@ page contentType="text/html;charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ include file="/mobilefirst/include/IncGroupTool_2010.jsp"%>
<%@ page import="com.enuri.bean.main.Goods_Proc"%>
<%@ page import="com.enuri.bean.main.Goods_Data"%>
<%@ page import="com.enuri.bean.mobile.Mobile_Image_Proc"%>
<jsp:useBean id="Goods_Proc" class="com.enuri.bean.main.Goods_Proc" scope="page" />
<jsp:useBean id="Mobile_Image_Proc" class="com.enuri.bean.mobile.Mobile_Image_Proc" scope="page" />
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
	String strVigImageUrl = "";

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
	if(!CutStr.cutStr(szCategory,2).equals("93")){
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

try{
	for(int i=0;i<carr.length;i++){
	    if(carr[i].getName().equals("appYN")){
	    	strAppyn = carr[i].getValue();
	    	break;
	    }
	}
}catch(Exception e){
}

String referer = request.getHeader("referer");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>에누리(가격비교) eNuri.com</title>
<meta charset="utf-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, minimum-scale=1.0, maximum-scale=5.0, width=device-width">
<%@ include file="/mobilefirst/include/common.html" %>
<link rel="stylesheet" type="text/css" href="/mobilefirst/css/vipviewer.css"/>
<link rel="stylesheet" type="text/css" href="/mobilefirst/css/footer.css"/>
<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js" charset="utf-8"></script>
<style>
.newquick {
	position: fixed;
	right: 10px;
	bottom: 50px;
	z-index: 10;
	display:none;
}
</style>
</head>
<%@ include file="/mobilefirst/include/common_top.jsp" %>
<body>
<div id="zoomWrap">
	<%if(!strAppyn.equals("Y")) {%>
	<!--<nav class="m_top_sub type2">
		<h2><a href="javascript:///" style="text-decoration:none;<%=(strAppyn.equals("Y")?"display:none;":"") %>" onclick="history.go(-1);" class="back">뒤로가기</a>상세 이미지 확대</h2>
	</nav>-->
	<div class="head_area">  
		<div class="head_inner">
			<h2 class="tit">상세 이미지 확대</h2> 
			<a href="javascript:///" onclick="location.replace('<%=referer %>');" class="close">닫기</a>
		</div>
	</div>
	<%}%>
<%
	if(bigImages==null) {
		if(strImageChk.equals("3") || strImageChk.equals("9") || strImageChk.equals("4") || strImageChk.equals("5") ||  strImageChk.equals("0") ||  strImageChk.equals("8")) {
			bigImageDisplayFlag = false;
		} else { 
			bigImageDisplayFlag = true;
			if(intGetModelNo>0) {
				strVigImageUrl = PHOTO_ENURI_COM + "/data/images/service/big/"+ImageUtil.ImgFolder(intGetModelNo)+"/"+intGetModelNo+".jpg";
			} else {
				strVigImageUrl = PHOTO_ENURI_COM + "/data/images/service/big/"+ImageUtil.ImgFolder(nModelNo)+"/"+nModelNo+".jpg";
			}
			if(request.getServletPath().indexOf("EnuriQuick.jsp")>=0) {
				if(intGetModelNo>0) {
					strVigImageUrl = PHOTO_ENURI_COM + "/data/images/service/big_quick/"+ImageUtil.ImgFolder(intGetModelNo)+"/"+intGetModelNo+"_y.jpg";
				} else {
					strVigImageUrl = PHOTO_ENURI_COM + "/data/images/service/big_quick/"+ImageUtil.ImgFolder(nModelNo)+"/"+nModelNo+"_y.jpg";
				}
			}
		}
		if(ControlUtil.compareValOR(new String[]{nModelNo+"","9221825","9223613","9221822","9223615","9222080","9221824","9221821"}) && CutStr.cutStr(ChkNull.chkStr(request.getParameter("cate")),4).equals("0304")) {
			strVigImageUrl = IMG_ENURI_COM+"/2012/detail/9221824.jpg";
		}
		// 유사상품
		if(strImageChk.equals("G") && !strP_imgurl2.equals("")) {
			strVigImageUrl = strP_imgurl2;
			if(strVigImageUrl.indexOf("gmarket.co.kr")>=0) {
				strVigImageUrl = ReplaceStr.replace(strVigImageUrl,"/large_img/","/large_jpgimg/");
			}
		}
		if(strVigImageUrl.trim().length() == 0 || strVigImageUrl.trim().equals("BIGIMAGEISNULL")) {
			bigImageDisplayFlag = false;
		}
%>
	<div id="imgListDiv" class="zoomCont" <%=(strAppyn.equals("Y")?"style=\"margin-top:0;\"":"") %>>
		<img src="<%=strVigImageUrl%>" onerror="this.src='<%=strImageurl_middle %>';">
	</div>
<%
	} else {
%>
	<div id="imgListDiv" class="zoomCont" <%=(strAppyn.equals("Y")?"style=\"margin-top:0;\"":"") %>></div>
	<div class="zoomFoot" style="z-index:100;">
		<%if(bigImages.length>1) {%>
		<a id="imgMoreTitle" href="JavaScript:setNextImg();" class="more"></a>
		<span class="r_btn"><a href="JavaScript:setAllLoadImgShow();">전체보기</a></span><!-- 버튼추가 -->
		<%}%>
		<!--<div class="newquick view">
		<a href="#"><p class="TBtn">TOP</p></a>
		</div>-->
	</div>
<script language="JavaScript">
var bigImageAry = new Array();
<%for(int i=0; i<bigImages.length; i++) {%>
bigImageAry[<%=i%>] = "<%=bigImages[i]%>";
<%}%>

var maxImgNum = <%=bigImages.length%>;
var maxPageNum = Math.ceil(maxImgNum/2);
var lastImgNum = 1;

function setNextImg() {
	if(maxImgNum>0) {
		if(lastImgNum<maxImgNum) {
			lastImgNum++;
			$("#imgListDiv").append("<img id=\"imgItem"+lastImgNum+"\" src=\""+bigImageAry[lastImgNum-1]+"\">");
			if(lastImgNum==maxImgNum) {
				lastImgSet();
			} else { 
				$("#imgMoreTitle").html("이미지 더 보기("+Math.ceil(lastImgNum/2)+"/"+maxPageNum+")");
			}

			//setTimeout("scrollBottom()", 500);
		}
		if(lastImgNum<maxImgNum) {
			lastImgNum++;
			$("#imgListDiv").append("<img id=\"imgItem"+lastImgNum+"\" src=\""+bigImageAry[lastImgNum-1]+"\">");
			if(lastImgNum==maxImgNum) {
				lastImgSet();
			} else {
				$("#imgMoreTitle").html("이미지 더 보기("+Math.ceil(lastImgNum/2)+"/"+maxPageNum+")");
			}

			//setTimeout("scrollBottom()", 500);
		}

		<%if(strAppyn.equals("Y")) {%>
		$("#zoomWrap .zoomCont img").css("width", $("#zoomWrap").width()+"px" );
		<%}%>
	}
}

// 이미지 전체 로딩
function setAllLoadImgShow() {
	lastImgNum++;
	for(;;lastImgNum++) {
		if(lastImgNum<=maxImgNum) {
			$("#imgListDiv").append("<img id=\"imgItem"+lastImgNum+"\" src=\""+bigImageAry[lastImgNum-1]+"\">");
		} else {
			break;
		}
	}
	lastImgSet();
}

function lastImgSet() {
	$("#imgMoreTitle").html("더 이상 이미지가 없습니다");
	$("#imgMoreTitle").addClass("last");
	$("#zoomWrap .zoomFoot .r_btn a").html("닫기");
	$("#zoomWrap .zoomFoot .r_btn a").attr("href", "JavaScript:goBack();");
}

function scrollBottom() {
	document.body.scrollTop = document.body.scrollHeight;
}

</script>
<%
	}
%>
	<footer>
		<div class="newquick">
			<p class="TBtn" onclick="location.replace('#');" />
		</div>
	</footer>
</div>
<script language="JavaScript">
<!--
function goBack() {
	<%
	if(strAppyn.equals("Y")) {
	%>
	if(window.android) {
		window.android.onBack();
	} else {
		document.location = "close://";
	}
	<%
	} else {
	%>
	history.back(-1);
	<%
	}
	%>
}

$(function() {
	<%if(bigImages!=null) {%>
	$("#imgListDiv").append("<img id=\"imgItem1\" src=\""+bigImageAry[0]+"\" onerror=\"this.src='<%=strImageurl_middle %>'\">");
	if(maxImgNum>1) {
		$("#imgListDiv").append("<img id=\"imgItem1\" src=\""+bigImageAry[1]+"\">");
		lastImgNum = 2;
	}
	if(maxPageNum>1) {
		$("#imgMoreTitle").html("이미지 더 보기(1/"+maxPageNum+")");
	}
	
	if(maxImgNum<=2) {
		lastImgSet();
		$(".zoomFoot").css("display", "none");
	}
	<%}%>

	$("#zoomWrap .pageHead").css("position", "relative");
	$("#zoomWrap .zoomFoot").css("position", "relative");

	insertLog('11027');
});

// 문서 로딩 후 시작
$(document).ready(function() {
	<%if(strAppyn.equals("Y")) {%>
	$("#zoomWrap .zoomCont img").css("width", $("#zoomWrap").width()+"px" );
	$("#zoomWrap .pageHead").css("width", $("#zoomWrap").width()+"px" );
	$("#imgListDiv").css("width", $("#zoomWrap").width()+"px" );
	$("#zoomWrap .zoomFoot").css("width", $("#zoomWrap").width()+"px" );
	<%}%>
});

ga('send', 'pageview', {
	'page': '/mobilefirst/detailBigImage.jsp', 
	'title': 'mf_큰사진보기'
});

$(window).scroll(function(){
	if($(window).scrollTop() > 50){
		$(".newquick").show();
	}else{
		$(".newquick").hide();
	}
});

-->
</script>
</body>
<%@ include file="/mobilefirst/include/common_logger.html"%>  
</html>