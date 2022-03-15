
(function (context, $, GUI) {
"use strict";
	
	GUI = enuriUI.GUI;
	var GF = enuriUI.GF,
		Class = GUI.Class;

	GUI.define('GUI.Slide', function() {
        var Slide = Class({
            name: 'Slide',
            $extend: GF.View,
            defaults: {
				viewItem : 1,
				indicators : false,
				ajaxLoad : true,
				loadUrl : ''
            },
			selectors: {
				paging : '.total-paging strong',
				prevBtn : '.total-paging a:eq(0)',
				nextBtn : '.total-paging a:eq(1)',
				indicators : '.indicators'
			},
            initialize: function(el, options) {
                var me = this;
                if(me.supr(el, options) === false) { return; }
				if(me.options.ajaxLoad){
					me.$el.css('visibility','hidden');
					me.itemLoad(); //ajax데이터 로드
				}
            },
			itemLoad : function(){ //json 로드
				var me = this;
				$.getJSON(me.options.loadUrl, null, function(data) {
					me.options.itemLoad(me, data);//로드후 마크업 구성은 호출부에서 설정해야함
					me.ajaxData = data;

					me.$items = me.$el.find(me.options.selectors.items);
					me.$items.eq(0).addClass('on');
					me.options.indicators && me.indCreate(me.$items.eq(0).find('>ul>li').length); //인디케이터 생성
					me.$paging.html('<em>1</em>/'+me.$items.length); //페이징 초기화
					me.$el.css('visibility','');
					me.bind(); //prev, next, indicators 기능 적용
				})
			},
			indCreate : function(num){
				var me = this;
				var result = [];
				var len = num || me.options.viewItem;

				for( var i =0; i < len; i++){
					result.push(['<li><a href="#">'+(i+1)+'</a></li>'])
				}
				me.$indicators.html(result.join(''));
				me.$indicators.find('li').eq(0).addClass('selected');
			},
			move : function(behavior){
				var me = this;
				var idx = me.count(behavior);
				idx && me.selected(idx - 1)
			},
			selected : function(idx){
				var me = this;
				me.$items.eq(idx).show().siblings().hide();
				if(me.options.indicators){
					me.$el.find(me.options.selectors.items + '.on').find('li').show();
					me.indCreate(me.$items.eq(idx).find('>ul>li').length); //인디케이터 생성
				}
				me.$items.eq(idx).addClass('on').siblings().removeClass('on');
				me.$paging.html('<em>'+(idx+1)+'</em>/'+me.$items.length);//페이징 적용
			},
			count : function(val){
				var me = this,
					text = me.$paging.text(),
					now = parseInt(text.split('/')[0]),
					total = parseInt(text.split('/')[1]);
				if(total >= (now + val) && (now + val) > 0){
					var idx = now + val;
					 return idx;
				}

				return false;
			},
			bind : function(){
				var me = this;
				me.$prevBtn.unbind('click');
				me.$nextBtn.unbind('click');
				me.$prevBtn.click(function(e){
					e.preventDefault();
					me.move(-1);
				});
				me.$nextBtn.click(function(e){
					e.preventDefault();
					me.move(1);
				});
			}
        });

		GUI.bindjQuery(Slide, 'SlideFx')
        return Slide;
    });

	GUI.define('GUI.SlideMenu', function() {
        var SlideMenu = Class({
            name: 'SlideMenu',
            $extend: GF.View,
            defaults: {
				viewMenu : 6,
				ajaxLoad : true,
				loadUrl : ''
            },
			selectors: {
				prevBtn : '.prev',
				nextBtn : '.next',
				targetContainer : '> div:eq(1)'
			},
            initialize: function(el, options) {
                var me = this;
                if(me.supr(el, options) === false) { return; }
				if(me.options.ajaxLoad){
					me.$el.css('visibility','hidden');
					me.stats = 0;
					me.itemLoad(); //ajax데이터 로드
				}
            },
			itemLoad : function(){ //json 로드
				var me = this;
				$.getJSON(me.options.loadUrl, null, function(data) {
					me.options.itemLoad(me, data);//로드후 마크업 구성은 호출부에서 설정해야함
					me.ajaxData = data;

					me.$items = me.$el.find(me.options.selectors.items);
					me.$items.eq(0).addClass('selected');
					me.$el.css('visibility','');
					me.bind(); //prev, next 기능 적용
				})
			},
			move : function(behavior){
				var me = this;
				var idx = me.count(behavior);
				idx && me.selected();
			},
			selected : function(){
				var me = this;
				if(me.$items.length > me.options.viewMenu){
					me.$items.each(function(index){
						var item = $(this);
						if(index >= me.stats && index < (me.stats+me.options.viewMenu)){
							if(index == me.stats){
								item.css('marginTop','0')
							}
							item.show();
						}else{
							item.hide();
						}
					})
				}
			},
			count : function(val){
				var me = this;
				var stats = me.stats;

				if(stats+(val* me.options.viewMenu) > -1 && stats+(val* me.options.viewMenu) < me.$items.length){
					me.stats = stats+(val* me.options.viewMenu);
					return true;
				}
				return false;
			},
			bind : function(){
				var me = this;
				me.$prevBtn.unbind('click');
				me.$nextBtn.unbind('click');
				me.$prevBtn.click(function(e){
					e.preventDefault();
					me.move(-1);
				});
				me.$nextBtn.click(function(e){
					e.preventDefault();
					me.move(1);
				});
			}
        });

		GUI.bindjQuery(SlideMenu, 'slideMenu')
        return SlideMenu;
    });

})(window, jQuery, enuriUI.GUI);



