var vPc_price = "";
vPc_price += "<div class=\"noListInfo\">";
vPc_price += "	<p class=\"txt\">해당 상품은 판매 쇼핑몰 정책상<br>에누리 PC웹에서 '최저가'로 구매가능합니다. <br> <strong>'찜하기' 후 PC웹으로 접속해주세요.</strong></p>";
vPc_price += "	<button class=\"btnzzim\" onclick=\"$('#btn_zzim').click();$('#layerLowPrice').hide();\">찜하기</button>";
vPc_price += "</div>";

// 판매예정, 품절상품
// <li>
// <div class="noListInfo" id="none_list" style="display:none;">
// <p class="txt">가격 정보가 없습니다.</p>
// <button class="btnzzim">찜하기
// <div class="zzimarea"><span class="zzimly fade-out">찜 되었습니다</span></div>
// </button>
// </div>
// </li>

var vComponent_detaill; // 각성분별내용리스트
var v1_txt = ""; // 좋은성분
var v2_txt = ""; // 주의성분
var v3_txt = ""; // 피부타입별
var vEbay_cpc = false;

/* 상품평에서 사용하는 변수 */
var gbPage = 1;
var gbPageSize = 10;
var iPoint = 0;
var nnos = "";
var shopCodeList = "";
var strNoShopCode = "";
var vFirst_review_cnt = false;
var vFirst_review = false;

/* 포토상품평에서 사용하는 변수 */
var gbPage_photo = 1;
var gbPageSize_photo = 10;

/* 블로그, 영상에서 사용하는 변수 */
var pageNum = 1;
var pageSize = 6;
var endPage = 1;
var imageRoot = "http://storage.enuri.info/pic_upload/enurinews_thumbnail/"
var errImgSrc = "http://img.enuri.info/images/home/thumb_subst.jpg";

var activeTab = "";
var vTableCnt = 8; //추천상품 비교표 해드갯수

var vWord_code = ""; //필터 코드
//SR : 32236 요청에 따른 카테고리 제외 : 0904
//var vCard_cate_ex = ",1201,1202,1204,1205,0904,";
var vCard_cate_ex = ",1201,1202,1204,1205,145530,";


/* 추천상품에서 사용하는 변수 */
var isLoadRecommand = "N";

$(function() {
    $("header").hide();
    if (vAppyn == 'Y') {
        $(".m_top_sub").hide();
    } else {
        $(".m_top_sub").show();
    }
    $("#vip_srp").click(function() {
        //searchOpen();		 
        $("#searchWrap").show();
        $(".sch_box_area .sub").show();
        $(".sch_box_area").show();
        $("#search_keyword").focus();
        searchLockScroll();
        ga_new(2, '');
    });
    /*
     * var aa = document.getElementById("d_img").clientWidth; var bb =
     * document.getElementById("d_img").clientHeight;
     * 
     * if(aa > bb){ $("#d_img").css("width","100%");
     * $("#d_img").css("height",""); }else if(aa < bb){
     * $("#d_img").css("width",""); $("#d_img").css("height","100%"); }else{
     * $("#d_img").css("width","100%"); $("#d_img").css("height","100%"); }
     */
    if (vAppyn == "Y") {
        $(".back").addClass("android");
    }

    varSNSTITLE = "에누리 가격비교";

    // 카카오톡 키
    Kakao.init('5cad223fb57213402d8f90de1aa27301');

    //카드정렬가 디폴트 카테
    if (vCard_cate_ex.indexOf("," + vCate4 + ",") > -1 || vCard_cate_ex.indexOf("," + vCate6 + ",") > -1) {
        toggleCard = 1;
        $("#toggle_card_price .toggle").addClass("on");
        //vListSort = "tabyn_card";
    }

    // 옵션정보
    getOption();
    // 가격비교정보
    getList();
    // 파워링크
    //setPowerLinkLink();
    getPowerLink("VIP", vCate4, "", false);
    // 둥둥배너
    bnrVip();
    // 상품후기
    getReview_preview();
    //하단 추천상품
    //getRecommend_bottom();
    // 카드 최저가 노출
    getMinCardPriceInfo();
    // 모바일 주의 사항 노출 ( 20191127 TLC )
    if (vTlcYn == "Y") {
        loadCaution();
    }


    // 스크롤바가 400 이상 내려갔을 경우에만 하단 추천 상품 호출 하도록 한다.
    // HTML Rendering 속도 이슈로 인한 리팩토링
    $(window).scroll(function() {
        if ($(this).scrollTop() >= 400 && isLoadRecommand == "N") {
            //하단 추천상품
            getRecommend_bottom();
            isLoadRecommand = "Y"; // 한번만 통신하기 위해 Flag 처리
        }
    });

    insertLog('11080');

    // bar
    vTab1 = $("#tab1");
    vTab2 = $("#tab2");
    vTab3 = $("#tab3");
    vTab4 = $("#tab4");

    vTab1.click(function(e) {
        vListnow = 0;
        vListpage = 1;
        //getList();

        insertLog('11032');
        ga('send', 'event', 'mf_vip', 'vip', 'vip_가격비교');
    });
    vTab2.click(function(e) {
        vListnow = 0;
        getCMVideo();
        getGuide();
        //getGuide는 시간갭이 조금있어서 클릭시 노출되어야 하는 소스는 함수 하단에 위치해야함.
        insertLog('11033');
        ga('send', 'event', 'mf_vip', 'vip', 'vip_상품설명');
    });
    vTab3.click(function(e) {
        vListnow = 0;
        if (!vFirst_review) {
            fn_goods_bbs(); // 상단 그래프
            fn_bbs_filter(); //주제별
            vFirst_review = true;
        }
        gbPage = 1;
        gbPage_photo = 1;
        getReview();

        //블로그, 동영상 사전 세팅
        fn_potal_api_info();

        $("#bottom_recommend").hide();

        //$("#blog_div").hide();
        //$("#blog_div").hide();

        $("#blog_more").attr("href", "http://search.zum.com/search.zum?method=blog&option=accu&query=" + fn_keyword_chang(vModelnm) + "&cm=tab&co=4&freetoken=outlink");
        $("#video_more").attr("href", "http://search.zum.com/search.zum?method=video&option=accu&query=" + fn_keyword_chang(vModelnm) + "&cm=tab&co=4&freetoken=outlink");

        insertLog('11034');
        ga('send', 'event', 'mf_vip', 'vip', 'vip_상품평');
    });
    vTab4.click(function(e) {
        vListnow = 0;
        setTimeout(function() {
            getRecommend();
            $("#bottom_recommend").hide();
        }, 200);

        insertLog('11034');
        ga('send', 'event', 'mf_vip', 'vip', 'vip_추천상품');
    });

    /*포토/일반상품평 탭 on,off*/
    $(".rv_tabs ul li a.rvtab").click(function() {
        var _span = $(this).find("span");

        if (_span.text() != "0") {
            $(".rv_tabs ul li a.rvtab").removeClass("on");
            $(this).addClass("on");
            $(".rvcont").hide();
            var activeTab = $(this).attr("href");
            $(activeTab).fadeIn();

            if (activeTab == "#rvtab1") {
                reviewBind('photo');
                $(".btnWrite").hide();
                ga_new(20, '');
            } else {
                reviewBind('normal');
                $(".btnWrite").show();
                ga_new(21, '');
            }
        }
        return false;
    });

    vS_kakao.click(function(e) {
        //alert("카카오톡 공유 서비스 개선 중입니다.\n이용에 불편을 드려 죄송합니다.");		// 임시 alert
        ga('send', 'event', 'mf_vip', 'vip', 'vip_공유_kakao');
    });
    vS_line.click(function(e) {
        CmdShare_detail("line");
    });
    vS_face.click(function(e) {
        CmdShare_detail("face");
    });
    vS_tw.click(function(e) {
        CmdShare_detail("tw");
    });
    vS_sms.click(function(e) {
        CmdShare_detail("sms");
    });
    vS_copy.click(function(e) {
        CmdShare_detail("copy");
    });

    $(".cont_area").hide();
    $("#bottom_recommend").show();
    $(".tabs li:first").addClass("on").show();
    $(".cont_area:first").show();

    //가격알림 표시
    if (vAppyn == "Y") {
        getAlarm();
    }

    //성인인증 하러가기
    $("#adult_go").click(function() {
        if (vAppyn == "Y") { // 앱일때
            if (window.android) {
                window.android.callAdultAuth();
            } else {
                location.href = "calladultauth://";
            }
        } else {
            location.href = "/mobilefirst/login/adult.jsp?app=" + vAppyn + "&backUrl=" + encodeURIComponent(document.location.href);
            //window.open("/mobilefirst/login/adult.jsp?app="+ vAppyn +"&backUrl="+encodeURIComponent(document.location.href) + "");
        }
    });

    // On Click Event
    $(".tabs li").click(function() {
        $(".tabs li").removeClass("on");
        $(this).addClass("on");
        $(".cont_area").hide();
        activeTab = $(this).find("a").attr("href");
        $(activeTab).fadeIn();

        $("body, html").animate({
            scrollTop: $("#tab_position").offset().top - 1
        }, 500);

        // 가격비교 탭이 on 일때만, .areaAmount 영역 보임
        if ($(this).find("a").hasClass("tab1") && $("#none_list").css("display") != "block")
            $(".areaAmount").fadeIn();
        else
            $(".areaAmount").hide();
        return false;
    });

    //찜하기
    $(".btnzzim").click(function() {
        $('#btn_zzim').click();
        ga('send', 'event', 'mf_vip', 'vip', 'vip_찜');
    });

    //옵션탭
    $(".optionTab li").click(function() {
        $(".optionTab li").removeClass("on");
        $(this).addClass("on");
        activeTab = $(this).find("a").attr("id");

        if (activeTab == "option_unit") {
            //alert("옵션 개당단가");
            $("#list_select .company").removeClass("on").addClass("off");
            $("#list_select .unit").removeClass("off").addClass("on");
            $("#optionlist_mallcnt").hide();
            $("#optionlist_unit").show();

            ga_new(7, '')
        } else if (activeTab == "option_mallcnt") {
            //alert("옵션 업체수");
            $("#list_select .company").removeClass("off").addClass("on");
            $("#list_select .unit").removeClass("on").addClass("off");
            $("#optionlist_mallcnt").show();
            $("#optionlist_unit").hide();

            ga_new(6, '')
        }

        return false;
    });

    if (vConstrain != "5") {
        if (vTab_Selected == "1") {
            vTab1.click();
            //select_list(intGroup,1);
        } else if (vTab_Selected == "2") {
            vTab2.click();
        } else if (vTab_Selected == "3") {
            setTimeout(function() {
                vTab3.click();
            }, 700);
        }
        vTab_Selected = "";
    } else {
        $(".prodDetailTab").addClass("tabType2");
        $("#li_tab3").hide();
        $("#li_tab2").hide();
        $("#li_tab1").addClass("on");
        vTab1.click();
    }

    $("#vip_srp").click(function() {
        $("#searchtxt").focus();
    });

    // 더보기
    $('.openBtn button').click(function() {
        var _this = $(this);
        _this.parent().parent().find('.shortBox').toggleClass('open');
        _this.toggleClass('on');
        _this.text('접기');
        if (_this.hasClass('on') != 1) {
            _this.text('더보기');
        }
    });

    // 구글 분석기.
    if (referrerPower.indexOf("list.jsp") > -1) {
        if (vCa_code.substring(0, 2) == "02" ||
            vCa_code.substring(0, 2) == "03" ||
            vCa_code.substring(0, 2) == "04" ||
            vCa_code.substring(0, 2) == "05" ||
            vCa_code.substring(0, 2) == "06" ||
            vCa_code.substring(0, 2) == "07" ||
            vCa_code.substring(0, 2) == "12" ||
            vCa_code.substring(0, 2) == "21" ||
            vCa_code.substring(0, 2) == "22" ||
            vCa_code.substring(0, 2) == "24") {
            ga('send', 'pageview', {
                'page': '/mobilefirst/detail.jsp?from=list_cm1',
                'title': 'mf_상품상세_카테고리_CM1'
            });
        } else {
            ga('send', 'pageview', {
                'page': '/mobilefirst/detail.jsp?from=list_cm2',
                'title': 'mf_상품상세_카테고리_CM2'
            });
        }
    } else if (referrerPower.indexOf("search.jsp") > -1) {
        ga('send', 'pageview', {
            'page': '/mobilefirst/detail.jsp?from=search',
            'title': 'mf_상품상세_검색'
        });
    }
    getVIPMiddleBanner();
    //배너 클릭시 - 액션은 다른곳에서 일어남. ga만 사용
    /*$(".vip_middle_banner").click(function(){
    	var vBanner_tmp = $(this).find("a").attr("href") + "";
    	var vBanner_no = "";
    	
    	if(vBanner_tmp.indexOf("register_no=") > -1 && vBanner_tmp.indexOf("&pageNm") > -1){
    		vBanner_no = vBanner_tmp.substring(vBanner_tmp.indexOf("register_no=")+12, vBanner_tmp.indexOf("&pageNm"));
    	}
    	ga_new(10,vBanner_no);
    });*/
    // 최근본app처리
    try {
        if (vAppyn == "Y") {
            var vAdult = vAdultchk;

            if (window.android) { // 안드로이드
                window.android.getRecentData(vModelnm, "G:" + vModelno, $("#d_img").attr("src"), location.href);
                window.android.getRecentData_adult(vModelnm, "G:" + vModelno, imgurl_org, location.href, vAdult);
            } else { // 아이폰에서 호출
                window.location.href = "enuriappcall://getRecentData?name=" +
                    encodeURIComponent(vModelnm) + "&code=G:" + vModelno +
                    "&imageurl=" +
                    encodeURIComponent($("#d_img").attr("src")) + "&url=" +
                    encodeURIComponent(location.href) + "&vAdult=" +
                    vAdult;

            }
        }
    } catch (e) {}

    // 소셜 일때 하단부 footer에서 배너와 바로가기 안보이기
    if (vSocial) {
        $(".family_app").hide();
        $(".rule").addClass("social");
        setTimeout(function() {
            $(".evtbanner_btm").hide();
        }, 2000);

    }

    /*추천상품 성/연령별 탭 on,off */
    $("#ftListNav li a").click(function() {
        $("#ftListNav li a").removeClass("on");
        $(this).addClass("on");
        $(".ftCont").hide();
        var activeTab = $(this).attr("href");
        var vCode = $(this).attr("code");
        $(activeTab).fadeIn();

        //td 높이 세팅
        /*
        for(var j=0;j<5;j++){
        	var vTh = $(".th_"+ vCode + "_"+(j+1)).height();
        	var vTd = $(".td_"+ vCode + "_"+(j+1)).height();
        	
        	if(vTh > vTd){
        		//$(".th_"+ vCode + "_"+ (j+1)).css("height",$(".th_"+ vCode + "_"+(j+1)).height());
        		$(".td_"+ vCode + "_"+(j+1)).css("height",$(".th_"+ vCode + "_"+(j+1)).height());
        	}else if(vTd > vTh){
        		$(".th_"+ vCode + "_"+ (j+1)).css("height",$(".td_"+ vCode + "_"+(j+1)).height());
        		//$(".td_"+ vCode + "_"+(j+1)).css("height",$(".td_"+ vCode + "_"+(j+1)).height());
        	}
        }
		
        for(var j=0;j<5;j++){
        	var vTh = $(".th_"+ vCode + "_"+(j+1)).height();
        	var vTd = $(".td_"+ vCode + "_"+(j+1)).height();
        	
        	$(".th_"+ vCode + "_"+ (j+1)).css("height",$(".td_"+ vCode + "_"+(j+1)).height());
        	$(".td_"+ vCode + "_"+(j+1)).css("height",$(".td_"+ vCode + "_"+(j+1)).height());
        }
        */
        for (var j = 0; j < vTableCnt; j++) {
            var highestBox = 0;
            $(".td_" + vCode + "_" + (j + 1)).each(function() {

                if ($(this).height() > highestBox)
                    highestBox = $(this).height();
            });

            if ($(".th_" + vCode + "_" + (j + 1)).height() > highestBox) {
                highestBox = $(".th_" + vCode + "_" + (j + 1)).height();
            }

            $(".th_" + vCode + "_" + (j + 1)).height(highestBox);
            $(".td_" + vCode + "_" + (j + 1)).height(highestBox);
        }

        //}catch(e){}

        return false;
    });

    // 이벤트
    // getHunting();

    // 로거에 담기
    _TRK_CP = "/" + vCa_code.substring(0, 2) + "/" + vCa_code.substring(2, 4) + "/" + vCa_code.substring(4, 6) + "/" + vCa_code.substring(6, 8);
});

function getOption() {
    // 옵션정보
    //if ($("#list_select").html() == "") {
    $.ajax({
        type: "GET",
        url: "/mobilefirst/ajax/detailAjax/get_option.jsp",
        async: false,
        data: "modelno=" + vModelno + "&delivery=" + toggleState,
        dataType: "JSON",
        success: function(json) {
            $("#list_select").html(null);

            if (json.optionDetail) {
                if (json.optionDetail[0].optionCnt < 1 || json.optionDetail[0].optionCondiname == "") {
                    $("#option_part").hide();
                    return false;
                } else {
                    // 옵션 단위당 단가 text
                    if (json.optionUnit != "") {
                        $("#option_unit").html(json.optionUnit.replace("*", ""));
                        $("#optionlist_unit").html(json.optionUnit.replace("*", ""));
                        $(".optionTab").show();
                    } else {
                        $(".optionTab").hide();
                    }
                    var vCompany_tab = "on";
                    var vUnit_tab = "off";
                    //현재보고있는 클릭탭
                    if (activeTab == "option_unit") {
                        vCompany_tab = "off";
                        vUnit_tab = "on";
                    }
                    var r1 = -1;
                    var r2 = -1;

                    var groupModelMaxCnt = 5;
                    var groupModelListObj = json.optionDetail;

                    //$.extend(groupModelListObj , json.optionDetail);

                    var tarray = groupModelListObj;
                    for (var i = 0; i < groupModelListObj.length; i++) {
                        var grouplistData = groupModelListObj[i];
                        var strOrderTag = grouplistData["optionRank"];
                        if (strOrderTag == "1") r1 = i;
                        if (strOrderTag == "2") r2 = i;
                        if (r1 > 0 && r2 > 0) break;
                    }
                    if (r1 >= groupModelMaxCnt && r2 >= groupModelMaxCnt) {

                        groupModelListObj.splice(groupModelMaxCnt - 2, 0, groupModelListObj[r1], groupModelListObj[r2]);
                        if (r1 > r2) {
                            groupModelListObj.splice(r1 + 2, 1);
                            groupModelListObj.splice(r2 + 2, 1);
                        } else {
                            groupModelListObj.splice(r2 + 2, 1);
                            groupModelListObj.splice(r1 + 2, 1);
                        }
                    } else if (r1 >= groupModelMaxCnt) {
                        if (r2 == (groupModelMaxCnt - 1)) {
                            groupModelListObj.splice(groupModelMaxCnt - 2, 0, groupModelListObj[r2], groupModelListObj[r1]);
                            groupModelListObj.splice(r2 + 2, 1);
                        } else {
                            groupModelListObj.splice(groupModelMaxCnt - 1, 0, groupModelListObj[r1]);
                        }
                        tarray.splice(r1 + 1, 1);
                    } else if (r2 >= groupModelMaxCnt) {
                        if (r1 == (groupModelMaxCnt - 1)) {
                            groupModelListObj.splice(groupModelMaxCnt - 2, 0, groupModelListObj[r1], groupModelListObj[r2]);
                            groupModelListObj.splice(r1 + 2, 1);
                        } else {
                            groupModelListObj.splice(groupModelMaxCnt - 1, 0, groupModelListObj[r2]);
                        }
                        groupModelListObj.splice(r2 + 1, 1);
                    }
                    var template = "";
                    var html = "";
                    $.each(groupModelListObj, function(index, listData) {
                        var vOptionModelno = listData["optionModelno"];
                        var vOptionDisplayDeliveryInfo = listData["display_deliveryinfo"];
                        var vOptionRentalflag = listData["optionRentalflag"];
                        var vOptionCondiname = listData["optionCondiname"];
                        var vOptionMallcnt = listData["optionMallcnt"];
                        var vOptionUnit = listData["optionUnit"];
                        var vOptionUnitprice = listData["optionUnitprice"];
                        var vOptionPrice = listData["optionPrice"];
                        var vOptionMinpriceflag = listData["optionMinpriceflag"];
                        var vOptionMinpricePcflag = listData["optionMinpricePcflag"];
                        var vOptionMinprice_delivery = listData["minprice_delivery"];
                        var vOptionCashPriceYn = listData["cashflag"];
                        var vOptionTlcMinPrice = listData["lngTlcMinPrice"];
                        var vOptionCashMinPrice = listData["lngCashMinPrice"];
                        html += "<tr id=\"optiondetail_" + vOptionModelno + "\" deliveryinfo=\"" + vOptionDisplayDeliveryInfo + "\">";
                        if (vOptionRentalflag != "") {
                            html += "		<td onclick=\"rental_go(" + vOptionModelno + ");\"><span id=\"select_mall_" + vOptionModelno + "\">";
                            html += "			<em class=\"type\">" + vOptionCondiname + "</em></span>";
                            html += "		</td>";
                            html += "		<td onclick=\"rental_go(" + vOptionModelno + ");\">";
                            html += "			<span class=\"company " + vCompany_tab + "\"  id=\"select_mallcnt_" + vOptionModelno + "\">";
                            if (vOptionMallcnt != "") {
                                html += "				<em>" + vOptionMallcnt + "</em>";
                            }
                            html += "			</span>";
                            html += "			<span class=\"unit " + vUnit_tab + "\">";
                            if (vOptionUnit != "" && vOptionUnitprice != "") {
                                html += vOptionUnitprice;
                            }
                            html += "			</span>";
                            html += "		</td>";
                            html += "		<td onclick=\"rental_go(" + vOptionModelno + ");\">";
                            html += "   	    <span class=\"priceLow\">";
                            html += "       		<span class=\"priceicon\">";
                            html += "       			<strong class=\"txtLow\"></strong>";
                            html += "				</span>";
                            html += "			<em>" + vOptionPrice + "</em>";
                            html += "			</span>";
                            html += "		</td>";
                        } else {
                            html += "		<td onclick=\"set_option(" + vOptionModelno + ");\">";
                            html += "			<span class=\"option\" id=\"select_mall_" + vOptionModelno + "\">";
                            html += "				<em class=\"type\">" + vOptionCondiname + "</em></span></td>";
                            html += "			<td onclick=\"set_option(" + vOptionModelno + ");\">";
                            html += "				<span class=\"company " + vCompany_tab + "\"  id=\"select_mallcnt_" + vOptionModelno + "\">";
                            if (vOptionMallcnt != "") {
                                html += "				<em>" + vOptionMallcnt + "</em>";
                            }
                            html += "				</span>";
                            html += "				<span class=\"unit " + vUnit_tab + "\">";
                            if (vOptionUnit != "" && vOptionUnitprice != "") {
                                html += vOptionUnitprice;
                            }
                            html += "			</span>";
                            html += "			</td>";
                        }
                        //	if(vOptionCashPriceYn!="Y"){
                        html += "			<td onclick=\"set_option(" + vOptionModelno + ");\">";
                        html += "				<span class=\"priceLow\">";
                        html += "					<span class=\"priceicon\">";
                        if (vOptionMinpriceflag != "") {
                            html += "					<strong class=\"txtLow\">최저가</strong>";
                        }
                        if (vOptionMinpricePcflag != "") {
                            html += "					<strong class=\"iconPc\">PC</strong>";
                        }
                        html += "					</span>";
                        if (toggleState == 0) {
                            html += "				<em>" + vOptionPrice + "</em>";
                        } else {
                            html += "				<em>" + vOptionMinprice_delivery + "</em>";
                        }
                        html += "				</span>";
                        html += "			</td>";
                        //}
                    });
                    if (html.length > 1) {
                        html = html.replace(/&amp;/gi, "&");
                        $("#list_select").html(html);

                        $("#option_part").show();
                    }

                    vOption_Cnt = json.optionDetail.length;

                    $("#optionlist_cnt").html("(" + vOption_Cnt + "개)");

                    $('#list_select tr').each(function() {
                        if ($(this).attr("id").indexOf(vModelno) > -1) {
                            $(this).addClass("selected");
                        }
                    });

                    if (vOption_Cnt > 5) {
                        $("#list_select > tr").hide();
                        $("#list_select > tr:nth-child(1)").show();
                        $("#list_select > tr:nth-child(2)").show();
                        $("#list_select > tr:nth-child(3)").show();
                        $("#list_select > tr:nth-child(4)").show();
                        $("#list_select > tr:nth-child(5)").show();

                        $("#optionMorearea").show();
                        $("#option_more_btn").removeClass("on");
                        $("#option_more_btn").html("더보기(5/" + vOption_Cnt + ")");

                        $("#option_more_btn").unbind("click");
                        $("#option_more_btn").click(function() {
                            $('#list_select tr').filter(':gt(4)').toggle();

                            if ($('#list_select tr').filter(':gt(4)').css("display") != "none") {
                                $("#option_more_btn").addClass("on");
                                $("#option_more_btn").html("접기");
                            } else {
                                $("#option_more_btn").removeClass("on");
                                $("#option_more_btn").html("더보기(5/" + vOption_Cnt + ")");
                            }

                            $("body, html").animate({ scrollTop: $("#option_part").offset().top }, 300);

                            vTab_top = vTab.offset().top;
                        });
                    } else if (vOption_Cnt > 0 && vOption_Cnt <= 5) {
                        $("#option_more_btn").hide();
                    } else {
                        // 단위환산가 없음 or 갯수가 1개일때
                        $("#option_part").hide();
                    }
                }
            } else {
                $("#option_part").hide();
                // $(".fixSelectoption").hide();
            }
        },
        error: function(xhr, ajaxOptions, thrownError) {
            // alert(xhr.status);
            // alert(thrownError);
        }
    });

    // 옵션명이 없을때는 칸을 줄여서 보여준다.
    if ($("#selected_option_txt").text() == "") {
        $(".amount").hide();
    }
    //}
}

