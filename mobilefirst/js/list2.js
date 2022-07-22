
var cate = $("#cate").val();
if(cate == "" || cate == undefined){
	cate = "0304";
}
var swiper;

var bFirst = false;
var bFilter = false;
var totalCnt = 0;

var arrFactory = new Array();
var arrBrand = new Array();
var arrCate = new Array();
var vFactoryCnt;
var vBrandCnt;

var arrFactoryChk = new Array();
var arrBrandChk = new Array();
var arrSpecChk = new Array();
var vFilterCate = "";

var arrChk = new Array();
var arrChkOn = new Array(); 

var arrChkTmp = new Array();
var arrChkReal = new Array(); 

var vFromPage = "List";
//if(document.URL.indexOf("search2.jsp") >= 0 ){
if(document.URL.indexOf("search.jsp") >= 0 ){
	vFromPage = "Search";
	cate = "";
} 

var DtypeJson;
var DtypeModel;

var tmp_url = "";
var tmp_shop_code = "";
var tmp_ca_code = "";

//해외직구 상점 리스트
var ovsShopAry = [8446,8447,8448,8826,8827,8828,8829];

jQuery(document).ready(function($) {
	
	//성인인증 하러가기
	$("#adult_login").click(function(){
		location.href="http://m.enuri.com/mobilefirst/login/adult.jsp?app=N"+"&backUrl="+encodeURIComponent(document.location.href);
	});
	
	//중소분류
	$(".contarea").hide(); 
	$(".mdl_sort li:first").addClass("on").show(); 
	$(".contarea:first").show(); 
		
	if(vFromPage == "List"){
		if(cate.length > 4 && cate.length < 10){
			// .scll  미분류레이어
			cmdDcate();				
		}else{
			$(".cate_area").hide();
			$(".small_cate").hide();
		}
		getcmdbanner();
		//cmdBanner();
		// 상품리스트 
		cmdList();	
	
		// 네이버파워쇼핑
		// getPowerShopping(타입, 카테고리, 검색어)
		// LP 는 검색어가없다.
		getPowerShopping("LP", cate, null);
		
		try{
			if($("#from").val() == "search"){
				var auto_keyword  = $("#auto_keyword").val();
				iseObj = new Object();
				iseObj.ca_code = szCategoryPower;	
				iseObj.lp_type = "K";
				iseObj.logType = "1";
				iseObj.keyword = auto_keyword;
				insSearchlog(iseObj);

			}else{
				iseObj = new Object();
				iseObj.ca_code = szCategoryPower;
				iseObj.lp_type = "C";
				iseObj.logType = "1";
				insSearchlog(iseObj);
			}
			
		}catch(e){console.log(e)}
		
	}else if(vFromPage == "Search"){
		
		//SRP C/D
		cmdSRP_Type();
		// SRP2
		cmdSRP2();
		//브랜드 테마 검색
		loadKeywordAd();
		iseObj = new Object();
		iseObj.procType = 1,
		iseObj.keyword = $("#all_keyword").val();
		iseObj.sr_type = "S";
		insertSearchListLog(iseObj);
		// 중고차
		loadResellcarListMobile();
		
		
	}
	// 소셜인기상품 리스트
	if(vFromPage == "List"){
		cmdSocialList();
	}
	
	// 연관검색어
	if(vFromPage == "Search"){
		cmdLinkageKwd();
	}
	
	//정렬
	$(".sort").click(function(){
        if( document.URL.indexOf("/list.jsp") > -1){
        	ga('send', 'event', 'mf_lp', 'lp_common', 'click_정렬');
        }else if( document.URL.indexOf("/search.jsp") > -1){
        	ga('send', 'event', 'mf_srp', 'srp_common', 'click_정렬');
        }
	});
	$(".sort select").change(function() { 
		var varSelect = $(this).val();
		var varSelectText = $('.sort option:selected').text();

		vKey = varSelect;
		
		$("#key").val(varSelect); 
		$("#page").val("1");

        if( document.URL.indexOf("/list.jsp") > -1){
        	ga('send', 'event', 'mf_lp', 'lp_sort', 'click_'+varSelectText);
        }else if( document.URL.indexOf("/search.jsp") > -1){
        	ga('send', 'event', 'mf_srp', 'srp_sort', 'click_'+varSelectText);
        }
		cmdList();
		scrollTo(0,0);
	});
	
	$('.box input').bind('keyup',function(e){
		event = e || window.event;
		var keyID = (event.which) ? event.which : event.keyCode;
		if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ){
		}else{
			event.target.value = event.target.value.replace(/[^0-9]/g, "");
		}
	});
 
	$('.inForm input').bind('keyup',function(e){
		event = e || window.event; 
		var keyID = (event.which) ? event.which : event.keyCode;
		if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ){
		}else{
			event.target.value = event.target.value.replace(/[^0-9]/g, "");
		}
	}); 
 
	//초기화 
	$(".reset").click(function(){
		//alert('arrChkReal,  arrChkTmp 초기화');
		$("#inkeyword").val("");
		$("#start_price").val("");
		$("#end_price").val("");	
		
		$("#srhKeyword").val("");
		$("#srhPrice_s").val("");
		$("#srhPrice_e").val("");	
		
		arrChkReal = new Array();
		arrChkTmp = new Array();
 
		$(".contarea li").removeClass("on");	
		$("#sch_category .detail li").removeClass("on");	
		
		$("#sch_go").click();
        if( document.URL.indexOf("/list.jsp") > -1){
        	ga('send', 'event', 'mf_lp', 'lp_common', 'click_선택한항목 해제');
        }
	});
	
	//상세검색 초기화
	$("#sch_refresh").click(function(){
		//alert('arrChkTmp 초기화');
		//CmdCopyArr();
	
		var idx = 0;
		var arrCnt = 0;
		var ChkText = ""; 
		var FactoryCnt = 0;
		var BrandCnt = 0;
		
		arrChkTmp = new Array();
		
		$("#sch_factory .sub li").removeClass("chk");
		$("#sch_brand .sub li").removeClass("chk");
		$("#sch_category .sub span").removeClass("on");
		$(".detail_sch ul li").removeClass("chk");
		$("#sch_spec li span").html("");
		$("#srhKeyword").val("");
		$("#srhPrice_s").val("");
		$("#srhPrice_e").val("");
		$("#srhPrice").val("");
		$("#srhPrice2").val("");
		
		if(FactoryCnt > 0){ 
			$("#sch_factory span").html(FactoryCnt); 	
			$("#filter_all h2 em").html(FactoryCnt);
		}else{
			$("#sch_factory span").html(""); 
			$("#filter_all h2 em").html("");
		}
		if(BrandCnt > 0){
			$("#sch_brand span").html(BrandCnt); 
			$("#filter_all h2 em").html(BrandCnt);
		}else{
			$("#sch_brand span").html(""); 
			$("#filter_all h2 em").html("");
		}
		
		/*$(".filter_area .s_tag").html(ChkText);
		
		if(ChkText==""){
			$(".tag_scroll").hide();		
		}else{
			$(".tag_scroll").show();		
		}*/
	});
	
	//상세검색 적용
	$("#sch_go").click(function(){
		//alert('1111  arrChkTmp -> arrChkReal 로 복사');
		/*
		//lp / srp _ 결과내
		$("#srhKeyword").val();
		
		//lp / srp _ 가격대
		$("#srhPrice_s").val();
		$("#srhPrice_e").val();
		
		//srp 결과내
		$("#srhRe").val();

		//srp 가격대
		$("#srhPrice").val();
		$("#srhPrice2").val();
		*/
		//if(vFromPage == "List"){
			if($("#srhKeyword").val().length > 0){
				$.each(arrChkTmp, function(i,v){
					if(arrChkTmp[i][0] == "k"){
						arrChkTmp[i][0] = "";
						arrChkTmp[i][1] = "";
						arrChkTmp[i][2] = ""; 
					} 
				}); 
				
				var idx = arrChkTmp.length;
				arrChkTmp[idx] = new Array();
				arrChkTmp[idx][0] = "k";
				arrChkTmp[idx][1] = $("#srhKeyword").val();
				arrChkTmp[idx][2] = $("#srhKeyword").val();
			}else{
				$.each(arrChkTmp, function(i,v){
					if(arrChkTmp[i][0] == "k"){
						arrChkTmp[i][0] = "";
						arrChkTmp[i][1] = "";
						arrChkTmp[i][2] = ""; 
					} 
				}); 
				
			}
			if($("#srhPrice_s").val().length > 0 && $("#srhPrice_e").val().length > 0 ){
				$.each(arrChkTmp, function(i,v){
					if(arrChkTmp[i][0] == "p"){
						arrChkTmp[i][0] = "";
						arrChkTmp[i][1] = "";
						arrChkTmp[i][2] = ""; 
					} 
				}); 
				
				var idx = arrChkTmp.length;
				arrChkTmp[idx] = new Array();
				arrChkTmp[idx][0] = "p";
				arrChkTmp[idx][1] = $("#srhPrice_s").val() +"~"+$("#srhPrice_e").val();
				arrChkTmp[idx][2] = commaNum($("#srhPrice_s").val()) +"~"+commaNum($("#srhPrice_e").val());
			}else{
				$.each(arrChkTmp, function(i,v){
					if(arrChkTmp[i][0] == "p"){
						arrChkTmp[i][0] = "";
						arrChkTmp[i][1] = "";
						arrChkTmp[i][2] = ""; 
					} 
				}); 
			}
			
		/*}else if(vFromPage == "Search"){

			if($("#srhKeyword").val().length > 0){
				$.each(arrChkTmp, function(i,v){
					if(arrChkTmp[i][0] == "k"){
						arrChkTmp[i][0] = "";
						arrChkTmp[i][1] = "";
						arrChkTmp[i][2] = ""; 
					} 
				}); 
				 
				var idx = arrChkTmp.length;
				arrChkTmp[idx] = new Array();
				arrChkTmp[idx][0] = "k";
				arrChkTmp[idx][1] = $("#srhKeyword").val();
				arrChkTmp[idx][2] = $("#srhKeyword").val();
			}
			if($("#srhPrice").val().length > 0 && $("#srhPrice2").val().length > 0 ){
				$.each(arrChkTmp, function(i,v){
					if(arrChkTmp[i][0] == "p"){
						arrChkTmp[i][0] = "";
						arrChkTmp[i][1] = "";
						arrChkTmp[i][2] = ""; 
					} 
				}); 
				
				var idx = arrChkTmp.length;
				arrChkTmp[idx] = new Array();
				arrChkTmp[idx][0] = "p";
				arrChkTmp[idx][1] = $("#srhPrice").val() +"~"+$("#srhPrice2").val();
				arrChkTmp[idx][2] = $("#srhPrice").val() +"~"+$("#srhPrice2").val();
			}
			if($("#srhPrice_s").val().length > 0 && $("#srhPrice_e").val().length > 0 ){
				$.each(arrChkTmp, function(i,v){
					if(arrChkTmp[i][0] == "p"){
						arrChkTmp[i][0] = "";
						arrChkTmp[i][1] = "";
						arrChkTmp[i][2] = ""; 
					} 
				}); 
				
				var idx = arrChkTmp.length;
				arrChkTmp[idx] = new Array();
				arrChkTmp[idx][0] = "p";
				arrChkTmp[idx][1] = $("#srhPrice_s").val() +"~"+$("#srhPrice_e").val();
				arrChkTmp[idx][2] = $("#srhPrice_s").val() +"~"+$("#srhPrice_e").val();
			}
		}*/
		
		
		var arrCnt = 0;
		var ChkText2 = "";
		
		arrChkReal = new Array(); //여기
		 
		$.each(arrChkTmp, function(i,v){
			if(arrChkTmp[i][1] == ""){
			}else{
				if(arrChkTmp[i][1] != undefined){

					idx = arrCnt;
					arrChkReal[idx] = new Array();
					arrChkReal[idx][0] = arrChkTmp[i][0];
					arrChkReal[idx][1] = arrChkTmp[i][1];
					arrChkReal[idx][2] = arrChkTmp[i][2];
					arrCnt++;
					//if(vFromPage == "Search"){
						ChkText2 = ChkText2 + "<li onclick=\"CmdFilterDel('1','"+arrChkReal[idx][0]+"','"+arrChkReal[idx][1]+"')\"><span>"+arrChkReal[idx][2]+"<em class=\"ico_m\">삭제</em></span></li>";
					//}else{
					//	ChkText2 = ChkText2 + "<li onclick=\"CmdFilterDel('1','"+arrChkReal[idx][0]+"','"+arrChkReal[idx][1]+"')\">"+arrChkReal[idx][2]+"<em>삭제</em></li>";
					//}
					//console.log(ChkText2);
				}
			}
		}); 
		
		//lp
		/*$(".lp_area .s_tag").html(ChkText2);
		$(".lp_area .s_tag").show();
		
		if(ChkText2==""){
			$(".lp_area .tag_scroll").hide();		
		}else{
			$(".lp_area .tag_scroll").show();	
		}*/
		
		//srp
		$("#relate_txt div ul").html(ChkText2);
		$("#relate_txt").show();
		
		
		//데이터 초기화 다시 담아 리스팅 (SRP 카테고리, 결과내검색, 가격대검색)
		$("#select_cate").val("");
		$("#inkeyword").val("");
		$("#start_price").val("");
		$("#end_price").val("");	
		$("#sel_spec").val("");
		$("#spec").val("");
		
		var vFactory = "";
		var vBrand = "";
		var vSpec = "";
		var vPrice_start = "";
		var vPrice_end = "";
		var vInKeyword = "";
		
		$.each(arrChkReal, function(i,v){
			 
			if(arrChkReal[i][0] == "c"){ 
				$("#select_cate").val(arrChkReal[i][1]);
			}
			if(arrChkReal[i][0] == "k"){ 
				$("#inkeyword").val(arrChkReal[i][1]);
				vInKeyword = arrChkReal[i][1];
			}
			if(arrChkReal[i][0] == "p"){ 
				var start_price = arrChkReal[i][1].substring(0, arrChkReal[i][1].indexOf("~"));
				var end_price = arrChkReal[i][1].substring(arrChkReal[i][1].indexOf("~")+1, arrChkReal[i][1].length);
							
				$("#start_price").val(start_price);
				$("#end_price").val(end_price);
				vPrice_start = start_price;
				vPrice_end = end_price;
			}
			if(arrChkReal[i][0] == "f"){ 
				if(vFactory == ""){
					vFactory = arrChkReal[i][1];					
				}else{
					vFactory = vFactory +","+arrChkReal[i][1];
				}
			}
			if(arrChkReal[i][0] == "b"){ 
				if(vBrand == ""){
					vBrand = arrChkReal[i][1];					
				}else{
					vBrand = vBrand +","+arrChkReal[i][1];
				}
			}
			if(arrChkReal[i][0] == "s"){  
				var vSpecTmp = arrChkReal[i][1];
				if(vSpecTmp.indexOf("_") > -1){
					vSpecTmp = arrChkReal[i][1].substring(arrChkReal[i][1].indexOf("_")+1, arrChkReal[i][1].length);				
				}
				if(vSpec == ""){
					vSpec = vSpecTmp;					
				}else{
					vSpec = vSpec +","+vSpecTmp;		
				} 
			}
		}); 
		
		$("#factory").val(vFactory);
		$("#brand").val(vBrand);
		if(vFromPage == "List"){
			$("#sel_spec").val(vSpec);
			if(vSpec.length > 0){
				$("#spec").val("y");
			}			
		}else{
			$("#spec").val(vSpec);
		}

		$("#srhPrice").val(vPrice_start);
		$("#srhPrice2").val(vPrice_end);
		
		$("#srhRe").val(vInKeyword);

		/*
		//제조사 factory
		var factory = "";
		$.each(arrFactoryChk , function(i,v){
			if(factory == ""){
				factory = arrFactoryChk[i];
			}else{
				factory = factory+ "," +arrFactoryChk[i];				
			}
		});
		$("#factory").val(factory);

		//브랜드 brand
		var brand = "";
		$.each(arrBrandChk , function(i,v){
			if(brand == ""){
				brand = arrBrandChk[i];
			}else{
				brand = brand+ "," +arrBrandChk[i];				
			}
		});
		$("#brand").val(brand);
		
		//스펙 sel_spec
		var sel_spec = "";
		$.each(arrSpecChk , function(i,v){
			if(sel_spec == ""){
				sel_spec = arrSpecChk[i].substring(arrSpecChk[i].indexOf("_")+1, arrSpecChk[i].length);
			}else{
				sel_spec = sel_spec+ "," +arrSpecChk[i].substring(arrSpecChk[i].indexOf("_")+1, arrSpecChk[i].length);	
			}
		});

		$("#sel_spec").val(sel_spec);
		*/
		
		//결과 내 검색
		//var tmpKeyword = $("#srhKeyword").val();
		//$("#inkeyword").val(tmpKeyword);
		 
		//가격대 검색
		//var tmpMin = $("#srhPrice_s").val().replace(/,/gi,"");
		//var tmpMax = $("#srhPrice_e").val().replace(/,/gi,"");

		//$("#start_price").val(tmpMin);
		//$("#end_price").val(tmpMax);	
		 
		
		$('.filter_close').click();
		
		$("#page").val("1");
		
		cmdList(); 
	}); 
 
});   
 
// .open_list : 중>소분류리스트 보여주기
function cmdOpenList(){
	
	//temp_key = "1"+cate.substring(0,cate.length-2);
	temp_key = "1"+cate;
	temp_flag = 0;
	
	if(temp_key.length >= 5){
		temp_key = temp_key.substring(0,5);
	}

	var loadUrl = "";

	loadUrl = "/mobilefirst/gnb/category/fourLevel.json";
	
	$.ajax({
		url: loadUrl,
		dataType: 'json',
		async: false,
		success: function(json){
			
			var result = false;
			var makeHtml = "";
			var makeOn = "";
			
			if (json) {
				makeHtml += "<div class='dimm'></div>";
				makeHtml += "<ul class='cate_list'>";
				
				$.each(json , function(i,v){
					
					if(v.g_parent == temp_key && v.g_name != "더보기"){

						var g_name = $.trim(v.g_name).replace('@','').replace(/<br>/gi,"").replace(/<BR>/gi,"").replace(/<Br>/gi,"");
													
						var g_seqno = v.g_seqno.toString(); 
						var g_seq =  g_seqno.substring(1,g_seqno.length);
						
							if(v.g_cate == cate){
								makeOn = "class='active'";
							}else {
								makeOn = "";
							}
							if('전체상품보기' == g_name ){
								if(g_seqno == '11600' || g_seqno =='10400'){//꽃배달
									makeHtml += "<li "+makeOn+">";
									makeHtml += "<a href=\"javascript:CmdList('"+v.g_cate+"');CmdGa('mf_lp','lp_GNB','GNB_카테고리선택');\">전체상품</a>";
									makeHtml += "</il>";
								}else{
									makeHtml += "<li "+makeOn+">";
									makeHtml += "<a href=\"javascript:CmdList('"+v.g_cate+"');CmdGa('mf_lp','lp_GNB','GNB_카테고리선택');\">전체상품</a>";
									makeHtml += "</il>";
								}
							}else{
								if(g_seqno == '19100' || g_seqno == '11600' || g_seqno == '10400'){ //여행사 , pc 견적은
									makeHtml += "<li "+makeOn+">";
									makeHtml += "<a href=\"javascript:CmdList('"+v.g_cate+"');CmdGa('mf_lp','lp_GNB','GNB_카테고리선택');\">"+g_name+"</a>";
									makeHtml += "</il>";
								}else{
									if(v.m_group_flag == 0){
										if(temp_flag == 1) {
											makeHtml += "	</ul>";
											makeHtml += "</li>";
										}
										makeHtml += "<li "+makeOn+">";
										makeHtml += "	<a href=\"javascript:CmdList('"+v.g_cate+"');CmdGa('mf_lp','lp_GNB','GNB_카테고리선택');\">"+g_name+"</a>";
										makeHtml += "</li>";
										temp_flag=0;
										
									}else if(v.m_group_flag == 1){
										if(temp_flag == 1){
											makeHtml += "	</ul>";
											makeHtml += "</li>";
										}
										makeHtml += "<li "+makeOn+">";
										makeHtml += "	<a href=\"javascript:CmdList('"+v.g_cate+"');CmdGa('mf_lp','lp_GNB','GNB_카테고리선택');\">"+g_name+"</a>";
										makeHtml += "	<ul class='cate_list sub'>";
										temp_flag = 1;
										
									}else{
										makeHtml += "		<li "+makeOn+">";
										makeHtml += "			<a href=\"javascript:CmdList('"+v.g_cate+"');CmdGa('mf_lp','lp_GNB','GNB_카테고리선택');\">"+g_name+"</a>";
										makeHtml += "		</li>";
									}
								}
							}
							/*
							if('전체상품보기' == g_name ){
								if(g_seqno == '11600' || g_seqno == '10400'){//꽃배달
									makeHtml += "<li "+makeOn+" onclick=\"CmdList('"+v.g_cate+"');CmdGa('mf_lp','lp_GNB','GNB_카테고리선택');\">전체상품</li>";
								}else{
									makeHtml += "<li "+makeOn+" onclick=\"CmdList('"+v.g_cate+"');CmdGa('mf_lp','lp_GNB','GNB_카테고리선택');\">전체상품</li>";	
								}
									
							}else{
								if(g_seqno == '19100' || g_seqno == '11600' || g_seqno == '10400'){ //여행사 , pc 견적은
									makeHtml += "<li "+makeOn+" onclick=\"CmdList('"+v.g_cate+"');CmdGa('mf_lp','lp_GNB','GNB_카테고리선택');\">"+g_name+"</li>";
								}else{
									makeHtml += "<li "+makeOn+" onclick=\"CmdList('"+v.g_cate+"');CmdGa('mf_lp','lp_GNB','GNB_카테고리선택');\">";
									if(v.m_group_flag == 2){
										makeHtml += "<em></em>";
									} 
									makeHtml += g_name+"</li>";
								}
								
							}
							*/
						}
				});
				makeHtml += "</ul>"; 
				//console.log(makeHtml)
				/*
				$(".open_list").append(makeHtml);
				$(".open_list").show();
				*/
				$("#foldingCate").append(makeHtml);
				$("#foldingCate").show();
			}
		}
	});
} 

