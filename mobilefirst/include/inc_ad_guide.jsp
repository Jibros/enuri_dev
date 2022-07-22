<%@ page contentType="text/html; charset=utf-8" trimDirectiveWhitespaces="true"%>
<%@ page import="com.enuri.util.common.ConfigManager"%>
<%@ page import="com.enuri.util.common.ChkNull"%>
<%@ page import="com.enuri.util.common.CutStr"%>
<%@ include file="/mobilefirst/include/inc_InfoAd_Contents_KnowboxCate.jsp"%>
<%
//String strCate = ChkNull.chkStr(request.getParameter("cate"));
boolean knowAdShowFlag = false;

if(knowCates!=null && knowCates.length>0) {
	for(int i=0; i<knowCates.length; i++) {
		if(knowCates[i][0].equals(CutStr.cutStr(strCate,4))) {
			knowAdShowFlag = true;
			break;
		}
	}
}


%>
<script language="javascript">
var flag = <%=knowAdShowFlag%>;
var varCate2 = "<%=CutStr.cutStr(strCate,4)%>";
var vVerios = "<%=strVerios%>";
var strNo = "";

$(function(){
	//if(flag){
		getContentsInfo();
		ga('send', 'pageview', {
			'page': '/mobilefirst/list.jsp',
			'title': 'mf_인포애드_컨텐츠광고_'+varCate2
		}); 
	//}else{
	//	$(".tab_trend").hide();
	//}
});

function getContentsInfo() {	//2016-12-12 신규 마음열기 데이터 GET
	var url = "/lsv2016/ajax/getKnowboxContent_Ajax.jsp";
	var param = "cate="+varCate2;
	
	$.ajax({
        type: "POST",
        url: url,
        data: param,
        success: function(data){
        	var jsondata =  JSON.parse(data);
        	$(document).ajaxStop(function(){	//prodList 완료 후 이후 마음열기 붙이기 위함
        		 remakeHtmlRender(jsondata);
        	});  
        	 
        }
    });
}

