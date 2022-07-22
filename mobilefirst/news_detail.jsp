<%@page import="com.enuri.bean.lsv2016.Goods_Search_Lsv_Proc"%>
<%@page import="com.enuri.bean.main.brandplacement.DBDataTable"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.mobile.News_Proc"%>
<%@ page import="com.enuri.bean.knowbox.Know_box_Data"%>
<%@ page import="com.enuri.bean.knowbox.Know_box_Proc"%>
<%@ page import="com.enuri.bean.main.Goods_Data"%>
<%@ page import="com.enuri.bean.mobile.Mobile_Goods_Proc"%>
<%@ page import="org.apache.commons.lang3.*"%>
<%@ page import="org.json.*"%>
<%@ page import="java.io.*"%>
<%@ page import="com.enuri.bean.knowbox.Knowbox_2011_Proc"%>
<%@ page import="com.enuri.bean.knowbox.Knowbox2_data"%>
<%@ page import="com.enuri.bean.knowbox.Knowbox2_review_data"%>
<jsp:useBean id="knowbox2_data" scope="page" class="com.enuri.bean.knowbox.Knowbox2_data"/>\
<jsp:useBean id="knowbox2_review_data" scope="page" class="com.enuri.bean.knowbox.Knowbox2_review_data"/>\
<jsp:useBean  id="Knowbox_2011_Proc" class="com.enuri.bean.knowbox.Knowbox_2011_Proc" />
<jsp:useBean id="News_Proc" class="com.enuri.bean.mobile.News_Proc" scope="page" />
<jsp:useBean  id="Mobile_Goods_Proc" class="com.enuri.bean.mobile.Mobile_Goods_Proc"/>\
<%@ include file="/include/IncGroupTool_2010.jsp"%>
<%
int intKbno = ChkNull.chkInt(request.getParameter("kbno"),0);
//String strVerios = ChkNull.chkStr(request.getParameter("verios"),"");
//String strVerand = ChkNull.chkStr(request.getParameter("verand"),"");
String strFrom = ChkNull.chkStr(request.getParameter("from"),"");
String strPop = ChkNull.chkStr(request.getParameter("strpop"),"");

//에누리TV 리뷰상품,채널명,다른동영상,최신동영상 --2017-10-10 홍석정
DBDataTable dt = knowbox2_data.getView(intKbno);
DBDataTable dtSourceList = knowbox2_review_data.getEnuriTvSourceData(intKbno);
DBDataTable dtMyLatest = knowbox2_review_data.getLatestEnuriTv("my",intKbno);
DBDataTable dtOtherLatest = knowbox2_review_data.getLatestEnuriTv("other",intKbno);

int enuritvModelno = dt.parse(0, "G_MODELNO", 0);


int i_Log = 5941;
int i_Log_pad = 0;
if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") >= 0){
	i_Log = 5940;
}else if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") >= 0 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") >= 0){
	i_Log = 5939;
}else if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") >= 0){
	i_Log = 5939;
	i_Log_pad = 1;
}else{
	i_Log = 5941;
}

String strUrl = request.getRequestURI();
String newsType = "1"; //뉴스

if(strFrom.equals("guide")){
	newsType="2";
}else if(strFrom.equals("review")){
	newsType="3";
}else if(strFrom.equals("enuritv")){
	newsType="4";
}else{
	strFrom = "news";
}

javax.servlet.http.Cookie[] carr = request.getCookies();
String strAppyn = "";
String strVerios = "";
String strVerand = "";
String strAd_id = "";
String movieSource = "";
int intVerios = 0;

try {
	for(int i=0;i<carr.length;i++){
	    if(carr[i].getName().equals("appYN")){
	    	strAppyn = carr[i].getValue();
	    	break;
	    }
	}
	for(int i=0;i<carr.length;i++){
	    if(carr[i].getName().equals("verios")){
	    	strVerios = carr[i].getValue();
	    	break;
	    }
	}
	for(int i=0;i<carr.length;i++){
	    if(carr[i].getName().equals("verand")){
	    	strVerand = carr[i].getValue();
	    	//break;
	    }
	}
	for(int i=0;i<carr.length;i++){
	    if(carr[i].getName().equals("adid")){
	    	strAd_id = carr[i].getValue();
	    	break;
	    }
	}
} catch(Exception e) {}

String strApp = ChkNull.chkStr(request.getParameter("appYN"),"");
String strVerand2 = ChkNull.chkStr(request.getParameter("verand"),"");
String strVerios2 = ChkNull.chkStr(request.getParameter("verios"),"");

if(strApp.equals("Y"))	strAppyn = "Y";	

int intVerand = 0;

boolean bl_headDisplay = true;

if(strFrom.length() > 10){ 
	response.sendRedirect("/knowcom/detail.jsp?kbno="+intKbno+"&bbsname="+strFrom+"&cateno=&page=1&freetoken=shoppingknow");
	return;  
}
if(strVerand2.length() > 10){
	response.sendRedirect("/knowcom/detail.jsp?kbno="+intKbno+"&bbsname="+strFrom+"&cateno=&page=1&freetoken=shoppingknow");
	return;
}
if(strVerios2.length() > 10){
	response.sendRedirect("/knowcom/detail.jsp?kbno="+intKbno+"&bbsname="+strFrom+"&cateno=&page=1&freetoken=shoppingknow");
	return;
} 

if(!strVerand.equals("")){
	intVerand = Integer.parseInt(strVerand.replace(".",""));
	if(strVerand.length() > 10){
		response.sendRedirect("/knowcom/detail.jsp?kbno="+intKbno+"&bbsname="+strFrom+"&cateno=&page=1&freetoken=shoppingknow");
		return;
	}
} 

if(!strVerios.equals("")){
	strVerios = strVerios.replace(".","");
	if(strVerios.length() > 10){
		response.sendRedirect("/knowcom/detail.jsp?kbno="+intKbno+"&bbsname="+strFrom+"&cateno=&page=1&freetoken=shoppingknow");
		return;
	} 
	if(strVerios.length() > 3){
		strVerios = strVerios.substring(0,3);
	} 
	intVerios = Integer.parseInt(strVerios);
}

if(strPop.equals("") || strPop == null){
	if(i_Log == 5940 && intVerand > 301)		bl_headDisplay = false;
	else if(i_Log == 5939)		bl_headDisplay = false;
}
 

//앱 3.3.6 이상 || 웹일때만 신규 쇼핑지식으로 이동
if(strAppyn.equals("Y")){ 
	if(intVerand > 336 || intVerios > 336){
		response.sendRedirect("/knowcom/detail.jsp?kbno="+intKbno+"&bbsname="+strFrom+"&cateno=&page=1&freetoken=shoppingknow");
		return;
	}
}else{ 
	response.sendRedirect("/knowcom/detail.jsp?kbno="+intKbno+"&bbsname="+strFrom+"&cateno=&page=1&freetoken=shoppingknow");
	return;
} 

String strContent = "";
String strKb_regdate = "";
String strKb_factory = "";
String strKb_title = "";
String strKb_readcnt = "";
String strCategory = "";
String strCatenm = "";
String strSource = "";
int imodelno = 0;

if(intKbno < 1) return;

//카운트 +1
String strPart = "mw";

if(strAppyn.equals("Y"))	strPart = "ma";
knowbox2_data.addReadCnt_mobile(intKbno,strPart);

boolean blNews = false;	//뉴스만 아래 이전 뉴스 다음뉴스와 뉴스 미리보기 가지고 옴

JSONObject jsonObject = (JSONObject) News_Proc.getData_Kbno(intKbno);
JSONArray jsonArray = (JSONArray) jsonObject.get("NewsDetail");

JSONArray jsonOutArray = new JSONArray();