function getList() {
    //현금몰 리스트
    getCashList();
    // 가격비교 리스트
    if (vPricestring == "품절" || vPricestring == "출시예정" || vPricestring == "단종") {
        if (vCashPrice.length > 0 && vCashMinYn == "Y") {
            $("#t_delivery_info").find(".i_delivery").html(vCashDelivery);
            // 배송비 포함 최저가 toggle
            $("#toggle_delivery_price .toggle").unbind("click");
            $("#toggle_delivery_price .toggle").click(function() {
                $(".tabs li").removeClass("on");
                if (toggleState == 0) {
                    $(this).addClass("on");
                    toggleState = 1;
                    getOption();
                    getList();
                    ga_new(5, '');
                } else {
                    $(this).removeClass("on");
                    toggleState = 0;
                    getOption();
                    getList();
                    ga_new(4, '');
                }
                $(".cont_area").hide();
                $(".tabs li:first").addClass("on").show();
                $(".cont_area:first").show();
            });
        }
        $("#none_list").show();
        // $("#list_head").hide();
        // $("#list_body").hide();
        $("#detail_list_more").hide();
        $("#detail_list").html(null);
    } else {
        // 가격비교 리스트
        var vList_data = "modelno=" + vModelno + "&page=" + vListpage;

        vList_data += "&tabinfoyn=Y";

        if (vListSort != "") {
            vList_data += "&" + vListSort + "=Y";
        }

        //카드할인가 적용버튼은 최저가일때만 노출
        if ($.trim(vListSort) == "" || vListSort == "tabyn_minsort") {
            $("#toggle_card_price").removeClass("blind");
        } else {
            if ($("#toggle_card_price").hasClass("blind")) {

            } else {
                $("#toggle_card_price").addClass("blind");
            }

        }

        //카드할인가 적용 버튼이 있을때만 바인딩
        //기준변경 -> 기존: 클릭시 카드 할인가만 보여줌. 변경 : 카드할인가 적용 정렬순으로 보여줌.
        if ($.trim(vListSort) == "" || vListSort == "tabyn_minsort") {
            $("#toggle_card_price .toggle").unbind("click");
            $("#toggle_card_price .toggle").click(function() {
                //$(".tabs li").removeClass("on");
                if (toggleCard == 0) {
                    $(this).addClass("on");
                    toggleCard = 1;
                } else {
                    $(this).removeClass("on");
                    toggleCard = 0;
                }

                getList();
            });
        }

        if (toggleState == 1) { //배송비 포함 최저가일때는 배송비 포함 최저가가 디폴트
            vList_data += "&tabyn_dminsort=Y";
        }

        // if(vInstanceMinPrice > 0){
        // vList_data += "&instanceminprice="+vInstanceMinPrice;
        // }

        if (vChkgroup) { // 그룹모델이면
            vList_data += "&modelnos=" + vMulti_Modelno;
        }

        //카드할인가순보기
        if (toggleCard == 1) {
            vList_data += "&card_sort=Y";
        }

        $.ajax({
            type: "GET",
            url: "/mobilefirst/ajax/detailAjax/get_list.jsp",
            data: vList_data,
            dataType: "JSON",
            success: function(json) {
                $("#detail_list").html(null);
                $("#detail_list_more").unbind("click");

                if (json.listContent) {

                    vList_Cnt = json.listCount;
                    // if(vInstanceMinPrice == 0){
                    // vInstanceMinPrice = json.instanceMinPrice;
                    // }
                    if (json.pcPriceyn == "Y") {
                        $(".pcLowPrice").show();
                        // $(".price1").html("<strong>PC</strong> 최저가");
                        $(".pricearea").show();
                    } else {
                        $(".pcLowPrice").hide();
                        // $(".price1").html("&nbsp;");
                        $(".pricearea").hide();
                    }

                    /*
                     * 삭제요청 #25565
                    if(vListSort == "tabyn_card"){
                    	$(".card_price").show();
                    }else{
                    	$(".card_price").hide();
                    }
                    */
                    //강제추가 상품은 상품명없음. 쇼핑몰 상품명으로 대체. 2017-11-28 18:40
                    var listContent = json["listContent"];
                    // 강제추가 상품은 상품명없음. 쇼핑몰 상품명으로 대체. 2017-11-28 18:40
                    var vTmpPlgoodsnm = $("#detail_modelnm").text();
                    var html = "";
                    var vShopbidflag, vShop_bid, vDetail_url, vMpriceflag;
                    var vMobl_Vip_Cpn_Icn_View_Yn, vMobl_Vip_Cpn_View_Dcd_C, vMobl_Promtn_Url, vMobl_Vip_Cpn_View_Str, vMobl_Vip_Cpn_View_Dcd_M, vMobl_coupon_txt;
                    var vShop_bid, vShopbidlogno_click;
                    var vMobileurl, vShopcode, vPlno, vGoodsCode, vInstancePrice, vCategory, vPrice, vMinprice, vShopname, vPlgoodsname, vDisplaydelivery, vTlcMinPrice;
                    var vGmarket_g9, vShopType;
                    var vCardflag, vCardname, vPriceCard;
                    var vCouponflag, vCardfreeflag, vAuthflag;
                    var vEventCouponCheck_etc, vEventCouponCss_etc, vEventCouponText_etc;
                    var vEmoneyShop = "";
                    var vCashFlag;
                    var vCashMallCnt = 0;
                    var vExEmoney = 0;
                    var vRewardRate = 0;
                    if (json.FstShop != "pc") {
                        $.each(listContent, function(index, listData) {
                            vShopbidflag = listData["shopbidflag"];
                            vShop_bid = listData["shop_bid"];
                            vDetail_url = listData["detail_url"];
                            vMpriceflag = listData["mpriceflag"];
                            vMobl_Vip_Cpn_Icn_View_Yn = listData["mobl_vip_cpn_icn_view_yn"];
                            vMobl_Vip_Cpn_View_Dcd_C = listData["mobl_vip_cpn_view_dcd_C"];
                            vShop_bid = listData["shop_bid"];
                            vShopbidlogno_click = listData["shopbidlogno_click"];
                            vMobileurl = listData["mobileurl"];
                            vShopcode = listData["shopcode"];
                            vPlno = listData["plno"];
                            vGoodsCode = listData["goodscode"];
                            vInstancePrice = listData["instanceprice"];
                            vCategory = listData["category"];
                            vPrice = listData["price"];
                            vMinprice = listData["minprice"];
                            vShopname = listData["shopname"];
                            vGmarket_g9 = listData["gmarket_g9"];
                            vCardflag = listData["cardflag"];
                            vCardname = listData["cardname"];
                            vPriceCard = listData["pricecard"];
                            vMobl_Promtn_Url = listData["mobl_promtn_url"];
                            vMobl_Vip_Cpn_View_Str = listData["mobl_vip_cpn_view_str"];
                            vMobl_Vip_Cpn_View_Dcd_M = listData["mobl_vip_cpn_view_dcd_M"];
                            vMobl_coupon_txt = listData["mobl_coupon_txt"];
                            vEventCouponCheck_etc = listData["eventCouponCheck_etc"];
                            vEventCouponCss_etc = listData["eventCouponCss_etc"];
                            vEventCouponText_etc = listData["eventCouponText_etc"];
                            vPlgoodsname = listData["plgoodsname"];
                            vCouponflag = listData["couponflag"];
                            vCardfreeflag = listData["cardfreeflag"];
                            vAuthflag = listData["authflag"];
                            vDisplaydelivery = listData["displaydelivery"];
                            vTlcMinPrice = listData["tlcMinPrice"];
                            vShopType = listData["shoptype"];
                            vCashFlag = listData["cashflag"];
                            vEmoneyShop = listData["emoneyshop"];
                            vRewardRate = listData["rewardRate"];
                            vExEmoney = parseInt(parseFloat(vRewardRate) * 0.01 * parseInt(vInstancePrice) / 10) * 10;
                            var vOvsCheck = (vShopcode == "8446" || vShopcode == "8447" || vShopcode == "8448" ||
                                vShopcode == "8826" || vShopcode == "8827" || vShopcode == "8828" || vShopcode == "8829") ? true : false;
                            if (vCashFlag == "Y") {
                                vCashMallCnt++;
                                return true;
                            }
                            var liClass = "list_li ";
                            var aOnclick = "";
                            var brandClass = "brand ";
                            var priceClass = "price ";
                            var shopTypeClass = "";
                            if (vShopType == "4") {
                                shopTypeClass = " comp type_npay ";
                            }
                            if (vAppyn == "Y") {
                                if (vShopbidflag != "" && vShop_bid != "" && vDetail_url != "") liClass += "haspreview ";
                                else if (vShopbidflag == "" && vMpriceflag != "" && vDetail_url != "") liClass += "haspreview";
                            }

                            if (vOvsCheck) {
                                liClass += "hasglobalprice";
                            } else if (vMobl_Vip_Cpn_Icn_View_Yn != "") {
                                liClass += "hasprice11st";
                            } else {
                                if (vMobl_Vip_Cpn_View_Dcd_C != "") liClass += "hasprice11st";
                                else liClass += "hascardprice";
                            }

                            if (vShop_bid != "") {
                                aOnclick += "insertLog_cate(" + vShopbidlogno_click + "," + vCate4 + ");";
                                brandClass += "shopbid_" + vShopcode;
                                priceClass += "spon";
                            }
                            aOnclick += "goShop('" + vMobileurl + "','" + vShopcode + "','" + vPlno + "','" + vGoodsCode + "','" + vInstancePrice + "','" + vCategory + "','" + vPrice + "','" + vMinprice + "',this," + vModelno + "); ";
                            html += "<li class=\"" + liClass + "\"	";
                            if (vAppyn != "Y") {
                                html += "shopcode=\"" + vShopcode + "\"";
                            }
                            html += ">";

                            html += "	<a href=\"javascript:void(0)\"; onclick=\"" + aOnclick + "\"  >";
                            html += "		<span class=\"" + brandClass + shopTypeClass + " \" >" + vShopname;
                            if (vShop_bid != "") {
                                html += "		<em class=\"spon\">스폰서</em>";
                            }
                            html += "		</span>";
                            /*if(vGmarket_g9 !=""){
                            	html +=" 	<span class=\"info_g9\">";
                            	html +="		<i class=\"ico_i\">i</i>";
                            	html +="		<span class=\"layer_g9\">본 상품은 G9로 이동되거나 가격이 다를 수 있습니다. 해당 쇼핑몰에서 정확한 정보를 확인 후 구매해주세요!";
                            	html +="			<i class=\"cls_x\">X</i>";
                            	html +="		</span>";
                            	html +="	</span>";
                            }*/
                            html += "		<span class=\"" + priceClass + "\">";
                            if (vListSort == "tabyn_card") {
                                if (vCardflag != "") {
                                    html += "		<strong class=\"txtCard\">" + vCardname + "</strong>";
                                }
                                if (vShop_bid != "") {
                                    html += "		<strong class=\"spon_min\">최저가</strong>";
                                }
                                html += "			<em>" + (vCardflag != "" ? vPriceCard : vPrice) + "</em>원";
                            } else {
                                if (vShop_bid != "") {
                                    html += "		<strong class=\"spon_min\">최저가</strong>";
                                }
                                html += "<em>" + vPrice + "</em>원</span>";
                                if (vCardflag != "") {
                                    html += "		<span class=\"price salecard\"><strong class=\"txtCard\">" + vCardname + "</strong><em>" + vPriceCard + "</em>원</span>";
                                }
                            }
                            html += "		</span>";
                            if (vMobl_Vip_Cpn_View_Dcd_C != "") {
                                html += "			<span class=\"price pm11st\" strUrl=\"" + vMobl_Promtn_Url + "\">" + vMobl_Vip_Cpn_View_Str + "</span>";
                            } else {
                                // 가격 서브 (카드할인가 및 기본할인가 영역)
                                if (vListSort == "tabyn_card") {
                                    html += "		<span class=\"price cardprice\">(판매가 <em>" + vPrice + "원</em>)</span>";
                                } else {
                                    if (vCardflag != "") {
                                        html += "	<span class=\"price cardprice\">(" + vCardname + " </strong><em>" + vPriceCard + "원</em>)</span>";
                                    }
                                }
                            }
                            // 카드적용가격이 있을때
                            html += "		<span class=\"info\">";
                            // 해외직구..
                            if (vOvsCheck) {
                                html += "<span class=\"global_noti\">구매 전 상품정보와 가격을 꼭 확인하세요!</span>";
                            }

                            // 프로모션 자동화
                            if (vMobl_Vip_Cpn_View_Dcd_M != "") {
                                html += "					<strong class=\"ll_coupon\" onclick=\"goEventCoupon('" + vMobl_Promtn_Url + "');return false;\">" + vMobl_Vip_Cpn_View_Str;
                                if (vMobl_Vip_Cpn_Icn_View_Yn != "") {
                                    html += "						<span class=\"ico_llcoupon\">쿠폰받기</span> ";
                                }
                                html += "					</strong>";
                            } else { // 기타다른 쿠폰문구 : 11번가 프로모션 없을 경우에만 노출 되도록 우선
                                // 순위 정함.
                                if (vEventCouponCheck_etc != "") {
                                    html += "						<p class=\"" + vEventCouponCss_etc + "\">" + vEventCouponText_etc + "<em class=\"ad\">AD</em></p>";
                                }
                            }
                            if (vPlgoodsname != "") {
                                html += vPlgoodsname;
                            } else {
                                html += vTmpPlgoodsnm;
                            }
                            html += "		</span>";

                            html += "	<span class=\"pro_spec\">";
                            if (parseInt(vTlcMinPrice) > 0) {
                                html += "<i class=\"i_tlc\">TLC카드가</i>";
                            }
                            if (vOvsCheck) {
                                html += " <i class=\"i_global\">해외직구</i>";
                            }
                            if (vCouponflag != "") {
                                html += "		<i class=\"i_coupon\">쿠폰</i>";
                            }
                            if (vCardfreeflag != "") {
                                html += "		<i class=\"i_gray\">무이자</i>";
                            }
                            if (vAuthflag != "") {
                                html += "		<i class=\"i_gray\">공식판매자</i>";
                            }
                            if (vCardflag != "") {
                                html += "		<i class=\"i_gray\">카드할인</i>";
                            }
                            if (vEmoneyShop != "" && vExEmoney > 0) {
                                html += "		<i class=\"i_emoneysave\"><strong>" + commaNum(vExEmoney) + "</strong>점 적립<em class=\"mw-only\">(앱전용)</em></i>";
                            }
                            if (vOvsCheck) {
                                html += " <i class=\"i_global_emoneysave\">적립</i>";
                            }
                            if (vMobl_coupon_txt != "") {
                                html += "		<span class=\"couponbadge\" onclick=\"goEventCoupon('" + vMobl_Promtn_Url + "');return false;\">";
                                html += "			<strong class=\"per\">";
                                html += "				<span class=\"num\">" + vMobl_coupon_txt + "</span> 할인";
                                html += "			</strong>";
                                html += "		</span>";
                            }
                            html += "		</span>";

                            html += "		<span class=\"delivery_info\">";
                            html += "			<i class=\"i_delivery\">" + vDisplaydelivery + "</i>";
                            html += "		</span>";
                            html += "	</a>";

                            if (vAppyn == "Y") { // 앱일때만 나옴
                                if (vShopbidflag != "") {
                                    if (vShop_bid != "" && vDetail_url != "") {
                                        html += "<div class=\"areaMore\"  onclick=\"show_detail('" + vDetail_url + "','" + vMobileurl + "','" + vShopcode + "','" + vPlno + "','" + vGoodsCode + "','" + vInstancePrice + "','" + vCategory + "','" + vPrice + "','" + vMinprice + "'," + vModelno + ",'" + vDisplaydelivery + "','" + vShopname + "','" + vShopbidlogno_click + "');\">";
                                        html += "	<button class=\"btnPreview\">상세정보 미리보기</button>";
                                        html += "</div>";
                                    }
                                } else {
                                    if (vMpriceflag != "" && vDetail_url != "") {
                                        html += "<div class=\"areaMore\"  onclick=\"show_detail('" + vDetail_url + "','" + vMobileurl + "','" + vShopcode + "','" + vPlno + "','" + vGoodsCode + "','" + vInstancePrice + "','" + vCategory + "','" + vPrice + "','" + vMinprice + "'," + vModelno + ",'" + vDisplaydelivery + "','" + vShopname + "','');\">";
                                        html += "	<button class=\"btnPreview\">상세정보 미리보기</button>";
                                        html += "</div>";
                                    }
                                }
                            }
                        });
                        if (vAppyn == "Y") {
                            $("#detail_list").addClass("isApp");
                        }
                        $("#detail_list").html(html);
                        var vCnt = json.listContent.length;
                        if (html.length > 1) {
                            $("#none_list").hide();
                            html = html.replace(/&amp;/gi, "&");
                            $("#detail_list").html(html);

                            // $("#list_head_sort").show();
                            // $("#detail_list_more").show();
                            // $(".infoBox").removeClass("box_no");

                            if (json.shopbidflag == "Y") {
                                insertLog_cate(json.shopbidlogno_view, vCate4); // 쇼핑몰 상위입찰 로그
                            }

                            $(".brand").each(function() {
                                if ($.trim($(this).text()) == 'PC 최저가') {
                                    $(this).parent().parent().hide();
                                }
                            });

                            $(".info_g9").click(function(event) {
                                event.stopPropagation();
                                $(".layer_g9").show();
                            });
                            $(".cls_x").click(function(event) {
                                event.stopPropagation();
                                $(".layer_g9").hide();
                            });

                            var ii = 0;

                            $(".list_li").each(function() {
                                if (ii > 19) { // 처음 50개
                                    $(this).hide();
                                }
                                ii++;
                            });

                            // vip 가격 비교 Google Analytic 추가 10개만 
                            $(".list_li").find("a").click(function(event) {
                                var index = $(this).parent().index();
                                if (index < 10) {
                                    index = index + 1;
                                    var label = "vip_가격리스트 " + index;
                                    ga('send', 'event', 'mf_vip', 'vip', label);
                                }
                            });

                            // 11번가 프로모션 클릭 이벤트
                            $(".pm11st").click(function(e) {
                                e.stopPropagation();
                                var rend_url = $(this).attr("strUrl");
                                if (rend_url == "") {
                                    rend_url = "http://www.11st.co.kr/connect/Gateway.tmall?method=Xsite&tid=1001161302";
                                }
                                window.open(rend_url, '', '');
                                //window.open("http://www.11st.co.kr/connect/Gateway.tmall?method=Xsite&tid=1001161302");
                                return;
                            });

                        }
                        $("#list_more2").text(parseInt(json.listCount) - vCashMallCnt);

                        vList_Cnt = json.listCount;

                        if (vCnt <= vListpagesize) {
                            $("#list_more1").text(vCnt);

                            $("#detail_list_more").hide();

                            vListnow = vCnt;
                        } else {
                            $("#list_more1").text(vListpagesize);

                            $("#detail_list_more").show();

                            vListnow = vListpagesize;

                            $("#detail_list_more").click(function() {
                                getListmore();
                            });
                        }
                    } else {

                        if (vCashPrice.length > 0 && vCashMinYn == "Y") {
                            $("#price_txt").html("<em class=\"low\">최저가</em><span>" + vCashPrice + "</span><em>원</em>");
                            $("#t_delivery_info").find(".i_delivery").html(vCashDelivery);
                        } else {
                            $("#detail_list").html("<li>" + vPc_price + "</li>");
                        }
                        // $("#none_list").show();
                        $("#list_more1").text("0");
                        $(".fixSelectoption").hide();
                        $("#detail_list_more").hide();

                        vListnow = vCnt;
                    }
                } else {

                    if (vCashPrice.length > 0 && vCashMinYn == "Y") {
                        $("#price_txt").html("<em class=\"low\">최저가</em><span>" + vCashPrice + "</span><em>원</em>");
                        $("#t_delivery_info").find(".i_delivery").html(vCashDelivery);
                    } else {
                        $("#detail_list").html("<li>" + vPc_price + "</li>");
                    }

                    $("#list_more1").text("0");
                    $(".fixSelectoption").hide();
                    $("#detail_list_more").hide();

                    vListnow = vCnt;
                }

                vTab_top = vTab.offset().top;

                if (toggleState != 1 && $("#list_sort").html().length < 1) {
                    // 정렬리스트 생성
                    var vTmpsort = "";

                    vTmpsort += "<option value=\"tabyn_minsort\">최저가순</option>";
                    // 오픈마켓

                    vTmpsort += "<option value=\"tabyn_dminsort\">배송비 포함 최저가순</option>";

                    // 할부원금가(판매가쇼핑몰)
                    if (json.tabyn_realprice == "Y") {
                        vTmpsort += "<option value=\"tabyn_realprice\">할부원금가</option>";
                    }
                    // 기본설치비(스탠드+벽걸이) 포함
                    if (json.tabyn_aircon_1 == "Y") {
                        vTmpsort += "<option value=\"tabyn_aircon_1\">기본설치비 포함 (스탠드+벽걸이)</option>";
                    }
                    // 기본설치비(스탠드+벽걸이+진공비) 포함
                    if (json.tabyn_aircon_2 == "Y") {
                        vTmpsort += "<option value=\"tabyn_aircon_2\">기본설치비 포함 (스탠드+벽걸이+진공비)</option>";
                    }
                    // 기본설치비+진공비 포함
                    if (json.tabyn_aircon_4 == "Y") {
                        vTmpsort += "<option value=\"tabyn_aircon_4\">기본설치비+진공비 포함</option>";
                    }
                    if (json.tabyn_open == "Y") {
                        vTmpsort += "<option value=\"tabyn_open\">오픈마켓</option>";
                    }
                    // 무료배송
                    if (json.tabyn_dlv0 == "Y") {
                        vTmpsort += "<option value=\"tabyn_dlv0\">무료배송</option>";
                    }
                    // 전시/중고
                    if (json.tabyn_junggo == "Y") {
                        vTmpsort += "<option value=\"tabyn_junggo\">전시/중고</option>";
                    }
                    // 반품/리퍼
                    if (json.tabyn_return == "Y") {
                        vTmpsort += "<option value=\"tabyn_return\">반품/리퍼</option>";
                    }
                    // 세금/배송비무료(해외쇼핑)
                    if (json.tabyn_tariffree == "Y") {
                        vTmpsort += "<option value=\"tabyn_tariffree\">세금/배송비무료(해외쇼핑)</option>";
                    }
                    // 제조사 공식인증판매자
                    if (json.tabyn_auth == "Y") {
                        vTmpsort += "<option value=\"tabyn_auth\">제조사 공식인증판매자</option>";
                    }
                    // 제조사인증 업체명
                    if (json.tabyn_auth_nm == "Y") {
                        vTmpsort += "<option value=\"tabyn_auth\">제조사인증 업체명</option>";
                    }
                    // 전국무료장착(타이어)
                    if (json.tabyn_tirefree == "Y") {
                        vTmpsort += "<option value=\"tabyn_tirefree\">전국무료장착(타이어)</option>";
                    }
                    // 백화점몰
                    if (json.tabyn_depart == "Y") {
                        vTmpsort += "<option value=\"tabyn_depart\">백화점몰</option>";
                    }
                    // 카드할인
                    if (json.tabyn_card == "Y") {
                        if (vListSort == "tabyn_card") {
                            vTmpsort += "<option value=\"tabyn_card\" selected>카드할인</option>";
                        } else {
                            vTmpsort += "<option value=\"tabyn_card\">카드할인</option>";
                        }
                    }
                    // 무이자
                    if (json.tabyn_cardfree == "Y") {
                        vTmpsort += "<option value=\"tabyn_cardfree\">무이자</option>";
                    }
                    // 홈쇼핑&전문몰
                    if (json.tabyn_etcmall == "Y") {
                        vTmpsort += "<option value=\"tabyn_etcmall\">홈쇼핑/전문몰</option>";
                    }

                    if (vTmpsort != "") {
                        $("#list_sort").html(vTmpsort);

                        vTab_top = vTab.offset().top;

                        $('#list_sort').unbind('change');
                        $('#list_sort').bind('change', function() {
                            var chk_value = $("#list_sort").val();
                            var chk_boolean = false;
                            //tabyn_dminsort 로 변경되면 상단 옵션 변경 버튼도 바꿔줌
                            if (chk_value == "tabyn_minsort") { //최저가순
                                if (toggleState == 1) { //상단 버튼이 on 일때 
                                    $("#delivery_btt").click();
                                    select_list_slide(0);
                                } else {
                                    chk_boolean = true;
                                }
                            } else if (chk_value == "tabyn_dminsort") { //배송비포함 최저가순
                                if (toggleState == 0) {
                                    $("#delivery_btt").click();
                                    select_list_slide(0);
                                } else {
                                    chk_boolean = true;
                                }
                            } else {
                                chk_boolean = true;
                            }

                            //alert(chk_boolean);
                            //alert(chk_value);

                            if (chk_boolean) {
                                //선택시 배송비 포함 최저가가 선택되어있을때는 배송비 포함 최저가를 끄고 난뒤 선택한 값으로 보여줌.
                                if ($("#toggle_delivery_price .toggle").hasClass("on")) {
                                    $("#toggle_delivery_price .toggle").removeClass("on");
                                    toggleState = 0;
                                    // 옵션리스트 변경
                                    // 리스트 최저가로 변경
                                    var chk_value = $("#list_sort").val();
                                    vListSort = chk_value;
                                    vListpage = 1;
                                    getOption();
                                    // 현금몰 정렬

                                }

                                vListSort = chk_value;
                                vListpage = 1;
                                getList();

                                select_list_slide(0);

                                vSort_txt = $("#list_sort option:selected").text();
                                fnGoogleClick(5);
                            }
                        });
                    }

                    // 배송비 포함 최저가 toggle
                    $("#toggle_delivery_price .toggle").unbind("click");
                    $("#toggle_delivery_price .toggle").click(function() {
                        $(".tabs li").removeClass("on");
                        if (toggleState == 0) {
                            $(this).addClass("on");
                            toggleState = 1;
                            // 옵션리스트 변경
                            // 리스트 배송비포함최저가로 변경
                            $("#list_sort").val("tabyn_dminsort");
                            var chk_value = $("#list_sort").val();
                            vListSort = chk_value;
                            vListpage = 1;
                            getOption();
                            getList();

                            vSort_txt = $("#list_sort option:selected").text();
                            fnGoogleClick(5);

                            ga_new(5, '');
                        } else {
                            $(this).removeClass("on");
                            toggleState = 0;
                            // 옵션리스트 변경
                            // 리스트 최저가로 변경
                            $("#list_sort").val("tabyn_minsort");
                            var chk_value = $("#list_sort").val();
                            vListSort = chk_value;
                            vListpage = 1;
                            getOption();
                            getList();

                            vSort_txt = $("#list_sort option:selected").text();
                            fnGoogleClick(5);

                            ga_new(4, '');
                        }

                        $(".cont_area").hide();
                        $(".tabs li:first").addClass("on").show();
                        $(".cont_area:first").show();

                        if ($(".tabs li:first").find("a").hasClass("tab1"))
                            $(".areaAmount").fadeIn();
                        else
                            $(".areaAmount").hide();
                    });
                }

                $("#bottom_recommend").show();

                if (vDelivery) {
                    $("#delivery_btt").click();
                    vDelivery = false;
                }

                //ebay cpc : 11번가 프로모션으로 임시 주석 20180.19 민재
                //최저가순일때만 보여줌
                //if(($.trim(vListSort) == "" || vListSort == "tabyn_minsort") && !vEbay_cpc){
                if ($.trim(vListSort) == "" || vListSort == "tabyn_minsort") {

                    $.ajax({
                        type: "GET",
                        url: "/ebayCpc/jsp/connectApiVip.jsp",
                        async: false,
                        data: "modelno=" + vModelno + "&app=" + vAppyn,

                        dataType: "JSON",
                        success: function(json) {
                            try {

                                if (json.sum_sort2.first.items.length > 0 || json.sum_sort2.second.items.length > 0) {
                                    //첫번째것만 사용
                                    var vItems;
                                    var vHtml = "";

                                    if (typeof json.sum_sort2.first == "object") {
                                        vItems = json.sum_sort2.first.items[0];
                                    } else if (typeof json.sum_sort2.second == "object") {
                                        vItems = json.sum_sort2.second.items[0];
                                    }

                                    vHtml += "<li id=\"vip_ebaycpc\" class=\"ebaycpc\" gourl=\"" + vItems.landing + "\" impt=\"" + vItems.imp_t + "\" clkt=\"" + vItems.clk_t + "\">";
                                    vHtml += "	<div class=\"ebaycpc__head\"><span class=\"ebaycpc__tit\">파워클릭AD</span></div>";
                                    vHtml += "	<a href=\"javascript:;\">";
                                    if (vItems.shopcode == 4027) {
                                        vHtml += "		<span class=\"brand shopbid_4027\">옥션</span>";
                                    } else if (vItems.shopcode == 536) {
                                        vHtml += "		<span class=\"brand shopbid_536\">G마켓</span>";
                                    }
                                    vHtml += "		<span class=\"price\"><em>" + commaNum(vItems.enuri_instance_price) + "원</em></span>";
                                    vHtml += "		<span class=\"info\">" + vItems.title + "</span>";
                                    vHtml += "		<span class=\"delivery_info\">";
                                    if (vItems.shipping_fee > 0) {
                                        if (vItems.shopcode == 4027) {
                                            vHtml += "			<i class=\"i_delivery\">조건부무료배송</i>";
                                        } else if (vItems.shopcode == 536) {
                                            vHtml += "			<i class=\"i_delivery\">" + vItems.shipping_fee + "원 별도</i>";
                                        }
                                    } else {
                                        vHtml += "			<i class=\"i_delivery\">무료배송</i>";
                                    }
                                    vHtml += "		</span>";
                                    vHtml += "	</a>";
                                    vHtml += "</li>";

                                    //alert(vHtml);
                                    if ($("#detail_list").children("li").length > 3) {
                                        $("#detail_list").children("li").filter(":eq(3)").after(vHtml);
                                    } else {
                                        $("#detail_list").append(vHtml);
                                    }

                                    if (!vEbay_cpc) {
                                        vEbay_cpc = true;
                                        //ebay cpc 로딩 로그
                                        goImpT(vItems.imp_t)
                                    }

                                    $("#vip_ebaycpc").unbind("click");
                                    $("#vip_ebaycpc").click(function() {
                                        var vClkt = $(this).attr("clkt");
                                        var vGourl = $(this).attr("gourl") + "&freetoken=outlink";

                                        insertLog_cate(21381, vCate4);
                                        goClk_t(vClkt);
                                        window.open(vGourl);

                                    });

                                } else {
                                    fnEbayVip_Empty();
                                }
                            } catch (ex) {
                                fnEbayVip_Empty();
                            }
                        }
                    });
                }
            },
            error: function(result, status, error) {
                /*alert("error occured. Status:" + result.status
                 + ' --Status Text:' + result.statusText
                 + " --Error Result:" + result);*/
                console.log(error);
                console.log(result);
                console.log(result.responseText);
                $(".fixSelectoption").hide();

                // vTab = $(".prodDetailTab");
                vTab_top = vTab.offset().top;

                $("#detail_list").html(null);

                $("#none_list").html("<p class=\"txt1\">선택한 조건에 해당하는 쇼핑몰이 없습니다.");
                $("#none_list").show();
                $("#detail_list").html(null);

                $("#list_more1").text("0");

                $("#list_head_sort").hide();

                $("#detail_list_more").hide();

                $(".infoBox").addClass("box_no");
            }
        });

        $('.prodDetailBox .openBtn button').unbind("click");

        $('.prodDetailBox .openBtn button').click(function() {
            var _this = $(this);
            _this.parent().parent().find('.shortBox').toggleClass('open');
            _this.toggleClass('on');
            _this.text('접기');
            if (_this.hasClass('on') != 1) {
                _this.text('더보기');
            }
        });
    }

}

