var vVerios = getCookie("verios");

var news_json = null;
var news_list = null;
var news_cate = null;
var json_guide = null;

var vGuide = "01";
//현재 보고 잇는 카테고리
var vViewcate = "01";

var Page1 = 0;
var Page2 = 0;
var Page3 = 0;
var Page4 = 0;
//각 카테고리별 노출된 초기 뉴스 번호's
var kbno_1 = "";
var kbno_2 = "";
var kbno_3 = "";
var kbno_4 = "";
function getNews_top(){
	$("#news_top_list").html(null);
	
	if(news_json == null){
		var loadUrl = "/mobilefirst/http/json/getNews_device.json";
	    $.ajax({
	        url: loadUrl,
	        dataType: 'json',
	        success: function(json){
	        	news_json = json.top;
	        	if(news_json.NewsPopular) news_popular();
	        	
	        	news_list = json.list;
	        	if(news_list)	getNews_list();
	        	
	        	news_cate = json;
	        	if(news_cate)	getNews_list_bottom();
	        	
	        	swiperAll.onResize();
	        	
	        }, complete : function(data) {
	            
	        },
	        error : function(result) { 
	            alert("error occured. Status:" + result.status  
	                         + ' --Status Text:' + result.statusText 
	                        + " --Error Result:" + result); 
	        }
	    });
	}else{
		if(news_json.NewsPopular)	news_popular();
	}
}
function kb_view2(kbno){
	ga('send', 'event', 'mf_today_new', 'best_new', 'best_news_'+kbno);
	window.open("/mobilefirst/news_detail.jsp?kbno="+kbno+"&verios="+vVerios);
	 return; 
}
function news_popular(){
	var template = "<ul>";
	
	for(var i=0;i<news_json.NewsPopular.length;i++){
		template += "<li><a href=\"javascript:///\" onclick=\"kb_view2("+ news_json.NewsPopular[i].kb_no +")\" ><em>"+ ( i + 1 ) +"</em>"+ news_json.NewsPopular[i].kb_title +"<span class=\"hits\"><em>조회수</em>"+  commaNum(news_json.NewsPopular[i].kb_readcnt) +"</span></a></li>";
	}
	template += "</ul>";
	$("#news_top_list").html(template);
	
	if(news_json.NewsPopular.length == 0)		$("#NewsBody .first").hide();
	
}
function news_view(cate,obj){
	vViewcate = cate;
	 
	$(".recentnews_tab_line").removeClass("on");
	$(obj).addClass("on");
	
	$(".news_list_cate_part").hide();
	$("#cate_"+cate).show();
	
	getNews_list_bottom();
}
function getNews_list_bottom(){
	var vChk_addlist = false;
	var vNotin = "";
	var json;
	
	if(vViewcate == "01" && Page1 == 0){
		vChk_addlist = true;
		vNotin = kbno_1;
		json = news_cate.cate_01.NewsCate_01;
	}else if(vViewcate == "02" && Page2 == 0){
		vChk_addlist = true;
		vNotin = kbno_2;
		json = news_cate.cate_02.NewsCate_02;
	}else if(vViewcate == "03" && Page3 == 0){
		vChk_addlist = true;
		vNotin = kbno_3;
		json = news_cate.cate_03.NewsCate_03;
	}else if(vViewcate == "04" && Page4 == 0){
		vChk_addlist = true;
		vNotin = kbno_4;
		json = news_cate.cate_04.NewsCate_04;
	}
	if(vChk_addlist){
		var template = "";
		
		if(json){
			for(var i=0;i<json.length;i++){
					template += "	<li class=\"news_pic\">";
					template += "		<a href=\"javascript:///\" onclick=\"kb_view("+ json[i].kb_no +")\" ><strong>"+ json[i].kb_title + "</strong>";
					
					template += "		<span class=\"thumb\"><img src=\""+ json[i].rss_thumbnail +"\" onerror=\"fn_err_img(this);\" /></span>";
					template += "		<span class=\"date\"><em>"+ (json[i].kb_regdate).substring(0,10) +"</em>";
					if(json[i].kb_readcnt >= 200){
						template += "		<em>조회수 : "+ commaNum(json[i].kb_readcnt) +"</em>";
					}	
					template += "		</span>";
					template += "		<span class=\"txt\">"+json[i].kb_content+"</span>";
					template += "	</a></li>";
			}
		}

		$("#news_list_bottom_"+vViewcate).html(template);
		
		if(vViewcate == "01"){
			Page1 = 1;
		}else if(vViewcate == "02"){
			Page2 = 1;
		}else if(vViewcate == "03"){
			Page3 = 1;
		}else if(vViewcate == "04"){
			Page4 = 1;
		}
	} 
}
function getNews_list(){
	$("#recentnews_contents").html(null);
	var json = news_list;
	if(json.NewsList){
		var template = "";
		for(var i=0;i<json.NewsList.length;i++){
			
			if( (i+1) % 8 == 1 ){	
				template += "<li class=\"news_list_cate_part\" id=\"cate_"+ json.NewsList[i].mm_llcate +"\">";
				template += "<div class=\"top_news_box\">";
				template += "	<ul>";
				template += "		<li>";
				template += "			<a href=\"javascript:///\" onclick=\"kb_view("+ json.NewsList[i].kb_no +")\" >";
				template += "				<span class=\"thumb\"><img src=\"http://storage.enuri.gscdn.com/pic_upload/main/news/"+ json.NewsList[i].mn_img +"\" alt=\"\" /></span>";
				template += "				<span class=\"tit\">"+ json.NewsList[i].kb_title +"</span>";
				template += "			</a>";
				template += "		</li>";
			}else if( (i+1) % 8 == 2 ){
				template += "		<li>";
				template += "			<a href=\"javascript:///\" onclick=\"kb_view("+ json.NewsList[i].kb_no +")\" >";
				template += "				<span class=\"thumb\"><img src=\"http://storage.enuri.gscdn.com/pic_upload/main/news/"+ json.NewsList[i].mn_img +"\" alt=\"\" /></span>";
				template += "				<span class=\"tit\">"+ json.NewsList[i].kb_title +"</span>";
				template += "			</a>";
				template += "		</li>";
				template += "	</ul>";
				template += "</div>";
			}else if( (i+1) % 8 == 3 ){
				template += "<ul class=\"news_list\">";

				template += "	<li class=\"news_pic\">";
				template += "		<a href=\"javascript:///\" onclick=\"kb_view("+ json.NewsList[i].kb_no +")\" ><strong>"+ json.NewsList[i].kb_title + "</strong>";
				
				template += "		<span class=\"thumb\"><img src=\"http://storage.enuri.gscdn.com/pic_upload/main/news/"+ json.NewsList[i].mn_img +"\" onerror=\"fn_err_img(this);\" /></span>";
				template += "		<span class=\"date\"><em>"+ (json.NewsList[i].kb_regdate).substring(0,10) +"</em>";
				if(json.NewsList[i].kb_readcnt >= 200){
					template += "		<em>조회수 : "+ commaNum(json.NewsList[i].kb_readcnt) +"</em>";
				}	
				template += "		</span>";
				template += "		<span class=\"txt\">"+json.NewsList[i].kb_content+"</span>";
				template += "	</a></li>";
			}else if( (i+1) % 8 == 0 ){	

				template += "	<li class=\"news_pic\">";
				template += "		<a href=\"javascript:///\" onclick=\"kb_view("+ json.NewsList[i].kb_no +")\" ><strong>"+ json.NewsList[i].kb_title + "</strong>";
				
				template += "		<span class=\"thumb\"><img src=\"http://storage.enuri.gscdn.com/pic_upload/main/news/"+ json.NewsList[i].mn_img +"\" onerror=\"fn_err_img(this);\" /></span>";
				template += "		<span class=\"date\"><em>"+ (json.NewsList[i].kb_regdate).substring(0,10) +"</em>";
				if(json.NewsList[i].kb_readcnt >= 200){
					template += "		<em>조회수 : "+ commaNum(json.NewsList[i].kb_readcnt) +"</em>";
				}	
				template += "		</span>";
				template += "		<span class=\"txt\">"+json.NewsList[i].kb_content+"</span>";
				template += "	</a></li>";
				template += "</ul>";
				template += "<ul class=\"news_list last\" id=\"news_list_bottom_"+ json.NewsList[i].mm_llcate +"\"></ul>";
				template += "</li>";
				
			}else{

				template += "	<li class=\"news_pic\">";
				template += "		<a href=\"javascript:///\" onclick=\"kb_view("+ json.NewsList[i].kb_no +")\" ><strong>"+ json.NewsList[i].kb_title + "</strong>";
				
				template += "		<span class=\"thumb\"><img src=\"http://storage.enuri.gscdn.com/pic_upload/main/news/"+ json.NewsList[i].mn_img +"\" onerror=\"fn_err_img(this);\" /></span>";
				template += "		<span class=\"date\"><em>"+ (json.NewsList[i].kb_regdate).substring(0,10) +"</em>";
				if(json.NewsList[i].kb_readcnt >= 200){
					template += "		<em>조회수 : "+ commaNum(json.NewsList[i].kb_readcnt) +"</em>";
				}	
				template += "		</span>";
				template += "		<span class=\"txt\">"+json.NewsList[i].kb_content+"</span>";
				template += "	</a></li>";
			}
		}

		$("#recentnews_contents").html(template);
		
		$(".news_list_cate_part").hide();
		$("#cate_01").show();
	}
}
function guide_view(cate){
	vGuide = cate;
	
	$("#GuideBody .recentnews_tab li a").removeClass("on");
	$("#guide_"+cate).addClass("on");

	getShoppingGuideList();
	setDelay();
}
function getGuide_top(){
	$("#guide_top_list").html(null);
	var loadUrl = "/mobilefirst/http/json/getShopping_guide.json";

	    $.ajax({
	        url: loadUrl,
	        dataType: 'json',
	        success: function(json){
	        	
	        	json_guide = json;
	        	
	        	var json = json.top2;
	        	if(json.ShoppingGuideList){
	        		var template = "<ul>";
	        		for(var i=0;i<json.ShoppingGuideList.length;i++){
	        			template += "<li><a href=\"javascript:///\" onclick=\"view_guide("+ json.ShoppingGuideList[i].kb_no +",'1')\" ><em>"+ ( i + 1 ) +"</em>"+ json.ShoppingGuideList[i].kb_title +"<span class=\"hits\"><em>조회수</em>"+  commaNum(json.ShoppingGuideList[i].kb_readcnt) +"</span></a></li>";
	        		}
	        		template += "</ul>";
	        		$("#guide_top_list").html(template);
	        		
	        		if(json.ShoppingGuideList.length == 0){
	        			$("#GuideBody .first").hide();
	        		}
	        	}
	        	
	        	//console.log(json_guide);
	        	if(json_guide)	getShoppingGuideList();
	        	
	        }
	    });
}
function getShoppingGuideList(){
	
	var json;
	if(vGuide=="01")			json = json_guide.cate_01;
	else if(vGuide=="02")		json = json_guide.cate_02;
	else if(vGuide=="03")		json = json_guide.cate_03;
	else if(vGuide=="04")		json = json_guide.cate_04;

	var num = 0;
	var json_guide_arr = new Array();
	var template_guide = "";
	var news_template_guide = "<ul class=\"news_list\">";
	
	//console.log(json);
	if(json.ShoppingGuideList){
		//상단 이미지 리스트
		for(var i=0;i<json.ShoppingGuideList.length;i++){ 
			if(json.ShoppingGuideList[i].img_yn == '1' 
						&& json.ShoppingGuideList[i].date50 == '1' && typeof json.ShoppingGuideList[i].mo_img2 != 'undefined' ){
				json_guide_arr[num] = i;
				template_guide += "				<li>		";
				template_guide += "					<a href=\"javascript://\" onclick=\"view_guide('"+ json.ShoppingGuideList[i].kb_no+"', '2');\">	";

				//template_guide += "						<img !class=\"guide_thumb\" src=\"http://storage.enuri.gscdn.com/pic_upload/enurinews_mobile/"+json.ShoppingGuideList[i].mo_img2+"\"  !src=\"http://storage.enuri.gscdn.com/pic_upload/enurinews_mobile/"+json.ShoppingGuideList[i].mo_img2+"\"  alt=\"\" />	";
				
				if(typeof json.ShoppingGuideList[i].mo_img != "undefined"){
					template_guide += "						<img !class=\"guide_thumb\" src=\"http://storage.enuri.gscdn.com/pic_upload/enurinews/"+json.ShoppingGuideList[i].mo_img+"\"  src2=\"http://storage.enuri.gscdn.com/pic_upload/enurinews_mobile/"+json.ShoppingGuideList[i].mo_img2+"\"   onerror=\"fn_err_img_big(this);\" alt=\"\" />	";					
				}else{
					template_guide += "						<img !class=\"guide_thumb\" src=\"http://storage.enuri.gscdn.com/pic_upload/enurinews/"+json.ShoppingGuideList[i].mo_img2+"\"  src2=\"http://storage.enuri.gscdn.com/pic_upload/enurinews_mobile/"+json.ShoppingGuideList[i].mo_img2+"\"   onerror=\"fn_err_img_big(this);\" alt=\"\" />	";
				}

				template_guide += "						<strong>"+ json.ShoppingGuideList[i].kb_title+"</strong>	";
				template_guide += "					</a>	";
				template_guide += "				</li>	";
				num = num + 1;
			}
		}
		//하단 리스트
		for(var i=0;i<json.ShoppingGuideList.length;i++){ 
			//상단 리스트로 사용되었는지 체크
			var arrChk = true;
			for(var j=0;j<json_guide_arr.length;j++){
				if(i == json_guide_arr[j]){
					arrChk = false;
				}
			}
			if(arrChk){
				if (typeof json.ShoppingGuideList[i].mo_img != 'undefined' || typeof json.ShoppingGuideList[i].mo_img2 != 'undefined'){
					news_template_guide += "<li class=\"news_pic\">";
				}else{
					news_template_guide += "<li>";
				}
				news_template_guide += "		<a href=\"javascript:///\" onclick=\"view_guide("+ json.ShoppingGuideList[i].kb_no +", '2')\" ><strong>"+ json.ShoppingGuideList[i].kb_title + "</strong>";
				
				//이미지 있는경우 노출
				if (typeof json.ShoppingGuideList[i].mo_img != 'undefined' || typeof json.ShoppingGuideList[i].mo_img2 != 'undefined'){
					if (typeof json.ShoppingGuideList[i].mo_img != 'undefined'){
						news_template_guide += "	<span class=\"thumb\"><img src=\"http://storage.enuri.gscdn.com/pic_upload/enurinews/"+json.ShoppingGuideList[i].mo_img +"\" onerror=\"fn_err_img(this);\" /></span>";	
					}else if (typeof json.ShoppingGuideList[i].mo_img2 != 'undefined'){
						news_template_guide += "	<span class=\"thumb\"><img src=\"http://storage.enuri.gscdn.com/pic_upload/enurinews_mobile/"+json.ShoppingGuideList[i].mo_img2 +"\" onerror=\"fn_err_img(this);\" /></span>";
					}
				}
				
				news_template_guide += "		<span class=\"date\"><em>"+ (json.ShoppingGuideList[i].kb_regdate).substring(0,10) +"</em>";
				if(json.ShoppingGuideList[i].kb_readcnt >= 200){
					news_template_guide += "		<em>조회수 : "+ commaNum(json.ShoppingGuideList[i].kb_readcnt) +"</em>";
				}	
				news_template_guide += "		</span>";
				news_template_guide += "		<span class=\"txt\">"+json.ShoppingGuideList[i].kb_content+"</span>";
				news_template_guide += "	</a></li>";
			}			
		}
	}	
	news_template_guide += "</ul>";
	$("#GuideBodyInner").html(template_guide);
	$("#news_guide_contents").html(news_template_guide);

} 
function kb_view(kbno){
	var cName = $("#news_"+vViewcate).text();
	ga('send', 'event', 'mf_today_new', 'topic_new_'+vViewcate, 'topic_new_'+kbno);
	window.open("/mobilefirst/news_detail.jsp?kbno="+kbno+"&verios="+vVerios);
	 return;   
}
function fn_err_img(img){
	var _this = img;
	_this.style.display='none';
	$(img).parents("li").removeClass("news_pic");
} 
function fn_err_img_big(img){
	var _this = img;
	var src2 = $(img).attr("src2");
	$(img).attr("src",src2);
}