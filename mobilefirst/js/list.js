
var IMG_ENURI_COM = "http://img.enuri.gscdn.com";
var cate = '0502';
var param = "";
var varPage = "";
var varPage2 = "";
var allcnt = 0;
var categoryHtmlOrg_prevTitle = "";
var categoryHtmlOrg_prevTitle_Sub = "";
var searchCategoryTitle = "";
var tmpKeyword = "";
var tmpSpec = "";
var searchFlag = false;
var searchFlagTitle = "";
var factory_sort = "G";
var brand_sort = "G";
var vPrice_start = "";
var vPrice_end = "";
var vFirst = "";
var vGrid_org = "";
var vGrid_org2 = "";
var bOxy = false;

function CmdErrImg(param, img){
	$("#img_"+param).error(function(){
		$(this).attr("src","http://photo3.enuri.com/data/working.gif");
	}).attr("src", img);
} 
function CmdBtnChu(){
	if($("#chkCategory").is(":visible")){
		$("#chuText").hide();
		$(".pagingview2").hide();
	}else{
		$("#chuText").show();
		if($("#cateSort2").hasClass('on')){
			$(".pagingview2").show();
			if($(".mCate").is(":visible")){
				$(".pagination02").show(); 
			}else if($(".sCate").is(":visible")){
				$(".pagination03").show();
			}
		}else{
			$(".pagination02").hide();
			$(".pagination03").hide();
		}
	}
	$(".sortSelect .cateSort > li > button").css("color","");
}	

