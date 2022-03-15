let bbsImageList = new Object();
let minReviewCheck = 202106111600;
let maxReviewCheck = 202106120400;
const param = {
    pType: "GL",
    idx: 0,
    modelno: gModelData.gModelno,
    cate: gModelData.gCategory,
    point: 0,
    isphoto: "",
    shopcodes: "",
    word_code: "",
    page: 1,
    pagesize: 5
};

export const paramHandler =  {
    set: (prop, value) => {
        if(prop=="point"){
            param["word_code"] = "";
        }
        if (prop != "page") {
            param["page"] = 1;
        } 
        param[prop] = value;
        bbsPromise.bbsList().then(bbsListView).finally( () => {
            $(".reviewall__loader").css({"position":"absolute"}).hide(); // 로더 숨김
            $(".reviewall__item").show(); // 로딩 후 상품평 목록 노출
        });
        return true;
    },
    get: (prop) => {
        return param[prop];
    }
};
export const bbsPromise = {
    chartParam: {},
    filterParam: {},
    topParam: {},
    imageParam: {},
    detailParam: {},
    shopParam : {},
    registParam : {},
    deleteParam : {},
    bbsTop: function () {
        this.topParam = {
            pType: "GT",
            modelno: gModelData.gModelno
        }
        return new Promise((resolve, reject) => {
            $.ajax({
                type: "POST",
                url: "/wide/api/product/prodBbsList.jsp",
                data: this.topParam,
                dataType: "JSON",
                success: (result) => {
                    resolve(result);
                },
                error: (err) => {
                    reject(err);
                }
            })
        });
    },
    bbsChart: function () {
        this.chartParam = {
            pType: "GB",
            modelno: gModelData.gModelno
        }

        return new Promise((resolve, reject) => {
            $.ajax({
                type: "POST",
                url: "/wide/api/product/prodBbsList.jsp",
                data: this.chartParam,
                dataType: "JSON",
                success: (result) => {
                    resolve(result);
                },
                error: (err) => {
                    reject(err);
                }
            })
        });
    },
    bbsFilter: function () {
        this.filterParam = {
            modelno: gModelData.gModelno,
            cate: gModelData.gCategory
        }
        return new Promise((resolve, reject) => {
            $.ajax({
                type: "POST",
                url: "/wide/api/product/prodCommentFilering.jsp",
                data: this.filterParam,
                dataType: "JSON",
                success: (result) => {
                    resolve(result);
                },
                error: (err) => {
                    reject(err);
                }
            })
        });
    },
    bbsList: function () {
        return new Promise((resolve, reject) => {
            $.ajax({
                type: "POST",
                url: "/wide/api/product/prodBbsList.jsp",
                data: param,
                dataType: "JSON",
                beforeSend : () =>{
                    $(".reviewall__loader").siblings().remove();
                    $(".reviewall__loader").css({"position":""}).show();
                },
                success: (result) => {
                    resolve(result);
                },
                error: (err) => {
                    reject(err);
                }
            })
        });
    },
    bbsImageList: function () {
        this.imageParam = {
            pType: "PT",
            modelno: gModelData.gModelno
        }
        return new Promise((resolve, reject) => {
            $.ajax({
                type: "POST",
                url: "/wide/api/product/prodBbsList.jsp",
                data: this.imageParam,
                dataType: "JSON",
                success: (result) => {
                    resolve(result);
                },
                error: (err) => {
                    reject(err);
                }
            })
        });
    },
    bbsDetail: function (idx = 0, no=0) {
        this.detailParam = {
            pType: "MD",
            modelno: gModelData.gModelno,
            idx: idx,
            no : no
        }
        return new Promise((resolve, reject) => {
            $.ajax({
                type: "POST",
                url: "/wide/api/product/prodBbsList.jsp",
                data: this.detailParam,
                dataType: "JSON",
                success: (result) => {
                    resolve(result);
                },
                error: (err) => {
                    reject(err);
                }
            })
        });
    },
    bbsShopList : function (){
        this.shopParam = {
            pType: "SL",
            modelno: gModelData.gModelno
        }
        return new Promise((resolve, reject) => {
            $.ajax({
                type: "POST",
                url: "/wide/api/product/prodBbsList.jsp",
                data: this.shopParam,
                dataType: "JSON",
                success: (result) => {
                    resolve(result);
                },
                error: (err) => {
                    reject(err);
                }
            })
        });
    },
    bbsRegist : function(text){
        this.registParam = {
            pType: "GI",
            modelno: gModelData.gModelno,
            contents : text
        }  
        return new Promise((resolve, reject) => {
            $.ajax({
                type: "POST",
                url: "/wide/api/product/prodBbsList.jsp",
                data: this.registParam,
                dataType: "JSON",
                success: (result) => {
                    resolve(result);
                },
                error: (err) => {
                    reject(err);
                }
            })
        });
    },
    bbsDelete : function(modelno,no,delpass){
        this.deleteParam = {
            pType: "GD",
            modelno: modelno,
            no : no,
            delpass : delpass
        }  
        return new Promise((resolve, reject) => {
            $.ajax({
                type: "POST",
                url: "/wide/api/product/prodBbsList.jsp",
                data: this.deleteParam,
                dataType: "JSON",
                success: (result) => {
                    resolve(result);
                },
                error: (err) => {
                    reject(err);
                }
            })
        });
    }
}
export const bbsView = () => {
    bbsPromise.bbsChart().then(bbsChartView);
    if(blAdultCate && blAdult || !blAdultCate){
        if(gModelData.gBbsNum > 0){
            bbsPromise.bbsTop().then(bbsTopView);
            bbsPromise.bbsFilter().then(bbsFilterView);
            bbsPromise.bbsList().then(bbsListView).finally( () => {
                $(".reviewall__loader").css({"position":"absolute"}).fadeOut(); // 로더 숨김
                $(".reviewall__item").show(); // 로딩 후 상품평 목록 노출
            });
            bbsPromise.bbsImageList().then(bbsImageListView);
            $("#prod_image_bbs").show();
        }else{
            $("#prod_bbs_top").find(".preview__cont .preview__list li.no-data").show();
            $("#prod_bbs").find(".reviewall__item.no-data").show();
        }
        $("#prod_bbs").show();
    }else{
        $("#prod_bbs_top").find(".preview__cont .preview__list li.no-adult").show();
        $("#prod_bbs_exception").show();
        $("#prod_image_bbs").hide();
        $("#prod_bbs").hide();
    }
 
    $("#prod_bbs").find(".reviewwrite .reviewwrite__cont .btn__register").unbind().click(function(){
        let insertFlag = true;
		let nowDate = new Date().format("yyyyMMddhhmm")*1;
        if (!islogin()) {
            alert("로그인을 하시면 글을 작성할 수 있습니다.");
            return;
        } else if(nowDate >= minReviewCheck && nowDate <= maxReviewCheck) {		// 상품평 작성 점검
			alert("2021-06-11 16:00 ~ 2021-06-12 04:00 까지 상품평 작성 점검중입니다. ");
			return;
		} else {
            let textObj =$("#prod_bbs").find(".reviewwrite .reviewwrite__cont textarea");
            let text = textObj.val();
            if(!insertFlag){
                alert("등록중입니다. 잠시만 기다려주세요.");
                return;
            }
            
            if(text == "") {
                alert("내용을 입력해 주세요.");
                text.focus();
                return;
            }
            if(text.length >= 2000) {
                alert("2000자 이상은 입력 하실 수 없습니다.");
                text.focus();
                return;
            }
    
            if(text.length < 5) {
                alert("5자 이상 내용을 입력하셔야 등록이 가능합니다.");
                text.focus();
                return;
            }
            
            bbsPromise.bbsRegist(text).then( (result) => {
                if(result.success){
                    if(result.data.flag){
                        textObj.val("");
                        alert("정상적으로 저장 되었습니다.");   
                        
                        bbsPromise.bbsTop().then(bbsTopView);
                        bbsPromise.bbsList().then(bbsListView);

                        ++gModelData.gBbsNum;

                        $('#tabBbs .tab__link em').text(`(${gModelData.gBbsNum.format()})`);
                        $('#prod_bbs_top .preview__tit span').text(gModelData.gBbsNum.format());
                    }else{
                        alert("저장 실패 하였습니다.");
                    }
                }
                insertFlag = false;
            });
        }
    });
}
const bbsTopView = (json) => {
    if (json.success && json.total > 0) {
        let bbsTopData = json.data;
        let html = ``;
        if (bbsTopData.length > 0) {
            $.each(bbsTopData, (index, listData) => {
                let imgsrv_flg = listData.imgsrv_flg;
                let contents = listData.contents;
                let imgurl_org = listData.imgurl_org;
                let point = listData.point;
                let modelno = listData.modelno;
                let no = listData.no;
                let regdate = listData.regdate;
                let shopcode = listData.shopcode;
                let shopname = listData.shopname;
                let title = listData.title;
                let username = listData.username;
                let imglist = listData.imglist;

                html += `<li ${imgsrv_flg == "Y" ? `class="is-thum"` : `class="is-txt"`} data-idx="${listData.list_idx}">
                            ${imgsrv_flg == "Y" ? `<a href="javascript:void(0)" class="thum__link"><img src="${imgurl_org}" alt=""></a>` : ``} 
                            <div class="thum__info">
                                <a href="javascript:void(0);" class="tx_review">${contents}</a>
                                <div class="prodscope">
                                ${point > 0 ? ` <i class="ico ico--scope">
                                                    <span class="ico--scope-active" style="width:${point * 20}%;"></span>
                                                </i><p class="tx_aval">${point}</p>` : ``}
                                </div>
                                <p class="tx_source">
                                    <span>${shopname}</span><span class="user">${username}</span><span>${regdate}</span>
                                </p>
                            </div>
                        </li>`;
            });
        } 
        $("#prod_bbs_top").find(".preview__list").html(html);
        $("#prod_bbs_top").find(".preview__list li").unbind().click(function(){
            if($(this).hasClass("is-txt")){
                bbsTextDetailView(json.data[$(this).data("idx")-1]);
            }else{
                $("#PHOTOLAYER").data("idx", $(this).data("idx"));
                bbsDetailView(json);
            }
			insertLog(14487);
        });

        $("#prod_bbs_top").find(".preview__list li.is-thum img").on("error",function(){
            //a   console.log(json.data[vThisIdx])
            let vThisIdx= $(this).parents(".is-thum").data("idx");
            if(json.data[vThisIdx-1].imglist.length > 1){
                imgError(json.data[vThisIdx-1].imglist,this,1);
            }
        }); 
    }else if(json.total == 0){
        let html = `<li class="no-data" style="">
                        <p class="tx_msg">등록된 상품평이 없습니다.<br>상품평을 등록해주세요!</p>
                        <a href="javascript:void(0)" class="btn btn__write" onclick=" $('html,body').stop(true,false).animate({'scrollTop': $('#prodReview').offset().top - 150},500);"><span>상품평 쓰기</span></a> 
                    </li>`;

        $("#prod_bbs_top").find(".preview__list").html(html);
    }
    $("#prod_bbs_top").show();
}
const bbsChartView = (json) => {
    if (json.success) {
        let chartPointCnt = json.data.iBbs_point_cnt;
        let chartPointNum = json.data.iBbs_point_num;//bbs_num
        let chartData = json.data;
        let pointList = json.data.pointList;
        if (chartPointCnt > 0) {
            $("#prodReview").find(".section__cont .userpoint .tx_score strong").html(chartData.bbs_point_avg);
            $("#prodReview").find(".section__cont .userpoint .prodscope span").css("width", chartData.bbs_point_avg * 20 + "%");
            let maxPoint = 1;
            if (pointList.length > 0) {
                $.each(pointList, (index, listData) => {
                    if (listData.point <= 5) {
                        if (listData.pointCnt > maxPoint) {
                            maxPoint = listData.point;
                        }
                        let pointObj = $("#prodReview").find(".section__cont .userpoint .prodgraph--stick li[data-point=" + listData.point + "]");
                        $(pointObj).find(".tx_cnt").html(listData.pointCnt.format());
                        $(pointObj).find(".stick--gauge").css("height", listData.pointCnt / chartData.iBbs_point_cnt * 100 + "%");
                        $(`#prod_bbs .point__filter li[data-point="${listData.point}"]`).removeClass("is-disabled");
                        $(`#prod_bbs .point__filter li[data-point="${listData.point}"] .tx-num`).html(` (${listData.pointCnt.format()})`);
                    }
                });
                $("#prod_bbs_chart").find(".prodgraph--stick li[data-point=" + maxPoint + "]").addClass("is-on");
            }
        } else {
            $("#prod_bbs_chart").hide();
        }
        $("#prod_bbs").find(".reviewall__cont .reviewfilter .point__filter li").not(".is-disabled").click(function () {
            $("#prod_bbs").find(".reviewall__cont .reviewfilter .subject__filter ul li").removeClass("is-on");
            $("#prod_bbs").find(".reviewall__cont .reviewfilter .subject__filter ul li[data-code='']").addClass("is-on");
            $(this).siblings().removeClass("is-on");
            $(this).addClass("is-on");
            let point = $(this).data("point");
            
            paramHandler.set("point",point);
            insertLog(15940);
        });
    } else {
        $("#prod_bbs_chart").hide();
    }
}
const bbsFilterView = (json) => {
    if (json.success) {
        let bbsFilterList = json.data.bbsFilterList;
        let html = ``;
        if (bbsFilterList.length > 0) {
            insertLogLSV(26287,`${gModelData.gCategory}`,`${gModelData.gModelno}`);
            html +=`<li class="is-on" data-code=""><button type="button">주제전체</button></li>`;
            $.each(bbsFilterList, (index, listData) => {
                html += `<li data-code=${listData.word_code}><button type="button">${listData.word_name}</button></li>`;
            });
            $("#prod_bbs").find(".reviewall__cont .reviewfilter .subject__filter ul").html(html);
            $("#prod_bbs").find(".reviewall__cont .reviewfilter .subject__filter").show();

            $("#prod_bbs").find(".reviewall__cont .reviewfilter .subject__filter ul li").off().on("click",function () {
                insertLogLSV(26279,`${gModelData.gCategory}`,`${gModelData.gModelno}`);
                $(this).siblings().removeClass("is-on");
                $(this).addClass("is-on");
                let word_code = $(this).data("code");
                paramHandler.set("word_code",word_code);
            });
        } else {
            $("#prod_bbs").find(".reviewall__cont .reviewfilter .subject__filter").hide();
        }
    } else {
        $("#prod_bbs").find(".reviewall__cont .reviewfilter .subject__filter").hide();
    }
}
const bbsListView = (json) => {
    let html = ``;
    let bbsToTalCnt = json.iTotalCnt;
    let bbsList = json.list;
    $("#prod_bbs").find(".reviewall__head em.tx_cnt").html(`(${bbsToTalCnt.format()})`);
    if (bbsList.length > 0) {
        $.each(bbsList, (index, listData) => {
            let contents = listData.contents;
            let imgsrv_flg = listData.imgsrv_flg;
            let imgurl_org = listData.imgurl_org;
            let list_idx = listData.list_idx;
            let no = listData.no;
            let modelno = listData.modelno;
            let point = listData.point;
            let regdate = listData.regdate;
            let shop_code = listData.shop_code;
            let shop_name = listData.shop_name;
            let title = listData.title;
            let userid = listData.userid;
            let usernm = listData.usernm;
            let photo_list = listData.photo_list;
            let delbtn = listData.delbtn;
            html += `<li class="reviewall__item ${imgsrv_flg=="Y" ? `` : `is-text`} ">
                        <div class="col col--lt">
                            <div class="tx__source">
                                ${point > 0 ? `<div class="prodscope prodscope--14x">
                                                <i class="ico ico--scope">
                                                    <span class="ico--scope-active" style="width:${point * 20}%;"></span>
                                                </i>
                                                <p class="tx_aval">${point}</p>
                                            </div>` : ``}
                                <ul class="tx_info">
                                    <li>${shop_name}</li>
                                    <li>${usernm}</li>
                                    <li>${regdate}</li>
                                </ul>
                                ${delbtn ? `<div class="review__delete">
                                                <button type="button" class="btn btn-delete" data-no="${no}" data-modelno="${modelno}" >삭제하기</button>
                                                ${SNSTYPE == "" || SNSTYPE == "E" ?
                                                `<div id="boardDelLayer" class="smallbox boarddel" data-no="${no}"  data-modelno="${modelno}" style="display:none;">
                                                    <h5>
                                                        게시글을 삭제합니다. 비밀번호를 입력해주세요.
                                                        <a href="javascript:///" class="btnclose">닫기</a>
                                                    </h5>
                                                    <div class="inner">
                                                        <p class="pw">비밀번호</p>
                                                        <p><input type="password"><a class="btn_dis del">삭제</a></p>
                                                    </div>` : ``}
                                                </div>` : ``}
                            </div>
                            <button type="button" class="tx__link">${title}</button>

                            <span class="tx_sub">
                                ${contents}
                            </span>`;
            if (photo_list.length > 0) {
                html += `<div class="thumbox">`;
                $.each(photo_list, (index, listData) => {
                    html += `<span><img src="${listData}" alt="" onerror="this.style.visibility='hidden'"></span>`;
                });
                html += `</div>`;
            }
            html += `    </div>
                        <div class="col col--rt">
                        ${imgsrv_flg=="Y" ? ` <a href="javascript:void(0)" class="thum__link">
                                                <img src="${imgurl_org}" alt="">
                                                ${photo_list.length > 1 ? `<span class="tx_cnt">+${photo_list.length}</span>` : ``}
                                            </a>` : ``}
                        ${contents.length<=120 && imgsrv_flg!="Y" ? `` :`<button type="button" class="btn btn__more">상품평 펼치기</button>`}
                        </div>
                    </li>`
        });
        $("#prod_bbs").find(".reviewall__cont .reviewall__list").append(html);
        $("#prod_bbs").find(".abs--right .reviewall__onlyphoto .toggle__chk").unbind().click(function () {
            if ($(this).hasClass("is-off")) {
                $(this).removeClass("is-off").addClass("is-on");
                paramHandler.set("isphoto","Y");
            } else {
                $(this).removeClass("is-on").addClass("is-off");
                paramHandler.set("isphoto","");
            }
			insertLog(24453);
        });
        $("#prod_bbs").find(".reviewall__cont .reviewall__list .reviewall__item .col.col--rt img").on("error",function(){
            let vThisIdx= $(this).parents(".reviewall__item").index();
            if(bbsList[vThisIdx-1].photo_list.length > 1){
                imgError(bbsList[vThisIdx-1].photo_list,this,1);
            }
        }); 
        // 상품평 접기/펼치기
        $("#prod_bbs").find(".reviewall__item").click(function(e){
            if($(this).find(".btn__more").length > 0){
                $(this).closest(".reviewall__item").toggleClass("is-unfold");
                
                if($(this).closest(".reviewall__item").hasClass("is-unfold")){                       
                    $(this).find(".btn__more").text("상품평 닫기");
                }else{
                    $(this).find(".btn__more").text("상품평 펼치기");
                    $("html,body").stop(true,false).animate({"scrollTop": $("#prod_bbs .reviewall__head").offset().top - 150},500);
                }
                insertLog(24454);
            }
        });
        $("#prod_bbs").find(".reviewall__list .reviewall__item .btn-delete").unbind().click(function(e){
			let nowDate = new Date().format("yyyyMMddhhmm")*1;
			if(nowDate >= minReviewCheck && nowDate <= maxReviewCheck) {		// 상품평 작성 점검
				alert("2021-06-11 16:00 ~ 2021-06-12 04:00 까지 상품평 작성 점검중입니다. ");
				return;
			}
            let delno = $(this).data("no");
            let delmodelno = $(this).data("modelno");
            if(SNSTYPE == "" || SNSTYPE == "E"){
                $("#boardDelLayer").show();
            }else{
                bbsPromise.bbsDelete(delmodelno,delno,'').then((result)=>{
                    if(result.success){
                        if(result.data.flag){
                            alert("선택하신 글이 삭제되었습니다.");
                            
                            bbsPromise.bbsTop().then(bbsTopView);
                            bbsPromise.bbsList().then(bbsListView);

                            --gModelData.gBbsNum;
                            
                            (gModelData.gBbsNum == 0)
                            ? $('#tabBbs .tab__link em').text('')
                            : $('#tabBbs .tab__link em').text(`(${gModelData.gBbsNum.format()})`);

                            $('#prod_bbs_top .preview__tit span').text(gModelData.gBbsNum.format());
                        }else{
                            if(!result.data.passflag){
                                alert("비밀번호가 정확하지 않습니다.");
                            }
                        }
                    }
                });
            }
            e.stopPropagation();
        });
        $("#prod_bbs").find(".reviewall__list .review__delete .smallbox.boarddel .btn_dis.del").unbind().click(function(){
            let delno = $(this).parents(".smallbox.boarddel").data("no");
            let delmodelno = $(this).parents(".smallbox.boarddel").data("modelno");
            let delPass = $(this).siblings("input").val();
            bbsPromise.bbsDelete(delmodelno,delno,delPass).then((result)=>{
                if(result.success){
                    if(result.data.flag){
                        alert("선택하신 글이 삭제되었습니다.");
                        
                        bbsPromise.bbsTop().then(bbsTopView);
                        bbsPromise.bbsList().then(bbsListView);

                        --gModelData.gBbsNum;
                        
                        (gModelData.gBbsNum == 0)
                        ? $('#tabBbs .tab__link em').text('')
                        : $('#tabBbs .tab__link em').text(`(${gModelData.gBbsNum.format()})`);

                        $('#prod_bbs_top .preview__tit span').text(gModelData.gBbsNum.format());
                    }else{
                        if(!result.data.passflag){
                            alert("비밀번호가 정확하지 않습니다.");
                        }
                    }
                }
            });
        });
        $("#prod_bbs").find(".reviewall__select").click(function(e){
            $("#prod_bbs").find(".select-box--basic").siblings().removeClass("is-on");
            $("#prod_bbs").find(".select-box--basic").addClass("is-on");
            if($(this).data("all-visible")){
                $("#prod_bbs").find(".select-box--basic .select-box__list").show();
            }else{
                $(this).data("all-visible",true);
                bbsPromise.bbsShopList().then(bbsShopListView);
            }
        });
    }else{
        html += `<li class="reviewall__item no-data">
                    <p class="tx_msg">등록된 상품평이 없습니다.</p>
                </li>`;
        $("#prod_bbs").find(".reviewall__cont .reviewall__list").append(html);
    }
    fn_paging(paramHandler.get("page"), paramHandler.get("pagesize") , bbsToTalCnt);
    $("#prod_bbs").find(".comm__paging ul li").click(function () {
        let page = $(this).data("page");
        paramHandler.set("page",page);
        $("html,body").stop(true,false).animate({"scrollTop": $("#prod_bbs .reviewall__head").offset().top - 150},500);
    });
}
const bbsImageListView = (json) => {
    if (json.success && json.total > 0) {
        $("#prod_image_bbs").find(".photoreview__head em.tx_cnt").html(`(${json.total.format()})`);
        Object.assign(bbsImageList, json);
        let imageBbsList = json.data;
        let html = ``;

        $.each(imageBbsList, (index, listData) => {
            if (index == 12) {
                html += `<li class="thum_more">
                            <button type="button" class="btn btn__layopen">
                                <p class="tx_cnt">+${json.total.format()}</p>
                                <img class="lazy" data-original="${listData.imgurl_org}" src="http://img.enuri.info/images/home/thum_none.jpg"  alt="" >
                            </button>
                        </li>`;
                return false;
            } else {
                html += `<li data-idx="${listData.list_idx}">   
                            <a href="javascript:void(0);" class="thum__link" title="">
                            <img class="lazy" data-original="${listData.imgurl_org}" src="http://img.enuri.info/images/home/thum_none.jpg"  alt="" >
                            </a>
                        </li>`;
            }
        });

        if(imageBbsList.length < 13){
            const cnt = 13 - imageBbsList.length;
            let i = 0;

            while (i < cnt) {
                html += `<li></li>`;
                ++i;
            }
        }

        $("#prod_image_bbs").find(".thum__list").html(html);
        
        $("#prod_image_bbs").find(".thum__list li").unbind().click(function () {
            if ($(this).hasClass("thum_more")) {
                bbsImageListAllView();
            } else if($(this).data("idx")){
                $("#PHOTOLAYER").data("idx", $(this).data("idx"));
                bbsPromise.bbsDetail($(this).data("idx")).then(bbsDetailView);
            }
			insertLog(24452);
        });
        $("#prod_image_bbs").find(".thum__list li img").lazyload({
            placeholder : 'http://img.enuri.info/images/home/thum_none.jpg',
            effect : 'fadeIn',
            effectTime : 2000,
            threshold : 800,
        });
    }else{
        $("#prod_image_bbs").hide();
    }
}
const bbsDetailView = (json) => {
    if (json.success && json.total > 0) {
        let detailbbsData = json.data;
        let detailbbsTotalCnt = json.total;
        let thisIdx = $("#PHOTOLAYER").data("idx");
        let next_idx = 0;
        let prev_idx = 0;
        let this_obj = {};
        let html = ``;
        $.each(detailbbsData, (index,listData) => {
            if(listData.list_idx==thisIdx){
                next_idx = this_obj.next_idx;
                prev_idx = this_obj.prev_idx;
                Object.assign(this_obj,listData);
                return false;
            }
        }); 
        $("#PHOTOLAYER").find(".photoreview__view .arr").hide();
        if (this_obj.next_idx > 0) {
            $("#PHOTOLAYER").find(".photoreview__view .arr.arr-next").data("idx", this_obj.next_idx);
            $("#PHOTOLAYER").find(".photoreview__view .arr.arr-next").show();
        }
        if (this_obj.prev_idx > 0) {
            $("#PHOTOLAYER").find(".photoreview__view .arr.arr-prev").data("idx", this_obj.prev_idx);
            $("#PHOTOLAYER").find(".photoreview__view .arr.arr-prev").show();
        }
        if(this_obj.next_idx > 0 && this_obj.prev_idx > 0){
            $("#PHOTOLAYER").find(".photoreview__lt").html(`
                <p class="tx_cnt"><strong>${thisIdx.format()}</strong><span> / ${detailbbsTotalCnt.format()}</span></p>
            `);
        }else{
            $("#PHOTOLAYER").find(".photoreview__lt").html(``);
        }
        $("#PHOTOLAYER").find(".photoreview__lt").append(`<div class="thum__box">
                <div class="thum__big"><img src="${this_obj.imgurl_org}" alt=""/></div>
            </div>`);

        html +=`<div class="inbo__box">
            <div class="tx__source">
                <div class="prodscope prodscope--14x">
                    <i class="ico ico--scope">
                        <span class="ico--scope-active" style="width:${this_obj.point * 20}%;"></span>
                    </i>
                    <p class="tx_aval">${this_obj.point}</p>
                </div>
                <ul class="tx_info">
                    <li>${this_obj.shopname}</li>
                    <li>${this_obj.username}</li>
                    <li>${this_obj.regdate}</li>
                </ul>
            </div>

            <p class="tx_name">${this_obj.title}</p>
            <span class="tx_sub">
                ${this_obj.contents}
            </span>
            <ul class="thum__list">`;
            $.each(this_obj.imglist, (index, listData) => {
                html += `<li ${index == 0 ? `class="is-on"` : ``} ><button type="button" class="btn"><img src="${listData}" alt=""  ></button></li>`
            });   
        html +=`</ul></div>`;

        $("#PHOTOLAYER").find(".photoreview__rt").html(html);
        $("#PHOTOLAYER").find(".photoreview__rt .thum__list li").click(function () {
            let thisImg = $(this).find("img").attr("src");
            $("#PHOTOLAYER").find(".photoreview__lt .thum__box .thum__big img").attr("src", thisImg);
        });
        $("#PHOTOLAYER").find(".photoreview__rt .thum__list li img ").on("error",function () {
            $(this).attr("src", "http://img.enuri.info/images/home/thum_none.jpg");
        });
        $("#PHOTOLAYER").find(".photoreview__lt .thum__box img").on("error",function () {
            $(this).attr("src", "http://img.enuri.info/images/home/thum_none.jpg");
        });
        $("#PHOTOLAYER").find(".btn__viewtype").removeClass("is-on");
        $("#PHOTOLAYER").find(".photoreview__all").hide();
        $("#PHOTOLAYER").find(".photoreview__view").show();

        $("#PHOTOLAYER").show();

        $("#PHOTOLAYER").find(".photoreview__view .arr").unbind().click(function () {
            let idx = $(this).data("idx");
            $("#PHOTOLAYER").data("idx", idx);
            bbsPromise.bbsDetail(idx).then(bbsDetailView);
        });
        $("#PHOTOLAYER").find(".photoreview__rt .thum__list li").click(function () {
            $(".photoreview__rt .thum__list li").removeClass("is-on");
            $(this).addClass("is-on");
        });
      
        $("#PHOTOLAYER").find(".btn__viewtype").click(function () {
            bbsImageListAllView();
        });

    }
}
const bbsTextDetailView = (json) => {
    let html = ``
    if(typeof json != "undefined"){
         html = `<div class="info__box">
                        <div class="tx__source">
                            <div class="prodscope prodscope--14x">
                                <i class="ico ico--scope">
                                <span class="ico--scope-active" style="width:${json.point * 20}%;"></span>
                                </i>
                                <p class="tx_aval">${json.point}</p>
                            </div>
                            <ul class="tx_info">
                            <li>${json.shopname}</li>
                            <li>${json.username}</li>
                            <li>${json.regdate}</li>
                        </ul>
                        </div>

                        <p class="tx_name">${json.title}</p>
                        <span class="tx_sub">
                        ${json.contents}
                        </span>`;
                
    $("#TEXTLAYER").find(".lay-comm--body .textreview__view").html(html);
    $("#TEXTLAYER").show();
    }else{
        $("#TEXTLAYER").hide();
    }
}
const bbsImageListAllView = () => {
    $("#PHOTOLAYER").find(".btn__viewtype").addClass("is-on");
    $("#PHOTOLAYER").find(".photoreview__view").hide();
    if (! $("#PHOTOLAYER").find(".btn__viewtype").data("all_visible")) {
        if (bbsImageList.success && bbsImageList.total > 0) {
            let imageBbsList = bbsImageList.data;
            let html = ``;
            $.each(imageBbsList, (index, listData) => {
                html += `<li>   
                            <button type="button" class="btn" data-idx="${listData.list_idx}"><img class="lazy" data-original="${listData.imgurl_org}" src="http://img.enuri.info/images/home/thum_none.jpg"  alt="" ></button> 
                        </li>`;
            });
            $("#PHOTOLAYER").find(".photoreview__all .photoreview__list").html(html);
            $("#PHOTOLAYER").find(".photoreview__all").show();
            $("#PHOTOLAYER").find(".photoreview__all .photoreview__list li img.lazy").lazyload({
                container : $("#PHOTOLAYER .photoreview__all"),
                placeholder : 'http://img.enuri.info/images/home/thum_none.jpg',
                effect : 'fadeIn',
                effectTime : 2000,
                threshold : 800

            });


            $("#PHOTOLAYER").find(".photoreview__all .photoreview__list .btn").click(function () {
                $("#PHOTOLAYER").find(".photoreview__all .photoreview__list .btn").removeClass("is-on");
                $(this).addClass("is-on");
                let idx = $(this).data("idx");
                $("#PHOTOLAYER").data("idx", idx);
                bbsPromise.bbsDetail(idx).then(bbsDetailView);
            });
            if(bbsImageList.total > 500){
                var _throttleTimer = null,
                    _throttleDelay = 100,
                    $pwrapper = $(".lay-photoreview .photoreview__all"),
                    $plist = $(".lay-photoreview .photoreview__list"),
                    $alarmBox = $(".lay-photoreview .limit__alarm");

                // 레이어 : 전체보기 최대 500개 노출 
                $pwrapper.scroll(function(){
                    //throttle event:
                    clearTimeout(_throttleTimer);
                    _throttleTimer = setTimeout(function () {
                        var pTotal = $pwrapper.scrollTop() + $pwrapper.height();
                        
                        if (pTotal > $plist.height() + 40) {
                            $alarmBox.fadeIn(200, function(){
                                setTimeout(function(){
                                    $alarmBox.fadeOut(200);    
                                }, 1000)
                            });
                        }
                    }, _throttleDelay);
                })
            }
        }
    }
    $("#PHOTOLAYER").find(".photoreview__all").show();
    $("#PHOTOLAYER").find(".btn__viewtype").data("all_visible", true);
    $("#PHOTOLAYER").show();
}
const bbsShopListView = (json) => {
    if(json.success && json.total > 0 ){
        let shopListData = json.data;
        let html =``;
        html +=`<li class="select-box__item"  data-shopcode=""><a href="javascript:void(0);">전체보기</a></li>`;
        $.each(shopListData, (index,listData) => {
            let shopcode = listData.shop_code;
            let shopname = listData.shop_name;

            html +=`<li class="select-box__item"  data-shopcode="${shopcode}"><a href="javascript:void(0);">${shopname}</a></li>`;
        });
        $("#prod_bbs").find(".select-box--basic .select-box__list").html(html);
        $("#prod_bbs").find(".select-box--basic .select-box__list li").unbind().click(function(e){
            e.stopPropagation();
            $("#prod_bbs").find(".reviewall__select .select-box--basic").removeClass("is-on");
            let shopname = $(this).find("a").text();
            let shopcode = $(this).data("shopcode");
            $("#prod_bbs").find(".select-box--basic .select-box--selected").html(`${shopname}<i class="ico-arr-select-box lp__sprite"></i>`);
            paramHandler.set("shopcodes",shopcode);
			insertLog(14530);	
        });
        $("#prod_bbs").find(".reviewall__select").show();
    }else{
        $("#prod_bbs").find(".reviewall__select").hide();
    }
}

