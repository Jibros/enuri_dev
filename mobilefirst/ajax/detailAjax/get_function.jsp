<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.mobile.Mobile_Goods_Proc"%>
<%@ page import="com.enuri.bean.main.Goods_Data"%>
<%@ page import="com.enuri.bean.knowbox.Know_termdic_title_Proc"%>
<%@ page import="com.enuri.bean.knowbox.Know_termdic_title_Data"%>
<%@ page import="com.enuri.bean.main.Detail_Notice_Data"%>
<%@ page import="com.enuri.bean.main.Detail_Notice_Proc"%>
<jsp:useBean id="Goods_Data" class="com.enuri.bean.main.Goods_Data" scope="page" />
<jsp:useBean id="Mobile_Goods_Proc" class="com.enuri.bean.mobile.Mobile_Goods_Proc" scope="page" />
<jsp:useBean id="Know_termdic_title_Proc" class="Know_termdic_title_Proc" scope="page" />
<jsp:useBean id="Detail_Notice_Data" class="com.enuri.bean.main.Detail_Notice_Data" scope="page" />
<jsp:useBean id="Detail_Notice_Proc" class="com.enuri.bean.main.Detail_Notice_Proc" scope="page" />
<%
int intModelno = ChkNull.chkInt(request.getParameter("modelno"),0);
int intMode = ChkNull.chkInt(request.getParameter("mode"),0);

Goods_Data spec_view = null;
spec_view = Mobile_Goods_Proc.Goods_One(intModelno);

String strModelnm = "";
String strFactory = "";
String strFunc = "";
String strCa_code = "";
String strFontSize = "10pt";
String strLineHeight = "";
String strFunc_detail = "";
String strFunc_temp = "";

if(spec_view != null){
	strModelnm = spec_view.getModelnm();
	strFactory = spec_view.getFactory();
	strFunc = spec_view.getFunc();
	strFunc_temp = spec_view.getFunc();
	strCa_code = spec_view.getCa_code();
}

// 상품설명이 카피문구만 있을 경우 보여주지 않음
if(strFunc.indexOf("▶")>-1 && strFunc.length()<610 && strFunc.indexOf("\r\n\r\n")<0) {
	strFunc = "";
}
// 상품설명없이 추가설명만 있는경우
if(strFunc.indexOf("<추가 설명>")>0 && strFunc.substring(0, strFunc.indexOf("<추가 설명>")).indexOf("^")<0 && strFunc.substring(0, strFunc.indexOf("<추가 설명>")).indexOf("※")<0){
	if(strFunc.indexOf("<주의사항") > -1) {
	}else{ 
		strFunc = strFunc.substring(strFunc.indexOf("<추가 설명>"));
	}
}


String[] deleteStrList = {"<주의사항1>\r\n", "<주의사항2>\r\n", "<주의사항3>\r\n", "<주의사항4>\r\n", "<주의사항5>\r\n", "<주의사항6>\r\n", "<주의사항7>\r\n", "<주의사항8>\r\n", "<주의사항9>\r\n", "<주의사항10>\r\n", "<주의사항11>\r\n", "<주의사항12>\r\n", "<주의사항13>\r\n", "<주의사항14>\r\n", "<주의사항15>\r\n", "<주의사항16>\r\n", "<주의사항17>\r\n"};
for(int di=0; di<deleteStrList.length; di++) strFunc = ReplaceStr.replace(strFunc, deleteStrList[di], "");
strFunc = ReplaceStr.replace(strFunc, "(안내: 3㎡ ≒ 1평)", "<span style='fbt_Zoomin_ont-size:8pt;color:#7A7A7A;font-family:돋움'>(안내: 3<span style='font-size:9pt'>㎡ ≒</span> 1평)</span>");
strFunc = ReplaceStr.replace(strFunc, "font color=grey", "font color=gray");
strFunc = strFunc.trim();

