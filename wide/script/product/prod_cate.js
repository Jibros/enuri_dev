let cosMap = new CustomMap();

export const catePromise = {
    param : {},
    cos : function (opt = "ALL_T", cpids = "", titletext = "") {
        this.param = {
            modelno : gModelData.gModelno,
            cate : gModelData.gCategory,
            opt : opt,
            cpids : cpids,
            titletext : titletext
        }
    
        return new Promise((res,rej) => {
            $.ajax({
                type:"post",
                url:"/wide/api/product/prodCosComponent.jsp",
                data:this.param,
                dataType:"JSON",
                success: (result) => {
                    if(result.resultmsg == "success") res(result);
                },
                error: (err) => {
                    rej(err);
                }
            })
        });
    },
    mobile : function () {
        this.param = {
            vipModelNo: gModelData.gModelno,
            deviceType: 1
        }
    
        return new Promise((res,rej) => {
            $.ajax({
                type:"get",
                url:"/wide/api/product/prodSearchType.jsp",
                data:this.param,
                dataType:"JSON",
                success: (result) => {
                    if(result.total > 0) res(result.data);
                },
                error: (err) => {
                    rej(err);
                }
            })
        });
    },
    furniture : function () {
        this.param = {
            modelno : gModelData.gModelno,
            cate : gModelData.gCategory
        }

        return new Promise((res,rej) => {
            $.ajax({
                type:"get",
                url:"/wide/api/product/prodAttrGraph.jsp",
                data:this.param,
                dataType:"JSON",
                success: (result) => {
                    if(result.total > 0) res(result.data);
                },
                error: (err) => {
                    rej(err);
                }
            })
        });
    },
    caution : function () {
        this.param = {
            modelno : gModelData.gModelno
            ,modelnm : gModelData.gModelNm
            ,cate : gModelData.gCategory
            ,factory : gModelData.gFactory
            ,brand : gModelData.gBrand
        }

        return new Promise((res,rej) => {
            $.ajax({
                type:"get",
                url:"/wide/api/product/prodCaution.jsp",
                data:this.param,
                dataType:"JSON",
                success: (result) => {
                    if(result.total > 0) res(result.data);
                },
                error: (err) => {
                    rej(err);
                }
            })
        });
    }
}

export const prodCateView = {
    cos : async function (data) {
        await prodCateCosFunc.table(data);
        await prodCateCosFunc.hover();
        await prodCateCosFunc.moreView();
    },
    mobile : function (data) {
        prodCateMobileFunc(data);
    },
    furniture : function (data) {
        prodCateFurnitureFunc(data);
    },
    caution : async function (data) {
        prodCateCautionFunc(data);
    }
}