function cmdBanner(){
	var loadUrl = "/mobilefirst/api/appLP_banner.jsp?cate="+cate;		
	$.ajax({  
		url: loadUrl, 
		dataType:"JSON", 
		success: function(json){ 
			if(json.banner_image == undefined)	return false;
			$(".bnr img").attr("src", json.banner_image);
			$(".bnr img").click(function() {
				ga('send', 'event', 'mf_lp', 'lp_common', 'click_lp_banner');
				location.href = json.banner_target_and.replace("&freetoken=outlink","");
			});
			$(".cate_area").show();
			$(".bnr").show(); 
		}
	}); 
}

// .scll  미분류레이어
function cmdDcate(){
	var cate_tmp = cate;
	if(cate_tmp.length >= 6){
		cate_tmp = cate_tmp.substring(0,6);
	}
	 
	if(cate == "092101"){ 
		cate_tmp = "145504";
	} 
	
	var loadUrl = "/mobilefirst/ajax/gnb/ajax_to_json_5category.jsp?cate="+cate_tmp+"&flag=0";		
	var makeHtml = ""; 
	var groupflag = "";
	var liCnt = 0;
	var makeHtmlClick = "";
	
	$.ajax({  
		url: loadUrl, 
		dataType:"JSON", 
		success: function(json){ 
				if(json.length > 0){
					makeHtml = "<ul>"; 
					$.each(json , function(i,v){
						var g_name = $.trim(v.g_name).replace('@','').replace('<br>','');
						if(groupflag != v.m_group_flag ){
							liCnt = 0;
						}
						if( (groupflag==2 && v.m_group_flag==1) || (groupflag==0 && v.m_group_flag==1) || (groupflag==2 && v.m_group_flag==0) ||  (groupflag=="" && v.m_group_flag==0) ||  (groupflag=="" && v.m_group_flag==2) ){		
							
							if(groupflag=="0" && v.m_group_flag==0){
								
							}else{
								if(i > 0){
									makeHtml += "	</ul>";
									makeHtml += "	</div>";
									makeHtml += "	</li>";
								}
								if(v.m_group_flag==0){
									makeHtml += "	<li  class=\"one\">"; 
								}else{
								makeHtml += "	<li>";
								}
								makeHtml += "	<div class=\"sm_box\">";
								if( v.m_group_flag == 1 ){
									if(v.nonclick_cate == 0){
										makeHtmlClick = " onclick=\"CmdList('"+v.g_cate+"');CmdGa('mf_lp', 'lp_common', 'click_미카테고리');\"";
									}else{
										makeHtmlClick = "";
									}
									if($("#cate").val() == v.g_cate){
										makeHtml += "		<span class=\"tit on\" "+makeHtmlClick+">"+g_name+"</span>";
									}else{
										makeHtml += "		<span class=\"tit\" "+makeHtmlClick+">"+g_name+"</span>";
									}
								}
								makeHtml += "		<ul class=\"sm_list\">";
							}
						}
						if(liCnt%4 == 0){
							if(v.m_group_flag!=1){
								makeHtml += "			<li>";
							}
						}
						if( v.m_group_flag != 1 ){
							if(v.nonclick_cate == 0){
								makeHtmlClick = " onclick=\"CmdList('"+v.g_cate+"');CmdGa('mf_lp', 'lp_common', 'click_미카테고리');\"";
							}else{
								makeHtmlClick = "";
							}
							
							if($("#cate").val() == v.g_cate){
								makeHtml += "				<span class=\"on\" "+makeHtmlClick+">"+g_name+"</span>";
							}else{
								makeHtml += "				<span "+makeHtmlClick+">"+g_name+"</span>";
							}
							liCnt = liCnt + 1; 
						}
						if(liCnt%4 == 0 ){
							makeHtml += "			</li>";
						}						

						groupflag = v.m_group_flag;
					});
				
				makeHtml += "</ul>"; 
				$(".scll").append(makeHtml);

			}else{ 
				$(".small_cate").hide();
			}
		}
	});
} 
var vViewFactory = "";

function cmdSRP2(){
	var loadUrl = "/lsv2016/ajax/getCateListSearchType_ajax.jsp?keyword="+$("#all_keyword").val();		

	$.ajax({   
		url: loadUrl, 
		dataType:"JSON", 
		async : true,
		success: function(result){ 
			var vViewType = result.keywordInfo.viewType;
			vViewFactory = result.keywordInfo.viewFactory;
			
			if(vViewType == "A"){ 
				var obj_A1 = result.mCateList;
				var html_A1 = "";
				var obj_A1_Cname = "";
				
				var obj_A2 = result.sCateList;
				var html_A2= "";
				var display_name = "";
				
				
				if(obj_A1){
					$.each(obj_A1 , function(i,v){
						if(i == 0){
							var obj_A1_On = "class=\"on\"";
							obj_A1_Cname = v.cateName;
						} 
						if(v.cateCode == 1001){
							display_name = "유아동 " + v.cateName;						
						}else if(v.cateCode == 2109){
							display_name = "차량 공기청정,안전용품";
						}else{
							display_name = v.cateName;
						}
						
						html_A1 += "<li data-id=\"tab0"+(i+1)+"\" "+obj_A1_On+"><a href=\"javascript:///\" onclick=\"cmdScate('"+v.cateCode+"','"+(i+1)+"');\">"+display_name+"</a></li>";
						
					});
					html_A1 += "<li data-id=\"tab04\"><a href=\"javascript:///\">제조사</a></li>";						
					html_A1 += "<li data-id=\"tab05\"><a href=\"javascript:///\">브랜드</a></li>";
					html_A1 += "<li data-id=\"tab06\"><a href=\"javascript:///\">상세검색</a></li>";
				
					$(".mdl_sort .scll ul").html(html_A1);
					if(obj_A1.length <1){
						$("[data-id='tab01']").hide();
					}
				}else{
					$("[data-id='tab01']").hide();
				}
				if(obj_A2){
					$.each(obj_A2 , function(i,v){
						if(i < 30){
							if(v.cateCode == 1001){
								display_name = "유아동 " + v.cateName;						
							}else if(v.cateCode == 2109){
								display_name = "차량 공기청정,안전용품";
							}else{
								display_name = v.cateName;
							}
							if(i % 6 == 0){
								html_A2 += "<li class=\"swiper-slide\"><ul>";
							}
							
							html_A2 += "<li id='sl_c_"+v.cateCode+"' onclick=\"cmdSearch('c','"+v.cateCode+"','"+obj_A1_Cname+" > "+display_name+"');\"><em>"+v.cateName+"("+commaNum(v.cateCnt)+")</em></li>";
							
							if(i % 6 == 5 || i == obj_A2.length || i == 29){
								html_A2 += "</ul></li>";
							}
						}
					}); 
					
					$("#tab01 div ul").html(html_A2);
				} 
			}else if(vViewType == "B"){
				var obj_B= result.mCateList;
				var html_B= "";
				var display_name = "";
				if(obj_B){
					$.each(obj_B , function(i,v){
						if(v.cateCode == 1001){
							display_name = "유아동 " + v.cateName;						
						}else if(v.cateCode == 2109){
							display_name = "차량 공기청정,안전용품";
						}else{
							display_name = v.cateName;
						}
						if(i < 30){
							if(i % 6 == 0){
								html_B += "<li class=\"swiper-slide\"><ul>";
							}
							
							html_B += "<li id='sl_c_"+v.cateCode+"' onclick=\"cmdSearch('c','"+v.cateCode+"','"+display_name+"');\"><em>"+display_name+"("+commaNum(v.cateCnt)+")</em></li>";

							if(i % 6 == 5 || i == obj_B.length || i == 29){
								html_B += "</ul></li>";
							}
						}
					}); 
	
					$("#tab01 div ul").html(html_B); 
					if(obj_B.length <1){
						$("[data-id='tab01']").hide();
					}
				}else{ 
					$("[data-id='tab01']").hide();
				}
			}
			
			//swiper.destroy;
			swiper = undefined;
			setTimeout(function(){
				 swiper = new Swiper('.sw_tab01', {
						pagination: '.swiper-pagination',
						paginationClickable: true
					 });
			},500);
			
			$(".mdl_sort li").unbind("click");
			$(".mdl_sort li").click(function() {
				
				$(".mdl_sort li").removeClass("on"); 
				$(this).addClass("on"); 
				$(".contarea").hide(); 
				
				var activeTab = $(this).attr("data-id");
				$("#"+activeTab).fadeIn();

				if(activeTab == "tab04" || activeTab == "tab05" || activeTab == "tab06"){
					$(".scll").scrollLeft(500); 
				}
				if(activeTab == "tab04" || activeTab == "tab05"){
					if($("#all_keyword").val().length > 0){
						cmdSRP2_filter();
					}
				}
				if(activeTab == "tab04"){
					ga('send', 'event', 'mf_srp', 'srp_common', 'click_제조사탭');
				}else if(activeTab == "tab05"){
					ga('send', 'event', 'mf_srp', 'srp_common', 'click_브랜드탭');
				}else if(activeTab == "tab06"){
					ga('send', 'event', 'mf_srp', 'srp_common', 'click_상세검색탭');
				}
				//swiper.destroy;

				swiper = undefined;
				setTimeout(function(){
					 swiper = new Swiper('.sw_'+activeTab, { 
							pagination: '.swiper-pagination',
							paginationClickable: true
						 });
				},500);
			});
		
			if(vViewFactory == "N"){
				$("[data-id='tab04']").hide();
			};
			 
		},
		complete:function(){

		}
	});
	
	if($("#all_keyword").val().length > 0){
		cmdSRP2_filter();
	}
} 


function cmdSRP2_filter(){
	//var loadUrl = "/lsv2016/ajax/getSearchInfoList_ajax.jsp?cate="+$("#cate").val()+"&keyword="+$("#all_keyword").val();
	var loadUrl = "/lsv2016/ajax/getSearchInfoList_ajax.jsp?cate="+$("#cate").val()+"&keyword="+vAllKeyword;
	var html_F = "";
	var html_B = ""; 
	
	if(vFilterCate == $("#cate").val()){
		  
	}else{
		$.ajax({   
			url: loadUrl, 
			dataType:"JSON", 
			//async : true, //여기
			success: function(result){  
				if(result.factoryList.factoryList){
					$.each(result.factoryList.factoryList , function(i,v){
						if(i < 30){
							if(i % 6 == 0){
								html_F += "<li class=\"swiper-slide\"><ul>";
							}
							html_F += "<li id='sl_f_"+v.factoryShowName+"' onclick=\"cmdSearch('f','"+v.factoryShowName+"','"+v.factoryShowName+"');\"><em>"+v.factoryShowName+"</em></li>";
							if(i % 6 == 5 || i == result.factoryList.factoryList || i == 29){
								html_F += "</ul></li>";
							} 
						}
					});		
					$("#tab04 div ul").html(html_F); 
					$("[data-id='tab04']").show();
				}else{
					if(	!bFirst ){
						$("[data-id='tab04']").hide();
					}else{
						return false;
					}
				}
	
				if(result.brandList.brandList){
					$.each(result.brandList.brandList , function(i,v){
						if(i < 30){
							if(i % 6 == 0){
								html_B += "<li class=\"swiper-slide\"><ul>";
							}
							html_B += "<li id='sl_b_"+v.brandShowName+"' onclick=\"cmdSearch('b','"+v.brandShowName+"','"+v.brandShowName+"');\"><em>"+v.brandShowName+"</em></li>";
							if(i % 6 == 5 || i == result.brandList.brandList || i == 29){
								html_B += "</ul></li>";
							} 
						}
					});		
					$("#tab05 div ul").html(html_B); 
					$("[data-id='tab05']").show();
				}else{
					if(	!bFirst ){
						$("[data-id='tab05']").hide();
					}else{
						return false;
					}
				} 
				//console.log(result.factoryList.length);
				if(result.factoryList.factoryShowCnt == 0){
					if(	!bFirst ){
						$("[data-id='tab04']").hide();
					}
				}
				
				if(result.brandList.brandShowCnt == 0){
					if(	!bFirst ){
						$("[data-id='tab05']").hide();
					}
				}
				
			},
			complete:function(){
				if($("[data-id='tab01']").is(":visible")){
					
				}else{
					if($("[data-id='tab06']").is(":visible")){
						$("[data-id='tab06']").addClass("on");
						$(".contarea").hide();
						$("#tab06").show();
					}
					if($("[data-id='tab05']").is(":visible")){
						$("[data-id='tab05']").addClass("on");
						$(".contarea").hide();
						$("#tab05").show();
					} 
					if($("[data-id='tab04']").is(":visible")){
						$("[data-id='tab04']").addClass("on");
						$(".contarea").hide();
						$("#tab04").show();
					}
				}
				vFilterCate = $("#cate").val();
			
				if(vViewFactory == "N"){
					$("[data-id='tab04']").hide();
				}; 
			}
		});
	}
}

function CmdRightCate(){
	$(".filter_area h2").html("<em>\""+$('#all_keyword').val()+"\"</em> 검색결과");
	var loadUrl = "/lsv2016/ajax/getSearchGoods_ajax.jsp?keyword="+$('#all_keyword').val()+"&deviceType=2&IsMobileApp=Y";		
	var html = "";
	var r_cate = $("#cate").val();
	
	$.ajax({  
		url: loadUrl, 
		dataType:"JSON", 
		success: function(result){ 
			var obj = result.cateGroupList;

			$.each(obj , function(i,v){
				for(var i = 0; i < v.cateList.length; i ++){
					if( i == 0){
						html += "<li id='right_cate_"+v.cateList[i].cate.substring(0,2)+"'><a href=\"#\">"+v.cateName+"</a>";
						if(r_cate.substring(0,2) == v.cateList[i].cate.substring(0,2)){
							html += "<div class=\"sub\" style=\"display:inline;\">";
						}else{
							html += "<div class=\"sub\">";
						}
						html += "	<ul>";
					}
					html += "	<li><span id='sub_"+v.cateList[i].cate+"'>"+v.cateList[i].name+"</span>";
					html += "	<div class=\"detail\">"; 
					html += "		<ul id='sublist_"+v.cateList[i].cate+"'></ul>";
					html += "</div></li>";
				} 
				html += "</ul>";
				html += "</li>";
			});
		},
		complete: function(){ 
			$("#sch_category").html(html); 
			$(".sch_list div li a").click(function() {
				$(this).toggleClass( "on" );
				$(this).next().slideToggle("fast").parent().siblings().children(".sub");
				return false;
			});
			$(".sub li span").click(function() {
				CmdRightSCate(this.id);
				$(this).toggleClass( "on" );
				$(this).next().slideToggle("fast").parent().siblings().children(".detail");
				return false;
			}); 
			//console.log("r_cate==="+r_cate)
			if(r_cate.length >= 4 && r_cate != "00000000"){
				//CmdRightSCate(r_cate.substring(0,4));
				$("#sub_"+r_cate.substring(0,4)).click();
				$(".detail_sch").scrollTop($("#sub_"+r_cate.substring(0,4)).offset().top-48);
			}
		}  
	});
	
	$("#sch_factory").hide();
	$("#sch_brand").hide();
	$("#sch_spec").hide();
	$("#sch_category").show();
}

function CmdRightSCate(param){
	var vCate = param.replace("sub_","");
	var loadUrl = "/lsv2016/ajax/getSearchCateList_ajax.jsp?keyword="+$('#all_keyword').val()+"&cate="+vCate;		

	$.ajax({  
		url: loadUrl, 
		dataType:"JSON",  
		success: function(result){ 
			var obj = result.sCateList;
			var html = "";
			if(vCate == $("#cate").val()){ 
				html = "<li class=\"chk\" id=\"scate_"+vCate+"\" name='전체보기'>전체보기</li>";			
			}else{
				var vNM = $("#sub_"+vCate.substring(0,4)).text();
				html = "<li id=\"scate_"+vCate+"\" name='전체보기'>전체보기</li>";			
			}
 
			if(obj){
				$.each(obj , function(i,v){
					if(v.cateCode == $("#cate").val().substring(0,6)){
						html += "<li class=\"chk\" id=\"scate_"+v.cateCode+"\" name=\""+v.cateName+"\">"+v.cateName+"("+commaNum(v.cateCnt)+")</li>";
					}else{
						html += "<li id=\"scate_"+v.cateCode+"\" name=\""+v.cateName+"\">"+v.cateName+"("+commaNum(v.cateCnt)+")</li>";
					}
				}); 
			} 
			$("#sublist_"+vCate).html(html);
		},
		complete: function(){ 
			//$(".contarea li").removeClass("on");
			$("#sublist_"+vCate + " li").click(function(){
				$(".contarea li").removeClass("on");
				var vName = "";
				if(this.id.replace("scate_","").length > 4){
					vName = $("#sub_"+vCate).text() + " > "+ $(this).attr("name");
				}else{ 
					vName = $("#sub_"+vCate).text();
				}
				
				if($(this).attr("name") == "전체보기"){
					ga('send', 'event', 'mf_srp', 'srp_cate', 'click_소카테_전체 더보기');
				}else{
					ga('send', 'event', 'mf_srp', 'srp_cate', 'click_소카테_list 더보기');
				}
				
				arrChkTmp = new Array();
				arrChkReal = new Array();
				
				idx = arrChkTmp.length; 
				arrChkTmp[idx] = new Array();
				arrChkTmp[idx][0] = "c";
				arrChkTmp[idx][1] = this.id.replace("scate_","");
				arrChkTmp[idx][2] = vName;
				
				$("#cate").val(arrChkTmp[idx][1]);
				$("#sch_go").click();
			});
		}
	});
}

function CmdRightFilter(){
	$(".filter_area h2").html("상세검색");
	CmdFilterBox();
	$("#sch_factory").show();
	$("#sch_brand").show(); 
	$("#sch_spec").show();
	$("#sch_category").hide();
	ga('send', 'event', 'mf_srp', 'srp_common', 'click_상세보기 더보기');
}

function cmdScate(cate, no){
	var loadUrl = "/lsv2016/ajax/getSearchCateList_ajax.jsp?keyword="+$('#all_keyword').val()+"&cate="+cate;		

	$.ajax({  
		url: loadUrl, 
		dataType:"JSON", 
		success: function(result){ 
			var obj = result.sCateList;
			var html = "";
			
			$.each(obj , function(i,v){
				if(i % 6 == 0){
					html += "<li class=\"swiper-slide\"><ul>";
				}
				html += "<li id='sl_c_"+v.cateCode+"' onclick=\"cmdSearch('c','"+v.cateCode+"','"+result.cateName2+" > "+v.cateName+"');\"><em>"+v.cateName+"("+commaNum(v.cateCnt)+")</em></li>";
				if(i % 6 == 5 || i == obj.length){ 
					html += "</ul></li>";
				}
			});

			$("#tab0"+no+" div ul").html(html);
		},
		complete:function(){
			var scllLeft = $("[data-id='tab0"+no+"']").offset().left;
			
			$(".scll").scrollLeft(0);
			$(".scll").scrollLeft($("[data-id='tab0"+no+"']").offset().left-$("#wrap").width() / 2);
			//console.log($("#wrap").width() / 2)
			//swiper.destroy;
			/*swiper = undefined; 
			setTimeout(function(){
				 swiper = new Swiper('.sw_tab0'+no, {
						pagination: '.swiper-pagination',
						paginationClickable: true
					 }); 
			},500);*/
		}
	});
	
	$(".mdl_sort .scll ul li").removeClass("on");
	$("[data-id='tab0"+no+"']").addClass("on");
	 
	$(".contarea").hide();
	$("#tab0"+no).show();
	
	ga('send', 'event', 'mf_srp', 'srp_common', 'click_카테고리 탭');
} 

//상품 총갯수
function cmdListCnt(param){
	var loadUrl = "/lsv2016/ajax/getGoodsListCnt_ajax.jsp?procType=1&constrain=1"+param;		
	
	$.ajax({  
		url: loadUrl, 
		dataType:"JSON", 
		success: function(result){ 
			if(param.indexOf("key=newGoods") > -1 || param.indexOf("tabType=1") > -1){
				totalCnt = result.totalModelCnt;	
			}else{
				totalCnt = result.totalCnt;			 
			}

			$(".sort_opt p").html(commaNum(totalCnt)+"개 상품");
			cmdPaging();
		}
	});
 
}

