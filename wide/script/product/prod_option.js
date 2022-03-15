import * as prodInit from "./prod_init.js";
import * as prodPriceComp from "./prod_pricecomp.js";
import * as prodShopPrice from "./prod_shopprice.js";
let param = {
    "modelno" : gModelData.gModelno,
    "unit" : "",
    "delivery" : "",
    "callcnt" : 0
}; 
/* const paramProxy = new Proxy(param,{
    set: (target, prop, value) => {
        if(prop=="modelno"){
            target[prop] = value;
            target["delivery"] = "";
            target["callcnt"] = 0;
        }else if(prop=="callcnt"){
            target[prop]++;
        }else{
            target[prop] = value;
            optionPromise().then(prodOptionView);
        }
        return true;
    }
}); */
export const paramHandler = {
    set: (prop, value) => {
        if(prop=="callcnt"){
        }else{
            param["callcnt"]++;
            param[prop] = value;
            //optionPromise().then(prodOptionView);
            optionPromise().then(prodOptionViewTop)
                .then(prodOptionViewTopFix)
                .then(prodOptionView);
        }
        return true;
    },get: (prop) => {
        return param[prop];
    },
    init : () => {
        param["modelno"] = gModelData.gModelno;
        param["delivery"] = "";
        param["callcnt"] = 0;
    }
}


export const optionPromise = (data) => {
    if(typeof data != "undefined"){
        param = data;
    }
    return new Promise((resolve,reject) => {
        $.ajax({
            type: "post",
            url: "/wide/api/product/prodOption.jsp",
            data: param, 
            dataType: "json",
            success: (response) => {
                resolve(response);
            }, error : (error) => {
                reject(error);
            }
        });
    });
}

