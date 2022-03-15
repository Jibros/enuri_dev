export const bridgeUrl = (cmd, sCode, mNo,  mFactory,  iPlNo,  sCoupon, showPrice, buycnt, epKey) =>{
    mFactory = encodeURIComponent(mFactory);
    if (typeof(buycnt) == "undefined") buycnt = 1;
    if (typeof(epKey) == "undefined") epKey = "";

    var strMoveTargetUrl = "/move/Redirect.jsp";
    var varTargetUrl = strMoveTargetUrl + "?cmd=" + cmd + "&vcode=" + sCode + "&modelno=" + mNo + "&pl_no=" + iPlNo + "&cate=" + gModelData.gCategory + "&urltype=0&coupon=" + sCoupon + "&from=detail&showPrice=" + showPrice + "&buycnt=" + buycnt +"&referrer="+enrRefer;
    if (sCode == 536) {
        varTargetUrl = varTargetUrl + "&tempid=" + TMPUSER_ID + "&memberid=" + USER_ID;
    }
    if (epKey != "") {
        varTargetUrl = varTargetUrl + "&ep=y&epkey=" + epKey;
    }

    return varTargetUrl;
}
// VIP 엠크로니 배너 교체 작업
export const prodBannerPromise = (type) => {
    let rtnHtml = ``;
    let bannerUrl = ``;

    if(type=="comp"){
        bannerUrl =  "http://ad-api.enuri.info/enuri_PC/pc_vip/C2/req?cate=" + gModelData.gCategory.substring(0,4);
    }else if("mid"){
        bannerUrl = "http://ad-api.enuri.info/enuri_PC/pc_vip/C1/req?cate=" + gModelData.gCategory.substring(0,4);
       /*  if (IsAdultAd == "true") {
            bannerUrl = "http://ad-api.enuri.info/enuri_PC/pc_adult/C1a/req?cate=" + ca_code;
        } */
    }else {

    }
    $.ajax({
        type: "get",
        url: bannerUrl,
        dataType: "json",
        async : false,
        success: function(data) {
            let vipGoodsImg = data.IMG1;
            let vipGoodsUrl = data.JURL1;
            let vipGoodsTarget = data.TARGET;
            let vipGoodsAlt = data.ALT;
            if(type == "comp"){
                if (vipGoodsImg != "" && vipGoodsUrl != "") {
                    rtnHtml = `<li class="comprod__item is-bnr--ad">
                        <a href="${vipGoodsUrl}" target="_blank" class="bnr__link"><img src="${vipGoodsImg}" alt="${vipGoodsAlt}"></a>
                    </li>`;
                }
            }else if(type =="mid"){
                if (vipGoodsImg != "" && vipGoodsUrl != "") {
                    rtnHtml = `<a href="${vipGoodsUrl}" target="_blank" class="bnr__anchor">
                                <img src="${vipGoodsImg}" alt="${vipGoodsAlt}" />
                            </a>`;
                }
            }
        }

    });
    if(type=="mid"){
        if(rtnHtml.length >0){
            $("#midBanner").html(rtnHtml).show();
        }
    }
    return rtnHtml;
}

