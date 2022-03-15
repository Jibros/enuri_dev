jQuery("<meta name='format-detection' content='telephone=no'>").appendTo('head');

var $1DepthList;
var $2DepthList;
var $3DepthList;
var $4DepthList;

var g_seq = [1,2,3,4,5,6,7,8];

var isDev = (top.location.href.indexOf("dev.enuri.com") > -1 || top.location.href.indexOf("stagedev.enuri.com") > -1 || top.location.href.indexOf("100.100.100.234") > -1)
			|| top.location.href.indexOf("100.100.100.151") > -1 || top.location.href.indexOf("27.122.133.189") > -1 || top.location.href.indexOf("localhost") > -1;
//isDev = 0;
var gnbBannerInit = false;

jQuery(document).ready(function(){
	fnGnbInit();
	fnSetGnbWidthException();
	//isEnuriDomain();
	
	// 클릭 시 배너 이미지 호출 20201130 
	jQuery(document).on("click", "#gnbMenu .gmenu__item", function(){
		if(!gnbBannerInit) {
			fnSetGnbBanner();
			gnbBannerInit = true;
		}
	});
});

//에누리 도메인 또는 IP가 아닐 경우 www.enuri.com으로 rediret 시켜 버린다. (testServer들은 제외)
function isEnuriDomain() {
	var varDmainNm = rtnDomainName(top.location.href);

	//에누리 도메인이 아닌 경우 www.enuri.com으로 이동 시켜 버린다.
	if (!("enuri.com" == varDmainNm || "www.enuri.com" == varDmainNm || "dev.enuri.com" == varDmainNm || "m.enuri.com" == varDmainNm || "studydev.enuri.com" == varDmainNm
			|| "stagedev.enuri.com" == varDmainNm || "my.enuri.com" == varDmainNm || "localhost" == varDmainNm || top.location.href.indexOf("124.243.126.1") > -1 || top.location.href.indexOf("27.122.133.1") > -1
			 || top.location.href.indexOf("100.100.100.") > -1 || top.location.href.indexOf("192.168.213.214") > -1)) {
	//	alert(varDmainNm);
		location.href='http://www.enuri.com/';
	}
}
//도메인 추출 funtion : 정규식
function rtnDomainName(url) {
	var pattern = /^http:\/\/([a-z0-9-_\.]*)[\/\?]/i;
	url = url.match(pattern);
	url = url[1];
	// url = url.split('//');
	// url = url[1].substr(0,url[1].indexOf('/'));
	return url;
}

function fnSetGnbWidthException(){
	var $gnb = jQuery("#gnb");

	if($gnb.find(">.gnbarea").is(".Left"))
		$gnb.css("width","1000px");
}

function fnGnbInit(){
	$1DepthList = jQuery("#gnbMenu > li > a");

	fnSetGnb();
	fnSetGnbLog();
	//fnSetGnbBanner();
	fnExternalAreaClick();
}

function fnExternalAreaClick(){
	if(document.getElementById("enuriMenuFrame")){// LP
		var interval = setInterval(function(){
			if(jQuery(document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame")).attr("src")){
				clearInterval(interval);

				jQuery(document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame").contentWindow.document).ready(function(){
					jQuery(document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame").contentWindow.document).click(function(e){
						fnGnbOutsideClick(e);

						fnCloseSearchLayer(e);
					});
				});
			}
		},3000);
	}

	if(document.getElementById("searchListFrame")){	// SRP
		var interval = setInterval(function(){
			if(jQuery(document.getElementById("searchListFrame")).attr("src")){
				jQuery(document.getElementById("searchListFrame").contentWindow.document).ready(function(){
					jQuery(document.getElementById("searchListFrame").contentWindow.document).click(function(e){
						fnGnbOutsideClick(e);
						fnCloseSearchLayer(e);
					});
				});
			}
		},3000);
	}

	if(document.getElementById("ifBodyRead")){// 지식통
		var interval = setInterval(function(){
			if(jQuery(document.getElementById("ifBodyRead")).attr("src")){
				clearInterval(interval);

				jQuery(document.getElementById("ifBodyRead").contentWindow.document).ready(function(){
					jQuery(document.getElementById("ifBodyRead").contentWindow.document).click(function(e){
						fnGnbOutsideClick(e);
						fnCloseSearchLayer(e);
					});
				});
			}
		},3000);
	}
}

