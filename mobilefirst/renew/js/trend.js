/*
var json_trend;
var vTrendCate = 0;

function getTrandJson(){
	
	if(json_trend == null){
		
		var trendUrl = "";
		
		if(nowUrl.indexOf("dev.enuri.com") > -1 )  trendUrl = "/mobilefirst/ajax/main/ajax_to_json_trend_2016.jsp";
		else  									   trendUrl = "/mobilefirst/http/json/getTrend_list.json";
		
	    $.ajax({
	        url: trendUrl,
	        dataType: 'json',
	        success: function(json){
	        	json_trend = json;
	        	getTrendPickupList();
	        	
	        }, complete : function(data) {
	        	//swiperAll.onResize();
	        },
	        error : function(result) { 
	            alert("error occured. Status:" + result.status  
	                         + ' --Status Text:' + result.statusText 
	                        + " --Error Result:" + result); 
	        }
	    });
	}
}
function getTrendPickupList(){
	//처음 한번만 호출. 
	var t_no = 0;
	json = json_trend; 
	
	$("#PickupBody").html(null); 
	if(json.trend){
		
		for(var i=0;i<json.trend.length;i++){
			var template = "";
			if(json.trend[i].ref_model_no != undefined && json.trend[i].sublist){
				t_no = t_no + 1;
				if(t_no == 1){  
					template += "<div class=\"trend_area first trdrwd\" id=\"trend_"+ json.trend[i].subject_idx +"\"> ";
				}else{
					template += "<div class=\"trend_area trdrwd\" id=\"trend_"+ json.trend[i].subject_idx +"\"> ";
				}
				template += "<ul class=\"trendBox\"> ";
				template += "	<li><a href=\"javascript:///\" onclick=\"detail_view("+ json.trend[i].ref_model_no +","+ json.trend[i].ref_model_no +", '1','"+ json.trend[i].mobile_url +"')\" > ";
				template += "	<strong class=\"b_tit\">"+ json.trend[i].subject +"<span>"+json.trend[i].subject_sub+"</span></strong> ";
				if(i < 4){
					template += "	<img class=\"trend_thumb\" src=\""+json.trend[i].ref_model_img+"\"  src=\""+json.trend[i].ref_model_img+"\"  alt=\"\" style=\"width:100%;\"> ";
				}else{
					template += "	<img class=\"trend_thumb\" src=\""+json.trend[i].ref_model_img+"\"  src=\"http://imgenuri.enuri.gscdn.com/images/mobilefirst/noimg_plan.png\" alt=\"\" style=\"width:100%;\"> ";
				}
				template += "	<div class=\"priceinfo\" id=\"info_"+json.trend[i].ref_model_no+"\"> ";
				template += "		<span class=\"tit\">"+json.trend[i].ref_modelnm+"</span> ";
				template += "		<span class=\"price\"><strong>"+json.trend[i].minprice3+"<em>원</em></strong> ~ "+json.trend[i].maxprice+"<em>원</em></span> ";
				template += "		<button class=\"pricego\" onclick=\"detail_view("+ json.trend[i].ref_model_no +","+ json.trend[i].ref_model_no +", '1','')\" >가격비교 ("+json.trend[i].mallcnt3+")</button> ";
				template += "	</div> ";
				
				template += "	</li></a> ";  
				template += "</ul> "; 
				if(json.trend[i].sublist){   
				template += "<ul class=\"relation\">	 "; 
					for(var k=0;k<json.trend[i].sublist.length;k++){
						template += "	<li onclick=\"detail_view("+ json.trend[i].ref_model_no +","+ json.trend[i].sublist[k].ref_model_no +",'2','"+ json.trend[i].sublist[k].mobile_url +"')\" > ";
						template += "		<img class=\"trend_thumb\" src=\""+json.trend[i].sublist[k].img_src+"\"  src=\"http://imgenuri.enuri.gscdn.com/images/mobilefirst/noimg_plan.png\" alt=\"\" /> ";
						template += "		<strong  id=\"info2_"+json.trend[i].sublist[k].ref_model_no+"\">"+json.trend[i].sublist[k].ref_modelnm+"</strong> ";
						template += "		<span>"+json.trend[i].sublist[k].minprice3+"<em>원</em></span> ";
						template += "	</li> ";
					} 
				template += "</ul> ";
				}
				template += "<a href=\"javascript:///\" class=\"morebtn\" onclick=\"list_view('"+json.trend[i].ref_model_no+"', '"+ json.trend[i].ca_code +"')\" > <span>"+json.trend[i].c_name+" 더보기</span></a> ";
				template += "</div> ";
			}
			$("#PickupBody").append(template);
			setDelay();
		}
		
	}
}
function trend_tab(cate){
	$(".trend_tab").removeClass("on");
	$("#t_"+cate).addClass("on");
	
	if(vTrendCate == cate){
	}else{
		if(cate == 1){
			vTrendCate = 1;	
			var goUrl = "/mobilefirst/http/json/getTrend_list_01.json" 
		}else if(cate ==2){
			vTrendCate = 2;	
			var goUrl = "/mobilefirst/http/json/getTrend_list_02.json" 
		}else if(cate ==3){
			vTrendCate = 3;	
			var goUrl = "/mobilefirst/http/json/getTrend_list_03.json" 
		}else if(cate ==4){
			vTrendCate = 4;	
			var goUrl = "/mobilefirst/http/json/getTrend_list_04.json" 
		}else{
			vTrendCate = 0;	
			var goUrl = "/mobilefirst/http/json/getTrend_list.json" 
		}		
	    $.ajax({
	        url: goUrl,
	        dataType: 'json',
	        success: function(json){
	        	json_trend = json;
	    		if(cate > 1){
	    			if(cate == 4)		$(".trd_scroll").scrollLeft(500);
	    			else				$(".trd_scroll").scrollLeft(vTrendCate*(vTrendCate*10));
	    		}else{
	    			$(".trd_scroll").scrollLeft(0);			
	    		}
	    		getTrendPickupList();
	    		setDelay();
	        }
	    });
	}
} 
function detail_view(modelno1, modelno2, param, mobile_url){
	if(!e) var e = window.event;
	e.cancelBubble = true;
	e.returnValue = false;
	if (e.stopPropagation) {
		e.stopPropagation();
		e.preventDefault();
	}
	var thisNM = $("#info_"+modelno2 + " .tit").text(); 
	if(param=="1"){
		ga('send', 'event', 'mf_trend_pickup', 'trend_pickup_'+modelno1, thisNM);
	}else if(param=="2"){
		var thisNM2 = $("#info2_"+modelno2).text();
		ga('send', 'event', 'mf_trend_pickup', 'trend_pickup_'+modelno1, '관련상품_'+thisNM2);
	} 
	if(mobile_url.length > 0 && mobile_url != "undefined"){
		window.open(mobile_url);
	}else{
		location.href = "/mobilefirst/detail.jsp?modelno="+modelno2;
	}
	return;  
}
function list_view(modelno,  cate){
	ga('send', 'event', 'mf_trend_pickup', 'trend_'+modelno, 'more');
	location.href = "/mobilefirst/list.jsp?cate="+cate;
	return;
}
function view_guide(kbno, param){ 
	window.open("/mobilefirst/news_detail.jsp?kbno="+kbno+"&from=guide&verios="+vVerios);
	var catenm = "";
	
	if($("#guide_01").hasClass("on")){
		catenm = "디지털/가전";
	}else if($("#guide_02").hasClass("on")){
		catenm = "컴퓨터";
	}else if($("#guide_03").hasClass("on")){
		catenm = "스포츠/자동차";
	}else if($("#guide_04").hasClass("on")){
		catenm = "유아/라이프";
	}
	 
	if(param == "1"){
		ga('send', 'event', 'mf_guide', 'guide_newtip', 'guide_newtip_'+kbno);
	}else if(param == "2"){
		ga('send', 'event', 'mf_guide', 'guide_category', 'guide_newtip_'+catenm+'_'+kbno);
	}	
	return;   
}
*/