// VIP 최저가 하단에 카드 최저가 노출
function getMinCardPriceInfo() {
    var vCard_price_data = "modelno=" + vModelno + "&page=" + vListpage + "&tabinfoyn=Y&tabyn_card=Y";

    var objVipDivTag = $("#vip_pricecard_div_tag");

    $.ajax({
        type: "GET",
        url: "/mobilefirst/ajax/detailAjax/get_list.jsp",
        data: vCard_price_data,
        dataType: "JSON",
        success: function(json) {

            if (null != json && json != undefined && json.listCount > 0) {
                var objListContent = json.listContent;

                if (objListContent.length > 0) {
                    for (var i = 0; i < objListContent.length; i++) {
                        var arryCon = objListContent[i];
                        var intPriceCard = 0;
                        if (arryCon.pricecard != undefined && arryCon.pricecard != "") {
                            intPriceCard = parseInt(arryCon.pricecard.replace(/,/gi, ""));
                        }
                        if ("PC 최저가" != arryCon.shopname && arryCon.pricecard != undefined && arryCon.cardname != undefined && intPriceCard <= vMinprice) {
                            $("#vip_pricecard_card_name").html(arryCon.cardname);
                            $("#vip_pricecard_price").html(arryCon.pricecard + "원");
                            $("#vip_pricecard_shop_name").html("(" + arryCon.shopname + ")");

                            $("#vip_pricecard_div_tag").unbind();
                            $("#vip_pricecard_div_tag").click(function() {
                                var varVipMobileUrl = arryCon.mobileurl;

                                if (varVipMobileUrl.indexOf("&amp;") > -1) {
                                    varVipMobileUrl = varVipMobileUrl.replace(/&amp;/gi, "&");
                                }
                                ga('send', 'event', 'mf_vip', 'vip', 'vip_카드최저가');
                                goShop(varVipMobileUrl, arryCon.shopcode, arryCon.plno, arryCon.goodscode, arryCon.instanceprice, arryCon.category, arryCon.price, arryCon.minprice, this, vModelno);
                            });

                            $("#card_price_low_span_id").remove();
                            $("#list_select").find(".selected .priceLow").after("<span id=\"card_price_low_span_id\" class=\"cardpriceLow\">(" + arryCon.cardname + " 최저가 " + arryCon.pricecard + "원)</span>");
                            if (parseInt(vCashPrice) < intPriceCard) {
                                $("#vip_card_minPrice_tag_id").insertAfter("#vip_cash_div_tag");
                            }
                            objVipDivTag.show();
                            break;
                        }

                    }
                } else { // if (objListContent.length > 0) {
                    objVipDivTag.hide();
                }
            } else { // if (null != json && json != undefined && json.listCount > 1) {
                objVipDivTag.hide();
            }
        },
        error: function(request, status, error) {
            objVipDivTag.hide();
        }

    });
}

function fnEbayVip_Empty() {
    var varuml = "keyword=" + encodeURIComponent(vCate4) + "&maxCnt=6&isCate=VIP&cateCode=" + vCate4;

    if (vAppyn == "Y") {
        varuml = varuml + "&chInfo=moapp_enuri_vip2&app=Y";
    } else {
        varuml = varuml + "&chInfo=mobile_enuri_vip2";
    }
    var btmMaketNm = "";

    $.ajax({
        type: "GET",
        url: "/ebayCpc/jsp/connectApi2.jsp",
        data: varuml,
        dataType: "JSON",
        success: function(json) {

            try {

                if (json.sum_sort2.first.items.length > 0 || json.sum_sort2.second.items.length > 0) {
                    //첫번째것만 사용
                    var vItems;
                    var vHtml = "";

                    if (typeof json.sum_sort2.first == "object") {
                        vItems = json.sum_sort2.first.items[0];
                    } else if (typeof json.sum_sort2.second == "object") {
                        vItems = json.sum_sort2.second.items[0];
                    }

                    vHtml += "<li id=\"vip_ebaycpc\" class=\"ebaycpc\" gourl=\"" + vItems.landing + "\" impt=\"" + vItems.imp_t + "\" clkt=\"" + vItems.clk_t + "\">";
                    vHtml += "	<div class=\"ebaycpc__head\"><span class=\"ebaycpc__tit\">파워클릭AD</span></div>";
                    vHtml += "	<a href=\"javascript:;\">";
                    if (vItems.shopcode == 4027) {
                        vHtml += "		<span class=\"brand shopbid_4027\">옥션</span>";
                    } else if (vItems.shopcode == 536) {
                        vHtml += "		<span class=\"brand shopbid_536\">G마켓</span>";
                    }
                    vHtml += "		<span class=\"price\"><em>" + commaNum(vItems.enuri_instance_price) + "원</em></span>";
                    vHtml += "		<span class=\"info\">" + vItems.title + "</span>";
                    vHtml += "		<span class=\"delivery_info\">";
                    if (vItems.shipping_fee > 0) {
                        if (vItems.shopcode == 4027) {
                            vHtml += "			<i class=\"i_delivery\">조건부무료배송</i>";
                        } else if (vItems.shopcode == 536) {
                            vHtml += "			<i class=\"i_delivery\">" + vItems.shipping_fee + "원 별도</i>";
                        }
                    } else {
                        vHtml += "			<i class=\"i_delivery\">무료배송</i>";
                    }
                    vHtml += "		</span>";
                    vHtml += "	</a>";
                    vHtml += "</li>";

                    //alert(vHtml);
                    if ($("#detail_list").children("li").length > 3) {
                        $("#detail_list").children("li").filter(":eq(3)").after(vHtml);
                    } else {
                        $("#detail_list").append(vHtml);
                    }

                    if (!vEbay_cpc) {
                        vEbay_cpc = true;
                        //ebay cpc 로딩 로그
                        goImpT(vItems.imp_t)
                    }

                    $("#vip_ebaycpc").unbind("click");
                    $("#vip_ebaycpc").click(function() {
                        var vClkt = $(this).attr("clkt");
                        var vGourl = $(this).attr("gourl") + "&freetoken=outlink";
                        insertLog_cate(21381, vCate4);
                        goClk_t(vClkt);
                        window.open(vGourl);

                    });

                }
            } catch (ex) {

            }
        },
        error: function(request, status, error) {}
    });
}

//노출 log
function goImpT(adurl) {
    if (location.href.indexOf("m.enuri.com") > -1 || location.href.indexOf("www.enuri.com") > -1) {
        var imgSrc = new Image();
        imgSrc.src = adurl;
    } else {
        //	console.log("test-powerClick 노출로그"); 
    }
}
//클릭 log
function goClk_t(url) {
    if (location.href.indexOf("m.enuri.com") > -1 || location.href.indexOf("www.enuri.com") > -1) {
        var imgSrc = new Image();
        imgSrc.src = url;
    } else {
        //	console.log("test-powerClick 클릭로그"); 
    }
}

function goEventCoupon(url) {
    event.stopPropagation();
    if (url != "") {
        //window.open("http://www.11st.co.kr/connect/Gateway.tmall?method=Xsite&tid=1001161302");
        window.open(url);
        return;
    }
}

function beforeSubmit() {
    // 최저가 가격알림 동의버튼
    try {
        $("input").each(function() {
            $(this).val($(this).val().trim());
        });

        var nowMinPrice = vMinprice;
        var limitPriceLow = Math.ceil(nowMinPrice * 0.7);
        var limitPriceHigh = nowMinPrice - 1;
        $('#setprice').val(stripCommas($('#setprice').val()));
        var setMinPrice = $('#setprice').val();

        /*
         * if( $('#setprice').val().length < 1 ) { alert(commaNum(limitPriceLow) +
         * "원 ~ " + commaNum(limitPriceHigh) + "원 사이 가격을 입력하세요!");
         * //$('#setprice').focus(); $('#setprice').select(); return false; }
         * else if( /[^0-9]/.test(setMinPrice) || setMinPrice < limitPriceLow ||
         * setMinPrice > limitPriceHigh ) { alert(commaNum(limitPriceLow) + "원 ~ " +
         * commaNum(limitPriceHigh) + "원 사이 가격을 입력하세요!");
         * //$('#setprice').focus(); $('#setprice').select(); return false; }
         */
        if ($("#chk_personagree").is(":checked") === false) {
            alert("개인 정보 수집에 동의를 하셔야 합니다.");
            return false;
        }

        if ($('#setprice').val().length < 1) {
            alert("희망 최저가를 입력하세요.");
            return false;
        } else if ($('#setprice').val().length > 10) {
            alert("금액을 확인하시고 다시 입력해 주세요.");
            return false;
        } else if (/[^0-9]/.test(setMinPrice)) {
            alert("숫자를 입력하세요.");
            return false;
        }

        if ($('#phonenum2').val().length < 3 ||
            $('#phonenum3').val().length != 4) {
            $('#setprice').val(commaNum($('#setprice').val()));
            alert("올바른 휴대폰 번호를 입력하세요.");
            return false;
        }

        try {
            // window.parent.document.getElementById("priceNoti").style.display
            // = "none";
        } catch (ex) {}

        insertLog('11030');

        ga('send', 'event', 'mf_vip', 'vip', 'vip_최저가알림받기');

        return true;

    } catch (ex) {}
}

function stripCommas(nStr) {
    return nStr.split(",").join("");
}

function getListmore() {
    vListpage++;

    var vCnt = $("#list_more2").text();
    if (vCnt < vListnow + vListpagesize) {
        $("#list_more1").text(vCnt);

        // getListDetail();

        $("#detail_list > li").show();

        $("#detail_list_more").hide();
    } else {
        vListnow = vListnow + vListpagesize;

        $("#list_more1").text(vListnow);

        // getListDetail();

        $("#detail_list > li:lt(" + vListnow + ")").show();
    }

    if ($("#detail_list > li:first .brand").text() == "PC 최저가") {
        $("#detail_list > li:first").hide()
    }
}

function select_list_slide(param) {
    if (param == 0) {
        $("body, html").animate({
            scrollTop: $("#tab_position").offset().top
        }, 500);
    } else {
        if (!vTab.hasClass("over_bar")) {
            $("body, html").animate({
                scrollTop: $("#tab_position").offset().top
            }, 500);
        } else {
            $("body, html").animate({
                scrollTop: $("#tab_position").offset().top
            }, 500);
        }
    }
}

function fnGoogleClick(param) {
    var vTxtgoogle = "";
    var vTxtAction = "vip";
    if (param == 1) {
        vTxtgoogle = "vip_현재위치";
    } else if (param == 2) {
        vTxtgoogle = "vip_선택 옵션 조회";
    } else if (param == 3) {
        vTxtgoogle = "vip_한줄보기";
    } else if (param == 4) {
        vTxtgoogle = "vip_좌우구분보기";
    } else if (param == 5) {
        vTxtgoogle = "vip_한줄보기_" + vSort_txt;
        vTxtAction = "vip_sort";
    } else if (param == 6) {
        vTxtgoogle = "vip_좌우구분보기_" + vSort_txt;
        vTxtAction = "vip_sort";
    }

    ga('send', 'event', 'mf_vip', vTxtAction, vTxtgoogle);
}

function set_option(optionModelno) {
    // 옵션선택시.(개별선택)
    vChkgroup = false;
    vGroup = 0;
    vListSort = "";

    if (toggleState != 1) {
        $("#list_sort").html("");
    }

    if ($("#option_more_btn").css("display") == "none") {
        $("#optionMorearea").hide();
    }

    vModelno = vModelno_org;

    select_list(optionModelno, 0);

    //최저배송비 변경 
    $(".i_delivery").text($("#optiondetail_" + optionModelno).attr("deliveryinfo"));

    //그래프 변경
    //$("#frm_graph").attr("src","/mobilefirst/include/detailGraphFrame.jsp?modelno="+optionModelno);
    //$("#frm_graph").get(0).contentWindow.location.replace("/mobilefirst/include/detailGraphFrame.jsp?modelno="+optionModelno);

    getGuide();

    if ($("#list_select .unit").hasClass("on")) {
        ga_new(9, '');
    } else {
        ga_new(8, '');
    }
}

function select_list(modelno, part) {
    // part : 1 open, 0 close; 사용안함.
    vModelno = modelno;

    get_base(modelno);

    var vTxt = $("#select_mall_" + modelno).html();
    var vTxt_cnt = "";
    if ($("#select_mallcnt_" + modelno).html() != "<em></em>") {
        vTxt_cnt = "(" + $("#select_mallcnt_" + modelno).text() + ")";
    }
    // 옵션li에 색상 없에고. 선택된것만 색상넣어줌.
    $("#list_select > tr").removeClass("selected");

    $("#optiondetail_" + modelno).addClass("selected");

    if ($("#select_mall_" + modelno).html() == undefined) {
        $("#selected_option").hide();
    } else {
        $("#selected_option").show();
        $("#tab1_cnt_txt").text(vTxt_cnt);
        $("#selected_option_txt").html(vTxt);
    }

    // 옵션명이 없을때는 칸을 줄여서 보여준다.
    if ($("#selected_option_txt").text() == "") {
        $("#list_head_model").hide();
    }

    vTab_Selected = "";

    vListpage = 1;

    getList();
    getMinCardPriceInfo();
    // minjae
}

function get_base(modelno) {

    var vData = "modelno=" + modelno;
    if (vChkgroup) { // 그룹모델이면
        vData += "&modelnos=" + vMulti_Modelno;
    }

    $.ajax({
        type: "GET",
        url: "/mobilefirst/ajax/detailAjax/get_detail_base.jsp",
        async: false,
        data: vData,
        dataType: "JSON",
        success: function(json) {
            vConstrain = json.constrain;

            if (vConstrain != undefined) {
                if (vConstrain != "5") {
                    $("#d_img").error(function() {
                        $(this).error(function() {
                            $(this).attr("src", "http://img.enuri.info/images/home/thumb_none_300.jpg");
                        }).attr("src", json.imgurl3);
                    }).attr("src", json.imgurl);
                } else {
                    $("#d_img").error(function() {
                        $(this).attr("src", "http://img.enuri.info/images/home/thumb_none_300.jpg");
                    }).attr("src", json.imgurl2);
                }
                imgurl_org = json.imgurl_org; // 원본 이미지경로

                if (json.bigimg == "true") { // 큰이미지 유무에따라 돋보기 이미지
                    // 유무.
                    $("#btn_zoom").show();
                    // $("#btn_zoom2").show();

                    $("#d_img").unbind("click");
                    $("#d_img").click(function() {
                        $(location).attr("href", "/mobilefirst/detailBigImage.jsp?modelno=" + modelno);
                        ga('send', 'event', 'mf_vip', 'vip', 'vip_상세이미지1');
                    });
                    $("#btn_zoom").unbind("click");
                    $("#btn_zoom").click(function() {
                        $(location).attr("href", "/mobilefirst/detailBigImage.jsp?modelno=" + modelno);
                        ga('send', 'event', 'mf_vip', 'vip', 'vip_상세이미지2');
                    });
                    // $("#btn_zoom2").click(function(){
                    // $(location).attr("href","/mobilefirst/detailBigImage.jsp?modelno="+modelno);
                    // ga('send', 'event', 'mf_vip', 'vip',
                    // 'vip_상세이미지3');
                    // });
                } else {
                    $("#btn_zoom").hide();
                    // $("#btn_zoom2").hide();
                }

                var vTmp_name = json.modelnm;
                if (json.condiname != "" && !vChkgroup) {
                    vTmp_name += " [" + json.condiname + "]";
                }
                $("#func_comment").text(json.condiname);
                $(".product_info_inner .title").text(json.keyword2);

                if (json.keyword2.length > 0 && $("#pro_keyword2").hasClass("titNone")) {
                    ("#pro_keyword2").removeClass("titNone");
                }

                vModelnm = vTmp_name;
                vModelno_group = json.modelno_group;
                vCa_code = json.ca_code;
                vCondiname = json.condiname;
                vMinprice = json.minprice;
                vPricestring = json.priceString;
                $("#caution_info").html(null);
                if (vPricestring == "품절" || vPricestring == "출시예정" || vPricestring == "단종") {
                    if (vCashMinYn == "Y" && vCashPrice.length > 0) {
                        $("#price_txt").html("<em class=\"low\">최저가</em><span>" + commaNum(vCashPrice) + "</span><em>원</em>");
                    } else {
                        $("#price_txt").html(null);
                        $("#price_txt").text(vPricestring);
                    }
                } else if (vPricestring == "TLC") {
                    $("#price_txt").html(null);
                    $("#price_txt").html("<em class=\"low\">TLC카드가</em><span>" + commaNum(json.tlc_min_prc) + "</span><em>원</em>");
                    loadCaution();
                } else {
                    $("#price_txt").html(null);
                    $("#price_txt").html("<span class=\"iconPc pricearea\" style=\"display:none\">PC 최저가</span><em class=\"low\">최저가</em><span id=\"detail_minprice\">" + commaNum(json.minprice) + "</span><em>원</em>");
                    $("#detail_minprice").text(commaNum(json.minprice));
                    $("#pclowprice").text(commaNum(json.minprice));
                }

                // 최저가 가격알림 가격
                $("#notiprice").text(commaNum(json.minprice) + " 원");

                $("#detail_modelnm").html(vTmp_name); // 상품명

                var vSpec = json.spec;

                vSpec = json.spec_group;

                vSpec = vSpec.replace(/&amp;/gi, "&");

                $("#spec_txt").html(vSpec);

                $("#btnAllProd").on("click", function() {
                    vTab1.click();
                    select_list(vModelno_group, 2);
                });

                vCate2 = json.cate4.substring(0, 2);
                vCate4 = json.cate4;

                vFunc = json.func;

                if (vFunc.indexOf("<추가 설명") > -1) {
                    vFunc = vFunc.substring(vFunc.indexOf("<추가 설명"),
                        vFunc.length);
                    // <!--주석-->삭제
                    var RegExpDS = /<!--[^>](.*?)-->/g;
                    vFunc = vFunc.replace(RegExpDS, "");
                }
                // 상품명 오류 다시한번 리딩
                $("#detail_modelnm").html(vModelnm); // 상품명
            }

        },
        error: function(xhr, ajaxOptions, thrownError) {
            // alert(xhr.status);
            // alert(thrownError);
        }
    });
}

function bnrVip_old() {
    //내부용 배너 관리자 사용시 사용
    $.getJSON("/mobilefirst/http/json/banner_list.json",
        function(json) {
            var bannerObj;
            var blWeb = false;

            var vAndroid = false;

            if (vAppyn == "Y") { // 앱일때
                if (window.android) {
                    vAndroid = true;
                }
            } else {
                if (vIosyn != 5939) {
                    vAndroid = true;
                }
            }

            if (vAppyn == "Y") { // 앱일때
                if (json.appVip.banner) {
                    var bannerJson = new Array();

                    $.each(json.appVip.banner, function(i, v) {
                        var sdate = replaceAll(v.sdate, "-", "/");
                        sdate = new Date(sdate);

                        var edate = replaceAll(v.edate, "-", "/");
                        edate = new Date(edate);

                        if (dateComparison(sdate, edate)) {
                            if (vAndroid && v.ANDROID == "Y") {
                                bannerJson.push(v);
                            } else if (!vAndroid && v.IOS == "Y") {
                                bannerJson.push(v);
                            }
                        }
                    });

                    var vnrVip = shuffle(bannerJson);
                    bannerObj = vnrVip[0];
                }
            } else {
                if (json.webVip.banner) {
                    var bannerJson = new Array();

                    $.each(json.webVip.banner, function(i, v) {
                        var sdate = replaceAll(v.sdate, "-", "/");
                        sdate = new Date(sdate);

                        var edate = replaceAll(v.edate, "-", "/");
                        edate = new Date(edate);

                        if (dateComparison(sdate, edate)) {
                            if (vAndroid && v.ANDROID == "Y") {
                                bannerJson.push(v);
                            } else if (!vAndroid && v.IOS == "Y") {
                                bannerJson.push(v);
                            }
                        }
                    });

                    var vnrVip = shuffle(bannerJson);
                    bannerObj = vnrVip[0];
                    blWeb = true;
                }
            }

            try {
                //if (bannerObj.img != "Object") {
                var checkView = true;

                // 2016-11-08 vip둥둥이 친구초대 예외처리
                if (bannerObj.IOS == "N") {
                    if (vIosyn == 5939) {
                        checkView = false;
                    }
                } else if (bannerObj.ANDROID == "N") {
                    if (vIosyn != 5939) {
                        checkView = false;
                    }
                }

                if (checkView) {
                    var vTmphtml = "";
                    var vBnr_class = "vip_bnr";
                    if (vAppyn == "Y") {
                        vBnr_class += " app";
                    }
                    getVIPDoongBanner(vBnr_class, blWeb);

                    /*
				 	if (blWeb) {
						vTmphtml += "<span class=\""+ vBnr_class +"\" id=\"vipbnr\" style=\"display:none;background:url("
								+ bannerObj.img
								+ ") center 0 no-repeat;\">";
					} else {
						vTmphtml += "<span class=\""+ vBnr_class +"\" id=\"vipbnr\" style=\"display:none;background:url("
								+ bannerObj.img
								+ ") center 0 no-repeat;\">";
					}
					vTmphtml += "<a href=\"javascript:///\" class=\"evtgo\" onclick=\"go_banner_link('"
							+ bannerObj.link
							+ "','"
							+ bannerObj.name
							+ "');\">"
							+ bannerObj.name + "</a>";
					vTmphtml += "<a href=\"javascript:///\" onclick=\"new_close_floating('vipbnr');\" class=\"btnclose\">닫기</a>";
					vTmphtml += "</span>";

					$("#floating_banner").html(vTmphtml);

					if (fnGetCookie2010("vip_promotion") != "vipbnr") {
						$(".vip_bnr").show();
					}
					*/
                }

                //	}
            } catch (e) {}

        });
}

function bnrVip() {
    var blWeb = true;
    var vTmphtml = "";
    var vBnr_class = "vip_bnr";
    if (vAppyn == "Y") {
        blWeb = false;
        vBnr_class += " app";
    }
    //banner_list.js call
    getVIPDoongBanner(vBnr_class, blWeb);
}

function new_close_floating(param) {
    $("#vipbnr").hide();

    fnSetCookie2010('vip_promotion', param, 1);
}

function fnSetCookie2010(name, value, expiredays) {
    if (typeof(expiredays) == "undefined" || expiredays == null) {
        expiredays = "";
    }
    if (expiredays == "") {
        document.cookie = name + "=" + escape(value) + "; path=/;";
    } else {
        var todayDate = new Date();
        todayDate.toGMTString();
        todayDate.setDate(todayDate.getDate() + expiredays);

        document.cookie = name + "=" + escape(value) + "; path=/;expires=" +
            todayDate.toGMTString() + ";";
        /*alert(name + "=" + escape(value) + "; path=/;expires="
        		+ todayDate.toGMTString() + ";");*/
    }
}