function fnGnbOutsideClick(e){
	if(e.target.innerHTML == "전체메뉴")
		return;

	if(jQuery("#gnbMenu > li > a.is-on").length > 0){
		if(e.target.className != "selected"){
			if(jQuery(e.target).parents("#gnbMenu").length==0){
				fnCloseGnbMenu();
			}
		}
	} else if(jQuery("#gnbAllMenu > li > a.is-on").length > 0){
		if(e.target.className != "selected"){
			if(jQuery(e.target).parents(".gnbAllMenu").length==0){
				fnCloseGnbAllMenu();
				
				jQuery("div.submenu").removeClass('is-show');
				jQuery("div.submenu").addClass('is-hidden');
				
				//jQuery(".menu-trigger").toggleClass("is-on");
			}
		}
	}
	
}

function fnCloseSearchLayer(e){
	if(e.target.className != "selected"){
		if(jQuery("#ac_layer_main"))
			if(jQuery("#ac_layer_main").css("display") != "none")
				toggleAutoMake();
	}
}

function fnCloseGnbMenu(){
	jQuery("#gnbMenu li a").removeClass("is-on");
	jQuery("#gnbMenu li div.submenu").removeClass("is-shown");
	jQuery("#gnbMenu li div.submenu").addClass("is-hidden");
	jQuery(".menu-trigger").removeClass("is-on");
}

function fnCloseGnbAllMenu(){
	//jQuery("#gnbAllMenu > li.on").removeClass("on");
	//jQuery("#gnb > div").toggle();

	jQuery("#gnbAllMenu li a").removeClass("is-on");
	jQuery("#gnbAllMenu li div.submenu").removeClass("is-shown");
	jQuery("#gnbAllMenu li div.submenu").addClass("is-hidden");

	jQuery("#gnbwrap__inner_all").hide();
	jQuery("#gnbwrap__inner_cate").show();
	
	jQuery(".menu-trigger").removeClass("is-on");

}

function attachAllMenu(data){
	jQuery("#gnbAllMenu").html(data).queue(function(){
		fnSetGnbAllCate();
	});

	jQuery("#gnbAllMenu > li").mouseenter(function(){

		jQuery(".submenu-trigger.js-trigger").removeClass("is-on");
		jQuery(this).find("a.submenu-trigger.js-trigger").addClass("is-on");

		jQuery("div.submenu.submenu-all").removeClass("is-show").addClass("is-hidden");

		jQuery(this).find("div.submenu").removeClass('is-hidden');
		jQuery(this).find("div.submenu").addClass('is-show');

	}).find("> a").click(function(event){
		jQuery("div.submenu").removeClass('is-show');
		jQuery("div.submenu").addClass('is-hidden');
		
		fnCloseGnbAllMenu();
		
		event.stopPropagation();
		event.preventDefault();
	});

	jQuery("#gnbAllMenu > li:last-child").click(function(event){
		jQuery("#gnbAllMenu > li.on").removeClass("on");
		jQuery("#gnb > div").toggle();

		event.stopPropagation();
	});

	jQuery(".all_view").wrap("<div class=\"gnbbox\"></div>");

}

function fnClickAllMenu(e,idx){

	idx = (idx == null ? 1 : idx);

	jQuery("#gnbMenu > li.on").removeClass("on");
	jQuery("#gnb > div").toggle();
	jQuery("#gnbAllMenu > li:nth-child(" + idx + ")").mouseenter();

	if(e) fnCloseSearchLayer(e);
}

function loadGnbAllMenu(idx){
	idx = (idx == null ? 1 : idx);

	jQuery.ajax({
		url : isDev ? "/common/jsp/Ajax_Gnb_Src_2020.jsp?stype=allCate" : "/common/jsp/AllCateList_2020.html",
		data : "html",
		success:function(data){
			attachAllMenu(data);
			fnClickAllMenu(null,idx);
		}
	});
}

