var vNews_no_now = "01";
var vHash = window.location.hash;

$(function() {

    $("body").on('touchend', function(e) {
        if (window.android && android.onTouchEnd) {
            window.android.onTouchEnd();
        } else if ($("#ios").val()) {

        }
    });
	vHash = window.location.hash;
	$(".cate_new > li").click(function(){
		var vThis = $(this).attr("cate");

		$(".newscate_btt").removeClass("on");
		$(this).addClass("on");
		vNews_no_now = $(this).attr("cate");

		$(".hotnews").hide();
		$("#newscate_"+vNews_no_now).show();
	});

	$("#news_all").click(function(){
		fnGa('mf_쇼핑뉴스','click_cate','cate_전체보기');
		show_detail("/mobilefirst/renew/shoppingNews_all.jsp?tipno="+vNews_no_now);
	});
	//getList();
	$(".cate_new > li").click(function(e){
		fnGa("mf_쇼핑뉴스","click_cate","cate_"+ e.currentTarget.innerText);
	});
});
function fnGa(pCate,pAction,pLabel){
	ga('send', 'event', pCate, pAction, pLabel);
}
function getList(){
	var news_bottom_body = $("#news_bottom_body").children().html();

	if(news_bottom_body){
		return false;
	}

	$.ajax({
		type: "POST",
		dataType:"json",
		url: "/mobilefirst/api/main/newNewsTab.json",
		success: function(json_list){
			var newsTab_top = json_list.newsTab_top;
			var newsTab_bottom = json_list.newsTab_bottom;
			var category_tip = json_list.category_tip;
			var today_hop_clip = json_list.today_hop_clip;

		    var template = "";

		    if(newsTab_top){
		    	newsTab_top = shuffle(newsTab_top);
		        var vTopimg = setImg(newsTab_top[0].mo_img,newsTab_top[0].mo_img2,newsTab_top[0].rss_thumbnail);

		        if(vTopimg){
		      		template += "<img class=\"lazy\" src=\""+ vTopimg +"\" data-original=\"\" alt=\"\" />";
		           	template += "<span class=\"tit\"><em>"+ newsTab_top[0].name +"</em></span>";

		            $("#news_top").html(template);
		            $("#news_top").click(function(){
		            	fnGa("mf_쇼핑뉴스","click_main_news","news_상단배너_"+ newsTab_top[0].kbno);
		            	show_detail(newsTab_top[0].url);
		            });
		        }else{
		        	$("#news_top").hide();
		        }
		    }else{
		    	$("#news_top").hide();
		    }
		    template = "";

		    if(newsTab_bottom.length>3){
		    	newsTab_bottom = shuffle(newsTab_bottom);
		        for(var i=0;i<3;i++){
		            template += "<li onclick=\"fnGa('mf_쇼핑뉴스','click_main_news','news_하단배너2_"+ newsTab_bottom[i].kbno +"');show_detail('"+newsTab_bottom[i].url+"');\">";
		            template += "	<a href=\"javascript:///\">";
		            template += "		<img class=\"lazy\" src=\""+ newsTab_bottom[i].rss_thumbnail +"\" data-original=\"\" alt=\"\" />";

		            template += "		<strong>"+ newsTab_bottom[i].name +"</strong>";
		            var regDate = newsTab_bottom[i].kb_regdate.substring(0,10);
		            template += "		<span class='date'>"+newsTab_bottom[i].source+" "+regDate+"</span>";
		            template += "	</a>";
		            template += "</li>";
		        }
		        $("#news_bottom_body").html(template);
		    }else{
		    	$("#news_bottom").hide();
		    	$("#news_bottom_body").html(null);
		    }

		    template = "";

		    var json_list = category_tip;

		    if(json_list.length > 0){
		        for(var i = 0;i<json_list.length;i++){
		            var vCategory_name = json_list[i].category_name;
		            var vTip_no = json_list[i].tip_no;
					var vList = json_list[i].list;

					if(vList.length > 0){
						for(var j=0;j<vList.length;j++){
							var vTmpImg = setImg(vList[j].mo_img,vList[j].mo_img2,vList[j].rss_thumbnail);

							template += "<li class=\"tiplist tip_"+ vTip_no +"\" onclick=\"fnGa('mf_쇼핑뉴스','click_cate','news_"+ vCategory_name +"_" + vList[j].kbno +"'); show_detail('"+ vList[j].url +"');\">";
							if(vTmpImg != ""){
								//template += "<span class=\"thum\"><img class=\"lazy\" src=\"http://imgenuri.enuri.gscdn.com/images/m_home/noimg.png\" data-original=\""+ vTmpImg +"\" alt=\"\" /></span>";
								if(vTmpImg.indexOf("http://imgenuri.enuri.gscdn.com/images/m_home/noimg.png") > -1 ){

								}else{
									template += "<span class=\"thum\"><img class=\"\" src=\""+ vTmpImg +"\" alt=\"\" /></span>";
								}

							}
							template += "<strong>"+ vList[j].name +"</strong>";
							template += setMmdd(vList[j].kb_regdate.substring(5,10));
							if(vList[j].source != ""){
								template += " | "+ vList[j].source;
							}
							template += "</li>";
						}
					}
					if(template != ""){
						$("#newscate_"+vTip_no).html(template);
						template = "";
					}
		        }
		        $("#newscate_head_"+vNews_no_now).addClass("on");
		        $("#newscate_"+vNews_no_now).show();
		    }

		    /* TODAY 투데이 HOT CLIP */
		    if (today_hop_clip) {
		    	var html = [];

		    	$.each(today_hop_clip, function(i, v) {
			    	var thumbnail_img = "";
		        	if (v.mo_img) {
		        		thumbnail_img = v.mo_img;
		        	} else if (v.rss_thumbnail) {
	                	thumbnail_img = v.rss_thumbnail;
	                } else if (v.kb_thumbnail_img) {
	                	thumbnail_img = v.kb_thumbnail_img;
		        	} else if (v.mo_img2) {
		        		thumbnail_img = v.mo_img2;
		        	} else if (v.kb_thumbnail) {
		        		thumbnail_img = v.kb_thumbnail;
		        	} else {
		        		thumbnail_img = "http://img.enuri.gscdn.com/images/sns_knowcom_basic_last2.png";
		        	}

		        	var makeHtml = "";
					makeHtml += "<li class=\"swiper-slide\">";
					makeHtml += "	<div class=\"hotclip_item\" onclick=\"insertLog(19101)\">";
					makeHtml += "		<a href=\"javascript:;\" onclick=\"location.href='/knowcom/detail.jsp?kbno="+v.kb_no+"&bbsname=news'\" class=\"g_thumb\"><img src=\""+thumbnail_img+"\" alt=\"이미지\" onerror=\"this.src='http://imgenuri.enuri.gscdn.com/images/home/thum_none.jpg'\" /></a>";
					makeHtml += "		<div class=\"g_detail\">";
					makeHtml += "			<a href=\"javascript:;\" onclick=\"location.href='/knowcom/detail.jsp?kbno="+v.kb_no+"&bbsname=news'\" class=\"g_tit\">"+v.kb_title+"</a>";
					makeHtml += "		</div>";
					makeHtml += "	</div>";
					makeHtml += "</li>";

		        	if (v.kk_code == "26") {
		        		html[1]==null?html[1]=makeHtml:html[4]=makeHtml;
		        	} else if (v.kk_code == "27") {
		        		html[0]==null?html[0]=makeHtml:html[3]=makeHtml;
		        	} else {
		        		html[2]==null?html[2]=makeHtml:html[5]=makeHtml;
		        	}
		    	});
		    	$('#swiperHotclip .swiper-wrapper.hotclip_list').append(html.join(""));	// 스포츠 > 연예 > 코스프레 순
		    } else {
		    	$('#swiperHotclip .swiper-wrapper.hotclip_list').closest('.newsbox').hide();
		    }
		    /* TODAY 투데이 HOT CLIP */
		}, complete : function (data){
			// 동적인 이미지 호출
		    $("img.lazy").lazyload({
		        effect: 'fadeIn',
		        effectTime : 300
		    });
		    setDelay();

		    // 쇼핑뉴스 투데이 HOP CLIP Swiper
			var swiper = new Swiper('#swiperHotclip', {
				freeMode: true,
				slidesPerView: 'auto',
				spaceBetween: 10,
				freeMode: true,
				pagination: false
			});
		}
	});
}