//페이징
function cmdPaging(){
	var vPaging = "<li></li><li>#n</li><li>#n</li><li>#c</li><li>#n</li><li>#n</li><li></li>";

	$("#paging").html(vPaging);
	$("#paging").show();
	
	$("#paging2").html(vPaging);
	//$("#paging2").show();

	var listCntHtml = totalCnt;
	if($("#page").val() == 1){
		$("#paging").easyPaging(listCntHtml.replace(/,/gi,""), {
				perpage: 40,
				page: 1,
				onSelect: function(page) {
					if($("#page").val() != page){
						scrollTo(0, 0);
						$("#page").val(page);
						cmdList();
						CmdGa('', '', 'click_1page~ 5page');
						nowPageLogExe();	//페이징시 logger 한번 호출 2018-03-30. shwoo
					}
				} 
         });	 
		$("#paging2").easyPaging(listCntHtml.replace(/,/gi,""), {
			perpage: 40,
			page: 1,
			onSelect: function(page) {
				if($("#page").val() != page){
					scrollTo(0, 0);
					$("#page").val(page);
					CmdGa('', '', 'click_1page~ 5page');
					cmdList();
					nowPageLogExe();	//페이징시 logger 한번 호출 2018-03-30. shwoo
				}
			} 
		});	 
	}else{
		$("#paging").easyPaging(listCntHtml.replace(/,/gi,""), {
			perpage: 40,
			page: $("#page").val(),
			onSelect: function(page) {
				if($("#page").val() != page){ 
					scrollTo(0, 0);
					$("#page").val(page);
					CmdGa('', '', 'click_1page~ 5page');
					cmdList();
					nowPageLogExe();	//페이징시 logger 한번 호출 2018-03-30. shwoo
				}
			} 
        });
		$("#paging2").easyPaging(listCntHtml.replace(/,/gi,""), {
			perpage: 40,
			page: $("#page").val(),
			onSelect: function(page) {
				if($("#page").val() != page){ 
					scrollTo(0, 0);
					$("#page").val(page);
					CmdGa('', '', 'click_1page~ 5page');
					cmdList();
					nowPageLogExe();	//페이징시 logger 한번 호출 2018-03-30. shwoo
				}
			} 
        });
	}

}

