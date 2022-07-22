import * as prodOption from "./prod_option.js";
import * as prodShopPrice from "./prod_shopprice.js";
import * as prodPriceComp from "./prod_pricecomp.js";
import * as prodRecomm from "./prod_recomm.js";
import * as prodReview from "./prod_review.js";
import * as prodCompSpec from "./prod_compspec.js";
import * as prodBbs from "./prod_bbs.js";
import * as prodGraph from "./prod_graph.js";
import * as prodDesc from "./prod_desc.js";
import * as prodQna from "./prod_qna.js";
import * as prodCate from "./prod_cate.js";
import * as prodCommon from "./prod_common.js";

$(function(){
    loadNav(gModelData.gCategory);
    
    init(false);

    // 탭 이동, 활성화
    var $pTabItem = $(".prodtab__item"); // 탭 li

    $pTabItem.find(".tab__link").on("click", function(e){
        var _this = $(this);
        var objId = _this.attr("href"); // 이동할 탭 아이디
        var objPosTop = $(objId).offset().top; // 탭 위치 
        var fixedInfo_H = $(".prodtabinfo").outerHeight(); // fixed된 상품 정보 높이
        var fixedTab_H = $(".prodtab").outerHeight(); // fixed된 탭 높이

        /* $pTabItem.removeClass("is-on");
        _this.parents("li").addClass("is-on"); */
        
        $(window).scrollTop(objPosTop - fixedInfo_H - fixedTab_H - 32)

        e.preventDefault();
    })
                       
    // 상단요약 좌측 > 썸네일 목록 스와이퍼 생성
    var prodinfoThumLength = $(".thum__slide .thum__list > li").length;

    if(prodinfoThumLength > 3){
        var prodinfoThum = $(".thum__slide");
            prodinfoThum.addClass("is-swiper");
    }else{
        prodinfoSwipe.destroy(false,true);
    }
    var specLength = $(".specswipe .specswipe__item > li").length;  // 사양 전체갯수
                                            
    if(specLength > 5){
        var specState = $(".proddetail__spec");
        specState.addClass("is-swiper");
        $(".proddetail__spec .swiper-pagination").removeClass('swiper-pagination-hidden');
        $(".proddetail__spec .btn__more").show();
    }else{
       // prodspecSwipe.destroy(false,true);
        $(".proddetail__spec .swiper-pagination").addClass('swiper-pagination-hidden');
        $(".proddetail__spec .btn__more").hide();
    }
    // 상단요약 좌측 > 이미지 컨트롤
    var $thum_cont = $(".proddetail .thum__cont .thum__img > img"),    // 썸네일 큰 이미지
        $thum_item = $(".proddetail .thum__list > li"),     // 썸네일 작은 이미지 목록
        _btnVodIdx = 1; // VOD 일 때, 스와이퍼 인덱스 

    $thum_item.on("mouseenter", function(){
        var _this = $(this),
            thumSrc = _this.find("img").attr("src");
            
        $thum_item.removeClass("is-on");
        _this.addClass("is-on");
        
        if(_this.hasClass("has-vod")){ // VOD 썸네일일때
            $thum_cont.closest(".thum__cont").addClass("is-vod");
        }else{
            $thum_cont.closest(".thum__cont").removeClass("is-vod");
        }
        $thum_cont.attr({"src": thumSrc});                                                    
    }).on("click", function(){
        var __idx = $(this).index(); // 클릭 index
        loadThumNail(gModelData.gModelno,__idx);
       
    });
    
   $('.vip__top .btn__declaration').click(function(){
        prodCommon.declaration.layerDeclaration();
    });

    setTimeout(function(){
        $("#prod_summary_top, #prod_topfix").find(".btn__alarm").siblings(".lay-tooltip").fadeOut();
    }, 1000);
    
    $(window).on("scroll",stickyProdTab);
    $("#prod_shopprice").find(".m_price__toggle .toggle__chk").on("click",function(){
        if ($(this).hasClass("is-off")) {
            $(this).removeClass("is-off");
            $(this).addClass("is-on");
            if ($(this).hasClass("card")) {
                prodShopPrice.paramHandler.set("card", "Y");
                prodPriceComp.paramHandler.set("card", "Y");
                insertLogLSV(18626,`${gModelData.gCategory}`,`${gModelData.gModelno}`);
                ga('send','event','vip','summary_sort','creditpromotion');
            }
            if ($(this).hasClass("delivery")) {
                prodShopPrice.paramHandler.set("delivery", "Y");
                prodOption.paramHandler.set("delivery", "Y");
                prodPriceComp.paramHandler.set("delivery", "Y");
                insertLogLSV(18625,`${gModelData.gCategory}`,`${gModelData.gModelno}`);
                ga('send','event','vip','summary_sort','shipping');
            }
        } else {
            $(this).addClass("is-off");
            $(this).removeClass("is-on");
            if ($(this).hasClass("card")) {
                prodShopPrice.paramHandler.set("card", "");
                prodPriceComp.paramHandler.set("card", "N");
            }
            if ($(this).hasClass("delivery")) {
                prodShopPrice.paramHandler.set("delivery", "");
                prodOption.paramHandler.set("delivery", "");
                prodPriceComp.paramHandler.set("delivery", "N");
            }
        }
        prodShopPrice.paramHandler.set("callcnt", 1);
    });
    $("#prod_shopprice").find(".m_price__sort input").on("click",function(){
        if ($(this).is(":checked")) {
            if ($(this).data("sort") === 'card') {
                prodShopPrice.paramHandler.set("card", "Y");
                prodPriceComp.paramHandler.set("card", "Y");
                insertLogLSV(18626,`${gModelData.gCategory}`,`${gModelData.gModelno}`);
                ga('send','event','vip','summary_sort','creditpromotion');
            }
            if ($(this).data("sort") === 'delivery') {
                prodShopPrice.paramHandler.set("delivery", "Y");
                prodOption.paramHandler.set("delivery", "Y");
                prodPriceComp.paramHandler.set("delivery", "Y");
                insertLogLSV(18625,`${gModelData.gCategory}`,`${gModelData.gModelno}`);
                ga('send','event','vip','summary_sort','shipping');
            }
        } else {
            if ($(this).data("sort") === 'card') {
                prodShopPrice.paramHandler.set("card", "");
                prodPriceComp.paramHandler.set("card", "N");
            }
            if ($(this).data("sort") === 'delivery') {
                prodShopPrice.paramHandler.set("delivery", "");
                prodOption.paramHandler.set("delivery", "");
                prodPriceComp.paramHandler.set("delivery", "N");
            }
        }
        prodShopPrice.paramHandler.set("callcnt", 1);
    });
    
    $("#prod_pricecomp .sort_block .sort_chk input").off().on("click",function(){
        if($(this).is(':checked') === true){
            prodPriceComp.paramHandler.set(`${$(this).data('sort')}`, 'Y');
            prodShopPrice.paramHandler.set(`${$(this).data('sort')}`, 'Y');
            prodOption.paramHandler.set(`${$(this).data('sort')}`, 'Y');
        }else{
            prodPriceComp.paramHandler.set(`${$(this).data('sort')}`, 'N');
            prodShopPrice.paramHandler.set(`${$(this).data('sort')}`, 'N');
            prodOption.paramHandler.set(`${$(this).data('sort')}`, 'N');
        }
        /* ($(this).is(':checked') === true)
        ? prodPriceComp.paramHandler.set(`${$(this).data('sort')}`, 'Y')
        : prodPriceComp.paramHandler.set(`${$(this).data('sort')}`, 'N'); */

        /*로그 정리되면 수정*/
        if($(this).data('sort') === "delivery"){
            insertLogLSV(14502,`${gModelData.gCategory}`,`${gModelData.gModelno}`);
        }else if($(this).data('sort') == "card"){
            insertLogLSV(14504,`${gModelData.gCategory}`,`${gModelData.gModelno}`);
        }
    });
});
// 상단요약 좌측 > 썸네일 목록 스와이퍼 생성
var prodinfoSwipe = new Swiper('.thum__slide .swiper-container', {
           centeredSlides: false,
           slidesPerView: 4,
           spaceBetween: 4,
           grabCursor: true,
           prevButton : '.thum__slide .arr-prev',
           nextButton : '.thum__slide .arr-next',
       });