const prodCateCosFunc = {
    table : async function (data) {
        let tableHtml = "";
        const compData = data.all_component_data;
        const allIngredients = compData[0].all_component; //전성분
        const goodenssFit = compData[1].goodness_type; //피부타입별 적합도
        const mainIngredients = compData[2].component_items; //좋은성분, 주의성분
        
        if(allIngredients.length == 0){
            return;
        }else{
            tableHtml += `<tr>
                            <td>
                                <ul class="graph__list graph--type1">`
                                    goodenssFit.forEach(v => {
                                        tableHtml += `<li data-layer="${(v.cpt_goodness_round_percent > 0) ? `on`:``}" data-cptid=${v.cpt_id} data-cpids=${v.cp_ids} data-title=${v.cpt_group_name}>
                                                        <i class="ico p${v.cpt_goodness_round_percent}">${v.cpt_goodness_round_percent}%</i>
                                                        <em class="tx_type">${v.cpt_group_name}</em>
                                                    </li>`; 
                                    });
            tableHtml +=        `</ul>
                                <div class="lay-cosmetic lay-comm">
                                </div>
                            </td>
                            <td>
                                <ul class="graph__list graph--type2">`
                                mainIngredients.forEach((v) => {
                                    let cpt_name = (v.cpt_name.indexOf("피부") > -1) ? v.cpt_name : `피부${v.cpt_name}`;
    
                                    if(v.cpt_harmflag == "0"){
                                        tableHtml += `<li data-layer="${(v.cpt_cnt > 0) ? `on` : ``}" data-cptid=${v.cpt_id} data-cpids=${v.cp_ids} data-title=${cpt_name}>
                                                        <i class="ico ${(v.cpt_cnt > 0) ? `is-on` : ``}">${v.cpt_cnt}</i>
                                                        <em class="tx_type">${cpt_name}</em>
                                                    </li>`
                                    }
                                });
            tableHtml +=        `</ul>
                                <div class="lay-cosmetic lay-comm">
                                </div>
                            </td>
                            <td>
                                <ul class="graph__list graph--type3">`
                                    mainIngredients.forEach((v) => {
                                        if(v.cpt_harmflag == "1"){
                                            tableHtml += `<li data-layer="${(v.cpt_cnt > 0) ? `on` : ``}" data-cptid=${v.cpt_id} data-cpids=${v.cp_ids} data-title=${v.cpt_name}>
                                                            <i class="ico ${(v.cpt_cnt > 0) ? `is-on` : ``}">${v.cpt_cnt}</i>
                                                            <em class="tx_type">${v.cpt_name}</em>
                                                        </li>`
                                        }
                                    });
            tableHtml +=        `</ul>
                                <div class="lay-cosmetic lay-comm">
                                </div>
                            </td>
                            <td>
                                <div class="cosmetic__info">
                                    <p class="tx_detail">${allIngredients}</p>
                                    <button type="button" class="btn btn__more">전성분 ${compData[0].total_cnt}개 더보기</button><!-- 레이어 있는 성분 -->
                                    <!-- 전성분 레이어 -->
                                    <div class="lay-cosmetic lay-cosmetic--wide lay-comm">
                                    </div>
                                </div>
                            </td>
                        </tr>`
            
            $('#cosComponent .tb__cosmetic tbody').html(tableHtml);
            $('#cosComponent').show();
        }
    },
    hover : async function () {
        const hasLayer = $("#cosComponent .tb__cosmetic .graph__list > li");                                  
        
        if(hasLayer.length == 0){
            return;
        }else{
            $(hasLayer).hover(async function(){
                const layerState = $(this).data("layer");
                const cptId = $(this).data("cptid");
                const cpIds = $(this).data("cpids");
                const title = $(this).data("title");
        
                $("#cosComponent .lay-cosmetic").removeClass("is-shown");
                if(layerState === "on"){
                    await prodCateCosFunc.hoverLayer($(this), cptId, cpIds, title);
                    $(this).closest("td").find(".lay-cosmetic").addClass("is-shown");
                }
            },function() {
                $(this).closest("td").find(".lay-cosmetic").removeClass("is-shown");
            });
        }
    },
    hoverLayer : async function ($this, cptId, cpIds, title) {
        let data = null;
        let layerHtml = "";
        let layerTitle = "";
    
        if(!cosMap.containsKey(cptId)){
            data = await catePromise.cos("4",cpIds,title);
            cosMap.put(cptId,data);
        }

        if($this.parent().hasClass("graph--type1")){
            insertLog(14488);
            layerTitle = `${$this.find('em').text()}에 좋은 성분 ${cosMap.get(cptId).total_cnt}개`;
        }else if($this.parent().hasClass("graph--type2")){
            insertLog(14489);
            layerTitle = `${$this.find('em').text()} 성분 ${cosMap.get(cptId).total_cnt}개`;
        }else if($this.parent().hasClass("graph--type3")){
            insertLog(14490);
            layerTitle = `${$this.find('em').text()} 성분 ${cosMap.get(cptId).total_cnt}개`;
        }
    
        layerHtml += `<div class="lay-comm--head">
                            <strong class="lay-comm__tit">${layerTitle}</strong>
                        </div>
                        <div class="lay-comm--body">
                            <div class="lay-comm--inner">
                                <table class="lay-tb lay-tb--cosmetic">
                                    <colgroup>
                                        <col width="50%">
                                        <col width="50%">
                                    </colgroup>
                                    <thead>
                                        <tr>
                                            <th>성분명</th>
                                            <th>배합목적</th>
                                        </tr>
                                    </thead>
                                    <tbody>`
                                        cosMap.get(cptId).component_list.forEach(v => {
                                            layerHtml += `<tr>
                                                            <td>${v.cp_name_kr}</td>
                                                            <td>${v.cp_purpose}</td>
                                                        </tr>`
                                        });
        layerHtml +=                `</tbody>
                                </table>
                            </div>
                        </div>`;
    
        $this.closest("td").find(".lay-cosmetic").html(layerHtml);
    },
    moreView : async function () {
        const $button = $(".tb__cosmetic .cosmetic__info .btn__more");
        const cpIds = $(".tb__cosmetic .cosmetic__info .tx_detail").text();

        if($button.length == 0){
            return;
        }else{
            $button.click(async function () {
                let data = null;
                let moreHtml = "";
            
                if(!cosMap.containsKey("total")){
                    data = await catePromise.cos("6",cpIds);
                    cosMap.put("total",data);
    
                    moreHtml += `<div class="lay-comm--head">
                                    <strong class="lay-comm__tit">전성분 ${cosMap.get("total").Allcomponent_list.length}개</strong>
                                </div>
                                <div class="lay-comm--body">
                                    <div class="lay-comm--inner">
                                        <table class="lay-tb lay-tb--cosmetic">
                                            <colgroup>
                                                <col width="30%">
                                                <col width="50%">
                                                <col width="20%">
                                            </colgroup>
                                            <thead>
                                                <tr>
                                                    <th>성분명</th>
                                                    <th>배합 목적</th>
                                                    <th>성분 내용</th>
                                                </tr>
                                            </thead>
                                            <tbody>`;
                                            cosMap.get("total").Allcomponent_list.forEach(v => {
                                                let cpt_name = "";
                                                
                                                switch (v.cpt_name) {
                                                    case "건성피부":
                                                        cpt_name = "피부건조";
                                                        break;
                                                    case "지성피부":
                                                        cpt_name = "지성좋음";
                                                        break;
                                                    case "민감성피부":
                                                        cpt_name = "민감성좋음";
                                                        break;
                                                    case "자극":
                                                        cpt_name = "피부자극";
                                                        break;
                                                    case "미백":
                                                        cpt_name = "피부미백";
                                                        break;
                                                    case "탄력":
                                                        cpt_name = "피부탄력";
                                                        break;
                                                    default:
                                                        cpt_name = v.cpt_name;
                                                        break;
                                                }
    
                                                moreHtml += `<tr>
                                                                <td>${v.cp_name_kr}</td>
                                                                <td>${v.cp_purpose}</td>
                                                                <td class="${v.cpt_harmflag == "1" ? `tx_emp`:``}">${cpt_name}</td>
                                                            </tr>`;
                                            });
                    moreHtml +=             `</tbody>
                                        </table>
                                    </div>
                                </div>
                                <button class="lay-comm__btn--close comm__sprite" onclick="$(this).parent().hide()">레이어 닫기</button>`;
                    
                                $(".tb__cosmetic .cosmetic__info .lay-cosmetic").html(moreHtml);
                }
                
                insertLog(14491);
                $(this).siblings('.lay-cosmetic--wide').show();
            });
        }
    }
}

