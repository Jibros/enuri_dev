function getCookieCommon(c_name) {
	var i,x,y,ARRcookies = document.cookie.split(";");
	for(var i=0; i<ARRcookies.length; i++) {
		x = ARRcookies[i].substr(0,ARRcookies[i].indexOf("="));
		y = ARRcookies[i].substr(ARRcookies[i].indexOf("=")+1);
		x = x.replace(/^\s+|\s+$/g,"");
		if(x==c_name) {
			return unescape(y);
		}
	}
}

function getcmdbanner() {
	//var objEvtProm = $("#evtpromSlide");
	var cate4 = cate;
	if(cate.length > 4){
		cate4 = cate.substring(0,4);
	}
	
	var loadUrl = "http://ad-api.enuri.info/enuri_M/m_lp/M3/bundle?bundlenum=3&cate="+cate4;
	
	/*
	if(cate4 == "1640" && isAdult == "true") {
		loadUrl = "http://ad-api.enuri.info/enuri_M/m_adult/M3a/bundle?bundlenum=3&cate=1640";
	}
	*/
		
	$.getJSON(loadUrl,function(json){
		
		if(json[0] ==undefined){
			$(".bnr").hide(); 
			 
			return false;			
		}
		$(".bnr img").attr("src", json[0].IMG1);
		$(".bnr img").click(function() {
			ga('send', 'event', 'mf_lp', 'lp_common', 'click_lp_banner');
			if(json[0].JURL1.indexOf("freetoken=outlink") > -1 ){
				window.open(json[0].JURL1);
			}else{
				location.href = json[0].JURL1.replace("&freetoken=outlink","");	
			}
			
		});
		$(".cate_area").show();
		$(".bnr").show(); 
	});
}
function getVIPMiddleBanner(){
	var loadUrl = "http://ad-api.enuri.info/enuri_M/m_vip/M4/bundle?bundlenum=3&cate="+vCate4;
	
	/*
	if(vCate4 == "1640" && isAdult == "true") {
		loadUrl = "http://ad-api.enuri.info/enuri_M/m_adult/M3a/bundle?bundlenum=3&cate=1640";
	}
	*/
	
	//$.getJSON("/mobilefirst/get_banner_list.jsp",{url:loadUrl},function(json){
	$.getJSON(loadUrl,function(json){
		if(json[0] == undefined){
			$(".vip_middle_banner").hide(); 
			return false;		
		}
		//$(".vip_middle_banner li a").attr("href", json[0].JURL1);
		$(".vip_middle_banner li img").attr("src", json[0].IMG1);
		$(".vip_middle_banner li img").click(function() {
			ga_new(10,json[0].TXT1);
			if(json[0].JURL1.indexOf("freetoken=outlink") > -1 ){
				window.open(json[0].JURL1);
			}else{
				location.href = json[0].JURL1;	
			}
			
		});
		
		$(".vip_middle_banner").show(); 
	});
}
function getVIPDoongBanner(bnr_class, blWeb){
	var loadUrl = "";

	if(blWeb){
		loadUrl = "http://ad-api.enuri.info/enuri_M/m_vip/PW/bundle?bundlenum=2&cate="+vCate4;
	}else{
		loadUrl = "http://ad-api.enuri.info/enuri_M/m_vip/PA/bundle?bundlenum=2&cate="+vCate4;
	}
	
	//$.getJSON("/mobilefirst/get_banner_list.jsp",{url:loadUrl},function(json){
	$.getJSON(loadUrl,function(json){
		if(json[0] == undefined){
			$("#floating_banner").hide(); 
			return false;	
		}
		var vTmphtml = "";
		vTmphtml += "<span class=\""+ bnr_class +"\" id=\"vipbnr\" style=\"display:none;background:url("
		+ json[0].IMG1
		+ ") center 0 no-repeat;\">";

		vTmphtml += "<a href=\"javascript:///\" class=\"evtgo\" onclick=\"go_banner_link('" + json[0].JURL1	+ "','"+ json[0].TXT1 + "');\">" + json[0].TXT1 + "</a>";
		vTmphtml += "<a href=\"javascript:///\" onclick=\"new_close_floating('vipbnr');\" class=\"btnclose\">닫기</a>";
		vTmphtml += "</span>";
		
		$("#floating_banner").html(vTmphtml);

		if (fnGetCookie2010("vip_promotion") != "vipbnr") {
			$(".vip_bnr").show();
		}
	});

}

