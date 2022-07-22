var vPc_price = "";
vPc_price += "<div class=\"searchNone\">";
vPc_price += "	<p class=\"txt1\">해당 상품은 판매 쇼핑몰 정책상 에누리 PC웹에서 ‘최저가’로 구매가능 합니다.  <em>‘찜하기’</em> 후 PC웹으로 접속해 주세요.</p>";
vPc_price += "	<button class=\"btnTxt btnZzim\" onclick=\"$('#btn_zzim').click();$('#noBuyClose').click();\">찜하기</button>";
vPc_price += "</div>";

//vPc_price += "<div class=\"pc_price\">";
//vPc_price += "	<p style=\"text-align:center;\">선택한 조건에 해당하는 쇼핑몰이 없습니다.</p>";
//vPc_price += "</div>";

$(function() {
	if(vAppyn == 'Y'){
        $("header").hide();
    }else{
        $("header").show();
    }
	var aa = document.getElementById("d_img").clientWidth;
	var bb = document.getElementById("d_img").clientHeight;

	if(aa > bb){
	   $("#d_img").css("width","100%");
	   $("#d_img").css("height","");
	}else if(aa < bb){
	   $("#d_img").css("width","");
	   $("#d_img").css("height","100%");
	 }else{
	   $("#d_img").css("width","100%");
	   $("#d_img").css("height","100%");
	 }	
				
	if(vAppyn == "Y"){
		$(".back").addClass("android");
	}
	
	varSNSTITLE = "에누리 가격비교";
	
	//카카오톡 키
	Kakao.init('5cad223fb57213402d8f90de1aa27301');

	//기본정보
	//get_base(vModelno);

	//가격비교정보
	getList();

	//둥둥배너
	bnrVip();

	var vTxt = $("#select_mall_"+vModelno).html();
	if($("#select_mallcnt_"+vModelno).html() != "<em></em>"){
		vTxt += "("+ $("#select_mallcnt_"+vModelno).html() + ")";
	}
	
	if($("#select_mall_"+vModelno).html() ==  undefined){
		$("#selected_option").hide();
	}else{
		$("#selected_option").show();
		$("#selected_option_txt").html(vTxt.replace("c_8a909e","c_198ef5"));
	}
	
	//옵션li에 색상 없에고. 선택된것만 색상넣어줌.
	$("#list_select > li").css("background","");
	$(".option").removeClass("on");
	
	$("#optiondetail_"+vModelno).addClass("selected");
	$("#optiondetail_"+vModelno).find(".option").addClass("on");
	
	if($("#list_select > li").size() > 5){
		$("#list_select > li").hide();
		$("#list_select > li:nth-child(1)").show();
		$("#list_select > li:nth-child(2)").show();
		$("#list_select > li:nth-child(3)").show();
		$("#list_select > li:nth-child(4)").show();
		$("#list_select > li:nth-child(5)").show();
		$("#option_more").show();
	}

	if($("#optiondetail_"+vModelno).css("display") == "none"){
		$("#option_more_btn").click();
	}
	
	$('.prodDetailBox .openBtn button').click(function(){
		vTab_top = vTab.offset().top-70;
	});
	
	//탭
    init_tabs();

	//CmdShare();

	insertLog('11080');

	//bar
	vTab1 = $("#tab1");
	vTab2 = $("#tab2");
	vTab3 = $("#tab3");
	
	vS_kakao.click(function(e){
		ga('send', 'event', 'mf_vip', 'vip', 'vip_공유_kakao');
	});
	vS_line.click(function(e){
		CmdShare_detail("line");
	});
	vS_face.click(function(e){
		CmdShare_detail("face");
	});
	vS_tw.click(function(e){
		CmdShare_detail("tw");
	});
	vS_sms.click(function(e){
		CmdShare_detail("sms");
	});
	vS_copy.click(function(e){
		CmdShare_detail("copy");
	});
	
	vTab1.click(function(e){
		vListnow = 0;
		vListpage = 1;
		getList();		
		
		insertLog('11032');
		ga('send', 'event', 'mf_vip', 'vip', 'vip_가격비교');
	});
	vTab2.click(function(e){
		vListnow = 0;
		getGuide();
		
		insertLog('11033');
		ga('send', 'event', 'mf_vip', 'vip', 'vip_상품설명');
	});
	vTab3.click(function(e){
		vListnow = 0;
		getReview();
		
		insertLog('11034');
		ga('send', 'event', 'mf_vip', 'vip', 'vip_상품평');
	});
	
	$("#btt_close").click(function(){
		 priceNotiClose();
	});
	
	//큰이미지 보기
	$("#d_img").click(function(e){
		if($("#b_imgbtt").text() == "true"){
			window.open("/mobilefirst/detailBigImage.jsp?modelno="+vModelno);
		}
		ga('send', 'event', 'mf_vip', 'vip', 'vip_상세이미지1');
	});
	
	if(vConstrain != "5"){
		if(vTab_Selected == "1"){
			vTab1.click();
			//select_list(intGroup,1);
		}else if(vTab_Selected == "2"){
			vTab2.click();
		}else if(vTab_Selected == "3"){
			setTimeout(function(){
				vTab3.click();
			},700);
		}
		vTab_Selected = "";
	}else{
		$(".prodDetailTab").addClass("tabType2");
		$("#li_tab3").hide();
		$("#li_tab2").hide();
		$("#li_tab1").addClass("on");
		vTab1.click();
	}
	
	//$('.dropSel button').unbind("click");
	$('.dropSel > span > button').unbind("click");
	
	$('.layerPop .btnClose').click(function(){
		var _this = $(this);
		$('.dimmed').remove();
		$('html, body').removeClass('dimdOn');
		_this.parent().parent().parent().hide();
	});
	
	setPowerLinkLink();
	
	//구글 분석기.
	if(referrerPower.indexOf("list.jsp")>-1){
		if(vCa_code.substring(0,2) == "02" || vCa_code.substring(0,2) == "03" || vCa_code.substring(0,2) == "04" || vCa_code.substring(0,2) == "05" || vCa_code.substring(0,2) == "06" || vCa_code.substring(0,2) == "07" || vCa_code.substring(0,2) == "12" || vCa_code.substring(0,2) == "21" || vCa_code.substring(0,2) == "22" || vCa_code.substring(0,2) == "24"){
			ga('send', 'pageview', {
				'page': '/mobilefirst/detail.jsp?from=list_cm1',
				'title': 'mf_상품상세_카테고리_CM1'
			});
		}else{
			ga('send', 'pageview', {
				'page': '/mobilefirst/detail.jsp?from=list_cm2',
				'title': 'mf_상품상세_카테고리_CM2'
			});
		}
	}else if(referrerPower.indexOf("search.jsp")>-1){
		ga('send', 'pageview', {
			'page': '/mobilefirst/detail.jsp?from=search',
			'title': 'mf_상품상세_검색'
		});
	}

	$('.openBtn button').click(function(){
		var _this = $(this);
		_this.parent().parent().find('.shortBox').toggleClass('open');
		_this.toggleClass('on');
		_this.text('접기');
		if (_this.hasClass('on') != 1) {
		_this.text('더보기');
		}
	});
	
	$("#btn_zzim").click(function(){
		ga('send', 'event', 'mf_vip', 'vip', 'vip_찜');
	});
	//최근본app처리
	try{
		if(vAppyn=="Y"){
			var vAdult = false;
    		if(vCate4 == "1640"){
    			vAdult = true;
    		}
    		
			if(window.android){		// 안드로이드
    			window.android.getRecentData(vModelnm , "G:"+vModelno, $("#d_img").attr("src") , location.href);
    			window.android.getRecentData_adult(vModelnm , "G:"+vModelno, imgurl_org, location.href,vAdult);
    		}
    		else{// 아이폰에서 호출
    			window.location.href = "enuriappcall://getRecentData?name="+encodeURIComponent(vModelnm)+"&code=G:"+vModelno+"&imageurl="+encodeURIComponent($("#d_img").attr("src"))
    			+"&url="+encodeURIComponent(location.href)+"&vAdult="+vAdult;

    		} 
		}
	}catch(e){
	}
	
	//소셜 일때 하단부 footer에서 배너와 바로가기 안보이기
	if(vSocial){
		$(".family_app").hide();
		$(".rule").addClass("social");
		setTimeout(function(){
			$(".evtbanner_btm").hide();
		},2000);
		
	}
	
	//이벤트 
	//getHunting();
	
	//로거에 담기
	_TRK_CP = "/"+vCa_code.substring(0,2)+ "/"+vCa_code.substring(2,4)+ "/"+vCa_code.substring(4,6)+ "/"+vCa_code.substring(6,8);
});

window.addEventListener("load", function(){
    setTimeout(scrollTo, 0, 0, 1);
}, false);
 


