<script>
var expTopBanner = false;

jQuery(document).ready(function(){
	try{
			topBannerInit();
	}catch(e){}
// 	    setTimeout("topBannerInit()",1000);
});
function fnInitExpTopBanner(){
    jQuery(".bnr_up.btclose").click(function(){
        jQuery(".downbnr").slideUp();
        insertLog(13676);
    });

    jQuery(".bnrtxt > a").click(function(){
        insertLog(13675);
    });

    var loc = location.href.toString().replace(/http:\/\/.*\/(.*)/,"$1");

    if(loc == "" || loc.indexOf("Index.jsp")==0){
        if(!eval(fnGetCookie2010("expTopBanner"))){
            expTopBanner = true;

            fnSetCookie2010("expTopBanner","true",3);

            jQuery(".downbnr").slideDown();
            insertLog(13674);

            setTimeout("jQuery('.downbnr').slideUp();",4000);
        }
    }
}

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
			var html = "<a class=\"banner_inner\" href=\""+JURL1+"\" target=\"_new\" ";
			html += "style=\"background-image: url('"+IMG1+"');\">";
			//html += "	<button class=\"btn_close\">닫기</button>";
			html += "</a>";

			topBannerNewObj.html(html);
			topBannerNewObj.css("background-color", BGCOLOR);

			topBannerNewObj.find(".btn_close").click(function(e) {
				var offsetHeight = 69;

				topBannerNewObj.slideUp().queue(function() {
					jQuery("#aside").css("top","-=" + offsetHeight );

					if(borwserName!="msie8"){
						jQuery("#bannerId56").css("top","-=" + offsetHeight);
						jQuery("#div_speed_reg").css("top","-=" + offsetHeight);
					}

					if(jQuery("#rightBanner > div").length > 1){
						jQuery("#rightBanner > div").eq(1).css("top","-=" + offsetHeight);
					}
					if(jQuery("#mainLeftDiv > div").length > 1){
						jQuery("#mainLeftDiv").css("top","-=" + offsetHeight);
					}
						
				});

				e.stopPropagation();
				e.preventDefault();
			});

			//jQuery("#cbNoMoreViewTopBanner").attr("seqno",validList[rndValue][7]).click(function(e) {
			//	jQuery("#top_banner_closer").trigger("click");
			//	fnSetCookie2010("topbanner_"+validList[rndValue][7],"checked",1);
			//});
		},
		error: function (xhr, ajaxOptions, thrownError) {
			//ADìë² ë°°ë ììë ëí´í¸ ë°°ë
			var topBannerNewObj = jQuery("#topBannerNew");
			var html = "<a class=\"banner_inner\" href=\"/knowcom/index.jsp\" target=\"_new\" ";
			html += "style=\"background-image: url('<%=ConfigManager.IMG_ENURI_COM%>/images/main/topbanner.jpg');\">";
			html += "	<button class=\"btn_close\">닫기</button>";
			html += "</a>";



			topBannerNewObj.html(html);
			topBannerNewObj.css("background-color", "#60BED1");

			topBannerNewObj.find(".btn_close").click(function(e) {
				var offsetHeight = 69;

				topBannerNewObj.slideUp().queue(function() {
					jQuery("#aside").css("top","-=" + offsetHeight );

					if(borwserName!="msie8")
						jQuery("#bannerId56").css("top","-=" + offsetHeight);

					jQuery("#div_speed_reg").css("top","-=" + offsetHeight);

					if(jQuery("#rightBanner > div").length > 1)
						jQuery("#rightBanner > div").eq(1).css("top","-=" + offsetHeight);
				});

				e.stopPropagation();
				e.preventDefault();
			});
			//alert(xhr.status);
			//alert(thrownError);
			//console.log("thrownError="+thrownError);
		}
	});
	fnOpenTopBanner();
}
function fnGoPage(url,log){
    window.open(url);

    if(log != null && log != undefined)
        insertLog(log);
}
function fnOpenTopBanner(){
    var offsetHeight = 69;

    jQuery("#topBannerNew").css({"overflow":"hidden"}).show();
//     jQuery("#topBannerNew").css({"height" : offsetHeight+"px","overflow":"hidden"}).slideDown();

    jQuery("#aside").css("top","+=" + offsetHeight);
    jQuery("#div_speed_reg").css("top","+=" + offsetHeight);
    jQuery("#bannerId56").css("top","+=" + offsetHeight);

    if(jQuery("#rightBanner > div").length > 1)
    	jQuery("#rightBanner > div").eq(1).css("top","+=" + offsetHeight);

    setTimeout("fnInitExpTopBanner()",1000);
}
</script>