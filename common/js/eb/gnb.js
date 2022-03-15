jQuery("<meta name='format-detection' content='telephone=no'>").appendTo('head');

var $1DepthList;
var $2DepthList;
var $3DepthList;
var $4DepthList;

var g_seq = [1,2,3,4,5,6,4778];

var isDev = (top.location.href.indexOf("dev.enuri.com") > -1 && top.location.href.indexOf("stagedev.enuri.com") == -1) 
			|| top.location.href.indexOf("100.100.100.151") > -1 || top.location.href.indexOf("27.122.133.189") > -1 || top.location.href.indexOf("localhost") > -1;
/*var isDev = true;*/

jQuery(document).ready(function(){
	fnGnbInit();
	fnSetGnbWidthException();
	isEnuriDomain();
});

//에누리 도메인 또는 IP가 아닐 경우 www.enuri.com으로 rediret 시켜 버린다. (testServer들은 제외)
function isEnuriDomain() {
	var varDmainNm = rtnDomainName(top.location.href);
	
	//에누리 도메인이 아닌 경우 www.enuri.com으로 이동 시켜 버린다. 
	if (!("enuri.com" == varDmainNm || "www.enuri.com" == varDmainNm || "dev.enuri.com" == varDmainNm || "m.enuri.com" == varDmainNm || "studydev.enuri.com" == varDmainNm 
			|| "stagedev.enuri.com" == varDmainNm || "my.enuri.com" == varDmainNm || "localhost" == varDmainNm || top.location.href.indexOf("124.243.126.1") > -1 || top.location.href.indexOf("27.122.133.1") > -1
			 || top.location.href.indexOf("100.100.100.") > -1)) {
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
	$1DepthList = jQuery("#gnbMenu > li");
	
	fnSetGnb();
	fnSetGnbLog();
	fnSetGnbBanner();
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
	
	if(jQuery("#gnbMenu > li.on").length > 0){
		if(e.target.className != "selected"){
			if(jQuery(e.target).parents("#gnbMenu").length==0){
				fnCloseGnbMenu();
			}
		}
	} else if(jQuery("#gnbAllMenu > li.on").length > 0){
		if(e.target.className != "selected"){
			if(jQuery(e.target).parents(".all_sub").length==0){
				fnCloseGnbAllMenu();
			}				
		}
	}
}

function fnCloseSearchLayer(e){
	if(e.target.className != "selected"){
		if($("#ac_layer_main"))
			if($("#ac_layer_main").css("display") != "none")
				toggleAutoMake();
	}
}

function fnCloseGnbMenu(){
	jQuery("#gnbMenu > li.on").removeClass("on");
}

function fnCloseGnbAllMenu(){
	jQuery("#gnbAllMenu > li.on").removeClass("on");
	jQuery("#gnb > div").toggle();	
}

function attachAllMenu(data){
	jQuery("#gnbAllMenu").html(data).queue(function(){
		fnSetGnbAllCate();					
	});
	
	jQuery("#gnbAllMenu > li:lt(-1)").mouseenter(function(){
		jQuery(this).addClass('on').siblings().removeClass('on');			
	}).find("> a").click(function(event){
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
	
	if(e)
		fnCloseSearchLayer(e);
}

function loadGnbAllMenu(idx){
	idx = (idx == null ? 1 : idx);
	
	jQuery.ajax({
		url : isDev ? "/common/jsp/Ajax_Gnb_Src3.jsp?stype=allCate" : "/common/jsp/AllCateList.html",
		data : "html",
		success:function(data){
			attachAllMenu(data);
			
			fnClickAllMenu(null,idx);
		}
	});
}

/*var adServerLinkList = ["http://ad.enuri.com/NetInsight/text/PC_Enuri_Site/GNB_Enuri/GNB@GNB_Category_banner_Digital_Electronics",
                        "http://ad.enuri.com/NetInsight/text/PC_Enuri_Site/GNB_Enuri/GNB@GNB_Category_banner_Computer",
                        "http://ad.enuri.com/NetInsight/text/PC_Enuri_Site/GNB_Enuri/GNB@GNB_Category_banner_Sports_Leisure_Car",
                        "http://ad.enuri.com/NetInsight/text/PC_Enuri_Site/GNB_Enuri/GNB@GNB_Category_banner_Baby_Grocery",
                        "http://ad.enuri.com/NetInsight/text/PC_Enuri_Site/GNB_Enuri/GNB@GNB_Category_banner_Furniture_Home_Health",
                        "http://ad.enuri.com/NetInsight/text/PC_Enuri_Site/GNB_Enuri/GNB@GNB_Category_banner_Fashion_Beauty",
                        "http://ad.enuri.com/NetInsight/text/PC_Enuri_Site/GNB_Enuri/GNB@GNB_Category_banner_Book_Travel_Hobby",
                        "http://ad.enuri.com/NetInsight/text/PC_Enuri_Site/GNB_Enuri/GNB@GNB_Upper_right"];
*/

//Banner Json 파일명 (/jca/main/json/ 파일명.json)
var adServerLinkList = ["B21",
                        "B22",
                        "B23",
                        "B24",
                        "B25",
                        "B26",
                        "B27"];

function fnSetGnbBanner(){
	
	var url = isDev > 0 ? "/common/jsp/Ajax_Gnb_Src3.jsp?stype=banner" : "/common/js/eb/nGnbBanner_data.json";
	jQuery.getJSON(url,null,function(data){
		var bannerList = data["gnbBanner"];
		jQuery.each(bannerList,function(i,banners){
			jQuery.each(banners["banner"],function(j,banner){
				var html = "";
				if(parseInt(banner["source"])==0){
					switch(parseInt(banner["linktype"])){
						case 1 : {
							html = "<li><a href=\"javascript://\" onclick=\"window.open('" + banner["link"]+ "');\"><img alt=\"\" src=\"" + banner["img"] + "\"></a></li>";break;
						}
						case 2 : {
							html = "<li><a href=\"javascript://\" onclick=\"top.location.href = '" + banner["link"]+ "';\"><img alt=\"\" src=\"" + banner["img"] + "\"></a></li>";break;
						}
						case 3 : {
							html = "<li><a href=\"javascript://\" onclick=\"Main_OpenWindow('" + banner["link"]+ "','','804', " + window.screen.height + ", 'yes');\"><img alt=\"\" src=\"" + banner["img"] + "\"></a></li>";break;
						}					
					}
				}else{
					html = "<li><a href=\"" + "/move/Redirectad.jsp?register_no="+banner["no"]+"&pageNm=gnb" + "\"><img alt=\"\" src=\"" + banner["img"] + "\"></a></li>";
				}
				
				var $bannerArea = $1DepthList.eq(i).find("> .back_img > .snblist > .ad_area");
				
				$bannerArea.find("> .adarea_h > ul").append(html);
				$bannerArea.find("> .bnr_dot").append("<span class=anchors></span>");
			});
			var loadJson = adServerLinkList[i];
			
			var adUrl = adServerLinkList[i];
			//adUrl = adUrl.substring((adUrl.indexOf("@") + 1), adUrl.length);
			
			var varFilePath = "/jca/main/json/" + adUrl + ".json";
			//alert(varFilePath);
			//json 파일 서버 내 저장함에 따라 주석 처리, 서버에서 직접 처리 시 아래 주석 해제 필요
			//jQuery.getJSON("/common/jsp/eb/getGnbTopRight_Json.jsp",{url:adServerLinkList[i]},function(banner){
			jQuery.getJSON(varFilePath,function(banner){
				var html = "";
				switch(parseInt(banner["TARGET"])){
					case 1 : {
						html = "<li><a href=\"javascript://\" onclick=\"window.open('" + banner["JURL1"]+ "');\"><img alt=\"\" src=\"" + banner["IMG1"] + "\"></a></li>";break;
					}
					case 2 : {
						html = "<li><a href=\"javascript://\" onclick=\"top.location.href = '" + banner["JURL1"]+ "';\"><img alt=\"\" src=\"" + banner["IMG1"] + "\"></a></li>";break;
					}
					case 3 : {
						html = "<li><a href=\"javascript://\" onclick=\"Main_OpenWindow('" + banner["JURL1"]+ "','','804', " + window.screen.height + ", 'yes');\"><img alt=\"\" src=\"" + banner["IMG1"] + "\"></a></li>";break;
					}
				}
				if(html != ""){
					var $bannerArea = $1DepthList.eq(i).find("> .back_img > .snblist > .ad_area");
					$bannerArea.find("> .adarea_h > ul").append(html);
					$bannerArea.find("> .bnr_dot > span.right").before("<span class=anchors></span>");
				}
			}).always(function(){
				fnSetBannerIconOver();
			});
		});
		
		jQuery(".bnr_dot span:first-child").before("<span class=\"left\"></span>");
		jQuery(".bnr_dot span:last-child").after("<span class=\"right\"></span>");	
	});

	function fnSetBannerIconOver(){
		$1DepthList.each(function(i,obj){
			jQuery(obj).find("> .back_img > .snblist > .ad_area > .bnr_dot > span.anchors").each(function(j,obj2){
				jQuery(this).mouseenter(function(e){
					jQuery(this).parent().parent().find("> .adarea_h > ul > li").eq(j).addClass("on").siblings().removeClass('on');
					jQuery(this).addClass("on").siblings().removeClass('on');
					
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
	});
	
	$1DepthList.each(function(i,v){
		var _this = jQuery(this);
		
		_this.click(function(e){
			if(i==7){
				if(jQuery.trim(jQuery("#gnbAllMenu").html())==""){
					jQuery.ajax({
						url : isDev ? "/common/jsp/Ajax_Gnb_Src3.jsp?stype=allCate" : "/common/jsp/AllCateList.html",
						data : "html",
						success:function(data){
							attachAllMenu(data);
							
							fnClickAllMenu(e);
						}
					});
					
				}else {
					fnClickAllMenu(e);
					
					e.stopPropagation();		
				}
			} else {
				if(jQuery.trim(jQuery("#first_depth" + i).html()) == ""){
					jQuery.ajax({
						url : isDev ? "/common/jsp/Ajax_Gnb_Src3.jsp?g_seq="+g_seq[i] : "/common/jsp/CateList_"+i+".html",
						data : "html",
						async : false,
						success:function(data){
							jQuery("#first_depth" + i).html(data).queue(function(){
								jQuery("#first_depth" + i).find("> li > ul.second_depth > li").mouseenter(function(){
									var _this = jQuery(this);
									
									jQuery(this).addClass('on').siblings().removeClass('on');
								}).click(function(event){
								});
								
								jQuery("#first_depth" + i).find("> li").mouseenter(function(){
									var _this = jQuery(this);
									_this.addClass('on').siblings().removeClass('on');
									
									_2ndDepth = _this.find("> ul.second_depth > li:first-child");
									_2ndDepth.addClass('on').siblings().removeClass('on');
								}).click(function(event){
									event.stopPropagation();
								});
								
								if(_this.is(".on")){
									_this.removeClass("on");
								} else {
									_this.addClass('on').siblings().removeClass('on');
									
									_this.find("> div.back_img > div.snblist > ul.first_depth > li:first-child").trigger("mouseenter")
									.find("> ul.second_depth > li:first-child").trigger("mouseenter");
								}
								
								// 키워드,기획전 개별로그
								jQuery("#first_depth" + i + " > li > dl.etc_menu > div").each(function(j){
									if(jQuery(this).find("> dt:first-child").text() == "인기 키워드"){
										jQuery(this).find("> dd > a").click(function(){
											insertLog(12473);
											insertLog(12475);
											
											switch(i){
												case 0 : {insertLog(12463);break;}
												case 1 : {insertLog(12464);break;}
												case 2 : {insertLog(12465);break;}
												case 3 : {insertLog(12466);break;}
												case 4 : {insertLog(12467);break;}
												case 5 : {insertLog(12468);break;}
												case 6 : {insertLog(12469);break;}
											}
										});
									} else if(jQuery(this).find("> dt:first-child").text() == "인기 전문관"){
										jQuery(this).find("> dd > a").click(function(){
											insertLog(12476);
										});
									}
								});
								
								jQuery("#first_depth" + i + " > li").each(function(j){
									$(this).find(" > .second_depth > li").each(function(k){
										$(this).click(function(e){
											switch(i){
												case 0 : {insertLog(12449);break;}
												case 1 : {insertLog(12450);break;}
												case 2 : {insertLog(12451);break;}
												case 3 : {insertLog(12452);break;}
												case 4 : {insertLog(12453);break;}
												case 5 : {
													insertLog(12454);
													
													switch(j){
														case 0:{
															switch(k){
																case 1:{insertLog(13229);break;} 
															}
															break;
														} 
														case 1:{
															switch(k){
																case 0:{insertLog(13230);break;}
																case 1:{insertLog(13231);break;}
																case 4:{insertLog(13232);break;}
																case 5:{insertLog(13233);break;}
															}
															break;
														}
														case 2:{
															switch(k){
																case 0:{insertLog(13234);break;}
																case 1:{insertLog(13235);break;}
																case 2:{insertLog(13236);break;}
															}
															break;
														}														
													}
													break;
												}
												case 6 : {insertLog(12455);break;}
											}
											
											setGEventLog('GNB_'+this.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.getElementsByTagName("a")[0].innerHTML.removeTag()
													,this.parentNode.parentNode.getElementsByTagName("a")[0].innerHTML.removeTag(),this.getElementsByTagName("a")[0].innerHTML.removeTag()
													+ " > " + this.getElementsByTagName("a")[0].innerHTML.removeTag(),this.getElementsByTagName("a")[0].innerHTML.removeTag()
													);
											
											e.stopPropagation();
										}).find("> .third_depth > li").each(function(l){
											$(this).click(function(e){
												switch(i){
													case 0 : {insertLog(12456);break;}
													case 1 : {
														insertLog(12457);
														
														if(j==0 && k==0 && l==0) insertLog(13125);
														else if(j==0 && k==0 && l==1) insertLog(13126);
														else if(j==3 && k==0 && l==0) insertLog(13127);
														else if(j==3 && k==0 && l==1) insertLog(13128);
														else if(j==4 && k==0 && l==0) insertLog(13129);
														else if(j==4 && k==0 && l==1) insertLog(13130);
														
														break;
													}
													case 2 : {insertLog(12458);break;}
													case 3 : {insertLog(12459);break;}
													case 4 : {insertLog(12460);break;}
													case 5 : {
														insertLog(12461);
														
														switch(j){
															case 0:{
																switch(k){
																	case 0:{insertLog(13237);break;}
																	case 1:{insertLog(13238);break;}
																}
																break;
															}
															case 1:{
																switch(k){
																	case 0:{insertLog(13239);break;}
																	case 1:{insertLog(13240);break;}
																	case 4:{insertLog(13241);break;}
																	case 5:{insertLog(13242);break;}
																}
																break;
															}
															case 2:{
																switch(k){
																	case 0:{insertLog(13243);break;}
																	case 1:{insertLog(13244);break;}
																	case 2:{insertLog(13245);break;}
																}
																break;
															}																
														}
														break;
													}
													case 6 : {insertLog(12462);break;}
												}
												
												setGEventLog('GNB_' + this.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.getElementsByTagName("a")[0].innerHTML.removeTag()
														, this.parentNode.parentNode.parentNode.parentNode.getElementsByTagName("a")[0].innerHTML.removeTag()
														+ " > " + this.parentNode.parentNode.getElementsByTagName("a")[0].innerHTML.removeTag()
														+ " > " + this.getElementsByTagName("a")[0].innerHTML.removeTag()
														,this.getElementsByTagName("a")[0].innerHTML.removeTag());
												
												e.stopPropagation();
											});
										});
									});
								});
									
								jQuery("#first_depth" + i).parent().find(" > div.ad_area > div.adarea_h").click(function(e){
									switch(i){
										case 0 : {insertLog(10533);break;}
										case 1 : {insertLog(10534);break;}
										case 2 : {insertLog(10535);break;}
										case 3 : {insertLog(10536);break;}
										case 4 : {insertLog(10537);break;}
										case 5 : {insertLog(10538);break;}
										case 6 : {insertLog(11237);break;}
									}			
								});	
								
								jQuery("#first_depth0").parent().find(" > div.ad_area > div.adarea_h > ul >li:eq(4)").click(function(){
									insertLog(13093);
								});
								
								jQuery("#first_depth0").children("li:eq(6)").find("ul.second_depth > li:eq(0)").find("ul.third_depth > li:eq(0)").click(function(){		// 냉장고 전체상품 보기
									insertLog(14175);
								});
								jQuery("#first_depth0").children("li:eq(6)").find("ul.second_depth > li:eq(0) > ul.third_depth > li:eq(1)").click(function(){		// 냉장고 (일반형)
									insertLog(14176);
								});
								
								jQuery("#first_depth0 > li:eq(1)").children("ul.second_depth > li:eq(0),li:eq(1),li:eq(2)").children("ul.third_depth > li:eq(0)").click(function() { // 대우 루컴즈 방문출장 A/S
									insertLog(14852);
								});

								jQuery("#first_depth0 > li:eq(1)").children("ul.second_depth > li:eq(0),li:eq(1)").children("ul.third_depth > li:eq(1)").click(function() { // 더함우버,LG완제품모듈장착
									insertLog(14853);
								});
								
								jQuery("#first_depth1").parent().find(" > div.ad_area > div.adarea_h > ul >li:eq(4)").click(function(){
									insertLog(13255);
								});
								
								var startDate = null;
								var limitedDate = null;
								var now = new Date();
								
								
								// '유아/식품' 분류의 첫번째 배너(설날 통합기획전)에 개별로그 추가
								jQuery("#first_depth3").parent().find(" > div.ad_area > div.adarea_h > ul >li:eq(0)").click(function(){
									startDate = new Date(2017, 1 - 1, 17, 23, 59, 59);
									limitedDate = new Date(2017, 1 - 1, 25, 0, 0, 0);
									if (now > startDate && now < limitedDate) { // 노출기간 : 1월 18일 ~ 1월 24일
										insertLog(15334);
									} 
								});
								
								jQuery("#first_depth" + i).find("a[href^='http']").attr("target","_blank");
							});
						}
					});
				}else{
					if(_this.is(".on")){
						_this.removeClass("on");
					} else {
						_this.addClass('on').siblings().removeClass('on');
						
						_this.find("> div.back_img > div.snblist > ul.first_depth > li:first-child").trigger("mouseenter")
						.find("> ul.second_depth > li:first-child").trigger("mouseenter");
					}						
				}
			}
		});
	});
}

function fnSetGnbAllCate(){
	jQuery(".all_sub  > li > ul > li > a").click(function(){
		insertLog(8299);
	});
	
	jQuery(".snblist > a.btn_close").click(function(){
		insertLog(12477);
	});
}

function fnBannerRoller(){
	$1DepthList.each(function(){
		var $BannerArea = jQuery(this).find("> div.back_img > .snblist > .ad_area");
		var $BannerBtn  = $BannerArea.find("> .bnr_dot");
		
		var timer;
		
		var rollerStarter = function(){
			rollerStopper();
			
			timer = setInterval(function(){
				if($BannerBtn.find("> span.anchors").last().is(".on")){
					$BannerBtn.find("> span.anchors").first().mouseenter();
				}else {
					$BannerBtn.find("> .on").next().mouseenter();
				}
		},3000)};
		
		var rollerStopper = function(){
			clearInterval(timer);
		}
		
		$BannerArea.click(function(){
/*			var e = window.event;
		    e.cancelBubble = true;
		    e.returnValue = false;	*/
		}).find("> div.adarea_h").bind({
			'mouseenter':function(){rollerStopper();},
			'mouseleave':function(){rollerStarter();}
		});

		$BannerBtn.mouseenter(function(e){
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
				case 0 : {insertLog(12254);break;}
				case 1 : {insertLog(12255);break;}
				case 2 : {insertLog(12256);break;}
				case 3 : {insertLog(12257);break;}
				case 4 : {insertLog(12258);break;}
				case 5 : {insertLog(12259);break;}
				case 6 : {insertLog(12260);break;}
				case 7 : {insertLog(12261);break;}
			}
		});
	});
}

String.prototype.removeTag = function (){
	return this == null || this == 'undefined' ? '' : (this.replace(/\<span.*span\>/gi,'').replace(/\<[^\>]*\>/gi,'')).trim();
}