export const declaration = {
    singoClick : false,
    layerDeclaration : function(obj){
        let shopCode = 0;
        let plno = 0;
        let radioHtml = ``;

        if(obj) {
            const $comprod__item = obj.parents('.comprod__item');

            shopCode = $comprod__item.data('shopcode');
            plno = $comprod__item.data('plno');

            radioHtml = `<li><input type="radio" id="epNew8" name="epNew" class="input--radio-item" value="8"><label for="epNew8">잘못된 상품(다른상품)</label></li>
                        <li><input type="radio" id="epNew9" name="epNew" class="input--radio-item" value="9"><label for="epNew9">쇼핑몰 접속불가/다른 쇼핑몰</label></li>
                        <li><input type="radio" id="epNew10" name="epNew" class="input--radio-item" value="10"><label for="epNew10">잘못된 가격정보</label></li>
                        <li><input type="radio" id="epNew11" name="epNew" class="input--radio-item" value="11"><label for="epNew11">잘못된 배송비/혜택</label></li>
                        <li><input type="radio" id="epNew12" name="epNew" class="input--radio-item" value="12"><label for="epNew12">품절/재고없음</label></li>
                        <li><input type="radio" id="epNew13" name="epNew" class="input--radio-item" value="13"><label for="epNew13">추가비용/현금결제 요구</label></li>
                        <li><input type="radio" id="epNew29" name="epNew" class="input--radio-item" value="29"><label for="epNew29">기타</label></li>`;
        }else{
            radioHtml = `<li><input type="radio" id="epNew10" name="epNew" class="input--radio-item" value="10"><label for="epNew10">잘못된 가격정보</label></li>
                        <li><input type="radio" id="epNew6" name="epNew" class="input--radio-item" value="6"><label for="epNew6">잘못된 제조사/브랜드 정보</label></li>
                        <li><input type="radio" id="epNew5" name="epNew" class="input--radio-item" value="5"><label for="epNew5">잘못된 상품정보/이미지</label></li>
                        <li><input type="radio" id="epNew7" name="epNew" class="input--radio-item" value="7"><label for="epNew7">잘못된 카테고리</label></li>
                        <li><input type="radio" id="epNew4" name="epNew" class="input--radio-item" value="4"><label for="epNew4">페이지오류(이미지 매칭 /기능오류 등)</label></li>
                        <li><input type="radio" id="epNew29" name="epNew" class="input--radio-item" value="29"><label for="epNew29">기타</label></li>`;
        }
        
        $('#SINGOLAYER .list-form--radio').html(radioHtml);
        $('#SINGOLAYER div.error-report__box').text(gModelData.gModelNm); // 모델명

        $('#SINGOLAYER .lay-comm__btn-group .lay-comm__btn').eq(0).unbind().click(function(){
            $(':radio[name="epNew"]:checked').prop('checked', false);
            $('#inconv_txt').val('');
            $('#chkEmail:checked').prop('checked',false);
            $('#inconv_email').val('');
            $('#SINGOLAYER').hide();
        });

        $('#SINGOLAYER .lay-comm__btn--close').unbind().click(function(){
            $(':radio[name="epNew"]:checked').prop('checked', false);
            $('#inconv_txt').val('');
            $('#chkEmail:checked').prop('checked',false);
            $('#inconv_email').val('');
            $('#SINGOLAYER').hide();
        });

        $('#SINGOLAYER .lay-comm__btn-group .lay-comm__btn').eq(1).unbind().click(function(){
            declaration.goDeclaration(shopCode,plno);
        });

        $('#SINGOLAYER').show();
    },
    goDeclaration : function(shopCode,plno){
        let strEp = "34";
        let strEp_ch_new = "";
        let param = {
            "cate" : gModelData.gCategory,
            "inconv_txt" : $("#inconv_txt").val().trim(),
            "http_header" : navigator.userAgent+"<BR>"+declaration.getOSInfoStr(),
            "modelno" : gModelData.gModelno,
            "shop_code" : shopCode,
            "pl_no" : plno,
            "inconv_email" : $("#inconv_email").val(),
            "ep_ch_new" : "",
            "epclass" : "",
            "ep_device" : 1,
            "ep_site" : 1
        };
    
        if ($(':radio[name="epNew"]').length > 0) {
            if ($(':radio[name="epNew"]:checked').val()) {
                strEp_ch_new = $(':radio[name="epNew"]:checked').val();
            }
        } else {
            strEp_ch_new = "14";
        }
    
        if (strEp_ch_new != "") {
            param.ep_ch_new = strEp_ch_new;
        } else {
            alert("신고항목을 선택해주세요");
            $("radio[name=epNew]").eq(0).focus();
            return;
        }
    
        if(strEp_ch_new != "14"){
            switch (strEp_ch_new) {
                case "4":
                    strEp = "09";
                    break;
                case "5":
                    strEp = "10";
                    break;
                case "6":
                    strEp = "05";
                    break;
                case "7":
                    strEp = "01";
                    break;
                case "10":
                    strEp = "08";
                    break;
                case "29":
                    strEp = "11";
                    break;
                default:
                    break;
            }
        }else{
            if ($("#inconv_txt").val().trim().length == 0 ) {
                alert("오류내용을 입력해 주십시오.");
                $("#inconv_txt").focus();
                return;
            }
        
            if ($("#inconv_txt").val().trim().korlen() > 1000) {
                alert("500자 이상 입력하실수 없습니다.")
                $("#inconv_txt").focus();
                return;
            }
        }
    
        if (strEp != ""){
            param.epclass = strEp;
        }
        if(!declaration.singoClick){
            declaration.singoClick = true;
            $.ajax({
                url : "/include/layer/InsertInconvenience.jsp", 
                data : param, 
                dataType : "text", 
                type : "post",
                success : function(result){
                    if(result.indexOf("ERROR_CNT_OVER") >= 0){
                        alert("일일 신고 제한 건수인 20 건을 초과했습니다.\n내일 다시 신고 주시기 바랍니다.\n문의: (02)6354-3601(내선:206)");
                    }else{
                        alert(result);
                    }
                    $("#SINGOLAYER").hide();
                    declaration.singoClick = false;
                }
            });
        }else{
            alert("신고 접수 중 입니다.\n잠시만 기다려 주세요. ");
        }
    },
    getOSInfoStr : function(){
        const ua = navigator.userAgent;
        if(ua.indexOf("NT 6.0") != -1) return "Windows Vista/Server 2008";
        else if(ua.indexOf("NT 5.2") != -1) return "Windows Server 2003";
        else if(ua.indexOf("NT 5.1") != -1) return "Windows XP";
        else if(ua.indexOf("NT 5.0") != -1) return "Windows 2000";
        else if(ua.indexOf("NT") != -1) return "Windows NT";
        else if(ua.indexOf("9x 4.90") != -1) return "Windows Me";
        else if(ua.indexOf("98") != -1) return "Windows 98";
        else if(ua.indexOf("95") != -1) return "Windows 95";
        else if(ua.indexOf("Win16") != -1) return "Windows 3.x";
        else if(ua.indexOf("Windows") != -1) return "Windows";
        else if(ua.indexOf("Linux") != -1) return "Linux";
        else if(ua.indexOf("Macintosh") != -1) return "Macintosh";
        else return "";
    }
}