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
					var _banner_idx = Math.floor(Math.random()*_banner_cnt)+1; //노출할 배너 랜덤
					if(_banner_cnt>0){
						_banner.attr("src", gnb_banner_img_hash[_banner_level1][_banner_idx-1]);
						_banner_a.attr("href", gnb_banner_link_hash[_banner_level1][_banner_idx-1]);
						_banner_a.attr("linktype", gnb_banner_linktype_hash[_banner_level1][_banner_idx-1]);
					}
				}
				if(_banner_cnt==0){ //등록된 배너 없으면 추천상품영역 삭제
					_banner.parent().parent().parent().remove();
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
				
				$('.search > span').removeClass('on');
				if( $('#ac_layer_main').is(':visible') ) {
					toggleAutoMake();
				}
			});
			$('.depth2 > ul > li > a').bind('mouseenter focusin', function(){
				var _this = $(this);

				_depth2.removeClass('on');
				_this.parent().addClass('on');
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
				var _this = $(this);
				var _seq = _this.parent().parent().parent().parent().parent().parent().attr('seq');
				_this.parent().parent().parent().parent().parent().parent().find('a').addClass('current');
				_depth1.removeClass('on');
				_depth3Detail.show();
				
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
										var _detail1depth = $('#depth3Detail > ul > li'),
											_detail2depth = $('.detailDepth2 > ul > li');
										
										$('#depth3Detail > ul > li > a').unbind();
										$('#depth3Detail > ul > li > a').bind('click', function(){
											var _this = $(this);
											var blankClassName = _this.parent().attr("class");
											if( blankClassName != null && blankClassName.indexOf("detailDepth1_blank") >= 0 ){
												return;
											}
											_detail1depth.removeClass('on');
											_detail2depth.removeClass('on');
											_this.parent().addClass('on');
											_this.next().find('li:first-child').addClass('on');
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
									
										if (getBrowserName() == "msie7"){
											var _varspan = $("#depth3Detail_"+_seq + "  span");
											for (var i=0;i<_varspan.length;i++){
												if ($(_varspan[i]).html().toLowerCase().indexOf("<br>") < 0 ){
													$(_varspan[i]).css('margin-top','25px');
												}else{
													$(_varspan[i]).css('margin-top','16px');
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
				loadGnbAllMenu();
			});
			$('#gnb').bind('mouseleave', function(){
				_depth1.removeClass('on');
				_depth2.removeClass('on');
				//stopGnbBannerRoll();
			});
			$('.toggleAuto').click(function(){
				toggleAutoMake();
				return false;
			});			
			//loadGnbDepth3Detail(1);
			//loadGnbAllMenu();
		}
		function loadGnbAllMenu(){
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
						if (typeof(_this.parent().attr("class")) != "undefined"){
							allMenuClass = _this.parent().attr("class")
						}
						if(allMenuClass.indexOf("allMenuBtn") < 0){
							_allMenu.removeClass('on');
							_this.parent().addClass('on');
						}
					});
					$('#allMenu > ul > li.allMenuBtn > a').bind('click', function(){
						$('.gnbMenu').hide();
						_allMenu.removeClass('on');
						$('#allMenu > ul > li:first-child').addClass('on');
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
						*/
					});
					$('.depth2allMenu > ul > li:first-child, .depth2allMenu > ul > li:nth-child(6)').addClass('noLine');
					if (getBrowserName() == "msie7"){
						$('.depth2allMenu > ul > li:nth-child(5) > ul').css("width",177);
						$('.depth2allMenu > ul > li:nth-child(5) > ul').css("background-color","#ffffff");
						$('.depth2allMenu > ul > li:nth-child(10) > ul').css("width",177);
						$('.depth2allMenu > ul > li:nth-child(10) > ul').css("background-color","#ffffff");					
					}
					$('#allMenu').show();
					_allMenu.removeClass('on');
					$('#allMenu > ul > li:first-child').addClass('on');
					$('.gnbMenu').hide();
				}
			});
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