function getGuide() {
    try {
        //$("#frm_graph").get(0).contentWindow.location.replace("/mobilefirst/include/detailGraphFrame.jsp?modelno="+vModelno);
        var html = "";

        $.ajax({
            type: "GET",
            url: "/mobilefirst/ajax/detailAjax/get_detail_spec.jsp",
            data: "modelno=" + vModelno,
            dataType: "JSON",
            success: function(json) {
                // var template =
                // "{{#detailSpec}}{{specTitle}}/{{specContent}}<br>{{/detailSpec}}
                // ";

                if (json.detailSpec) {
                    var template = "<table summary=\"제품 요약 설명\">";
                    template += "	<caption>제품 요약 설명</caption>";
                    // template += " <colgroup><col style=\"width:20%\"
                    // /><col style=\"width:80%\" /></colgroup>";
                    template += "	<tbody>";
                    template += "{{#detailSpec}}";
                    template += "		{{#specGroupname}}<tr><th colspan=\"2\" class=\"title\">{{{specGroupname}}}</th></tr>{{/specGroupname}}";
                    template += "		{{#specTitle}}<tr><th scope=\"row\" rowspan=\"{{specCellcnt}}\">{{{specTitle}}}</th>{{/specTitle}}<td>{{{specContent}}}</td></tr>";
                    template += "{{/detailSpec}}";
                    template += "	</tbody>";
                    template += "</table>";

                    html = Mustache.to_html(template, json);

                    if (html.length > 1) {
                        html = html.replace(/&amp;/gi, "&");
                        $("#spec_body").html(html);
                        $("#spec_txt").hide();
                    }

                } else {
                    $("#spec_section").hide();
                }
            },
            error: function(xhr, ajaxOptions, thrownError) {
                $("#spec_section").hide();
                // alert(xhr.status);
                // alert(thrownError);
            }
        });
    } catch (e) {
        $("#spec_section").hide();
    }

    getVipKcMark();

    // 카탈로그 보여줄 카테고리 정리
    var vCate_L = ",02,03,04,05,06,07,12,21,22,24,";
    var vCate_M = ",0908,0930,0905,0931,0920,0932,0918,0904,1602,1643,2144,";
    var vCateflag = false;
    var vData = "modelno=" + vModelno;

    if (vCate_L.indexOf("," + vCate2 + ",") > -1) {
        vCateflag = true;
    }

    if (vCate_M.indexOf("," + vCate4 + ",") > -1) {
        vCateflag = true;
    }

    if (vCateflag) {
        vData += "&mode=1";
    }

    // 카탈로그 및 용어설명
    /*
     * $.ajax({ type: "GET", url:
     * "/mobilefirst/ajax/detailAjax/get_function.jsp", data: vData, success:
     * function(result){ var r0 =
     * result.substring(result.indexOf("@@@")+3,result.indexOf("$$$")); var r1 =
     * result.substring(result.indexOf("$$$")+3,result.indexOf("^^^")); var r2 =
     * result.substring(result.indexOf("^^^")+3,result.length);
     * 
     * if(r1.length > 10){ $("#spec_func").html("<pre>"+r1+"</pre>");
     * 
     * }else{ $("#func_section").hide();
     * 
     * if($("#spec_body").html().length < 10){ $("#spec_section").show(); } }
     * 
     * //주의사항 if(r1.length > 10 && r0.length > 10){ $("#spec_func").html("<pre>"+r1+"</pre>"+r0); }
     * 
     * if($("#spec_func > pre").height() < 250){ $("#spec_more").hide(); }else{
     * $("#spec_more").show(); }
     * 
     * //용어설명 if(r2.length > 50){ $("#guide_body").html(r2);
     * 
     * if($("#guide_body > pre").height() < 139){ $("#guide_more").hide();
     * }else{ $("#guide_more").show(); } }else{ $("#guide_section").hide(); } },
     * error: function (xhr, ajaxOptions, thrownError) { //alert(xhr.status);
     * //alert(thrownError); } });
     * 
     */
    var param = {
        "modelno": vModelno,
        "procType": 3
    };

    $.ajax({
        type: "get",
        url: "/lsv2016/ajax/detail/getGoodsDesc_ajax.jsp",
        async: true,
        data: param,
        dataType: "json",
        success: function(json) {
            // 상세설명
            var enuri_func_title = json["enuri_func_title"];
            var enuri_func_1 = json["enuri_func_1"];
            var enuri_func_2 = json["enuri_func_2"];
            var enuri_func_3 = json["enuri_func_3"];
            var enuri_func_all = enuri_func_1 + enuri_func_2 + enuri_func_3;

            if (typeof(enuri_func_title) != "undefined" && enuri_func_title != "") {
                enuri_func_title = "<h3>" + enuri_func_title.replace(/<!--br-->/gi, "<br>") + "</h3>";
            }

            if (enuri_func_all.length > 10) {
                $("#spec_func").html("<pre>" + enuri_func_title + enuri_func_1.replace(/※/gi, "<br>※") + enuri_func_2 + enuri_func_3 + "</pre>");
            } else {
                $("#func_section").hide();

                if ($("#spec_body").html().length < 10) {
                    $("#spec_section").show();
                }
            }

            if ($("#spec_func > pre").height() < 130) {
                $("#spec_more").hide();
            } else {
                $("#spec_more").show();

                $("#spec_func a").empty();
            }

            // 용어사전
            var enuri_termdic1 = json["enuri_termdic1"];
            var enuri_termdic2 = json["enuri_termdic2"];
            var enuri_termdic3 = json["enuri_termdic3"];
            // var enuri_termdic_all = enuri_termdic1 + enuri_termdic2 +
            // enuri_termdic3;


            if (enuri_termdic1 || enuri_termdic2 || enuri_termdic3) {
                $('#guide_section').show();
            } else {
                $("#guide_section").hide();
            }

            for (i = 0; i < 3; i++) {
                var term_obj;
                var termdic_col;

                termdic_col = $("#guide_body");

                if (i == 0) {
                    term_obj = enuri_termdic1;
                } else if (i == 1) {
                    term_obj = enuri_termdic2;
                } else if (i == 2) {
                    term_obj = enuri_termdic3;
                }
                if (term_obj && term_obj.length > 0) {
                    $.each(term_obj, function(Index, listData) {
                        var term_html = "";
                        var kbno = listData["kbno"];
                        var title = listData["title"];
                        var titmeimg = listData["titmeimg"];
                        var img_width = listData["img_width"];
                        var img_height = listData["img_height"];
                        var func_content = listData["func_content"];
                        var func_option = listData["func_option"];

                        term_html += "<div class=\"term_contents\"><h3>" + title;
                        /*
                        if (func_option == "1") {
                        	// 용어사전 레이어(자세히)
                        	term_html += "&nbsp;<img align='absmiddle' src='http://img.enuri.info/images/view/blue/btn_picture_0813.gif' onclick='showTermDicKb("+ kbno + ", this);'>";
                        } else if (func_option == "2") {
                        	// 지식통 링크(더보기)
                        	// term_html += "&nbsp;<img
                        	// align='right'
                        	// src='http://img.enuri.info/images/detail/more_btn.gif'
                        	// onclick='CmdGotoBeginnerDic("+kbno+");'
                        	// style='cursor:pointer;'>";
                        }
                        */
                        term_html += "</h3>";
                        term_html += "<pre>";
                        var kttFuncContent = func_content.split("<break>");
                        if (kttFuncContent.length > 1) {
                            if (kttFuncContent[0].length > 2 && kttFuncContent[0].substring(kttFuncContent[0].length - 2) == "\r\n") {
                                kttFuncContent[0] = kttFuncContent[0].substring(0, kttFuncContent[0].length - 2) + "<br>";
                            }
                            term_html += kttFuncContent[0];
                        }
                        if (titmeimg.length > 0) {
                            // 플래쉬 일 경우
                            if (titmeimg.length > 4 && titmeimg.substring(titmeimg.length - 4) == ".swf") {
                                term_html += "<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" codebase=\"http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0\" width=\"" +
                                    img_width +
                                    "\" height=\"" +
                                    img_height +
                                    "\" id=\"titleimg_" +
                                    kbno +
                                    "\" align=\"left\" style=\"margin-bottom:2;border:1 solid gray;\">";
                                term_html += "<param name=\"allowScriptAccess\" value=\"always\" /><param name=\"allowFullScreen\" value=\"false\" /><param name=\"quality\" value=\"high\" /><param name=\"wmode\" value=\"transparent\" />";
                                term_html += "<param name=\"bgcolor\" value=\"#ffffff\" /><param name=\"movie\" value=\"http://storage.enuri.info/pic_upload/termdictitle/" +
                                    titmeimg +
                                    "\" />";
                                term_html += "<param name=\"FlashVars\" value=\"\" /><embed src=\"http://storage.enuri.info/pic_upload/termdictitle/" +
                                    titmeimg +
                                    "\" quality=\"high\" wmode=\"transparent\" bgcolor=\"#ffffff\" width=\"" +
                                    img_width +
                                    "\" height=\"" +
                                    img_height +
                                    "\" id=\"titleimg_" +
                                    kbno +
                                    "\" name=\"titleimg_" +
                                    kbno +
                                    "\" align=\"left\" swLiveConnect=true allowScriptAccess=\"always\" type=\"application/x-shockwave-flash\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\" /></embed>";
                                term_html += "</object>";
                            } else { // 일반 이미지 일 경우
                                term_html += "<img align='left' src='http://storage.enuri.info/pic_upload/termdictitle/" +
                                    titmeimg +
                                    "' onload=\"resizeGuideHeaderImage(this)\" style=\"border:1px solid gray;margin:0 4px 2px 0;padding:0 0 0 0;\">";
                            }
                        }
                        if (kttFuncContent.length > 1) {
                            term_html += kttFuncContent[1];
                        } else {
                            term_html += kttFuncContent[0].replace("<P ", "<span ").replace("</P>", "</span>");
                        }
                        term_html += "</pre></div>";
                        termdic_col.append(term_html);

                        $("#guide_body a").empty();
                    });
                }
            }

            $("#guide_body").html("<pre>" + $("#guide_body").html() + "</pre>");

            if ($("#guide_body > pre").height() < 100) {
                $("#guide_more").hide();
            } else {
                $("#guide_more").show();
            }

            $("#bottom_recommend").show();
        },
        error: function(xhr, ajaxOptions, thrownError) {
            // alert(xhr.status);
            // alert(thrownError);
        }
    });

    $('.infoBox .more button').unbind("click");
    $('.infoBox .more button').click(function() {
        var _this = $(this);
        _this.parent().parent().find('.info_part').toggleClass('open');
        _this.toggleClass('on');
        _this.text('접기');
        if (_this.hasClass('on') != 1) {
            _this.text('더보기');
        }
    });

    // 화장품 성분비교 추가
    if (vCate2 == "08") {

        var vData_conponent = {
            modelno: vModelno,
            cacode: vCa_code,
            opt: "ALL_T"
        };
        $.ajax({
            type: "GET",
            url: "/common/jsp/Ajax_Component_Data.jsp",
            data: vData_conponent,
            dataType: "JSON",
            success: function(json) {
                if (json.resultmsg == "success") {
                    var vAll_Component = json.all_component_data[0];
                    var vGoodness_type = json.all_component_data[1];
                    var vComponent_items = json.all_component_data[2];

                    var template = "";

                    var vGood_item_txt = "";
                    var vGood_item_ids = "";
                    var vBad_item_txt = "";
                    var vBad_item_ids = "";

                    var vTemplate = "";
                    var vTemplate_ids = "";

                    if (vAll_Component.total_cnt > 0) {
                        componentMakeUI(vAll_Component, vGoodness_type, vComponent_items);
                        /*template += "<tr>";
						template += "	<th scope=\"row\" rowspan=\"1\">전성분</th>";
						template += "	<td>"
								+ vAll_Component.total_cnt
								+ "개<em class=\"more_ly\" onclick=\"show_component(1,'"
								+ vAll_Component.all_component
								+ "')\">더보기</em></td>";
						template += "</tr>";
						
						if (vComponent_items.component_items.length > 0) {
							for (var i = 0; i < vComponent_items.component_items.length; i++) {
								if (vComponent_items.component_items[i].cpt_harmflag == "0") { // 좋은성분
									vGood_item_txt += vComponent_items.component_items[i].cpt_name
											+ "("
											+ vComponent_items.component_items[i].cpt_cnt
											+ ")    ";
									
									if (vGood_item_ids != "" && vComponent_items.component_items[i].cp_ids != "") {
										vGood_item_ids += ",";
									}
									vGood_item_ids += vComponent_items.component_items[i].cp_ids;
								} else { // 나쁜성분
									vBad_item_txt += vComponent_items.component_items[i].cpt_name
											+ "("
											+ vComponent_items.component_items[i].cpt_cnt
											+ ")    ";
									if (vBad_item_ids != "" && vComponent_items.component_items[i].cp_ids != "") {
										vBad_item_ids += ",";
									}
									vBad_item_ids += vComponent_items.component_items[i].cp_ids;
								}

								// if(vComponent_items.component_items[i].cp_ids
								// != ""){
								if (vComponent_items.component_items[i].cpt_harmflag == "0") {
									if (v1_txt != "") {
										v1_txt += "^";
									}
									if (vComponent_items.component_items[i].cp_ids != "") {
										v1_txt += vComponent_items.component_items[i].cpt_name
												+ ","
												+ vComponent_items.component_items[i].cp_ids;
									} else {
										v1_txt += vComponent_items.component_items[i].cpt_name;
									}
								} else if (vComponent_items.component_items[i].cpt_harmflag == "1") {
									if (v2_txt != "") {
										v2_txt += "^";
									}
									if (vComponent_items.component_items[i].cp_ids != "") {
										v2_txt += vComponent_items.component_items[i].cpt_name
												+ ","
												+ vComponent_items.component_items[i].cp_ids;
									} else {
										v2_txt += vComponent_items.component_items[i].cpt_name;
									}
								}
								// }
							}
							
						}
						template += "<tr>";
						template += "	<th scope=\"row\" rowspan=\"1\">좋은성분</th>";
						template += "	<td><span class=\"good\">"
								+ vGood_item_txt + "</span>";
						if (vGood_item_ids != "") {
							template += "		<em class=\"more_ly\" onclick=\"show_component(2,'"
									+ vGood_item_ids + "')\">더보기</em>";
						}
						template += "	</td>";
						template += "</tr>";
						template += "<tr>";
						template += "	<th scope=\"row\" rowspan=\"1\">유의성분</th>";
						template += "	<td><span class=\"care\">"
								+ vBad_item_txt + "</span>";
						if (vBad_item_ids != "") {
							template += "		<em class=\"more_ly\" onclick=\"show_component(3,'"
									+ vBad_item_ids + "')\">더보기</em>";
						}
						template += "	</td>";
						template += "</tr>";
						
				
						
						if (vGoodness_type.goodness_type.length > 0) {
							for (var i = 0; i < vGoodness_type.goodness_type.length; i++) {
								vTemplate += "			<li><em class=\"p"
										+ vGoodness_type.goodness_type[i].cpt_goodness_round_percent
										+ "\">"
										+ vGoodness_type.goodness_type[i].cpt_goodness_percent
										+ "%</em>"
										+ vGoodness_type.goodness_type[i].cpt_group_name
										+ "</li>";

								if (vTemplate_ids != ""
										&& vGoodness_type.goodness_type[i].cp_ids != "") {
									vTemplate_ids += ",";
								}
								vTemplate_ids += vGoodness_type.goodness_type[i].cp_ids;

								// if(vGoodness_type.goodness_type[i].cp_ids
								// != ""){
								if (v3_txt != "") {
									v3_txt += "^";
								}
								if (vGoodness_type.goodness_type[i].cp_ids != "") {
									v3_txt += vGoodness_type.goodness_type[i].cpt_group_name
											+ "에 좋은성분,"
											+ vGoodness_type.goodness_type[i].cp_ids;
								} else {
									v3_txt += vGoodness_type.goodness_type[i].cpt_group_name
											+ "에 좋은성분";
								}
								// }
							}

							template += "<tr>";
							template += "	<th colspan=\"2\" class=\"title\">· 피부타입별 적합도<em class=\"more_ly\" onclick=\"show_component(4,'"
									+ vTemplate_ids
									+ "')\">더보기</em></th>";
							template += "</tr>";
							template += "<tr>";
							template += "	<td colspan=\"2\" class=\"type_skin\">";
							template += "		<ul class=\"type\">";
							template += vTemplate;
							template += "		</ul>";
							template += "	</td>";
							template += "</tr>";
						}
						
					
						// 피부타입별 적합도 안내 TOGGLE
					
						// template = template.replace(/&amp;/gi,"&");
						//$("#cosmetic_body").html(template);
						//$("#cosmetic_section").show();

						var vAllcpids = "";

						if (vGood_item_ids != "") {
							vAllcpids += vGood_item_ids;
						}
						if (vBad_item_ids != "") {
							if (vAllcpids != "") {
								vAllcpids += ",";
							}
							vAllcpids += vBad_item_ids;
						}
						if (vTemplate_ids != "") {
							if (vAllcpids != "") {
								vAllcpids += ",";
							}
							vAllcpids += vTemplate_ids;
						}

						// 각각 성분 가지고 와서 배열에 담기
						var vData_conponent = {
							cpids : vAllcpids,
							cacode : vCa_code,
							opt : "4"
						};

						$.ajax({
							type : "GET",
							url : "/common/jsp/Ajax_Component_Data.jsp",
							data : vData_conponent,
							dataType : "JSON",
							success : function(json_detail) {
								if (json_detail.resultmsg == "success") {
									if (json_detail.component_list.length > 0) {
										// for (var i=0; i <
										// json_detail.component_list.length;
										// i++) {

										// }
										vComponent_detaill = json_detail.component_list;
									}
								}
							}
						});
*/
                    } else {
                        $("#cosmetic_section").hide();
                    }
                } else {
                    $("#cosmetic_section").hide();
                }
            }
        });
    }
    loadAttr(vModelno, vCa_code);

}


//가구 속성 추가 (20190410)
function loadAttr(gModelno, szCategory) {
    var modelno = gModelno;
    var ca_code = "";
    var attrId = "";

    var ca_code4 = szCategory.substring(0, 4);
    var ca_code6 = szCategory.substring(0, 6);
    var ca_code8 = szCategory.substring(0, 8);

    //가구 속성 
    if ((ca_code4 == "1201" || ca_code4 == "1202")) {
        ca_code = ca_code4;
    } else {
        return;
    }

    var param = {
        "modelno": modelno,
        "ca_code": ca_code
    };
    $.ajax({
        type: "get",
        url: "/lsv2016/ajax/detail/getGoodsAttrGraph.jsp",
        data: param,
        dataType: "json",
        success: function(result) {
            var listAry = result["list"];
            if ((ca_code == "1201" || ca_code == "1202")) {
                loadFurniture(listAry);
            }
        },
        error: function(e) {

        }
    });

}

function loadFurniture(json) {
    var furHtml = "";
    if (json.length > 0) {
        $.each(json, function(index, listData) {
            var attribute_id = listData["attribute_id"];
            var attribute_element_id = listData["attribute_element_id"];
            var attribute_element = listData["attribute_element"];
            var attribute_title = "";
            var attribute_type = "";
            var attribute_elementClass = "";
            var attribute_typeClass = "";
            if (attribute_id == 123660 || attribute_id == 133553) {
                attribute_type = "1";
                attribute_title = "자재등급";
            } else if (attribute_id == 211331) {
                attribute_type = "2";
                attribute_title = "착석감";
            } else if (attribute_id == 205023) {
                attribute_type = "2";
                attribute_title = "쿠션감";
                if (attribute_element_id == 5) attribute_element_id = 1;
                else if (attribute_element_id == 6) attribute_element_id = 2;
                else if (attribute_element_id == 2) attribute_element_id = 3;
                else if (attribute_element_id == 3) attribute_element_id = 4;
                else if (attribute_element_id == 7) attribute_element_id = 5;
            }

            attribute_typeClass = "fun_grade_0" + attribute_type;

            furHtml += "	<div class=\"fun_grade " + attribute_typeClass + "\">";
            furHtml += "		<h1>" + attribute_title + "</h1>";

            if (attribute_type == "1") {
                attribute_elementClass = "level_" + attribute_element.toLowerCase();
                furHtml += "		<div class=\"grade_level " + attribute_elementClass + "\">";
                furHtml += "			<div class=\"txt_level\"></div>";
                furHtml += "			<ul class=\"grade_graph \">";
                furHtml += "				<li><span>E2</span></li>";
                furHtml += "				<li><span>E1</span></li>";
                furHtml += "				<li><span>E0</span></li>";
                furHtml += "				<li><span>SE0</span></li>";
                furHtml += "			</ul>";
                furHtml += "		</div>";
                furHtml += "		<span class=\"txt_noti\">유해물질 포름알데히드 방출량에 따른 등급분류</span>";
            } else if (attribute_type == "2") {
                attribute_elementClass = "level_0" + attribute_element_id;
                furHtml += "		<div class=\"grade_level " + attribute_elementClass + "\">";
                furHtml += "			<div class=\"txt_level\"></div>";
                furHtml += "			<ul class=\"grade_graph \">";
                furHtml += "				<li><span>1</span></li>";
                furHtml += "				<li><span>2</span></li>";
                furHtml += "				<li><span>3</span></li>";
                furHtml += "				<li><span>4</span></li>";
                furHtml += "				<li><span>5</span></li>";
                furHtml += "			</ul>";
                furHtml += "		</div>";
                furHtml += "			<span class=\"txt_noti\">푹신함의 강도를 나타내며, 1이 가장 푹신하고 5가 가장 단단합니다.</span>";
            }
            furHtml += "	</div>";
        });

        $("#lpvip_fun_grade").html(furHtml);
        $("#lpvip_fun_grade").show();
    } else {
        $("#lpvip_fun_grade").hide();
    }


}


function loadCaution() {
    var modelno = vModelno;
    var cate = vCa_code;
    //var modelnm = vModelNm;
    //var factory = szFactory;
    //var brand = vBrand;
    //var spec	= szSpec;
    var param = {
        //"random_seq" : random_seq,
        "modelnos": modelno,
        "ca_code": cate,
        "view_type": 1,
        //"modelnm" : modelnm,
        //"factory" : factory,
        //"brand" : brand,
        //"spec" : strCautionSpec,
        "deviceType": 2
            //"spec" : spec
    };

    $.ajax({
        type: "get",
        url: "/lsv2016/ajax/detail/getCautionInfo_ajax.jsp",
        async: true,
        data: param,
        dataType: "json",
        success: function(json) {
            if (json != null) {
                var aos_url = json["andrd_url"];
                var ios_url = json["ios_url"];
                var img_url = json["mobl_img_url"];
                if (img_url != "" && typeof(img_url) != "undefined") {
                    $("#caution_info").html("<img src=\"" + img_url + "\" onerror=\"replaceImg(this);\"> ");
                }
                $("#caution_info").show();
                $("#caution_info").click(function() {
                    if (vAppyn == "Y" && aos_url != "") {
                        if (window.android && aos_url != "") {
                            window.open(aos_url);
                        } else if (ios_url != "") {
                            window.open(ios_url);
                        }
                    } else if (aos_url != "") {
                        window.open(aos_url);
                    }

                });
            } else {
                $("#caution_info").hide();
            }
        },
        error: function(xhr, ajaxOptions, thrownError) {
            //alert(xhr.status);
            //alert(thrownError);
        }
    });
}

function onoff(id) {
    var mid = document.getElementById(id);
    if (mid.style.display == '') {
        mid.style.display = 'none';
        if (id == "skin_ly") {
            $("body").css("overflow-y", "auto");
            //unlockScroll();
            //$("body").scrollTop(vNow_scroll);
        }
    } else {
        mid.style.display = '';
    }
}

function componentMakeUI(vAll_Component, vGoodness_type, vComponent_items) {
    var vGoods_itemTemplate = "";
    var vBad_itemTemplate = "";
    var vGoods_Itemli = "";
    var vBad_Itemli = "";
    var vGoodnessTemplate = "";
    var vAllTemplate = "";
    var vTemplate = "";
    var cpt_name = "";
    for (var i = 0; i < vGoodness_type.goodness_type.length; i++) {
        vTemplate += "<li><em class=\"p" + vGoodness_type.goodness_type[i].cpt_goodness_round_percent + "\">" + vGoodness_type.goodness_type[i].cpt_goodness_percent + "%</em>" + vGoodness_type.goodness_type[i].cpt_group_name + "</li>";
    }
    for (var i = 0; i < vComponent_items.component_items.length; i++) {
        if (vComponent_items.component_items[i].cpt_harmflag == "0") {
            if (vComponent_items.component_items[i].cpt_name == "피부보습") {
                cpt_name = "피부 보습";
            } else {
                cpt_name = "피부 " + vComponent_items.component_items[i].cpt_name
            }
            if (vComponent_items.component_items[i].cpt_cnt == "0") {
                vGoods_Itemli += "<li><em class=\"non\">" + vComponent_items.component_items[i].cpt_cnt + "</em>" + cpt_name + "</li>";
            } else {
                vGoods_Itemli += "<li><em class=\"on\">" + vComponent_items.component_items[i].cpt_cnt + "</em>" + cpt_name + "</li>";
            }
        } else {
            if (vComponent_items.component_items[i].cpt_cnt == "0") {
                vBad_Itemli += "<li><em class=\"non\">" + vComponent_items.component_items[i].cpt_cnt + "</em>" + vComponent_items.component_items[i].cpt_name + "</li>";
            } else {
                vBad_Itemli += "<li><em class=\"on\">" + vComponent_items.component_items[i].cpt_cnt + "</em>" + vComponent_items.component_items[i].cpt_name + "</li>";
            }
        }
    }
    vGoodnessTemplate += "<div class=\"cosmeticsgraph\">";
    vGoodnessTemplate += "	<h2 class=\"cosmeticsgraph__tit\">피부타입별 적합도";
    vGoodnessTemplate += "		<span class=\"cosmeticsgraph__tit--info\">";
    vGoodnessTemplate += "			<i class=\"ico_i\">i</i> ";
    vGoodnessTemplate += "			<span class=\"cosmeticsgraph__tit--layer\"><em>피부타입 별 적합도</em><b>%가 높을 수록 해당 피부타입에 적합한 제품</b>이며, 적합도는 전성분의 특성을 분석하여 산출된 값입니다.<i class=\"cls_x\">X</i></span>";
    vGoodnessTemplate += "		</span>";
    vGoodnessTemplate += "	</h2>";
    vGoodnessTemplate += "	<ul class=\"cosmeticsgraph__graph type1\">";
    vGoodnessTemplate += vTemplate;
    vGoodnessTemplate += "	</ul>";
    vGoodnessTemplate += "</div>";

    vGoods_itemTemplate += "<div class=\"cosmeticsgraph\">";
    vGoods_itemTemplate += "	<h2 class=\"cosmeticsgraph__tit\">좋은성분";
    vGoods_itemTemplate += "	</h2>";
    vGoods_itemTemplate += "	<ul class=\"cosmeticsgraph__graph type2\">";
    vGoods_itemTemplate += vGoods_Itemli;
    vGoods_itemTemplate += "	</ul>";
    vGoods_itemTemplate += "</div>";

    vBad_itemTemplate += "<div class=\"cosmeticsgraph\">";
    vBad_itemTemplate += "	<h2 class=\"cosmeticsgraph__tit\">유의성분";
    vBad_itemTemplate += "	</h2>";
    vBad_itemTemplate += "	<ul class=\"cosmeticsgraph__graph type3\">";
    vBad_itemTemplate += vBad_Itemli;
    vBad_itemTemplate += "	</ul>";
    vBad_itemTemplate += "</div>";
    $("#cosmoetics_cont").html(vGoodnessTemplate + vGoods_itemTemplate + vBad_itemTemplate);
    $("#cosmetic_section").show();
    show_component2(1, vAll_Component.all_component, vCa_code, vModelno);
    var cosmetics_status = false;
    $(".cosmeticsgraph__tit--info .ico_i").on("click", function(e) {
        e.preventDefault();
        var layercosmetics = $(this).siblings(".cosmeticsgraph__tit--layer");
        if (!cosmetics_status) {
            $(layercosmetics).fadeIn(100);
            cosmetics_status = true;

            $(".cls_x").click(function(e) {
                e.preventDefault();
                $(".cosmeticsgraph__tit--layer").fadeOut(100);
                cosmetics_status = false;
            });
        } else {
            $(layercosmetics).fadeOut(100);
            cosmetics_status = false;
        }
    });
    $("#onCosmeticInfo").click(function() {
        var layer = $(".layer__cosmeticsinfo");

        $(layer).fadeIn(200);
        $("body").css({ "overflow": "hidden" });

        $(".layer__cosmeticsinfo .close").click(function() {
            $(layer).fadeOut(200);
            $("body").css({ "overflow": "visible" });

            return false;
        });

        return false;
    });
}

function show_component2(part, allcomponent, cacode, modelno) {
    if (part == 1) {
        var vIds = allcomponent.split(",");

        var templete = "";
        var front_name = "";
        $("#skinhead .tit .num").text(vIds.length);
        var vData_conponent = {
            cpids: allcomponent,
            cacode: cacode,
            modelno: modelno,
            opt: "6"
        };
        $.ajax({
            type: "POST",
            url: "/common/jsp/Ajax_Component_Data.jsp",
            data: vData_conponent,
            dataType: "JSON",
            success: function(json_detail) {
                if (json_detail.resultmsg == "success") {
                    if (json_detail.Allcomponent_list.length > 0) {
                        $.each(json_detail.Allcomponent_list, function(i, v) {
                            if (v.cpt_name == "피부보습" && v.cpt_harmflag == "0") {
                                front_name = "피부보습";
                            } else if (v.cpt_name == "건성피부" && v.cpt_harmflag == "1") {
                                front_name = "피부건조";
                            } else if (v.cpt_name == "지성피부" && v.cpt_harmflag == "0") {
                                front_name = "지성좋음";
                            } else if (v.cpt_name == "여드름" && v.cpt_harmflag == "1") {
                                front_name = "여드름";
                            } else if (v.cpt_name == "민감성피부" && v.cpt_harmflag == "0") {
                                front_name = "민감성좋음";
                            } else if (v.cpt_name == "자극" && v.cpt_harmflag == "1") {
                                front_name = "피부자극";
                            } else if (v.cpt_name == "알레르기" && v.cpt_harmflag == "1") {
                                front_name = "알레르기";
                            } else if (v.cpt_name == "미백" && v.cpt_harmflag == "0") {
                                front_name = "피부미백";
                            } else if (v.cpt_name == "탄력" && v.cpt_harmflag == "0") {
                                front_name = "피부탄력";
                            }
                            templete += "<li>";
                            templete += "	<div class=\"lt\">";
                            templete += "		<p class=\"ingredient\">" + v.cp_name_kr + "</p>";
                            templete += "		<span class=\"purpose\">" + v.cp_purpose + "</span>";
                            templete += "	</div>";
                            templete += "	<div class=\"rt\">";
                            if (v.cpt_harmflag == "0") {
                                templete += "			<p class=\"ingredient__detail txt--blue\">" + front_name + "</p>";
                            } else if (v.cpt_harmflag == "1") {
                                templete += "			<p class=\"ingredient__detail txt--red\">" + front_name + "</p>";
                            }

                            templete += "	</div>";
                            templete += "</li>";
                        });
                        $("#cosmeticsinfo__list").html(templete);
                    }
                }
            }
        });
    }
}

function show_component(part, ids) {
    // alert(ids);
    // part 1:전성분, 2: 주의성분, 3:좋은성분, 4: 피부타입별
    if (part == 1) {
        $("#skinhead").text("전성분");

        $("#skinhead").html(null);

        var vIds = ids.split(",");

        var templete = "";

        templete += "<colgroup>";
        templete += "	<col width=\"70%\" />";
        templete += "	<col width=\"30%\" />";
        templete += "</colgroup>";
        templete += "<tr>";
        templete += "	<th colspan=\"2\">전성분(" + (vIds.length) + ")</th>";
        templete += "</tr>";

        if (vIds.length > 0) {
            for (var i = 0; i < vIds.length; i++) {
                templete += "<tr>";
                templete += "	<td colspan=\"2\" class=\"colspan2\">" + vIds[i] +
                    "</td>";
                templete += "</tr>";
            }
        }

        $("#skintable").html(templete);
        $("#skin_ly").show();
        $("body").css("overflow-y", "hidden");
        // lockScroll();
        // vNow_scroll = $("body").scrollTop();
    } else {
        var vText = v1_txt;
        if (part == 2) {
            $("#skintitle").text("좋은성분");
            vText = v1_txt;
        } else if (part == 3) {
            $("#skintitle").text("유의성분");
            vText = v2_txt;
        } else if (part == 4) {
            $("#skintitle").text("피부타입별 적합도");
            vText = v3_txt;
        }

        $("#skintable").html(null);

        var templete = "";

        templete += "<colgroup>";
        templete += "	<col width=\"70%\" />";
        templete += "	<col width=\"30%\" />";
        templete += "</colgroup>";

        // var vText = "미백^탄력^피부보습,71,107,113";

        var vParts = vText.split("^");

        if (vParts.length > 0) {
            for (var i = 0; i < vParts.length; i++) {
                var vTmptxt = vParts[i].split(",");

                if (vTmptxt.length > 0) {
                    for (var j = 0; j < vTmptxt.length; j++) {
                        if (j == 0) { // 타이틀
                            templete += "<tr>";
                            templete += "	<th colspan=\"2\">" + vTmptxt[j] +
                                "(" + (vTmptxt.length - 1) + ")</th>";
                            templete += "</tr>";
                            if (vTmptxt.length - 1 == 0) {
                                templete += "<tr>";
                                templete += "	<td>해당성분없음<td></td>";
                                templete += "</tr>";
                            }
                        } else {
                            for (var k = 0; k < vComponent_detaill.length; k++) {
                                if (vComponent_detaill[k].cp_id == vTmptxt[j]) {
                                    var vPurpose_tmp = "";
                                    if (vComponent_detaill[k].cp_purpose
                                        .indexOf(",") > -1) {
                                        vPurpose_tmp = vComponent_detaill[k].cp_purpose
                                            .substring(
                                                0,
                                                vComponent_detaill[k].cp_purpose
                                                .indexOf(","));
                                    } else {
                                        vPurpose_tmp = vComponent_detaill[k].cp_purpose;
                                    }
                                    templete += "<tr>";
                                    templete += "	<td>" +
                                        vComponent_detaill[k].cp_name_kr +
                                        "</td><td>" + vPurpose_tmp +
                                        "</td>";
                                    templete += "</tr>";
                                    break;
                                }
                            }
                        }
                    }
                }
            }
        }

        // if(vIds.length > 0){
        // for(var i = 0;i < vIds.length;i++){
        // templete += "<tr>";
        // templete += " <td colspan=\"2\" class=\"colspan2\">"+ vIds[i]
        // +"</td>";
        // templete += "</tr>";
        // }
        // }

        $("#skintable").html(templete);
        $("#skin_ly").show();
        $("body").css("overflow-y", "hidden");
        // lockScroll();
        // vNow_scroll = $("body").scrollTop();
    }
}

