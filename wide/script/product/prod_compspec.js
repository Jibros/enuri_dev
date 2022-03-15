const specData = {
    specListTitle : null // 스펙
    ,totalArray : null // 인기상품(전체)
    ,newArray : null // 신상품
    ,simArray : null // 비슷한 가격대
    ,specExist : null//스펙값 존재 유무
    ,originProd : null // 현재상품
}

//스펙비교 data
const compspecPromise  = (type = "S") => {
    const param = {
        type : type,
        modelno : gModelData.gModelno,
    }

    return new Promise((res,rej) => {
        $.ajax({
            type:"get",
            url:"/wide/api/product/prodCompSpec.jsp",
            data:param,
            dataType:"JSON",
            success: (result) => {
                res(result);
            },
            error: (err) => {
                rej(err);
            }
        })
    });
}

const prodCompspecFunc = {
    list : async function () { //스펙 리스트
        let listHtml = "";
    
        listHtml += `<tr class="spec_info">
                        <td style="height: 226px;">상품정보<em></em></td>
                    </tr>
                    <tr class="row_spec">
                        <td style="height: 19px;">최저가</td>
                    </tr>
                    <tr class="row_spec">
                        <td style="height: 18px;">상품등록일</td>
                    </tr>`;
        specData.specListTitle.forEach((v,i) => {
            let specMain = (i < 2) ? "spec_main" : "";
            listHtml += `<tr class="row_spec ${specMain}" gp_no="${v.gp_no}">
                            <td style="height: 18px;">${v.title}</td>
                        </tr>`;
        });
    
        $('#prodSpecComparison .comp_item .tb_compspec > tbody').html(listHtml);
    },
    originProd : async function () { //현재 모델
        if(specData.originProd){
            const obj = specData.originProd;
            const dateArr = obj.c_date.split("-");
            const yyyy = dateArr[0];
            const mm = dateArr[1];
            const specList = obj.specList;
            let originProdHtml = "";
            let img = "";

            if(obj.origin_img.length > 0){
                img = obj.origin_img;
            }else if(obj.p_imgurl.length > 0){
                img = obj.p_imgurl;
            }else if(obj.p_imgurl2.length > 0){
                img = obj.p_imgurl2;
            }

            originProdHtml += `<table class="tb_compspec">
                                    <tbody>
                                        <tr>
                                            <td class="spec_info" style="height: 226px;">
                                                <p class="tag__prod">현재상품</p>
                                                <a href="#" class="thum__link">
                                                    <ul class="tag_list">
                                                        ${obj.best_flag == "Y" ? `<li><i class="ico_cos">가성비</i></li>` : ``}
                                                        ${obj.most_flag == "Y" ? `<li><i class="ico_alo">많이구매</i></li>` : ``}
                                                        ${obj.new_flag == "Y" ? `<li><i class="ico_new">신제품</i></li>` : ``}
                                                    </ul>
                                                    <img class="lazy" data-original="${img}" src="http://img.enuri.info/images/home/thum_none.jpg" alt="" onerror="this.src='http://img.enuri.info/images/home/thum_none.jpg'">
                                                </a>
                                                <div class="scope">`;
            if(obj.bbs_num > 0){
                originProdHtml += `                    <i class="ico ico--scope">
                                                            <span class="ico--scope-active"><!--별점--></span>
                                                        </i>
                                                        <p class="tx_aval">${obj.bbs_point_avg}</p>
                                                        <p class="tx_cnt">(${obj.bbs_num.format()})</p>`
            }
            originProdHtml += `                </div>
                                                <span class="info">
                                                    <a href="#" class="tx_name">${obj.modelnm}</a>
                                                </span>
                                            </td>
                                        </tr>
                                        <tr class="row_spec">
                                            <td style="height: 19px;">
                                                <span class="tx_spec_desc ty_price"><em>${obj.minprice3.format()}</em>원</span>
                                            </td>
                                        </tr>
                                        <tr class="row_spec">
                                            <td style="height: 18px;">
                                                <span class="tx_spec_desc">${yyyy}.${mm}</span>
                                            </td>
                                        </tr>`;
            specData.specListTitle.forEach((b,a) => {
                const gp_no = b.gp_no.toString();
                const specMain = (a < 2) ? "spec_main" : "";
                let gpArr = new Array();
                let title = "";
                
                if(specList[gp_no]) gpArr = specList[gp_no];
                specData.specExist[gp_no] = "N";
                
                originProdHtml += `        <tr class="row_spec ${specMain}" gp_no="${gp_no}">
                                                <td style="height: 18px;">`;
                if(gpArr.length > 0) {
                    for(let c = 0; c < gpArr.length; c ++){
                        specData.specExist[gp_no] = "Y";
                        if(gpArr[c].spec_title == "부가기능" && gpArr[c].title_group.length > 0){
                            title = gpArr[c].title_group + "("+gpArr[c].title+")";;
                        }else{
                            title = gpArr[c].title;
                        }
                        originProdHtml += `        <span class="tx_spec_desc">${title}</span>`;
                    }
                }else{
                    originProdHtml += `        <span class="tx_spec_desc">-</span>`;
                }
                originProdHtml += `            </td>
                                            </tr>`;
            });
            originProdHtml += `    </tbody>
                                </table>`;
    
            $('#prodSpecComparison .comp_origin').html(originProdHtml);
            $('#prodSpecComparison .comp_origin .spec_info img.lazy').lazyload({
                placeholder : 'http://img.enuri.info/images/home/thum_none.jpg',
                effect : 'fadeIn',
                effectTime : 2000,
                threshold : 800
            });
        }
    },
    compProds : async function (arr = specData.totalArray) { //스펙비교 모델
        const pageGap = 4;
        let page = 1;
        let compProdHtml = "";
        let index = 0; 
        let compArray = new Array();

        if(arr.length > 0){
            compArray = arr.sort(function(a, b) { // 오름차순 정렬
                return b['badge_cnt'] - a['badge_cnt'];
            });
        } 

        compArray.forEach(v => {
            const specList = v.specList;
            const dateArr = v.c_date.split("-");
            const yyyy = dateArr[0];
            const mm = dateArr[1];
            let img = "";

            if(v.origin_img.length > 0){
                img = v.origin_img;
            }else if(v.p_imgurl.length > 0){
                img = v.p_imgurl;
            }else if(v.p_imgurl2.length > 0){
                img = v.p_imgurl2;
            }
    
            if(v.modelno == gModelData.gModelno) return true;
    
            compProdHtml += `<li data-group="${parseInt(index/pageGap)+1}">
                                <table class="tb_compspec">
                                    <tbody>
                                        <tr>
                                            <td class="spec_info" style="height: 221px;">
                                                <a href="/detail.jsp?modelno=${v.modelno}" class="thum__link" onclick="insertLogCate(23350, ${gModelData.gCate4});">
                                                    <ul class="tag_list">
                                                        ${v.best_flag == "Y" ? `<li><i class="ico_cos">가성비</i></li>` : ``}
                                                        ${v.most_flag == "Y" ? `<li><i class="ico_alo">많이구매</i></li>` : ``}
                                                        ${v.new_flag == "Y" ? `<li><i class="ico_new">신제품</i></li>` : ``}
                                                    </ul>
                                                    <img class="lazy" data-original="${img}" src="http://img.enuri.info/images/home/thum_none.jpg" alt="" onerror="this.src='http://img.enuri.info/images/home/thum_none.jpg'">
                                                </a>
                                                <div class="scope">
                                                    <i class="ico ico--scope">
                                                        <span class="ico--scope-active"><!--별점--></span>
                                                    </i>
                                                    <p class="tx_aval">${v.bbs_point_avg}</p>
                                                    <p class="tx_cnt">(${v.bbs_num.format()})</p>
                                                </div>
                                                <span class="info">
                                                    <a href="/detail.jsp?modelno=${v.modelno}" class="tx_name" onclick="insertLogCate(23350, ${gModelData.gCate4});">${v.modelnm}</a>
                                                </span>
                                            </td>
                                        </tr>
                                        <tr class="row_spec">
                                            <td style="height: 19px;">
                                                <span class="tx_spec_desc ty_price"><em>${v.minprice3.format()}</em>원</span>
                                            </td>
                                        </tr>
                                        <tr class="row_spec">
                                            <td style="height: 18px;">
                                                <span class="tx_spec_desc">${yyyy}.${mm}</span>
                                            </td>
                                        </tr>`;
            specData.specListTitle.forEach((b,a) => {
                const gp_no = b.gp_no.toString();
                let gpArr = new Array();
                let title = "";
                let specMain = (a < 2) ? "spec_main" : "";
                
                if(specList[gp_no]) gpArr = specList[gp_no];
                if(gpArr.length > 0) title = gpArr[0].title;
                
                compProdHtml += `        <tr class="row_spec ${specMain}" gp_no="${gp_no}">
                                            <td style="height: 18px;">`;
                if(gpArr.length > 0) {
                    for(let c = 0; c < gpArr.length; c ++){
                        if(gpArr[c].spec_title == "부가기능" && gpArr[c].title_group.length > 0){
                            title = `${gpArr[c].title_group}(${gpArr[c].title})`;
                        }else{
                            title = gpArr[c].title;
                        }
                        compProdHtml += `<span class="tx_spec_desc">${title}</span>`;
                    }
    
                    if(arr == specData.totalArray && specData.specExist[gp_no] == "N") specData.specExist[gp_no] = "Y";
                }else{
                    compProdHtml += `        <span class="tx_spec_desc">-</span>`;
                }
                compProdHtml += `            </td>
                                        </tr>`;
            });
            compProdHtml += `       </tbody>
                                </table>
                            </li>`
            index ++;
        });

        $('#prodSpecComparison .comp_item .tb_compspec .spec_info > td > em').text(`(${index})`); //필터 별 모델 카운트
        $('#prodSpecComparison .comp_prod .comp_prod_list').html(compProdHtml);
        $('#prodSpecComparison .div_compspec').hide();
        $('#prodSpecComparison .div_compspec').eq(0).show();
        $('#prodSpecComparison .comp_prod .comp_prod_list .spec_info img.lazy').lazyload({
            placeholder : 'http://img.enuri.info/images/home/thum_none.jpg',
            effect : 'fadeIn',
            effectTime : 2000,
            threshold : 800
        });

        $("#prodSpecComparison .btn_comp.btn_comp_next, #prodSpecComparison .btn_comp.btn_comp_prev").unbind().click(function(){ //next,prev 버튼
            let maxPage = Math.ceil(index/pageGap);

            $(this).siblings('ul').find(`li[data-group="${page}"]`).hide();
            
            if($(this).attr("class").indexOf("next") > 0){
                if(page < maxPage) page++;
            }else{
                if(page > 1) page--;
            }
        
            $(this).siblings('ul').find(`li[data-group="${page}"]`).show();
        });

        //스펙값 없으면 해당 스펙그룹 비노출
        $.each(specData.specExist, function(c,d){
            if(d === "N") $('tr[gp_no='+c+']').remove();
        });

        return true;
    },
    height : async function () { //테이블 높이 조정
        const $compItem = $("#prodSpecComparison .comp_item tr"); // 구분 Table-row
        const $row = $("#prodSpecComparison .comp_origin tr"); // 선택상품 Table-row
        const $compProd = $("#prodSpecComparison .comp_prod > ul > li"); // 비교상품 Table

        $row.each(function(e) {
            let tdH = $(this).find(">td").height();
            
            $compProd.each(function() {
                const cptdH = $(this).find("tr").eq(e).find(">td").height();
                if ( tdH < cptdH ) tdH = cptdH;
            });

            $(this).find(">td").height(tdH);

            $compProd.each(function() {
                $(this).find("tr").eq(e).find(">td").height( tdH );
                $compItem.eq(e).find(">td").height( tdH );
            });
        });
    },
    event : async function () { //클릭 이벤트
        const $compspec_tab = $('#prodSpecComparison .speccomp__sort > li'); //비교유형 버튼
        const $compspec_sort = $('#prodSpecComparison .speccomp__insort > li'); //필터 버튼
        const $simBtn = $compspec_sort.eq(1); //비슷한 가격대 버튼
        const $newBtn = $compspec_sort.eq(2); //신제품 버튼
        
        $compspec_sort.show();
        $compspec_sort.removeClass('is-on');
        $compspec_sort.eq(0).addClass('is-on');

        //버튼 미노출
        if(specData.simArray == null || specData.simArray.length == 0) $simBtn.hide();
        if(specData.newArray == null || specData.newArray.length == 0) $newBtn.hide();
        
        $compspec_tab.unbind().click(function(){ //탭 클릭
            const $type = $(this).data('type');
            const logArr = [23351,23352,23353];
            const idx = $(this).index();

            insertLog(logArr[idx]);
            prodCompspecViewTab($type);

            $compspec_tab.removeClass('is-on');
            $(this).addClass('is-on');
        });

        $compspec_sort.unbind().click(function(){ //필터 클릭
            const $arr = $(this).data('arr'); 
            
            switch ($arr) {
                case "total":
                    insertLog(23354);
                    prodCompspecViewSort(specData.totalArray);
                    break;
                case "sim":
                    insertLog(23355);
                    prodCompspecViewSort(specData.simArray);
                    break;
                case "new":
                    insertLog(23356);
                    prodCompspecViewSort(specData.newArray);
                    break;
                default:
                    break;
            }

            $compspec_sort.removeClass('is-on');
            $(this).addClass('is-on');
        });

        $(".speccomp__sort li[data-type='S'] button").text(gModelData.gCate6Nm);
        $(".speccomp__sort li[data-type='B'] button").text(gModelData.gBrand);
        $(".speccomp__sort li[data-type='D'] button").text(gModelData.gCate8Nm);
    }
}

