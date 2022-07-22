var isDev = (top.location.href.indexOf("dev.enuri.com") > -1 
			|| top.location.href.indexOf("dev2.enuri.com") > -1
			|| top.location.href.indexOf("100.100.100.234") > -1)
			|| top.location.href.indexOf("100.100.100.151") > -1 
			|| top.location.href.indexOf("27.122.133.189") > -1 
			|| top.location.href.indexOf("localhost") > -1;

var isDev2 = (top.location.href.indexOf("dev2.enuri.com") > -1 );
var isDev3 = (top.location.href.indexOf("stagedev.enuri.com") > -1 );

var bannerLoadYN = false;
$(function(){ // 메인 > 카테고리 퍼블 테스트용
    var $catemain = $(".cate-main");
    var $cateExtend = $(".cate-main__extend");
    var $depth1 = $(".cate-main .cate-item--depth1");
    var $depth3 = $(".cate-main .cate-item--depth3");
    var $depth4 = $(".cate-main .cate-item--depth4");
    var delayTimer;
    var delayTime = 50;
    $catemain.on({
        "mouseleave" : function(){
            $depth1.removeClass("is--on");
            $cateExtend.removeClass("is--show");
        }
    })
    $depth1.on({
        "mouseenter" : function(){
            var $t = $(this);
            delayTimer = setTimeout(function(){
                if ( !$t.hasClass('is--empty') ){
                    $t.addClass("is--on").siblings().removeClass("is--on");                            
                    $cateExtend.addClass("is--show");
                    
                    var inx = $t.index();
                    
                    if($.trim($("#first_depth" + inx).html()) == ""){
                    	var getUrl = "";
                    	
						if (isDev) getUrl = "/wide/main/ajax/Ajax_Itg_Gnb_Src_2022_main.jsp?g_seq=" + (inx + 1); 
						//else if(isDev2) 		getUrl = "/wide/main/ajax/Ajax_Gnb_Src_2021_main_nw_dev2.jsp?g_seq="+(inx+1);
						//else if(isDev)	getUrl = "/wide/main/ajax/Ajax_Gnb_Src_2021_main_nw.jsp?g_seq="+(inx+1);
						else getUrl = "/wide/main/ajax/main_Itg_CateList_2022_" + inx + ".html"; 
                    	
                    	$.ajax({
                    	    url: getUrl,
                    	    cache: false,
                    	    dataType: "html",
                    	    success: function(v) {
                    	    	$("#first_depth"+inx).html(v);
                    	    	
                    	    	var ison = $("#first_depth"+inx).find("li.cate-item.cate-item--depth3").hasClass("is--on");
                    	    	if(!ison){
                    	    		$("#first_depth"+inx).find("li.cate-item.cate-item--depth3").eq(0).addClass("is--on");
                    	    	}
                    	    	
                    	    }
                    	});
                    	
                    }
                    
                }
            },delayTime);
            
            if($(".cate-main-bnr__list").html() == "" && !bannerLoadYN){
            	fnSetGnbBanner();
            	setTimeout(function(){ 
            		fnBannerRoller();	
            	}, 500);
            	bannerLoadYN = true;
            }
            
        },"mouseleave" : function(){
            clearTimeout(delayTimer);
        }
    });
    $("body").on('mouseenter', '.cate-item--depth3' , function(e) {
            var $t = $(this);
            delayTimer = setTimeout(function(){
            	$t.parent().parent().parent().find("li.cate-item--depth3").removeClass("is--on");
                $t.addClass("is--on");
            },delayTime);
    });
     $("body").on('mouseleave', '.cate-main .cate-item--depth3' , function(e) {
    	 clearTimeout(delayTimer);
    });
    $("body").on('mouseenter', '.cate-main .cate-item--depth4' , function(e) {
            var $t = $(this);
            delayTimer = setTimeout(function(){
                //$(".cate-main .cate-item--depth4").removeClass("is--on");
                //$t.addClass("is--on");
            	$t.addClass("is--on").siblings().removeClass("is--on");
            },delayTime);
            /*
            var inx = $t.index();
			switch(inx){
				case 1 : insertLog(24300);break;
				case 2 : insertLog(24301);break;
				case 3 : insertLog(24302);break;
				case 4 : insertLog(24303);break;
				case 5 : insertLog(24304);break;
				case 6 : insertLog(24305);break;
				case 7 : insertLog(24306);break;
				case 8 : insertLog(24307);break;
				case 9 : insertLog(24308);break;
				case 10: insertLog(24309);break;
				case 11: insertLog(24310);break;
			}
			*/
    });
     $("body").on('mouseleave', '.cate-main .cate-item--depth4' , function(e) {
    	 clearTimeout(delayTimer);
    });

	$("body").on('mouseenter', '.cate-main .cate-item--depth5', function(e) { 
		$(this).addClass("is--on").siblings().removeClass("is--on");
			
			$(".cate-main .cate-item--depth5").each(function(index, item) {
				if ($(item).hasClass('is--on')) {
					$(item).find('.cate--tree').stop().slideDown();
				} else {
					$(item).find('.cate--tree').stop().slideUp();
				}
			})
	});
});
$1DepthList = $("#main_left_cate > li");