/***********************************************
	KC 인증마크 관련 함수. by minjae
************************************************/
function getVipKcMark() {
    // 안전인증 및 적합성 인증 여부 데이터 호출 로직 
    var param = {
        "cate": vCa_code,
        "modelno": vModelno
    }

    $.ajax({
        type: "get",
        url: "/lsv2016/ajax/getKcInfo_ajax.jsp",
        async: true,
        data: param,
        dataType: "json",
        success: function(json) {
            var isViewCert = "N";

            if (json && json.kc_info != undefined) {
                var kcObj = json.kc_info;

                var certNumExistIdObj = $("#cert_num_exist_id");
                var certTemplateIdObj = $("#cert_template_id");
                var certViewTrIdObj = $("#cert_view_tr_id");
                var certTitleTextIdObj = $("#cert_title_text_id");

                //전기용품 안전인증 검사 - 노출 카테고리 일 경우 
                if (kcObj.cert_yn != "" && kcObj.cert_yn == "Y") {
                    if (kcObj.cert_value != "T" && kcObj.cert_name != "" && kcObj.cert_key != "") { // template 가 아닌 경우
                        certTitleTextIdObj.text(kcObj.cert_name);
                        certNumExistIdObj.find(".btnKcMark").html(kcObj.cert_key);

                        certNumExistIdObj.find(".btnKcMark").attr("href", "http://safetykorea.kr/search/searchPop?certNum=" + kcObj.cert_key + "&menu=search");

                        certTemplateIdObj.hide();
                        certNumExistIdObj.show();

                    } else {
                        certNumExistIdObj.hide();
                        certTemplateIdObj.show();
                    }
                    isViewCert = "Y";
                    certViewTrIdObj.show();
                } else {
                    certTitleTextIdObj.hide();
                    certNumExistIdObj.hide();
                    certTemplateIdObj.show();
                    certViewTrIdObj.hide();
                }

                var suitTemplateIdObj = $("#suit_template_id");
                var suitNumExistIdObj = $("#suit_num_exist_id");
                var suitViewTrIdObj = $("#suit_view_tr_id");
                var suitViewTrId2Obj = $("#suit_view_tr_id2");

                //적합성 평가 검사 - 노출 카테고리 일 경우 
                if (kcObj.suit_yn != "" && kcObj.suit_yn == "Y") {
                    if (kcObj.suit_value != "T" && kcObj.suit_key != "") {
                        suitNumExistIdObj.find(".btnKcMark").html(kcObj.suit_key);

                        suitTemplateIdObj.hide();
                        suitNumExistIdObj.show();

                    } else {
                        suitNumExistIdObj.hide();
                        suitTemplateIdObj.show();
                    }
                    isViewCert = "Y";
                    suitViewTrIdObj.show();
                    suitViewTrId2Obj.show();
                } else {
                    suitNumExistIdObj.hide();
                    suitTemplateIdObj.show();
                    suitViewTrIdObj.hide();
                    suitViewTrId2Obj.hide();
                }

                if (isViewCert == "Y") {
                    $("#kc_mark_table_id").show();
                } else {
                    $("#kc_mark_table_id").hide();
                }
            }

        }
    });
    // html 랜더링

    $("#kc_mark_table_id").show();
}

// KC인증마크 안내 TOGGLE
var kc_status = false;
$(".info_kc .ico_i").on("click", function(e) {
    e.preventDefault();
    var layerkc = $(this).siblings(".layer_kc");
    if (!kc_status) {
        $(layerkc).fadeIn(100);
        kc_status = true;

        $(".cls_x").click(function(e) {
            e.preventDefault();
            $(".layer_kc").fadeOut(100);
            kc_status = false;
        });
    } else {
        $(layerkc).fadeOut(100);
        kc_status = false;
    }
});

function show_write() {
    if (IsLogin()) {
        $('#review_writefrm').show();

        $("#none_review").hide();

        $("#writerId").text(strID);
        $("#writerNick").text(vUserNick);
        $('#review_writefrm').show();

        $("#review_write_close").unbind("input propertychange");

        $('#review_textarea').bind('input propertychange', function() {
            var text = $(this).val();
            var limit = 500;
            if (this.value.length >= limit) {
                var new_text = text.substr(0, limit);
                $(this).val(new_text);
            }

            $("#review_now_taping").text(this.value.length);

            $(this).css('height', 'auto');
            $(this).height(this.scrollHeight - 14);
        });

        $("#review_write_close").unbind("click");

        $("#review_write_close").click(
            function() {
                $('#review_writefrm').hide();
                return false;
            });
        $("#review_write_up").unbind("click");
        $("#review_write_up").click(function() {
            review_chk();
        });

        insertLog('11796');
    } else {
        goLogin();
    }
}