//type 변경
export async function prodCompspecViewTab (type = "S") {
    const promiseData = await compspecPromise(type);

    specData.totalArray = promiseData.totalArray;
    specData.newArray = promiseData.newArray;
    specData.simArray = promiseData.simArray;
    specData.specListTitle = promiseData.specListTitle;
    if(specData.totalArray.length > 0) specData.originProd = specData.totalArray[0];
    specData.specExist = new Object();

    if(promiseData.scate_cnt > 2 || promiseData.brnd_cnt > 2 || promiseData.dcate_cnt > 2){
        if(promiseData.scate_cnt < 3){
            $("#prodSpecComparison .speccomp__sort li[data-type='S']").remove();
            if(type == "S") {
                prodCompspecViewTab("B");
                return;
            }
        }
        
        if(promiseData.brnd_cnt < 3){
            $("#prodSpecComparison .speccomp__sort li[data-type='B']").remove();
            if(type == "B") {
                prodCompspecViewTab("D");
                return;
            }
        }
        
        if(promiseData.dcate_cnt < 3){
            $("#prodSpecComparison .speccomp__sort li[data-type='D']").remove();
            if(type == "D") return;
        }
        $('#tabSpec').show();
        $('#prodSpecComparison').show();
    }else{
        $('#tabSpec').hide();
        $('#prodSpecComparison').hide();
    }

    await prodCompspecFunc.list();
    await prodCompspecFunc.originProd();
    await prodCompspecFunc.compProds();
    await prodCompspecFunc.height();
    await prodCompspecFunc.event();
}

//필터링
export async function prodCompspecViewSort (arr = specData.totalArray) {
    await prodCompspecFunc.compProds(arr);
    await prodCompspecFunc.height();
}