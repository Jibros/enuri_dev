var mini_deliveryFlag = false; //배송비포함
var mini_cardeventFlag = false; //카드특가
var mini_cardorderFlag = false; //카드 할인가순
var mini_deliveryfreeFlag = false; //무료배송
var mini_authFlag = false; //제조사공식인증
var mini_departFlag = false; //백화점몰
var mini_cardfreeFlag = false; //무이자
var mini_etcmallFlag = false; //홈쇼핑/전문몰

var mini_shopListAll = "NO"; //더보기
var mini_SelectedShop = "";
var mini_modelno = "";
var mini_Constrain = "";
var mini_Rental = "";
var min_szBidchk = "";
var mini_dDate = "";
var mini_cur_date = "";
var mini_nMallCnt = "";
var mini_nMallCnt3 = "";
var mini_szCategory = "";
var mini_szModelNm = "";
var mini_szCategory2 = "";
var mini_szCategory4 = "";
var mini_szCategory6 = "";
var mini_strCondiname = "";
var mini_factory = "";
var mini_brand = "";
var mini_spec = "";
var mini_strImageUrl = "";
var eventModelCouponCheck = false;
var vNowtime = "";

var minCheck = 202106100200;
var maxCheck = 202106100400;
$(document).ready(function() {
    //닫기
    $('#miniVIP_AREA').find('.btn closex').click(function() {
        $('#miniVIP_AREA').hide();
    });
    vNowtime =  new Date().format("yyyyMMddhhmm");
    vNowtime = vNowtime * 1;
    //탭선택
    var mini_maObj = $('#mini_mallprlist_area');
    mini_maObj.find(".cont_area").hide();
    mini_maObj.find(".tab li:first").addClass("on").show();
    mini_maObj.find(".cont_area:first").show();

    mini_maObj.find(".tab li").click(function() {
        mini_maObj.find(".tab li").removeClass("on");
        $(this).addClass("on");
        mini_maObj.find(".cont_area").hide();
        var activeTab = $(this).find("a").attr("href");
        if (activeTab == "#tab01") insertLog(15386);
        else if (activeTab == "#tab02") insertLog(15387);
        else if (activeTab == "#tab03") insertLog(15388);
        $(activeTab).show();
        $(activeTab).find(".scroll_area").scrollTop(0);
        return false;
    });

    if (mvShowModelno.length > 0) {
        loadMiniVip(mvShowModelno);
    }

    //상단요약
    //loadMiniVip(mini_modelno);

    //정렬
    $('.option_sel li').unbind();
    $('.option_sel li').click(function() {
        if ($('.option_sel li').hasClass("on")) {
            var objid = $(this).attr('id');
            if (objid == 'objid') insertLog(15059);
            else if (objid == 'o_delivery') insertLog(15060);
            else if (objid == 'o_card') insertLog(15061);
            option_sel(objid);
        }
    });

    //더보기
    $("#list_more").unbind();
    $("#list_more").click(function() {
        //mini_shopListAll = "YES";
        //loadPriceList(mini_modelno);
        //$("#list_more").hide();
        if ($('#mimi_bisic_compare').attr('class').indexOf("on") > -1) insertLog(15407);
        if (mini_modelno != "") goMore_Modelno(mini_modelno, "3");
    });

    //미니미니vip 정렬
    $("#tab01 .pro.sub_dp li").parent().parent().prev("a").text("판매가순");
    $("#tab01 div.select > a").click(function() {
        insertLog(15404);
        $("div.select .sub_dp").hide();

        if ($(this).next("div").is(":hidden")) {
            $(this).next("div").show();
        }
    });

    $("#tab01 .pro.sub_dp li").click(function() {
        $(this).parent().parent().prev("a").text($(this).text());
        $("div.select .sub_dp").hide();
        var order_list = $(this).attr('id');

        if (order_list == 'o_basic') insertLog(15059);
        else if (order_list == 'o_delivery') insertLog(15060);
        else if (order_list == 'o_card') insertLog(15061);
        option_sel(order_list);
    });

    //mimiCheck();
});

$(document).mouseup(function(e) {
    // 팝업 아이디
    var container = $("#tab01 .pro.sub_dp");
    container.css("display", "none");
    if (!container.is(e.target) && container.has(e.target).length == 0) {
    }
});

$(window).resize(function() {
    mini_resize();
    //mimiCheck();
    //mimiResizeWidth();
});

var miniVIP = $("#miniVIP_AREA");
var miniTOP = $(".btn_packtop");
var winWid = $(window).width() - 20; // 전체 너비 - 여백
var gapWid = 10;

function mimiResizeWidth() {
    winWid = $(window).width() - 20;
    gapWid = 10;
    var vipWidth = ((winWid - $(".listview_area").width()) / 2) - gapWid;
    if (vipWidth < 128) vipWidth = 128;
    if (128 <= vipWidth && vipWidth <= 210) {
        $(miniVIP).css({ "width": vipWidth, "margin-right": "-" + (vipWidth + gapWid + $(".listview_area").width() / 2) + "px" });
        var topMarginRight = (($(".listview_area").width()) / 2) + gapWid + (vipWidth - 20);
        $(miniTOP).css({ "margin-right": "-" + topMarginRight + "px" });
        $(".scroll_area").css({ "width": vipWidth + 17 });
    }
    if (vipWidth > 210) $(".scroll_area").css({ "width": $(miniVIP).width() + 17 });
}

//미니인지 미니미니 인지 구별
function mimiCheck() {
/*
    var bWidth = window.innerWidth;
    if (bWidth > 1600) {
        $('#bisic_compare').addClass('on');
        $('#mimi_bisic_compare').removeClass('on');
        $('#mini_tabarea').show();
    } else {
        $('#bisic_compare').removeClass('on');
        $('#mimi_bisic_compare').addClass('on');
        mimiResizeWidth();
        $('#mini_tabarea').hide();
    }
    mimiShow();

    if ($('#mimi_bisic_compare').attr('class').indexOf("on") > -1) {
        miniTabReset();
    }
 */
}

function mimiShow() {
    if (!((mini_Rental == "rental" || mini_strCondiname.indexOf("렌탈(월)") > -1) || (!isNaN(mini_dDate) && (parseInt(mini_dDate) > parseInt(mini_cur_date))) || (parseInt(mini_nMallCnt) <= 0 && parseInt(mini_nMallCnt3) <= 0))) {
        if ($('#mimi_bisic_compare').attr('class').indexOf("on") > -1) {
            $('#bisic_compare').hide();
            $('#mimi_bisic_compare').show();
            $('#option_sel').hide();
            $('#option_sel').hide();
            $('#mimi_option_sel').show();
            $('.topprobox .ad_banner').hide();
            if (parseInt(mini_Constrain) == 5) {
                $('#similar_compare').hide();
                $('#simcompair').hide();
            }
            if (starGraphon == 'true') $('#starGraph').show();

        } else {
            $('#mimi_bisic_compare').hide();
            $('#option_sel').show();
            $('#mimi_option_sel').hide();
            $('.topprobox .ad_banner').show();
            if (parseInt(mini_Constrain) == 5) {
                $('#similar_compare').show();
                $('#simcompair').show();
            } else $('#bisic_compare').show();
            $('#starGraph').hide();

        }
    } else {
        if ($('#mimi_bisic_compare').attr('class').indexOf("on") > -1) {
            if (starGraphon == 'true') $('#starGraph').show();
            $('.topprobox .ad_banner').hide();
        } else {
            $('.topprobox .ad_banner').show();
            $('#starGraph').hide();
        }
    }
}
$(document).scroll(function() {
/*
    var $MiniVIP = $("#miniVIP_AREA"); // MiniVip 레이어
    var _contPosH = $("#LP_AREA").offset().top - 13; // LP 컨텐츠 시작위치
    if ($(document).scrollTop() > _contPosH ) {
        $MiniVIP.css({
            "top":0,
            "position" : "fixed"            
        });
    } else { // 네비 하단으로 고정
        $MiniVIP.css({
            "top": _contPosH,
            "position" : "absolute"            
        });
    }
*/
});

//Top
function goTop(Ttype) {
    $('#tab0' + Ttype).find(".scroll_area").scrollTop(0);
    insertLog(15065);
}

//화면 재설정
function mini_resize() {
    var gapheight = 65;
    var bBasic = "Y";
    var titleheight = $('#lefttitle').height();
    if (mini_Rental == "rental" || mini_strCondiname.indexOf("렌탈(월)") > -1) {
        gapheight = titleheight; //렌탈
        bBasic = "N";
    }
    if (!isNaN(mini_dDate) && (parseInt(mini_dDate) > parseInt(mini_cur_date))) {
        gapheight = titleheight; //출시예정
        bBasic = "N";
    }
    if (parseInt(mini_nMallCnt) <= 0 && parseInt(mini_nMallCnt3) <= 0) {
        gapheight = titleheight; //일시품절
        bBasic = "N";
    }
    if (mini_bannerinfo) gapheight += 22;
    else gapheight += 22;

    var scroll_height = $(window).height() - $('.topprobox').height() - $('.tabarea').height() - $('.option_sel').height() - gapheight;
    if ($('#mimi_bisic_compare').attr('class').indexOf("on") > -1) {
        gapheight = 60;
        if (bBasic == 'N') gapheight = 30;
        scroll_height = $(window).height() - $('.topprobox').height() - $('.pro.select').height() - gapheight;
    }

    $('.scroll_area').each(function(Index) {
        var $this = $(this);
        var se_scroll_height = scroll_height + $('.option_sel').height() + 17;
        if (parseInt(Index) > 0 && bBasic == "Y") $this.css("height", se_scroll_height);
        else $this.css("height", scroll_height);
    });

}


function option_sel(obj) {
    $('.option_sel li').removeClass('on');
    if (obj == "o_basic" || obj == "o_delivery" || obj == "o_card") $('#' + obj).addClass('on');
    else $('#o_basic').addClass('on');
    mini_deliveryFlag = false;
    mini_cardeventFlag = false;
    mini_deliveryfreeFlag = false; //무료배송
    mini_authFlag = false; //제조사공식인증
    mini_departFlag = false; //백화점몰
    mini_cardfreeFlag = false; //무이자
    mini_etcmallFlag = false; //홈쇼핑/전문몰

    if (obj == 'o_delivery') {
        mini_deliveryFlag = true;
    } else if (obj == 'o_card') {
        mini_cardeventFlag = true;
    } else if (obj == 'o_deliveryfree') {
        mini_deliveryfreeFlag = true;
    } else if (obj == 'o_auth') {
        mini_authFlag = true;
    } else if (obj == 'o_cardfree') {
        mini_cardfreeFlag = true;
    }/* else if (obj == 'o_depart') {
        mini_departFlag = true;
    }  else if (obj == 'o_etcmall') {
        mini_etcmallFlag = true;
    } */
    loadPriceList(mini_modelno);
    //loadMimiPriceList(mini_modelno);
}

