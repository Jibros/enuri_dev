automake_template = $('#automake_template').html();	 //자동완성 템플릿 선언
history_template = $('#history_template').html();	 //최근 검색 템플릿 선언
history_empty_template = $('#history_empty_template').html();	 //최근 검색 템플릿 선언
history_goods_template = $('#history_goods_template').html();	 //최근 검색 템플릿 선언
exptionKeyWord = "";
jQuery(document).ready(function($) {
	//검색 입력 박스 오픈
	$("input[name=search_txt]").bind({focus:function(){searchOpen();}});
	$("body").on('click', '#search_text_del', function(event) {
		$("#search_keyword").val("");
		$("#search_keyword").focus();
	});
	var rec_flag = getCookie("MOB_REC_FLAG");
	
	if(typeof rec_flag != "undefined" ){
		if(rec_flag.indexOf("RECFLAG=N") > -1){
			$('#delect_rec').text("검색어저장 하기");
			$('#delect_rec').attr("onclick","delect_rec_Y()");
		}
	}
	//검색 입력 박스 바인드
	$("#search_keyword").bind({
		keydown:function(event){ 
			var kEvt = window.event;
			if (kEvt.keyCode == 13){
				 goSearch();
			}else{
				setTimeout(function(){
					//$("#searchType").val("auto");	
					getSuggestion();
				},300);
			}
		},
		blur:function(){
			
		},
		focus:function(){
			getSuggestion();
			getRecentGoods('autoKeywordemply'); //최근 본 상품
		}
	});
		$("body").on('click', '.searchList ul li a', function(event) {
			//$("#search_keyword").val($(this).text());
			goSearch($(this).text(),"A");
			event.preventDefault();
			//goSearch($(this).text(),"A");
		});
	setTimeout(function(){
	},500);
	$.getScript("/common/js/exception_keyword.js", function() {
		exptionKeyWord = varExpKeyWord;
	});
});

//searchList go
function goSearch(searchText,type){
	
	var url = "/mobilefirst/search.jsp?keyword=";
    
    var keyword = "";
    
    if(type = 'A'){
    	keyword = searchText;
    }else{
    	keyword = $("#search_keyword").val();
    }
    
	if($("#searchWrap").is(':visible') && keyword == ""){
		alert("검색어를 입력하세요");
		return;
	}
	
	/*
	if(typeof keyword == 'underfined' || keyword == null){
    	keyword = "";
    }
    */
	
			   
	if(keyword.length < 2 ){
		if (!(keyword.length == 1 && exptionKeyWord.indexOf(keyword) >= 0 )){
			alert("한글자는 검색할 수 없습니다.\r\n다른 단어를 함께 선택해 주세요.");
			$("#search_keyword").val("");
			$("#search_keyword").focus();
			return;
		}
	}
	
	if(keyword.indexOf("__") > 0){ //히스토리
		
		var keywordMake = keyword.substring(0,keyword.indexOf("__"));
		location.href = url+escape(schKeyword(keywordMake.trim()));
		//ga('send', 'event', 'search', 'search', '검색_'+keywordMake.trim());
		
	}else{
		location.href = url+escape(schKeyword(keyword.trim()));
		//ga('send', 'event', 'search', 'search', '검색_'+keyword.trim());
	}
	
}

