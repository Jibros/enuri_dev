"use strict";
/*
 * @constrator
 * @param {String} container  - 추가 생성될 객체
 * @param {String} tmplTarget - jQury 템플릿 클래스명 또는 아이디값 
 * @param {Function} beforeCallback - 데이터 추가전 실행될 함수.
 * @param {Function} afterCallback  - 리스트 추가후 실행될 함수.
 */

var BroadCastList = function(container, opts) {
	if ( container == 'undefined' || container == null ) return;
	this.container = $(container);
	this.init(opts);
};
BroadCastList.prototype = {
	data : [],
	index : 0,
	container : null,
	tmplTarget : null,
	beforeCallback : function() {},
	afterCallback : function() {},

	init : function(opts) {
		$.extend(this, opts);
		this.tmplTarget = $(this.tmplTarget);
		if ( this.data.length ) {
			this.setAppendData(this.data); 
		}
	},
	/**
	 * 데이터 추가
	 * @method setAppendData()
	 * @param {Array}
	 *
	 **/
	setAppendData : function(dataArr) {
		// 데이터 추가전 실행함수.
		this.beforeCallback.call(this, dataArr);

		var idx = this.index;
		this.data = this.data.concat(dataArr);
		this.index += dataArr.length;
		
		if ( dataArr[0].startDate != null ) {
			for (var i=0, l=dataArr.length; i < l; i++) {
				dataArr[i].idx = idx++;
				dataArr[i].prevDate = ( i > 0 ) ? dataArr[i-1].startDate : dataArr[i].startDate;
			};
		}

		this.makeTmplSet(dataArr);
	},
	// 리스트 생성
	makeTmplSet : function(dataArr) {
		var tmplData = this.tmplTarget.tmpl(dataArr);
		this.container.append(tmplData);

		// 콜백함수 호출.
		this.afterCallback.call(this);
	},
	// 데이터 초기화
	clearData : function() {
		this.data = [];
		this.index = 0;
		this.container.empty();
	},
	// 데이터 초기화후 다시 그리기.
	resetData : function() {
		this.container.empty();
		this.makeTmplSet(this.data);
	}
};
$.fn.BroadCastList = function(options) {
	return this.each(function() {
		$(this).data("BroadCastList", new BroadCastList(this, options) );
	});
};

function DesignRadio(that) {
	this.init(that);
};
DesignRadio.prototype = {
	label : null,
	radio : null,
	callback : null,
	init  : function(that) {
		this.label = that;
		this.radio = $(this.label).find(':radio')[0];
		// 기존에 이벤트가 있다면 삭제.
		this.EventUnBinding();
		// 새로운 클릭 이벤트 추가.
		this.EventBinding();
		this.Setup();
	},
	/* 
	 * label에 active 클래스가 있거나, radio버튼에 checked 속성이 있을경우. setting해준다.
	 * @method Setup()
	 */
	Setup : function() {
		if ( $(this.label).hasClass('active') || $(this.radio).is(':checked') ) {
			this.Animation();
		};
	},
	/*
	 * 이벤트 실행.
	 * @method Animation();
	 */
	Animation : function() {
		var iRadios = $(":radio[name='" + this.radio.name + "']");
		var iLabels = iRadios.parent('label');
		iRadios.prop('checked', false);
		iLabels.removeClass('active');
		$(this.label).addClass('active');
		$(this.radio).prop('checked', true);
		if ( this.callback != null, this.callback instanceof Function ) {
			this.callback.call();
		}
	},
	/*
	 * label를 클릭할 경우 변경되도록 이벤트 추가.
	 * @method EventBinding();
	 */
	EventBinding : function() {
		var _this = this;
		$(this.label).on('click', function() {
			_this.Animation.call(_this);
		});
	},
	/*
	 * label를 클릭할 경우 실행되던 이벤트를 삭제
	 * @method EventUnBinding();
	 */
	EventUnBinding : function() {
		$(this.label).off('click', this.Animation);
	}
};

function DesignCheckbox(that) {
	this.init(that);
};
DesignCheckbox.prototype = {
	label : null,
	check : null,
	callback : null,
	init  : function(that) {
		this.label = that;
		this.check = $(this.label).find(':checkbox')[0];
		// 기존에 이벤트가 있다면 삭제.
		this.EventUnBinding();
		// 새로운 클릭 이벤트 추가.
		this.EventBinding();
		this.Setup();
	},
	/* 
	 * label에 active 클래스가 있거나, radio버튼에 checked 속성이 있을경우. setting해준다.
	 * @method Setup()
	 */
	Setup : function() {
		if ( $(this.label).hasClass('active') || $(this.check).is(':checked') ) {
			this.Animation(true);
		};
	},
	/*
	 * 이벤트 실행.
	 * @method Animation();
	 */
	Animation : function(isSetup) {
		if ( $(this.check).is(':checked') == false || !!isSetup ) {
			$(this.label).addClass('active');
			$(this.check).prop('checked', true);
		} else {
			$(this.label).removeClass('active');
			$(this.check).prop('checked', false);
		}
		if ( this.callback != null, this.callback instanceof Function ) {
			this.callback.call(this);
		}
	},
	/*
	 * label를 클릭할 경우 변경되도록 이벤트 추가.
	 * @method EventBinding();
	 */
	EventBinding : function() {
		var _this = this;
		$(this.label).on('click', function() {
			_this.Animation.call(_this);
		});
	},
	/*
	 * label를 클릭할 경우 실행되던 이벤트를 삭제
	 * @method EventUnBinding();
	 */
	EventUnBinding : function() {
		$(this.label).off('click', this.Animation);
	}
};