if(jsonArray != null && jsonArray.length() > 0){
	JSONObject jsonTemp = (JSONObject)jsonArray.get(0);

	strContent = StringUtils.defaultString((String)jsonTemp.get("kb_content"));

	strKb_regdate = StringUtils.defaultString((String)jsonTemp.get("kb_regdate"));
	strKb_factory = StringUtils.defaultString((String)jsonTemp.get("kb_factory"));

	if(strKb_regdate.length() > 9)		strKb_regdate = strKb_regdate.substring(0,10);

	if(strKb_factory.length() > 7){
		if(strKb_factory.substring(0,2).equals("20") &&
			( strKb_factory.substring(4,6).equals("01") || strKb_factory.substring(4,6).equals("02") || strKb_factory.substring(4,6).equals("03") || strKb_factory.substring(4,6).equals("04") ||
			  strKb_factory.substring(4,6).equals("05") || strKb_factory.substring(4,6).equals("06") || strKb_factory.substring(4,6).equals("07") || strKb_factory.substring(4,6).equals("08") ||
			  strKb_factory.substring(4,6).equals("09") || strKb_factory.substring(4,6).equals("10") || strKb_factory.substring(4,6).equals("11") || strKb_factory.substring(4,6).equals("12")
			 )
		){
			strKb_regdate = strKb_factory.substring(0,4) + "-" + strKb_factory.substring(4,6) + "-" + strKb_factory.substring(6,8);
		}else{
			strKb_factory = "";
		}
	}

	if (intKbno > 0){
		String knowboxtype = knowbox2_data.getknowboxtype(intKbno);
		
		if (knowboxtype.equals("news")){	//뉴스
			//response.sendRedirect("/knowbox2/news/view.jsp?kbno=" + String.valueOf(kbno));
			blNews = true;
		}
		if (knowboxtype.equals("guide")){	//구매가이드
			//response.sendRedirect("/knowbox2/guide/view.jsp?kbno=" + String.valueOf(kbno));
			strFrom = "guide";
		}
		if (knowboxtype.equals("review")){	//리뷰
			//response.sendRedirect("/knowbox2/review/view.jsp?kbno=" + String.valueOf(kbno));
			strFrom = "review";
		}
		if (knowboxtype.equals("qna")){	//Q&A
			//response.sendRedirect("/knowbox2/qna/view.jsp?kbno=" + String.valueOf(kbno));
		}
		if (knowboxtype.equals("nuri")){	//누리게시판
			//response.sendRedirect("/knowbox2/nuri/view.jsp?kbno=" + String.valueOf(kbno));
		}
		if (knowboxtype.equals("sale")){	//판매
			//response.sendRedirect("/knowbox2/sale/view.jsp?kbno=" + String.valueOf(kbno));
		}
		if (knowboxtype.equals("enuritv")){	//에누리TV
			strFrom = "enuritv";
			movieSource = dtSourceList.parse(0,"SOURCE_NAME","");
			//response.sendRedirect("/knowbox2/sale/view.jsp?kbno=" + String.valueOf(kbno));
		}
	}

	strKb_title = StringUtils.defaultString((String)jsonTemp.get("kb_title"));
	strKb_readcnt = StringUtils.defaultString((String)jsonTemp.get("kb_readcnt"));
	strCategory = StringUtils.defaultString((String)jsonTemp.get("g_category"));
	imodelno = Integer.parseInt( StringUtils.defaultString((String)jsonTemp.get("g_modelno")));

	//출처
	strSource = getNewsSource(StringUtils.defaultString((String)jsonTemp.get("kb_news_flag")));

	boolean isBigcate = false;
	if(strCategory.length() > 4 && strCategory.substring(2,4).equals("00")){
		isBigcate = true;
	}else if(strCategory.trim().length() == 2){
		isBigcate = true;
	}

	if(strFrom.equals("guide")){
		//ss:00은 예외 encoding
		strContent = strContent.replaceAll("ss:00;width","ss:00;eidth");
		if (strContent.indexOf("new_edit_btn_20171027") < 0) {
			strContent = strContent.replaceAll("width","!width");
			strContent = strContent.replaceAll("WIDTH","!WIDTH");
		}
		//strContent = strContent.replaceAll("style","!style");
		strContent = strContent.replaceAll("STYLE","!STYLE");
		if (strContent.indexOf("new_edit_btn_20171027") < 0) {
			strContent = strContent.replaceAll("height","!height");
			strContent = strContent.replaceAll("HEIGHT","!HEIGHT");
		}
		strContent = strContent.replaceAll("MARGIN-LEFT: 20px","MARGIN-LEFT: 5px;MARGIN-RIGHT: 5px");
		strContent = strContent.replaceAll("margin-left: 20px","margin-left: 0px");
		strContent = strContent.replaceAll("&nbsp;&nbsp;&nbsp;","&nbsp;");
		
		//기존
		if (strContent.indexOf("new_edit_btn_20171027") < 0  && strContent.indexOf("www.youtube.com") < 0) {
			strContent = strContent.replaceAll("iframe","iframe width='63px' height='24px' ");
			strContent = strContent.replaceAll("IFRAME","IFRAME width='63px' height='24px' ");
		}
				
		strContent = strContent.replaceAll("<img ","<img onerror=\"this.style.display='none'\" ");
		strContent = strContent.replaceAll("<IMG ","<IMG onerror=\"this.style.display='none'\" ");
		strContent = strContent.replaceAll("modelno=","from=guide&modelno=");
		strContent = strContent.replaceAll("http://www.enuri.com/view/Listmp3.jsp","/mobilefirst/list.jsp");
		strContent = strContent.replaceAll("http://www.enuri.com/view/include","/view/include");
		strContent = strContent.replaceAll("top.opener.top.location.href","location.href");
		strContent = strContent.replaceAll("http://www.enuri.com/p/","http://m.enuri.com/mobilefirst/detail.jsp?modelno=");

		strContent = strContent.replaceAll("MARGIN-TOP: 18px; LINE-!HEIGHT: normal","MARGIN-TOP: 18px; LINE-HEIGHT: 30px");
		//decoding
		strContent = strContent.replaceAll("ss:00;eidth","ss:00;width");

		strContent = strContent.replaceAll("WIDTH: 50px","WIDTH: 100%");
		
		strContent = strContent.replaceAll("width=50","width=100% !width=50");
		strContent = strContent.replaceAll("width=50","width=100% !width=50");
	}else{
		//out.println("strContent"+strContent);
		strContent = strContent.replaceAll("width=2","width=100% !width=2");
		strContent = strContent.replaceAll("width=3","width=100% !width=3");
		strContent = strContent.replaceAll("width=4","width=100% !width=4");
		strContent = strContent.replaceAll("width=\"4","width=100% !width=\"4");
		strContent = strContent.replaceAll("width=5","width=100% !width=5");
		strContent = strContent.replaceAll("width=6","width=100% !width=6");
		strContent = strContent.replaceAll("WIDTH: 540px","WIDTH: 100%");
		strContent = strContent.replaceAll("WIDTH: 550px","WIDTH: 100%");
		strContent = strContent.replaceAll("WIDTH: 580px","WIDTH: 100%");
		strContent = strContent.replaceAll("WIDTH: 696px","WIDTH: 100%");
		strContent = strContent.replaceAll("WIDTH: 640px","WIDTH: 100%");
		strContent = strContent.replaceAll("WIDTH: 700px","WIDTH: 100%");
		strContent = strContent.replaceAll("WIDTH: 717px","WIDTH: 100%");
		strContent = strContent.replaceAll("HEIGHT: 478px","HEIGHT: 100%");
		strContent = strContent.replaceAll("WIDTH: 478px","WIDTH: 100%");
		strContent = strContent.replaceAll("WIDTH: 484px","WIDTH: 100%");
		strContent = strContent.replaceAll("WIDTH: 475px","WIDTH: 100%");
		strContent = strContent.replaceAll("HEIGHT: 717px","HEIGHT: 100%");
		strContent = strContent.replaceAll("HEIGHT: 536px; WIDTH: 710px","WIDTH: 100%");
		strContent = strContent.replaceAll("HEIGHT: 443px; WIDTH: 710px","WIDTH: 100%");
		strContent = strContent.replaceAll("HEIGHT: 277px; WIDTH: 701px","WIDTH: 100%");
		//strContent = strContent.replaceAll("<img ","<img width=100% ");
		//strContent = strContent.replaceAll("<IMG ","<IMG width=100% ");
		strContent = strContent.replaceAll("<img ","<img onerror=\"this.style.display='none'\" ");
		strContent = strContent.replaceAll("<IMG ","<IMG onerror=\"this.style.display='none'\" ");
		strContent = strContent.replaceAll("480","100%");
		if(strFrom.equals("enuritv")){
			strContent = strContent.replaceAll("width=\"560\"","width=\"100%\"");
		}
		strContent = strContent.replaceAll("height=","!height=");
		strContent = strContent.replaceAll("http://www.enuri.com/p/","http://m.enuri.com/mobilefirst/detail.jsp?modelno=");
		strContent = strContent.replaceAll("BORDER-BOTTOM:","width:100%;BORDER-BOTTOM:");
		strContent = strContent.replaceAll("LEFT: 745px;","display:none;");
	}
	strContent = strContent.replaceAll("width:100%;BORDER-BOTTOM:","BORDER-BOTTOM:");
	strContent = strContent.replaceAll("bgColor=#f9f8f0 width=184","bgColor=#f9f8f0");

	strContent = strContent.replaceAll("WHITE-SPACE","!WHITE-SPACE");
	strContent = strContent.replace(".countBox",".countBox { font-size:23px;height:30px; }");
	//장태주 예외처리 2016-08-03
	strContent = strContent.replace("http://enuripc.com/winwinseller/online_logo.php","");

	strContent = strContent.replace("www.enuri.com/list.jsp?cate=","m.enuri.com/mobilefirst/list.jsp?freetoken=list&cate=");

	//System.out.println("isBigcate>>>>"+isBigcate);
	//System.out.println("strCategory>>>>"+strCategory);
	//System.out.println("strCategory.trim().length()>>>>"+strCategory.trim().length());
	//System.out.println("strCategory.substring(0,2)>>>>"+strCategory.substring(0,2));
	//System.out.println("strCategory.substring(0,4)>>>>"+strCategory.substring(0,4));
	//System.out.println("strCategory.substring(2,4)>>>>"+strCategory.substring(2,4));

	if(isBigcate){
		strCatenm = Category_Proc.getData_Catename(strCategory.substring(0,2), 1);
	}else{
		strCatenm = Category_Proc.getData_Catename(strCategory.substring(0,4), 2);
	}

	//검색 변경
	//http://www.enuri.com/search.jsp?&keyword=KU6190
	//http://m.enuri.com/mobilefirst/search.jsp?keyword=

	strContent = strContent.replaceAll("www.enuri.com/search.jsp","m.enuri.com/mobilefirst/search.jsp");

}

