function CmdMainKnowcom(){
	
	/*
	var vUrl = "/main/main2018/ajax/get_knowcom_ajax_1.json";
	if(top.location.href.indexOf("dev.enuri.com") > -1 || top.location.href.indexOf("stagedev.enuri.com") > -1 || top.location.href.indexOf("100.100.100.151/") > -1 || top.location.href.indexOf("192.168.213.214/") > -1 || top.location.href.indexOf("my.enuri.com") > -1){
		vUrl = "/wide/main/ajax/get_knowcom_ajax.jsp";
	}
	$.ajax({
		url: vUrl,
		async: true,
		dataType:"JSON",
		success: function(data){
			jsonNuriObj = data["nuriList"];
			jsonNuriHmObj = data["nuriHmList"];
			jsonEnuriTVObj = data["enuritvList"];
			jsonReviewObj = shuffle(data["reviewList"]);
			jsonUnboxingObj = typeof data["unboxingList"] == "undefined" ? [] : data["unboxingList"];
			//누리
			CmdMainNuriHm();
			//에누리TV
			vodArr = jsonEnuriTVObj;
			vodDraw();
		}
	});
	*/
	//data = jsonKnow;
	
try{
	jsonNuriObj = jsonKnow["nuriList"];
	jsonNuriHmObj = jsonKnow["nuriHmList"];
	jsonEnuriTVObj = jsonKnow["enuritvList"];
	jsonReviewObj = shuffle(jsonKnow["reviewList"]);
	jsonUnboxingObj = typeof jsonKnow["unboxingList"] == "undefined" ? [] : jsonKnow["unboxingList"];
	//누리
	CmdMainNuriHm();
	//에누리TV
	vodArr = jsonEnuriTVObj;
	vodDraw();	
}catch(e){console.log(e)}
	$("#knowboxArrows > button").click(function(){
    	if($('#newsPage1').is(':visible')){
    		$('#newsPage2').show();
    		$('#newsPage1').hide();
    	}else{
    		$('#newsPage1').show();
    		$('#newsPage2').hide();
    	}
	});
	 $("#vodArrows > button").click(function(){
		 changeVod(($(this).index() == 0) ? -3 : 3);
	 });
	
}
function CmdMainNuriHm() {
	var hm = jsonNuriHmObj["hm"];
	var text = jsonNuriHmObj["text"];

    var outHtml = "";
    var outHtml2 = "";
    var vNuriTitle = "";

    // 썸네일
	$.each(hm, function(i, nuriObj) {
		vNuriTitle = cut(nuriObj["kb_title"], 25);
		
		if(i < 2){
			outHtml += "<li class=\"prod__item\">";
			outHtml += "<a href=\"/knowcom/detail.jsp?bbsname=nuri&cateno=&kbno="+nuriObj["kb_no"]+"&page=1\" onclick='insertLog(24351);' class='thum__link'>";
			outHtml += "	<span class=\"thum\"><img src=\"http://storage.enuri.info/pic_upload/knowbox_home_thumb/"+nuriObj["kb_no"]+".jpg\" onerror=\"this.src='http://img.enuri.com/images/m_home/noimg.png'\" alt=\"\" width='100%' /></span>";
			outHtml += "	<span class='tx'><em class='tx_cate'>["+nuriObj["cate_nm"]+"]</em>"+vNuriTitle+"</span>";
			outHtml += "</a>";
			outHtml += "</li>";	
		}else {
			outHtml2 += "<li class=\"prod__item\">";
			outHtml2 += "<a href=\"/knowcom/detail.jsp?bbsname=nuri&cateno=&kbno="+nuriObj["kb_no"]+"&page=1\" onclick='insertLog(24351);'  class='thum__link'>";
			outHtml2 += "	<span class=\"thum\"><img src=\"http://storage.enuri.info/pic_upload/knowbox_home_thumb/"+nuriObj["kb_no"]+".jpg\" onerror=\"this.src='http://img.enuri.com/images/m_home/noimg.png'\" alt=\"\" width='100%' /></span>";
			outHtml2 += "	<span class='tx'><em class='tx_cate'>["+nuriObj["cate_nm"]+"]</em>"+vNuriTitle+"</span>";
			outHtml2 += "</a>";
			outHtml2 += "</li>";
		}
		
		
	});
    // 썸네일 체크 없을 경우 텍스트형에서 가져옴
    if (outHtml == "" || hm.length <= 0) {
		if (text.length >= 18) {
			var cnt = 0;
			for (_idx=0; _idx<text.length; _idx++) {
				nuriObj = text[_idx];
				if (nuriObj["kb_thumbnail"] != "") {

					vNuriTitle = cut(nuriObj["kb_title"], 25)

					outHtml += "<li class=\"prod__item\">";
						outHtml += "<a href=\"/knowcom/detail.jsp?bbsname=nuri&cateno=&kbno="+nuriObj["kb_no"]+"&page=1\" onclick='insertLog(24351);' class='thum__link'>";
						outHtml += "	<span class=\"thum\"><img src=\"http://storage.enuri.info/pic_upload/knowbox_home_thumb/"+nuriObj["kb_no"]+".jpg\" onerror=\"this.src='http://img.enuri.com/images/m_home/noimg.png'\" alt=\"\" /></span>";
						outHtml += "	<span class='tx'><em class='tx_cate'>"+nuriObj["cate_nm"]+"</em>"+vNuriTitle+"</span>";
						outHtml += "</a>";
					outHtml += "</li>";

					var $obj = text.splice(_idx, 1);	// 텍스트 기사에서 제외
					if (++cnt >= 2) break;
				}
			}
		}
    }
   
    var txtHtml1="";
    var txtHtml2="";
    // 텍스트
	$.each(text, function(_idx, nuriObj) {
		var num_1 = 8;
		var num_2 = 16;

		vNuriTitle = cut(nuriObj["kb_title"], 25);

    	// 1판 텍스트 6개, 2판 11개
		/*
		if (_idx < num_1) {
    		outHtml += "<li><a href=\"/knowcom/detail.jsp?bbsname=nuri&cateno=&kbno="+nuriObj["kb_no"]+"&page=1\" class=\"commnitybest__item\" target=\"_blank\" title=\"새 창에서 열립니다\" onclick=\"insertLog(16947);\">"+vNuriTitle+"";
    		if(nuriObj["reply_cnt"] > 0){
    			outHtml += "<span class=\"reply\">("+nuriObj["reply_cnt"]+")</span>";
    		}
    		outHtml += "</a></li>";
    	} else if (_idx < num_2) {
    		outHtml2 += "<li><a href=\"/knowcom/detail.jsp?bbsname=nuri&cateno=&kbno="+nuriObj["kb_no"]+"&page=1\" class=\"commnitybest__item\" target=\"_blank\" title=\"새 창에서 열립니다\"  onclick=\"insertLog(16947);\">"+vNuriTitle+"";
    		if(nuriObj["reply_cnt"] > 0){
    			outHtml2 += "<span class=\"reply\">("+nuriObj["reply_cnt"]+")</span>";
    		}
    		outHtml2 += "</a></li>";
    	}
    	*/
		if (_idx < num_1) {
			txtHtml1 += "<li class='prod__item'>";
			txtHtml1 += "	<a href=\"/knowcom/detail.jsp?bbsname=nuri&cateno=&kbno="+nuriObj["kb_no"]+"&page=1\" onclick='insertLog(24351);'  >";
			txtHtml1 += "		<span class='tx_cate'>"+nuriObj["cate_nm"]+"</span>"+vNuriTitle;
			txtHtml1 += "	</a>";
			txtHtml1 += "</li>";
		} else if (_idx < num_2) {
			//outHtml2 += "<li class='prod__item'>";
			//outHtml2 += "	<a href=\"/knowcom/detail.jsp?bbsname=nuri&cateno=&kbno="+nuriObj["kb_no"]+"&page=1\" >";
			//outHtml2 += "		<span class='tx_cate'>"+nuriObj["cate_nm"]+"</span>"+vNuriTitle;
			//outHtml2 += "	</a>";
			//outHtml2 += "</li>";			
			txtHtml2 += "<li class='prod__item'>";
			txtHtml2 += "	<a href=\"/knowcom/detail.jsp?bbsname=nuri&cateno=&kbno="+nuriObj["kb_no"]+"&page=1\" onclick='insertLog(24351);'  >";
			txtHtml2 += "		<span class='tx_cate'>"+nuriObj["cate_nm"]+"</span>"+vNuriTitle;
			txtHtml2 += "	</a>";
			txtHtml2 += "</li>";
		}
		
	});
	
	$("#newsPage1 > div.thumknow > ul").html(outHtml);
	$("#newsPage1 > div.newsknow > ul").html(txtHtml1);
	
	$("#newsPage2 > div.thumknow > ul").html(outHtml2);
	$("#newsPage2 > div.newsknow > ul").html(txtHtml2);
}
function changeVod (param) {
	//(default : 오른쪽으로 2칸)
	var moveSize = typeof param !== "undefined" ? param : 3; 
	vidx = (vidx + moveSize + vodSize) % vodSize;
	vodDraw();
}

