jQuery(document).ready(function(){
	try{
		topBannerInit();
	}catch(e){}
});
function topBannerInit() {
	var ajaxObj = jQuery.ajax({
		type : "get",
		url : "http://ad-api.enuri.info/enuri_PC/pc_home/O1/req",
		async: true,
		cache: false,
		data : param,
		dataType : "json",
		success: function(json) {
			var TXT1 = json["TXT1"];
			var JURL1 = json["JURL1"];
			var IMG1 = json["IMG1"];
			var TARGET = json["TARGET"];
			var BGCOLOR = json["BGCOLOR"];

			var topBannerNewObj = jQuery("#topBannerNew");
			var html = "";
			html += "<div class=\"header-top-over__bnr\" style=\"background-color: "+BGCOLOR+";\">";
			html += "	<a href=\""+JURL1+"\" target=\"_new\" style=\"background-image: url('"+IMG1+"');\"></a>";
			html += "</div>";
			html += "<button type=\"button\" class=\"header-top__btn--close comm__sprite\" onclick=\"jQuery(this).parent().slideUp(300);jQuery('.header_top_expand_ad_img.btn_close_expand_img').trigger('click');\">닫기</button>";
			topBannerNewObj.html(html);

		},
		error: function (xhr, ajaxOptions, thrownError) {
			var topBannerNewObj = jQuery("#topBannerNew");
			var html = "";
			html += "<div class=\"header-top-over__bnr\" style=\"background-color: #60BED1\">";
			html += "	<a href=\"/knowcom/index.jsp\" target=\"_new\" style=\"background-image: url('http://image.enuri.info/images/main/topbanner.jpg');\"></a>";
			html += "</div>";
			html += "<button type=\"button\" class=\"header-top__btn--close comm__sprite\" onclick=\"jQuery(this).parent().slideUp(300);\">닫기</button>";
		
			topBannerNewObj.html(html);
		}
	});
}