var prodspecSwipe = new Swiper('.proddetail__spec .specswipe', {
           scrollbarHide: false,
           slidesPerView: "auto",
           centeredSlides: false,
           spaceBetween: 0,
           initialSlide: 0,
           adaptiveHeight:true,
           grabCursor: false,
           prevButton : '.proddetail__spec .arr-prev',
           nextButton : '.proddetail__spec .arr-next',
           pagination: '.swiper-pagination'
       });

var stickyProdTab = function(){      
    var vTab = $(".prodtab"); // 탭 WRAP
    var vTabItem = $(".prodtab__item:not(.prodtab__item[style*='display:none'])"); // 탭 LI
    var vTab_top = $(".prodtabbox").offset().top - 90; // 탭 + 상품정보 첫 위치
    var vTab_height = Math.ceil($(vTab).outerHeight() + $(".prodtabinfo").outerHeight() + 34); // 탭 + 상품정보 높이
    var scrTop = Math.ceil($(window).scrollTop()); // 현재 scroll 위치
    var vtabContents = $(".tab__scroll:not(.tab__scroll[style*='display:none'])"); // 각 탭 컨텐츠 스크롤 지점
    $("header").removeClass("is--sticky is--show");
    // 탭 FIXED
    if(scrTop > vTab_top){
        if(!vTab.hasClass("is-fixed")){
            vTab.addClass("is-fixed");
            $(".prodtabinfo").addClass("over_bar_price");
            $(".wing").addClass("is--over_bar")
        }
    }else{
        if(vTab.hasClass("is-fixed")){
            vTab.removeClass("is-fixed");
            $(".prodtabinfo").removeClass("over_bar_price");
            $(".wing").removeClass("is--over_bar")
        }
    }
    // 스크롤 위치에 따른 탭 활성화
    $.each(vtabContents, function (idx, item) {                    
        var $target = vtabContents.eq(idx),
        targetTop = Math.ceil($target.offset().top - vTab_height);
        if (targetTop < scrTop) {
            vTabItem.removeClass('is-on');
            vTabItem.eq(idx).addClass('is-on');
        }
    });
    
};
$(window).on("load",function(){
    stickyProdTab();
    if($("#prodDetail").find(".section__cont .specdetail .sd__container .sd__cont.is-shown .inner").height() >= 850){
        $("#prodDetail").find(".section__cont .specdetail .btn__group").show();
    }else{
        $("#prodDetail").find(".section__cont .specdetail .btn__group").hide();
    }
    $("#prod_bbs_top").find(".btn.btn__more").unbind().click(function(){
        $(window).scrollTop( $("#prodReview").offset().top - $(".prodtabinfo").outerHeight() - $(".prodtab").outerHeight() - 32);
    });
    $(".proddetail__spec .btn__more").unbind().click(function(){
        $(window).scrollTop( $("#prodDetail").offset().top - $(".prodtabinfo").outerHeight() - $(".prodtab").outerHeight() - 32);
    });

   /*  if(focusName=="bbs"){
        setTimeout(function(){
            $(window).scrollTop( $("#prodReview").offset().top - $(".prodtabinfo").outerHeight() - $(".prodtab").outerHeight() - 32);
        },1000);
    } */
})

