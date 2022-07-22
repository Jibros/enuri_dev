
function fnGa(pCate,pAction,pLabel){
	ga('send', 'event', pCate, pAction, pLabel);	
}
//쇼핑팁의 상단이미지만 우선순위 다르게 적용
function setImg_shoptip_todayTiptop(mo_img,mo_img2,rss_thumbnail){
	var vRtn_img = "";
	
	if(mo_img2 != ""){
		vRtn_img = mo_img2;
	}else if(mo_img != ""){
		vRtn_img = mo_img;
	}else if(rss_thumbnail != ""){
		vRtn_img = rss_thumbnail;
	}

	if(vRtn_img != ""){
		return vRtn_img;
	}else{
		return "http://imgenuri.enuri.gscdn.com/images/m_home/noimg.png";
	}
}
function setImg(mo_img,mo_img2,rss_thumbnail){
	var vRtn_img = "";
	/*if(movie_id != "" && typeof movie_id  != "undefined"){
		vRtn_img = movie_id;
	}*/
	if(mo_img != "" && typeof mo_img  != "undefined"){
		vRtn_img = mo_img;
	}else if(mo_img2 != ""){
		vRtn_img = mo_img2;
	}
	else if(rss_thumbnail != ""){
		vRtn_img = rss_thumbnail;
	}

	if(vRtn_img != ""){
		return vRtn_img;
	}else{
		return "http://imgenuri.enuri.gscdn.com/images/m_home/noimg.png";
	}
}
function getTips(){
	
	var weekly_push = $("#weekly_push").children().html();
	
	if(weekly_push){
		return false;
	}
	
	$.ajax({  
		type: "POST",
		dataType:"json",
		url: "/mobilefirst/api/main/shoptipTab.json",   
		success: function(json_list){
			var todaytip_top = json_list.todayTip_top;
			var category_tip = json_list.category_tip;
			var weekly_push = json_list.weekly_push;
		    var template = "";
		    var idx=0;
		    
		    if(todaytip_top){
		    	idx = Math.floor(Math.random() * todaytip_top.length);
		        var vTopimg = setImg_shoptip_todayTiptop(todaytip_top[idx].mo_img,todaytip_top[idx].mo_img2,todaytip_top[idx].rss_thumbnail);

		        if(vTopimg){
		      		template += "<img class=\"lazy\" src=\""+ vTopimg +"\" data-original=\"\" alt=\"\" />";
		           	template += "<span class=\"tit\"><em>"+ todaytip_top[idx].name +"</em></span>";
		    		
		            $("#todaytip_top").html(template);
		            $("#todaytip_top").click(function(){
		            	fnGa("mf_쇼핑팁","click_main_tips","tips_상단배너_"+ todaytip_top[idx].kbno);	
		            	show_detail(todaytip_top[idx].url);
		            });
		        }else{
		        	$("#todaytip_top").hide();
		        }
		    }else{
		    	$("#todaytip_top").hide();
		    }

		    template = "";
		    
		    if(weekly_push){
		    	template += "<h3>금주의 <b>추천</b></h3>";
		    	template += "<ul class=\"sp_list\">";
		    	weekly_push = shuffle(weekly_push);
		        for(var i=0;i<4;i++){
		            template += "<li onclick=\"fnGa('mf_쇼핑팁','click_main_tips','tips_하단배너_"+ weekly_push[i].kbno +"');show_detail('"+weekly_push[i].url+"');\">";
		            template += "	<a href=\"javascript:;\">";
		            template += "		<img class=\"lazy\" src=\""+ setImg(weekly_push[i].mo_img,weekly_push[i].mo_img2,weekly_push[i].rss_thumbnail) +"\" data-original=\"\" alt=\"\" />";
		            template += "		<strong>"+ weekly_push[i].name +"</strong>";
		            template += "	</a>";
		            template += "</li>";
		        }
		        template += "</ul>";

		        $("#weekly_push").html(template);
		    }else{
		    	$("#weekly_push").hide();
		    }

		    if(category_tip){

		        for(var i=0;i<category_tip.length;i++){
			    	template = "";
			    	
					template += "<h3 class=\"tip_tit\"><b onclick=\"fnGa('mf_쇼핑팁','click_cate','tips_"+ category_tip[i].category_name +"_전체보기');allview('"+ category_tip[i].tip_no +"');\">"+ category_tip[i].category_name +"</b><em class=\"all\" onclick=\"fnGa('mf_쇼핑팁','click_cate','tips_"+ category_tip[i].category_name +"_전체보기');allview('"+ category_tip[i].tip_no +"');\">전체보기</em></h3>";
					template += "<ul class=\"hotnews\">";

					if(category_tip[i].list.length > 0){
						var category_sub = category_tip[i].list;
						
						for(var j=0;j<category_sub.length;j++){
							
							var vTmp_img = setImg(category_sub[j].mo_img, category_sub[j].mo_img2, category_sub[j].rss_thumbnail);
							
							template += "<li onclick=\"fnGa('mf_쇼핑팁','click_cate','tips_"+ category_tip[i].category_name +"_"+ category_sub[j].kbno +"');show_detail('"+category_sub[j].url+"');\">";
							template += "	<span class=\"thum\"><img class=\"lazy\" src=\"http://imgenuri.enuri.gscdn.com/images/m_home/noimg.png\" data-original='"+ vTmp_img +"' /></span>";
							template += "	<strong>"+ category_sub[j].name +"</strong>";
							//template += "	"+ setMmdd(category_sub[j].kb_regdate.substring(5,10));
							template += "	조회수 "+ commaNum(category_sub[j].kb_readcnt);
							if(category_sub[j].source != ""){
								template += " | "+ category_sub[j].source;
							}
							template += "</li>";
						}
				 	}
					template += "</ul>";

					$("#tip_"+category_tip[i].tip_no).html(template);
		        }
		    }else{
		    	$("#tip_01").hide();
		    	$("#tip_02").hide();
		    	$("#tip_03").hide();
		    	$("#tip_04").hide();
		    	$("#tip_05").hide();
		    }
		}, complete : function (data){
			// 동적인 이미지 호출
		    $("img.lazy").lazyload({
		        effect: 'fadeIn',
		        effectTime : 300
		    });
		    setDelay();
		}
	});
}

function setMmdd(date){
	var mm = date.substring(0,2);
	var dd = date.substring(3,5);

	return parseInt(mm) + "월 " + parseInt(dd) + "일";
}

function allview(no){
	location.href="/mobilefirst/renew/shoppingTips_all.jsp?tipno="+no;
}

function show_detail(url){
	window.open(url);
	//location.href=url;
	return false;
}