function remakeHtmlRender(data) { //2016-12-12 신규 마음열기 데이터 GET
	var dframe = data.frame;
	var imageRoot          = "http://storage.enuri.info/pic_upload/enurinews_thumbnail/";
	var errImgSrc          = "http://img.enuri.info/images/infoad/noimage.jpg";
	var html = "";

	//console.log(data.frame);
	var vChk_4 = false;
	if(dframe.length > 0){
		html+= "<li class=\"retarget\"> ";
		html+= "	<div class=\"retarget__inner\" >";
		html+= "		<ul class=\"retarget__list\" >";
		for(var i=0; i<dframe.length; i++) {
			//html += "<ul class=\"news_list\" id=\"cate0"+(i+1)+"\">";
			if(dframe[i].type == "1" && typeof dframe[i].slot[0] != "undefined" ){  
				var first_slot = dframe[i].slot[0];
				
				html+= "<li>";
				html+= "	<a href=\"javascript:///\" onclick=\"kb_view2('"+ dframe[i].name +"', '"+ first_slot["slotid"] +"', '"+ first_slot["click"] +"', '"+ dframe[i].id +"', '"+ first_slot["click"]+"')\" target=\"_blank\"  >";
				html+= "			<span class=\"thumb\">";
				html+= "				<img src=\""+first_slot["image"]+"\" alt=\"\" onerror=\"this.src='"+errImgSrc+"'\">";
				html+= "			</span>";
				html+= "			<strong class=\"category\">"+dframe[i]["name"]+"</strong>";
				html+= "			<span class=\"rename\">"+first_slot["title"]+"</span>";
				html+= "	</a>";
				html+= "</li>";
				/*$("#barTap0"+(i+1)).text(dframe[i].name);
				 for(var j=0; j<dframe[i].slot.length; j++){
					if(j == 0){
						html += "<li class=\"thum\">";
						html += "<img src=\""+ dframe[i].slot[j].image +"\" alt=\"\" onerror=\"this.src='"+errImgSrc+"'\" />";
					}else{
						html += "<li>";					
					}
					html += 	"<a href=\"javascript:///\" onclick=\"kb_view2('"+ dframe[i].name +"', '"+ dframe[i].slot[j].slotid +"', '"+ dframe[i].slot[j].click +"', '"+ dframe[i].id +"', '"+ dframe[i].slot[j].click+"')\" target=\"_blank\" >"+ dframe[i].slot[j].title +"</a>";
					html += "</li>";
				} */
			}else if(dframe[i].type == "2"){
				for(var j=0; j<dframe[i].slot.length; j++){
					if(j == 0){
						html += "<li class=\"banner\">";
						html += "<img onclick=\"kb_view2('"+ dframe[i].name +"', '"+ dframe[i].slot[j].slotid +"', '"+ dframe[i].slot[j].click +"', '"+ dframe[i].id +"', '"+ dframe[i].slot[j].click +"')\"  src=\""+ dframe[i].slot[j].image +"\" alt=\"\" onerror=\"this.src='"+errImgSrc+"'\" />";	
					}
					html += 	"<a href=\"javascript:///\" onclick=\"kb_view2('"+ dframe[i].name+"', '"+ dframe[i].slot[j].slotid +"', '"+ dframe[i].slot[j].click +"',' "+ dframe[i].id +"', '"+ dframe[i].slot[j].click+"')\" target=\"_blank\" ><span>"+ dframe[i].slot[j].title +"</span>"+ dframe[i].slot[j].text +"<em><em></a>";
					html += "</li>";
				}
				vChk_4 = true; //type 2 가 있으면 기획전 탭이 있으므로 기획전으로 텍스트 전환
			}
			//html += "</ul>";
		}
		html += "</ul>";
		html += "</div>";
		html += "</li>";
		if(html.length > 150){
			//$('.guidelist').html(html);
			$('.lp_list .prodList').append(html);
			//document.getElementById("cate02").style.display = "none";
			//document.getElementById("cate03").style.display = "none";
			if(vChk_4){
				$("#barTap03").text("기획전")
			}
		}else{
			$(".tab_trend").hide();
		}
	}else{
		$(".tab_trend").hide();
	}
	
}

function getContentsInfo_old() {	//2016-12-12 이전 마음열기 데이터 GET
	var url = "/mobilefirst/ajax/getAdContentType_ajax.jsp";
	var param = "strCate="+varCate2+"&strNo=";
	
	$.ajax({
        type: "POST",
        url: url,
        data: param,
        success: function(data){
        	var jsondata =  JSON.parse(data);
        	remakeHtmlRender(jsondata);	
        }
    });
}