function prodCateMobileFunc(data){
    let opt1Arr = Object.keys(data.option1); //option1 그룹
    const opt2Arr = data.option2; //option2 array
    let tableHtml = "";
    let thisTab = "";

    //탭 순서 정렬
    if(gModelData.gCategory.substring(0, 4) == "0304"){
        opt1Arr.sort((a,b) => {
            return parseInt(a.substring(0,a.indexOf("G"))) - parseInt(b.substring(0,b.indexOf("G")));
        });
    }else{
        opt1Arr.sort();
    }
    opt1Arr.forEach((v,i) => {
        let tableObj = new Object();
        let idx1 = 0;

        tableHtml += `<li  data-tab=${opt1Arr[i]}>
                        <button class="srp-type__tab">${opt1Arr[i]}</button>
                        <div class="srp-type__cont">
                            <dl class="srp-type__cond">`
                            while (idx1<3) { //가로 3칸 고정
                                if(opt2Arr[idx1]){
                                    const a = opt2Arr[idx1];
                                    let tmpArray = new Array();
                                    let idx2 = 0;
    
                                    tableObj[a] = data.option1[v].filter(function (obj) {
                                        return obj.OPTION_2 == a;
                                    });
    
                                    tmpArray = tableObj[a];
    
                                    tableHtml += `<dt>${a}</dt>
                                                    <dd>
                                                        <table class="tb-conditon--type-c">
                                                            <tbody>`
                                                            while (idx2<4) { //세로 4칸 고정
                                                                if(tmpArray[idx2]){
                                                                    const value = tmpArray[idx2];
                                                                    
                                                                    if(gModelData.gModelno == value.MODELNO) thisTab = opt1Arr[i];
            
                                                                    tableHtml += `<tr>
                                                                                    <th>${value.OPTION_3}</th>
                                                                                    ${(value.MINPRICE3 == 0) ? `<td class = is--soldout>품절</td>`:`<td><a href="/detail.jsp?modelno=${value.MODELNO}" onclick="insertLog(24451);">최저가 <em>${parseInt(value.MINPRICE3).format()}</em>원</a></td>`}
                                                                                </tr>`
                                                                }else{
                                                                    tableHtml += `<tr class="is--empty"><th></th><td></td></tr>`
                                                                }
                                                                ++idx2;
                                                            }
                                    tableHtml +=            `</tbody>
                                                        </table>
                                                    </dd>`
                                }else{
                                    tableHtml += `<dt class="is--blank"></dt><dd class="is--blank"></dd>`;
                                }
                                ++idx1;
                            }
        tableHtml +=        `</dl>
                        </div>
                    </li>`;
    });

    $('.srp-type--c ul').html(tableHtml);
    $(`.srp-type--c [data-tab="${thisTab}"]`).addClass('is--on');
    $('.srp-type--c').show();

    $(".srp-type__list .srp-type__tab").click(function(){
        var $pa = $(this).parent();
        $pa.addClass("is--on").siblings().removeClass("is--on");
    });
}