function review_chk() {
    var formObj = document.getElementById("goodsbbsFrm");

    formObj.contents.value = $("#review_textarea").val();

    if (formObj.contents.value == "" || formObj.contents.value == "상품평을 입력하세요.") {
        alert("내용을 입력해 주세요.");
        return;
    }
    formObj.contents.value = formObj.contents.value.trim().replace(/&/gi,
        "&amp;").replace(/</gi, "&lt").replace(/>/gi, "&gt").replace(
        /\"/gi, "&quot");

    if (formObj.contents.value.length < 5) {
        alert("5자 이상 내용을 입력하셔야 등록이 가능합니다.");
        return;
    }

    formObj.procType.value = "insert";
    formObj.method = "post";
    formObj.target = "hFrame";
    formObj.modelno.value = vModelno;
    formObj.action = "/mobilefirst/include/Goods_bbs_proc.jsp";
    formObj.submit();
}

function cmdAfterKbWrite() {

    // 글쓰기후 콜
    alert("등록 되었습니다.");
    // 내용지우고 레이어닷고
    $("#review_textarea").val("상품평을 입력하세요.");
    $('#review_textarea').height(50);
    $("#review_now_taping").text(0);
    $('#review_writefrm').hide();

    $("#goodsbbsFrm")[0].reset();

    getReview();

    insertLog('11797');

    ga_new(11, '');
}

/*
 * layerPop_del : 댓글을 삭제한다.
 */
var del_modelno = 0;
var del_no = 0;

function layerPop_del(modelno, no) {
    var formObj = document.getElementById("goodsbbsdelFrm");
    formObj.reset();
    document.getElementById("del_pass_input").value = "";
    del_modelno = modelno;
    del_no = no;

    $("#layer_del").show();
    var layerPopHeight = $("#layer_del").find('.layerPopInner').height();
    $("#layer_del").find('.layerPopInner').css('margin-top',
        '-' + layerPopHeight / 2 + 'px');
    $('.layerPop').append('<div class="dimmed"></div>');
    $('html, body').addClass('dimdOn');

}

function sns_good_bbs_del(modelno, no) {
    if (confirm("삭제하시겠습니까?") == true) { //확인
        var delNo = $(this).attr("no");
        fn_sns_goods_bbs_delete(modelno, no);
    } else { //취소
        return;
    }
}

function fn_sns_goods_bbs_delete(modelno, no) {
    $.ajax({
        type: "get",
        url: "/lsv2016/ajax/detail/goods_bbs_list_ajax.jsp",
        data: "modelno=" + modelno + "&del_no=" + no + "&pType=SGD",
        dataType: "JSON",
        success: function(result) {
            if (result.flag == "true") {
                alert("선택하신 글이 삭제되었습니다.");
                $("#" + modelno + no).remove();
                fn_goods_bbs();
            } else {
                alert("사용자 정보가 일치하지 않습니다.");
            }
        },
        error: function(request, status, error) {
            //alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        }
    });
}

function layerPop_del_close(_this) {
    //$('.dimmed').hide();
    $('html, body').removeClass('dimdOn');
    $("#del_pass_input").val('');
    $("#layer_del").hide();
}

function submitDelBbs() {
    var formObj = document.getElementById("goodsbbsdelFrm");
    formObj.del_pass.value = document.getElementById("del_pass_input").value;


    if (formObj.del_pass.value.length < 2) {
        alert("비밀번호를 입력하세요.");
        return;
    }

    /*
    if (!chkPassChar2(formObj.del_pass.value)) {
    	alert("2~12자의 영문,숫자로 입력하세요.");
    	return;
    }
    */

    formObj.del_modelno.value = del_modelno;
    formObj.del_no.value = del_no;
    formObj.procType.value = "del";
    formObj.method = "post";
    formObj.target = "hFrame";
    formObj.action = "/mobilefirst/include/Goods_bbs_proc.jsp";

    formObj.submit();
}

function cmdAfterKbDel() {
    alert("삭제 되었습니다.");
    layerPop_del_close();

    $("#goodsbbsdelFrm")[0].reset();

    getReview();
}

function chkPassChar2(strPass) {
    var regExp = /^[a-zA-Z0-9_]{2,20}$/;

    return regExp.test(strPass);
}

function showDelMsgFlase() {
    alert("비밀번호가 틀렸습니다. 다시 입력하세요.");
    $("#del_pass_input").val("");
}

function insertLog(logNum) {
    $.ajax({
        type: "GET",
        url: "/view/Loginsert_2010.jsp",
        data: "kind=" + logNum,
        success: function(result) {}
    });
}

function insertLog_cate(logNum, cate) {
    $.ajax({
        type: "GET",
        url: "/view/Loginsert_2010.jsp",
        data: "kind=" + logNum + "&cate=" + cate,
        success: function(result) {}
    });
}

function reviewBind(param) {
    // 상품평보기에... 펼치기 접기 기능 바인딩

    // vip Google Analytic 추가 10개만 
    if (param == "photo") {
        $("#review_body_photo li").unbind("click");
        $("#review_body_photo li").click(function() {
            var _this = $(this);
            if (_this.find(".more").hasClass("views")) {
                if (_this.find("div").hasClass("short")) {
                    _this.find("div").removeClass('short');
                    _this.find(".more").toggleClass('less');
                    _this.find(".img_num").hide();

                    ga_new(22, '');
                } else {
                    _this.find("div").addClass('short');
                    _this.find(".more").toggleClass('less');
                    _this.find(".img_num").show();

                    _vThisScroll = _this.offset().top;

                    $("body, html").animate({
                        scrollTop: _vThisScroll - 45
                    }, 500);

                }
            }

            var index = _this.index();
            if (index < 10) {
                index = index + 1;
                var label = "vip_포토 " + index;
                ga('send', 'event', 'mf_vip', 'vip_review_포토 ', label);
            }
        });
    } else if (param == "normal") {
        $("#review_body li .hd_area").each(function() {
            var _this = $(this);
            if (_this.height() > 74) {
                _this.addClass("short");
                _this.parent("li").find(".more").addClass("views");
            }
        });

        $("#review_body li").unbind("click");
        $("#review_body li").click(function() {
            var _this = $(this);
            if (_this.find("div").hasClass("short")) {
                _this.find("div").removeClass('short');
                _this.find(".more").toggleClass('less');
                ga_new(23, '');
            } else {
                _this.find("div").addClass('short');
                _this.find(".more").toggleClass('less');

                _vThisScroll = _this.offset().top;

                $("body, html").animate({
                    scrollTop: _vThisScroll - 45
                }, 500);
            }

            var index = _this.index();
            if (index < 10) {
                index = index + 1;
                var label = " vip_일반 " + index;
                ga('send', 'event', 'mf_vip', 'vip_review_일반', label);
            }
        });
    }
}

function review_page_photo(no) {
    // $("body, html").animate({ scrollTop: $("#tab_position").offset().top },
    // 300);
    if ($("#review_now_photo").text() == $("#review_cnt_photo").text()) {
        // alert("다음 없음");
        return false;
    } else if (vModelno == null || typeof vModelno == "undefined") { // 모델 번호가 없을 경우 포토 상품평 ajax 호출 안함.
        return false;
    } else {
        gbPage_photo++;
    }

    $.ajax({
        type: "get",
        url: "/lsv2016/ajax/detail/goods_bbs_list_ajax.jsp",
        data: "modelno=" + vModelno + "&page=" + gbPage_photo + "&pagesize=" +
            gbPageSize_photo + "&iPoint=" + iPoint + "&nnos=&shopcodes=" +
            shopCodeList + "&pType=GL&isPhoto=Y&word_code=" + vWord_code + "&category=" + vCate4,
        dataType: "JSON",
        success: function(json) {
            $("#reView_List_photo").tmpl(json).appendTo("#review_body_photo");

            if (no == 0) {
                $("#review_now_photo").text(gbPage_photo * gbPageSize_photo);
            } else {
                $("#review_now_photo").text(Number($("#review_now_photo").text()) + json.list.length);
            }

            if ($("#review_now_photo").text() == $("#review_cnt_photo").text()) {
                $("#review_list_more_photo").hide();
            }

            reviewBind('photo');
        },
        error: function(xhr, ajaxOptions, thrownError) {
            // alert(xhr.status);
            // alert(thrownError);
        }
    });
}

function review_page(no) {
    // $("body, html").animate({ scrollTop: $("#tab_position").offset().top },
    // 300);
    if ($("#review_now").text() == $("#review_cnt").text()) {
        // alert("다음 없음");
        return false;
    } else if (vModelno == null || typeof vModelno == "undefined") { // 모델 번호가 없을 경우 포토 상품평 ajax 호출 안함.
        return false;
    } else {
        gbPage++;
    }

    $.ajax({
        type: "get",
        url: "/lsv2016/ajax/detail/goods_bbs_list_ajax.jsp",
        data: "modelno=" + vModelno + "&page=" + gbPage + "&pagesize=" +
            gbPageSize + "&iPoint=" + iPoint + "&nnos=&shopcodes=" +
            shopCodeList + "&pType=GL&word_code=" + vWord_code + "&category=" + vCate4,
        dataType: "JSON",
        success: function(json) {

            $("#reView_List").tmpl(json).appendTo("#review_body");

            if (no == 0) {
                $("#review_now").text(gbPage * gbPageSize);
            } else {
                $("#review_now").text(
                    Number($("#review_now").text()) + json.list.length);
            }

            if ($("#review_now").text() == $("#review_cnt").text()) {
                $("#review_list_more").hide();
            }

            reviewBind('normal');
        },
        error: function(xhr, ajaxOptions, thrownError) {
            // alert(xhr.status);
            // alert(thrownError);
        }
    });
}

/* 상품평 차트 조회 */
function fn_goods_bbs() {
    $.ajax({
        type: "get",
        url: "/lsv2016/ajax/detail/goods_bbs_list_ajax.jsp",
        data: "modelno=" + vModelno + "&pType=GB",
        dataType: "JSON",
        success: function(result) {
            var pObj = result.pointList;

            var resultPointCnt = result.iBbs_num;
            var resultPointavg = result.bbs_point_avg;

            // 별점 재정의
            if (result.bbs_point_avg != "") {
                //$("#review_status1").html("상품평("+ resultPointCnt + ")<span class=\"star_graph ico_m\"><span class=\"ico_m\" style=\"width:"+ resultPointavg * 20 + "%\">별점</span></span><em>"	+ resultPointavg + "/5</em>");
                $("#review_status2").html("사용자평점 <span class=\"star_graph ico_m\"><span class=\"ico_m\" style=\"width:" + resultPointavg * 20 + "%\">별점</span></span><em>" + resultPointavg + "/5</em>");

                //기본 별점 정의
                //$("#review_status_cnt").text(commaNum(resultPointCnt));
                //$("#review_status_width").css("width",resultPointavg * 20 + "%");
                //$("#review_status_avg").text(resultPointavg+"/5");
            }

            /* 차트 */
            if (pObj.length > 0) {
                $("#goodsBbsNoChart").hide();
                var maxPoint = 0;
                var maxPointCnt = 0;

                for (i = 0; i < pObj.length; i++) {
                    var pPoint = pObj[i].point;
                    if (parseInt(pObj[i].pointCnt) > 0) {
                        if (maxPointCnt < parseInt(pObj[i].pointCnt)) {
                            maxPointCnt = parseInt(pObj[i].pointCnt);
                            maxPoint = pPoint;
                        } else if (maxPointCnt == parseInt(pObj[i].pointCnt)) {
                            maxPoint += "," + pPoint;
                        }
                    }

                    if (parseInt(pObj[i].pointCnt) > 0) {
                        $("#goodsBbsChart .star" + pPoint).addClass("pShow");
                        $("#goodsBbsChart .gpoint" + pObj[i].point).parent().addClass("pShow");
                    } else {
                        $("#goodsBbsChart .star" + pPoint).addClass("pHide");
                        $("#goodsBbsChart .gpoint" + pObj[i].point).parent().addClass("pHide");
                    }

                    var chartPoint = (pObj[i].pointCnt / result.iBbs_point_cnt * 100);

                    if (chartPoint > 0 && chartPoint < 10)
                        chartPoint = 10;

                    $("#goodsBbsChart .gpoint" + pObj[i].point).attr("style", "height:" + chartPoint + "%;");

                    var pointCnt = pObj[i].pointCnt;
                    if (pointCnt == "0")
                        pointCnt = "";
                    $("#goodsBbsChart .gpoint" + pObj[i].point + " em").text(pointCnt);
                }

                if (maxPoint != "") {
                    var maxPointArray = maxPoint.split(",");

                    if (maxPointArray.length > 0) {
                        for (i = 0; i < maxPointArray.length; i++) {
                            $("#goodsBbsChart .gpoint" + maxPointArray[i]).addClass("on");
                        }
                    }
                } else {
                    $("#comment_list").hide();
                    $("#divGbTop").hide();
                    $("#divUper").hide();
                    $(".graphBox").hide();
                    if ($("#goodsBbsNoList").css("display") == "none") {
                        $("#goodsBbsNoChart").show();
                    }
                    $("#review_status2").hide();
                }
            } else {
                /*
                 * for(i = 0; i < 5; i++) { $("#goodsBbsChart .star" +
                 * (i+1)).addClass("pHide"); $("#goodsBbsChart .gpoint" +
                 * (i+1)).parent().addClass("pHide"); $("#goodsBbsChart
                 * .gpoint" + (i+1)).attr("style", "height:0%;");
                 * $("#goodsBbsChart .gpoint" + (i+1) + " em").text(""); }
                 */
                $("#comment_list").hide();
                $("#divGbTop").hide();
                $("#divUper").hide();
                $(".graphBox").hide();
                if ($("#goodsBbsNoList").css("display") == "none") {
                    $("#goodsBbsNoChart").show();
                }
            }
        },
        error: function(request, status, error) {
            // alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        }
    });

    /* 쇼핑몰 선택 레이어 */
    $.ajax({
        type: "get",
        url: "/lsv2016/ajax/detail/goods_bbs_list_ajax.jsp",
        data: "modelno=" + vModelno + "&pType=SL",
        dataType: "JSON",
        success: function(result) {
            var shList = result.shoplist;
            var shHtml = "";
            var chkCnt = 0;

            if (shList != null && shList.length > 0) {
                for (i = 0; i < shList.length; i++) {
                    var shObj = shList[i];
                    shHtml += "<option value=\"" + shObj.shop_code + "\">" +
                        shObj.shop_name + "</option>";
                }

                shHtml = "<option value=\"\">전체</option>" + shHtml;

                $("#bbsMall").html(shHtml);

                /* star 갯수 선택 */
                $("#bbsScore").change(function() {
                    iPoint = $(this).val();
                    gbPage = 1;
                    gbPage_photo = 1;
                    getReview();

                    ga_new(12, '');
                });

                /* 쇼핑몰 선택 */
                $("#bbsMall").change(function() {
                    shopCodeList = $(this).val();
                    gbPage = 1;
                    gbPage_photo = 1;
                    getReview();

                    ga_new(13, '');
                });

            } else {
                //alert("등록 된 상품평이 없습니다.");
                //글쓰기만 나오게.
                $("#review_status2").hide();
                $(".selectype_di").hide();
                $("#review_list_more").hide();
            }
        },
        error: function(request, status, error) {
            // console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        }
    });
}

function fn_bbs_filter() {
    //주제별 필터
    $.ajax({
        type: "get",
        url: "/lsv2016/ajax/detail/getCommentFiltering_ajax.jsp",
        data: "modelno=" + vModelno + "&cate=" + catePower,
        dataType: "JSON",
        async: false,
        success: function(json) {
            //베스트글 5개
            if (json.subjectList.length > 2 && json.bbsTopList.length > 1) {
                var vList = json.bbsTopList;
                var vTmp_html = "<ul>";
                for (var i = 0; i < vList.length; i++) {
                    if (i >= 3) break;

                    vTmp_html += "<li><span class=\"irb\">" + vList[i].assess_word_name + "</span> ";

                    var vSublist = vList[i].topSubList;
                    for (var j = 0; j < vSublist.length; j++) {
                        if (j > 0) vTmp_html += ", ";
                        vTmp_html += vSublist[j].contents;
                    }
                    vTmp_html += "</li>";
                }
                vTmp_html += "</ul>";

                $("#bbs_filter_best").html(vTmp_html);
                $("#bbs_filter_best").show();
            } else {
                $("#bbs_filter_best").hide();
            }
            //주제리스트(버튼형)
            if (json.subjectList.length > 2) {
                var vList = json.subjectList;
                var vTmp_html = "<li><a href=\"javascript:///\" class=\"bbs_filter_btt on\" word_code=\"\" onclick=\"fn_bbsfilter(this);\">전체</a></li>";
                for (var i = 0; i < vList.length; i++) {
                    vTmp_html += "<li>";
                    vTmp_html += "<a href=\"javascript:///\" class=\"bbs_filter_btt\" word_code=\"" + vList[i].assess_word_code + "\" onclick=\"fn_bbsfilter(this);\">";
                    vTmp_html += vList[i].assess_word_name + "</a></li>";
                }
                $("#bbs_subfilter").html(vTmp_html);
                $(".subjectList").show();
            } else {
                $(".subjectList").hide();
            }
        },
        error: function(xhr, ajaxOptions, thrownError) {
            //alert(xhr.status);
            //alert(thrownError);
            $("#bbs_filter_best").hide();
            $("#bbs_subfilter").hide();
        }
    });
}

function fn_bbsfilter(obj) {
    //class 초기
    $(".bbs_filter_btt").removeClass("on");
    $(obj).addClass("on");

    vWord_code = $(obj).attr("word_code");

    //리뷰 다시 읽기
    gbPage = 1;
    gbPage_photo = 1;
    getReview();

    //ga 추가 (click_대카테명_중카테명_주제명)
    var vFilter_name = $(obj).text();
    var vLcate_name = $("#lcate_name").text().trim();
    var vMcate_name = $("#mcate_name").text().trim();
    var vTxt = "click_" + vLcate_name + "_" + vMcate_name + "_" + vFilter_name;

    ga_new(24, vTxt);
}

function getReview_preview() {
    //상품평 갯수만 가지고 오는 기능
    var vCnt_photo = 0;
    var vCnt_normal = 0;
    var vChk_photo = false;
    var vChk_normal = false;

    $.ajax({
        type: "get",
        url: "/lsv2016/ajax/detail/goods_bbs_list_ajax.jsp", //by 한지민
        data: "modelno=" + vModelno + "&page=" + gbPage_photo + "&pagesize=" + gbPageSize_photo + "&iPoint=" + iPoint + "&nnos=&shopcodes=" + shopCodeList + "&pType=GL&isPhoto=Y&word_code=" + vWord_code + "&category=" + vCate4,
        dataType: "JSON",
        success: function(json) {
            vCnt_photo = parseInt(json.iTotalCnt);
            vChk_photo = true;
        },
        error: function(xhr, ajaxOptions, thrownError) {
            //alert(xhr.status);
            //alert(thrownError);
        }
    });

    // 상품평
    $.ajax({
        type: "get",
        url: "/lsv2016/ajax/detail/goods_bbs_list_ajax.jsp",
        data: "modelno=" + vModelno + "&page=" + gbPage + "&pagesize=" + gbPageSize + "&iPoint=" + iPoint + "&nnos=&shopcodes=" + shopCodeList + "&pType=GL&word_code=" + vWord_code + "&category=" + vCate4,
        dataType: "JSON",
        success: function(json) {
            vCnt_normal = parseInt(json.iTotalCnt);
            vChk_normal = true;
        },
        error: function(xhr, ajaxOptions, thrownError) {
            //alert(xhr.status);
            //alert(thrownError);
        }
    });

    var vReview_inter_cnt = 0;
    var vReview_Cnt_chk = setInterval(function() {
        if (vChk_normal && vChk_photo) {
            if (vCnt_photo + vCnt_normal > 0) {
                $(".rvtab").show();
                //$("#rvtab1").show();
            }
            if (vCnt_photo + vCnt_normal > 0) {
                $(".rvtab").show();
                if ($("#tab3_cnt_txt").text() == "") {
                    $("#tab3_cnt_txt").text("(" + commaNum(vCnt_photo + vCnt_normal) + ")");
                }
            } else {
                $("#tab3_cnt_txt").text("");
            }
            if (!vFirst_review_cnt) {
                if (vCnt_photo > 0 && vCnt_normal == 0) {
                    //포토상품평은 있고, 일반은 없을때
                    $(".rv_tabs").show();
                    $("#rvtab1_btt").addClass("on");
                    $("#rvtab1").show();
                    ga_new(20, '');
                } else if (vCnt_photo == 0 && vCnt_normal > 0) {
                    //포토상품평은 없고, 일반은 있을때
                    $(".rv_tabs").show();
                    $("#rvtab2_btt").addClass("on");
                    $("#rvtab2").show();
                    $(".btnWrite").show();
                    ga_new(21, '');
                } else if (vCnt_photo > 0 && vCnt_normal > 0) {
                    //둘다 있을때
                    $(".rv_tabs").show();
                    $("#rvtab1_btt").addClass("on");
                    $("#rvtab1").show();
                    ga_new(20, '');
                } else {
                    //둘다 없을때는 default가 display none이니깐. 상관은 없음.
                    $("#div_review").hide();
                    $("#div_review").show();
                    $("#rvtab2").show();
                    $("#review_body").show();
                }
                vFirst_review_cnt = true;
            }

            clearInterval(vReview_Cnt_chk);
        }
        if (vReview_inter_cnt > 100) {
            clearInterval(vReview_Cnt_chk);
        } else {
            vReview_inter_cnt++;
        }
    }, 500);

}

function getReview() {
    // 포토상품평 추가
    var vCnt_photo = 0;
    var vCnt_normal = 0;

    var vChk_photo = false;
    var vChk_normal = false;

    var vData_Photo = "modelno=" + vModelno + "&page=" + gbPage_photo + "&pagesize=" + gbPageSize_photo + "&iPoint=" + iPoint + "&nnos=&shopcodes=" + shopCodeList + "&pType=GL&isPhoto=Y&word_code=" + vWord_code + "&category=" + vCate4;
    var vData_Normal = "modelno=" + vModelno + "&page=" + gbPage + "&pagesize=" + gbPageSize + "&iPoint=" + iPoint + "&nnos=&shopcodes=" + shopCodeList + "&pType=GL&word_code=" + vWord_code + "&category=" + vCate4;

    $.ajax({
        type: "get",
        url: "/lsv2016/ajax/detail/goods_bbs_list_ajax.jsp", //by 한지민
        data: vData_Photo,
        dataType: "JSON",
        async: false,
        success: function(json) {
            $("#review_body_photo").html(null);

            $("#reView_List_photo").tmpl(json).appendTo("#review_body_photo");

            vCnt_photo = parseInt(json.iTotalCnt);

            if (json.iTotalCnt != 0) {
                $(".tab3").removeClass("line1");

                // $("#none_review").hide();
                $("#review_list").show();

                if (json.iTotalCnt < gbPageSize_photo) {
                    $("#review_now_photo").text(json.iTotalCnt);
                } else {
                    $("#review_now_photo").text(gbPageSize_photo);
                }
                $("#review_cnt_photo").text(commaNum(json.iTotalCnt));
                $("#tab_photo_cnt").text(commaNum(json.iTotalCnt));

                if ($("#review_now_photo").text() == $("#review_cnt_photo").text()) {
                    $("#review_list_more_photo").hide();
                } else {
                    $("#review_list_more_photo").show();
                }

                $("#review_list_more_photo").unbind("click");
                $("#review_list_more_photo").click(function() {
                    review_page_photo(1);
                });

                $(".rv_tabs").show();

            } else {
                $("#tab_photo_cnt").text("0");
                $("#review_cnt_photo").text("0");
                //$("#review_body_photo").hide();
                $("#review_list_more_photo").hide();

                $("#review_body_photo").html("<div class=\"novalue\" id=\"goodsBbsNoList\">등록된 포토상품평이 없습니다.</div>");
            }

            vChk_photo = true;
        },
        error: function(xhr, ajaxOptions, thrownError) {
            //alert(xhr.status);
            //alert(thrownError);
        }
    });

    // 상품평
    $.ajax({
        type: "get",
        url: "/lsv2016/ajax/detail/goods_bbs_list_ajax.jsp",
        data: vData_Normal,
        dataType: "JSON",
        async: false,
        success: function(json) {
            $("#review_body").html(null);

            $("#reView_List").tmpl(json).appendTo("#review_body");

            vCnt_normal = parseInt(json.iTotalCnt);

            if (json.iTotalCnt != 0) {
                $(".tab3").removeClass("line1");
                // $("#none_review").hide();
                $("#review_list").show();

                if (json.iTotalCnt < gbPageSize) {
                    $("#review_now").text(json.iTotalCnt);
                } else {
                    $("#review_now").text(gbPageSize);
                }
                $("#review_cnt").text(commaNum(json.iTotalCnt));
                $("#tab_normal_cnt").text(commaNum(json.iTotalCnt));

                if ($("#review_now").text() == $("#review_cnt").text()) {
                    $("#review_list_more").hide();
                } else {
                    $("#review_list_more").show();
                }

                $("#review_list_more").unbind("click");
                $("#review_list_more").click(function() {
                    review_page(1);
                });

            } else {
                $("#tab_normal_cnt").text("0");
                $("#review_cnt").text("0");
                $("#none_review").show();
                $("#review_list").hide();

                $("#review_body").html("<div class=\"novalue\" id=\"goodsBbsNoList\">등록된 상품평이 없습니다.</div>");
                $("#review_list_more").hide();
            }

            vChk_normal = true;
        },
        error: function(xhr, ajaxOptions, thrownError) {
            //alert(xhr.status);
            //alert(thrownError);
        }
    });

    //상품후기 갯수 가지고 올때 비동기로 하기 위한 인터벌, 인터벌 100이 넘으면 정지
    var vReview_inter_cnt = 0;
    var vReview_Cnt_chk = setInterval(function() {
        if (vChk_normal && vChk_photo) {
            if (vCnt_photo + vCnt_normal > 0) {
                $(".rvtab").show();
            }
            clearInterval(vReview_Cnt_chk);
            reviewBind('photo');
            reviewBind('normal');
        }
        if (vReview_inter_cnt > 100) {
            clearInterval(vReview_Cnt_chk);
        } else {
            vReview_inter_cnt++;
        }
    }, 500);
}

function id_chstar(v) {
    // 아이디 뒤에 ***처리
    var d = false;

    if (v.length > 0) {
        var check = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
        var chk_han = v.match(check);
        // d = Pattern.matches("[ㄱ-ㅎㅏ-ㅣ가-힝]", v.substring(0,1));
    } else {
        // 아이디가 없음 ㅡㅡ;;;;;;;;;;;
        v = "******";
    }

    if (d) {
        // 한글이면 홍** 해줌.
        v = v.substring(0, 1) + "**";
    } else {
        // 영문이면 ab**** 해줌.
        if (v.length > 2) {
            v = v.substring(0, 2) + "****";
        } else {
            v = v.substring(0, 1) + "*****";
        }
    }

    return v;
}

//블로그, 동영상 api 기본 셋팅
function fn_potal_api_info() {
    var strKeyword = vModelnm;

    if (strKeyword.indexOf("(") > -1) {
        strKeyword = strKeyword.substring(0, strKeyword.indexOf("("));
    }

    if (strKeyword.indexOf("[") > -1) {
        strKeyword = strKeyword.substring(0, strKeyword.indexOf("["));
    }

    var param = {
        "cate": vCa_code,
        "pType": "RI",
        "keyword": fn_keyword_chang(strKeyword),
        "modelno": vModelno,
        "szModelNm": vModelnm
    };
    $.ajax({
        type: "GET",
        url: "/lsv2016/ajax/detail/getReviewInfoList_ajax.jsp",
        data: param,
        dataType: "JSON",
        async: false,
        success: function(result) {
            if (result.keyword != "") {
                strKeyword = result.keyword;
            }
            vModelnm = strKeyword;

            if (parseInt(result.contents_flag) > 0) {

                if (parseInt(result.blog_flag) > 0) {
                    fn_blogList();
                } else {
                    $("#blog_div").hide();
                }
                if (parseInt(result.video_flag) > 0) {
                    fn_videoList();
                } else {
                    $("#video_div").hide();
                }

            } else {
                $("#blog_div").hide();
                $("#video_div").hide();
            }
        },
        error: function(request, status, error) {
            //console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        }
    });
}

// 블로그
function fn_blogList() {
    $.ajax({
        type: "GET",
        url: "/lsv2016/ajax/detail/getReviewInfoList_ajax.jsp",
        data: "cn=blog&pType=RS&keyword=" + fn_keyword_chang(vModelnm),
        dataType: "JSON",
        success: function(data) {
            var bObj = data.response;
            var bList = (bObj != null ? bObj.docs : null);

            if (bList != null && bList.length > 0) {
                for (i = 0; i < bList.length; i++) {
                    var blObj = bList[i];
                    var blTime = blObj.createTime;
                    blTime = blTime.substring(0, 10);
                    blTime = blTime.replace(/-/g, ".");

                    var vWeblink = blObj.webLink;
                    if (vWeblink.indexOf("?") > -1) {
                        vWeblink = blObj.webLink + "&freetoken=outlink";
                    } else {
                        vWeblink = blObj.webLink + "?freetoken=outlink";
                    }

                    var blHtml = "";
                    blHtml += "<li class=\"blogLi\">";
                    blHtml += "	<a href=\"javascript:///\" onclick=\"window.open('" + vWeblink + "');ga_new(14,'');\">";
                    blHtml += "		<img src=\"" + blObj.imageThumbnail + "\" alt=\"\" class=\"thumb\" onerror=\"this.src='" + errImgSrc + "'\" />";
                    blHtml += "		<span class=\"info\">";
                    // blHtml += " <i class=\"ico\">뉴스</i>";
                    blHtml += "			<span class=\"tit\">" + blObj.title + "</span>";
                    blHtml += "			<span class=\"txt\">" + blObj.body + "</span>";
                    blHtml += "			<span class=\"views\">" + blTime + "</span>";
                    blHtml += "		</span>";
                    blHtml += "	</a>";
                    blHtml += "</li>";

                    $("#ulBlogList").append(blHtml);

                    $("#blog_support").text("(검색지원 : zum)");

                    var exHtml = $("#ulBlogList .blogLi").last().find(".tit").html();
                    var exHtml2 = $("#ulBlogList .blogLi").last().find(".txt").html();

                    if (fn_ex_del(exHtml) == 1 || fn_ex_del(exHtml2) == 1) {
                        $("#ulBlogList .blogLi").last().remove();
                    }

                    if ($("#ulBlogList .blogLi").length > 2) {
                        break;
                    }
                }

            } else {
                $("#blog_div").hide();
            }
        },
        error: function(request, status, error) {
            // console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            $("#blog_div").hide();
        }
    });
}

// 동영상
function fn_videoList() {
    $.ajax({
        type: "GET",
        url: "/lsv2016/ajax/detail/getReviewInfoList_ajax.jsp",
        data: "cn=video&pType=RS&keyword=" + fn_keyword_chang(vModelnm),
        dataType: "JSON",
        success: function(data) {
            var vObj = data.response;
            var vList = (vObj != null ? vObj.docs : null);

            if (vList != null && vList.length > 0) {
                for (i = 0; i < vList.length; i++) {
                    var viObj = vList[i];
                    var viKey = viObj.key;
                    var viLink = viObj.webLink;
                    viLink = viLink.substring(viLink.lastIndexOf("=") + 1, viLink.length);

                    var viTime = viObj.createTime;
                    viTime = viTime.substring(0, 10);
                    viTime = viTime.replace(/-/g, ".");

                    var vWeblink = viObj.webLink;
                    if (vWeblink.indexOf("?") > -1) {
                        vWeblink = viObj.webLink + "&freetoken=outlink";
                    } else {
                        vWeblink = viObj.webLink + "?freetoken=outlink";
                    }

                    var viHtml = "";
                    viHtml += "<li class=\"videoLi\">";
                    viHtml += "	<a href=\"javascript:///\"  onclick=\"window.open('" + vWeblink + "');ga_new(15,'');\">";
                    viHtml += "		<span class=\"imgarea\">";
                    viHtml += "			<img src=\"https://img.youtube.com/vi/" + viLink + "/mqdefault.jpg\" alt=\"\" class=\"thumb\" />";
                    viHtml += "			<i class=\"ico\">Play</i>";
                    viHtml += "		</span>";
                    viHtml += "		<span class=\"info\">";
                    viHtml += "			<span class=\"txt\">" + viObj.title + "</span>";
                    viHtml += "			<span class=\"date\">" + viTime + " | Youtube</span>";
                    viHtml += "		</span>";
                    viHtml += "	</a>";
                    viHtml += "</li>";

                    $("#ulVideoList").append(viHtml);

                    var exHtml = $("#ulVideoList .videoLi").last().find(".txt").html();

                    if (fn_ex_del(exHtml) == 1) {
                        $("#ulVideoList .videoLi").last().remove();
                    }

                    if ($("#ulVideoList .videoLi").length > 4) {
                        break;
                    }
                }

                if ($("#ulVideoList .videoLi").length < 3) { // 2개 이하면  노출 안함
                    $("#video_div").hide();
                }
            } else {
                $("#video_div").hide();
            }
        },
        error: function(request, status, error) {
            // console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            $("#video_div").hide();
        }
    });
}

function fn_ex_del(cVal) {
    var exVal = ["다나와", "danawa", "DANAWA", "DPG", "쿠차", "네이버", "핫딜", "가격비교", "최저가"];
    var rVal = 0;

    for (j = 0; j < exVal.length; j++) {
        if (cVal.indexOf(exVal[j]) > -1) {
            rVal = 1;
            break;
        }
    }

    return rVal;
}

function fn_keyword_chang(v) {
    var sv = encodeURIComponent(v, "UTF-8");

    return sv;
}

function resizeGuideHeaderImage(obj) {
    if (obj.width > 115) {
        obj.width = 115;
    }
}

var vFirst_recommend = false;

function getRecommend() {
    if (!vFirst_recommend) {
        //완료후 데이터가 없을때
        var vRecom1 = $("#recom1").html();
        //var vRecom2 = $("#recom2").html();
        var vRecom3 = $("#recom3").html();
        var vRecom4 = $("#recom4").html();
        var vRecom5 = $("#recom5").html();
        var vRecom6 = $("#recom6").html();
        var vRecom8 = ""; //$("#recom8").html();

        if (!vAdultchk) {
            if (vRecom1 == "") loadRecomGoods(1);
            //if(vRecom2 == "")		loadRecomGoods(2);
            if (vRecom3 == "") loadRecomGoods(3);
            if (vRecom4 == "") loadRecomGoods(4);
            if (vRecom5 == "") loadRecomGoods(5);
            if (vRecom6 == "") loadRecomGoods(6);
            if (vRecom8 == "") loadRecomGoods_peek(8);
            //loadRecomGoods(7);
        }

        //완료후 다시불러온 데이터가 없을때
        vRecom1 = $("#recom1").html();
        //vRecom2 = $("#recom2").html();
        vRecom3 = $("#recom3").html();
        vRecom4 = $("#recom4").html();
        vRecom5 = $("#recom5").html();
        vRecom6 = $("#recom6").html();
        vRecom8 = $("#recom8").html();

        //각각 데이터 없을때 nodata class 추가
        $(".recommandBox").each(function() {
            if ($(this).find("div").html() == "") {
                $(this).addClass("nodata");
            }
        });

        //나오는 메뉴가 2개 이상일때만 해더 나옴
        if ($("#ftListNav > li").filter(":visible").size() < 2) {
            $("#ftListNav").hide();
        }


        if ((vRecom1 + vRecom3 + vRecom4 + vRecom5 + vRecom6 + vRecom8) == "") {
            $(".recommandBox_nochart").show();
        } else {
            if ((vRecom8 + vRecom5 + vRecom4 + vRecom6) == "") {
                $("#contentBox_Top").hide();
            }

            if ((vRecom8 + vRecom5 + vRecom4) == "") {
                $("#recom6_head").click();
            } else if ((vRecom8 + vRecom5) == "") {
                $("#recom4_head").click();
            } else if ((vRecom8) == "") {
                $("#recom5_head").click();
            } else {
                $("#recom8_head").addClass("on");
            }
            $(".recommandBox_nochart").hide();

            if ($("#recom8").html() != "") {
                ga('send', 'event', 'mf_vip', 'vip', 'vip_추천상품_성연령별');
            }
        }
    }
    vFirst_recommend = true;
}

var gb1 = 0;
var gb2 = 0;
var recomCate = "";
var bSupplyTool = false;

function loadRecomGoods(recomType) {
    var loadrecom_pageNum = 1;
    var loadrecom_pageGap = 20;
    if (typeof(recomType) == "undefined" || recomType == "")
        recomType = 1;

    var strUrl = "";
    if (recomType == 1) {
        strUrl = "/lsv2016/ajax/detail/getRecommendGoods_ajax.jsp";
    } else if (recomType == 2) {
        //strUrl = "/lsv2016/ajax/detail/getRecommendGoods2_ajax.jsp";
        return false;
    } else if (recomType == 3) {
        strUrl = "/lsv2016/ajax/detail/getRecommendGoods3_ajax.jsp";
    } else if (recomType == 4) {
        strUrl = "/lsv2016/ajax/detail/getRecommendGoods4_ajax.jsp";
    } else if (recomType == 5) {
        strUrl = "/lsv2016/ajax/detail/getRecommendGoods5_ajax.jsp";
    } else if (recomType == 6) {
        strUrl = "/lsv2016/ajax/detail/getRecommendGoods6_ajax.jsp";
    } else if (recomType == 7) {
        strUrl = "/lsv2016/ajax/detail/getRecommendGoods7_ajax.jsp";
    } else if (recomType == 8) {
        strUrl = "/lsv2016/ajax/detail/getRecommendGoods8_ajax.jsp";
    }

    var param = {
            "nModelNo": vModelno,
            "szCategory": vCa_code,
            "accessoryShowFlag": vAccessoryShowFlag,
            "nModelNoGroup": nModelNoGroup,
            "Refernum": vRefernum,
            "strReferModelno": vReferModelno,
            "szBrand": vBrand,
            "recomType": recomType,
            "pageGap": loadrecom_pageGap,
            "pageNum": loadrecom_pageNum
        }
        // console.log(param);

    $.ajax({
        type: "get",
        url: strUrl,
        async: false,
        data: param,
        dataType: "json",
        success: function(json) {
            var totalcnt = json["totalcnt"];

            if (totalcnt > 0) {
                var recomgoodsListObj = json["recomgoods_list"];
                recomgoodsCntAry[recomType] = totalcnt;
                recomgoodsListAry[recomType] = recomgoodsListObj;

                if ((recomType == 3 || recomType == 1) && totalcnt > 3) {
                    loadRecomGoodsview(recomType);
                } else if (recomType > 3 && recomType != 8 && totalcnt > 2) { //새로 생성된 함수
                    loadRecomGoodsview_new(recomType);
                } else {
                    totalcnt = 0;
                }
            }

            return true;
        },
        error: function(xhr, ajaxOptions, thrownError) {
            // alert(xhr.status);
            // alert(thrownError);
        }
    });
}

function loadRecomGoods_peek(recomType) {
    //8번 전용
    var loadrecom_pageNum = 1;
    var loadrecom_pageGap = 20;
    if (typeof(recomType) == "undefined" || recomType == "")
        recomType = 8;

    var strUrl = strUrl = "/lsv2016/ajax/detail/getRecommendGoods8_ajax.jsp";

    var param = {
        "szCategory": vCa_code,
        "modelno": vModelno_group
    }
    $.ajax({
        type: "get",
        url: strUrl,
        async: false,
        data: param,
        dataType: "json",
        success: function(json) {

            if (json.length > 0) {
                var recomgoodsListObj = json;

                recomgoodsListAry[recomType] = recomgoodsListObj;

                loadRecomGoodsview_peek(recomType);
            }

            return true;
        },
        error: function(xhr, ajaxOptions, thrownError) {
            //alert(xhr.status);
            //alert(thrownError);
        }
    });
}

var lognum = 0;
var recomgoodsPreList = null; // 상품설명 추천상품 미리보기
var recomgoodsListAry = new Array();
var recomgoodsCntAry = new Array();

var recomgoodsListAry_bottom = new Array();
var recomgoodsCntAry_bottom = new Array();

var gtotalcnt = 0;

function loadRecomGoodsview(recomType) {
    var recom_pageNum = 1;
    var recom_pageGap = 20;

    var html = "";
    var recomTitle = "";
    if (recomType == 1) {
        recomTitle = "CM추천 액세서리"; // d
    } else if (recomType == 2) {
        //recomTitle = "동일 시리즈 상품"; // f
        return false;
    } else if (recomType == 3) {
        recomTitle = "함께 살만 한 상품"; // e
    }

    var recomgoodsListObj = recomgoodsListAry[recomType];
    var totalcnt = recomgoodsListObj.length;
    var limtcnt = 20;
    if (totalcnt < limtcnt)
        limtcnt = totalcnt;
    var startcnt = (recom_pageNum - 1) * recom_pageGap;

    html += "	<h1 class=\"tit\">" + recomTitle + "(" + totalcnt + ")</h1>";
    var bSupplyTool = false;

    if (vCate2 != "03") {
        if (vAccessoryShowFlag == 'true' && vCate4 != "0402") {
            bSupplyTool = true;
        }
    }
    html += "<div class=\"horiScrollWrap\">";
    html += "	<div class=\"scrollList\">";
    html += "		<ul class=\"recommandProdList\" id=\"rec_list_" + recomType + "\">";

    var listObj = $("#recom" + recomType);

    listObj.hide();

    /*
     * if(recomType==1) { insertLog(14548); lognum = 14542; } if(recomType==2) {
     * insertLog(14549); lognum = 14543; } if(recomType==3) { insertLog(14550);
     * lognum = 14544; } if(recomType==4) { insertLog(14551); lognum = 14545; }
     * if(recomType==5) { insertLog(14552); lognum = 14546; } if(recomType==6) {
     * insertLog(14553); lognum = 14547; }
     */

    for (var i = startcnt; i < limtcnt; i++) {
        var o_modelno = recomgoodsListObj[i].modelno;
        var o_modelnm = recomgoodsListObj[i].modelnm;
        var o_ca_code4 = recomgoodsListObj[i].ca_code4;
        var o_strImageUrl = recomgoodsListObj[i].strImageUrl;
        var o_minprice = recomgoodsListObj[i].minprice;
        var o_minprice2 = recomgoodsListObj[i].minprice2;
        var o_minprice3 = recomgoodsListObj[i].minprice3;
        var o_imgchk = recomgoodsListObj[i].imgchk;
        var o_sopnShowFlag = recomgoodsListObj[i].sopnShowFlag;
        var o_bbs_point_avg = recomgoodsListObj[i].bbs_point_avg;
        var o_bbs_num = recomgoodsListObj[i].bbs_num;
        var o_gb1 = recomgoodsListObj[i].gb1;
        var o_gb2 = recomgoodsListObj[i].gb2;
        var o_c_date = recomgoodsListObj[i].c_date;
        // 현금몰 비교 로직 추가(2019.11.08)
        var o_cash_min_prc = recomgoodsListObj[i].cashMinPrc;
        var o_cash_min_prc_yn = recomgoodsListObj[i].cashMinPrcYn;
        var o_ovs_min_prc_yn = recomgoodsListObj[i].ovsMinPrcYn;
        // tlc 비교 로직 추가 (2019.12.12)
        var o_tlc_min_prc = recomgoodsListObj[i].tlcMinPrc;

        html += "			<li id=\"" + o_modelno + "\" tit=\"" + recomTitle + "\">";
        html += "				<a href=\"javascript:///\">";
        if (vAdultchk) {
            html += "					<img src=\"http://img.enuri.info/images/home/thum_adult.gif\" alt=\"\" class=\"thumb\" />";
        } else {
            html += "					<img src=\"" + o_strImageUrl + "\" alt=\"\" class=\"thumb\"  onerror=\"replaceImg(this);\" />";
        }
        html += "					<span class=\"info\">";
        html += "						<span class=\"txt\">" + o_modelnm + "</span>";
        html += "						<span class=\"price\">";
        if (typeof o_cash_min_prc_yn != undefined && o_cash_min_prc_yn != null && o_cash_min_prc_yn == "Y" && typeof o_cash_min_prc != undefined && o_cash_min_prc != null) {
            html += "							<em class=\"low\">최저가</em>";
            html += "							<em>" + commaNum(o_cash_min_prc) + "</em>원";
        } else if (typeof o_tlc_min_prc != undefined && o_tlc_min_prc != null && o_tlc_min_prc != "0" && o_minprice == "0") {
            html += "							<em class=\"low\">최저가</em>";
            html += "							<em>" + commaNum(o_tlc_min_prc) + "</em>원";
        } else {
            if (!isNaN(o_c_date) && (parseInt(o_c_date) >= parseInt(cur_date))) {
                html += "							<em class=\"low\">출시예정</em>";
            } else {
                // if(o_minprice > o_minprice3 && o_minprice3 > 0){ //모바일가격이 더
                // 저렴하면
                // html += " <em class=\"low\">최저가</em>";
                // html += " <em>1,449,000</em>원";
                // }else{ //pc가격이 더 저렴하면
                html += "							<em class=\"low\">최저가</em>";
                html += "							<em>" + commaNum(o_minprice) + "</em>원";
                // }
            }
        }
        html += "						</span>";
        html += "					</span>";
        html += "				</a>";
        html += "			</li>";
    }

    if (1 == 2 && totalcnt > 5) {
        html += "			<li class=\"moreProd\">";
        html += "				<a href=\"javascript:///\" onclick=\"fn_recommand('" + recomType + "')\">";
        html += "					<span class=\"ico\"></span>";
        html += "					<span class=\"txt\">더보기</span>";
        html += "				</a>";
        html += "			</li>";
    }

    html += "			</ul>";
    html += "		</div>";
    html += "</div>";

    if (html != "") {
        listObj.html(html);
        listObj.show();

        $("#rec_list_" + recomType + " li").unbind("click");
        $("#rec_list_" + recomType + " li").click(function() {
            var vRecommand_Modelno = $(this).attr("id");
            var vRecommand_title = $(this).attr("tit");

            if (typeof vRecommand_Modelno != "undefined") {
                location.href = "detail.jsp?modelno=" + vRecommand_Modelno;

                ga_new(16, vRecommand_title + '_' + vRecommand_Modelno);
                return false;
            }
        });
    } else {
        listObj.hide();
    }
}

var iosShareText = "";

function click_share() {

    if (varSNSURL == "") {
        CmdShare();
    }

    if (vAppyn == "Y" && vIosyn != 5939) {
        location.href = "shareintent://[" + varSNSTITLE + "]\n " + vModelnm +
            "\n " + varSNSURL;
    } else {
        $('#snsPop').toggle();
    }
}

function CmdShare() {
    if ((SNS_URL + "").indexOf("resentzzim/resentzzimList.jsp") > -1) {
        varSNSTITLE = getResentZzimPageTitle();
        SNS_URL = getResentZzimPageUrl();
    }

    varSNSURL = "m_url=" + SNS_URL;
    varSNSURL = varSNSURL.replace("http://www.enuri.com", "http://m.enuri.com");
    varSNSURL = varSNSURL.replace("app=Y", "app=");
    varSNSURL = varSNSURL.replace("?app=?", "?");
    varSNSURL = varSNSURL.replace("m_url=", "");

    var url = "/url_check/Short_Url_Rtn.jsp";
    var param2 = "org_url=" + varSNSURL;

    var Dns;
    Dns = location.href;
    Dns = Dns.split("//");
    Dns = "http://" + Dns[1].substr(0, Dns[1].indexOf("/"));

    $.ajax({
        type: "POST",
        url: url,
        data: param2,
        async: false,
        success: function(result) {
            varSNSURL = Dns + "/short/" + result.trim();
        }
    });

    try {
        /*
        Kakao.Link.createTalkLinkButton({
        	container : '#kakao-link-btn',
        	label : "[에누리 가격비교]\n" + vModelnm,
        	image : {
        		// src: $("#d_img").attr("src"),
        		src : vImg100,
        		width : '200',
        		height : '200'
        	},
        	webButton : {
        		text : "상품 상세정보 보기",
        		url : varSNSURL
        	}
        });
        		*/

        Kakao.Link.createDefaultButton({
            container: '#kakao-link-btn',
            objectType: 'commerce',
            content: {
                title: '[에누리 가격비교]\n' + vModelnm,
                imageUrl: vImg100,
                link: {
                    mobileWebUrl: varSNSURL,
                    webUrl: varSNSURL
                }
            },
            commerce: {
                regularPrice: vMinprice
            },
            buttons: [{
                title: '상품 상세정보 보기',
                link: {
                    mobileWebUrl: varSNSURL,
                    webUrl: varSNSURL
                }
            }]
        });
        /*
		Kakao.Link.sendDefault({
	        objectType: 'commerce',
	        content: {
	          title: '[에누리 가격비교]\n' + vModelnm,
	          imageUrl: vImg100,
	          link: {
	            mobileWebUrl: varSNSURL,
	            webUrl: varSNSURL
	          }
	        },
	        commerce: {
	          regularPrice: vMinprice
	        },
	        buttons: [
	          {
	            title: '상품 상세정보 보기',
	            link: {
	              mobileWebUrl: varSNSURL,
	              webUrl: varSNSURL
	            }
	          }
	        ]
	      });
	      */
    } catch (e) {
        alert(e);
    }
}

function CmdShare_detail(param) {
    varSNSTITLE = "[에누리 가격비교]\n";

    if (param == "tw") {
        try {
            window.android
                .android_window_open("http://twitter.com/intent/tweet?text=" +
                    encodeURIComponent(varSNSTITLE + vModelnm) +
                    "&url=" + varSNSURL);
        } catch (e) {
            window.open("http://twitter.com/intent/tweet?text=" +
                encodeURIComponent(varSNSTITLE + vModelnm) + "&url=" +
                varSNSURL);
        }
    } else if (param == "face") {
        var url = varSNSURL; // 공유할 URL
        var image = var_img_enuri_com + "/images/mobile4/f_enuri.png"; // 이미지
        // 경로
        var title = varSNSTITLE; // 페이스북 공유 제목 문구
        var summary = vModelnm; // 페이스북 공유 상세문구
        try {
            window.android
                .android_window_open("http://www.facebook.com/sharer.php?t=" +
                    encodeURIComponent(title) + "&u=" + url);
        } catch (e) {
            // url = "http://m.enuri.com";
            window.open("http://www.facebook.com/sharer.php?t=" +
                encodeURIComponent(title) + "&u=" + url);
        }
    } else if (param == "sms") {
        // try{
        // window.android.android_send_sms("", varSNSTITLE+""+varSNSURL);
        // }catch(e){
        location.href = "sms:?body=" + varSNSTITLE + " " + vModelnm +
            "          " + varSNSURL;

        // }
    } else if (param == "line") {
        try {
            window.android.android_window_open("http://line.me/R/msg/text/?" +
                varSNSTITLE + vModelnm + "[" + varSNSURL + "]");
        } catch (e) {
            location.href = "http://line.me/R/msg/text/?" + varSNSTITLE +
                vModelnm + "[" + varSNSURL + "]";
        }
    } else if (param == "copy") {
        var ua = navigator.userAgent.toLowerCase();
        var isAndroid = ua.indexOf("android") > -1;
        if (isAndroid) {
            $("#url_text").text("아래의 URL을 길게 누르면 복사할 수 있습니다.");
        } else {
            $("#url_text").text("아래의 URL을 두번 누르면 복사할 수 있습니다.");
        }
        $("#layer_geturl").show();

        var layerPopHeight = $("#layer_geturl").find('.layerPopInner').height();
        $("#layer_geturl").find('.layerPopInner').css('margin-top',
            '-' + layerPopHeight / 2 + 'px');

        $("#txt_getUrl").val(varSNSURL);

        // $('.layerPop').append('<div class="dimmed"></div>');
        // $('html, body').addClass('dimdOn');

    }

    ga('send', 'event', 'mf_vip', 'vip', 'vip_공유_' + param);
}

function priceNotiClose() {
    //$('.layerPop .dimmed').hide();
    $('html, body').removeClass('dimdOn');
    $("#layer_alarm").hide();
}


var vtMobileurl, vtShopcode, vtPlno, vtGoodscode, vtInstanceprice, vtCategory, vtPrice, vtMinprice, vtModelno; //앱 상세설명용 변수
var vIosUrl, vIosDelivery, vIosshopnm, vIosprice;
var vShopbid_click = "";

function show_detail(url, mobileurl, shopcode, plno, goodscode, instanceprice, category, price, minprice, modelno, delivery, shopnm, shopbid_click) {
    vtMobileurl = mobileurl;
    vtShopcode = shopcode;
    vtPlno = plno;
    vtGoodscode = goodscode;
    vtInstanceprice = instanceprice;
    vtCategory = category;
    vtPrice = price;
    vtMinprice = minprice;
    vtModelno = modelno;

    vIosUrl = url;
    vIosDelivery = delivery;
    vIosshopnm = shopnm;
    vIosprice = price;
    //상위입찰일때 개별로그번호
    vShopbid_click = shopbid_click;

    try {
        if (window.android) {
            window.android.android_detail_review(url, delivery, shopnm, price);
        } else {
            //location.href = "appcall://detailViewInfo";
            location.href = "appcall://detailViewInfo?url=" + encodeURIComponent(vIosUrl) + "&delivery=" + vIosDelivery + "&shopnm=" + vIosshopnm + "&price=" + vIosprice;
        }
    } catch (e) {}

    ga('send', 'event', 'mf_vip', 'vip', 'vip_상세정보미리보기');
}

function appCall_minshop() {
    if (vShopbid_click != "") {
        insertLog_cate(vShopbid_click, vtCategory.substring(0, 4));
        vShopbid_click = "";
    }
    goShop(vtMobileurl, vtShopcode, vtPlno, vtGoodscode, vtInstanceprice, vtCategory, vtPrice, vtMinprice, this, vtModelno);
}

function fn_recommand(no) {
    var param = "nModelNo=" + vModelno +
        "&szCategory=" + vCa_code +
        "&accessoryShowFlag=" + vAccessoryShowFlag +
        "&nModelNoGroup=" + nModelNoGroup +
        "&Refernum=" + vRefernum +
        "&strReferModelno=" + vReferModelno +
        "&szBrand=" + vBrand +
        "&recomType=" + no;

    window.open("/mobilefirst/renew/recommand.jsp?" + param);
}

function go_banner_link(url, name) {
    location.href = url;

    ga('send', 'event', 'mf_vip', '둥둥이배너', name + '_' + vOs_type);
}

function ga_new(no, txt) {
    var vEvent_category = "";
    var vEvent_action = "";
    var vEvent_lable = "";

    if (no == 1) {
        vEvent_category = "mf_vip";
        vEvent_action = "vip_GNB";
        vEvent_lable = "GNB_이전으로";
    } else if (no == 2) {
        vEvent_category = "mf_vip";
        vEvent_action = "vip_GNB";
        vEvent_lable = "GNB_검색";
    } else if (no == 3) {
        vEvent_category = "mf_vip";
        vEvent_action = "vip_GNB";
        vEvent_lable = "GNB_마이에누리";
    } else if (no == 4) {
        vEvent_category = "mf_vip";
        vEvent_action = "vip_option";
        vEvent_lable = "option_배송비 포함 최저가 off";
    } else if (no == 5) {
        vEvent_category = "mf_vip";
        vEvent_action = "vip_option";
        vEvent_lable = "option_배송비 포함 최저가 on";
    } else if (no == 6) {
        vEvent_category = "mf_vip";
        vEvent_action = "vip_option";
        vEvent_lable = "click_탭_기본 최저가";
    } else if (no == 7) {
        vEvent_category = "mf_vip";
        vEvent_action = "vip_option";
        vEvent_lable = "click_탭_단위 환산가";
    } else if (no == 8) {
        vEvent_category = "mf_vip";
        vEvent_action = "vip_option";
        vEvent_lable = "click_옵션선택_기본 최저가";
    } else if (no == 9) {
        vEvent_category = "mf_vip";
        vEvent_action = "vip_option";
        vEvent_lable = "click_옵션선택_단위 환산가";
    } else if (no == 10) {
        vEvent_category = "mf_vip";
        vEvent_action = "vip_banner";
        vEvent_lable = "banner_" + txt;
    } else if (no == 11) {
        vEvent_category = "mf_vip";
        vEvent_action = "vip_review_일반";
        vEvent_lable = "click_글 등록";
    } else if (no == 12) {
        vEvent_category = "mf_vip";
        vEvent_action = "vip_review_일반";
        vEvent_lable = "click_평점 filter";
    } else if (no == 13) {
        vEvent_category = "mf_vip";
        vEvent_action = "vip_review_일반";
        vEvent_lable = "click_쇼핑몰 filter";
    } else if (no == 14) {
        vEvent_category = "mf_vip";
        vEvent_action = "vip_review_일반";
        vEvent_lable = "click_blog";
    } else if (no == 15) {
        vEvent_category = "mf_vip";
        vEvent_action = "vip_review_일반";
        vEvent_lable = "click_video";
    } else if (no == 16) {
        vEvent_category = "mf_vip";
        vEvent_action = "vip_recommend";
        vEvent_lable = "click_" + txt; //예) click_동일 브랜드 인기 상품_1235456  //   click_다른 브랜드 인기 상품_35345
    } else if (no == 17) {
        vEvent_category = "mf_vip";
        vEvent_action = "vip_new_recommend";
        vEvent_lable = "click_" + txt; //예) click_동일 브랜드 인기 상품_1235456  //   click_다른 브랜드 인기 상품_35345
    } else if (no == 18) {
        vEvent_category = "mf_vip";
        vEvent_action = "vip_new_recommend_bottom";
        vEvent_lable = "click_" + txt; //예) click_동일 브랜드 인기 상품_1235456  //   click_다른 브랜드 인기 상품_35345
    } else if (no == 19) {
        vEvent_category = "mf_vip";
        vEvent_action = "vip_new_recommend";
        vEvent_lable = "click_성/연령필터버튼";
    } else if (no == 20) {
        vEvent_category = "mf_vip";
        vEvent_action = "vip_tab";
        vEvent_lable = "tab_포토";
    } else if (no == 21) {
        vEvent_category = "mf_vip";
        vEvent_action = "vip_tab";
        vEvent_lable = "tab_일반";
    } else if (no == 22) {
        vEvent_category = "mf_vip";
        vEvent_action = "vip_review_포토";
        vEvent_lable = "click_포토";
    } else if (no == 23) {
        vEvent_category = "mf_vip";
        vEvent_action = "vip_review_일반";
        vEvent_lable = "click_text";
    } else if (no == 24) {
        vEvent_category = "mf_vip";
        vEvent_action = "vip_주제필터링";
        vEvent_lable = "click_" + txt;
    } else if (no == 25) {
        vEvent_category = "mf_vip";
        vEvent_action = "vip";
        vEvent_lable = "vip_동영상";
    }

    //alert(no);
    //alert(vEvent_category);
    //alert(vEvent_action);
    //alert(vEvent_lable);

    if (vEvent_category != "") {
        ga('send', 'event', vEvent_category, vEvent_action, vEvent_lable);
    }
}

function loadRecomGoodsview_new(recomType) {
    var recom_pageNum = 1;
    var recom_pageGap = 20;

    var html = "";
    var recomTitle = "";
    if (recomType == 4) {
        recomTitle = "동일 브랜드 인기 상품"; // a
    } else if (recomType == 5) {
        recomTitle = "다른 브랜드 인기상품"; // b
    } else if (recomType == 6) {
        recomTitle = "동일 카테고리 인기상품"; // c
    }

    //return false; 


    var recomgoodsListObj = recomgoodsListAry[recomType];
    var totalcnt = recomgoodsListObj.length;

    if (totalcnt < 2) {
        return false;
    }
    var limtcnt = 20;
    if (totalcnt < limtcnt)
        limtcnt = totalcnt;
    var startcnt = (recom_pageNum - 1) * recom_pageGap;

    var bSupplyTool = false;

    if (vCate2 != "03") {
        if (vAccessoryShowFlag == 'true' && vCate4 != "0402") {
            bSupplyTool = true;
        }
    }

    //스펙 내용 가지고 오기
    //모델번호 수집
    //카테고리 수집
    var vTitleModelnos = "";
    var vTitleCate = "";
    if (limtcnt > 0) {
        for (var i = startcnt; i < limtcnt; i++) {
            if (i == 0) vTitleCate = recomgoodsListObj[i].ca_code4;
            if (i > 0) vTitleModelnos += ",";
            vTitleModelnos += recomgoodsListObj[i].modelno;
        }
    }

    //console.log(vTitleCate);
    //console.log(vTitleModelnos);
    var vSpecTitle_json; //스펙에 타이틀
    var vSpecList_json; //스펙에 내용

    $.ajax({
        type: "GET",
        url: "/lsv2016/ajax/detail/getRecommendGoods_addition_ajax.jsp",
        data: "modelnos=" + vTitleModelnos + "&cate=" + vTitleCate + "&part=T&titlecnt=" + vTableCnt,
        dataType: "JSON",
        async: false,
        success: function(json) {
            vSpecTitle_json = json;
        },
        error: function(xhr, ajaxOptions, thrownError) {

        }
    });

    $.ajax({
        type: "GET",
        url: "/lsv2016/ajax/detail/getRecommendGoods_addition_ajax.jsp",
        data: "modelnos=" + vTitleModelnos + "&cate=" + vTitleCate + "&titlecnt=" + vTableCnt,
        dataType: "JSON",
        async: false,
        success: function(json) {
            vSpecList_json = json;
        },
        error: function(xhr, ajaxOptions, thrownError) {

        }
    });

    var listObj = $("#recom" + recomType);
    var titleObj = $("#recom" + recomType + "_title");

    if (vSpecTitle_json.length > 2) {
        listObj.hide();

        if (limtcnt > 0) {

            html += "<div class=\"table-responsive\">";
            html += "	<table class=\"table ft_table\">";
            html += "	<thead>";
            html += "	<tr>";
            html += "		<th class=\"model\">비교모델 <br />(" + totalcnt + ")</th>";
            html += "		<th>최저가</th>";
            html += "		<th>브랜드</th>";
            if (vSpecTitle_json.length > 0) {
                for (var j = 0; j < vSpecTitle_json.length; j++) {
                    html += "		<th class=\"th_" + recomType + "_" + (j + 1) + " " + vSpecTitle_json[j].gpno + "\">" + vSpecTitle_json[j].gp_title + "</th>";
                }
            }

            html += "	</tr>";
            html += "	</thead>";
            html += "	<tbody>";

            for (var i = startcnt; i < limtcnt; i++) {
                var o_modelno = recomgoodsListObj[i].modelno;
                var o_modelnm = recomgoodsListObj[i].modelnm;
                var o_ca_code4 = recomgoodsListObj[i].ca_code4;
                var o_strImageUrl = recomgoodsListObj[i].strImageUrl;
                var o_minprice = recomgoodsListObj[i].minprice;
                var o_minprice2 = recomgoodsListObj[i].minprice2;
                var o_minprice3 = recomgoodsListObj[i].minprice3;
                var o_imgchk = recomgoodsListObj[i].imgchk;
                var o_sopnShowFlag = recomgoodsListObj[i].sopnShowFlag;
                var o_bbs_point_avg = recomgoodsListObj[i].bbs_point_avg;
                var o_bbs_num = recomgoodsListObj[i].bbs_num;
                var o_gb1 = recomgoodsListObj[i].gb1;
                var o_gb2 = recomgoodsListObj[i].gb2;
                var o_c_date = recomgoodsListObj[i].c_date;
                var o_factory = recomgoodsListObj[i].factory;
                var o_brand = recomgoodsListObj[i].brand;
                // 현금몰 비교 로직 추가(2019.11.08)
                var o_cash_min_prc = recomgoodsListObj[i].cashMinPrc;
                var o_cash_min_prc_yn = recomgoodsListObj[i].cashMinPrcYn;
                var o_ovs_min_prc_yn = recomgoodsListObj[i].ovsMinPrcYn;
                // tlc 비교 로직 추가 (2019.12.12)
                var o_tlc_min_prc = recomgoodsListObj[i].tlcMinPrc;

                html += "		<tr>";
                html += "			<td class=\"model detailgo\" modelno=\"" + o_modelno + "\" tit=\"" + recomTitle + "\">";
                html += "				<a href=\"javascript:///\">";
                html += "					<img src=\"" + o_strImageUrl + "\" alt=\"\" class=\"thumb\" onerror=\"replaceImg(this);\" />";
                html += "					<span class=\"pname\">" + o_modelnm + "</span>";
                html += "				</a>";
                html += "			</td>";
                if (typeof o_cash_min_prc_yn != undefined && o_cash_min_prc_yn != null && o_cash_min_prc_yn == "Y" && typeof o_cash_min_prc != undefined && o_cash_min_prc != null) {
                    html += "			<td class=\"low_price detailgo\" modelno=\"" + o_modelno + "\"><a href=\"#\"><strong>" + commaNum(o_cash_min_prc) + "</strong>원</a></td>";
                } else if (typeof o_tlc_min_prc != undefined && o_tlc_min_prc != null && o_tlc_min_prc != "0" && o_minprice3 == "0") {
                    html += "			<td class=\"low_price detailgo\" modelno=\"" + o_modelno + "\"><a href=\"#\"><strong>" + commaNum(o_tlc_min_prc) + "</strong>원</a></td>";
                } else {
                    html += "			<td class=\"low_price detailgo\" modelno=\"" + o_modelno + "\"><a href=\"#\"><strong>" + commaNum(o_minprice3) + "</strong>원</a></td>";
                }
                html += "			<td>" + o_brand + "</td>";
                if (vSpecTitle_json.length > 0) {
                    for (var j = 0; j < vSpecTitle_json.length; j++) {
                        html += "		<td class=\"td_" + recomType + "_" + (j + 1) + "\">";
                        // 스펙리스트에 해당 모델에 해당 스팩이 있으면 노출
                        var vSpec_detail = "";
                        for (var k = 0; k < vSpecList_json.length; k++) {
                            if (vSpecTitle_json[j].gpno == vSpecList_json[k].gpno && o_modelno == vSpecList_json[k].modelno) {
                                if (vSpec_detail != "") {
                                    vSpec_detail += "<br>";
                                }
                                // vSpec_detail += vSpecList_json[k].spec_title;
                                vSpec_detail += vSpecList_json[k].attribute_element;
                            }
                        }

                        if (vSpec_detail != "") {
                            html += vSpec_detail;
                        } else {
                            html += "-";
                        }
                        html += "		</td>";
                    }
                }
                html += "		</tr>";
            }

            html += "	</tbody>";
            html += "	</table>";
            html += "</div>";


            if (html != "") {
                listObj.html(html);
                titleObj.show();

                $(".detailgo").unbind("click");
                $(".detailgo").click(function() {
                    var vGoModelno = $(this).attr("modelno");
                    var vRecommand_title = $(this).attr("tit");

                    location.href = "detail.jsp?modelno=" + vGoModelno;

                    ga_new(17, vRecommand_title + '_' + vGoModelno);
                    return false;
                });
            }
        }
    } else {
        //리턴되는 값이 없을때는 기존 방식으로 보여줌.
        listObj.hide();

        html += "		<ul class=\"ftProdList\" id=\"recommend_recomtype_" + recomType + "\">";

        for (var i = startcnt; i < limtcnt; i++) {
            var o_modelno = recomgoodsListObj[i].modelno;
            var o_modelnm = recomgoodsListObj[i].modelnm;
            var o_ca_code4 = recomgoodsListObj[i].ca_code4;
            var o_strImageUrl = recomgoodsListObj[i].strImageUrl;
            var o_minprice = recomgoodsListObj[i].minprice;
            var o_minprice2 = recomgoodsListObj[i].minprice2;
            var o_minprice3 = recomgoodsListObj[i].minprice3;
            var o_imgchk = recomgoodsListObj[i].imgchk;
            var o_sopnShowFlag = recomgoodsListObj[i].sopnShowFlag;
            var o_bbs_point_avg = recomgoodsListObj[i].bbs_point_avg;
            var o_bbs_num = recomgoodsListObj[i].bbs_num;
            var o_gb1 = recomgoodsListObj[i].gb1;
            var o_gb2 = recomgoodsListObj[i].gb2;
            var o_c_date = recomgoodsListObj[i].c_date;
            // 현금몰 비교 로직 추가(2019.11.08)
            var o_cash_min_prc = recomgoodsListObj[i].cashMinPrc;
            var o_cash_min_prc_yn = recomgoodsListObj[i].cashMinPrcYn;
            var o_ovs_min_prc_yn = recomgoodsListObj[i].ovsMinPrcYn;
            // tlc 비교 로직 추가 (2019.12.12)
            var o_tlc_min_prc = recomgoodsListObj[i].tlcMinPrc;

            html += "			<li modelno=\"" + o_modelno + "\" tit=\"" + recomTitle + "\">";
            html += "				<a href=\"javascript:///\">";
            html += "					<span class=\"fr_img\">";
            if (vAdultchk) {
                html += "					<img src=\"http://img.enuri.info/images/home/thum_adult.gif\" alt=\"\" class=\"thumb\" />";
            } else {
                html += "					<img src=\"" + o_strImageUrl + "\" alt=\"\" class=\"thumb\"  onerror=\"replaceImg(this);\" />";
            }
            html += "					</span>";
            html += "					<span class=\"info\">";
            html += "						<span class=\"txt\">" + o_modelnm + "</span>";
            html += "						<span class=\"price\">";
            if (typeof o_cash_min_prc_yn != undefined && o_cash_min_prc_yn != null && o_cash_min_prc_yn == "Y" && typeof o_cash_min_prc != undefined && o_cash_min_prc != null) {
                html += "							<em class=\"low\">최저가</em>";
                html += "							<em>" + commaNum(o_cash_min_prc) + "</em>원";
            } else if (typeof o_tlc_min_prc != undefined && o_tlc_min_prc != null && o_tlc_min_prc != "0" && o_minprice == "0") {
                html += "							<em class=\"low\">최저가</em>";
                html += "							<em>" + commaNum(o_tlc_min_prc) + "</em>원";
            } else {
                if (!isNaN(o_c_date) && (parseInt(o_c_date) >= parseInt(cur_date))) {
                    html += "							<em class=\"low\">출시예정</em>";
                } else {
                    // if(o_minprice > o_minprice3 && o_minprice3 > 0){ //모바일가격이
                    // 더 저렴하면
                    // html += " <em class=\"low\">최저가</em>";
                    // html += " <em>1,449,000</em>원";
                    // }else{ //pc가격이 더 저렴하면
                    html += "							<em class=\"low\">최저가</em>";
                    html += "							<em>" + commaNum(o_minprice) + "</em>원";
                    // }
                }
            }
            html += "						</span>";
            html += "					</span>";
            html += "				</a>";
            html += "			</li>";
        }
        html += "			</ul>";

        if (html != "") {
            listObj.html(html);
            titleObj.show();

            $("#recommend_recomtype_" + recomType + " li").unbind("click");
            $("#recommend_recomtype_" + recomType + " li").click(function() {
                var vRecommand_Modelno = $(this).attr("modelno");
                var vRecommand_title = $(this).attr("tit");

                if (typeof vRecommand_Modelno != "undefined") {
                    location.href = "detail.jsp?modelno=" + vRecommand_Modelno;

                    ga_new(17, vRecommand_title + '_' + vRecommand_Modelno);
                    return false;
                }
            });
        } else {
            listObj.hide();
        }
    }
}

function loadRecomGoodsview_peek(recomType) {
    var recom_pageNum = 1;
    var recom_pageGap = 20;

    var html = "";
    var htmlHead = "";
    var htmlFM = "";
    var recomTitle = "";
    recomTitle = "남들은 뭘 샀지";

    //return false; 

    var recomgoodsListObj = recomgoodsListAry[recomType];
    var totalcnt = recomgoodsListObj.length;

    var listObj = $("#recom" + recomType);
    var titleObj = $("#recom" + recomType + "_title");

    listObj.hide();

    if (totalcnt > 0) {

        htmlHead += "<ul class=\"onlyOld_tab\" id=\"recommend_tab\">";
        //htmlHead += "	<li><a href=\"javascript:///\" class=\"on\" id=\"peekhead_0\" code=\"0\">전체</a></li>";

        htmlFM += "<div class=\"ftProdTit\">";
        htmlFM += "<p class=\"tag_tit\"><span class=\"tag\" id=\"tag_tit_span\"></span>가 많이 구매한 상품</p>";
        htmlFM += "<ul class=\"gender\" id=\"gender4\" style=\"display:none;\">";
        htmlFM += "<li class=\"on\" onclick=\"\"><span class=\"ico female\"></span>여성</li>";
        htmlFM += "<li onclick=\"\"><span class=\"ico male\"></span>남성</li>";
        htmlFM += "</ul>";
        htmlFM += "</div>";

        html += "<ul class=\"whatProdList\" id=\"recommend_recomtype_" + recomType + "\">";

        var vHead = ""; //값이 없으면 넣고 값을 가지고 있다가 값이 바뀌면 htmlHead 줄이 바뀜.
        var vHead_first = ""; //초기 값
        var vLast_Group = 0;

        var vThis_code = "";
        var vThis_code_cnt = 0;

        var o_varArr = new Array(); //o_var 배열
        var g_gender = "";

        for (var i = 0; i < totalcnt; i++) {
            var o_modelno = recomgoodsListObj[i].modelno;
            var o_modelnm = recomgoodsListObj[i].modelnm;
            var o_ca_code4 = recomgoodsListObj[i].ca_code4;
            var o_strImageUrl = recomgoodsListObj[i].strImageUrl;
            var o_minprice = recomgoodsListObj[i].minprice;
            var o_minprice2 = recomgoodsListObj[i].minprice2;
            var o_minprice3 = recomgoodsListObj[i].minprice3;
            var o_imgchk = recomgoodsListObj[i].imgchk;
            var o_sopnShowFlag = recomgoodsListObj[i].sopnShowFlag;
            var o_bbs_point_avg = recomgoodsListObj[i].bbs_point_avg;
            var o_bbs_num = recomgoodsListObj[i].bbs_num;
            var o_gb1 = recomgoodsListObj[i].gb1;
            var o_gb2 = recomgoodsListObj[i].gb2;
            var o_c_date = recomgoodsListObj[i].c_date;
            //성/연령별로 추가됨
            var o_var_code = recomgoodsListObj[i].var_code;
            var o_var = recomgoodsListObj[i].var;
            var o_lcate = recomgoodsListObj[i].lcate;
            var o_mcate = recomgoodsListObj[i].mcate;
            var o_scate = recomgoodsListObj[i].scate;
            var o_dcate = recomgoodsListObj[i].dcate;
            var o_model_no = recomgoodsListObj[i].model_no;
            var o_gender = recomgoodsListObj[i].gender;
            g_gender = o_gender;
            // 현금몰 비교 로직 추가(2019.11.08)
            var o_cash_min_prc = recomgoodsListObj[i].cashMinPrc;
            var o_cash_min_prc_yn = recomgoodsListObj[i].cashMinPrcYn;
            var o_ovs_min_prc_yn = recomgoodsListObj[i].ovsMinPrcYn;
            // tlc 비교 로직 추가 (2019.12.12)
            var o_tlc_min_prc = recomgoodsListObj[i].tlcMinPrc;

            // 20개 미만 안 보임
            // 현재코드 입력 받고 20개 카운팅 20개 넘어가면 다음.
            if (vThis_code == "" || vThis_code != o_var_code) {
                vThis_code = o_var_code;
                vThis_code_cnt = 0;
            }
            ++vThis_code_cnt;
            // console.log(vThis_code_cnt);

            if (vThis_code_cnt <= 20) {

                if ($.inArray(o_var.split(" ")[0], o_varArr) === -1) {
                    htmlHead += "<li><a href=\"javascript:///\" id=\"peekhead_" + o_var_code + "\" ";
                    // if(i == 0){
                    // htmlHead += " class=\"on\" ";
                    // }
                    htmlHead += " code=\"" + o_var_code + "\">" + o_var.split(" ")[0] + "</a></li>";
                    // vHead = o_var.split(" ")[0]; //vHead로 치환
                    o_varArr.push(o_var.split(" ")[0]);
                }
                if (i == 0) {
                    vHead_first = o_var_code;
                }

                html += "<li modelno=\"" + o_modelno + "\" id=\"" + o_var + "\" class=\"peek_goods peek_" + o_var_code + "\" ";
                //if(vHead_first != o_var_code){
                html += " style=\"display:none\" ";
                //}
                html += " tit=\"" + recomTitle + "\" code=\"" + o_var_code + "\">";
                html += "	<a href=\"javascript:///\">";
                html += "		<span class=\"fr_img\">";
                html += "			<img src=\"" + o_strImageUrl + "\" alt=\"\" class=\"thumb\"  onerror=\"replaceImg(this);\" />";
                html += "		</span>";
                html += "		<span class=\"info\">";
                html += "			<span class=\"txt\">" + o_modelnm + "</span>";
                html += "			<span class=\"price\">";
                html += "				<em class=\"low\">최저가</em>";
                if (typeof o_cash_min_prc_yn != undefined && o_cash_min_prc_yn != null && o_cash_min_prc_yn == "Y" && typeof o_cash_min_prc != undefined && o_cash_min_prc != null) {
                    html += "				<em>" + commaNum(o_cash_min_prc) + "</em>원";
                } else if (typeof o_tlc_min_prc != undefined && o_tlc_min_prc != null && o_tlc_min_prc != "0" && o_minprice3 == "0") {
                    html += "				<em>" + commaNum(o_tlc_min_prc) + "</em>원";
                } else {
                    html += "				<em>" + commaNum(o_minprice3) + "</em>원";
                }
                html += "			</span>";
                html += "		</span>";
                html += "	</a>";
                html += "</li>";
            }
            vLast_Group = o_var_code;
        }

        htmlHead += "</ul>";
        html += "</ul>";

        if (html != "") {
            listObj.html(htmlHead + htmlFM + html);
            listObj.show();
            titleObj.show();

            if (g_gender != "") $("#gender4").show();

            $("#recommend_tab li a").unbind("click");
            $("#recommend_tab li a").click(function() {
                $("#recommend_tab li a").removeClass("on");
                $(this).addClass("on");
                var var_nm = $(this).html();
                $("#tag_tit_span").html("# " + var_nm);
                var vCode = $(this).attr("code");
                var this_index = $("#gender4").find(".on").index() == 1 ? 5 : 0;
                vCode = Number(this_index) + Number(vCode);
                /*$("#gender li").removeClass("on");
                $("#gender li").first().addClass("on");*/

                //if(vCode == 0){
                //	$(".peek_goods").show();		//전체 눌렀을때
                //}else{
                $(".peek_goods").hide();
                $(".peek_" + vCode).show();
                //}

                //ga_new(19,'연령별 필터');
            });

            $("#gender4 li").unbind("click");
            $("#gender4 li").click(function() {
                $("#gender4 li").removeClass("on");
                $(this).addClass("on");
                var this_index = $(this).index() == 1 ? 5 : 0;
                var vCode = "";
                $('#recommend_tab li a').each(function() {
                    if ($(this).hasClass("on")) {
                        vCode = Number(this_index) + Number($(this).attr("code"));
                    }
                });

                $(".peek_goods").hide();
                $(".peek_" + vCode).show();

                //ga_new(19,'성별 필터');
            });

            $("#recommend_recomtype_8 li").unbind("click");
            $("#recommend_recomtype_8 li").click(function() {
                var vRecommand_Modelno = $(this).attr("modelno");
                var vRecommand_var = $(this).attr("id");

                var vRecommand_title = $(this).attr("tit");

                if (typeof vRecommand_Modelno != "undefined") {
                    location.href = "detail.jsp?modelno=" + vRecommand_Modelno;

                    ga_new(17, vRecommand_title + '_' + vRecommand_var);

                    return false;
                }
            });

            //제일 많은 그룹 검색 후 선택
            //마지막 그룹번호 vLast_Group
            var vMany_code = 0; //젤 많은 그룹
            var vMany_group_length = 0; //젤 많았던 그룹의 갯수

            for (var i = 0; i < vLast_Group; i++) {
                var vThis_group_length = $(".peek_" + i).length;
                if (vMany_group_length < vThis_group_length) {
                    vMany_code = $(".peek_" + i).attr("code");
                    vMany_group_length = vThis_group_length;
                    //console.log("i="+i);
                    //console.log("===vMany_code="+vMany_code);
                    //console.log("vMany_group_length="+vMany_group_length);
                    //console.log("vThis_group_length="+vThis_group_length);
                }
            }
            //console.log("===vMany_code="+vMany_code);

            if (vMany_code > 5) {
                vMany_code -= 5;
                $("#peekhead_" + vMany_code).trigger("click");
                $("#gender4 li").get(1).click();
            } else {
                $("#peekhead_" + vMany_code).trigger("click");
                $("#gender4 li").get(0).click();
            }

        }
    }
}

var vRecommend_bottom_1 = "";
var vRecommend_bottom_2 = "";

function getRecommend_bottom() {
    //첫번째 탭 8 > 5 > 4 > 6 순으로 처음 데이터 있는것만 보임
    //두번째 탭 3이 있으면 보이고 없으면 히든

    var vRecom8 = "";
    var vRecom5 = "";
    var vRecom4 = "";
    var vRecom6 = "";
    var vRecom3 = "";

    if (!vAdultchk) {
        if (vRecom8 == "") loadRecomGoods_bottom(8);
        if (vRecom5 == "" && vRecommend_bottom_1 == "") loadRecomGoods_bottom(5);
        if (vRecom4 == "" && vRecommend_bottom_1 == "") loadRecomGoods_bottom(4);
        if (vRecom6 == "" && vRecommend_bottom_1 == "") loadRecomGoods_bottom(6);
        if (vRecom3 == "") loadRecomGoods_bottom(3);
    }

    //alert(vRecommend_bottom_1);
    //alert(vRecommend_bottom_2);

    //풍선 툴팁세팅
    //두개 다 있으면 풍선팁은 남들 뭘 샀지로
    //함께 살만한 상품만 있을대는 풍선툴팁 안나옴
    // 툴팁 미사용으로 주석 처리 02.26
    /*
    if(vRecommend_bottom_1 != "" && vRecommend_bottom_1 != "3"){
    	if(vRecommend_bottom_1 == "8"){
    		$(".balloon_txt .txt").text("남들은 뭘 샀지?");
    		$(".balloon_area").show();
    	}else{
    		//if(typeof $(".ft_table").css("display") != "undefined"){
    		//	$(".balloon_txt").text("추천상품 비교하기");
    		//	$(".balloon_txt").show();
    		//}else{
    		//	$(".balloon_txt").hide();
    		//}
    		if("0404,0405,0201,0502,0621,0602,2401,2406,1004,1007,1020".indexOf(vCate4) > -1){
    			$(".balloon_txt .txt").text("추천상품 비교하기");
    			$(".balloon_area").show();
    		}
    	}
    	$(".balloon_txt").unbind("click");
    	$(".balloon_txt").click(function(){
    		vTab4.click();
    		
    		ga('send', 'event', 'mf_vip', 'vip', 'vip_추천말풍선');
    		
    	});
    }else{
    	$(".balloon_area").hide();
    }
    	*/
    var vTab_html = "";

    if (vRecommend_bottom_1 != "" && vRecommend_bottom_2 != "") {
        vTab_html += "<ul id=\"pftListNav\" class=\"ftList\">";
        vTab_html += "	<li><a href=\"#pfTab1\" class=\"on\">남들은 뭘 샀지?</a></li>";
        vTab_html += "	<li><a href=\"#pfTab2\">함께 살만한 상품</a></li>";
        vTab_html += "</ul>";
    } else if (vRecommend_bottom_1 != "" && vRecommend_bottom_2 == "") {
        //탭하나만 노출
        vTab_html += "<h1 class=\"ftTit\">남들은 뭘 샀지?</h1>";
    } else {
        $("#bottom_recommend").hide();

        return false;
    }

    if (vTab_html != "") {
        $("#bottom_recommend_tab").html(vTab_html);
    }

    /*가격비교 하단 탭 on,off*/
    $("#pftListNav li a").unbind("click");
    $("#pftListNav li a").click(function() {
        $("#pftListNav li a").removeClass("on");
        $(this).addClass("on");
        $(".pftCont").hide();
        var activeTab = $(this).attr("href");
        $(activeTab).fadeIn();

        return false;
    });

}


function loadRecomGoods_bottom(recomType) {
    //메인 하단용 추천상품
    var loadrecom_pageNum = 1;
    var loadrecom_pageGap = 20;
    if (typeof(recomType) == "undefined" || recomType == "")
        recomType = 8;

    var strUrl = "";
    if (recomType == 3) {
        strUrl = "/lsv2016/ajax/detail/getRecommendGoods3_ajax.jsp";
    } else if (recomType == 4) {
        strUrl = "/lsv2016/ajax/detail/getRecommendGoods4_ajax.jsp";
    } else if (recomType == 5) {
        strUrl = "/lsv2016/ajax/detail/getRecommendGoods5_ajax.jsp";
    } else if (recomType == 6) {
        strUrl = "/lsv2016/ajax/detail/getRecommendGoods6_ajax.jsp";
    } else if (recomType == 8) {
        strUrl = "/lsv2016/ajax/detail/getRecommendGoods8_ajax.jsp";
    }

    var param = {
            "nModelNo": vModelno,
            "szCategory": vCa_code,
            "accessoryShowFlag": vAccessoryShowFlag,
            "nModelNoGroup": nModelNoGroup,
            "Refernum": vRefernum,
            "strReferModelno": vReferModelno,
            "szBrand": vBrand,
            "recomType": recomType,
            "pageGap": loadrecom_pageGap,
            "pageNum": loadrecom_pageNum
        }
        // console.log(param);

    $.ajax({
        type: "get",
        url: strUrl,
        async: false,
        data: param,
        dataType: "json",
        success: function(json) {
            if (recomType != 8) {
                var totalcnt = json["totalcnt"];
                recomCate = json["recomCate"];

                if (totalcnt > 2) {
                    var recomgoodsListObj = json["recomgoods_list"];
                    recomgoodsCntAry_bottom[recomType] = totalcnt;
                    recomgoodsListAry_bottom[recomType] = recomgoodsListObj;

                    if (recomType == 3) {
                        vRecommend_bottom_2 = "3";
                        loadRecomGoodsview_bottom(recomType);
                    } else {
                        vRecommend_bottom_1 = recomType;
                    }

                    loadRecomGoodsview_bottom(recomType);
                }
                return true;
            } else {
                if (json.length > 0) {

                    vRecommend_bottom_1 = "8";
                    recomgoodsCntAry_bottom[recomType] = json.length;
                    recomgoodsListAry_bottom[recomType] = json;

                    loadRecomGoodsview_peek_bottom(recomType);
                }

                return true;
            }

        },
        error: function(xhr, ajaxOptions, thrownError) {
            // alert(xhr.status);
            // alert(thrownError);
        }
    });
}

function loadRecomGoodsview_bottom(recomType) {
    var recom_pageNum = 1;
    var recom_pageGap = 20;

    var html = "";

    var recomgoodsListObj = recomgoodsListAry_bottom[recomType];
    var totalcnt = recomgoodsListObj.length;
    var limtcnt = 20;
    if (totalcnt < limtcnt)
        limtcnt = totalcnt;
    var startcnt = (recom_pageNum - 1) * recom_pageGap;

    if (limtcnt < 2) {
        return false;
    }

    var recomTitle = "";
    if (recomType == 4) {
        recomTitle = "동일 브랜드 인기 상품"; // a
    } else if (recomType == 5) {
        recomTitle = "다른 브랜드 인기상품"; // b
    } else if (recomType == 6) {
        recomTitle = "동일 카테고리 인기상품"; // c
    } else if (recomType == 8) {
        recomTitle = "남들 뭐샀지"; // c
    }


    html += "<div class=\"horiScrollWrap\">";
    html += "	<div class=\"scrollList\">";
    html += "		<ul class=\"recommandProdList\" id=\"bottom_recommendList_" + recomType + "\">";

    for (var i = startcnt; i < limtcnt; i++) {
        var o_modelno = recomgoodsListObj[i].modelno;
        var o_modelnm = recomgoodsListObj[i].modelnm;
        var o_ca_code4 = recomgoodsListObj[i].ca_code4;
        var o_strImageUrl = recomgoodsListObj[i].strImageUrl;
        var o_minprice = recomgoodsListObj[i].minprice;
        var o_minprice2 = recomgoodsListObj[i].minprice2;
        var o_minprice3 = recomgoodsListObj[i].minprice3;
        var o_imgchk = recomgoodsListObj[i].imgchk;
        var o_sopnShowFlag = recomgoodsListObj[i].sopnShowFlag;
        var o_bbs_point_avg = recomgoodsListObj[i].bbs_point_avg;
        var o_bbs_num = recomgoodsListObj[i].bbs_num;
        var o_gb1 = recomgoodsListObj[i].gb1;
        var o_gb2 = recomgoodsListObj[i].gb2;
        var o_c_date = recomgoodsListObj[i].c_date;
        // 현금몰 비교 로직 추가(2019.11.08)
        var o_cash_min_prc = recomgoodsListObj[i].cashMinPrc;
        var o_cash_min_prc_yn = recomgoodsListObj[i].cashMinPrcYn;
        // tlc 비교 로직 추가 (2019.12.12)
        var o_tlc_min_prc = recomgoodsListObj[i].tlcMinPrc;

        html += "			<li modelno=\"" + o_modelno + "\" tit=\"" + recomTitle + "\">";
        html += "				<a href=\"javascript:///\">";
        if (vAdultchk) {
            html += "					<img src=\"http://img.enuri.info/images/mobilefirst/prod_img_imsi.gif\" class=\"thumb\" />";
        } else {
            html += "					<img src=\"" + o_strImageUrl + "\" class=\"thumb\"  onerror=\"replaceImg(this);\" />";
        }
        html += "					<span class=\"info\">";
        html += "						<span class=\"txt\">" + o_modelnm + "</span>";
        html += "						<span class=\"price\">";
        if (!isNaN(o_c_date) && (parseInt(o_c_date) >= parseInt(cur_date))) {
            html += "							<em class=\"low\">출시예정</em>";
        } else {
            html += "							<em class=\"low\">최저가</em>";
            if (typeof o_cash_min_prc_yn != undefined && o_cash_min_prc_yn != null && o_cash_min_prc_yn == "Y" && typeof o_cash_min_prc != undefined && o_cash_min_prc == null) {
                html += "							<em>" + commaNum(o_cash_min_prc) + "</em>원";
            } else if (typeof o_tlc_min_prc != undefined && o_tlc_min_prc != null && o_tlc_min_prc != "0" && o_minprice == "0") {
                html += "							<em>" + commaNum(o_tlc_min_prc) + "</em>원";
            } else {
                html += "							<em>" + commaNum(o_minprice) + "</em>원";
            }
        }
        html += "						</span>";
        html += "					</span>";
        html += "				</a>";
        html += "			</li>";
    }
    html += "		</ul>";
    html += "	</div>";
    html += "</div>";

    if (recomType == 5 || recomType == 4 || recomType == 6) {
        $("#pfTab1").html(html);
    } else if (recomType == 3) {
        $("#pfTab2").html(html);
    }

    $("#bottom_recommendList_" + recomType + " li").unbind("click");
    $("#bottom_recommendList_" + recomType + " li").click(function() {
        var vRecommand_title = $(this).attr("tit");
        var vRecommand_Modelno = $(this).attr("modelno");

        if (typeof vRecommand_Modelno != "undefined") {
            location.href = "detail.jsp?modelno=" + vRecommand_Modelno;

            ga_new(18, vRecommand_title + '_' + vRecommand_Modelno);
            //return false;
        }
    });
}

function loadRecomGoodsview_peek_bottom(recomType) {
    var recom_pageNum = 1;
    var recom_pageGap = 20;

    var html = "";
    var htmlHead = "";
    var recomTitle = "";
    recomTitle = "남들은 뭘 샀지";

    //return false; 

    var recomgoodsListObj = recomgoodsListAry_bottom[recomType];
    var totalcnt = recomgoodsListObj.length;

    var vLast_Group = 0;
    if (totalcnt > 0) {

        htmlHead += "<div class=\"pftCont_head\">";
        htmlHead += "<ul class=\"onlyOld_tab\" id=\"bottom_peek_head\">";

        //html += "<ul class=\"ftCont_head\" id=\"bottom_allview\">";
        //html += "	<li><a href=\"javascript:///\" class=\"p_ratio\">상품전체 비교하기</a></li>";
        //html += "</ul>";

        html += "<div class=\"horiScrollWrap\">";
        html += "	<div class=\"scrollList\">";
        html += "		<ul class=\"recommandProdList\" id=\"bottom_recommendList_" + recomType + "\">";

        var vHead = ""; //값이 없으면 넣고 값을 가지고 있다가 값이 바뀌면 htmlHead 줄이 바뀜.
        var vHead_first = ""; //초기 값

        var vThis_code = "";
        var vThis_code_cnt = 0;

        var o_varArr = new Array(); //o_var 배열
        var g_gender = "";

        for (var i = 0; i < totalcnt; i++) {
            var o_modelno = recomgoodsListObj[i].modelno;
            var o_modelnm = recomgoodsListObj[i].modelnm;
            var o_ca_code4 = recomgoodsListObj[i].ca_code4;
            var o_strImageUrl = recomgoodsListObj[i].strImageUrl;
            var o_minprice = recomgoodsListObj[i].minprice;
            var o_minprice2 = recomgoodsListObj[i].minprice2;
            var o_minprice3 = recomgoodsListObj[i].minprice3;
            var o_imgchk = recomgoodsListObj[i].imgchk;
            var o_sopnShowFlag = recomgoodsListObj[i].sopnShowFlag;
            var o_bbs_point_avg = recomgoodsListObj[i].bbs_point_avg;
            var o_bbs_num = recomgoodsListObj[i].bbs_num;
            var o_gb1 = recomgoodsListObj[i].gb1;
            var o_gb2 = recomgoodsListObj[i].gb2;
            var o_c_date = recomgoodsListObj[i].c_date;
            //성/연령별로 추가됨
            var o_var_code = recomgoodsListObj[i].var_code;
            var o_var = recomgoodsListObj[i].var;
            var o_lcate = recomgoodsListObj[i].lcate;
            var o_mcate = recomgoodsListObj[i].mcate;
            var o_scate = recomgoodsListObj[i].scate;
            var o_dcate = recomgoodsListObj[i].dcate;
            var o_model_no = recomgoodsListObj[i].model_no;
            var o_gender = recomgoodsListObj[i].gender;
            g_gender = o_gender;

            var o_c_date = recomgoodsListObj[i].c_date;
            // 현금몰 비교 로직 추가(2019.11.08)
            var o_cash_min_prc = recomgoodsListObj[i].cashMinPrc;
            var o_cash_min_prc_yn = recomgoodsListObj[i].cashMinPrcYn;
            // tlc 비교 로직 추가 (2019.12.12)
            var o_tlc_min_prc = recomgoodsListObj[i].tlcMinPrc;

            //20개 미만 안 보임
            //현재코드 입력 받고 20개 카운팅 20개 넘어가면 다음.
            if (vThis_code == "" || vThis_code != o_var_code) {
                vThis_code = o_var_code;
                vThis_code_cnt = 0;
            }
            ++vThis_code_cnt;
            //console.log(vThis_code_cnt);
            if (vThis_code_cnt <= 20) {
                if ($.inArray(o_var.split(" ")[0], o_varArr) === -1) {
                    htmlHead += "<li><a href=\"javascript:///\" id=\"bottom_peekhead_" + o_var_code + "\" ";
                    //if(i == 0){
                    //	htmlHead += " class=\"on\" ";
                    //}
                    htmlHead += " code=\"" + o_var_code + "\">" + o_var.split(" ")[0] + "</a></li>";
                    //vHead = o_var;	//vHead로 치환	
                    o_varArr.push(o_var.split(" ")[0]);
                }
                if (i == 0) {
                    vHead_first = o_var_code;
                }

                html += "<li modelno=\"" + o_modelno + "\" id=\"" + o_var + "\" class=\"peek_bottom_goods peek_bottom_" + o_var_code + "\" ";
                //if(vHead_first != o_var_code){
                html += " style=\"display:none\" ";
                //}
                html += " tit=\"" + recomTitle + "\" code=\"" + o_var_code + "\">";
                html += "	<a href=\"javascript:///\">";
                html += "		<img src=\"" + o_strImageUrl + "\" alt=\"\" class=\"thumb\"  onerror=\"replaceImg(this);\" />";
                html += "		<span class=\"info\">";
                html += "			<span class=\"txt\">" + o_modelnm + "</span>";
                html += "			<span class=\"price\">";
                html += "				<em class=\"low\">최저가</em>";
                if (typeof o_cash_min_prc_yn != undefined && o_cash_min_prc_yn != null && o_cash_min_prc_yn == "Y" && typeof o_cash_min_prc != undefined && o_cash_min_prc != null) {
                    html += "				<em>" + commaNum(o_cash_min_prc) + "</em>원";
                } else if (typeof o_tlc_min_prc != undefined && o_tlc_min_prc != null && o_tlc_min_prc != "0" && o_minprice3 == "0") {
                    html += "				<em>" + commaNum(o_tlc_min_prc) + "</em>원";
                } else {
                    html += "				<em>" + commaNum(o_minprice3) + "</em>원";
                }
                html += "			</span>";
                html += "		</span>";
                html += "	</a>";
                html += "</li>";
            }
            vLast_Group = o_var_code;
        }

        htmlHead += "</ul>";

        htmlHead += "<div class=\"ftProdTit\">";
        htmlHead += "<p class=\"tag_tit\"><span class=\"tag\" id=\"tag_tit_span\"></span>가 많이 구매한 상품</p>";
        htmlHead += "<ul class=\"gender\" id=\"gender\" style=\"display:none;\">";
        htmlHead += "<li class=\"on\" onclick=\"\"><span class=\"ico female\"></span>여성</li>";
        htmlHead += "<li onclick=\"\"><span class=\"ico male\"></span>남성</li>";
        htmlHead += "</ul>";
        htmlHead += "</div>";
        htmlHead += "</div>";

        html += "</ul>";
        $("#pfTab1").html(htmlHead + html);

        if (g_gender != "") $("#gender").show();

        $("#bottom_allview").unbind("click");
        $("#bottom_allview").click(function() {
            vTab4.click();
        });

        $("#bottom_peek_head li a").unbind("click");
        $("#bottom_peek_head li a").click(function() {
            $("#bottom_peek_head li a").removeClass("on");
            $(this).addClass("on");

            var var_nm = $(this).html();
            $("#tag_tit_span").html("# " + var_nm);
            var vCode = $(this).attr("code");
            var this_index = $("#gender").find(".on").index() == 1 ? 5 : 0;
            vCode = Number(this_index) + Number(vCode);
            /*$("#gender li").removeClass("on");
            $("#gender li").first().addClass("on");*/

            $(".peek_bottom_goods").hide();
            $(".peek_bottom_" + vCode).show();
        });

        $("#gender li").unbind("click");
        $("#gender li").click(function() {
            $("#gender li").removeClass("on");
            $(this).addClass("on");
            var this_index = $(this).index() == 1 ? 5 : 0;
            var vCode = "";
            $('#bottom_peek_head li a').each(function() {
                if ($(this).hasClass("on")) {
                    vCode = Number(this_index) + Number($(this).attr("code"));
                }
            });

            $(".peek_bottom_goods").hide();
            $(".peek_bottom_" + vCode).show();

        });

        $("#bottom_recommendList_" + recomType + " li").unbind("click");
        $("#bottom_recommendList_" + recomType + " li").click(function() {
            var vRecommand_Modelno = $(this).attr("modelno");
            var vRecommand_var = $(this).attr("id");
            var vRecommand_title = $(this).attr("tit");

            if (typeof vRecommand_Modelno != "undefined") {
                location.href = "detail.jsp?modelno=" + vRecommand_Modelno;

                ga_new(18, vRecommand_title + '_' + vRecommand_var);
                return false;
            }
        });

        //제일 많은 그룹 검색 후 선택
        //마지막 그룹번호 vLast_Group
        var vMany_code = 0; //젤 많은 그룹
        var vMany_group_length = 0; //젤 많았던 그룹의 갯수

        //console.log("===vLast_Group="+vLast_Group);

        for (var i = 0; i < vLast_Group; i++) {
            var vThis_group_length = $(".peek_bottom_" + i).length;
            if (vMany_group_length < vThis_group_length) {
                vMany_code = $(".peek_bottom_" + i).attr("code");
                vMany_group_length = vThis_group_length;
                //console.log("i="+i);
                //console.log("===vMany_code="+vMany_code);
                //console.log("vMany_group_length="+vMany_group_length);
                //console.log("vThis_group_length="+vThis_group_length);
            }
        }
        if (vMany_code > 5) {
            vMany_code -= 5;
            $("#bottom_peekhead_" + vMany_code).trigger("click");
            $("#gender li").get(1).click();
        } else {
            $("#bottom_peekhead_" + vMany_code).trigger("click");
            $("#gender li").get(0).click();
        }

    }
}

function getCMVideo() {
    /**
     * VIP VIDEO 노출
     */
    var param = {
        "modelno": vModelno
    };

    $.ajax({
        type: "get",
        url: "/lsv2016/ajax/detail/getVideoData_ajax.jsp",
        data: param,
        dataType: "json",
        success: function(json) {

            if (json.videoCnt != 0) {

                if (json.videoList.length > 0) {
                    loadCMVideo(json);
                }

            }

        },
        error: function(xhr, ajaxOptions, thrownError) {
            //alert(xhr.status);
            //alert(thrownError);
        }
    });
}

function loadCMVideo(json) {
    var videoObjList = json["videoList"];
    var html = "";
    if (videoObjList.length > 0) {
        $.each(videoObjList, function(index, listData) {
            if (index > 0) return false;
            var ktw_no = listData["ktw_no"];
            var model_no = listData["model_no"];
            var ofr_bze_nm = listData["ofr_bze_nm"];
            var video_cls_cd = listData["video_cls_cd"];
            var video_itm_cd = listData["video_itm_cd"];
            var video_tl = listData["video_tl"];
            var video_url = listData["video_url"];
            var view_ord = listData["view_ord"];
            var video_code = "";
            if (video_url.lastIndexOf("?") > -1) {
                video_code = video_url.substring(video_url.lastIndexOf("/") + 1, video_url.lastIndexOf("?"));
                video_url = video_url.replace("?", "?enablejsapi=1&playerapiid=ytplayer");
            } else {
                video_code = video_url.substring(video_url.lastIndexOf("/") + 1, video_url.length);
                video_url += "?enablejsapi=1&playerapiid=ytplayer";
            }

            html += "<div class=\"media_head\">";
            html += "		<h1 class=\"tit\">영상 설명</h1>";
            html += "</div>";
            html += "<div class=\"media_cnt\">";
            html += "	<span class=\"txt_tit\">" + video_tl + "</span>";
            html += "	<!-- data-youtube-code 속성에 영상id 넣어주세요 -->";
            html += "    <div class=\"area_media\" >";
            html += "        <!-- 버튼 : 커버 이미지 -->";
            html += "        <span class=\"btn_cover\" style=\"background-image: url('https://img.youtube.com/vi/" + video_code + "/0.jpg'); \" ></span>";
            html += "        <!-- 영상 영역 -->";
            html += "        <div id=\"\" class=\"media_inner\">";
            if (video_url.length > 0) {
                html += "    <iframe id=\"mediaPlayer\" src =\" " + video_url + " \"></iframe>";
            }
            html += "		   </div>";
            html += "    </div>";
            html += "    <span class=\"txt_author\">제공 : " + ofr_bze_nm + "</span>";
            html += "</div>";
        });

        if (html.length > 0) {
            $("#info_media").html(html);
            $("#info_media").show();

            $("#info_media .btn_cover").click(function() {
                if (confirm('3G/5G/LTE 환경에서는 데이터 사용료가 발생할 수 있습니다.')) {
                    ga_new(25, '');
                    $(this).hide();
                }
            });
            $(".navTabs .tabs li").click(function() {
                $("#mediaPlayer")[0].contentWindow.postMessage('{"event":"command","func" : "stopVideo"}', '*');
            });
        }
    }
}

function getCashList() {
    var listType = (toggleState == 0) ? "1" : "2";
    var param = {
        "modelno": vModelno,
        "listType": listType
    };

    $.ajax({
        type: "get",
        url: "/lsv2016/ajax/detail/getCashGoodsList_ajax.jsp",
        data: param,
        async: false,
        dataType: "json",
        success: function(json) {

            if (json.cash_pricelist_cnt != 0) {

                if (json.cash_pricelist.length > 0) {
                    loadCashList(json);
                }
            }
        },
        error: function(xhr, ajaxOptions, thrownError) {
            // alert(xhr.status);
            // alert(thrownError);
        }
    });
}
var vCashDelivery = "";

function loadCashList(json) {
    var cashListCnt = json["cash_pricelist_cnt"];
    var cashList = json["cash_pricelist"];
    /*var cashShopName = "";
    var cashPrice = "";
    var cashGoodsName = "";
    var cashDeliveryPrice = "";
    var cashUrl = "";
    var cashShopCode = "";
    var cashPlno = "";
    var cashGoodsCode = "";
    var cashInstancePrice ="";
    var cashCa_code = "";
    var cashDeliveryInfo2 ="";*/
    var aOnclick = "";
    var html = "";
    var displayCss = "";
    if (cashListCnt > 0 && cashList != null && cashList.length > 0) {

        html += "<div class=\"cashPrdList\">";
        html += "	<p class=\"cashPrdTit\">";
        html += "		일반전문몰 <i class=\"ico_i\" onclick=\"$(this).next('.layer_cashmall').fadeIn(100);\">i</i>";
        html += "		<span class=\"layer_cashmall\">무통장 입금을 이용한 현금 결제 쇼핑몰입니다.<br>구매하기 전 재고 및 가격 확인을 꼭 해주세요<i class=\"cls_x\" onclick=\"$(this).parent().fadeOut(100);\">X</i></span>";
        html += "	</p>";
        html += "	<ul class=\"productList\">";
        $.each(cashList, function(index, listData) {
            var cashShopName = listData["shop_name"];
            var cashPrice = listData["price"];
            var cashGoodsName = listData["goodsnm"];
            var cashDeliveryPrice = listData["m_displaydelivery"];
            var cashUrl = listData["url"];
            var cashShopCode = listData["shop_code"];
            var cashPlno = listData["pl_no"];
            var cashGoodsCode = listData["cashGoodsCode"];
            var cashInstancePrice = listData["instance_price"];
            var cashCa_code = listData["ca_code"];
            var cashDeliveryInfo2 = listData["deliveryinfo2"];
            var cashPrice = (toggleState == 0) ? commaNum(cashPrice) : commaNum(cashPrice + cashDeliveryInfo2);
            var blCashShow = ($("#vip_cash_div_tag").css("display") == "none") ? false : true;
            displayCss = (index < 4) ? " style=\"display:block\"" : " style=\"display:none\"";
            if (index == 0 && !blCashShow) {
                vCashDelivery = cashDeliveryPrice;
                $("#vip_cash_price").html(cashPrice + "원");
                $("#vip_cash_shop_name").html(cashShopName);
                $("#vip_cash_div_tag").show();
                $("#vip_cash_div_tag").unbind("click");
                $("#vip_cash_div_tag").click(function() {
                    goShop(cashUrl, cashShopCode, cashPlno, cashGoodsCode, cashInstancePrice, cashCa_code, cashPrice, vMinprice, this, vModelno);
                });
            }
            aOnclick += "goShop('" + cashUrl + "','" + cashShopCode + "','" + cashPlno + "','" + cashGoodsCode + "','" + cashInstancePrice + "','" + cashCa_code + "','" + cashPrice + "','" + vMinprice + "',this," + vModelno + "); ";
            html += "		<li " + displayCss + ">";
            html += "			<a href=\"javscript:void(0);\" onclick=\"" + aOnclick + "\" >";
            html += "				<span class=\"comp\">" + cashShopName + "</span>";
            html += "				<span class=\"price\"><em class=\"ico--cash\">현금</em>";
            html += "					<em>" + cashPrice + "원</em>";
            html += "				</span>";
            html += "				<span class=\"info\">" + cashGoodsName + "</span>";
            html += "				<span class=\"pro_spec\"></span>";
            html += "				<span class=\"delivery_info\">";
            html += "					<i class=\"i_delivery\">" + cashDeliveryPrice + "</i>";
            html += "				</span>";
            html += "			</a>";
            html += "		</li>";
        });

        html += "		</ul>";
        html += "</div>";
        $("#cash_list").html(html);
        $("#cash_list").show();

        $("#cash_list_more1").html(cashListCnt - $("#cash_list").find(".productList li[style*='none']").length);
        $("#cash_list_more2").html(cashListCnt);
        if (cashListCnt > 4) $("#cash_list_more").show();
        $("#cash_list_more").click(function() {
            $("#cash_list").find(".productList li").show();
            $("#cash_list_more1").html(cashListCnt - $("#cash_list").find(".productList li[style*='none']").length);
            $("#cash_list_more").hide();
        });

    }

}

function click_callAlarm() {
    // app일때는 따로 스킴 콜하고 가격알림은 완료로 처리
    try {
        if (vAppyn == "Y") {
            $('html, body').removeClass('dimdOn');
            $("#layer_alarm").hide();

            // - Android
            // public void callAppMinPricePopup(String modelno , String price,
            // String setMinPrice)

            // - iOS
            // enuriappcall://callAppMinPricePopup?modelno=38384&price&39392&setMinPrice=94903938

            // [param 설명]
            // modelno : vip 모델번호
            // price : vip 가격 <span id="detail_minprice">781,200</span>
            // setMinPrice : 사용자가 세팅한 가격

            // alert(vModelno);
            // alert(vMinprice);
            // alert($('#setprice').val());

            if (window.android) { // 안드로이드
                window.android.callAppMinPricePopup(vModelno + "", vMinprice, $('#setprice').val());
            } else { // 아이폰에서 호출
                if (vVerios >= 33300) {
                    window.location.href = "enuriappcall://callAppMinPricePopup?modelno=" + vModelno +
                        "&price=" + vMinprice +
                        "&setMinPrice=" + $('#setprice').val();
                } else {
                    $('#layer_alarm').show();
                }
            }
            return false;
        } else {
            $('#layer_alarm').show();
        }
    } catch (e) {
        $('#layer_alarm').show();
    }
}

function getAlarm() {
    $.ajax({
        type: "GET",
        url: "/mobilefirst/api/requestMinpriceItem.jsp",
        async: false,
        data: "modelnos=" + vModelno + "&appId=1001&sh=Y",
        dataType: "JSON",
        success: function(json) {

            if (json.modelno > 0) {
                $("#btn_alram").addClass("on");
            } else {
                $("#btn_alram").removeClass("on");
            }
        }
    });
}