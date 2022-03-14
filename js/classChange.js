(function($){
	var viewPort = (function(){
		var document_el, body_class, nowClass, prevClass, viewportWidth;
		var mobileH, mobileW, tabletH, tabletW, pc ,mSize_s, mSize_m, mSize_l, mSize_t, tSize_s, tSize_l, pSize_s, pSize_m, pSize_l;
		var chk, tabletW, tabletAgent, tabletVportCont, tabletWidth, tabletHeight, $viewport;

		function init(){
			mobileH = {};
			mobileW = {};
			tabletH = {};
			tabletW = {};
			pc = {};

			resizeEvent();
			orien();
		}

		function resizeEvent(){
			if($('html').hasClass('ie8') || $('html').hasClass('ie7') ) {
				$('body').addClass('pc');
				return;
			}
			//$(window).on('load resize', function(){
			$(window).on('load', function(){
			//	viewPortChk();
				if (navigator.userAgent.toLowerCase().indexOf('ipad') > -1 || (navigator.userAgent.toLowerCase().indexOf('android') > -1 && navigator.userAgent.toLowerCase().indexOf('mobile') == -1)){
					$('body').removeClass('mobile pc_o');
					$('body').addClass('mobile');
					console.log(0)
				}else if( document.URL.indexOf("/lucky7.jsp") > -1){
					viewPortChk();
				}
			});
		}

		function orien(){
			$(window).off('orientationchange').on('orientationchange', function(){
				$(document).trigger('viewPort.orien');
			});
		}

		function tabletViewPort(){
			console.log(1)
			tabletAgent = navigator.userAgent;
			$viewport = $('head meta[name="viewport"]');
			$viewport.attr('content', 'width=device-width');
			tabletWidth = $(window).width();
			if(tabletAgent.indexOf('iPad') !== -1){
				//$viewport.attr('content', 'width='+ tabletWidth + ', initial-scale=1, maximum-scale=1, user-scalable=no');
			} else if (tabletAgent.indexOf('Android') !== -1){
				setTimeout(function(){
					tabletWidth = $(window).width();
					//$viewport.attr('content', 'width='+ tabletWidth + ', initial-scale=1, maximum-scale=1, user-scalable=no');
				},300);
			}
		}

		function viewPortChk(){
			document_el = $('body');
			viewportWidth = window.innerWidth || $(window).width();
			prevClass = document_el.attr('class');
			mSize_t = 768;								// MOBILE
			tSize_s = 984;								// PC UNDER
			pSize_s = 1280;								// PC OVER
			body_class = [ 'mobile' , 'mobileW' , 'pc_u' , 'pc_o', 'pc' + pSize_m ];
									mobileH.s = viewportWidth <= mSize_s;
									mobileH.m = viewportWidth <= mSize_m;
									mobileH.l = viewportWidth <= mSize_l;
			mobileH.t =  viewportWidth < tSize_s;
									mobileW = viewportWidth >= mSize_t && viewportWidth < tSize_s;
			tabletT = viewportWidth >= tSize_s && viewportWidth < pSize_s;
									pc.s = viewportWidth > pSize_s && viewportWidth < pSize_m;
									pc.m = viewportWidth >= pSize_m;
			pc.t = viewportWidth >= pSize_s;

			if( mobileH.t ){
				// console.log('mobile')
				document_el.removeClass('pc_o pc_u');
				document_el.addClass(body_class[0]);
			} else if( tabletT ){
				// console.log('pc_u')
				document_el.removeClass('mobile pc_o');
				document_el.addClass(body_class[2]);
			} else if( pc.t ){
				// console.log('pc')
				document_el.removeClass('mobile pc_u');
				document_el.addClass(body_class[3]);
			}
			nowClass = document_el.attr('class');

			if (prevClass != nowClass && typeof prevClass !== 'undefined'){
				var param = {
					prev: prevClass
					, now: nowClass
				};
				$(document).trigger('viewPort.changed', param);
			}

		}
		return {
			init: init
			, viewPortChk: viewPortChk
			, tabletViewPort: tabletViewPort
		}
	})();

	$(function(){
		viewPort.init();
	});
})(jQuery);