var bast_list; //특가모음
var hot_list; //핫딜베스트
//특가모음
function getBestlist1(param){
	if(bast_list == null){
		getBestlist(param);
	}
}
//핫딜베스트
function getBaselist1(param){
	if(hot_list == null){
		getBaselist(param);
	}
}
function getBestlist(param){
	
	$(".brand_btt").removeClass("on");
	
	var shop_code = "536";
	var json_url = "/mobilefirst/http/json/bestGmarket.json";
	var shop_name = "";
	if(param == 1){
		shop_code = "536";
		json_url = "/mobilefirst/http/json/bestGmarket.json";
		$("#brand_1").addClass("on");
		shop_name = "지마켓";
	}else if(param == 2){
		shop_code = "4027";
		
		if( nowUrl.indexOf("dev.enuri.com") > -1 )	json_url = "/mobilefirst/http/shopBestMake.jsp?bestType=1";	
		else										json_url = "/mobilefirst/http/json/bestAuction.json";
		
		$("#brand_2").addClass("on");
		shop_name = "옥션";
	}else if(param == 3){
		shop_code = "5910";
		json_url = "/mobilefirst/http/json/best11st.json";
		$("#brand_3").addClass("on");
		shop_name = "11번가";
	}else if(param == 4){
		shop_code = "55";
		json_url = "/mobilefirst/http/json/bestInterPark.json";
		$("#brand_4").addClass("on");
		shop_name = "인터파크";
	}
	ga("send", "event", "mf_home", "tab_쇼핑베스트_"+shop_name, "tab_쇼핑베스트_"+ shop_name +"_홈");
	
	$.ajax({
		type: "GET",
		url: json_url,
		dataType: "JSON",
		success: function(json){
			$("#best_body").html(null);
			
			if(json.goodsList){
				var template = "";
				
				for(var i=0;i<json.goodsList.length;i++){
					template += "<li>";
					template += "	<a href=\"javascript:///\" class=\"best_area\" modelno=\""+ json.goodsList[i].modelno +"\" url=\""+ json.goodsList[i].url +"\" pl_no=\""+ json.goodsList[i].pl_no +"\">";
					template += "		<span class=\"num\">"+( i + 1) +"</span>";
					if(json.goodsList[i].modelno > 0){
						template += "		<span class=\"infobtn\" modelno=\""+ json.goodsList[i].modelno +"\">카탈로그보기</span>";
					}
					 if(param == 2){
						if(i < 4){
							template += "	<img class='trend_thumb' src=\""+json.goodsList[i].shopImageUrl+"\"  src=\""+json.goodsList[i].shopImageUrl+"\"  alt=\"\"> ";
						}else{
							template += "	<img class='trend_thumb swiper-lazy' src=\""+json.goodsList[i].shopImageUrl+"\"  src=\"http://imgenuri.enuri.gscdn.com/images/mobilefirst/enuri_rod.png\" alt=\"\"> ";
							template += "	<div class=\"swiper-lazy-preloader swiper-lazy-preloader-black\"></div>";
						}
					 }else{
						if(i < 4){
							template += "	<img class=\"trend_thumb\" src=\""+json.goodsList[i].imgurl+"\"  src=\""+json.goodsList[i].imgurl+"\"  alt=\"\"> ";
						}else{
							template += "	<img class='trend_thumb swiper-lazy' src=\""+json.goodsList[i].imgurl+"\"  src=\"http://imgenuri.enuri.gscdn.com/images/mobilefirst/enuri_rod.png\" alt=\"\"> ";
							template += "	<div class=\"swiper-lazy-preloader swiper-lazy-preloader-black\"></div>";
						}
					 }
					template += "		<strong>"+ json.goodsList[i].goodsnm +"</strong>";
					template += "		<span class=\"pr\">"+ commaNum(json.goodsList[i].price) +"<em>원</em>";
					if( json.goodsList[i].deliverytype2 == "1" &&  json.goodsList[i].deliveryinfo2 == "0"){
						template += "<span class=\"free\">무료배송</span>";
					}
					template += "		</span>";
					template += "	</a>";
					if(json.goodsList[i].ca_codeName != ""){
						template += "	<a href=\"javascript:///\" class=\"best_more\" cate=\""+ json.goodsList[i].ca_code4 +"\"><span>"+ json.goodsList[i].ca_codeName +"</span></a>";
					}
					template += "</li>";
				}
				$("#best_body").html(template);
				
				$(".best_area").each(function(){
					$(this).on("click",function(event) {
						goShop($(this).attr("url"),shop_code,$(this).attr("pl_no"),'','','','','',this,$(this).attr("modelno"));
						ga("send", "event", "mf_home", "tab_쇼핑베스트_"+shop_name, "tab_쇼핑베스트_"+ shop_name +"_상품");
					});
				});
			    $(".infobtn").each(function(){
                    $(this).on("click",function(event) {
                        event.stopPropagation();
                        location.href = "/mobilefirst/detail.jsp?modelno="+ $(this).attr("modelno");
                        ga("send", "event", "mf_home", "tab_쇼핑베스트_"+shop_name, "tab_쇼핑베스트_"+ shop_name +"_인포");
                    });
                });
                $(".best_more").each(function(){
                    $(this).on("click",function(event) {
                        event.stopPropagation();
                        go_cate($(this).attr("cate"));
                        ga("send", "event", "mf_home", "tab_쇼핑베스트_"+shop_name, "tab_쇼핑베스트_"+ shop_name +"_카테");
                    });
                });
			}
			bast_list = json;
			setDelay();
		},
		error : function(result) { 
			alert("error occured. Status:" + result.status  
	                     + ' --Status Text:' + result.statusText 
	                    + " --Error Result:" + result); 
		}
	});
	
}
function getBaselist(param){
    $(".tab_deal li").removeClass("on");
    
    var shop_code = "536";
    var shop_name = "슈퍼딜";
    var json_url = "/mobilefirst/http/json/superDeal.json";
    
    if(param == 1){
        shop_code = "536";
        shop_name = "슈퍼딜";
        if( nowUrl.indexOf("dev.enuri.com") > -1 )   	json_url = "/mobilefirst/http/shopDeal2Make.jsp?bestType=2";	
        else   	json_url = "/mobilefirst/http/json/superDeal.json";
        
        $("#hot_title").attr("src","http://imgenuri.enuri.gscdn.com/images/m_home/hotdeal_superdeal.png");
        $("#deal_1").addClass("on");
    }else if(param == 2){
        shop_code = "4027";
        shop_name = "올킬";
        json_url = "/mobilefirst/http/json/allKill.json";
        $("#hot_title").attr("src","http://imgenuri.enuri.gscdn.com/images/m_home/hotdeal_allkill.png");
        $("#deal_2").addClass("on");
    }else if(param == 3){
        shop_code = "5910";
        shop_name = "쇼킹딜";
        json_url = "/mobilefirst/http/json/shocking.json";
        $("#hot_title").attr("src","http://imgenuri.enuri.gscdn.com/images/m_home/hotdeal_shocking.png");
        $("#deal_3").addClass("on");
    }else if(param == 4){
        shop_code = "6641";     
        shop_name = "티몬";
        json_url = "/mobilefirst/http/json/tmon.json";
        $("#hot_title").attr("src","http://imgenuri.enuri.gscdn.com/images/m_home/hotdeal_timon.png");
        $("#deal_4").addClass("on");
    }else if(param == 5){
    	//쿠팡
    }else if(param == 6){
        shop_code = "6508";
        shop_name = "위메프";
        
        var locurl = document.location.href; 
        
        if( locurl.indexOf("dev.enuri.com") > -1 ){
        	json_url = "/mobilefirst/http/shopDeal3Make.jsp?bestType=4";
        }else{
        	json_url = "/mobilefirst/http/json/wemake.json";
        }
        
        $("#hot_title").attr("src","http://imgenuri.enuri.gscdn.com/images/m_home/hotdeal_wemape.png");
        $("#deal_6").addClass("on");
	}else if(param == 7){
	    shop_code = "55";
	    shop_name = "쎈딜";
	    json_url = "/mobilefirst/http/json/ssenDeal.json";
	    $("#hot_title").attr("src","http://imgenuri.enuri.gscdn.com/images/m_home/hotdeal_ssendeal.png");
	    $("#deal_7").addClass("on");
	}
    
    ga("send", "event", "mf_hotdeal", "hotdeal_tab", "tab_"+ shop_name);
    
    $.ajax({
        type: "GET",
        url: json_url,
        dataType: "JSON",
        success: function(json){
            $("#hotDealBestList").html(null);
            
            if(json.goodsList){
                var temp = "";
                
                for(var i=0;i<json.goodsList.length;i++){
                
                var template = "";
                if(shop_code=="6641" || shop_code=="6508" || shop_code=="55"){
                    template += "<li>";
                    template += "<a href=\"javascript:///\" modelnm=\""+ json.goodsList[i].goodsnm +"\" class=\"best_area\" url=\""+ json.goodsList[i].url +"\" modelno=\""+ json.goodsList[i].modelno +"\" pl_no=\""+ json.goodsList[i].pl_no +"\">";
                    template += "<div class=\"thum sq\">";
                    template += 	"<img data-original=\""+json.goodsList[i].shopImageUrl+"\" alt='' class='bestLazy' src='http://imgenuri.enuri.gscdn.com/images/m_home/noimg.png' />";
                    template += "</div>";
                    template += "<div class=\"zzimarea\" onclick=\"event.cancelBubble=true;\">";
                    template += "<button type=\"button\" class=\"heart\" onclick=\"zzimSet("+json.goodsList[i].model_no +" , "+json.goodsList[i].pl_no +" ,this,"+shop_code+");\" id=P_"+ json.goodsList[i].pl_no +">찜</button>";
                    template += "</div>";

                    template += "<div class=\"info\">";
                    //String[] shopCode = {"536", "4027", "5910", "6641", "6508"};
            		//String[] shopName = {"슈퍼딜", "올킬", "쇼킹딜", "티몬", "위메프"};
                    if(shop_code == "6641"){
                        template += "<span class=\"mall\"><img src=\"http://img.enuri.com/images/mobilefirst/main/shoplogo/tmon.png\" alt=\"\" /></span>";
                    }else if(shop_code == "6508"){
                    	template += "<span class=\"mall\"><img src=\"http://img.enuri.com/images/mobilefirst/main/shoplogo/wemake.png\" alt=\"\" /></span>";
                    }else if(shop_code == "55"){
                        template += "<span class=\"mall\"><img src=\"http://img.enuri.com/images/mobilefirst/main/shoplogo/ssendeal.png\" alt=\"\" /></span>";
                    }
                    template += "<strong>"+json.goodsList[i].goodsnm+"</strong>";
                    template += "<div class=\"price\">";
                    if(json.goodsList[i].discount_rate){
                        if((json.goodsList[i].discount_rate != "" && json.goodsList[i].discount_rate != 0) && (json.goodsList[i].orgPrice != "" && json.goodsList[i].orgPrice != 0)){
                            template += "<span class=\"sale\"><b>"+json.goodsList[i].discount_rate+"</b>%</span>";
                            template += "<span class=\"prc\"><b>"+commaNum(json.goodsList[i].price)+"</b>원";
                            template += "<del>"+commaNum(json.goodsList[i].orgPrice)+"원</del>";
                        }else if((json.goodsList[i].discount_rate == "" || json.goodsList[i].discount_rate == "0") || (json.goodsList[i].orgPrice == "" || json.goodsList[i].orgPrice == "0")){
                            template += "<span class=\"sale\"><b>특별가</b></span>";
                            template += "<span class=\"prc\"><b>"+commaNum(json.goodsList[i].price)+"</b>원";
                        }
                    }else{
                        template += "<span class=\"sale\"><b>특별가</b></span>";
                        template += "<span class=\"prc\"><b>"+commaNum(json.goodsList[i].price)+"</b>원";
                    }
                    template += "</span>";
                    template += "</div>";
                    template += "</div>";
                    template += "</a>";
                    if(json.goodsList[i].pcnt){
                        template += "<div class=\"option_area\">"+json.goodsList[i].pcnt+"개 구매";
                    }
                    if(json.goodsList[i].option){
                        var option = json.goodsList[i].option;
                        var optSplit = option.split(',');
                        for(var j=0;j<optSplit.length;j++){
                            if(optSplit[j] == "무료배송"){
                                template += "<em>"+optSplit[j]+"</em>";
                            }
                        }
                    }
                    template += "</div>";
                    template += "</li>";
                }else{
                    template += "<li>";
                    template += "<a href=\"javascript:///\" modelnm=\""+ json.goodsList[i].goodsnm +"\" class=\"best_area\" url=\""+ json.goodsList[i].url +"\" modelno=\""+ json.goodsList[i].modelno+"\" pl_no=\""+ json.goodsList[i].pl_no +"\">";
                    
                    if(shop_code=="5910"){
                    	template += "<div class=\"thum sq\">";	
                    }else{
                    	template += "<div class=\"thum\">";
                    }
                    
                    
                    if (typeof json.goodsList[i].wmov != "undefined"){
                    	template += "<em class='play ico_m' data-mov='"+json.goodsList[i].wmov+"'>PLAY</em>";
                    }
                    template += 	"<img data-original=\""+json.goodsList[i].shopImageUrl+"\" alt='' class='bestLazy' src='http://imgenuri.enuri.gscdn.com/images/m_home/noimg.png' />";
                    
                    template += "</div>";
                    template += "<div class=\"zzimarea\"  onclick=\"event.cancelBubble=true;\">";
                    template += "<button type=\"button\" class=\"heart\" onclick=\"zzimSet("+ json.goodsList[i].model_no +" , "+ json.goodsList[i].pl_no +" ,this,"+shop_code+");\" id=P_"+ json.goodsList[i].pl_no +">찜</button>";
                    template += "</div>";

                    template += "<div class=\"info\">";
                    if(shop_code == "536"){
                        template += "<span class=\"mall\"><img src=\"http://img.enuri.com/images/mobilefirst/main/shoplogo/superdeal.png\" alt=\"\" /></span>";
                    }else if(shop_code == "4027"){
                        template += "<span class=\"mall\"><img src=\"http://img.enuri.com/images/mobilefirst/main/shoplogo/allkill.png\" alt=\"\" /></span>";
                    }else{
                        template += "<span class=\"mall\"><img src=\"http://img.enuri.com/images/mobilefirst/main/shoplogo/shocking.png\" alt=\"\" /></span>";
                    }
                    template += "<strong>"+json.goodsList[i].goodsnm+"</strong>";
                    template += "<div class=\"price\">";
                    if(json.goodsList[i].discount_rate){
                        if((json.goodsList[i].discount_rate != "" && json.goodsList[i].discount_rate != 0) && (json.goodsList[i].orgPrice != "" && json.goodsList[i].orgPrice != 0)){
                            template += "<span class=\"sale\"><b>"+json.goodsList[i].discount_rate+"</b>%</span>";
                            template += "<span class=\"prc\"><b>"+commaNum(json.goodsList[i].price)+"</b>원";
                            template += "<del>"+commaNum(json.goodsList[i].orgPrice)+"원</del>";
                        }else if((json.goodsList[i].discount_rate == "" || json.goodsList[i].discount_rate == "0") || (json.goodsList[i].orgPrice == "" || json.goodsList[i].orgPrice == "0")){
                            template += "<span class=\"sale\"><b>특별가 </b></span>";
                            template += "<span class=\"prc\"><b>"+commaNum(json.goodsList[i].price)+"</b>원";
                        }
                    }else{
                        template += "<span class=\"sale\"><b>특별가 </b></span>";
                        template += "<span class=\"prc\"><b>"+commaNum(json.goodsList[i].price)+"</b>원";
                    }
                    template += "</span>";
                    template += "</div>";
                    template += "</div>";
                    template += "</a>";
                    if(json.goodsList[i].pcnt){
                        template += "<div class=\"option_area\">"+json.goodsList[i].pcnt+"개 구매";
                    }
                    if(json.goodsList[i].option){
                        var option = json.goodsList[i].option;
                        var optSplit = option.split(',');
                        for(var j=0;j<optSplit.length;j++){
                            if(optSplit[j] == "무료배송"){
                                template += "<em>"+optSplit[j]+"</em>";
                            }
                        }
                    }
                    template += "</div>";
                    template += "</li>";
                }
                $("#hotDealBestList").append(template);
            } 
                setDelay();
                
                hot_list = json;
                $(".best_area").each(function(){
                    $(this).on("click",function(event) {
                        goShop($(this).attr("url"),shop_code,$(this).attr("pl_no"),'','','','','',this,$(this).attr("modelno"));
                        
                        ga("send", "event", "mf_hotdeal", "buy", "buy_"+shop_name+"_"+$(this).attr("modelnm"));
                    });
                });
                
                $(".play.ico_m").click(function(){
                	if(agentCheck() == "I"){
                		alert("아이폰은 재생할수 없습니다.");
                		return false;
                	}
                	var movUrl = $(this).attr("data-mov");
                	window.open(movUrl);
                	return false;	
                	
                });
            }
        },
        complete : function(data) {
            zzimCheckSet();
        	$(".bestLazy").lazyload({
        		effect:'fadeIn', 
                threshold:500, 
                failure_limit:2 ,
                skip_invisible : true
        	});
            
        },
        error : function(result) {
            alert("error occured. Status:" + result.status
             + ' --Status Text:' + result.statusText 
            + " --Error Result:" + result); 
        }
    });
}
function go_cate(cate){	location.href="/mobilefirst/list.jsp?cate="+cate;}