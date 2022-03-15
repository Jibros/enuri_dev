jQuery(document).ready(function(){
	setTimeout("topBannerInit()",1000);
});

function topBannerInit(){
	var bannerList = new Array();
	var validList  = new Array();
	
	var rndValue  = 0;
	
	bannerList.push(['2015090910','2015093023','/images/banner_2015/top_banner_150907_bg.jpg','/images/banner_2015/top_banner_150907.jpg','/event/Thanksgiving.jsp'		,12687 ,20]);	
	bannerList.push(['2015090110','2015093023','/images/banner_2015/top_banner_150828_bg.jpg','/images/banner_2015/top_banner_150828.jpg','/event/eventAppInstall2.jsp'	,12666 ,20]);
	
	for(i=0;i<bannerList.length;i++)
		if(parseInt(fnGetDate2()) >= parseInt(bannerList[i][0]) &&  parseInt(fnGetDate2()) <= parseInt(bannerList[i][1]))
			validList.push(bannerList[i]);
	
	//rndValue = Math.floor(Math.random()*validList.length);

	if(validList.length>0){
		if(validList.length>1){
			var accumulativeValue = 0;
			
			for(i=0;i<validList.length;i++){
				validList[i].push(accumulativeValue += validList[i][6]);
			}
			
			rndValue = Math.floor(Math.random()*accumulativeValue);
	
			var i =0;
			
			while(rndValue > validList[i][7] && i < validList.length){
				i++;
			}
			
			rndValue = i;
		}

		var exceptionPage = [validList[rndValue][4],"/event/EventMassMarketing2End.jsp","stampEvent_ReviewPage.jsp","stampEventMain.jsp","/tour2012/","Event_Department_Open_Main.jsp","prizeEventMain.jsp","prizeEvent_WinnerList.jsp","eventDiscount2Main.jsp","eventNewServicesMain.jsp","eventMassMaketingMain.jsp","/event/eventMassMaketingViral.jsp","/etc/planevent/PlanList.jsp?plan_no=47","EventMassMarketing2Main.jsp","/etc/planevent/PlanList.jsp?plan_no=54","/event/eventAppInstall.jsp"];
		var isException = false;

		for(i=0;i<exceptionPage.length && !isException;i++)
			if(top.location.href.indexOf(exceptionPage[i]) > 0)
				isException = true;

		if(!isException){
			jQuery("#topBannerNew").css({"background-image":"url(http://img.enuri.info" + validList[rndValue][2] + ")","background-repeat":"repeat-x"});

			jQuery("#topBannerNew > .banner_inner")
			.css("background-image","url(http://img.enuri.info" + validList[rndValue][3] + ")")
			.click(function(){
				fnGoPage(validList[rndValue][4],validList[rndValue][5]);
			});

			document.getElementById("top_banner_closer").onclick = fnCloseTopBanner;

			fnOpenTopBanner();
		}
	}
}
function fnGetDate2(){
	var date = new Date();

	return String(date.getFullYear()) + String((String(date.getMonth()).length == 1 ? "0" : "") + (date.getMonth() + 1)) + String((String(date.getDate()).length == 1 ? "0" : "") + date.getDate()) + String((String(date.getHours()).length == 1 ? "0" : "") + date.getHours());
}

function fnGoPage(url,log){
	var e = window.event;
	window.open(url);

	if(log != null && log != undefined)
		insertLog(log);

    e.cancelBubble = true;
    e.returnValue = false;

    if (e.stopPropagation) {
        e.stopPropagation();
        e.preventDefault();
    }
}

function fnOpenTopBanner(){
	var offsetHeight = 69;

	jQuery("#topBannerNew").css({"height" : offsetHeight+"px","overflow":"hidden"}).slideDown();

	jQuery("#aside").css("top","+=" + offsetHeight);
	jQuery("#div_speed_reg").css("top","+=" + offsetHeight);
	jQuery("#bannerId56").css("top","+=" + offsetHeight);

	if($("#rightBanner > div").length > 1)
		$("#rightBanner > div").eq(1).css("top","+=" + offsetHeight);

}

function fnCloseTopBanner(){
	var e = window.event;
	var offsetHeight = 69;

	jQuery("#topBannerNew").slideUp().queue(function(){
		jQuery("#aside").css("top","-=" + offsetHeight );
		jQuery("#bannerId56").css("top","-=" + offsetHeight);
		jQuery("#div_speed_reg").css("top","-=" + offsetHeight);

		if($("#rightBanner > div").length > 1)
			$("#rightBanner > div").eq(1).css("top","-=" + offsetHeight);
	});

	e.cancelBubble = true;
    e.returnValue = false;

    if (e.stopPropagation) {
        e.stopPropagation();
        e.preventDefault();
    }
}