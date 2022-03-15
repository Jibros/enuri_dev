jQuery(document).ready(function($){
/**
	$('.depth2Pr > a').bind('mouseenter focusin', function(){
		stopGnbBannerRoll();
	});
	$('.depth2Pr > a').bind('mouseleave', function(){
		gnbBannerRotation();
	});
**/
	$('.depth2Pr > a').click(function(){
		var _this = $(this);
		var _href = _this.attr("href");
		var _linktype = _this.attr("linktype");
		var _source = _this.attr("source");
		var _no = _this.attr("no");
		/**
		console.log("href:"+_href);
		console.log("linktype:"+_linktype);
		console.log("source:"+_source);
		console.log("no:"+_no);
		**/
		if(_source==1){
			_this.attr("href","/move/Redirectad.jsp?register_no="+_no+"&pageNm=gnb");
		}
		if(_linktype==1){
			_this.attr("target","_new");
		}else if(_linktype==2){
			_this.attr("target","_self");
		}else{
			_this.attr("target","");
			window.detailWin = window.open(_href,"detailMultiWin","width=804,height="+window.screen.height+",left=0,top=0,toolbar=no,directories=no,status=no,scrollbars=yes,resizable=yes,menubar=no");
  			window.detailWin.focus();
  			return false;
		}
	});
});

	var gnb_banner_img_hash = new Array();
	var gnb_banner_linktype_hash = new Array();
	var gnb_banner_link_hash = new Array();
	var gnb_banner_source_hash = new Array();
	var gnb_banner_no_hash = new Array();

	var thisimg = 1;
	var maximg = 1;

	var gnb_banner_timer;
	var gnb_banner_this = 1;
	var gnb_banner_max = 1;
	var this_img = null;
	var this_a = null;
	var this_img_arr = null;
	var this_linktype_arr = null;
	var this_link_arr = null;
	var this_source_arr = null;
	var this_no_arr = null;

	function setGnbBannerRoll(seq){
		/**
		clearTimeout(gnb_banner_timer);

		this_img = $("#gnb_banner_"+seq);
		this_a = this_img.parent();
		this_img_arr = gnb_banner_img_hash['b'+seq];
		this_linktype_arr = gnb_banner_linktype_hash['b'+seq];
		this_link_arr = gnb_banner_link_hash['b'+seq];
		this_source_arr = gnb_banner_source_hash['b'+seq];
		this_no_arr = gnb_banner_no_hash['b'+seq];

		if(this_img_arr && this_img_arr.length>1){
			gnb_banner_this = 1;
			gnb_banner_max = this_img_arr.length;
			gnb_banner_timer = setTimeout(gnbBannerRotation, 3000);
			//console.log("start banner rolling");
			//console.log(this_img_arr);
		}
		**/
	}
	function stopGnbBannerRoll(seq){
		//console.log("stop banner rolling");
		//clearTimeout(gnb_banner_timer);
	}
	function getnextimg(ix){
		//if(ix+1>gnb_banner_max) return 1;
		//return ix+1;
	}

	function gnbBannerRotation(){
		//console.log(gnb_banner_this);
		/**
		clearTimeout(gnb_banner_timer);
		var nextimg = getnextimg(gnb_banner_this);
		this_img.fadeOut('slow', function(){

			this_img.attr("src", this_img_arr[nextimg-1]);
			this_a.attr("href", this_link_arr[nextimg-1]);
			this_a.attr("linktype", this_linktype_arr[nextimg-1]);

			this_img.fadeIn('slow', function(){
				gnb_banner_this = nextimg;
				gnb_banner_timer = setTimeout(gnbBannerRotation, 3000);
			});
		});
		**/
	}