function remakeHtmlRender_old(data) {	//2016-12-12 이전 마음열기 데이터 GET
	obj = data.adListContentType;

	var imageRoot          = "http://storage.enuri.info/pic_upload/enurinews_thumbnail/";
	var errImgSrc          = "http://img.enuri.info/images/infoad/noimage.jpg";
	
	var jsonGuide = new Array();	//구매가이드
	var jsonNews = new Array();		//뉴스
	var jsonReview = new Array();	//리뷰&사용기
	var guideNum = 0;
	var newsNum = 0;
	var reviewNum = 0;
	//10:구매, 05:뉴스, 07:리뷰
	
	//alert(obj.length);
	for(var i=0; i<obj.length; i++){
		if(obj[i].kk_code == '10'){	
			jsonGuide[guideNum] = obj[i];
			guideNum = guideNum + 1;
		}else if(obj[i].kk_code == '05'){	
			jsonNews[newsNum] = obj[i];
			newsNum = newsNum + 1;
		}else if(obj[i].kk_code == '07'){	
			jsonReview[reviewNum] = obj[i];
			reviewNum = reviewNum + 1;
		}
	}
	//alert(jsonNews.length);
	//alert(jsonReview.length);
	var arr = new Array('jsonGuide','jsonNews','jsonReview');
	var arrNm = new Array('가이드','뉴스','리뷰&사용기');
	var arrDpYn = new Array(false,false,false);
	var html = "";
	
	for(var i=0; i<arr.length; i++) {
		var name = arr[i];
		var len = eval(name+".length");
		//alert(len);
		html += "<ul class=\"news_list\" id=\"cate0"+(i+1)+"\">";
		for(var j=0; j<len; j++){
			var sub_name = eval(name+"["+j+"]");
			if(sub_name.kb_top_write_flag=="Y") {
				arrDpYn[i] = true;
				html += "<li class=\"thum\">";
				if(sub_name.kb_thumbnail_img && sub_name.kb_thumbnail_img.length > 0) {
					html += "<img src=\""+imageRoot+sub_name.kb_thumbnail_img+"\" alt=\"\" onerror=\"this.src='"+errImgSrc+"'\" />";	
				}
				strNo = strNo + sub_name.kb_no + ",";
			}else{
				html += "<li>";
			}
			html += 	"<a href=\"javascript:///\" onclick=\"kb_view("+ sub_name.kb_no +",'"+(i+1)+"')\" target=\"_blank\" !onclick=\"logInsertInfoAdKnowBox('', varCate2);\">"+sub_name.kb_title+"</a>";
			html += "</li>";
		}
		html += "</ul>";
		html += "<a href=\"javascript:moreGuide("+(i+1)+");\" class=\"morebtn\" id=\"btm0"+(i+1)+"\"><span>"+arrNm[i]+" 더보기</span></a>";		
	}

	$('.guidelist').html(html);
	document.getElementById("cate02").style.display = "none";
	document.getElementById("cate03").style.display = "none";
	document.getElementById("btm02").style.display = "none";
	document.getElementById("btm03").style.display = "none";
	//$('.guidelist').style.display = "";
	
	var chk = true;
	for(var i=0;i<arr.length;i++){
		if(!arrDpYn[i]){
			chk = false;
		}
	}
	if(!chk){
		$(".tab_trend").hide();
		$(".guidelist").hide();
	}
}

function moreGuide(param){
	var sub_str = "";
	if(strNo != null && strNo != ""){
		sub_str = strNo.substring(0,strNo.length-1);
	}
	
	if(param == 1){
		ga('send', 'event', 'mf_lp_Info_Ad_contents', varCate2+'_more', 'more_가이드_더보기');
	}else if(param == 2){
		ga('send', 'event', 'mf_lp_Info_Ad_contents', varCate2+'_more', 'more_뉴스_더보기');
	}else if(param == 3){
		ga('send', 'event', 'mf_lp_Info_Ad_contents', varCate2+'_more', 'more_리뷰&사용기_더보기');
	}
	
	window.open("/mobilefirst/ad_guide.jsp?freetoken=event&num="+param+"&strCate="+varCate2+"&strNo="+sub_str);
}

function displayYn(param){
	var val = param;
	if(val == 1){
		$("#barTap02").removeClass("selected");
		$("#barTap03").removeClass("selected");
		document.getElementById("cate02").style.display = "none";
		document.getElementById("cate03").style.display = "none";
		
		$("#barTap01").addClass("selected");
		document.getElementById("cate01").style.display = "";
		
		ga('send', 'event', 'mf_lp_Info_Ad_contents', varCate2+'_TAB', 'TAB_가이드');
	}else if(val == 2){
		$("#barTap01").removeClass("selected");
		$("#barTap03").removeClass("selected");
		document.getElementById("cate01").style.display = "none";
		document.getElementById("cate03").style.display = "none";
		
		$("#barTap02").addClass("selected");
		document.getElementById("cate02").style.display = "";
		
		ga('send', 'event', 'mf_lp_Info_Ad_contents', varCate2+'_TAB', 'TAB_뉴스');
	}else if(val == 3){
		$("#barTap01").removeClass("selected");
		$("#barTap02").removeClass("selected");
		document.getElementById("cate01").style.display = "none";
		document.getElementById("cate02").style.display = "none";
		
		$("#barTap03").addClass("selected");
		document.getElementById("cate03").style.display = "";
		
		ga('send', 'event', 'mf_lp_Info_Ad_contents', varCate2+'_TAB', 'TAB_기획전');
	}
}

