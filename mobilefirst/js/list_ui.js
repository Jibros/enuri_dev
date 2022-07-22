/*window.addEventListener('load', function(){
setTimeout(scrollTo, 0, 0, 1);
}, false); */

var spin_opts = {
	lines: 5, // The number of lines to draw
	length: 30, // The length of each line
	width: 4, // The line thickness
	radius: 10, // The radius of the inner circle
	corners: 1, // Corner roundness (0..1)
	rotate: 0, // The rotation offset
	color: '#000', // #rgb or #rrggbb
	speed: 1, // Rounds per second
	trail: 60, // Afterglow percentage
	shadow: false, // Whether to render a shadow
	hwaccel: false, // Whether to use hardware acceleration
	className: 'spinner', // The CSS class to assign to the spinner
	zIndex: 2e9, // The z-index (defaults to 2000000000)
	top: 'auto', // Top position relative to parent in px
	left: 'auto' // Left position relative to parent in px
};
 
$.fn.spin = function(spin_opts) {
	this.each(function() {
		var $this = $(this),
			data = $this.data(); 

		if (data.spinner) {
			data.spinner.stop();
			delete data.spinner;
		}
		if (spin_opts !== false) {
			data.spinner = new Spinner($.extend({color: $this.css('color')}, spin_opts)).spin(this);
		}
	});
	return this;
};