function get_base(modelno){
		   
	var vData = "modelno="+ modelno;
	if(vChkgroup){	//그룹모델이면
		vData += "&modelnos="+vMulti_Modelno;
	}
	
	$.ajax({ 
		type: "GET",
		url: "/mobilefirst/ajax/detailAjax/get_detail_base.jsp",
		async: false,
		data: vData,
		dataType:"JSON",
		success: function(json){
			vConstrain = json.constrain;
			
			if(vConstrain != undefined){
				if(vConstrain != "5"){
					$("#d_img").error(function(){
						$(this).error(function(){
							$(this).attr("src","http://photo3.enuri.com/data/working.gif");
						}).attr("src",json.imgurl3);
					}).attr("src",json.imgurl); 
				}else{
					$("#d_img").error(function(){
						$(this).attr("src","http://photo3.enuri.com/data/working.gif");
					}).attr("src",json.imgurl2);
				}
				imgurl_org = json.imgurl_org; //원본 이미지경로
				var aa = document.getElementById("d_img").clientWidth;
				var bb = document.getElementById("d_img").clientHeight;
				
				/*if(aa > bb){
					$("#d_img").css("width","100%");
					$("#d_img").css("height","");
				}else{ 
					$("#d_img").css("width","");
					$("#d_img").css("height","100%");
				}	*/
				if(aa > bb){
				   $("#d_img").css("width","100%"); 
				   $("#d_img").css("height","");
				}else if(aa < bb){
				   $("#d_img").css("width","");
				   $("#d_img").css("height","100%");
				 }else{
				   $("#d_img").css("width","100%");
				   $("#d_img").css("height","100%");
				 }	
				
				if(json.bigimg == "true"){								//큰이미지 유무에따라 돋보기 이미지 유무.
					$("#icon_zoom").show();
					$("#btn_zoom").show();
					$("#btn_zoom2").show();
					
					$("#d_img").click(function(){
						$(location).attr("href","/mobilefirst/detailBigImage.jsp?modelno="+modelno);
						ga('send', 'event', 'mf_vip', 'vip', 'vip_상세이미지1');
					});
					$("#btn_zoom").click(function(){
						$(location).attr("href","/mobilefirst/detailBigImage.jsp?modelno="+modelno);
						ga('send', 'event', 'mf_vip', 'vip', 'vip_상세이미지2');
					});
					$("#btn_zoom2").click(function(){
						$(location).attr("href","/mobilefirst/detailBigImage.jsp?modelno="+modelno);
						ga('send', 'event', 'mf_vip', 'vip', 'vip_상세이미지3');
					});
				}else{
					$("#icon_zoom").hide();
					$("#btn_zoom").hide();
					$("#btn_zoom2").hide();
				}
				//if(json.sponsor == "true"){								//스폰서 상품이면 마크 보여줌.
				//	$("#icon_sponsor").show();
				//}else{
				//	$("#icon_sponsor").hide();
				//}
				var vTmp_name =  json.modelnm;
				if( json.condiname != "" && !vChkgroup){
					//if(json.condiname == "일반"){
					//	vTmp_name += " [기본구성]";				
					//}else{
						vTmp_name += " [" + json.condiname + "]";
					//}
				}
				//if(json.condiname == "일반"){
				//	$("#func_comment").text("기본구성");						
				//}else{
					$("#func_comment").text(json.condiname);
				//}
				$(".product_info_inner .title").text(json.keyword2);
				
				if(json.keyword2.length > 0 && $("#pro_keyword2").hasClass("titNone")){
					("#pro_keyword2").removeClass("titNone");
				} 
				 
				vModelnm = vTmp_name;
				vModelno_group = json.modelno_group;
				vCa_code = json.ca_code;
				vCondiname = json.condiname;
				vMinprice = json.minprice;
				vPricestring = json.priceString;

				if(vPricestring == "품절" || vPricestring == "출시예정" || vPricestring == "단종"){
					$("#detail_minprice").text(json.priceString);	
					$("#btt_alarm").hide();
				}else if(vPricestring == "별도확인"){
					$(".price.price2").html("<strong id=\"detail_minprice\">별도확인</strong>");
					if(json.maxprice == 0){
						$(".price.price3").hide();
					}else{
						$("#detail_maxprice").text(commaNum(json.maxprice));
						$(".price.price3").show();
					}
					$("#pclowprice").text("별도확인");
					//$("#detail_maxprice").text("~ "+commaNum(json.maxprice)+" 원");
				}else{
					$(".price.price3").show();
					$("#detail_minprice").text(commaNum(json.minprice));
					$("#detail_maxprice").text(commaNum(json.maxprice));
					
					$("#pclowprice").text(commaNum(json.minprice));
				}
				
				//최저가 가격알림 가격
				$("#notiprice").text(commaNum(json.minprice)+" 원");
				
				$("#detail_modelnm").html(vTmp_name);						//상품명
				
				var vSpec = json.spec;
				
				vSpec  = json.spec_group;
				
				vSpec = vSpec.replace(/&amp;/gi,"&");
				
				$("#spec_txt").html(vSpec);
				
				$("#btnAllProd").on("click", function() {
					vTab1.click();
					select_list(vModelno_group,2);
				});
	
				
				vCate2 = json.cate4.substring(0,2);
				vCate4 = json.cate4;
	
				vFunc = json.func;
				
				if(vFunc.indexOf("<추가 설명")>-1){
					vFunc = vFunc.substring(vFunc.indexOf("<추가 설명"),vFunc.length);
					//<!--주석-->삭제
					var RegExpDS = /<!--[^>](.*?)-->/g;   
					vFunc = vFunc.replace(RegExpDS,"");   
				}
				
				//리스트상단 모델명 & 옵션명 추가
				//$("#list_head_model_txt_1").text(json.modelnm);
				
				//상품명 오류 다시한번 리딩
				$("#detail_modelnm").html(vModelnm);						//상품명
			}

		},
		error: function (xhr, ajaxOptions, thrownError) {
			//alert(xhr.status);
			//alert(thrownError);
		}
	});
}