String strBigcate = "";
if(strCategory != null && strCategory.length() > 2){
	strBigcate = strCategory.substring(0,2);	
}

String strCate_title = "";
String strNews_cate = "";

if(strBigcate.equals("02") || strBigcate.equals("03") || strBigcate.equals("05") || strBigcate.equals("06") || strBigcate.equals("22") ){
	strCate_title = "디지털/가전";
	strNews_cate = "01";
}else if(strBigcate.equals("04") || strBigcate.equals("07")){
	strCate_title = "컴퓨터";
	strNews_cate = "02";
}else if(strBigcate.equals("21") || strBigcate.equals("09")){
	strCate_title = "스포츠/자동차";
	strNews_cate = "03";
}else if(strBigcate.equals("08") || strBigcate.equals("10") || strBigcate.equals("12") || strBigcate.equals("14") || strBigcate.equals("15") || strBigcate.equals("16") || strBigcate.equals("18") || strBigcate.equals("24")){
	strCate_title = "유아/라이프";
	strNews_cate = "04";
}

//이전뉴스 다음뉴스
String strBefore_kbno = "";
String strBefore_kb_title = "";
String strNext_kbno = "";
String strNext_kb_title = "";


if(blNews){
	JSONObject jSONObject = new JSONObject();
	jSONObject = News_Proc.getNews_NB(intKbno,strNews_cate, "b");
	try{
		strBefore_kbno = StringUtils.defaultString(jSONObject.getString("kb_no"));
		strBefore_kb_title = StringUtils.defaultString(jSONObject.getString("kb_title"));
		
		jSONObject = News_Proc.getNews_NB(intKbno,strNews_cate, "n");
		strNext_kbno = StringUtils.defaultString(jSONObject.getString("kb_no"));
		strNext_kb_title = StringUtils.defaultString(jSONObject.getString("kb_title"));
	}catch(Exception e){}
}


Know_box_Data[] rmdata = null; //관련상품
Goods_Data gdata = null; //상품 데이터

rmdata = Knowbox_2011_Proc.getList_RelateModel(intKbno, (imodelno>0)?imodelno:0);

String strRmdata = "";
String tmpModelnm_goodsinfo = "";
String strC_date = "";
String cur_date = ReplaceStr.replace(DateStr.nowStr(),"-","");
String strBrand = "";
String strView_modelnm = "";