$(function(){

	var reszieEvent = 'orientationchange' in window ? 'orientationchange' : 'resize',
		resizeTimer;

	function allMenu() {
		function menuOpen() {
			$('.allMenu').show();
			$('.headTop').append('<div class="dimmed"></div>');
			$('html, body').addClass('dimdOn');
		}
		function menuClose() {
			$('.allMenu').hide();
			$('.dimmed').remove();
			$('html, body').removeClass('dimdOn');
			$('.allMenuBtn button').removeClass('on');
		}
		$('.allMenuBtn button').click(function(){
			var _this = $(this);
			_this.toggleClass('on');
			(_this.hasClass('on')) ? menuOpen() : menuClose();
			insertLog('10991');//클릭 로그
		});
		$('.headTop').on('click', 'div.dimmed', function(){
			menuClose();
		});
	}
	allMenu();

	document.body.addEventListener('touchmove', function(e){
		if($('body').hasClass('dimdOn')){e.preventDefault();}
	}, false);

	depth2Index = -1;
	depth3Index = -1;
	
	function category() {
		
		var _depth1 = $('.categoryList > li'),
			_depth1Link = $('.categoryList > li > a'),
			category = $('.categoryList'),
			_depth2 = $('.depth2 > li'),
			categoryDepth3 = $('.depth3');
			
		$('.categoryList > li > a').click(function(){

			insertLog('11017');
			var _this = $(this);
			
			depth2Index = _this.parent().index();
			
			try{
				localStorage.setItem("cate2depth",depth2Index);
			}catch(err){
				
			}
			
			var nowUrl = document.URL;
			//현재 페이지가 리스트 일경우
			if(nowUrl.indexOf("app=Y") > 0){
				scrollTo(0,0);
			}else{
				scrollTo(0,56);
			}
			
			if (_this.parent().hasClass('on')) {
				_depth1.removeClass('on');
				_depth2.removeClass('on');
			} else {
				_depth1.removeClass('on');
				_depth2.removeClass('on');
				_this.parent().addClass('on');
			}
			
			/*
			if ($('#wrap').hasClass('flickingContents')) {
				var cateHeight = $('.category').height();
				$('#container').height(cateHeight);
			}
			*/
		});
		$('.depth2 > li > a').click(function(){
			insertLog('11018');
			
			var _this = $(this);
			_depth2.removeClass('on');
			_this.parent().addClass('on');
			cateHeight = category.height();
			categoryDepth3.height(cateHeight);
			
			depth3Index = _this.parent().index();
			
			try{
				localStorage.setItem("cate3depth",depth3Index);				
			}catch(err){
				
			}
			
			var nowUrl = document.URL;
			//현재 페이지가 리스트 일경우
			if(nowUrl.indexOf("app=Y") > 0){
				scrollTo(0,0);
			}else{
				scrollTo(0,56);
			}
			
		});
		
	}
	category();
	
	//sessionStorage.setItem("cateBanner",modelno);

	$(window).bind('scroll', function(){
		var _footNav = $('.footNav2');
		if ($('body').hasClass('dimdOn') != 1) {
			_footNav.css('display','none');
			clearTimeout( $.data( this, "scrollCheck" ) );
			$.data( this, "scrollCheck", setTimeout(function() {
				_footNav.fadeIn('fast');
			}, 250) );
		}
	});

	$('.prodChoice select').bind('touchstart', function(){
		$(this).prev('button').addClass('on');
	});
	$('.prodChoice select').bind('touchend',function(){
		$(this).prev('button').removeClass('on');
	});

	/*$('.prodChoice select').bind('change', function(){
		$(this).prev('button').addClass('on');
	});*/

	function tabCont(_this) {
		if (_this.parent().hasClass('on')) {
			_this.parent().parent().find(' > li').removeClass('on');
		} else {
			_this.parent().parent().find(' > li').removeClass('on');
			_this.parent().addClass('on');
		}
	}
	$('.sortSelect > ul > li > button').click(function(){
		var _this = $(this);
		tabCont(_this);
		brandSort();
	});
	$('.prodEnuriInfo > li > button').click(function(){
		var _this = $(this);
		tabCont(_this);
		$('.btnAllOpen').removeClass('on');
	});
	$('.btnGrid').click(function(){
		$('.btnGrid').hide();
		$('.btnList').show();
		$('.prodList').addClass('gridType');
		if($('.btnAllOpen').hasClass('on')){
			$(".btnAllOpen").removeClass("on");
			$('.toggle').removeClass("txtclose");
		}
	});
	$('.btnList').click(function(){ 
		$('.btnGrid').show(); 
		$('.btnList').hide();
		$('.prodList').removeClass('gridType');
	});
	$('.btnAllOpen').click(function(){
		$(this).toggleClass('on');
		//$('.toggle').click(); 

		if($('.btnAllOpen').hasClass('on')){
			$('.toggle').addClass("txtclose");
		}else{ 
			$('.toggle').removeClass("txtclose");
		}
		 
		if ($('.prodList').hasClass('gridType')) {
			$('.prodList').removeClass('gridType');
			$('.btnGrid').show();
			$('.btnList').hide();
		} 
	});

	$('.prodDetailTab button').click(function(){
		var _this = $(this);
		$('.prodDetailTab li').removeClass('on');
		_this.parent().addClass('on');
		var tabIdx = _this.parent().index();
		$('.prodDetailInfo .prodDetailBox').removeClass('on');
		$('.prodDetailInfo .prodDetailBox').eq(tabIdx).addClass('on');
		$('.prodRating li .shortBox').each(function(){
			var _this = $(this);
			if (_this.height() > 50) {
				_this.parent().addClass('short');
			}
		});
	});
	$('.prodDetailBox .openBtn button').click(function(){
		var _this = $(this);
		_this.parent().parent().find('.shortBox').toggleClass('open');
		_this.toggleClass('on');
		_this.text('접기');
		if (_this.hasClass('on') != 1) {
		_this.text('더보기');
		}
	});
	function layerPop(_this){
		_this.next('.layerPop').show();
		var layerPopHeight = _this.next('.layerPop').find('.layerPopInner').height();
		_this.next('.layerPop').find('.layerPopInner').css('margin-top','-'+ layerPopHeight / 2 + 'px' );
		$('.layerPop').append('<div class="dimmed"></div>');
		$('html, body').addClass('dimdOn');
	}
	function layerPop1(_this){
		$('.layerPop1').show();
		var layerPopHeight = $('.layerPop1').find('.layerPopInner').height();
		$('.layerPop1').find('.layerPopInner').css('margin-top','-'+ layerPopHeight / 2 + 'px' );
		$('body').append('<div class="dimmed"></div>');
		$('html, body').addClass('dimdOn');
	}

	$('.prodSection .btnLink').click(function(){
		var _this = $(this);
		layerPop(_this);
	});
	$('.listSort .btnTxt').click(function(){
		var _this = $(this);
		layerPop(_this);
	});
	$('.linkList .btnLow').click(function(){
		var _this = $(this);
		layerPop(_this);
	});
	$('.buyNoticePop').click(function(){
		var _this = $(this);
		layerPop1(_this);
		return false;
	});
	$('.layerPop .btnClose').click(function(){
		var _this = $(this);
		$('.dimmed').remove();
		$('html, body').removeClass('dimdOn');
		_this.parent().parent().parent().hide();
	});

	$('#touchSlider img').load(function(){
		var sliderHeight = $('#touchSlider > ul > li').height();
		$('#touchSlider').css('height', sliderHeight + 'px');
	});
	function flickingHeight() {
		var sliderHeight = $('#touchSlider > ul > li').height();
		$('#touchSlider').css('height', sliderHeight + 'px');
	};
	flickingHeight();

	$('.cateSort > li > button').click(function(){
		var _this = $(this);
		tabCont(_this);
	});
	$('.cateSort .cateSortList li a').click(function(){
		var _this = $(this);
		tabCont(_this);
		return false;
	});
	function allCateLIst() {
		var cateWidth  = $('.allCateLIst').width(),
			listLength = $('.cateSortList > div > ul').length,
			listWidth = $('.cateSortList > div > ul').width(cateWidth);
		$('.cateSortList > div').width((cateWidth * listLength));
	}
	allCateLIst();

	function brandSort() {
		var brandWidth = $('.brandSort').width(),
			brandListLength = $('.brandSort > div > ul').length,
			brandListWidth = $('.brandSort > div > ul').width(brandWidth);
		$('.brandSort > div').width((brandWidth * brandListLength));
	}
	brandSort();

	function agreeHeight() {
		wHeight = $(window).height();
		pageHeadHeight = $('.pageHead').height();
		agreeBoxHeight = wHeight - pageHeadHeight - 13;
		$('.agreeBox').css('min-height', agreeBoxHeight + 'px');
	}
	agreeHeight();

	$(window).bind(reszieEvent, function() {
		clearTimeout(resizeTimer);
		resizeTimer = setTimeout(function(){
			flickingHeight();
			agreeHeight();
			allCateLIst();
			brandSort();
		},300);
	});

	$('.inputBox .txt').bind('focusin', function() {
		$(this).prev('label').hide();
	});
	$('.inputBox .txt').bind('focusout', function(){
		if ($(this).val()) {
			$(this).prev('label').hide();
		} else {
			$(this).prev('label').show();
		}
	});
	function sortSel() {
		var onTxt = $('.sortSel option').filter(':selected').text();
		$('.sortSel').prev('button').text(onTxt);
		$('.listSort button').click(function(){
			$('.listSort button').removeClass('on');
			$(this).addClass('on');
		});
		$('.sortSel select').bind('change', function(){
			var selTxt = $(this).find('option').filter(':selected').text();
			$('.sortSel').prev('button').text(selTxt);
			$('.listSort button').removeClass('on');
			$('.sortSel').prev('button').addClass('on');
		});
	}
	sortSel();

	function storeList() {
		var labelCheck = $('.storeList > ul > li > div').find('.labeling');
		labelCheck.each(function(){
			if (labelCheck){
				$(this).parent().addClass('labelCheck');
			}
		});
	}
	storeList();

});