// Mutation Observer
// 감시 대상 node 선택
let target = $("#prod_option")[0];

// 감시자 인스턴스 만들기+
let observer = new MutationObserver((mutations) => {
    // 노드가 변경 됐을 때의 작업
    $("#prod_topfix .prodtabinfo .select-box__list li, #prod_option .pricecomp__list[class*='is-col'] li, #prod_option .compare_price__list li, #prod_option_top .buyopt__list li").click(function(e){
        if($(this).data("modelno") != gModelData.gModelno){
            var modelno = $(this).data("modelno");
            gModelHandler.set("gModelno",modelno);
        }
    });
    //observer.disconnect();
})

// 대상 노드에 감시자 전달
observer.observe(target, {
    //attributes: true,
    //attributeFilter: ["style"]
    subtree : true,
    childList: true,
    //characterData: true
});

export const gModelHandler = {
    set: (prop, value) => {
        gModelData[prop] = value;
        init(true);
        return true;
        },
    get : (prop) => {
        return gModelData[prop];
    }
};
const init = async (reInit = false ) => {
    $(".comm-loader").show();

    if(reInit){       //비동기 상단 세팅
       await prodModelInitPromise().then(prodModelInitView);
    }
    
    if(gModelData.gCdateView=="출시예정"){  //출시예정
        $("#prod_top_right_except").show();
        $("#prod_top_left_except").show();
        $("#prod_comp_except").show();
    }else {                                
        if(gModelData.gMallCnt == 0){        //일시품절
            $("#prod_top_left_except").show();
            $("#prod_comp_except").show();
        }else {                             //상품존재
            if(!reInit){
                await prodOption.optionPromise().then(prodOption.prodOptionViewTop)
                .then(prodOption.prodOptionViewTopFix)
                .then(prodOption.prodOptionView);
            }
            await prodShopPrice.shopPricePromise().then(prodShopPrice.prodShopPriceView)
                                                  .catch((err) => {
                                                    console.log(err);
                                                  });
            if( (gModelData.gCate4 == "1459" ||
                gModelData.gCate4 == "1203" || 
                gModelData.gCate4 == "1205" ||
                gModelData.gCate4 == "1219" || 
                gModelData.gCate4 == "1242" || 
                gModelData.gCate4 == "1254") && prodShopPrice.cardshop_check){
                    prodPriceComp.paramHandler.set("card","Y");
                }else{
                    prodPriceComp.paramHandler.set("sort","price");
                }

        }
      
    }
    prodGraph.graphPromise().then(prodGraph.prodGraphView);

    getPowerLink("VIP",gModelData.gCategory,"");
    fnEbayVip(gModelData.gModelno);

    prodCommon.prodBannerPromise("mid");
    prodCate.catePromise.caution().then(prodCate.prodCateView.caution);

    if (gModelData.gCate4=="0860"
    || gModelData.gCate4=="0801"
    || gModelData.gCate4=="0805"
    || gModelData.gCate4=="0809"
    || gModelData.gCate4=="0812"
    || gModelData.gCate4=="0802"
    || gModelData.gCate4=="0814"
    || gModelData.gCate4=="0806"
    || gModelData.gCate4=="0807"
    || gModelData.gCate4=="0803"
    || gModelData.gCate4=="0804"
    || gModelData.gCate4=="1654") {
        prodCate.catePromise.cos().then(prodCate.prodCateView.cos);
    }

    if (gModelData.gCate4=="1201" || gModelData.gCate4=="1202") {
        prodCate.catePromise.furniture().then(prodCate.prodCateView.furniture);
    }
    
    if (gModelData.gCate4=="0304" || gModelData.gCate4=="0305") {
        prodCate.catePromise.mobile().then(prodCate.prodCateView.mobile);
    }
    prodBbs.bbsView();

    prodQna.qnaPromise.qnaList().then(prodQna.qnaView);

    prodReview.reviewPromise.zum().then(prodReview.prodReviewZum);
    prodReview.reviewPromise.knowcom().then(prodReview.prodReviewKnow);
    
    prodRecomm.recommPromise().then(result => {
        prodRecomm.prodRecommViewTable(result);
        prodRecomm.prodRecommViewList(result);
    });
    if(gModelData.gCompare) await prodCompSpec.prodCompspecViewTab();
    
    prodDesc.descPromise().then(prodDesc.prodDescView).finally(()=>{
        if(focusName=="bbs"){
            setTimeout(function(){
                $(window).scrollTop( $("#prodReview").offset().top - $(".prodtabinfo").outerHeight() - $(".prodtab").outerHeight() - 32);
            },1000);
        }
    });


    $(".comm-loader").hide();
};