if(rmdata!=null && rmdata.length>0){
	for(int i=0; i<rmdata.length; i++){
		//모바일은 minprice3 을 사용
		gdata = Mobile_Goods_Proc.Goods_One_noGroup(rmdata[i].getG_modelno());
		if(gdata!=null){
			String szModelNm = gdata.getModelnm();
			String strGoodsImg = ImageUtil.getImageSrc(gdata.getCa_code(),gdata.getModelno(),gdata.getImgchk(),gdata.getP_pl_no(),gdata.getP_imgurl(),gdata.getP_imgurlflag());
			String strPrice = "";
			if(gdata.getConstrain().equals("5")){
				strGoodsImg = gdata.getP_imgurl2().trim();
			}

			String strImageUrl_middle = strGoodsImg;

			String smallImgUrlFinder = "/data/images/service/small/";
			int smallFinderIdx = strGoodsImg.indexOf(smallImgUrlFinder);
			// 500이미지로 변경
			if(smallFinderIdx>-1) {
				strImageUrl_middle = strGoodsImg.substring(0, smallFinderIdx);
				strImageUrl_middle += "/data/images/service/middle/";
				strImageUrl_middle += strGoodsImg.substring(smallFinderIdx + smallImgUrlFinder.length());

				int lastDotIdx = strImageUrl_middle.lastIndexOf(".");
				strImageUrl_middle = strImageUrl_middle.substring(0, lastDotIdx) + ".jpg";
			}

			szModelNm = replaceModelNmSpecialChar(gdata.getCa_code(), szModelNm);
			strView_modelnm = szModelNm;
			strBrand = gdata.getBrand();

			//모델명 변경 2015.10.12.
			String[] strModelno_new = getModel_FBN(gdata.getCa_code(), szModelNm, gdata.getFactory() , gdata.getBrand() );
			strView_modelnm = strModelno_new[1] + " "+ strModelno_new[2] + " "+ strModelno_new[0];
			strView_modelnm = strView_modelnm.replace("  "," ");


			tmpModelnm_goodsinfo = ReplaceStr.replace(strView_modelnm, "[", " [");
			//strC_date = ReplaceStr.replace(gdata.getC_date(),"-","");
			strC_date = gdata.getC_date();
			if(!ChkNull.chkNumber(strC_date) || (ChkNull.chkNumber(strC_date) && (Integer.parseInt(strC_date) <= Integer.parseInt(cur_date)))){
				if( gdata.getMinprice() > 0 && gdata.getMallcnt() > 0 ){
					strPrice = FmtStr.moneyFormat(Long.toString(gdata.getMinprice()));
				}else{
					if((CutStr.cutStr(gdata.getCa_code(),4).equals("0304") || CutStr.cutStr(gdata.getCa_code(),4).equals("0305")) && gdata.getMinprice()==0 && gdata.getMallcnt() > 0){
						strPrice = "클릭";
					}else{
						strPrice = "없음";
					}
				}
			}else{
				strPrice = "가격미정";
			}

			/*
			String strCknowbox = "";
			Category_Data cdata = Category_Proc.Category_One_1(gdata.getCa_code().substring(0,4));
			if(cdata!=null && !cdata.getC_name().equals("")){
				strCknowbox = cdata.getC_knowbox();
			}
			if(iRelateIdx==0){
				out.println("<div class=\"h_10\"></div>");
				out.println("<div class=\"relategoods\">");
				out.println("<div class=\"relategoods_box_1\">");
				out.println("<div class=\"h_20\"></div>");
			}else if(iRelateIdx==1){
				out.println("<div class=\"relategoods_box_2\">");
				out.println("<div class=\"h_20\"></div>");
			}else{
				out.println("<div class=\"relategoods_box\">");
				out.println("<div class=\"h_9\"></div>");
			}
			*/

			String strViewCdate = "";
			String dateText = "";

			//strViewCdate = DateUtil.RtnDateComment(strC_date,"2010_list","");
			String strCate4 = gdata.getCa_code().substring(0,4);
			String strCate6 = gdata.getCa_code().substring(0,6);

			//날짜
			strC_date = CutStr.cutStr(strC_date,10);
			strViewCdate = DateUtil.RtnDateComment(strC_date,"2010_list","");

			if(!CutStr.cutStr(strCate4,2).equals("15")){
				if (strViewCdate.equals("예정")){
					dateText = "출시예정";
				}else{
					// 2012.03.07.imzig. 현재년도 이전 출시 상품은 출시월 정보 없이 출시년도만 표시
					int cdateYear = 0;
					int cdateMon = 0;

					if(strViewCdate.length() > 0){
						cdateYear = Integer.parseInt(strC_date.substring(0,4));
						cdateMon =  Integer.parseInt(strC_date.substring(5,7));
					}
					int nowYear = Integer.parseInt(new java.text.SimpleDateFormat("yyyy").format(new java.util.Date()));
					int nowMon = ChkNull.chkInt(DateStr.getYMD(DateStr.nowStr(),"M"));

					if( strC_date.length() > 0 ){
						if( cdateYear < nowYear) {
							if(cdateYear == nowYear-1 && cdateMon > nowMon && nowMon < 3){
								if(strViewCdate.substring(5,6).equals("0")){
									dateText = "'"+strC_date.substring(2,4)+"년 "+strC_date.substring(6,7)+"월";
								}else{
									dateText = "'"+strC_date.substring(2,4)+"년 "+strC_date.substring(5,7)+"월";
								}
							}else{
								dateText = "'"+strC_date.substring(2,4)+"년";
							}
						} else {
							if(strC_date.substring(5,6).equals("0")){
								dateText = "'"+strC_date.substring(2,4)+"년 "+strC_date.substring(6,7)+"월";
							}else{
								dateText = "'"+strC_date.substring(2,4)+"년 "+strC_date.substring(5,7)+"월";
							}
						}
					}
				}
			}

			if( gdata.getMinprice() == 0 && gdata.getMallcnt() == 0 ){
				strPrice = "단종/품절";
			}
			if(DateUtil.RtnDateComment(CutStr.cutStr(strC_date,10),"2010_list","").equals("예정")){
				strPrice = "출시예정";
			}else if(gdata.getMinprice()==0 && ( strCate4.equals("0304") || strCate4.equals("0305") || strCate4.equals("0353"))){
				strPrice = "별도확인";
			}else{
				//strPrice = FmtStr.moneyFormat(strPrice);
			}
			if(!strCate4.equals("0304") && strPrice.equals("0")){
				strPrice = "미정";
			}

			String strKeyword = gdata.getKeyword2();
			if (strKeyword.trim().length() > 0 && !strCate4.equals("0703") && !strCate4.equals("0714") && !strCate4.equals("0925") && !CutStr.cutStr(strCate4,2).equals("14") && !CutStr.cutStr(strCate4,2).equals("15")){
				//strKeyword = ReplaceStr.replace(strKeyword,"★","▶");
				strKeyword = ReplaceStr.replace(strKeyword,"★","");
				strKeyword = ReplaceStr.replace(strKeyword,"▶","");
				strKeyword = ReplaceStr.replace(strKeyword,"\"","&quot;");
			}
			if(strCate4.equals("0703") || strCate4.equals("0925") || strCate6.equals("070120") || strCate6.equals("070121") || strCate6.equals("070122") || strCate6.equals("070123")){
				strKeyword = "";
			}

			strRmdata += "<li>";
			strRmdata += "<a href=\"javascript:///\" onclick=\"go_detail('"+ rmdata[i].getG_modelno() +"');\" class=\"listarea\">";
			strRmdata += "<span class=\"thum\"><img src=\""+ strImageUrl_middle +"\" onerror=\"this.src='"+strGoodsImg+"'\" alt=\"\" /></span>";
			strRmdata += "<div>";
			strRmdata += "	<span class=\"com\"><em></em><em style='float:right;'>"+dateText+"</em></span>";
			strRmdata += "	<strong>"+ tmpModelnm_goodsinfo +"</strong>";
			strRmdata += "	<em class=\"shop\"></em>";
			if(strPrice.equals("출시예정") || strPrice.equals("별도확인") || strPrice.equals("미정")){
				strRmdata += "	<span class=\"price\"><em class=\"release\">"+ strPrice +"</em></span><!-- 150408 shop_p 추가 -->";
			}else if(strPrice.equals("단종/품절")){
				strRmdata += "	<span class=\"price\"><em class=\"soldout\">"+ strPrice +"</em></span><!-- 150408 shop_p 추가 -->";
			}else{
				strRmdata += "	<span class=\"price\"><span class=\"min\">최저가</span><em>"+ strPrice +"<em>원</em></em></span><!-- 150408 shop_p 추가 -->";
			}
			strRmdata += "</div>";
			strRmdata += "</a>";
			strRmdata += "</li>";
		}
	}
}
String strTitle = "뉴스";
String strSnsImg = ConfigManager.IMG_ENURI_COM + "/images/mobilenew/images/enuri_news_kakao.jpg";

if(strFrom.equals("guide")){
	strTitle = "구매가이드";
	strSnsImg = ConfigManager.IMG_ENURI_COM + "/images/mobilenew/images/enuri_guide_kakao.jpg";
}
if(strFrom.equals("review")){
	strTitle = "리뷰&사용기";
	strSnsImg = ConfigManager.IMG_ENURI_COM + "/images/mobilenew/images/enuri_review_kakao.jpg";
}
if(strFrom.equals("enuritv")){
	strTitle = "에누리TV";
	//strSnsImg = ConfigManager.IMG_ENURI_COM + "/images/mobilenew/images/enuri_review_kakao.jpg";	//에누리TV SNS용 이미지 요청하기
}
String Referer = request.getHeader("referer");
%>
<!DOCTYPE html>
<html lang="ko" style="overflow-x:hidden">
<head>
	<meta charset="utf-8">
<% if(bl_headDisplay){ %>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
<% }else{ %>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0" />
<% }%>
	<meta property="og:title" content="[에누리 가격비교]">
	<meta property="og:image" content="<%=strSnsImg%>">
	<meta property="og:description" content="<%=strKb_title %> 보러가기!">
	<%@include file="/mobilefirst/renew/include/common.html"%>
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/home/trend.css"/><!-- 트렌트 메뉴 추가-->
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/home/common.css"/>
	<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js"></script>
	<script async src="https://s.imgur.com/min/embed.js" charset="utf-8"></script>
	<script>
	(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
	(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
	m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
	})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
	//런칭할때 UA-52658695-3 으로 변경
	ga('create', 'UA-52658695-3', 'auto');
	</script>
	<style>
	img {
		max-width: 100%;
		height: auto;
	}
	div {
		max-width: 100%;
	}
	.news.news_view .txt_area img { width:auto !important;}