//Banner Json 파일명 (/jca/main/json/ 파일명.json) 현재사용 안함
//var adServerLinkList = ["B21","B22","B23","B24","B25","B26","B27","B28"];

var adServerLinkList = ["B21","B22","B23","B24","B25","B26","B27","B28", "B29", "B210" , "B2110" ];

function fnSetGnbBanner(){
	var url = isDev > 0 ? "/wide/main/ajax/Ajax_Gnb_Src_2021_main_nw.jsp?stype=banner" : "/wide/main/ajax/mainCateBanner_data_2021.json";
	//jQuery.getJSON(url,null,function(data){

	$.ajax({
	    cache: false,
	    url: url,
	    type:'post',
	    dataType: "json",
	    success: function(data) {

		var bannerList = data["gnbBanner"];
		jQuery.each(bannerList,function(i,banners){
			jQuery.each(banners["banner"],function(j,banner){
				var html = "";

				var bannerLogYN = false;

				if(parseInt(banner["source"])==0){
					
					//if(i == 7 && j == 0)	bannerLog = "insertLog(17912)"; //패션 첫번째 배너만 클릭로그 넣어준다
					//else					bannerLog = "";

					if(i == 0)		bannerLog = "insertLog(26746)"; 
					else if(i == 1)	bannerLog = "insertLog(26747)";
					else if(i == 2)	bannerLog = "insertLog(26748)";
					else if(i == 3)	bannerLog = "insertLog(26749)";
					else if(i == 4)	bannerLog = "insertLog(26750)";
					else if(i == 5)	bannerLog = "insertLog(26751)";
					else if(i == 6)	bannerLog = "insertLog(26752)";
					else if(i == 7)	bannerLog = "insertLog(26753)";
					else if(i == 8)	bannerLog = "insertLog(26754)";
					else if(i == 9)	bannerLog = "insertLog(26755)";
					else if(i == 10)	bannerLog = "insertLog(26756)";
					
					switch(parseInt(banner["linktype"])){
						case 1 : {
							html = "<li class='cate-main-bnr__item'><a href='"+banner["link"]+"' onclick='"+bannerLog+"' target='_blank'><img alt=\"\" src=\"" + banner["img"] + "\"></a></li>";break;
						}
						case 2 : {
							html = "<li class='cate-main-bnr__item'><a href='"+banner["link"]+"' onclick='"+bannerLog+"' target='_blank'><img alt=\"\" src=\"" + banner["img"] + "\"></a></li>";break;
						}
						case 3 : {
							html = "<li class='cate-main-bnr__item'><a href='"+banner["link"]+"'onclick='"+bannerLog+"' target='_blank'><img alt=\"\" src=\"" + banner["img"] + "\"></a></li>";break;
						}
					}
				}else{
					html = "<li class='cate-main-bnr__item is--on 4'><a href=\"" + "/move/Redirectad.jsp?register_no="+banner["no"]+"&pageNm=gnb" + "\"><img alt=\"\" src=\"" + banner["img"] + "\"></a></li>";
				}

				var $bannerArea = $1DepthList.eq(i).find("#banner__inner");

				$bannerArea.find("ul").append(html);
				$bannerArea.find("ul > li:first-child").addClass("is--on");

				if(banners["banner"].length > 1){
					//$bannerArea.find("div.cate-main-bnr__paging").append("<button class='cate-main-bnr__btn' data-id="+j+">"+j+"</button>");
					//$bannerArea.find("div.cate-main-bnr__paging button:first-child").addClass("is--active");
					
					$bannerArea.find("div.cate-main-bnr__paging").append(" <button class=\"cate-main-bnr__btn\" data-id="+j+" >"+j+"</button> ");
					$bannerArea.find("div.cate-main-bnr__paging button:first-child").addClass("is--active");
				}
			});
			var loadJson = adServerLinkList[i];
			var adUrl = adServerLinkList[i];
			
			if(adUrl==""){
				return false;
			}
			
			adUrl = adUrl.substring((adUrl.indexOf("@") + 1), adUrl.length);
			
			//ad서버 사용 신규 배너 추가
			var varBannerUrl = "";
			switch(parseInt(i+1)){
				case 1 : varBannerUrl = "http://ad-api.enuri.info/enuri_PC/pc_home/B21/bundle?bundlenum=2";break;
				case 2 : varBannerUrl = "http://ad-api.enuri.info/enuri_PC/pc_home/B22/bundle?bundlenum=2";break;
				case 3 : varBannerUrl = "http://ad-api.enuri.info/enuri_PC/pc_home/B23/bundle?bundlenum=2";break;
				case 4 : varBannerUrl = "http://ad-api.enuri.info/enuri_PC/pc_home/B24/bundle?bundlenum=2";break;
				case 5 : varBannerUrl = "http://ad-api.enuri.info/enuri_PC/pc_home/B25/bundle?bundlenum=2";break;
				case 6 : varBannerUrl = "http://ad-api.enuri.info/enuri_PC/pc_home/B26/bundle?bundlenum=2";break;
				case 7 : varBannerUrl = "http://ad-api.enuri.info/enuri_PC/pc_home/B27/bundle?bundlenum=2";break;
				case 8 : varBannerUrl = "http://ad-api.enuri.info/enuri_PC/pc_home/B28/bundle?bundlenum=2";break;
				case 9 : varBannerUrl = "http://ad-api.enuri.info/enuri_PC/pc_home/B29/bundle?bundlenum=2";break;
				case 10: varBannerUrl = "http://ad-api.enuri.info/enuri_PC/pc_home/B210/bundle?bundlenum=2";break;
				case 11: varBannerUrl = "http://ad-api.enuri.info/enuri_PC/pc_home/B211/bundle?bundlenum=2";break;
			}
			//$.getJSON("/common/jsp/eb/getHomeConnBanner.jsp", {url:varBannerUrl}, function(jsonObj) {
			$.getJSON(varBannerUrl, {}, function(jsonObj) {
				if(jsonObj && jsonObj!=undefined) {
					var html = "";
					
					if (jsonObj.length > 1) {
						var sortingField = "SORT";
						jsonObj.sort(function(a, b) { // 오름차순
						    return a[sortingField] - b[sortingField];
						});
					}
			    	$.each(jsonObj,function(s,o){
			    		
			    		if(o["TARGET"]!=""){
				    		switch(parseInt(o["TARGET"])){
								case 1 : {
									html = "<li class='cate-main-bnr__item' ><a href='"+o["JURL1"]+"' target='_blank'><img alt=\"\" src=\"" + o["IMG1"] + "\"></a></li>";break;
								}
								case 2 : {
									html = "<li class='cate-main-bnr__item'><a href='"+o["JURL1"]+"' target='_blank'><img alt=\"\" src=\"" + o["IMG1"] + "\"></a></li>";break;
								}
								case 3 : {
									html = "<li class='cate-main-bnr__item'><a href='"+o["JURL1"]+"' target='_blank'><img alt=\"\" src=\"" + o["IMG1"] + "\"></a></li>";break;
								}
							}
					    	if(html != ""){
								var $bannerArea = $1DepthList.eq(i).find("#banner__inner");
								
								$bannerArea.find("ul").append(html);
								$bannerArea.find("ul > li:first-child").addClass("is--on");

								try{
									var dotint = $bannerArea.find("ul > li").length;

									//$bannerArea.find(".bannerdot").append("<span class='bannerdot__item' data-id="+(dotint-1)+"></span>");
									//$bannerArea.find(".bannerdot span:first-child").addClass("is-on");
									
									$bannerArea.find("div.cate-main-bnr__paging").append("<button class=\"cate-main-bnr__btn\">"+dotint+"</button> ");

								}catch(ex){
									console.log(ex);
								}
							}
			    		}
			    	});
			    	/*
					var $bannerArea = $1DepthList.eq(i).find("#banner__inner");
					
					$bannerArea.find("ul").append(html);
					$bannerArea.find("ul > li:first-child").addClass("is--on");
					
					try{
						var dotint = $bannerArea.find("ul > li").length;

						for(i=0;i<dotint;i++){
							$bannerArea.find(".bannerdot").append("<span class='bannerdot__item' data-id="+(dotint-1)+"></span>");
						}
						$bannerArea.find(".bannerdot span:first-child").addClass("is-on");

					}catch(ex){
						console.log(ex);
					}
					*/
				}
			});
		});
		fnSetBannerIconOver();
		//fnBannerRoller();
	    }
	});
}
function fnSetBannerIconOver(){
    $("body").on('mouseenter', '.cate-main-bnr__paging > button' , function(e) {
    	var inx = $(this).index();
    	$(this).parent().parent().find("ul > li").eq(inx).addClass("is--on").siblings().removeClass('is--on');
    	$(this).addClass("is--active").siblings().removeClass('is--active');
    	e.cancelBubble = true;
	    e.returnValue = false;
    });
}
function fnBannerRoller(){
	//console.log("fnBannerRoller");
	try{
		var timer = new Array();
		
		$1DepthList.each(function(i,v){
		
			if($(this).is(".cate-item--depth1.is--empty")) return false;
			
				var $BannerArea1 = $("#cateBanner"+i+"> li");
				var $BannerBtn1  = $("#cateBannerBot"+i);

				var bannerCnt = $BannerArea1.length;
				
				rollerStarter = function(num){
					
					var bannerPage = 0;
					var inx = 0;
					
					if(num == "" ){
						
						timer[i] = setInterval(function(){
							
							if(bannerCnt == bannerPage)  bannerPage = 0;
							
							$BannerArea1.eq(bannerPage).addClass("is--on").siblings().removeClass('is--on');
							$BannerBtn1.find("button").eq(bannerPage).addClass("is--active").siblings().removeClass('is--active');
							
							bannerPage++;
							
						},3000);
						
					}else{
						//inx = num;
						$("#cateBanner"+num+"> li").each(function(i,v){				
							if($(this).hasClass("is--on")){
								bannerPage = i;
							}
						});
						
						timer[num] = setInterval(function(){
							
							bannerCnt = $("#cateBanner"+num+"> li").length;			
							
							if(bannerCnt == bannerPage)  bannerPage = 0;
							
							$("#cateBanner"+num+"> li").eq(bannerPage).addClass("is--on").siblings().removeClass('is--on');
							$("#cateBannerBot"+num).find("button").eq(bannerPage).addClass("is--active").siblings().removeClass('is--active');
							
							bannerPage++;
							
						},3000);

					}				
				}
				rollerStopper = function(num){
					//console.log("rollerStopper");
					clearInterval(timer[num]); 
				}
				$BannerArea1.mouseenter(function(){
				//$("body").on('mouseenter', '.cate-main-bnr__list > li' , function(e) {
					var id = $(this).parent().attr("id");	
					var num = id.replace("cateBanner","");
					
					rollerStopper(num);
					
				});
				$BannerArea1.mouseleave(function(){
				//$("body").on('mouseleave', '.cate-main-bnr__list > li' , function(e) {
					
					var id = $(this).parent().attr("id");
					
					var id = $(this).parent().attr("id");
					var num = id.replace("cateBanner","");
					
					rollerStarter(num);
					
				});
				$BannerBtn1.mouseenter(function(e){
				//$("body").on('mouseenter', '.cate-main-bnr__paging' , function(e) {
					if(e.target.tagName.toLowerCase() != "button"){
						rollerStopper();
					}
			
				}).mouseleave(function(){
					rollerStarter();
				});
				rollerStarter(0);		
		});
				
	}catch(e){
		console.log(e);
	}
	/*
	var timer = new Array();
	var $BannerArea1 = $("#cateBanner0 > li");
	var $BannerBtn1  = $("#cateBannerBot0");
	
	var bannerCnt = $BannerArea1.length;
	
	rollerStarter1 = function(){
		var bannerPage = 0;
		timer[0] = setInterval(function(){
			
			if(bannerCnt == bannerPage)  bannerPage = 0;
			
			$BannerArea1.eq(bannerPage).addClass("is--on").siblings().removeClass('is--on');
			$BannerBtn1.find("button").eq(bannerPage).addClass("is--active").siblings().removeClass('is--active');
			
			bannerPage++;
			//console.log("rollerStarter"+rollerStarter);
			
	},3000)};

	rollerStopper1 = function(){
		console.log("rollerStopper");
		clearInterval(timer[0]); 
	}
	$BannerArea1.mouseenter(function(){
		console.log($(this).parent().attr("id"));
		rollerStopper1();
	});
	$BannerArea1.mouseleave(function(){
		console.log("www");
		rollerStarter1();
		
	});
	$BannerBtn1.mouseenter(function(e){
		if(e.target.tagName.toLowerCase() != "button"){
			rollerStopper1();
		}
	});
	*/
}
function allCate(){
	$('.cate-all').show();
	$('.cate-main').hide();
			
	if($.trim(jQuery("#all_cate").html())==""){
		jQuery.ajax({
			url: isDev ? "/wide/main/ajax/Ajax_Itg_Gnb_Src_2022_main.jsp?stype=allCate" : "/wide/main/ajax/ItgCateList_2022.html", 
			data : "html",
			success:function(data){
				
				$("#all_cate").html(data);

                $(function(){ // 헤더 > 카테고리 퍼블 테스트용
                    var $depth1 = $(".cate-all .cate-item--depth1");
                    var delayTimer;
                    var delayTime = 100;
                    $depth1.on({
                        "mouseenter" : function(){
                            var $t = $(this);
                            delayTimer = setTimeout(function(){
                                $t.addClass("is--on").siblings().removeClass("is--on");
                            },delayTime)
                            /*
                            var inx = $t.index();
                			switch(inx){
	            				case 1 : insertLog(24288);break;
	            				case 2 : insertLog(24289);break;
	            				case 3 : insertLog(24290);break;
	            				case 4 : insertLog(24291);break;
	            				case 5 : insertLog(24292);break;
	            				case 6 : insertLog(24293);break;
	            				case 7 : insertLog(24294);break;
	            				case 8 : insertLog(24295);break;
	            				case 9 : insertLog(24296);break;
	            				case 10: insertLog(24297);break;
	            				case 11: insertLog(24298);break;
                			}
                			*/
                        },"mouseleave" : function(){
                            clearTimeout(delayTimer);
                        }
                    })
                })
			}
		});
	}
	insertLog(24299);
}