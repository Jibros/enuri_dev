
$(document).ready(function(){	
		//미분류 클릭시
		var gnb_dcate;

		 
		$("body").on("click","#prodCategory ul li a", function(){
			ga('send', 'event', 'mf_lp', ' click_소카테고리', 'click_소카테고리');
			var cate = $(this).attr("cate");
			
			var sub_cate = $("#sub_cate");
			var sub_cate2 = $("#sub_cate").val();
			var lay = $(this);

			var ca_code = $("#cate").val();

			if(cate=="101447"){ 
				return;
			} 
			
			/*
			if(fashion_cate.contains(cate)){
				ar.indexOf("cd", 2); 
			} 
			*/
			if( typeof(sub_cate) == "undefined" || sub_cate == "" ){
				
				if(gnb_dcate == cate){ $(".detail-menu").remove(); gnb_dcate = ''; lay.parent().removeClass('on'); return; }
			
				$(".detail-menu").remove();

				$("#prodCategory ul li").each(function(){
					$(this).removeClass('on');	
				});
				
				if(cate){
					var cate_tmp = cate;
					
					if(cate == "092101"){ 
						cate_tmp = "145504";
					}
					var loadUrl = "/mobilenew/ajax/menu/dcateLayer_ajax.jsp?cate="+cate_tmp;

					$.ajax({
					url: loadUrl,
					success: function(data){
						if(data.length > 20){
							var vTmp = "";
							vTmp = "<div class='detail-menu'>";
							vTmp += "<button class=\"btn-blue-type\" onclick=\"goCategory('"+cate_tmp+"','')\">전체상품보기 (<span id=\"dcate_cnt_"+cate+"\"></span>)</button>";
							vTmp += data;
							vTmp += "</div>";
							lay.after(vTmp);
							lay.parent().addClass('on');
						}else{ 
							goCategory(cate_tmp,'');
						} 
						
						getDcateCnt(cate,cate_tmp);					
					}
					});
					
				}
				gnb_dcate = cate;

			}else{
 
				if(ca_code.length > 5){  
					if(sub_cate2.length > 0){
						location.href = "/mobilefirst/list.jsp?cate="+ca_code+sub_cate2;	
					}else{
							location.href = "/mobilefirst/list.jsp?cate="+cate;
					}
				}else{
					//location.href = "/mobilefirst/list.jsp?cate="+cate+"&sub_cate="+sub_cate;
					location.href = "/mobilefirst/list.jsp?cate="+cate;	
				}
				
			}
		});
				
	
	});
	
	insertLog('11077'); 
	
	var lcate = "<%=strCate2%>";
	var catelistCnt = 0;
	
	
	if(lcate.length > 0){
		if(lcate == "02" || lcate == "03" || lcate == "04" || lcate == "05" || lcate == "06" || lcate == "07" || lcate == "12" || lcate == "21" || lcate == "22" || lcate == "24" ){
			insertLog('11078');
		}else if(lcate == "08" || lcate == "09" || lcate == "10" || lcate == "14" || lcate == "15" || lcate == "16" || lcate == "18" || lcate == "23" ){
			insertLog('11079');
		}
	}

		
	function CmdBottomMenu(param){
		if(param == 1){
			$(".newquick").hide();
		}else if (param==2){
			$(".newquick").show();
		}
	}   	 
	
	//소분류일때 하위에 미분류레이어 보여주기
	function CmdDcateLayer(cate,cate2){
		if(cate){
			var cate_tmp = cate;
			
			if(cate == "092101"){ 
				cate_tmp = "145504";
			} 
			var loadUrl = "/lsv2016/ajax/getCateLayer_ajax.jsp?procType=1&deviceType=2&cateList="+cate_tmp;		
			
			$.ajax({  
			url: loadUrl, 
			dataType:"JSON", 
			success: function(data){ 
				if(data.cateLayerList && data.cateLayerList.length > 0){
					if(data.cateLayerList[0].layer_html.length > 0){
						var vTmp = ""; 
						vTmp = "<div class='catebox_layer'>";
						vTmp += data.cateLayerList[0].layer_html;
						vTmp += "</div>"; 
						$("#prodCategory ul").after(vTmp);
						
						$('#prodCategory .catebox_layer td').each(function(n, v){
							if($(this).attr("linkcate") == $("#cate").val()){
								$(this).css("color", "#ff0000");
							}
						});  
						$('#prodCategory').addClass("cen");
						
						$('#prodCategory .catebox_layer td').click(function(){
							var linkcate = $(this).attr("linkcate");
							var cate = $("#cate").val(); 
							var linkname = $(this).html();
							linkname = linkname.split(" ").join("");
							linkname = linkname.split("\r").join("");
							linkname = linkname.split("\n").join("");
							
							if(linkcate != cate && linkcate != null && linkname != null && linkname != "&nbsp;"){
								goCategory(linkcate,'');
							} 
						}); 
					}
				}else{
					$(".prodCategory").hide();
					$('#prodCategory').removeClass("cen");
				}
				/*if(data.length > 20){
					var vTmp = "";
					vTmp = "<div class='detail-menu'>";
					//vTmp += "<button class=\"btn-blue-type\" onclick=\"goCategory('"+cate_tmp+"','')\">전체상품보기 (<span id=\"dcate_cnt_"+cate+"\"></span>)</button>";
					vTmp += data;
					vTmp += "</div>";
	
					$("#prodCategory ul").after(vTmp);
					if(cate2.length == 8){
						$("#dlink_"+cate2).css("color","#ff0000");
					}
					getDcateCnt(cate,cate_tmp);	
				}	*/			
			}
			});
			
		}
	}
	
	function CmdDcateLayer_old(cate,cate2){
		if(cate){
			var cate_tmp = cate;
			
			if(cate == "092101"){ 
				cate_tmp = "145504";
			} 
			
			var loadUrl = "/mobilenew/ajax/menu/dcateLayer_ajax.jsp?cate="+cate_tmp;
			
			$.ajax({ 
			url: loadUrl,
			success: function(data){
				if(data.length > 20){
					var vTmp = "";
					vTmp = "<div class='detail-menu'>";
					//vTmp += "<button class=\"btn-blue-type\" onclick=\"goCategory('"+cate_tmp+"','')\">전체상품보기 (<span id=\"dcate_cnt_"+cate+"\"></span>)</button>";
					vTmp += data;
					vTmp += "</div>";
	
					$("#prodCategory ul").after(vTmp);
					if(cate2.length == 8){
						$("#dlink_"+cate2).css("color","#ff0000");
					}
					getDcateCnt(cate,cate_tmp);	
				}				
			}
			});
			
		}
	}
	
	//소분류 json 으로 가지고 오기
	function getCategoryJsonData(cateCode){
		
		var loadUrl = "";
		
		var ca_code = $("#cate").val();
		var sub_ca_code = $("#sub_cate").val();

		var nowUrl = document.location.href;

		var tmp_html = "";

	   /* if(ca_code.indexOf(1482) > -1 && nowUrl.indexOf("gseq=") > 0){//남성 브랜드 의류

	    	if(ca_code.length == 4){
	    		loadUrl = "/mobilenew/gnb/category/fashion_brand_1482.json";
	    	}else{
				loadUrl = "/mobilenew/ajax/gnb/ajax_to_json_brand_cate.jsp?cate="+ca_code;
	    	}
	   	
	    }else if(ca_code.indexOf(1483) > -1 && nowUrl.indexOf("gseq=") > 0){ //여성 브랜드 의류
	    	
	    	if(ca_code.length == 4){
	    		loadUrl = "/mobilenew/gnb/category/fashion_brand_1483.json";
	    	}else{
				loadUrl = "/mobilenew/ajax/gnb/ajax_to_json_brand_cate.jsp?cate="+ca_code;
	    	}

	    }else if(ca_code.indexOf(1484) > -1 && nowUrl.indexOf("gseq=") > 0){
	    	
	    	if(ca_code.length == 4){
	    		loadUrl = "/mobilenew/gnb/category/fashion_brand_1484.json";
	    	}else{
				loadUrl = "/mobilenew/ajax/gnb/ajax_to_json_brand_cate.jsp?cate="+ca_code;
	    	}

	    }else if(ca_code.indexOf(1485) > -1 && nowUrl.indexOf("gseq=") > 0){
	    	
	    	if(ca_code.length == 4){
	    		loadUrl = "/mobilenew/gnb/category/fashion_brand_1485.json";
	    	}else{
				loadUrl = "/mobilenew/ajax/gnb/ajax_to_json_brand_cate.jsp?cate="+ca_code;
	    	} 
	    }else{
	    	loadUrl = "/mobilenew/ajax/gnb/ajax_to_json_4category.jsp?gseq="+$("#gseq").val();
	    }*/
	   	if(sub_ca_code.length >0){
	   		cateCode = cateCode + sub_ca_code;
	   	}
	   	 
	   	if(cateCode.length == 6 && (cateCode.substring(0,4) == "1471" || cateCode.substring(0,4) == "1472"  || cateCode.substring(0,4) == "1473")){
	   		loadUrl = "/mobilefirst/gnb/category/exLevel.jsp?cate="+cateCode;
	   	}else if(  (cateCode.substring(0,4) == "1482" || cateCode.substring(0,4) == "1483"  || cateCode.substring(0,4) == "1484" || cateCode.substring(0,4) == "1485") && ($("#from").val() =="search" || $("#from").val() =="vip")){
	   		loadUrl = "/mobilefirst/gnb/category/ajax_to_json_brand_cate.jsp?cate="+cateCode;
	   	}else{ 
		   	loadUrl = "/mobilefirst/gnb/category/fourLevel.json";
		} 
			$.ajax({  
					url: loadUrl,
					dataType: 'json',   
					async: false, 
					success: function(json){
						if (json) {  
							//카테코드가 6 자리 보다 크면 소분류를 나오지 않게 한다.
							//if(cateCode.length > 6){
							//	json = 0;
							//}else if(cateCode.length == 6){
							if(cateCode.length == 6 || cateCode.length == 8){ 
								if(cateCode.substring(0,4) == "1482" || cateCode.substring(0,4) == "1483"  || cateCode.substring(0,4) == "1484"  || cateCode.substring(0,4) == "1485" ){
								}else if(cateCode.substring(0,4) == "1471" || cateCode.substring(0,4) == "1472"  || cateCode.substring(0,4) == "1473"){
								}else{
									if(sub_ca_code.length > 0){ 
									}else{
										CmdDcateLayer(cateCode.substring(0,6),cateCode);
 									}
 								}
 							}
 							
 							//cateCode = cateCode.substring(0, cateCode.length-2);
 							
 							cateCode = "1"+cateCode;
 							if(sub_ca_code.length > 0){ 
 								cateCode = cateCode.substring(0,5);
 							} 
 							var cateName  = "";
 						
 							for(var i = 0; i < json.length; i++){
 								if(json[i].g_parent == cateCode){
 									if(json[i].g_name.indexOf("전체상품보기") > -1){
 									}else{
 										cateName = json[i].g_name;
 										cateName = cateName.replace("@","└ ");
 										cateName = cateName.replace(/<br>/gi,"");
 										cateName = cateName.replace(/,/gi,", ");
	 									tmp_html = tmp_html + "<li><a href=\"javascript:///\" cate=\""+json[i].g_cate+"\">"+cateName+"</a></li>";
 									}
 								}
 							} 
 
							$("#list_title_div").append(Mustache.render($('#gnb_list_template').html(), json));// 템플릿에 연동
							$("#prodCategory ul").append(tmp_html);
							
							var cnt = 0; 
							
							$('.prodCategory ul li').each(function(n, v){
								cnt++;
								//소분류 5개 까지만 노출한다.
								if (n > 4) {
									$(this).hide();
								}
							});
							//소분류가 5개 보다 작으면 더보기 버튼 삭제
							if (cnt <= 5) {
								$("#more").empty();
							}
							 
							var moreCnt = cnt - 5;
							 
							$("#more a").removeClass("on");
							$("#more a span").html(" 더보기 (" + 5 + "/" + cnt + ")");
							catelistCnt = cnt;							
							
							var goodsCnt = $(".prodSortOpt p").html();
							//$(".prodHead").children().html($("#catenm").val()+"<span id='goodsCnt'></span>");
							$("#cateName").text($("#catenm").val());
							$("#goodsCnt").text(" (" + goodsCnt + ")");
						}
					}

			});
	}
	//더보기
	function goMore(){
		$("#more a").attr("href","javascript:goClose()");
		$("#more a").addClass("on");
		$("#more a span").html(" 접기 (" + catelistCnt + "/" + catelistCnt + ")");
		$('.prodCategory ul li').show();
		
		ga('send', 'event', 'mf_lp', ' click_더보기', 'click_더보기');
		
		/*
		var nowUrl = document.URL;

		var ca_code = $("#cate").val();

		var gseqVal = $("#gseq").val();
		$("#list_title_div").empty();
		//var url = "/mobilenew/ajax/gnb/ajax_to_json_category.jsp";
		var loadUrl = "";
		var cnt = 0;
		
		if(nowUrl.indexOf(1482) > 0){//남성 브랜드 의류
	    	
	    	if(ca_code.length == 4){
	    		loadUrl = "/mobilenew/gnb/category/fashion_brand_1482.json";
	    	}else{
				loadUrl = "/mobilenew/ajax/gnb/ajax_to_json_brand_cate.jsp?cate="+ca_code;
	    	}

	    }else if(nowUrl.indexOf(1483) > 0){ //여성 브랜드 의류
			if(ca_code.length == 4){
	    		loadUrl = "/mobilenew/gnb/category/fashion_brand_1483.json";
	    	}else{
				loadUrl = "/mobilenew/ajax/gnb/ajax_to_json_brand_cate.jsp?cate="+ca_code;
	    	}
	    }else if(nowUrl.indexOf(1484) > 0){
	    	if(ca_code.length == 4){
	    		loadUrl = "/mobilenew/gnb/category/fashion_brand_1484.json";
	    	}else{
				loadUrl = "/mobilenew/ajax/gnb/ajax_to_json_brand_cate.jsp?cate="+ca_code;
	    	}
	    }else if(nowUrl.indexOf(1485) > 0){
	    	if(ca_code.length == 4){
	    		loadUrl = "/mobilenew/gnb/category/fashion_brand_1485.json";
	    	}else{
				loadUrl = "/mobilenew/ajax/gnb/ajax_to_json_brand_cate.jsp?cate="+ca_code;
	    	}
	    }else{
				loadUrl = "/mobilenew/ajax/gnb/ajax_to_json_4category.jsp?gseq="+$("#gseq").val();
	    }	

		$.getJSON(loadUrl, {gseq:gseqVal}, function(json, textStatus) {
			
			var catenm = $("#catenm").val();
			var prod = $(".prodSortOpt p").html();
					
			if (json){
				$("#list_title_div").append(Mustache.render($('#gnb_list_template').html(), json));// 템플릿에 연동
				//$(".more").remove();
			}
			 
			$('.prodCategory ul li').each(function(n, v){
				cnt++;
			});
			
			var goodsCnt = $(".prodSortOpt p").html();
			$(".prodHead").children().html($("#catenm").val()+"<span id='goodsCnt'></span>");
			$("#goodsCnt").text(" (" + goodsCnt + ")");
			
			$("#more a").attr("href","javascript:goClose()");
			$("#more a").addClass("on");
			$("#more a span").html(" 접기 (" + cnt + "/" + cnt + ")");

		});
		*/
	}

	function goClose(){
		/*var gseqVal = $("#gseq").val();
		$("#list_title_div").empty();
		getCategoryJsonData(gseqVal);*/
		
		$('.prodCategory ul li').each(function(n, v){
			if (n > 4) {
				$(this).hide();
			}
		});
		
		$("#more a").attr("href","javascript:goMore()");
		$("#more a").addClass("on");
		$("#more a span").html(" 더보기 (5/" + catelistCnt + ")");
	}
	function getDcateCnt(cate,cate_tmp){
		/*var vUrl_tmp = "/mobilefirst/ajax/listAjax/getList_ajax.jsp";
		
		if(cate_tmp.substring(0,4) == "1471" || cate_tmp.substring(0,4) == "1472" || cate_tmp.substring(0,4) == "1473"){
			vUrl_tmp = "/mobilefirst/ajax/listAjax/getList2_ajax.jsp";	
		}   
		$.ajax({
			type: "GET",
			url: vUrl_tmp,
			data:"cate="+cate_tmp+"&f=1",
			async: false,
			dataType:"JSON",
			success: function(json){
				var listCnt = "{{#goodsCnt}}{{cnt}}{{/goodsCnt}}";
				var listCntHtml = Mustache.to_html(listCnt, json);

				$("#dcate_cnt_"+cate).text(listCntHtml+"개");	 
			},
			error: function (xhr, ajaxOptions, thrownError) {
				//alert(xhr.status);
				//alert(thrownError);
			}
		});*/
	}
	function goCategory(cate){
		
		if(cate.length > 7){
			ga('send', 'event', 'category', 'tiny', 'cate_미분류');
		}else{
			ga('send', 'event', 'category', 'small', 'cate_소분류전체보기');	 
		}  
		 
		//if(cate == "10011602" )	{ cate = "14512001";	}
		//if(cate == "14570330" )	{ cate = "10011611";	}
		
		var var_redirect = goJumpCategory(cate);
	    
		if(	cate != var_redirect && var_redirect.length > 0){
			cate = var_redirect; 
		} 
		vParam = "";

		if($("#from")){
			vParam = "&from="+$("#from").val()+"&gseq=&skeyword="+$("#auto_keyword").val();
		}
		location.href = "/mobilefirst/list.jsp?cate="+cate+vParam;
	} 
	
    function goJumpCategory(cate){
		var tmpCate = ""; 
		
        if(cate == "14570709" ) {
            tmpCate = "10010810&in_keyword=%EC%9A%B0%EC%82%B0";
        }
        if(cate == "14540705" ) {
            tmpCate = "16351603";
        }
        if(cate == "09210404" ) {
            tmpCate = "14570108";
        }
        if(cate == "09210408" ) {
            tmpCate = "14570697";
        }
        if(cate == "09210308" ) {
            tmpCate = "14560304";
        } 
        if(cate == "02320701" ) {
            tmpCate = "023302";
        }
        if(cate == "02320702" ) {
            tmpCate = "023310";
        }
        if(cate == "02241006" ){ 
            tmpCate = "020123";
        }
        if(cate == "02420113" ){
            tmpCate = "0234"; 
        }
        if(cate == "02420214" ){
            tmpCate = "0232";
        }
        if(cate == "02420315" ){
            tmpCate = "023310";
        }
        if(cate == "02420412" ){
            tmpCate = "023302";
        }
        if(cate == "02320801" ){
            tmpCate = "023416";
        }
        if(cate == "02320802" ){
            tmpCate = "023417";
        }

        if(cate == "02320803" ){
            tmpCate = "023418";
        }
        if(cate == "02320804" ){
            tmpCate = "023419";
        }
        if(cate == "18010626" ){
            tmpCate = "182210";
        }
 
        if(cate == "18191400" ){ 
            tmpCate = "181914";
        }

        if(cate == "94181502" ){ 
            tmpCate = "1510";
        }

        if(cate == "18012202" ){ 
            tmpCate = "180303";
        }
        if(cate == "18012203" ){ 
            tmpCate = "180301";
        }
        if(cate == "18012204" ){ 
            tmpCate = "18030301";
        }
        if(cate == "18012205" ){ 
            tmpCate = "180302";
        }
        if(cate == "09052011" ){ 
            tmpCate = "09240611";
        }
        if(cate == "18012206" ){ 
            tmpCate = "18030302";
        }
        if(cate == "18012207" ){ 
            tmpCate = "180313";
        }
        if(cate == "12021507" ){ 
            tmpCate = "120828";
        }
        if(cate == "18012208" ){ 
            tmpCate = "180312";
        }
        if(cate == "18012209" ){ 
            tmpCate = "18030303";
        }
        if(cate == "05021603" ){ 
            tmpCate = "163206";
        }

        if (cate == "02151501"){
            tmpCate = "02132701";
        }  
        if (cate == "02151502"){
            tmpCate = "021314";
        }
        if (cate == "02151503"){
            tmpCate = "021315";
        }
        if (cate == "02151504") {
            tmpCate = "021319";
        }
        if (cate == "02240801") {
            tmpCate = "020810";
        }

        if (cate == "02240802") {
            tmpCate = "020816";
        }
        if (cate == "02240901") {
            tmpCate = "021511";
        }

        if (cate == "02240902") {
            tmpCate = "021518";
        }
        if (cate == "02240903") {
            tmpCate = "021513";
        }
        if (cate == "02240904") {
            tmpCate = "021507";
        }
        if(cate=="21041701") { tmpCate = "160204";  }
        if(cate=="21041702") { tmpCate = "160209";  }
        if(cate=="21041703") { tmpCate = "160210";  }
        if(cate=="21041704") { tmpCate = "160208";  }
        if(cate=="21041705") { tmpCate = "160207";  }
   		if(cate=="14540801") { tmpCate = "091901";  }
        if(cate=="14540802") { tmpCate = "091902";  }
        if(cate=="14540803") { tmpCate = "091914";  }
        if(cate=="14540804") { tmpCate = "091903";  }
        if(cate=="14540805") { tmpCate = "091911";  }
        if(cate=="14540806") { tmpCate = "091904";  }
        if(cate=="14540807") { tmpCate = "091509";  }
        if(cate=="14540808") { tmpCate = "091614";  }
        if(cate=="14540809") { tmpCate = "09143301";  }
        if(cate=="14540810") { tmpCate = "09140804";  }
        if(cate=="14540811") { tmpCate = "09143101";  }
        if(cate=="14540814") { tmpCate = "09140903";  }
        if(cate=="14540704") { tmpCate = "121512";  }
     // 휴대폰 바로 가기 모음 시작
        if(cate=="97161201") { tmpCate = "031901";  }
        if(cate=="97161202") { tmpCate = "031902";  }
        if(cate=="97161203") { tmpCate = "031903";  }
        if(cate=="97161204") { tmpCate = "031904";  }
        if(cate=="97161205") { tmpCate = "031905";  }
        if(cate=="97161206") { tmpCate = "031906";  }
        if(cate=="97161207") { tmpCate = "031907";  }
        if(cate=="97161208") { tmpCate = "031908";  }
        if(cate=="97161209") { tmpCate = "031909";  }
        if(cate=="97161210") { tmpCate = "031910";  }
        if(cate=="97200601") { tmpCate = "031901";  }
        if(cate=="97200602") { tmpCate = "031902";  }
        if(cate=="97200603") { tmpCate = "031903";  }
        if(cate=="97200604") { tmpCate = "031904";  }
        if(cate=="97200605") { tmpCate = "031905";  }
        if(cate=="97200606") { tmpCate = "031906";  }
        if(cate=="97200607") { tmpCate = "031907";  }
        if(cate=="97200608") { tmpCate = "031908";  }
        if(cate=="97200609") { tmpCate = "031909";  }
        if(cate=="97200610") { tmpCate = "031910";  }
        if(cate=="97200613") { tmpCate = "031911";  }
        if(cate=="97200614") { tmpCate = "03191101";  }
        if(cate=="97200615") { tmpCate = "03191102";  }
        if(cate=="97200616") { tmpCate = "03191103";  }
        if(cate=="97200617") { tmpCate = "03191106";  }
        if(cate=="97200619") { tmpCate = "031914";  }
    // 휴대폰 바로 가기 모음 끝
        // 자전거 부품
        if(cate=="09052003") { tmpCate = "092412";  }
        // 자전거 보호장비
        if(cate=="09052009") { tmpCate = "092413";  }

        if(cate=="10230701") { tmpCate = "100303";  }
        if(cate=="10230702") { tmpCate = "100316";  }
        if(cate=="10230703") { tmpCate = "100301";  }
        if(cate=="10230704") { tmpCate = "100310";  }
        if(cate=="10230705") { tmpCate = "100311";  }
        if(cate=="10230706") { tmpCate = "100308";  }
        if(cate=="10230707") { tmpCate = "100307";  }
        if(cate=="10230708") { tmpCate = "100318";  }
        if(cate=="10230709") { tmpCate = "100312";  }
        if(cate=="10240601") { tmpCate = "040812";  }
        if(cate=="10240602") { tmpCate = "040803";  }
        if(cate=="14550420") { tmpCate = "10010104";  }

        if (cate == "09240613"){
            tmpCate = "092003";
        }
        if (cate == "09240614"){
            tmpCate = "092004";
        }
        if (cate == "09270607"){
            tmpCate = "14570106";
        }
        if (cate == "09270609"){
            tmpCate = "14550307";
        }
        if (cate == "09040515"){
            tmpCate = "15010304";
        }

        if (cate == "09190512"){ 
            tmpCate = "14550304";
        }
        if (cate == "09270608"){
            tmpCate = "14570601";
        }

        if (cate == "02080708"){
            tmpCate = "0704";
        }
        if (cate == "02010804"){
            tmpCate = "970204";
        }

        if (cate == "04060502"){
            tmpCate = "03041402";
        }
        if (cate == "12191010"){
            tmpCate = "120517";
        }
        if (cate == "16930700"){
            tmpCate = "1598";
        }

        if (cate == "21061901"){
            tmpCate = "092015";
        }
        if (cate == "21061902"){
            tmpCate = "092003";
        }
        if (cate == "21061903"){
            tmpCate = "092007";
        }
        if (cate == "21061904"){
            tmpCate = "092004";
        }
        if (cate == "21061905"){
            tmpCate = "092011";
        }
        if (cate == "21061906") {
            tmpCate = "092010";
        }
        if (cate == "21061907"){
            tmpCate = "092006";
        }
        if (cate == "21061908"){
            tmpCate = "092002";
        }
        if (cate == "21061909"){
            tmpCate = "092005";
        }
        if (cate == "08130601"){
            tmpCate = "052101";
        }
        if (cate == "09290800"){
            tmpCate = "150103";
        }
        if (cate == "09041000"){
            tmpCate = "15010304";
        }
        if (cate == "97500300"){
            tmpCate = "975003";
        }
        if (cate == "97500400"){
            tmpCate = "975004";
        }
        if (cate == "97500500"){
            tmpCate = "975005";
        }
        if (cate == "97500600"){
            tmpCate = "975006";
        }
    	if (cate == "08130602"){
            tmpCate = "052102";
        }
        if (cate == "08130603"){
            tmpCate = "052103";
        }   
        if (cate == "09140101"){
            tmpCate = "091509";
        }   
        if (cate == "09140102"){
            tmpCate = "091510";
        }   
        if (cate == "09140103"){
            tmpCate = "091511";
        }   

        if (cate == "03042900"){
            tmpCate = "0305"; 
        }

        if(cate == "09040401") {
            tmpCate = "15010301";
        }
        if(cate == "09040402") {
            tmpCate = "15010304";
        }
        if(cate == "09121101") {
            tmpCate = "14020917";
        }
        if(cate == "09121102") {
            tmpCate = "14020918";
        }
        if(cate == "09121103") {
            tmpCate = "14030605";
        }   

        if(cate == "90050701") {
            tmpCate = "150105";
        }
        if(cate == "90050702") {
            tmpCate = "150101";
        }
        if(cate == "90050703") {
            tmpCate = "150102";
        }
		if(cate == "02120310") {
            tmpCate = "02170610";
        }
        if(cate == "03040608") {
            tmpCate = "021709";
        }   
        if(cate == "09291300") {
            tmpCate = "0904";
        }   
		if (cate == "02010914"){
            tmpCate = "040513";
        }
        if(cate == "02010805"){
            tmpCate = "040513"; 
        }
        if(cate == "02061008"){
            tmpCate = "021403";
        }
        if(cate == "97501604"){
            tmpCate = "0304";
        }
        if(cate == "97501605"){
            tmpCate = "0305";
        }
        if(cate == "02061009"){
            tmpCate = "021405";
        }
        if(cate == "02061025"){
            tmpCate = "04140204";
        }
        if(cate == "21080501"){
            tmpCate = "160204";
        }
        if(cate == "09040403"){
            top.insertLog(2905);
            tmpCate = "15010310";
        }
        if(cate == "09040404"){
            top.insertLog(2905);
            tmpCate = "080611";
        }
        if(cate == "09040405"){
            top.insertLog(2905);
            tmpCate = "091914";
        }
        if(cate == "10220801"){
            tmpCate = "100903";
        }
        if(cate == "10220802"){
            tmpCate = "100912";
        }
        if(cate == "10220803"){
            tmpCate = "100910";
        }
        if(cate == "10220804"){
            tmpCate = "100921";
        }
        if(cate == "10220805"){
            tmpCate = "100920";
        }
        if(cate == "10220806"){
            tmpCate = "100906";
        }
        if(cate == "10220807"){
            tmpCate = "100907";
        }
        if(cate == "05150305"){
            tmpCate = "051014";
        }
        if(cate == "05081401" ){
            tmpCate = "08070303";
        }
        if(cate == "05081402" ){   
            tmpCate = "08070301";
        }
        if(cate == "05081403" ){
            tmpCate = "08070305";
        }
        if(cate == "05081404" ){
            tmpCate = "08070302";
        }
        if(cate == "05081405" ){
            tmpCate = "08070304";
        }
        if(cate == "05210901" ){
            tmpCate = "080611";
        }
        if(cate == "05210902" ){
            tmpCate = "080612";
        }
        if(cate == "05210903" ){
            tmpCate = "080603";
        }   
        if(cate == "21050507") {
            tmpCate = "21030807";
        }   
        if(cate == "09032401"){
            tmpCate = "145404";
        }
        if(cate == "09031023"){
            tmpCate = "145404";
        }
        if(cate == "09032402"){
            tmpCate = "14540404";
        }
   		if(cate == "07090710"){
            tmpCate = "02081201";
        }
        if(cate == "07050510"){
            tmpCate = "04140204";
        }
         if(cate == "02250701"){
            tmpCate = "020902";
        }
        if(cate == "02250702"){
            tmpCate = "020910";
        }
	    if(cate == "02250801"){
            tmpCate = "022116";
        }
        if(cate == "02250802"){
            tmpCate = "022117";
        }
        if(cate == "02250803"){
            tmpCate = "022118";
        }
        if(cate == "02250804"){
            tmpCate = "022119";
        }
        if(cate == "09052010"){
            tmpCate = "09241401";
        }
  		if (cate == "10100901"){
            tmpCate = "100912";
        }
    	if(cate =="15011000" ){
            tmpCate = "150110";
        }
        if(cate == "05090708"){
            tmpCate = "022007";
        }   
  
        if(cate == "09031509"){
            tmpCate = "092009";
        }   
        if(cate == "09200904"){
            tmpCate = "145504";
        }   
        if(cate == "02120301" || cate == "02180601" ){
            tmpCate = "021709";
        }       
        if(cate == "02120302" || cate == "02180602" ){
            tmpCate = "021710";
        }
        if(cate == "02120303" || cate == "02180603" ){
            tmpCate = "021707";
        }
        if(cate == "02120306" || cate == "02180604" ){
             tmpCate = "021706";
        }
        if(cate == "02120305" || cate == "02180605" ){
            tmpCate = "021711";
         }
        if(cate == "02171108" ){
            tmpCate = "22112503";
        }
        if(cate == "09210901" ){
            tmpCate = "1809";
        }
        if(cate == "09210904" ){
            tmpCate = "0404";
        }
        if(cate == "09211004" ){
            tmpCate = "15110305";
        }

        if(cate == "09210804" ){
            tmpCate = "14550303";
        }
        if(cate == "09210608" ){
            tmpCate = "14550105";
        }
        if(cate == "09210906" ){
            tmpCate = "0206";
        }
        if(cate == "09210908" ){
            tmpCate = "0408";
        }
        if(cate == "09210909" ){
            tmpCate = "0209";
        }
        if(cate == "09210912" ){
            tmpCate = "0212";
        }
        if(cate == "09210918" ){
            tmpCate = "0218";
        }
        if(cate == "09210911" ){   
            tmpCate = "0511";
        }
        if( cate == "09210100"){
            tmpCate = "145504";
        }
        if(cate == "06051709" ){
            tmpCate = "062105";
        }
        if(cate == "09122401" ){
            tmpCate = "0923";
        }
        if(cate == "09032203" ){
            tmpCate = "092310";
        }
        if(cate == "09122402" ){
            tmpCate = "090108";
        }
        if(cate == "09122403" ){
            tmpCate = "092407";
        }
        if(cate == "09122404" ){
            tmpCate = "0913";
        }

        if(cate == "18900801" ){
            tmpCate = "04020702";
        }
        if(cate == "18900802" ){
            tmpCate = "04020701";
        }
 
        if(cate == "18900803" ){
            tmpCate = "04020703";
        }
        if(cate == "18900804" ){
            tmpCate = "04020704";
        }
        if(cate == "18900805" ){
            tmpCate = "04020705";
        }
        if(cate == "18900806" ){
            tmpCate = "04020706";
        }
        if(cate == "18900807" ){
            tmpCate = "04020707";
        }
        if(cate == "18900808" ){
            tmpCate = "04020708";
        }
        if(cate == "18900809" ){
            tmpCate = "04020709";
        }
         if(cate == "10190701" ){
            tmpCate = "040812";
        }
        if(cate == "10190702" ){
            tmpCate = "040803";
        }

        if(cate == "15081014" ){
            tmpCate = "1627";
        }

        if(cate == "94181510" ) {
            tmpCate = "1511";
        }
        if(cate == "94181501" ){
            tmpCate = "150102";
        }
        if(cate == "94181505" ){
            tmpCate = "151301";
        }
        if(cate == "05230901" ){
            tmpCate = "150105";
        }
        if(cate == "05230902" ){
            tmpCate = "15010114";
        }
        if(cate == "05230903" ){
            tmpCate = "15010113";
        }
        if(cate == "05230904" ){
            tmpCate = "15010123";
        }

        if(cate == "18901302" ){
            tmpCate = "15050102";
        }
        if(cate == "18901303" ){
            tmpCate = "15050105";
        }
        if(cate == "18901304" ){
            tmpCate = "150507";
        }
        if(cate == "18901305" ){
            tmpCate = "15050106";
        }
        if(cate == "18901306" ){
            tmpCate = "15080204";
        }
        if(cate == "18901307" ){
            tmpCate = "15080203";
        }
        if(cate == "18901308" ){
            tmpCate = "151301";
        }   
        if(cate == "14550413" ){
            tmpCate = "0921";
        }   
        if(cate == "14570608"){
            tmpCate = "0925";
        }   
        if(cate == "14570609"){
            tmpCate = "145906";
        }    

        if(cate == "02032401" ){
            tmpCate = "069204";
        }
        if(cate == "02032403" ){
            tmpCate = "06920201";
        }
        if(cate == "02032405" ){
            tmpCate = "06920218";
        }
        if(cate == "02032402" ){
            tmpCate = "069203";
        }
        if(cate == "02032404" ){
            tmpCate = "069207";
        }
        if(cate == "02032406" ){
            tmpCate = "069205";
        }  
        if(cate == "14550306" ){
            tmpCate = "09190509";
        }
 
        if(cate == "14570708" ){
            tmpCate = "09231012";
        }   
        if(cate == "09041409" ){
            tmpCate = "150103";
        }   
        if(cate == "09040907" ){
            tmpCate = "15010323";
        }   
        if(cate == "09041100"){
            tmpCate = "15010323";
        }   
    	if(cate == "10010706" ){ 
            tmpCate = "14511331";
        }
        if(cate == "10011602" ){ 
            tmpCate = "14512001";
        }
        if(cate == "10010707" ){
            tmpCate = "145209";
        }
    	if(cate == "06061401" ){
            tmpCate = "15050111";
        }
        if(cate == "06061402" ){
            tmpCate = "15050110";
        }   
        if(cate == "06061403" ){
            tmpCate = "15050103";
        }   
        if(cate == "06061404" ){
            tmpCate = "15050105";
        }   
        if(cate == "09210409" ){
            tmpCate = "14550307";
        }   
        if(cate == "10031509"){
            tmpCate = "14570310";
        }
        if(cate == "03281002" ){
            tmpCate = "15080805 ";
        }   
        if(cate == "03043901"){
            tmpCate = "031317";
        }   
        if(cate == "03043902"){
            tmpCate = "031314";
        }   
        if(cate == "03043903"){
            tmpCate = "031316";
        }   
        if(cate == "03043904"){
            tmpCate = "031318";
        }   
        if(cate == "03043906"){
            tmpCate = "031319";
        }   
        if(cate == "03043907"){
            tmpCate = "031315";
        }   
        if(cate == "03043908"){
            tmpCate = "031307";
        }   
        if(cate == "03043909"){
            tmpCate = "031313";
        }   
        if(cate == "03043910"){
            tmpCate = "031308";
        }   
        if(cate == "09210606"){
            tmpCate = "14550901";
        }        
        if(cate == "09210610"){
            tmpCate = "14550902";
        }   
        if(cate == "09210607"){
            tmpCate = "14550903";
        }   
        if(cate == "09210202"){ 
            tmpCate = "14550904";
        }   
        if(cate == "09210204"){
            tmpCate = "14550907";
        }   
        if(cate == "14550905"){
            tmpCate = "09210201";
        }   
        if(cate == "14550906"){
            tmpCate = "09210203";
        }   
        if(cate == "02011901"){
            tmpCate = "022413";
        }
        if(cate == "16381002" ){
            tmpCate = "15081301";
        }
        if(cate == "12281002" ){
            tmpCate = "15081301";
        }
        if(cate == "02241001"){
            tmpCate = "020103";
         }
        if(cate == "02241002"){
            tmpCate = "02010511";
         }
        if(cate == "02241003"){
            tmpCate = "02010541";
         }
        if(cate == "02241004"){
            tmpCate = "020115";
         }
        if(cate == "02241005"){
            tmpCate = "020116";
         }
        if(cate == "15091102"){
            tmpCate = "162208";
         }   
        if(cate == "03441101"){
            tmpCate = "033506";
         }   
        if(cate == "03441102"){
            tmpCate = "033507";
         }   

        if(cate == "03441103"){
            tmpCate = "033513";
         }   
        if(cate == "03431101"){ 
            tmpCate = "031323";
         }

        if(cate == "02420510"){ 
            tmpCate = "023526";
         }
        if(cate == "03431102"){ 
            tmpCate = "031324";
         }
        if(cate == "03431103"){ 
            tmpCate = "031308";
         }
        if(cate == "12021501"){ 
            tmpCate = "120802";
         }
        if(cate == "12021502"){ 
            tmpCate = "120803";
         }
        if(cate == "12021503"){ 
            tmpCate = "120817";
         }
        if(cate == "12021504"){ 
            tmpCate = "120818";
         }
        if(cate == "12021505"){ 
            tmpCate = "120812";
         }
        if(cate == "12021506"){ 
            tmpCate = "120816";
         }
        if(cate == "09082801"){ 
            tmpCate = "093001";
         }
        if(cate == "09082802"){ 
            tmpCate = "093006";
         }
        if(cate == "09082803"){ 
            tmpCate = "093011";
         }
        if(cate == "09082804"){ 
            tmpCate = "093007";
         }
        if(cate == "09082805"){ 
            tmpCate = "093005";
         }
        if(cate == "09082806"){ 
            tmpCate = "093008";
         }
        if(cate == "09080901"){ 
            tmpCate = "090813";
         }
        if(cate == "09080902"){ 
            tmpCate = "090825";
         }
        if(cate == "09080903"){ 
            tmpCate = "090822";
         }
        if(cate == "09080904"){ 
            tmpCate = "090826";
         }
        if(cate == "09080905"){ 
            tmpCate = "090823";
         }
        if(cate == "09080906"){ 
            tmpCate = "090827";
         }
        if(cate == "09080907"){ 
            tmpCate = "090824";
         }
        if(cate == "09300901"){ 
            tmpCate = "090813";
         }
        if(cate == "09300902"){ 
            tmpCate = "090825";
         }
        if(cate == "09300903"){ 
            tmpCate = "090822";
         }
        if(cate == "09300904"){ 
            tmpCate = "090826";
         }
        if(cate == "09300905"){ 
            tmpCate = "090823";
         }
        if(cate == "09300906"){ 
            tmpCate = "090827";
         }
        if(cate == "09300907"){ 
            tmpCate = "090824";
         }
        if(cate == "09301001"){ 
            tmpCate = "091301";
         }
        if(cate == "09301002"){ 
            tmpCate = "091305";
         }
        if(cate == "09301003"){ 
            tmpCate = "091313";
         }
        if(cate == "09301004"){ 
            tmpCate = "091309";
         }       
         if(cate == "09131401"){ 
            tmpCate = "090813";
         }
        if(cate == "09131402"){ 
            tmpCate = "090822";
         }
        if(cate == "09131403"){ 
            tmpCate = "090823";
         }
        if(cate == "09131404"){ 
            tmpCate = "090824";
         }
        if(cate == "09131405"){ 
            tmpCate = "090825";
         }
        if(cate == "09131406"){ 
            tmpCate = "090826";
         }
        if(cate == "09131407"){ 
            tmpCate = "090827";
         }
        if(cate == "09131501"){ 
            tmpCate = "093001";
         }
        if(cate == "09131502"){ 
            tmpCate = "093011";
         }
        if(cate == "09131503"){ 
            tmpCate = "093005";
         }
        if(cate == "09131504"){ 
            tmpCate = "093006";
         }
        if(cate == "09131505"){ 
            tmpCate = "093007";
         }
        if(cate == "09131506"){ 
            tmpCate = "093008";
         }
        if(cate == "06212301"){ 
            tmpCate = "15080907";
         }
        if(cate == "06212303"){ 
            tmpCate = "15080904";
         }
        if(cate == "06212305"){ 
            tmpCate = "15080908";
         }
        if(cate == "06212302"){ 
            tmpCate = "15080901";
         }
        if(cate == "06212304"){ 
            tmpCate = "15080909";
         }
        if(cate == "06212306"){ 
            tmpCate = "15080903";
         }
        if(cate == "06212308"){ 
            tmpCate = "15080905";
         }
        if(cate == "02132801"){ 
            tmpCate = "021507";
         }
        if(cate == "02132802"){ 
            tmpCate = "021511";
         }
        if(cate == "09211409"){ 
            tmpCate = "14570108";
         }
        if(cate == "09211410"){ 
            tmpCate = "14570697";
         }
        if(cate == "14570112"){ 
            tmpCate = "100104";
         }
        if(cate == "14570330"){ 
            tmpCate = "10011611";
         }
        if(cate == "14570622"){ 
            tmpCate = "10011601";
         }
        if(cate == "03461001"){ 
            tmpCate = "031323";
         }
        if(cate == "08040812"){ 
            tmpCate = "080314";
         }
        if(cate == "08040813"){ 
            tmpCate = "080313";
         }
        if(cate == "03461002"){ 
            tmpCate = "031324";
         }
        if(cate == "03461003"){ 
            tmpCate = "031308";
         }
        if(cate == "10051001"){  
            tmpCate = "100319";
          }
        if(cate == "10051002"){  
            tmpCate = "100320";
         }
        if(cate == "10051003"){  
            tmpCate = "100321";
         }
        if(cate == "10051004"){  
            tmpCate = "100322";
         }
        if(cate == "10051005"){  
            tmpCate = "100318";
         }
    	if(cate == "101451")
        { 
            tmpCate = "102409";
        }
        if(cate == "10145101")
        { 
            tmpCate = "10240911";
        }
        if(cate == "10145102")
        { 
            tmpCate = "10240902";
        }
        if(cate == "10145103")
        { 
            tmpCate = "10240903";
        }
        if(cate == "10145104")
        { 
            tmpCate = "10240904";
        }
        if(cate == "10145105")
        { 
            tmpCate = "10240907";
        }
        if(cate == "10145106")
        { 
            tmpCate = "10240909";
        }
        if(cate == "10145107")
        { 
            tmpCate = "10240908";
        }
        if(cate == "10145108")
        { 
            tmpCate = "10240901";
        }
        if(cate == "10145109")
        { 
            tmpCate = "10240905";
        }
        if(cate == "10145110")
        {  
            tmpCate = "10240910";
        }
        
        /*점프 카테고리 예외 처리*/
        if(cate){
        if (cate.length == 8){
            if (cate.substring(0,6) == "090819"){
                if(cate == "09081911"){
                    tmpCate = "091313";
                }else{ 
                    tmpCate = "0913"+cate.substring(6,8);
                }
            }
            if (cate.substring(0,6) == "091312"){
                tmpCate = "0908"+cate.substring(6,8)
            }
            if (cate.substring(0,6) == "020119"){
                if(cate == "02011905"){
                    tmpCate = "022406";
                }else if(cate == "02011906"){
                    tmpCate = "022413";
                }else{ 
                    tmpCate = "0224"+cate.substring(6,8)
                }
            }
            if (cate.substring(0,6) == "080718"){
                tmpCate = "081304"+cate.substring(6,8)
            }   
            if (cate.substring(0,6) == "051012"){
                tmpCate = "0515"+cate.substring(6,8)
            }           
            if (cate.substring(0,6) == "052113"){
                tmpCate = "0826"+cate.substring(6,8)
            }
            if (cate.substring(0,6) == "051509"){
                if(cate == "05150914"){
                    tmpCate = "051011"
                }else{
                    tmpCate = "0510"+cate.substring(6,8)
                }
            }
            if (cate.substring(0,6) == "050813"){
                tmpCate = "0521"+cate.substring(6,8)
            }
            if (cate.substring(0,6) == "052108"){
                tmpCate = "0508"+cate.substring(6,8)
            }
            if (cate.substring(0,6) == "061111"){
                tmpCate = "0608"+cate.substring(6,8)
            }
            if (cate.substring(0,6) == "060814"){
                if(cate == "06081401"){
                    tmpCate = "06110101"
                }else{
                    tmpCate = "0611"+cate.substring(6,8)
                }
            }           
            if (cate.substring(0,6) == "062109"){
                tmpCate = "0605"+cate.substring(6,8)
            }
            if (cate.substring(0,6) == "060517"){
                if(cate == "06051705"){
                    tmpCate = "062103"
                }else if(cate == "06051706"){
                    tmpCate = "062101"
                }else if(cate == "06051709"){
                    tmpCate = "062105"
                }else{
                    tmpCate = "0621"+cate.substring(6,8)
                }
           } 
           if (cate.substring(0,6) == "163608"){
                if(cate == "16360803"){
                    tmpCate = "051504"
                }else if(cate == "16360804"){
                    tmpCate = "051505"
                }else if(cate == "16360806"){
                    tmpCate = "051508"
                }else if(cate == "16360807"){
                    tmpCate = "051513"
                }else if(cate == "16360805"){
                    tmpCate = "051518"
                }else if(cate == "16360808"){
                    tmpCate = "051517"
                }else if(cate == "16360809"){
                    tmpCate = "051503"
                }else{
                    tmpCate = "0515"+cate.substring(6,8)
                }
            }   
            if (cate.substring(0,6) == "080217"){
                tmpCate = "0815"+cate.substring(6,8)
            }                                               
            if (cate.substring(0,6) == "081509"){
                tmpCate = "0802"+cate.substring(6,8)
            }                                               
            if (cate.substring(0,6) == "080309"){
                if(cate == "08030905"){
                    tmpCate = "080411"
                }else if(cate == "08030908"){
                    tmpCate = "080405"
                }else if(cate == "08030901"){
                    tmpCate = "0826"
                }else{
                    tmpCate = "0804"+cate.substring(6,8)
                }
			}                                               
            if (cate.substring(0,6) == "080408"){
           		if (cate == "08040807"){
                	tmpCate = "080311"
            	}else{              
            		tmpCate = "0803"+cate.substring(6,8)
            	}
            }      
            if (cate.substring(0,6) == "100911"){
                if (cate == "10091109"){
                    tmpCate = "101010"
                }else if (cate == "10091104"){
                    tmpCate = "101011"
                }else if (cate == "10091108"){
                    tmpCate = "101013"
                }else if (cate == "10091110"){
                    tmpCate = "101012"
                }else{
                    tmpCate = "1010"+cate.substring(6,8)
                }
			}                                               
			if (cate.substring(0,6) == "101009"){
                tmpCate = "1009"+cate.substring(6,8)
            }                                               
            if (cate.substring(0,6) == "101307"){
                if (cate == "10130708"){
                    tmpCate = "100912"
                }else{
                    tmpCate = "1009"+cate.substring(6,8)
                }
            }       
            if (cate.substring(0,6) == "021015"){
                if(cate == "02101505"){
                    tmpCate = "021415";
                }else if(cate == "02101509"){
                    tmpCate = "021413";
                }else if(cate == "02101510"){
                    tmpCate = "021412";
                }else{
                    tmpCate = "0214"+cate.substring(6,8)
                }
            }          
             if (cate.substring(0,6) == "021411"){
                if(cate == "02141113"){
                    tmpCate = "02101301";
                }else{
                    tmpCate = "0210"+cate.substring(6,8)
                }
            }
            if (cate.substring(0,6) == "051407"){
                tmpCate = "1605"+cate.substring(6,8)
            }           
            if (cate.substring(0,6) == "020407"){
                if (cate == "02040710"){
                    tmpCate = "069203"
                }else if (cate == "02040702"){
                    tmpCate = "06920201"
                }else if (cate == "02040701"){
                    tmpCate = "06920218"
                }else{
                    tmpCate = "0692"+cate.substring(6,8)
                }
            }
            if (cate.substring(0,6) == "101408"){
                if (cate == "10140809"){
                    tmpCate = "101010"
                }else if (cate == "10140804"){
                    tmpCate = "101011"
                }else if (cate == "10140808"){
                    tmpCate = "101013"
                }else if (cate == "10140810"){
                    tmpCate = "101012"
                }else{
                    tmpCate = "1010"+cate.substring(6,8)
                }
             }
             if (cate.substring(0,6) == "180113"){
                if (cate == "18011311"){
                    tmpCate = "180213"
                }else if (cate == "18011312"){
                    tmpCate = "180214"
                }else{
                    tmpCate = "1802"+cate.substring(6,8)
                }
            }
            if (cate.substring(0,6) == "180212"){
                if (cate == "18021208"){
                    tmpCate = "1803"
                }else if (cate == "18021213"){
                    tmpCate = "180116"
                }else if (cate == "18021215"){
                    tmpCate = "180117"
                }else if (cate == "18021216"){
                    tmpCate = "180115"
                }else{  
                    tmpCate = "1801"+cate.substring(6,8)
                }
            }
            if (cate.substring(0,6) == "081306"){
                tmpCate = "0521"+cate.substring(6,8)
            }           
            if (cate.substring(0,6) == "070406"){
                if (cate == "07040601"){
                    tmpCate = "020822"
                }else if (cate == "07040610"){
                    tmpCate = "020823"
                }else if (cate == "07040609"){
                    tmpCate = "020805"
                }
            }   
            if (cate.substring(0,6) == "090315"){
                tmpCate = "0920"+cate.substring(6,8)
            }
            if (cate.substring(0,6) == "092008"){
                tmpCate = "0903"+cate.substring(6,8)
            }
            if (cate.substring(0,6) == "021907"){
                tmpCate = "0704"+cate.substring(6,8)
            }   
            if (cate.substring(0,6) == "163208"){
                tmpCate = "1625"+cate.substring(6,8)
            }   
            if (cate.substring(0,6) == "090520"){
                if (cate == "09052008"){
                    tmpCate = "092408"
                }else{
                    tmpCate = "0924"+cate.substring(6,8)
                }
            }   
            if (cate.substring(0,6) == "092410"){
                tmpCate = "0905"+cate.substring(6,8)
            }   
            if (cate.substring(0,6) == "169307"){
                tmpCate = "1598"+cate.substring(6,8)
            }   
            if (cate.substring(0,6) == "051516"){
                if (cate == "05151601"){
                    tmpCate = "163604"
                }else if (cate == "05151605"){
                    tmpCate = "163601"
                }else if (cate == "05151602"){
                    tmpCate = "163602"
                }else if (cate == "05151606"){
                    tmpCate = "163609"
                }else if (cate == "05151603"){
                    tmpCate = "163606"
                }else if (cate == "05151607"){
                    tmpCate = "163611"
                }else if (cate == "05151609"){
                    tmpCate = "163607"
                }else if (cate == "05151604"){
                    tmpCate = "163605"
                }
            }
            if (cate.substring(0,6) == "040426"){
                if (cate == "04042609"){
                    top.insertLog(2828);
                    tmpCate = "041008"
                }else if(cate == "04042604"){
                    tmpCate = "041009"
                }else if(cate == "04042611"){
                    tmpCate = "041006"
                }else if(cate == "04042612"){
                    tmpCate = "041005"
                }else if(cate == "04042613"){
                    tmpCate = "041015"
                }else{
                    tmpCate = "0410"+cate.substring(6,8)
                }
            }   
            if (cate.substring(0,6) == "211311"){
                tmpCate = "2116"+cate.substring(6,8)
            }   
            if (cate.substring(0,6) == "162510"){
                tmpCate = "1632"+cate.substring(6,8)
            }   
            if (cate.substring(0,6) == "020808"){
                tmpCate = "0219"+cate.substring(6,8)
            }   
            if (cate.substring(0,6) == "090322"){
                if(cate == "09032201"){ 
                    tmpCate = "092316"
                }else if(cate == "09032202"){ 
                    tmpCate = "092317"
                //}else if(cate == "09032203"){ 
                    //tmpCate = "092302"
                //}else if(cate == "09032204"){ 
                    //tmpCate = "092303"
                }else if(cate == "09032205"){ 
                    tmpCate = "092310"
                }
            }   
            if (cate.substring(0,6) == "092307"){
                if(cate == "09230710"){
                    tmpCate = "090326"
                }else{
                    tmpCate = "0903"+cate.substring(6,8)
                }
            }   
            if (cate.substring(0,6) == "092509"){
                tmpCate = "/fashion/Fashion_SubList.jsp?cate=145706"+cate.substring(6,8)
            }   
            if (cate.substring(0,6) == "020911"){
                if(cate == "02091112"){
                    tmpCate = "0210"+cate.substring(6,8)
                }else{
                    tmpCate = "0214"+cate.substring(6,8)
                }
            }
            if (cate.substring(0,6) == "022111" || cate.substring(0,6) == "020913"){
                if (cate == "02091305"){
                    tmpCate = "021405"
                }else if (cate == "02211105"){
                    tmpCate = "021415"
                }else if (cate == "02211112"){
                    tmpCate = "021001"
                }else{
                    tmpCate = "0210"+cate.substring(6,8)
                }
            }   
            if (cate.substring(0,6) == "020914"){
                tmpCate = "0221"+cate.substring(6,8)
            }
            if (cate.substring(0,6) == "211307"){
                if(cate == "21130704"){
                    tmpCate = "212105"
                }else{
                    tmpCate = "2121"+cate.substring(6,8)
                } 
            }   
            if (cate.substring(0,6) == "021425"){
                tmpCate = "0231"+cate.substring(6,8)
            }   
            if (cate.substring(0,6) == "092016"){
                if(cate == "09201606"){
                    tmpCate = "210618"
                }else if(cate == "09201607"){
                    tmpCate = "210621"
                }else if(cate == "09201608"){
                    tmpCate = "21061701"
                }else if(cate == "09201609"){
                    tmpCate = "21060707"
                }else if(cate == "09201610"){
                    tmpCate = "21061717"
                }else{
                    tmpCate = "210618"+cate.substring(6,8)
                }
            }
            if (cate.substring(0,6) == "121910"){
                if(cate == "12191001"){
                    tmpCate = "120512"
                }else if(cate == "12191002"){
                    tmpCate = "120515"
                }else if(cate == "12191003"){
                    tmpCate = "120501"
                }else if(cate == "12191004"){
                    tmpCate = "120510"
                }else if(cate == "12191005"){
                    tmpCate = "120502"
                }else if(cate == "12191006"){
                    tmpCate = "120504"
                }else if(cate == "12191007"){
                    tmpCate = "120516"
                }else if(cate == "12191008"){
                    tmpCate = "120514"
                }else{
                    tmpCate = "1205"+cate.substring(6,8)
                }
            }   
            if (cate.substring(0,6) == "033711" || cate.substring(0,6) == "033811" || cate.substring(0,6) == "033911"){
                if(cate == "03371101" || cate == "03381101" || cate == "03391101" ){
                    tmpCate = "031323"
                }else if(cate == "03371102" || cate == "03381102" || cate == "03391102" ){
                    tmpCate = "031324"
                }else if(cate == "03371103" || cate == "03381103" || cate == "03391103" ){
                    tmpCate = "031308"
                }
            }   
            if (cate.substring(0,6) == "034013" || cate.substring(0,6) == "034112"){
                if(cate == "03401301" || cate == "03411201" ){
                    tmpCate = "033506"
                }else if(cate == "03401302" || cate == "03411202" ){
                    tmpCate = "033507"
                }else if(cate == "03401303" || cate == "03411203" ){
                    tmpCate = "033513"
                }
            }   
        }   
        }    
        return tmpCate;
    }
    