<%
if(intKbno ==  592797 || intKbno == 594400 || intKbno == 596327){
	out.println(".youtubeBox { display:none;}");
	out.println(".youtubeMiddleBox { display:none;}");
	out.println(".news_wrap { overflow: hidden;}");
} %>
	</style>
</head>
<body style="overflow-x:hidden">
<!-- sns 공유 -->
<div class="layerPop_sns" id="snsPop">
	<div class="layerPopInner">
		<div class="layerPopCont">
			<h1 id="layerPopCont_txt">SNS 공유</h1>
			<button class="btnClose" onclick="$('#snsPop').hide();$('html, body').removeClass('dimdOn');">SNS 공유 창 닫기</button>
			<div class="contents">
				<div class="linkList">
					<ul>
						<li><a href="javascript:///" class="kakao" id="kakao-link-btn">카카오톡</a></li>
						<li><a href="javascript:///" class="facebook">페이스북</a></li>
						<li><a href="javascript:///" class="url">URL</a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="layerPop_sns" id="layer_geturl">
	<div class="layerPopInner">
		<div class="layerPopCont">
			<h1>URL 복사</h1>
			<button class="btnClose" type="button" onclick="$('#layer_geturl').hide();">창 닫기</button>
			<div class="contents">
				<p class="url_txt">
					<span id="url_text">아래의 URL을 두번 누르면 복사할 수 있습니다.</span>
					<span class="input_copy"><input type="text" class="urlCopy" id="txt_getUrl" value=""></span>
				</p>
			</div>
			<div class="layerBtn"><button class="btnTxt" type="button" id="btt_close" onclick="$('#layer_geturl').hide();">닫기</button></div>
		</div>
	</div>
	<div class="dim"></div>
