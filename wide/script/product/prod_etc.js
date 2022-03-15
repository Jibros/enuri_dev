Kakao.init('b588430d311952c8371862b2e24960f4');

//모바일 최저가
mobileMinPrice();

//프린트 버튼
$('.btn__print').click(function(){
    cmdDetailPrint();
});

//클립보드
var clipboard = new ClipboardJS('.lay-share .lay-share__btn--copy');

clipboard.on('success', function(e) {
    insertLog(14468);
    alert('주소가 복사되었습니다');
});

clipboard.on('error', function(e) {
    console.log(e);
});

$('#txtURL').text(location.href);


$('.btn--share').click(function(){
    $(this).siblings('.lay-share').toggle();

    $('.lay-share__btn .lay-share__btn--tw').click(function(){
        shareUrl(1);
    });

    $('.lay-share__btn .lay-share__btn--fb').click(function(){
        shareUrl(2);
    });
    
    $('.lay-share__btn .lay-share__btn--kakao').click(function(){
        shareUrl(3);
    });
});
//스탬프 획득
$(".hit_stamp > a").click(function(e){
	if(!Islogin()){
		if(confirm("로그인 후 참여하실 수 있습니다.")){
			Cmd_Login();
			return;
		}
	}else{
		$.ajax({
			data : {
				"modelno" : gModelData.gModelno,
				"procCode" : 2
			},
			type : "POST",
			dataType : "JSON",
			url : "/wide/api/product/prodHitStamp.jsp",
			success : function(result){
				if(result!=null){
					e.preventDefault();
					var myStamp = result.result;  //스탬프갯수 가져오기
					var cf = confirm("HIT 스탬프 획득 완료!\n현재스탬프 : "+myStamp+"개\n히트브랜드 페이지로 이동하시겠습니까?");
					// 확인 클릭시 히트브랜드 프로모션으로 이동
					if ( cf ) location.href = "/eventPlanZone/jsp/HitBrand_202112.jsp";
					// 스탬프 가리기
					$('.hit_stamp').fadeOut(100);	
				}
			}
		});	
	}
})

function cmdDetailPrint(){
    var detailPrint = window.open("/view/DetailmultiPrint.jsp?modelno="+gModelData.gModelno, "", "width=740,height=900,toolbar=no,directories=no,status=no,scrollbars=yes,resizable=yes,menubar=no,top=100,left=100");
    detailPrint.focus();
}

function shareUrl(type) {
    var pcUrl = location.href;
    var mUrl = "http://m.enuri.com/m/vip.jsp?modelno="+gModelData.gModelno;
    var content = gModelData.gModelNm;

	if(content.length>0) {
		// 트위터
		if(type==1) {
            insertLog(14471);
			window.open("http://twitter.com/intent/tweet?text="+encodeURIComponent(content)+"&url="+encodeURIComponent(pcUrl), "_new");
		}
		// 페이스북
		if(type==2) {
            insertLog(14470);
			window.open("http://www.facebook.com/sharer.php?u="+encodeURIComponent(pcUrl), "_new");
		}
		// 카카오
		if(type==3) {
            insertLog(24461);
            Kakao.Link.sendDefault({
                objectType: 'commerce',
                content: {
                    title: '[에누리 가격비교]\n' + gModelData.gModelNm,
                    imageUrl: gModelData.gImageUrl,
                    link: {
                        mobileWebUrl: mUrl,
                        webUrl: pcUrl
                    }
                },
                commerce: {
                    regularPrice: gModelData.gMinPrice
                },
                buttons: [{
                    title: '상품 상세정보 보기',
                    link: {
                        mobileWebUrl: mUrl,
                        webUrl: pcUrl
                    }
                }]
            });
		}
	}
}