const imgError = (imgarray,obj,index) => {
    $(obj).replaceWith(`<img src="${imgarray[index]}" alt="">`);
    $(this).on("error",function(){
        imgError(imgarray,this,index++);
    }); 
}
const fn_paging = (pageNum, pageSize, pageCnt) => {
    var pHtml = "";
    var startPage = parseInt(pageNum / 10) * 10;
    var totalPage = (parseInt(pageCnt) / pageSize);
    var endPage = 0;
    if (pageNum > 0 && parseInt(pageNum % 10) == 0) {
        startPage = startPage - 10;
    }

    if (pageNum > 10) {
        pHtml += "<li data-page=\"" + (startPage - 1) + "<a href=\"javascript:;\" class=\"btn btn__prev\">이전</a></li>";
    }

    if (totalPage > (startPage + 10)) {
        endPage = (startPage + 10);
    } else {
        endPage = totalPage;
    }
    let i = startPage;
    for (i = startPage; i < endPage; i++) {
        if (pageNum == (i + 1)) {
            pHtml += "<li data-page=\"" + (i + 1) + "\" class=\"is-on\"><a href=\"javascript:;\" class=\"p_num\">" + (i + 1) + "</a></li>";
        } else {
            pHtml += "<li data-page=\"" + (i + 1) + "\"><a href=\"javascript:;\" class=\"p_num\">" + (i + 1) + "</a></li>";
        }
    }

    if (totalPage > (startPage + 10)) {
        pHtml += "<li data-page=\"" + (i + 1) + "\"><a href=\"javascript:;\" class=\"btn btn__next\">다음</a></li>";
    }
    $("#prod_bbs").find(".comm__paging ul").html(pHtml);
    $("#prod_bbs").find(".comm__paging").show();
}