function numComma(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function nuNumComma(x) {
    return x.toString().replace(/,/g, '');
}
var starGraphon = "false";

function loadMiniVip(modelno) {
	// 일반 리스트형 > 가격 옵션 클릭 시, miniVip 노출 
	//var $optPrice = $(".price__option .opt--price");
	
	//$optPrice.on("click", function(){
		$(".lay-minvip").show(0, function(){
			var $body = $(".list-body");
			var $minVip = $('.lay-minvip'); // MiniVip Wrapper
			var $minVipHead = $(".topprobox"); // MiniVIP 상단
			var $minVipTab = $(".mallprlist_area .tabarea"); //MiniVIP 탭
			var $minVipContent = $(".cont_area"); // MiniVIP 컨텐츠 영역
			var $vipCommBody  = $(".lay-minvip .lay-comm-body"); // MiniVIP 레이어 바디
			var resizeMinVip = function(){
				var scroll = $(window).scrollTop(),
					bodyT,
					bodyH,
					winH = $(window).height(), // 스크린 Y 크기
					distT = 70; // 상단과 FIXED 될 거리

				if ( $minVip.is(":visible") ){
					var boxH = $minVip.outerHeight();
					var headH = $minVipHead.outerHeight();
					var tabH = $minVipTab.outerHeight();
					$minVipContent.height( boxH - headH - tabH - 38 );
					$vipCommBody.height( boxH - 38 );
					if( $body.length ){
						bodyT = $body.offset().top; // 컨테이너 Position Top
						bodyH = $body.outerHeight(); // 컨테이너 높이
						if ( scroll > bodyT - distT ){
							if ( scroll > bodyT + bodyH - boxH - distT){
								$minVip.css("right","-100%");
							}else{
								$minVip.removeAttr("style").addClass("is--fixTop").height( winH - distT - 20);
							}
						}else{
							$minVip.removeClass("is--fixTop");
						}
					}
				}
			}
			// 실행
			resizeMinVip();

			$(window).on({
				"load" : resizeMinVip,
				"scroll" : resizeMinVip,
				"resize" : resizeMinVip
			});
			$minVipContent.on({
            	"scroll" : resizeMinVip
			});
		});
	//});

    // 카드할인가순 정렬 디폴트 노출
    // 카드 특가 사용여부를 확인하기 위해 어쩔수 없이 카드 특가 ajax 새로 만들어서 검사 해야 함. 
    // 기존 로직 - goods 데이터를 먼저 가져오기 때문에 pricelist에서 카드 정보 추출 여러움. 

    // SR-25975 이슈로 인해 미배포 함.
    /*
    var miniIsCardParam = {
    	"modelno" : modelno
    }
    $.ajax({
    	type : "get",
    	url : "/lsv2016/ajax/detail/getIsCardUsedSale_ajax.jsp",
    	async: false,
    	data : miniIsCardParam,
    	dataType : "json",
    	success: function(json) {
    		mini_cardorderFlag = false;
    		if (json) {
    			var isCardUsedJson = json["is_card_used"];
    			var modelNoJson = json["modelno"];
    			
    			if (modelNoJson == modelno && isCardUsedJson == "Y" ) {
    				mini_cardorderFlag = true;
    			}
    		}
    	},
    	error: function (xhr, ajaxOptions, thrownError) {
    		//alert(xhr.status);
    		//alert(thrownError);
    	}
    });
    */
    //정렬초기화
    mini_modelno = modelno;
    mini_deliveryFlag = false;
    mini_cardeventFlag = false;
    if ($("input:checkbox[id='chLPcondition2']").is(":checked") == true) {
        mini_deliveryFlag = true;
        option_sel('o_delivery');
    } else {
        option_sel('o_basic');
    }

    /* //카드할인가순 정렬 SR-25975 이슈로 인해 미배포 함.
    if(mini_cardorderFlag){
    	mini_cardeventFlag = true;
    	option_sel('o_card');
    }else{
    	option_sel('o_basic');
    }
    */

    var infopro_areaDiv = $('#mini_goodsInfo');

    var param = {
        "random_seq": random_seq,
        "modelno": modelno
    }

    $.ajax({
        type: "get",
        url: "/lsv2016/ajax/detail/getGoodsData_ajax.jsp",
        async: false,
        data: param,
        dataType: "json",
        success: function(json) {
            var mini_cashMinPrice = json["mini_mCashMinPrice"];
            var mini_cashMinYn = json["mini_mCashMinYn"];
            var mini_ovsMinYn = json["mini_mOvsMinYn"];
            //mini_sUserId = json["sUserId"];
            var mini_isSponsor = json["mini_isSponsor"];
            mini_szModelNm = json["mini_szModelNm"];
            var mini_strCondiname = json["mini_strCondiname"];
            mini_strImageUrl = json["mini_strImageUrl"];
            var mini_intRealMinPrice = parseInt(json["mini_intRealMinPrice"]);
            var mini_mMinPrice3 = parseInt(json["mini_mMinPrice3"]);
            min_szBidchk = json["mini_szBidchk"];
            mini_Constrain = json["mini_strConstrain"];
            mini_Rental = json["mini_strSrv"];
            mini_szCategory4 = json["mini_szCategory4"];
            mini_szCategory6 = json["mini_szCategory6"];
            mini_szCategory = json["mini_szCategory"];
            mini_bZzim = json["mini_bZzim"];
            var mini_mTlcMinPrice = json["mini_mTlcMinPrice"];
            //VIP > 디폴트 정렬 변경: 9개 카테고리 (배송비포함)
            /*if(mini_szCategory4=="0502" || mini_szCategory4=="0503" || mini_szCategory4=="0601" 
            	|| mini_szCategory4=="0602" || mini_szCategory4=="0605" || mini_szCategory4=="0609"
            	|| mini_szCategory4=="2401" || mini_szCategory4=="2405" || mini_szCategory4=="2406"){
            	mini_deliveryFlag = true;
            	option_sel('o_delivery');
            }*/

            /********************************************************************
               mini_cardorderFlag : ajax를 통해 받아온 카드 정보가 true
               해당 카테고리만 카드 정보로 보여 줌.
               미니 미니 vip 일 경우 카드 플래그 미 변경			   
            ********************************************************************/
            /*
            //카드할인가순 정렬 SR-25975 이슈로 인해 미배포 함.
            if(mini_cardorderFlag && (mini_szCategory4=="1201" || mini_szCategory4=="1202" || mini_szCategory4=="1204" || mini_szCategory4=="1205")
            		&& $('#mimi_bisic_compare').attr('class').indexOf("on") < 0) {
            	mini_cardeventFlag = true;
            	option_sel('o_card');
            } else {
            	mini_cardeventFlag = false;
            }
            */
            if (mini_Rental == "rental" || mini_strCondiname.indexOf("렌탈(월)") > -1) {
                $("#tabarea_tab01").html("렌탈신청");
            } else {
                $("#tabarea_tab01").html("가격비교<em id=\"tab01_cnt\"></em>");
            }

            mini_nMallCnt3 = json["mini_nMallCnt3"];
            mini_dDate = json["mini_dDate"];
            mini_cur_date = json["mini_cur_date"];

            mini_nMallCnt = json["mini_nMallCnt"];
            if (!isNaN(mini_dDate) && (parseInt(mini_dDate) > parseInt(mini_cur_date))) mini_nMallCnt = 0;
            $("#tab01_cnt").html("(" + numComma(mini_nMallCnt) + ")");
            mini_strCondiname = json["mini_strCondiname"];

            mini_bbs_point_avg = json["mini_bbs_point_avg"];
            mini_bbs_point_num = json["mini_bbs_point_num"];

            mini_factory = json["mini_szFactory"];
            mini_brand = json["mini_szBrand"];
            mini_spec = json["mini_szSpec"];

            if (mini_bbs_point_avg > 0 || mini_bbs_point_num > 0) {
                starGraphon = "true";
                if (mini_bbs_point_avg > 0) $('#starGraph').find('span').css("width", mini_bbs_point_avg * 20 + "%");
                else $('#starGraph').find('.point').hide();
                if (mini_bbs_point_num > 0) $('#starGraph').find('em').html("(" + numComma(mini_bbs_point_num) + ")");
                else $('#starGraph').find('#starGraphEm').hide();
            } else {
                starGraphon = "false";
                $('#starGraph').hide();
            }

            infopro_areaDiv.find('#thumb_img').attr("src", mini_strImageUrl);
			infopro_areaDiv.find('#thumb_img').attr("alt", mini_szModelNm);
            infopro_areaDiv.find('.proname').html(mini_szModelNm);
            infopro_areaDiv.find('.subcon').html(mini_strCondiname);
            var priceHtml = "";
            if (!isNaN(mini_dDate) && (parseInt(mini_dDate) > parseInt(mini_cur_date))) {
                priceHtml += "<span class=\"low\">가격미정</span>";
                infopro_areaDiv.find('.lowprice').html(priceHtml);
            } else if (parseInt(mini_nMallCnt) <= 0 && parseInt(mini_nMallCnt3) <= 0) {
                priceHtml += "일시품절";
                infopro_areaDiv.find('.lowprice').html(priceHtml);
            } else {
                if (mini_intRealMinPrice > mini_mMinPrice3) priceHtml += "<span class=\"mobileSendLayer icon mobile\" type=\"1\"><em>모바일</em></span>";
                if (mini_Rental == "rental") priceHtml += "<a href=\"javascript:///\"><span class=\"low\">렌탈(월)</span><span class=\"pr\"><strong>" + numComma(mini_mMinPrice3) + "</strong>원</span></a>";
                else if (parseInt(mini_mTlcMinPrice) > 0) priceHtml += "<a href=\"javscript:void(0);\"><span class=\"low low_tlc\">TLC카드가</span><strong>" + numComma(mini_mTlcMinPrice) + "</strong>원</a>";
                else priceHtml += "<a href=\"javascript:///\"><span class=\"low\">최저가</span><span class=\"pr\"><strong>" + numComma(mini_mMinPrice3) + "</strong>원</span></a>";
                infopro_areaDiv.find('.lowprice').html(priceHtml);
                infopro_areaDiv.find('.lowprice').show();
            }

            if (parseInt(mini_cashMinPrice) >= 0 && mini_cashMinYn == "Y") {
                if (parseInt(mini_mMinPrice3) == 0 && parseInt(mini_nMallCnt) > 0) {
                    infopro_areaDiv.find('.lowprice').hide();
                }
                priceHtml = "<a href=\"javascript:void(0);\"><span class=\"low\">현금최저가</span><strong>" + numComma(mini_cashMinPrice) + "</strong>원</a>";
                infopro_areaDiv.find(".cashprice").html(priceHtml);
                infopro_areaDiv.find(".cashprice").show();
            } else {
                infopro_areaDiv.find(".cashprice").hide();
            }

            infopro_areaDiv.find('img').unbind();
            infopro_areaDiv.find('img').click(function() {
                goModelnoNew(modelno);
                insertLog(15044);
            });

            infopro_areaDiv.find('.proname').unbind();
            infopro_areaDiv.find('.proname').click(function() {
                goModelnoNew(modelno);
                insertLog(15045);
            });

            infopro_areaDiv.find('.subcon').unbind();
            infopro_areaDiv.find('.subcon').click(function() {
                goModelnoNew(modelno);
                insertLog(15046);
            });

            infopro_areaDiv.find('.lowprice a').unbind();
            infopro_areaDiv.find('.lowprice a').click(function() {
                goModelnoNew(modelno);
                insertLog(15057);
            });

            infopro_areaDiv.find('#starGraph').unbind();
            infopro_areaDiv.find('#starGraph').click(function() {
                goModelnoNew(modelno);
                insertLog(15402);
            });

            $('#starGraph').unbind();
            $('#starGraph').click(function() {
                if (mini_modelno != "") goMore_Modelno(mini_modelno, "2");
            });

            //중분류별 로그
            if ($('#mimi_bisic_compare').attr('class').indexOf("on") > -1) insertLogCate(15417, mini_szCategory4);
            else insertLogCate(15079, mini_szCategory4);
            // 신고 버튼 클릭
            infopro_areaDiv.find(".btn_singo2").unbind();
            infopro_areaDiv.find(".btn_singo2").click(function() {
                insertLog(15058);

                var thisObj = $(this);
                var prodNo = "";
                var modelno = mini_modelno;


                if (modelno.length > 0) {
                    $.ajax({
                        url: "/lsv2016/ajax/AjaxInconv.jsp",
                        data: "modelno=" + modelno + "&type=2",
                        dataType: "HTML",
                        type: "get",
                        success: function(result) {
                            var div_inconvObj = $("#div_inconv");
                            div_inconvObj.html(result);

                            var lStyle = "";
                            lStyle += "position:absolute;";
                            lStyle += "z-index:9999;";
                            lStyle += "top:" + (thisObj.offset().top + thisObj.height() + 4) + "px;";
                            lStyle += "left:" + (thisObj.offset().left - div_inconvObj.width() + thisObj.width() + 4) + "px;";

                            div_inconvObj.attr("style", lStyle);

                            div_inconvObj.fadeIn();

                            insertLogLSV(14294);
                        },
                        error: function(request, status, error) {
                            //alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                        }
                    });
                }
            });

            // 미니미니 일경우는 안함
            // miniVipTab=1 일 경우는 디폴트임
            if (miniVipTab && miniVipTab > 1 && miniVipTab <= 3) {
                var tabObj = $("#mini_tabarea .tab li");
                if (tabObj.length >= 3) {
                    $(tabObj[miniVipTab - 1]).trigger("click");
                }
            } else {
                miniTabReset();
            }
            miniVipTab = "";

            // 비즈스프링(로거)에서 알려준 ajax를 확인 할 수 있는 로그 호출 방법
            try {
                _trk_flashEnvView('_TRK_CP=/miniVIP');
            } catch (e) {}

        },
        error: function(xhr, ajaxOptions, thrownError) {
            //alert(xhr.status);
            //alert(thrownError);
        }
    });

    loadBanner('Mi');

    //파워링크
    //fn_Mini_powerlink(mini_szCategory,strPlkeyword);
    getPowerLink("MINIVIP", gCate, strPlkeyword);
    loadPriceList(modelno);
    //loadMimiPriceList(mini_modelno);
    getMiniSpec(); //상품설명

    getMiniGoods_caution(); //주의사항
    loadCashList(modelno);
    /* 사용자 로그인 여부 */
    fn_userInfoSet(mini_sUserId, "G");
    getMiniBbs(); //상품평리스트
    if (mini_szCategory.length > 2) {
        mini_szCategory2 = mini_szCategory.substring(0, 2);
        if (mini_szCategory2 == "08") loadComponet(modelno, mini_szCategory4);
    }

    loadAttr(modelno, mini_szCategory);
}
/****************************************************************************
	화장품 전성분 UI 개선 (20180425)
****************************************************************************/

function loadComponet(gModelno, szCategory) {
    var modelno = gModelno;
    var cacode = szCategory;
    var opt = "ALL_T";
    var param = {
        "modelno": modelno,
        "cacode": cacode,
        "opt": opt
    }

    $.ajax({
        type: "get",
        url: "/common/jsp/Ajax_Component_Data.jsp",
        async: true,
        data: param,
        dataType: "json",
        success: function(json) {
            var vAll_Component = json.all_component_data[0];
            var vGoodness_type = json.all_component_data[1];
            var vComponent_items = json.all_component_data[2];
            var vGoods_itemTemplate = "";
            var vBad_itemTemplate = "";
            var vGoods_Itemli = "";
            var vBad_Itemli = "";
            var vGoodnessTemplate = "";
            var vAllTemplate = "";
            var vTemplate = "";
            var cpt_name = "";
            if (vAll_Component.total_cnt == 0) {
                return;
            }
            for (var i = 0; i < vGoodness_type.goodness_type.length; i++) {
                vTemplate += "<li><em class=\"p" + vGoodness_type.goodness_type[i].cpt_goodness_round_percent + "\">" + vGoodness_type.goodness_type[i].cpt_goodness_percent + "%</em><span>" + vGoodness_type.goodness_type[i].cpt_group_name + "</span></li>";
            }
            for (var i = 0; i < vComponent_items.component_items.length; i++) {
                if (vComponent_items.component_items[i].cpt_harmflag == "0") {
                    if (vComponent_items.component_items[i].cpt_name == "피부보습") {
                        cpt_name = "피부 보습";
                    } else {
                        cpt_name = "피부 " + vComponent_items.component_items[i].cpt_name
                    }
                    if (vComponent_items.component_items[i].cpt_cnt == "0") {
                        vGoods_Itemli += "<li><em class=\"non\">" + vComponent_items.component_items[i].cpt_cnt + "</em><span>" + cpt_name + "</span></li>";
                    } else {
                        vGoods_Itemli += "<li><em class=\"on\">" + vComponent_items.component_items[i].cpt_cnt + "</em><span>" + cpt_name + "</span></li>";
                    }
                } else {
                    if (vComponent_items.component_items[i].cpt_cnt == "0") {
                        vBad_Itemli += "<li><em class=\"non\">" + vComponent_items.component_items[i].cpt_cnt + "</em><span>" + vComponent_items.component_items[i].cpt_name + "</span></li>";
                    } else {
                        vBad_Itemli += "<li><em class=\"on\">" + vComponent_items.component_items[i].cpt_cnt + "</em><span>" + vComponent_items.component_items[i].cpt_name + "</span></li>";
                    }
                }
            }
            vGoodnessTemplate += "<p class=\"cosmetics__tit\">성분</p>";
            vGoodnessTemplate += "<div class=\"cosmeticsgraph\">";
            vGoodnessTemplate += "	<h2 class=\"cosmeticsgraph__tit\">";
            vGoodnessTemplate += "			<span>*</span>피부타입별 적합도";
            vGoodnessTemplate += "	</h2>";
            vGoodnessTemplate += "	<ul class=\"cosmeticsgraph__graph type1\">";
            vGoodnessTemplate += vTemplate;
            vGoodnessTemplate += "	</ul>";
            vGoodnessTemplate += "</div>";

            vGoods_itemTemplate += "<div class=\"cosmeticsgraph\">";
            vGoods_itemTemplate += "	<h2 class=\"cosmeticsgraph__tit\">";
            vGoods_itemTemplate += "			<span>*</span>좋은성분";
            vGoods_itemTemplate += "	</h2>";
            vGoods_itemTemplate += "	<ul class=\"cosmeticsgraph__graph type2\">";
            vGoods_itemTemplate += vGoods_Itemli;
            vGoods_itemTemplate += "	</ul>";
            vGoods_itemTemplate += "</div>";

            vBad_itemTemplate += "<div class=\"cosmeticsgraph\">";
            vBad_itemTemplate += "	<h2 class=\"cosmeticsgraph__tit\">";
            vBad_itemTemplate += "			<span>*</span>유의성분";
            vBad_itemTemplate += "	</h2>";
            vBad_itemTemplate += "	<ul class=\"cosmeticsgraph__graph type3\">";
            vBad_itemTemplate += vBad_Itemli;
            vBad_itemTemplate += "	</ul>";
            vBad_itemTemplate += "</div>";
            $("#cosmetics").html(vGoodnessTemplate + vGoods_itemTemplate + vBad_itemTemplate);
            $("#cosmetics").show();

        },
        error: function(xhr, ajaxOptions, thrownError) {
            //alert(xhr.status);
            //alert(thrownError);
        }
    });
}


//가구 속성 추가 (20190410)
function loadAttr(gModelno, szCategory) {
    var modelno = gModelno;
    var param = {
        "modelno": modelno,
        "ca_code": szCategory
    };
    $.ajax({
        type: "get",
        url: "/lsv2016/ajax/detail/getGoodsAttrGraph.jsp",
        data: param,
        dataType: "json",
        success: function(result) {
            var listAry = result["list"];
            if (szCategory.substring(0, 4) == "1201" || szCategory.substring(0, 4) == "1202") {
                loadFurniture(listAry);
            }
        },
        error: function(e) {

        }
    });

}

function loadFurniture(json) {
    var furHtml = "";
    $.each(json, function(index, listData) {
        var attribute_id = listData["attribute_id"];
        var attribute_element_id = listData["attribute_element_id"];
        var attribute_element = listData["attribute_element"];
        var attribute_model = listData["model"];
        var attribute_elementClass = "";
        var attribute_title = "";
        var attribute_type = "";
        var attribute_typeClass = "";
        var attribute_gradeClass = "";
        var attribute_spanText = "";
        if (attribute_id == 123660 || attribute_id == 133553) {
            attribute_gradeClass = "level_" + attribute_element.toLowerCase();
            attribute_title = "자재등급";
            attribute_type = "1";
            attribute_spanText = "유해물질 포름알데히드 방출량에 따른 등급분류";
        } else if (attribute_id == 211331) {
            attribute_gradeClass = "level_0" + attribute_element_id;
            attribute_title = "착석감";
            attribute_type = "2";
            attribute_spanText = "1이 가장 푹신하고 5가 가장 단단합니다.";
        } else if (attribute_id == 205023) {
            if (attribute_element_id == 5) attribute_element_id = 1;
            else if (attribute_element_id == 6) attribute_element_id = 2;
            else if (attribute_element_id == 2) attribute_element_id = 3;
            else if (attribute_element_id == 3) attribute_element_id = 4;
            else if (attribute_element_id == 7) attribute_element_id = 5;
            attribute_gradeClass = "level_0" + attribute_element_id;
            attribute_title = "쿠션감";
            attribute_type = "2";
            attribute_spanText = "1이 가장 푹신하고 5가 가장 단단합니다.";
        }
        attribute_typeClass = "fun_grade_0" + attribute_type;

        furHtml += "	<div class=\"fun_grade " + attribute_typeClass + "\">";
        furHtml += "		<div class=\"grade_tit\">*" + attribute_title + "</div>";
        furHtml += "		<div class=\"grade_level " + attribute_gradeClass + "\"></div>";
        furHtml += "		<span class=\"txt_noti\">" + attribute_spanText + "</span>";
        furHtml += "	</div>";

    });
    if (furHtml != "") {
        $("#lpvip_fun_grade").html(furHtml);
        $("#lpvip_fun_grade").show();
    } else {
        $("#lpvip_fun_grade").hide();
    }


}
//탭초기화
function miniTabReset() {
    mini_resize();
    var mini_maObj = $('#mini_mallprlist_area');
    mini_maObj.find(".tab li").removeClass("on");
    mini_maObj.find(".tab li:first").addClass("on");
    var activeTab = mini_maObj.find(".tab li:first").find("a").attr("href");
    mini_maObj.find(".cont_area").hide();
    $(activeTab).show();
}

var mini_listType = 1; //기본
var leftCnt = 0;
var rightCnt = 0;
var caution_info = false;
var optionEssential = false;
var mini_totalminprice = 0;
var gPhonePriceShow = false; //좌우구분이 일시불/할부구매쇼핑몰인 모델 구분
var gauthShowFlag = false; //제조사 인증
var mini_limtShowLine = 19; //더보기 제한갯수
var mini_bZzim = false;

function loadPriceList(modelno) {
    //var mini_modelno = modelno;
    if (typeof(modelno) == 'undefined') modelno = mini_modelno;
    var strShopListAll = mini_shopListAll; //YES :더보기
    if (mini_deliveryFlag) mini_listType = 2; //배송비포함
    if (mini_cardeventFlag) mini_listType = 3; //카드할인가
    if (!mini_deliveryFlag && !mini_cardeventFlag) mini_listType = 1; //기본

    if (mini_shopListAll == "YES") mini_loadingShow();

    var param = {
        //"modelno" : gModelno
        "random_seq": random_seq,
        "modelno": modelno,
        "strShopListAll": strShopListAll,
        "listType": mini_listType,
        "szSelectedShop": mini_SelectedShop,
        "constrain": mini_Constrain,
        "showLine": mini_limtShowLine
    }
    $.ajax({
        type: "get",
        url: "/lsv2016/ajax/detail/getPriceList_ajax.jsp",
        async: false,
        data: param,
        dataType: "json",
        success: function(json) {
            $('#tab01').find(".scroll_area").scrollTop(0);

            //가격비교 개수
            var compareGoodsCnt = json["compareGoodsCnt"];
            var cardButtonShowFlag = false;
            cardButtonShowFlag = json["cardButtonShowFlag"];
            gPhonePriceShow = json["bPhonePriceShow"];

            cardButtonShowFlag = (cardButtonShowFlag == 'true');
            if (cardButtonShowFlag) $('.option_sel').find('#o_card').show();
            else $('.option_sel').find('#o_card').hide();

            if (parseInt(mini_Constrain) == 5) { //유사상품
                $('#mini_goodsInfo').find('.proinfo ').addClass("siminfo");
                var priceListObj = json["left_priceList"];
                if (cardButtonShowFlag && mini_cardeventFlag) priceListObj = json["right_priceList"];

                //최저가
                mini_totalminprice = parseInt(json["left_totalMinPrice"]);
                if (cardButtonShowFlag && mini_cardeventFlag) mini_totalminprice = parseInt(json["right_totalMinPrice"]);

                $('#bisic_compare').hide();

                if ($('#mimi_bisic_compare').attr('class').indexOf("on") > -1) {
                    $('#similar_compare').hide();
                    $('#option_sel').hide();
                    $('#mimi_bisic_compare').show();
                    if (starGraphon == 'true') $('#starGraph').show();
                } else {
                    $('#mimi_bisic_compare').hide();
                    $('#similar_compare').show();
                    $('#rental_compare').hide();
                    $('#option_sel').show();
                    $('#simcompair').show();
                    $('#starGraph').hide();
                }


                var left_msg = json["left_msg"];

                loadsimilarGoodsListView(priceListObj, 'left', left_msg);
            } else if (mini_Rental == "rental" || mini_strCondiname.indexOf("렌탈(월)") > -1) {
                $('#bisic_compare').hide();
                $('#mimi_bisic_compare').hide();
                $('#similar_compare').hide();
                $('#option_sel').hide();
                $('#mimi_option_sel').hide();
                $('#rental_compare').show();
                $('#simcompair').hide();

                //상담신청하기
                $('#btn_rental').unbind();
                $('#btn_rental').click(function() {
                    goModelnoNew(mini_modelno);
                });
            } else if (!isNaN(mini_dDate) && (parseInt(mini_dDate) > parseInt(mini_cur_date))) { //출시예정
                $('#bisic_compare').hide();
                $('#mimi_bisic_compare').hide();
                $('#similar_compare').hide();
                $('#option_sel').hide();
                $('#mimi_option_sel').hide();
                $('#rental_compare').hide();
                $('#nodata_compare').show();
                $('#plan_goods').show();
                $('#soldout_goods').hide();
                $('#simcompair').hide();
            } else if (parseInt(mini_nMallCnt) <= 0 && parseInt(mini_nMallCnt3) <= 0) { //일시품절
                $('#bisic_compare').hide();
                $('#mimi_bisic_compare').hide();
                $('#similar_compare').hide();
                $('#option_sel').hide();
                $('#mimi_option_sel').hide();
                $('#rental_compare').hide();
                $('#nodata_compare').show();
                $('#plan_goods').hide();
                $('#soldout_goods').show();
                $('#simcompair').hide();
            } else {
                $('#simcompair').hide();
                var left_priceListObj = json["left_priceList"];
                var right_priceListObj = json["right_priceList"];

                //가격비교 개수
                leftCnt = parseInt(json["left_cnt"]);
                rightCnt = parseInt(json["right_cnt"]);

                //최저가
                mini_totalminprice = parseInt(json["left_totalMinPrice"]);
                var right_totalMinPrice = parseInt(json["right_totalMinPrice"]);
                if (mini_totalminprice <= 0) mini_totalminprice = right_totalMinPrice;
                else if (right_totalMinPrice < mini_totalminprice && right_totalMinPrice > 0) mini_totalminprice = right_totalMinPrice;

                //타이틀
                var lefttitleObj = $("#lefttitle");
                var righttitleObj = $("#righttitle");
                var left_title = "";
                var right_title = "";
                if (typeof(json["left_title"]) != 'undefined') {
                    left_title = json["left_title"].replace("인증 공식판매자", "공식판매");
                    if (left_title.indexOf("<a") > -1) left_title = left_title.substring(0, left_title.indexOf("<a"));
                }
                if (typeof(json["right_title"]) != 'undefined') {
                    right_title = json["right_title"];
                    if (right_title.indexOf("<a") > -1) right_title = right_title.substring(0, right_title.indexOf("<a"));
                }
                //var left_authImg = json["left_authImg"].replace("/images/view/detail/pricelist/auth/","/2014/toolbar/20140331/logos/").replace(".gif","_toolbar.gif");
                var left_authImg = "";
                var right_authImg = "";
                if (typeof(json["left_authImg"]) != 'undefined') left_authImg = json["left_authImg"].replace(".gif", "_toolbar.gif");
                if (typeof(json["right_authImg"]) != 'undefined') right_authImg = json["right_authImg"];
                var left_msg = json["left_msg"];
                var right_msg = json["right_msg"];

                //제조사 인증
                gauthShowFlag = json["authShowFlag"];
                if (left_authImg != "" && mini_SelectedShop == "") left_title = left_authImg + left_title;
                if (right_authImg != "") right_title = right_authImg + right_title;
                lefttitleObj.html(left_title);
                righttitleObj.html(right_title);

                mimiShow();

                if (leftCnt > 0 || rightCnt > 0) {
                    $('#similar_compare').hide();
                    $('#rental_compare').hide();
                    $('#nodata_compare').hide();

                    if (modelno == mini_modelno) {
                        loadGoodsListView(left_priceListObj, 'left', left_msg);
                        loadGoodsListView(right_priceListObj, 'right', right_msg);
                    }
                } else {
                    //현금몰 예외처리 ( left right 가격비교 없을 때 디폴트 )

                    var nohtml = "";
                    var leftsideObj = $("#bisic_compare .fieldleft").find(".proitemlist");
                    var rightsideObj = $("#bisic_compare .fieldright").find(".proitemlist");
                    if (compareGoodsCnt > 0) {
                        $("#lefttitle").html("오픈마켓");
                        $("#righttitle").html("일반쇼핑몰");
                        leftsideObj.html("<li class=\"nomall\"><div class=\"itembox\"><p class=\"nomall\">판매중인 오픈마켓이 없습니다.</p></div></li>");
                        rightsideObj.html("<li class=\"nomall\"><div class=\"itembox\"><p class=\"nomall\">판매중인 일반 쇼핑몰이 없습니다.</p></div></li>");
                        $('.nomall').addClass("last");
                    }

                }
            }

            mini_resize();

            // 상위입찰 스크립트 호출
            if (mini_listType == 1 && mini_SelectedShop == "") {
                setBidDeduction();
            }

            //모바일 최저가 레이어
            //setMiniMobileSendProdDiv();

            //G9이동
            setG9Div();

        },
        error: function(xhr, ajaxOptions, thrownError) {
            //alert(xhr.status);
            //alert(thrownError);
        }
    });
}

var mimi_compareGoodsCnt = 0;

function loadMimiPriceList(modelno) {
    //var mini_modelno = modelno;
    if (typeof(modelno) == 'undefined') modelno = mini_modelno;
    var strShopListAll = mini_shopListAll; //YES :더보기
    var tabyn_dminsort = 'N';
    if (mini_deliveryFlag) {
        mini_listType = 2; //배송비포함
        tabyn_dminsort = 'Y';
    }
    var tabyn_card = "N";
    if (mini_cardeventFlag) {
        mini_listType = 3; //카드할인가
        tabyn_card = "Y";
    }
    var tabyn_dlv0 = "N";
    if (mini_deliveryfreeFlag) {
        mini_listType = 1; //무료배송
        tabyn_dlv0 = "Y";
    }
    var tabyn_auth = "N";
    if (mini_authFlag) {
        mini_listType = 1; //제조사공식인증
        tabyn_auth = "Y";
    }
    var tabyn_depart = "N";
    if (mini_departFlag) {
        mini_listType = 1; //백화점몰
        tabyn_depart = "Y";
    }
    var tabyn_cardfree = "N";
    if (mini_cardfreeFlag) {
        mini_listType = 1; //무이자
        tabyn_cardfree = "Y";
    }
    var tabyn_etcmall = "N";
    if (mini_etcmallFlag) {
        mini_listType = 1; //홈쇼핑/전문몰
        tabyn_etcmall = "Y";
    }
    if (!mini_deliveryFlag && !mini_cardeventFlag && !mini_deliveryfreeFlag && !mini_authFlag && !mini_departFlag && !mini_cardfreeFlag && !mini_etcmallFlag) {
        mini_listType = 1; //기본
        $("#tab01 .pro.sub_dp li").parent().parent().prev("a").text("판매가순");
    } else if (mini_deliveryFlag) {
        $("#tab01 .pro.sub_dp li").parent().parent().prev("a").text("배송비포함순");
    } else if (mini_cardeventFlag) {
        $("#tab01 .pro.sub_dp li").parent().parent().prev("a").text("카드할인가순");
    }

    if (mini_shopListAll == "YES") mini_loadingShow();

    var param = {
        //"modelno" : gModelno
        "kind": "pm",
        "modelno": modelno,
        "tabinfoyn": "Y",
        "tabyn_dminsort": tabyn_dminsort,
        "tabyn_card": tabyn_card,
        "tabyn_dlv0": tabyn_dlv0,
        "tabyn_auth": tabyn_auth,
        "tabyn_depart": tabyn_depart,
        "tabyn_cardfree": tabyn_cardfree,
        "tabyn_etcmall": tabyn_etcmall,
        "ca_code": mini_szCategory
    }
    $.ajax({
        type: "get",
        url: "/mobilefirst/ajax/detailAjax/get_minilist.jsp",
        async: true,
        data: param,
        dataType: "json",
        success: function(json) {
            $('#tab01').find(".scroll_area").scrollTop(0);

            //가격비교 개수
            mimi_compareGoodsCnt = json["listCount"];
            var cardButtonShowFlag = false;
            cardButtonShowFlag = json["tabyn_card"] == 'Y' ? true : false;

            var tabyn_dlv0ShowFlag = false;
            tabyn_dlv0ShowFlag = json["tabyn_dlv0"] == 'Y' ? true : false;

            var tabyn_authShowFlag = false;
            tabyn_authShowFlag = json["tabyn_auth"] == 'Y' ? true : false;

            var tabyn_departShowFlag = false;
            tabyn_departShowFlag = json["tabyn_depart"] == 'Y' ? true : false;

            var tabyn_cardfreeFlag = false;
            tabyn_cardfreeFlag = json["tabyn_cardfree"] == 'Y' ? true : false;

            var tabyn_etcmallFlag = false;
            tabyn_etcmallFlag = json["tabyn_etcmall"] == 'Y' ? true : false;

            if (cardButtonShowFlag) $('#mimi_option_sel').find('#o_card').show();
            else $('#mimi_option_sel').find('#o_card').hide();

            if (tabyn_dlv0ShowFlag) $('#mimi_option_sel').find('#o_deliveryfree').show();
            else $('#mimi_option_sel').find('#o_deliveryfree').hide();

            if (tabyn_authShowFlag) $('#mimi_option_sel').find('#o_auth').show();
            else $('#mimi_option_sel').find('#o_auth').hide();

            if (tabyn_departShowFlag) $('#mimi_option_sel').find('#o_depart').show();
            else $('#mimi_option_sel').find('#o_depart').hide();

            if (tabyn_cardfreeFlag) $('#mimi_option_sel').find('#o_cardfree').show();
            else $('#mimi_option_sel').find('#o_cardfree').hide();

            if (tabyn_etcmallFlag) $('#mimi_option_sel').find('#o_etcmall').show();
            else $('#mimi_option_sel').find('#o_etcmall').hide();

            /*if(parseInt(mini_Constrain)==5){ //유사상품
            	$('#mini_goodsInfo').find('.proinfo ').addClass("siminfo");
            	var priceListObj = json["listContent"];

            	//최저가
            	mini_totalminprice = parseInt(json["instanceMinPrice"]);
            	
            	$('#bisic_compare').hide();
            	$('#mimi_bisic_compare').hide();
            	$('#similar_compare').show();
            	$('#rental_compare').hide();
            	$('#option_sel').show();
            	$('#simcompair').show();

            	loadsimilarGoodsListView(priceListObj, 'left', '해당 쇼핑몰이 없습니다.');
            }else*/
            if (mini_Rental == "rental" || mini_strCondiname.indexOf("렌탈(월)") > -1) {
                $('#bisic_compare').hide();
                $('#mimi_bisic_compare').hide();
                $('#similar_compare').hide();
                $('#option_sel').hide();
                $('#mimi_option_sel').hide();
                $('#rental_compare').show();
                $('#simcompair').hide();

                //상담신청하기
                $('#btn_rental').click(function() {
                    goModelnoNew(mini_modelno);
                });
            } else if (!isNaN(mini_dDate) && (parseInt(mini_dDate) > parseInt(mini_cur_date))) { //출시예정
                $('#bisic_compare').hide();
                $('#mimi_bisic_compare').hide();
                $('#similar_compare').hide();
                $('#option_sel').hide();
                $('#mimi_option_sel').hide();
                $('#rental_compare').hide();
                $('#nodata_compare').show();
                $('#plan_goods').show();
                $('#soldout_goods').hide();
                $('#simcompair').hide();
            } else if (parseInt(mini_nMallCnt) <= 0 && parseInt(mini_nMallCnt3) <= 0) { //일시품절
                $('#bisic_compare').hide();
                $('#mimi_bisic_compare').hide();
                $('#similar_compare').hide();
                $('#option_sel').hide();
                $('#mimi_option_sel').hide();
                $('#rental_compare').hide();
                $('#nodata_compare').show();
                $('#plan_goods').hide();
                $('#soldout_goods').show();
                $('#simcompair').hide();
            } else {
                var listContentObj = json["listContent"];

                //최저가
                mini_totalminprice = parseInt(json["instanceMinPrice"]);

                mimiShow();

                if (parseInt(mimi_compareGoodsCnt) > 0) {
                    $('#nodata_compare').hide();
                    //$('#similar_compare').hide();
                    $('#rental_compare').hide();

                    if (modelno == mini_modelno) {
                        loadMimiGoodsListView(listContentObj);
                    }
                } else {
                    $('#nodata_compare').hide();
                    $('#mimi_bisic_compare').hide();
                    ///$('#option_sel').hide();
                    //$('#mimi_option_sel').hide();
                }
            }

            mini_resize();

            //모바일 최저가 레이어
           // setMiniMobileSendProdDiv();

        },
        error: function(xhr, ajaxOptions, thrownError) {
            //alert(xhr.status);
            //alert(thrownError);
        }
    });
}

//상위입찰 스크립트 호출
function setBidDeduction() {
    var modelno = mini_modelno;
    var param = {
        "modelno": modelno,
        "bidchk": min_szBidchk
    }

    $.ajax({
        type: "get",
        url: "/sdul/bid/include/AjaxBidDeduction.jsp",
        async: true,
        data: param,
        dataType: "data",
        success: function(data) {},
        error: function(xhr, ajaxOptions, thrownError) {
            //alert(xhr.status);
            //alert(thrownError);
        }
    });
}

function loadGoodsListView(priceListObj, leftright, nomall_msg) {
    var sideObj = null;
    var lastcnt = 0;
    if (leftright == 'left') {
        sideObj = $("#bisic_compare .fieldleft").find(".proitemlist");
        lastcnt = leftCnt;
    }
    if (leftright == 'right') {
        sideObj = $("#bisic_compare .fieldright").find(".proitemlist");
        lastcnt = rightCnt;
    }
    //sideObj.hide();
    var html = "";
    sideObj.html(html);

    if (priceListObj != "") {
        $.each(priceListObj, function(Index, listData) {
            html = "";
            var o_shop_cnt = listData["shop_cnt"];
            var o_shop_code = listData["shop_code"];
            var o_emoneyshop = listData["emoneyshop"];
            var o_shop_name = listData["shop_name"];
            var o_minPrice = listData["minPrice"];
            var o_instance_price = listData["instance_price"];
            var o_minPrice2 = listData["minPrice2"];
            var o_minPrieFlag = listData["minPrieFlag"];
            var o_deliveryInfo = listData["deliveryInfo"];
            var o_deliveryinfo2 = listData["deliveryinfo2"];
            var o_deliverytype2 = listData["deliverytype2"];
            var o_minprice_delivery = listData["minprice_delivery"];
            var strdelivery = "";

            if (o_deliveryInfo == "조건부무료") { //쿠팡조건추가 2019-04-03
                strdelivery = o_deliveryInfo;
            } else if (o_minprice_delivery == 0) {
                strdelivery = "무료배송";
            } else if ($.isNumeric(o_minprice_delivery)) {
                if (mini_deliveryFlag) strdelivery = "배송비 " + numComma(o_minprice_delivery) + "원 포함";
                else strdelivery = "배송비 " + numComma(o_minprice_delivery) + "원";
            } else {
                strdelivery = o_minprice_delivery;
            }
            var o_eventTxt = listData["eventTxt"];
            var o_telTxt = listData["telTxt"];
            var o_agree_monthTxt = listData["agree_monthTxt"];
            var o_powerFlag = listData["powerFlag"];
            var o_shopBidFlag = listData["shopBidFlag"];
            var o_bidTopClass = listData["bidTopClass"];
            var o_seller_ad = listData["seller_ad"];
            var o_nhCardAdShowFlag = listData["nhCardAdShowFlag"];
            var o_CardEvent = listData["CardEvent"];
            var o_Price_card = listData["Price_card"];
            var o_CardName = listData["CardName"];
            var o_mallLinkUrl = listData["mallLinkUrl"];
            var o_logLinkUrl = listData["logLinkUrl"];
            var o_pl_no = listData["pl_no"];
            var o_goodsCode = listData["goodsCode"];
            var o_goodsName = listData["goodsName"].replace("\"", "&quot;").replace("'", "\'");
            var o_Freeinterest = listData["Freeinterest"];
            var o_PlCoupon = listData["PlCoupon"];
            var o_CouponFlag = listData["CouponFlag"];
            var o_CouponUrl = listData["CouponUrl"];
            var o_CouponSale1 = listData["CouponSale1"];
            var o_CouponSale2 = listData["CouponSale2"];
            var o_option_flag = listData["option_flag"];
            var o_deliveryShowFlag = listData["deliveryShowFlag"];
            var o_CouponContents = listData["CouponContents"].replace(/\r\n/g, '<br>');
            var o_CouponURL = listData["CouponURL"];
            var o_OverseaDelivery = listData["OverseaDelivery"];
            var o_phonePriceShowInfo = listData["phonePriceShowInfo"];

            var o_strSystemContents = listData["strSystemContents"].replace(/\r\n/g, '<br>');
            var o_strSystemSdate = listData["strSystemSdate"];
            var o_strSystemEdate = listData["strSystemEdate"];

            var o_bDepartGoods = listData["bDepartGoods"];
            var o_strDepartname = listData["strDepartname"];

            var o_gmarket_g9 = listData["gmarket_g9"];

            //11번가 중복쿠폰
            var eventCouponCheck = listData["eventCouponCheck"];

            //프로모션 자동화
            var o_pc_mini_vip_icn_view_dcd = listData["pc_mini_vip_icn_view_dcd"];
            var o_pc_mini_vip_icn_str = listData["pc_mini_vip_icn_str"];
            var o_pc_promtn_url = listData["pc_promtn_url"];
            var o_mobileOnly = listData["mobileOnly"];


            //TLC flag
            var o_tlc_flag = listData["tlc_flag"];
            var varMini11StSort = "";

            var deliveryprice = 0;
            if (!isNaN(o_deliveryInfo)) deliveryprice = o_deliveryInfo;
            var o_talminprice = o_minPrice;
            if (o_minPrice > o_instance_price) o_talminprice = o_instance_price;

            var sponcheck = false;
            if (o_bidTopClass > 0 || o_shopBidFlag == 'true') sponcheck = true;

            var mini_logflag = 0;
            if (leftright == 'right' && o_bidTopClass > 0) mini_logflag = 1;
            if (leftright == 'left' && o_bidTopClass > 0) mini_logflag = 2;

            var cmdGoToUrl = "";
            var cmdBridgeUrl = "";
            if (o_mobileOnly == "Y") {
                cmdGoToUrl = "MinimobileSendProdDivShow(2, this);insertLog(15052);";
            } else {
               
                if((o_shop_code == "5910") && (vNowtime >= minCheck) && (vNowtime <= maxCheck)){
                    cmdGoToUrl = "clicklog(" + mini_logflag + ");alert('해당 쇼핑몰은 현재 서비스 점검 중입니다.');return false;";
                }else{
                    cmdBridgeUrl = bridgeUrl('move_link',o_shop_code,mini_modelno,mini_factory,o_pl_no,o_PlCoupon,o_minPrice,1);
                    cmdGoToUrl = "clicklog(" + mini_logflag + ");";//goPlnoItem(" + o_pl_no + ");";
                }
            }
            //상위입찰 적용 노출 로그
            if (o_bidTopClass > 0) insertLog(15078);

            var deliveryIscollect = (strdelivery == "배송비유무료" || strdelivery == "착불" || strdelivery == "배송비유료") ? "N" : "Y";

            var rightLast = false;
            if (leftright == "right" && priceListObj.length == (Index + 1) && (leftCnt > 4 || rightCnt > 4)) rightLast = true;

            html += "<li";
            if (rightLast) { html += " class=\"last\"" }
            html += " id=\"item" + (Index + 1) + "\">";
            html += "	<div class=\"itembox\">";
            html += "		<p class=\"mallinfo\">";
            if((o_shop_code == "5910") && (vNowtime >= minCheck) && (vNowtime <= maxCheck)){
                html += "			<a class=\"mallname\" href=\"javascript:void(0);\"  onclick=\"" + cmdGoToUrl;
            }else{
                html += "			<a class=\"mallname\" href=\""+cmdBridgeUrl+"\" target=\"_blank\" onclick=\"" + cmdGoToUrl;
            }
            if (o_mobileOnly != "Y") html += "insertLog(15062);";
            html += "\">";
            if (mini_cardeventFlag && leftright == 'right') {
                html += "			<strong class=\"crcard\">" + o_CardName + "</strong>";
            }
            html += "				<strong>" + o_shop_name + "</strong>";
            if (sponcheck) {
                html += "			<span class=\"icon ad\"><em>스폰서</em></span>";
            }
            /* if (o_powerFlag == 'Y') {
                html += "				<span class=\"icon powerseller\"><em>파워셀러</em></span>";
            } */
            html += "			</a>";

            // 프로모션 자동화 중복쿠폰
            if (o_pc_mini_vip_icn_view_dcd == 'C') {
                html += "	 	<span class=\"coupon_11st\" strUrl='" + o_pc_promtn_url + "'>중복쿠폰받기</span>";
            } else if (o_pc_mini_vip_icn_view_dcd == 'M' && o_pc_mini_vip_icn_str != "") {
                html += "	 	<span class=\"coupon_11st word\" strUrl='" + o_pc_promtn_url + "'>" + o_pc_mini_vip_icn_str + "</span>";
            }

            /*//G9이동
            if(o_gmarket_g9=="Y"){
            	html +="		<span class=\"icon btn_g9move\" style=\"cursor: pointer;\" onclick=\"G9DivShow(this);\"><em>G9이동</em></span>";
            }*/
            html += "		</p>";
            html += "		<p class=\"priceline";
            if (parseInt(mini_totalminprice) == o_minPrice) {
                if (o_tlc_flag != "Y") {
                    html += " pricelow";
                }
            }
            if (o_shopBidFlag == 'true') {
                html += " shopbid";
            }
            html += "\">";

            if ((o_minPrice <= 0 && o_instance_price > 0) || o_mobileOnly == "Y") {
                html += "	<span class=\"icon mobile\" type=\"2\"><em>모바일</em></span>";
                if (($("#mini_goodsInfo").find(".lowprice .icon.mobile").length == 0 && parseInt(mini_totalminprice) == o_minPrice)) {
                    $("#mini_goodsInfo").find(".lowprice").prepend("<span class=\"icon mobile\" type=\"2\"><em>모바일</em></span>");
                }
                /*html +="	<span class=\"mobileSendLayer only mobile\" type=\"2\">전용</span>";*/
            } else if ((o_instance_price > 0 && o_instance_price < o_minPrice && !mini_deliveryFlag) || (mini_deliveryFlag && o_instance_price > 0 && (parseInt(o_instance_price) + parseInt(deliveryprice)) < o_minPrice)) {
                html += "<span class=\"mobileSendLayer icon mobile\" type=\"1\"><em>모바일</em></span>";
            }
            if((o_shop_code == "5910") && (vNowtime >= minCheck) && (vNowtime <= maxCheck)){
                html += "			<a href=\"javascript:void(0);\"  onclick=\"" + cmdGoToUrl;
            }else{
                html += "			<a href=\""+cmdBridgeUrl+"\" target=\"_blank\" onclick=\"" + cmdGoToUrl;
                if (o_mobileOnly != "Y") html += "insertLog(15063);";
                html += "\">";
            }
            if (parseInt(mini_totalminprice) == o_minPrice) {
                if (o_tlc_flag != "Y") {
                    html += "<span class=\"prlow\" onclick=\"" + cmdGoToUrl + "\">최저가</span>";
                }
            }
            html += "<span class=\"pricepack\"><strong>" + numComma(o_minPrice) + "</strong>";
            if (o_minPrice < 100000000) html += "원";
            html += "	</span></a></p>";
            html += "		<p class=\"delivery\">";
            if((o_shop_code == "5910") && (vNowtime >= minCheck) && (vNowtime <= maxCheck)){
                html +="            <a href=\"javascript:///\" onclick=\"" + cmdGoToUrl + "\">" + strdelivery + "</a></p>";
            }else{
                html +="            <a href=\""+cmdBridgeUrl+"\" target=\"_blank\" onclick=\"" + cmdGoToUrl + "\">" + strdelivery + "</a></p>";
            }
            
            html += "	</div>";
            html += "</li>";
            sideObj.append(html);
            if (mini_shopListAll == 'NO' && (leftCnt >= mini_limtShowLine || rightCnt >= mini_limtShowLine)) {
                $("#list_more").show();
            } else {
                $("#list_more").hide();
            }

            if (mini_shopListAll == "YES") mini_loadingHide();

            $("#mini_mallprlist_area").find('.coupon_11st').unbind();
            $("#mini_mallprlist_area").find('.coupon_11st').click(function() {
                //var rend_url = "http://www.11st.co.kr/connect/Gateway.tmall?method=Xsite&tid=1001161301";
                var rend_url = $(this).attr("strUrl");

                if (rend_url == '') {
                    rend_url = "http://www.11st.co.kr/connect/Gateway.tmall?method=Xsite&tid=1001161301";
                }
                window.open(rend_url, '', '');
                return false;
            });
        });
    } else {

        html = "";
        html += "<li class=\"nomall\"><!-- 쇼핑몰이 없는 경우 class=\"nomall\" 추가 -->";
        html += "<!-- itembox -->";
        html += "<div class=\"itembox\">";
        html += "<p class=\"nomall\">" + nomall_msg + "</p>";
        html += "</div>";
        html += "<!-- //itembox -->";
        html += "</li>";

        sideObj.append(html);
        $('.nomall').addClass("last");
    }
}

function loadMimiGoodsListView(priceListObj) {
    var sideObj = $("#mimi_bisic_compare").find(".proitemlist");
    var html = "";
    sideObj.html(html);
    if (priceListObj != "") {
        $.each(priceListObj, function(Index, listData) {
            html = "";
            var o_shopname = listData["shopname"];
            var o_shopurl = listData["shopurl"];
            var o_shopcode = listData["shopcode"];
            var o_price = listData["price"];
            var o_instanceprice = listData["instanceprice"];
            var o_goodscode = listData["goodscode"];
            var o_minprice = listData["minprice"];
            var o_mPrice_card = listData["mPrice_card"];
            var o_plno = listData["plno"];
            var o_ca_code = listData["ca_code"];
            var o_category = listData["category"];
            var o_plgoodsname = listData["plgoodsname"].replace("\"", "&quot;").replace("'", "\'");;
            var o_deliveryinfo1 = listData["deliveryinfo1"];
            var o_deliveryinfo2 = listData["deliveryinfo2"];
            var o_cardname = listData["cardname"];
            var o_authflag = listData["authflag"];
            var o_cardflag = listData["cardflag"];
            var o_cardfreeflag = listData["cardfreeflag"];
            var o_freeinterestflag = listData["freeinterestflag"];
            var o_couponflag = listData["couponflag"];
            var o_mpriceflag = listData["mpriceflag"];
            var o_pricecard = listData["pricecard"];
            var o_detail_url = listData["detail_url"];
            var o_displaydelivery = listData["displaydelivery"];
            var o_shop_bid = listData["shop_bid"];
            var o_shopbidflag = listData["shopbidflag"];
            var o_shopbidlogno_view = listData["shopbidlogno_view"];
            var o_shopbidlogno_click = listData["shopbidlogno_click"];
            var o_powerFlag = false; //listData["powerFlag"];

            var o_gmarket_g9 = listData["gmarket_g9"];

            //11번가 중복쿠폰
            var eventCouponCheck = listData["eventCouponCheck"];
            var o_CouponURL = listData["CouponUrl"];

            // 프로모션 자동화
            var o_pc_mini_vip_icn_view_dcd = listData["pc_mini_vip_icn_view_dcd"];
            var o_pc_mini_vip_icn_str = listData["pc_mini_vip_icn_str"];
            var o_pc_promtn_url = listData["pc_promtn_url"];
            var o_mobileOnly = listData["mobileOnly"];

            var cmdGoToUrl = "";
            var cmdBridgeUrl = "";
          
            if (o_mobileOnly == "Y") {
                cmdGoToUrl = "MinimobileSendProdDivShow(2, this);insertLog(15052);";
            } else {
                if((o_shopcode == "5910") && (vNowtime >= minCheck) && (vNowtime <= maxCheck)){
                    cmdGoToUrl = "clicklog(" + mini_logflag + ");alert('해당 쇼핑몰은 현재 서비스 점검 중입니다.');return false;";
                }else{
                    cmdGoToUrl = "clicklog(" + mini_logflag + ");";
                    //goPlnoItem(" + o_plno + ");";
                    cmdBridgeUrl = bridgeUrl('move_link',o_shop_code,mini_modelno,mini_factory,o_pl_no,o_PlCoupon,o_minPrice,1);

                }
            }
            var sponcheck = false;
            if (o_shopbidflag == 'Y') sponcheck = true;
            //if (o_bidTopClass > 0 || o_shopBidFlag == 'true') sponcheck = true;

            //상위입찰 적용 노출 로그
            var mini_logflag = 0;
            if (sponcheck) {
                insertLog(o_shopbidlogno_view);
                mini_logflag = 3;
            }

            var deliveryIscollect = (o_displaydelivery == "배송비유무료" || o_displaydelivery == "착불" || o_displaydelivery == "배송비유료") ? "N" : "Y";

            html += "<li class=\"last\" id=\"item" + (Index + 1) + "\">";
            html += "	<div class=\"itembox\">";
            html += "		<p class=\"mallinfo\">";
            if((o_shop_code == "5910") && (vNowtime >= minCheck) && (vNowtime <= maxCheck)){
                html += "			<a class=\"mallname\" href=\"javascript:void(0);\"  onclick=\"" + cmdGoToUrl;
            }else{
                html += "			<a class=\"mallname\" href=\""+cmdBridgeUrl+"\" target=\"_blank\" onclick=\"" + cmdGoToUrl;
            }
            if (o_mobileOnly != "Y") html += "insertLog(15405);";
            html += "\">";
            if (mini_cardeventFlag) {
                html += "			<strong class=\"crcard\">" + o_cardname + "</strong>";
            }
            html += "				<strong>" + o_shopname + "</strong>";
            if (sponcheck) {
                html += "               <span class=\"icon ad\"><em>AD</em></span>";
            }
            /* if (o_powerFlag == 'Y') {
                html += "				<span class=\"icon powerseller\"><em>파워셀러</em></span>";
            } */
            html += "			</a>";

            // 프로모션 자동화 중복쿠폰
            if (o_pc_mini_vip_icn_view_dcd == 'C') {
                html += "	 	<span class=\"coupon_11st\" strUrl='" + o_pc_promtn_url + "'>중복쿠폰받기</span>";
            } else if (o_pc_mini_vip_icn_view_dcd == 'M' && o_pc_mini_vip_icn_str != "") {
                html += "	 	<span class=\"coupon_11st word\" strUrl='" + o_pc_promtn_url + "'>" + o_pc_mini_vip_icn_str + "</span>";
            }

            //G9이동
            /*if(o_gmarket_g9=="Y"){
            	html +="		<span class=\"icon btn_g9move\" style=\"cursor: pointer;\" onclick=\"G9DivShow(this);\"><em>G9이동</em></span>";
            }*/
            html += "		</p>";
            html += "		<p class=\"priceline";
            if (parseInt(o_minprice) == nuNumComma(o_price)) { html += " pricelow"; }
            // if (o_shopbidflag == 'Y') { html += " shopbid"; }
            html += "\">";
            if ((nuNumComma(o_price) <= 0 && o_instanceprice > 0) || o_mobileOnly == "Y") {
                html += "	<span class=\"icon mobile\" type=\"2\"><em>모바일</em></span>";
                if (($("#mini_goodsInfo").find(".lowprice .icon.mobile").length == 0 && parseInt(mini_totalminprice) == o_price)) {
                    $("#mini_goodsInfo").find(".lowprice").prepend("<span class=\"icon mobile\" type=\"2\"><em>모바일</em></span>");
                }
            } else if ((o_instanceprice > 0 && o_instanceprice < nuNumComma(o_price) && !mini_deliveryFlag) || (mini_deliveryFlag && o_instanceprice > 0 && (parseInt(o_instanceprice) + parseInt(o_deliveryinfo2)) < nuNumComma(o_price))) {
                html += "<span class=\"mobileSendLayer icon mobile\" type=\"1\"><em>모바일</em></span>";
            }

            html += "<a href=\"javascript:///\">";
            //if(parseInt(mini_totalminprice)==nuNumComma(o_price)){ html +="<span class=\"prlow\">최저가</span>";}
            if (mini_cardeventFlag) o_price = o_mPrice_card;
            html += "<span class=\"pricepack\" onclick=\"" + cmdGoToUrl;
            if (o_mobileOnly != "Y") html += "insertLog(15406);";
            html += "\"><strong>" + numComma(nuNumComma(o_price)) + "</strong>";
            if (nuNumComma(o_price) < 100000000) html += "원";
            html += "</span></a></p>";
            html += "		<p class=\"delivery\"><a href=\"javascript:///\" onclick=\"" + cmdGoToUrl + "\">" + o_displaydelivery + "</a></p>";
            html += "	</div>";
            html += "</li>";
            if (Index < 20) sideObj.append(html);

            if (mini_shopListAll == 'NO' && (mimi_compareGoodsCnt >= mini_limtShowLine)) {
                $("#list_more").show();
            } else {
                $("#list_more").hide();
            }

            if (mini_shopListAll == "YES") mini_loadingHide();

            $("#mimi_bisic_compare").find('.coupon_11st').unbind();
            $("#mimi_bisic_compare").find('.coupon_11st').click(function() {
                var rend_url = "http://www.11st.co.kr/connect/Gateway.tmall?method=Xsite&tid=1001161301";
                window.open(rend_url, '', '');
                return false;
            });

        });
    } else {
        html = "";
        html += "<li class=\"nomall\"><!-- 쇼핑몰이 없는 경우 class=\"nomall\" 추가 -->";
        html += "<!-- itembox -->";
        html += "<div class=\"itembox\">";
        html += "<p class=\"nomall\">해당 쇼핑몰이 없습니다.</p>";
        html += "</div>";
        html += "<!-- //itembox -->";
        html += "</li>";

        sideObj.append(html);
        $('.nomall').addClass("last");
    }

    mimiResizeWidth();
}

function loadsimilarGoodsListView(priceListObj, leftright, nomall_msg) {
    var itemlistObj = $("#similar_compare").find(".simitemlist");
    //itemlistObj.hide();
    var html = "";
    itemlistObj.html(html);
    if (priceListObj != "") {
        $.each(priceListObj, function(Index, listData) {
            html = "";
            var o_shop_cnt = listData["shop_cnt"];
            var o_shop_code = listData["shop_code"];
            var o_emoneyshop = listData["emoneyshop"];
            var o_shop_name = listData["shop_name"];
            var o_minPrice = listData["minPrice"];
            var o_instance_price = listData["instance_price"];
            var o_minPrice2 = listData["minPrice2"];
            var o_minPrieFlag = listData["minPrieFlag"];
            var o_deliveryInfo = listData["deliveryInfo"];
            var o_deliveryinfo2 = listData["deliveryinfo2"];
            var o_deliverytype2 = listData["deliverytype2"];
            var o_minprice_delivery = listData["minprice_delivery"];
            var strdelivery = "";

            if (o_deliveryInfo == "조건부무료") { //쿠팡조건추가 2019-04-03
                strdelivery = o_deliveryInfo;
            } else if (o_minprice_delivery == 0) {
                strdelivery = "무료배송";
            } else {
                strdelivery = "배송비 " + numComma(o_minprice_delivery) + "원";
                if (mini_deliveryFlag) strdelivery += " 포함";
            }
            var o_imgUrl = listData["imgUrl"];
            var o_eventTxt = listData["eventTxt"];
            var o_telTxt = listData["telTxt"];
            var o_agree_monthTxt = listData["agree_monthTxt"];
            var o_powerFlag = listData["powerFlag"];
            var o_shopBidFlag = listData["shopBidFlag"];
            var o_bidTopClass = listData["bidTopClass"];
            var o_seller_ad = listData["seller_ad"];
            var o_CardEvent = listData["CardEvent"];
            var o_Price_card = listData["Price_card"];
            var o_CardName = listData["CardName"];
            var o_mallLinkUrl = listData["mallLinkUrl"];
            var o_logLinkUrl = listData["logLinkUrl"];
            var o_pl_no = listData["pl_no"];
            var o_goodsCode = listData["goodsCode"];
            var o_goodsName = listData["goodsName"];
            var o_Freeinterest = listData["Freeinterest"];
            var o_PlCoupon = listData["PlCoupon"];
            var o_CouponFlag = listData["CouponFlag"];
            var o_CouponUrl = listData["CouponUrl"];
            var o_CouponSale1 = listData["CouponSale1"];
            var o_CouponSale2 = listData["CouponSale2"];
            var o_option_flag = listData["option_flag"];
            var o_deliveryShowFlag = listData["deliveryShowFlag"];
            var o_CouponContents = listData["CouponContents"].replace(/\r\n/g, '<br>');
            var o_CouponURL = listData["CouponURL"];
            var o_OverseaDelivery = listData["OverseaDelivery"];
            var o_mobileOnly = listData["mobileOnly"];
            var deliveryprice = 0;
            if (!isNaN(o_deliveryInfo)) deliveryprice = o_deliveryInfo;
            var o_talminprice = o_minPrice;
            if (o_minPrice > o_instance_price) o_talminprice = o_instance_price;

            var deliveryIscollect = (strdelivery == "배송비유무료" || strdelivery == "착불" || strdelivery == "배송비유료") ? "N" : "Y";
            var cmdBridgeUrl ="";
            var cmdGoToUrl ="";
            if((o_shop_code == "5910") && (vNowtime >= minCheck) && (vNowtime <= maxCheck)){
                cmdGoToUrl = "clicklog();alert('해당 쇼핑몰은 현재 서비스 점검 중입니다.');return false;";
            }else{
                cmdGoToUrl = "clicklog();";
                //goPlnoItem(" + o_plno + ");";
                cmdBridgeUrl = bridgeUrl('move_link',o_shop_code,mini_modelno,mini_factory,o_pl_no,o_PlCoupon,o_minPrice,1);

            }
            html += "<li ";
            if (Index == (priceListObj.length - 1)) { html += " class=\"last\"" }
            html += ">";
            html += "	<div class=\"infopro_area\">";
            html += "		<span class=\"thumb\">";
            if((o_shop_code == "5910") && (vNowtime >= minCheck) && (vNowtime <= maxCheck)){
                html += "			<img src=\"" + o_imgUrl + "\" onclick=\""+cmdGoToUrl+"\" onerror=\"this.src='http://img.enuri.info/images/home/thum_none.gif'\" alt=\"\">";
            }else{
                html += "			<img src=\"" + o_imgUrl + "\" onclick=\"clicklog();window.open('" + cmdBridgeUrl + "')\" onerror=\"this.src='http://img.enuri.info/images/home/thum_none.gif'\" alt=\"\">";
            }

            html += "		</span>";
            html += "		<div class=\"proinfo\">";
            if((o_shop_code == "5910") && (vNowtime >= minCheck) && (vNowtime <= maxCheck)){
                html += "			<div class=\"modelname\" onclick=\""+cmdGoToUrl+"\">";
            }else{
                html += "			<div class=\"modelname\" onclick=\"clicklog();window.open('" + cmdBridgeUrl + "')\">";
            }
            html +=  o_goodsName;
            html += "			</div>";
            html += "			<div class=\"fixbt_info\">";
            html += "				<p class=\"lineprice";
            if (parseInt(mini_totalminprice) >= parseInt(o_minPrice) && (deliveryIscollect == "Y")) { html += " lowprice"; }
            html += "\">";
            if ((o_minPrice <= 0 && o_instance_price > 0) || o_mobileOnly == "Y") {
                html += "<span class=\"icon mobile\" type=\"2\"><em>모바일</em></span>";
            } else if ((o_instance_price > 0 && o_instance_price < o_minPrice && !mini_deliveryFlag) || (mini_deliveryFlag && o_instance_price > 0 && (parseInt(o_instance_price) + parseInt(deliveryprice)) < o_minPrice)) {
                html += "				<span class=\"mobileSendLayer icon mobile\" type=\"1\"><em>모바일</em></span>";
            }
            if((o_shop_code == "5910") && (vNowtime >= minCheck) && (vNowtime <= maxCheck)){
                html += "				<a href=\"javascript:///\" onclick=\""+cmdGoToUrl+"\">";
            }else{
                html += "				<a href=\""+cmdBridgeUrl+"\" target=\"_blank\" onclick=\"clicklog();\">";
            }
            if (parseInt(mini_totalminprice) >= parseInt(o_minPrice) && (deliveryIscollect == "Y")) {
                html += "				<span class=\"low\">최저가</span>";
            }
            html += "					<strong>";
            if (mini_cardeventFlag && o_CardEvent != "") { html += numComma(o_Price_card) } else { html += numComma(o_minPrice) }
            html += "</strong>원</a></p>";
            html += "				<p class=\"etcinfo\"><span>" + strdelivery + "</span><span>" + o_shop_name + "</span></p>";
            /*if(o_CardEvent!=""){
            	html += "			<p class=\"crcard\">"+o_CardEvent+"</p>"
            }*/
            if (mini_cardeventFlag) {
                html += "				<span class=\"crcard\">" + o_CardName + "</span>";
            }
            html += "			</div>";
            html += "		</div>";
            html += "	</div>";
            html += "	<!-- top 버튼, 4행 미만일 시 비노출 -->";
            html += "</li>";

            itemlistObj.append(html);
            if (mini_shopListAll == 'NO' && (priceListObj.length >= mini_limtShowLine)) {
                $("#list_more").show();
            } else {
                $("#list_more").hide();
            }

            if (mini_shopListAll == "YES") mini_loadingHide();
        });
    } else {
        html = "";
        html += "<li class=\"nomall\"><!-- 쇼핑몰이 없는 경우 class=\"nomall\" 추가 -->";
        html += "<!-- itembox -->";
        html += "<div class=\"itembox\">";
        html += "<p>" + nomall_msg + "</p>";
        html += "</div>";
        html += "<!-- //itembox -->";
        html += "</li>";

        itemlistObj.append(html);

        //sideObj.show();
    }

}

function loadCashList(modelno) {
    var param = {
        "modelno": modelno,
        "listType": mini_listType
    };

    $.ajax({
        type: "get",
        url: "/lsv2016/ajax/detail/getCashGoodsList_ajax.jsp",
        data: param,
        dataType: "json",
        success: function(json) {

            if (json.cash_pricelist_cnt != 0) {

                if (json.cash_pricelist.length > 0) {
                    loadCashListView(json);
                } else {
                    $("#mini_cashpricelist_area").hide();
                }
            } else {
                $("#mini_cashpricelist_area").hide();
            }
        },
        error: function(xhr, ajaxOptions, thrownError) {
            //alert(xhr.status);
            //alert(thrownError);
        }
    });
}

function loadCashListView(json) {
    var cashListCnt = json["cash_pricelist_cnt"];
    var cashList = json["cash_pricelist"];
    var cashShopName = "";
    var cashShopCode = "";
    var cashPrice = "";
    var cashGoodsName = "";
    var cashDeliveryPrice = "";
    var cashUrl = "";
    var cashDeliveryInfo = "";
    var cashDeliveryInfo2 = "";
    var cashDeliveryType2 = "";
    var cashDisplayDelivery = "";
    var cashInstancePrice = 0;
    var cashPlno = "";
    var cashGoodsCode = "";
    var html = "";
    var cashListObj = $("#cash_pricelist").find(".tbody");
    var cmdGoToUrl = "";
    var displayCss = "";
    if (cashListCnt > 0 && cashList != null && cashList.length > 0) {
        $.each(cashList, function(index, listData) {
            if (index > 3) return false;
            cashShopCode = listData["shop_code"];
            cashShopName = listData["shop_name"];
            cashPrice = listData["price"];
            cashInstancePrice = listData["instance_price"];
            cashGoodsName = listData["goodsnm"];
            cashDeliveryPrice = listData["pc_displaydelivery"];
            cashUrl = listData["url"];
            cashDeliveryInfo = listData["deliveryinfo"];
            cashDeliveryInfo2 = listData["deliveryinfo2"];
            cashDeliveryType2 = listData["deliverytype2"];
            cashGoodsCode = listData["cashGoodsCode"];
            cashPlno = listData["pl_no"];
            cashPrice = (mini_listType == 1) ? numComma(cashPrice) : numComma(cashPrice + cashDeliveryInfo2);
            displayCss = (index < 4) ? "" : "style = \"display:none\" ";

            if (cashDeliveryInfo == "조건부무료") {
                cashDisplayDelivery = cashDeliveryInfo;
            } else if (cashDeliveryPrice == 0) {
                cashDisplayDelivery = "무료배송";
            } else if ($.isNumeric(cashDeliveryPrice)) {
                cashDisplayDelivery = numComma(cashDeliveryPrice) + "원";
            } else {
                cashDisplayDelivery = cashDeliveryPrice;
            }

           var cmdBridgeUrl = bridgeUrl('move_link',cashShopCode,mini_modelno,mini_factory,cashPlno,0,cashPrice,1);
            html += "<li " + displayCss + " >";
            html += "	<div class=\"itembox\">";
            html += "		<p class=\"mallinfo\">";
            html += "			<a class=\"mallname\" href=\""+cmdBridgeUrl+"\" target=\"_blank\" ><strong>" + cashShopName + "</strong></a>";
            html += "		</p>";
            html += "		<p class=\"priceline\">";
            html += "			<a href=\""+cmdBridgeUrl+"\" target=\"_blank\"><span class=\"prcash\">현금</span><span class=\"pricepack\"><strong>" + cashPrice + "</strong>원</span></a>";
            html += "		</p>";
            html += "		<p class=\"delivery\">";
            html += "			<a href=\""+cmdBridgeUrl+"\" target=\"_blank\">" + cashDisplayDelivery + "</a>";
            html += "		</p>";
            html += "	</div>";
            html += "</li>";
        });
        $("#mini_cashpricelist_area").find(".tbody ul").html(html);
        $("#mini_cashpricelist_area").show();
        if (cashListCnt > 5) {
            $("#mini_cashpricelist_area").find(".list_more").show();
        }
        $("#mini_cashpricelist_area").find(".list_more").unbind("click");
        $("#mini_cashpricelist_area").find(".list_more").click(function() {
            $("#mini_cashpricelist_area").find(".tbody ul li").show();
            if (mini_modelno != "")  goMore_Modelno(mini_modelno,"");
        });
    } else {
        $("#mini_cashpricelist_area").hide();
    }
}

function goModelnoNew(modelno) {
    var openWindow = window.open("about:blank");
    openWindow.location.href = "/detail.jsp?modelno=" + modelno;
}

function goMore_Modelno(modelno, opentype) {
    var openWindow1 = window.open("about:blank");
    var open_url = "/detail.jsp?modelno=" + modelno + "&goodsBbsOpenType=" + opentype;
    openWindow1.location.href = open_url;
}

var mini_bannerinfo = false;

function loadBanner(bannerpos) {
    var bannerObj = $('#miniVIP_AREA').find('.ad_banner');
    var onlive = true;

    var varMiniVipUrl = "http://ad-api.enuri.info/enuri_PC/pc_vip/C3/req?cate=" + mini_szCategory4;

    $.getJSON(varMiniVipUrl, function(jsonObj) {
            var miniVipImg = jsonObj.IMG1;
            var miniVipUrl = jsonObj.JURL1;
            var miniVipTarget = jsonObj.TARGET;
            var miniVipAlt = jsonObj.ALT;
            var html = "";
            mini_bannerinfo = true;

            if (mini_bannerinfo && miniVipImg != "" && miniVipUrl != "") {
                bannerObj.find('img').attr("src", miniVipImg);
                bannerObj.find('#gourl').unbind();
                bannerObj.find('#gourl').click(function() {
                    window.open(miniVipUrl, '', '');
                    insertLog(15066);
                    return false;
                });

                bannerObj.css("height", 29 + "px");
                if ($('#bisic_compare').attr('class').indexOf("on") > -1) {
                    bannerObj.show();
                } else {
                    bannerObj.hide();
                }
            } else {
                bannerObj.css("height", 0);
                bannerObj.hide();
            }

        });
}

function closeMinVip() {
    $('#miniVIP_AREA').hide();
}
/* 
function setMiniMobileSendProdDiv() {
    var type = "";
    // 모바일 전용상품 및 모바일 최저가 상품 레이어 보여주기
    var basicDivObj = $("#miniVIP_AREA");
    basicDivObj.find(".mobile").unbind();
    basicDivObj.find(".mobile").click(function() {
        type = $(this).attr("type");
        if (type == 1) insertLog(15047);
        else insertLog(15052);
        MinimobileSendProdDivShow(type, this);
    });


    var mobileSendProdDivObj = $("#mobileSendProdDiv");
    mobileSendProdDivObj.css("z-index", "10001");

    // 닫기 이벤트
    mobileSendProdDivObj.find(".close").unbind();
    mobileSendProdDivObj.find(".close").click(function() {
        mobileSendProdDivHide();
    });

    // 핸드폰 전송 하단 레이어 열기
    mobileSendProdDivObj.find(".smsp").unbind();
    mobileSendProdDivObj.find(".smsp").click(function() {
        mobileSendProdDivObj.find(".boxly_b").toggle();
        if (type == 1) insertLog(15049);
        else insertLog(15054);
    });

    // 찜하기 체크박스
    mobileSendProdDivObj.find(".mobileSendCheck").unbind();
    mobileSendProdDivObj.find(".mobileSendCheck").click(function() {
        insertZzimProc(mini_modelno);
        if (type == 1) insertLog(15048);
        else insertLog(15053);
    });

    // 에누리앱 설치
    mobileSendProdDivObj.find(".app").unbind();
    mobileSendProdDivObj.find(".app").click(function() {
        goLocatonNewWindow("/common/jsp/App_Landing.jsp");
        if (type == 1) insertLog(15050);
        else insertLog(15055);
    });

    // 핸드폰 번호 전송
    mobileSendProdDivObj.find(".btn_send").unbind();
    mobileSendProdDivObj.find(".btn_send").click(function() {
        var phoneTxt = mobileSendProdDivObj.find(".phoneNum").val();
        var listItemObj = $("#modelno_" + mobileSendSelModelno);

        if (listItemObj.length < 1) {
            if ($("modelnoGroup_" + mobileSendSelModelno).length > 0) {
                listItemObj = $("modelnoGroup_" + mobileSendSelModelno).parents("prodItem");
            }
        }

        var title = mini_szModelNm;

        sendDetailSms(phoneTxt, "detail", title)

        mobileSendProdDivObj.find(".phoneNum").val("");
        if (type == 1) insertLog(15051);
        else insertLog(15056);


    });
}

// SMS보내가
function sendDetailSms(phoneTxt, part, title) {
    var myphone = phoneTxt;
    var rurl;
    
    console.log( "phoneTxt : " + phoneTxt );
    console.log( "part : " + part );
    console.log( "title : " + title );

    if (myphone == "") {
        alert("휴대폰 번호가 입력되지않았습니다.");
        return;
    }

    var rgEx = /(01[016789])(\d{4}|\d{3})\d{4}$/g;
    var chkFlg = rgEx.test(myphone);

    if (!chkFlg) {
        alert("잘못된 형식의 휴대폰 번호입니다.");
        return;
    }

    rurl = encodeURIComponent("http://m.enuri.com/mobilefirst/detail.jsp?_qr=y&modelno=" + mobileSendSelModelno + "&hoticon=-1");

    if (rurl != "") {
        rurl = rurl.replace(/\?/ig, "--***--");
        rurl = rurl.replace(/\&/ig, "--**--");
        document.getElementById("hFrame").src = "/common/jsp/Ajax_ListHeader_Sms_Proc.jsp?part=" + part + "&rurl=" + rurl + "&phoneno=" + myphone + "&title=" + encodeURIComponent(title);
    } else {
        alert("주소를 읽어오지 못했습니다.");
    }
}

var mobileSendSelModelno = "";

function MinimobileSendProdDivShow(type, thisObject, modelno, price) {
    if (typeof(price) == 'undefined') price = 0;
    var mobileSendProdDivObj = $("#mobileSendProdDiv");

    // 토글
    if (mobileSendProdDivObj.css("display") != "none") {
        mobileSendProdDivHide();

        return;
    }

    var thisObj = $(thisObject);
    var top = thisObj.offset().top + thisObj.height() + 3;
    var left = thisObj.offset().left - mobileSendProdDivObj.width() + thisObj.width();

    if (left < mobileSendProdDivObj.width()) left = thisObj.offset().left;

    if (type == "1") {
        mobileSendProdDivObj.find("h4").html("모바일 최저가 상품");
        mobileSendProdDivObj.find(".m_txt p").html("본 상품은 <b>모바일로 구매 시 더 저렴</b>합니다.<br />찜/핸드폰 전송 또는 QR코드를 스캔하여<br />모바일에서 최저가를 확인하세요.");
    }
    if (type == "2") {
        mobileSendProdDivObj.find("h4").html("모바일 전용 상품");
        mobileSendProdDivObj.find(".m_txt p").html("모바일에서만 구매할 수 있는 모바일 전용<br />상품 입니다. 찜/핸드폰 전송 또는 QR코드를<br />스캔하여 모바일에서 최저가를 확인하세요.");
    }

    mobileSendProdDivObj.css("top", top + "px");
    mobileSendProdDivObj.css("left", left + "px");
    mobileSendProdDivObj.show();

    if (typeof(modelno) == 'undefined') mobileSendSelModelno = mini_modelno;
    else mobileSendSelModelno = modelno;

    // 찜 했을 경우 체크 박스의 체크를 표시함
    var zzimChecked = "";
    if (mini_bZzim == 'true') zzimChecked = "checked";
    mobileSendProdDivObj.find(".mobileSendCheck").prop("checked", zzimChecked);

    // 클릭한 모델의 qr코드 생성
    setQrCodeImg();
}

// 모델에서 휴대폰 아이콘 클릭시 qr코드를 생성함
var qrCodeResetTryCnt = 0;

function setQrCodeImg(type) {
    if (typeof(type) == 'undefined') type = 0;
    var newDate = new Date();
    var qrName = newDate.getTime();
    var mobileSendProdDivObj = $("#mobileSendProdDiv");
    if (type == 1) mobileSendProdDivObj = $("#shoppingSendLayerDiv");
    var qrImgSrc = mobileSendProdDivObj.find(".boxly .qrcode img").attr("src");

    if (mobileSendSelModelno == "") mobileSendSelModelno = mini_modelno;
    if (qrImgSrc == "") {
        mobileSendProdDivObj.find(".boxly .qrcode img").css("visibility", "hidden");
        mobileSendProdDivObj.find(".boxly .qrcode img").attr("src", "/view/qrcode/qr_model_" + mobileSendSelModelno + ".png?v=" + (new Date()).getTime());
    }
    mobileSendProdDivObj.find(".boxly .qrcode img").error(function() {
        makeQr2(type);
    });
}

function makeQr2(type) {
    var mobileSendProdDivObj = $("#mobileSendProdDiv");
    if (type == 1) mobileSendProdDivObj = $("#shoppingSendLayerDiv");
    var newDate = new Date();
    var qrName = newDate.getTime();
    if (qrCodeResetTryCnt < 5) { //5회까지만 생성 재시도
        qrCodeResetTryCnt++;

        function showQr() {
            setTimeout(function() {
                mobileSendProdDivObj.find(".boxly .qrcode img").attr("src", "/view/qrcode/qr_model_" + mobileSendSelModelno + ".png?v=" + qrName);
                mobileSendProdDivObj.find(".boxly .qrcode img").error(function() {
                    makeQr2();
                });
            }, 1000);
        }
        var aUrl = "/view/make_qr2.jsp";
        var param = "";
        param += "&url=" + encodeURIComponent("http://m.enuri.com/mobilefirst/detail.jsp?_qr=y&modelno=" + mobileSendSelModelno + "&hoticon=-1");
        param = param + "&t=qr_model_" + mobileSendSelModelno;
        //console.log(param);
        $.ajax({
            type: "get",
            url: aUrl,
            async: true,
            data: param,
            dataType: "json",
            success: function(json) {
                showQr();
            },
            error: function(xhr, ajaxOptions, thrownError) {
                //alert(xhr.status);
                //alert(thrownError);
            }
        });
    } else {
        return;
    }
}

function insertZzimProc(modelno, mb) {
    minisetZzimCompDiv();
    if (typeof(modelno) == 'undefined') modelno = mini_modelno;
    if (typeof(mb) == 'undefined') mb = "";
    if (!islogin()) {
        //Cmd_Login('detailinputzzim');
        var rtnUrl = document.location.href + "&mvShowModelno=" + mini_modelno + "&miniVipTab=1";
        Cmd_Login('detailinputzzim', rtnUrl);
    } else {
        $.ajax({
            type: "get",
            url: "/view/include/insertSaveGoodsProc.jsp",
            data: "modelnos=" + modelno,
            dataType: "json",
            success: function(result) {
                var varCount = parseInt(result["count"]);
                if (varCount == 0) {
                    if (!confirm("이미 찜한 상품입니다.\n해지하겠습니까?")) {
                        return;
                    } else {
                        delteZzimProc(modelno);
                    }
                    //setTimeout(function(){$('#div_save_msg_already').hide();},3000);
                } else if (varCount > 0) {
                    fn_banner_info();
                    minizzimCompDivShow(modelno, mb);
                    setTimeout(function() { zzimCompDivHide(); }, 3000);
                }
            },
            error: function(request, status, error) {}
        });
    }
}

//찜완료를 위한 레이어의 기본 세팅
function minisetZzimCompDiv() {
    var zzimCompDivObj = $("#zzimCompDiv");

    zzimCompDivObj.find(".zzimlist").unbind();
    zzimCompDivObj.find(".zzimlist").click(function() {
        goLocatonNewWindow("/view/resentzzim/resentzzimList.jsp?listType=2");
    });

    zzimCompDivObj.find(".close").unbind();
    zzimCompDivObj.find(".close").click(function() {
        zzimCompDivHide();
    });
}

// 찜 완료 창 열기
// modelnoObj.image : 이미지 경로
// modelnoObj.price : 가격
// modelnoObj.name : 상품명
function minizzimCompDivShow(zzimModelno, mb) {
    if (zzimModelno.toString().length > 0) {
        var url = "/lsv2016/ajax/getCompareProdList_ajax.jsp";
        var param = {
            "random_seq": random_seq,
            "goodsNumList": "G" + zzimModelno
        }

        $.ajax({
            type: "get",
            url: url,
            async: true,
            data: param,
            dataType: "json",
            success: function(json) {
                var goodsCnt = json["goodsCnt"];
                var goodsListObj = json["goodsList"];
                var html = "";
                var showModelno = "";
                var showPriceStr = "";
                var showImageUrl = "";
                $.each(goodsListObj, function(Index, listData) {
                    var prodNo = listData["prodNo"];
                    var modelno = listData["modelno"];
                    var p_pl_no = listData["p_pl_no"];
                    var minPriceText = listData["minPriceText"];
                    var minprice = listData["minprice"];
                    var minprice3 = listData["minprice3"];
                    var mallcnt = listData["mallcnt"];
                    var mallcnt3 = listData["mallcnt3"];
                    
                    var goods_info = listData["goods_info"];
                    var sale_cnt = listData["sale_cnt"];
                    var ca_code = listData["ca_code"];
                    var modelnm = listData["modelnm"];
                    var factory = listData["factory"];
                    var brand = listData["brand"];
                    var strFreeinterest = listData["strFreeinterest"];
                    var c_date = listData["c_date"];
                    var c_dateStr = listData["c_dateStr"];
                    var moddate = listData["moddate"];
                   
                    var smallImageUrl = listData["smallImageUrl"];
                   
                    var gb1_no = listData["gb1_no"];
                    var kb_num = listData["kb_num"];
                    var kb_title = listData["kb_title"];
                    var url1 = listData["url1"];
                    var keyword2 = listData["keyword2"];
                    var modelCateLink = listData["modelCateLink"];
                    var strCategoryName = listData["strCategoryName"];
                    var goodscode = listData["goodscode"];
                   

                    showModelno = modelno;
                    showPriceStr = minprice.format();
                    showImageUrl = smallImageUrl;

                });

                var zzimCompDivObj = $("#zzimCompDiv");
                var zzimPriceStr = "";
                var bodyObj = $("body");

                var ua = window.navigator.userAgent;
                var bodyTop = document.documentElement ? document.documentElement.scrollTop : document.body.scrollTop;
                if (ua.indexOf('Chrome') != -1) {
                    bodyTop = $(window).scrollTop();
                }

                var top = bodyTop + bodyObj.height() / 2 - zzimCompDivObj.height() / 2;
                var left = bodyObj.width() / 2 - zzimCompDivObj.width() / 2;

                // 일반 상품일 경우
                if (showModelno == "0") {
                    zzimPriceStr = "<b>" + showPriceStr + "</b>원";
                } else {
                    zzimPriceStr = "최저가<b>" + showPriceStr + "</b>원";
                }

                zzimCompDivObj.find(".zzimProdImage").attr("src", showImageUrl);
                if (mb == "mb") zzimCompDivObj.find(".m_txt p").html("<p>선택하신 상품 찜이 완료 되었습니다.<br /> 에누리 <b>모바일에서 찜 상품을 확인</b>해보세요.</p>");
                else zzimCompDivObj.find(".m_txt p").html("<p>선택하신 상품<br />찜이 완료 되었습니다.</p>");
                zzimCompDivObj.find(".zzim_price").html(zzimPriceStr);

                zzimCompDivObj.css("top", top + "px");
                zzimCompDivObj.css("left", left + "px");
                zzimCompDivObj.show();
            },
            error: function(request, status, error) {
                //console.log("request : " + request + "status : " + status + "error : " + error);
            }
        });
    }
}

function zzimCompDivHide() {
    var zzimCompDivObj = $("#zzimCompDiv");

    zzimCompDivObj.hide();
}


function delteZzimProc(modelno) {
    if (typeof(modelno) == 'undefined') modelno = mini_modelno;
    if (!islogin()) {
        //Cmd_Login('detailinputzzim');
        var rtnUrl = document.location.href + "&mvShowModelno=" + mini_modelno + "&miniVipTab=1";
        Cmd_Login('detailinputzzim', rtnUrl);
    } else {
        $.ajax({
            type: "get",
            url: "/view/deleteSaveGoodsProc.jsp",
            data: "modelnos=" + modelno + "&tbln=save",
            dataType: "json",
            success: function(result) {},
            error: function(request, status, error) {}
        });
        if ($('.right_units .zzim')) $('.right_units .zzim').removeClass('on');
    }
}

function mobileSendProdDivHide() {
    var mobileSendProdDivObj = $("#mobileSendProdDiv");

    mobileSendProdDivObj.hide();

    mobileSendSelModelno = "";

    mobileSendProdDivObj.find(".boxly .qrcode img").attr("src", "");
} */

function mini_loadingShow() {
    $('#miniloadingDiv').show();
}

function mini_loadingHide() {
    $('#miniloadingDiv').hide();
}

function clicklog(logflag) {
    if (typeof(mini_szCategory4) != 'undefined') {
        //insertLogCate(14515,mini_szCategory4);
        if ($('#mimi_bisic_compare').attr('class').indexOf("on") > -1) insertLogCate(15418, mini_szCategory4);
        else insertLogCate(15075, mini_szCategory4);
    }
    if (typeof(logflag) == "undefined") logflag = 0;
    //1: 상위입찰 적용 상품 클릭 수_우측, 2 : 상위입찰 적용 상품 클릭 수_좌측, 3: 미니미니 쇼핑몰 상위입찰
    if (logflag == 1) insertLog(15076);
    if (logflag == 2) insertLog(15077);
    if (logflag == 3) insertLog(15547);
}

function getMiniSpec() {
    var template = "";
    template += "<div style=\"display:none\" class=\"thum_area\">";
    template += "<img style=\"display:none\" class=\"listShowImg\" src=\"\">";
    template += "<em style=\"display:none\" class=\"prodName\"></em>";
    template += "</div>";
    $.ajax({
        type: "GET",
        url: "/lsv2016/ajax/detail/getMinidetailSpec_ajax.jsp",
        data: "modelno=" + mini_modelno + "&szCategory=" + mini_szCategory,
        dataType: "JSON",
        success: function(json) {
            var detailSpecObj = json["detailSpec"];
            var spec_tbodyObj = $("#spec_tbody");
            spec_tbodyObj.data("model-origin", mini_modelno);
            spec_tbodyObj.data("dtype", "mini_vip");
            spec_tbodyObj.data("cate", mini_szCategory);
            spec_tbodyObj.addClass("prodItem");
            spec_tbodyObj.html(null);
            if (detailSpecObj != null) {
                $.each(detailSpecObj, function(Index, listData) {
                    var specGroupname = listData["specGroupname"];
                    var specCellcnt = listData["specCellcnt"];
                    var specContent = listData["specContent"];
                    var specTitle = listData["specTitle"];
                    var att_id = listData["att_id"];
                    var att_el_id = listData["att_el_id"];
                    var att_kbno = listData["att_kbno"];
                    var att_el_kbno = listData["att_el_kbno"];
                    if (specGroupname.length > 0) {
                        template += "<tr><th>" + specGroupname + "</th><th></th></tr>";
                    }
                    template += "<tr>";
                    if (specTitle != "") {
                        if (att_kbno > 0) {
                            template += "<td";
                            if (specCellcnt > 1) { template += " rowspan=\"" + specCellcnt + "\""; }
                            //template += "><a class='attr' href='javascript:///' onclick='insertLogCate(15389);showTermDic(" + att_id + ", 0, this);return false;'>" + specTitle + "</a></td>";
							template += "><a class='attr' href='javascript:///' class=\"btn--dic\" data-attr_id=\"" + att_id + "\" data-attr_el_id=\"0\" onclick=\"parent.showDicLayer(this);insertLogCate(15389);return false;\">" + specTitle + "</a></td>";
                        } else {
                            template += "<td";
                            if (specCellcnt > 1) { template += " rowspan=\"" + specCellcnt + "\""; }
                            template += ">" + specTitle + "</td>";
                        }
                    }

                    if (att_el_kbno > 0) {
                        //template += "<td><a class='attr' href='javascript:///' onclick='insertLogCate(15389);showTermDic(" + att_id + ", " + att_el_id + ", this);return false;'>" + specContent + "</a></td>";
						template += "<td><a class='attr' href='javascript:///' class=\"btn--dic\" data-attr_id=\"" + att_id + "\" data-attr_el_id=\"" + att_el_id + "\" onclick=\"parent.showDicLayer(this);insertLogCate(15389);return false;\">" + specContent + "</a></td>";
                    } else {
                        template += "<td>" + specContent + "</td>";
                    }

                    template += "</tr>";
                    if (template.length > 1) {
                        template = template.replace(/&amp;/gi, "&");
                        spec_tbodyObj.html(template);
                        spec_tbodyObj.find(".thum_area .listShowImg").attr("src", mini_strImageUrl);
                        spec_tbodyObj.find(".prodName").html(mini_szModelNm);
                    } else {
                        $("#spec_table").hide();
                    }
                });
            } else {
                $("#basic_spec").hide();

                //도서인경우 저자명노출
                if (mini_szCategory.length >= 2 && mini_szCategory.substring(0, 2) == "93") $("#book_spec").find('.array').html(mini_spec);
                else $("#book_spec").find('.array').hide();

                $("#book_spec").show();
                $("#book_spec").find('.btn_sq').click(function() {
                    goModelnoNew(mini_modelno);
                    insertLog(15391);
                });
            }
        },
        error: function(xhr, ajaxOptions, thrownError) {
            //alert(xhr.status);
            //alert(thrownError);
        }
    });
}

function getMiniGoods_caution() { //주의사항
    var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi;
    var param = {
        "view_type": 4,
        "ca_code": mini_szCategory,
        "modelnos": mini_modelno,
        "modelnm": mini_szModelNm.replace(regExp, ''),
        "factory": mini_factory,
        "brand": mini_brand,
        "spec": ""
            //"spec" : spec
    }
    $('#mini_caution').hide();
    $('#mini_caution').html("");
    $.ajax({
        type: "get",
        url: "/lsv2016/ajax/detail/getCautionInfo_ajax.jsp",
        async: true,
        data: param,
        dataType: "json",
        success: function(json) {
            var title_type = json["title_type"];
            var title = json["title"];
            var content_list = json["content_list"];
            var content_type = json["content_type"];
            var img = json["img"];
            var imgmap_list = json["imgmap_list"];
            var caution_html = "";
            if (content_list && content_list.length > 0) {
                if (content_type == 1) {
                    if (title_type < 2) {
                        if (title_type == 1) {
                            caution_html += "<dt class=\"txt\"><strong>" + title + "</strong></dt>";
                        } else {
                            caution_html += "<dt class=\"txt\"><strong>주의사항</strong></dt>";
                        }
                    }

                    $.each(content_list, function(Index, listData) {
                        var o_content = listData["content"];
                        caution_html += "<dd><em>*</em>" + o_content + "</dd>";
                    });

                }
                /*else if(content_type==2){
                	caution_html += "<img src=\"http://storage.enuri.info/pic_upload/caution/"+img+"\"  usemap=\"#Map\" style=\"width:970px;\">";
                	caution_html += "<map name=\"Map\">";
                	$.each(imgmap_list, function(Index, listData) {
                		var o_img_map = listData["img_map"];
                		var o_map_url = listData["map_url"];
                		var o_open_type = listData["open_type"];
                		if(o_img_map!=""){
                			caution_html += "<area shape=\"rect\" coords=\""+o_img_map+"\" href=\""+o_map_url+"\""; if(o_open_type==1){caution_html+="target=\"_blank\""} caution_html+=">";
                		}
                	});

                	caution_html += "</map>"
                }*/
                $('#mini_caution').html(caution_html);
                $('#mini_caution').show();

            }
            load_explain_caution = true;
        },
        error: function(xhr, ajaxOptions, thrownError) {
            //alert(xhr.status);
            //alert(thrownError);
        }
    });
}

function getMiniBbs() {
    var html = "";

    $.ajax({
        type: "GET",
        url: "/lsv2016/ajax/detail/goods_bbs_list_ajax.jsp",
        data: "modelno=" + mini_modelno + "&pType=ML",
        dataType: "JSON",
        success: function(json) {
            var bbsListObj = json["list"];
            var bbsTotalCnt = json["iTotalCnt"];
            if (bbsTotalCnt > 31) {
                $("#bbs_list_more").show(); //더보기
                $("#bbs_list_more").click(function() {
                    goMore_Modelno(mini_modelno, "2");
                });
            } else {
                $("#bbs_list_more").hide(); //더보기
            }
            $("#tab03_cnt").html("(" + bbsTotalCnt + ")");
            var com_listObj = $("#com_list ul");
            if (bbsListObj != null) {
                $.each(bbsListObj, function(Index, listData) {
                    var contents = listData["contents"];
                    var shop_name = listData["shop_name"];
                    var regdate = listData["regdate"].replace(/[.]/gi, "-");
                    var usernm = listData["usernm"];

                    html += "<li id=\"mbbs_" + (Index + 1) + "\">";
                    html += "	<div class=\"artic_ments\">";
                    html += contents;
                    html += "	</div>";
                    html += "	<div class=\"artic_info\">";
                    html += "		<strong class=\"shop\">" + shop_name + "</strong>";
                    html += "		<p class=\"subinfo\">";
                    html += "			<span class=\"date\">" + regdate + "</span> | <span class=\"write\">" + usernm + "</span>";

                    var delClass = "";
                    if (listData["delBtnFlag"] == "1") {
                        delClass = "mine";
                    }

                    if (delClass != "") {
                        html += "		| <a href=\"javascript:;\" class=\"btn_del delGoodsBbs\" data-no=\""+listData["no"]+"\" data-modelno=\""+listData["modelno"].trim()+"\">삭제하기</a>";
                        html += "		<input type=\"hidden\" id=\"no\" name=\"no\" value=\"" + listData["no"] + "\"></a>";
                    }
                    html += "		</p>";
                    html += "	</div>";
                    html += "</li>";

                    if (html.length > 1) {
                        com_listObj.html(html);
                        com_listObj.show();
                    } else {
                        com_listObj.hide();
                    }

                    /* 삭제 버튼 */
                    $(".delGoodsBbs").click(function() {
                        var delno = $(this).data("no");
                        var delmodelno = $(this).data("modelno");
                        if(mini_SNSTYPE=="K" || mini_SNSTYPE=="N"){
                            alert("삭제하시겠습니까?");
                            fn_sns_goods_bbs_delete(delmodelno,delno);
                        }else{
                            $("#del_pass").val("");
    
                            var lStyle = "display:block;";
                            //lStyle += "top:" + ($(this).parent().parent().parent().position().top + $(this).position().top) + "px;";
                            //lStyle += "left:" + ($(this).position().left + 62) +"px;";
    
                            $("#boardDelLayer").attr("style", lStyle);
                            $("#del_modelno").val(delmodelno);
                            $("#del_no").val(delno);
                        }
                    });
                });
            } else {
                com_listObj.hide();
                $("#bbs_nocom").show();

            }
        },
        error: function(xhr, ajaxOptions, thrownError) {
            //alert(xhr.status);
            //alert(thrownError);
        }
    });
}

$("#gbBtnWrite").click(function() {
    //fn_goods_top_bg_remove();
    fn_goods_bbs_insert();
    insertLog(15392);
});

/* 댓글 저장 */
var insertFlag = true;

function fn_goods_bbs_insert() {
    
    if (miniIsLogin() == false) {
        //alert("로그인을 하시면 글을 작성할 수 있습니다.");
        //Cmd_Login('miniBbs');
        var rtnUrl = document.location.href + "&mvShowModelno=" + mini_modelno + "&miniVipTab=3";
        Cmd_Login('miniBbs', rtnUrl);
    } else {
        if (!insertFlag) {
            alert("등록중입니다. 잠시만 기다려주세요.");
            return;
        }

        if ($("#gbContent").val() == "") {
            alert("내용을 입력해 주세요.");
            $("#gbContent").focus();
            return;
        }

        $("#gbContent").val($("#gbContent").val().replaceAll("&", "&amp;").replaceAll("<", "&lt").replaceAll(">", "&gt").replaceAll("\"", "&quot"));

        if ($("#gbContent").val().length >= 2000) {
            alert("2000자 이상은 입력 하실 수 없습니다.");
            $("#gbContent").focus();
            return;
        }

        if ($("#gbContent").val().length < 5) {
            alert("5자 이상 내용을 입력하셔야 등록이 가능합니다.");
            $("#gbContent").focus();
            return;
        }

        insertFlag = false;
        var strContents = encodeURIComponent($("#gbContent").val(), "UTF-8");
        $.ajax({
            type: "POST",
            url: "/lsv2016/ajax/detail/goods_bbs_list_ajax.jsp",
            data: "modelno=" + mini_modelno + "&pType=GI&contents=" + strContents,
            dataType: "JSON",
            success: function(result) {
                insertFlag = true;

                if (result.flag) {
                    $("#gbContent").val("");
                    alert("정상적으로 저장 되었습니다.");
                    //gbPage = 1;
                    getMiniBbs();
                } else {
                    alert("저장 실패 하였습니다.");
                }
            },
            error: function(request, status, error) {
                //console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            }
        });
    }
}

/* 사용자 로그인 여부 */
function fn_userInfoSet(sId, tFlag) {
    var wHtml = "";

    if (sId != "") {
        wHtml += "<ul class=\"idpw\">";
        wHtml += "	<li><em>작성자</em><a class=\"writer lwLayer\" href=\"javascript:;\" >" + sId + "</a>";
        wHtml += "</ul>";

        if (tFlag == "G") $("#gbContent").attr("placeholder", "상품평을 작성해보세요.");
        else if (tFlag == "E") $("#evContent").attr("placeholder", "20글자 이상 300글자 이내로 작성하여 주세요.");

    } else {
        //mini_bbs_login();
        wHtml += "<a href=\"javascript:///\" class=\"login\" id=\"btn_login\">로그인</a>";
        if (tFlag == "G") $("#gbContent").attr("placeholder", "로그인을 하시면 글을 작성할 수 있습니다.");
    }
    $(".logininfo").html(wHtml);

    $(".lwLayer").click(function() {
        //$("#membInfoLayer").show();
        $("#membInfoLayer strong").html(sId);
        insertLog(15393);

        var lStyle = "display:block;";
        lStyle += "height:103px;";

        $("#membInfoLayer").attr("style", lStyle);
    });

    $("#btn_login").click(function() {
        mini_bbs_login();
        insertLog(15394);
    });

    $("#gbContent").click(function() {
        if (miniIsLogin() == false) {
            //alert('로그인을 하시면 글을 작성할 수 있습니다.');
            //Cmd_Login('miniBbs');
            var rtnUrl = document.location.href + "&mvShowModelno=" + mini_modelno + "&miniVipTab=3";
            Cmd_Login('miniBbs', rtnUrl);
        }
    });
}

function fn_malllayerClose(closeLayer) {
    $(closeLayer).hide();
}

$(".btnclose").click(function() {
    fn_malllayerClose('#membInfoLayer');
});

function mini_bbs_login() {
    if (miniIsLogin() == false) {
        //Cmd_Login('miniBbs');
        var rtnUrl = document.location.href + "&mvShowModelno=" + mini_modelno + "&miniVipTab=3";
        Cmd_Login('miniBbs', rtnUrl);
    }
}

function miniIsLogin() {
    var cName = "LSTATUS";
    var s = document.cookie.indexOf(cName + '=');
    if (s != -1) {
        s += cName.length + 1;
        e = document.cookie.indexOf(';', s);
        if (e == -1) {
            e = document.cookie.length
        }
        if (unescape(document.cookie.substring(s, e)) == "Y") {
            return true;
        } else {
            return false;
        }
    } else {
        return false;
    }
}

/* 게시물 삭제 */
$("#goodsBbsDel").click(function() {
    fn_goods_bbs_delete();
});

$("#bbs_delPassClose").click(function() {
    $("#boardDelLayer").hide();
});
function fn_sns_goods_bbs_delete(modelno,delNo) {

	$.ajax({
		type:"get",
		url: "/lsv2016/ajax/detail/goods_bbs_list_ajax.jsp",
		data:"modelno=" + modelno + "&del_no=" + delNo + "&pType=SGD",
		dataType: "JSON",
		success:function(result){
			if (result.flag == "true") {
				alert("선택하신 글이 삭제되었습니다.");
				getMiniBbs();
			} else {
				alert("사용자 정보가 일치하지 않습니다.");
			}
		},
		error: function(request,status,error){
			//alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
}
/* 댓글 삭제 */
function fn_goods_bbs_delete() {
    if ($("#del_pass").val() == "" && ($("#del_pass").val()).length < 1) {
        alert("비밀번호가 정확하지 않습니다.");
        $("#del_pass").focus();
        return;
    }

    $.ajax({
        type: "get",
        url: "/lsv2016/ajax/detail/goods_bbs_list_ajax.jsp",
        data: "modelno=" + mini_modelno + "&del_no=" + $("#del_no").val() + "&del_pass=" + $("#del_pass").val() + "&pType=GD",
        dataType: "JSON",
        success: function(result) {
            if (result.flag == "true") {
                alert("선택하신 글이 삭제되었습니다.");
                //gbPage = 1;
                getMiniBbs();
            } else {
                alert("비밀번호가 정확하지 않습니다.");
            }
        },
        error: function(request, status, error) {
            //alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        }
    });

    fn_malllayerClose('#boardDelLayer');
}
function bridgeUrl(cmd, sCode, mNo,  mFactory,  iPlNo,  sCoupon, showPrice, buycnt, epKey){
    mFactory = encodeURIComponent(mFactory);
    if (typeof(buycnt) == "undefined") buycnt = 1;
    if (typeof(epKey) == "undefined") epKey = "";

    var strMoveTargetUrl = "/move/Redirect.jsp";
    var varTargetUrl = strMoveTargetUrl + "?cmd=" + cmd + "&vcode=" + sCode + "&modelno=" + mNo + "&pl_no=" + iPlNo + "&cate=" + mini_szCategory + "&urltype=0&coupon=" + sCoupon + "&from=detail&showPrice=" + showPrice + "&buycnt=" + buycnt;
    if (sCode == 536) {
        varTargetUrl = varTargetUrl + "&tempid=" + mini_sTmpUserId + "&memberid=" + mini_sUserId;
    }
    if (epKey != "") {
        varTargetUrl = varTargetUrl + "&ep=y&epkey=" + epKey;
    }

    return varTargetUrl;
}
function setG9Div() {
    var G9DivObj = $("#G9Div");

    G9DivObj.find(".btnclose").unbind();
    G9DivObj.find(".btnclose").click(function() {
        G9DivHide();
    });
}

function G9DivShow(thisObject) {
    var G9DivObj = $("#G9Div");

    // 토글
    if (G9DivObj.css("display") != "none") {
        G9DivHide();

        return;
    }

    var thisObj = $(thisObject);

    var top = thisObj.offset().top + 15; //- G9DivObj.height()-140;
    var left = thisObj.parents(".itembox").offset().left - (G9DivObj.width() - thisObj.parents(".itembox").width()) + 10;

    G9DivObj.css("top", top + "px");
    G9DivObj.css("left", left + "px");
    G9DivObj.show();
}

function G9DivHide() {
    var G9DivObj = $("#G9Div");

    G9DivObj.hide();
}
Date.prototype.format = function(f) {
    if (!this.valueOf()) return " ";
    var weekName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
    var d = this;
    return f.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|a\/p)/gi, function($1) {
        switch ($1) {
            case "yyyy":
                return d.getFullYear();
            case "yy":
                return (d.getFullYear() % 1000).zf(2);
            case "MM":
                return (d.getMonth() + 1).zf(2);
            case "dd":
                return d.getDate().zf(2);
            case "E":
                return weekName[d.getDay()];
            case "HH":
                return d.getHours().zf(2);
            case "hh":
                return d.getHours().zf(2);
            case "mm":
                return d.getMinutes().zf(2);
            case "ss":
                return d.getSeconds().zf(2);
            case "a/p":
                return d.getHours() < 12 ? "오전" : "오후";
            default:
                return $1;
        }
    });
};
String.prototype.string = function(len) {
    var s = '',
        i = 0;
    while (i++ < len) {
        s += this;
    }
    return s;
};
String.prototype.zf = function(len) {
    return "0".string(len - this.length) + this;
};
Number.prototype.zf = function(len) {
    return this.toString().zf(len);
};