// 가격수정
function sdul_update_price() {
    // 브라우져 체크 IE외에는 지원 안함
    insertLog(2238);
    var sdulWin = window.open("/sdul/sell/Sdul_Update_Price.jsp?modelno=" + gModelData.gModelno, "sduladd", "width=462,height=420,toolbar=no,directories=no,status=no,scrollbars=no,resizable=no,menubar=no,top=100,left=100");
    sdulWin.focus();
}

// Speed등록
function sdul_add() {
    var sdulWin = window.open("/sdul/sell/Sdul_Add.jsp?modelno=" + gModelData.gModelno, "sduladd", "width=462,height=420,toolbar=no,directories=no,status=no,scrollbars=yes,resizable=no,menubar=no,top=0,left=100");
    sdulWin.focus();
}

// 모델복사
function modelno_copy() {
    if (confirm("현재 상품의 모델번호는 " + gModelData.gModelno + "입니다.\r\n확인을 누르시면 모델번호가 복사됩니다.\r\n원하는 곳에 Ctrl+V 를 해주세요.")) {
        var modelnoStr = gModelData.gModelno + "";
        if (window.clipboardData) {
            window.clipboardData.setData("Text", modelnoStr);
        } else if (window.netscape) {
            try {
                netscape.security.PrivilegeManager.enablePrivilege('UniversalXPConnect');
                var clip = Components.classes['@mozilla.org/widget/clipboard;1'].createInstance(Components.interfaces.nsIClipboard);
                if (!clip) return;
                var trans = Components.classes['@mozilla.org/widget/transferable;1'].createInstance(Components.interfaces.nsITransferable);
                if (!trans) return;
                trans.addDataFlavor('text/unicode');
                var str = new Object();
                var len = new Object();
                var str = Components.classes['@mozilla.org/supports-string;1'].createInstance(Components.interfaces.nsISupportsString);
                var copytext = modelnoStr;
                str.data = copytext;
                trans.setTransferData('text/unicode', str, copytext.length * 2);
                var clipid = Components.interfaces.nsIClipboard;
                if (!clipid) return false;
                clip.setData(trans, null, clipid.kGlobalClipboard);
            } catch (e) {
                alert("signed.applets.codebase_principal_support를 설정해주세요!");
            }
        } else {
            alert("해당 브라우저에서는 지원하지 않습니다.");
        }
    }
}

//direct 등록
function sdul_add2() {
    var sduWin = window.open("/sdul/sell/Sdul_Add2.jsp?modelno=52422982","sduadd","width=462,height=420,toolbar=no,directories=no,status=no,scrollbars=yes,resizable=no,menubar=no,top=100,left=100");
    sduWin.focus();
}

// 웹검색
function openWebSearch(keyword, cate, price) {
    var surl = "/search/Searchlist.jsp?searchkind=2&keyword=" + escape(keyword) + "&cate=" + cate + "&m_price=" + price;
    var win = window.open(surl);
    win.focus();
}

//뉴스관리팝업
function knowBoxNewsSetPopup() {
    var url = "/view/goodsbbs/Goods_Info_KnowNewsSet.jsp?modelno=52422982&smodelnos=53540552,52422982";
    var winsobj = window.open(url,"knowBoxNewsSet");
}
// 판매자 광고문구 노출 로그
function setSellerAdLog(pl_no) {
    var param = {
        "pl_no": pl_no
    }
    $.ajax({
        type: "get",
        url: "/sdul/sad/ajax/Ajax_Sad_Explog_Insert.jsp",
        async: true,
        data: param,
        dataType: "data",
        success: function(data) {},
        error: function(xhr, ajaxOptions, thrownError) {
            // alert(xhr.status);
            // alert(thrownError);
        }
    });
}
function replaceImg(obj){
	$(obj).error(function(){
		$(obj).attr("src","http://img.enuri.info/images/home/thumb_none_300.jpg");
    });
	var imgsrc = $(obj).attr("src").replace("webimage_300","webimage2");
	$(obj).attr("src",imgsrc);
}