function prodCateFurnitureFunc(data){
    let tableHtml = "";
    let title_1 = "자재등급";
    let class_1 = "level_0";
    let attrId_1 = 0;
    let title_2 = "";
    let class_2 = "level_00";
    let attrId_2 = 0;

    if (gModelData.gCategory.substring(0, 4) == "1201") {
        title_2 = "착석감";
    } else if (gModelData.gCategory.substring(0, 4) == "1202") {
        title_2 = "쿠션감";
    }

    data.list.forEach(v => {
        switch (v.attribute_id) {
            case 123660:
            case 133553:
                title_1 = "자재등급";
                class_1 = `level_${v.attribute_element.toLowerCase()}`;
                attrId_1 = v.attribute_id;
                break;
            case 211331:
                title_2 = "착석감";
                class_2 = `level_0${v.attribute_element_id}`;
                attrId_2 = v.attribute_id;
                break;
            case 205023:
                let attribute_element_id = "";

                switch (v.attribute_element_id) {
                    case 5:
                        attribute_element_id = 1;
                        break;
                    case 6:
                        attribute_element_id = 2;
                        break;
                    case 2:
                        attribute_element_id = 3;
                        break;
                    case 3:
                        attribute_element_id = 4;
                        break;
                    case 7:
                        attribute_element_id = 5;
                        break;
                    default:
                        break;
                }
                
                title_2 = "쿠션감";
                class_2 = `level_0${attribute_element_id}`;
                attrId_2 = v.attribute_id;
                break;
            default:
                break;
        }
    });

    tableHtml += `<table class="tb__fungrade">
                    <colgroup>
                        <col width="25%">
                        <col width="25%">
                    </colgroup>
                    <thead>
                        <tr>
                            <th>${title_1} <button type="button" class="ico ico--question" onclick="showDicLayer(this);" data-attr_id="${attrId_1}" data-attr_el_id="0">?</button> <p class="tx_sub">유해물질 포름알데히드 방출량에 따른 등급분류</p></th>
                            <th>${title_2} <button type="button" class="ico ico--question" onclick="showDicLayer(this);" data-attr_id="${attrId_2}" data-attr_el_id="0">?</button> <p class="tx_sub">푹신함의 강도를 나타내며, 1이 가장 푹신하고 5가 가장 단단합니다.</p></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>
                                <div class="grade_level ${class_1}">
                                </div>
                            </td>
                            <td>
                                <div class="grade_level ${class_2}"></div>
                            </td>
                        </tr>
                    </tbody>
                </table>`;

    $('.row__fungrade .inner').html(tableHtml);
    $('.row__fungrade').show();
}