//자동 완성 ajax 호출
function getSuggestion(){

	var url = "/mobilefirst/ajax/AjaxAutoMake.jsp";

	var varSearchType = "";
	
	if($("#search_keyword").val().length == 0){
		varSearchType = "recentl";
	}else if($("#search_keyword").val().length > 0){
		varSearchType = "auto";
	}
	
	$.getJSON(url+searchParam(),function(data){
			
			$("#searchList").empty();
			
			//포커스 검색바 검색어 없을 경우 검색히스토리 노출
			/*
			if($("#search_keyword").val().length == 0){
				searchListHistoryHtml(data.history);	
			}else if($("#search_keyword").val().length > 0){
				searhAutoMakeList(data.auto);
			}
			*/
				searchFootDisplay("Y");
				
				$automakeDiv = $("#automake").empty();	//automake div 초기화 선언
				$history_div = $("#searchList").empty();	//automake div 초기화 선언
				$history_goods_div = $("#history_goods").empty();	//automake history_goods_div 초기화 선언
				
				//keyword blur 최근 검색어 노출
				if(varSearchType == 'recentl'){
					
					//검색히스토리
					if (data.history){

						var historyData = historyMakeData(data);
						
						$history_div.append(Mustache.render(history_template, historyData));// 템플릿에 연동
						
						//getRecentGoods('recentl'); //최근 본 상품
						
						searchWrap_visible();
						
						
					}else{ //최근 검색어 없을 경우
						
						$history_div.append(Mustache.render(history_empty_template, 0));// 템플릿에 연동
						getRecentGoods('recentlempty'); //최근 본 상품
						searchWrap_visible();
						$("#searchCont").attr("class", ".searchCont");
						$(".noneTxt").text("최근검색어 및 최근본상품이 없습니다.");
						//$(".noneTxt").text("최근 검색어가 없습니다.");
						
					}
					
				}

				if (varSearchType == 'auto') {
					
					searchFootDisplay("N");
					//자동 완성
					if (data.auto) {
						
						//새로운 json 생성 히스토리랑 비교 한다음 히스토리 가 있는경우 문자열의 경우 class 지정
					    var autoHtml = getAutoMakeHtml();
						
						var jarray = {
							auto: []
						};
						
						if (data.history) {
							
							$.each(data.auto, function(k, av){
								
								var samYN = false;
																
								$.each(data.history, function(k, hv){
								
									var length = hv.keyword.indexOf("__");
									var hkeyword = hv.keyword.substring(0, length); // 히스토리 키워드
									
									if(hkeyword.trim() == av.keyword.trim()){
																																									
										var tempJsonData = {};
										
										var keyword = document.getElementById("search_keyword").value;
										var reKeyword = keywordReplace(av.keyword.trim(),keyword); 
										
										tempJsonData.keyword = reKeyword;		
										tempJsonData.onoff = "on";
										samYN = true;
										jarray.auto.push(tempJsonData);
										
									}
								});
								if(!samYN){
									var tempJsonData = {};
									
									var keyword = document.getElementById("search_keyword").value;
									var reKeyword = keywordReplace(av.keyword.trim(),keyword);
									
									tempJsonData.keyword = reKeyword;
									tempJsonData.onoff = "off";
									jarray.auto.push(tempJsonData);
									
								}
													
							});
							
							//$automakeDiv.append(Mustache.to_html(autoHtml, jarray));
							$history_div.append(Mustache.render(history_template, jarray));// 템플릿에 연동
						}else{
							
							$.each(data.auto, function(k, av){
								
								var tempJsonData = {};
								
								var keyword = document.getElementById("search_keyword").value;
								var reKeyword = keywordReplace(av.keyword,keyword); 
								
								tempJsonData.keyword = reKeyword;		
								tempJsonData.onoff = "off";
								samYN = true;
								jarray.auto.push(tempJsonData);
								
							});
							
							//$automakeDiv.append(Mustache.to_html(autoHtml, jarray));
							$history_div.append(Mustache.render(history_template, jarray));// 템플릿에 연동
						}
						
						 
					}else{	//자동완성에 문자가 없을 경우 
						
						var keyword = $("#keyword").val();
						
						//검색히스토리
						if (data.history){
							/*
							var historyData = historyMakeData(data);
							
							$history_div.append(Mustache.render(history_template, historyData));// 템플릿에 연동
							getRecentGoods('autoKeywordemply'); //최근 본 상품
							searchWrap_visible();
							*/
							
							
							$history_div.append(Mustache.render(history_template, null));// 템플릿에 연동
							
							//getRecentGoods('autoKeywordemply'); //최근 본 상품
							searchWrap_visible();
							
							
									
						//	$history_div.append(Mustache.render(history_template, data.history));// 템플릿에 연동
						}else{
							
							$history_div.append(Mustache.render(history_empty_template, 0));// 템플릿에 연동
							var goodsCnt = getRecentGoods(); //최근 본 상품
							
							//$(".noneTxt").text("검색어에 대한 상품 없습니다.");
							
							if(goodsCnt == 0){
								
								$(".noneTxt").text(" ");
								$("#searchCont").attr("class", "searchCont");
							}
						}
						
						searchFootDisplay("Y");
						
					}
				}	
	
	});

}

function searhAutoMakeList(auto){
	
	var resentHtml = "";
	
	$.each(auto,function(i,v){
		
		resentHtml = "";
		
		resentHtml += "<li>";
		resentHtml += "<a href='javascipt:///'>"+v.keyword+"</a>";
		resentHtml += "</li>";
		
		$("#searchList").append(resentHtml);
	});
	
	
}


//자동완성 파라메터
function searchParam(){

	var varParam = "";

	if($("#search_keyword").val().trim().length > 0){
		varParam += "?_q="+encodeURIComponent($("#search_keyword").val().trim());
	}
	return varParam; 

}



