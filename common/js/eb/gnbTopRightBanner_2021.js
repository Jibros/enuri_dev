var currImgNum = 0;
var totImgNum = 0;
var isoverbanner = false;
jQuery(function(){
	var arrHtml = [];

	//json 파일 서버 내 저장함에 따라 주석 처리, 서버에서 직접 처리 시 아래 주석 해제 필요
    //$.getJSON("/common/jsp/eb/getGnbTopRight_Json.jsp",{url:encodeURIComponent("http://ad.enuri.com/NetInsight/bundle/PC_Enuri_Site/GNB_Enuri/GNB@GNB_Upper_right")},function(jsonObj){
	//$.getJSON("/jca/main/json/GNB_Upper_right.json",function(jsonObj){
	//$.getJSON("/common/jsp/eb/getGnbTopRight_Json.jsp",{url:encodeURIComponent("http://adsvc.enuri.mcrony.com/enuri_PC/pc_main/B1/bundle?bundlenum=6")},function(jsonObj){
	
	//try {
		//jQuery.getJSON("/jca/main/json/B1.json",function(jsonObj){
		//jQuery.getJSON("/common/jsp/eb/getGnbTopRight_Json.jsp",{url:encodeURIComponent("http://ad-api.enuri.info/enuri_PC/pc_home/B1/bundle?bundlenum=6")},function(jsonObj){
		jQuery.getJSON("http://ad-api.enuri.info/enuri_PC/pc_home/B1/bundle?bundlenum=6",function(jsonObj){
			try {
				totImgNum = jsonObj.length-1;
		    	
				jQuery.each(jsonObj,function(i,o){
		    		arrHtml.push("	<a href=\"javascript:goBannerLink('" + o["TARGET"] +"', '"+o["JURL1"]+"');\" style=\"display: none;\">");
		    		arrHtml.push("		<img src=\""+o["IMG1"]+"\" alt=\"헤더 탑배너\" width=\"168\" height=\"60\">");
		    		arrHtml.push("	</a>");
		    	});
		    	// 2016.07.25. 랜덤 제외. 무조건 첫번재부터 + 5초단위 자동 롤링.
		    	currImgNum = 0;
		    	// currImgNum = Math.round(Math.random()*totImgNum);
		
		    	jQuery("#bannerList").html(arrHtml.join("")).find("> a:eq(" + currImgNum + ")").show();
		    	setTimeout(function(){ 
			    	// 5초단위 자동 롤링.
			    	setInterval(function(){
			    		// 마우스 오버되어 있으면 롤링 멈춤
			    		if (isoverbanner){
			    			return;
			    		}
			
			    		// 우클릭 효과.
			    		if(++currImgNum>totImgNum){
			            	currImgNum = 0;
			    		}
			
			            moveBanner();
			
			    	}, (5 * 1000) ); // 5초.
		    		
		    	}, 3000);
		    	
		    	// 마우스 오버시 롤링 멈춤
		    	jQuery("#bannerList").mouseover(function(){
		    		isoverbanner = true;
		    	});
		
		    	// 마우스 오버 풀리면 다시 롤링 시작
		    	jQuery("#bannerList").mouseout(function(){
		    		isoverbanner = false;
		    	});
		
		        // 배너 좌로 이동
		    	if(jsonObj.length > 1){
		    	
			        jQuery("#move_banner_left").click(function(){
			            if(--currImgNum==-1)   currImgNum = totImgNum;
			            moveBanner();
			        });
			        // 배너 우로 이동
			        jQuery("#move_banner_right").click(function(){
			            if(++currImgNum>totImgNum) currImgNum = 0;
			            moveBanner();
			        });
		    	}else{
		    		jQuery("#move_banner_left").remove();
		    		jQuery("#move_banner_right").remove();
		    	}
			} catch(exception){
				jQuery("#bannerList").hide();
			}
	    })
	    //.error(function(e) { $("#bannerList").hide(); });
	/*} catch (Exception) {
		jQuery("#bannerList").hide();
	}*/
	
    function moveBanner(){
    //	insertLog(12472);
    	jQuery("#bannerList > a:eq(" + currImgNum + ")").show().siblings().hide();
    }
});