$(document).ready(function(){
	/* @ 오늘의 뉴스 
		json 두개를 로드해서 병합하여 출력
		news 2개 hitnew 8개 가 하나의 아이템으로 노출됨.
	*/
	$('#news').SlideFx({
		viewItem : 2,
		loadUrl : "/common/js/ajax/getNews_ajax.js", 
		templete : '<div><span><a href="{linkUrl}"><img src="{imageUrl}" alt="{title}"></a></span><strong><a href="{linkUrl}">{title}</a></strong></div>', //{}안의 내용은 ajax 데이터의 동일한 key의 값으로 replace됨
		viewItem2 : 8,
		loadUrl2 : "/common/js/ajax/getHitNews_ajax.js",
		templete2 : '<li><a href="{linkUrl}">{title}</a></li>',
		selectors : {
			prevBtn: 'a.prev',
			nextBtn: 'a.next',
			items : '.viewport > div'
		},
		itemLoad : function(me, data, type){//  탭별로 type을 나눠서 신차와 동일한 방식으로
			/* 컨텐츠별로 마크업 구조가 다를수 있기 때문에 ajax로드 데이타를 이용해 트리구조 변경은 호출 함수별로 설정 필요 */
			var imgPath = "http://img.enuri.gscdn.com/2014/main/images/",
				wrapHtml = [],
				data = me.ajaxData || data,
				tabType = type || 0,
				n = 0;

			$.getJSON(me.options.loadUrl2, null, function(data2) {//HitNewsLoad
				//getNews_ajax
				for(var i=0; i< data[tabType].newsList.length; i++){//10
					var obj = data[tabType].newsList[i];
					var result = me.options.templete;
					var itemHtml = [];
					var _val = '';
					
					for (var key in obj){
						_val = obj[key];
						if(key.indexOf('image') != -1){
							_val = imgPath + obj[key];
						}
						result = result.replaceAll("{"+key+"}",_val)
					}
					if(me.options.viewItem > 1){
						if(i%me.options.viewItem == 0){
							itemHtml.push(["<div>"])
						}
						itemHtml.push(result);

						if(i%me.options.viewItem == (me.options.viewItem-1)){
							var hitNews = [];

							//getHitNews_ajax
							var cn = n*me.options.viewItem2;
							hitNews.push(['<ul>']);
							for(var q=cn; q < cn+me.options.viewItem2; q++){
								var obj2 = data2[tabType].hitNewsLinks[q],
									result2 = me.options.templete2,
									_val2 = '';

								for (var key2 in obj2){
									_val2 = obj2[key2];
									result2 = result2.replaceAll("{"+key2+"}",_val2)
									
								}
								hitNews.push(result2);
							}
							hitNews.push(['</ul>']);
							itemHtml.push(hitNews.join(''))
							itemHtml.push(["</div>"]);
							n++;
						}
					}else{ itemHtml.push(result);}
					wrapHtml.push(itemHtml.join(''));
				}

				me.$items.parent().html(wrapHtml.join('')); //트리구조에 적용
				me.$items = me.$el.find(me.options.selectors.items);
				me.$paging.html('<em>1</em>/'+me.$items.length); //페이징 초기화
			})
		},
		events : {
			'click .news-ctab>li>a' : function(e){
				e.preventDefault();
				var me = this,
					_ank = $(e.currentTarget),
					idx = _ank.parent().index();
				
				me.options.itemLoad(me, me.ajaxData, idx);
				_ank.parent().addClass('selected').siblings().removeClass('selected');

				me.$items = me.$el.find(me.options.selectors.items);
				me.$paging.html('<em>1</em>/'+me.$items.length); //페이징 초기화
				me.$el.css('visibility','');
				me.bind(); //prev, next, indicators 기능 적용
			}
			/* 기존사이트 마우스 오버기능 있으나, 이미지 사이즈가 달라 디자인 필요 */
		}
	})

	/*	@오늘의 키워드
		
	*/
	$('.today-keywords').slideMenu({
		viewMenu : 6,
		loadUrl : "/common/js/ajax/getIngiKeyword.json",
		templete : '<li><a href="{linkValue}">{linkName}</a></li>',
		selectors: {
			items : '.keywords-menu li'
		},
		itemLoad : function(me, data, type){
			var wrapHtml = [];

			for(var i=0; i< data.keywordLinks.length; i++){//10
				var obj = data.keywordLinks[i];
				var result = me.options.templete;
				var itemHtml = [];
				var _val = '';
				
				for (var key in obj){
					_val = obj[key];
					result = result.replaceAll("{"+key+"}",_val)
				}
				itemHtml.push(result);
				wrapHtml.push(itemHtml.join(''));
			}
			me.$items.parent().html(wrapHtml.join('')); //트리구조에 적용
		},
		events : {
			'mouseenter .keywords-menu>div>ul>li>a' : function(e){
				e.preventDefault();
				var me = this;
				var _ank = $(e.currentTarget);
				_ank.parent().addClass('selected').siblings().removeClass('selected');
			}
		}
	})

	/* @ 체험단 
		desc 데이터가 기존사이트에는 없음
	*/
	$('.box-experience').SlideFx({
		viewItem : 3,
		loadUrl : "/common/js/ajax/getEventList_ajax.json",
		templete : '<li><span class="img"><a href="{linkUrl}"><img src="{imageUrl}" alt="{title}"/></a></span><span class="txt"><a href="{linkUrl}"><strong>{title}</strong><em>{desc}</em><span>모집인원 : {memNum}명 <em>({memNum}명 지원)</em></span><span>마감일 : {endDay}</span></a></span></li>', //{}안의 내용은 ajax 데이터의 동일한 key의 값으로 replace됨
		selectors : {
			items : '.viewport > ul > li'
		},
		itemLoad : function(me, data){
			/* 컨텐츠별로 마크업 구조가 다를수 있기 때문에 ajax로드 데이타를 이용해 트리구조 변경은 호출 함수별로 설정 필요 */
			var imgPath = "http://img.enuri.gscdn.com/2014/main/images/";
			var wrapHtml = [];

			for(var i=0; i< data.eventListLinks.length; i++){//10
				var obj = data.eventListLinks[i];
				var result = me.options.templete;
				var itemHtml = [];
				var _val = '';
				
				/*	viewItem의 갯수마다 데이터를 분리하여 아래의 트리구조를 만드는 과정 
					li > ul > li
				*/
				for (var key in obj){
					_val = obj[key];
					if(key.indexOf('image') != -1){
						_val = imgPath + obj[key];
					}
					result = result.replaceAll("{"+key+"}",_val)
				}
				if(me.options.viewItem > 1){
					if(i%me.options.viewItem == 0){
						itemHtml.push(["<li><ul>"])
					}
					itemHtml.push(result);
					
					if(i%me.options.viewItem == (me.options.viewItem-1)){
						itemHtml.push(["</ul></li>"]);
					}
				}else{ itemHtml.push(result);}
				wrapHtml.push(itemHtml.join(''));
			}
			me.$items.parent().html(wrapHtml.join('')); //트리구조에 적용
		}
	})

	/* @ 신차비교
		탭별로 아이템이 4개씩만 전달되고있음.
	*/
	$('.box-compare').SlideFx({
		viewItem : 4,
		loadUrl : "/common/js/ajax/getAutoList_ajax.js",
		templete : '<li><strong><a href="{link}"><img src="{normalImg}" oversrc="{bigImg}" alt="{title}"/></a></strong><a href="{link}"><em>{addInfo}</em><br>{title}</a></li>', //{}안의 내용은 ajax 데이터의 동일한 key의 값으로 replace됨
		selectors : {
			items : '> ul > li'
		},
		itemLoad : function(me, data, type){
			/* 컨텐츠별로 마크업 구조가 다를수 있기 때문에 ajax로드 데이타를 이용해 트리구조 변경은 호출 함수별로 설정 필요 */
			var wrapHtml = [],
				data = me.ajaxData || data;

			var tabType = type || 0;
			for(var i=0; i < data[tabType].autoMainLists.length; i++){
				var obj = data[tabType].autoMainLists[i],
					result = me.options.templete,
					itemHtml = [],
					_val = '';

				for (var key in obj){
					_val = obj[key];
					result = result.replaceAll("{"+key+"}",_val)
				}
				if(me.options.viewItem > 1){
					if(i%me.options.viewItem == 0){
						itemHtml.push(["<li><ul>"])
					}
					itemHtml.push(result);
					
					if(i%me.options.viewItem == (me.options.viewItem-1)){
						itemHtml.push(["</ul></li>"]);
					}
				}else{ itemHtml.push(result);}
				wrapHtml.push(itemHtml.join(''));
			}
			me.$items.parent().html(wrapHtml.join('')); //트리구조에 적용
		},
		events : {
			'click >div>ul>li>a' : function(e){
				e.preventDefault();
				var me = this;
				var _ank = $(e.currentTarget);
				var idx = parseInt(_ank.parent().attr('_idx'));
				me.$el.find('>div>ul>li').removeClass('selected');
				_ank.parent().addClass('selected');
				me.options.itemLoad(me, me.ajaxData, idx-1);

				me.$items = me.$el.find(me.options.selectors.items);
				me.$paging.html('<em>1</em>/'+me.$items.length); //페이징 초기화
				me.$el.css('visibility','');
				me.bind(); //prev, next, indicators 기능 적용
			}
			/* 기존사이트 마우스 오버기능 있으나, 이미지 사이즈가 달라 디자인 필요 */
		}
	})
	/* @ 긴급 모객
		이미지 사이즈 관련 기획 의견 필요
	*/
	$('.box-travel').SlideFx({
		viewItem : 1, //indicator num
		loadUrl : "/common/js/ajax/getRightTabShopList_ajax.json",
		//indicators : true, 
		templete : '<li><strong><a href="{linkValue}"><img src="{normalImg}" alt="{linkName}"/></a></strong><p><strong><a href="{linkValue}">{linkName}</a></strong><span>{date}<br/><em>{price}</em></span></p></li>', //{}안의 내용은 ajax 데이터의 동일한 key의 값으로 replace됨
		itemLoad : function(me, data){
			var wrapHtml = [];

			for(var i=0; i < data[1].section4RightList.length; i++){
				var obj = data[1].section4RightList[i],
					result = me.options.templete,
					itemHtml = [],
					_val = '';
				for (var key in obj){
					_val = obj[key];
					result = result.replaceAll("{"+key+"}",_val)
				}
				if(me.options.viewItem > 1){
					if(i%me.options.viewItem == 0){
						itemHtml.push(["<li><ul>"])
					}
					itemHtml.push(result);
					
					if(i%me.options.viewItem == (me.options.viewItem-1)){
						itemHtml.push(["</ul></li>"]);
					}
				}else{ itemHtml.push(result);}
				wrapHtml.push(itemHtml.join(''));
			}
			me.$items.parent().html(wrapHtml.join('')); //트리구조에 적용
		},
		selectors : {
			items : '.viewport > ul > li'
		},
		events : {
			'mouseenter .indicators>li>a':function(e){
				e.preventDefault();
				var me = this;
				var _ank = $(e.currentTarget);
				var idx = _ank.parent().index();
				_ank.parent().addClass('selected').siblings().removeClass('selected');
				me.$el.find(me.options.selectors.items + '.on').find('li').eq(idx).show().siblings().hide();
			}
		}
	})
})
