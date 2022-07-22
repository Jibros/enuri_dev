var IMG_ENURI_COM = "http://img.enuri.info";
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

if(document.URL.indexOf("list.jsp") >= 0){
	varPage = "/mobilefirst/ajax/listAjax/getList_ajax.jsp";
}

function CmdBtnChu(){
	if($("#chkCategory").is(":visible")){
		$("#chuText").hide();
	}else{
		$("#chuText").show();
	}
	$(".sortSelect .cateSort > li > button").css("color","");
}	
function CmdErrImg(param, img){
	$("#img_"+param).error(function(){
		$(this).attr("src","http://photo3.enuri.com/data/working.gif");
	}).attr("src", img);
} 

$(function() {
	
	$("#cate_owl li a").click(function(){
		var cate = $(this).attr("id");
		var cateName = $(this).text(); 
		
		ga('send', 'event', 'mf_best', 'click', 'best_'+cateName);
		
		$("#cate_owl li a").removeClass();
		
		$("#cate").val(cate);
		
		CmdSpinLoading();
		getList();
		
		$(this).addClass("on");
		
		$("#btnAllOpen").removeClass("btnIcon btnAllOpen on")
				.addClass("btnAllOpen")
				.addClass("btnIcon");
		
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
	$(".prodSortOpt select").change(function() {
		var varSelect = $(this).val();
		$("#key").val(varSelect);
		$("#page").val('1');
		//location.href = varPage2+"?"+getParam();
		getList('re');
	});
	$(".sortBtn .btnType1:nth-of-type(1)").click(function() {  //초기화
		CmdSpinLoading();
		var id = this.parentNode.id; 

		if(id == "detail_b"){
			var tmpMin = $("#org_start_price").val();
			var tmpMax = $("#org_end_price").val();
			$("#srhPrice").val(tmpMin);
			$("#srhPrice2").val(tmpMax); 
			
			var tmpInkeyword = $("#inkeyword").val(); 
			$("#srhRe").val(tmpInkeyword);
			getList('re');
		}else if(id == "brand_b"){
			$('input:checkbox[name="f_chk"]').each(function(){
				if(this.checked){
					this.checked = false;
				}
			});
			$("#factory").val("");
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
			getList('a');
		}
	});
	$(".sortBtn .btnType1:nth-of-type(2)").click(function() {  //완료
		var _this = $(this);
		var id = this.parentNode.id; 
		
		if(id == "brand_b"){
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

		if(id == "category_b"){
			searchCategoryTitle = "";
			
			var varChu = $("#chuText").html();
			var varAll = $("#categoryAll").html();
			
			if(varChu.length > 0 ){
				searchCategoryTitle = "<b>추천 카테고리</b> > <span style=\"color:#0081e5;\">"+varChu+"</span>";
			}else if(varAll.length > 35){
				if(categoryHtmlOrg_prevTitle_Sub.length > 0 ){
					searchCategoryTitle = varAll.replace("전체","<b>전체</b> > ") + " > <span style='color:#0081e5;'>"+categoryHtmlOrg_prevTitle_Sub+"</span>";
					searchCategoryTitle = searchCategoryTitle.replace("<span>","<span style='display:none;'>");
				}
			}
			if(searchCategoryTitle.length > 0){
				$("#category_nav").html(searchCategoryTitle);
				$("#category_nav").show();
			}
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
	});
	//바둑판 --> 리스트 전환
	$(".btnList").click(function() { 
		$("#grid").val('');
		$("#allopen").val('');
	});
	//리스트  --> 바둑판 전환
	$(".btnGrid").click(function() { 
		$("#grid").val('y');
		$("#allopen").val('');
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
	$(".pagingNext").click(function() { 
		var page = $("#page").val();

		if(eval(page) * 20 > eval(allcnt.replace(',','')) ){
			//alert('end page');
		}else{
			$("#page").val(eval(page)+1);
			getList('re');
			scrollTo(0,0);
			//location.href = varPage2+"?"+getParam();
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
					searchCategoryTitle = varAll.replace("전체","<b>전체</b> > ") + " > <span style='color:#0081e5;'>"+categoryHtmlOrg_prevTitle_Sub+"</span>";
					searchCategoryTitle = searchCategoryTitle.replace("<span>","<span style='display:none;'>");
				}
			}
			if(searchCategoryTitle.length > 0){
				$("#category_nav").html(searchCategoryTitle);
				$("#category_nav").show();
			}	
		}
	});
	//제조사탭 클릭
	$("#BrandTab").click(function() { 
		$("#category_nav").hide();
		if($(".brandSort div").is(":visible") && document.URL.indexOf("list.jsp") >= 0){
			insertLog('11020');
		}
		if ($(".brandSort div").html().trim().length == 0 ){
			CmdSpinLoading();
				
			var vParam = getParam();
			var vParam2 = "&mobile2=new&tTy=factory";
			
			if($("#BrandTab").text() == "쇼핑몰"){
				vParam2 = "&mobile2=new&tTy=shop";
			}
			
			$.ajax({
				type: "GET",
				url: "/search/getTabLayer.jsp", 
				//async: true,
				//data: "cate="+cate+"&&key=popular+DESC&mobile2=new&tTy=factory",
				data: vParam + vParam2,
				dataType:"JSON",
				success: function(result){	 
					$(".brandSort div").html(null);
					var template = "";
					template += "<ul>{{#factoryList}}";
					//template += "<li><label><input class=\"chkbox\" name=\"f_chk\" id=\"{{factoryName}}\" type=\"checkbox\" {{#factoryChk}}{{factoryChk}}{{/factoryChk}}>{{factoryHot}} {{factoryName}} <span>{{factoryCnt}}</span><label></li>";
					template += "<li class=\"pg{{factoryGroup}}\"><label><input class=\"chkbox\" name=\"f_chk\" id=\"{{factoryId}}\" type=\"checkbox\" {{#factoryChk}}{{factoryChk}}{{/factoryChk}}>{{factoryName}} {{#factoryName2}}<br>{{factoryName2}}{{/factoryName2}}<span> {{factoryCnt}}</span><label></li>";
					template += "{{#factoryNext}}</ul><ul>{{/factoryNext}}";
					template += "{{/factoryList}}";
					template += "{{#factoryNav}}";
					template += "<input type=\"hidden\" id=\"allCnt\" value=\"{{allCnt}}\" >";
					template += "<input type=\"hidden\" id=\"pageCnt\" value=\"{{pageCnt}}\" >";
					template += "{{/factoryNav}}";
					template += "</ul>";
							  
					var html = Mustache.to_html(template, result);			
					$(".brandSort div").html(html);	
					
					var allCnt = $("#allCnt").val();
					var pageCnt = $("#pageCnt").val();
					
					$(".pagination02 span").html("<strong>15</strong> /  "+allCnt);
					
					var pPage = 1;
					
					var brandWidth = $('.brandSort').width(),
						brandListLength = $('.brandSort > div > ul').length,
						brandListWidth = $('.brandSort > div > ul').width(brandWidth);
					$('.brandSort > div').width((brandWidth * brandListLength));		

					var varResearchKeyword = "";
							 
					$(".pagingPrev2").click(function() { 
						if(pPage > 1){
							//$(".pg"+pPage).hide(); 
							pPage = pPage - 1;
							$(".sortSelect .brandSort").scrollTo( (pPage-1) * $('.brandSort').width(), 800 );
							//$(".pg"+pPage).show();
							var pCnt = $(".pg"+pPage).length;
							pCnt = (pPage-1)*15 + pCnt;
							$(".pagination02 span strong").html(pCnt);	
						}
					}); 
					$(".pagingNext2").click(function() { 
						if(pPage < pageCnt){
							//$(".pg"+pPage).hide();
							$(".sortSelect .brandSort").scrollTo( pPage*$('.brandSort').width(), 800 );
							pPage = pPage + 1;
							//$(".pg"+pPage).show();	
							var pCnt = $(".pg"+pPage).length;
							pCnt = (pPage-1)*15 + pCnt;
							$(".pagination02 span strong").html(pCnt);											
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
				},
				complete: function(){ 
					$("#cm_loading").hide();	
				}
			});
		}
	});
	//가격대탭 클릭
	$("#PriceTab").click(function() { 
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
				//data: "cate="+cate+"&key=popular+DESC&mobile2=new&tTy=price",
				data: vParam + "&mobile2=new&tTy=price",
				dataType:"JSON", 
				success: function(result){
					$(".inForm").html(null);
					var template = "";
					template += "{{#priceList}}<span><input type=\"tel\" id=\"srhPrice\" value=\"{{minPirce}}\" onkeyup=\"inputPriceCheck(this);\" onfocusout=\"checkNumberFormat(this);\"/></span><span style=\"width:28px;\">원 ~</span><span><input type=\"tel\" id=\"srhPrice2\" value=\"{{maxPirce}}\" onkeyup=\"inputPriceCheck(this);\" onfocusout=\"checkNumberFormat(this);\" / ></span><span style=\"width:20px;\">원</span>{{/priceList}}";
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
				}
			}); 
		}			
	});
	//스펙탭 클립
	$("#SpecTab").click(function() { 
		if($(".optionSort").is(":visible") && document.URL.indexOf("list.jsp") >= 0){
			insertLog('11022');
		}
		getSpec();
	});	
	$(".btnAllOpen").click(function() { 
		if($(".btnAllOpen").hasClass("on") && document.URL.indexOf("list.jsp") >= 0){
			insertLog('11023');
		}
		$("#grid").val('');
		if($(".btnAllOpen").hasClass("on")){
			$("#allopen").val('y');
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
	
	function getList(type){	//리스트 불러오기
		
		if (typeof(getParam()) != "undefined" || getParam() != ''){
			var cateCode = getParam();
			cateCode = cateCode.replace("cate=","");
			$("#bestcate").val(cateCode); 
		}
		
		$.ajax({ 
			type: "GET",
			url: varPage,
			async: true, 
			data: getParam()+"&best=Y", 
			dataType:"JSON", 
			success: function(result){
				if(type == 'a'){ 
					//검색목록 카테고리_추천
					var chucategory = "";
					chucategory += "{{#chu_category}}"; 
					chucategory += "<li><a href=\"javascript:///\" class=\"searchCates\" id=\"{{code}}\"><span>{{name}}</span> <span style='color:#8c8c8c;font: 12px/1.5 '돋움',Dotum,'굴림',Gulim,Helvetica,sans-serif;'>{{cnt}}</span></a></li>";  
					chucategory += "{{/chu_category}}";   
					var categoryHtml = Mustache.to_html(chucategory, result);		
					$("#chkCategory").html(categoryHtml); 	
				}
				if(type == 'a' || type == 'b'){ 	
					//검색목록 카테고리_전체_타이틀
					var mcategory_title = "";
					mcategory_title += "{{#m_category_title}}"; 
					mcategory_title += "전체 카테고리   <span style='color:#4c5363;'>({{length}}개 카테고리)</span>";  
					mcategory_title += "{{/m_category_title}}";   
					var categoryHtml = Mustache.to_html(mcategory_title, result);		
					$("#categoryAll").html(categoryHtml);	
					categoryHtmlOrg_prevTitle = $("#categoryAll").html();

					//검색목록 카테고리_전체
					var mcategory = "";
					mcategory += "<ul>"; 
					mcategory += "{{#m_category}}"; 
					mcategory += "<li class=\"searchCate\" id=\"{{code}}\"><a href=\"javascript:///\"><span>{{name}}</span> <div style='color:#8c8c8c;font: 12px/1.5 '돋움',Dotum,'굴림',Gulim,Helvetica,sans-serif;'>{{cnt}}</div></a></li>";  
					mcategory += "{{#ul}}</ul><ul>{{/ul}}";  
					mcategory += "{{/m_category}}";   
					mcategory += "</ul>"; 
					var categoryHtml = Mustache.to_html(mcategory, result);		
					$(".allCateLIst .mCate").html(categoryHtml);	
					$(".allCateLIst .mCate").show();
					$(".allCateLIst .sCate").hide();
					
					var cateWidth  = $('.allCateLIst').width(),
					listLength = $('.allCateLIst .mCate > ul').length,
					listWidth = $('.allCateLIst .mCate > ul').width(cateWidth);
					$('.allCateLIst .mCate').width((cateWidth * listLength));
				}			
				
				//전체갯수
				var listCnt = "{{#goodsCnt}}{{cnt}}{{/goodsCnt}}";
				var listCntHtml = Mustache.to_html(listCnt, result);		
				$(".prodSortOpt p").html(listCntHtml+"건");	
				
				
				if($(".prodHead  h1  #goodsCnt").html()){
					
					if($(".prodHead  h1  #goodsCnt").html().trim() == "()"){
						$(".prodHead  h1  #goodsCnt").html(" ("+listCntHtml+"건)");	
					}
					
				}
				
				
				allcnt = listCntHtml;

				if(listCntHtml == 0 ){
					//검색결과 없음
					$(".searchNone").show();
					$(".pagination").hide();
					if( document.URL.indexOf("search.jsp") >= 0 ){
						$(".prodSort").hide();
					}
					//location.href = "search2.jsp?keyword="+$("#all_keyword").val();
				}else{
					if( document.URL.indexOf("search.jsp") >= 0 ){
						$(".prodSort").show();
					}
					$(".searchNone").hide();
					$(".pagination").show();
					
					//하단 페이징 부분
					var pageBar = "{{#goodsPageBar}}<strong>{{pageBar}}</strong> /  {{cnt}}{{/goodsPageBar}}";
					var pageBarHtml = Mustache.to_html(pageBar, result);		
					$(".pagination span").html(pageBarHtml);	
				}
				var sponChk = "";
				
				if(getParam().indexOf("sponChk=Y") > 0){
					sponChk = "Y";
				}

				//목록 
				$(".prodList").html(null);
				
				var listDiv = "";
				
				listDiv += "{{#goodsList}}";
				listDiv += "<li>	";			
				listDiv += "<a href=\"javascript:///\" class=\"listarea\" id=\"{{modelno}}\" shopcode=\"{{shopcode}}\">	";			
				listDiv += "		<input type=\"hidden\" id=\"goods{{modelno}}_modelno\" name=\"modelno\" value={{modelno}}>";
				listDiv += "		<input type=\"hidden\" id=\"goods{{modelno}}_popularmodelno\" name=\"popularmodelno\" value={{popularmodelno}}>";
				listDiv += "		<input type=\"hidden\" id=\"goods{{modelno}}_ca_code\" name=\"ca_code\" value={{ca_code}}>";
				listDiv += "		<input type=\"hidden\" id=\"mobileurl\" {{#mobileurl}}value=\"{{mobileurl}}\"{{/mobileurl}}>";
				if(sponChk == "Y"){ 
				}else{ 
				listDiv += "	{{#sponsor}}<span class=\"sponsor\">스폰서</span>{{/sponsor}}";   
				}
				listDiv += "	{{#hot}}<span class=\"rank\">{{hot}}</span>{{/hot}}	";			
				listDiv += "	<p class=\"prodChoice\" onclick=\"event.cancelBubble=true;\"><button type=\"button\" id=\"{{zzimId}}\">찜</button></p>	";			
				//listDiv += "	<span class=\"thum\"><img src=\"{{imgurl}}\" alt=\"{{modelnm}} 제품이미지\" id=\"img_{{modelno}}\" onerror=\"CmdErrImg('{{modelno}}','{{imgurl_er}}')\"  !style=\"width:100%;height:100%;\" /></span>";
				listDiv += "	<span class=\"thum\"><img class=\"thum2\" data-original=\"{{imgurl_er}}\"  src=\"\" alt=\"{{modelnm}} 제품이미지\" id=\"img_{{modelno}}\" !onerror=\"CmdErrImg('{{modelno}}','{{imgurl_er}}')\"  !style=\"width:100%;height:100%;\" /></span>";
				listDiv += "	<div>	";			
				//listDiv += "		<span class=\"stit\">{{{copyphrase}}}&nbsp;</span>	";			 
				listDiv += "		<span class=\"com\"><em>{{{factory}}}</em><em class=\"date\">{{date}}</em><em class=\"company\">{{mallcnt}}</em></span>	";			
				listDiv += "		<strong>{{{modelnm}}}</strong>	";		  
				listDiv += "		<span class=\"stit\">{{#bbs_num}}상품평({{bbs_num}}){{#salecnt}}<em>|</em>판매량({{salecnt}}){{/salecnt}}{{/bbs_num}}</span>	";
				//listDiv += "		{{#salecnt}}<em class=\"sales\">{{salecnt}}</em>{{/salecnt}}		";	
				listDiv += "		{{^type}}<em class=\"shop\">{{mallcnt3}}</em>{{/type}}		";	
				listDiv += "		<span class=\"price {{^type}}shop_p{{/type}}\">	";			 
				listDiv += "			{{#soldout_y}}<em class=\"soldout\">단종/품절</em>{{/soldout_y}}	";
				listDiv += "			{{^new}}{{minprice3}}{{/new}}";   
				listDiv += "			{{#soldout_n}}{{#new}}{{#type}}<span class=\"min\">최저가</span> {{/type}}<em>{{minprice3}}<em>원</em></em>{{/new}}{{/soldout_n}}";   
				listDiv += "		</span>	";				
				listDiv += "	</div>	";			
				listDiv += "</a>	";			 
				listDiv += "{{#spec}}";			 
				listDiv += "<div class=\"prodtxt toggle {{#spec_length}}spec{{/spec_length}}\" value=\"Hide\" >";
				listDiv += "{{^spec_length}}<span>더보기</span>	{{/spec_length}}";			
				listDiv += "{{{spec}}}";			  
				listDiv += "{{^spec_length}}<em class=\"btndetail\"  id=\"btndetail_{{modelno}}\" onclick=\"event.cancelBubble=true;\"><a href=\"javascript:///\">자세히</a></em>{{/spec_length}}	";			
				listDiv += "</div>	";	
				listDiv += "{{/spec}}	";			 
				listDiv += "{{#type}}";  
				listDiv += "<div class=\"pircelist plist\" id=\"goods{{modelno}}\">	";
				listDiv += "	<input type=\"hidden\" id=\"bestoptionchk\" value=\"{{#mall_YN}}mall{{/mall_YN}}{{#option_YN}}option{{/option_YN}}\" >";
				listDiv += "	<dl>	";			
				listDiv += "		{{#group_cnt}}<dt>가격비교{{#mallcnt3}}<em>({{mallcnt3}})</em>{{/mallcnt3}}{{#option_YN}}<span>옵션보기({{group_cnt}})</span>{{/option_YN}}</dt>{{/group_cnt}} ";
				listDiv += "		{{^group_cnt}}<dt>가격비교<span>업체({{mallcnt3}})</span></dt>{{/group_cnt}}	";				
				listDiv += "		<dd  class=\"enuriList\">	";			
				listDiv += "		</dd>	";			
				listDiv += "	</dl>	";			 
				listDiv += "	<p class=\"moreBtn\" ><a href=\"javascript:///\"><span id=\"option_more_{{modelno}}\">더보기 (5/{{#mall_YN}}{{mallcnt3}}{{/mall_YN}}{{#option_YN}}{{group_cnt}}{{/option_YN}})</span><em class=\"link\">전체보기 ({{mallcnt3}})</em></a></p><!-- 접기  class=\"on\"-->	";			
				listDiv += "</div>	";		
				listDiv += "{{/type}}";  	
				listDiv += "</li>	";	
				listDiv += "{{/goodsList}}";   
				
				var listDivHtml = Mustache.to_html(listDiv, result);	
				listDivHtml = listDivHtml.split("별도확인</span>원").join("별도확인").split("출시예정</span>원").join("출시예정");		
				
				$('.prodList').html(listDivHtml.replace(/&amp;/gi,"&").replace(/&apos;/gi,"'"));	
				
				$('.prodList > li > div > a > span').each(function(i,v){
						var cnt = i+1;
						if(cnt <= 3 ){
							var label_rank = "<span class=\"label rank"+cnt+"\">";
							$(this).last().append(label_rank);	
						}
				});
				$('.prodList .thum img').each(function(){
					var thisId = this.id;
					
					var aa = document.getElementById(thisId).clientWidth;
					var bb = document.getElementById(thisId).clientHeight;

					 if(aa > bb){
					   $("#"+thisId).css("width","100%");
					   $("#"+thisId).css("height","");
					}else if(aa < bb){ 
					   $("#"+thisId).css("width","");
					   $("#"+thisId).css("height","100%");
					 }else{
					   $("#"+thisId).css("width","100%");
					   $("#"+thisId).css("height","100%");
					 }
				});  

				if($(".prodEnuriInfo").length > 0){
					$("#BrandTab").text($("#brandtab").val());
				}else{
					$("#BrandTab").text("쇼핑몰");
				}

				//검색 카테고리 pcate
				var pCate = "{{#pcate}}{{pcate}}{{/pcate}}";
				var pCateHtml = Mustache.to_html(pCate, result);		
				$("#pcate").val(pCateHtml);	
								
				//찜 스크립트
				var zzimG = "{{#zzimModel}}{{Model}}{{/zzimModel}}";
				var zzimGHtml = Mustache.to_html(zzimG, result);		
				
				goodsNumbers = zzimGHtml;

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
						} 
					});

					/*가격비교*/
					$('.plist dt').click(function(){
						var _this = this.parentNode.parentNode.id;
						if ($("#"+_this).hasClass("pmore")) {
							$("#"+_this).removeClass("pmore");
						} else {
							$("#"+_this).addClass("pmore");
						} 
					});
  					$('.plist .link').click(function(){
						var _this = this.parentNode.parentNode.parentNode.id;
						location.href = "/mobilefirst/detail.jsp?modelno="+_this.replace('goods','')+"&group=1";
					});
					$('.btndetail').click(function(){
						var _this = this.id;
						location.href = "/mobilefirst/detail.jsp?modelno="+_this.replace('btndetail_','')+"&tab=2&group=1";
					}); 
					$('.pircelist dt').click(function(){
						var thisId = this.parentNode.parentNode.id;
						var chkVal = $("#"+thisId+" #bestoptionchk").val();

						if($("#"+thisId).hasClass("soon")){
						}else{
							//if($("#"+thisId).hasClass("option")){
							if(chkVal == "option"){
								getOption($("#"+thisId+"_modelno").val());
							}else if(chkVal == "mall"){
								getMall($("#"+thisId+"_modelno").val());
							}
							
							if(document.URL.indexOf("list.jsp") >= 0){ 
								if($("#"+thisId).hasClass('on')) {
								}else{
									insertLog('11025');
								}
							}
						}
					});		
				
					$('.prodEnuri button').click(function(){
						var thisId = this.parentNode.id;
						if($(this).hasClass("option")){
							getOption($("#"+thisId+"_modelno").val());
						}else if($(this).hasClass("mall")){
							getMall($("#"+thisId+"_modelno").val());
						} 
						if(document.URL.indexOf("list.jsp") >= 0){
							if($("#"+thisId).hasClass('on')) {
							}else{
								insertLog('11025');
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
					$('.prodChoice button').click(function(){
						$(this).toggleClass('on'); 
					});			
		
					$('.prodEnuriInfo > li > button').click(function(){
						var _this = $(this);
						tabCont(_this);
					});
					$('.btnAll').click(function(){
						var thisId = this.id;
						location.href = "/mobilefirst/detail.jsp?modelno="+thisId+"&group=1";				
					});
					$('.listarea').click(function(){
						var thisId = this.id;
						var mobileUrl = $("#"+thisId+" #mobileurl").val();
						
						var thisText = $("#goods"+thisId+" td:first").text();
						 
						if($("#img_"+thisId).attr("src").indexOf("img_19.jpg") > 0 ){
							goALogin();
						}else{
							if(mobileUrl.length > 0){
								addResentZzimItem(1, "P", thisId);
								
								var newUrl = mobileUrl;
								
								if( navigator.userAgent.indexOf("iPhone") > 0 || navigator.userAgent.indexOf("iPod") > 0 ||  navigator.userAgent.indexOf("iPad") > 0){
									newUrl = newUrl + "&DEVICE_BROWSER=Y";
								}
								var today = new Date();
								var month = (today.getMonth() + 1);
								var date = today.getDate(); 
											
								if(newUrl.indexOf("akmall.com") > 0 && month == 9 && date >= 19 ){
									alert("쇼핑몰 시스템 점검중입니다.");
									return false;
								}
									
								var newWin = window.open(newUrl);
							}else{
								if(thisText == "PC 최저가"){
								}else{
									location.href = "/mobilefirst/detail.jsp?modelno="+thisId+"&group=1";				
								}
							}
						}

						ga('send', 'event', 'mf_best', 'click_goods', 'best_'+$("#"+$("#cate").val()).text());
						
					});
					$('.infoBox .btn').click(function(){
						var thisId = this.id;
						location.href = "/mobilefirst/detail.jsp?modelno="+thisId;				
					});
					if(type == 'a' || type == 'b'){ 	
						$('.searchCate').click(function(){
							$(".brandSort div").html(null);
							$("#BrandTab").text($("#brandtab").val());
							$("#factory").val("");
							$("#shop_code").val("");
						
							CmdSpinLoading();
							
							var thisId = this.id;
										 	
							var thisName = $("#"+thisId+" span:first").text();
							
							if(thisName.indexOf("추가기타") >= 0){
								$("#cate").val(thisId);
								$("#page").val('1');
								
								getList('re');
							}else{
								sCategory(thisId, thisName);
							}		
						});
					}
					zzimCheckSetBest();
					 
					if(szCategoryPower.length == 0){
						szCategoryPower = $("#pcate").val();	
						catePower = $("#pcate").val();
					} 
					if(type == 'a'){ 			
						ad_commandPower = encodeURIComponent(result.ad_command);
		
						//setPowerLinkLink();
					}
			},
			complete: function(){  
				$("img.thum2").lazyload({
					onError: function(element) {
			           console.log("error loading image: " + $(this));
			        } 
				}); 
				$("img.thum2").error(function(){

				}).attr("src", "http://photo3.enuri.com/data/working.gif"); 
				
				$("#cm_loading").hide();
				$(".loading").hide();
				
				if($("#grid").val() == "y" ){
					$('.btnGrid').click();
				}else{
					if($("#allopen").val() == "y" ){
						$('.btnAllOpen').addClass('on');
						$('.prodSummary').addClass('on');
					}
					$('.btnList').click(); 
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
		//if ($(".optionSort").html().trim().length == 0 || param != ""){
		if ($(".optionSort").html().trim().length == 0){	
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
					$(".optionSort").html(null); 
					var template = ""; 
					var template2 = ""; 
					template += "{{#specList}}";
					//template += "<li><label for=\"option1\" style='width:70px;overflow:hidden;height:20px;'>{{spec_group_title}}</label>";
					//template += "<select class=\"spec_select\">"; 
					//template += "{{#spec}}<option value=\"{{specno}}\" {{#specChk}}selected=\"{{specChk}}\" {{/specChk}}>{{spec_cate_title}}</option>{{/spec}}"; 
					//template += "</select></li>";			
					template += "<li><label for=\"option1\" style=\"width:70px;height:20px;overflow:hidden;\">{{spec_group_title}}</label><a href=\"#selOption{{gpno}}\" class=\"ms-choice\" id=\"{{gpno}}\"><span id=\"selOptionText{{gpno}}\" style=\"padding-left:100px;\">속성선택</span><div></div></a></li>";		
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
					template2 += "						<label for=\"\" style='font-weight:bold;'>";	
					template2 += "							선택안함";	
					template2 += "							<input type=\"checkbox\" name=\"spec_cancle\" id=\"uncheck{{gpno}}\" class=\"spec_cancle\" />";	
					template2 += "						</label>";	
					template2 += "					</li>";	
					template2 += "				</ul>";	
					template2 += "				<ul style='border-bottom:1px solid #d7d7d7;'>";	
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
					template2 += "					</ul>";
					template2 += "			</div>";	
					template2 += "			<div class=\"layerBtn\">";	
					template2 += "				<button class=\"btnTxt btnSpec\" id=\"{{gpno}}\" >조회</button>";	
					template2 += "				<button class=\"btnTxt btnCloseSpec\" id=\"{{gpno}}\" >취소</button>";	
					template2 += "			</div>";	
					template2 += "		</div>";	
					template2 += "	</div>";	
					template2 += "</section>";	
					template2 += "{{/specList}}";	
					
					
					var html = Mustache.to_html(template, result);	
					var html2 = Mustache.to_html(template2, result);	
	
					$(".optionSort").html(html);	
					$("#specDiv").html(html2);
					
			        $(".btnSpec").click(function(e){			//완료
			        	var no = this.id;

			        	var getspecNo = getCheckedSpec();
			        	$("#sel_spec").val(getspecNo);
			        	getCheckSpecText(no);
			        	getUnCheckCancle(no);
			        	$("#page").val('1');

						var param = getParam();
						var schWord = checkSearchInKeyword();
						
						if (schWord != ""){
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
									}
								}
							});	
						}
						
			        });
			        $(".btnCloseSpec").click(function(e){		//취소
			        	var no = this.id;
			        	CmdCloseLayerPop();
			        	getUnCheckCancle(no);
			        	getUnCheckCancle2(no);
			        	
			        });
			        $(".spec_cancle").click(function(e){		//선택안함
			        	var no = this.id.replace("uncheck","");
			        	getUnCheckSpec(no);
			        	this.checked = false;
			        	CmdCloseLayerPop();
			        	$(".btnSpec").click();

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
			       	$('.optionSort .ms-choice').click(function(){
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
									
				var scategory_title = "";
				scategory_title += "{{#s_category_title}}"; 
				scategory_title += "전체 <em class=inCate style=\"color:#0081e5;\">"+name+"</em> <span>({{length}}개 카테고리)</span>";  
				scategory_title += "{{/s_category_title}}";   
				var categoryHtml = Mustache.to_html(scategory_title, json);		
				$("#categoryAll").html(categoryHtml);	
			
				var scategory = "";
				scategory += "<ul>"; 
				scategory += "<li class=\"prev\"><a href=\"javascript:///\" style=\"line-height:30px;text-align:center;vertical-align:middle;\">이전</a></li>"; 
				scategory += "{{#s_category}}"; 
				scategory += "<li><a href=\"javascript:///\"  class=\"searchCates2\" id=\"{{code}}\"><span>{{name}}</span> <div style='color:#8c8c8c;font: 12px/1.5 '돋움',Dotum,'굴림',Gulim,Helvetica,sans-serif;'>{{cnt}}</div></a></li>";  
				scategory += "{{#ul}}</ul><ul>{{/ul}}";  
				scategory += "{{/s_category}}";   
				scategory += "</ul>"; 
				var categoryHtml2 = Mustache.to_html(scategory, json);	
				$(".allCateLIst .sCate").show();
				$(".allCateLIst .sCate").html(categoryHtml2);

				$('.searchCates2').click(function(){
					CmdSpinLoading();
					
					$(".brandSort div").html(null);
					$("#BrandTab").text($("#brandtab").val());
					$("#factory").val("");
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

					categoryHtmlOrg_prevTitle_Sub = $("#"+thisId+" span").text();
				});	
				$('.prev').click(function(){
					$("#categoryAll").html(categoryHtmlOrg_prevTitle);
					$(".allCateLIst .mCate").show();
					$(".allCateLIst .sCate").hide();
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
		$.ajax({
			type: "GET",
			url: "/mobilefirst/ajax/detailAjax/get_option.jsp",
			async: false,
			data: "modelno="+modelno, //preview 1:5개, other:전부.
			dataType:"JSON",
			success: function(json){
				var optionObj = $("#goods"+modelno+" .enuriList");
				optionObj.html(null);		
				//var template = "<h1 style=\"font-weight:normal;border-bottom:0;\">옵션 전체 최저가 <lavel id=\"optionAll_cnt_"+ modelno +"\"></lavel></h1>";
				//var template = "<li id='"+modelno+"_top'>";
				//template += "<a href=\"javascript:///\">";
				//template += "	<span class=\"opt_head\">옵션 전체 최저가 <lavel style=\"color:#8a909e;\" id=\"optionAll_cnt_"+ modelno +"\"></lavel></span>";
				//template += "</a></li>";

				//template += "{{#optionDetail}}<li id='{{optionModelno}}' condiname=\"{{optionCondiname}}\"><a href=\"javascript:///\">";
			    //template += "<span class=\"opt\">{{optionCondiname}}{{#optionMallcnt}} <label style=\"color:#8a909e;\">({{optionMallcnt}})</label>{{/optionMallcnt}}</span>";
			    //template += "<span class=\"price\">{{#optionMinpriceflag}}<em>최저가</em> {{/optionMinpriceflag}} <strong class=\"pay\">{{optionPrice}}</strong></span>";
			    //template += "</a></li>{{/optionDetail}}";
				
				var template = "";
				template += "			<table>	";			
				template += "				<colgroup>	";			
				template += "					{{#optionUnit}}<col width=\"38%\" /><col width=\"*\" /><col width=\"38%\" />{{/optionUnit}} ";
				template += "					{{^optionUnit}}<col width=\"50%\" /><col width=\"50%\" />{{/optionUnit}} ";
				template += "				</colgroup>	";			
				template += "				<tr>	";			
				template += "					<th>옵션</th>	";			
				template += "					{{#optionUnit}}<th class=\"unit\">{{optionUnit}}</th>{{/optionUnit}}	";			
				template += "					<th>가격</th>	";			
				template += "				</tr>	";			
				template += "				{{#optionDetail}}	";
				template += "				<tr id='{{optionModelno}}' condiname=\"{{optionCondiname}}\">	";			
				template += "					<td>{{optionCondiname}}{{#optionRank}}<img src=\"http://img.enuri.info/images/mobilefirst/rank0{{optionRank}}.png\" alt=\"{{optionRank}}위\" onerror=\"this.src='http://img.enuri.info/images/blank.gif'\"/>{{/optionRank}}</td>	";			
				template += "					{{#optionUnit}}<td class=\"price\">{{{optionUnitprice}}}</td>{{/optionUnit}}	";			
				template += "					<td class=\"min\">{{#optionMinpriceflag}}최저가{{/optionMinpriceflag}} <em>{{optionPrice}}<em></em></em></td>	";			
				template += "				</tr>	";			
				template += "				{{/optionDetail}}	"; 
				template += "			</table>	";	

				var html = Mustache.to_html(template, json);	
				
				if(html.length > 1)	 
					optionObj.html(html);	
				
				var vOption_Cnt = json.optionDetail.length ;
				var vOptionUnit = json.optionUnit ;
				var vOptionUnit = json.optionUnit ;
				var vOptionUnit_tmp = vOptionUnit.replace("*","").replace("최저가","가격").replace("(배송","<br>(배송");
				 
				$("#goods"+modelno+" .unit").html(vOptionUnit_tmp); 
				
				if(vOption_Cnt > 5){
					$("#option_more_"+modelno).show();
					
					$("#goods"+modelno+" .enuriList tr").show();
					
					$("#goods"+modelno+" .enuriList tr").filter(":gt(5)").toggle();
					
					//$("#option_more_btn_"+modelno).text("전체보기(5/"+ vOption_Cnt +")▼");
					
					$("#option_more_"+modelno).click(function(){
						//$("#list_select").removeClass("listOpen");
						$("#goods"+modelno+" .enuriList tr").filter(':gt(5)').toggle();

						if($("#goods"+modelno+" .enuriList tr").filter(':gt(5)').css("display") != "none"){
							$("#option_more_"+modelno).text("접기("+ vOption_Cnt +"/"+ vOption_Cnt +")");
							$("#goods"+modelno+" .moreBtn a").addClass("on");
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
					
					if(thisId.length > 0){
						if(thisId.indexOf("_top")>-1){
							location.href = "/mobilefirst/detail.jsp?modelno="+thisId.replace("_top","") +"&group=1";				
						}else{
							location.href = "/mobilefirst/detail.jsp?modelno="+thisId;
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
			dataType:"JSON",
			success: function(json){
				var mallObj = $("#goods"+modelno+" .enuriList");
				mallObj.html(null);		

				//var template = "<h1 style=>몰별  최저가</h1>"; 
   				//template += "{{#listContent}}<li id='"+modelno+"'><a href=\"javascript:///\"><span class=\"mall\">{{shopname}}</span><span class=\"delivery\">{{displaydelivery}}</span><strong class=\"pay\"><span class=\"price\">{{price}}</span></strong></a></li>{{/listContent}}";
				//var template = "{{#listContent}}<li onclick=\"goShop('{{#mobileurl}}{{mobileurl}}{{/mobileurl}}','{{shopcode}}','{{plno}}','{{goodscode}}','{{instanceprice}}','{{category}}','{{price}}','{{minprice}}',this, "+modelno+");\"><a href=\"javascript:///\" >";
		        //template += "<span class=\"mall\">{{shopname}}</span>";
		        //template += "<span class=\"delivery\">{{displaydelivery}}</span>";
		        //template += "<span class=\"price\">{{#mpriceflag}}<em>최저가</em> {{/mpriceflag}} <strong class=\"pay\">{{price}}</strong></span>";
		        //template += "</a></li>{{/listContent}}";
				
				var template = " ";
				template += "			<table>	";			
				template += "				<colgroup>	";			
				template += "					<col width=\"25%\" /><col width=\"*\" /><col width=\"43%\" /> ";
				template += "				</colgroup>	";			 
				template += "				{{#listContent}}	";
				template += "				<tr onclick=\"goShop('{{#mobileurl}}{{mobileurl}}{{/mobileurl}}','{{shopcode}}','{{plno}}','{{goodscode}}','{{instanceprice}}','{{category}}','{{price}}','{{minprice}}',this, "+modelno+");\">	";			
				template += "					<td class=\"mall\">{{shopname}}</td>	";			
				template += "					<td class=\"price\">{{displaydelivery}}</td>";			
				template += "					<td class=\"min\">{{#mpriceflag}}최저가{{/mpriceflag}} <em>{{price}} 원<em></em></em></td>	";			
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
							}else{
								$("#option_more_"+modelno).text("더보기");
								$("#goods"+modelno+" .moreBtn a").removeClass("on");
							}
							
							$("body, html").animate({ scrollTop: $("#tab1").offset().top }, 300); 
						});
						   
						$("#allview_"+modelno).click(function(){
							var thisId = $("#allview_"+modelno).attr("modelno");
							location.href = "/mobilefirst/detail.jsp?modelno="+thisId+"&group=1";
							
							return false;
						});
					}else{
						$("#option_more_"+modelno).hide();
					}
				}
				$("#goods"+modelno+" .enuriList li").click(function() { 
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
				param += "&cate="+$("#cate").val().trim();
			}
		}	 
		if($("#factory").length){
			if ($("#factory").val().trim().length > 0 ){
				param += "&factory="+$("#factory").val().replace(/&/gi,"%26")
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
			if($("#start_price").val() != "0" && $("#end_price").val() != "0"){
				if ($("#start_price").val().trim().length > 0 ){
					param += "&start_price="+$("#start_price").val().replace(/,/gi,"");
					sponChk = "Y";
				}
				if ($("#end_price").val().trim().length > 0 ){
					param += "&end_price="+$("#end_price").val().replace(/,/gi,"");
					sponChk = "Y";
				}
			}
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
		if ($("#all_keyword").length){ 
			if ($("#all_keyword").val().trim().length > 0 ){
				param += "&keyword="+$("#all_keyword").val();
			}
		}
		if(document.URL.indexOf("list.jsp") >= 0 ){
			var varInKeyWord = false;
			var varPrevSearchKeyword = "";
			if ($("#srhRe").length){
				if ($("#srhRe").val().trim().length > 0 ){
					param += "&keyword="+varPrevSearchKeyword + schKeyword($("#srhRe").val());
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
					param += "&in_keyword="+schKeyword($("#srhRe").val().trim());
					sponChk = "Y";
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
		
		return param; 		
	}
	
	function getInCount(type){
		$("#page").val('1');
		var param = getParam();
		var schWord = checkSearchInKeyword();
		
		if (schWord != ""){
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
						alert("검색결과가 없습니다.      \n \n붙은 단어를 띄어 써서 검색해 보세요. \n다른 검색조건을 선택해 보세요.");
						$("#cm_loading").hide();
					}else{   
						//location.href = "list.jsp?" + param;
						getList('re');
					}
				}
			});	
		}
	}
	function checkSearchInKeyword(){
		var schWord = $("#srhRe").val().trim();
		var schLen = schWord.length;
		
		schWord = schWord.trim();
		
		//if ($("#srhPrice").val() == "" || $("#srhPrice2").val() == ""){
		//	alert("가격대 정보를 확인해주세요.");
		//}else if( (schLen == 1 && $("#srhRe").val().trim().length == 1 ) ){
		if( (schLen == 1 && $("#srhRe").val().trim().length == 1 ) ){
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
		param = param + "&search_area=1111";
		
		if (schWord != ""){
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
						alert("검색결과가 없습니다.      \n \n붙은 단어를 띄어 써서 검색해 보세요. \n다른 검색조건을 선택해 보세요.");
						$("#cm_loading").hide();
					}else{
						getList();
					}
				} 
			});		
		}
	}

	function schKeyword(schWrd){
		var schWord;
		schWord = schWrd;
		schWord = replace2(schWord,"'");
		schWord = replace2(schWord,"\\");
		schWord = replace2(schWord,"^");
		schWord = replace2(schWord,"&");
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
		//schWord = replace2(schWord,":");
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

		var arrSpec = tmpSpec.split(",");
		for( var ispec = 0 ; ispec < arrSpec.length ; ispec++){
			$("#spec_"+arrSpec[ispec]).click();
		}  	
	}
			        	
});