</div>
<div id="wrap">
	<section class="news news_view <%=(strAppyn.equals("Y")?"app":"") %>">
		<div class="newsbox">
			<h2 id="news_head">
				<%if(strFrom.equals("enuritv")){%>
					<%=strTitle %>
				<%}else{%>
					<%=strCatenm %> <%=strTitle %>
				<%}%>
				<a href="javascript:///" class="close ico_m">창닫기</a>
			</h2>
			<p class="tit_area">
				<%=strKb_title %>
				<span class="date">
				<%if(strFrom.equals("enuritv")){%>
					<%=movieSource%> |
				<%}%>
				<%=strKb_regdate %><% if(!strKb_readcnt.equals("")){ %> | 조회수: <%=toNumFormat(strKb_readcnt) %>	<% } %>
				<a href="javascript:///" class="sns_share2 ico_m">공유하기</a></span>
			</p>
			<!-- 모델 -->
			<% if (enuritvModelno > 0) {
				Goods_Search_Lsv_Proc goods_Search_Lsv_Proc = new Goods_Search_Lsv_Proc();					
				Goods_Data goods_data = goods_Search_Lsv_Proc.Goods_One(dt.parse(0, "G_MODELNO", 0), 0);
		
				if (goods_data != null) {
		        String szCategory       = goods_data.getCa_code();
		        //String strImageChk      = goods_data.getImgchk();
		        //long intP_plno        	= goods_data.getP_pl_no();
		       // String strPImageUrl     = goods_data.getP_imgurl().trim();
		        //String strPImageUrlFlag = goods_data.getP_imgurlflag().trim();
		        long mMinPrice        	= goods_data.getMinprice();
		        long mMinPrice3        	= goods_data.getMinprice3();
		        String strModelNm       = goods_data.getModelnm();
		       // String strBrand         = goods_data.getBrand();
		        String strFactory       = goods_data.getFactory();
		        long mallcnt 			= goods_data.getMallcnt();
		        //long mallcnt3 			= goods_data.getMallcnt3();
		        boolean priceYN = false;
		
		        if (strFactory.trim().length() > 14 ){
		            strFactory = CutStr.cutStr(strFactory,14);
		        }
		
		        strModelNm = ReplaceStr.replace(strModelNm,"\"","&quot");
		        strModelNm = ReplaceStr.replace(strModelNm,"[일반]","");
		        strModelNm = ReplaceStr.replace(strModelNm,"["," [");
		
		        String strCdate         = goods_data.getC_date();
		        strCdate 				= CutStr.cutStr(strCdate,10);
		        String strMPrice        = "";
		        //String strDetailUrl     = "";
		        String strModelImage    = "";
		
		        if(goods_data.getOpenexpectflag().equals("1")) {
		            strMPrice = "미정";
		        } else if(mallcnt==0) {
		            strMPrice = "일시품절";
		        } else {
		            if (mallcnt==1 && DateUtil.getDaysBetween(strCdate,DateStr.nowStr())>0){
		                strMPrice = "미정";
		            }else{
		                if ((CutStr.cutStr(szCategory,4).equals("0304") || CutStr.cutStr(szCategory,4).equals("0305") || CutStr.cutStr(szCategory,4).equals("0353")) && mMinPrice == 0){
		                    strMPrice = "클릭";
		                }else{
		                	if(mMinPrice3<=0){
		                    	strMPrice = FmtStr.moneyFormat(mMinPrice+"");
		                	}else{
		                		strMPrice = FmtStr.moneyFormat(mMinPrice3+"");
		                	}
		                    priceYN = true;
		                }
		            }
		        }
		
		        strModelImage =  ImageUtil_lsv.getImageSrc(goods_data);
		        //String strAdultCookie = "";
		        //if (cb.GetCookie("MEM_INFO","ADULT") != null){
		         //   strAdultCookie = cb.GetCookie("MEM_INFO","ADULT");
		        //}
		
		       // if (strFactory.equals("[추가]")){
		         //   strFactory = "";
		        //}
		               	          
				//String strShopName = "";
				String strGoodsName = getModel_FBN(szCategory,strModelNm,strFactory,strBrand)[1] + " " + getModel_FBN(szCategory,strModelNm,strFactory,strBrand)[2] + " " + getModel_FBN(szCategory,strModelNm,strFactory,strBrand)[0];           
			%>
			<!-- 171010 리뷰상품 -->
			<div class="newsproduct_wrap enuritv">
				<h3 style = "font-size:14px">리뷰 상품</h3>
				<ul class="product_box">
					<li>
						<a class="listarea" href="/detail.jsp?modelno=<%=dt.parse(0, "G_MODELNO", 0) %>" target="_block">
							<span class="thum"><img src="<%= strModelImage %> " /></span>
							<div>
								<strong><%= strGoodsName %></strong>
								<span class="price"><span class="min">최저가</span><em><%=strMPrice%><em><%= priceYN==true ? "원" : "" %></em></em></span>
							</div>
						</a>
					</li>	
				</ul>
			</div>
			<!--// 171010 리뷰상품 -->
			<!-- // 모델 -->
			<%
				}
			}
			%>
			<div class="txt_area news_wrap">
				<%=strContent %>
			</div>
			<ul class="link_area" id="before_next">
				<li <% if(strBefore_kbno.equals("") || strBefore_kbno.equals("0")){%>style="display:none;"<%}else{ %> onclick="show_detail('news_detail.jsp?kbno=<%=strBefore_kbno %>');fnGa('mf_쇼핑뉴스','click_상세보기','상세보기_이전기사');"<% } %>>
					<span class="right" kbno="<%=strBefore_kbno %>" >이전 글</span><strong><%=strBefore_kb_title%></strong>
				</li>
				<li <% if(strNext_kbno.equals("") || strNext_kbno.equals("0")){%>style="display:none;"<%}else{ %> onclick="show_detail('news_detail.jsp?kbno=<%=strNext_kbno %>');fnGa('mf_쇼핑뉴스','click_상세보기','상세보기_다음기사');"<% } %>>
					<span class="left" kbno="<%=strNext_kbno %>" >다음 글</span><strong><%=strNext_kb_title%></strong>
				</li>
			</ul>
		</div>
		<!-- 171010 다른 동영상 -->
		<%if(strFrom.equals("enuritv") && dtMyLatest.count() >= 1){%>
			<div class="newsbox enuritv"> 
				<h4 class="vod_tit"><em><%=movieSource%></em> 다른 동영상</h4>
				<div class="hit_scroll">
					<div class="hit_List_area">
						<ul class="hit_product">
						<% 
							int latest_title_max = 35;
							for (int i=0;i<dtMyLatest.count();i++){
								String imgsrc_rss = dtMyLatest.get(i).get("rss_thumbnail");
								//out.println("imgsrc_rss: "+imgsrc_rss);
								String myLatest_title = dtMyLatest.get(i).get("kb_title");
								if(myLatest_title.length()>latest_title_max){
									myLatest_title = myLatest_title.substring(0, latest_title_max);
									myLatest_title += "...";
								}
								
						%>
							<li>
								<a href="http://www.enuri.com/mobilefirst/news_detail.jsp?kbno=<%=dtMyLatest.get(i).get("kb_no")%>" onclick="insertLog(16072);">
								
								<%
								if(imgsrc_rss!=null && imgsrc_rss.length()>0 ){
									//out.println("null...");
									if(!imgsrc_rss.isEmpty()){
										//out.println("isEmpty~~~");
								%>
									<img src="<%=imgsrc_rss%>" class="thum">
								<%
									}
								} else {
								%>
									<img src="http://img.youtube.com/vi/<%=dtMyLatest.get(i).get("movie_id")%>/mqdefault.jpg" class="thum">
								<%
								}
								%>
								</a>
								<a href="http://www.enuri.com/mobilefirst/news_detail.jsp?kbno=<%=dtMyLatest.get(i).get("kb_no")%>" onclick="insertLog(16072);">
								<span class="tit">
									<%=dtMyLatest.get(i).get("show_name")%>
								</span>
								</a>
								<strong>
									<a href="http://www.enuri.com/mobilefirst/news_detail.jsp?kbno=<%=dtMyLatest.get(i).get("kb_no")%>" onclick="insertLog(16072);"><%=myLatest_title%></a>
								</strong>
								<em  class="num">조회수 : <%=dtMyLatest.get(i).get("kb_readcnt") %></em>
							</li>
						<%} // end of list loop %>
					</ul>
					</div>
				</div>
			</div>
		<%}%>
		<!-- 171010 최신 동영상 -->
		<%if(strFrom.equals("enuritv") && dtOtherLatest.count() >= 1){%>
			<div class="newsbox enuritv"> 
				<h4 class="vod_tit">최신 동영상</h4>
				<div class="hit_scroll">
					<div class="hit_List_area">
						<ul class="hit_product">
						<% 
							int latest_title_max = 35;
							for (int i=0;i<dtOtherLatest.count();i++){
								String imgsrc_rss = dtOtherLatest.get(i).get("rss_thumbnail");
								//out.println("imgsrc_rss: "+imgsrc_rss);
								String otherLatest_title = dtOtherLatest.get(i).get("kb_title");
								if(otherLatest_title.length()>latest_title_max){
									otherLatest_title = otherLatest_title.substring(0, latest_title_max);
									otherLatest_title += "...";
								}
								
						%>
							<li>
								<a href="http://www.enuri.com/mobilefirst/news_detail.jsp?kbno=<%=dtOtherLatest.get(i).get("kb_no")%>" onclick="insertLog(16072);">
								
								<%
								if(imgsrc_rss!=null && imgsrc_rss.length()>0 ){
									//out.println("null...");
									if(!imgsrc_rss.isEmpty()){
										//out.println("isEmpty~~~");
								%>
									<img src="<%=imgsrc_rss%>" class="thum">
								<%
									}
								} else {
								%>
									<img src="http://img.youtube.com/vi/<%=dtOtherLatest.get(i).get("movie_id")%>/mqdefault.jpg" class="thum">
								<%
								}
								%>
								</a>
								<a href="http://www.enuri.com/mobilefirst/news_detail.jsp?kbno=<%=dtOtherLatest.get(i).get("kb_no")%>" onclick="insertLog(16072);">
									<span class="tit"><%=dtOtherLatest.get(i).get("show_name")%></span>
								</a>
								<strong>
									<a href="http://www.enuri.com/mobilefirst/news_detail.jsp?kbno=<%=dtOtherLatest.get(i).get("kb_no")%>" onclick="insertLog(16072);"><%=otherLatest_title%></a>
								</strong>
								<em  class="num">조회수 : <%=dtOtherLatest.get(i).get("kb_readcnt") %></em>
							</li>
						<%} // end of list loop %>
					</ul>
					</div>
				</div>
			</div>
		<%}%>
		
		<% if(strRmdata.length() > 100){ %>
			<div class="newsproduct_wrap">
			<% if(strFrom.equals("guide")){ %>
				<h3 class="">관련된 상품</h3>
			<% }else{ %>
				<h3 class="">기사와 관련된 상품</h3>
			<% } %>
				<ul class="product_box">
					<%=strRmdata %>
				</ul>
			</div>
		<% } %>
		<!-- 170809 해당 카테 구매가이드 노출 -->
		<div class="newsbox" id="goodtip"> 
			<h3 class="view_tit"></h3>
			<div class="hit_scroll">
				<div class="hit_List_area">
					<ul class="hit_product">
					</ul>
				</div>
			</div>
		</div>
		<!--// 170809 해당 카테 구매가이드 노출 -->
		<div class="newsbox" id="news_review">
			<h3 id="hotnews_title"></h3>
			<ul class="hotnews"></ul>
		</div>
	</section>
</div>
</body>
</html>
<script language="javascript">
var strCatenm = "<%=strCatenm%>";
var vAppyn = "<%=strAppyn%>";
var strCatenm_all = "<%=strCatenm%> <%=strTitle %>";
Kakao.init('5cad223fb57213402d8f90de1aa27301');
<%
String str = strKb_title.replaceAll("'", "\'");
str = str.replaceAll("\"","\\\\\"");
str = str.trim();
%>
var SNS_URL = window.location;// 현재 페이지
var varSNSURL = "";
var imgSNS = "<%=strSnsImg%>";

var vBig_Category = "<%=strBigcate %>";
var vCate_title = "<%=strCate_title %>";
var vCate = "<%=strNews_cate %>";
var json_cate;

var referer = "<%=Referer%>";