///////////////////////////////////////////////////// 모바일 최저가,전용 레이어 스크립트 시작 /////////////////////////////////////////////////////
function mobileMinPrice() {
	var mobileSendProdDivObj = $("#mobile_min_layer");

    $("#prod_summary_left .mobile__buy .btn").unbind().click(function(){
        mobileSendProdDivObj.show();
        mobileSendProdDivObj.find(".lay-mobile__qr img").attr("src", "");
        setQrCodeImg(gModelData.gModelno);
    });

	// 닫기 이벤트
	mobileSendProdDivObj.find(".lay-comm__btn--close").unbind().click(function() {
        $("#mobile_min_layer").hide();
	});

	// 핸드폰 전송 하단 레이어 열기
	mobileSendProdDivObj.find(".smsp").unbind().click(function() {
        mobileSendProdDivObj.find('.lay-mobile-sendsms').toggle();
	});

	// 찜하기 체크박스
	mobileSendProdDivObj.find(".btn-mobile--zzim").unbind().click(function() {
        showLayZzim(this,gModelData.gModelno);
	});

	// 에누리앱 설치
	mobileSendProdDivObj.find(".btn-mobile--app").unbind().click(function() {
		window.open("/common/jsp/App_Landing.jsp");
	});

	// 핸드폰 번호 전송
	mobileSendProdDivObj.find(".sendsms__form--btn").click(function() {
		sendDetailSms(this, "detail",gModelData.gModelno, gModelData.gModelNmView);
	});
}
///////////////////////////////////////////////////// 모바일 최저가,전용 레이어 스크립트 끝 ////////////////////////////////////////