(function ($) {

	$.fn.touchSlider = function (settings) {

		settings = jQuery.extend({
			roll : true,
			flexible : false,
			btn_prev : null,
			btn_next : null,
			paging : null,
			speed : 75,
			view : 1,
			range : 0.15,
			initComplete : null,
			counter : null			
		}, settings);

		var opts = [];
		opts = $.extend({}, $.fn.touchSlider.defaults, settings);

		return this.each(function () {

			$.fn.extend(this, touchSlider);

			var _this = this;

			this.opts = opts;
			this._view = this.opts.view;
			this._speed = this.opts.speed;
			this._tg = $(this);
			this._list = this._tg.children().children();
			this._width = parseInt(this._tg.css("width"));
			this._item_w = parseInt(this._list.css("width"));
			this._len = this._list.length;
			this._range = this.opts.range * this._width;
			this._pos = [];
			this._start = [];
			this._startX = 0;
			this._startY = 0;
			this._left = 0;
			this._top = 0;
			this._drag = false;
			this._scroll = false;
			this._btn_prev;
			this._btn_next;

			this.init();

			$(this)
			.bind("drag", this.touchmove)
			.bind("dragend", this.touchend)

			$(window).bind("orientationchange resize", function () {
				_this.resize(_this);
			});
		});

	};

	var touchSlider = {

		init : function () {
			var _this = this;

			$(this).children().css({
				"width":this._width + "px",
				"overflow":"visible"
			});

			if(this.opts.flexible) this._item_w = this._width / this._view;
			if(this.opts.roll) this._len = Math.ceil(this._len / this._view) * this._view;

			for(var i=0; i<this._len; ++i) {
				this._pos[i] = this._item_w * i;
				this._start[i] = this._pos[i];
				this._list.eq(i).css({
					"float" : "none",
					"display" : "block",
					"position" : "absolute",
					"top" : "0",
					"left" : this._pos[i] + "px",
					"width" : this._item_w + "px"
				});
			}

			if(this.opts.btn_prev && this.opts.btn_next) {
				this.opts.btn_prev.bind("click", function() {
					_this.animate(1, true);
					return false;
				})
				this.opts.btn_next.bind("click", function() {
					_this.animate(-1, true);
					return false;
				});
			}

			if(this.opts.paging) {
				$(this._list).each(function (i, el) {
					var btn_page = _this.opts.paging.eq(0).clone();
					_this.opts.paging.before(btn_page);

					btn_page.bind("click", function() {
						var crt = ($.inArray(0, _this._pos) / _this._view) + 1;
						var cal = crt - (i + 1);

						while(cal != 0) {
							if(cal < 0) {
								_this.animate(-1, true);
								cal++;
							} else if(cal > 0) {
								_this.animate(1, true);
								cal--;
							}
						}

						return false;
					});
				});

				this.opts.paging.remove();
			}

			this.counter();
			this.initComplete();
		},

		initComplete : function () {
			if(typeof(this.opts.initComplete) == "function") {
				this.opts.initComplete(this);
			}
		},

		resize : function (e) {
			if(e.opts.flexible) {
				var tmp_w = e._item_w;

				e._width = parseInt(e._tg.css("width"));
				e._item_w = e._width / e._view;
				e._range = e.opts.range * e._width;

				for(var i=0; i<e._len; ++i) {
					e._pos[i] = e._pos[i] / tmp_w * e._item_w;
					e._list.eq(i).css({
						"left" : e._pos[i] + "px",
						"width" : e._item_w + "px"
					});
				}
			}
		},

		touchend : function (e) {
			if((e.type == "touchend" && e.originalEvent.touches.length <= 1) || e.type == "dragend") {
				if(this._scroll) {
					this._drag = false;
					this._scroll = false;
					return false;
				}

				this.animate(this.direction());
				this._drag = false;
				this._scroll = false;
			}
		},

		position : function (d) {
			var gap = this._view * this._item_w;

			if(d == -1 || d == 1) {
				this._startX = 0;
				this._start = [];
				for(var i=0; i<this._len; ++i) {
					this._start[i] = this._pos[i];
				}
				this._left = d * gap;
			} else {
				if(this._left > gap) this._left = gap;
				if(this._left < - gap) this._left = - gap;
			}

			if(this.opts.roll) {
				var tmp_pos = [];
				for(var i=0; i<this._len; ++i) {
					tmp_pos[i] = this._pos[i];
				}
				tmp_pos.sort(function(a,b){return a-b;});

				var max_chk = tmp_pos[this._len-this._view];
				var p_min = $.inArray(tmp_pos[0], this._pos);
				var p_max = $.inArray(max_chk, this._pos);

				if(this._view <= 1) max_chk = this._len - 1;

				if((d == 1 && tmp_pos[0] >= 0) || (this._drag && tmp_pos[0] > 0)) {
					for(var i=0; i<this._view; ++i, ++p_min, ++p_max) {
						this._start[p_max] = this._start[p_min] - gap;
						this._list.eq(p_max).css("left", this._start[p_max] + "px");
					}
				} else if((d == -1 && tmp_pos[max_chk] <= 0) || (this._drag && tmp_pos[max_chk] <= 0)) {
					for(var i=0; i<this._view; ++i, ++p_min, ++p_max) {
						this._start[p_min] = this._start[p_max] + gap;
						this._list.eq(p_min).css("left", this._start[p_min] + "px");
					}
				}
			} else {
				var last_p = parseInt((this._len - 1) / this._view) * this._view;
				if(	(this._start[0] == 0 && this._left > 0) || (this._start[last_p] == 0 && this._left < 0) ) this._left = 0;
			}
		},

		animate : function (d, btn_click) {
			if(this._drag || !this._scroll || btn_click) {
				if(btn_click) this.position(d);

				var gap = d * (this._item_w * this._view);
				if(this._left == 0) gap = 0;

				for(var i=0; i<this._len; ++i) {
					this._pos[i] = this._start[i] + gap;
					this._list.eq(i).animate({"left": this._pos[i] + "px"}, this._speed);
				}

				this.counter();
			}
		},

		direction : function () {
			var r = 0;

			if(this._left < -(this._range)) r = -1;
			else if(this._left > this._range) r = 1;

			if(!this._drag || this._scroll) r = 0;

			return r;
		},

		counter : function () {
			if(typeof(this.opts.counter) == "function") {
				var param = {
					total : Math.ceil(this._len / this._view),
					current : ($.inArray(0, this._pos) / this._view) + 1
				};
				this.opts.counter(param);
			}
		}

	};

	$.fn.extend({
		customSelect: function() {
			var select = $(this),
				selectNum = null;
			if (!select.get(0)){return false}
			$.each(select, function(i) {
				var thisSelect = $(this),
					selectList,
					thisSelected,
					openState = false,
					selectWidth = thisSelect.attr('style'),
					thisSelectList = thisSelect.find('option');
				var openStateFn = function() {
					selectList.remove();
					$(document).unbind('click', openStateFn);
					openState = false;
					selectNum = null;
					$('.select-box').removeClass('open');
				};

				thisSelect.css({ display: 'none' })
					.wrap('<span></span>').parent()
					.attr({'class' : 'select-box' + thisSelect.attr('class').replace('select', '')})
					.attr('style',selectWidth)
					.append('<span class="selected">' + thisSelectList.filter(':selected').text() + '</span>')
					.click(function() {
						$('.select-box').addClass('open');
						if (openState == true || selectNum == i) {
							selectNum = null;
							$('.select-box').removeClass('open');
							return;
						}
						if (selectNum != null && selectNum != i) {
							if ($('ul.select-box-list').is() == false) selectList = $('ul.select-box-list');
							$('.select-box').removeClass('open');
							selectList.remove();
						}
						thisSelected = $(this);
						selectList = $('<ul></ul>').attr({
							'class' : 'select-box-list' + thisSelect.attr('class').replace('select', '')
						}).appendTo('body');

						selectList.css({
							left: thisSelected.offset().left + 'px',
							top: thisSelected.offset().top + thisSelected.outerHeight() + 'px',
							width: thisSelected.width() + 2 + 'px'
						});
						$.each(thisSelectList, function(i) {
							$('<li>' + $(this).text() + '</li>').appendTo(selectList)
								.click(function() {
									openState = false;
									thisSelected.find('span').text(thisSelectList.eq(i).text());
									//thisSelect.val(thisSelectList.eq(i).val());
									thisSelect.change(function() {
										$(this).val(thisSelectList.eq(i).val());
									}).change();
									$('.select-box').removeClass('open');
									selectList.remove();
									return false;
								}).hover(function() { $(this).addClass('hover'); }, function() { $(this).removeClass('hover'); });
						});
						//openState = true;
						selectNum = i;
						$(document).bind('click', openStateFn);
						return false;
					});
			});
		},		
		/*
		bestContents : function(){
			var _this = $(this),
				tabCheck = _this.find('.tabContents a'),
				contCheck = _this.find('.bestCont');
			if (!_this.get(0)){return false};
			$.each(tabCheck,function(){
				$(this).click(function(){
					tabCheck.removeClass('on');
					$(this).addClass('on');
					contCheck.hide();					
					$($(this).attr('href')).show(0,function(){						
						var heightCheck = $(this).parent().height()+10;
						console.log(heightCheck);
						$('.swipe-wrap').height(heightCheck);
					});
					return false;
				});
			});
		},
		*/
		/* 0824 추가 */
		bestCategory : function(){
			var _this = $(this),				
				icoCheck = _this.find('.ico');
			if (!_this.get(0)){return false};			
			$.each(icoCheck, function(){
				$(this).click(function(){
					icoCheck.removeClass('on');
					$(this).addClass('on');
				});
			});
		},
		/* --// 0824 추가 */
		/* 0824 추가 */
		mainBannerControl : function(){
			var _this = $(this),
				listLength = _this.find('li').length;
				randomList = Math.floor((Math.random()*listLength)+1),
				nextControl = _this.find('.btnNext'),
				prevControl = _this.find('.btnPrev');
			if (!_this.get(0)){return false};			
			$(this).find('.btnPage').eq(randomList).click();
			var autoList = function(){init = setInterval(function(){_this.find('.btnNext').click()},6000);}
			autoList();
			prevControl.click(function(){
				clearInterval(init);
				autoList();
			});
			nextControl.click(function(){
				clearInterval(init);
				autoList();
			});
		}
		/* --// 0824 추가 */
	})
	$(document).ready(function() {
		$('select.select').customSelect();
		//$('#container').bestContents();
		/* 0824 추가 */
		$('.bestCategoryWrap').bestCategory();		
		/* --// 0824 추가 */
		/* 0824 추가 */
		$('.flickingBanner').mainBannerControl();		
		/* --// 0824 추가 */
		$('#keyword').click(function(){
			$('#container').hide();
		});
		$('#searchWrap .close').click(function(){
			$('#container').show();
		});
	})

})(jQuery);