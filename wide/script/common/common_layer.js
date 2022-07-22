var logInit_DICLAYER_AD = false; // 광고 로그셋팅

function loadThumNail(modelno,idx) {
    var thumNailPromise = new Promise(function(resolve,reject){
        $.ajax({
            type: "post",
            url: "/wide/api/product/prodImage.jsp",
            data: {"modelno" : modelno},
            dataType: "json",
            success : function(response){
                resolve(response);
            },error : function(response){
                reject(response);
            }
        });
    }) 
    thumNailPromise.then(function(result){
        drawThumNail(result,idx);
    });
}

function drawThumNail(json,idx){
    var goodsVideoData = json.goodsVideo;
    var goodsThumnailData = json.goodsThumnail;
    var goodsImageData =json.goodsImage;
    var goodsNameData =json.goodsName;
    var html = "";
    var thumIndex = 0;
    if(typeof idx != "undefined"){
        thumIndex = idx;
    }

    html+="        <div class=\"dimmed\"></div>";
    html+="        <div class=\"lay-enlarge-view lay-comm\">";
    html+="            <div class=\"lay-comm--head\">";
    html+="                <strong class=\"lay-comm__tit\">이미지 확대보기</strong>";
    html+="            </div>";
    html+="            <div class=\"lay-comm--body\">";
    html+="                <div class=\"enlarge__box\">";
    html+="                    <div class=\"enlarge__view\">";
    html+="                        <div class=\"lay-thumlist--big\">";
    html+="                            <div class=\"swiper-container\">";
    html+="                                <ul class=\"swiper-wrapper\">";
    if(goodsImageData && goodsImageData.length > 0){
        html += "<li class=\"swiper-slide\"><div class=\"enlarge__view--img\"><img src=\""+goodsImageData+"\" alt=\"\"></div></li>";    
    }
    $.each(goodsVideoData, function(index,listData){
        var video_url = "";
        
        (listData.video_url.indexOf("?") > -1)
        ? video_url = listData.video_url+"&enablejsapi=1&version=3&playerapiid=ytplayer"
        : video_url = listData.video_url+"?enablejsapi=1&version=3&playerapiid=ytplayer";

        html += "  <li class=\"swiper-slide\"><div class=\"enlarge__view--movie\"><iframe width=\"100%\" height=\"100%\" src=\""+video_url+"\" frameborder=\"0\" allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture\" allowfullscreen></iframe></div></li>";
    });
    $.each(goodsThumnailData, function(index,listData){
        html += "<li class=\"swiper-slide\"><div class=\"enlarge__view--img\"><img src=\""+listData+"\" alt=\"\"></div></li>";    
    });
    html+="                                </ul>";
    html+="                            </div>";
    html+="                            <button class=\"enlarge__btn--prev comm__sprite\">이전</button>";
    html+="                            <button class=\"enlarge__btn--next comm__sprite\">다음</button>";
    html+="                        </div>";
    html+="                    </div>                                                        ";
    html+="                </div>";
    html+="                <div class=\"enlarge__thumb\">";
    html+="                    <div class=\"lay-thumlist--sm\">";
    html+="                        <div class=\"swiper-container\">";
    html+="                            <ul class=\"swiper-wrapper\">";
    if(goodsImageData.length > 0){
        html += " <li class=\"swiper-slide\"><img src=\""+goodsImageData+"\" alt=\"\"></li>";    
    }
    $.each(goodsVideoData, function(index,listData){
        var strSource = listData.video_url;
        var strVideoThum = "";
        if(strSource.indexOf("youtu.be") > 0 || strSource.indexOf("youtube") > 0){
            var srcIndex = strSource.lastIndexOf("/");
            var descIndex = 0;
            if(strSource.lastIndexOf("?list") > 0){
                descIndex = strSource.lastIndexOf("?list"); 
            } else if(strSource.lastIndexOf("?autoplay") > 0){
                descIndex = strSource.lastIndexOf("?autoplay"); 
            } else{
                descIndex = strSource.length; 
            }
            strVideoThum = strSource.substring(srcIndex+1,descIndex);
        }
        html += " <li class=\"swiper-slide type--movie\"><img src=\"//img.youtube.com/vi/"+strVideoThum+"/hqdefault.jpg\" alt=\"\"></li>";
    });
    $.each(goodsThumnailData, function(index,listData){
        html += " <li class=\"swiper-slide\"><img src=\""+listData+"\" alt=\"\"></li>";    
    });
    html+="                            </ul>";
    html+="                        </div>";
    html+="                        <button type=\"button\" class=\"arr arr-prev\">이전</button>";
    html+="                        <button type=\"button\" class=\"arr arr-next\">다음</button>";
    html+="                        <div class=\"swiper-pagination\"></div>";
    html+="                    </div>";
    $.each(goodsVideoData, function(index,listData){
        html+="                    <div class=\"enlarge__tx--source\" style=\"display:none;\"></div>";
    });

    html+="                    <div class=\"enlarge__tx--law\">에누리 가격비교는 공개된 자료를 기반으로 상품정보를 제공합니다.<br>쇼핑몰에서 제공하는 상품정보와 다를 수 있으니, 구매 전 쇼핑몰의 상품정보를 다시 한번 확인해주세요. (<a href=\"/etc/disclaimer.jsp\" target=\"_blank\" >법적고지 보기</a>)</div>";
    html+="                </div>";
    html+="            </div>";
    html+="            <button class=\"lay-comm__btn--close comm__sprite\" onclick=\"$(this).closest('.lay--dimm-wrap').hide()\">레이어 닫기</button>";
    html+="        </div>";
    $("#THUMNAILLAYER").html(html);
                              
     // 레이어 : 이미지 확대보기 내 스와이프 컨트롤
    var bigThumnail = ".lay-thumlist--big .swiper-container",  // 이미지확대보기 > 큰 썸네일
    smThumbnail = ".lay-thumlist--sm .swiper-container";    // 이미지확대보기 > 작은 썸네일

    // 레이어 : 작은 썸네일 스와이퍼 생성                                    
    var layThumSwipe_sm = new Swiper(smThumbnail, {
        loop : false,
        slidesPerView : 5,
        initialSlide: 0,
        loopAdditionalSlides : 2,
        spaceBetween : 8,
        centeredSlides: true,
        prevButton : '.lay-thumlist--sm .arr-prev',
        nextButton : '.lay-thumlist--sm .arr-next',
        pagination : '.lay-thumlist--sm .swiper-pagination',
        paginationClickable : false,
        slideToClickedSlide:true,
        onSlideChangeEnd: function(e){
            var activeSlide =  $("#THUMNAILLAYER .lay-thumlist--big .swiper-slide div").eq(e.activeIndex);
            if(activeSlide.hasClass("enlarge__view--img")){
                $("#THUMNAILLAYER").find(".enlarge__thumb .enlarge__tx--source").hide();
            }else{
                $("#THUMNAILLAYER").find(".enlarge__thumb .enlarge__tx--source").show();
                $("#THUMNAILLAYER").find(".enlarge__thumb .enlarge__tx--source").html("출처 : "+goodsVideoData[e.activeIndex-1].ofr_bze_nm+" 제공");    
            }

            stopYoutube();
        },
    });
    
    // 레이어 : 큰 썸네일 스와이퍼 생성
    var layThumSwipe_big = new Swiper(bigThumnail, {
        centeredSlides: true,
        loopAdditionalSlides : 6,
        slidesPerView : 1,
        spaceBeetween : 0,
        loop : false,
        preventClicks:true,
        prevButton : '.lay-thumlist--big .enlarge__btn--prev',
        nextButton : '.lay-thumlist--big .enlarge__btn--next',
        onSlideChangeEnd: function(e){
            var activeSlide =  $("#THUMNAILLAYER .lay-thumlist--big .swiper-slide div").eq(e.activeIndex);
            if(activeSlide.hasClass("enlarge__view--img")){
                $("#THUMNAILLAYER").find(".enlarge__thumb .enlarge__tx--source").hide();
            }else{
                $("#THUMNAILLAYER").find(".enlarge__thumb .enlarge__tx--source").show();
                $("#THUMNAILLAYER").find(".enlarge__thumb .enlarge__tx--source").html("출처 : "+goodsVideoData[e.activeIndex-1].ofr_bze_nm+" 제공");    
            }

            stopYoutube();
        },
    });

    // 레이어 : 컨트롤러를 서로 묶어줍니다.
    layThumSwipe_big.params.control = layThumSwipe_sm;
    layThumSwipe_sm.params.control = layThumSwipe_big;
    $("#THUMNAILLAYER").show(300, function(){
        layThumSwipe_big.update();
        layThumSwipe_sm.update();
        layThumSwipe_big.slideTo(idx);
        layThumSwipe_sm.slideTo(idx); 
       // 
    });
   
    // dimmed 클릭 레이어 숨김
    $("#THUMNAILLAYER .dimmed, #THUMNAILLAYER .lay-comm__btn--close").on("click", function(){
        stopYoutube();
        $(this).closest(".lay--dimm-wrap").hide();
    })              
           
}
function termDicPromise(type) {
    var modelno = $("#TERMDICLAYER").data("modelno");
    var cate = $("#TERMDICLAYER").data("cate");
    var attr_id = $("#TERMDICLAYER").data("attr_id");
    var attr_el_id = $("#TERMDICLAYER").data("attr_el_id");
    var kbno = $("#TERMDICLAYER").data("kbno");
    var keyword = $("#TERMDICLAYER").data("keyword");
    var page = $("#TERMDICLAYER").data("page");

    var param = {
        "procType" : type,
        "cate" : cate,
        "modelno" : modelno,
        "kbnos" : kbno,
        "keyword" : keyword,
        "attribute_id" : attr_id,
        "attribute_element_id" : attr_el_id,
        "page":page
    };
    return new Promise(function(resolve,reject){
        $.ajax({
            type: "get",
            url: "/wide/api/termdicData.jsp",
            data: param,
            dataType: "json",
            success : function(response){
                resolve(response);
            },error : function(response){
                reject(response);
            }
        });
    }) 
}
function showDicLayer(obj){
    var cate = "";
    var modelno = "";
    var kbnos = "";
    var attribute_id = "";
    var attribute_element_id = "";
    var kbno = "";
    var img = "";
    var modelnm = "";
    var type = 1;
    var page = "";
  
    if(typeof gModelData != "undefined"){
        //vip
        modelno = gModelData.gModelno;
        cate = gModelData.gCategory;
        img = gModelData.gImageUrl;
        modelnm = gModelData.gModelNmView;
        attribute_id = $(obj).data("attr_id");
        attribute_element_id = $(obj).data("attr_el_id");
        page = "VIP";
        //kbno = $(obj).data("kbno");
    }else{
        cate = gCate;
		if($(obj).closest("table").attr("id") == "miniVipSpecTable"){ //minivip
           img= $(".minvip__thumb").find("img").attr("src");
           modelnm= $(".minvip__thumb").find("img").attr("alt");
		   modelno = miniVipModelNo;
           page = "VIP";
        }else{
            img = typeof $(obj).parents("li.prodItem").find(".item__thumb img").attr("src") != "undefined" ? $(obj).parents("li.prodItem").find(".item__thumb img").attr("src") : "";
        	modelnm = typeof $(obj).parents("li.prodItem").find(".item__box .item__model a").text() != "undefined" ? $(obj).parents("li.prodItem").find(".item__box .item__model a").text() : "";
			modelno = typeof $(obj).parents(".prodItem").data("model-origin") != "undefined" ? $(obj).parents(".prodItem").data("model-origin") : "";
            page = "LP";
        }
        attribute_id =  typeof $(obj).data("attr_id") != "undefined" ?  $(obj).data("attr_id")  : "" ;
        attribute_element_id = typeof $(obj).data("attr_el_id") != "undefined" ?  $(obj).data("attr_el_id")  : "" ;
        kbno = typeof $(obj).data("kbno") != "undefined" ?  $(obj).data("kbno")  : "" ;
        
    }
    $("#TERMDICLAYER").empty();
    $("#TERMDICLAYER").data("modelno",modelno);
    $("#TERMDICLAYER").data("cate",cate);
    $("#TERMDICLAYER").data("attr_id",attribute_id);
    $("#TERMDICLAYER").data("attr_el_id",attribute_element_id);
    $("#TERMDICLAYER").data("kbno",kbno);
    $("#TERMDICLAYER").data("img",img);
    $("#TERMDICLAYER").data("modelnm",modelnm);
    $("#TERMDICLAYER").data("page",page);

     termDicPromise(1).then(drawlistTermdic)
                      .then(function(){
             termDicPromise(2).then(function(result){
                $("#basicdic").find(".dic-cont__box").html(drawTermdic(result));
                $("#basicdic").find(".lay-dic__menu .dic-list__item").unbind().click(function(){
                    $(this).siblings().removeClass("is--on");
                    $(this).addClass("is--on");
                    var thisAttrId = $(this).find("a").data("attr_id");
                    var thisAttrElId = $(this).find("a").data("attr_el_id");
                    var thisKbno = $(this).find("a").data("kbno");
                    $("#TERMDICLAYER").data("attr_id",thisAttrId);
                    $("#TERMDICLAYER").data("attr_el_id",thisAttrElId);
                    $("#TERMDICLAYER").data("kbno",thisKbno);

                    $("#basicdic").find(".lay-dic__content .dic-cont__tit strong").html($(this).data("name"));
            
                    termDicPromise(2).then(function(result){
                        $("#basicdic").find(".dic-cont__box").html(drawTermdic(result));
                    });
                });
            
                $("#basicdic, #researchdic").find(".lay-dic__menu .dic-search__btn").unbind().click(function(){
                    var thisSearchKeyword = $(this).siblings(".dic-search__input").val();
                    searchTermdic(thisSearchKeyword);
                });
                $("#basicdic, #researchdic").find(".dic-search__input").unbind().keydown(function(key) {
                    if (key.keyCode == 13) {
                        var thisSearchKeyword = $(this).val();
                        searchTermdic(thisSearchKeyword);
                    }
                });
            });
    }); 
    
    /* termDicPromise(1).then(drawlistTermdic);
    termDicPromise(2).then(function(result){
        $("#TERMDICLAYER").find(".lay-comm--body .dic-cont__box").html(drawTermdic(result));

        $("#TERMDICLAYER").find(".lay-comm--body .lay-dic__menu .dic-list__item").unbind().click(function(){
            $(this).siblings().removeClass("is--on");
            $(this).addClass("is--on");
            $("#TERMDICLAYER").find(".lay-comm--body .lay-dic__content .dic-cont__tit strong").html($(this).data("name"));
            termDicPromise(2).then(function(result){
                $("#TERMDICLAYER").find(".lay-comm--body .dic-cont__box").html(drawTermdic(result));
             });
        });
     }); */
     $("#TERMDICLAYER").removeClass("dic--light");
     $("#TERMDICLAYER").show().css({
        "position" : "absolute",
        "top" : $(obj).offset().top - 80,
        "left" : "50%",
        "transform" : "translateX(-50%)",
        "z-index" : 10
    }); 

  
}
function searchTermdic(keyword){
    $("#TERMDICLAYER").data("keyword",keyword);
    $("#researchdic").find(".lay-dic__menu .dic-search-result__txt strong").html(keyword);
    termDicPromise(3).then(drawSearchListTermdic);
}
function drawSearchListTermdic(json){
    var html ="";
    var thisAttrName = "";
    if(json.success && json.total > 0){
        var termDicList = json.data;
        html += "           <ul class=\"dic-list__inner\">";
        $.each(termDicList,function(index,listData){
            if(index==0){
                $("#TERMDICLAYER").data("kbno",listData.ref_kb_no);
                $("#TERMDICLAYER").data("attr_id",listData.attribute_id);
                $("#TERMDICLAYER").data("attr_el_id",listData.attribute_element_id);
                thisAttrName = listData.name;
                html += "<li class=\"dic-list__item is--on\" data-name=\""+listData.name+"\">";
            }else{
                html += "<li class=\"dic-list__item\" data-name=\""+listData.name+"\">";
            }
            html += "    <a href=\"javascript:void(0);\" data-kbno=\""+listData.ref_kb_no+"\" data-attr_id=\""+listData.attribute_id+"\" data-attr_el_id =\""+listData.attribute_element_id+"\" data-name=\""+listData.name+"\"  \">"+listData.name+"</a>";
            html += "   </li>";
        });
        html += "           </ul>";
        $("#researchdic").find(".lay-dic__content .dic-cont__tit strong").html(thisAttrName);
        $("#researchdic").find(".dic-list").html(html);
        $('#researchdic').show();
        termDicPromise(2).then(function(result){
            $("#researchdic").find(".dic-cont__box").html(drawTermdic(result));
            $("#researchdic").find(".lay-dic__menu .dic-list__item").unbind().click(function(){
                $(this).siblings().removeClass("is--on");
                $(this).addClass("is--on");
                var thisAttrId = $(this).find("a").data("attr_id");
                var thisAttrElId = $(this).find("a").data("attr_el_id");
                var thisKbno = $(this).find("a").data("kbno");
                $("#TERMDICLAYER").data("attr_id",thisAttrId);
                $("#TERMDICLAYER").data("attr_el_id",thisAttrElId);
                $("#TERMDICLAYER").data("kbno",thisKbno);
    
                $("#researchdic").find(".lay-dic__content .dic-cont__tit strong").html($(this).data("name"));
        
                termDicPromise(2).then(function(result){
                    $("#researchdic").find(".dic-cont__box").html(drawTermdic(result));
                });
            });
        });
    }else{
        alert("입력하신 검색어에 대한 에누리 용어사전 검색결과가 없습니다.");
        return ;
    }
}
function drawlightTermdic(json){
    if(json.success && json.total > 0){
        var termDicList = json.data.kbnoList;
        var strHeaerTitle = termDicList[0].strHeaerTitle;
        var html = "";
        if(termDicList.length > 0){
            html += "<div class=\"lay-comm--head\">";
            html += "   <strong class=\"lay-comm__tit\">에누리 용어사전</strong>";
            html += "</div>";
            html += "<div class=\"lay-comm--body\">";
            html += "   <div class=\"lay-dic__inner\">";
            html += "       <div class=\"lay-dic__content\">";
            html += "           <div class=\"dic-cont__top\">";
            html += "                <div class=\"dic-cont__tit\">";
            html += "                      <strong>"+strHeaerTitle+"</strong>";
            html += "               </div>";
            html += "           </div>";
            html += "           <div class=\"dic-cont__box\">";
            html += "               <div class=\"cont\">"+drawTermdic(json)+"</div>";
            html += "           </div>";
            html += "       </div>";
            html += "    </div>";
            html += "</div>";
            html += "<button class=\"lay-comm__btn--close comm__sprite\" onclick=\"$(this).parent().hide()\">레이어 닫기</button>";
        }
        $("#TERMDICLAYER").html(html);
    }
}
function drawlistTermdic(json){
    if(json.success && json.total > 0){
        var termDicList = json.data;
        var html = "";
        var thisAttr_id = $("#TERMDICLAYER").data("attr_id");
        var thisAttr_el_id = $("#TERMDICLAYER").data("attr_el_id");
        var thisModelImg = $("#TERMDICLAYER").data("img");
        var thisModelNm = $("#TERMDICLAYER").data("modelnm");
        var thisKbno = "";
        var thisAttrName = "";
        if(termDicList.length > 0){
            html += "<div class=\"lay-comm--head\">";
            html += "   <strong class=\"lay-comm__tit\">에누리 용어사전</strong>";
            html += "</div>";
            html += "<div class=\"lay-comm--body\">";
            html += "   <div id=\"basicdic\" class=\"lay-dic__inner\">";
            html += "       <div class=\"lay-dic__menu\">";
            html += "           <div class=\"dic-model\">";
            html += "               <div class=\"dic-model__thumb\">";
            html += "                   <img src=\""+thisModelImg+"\" >";
            html += "               </div>";
            html += "               <div class=\"dic-model__name\">"+thisModelNm+"";
            html += "               </div>";
            html += "           </div>";
            html += "           <div class=\"dic-list\">";
            html += "           <ul class=\"dic-list__inner\">";
            $.each(termDicList,function(index,listData){
               if(thisAttr_id == listData.attribute_id && thisAttr_el_id==listData.attribute_element_id){
                    $("#TERMDICLAYER").data("kbno",listData.ref_kb_no);
                    $("#TERMDICLAYER").data("attr_id",listData.attribute_id);
                    $("#TERMDICLAYER").data("attr_el_id",listData.attribute_element_id);
                    thisAttrName = listData.name;
                    html += "<li class=\"dic-list__item is--on\" data-name=\""+listData.name+"\">";
                }else{
                    html += "<li class=\"dic-list__item\" data-name=\""+listData.name+"\">";
                }
                html += "    <a href=\"javascript:void(0);\" data-kbno=\""+listData.ref_kb_no+"\" data-attr_id=\""+listData.attribute_id+"\" data-attr_el_id =\""+listData.attribute_element_id+"\" data-name=\""+listData.name+"\"  \">"+listData.name+"</a>";
                html += "   </li>";
            });
            html += "           </ul>";
            html += "           </div>";
            html += "           <div class=\"dic-search\">";
            html += "                <input type=\"text\" class=\"dic-search__input\" placeholder=\"검색어를 입력해주세요\">";
            html += "                 <button class=\"dic-search__btn\" >검색</button>";
            html += "           </div>";
            html += "       </div>";
            html += "       <div class=\"lay-dic__content\">";
            html += "           <div class=\"dic-cont__top\">";
            html += "                <div class=\"dic-cont__tit\">";
            html += "                      <strong>"+thisAttrName+"</strong>";
            html += "               </div>";
            html += "           </div>";
            html += "           <div class=\"dic-cont__box\">";
            html += "               <div class=\"cont\"></div>";
            html += "           </div>";
            html += "       </div>";
            html += "    </div>";
            html += "     <div id=\"researchdic\" class=\"lay-dic__inner dic--research\" style=\"display: none;\">";
            html += "         <div class=\"lay-dic__menu\">";
            html += "             <div class=\"dic-search-result\">";
            html += "                 <div class=\"dic-search-result__head\">용어 검색결과</div>";
            html += "                 <div class=\"dic-search-result__txt\">";
            html += "                     <strong></strong>";
            html += "                 </div>";
            html += "                 <button class=\"btn--research-close comm__sprite\" onclick=\"$('.dic--research').hide();\">닫기</button>";
            html += "             </div>";
            html += "             <div class=\"dic-list\"></div>";
            html += "             <div class=\"dic-search\">";
            html += "                <input type=\"text\" class=\"dic-search__input\" placeholder=\"검색어를 입력해주세요\">";
            html += "                 <button class=\"dic-search__btn\" >검색</button>";
            html += "             </div>";
            html += "         </div>";
            html += "         <div class=\"lay-dic__content\">";
            html += "             <div class=\"dic-cont__top\">";
            html += "                  <div class=\"dic-cont__tit\">";
            html += "                        <strong></strong>";
            html += "                 </div>";
            html += "             </div>";
            html += "              <div class=\"dic-cont__box\">";
            html += "                 <div class=\"cont\"></div>";
            html += "             </div>";
            html += "          </div>";
            html += "     </div>";
            // 			  <!-- Coupang AD -->
            html += "     <div class=\"lay-dic__ad\"></div>";
            html += "</div>";
            html += "<button class=\"lay-comm__btn--close comm__sprite\" onclick=\"$(this).parent().hide()\">레이어 닫기</button>";
        }
        $("#TERMDICLAYER").html(html);
        
        var diclistObj = $("#basicdic").find(".dic-list");
        if(diclistObj.find(".dic-list__item.is--on").length > 0){
            diclistObj.scrollTop(diclistObj.find(".dic-list__item.is--on").offset().top-diclistObj.offset().top);
        }
        
        // 쿠팡 광고 호출
        call_DICLAYER_AD();
    }
}