var obj;
var obj2; 
var makeHtml = "";  
var makeParam = ""; 
var vKey = ""; 
var infoAdHtml = "";
var sponAdHtml = "";
var vPage = "";
var mIsSponBType = false;
var vModelnos = "";
// 상품리스트 
function cmdList(param){

	vPage = $("#page").val();
	vKey = $("#key").val(); 
	
	var vStartPrice = $("#start_price").val(); 
	vStartPrice = vStartPrice.replace(/,/gi,"");
	var vEndPrice = $("#end_price").val(); 
	vEndPrice = vEndPrice.replace(/,/gi,"");
	var vInKeyword = $("#inkeyword").val(); 
	var vKeyword = $("#all_keyword").val(); 
	var vFactory = $("#factory").val(); 
	var vBrand = $("#brand").val();  
	var vSelSpec = $("#sel_spec").val(); 
	var vSpec = $("#spec").val(); 
	
	//tabType : 0 전체 , 1 가격비교
	var loadUrl = "/lsv2016/ajax/get"+vFromPage+"Goods_ajax.jsp?deviceType=2&key="+vKey+"&pageNum="+vPage+"&pageGap=40";		
	loadUrl += "&start_price="+vStartPrice+"&end_price="+vEndPrice;
	if(vFromPage =="Search"){
		var vCate = $("#select_cate").val();
		loadUrl += "&tabType=0&keyword="+vKeyword+"&in_keyword="+vInKeyword;
		loadUrl += "&cate="+vCate;
	}else{  
		if(vInKeyword.length > 0 || (vKey == "popular DESC")){
			loadUrl += "&tabType=0&cate="+cate+"&keyword="+vInKeyword;					
		}else{
			loadUrl += "&tabType=1&cate="+cate+"&keyword="+vInKeyword;		
		}
	} 
	loadUrl += "&factory="+vFactory;
	loadUrl += "&brand="+vBrand;
	if(vFromPage =="Search"){
		loadUrl += "&spec="+vSpec;	
	}else{
		if(vSelSpec){
			loadUrl += "&spec=y&sel_spec="+vSelSpec;
		}else{ 
			loadUrl += "&spec=&sel_spec=";		
		}
	}

	var vLCnt = 0;

	
	//여기에서 체크한번더? 
	//제조사, 브랜드, 스펙, 카테고리, 키워드, 가격 체크, 삭제텍스트
	var ChkText2 = "";
	$(".contarea li").removeClass("on");	
	$.each(arrChkReal , function(i,v){

		$("#sch_category .detail li").removeClass("on");	
		if(arrChkReal[i][0] == "c"){
			$("#sl_c_"+arrChkReal[i][1]).addClass("on");
			$("#scate_"+arrChkReal[i][1]).addClass("on");
		}
		if(arrChkReal[i][0] == "f"){
			//$("#sl_f_"+arrChkReal[i][1]).addClass("on");
			//$("li[name='"+arrChkReal[i][1]+"']").addClass("on");
			$("#tab01 li[name='"+arrChkReal[i][1]+"']").addClass("on");			
			$("#sch_factory li[name='"+arrChkReal[i][1]+"']").addClass("chk");			
			if( $("#allview_search .factory").length ) {
				$("#allview_search .factory li[name='"+arrChkReal[i][1]+"']").addClass("chk");	
			}
		}
		if(arrChkReal[i][0] == "b"){
			//console.log(arrChkReal[i][1]);
			//$("#sl_b_"+arrChkReal[i][1]).addClass("on");
			//$("li[name='"+arrChkReal[i][1]+"']").addClass("on");
			$("#tab02 li[name='"+arrChkReal[i][1]+"']").addClass("on");			
			$("#sch_brand li[name='"+arrChkReal[i][1]+"']").addClass("chk");			
			if( $("#allview_search .brand").length ) {
				$("#allview_search .brand li[name='"+arrChkReal[i][1]+"']").addClass("chk");	
			}
		}
		if(arrChkReal[i][0] == "s"){
			//console.log(arrChkReal[i][1]);
			$("#sl_s_"+arrChkReal[i][1]).addClass("on");
			$("li[name='"+arrChkReal[i][1]+"']").addClass("on");
		}
		if(arrChkReal[i][0] == "k"){
			
		}
		if(arrChkReal[i][0] == "p"){
			
		}
		if(arrChkReal[i][0] != ""){
			//ChkText2 = ChkText2 +"<li onclick=\"CmdFilterDel('1','"+arrChkReal[i][0]+"','"+arrChkReal[i][1]+"')\"><span>"+arrChkReal[i][2]+"<em class=\"ico_m\">삭제</em></span></li>";
		}
	    //console.log("1111==="+arrChkReal[i][0] + " , " +arrChkReal[i][1] + " , "+arrChkReal[i][2]);
	});

	scrollTo(0, 0);

	if(bFirst || vFromPage == "Search"){
		CmdSpin('on');
	}
	if( vFromPage == "Search" && $("#all_keyword").val() =="" ){
		cmdIngiList();	
		$(".prodList").hide();
		$(".no_txt").show(); 
		$(".srpview").hide(); 
		$(".power").hide();
		$(".depart_hit").hide();
		if(vFromPage == "Search"){
			if($("#inkeyword").val().length > 0){
				$(".no_txt p em").text("'"+$("#all_keyword").val()+" > " +$("#inkeyword").val() + " '");
				$(".sort_list").show();
			}else{
				$(".no_txt p em").text("'"+$("#all_keyword").val()+"'");
				$(".sort_list").hide();
			}
			$(".srpview").show(); 
			$(".sort_opt p").text("0개 상품");
		}else{
			$(".sort_opt p").text("0개 상품");
		} 
		//$(".relate").hide();
		$(".con_box").show();
		$(".loading").hide();
		$(".paging").hide();
		$("#paging2").hide();
		CmdSpin('off');
		return false;	 
	}else{
		$(".con_box").hide();
	}

	$.ajax({    
		url: loadUrl,   
		dataType:"JSON",  
		success: function(result){
			obj = null;
			obj2 = null;
			
			obj = result.lpList;
			obj2 = result.srpPlnoList;
			
			if (result.isSponBType) {
				mIsSponBType = result.isSponBType;
			}
			else if (result.isSrpSponBType) {
				mIsSponBType = result.isSrpSponBType;
			}
			
			if(vFromPage == "Search"){
				obj = result.srpModelList;
			} else{
				var lp_viewtype = result.list_view_m_flag;
				lpViewType(lp_viewtype);
			}
			if(obj){
				vLCnt = vLCnt + obj.length;
			}
			if(obj2){
				vLCnt = vLCnt + obj2.length;
			}
			//alert(vLCnt)
			
			if(vLCnt == 0){
				cmdIngiList();	
				$(".prodList").hide();
				$(".no_txt").show(); 
				//$(".srpview").hide(); 
				$(".power").hide();
				if(vFromPage == "Search"){
					if($("#inkeyword").val().length > 0){
						$(".no_txt p em").text("'"+$("#all_keyword").val()+" > " +$("#inkeyword").val() + " '");
						$(".sort_list").show();
					}else{
						$(".no_txt p em").text("'"+$("#all_keyword").val()+"'");
						$(".sort_list").hide();
					}
					$(".srpview").show(); 
					$(".sort_opt p").text("0개 상품");
				}else{
					$(".sort_opt p").text("0개 상품");
				}
				//$(".relate").hide();
				$(".depart_hit").hide();
				$(".con_box").show();
				$(".loading").hide();
				$(".paging").hide();
				$("#paging2").hide();
				return false;	 
			}else{ 
				$(".prodList").show();
				$(".no_txt").hide();
				$(".srpview").show();
				//$(".sort_list").show();
				if(vFromPage == "Search"){
					$(".sort_list").show();
				}else{
					var dcatelayer = $(".small_cate .scll").html();

					if(dcatelayer.length > 100){
						$(".sort_list").hide();
					}else{
						$(".sort_list").show();
					}
				}
				//if(vFromPage == "Search"){
				if($("#relate .relate_area ul").html()){
					if($("#relate .relate_area ul").html().trim().length > 0){
						$(".relate_area").scrollLeft($(".relate_area").width());
						$("#relate_txt").show();	
					}
				}
				if($("#relate_txt .relate_area").html()){
					if($("#relate_txt .relate_area").html().trim().length < 20){
						$("#relate_txt").hide();	
					}else{ 
						$(".relate_area").scrollLeft($(".relate_area").width());
					}
				}
					//$("#relate_txt").show();
				//}

				$(".paging").show();
				if($(".power").is(":visible")){
					$("#paging2").show();
				}else{
					$("#paging2").hide();
				}
				/*if($(".power").html().length < 200){
					$(".power").hide();
					$(".paging2").hide();
				}else{
					$(".power").show();
					$("#paging2").show();
				}*/
			} 
			//가격비교상품

			//if(vFromPage == "Search" && !obj && !obj2){
			makeListHtml();
			
			if($("#page").val() == 1){ 
				// 네이버 파워링크 위치 조절.
				// adline 바로 아래에 네이버 파워링크가 붙음.
				var adlineidx = 1; // 기본 모델 2개 포함.					
				// 스폰서나 플러스링크 (인포애드) 는 기본 모델 갯수에 포함시키지 않으므로 숫자 더해줌.
				$('.prodList li').each(function(){
					if ($(this).find('.sponsor').length > 0){
						adlineidx ++;
					}
					
					if ($(this).find('.pluslink').length > 0){
						adlineidx ++;
					}
				});
				
				// console.log(adlineidx);

				if($('.prodList > li').length < adlineidx){
					$('.prodList > li:eq('+($('.prodList > li').length-1)+')').after("<li id=\"adline\" style=\"display:none;\"></li>");
				}else{
					$('.prodList > li:eq(' + adlineidx.toString() + ')').after("<li id=\"adline\" style=\"display:none;\"></li>");
				}

				if(!bFirst){
					//getEDPlatformData();
					//cpcLoading();
				}else{
					
					//$('.prodList #adline').before(ebayMakeTmp);
					//jq11(".pluslink_goods_list").show();
					
					ebayMakeTmp = ""; 
					$(".depart_hit").html("");
					cpcLoading();
				//	setPowerLinkLinkLpRe();
					// getPowerLink LP/SRP 구분이 명확하지 않아 LP로 호출, 
					// keyword 값이 있는경우 SRP 로 인식함
					if($(".listarea").length < 4){
						getPowerLink( "LP", $("#cate").val(), $("okeyword").val(), false);
					} else {
						getPowerLink( "LP", $("#cate").val(), $("#okeyword").val(), true);
					}
				} 
				//console.log("bFirst=="+bFirst)
				if(!bFirst){
					if($("#tab0"+vListTab_org).hasClass("on")){
						
					}else{ 
						$("[data-id='tab0"+vListTab_org+"']").click();
					}
				}
			} 
			if(!bFirst){
			//	cpcLoading();
			} 
			if($("#page").val() == 1 && !bFirst){  
				ad_commandPower = encodeURIComponent(result.ad_command);
				
				if(szCategoryPower != "-" || szCategoryPower == "" ){
					//if($(".prodChoice").length < 20){
					// getPowerLink LP/SRP 구분이 명확하지 않아 LP로 호출, 
					// keyword 값이 있는경우 SRP 로 인식함
					if($(".listarea").length < 4){
				//		setPowerLinkLink();		//하단 파워링크
						getPowerLink( "LP", $("#cate").val(), $("#okeyword").val(), false);
					}else{
				//		setPowerLinkLinkLp();	//상,하단 파워링크
						getPowerLink( "LP", $("#cate").val(), $("#okeyword").val(), true);
					} 
				}else{
					$(".powerLink").hide();
				} 
			}
			if(!bFirst){
				cpcLoading(); 
				if(vFromPage == "Search"){
					getSrpMiddleBanner();	//검색 상단 배너
				}else{
					getLpMiddleBanner();	//리스트 중단 파워클릭 상단 배너
				}
			}
			
			if(vFromPage == "Search"){
				$(".sort_opt p").html(commaNum(result.intTotRsCnt)+"개 상품");
				totalCnt = result.intTotRsCnt;
				cmdPaging(); 
				bFirst = true; 		
			}else if(result.intEnuriCnt!="0" || (vInKeyword && vInKeyword.length>0 ) ) {
				//$(".sort_opt p").html(commaNum(result.intEnuriCnt)+"개 상품");
				//totalCnt = result.intEnuriCnt;
				$(".sort_opt p").html(commaNum(result.intTotRsCnt)+"개 상품");
				totalCnt = result.intTotRsCnt;
				
				cmdPaging(); 
				bFirst = true; 
			}else{
				if(result.hmParams){ 
					makeParam = "";
					if(result.hmParams.length > 0){
						$.each(result.hmParams , function(i,v){
							makeParam += "&"+v.key +"="+v.value;
						});
						makeParam = makeParam.replace("mprice","m_price");
						makeParam += "&cate="+$("#cate").val();
						if(vInKeyword.length > 0 || (vKey == "popular DESC")){
							makeParam += "&tabType=0";
						}else{
							makeParam += "&tabType=1";
						}
						if(vFactory.length > 0){
							makeParam += "&factory_arr="+vFactory;
						}
						if(vBrand.length > 0){ 
							makeParam += "&brand_arr="+vBrand;
						}
						if(vSelSpec.length > 0){
							makeParam += "&spec=y&sel_spec="+vSelSpec;
						}
						if(vKey == "newGoods"){
							makeParam += "&key=newGoods&selOrderNum=6";
						} 
						cmdListCnt(makeParam);
					}
				}

				bFirst = true; 
			//}
			}
				
		},
		complete:function(){
			//zzimCheckSet(); 
			//썸네일 이미지 내 속성 노출 
			setListImageInIconSet();
			
			/*상세설명*/ 
			$('.prodtxt span').click(function(){
				if ($(this).parent().hasClass("txtmore")) {
					$(this).parent().removeClass("txtmore");
			        if( document.URL.indexOf("/list.jsp") > -1){
			        	ga('send', 'event', 'mf_lp', 'lp_common', 'click_속성더보기');
			        }else if( document.URL.indexOf("/search.jsp") > -1){
			        	ga('send', 'event', 'mf_srp', 'srp_common', 'click_속성더보기');
			        }
				} else {
					$(this).parent().addClass("txtmore");
				}  
			});
			/*가격비교*/
			$('.pircelist dt').click(function(){
				if ($(this).parent().hasClass("pmore")) {
					$(this).parent().removeClass("pmore");
				} else {
					var modelno = this.parentNode.parentNode.parentNode.id.replace("p_",""); 
					$(this).parent().addClass("pmore");
					if($(this).text().indexOf("옵션") < 0){
						getMall(modelno);
				        if( document.URL.indexOf("/list.jsp") > -1){
				        	ga('send', 'event', 'mf_lp', 'lp_detail', 'click_쇼핑몰');
				        }else if( document.URL.indexOf("/search.jsp") > -1){
				        	ga('send', 'event', 'mf_srp', 'srp_detail', 'click_쇼핑몰');
				        }
					}else{
						var vCatecode = $("#p_"+modelno).attr("catecode");
						getOption(modelno, vCatecode);
				        if( document.URL.indexOf("/list.jsp") > -1){
				        	ga('send', 'event', 'mf_lp', 'lp_detail', 'click_가격비교');
				        }else if( document.URL.indexOf("/search.jsp") > -1){
				        	ga('send', 'event', 'mf_srp', 'srp_detail', 'click_가격비교');
				        }
					}
			} });
			
			/*찜*/
			$( ".prodList li .btnzzim").click(function() {
				if(IsLogin()) {
					$(this).toggleClass( "on" );
					var vZzimNo = "";
					var vZzimType = "";
					
					if(this.id.indexOf("_G") > -1){
						vZzimType = "G";
						vZzimNo = this.id.replace("btn_zzim_G","");
					}else if(this.id.indexOf("_P") > -1){
						vZzimType = "P";
						vZzimNo = this.id.replace("btn_zzim_P","");
					}
					
					if($("#btn_zzim_"+vZzimType+vZzimNo).hasClass("on")){
						addResentZzimItem(2, vZzimType, vZzimNo);	
						$("#btn_zzim_"+vZzimType+vZzimNo+" div").html("<span class=\"zzimly fade-out\">찜 되었습니다</span>");
					}else{
						var url = "/view/deleteSaveGoodsProc.jsp";
						var param = "modelnos="+vZzimType+":"+vZzimNo+"&tbln=save";

						$.ajax({
							type : "post",
							url : url,
							data : param, 
							dataType : "html",
							success : function(ajaxResult) {
								
							}
						}); 
					}
				}else{
					if(confirm("찜 하시려면 로그인이 필요합니다.\n로그인 하시겠습니까?")) {
						goLogin();
						return false;
					}else{
						return false;
					}
				}
			});
			if(IsLogin()) {
				zzimColor();
			}
			var arrInfoad = infoAdHtml.split(",");
			for( var infoad = 0 ; infoad < arrInfoad.length ; infoad++){
				if(arrInfoad[infoad].length > 0 ){
					getInfoAdItemData(arrInfoad[infoad]);
					ga('send', 'event', 'mf_lp_Info_Ad_list', 'mf_인포애드_'+arrInfoad[infoad], 'mf_인포애드_'+arrInfoad[infoad]);
				}
			}
			
			// 스폰서 추가
			var arrSponad = sponAdHtml.split(",");
			for( var spon = 0 ; spon < arrSponad.length ; spon++){
				if(arrSponad[spon].length > 0 ){
					getSponAdItemData(arrSponad[spon], szCategoryPower);
					ga('send', 'event', 'mf_lp_Spon_Ad_list', 'mf_스폰서_'+arrSponad[spon], 'mf_스폰서_'+arrSponad[spon]);
				}
			}
			
			// 스폰서 B-Type api 호출 및 html 랜더링 추가 
			// getListGoods_ajax.jsp에서 받은 isSponBType이 true일 경우에만 스폰서 Btype api 호출 한다. 
			if (mIsSponBType == "true") {
				getSponAdBTypeData(szCategoryPower);
			}
			
			$.each(arrChkReal , function(i,v){ 
				if(arrChkReal[i][0] == "s"){ 
					$(".prodList > li > div > div > a > em").each(function(){
						var seqTemp = $(this).attr("specno");
						var specno = arrChkReal[i][1];
						if(specno.indexOf("_") > -1){
							specno = specno.substring(0, specno.indexOf("_"));
						}
						if(specno == seqTemp ){ 
							$(this).addClass("on");
							$(this).removeClass("add");
						}
					}); 
				}
			});
			
			if(DtypeModel != "undefined" ){
				if(DtypeModel){
					$("#p_"+DtypeModel+" .pircelist dt").click();
				}
			} 
			CmdSpin('off');
			//$(".relate_area").scrollLeft(1000); 
			//lp
			$(".lp_area .s_tag").html(ChkText2);
			$(".lp_area .tag_scroll").show();
			$(".lp_area .s_tag").show();
			
			//srp
			//$("#relate_txt div ul").html(ChkText2);
			//$("#relate_txt").show();

		}
	});
	
}
function makeListHtml(){
	makeHtml = "";
	
	// #36582 SRP > 출시예정상품 가격 및 등록일 노출 수정 (WEB) 2019.10.30 jinwook 
	var prodStatusTxt = "";
	
	// 파워쇼핑을 그리기 위한 선언자
	var boolPowerShop = false;
	var searchKeyword = $("#okeyword").val();
	
	if(obj || obj2){
		if(obj){
			if(obj.length > 0){
				$.each(obj , function(i,v){
					if(i==0 && !boolPowerShop && vFromPage == "Search") {
						getPowerShopping("SRP", v.strCa_code, searchKeyword);
						boolPowerShop = true;
					}
					
					prodStatusTxt = v.prodStatusTxt;
					
					if(i==0){
						vModelnos =  v.intModelNo;
					}else{
						vModelnos += ","+ v.intModelNo;	
					}
					var vShopType = v.strShopType;
					var vShopTypeClass = "";
					if(vShopType =="4"){
						vShopTypeClass = "type_npay";
					}
					
					makeHtml += "<li>"; 
					
					if(v.intModelNoOrg == 0){
						
						var tmpSpec = v.strSpec;
						var tmpShopCode = 0;
						if( tmpSpec.length > 0 ) {
							tmpShopCode = tmpSpec.split(":")[0];
						}
						
						makeHtml += "<div class=\"listarea\" id=\'p_"+v.intP_Pl_No+"\'  catecode=\""+v.strCa_code+" modelno= \""+v.intModelNo+"\" \">"; 
						makeHtml += "	<a href=\"javascript:///\" onclick=\"goShop_ex('"+v.intP_Pl_No+"');goShop(tmp_url,tmp_shop_code,'"+v.intP_Pl_No+"', '', '', tmp_ca_code, '', '', '', '0'); \">"; 
						makeHtml += "		<p class=\"prodChoice\" onclick=\"event.cancelBubble=true;\"><button class=\"btnzzim\" id=\"btn_zzim_P"+v.intP_Pl_No+"\">찜하기<div class=\"zzimarea\"></div></button></p>"; 
						makeHtml += "		<span class=\"thum\" ><img src=\""+v.strImageUrl+"\" alt=\"\" onerror=\"this.src='http://photo3.enuri.com/data/working.gif'\"/></span>"; 
						makeHtml += "		<em class=\"mall "+vShopTypeClass+"\">"+v.strKb_title+"</em>"; 
						makeHtml += "		<strong class=\"tit\">"+v.strModelName+"</strong>"; 
						makeHtml += "		<span class=\"price\">";
						
						// 현금몰
						if(v.strCashMinFlag=="Y") {
							makeHtml += "		<span class=\"ico--cash\">현금</span>";
						// 해외직구
					
						} else if(v.strOvsMinFlag=="Y" || $.inArray(parseInt(tmpShopCode), ovsShopAry) >= 0) {
							makeHtml += "		<span class=\"ico--global\">직구</span>";
						}
						
						makeHtml += "			<span class=\"min\">최저가 </span>";
						
						if(v.strCashMinFlag=="Y" && ( v.lngCashMinPrice<v.lngMinPrice2 || (v.lngCashMinPrice>0 && v.lngMinPrice2==0) ) ) {
							makeHtml += "	<em>"+commaNum(v.lngCashMinPrice)+"</em>원</span>";
						} else {
							makeHtml += "	<em>"+commaNum(v.lngMinPrice2)+"</em>원</span>";
						}
						makeHtml += "	</a>";
						
						//<!-- 191106 직구/현금몰 추가 - 리스트형/그리드형 - 직구 안내 아이콘 추가  -->
						if(v.strOvsMinFlag=="Y"){
							makeHtml += "<span class=\"ico--global_info\" onclick=\"$(this).next('.layer--global').show();\">안내</span>";
							makeHtml += "<span class=\"layer--global\" style=\"display:none\">";
							makeHtml += "	해외직구 상품으로 상품 정보, 가격, 배송비 등을 꼭 확인 후 구매하세요<i class=\"cls_x\" onclick=\"$(this).parent().hide();\">X</i>";
							makeHtml += "</span>";
						}
						
						makeHtml += "</div>"; 
					}else{
						if(v.intModelNoOrg){ 
							makeHtml += "<div id=\'p_"+v.intModelNoOrg+"\' catecode=\""+v.strCa_code+"\" class=\"listarea\"  ";
						}else{
							makeHtml += "<div class=\"listarea\" id=\'p_"+v.intModelNo+"\'  catecode=\""+v.strCa_code+"\"  ";
						}
						if(v.intAdType == 2){ 
							makeHtml +=  " infoad=\"Y\" ";
						}
						makeHtml +=  " modelno= \""+v.intModelNo+"\" >"; 
						if($("#page").val() == 1){
							//console.log(DtypeModel + "   "+v.intModelNoOrg + "   "+v.intModelNo);
							if(v.intModelNoOrg){ 
								if(DtypeModel == v.intModelNoOrg || DtypeModel == v.intModelNo){
									makeHtml += "<p class=\"d_type\">딱 맞는 상품입니다.</p>";
								}  
							}else{
								if(DtypeModel == v.intModelNo){
									makeHtml += "<p class=\"d_type\">딱 맞는 상품입니다.</p>"; 
								}						
							} 
						}
						makeHtml += "	<a href=\"javascript:///\" onclick=\"CmdVip('option','"+v.intModelNo+"');CmdGa('', '', 'click_상품');";
						
						if(v.intAdType == 2){ 
							makeHtml += "	CmdGaInfoad('"+v.intModelNoOrg+"', 'click_"+v.intModelNoOrg+"');"   ;
						} 
						makeHtml += " \"  >";
						makeHtml += "		<p class=\"prodChoice\" onclick=\"event.cancelBubble=true;\"><button class=\"btnzzim\" id=\"btn_zzim_G"+v.intModelNo+"\">찜하기<div class=\"zzimarea\"></div></button></p>";
						makeHtml += "		<span class=\"thum\"><img src=\""+v.strImageUrl+"\" alt=\"\"   id=\"img_"+v.intModelNo+"\" onerror=\"CmdErrImg('"+v.intModelNo+"','"+v.strImageUrl+"')\" /></span>";
						//if(v.intAdType == 2){ //INFO AD
						//	makeHtml += "		<span class=\"pluslink\">INFO AD</span>";								
						//}else if(v.intAdType == 1){ //스폰서
						//	makeHtml += "		<span class=\"pluslink\">스폰서</span>";	
						//}
						if(v.intAdType == 2 || v.intAdType == 1){ 
							makeHtml += "		<span class=\"pluslink\">AD</span>";
						}
						makeHtml += "		<strong class=\"tit\">";
						if(v.intPopularOrder){
							if(v.intPopularOrder.length > 0 && vKey == "popular DESC"){
								if(v.intPopularOrder > 0 &&  v.intPopularOrder < 11 && vPage == 1){
								makeHtml += "		<em>"+v.intPopularOrder+"위</em>";							
								}
							}
						}
						makeHtml += "		"+v.strModelName+"</strong>";
						
						// #36582 SRP > 출시예정상품 가격 및 등록일 노출 수정 (WEB) 2019.10.30 jinwook 
						if(prodStatusTxt=="미정") {
							makeHtml += "		<span class=\"price\"><em>가격미정</em></span>";
						} else if(prodStatusTxt=="없음") {
							makeHtml += "		<span class=\"price\"><em>가격없음</em></span>";
						} else {
							if(v.strGroupCondiName == "출시예정" || (vKey == "newGoods" && v.lngMinPrice3 == 0)){
								makeHtml += "		<span class=\"price\"><em>출시예정</em></span>";
							}else{
								makeHtml += "		<span class=\"price\">";
								var strRelease = "";
								var release_price = "";
								var regex="";
								
								if(v.strSpec.indexOf("출시가") > -1){
									strRelease = "출시가";
									regex  = /출시가[a-bA-Z\<\>\/]*:[a-bA-Z\<\>\/]*([0-9,.]+|원)/gi;
								}else if(v.strSpec.indexOf("출고가") > -1){
									strRelease = "출고가";
									regex  = /출고가[a-bA-Z\<\>\/]*:[a-bA-Z\<\>\/]*([0-9,.]+|원)/gi;
								}
								
								if(strRelease.length>0 && strRelease !=""){
									if(regex.test(v.strSpec)){
										release_price = RegExp.$1;	
									}
									if(release_price.length > 0){
										makeHtml += "<span class=\"release_price\">"+strRelease+" <span class=\"txt_price\"><b>"+release_price+"</b>원</span></span>";	
									}	
								}
								
								// 현금몰
								if(v.strCashMinFlag=="Y") {
									makeHtml += "		<span class=\"ico--cash\">현금</span>";
								// 해외직구
								} else if(v.strOvsMinFlag=="Y"){
									makeHtml += "		<span class=\"ico--global\">직구</span>";
								}
								
								makeHtml += 		"<span class=\"min\">최저가</span> ";
								
								if(v.strCashMinFlag=="Y" && ( v.lngCashMinPrice<v.lngMinPrice3 || (v.lngCashMinPrice>0 && v.lngMinPrice3==0) ) ) {
									makeHtml += 	"	<em>"+commaNum(v.lngCashMinPrice)+"</em>원";
								} else {
									makeHtml += 	"	<em>"+commaNum(v.lngMinPrice3)+"</em>원";
								}
								makeHtml += 		"</span>";
							}
						}
						makeHtml += "		<span class=\"stit\">";
						if(v.kbnum > 0){
						makeHtml += "		상품평("+commaNum(v.kbnum)+")";
						}
						if(v.kbnum > 0 && v.intSaleCnt > 0){
						makeHtml += "		<em>|</em>";
						}
						if(v.intSaleCnt > 0){ 
						makeHtml += "		판매량("+commaNum(v.intSaleCnt)+")";
						}
						makeHtml += "		</span></span>";
						makeHtml += "	</a>";
						
						if(v.intAdType == 2){
							makeHtml += "<div class=\"news\" id=\"infoAd_"+v.intModelNoOrg+"\"><span><em>NEWS</em></span></div>";
							if(infoAdHtml==""){
								infoAdHtml = v.intModelNoOrg;
							}else{
								infoAdHtml = infoAdHtml + ","+ v.intModelNoOrg;	
							}
						} else if(v.intAdType == 1){		// 스폰서 일 경우 추가
							// SRP 의 경우 intModelNoOrg 겂이 존재하지 않아 intModelNo 로 매핑 20191010 by jinwook
							var ad_modelno = (v.intModelNoOrg && v.intModelNoOrg.length>0) ? v.intModelNoOrg : v.intModelNo; 
							makeHtml += "<div class=\"news\" id=\"sponAd_"+ad_modelno+"\"><span><em>NEWS</em></span></div>";
							if(sponAdHtml==""){
								sponAdHtml = ad_modelno;
							}else{
								sponAdHtml = sponAdHtml + ","+ ad_modelno;	
							}
						}

						//var arrSpec = v.spec_lp_tag.split("/"); 
						if(v.spec_lp_tag ){
							makeHtml +="<div class=\"prodtxt\" value=\"Hide\">";							
						}else{ 
							if(v.strSpec != ""){
								makeHtml +="<div class=\"prodtxt\" value=\"Hide\">"+ v.strSpec;
							}else{
								makeHtml +="<div class=\"prodtxt\" value=\"Hide\" style=\"display:none;\">";								
							}
						}
						//makeHtml += "	<span>더보기</span>";
						makeHtml += makeSpecTagDic(v.spec_lp_tag, v.intModelNoOrg); 
						
						makeHtml += "	<em class=\"btndetail\" onclick=\"CmdVip('text','"+v.intModelNo+"');\">전체보기</em>";
						makeHtml += "</div>";
						
						//20180911 화장품 전성분 UI 개선
						var componentObj = v["att"];
						
                        if(componentObj != null && v.strCa_code.substring(0,2)=="08" && componentObj != ""){
							var componentList = componentObj["bell"]["list"];
							if(componentList.length >0){
								makeHtml += "<div class=\"cosmetics\">";
								makeHtml += "	<div class=\"cosmetics__inner\">";
								makeHtml += "		<p class=\"cosmetics__label\">적합도 : </p>";
								makeHtml += "		<ul class=\"cosmetics__list\">";
								
								var vTmp = 1;
								$.each(componentList,function(index,listData){
									var percent_gage = listData["cpt_goodness_percent_gage"];
									if(percent_gage>0){
										percent_gage = Math.ceil(percent_gage/10)*10;
									}
									var percent_gage_class = "data"+percent_gage;
									makeHtml += "			<li>";
									makeHtml += "				<span class=\"cosmetics__tit type"+(vTmp++)+"\">"+listData["cpt_goodness"]+"</span>";
									makeHtml += "				<div class=\"watergraph\">";
									makeHtml += "					<em class=\"watergraph data "+percent_gage_class+"\">"+listData["cpt_goodness_round_percent_txt"]+"%</em>";
									makeHtml += "				</div>";
									makeHtml += "			</li>";	
								});
								makeHtml += "		</ul>";
								makeHtml += "	</div>";
								makeHtml += "</div>";
							}
						}
						//20180911 화장품 전성분 UI 개선
                        var furAttObj = v["furAttr"];
                        //20190412 가구 속성 영역 
                        
    					if( (v.strCa_code.substring(0,4)== "1201" || v.strCa_code.substring(0,4)=="1202")
    						 && furAttObj != "" && furAttObj != null ){
    						makeHtml += "<div class=\"lp_fun_grade\"> ";
    						$.each(furAttObj,function(index,listData){
    							var attribute_id = listData["attribute_id"];
    							var attribute_element_id = listData["attribute_element_id"];
    							var attribute_element = listData["attribute_element"];
    							var attribute_title = listData["title"];
    							var attribute_typeClass = "";
    							var attribute_elementClass = "";
    							var attribute_type ="";
    							
    							if(attribute_id==123660 || attribute_id==133553) attribute_type = "1";	//자재등급
    							else if(attribute_id==205023) attribute_type = "2";						//쿠션감
    							else if(attribute_id==211331) attribute_type = "3";						//착석감
    							attribute_typeClass = "fun_grade_0"+attribute_type;
    							makeHtml += "	<div class=\"fun_grade "+attribute_typeClass+"\">";
    							makeHtml += "		<div class=\"grade_tit\">· "+attribute_title+"</div>";
    							
     							if(attribute_type=="1"){
     								attribute_elementClass = "level_"+attribute_element.toLowerCase();
     								makeHtml += "		<div class=\"grade_level "+attribute_elementClass+"\">";
     								makeHtml += "		</div>";
     							}else if(attribute_type=="2" ||attribute_type=="3"){
     								attribute_elementClass = "level_0"+attribute_element_id;
     								makeHtml += "		<div class=\"grade_level "+attribute_elementClass+"\">";
     								makeHtml += "		</div>";
     							}
     							makeHtml += "	</div>";
    						});
    						makeHtml += "</div>";
    					}
    					//가구 속성 영역 
    					
    					// #36582 SRP > 출시예정상품 가격 및 등록일 노출 수정 (WEB) 2019.10.30 jinwook 
    					if(prodStatusTxt!="미정") {
							makeHtml += "<div class=\"more_info\">";
							if(v.strCdate){
								if(v.strCdate.length >=7 ){
									var vDate = "등록일 "+v.strCdate.substring(2,4)+"년 ";
									if(v.strCdate.substring(5,6) == "0"){
										vDate += v.strCdate.substring(6,7)+"월";
									}else{
										vDate += v.strCdate.substring(5,7)+"월";
									}
									makeHtml += "	<span class=\"date\">"+vDate+"</span>";
								}else{
									makeHtml += "	<span class=\"date\">등록일 "+v.strCdate+"</span>";
								}
							}
							makeHtml += "	<dl class=\"pircelist\">"; 
							makeHtml += "		<dt>";
							//if(v.groupModelCnt > 0){R
							if( v.groupModelCnt == 1 && v.strGroupCondiName == "일반"){
							}else if( (v.groupModelCnt > 0 && v.strGroupCondiName !== "")){
								makeHtml += "구매옵션 ("+v.groupModelCnt+")";
							} 
							if( v.groupModelCnt == 1 && v.strGroupCondiName == "일반"){
							}else if(v.intMallCnt3 > 0 && (v.groupModelCnt > 0 && v.strGroupCondiName !== "")){
								makeHtml += "		/ ";
							} 
							if(v.intMallCnt3 > 0){ 
								makeHtml += "		가격비교("+v.intMallCnt3+")";
							}
							makeHtml += "		</dt>";
							makeHtml += "	<dd>";
							/// 여기
							if(v.groupModelList){   
								var tarray = v.groupModelList;
								var groupModelMaxCnt = 5;
								var r1 = -1;
								var r2 = -1;
								for(var i=0;i<v.groupModelList.length;i++){
									var grouplistData = v.groupModelList[i];
									var strOrderTag = grouplistData["strOrderTag"];
									if(strOrderTag=="1") r1 = i;
									if(strOrderTag=="2" ) r2 = i;
									if(r1>0 && r2>0) break;
								}
							//	$.extend(tarray , groupModelList);
								if(r1>=groupModelMaxCnt && r2>=groupModelMaxCnt){
									
									tarray.splice(groupModelMaxCnt-2,0,v.groupModelList[r1],v.groupModelList[r2]);
									if(r1>r2){
										tarray.splice(r1+2,1);
										tarray.splice(r2+2,1);	
									}else{
										tarray.splice(r2+2,1);
										tarray.splice(r1+2,1);
									}
								}else if(r1>=groupModelMaxCnt){
									if(r2==(groupModelMaxCnt-1)){
										tarray.splice(groupModelMaxCnt-2,0,v.groupModelList[r2],v.groupModelList[r1]);
										tarray.splice(r2+2,1);
									} else {
										tarray.splice(groupModelMaxCnt-1,0,v.groupModelList[r1]);
									} 
									tarray.splice(r1+1,1);
								}else if(r2>=groupModelMaxCnt){
									if(r1==(groupModelMaxCnt-1)){
										tarray.splice(groupModelMaxCnt-2,0,v.groupModelList[r1],v.groupModelList[r2]);
										tarray.splice(r1+2,1);
									} else {
										tarray.splice(groupModelMaxCnt-1,0,v.groupModelList[r2]);
									} 
									tarray.splice(r2+1,1);
								}
								if(v.groupModelList.length > 0 ){  
									makeHtml += "	<table summary=\"기본 최저가 목록\">";
									makeHtml += "	<caption>기본 최저가 목록</caption>";
									makeHtml += "	<thead>";
									makeHtml += "		<tr>";
									makeHtml += "			<th>옵션</th>";
									if(v.groupModelList[0].unit){
										if(v.groupModelList[0].change > 1){
											makeHtml += "			<th>"+v.groupModelList[0].change+""+v.groupModelList[0].unit+"당가격<br />(배송포함)</th>";
										}else{
											makeHtml += "			<th>"+v.groupModelList[0].unit+"당가격<br />(배송포함)</th>";									
										}
									}else{
										makeHtml += "			<th></th>";								
									}
									makeHtml += "			<th>가격</th>";
									makeHtml += "		</tr>";
									makeHtml += "	</thead>";
									makeHtml += "	<tbody>"; 
									for(var i = 0; i < v.groupModelList.length; i ++){
										var minUnitClass = (v.groupModelList[i].unitPrice==v.minUnitPrice) ? "unit_lowest " : "";
										if(i < 5){
											makeHtml += "		<tr onclick=\"CmdVip('option2','"+v.groupModelList[i].intMutilModelNo+"');CmdGa('','','click_옵션선택'); ";
											if(v.intAdType == 2){ 
												makeHtml += "	CmdGaInfoad('"+v.groupModelList[i].intMutilModelNo+"', 'click_구매옵션');"; 
											} 
											makeHtml += " \">";
											makeHtml += "			<td>";
											if(v.groupModelList[i].strOrderTag){
												makeHtml += "			<em class=\"num\">"+v.groupModelList[i].strOrderTag+"위</em>";									
											}
											makeHtml += "			"+v.groupModelList[i].strBeginnerDicCondiname;
											//makeHtml += "			<em class=\"spon\">스폰서</em>";`
											makeHtml += "		</td>";
											if(v.groupModelList[i].unit == "" ){
												makeHtml += "			<td></td>";			
											}else if(v.groupModelList[i].unit){
												makeHtml += "			<td class=\""+minUnitClass+"\">"+v.groupModelList[i].unitPrice+"</td>";
											}else{
												makeHtml += "			<td></td>";			
											}
											makeHtml += "			<td>";
											makeHtml += "				<span class=\"priceLow\">";
											makeHtml += "				<span class=\"priceicon\" id=\"priceicon_"+v.groupModelList[i].intMutilModelNo+"\">";
											
											// 현금몰
											if(v.groupModelList[i].strCashMinFlag=="Y") {
												makeHtml += "		<span class=\"ico--cash\">현금</span>";
											// 해외직구
											} else if(v.groupModelList[i].strOvsMinFlag=="Y"){
												makeHtml += "		<span class=\"ico--global\">직구</span>";
											}
											
											if(v.groupModelList[i].longMinprice3 ==  v.lngMinPrice3){
												makeHtml += "				<strong class=\"txtLow\">최저가</strong>";
											}
											makeHtml += "				</span>";
											
											var tmpPriceHtml = commaNum(v.groupModelList[i].longMinprice3);
											
											// 현금몰 최저가
											if(v.groupModelList[i].strCashMinFlag=="Y" && ( v.groupModelList[i].longMinprice3 == 0 || v.groupModelList[i].lngCashMinPrice<v.groupModelList[i].longMinprice3 ) ) {
												tmpPriceHtml = commaNum(v.groupModelList[i].lngCashMinPrice);
											// TLC 카드 최저가
											} else if(v.groupModelList[i].lngTlcMinPrice>0) {
												tmpPriceHtml = commaNum(v.groupModelList[i].lngTlcMinPrice);
											}
											
											makeHtml += "				<em>" + tmpPriceHtml +"원</em></span>";
											makeHtml += "			</td>";
											makeHtml += "		</tr>";			
										}
									}
									makeHtml += "	</tbody>";
									makeHtml += "</table>";
									if(v.intModelNoOrg){
										makeHtml += "		<em class=\"btndetail\" onclick=\"CmdVip('option','"+v.intModelNoOrg+"');CmdGa('', '', 'click_옵션 전체보기');\">전체보기</em>";
									}else{
										makeHtml += "		<em class=\"btndetail\" onclick=\"CmdVip('option','"+v.intModelNo+"');CmdGa('', '', 'click_옵션 전체보기');\">전체보기</em>";
									}
								}
							}
							/// 여기
							makeHtml += "		</dd>";
							makeHtml += "	</dl>";
							makeHtml += "</div>";
						}
						
						makeHtml += "</div>";
						makeHtml += "</li>";
					}
				});
			}
		}
		//일반상품
		if(obj2){
			if(obj2.length > 0){
				$.each(obj2 , function(i,v){
					if(i==0 && !boolPowerShop && vFromPage == "Search") {
						getPowerShopping("SRP", v.ca_code, searchKeyword);
						boolPowerShop = true;
					}
					var vShopType = v.shop_type;
					var vShopTypeClass = "";
					if(vShopType =="4"){
						vShopTypeClass = "type_npay";
					}
					
					makeHtml += "<li>";     
					makeHtml += "<div class=\"listarea\" catecode=\""+v.ca_code+"\">"; 
					makeHtml += "	<a href=\"javascript:///\" onclick=\"addResentZzimItem(1, 'P', '"+v.pl_no+"');goSearchLog('"+v.pl_no+"'); goShop('"+v.url+"', '"+v.shop_code+"', "+v.pl_no+", '', '', '"+v.ca_code+"', '', '', '', '0'); \">"; 
					makeHtml += "		<p class=\"prodChoice\" onclick=\"event.cancelBubble=true;\"><button class=\"btnzzim\" id=\"btn_zzim_P"+v.pl_no+"\">찜하기<div class=\"zzimarea\"></div></button></p>"; 
					makeHtml += "		<span class=\"thum\" ><img src=\""+v.imgurl+"\" alt=\"\" onerror=\"this.src='http://photo3.enuri.com/data/working.gif'\"/></span>"; 
					makeHtml += "		<em class=\"mall "+vShopTypeClass+"\">"+v.shop_name+"</em>"; 
					makeHtml += "		<strong class=\"tit\">"+v.goodsnm+"</strong>"; 
					makeHtml += "		<span class=\"price\">";
					
					// 현금몰
					if(v.srvflag=="C"){
						makeHtml += "		<span class=\"ico--cash\">현금</span>";
					// 해외직구
					} else if(v.ovsflag=="Y"){
						makeHtml += "		<span class=\"ico--global\">직구</span>";
					}
					
					makeHtml += "			<span class=\"min\">최저가 </span><em>"+commaNum(v.instance_price)+"</em>원";
					makeHtml += "		</span>"; 
					makeHtml += "	</a>"; 
					
					//<!-- 191106 직구/현금몰 추가 - 리스트형/그리드형 - 직구 안내 아이콘 추가  -->
					if(v.ovsflag=="Y"){
						makeHtml += "<span class=\"ico--global_info\" onclick=\"$(this).next('.layer--global').show();\">안내</span>";
						makeHtml += "<span class=\"layer--global\" style=\"display:none\">";
						makeHtml += "	해외직구 상품으로 상품 정보, 가격, 배송비 등을 꼭 확인 후 구매하세요<i class=\"cls_x\" onclick=\"$(this).parent().hide();\">X</i>";
						makeHtml += "</span>";
					}
					
					makeHtml += "</div>"; 
					makeHtml += "</li>";  
				});  
			}
		}
		$(".prodList").html(makeHtml);
		$(".loading").hide();
}else{ 
 
}	
	
	
}
function zzimColor(){
	var loadUrl = "/lsv2016/ajax/getModelnoSaveGoods_ajax.jsp";

	$.ajax({
		url: loadUrl, 
		dataType:"JSON",  
		success: function(result){ 
			if(result.zzimList){
				$.each(result.zzimList, function(i,v){	 
						$("#btn_zzim_G"+v.modelno).addClass("on");
						$("#btn_zzim_P"+v.pl_no).addClass("on");
					//}
				}); 
			}
		}
	}); 
}
function getOption(modelno, cate){	//pc최저가 아이콘만 
	var optionCate = cate;
	var OptionObj = $("#p_"+modelno+"  dd");
	
	if(OptionObj.html()){
		$.ajax({
			type: "GET",
			url: "/mobilefirst/ajax/detailAjax/get_option.jsp",
			data: "modelno="+modelno+"&cate="+optionCate, //preview 1:5개, other:전부.
			dataType:"JSON",
			success: function(result){  
				if(result && result.optionDetail) {
					$.each(result.optionDetail, function(i,v){
						var makeHtml = "";
						if(v.optionMinpricePcflag == "Y"){
							makeHtml += "<strong id='iconPc_"+v.groupModelList[i].intMutilModelNo+"' class=\"iconPc\" style=\"display:none;\">PC</strong>";
						}
						$("#priceicon_"+v.optionModelno).append(makeHtml);
						//<!-- 191106 직구/현금몰 추가 - 리스트형 - 구매조건 옵션리스트 아이콘 추가  -->
						var iconHtml = "";
						if(v.cashflag=="Y" && !$("#priceicon_cash_"+v.optionModelno) ){
							iconHtml = "<span class=\"ico--cash\" id=\"priceicon_cash_"+v.optionModelno+"\">현금</span>";
						} else if(v.ovsflag == "Y" && !$("#priceicon_global_"+v.optionModelno)){
							iconHtml = "<span class=\"ico--global\" id=\"priceicon_global_"+v.optionModelno+"\">직구</span>";
						}
						$("#priceicon_"+v.optionModelno).before(iconHtml);
					});
				}
				/*
				OptionObj.html(null);		
				var template = " ";
				template += "	<table summary=\"기본 최저가 목록\">";
				template += "	<caption>기본 최저가 목록</caption>";
				template += "	<thead>";
				template += "		<tr>";
				template += "			<th>옵션</th>";
				if(result.optionUnit){
					//if(result.optionUnit > 1){
					//	template += "			<th>"+v.groupModelList[0].change+""+v.groupModelList[0].unit+"당가격<br />(배송포함)</th>";
					//}else{
						template += "			<th>"+result.optionUnit.replace("(","<br/>(")+"</th>";									
					//}
				}else{
					template += "			<th></th>";								
				}
				template += "			<th>가격</th>";
				template += "		</tr>";
				template += "	</thead>";
				template += "	<tbody>"; 
				$.each(result.optionDetail, function(i,v){	
					if(i < 5){
						template += "		<tr onclick=\"CmdVip('option2','"+v.optionModelno+"');\">";
						template += "			<td>";
						if(v.optionRank){
							//if(v.optionRank < 3){
								template += "			<em class=\"num\">"+v.optionRank+"위</em>";
							//}
						}
						template += "			"+v.optionCondiname;
						//template += "			<em class=\"spon\">스폰서</em>";`
						template += "		</td>";
						if(v.optionUnitprice == ""){
							template += "			<td></td>";			
						}else{
							template += "			<td>"+v.optionUnitprice+"</td>";
						}
						template += "			<td>";
						template += "			<span class=\"priceLow\">";
						template += "			<span class=\"priceicon\">";
						if(v.optionMinpricePcflag == "Y"){
							template += "				<strong class=\"iconPc\">PC</strong>";
						} 
						if(v.optionMinpriceflag == "Y"){
							template += "				<strong class=\"txtLow\">최저가</strong>";
						}
						template += "				</span>";
						template += "			<em>" +v.optionPrice+"</em></span>";
						template += "			</td>";
						template += "		</tr>";			
					}
				});
				template += "	</tbody>";
				template += "</table>";
				template += "		<em class=\"btndetail\" onclick=\"CmdVip('option','"+modelno+"');\">전체보기</em>";
				OptionObj.html(template);	*/
			}
		}); 
	}
	
	/*	makeHtml += "	<table summary=\"기본 최저가 목록\">";
		makeHtml += "	<caption>기본 최저가 목록</caption>";
		makeHtml += "	<thead>";
		makeHtml += "		<tr>";
		makeHtml += "			<th>옵션</th>";
		if(v.groupModelList[0].unit){
			if(v.groupModelList[0].change > 1){
				makeHtml += "			<th>"+v.groupModelList[0].change+""+v.groupModelList[0].unit+"당가격<br />(배송포함)</th>";
			}else{
				makeHtml += "			<th>"+v.groupModelList[0].unit+"당가격<br />(배송포함)</th>";									
			}
		}else{
			makeHtml += "			<th></th>";								
		}
		makeHtml += "			<th>가격</th>";
		makeHtml += "		</tr>";
		makeHtml += "	</thead>";
		makeHtml += "	<tbody>"; 
		for(var i = 0; i < v.groupModelList.length; i ++){
			if(i < 5){
				makeHtml += "		<tr onclick=\"CmdVip('option2','"+v.groupModelList[i].intMutilModelNo+"');\">";
				makeHtml += "			<td>";
				if(v.groupModelList[i].strOrderTag){
					makeHtml += "			<em class=\"num\">"+v.groupModelList[i].strOrderTag+"위</em>";									
				}
				makeHtml += "			"+v.groupModelList[i].strBeginnerDicCondiname;
				//makeHtml += "			<em class=\"spon\">스폰서</em>";`
				makeHtml += "		</td>";
				if(v.groupModelList[i].unit == ""){
					makeHtml += "			<td></td>";			
				}else{
					makeHtml += "			<td>"+v.groupModelList[i].unitPrice+"</td>";
				}
				makeHtml += "			<td>";
				makeHtml += "			<span class=\"priceLow\">";
				makeHtml += "			<span class=\"priceicon\">";
				if(v.groupModelList[i].longMinprice3 > v.groupModelList[i].longMinprice){
					makeHtml += "				<strong class=\"iconPc\">PC</strong>";
				} 
				if(v.groupModelList[i].longMinprice3 ==  v.lngMinPrice3){
					makeHtml += "				<strong class=\"txtLow\">최저가</strong>";
				}
				makeHtml += "				</span>";
				makeHtml += "			<em>" +commaNum(v.groupModelList[i].longMinprice3)+"원</em></span>";
				makeHtml += "			</td>";
				makeHtml += "		</tr>";			
			}
		}
		makeHtml += "	</tbody>";
		makeHtml += "</table>";
		makeHtml += "		<em class=\"btndetail\" onclick=\"CmdVip('option','"+v.intModelNoOrg+"');\">전체보기</em>";
		*/
}