//Banner Json 파일명 (/jca/main/json/ 파일명.json) 현재사용 안함
var adServerLinkList = ["B21","B22","B23","B24","B25","B26","B27","B28"];

function fnSetGnbBanner(){
	var url = isDev > 0 ? "/common/jsp/Ajax_Gnb_Src_2020.jsp?stype=banner" : "/common/js/eb/nGnbBanner_data_2018.json";
	//jQuery.getJSON(url,null,function(data){

	jQuery.ajax({
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
					if(i == 7 && j == 0)	bannerLog = "insertLog(17912)"; //패션 첫번째 배너만 클릭로그 넣어준다
					else					bannerLog = "";

					switch(parseInt(banner["linktype"])){
						case 1 : {
							html = "<li class='bannerlist__item'><a href=\"javascript://\" onclick=\"window.open('" + banner["link"]+ "');"+bannerLog+"\"><img alt=\"\" src=\"" + banner["img"] + "\"></a></li>";break;
						}
						case 2 : {
							html = "<li class='bannerlist__item'><a href=\"javascript://\" onclick=\"top.location.href = '" + banner["link"]+ "';\"><img alt=\"\" src=\"" + banner["img"] + "\"></a></li>";break;
						}
						case 3 : {
							html = "<li class='bannerlist__item'><a href=\"javascript://\" onclick=\"Main_OpenWindow('" + banner["link"]+ "','','804', " + window.screen.height + ", 'yes');\"><img alt=\"\" src=\"" + banner["img"] + "\"></a></li>";break;
						}
					}
				}else{
					html = "<li class='bannerlist__item is-on 4'><a href=\"" + "/move/Redirectad.jsp?register_no="+banner["no"]+"&pageNm=gnb" + "\"><img alt=\"\" src=\"" + banner["img"] + "\"></a></li>";
				}

				var $bannerArea = $1DepthList.eq(i).next().find("div.gnbanner__inner");

				$bannerArea.find(".bannerlist").append(html);
				$bannerArea.find(".bannerlist li:first-child").addClass("is-on");

				if(banners["banner"].length > 1){
					$bannerArea.find(".bannerdot").append("<span class='bannerdot__item' data-id="+j+"></span>");
					$bannerArea.find(".bannerdot span:first-child").addClass("is-on");
				}
			});

			var loadJson = adServerLinkList[i];
			var adUrl = adServerLinkList[i];
			adUrl = adUrl.substring((adUrl.indexOf("@") + 1), adUrl.length);

			//ad 서버 현재 사용 안함
			var varFilePath = "/jca/main/json/" + adUrl + ".json";
			//alert(varFilePath);
			//json 파일 서버 내 저장함에 따라 주석 처리, 서버에서 직접 처리 시 아래 주석 해제 필요
			//jQuery.getJSON("/common/jsp/eb/getGnbTopRight_Json.jsp",{url:adServerLinkList[i]},function(banner){

			jQuery.getJSON(varFilePath, {_: new Date().getTime()} , function(banner){
				var html = "";

				switch(parseInt(banner["TARGET"])){
					case 1 : {
						html = "<li class='bannerlist__item' ><a href=\"javascript://\" onclick=\"window.open('" + banner["JURL1"]+ "');\"><img alt=\"\" src=\"" + banner["IMG1"] + "\"></a></li>";break;
					}
					case 2 : {
						html = "<li class='bannerlist__item'><a href=\"javascript://\" onclick=\"top.location.href = '" + banner["JURL1"]+ "';\"><img alt=\"\" src=\"" + banner["IMG1"] + "\"></a></li>";break;
					}
					case 3 : {
						html = "<li class='bannerlist__item'><a href=\"javascript://\" onclick=\"Main_OpenWindow('" + banner["JURL1"]+ "','','804', " + window.screen.height + ", 'yes');\"><img alt=\"\" src=\"" + banner["IMG1"] + "\"></a></li>";break;
					}
				}

				if(html != ""){
					//var $bannerArea = $1DepthList.eq(i).find("> .back_img > .snblist > .ad_area");
					//$bannerArea.find("> .adarea_h > ul").append(html);
					//$bannerArea.find("> .bnr_dot > span.right").before("<span class=anchors></span>");

					//var $bannerArea = $1DepthList.eq(i).next().find("div.gnbanner__inner");
					var $bannerArea = $1DepthList.eq(i).parent().find("div.gnbanner__inner");

					$bannerArea.find(".bannerlist").append(html);
					$bannerArea.find(".bannerlist li:first-child").addClass("is-on");

					try{
						var dotint = $bannerArea.find(".bannerlist > li").size();

						//for(i=0;i<dotint;i++){
							$bannerArea.find(".bannerdot").append("<span class='bannerdot__item' data-id="+(dotint-1)+"></span>");
						//}
						$bannerArea.find(".bannerdot span:first-child").addClass("is-on");

					}catch(ex){
						console.log(ex);
					}

				}
			}).always(function(){
				fnSetBannerIconOver();
			});
			fnSetBannerIconOver();
			
			//ad서버 사용 신규 배너 추가
			var varBannerUrl = "";
			switch(parseInt(i+1)){
				case 1 : {
					varBannerUrl = "http://ad-api.enuri.info/enuri_PC/pc_home/B211/req";break;
				}
				case 2 : {
					varBannerUrl = "http://ad-api.enuri.info/enuri_PC/pc_home/B221/req";break;
				}
				case 3 : {
					varBannerUrl = "http://ad-api.enuri.info/enuri_PC/pc_home/B231/req";break;
				}
				case 4 : {
					varBannerUrl = "http://ad-api.enuri.info/enuri_PC/pc_home/B241/req";break;
				}
				case 5 : {
					varBannerUrl = "http://ad-api.enuri.info/enuri_PC/pc_home/B251/req";break;
				}
				case 6 : {
					varBannerUrl = "http://ad-api.enuri.info/enuri_PC/pc_home/B261/req";break;
				}
				case 7 : {
					varBannerUrl = "http://ad-api.enuri.info/enuri_PC/pc_home/B271/req";break;
				}
				case 8 : {
					varBannerUrl = "http://ad-api.enuri.info/enuri_PC/pc_home/B281/req";break;
				}
			}
			//varBannerUrl = "http://ad-api.enuri.info/pcshop/ep_home/P3/bundle?bundlenum=1";
			
			//$.getJSON("/common/jsp/eb/getHomeConnBanner.jsp", {url:varBannerUrl}, function(jsonObj) {
			$.getJSON(varBannerUrl, function(jsonObj) {
				if(jsonObj && jsonObj!=undefined) {
					var html = "";
			    	$.each(jsonObj,function(i,o){
			    		if(jsonObj["TARGET"]!=""){
				    		switch(parseInt(jsonObj["TARGET"])){
								case 1 : {
									html = "<li class='bannerlist__item' ><a href=\"javascript://\" onclick=\"window.open('" + jsonObj["JURL1"]+ "');\"><img alt=\"\" src=\"" + jsonObj["IMG1"] + "\"></a></li>";break;
								}
								case 2 : {
									html = "<li class='bannerlist__item'><a href=\"javascript://\" onclick=\"top.location.href = '" + jsonObj["JURL1"]+ "';\"><img alt=\"\" src=\"" + jsonObj["IMG1"] + "\"></a></li>";break;
								}
								case 3 : {
									html = "<li class='bannerlist__item'><a href=\"javascript://\" onclick=\"Main_OpenWindow('" + jsonObj["JURL1"]+ "','','804', " + window.screen.height + ", 'yes');\"><img alt=\"\" src=\"" + jsonObj["IMG1"] + "\"></a></li>";break;
								}
							}
			    		}
			    	});
					if(html != ""){
						var $bannerArea = $1DepthList.eq(i).parent().find("div.gnbanner__inner");

						$bannerArea.find(".bannerlist").append(html);
						$bannerArea.find(".bannerlist li:first-child").addClass("is-on");

						try{
							var dotint = $bannerArea.find(".bannerlist > li").size();

							//for(i=0;i<dotint;i++){
								$bannerArea.find(".bannerdot").append("<span class='bannerdot__item' data-id="+(dotint-1)+"></span>");
							//}
							$bannerArea.find(".bannerdot span:first-child").addClass("is-on");

						}catch(ex){
							console.log(ex);
						}
					}
				}
			}).always(function(){
				fnSetBannerIconOver();
			});
			fnSetBannerIconOver();
		});
		//jQuery(".bannerdot span:first-child").before("<span class=\"left\"></span>");
		//jQuery(".bannerdot span:last-child").after("<span class=\"right\"></span>");
	    }
	});

	function fnSetBannerIconOver(){

		$1DepthList.each(function(i,obj){
			jQuery(obj).parent().find("div.bannerdot > span.bannerdot__item").each(function(j,obj2){

				jQuery(this).mouseenter(function(e){
					jQuery(this).parent().parent().find(".bannerlist li").eq(j).addClass("is-on").siblings().removeClass('is-on');
					jQuery(this).addClass("is-on").siblings().removeClass('is-on');

				    e.cancelBubble = true;
				    e.returnValue = false;
				});
			}).eq(0).mouseenter();
		});
	}
	fnBannerRoller();
}
function fnSetGnb(){
	jQuery("body").click(function(e){
		fnGnbOutsideClick(e);
		fnCloseSearchLayer(e);
		/* #36275 관련 마이메뉴 hide 방지
		try{//아이디 클릭시 메뉴 사라지게 혹시 오류날 경우 try catch 처리
			jQuery("#nonbanking_site1").hide();
		}catch(e){}
		*/
	});
/*
	jQuery(function(){
        // 전체보기 toggle
        var $mTrigger = $(".menu-trigger"),              // 전체메뉴 버튼
            gnb_cate = $("#gnbwrap__inner_cate"),       // 카테고리 메뉴
            gnb_all = $("#gnbwrap__inner_all"),         // 전체보기 메뉴
            gnb_state = false;

        $mTrigger.click(function(){
            $(this).toggleClass("is-on");

            if(!gnb_state) {
                $(gnb_cate).hide(); 
                $(gnb_all).show(); 
                gnb_state = true;

                $(gnb_all).find(".gmenu__item").hover(function(){
                    $(this).siblings().children(".submenu-trigger").removeClass("is-on")
                    $(this).children(".submenu-trigger").addClass("is-on")
                });
            }else {
                $(gnb_cate).show(); $(gnb_all).hide(); gnb_state = false;
            }
        });
    });
    */
	gnb_state = false;
	jQuery("body").on('click', '.menu-trigger', function(e) {

		insertLog(16606);
		//jQuery("#gnbAllBtn2").addClass("is-on");
		//jQuery(this).toggleClass("is-on");
			
		if(jQuery.trim(jQuery("#gnbAllMenu").html())==""){
			jQuery.ajax({
				url : isDev ? "/common/jsp/Ajax_Gnb_Src_2020.jsp?stype=allCate" : "/common/jsp/AllCateList_2020.html",
				data : "html",
				success:function(data){
					attachAllMenu(data);
					fnClickAllMenu(e);
					
					gnb_cate = jQuery("#gnbwrap__inner_cate");       // 카테고리 메뉴
			        gnb_all = jQuery("#gnbwrap__inner_all");         // 전체보기 메뉴

			        //전체카테고리
			        if(!gnb_state) {
			        	
			        	jQuery(gnb_cate).hide(); 
			        	jQuery(gnb_all).show();
			        	
			        	jQuery(".menu-trigger").addClass("is-on");
			        	
			        	gnb_state = true;
			        	
			        	jQuery(gnb_all).find(".gmenu__item").hover(function(){
			        		jQuery(this).siblings().children(".submenu-trigger").removeClass("is-on")
			                jQuery(this).children(".submenu-trigger").addClass("is-on")
			            });
			        }else { //대대카테고리
			        	jQuery(gnb_cate).show(); 
			        	jQuery(gnb_all).hide();
			        	
			        	jQuery(".menu-trigger").removeClass("is-on");
			        	gnb_state = false;
			        	
			        }
					
				}
			});

		}else {
			fnClickAllMenu(e);
			if(jQuery(this).attr("class").indexOf("is-on") > -1 ){
				jQuery(this).removeClass("is-on");
			}else{
				jQuery(this).addClass("is-on");
			}
			e.stopPropagation();
		}
		//fnCloseGnbMenu();
	});
	$1DepthList.each(function(i,v){
		var _this = jQuery(this);

		_this.click(function(e){
				
				jQuery(".menu-trigger").removeClass("is-on");
			
				if(jQuery.trim(jQuery("#first_depth" + i).html()) == ""){
					jQuery.ajax({
						url : isDev ? "/common/jsp/Ajax_Gnb_Src_2020.jsp?g_seq="+g_seq[i] : "/common/jsp/CateList_2020_"+i+".html",
						cache: false,
						data : "html",
						async : false,
						success:function(data){

							jQuery("#first_depth" + i).html(data).queue(function(){

								var delayTimer;
								var delayTime = 100;
								jQuery("#first_depth" + i).find("> li > div > ul > li > ul.twolist > div.twogroup > li ").mouseenter(function(){
								    var _this = jQuery(this);                                    
								    delayTimer = setTimeout(function(){
								            _this.addClass('is-on').siblings().removeClass('is-on');
								    },delayTime);
								           
								}).mouseleave(function(){
								    clearTimeout(delayTimer);
								}).click(function(event){
								});

								jQuery("#first_depth" + i).find("> li > div > ul > li").mouseenter(function(){
								    var _this = jQuery(this);                                    
								    delayTimer = setTimeout(function(){
								    	jQuery("#first_depth" + i).find("li > div > ul > li ").removeClass('is-on');
								    	_this.addClass('is-on');
								    },delayTime);

								}).mouseleave(function(){
								    clearTimeout(delayTimer);

								}).click(function(event){
								    event.stopPropagation();
								});
							
								
								jQuery(".submenu-trigger.js-trigger").removeClass("is-on");
								_this.addClass("is-on");

								jQuery("div.submenu").removeClass("is-show").addClass("is-hidden");

								_this.parent().find("div.submenu").removeClass("is-hidden");
								_this.parent().find("div.submenu").addClass("is-show");

								_this.parent().find("ul.onelist > li:first-child").trigger("mouseenter")
								.find("ul.twolist > li:first-child").trigger("mouseenter");

								jQuery("#first_depth" + i).find("a[href^='http']").attr("target","_blank");

								jQuery("#first_depth" + i + " > li").each(function(j){
									jQuery(this).children().find("li > a").each(function(k){

										jQuery(this).click(function(e){

											var cls = jQuery(this).attr("class");

											if(cls == "twolist__trigger"){
												switch(i){
												case 0 : {insertLog(23708);break;}
												case 1 : {insertLog(23709);break;}
												case 2 : {insertLog(23710);break;}
												case 3 : {insertLog(23711);break;}
												case 4 : {insertLog(23712);break;}
												case 5 : {insertLog(23713);break;}
												case 6 : {insertLog(23714);break;}
												case 7 : {insertLog(23715);break;}
												}

											}else if(cls == "threelist__trigger"){
												switch(i){
												case 0 : {insertLog(23716);break;}
												case 1 : {insertLog(23717);break;}
												case 2 : {insertLog(23718);break;}
												case 3 : {insertLog(23719);break;}
												case 4 : {insertLog(23720);break;}
												case 5 : {insertLog(23721);break;}
												case 6 : {insertLog(23722);break;}
												case 7 : {insertLog(23723);break;}
												}
											}
										});
									});
								});
								jQuery("#first_depth" + i ).each(function(j){
									jQuery(this).next().find(".bannerlist > li > a").each(function(k){
										jQuery(this).click(function(e){
											switch(i){
											case 0 : {insertLog(23740);break;}
											case 1 : {insertLog(23741);break;}
											case 2 : {insertLog(23742);break;}
											case 3 : {insertLog(23743);break;}
											case 4 : {insertLog(23744);break;}
											case 5 : {insertLog(23745);break;}
											case 6 : {insertLog(23746);break;}
											case 7 : {insertLog(23747);break;}
											}
										});
									});
								});

							});
						}
					});
				}else{

					if(_this.is(".is-on")){
						
						jQuery(".submenu-trigger.js-trigger").removeClass("is-on");
						jQuery("div.submenu").removeClass("is-show").addClass("is-hidden");
						
					}else{
						
						jQuery(".submenu-trigger.js-trigger").removeClass("is-on");
						_this.addClass("is-on");

						jQuery("div.submenu").removeClass("is-show").addClass("is-hidden");

						_this.parent().find("div.submenu").removeClass("is-hidden");
						_this.parent().find("div.submenu").addClass("is-show");

						_this.parent().find("ul.onelist > li:first-child").trigger("mouseenter")
						.find("ul.twolist > li:first-child").trigger("mouseenter");
						
					}
				}
				
		});
		/*
		jQuery(".twolist > li").click(function(e) {
			insertLog(16575);
		});
		*/
	});
}
function fnSetGnbAllCate(){
	jQuery(".all_sub  > li > ul > li > a").click(function(){insertLog(8299);});
	jQuery(".snblist > a.btn_close").click(function(){insertLog(12477);});
}
function fnBannerRoller(){
	$1DepthList.each(function(i,v){
		var $BannerArea = jQuery(this).parent().find(".gnbanner__inner > .bannerlist");
		var $BannerBtn  = jQuery(this).parent().find(".bannerdot");

		var timer;

		var rollerStarter = function(){
			rollerStopper();

			timer = setInterval(function(){

				if($BannerBtn.find("> span.bannerdot__item").last().is(".is-on")){
					$BannerBtn.find("> span.bannerdot__item").first().mouseenter();
				}else {
					$BannerBtn.find("> .is-on").next().mouseenter();
				}
		},3000)};

		var rollerStopper = function(){
			clearInterval(timer);
		}

		$BannerArea.click(function(){
/*			var e = window.event;
		    e.cancelBubble = true;
		    e.returnValue = false;	*/
		}).find(".bannerlist").bind({
			'mouseenter':function(){console.log("rollerStopper"); rollerStopper();},
			'mouseleave':function(){console.log("rollerStarter"); rollerStarter();}
		});

		$BannerBtn.mouseenter(function(e){
			//console.log("dddd:"+e.target.tagName.toLowerCase());
			if(e.target.tagName.toLowerCase() != "span")
				rollerStopper();

		}).mouseleave(function(){
			rollerStarter();
		});
		rollerStarter();
	});
}
function fnSetGnbLog(){
	$1DepthList.each(function(i,v){
		var $this = jQuery(this);

		// 대대분류 클릭로그
		$this.click(function(){
			switch(i){
				case 0 : {insertLog(23700);break;}//가전/해외직구
				case 1 : {insertLog(23701);break;}//tv/영상/디카
				case 2 : {insertLog(23702);break;}//컴퓨터/노트북
				case 3 : {insertLog(23703);break;}//태블릿/모바일
				case 4 : {insertLog(23704);break;}//스포츠/자동차
				case 5 : {insertLog(23705);break;}//유아/식품
				case 6 : {insertLog(23706);break;}//가구/생활
				case 7 : {insertLog(23707);break;}//패션/화장품
			}
		});
	});
}
function goGnbFooterLink(gonum){
	if(1 == gonum){
		location.href = "/cpp/cpp.jsp";
		insertLog(16607);
		return false;
	}else if(2 == gonum){
		window.open('/knowcom/index.jsp');
		insertLog(16608);
		return false;
	}else if(3 == gonum){
		window.open('/deal/newdeal/index.deal');
		insertLog(16609);
		return false;
	}else if(4 == gonum){
		window.open('/tour2012/Tour_Index.jsp');
		insertLog(16610);
		return false;
	}else if(5 == gonum){
		window.open('/view/Flower365.jsp');
		insertLog(16611);
		return false;
	}else if(6 == gonum){
		location.href = "/view/move_mall.jsp";
		insertLog(16612);
		return false;
	}else if(8 == gonum){
		window.open('/enuripc');
		insertLog(20071);
		return false;
	}
}
String.prototype.removeTag = function (){ return this == null || this == 'undefined' ? '' : (this.replace(/\<span.*span\>/gi,'').replace(/\<[^\>]*\>/gi,'')).trim();}