$(function(){
	try{
		if(window.android){
			window.android.getGuideTitle(strCatenm);
			window.android.getGuideTitle_all(strCatenm_all);
		}else{
			if(vAppyn == "Y" && '<%=strFrom%>' == 'review'){
				strCatenm = "사용기";
			}
		}
	}catch(e){}
	$("#guidevideo").width("100%");
	$("#guidevideo").height("100%");
	var app = getCookie("appYN"); //app인지 여부
	var news_type = "<%=newsType%>";
	var vEvent_page = "<%=strUrl%>"; 
	 if(app =='Y' ){  
		 if(news_type=='1'){
			ga('send', 'pageview', {'page': vEvent_page,'title': '뉴스상세_APP'});	
		 }else if(news_type=='2'){
				ga('send', 'pageview', {'page': vEvent_page,'title': '가이드상세_APP'});	
		 }else if(news_type=='3'){
				ga('send', 'pageview', {'page': vEvent_page,'title': '리뷰상세_APP'});	
		 }
	 }else{        
		 if(news_type=='1'){
				ga('send', 'pageview', {'page': vEvent_page,'title': '뉴스상세_WEB'});	
			 }else if(news_type=='2'){
					ga('send', 'pageview', {'page': vEvent_page,'title': '가이드상세_WEB'});	
			 }else if(news_type=='3'){
					ga('send', 'pageview', {'page': vEvent_page,'title': '리뷰상세_WEB'});	
			 }
	 } 
	
	<% if(bl_headDisplay){ %>
		$(".news.news_view").removeClass("app");
	<% }else{ %>
		if(vAppyn == "Y"){
			$(".news.news_view").addClass("app");
		}else{
			$(".news.news_view").removeClass("app");
		}
	<% } %>
	$("img").each(function(){		$(this).css("height","auto");	});
	$(".close").on('click', function(){
    	fnGa('mf_쇼핑뉴스','click_상세보기','상세보기_닫기');
    	if(vAppyn != 'Y'){	// 웹에서 호출
    		if(  document.referrer && (  document.referrer.indexOf("news_detail.jsp") > -1 || document.referrer.indexOf("shoppingTips_all.jsp") > -1  )){
    			history.back(-1);
    		}else{
    			window.close();
    			return false;
    		}
    	}else{
    		// 앱에서 호출
	    	if(window.android){		// 안드로이드
	    		window.location.href = "close://";
	    	}else{					// 아이폰에서 호출
	    		if("<%=strPop%>" != 'Y')	history.back();
	    		else	window.location.href = "close://";
	    	}
    	}
    });

	$(".sns_share2").on('click', function(){
		if(varSNSURL == "")			CmdShare();
    	if(vAppyn == "Y" && window.android){
    	    var snsurl = varSNSURL.replace("%","%25");
    		var vTitle = "<%=str%>";
    		var snstile = vTitle.replace("%","%25")

			location.href = "shareintent://[에누리 가격비교]\n "+snstile+" 보러가기!\n "+snsurl;
		}else{
			$('#snsPop').show();
		}
    	fnGa('mf_쇼핑뉴스','click_상세보기','상세보기_공유');
    });

	$(".kakao").on('click', function(){
		Share_detail('kakao');
	});
	$(".facebook").on('click', function(){
		Share_detail('face');
	});
	$(".url").on('click', function(){
		Share_detail('copy');
	});

	//앱오류 때문에 srp 페이지로 가는 버튼은 삭제
	if(vAppyn == 'Y'){
	   var newswrap = $(".news_wrap").html();
       if(newswrap.indexOf("/guide/btn_detailmulti.gif") > -1){
            $(".news_wrap  p").each(function(i , v){
                $value = v;
                if(  v.outerHTML.indexOf("http://m.enuri.com/mobilefirst/search.jsp?") > -1 ){
                    v.parentNode.removeChild(v);
                }
            });
       }
	}
	//이미지 고정 싸이즈 100% 변경
	$(".news_wrap > p > a > img").css("width","100%");
	$(".news_wrap > p > img").css("width","100%");
	
	//$(".news_wrap > table  tbody  tr  td ").css("width","");
	var width = $(".news_wrap > table  tbody > tr >td ").css("width");

	$("img").css("max-width","");

	$("#hotnews_title").html(vCate_title + " 인기뉴스<em class=\"all\" id=\"hotnews_allview\">전체보기</em>");

	$("#hotnews_allview").click(function(){
		//업로드전에 수정
		if(vAppyn == 'Y'){
			location.href = "/mobilefirst/api/main/newsTab_all.jsp?tab="+ vCate  +"&newpage=Y&freetoken=newslistpage";
		}else{
			location.href = "/mobilefirst/renew/shoppingNews_all.jsp?tab="+ vCate;
		}
		fnGa('mf_쇼핑뉴스','click_상세보기','상세보기_인기뉴스_전체보기');
	});

	json_cate = (function() {
	    var json = null;
	    $.ajax({
	        'async': false,
	        'global': false,
	        'url': "/mobilefirst/ajax/main/getNews_cate_cnt.jsp",
	        'data' : {"cate" : vCate},
	        'dataType': "json",
	        'success': function (data) {
	            json = data;
	        }
	    });
	    return json;
	})();

	<% if(!strFrom.equals("guide") && !strFrom.equals("review")){ %>
		getNews_cate();
	<% }else{ %>
		$("#before_next").hide();
		$("#news_review").hide();
	<% } %>
	//쇼핑팁
	getShoppinTip(vCate);
	
});
function getShoppinTip(vCate){
	
	if( vCate == 'undefinde' || vCate == '' ) return false;
	
	$.ajax({  
		type: "POST",
		dataType:"json",
		url: "/mobilefirst/ajax/main/ajax_getShoppingTip.jsp?cate="+vCate,   
		success: function(json){
			
			var htmlgoods = "";	
			$.each(json,function(i,v){
				
				    htmlgoods += "<li data-id='"+v.kbno+"'>";
					htmlgoods += "<a href='javascript:///'>";
					htmlgoods += "<img src='"+v.mo_img+"' class='thum'/>";
					htmlgoods += "<strong>"+v.name+"</strong>";
					htmlgoods += "</a>";
					htmlgoods += "</li>";
					
			});
			$(".view_tit").html(vCate_title+" <b>잘사는TIP</b>");
			$("#goodtip .hit_product").html(htmlgoods);
		},
        complete : function() {
        	$("#goodtip .hit_product > li ").click(function(){
        		var kbno = $(this).attr("data-id");
        		ga('send', 'event', 'mf_쇼핑뉴스', 'click_상세보기', '상세보기_'+vCate_title+'_구매가이드_'+kbno);
        		location.href = "/mobilefirst/news_detail.jsp?freetoken=news&from=guide&kbno="+kbno;
        		return false;
        	});
        }
	});
}
function fnGa(pCate,pAction,pLabel){
	ga('send', 'event', pCate, pAction, pLabel);
}
function getNews_cate(){

	var template = "";

    if(json_cate.length > 0){
		for(var i = 0;i<json_cate.length;i++){
			var vTmpImg = setImg(json_cate[i].mo_img,json_cate[i].mo_img2,json_cate[i].rss_thumbnail);

			template += "<li onclick=\"fnGa('mf_쇼핑뉴스','click_상세보기','상세보기_인기뉴스_"+ json_cate[i].kb_no +"');show_detail('news_detail.jsp?kbno="+ json_cate[i].kb_no +"');\">";
			if(vTmpImg != ""){
				template += "<span class=\"thum\"><img src=\""+ vTmpImg +"\" alt=\"\" /></span>";
			}
			template += "<strong>"+ json_cate[i].kb_title +"</strong>";
			template += setMmdd(json_cate[i].kb_regdate.substring(5,10));
			if(json_cate[i].source != "" && typeof json_cate[i].source != "undefined"){
				template += " | "+ json_cate[i].source;
			}
			template += "</li>";
		}

		if(template != ""){
			$(".hotnews").html(template);
		}
    }
}