//업체
function getMall(modelno){
	var mallObj = $("#p_"+modelno+"  dd");
	
	if(mallObj.html()){
		$.ajax({
			type: "GET",
			url: "/mobilefirst/ajax/detailAjax/get_list.jsp",
			data: "page=1&tabinfoyn=Y&pagesize=10&modelno="+modelno, //preview 1:5개, other:전부.
			dataType:"JSON",
			success: function(result){  
				mallObj.html(null);		
					var template = " ";
					var pcFlag = result.pcPriceyn;
					var minPriceHtml = "";
					var cashBool = "N";

					$.each(result.listContent, function(i,v){	
						if(i == 0){
							if(v.shopname == "PC 최저가"){
								template += "			<table  class=\"pc_price\" summary=\"기본 최저가 목록\">	";										
							}else{
								template += "			<table  summary=\"기본 최저가 목록\">	";		
							}
							template += "			<caption>기본 최저가 목록</caption>	";			
						}
						if(v.shopname == "PC 최저가"){
							template += "			<thead>	";		
							template += "				<tr onclick=\"$('#onlypc').show();\">	";			 
							template += "					<th>PC 최저가<em>?</em></th>	";			 
							template += "					<th></th>	";			 
							template += "					<th>"+v.price.trim()+"</th>	";			 
							template += "				</tr>	";			 
							template += "			</thead>	";				 
						}else{
							if(i == 0){
								template += "			<thead>	";		
								template += "				<tr>	";			 
								template += "					<th>쇼핑몰</th>	";			 
								template += "					<th></th>	";			 
								template += "					<th>가격</th>	";			 
								template += "				</tr>	";			 
								template += "			</thead>	";		
							}
							if(pcFlag == "Y" && i == 1){
								template += "			<tbody>	";			  
							}
							template += "				<tr onclick=\"goShop('"+v.mobileurl+"', '"+v.shopcode+"', '"+v.plno+"', '', '', '"+v.ca_code+"', '', '', '', '0'); \">	";			 
							template += "					<td>"+v.shopname+"</td>	";			 
							template += "					<td>"+v.displaydelivery+"</td>	";			
							template += "					<td>";				
							if(v.shop_bid){
								template += "					<em class=\"spon\">스폰서</em>";					
							}
							//<!-- 191106 직구/현금몰 추가 - 리스트형 - 구매조건 옵션리스트 아이콘 추가  -->
							if(v.cashflag=="Y"){
								template += "					<span class=\"ico--cash\">현금</span>";
								cashBool = "Y";
							} else if(v.ovsflag=="Y"){
								template += "					<span class=\"ico--global\">직구</span>";
							}
							template += "						<span class=\"priceLow\">";
							
							// 현금몰이면서 최저가일 경우 최저가 표기는 그 다음순서에 한다.
							if(result.instanceMinPrice == v.instanceprice){
								minPriceHtml = "					<span class=\"priceicon\"><strong class=\"txtLow\">최저가</strong></span>";
							} 
							if(minPriceHtml.length>0 && (v.ovsflag=="Y" || cashBool == "N")) {
								template += minPriceHtml;
								minPriceHtml = "";
							}
							
							if(v.cashflag=="Y" && result.instanceMinPrice == v.instanceprice) {
								cashBool="N";
							}
							
							template += "						<em>"+commaNum(v.instanceprice)+"원</em>	";			
							template += "						</span>";
							template += "					</td>	";					
						} 
 						template += "				</tr>	";			 
 						if(pcFlag == "Y" && i == 5){
 							return false;
 						}else if(pcFlag != "Y" && i == 4){
 							return false;
 						}  
					});
					template += "			</tbody>	";			 
					template += "			</table>	";	
					template += "		<em class=\"btndetail\" onclick=\"CmdVip('mall','"+modelno+"');CmdGa('','','click_쇼핑몰 전체보기');\">전체보기</em>";
	
				mallObj.html(template);	
			}
		}); 
	}
}

function cmdSocialList(){
	var cate4 = cate;

	if(cate4.length >=4){
		cate4 = cate4.substring(0,4);
	}
	var loadUrl = "/mobilefirst/ajax/listAjax/getListDealMini_ajax.jsp?cate="+cate4;		
	var makeHtml = ""; 
	
	$.ajax({  
		url: loadUrl, 
		dataType:"JSON", 
		success: function(result){ 
			if(result.goods.length > 0){
					$.each(result.goods , function(i,v){
						makeHtml += "<li>";
						makeHtml += "<a href=\"#\">";
						makeHtml += "	<img src=\""+v.img2+"\" class=\"thum\" />";
						//makeHtml += "	<span class=\"mall\"><img src=\"http://img.enuri.info/images/board/big/logo_6641b.gif\" alt=\"티몬\" /></span>";
						makeHtml += "	<span class=\"mall\">"+v.company+"</span>";
						makeHtml += "	<strong>"+v.name+"</strong>";
						makeHtml += "	<div class=\"price\">";
						if(v.rate > 0){
							makeHtml += "	<span class=\"per\">"+v.rate+"<em>%</em></span>";							
						}else{
							makeHtml += "	<span class=\"sp\">특가</span>";
						}
						makeHtml += ""+v.price+"<b>원</b></div>";
						makeHtml += "</a>";
						makeHtml += "</li>";
					}); 
					$(".hit_product").append(makeHtml);
			}else{ 
				$(".con_box").hide();
			}	
		}
	});
}

function cmdIngiList(){

	var loadUrl = "/mobilefirst/api/main/mobile_mainlistfix.json";		
	var makeHtml = ""; 
	
	$.ajax({  
		url: loadUrl, 
		dataType:"JSON", 
		success: function(result){ 
			if(result.MainJsonfix.length > 0){
					$.each(result.MainJsonfix , function(i,v){
						if(v.part == "C" || v.part == "D" || v.part == "T" ){
							makeHtml += "<li onclick=\"goShop('"+v.url+"', '"+v.shopcode+"', '"+v.pl_no+"', '', '', '"+v.category+"', '', '', '', '0'); \">";
							makeHtml += "<a href=\"#\">";
							makeHtml += "	<img src=\""+v.img+"\" class=\"thum\" />";
							makeHtml += "	<span class=\"mall\"><img src=\"http://img.enuri.info/images/view/ls_logo/2013/Ap_logo_"+v.shopcode+".png\"></span>";
							makeHtml += "	<strong>"+v.modelnm+"</strong>";
							makeHtml += "	<div class=\"price\">";
							if(v.bbs_staravg > 0){
								makeHtml += "	<span class=\"per\">"+v.bbs_staravg+"<em>%</em></span>";							
							}else{
								makeHtml += "	<span class=\"sp\">특가</span>";
							}
							makeHtml += ""+commaNum(v.price)+"<b>원</b></div>";
							makeHtml += "</a>";
							makeHtml += "</li>";
						}
					}); 
					$(".hit_product").append(makeHtml);
			}else{ 
				$(".con_box").hide();
			}	
		}
	});
}
function cmdLinkageKwd(){
	var loadUrl = "/lsv2016/ajax/getLinkageKeyword_ajax.jsp?procType=1&keyword="+$("#all_keyword").val();		
	var makeHtml = ""; 

	$.ajax({  
		url: loadUrl, 
		dataType:"JSON", 
		success: function(result){ 
			makeHtml = "";
			if(result.linkageKeywordList){
				$.each(result.linkageKeywordList, function(i,v){
					if(i < 10){
						makeHtml += "<li onclick=\"CmdSList('"+v.linkageKeyword+"');\"><span>"+v.linkageKeyword+"</span></li>";
					}
				}); 
				$("#relate .relate_area ul").html(makeHtml);
			}
			if(makeHtml == ""){
				$("#relate").hide();
			}else{
				$("#relate").show();
			}
		}
	});
}

