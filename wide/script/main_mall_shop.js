$(document).ready(function(){
	//로고 타입
	$.ajax({
		url: "/main/main2018/ajax/logo_type.json",
		dataType: "json",
		cache: false,
		success: function(data) {
			//$(".popularmall_list > li").unbind(); //main_2018 수정하면 삭제

			for(var a=0; a<data.length; a++){
				var makeHtml = "";

				makeHtml += "<ul class=\"mall__list \" style=\"display:none\">"
					$.each(data[a],function(i,v){
						var logoImg = "";
						var pcUrl = v.pc_url.toString();
						if(v.s_logo) logoImg = v.s_logo;
						
						logoImg = logoImg.replace("storage.enuri.info/pic_upload/mall/logo/s_logo","storage.enuri.info/logo/logo20/logo_20");
						
						makeHtml += "<li><a href=\"/move/Simpleredirect.jsp?vcode="+v.shop_code+"\" onclick='insertLog(24385);'  target=\"_blank\"><img class='thum' src=\""+logoImg+"\" alt=\""+v.shop_name.toString()+"\"></a></li>";
					});
				makeHtml += "</ul>"

				$('.mallbox').append(makeHtml);
				$('.mall__list').eq(0).show();
			}
		},complete: function(){
			$("#shopPrevButton , #shopNextButton").click(function(){ //next,prev 버튼
				var $target = null;
				var $list = $(".mall__list");

				if($(this).attr("class").indexOf("next") > 0){
					$target = $(".mall__list:visible").next('ul');
				}else{
					$target = $(".mall__list:visible").prev('ul');
				}
				$list.hide();

				if($target.length > 0){
					$target.show();
				}else{
					if($(this).attr("class").indexOf("next") > 0){
						$list.eq(0).show();
					}else{
						$list.slice(-1).eq(0).show();
					}
				}
				insertLog(24386);
			});
/*
			$(".popularmall_list > li").click(function(){
				var src = $(this).find("img").attr("src");

					 if(src.indexOf("536") > -1 )  { insertLog(22276);}
				else if(src.indexOf("5910") > -1 ) { insertLog(22277);}
				else if(src.indexOf("4027") > -1 ) { insertLog(22278);}
				else if(src.indexOf("6508") > -1 ) { insertLog(22280);}
				else if(src.indexOf("6641") > -1 ) { insertLog(22281);}
				else if(src.indexOf("7861") > -1 ) { insertLog(22282);}
				else if(src.indexOf("7692") > -1 ) { insertLog(22283);}
				else if(src.indexOf("806") > -1 )  { insertLog(22287);}
				else if(src.indexOf("6588") > -1 ) { insertLog(22288);}
				else if(src.indexOf("9011") > -1 ) { insertLog(22289);}
				else if(src.indexOf("974") > -1 )  { insertLog(22290);}
				else if(src.indexOf("7935") > -1 ) { insertLog(22291);}
				else if(src.indexOf("7851") > -1 ) { insertLog(22294);}
				else if(src.indexOf("6547") > -1 ) { insertLog(22292);}
				else if(src.indexOf("6620") > -1 ) { insertLog(22296);}
				else if(src.indexOf("6252") > -1 ) { insertLog(22299);}
				else if(src.indexOf("7455") > -1 ) { insertLog(22300);}
				else if(src.indexOf("374") > -1 )  { insertLog(22301);}
				else if(src.indexOf("3336") > -1 ) { insertLog(22302);}
				else if(src.indexOf("6193") > -1 ) { insertLog(22303);}
				else if(src.indexOf("8380") > -1 ) { insertLog(22304);}
				else if(src.indexOf("6622") > -1 ) { insertLog(22305);}
				else if(src.indexOf("7870") > -1 ) { insertLog(22306);}
				else if(src.indexOf("6665") > -1 ) { insertLog(22307);}
				else if(src.indexOf("6389") > -1 ) { insertLog(22308);}
				else if(src.indexOf("6634") > -1 ) { insertLog(22309);}
				else if(src.indexOf("6644") > -1 ) { insertLog(22310);}
				else if(src.indexOf("7910") > -1 ) { insertLog(22311);}
				else if(src.indexOf("7908") > -1 ) { insertLog(22312);}
				else if(src.indexOf("8446") > -1 ) { insertLog(22313);}
				else if(src.indexOf("7857") > -1 ) { insertLog(22314);}
				else if(src.indexOf("8094") > -1 ) { insertLog(22315);}
				else if(src.indexOf("6095") > -1 ) { insertLog(22316);}
				else if(src.indexOf("7852") > -1 ) { insertLog(22317);}
				else if(src.indexOf("8032") > -1 ) { insertLog(22318);}
				else if(src.indexOf("6695") > -1 ) { insertLog(22319);}
				else if(src.indexOf("8090") > -1 ) { insertLog(22320);}
				else if(src.indexOf("6729") > -1 ) { insertLog(22321);}
				else if(src.indexOf("6603") > -1 ) { insertLog(22322);}
				else if(src.indexOf("7939") > -1 ) { insertLog(22323);}
				else if(src.indexOf("663") > -1 )  { insertLog(22284);}
				else if(src.indexOf("36") > -1 )   { insertLog(22298);}
				else if(src.indexOf("55") > -1 )   { insertLog(22279);}
				else if(src.indexOf("75") > -1 )   { insertLog(22285);}
				else if(src.indexOf("57") > -1 )   { insertLog(22286);}
				else if(src.indexOf("49") > -1 )   { insertLog(22292);}
				else if(src.indexOf("47") > -1 )   { insertLog(22293);}
			});
			*/
		}
		
	});
	

	//텍스트 타입
	$.ajax({
		url: "/main/main2018/ajax/text_type.json",
		dataType: "json",
		cache: false,
		success: function(data) {
			for(var b=0; b<data.length; b++){
				var makeHtml = "";
				var npay = "";

				$.each(data[b],function(i,v){
					var pcUrl = v.pc_url.toString();
					npay = (v.shop_type == "4") ? "ad_type_npay" : "";

					makeHtml += "<li><a href=\"/move/Simpleredirect.jsp?vcode="+v.shop_code+"\"  onclick='insertLog(24387);' target=\"_blank\"><em class=\""+npay+"\">"+v.shop_name+"</em></a></li>";
				});

				$('.catebox').eq(b).find('.cate__list').html(makeHtml);
			}
		}
	});
});