function minPriceAlarmInfo(){
    $.ajax({
        type : "get", 
        url : "/wide/api/product/prodAlarm.jsp",
        data : {"modelno":gModelData.gModelno},
        dataType : "json", 
        success : function(json){
            if(json.success){
                drawMinPriceAlarm(json);
            }else{

            }
        }
    });
}
function drawMinPriceAlarm(json){
    var html ="";
    var week_minprice = json.data.week_minprice;
    var month1_minprice = json.data.month1_minprice;
    var month3_minprice = json.data.month3_minprice;
    var range_minprice = gModelData.gMinPrice;
    if(gModelData.gMinPrice > 0){
        if(month3_minprice > 0){ 
            month3_minprice = (month3_minprice < gModelData.gMinPrice ? month3_minprice : parseInt(gModelData.gMinPrice * (1 - (1 / 100))));
        }
        if(month1_minprice > 0){ 
            month1_minprice = (month1_minprice < gModelData.gMinPrice ? month1_minprice : parseInt(gModelData.gMinPrice * (1 - (1 / 100))));
        }
        if(week_minprice > 0){ 
            week_minprice = (week_minprice < gModelData.gMinPrice ? week_minprice : parseInt(gModelData.gMinPrice * (1 - (1 / 100))));
        }
    }
    html +=  " <div class=\"dimmed\">";
    html +=  "   <div class=\"lay-alarm lay-comm\">";
    html +=  "       <div class=\"lay-comm--head\">";
    html +=  "           <strong class=\"lay-comm__tit\">가격알림 <span class=\"tx_sub\">원하는 가격이 되면 알려드립니다.</span></strong>";
    html +=  "       </div>";
    html +=  "       <div class=\"lay-comm--body\">";
    html +=  "           <div class=\"lay-comm--inner\">";
    html +=  "               <div class=\"row row--prod\">";
    html +=  "                   <p class=\"thum\"><img src=\""+gModelData.gImageUrl+"\" alt=\"\"></p>";
    html +=  "                   <div class=\"tx_source\">";
    html +=  "                       <p class=\"tx_name\">"+gModelData.gModelNmView+"</p>";
    html +=  "                       <p class=\"tx_info\">"+gModelData.gFactory+", "+gModelData.gCdate+" 출시</p>";
    if(gModelData.gMinPrice > 0){
        html +=  "                       <p class=\"tx_price\">현재 최저가<em>"+gModelData.gMinPrice.format()+"</em>원</p>";
    }else{
        html +=  "                       <p class=\"tx_price\">현재 최저가 정보가 없습니다.</p>";
    }
    html +=  "                   </div>";
    html +=  "               </div>";
    if(gModelData.gMinPrice > 0){
        html +=  "               <div class=\"row row--ipt\">";
        html +=  "                   <div class=\"row--ipt__head\">";
        html +=  "                       <p class=\"tx_tit\">최저가설정</p>";
        html +=  "                       <ul class=\"tx_sort__list\">";
        if(week_minprice > 0){
            html +=  "                           <li class=\"attrs\">";
            html +=  "                               <input type=\"checkbox\" id=\"id1\" name=\"chk_period\" class=\"input--checkbox-item\" value=\""+week_minprice+"\">";
            html +=  "                               <label for=\"id1\" title=\"일주일\">일주일</label>";
            html +=  "                           </li>";
        }
        if(month1_minprice > 0){
            html +=  "                           <li class=\"attrs\">";
            html +=  "                               <input type=\"checkbox\" id=\"id2\" name=\"chk_period\" class=\"input--checkbox-item\" value=\""+month1_minprice+"\">";
            html +=  "                               <label for=\"id2\" title=\"1개월\">1개월</label>";
            html +=  "                           </li>";
        }
        if(month3_minprice > 0){
            html +=  "                           <li class=\"attrs\">";
            html +=  "                               <input type=\"checkbox\" id=\"id3\" name=\"chk_period\" class=\"input--checkbox-item\" value=\""+month3_minprice+"\">";
            html +=  "                               <label for=\"id3\" title=\"3개월\">3개월</label>";
            html +=  "                           </li>";
        }
        html +=  "                       </ul>";
        html +=  "                   </div>";
        html +=  "                   <div class=\"row--ipt__body\">";
        html +=  "                       <div class=\"range__bar\">";
        html +=  "                           <input type=\"range\" id=\"setpricerange\" name=\"\" min=\"10\" max=\""+(gModelData.gMinPrice-10)+"\" step=\"1\" >";
        html +=  "                       </div>";
        html +=  "                       <div class=\"range__ipt\">";
        html +=  "                           <div class=\"range__ipt_percent\">";
        html +=  "                               <label>";
        html +=  "                                   <span class=\"tx_tit\">할인율 입력</span>";
        html +=  "                                   <input class=\"tx_ipt\" type=\"text\" id=\"setrate\" name=\"\">";
        html +=  "                                   <span class=\"tx_unit\">%</span>";
        html +=  "                               </label>";
        html +=  "                           </div>";
        html +=  "                           <div class=\"range__ipt_price\">";
        html +=  "                               <label>";
        html +=  "                                   <span class=\"tx_tit\">설정가</span>";
        html +=  "                                   <input class=\"tx_ipt\" type=\"text\" id=\"setprice\" name=\"\" placeholder=\"알림신청 가격을 입력하세요\">";
        html +=  "                                   <span class=\"tx_unit\">원</span>";
        html +=  "                               </label>";
        html +=  "                           </div>";
        html +=  "                       </div>";
        html +=  "                   </div>";
        html +=  "               </div>";
    }else{
        html +=  "               <div class=\"row row--ipt\">";
        html +=  "                   <div class=\"row--ipt__head\">";
        html +=  "                       <p class=\"tx_tit\">가격 알림 설정</p>";
        html +=  "                       <p class=\"tx_sub\">설정한 가격대에 도달하면 알림으로 알려드립니다.</p>";
        html +=  "                   </div>";
        html +=  "                   <div class=\"row--ipt__body\">";
        html +=  "                       <div class=\"setprice__ipt\">";
        html +=  "                           <label>";
        html +=  "                               <span class=\"tx_tit\">설정가</span>";
        html +=  "                               <input type=\"text\" id=\"setprice\" name=\"\" class=\"tx_ipt\" placeholder=\"알림신청 가격을 입력하세요\">";
        html +=  "                               <span class=\"tx_unit\">원</span>";
        html +=  "                           </label>";
        html +=  "                       </div>";
        html +=  "                   </div>";
        html +=  "               </div>";
    }
    html +=  "               <div class=\"row row--regist\">";
    html +=  "                   <form method=\"\">";
    html +=  "                       <ul class=\"tx_userinfo\">";
    html +=  "                           <li>";
    html +=  "                               <label>";
    html +=  "                                   <span class=\"tx_tit\">휴대폰</span>";
    html +=  "                                   <span class=\"tx_phone\">";
    //html +=  "<input type=\"text\" id=\"phonenum1\" name=\"phonenum1\" class=\"tx_ipt\" maxlength=\"3\" />";
    //html +=  "<input type=\"text\" id=\"phonenum2\" name=\"phonenum2\" class=\"tx_ipt\" maxlength=\"4\" />";
    //html +=  "<input type=\"text\" id=\"phonenum3\" name=\"phonenum3\" class=\"tx_ipt\" maxlength=\"4\" />";
    html +=  "                                       <input type=\"text\" id=\"phonenum\" name=\"phonenum\" class=\"tx_ipt tx_ipt--exp\" maxlength=\"11\" placeholder=\"숫자만 입력해 주세요.\">";
    html +=  "                                   </span>";
    html +=  "                               </label>";
    html +=  "                           </li>";
    html +=  "                       </ul>";
    html +=  "                       <button type=\"button\" class=\"btn btn__regist\">가격알림등록</button>";
    html +=  "                   </form>";
    html +=  "                   <p class=\"tx_tip\">휴대폰 번호 입력 시 문자로 알림을 받으실 수 있습니다.<br>(입력하신 정보는 다른 용도로 사용되지 않습니다.)</p>";
    html +=  "               </div>";
    html +=  "           </div>";
    html +=  "       </div>";
    html +=  "       <button class=\"lay-comm__btn--close comm__sprite\" onclick=\"$(this).closest('.lay--dimm-wrap').hide()\">레이어 닫기</button>";
    html +=  "   </div>";
    html +=  "</div>";
    $("#MINPRICEALARMLAYER").html(html);
    $('#MINPRICEALARMLAYER').show();
    //마지막 체크박스 true;
    var defaultObj =  $("#MINPRICEALARMLAYER").find(".tx_sort__list li:last-child input");
    var defaultMinPrice = gModelData.gMinPrice;
    if(defaultObj.length > 0){
        defaultMinPrice = parseInt(defaultObj.val());
        defaultObj.prop("checked",true);
    }else{
        defaultMinPrice = parseInt(gModelData.gMinPrice * (1 - (1 / 100)));
    }
    $("#setprice").val(parseInt(defaultMinPrice).format());
    $("#setpricerange").val(defaultMinPrice);
    $("#setrate").val(parseInt(((gModelData.gMinPrice - defaultMinPrice) / gModelData.gMinPrice) * 100));

    // 최저가 알림가격 입력
    $('#setprice').on("keyup",function(e) {
        var regnumExp = /^[0-9]+$/;
        var noti_price = $("#setprice").val().replace(/,/g, '');
        if(e.keyCode!=8){
            if (!regnumExp.test(noti_price)) {
                noti_price = noti_price.replace(regnumExp, '');
                alert("숫자만 입력해주세요.");
                noti_price = gModelData.gMinPrice-10;
            }
        }
        if(noti_price.length>0){
            // (현재최저가-알림가격/현재최저가) x 100
            var noti_rate = parseInt(((gModelData.gMinPrice - noti_price) / gModelData.gMinPrice) * 100);
            if(noti_rate>100){
                alert("100%를 초과할수 없습니다."); 
                noti_rate = 99;
                noti_price = parseInt(gModelData.gMinPrice * (1 - (noti_rate / 100)));
            }else if(noti_rate<0){
                alert("현재 최저가를 초과할 수 없습니다.");
                noti_rate = 1;
                noti_price = parseInt(gModelData.gMinPrice * (1 - (noti_rate / 100)));
            }
            $('#setprice').val(noti_price.format());
            $('#setrate').val(noti_rate);
            $("#setpricerange").val(noti_price);
            $("#MINPRICEALARMLAYER").find(".tx_sort__list input").prop("checked",false);
            $($("#MINPRICEALARMLAYER").find(".tx_sort__list input").get().reverse()).each(function(){
                var vThisPrice =  $(this).val();
                if(noti_price == parseInt(vThisPrice)){
                    $(this).prop("checked",true);
                    return false; 
                }
            });
        }
    });
    // 최저가 할인율 입력
    $("#setrate").on("keyup",function(e) {
        var regnumExp = /^[0-9]+$/;
        var noti_rate = $('#setrate').val();
        if(e.keyCode!=8){
            if (!regnumExp.test(noti_rate)) {
                alert("숫자만 입력해주세요.");
                noti_rate = 1;
                //return false
            }else{
                if(noti_rate>99){
                    alert("100%를 초과할 수 없습니다.");
                    noti_rate = 99;
                }
            }
        }
        // (현재최저가-알림가격/현재최저가) x 100
        var noti_price = parseInt(gModelData.gMinPrice * (1 - (noti_rate / 100)));
        if(noti_rate > 100){
            noti_price = parseInt(gModelData.gMinPrice * (1 - (noti_rate / 100)));
        }
        $("#setrate").val(noti_rate);
        $("#setprice").val(noti_price.format());
        $("#setpricerange").val(noti_price);
        $("#MINPRICEALARMLAYER").find(".tx_sort__list input").prop("checked",false);
        $($("#MINPRICEALARMLAYER").find(".tx_sort__list input").get().reverse()).each(function(){
            var vThisPrice =  $(this).val();
            if(noti_price == parseInt(vThisPrice)){
                $(this).prop("checked",true);
                return false; 
            }
        });
    });

    $("#MINPRICEALARMLAYER").find(".tx_sort__list li").unbind().click(function(){
        $("#MINPRICEALARMLAYER").find(".tx_sort__list input").prop("checked",false);
            $(this).find("input").prop("checked",true);
            var vThisPrice =  $(this).find("input").val();
            var noti_rate = parseInt(((gModelData.gMinPrice - vThisPrice) / gModelData.gMinPrice) * 100);
            $("#setpricerange").val(parseInt(vThisPrice));
            $('#setprice').val(parseInt(vThisPrice).format());
            $('#setrate').val(noti_rate);
        });
    //알림신청
    if($("#setpricerange").length > 0){
        document.getElementById("setpricerange").onchange = function() {
            var vThisPrice = this.value;
            $("#setprice").val(vThisPrice.format());
            $('#setrate').val(parseInt(((gModelData.gMinPrice - this.value) / gModelData.gMinPrice) * 100));
            $("#MINPRICEALARMLAYER").find(".tx_sort__list input").prop("checked",false);
            $($("#MINPRICEALARMLAYER").find(".tx_sort__list input").get().reverse()).each(function(){
                if(parseInt(vThisPrice) == parseInt($(this).val())){
                    $(this).prop("checked",true);
                    return false; 
                }
            });
        }
    }
    $("#MINPRICEALARMLAYER").find(".dimmed").click(function(){
        $(this).closest('.lay--dimm-wrap').hide();
    });
    $("#MINPRICEALARMLAYER").find(".dimmed").unbind().mousedown(function(e){
        if($(e.target).hasClass("dimmed")){
            $(this).closest('.lay--dimm-wrap').hide();
        }
    });
    $("#MINPRICEALARMLAYER").find(".lay-alarm .btn__regist").click(function() {
        var regemailExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
        //var reghpExp = /^\d{3}-\d{3,4}-\d{4}$/;
        var reghpExp = /(01[016789])(\d{4}|\d{3})(\d{4})$/g;
        var regnumExp = /^[0-9]+$/;
        var setprice = $('#setprice').val();
        var setrate = $('#setrate').val();
        var phonenum = $('#phonenum').val();
        //var mailaddr = $('#mailaddr').val();
        var phonenum1 = "";
        var phonenum2 = "";
        var phonenum3 = "";
        if (setprice != "") {
            if (!regnumExp.test(setprice.replace(/,/g, ''))) {
                alert("알림가를 다시 입력하세요.");
                return false;
            }else{
                 if(setprice.replace(/,/g, '')==0){
                    alert("가격 알림은 1원 이상부터 등록 가능합니다.");
                    return false;
                } 
            }
        } else {
            alert("알림가를 입력하세요.");
            return false
        }
        if($('#setrate').length > 0){
            if (setrate != "") {
                if (!regnumExp.test(setrate.replace(/,/g, ''))) {
                    alert("할인율을 다시 입력하세요.");
                    return false;
                }
            } else {
                alert("할인율을 입력하세요.");
                return false;
            }
        }
        var chkFlg = reghpExp.test(phonenum);
        if(!chkFlg) {
            alert("잘못된 형식의 휴대폰 번호입니다.");
            return;
        }else{
            phonenum1 = phonenum.replace(reghpExp,"$1");
            phonenum2 = phonenum.replace(reghpExp,"$2");
            phonenum3 = phonenum.replace(reghpExp,"$3");
        }
    /*  if (mailaddr != "") {
            if (!regemailExp.test(mailaddr)) {
                alert("잘못된 이메일형식입니다.다시 입력하세요.");
                return false
            }
        }
        if (phonenum1 != "" && phonenum2 != "" && phonenum3 != "") {
            if (!reghpExp.test(phonenum1 + "-" + phonenum2 + "-" + phonenum3) || !regnumExp.test(phonenum1) || !regnumExp.test(phonenum2) || !regnumExp.test(phonenum3)) {
                alert("잘못된 휴대폰 번호입니다. 다시 입력하세요.");
                return false
            }
        }
        if (mailaddr == "" && phonenum1 == "" && phonenum2 == "" && phonenum3 == "") {
            alert("이메일 또는 휴대폰 번호를 입력해주세요.");
            return false
        } */
        var param = "setprice=" + setprice.replace(/,/g, '') + "&phonenum1=" + phonenum1 + "&phonenum2=" + phonenum2 + "&phonenum3=" + phonenum3 + "&modelno=" + gModelData.gModelno;
        setNoticePrice(param);
    });
}

function setNoticePrice(param) {
    $.ajax({
        type: "get",
        url: "/lsv2016/ajax/detail/setNoticePrice_ajax.jsp",
        async: true,
        data: param,
        dataType: "json",
        success: function(result) {
            var status = result["status"];
            var msg = "";
            if(status=="1"){
                if(gModelData.gMinPrice > 0){
                    insertLogLSV(24633,gModelData.gCategory.toString(),gModelData.gModelno.toString());
                }else{
                    insertLogLSV(24634,gModelData.gCategory.toString(),gModelData.gModelno.toString());
                }
                msg = "가격 알림이 신청되었습니다.";
            }else if(status=="99"){
                msg = "월 최대 발송량을 초과하였습니다.\n다음달에 이용해주세요";
            }else {
                msg = "가격 알림 신청이 실패 했습니다.\n지속적인 오류 발생 시 관리자에게 문의하여 주시기 바랍니다.";
            }
            alert(msg);
            $("#MINPRICEALARMLAYER").hide();
            $("#MINPRICEALARMLAYER").find(".lay-alarm input[type='text']").val("");
        }
    });
}