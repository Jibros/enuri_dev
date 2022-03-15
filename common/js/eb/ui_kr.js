$("<meta name='format-detection' content='telephone=no'>").appendTo('head');
jQuery(document).ready(function($){
	$(function(){
		/**
		function getDefaultGnb(seq){
			var ajax_url = "/common/jsp/Ajax_Gnb_Default.jsp";
			if(isServer151==1) ajax_url = "/common/jsp/Ajax_Gnb_Src.jsp";
			$.ajax({
				url: ajax_url,
				success: function(data) {
					$("#gnbMenu").append( jQuery.trim(data) );
					setGnbBanner();
				}
			});
		}
		**/
		function setGnbBanner(){
			for(i=1;i<=6;i++){
				var _banner = $("#gnb_banner_"+i);
				var _banner_a = _banner.parent();
				var _banner_level1 = "b"+i;
				var _banner_cnt = 0;
				if(gnb_banner_img_hash && gnb_banner_img_hash[_banner_level1]){
					_banner_cnt = gnb_banner_img_hash[_banner_level1].length;
					var _banner_idx = Math.floor(Math.random()*_banner_cnt); //노출할 배너 랜덤
					//var _banner_idx = 1;

					if(_banner_cnt>0){
						var div = document.createElement('div');
						//div.style.position = 'relative';
						//div.style.top = "7px";
						//div.style.paddingLeft = '13px';
						//div.style.zIndex = 2;
						div.style.padding = "0px 13px 0px 0px";
						div.style.textAlign = 'right';

						document.getElementById("gnb_banner_box_"+i).insertBefore(div,document.getElementById("gnb_banner_box_"+i).getElementsByTagName("a")[0]);

						for(j=0;j<_banner_cnt;j++){
							var btn = document.createElement('span');

							btn.className = 'anchors_' + (j == _banner_idx ? "on" : "off");
							btn._idx = j;
							$(btn).mouseenter(function(){
								var obj = $(this).parent().parent();
								var _idx = obj.attr("id").replace("gnb_banner_box_","");
								var obj_a = obj.find('a');
								obj_a.bind('click', function(){});

								obj.find('img').attr("src", gnb_banner_img_hash["b"+_idx][this._idx]);
								obj_a.attr("href", gnb_banner_link_hash["b"+_idx][this._idx]);
								obj_a.attr("linktype", gnb_banner_linktype_hash["b"+_idx][this._idx]);
								obj_a.attr("source", gnb_banner_source_hash["b"+_idx][this._idx]);
								obj_a.attr("no", gnb_banner_no_hash["b"+_idx][this._idx]);
								obj_a.attr("gnbidx", _idx);

								$(this.parentNode.getElementsByTagName('span')).each(function(e){this.className = "anchors_off";});
								this.className = "anchors_on";

								//추천상품 광고그룹대상 view count 로그
								if(gnb_banner_source_hash["b"+_idx][this._idx]=="1"){
									logGnbAdBanner(_idx);
								}
							});

							document.getElementById("gnb_banner_box_"+i).getElementsByTagName('div')[0].appendChild(btn);
						}

						_banner.attr("src", gnb_banner_img_hash[_banner_level1][_banner_idx]);
						_banner_a.attr("href", gnb_banner_link_hash[_banner_level1][_banner_idx]);
						_banner_a.attr("linktype", gnb_banner_linktype_hash[_banner_level1][_banner_idx]);
						_banner_a.attr("source", gnb_banner_source_hash[_banner_level1][_banner_idx]);
						_banner_a.attr("no", gnb_banner_no_hash[_banner_level1][_banner_idx]);
						_banner_a.attr("gnbidx", _banner_level1.replace("b",""));
					}
				}
				if(_banner_cnt==0){ //등록된 배너 없으면 추천상품영역 삭제
					_banner.parent().parent().parent().remove();
				}
				if (i == 1){
					$(_banner_a).bind('click', function(){
						gnb_log(10533)
					});
				}else if(i == 2){
					$(_banner_a).bind('click', function(){
						gnb_log(10534)
					});
				}else if(i == 3){
					$(_banner_a).bind('click', function(){
						gnb_log(10535)
					});
				}else if(i == 4){
					$(_banner_a).bind('click', function(){
						gnb_log(10536)
					});
				}else if(i == 5){
					$(_banner_a).bind('click', function(){
						gnb_log(10537)
					});
				}else if(i == 6){
					$(_banner_a).bind('click', function(){
						gnb_log(10538)
					});
				}
			}
			gnb();
		}
		function gnb() {
			var _depth1 = $('#gnb > ul > li'),
				_depth2 = $('.depth2 > ul > li'),
				_depth3Detail = $('#depth3Detail'),
				fashionDepth = $('#gnb > ul > li:nth-child(6)');
				fashionDepth.find('.depth2').css('margin-left','-131px');
			/*
			if ($('#wrap').hasClass('main')){
				fashionDepth.find('.depth2').css('margin-left','-131px');
			} else {
				fashionDepth.find('.depth2').css('right','178px');
			}
			*/
			$('#gnb > ul > li > a').bind('mouseenter focusin', function(){
				var _this = $(this);
				_depth1.removeClass('on');
				_depth1.find('a').removeClass('current');
				_depth2.removeClass('on');
    			if (!(location.pathname == "/" || location.pathname == "/Index.jsp")){
    			    var _ie7 = 2;
   					if (getBrowserName() == "msie7"){
   					    _ie7 = 1;
   					}
    			    var _ml = -(_this.parent().position().left+$(".depth2").width()+$(".depth2Pr").width()-$('.gnbMenu').width()+_ie7);
    				fashionDepth.find('.depth2').css('margin-left',_ml+'px');
    			}
				$('.depth2Pr').append('<span class="onArw"></span>')
				if (_depth3Detail.is(":visible")){
					_depth3Detail.hide();
					$("#gnb > ul > li[seq='"+_this.parent().attr("seq")+"'] .depth3DetailBtn:first > a").trigger("click");
					if (getBrowserName() == "msie7"){
						$("#depth3Detail_"+_this.parent().attr("seq")+" li:first > a").trigger("blur");
					}
				}else{
					_this.parent().addClass('on');
					//setGnbBannerRoll(_this.parent().attr("seq"));
				}
				//추천상품 광고그룹대상 view count 로그
				if(_this.parent().find("p.depth2Pr > a").attr("source")=="1"){
					var gnbAdBannerIdx = _this.parent().find("p.depth2Pr > a").attr("gnbidx");
					logGnbAdBanner(gnbAdBannerIdx);
				}
				$('.search > span').removeClass('on');
				if( $('#ac_layer_main').is(':visible') ) {
					toggleAutoMake();
				}
			});
			$('.depth3 > ul > li > a').bind('click', function(){
				var _this = $(this);
				var _seq = _this.parent().parent().parent().parent().parent().parent().parent().attr("seq");
				var _href = $(this).attr("href");
				var _parent = $(this).parent();
				if (_href != null && _href != "" && _href.length > 4){
					var _cate_idx = _href.indexOf("cate=");
					if(_cate_idx>0){
						var _cate = _href.substring(_cate_idx+5,_href.length);
						if (_seq == 1){
							gnb_log_cate(10539,_cate);
						}else if(_seq == 2){
							gnb_log_cate(10540,_cate);
						}else if(_seq == 3){
							gnb_log_cate(10541,_cate);
						}else if(_seq == 4){
							gnb_log_cate(10542,_cate);
						}else if(_seq == 5){
							gnb_log_cate(10543,_cate);
						}else if(_seq == 6){
							gnb_log_cate(10544,_cate);
						}else if(_seq == 4778){
							gnb_log_cate(11167,_cate);
						}
					}else{
						if(_seq == 4778){
							gnb_log(11167);
						}
					}
					if(_parent.hasClass("addcs2")){
						gnb_log(11048);
					}
					if(_href.substring(0,4)=="http"){
						_this.blur();
					}
					if(_logno>0){
						gnb_log(_logno);
					}
				}else{
					return false;
				}
			});
			$('.depth2 > ul > li > a').bind('mouseenter focusin', function(){
				var _this = $(this);

				_depth2.removeClass('on');
				_this.parent().addClass('on');
				$('.onArw').remove();
				_this.append('<span class="onArw"></span>')
				if (_this.parent().attr("class").indexOf("recomPrd") >= 0 ){
					//setGnbBannerRoll(_this.parent().parent().parent().parent().attr("seq"));
				}else{
					//stopGnbBannerRoll();
				}
			});
			$('.depth2 > ul > li > a').bind('click', function(){
				return false;
			});
			$('.depth3DetailBtn > a').click(function(){
				gnb_log(10512);
				var _this = $(this);
				var _seq = _this.parent().parent().parent().attr('seq');
				_this.parent().parent().parent().find('a').addClass('current');
				_depth1.removeClass('on');
				_depth3Detail.show();
				/*가로폭*/
				if (getBrowserName() == "msie7" && document.URL.indexOf("Index.jsp") < 0){
					_depth3Detail.width($('.gnbMenu').width()-1);
				}
				/*가로폭*/
				if($("#depth3Detail_"+_seq).html()==""){
					$(function(){
						function loadGnbDepth3Detail(seq){ //자세히보기 컨텐츠 로딩
							var ajax_url = "/common/jsp/Ajax_Gnb_Detail_"+seq+".jsp";
							if(isServer151==1) ajax_url = "/common/jsp/Ajax_Gnb_Src.jsp?stype=detail&g_seq="+seq;
							$.ajax({
								url: ajax_url,
								success: function(data) {
									$("#depth3Detail_"+seq).append( jQuery.trim(data) );
									//console.log(jQuery.trim(data));
									//if(seq<6){
									//	loadGnbDepth3Detail(seq+1);
									//}else{
										var	_detail1depth = $('#depth3Detail > ul > li'),
											_detail2depth = $('.detailDepth2 > ul > li');

										$('#depth3Detail > ul > li > a').unbind();
										$('#depth3Detail > ul > li > a').bind('click', function(){
											gnb_log(10523);
											var _this = $(this);
											var blankClassName = _this.parent().attr("class");
											if( blankClassName != null && blankClassName.indexOf("detailDepth1_blank") >= 0 ){
												return;
											}
											_detail1depth.removeClass('on');
											_detail2depth.removeClass('on');

											_this.parent().addClass('on');
											_this.next().find('li:first-child').addClass('on');
											/*가로폭*/
											if (getBrowserName() == "msie7" && document.URL.indexOf("Index.jsp") < 0){
												var _varli2 = $("#depth3Detail_"+_seq + " > .on > .detailDepth2 > ul > li");

												for (var i=0;i<_varli2.length;i++){
													$(_varli2[i]).width(_varW);
												}
												for (var i=0;i<($("#depth3Detail_"+_seq).width()-(_varW*10));i++){
													var _w = $(_varli2[i]).width()+1;
													$(_varli2[i]).width(_w);
												}
											}
											/*가로폭*/

										});
										$('.detailDepth2 > ul > li > a').unbind();
										$('.detailDepth2 > ul > li > a').bind('mouseenter focusin', function(){
											var _this = $(this);
											var blankClassName = _this.parent().attr("class");
											if (blankClassName != null && _this.parent().attr("class").indexOf("detailDepth2_blank") >= 0 ){
												return;
											}
											_detail2depth.removeClass('on');
											_this.parent().addClass('on');

										});
										$('.detailDepth2 > ul > li > a').bind('click', function(){
											gnb_log(10524);
										});
										$('.detailDepth3 > ul > li > a').bind('click', function(){
											gnb_log(10514);
										});
										$('.detailClose > a').unbind();
										$('.detailClose > a').bind('click', function(){
											_depth1.find('a').removeClass('current');
											_detail1depth.removeClass('on');
											_detail2depth.removeClass('on');
											_depth3Detail.hide();
										});
										$('#depth3Detail > ul > li:first-child').addClass('on');
										$('.detailDepth2 > ul > li:first-child').addClass('on');
										$('#depth3Detail > ul > li:first-child > a').focus();
										$("#depth3Detail > ul > li[seq='"+_this.parent().parent().parent().attr("seq")+"'] > a").trigger( "click" );
										$("#depth3Detail_"+_seq+" li:first > a").trigger("blur");

										$("#depth3Detail_"+_seq).show();

										if(_seq!=1) $("#depth3Detail_1").hide();
										if(_seq!=1) $("#depth3Detail_1").html("");
										if(_seq!=2) $("#depth3Detail_2").hide();
										if(_seq!=2) $("#depth3Detail_2").html("");
										if(_seq!=3) $("#depth3Detail_3").hide();
										if(_seq!=3) $("#depth3Detail_3").html("");
										if(_seq!=4) $("#depth3Detail_4").hide();
										if(_seq!=4) $("#depth3Detail_4").html("");
										if(_seq!=5) $("#depth3Detail_5").hide();
										if(_seq!=5) $("#depth3Detail_5").html("");
										if(_seq!=6) $("#depth3Detail_6").hide();
										if(_seq!=6) $("#depth3Detail_6").html("");

										if (getBrowserName() == "msie7" && document.URL.indexOf("Index.jsp") < 0){
											/*가로폭*/
											var _varli = $("#depth3Detail_"+_seq + " > li");
											var _varW = (Math.floor($("#depth3Detail_"+_seq).width()/10));
											for (var i=0;i<_varli.length;i++){
												$(_varli[i]).width(_varW);
											}

											for (var i=0;i<($("#depth3Detail_"+_seq).width()-(_varW*10));i++){
												var _w = $(_varli[i]).width()+1;
												$(_varli[i]).width(_w);
											}

											var _varli2 = $("#depth3Detail_"+_seq + " > .on > .detailDepth2 > ul > li");

											for (var i=0;i<_varli2.length;i++){
												$(_varli2[i]).width(_varW);
											}
											for (var i=0;i<($("#depth3Detail_"+_seq).width()-(_varW*10));i++){
												var _w = $(_varli2[i]).width()+1;
												$(_varli2[i]).width(_w);
											}
											/*가로폭*/
											var _varspan = $("#depth3Detail_"+_seq + "  span");
											for (var i=0;i<_varspan.length;i++){
												if ($(_varspan[i]).html().toLowerCase().indexOf("<br>") < 0 ){
													$(_varspan[i]).css('margin-top','24px');
												}else{
													$(_varspan[i]).css('margin-top','15px');
												}
											}
										}
										if (getBrowserName() == "msie7" || getBrowserName() == "msie8"){
											var _varspan = $("#depth3Detail_"+_seq + "  span");
											for (var i=0;i<_varspan.length;i++){
												if ($(_varspan[i]).html().toLowerCase().indexOf("<br>") < 0 ){
													$(_varspan[i]).css('margin-top','24px');
												}else{
													$(_varspan[i]).css('margin-top','15px');
												}
											}
										}
									//}
								}
							});
						};
						loadGnbDepth3Detail(_seq);
					});
				}else{
					$("#depth3Detail_"+_seq).show();
					$('#depth3Detail > ul > li:first-child').addClass('on');
					$('.detailDepth2 > ul > li:first-child').addClass('on');
					$('#depth3Detail > ul > li:first-child > a').focus();
					$("#depth3Detail > ul > li[seq='"+_this.parent().parent().parent().attr("seq")+"'] > a").trigger( "click" );
					$("#depth3Detail_"+_seq+" li:first > a").trigger("blur");

					if(_seq!=1) $("#depth3Detail_1").hide();
					if(_seq!=1) $("#depth3Detail_1").empty();
					if(_seq!=2) $("#depth3Detail_2").hide();
					if(_seq!=2) $("#depth3Detail_2").empty("");
					if(_seq!=3) $("#depth3Detail_3").hide();
					if(_seq!=3) $("#depth3Detail_3").empty("");
					if(_seq!=4) $("#depth3Detail_4").hide();
					if(_seq!=4) $("#depth3Detail_4").empty("");
					if(_seq!=5) $("#depth3Detail_5").hide();
					if(_seq!=5) $("#depth3Detail_5").empty("");
					if(_seq!=6) $("#depth3Detail_6").hide();
					if(_seq!=6) $("#depth3Detail_6").empty("");
				}
				$('.detailDepth2 > ul > li:last-child').addClass('lastChild');
			});
			$('#gnb > ul > li.allMenuBtn > a').bind('click', function(){
				gnb_log(1053);
				loadGnbAllMenu();
			});
			$('#gnb').bind('mouseleave', function(){
				_depth1.removeClass('on');
				_depth2.removeClass('on');
				$('#gnbMenu .onArw').remove();
				//stopGnbBannerRoll();
			});
			$('.toggleAuto').click(function(){
				toggleAutoMake();
				return false;
			});
			//loadGnbDepth3Detail(1);
			//loadGnbAllMenu();
		}
		setGnbBanner();
		/*
		function searchHistory() {
			$('.search > span > .placeholder').click(function(){
				$('.placeholder').hide();
				$('.search > span > .txt').focus();
			});
			$('.search > span > .txt').bind('click focusin', function(){
				var _this = $(this);
				_this.parent().addClass('on');
				$('.searchHistory').show();
				$('.placeholder').hide();
			});
			$('.search > span > .txt').keydown(function(){
				var _this = $(this);
				_this.parent().addClass('over');
			});
			$('.search > span > .txt').bind('mouseleave focusout keyup', function(){
				if ($('.search > span > .txt').val()) {
					$('.search > span').addClass('over');
				} else {
					$('.search > span').removeClass('over');
				}
			});
			$('.searchHistoryList > li').bind('mouseenter focusin', function(){
				var _this = $(this);
				$('.searchHistoryList > li').removeClass('over');
				_this.addClass('over');
			});
			$('.searchHistoryList').bind('mouseleave', function(){
				$('.searchHistoryList > li').removeClass('over');
			});

		}
		searchHistory();
		function quickMenu() {
			var conWidth = $('#container').width();
			var _quick = $('#quickMenu');
			_quick.css('left', conWidth);
			$(window).resize(function(){
				var conWidth = $('#container').width();
				var _quick = $('#quickMenu');
				_quick.css('left', conWidth);
			});
		}
		quickMenu();
		*/
	});
});
function loadGnbAllMenu(idx){
	if(typeof(idx)=="undefined") idx = 0;
	jQuery(document).ready(function($){
		$("#allMenu").empty();
		var ajax_url = "/common/jsp/Ajax_Gnb_AllMenu.jsp";
		if(isServer151==1) ajax_url = "/common/jsp/Ajax_Gnb_Src.jsp?stype=allmenu";
		$.ajax({
			url: ajax_url,
			success: function(data) {
				$("#allMenu").append( jQuery.trim(data) );

				var _allMenu = $('#allMenu > ul > li');
				$('#allMenu > ul > li > a').bind('mouseenter focusin', function(){
					var _this = $(this);
					var allMenuClass = "";
					_this.append('<span class="onArw"></span>');
					if (typeof(_this.parent().attr("class")) != "undefined"){
						allMenuClass = _this.parent().attr("class")
					}
					if(allMenuClass.indexOf("allMenuBtn") < 0){
						_allMenu.removeClass('on');
						_this.parent().addClass('on');
					}
				});
				$('#allMenu > ul > li.allMenuBtn > a').bind('click', function(){
					/**
					$('.gnbMenu').hide();
					_allMenu.removeClass('on');
					$('#allMenu > ul > li:first-child').addClass('on');
					$('#allMenu > ul > li:first-child > a').append('<span class="onArw"></span>');
					**/
					$("#allMenu").hide();
					$('.gnbMenu').show();
				});
				$('.allMenuClose > a').click(function(){
					$('#allMenu').hide();
					$('.gnbMenu').show();
					_allMenu.removeClass('on');
				});
				$('#allMenu').bind('mouseleave', function(){
					/**
					$('#allMenu').hide();
					$('.gnbMenu').show();
					_allMenu.removeClass('on');
					**/
				});
				$('.depth2allMenu > ul > li:first-child, .depth2allMenu > ul > li:nth-child(6)').addClass('noLine');
				$('#allMenu').show();
				_allMenu.removeClass('on');
				if(idx>0){
					$('#allMenu > ul > li:nth-child('+idx+')').addClass('on');
				}else{
					$('#allMenu > ul > li:first-child').addClass('on');
				}
				$('#allMenu .onArw').remove();
				if(idx>0){
					$('#allMenu > ul > li:nth-child('+idx+')').append('<span class="onArw"></span>');
				}else{
					$('#allMenu > ul > li:first-child > a').append('<span class="onArw"></span>');
				}
				$('.gnbMenu').hide();
				$('.depth2allMenu > ul > li > ul > li > a').bind('click', function(){
					gnb_log(8299);
				});
				/*가로폭*/
				var _bIndex = false;
				if (location.pathname == "/" || location.pathname == "/Index.jsp"){
					var _bIndex = true;
				}
				if (getBrowserName() == "msie7" && !_bIndex){
					$(".depth2allMenu").width($('.gnbMenu').width()-1);
					$(".depth2allMenu").css("left",-1);
					if($('.depth2allMenu > ul > li:nth-child(5)').width()==0){ //사이트맵페이지
						$('.depth2allMenu > ul > li:nth-child(5) ').css("width","195");
						$('.depth2allMenu > ul > li:nth-child(10) ').css("width","195");
					}else{
						$('.depth2allMenu > ul > li:nth-child(5) ').css("width",$('.depth2allMenu > ul > li:nth-child(5)').width()-1);
						$('.depth2allMenu > ul > li:nth-child(10) ').css("width",$('.depth2allMenu > ul > li:nth-child(10)').width()-1);
					}
					$('.depth2allMenu > ul > li:nth-child(5) > ul').css("background-color","#ffffff");
					$('.depth2allMenu > ul > li:nth-child(10) > ul').css("background-color","#ffffff");
				}
				if (getBrowserName() == "msie7" && _bIndex && navigator.userAgent.toLowerCase().indexOf("trident/4.0") <0 ){
					$('.depth2allMenu > ul > li:nth-child(5)').css("width","177");
					$('.depth2allMenu > ul > li:nth-child(10)').css("width","177");
				}
				/*가로폭*/
			}
		});
	});
}
function gnb_log(logNum){
	var url = "/view/Loginsert_2010.jsp"
	var param = "kind="+logNum;
	if (typeof(modelno) != "undefined"){
		param += "&modelno="+modelno;
	}
	var rtn = "";
	if (typeof(Prototype) != "undefined" ){
		rtn = "PR"
	}else if(typeof(jQuery) != "undefined"){
		rtn = "JQ"
	}
	if (rtn == "PR"){
		var getRec = new Ajax.Request(
			url,
			{
				method:'get',parameters:param
			}
		);
	}else{
		$.ajax({
			type: "POST",
			url: url,
			data: param
		});
	}

}
function gnb_log_cate(logNum,cate){
	var url = "/view/Loginsert_2010.jsp"
	var param = "kind="+logNum+"&cate="+cate;
	var rtn = "";
	if (typeof(Prototype) != "undefined" ){
		rtn = "PR"
	}else if(typeof(jQuery) != "undefined"){
		rtn = "JQ"
	}
	if (rtn == "PR"){
		var getRec = new Ajax.Request(
			url,
			{
				method:'get',parameters:param
			}
		);
	}else{
		$.ajax({
			type: "POST",
			url: url,
			data: param
		});
	}
}
var gnbAdBannerLoged = [0,0,0,0,0,0,0];
function logGnbAdBanner(gnbAdBannerIdx){
	if(gnbAdBannerIdx==4778) gnbAdBannerIdx = 7;
	if(gnbAdBannerLoged[gnbAdBannerIdx-1]==0){
		switch(parseInt(gnbAdBannerIdx)) {
			case 1:
				gnb_log(11936);
				gnbAdBannerLoged[gnbAdBannerIdx-1] = 1;
				break;
			case 2:
				gnb_log(11937);
				gnbAdBannerLoged[gnbAdBannerIdx-1] = 1;
				break;
			case 3:
				gnb_log(11938);
				gnbAdBannerLoged[gnbAdBannerIdx-1] = 1;
				break;
			case 4:
				gnb_log(11939);
				gnbAdBannerLoged[gnbAdBannerIdx-1] = 1;
				break;
			case 5:
				gnb_log(11940);
				gnbAdBannerLoged[gnbAdBannerIdx-1] = 1;
				break;
			case 6:
				gnb_log(11941);
				gnbAdBannerLoged[gnbAdBannerIdx-1] = 1;
				break;
			case 7:
				gnb_log(11942);
				gnbAdBannerLoged[gnbAdBannerIdx-1] = 1;
				break;
		}
	}
}