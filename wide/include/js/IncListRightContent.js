$(document).ready(function(){
	//getRightWingKnowList2();
	if (rbViewFlag == 2) {
		setSearchIngiKeywrd(1);
		setSearchIngiKeywrd(2);
	}
	
});
function getRightWingKnowList2(paramCaCode) {
	var param = null;
	if(paramCaCode.length==0) return;
	param = {"procType" : 1, "cate" : paramCaCode}
	
	$.ajax({
		type : "get",
		url : "/lsv2016/ajax/getRightWingContents_ajax_v2.jsp",
		async: true,
		data : param,
		dataType : "json",
		success: function(json) {
			var knowBoxListObj = json.knowBoxList;

			if(knowBoxListObj && knowBoxListObj.length>0) {
				$('.knowcom-box').show();

				for(a=0; a<knowBoxListObj.length; a++){
					var makeHtml = "";
					var makeHtml2 = "";
					var moveUrl = "";
					var page = 0; //페이지
					var cnt = 0; //페이지 당 컨텐츠 수
					var $group = $('.wing_knowcom--group').eq(a);
					if(a==0){
						cnt = 5; //뉴스 5개
					}else{
						cnt = 3; //가이드,리뷰 3개
					}

					$.each(knowBoxListObj[a], function(i,v){
						if(Object.keys(v).length > 0){
							if(a > 0 && v.showThumbImg && makeHtml2.length == 0){
								moveUrl = "/knowcom/detail.jsp?kbno="+v.kb_no;
								makeHtml2 += "<span class='knwocom-group__thum--img'>";
								makeHtml2 += "	<img src='"+v.showThumbImg+"' alt=''>";
								makeHtml2 += "</span>";
								makeHtml2 += "<span class='tx--thumb'>"+v.kb_title+"</span>";
							}else{
								makeHtml += "<li><a href='/knowcom/detail.jsp?kbno="+v.kb_no+"' target='_blank'>"+v.kb_title+"</a></li>";
							}

							if(i%cnt == cnt-1){ //해당 페이지 컨텐츠 개수 모자라면 그리지 않는다.
								$group.find('.knowcom-group--body').eq(page).addClass('available');
								$group.find('.knowcom-group__list').eq(page).html(makeHtml);
								$group.find('.knwocom-group__thum').eq(page).attr('href',moveUrl);
								$group.find('.knwocom-group__thum').eq(page).attr('target',"_blank");
								$group.find('.knwocom-group__thum').eq(page).html(makeHtml2);

								makeHtml="";
								makeHtml2="";
								page++;
							}
						}
					});

					if($group.find('.available').length < 2) $group.find('.knowcom-group__btn').hide(); // 1페이지만 있을경우 버튼 비노출
					$('.knowcom-box .knowcom-box--head .tx--cate').text(json.cateNm);
				}
			}
		},
		complete:function(){
		      // 우측 컨텐츠 fixed 관련 스크립트
	          var $body = $(".list-body");
	          var $side = $(".list-body-side .side__inner");
	          var fixSidePos = function(){
	              var scroll = $(window).scrollTop(),
	              bodyH = $body.outerHeight(), // 컨테이너 높이
	              bodyT = $body.offset().top, // 컨테이너 Position Top
	              sideH = $side.outerHeight(), // 우측컨텐츠 높이
	              winH = $(window).height(), // 스크린 Y 크기
	              distT = 70; // 상단과 FIXED 될 거리

	              if ( bodyH > sideH ){ // 우측 컨텐츠 보다 상품리스트가 크고
	                  if ( sideH < winH - distT ){ // 우측 컨텐츠가 스크린H 보다 작을때
	                      if ( scroll > bodyT - distT ){ // 상단에 고정
	                          if ( scroll > bodyT + bodyH - sideH - distT){ // 스크롤이 컨텐츠 하단으로 벗어날때
	                              $side.addClass("is--fixBotOv").removeClass("is--fixBot is--fixTop");
	                          }else{ // 스크롤이 컨텐츠 내에 존재할때
	                              $side.addClass("is--fixTop").removeClass("is--fixBot is--fixBotOv");
	                          }
	                      }else{
	                          $side.removeClass("is--fixTop is--fixBot is--fixBotOv");
	                      }
	                  }else{ // 우측 컨텐츠가 스크린H 보다 클때
	                      if ( scroll > bodyT + (sideH-winH) ){ // 하단에 고정
	                          if ( scroll > bodyT + bodyH - winH ){ // 스크롤이 컨텐츠 하단으로 벗어날때
	                              $side.addClass("is--fixBotOv").removeClass("is--fixBot is--fixTop");
	                          }else{ // 스크롤이 컨텐츠 내에 존재할때
	                              $side.addClass("is--fixBot").removeClass("is--fixTop is--fixBotOv");
	                          }
	                      }else{
	                          $side.removeClass("is--fixTop is--fixBot is--fixBotOv");
	                      }
	                  }
	              }else{ // 우측 컨텐츠가 상품리스트 보다 길때는 실행 안함
	                  $side.removeClass("is--fixTop is--fixBot is--fixBotOv")
	              }
	          }

	          $(window).on({
	              "load" : fixSidePos,
	              "scroll" : fixSidePos,
	              "resize" : fixSidePos
	          })
	          
	          var $wingPH = $(".knowcom-group__placecholder");
              $(window).on('load', function() {
                  setTimeout(function(){ // 퍼블테스트
                      $wingPH.fadeOut(300);
                  },1000)
              })
              
              //*************** 개별로그
              
              // 1. 뉴스
              $(document).on("click", ".knowcom-box .group--news .knowcom-group--body a", function() {
              	if(listType=="list") {
              		insertLogLSV(15807, param_cate); // LP 쇼핑지식 컨텐츠박스 - 뉴스 컨텐츠
              	} else if(listType=="search") {
              		insertLogLSV(16740); // SRP 쇼핑지식 컨텐츠박스 - 뉴스 컨텐츠
              	}
              });
              
              // 2. 구매가이드
              $(document).on("click", ".knowcom-box .group--bguide .knowcom-group--body a", function() {
              	if(listType=="list") {
              		insertLogLSV(15806, param_cate); // LP 쇼핑지식 컨텐츠박스 - 구매가이드 컨텐츠
              	} else if(listType=="search") {
              		insertLogLSV(16741); // SRP 쇼핑지식 컨텐츠박스 - 구매가이드 컨텐츠
              	}
              });
              
              // 3. 리뷰
              $(document).on("click", ".knowcom-box .group--review .knowcom-group--body a", function() {
              	if(listType=="list") {
              		insertLogLSV(15805, param_cate); // LP 쇼핑지식 컨텐츠박스 - 리뷰 컨텐츠
              	} else if(listType=="search") {
              		insertLogLSV(16742); // SRP 쇼핑지식 컨텐츠박스 - 리뷰 컨텐츠
              	}
              });
		},
		error: function (xhr, ajaxOptions, thrownError) {
		}
	});
}

