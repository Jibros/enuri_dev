function topmotion(){
		var boxH = $('.evtop01').height()-12;
		//alert(boxH);
		$('#topmotion').css('height', boxH);

		function bg01(){
			$(".all").fadeOut(400);
			$(".summer").delay(200).fadeOut(400);
			$(".sub01").delay(400).fadeOut(400);
			$(".bracket01").delay(200).animate({left:"7.5%"}, 300, "swing");
			$(".bracket02").delay(200).animate({right:"7.5%"}, 300, "swing");
			$(".evtop01").animate({backgroundPosition:"100%"}, 2000, "swing");
			
			$(".title01").delay(400).fadeIn(400);
			$(".sub02").delay(500).fadeIn(400);
		}
		function bg02(){
			$(".evtop01").fadeOut(400,
				function(){
					$(this).css("backgroundPosition","0");
				}
			);
			$(".evtop02").fadeIn(400,
				function(){
					$(this).animate({backgroundPosition:"100%"}, 2000, "swing");
				}
			);
			$(".title01").fadeOut(400);
			$(".title02").delay(400).fadeIn(400);
		}
		function bg03(){
			$(".evtop02").fadeOut(400,
				function(){
					$(this).css("backgroundPosition","0");
				}
			);
			$(".evtop03").fadeIn(400,
				function(){
					$(this).animate({backgroundPosition:"100%"}, 2000, "swing");
				}
			);
			$(".title02").fadeOut(400);
			$(".title03").delay(400).fadeIn(400);
		}
		
		function bg04(){
			$(".evtop03").fadeOut(400,
				function(){
					$(this).css("backgroundPosition","0");
				}
			);
			$(".evtop04").fadeIn(400,
				function(){
					$(this).animate({backgroundPosition:"100%"}, 2000, "swing");
				}
			);
			$(".title03").fadeOut(400);
			$(".title04").delay(400).fadeIn(400);
			/*
			$(".bracket01").delay(200).animate({left:"45%"}, 300, "swing",
				function(){
					$(this).animate({left:"7.5%"}, 300, "swing")
				}
			);
			$(".bracket02").delay(200).animate({right:"45%"}, 300, "swing",
				function(){
					$(this).animate({right:"7.5%"}, 300, "swing")
				}
			);
			*/
		}
		function bg05(){
			$(".evtop04").fadeOut(400,
				function(){
					$(this).css("backgroundPosition","0");
				}
			);
			$(".evtop01").fadeIn(400);
			$(".all").fadeIn(400);
			$(".summer").delay(200).fadeIn(400);
			$(".sub01").delay(400).fadeIn(400);
			$(".sub02").delay(400).fadeOut(400);
			$(".bracket01").delay(200).animate({left:"45.2%"}, 300, "swing");
			$(".bracket02").delay(200).animate({right:"18.7%"}, 300, "swing");
		}
		var bg01 = setTimeout(bg01, 2000);
		var bg02 = setTimeout(bg02, 5000);
		var bg03 = setTimeout(bg03, 8000);
		var bg04 = setTimeout(bg04, 11000);
		var bg05 = setTimeout(bg05, 1000);
	}
	topmotion();
	var topmotion = setInterval(topmotion, 15000);