var vodArr = [];
var vodSize= 6;
var vidx = 0;

function vodDraw(){
	
	var outHtml = "";
	
	var v = vodArr[vidx];
	
	outHtml += "<li class='prod__item'>";
	outHtml += "	<a href=\"/knowcom/detail.jsp?kbno="+v["kb_no"]+"&bbsname=enuritv&cateno=9&page=1\" target='_self' onclick='insertLog(24352);'  class='thum__link'>";
	outHtml += "	    <span class='thum'><img src='"+v.movie_id+"' alt=''></span>";
	outHtml += "	    <span class='tx_wrap'>";
	outHtml += "	        <span class='tx_class'>"+v.show_name+"</span>";
	outHtml += "	        <span class='tx_name'>"+v.kb_title+"</span>";
	outHtml += "	    </span>";
	outHtml += "	</a>";
	outHtml += "</li>";
	
	v = vodArr[vidx+1];
	
	outHtml += "<li class='prod__item'>";
	outHtml += "	<a href=\"/knowcom/detail.jsp?kbno="+v["kb_no"]+"&bbsname=enuritv&cateno=9&page=1\" target='_self' onclick='insertLog(24352);' class='thum__link'>";
	outHtml += "	    <span class='thum'><img src='"+v.movie_id+"' alt=''></span>";
	outHtml += "	    <span class='tx_wrap'>";
	outHtml += "	        <span class='tx_class'>"+v.show_name+"</span>";
	outHtml += "	        <span class='tx_name'>"+v.kb_title+"</span>";
	outHtml += "	    </span>";
	outHtml += "	</a>";
	outHtml += "</li>";
	
	v = vodArr[vidx+2];
	
	outHtml += "<li class='prod__item'>";
	outHtml += "	<a href=\"/knowcom/detail.jsp?kbno="+v["kb_no"]+"&bbsname=enuritv&cateno=9&page=1\" target='_self' onclick='insertLog(24352);'  class='thum__link'>";
	outHtml += "	    <span class='thum'><img src='"+v.movie_id+"' alt=''></span>";
	outHtml += "	    <span class='tx_wrap'>";
	outHtml += "	        <span class='tx_class'>"+v.show_name+"</span>";
	outHtml += "	        <span class='tx_name'>"+v.kb_title+"</span>";
	outHtml += "	    </span>";
	outHtml += "	</a>";
	outHtml += "</li>";

	$("#vodList").html(outHtml);
	
	return false;
}
//한글 2byte로 자르기
function cut(str, len) {
	if(str.ByteLength() > len){
		len = len*2;
		var l = 0;
		for (var i=0; i<str.length; i++) {
	        l += (str.charCodeAt(i) > 128) ? 2 : 1;
	        if (l > len) return str.substring(0,i)+"...";
		}
	}
	return str;
}
var jsonFunParkObj;
var vFunParkNo = 1;
function CmdMainKnowcom2(){
	var vUrl = "http://ad-api.enuri.info/enuri_PC/pc_home/O5/bundle";
	$.ajax({
		url: vUrl,
		async: true,
		data: {"bundlenum":10},
		dataType:"JSON",
		success: function(data){
			
			jsonFunParkObj = data;
			//체험단 & 언박싱
			CmdFunPark(1);
			
			$(".bnrbox.bnrbox--knowfun > div.arrows > button").click(function(){
				
				if($(this).hasClass("prev")){
					vFunParkNo = vFunParkNo - 1;
					if(vFunParkNo < 1){
						vFunParkNo = jsonFunParkObj.length;
					}
				}else{
					vFunParkNo = vFunParkNo + 1;
					if(vFunParkNo > jsonFunParkObj.length){
						vFunParkNo = 1;
					}
				}
				CmdFunPark(vFunParkNo);
				insertLog(24353);
			});
		}
	});
}
function CmdFunPark(param){
    var outHtml = "";
    $.each(jsonFunParkObj,function(_idx, obj){
	   if(param == (_idx+1)){
		   outHtml += "<li>";
		   outHtml += "<a href=\""+obj.JURL1+"\" onclick='insertLog(24354);'  target=\"_blank\">";
		   outHtml += "		<img src=\""+obj.IMG1+"\" alt=\""+obj.ALT+"\">";
		   outHtml += "</a>";
		   outHtml += "</li>";
	   }
	});
    $("#know_banner").html(outHtml);
}