$(function() {
	$("#list_banner").click(function(){
		if(document.URL.indexOf("list.jsp") >= 0){
			ga('send', 'event', 'mf_lp', 'lp', 'lp_list banner');
		}
	});
	$(".btn_result").click(function(){		
		if(document.URL.indexOf("list.jsp") >= 0){
			ga('send', 'event', 'mf_lp', 'lp', 'lp_go SRP');
		}
	}); 
	$(".btn_category").click(function(){	
		ga('send', 'event', 'mf_srp', 'srp_common', 'srp_go LP');
	}); 
	$("#srhRe").bind({  
		keydown:function(event){ 
			var kEvt = window.event;
			if (kEvt.keyCode == 13){ 
				$(".sortBtn .btnType4").click();
			}else{
			}
		}
	});
	// 정렬 
	$(".prodSortOpt select").click(function() {
		if($("#applist").val() == "" && navigator.userAgent.indexOf("Android") > 0 ){
			var vSortScroll = $(".powerLink").offset().top;

			setTimeout(function(){ 
				if(vSortScroll < jQuery(window).scrollTop() ){
					scrollTo(0, $(".prodSortOpt").offset().top-30);
				} 
			}, 500);	
		} 
	});
	$(".prodSortOpt select").change(function() { 
		CmdSpinLoading();
		var varSelect = $(this).val();
		if(document.URL.indexOf("list.jsp") >= 0){
			//var varTitle = $("select > option[value="+varSelect+"]").text();
			var varTitle = $('.sortopt option:selected').text();
			ga('send', 'event', 'mf_lp', 'lp_sort', 'sort_'+varTitle);
		}  
		
		$("#key").val(varSelect); 
		$("#page").val('1');
		//location.href = varPage2+"?"+getParam();
		getList('re');
		scrollTo(0,0);
	});
	$(".sortBtn .btnreset").click(function() {  //초기화
		CmdSpinLoading();
		var id = this.parentNode.id; 

		if(id == "detail_b"){
			var tmpMin = $("#org_start_price").val();
			var tmpMax = $("#org_end_price").val();
			$("#srhPrice").val(tmpMin);
			$("#srhPrice2").val(tmpMax); 
			$("#start_price").val("");
			$("#end_price").val(""); 
			
			var tmpInkeyword = $("#inkeyword").val(); 

			//$("#srhRe").val(tmpInkeyword);
			$("#srhRe").val('');
			$("#inkeyword").val('');
			$(".brandSort div").html("");
			$(".brandSort2 div").html("");
			tmpSpon = "Y";
			getList('re');
		}else if(id == "brand_b"){
			$('input:checkbox[name="f_chk"]').each(function(){
				if(this.checked){
					this.checked = false;
				} 
			});
			$("#factory").val("");
			$(".brandSort2 div").html("");
			$("#shop_code").val("");
			tmpSpon = "";
			getList('a');
		}else if(id == "brand2_b"){
			$('input:checkbox[name="b_chk"]').each(function(){
				if(this.checked){
					this.checked = false;
				}
			}); 
			$("#brand").val("");
			$(".brandSort div").html("");
			tmpSpon = "";
			getList('a');
		}else if(id == "spec_b"){
			$("#sel_spec").val("");
			$(".ms-choice span").text("속성선택");
			$(".spec_chk").attr("checked", false);
			getList('re');
			getSpec('re');
		}else if(id == "category_b"){
			$("#cate").val("");
			$("#chuText").text("");
			$(".searchCates").css("color","#4c5363");
			$(".searchCates2").css("color","#4c5363");
			tmpSpon = "";
			getList('a');
		}
	});
	$(".sortBtn .btnclose").click(function() {  //완료
		var _this = $(this);
		var id = this.parentNode.id; 

		if( id == "brand_b" ){
			if (_this.parent().parent().parent().parent().hasClass('on')) {
				_this.parent().parent().parent().parent().parent().find(' > li').removeClass('on');
			} else {
				_this.parent().parent().parent().parent().find(' > li').removeClass('on');
				_this.parent().parent().parent().addClass('on');
			}	
		}else if ( id == "category_b"){
			if (_this.parent().parent().parent().parent().hasClass('on')) {
				_this.parent().parent().parent().parent().parent().find(' > li').removeClass('on');
			} else {
				_this.parent().parent().parent().parent().find(' > li').removeClass('on');
				_this.parent().parent().parent().addClass('on');
			}	
		}else{
			if (_this.parent().parent().parent().hasClass('on')) {
				_this.parent().parent().parent().parent().find(' > li').removeClass('on');
			} else {
				_this.parent().parent().parent().find(' > li').removeClass('on');
				_this.parent().parent().addClass('on');
			}		
		}

	});

	
	$("#inkeywordSearch").click(function() {	//결과내 검색 조회
		
		CmdSpinLoading();
		if(document.URL.indexOf("list.jsp") >= 0){
			ga('send', 'event', 'mf_lp', 'lp_상세검색', 'lp_결과내검색');
		}	
		if(document.URL.indexOf("search.jsp") >= 0){
			ga('send', 'event', 'mf_srp', 'srp_detail search', 'srp_결과내검색');
		}	
		
		if($("#srhRe").val().trim().length > 0  ){
		}else{
			alert("검색 정보를 확인해주세요.");
			$("#cm_loading").hide();
			return false;			
		}		 

		$("#inkeyword").val(tmpKeyword);	
		$(".brandSort div").html("");
		$(".brandSort2 div").html("");
		
		
		if(document.URL.indexOf("search.jsp") >= 0 ){
			getCount();
		}else{
			getInCount();	  
		}
	});  
	$("#priceSearch").click(function() {	//가격대검색 조회
		if(document.URL.indexOf("list.jsp") >= 0){
			ga('send', 'event', 'mf_lp', 'lp_상세검색', 'lp_가격대검색');
		}	
		if(document.URL.indexOf("search.jsp") >= 0){
			ga('send', 'event', 'mf_srp', 'srp_detail search', 'srp_가격대검색');
		}	
		
		if( $("#srhPrice").val() == "" ||  $("#srhPrice2").val() == "" ){
			alert("검색 정보를 확인해주세요.");
			$("#cm_loading").hide();
			return false;	
		}
		if($("#srhPrice").val().length > 0 && $("#srhPrice2").val().length > 0 ){
			if( eval($("#srhPrice").val().replace(/,/gi,"")) > eval($("#srhPrice2").val().replace(/,/gi,""))  ){
				alert("검색 정보를 확인해주세요.");
				$("#cm_loading").hide();
				return false;	
			}
		}	 
	
		var tmpMin = $("#srhPrice").val().replace(/,/gi,"");
		var tmpMax = $("#srhPrice2").val().replace(/,/gi,"");
		
		vPrice_start = $("#start_price").val();
	    vPrice_end = $("#end_price").val();	
	
		$("#start_price").val(tmpMin);
		$("#end_price").val(tmpMax);	
				
		CmdSpinLoading();
				
		if(document.URL.indexOf("search.jsp") >= 0 ){
			getCount();
		}else{
			getInCount();	  
		}
	});  
	$(".sortBtn .btnType4").click(function() {  //완료 
		CmdSpinLoading();
		var id = this.parentNode.id;
		
		if(id == "detail_b"){
		
			if($("#srhPrice").val().length > 0 && $("#srhPrice2").val().length > 0 && $("#srhRe").val().length > 0 ){
				if( eval($("#srhPrice").val().replace(/,/gi,"")) > eval($("#srhPrice2").val().replace(/,/gi,""))  ){
					alert("검색 정보를 확인해주세요.");
					$("#cm_loading").hide();
					return false;	
				}
			}else if( $("#srhPrice").val().replace(/,/gi,"").length > 0 && $("#srhPrice2").val().replace(/,/gi,"").length > 0 && $("#srhRe").val().length == 0 ){
				var tmpInkeyword = $("#inkeyword").val(); 
				
				if( ( $("#srhPrice").val().replace(/,/gi,"") == $("#start_price").val().replace(/,/gi,"") && $("#srhPrice2").val().replace(/,/gi,"") == $("#end_price").val().replace(/,/gi,"") ) ||  eval($("#srhPrice").val().replace(/,/gi,""))  > eval($("#srhPrice2").val().replace(/,/gi,"")) ){
					if(tmpKeyword == $("#srhRe").val()){
						alert("검색 정보를 확인해주세요.");
						$("#cm_loading").hide();
						return false;		
					}
				}
			}else if($("#srhPrice").val().replace(/,/gi,"").length == 0 && $("#srhPrice2").val().replace(/,/gi,"").length == 0 && $("#srhRe").val().length > 0 ){
			}else{
				alert("검색 정보를 확인해주세요.");
				$("#cm_loading").hide();
				return false;
			}
			var tmpMin = $("#srhPrice").val().replace(/,/gi,"");
			var tmpMax = $("#srhPrice2").val().replace(/,/gi,"");
			tmpKeyword = $("#srhRe").val();

			$("#start_price").val(tmpMin);
			$("#end_price").val(tmpMax);	
			$("#inkeyword").val(tmpKeyword);	
				
		}else if(id == "brand_b"){
			$("#factory").val(tmpFactory);
		}else if(id == "brand2_b"){
			$("#brand").val(tmpBrand);
		}else if(id == "spec_b"){
		}
		if(document.URL.indexOf("search.jsp") >= 0 ){
			getCount();
		}else{
			getInCount(id);	  
		}
	});
 
	$(".inSearch .del").click(function() { 
		$("#srhRe").val("");
		$("#srhRe").focus();
		CmdBottomMenu('1');
	});
	
	//바둑판 --> 리스트 전환
	$(".btnList").click(function() { 
		$("#grid").val('');
		$("#allopen").val('');
		if(document.URL.indexOf("list.jsp") >= 0 && vFirst != "" && vGrid_org == "y"){
			ga('send', 'event', 'mf_lp', 'lp_view', 'lp_list view');
		}    
		vGrid_org = "";  
		vGrid_org2 = "y";
		vFirst = "N";  
	});      
	//리스트  --> 바둑판 전환 
	$(".btnGrid").click(function() {  
		$("#grid").val('y'); 
		$("#allopen").val('');
		if(document.URL.indexOf("list.jsp") >= 0 && vFirst != "" && vGrid_org2 == "y"){
			ga('send', 'event', 'mf_lp', 'lp_view', 'lp_grid view');
		}
		vGrid_org = "y";
		vGrid_org2 = "";
		vFirst = "N"; 
	}); 
	//이전페이지
	$(".pagingPrev").click(function() { 
		var page = $("#page").val();
		
		if(page == 1){
			//alert('end page');
		}else{
			$("#page").val(eval(page)-1);
			getList('re');
			scrollTo(0,0);
			//location.href = varPage2+"?"+getParam();
		}
	}); 
	//다음페이지
	$("#pagingNextList").click(function() { 
		$(".loading").show();	
		var page = $("#page").val();
		
		if(eval(page) * 20 > eval(allcnt.replace(',','')) ){
			//alert('end page');
		}else{
			$("#page").val(eval(page)+1);
			getList('re');
			if(document.URL.indexOf("list.jsp") >= 0){
				ga('send', 'event', 'mf_lp', 'lp', 'lp_list more');
			}
		}  
	});
	
	$("#CategoryTab").click(function() { 
		if($(".cateSort").is(":visible")){
			$("#category_nav").hide();
		}else{ 
			searchCategoryTitle = "";
			
			var varChu = $("#chuText").html();
			var varAll = $("#categoryAll").html();
			
			if(varChu.length > 0 ){
				searchCategoryTitle = "<b>추천 카테고리</b> > <span style=\"color:#0081e5;\">"+varChu+"</span>";
			}else if(varAll.length > 35){
				if(categoryHtmlOrg_prevTitle_Sub.length > 0 ){
					//searchCategoryTitle = varAll.replace("전체","<b>전체</b> > ") + " > <span style='color:#0081e5;'>"+categoryHtmlOrg_prevTitle_Sub+"</span>";
					searchCategoryTitle = varAll.replace("전체","<b>전체</b> > ") ;
					searchCategoryTitle = searchCategoryTitle.replace("<span>","<span style='display:none;'>");
					searchCategoryTitle = searchCategoryTitle.replace("<em","<span").replace("</em>","</span>");
				}
			}
			if(searchCategoryTitle.length > 0){
				$("#category_nav").html(searchCategoryTitle);
				$("#category_nav").show();
			}	
		}
	});
	$(".searh_align li div").click(function() { 

		if(this.id.indexOf("f_") > -1){
			$("#tab1 .searh_align li div").removeClass("on");
			$("#"+this.id).addClass("on");
			
			factory_sort = this.id.replace("f_","");
			
			if(document.URL.indexOf("list.jsp") >= 0){
				if( factory_sort == "G"){
					ga('send', 'event', 'mf_lp', 'lp_제조사', 'lp_가나다 순');
				}else if( factory_sort == "C"){
					ga('send', 'event', 'mf_lp', 'lp_제조사', 'lp_상품수 순');
				}else if( factory_sort == "P"){
					ga('send', 'event', 'mf_lp', 'lp_제조사', 'lp_인기도 순');
				}
			}
			CmdTab('re');
		}else if(this.id.indexOf("b_") > -1){
			$("#tab4 .searh_align li div").removeClass("on");
			$("#"+this.id).addClass("on");
			
			brand_sort = this.id.replace("b_","");
			CmdTab2('re');
		}
	}); 
	//브랜드탭 클릭  
	$("#Brand2Tab").click(function() { 
		CmdTab2(''); 
		if(document.URL.indexOf("list.jsp") >= 0 ){
			if($("#tab4").is(":visible")){
			}else{
			//	ga('send', 'event', 'mf_lp', 'lp_제조사', 'lp_제조사탭');
			}
		}  
		if(document.URL.indexOf("search.jsp") >= 0 ){
			if($("#tab4").is(":visible")){
			}else{
			//	ga('send', 'event', 'mf_srp', 'srp_shop', 'srp_shop tab');
			}
		}  	
	});
	//제조사탭 클릭  
	$("#BrandTab").click(function() { 
		CmdTab('');
		if(document.URL.indexOf("list.jsp") >= 0 ){
			if($("#tab1").is(":visible")){
			}else{
				ga('send', 'event', 'mf_lp', 'lp_제조사', 'lp_제조사탭');
			}
		}   
		if(document.URL.indexOf("search.jsp") >= 0 ){
			if($("#tab1").is(":visible")){
			}else{
				ga('send', 'event', 'mf_srp', 'srp_shop', 'srp_shop tab');
			}
		}  	
	});
	//가격대탭 클릭 
	$("#PriceTab").click(function() { 
		if(document.URL.indexOf("list.jsp") >= 0 ){
			if($("#tab2").is(":visible")){
			}else{
				ga('send', 'event', 'mf_lp', 'lp_상세검색', 'lp_상세검색탭');
			}
		}  
		if(document.URL.indexOf("search.jsp") >= 0 ){
			if($("#tab2").is(":visible")){
			}else{ 
				ga('send', 'event', 'mf_srp', 'srp_detail search', 'srp_detail search tab');
			}
		}  		
		//if ($(".inForm").html().trim().length == 0 ){	
		if($(".inForm").is(":visible") && document.URL.indexOf("list.jsp") >= 0){
			insertLog('11021');
		}
		$("#category_nav").hide();
		if($("#srhPrice").val() == "" && $("#srhPrice2").val() == "" ){
			
			CmdSpinLoading();
 			
 			var vParam = getParam();
 			
			$.ajax({
				type: "GET",
				url: "/search/getTabLayer.jsp",
				async: true,
				//data: "cate="+cate+"&key=popular+DESC&mobile2=first&tTy=price",
				data: vParam + "&mobile2=first&tTy=price",
				dataType:"JSON", 
				success: function(result){ 
					$(".inForm").html(null); 
					var template = "";
					template += "{{#priceList}}<span><input type=\"tel\" id=\"srhPrice\" value=\"{{minPirce}}\" onkeyup=\"inputPriceCheck(this);\" onclick=\"CmdBottomMenu('1');\" onfocusout=\"CmdBottomMenu('2');checkNumberFormat(this);\"/><button type=\"button\" class=\"del\" id=\"p_del1\">검색어 삭제</button></span><span style=\"width:20px;\"> ~</span><span><input type=\"tel\" id=\"srhPrice2\" value=\"{{maxPirce}}\" onkeyup=\"inputPriceCheck(this);\" onclick=\"CmdBottomMenu('1');\" onfocusout=\"CmdBottomMenu('2');checkNumberFormat(this);\" / ><button type=\"button\" class=\"del\" id=\"p_del2\">검색어 삭제</button></span>{{/priceList}}";
					var html = Mustache.to_html(template, result);			
					$(".inForm").html(html);	
					var tmpMin = $("#srhPrice").val();
					var tmpMax = $("#srhPrice2").val();
					$("#start_price").val(tmpMin); 
					$("#end_price").val(tmpMax);
					$("#org_start_price").val(tmpMin);
					$("#org_end_price").val(tmpMax);
				},
				complete: function(){ 
					$("#cm_loading").hide();	
					$("#p_del1").click(function() { 
						$("#srhPrice").val(""); 
						$("#srhPrice").focus();
						CmdBottomMenu('1');
					});
					$("#p_del2").click(function() { 
						$("#srhPrice2").val("");
						$("#srhPrice2").focus();
						CmdBottomMenu('1');
					}); 
	
				}
			}); 
		}			
	});
	//스펙탭 클립
	$("#SpecTab").click(function() { 
		if($(".spec").is(":visible") && document.URL.indexOf("list.jsp") >= 0){
			insertLog('11022');
		}
		if(document.URL.indexOf("list.jsp") >= 0){
			getSpec();
			if($("#tab3").is(":visible")){
			}else{
				ga('send', 'event', 'mf_lp', 'lp_사양선택', 'lp_사양선택탭');
			}
		}else if(document.URL.indexOf("search.jsp") >= 0){
			if($("#tab3").is(":visible")){
			}else{
				ga('send', 'event', 'mf_srp', 'srp_cate', 'srp_category tab');
			}
		}
		var cateWidth  = $(window).width(),
		listLength = $('.allCateLIst .mCate > ul').length,
		listWidth = $('.cateSortList .mCate > ul').width(cateWidth); 
		$('.cateSortList .mCate').width((cateWidth * listLength));
		
	});	 
	$(".btnAllOpen").click(function() { 
		if($(".btnAllOpen").hasClass("on") && document.URL.indexOf("list.jsp") >= 0){
			insertLog('11023');
		}
		$("#grid").val(''); 
		if($(".btnAllOpen").hasClass("on")){ 
			$("#allopen").val('y');
			if(document.URL.indexOf("list.jsp") >= 0){
				ga('send', 'event', 'mf_lp', 'lp_view', 'lp_open view');
			}
		}else{
			$("#allopen").val('');
		}
	});	 

	function layerPop(_this){
		//_this.next('.layerPop').show();
		//var layerPopHeight = _this.next('.layerPop').find('.layerPopInner').height();
		//_this.next('.layerPop').find('.layerPopInner').css('margin-top','-'+ layerPopHeight / 2 + 'px' )
		//$('#wrap').append('<div class="dimmed"></div>');
		//$('html, body').addClass('dimdOn');
	}

	
	getList('a');
	 
	//안드로이드 상품창 이동후 리스트로 back 했을때  
	var vParamAnd = "";

	function getList(type){	//리스트 불러오기
		//if(type == 'a' && $("#page").val() > 1){ 
		//	vParamAnd = "andEx=Y&"+getParam();
		//}else{
			vParamAnd = getParam(); 
		//}   
		//alert(vParamAnd);
		if(document.URL.indexOf("list.jsp") >= 0){
			if(document.URL.indexOf("cate=1471") >= 0 || document.URL.indexOf("cate=1472") >= 0 || document.URL.indexOf("cate=1473") >= 0 ){
				varPage = "/mobilefirst/ajax/listAjax/getList2_ajax.jsp";
			}else if(document.URL.indexOf("cate=1482") >= 0 || document.URL.indexOf("cate=1483") >= 0 || document.URL.indexOf("cate=1484") >= 0 || document.URL.indexOf("cate=1485") >= 0){
				varPage = "/mobilefirst/ajax/listAjax/getList3_ajax.jsp";
			}else{  
				varPage = "/mobilefirst/ajax/listAjax/getList_ajax.jsp";
			}
			if($("#key").val() ==  "new"){
				varPage = "/mobilefirst/ajax/listAjax/getListNew_ajax.jsp";
			} 
			varPage2 = "/mobilefirst/list.jsp";
		}else if(document.URL.indexOf("search.jsp") >= 0){
			varPage = "/mobilefirst/ajax/listAjax/getSearch_ajax.jsp";
			varPage2 = "/mobilefirst/search.jsp";
		}

		if($("#applist").val() == "Y"){
			if(navigator.userAgent.indexOf("Android") > 0 ){
			}else{
				$("#cm_loading").hide();	 
				$(".loading").hide();	
			}
		} 
		
		//if($("#page").val() > 1 ){
			//scrollTo(0, $(".prodSortOpt").offset().top);
			//scrollTo(0, 0);
		//}
		
		var varInKeywordOxy = $("#srhRe").val().trim().toUpperCase();
		//검색 금지어 전체 삭제
		/*
		#33351 검색 금지어 전체 삭제 2019.04.08, 최서진 선임 
		#35507 "수퍼굽 스킨 수딩 미네랄 선스크린" 외 15건 결과없음 처리 2019.08.19, jinwook 
		#35971 조개젓 관련 키워드 결과 없음 처리 2019.09.18. shwoo
		#36492 삼성 셀리턴 외 2019.10.23 jinwook
		*/
	
		//단어 일치 할 경우 
		var strNoUseKwd = ["SKINSOOTHINGMINERALSUNSCREENSPF40","SOOTHINGMINERALSUNSCREENSPF40","수퍼굽스킨수딩미네랄선스크린SPF40"
		                   ,"수퍼굽스킨수딩미네랄선스크린","수퍼굽스킨수딩미네랄","수퍼굽스킨수딩","수퍼굽스킨","수퍼굽수딩","수퍼굽선스크린"
		                   ,"수퍼굽미네랄선스크린","수퍼굽수딩미네랄선스크린","AUSTRALIANGOLDLOTIONSUNSCREENSPF15"
		                   ,"오스트레일리안골드로션선스크린SPF15","오스트레일리안골드선스크린SPF15","CERAVESUNSCREENBODYLOTIONSPF30","세라베선스크린바디로션SPF30"
		                   ,"조개젓", "조개젓갈", "whrowjt","삼성셀리턴","삼성전자셀리턴","삼성LED마스크","삼성전자LED마스크"];

		//단어가 포함될 경우 
		var strNoUseContainKwd = ["조개젓", "조개젓갈", "whrowjt","삼성셀리턴","삼성전자셀리턴","삼성LED마스크","삼성전자LED마스크"];
		
		  for(var i = 0; i < strNoUseKwd.length; i++){
	            if (strNoUseKwd[i] == varInKeywordOxy){
	            	bOxy = true;
	                break;
	            }
	        }
		  
		  if (!bReturn) {
			  for(var i = 0; i < strNoUseContainKwd.length; i++){
		            if (varInKeywordOxy.indexOf(strNoUseContainKwd[i]) > -1){
		            	bOxy = true;
		                break;
		            }
		        }
		  }
		
		if(bOxy){
			alert("상품이 없습니다.");
			$("#cm_loading").hide();
			return false;
		}
		
		$.ajax({   
			type: "GET",
			url: varPage,
			async: true, 
			data: vParamAnd,   
			dataType:"JSON", 
			success: function(result){
				if(document.URL.indexOf("search.jsp") >= 0 ){
					//alert(result.rekeyword.length)
					//if(result.rekeyword.length > 0){
						$("#rekeyword").val(result.rekeyword);
					//}  
				}

				$(".lp_tab").show();
				$(".prodSortOpt").show();
				$(".panel").show();
				$(".searchNone").hide(); 
				$(".prodList").show();
				$(".prodSortOpt").show(); 
				$("#paging").hide();
				if($("#cate").val().length >= 4 ){
					/*if( type == 'a' && ( $("#cate").val().substring(0,4) == "1471" || $("#cate").val().substring(0,4) == "1472" || $("#cate").val().substring(0,4) == "1473") ){
						$(".inForm").html(null);
						var template = "";
						template += "{{#priceList}}<span><input type=\"tel\" id=\"srhPrice\" value=\"{{minPirce}}\" onkeyup=\"inputPriceCheck(this);\" onclick=\"CmdBottomMenu('1');\" onfocusout=\"CmdBottomMenu('2');checkNumberFormat(this);\"/></span><span style=\"width:28px;\">원 ~</span><span><input type=\"tel\" id=\"srhPrice2\" value=\"{{maxPirce}}\" onkeyup=\"inputPriceCheck(this);\" onclick=\"CmdBottomMenu('1');\" onfocusout=\"CmdBottomMenu('2');checkNumberFormat(this);\" / ></span><span style=\"width:20px;\">원</span>{{/priceList}}";
						var html = Mustache.to_html(template, result);		
						$(".inForm").html(html);	
						var tmpMin = $("#srhPrice").val();
						var tmpMax = $("#srhPrice2").val();
						$("#start_price").val(tmpMin);
						$("#end_price").val(tmpMax);
						$("#org_start_price").val(tmpMin);
						$("#org_end_price").val(tmpMax);
						 
						$(".brandSort div").html(null);
						var template = "";
						template += "<ul>{{#factoryList}}";
						template += "<li class=\"pg{{factoryGroup}}\"><label><input class=\"chkbox\" name=\"f_chk\" id=\"{{factoryId}}\" type=\"checkbox\" {{#factoryChk}}{{factoryChk}}{{/factoryChk}}>{{factoryName}} {{#factoryName2}}<br>{{factoryName2}}{{/factoryName2}}<span> ({{factoryCnt}})</span><label></li>";
						template += "{{#factoryNext}}</ul><ul>{{/factoryNext}}";
						template += "{{/factoryList}}";
						template += "</ul>"; 
						template += "{{#factoryNav}}";
						template += "<input type=\"hidden\" id=\"allCnt\" value=\"{{allCnt}}\" >";
						template += "<input type=\"hidden\" id=\"pageCnt\" value=\"{{pageCnt}}\" >";
						template += "{{/factoryNav}}";
													  
						var html = Mustache.to_html(template, result);			
						$(".brandSort div").html(html);	

						var allCnt = $("#allCnt").val();
						allCnt = $(".brandSort li").length;
						allCnt = Math.ceil($(".brandSort li").length / 10);
						var pageCnt = $("#pageCnt").val();
						var firstCnt = $(".brandSort .pg1").length;
						
						$(".pagingview .pagination01 span").html("<strong>1</strong> /  "+commaNum(allCnt));				
					

						var pPage = 1;
						
						var brandWidth = $('.brandSort').width(),
							brandListLength = $('.brandSort > div > ul').length,
							brandListWidth = $('.brandSort > div > ul').width(brandWidth);
						$('.brandSort > div').width((brandWidth * brandListLength));		
						
						var varResearchKeyword = "";
						var x = 0;
						
						var endX = 0;
						var pageW = 0;
						var pageX2 = 0;
						var btnChk = true;
						
						$('.brandSort').bind('mousedown touchstart', function(e){
							btnChk = true;
						});
						$('.brandSort').scroll(function() { 
							setTimeout(function(){
								if(btnChk){
									CmdBrandScroll();
								}
							},100);  
							function CmdBrandScroll(){
								endX = $('.brandSort').scrollLeft();
								pageW = $('.brandSort ul li').width() * 2;
								pageX2 = parseInt(endX / pageW) + 1;
								
								if(pageX2*10 > (allCnt*10)){
								 	$(".pagination01 span strong").html(commaNum(allCnt));
								 	pPage = pageX2;
								}else{
									$(".pagination01 span strong").html(commaNum(pPage));	
									pPage = pageX2;
								}
							}
						});
						$(".pagingPrev2").click(function() { 
							if(pPage > 1){
								btnChk = false;
								pPage = pPage - 1;
								$(".sortSelect .brandSort").scrollTo( (pPage-1) * $('.brandSort').width(), 200 );
								$(".pagination01 span strong").html(commaNum(pPage));	
							} 
							if(pPage == 1){
								$(".sortSelect .brandSort").scrollTo( 0 , 200 );
							}
						}); 
						$(".pagingNext2").click(function() { 
						//	alert(pPage + " , "+ pageCnt)
							if(pPage < pageCnt){
								btnChk = false;
								$(".sortSelect .brandSort").scrollTo( pPage*$('.brandSort').width(), 200 );
								pPage = pPage + 1;

								$(".pagination01 span strong").html(commaNum(pPage));											
							}
						});
						
						$(".chkbox").click(function() { 
							if($("#cm_loading").is(":visible")){
								return false;
							}else{
								CmdSpinLoading();
								
								if(this.checked){
									this.checked = true;
									if(varResearchKeyword.length == 0){
										varResearchKeyword += this.id; 
									}else{
										varResearchKeyword +=  "," + this.id; 
									}
								}else{
									this.checked = false;
									varResearchKeyword = varResearchKeyword.replace(this.id, "").replace(",,", ",");
								} 
								if(varResearchKeyword.length > 1){
									if(varResearchKeyword.substring(0,1) == ","){
										varResearchKeyword = varResearchKeyword.substring(1,varResearchKeyword.length);
									}
								}
								if(varResearchKeyword == ","){
									varResearchKeyword = "";
								}
							
								
								var tmpFactory = varResearchKeyword;
								if($("#BrandTab").text() == "쇼핑몰"){
									$("#shop_code").val(tmpFactory)
								}else{
									$("#factory").val(tmpFactory);
								}
								$("#page").val('1');
								
								getList();
							}
						});
					}
					*/
				}
				if(type == 'a'){ 
					//검색목록 카테고리_추천
					var chucategory = "";
					chucategory += "{{#chu_category}}"; 
					chucategory += "<li><a href=\"javascript:///\" class=\"searchCates\" id=\"{{code}}\"><span>{{name}}</span> <span style='color:#8c8c8c;font: 12px/1.5 '돋움',Dotum,'굴림',Gulim,Helvetica,sans-serif;'>({{cnt}})</span></a></li>";  
					chucategory += "{{/chu_category}}";   
					var categoryHtml = Mustache.to_html(chucategory, result);		
					$("#chkCategory").html(categoryHtml); 	
				}
				if(type == 'a' || type == 'b'){ 	
					if($("#from").val() == "searchOrg"){
						searchFlag = true;
					}

					//검색목록 카테고리_전체_타이틀
					var mcategory_title = "";
					mcategory_title += "{{#m_category_title}}";  
					if(searchFlag){
						mcategory_title += "전체 카테고리  {{name4}} <span>({{length}}개 카테고리)</span>";  
					}else{
						mcategory_title += "전체 카테고리 <span>({{length}}개 카테고리)</span>";  
					}
					mcategory_title += "{{/m_category_title}}";   
					var categoryHtml = Mustache.to_html(mcategory_title, result);		
					$("#categoryAll").html(categoryHtml);	

					searchFlagTitle = $("#categoryAll").html();
					if(searchFlag){
						searchFlagTitle = searchFlagTitle.replace("전체 카테고리","");
						searchFlagTitle = searchFlagTitle.substring(0, searchFlagTitle.indexOf("<span"));
					}
					categoryHtmlOrg_prevTitle = $("#categoryAll").html();
					
					if(searchFlag){
						categoryHtmlOrg_prevTitle = categoryHtmlOrg_prevTitle.replace(searchFlagTitle,"");
					}
					
					//검색목록 카테고리_전체
					var mcategory = "";
					mcategory += "<ul class=\"non_chk\">"; 
					mcategory += "{{#m_category}}"; 
					//mcategory += "<li class=\"searchCate pg{{pg}}\" id=\"{{code}}\"><a href=\"javascript:///\"><span>{{name}}</span> <div style='color:#8c8c8c;font: 12px/1.5 '돋움',Dotum,'굴림',Gulim,Helvetica,sans-serif;'>{{cnt}}</div></a></li>";  
					mcategory += "<li  class=\"searchCate pg{{pg}}\" id=\"{{code}}\"><label>{{name}}<span>({{cnt}})</span></label></li>";
					mcategory += "{{#ul}}</ul><ul class=\"non_chk\">{{/ul}}";  
					mcategory += "{{/m_category}}";   
					mcategory += "</ul>"; 
					var categoryHtml = Mustache.to_html(mcategory, result);		
					$(".allCateLIst .mCate").html(categoryHtml);	
					$(".allCateLIst .mCate").show();
					$(".allCateLIst .sCate").hide();
					$(".pagingview .pagination02").show();
					$(".pagingview .pagination03").hide();
					 				
					var allCnt = $("#allCnt").val();
					allCnt = $(".allCateLIst .mCate li").length;
					var pageCnt = Math.ceil(allCnt / 10);
					var firstCnt = $(".allCateLIst .mCate .pg1").length;
					
					$(".pagingview .pagination02 span").html("<strong>1</strong> /  "+commaNum(pageCnt));
					
					var pPage = 1;
					
					var cateWidth  = $('.allCateLIst').width(),
					listLength = $('.allCateLIst .mCate > ul').length,
					listWidth = $('.allCateLIst .mCate > ul').width(cateWidth);
					$('.allCateLIst .mCate').width((cateWidth * listLength));
					
					var endX = 0;
					var pageW = 0;
					var pageX2 = 0;
					var btnChk = true;
					
					$('.allCateLIst').bind('mousedown touchstart', function(e){
						btnChk = true;
					});
					$('.allCateLIst').scroll(function() { 
						setTimeout(function(){
							if(btnChk){
								CmdBrandScroll();
							}
						},100);  
						function CmdBrandScroll(){
							endX = $('.allCateLIst').scrollLeft();
							pageW = $('.allCateLIst .mCate ul li').width() * 2;
							pageX2 = parseInt(endX / pageW) + 1;
							
							if(pageX2 > allCnt){
							 	$(".pagingview .pagination02 span strong").html(commaNum(pPage));
							 	pPage = pageX2;
							}else{
								var pCnt = (pageX2);
								$(".pagingview .pagination02 span strong").html(commaNum(pCnt));	
								pPage = pageX2;
							} 
						} 
					});
					$(".pagination02 .pagingPrev2").click(function() { 
						if(pPage > 1){
							btnChk = false;
							pPage = pPage - 1;
							$(".allCateLIst").scrollTo( (pPage-1) * ($('.searchCate').width()*2) + (pPage*2), 200 );
							$(".brandSort").scrollTo( (pPage-1) * $('.brandSort').width(), 200 );
							var pCnt = $(".mCate .pg"+pPage).length;
							pCnt = pPage;
							$(".pagination02 span strong").html(commaNum(pCnt));	
						} 
						if(pPage == 1){
							$(".sortSelect .allCateLIst").scrollTo( 0 , 200 );
						}
					}); 
					$(".pagination02 .pagingNext2").click(function() { 
						if(pPage < pageCnt){
							btnChk = false;
							$(".allCateLIst").scrollTo( pPage *($('.searchCate').width()*2) + (pPage*2), 200 );
							pPage = pPage + 1;
							var pCnt = $(".mCate .pg"+pPage).length;
							pCnt = pPage;
							$(".pagination02 span strong").html(commaNum(pCnt));											
						}
					});					
				}			
				
				//전체갯수
				var listCnt = "{{#goodsCnt}}{{cnt}}{{/goodsCnt}}";
				var listOxy = "{{#goodsCnt}}{{oxy}}{{/goodsCnt}}";
				var listCntHtml = Mustache.to_html(listCnt, result);		
				var vOxy = Mustache.to_html(listOxy, result);		

				allcnt = listCntHtml; 
				
				if(listCntHtml == 0 ){
					//검색결과 없음 
					if( $("#key").val() != "new" && ( document.URL.indexOf("list.jsp") >= 0 || ( document.URL.indexOf("search.jsp") >= 0 && type!='a')) ){
					  alert("상품이 없습니다.");
					  $("#srhPrice").val(vPrice_start);
					  $("#srhPrice2").val(vPrice_end);
					  $("#start_price").val(vPrice_start);
					  $("#end_price").val(vPrice_end);
					  return false;
					}
					$(".lp_tab").hide();

					if($("#key").val() == "new"){
					  $(".prodSortOpt").show();
						$(".searchNone .txt1").html("출시예정인 상품이 없습니다.");
						$(".txt2").hide();
						$(".txt3").hide();
					}else{
						$(".prodSortOpt").hide();
						$(".searchNone .txt1").html("상품정보가 없습니다.");
						if( document.URL.indexOf("search.jsp") >= 0 ){
							if(vOxy == ""){
								$(".txt2").hide();
								$(".txt2").show();
							}else{ 
								$(".txt2").hide();
								$(".txt3").show();
								$("#socialMiniDiv").hide();
							}
						}
					}
					$(".panel").hide();
					$(".searchNone").show();
					$("#pagingNextList").hide();
					if( document.URL.indexOf("search.jsp") >= 0 ){
						if($(".m_top_sub #goodsCnt").html().indexOf("(0건)") > -1){
							$(".prodSort").hide();
						}
					}   

					//location.href = "search2.jsp?keyword="+$("#all_keyword").val();
				}else{
					if( document.URL.indexOf("search.jsp") >= 0 ){
						$(".prodSort").show();
					}
					$(".lp_tab").show(); 
					$(".prodSortOpt").show();
					$(".panel").show();
					$(".searchNone").hide();
					$("#pagingNextList").show();
				 
				} 
				if(listCntHtml == "-60,004" ){		//-60004 : 검색시 timeout 코드
					if( $("#search_reload").val() == "" ){
						$("#search_reload").val("1");
						//alert("재검색1");
						getList();
						return false;  
						//location.href = document.URL+"&reload=1";
					}else if( $("#search_reload").val() == "1" ){
						$("#search_reload").val("");
						listCntHtml = 0;  
						//alert("재검색2");
						$(".prodSortOpt p").html(listCntHtml+"건");	
					}  
				}else{  
					$(".prodSortOpt p").html(listCntHtml+"건");	
				}
				
				//if($("#goodsCnt").html()){  
					if(type == 'a'){ 
					//if($("#goodsCnt").html().trim() == "()"){
						$("#goodsCnt").html(" ("+listCntHtml+"건)");	
					//}
					}
				//}
				 
				
				var sponChk = "";
				if(getParam().indexOf("sponChk=Y") > 0 ){
					sponChk = "Y";
				}
			
				//목록 

				if(type == 're') { 	
				}else{ 
				//	$(".prodList").html(null);
				}
				  
				var listDiv = "";
				
				listDiv += "{{#goodsList}}";
				listDiv += "<li class=\"listLi\" >	";			
				listDiv += "<a href=\"javascript:///\" class=\"listarea\" id=\"{{modelno}}\" shopcode=\"{{shopcode}}\" infoad=\"{{info_ad}}\" >	";			 
				listDiv += "		<input type=\"hidden\" id=\"goods{{modelno}}_modelno\" name=\"modelno\" value={{modelno}}>";
				listDiv += "		<input type=\"hidden\" id=\"goods{{modelno}}_popularmodelno\" name=\"popularmodelno\" value={{popularmodelno}}>";
				listDiv += "		<input type=\"hidden\" id=\"goods{{modelno}}_ca_code\" name=\"ca_code\" value={{ca_code}}>";
				listDiv += "		<input type=\"hidden\" id=\"mobileurl\" {{#mobileurl}}value=\"{{mobileurl}}\"{{/mobileurl}}>";
				if(sponChk == "Y"){
				listDiv += "	{{#info_ad}}<span class=\"pluslink\">INFO AD</span>{{/info_ad}}";
				}else{
				listDiv += "	{{#info_ad}}<span class=\"pluslink\">INFO AD</span>{{/info_ad}}{{^info_ad}}{{#sponsor}}<span class=\"sponsor\">스폰서</span>{{/sponsor}}{{/info_ad}}";   
				} 
				
				listDiv += "	{{#rental}}<span class=\"rent\">렌탈가능</span>{{/rental}}	";		
				listDiv += "	{{^rental}}{{^info_ad}}{{#hot}}<span class=\"rank\">{{hot}}</span>{{/hot}}{{/info_ad}}{{/rental}}	";			
				listDiv += "	<p class=\"prodChoice\" onclick=\"event.cancelBubble=true;\"><button type=\"button\" id=\"{{zzimId}}\">찜</button></p>	";			
				//listDiv += "	<span class=\"thum\"><img src=\"http://imgenuri.\enuri.gscdn.com/images/mobilefirst/enuri_rod.png\" data-original=\"{{imgurl}}\"  alt=\"{{modelnm}}\"  id=\"img_{{modelno}}\" class=\"thum\"  onerror=\"CmdErrImg('{{modelno}}','{{imgurl_er}}')\"/></span>";
				listDiv += "	<span class=\"thum\"><img src=\"{{imgurl}}\" alt=\"{{modelnm}} 제품이미지\" id=\"img_{{modelno}}\" onerror=\"CmdErrImg('{{modelno}}','{{imgurl_er}}')\"  !style=\"width:100%;height:100%;\" /></span>";
				listDiv += "	<div>	";			 
				//listDiv += "		<span class=\"stit\">{{{copyphrase}}}&nbsp;</span>	";			 
				listDiv += "		<span class=\"com\"><em>{{{factory}}}</em><em class=\"date\">{{date}}</em><em class=\"company\">{{mallcnt}}</em></span>	";			
				listDiv += "		<strong id=\"goods{{modelno}}_modelnm\">{{{modelnm}}}</strong>	";		  
				listDiv += "		<span class=\"stit\">{{#bbs_num}}상품평({{bbs_num}}){{#salecnt}}<em>|</em>판매량({{salecnt}}){{/salecnt}}{{/bbs_num}}</span>	";		
				//listDiv += "		{{#salecnt}}<em class=\"sales\">{{salecnt}}</em>{{/salecnt}}		";	
				listDiv += "		{{^type}}<em class=\"shop\">{{mallcnt3}}</em>{{/type}}		";	 
				listDiv += "		<span class=\"price {{^type}}shop_p{{/type}}\">	";			 
				listDiv += "			{{#soldout_y}}<em class=\"soldout\">단종/품절</em>{{/soldout_y}}	"; 
				listDiv += "			{{^new}}<em class=\"release\">{{minprice3}}</em>{{/new}}";   
				listDiv += "			{{#soldout_n}}{{#new}}{{#type}}<span class=\"min\">최저가</span> {{/type}}<em>{{minprice3}}<em>원</em></em>{{/new}}{{/soldout_n}}";   
				listDiv += "		</span>	";			
				listDiv += "	</div>	";			   
				listDiv += "</a>	";			  
				listDiv += "{{#spec}}";	
				//마음열기
				listDiv += "{{#info_ad}}";	 
				listDiv += "<a href=\"javascript:///\" class=\"news\" id=\"infoAd_{{modelno}}\"></a>";
				listDiv += "{{/info_ad}}"; 	
				listDiv += "<div class=\"prodtxt toggle {{#prodtxt}}line{{/prodtxt}} {{#spec_length}}spec{{/spec_length}}\" value=\"Hide\" >";
				listDiv += "{{^spec_length}}<span>더보기</span>	{{/spec_length}}";			
				listDiv += "{{{spec}}}";			 
				listDiv += "{{^spec_length}}<em class=\"btndetail\"  id=\"btndetail_{{modelno}}\" onclick=\"event.cancelBubble=true;\"><a href=\"javascript:///\">자세히</a></em>{{/spec_length}}	";			
				listDiv += "</div>	";	
				listDiv += "{{/spec}}	";			
				listDiv += "{{#type}}";   
				listDiv += "{{^new2}}"; 
				listDiv += "<div class=\"pircelist plist {{#mall_YN}}mall{{/mall_YN}}{{#option_YN}}option{{/option_YN}} \" id=\"goods{{modelno}}\">	";			
				listDiv += "	<dl>	";	 
				listDiv += "		{{#group_cnt}}<dt>가격비교{{#mallcnt3}}<em>({{mallcnt3}})</em>{{/mallcnt3}}{{#option_YN}}<span>옵션보기({{group_cnt}})</span>{{/option_YN}}</dt>{{/group_cnt}} ";
				listDiv += "		{{^group_cnt}}<dt>가격비교<span>업체({{mallcnt3}})</span></dt>{{/group_cnt}}	";			
				listDiv += "		<dd class=\"enuriList\">	";		 	 
				listDiv += "		</dd>	";			
				listDiv += "	</dl>	";			
				listDiv += "	<p class=\"moreBtn\" ><a href=\"javascript:///\"><span id=\"option_more_{{modelno}}\">더보기 (5/{{#mall_YN}}{{mallcnt3}}{{/mall_YN}}{{#option_YN}}{{group_cnt}}{{/option_YN}})</span><em class=\"link\">전체보기 {{#mallcnt3}}({{mallcnt3}}){{/mallcnt3}}</em></a></p><!-- 접기  class=\"on\"-->	";			
				listDiv += "</div>	";		
				listDiv += "{{/new2}}"; 
				listDiv += "{{/type}}";  	
				listDiv += "</li>	";	
				listDiv += "{{/goodsList}}";   
						
				
				var listDivHtml = Mustache.to_html(listDiv, result);	 
				listDivHtml = listDivHtml.split("별도확인</span>원").join("별도확인").split("출시예정</span>원").join("출시예정");		
				listDivHtml = listDivHtml.split("별도확인 원").join("별도확인").split("출시예정 원").join("출시예정");		

				
				if($("#page").val() == 1){ 
					//$('.prodList').html(listDivHtml.replace(/&amp;/gi,"&").replace(/&apos;/gi,"'"));
					if($("#page").val()=="1" && type == 'a' && ($("#key").val() == "" || $("#key").val() == "popular DESC")){
						$('.prodList').append(listDivHtml.replace(/&amp;/gi,"&").replace(/&apos;/gi,"'"));
						//$('.prodList').html(listDivHtml.replace(/&amp;/gi,"&").replace(/&apos;/gi,"'"));
					}else{  
						$('.prodList').html(listDivHtml.replace(/&amp;/gi,"&").replace(/&apos;/gi,"'"));
					}
					$("#pagingNextList").show();
					
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

					if($('.prodList li').length < adlineidx){
						$('.prodList li:eq('+($('.prodList li').length-1)+')').after("<li id=\"adline\" style=\"display:none;\"></li>");
					}else{
						$('.prodList li:eq(' + adlineidx.toString() + ')').after("<li id=\"adline\" style=\"display:none;\"></li>");
					}

					if(type == 'a'){
						//getEDPlatformData();
						//cpcLoading();
					}else{

						$('.prodList #adline').before(ebayMakeTmp);
						//jq11(".pluslink_goods_list").show();
						setPowerLinkLinkLpRe();  
					}
				}else{   
					$('.prodList').html(listDivHtml.replace(/&amp;/gi,"&").replace(/&apos;/gi,"'"));
					//$('.prodList').append(listDivHtml.replace(/&amp;/gi,"&").replace(/&apos;/gi,"'"));
				}
						
				if($(".prodList li").length > 19){
					$("#pagingNextList").show(); 
				}else{  
				//	$("#pagingNextList").hide();
				}
				if(listCntHtml == 0){ 
					$("#pagingNextList").hide();
				} 	 	
				if($(".plist").length > 0 || ( $("#cate").val().substring(0,4) == "1482" || $("#cate").val().substring(0,4) == "1483" || $("#cate").val().substring(0,4) == "1484") || $("#cate").val().substring(0,4) == "1485") {
					$("#BrandTab").text($("#brandtab").val());
					$(".searh_align").show();
					$(".searchArea").css("paddingTop", "0px");
				}else{
					$("#BrandTab").text("쇼핑몰");
					$(".searh_align").hide();
					$(".searchArea").css("paddingTop", "10px");
				}
 
				$('.prodList .thum').find("img").each(function(){
                    
                    var aa = $(this).width();
                    var bb = $(this).height();
                    
					 if(aa > bb){
					   $(this).css("width","100%");
					   $(this).css("height","");
					}else if(aa < bb){
					   $(this).css("width","");
					   $(this).css("height","100%");
					 }else{
					   $(this).css("width","100%");
					   $(this).css("height","100%");
					 }
				});   
				
				//검색 카테고리 pcate
				var pCate = "{{#pcate}}{{pcate}}{{/pcate}}";
				var pCateHtml = Mustache.to_html(pCate, result);		
				$("#pcate").val(pCateHtml);	
								
				//찜 스크립트
				var zzimG = "{{#zzimModel}}{{Model}}{{/zzimModel}}";
				var zzimGHtml = Mustache.to_html(zzimG, result);		
				 
				goodsNumbers = zzimGHtml;

				//마음열기 스크립트
				var infoadModels = "{{#infoModels}}{{Model}}{{/infoModels}}";
				var infoAdHtml = Mustache.to_html(infoadModels, result);		
				
				var arrInfoad = infoAdHtml.split(",");
				for( var infoad = 0 ; infoad < arrInfoad.length ; infoad++){
					if(arrInfoad[infoad].length > 0 ){
						getInfoAdItemData(arrInfoad[infoad]);
					}
				}
				if(type == 'a'){ 				
					$('.searchCates').click(function(){
						CmdSpinLoading();
						$(".brandSort div").html(null);
						$("#BrandTab").text($("#brandtab").val());
						$("#factory").val("");
						$("#shop_code").val("");
					
						$(".searchCates").css("color","#4c5363");
						$(".searchCates2").css("color","#4c5363");
						
						var thisId = this.id; 
						var thisName = $("#"+thisId).html();
						$("#chuText").html(thisName);
						
						if($("#cate").val() == thisId){
							$("#cate").val("");
						}else{
							$("#"+thisId).css("color","#0081e5");		
							$("#cate").val(thisId);
						} 
						
						$("#page").val('1');
						var  param = getParam();
						 
						getList('b');
						//location.href = "/mobilefirst/search.jsp?"+param;		
					});	
				}	
					$('.toggle').click(function(){
						if ($(this).hasClass("txtclose")) {
							$(this).removeClass("txtclose");
						} else {
							$(this).addClass("txtclose");
							var _Height =  $(this).height();
						
							if(_Height < 20){
								$(this).removeClass("txtclose");
							} 
							if(document.URL.indexOf("list.jsp") >= 0){
								ga('send', 'event', 'mf_lp', 'lp', 'lp_+');
							}
						}   
					});
					 
					/*가격비교*/
					$('.plist dt').unbind("click");
					$('.plist dt').click(function(){
						var _this = this.parentNode.parentNode.id;
						
						if ($("#"+_this).hasClass("pmore")) {
							$("#"+_this).removeClass("pmore");
						} else {
							$("#"+_this).addClass("pmore");
							if(document.URL.indexOf("list.jsp") >= 0){
								ga('send', 'event', 'mf_lp', 'lp', 'lp_option view');
							}
						}  
					});
 					$('.plist .link').click(function(){
 						if(document.URL.indexOf("list.jsp") >= 0){
 							ga('send', 'event', 'mf_lp', 'lp', 'lp_all view');
 						}
						var _this = this.parentNode.parentNode.parentNode.id;
						
						var thisInfoad = $("#"+_this.replace('goods','')).attr("infoad");
						var vInfoad = "";
						if(thisInfoad == "Y"){
							vInfoad = "&from=infoad";
						}
						
						CmdDetail("/mobilefirst/detail.jsp?modelno="+_this.replace('goods','')+"&group=1"+vInfoad);
						//location.href = "/mobilefirst/detail.jsp?modelno="+_this.replace('goods','')+"&group=1";
					});
					$('.btndetail').click(function(){
						var _this = this.id; 
						
						var thisInfoad = $("#"+_this.replace('btndetail_','')).attr("infoad");
						var vInfoad = "";
						if(thisInfoad == "Y"){
							vInfoad = "&from=infoad";
						}
						
						CmdDetail("/mobilefirst/detail.jsp?modelno="+_this.replace('btndetail_','')+"&tab=2&group=1"+vInfoad);
						//location.href = "/mobilefirst/detail.jsp?modelno="+_this.replace('btndetail_','')+"&tab=2";
					});
					$('.pircelist dt').click(function(){ 
						var thisId = this.parentNode.parentNode.id;
						if($("#"+thisId).hasClass("soon")){
						}else{  
							if($("#"+thisId).hasClass("pmore")){
								if($("#"+thisId).hasClass("option")){
									getOption($("#"+thisId+"_modelno").val());
								}else if($("#"+thisId).hasClass("mall")){
									getMall($("#"+thisId+"_modelno").val());
								} 
							}
							if(document.URL.indexOf("list.jsp") >= 0){ 
								if($("#"+thisId).hasClass('on')) {
								}else{
									insertLog('11025');
								}
							}
						}
					});		 
					$('.prodSummary button').click(function(){
						var thisId = this.parentNode.id;
						if(document.URL.indexOf("list.jsp") >= 0){
							if($("#"+thisId).hasClass('on')) {
							}else{
								insertLog('11026');
							}
						}
					});	
					//$('.prodChoice button').click(function(){
						//$(this).toggleClass('on'); 
					//});			
		  
					$('.prodEnuriInfo > li > button').click(function(){
						var _this = $(this);
						var thisId = this.parentNode.id;
					
						if($("#"+thisId).hasClass("soon")){
						}else{
							tabCont(_this);
						}
					});
					$('.btnAll').click(function(){
						var thisId = this.id;
						
						var thisInfoad = $("#"+thisId).attr("infoad");
						var vInfoad = "";
						if(thisInfoad == "Y"){
							vInfoad = "&from=infoad";
						}
						
						CmdDetail("/mobilefirst/detail.jsp?modelno="+thisId+"&group=1"+vInfoad);
						//location.href = "/mobilefirst/detail.jsp?modelno="+thisId+"&group=1";
					});
					$('.listarea').click(function(){
						var thisId = this.id;
						var thisShopcode = $(this).attr("shopcode");
						var thisCate = $("#goods"+thisId+"_ca_code").val();
						var mobileUrl = $("#"+thisId+" #mobileurl").val();
						var thisName = $("#goods"+thisId+"_modelnm").text();
						
						var thisInfoad = $(this).attr("infoad");
						if(thisInfoad == "Y"){
							ga('send', 'event', 'mf_lp_Info_Ad_list', 'click_'+thisId, 'click_'+thisId);
						}
						var vInfoad = "";
						if(thisInfoad == "Y"){
							vInfoad = "&from=infoad";
						}
						
						var thisText = $("#goods"+thisId+" td:first").text();
						
						if($("#img_"+thisId).attr("src").indexOf("img_19.jpg") > 0 ){
							goALogin(); 
						}else{
							if(mobileUrl.length > 0){
								addResentZzimItem(1, "P", thisId); 
								
								var newUrl = mobileUrl;
								
								if( navigator.userAgent.indexOf("iPhone") > 0 || navigator.userAgent.indexOf("iPod") > 0 ||  navigator.userAgent.indexOf("iPad") > 0){
								//	newUrl = newUrl + "&DEVICE_BROWSER=Y";
									if(newUrl.indexOf("?") > -1){
										newUrl = newUrl + "&DEVICE_BROWSER=Y";
									}else{
										newUrl = newUrl + "?DEVICE_BROWSER=Y";     
									} 
								}

								var today = new Date();
								var month = (today.getMonth() + 1);
								var date = today.getDate(); 
											
								if(newUrl.indexOf("akmall.com") > 0 && month == 9 && date >= 19 ){
									alert("쇼핑몰 시스템 점검중입니다.");
									return false;
								}

								//앱에서 사용할 최근본 함수
								
								try{
									if(getCookie("appYN") == "Y"){
										if(window.android){		// 안드로이드 			
								    		window.android.getRecentData(thisName , "P:"+thisId, $("#img_"+thisId).attr("src") , newUrl);
								    	}else{							// 아이폰에서 호출
								    		//window.location.href = "appcall://getRecentData?name="+encodeURIComponent(thisName)+"&code=P:"+encodeURIComponent(thisId)+"&imageurl="+encodeURIComponent($("#img_"+thisId).attr("src"))+"&url="+encodeURIComponent(newUrl)+"";
								    		window.location.href = "enuriappcall://getRecentData?name="+encodeURIComponent(thisName)+"&code=P:"+encodeURIComponent(thisId)+"&imageurl="+encodeURIComponent($("#img_"+thisId).attr("src"))+"&url="+encodeURIComponent(newUrl)+"";
								    	}
								     } 
								}catch(e){}  
								
								//var newWin = window.open(newUrl); 
								//url, shopcode, plno, goodscode, instanceprice, category, price, minprice,  obj, get_modelno
								goShop(newUrl, thisShopcode, thisId, '', '', thisCate, '', '', '', '0'); 
								
							}else{  
								//if(thisText == "PC 최저가"){
								//}else{
								CmdDetail("/mobilefirst/detail.jsp?modelno="+thisId+"&group=1"+vInfoad);
								
								//CmdDetail("/mobilefirst/detail.jsp?modelno="+thisId+"&group=1&cate="+$("#cate").val());
								//location.href = "/mobilefirst/detail.jsp?modelno="+thisId+"&group=1";
								//}
							}
						} 
					});
					$('.infoBox .btn').click(function(){
						var thisId = this.id; 
						
						var thisInfoad = $("#"+thisId).attr("infoad");
						var vInfoad = "";
						if(thisInfoad == "Y"){
							vInfoad = "&from=infoad";
						}
					
						CmdDetail("/mobilefirst/detail.jsp?modelno="+thisId+"&tab=2"+vInfoad);
						//location.href = "/mobilefirst/detail.jsp?modelno="+thisId+"&tab=2";			
					});
					if(type == 'a' || type == 'b'){ 	
						$('.searchCate').click(function(){
							$(".brandSort div").html(null);
							$("#BrandTab").text($("#brandtab").val());
							$("#factory").val("");
							$("#shop_code").val("");
						
							CmdSpinLoading();
							
							var thisId = this.id;
										 	
							var thisName = $("#"+thisId).html();
							thisName = thisName.substring(thisName.indexOf("<label>"+7),thisName.indexOf("<span>"));
							thisName = thisName.replace("<label>","");
							 
							if(thisName.indexOf("기타 일반상품") >= 0){
								$("#cate").val(thisId);
								$("#page").val('1');
								
								getList('re');
							}else{
								sCategory(thisId, thisName);
							}		
							ga('send', 'event', 'mf_srp', 'srp_cate', 'srp_category');
						});
					}
					 
					if(szCategoryPower.length == 0){
						szCategoryPower = $("#pcate").val();	
						szCategoryPower = szCategoryPower.replace("-","");
						catePower = $("#pcate").val();
						catePower = catePower.replace("-","");
					} 

					if(type == 'a'){ 			
						ad_commandPower = encodeURIComponent(result.ad_command);
						if(szCategoryPower != "-" || szCategoryPower == "" ){
							//if($(".prodChoice").length < 20){
							if($(".listLi").length < 4){
								setPowerLinkLink();		//하단 파워링크
							}else{
								setPowerLinkLinkLp();	//상,하단 파워링크
							}
						}else{
							$(".powerLink").hide();
						} 
						cpcLoading();
					}  
					
					//하단 페이징 부분
					//하단 페이징 부분
					var pageBar = "{{#goodsPageBar}}더보기 ({{pageBar}}/{{cnt}}){{/goodsPageBar}}";
					var pageBarHtml = Mustache.to_html(pageBar, result);		
					$("#pagingNextList span").html(pageBarHtml);	
					
					var page_s = pageBarHtml.substring(pageBarHtml.indexOf("(")+1,pageBarHtml.indexOf("/"));
					var page_e = pageBarHtml.substring(pageBarHtml.indexOf("/")+1,pageBarHtml.indexOf(")"));
					 
					if(page_s == page_e){
						$("#pagingNextList").hide();
					}	
					//$(".moreBtn").show();
					
					$("#pagingNextList").hide();
					//if( type == 'a' ){
					var vPaging = "<li></li><li>#n</li><li>#n</li><li>#c</li><li>#n</li><li>#n</li><li></li>";

					$("#paging").html(vPaging);
					
					if($(".searchNone").is(":visible")){ 
					}else{
						$("#paging").show();
					}
					
					if($("#page").val() == 1){
						$("#paging").easyPaging(listCntHtml.replace(/,/gi,""), {
								perpage: 20,
								page: 1,
								onSelect: function(page) {
								if($("#page").val() != page){
									scrollTo(0, 0);
									$("#page").val(page);
										getList();
									}
								} 
				         });	 
					}else{
							$("#paging").easyPaging(listCntHtml.replace(/,/gi,""), {
								perpage: 20,
								page: $("#page").val(),
								onSelect: function(page) {
									if($("#page").val() != page){ 
										scrollTo(0, 0);
										$("#page").val(page);
										getList();
									}
								} 
				            });
						}
					//}

		},
			complete: function(){  
				/*$("img.thum").lazyload({
					onError: function(element) {
			           console.log("error loading image: " + $(this));
			        }
				});*/
				if($("#allopen").val() =="y" || $(".btnAllOpen").hasClass("on")){
					$('.prodList .prodtxt').addClass('txtclose');
				}
				
				zzimCheckSet();
				
				$("#cm_loading").hide();	
				
				if($("#search_reload").val() == "1" && $(".prodSortOpt p").html() == "조회중..."){
				}else{ 
					$(".loading").hide();	
				}
				 
				$("#pagination").show(); 

				if($(".sCate").is(":visible")){ 
					$(".pagination03").show();
				}else{
					$(".pagination03").hide();
				}
				
				if($("#from").val() == "search" && $("#page").val()  == 1 && location.href.indexOf("&gseq=") < 0 ){
					$("#PriceTab").click();
				}else{ 
					if($("#from").val() == "searchOrg" && searchFlag){
						$("#cateSort1").removeClass('on');
						$("#cateSort2").addClass('on');
						sCategory($("#cate").val(), $("#keyword").val());
						$("#"+$("#cate").val()).css("color","#0081e5");
						$(".pagingview2").show();
					}   
	
				}
				if($("#grid").val() == "y" ){
					$('.btnGrid').click();
				}else{
					if($("#allopen").val() == "y" ){
						$('.btnAllOpen').addClass('on');
						$('.prodSummary').addClass('on');
					}
					$('.btnList').click();
				}   
				if($("#key").val() == "new"){
					$(".lp_tab").hide();
					$(".panel").hide();
				} 

			}		   
		}); 	
	}
	function layerPop2(_this){
		$(_this.attr('href')).show();
		var layerPopHeight = $(_this.attr('href')).find('.layerPopInner').height();
		$(_this.attr('href')).find('.layerPopInner').css('margin-top','-'+ layerPopHeight / 2 + 'px' )
		$('body').append('<div class="dimmed"></div>');
		$('html, body').addClass('dimdOn');
	}
	function getSpec(param){
		//if ($(".sortBox").html().trim().length == 0 || param != ""){
		if ($(".spec").html().trim().length == 0){	
			CmdSpinLoading();
			var vParam = getParam();
			$.ajax({
				type: "GET",
				url: "/mobilefirst/ajax/listAjax/getSpec_ajax.jsp", 
				async: false,
				data: vParam,
				//data: "cate="+cate,
				dataType:"JSON", 
				success: function(result){
					$(".spec").html(null); 
					var template = ""; 
					var template2 = ""; 
					template += "{{#specList}}";
					template += "<li><span>{{spec_group_title}}</span><a href=\"#selOption{{gpno}}\" class=\"ms-choice\"  id=\"{{gpno}}\"><span id=\"selOptionText{{gpno}}\" style=\"padding-left:90px;\">속성선택</span></a></li>";
					template += "{{/specList}}";	
					
					template2 += "{{#specList}}";
					template2 += "<section id=\"selOption{{gpno}}\" class=\"layerPop transfer-popup select-option\">";	
					template2 += "	<div class=\"layerPopInner\">";	
					template2 += "		<div class=\"layerPopCont\">";	
					template2 += "			<h1>사양선택 <span class=\"spec_cnt\"></span></h1>";	
					template2 += "			<button class=\"btnClose\" id=\"{{gpno}}\">최저가 가격알림 창 닫기</button>";	
					template2 += "			<div class=\"contents\">";	
					template2 += "				<ul>";	
					template2 += "					<li>";	 
					template2 += "						<label for=\"\" style=\"font-weight:bold;\">";	
					template2 += "							선택안함";	
					template2 += "							<input type=\"checkbox\" name=\"spec_cancle\" id=\"uncheck{{gpno}}\" class=\"spec_cancle\" />";	
					template2 += "						</label>";	
					template2 += "					</li>";	
					template2 += "				</ul>";	
					template2 += "				<ul style=\"border-bottom:1px solid #d7d7d7;\">";	
					template2 += "				{{#spec}}";	
					template2 += "					{{#spec_delflag}}<h2 class=\"section-title\">{{spec_cate_title}}</h2>{{/spec_delflag}}";
					template2 += "					{{^spec_delflag}}";
					template2 += "						<li id=\"spec_li_{{specno}}\" >";	
					template2 += "							<label for=\"\">";	 
					template2 += "								{{spec_cate_title}}";	
					template2 += "								<input type=\"checkbox\" name=\"spec_chk\" id=\"spec_{{specno}}\" value=\"{{specno}}\" class=\"spec_chk\" /> ";	
					template2 += "								<input type=\"hidden\" id=\"gpno_{{specno}}\" value=\"{{gpno}}\"> ";	
					template2 += "								<input type=\"hidden\" id=\"gpsno_{{specno}}\" value=\"{{gpsno}}\"> ";	
					template2 += "								<input type=\"hidden\" id=\"gpno_aoflag_{{specno}}\" value=\"{{gpno_aoflag}}\"> ";	
					template2 += "								<input type=\"hidden\" id=\"gpsno_aoflag_{{specno}}\" value=\"{{gpsno_aoflag}}\">	 ";	
					template2 += "							</label>";	
					template2 += "						</li>";	
					template2 += "					{{/spec_delflag}}";
					template2 += "				{{/spec}}";	
					template2 += "				</ul>";
					template2 += "			</div>";	
					template2 += "			<div class=\"layerBtn\" style=\"height:35px;font-size:12px;font-family:돋움;\">";	
					template2 += "				<div class=\"btnTxt2 btnSpec\" id=\"{{gpno}}\" style=\"float:left;\">조회</div>";	
					template2 += "				<div class=\"btnTxt2 btnCloseSpec\" id=\"{{gpno}}\" style=\"float:right;\">취소</div>";	
					template2 += "			</div>";	
					template2 += "		</div>";
					template2 += "	</div>";	 
					template2 += "</section>";	
					template2 += "{{/specList}}";	 
					
					
					var html = Mustache.to_html(template, result);	
					var html2 = Mustache.to_html(template2, result);	
			       
					$(".searchArea .spec").html(html);
					$("#specDiv").html(html2);
					 
			        $(".btnSpec").click(function(){			//완료
			        	
			        	var no = this.id;
 
			        	var getspecNo = getCheckedSpec();
			        	$("#sel_spec").val(getspecNo);
			        	getUnCheckCancle(no);
			        	$("#page").val('1');

						var param = getParam();
						var schWord = checkSearchInKeyword();

						if (schWord != ""){
							/*
							$.ajax({
								type: "POST",
								url: "/search/GetCountListMp3.jsp",
								data: param,
								success: function(result){ 
									eval("varCount = " + result); 
									if (varCount.count == "-1"){ 
										alert("죄송합니다.\r\n\r\n현재 검색서버의 장애로 검색이 되지 않고 있습니다.\r\n\r\n불편하시더라도 메뉴를 이용하여 주시기 바랍니다.\r\n\r\n조속히 정상화 되도록 최선을 다하겠습니다.	");	
										$("#cm_loading").hide();
									}else if (varCount.count == "0"){ 
										alert("검색결과가 없습니다.      \n다른 검색조건을 선택해 보세요.");
										$("#cm_loading").hide();
									}else{   
										CmdCloseLayerPop();
										CmdSpinLoading();
										getList('re'); 
										getCheckSpecText(no); 
									}
								}
							});	 */
							CmdCloseLayerPop();
							CmdSpinLoading();
							getList('re'); 
							getCheckSpecText(no);
							$('html, body').removeAttr('style');
							 
							ga('send', 'event', 'mf_lp', 'lp_사양선택', 'lp_사양선택 검색');
						}
						
			        });
			        $(".btnCloseSpec").click(function(){		//취소
			        	var no = this.id;
			        	getUnCheckCancle(no);
			        	getUnCheckCancle2(no);
			        	CmdCloseLayerPop();
			        	$('html, body').removeAttr('style');s
			        });
			        $(".spec_cancle").click(function(e){		//선택안함
			        	var no = this.id.replace("uncheck","");
			        	getUnCheckSpec(no);
			        	this.checked = false;
			        	CmdCloseLayerPop();
			        	$(".btnSpec").click();
			        	$('html, body').removeAttr('style');
			        });
			        $(".spec_chk").click(function(e){
			        	var thisId = this.id.replace("spec_",""); 
			        	var thisGpno = $("#gpno_"+thisId).val();
			        	getUnCheckCancle(thisGpno);
			        });
			        $('.spec_select').click(function(e){
				        var check_h = jQuery(window).height(); 
						var layer_top = jQuery(window).scrollTop(); 
			        	scrollTo(0, $("#container").position().top);
			         });
			       	$('.spec .ms-choice').click(function(){
			       		
			       		var thisId = this.id;
						tmpSpec = "";
						
						var chkBoxSpecCnt = $('#selOption'+thisId+' input:checkbox[name="spec_chk"]');
					   
					    for (var i=0;i<chkBoxSpecCnt.length;i++){
					    	if (chkBoxSpecCnt[i].checked){
								
								if(tmpSpec.length == 0){
									tmpSpec = chkBoxSpecCnt[i].id.replace("spec_","");
								}else{
									tmpSpec = tmpSpec + "," + chkBoxSpecCnt[i].id.replace("spec_","");
								}
							}
						}
						
						$(".spec_cnt").html("("+chkBoxSpecCnt.length+"개)");
										
						var _this = $(this); 
						layerPop2(_this);
						$('html, body').removeClass('dimdOn');
						var widthCheck = $(window).width(),
							heightCheck = $(window).height();
						$('html, body').css({overflow:'hidden',width:widthCheck, height:heightCheck});
						$('.select-option .layerBtn button, .select-option .btnClose').click(function(){
							$('html, body').removeAttr('style');
						});
						
						ga('send', 'event', 'mf_lp', 'lp_사양선택', 'lp_사양선택 옵션');
			       		
						return false; 
					});
					$('.layerPop .btnClose').click(function(){ 
						var thisId = this.id;
						getUnCheckCancle2(thisId);
						
						CmdCloseLayerPop();
					});
			        $(".tabSubmit").click(function() { 
			        	$("#page").val('1');
						getInCount('spec');
						$(".ms-drop").hide();
		        	});	   
				},
				complete: function(){ 
					$("#cm_loading").hide();	
				}
			});	
		}	
	
	}	
					
	function CmdCloseLayerPop(){
		$('.dimmed').remove(); 
		$('html, body').removeClass('dimdOn');
		$(".layerPop").hide();
		$('html, body').css({overflow:'auto',width:'100%', height:$("body").height()});
	} 
	 
	function sCategory(cate, name){
		var  param = getParam();
		param = param.replace("cate","cate2");
		param = param + "&cate="+cate;
		$("#chuText").html("");
		
		//CmdSpinLoading();
		$.ajax({
			type: "POST",
			url: "/mobilefirst/ajax/listAjax/getSearchCategory_ajax.jsp",
			async: false,
			data: param,
			dataType:"JSON",
			success: function(json){
				//검색목록 카테고리_전체_타이틀
				
				$(".allCateLIst .mCate").hide();
				$(".allCateLIst .sCate").html("");		 

				$(".pagingview .pagination02").hide(); 
				$(".pagingview .pagination03").show();
														
				if(searchFlag){
					name = searchFlagTitle;
				}
				var scategory_title = "";
				scategory_title += "{{#s_category_title}}";  
				scategory_title += "전체 <em class=inCate style=\"color:#0081e5;\">"+name+"</em> <span>({{length}}개 카테고리)</span>";  
				scategory_title += "{{/s_category_title}}";   
				var categoryHtml = Mustache.to_html(scategory_title, json);		
				$("#categoryAll").html(categoryHtml);	
 
				var scategory = "";
				scategory += "<ul class=\"non_chk\">"; 
				scategory += "<li class=\"prev\">이전</li>"; 
				scategory += "{{#s_category}}"; 
				//scategory += "<li><a href=\"javascript:///\"  class=\"searchCates2 pg{{pg}}\" id=\"{{code}}\"><span>{{name}}</span> <div style='color:#8c8c8c;font: 12px/1.5 '돋움',Dotum,'굴림',Gulim,Helvetica,sans-serif;'>{{cnt}}</div></a></li>";  
				scategory += "<li class=\"searchCates2 pg{{pg}}\" id=\"{{code}}\"><label>{{name}}<span>{{cnt}}</span></label></li>";
				scategory += "{{#ul}}</ul><ul class=\"non_chk\">{{/ul}}";   
				scategory += "{{/s_category}}";   
				scategory += "</ul>"; 
				var categoryHtml2 = Mustache.to_html(scategory, json);	
				$(".allCateLIst .sCate").show();
				$(".allCateLIst .sCate").html(categoryHtml2);

				var allCnt = $("#allCnt").val()-1;
				allCnt = $(".allCateLIst .sCate .searchCates2").length;
				var pageCnt = Math.ceil(allCnt / 10);
				var firstCnt = $(".allCateLIst .sCate .pg1").length;
				 
				$(".pagingview .pagination03 span").html("<strong>1</strong> /  "+commaNum(pageCnt));
					
				$('.searchCates2').click(function(){
					CmdSpinLoading(); 
					
					$(".brandSort div").html(null);
					$(".brandSort2 div").html(null);
					$("#BrandTab").text($("#brandtab").val());
					$("#factory").val("");
					$("#brand").val(""); 
					$("#shop_code").val("");
					
					$(".searchCates").css("color","#4c5363");
					$(".searchCates2").css("color","#4c5363");
					
					var thisId = this.id; 
					
					if($("#cate").val() == thisId){
						$("#cate").val("");
					}else{
						$("#"+thisId).css("color","#0081e5");		
						$("#cate").val(thisId);
					} 
					$("#page").val('1');

					getList('re');

					categoryHtmlOrg_prevTitle_Sub = $("#"+thisId+" label").html().replace("<span>","<span style='display:none;'>");

					var categorynavTitle = $("#categoryAll").html();
					///categorynavTitle = categorynavTitle.replace("<span>","<span style='display:none;'>");
					//categorynavTitle = categorynavTitle.substring(categorynavTitle.indexOf("<span style='display:none;'>"), categorynavTitle.length);
					
					if($("#s_nm").text().length > 0){
						$("#s_nm").html(categoryHtmlOrg_prevTitle_Sub);
					}else{
						$("#categoryAll").html(categorynavTitle + " > <span style='color:#0081e5;' id='s_nm'>"+categoryHtmlOrg_prevTitle_Sub+"</span>");
					}
				});	   
				$('.prev').click(function(){ 
					$("#categoryAll").html(categoryHtmlOrg_prevTitle);
					$(".allCateLIst .mCate").show();
					$(".allCateLIst .sCate").hide();
					$(".pagingview .pagination02").show();
					$(".pagingview .pagination03").hide();
					allCnt = 0;
					pageCnt = 0;
					firstCnt = 0;
				});	
				
				var pPage = 1;
				var endX = 0;
				var pageW = 0;
				var pageX2 = 0;
				var btnChk = true;
				
				$('.allCateLIst').bind('mousedown touchstart', function(e){
					btnChk = true;
				});
				$('.allCateLIst').scroll(function() { 
					setTimeout(function(){
						if(btnChk){
							CmdBrandScroll();
						}
					},100);  
					
					function CmdBrandScroll(){
						endX = $('.allCateLIst').scrollLeft();
						pageW = $('.allCateLIst .sCate ul li').width() * 2;
						pageX2 = parseInt(endX / pageW) + 1;
						
						if(pageX2 > allCnt){
						 	$(".pagingview .pagination03 span strong").html(commaNum(pPage));
						 	pPage = pageX2;
						}else{
							var pCnt = (pageX2);
							$(".pagingview .pagination03 span strong").html(commaNum(pCnt));	
							pPage = pageX2;
						} 
					} 
				});
				$(".pagination03 .pagingPrev2").click(function() { 
					if(pPage > 1){
						btnChk = false; 
						pPage = pPage - 1;
						$(".allCateLIst").scrollTo( (pPage-1) * ($('.searchCates2').width()*2) , 200 );
						var pCnt = $(".sCate .pg"+pPage).length; 
						pCnt = pPage; 
						$(".pagination03 span strong").html(commaNum(pPage));	
					} 
					if(pPage == 1){
						$(".allCateLIst").scrollTo( 0 , 200 );
					}
				}); 
				 
				$(".pagination03 .pagingNext2").click(function() { 
					if(pPage < pageCnt){
						btnChk = false;
						pPage = pPage + 1; 
						$(".allCateLIst").scrollTo( (pPage-1)* ($('.searchCates2').width()*2), 200 );
						var pCnt = $(".sCate .pg"+pPage).length;
						pCnt = pPage;
						$(".pagination03 span strong").html(commaNum(pPage));											
					}
				});											
			},
			complete: function(){ 
				$("#cm_loading").hide();	
				var cateWidth  = $('.allCateLIst').width(),
					listLength = $('.allCateLIst .sCate > ul').length,
					listWidth = $('.cateSortList .sCate > ul').width(cateWidth); 
					$('.cateSortList .sCate').width((cateWidth * listLength));
			}
		});		 
	}

	function tabCont(_this) { 
		if (_this.parent().hasClass('on')) {
			_this.parent().parent().find(' > li').removeClass('on');
		} else {
			_this.parent().parent().find(' > li').removeClass('on');
			_this.parent().addClass('on');
		}
	}


	function getOption(modelno){
		var optionCate = $("#cate").val();
		
		//if(optionCate.length > 0){
		//	optionCate = $("#cate").val();
		//}else{
			optionCate = $("#"+modelno+"_ca_code").val();
		//}
		
		$.ajax({ 
			type: "GET",
			url: "/mobilefirst/ajax/detailAjax/get_option.jsp",
			async: false,
			data: "modelno="+modelno+"&cate="+optionCate, //preview 1:5개, other:전부.
			dataType:"JSON",
			success: function(json){
				var optionObj = $("#goods"+modelno+" .enuriList");
				optionObj.html(null);		
				
				var template = "";
				template += "			<table>	";			
				template += "				<colgroup>	";			
				template += "					{{#optionUnit}}<col width=\"38%\" /><col width=\"*\" /><col width=\"38%\" />{{/optionUnit}} ";
				template += "					{{^optionUnit}}<col width=\"50%\" /><col width=\"50%\" />{{/optionUnit}} ";
				template += "				</colgroup>	";			
				template += "				<tr>	";		 	
				template += "					<th>옵션</th>	";			
				template += "					{{#optionUnit}}<th class=\"unit\">{{{optionUnit}}}</th>{{/optionUnit}}	";			
				template += "					<th>가격</th>	";			
				template += "				</tr>	";			
				template += "				{{#optionDetail}}	";
				template += "				<tr id='{{optionModelno}}' condiname=\"{{optionCondiname}}\">	";			
				template += "					<td>{{optionCondiname}}{{#optionRank}}<img src=\"http://imgenuri.enuri.gscdn.com/images/mobilefirst/rank0{{optionRank}}.png\" alt=\"{{optionRank}}위\" onerror=\"this.src='http://img.enuri.gscdn.com/images/blank.gif'\"/>{{/optionRank}}</td>	";			
				template += "					{{#optionUnit}}<td class=\"price\">{{{optionUnitprice}}}</td>{{/optionUnit}}	";			
				template += "					{{#optionRentalflag}}";
				template += "					<td class=\"min\"><span class=\"tit_rent\"></span> <em>{{optionPrice}}<em></em></em></td>	";			
				template += "					{{/optionRentalflag}}	";
				template += " 					{{^optionRentalflag}}";
				template += "					<td class=\"min\">{{#optionMinpriceflag}}최저가{{/optionMinpriceflag}}{{#optionMinpricePcflag}}<img src=\"http://imgenuri.enuri.gscdn.com/images/mobilefirst/rank_pc.png\" alt=\"pc\" class=\"pc\">{{/optionMinpricePcflag}} <em>{{optionPrice}}<em></em></em></td>	";			
				template += "					{{/optionRentalflag}}	";
				template += "				</tr>	";			 
				template += "				{{/optionDetail}}	"; 
				template += "			</table>	";	
 
				var html = Mustache.to_html(template, json);	
				
				if(html.length > 1)	
					optionObj.html(html);

				var vOption_Cnt = json.optionDetail.length ;
				var vOptionUnit = json.optionUnit ;
				var vOptionUnit_tmp = vOptionUnit.replace("*","").replace("최저가","가격").replace("(배송","<br>(배송");
				 
				$("#goods"+modelno+" .unit").html(vOptionUnit_tmp);
				
				ga('send', 'event', 'mf_lp', 'lp_option', 'lp_option_'+$("#cate").val().substring(0,4));
				
				if(vOption_Cnt > 5){ 
					$("#option_more_"+modelno).show();
					
					$("#goods"+modelno+" .enuriList tr").show();
					
					$("#goods"+modelno+" .enuriList tr").filter(":gt(5)").toggle();
					
					//$("#option_more_btn_"+modelno).text("전체보기(5/"+ vOption_Cnt +")▼");
					
					$("#option_more_"+modelno).click(function(){
						$("#goods"+modelno+" .enuriList tr").filter(':gt(5)').toggle();
						
						if($("#goods"+modelno+" .enuriList tr").filter(':gt(5)').css("display") != "none"){
							$("#option_more_"+modelno).text("접기("+ vOption_Cnt +"/"+ vOption_Cnt +")");
							$("#goods"+modelno+" .moreBtn a").addClass("on");
							if(document.URL.indexOf("list.jsp") >= 0){
								ga('send', 'event', 'mf_lp', 'lp', 'lp_option view_옵션 더보기');
							}
						}else{ 
							$("#option_more_"+modelno).text("더보기(5/"+ vOption_Cnt +")");
							$("#goods"+modelno+" .moreBtn a").removeClass("on");
						}
						
						$("body, html").animate({ scrollTop: $("#tab1").offset().top }, 300); 
					});
				}else{
					$("#option_more_"+modelno).hide();
				} 
				  
				if(vOption_Cnt > 0){
					$("#optionAll_cnt_"+ modelno).text("("+commaNum(json.optionAllmallCnt)+"개)");
				}
				$("#goods"+modelno+" .enuriList tr").click(function() { 
					var thisId = this.id;
					
					var thisInfoad = $("#"+modelno).attr("infoad");
					if(thisInfoad == "Y"){
						ga('send', 'event', 'mf_lp_Info_Ad_list', 'click_'+modelno, 'click_'+modelno);
					}
					
					
					var vInfoad = "";
					if(thisInfoad == "Y"){
						vInfoad = "&from=infoad";
					}
					
					if(document.URL.indexOf("list.jsp") >= 0){
						ga('send', 'event', 'mf_lp', 'lp', 'lp_option view_옵션');
					}
					
				    if(thisId.length > 0){
				    	if($("#"+thisId+" td span").hasClass("tit_rent")){ 
							location.href = "/mobilefirst/rental.jsp?modelno="+thisId;			
						}else{ 
							if(thisId.indexOf("_top")>-1){
								CmdDetail("/mobilefirst/detail.jsp?modelno="+thisId.replace("_top","") +"&group=1"+vInfoad);
								//location.href = "/mobilefirst/detail.jsp?modelno="+thisId.replace("_top","") +"&group=1";				
							}else{
								CmdDetail("/mobilefirst/detail.jsp?modelno="+thisId+vInfoad);
								//location.href = "/mobilefirst/detail.jsp?modelno="+thisId;
							}
						}
					}
				});
			}
		});	
	}
	//몰별
	function getMall(modelno){
		$.ajax({
			type: "GET",
			url: "/mobilefirst/ajax/detailAjax/get_list.jsp",
			data: "modelno="+modelno+"&preview=1&pagesize=10", //preview 1:5개, other:전부.
			//data: "modelno="+modelno, //preview 1:5개, other:전부.
			dataType:"JSON",
			success: function(json){  
				var mallObj = $("#goods"+modelno+" .enuriList");
				mallObj.html(null);		

				var template = " ";
				template += "			<table>	";			 
				template += "				<colgroup>	";			
				template += "					<col width=\"25%\" /><col width=\"*\" /><col width=\"43%\" /> ";
				template += "				</colgroup>	";			 
				template += "				{{#listContent}}	";
				template += "				<tr onclick=\"goShop('{{#mobileurl}}{{mobileurl}}{{/mobileurl}}','{{shopcode}}','{{plno}}','{{goodscode}}','{{instanceprice}}','{{category}}','{{price}}','{{minprice}}',this, "+modelno+");\">	";			
				template += "					<td class=\"mall\">{{shopname}}{{#shop_bid}}<span class=\"spon\">스폰서</span>{{/shop_bid}}</td>	";			
				template += "					<td class=\"price\">{{displaydelivery}}</td>";			
				template += "					<td class=\"min{{#shop_bid}} spontxt{{/shop_bid}}\">{{#mpriceflag}}{{#shop_bid}}<span>{{/shop_bid}}최저가{{#shop_bid}}</span>{{/shop_bid}}{{/mpriceflag}} <em>{{price}} 원<em></em></em></td>	";			
				template += "				</tr>	";			
				template += "				{{/listContent}}	"; 
				template += "			</table>	";	 

				var html = Mustache.to_html(template, json);
				  
				if(html.length > 1){
					mallObj.html(html);	
					
					if(navigator.userAgent.indexOf("AppleWebKit/")>-1 && navigator.userAgent.indexOf("AppleWebKit/6") < 0){
					//	$(".delivery").css("width","24%");
					}

					$(".mall").each(function(){
						if($.trim($(this).text()) == 'PC 최저가'){
							$(this).css("color","#8c8c8c");
							
							$(this).parent().children(".delivery").hide();
							
							$(this).parent().children(".min").css("color","#83a8d7");
							
							var min_tmp = $(this).parent().children(".min").text().replace(" 원 원"," 원");
							$(this).parent().children(".min").html("<em>"+min_tmp+"</em>");
				        }
					});
					 
					//5개 이상 가지고 오면 하단 더보기 바 생성.
					if(json.listContent.length > 5){
					
						$("#goods"+modelno+" .enuriList tr").show();
						
						$("#goods"+modelno+" .enuriList tr").filter(":gt(4)").toggle();
						
						var vMallcnt = $("#goods"+ modelno +"_mallcnt").text().replace("업체 ","");
						$("#option_more_"+modelno).text("더보기");
						//mallObj.append("<div class=\"list_mall_end_bar\" id=\"more_"+modelno+"\"><span  id=\"moretxt_"+modelno+"\">더보기 ▼</span><span style=\"position:absolute; right:10px; top:0\" id=\"allview_"+modelno+"\" modelno=\""+modelno+"\">전체보기<span style=\"color:#8a909e;;font-size:10px;\">("+vMallcnt+")  </span>&gt;</span></div>");
						
						$("#option_more_"+modelno).click(function(){
							//$("#list_select").removeClass("listOpen");
							$("#goods"+modelno+" .enuriList tr").filter(':gt(4)').toggle();
							
							if($("#goods"+modelno+" .enuriList tr").filter(':gt(4)').css("display") != "none"){
								$("#option_more_"+modelno).text("접기");
								$("#goods"+modelno+" .moreBtn a").addClass("on");
								if(document.URL.indexOf("list.jsp") >= 0){
									ga('send', 'event', 'mf_lp', 'lp', 'lp_option view_쇼핑몰 더보기');
								} 
							}else{
								$("#option_more_"+modelno).text("더보기");
								$("#goods"+modelno+" .moreBtn a").removeClass("on");
							}
							
							$("body, html").animate({ scrollTop: $("#tab1").offset().top }, 300); 
						});
						   
						$("#allview_"+modelno).click(function(){
							var thisId = $("#allview_"+modelno).attr("modelno");
							
							var thisInfoad = $("#"+modelno).attr("infoad");
							var vInfoad = "";
							if(thisInfoad == "Y"){
								vInfoad = "&from=infoad";
							}
							
							CmdDetail("/mobilefirst/detail.jsp?modelno="+thisId+"&group=1"+vInfoad);
							//location.href = "/mobilefirst/detail.jsp?modelno="+thisId+"&group=1";
							
							return false;
						});
					}else{
						$("#option_more_"+modelno).hide();
					}
				} 
				$("#goods"+modelno+" .enuriList td").click(function() { 
					if(document.URL.indexOf("list.jsp") >= 0){
						ga('send', 'event', 'mf_lp', 'lp', 'lp_option view_쇼핑몰');
					}	 
					var thisId = this.id;
					//location.href = "/mobilefirst/detail.jsp?modelno="+modelno+"&groupno="+modelno+"&tab=1";
				});
			}

		}); 
	}
	
 
	
	function getParam(){
		var sponChk = "";
		
		param  = "";
		if ($("#cate").length){
			if($("#cate").val().length > 2){
				if($("#cate").val().substring($("#cate").val().length-2, $("#cate").val().length) == "99"){
				   $("#cate").val($("#cate").val().substring(0, $("#cate").val().length-2)+"00");
				}
			}  
			if ($("#cate").val().trim().length > 0 ){
				if ($("#from").val() == "search" && $("#sub_cate").length){ 
					param += "&cate="+$("#cate").val().trim()+$("#sub_cate").val();
				}else{
					param += "&cate="+$("#cate").val().trim();
				}
			}
		}	  
		if ($("#sub_cate").length){ 
			if ($("#sub_cate").val().trim().length > 0 && $("#from").val() != "search" ){
				param += "&sub_cate="+$("#sub_cate").val();
			}
		}
		 
		if($("#factory").length){
			if ($("#factory").val().trim().length > 0 ){
				param += "&factory="+$("#factory").val().replace(/&/gi,"%26")
				sponChk = "Y";
			}
		}	 
		if($("#brand").length){
			if ($("#brand").val().trim().length > 0 ){
				param += "&brand="+$("#brand").val().replace(/&/gi,"%26")
				sponChk = "Y";
			}
		}	 
		if ($("#shop_code").length){ 
			if ($("#shop_code").val().trim().length > 0 ){
				param += "&shop_code="+$("#shop_code").val();
				sponChk = "Y";	
			}
		}
		if ($("#start_price").length && $("#end_price").length ){
			//if($("#start_price").val() != "0" && $("#end_price").val() != "0"){
				if ($("#start_price").val().trim().length > 0 ){
					param += "&start_price="+$("#start_price").val().replace(/,/gi,"");
					sponChk = "Y";
				}
				if ($("#end_price").val().trim().length > 0 ){
					param += "&end_price="+$("#end_price").val().replace(/,/gi,"");
					sponChk = "Y"; 
				}
			//} 
		}
		if ($("#m_price").length){ 
			if ($("#m_price").val().trim().length > 0 ){
				param += "&m_price="+$("#m_price").val();
				sponChk = "Y";
			}
		}
		if ($("#sel_spec").length){ 
			if ($("#sel_spec").val().trim().length > 0 ){
				param += "&spec=y&sel_spec="+$("#sel_spec").val();
				if($("#sel_spec").val().substring($("#sel_spec").length-1, $("#sel_spec").length) != ","){
					param  += ",";
				}
				if(param.indexOf(",,") > 0){
					param = param.replace(",,",",");
				//	param = param..replace(/,,/gi,",")
				}
				sponChk = "Y";
			} 
		}
		if ($("#key").length){ 
			if ($("#key").val().trim().length > 0 ){
				param += "&key="+$("#key").val();
			}
		}
		if ($("#page").length){ 
			if ($("#page").val().trim().length > 0 ){
				param += "&page="+$("#page").val();
			}
		}
		if ($("#srhRe").length){ 
			if ($("#srhRe").val().trim().length > 0 ){
		//		param += "&in_keyword="+$("#srhRe").val();
			}
		}
		if ($("#inkeyword").length){  
			if ($("#inkeyword").val().trim().length > 0 ){
				param += "&in_keyword="+encodeURIComponent(schKeyword($("#inkeyword").val()));
				var keywordTmp = schKeyword($("#inkeyword").val());
				$("#srhRe").val(keywordTmp);
			}
		} 
		if ($("#all_keyword").length){ 
			if($("#rekeyword").val().length > 0){
				param += "&keyword="+$("#rekeyword").val();
			}else if ($("#all_keyword").val().trim().length > 0 ){
				param += "&keyword="+$("#all_keyword").val();
			}
		}
		if(document.URL.indexOf("list.jsp") >= 0 && $("#from").val() != "search"){
			var varInKeyWord = false;
			var varPrevSearchKeyword = ""; 
			if ($("#srhRe").length){
				if ($("#srhRe").val().trim().length > 0 ){
					param += "&keyword="+encodeURIComponent(varPrevSearchKeyword + schKeyword($("#srhRe").val()));
					varInKeyWord = true;
					sponChk = "Y";
				}
			}
			if (!varInKeyWord && varPrevSearchKeyword.trim().length > 0){
				param += "&keyword="+varPrevSearchKeyword.trim();
				sponChk = "Y";
			}
		}else{
			if ($("#srhRe").length){
				if ($("#srhRe").val().trim().length > 0 ){
					param += "&in_keyword="+encodeURIComponent(schKeyword($("#srhRe").val().trim()));
					if($("#from").val() == "search"){
						if($("#rekeyword").val().length > 0){
							param += "&keyword="+schKeyword($("#rekeyword").val().trim());
						}else{
							param += "&keyword="+schKeyword($("#srhRe").val().trim());
						}
					}  
					sponChk = "Y";
					var keywordTmp2 = schKeyword($("#srhRe").val());
					$("#srhRe").val(keywordTmp2);
				} 
			}			
		}		
		if ($("#grid").length){ 
			if ($("#grid").val().trim().length > 0 ){
				param += "&grid="+$("#grid").val();
			}
		}
		if ($("#allopen").length){ 
			if ($("#allopen").val().trim().length > 0 ){
				param += "&allopen="+$("#allopen").val();
			}
		}  
		if(param.substring(0,1) == "&"){
			param = param.substring(1,param.length);
		} 
		if(sponChk.length){  
			if (sponChk.length > 0 ){
				param += "&sponChk="+sponChk;
			} 
		}		
		//alert(param);
		return param; 		
	}
	
	function getInCount(type){
		$("#page").val('1');
		var param = getParam();
		param = param + "&fromMo=Y";
		var schWord = checkSearchInKeyword();
		var vUrl = "/search/GetCountListMp3.jsp";
		if($("#cate").val().substring(0,4) == "1471" || $("#cate").val().substring(0,4) == "1472" || $("#cate").val().substring(0,4) == "1473"){
			vUrl = "/search/GetCountListClothes.jsp";
		}
		
		if (schWord != ""){
			/*
			$.ajax({
				type: "POST",
				url: vUrl, 
				data: param, 
				success: function(result){ 
					eval("varCount = " + result); 
					if (varCount.count == "-1"){ 
						alert("죄송합니다.\r\n\r\n현재 검색서버의 장애로 검색이 되지 않고 있습니다.\r\n\r\n불편하시더라도 메뉴를 이용하여 주시기 바랍니다.\r\n\r\n조속히 정상화 되도록 최선을 다하겠습니다.	");	
						$("#cm_loading").hide();
					}else if (varCount.count == "0"){
						//alert("검색결과가 없습니다.      \n \n붙은 단어를 띄어 써서 검색해 보세요. \n다른 검색조건을 선택해 보세요.");
						$(".searchNone").show();
						$(".prodList").hide();
						$(".prodSortOpt").hide();
						$("#cm_loading").hide();
					}else{   
						//location.href = "list.jsp?" + param;
						getList('re');
					}
				}
			});*/
			getList('re');	
		}
	}
	function checkSearchInKeyword(){
		var schWord = $("#srhRe").val().trim();
		var schLen = schWord.length;
		
		schWord = schWord.trim();
		
		//if ($("#srhPrice").val() == "" || $("#srhPrice2").val() == ""){
		//	alert("가격대 정보를 확인해주세요.");
		//}else if( (schLen == 1 && $("#srhRe").val().trim().length == 1 ) ){
		//alert(exptionKeyWord)
		if( (schLen == 1 && $("#srhRe").val().trim().length == 1 ) && exptionKeyWord.indexOf(schWord) < 0 ){
			if ($("#srhPrice").val() != "" && $("#srhPrice2").val() != "" && schLen == 1){
				alert("2자 이상의 검색어를 넣으세요.\t\t\r\n\특수문자는 제외 됩니다.");
				$("#cm_loading").hide();
			}else if (!(schLen == 1 && varExpKeyWord.indexOf(schWord) >= 0 ) ){
				alert("2자 이상의 검색어를 넣으세요.\t\t\r\n\특수문자는 제외 됩니다.");
				$("#cm_loading").hide();
			}
			$("#srhRe").val("")
			$("#srhRe").focus();
			schWord = "";
		}else{ 
			//schWord = schKeyword($("#keyword").val().trim()+" "+$("#srhRe").val().trim());
			schWord = schKeyword($("#keyword").val()+" "+$("#srhRe").val());
			if(schWord == ""){
				schWord = "Y";
			}
		}

		return schWord; 
	} 

	function getCount(){
		$("#page").val('1');
		var  param = getParam();
		var  schWord = checkSearchInKeyword();
		param = param + "&search_area=1111&fromMo=Y";
		
		if (schWord != ""){
			/*
			$.ajax({
				type: "POST",
				url: "/search/GetCountListSearch.jsp",
				data: param, 
				success: function(result){ 
					eval("varCount = " + result);
					if (varCount.count == "-1"){
						alert("죄송합니다.\r\n\r\n현재 검색서버의 장애로 검색이 되지 않고 있습니다.\r\n\r\n불편하시더라도 메뉴를 이용하여 주시기 바랍니다.\r\n\r\n조속히 정상화 되도록 최선을 다하겠습니다.	");	
						$("#cm_loading").hide();
					}else if (varCount.count == "0"){
						//alert("검색결과가 없습니다.      \n \n붙은 단어를 띄어 써서 검색해 보세요. \n다른 검색조건을 선택해 보세요.");
						$(".searchNone").show();
						$(".prodList").hide();
						$(".prodSortOpt").hide();
						$("#cm_loading").hide();
					}else{
						getList();
					}
				} 
			});		
			*/
			getList();
		}
	}
	function CmdDetail(param){
		var ed_param = "";
		var vAppyn = getCookie("appYN"); 
		var vCate = $("#cate").val();
		var vSearch = $("#auto_keyword").val();
		
		//if(vAppyn == "Y"){
			if(document.URL.indexOf("search.jsp") > -1 || $("#from").val()=="search"){		//search
				ed_param = "&ep=2&ek="+vSearch;
			}else{																													//list
				ed_param = "&ep=1&ek="+vCate;
			}  
			//alert(param+ed_param);
			location.href = param+ed_param; 
		//}else{
		//	location.href = param;
		//}
	}
	
	function schKeyword(schWrd){
		var schWord; 
		schWord = schWrd;

	    schWord = replace2(schWord,"'");
	    schWord = replace2(schWord,"\\");
	    schWord = replace2(schWord,"^");
	    schWord = replace2(schWord,"~");
	    schWord = replace2(schWord,"!");
	    schWord = replace2(schWord,"@");
	    schWord = replace2(schWord,"$");
	    schWord = replace2(schWord,"%");
	    schWord = replace2(schWord,"*");
	    schWord = replace2(schWord,"+");
	    schWord = replace2(schWord,"=");
	    schWord = replace2(schWord,"\\");
	    schWord = replace2(schWord,"{");
	    schWord = replace2(schWord,"}");
	    schWord = replace2(schWord,"[");
	    schWord = replace2(schWord,"]");
	    schWord = replace2(schWord,";");
	    schWord = replace2(schWord,"/");
	    schWord = replace2(schWord,"<");
	    schWord = replace2(schWord,">");
	    schWord = replace2(schWord,",");
	    schWord = replace2(schWord,"?");
	    schWord = replace2(schWord,"(");
	    schWord = replace2(schWord,")");
	    schWord = replace2(schWord,"'");
	    schWord = replace2(schWord,"_");
	    schWord = replace2(schWord,"-");
	    schWord = replace2(schWord,"`");
	    schWord = replace2(schWord,"|");
	    schWord = replace2(schWord,"\"");
    	
	    schWord = jQuery.trim(schWord);
	        		
		function replace2(src, delWrd){
			var newSrc = "";
			for(var i=0;i<src.length;i++){
				if(src.charAt(i) == delWrd) {
					newSrc = newSrc + " ";
				}else{
					newSrc = newSrc + src.charAt(i);
				}			
			}
			return newSrc;
		}	    
		
	    return schWord;
	} 
	
	function enterChk(e){
		var keycode;
		if(typeof(e) != "undefined"){
			if (typeof(e.which) != "undefined"){
				keycode = e.which;
			}else{ 
				keycode = e.keyCode;
			}
		}else{
			keycode = event.keyCode;
		}
		if (!((keycode >= 48 && keycode <= 57) || (keycode >= 96 && keycode <= 105) || keycode == 8 || keycode == 9 ||  keycode == 46 || keycode == 13 || (keycode >= 37 && keycode <= 40))){
			if(!e) var e = window.event;
			e.cancelBubble = true;
			e.returnValue = false;
			if (e.stopPropagation) {
				e.stopPropagation();
				e.preventDefault();
			}
		}
		if (keycode == 13 ){ 
			directPriceSearch();
		}
	}
	function getUnCheckSpec(param){
		var chkBoxSpec = $('#selOption'+param+' input:checkbox[name="spec_chk"]');
		
		chkBoxSpec.each(function(){
			if(this.checked){
				this.checked = false;
			}
		});
	}
	function getUnCheckCancle(no){
    	var chkBoxSpec = $('#selOption'+no+' input:checkbox[name="spec_cancle"]');

		chkBoxSpec.each(function(){
			if(this.checked){
				this.checked = false;
			}
		}); 
		//$("#selOptionText"+no).text("속성선택");  
	}
	function getCheckedSpec(){
	    var varPrecgpno = "";
	    var varPrecgpsno = "";
	    var varSelectedSpec = "";
	    
	    var chkBoxSpec = $('input:checkbox[name="spec_chk"]');
	    
	    for (var i=0;i<chkBoxSpec.length;i++){
	    	if (chkBoxSpec[i].checked){
	            var varSpecNo = chkBoxSpec[i].id.replace("spec_","");
	            var varGpno = $("#gpno_"+varSpecNo).val();
	            var varGpsno = $("#gpsno_"+varSpecNo).val();
	            var varGpno_Aoflag = $("#gpno_aoflag_"+varSpecNo).val();
	            var varGpsno_Aoflag = $("#gpsno_aoflag_"+varSpecNo).val();
	            if ( varGpno_Aoflag == "0"){
	                if (varPrecgpno.length > 0 && varGpno != varPrecgpno){
	                    varSelectedSpec = varSelectedSpec + "_";
	                }
	                varSelectedSpec = varSelectedSpec + varSpecNo + ",";
	                varPrecgpno = varGpno;
	            }else if (varGpno_Aoflag == "1"){
	                if (varGpsno_Aoflag == "0"){
	                    if (varPrecgpno.length > 0 && varGpno != varPrecgpno){
	                        varSelectedSpec = varSelectedSpec + "_";
	                    }else{                        
	                        if (varPrecgpsno.length > 0 && varGpsno != varPrecgpsno){
	                            varSelectedSpec = varSelectedSpec + "_";
	                        }
	                    }
	                    varSelectedSpec = varSelectedSpec + varSpecNo + ",";
	                }else if (varGpsno_Aoflag == "1"){
	                    if (varPrecgpno.length > 0 ){
	                        varSelectedSpec = varSelectedSpec + "_";
	                    }
	                    varSelectedSpec = varSelectedSpec + varSpecNo + ",";
	                }
	                varPrecgpno = varGpno;
	                varPrecgpsno = varGpsno; 
	            }
	        }
	    }
	    //alert(varSelectedSpec)
	    return varSelectedSpec;
	} 
	
	function getCheckSpecText(no){
		var chkBoxSpec = $('#selOption'+no+' input:checkbox[name="spec_chk"]');
	    var thisText = "";
	    
	    for (var i=0;i<chkBoxSpec.length;i++){
	    	if (chkBoxSpec[i].checked){
	    		var specno = chkBoxSpec[i].id.replace("spec_","");
	    		if(thisText.length < 1){ 
		    		thisText = $("#spec_li_"+specno).text();
	    		}else{
	    			thisText = thisText + "," +$("#spec_li_"+specno).text();
	    		}
	    	}
	    }
	    if(thisText.length > 0){
	  		$("#selOptionText"+no).text(thisText);  
	    }else{
	    	$("#selOptionText"+no).text("속성선택");  
	    }	
	}
	
	function getUnCheckCancle2(no){
		var chkBoxSpec = $('#selOption'+no+' input:checkbox[name="spec_chk"]');

		chkBoxSpec.each(function(){
			if(this.checked){
				this.checked = false; 
			}
		}); 
		
		//$("#selOptionText"+no).text("속성선택");  
	
		var arrSpec = tmpSpec.split(",");
		for( var ispec = 0 ; ispec < arrSpec.length ; ispec++){
			$("#spec_"+arrSpec[ispec]).click(); 
		}  	
	}

	function CmdTab(param){
		//$("#category_nav").hide();
	   
		if($(".brandSort div").is(":visible") && document.URL.indexOf("list.jsp") >= 0){
			insertLog('11020');
		}

	//if ($("#tab1 .brandSort div").html().length == 0 ){

	if(param.length > 0 || $("#tab1 .brandSort div").html().length == 0){
		
		CmdSpinLoading();

		var vParam = getParam();
		var vParam2 = "&mobile2=first&tTy=factory&factory_sort="+factory_sort;
		
		if($("#BrandTab").text() == "쇼핑몰"){
			vParam2 = "&mobile2=first&tTy=shop";
		}

		$.ajax({
			type: "GET",
			url: "/search/getTabLayer.jsp", 
			//async: true, 
			//data: "cate="+cate+"&&key=popular+DESC&mobile2=first&tTy=factory",
			data: vParam + vParam2,
			dataType:"JSON",
			success: function(result){	  
				$("#tab1 .brandSort div").html(null);
				var template = "";   
				template += "<ul>{{#factoryList}}"; 
				template += "<li class=\"pg{{factoryGroup}}\"><label><input class=\"chkbox\" name=\"f_chk\" id=\"{{factoryId}}\" type=\"checkbox\" {{#factoryChk}}{{factoryChk}}{{/factoryChk}}>{{factoryName}} {{#factoryName2}}<br>{{factoryName2}}{{/factoryName2}}<span> ({{factoryCnt}})</span>";
				template += "{{#factoryHot}}<img src=\"http://imgenuri.enuri.gscdn.com/images/mobilefirst/rank0{{factoryHot}}.png\" alt=\"{{factoryHot}}위\" class=\"rank\">{{/factoryHot}}";
				template += "<label></li>";
				template += "{{#factoryNext}}</ul><ul>{{/factoryNext}}";
				template += "{{/factoryList}}";
				template += "</ul>"; 
				template += "{{#factoryNav}}";
				template += "<input type=\"hidden\" id=\"allCnt\" value=\"{{allCnt}}\" >";
				template += "<input type=\"hidden\" id=\"pageCnt\" value=\"{{pageCnt}}\" >";
				template += "{{/factoryNav}}";
											  
				var html = Mustache.to_html(template, result);			
				$("#tab1 .brandSort div").html(html);	
				
				var allCnt = $("#tab1 #allCnt").val(); 
				allCnt = Math.ceil($("#tab1 .brandSort li").length / 10);
				var pageCnt = $("#tab1 #pageCnt").val();
				var firstCnt = $("#tab1 .brandSort .pg1").length;
				
				$("#tab1 .pagingview .pagination01 span").html("<strong>1</strong> /  "+commaNum(allCnt));
				
				var pPage = 1;
				
				var varResearchKeyword = "";
				var x = 0;
				
				var endX = 0;
				var pageW = 0;
				var pageX2 = 0;
				var btnChk = true;
				
				$('#tab1 .brandSort').bind('mousedown touchstart', function(e){
					btnChk = true;
				});
				$('#tab1 .brandSort').scroll(function() { 
					setTimeout(function(){
						if(btnChk){
							CmdBrandScroll();
						}
					},100);  
					function CmdBrandScroll(){
						endX = $('#tab1 .brandSort').scrollLeft();
						pageW = $('#tab1 .brandSort ul').width();
						pageX2 = parseInt(endX / pageW) + 1;
						//alert(endX + " , "+pageW + " , "+pageX2);
						if(pageX2 > allCnt){
						 	$("#tab1 .pagination01 span strong").html(commaNum(allCnt));
						 	pPage = pageX2;
						}else{
							$("#tab1 .pagination01 span strong").html(commaNum(pPage));	
							pPage = pageX2;
						}
					}
				});
				$("#tab1 .pagingPrev2").click(function() { 
					if(pPage > 1){
						btnChk = false;
						pPage = pPage - 1;
						$("#tab1 .brandSort").scrollTo( (pPage-1) * $('#tab1 .brandSort').width(), 200 );
						$("#tab1 .pagination01 span strong").html(commaNum(pPage));	
					} 
					if(pPage == 1){
						$("#tab1 .brandSort").scrollTo( 0 , 200 );
					}
				}); 
				$("#tab1 .pagingNext2").click(function() { 
					if(pPage < pageCnt){
						btnChk = false;
						$("#tab1 .brandSort").scrollTo( pPage*$('#tab1 .brandSort').width(), 200 );
						pPage = pPage + 1;
						$("#tab1 .pagination01 span strong").html(commaNum(pPage));											
					}
				});
				
				$("#tab1 .chkbox").click(function() { 
					if($("#cm_loading").is(":visible")){
						return false;
					}else{
						CmdSpinLoading();
						if($("#factory").val().length > 0){
							varResearchKeyword = $("#factory").val();
						}
						
						if(this.checked){
							this.checked = true;
							if(varResearchKeyword.length == 0){
								varResearchKeyword += this.id; 
							}else{
								varResearchKeyword +=  "," + this.id; 
							}
						}else{
							this.checked = false;
							varResearchKeyword = varResearchKeyword.replace(this.id, "").replace(",,", ",");
						} 
						if(varResearchKeyword.length > 1){
							if(varResearchKeyword.substring(0,1) == ","){
								varResearchKeyword = varResearchKeyword.substring(1,varResearchKeyword.length);
							}
						}
						if(varResearchKeyword == ","){
							varResearchKeyword = "";
						}
					
						
						var tmpFactory = varResearchKeyword;
						if($("#BrandTab").text() == "쇼핑몰"){
							$("#shop_code").val(tmpFactory)
						}else{ 
							$("#factory").val(tmpFactory);
						}
						$("#page").val('1'); 
						
						$(".brandSort2 div").html("");
						
						getList();
						
						if(document.URL.indexOf("list.jsp") >= 0){
							ga('send', 'event', 'mf_lp', 'lp_제조사', 'lp_제조사선택');
						}
						if(document.URL.indexOf("search.jsp") >= 0){
							ga('send', 'event', 'mf_srp', 'srp_shop', 'srp_shop');
						}
					}
				}); 
			},
			complete: function(){ 
				$("#cm_loading").hide();	
				var brandWidth = $('#tab1 .brandSort').width(),
					brandListLength = $('#tab1 .brandSort > div > ul').length,
					brandListWidth = $('#tab1 .brandSort > div > ul').width(brandWidth);
				$('#tab1 .brandSort > div').width((brandWidth * brandListLength));	
				$("#tab1 .brandSort").scrollTo( 0, 200 );
			}
		});
	}    
}
function CmdTab2(param){

	//$("#category_nav").hide();
	//if($(".brandSort div").is(":visible") && document.URL.indexOf("list.jsp") >= 0){
	//	insertLog('11020');
	//} 

	//if ($(".brandSort2 div").html().length == 0 ){
	if(param.length > 0 || $(".brandSort2 div").html().length == 0 ){

		CmdSpinLoading();

		var vParam = getParam();
		var vParam2 = "&mobile2=first&tTy=brand&brand_sort="+brand_sort;
        
        console.log(vParam+vParam2);
        
		$.ajax({
			type: "GET",
			url: "/search/getTabLayer.jsp", 
			//async: true, 
			//data: "cate="+cate+"&&key=popular+DESC&mobile2=first&tTy=factory",
			data: vParam + vParam2,
			dataType:"JSON",
			success: function(result){	  
			     console.log("result :"+result);
				$(".brandSort2 div").html(null);
				var template = "";   
				template += "<ul>{{#brandList}}"; 
				template += "<li class=\"pg{{brandGroup}}\"><label><input class=\"chkbox\" name=\"b_chk\" id=\"{{brandId}}\" type=\"checkbox\" {{#brandChk}}{{brandChk}}{{/brandChk}}>{{brandName}} {{#brandName2}}<br>{{brandName2}}{{/brandName2}}<span> ({{brandCnt}})</span>";
				template += "{{#brandHot}}<img src=\"http://imgenuri.enuri.gscdn.com/images/mobilefirst/rank0{{brandHot}}.png\" alt=\"{{brandHot}}위\" class=\"rank\">{{/brandHot}}";
				template += "<label></li>";
				template += "{{#brandNext}}</ul><ul>{{/brandNext}}";
				template += "{{/brandList}}";
				template += "</ul>"; 
				template += "{{#brandNav}}";
				template += "<input type=\"hidden\" id=\"allCnt\" value=\"{{allCnt}}\" >";
				template += "<input type=\"hidden\" id=\"pageCnt\" value=\"{{pageCnt}}\" >";
				template += "{{/brandNav}}";
											  
				var html = Mustache.to_html(template, result);			
				$("#tab4 .brandSort2 div").html(html);	
				
				var allCnt = $("#tab4 #allCnt").val(); 
				allCnt = Math.ceil($("#tab4 .brandSort2 li").length / 10);
				var pageCnt = $("#tab4 #pageCnt").val();
				var firstCnt = $("#tab4 .brandSort2 .pg1").length;
				
				$("#tab4 .pagingview .pagination01 span").html("<strong>1</strong> /  "+commaNum(allCnt));

				var pPage = 1;
				
				var varResearchKeyword2 = "";
				var x = 0;
				 
				var endX = 0;
				var pageW = 0;
				var pageX2 = 0;
				var btnChk = true;
				
				$('#tab4 .brandSort2').bind('mousedown touchstart', function(e){
					btnChk = true;
				});
				$('#tab4 .brandSort2').scroll(function() { 
					setTimeout(function(){
						if(btnChk){
							CmdBrandScroll();
						}
					},100);  
					function CmdBrandScroll(){
						endX = $('#tab4 .brandSort2').scrollLeft();
						pageW = $('#tab4 .brandSort2 ul').width();
						pageX2 = parseInt(endX / pageW) + 1;
						//alert(endX + " , "+pageW + " , "+pageX2);
						if(pageX2 > allCnt){
						 	$("#tab4 .pagination01 span strong").html(commaNum(allCnt));
						 	pPage = pageX2;
						}else{
							$("#tab4 .pagination01 span strong").html(commaNum(pPage));	
							pPage = pageX2;
						}
					}
				}); 
				$("#tab4 .pagingPrev2").click(function() { 
					if(pPage > 1){
						btnChk = false;
						pPage = pPage - 1;
						$("#tab4 .brandSort2").scrollTo( (pPage-1) * $('#tab4 .brandSort2').width(), 200 );
						$("#tab4 .pagination01 span strong").html(commaNum(pPage));	
					} 
					if(pPage == 1){
						$("#tab4 .brandSort2").scrollTo( 0 , 200 );
					}
				}); 
				$("#tab4 .pagingNext2").click(function() { 
					if(pPage < pageCnt){
						btnChk = false;
						$("#tab4 .brandSort2").scrollTo( pPage*$('#tab4 .brandSort2').width(), 200 );
						pPage = pPage + 1;
						$("#tab4 .pagination01 span strong").html(commaNum(pPage));											
					}
				});
				
				$("#tab4 .chkbox").click(function() { 
					if($("#cm_loading").is(":visible")){
						return false;
					}else{
						CmdSpinLoading();
						if($("#brand").val().length > 0){
							varResearchKeyword2 = $("#brand").val();
						}
						
						if(this.checked){
							this.checked = true;
							if(varResearchKeyword2.length == 0){
								varResearchKeyword2 += this.id; 
							}else{
								varResearchKeyword2 +=  "," + this.id; 
							}
						}else{
							this.checked = false;
							varResearchKeyword2 = varResearchKeyword2.replace(this.id, "").replace(",,", ",");
						} 
						if(varResearchKeyword2.length > 1){
							if(varResearchKeyword2.substring(0,1) == ","){
								varResearchKeyword2 = varResearchKeyword2.substring(1,varResearchKeyword2.length);
							}
						}
						if(varResearchKeyword2 == ","){
							varResearchKeyword2 = "";
						}
					
						$(".brandSort div").html("");
						
						var tmpBrand = varResearchKeyword2;
						$("#brand").val(tmpBrand);

						$("#page").val('1'); 
						
						getList();
						
						ga('send', 'event', 'mf_lp', 'lp_브랜드', 'lp_브랜드선택');
					
					}
				}); 
			}, 
			complete: function(){ 
				$("#cm_loading").hide();	
				var brandWidth2 = $('#tab4 .brandSort2').width(),
					brandListLength2 = $('#tab4 .brandSort2 > div > ul').length,
					brandListWidth2 = $('#tab4 .brandSort2 > div > ul').width(brandWidth2);
				$('#tab4 .brandSort2 > div').width((brandWidth2 * brandListLength2));	
				$("#tab4 .brandSort2").scrollTo( 0, 200 );
			}
		});
	}
}   
}); 
 