// 쿠팡 광고 불러오기
function call_DICLAYER_AD() {
	var adListType = "";
	if(listType=="list") {
		adListType = "lp";
	} else if(listType=="search") {
		adListType = "srp";
	} else if(listType=="vip") {
		adListType = "vip";
	}
	
	var paramString = "type="+adListType;
	if(adListType=="lp") {
		paramString += "&cate="+param_cate;
	} else if(adListType=="srp") {
		paramString += "&keyword="+encodeURIComponent(param_keyword);
	} else if(adListType=="vip") {
		if(typeof gModelData != "undefined") {
			paramString += "&cate="+gModelData.gCate4;
		}
	}
	paramString += "&size=15";
	
	var adObj = $.ajax({
		type:"GET",
		url: "/wide/api/ad/cpcCoupang.jsp",
		data: paramString,
		dataType: "JSON"
	});
	
	// 광고 그리기
	adObj.then(draw_DICLAYER_AD);
	// 광고 이벤트리스너
	adObj.then(eventListner_DICLAYER_AD);
}

// 광고 그리기
function draw_DICLAYER_AD(dataObj) {
	var Obj = $(document).find("#TERMDICLAYER .lay-dic__ad");
	if(Obj.length>0 && dataObj && dataObj.success && dataObj.data.length>0) {
		
		var adHtml = [];
		var adIdx = 0;
		
		var item = dataObj.data[0];
		var vIsRocket = typeof item.isRocket == "undefined" ? false : item.isRocket;
		
		adHtml[adIdx++] = "<div class=\"ad__coupang_dic\">";
		adHtml[adIdx++] = "	<a href=\""+item.landingUrl+"\" target=\"_blank\" rel=\"noopener noreferrer\" data-type=\"adDic\">";
		adHtml[adIdx++] = "		<div class=\"ad_goods_thumbnail\"><img src=\""+item.productImage+"\" alt=\""+item.productName+"\" width=\"78\" height=\"78\"></div>";
		adHtml[adIdx++] = "		<div class=\"ad_goods_name\">"+item.productName+"</div>";
		adHtml[adIdx++] = "		<div class=\"ad_goods_price\"><em>"+item.productPrice.format()+"</em>원</div>";
		adHtml[adIdx++] = "		<div class=\"ad_goods_logo\">";
		adHtml[adIdx++] = "			<img src=\"//img.enuri.info/images/sample/sample_logo_coupang@h32.png\" width=\"56\" height=\"16\">";
		if(vIsRocket) {
			adHtml[adIdx++] = "		<img src=\"//img.enuri.info/images/sample/sample_logo_coupang_rocket@h32.png\" width=\"64\" height=\"16\">";
		}
		adHtml[adIdx++] = "		</div>";
		adHtml[adIdx++] = "	</a>";
		adHtml[adIdx++] = "	<div class=\"ad__label\">";
		adHtml[adIdx++] = "		<img src=\"//img.enuri.info/images/rev/label_ad@32x22.png\" width=\"16\" height=\"11\">";
		adHtml[adIdx++] = "	</div>";
		adHtml[adIdx++] = "</div>";
		Obj.html(adHtml.join(""));
	}
}