function kb_view2(slot_name, slotid, url, param, click_url){
	if(param == 1){
		ga('send', 'event', 'mf_lp_Info_Ad_contents', varCate2+'_'+slot_name, slot_name+'_'+slotid);
	}else if(param == 2){
		ga('send', 'event', 'mf_lp_Info_Ad_contents', varCate2+'_'+slot_name, slot_name+'_'+slotid);
	}else if(param == 3){
		ga('send', 'event', 'mf_lp_Info_Ad_contents', varCate2+'_'+slot_name, slot_name+'_'+slotid);
	}else if(param == 4){
		ga('send', 'event', 'mf_lp_Info_Ad_contents', varCate2+'_'+slot_name, slot_name+'_'+slotid);
	}
	//window.open(url+"&freetoken=news");
	$("#infoUrl").attr("src", click_url);
	 
	if(url.indexOf("www.enuri.com%2Fknowbox2%2Findex.jsp%3F") > -1){
		url = url.replace("www.enuri.com%2Fknowbox2%2Findex.jsp%3F","m.enuri.com%2Fmobilefirst%2Fnews_detail.jsp%3F");
		url = url + "%26freetoken%3Dnews&freetoken=news&test=/mobilefirst/news_detail.jsp";
	}
	window.open(url); 

	return;   
}

function kb_view(slotid, url, param){
	if(param == 1){
		ga('send', 'event', 'mf_lp_Info_Ad_contents', varCate2+'_가이드', '가이드_'+slotid);
	}else if(param == 2){
		ga('send', 'event', 'mf_lp_Info_Ad_contents', varCate2+'_뉴스', '뉴스_'+slotid);
	}else if(param == 3){
		ga('send', 'event', 'mf_lp_Info_Ad_contents', varCate2+'_기획전', '리뷰&사용기_'+slotid);
	}else if(param == 4){
		ga('send', 'event', 'mf_lp_Info_Ad_contents', varCate2+'_기획전', '기획전_'+slotid);
	}
	//window.open(url+"&freetoken=news");
	if(url.indexOf("www.enuri.com%2Fknowbox2%2Findex.jsp%3F") > -1){
		url = url.replace("www.enuri.com%2Fknowbox2%2Findex.jsp%3F","m.enuri.com%2Fmobilefirst%2Fnews_detail.jsp%3F");
		url = url + "%26freetoken%3Dnews&freetoken=news&test=/mobilefirst/news_detail.jsp";
	}
	window.open(url);

	return;   
}

function kb_view_old(kbno, param){
	if(param == 1){
		ga('send', 'event', 'mf_lp_Info_Ad_contents', varCate2+'_가이드', '가이드_'+kbno);
		window.open("news_detail.jsp?strpop=Y&freetoken=event&kbno="+kbno+"&from=guide&verios="+vVerios);
	}else if(param == 2){
		ga('send', 'event', 'mf_lp_Info_Ad_contents', varCate2+'_뉴스', '뉴스_'+kbno);
		window.open("news_detail.jsp?strpop=Y&freetoken=event&kbno="+kbno+"&verios="+vVerios);
	}else if(param == 3){
		ga('send', 'event', 'mf_lp_Info_Ad_contents', varCate2+'_리뷰', '리뷰_'+kbno);
		window.open("news_detail.jsp?strpop=Y&freetoken=event&kbno="+kbno+"&from=review&verios="+vVerios);
	}

	return;   
}
</script>

<!-- 160406 마음열기 -->
<!-- <div class="tab_trend three">
	<ul>
		<li><a class="selected" href="javascript:displayYn(1);" id="barTap01">가이드</a></li>
		<li><a href="javascript:displayYn(2);" id="barTap02">뉴스</a></li>
		<li><a href="javascript:displayYn(3);" id="barTap03">리뷰&사용기</a></li>
	</ul>
</div>

<div class="guidelist">
</div> -->
<!--// 160406 마음열기 -->
