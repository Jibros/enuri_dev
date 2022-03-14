$(function(){
function moving(){
	function swing(){
		$(".txt_box .top .swing p").toggleClass("animated swing")
	}
	function moving_top(){
		var n = 150;
		var element = $(".txt_box .top p");
		var easing = "swing";

		element.each(function(i){
			$(this).animate({"opacity":"1"},500,easing,function(){
				if(element.size() == i+1){
					/*
					$(".txt_box .top .swing p").effect("puff",1000,function(){
						$(this).effect("bounce",300,function(){
							
						})
					});
					*/
					moving_fade();
					setInterval(swing,3000)
					return false;
				}
			});
		});
	};
	setTimeout(moving_top,500);
	
	
	function moving_slide(){
		var n = 1800;
		//var easing = "easeInOutBack";
		//var easing = "easeOutElastic";
		var easing = "swing";
		var element = $(".moving_wrap p");
		element.each(function(i){
			$(this).delay(i*n).animate({"left":"0%"},300,easing,
				function(){
					$(this).delay(1200).animate({"left":"-100%"},300,easing,function(){
						$(this).css({"left":"100%"});
						if(element.size() == i+1){
							moving_slide();
							return false;
						}
					});
				}
			);
		});
	}
	//setTimeout(moving_slide,3200);

	function moving_fade(){
		var n = 2200;
		//var easing = "easeInOutBack";
		//var easing = "easeOutElastic";
		var easing = "swing";
		var element = $(".moving_wrap p");
		element.css({"left":"0%","opacity":"0"});
		element.each(function(i){
			$(this).delay(i*n).animate({"opacity":"1"},500,easing,
				function(){
					//console.log("i : "+i+", size : "+element.size())
					if(i < element.size() - 1){
						$(this).delay(1200).animate({"opacity":"0"},500,easing,function(){
							$(this).css({"left":"0%"});
						});
					}else{
						//console.log("last")
					}
				}
			);
		});
	}
	//setTimeout(moving_fade,2800);

	function moving_fade_right(){
		var num = 80; //쪼갤 갯수...
		var n = 1800;
		//var easing = "easeInOutBack";
		//var easing = "easeOutElastic";
		var easing = "swing";
		var element = $(".moving_wrap p");
		element.css({"left":"0%","opacity":"1"});
		
		//console.log(element.css("background-image"))
		
		element.each(function(e){
			var wd = $(this).width();
			var bg = $(this).css("background-image");
			$(this).css("background-image","none");
			for(var i = 1; i <= num; i++){
				$(this).append("<span class='bg"+i+"'></span>");
				$(this).find(".bg"+i).css({
					"opacity":0,
					"width":(wd/num),
					"background-image":bg,
					"background-position-x":-(wd/num) * (i-1) +"px"
				})
			};

			
		});
			//element.eq(e).show();
				var size = element.find("span").size();
				var cnt = 1;
				element.find("span").each(function(s){
					$(this).delay(s * 40).animate({"opacity":"1"},500,easing,function(){
						element.find("span").animate({"opacity":"0"},2000)
						//console.log(cnt)
						cnt++
					})
				})
		
		/*
		element.each(function(i){
			$(this).delay(i*n).animate({"opacity":"1"},500,easing,
				function(){
					$(this).delay(1200).animate({"opacity":"0"},500,easing,function(){
						$(this).css({"left":"0%"});
						if(element.size() == i+1){
							moving_fade_right();
							return false;
						}
					});
				}
			);
		});
		*/
	}
	//setInterval(moving_fade_right,10000);

	/*
	function moving_txt(){
		var n = 1800;
		//var easing = "easeInOutBack";
		//var easing = "easeOutElastic";
		var easing = "swing";
		var element = $(".moving_wrap p");
		element.each(function(i){
			$(this).delay(i*n).animate({"left":"0%"},300,easing,
				function(){
					$(this).delay(1200).animate({"left":"-100%"},300,easing,function(){
						$(this).css({"left":"100%"});
						if(element.size() == i+1){
							//moving_txt();
							return false;
						}
					});
				}
			);
		});
	}
	setTimeout(moving_txt,1500);
	*/

};moving();
/*
function inter(){
	var down = "24.52%";
	var up = "28.52%";
	$(".txt3").delay(1000).animate({height:down},50,"swing",
		function(){
			$(this).animate({height:up},50,"swing");
		}
	)

	$(".txt4").delay(1100).animate({height:down},50,"swing",
		function(){
			$(this).animate({height:up},50,"swing");
		}
	);

	$(".txt5").delay(1200).animate({height:down},50,"swing",
		function(){
			$(this).animate({height:up},50,"swing");
		}
	);
}
var start = setInterval(inter,3000);
*/

})