function moveButton(board,param){
	var $group = $("."+board+" .knowcom-group--body.available");
	var $now = $("."+board+" .knowcom-group--body:visible");
	if(param == "next"){
		if(($now.index() < $group.length)){
			$now.next().show();
			$now.hide();
		}else{
			$now.hide();
			$group.eq(0).show();
		}
	}else if(param == "prev"){
		if($now.index() > 1){
			$now.prev().show();
			$now.hide();
		}else{
			$now.hide();
			$group.eq($group.length-1).show();
		}
	}
	
	// 개별로그
	if(listType=="list") {
		if(board=="group--news") {
			insertLogLSV(15786, param_cate); // LP 쇼핑지식 컨텐츠박스 - 뉴스 좌우버튼
		} else if(board=="group--bguide") {
			insertLogLSV(15787, param_cate); // LP 쇼핑지식 컨텐츠박스 - 구매가이드 좌우버튼
		} else if(board=="group--review") {
			insertLogLSV(15788, param_cate); // LP 쇼핑지식 컨텐츠박스 - 리뷰 좌우버튼
		} 
	} else if(listType=="search") {
		if(board=="group--news") {
			insertLogLSV(15712); // SRP 쇼핑지식 컨텐츠박스 - 뉴스 좌우버튼
		} else if(board=="group--bguide") {
			insertLogLSV(15713); // SRP 쇼핑지식 컨텐츠박스 - 구매가이드 좌우버튼
		} else if(board=="group--review") {
			insertLogLSV(15714); // SRP 쇼핑지식 컨텐츠박스 - 리뷰 좌우버튼
		}
	}
	
}

//orderBy=1 : 중복제거한 인기 검색어
//orderBy=2 : 중복제거한 급상승 검색어
function setSearchIngiKeywrd(orderBy) {

	var param = {
		"procType" : 1,
		"orderBy" : orderBy
	}

	var ajaxObj = $.ajax({
		type : "get",
		url : "/lsv2016/ajax/getSearch_Keyword_Rank_ajax.jsp",
		async: true,
		data : param,
		dataType : "json",
		success: function(json) {
			var searchIngiKeywrdDivObj = $("#searchIngiKeywrdDiv");
			var html = "";

			var keywordListObj = json["keywordList"];
			var keywordCnt = json["keywordCnt"];

			if(keywordListObj) {
				searchIngiKeywrdDivObj.show();
				$.each(keywordListObj, function(Index, listData) {
					var keyword = listData["keyword"];
					var rank_1 = listData["rank_1"];
					var rank_2 = listData["rank_2"];
					var new_rank_1 = listData["new_rank_1"];
					var new_rank_2 = listData["new_rank_2"];
					var hotRankClass = " red";
					if(Index>2) hotRankClass = "";

					html += "<li>";
					html += "	<em class=\"tx--rank\">"+(Index+1)+"</em>";
					html += "	<a href=\"javascript:\\\">";
					html += keyword;
					html += "	</a>";
					html += "</li>";
				});
			}
			var listobj = $(".hot-keyword__list--hit");
			if(orderBy=="1") listobj = $(".hot-keyword__list--pop");
			else if (orderBy=="2") listobj = $(".hot-keyword__list--hit");
			listobj.html(html);

			searchIngiKeywrdDivObj.show();

			listobj.find("li a").unbind();
			listobj.find("li a").click(function() {
				var thisObj = $(this);
				var keyword = thisObj.text().trim();
				keyword = encodeURIComponent(keyword);

				openSearchPage(keyword);

				if(orderBy=="1") insertLogLSV(14861);
				if(orderBy=="2") insertLogLSV(14859);
			});

			var $tab = $(".hot-keyword__tab");
            $tab.click(function(e){
                e.preventDefault();
                var $pa = $(this).parent();
                $pa.addClass("is--on").siblings().removeClass("is--on");
            })
		},
		error: function (xhr, ajaxOptions, thrownError) {
			//alert(xhr.status);
			//alert(thrownError);
			//console.log("thrownError="+thrownError);
		}
	});
}

function openSearchPage(keyword) {
	window.open("/search.jsp?keyword="+keyword);
}