// 광고 이벤트리스너
function eventListner_DICLAYER_AD() {
	if(!logInit_DICLAYER_AD) {
		$(document).on("click", "a[data-type=adDic]", function() {
			insertLogLSV(27132);
		});
		logInit_DICLAYER_AD = true;
	}
}

function drawTermdic(json){
    var html = [];
    if(json.success && json.total > 0){
        var kbnoList = json.data.kbnoList;
        var specno = json.data.specno;
       
        var hIdx = 0;
        var strHeaerTitle = "";
        var dimhtml = "";
        $.each(kbnoList,function(index,listData){
            var kb_no = listData["kb_no"];
            strHeaerTitle = listData["strHeaerTitle"]; // 제목
            var strHeaderImage = listData["strHeaderImage"];
            var strHeaerDesc = listData["strHeaerDesc"];
            var strKb_movfile = listData["strKb_movfile"];
            var strKbContent = listData["strKbContent"];
            var strLinkYn = listData["strLinkYn"];
            var intKtt_readcnt = listData["intKtt_readcnt"];
            if(intKtt_readcnt<=0) intKtt_readcnt = 1;
            intImageHeight = listData["intImageHeight"];
            var intImageWidth = listData["intImageWidth"];
            var strIsSearch = listData["strIsSearch"]; // 개수
            var strBigImage = listData["strBigImage"];
            var intImport = listData["intImport"]; // 중요도
            var strSpecsynonym = listData["strSpecsynonym"];
            var imgRoot = "http://storage.enuri.info/pic_upload/termdictitle/";
            var imgPath = imgRoot + strHeaderImage;

            strHeaerDesc = strHeaerDesc.split("&#39").join("'");
            if(strHeaerDesc != ""){         //서브 레이어 노출추가

                if(strHeaerDesc.trim().indexOf("<synonym")>=0) {
                    var intLoopCheck = 0;
                    while(true) {
                        if(strHeaerDesc.trim().indexOf("<synonym")>=0) {
                            var intF1 = strHeaerDesc.trim().indexOf("<synonym");
                            var str1 = strHeaerDesc.substring(0,intF1);
                            var intF2 = strHeaerDesc.indexOf(">",intF1+8);
                            var strKbNo = strHeaerDesc.substring(intF1+8,intF2).trim();
                            var intF3 = strHeaerDesc.indexOf("</synonym>",intF2);
                            var strFuncsynonym = strHeaerDesc.substring(intF2+1,intF3);
                            var str2 = strHeaerDesc.substring(intF3+10,strHeaerDesc.length);
    
                            strHeaerDesc = str1 + "<span style='cursor:pointer;text-decoration:underline;' data-kbno=\""+strKbNo+"\"  onmouseover=\"this.style.color='#c70b09'\"  onmouseout=\"this.style.color='#000000'\"  onClick=\"searchTermdic('"+strFuncsynonym+"');\">"+strFuncsynonym+"</span>" + str2;
    
                        } else {
                            break;
                        }
    
                        if(intLoopCheck>20) {
                            break;
                        }
    
                        intLoopCheck++;
                    }
                }
                
                var strHeaderOverDescBottom = "";
                var intBreak = strHeaerDesc.trim().indexOf("<break>");
                if (intBreak > 0){
                    strHeaderOverDescBottom = strHeaerDesc.substring(intBreak+7,strHeaerDesc.trim().length);
                    strHeaerDesc = strHeaerDesc.substring(0,intBreak);
                }
    
                // 용어사전 사이에는 <br>로 띄움
                if(index>0) {
                    html[hIdx++] = "<div class=\"dic-subcont__tit\">";
                    html[hIdx++] = "    <strong>"+strHeaerTitle+"</strong>";
                    html[hIdx++] = "</div>";
                }
               
                
                html[hIdx++] ="<table cellspacing=\"0\" cellpadding=\"0\">";
                html[hIdx++] ="<tbody><tr>";
                if(strHeaderImage!=""){
                    html[hIdx++] ="<td width=\"110\" valign=\"top\">";
                    var strGuideHeaderImageSrc = "";
                    if (strHeaderImage.indexOf(".swf")>-1 ){
                        strGuideHeaderImageSrc = "http://storage.enuri.info/pic_upload/termdictitle/"+strHeaderImage;
                        html[hIdx++] ="<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" codebase=\"http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0\" style=\"width:"+intImageWidth+"px; height:"+intImageHeight+"px;\" id=\"beginner_flash_id_"+kb_no+"\" align=\"middle\">";
                        html[hIdx++] ="<param name=\"allowScriptAccess\" value=\"always\"/>";
                        html[hIdx++] ="<param name=\"allowFullScreen\" value=\"false\"/>";
                        html[hIdx++] ="<param name=\"quality\" value=\"high\"/>";
                        html[hIdx++] ="<param name=\"wmode\" value=\"transparent\" />";
                        html[hIdx++] ="<param name=\"movie\" value=\"http://storage.enuri.info/pic_upload/termdictitle/"+strHeaderImage+"\" />";
                        html[hIdx++] ="<param name=\"FlashVars\" value=\"\" />";
                        html[hIdx++] ="<embed src=\"http://storage.enuri.info/pic_upload/termdictitle/"+strHeaderImage+"\" quality=\"high\" wmode=\"transparent\" width=\""+intImageWidth+"\" height=\""+intImageHeight+"\" id=\"beginner_flash_id_"+kb_no+"\" name=\"beginner_flash_id_"+kb_no+"\" align=\"middle\" swLiveConnect=true allowScriptAccess=\"always\" type=\"application/x-shockwave-flash\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\" /></embed>";
                        html[hIdx++] ="</object>";
                    }else{
                        html[hIdx++] ="<img src=\"http://storage.enuri.info/pic_upload/termdictitle/"+strHeaderImage+"\" alt=\"\">";
                    }
                    html[hIdx++] ="</td>";
                }
                html[hIdx++] ="<td style=\"padding-left:9px\" valign=\"top\" class=\"kbnoDicContentTop\" id=\"kbnoDicContentTop"+kb_no+"\" strHeaerTitle=\""+strHeaerTitle+"\" intKtt_readcnt=\""+intKtt_readcnt+"\" intImport=\""+intImport+"\">";
                html[hIdx++] = strHeaerDesc;
                html[hIdx++] ="</td>";
                html[hIdx++] ="</tr>";
                if(strHeaderOverDescBottom!=""){
                    html[hIdx++] ="<tr>";
                    html[hIdx++] ="<td "; if(strHeaderImage!=""){html[hIdx++] ="colspan=\"2\"";}html[hIdx++] =">";
                    html[hIdx++] = strHeaderOverDescBottom;
                    html[hIdx++] ="</td>";
                    html[hIdx++] ="</tr>";
                }
                html[hIdx++] ="</tbody></table>";
                if(specno>0){
                    html[hIdx++] ="<button class=\"dic-cont__more\" onclick=\"window.open('/list.jsp?cate="+$("#TERMDICLAYER").data("cate").substring(0,4)+"&spec="+specno+"')\" >해당상품 모아보기</button>";
                }
            }   
        });      
    }
    return html.join("");
}

//상세검색용
function lightTermdic(obj){
    var kbnos =  $(obj).data("kbno");
    var cate = gCate;
    var param = {
        "procType" : 2,
        "cate" : cate,
        "kbnos" : kbnos,
    };
    var lightTermicPromise = $.ajax({
        type: "get",
        url: "/wide/api/termdicData.jsp",
        data: param,
        dataType: "json"
    });
    lightTermicPromise.then(function(result){
        drawlightTermdic(result);
        $("#TERMDICLAYER").addClass("dic--light");
        $("#TERMDICLAYER").show().css({
            "position" : "absolute",
            "top" : $(obj).offset().top - 80,
            "left" : "50%",
            "transform" : "translateX(-50%)",
            "z-index" : 10
        });
    });
}

function stopYoutube(){
    if($("#THUMNAILLAYER .enlarge__view--movie iframe").length > 0){
        $("#THUMNAILLAYER .enlarge__view--movie iframe").each(function(i,v) { 
            v.contentWindow.postMessage('{"event":"command","func":"stopVideo","args":""}','*');
        });
    }
}