var $doc = $(document);
var $win = $(window);
// document Load.
$(function() {

	if ( FastClick && FastClick != null ) {
		FastClick.attach(document.body);
	};

	var btnTop = $(".btnTop");
	var btnTopPos = 15;
	var quickMenuBar = $(".quickMenuBar");
	if ( quickMenuBar.length ) {
		btnTopPos = 55;

		// 20150729 추가.
		$('#container').css('padding-bottom', quickMenuBar.height() );
	};

	if ( btnTop.length ) {
		btnTop.css('bottom', '-100px');

		var winMaxH = ( $win.height()*0.65 );
		var isTopBtnScroll = false;

		var topBtnScroll = function() {
			if ( isTopBtnScroll ) return;
			isTopBtnScroll = true;
			if ( $win.scrollTop() < winMaxH ) {
				btnTop.stop().animate({'bottom': '-100px'}, 200, function() {
					isTopBtnScroll = false;
					topBtnScroll.call();
				});
			} else {
				btnTop.stop().animate({'bottom': btnTopPos}, 200, function() {
					isTopBtnScroll = false;
					topBtnScroll.call();
				});
			}
		}
		$win.on("scroll.btnTop", topBtnScroll);
	};

	
	$(document).on('ready shown.bs.modal', ".modal", function() {
		$('.iRadio>label').DesignRadio();
		$('.iCheck>label').DesignCheckbox();
	});
});

$.extend({
	modalLoad : function(target, options) {		
		var $this = $(target);
		var targetID = target.slice(1);
		if ( !$this.length ) {
			$this = $('<div></div>').appendTo($('body'));
			$this.attr("id", targetID );
		};
		$this.modalLoad(options);
	}
});

$.fn.extend({
	coverImg : function() {
		this.each(function() {
			var $this, $box;
			if ( this.tagName == 'IMG' ) {
				$this = $(this);
				$box = $("<span></span>");
				$this.wrap($box);
			} else {
				$this = $(this).find("img");
				$box = $(this);
			};
			$box.css({
				"display"			: "block",
				"width"				: "100%",
				"padding-bottom"	: "100%",
				"background-image"	: "url(" + $this.attr('src') + ")",
				"background-color"	: "#fff",
				"-webkit-background-size"	: "cover",
				"-moz-background-size"		: "cover",
				"-ms-background-size"		: "cover",
				"-o-background-size"		: "cover",
				"background-size"			: "cover"
			});
			$img.remove();
		});
	},
	
	/*
	 * 모달레이어 로드 함수.
	 * @param {String} url - Load 경로
	 * @param {String} target - modal 함수 호출 ID. 설정안할경우 Load함수에 적용된 타켓을 기준으로 한다.
	 * @param {Function} (show, shown, hide, hiden)
	 *    - modal에 적용할 함수. open전, open 후, close전, close 후 함수를 지원.
	 */
	modalLoad : function(option) {
		var options = {
			url		 : option.url || '',
			callback : {
				"show.bs.modal"   : option.show  || function() {},
				"shown.bs.modal"  : option.shown || function() {},
				"hide.bs.modal"   : option.hide  || function() {},
				"hidden.bs.modal" : option.hiden || function() {}
			}
		};
		this.each(function() {
			var $this = $(this);
			$this.load(options.url, function( response, status, xhr ) {
				// if ( status == "error" ) return;
				if ( status == "error" ) {
					alert('페이지 로드 실패(URL: '+ options.url +')');
					return;
				};
				var targetID = $this.attr('id');
				var modal = $this.find(".modal");
				$this.prop("id","");
				modal.attr("id", targetID);
				modal.on(options.callback);
			});
		});
	},
	DesignRadio : function() {
		this.each(function() {
			if ( $(this).data('DesignRadio') != null ) {
				var _this = $(this).data('DesignRadio');
				_this.Setup();
			} else {
				$(this).data('DesignRadio', new DesignRadio(this) );
			}
		});
	},
	DesignCheckbox : function() {
		this.each(function() {
			if ( $(this).data('DesignCheckbox') != null ) {
				var _this = $(this).data('DesignCheckbox');
				_this.Setup();
			} else {
				$(this).data('DesignCheckbox', new DesignCheckbox(this) );
			}
		});	
	}
});