//spec display
function makeSpecTagDic(vip_spec, modelno) {
	if(!vip_spec) return "";

	var svt = vip_spec;
	// g   완전일치(발생할 모든 pattern에 대한 전역 검색)
	// i  대/소문자 무시
	// gi  대/소문자 무시하고 완전 일치
	var regFinder = /[$][T][A][G][$][^$]+[$][E][N][D][$]/g;
	var bTag1 = "</b>";
	var bTag2 = "----b----";
	var brTag1 = "</br>";
	var brTag2 = "----br----";

	var rtnValue = "";

	// 태그 빼기
	svt = svt.split(bTag1).join(bTag2);
	svt = svt.split(brTag1).join(brTag2);

	var svtAry = svt.split("/");
	var sShowText2 = "";
	
	for(var i=0; i<svtAry.length; i++) {
		var svtItem = svtAry[i];

		var findStrAry = svtItem.match(regFinder);
		var findSpecNo = "";
		
		
		var arrText1 = svtItem.split("$TAG$");
		var sShowText = "";
		
		for( var vText1 = 0 ; vText1 < arrText1.length ; vText1++){
			if(arrText1[vText1].substring(0,1) == "_"){
				var arrText2 = arrText1[vText1].split("_");
				var arrTextClick = arrText2[2].substring(0, arrText2[2].indexOf("$END$")).replace("\"","″");
				arrTextClick = arrTextClick.replace(/&#39/gi, "");

				if(arrText2 && arrText2.length>=2) {
					if(sShowText.length > 0){ 
						sShowText = sShowText + "<em class=\"add \" specno=\""+arrText2[1]+"\" onclick=\"CmdListSpec('"+arrText2[1]+"','"+arrTextClick+"');\">"+arrText2[2].replace("$END$","</em>").replace("\"","″");
						sShowText2 = sShowText2 + arrText2[2].replace("$END$","");
					}else{
						sShowText = "<em class=\"add \" specno=\""+arrText2[1]+"\" onclick=\"CmdListSpec('"+arrText2[1]+"','"+arrTextClick+"');\">#"+arrText2[2].replace("$END$","</em>").replace("\"","″");
						sShowText2 = sShowText2 +"#" +arrText2[2].replace("$END$","");
					}
				} 	
				
				sShowText = sShowText.replace(/&amp;#47;/gi, "/");
			}else{
				sShowText = arrText1[vText1];
				sShowText2 = sShowText2+arrText1[vText1];
				
				sShowText = sShowText.replace(/&amp;#47;/gi, "/");
				//console.log("sShowText>>>"+sShowText);
			} 
		}
		
		if(sShowText.indexOf(">#") > -1){ 
			rtnValue += "<a href=\"javascript:///\">"+sShowText+"</a>";					
		}else{
			rtnValue += "<a href=\"javascript:///\">#"+sShowText+"</a>";		
			sShowText2 = sShowText2 + "#";
		}
	}
	// 태그 넣기
	rtnValue = rtnValue.split(bTag2).join(bTag1);
	rtnValue = rtnValue.split(brTag2).join(brTag1);
	//console.log(sShowText2.length);	
	
	if(sShowText2.length < 70){
		rtnValue = "<span style=\"display:none;\">더보기</span>"+rtnValue;
	}else{
		rtnValue = "<span>더보기</span>"+rtnValue;
	}
	
	return rtnValue;
}

function CmdListSpec(specno, text){
	//if($(".d_type").is(":visible")){
	//	return false;
	//}
	 
	var bSpec = false;
	text = text.replace("#","");
	
	$.each(arrChkReal , function(i,v){
		if(arrChkReal[i][0] == "s"){ 
			if(arrChkReal[i][1].substring(arrChkReal[i][1].indexOf("_")+1, arrChkReal[i][1].length) == specno){
				arrChkReal[i][0] = "";
				arrChkReal[i][1] = "";
				arrChkReal[i][2] = "";
				bSpec = true;
			}
		}
	});
	$.each(arrChkTmp , function(i,v){
		if(arrChkTmp[i][0] == "s"){
			if(arrChkTmp[i][1].substring(arrChkTmp[i][1].indexOf("_")+1, arrChkTmp[i][1].length) == specno){
				arrChkTmp[i][0] = "";
				arrChkTmp[i][1] = "";
				arrChkTmp[i][2] = "";
				bSpec = true;
			}
		}
	});
	$(".prodList > li > div > div > a > em").each(function(){
		var seqTemp = $(this).attr("specno");
		if(specno ==seqTemp ){ 
			if(bSpec){
				$(this).removeClass("on");
				$(this).addClass("add");
			}else{
				$(this).removeClass("add");
				$(this).addClass("on");		
			}
		}
	});
	
	
	if(!bSpec){
		var idx = arrChkReal.length;
		
		arrChkReal[idx] = new Array();
		arrChkReal[idx][0] = "s";
		arrChkReal[idx][1] = specno;
		arrChkReal[idx][2] = text;
		
		var idx2 = arrChkTmp.length;
		
		arrChkTmp[idx2] = new Array();
		arrChkTmp[idx2][0] = "s";
		arrChkTmp[idx2][1] = specno;
		arrChkTmp[idx2][2] = text;
	}
	 
    if( document.URL.indexOf("/list.jsp") > -1){
    	ga('send', 'event', 'mf_lp', 'lp_common', 'click_속성');
    }else if( document.URL.indexOf("/search.jsp") > -1){
    	ga('send', 'event', 'mf_srp', 'srp_common', 'click_속성');
    }
    
	$("#sch_go").click();
}
function CmdListSpec2(specno, text){
	var bSpec = false;
	
	$.each(arrChkReal , function(i,v){
		if(arrChkReal[i][0] == "s"){
			if(arrChkReal[i][1].substring(arrChkReal[i][1].indexOf("_")+1, arrChkReal[i][1].length) == specno){
				arrChkReal[i][0] = "";
				arrChkReal[i][1] = "";
				arrChkReal[i][2] = "";
				bSpec = true;
			}
		}
	});
	
	$(".prodList > li > div > div > a > em").each(function(){
		var seqTemp = $(this).attr("specno");
		if(specno ==seqTemp ){ 
			if(bSpec){
				$(this).removeClass("on");
				$(this).addClass("add");
			}else{
				$(this).removeClass("add");
				$(this).addClass("on");		
			}
		}
	});
	
	if(!bSpec){
		var idx = arrChkReal.length;
		
		arrChkReal[idx] = new Array();
		arrChkReal[idx][0] = "s";
		arrChkReal[idx][1] = specno;
		arrChkReal[idx][2] = text;
	}
	 
	$("#sch_go").click();
}
//필터링탭
var vListTab_org = "";

function CmdFilterBox(){ 
	var vListTab = "1";

	if(vFromPage == "Search" && $("#all_keyword").val() == ""){
		return false;
	}
	
	if(bFilter && !(vFromPage == "Search" && $("#cate").val().length > 0)){
		if(vFromPage == "Search" ){
			if($("[data-id='tab04']").is(":visible")){
			}else{
				$("#sch_factory").remove();
			}
		}
	}else{

		var loadUrl = "";
		 
		if(vFromPage == "Search" ){
			//loadUrl = "/lsv2016/ajax/getSearchInfoList_ajax.jsp?cate="+$("#cate").val()+"&keyword="+$("#all_keyword").val();
			loadUrl = "/lsv2016/ajax/getSearchInfoList_ajax.jsp?cate="+$("#cate").val()+"&keyword="+vAllKeyword;
		}else{
			//loadUrl = "/mobilefirst/api/appCateSpecMenu.jsp?cate="+cate+"&factory=Y&brand=Y&spec=Y";
			if( cate == "163619" ) {
				loadUrl = "/mobilefirst/api/appCateSpecMenu331.jsp?cate="+cate+"&factory="+rFactory+"&brand=N&spec=Y";
			} else {
				loadUrl = "/mobilefirst/api/appCateSpecMenu331.jsp?cate="+cate+"&factory="+rFactory+"&brand="+rBrand+"&spec=Y";
			}
		} 
		var makeHtml = ""; 
		var html_LF = "";
		var html_LB = "";
		var html_LS = "";
		
		$.ajax({  
			url: loadUrl,  
			dataType:"JSON",  
			//async : false,
			success: function(result){  
				bFilter = true;
				if(vFromPage == "List" ){
					//제조사 _ lp_right 
					if(result.getFactory_ajax){
						if(result.getFactory_ajax.factoryList){
							$.each(result.getFactory_ajax.factoryList , function(i,v){ 
								if(i < 8){
									makeHtml += "<li id=\"f_"+v.factory+"\" name=\""+v.factory+"\">"+v.factory+"("+commaNum(v.cnt)+")</li>";
								}
								arrFactory[i] = v.factory+"("+v.cnt+")"; 
							}); 
							if(result.getFactory_ajax.factoryList.length < 9){
								$("#sch_factory .sub .all").hide();
							}
							$("#sch_factory .sub ul").html(makeHtml);
						}else{
							$("#sch_factory").hide(); 
						}
					}else{ 
						$("#sch_factory").hide();
					}	 
					//제조사 _ lp_swipe 
					if(result.getFactory_ajax){
						if(result.getFactory_ajax.factoryList){
							$.each(result.getFactory_ajax.factoryList , function(i,v){
								if(i < 30){
									if(i % 6 == 0){
										html_LF += "<li class=\"swiper-slide\"><ul>";
									}
									html_LF += "<li id='sl_f_"+v.factory+"' name=\""+v.factory+"\" onclick=\"cmdSearch('f','"+v.factory+"','"+v.factory+"');\"><em>"+v.factory+"</em></li>";
									if(i % 6 == 5 || i == result.getFactory_ajax.factoryList || i == 29){
										html_LF += "</ul></li>";
									} 
								}
							});	
						}
						$("#tab01 div ul").html(html_LF); 
						$("[data-id='tab01']").show();
					}else{
						if(	!bFirst ){  
							$("[data-id='tab01']").hide();
							vListTab = "2";
							//$("[data-id='tab02']").click();
						}else{
							return false;
						} 
					}
					//브랜드 _ lp
					makeHtml = "";
					if(result.getBrand_ajax){
						if(result.getBrand_ajax.brandList){
							$.each(result.getBrand_ajax.brandList , function(i,v){
								if(i < 8){
									makeHtml += "<li id=\"b_"+v.brand+"\" name=\""+v.brand+"\">"+v.brand+"("+commaNum(v.cnt)+")</li>";
								} 
								arrBrand[ i] = v.brand+"("+v.cnt+")"; 
							}); 
							if(result.getBrand_ajax.brandList.length < 9){
								$("#sch_brand .sub .all").hide(); 
							}
							$("#sch_brand .sub ul").html(makeHtml);
						}else{
							$("#sch_brand").hide();
						}
					}else{ 
						$("#sch_brand").hide();
					}	
					//브랜드 _ lp_swipe 
					if(result.getBrand_ajax){
						if(result.getBrand_ajax.brandList){
							$.each(result.getBrand_ajax.brandList , function(i,v){
								if(i < 30){
									if(i % 6 == 0){
										html_LB += "<li class=\"swiper-slide\"><ul>";
									}
									html_LB += "<li id='sl_b_"+v.brand+"' name=\""+v.brand+"\" onclick=\"cmdSearch('b','"+v.brand+"','"+v.brand+"');\"><em>"+v.brand+"</em></li>";
									if(i % 6 == 5 || i == result.getBrand_ajax.brandList || i == 29){
										html_LB += "</ul></li>";
									} 
								}
							});	
						}
						$("#tab02 div ul").html(html_LB); 
						$("[data-id='tab02']").show(); 
					}else{
						//if(	!bFirst ){ 
							$("[data-id='tab02']").hide();
						//}else{
						//	return false;
						//} 
					}
				}
				if(vFromPage == "Search" ){
					//제조사 _ srp
					if(result.factoryList){
						if(result.factoryList.factoryList){
							$.each(result.factoryList.factoryList , function(i,v){
								if(i < 8){
									makeHtml += "<li id=\"f_"+v.factoryShowName+"\" name=\""+v.factoryShowName+"\">"+v.factoryShowName+"</li>";
								}
								arrFactory[i] = v.factoryShowName; 
							}); 
							$("#sch_factory .sub ul").html(makeHtml);
							$("#sch_factory").show(); 
						}else{
							$("#sch_factory").hide(); 
						}
					}else{ 
						$("#sch_factory").hide();
					}	 
	
					//브랜드 _ srp
					makeHtml = ""; 
					if(result.brandList){
						if(result.brandList.brandList){
							$.each(result.brandList.brandList , function(i,v){
								if(i < 8){
									makeHtml += "<li id=\"b_"+v.brandShowName+"\" name=\""+v.brandShowName+"\">"+v.brandShowName+"</li>";
								}
								arrBrand[ i] = v.brandShowName; 
							}); 
							$("#sch_brand .sub ul").html(makeHtml);
							$("#sch_brand").show(); 
						}else{
							$("#sch_brand").hide();
						}
					}else{ 
						$("#sch_brand").hide();
					}	
				}
				//스펙  _ lp
				makeHtml = "";
				if(result.getCateSpecMenu_ajax){
					if(result.getCateSpecMenu_ajax.specCateList){
						$.each(result.getCateSpecMenu_ajax.specCateList , function(i,v){
							//makeHtml += "<li id=\""+v.intCateKbNo+"\"><a href=\"#\">"+v.strSpecCateTitle+"<span></span></a>";
							makeHtml += "<li id=\""+(i+3)+"\"><a href=\"#\">"+v.strSpecCateTitle+"<span></span></a>";
							makeHtml += "		<div class=\"sub\">	";
							makeHtml += "			<ul>	"; 
							if(v.specMenuList){ 
								$.each(v.specMenuList, function(i2,v2){
									makeHtml += "				<li id=\"s_"+v2.intSpecNo+"\" name=\""+v2.strSpecGroupTitle+"\">"+v2.strSpecGroupTitle+"</li>";
								});  
							} 
							makeHtml += "			</ul>	";
							makeHtml += "		</div>	";
							makeHtml += "	</li>	";
						}); 
	
						$("#sch_spec").html(makeHtml);
					}else{ 
						$("#sch_spec").hide();
					}
				}else{ 
					$("#sch_spec").hide();
				}	
				
				//스펙 _ lp_swipe
				if(result.getCateSpecMenu_ajax){
					if(result.getCateSpecMenu_ajax.specCateList){
						$.each(result.getCateSpecMenu_ajax.specCateList , function(i,v){
							if(v.specMenuList && i < 7){ 
								$("[data-id='tab0"+(3+i)+"'] > a").html(v.strSpecCateTitle);
								html_LS = ""; 
								$.each(v.specMenuList, function(i2,v2){
									if(i2 < 30){
										if(i2 % 6 == 0){
											html_LS += "<li class=\"swiper-slide\"><ul>";
										}
										html_LS += "<li id='sl_s_"+v2.intSpecNo+"' name=\""+v2.strSpecGroupTitle+"\" onclick=\"cmdSearch('s','"+v2.intSpecNo+"','"+v2.strSpecGroupTitle+"');\"><em>"+v2.strSpecGroupTitle+"</em></li>";
										if(i2 % 6 == 5 || i2 == result.getCateSpecMenu_ajax.specCateList.specMenuList || i2 == 29){
											html_LS += "</ul></li>";
										} 
									}
								});  
								$("#tab0"+(3+i)+" div ul").html(html_LS);  
								$("[data-id='tab0"+(3+i)+"']").show(); 
							}
						});
					} 
				}
			},  
			complete: function(){  
				vListTab_org = vListTab;
				
				CmdFilterChk3(); 
				
				/*필터검색*/
				$(".sch_list li a").unbind("click");
				$(".sch_list li a").click(function() {
					$(this).toggleClass( "on" );
					$(this).next().slideToggle("fast").parent().siblings().children(".sub");
					return false;
				}); 
				$(".sub ul li").unbind("click");
				$(".sub ul li").click(function(){
					
					if($(this).hasClass("chk")){
						$(this).removeClass("chk");				
						CmdFilterChk(this.id, 'off', $(this).attr("name"));
					}else{
						$(this).addClass("chk");
						CmdFilterChk(this.id,'on', $(this).attr("name"));
												
						if(vFromPage == "Search" ){
						}else{
							var cateNm = $(this).attr("name");
							var iseObj = new Object();
							iseObj.ca_code = szCategoryPower;	
							iseObj.lp_type = "C";
							
							if( this.id.indexOf("f_") > -1 ){
								iseObj.attType = "F";//제조사
								iseObj.fbName = cateNm;
							}else if(this.id.indexOf("b_") > -1) {
								iseObj.attType = "B";//브랜드
								iseObj.fbName = cateNm;
							}else if(this.id.indexOf("s_") > -1) {
								
								var specNo = (this.id).replace("s_","");
								iseObj.attType = "S";//브랜드
								iseObj.specNo = specNo;
							}
							iseObj.logType = "3";
							insSearchlog(iseObj);
						}
					}  
				});
				if(vFromPage == "Search" ){
					if($("[data-id='tab04']").is(":visible")){
					}else{
						$("#sch_factory").remove();
					}
				}else{
					/*swiper = undefined;
					setTimeout(function(){
						 swiper = new Swiper('.sw_tab01', {
								pagination: '.swiper-pagination',
								paginationClickable: true 
							 });
					},1000); */
					if(vListTab == "1"){
						swiper = undefined;  
						$("#tab0"+vListTab+" span:first").click();
						setTimeout(function(){
							 swiper = new Swiper('.sw_tab0'+vListTab, {
									pagination: '.sw_tab0'+vListTab+' .swiper-pagination',
									paginationClickable: true,
									onSlideChangeStart : function(swiper){
										var index = swiper.activeIndex;
							            $('.sw_tab0'+vListTab+' .swiper-pagination-bullets span').removeClass('swiper-pagination-bullet-active');
							            $('.sw_tab0'+vListTab+' .swiper-pagination-bullets  span:eq(' + index + ')').addClass('swiper-pagination-bullet-active');
									} 
								 });
						},1200);     
					}else{  
						if(!($("[data-id='tab01']").is(":visible")) && !($("[data-id='tab02']").is(":visible"))){
							$("[data-id='tab03']").click();
						}else{
							$("[data-id='tab0"+vListTab+"']").click();
						}
					}
					
					// 20200305 마스크 예외처리
					if( cate == 163619) {
						setTimeout(function(){
							$("[data-id='tab03']").click();
						}, 500 );
					}
					
				} 
			} 
		});  
	} 
}  

//필터링 체크박스, 배열on
function CmdFilterChk(id, onoff, name){ 
	var vType = id.substring(0, id.indexOf("_"));
	var vID = id.substring(id.indexOf("_")+1, id.length);
	var vName = name;

	if(vType == "f" || vType == "f2") 	{
		vType = "f";
	}

	if(vType == "b" || vType == "b2") 	{
		vType = "b";
	}
	
	//alert("arrChkTmp에 담기  --> " + vType + " , "+vID+" , "+name+" , "+onoff);
	  
	if(onoff == "on"){
		idx = arrChkTmp.length;
		arrChkTmp[idx] = new Array();
		arrChkTmp[idx][0] = vType;
		arrChkTmp[idx][1] = vID;
		arrChkTmp[idx][2] = vName;
		if(vType == "f"){ 
			//$("#"+vType+"_"+vID).addClass("chk");
			//$("#"+vType+"2_"+vID).addClass("on");
			$("#tab01 li[name='"+arrChkTmp[idx][2]+"']").addClass("on");			
			$("#sch_factory li[name='"+arrChkTmp[idx][2]+"']").addClass("chk");
			$("#allview_search .factory li[name='"+arrChkTmp[idx][2]+"']").addClass("chk");
		} 
		if(vType == "b"){ 
			//$("#"+vType+"_"+vID).addClass("chk");
			//$("#"+vType+"2_"+vID).addClass("on");
			$("#tab02 li[name='"+arrChkTmp[idx][2]+"']").addClass("on");			
			$("#sch_brand li[name='"+arrChkTmp[idx][2]+"']").addClass("chk");	
			$("#allview_search .brand li[name='"+arrChkTmp[idx][2]+"']").addClass("chk");
		} 
		if(vType == "k"){
			$("#srhRe").val(vID); 
			$("#srhKeyword").val(vID);
		}
		if(vType == "s"){
			$("#s_"+vID).addClass("chk");
			var vCnt = $("#s_"+vID).parent().parent().parent().find("span").text();
			if(vCnt == "") vCnt = 0;
			var sCnt = parseInt(vCnt);
			sCnt++;  
			$("#s_"+vID).parent().parent().parent().find("span").text(sCnt);
		}  
	}else{ 
		$.each(arrChkTmp, function(i,v){
			if(arrChkTmp[i][0] == vType && arrChkTmp[i][1] == vID){
				if($("li[name='"+arrChkTmp[i][2]+"']")){
					$("li[name='"+arrChkTmp[i][2]+"']").removeClass("on");
				}
				arrChkTmp[i][0] = ''; 
				arrChkTmp[i][1] = '';
				arrChkTmp[i][2] = '';  
				if(vType == "f"){  
					//$("#"+vType+"_"+vID).removeClass("chk");
					//$("#"+vType+"2_"+vID).removeClass("on"); 
					//$("#sl_f_"+vID).removeClass("on");
					$("#tab01 li[name='"+arrChkTmp[i][2]+"']").addClass("on");			
					$("#sch_factory li[name='"+arrChkTmp[i][2]+"']").addClass("chk");			
					$("#allview_search li[name='"+arrChkTmp[i][2]+"']").addClass("chk");
				}  
				if(vType == "b"){ 
					//$("#"+vType+"_"+vID).removeClass("chk");
					//$("#"+vType+"2_"+vID).removeClass("on");
					//$("#sl_b_"+vID).removeClass("on");
					$("#tab02 li[name='"+arrChkTmp[i][2]+"']").addClass("on");			
					$("#sch_brand li[name='"+arrChkTmp[i][2]+"']").addClass("chk");			
					$("#allview_search li[name='"+arrChkTmp[i][2]+"']").addClass("chk");
				} 
				if(vType == "k"){
					$("#srhRe").val("");
					$("#srhKeyword").val("");
				}
				if(vType == "s"){
					$("#s_"+vID).removeClass("chk");
					var vCnt = $("#s_"+vID).parent().parent().parent().find("span").text();
					if(vCnt == "") vCnt = 0;
					var sCnt = parseInt(vCnt);
					sCnt--;  
					if(sCnt == 0){
						$("#s_"+vID).parent().parent().parent().find("span").text("");						
					}else{
						$("#s_"+vID).parent().parent().parent().find("span").text(sCnt);
					}
					$("#sl_s_"+vID).removeClass("on");
				}
			} 
		});
	}
	
	//타이틀옆 카운트 (제조사, 브랜드, 스펙)
	 var fCnt = 0;
	 var bCnt = 0;
	  
	 $.each(arrChkTmp, function(i,v){
		if(arrChkTmp[i][0] == "f"){
			fCnt = fCnt + 1;
		}
		if(arrChkTmp[i][0] == "b"){
			bCnt = bCnt + 1;
		}
	 }); 
	 
	 if(vType == "f"){
		 if(fCnt == 0){
			$("#sch_factory a span").html("");		
			$("#filter_all h2 em").html("");
	    }else{
			$("#sch_factory a span").html(fCnt);
			$("#filter_all h2 em").html(fCnt);
	    }
	 }
	if(vType == "b"){
		if(bCnt == 0){
			$("#sch_brand a span").html("");		
			$("#filter_all h2 em").html("");
		}else{
			$("#sch_brand a span").html(bCnt);		
			$("#filter_all h2 em").html(bCnt);
		}
	}
	//필터링 텍스트 영역+삭제버튼
	var ChkText = "";
	 
	$.each(arrChkTmp, function(i,v){
		if(arrChkTmp[i][1]){
			ChkText = ChkText + "<li onclick=\"CmdFilterDel('2','"+arrChkTmp[i][0]+"','"+arrChkTmp[i][1]+"')\">"+arrChkTmp[i][2]+"<em>삭제</em></li>";
		}
	});  
	
	$(".filter_area .s_tag").html(ChkText);
	
	if(ChkText==""){
		$(".filter_area .tag_scroll").hide();		
	}else{
		$(".filter_area .tag_scroll").show();		
	}
	 
	 
	/* 
	if(onoff == "on"){ 
		idx = arrChk.length;
		arrChk[idx] = new Array();
	}

	if(id.indexOf("f_") > -1 || id.indexOf("f2_") > -1 ){
		if(onoff == "on"){
			arrChk[idx][0] = 'f';
			arrChk[idx][1] = id.replace("f_","").replace("f2_","");
			arrChk[idx][2] = '';
			arrFactoryChk.push(id.replace("f_","").replace("f2_","")); 
		}else if(onoff == "off"){
			$.each(arrChk, function(i,v){
				if(arrChk[i][1] == id.replace("f_","").replace("f2_","")){
					arrChk[i][0] = '';
					arrChk[i][1] = '';
					arrChk[i][2] = '';
				}
			});
			arrFactoryChk.splice($.inArray(id.replace("f_","").replace("f2_",""), arrFactoryChk),1);
		}
		if(arrFactoryChk.length > 0){
			$("#sch_factory span").html(arrFactoryChk.length);
			$("#filter_all h2 em").html(arrFactoryChk.length);
		}else{
			$("#sch_factory span").html("");
			$("#filter_all h2 em").html("");
		}
	}else if(id.indexOf("b_") > -1 || id.indexOf("b2_") > -1 ){
		if(onoff == "on"){
			arrChk[idx][0] = 'b';
			arrChk[idx][1] = id.replace("b_","").replace("b2_","");
			arrChk[idx][2] = '';
			arrBrandChk.push(id.replace("b_","").replace("b2_","")); 
		}else if(onoff == "off"){
			$.each(arrChk, function(i,v){
				if(arrChk[i][1] == id.replace("b_","").replace("b2_","")){
					arrChk[i][0] = '';
					arrChk[i][1] = '';
					arrChk[i][2] = '';
				}
			});
			arrBrandChk.splice($.inArray(id.replace("b_","").replace("b2_",""), arrBrandChk),1);
		}
		if(arrBrandChk.length > 0){
			$("#sch_brand span").html(arrBrandChk.length);
			$("#filter_all h2 em").html(arrBrandChk.length);
		}else{
			$("#sch_brand span").html("");	
			$("#filter_all h2 em").html("");
		}
	}else if(id.indexOf("s_") > -1){
		var tmpSpec = id.replace("s_","");
		tmpSpec = tmpSpec.substring(0, tmpSpec.indexOf("_"));
		var iSpec = 0;
		
		if(onoff == "on"){
			arrChk[idx][0] = 's';
			arrChk[idx][1] = $("#"+id).text();
			arrChk[idx][2] = id.replace("s_","");
			arrSpecChk.push(id.replace("s_","")); 
		}else if(onoff == "off"){
			$.each(arrChk, function(i,v){
				if(arrChk[i][2] == id.replace("s_","")){
					arrChk[i][0] = '';
					arrChk[i][1] = '';
					arrChk[i][2] = '';
				}
			});
			arrSpecChk.splice($.inArray(id.replace("s_",""), arrSpecChk),1);
		}
		
		$.each(arrSpecChk, function(i,v){
			if(arrSpecChk[i].substring(0, arrSpecChk[i].indexOf("_")) == tmpSpec){
				iSpec = iSpec + 1;
			}  
			$("#"+tmpSpec+" a span").html(iSpec);
		});
		
		if(iSpec == 0){
			$("#"+tmpSpec+" a span").html("");				
		}
	}
	
	var ChkText = "";
	 
	$.each(arrChk, function(i,v){
		if(arrChk[i][1]){
			ChkText = ChkText + "<li onclick=\"CmdFilterDel('1','"+arrChk[i][0]+"','"+arrChk[i][1]+"')\">"+arrChk[i][1]+"<em>삭제</em></li>";
		}
	}); 
	
	$(".filter_area .s_tag").html(ChkText);
	
	if(ChkText==""){
		$(".tag_scroll").hide();		
	}else{
		$(".tag_scroll").show();		
	}
	*/
} 

function CmdFilterChk3(param){ 
	$.each(arrChkReal, function(i,v){
		if(arrChkReal[i][0] == "f"){
			/*if($("#f_"+arrChkReal[i][1])){
				$("#f_"+arrChkReal[i][1]).addClass("chk");			
			}
			if($("#f2_"+arrChkReal[i][1])){
				$("#f2_"+arrChkReal[i][1]).addClass("chk");
			}*/
			$("#tab01 li[name='"+arrChkReal[i][1]+"']").addClass("on");			
			$("#sch_factory li[name='"+arrChkReal[i][1]+"']").addClass("chk");			
			$("#allview_search .factory li[name='"+arrChkReal[i][1]+"']").addClass("chk");
		}else if(arrChkReal[i][0] == "b"){
			/*if($("#b_"+arrChkReal[i][1])){
				$("#b_"+arrChkReal[i][1]).addClass("chk");			 
			}
			if($("#b2_"+arrChkReal[i][1])){
				$("#b2_"+arrChkReal[i][1]).addClass("chk");
			}	*/
			$("#tab02 li[name='"+arrChkReal[i][1]+"']").addClass("on");			
			$("#sch_brand li[name='"+arrChkReal[i][1]+"']").addClass("chk");			
			$("#allview_search .brand li[name='"+arrChkReal[i][1]+"']").addClass("chk");	
		}else if(arrChkReal[i][0] == "s"){
			if($("#s_"+arrChkReal[i][1])){
				$("#s_"+arrChkReal[i][1]).addClass("chk");			 
			}
			if($("#s2_"+arrChkReal[i][1])){
				$("#s2_"+arrChkReal[i][1]).addClass("chk");
			}	
		}
	});  
} 
function CmdFilterChk2(param){ 
	//$(".sub ul li").removeClass("chk");
	//$(".detail_sch ul li").removeClass("chk");
	
	//alert("필터링 전체보기 --> arrChkTmp : f2 , b2에 다시 체크해주기");

	$.each(arrChkTmp, function(i,v){
		if(arrChkTmp[i][0] == "f"){
			/*if($("#f_"+arrChkTmp[i][1])){
				$("#f_"+arrChkTmp[i][1]).addClass("chk");			
			}
			if($("#f2_"+arrChkTmp[i][1])){
				$("#f2_"+arrChkTmp[i][1]).addClass("chk");
			}*/
			$("#tab01 li[name='"+arrChkTmp[i][1]+"']").addClass("on");			
			$("#sch_factory li[name='"+arrChkTmp[i][1]+"']").addClass("chk");			
			$("#allview_search .factory li[name='"+arrChkTmp[i][1]+"']").addClass("chk");	
		}else if(arrChkTmp[i][0] == "b"){
			/*if($("#b_"+arrChkTmp[i][1])){
				$("#b_"+arrChkTmp[i][1]).addClass("chk");			 
			}
			if($("#b2_"+arrChkTmp[i][1])){
				$("#b2_"+arrChkTmp[i][1]).addClass("chk");
			}	*/
			$("#tab02 li[name='"+arrChkTmp[i][1]+"']").addClass("on");			
			$("#sch_brand li[name='"+arrChkTmp[i][1]+"']").addClass("chk");			
			$("#allview_search .brand li[name='"+arrChkTmp[i][1]+"']").addClass("chk");	

		}
	}); 

} 
//필터링 전체보기
function CmdFilterAll(param){
	var makeHtml = "";	
	var tmpFactory = "";
	var tmpBrand = "";
	var tmpCnt = 0;
	
	if(param == "f"){   
		$.each(arrFactory, function(i,v){
			if(arrFactory[0,i].indexOf("(") > -1){
				tmpFactory = arrFactory[0,i].substring(0,arrFactory[0,i].lastIndexOf("("));
			}else{
				tmpFactory = arrFactory[0,i];
			}
			makeHtml += "				<li id=\"f2_"+tmpFactory+"\" name=\""+tmpFactory+"\">"+arrFactory[0,i]+"</li>";
		});
		$("#allview_search ul").removeClass("brand");
		$("#allview_search ul").addClass("factory");
		$("#allview_search ul").html(makeHtml);
		$("#filter_all h2").html("제조사<em></em>");
		$(".allview_search").html("<input type=\"text\" placeholder=\"제조사명을 입력하세요.\" onkeyup=\"CmdFilterSch();\"/>");
	
		$.each(arrChkTmp, function(i,v){
			if(arrChkTmp[i][1] == ""){
			}else{
				if(arrChkTmp[i][0] == "f"){
					tmpCnt++; 
					$("#allview_search .factory li[name='"+arrChkTmp[i][1]+"']").addClass("chk");
				}
			}
		}); 
		CmdGa('', '', 'click_제조사 전체보기');
	}else if(param == "b"){
		$.each(arrBrand, function(i,v){
			if(arrBrand[0,i].indexOf("(") > -1){
				tmpBrand = arrBrand[0,i].substring(0,arrBrand[0,i].lastIndexOf("("));	
			}else{
				tmpBrand = arrBrand[0,i];					
			}
			makeHtml += "				<li id=\"b2_"+tmpBrand+"\" name=\""+tmpBrand+"\">"+arrBrand[0,i]+"</li>";
		});
		$("#allview_search ul").removeClass("factory");
		$("#allview_search ul").addClass("brand");
		$("#allview_search ul").html(makeHtml);
		$("#filter_all h2").html("브랜드<em></em>");
		$(".allview_search").html("<input type=\"text\" placeholder=\"브랜드명을 입력하세요.\" onkeyup=\"CmdFilterSch();\"/>");
		 
		$.each(arrChkTmp, function(i,v){
			if(arrChkTmp[i][1] == ""){
			}else{ 
				if(arrChkTmp[i][0] == "b"){
					tmpCnt++;
					$("#allview_search .brand li[name='"+arrChkTmp[i][1]+"']").addClass("chk");
				}
			}
		}); 
		CmdGa('', '', 'click_브랜드 전체보기');
	}
	
	if(tmpCnt > 0){
		$("#filter_all h2 em").text(tmpCnt);		
	}else{
		$("#filter_all h2 em").text("");
	}
	
	$("#allview_search ul li").unbind();
	$("#allview_search ul li").click(function(){
		if($(this).hasClass("chk")){
			$(this).removeClass("chk");				
			CmdFilterChk(this.id, 'off', $(this).attr("name"));
		}else{
			$(this).addClass("chk");
			CmdFilterChk(this.id, 'on', $(this).attr("name"));
		}  
	});
	CmdFilterChk2();
}
function CmdFilterDel(param, param2, param3){
	if(param == 1){
		//바닥에서 삭제 arrChkReal
		$.each(arrChkReal, function(i,v){
			if((arrChkReal[i][0] == param2 && arrChkReal[i][1] == param3) || (arrChkReal[i][0] =="p" && param2 == "p") ){
				//console.log(arrChkReal[i][1]  +"  ,  "+ param3)
				CmdFilterChk(arrChkReal[i][0]+"_"+arrChkReal[i][1], 'off', "");
				arrChkReal[i][0] = "";
				arrChkReal[i][1] = "";
				arrChkReal[i][2] = "";
			}
		}); 

		if(param2=="c"){
			$("#tab01 li").removeClass("on");
			$("#cate").val("");
		}
		//확인필요! 
			CmdCopyArr();
		$("#sch_go").click();
	}else if(param == 2){
		//레이어에서 삭제 arrChkTmp
		$.each(arrChkTmp, function(i,v){
			if(arrChkTmp[i][0] == param2 && arrChkTmp[i][1] == param3){
				CmdFilterChk(arrChkTmp[i][0]+"_"+arrChkTmp[i][1], 'off', "");
				
				arrChkTmp[i][0] = "";
				arrChkTmp[i][1] = "";
				arrChkTmp[i][2] = "";
			}
		});	  
	}
    if( document.URL.indexOf("/list.jsp") > -1){
    	ga('send', 'event', 'mf_lp', 'lp_common', 'click_선택한항목');
    }
	/* 
	$.each(arrChk, function(i,v){
		if(arrChk[i][0] == param && arrChk[i][1] == param2){
			arrChk[i][0] = "";
			arrChk[i][1] = "";
			arrChk[i][2] = "";
			if(param == "f"){
				arrFactoryChk.splice($.inArray(param2, arrFactoryChk),1);
			}
			if(param == "b"){
				arrBrandChk.splice($.inArray(param2, arrBrandChk),1);
			}
			if(param == "s"){
				arrSpecChk.splice($.inArray(param2, arrSpecChk),1);
			}
		}
	});	 
	
	$("#sch_go").click();
	*/
}

//필터링 검색
function CmdFilterSch(){
	var data = $(".allview_search input").val();

	if(data=="") {
		$("#allview_search ul li").show();
		return;
	}

	$("#allview_search ul li").filter(function (i, v) {
		var $t = $(this);
 
		if ($t.text().substring(0,data.length) == data) { 
			//console.log($t.text() +" ,  " +data)
			$(this).show();
			return true;
		}else{
			$(this).hide();
		}
		
		return false;

	}).show();

}
function cmdSearch(part, gubun, text){
	var idx = 0; 
	var gubuns = "";
	
	if(part == "c"){  
		$(".contarea li").removeClass("on");
		$(".contarea #sl_"+part+"_"+gubun).addClass("on");
		
		var idx = 0;
		arrChkReal = new Array();
		arrChkTmp = new Array();
		
		$("#start_price").val(""); 
		$("#end_price").val(""); 
		$("#inkeyword").val(""); 
		$("#spec").val(""); 
		$("#select_cate").val(gubun);
		$("#factory").val("");
		$("#brand").val("");
		$("#inkeyword").val("");
		$("#cate").val(gubun);
		
		if( document.URL.indexOf("/search.jsp") > -1){
			ga('send', 'event', 'mf_srp', 'srp_common', 'click_카테고리 상세항목');
		}
	}else if(part == "f"){
		//$.each(arrChkReal, function(i,v){
		//	if(arrChkReal[i][0] == "f"){
		//		arrChkReal[i][0] = "";
		//		arrChkReal[i][1] = "";
		//		arrChkReal[i][2] = "";
		//	}
		//}); 
		
		idx = arrChkReal.length;
		
		//$("#select_cate").val("");
		gubuns = $("#factory").val();
		if(gubuns == ""){
			gubuns = gubun;
		}else{
			gubuns = gubuns + ","+gubun;
		}
		$("#factory").val(gubuns);
		if( document.URL.indexOf("/search.jsp") > -1){
			ga('send', 'event', 'mf_srp', 'srp_common', 'click_제조사 상세항목');
		}
		//$("#brand").val("");
	}else if(part == "b"){
		//$.each(arrChkReal, function(i,v){
		//	if(arrChkReal[i][0] == "b"){
		//		arrChkReal[i][0] = "";
		//		arrChkReal[i][1] = "";
		//		arrChkReal[i][2] = "";
		//	}
		//});  
		
		idx = arrChkReal.length;
		
		//$("#select_cate").val("");
		//$("#factory").val("");
		gubuns = $("#brand").val();
		if(gubuns == ""){
			gubuns = gubun;
		}else{
			gubuns = gubuns + ","+gubun;
		}
		$("#brand").val(gubuns);
		if( document.URL.indexOf("/search.jsp") > -1){
			ga('send', 'event', 'mf_srp', 'srp_common', 'click_브랜드 상세항목');
		}
	}else if(part == "s"){
		idx = arrChkReal.length;
		
		gubuns = $("#sel_spec").val();
		if(gubuns == ""){
			gubuns = gubun;
		}else{
			gubuns = gubuns + ","+gubun;
		}
		$("#sel_spec").val(gubuns); 
	}
	 
	arrChkReal[idx] = new Array();
	arrChkReal[idx][0] = part;
	arrChkReal[idx][1] = gubun;
	arrChkReal[idx][2] = text;
	
	var ChkText2 = ""; 
	
	$.each(arrChkReal, function(i,v){
		if(arrChkReal[i][0] != ""){
			if(ChkText2.indexOf("CmdFilterDel('1','"+arrChkReal[i][0]+"','"+arrChkReal[i][1]+"'") > -1 ){
				arrChkReal[i][0] = "";
				arrChkReal[i][1] = "";
				arrChkReal[i][2] = "";
			}else{
				ChkText2 = ChkText2 +"<li onclick=\"CmdFilterDel('1','"+arrChkReal[i][0]+"','"+arrChkReal[i][1]+"')\"><span>"+arrChkReal[i][2]+"<em class=\"ico_m\">삭제</em></span></li>";
			}
		}
	}); 
	
	$("#relate_txt div ul").html(ChkText2);
	$("#relate_txt").show();
	
	idx = 0;
	arrChkTmp = new Array();
	 
	$.each(arrChkReal, function(i,v){
		arrChkTmp[idx] = new Array();
		arrChkTmp[idx][0] = arrChkReal[i][0];
		arrChkTmp[idx][1] = arrChkReal[i][1];
		arrChkTmp[idx][2] = arrChkReal[i][2];
		idx++; 
	}); 
	 
	cmdList();		
	
	if( document.URL.indexOf("/list.jsp") > -1){
		ga('send', 'event', 'mf_lp', 'lp_common', 'click_상세항목');
	}
}

function CmdCopyArr(){
	//arrChkReal -> arrChkTmp 로 복사
	//alert('2222  arrChkReal -> arrChkTmp 로 복사');
	var idx = 0;
	var arrCnt = 0;
	var ChkText = ""; 
	var FactoryCnt = 0;
	var BrandCnt = 0;
	
	arrChkTmp = new Array();
	
	$("#sch_factory .sub li").removeClass("chk");
	$("#sch_brand .sub li").removeClass("chk");
	$(".detail_sch ul li").removeClass("chk");
	$("#sch_spec li span").html("");
	$("#srhKeyword").val("");
	$("#srhPrice_s").val("");
	$("#srhPrice_e").val("");
	$("#srhPrice").val("");
	$("#srhPrice2").val("");
	
	$.each(arrChkReal, function(i,v){
		if(arrChkReal[i][1] == ""){
		}else{
			if(arrChkReal[i][1] != undefined){
				idx = arrCnt;
				arrChkTmp[idx] = new Array();
				arrChkTmp[idx][0] = arrChkReal[i][0];
				arrChkTmp[idx][1] = arrChkReal[i][1];
				arrChkTmp[idx][2] = arrChkReal[i][2];
				arrCnt++;
				
				ChkText = ChkText + "<li onclick=\"CmdFilterDel('2','"+arrChkTmp[idx][0]+"','"+arrChkTmp[idx][1]+"')\">"+arrChkTmp[idx][2]+"<em>삭제</em></li>";

				//카테고리
				if(arrChkReal[i][0] == "c"){
					$("#scate_"+arrChkReal[i][1]).addClass("chk");
					$("#sl_c_"+arrChkReal[i][1]).addClass("chk");
				}
				// 제조사  
				if(arrChkReal[i][0] == "f"){
					//$("#f_"+arrChkReal[i][1]).addClass("chk");
					//$("#f2_"+arrChkReal[i][1]).addClass("chk");
					$("#tab01 li[name='"+arrChkReal[i][1]+"']").addClass("on");			
					$("#sch_factory li[name='"+arrChkReal[i][1]+"']").addClass("chk");			
					if( $("#allview_search .factory").length ) {
						$("#allview_search .factory li[name='"+arrChkTmp[i][1]+"']").addClass("chk");	
						FactoryCnt++;
					}
				}
				// 브랜드
				if(arrChkReal[i][0] == "b"){
					//$("#b_"+arrChkReal[i][1]).addClass("chk");
					//$("#b2_"+arrChkReal[i][1]).addClass("chk");
					//$("li[name='"+arrChkReal[i][1]+"']").addClass("chk");
					$("#tab02 li[name='"+arrChkReal[i][1]+"']").addClass("on");			
					$("#sch_brand li[name='"+arrChkReal[i][1]+"']").addClass("chk");			
					if( $("#allview_search .brand").length ) {
						$("#allview_search .brand li[name='"+arrChkReal[i][1]+"']").addClass("chk");	
						BrandCnt++;
					}
				}    
				// 카테고리명 
				if(arrChkReal[i][0] == "s"){
					$("#s_"+arrChkReal[i][1]).addClass("chk");
					var vCnt = $("#s_"+arrChkReal[i][1]).parent().parent().parent().find("a > span").text();
					if(vCnt == "") vCnt = 0;
					var sCnt = parseInt(vCnt);
					sCnt++;  
					$("#s_"+arrChkReal[i][1]).parent().parent().parent().find("span").text(sCnt);
				} 
				//결과 내 검색 
				if(arrChkReal[i][0] == "k"){
					$("#srhKeyword").val(arrChkReal[i][1]);
				}
				//가격대 검색
				if(arrChkReal[i][0] == "p"){
					var start_p = arrChkReal[idx][1].substring(0, arrChkReal[i][1].indexOf("~"));
					var end_p = arrChkReal[idx][1].substring( arrChkReal[i][1].indexOf("~")+1, arrChkReal[i][1].length);
					
					$("#srhPrice_s").val(start_p);
					$("#srhPrice_e").val(end_p);
				}
			}
		}				
	});
	
	if(FactoryCnt > 0){ 
		$("#sch_factory span").html(FactoryCnt); 	
		$("#filter_all h2 em").html(FactoryCnt);
	}else{
		$("#sch_factory span").html(""); 
		$("#filter_all h2 em").html("");
	}
	if(BrandCnt > 0){
		$("#sch_brand span").html(BrandCnt); 
		$("#filter_all h2 em").html(BrandCnt);
	}else{
		$("#sch_brand span").html(""); 
		$("#filter_all h2 em").html("");
	}
	
	$(".filter_area .s_tag").html(ChkText);
	
	if(ChkText==""){
		$(".tag_scroll").hide();		
	}else{
		$(".tag_scroll").show();		
	}
	
	if(arrChkReal.length == 0){
		$(".sub li").removeClass("chk");
		//$(".lp_area .s_tag").html("");
		//$(".lp_area .tag_scroll").hide();
		$("#sch_factory span").html("");
		$("#sch_brand span").html("");
		
		$(".filter_area .s_tag").html("");
		//$(".tag_scroll").hide();	
	}
}
function CmdInSearch(){
	ga('send', 'event', 'mf_srp', 'srp_common', 'click_상세검색 결과내검색');
	
	if($("#srhRe").val() == ""){
		alert("검색어를 입력해주세요.");
		return false;
	}
	if($("#inkeyword").val() == $("#srhRe").val()){
		alert("입력된 검색어입니다.");
		return false;
	}else{
		$("#srhKeyword").val($("#srhRe").val());

		$("#sch_go").click();
	}
} 
function CmdPriceSearch(){
	ga('send', 'event', 'mf_srp', 'srp_common', 'click_상세검색 가격대검색');
	
	if($("#srhPrice").val() == "" || $("#srhPrice2").val() == ""){
		alert("가격대 입력해주세요.");
		return false;
	}
	if($("#srhPrice").val() == $("#start_price").val() && $("#srhPrice2").val() == $("#end_price").val() ){
		alert("입력된 검색어입니다.");
		return false;
	}else{
		$("#srhPrice_s").val($("#srhPrice").val());
		$("#srhPrice_e").val($("#srhPrice2").val());

		$("#sch_go").click();
	}
}
//리스트 이동
function CmdList(cate){
	//location.href = "/mobilefirst/list2.jsp?cate="+cate;
	location.href = "/mobilefirst/list.jsp?cate="+cate;
} 
//검색리스트 이동
 function CmdSList(kwd){
	 //location.href = "/mobilefirst/search2.jsp?keyword="+kwd;
	 ga('send', 'event', 'mf_srp', 'srp_common', 'click_연관키워드');
	 location.href = "/mobilefirst/search.jsp?keyword="+kwd;
 }
//콤마
function commaNum(amount) {
    var delimiter = ","; 
    var i = parseInt(amount);

    if(isNaN(i)) { return ''; }
    
    var minus = '';
    
    if (i < 0) { minus = '-'; }
    i = Math.abs(i);
    
    var n = new String(i);
    var a = [];

    while(n.length > 3)
    {
        var nn = n.substr(n.length-3);
        a.unshift(nn);
        n = n.substr(0,n.length-3);
    }

    if (n.length > 0) { a.unshift(n); }
    n = a.join(delimiter);
    amount = minus + (n+ "");
    return amount; 
}

function CmdVip(param, param2){
	//location.href = "/mobilefirst/detail.jsp?modelno=17447611&group=1&ep=1&ek=221102";	
	
	var thisInfoad = $("#p_"+param2).attr("infoad");
	//console.log(thisInfoad)
	var vInfoad = ""; 
	if(thisInfoad == "Y")	vInfoad = "&from=infoad";
	
	try{
		if(vFromPage == "Search"){
			iseObj = new Object();
			iseObj.procType = "2";
			iseObj.keyword = $("#all_keyword").val();
			iseObj.sr_type = "S";
			iseObj.view_type = "1";
			iseObj.modelno = param2;
			iseObj.pl_no = 0;
			insertSearchListLog(iseObj);
		}else{
			iseObj = new Object();
			iseObj.ca_code = szCategoryPower;	
			iseObj.lp_type = "C";
			iseObj.logType = "2";
			iseObj.view_type = "1";
			iseObj.modelno = param2;
			insSearchlog(iseObj);
		}
		
	}catch(e){
		console.log(e);
	}
	
	if(param == "mall"){
		location.href = "/mobilefirst/detail.jsp?modelno="+param2+"&group=1"+vInfoad;
		return false;
	}else if(param == "option"){
		location.href = "/mobilefirst/detail.jsp?modelno="+param2+"&group=1"+vInfoad;
		return false;
	}else if(param == "option2"){ 	//개별상품
		location.href = "/mobilefirst/detail.jsp?modelno="+param2;
		return false;
	}else if(param == "text"){
		location.href = "/mobilefirst/detail.jsp?modelno="+param2+"&group=2"+vInfoad;
		return false;
	}
	
}
function CmdErrImg(param, img){
	$("#img_"+param).error(function(){
		$(this).attr("src","http://img.enuri.info/images/m_home/noimg320.gif");
	}).attr("src", img);
} 
function CmdSpin(param){
	if(param=="on"){
		$("#loadingLayer").css("top",$(window).height()/2);
		$("#loadingLayer").css("left",$(window).width()/2);
		$("#loadingLayer").fadeIn("fast");
		$("#loadingLayer").spin();	 
	}else{
		$("#loadingLayer").hide();
	}
}
function CmdGa(ga1, ga2, ga3){
	if(ga3 == "click_상품"){
        if( document.URL.indexOf("/list.jsp") > -1){
        	ga1 = "mf_lp";
        	ga2 = "lp_common";
        }else if( document.URL.indexOf("/search.jsp") > -1){
        	ga1 = "mf_srp";
        	ga2 = "srp_common";
        }
	}else if(ga3 == "click_옵션선택" || ga3 == "click_옵션 전체보기" || ga3 == "click_쇼핑몰 전체보기"){
        if( document.URL.indexOf("/list.jsp") > -1){
        	ga1 = "mf_lp";
        	ga2 = "lp_detail";
        }else if( document.URL.indexOf("/search.jsp") > -1){
        	ga1 = "mf_srp";
        	ga2 = "srp_detail";
        }
	}else if(ga3 == "click_1page~ 5page"){
        if( document.URL.indexOf("/list.jsp") > -1){
        	ga1 = "mf_lp";
        	ga2 = "lp_paging";
        }else if( document.URL.indexOf("/search.jsp") > -1){
        	ga1 = "mf_srp";
        	ga2 = "srp_paging";
        }
	}else if(ga3 ==  "click_제조사 전체보기"){
        if( document.URL.indexOf("/list.jsp") > -1){
        	ga1 = "mf_lp";
        	ga2 = "lp_filter";
        }else if( document.URL.indexOf("/search.jsp") > -1){
        	ga1 = "mf_srp";
        	ga2 = "srp_filter";
        }
	}
	ga('send', 'event', ga1, ga2, ga3);
	
}

function goShop_ex(plno){
	
	iseObj = new Object();
	iseObj.ca_code = szCategoryPower;
	iseObj.lp_type = "C";
	iseObj.logType = "2";
	iseObj.view_type = "2";
	iseObj.pl_no = plno;
	insSearchlog(iseObj);
	
	var loadUrl = "/mobilefirst/ajax/resentZzim/getPlno_infos_ajax.jsp?plno="+plno;		
	
	tmp_url = "";
	tmp_shop_code = "";
	tmp_ca_code = "";
	 
	$.ajax({  
		url: loadUrl, 
		dataType:"JSON",
		async : false,
		success: function(json){ 
			tmp_url = json.url;
			tmp_shop_code = json.shop_code;
			tmp_ca_code = json.ca_code;
			addResentZzimItem(1, "P", plno); 
		}
	}); 
	//goShop('"+v.url+"', '"+v.shop_code+"', "+v.pl_no+", '', '', '"+v.ca_code+"', '', '', '', '0');

}

function CmdGaInfoad(param, param2){
	ga('send', 'event', 'mf_lp_Info_Ad_list', 'click_'+param, param2);
}

function CmdMobile(param){
	$(".g_tab li").removeClass("on");
	$("#mobile_tab_"+param).addClass("on");
	$(".mobile_type div").hide();
	$("#mobile_type_"+param).show();
}
function cmdSRP_Type(){
	var srp_keyword = vAllKeyword;
	var tmp_option1 = "";
	var tmp_option1_org = "";
	var tmp_option2_org = "";
	var mobile_top_html = "";
	var mobile_body_html = "";
	var classOn = "";
	var vDisplay = "";
	
	var loadUrl = "/mobilefirst/api/search_type.jsp?keyword="+srp_keyword;	

	$.ajax({  
		url: loadUrl, 
		dataType:"JSON",
		async : false,
		success: function(json){ 
			var tmp_type = json.type.type;
			
			if(tmp_type == "C"){
				var title_name = json.type.title_name;
				$(".mobilephone").find(".g_type").text(title_name);
				$.each(json.list , function(i,v){
					if(v.option_1 != tmp_option1_org){
						if(i > 1){
							mobile_body_html += "</li> "; 
							mobile_body_html += "</div> "; 			
						}
						if( i == 0){
							classOn = "class=\"on\" ";
						}else{
							classOn = " ";
							vDisplay = "style=\"display:none;\" ";
						}
						mobile_top_html += "<li id=\"mobile_tab_"+(i+1)+"\" "+classOn+" onclick=\"CmdMobile('"+(i+1)+"')\"><span>"+v.option_1+"</span></li> ";
						mobile_body_html += "<div id=\"mobile_type_"+(i+1)+"\" "+vDisplay+"> "; 
						mobile_body_html += "<li> "; 
					}
					if(v.option_2 != tmp_option2_org){
						if(i > 1){
							mobile_body_html += "</dl></li>"; 
						}
						mobile_body_html += "<li><span>"+v.option_2+"</span><dl>";
					}
					mobile_body_html += "<dt>"+v.option_3+"</dt> ";
					if(v.minprice3 == 0 && v.mallcnt3 == 0){
						mobile_body_html += "<dd><a href=\"#\">품절</a></dd>";
					}else{
						mobile_body_html += "<dd onclick=\"CmdVip('option2','"+v.modelno+"');\"><a href=\"#\"><em>최저가</em>";
						mobile_body_html += commaNum(v.minprice3);
						mobile_body_html += "원</a></dd>";
					}
					tmp_option1_org = v.option_1;
					tmp_option2_org = v.option_2; 
				});
				$(".mobilephone .g_tab").html(mobile_top_html);
				$(".mobilephone .mobile_type").html(mobile_body_html);
				$(".mobilephone").show();
			}else if(tmp_type == "D"){
				DtypeModel = json.srpModelList[0].intModelNo;
				//DtypeModel = "13385722";
				cmdList();		 
				/*DtypeJson = json.srpModelList;  
				// 상품리스트 
				//console.log(DtypeJson);
				$(".d_type").show();  

				$(".sort_list").hide();
				$(".sort_opt p").html("1개 상품");
				$(".power").hide();
				totalCnt = "1";
				cmdPaging(); 
				*/
			}
			if(tmp_type != "D"){
				// 상품리스트 
				$(".d_type").hide();
				cmdList();		
			}
		}
	}); 
}

function goSearchLog(plno){
	
	iseObj = new Object();
	iseObj.procType = "2";
	iseObj.keyword = $("#all_keyword").val();
	iseObj.sr_type = "S";
	iseObj.view_type = "2";
	iseObj.modelno = 0;
	iseObj.pl_no = plno;
	insertSearchListLog(iseObj);
	
}

//list
function insSearchlog(iseObj){
	var insSearhEffUrl = "/lsv2016/include/insertSearchEff.jsp";
	$.ajax({
        type: "GET",
        url: insSearhEffUrl,
        async: false,
        data:iseObj,
        dataType:"JSON",
        success: function(json){
        }
	});
}
//seach
function insertSearchListLog(iseObj){
	var insSearhEffUrl = "/lsv2016/ajax/insertSearchListLog_ajax.jsp";
	$.ajax({
        type: "GET",
        url: insSearhEffUrl,
        async: false,
        data:iseObj,
        dataType:"JSON",
        success: function(json){
        }
	});
}

function loadKeywordAd(){
	var keyword = $("#all_keyword").val();
	var html ="";
	var html2 = "";
	var param = {
			"keyword" : keyword,
			"channel" : "m"
	};
	$.ajax({
		type: "GET",
        url: "/lsv2016/ajax/getBrandTheme_ajax.jsp",
        data:param,
        dataType:"JSON",
        success : function(json){
        	var itemCnt = json["itemCnt"];
			var storageRoot = "http://storage.enuri.info";
			$(".brand_search").hide();
			if(itemCnt && itemCnt!="0") {
				var intDIdx = json["intDIdx"]; 
				var strMainType = json["strMainType"]; 
				var strMainImg = json["strMainImg"]; 
				var strMainImgUrl = json["strMainImgUrl"]; 
				var strMainTitleImg = json["strMainTitleImg"]; 
				var strMainTitleUrl = json["strMainTitleUrl"]; 
				var strMainTitleDesc = json["strMainTitleDesc"].replace(/\n|\r/g,""); 
				var strMoreText = json["strMoreText"]; 
				var strMoreUrl = json["strMoreUrl"]; 
				var strLogoImage = json["strLogoImage"]; 
				var strDescTitleNm = json["strDescTitleNm"]; 
				var strAdOwner = json["strAdOwner"]; 
				var detailModelListObj = json["detailModelList"];
				html +="<h3>";
				if(strAdOwner=="에누리") html += "트렌드 검색";
				else html +="<em>AD</em>브랜드검색";
				html +="</h3>";
				if(strLogoImage.length>0){
					html +="<div class=\"logo\"><img src=\""+strLogoImage+"\" alt=\"로고\"></div>";	
				}
				html +="<div class=\"swiper-container brandbox\">";
				html +="	<ul class=\"swiper-wrapper\">";
				html +="        <li class=\"swiper-slide\">";
				html +="        	<div class=\"thumb\">";
				html +="        		<a href=\""+strMainImgUrl+"\" target=\"_blank\"><img src=\""+strMainImg+"\" alt=\"브랜드검색상품\"></a>";
				html +="        	</div>";
				html +="        	<div class=\"thema_info\">";
				html +="        		<div class=\"thema_tit\">";
				html +="        			<a href=\""+strMainTitleUrl+"\" target=\"_blank\"><img src=\""+strMainTitleImg+"\" alt=\"테마상품소개\"></a>";
				html +="        		</div>";
				html +="        		<p>"+strMainTitleDesc+"</p>";
				html +="        	</div>";
				html +="        	<a href=\""+strMoreUrl+"\" class=\"btn_viewgo\" target=\"_blank\">"+strMoreText+"</a>";
				html +="        </li>";
				if(detailModelListObj){
					html +="    <li class=\"swiper-slide\">";
					html +="        <div class=\"thema_list\">";
					html +="        	<ul>";
					$.each(detailModelListObj, function(Index, listData) {
						var strModelImage = listData["strModelImage"];
						var goodsUrl = listData["goodsUrl"];
						var strModelDesc = listData["strModelDesc"];
						var strEnuriGoodsFlag = listData["strEnuriGoodsFlag"];
						var intModelNo = listData["intModelNo"];
						html +="        	<li>";
						if(strEnuriGoodsFlag=="Y")	html +=" <a href=\"javscript:void(0); onclick=\"CmdVip('option2','"+intModelNo+"'); \">";
						else 						html +=" <a href=\""+goodsUrl+"\" target=\"_blank\">";
						html +="        			<span class=\"thema_thumb\"><img src=\""+strModelImage+"\" alt=\"브랜드테마상품"+(Index+1)+"\" class=\"list_thumb\"></span>";
						html +="        			<strong>"+strModelDesc+"</strong>";
						html +="        		</a>";
						html +="        	</li>";
					});
				}
				html +="        		</ul>";
				html +="        	</div>";
				html +="        </li>";
				html +="    </ul>";
				html +="<div class=\"swiper-pagination\"></div>";
				html +="</div>";
				$(".brand_search .innerbox").html(html);
				$(".brand_search").show();
			}
		
		
			if(strAdOwner=="에누리") $(".brand_search .innerbox h3").css("padding-left","0px");
			 var swiper = new Swiper('.brandbox', {
					pagination: '.swiper-pagination',
					paginationClickable: true
			});
        }
	});
}

//이미지 위 태그 색상 노출 시작
function setListImageInIconSet() {

	if(vModelnos.length>0) {
		var param = {
			"procType" : "1",
			"modelnos" : vModelnos 
		};

		var ajaxObj = $.ajax({
			type : "get", 
			url : "/lsv2016/ajax/getGoods_List_Colors_ajax.jsp", 
			data : param, 
			dataType : "json", 
			success: function(json) {
				var goodsDisplayListObj = json["goodsDisplayList"];
				var goodsDisplayCnt = json["goodsDisplayCnt"];
				var goodsDisplayAttrListObj = json["goodsDisplayAttrList"];
				var goodsDisplayAttrCnt = json["goodsDisplayAttrCnt"];
				var goodsThumbTypeListObj = json["goodsThumbTypeList"];
				
				
				var gdAry = new Array();
				var gdcAry = new Array();
				var gdaAry = new Array();
				var gdtAray = new Array();
				
				if(goodsThumbTypeListObj && goodsThumbTypeListObj.length > 0){
					$.each(goodsThumbTypeListObj, function(index, listData){
						var category = listData["category"];
						gdtAray[category] = listData["type"];
					});
				}
				
				if(goodsDisplayListObj && goodsDisplayListObj.length>0) {
					$.each(goodsDisplayListObj, function(Index, listData) {
						var cate = listData["cate"];
						var modelno = listData["modelno"];
						var specnoList = listData["specnoList"];
						var titleList = listData["titleList"];
						var chtml = "";
						var html = "";
						var tagClass = "";
						if(specnoList.length>0) {
							var specnoListAry = specnoList.split(",");
							var titleListAry = titleList.split(",");
							var tmpTitle = "";
							if(titleListAry && titleListAry.length>0) {
								//for(var i=0; i<titleListAry.length; i++) {
									if(titleListAry[0].indexOf("등급") > -1) {
										tmpTitle = titleListAry[0].replace("등급","");
										chtml = "<span class=\"tag_energy grade"+tmpTitle+"\">"+titleListAry[0]+"</span>";
										gdcAry[modelno] = chtml;
									}else{
										html += "<span class=\"tag_sub\">"+titleListAry[0]+"</span>";
									}
								//}
							}
						}
						if(html.length>0) gdAry[modelno] = html;
					});
				}
			
				if(goodsDisplayAttrListObj && goodsDisplayAttrListObj.length>0) {
				
					$.each(goodsDisplayAttrListObj, function(Index, listData) {
						var category = listData["category"];
						var modelno = listData["modelno"];
						var orderno = listData["orderno"];
						var attribute_idList = listData["attribute_idList"];
						var attribute_element_idList = listData["attribute_element_idList"];
						var attribute_elementList = listData["attribute_elementList"];
						//consoleLog("attribute_elementList="+attribute_elementList);
						var html = "";
						
						if(attribute_idList.length>0) {
							var aiListAry = attribute_idList.split(",");
							var aeiListAry = attribute_element_idList.split(",");
							var aeListAry = attribute_elementList.split(",");

							if(aeListAry && aeListAry.length>0) {
								for(var i=0; i<aeListAry.length; i++) {
									html += "<span class=\"tag_spec\" >"+aeListAry[i]+"</span>";
								}
							}
						}
						if(html.length>0){
							// B,C,D 타입
							if(gdtAray[category]) {
								// "0502" 타입만 두개가 노출된다.
								if(!gdaAry[modelno]){
									gdaAry[modelno] = html;
								} else if(category == "0502") {
									if(orderno == 1){
										gdaAry[modelno] = html+gdaAry[modelno];
									} else if(orderno == 2){
										gdaAry[modelno] = gdaAry[modelno]+html;
									}	
								}
							}
						}
					});
					
				}
				
				var listListAry = $(".lp_list .prodList .listarea");
				for(var i=0; i<listListAry.length; i++) {
					var listObj = $(listListAry[i]);
					var listModelno = listObj.attr("modelno");
					var listCate = listObj.attr("catecode");
					var listAdType = listObj.find(".pluslink");
					var listCate4 = "";
					var html ="";
					
					if( (typeof(listModelno) =="undefined" || typeof(listCate) =="undefined") || listAdType.length > 0) continue;
					
					
					if(listCate.length > 4){
						listCate4 = listCate.substring(0,4);
						if( typeof(gdtAray[listCate4]) =="undefined" ) continue;
						else{
							tagClass = "tag_type_"+ gdtAray[listCate4].toLowerCase();
							
							html +="<span class=\"img_tag_v2\">";
							html +="	<span class=\"tag_group " +tagClass+ "\">";
							if(gdAry.length > 0 && typeof(gdAry[listModelno]) != "undefined")  html +=gdAry[listModelno];
							if(gdaAry.length > 0 && typeof(gdaAry[listModelno]) != "undefined") html +=gdaAry[listModelno];
							html +="	</span>";
							if(gdcAry.length > 0 && typeof(gdcAry[listModelno]) != "undefined") html += gdcAry[listModelno];
							html +="</span>";
							listObj.find(".thum").prepend(html);	
						}
					}
				}
			},
			error: function (xhr, ajaxOptions, thrownError) {
				//alert(xhr.status);
				//alert(thrownError);
			}
		});
	}
}
//로그 넣기
function insertLogLSV(logNum, logCate, modelno) {
	var url = "/view/Loginsert_2010.jsp"
	var param = "kind="+logNum;
	if(logCate && logCate.length>0) param += "&cate="+logCate;
	if(modelno && modelno.length>0) {
		param += "&modelno="+modelno;
	} else {
		param = "kind="+logNum+"&cate="+cate;
	}

	$.ajax({
		type: "GET",
		url: url,
		data: param
	});

	//showLogView(logNum);
}

function turnOff(id) {
	$('#' + id).closest('.dim').hide();
	fnEverSetCookie("showAdultAuth", "false");
}

function fnEverSetCookie(name, value) {
    document.cookie = name + "=" + escape(value) + "; path=/;";    
}

function getCookie(c_name) {
    var i,x,y,ARRcookies=document.cookie.split(";");
    for(i=0;i<ARRcookies.length;i++) {
        x = ARRcookies[i].substr(0,ARRcookies[i].indexOf("="));
        y = ARRcookies[i].substr(ARRcookies[i].indexOf("=")+1);
        x = x.replace(/^\s+|\s+$/g,"");
        if(x==c_name) {
            return unescape(y);
        }
    }
}

//숫자에서 콤마찍기
Number.prototype.format = function() {
	if(this==0) return 0;

	var r = /(^[+-]?\d+)(\d{3})/;
	var n = (this + '');

	while (r.test(n)) n = n.replace(r, '$1' + ',' + '$2');

	return n;
};