export const prodOptionViewTop = (json) => {
    if(json.success && json.total > 1){
        let optionCnt = json.total;
        let optionJson = json.data;
        let optionViewType = optionJson.optionViewType;

        let optionList = optionJson.optionList;
        let optionSelIdx = 0;
        let html = ``;

     
        if(optionCnt > 4){
            html = `<button type="button" class="btn btn__toggle" >펼치기</button>`;
        }
        html += `<ul class="buyopt__list">`;
        $.each(optionList, (index, listData) => {
            let price = listData.price;
            let rank = listData.rank;
            let condiname = listData.condiname;
            let modelno = listData.modelno;
            let condilogo = listData.condilogo;
            let rankcount = 0;

            if(gModelData.gModelno==modelno){
                optionSelIdx = index;
            }
            if(optionCnt == 3) rankcount = 1;
            else if (optionCnt > 3 && optionCnt < 8) rankcount = 2;
            else if (optionCnt >= 8) rankcount = 3;
            
            html += `<li data-modelno="${modelno}" data-val-price="${price}" data-name="${condiname}" data-rank="${index}">
                        <input type="radio" id="radioOPTIONTOP${index}" name="radioOPTIONTOP" class="input--radio-item">
                        <label for="radioOPTIONTOP${index}">
                        ${condilogo  != "" ? `<span class="tx--ad"><img src="${condilogo}" alt="${condiname}"></span>` : `<span>${condiname}</span>`}
                        ${(rank > 0 && rank <= rankcount) ? `<i class="badge badge--rank">${rank}</i>` : ``}
                        </label>
                    </li>`;
        });
        html +=`</ul>`;+
        $("#prod_option_top").find(".buyoption").html(html);
        
        $("#prod_option_top").find(".buyopt__list li[data-modelno="+gModelData.gModelno+"] input:radio").prop("checked",true);
        if(optionSelIdx > 3){
            $($("#prod_option_top").find(".buyoption li")[2]).after($("#prod_option_top").find(".buyopt__list li[data-modelno="+gModelData.gModelno+"]"));
            //$("#prod_option_top").find(".buyopt__list li[data-modelno="+gModelData.gModelno+"]").insertAfter($("#prod_option_top").find(".buyoption li")[2]);
        }
        $("#prod_option_top").find(".btn.btn__toggle").off().on("click",function(){
            if(optionSelIdx > 3){
                if(!$("#prod_option_top").find(".buyoption").hasClass("is-unfold")){
                    //$($("#prod_option_top").find(".buyopt__list li[data-modelno="+gModelData.gModelno+"]")).insertAfter($("#prod_option_top").find(".buyoption li")[optionSelIdx]);
                    //$($("#prod_option_top").find(".buyoption li")[optionSelIdx]).insertAfter($("#prod_option_top").find(".buyopt__list li[data-modelno="+gModelData.gModelno+"]"));
                    $($("#prod_option_top").find(".buyoption li")[optionSelIdx]).after($("#prod_option_top").find(".buyopt__list li[data-modelno="+gModelData.gModelno+"]"));
                }else{
                    $($("#prod_option_top").find(".buyoption li")[2]).after($("#prod_option_top").find(".buyopt__list li[data-modelno="+gModelData.gModelno+"]"));
                    //$("#prod_option_top").find(".buyopt__list li[data-modelno="+gModelData.gModelno+"]").insertAfter($("#prod_option_top").find(".buyoption li")[2]);
                }
            }
            $(this).closest('.buyoption').toggleClass('is-unfold');
        });
        /* if(!$("#prod_option_top").find(".buyoption").hasClass("is-unfold")){
            if(optionSelIdx > 3){
             //   $("#prod_option_top").find(".buyoption").addClass("is-unfold");
             $($("#prod_option_top").find(".buyoption li")[2]).insertAfter($("#prod_option_top").find(".buyopt__list li[data-modelno="+gModelData.gModelno+"]"));
            }else{
                $("#prod_option_top").find(".buyoption").removeClass("is-unfold");
            }
        } */
       
        $("#prod_option_top").find(".buyopt__list li").unbind().click(function(e){
           
            let modelno =$(this).data("modelno");
            let thisIndex = $(this).index();
            if(modelno!=gModelData.gModelno){
                insertLog(24450);
                $(this).siblings().removeClass("is-on");
                $(this).addClass("is-on");
                $(this).find("input:radio").prop("checked",true);
                $("#prod_option").find(".pricecomp__list li, .compare_price__list li").removeClass("is-on");
                $("#prod_option").find(".pricecomp__list li[data-modelno="+modelno+"], .compare_price__list li[data-modelno="+modelno+"]").addClass("is-on");
                $("#prod_option").find(".pricecomp__list li[data-modelno="+modelno+"] input:radio, .compare_price__list li[data-modelno="+modelno+"] input:radio").prop("checked",true);
                //top fix 세팅
                $("#prod_topfix").find(".prodtabinfo .select-box__list li").removeClass("is--selected");
                $("#prod_topfix").find(".prodtabinfo .select-box__list li[data-modelno="+modelno+"]").addClass("is--selected");
                $("#prod_topfix").find(".prodtabinfo .select-box--selected #changeOpt").html($(this).data("name"));

                //가격 변동 효과
                let price = parseInt($("#prod_summary_top").find(".prodminprice .box__minprice .tx_price em").text().replace(/,/g,''),10);
                let limitNum = $("#prod_option_top").find(".buyopt__list li[data-modelno="+modelno+"]").data("val-price");
                $( { countNum : price } ).stop(true,true).animate({countNum : limitNum },{
                    duration : 400,
                    easing : 'linear',
                    step : function(){
                        $("#prod_summary_top").find(".prodminprice .box__minprice .tx_price em").text( numComma(Math.floor(this.countNum)) )
                    },
                    complete : function(){
                        $("#prod_summary_top").find(".prodminprice .box__minprice .tx_price em").text( numComma(Math.floor(this.countNum)) )
                    }
                })
                e.preventDefault();
                $("#prod_option_top").find(".btn.btn__toggle").off().on("click",function(){
                    let list = document.querySelector('#prod_option_top .buyopt__list');

                    [...list.children].sort((a,b)=>$(a).data("rank")>$(b).data("rank")?1:-1).forEach(node=>list.appendChild(node));
                    if(thisIndex > 3){
                        if(!$("#prod_option_top").find(".buyoption").hasClass("is-unfold")){
                            $($("#prod_option_top").find(".buyoption li")[thisIndex]).after($("#prod_option_top").find(".buyopt__list li[data-modelno="+modelno+"]"));
                        }else{
                            $($("#prod_option_top").find(".buyoption li")[2]).after($("#prod_option_top").find(".buyopt__list li[data-modelno="+modelno+"]"));
                        }
                    }
                    $(this).closest('.buyoption').toggleClass('is-unfold');
                });
            }
            //하단 펼쳐주기 
            if(!$("#prod_option").hasClass("is-unfold")){
                if(optionViewType=="1" && optionCnt > 5){
                    if(thisIndex >= 5 ){
                        $("#prod_option").addClass("is-unfold");
                    }
                }else if(optionViewType=="2" && optionCnt > 10){
                    if(thisIndex >= 10 ){
                        $("#prod_option").addClass("is-unfold");
                    }
                }
            }
        
        });
        $("#prod_option_top").show();
    }else{
        $("#prod_option_top").hide();
    }
    return json;
};
export const prodOptionViewTopFix  = (json) =>{
    if(json.success && json.total > 1){
        let optionCnt = json.total;
        let optionJson = json.data;
        let optionList = optionJson.optionList;
        let optionViewType = optionJson.optionViewType;
        let html = ``;
        $.each(optionList,(index,listData) => {
            html +=`<li class="select-box__item" data-modelno="${listData.modelno}" data-val-price="${listData.price}"><a href="#">${listData.condiname}</a></li>`;
        });
        $("#prod_topfix").find(".prodtabinfo .prodtabinfo__lt .select-box__list").html(html);
        
        $("#prod_topfix").find(".prodtabinfo .prodtabinfo__lt .select-box__list li[data-modelno="+gModelData.gModelno+"]").addClass("is--selected");
        $("#prod_topfix").find(".prodtabinfo .prodtabinfo__lt .prod__select").show();

        $("#prod_topfix").find(".prodtabinfo .select-box__list > li").unbind("click");
        $("#prod_topfix").find(".prodtabinfo .select-box__list > li").click(function(e){
            let modelno =$(this).data("modelno");
            let thisIndex = $(this).index();

            if(modelno!=gModelData.gModelno){
                insertLog(24455);
                $(this).addClass("is--selected").siblings().removeClass("is--selected");
                $(".prodtabinfo .select-box--selected #changeOpt").html( $(this).find("a").html() );
                var $price = $("#detail_minprice").text();
                var price = parseInt($price.replace(/,/g,''),10);
                var limitNum = $(this).attr('data-val-price');
                modelno = $(this).data("modelno");
               // prodInit.gModelHandler.set("gModelno",modelno);
    
                $( { countNum : price } ).stop(true,true).animate({countNum : limitNum },{
                    duration : 400,
                    easing : 'linear',
                    step : function(){
                        $("#detail_minprice").text( numComma(Math.floor(this.countNum)) )
                    },
                    complete : function(){
                        $("#detail_minprice").text( numComma(Math.floor(this.countNum)) )
                    }
                })
                
                $("#prod_option_top").find(".buyopt__list li[data-modelno="+modelno+"] input:radio").prop("checked",true);
                if(!$("#prod_option_top").find(".buyoption").hasClass("is-unfold")){
                    if(thisIndex > 3){
                        $("#prod_option_top").find(".buyoption").addClass("is-unfold");
                    }
                }
                //중단세팅
                //하단 펼쳐주기 
                if(!$("#prod_option").hasClass("is-unfold")){
                    if(optionViewType=="1" && optionCnt > 5){
                        if(thisIndex >= 5){
                            $("#prod_option").addClass("is-unfold");
                        }
                    }else if(optionViewType=="2" && optionCnt > 10){
                        if(thisIndex >= 10){
                            $("#prod_option").addClass("is-unfold");
                        }
                    }
                }
                $("#prod_option").find(".pricecomp__list li, .compare_price__list li").removeClass("is-on");
                $("#prod_option").find(".pricecomp__list li[data-modelno="+modelno+"], .compare_price__list li[data-modelno="+modelno+"]").addClass("is-on");
                $("#prod_option").find(".pricecomp__list li[data-modelno="+modelno+"] input:radio, .compare_price__list li[data-modelno="+modelno+"] input:radio").prop("checked",true);
                
                e.preventDefault();
            }
        });
    }else{
        $("#prod_topfix").find(".prodtabinfo .prodtabinfo__lt .prod__select").hide();
    }
    return json;
}
export const prodOptionView = (json) => {
    if(json.success && json.total > 0){
        let optionCnt = json.total;
        let optionJson = json.data;

        let optionUnitType = optionJson.optionUnitType;
        let optionUnit = optionJson.optionUnit;

        let optionViewType = optionJson.optionViewType;
        let optionList = optionJson.optionList;

        let optionSelIdx = 0;

        let html =``;

        $("#prod_option").removeClass("inc-delivery").removeClass("inc-unitprice").addClass("pricecomp");
        if(optionViewType=="1"){
            $("#prod_option").addClass("inc-delivery");
        }else{
            $("#prod_option").addClass("inc-unitprice");
        }
        if(optionViewType =="1"){
            html +=`<p class="toggle__chk ${param.delivery != "" ? `is-on` :`is-off` } ">
                        <span class="switch"><span class="btn"><em>on/off</em></span><strong>배송비 포함 최저가</strong></span>
                    </p>
                    <div class="lay-tooltip">
                        <div class="lay__inner">
                            <p class="tx_msg"><em>TIP</em><strong>배송비포함최저가</strong>로 <strong>단위당 가격을 비교</strong>해 볼 수 있습니다.</p>
                        </div>
                    </div>
                    <ul class="pricecomp__list is-sort">
                        <li>
                            <span class="col col-1"><strong>구매옵션</strong></span>`;
            if(optionUnitType){
                html +=     `<span class="col col-2" data-sort="asc"><button type="button" class="btn btn--sort">배송비</button></span>
                            <span class="col col-3" data-sort="asc"><button type="button" class="btn btn--sort">${optionUnit}당 가격</button></span>`;
            }  else {
                html +=     `<span class="col col-2" data-sort="asc"></span>
                            <span class="col col-3" data-sort="asc"><button type="button" class="btn btn--sort">배송비</button></span>`;
            }   
                html +=     `<span class="col col-4" data-sort="asc"><button type="button" class="btn btn--sort">${param.delivery=="Y" ? `배송비 포함` : ``}최저가</button></span>
                            <span class="col col-5" data-sort="asc"><button type="button" class="btn btn--sort">판매몰</button></span>
                        </li>
                    </ul>`;
            html += `<ul class="pricecomp__list is-col--1">`
            $.each(optionList, (index,listData) => {
                let unit_per_price = listData.unit_per_price;
                let price = listData.price;
                let price2 = listData.price2;
                let cash_check = listData.cash_check;
                let delivery_text = listData.delivery_text;
                let mallcnt = listData.mallcnt
                let unit = listData.unit;
                let rank = listData.rank;
                let condiname = listData.condiname;
                let modelno = listData.modelno;
                let delivery_textView = "";
                let priceView = price;
                let rankcount = 0;
                let condilogo = listData.condilogo;

                if(gModelData.gModelno==modelno){
                    optionSelIdx = index;
                }
                if($.isNumeric(delivery_text)){
                    delivery_textView = numComma(delivery_text) + "원";
                }else{
                    delivery_textView = delivery_text;
                }
              
                if(param.delivery=="Y"){
                    priceView = price2
                }else{
                    priceView = price;
                }
                if(optionCnt == 3) rankcount = 1;
                else if (optionCnt > 3 && optionCnt < 8) rankcount = 2;
                else if (optionCnt >= 8) rankcount = 3;
                html += `<li data-modelno="${modelno}" data-name="${condiname}" >
                            <a href="javascript:void(0);" class="opt_link">
                                <span class="col col-1"  >
                                    <input type="radio" id="radioOPTION${index}" name="radioOPTION" class="input--radio-item" >
                                    ${condilogo  != "" ? `
                                    <label for="radioOPTION${index}" class="tx--ad">
                                        <img src="${condilogo}" alt="${condiname}">
                                        ${(rank > 0 && rank <= rankcount) ? `<i class="badge badge--rank">${rank}</i>` : ``}
                                    </label>` :
                                    `<label for="radioOPTION${index}">
                                        ${condiname}
                                        ${(rank > 0 && rank <= rankcount) ? `<i class="badge badge--rank">${rank}</i>` : ``}
                                    </label>`}
                                </span>`;
                if(optionUnitType){
                    html +=     `<span class="col col-2" data-value="${delivery_text}">
                                        <span class="tx_delivery">${delivery_textView}</span>
                                </span>
                                <span class="col col-3" data-value="${unit_per_price}">
                                    <span class="tx_unitprice">${numComma(unit_per_price)}원/${unit}</span>
                                </span>`;
                }  else {
                    html +=     `<span class="col col-2" data-value="">
                                    <span class="tx_delivery"></span>
                                </span>
                                <span class="col col-3" data-value="${delivery_text}">
                                    <span class="tx_unitprice">${delivery_textView}</span>
                                </span>`;
                }   
                html +=     `<span class="col col-4" data-value="${priceView}">
                            ${cash_check ? `<i class="ico ico--cash" title="현금 최저가"></i>`: ``}
                                    <span class="tx_price"><em>${numComma(priceView)} </em>원</span>
                                </span>
                                <span class="col col-5" data-value="${mallcnt}">
                                    <span class="tx_cnt"><em>${numComma(mallcnt)}</em>몰</span>
                                </span>
                            </a>
                        </li>`
            });
            html += `</ul>  
            ${optionCnt > 5 ? `<button class="adv-search__btn--more">더보기<i class="ico-adv-arr-down lp__sprite"></i></button>
                        <button class="adv-search__btn--close">닫기<i class="ico-adv-arr-up lp__sprite"></i></button>
                ` : ``}`;
        }else{
            html += `<div class="pricecomp__head">
                        <ul class="pricecomp__sort">
                            <li data-sort="price" ${param.unit == "" ? `class= is-on` :`` }><button type="button" class="btn">최저가순</button></li>
                            ${optionUnitType ? `<li data-sort="unit" ${param.unit != "" ? `class= is-on` :`` }><button type="button" class="btn">단위당 환산가순</button></li>` : ``}
                        </ul>
                        <p class="toggle__chk ${param.delivery != "" ? `is-on` :`is-off` }">
                            <span class="switch">
                                <span class="btn"><em>on/off</em></span>
                                <strong>배송비 포함</strong>
                            </span>
                        </p>
                    </div>`
            html += `<ul class="compare_price__list border-box">`
            $.each(optionList, (index,listData) => {
                let unit_per_price = listData.unit_per_price;
                let price = listData.price;
                let price2 = listData.price2;
                let delivery_text = listData.delivery_text;
                let cash_check = listData.cash_check;
                let mallcnt = listData.mallcnt
                let unit = listData.unit;
                let rank = listData.rank;
                let condiname = listData.condiname;
                let modelno = listData.modelno;
                let delivery_textView = "";
                let priceView = price;

                let rankcount = 0;
                let condilogo = listData.condilogo;

                if(gModelData.gModelno==modelno){
                    optionSelIdx = index;
                }
                if($.isNumeric(delivery_text)){
                    delivery_textView = numComma(delivery_text) + "원";
                }else{
                    delivery_textView = delivery_text;
                }
                if(param.delivery=="Y"){
                    priceView = price2;
                }else{
                    priceView = price;
                }
                if(optionCnt == 3) rankcount = 1;
                else if (optionCnt > 3 && optionCnt < 8) rankcount = 2;
                else if (optionCnt >= 8) rankcount = 3;
                html += `<li data-modelno="${modelno}" data-name="${condiname}" ${index==0 ? `class="is-on ${(param.unit=="") ? "is-low-price" : "is-low-per-price"}" ` : ``} >
                            <a href="javascript:void(0);" class="opt_link">
                                <span class="col col-1">
                                    <input type="radio" id="radioOPTION${index}" name="radioOPTION" class="input--radio-item">
                                    ${condilogo  != "" ? `
                                        <label for="radioOPTION${index}" class="tx--ad">
                                            <img src="${condilogo}" alt="${condiname}">
                                            ${(rank > 0 && rank <= rankcount) ? `<i class="badge badge--rank">${rank}</i>` : ``}
                                        </label>` :
                                        `<label for="radioOPTION${index}">
                                            ${condiname}
                                            ${(rank > 0 && rank <= rankcount) ? `<i class="badge badge--rank">${rank}</i>` : ``}
                                        </label>`}
                                </span>
                                <span class="col col-2">
                                    ${index == 0 && (param.delivery=="Y" && param.unit=="Y") ? `<span class="tx_low-price">최저</span>` : ``}
                                    <span class="tx_unitprice">${unit_per_price > 0 ? `${numComma(unit_per_price)}원/${unit}` : ``}</span>
                                </span>
                                <span class="col col-3">
                                    ${cash_check > 0 ? `<i class="ico ico--cash" title="현금 최저가"></i>` : ``} 
                                    ${index==0 && param.delivery=="Y" && param.unit!="Y" ? `<span class="tx_low-price">최저가</span>` : ``}
                                    <span class="tx_price"><em>${numComma(priceView)}</em>원</span>
                                </span>
                                <span class="col col-4">
                                    <span class="tx_cnt"><em>${numComma(mallcnt)}</em>몰</span>
                                </span>
                            </a>
                        </li>`
            });
            html += `</ul> 
            ${optionCnt > 10 ? `<button class="adv-search__btn--more">더보기<i class="ico-adv-arr-down lp__sprite"></i></button>
                                <button class="adv-search__btn--close">닫기<i class="ico-adv-arr-up lp__sprite"></i></button>
            ` : ``}`;
        }
        
        $("#prod_option").html(html);
      
       // $("#prod_option").find(".pricecomp__list li[data-modelno="+gModelData.gModelno+"]").addClass("is-on");
       
        $("#prod_option").find(".pricecomp__list li[data-modelno="+gModelData.gModelno+"] input:radio, .compare_price__list li[data-modelno="+gModelData.gModelno+"] input:radio").prop("checked",true);
        $("#prod_option").show();
        if(!$("#prod_option").hasClass("is-unfold")){
            if(optionViewType=="1" && optionCnt > 5){
                if(optionSelIdx >= 5){
                    $("#prod_option").addClass("is-unfold");
                }
            }else if(optionViewType=="2" && optionCnt > 10){
                if(optionSelIdx >= 10){
                    $("#prod_option").addClass("is-unfold");
                }
            }
        }
        //소팅
        $("#prod_option").find(".pricecomp__list.is-sort .col").unbind().click(function(){
            let optionObj = $("#prod_option").find(".pricecomp__list.is-col--1");
            let optionObjli = $("#prod_option").find(".pricecomp__list.is-col--1 li");
            let optionColClass = $(this).attr("class").replace("is-up","").replace("is-down","").trim();
            let optionAsc = $(this).data("sort");
            optionObjli.sort(function(a,b){
                
                let an = $(a).find(".opt_link span[class*='"+optionColClass+"']").data("value");
                let bn = $(b).find(".opt_link span[class*='"+optionColClass+"']").data("value");
                an = $.isNumeric(an) ? parseInt(an) : 0;
                bn = $.isNumeric(bn) ? parseInt(bn) : 0;
                if(an > bn) {
                    return optionAsc=="desc" ? -1 : 1;
                }
                if(an < bn) {
                    return optionAsc=="desc" ? 1 : -1;
                }
                return 0;
            });
            $(optionObj).html(optionObjli);

            $(this).siblings().removeClass("is-up");
            $(this).siblings().removeClass("is-down");

            
            if(optionAsc=="asc"){
                $(this).removeClass("is-up");
                $(this).addClass("is-down");
            }else{
                $(this).removeClass("is-down");
                $(this).addClass("is-up");
            }
           // $(optionObjli).find(".opt_link span").removeClass("is-on");
           // $(optionObjli).find(".opt_link span[class*='"+optionColClass+"']").addClass("is-on");
            optionAsc=="asc" ? $(this).data("sort","desc") : $(this).data("sort","asc");

            $("#prod_option").find(".pricecomp__list li, .compare_price__list li").unbind().click(function(e){
                
                let modelno =$(this).data("modelno");
                let thisIndex = $(this).index();
                if(modelno!=gModelData.gModelno){
                    if(optionViewType =="1"){
                        insertLogLSV(14497,`${gModelData.gCategory}`,`${gModelData.gModelno}`);
                    }else{
                        insertLogLSV(18630,`${gModelData.gCategory}`,`${gModelData.gModelno}`);
                    }
                   // $(this).siblings().removeClass("is-on");
                   // $(this).addClass("is-on");
                    $(this).find("input:radio").prop("checked",true);
                    
                     //top 세팅
                    let list = document.querySelector('#prod_option_top .buyopt__list');

                    [...list.children].sort((a,b)=>$(a).data("rank")>$(b).data("rank")?1:-1).forEach(node=>list.appendChild(node));

                    $("#prod_option_top").find(".buyopt__list li[data-modelno="+modelno+"] input:radio").prop("checked",true);
                    if(!$("#prod_option_top").find(".buyoption").hasClass("is-unfold")){
                        if(thisIndex > 3){
                            $($("#prod_option_top").find(".buyoption li")[2]).after($("#prod_option_top").find(".buyopt__list li[data-modelno="+modelno+"]"));
                        }
                    }
                    
                    //fixtop 세팅
                    $("#prod_topfix").find(".prodtabinfo .select-box__list li").removeClass("is--selected");
                    $("#prod_topfix").find(".prodtabinfo .select-box__list li[data-modelno="+modelno+"]").addClass("is--selected");
                    $("#prod_topfix").find(".prodtabinfo .select-box--selected #changeOpt").html( $(this).data("name") );
                    let price = parseInt($("#detail_minprice").text().replace(/,/g,''),10);
                    let limitNum = $("#prod_topfix").find(".prodtabinfo .select-box__list li[data-modelno="+modelno+"]").data("val-price");
                    $( { countNum : price } ).stop(true,true).animate({countNum : limitNum },{
                        duration : 400,
                        easing : 'linear',
                        step : function(){
                            $("#detail_minprice").text( numComma(Math.floor(this.countNum)) )
                        },
                        complete : function(){
                            $("#detail_minprice").text( numComma(Math.floor(this.countNum)) )
                        }
                    })
                }
                e.preventDefault();
            });
        });
        $(".pricecomp .adv-search__btn--more").on("click", function(){
            $(this).closest(".pricecomp").addClass("is-unfold");               
        });
        $(".pricecomp .adv-search__btn--close").on("click", function(){
            $(this).closest(".pricecomp").removeClass("is-unfold");            
        });
        $("#prod_option").find(".toggle__chk").on("click",function(){
            insertLog(14492);
            paramHandler.set("callcnt",1);
            if($(this).hasClass("is-off")){
                $(this).removeClass("is-off").addClass("is-on");
             
                paramHandler.set("delivery","Y");
                prodPriceComp.paramHandler.set("sort", "delivery");
                prodShopPrice.paramHandler.set("delivery", "Y");
            }else if($(this).hasClass("is-disabled")){
                return false;
            }else{
                $(this).removeClass("is-on").addClass("is-off");
                paramHandler.set("delivery","");
                prodPriceComp.paramHandler.set("sort", "price");
                prodShopPrice.paramHandler.set("delivery", "");
            }
        });
    
        $("#prod_option").find(".pricecomp__head .pricecomp__sort li").off().on("click",function(){
            
            if($(this).hasClass("is-on")){
                return false;
            }else {
                if($(this).data("sort")=="unit"){
                    insertLogLSV(26278,`${gModelData.gCategory}`,`${gModelData.gModelno}`);
                    paramHandler.set("unit","Y");
                }else{
                    insertLogLSV(26277,`${gModelData.gCategory}`,`${gModelData.gModelno}`);
                    paramHandler.set("unit","");
                }
                $(this).siblings().removeClass("is-on");
                $(this).addClass("is-on");
            }
        });
        $("#prod_option").find(".pricecomp__list li, .compare_price__list li").unbind().click(function(e){
           
            let modelno =$(this).data("modelno");
            let thisIndex = $(this).index();

            if(modelno!=gModelData.gModelno){
                //$(this).siblings().removeClass("is-on");
                //$(this).addClass("is-on");
                $(this).find("input:radio").prop("checked",true);
                if(optionViewType=="1"){
                    insertLog(14497);
                }else{
                    insertLog(18630);
                }
                //top 세팅
                let list = document.querySelector('#prod_option_top .buyopt__list');

                [...list.children].sort((a,b)=>$(a).data("rank")>$(b).data("rank")?1:-1).forEach(node=>list.appendChild(node));
                $("#prod_option_top").find(".buyopt__list li[data-modelno="+modelno+"] input:radio").prop("checked",true);
                if(!$("#prod_option_top").find(".buyoption").hasClass("is-unfold")){
                    if(thisIndex > 3){
                        $($("#prod_option_top").find(".buyoption li")[2]).after($("#prod_option_top").find(".buyopt__list li[data-modelno="+modelno+"]"));
                    }
                }
                $("#prod_option_top").find(".btn.btn__toggle").off().on("click",function(){
                    if(thisIndex > 3){
                        if(!$("#prod_option_top").find(".buyoption").hasClass("is-unfold")){
                            $($("#prod_option_top").find(".buyoption li")[thisIndex]).after($("#prod_option_top").find(".buyopt__list li[data-modelno="+modelno+"]"));
                        }else{
                            $($("#prod_option_top").find(".buyoption li")[2]).after($("#prod_option_top").find(".buyopt__list li[data-modelno="+modelno+"]"));
                        }
                    }
                    $(this).closest('.buyoption').toggleClass('is-unfold');
                });
                //fixtop 세팅
                $("#prod_topfix").find(".prodtabinfo .select-box__list li").removeClass("is--selected");
                $("#prod_topfix").find(".prodtabinfo .select-box__list li[data-modelno="+modelno+"]").addClass("is--selected");
                $("#prod_topfix").find(".prodtabinfo .select-box--selected #changeOpt").html( $(this).data("name") );
                let price = parseInt($("#detail_minprice").text().replace(/,/g,''),10);
                let limitNum = $("#prod_topfix").find(".prodtabinfo .select-box__list li[data-modelno="+modelno+"]").data("val-price");
                $( { countNum : price } ).stop(true,true).animate({countNum : limitNum },{
                    duration : 400,
                    easing : 'linear',
                    step : function(){
                        $("#detail_minprice").text( numComma(Math.floor(this.countNum)) )
                    },
                    complete : function(){
                        $("#detail_minprice").text( numComma(Math.floor(this.countNum)) )
                    }
                })
            }
            e.preventDefault();
        });
    }else{
        $("#prod_option").hide();   
    }
};

const numComma = (x) => {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