function getList(){
//가격비교
	if(vPricestring == "품절" || vPricestring == "출시예정" || vPricestring == "단종"){
		$("#none_list").show();
		$("#list_head").hide();
		$("#list_body").hide();
		$("#detail_list").html(null);
	}else{
		//가격비교 리스트
		var vList_data = "modelno="+vModelno+"&page="+vListpage;
		
		vList_data += "&tabinfoyn=Y";

		if(vListSort != ""){
			vList_data += "&"+vListSort+"=Y";
		}
		
		//if(vInstanceMinPrice > 0){
		//	vList_data += "&instanceminprice="+vInstanceMinPrice;	
		//}
		
		if(vChkgroup){	//그룹모델이면
			vList_data += "&modelnos="+vMulti_Modelno;
		}
		
		$.ajax({
			type: "GET",
			url: "/mobilefirst/ajax/detailAjax/get_list.jsp",
			data: vList_data,
			dataType: "JSON",
			success: function(json){
				$("#detail_list").html(null);
				$("#detail_list_more").unbind("click");
				
				if(json.listContent){
				
					vList_Cnt = json.listCount;

					//if(vInstanceMinPrice == 0){
					//	vInstanceMinPrice = json.instanceMinPrice;
					//}
					if(json.pcPriceyn == "Y"){
						$(".pc_lowprice").show();
						$(".price1").html("<strong>PC</strong> 최저가");
					}else{
						$(".pc_lowprice").hide();
						$(".price1").html("&nbsp;");
					}
					if(json.FstShop != "pc"){
						var template = "{{#listContent}}";

						template += "<li class=\"list_li\">";
						template += "	<a href=\"javascript:///\"  onclick=\"{{#shop_bid}}insertLog_cate({{shopbidlogno_click}},vCate4);{{/shop_bid}}goShop('{{#mobileurl}}{{mobileurl}}{{/mobileurl}}','{{shopcode}}','{{plno}}','{{goodscode}}','{{instanceprice}}','{{category}}','{{price}}','{{minprice}}',this,vModelno);\">";
						template += "		<p class=\"txt1\">{{plgoodsname}}</p>";
						template += "		<p class=\"txt2\">";
						template += "			<span class=\"brand {{#shop_bid}}shopbid_{{shopcode}}{{/shop_bid}}\">{{shopname}}{{#shop_bid}}<em class=\"spon\">스폰서</em>{{/shop_bid}}</span>";
						template += "			<span class=\"price {{#shop_bid}}spon{{/shop_bid}}\">{{#shop_bid}}<strong class=\"spon_min\">최저가</strong>{{/shop_bid}}<em>{{price}}</em>원</span>";
						template += "		</p>";	
						template += "		<p class=\"txt3\">";
						template += "			{{#couponflag}}<span class=\"icoOpt icoOpt1\">쿠폰</span>{{/couponflag}}";
						template += "			{{#cardfreeflag}}<span class=\"icoOpt icoOpt2\">무이자</span>{{/cardfreeflag}}";
						template += "			{{#authflag}}<span class=\"icoOpt icoOpt4\">공식판매자</span>{{/authflag}}";
						template += "			{{#cardflag}}<span class=\"icoOpt icoOpt6\">카드할인</span>{{/cardflag}}";
						template += "			<span class=\"delivery\">{{displaydelivery}}</span>";
						template += "		</p>";
						template += "	</a>";
						if(vAppyn == "Y"){	//앱일때만 나옴
						//if(1 == 1){	//앱일때만 나옴
							template += "  {{#shopbidflag}}";
							template += "  	{{#shop_bid}}{{#detail_url}}";
							template += "			<div class=\"areaPreview\"  onclick=\"show_detail('{{detail_url}}','{{#mobileurl}}{{mobileurl}}{{/mobileurl}}','{{shopcode}}','{{plno}}','{{goodscode}}','{{instanceprice}}','{{category}}','{{price}}','{{minprice}}',vModelno,'{{displaydelivery}}','{{shopname}}','{{shopbidlogno_click}}');\"><button class=\"btnMore\">상세정보 미리보기</button></div>";
							template += "		{{/detail_url}}{{/shop_bid}}";
							template += "	{{/shopbidflag}}";
							template += "	{{^shopbidflag}}";
							template += "		{{#mpriceflag}}{{#detail_url}}";
							template += "			<div class=\"areaPreview\"  onclick=\"show_detail('{{detail_url}}','{{#mobileurl}}{{mobileurl}}{{/mobileurl}}','{{shopcode}}','{{plno}}','{{goodscode}}','{{instanceprice}}','{{category}}','{{price}}','{{minprice}}',vModelno,'{{displaydelivery}}','{{shopname}}','');\"><button class=\"btnMore\">상세정보 미리보기</button></div>";
							template += "		{{/detail_url}}{{/mpriceflag}}";							
							template += "	{{/shopbidflag}}";
						}
						template += "</li>";
						template += "{{/listContent}}";

						var html = Mustache.to_html(template, json);
												
						var vCnt = json.listContent.length;

						if(html.length > 1){
							$("#none_list").hide();
							html = html.replace(/&amp;/gi,"&");
							$("#detail_list").html(html);

							$("#list_head_sort").show();
							$("#detail_list_more").show();
							$(".infoBox").removeClass("box_no");

							if(json.shopbidflag == "Y"){
								insertLog_cate(json.shopbidlogno_view	,vCate4);		//쇼핑몰 상위입찰 로그
							}
							
							$(".brand").each(function(){
								if($.trim($(this).text()) == 'PC 최저가'){
									//$(this).css("color","#8c8c8c");
									
									$(this).parent().parent().hide();
									
									//$(this).parent().children(".price").children("em").hide();
									
									//$(this).parent().children(".price").css("color","#83a8d7");
								}
							});	
							
							var ii = 0;
							$(".list_li").each(function(){
								if(ii > 49){ 						//처음 50개
									$(this).hide();
								}
								ii++;
							});
						}
						
						$("#list_more2").text(json.listCount);
						$("#list_mallcnt").text(json.listCount);
						
						vList_Cnt = json.listCount;
						
						if(vCnt < vListpagesize){
							$("#list_more1").text(vCnt);
						
							$("#detail_list_more").hide();
						
							vListnow = vCnt;
						}else{
							$("#list_more1").text(vListpagesize);

							$("#detail_list_more").show();
							
							vListnow = vListpagesize;
							
							$("#detail_list_more").click(function(){
								getListmore();
							});
						}
					}else{
						$("#detail_list").html("<li>"+vPc_price+"</li>");
						//$("#none_list").show();
						$("#list_more1").text("0");
						$(".fixSelectoption").hide();
						$("#detail_list_more").hide();

						vListnow = vCnt;
					}
				}else{
					$("#detail_list").html("<li>"+vPc_price+"</li>");
					
					$("#list_more1").text("0");
					$(".fixSelectoption").hide();
					$("#detail_list_more").hide();

					vListnow = vCnt;
				}
				
				vTab_top = vTab.offset().top;
			
				
				if($("#list_sort").html().length < 1){
					//정렬리스트 생성
					var vTmpsort = "";
					
					vTmpsort += "<option value=\"tabyn_minsort\">최저가순</option>";
					//오픈마켓
					
					vTmpsort += "<option value=\"tabyn_dminsort\">배송비 포함 최저가순</option>";
					
					//할부원금가(판매가쇼핑몰)
					if(json.tabyn_realprice == "Y"){
						vTmpsort += "<option value=\"tabyn_realprice\">할부원금가</option>";
					}
					//기본설치비(스탠드+벽걸이) 포함
					if(json.tabyn_aircon_1 == "Y"){
						vTmpsort += "<option value=\"tabyn_aircon_1\">기본설치비 포함 (스탠드+벽걸이)</option>";
					}
					//기본설치비(스탠드+벽걸이+진공비) 포함
					if(json.tabyn_aircon_2 == "Y"){
						vTmpsort += "<option value=\"tabyn_aircon_2\">기본설치비 포함 (스탠드+벽걸이+진공비)</option>";
					}
					//기본설치비+진공비 포함
					if(json.tabyn_aircon_4 == "Y"){
						vTmpsort += "<option value=\"tabyn_aircon_4\">기본설치비+진공비 포함</option>";
					}
					if(json.tabyn_open == "Y"){
						vTmpsort += "<option value=\"tabyn_open\">오픈마켓</option>";
					}
					//무료배송
					if(json.tabyn_dlv0 == "Y"){
						vTmpsort += "<option value=\"tabyn_dlv0\">무료배송</option>";
					}
					//전시/중고
					if(json.tabyn_junggo == "Y"){
						vTmpsort += "<option value=\"tabyn_junggo\">전시/중고</option>";
					}
					//반품/리퍼
					if(json.tabyn_return == "Y"){
						vTmpsort += "<option value=\"tabyn_return\">반품/리퍼</option>";
					}
					//세금/배송비무료(해외쇼핑)
					if(json.tabyn_tariffree == "Y"){
						vTmpsort += "<option value=\"tabyn_tariffree\">세금/배송비무료(해외쇼핑)</option>";
					}
					//제조사 공식인증판매자
					if(json.tabyn_auth == "Y"){
						vTmpsort += "<option value=\"tabyn_auth\">제조사 공식인증판매자</option>";
					}
					//제조사인증 업체명
					if(json.tabyn_auth_nm == "Y"){
						vTmpsort += "<option value=\"tabyn_auth\">제조사인증 업체명</option>";
					}
					//전국무료장착(타이어)
					if(json.tabyn_tirefree == "Y"){
						vTmpsort += "<option value=\"tabyn_tirefree\">전국무료장착(타이어)</option>";
					}
					//백화점몰
					if(json.tabyn_depart == "Y"){
						vTmpsort += "<option value=\"tabyn_depart\">백화점몰</option>";
					}
					//카드할인
					if(json.tabyn_card == "Y"){
						vTmpsort += "<option value=\"tabyn_card\">카드할인</option>";
					}
					//무이자
					if(json.tabyn_cardfree == "Y"){
						vTmpsort += "<option value=\"tabyn_cardfree\">무이자</option>";
					}
					//홈쇼핑&전문몰
					if(json.tabyn_etcmall == "Y"){
						vTmpsort += "<option value=\"tabyn_etcmall\">홈쇼핑/전문몰</option>";
					}
					
					if(vTmpsort != ""){
						$("#list_sort").html(vTmpsort);

						vTab_top = vTab.offset().top;
													
						$('#list_sort').unbind('change');
						$('#list_sort').bind('change', function(){
							var chk_value = $("#list_sort").val();					
							vListSort = chk_value;
							vListpage = 1;
							getList();
							select_list_slide(0);
							
							vSort_txt = $("#list_sort option:selected").text();
							fnGoogleClick(5);
						});
					}
				}  
			},
			error : function(result) { 
				//alert("error occured. Status:" + result.status  
                 //            + ' --Status Text:' + result.statusText 
                 //           + " --Error Result:" + result); 
				$(".fixSelectoption").hide();

				vTab = $(".prodDetailTab");
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
		
		if($("#list_select").html() == ""){
			$.ajax({
				type: "GET",
				url: "/mobilefirst/ajax/detailAjax/get_option.jsp",
				async: false,
				data: "modelno="+vModelno,
				dataType:"JSON",
				success: function(json){
					$("#list_select").html(null);

					if(json.optionDetail){
						if(json.optionDetail[0].optionCnt < 1 || json.optionDetail[0].optionCondiname == ""){
							//$('#list_select_txt').addClass("empty-option");
							//$('.dropSel > span button').unbind("click");
							//$('.dropSel > span button').addClass("empty-option");
							
							$("#option_part").hide();
							return false;
						}else{
		
							$("#option_head_txt").html(json.optionUnit);
		
							var template = "";
						
							template += "{{#optionDetail}}";
							template += "<li id=\"optiondetail_{{optionModelno}}\">";
							template += "	<a href=\"javascript:///\">";
							template += " 		{{#optionRentalflag}}";
							template += "			<span class=\"option\"><span class=\"chk\"><img class=\"chk_img\" src=\"http://imgenuri.enuri.gscdn.com/images/mobilefirst/ico_chk.png\"  onclick=\"rental_go({{optionModelno}});\" value=\"{{optionModelno}}\" ></span><span onclick=\"rental_go({{optionModelno}});\" id=\"select_mall_{{optionModelno}}\"><em class=\"type\">{{optionCondiname}}</em></span></span>";
							template += "			<span onclick=\"rental_go({{optionModelno}});\" class=\"company\"  id=\"select_mallcnt_{{optionModelno}}\"><em>{{#optionMallcnt}}{{optionMallcnt}}{{/optionMallcnt}}</em></span>";
							template += "			<span onclick=\"rental_go({{optionModelno}});\" class=\"unit\">{{#optionUnit}}{{#optionUnitprice}}{{{optionUnitprice}}}{{/optionUnitprice}}{{/optionUnit}}</span>";
							template += "			<span onclick=\"rental_go({{optionModelno}});\" class=\"priceLow\"><span class=\"priceicon\"><strong class=\"txtLow\" !class=\"iconPc\"></strong></span><em>{{optionPrice}}</em></span>";
							template += " 		{{/optionRentalflag}}";
							template += " 		{{^optionRentalflag}}";
							template += "			<span class=\"option\"><span class=\"chk\"><img class=\"chk_img\" src=\"http://imgenuri.enuri.gscdn.com/images/mobilefirst/ico_chk.png\"  onClick=\"procChkButton(this,1);\" value=\"{{optionModelno}}\" ></span><span onclick=\"set_option({{optionModelno}});\" id=\"select_mall_{{optionModelno}}\"><em class=\"type\">{{optionCondiname}}</em></span></span>";
							template += "			<span onclick=\"set_option({{optionModelno}});\" class=\"company\"  id=\"select_mallcnt_{{optionModelno}}\"><em>{{#optionMallcnt}}{{optionMallcnt}}{{/optionMallcnt}}</em></span>";
							template += "			<span onclick=\"set_option({{optionModelno}});\" class=\"unit\">{{#optionUnit}}{{#optionUnitprice}}{{{optionUnitprice}}}{{/optionUnitprice}}{{/optionUnit}}</span>";
							template += "			<span onclick=\"set_option({{optionModelno}});\" class=\"priceLow\"><span class=\"priceicon\">{{#optionMinpriceflag}}<strong class=\"txtLow\" !class=\"iconPc\">최저가</strong>{{/optionMinpriceflag}}{{#optionMinpricePcflag}}<strong class=\"iconPc\">PC</strong>{{/optionMinpricePcflag}}</span><em>{{optionPrice}}</em></span>";
							template += " 		{{/optionRentalflag}}";
							template += "	</a>";
							template += "</li>";
							
							template += "{{/optionDetail}}";
			
							var html = Mustache.to_html(template, json);	

							if(html.length > 1){
								html = html.replace(/&amp;/gi,"&");
								$("#list_select").html(html);
							}
							
							vOption_Cnt = json.optionDetail.length;
							
							$("#optionlist_cnt").html("("+vOption_Cnt+"개)");
							
							//var vChkli = false;
							$(".option").removeClass("on");
							
							$('#list_select li').each(function(){
								if($(this).attr("id").indexOf(vModelno) > -1){
									$(this).addClass("selected");
									$(this).find(".option").addClass("on");
									//$(this).find(".chk_img").checked = true;
									//$(this).find(".chk_img").attr("src","http://imgenuri.enuri.gscdn.com/images/mobilefirst/ico_chk_on.png");
									//vChkli = true;
								}
							});
							//if(!vChkli){
							//	$('#list_select li').each(function(){
							//		$(this).addClass("selected");
							//	});
							//}
							if(json.optionUnit == ""){
								$("#option_unit").hide();
								$(".optionHeader").addClass("mu3");
								$(".optionList").addClass("mu3");
								$(".unit").hide();
							}
							
	
							if(vOption_Cnt > 5){
								$("#optionMorearea").show();
								$("#option_more_btn").removeClass("on");
								$("#option_more_btn").html("더보기(<label class=\"c_198ef5\">5</label>/<label class=\"c_198ef5\">"+ vOption_Cnt +"</label>)");
	
								$("#option_more_btn").click(function(){
									
									$('#list_select li').filter(':gt(4)').toggle();
									
									vTab = $(".prodDetailTab");
									vTab_top = vTab.offset().top;
									
									if($('#list_select li').filter(':gt(4)').css("display") != "none"){
										$("#option_more_btn").addClass("on");
										$("#option_more_btn").html("접기");
									}else{
										$("#option_more_btn").removeClass("on");
										$("#option_more_btn").html("더보기(<label class=\"c_198ef5\">5</label>/<label class=\"c_198ef5\">"+ vOption_Cnt +"</label>)");
									}
									
									$("body, html").animate({ scrollTop: $("#option_part").offset().top }, 300); 
			
								});
							}else if(vOption_Cnt > 1){
								$("#option_more_btn").hide();
							}else{
								$(".check_caution").hide();
								$("#option_check_all").hide();
								$("#optionMorearea").hide();
								$(".chk_img").hide();
							}
		
							if(vOption_Cnt > 0){
								if($("#list_select_txt").html() == ""){
									$("#list_select_txt").html("· 옵션 별 최저가 (총 <label class=\"c_198ef5\">"+ vOption_Cnt +"</label> 개 옵션 / <label class=\"c_198ef5\">"+commaNum(json.optionAllmallCnt)+"</label> 개 상품)");
								}
							}
						}
					}else{
						$("#option_part").hide();
						$(".fixSelectoption").hide();
					}
				},
				error: function (xhr, ajaxOptions, thrownError) {
					//alert(xhr.status);
					//alert(thrownError);
				}
			});
		}
		
		$('.prodDetailBox .openBtn button').unbind("click");
			
		$('.prodDetailBox .openBtn button').click(function(){
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

function select_list(modelno,part){

	//part : 1 open, 0 close;	사용안함.
	vModelno = modelno;
	
	get_base(modelno);
	
	var vTxt = $("#select_mall_"+modelno).html();
	if($("#select_mallcnt_"+modelno).html() != "<em></em>"){
		vTxt += "("+ $("#select_mallcnt_"+modelno).html() + ")";
	}

	//옵션li에 색상 없에고. 선택된것만 색상넣어줌.
	$("#list_select > li").removeClass("selected");
	$(".option").removeClass("on");
	
	$("#optiondetail_"+modelno).addClass("selected");
	$("#optiondetail_"+modelno).find(".option").addClass("on");
	
	if($("#select_mall_"+modelno).html() == undefined){
		$("#selected_option").hide();
	}else{
		$("#selected_option").show();
		$("#selected_option_txt").html(vTxt.replace("c_8a909e","c_198ef5"));
	}
	
	
	
	//옵션명이 없을때는 칸을 줄여서 보여준다.
	if($("#selected_option_txt").text() == ""){
		$("#list_head_model").hide();
	}

	vTab_Selected = "";
	
	vListpage = 1;
	getList();
}

function select_list_slide(param){
	if(param == 0){
		$("body, html").animate({ scrollTop: $("#tab_position").offset().top}, 500);
	}else{
		if(!vTab.hasClass("over_bar")){
			$("body, html").animate({ scrollTop: $("#tab_position").offset().top }, 500);
		}else{
			$("body, html").animate({ scrollTop: $("#tab_position").offset().top }, 500);
		}
	}
}

var vComponent_detaill;	//각성분별내용리스트
var v1_txt = "";	//좋은성분
var v2_txt = "";	//주의성분
var v3_txt = "";	//피부타입별

function getGuide(){
	var html = "";

	$.ajax({
		type: "GET",
		url: "/mobilefirst/ajax/detailAjax/get_detail_spec.jsp",
		data: "modelno="+vModelno,
		dataType:"JSON",
		success: function(json){
			$("#spec").html(null);
			//var template = "{{#detailSpec}}{{specTitle}}/{{specContent}}<br>{{/detailSpec}} ";

			if(json.detailSpec){
				var template = "<table summary=\"제품 요약 설명\">";
					template += "	<caption>제품 요약 설명</caption>";
					//template += "		<colgroup><col style=\"width:20%\" /><col style=\"width:80%\" /></colgroup>";
					template += "	<tbody>";
					template += "{{#detailSpec}}";
					template += "		{{#specGroupname}}<tr><th colspan=\"2\" class=\"title\">&middot; {{{specGroupname}}}</th></tr>{{/specGroupname}}";
					template += "		{{#specTitle}}<tr><th scope=\"row\" rowspan=\"{{specCellcnt}}\">{{{specTitle}}}</th>{{/specTitle}}<td>{{{specContent}}}</td></tr>";
					template += "{{/detailSpec}}";
					template += "	</tbody>";
					template += "</table>";
				
				html = Mustache.to_html(template, json);
				
				if(html.length > 1){
					html = html.replace(/&amp;/gi,"&");
					$("#spec_body").html(html);
					$("#spec_txt").hide();;
					//$("#spec_head_h1").css("border-bottom","0px");
				}
				
			}else{
				$("#spec_section").hide();
			}
		},
		error: function (xhr, ajaxOptions, thrownError) {
			$("#spec_section").hide();
			//alert(xhr.status);
			//alert(thrownError);
		}
	});
	
	//카탈로그 보여줄 카테고리 정리
	var vCate_L = ",02,03,04,05,06,07,12,21,22,24,";
	var vCate_M = ",0908,0930,0905,0931,0920,0932,0918,0904,1602,1643,2144,";
	var vCateflag = false;
	var vData = "modelno="+vModelno;
	
	if(vCate_L.indexOf(","+vCate2+",") > -1){
		vCateflag = true;
	}
	
	if(vCate_M.indexOf(","+vCate4+",") > -1){
		vCateflag = true;
	}
	
	if(vCateflag){
		vData += "&mode=1";
	}

	//카탈로그 및 용어설명
	$.ajax({
		type: "GET",
		url: "/mobilefirst/ajax/detailAjax/get_function.jsp",
		data: vData,
		success: function(result){
			var r0 = result.substring(result.indexOf("@@@")+3,result.indexOf("$$$"));
			var r1 = result.substring(result.indexOf("$$$")+3,result.indexOf("^^^"));
			var r2 = result.substring(result.indexOf("^^^")+3,result.length);

			if(r1.length > 10){
				$("#spec_func").html("<pre>"+r1+"</pre>");
				
			}else{
				$("#func_section").hide();

				if($("#spec_body").html().length < 10){
					$("#spec_section").show();
				}
			}
			
			//주의사항
			if(r1.length > 10 && r0.length > 10){
				$("#spec_func").html("<pre>"+r1+"</pre>"+r0);							
			}
			
			if($("#spec_func").height() < 250){
				$("#spec_more").hide();
			}

			if(r2.length > 50){		
				$("#guide_body").html(r2);
				
				if($("#guide_body").height() < 139){
					$("#guide_more").hide();
				}
			}else{
				$("#guide_section").hide();
			}
		},
		error: function (xhr, ajaxOptions, thrownError) {
			//alert(xhr.status);
			//alert(thrownError);
		}
	});

	$('.prodDetailBox .openBtn button').unbind("click");
			
	$('.prodDetailBox .openBtn button').click(function(){
		var _this = $(this);
		_this.parent().parent().find('.shortBox').toggleClass('open');
		_this.toggleClass('on');
		_this.text('접기');
		if (_this.hasClass('on') != 1) {
		_this.text('더보기');
		}
	});

	//화장품 성분비교 추가
	if (vCa_code.indexOf("0801") > -1 || vCa_code.indexOf("0805") > -1 || vCa_code.indexOf("0809") > -1 || vCa_code.indexOf("0812") > -1 || vCa_code.indexOf("0802") > -1 || vCa_code.indexOf("0814") > -1 || vCa_code.indexOf("0806") > -1 || vCa_code.indexOf("0807") > -1 || vCa_code.indexOf("1654") > -1 || vCa_code.indexOf("0803") > -1 || vCa_code.indexOf("0804") > -1) {
	
		var vData_conponent = {modelno : vModelno , cacode: vCa_code , opt : "ALL_T"};
		$.ajax({
			type: "GET",
			url: "/common/jsp/Ajax_Component_Data.jsp",
			data: vData_conponent,
			dataType:"JSON",
			success: function(json){
				if(json.resultmsg == "success"){
					var vAll_Component = json.all_component_data[0];
					var vGoodness_type = json.all_component_data[1];
					var vComponent_items = json.all_component_data[2];
	
					var template = "";
					
					var vGood_item_txt = "";
					var vGood_item_ids = "";
					var vBad_item_txt = "";
					var vBad_item_ids = "";		
					
					var vTemplate =  "";
					var vTemplate_ids =  "";
					
					if(vAll_Component.total_cnt > 0){
					
						template += "<tr>";
						template += "	<th scope=\"row\" rowspan=\"1\">전성분</th>";
						template += "	<td>"+ vAll_Component.total_cnt +"개<em class=\"more_ly\" onclick=\"show_component(1,'"+ vAll_Component.all_component +"')\">더보기</em></td>";
						template += "</tr>";
				
						if(vComponent_items.component_items.length > 0){
							for (var i=0; i < vComponent_items.component_items.length; i++) {
								if(vComponent_items.component_items[i].cpt_harmflag == "0"){	//좋은성분
									vGood_item_txt += vComponent_items.component_items[i].cpt_name + "("+ vComponent_items.component_items[i].cpt_cnt + ")    ";
									if(vGood_item_ids != "" && vComponent_items.component_items[i].cp_ids != ""){
										vGood_item_ids += ",";
									}
									vGood_item_ids += vComponent_items.component_items[i].cp_ids;
								}else{	//나쁜성분
									vBad_item_txt += vComponent_items.component_items[i].cpt_name + "("+ vComponent_items.component_items[i].cpt_cnt + ")    ";
									if(vBad_item_ids != "" && vComponent_items.component_items[i].cp_ids != ""){
										vBad_item_ids += ",";
									}
									vBad_item_ids += vComponent_items.component_items[i].cp_ids;
								}
								
								//if(vComponent_items.component_items[i].cp_ids != ""){
									if(vComponent_items.component_items[i].cpt_harmflag == "0"){
										if(v1_txt != ""){
											v1_txt += "^";
										}
										if(vComponent_items.component_items[i].cp_ids != ""){
											v1_txt += vComponent_items.component_items[i].cpt_name +","+vComponent_items.component_items[i].cp_ids;								
										}else{
											v1_txt += vComponent_items.component_items[i].cpt_name;
										}
									}else if(vComponent_items.component_items[i].cpt_harmflag == "1"){
										if(v2_txt != ""){
											v2_txt += "^";
										}
										if(vComponent_items.component_items[i].cp_ids != ""){
											v2_txt += vComponent_items.component_items[i].cpt_name +","+vComponent_items.component_items[i].cp_ids;
										}else{
											v2_txt += vComponent_items.component_items[i].cpt_name;
										}
									}
									
								//}
							}
						}
						template += "<tr>";
						template += "	<th scope=\"row\" rowspan=\"1\">좋은성분</th>";
						template += "	<td><span class=\"good\">"+ vGood_item_txt +"</span>";
						if(vGood_item_ids != ""){
							template += "		<em class=\"more_ly\" onclick=\"show_component(2,'"+ vGood_item_ids +"')\">더보기</em>";
						}
						template += "	</td>";
						template += "</tr>";
						template += "<tr>";
						template += "	<th scope=\"row\" rowspan=\"1\">주의성분</th>";
						template += "	<td><span class=\"care\">"+ vBad_item_txt +"</span>";
						if(vBad_item_ids != ""){
							template += "		<em class=\"more_ly\" onclick=\"show_component(3,'"+ vBad_item_ids +"')\">더보기</em>";
						}
						template += "	</td>";
						template += "</tr>";
	
						if(vGoodness_type.goodness_type.length > 0){
							for (var i=0; i < vGoodness_type.goodness_type.length; i++) {
								vTemplate += "			<li><em class=\"p"+ vGoodness_type.goodness_type[i].cpt_goodness_round_percent +"\">"+ vGoodness_type.goodness_type[i].cpt_goodness_percent +"%</em>"+ vGoodness_type.goodness_type[i].cpt_group_name +"</li>";
		
								if(vTemplate_ids != "" && vGoodness_type.goodness_type[i].cp_ids != ""){
									vTemplate_ids += ",";
								}
								vTemplate_ids += vGoodness_type.goodness_type[i].cp_ids;
								
								//if(vGoodness_type.goodness_type[i].cp_ids != ""){
									if(v3_txt != ""){
										v3_txt += "^";
									}
									if(vGoodness_type.goodness_type[i].cp_ids != ""){
										v3_txt += vGoodness_type.goodness_type[i].cpt_group_name +"에 좋은성분,"+vGoodness_type.goodness_type[i].cp_ids;
									}else{
										v3_txt += vGoodness_type.goodness_type[i].cpt_group_name +"에 좋은성분";							
									}
									
								//}
								
								
							}
						
							template += "<tr>";  
							template += "	<th colspan=\"2\" class=\"title\">· 피부타입별 적합도<em class=\"more_ly\" onclick=\"show_component(4,'"+ vTemplate_ids +"')\">더보기</em></th>";
							template += "</tr>";
							template += "<tr>";
							template += "	<td colspan=\"2\" class=\"type_skin\">";
							template += "		<ul class=\"type\">";
							template += vTemplate;
							template += "		</ul>";
							template += "	</td>";
							template += "</tr>";
							
						}
						//template = template.replace(/&amp;/gi,"&");
						$("#cosmetic_body").html(template);
						$("#cosmetic_section").show();
						
						var vAllcpids = "";
						
						if(vGood_item_ids != ""){
							vAllcpids += vGood_item_ids;
						}
						if(vBad_item_ids != ""){
							if(vAllcpids != ""){
								vAllcpids += ",";
							}
							vAllcpids += vBad_item_ids;
						}
						if(vTemplate_ids != ""){
							if(vAllcpids != ""){
								vAllcpids += ",";
							}
							vAllcpids += vTemplate_ids;
						}
						
						//각각 성분 가지고 와서 배열에 담기
						var vData_conponent = {cpids : vAllcpids , cacode: vCa_code , opt : "4"};
						
						$.ajax({
							type: "GET",
							url: "/common/jsp/Ajax_Component_Data.jsp",
							data: vData_conponent,
							dataType:"JSON",
							success: function(json_detail){
								if(json_detail.resultmsg == "success"){
									if(json_detail.component_list.length > 0){
										//for (var i=0; i < json_detail.component_list.length; i++) {
										
										//}
										vComponent_detaill = json_detail.component_list;
									}
								}
							}
						});
					}else{
						$("#cosmetic_section").hide();
					}
				}else{
					$("#cosmetic_section").hide();
				}
			}
		});
	}
}

function show_component(part,ids){ 
	//alert(ids);
	//part  1:전성분, 2: 주의성분, 3:좋은성분, 4: 피부타입별
	if(part == 1){
		$("#skintitle").text("전성분");
		
		$("#skintable").html(null);
		
		var vIds = ids.split(",");
		
		var templete = "";
		
		templete += "<colgroup>";
		templete += "	<col width=\"70%\" />";
		templete += "	<col width=\"30%\" />";
		templete += "</colgroup>";
		templete += "<tr>";
		templete += "	<th colspan=\"2\">전성분("+ (vIds.length) +")</th>";
		templete += "</tr>";

		if(vIds.length > 0){
			for(var i = 0;i < vIds.length;i++){
				templete += "<tr>";
				templete += "	<td colspan=\"2\" class=\"colspan2\">"+ vIds[i] +"</td>";
				templete += "</tr>";
			}
		}
		
		$("#skintable").html(templete);
		$("#skin_ly").show();
		$("body").css("overflow-y","hidden");
		//lockScroll();
		//vNow_scroll = $("body").scrollTop();
	}else{
		var vText = v1_txt;
		if(part == 2){
			$("#skintitle").text("좋은성분");
			vText = v1_txt;
		}else if(part == 3){
			$("#skintitle").text("주의성분");
			vText = v2_txt;
		}else if(part == 4){
			$("#skintitle").text("피부타입별 적합도");
			vText = v3_txt;
		}
		
		$("#skintable").html(null);
		
		var templete = "";
		
		templete += "<colgroup>";
		templete += "	<col width=\"70%\" />";
		templete += "	<col width=\"30%\" />";
		templete += "</colgroup>";
		
		
		//var vText = "미백^탄력^피부보습,71,107,113";
		
		var vParts = vText.split("^");
		
		if(vParts.length>0){
			for(var i = 0;i < vParts.length;i++){
				var vTmptxt = vParts[i].split(",");
				
				if(vTmptxt.length>0){
					for(var j = 0;j < vTmptxt.length;j++){
						if(j == 0){	//타이틀
							templete += "<tr>";
							templete += "	<th colspan=\"2\">"+ vTmptxt[j] +"("+ (vTmptxt.length-1) +")</th>";
							templete += "</tr>";
							if(vTmptxt.length-1 == 0){
								templete += "<tr>";
								templete += "	<td>해당성분없음<td></td>";
								templete += "</tr>";
							}
						}else{
							for(var k = 0;k<vComponent_detaill.length;k++){
								if(vComponent_detaill[k].cp_id ==vTmptxt[j]){
									var vPurpose_tmp = "";
									if(vComponent_detaill[k].cp_purpose.indexOf(",") > -1){
										vPurpose_tmp = vComponent_detaill[k].cp_purpose.substring(0,vComponent_detaill[k].cp_purpose.indexOf(","));
									}else{
										vPurpose_tmp = vComponent_detaill[k].cp_purpose;
									}
									templete += "<tr>";
									templete += "	<td>"+ vComponent_detaill[k].cp_name_kr +"</td><td>"+ vPurpose_tmp +"</td>";
									templete += "</tr>";
									break;
								}
							}
						}
					}	
				}
			}
		}

		//if(vIds.length > 0){
		//	for(var i = 0;i < vIds.length;i++){
		//		templete += "<tr>";
		//		templete += "	<td colspan=\"2\" class=\"colspan2\">"+ vIds[i] +"</td>";
		//		templete += "</tr>";
		//	}
		//}
		
		$("#skintable").html(templete);
		$("#skin_ly").show();
		$("body").css("overflow-y","hidden");
		//lockScroll();
		//vNow_scroll = $("body").scrollTop();
	}
}

function getOptionmore(){
	var vCnt = $("#option_more2").text();
	if(vCnt < vOptionnow+vOptionpagesize){
		$("#option_more1").text(vCnt);
		
		$("#list_select > li").show();
	}else{
		vOptionnow = vOptionnow+vOptionpagesize;
		
		$("#option_more1").text(vOptionnow);
		
		$("#list_select > li:lt("+ vOptionnow +")").show();
	}
}

function go_url(url){
	var redirectUrl;
	
	try{    
		window.android.android_window_open(url); 
	}catch(e){ 
		if(varApp == ""){
			redirectUrl = window.open(url);
		}else{
			redirectUrl = window.open(url);
		}
		redirectUrl.focus;  
	}
}


function getReview(){
	var vData = "";
	//상품평
	vData = "modelno="+vModelno;

	$.ajax({
		type: "GET",
		url: "/mobilefirst/ajax/detailAjax/get_review.jsp",
		data: vData,
		dataType:"JSON",
		success: function(json){
			$("#review_body").html(null);
			
			var template = "{{#reviewCount}}";
				template += "{{#reviewBody}}";
				template += "<li>";
				template += "	<span>{{shopname}}</span>";
				template += "	{{#point}}";
				template += "	<p class=\"star_comm star_type2\">";
				template += "		<span class=\"star_score star_rate\"><span class=\"star_score inner_star\" style=\"width:{{point_per}}%;\">별점 : </span></span>";
				template += "		<em class=\"num_rate\">{{point}}</em>";
				template += "	</p>";
				template += "	{{/point}}";
				template += "	<span class=\"writer\">{{username}} | {{date}}   {{#myreply}}<a class=\"delete\" href=\"javascript:///\" onclick=\"layerPop_del({{modelno1}},{{no}});\">삭제</a>{{/myreply}}</span>";
				template += "	<p class=\"shortBox\">{{{content}}}</p>";
				template += "	<p class=\"openBtn\"><button>더보기</button></p>";
				template += "</li>";					
				template += "{{/reviewBody}} ";
				template += "{{/reviewCount}}";
										
			
			if(json.reviewCount){
				$("#none_review").hide();
				$("#review_list").show();
				if(json.reviewCount < vReviewpagesize){
					$("#review_now").text(json.reviewCount);
					$("#review_cnt").text(commaNum(json.reviewCount));		
					$("#review_listin_cnt").text(commaNum(json.reviewCount) + "개");
					$("#tab3_cnt_txt").text(commaNum(json.reviewCount));
				}else{
					$("#review_now").text(vReviewpagesize);
					$("#review_cnt").text(commaNum(json.reviewCount));
					$("#review_listin_cnt").text(commaNum(json.reviewCount) + "개");
					$("#tab3_cnt_txt").text(commaNum(json.reviewCount));
				}
				
				if($("#review_now").text() == $("#review_cnt").text()){
					$("#review_list_more").hide();
				}
				
				var html = Mustache.to_html(template, json);
				
				if(html.length > 1){	
					html = html.replace(/&amp;/gi,"&");
					$("#review_body").html(html);	
				}
				
				reviewBind();
				
				//$("#review_prev").click(function(){
					//alert("이전");
				//	review_page(0);
				//});
				//$("#review_next").click(function(){
					//alert("다음");	
				//	review_page(1);
				//});
				$("#review_list_more").click(function(){
					//alert("다음");	
					review_page(1);
				});
				
			}else{
				$("#tab3_cnt_txt").text("0");
				$("#review_cnt").text("0");		
				$("#review_listin_cnt").text("0개");
				$("#none_review").show();
				$("#review_list").hide();
			}
		},
		error: function (xhr, ajaxOptions, thrownError) {
			//alert(xhr.status);
			//alert(thrownError);
		}
	});
}

function reviewBind(){
	//상품평보기에... 펼치기 접기 기능 바인딩

	var _this = $(this);
	//$('.prodDetailTab li').removeClass('on');
	//_this.parent().addClass('on');
	var tabIdx = _this.parent().index();
	$('.prodRating').removeClass('on');
	$('.prodRating').eq(tabIdx).addClass('on');
	$('.prodRating li .shortBox').each(function(){
		var _this = $(this);
		if (_this.height() > 57) {
			_this.parent().addClass('short');
		}
	});

	$('.prodRating .openBtn button').unbind("click");
	$('.prodRating .openBtn button').click(function(){
		var _this = $(this);
		_this.parent().parent().find('.shortBox').toggleClass('open');
		_this.toggleClass('on');
		_this.text('접기');
		if (_this.hasClass('on') != 1) {
		_this.text('더보기');
		}
	});
	
		
	$('#prev_more button').unbind("click");
	$('#prev_more button').click(function(){
		var _this = $(this);
		_this.parent().parent().find('.shortBox').toggleClass('open');
		_this.toggleClass('on');
		_this.text('접기');
		if (_this.hasClass('on') != 1) {
			_this.text('더보기');
		}
	});
}

function review_page(no){
	//$("body, html").animate({ scrollTop: $("#tab_position").offset().top }, 300); 

	if($("#review_now").text() == $("#review_cnt").text()){
		//alert("다음 없음");
		return false;
	}else{
		vReviewpage++;				
	}

	var vData = "modelno="+vModelno+"&pageno="+vReviewpage;
		
	$.ajax({
		type: "GET",
		url: "/mobilefirst/ajax/detailAjax/get_review.jsp",
		data: vData,
		dataType:"JSON",
		success: function(json){
			//$("#review_body").html(null);
			
			var template = "{{#reviewCount}}";
				template += "{{#reviewBody}}";
				template += "<li>";
				template += "	<span>{{shopname}}</span>";
				template += "	<span class=\"writer\">{{username}} | {{date}}    {{#myreply}}<a class=\"delete\" href=\"javascript:///\" onclick=\"layerPop_del(({{modelno1}},{{no}});\">삭제</a>{{/myreply}}</span>";
				template += "	<p class=\"shortBox\">{{content}}</p>";
				template += "	<p class=\"openBtn\"><button>더보기</button></p>";
				template += "</li>";					
				template += "{{/reviewBody}} ";
				template += "{{/reviewCount}}";
			
			if(no == 0){
				$("#review_now").text(vReviewpage * vReviewpagesize);
			}else{
				$("#review_now").text(Number($("#review_now").text()) + json.reviewBody.length);
			}
			
			if($("#review_now").text() == $("#review_cnt").text()){
				$("#review_list_more").hide();
			}
			
			var html = Mustache.to_html(template, json);
			
			if(html.length > 1)			
				$("#review_body").html($("#review_body").html() + html);	
			
			reviewBind();
		},
		error: function (xhr, ajaxOptions, thrownError) {
			//alert(xhr.status);
			//alert(thrownError);
		}
	});
}

function getListmore(){
	vListpage++;

	var vCnt = $("#list_more2").text();
	if(vCnt < vListnow+vListpagesize){
		$("#list_more1").text(vCnt);
		
		//getListDetail();
		
		$("#detail_list > li").show();
		
		$("#detail_list_more").hide();
	}else{
		vListnow = vListnow+vListpagesize;
		
		$("#list_more1").text(vListnow);
		
		//getListDetail();
		
		$("#detail_list > li:lt("+ vListnow +")").show();
	}
}

function getListDetail(){

}


function CmdShare(){ 
	if((SNS_URL+"").indexOf("resentzzim/resentzzimList.jsp")>-1) {
		varSNSTITLE = getResentZzimPageTitle();
		SNS_URL = getResentZzimPageUrl();
	}
		  
	varSNSURL = "m_url="+SNS_URL; 
	varSNSURL = varSNSURL.replace("http://www.enuri.com","http://m.enuri.com");
	varSNSURL = varSNSURL.replace("app=Y","app=");
	varSNSURL = varSNSURL.replace("?app=?","?");
	varSNSURL = varSNSURL.replace("m_url=","");
		
	var url = "/url_check/Short_Url_Rtn.jsp";
	var param2 = "org_url="+varSNSURL; 

	var Dns; 
	Dns = location.href; 
	Dns = Dns.split("//"); 
	Dns = "http://"+Dns[1].substr(0,Dns[1].indexOf("/")); 	
	 	
	$.ajax({  
		type: "POST",
		url: url,   
		data: param2,  
		success: function(result){ 	
			varSNSURL = Dns+"/short/"+result.trim();
		}
	});
	
	try{
		Kakao.Link.createTalkLinkButton({
			container: '#kakao-link-btn',
			label: "[에누리 가격비교]\n"+vModelnm,
			image: {
				//src: $("#d_img").attr("src"),
				src: vImg100,
				width: '200',
				height: '200'
		    },
		    webButton: {
		    	text: "상품 상세정보 보기",
				url: varSNSURL
			}
	    });
	}catch(e){
		//alert(e);
	}
}

function CmdShare_detail(param){ 
	varSNSTITLE = "[에누리 가격비교]\n";

	if(param == "tw"){
		try{    
			window.android.android_window_open("http://twitter.com/intent/tweet?text="+encodeURIComponent(varSNSTITLE+vModelnm)+"&url="+varSNSURL); 
		}catch(e){
			window.open("http://twitter.com/intent/tweet?text="+encodeURIComponent(varSNSTITLE+vModelnm)+"&url="+varSNSURL);
		}
	}else if(param == "face"){
		var url = varSNSURL; //공유할 URL 
		var image= var_img_enuri_com +"/images/mobile4/f_enuri.png";	//이미지 경로
		var title = varSNSTITLE; 														//페이스북 공유 제목 문구
		var summary = vModelnm; 													//페이스북 공유 상세문구
		try{   
			window.android.android_window_open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(title)+"&u="+url); 
		}catch(e){
			//url = "http://m.enuri.com";
			window.open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(title)+"&u="+url);
		} 
	}else if(param == "sms"){
		//try{ 
		//	window.android.android_send_sms("", varSNSTITLE+""+varSNSURL);
		//}catch(e){
			location.href="sms:?body="+varSNSTITLE+" "+vModelnm+"          "+varSNSURL;

		//}
	}else if(param == "line"){
		try{ 
			window.android.android_window_open("http://line.me/R/msg/text/?"+varSNSTITLE+vModelnm+"["+varSNSURL+"]");
		}catch (e){
			location.href="http://line.me/R/msg/text/?"+varSNSTITLE+vModelnm+"["+varSNSURL+"]";
		}
	}else if(param == "copy"){
		var ua = navigator.userAgent.toLowerCase();
		var isAndroid = ua.indexOf("android") > -1;
		if(isAndroid) {
			$("#url_text").text("아래의 URL을 길게 누르면 복사할 수 있습니다.");
		}else{
			$("#url_text").text("아래의 URL을 두번 누르면 복사할 수 있습니다.");
		}
		$("#layer_geturl").show();
		
		var layerPopHeight = $("#layer_geturl").find('.layerPopInner').height();
		$("#layer_geturl").find('.layerPopInner').css('margin-top','-'+ layerPopHeight / 2 + 'px' );
		
		$("#txt_getUrl").val(varSNSURL);
		
		$('.layerPop').append('<div class="dimmed"></div>');
		$('html, body').addClass('dimdOn');    
	    
	    
	}
	
	ga('send', 'event', 'mf_vip', 'vip', 'vip_공유_'+param);
}

function beforeSubmit() {

	try {
		$("input").each(function(){
		    $(this).val($(this).val().trim());
		});
		
		var nowMinPrice = vMinprice;
		var limitPriceLow = Math.ceil(nowMinPrice * 0.7);
		var limitPriceHigh = nowMinPrice - 1;
		$('#setprice').val(stripCommas($('#setprice').val()));
		var setMinPrice = $('#setprice').val();
		
		/*
		if( $('#setprice').val().length < 1 ) {
			alert(commaNum(limitPriceLow) + "원 ~ " + commaNum(limitPriceHigh) + "원 사이 가격을 입력하세요!");
			//$('#setprice').focus();
			$('#setprice').select();
			return false;
		} else if( /[^0-9]/.test(setMinPrice) || setMinPrice < limitPriceLow || setMinPrice > limitPriceHigh ) {
			alert(commaNum(limitPriceLow) + "원 ~ " + commaNum(limitPriceHigh) + "원 사이 가격을 입력하세요!");
			//$('#setprice').focus();
			$('#setprice').select();
			return false;
		}
		*/
		
		if($('#setprice').val().length < 1){
			alert("희망 최저가를 입력하세요.");
			return false;
		}else if($('#setprice').val().length > 10){
			alert("금액을 확인하시고 다시 입력해 주세요.");
			return false;
		}else if( /[^0-9]/.test(setMinPrice)){
			alert("숫자를 입력하세요.");
			return false;
		}
			
		if($('#phonenum2').val().length < 3	|| $('#phonenum3').val().length != 4) {
			$('#setprice').val(commaNum($('#setprice').val()));
			alert("올바른 휴대폰 번호를 입력하세요.");
			return false;
		}
		
		try {
			//window.parent.document.getElementById("priceNoti").style.display = "none";
		} catch(ex) {}
		
		insertLog('11030');
		
		ga('send', 'event', 'mf_vip', 'vip', 'vip_최저가알림받기');
		
		return true;
		
	} catch(ex) {}
}

function priceNotiClose(){
	$('.layerPop .dimmed').remove();
	$('html, body').removeClass('dimdOn');
	$("#layer_alarm").hide();
}

function newWin_Info(paramUrl){
	if(paramUrl.indexOf("/view/List.jsp") > -1 || paramUrl.indexOf("/view/Listmp3.jsp") > -1){
		paramUrl = paramUrl.replace("/view/List.jsp","/mobilefirst/list.jsp");
		paramUrl = paramUrl.replace("/view/Listmp3.jsp","/mobilefirst/list.jsp");
	}else if(paramUrl.indexOf("/view/Detailmulti.jsp") > -1 ){
		paramUrl = paramUrl.replace("/view/Detailmulti.jsp","/mobilefirst/detail.jsp");
	}
	  
	try{ 
		window.android.android_window_open(paramUrl); 
	}catch(e){
		window.open(paramUrl,"",""); 
	}
}
function Main_OpenWindow(OpenFile,names,nWidth,nHeight,ScrollYesNo,ResizeYesNo,Tposition,Lposition){
	var winsobj = window.open("",names,"width="+nWidth+",height="+nHeight+",toolbar=no,directories=no,status=no,scrollbars="+ ScrollYesNo +",resizable="+ ResizeYesNo +",menubar=no, top="+Tposition+",left="+Lposition+"");
	winsobj.moveTo(1,1);
	winsobj.location.href=OpenFile;
}

function show_write(){
	if(IsLogin()){
		$("#none_review").hide();
		
		$("#writerId").text(strID);
		$("#writerNick").text(vUserNick);
		$('#review_writefrm').show();
		
		$("#review_write_close").unbind("input propertychange");
		
		$('#review_textarea').bind('input propertychange', function() {
		    var text = $(this).val();
		    var limit = 500;
		    if(this.value.length >= limit){
				var new_text = text.substr(0, limit);  
	            $(this).val(new_text); 
		    }
		    
		    $("#review_now_taping").text(this.value.length);
		    
		  	$(this).css('height','auto');
			$(this).height(this.scrollHeight - 14);
		});
		
		$("#review_write_close").unbind("click");
		
		$("#review_write_close").click(function(){
			$('#review_writefrm').hide();
			
			if($("#review_listin_cnt").text() == "" || $("#review_listin_cnt").text() == "0개"){
				$("#none_review").show();
			}
			return false;
		});
		$("#review_write_up").unbind("click");
		$("#review_write_up").click(function(){
			review_chk();
		});
		
		insertLog('11796');
	}else{
		goLogin();
	}
}


function review_chk(){
	var formObj = document.getElementById("goodsbbsFrm");
	
	formObj.contents.value = $("#review_textarea").val();

	if(formObj.contents.value=="" || formObj.contents.value=="상품평을 입력하세요.") {
		alert("내용을 입력해 주세요.");
		return;
	}
	formObj.contents.value = formObj.contents.value.trim().replace(/&/gi,"&amp;").replace(/</gi, "&lt").replace(/>/gi, "&gt").replace(/\"/gi,"&quot");

	if(formObj.contents.value.length < 5) {
		alert("5자 이상 내용을 입력하셔야 등록이 가능합니다.");
		return;
	}

	formObj.procType.value 	= "insert";
	formObj.method 			= "post";
	formObj.target 			= "hFrame";
	formObj.modelno.value = vModelno;
	formObj.action = "/mobilefirst/include/Goods_bbs_proc.jsp";
	formObj.submit();
}
	
function cmdAfterKbWrite(){
	
	//글쓰기후 콜
	alert("등록 되었습니다.");
	//내용지우고 레이어닷고
	$("#review_textarea").val("상품평을 입력하세요.");
	$('#review_textarea').height(50);
	 $("#review_now_taping").text(0);
	$('#review_writefrm').hide();
	
	$("#goodsbbsFrm")[0].reset();
	
	getReview();

	insertLog('11797');
}


/*
 * layerPop_del : 댓글을 삭제한다.
 */
var del_modelno = 0;
var del_no 		= 0;

function layerPop_del(modelno,no){
	var formObj = document.getElementById("goodsbbsdelFrm");
	formObj.reset();
	document.getElementById("del_pass_input").value = "";
	del_modelno = modelno;
	del_no = no;
	
	$("#layer_del").show();
	var layerPopHeight = $("#layer_del").find('.layerPopInner').height();
	$("#layer_del").find('.layerPopInner').css('margin-top','-'+ layerPopHeight / 2 + 'px' );
	$('.layerPop').append('<div class="dimmed"></div>');
	$('html, body').addClass('dimdOn');
	
}

function layerPop_del_close(_this){
	$('.dimmed').remove();
	$('html, body').removeClass('dimdOn');
	$("#del_pass_input").val('');
	$("#layer_del").hide();
}
 

function submitDelBbs(){
	var formObj = document.getElementById("goodsbbsdelFrm");
	formObj.del_pass.value = document.getElementById("del_pass_input").value;

	if(formObj.del_pass.value.length < 2) {
		alert("2~12자의 영문,숫자로 입력하세요.");
		return;
	}

	if(!chkPassChar2(formObj.del_pass.value)) {
		alert("2~12자의 영문,숫자로 입력하세요.");
		return;
	}

	formObj.del_modelno.value 	= del_modelno;
	formObj.del_no.value 		= del_no;
	formObj.procType.value 		= "del";
	formObj.method 				= "post";
	formObj.target 				= "hFrame";
	formObj.action 				= "/mobilefirst/include/Goods_bbs_proc.jsp";

	formObj.submit();
}

function cmdAfterKbDel(){
	alert("삭제 되었습니다.");
	layerPop_del_close();
	
	$("#goodsbbsdelFrm")[0].reset();
	
	getReview();
}

function chkPassChar2(strPass) {
	var regExp = /^[a-zA-Z0-9_]{2,20}$/;

	return regExp.test(strPass);
}

function showDelMsgFlase(){
	alert("비밀번호가 틀렸습니다. 다시 입력하세요.");
	$("#del_pass_input").val("");
}

function insertLog(logNum){
	$.ajax({
		type: "GET",
		url: "/view/Loginsert_2010.jsp",
		data: "kind="+logNum,
		success: function(result){
		}
	});
}

function insertLog_cate(logNum,cate){
	$.ajax({
		type: "GET",
		url: "/view/Loginsert_2010.jsp",
		data: "kind="+logNum+"&cate="+cate,
		success: function(result){
		}
	});
}

function layerPop(_this){
	$('#'+_this).show();
	var layerPopHeight = $('#'+_this).find('.layerPopInner').height();
	$('#'+_this).find('.layerPopInner').css('margin-top','-'+ layerPopHeight / 2 + 'px' );
	$('.layerPop').append('<div class="dimmed"></div>');
	$('html, body').addClass('dimdOn');
	
	if(_this == "layer_alarm"){
		ga('send', 'event', 'mf_vip', 'vip', 'vip_최저가알림받기');
	}
}

function procChkButton(img,part) {
	$(".check_caution").fadeOut();
	$("#optionMorearea").show();
	$(".btnOptionSearch").show();
	var chkCnt = 0;
	
	if(img.checked) {
		img.checked = false;
		img.src="http://imgenuri.enuri.gscdn.com/images/mobilefirst/ico_chk.png";
	} else {
		img.checked = true;
		img.src="http://imgenuri.enuri.gscdn.com/images/mobilefirst/ico_chk_on.png";
	}

	if(part == 0){	//옵션 전체 체크
		if(img.checked) {
			var vModelno_arr = "";
			$(".chk_img").each(function(){
				this.checked = true;
				this.src="http://imgenuri.enuri.gscdn.com/images/mobilefirst/ico_chk_on.png";
				if(vModelno_arr != ""){
					vModelno_arr += ",";
				}
				vModelno_arr += $(this).attr("value");
			});
			vMulti_Modelno = vModelno_arr;
		}else{
			$(".chk_img").each(function(){
				this.checked = false;
				this.src="http://imgenuri.enuri.gscdn.com/images/mobilefirst/ico_chk.png";
			});
			vMulti_Modelno = vModelno_org;
		}
	}else{	//일반 옵션 체크 시
		var vModelno_arr = "";
		$(".chk_img").each(function(){
			if(this.checked) {
				this.src="http://imgenuri.enuri.gscdn.com/images/mobilefirst/ico_chk_on.png";
				if(vModelno_arr != ""){
					vModelno_arr += ",";
				}
				vModelno_arr += $(this).attr("value");
			}
		});
		
		vMulti_Modelno = vModelno_arr;		
	}
	for( var i = 0; i < $(".chk_img").length; i++){
		if($(".chk_img")[i].checked){
			chkCnt = chkCnt + 1;
		}
	}
	if(chkCnt == $(".chk_img").length){
		$("#option_check_all").attr("checked",true);
		$("#option_check_all").attr("src","http://imgenuri.enuri.gscdn.com/images/mobilefirst/ico_chk_on.png");
	}else{
		$("#option_check_all").attr("checked",false);
		$("#option_check_all").attr("src","http://imgenuri.enuri.gscdn.com/images/mobilefirst/ico_chk.png");
	}
	
	//alert(vModelno);
}
 
function procChkall(){
	$(".btnOptionSearch").hide();

	if($("#option_more_btn").css("display") ==  "none"){
		$("#optionMorearea").hide();	
	}

	if(vMulti_Modelno != ""){
	
		if((""+vMulti_Modelno).indexOf(",") > -1){

			vChkgroup = true;
			
			$("#list_sort").html("");
	
			get_base(vModelno);		

			var vMulti_Modelno_arr = vMulti_Modelno.split(",");
			var vMulti_optionnm = "";
			
			//옵션li에 색상 없에고. 선택된것만 색상넣어줌.
			$("#list_select > li").removeClass("selected");
			$(".option").removeClass("on");
			
			for(var i = 0;i < vMulti_Modelno_arr.length;i++){
				if(i > 0){
					vMulti_optionnm += " / ";
				}
				vMulti_optionnm += $("#select_mall_"+vMulti_Modelno_arr[i]).html();
				if( $("#select_mallcnt_"+vMulti_Modelno_arr[i]).html() != "<em></em>"){
					vMulti_optionnm += "("+ $("#select_mallcnt_"+vMulti_Modelno_arr[i]).html() + ")";
				}
				
				$("#optiondetail_"+vMulti_Modelno_arr[i]).addClass("selected");
				$("#optiondetail_"+vMulti_Modelno_arr[i]).find(".option").addClass("on");
			}
		
			$("#selected_option").show();
			$("#selected_option_txt").html(vMulti_optionnm.replace("c_8a909e","c_198ef5"));
			
			//옵션명이 없을때는 칸을 줄여서 보여준다.
			if($("#selected_option_txt").text() == ""){
				$("#list_head_model").hide();
			}
		
			vTab_Selected = "";
			
			vListpage = 1;
			getList();
		}else{
			//$("#optiondetail_"+vMulti_Modelno).click();
			set_option(vMulti_Modelno);
		}
	}else{
		//기본최저가 모델로 보냄.
		set_option(vModelno_org);
	}
	
	fnGoogleClick(2);
}


function init_tabs() {
	$(".tab_content").css("display","none");
	if (!$('ul.tabs').length) { return; }
	$('div.tab_content_wrap').each(function() {
		$(this).find('div.tab_content:first').show();
	});
	$('ul.tabs a').click(function() {
		if (!$(this).hasClass('current')) {
			$(this).addClass('current').parent('li').siblings('li').find('a.current').removeClass('current');
			$($(this).attr('href')).show().siblings('div.tab_content').hide();
		}
		if($(this).text() == "가격비교"){
			if($("#list_mallcnt").text() != ""){
				$(".fixSelectoption").show();
			}
		}else{
			$(".fixSelectoption").hide();
		}

		$("body, html").animate({ scrollTop: $("#tab_position").offset().top - 1 }, 500);
		this.blur();
		return false;
	});
}

function set_option(optionModelno){
	//옵션선택시.(개별선택)
	vChkgroup = false;
	vGroup = 0;
	//vInstanceMinPrice = 0;
	vListSort = "";
	$("#list_sort").html("");
	$(".btnOptionSearch").hide();
	
	if($("#option_more_btn").css("display") ==  "none"){
		$("#optionMorearea").hide();	
	}
	
	//옵션상단 체크박스해제
	$("#option_check_all").attr("checked",false);
	$("#option_check_all").attr("src","http://imgenuri.enuri.gscdn.com/images/mobilefirst/ico_chk.png");
	
	$(".chk_img").each(function(){
		this.checked = false;
		this.src="http://imgenuri.enuri.gscdn.com/images/mobilefirst/ico_chk.png";
	});
	vModelno = vModelno_org;
			
	select_list(optionModelno,0);
	//select_list_slide(0);
	getGuide();
}

var iosShareText = "";
		
function click_share(){

	if(varSNSURL == ""){
		CmdShare();
	}

	if(vAppyn == "Y" && vIosyn != 5939){
		location.href = "shareintent://["+varSNSTITLE+"]\n "+vModelnm+"\n "+varSNSURL;
	}else{
		$('#snsPop').toggle();
	} 
}

var vtMobileurl,vtShopcode,vtPlno,vtGoodscode,vtInstanceprice,vtCategory,vtPrice,vtMinprice,vtModelno;	//앱 상세설명용 변수
var vIosUrl, vIosDelivery, vIosshopnm, vIosprice;
var vShopbid_click = "";

function show_detail(url,mobileurl,shopcode,plno,goodscode,instanceprice,category,price,minprice,modelno,delivery,shopnm,shopbid_click){
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
	
	try{
		if(window.android){
			window.android.android_detail_review(url,delivery,shopnm,price);
		}else{
			//location.href = "appcall://detailViewInfo";
			location.href = "appcall://detailViewInfo?url="+encodeURIComponent(vIosUrl)+"&delivery="+vIosDelivery+"&shopnm="+vIosshopnm+"&price="+vIosprice;
		}
	}catch(e){}
	
	ga('send', 'event', 'mf_vip', 'vip', 'vip_상세정보미리보기');
}

function appCall_minshop(){
	if(vShopbid_click != ""){
		insertLog_cate(vShopbid_click,vtCategory.substring(0,4));
		vShopbid_click  = "";
	}
	goShop(vtMobileurl, vtShopcode, vtPlno, vtGoodscode, vtInstanceprice, vtCategory, vtPrice, vtMinprice,  this, vtModelno);
}


function go_floating(param){
	if(param == "cash"){
		location.href = "/mobilefirst/event2016/allpayback_201608.jsp?freetoken=event";
 
		ga('send', 'event', 'mf_vip', '[APP]도전 구매왕', '둥둥이');
	}else if(param == "summer"){
		location.href = "/mobilefirst/planlist.jsp?t=B_20160705111111&freetoken=list";
 
		ga('send', 'event', 'mf_vip', '둥둥이배너', '여름기획전');
	}else if(1 == 2 && param == "hunting"){
	/*
		$.ajax({
			type: "GET",
			url: "/event2016/hunting_getlist.jsp",
			dataType: "JSON",
			success: function(json){
				if(json.hunting){
					if(json.hunting == -1){
						alert("로그인 후 이벤트 참여가능합니다.");
						goLogin();
						//location.href = "/mobilefirst/event/luckybag_2016.jsp?freetoken=event";
					}else if(json.hunting >= 0){
						$.ajax({
							type: "GET",
							url: "/event2016/hunting_setlist.jsp",
							data : "job=1&eventid=8&modelno="+ vModelno +"&os_type="+ vOs_type,
							dataType: "JSON",
							success: function(json){
								if(json.result == "true"){
									alert("e머니 아이콘을\n획득 하셨습니다.");
								}else{
									alert("이미 획득한 e머니 아이콘 입니다.\n다른 상품에서 찾아 주세요~");
								}
							},
							error: function (xhr, ajaxOptions, thrownError) {
								//alert(xhr.status);
								//alert(thrownError);
							}
						});
					}
				}
			},
			error: function (xhr, ajaxOptions, thrownError) {
				//alert(xhr.status);
				//alert(thrownError);
			}
		});
	
		ga('send', 'event', 'mf_vip',  '[APP]새학기_e머니', '둥둥이');
		*/
	}
}   

function close_floating(param){
	if(param == "cash"){
		$("#vipbnr").hide();
	
		fnSetCookie2010( 'vip_promotion', 'cash_bnr', 1 );
	}else 	if(param == "summer"){
		$("#vipbnr").hide();
	
		fnSetCookie2010( 'vip_promotion', 'summer', 1 );
	}
}


function fnSetCookie2010( name, value, expiredays ){
	if (typeof(expiredays) == "undefined" || expiredays == null) {
		expiredays = "";
	}
	if (expiredays == ""){
		document.cookie = name + "=" + escape( value ) + "; path=/;";
	}else{
		var todayDate = new Date();
		todayDate.toGMTString();
		todayDate.setDate( todayDate.getDate() + expiredays );	
		document.cookie = name + "=" + escape( value ) + "; path=/;expires="+ todayDate.toGMTString() + ";";
	}
	
}	

function fnGoogleClick(param){
	var vTxtgoogle = "";
	var vTxtAction = "vip";
	if(param == 1){
		vTxtgoogle = "vip_현재위치";
	}else	if(param == 2){
		vTxtgoogle = "vip_선택 옵션 조회";
	}else	if(param == 3){
		vTxtgoogle = "vip_한줄보기";
	}else	if(param == 4){
		vTxtgoogle = "vip_좌우구분보기";
	}else	if(param == 5){
		vTxtgoogle = "vip_한줄보기_"+ vSort_txt;
		vTxtAction = "vip_sort";
	}else	if(param == 6){
		vTxtgoogle = "vip_좌우구분보기_"+ vSort_txt;
		vTxtAction = "vip_sort";
	}
	
	ga('send', 'event', 'mf_vip',vTxtAction, vTxtgoogle);
}

function rental_go(param_modelno){
	location.href = "/mobilefirst/rental.jsp?modelno="+param_modelno;
}

function getHunting(){
	var vTmphtml = "";
	
	/*				
	if(vRefer.indexOf("/mobilefirst/planlist.jsp")> -1){
		$.ajax({
			type: "GET",
			url: "/event2016/hunting_setlist.jsp",
			data : "job=2&eventid=8&modelno="+ vModelno +"&os_type="+ vOs_type,
			dataType: "JSON",
			success: function(json){
				if(json.result == "true"){	//최고우선순위 둥둥
					vTmphtml += "<span class=\"coin_bnr\" id=\"vipbnr\">";
					vTmphtml += "<a href=\"javascript:///\" class=\"evtgo\" onclick=\"go_floating('hunting');\">e머니</a>";
					vTmphtml += "</span>";
				}else{
					//floating banner
					if(vAppyn == "Y"){	//앱일때
						var vRandom_bnr = Math.floor((Math.random() * 2) + 1);
						
						if(vRandom_bnr == 1){
							//vTmphtml += "<span class=\"buy_bnr\" id=\"vipbnr\" style=\"display:none;\">";		//구매금액 100%지원
							//vTmphtml += "<a href=\"javascript:///\" class=\"evtgo\" onclick=\"go_floating('allpayback');\">구매금액 100% 전액지원</a>";
							//vTmphtml += "<a href=\"javascript:///\" onclick=\"close_floating('allpayback');\" class=\"btnclose\">닫기</a>";
							//vTmphtml += "</span>";
							vTmphtml += "<span class=\"first_bnr\" id=\"vipbnr\" style=\"display:none;\">";		//첫구매
							vTmphtml += "<a href=\"javascript:///\" class=\"evtgo\" onclick=\"go_floating('firstbuy');\">첫 구매시 5,000</a>";
							vTmphtml += "<a href=\"javascript:///\" onclick=\"close_floating('firstbuy');\" class=\"btnclose\">닫기</a>";
							vTmphtml += "</span>";
						}else{
							vTmphtml += "<span class=\"school_bnr\" id=\"vipbnr\" style=\"display:none;\">";		//새학기첫간식
							vTmphtml += "<a href=\"javascript:///\" class=\"evtgo\" onclick=\"go_floating('school');\">댓글쓰면 새학기 첫간식!</a>";
							vTmphtml += "<a href=\"javascript:///\" onclick=\"close_floating('school');\" class=\"btnclose\">닫기</a>";
							vTmphtml += "</span>";
						}
					}
				}
				
				$("#floating_banner").html(vTmphtml);
	
				if($("#vipbnr").hasClass("buy_bnr")){
					if(fnGetCookie2010("vip_promotion") != "allpayback"){
						$(".buy_bnr").show();
					}
				}else if($("#vipbnr").hasClass("first_bnr")){
					if(fnGetCookie2010("vip_promotion") != "firstbuy"){
						$(".first_bnr").show();
					}
				}else if($("#vipbnr").hasClass("school_bnr")){
					if(fnGetCookie2010("vip_promotion") != "school"){
						$(".school_bnr").show();
					}
				} 
				
				$(".evtgo").click(function(){
					$(".coin_bnr").hide();
				});
			},
			error: function (xhr, ajaxOptions, thrownError) {
				//alert(xhr.status);
				//alert(thrownError);
			}
		});
	}else{
	*/
		//floating banner
		if(vAppyn == "Y"){	//앱일때
			var vRandom_bnr = Math.floor((Math.random() * 2) + 1);
			//var vRandom_bnr = 1;

			if(vRandom_bnr == 1){
				vTmphtml += "<span class=\"cash_bnr\" id=\"vipbnr\" style=\"display:none;\">";		//사는만큼 돌려받자
				vTmphtml += "<a href=\"javascript:///\" class=\"evtgo\" onclick=\"go_floating('cash');\">사는만큼 돌려받자</a>";
				vTmphtml += "<a href=\"javascript:///\" onclick=\"close_floating('cash');\" class=\"btnclose\">닫기</a>";
				//vTmphtml += "<span class=\"first_bnr\" id=\"vipbnr\" style=\"display:none\">";
				//vTmphtml += "<a href=\"javascript:///\" class=\"evtgo\" onclick=\"go_floating('firstdd');\">첫 구매시 3,000원</a>";
				//vTmphtml += "<a href=\"javascript:///\" onclick=\"close_floating('firstdd');\" class=\"btnclose\">닫기</a>";
				vTmphtml += "</span>";
			}else{
				//vTmphtml += "<span class=\"lucky_bnr\" id=\"vipbnr\" style=\"display:none;\">";
				//vTmphtml += "<a href=\"javascript:///\" class=\"evtgo\" onclick=\"go_floating('luckytime');\">금요일 11시 선착순 1천명!</a>";
				//vTmphtml += "<a href=\"javascript:///\" onclick=\"close_floating('luckytime');\" class=\"btnclose\">닫기</a>";
				//vTmphtml += "</span>";
				
				vTmphtml += "<span class=\"summer_bnr\" id=\"vipbnr\" style=\"display:none;\">";
				vTmphtml += "<a href=\"javascript:///\" class=\"evtgo\" onclick=\"go_floating('summer');\">더위를 싹 여름상품전</a>";
				vTmphtml += "<a href=\"javascript:///\" onclick=\"close_floating('summer');\" class=\"btnclose\">닫기</a>";
				vTmphtml += "</span>";
			}
		}
		
		$("#floating_banner").html(vTmphtml);

		if($("#vipbnr").hasClass("cash_bnr")){
			if(fnGetCookie2010("vip_promotion") != "cash"){
				$(".cash_bnr").show();
			}
		}else if($("#vipbnr").hasClass("summer_bnr")){
			if(fnGetCookie2010("vip_promotion") != "summer"){
				$(".summer_bnr").show();
			}
		}
	//}
}

//var vNow_scroll = 0;

function onoff(id) {
	var mid=document.getElementById(id);
	if(mid.style.display=='') {
		mid.style.display='none';
		if(id == "skin_ly"){
			$("body").css("overflow-y","auto");
			//unlockScroll();
			//$("body").scrollTop(vNow_scroll);
		}
	}else{
		mid.style.display='';
	}
}

function bnrVip(){
	$.getJSON( "/mobilefirst/http/json/banner_list.json", function(json) {
		var bannerObj;
		var blWeb = false;
		
		var vAndroid = false;
			
		if(vAppyn == "Y"){	//앱일때
			if(window.android){
				vAndroid = true;
			}
		}else{		
			if(vIosyn != 5939){
				vAndroid = true;
			}
		}
		
		if(vAppyn == "Y"){	//앱일때
			if(json.appVip.banner){
				var bannerJson = new Array();
		
				$.each(json.appVip.banner, function(i, v){
					var sdate = replaceAll(v.sdate,"-" ,"/"); 
					sdate = new Date(sdate);
		                
					var edate = replaceAll(v.edate,"-" ,"/");
					edate = new Date(edate);
		                
					if(dateComparison(sdate,edate)){
						if(vAndroid && v.ANDROID == "Y"){
							bannerJson.push(v);
						}else if(!vAndroid && v.IOS == "Y"){
							bannerJson.push(v);
						} 
					}
				}); 
				
				var vnrVip = shuffle(bannerJson);
				bannerObj = vnrVip[0];
			}
		}else{
			if(json.webVip.banner){
				var bannerJson = new Array();
		
				$.each(json.webVip.banner, function(i, v){
					var sdate = replaceAll(v.sdate,"-" ,"/"); 
					sdate = new Date(sdate);
		                
					var edate = replaceAll(v.edate,"-" ,"/");
					edate = new Date(edate);
		                
					if(dateComparison(sdate,edate)){
						if(vAndroid && v.ANDROID == "Y"){
							bannerJson.push(v);
						}else if(!vAndroid && v.IOS == "Y"){
							bannerJson.push(v);
						} 
					}
				}); 
				
				var vnrVip = shuffle(bannerJson);
				bannerObj = vnrVip[0];
				blWeb = true;
			}
		}
		
		try{
			if(bannerObj.img != "Object"){
				var checkView = true;

				//2016-11-08 vip둥둥이 친구초대 예외처리				
				if(bannerObj.IOS == "N"){
					if(vIosyn == 5939){
						checkView = false;
					}
				}else if(bannerObj.ANDROID == "N"){
					if(vIosyn != 5939){
						checkView = false;
					}
				}
				
				if(checkView){
					var vTmphtml = "";
					if(blWeb){
						vTmphtml += "<span class=\"vip_bnr\" id=\"vipbnr\" style=\"display:none;background:url("+ bannerObj.img +") center 0 no-repeat; background-size:100px;margin-top:80px;\">";
					}else{
						vTmphtml += "<span class=\"vip_bnr\" id=\"vipbnr\" style=\"display:none;background:url("+ bannerObj.img +") center 0 no-repeat; background-size:100px;\">";			
					}
					vTmphtml += "<a href=\"javascript:///\" class=\"evtgo\" onclick=\"go_banner_link('"+ bannerObj.link +"','"+ bannerObj.name +"');\">"+ bannerObj.name +"</a>";
					vTmphtml += "<a href=\"javascript:///\" onclick=\"new_close_floating('vipbnr');\" class=\"btnclose\">닫기</a>";
					vTmphtml += "</span>";
				
					$("#floating_banner").html(vTmphtml);
					
					if(fnGetCookie2010("vip_promotion") != "vipbnr"){
						$(".vip_bnr").show();
					}
				}
				
				
			}
		}catch(e){}
		
	});
}

function go_banner_link(url, name){
	location.href = url;
	
	ga('send', 'event', 'mf_vip', '둥둥이배너', name+'_'+vOs_type);
}

function new_close_floating(param){
	$("#vipbnr").hide();
	
	fnSetCookie2010( 'vip_promotion', param, 1 );
}