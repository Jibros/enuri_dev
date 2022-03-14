$(function(){
	$('#footer').css('margin-top',0);
	IEFlag = get_version_of_IE();
	main.init();
	visual.init();
	$('#container').addClass('start');
});

$(window).resize(function(){
	SW	=	$(window).width();
	SH	=	$(window).height();
	main.resize();
	visual.resize();
});



var main = {
	cur:0,
	prev:-1,
	target:null,
	init:function(){
		main.target = $('#mainData');		
		main.resetScale();
	},
	resize:function(){
		main.resetScale();	
	},
	resetScale:function(){
		var _topHeight = $('#header').innerHeight();
		var _bottomHeight = $('#footer').innerHeight();
		var _h = (SW > 640)?SH - _topHeight - _bottomHeight:SH-_topHeight;
		main.target.height(_h);
		main.target.find('> div').height(_h);
		main.target.find('> div > div').height(_h);
	}
}

var visual = {
	cur:0,
	prev:-1,
	len:0,
	flag:false,
	dir:0,
	DH:0,
	target:null,
	first:true,
	timer:null,
	speed:5000,
	init:function(){
		visual.target = $('#mainData');				
		visual.DH = visual.target.innerHeight();
		visual.len = visual.target.find('.content > div').length;
		
		main.target.on('mousewheel DOMMouseScroll', function (e) {
			if(AgentFlag){
				var delta = e.originalEvent.wheelDelta || e.originalEvent.deltaY || e.originalEvent.detail*-1;
				if(IEFlag){
					delta = delta;
				}

				if(!visual.flag){
					visual.prev = visual.cur;
					if (delta > 0) {
						//up
						visual.cur = (visual.cur == 0)?visual.len-1:visual.cur=visual.cur-1;
						visual.dir = 0;
					}else{
						//down
						visual.cur = (visual.cur >= visual.len-1)?0:visual.cur = visual.cur+1;
						visual.dir = 1;
						
					}
					visual.start();
					visual.flag = true;	

				}
			}
		});

		if(!AgentFlag){
			main.target.swipe(function(direction){
				if(!visual.flag){
					if(direction == "down"){
						visual.prev = visual.cur;
						visual.cur = (visual.cur == 0)?visual.len-1:visual.cur=visual.cur-1;
						visual.dir = 0;
						visual.start();
						visual.flag = true;	
					}else if(direction == "up"){
						visual.prev = visual.cur;
						visual.cur = (visual.cur >= visual.len-1)?0:visual.cur = visual.cur+1;
						visual.dir = 1;
						visual.start();
						visual.flag = true;	
						
					}


				}			
			},
			{
				preventDefault: false,
				mouse: true,
				pen: true,
				distance: 50
			});

		}
		
		visual.target.find('.btn_arrow a').click(function(){
			if(!visual.flag){
				visual.prev = visual.cur;
				visual.cur = (visual.cur >= visual.len-1)?0:visual.cur = visual.cur+1;
				visual.dir = 1;
				visual.start();
				visual.flag = true;	
			}
		});

		visual.target.find('.nav a').click(function(){
			if(!visual.flag){

				if($(this).parent().index() != visual.cur){
					visual.prev = visual.cur;
					visual.cur = $(this).parent().index();				
					visual.dir = (( visual.cur - visual.prev) < 0)?0:1;
					visual.start();	
					visual.flag = true;
				}
			}
		});

		visual.target.find('.e_wrap').each(function(){
			TweenMax.set($(this),{y:70,alpha:0});
		});
		//visual.timer = setInterval(visual.autoTimer,visual.speed);
		visual.start();
	},
	start:function(){
		
		var _dx = (visual.dir == 0)?visual.DH*-1:visual.DH;
		visual.target.find('.content > div').each(function(){
			if($(this).index() == visual.cur){
				if(!visual.first){
					if(SW > 640){
						$(this).stop(true).css({'top':_dx}).animate({'top':0},1800,'easeInOutExpo',function(){visual.flag = false});

						var _dy = (visual.dir == 0)?-70:70;
						var _i = 0;
						$(this).find('.e_wrap').each(function(){
							var _delay = (0.3*_i)+0.9;
							TweenMax.set($(this),{y:_dy});
							TweenMax.to($(this),0.6,{y:0,alpha:1,delay:_delay,ease:Quad.easeOut});
							_i++;
						});
					}else{
						$(this).stop(true).css({'top':_dx}).animate({'top':0},1800,'easeInOutExpo',function(){visual.flag = false});					
						visual.target.find('.e_wrap').each(function(){
							TweenMax.set($(this),{y:0,alpha:1});
						});
					}
				}else{
					if(SW > 640){
						$(this).stop(true).css({'top':0})						
						var _i = 0;
						$(this).find('.e_wrap').each(function(){
							var _delay = 0.3*_i;
							TweenMax.to($(this),0.6,{y:0,alpha:1,delay:_delay,ease:Quad.easeOut});
							_i++;
						});
					}else{
						$(this).stop(true).css({'top':0})
						visual.target.find('.e_wrap').each(function(){
							TweenMax.set($(this),{y:0,alpha:1});
						});
					}
				}
			}else if($(this).index() == visual.prev){
				if(SW > 640){
					$(this).stop(true).animate({'top':_dx*-1},1800,'easeInOutExpo');
					var _dy = (visual.dir == 0)?70:-70;
					var _k = 0;
					$(this).find('.e_wrap').each(function(){
						var _delay = (0.1*_k)+0.3;	
						TweenMax.to($(this),0.6,{y:_dy,alpha:0,delay:_delay,ease:Quad.easeOut});
						_k++;
					});
				}else{
					$(this).stop(true).animate({'top':_dx*-1},1800,'easeInOutExpo');
					visual.target.find('.e_wrap').each(function(){
						TweenMax.set($(this),{y:0,alpha:1});
					});
				}
			}else{
				if(SW > 640){
					$(this).stop(true).css({'top':_dx});
					$(this).find('.e_wrap').each(function(){
						TweenMax.set($(this),{y:-70,alpha:0});
					});
				}else{
					$(this).stop(true).css({'top':_dx});
					visual.target.find('.e_wrap').each(function(){
						TweenMax.set($(this),{y:0,alpha:1});
					});
				}
			}
		});		
		visual.target.find('.area > ul > li').eq(visual.cur).addClass('actived').siblings().removeClass('actived');
		visual.first = false;
	},
	resize:function(){
		visual.DH = visual.target.innerHeight();
		visual.target.find('.content > div').each(function(){
			if($(this).index() == visual.cur){	
				if(SW > 640){
					$(this).stop(true).css({'top':0})
				}else{
					$(this).stop(true).css({'top':0})
				}
			}else{
				if(SW > 640){
					$(this).stop(true).css({'top':visual.DH})
				}else{
					$(this).stop(true).css({'top':visual.DH})
				}
			}
		});

		//clearInterval(visual.timer);
		//visual.timer = setInterval(visual.autoTimer,visual.speed);
	},
	autoTimer:function(){
		visual.flag = true;	
		visual.prev = visual.cur;
		visual.cur = (visual.cur >= visual.len-1)?0:visual.cur = visual.cur+1;
		visual.dir = 1;
		visual.start();
	}
	
}



function get_version_of_IE () { 

	 var word; 
	 var version = "N/A"; 
	 var flag = false;

	 var agent = navigator.userAgent.toLowerCase(); 
	 var name = navigator.appName; 

	 // IE old version ( IE 10 or Lower ) 
	 if ( name == "Microsoft Internet Explorer" ) word = "msie ",flag = true; 

	 else { 
		 // IE 11 
		 if ( agent.search("trident") > -1 ) word = "trident/.*rv:",flag = true; 

		 // Microsoft Edge  
		 else if ( agent.search("edge/") > -1 ) word = "edge/",flag = true; 
	 } 

	 var reg = new RegExp( word + "([0-9]{1,})(\\.{0,}[0-9]{0,1})" ); 

	 if (  reg.exec( agent ) != null  ) version = RegExp.$1 + RegExp.$2; 

	 return flag; 
} 