function getMainTopBanner(){
	var loadUrl = "http://ad-api.enuri.info/enuri_M/m_all/W1/bundle?bundlenum=3";

	$.getJSON(loadUrl,function(json){	
		
		if ( fnGetCookie2010('linkerEvtTop') != "CHECKED" ) {
			if(json[0]){
				$("header").prepend($("#homeBanner").tmpl(json[0]));
			}
		}
	});
}
function getMainFooterBanner(){
	var loadUrl = "http://ad-api.enuri.info/enuri_M/m_all/W2/bundle?bundlenum=3";
	$.getJSON(loadUrl,function(json){
		if ( fnGetCookie2010('linkerEvtTop') != "CHECKED" ) {
			 if(json[0]) {
				 //$(".family_app").after($("#footerBanner").tmpl(json[0]));
				 var banJson = json[0];
				 
				 var fbannerHtml = "<div class='aside_bnr'>"; 
				 	 fbannerHtml += "<a href='javascript:///' onclick=\"javascript:gofooterBannerLink('"+banJson.JURL1+"')\" >";
				 	 fbannerHtml += "<img src='"+banJson.IMG1+"' alt='"+banJson.ALT+"' >";
				 	 fbannerHtml += "</a>";
				 	 fbannerHtml += "</div>";
				 
				 	 $(".family_app").before(fbannerHtml);
			 }
		}
	});
}
function getLpMiddleBanner(){
	var cate4 = cate;
	if(cate.length > 4){
		cate4 = cate.substring(0,4);
	}
	
	var loadUrl = "http://ad-api.enuri.info/enuri_M/m_lp/M31/bundle?bundlenum=3&cate="+szCategoryPower.substring(0,4);
	
	/*
	if(cate4 == "1640" && isAdult == "true") {
		loadUrl = "http://ad-api.enuri.info/enuri_M/m_adult/M3a/bundle?bundlenum=3&cate=1640";
	}
	*/
	
	$.getJSON(loadUrl,function(json){

		if(json[0]) {
			var vTmphtml = "";
			
			vTmphtml += "<li class=\"midbanner\" id=\"lpmiddlebanner\">";
			vTmphtml += "	<div class=\"midbanner__inner\">";
			vTmphtml += "		<a href=\"javascript:;\"><img src=\""+ json[0].IMG1 +"\" alt=\"\" /></a>";
			vTmphtml += "	</div>";
			vTmphtml += "</li>";
			
			$(".powerlink").before(vTmphtml);
			
			$("#lpmiddlebanner").unbind("click");
			$("#lpmiddlebanner").click(function(){
				if(json[0].JURL1.indexOf("freetoken=outlink") > -1 ){
					window.open(json[0].JURL1);
				}else{
					location.href = json[0].JURL1;	
				}
			});
		 }
	});
}

function getSrpMiddleBanner(){
	var loadUrl = "http://ad-api.enuri.info/enuri_M/m_srp/MS1/bundle?bundlenum=3";
	
	$.getJSON(loadUrl,function(json){

		if(json[0]) {
			var vTmphtml = "";
			
			vTmphtml += "<section class=\"srpbanner\" id=\"srpmiddlebanner\">";
			vTmphtml += "	<div class=\"srpbanner__inner\">";
			vTmphtml += "		<a href=\"javascript:;\"><img src=\""+ json[0].IMG1 +"\" alt=\"\" /></a>";
			vTmphtml += "	</div>";
			vTmphtml += "</section>";
			
			// 중고차 앞
			$(".reborn_section").before(vTmphtml);
			
			$("#srpmiddlebanner").unbind("click");
			$("#srpmiddlebanner").click(function(){
				if(json[0].JURL1.indexOf("freetoken=outlink") > -1 ){
					window.open(json[0].JURL1);
				}else{
					location.href = json[0].JURL1;	
				}
				
			});
		 }
	});
}
