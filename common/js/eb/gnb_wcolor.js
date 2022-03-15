function setChangeGnb(){
	var $menuList = jQuery("#gnbMenu > li");

	$menuList.each(function(idx){
		$this = jQuery(this);

		if($menuList.length-1 != idx)
			$this.find("a > img").attr("src","http://img.enuri.info/2015/gnb_event/gnb_menu0" + (idx+1) + ".gif")
			.parent().mouseenter(function(){
				$this = $(this).find("img");
				if($this.attr("src").indexOf("_on")<0) $this.attr("src",$this.attr("src").replace(".gif","_on.gif"));
			})
			.mouseleave(function(){
				$this = jQuery(this).find("img");
				$this.attr("src",$this.attr("src").replace("_on.gif",".gif"));
			});
		else
			$this.find("a > img").attr("src","http://img.enuri.info/2015/gnb_event/gnb_allmenu.gif");
	});

	$(".num.num1 > div.r_graph > .graph_comm > li > .g_term > span").click(function(){
		$(".num.num1 > div.r_graph > .graph_comm > li").each(function(){
			$this = $(this).find(".g_term > span > img")
			$this.attr("src",$this.attr("src").replace("chk_on.png","chk.png"));
		});

		$(this).find("img").attr("src",$(this).find("img").attr("src").replace("chk.png","chk_on.png"));
	});

	$(".num.num2 > div.r_graph > .graph_comm > li > .g_term > span").click(function(){
		$(".num.num2 > div.r_graph > .graph_comm > li").each(function(){
			$this = $(this).find(".g_term > span > img")
			$this.attr("src",$this.attr("src").replace("chk_on.png","chk.png"));
		});

		$(this).find("img").attr("src",$(this).find("img").attr("src").replace("chk.png","chk_on.png"));
	});

	setTimeout(function(){
		loadGnbAllMenu2 = loadGnbAllMenu;

		loadGnbAllMenu = function(idx){
			loadGnbAllMenu2(idx);

			setTimeout(function(){
				$allMenuLi = $("#allMenu > ul > li");

				$allMenuLi.each(function(idx){
					$this = $(this).find("a > img");

					if(idx!=$allMenuLi.length-1){
						$this.attr("src",$this.attr("src").replace("2014/gnb/gnb_menu0" + (idx+1) + ".png","2015/gnb_event/gnb_menu0" + (idx+1) + ".gif"));

						$this2 = $(this).find(">a");

						$this2.mouseenter(function(){
							$this = $(this).find("img");

							$this.attr("src",$this.attr("src").replace(".gif","_on.gif"));
						}).mouseleave(function(){
							$this = $(this).find("img");

							$this.attr("src",$this.attr("src").replace("_on.gif",".gif"));
						});
					}else
						$this.attr("src",$this.attr("src").replace("/2014/gnb/gnb_allmenu.png","/2015/gnb_event/gnb_allmenu.gif"));
				});
			},300);
		}

	},500);
}
$(document).ready(function(){
	try{
		setChangeGnb();
	}catch(e){};
});