var plan_list;
function getPlanBanner(){

    var loadUrl = "";
    
    if(document.URL.indexOf("dev.enuri.com") > -1) loadUrl = "/mobilefirst/ajax/main/ajax_to_json_plan_banner.jsp";
    else loadUrl = "/mobilefirst/http/json/plan_banner_list.json";
    
    if(plan_list == null){
    	$.ajax({
            url: loadUrl,
            dataType: 'json',
            async: false,
            success: function(json){
                
            	$("#planList").empty();
            	
                $.each(json.planList , function(i, v){
                	var planHtml = "";
    	                planHtml +="<li data-id='"+v.TODAY_ID+"'><a href=\"javascript:goPlanView('"+v.TODAY_ID+"', '"+v.URL+"')\">";
    	                //planHtml +=    "<img class='swiper-lazy' src=\"http://img.enuri.gscdn.com/images/mobilefirst/planlist/B_"+v.TODAY_ID+"/B_"+v.TODAY_ID+"_main.png\" class=\"thum\">";
    	                planHtml +=    "<img class='swiper-lazy' src='"+v.IMGSRC+"'  class=\"thum\">";
    	                planHtml += "	<div class='swiper-lazy-preloader swiper-lazy-preloader-black'></div>";
    	                planHtml +="</a>";
    	                planHtml +="</li>";
    	                $("#planList").append(planHtml);
                });
                //$("#planList").html(planHtml);
                plan_list = json;
                setDelay();
                $(".winner").hide();
            }
        });
    }
}
function getEventBanner(){
    var loadUrl = "/mobilefirst/http/json/plan_banner.json";

    $.ajax({
        url: loadUrl,
        dataType: 'json',
        async: false,
        success: function(json){
            
            Date.prototype.format = function(f) {
                if (!this.valueOf()) return " ";
             
                var weekName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
                var d = this;
                 
                return f.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|a\/p)/gi, function($1) {
                    switch ($1) {
                        case "yyyy": return d.getFullYear();
                        case "yy": return (d.getFullYear() % 1000).zf(2);
                        case "MM": return (d.getMonth() + 1).zf(2);
                        case "dd": return d.getDate().zf(2);
                        case "E": return weekName[d.getDay()];
                        case "HH": return d.getHours().zf(2);
                        case "hh": return d.getHours().zf(2);
                        case "mm": return d.getMinutes().zf(2);
                        case "ss": return d.getSeconds().zf(2);
                        case "a/p": return d.getHours() < 12 ? "오전" : "오후";
                        default: return $1;
                    }
                });
            };

            String.prototype.string = function(len){var s = '', i = 0; while (i++ < len) { s += this; } return s;};
            String.prototype.zf = function(len){return "0".string(len - this.length) + this;};
            Number.prototype.zf = function(len){return this.toString().zf(len);};
            
            var today = new Date().format("yyyyMMddhhmm");
            today = today * 1;
            
//          var today = "201609010000";
            
            var template = "";
            
            if(json.planList){
                for(var i=0;i<json.planList.length;i++){
                    if((agentCheck=="I" && json.planList[i].iosYN == "N") || (agentCheck=="A" && json.planList[i].androidYN == "N")){
                        continue;
                    }  
                    if(json.planList[i].event_yn == "Y" && json.planList[i].startDate == "" && json.planList[i].endDate == ""){
                        template += "<li>";
	                        template += "<a href=\"javascript:goEventLink(\'"+json.planList[i].link+"\',\'"+json.planList[i].title+"\')\" >";
	                        	template += "<img src=\""+json.planList[i].imgSrc+"\" class=\"thum\"/>";
	                        	template += "<span><em>"+json.planList[i].title+"</em></span>";
	                        template += "</a>";
                        template += "</li>";
                        
                    }else{
                        if(json.planList[i].event_yn == "Y" && today > json.planList[i].startDate && today < json.planList[i].endDate){
                            template += "<li>";
	                            template += "<a href=\"javascript:goEventLink(\'"+json.planList[i].link+"\',\'"+json.planList[i].title+"\')\" >";
		                            template += "<img src=\""+json.planList[i].imgSrc+"\" class=\"thum\"/>";
		                            template += "<span><em>"+json.planList[i].title+"</em></span>";
	                            template += "</a>";
                            template += "</li>";
                        }
                    }
                }
            }
            $("#eventList").html(template);
            $(".winner").show();
            setDelay();
            
        }
    });
}
function goWonList(){
	ga('send', 'event', 'mf_plan_event', 'event', 'event_board');
	location.href = "/mobilefirst/event/eventWonList.jsp?before=Y";
}
function goPlanView(dataid , url){
	var goUrl = "/mobilefirst/planlist.jsp?t=B_"+dataid;
	
    ga('send', 'event', 'mf_plan_event', 'plan', 'plan_'+dataid);
    
    if(dataid == "20180410999999" || dataid.indexOf("999999") > -1 || dataid == "20190809408300"  ){
		goUrl = url;
	}
    location.href = goUrl;
    
	//if(dataid == '' ){
	//   ga('send', 'event', 'mf_plan_event', 'plan', "히트브랜드");
	//   goUrl = "/mobilefirst/event2016/hitBrand_201607.jsp";
	//   location.href = goUrl;
	//}else{
	//    ga('send', 'event', 'mf_plan_event', 'plan', 'plan_'+dataid);
    //    location.href = goUrl;
	//}
}
function goEventLink(link,title){
	ga('send', 'event', 'mf_plan_event', 'event', title);
	
	if(  link == ""){
		alert("이벤트 준비중 입니다.");
		return false;
	}else{
		location.href = link;
	}
}