//검색 레이아웃 오픈
function searchOpen(){

	$("#searchWrap").css("display","block");
	
	searchLockScroll();
	
	var text = $("#auto_keyword").val();
	
	$("#search_keyword").val(text);
	$("#search_keyword").focus();
}

/**
 * 화면 스크롤 잠금
 */
function searchLockScroll() {
	$('#wrap').css({
		'overflow' : 'hidden',
		'height' : '0'
	});
	
}

/**
 * 화면 스크롤 해제
 */
function searchUnlockScroll() {
	$('#wrap').css({
		'overflow' : 'auto',
		'height' : 'auto'
	});
}

//검색 레이아웃 닫기
function search_close(){

	$("#searchWrap").css("display","none");
	searchUnlockScroll();
	$("#auto_keyword").val("");
	
}

//최근 본 상품 DB를 통해 데이터를 읽어옴
function getRecentGoods(varSearchType){
	
	var resentListStr = getCookie("resentList");
	var listGoodsCnt = 0;
	var showGoodsCnt = 0;
	listGoodsCnt = 0;
	
	var cnt = 0;
	
	if (typeof(resentListStr) != "undefined") {
		var resentListStrAry = resentListStr.split(",");
		var resentListStr2 = "";
		if (resentListStr.indexOf(",") > -1) {
			for (var i = 0; i < resentListStrAry.length; i++) {
				resentListStr2 += resentListStrAry[i] + ",";
				cnt++;
				if (i > 6) 	break;
				
			}
		}
		
		// 쿠키 를 통해 데이터를 읽어옴(resentList)
		var loadUrl = "/mobilefirst/ajax/resentZzim/Ajax_goodsListNew.jsp?listType=9&goodsNumList=" + resentListStr2;
		
		$.ajax({
			url: loadUrl,
			dataType: 'json',
			success: function(data){
			
				goodsCnt = data["goodsCnt"];
				
				$history_goods_div = $("#latestProd").empty(); //automake div 초기화 선언
				
				if (goodsCnt > 0) {
					
					$history_goods_div = $("#latestProd").empty(); //automake div 초기화 선언					
					$history_goods_div.append(Mustache.render(history_goods_template, data));// 템플릿에 연동
					
					if (goodsCnt > 0) {
						
						if(goodsCnt > 6){
							$(".latestProd").last().append("<li class=\"more\"><a href=\"resentzzim/resentzzimList.jsp?listType=1\">더 보기</a></li>");
						}
						$("#searchWrap").addClass("back_line");
								
					} else {
						$history_goods_div = $("#latestProd").empty(); //automake div 초기화 선언
						$("#searchWrap").removeClass();
					}
					
				} 
			
				if(varSearchType=='recentl'){
						if(cnt == 0 || cnt == undefined){
							$("#searchCont").attr("class", ".searchCont");
						}else{
							$("#searchCont").attr("class", ".searchCont latest");
						}	
				}else if(varSearchType=='recentlempty'){
					
						if(goodsCnt == 0 || goodsCnt == undefined){
							$("#searchCont").attr("class", ".searchCont");
							$(".noneTxt").text("최근검색어 및 최근본상품이 없습니다.");
							//$(".noneTxt").text("최근 검색어가 없습니다.");
							$("#searchWrap").removeClass();
						}else{
							$(".noneTxt").text("최근 검색어가 없습니다.");
						}
					
				}else if(varSearchType=='autoKeywordemply'){
					
					if(goodsCnt == 0 || goodsCnt == undefined){
						$("#searchCont").attr("class", ".searchCont");
					}else{
						$("#searchCont").attr("class", ".searchCont latest");
					}
					
				}
			
			}
		});
		
		
	}
	return cnt;
	
}

//최근본 상품 삭제
function resentXLint(modelno,plno){
	
	var deleteModelno = "G"+modelno;
	
	// 삭제할 상품이 없음
	if(modelno=="0" && plno=="0") return;
	
	if(modelno=="0") deleteModelno = "P"+plno;
	else if(plno=="0") deleteModelno = "G"+modelno;
	
	delResentAppGNB(deleteModelno);
	getRecentGoods("recentlempty");
	
	
}

//최근상품 삭제
function delResentAppGNB(goodsCode) {

	var prodectStr = "";
	var resentListStr = getCookie("resentList");
	
	if(goodsCode.indexOf("G")>-1) {
		prodectStr = "G:" + goodsCode.substring(1) + ",";
	}
	if(goodsCode.indexOf("P")>-1) {
		prodectStr = "P:" + goodsCode.substring(1) + ",";
	}
	if(resentListStr.indexOf(prodectStr)>-1) {
		resentListStr = resentListStr.split(prodectStr).join("");
	}
	
	setCookie("resentList", resentListStr);
}