function prodCateCautionFunc(data){
    data.forEach(v => {
        if(v.view_type == "1"){
            let contentHtml = "";

            // if (title_type == 1){
            //     html += "<span class=\"tit\"><strong>" + title + "</strong><span class=\"speaker\"></span></span>";
            // }else{
            //     html += "<span class=\"tit\"><strong>특가/이벤트</strong><span class=\"speaker\"></span></span>";
            // } 
            
            if(v.content_type == "1"){
                contentHtml = `<div class="inner">`
                if(v.content_list.length > 0){
                    v.content_list.forEach(a => {
                        contentHtml += `${a.content}<br>`
                    });
                }
                contentHtml += `</div>`;
            } else if(v.content_type == "2"){
                contentHtml = `<div class="inner">
                <img src="http://storage.enuri.info/pic_upload/caution/${v.img}" usemap="#Map">`
                if(v.imgmap_list.length > 0){
                    contentHtml += `<map name="Map">`
                    v.imgmap_list.forEach(v => {
                        contentHtml += `<area shape="rect" coords="${v.img_map}" href="${v.map_url}" target="_blank">`
                    });
                    contentHtml += `</map>`
                }
                contentHtml += `</div>`;

                $('#caution1').addClass('is-thum');
            }

            $('#caution1').html(contentHtml);
            $('#caution1').show();
        }else if(v.view_type == "2"){
            let contentHtml = "";
            
            // if (title_type == 1){
            //     html += "<p class=\"tit\"><strong>" + title + "</strong></p>";
            // }else{
            //     html += "<p class=\"tit\"><strong>주의사항</strong></p>";
            // }

            if(v.content_type == "1"){
                contentHtml = `<div class="inner">`
                if(v.content_list.length > 0){
                    contentHtml += `${v.content_list[0].content}`
                }
                contentHtml += `</div>`;
            } else if(v.content_type == "2"){
                contentHtml = `<div class="inner">
                <img src="http://storage.enuri.info/pic_upload/caution/${v.img}" usemap="#Map">`
                if(v.imgmap_list.length > 0){
                    contentHtml += `<map name="Map">`
                    v.imgmap_list.forEach(v => {
                        contentHtml += `<area shape="rect" coords="${v.img_map}" href="${v.map_url}" target="_blank">`
                    });
                    contentHtml += `</map>`
                }
                contentHtml += `</div>`;

                $('.container__section .row__section.row__prodrelated').addClass('is-thum');
            }

            $('.container__section .row__section.row__prodrelated').html(contentHtml).show();
        }
    });
}