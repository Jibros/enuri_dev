( function( $ ) {
$( document ).ready(function() {
	$("body").on('click', '.all_view > .first > ul > li > ul > li > a', function(event) {
		
		$(".depth.third").empty();
		$(".depth.fourth").empty();
		
		$(".depth.second").find('li').removeClass('on');
		$(".depth.second").find('img').remove();
		
		$(".first").find('li').removeClass('on');
		$(this).parent().addClass("on");
		
		var seq = $.trim($(this).parent().attr('class').replace('on',''));
		
		$(".depth.second > ul").find('li').hide();
		
		$('.'+seq).show();
		
		setCookie('c1dept','',-1);
		setCookie("c1dept",$(this).parent().attr('id'));
	});
	$("body").on('click', '.depth.second > ul > li ', function(event) {
		var $this = $(this);
		
		$(".depth.second").find('li.on').removeClass('on').find('img').remove();
		
		//$this.addClass('on').find('a').append("<img src='http://imgenuri.enuri.gscdn.com/images/mobilefirst/g_arr.gif' />");
		$this.addClass('on');
		var seq = $this.attr('name');
		
		cate3View(seq);
		setCookie('c2dept','',-1);
		setCookie("c2dept",$this.attr("name"));
		$(".depth.third").scrollTop(0);
	});
	$("body").on('click', '.depth.third > ul > li', function(event) {
		
		try{
			var $this = $(this);
				
				$(".depth.third").find('li.on').removeClass('on').find('img').remove();
				
				var flag = $(event.target).parent().attr('class');
				flag = flag.substring(0,1);
				
				if (flag == 1){
					//$(event.target).parent().addClass('on').children().first().append("<img src='http://imgenuri.enuri.gscdn.com/images/mobilefirst/g_arr.gif' />");
					$(event.target).parent().addClass('on');
					
				}else if(flag == 2){
					$(event.target).parent().addClass('on');
		
				}else if(flag == 0){
					
					var url = $(event.target).parent().attr('name');
					var cateName = $(event.target).text();
					if(cateName == '전체상품보기'){
						location.href = $(event.target).attr('href');
						event.preventDefault();
						return false;
					}
					if(url.indexOf("http://") > -1){
						window.open(url);
						event.preventDefault();
						return false;
					}
					//$(this).addClass('on').find('a').first().append("<img src='http://imgenuri.enuri.gscdn.com/images/mobilefirst/g_arr.gif' />");
					$(this).addClass('on');
				}
				
				var cate = $(event.target).parent().attr('name');
				var cateName = $(event.target).text();
				var tempCate = cate.substring(0,4);
				
				if(tempCate == 1482 || tempCate == 1483 || tempCate == 1484 || tempCate == 1485){
					
					$(".depth.fourth").empty();
					$(".depth.fourth").html("<ul><li name='"+cate+"'  class='all'><a href='/mobilefirst/list.jsp?cate="+cate+"'> 전체카테고리</li></ul>");
					
				}else{
					
					//(여행사, 꽃배달, pc견적) 이동일 경우 4 dept 오픈 하지 않고  바로 이동 해준다.
					if(cate == 19100 || cate == 11650 || cate == 11600 || cate == 10400){
						
					}else{
						if(flag == 0 || flag == 2)	cate4View0_2(cate,flag,cateName);	
						else cate4View1(cate,flag,cateName);
					}
				}
				$(".depth.fourth").scrollTop(0);
		}catch(e){
			console.log(e);
		}
	});
	$("body").on('click', '.depth.fourth > ul > li', function(e) {

        var parentCate = $(this).attr("data-parent");
		var goUrl = "/mobilefirst/list.jsp?cate=";
		var dataid = $(e.target).parent().attr('data-id');
		
		var tempArray = dataid.split('_'); 	
		var cateNo = tempArray[0];
		var noneCate = tempArray[1];
		
		if(noneCate == 1){
		}else{
			if(noneCate == '4') ga('send', 'event', 'mf_common', 'gnb_소카테전체', 'type_curtain');
			else				ga('send', 'event', 'mf_common', 'gnb_미카테클릭', 'type_curtain');
			//연령별 추천 완구 임시 예외처리
			if(cateNo == '101447') return false;
			
			//앱에서 parent 코드가 잘못되서 수정함 2018-10-22 노병원
			try{
				if(parentCate.length > 5)				parentCate = parentCate.substr(0,5);
				location.href = goUrl+cateNo+"&parent="+parentCate;	
			}catch(e){
				location.href = goUrl+cateNo;
			}
		} 
	});
	//여행 사이트 이동
	goTourSite = function goTourSite(url){ window.open(url); };
	//4dept 이동 카테고리 클릭이동 여부 0 , 1
	goMoveList = function (cate,nonclick_cate){
		
		var goUrl = "/mobilefirst/list.jsp?cate=";
		
		if(nonclick_cate == 1){
		}else{
			if(nonclick_cate == '4') 				ga('send', 'event', 'mf_common', 'gnb_소카테전체', 'type_curtain');
			else				ga('send', 'event', 'mf_common', 'gnb_미카테클릭', 'type_curtain');
			location.href = goUrl+cate;
		}
	};
	goAll3cate = function (cate){
		ga('send', 'event', 'mf_common', 'gnb_중카테전체', 'type_curtain');
		
		if(cate.indexOf("http://") > -1 || cate.indexOf("https://") > -1){
			window.open(cate);
			return false;
		}
		location.href = "/mobilefirst/list.jsp?cate="+cate;
	};
	//카테고리 구분값 0 or 2 일 경우
	function cate4View0_2(cate,selFlag,cateName){
		
		loadUrl = "/mobilefirst/ajax/gnb/ajax_to_json_5category.jsp?cate="+cate+"&flag="+selFlag;
		
		$(".depth.fourth").empty();
		var makeHtml = "";
		
		$.ajax({
					url: loadUrl,
					dataType: 'json',
					async: false,
					success: function(json){
						var flag = 0;
						cnt = 0;
						if (json) {
							
							makeHtml += "<ul>";
							$.each(json , function(i,v){
								cnt++;
								if(i == 0){
									makeHtml += "<li class='"+v.m_group_flag+" dot_down' data-id='"+cate+"_4' ><a href='javascript:///' class='all'>전체상품보기</a></li>";										
								}
								
								var g_seqno = v.g_seqno.toString();
								var g_seq =  g_seqno.substring(1,g_seqno.length);
								var g_name = $.trim(v.g_name).replace('@','');
								var g_parent = $.trim(v.g_parent);
								
								if(v.p_seqno == 1 ){
									makeHtml += "<li class='"+v.m_group_flag+"' data-parent='"+g_parent+"' data-id='"+v.p_code+"_' ><a href='javascript:///' >"+v.p_name+"↓</a></li>";
								}
								if(v.m_group_flag == 0){
									
									if(flag == 2) makeHtml += "</ul>";
									
									makeHtml += "<li class='"+v.m_group_flag+"' data-parent='"+g_parent+"' data-id='"+v.g_cate+"_' ><a href='javascript:///' >■"+g_name+"</a></li>";
									
								}else if(v.m_group_flag == 1){
									
									var color = "";
									
									if(v.nonclick_cate == "1") color = "style='color:#616161'";
									
									if(flag == 1){
										makeHtml += "<li class='"+v.m_group_flag+"' data-parent='"+g_parent+"'  id='flag1' data-id='"+v.g_cate+"_"+v.nonclick_cate+"' ><a href='javascript:///' "+color+">"+g_name+"↓</a></li>";													
									} else if (flag == 2){
										makeHtml += "</ul>";
										makeHtml += "<li class='"+v.m_group_flag+"'  data-parent='"+g_parent+"' id='flag1' data-id='"+v.g_cate+"_"+v.nonclick_cate+"' ><a href='javascript:///' "+color+">■"+g_name+"</a>";
									} else {
										makeHtml += "<li class='"+v.m_group_flag+"' data-parent='"+g_parent+"'  id='flag1' data-id='"+v.g_cate+"_"+v.nonclick_cate+"' ><a href='javascript:///' "+color+">■"+g_name+"</a>";
									}
									
								}else if(v.m_group_flag == 2 ){
									
									if(flag == 1) makeHtml +="<ul>";	
									makeHtml += "<li class='"+v.m_group_flag+"' data-parent='"+g_parent+"'  data-id='"+v.g_cate+"_"+v.nonclick_cate+"' ><a href='javascript:///' >"+g_name+"</a></li>";
								}
								flag = v.m_group_flag;
							});
							
							if(cnt > 0){
								makeHtml += "</ul>";
								$(".depth.fourth").append(makeHtml);
							}else{
								$(".depth.fourth").children().remove();
								$(".depth.fourth").html("<ul><li class='dot_down' data-id='"+cate+"'_'4' ><a href='javascript:///' class='all'>전체상품보기</a></li></ul>");
							}
						}
					}
			});
	}
	/* 정상본 백업
	 
	function cate4View0_2(cate,selFlag,cateName){
		
		loadUrl = "/mobilefirst/ajax/gnb/ajax_to_json_5category.jsp?cate="+cate+"&flag="+selFlag;
		
		$(".depth.fourth").empty();
		
		var makeHtml = "";
		
		$.ajax({
					url: loadUrl,
					dataType: 'json',
					async: false,
					success: function(json){
						
						var flag = 0;
						cnt = 0;
						
						if (json) {
							
							makeHtml += "<ul>";
							$.each(json , function(i,v){
								cnt++;
								
								if(i == 0){
									makeHtml += "<li class='"+v.m_group_flag+" dot_down' name='"+cate+"' onclick = \"goMoveList('"+cate+"','4')\"><a href='javascript:///' class='all'>전체상품보기</a></li>";										
								}
								
								
								var g_seqno = v.g_seqno.toString();
								var g_seq =  g_seqno.substring(1,g_seqno.length);
								var g_name = $.trim(v.g_name).replace('@','');
								
								if(v.p_seqno == 1 ){
									makeHtml += "<li class='"+v.m_group_flag+"' name='"+v.p_code+"' onclick = \"goMoveList('"+v.p_code+"','')\"><a href='javascript:///' >"+v.p_name+"↓</a></li>";
								}
								
								if(v.m_group_flag == 0){
									
									if(flag == 2){
										makeHtml += "</ul>";
									}
									
									makeHtml += "<li class='"+v.m_group_flag+"' name='"+g_seq+"' onclick = \"goMoveList('"+v.g_cate+"','') \"><a href='javascript:///' >■"+g_name+"</a></li>";
									
									
								}else if(v.m_group_flag == 1){
									
									var color = "";
									
									if(v.nonclick_cate == "1"){
										color = "style='color:#616161'";
									}
									
									if(flag == 1){
										makeHtml += "<li class='"+v.m_group_flag+"' name='"+g_seq+"' id='flag1' onclick = \"goMoveList('"+v.g_cate+"','"+v.nonclick_cate+"')\"><a href='javascript:///' "+color+">"+g_name+"↓</a></li>";													
									} else if (flag == 2){
										makeHtml += "</ul>";
										makeHtml += "<li class='"+v.m_group_flag+"' name='"+g_seq+"' id='flag1' onclick = \"goMoveList('"+v.g_cate+"','"+v.nonclick_cate+"')\"><a href='javascript:///' "+color+">■"+g_name+"</a>";
									} else {
										makeHtml += "<li class='"+v.m_group_flag+"' name='"+g_seq+"' id='flag1' onclick = \"goMoveList('"+v.g_cate+"','"+v.nonclick_cate+"')\"><a href='javascript:///' "+color+">■"+g_name+"</a>";
									}
									
								}else if(v.m_group_flag == 2 ){
									
									if(flag == 1){
									makeHtml +="<ul>";	
									}
									makeHtml += "<li class='"+v.m_group_flag+"' name='"+g_seq+"' onclick = \"goMoveList('"+v.g_cate+"','')\"><a href='javascript:///' >"+g_name+"</a></li>";
									
								}
								
									
								flag = v.m_group_flag;
										
								
							});
							
							if(cnt > 0){
								
								makeHtml += "</ul>";
								$(".depth.fourth").append(makeHtml);
																	
							}else{
								
								$(".depth.fourth").children().remove();
								$(".depth.fourth").html("<ul><li class='dot_down' onclick = \"goMoveList('"+cate+"','4') \"><a href='javascript:///' class='all'>전체상품보기</a></li></ul>");
							}
							
						}
						
					}
			});
	}
	*/
	function cate4View1(cate,selFlag,cateName){
		
		loadUrl = "/mobilefirst/ajax/gnb/ajax_to_json_5category.jsp?cate="+cate+"&flag="+selFlag;
		$(".depth.fourth").empty();
		var makeHtml = "";
		
		$.ajax({
					url: loadUrl,
					dataType: 'json',
					async: false,
					success: function(json){
						
						var flag = 0;
						cnt = 0;
						
						if (json) {
							
							makeHtml += "<ul>";
							$.each(json , function(i,v){
								cnt++;
								
								var g_name = $.trim(v.g_name).replace('@','');
								var g_seqno = v.g_seqno.toString();
								var g_seq =  g_seqno.substring(1,g_seqno.length);
								var o_seqno = v.o_seqno.toString();
								var oseqno = o_seqno.substring(o_seqno.length-2,o_seqno.length); 
								
								var g_parent = $.trim(v.g_parent);
								
								if(typeof g_parent == "undefined")  g_parent = "";
								
								if(i == 0){
									
									makeHtml += "<li class='"+v.m_group_flag+"' data-parent='"+g_parent+"'  data-id='"+cate+"_4' ><a href='javascript:///' class='all'>전체상품보기</a></li>";
									
									if(cateName != g_name.replace("<br>","")){
										makeHtml += "<li data-parent='"+g_parent+"' class='"+v.m_group_flag+" dot' data-id='"+v.g_cate+"_' ><a href='javascript:///' >"+g_name+"↓</a></li>";
									}
										
								}else{
									
									if (oseqno ==  '00'){
									
										if(flag == 2) makeHtml += "</ul>";
										makeHtml += "<li data-parent='"+g_parent+"'  class='"+v.m_group_flag+" dot' data-id='"+v.p_code+"_' ><a href='javascript:///' >"+g_name+"↓</a></li>";
									
									}else{
										if(v.m_group_flag == 0){
											
											if(flag == 2) makeHtml += "</ul>";
											makeHtml += "<li class='"+v.m_group_flag+"' data-parent='"+g_parent+"'   data-id='"+v.g_cate+"_'  ><a href='javascript:///' >■"+g_name+"</a></li>";
											
										}else if(v.m_group_flag == 1){
											
											var color = "";
											
											if(v.nonclick_cate == "1"){
												color = "style='color:#616161'";
											}
											
											if(flag == 1){
												makeHtml += "<li class='"+v.m_group_flag+" dot' data-id='"+v.g_cate+"_"+v.nonclick_cate+"'  data-parent='"+g_parent+"'><a href='javascript:///' "+color+">"+g_name+"↓</a></li>";													
											} else if (flag == 2){
												makeHtml += "</ul>";
												makeHtml += "<li class='"+v.m_group_flag+"' data-id='"+v.g_cate+"_"+v.nonclick_cate+"' data-parent='"+g_parent+"' ><a href='javascript:///' "+color+">■"+g_name+"</a>";
											} else {
												makeHtml += "<li class='"+v.m_group_flag+"' data-id='"+v.g_cate+"_"+v.nonclick_cate+"' data-parent='"+g_parent+"' ><a href='javascript:///' "+color+">■"+g_name+"</a>";
											}
											
										}else if(v.m_group_flag == 2 ){
											
											if(flag == 1){
											makeHtml +="<ul>";	
											}
											makeHtml += "<li class='"+v.m_group_flag+"' data-parent='"+g_parent+"'  data-id='"+v.g_cate+"_' ><a href='javascript:///' >"+g_name+"</a></li>";
											
										}
									}
								}
								flag = v.m_group_flag;
							});
							if(cnt > 0){
								makeHtml += "</ul>";
								$(".depth.fourth").append(makeHtml);
																	
							}else{
								$(".depth.fourth").children().remove();
								$(".depth.fourth").html("<ul><li data-id='"+cate+"_4' ><a href='javascript:///' class='all' >전체상품보기</a></li></ul>");
							}
						}
					}
			});
	}
/*
	function cate4View1(cate,selFlag,cateName){
		
		loadUrl = "/mobilefirst/ajax/gnb/ajax_to_json_5category.jsp?cate="+cate+"&flag="+selFlag;
		
		$(".depth.fourth").empty();
		
		var makeHtml = "";
		
		$.ajax({
					url: loadUrl,
					dataType: 'json',
					async: false,
					success: function(json){
						
						var flag = 0;
						cnt = 0;
						
						if (json) {
							
							makeHtml += "<ul>";
							$.each(json , function(i,v){
								cnt++;
								
								var g_name = $.trim(v.g_name).replace('@','');
								var g_seqno = v.g_seqno.toString();
								var g_seq =  g_seqno.substring(1,g_seqno.length);
								var o_seqno = v.o_seqno.toString();
								var oseqno = o_seqno.substring(o_seqno.length-2,o_seqno.length); 
								
								if(i == 0){

									makeHtml += "<li class='"+v.m_group_flag+" dot_down' name='"+cate+"' onclick = \"goMoveList('"+cate+"','4')\"><a href='javascript:///' class='all'>전체상품보기</a></li>";
									if(cateName != g_name.replace("<br>","")){
										makeHtml += "<li class='"+v.m_group_flag+" dot' data-id='"+v.g_cate+"_' ><a href='javascript:///' >"+g_name+"↓</a></li>";
									}
										
								}else{
									
									if (oseqno ==  '00'){
									
										if(flag == 2){
											makeHtml += "</ul>";
										}
									
										makeHtml += "<li class='"+v.m_group_flag+" dot' name='"+v.p_code+"' onclick = \"goMoveList('"+v.p_code+"','')\" ><a href='javascript:///' >"+g_name+"↓</a></li>";
									
									}else{
										
										if(v.m_group_flag == 0){
											
											if(flag == 2){
												makeHtml += "</ul>";
											}
											
											makeHtml += "<li class='"+v.m_group_flag+"' name='"+g_seq+"' onclick = \"goMoveList('"+v.g_cate+"','')\" ><a href='javascript:///' >■"+g_name+"</a></li>";
											
											
										}else if(v.m_group_flag == 1){
											
											var color = "";
											
											if(v.nonclick_cate == "1"){
												color = "style='color:#616161'";
											}
											
											if(flag == 1){
												makeHtml += "<li class='"+v.m_group_flag+" dot' name='"+g_seq+"' onclick = \"goMoveList('"+v.g_cate+"','"+v.nonclick_cate+"')\" ><a href='javascript:///' "+color+">"+g_name+"↓</a></li>";													
											} else if (flag == 2){
												makeHtml += "</ul>";
												makeHtml += "<li class='"+v.m_group_flag+"' name='"+g_seq+"' onclick = \"goMoveList('"+v.g_cate+"','"+v.nonclick_cate+"')\" ><a href='javascript:///' "+color+">■"+g_name+"</a>";
											} else {
												makeHtml += "<li class='"+v.m_group_flag+"' name='"+g_seq+"' onclick = \"goMoveList('"+v.g_cate+"','"+v.nonclick_cate+"')\" ><a href='javascript:///' "+color+">■"+g_name+"</a>";
											}
											
										}else if(v.m_group_flag == 2 ){
											
											if(flag == 1){
											makeHtml +="<ul>";	
											}
											makeHtml += "<li class='"+v.m_group_flag+"' name='"+g_seq+"' onclick = \"goMoveList('"+v.g_cate+"','')\"><a href='javascript:///' >"+g_name+"</a></li>";
											
										}
										
										
									}
									
								}
									
								flag = v.m_group_flag;
								
							});
							
							if(cnt > 0){
								
								makeHtml += "</ul>";
								$(".depth.fourth").append(makeHtml);
																	
							}else{
								
								$(".depth.fourth").children().remove();
								$(".depth.fourth").html("<ul><li onclick = \"goMoveList('"+cate+"','4')\"><a href='javascript:///' class='all' >전체보기</a></li></ul>");
							}
							
						}
						
					}
			});

			
	}
*/
	function cate3View(temp_key){
		
		loadUrl = "/mobilefirst/gnb/category/fourLevel.json";
		
		$(".depth.third").empty();
		$(".depth.fourth").empty();
		
		if(temp_key == "11650") {
			var temp = "<ul><li class='0 dot_down' name='"+temp_key+"' ><a href=\"javascript:goAll3cate('1650')\" class='all'>전체상품보기</a></li></ul>";
			$(".depth.third").append(temp);
			return false;
		}
		
		$.ajax({
					url: loadUrl,
					dataType: 'json',
					async: false,
					success: function(json){
						
						var result = false;
						var makeHtml = "";
						
						var flag = 0;
						
						if (json) {
							makeHtml += "<ul>";
							$.each(json , function(i,v){
								
								if(v.g_parent == temp_key){
									
									var g_name = $.trim(v.g_name).replace('@','');
																
									var g_seqno = v.g_seqno.toString(); 
									var g_seq =  g_seqno.substring(1,g_seqno.length);
										
										if('전체상품보기' == g_name ){
											if(g_seqno == '11600' || g_seqno == '10400'){//꽃배달
												makeHtml += "<li class='"+v.m_group_flag+" dot_down' name='"+g_seq+"' ><a href=\"javascript:goTourSite('"+v.g_cate+"')\" class='all' >전체상품보기</a></li>";
											}else{
												makeHtml += "<li class='"+v.m_group_flag+" dot_down' name='"+g_seq+"' ><a href=\"javascript:goAll3cate('"+v.g_cate+"')\" class='all' >전체상품보기</a></li>";	
											}
												
										}else if(v.m_group_flag == 0){
											
											if(flag == 2){
												makeHtml += "</ul>";
											}
											
											if(g_seqno == '19100' || g_seqno == '11600' || g_seqno == '10400'){ //여행사 , pc 견적은
												makeHtml += "<li class='"+v.m_group_flag+"' name='"+g_seqno+"' onclick='goTourSite(\""+$.trim(v.g_cate)+"\")' ><a href='javascript:///' >"+g_name+"</a></li>";
											}else{
												makeHtml += "<li class='"+v.m_group_flag+"' name='"+g_seq+"' ><a href='javascript:///' >"+g_name+"</a></li>";
											}
											
										}else if(v.m_group_flag == 1){
											
											if(flag == 1){
												makeHtml += "<li class='"+v.m_group_flag+"' name='"+g_seq+"' id='flag1'><a href='javascript:///' >"+g_name+"</a></li>";													
											} else if (flag == 2){
												makeHtml += "</ul>";
												makeHtml += "<li class='"+v.m_group_flag+"' name='"+g_seq+"' id='flag1'><a href='javascript:///' >"+g_name+"</a>";
											} else {
												makeHtml += "<li class='"+v.m_group_flag+"' name='"+g_seq+"' id='flag1'><a href='javascript:///' >"+g_name+"</a>";
											}
											
										}else if(v.m_group_flag == 2){
											if(flag == 1){
											makeHtml +="<ul>";	
											}
											makeHtml += "<li class='"+v.m_group_flag+"' name='"+g_seq+"'><a href='javascript:///' >"+g_name+"</a></li>";
										}
										flag = v.m_group_flag;
									}
							});
							makeHtml += "</ul>";
							$(".depth.third").append(makeHtml);
						}
					}
			});
	}
});
} )( jQuery );