function searchFootDisplay(YN){
	
	if(YN == "Y"){
		
		$("#all_delete").show();
		$("#bar").show();
		$("#delect_rec").show();
	}else{
		//$(".searchFoot").children().not(".close").empty();
		
		$("#all_delete").hide();
		$("#bar").hide();
		$("#delect_rec").hide();
	}
		
}

//자동완성 html 생성
function getAutoMakeHtml(){
	
	var makeHtml =	"<ul>";
	 	makeHtml += "{{#auto}}";
		makeHtml += "<li class={{{onoff}}} style='height:30px;'>{{{keyword}}}</li>";
		makeHtml += "{{/auto}}";
		makeHtml += "</ul>";
		
		return makeHtml; 
	
}


//자동완성 입력키 컬러 변경
function keywordReplace(objKeyword , eleKeyword){
	var returnKeyword = objKeyword.replace(eleKeyword,"<span>"+eleKeyword+"</span>"); ;
	return returnKeyword;
}



//검색영어 노출
function searchWrap_visible(){
	
	/*
	var maskHeight = $(document).height();
	var maskWidth = $(window).width();
	
	var count = $(".latestProd").children().length;
	var heigth = $(".searchCont").height();
	var agent = navigator.userAgent;
	var height = 720;
	
	if(agent.indexOf("iPad")){
		height = 1024;
	}
	
	$("#searchWrap").css({
	"width":maskWidth ,
	"height":height ,
	"display":"block" ,
	});
	*/
	
	//$("#container").css("display","none");
	//$("footer").css("display","none");
	
}



function historyMakeData(json){
	
	var jarray = {
		history: []
	};
	
	$.each(json.history,function(i,v){
		
		var keyword = v.keyword.trim();
		keyword = $.trim(keyword.substring(0,keyword.indexOf("__"))); 
		
		var tempJsonData = {};
		tempJsonData.history_keyword = v.keyword.trim();
		tempJsonData.keyword = $.trim(keyword);
		jarray.history.push(tempJsonData);
		
	});
	
	return jarray;
}


//최근검색어 모두 삭제
function all_delete_rec(){
	
	var temp = confirm('최근 검색어를 모두 삭제 하시겠습니까?');
	
	if(temp){ 
		CmdSetCookie('recentl','');
		setTimeout(function(){
			getSuggestion();  
			scrollTo(0,0);
		},1000); 	   		
	}
}
//최근검색어 삭제
function deleteRec_one(param){
	
	if(!e) var e = window.event;
	e.cancelBubble = true;
	e.returnValue = false;
	if (e.stopPropagation) {
		e.stopPropagation();
		e.preventDefault(); 
	}
	
	var recKeyword = param.trim();
	//recKeyword = recKeyword.replace(" ","+");
	var recKeyword_Tmp = "";
	if(recKeyword.indexOf("[해당메뉴로]") > 0){
		recKeyword_Tmp = "C:"+recKeyword.replace("[해당메뉴로]","");
	}else{
		recKeyword_Tmp = "S:"+recKeyword;
	}
	
	CmdSetCookie('m_recentl_one', recKeyword_Tmp.trim());
	//CmdSetCookie('m_recentl_one', recKeyword_Tmp.trim().replace("S:","C:"));
	setTimeout(function(){
		getSuggestion();  
		scrollTo(0,0); 
	},1000); 
	 
}


function delect_rec_Y(){
	
	if(confirm("검색어 저장 기능을 활성화 합니다.")){
	
		CmdSetCookie('reckeyword_Y','');
		setTimeout(function(){
			getSuggestion();  
			scrollTo(0,0);
		},500); 	   
		
		$('#delect_rec').text("검색어 저장 끄기");
		$('#delect_rec').attr("onclick","iosDelete_rec()");
		
	}
}



//검색기능
function iosDelete_rec(){
   var temp = confirm('검색어 저장을 사용하지 않으시겠습니까?');
	
	if(temp){ 
		CmdSetCookie('reckeyword_N','');
		setTimeout(function(){
			getSuggestion();  
			scrollTo(0,0);
		},1000); 	   		
	}else{ 
	} 
	
	$('#delect_rec').text("검색어 저장 하기 ");
	$('#delect_rec').attr("onclick","delect_rec_Y()");
	
}