const prodModelInitPromise = () => {
    return new Promise((resolve,reject) => {
        $.ajax({
            type: "post",
            url: "/wide/api/product/prodInit.jsp",
            data: {"modelno" : gModelData.gModelno},
            dataType: "json",
            success: (response) => {
                resolve(response);
            }, error : (error) => {
                reject(error);
            }
        });
    });
}
const prodModelInitView = (json) => {
    if(json.success){
        Object.assign(gModelData,json.data.gModelData);
        history.replaceState(null, null, "/detail.jsp?modelno=" + gModelData.gModelno); //주소강제 변환
        //메타데이터
        if(json.data.gMetaData){
            const gMetaData = json.data.gMetaData;

            $("title").text(gMetaData.metaTitle);

            $("meta[name=description]").attr('content',`${gModelData.gModelNmView} 최저가 - ${gMetaData.metaKeyword}`);
            $("meta[name=keywords]").attr('content',`${gModelData.gModelNmView} 최저가 - ${gMetaData.metaKeyword}`);

            $("meta[property='og:title']").attr('content',gMetaData.metaCateName);
            $("meta[property='twitter:title']").attr('content',gMetaData.metaCateName);
            $("meta[property='me2:title']").attr('content',gMetaData.metaCateName);

            $("meta[property='og:description']").attr('content',gModelData.gModelNmView);
            $("meta[property='twitter:description']").attr('content',gModelData.gModelNmView);
            $("meta[property='me2:description']").attr('content',gModelData.gModelNmView);
        }
        if(json.data.gModelData.gSpecList){

            let specHtml ="";
            let specList = json.data.gModelData.gSpecList;
            if(specList != null){
                let specContentView ="";
                let specTitleView = "";
                let liCnt = 0;
                for(let i=0; i<specList.length;){
                    let specCellcnt = specList[i].cellcnt;
                    if(liCnt%5==0){
                        specHtml+=`<ul class="swiper-slide specswipe__item">`;
                    }
                    if(specCellcnt > 1){
                        let j=0;
                        specTitleView = specList[i].title;
                        specContentView = "";
                        for(j=0;j<specCellcnt;j++){
                            if(j>0) specContentView +=",";
                            
                            specContentView += specList[i+j].content;
                        }
                        i += j;
                    }else{
                        specContentView = specList[i].content;
                        specTitleView = specList[i].title;
                        i++;
                    }
                    specHtml+=`<li>
                                <span class="tx_spec">${specTitleView}</span>
                                <span class="tx_detail">${specContentView}</span>
                               </li>`; 
                    liCnt++;
                    if(liCnt%5==0){
                        specHtml += `</ul>`;
                    }
                }
                $("#prod_summary_left").find(".proddetail__spec .swiper-wrapper").html(specHtml);
            }
        }
        let thumHtml =`<li class="swiper-slide"><button type="button" class="btn btn--modal"><img src="${gModelData.gImageUrl}" alt="${gModelData.gModelNmView}" /></button></li>`;
        if(json.data.gModelData.gVideoList){
            let gVideoList = json.data.gModelData.gVideoList;
            $.each(gVideoList, function(index,listData){
                let strSource = listData.video_url;
                let strVideoThum = "";
                if(strSource.indexOf("youtu.be") > 0 || strSource.indexOf("youtube") > 0){
                    let srcIndex = strSource.lastIndexOf("/");
                    let descIndex = 0;
                    if(strSource.lastIndexOf("?list") > 0){
                        descIndex = strSource.lastIndexOf("?list"); 
                    } else if(strSource.lastIndexOf("?autoplay") > 0){
                        descIndex = strSource.lastIndexOf("?autoplay"); 
                    } else{
                        descIndex = strSource.length; 
                    }
                    strVideoThum = strSource.substring(srcIndex+1,descIndex);
                }
                thumHtml += `<li class="swiper-slide has-vod"><span class="dimm"></span><button type="button" class="btn btn--modal"><img src="//img.youtube.com/vi/${strVideoThum}/hqdefault.jpg" alt="" /></button></li>`;
            });
        }
        if(json.data.gModelData.gThumNailList){
            let gThumNailList = json.data.gModelData.gThumNailList;
            $.each(gThumNailList,(index,listData)=>{
                thumHtml += `<li class="swiper-slide"><button type="button" class="btn btn--modal"><img src="${listData}" alt="${gModelData.gModelNmView}" /></button></li>`;
            });
        }
        $("#prod_topfix").find(".prodtabinfo__lt .prod__thum").html(`<img src="${gModelData.gImageUrl}" alt="${gModelData.gModelNmView}" />`);
        $("#prod_summary_left").find(".proddetail .thum__slide .swiper-wrapper.thum__list").html(thumHtml);
        $("#prod_summary_left").find(".proddetail .thum__cont .thum__img").html(`<img src="${gModelData.gImageUrl}" alt="${gModelData.gModelNmView}" />`)
         //탑픽스, 썸네일,대표 이미지 온에러 처리 
        $("#prod_topfix").find(".prodtabinfo__lt .prod__thum img").on("error",function(e){
            e.preventDefault();
            replaceImg(this)
        })

        $("#prod_summary_left").find(".proddetail .thum__slide .swiper-wrapper.thum__list img").on("error",function(e){
            e.preventDefault();
            replaceImg(this)
        });
        $("#prod_summary_left").find(".proddetail .thum__cont .thum__img img").on("error",function(e){
            e.preventDefault();
            replaceImg(this)
        });
        
        // 상단요약 좌측 > 이미지 컨트롤
        prodinfoSwipe.update();
        // prodspecSwipe.slideTo(0);
        if($(".thum__slide .thum__list > li").length > 3){
            $(".thum__slide").addClass("is-swiper");
        }else{
            $(".thum__slide").removeClass("is-swiper");
        }
        prodspecSwipe.update();
        if($(".specswipe .specswipe__item > li").length > 5){
            $(".proddetail__spec").addClass("is-swiper");
            $(".proddetail__spec .swiper-pagination").removeClass('swiper-pagination-hidden');
            $(".proddetail__spec .btn__more").show();
            prodspecSwipe.slideTo(0);
        }else{
            $(".proddetail__spec").removeClass("is-swiper");
            $(".proddetail__spec .swiper-pagination").addClass('swiper-pagination-hidden');
            $(".proddetail__spec .btn__more").hide();
            prodspecSwipe.slideTo(0);
        }
        
        var $thum_cont = $(".proddetail .thum__cont .thum__img > img"),    // 썸네일 큰 이미지
        $thum_item = $(".proddetail .thum__list > li")     // 썸네일 작은 이미지 목록
        $thum_item.on("mouseenter", function(){
            var _this = $(this),
                thumSrc = _this.find("img").attr("src");
                
            $thum_item.removeClass("is-on");
            _this.addClass("is-on");
            
            if(_this.hasClass("has-vod")){ // VOD 썸네일일때
                $thum_cont.closest(".thum__cont").addClass("is-vod");
            }else{
                $thum_cont.closest(".thum__cont").removeClass("is-vod");
            }
            $thum_cont.attr({"src": thumSrc});                                                    
        }).on("click", function(){
            var __idx = $(this).index(); // 클릭 index
            loadThumNail(gModelData.gModelno,__idx);
            insertLog(24448);
        });
        
        prodPriceComp.paramHandler.init();
        prodShopPrice.paramHandler.init();
        prodGraph.paramHandler.init();
        prodOption.paramHandler.init();
        prodDesc.paramHandler.init();
        
      
        ga('create', 'UA-53076228-1', 'auto');
        ga('require', 'displayfeatures');
        ga('require', 'linkid', 'linkid.js');
        ga('send', 'pageview');

        
        $("#prod_summary_top").find(".prodinfo .prodinfo__tit").html(gModelData.gModelNmViewTag);
        $("#prod_summary_top").find(".prodinfo .prodinfo__spec").html(`  
        ${gModelData.gFactory !="" && gModelData.gFactoryCheck ? `<li>제조사: ${gModelData.gFactory}</li>` : ``}
        ${gModelData.gBrand !="" && gModelData.gBrandCheck ? `<li>브랜드: ${gModelData.gBrand}</li>` : ``}
        ${gModelData.gCdateView !="" ? `<li>${gModelData.gCdateView}</li>` : `<li>등록일: ${gModelData.gCdate}</li>`}
        ${gModelData.gReleasePrice > 0 ? `<li>${gModelData.gReleaseText}</li>` : ``}`);
        
        //상단 세팅
        if(gModelData.gMinPrice > 0){

            $("#prod_summary_top").find(".prodminprice .box__line1 .tx_msg").html(` 
            ${gModelData.gOvsMinPrcYn=="Y" ? `직구` : `` }
            ${gModelData.gCashShopOnly ? `현금` : `` } 최저가`);

            $("#prod_summary_top").find(".prodminprice .box__line2 .tx_price").html(`<em>${gModelData.gMinPrice.format()}</em>원`);
            if(gModelData.gMinPrice > 1000 && gModelData.gRewardRate > 0) {
                let t = (Math.floor(gModelData.gRewardRate  * 0.01 * gModelData.gMinPrice / 10) * 10);
                $("#prod_summary_top").find(".prodminprice .area_noti_savemoney .spSaveMoney").html(`${t.format()}적립`);
                $("#prod_summary_top").find(".prodminprice .area_noti_savemoney").show();
                if(gModelData.gMinShopCode == 6641){
                    $("#prod_summary_top").find(".btn_open_layer_noti_save .appBuyFlag").hide();
                }else{
                    $("#prod_summary_top").find(".btn_open_layer_noti_save .appBuyFlag").show();
                }
            }else{
                $("#prod_summary_top").find(".prodminprice .area_noti_savemoney").hide();
            }
            //fix 세팅
            $("#prod_topfix").find(".prodtabinfo__lt .prod__name").html(gModelData.gModelNmView);
            $("#prod_topfix").find(".prodtabinfo__rt .tx_price").html(`
                        <span class="tx_msg">      
                                ${gModelData.gOvsMinPrcYn=="Y" ? `직구` : `` }
                                ${gModelData.gCashShopOnly ? `현금` : `` }
                                최저가
                        </span>
                        <em id="detail_minprice">${gModelData.gMinPrice.format()}</em>원`);
                                                    
        }else{
            if(gModelData.gCdateView =="출시예정"){
                $("#prod_exception").html(`<p class="tx_exception"><strong>출시예정</strong> 상품입니다.</p>`);
            }else{
                $("#prod_exception").html(`<p class="tx_exception"><strong>일시품절</strong> 상품입니다.</p>`);
            }
        }
        
        $('#txtURL').text(location.href);

        if(blCriteo){
            window.criteo_q = window.criteo_q || [];
            window.criteo_q.push(
                    { event: "setAccount", account: 17070 },
                    { event: "setSiteType", type: "d" },
                    { event: "viewItem", item: `${gModelData.gModelno}` }
            );
        }
        gModelData.blHitBrandCheck ? $(".hit_stamp").show() :  $(".hit_stamp").hide();

        _TRK_PN = gModelData.gModelNmView.trim();
        _trk_img_base.src = _trk_make_code("log.enuri.com", "1001");
    }
}