if(intMode == 1){	//intMode 1:카탈로그 노출

	strFunc_detail = strFunc;

	if(strFunc_detail.indexOf("<추가 설명")>-1){
		strFunc_detail = strFunc_detail.substring(0,strFunc.indexOf("<추가 설명"));
	}
	//카탈로그 정리
	if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1 ){ 
		strFunc_detail = strFunc_detail.replaceAll("▶","▷");
	}else{
		strFunc_detail = strFunc_detail.replaceAll("▶","▷");
	}
	strFunc_detail = strFunc_detail.replaceAll("★","<span style='color:#953735;margin-right:2px;'>★</span>");
	strFunc_detail = strFunc_detail.replaceAll("\\^{1}","<img src='http://img.enuri.info/images/view/blue/detail_bullet_20140403.gif' style='margin-top:4px;margin-right:2px;margin-left:2px;'>");
	//strFunc_detail = strFunc_detail.replaceAll("<br>","");
	strFunc_detail = strFunc_detail.replaceAll("<table ","<table style='font-size:10px;border:none;border-bottom:1px solid #000000;border-left:1px solid #000000;' ");
	strFunc_detail = strFunc_detail.replaceAll("border=\"1\"",""); 
	strFunc_detail = strFunc_detail.replaceAll("medium:none","");
	strFunc_detail = strFunc_detail.replaceAll("collapse:collapse;border:none","");
	strFunc_detail = strFunc_detail.replaceAll("<td ","<td style='border-right:1px solid #000000;border-top:1px solid #000000;'");
	strFunc_detail = strFunc_detail.replaceAll("border=","");
	strFunc_detail = strFunc_detail.replaceAll("&lt;","&lt; ");  
	strFunc_detail = strFunc_detail.replaceAll("&gt;","gt;"); 
	
	String strFunc_detail_sub = "";
	String strFunc_detail_sub2 = "";
	
	if(strFunc_detail.indexOf("<주의") > -1){
		strFunc_detail_sub = strFunc_detail.substring(0,strFunc_detail.indexOf("<주의"));
		strFunc_detail = strFunc_detail.substring(strFunc_detail.indexOf("<주의"),strFunc_detail.length());
		if(strFunc_detail.indexOf(">") > -1 && strFunc_detail.length() > 10){
			strFunc_detail_sub2 = strFunc_detail.substring(strFunc_detail.indexOf(">")+3,strFunc_detail.length());
		}
	 
		strFunc_detail = strFunc_detail_sub+strFunc_detail_sub2; 
	}
	strFunc_detail = strFunc_detail.replaceAll("/images/detail/more_btn.gif","/images/blank.gif");
	strFunc_detail = strFunc_detail.replaceAll("/images/detail/ielogo.gif","/images/blank.gif");
	
	if(strFunc_detail.indexOf("<a") > -1 || strFunc_detail.indexOf("<A") > -1){ 
		if(strFunc_detail.indexOf("List.jsp") > 0 || strFunc_detail.indexOf("?cate") > 0 || strFunc_detail.indexOf("&cate") > 0){
			if(strFunc_detail.indexOf("?cate") > 0 || strFunc_detail.indexOf("&cate") > 0){
				strFunc_detail = strFunc_detail.replaceAll("www.enuri.com/view/Listmp3.jsp","m.enuri.com/mobilefirst/list.jsp");
				strFunc_detail = strFunc_detail.replaceAll("www.enuri.com/view/List.jsp","m.enuri.com/mobilefirst/list.jsp");
			}
		}
		if(strFunc_detail.indexOf("href=") > -1 ){ 
			strFunc_detail = strFunc_detail.replaceAll("href=javascript:;", "");
			strFunc_detail = strFunc_detail.replaceAll("onclick=knowboxLinkByUri\\(","href=").replaceAll("','knowbox'\\)","");
			strFunc_detail = strFunc_detail.replaceAll("<a ","<a onclick=\"newWin_Info(this.href);return false;\" ");
			strFunc_detail = strFunc_detail.replaceAll(" target=", " !target="); 
		}
	}
}
//strFunc_detail = strFunc_detail.replaceAll("\r\n*", "<br>");
//카탈로그 정리끝
//용어설명 정리
if(strFunc.indexOf("<추가 설명")>-1){
	strFunc = strFunc.substring(strFunc.indexOf("<추가 설명"),strFunc.length());			
			
	String miniguideStr1 = "";
	String miniguideStr2 = "";
	String miniguideReplaceStr = "";
	
	// 정규식을 이용한 추가설명
	java.util.regex.Pattern p1 = null;
	java.util.regex.Matcher m1 = null;
	String tempReplaceStr = "";
	int whileLoopBreak = 0;
	
	// 특정 문구를 미니가이드에서 찾아서 추가해줌
	if(strModelnm.indexOf("[")>-1 && strModelnm.indexOf("]")>-1 && strModelnm.indexOf("[")<strModelnm.indexOf("]")) {
		try {
			String findStr = strModelnm.substring(strModelnm.indexOf("[")+1, strModelnm.indexOf("]"));
			findStr = findStr.replaceAll("<b>", "");
			findStr = findStr.replaceAll("</b>", "");
			String tempRef_kbno = Know_termdic_title_Proc.getDetailmultiRef_kbno(CutStr.cutStr(strCa_code,4), findStr);
			if(tempRef_kbno.length()>0) {
				if(strFunc.indexOf("<추가 설명>")>-1) {
					strFunc = strFunc.replaceAll("<추가 설명>\r\n", "<추가 설명>\r\n<miniguide "+tempRef_kbno+">\r\n");
				} else {
					if(strFunc.indexOf("tit_02_0916.gif")>-1 && strFunc.lastIndexOf("</pre>")>0) {
						strFunc = strFunc.substring(0, strFunc.lastIndexOf("</pre>")) + "\r\n<추가 설명>\r\n<miniguide "+tempRef_kbno+">\r\n</pre>";
					}
				}
			}
		} catch(Exception e) {
		}
	}
		
	strFunc = strFunc.replace("\r\n<miniguide", "\r\n\r\n<miniguide");
	strFunc = strFunc.replace("--> ", "-->");
	strFunc = strFunc.replace("-->  ", "-->");
	strFunc = strFunc.replaceAll("<추가 설명> ","<추가 설명>");
	strFunc = strFunc.replace("<추가 설명>\r\n<miniguide", "<추가 설명><miniguide");
	strFunc = strFunc.replaceAll("<추가 설명>","");
	strFunc = strFunc.replaceAll("http://www.enuri.com/images", "" + IMG_ENURI_COM + "/images");
	strFunc = strFunc.replaceAll("\n ", "\n");
	strFunc = strFunc + "\r\n";

	// 이미지 정렬
	strFunc = strFunc.replaceAll("<img ", "<img align=\"absmiddle\" ");
	String tableChangeText = "</table>\r\n^";
	int tableChangeTextLoc = strFunc.indexOf(tableChangeText);
	while(tableChangeTextLoc>-1) {
		strFunc = strFunc.substring(0, tableChangeTextLoc) + "</table>\r\n\r\n^" + strFunc.substring(tableChangeTextLoc + tableChangeText.length());
		tableChangeTextLoc = strFunc.indexOf(tableChangeText);
	}
	
	// 주석 삭제
	p1 = java.util.regex.Pattern.compile("<!--.*?-->");
	m1 = p1.matcher(strFunc);
	while(m1.find()) {
		int findLoc = strFunc.indexOf(m1.group());
		if(findLoc>-1) {
			strFunc = strFunc.substring(0, findLoc) + strFunc.substring(findLoc + m1.group().length());
		}
	}
	
	//글로쓴 용어설명이 앞에 위치한지 뒤에 위치한지.. 앞에 있으면 true
	boolean miniGuideFirstFlag = false;
	
	if(strFunc.indexOf("<miniguide")>-1 && strFunc.indexOf("<miniguide")<strFunc.indexOf("^")){ 
		miniGuideFirstFlag = true;
	}else{
		miniGuideFirstFlag = false;
	}
	
	p1 = java.util.regex.Pattern.compile("\\^{1}.*?[:][ \r]");
	m1 = p1.matcher(strFunc);
	while(m1.find()) {
		String tempGroup = m1.group();

		if(miniGuideFirstFlag) tempReplaceStr = "\r\n";
		if(tempGroup.indexOf("\r")<0) {
			tempReplaceStr += "<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\"><tr><td>";
			tempReplaceStr += "<div class=\"title\">";
			tempReplaceStr += tempGroup.substring(1,tempGroup.length()-2);
			tempReplaceStr += "</div>";
		} else {
			tempReplaceStr += "<div class=\"title\">";
			tempReplaceStr += tempGroup.substring(1,tempGroup.length()-2);
			tempReplaceStr += "</div>";
		}
		tempReplaceStr += "<div class=\"content\">";
		if(tempGroup.indexOf("\r")<0) tempReplaceStr += "</td><td align=\"right\" style=\"padding-right:3px;\">";

		int findNum = strFunc.indexOf(tempGroup);
		if(findNum>-1) {
			if(tempGroup.indexOf("\r")<0) {
				strFunc = strFunc.substring(0, findNum) + tempReplaceStr + strFunc.substring(findNum+tempGroup.length()).replaceFirst("\r\n", "</td></tr></table>");
			} else {
				strFunc = strFunc.substring(0, findNum) + tempReplaceStr + strFunc.substring(findNum+tempGroup.length()).replaceFirst("\n", "");
			}
		}
		if(!miniGuideFirstFlag) tempReplaceStr = "\r\n";

		if(whileLoopBreak++>100) break;
	}

	// <miniguide 글번호 1>
	p1 = java.util.regex.Pattern.compile("<miniguide.*?[>]");
	m1 = p1.matcher(strFunc);
	whileLoopBreak = 0;
	while(m1.find()) {
		String m1Temp = m1.group().replaceAll("<", "").replaceAll(">", "");
		m1Temp = m1Temp.replaceAll("  ", " ");
		m1Temp = m1Temp.replaceAll("  ", " ");
		m1Temp = m1Temp.replaceAll("\t", " ");
		String[] m1TempAry = m1Temp.split(" ");
		if(m1TempAry.length>1) {
			miniguideStr1 += m1TempAry[1]+":";
			miniguideReplaceStr += m1.group()+":";
		}

		if(whileLoopBreak++>100) break;
	}

	// 중복해서 입력할 가능성 존재
	Know_termdic_title_Data[] kttdAryTemp = null;
	Know_termdic_title_Data[] kttdAry = null;
	String[] kttid = miniguideStr1.split(":");

	if(miniguideStr1.length()>0) {
		kttdAryTemp = Know_termdic_title_Proc.getData_TermdicTitleKbnos(miniguideStr1);
	}
	if(kttid!=null && kttdAryTemp!=null) {
		kttdAry = new Know_termdic_title_Data[kttid.length];
		for(int ki=0; ki<kttid.length; ki++) {
			kttdAry[ki] = new Know_termdic_title_Data();
			if(kttdAryTemp!=null) {
				for(int kj=0; kj<kttdAryTemp.length; kj++) {
					if(kttid[ki].equals(kttdAryTemp[kj].getRef_kbno()+"")) {

						kttdAry[ki].setKtt_idx(kttdAryTemp[kj].getKtt_idx());
						kttdAry[ki].setRef_kbno(kttdAryTemp[kj].getRef_kbno());
						kttdAry[ki].setKtt_cate(kttdAryTemp[kj].getKtt_cate());
						kttdAry[ki].setKtt_title(kttdAryTemp[kj].getKtt_title());
						kttdAry[ki].setKtt_titleimg(kttdAryTemp[kj].getKtt_titleimg());
						kttdAry[ki].setKtt_titleimg_width(kttdAryTemp[kj].getKtt_titleimg_width());
						kttdAry[ki].setKtt_titleimg_height(kttdAryTemp[kj].getKtt_titleimg_height());
						kttdAry[ki].setKtt_func_content(kttdAryTemp[kj].getKtt_func_content());
						kttdAry[ki].setKtt_func_option(kttdAryTemp[kj].getKtt_func_option());
					}
				}
			}
		}
	}
	// 비정상적인 엔터 제거
	strFunc = strFunc.replaceAll("\r\n\r\n\r\n", "\r\n\r\n");

	if(kttdAry!=null) {
		String[] miniguideReplaceStrAry = miniguideReplaceStr.split(":");
		String[] mgTypeAry = miniguideStr2.split(":");

		for(int ti=0; ti<kttdAry.length; ti++) {
			String tempMiniGuideStr = "";

			tempMiniGuideStr += "<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\"><tr><td style=\"padding-bottom:2px;padding-top:2px;\">";
			if(ti>0){
				tempMiniGuideStr += "<br>";
			}
			tempMiniGuideStr += "<span class=\"title\">";
			tempMiniGuideStr += kttdAry[ti].getKtt_title();
			tempMiniGuideStr += "</span>";
			if(kttdAry[ti].getKtt_func_option().equals("1")) {
				tempMiniGuideStr += "</td><td>";
				if(HttpUtils.getRequestURL(request).toString().indexOf("view/Detailmulti.jsp")>-1){
					tempMiniGuideStr += "<img align=\"right\" !onClick=\"CmdGotoBeginnerDic("+kttdAry[ti].getRef_kbno()+",'"+kttdAry[ti].getKtt_cate()+"');\" src=\""+IMG_ENURI_COM+"/images/detail/more_btn.gif\" align=\"absmiddle\" style=\"cursor:hand;\">";
				}
			}
			if(kttdAry[ti].getKtt_func_option().equals("2")) {
				if(HttpUtils.getRequestURL(request).toString().indexOf("view/Detailmulti.jsp")>-1){
					tempMiniGuideStr += "&nbsp;<img !onClick=\"getBeginnerDicDetailPos("+kttdAry[ti].getRef_kbno()+", this, 'minititle_"+ti+"');\" src=\""+IMG_ENURI_COM+"/images/view/blue/btn_picture_0916.gif\" align=\"absmiddle\" style=\"cursor:hand;\">";
				}
			}
			tempMiniGuideStr += "</td></tr>";
			tempMiniGuideStr += "</table>";
			tempMiniGuideStr += "<pre align=\"left\" width=\"100%\" style=\"margin:0;padding:0;color:#000000;font-family:돋움;word-break:break-all;\">";
			String[] kttFuncContent = kttdAry[ti].getKtt_func_content().split("<break>");

			if(kttFuncContent.length>1) {
				if(kttFuncContent[0].length()>2 && kttFuncContent[0].substring(kttFuncContent[0].length()-2).equals("\r\n")) {
					kttFuncContent[0] = kttFuncContent[0].substring(0, kttFuncContent[0].length()-2) + "<br>";
				}
				tempMiniGuideStr += kttFuncContent[0];
			}
			if(kttdAry[ti].getKtt_titleimg().length()>0) {
				// 플래쉬 일 경우
				if(kttdAry[ti].getKtt_titleimg().length()>4 && kttdAry[ti].getKtt_titleimg().substring(kttdAry[ti].getKtt_titleimg().length()-4).equals(".swf")) {
					tempMiniGuideStr += "<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" codebase=\"http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0\" width=\""+kttdAry[ti].getKtt_titleimg_width()+"\" height=\""+kttdAry[ti].getKtt_titleimg_height()+"\" id=\"titleimg_"+kttdAry[ti].getRef_kbno()+"\" align=\"left\" style=\"margin-bottom:2;border:1 solid gray;\">";
					tempMiniGuideStr += "<param name=\"allowScriptAccess\" value=\"always\" />";
					tempMiniGuideStr += "<param name=\"allowFullScreen\" value=\"false\" />";
					tempMiniGuideStr += "<param name=\"quality\" value=\"high\" />";
					tempMiniGuideStr += "<param name=\"wmode\" value=\"transparent\" />";
					tempMiniGuideStr += "<param name=\"bgcolor\" value=\"#ffffff\" />";
					tempMiniGuideStr += "<param name=\"movie\" value=\""+ConfigManager.STORAGE_ENURI_COM+"/pic_upload/termdictitle/"+kttdAry[ti].getKtt_titleimg()+"\" />";
					tempMiniGuideStr += "<param name=\"FlashVars\" value=\"\" />";
					tempMiniGuideStr += "<embed src=\""+ConfigManager.STORAGE_ENURI_COM+"/pic_upload/termdictitle/"+kttdAry[ti].getKtt_titleimg()+"\" quality=\"high\" wmode=\"transparent\" bgcolor=\"#ffffff\" width=\""+kttdAry[ti].getKtt_titleimg_width()+"\" height=\""+kttdAry[ti].getKtt_titleimg_width()+"\" id=\"titleimg_"+kttdAry[ti].getRef_kbno()+"\" name=\"titleimg_"+kttdAry[ti].getRef_kbno()+"\" align=\"left\" swLiveConnect=true allowScriptAccess=\"always\" type=\"application/x-shockwave-flash\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\" /></embed>";
					tempMiniGuideStr += "</object>";
				} else { // 일반 이미지 일 경우
					tempMiniGuideStr += "<img align=\"left\" src=\""+ConfigManager.STORAGE_ENURI_COM+"/pic_upload/termdictitle/"+kttdAry[ti].getKtt_titleimg()+"\" style=\"border:1 solid gray;margin:0 4 2 0;padding:0 0 0 0;\">";
				}
			}
			if(kttFuncContent.length>1) {
				tempMiniGuideStr += kttFuncContent[1];
			} else {
				tempMiniGuideStr += kttFuncContent[0].replaceAll("<P ", "<div ").replaceAll("</P>", "</div>");
			}
			tempMiniGuideStr += "</pre>\r\n";

			try {
				if(kttdAry[ti].getKtt_func_content().length()>0) {
					strFunc = strFunc.replaceAll(miniguideReplaceStrAry[ti], tempMiniGuideStr);
				} else {
					// 미니가이드 내용이 없으면 태그를 삭제함
					if(ti==0) {
						strFunc = strFunc.replaceAll(miniguideReplaceStrAry[ti]+"\r\n\r\n", "");
					} else {
						strFunc = strFunc.replaceAll("\r\n\r\n"+miniguideReplaceStrAry[ti], "");
					}
					strFunc = strFunc.replaceAll(miniguideReplaceStrAry[ti], "");
				}
			} catch(Exception e) {
			}
		}
	}

	strFunc = strFunc.replaceAll("※", "<span style=\"font-size:9pt;\">※</span>");
	strFunc = strFunc.replaceAll("</pre>\r\n\r\n\r\n<table", "</pre>\r\n\r\n<table");
	strFunc = strFunc.replaceAll("pre>\r\n\r\n\r\n<div", "pre>\r\n\r\n<div");
	strFunc = strFunc.replaceAll("pre>\r\n \r\n\r\n<div", "pre>\r\n\r\n<div");
	strFunc = strFunc + "</pre>";
	
	
	strFunc = strFunc.replaceAll("★","<span style=\"color:#953735;margin-right:2px;\">★</span>");
	strFunc = strFunc.replaceAll("\\^{1}","<br><img src=\"http://img.enuri.info/images/view/blue/detail_bullet_20140403.gif\" align=\"absmiddle\" style=\"margin-right:2px;margin-left:2px;\">");
	if(strFunc.indexOf("<a") > -1 || strFunc.indexOf("<A") > -1){ 
		
		if(strFunc.indexOf("List.jsp") > 0 || strFunc.indexOf("?cate") > 0 || strFunc.indexOf("&cate") > 0){
			if(strFunc.indexOf("?cate") > 0 || strFunc.indexOf("&cate") > 0){
				strFunc = strFunc.replaceAll("www.enuri.com/view/Listmp3.jsp","m.enuri.com/mobilefirst/list.jsp");
				strFunc = strFunc.replaceAll("www.enuri.com/view/List.jsp","m.enuri.com/mobilefirst/list.jsp");
			}
		}else{
			if(strFunc.indexOf("/more_btn.gif") > 0 || strFunc.indexOf("/ielogo.gif") > 0){
				strFunc = strFunc.replaceAll("<a ","<ab ");
				strFunc = strFunc.replaceAll("<A ","<Ab ");
				strFunc = strFunc.replaceAll("/a>","/ab>"); 
				strFunc = strFunc.replaceAll("/A>","/Ab>");
				strFunc = strFunc.replaceAll("/A>","/Ab>");			
			}
		}
		if(strFunc.indexOf("href=") > -1 ){ 
			strFunc = strFunc.replaceAll("href=javascript:;", "");
			strFunc = strFunc.replaceAll("onclick=knowboxLinkByUri\\(","href=").replaceAll("','knowbox'\\)","");
			strFunc = strFunc.replaceAll("<a ","<a onclick=\"newWin_Info(this.href);return false;\" ");
			strFunc = strFunc.replaceAll(" target=", " !target="); 
		}	
	}
	
	strFunc = strFunc.replaceAll("<center>",""); 
	strFunc = strFunc.replaceAll("</center>","");
	strFunc = strFunc.replaceAll("<table border=\"0\"","<div style=\"clear:both;\"></div><table border=\"0\"");
	strFunc = strFunc.replaceAll("/images/detail/more_btn.gif","/images/blank.gif");
	strFunc = strFunc.replaceAll("/images/detail/ielogo.gif","/images/blank.gif");
}else{
	strFunc = "";
}
//용어설명 정리끝
%>
@@@<%@ include file="/mobilefirst/include/inc_detail_func_notice.jsp" %>
$$$<%=strFunc_detail %>^^^<%=strFunc %>