function setImg(mo_img,mo_img2,rss_thumbnail){
	var vRtn_img = "";
	if(mo_img != "")		vRtn_img = "http://storage.enuri.info/pic_upload/enurinews/"+ mo_img;
	else if(mo_img2 != "")		vRtn_img = "http://storage.enuri.info/pic_upload/enurinews_mobile/"+ mo_img2;
	else if(rss_thumbnail != "")		vRtn_img = rss_thumbnail;
	return vRtn_img;
}
function setMmdd(date){
	var mm = date.substring(0,2);
	var dd = date.substring(3,5);

	return parseInt(mm) + "월 " + parseInt(dd) + "일";
}
function show_detail(url){
	<% if(strAppyn.equals("Y")){ %>
		location.href = url + "&appYN=<%=strAppyn%>";
	<% }else{ %>
		location.href = url;
	<% } %>
}
function go_detail(modelno){
	
	ga('send', 'event', 'mf_쇼핑뉴스', 'click_상세보기', '상세보기_관련상품');
	
	if(window.android){
		location.href = "/mobilefirst/detail.jsp?modelno="+modelno;
	}else{
	<% if(!strVerios.equals("")){ %>
		location.href = "/mobilefirst/detail.jsp?modelno="+modelno;
	<% }else{ %>
		try{
			opener.location.href = "/mobilefirst/detail.jsp?modelno="+modelno;
			window.close();
		}catch(e){
			location.href = "/mobilefirst/detail.jsp?modelno="+modelno;
		}
	<% } %>
	}
}
function Share_detail(param){
	var share_url = varSNSURL;
	var share_title = "[에누리 가격비교]\n<%=str%> 보러가기!";

	if(param == "face"){
		try{
			window.android.android_window_open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(share_title)+"&u="+share_url);
			//ga("send", "event", "mf_event", vEvent_title +"_APP", "공유하기_페이스북");
		}catch(e){
			window.open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(share_title)+"&u="+share_url);
			//ga("send", "event", "mf_event", vEvent_title +"_WEB", "공유하기_페이스북");
		}
	}else if(param == "kakao"){
		try{
			Kakao.Link.sendTalkLink({
				label: share_title,
				image: {
					src: imgSNS,
					width: '380',
					height: '198'
			    },
			    webButton: {
			    	text: "상세정보 보기",
					url: share_url
				},
				fail : function() {
				    alert("카카오 톡이 설치 되지 않았습니다.");
				}
		    });
		}catch(e){
			alert("카카오 톡이 설치 되지 않았습니다.");
		}
	}else if(param == "copy"){
		var ua = navigator.userAgent.toLowerCase();
		var isAndroid = ua.indexOf("android") > -1;
		if(isAndroid) {
			$("#url_text").text("아래의 URL을 길게 누르면 복사할 수 있습니다.");
		}else{
			$("#url_text").text("아래의 URL을 두번 누르면 복사할 수 있습니다.");
		}
		$("#layer_geturl").show();

		var layerPopHeight = $("#layer_geturl").find('.layerPopInner').height();
		$("#layer_geturl").find('.layerPopInner').css('margin-top','-'+ layerPopHeight / 2 + 'px' );

		$("#txt_getUrl").val(share_url);

		$('.layerPop').append('<div class="dimmed"></div>');
		$('html, body').addClass('dimdOn');
	}
}
function getCookie(c_name) {
	var i,x,y,ARRcookies=document.cookie.split(";");
	for(i=0;i<ARRcookies.length;i++) {
		x = ARRcookies[i].substr(0,ARRcookies[i].indexOf("="));
		y = ARRcookies[i].substr(ARRcookies[i].indexOf("=")+1);
		x = x.replace(/^\s+|\s+$/g,"");
		if(x==c_name) {
			return unescape(y);
		}
	}
}
function CmdShare(){
	varSNSURL = "m_url="+SNS_URL;
	varSNSURL = varSNSURL.replace("http://www.enuri.com","http://m.enuri.com");
	varSNSURL = varSNSURL.replace("app=Y","app=");
	varSNSURL = varSNSURL.replace("?app=?","?");
	varSNSURL = varSNSURL.replace("m_url=","");

	var url = "/url_check/Short_Url_Rtn.jsp";
	var param2 = "org_url="+varSNSURL;

	var Dns;
	Dns = location.href;
	Dns = Dns.split("//");
	Dns = "http://"+Dns[1].substr(0,Dns[1].indexOf("/"));

	$.ajax({
		type: "POST",
		url: url,
		data: param2,
		async : false,
		success: function(result){
			varSNSURL = Dns+"/short/"+result.trim();
		}
	});

	try{
		Kakao.Link.createTalkLinkButton({
			container: '#kakao-link-btn',
			label: "[에누리 가격비교]\n<%=str%> 보러가기!",
			image: {
				src: imgSNS,
				width: '380',
				height: '198'
		    },
		    webButton: {
		    	text: "상세정보 보기",
				url: varSNSURL
			}
	    });
	}catch(e){
		//alert(e);
	}
}

function Main_OpenWindow(OpenFile,name,nWidth,nHeight,ScrollYesNo,ResizeYesNo,TPosition,LPosition)
{
	var newWin = window.open(OpenFile,name,"width="+nWidth+",height="+nHeight+",toolbar=no,directories=no,status=no,scrollbars="+ ScrollYesNo +",resizable="+ ResizeYesNo +",menubar=no,Top="+ TPosition +",left="+ LPosition);
	newWin.focus();
}
/*[싱크미디어- 모비팜] 광고 제거 20160525
if(vAppyn != "Y"){
	document.write("<scr"+"ipt src='http://sp1.jssearch.net/script/script_168.js' charset='utf-8'></sc"+"ript>");
}
*/
</script>
<%!
public String getNewsSource(String flag){
	String getSource="";
	if(flag.equals("1"))				getSource="전자신문";
	else if(flag.equals("2"))			getSource="시앙스";
	else if(flag.equals("3"))			getSource="연합뉴스";
	else if(flag.equals("4"))			getSource="AVprime";
	else if(flag.equals("5"))			getSource="베타뉴스";
	else if(flag.equals("6"))			getSource="에누리";
	else if(flag.equals("7"))			getSource="바이킹";
	else if(flag.equals("8"))			getSource="유투브";
	else if(flag.equals("9"))			getSource="피씨비(뉴스)";
	else if(flag.equals("a"))			getSource="더아이오토";
	else if(flag.equals("A"))			getSource="글로벌오토";
	else if(flag.equals("B"))			getSource="시티신문";
	else if(flag.equals("c"))			getSource="케이벤치";
	else if(flag.equals("C"))			getSource="보도자료";
	else if(flag.equals("d"))			getSource="데일리카";
	else if(flag.equals("D"))			getSource="지디넷코리아";
	else if(flag.equals("e"))			getSource="게임메카";
	else if(flag.equals("E"))			getSource="피씨비(동영상)";
	else if(flag.equals("f"))			getSource="패션서울";
	else if(flag.equals("F"))			getSource="에누리(동영상)";
	else if(flag.equals("G"))			getSource="벤치클럽";
	else if(flag.equals("H"))			getSource="노트포럼";
	else if(flag.equals("I"))			getSource="ITCM";
	else if(flag.equals("J"))			getSource="위드포켓";
	else if(flag.equals("K"))			getSource="키뉴스";
	else if(flag.equals("L"))			getSource="PC사랑";
	else if(flag.equals("M"))			getSource="뉴스와이어";
	else if(flag.equals("N"))			getSource="SeeKo";
	else if(flag.equals("O"))			getSource="뉴스탭";
	else if(flag.equals("p"))			getSource="플레이웨어즈";
	else if(flag.equals("P"))			getSource="리뷰진";
	else if(flag.equals("Q"))			getSource="테크홀릭";
	else if(flag.equals("R"))			getSource="아이뉴스";
	else if(flag.equals("S"))			getSource="더 팩트";
	else if(flag.equals("T"))			getSource="기어박스";
	else if(flag.equals("U"))			getSource="베이비뉴스";
	else if(flag.equals("V"))			getSource="리드맘";
	else if(flag.equals("W"))			getSource="IT 동아";
	else if(flag.equals("X"))			getSource="WAPY";
	else if(flag.equals("Y"))			getSource="브레인박스";
	else if(flag.equals("Z"))			getSource="보드나라";

	return getSource;
}
/**
 * 숫자에 천단위마다 콤마 넣기
 * @param int
 * @return String
 * */
public String toNumFormat(String strNum) {
	DecimalFormat df = new DecimalFormat("#,###");
	int intNum = 0;
	if(!strNum.equals("")){
		intNum = Integer.parseInt(strNum);
	}
	return df.format(intNum);
}
%>