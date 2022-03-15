import * as prodCommon from "./prod_common.js";
const param = {
	"modelno" : gModelData.gModelno
}

export const paramHandler = {
    set: (prop, value) => {
		param[prop] = value;
        return true;
    },
    get : (prop) => {
        return param[prop];
    },
    init : () =>{
        param["modelno"] = gModelData.gModelno;
    }
};
export const descPromise = () => {
    return new Promise((resolve,reject) => {
        $.ajax({
            type: "post",
            url: "/wide/api/product/prodDesc.jsp",
            data: param,
			dataType: "JSON",
            success: (response) => {
                resolve(response);
            }, error : (error) => {
                reject(error);
            }
        });
    });
};

export const prodDescView = async (json) => {
    let ecatal_out_yn = json["ecatal_out_yn"];
    let mall_desc_yn = json["mall_desc_yn"];
    let enuri_desc_yn = json["enuri_desc_yn"];
	let enuri_knwocom_guide_yn = json["enuri_knwocom_guide_yn"];
	
	let enuri_caution = json["enuri_caution"];
	if(typeof enuri_caution != "undefined"){
		let contentHtml =``;
		if(enuri_caution.content_type == "1"){
			contentHtml = `<div class="inner">`
			if(enuri_caution.content_list.length > 0){
				enuri_caution.content_list.forEach(a => {
					contentHtml += `${a.content}<br>`
				});
			}
			contentHtml += `</div>`;
			$("#prodDetail").find(".row__prodrelated").removeClass('is-thum');
		} else if(enuri_caution.content_type == "2"){
			contentHtml = `<div class="inner">
			<img src="http://storage.enuri.info/pic_upload/caution/${enuri_caution.img}" usemap="#Map" style="display:block;width:970px;margin:0 auto">`
			if(enuri_caution.imgmap_list.length > 0){
				contentHtml += `<map name="Map">`
				enuri_caution.imgmap_list.forEach(v => {
					contentHtml += `<area shape="rect" coords="${v.img_map}" href="${v.map_url}" target="_blank">`
				});
				contentHtml += `</map>`
			}
			contentHtml += `</div>`;

			$("#prodDetail").find(".row__prodrelated").addClass('is-thum');
		}
		$("#prodDetail").find(".row__prodrelated").html(contentHtml);
	}else{
		$('#prodDetail').find(".row__prodrelated").hide();
	}
	$("#prodDetail").find(".tab__list li").removeClass("is-on");
	$("#prodDetail").find(".specdetail .sd__container .sd__cont").removeClass("is-shown");
	$("#prodDetail").find(".section__cont .specdetail .sd__container").removeClass('is-unfold');
    //요약설명 table형태
    let enuri_spec_table = json["enuri_spec_table"];
	let enuri_kc_info = json["enuri_kc_info"];
    let enuri_spec_text = json["enuri_spec_text"];
    enuri_spec_text = enuri_spec_text.replace("&nbsp;&nbsp;/&nbsp;&nbsp;","/");
	prodDescTableView(enuri_spec_table, enuri_kc_info,enuri_spec_text);
	//탭
	if(ecatal_out_yn=="N" && mall_desc_yn=="N" && enuri_desc_yn=="N" && enuri_knwocom_guide_yn=="N"){ //상세설명이 아무것도 없음
        $('#prodDetail .specdetail').hide();
        return;
    }

    if(ecatal_out_yn=="Y"){
        $('#prodDetail .specdetail').show();
        $('#opt_ecatal_out').show();
    }else{
		$('#opt_ecatal_out').hide();
    }
    if(mall_desc_yn=="Y"){
		$('#prodDetail .specdetail').show();
		$('#opt_mall_desc').show();
    }else{
        $('#opt_mall_desc').hide();
    }

    if(enuri_desc_yn=="Y"){
		$('#prodDetail .specdetail').show();
        $('#opt_enuri_desc').show();
    }else{
        $('#opt_enuri_desc').hide();
    }
	if(enuri_knwocom_guide_yn=="Y"){
		$('#prodDetail .specdetail').show();
        $('#opt_knowcom_guide').show();
    }else{
        $('#opt_knowcom_guide').hide();
    }
 	if(ecatal_out_yn=="Y"){
		prodExplainEcatalView(json);
		$('#opt_ecatal_out').addClass("is-on");
        $("#prodDetail").find(".sd__cont").addClass("is-shown");
    }else if(ecatal_out_yn=="N"){
        if(enuri_desc_yn=="Y"){
			prodExplainEnuriView(json);
            $('#opt_enuri_desc').addClass("is-on");
            $("#prodDetail").find(".sd__cont").addClass("is-shown");
        } else if(mall_desc_yn=="Y"){
			prodExplainMallView(json);
			$('#opt_mall_desc').addClass("is-on");
			$("#prodDetail").find(".sd__cont").addClass("is-shown");
        } else if(enuri_knwocom_guide_yn=="Y"){
			prodExplainKnowcomGuideView(json);
			$('#opt_knowcom_guide').addClass("is-on");
			$("#prodDetail").find(".sd__cont").addClass("is-shown");
		}
	
    } 

	
	/*if(enuri_desc_yn=="Y"){
		prodExplainEnuriView(json);
		$('#opt_enuri_desc').addClass("is-on");
		$("#prodDetail").find(".sd__cont").addClass("is-shown");
	}else if(enuri_desc_yn=="N"){
		if(ecatal_out_yn=="Y"){
			prodExplainEcatalView(json);
			$('#opt_ecatal_out').addClass("is-on");
			$("#prodDetail").find(".sd__cont").addClass("is-shown");
		}else if(mall_desc_yn=="Y"){
			prodExplainMallView(json);
			$('#opt_mall_desc').addClass("is-on");
			$("#prodDetail").find(".sd__cont").addClass("is-shown");
        }
	}*/

	if($("#prodDetail").find(".section__cont .specdetail .sd__container .thum_wrap img").length > 0 ){
		$("#prodDetail").find(".section__cont .specdetail .sd__container .thum_wrap img").on("load",function(){
			if($("#prodDetail").find(".section__cont .specdetail .sd__container .sd__cont.is-shown .inner").height() >= 850){
				$("#prodDetail").find(".section__cont .specdetail .btn__group").show();
			}else{
				$("#prodDetail").find(".section__cont .specdetail .btn__group").hide();
			}	
		});
	}else{
		if($("#prodDetail").find(".section__cont .specdetail .sd__container .sd__cont.is-shown .inner").height() >= 850){
			$("#prodDetail").find(".section__cont .specdetail .btn__group").show();
		}else{
			$("#prodDetail").find(".section__cont .specdetail .btn__group").hide();
		}
	}

	let $btnUnfold = $("#prodDetail").find(".section__cont .specdetail .btn__unfold"); // 펼치기
	let $btnFold = $("#prodDetail").find(".section__cont .specdetail .btn__fold"); // 펼치기

	$btnUnfold.click(function(){
		$(this).parents(".btn__group").siblings('.sd__container').addClass('is-unfold');
	})
	$btnFold.click(function(){
		$(this).parents(".btn__group").siblings('.sd__container').removeClass('is-unfold');
		// 스크롤 이동
		let movPos = $(".specdetail").offset().top + (850 - $(window).height());
		$("html,body").stop(true,false).animate({"scrollTop":movPos},"slow");
	});
	// TAB 공통
	let $tabs = $("#prodDetail").find(".section__cont .specdetail .tab__list"),
		$tabs_item = $tabs.find("li"),
		$tabCont = $("#prodDetail").find(".section__cont .specdetail .sd__cont");
		$tabs_item.click(function(){
			let _this = $(this);
			let _thisId = $(this).attr("id");
			
			_this.siblings("li").removeClass("is-on");
			_this.addClass("is-on");
			$("#opt_knowcom_guide_swiper").hide();
			
			if(_thisId=="opt_ecatal_out"){
				ga('send','event','vip','Product_tab','Maker');
				prodExplainEcatalView(json);
			}else if(_thisId=="opt_mall_desc"){
				ga('send','event','vip','Product_tab','Shop');
				prodExplainMallView(json);
			}else if(_thisId=="opt_enuri_desc"){
				ga('send','event','vip','Product_tab','Shopping mall');
				prodExplainEnuriView(json);
			}else{
				ga('send','event','vip','Product_tab','Guide');
				prodExplainKnowcomGuideView(json);
			}
			
			$tabCont.removeClass("is-shown")
			$tabCont.addClass("is-shown");

			$("#prodDetail").find(".section__cont .specdetail .sd__container").removeClass('is-unfold');
			if($("#prodDetail").find(".section__cont .specdetail .sd__container .thum_wrap img").length > 0 ){
				$("#prodDetail").find(".section__cont .specdetail .sd__container .thum_wrap img").on("load",function(){
					if($("#prodDetail").find(".section__cont .specdetail .sd__container .sd__cont.is-shown .inner").height() >= 850){
						$("#prodDetail").find(".section__cont .specdetail .btn__group").show();
					}else{
						$("#prodDetail").find(".section__cont .specdetail .btn__group").hide();
					}	
				});
			}else{
				if($("#prodDetail").find(".section__cont .specdetail .sd__container .sd__cont.is-shown .inner").height() >= 850){
					$("#prodDetail").find(".section__cont .specdetail .btn__group").show();
				}else{
					$("#prodDetail").find(".section__cont .specdetail .btn__group").hide();
				}
			}
		});
}

const prodDescTableView = (enuri_spec_table,enuri_kc_info,enuri_spec_text) => {
	if(typeof enuri_spec_table != "undefined" && enuri_spec_table.length > 0){
		let html = ``;
		let thCnt = 0;
		for(let i=0;i<enuri_spec_table.length;){
			let specGroupname = enuri_spec_table[i].specGroupname;
			let specTitle = enuri_spec_table[i].specTitle;
			let specContent = enuri_spec_table[i].specContent;
			let specCellcnt = enuri_spec_table[i].specCellcnt;
			let att_kbno = enuri_spec_table[i].att_kbno;
			let att_id = enuri_spec_table[i].att_id;
			let att_el_kbno = enuri_spec_table[i].att_el_kbno;
			let att_el_id = enuri_spec_table[i].att_el_id;

			let tmpContent = "";
			let tmpTitle ="";
			if(specGroupname != "" || i==0){
				thCnt=0;
				html += `${i>0 ? `</table></dd>` :``}
					<dt>${specGroupname}</dt>
					<dd><table class="tb__spec">`;
			}
			
			if(specCellcnt > 1){
				let j = 0;
				for(j=0;j<specCellcnt;j++){
					if(j > 0) tmpContent += `,`;
					if(enuri_spec_table[i+j].att_el_kbno > 0){
						tmpContent += `<a href="javascript:void(0)" class="lay__def" onclick="showDicLayer(this);insertLogCate(14523);" data-kbno="${att_el_kbno}" data-attr_id="${enuri_spec_table[i+j].att_id}" data-attr_el_id="${enuri_spec_table[i+j].att_el_id}">${enuri_spec_table[i+j].specContent}</a>`;
					}else{
						tmpContent += `${enuri_spec_table[i+j].specContent}`;
					}
					tmpTitle = specTitle;
				}					
				i += j;
			}else{
				tmpContent = (att_el_kbno > 0 ) ? `<a href="javascript:void(0)" class="lay__def" onclick="showDicLayer(this);insertLogCate(14523);"  data-attr_id="${att_id}" data-attr_el_id="${att_el_id}">${specContent}</a>` : specContent
				tmpTitle = (att_kbno > 0) ? `<a href="javascript:void(0)" class="lay__def" onclick="showDicLayer(this);insertLogCate(14523);"  data-attr_id="${att_id}" data-attr_el_id="0">${specTitle}</a>` : specTitle
				i++;
			}
			
			if(thCnt%2==0){
				html += `<tr>`;
			}
			html += `	<th>${tmpTitle}</th>
						<td>${tmpContent}</td>`;
			thCnt++;
			if(thCnt%2==0 || i==enuri_spec_table.length){
				html += `</tr>`;
		   	}
			if(i==enuri_spec_table.length) html +=`</table></dd>`;
		}
		$("#enuri_spec_table").html(html);
		$("#enuri_spec_table").find(".tb__spec tr").each(function(){ 
			if($(this).siblings().length>0 && $(this).find("td").length%2==1)
			{	
				$(this).find("td").attr("colspan",3);
			}  
		});
	}else{
		
	}

	if(typeof enuri_kc_info != "undefined"){
		let html = ``;
		let kcObj = enuri_kc_info.kc_info;
		let cert_name = "";
		let cert_key = "";
		let cert_link = "";
		let isViewCert = "N";
		let isViewSuit = "N";
		//전기용품 안전인증 검사 - 노출 카테고리 일 경우
		if (kcObj.cert_yn != "" && kcObj.cert_yn == "Y") {
			if (kcObj.cert_value != "T" && kcObj.cert_name != "" && kcObj.cert_key != "") { // template 가 아닌 경우
				cert_name = kcObj.cert_name;
				cert_key = kcObj.cert_key;
				cert_link = "http://safetykorea.kr/search/searchPop?certNum=" + cert_key + "&menu=search";
			} else {
				cert_name = "안전인증";
				cert_key = "상세 쇼핑몰 참고";
				cert_link = "http://safetykorea.kr/";
			}
			isViewCert = "Y";
		} else {
			isViewCert = "N";
		}

		let suit_key = "";
		let suit_link = "http://rra.go.kr/ko/license/A_c_search.do";
		//적합성 평가 검사 - 노출 카테고리 일 경우
		if (kcObj.suit_yn != "" && kcObj.suit_yn == "Y") {
			if (kcObj.suit_value != "T" && kcObj.suit_key != "") {
				suit_key = kcObj.suit_key;
			} else {
				suit_key = "상세 쇼핑몰 참고";
			}
			isViewSuit = "Y";
		} else {
			isViewSuit = "N";
		}

		
		html+=`
		<dt><i class="ico ico--kc"></i>인증정보</dt>
		<dd>
			<table class="tb__spec">
				<tbody>
					${isViewCert=="N" ? `` : `
					<tr>
						<th>${cert_name}</th>
						<td>${cert_key} <a href="${cert_link}" class="btn btn__kc" target="_blank">인증정보 확인</a></td>
					</tr>`}
					${isViewSuit =="N" ? `` : `	
					<tr>
						<th>적합성평가인증<i class="ico ico--question">?</i>
							<div class="lay-tooltip lay-comm">
								<div class="lay-comm--head">
									<strong class="lay-comm__tit">적합성평가인증</strong>
								</div>
								<div class="lay-comm--body">
									<div class="lay-comm__inner">
										전파 환경 및 방송통신망 등에 유해를 줄 우려가 있는 기자재에 해당하는 적합인증, 적합등록 또는 잠정인증 중 하나의 인증을 받아야 합니다.
									</div>
								</div>
							</div>
						</th>
						<td>${suit_key} <a href="${suit_link}" class="btn btn__kc" target="_blank">인증정보 확인</a></td>
					</tr>`}
				
				</tbody>
			</table>
		</dd>`;
		if(isViewCert=="Y"){
			$("#enuri_kc_info").html(html);
			$("#enuri_kc_info").show();
		}else{
			$("#enuri_kc_info").hide();
		}
	}else{
		$("#enuri_kc_info").hide();
	}
}
const prodExplainEcatalView = (json) => {
	let ecatal_out_src = json["ecatal_out_src"]; //이미지url
	let ecatal_out_from = json["ecatal_out_from"]; //제공 업체명
	let enuri_under19_yn = json["enuri_under19_yn"]; //제공 업체명
	let html =``;
	if(ecatal_out_src.length > 0){
		html += `<div class="inner">
					<div class="tx_wrap">
						<p class="tx_mall">제조사 : ${ecatal_out_from}</p> 
						<p class="tx_noti">본 컨텐츠는 ${ecatal_out_from}에서 제공받은 정보이며, 판매 가격과는 무관합니다.</p></div>`;
		if(enuri_under19_yn=="Y"){
			html +=`<div  class="prod--exception-adult" >
						<div class="tx_box">
							<p class="tx_exception">본 건텐츠는 청소년 유해 매체물로서 정보통신망 이용 및<br>정보보호 등에 관한 법률, 청소년 보호법 규정에 의하여<br>19세 미만의 청소년이 이용할 수 없습니다.</p>

							<ul class="btn__list">
								<li><a href="javascript:void(0);" class="btn btn--black" onclick="$('#lay_adult_wrap').show();">성인인증 후 사진보기</a></li>
							</ul>
						</div>
					</div>`;
		}else{
			html +=`<div class="thum_wrap">`;
			$.each(ecatal_out_src, (i,v) => {
				html +=`<img class="listShowImg" data-original="${v}" src="${v}" onerror="this.src='http://img.enuri.info/images/home/thum_none.jpg'" >`;
			});
			html +=`</div>`;
		}
		html +=`</div>`;		
		$("#prodDetail").find(".specdetail .sd__container .sd__cont").html(html);
	}else{
		//$("#sdTab1").empty();
		$("#prodDetail").find(".specdetail .sd__container .sd__cont").empty();
	}
	//$("#sdTab1").html(html);
}
const prodExplainMallView = (json) =>{
	let enuri_under19_yn = json["enuri_under19_yn"];
	let mall_desc_plno = json["mall_desc_plno"];
	let mall_desc_shopcd = json["mall_desc_shopcd"];
	let mall_desc_contents = json["mall_desc_contents"].replace("<style","<!-- style").replace("/style>","/style -->");
	let mall_desc_shopnm = json["mall_desc_shopnm"];
	let html =``;
	mall_desc_contents = mall_desc_contents.replace(/<STYLE/gi,"<!-- <style").replace(/STYLE>/gi,"style> -->");
	mall_desc_contents = mall_desc_contents.replace(/<LINK/gi,"<!-- <style").replace(/LINK>/gi,"style> -->");
	try{
		if(mall_desc_shopnm && mall_desc_shopnm.length>0 && mall_desc_contents && mall_desc_contents.length>0){
			html += `<div class="inner">
						<div class="tx_wrap">
							<p class="tx_mall">이미지제공 : ${mall_desc_shopnm}</p>
							<p class="tx_noti shopnoti_1">에누리 가격비교는 공개된 자료를 기반으로 상품정보를 제공합니다. 쇼핑몰에서 제공하는 상품정보와 다를 수 있으니, 구매 전 쇼핑몰의 상품정보를 다시 한번 확인해주세요. (<a href="/etc/disclaimer.jsp" target="_blank">법적고지 보기</a>)</p>
							<p class="tx_noti shopnoti_2">본 컨텐츠는 ${mall_desc_shopnm} 상세정보 미리보기 입니다. <a href="javascript:void(0);" class="link_mall">해당 쇼핑몰 바로가기</a></p>
						</div>
					${enuri_under19_yn=="Y" ? 
						`<div class="prod--exception-adult">
							<div class="tx_box">
								<p class="tx_exception">본 건텐츠는 청소년 유해 매체물로서 정보통신망 이용 및<br>정보보호 등에 관한 법률, 청소년 보호법 규정에 의하여<br>19세 미만의 청소년이 이용할 수 없습니다.</p>

								<ul class="btn__list">
									<li><a href="javascript:void(0);" class="btn btn--black" onclick="$('#lay_adult_wrap').show();">성인인증 후 사진보기</a></li>
								</ul>
							</div>
						</div>` :`	<div class="thum_wrap">${mall_desc_contents}</div> `}
				</div>`;
		}
		$("#prodDetail").find(".specdetail .sd__container .sd__cont").html(html);
	}catch(e) {
		$("#prodDetail").find(".specdetail .sd__container .sd__cont").empty();
	}
	if(mall_desc_plno && parseInt(mall_desc_plno)>0){
		$('#sdTab2 .tx_noti a.link_mall').click(function() {
			//해당 쇼핑몰 링크
			let bridgeUrl =prodCommon.bridgeUrl('move_link',`${mall_desc_shopcd}`,`${gModelData.gModelno}`,`${gModelData.gFactory}`,`${mall_desc_plno}`,`0`,``,1);
			window.open(bridgeUrl);
			return false;
		});
	}
}
const prodExplainEnuriView = (json) =>{

	//에누리 상세정보 호출

	//$('#area_enuri_desc').show();
	let load_enuri_desc = true;

	let enuri_under19_yn = json["enuri_under19_yn"]; //성인용품 19금 처리여부
	let html =`<div class="inner">`;
	if(enuri_under19_yn=="Y") { //19금처리
	html +=`	<div class="prod--exception-adult">
						<div class="tx_box">
							<p class="tx_exception">본 건텐츠는 청소년 유해 매체물로서 정보통신망 이용 및<br>정보보호 등에 관한 법률, 청소년 보호법 규정에 의하여<br>19세 미만의 청소년이 이용할 수 없습니다.</p>

							<ul class="btn__list">
								<li><a href="javascript:void(0);" class="btn btn--black" onclick="$('#lay_adult_wrap').show();">성인인증 후 사진보기</a></li>
							</ul>
						</div>
					</div>
				</div>`;	
	}else{
		//큰이미지
		let bigImageUrlStr = json["bigimage"];
		let bigimage_webshopnm = json["bigimage_webshopnm"];
		let bigimage_webplno = json["bigimage_webplno"];

		let enuriPcViewYn = json["enuripc_view_yn"];
		let enuripcImgUrl = json["enuripc_img_url"];
		let enuri_spec_table = json["enuri_spec_table"];
		let enuri_spec_text = json["enuri_spec_text"];
	
		html +=` <div class="tx_wrap">`;

		
		if(typeof bigimage_webshopnm != "undefined" && bigimage_webshopnm.length>0){
			html +=`			<p class="tx_mall">이미지제공 : ${bigimage_webshopnm}</p>`;
		}
		html +=`	<p class="tx_noti">에누리 가격비교는 공개된 자료를 기반으로 상품정보를 제공합니다. 쇼핑몰에서 제공하는 상품정보와 다를 수 있으니, 구매 전 쇼핑몰의 상품정보를 다시 한번 확인해주세요. (<a href="/etc/disclaimer.jsp" target="_blank">법적고지 보기</a>)</p>`;
		
		if(typeof enuri_spec_table != "undefined" && enuri_spec_table.length > 0){
		}else if(typeof enuri_spec_text != "undefined" && enuri_spec_text.length >0){
			enuri_spec_text = enuri_spec_text.replace("&nbsp;&nbsp;/&nbsp;&nbsp;","/");
			html += `<div class="tx_similarinfo"><p class="tx_sort"><span>${enuri_spec_text}</span></p></div>`;
		}
		//사이즈 정보
		let enuri_size = json["enuri_size"];

		if(typeof enuri_size != "undefined" || typeof enuri_cateicon != "undefined") {
			html+=`<ul class="tx_speclist">`;
			if(typeof enuri_size != "undefined") {
				let g_sizeStrAry = enuri_size.split("^");
				if(g_sizeStrAry.length>0) {
					$.each(g_sizeStrAry, (index, listData) =>{
						html +=`<li>${listData}</li>`;
					});
				}
			}
			if(typeof enuri_cateicon != "undefined") {
				if(enuri_cateicon.length>0) {
					$.each(enuri_cateicon, (index, listData) =>{
						html += `<li><img src="${listData}" alt=""></li>`;
					});
				}
			}
			html+= `</ul>`;
		}

		let goods_attribute_certi = json["goods_attribute_certi"];
		let goods_attribute_allergy = json["goods_attribute_allergy"];
		let func_icons = json["enuri_func_icon"];


		if(typeof goods_attribute_certi != "undefined" || typeof goods_attribute_allergy != "undefined" || typeof func_icons != "undefined"){
			html +=`<div class="flag_box">`;
			html +=`	<ul>`;
			if(typeof goods_attribute_certi != "undefined"){
				$.each(goods_attribute_certi, function(Index, listData) {
					let certi_attribute_id = listData["attribute_id"];
					let certi_attribute_element_id = listData["attribute_element_id"];
					let certi_iconno = listData["iconno"];
					let certi_attribute_element = listData["attribute_element"];
					let certi_ref_kb_no = listData["ref_kb_no"];
					
					if(certi_iconno) {
						html += "<li>";
						if(certi_ref_kb_no>0){
							html +="<a href=\"javascript:///\" onclick=\"insertLogCate(14523);showTermDic("+certi_attribute_id+", "+certi_attribute_element_id+", this);\"><span class=\"brup\"></span>";
						}
						html +="<img src=\"http://img.enuri.info/images/f_icon/"+certi_iconno+"_b.gif\" alt=\""+certi_attribute_element+"\">";
						if(certi_ref_kb_no>0){
							html +="</a>";
						}
						html +="</li>";
	
					}
				});
			}
			//알레르기성분
			
			if(typeof goods_attribute_allergy != "undefined"){
				$.each(goods_attribute_allergy, function(Index, listData) {
					let allergy_attribute_id = listData["attribute_id"];
					let allergy_attribute_element_id = listData["attribute_element_id"];
					let allergy_iconno = listData["iconno"];
					let allergy_attribute_element = listData["attribute_element"];
					let allergy_ref_kb_no = listData["ref_kb_no"];
					if(allergy_iconno > 0) {
						if(allergy_ref_kb_no>0){
							html += `<li><img src="http://img.enuri.info/images/f_icon/${allergy_iconno}}_b.gif" alt="${allergy_attribute_element}"></li>`;
						}else{
							html += `<li><img src="http://img.enuri.info/images/f_icon/${allergy_iconno}_b.gif" alt="${allergy_attribute_element}"></li>`;
						}
					}
				});
			}
	
			//스펙 아이콘
		
			if(typeof func_icons != "undefined"){
				$.each(func_icons, function(Index, listData) {
					let func_iconsItem = listData["iconno"];
					
					if(func_iconsItem >0) {
						html +=`<li><img src="http://img.enuri.info/images/f_icon/${func_iconsItem}_b.gif" alt=""></li>`;
					}
				});
			}
			html +=`	</ul>`;
			html +=`</div>`;
		}

		//PC견적 이미지 사용 시 이미지 경로 변경 함.
		if (typeof enuriPcViewYn != "undefined" && enuriPcViewYn == "Y" && typeof enuripcImgUrl != "undefined" && enuripcImgUrl.length > 0) {
			bigImageUrlStr = enuripcImgUrl;
		}
		if(typeof bigImageUrlStr != "undefined" && bigImageUrlStr.length>0) {
			if(typeof bigimage_webshopnm != "undefined" && bigimage_webshopnm.length>0){
				let bridgeUrl =prodCommon.bridgeUrl('move_link','',`${gModelData.gModelno}`,`${gModelData.gFactory}`,`${bigimage_webplno}`,`0`,``,1);
				if(parseInt(bigimage_webplno)>0){
					html += `<div class="thum_wrap" style=""><img src="${bigImageUrlStr}" style="cursor:pointer" target="_blank" onclick="window.open('${bridgeUrl}');" ></div>`;
				}
			}else{
				html += `<div class="thum_wrap" style=""><img src="${bigImageUrlStr}" ></div>`;
			}
		}else{
			html += `<div class="thum_wrap" style=""></div>`;
		}
	}
	//
	//상세설명
	
	let enuri_func_title = json["enuri_func_title"];
	let enuri_func_1 = json["enuri_func_1"];
	let enuri_func_2 = json["enuri_func_2"];
	let enuri_func_3 = json["enuri_func_3"];
	var enuri_func_scrap = json["enuri_func_scrap"];
	let enuri_cm_desc_html =``;
	if(typeof enuri_func_1 == "undefined" && typeof enuri_func_2 == "undefined" && typeof enuri_func_3 == "undefined"){
	}else{
		enuri_cm_desc_html = `
			<div class="cmdetail" id="desc_cm">
				<div class="cmdetail__head">
					<p class="tx_tit">상세설명</p>
					<p class="tx_sub">${typeof enuri_func_title != "undefined" && enuri_func_title.length>0 ? `${enuri_func_title}` : ``}</p>
					${enuri_func_scrap && enuri_func_scrap=="Y" ?  `<button type="button" class="btn btn__share" style="display:none;" onclick="alert('점검 중입니다. 이용에 불편을 드려 죄송합니다.');">퍼가기</button>` : ``}
					<div class="lay-cm-share lay-comm">
						<div class="lay-comm--head">
							<strong class="lay-comm__tit">카탈로그 퍼가기</strong>
						</div>
						<div class="lay-comm--body">
							<div class="lay-comm__inner">
								<p class="tx_msg">약관에 먼저 동의하셔야 카탈로그 퍼가기 이용이 가능합니다.<br>해당 저작권자의 요청이 있을 경우 카탈로그 퍼가기 제한이 있을 수 있습니다.</p>

								<p class="tx_boxtit">카탈로그 퍼가기 이용 약관</p>
								<div class="box_border">
									<ol class="order-list">
										<li>(주)써머스플랫폼은 상품정보의 정확도, 제조사 상표권 등에 대해 법적인 책임을 지지 않습니다.</li>
										<li>에누리 무료 카탈로그는 무단 수정 및 재배포를 금지합니다. 위반시 법적인 책임을 지게 됩니다.</li>
										<li>퍼가신 카탈로그는 당사 서버에 링크되어 수시 개선되며, 제품판매시에는 기간 제한이 없습니다.
											<ul class="order-list--sub">
												<li>① 오픈마켓 판매자 : 제한없음(제품판매시)</li>
												<li>② 입점전문몰 : 퇴점일까지 (퇴점이후 적용 카탈로그 삭제)</li>
											</ul>
										</li>
										<li>과다 트래픽 발생시 당사는 최대한 정상 서비스를 위해 노력하지만 서비스가 일시 중단될 수도 있습니다</li>
									</ol>
								</div>

								<p class="tx_agree">
									<input type="checkbox" id="chkCMSHARE_01" class="input--checkbox-item"><label for="chkCMSHARE_01">위 약관에 동의합니다.</label>
								</p>

								<button id="enuri_func_scrap_go" class="lay-comm__btn lay-btn--md lay-btn--color--blue">퍼가기</button>
							</div>
						</div>
						<!-- 버튼 : 레이어 닫기 -->
						<button class="lay-comm__btn--close comm__sprite" onclick="$(this).closest('.lay-comm').hide()">레이어 닫기</button>
					</div>
				</div>

				<div class="cmdetail__cont">
					<ul class="cmdetail__list">
						<li id="desc_cm_col1">${typeof enuri_func_1 != "undefined" && enuri_func_1.length>0 ? `<pre>${enuri_func_1}</pre>` : ``}</li>
						<li id="desc_cm_col2">${typeof enuri_func_2 != "undefined" && enuri_func_2.length>0 ? `<pre>${enuri_func_2}</pre>` : ``}</li>
						<li id="desc_cm_col3">${typeof enuri_func_3 != "undefined" && enuri_func_3.length>0 ? `<pre>${enuri_func_3}</pre>` : ``}</li>
					</ul>
				</div>
			</div>`;
	}
	html += enuri_cm_desc_html;

	if(enuri_func_scrap && enuri_func_scrap=="Y"){
		/*$('#enuri_func_scrap_go').click(function() {

			 if(!$("#chkCMSHARE_01").is(":checked")){
				alert("카탈로그 퍼가기 이용 약관에 동의하셔야 퍼가기가 가능합니다.");
			}else if($("#chkCMSHARE_01").is(":checked")){
				var s_param = {
					"modelno" : gModelData.gModelno,
					"userid" : "enuri",
					"imgtype" : 1,
					"widthtype" : 1
				}
				$.ajax({
					type : "get",
					url : "/view/include/catalog/AjaxGetCatalogImage.jsp",
					async: true,
					data : s_param,
					dataType : "html",
					success: function(json) {
						var catal_result = json;
						var varImgUrl = "http://storage.enuri.info/func_info/enuri/"+ImgFolder(gModelData.gModelno)+"/"+gModelData.gModelno+"_1.png";
						var scrapImageUrl = "<img src='";
						scrapImageUrl += varImgUrl;
						scrapImageUrl += "' border='0'/>";

						callCDNImg(varImgUrl);

						try {
							if(window.clipboardData) {
								window.clipboardData.setData("Text", scrapImageUrl);

								if(catal_result.indexOf("error")<0 && catal_result.indexOf("ok")>0){
									alert("카탈로그가 복사되었습니다.\n쇼핑몰 상품 등록창에 CTRL+V 를 해주세요");
								}else{
									alert("카탈로그가 복사되었습니다.\n쇼핑몰 상품 등록창에 CTRL+V 를 해주세요\n카탈로그 정보가 업데이트되지 않은 경우 퍼가기를 재실행 해주세요");
								}

							}else{
								// IE 체크 후 아래 로직으로 변경 작업을 하게 되면 크롬에서 복사하는 팝업 뜸
								//prompt("Ctrl+C를 눌러 카탈로그를 클립보드로 복사하세요.", scrapImageUrl);
								alert("해당 브라우저에서 지원하지않습니다.");
							}
						} catch(e) {
							alert("해당 브라우저에서 지원하지않습니다. " + e);
						}

						$('#enuri_func_ScrapLayer').hide();
					},
					error: function (xhr, ajaxOptions, thrownError) {
						$('#enuri_func_ScrapLayer').hide();
						//alert(xhr.status);
						//alert(thrownError);
					}
				});
			}
			return false; 
		});*/
	}

	let enuri_factory_tel = json["enuri_factory_tel"];
	let enuri_factory_telnm = json["enuri_factory_telnm"];
	let enuri_factory_url1 = json["enuri_factory_url1"];
	let enuri_factory_url1nm = json["enuri_factory_url1nm"];
	let enuri_factory_url2 = json["enuri_factory_url2"];
	let enuri_factory_url2nm = json["enuri_factory_url2nm"];

	let factoryhtml = ``;

	if(typeof enuri_factory_tel != "undefined" && enuri_factory_tel.length>0 && typeof enuri_factory_telnm != "undefined" && enuri_factory_telnm.length>0){
		factoryhtml += `<div class="partbox" id="desc_factory">
							<div class="partbox__inner">
								<p class="tx_tit">${enuri_factory_telnm} <em>TEL. ${enuri_factory_tel}</em></p>`;
		if(typeof enuri_factory_url1 != "undefined" && enuri_factory_url1.length>0 && typeof enuri_factory_url1nm != "undefined" && enuri_factory_url1nm.length>0){
			factoryhtml += `<a href="${enuri_factory_url1}" target="_blank" title="새 창에서 열립니다." class="tx_link">${enuri_factory_url1nm}</a>`;
		}
		if(typeof enuri_factory_url2 != "undefined" && enuri_factory_url2.length>0 && typeof enuri_factory_url2nm != "undefined" && enuri_factory_url2nm.length>0){
			factoryhtml += `<a href="${enuri_factory_url2}" target="_blank" title="새 창에서 열립니다." class="tx_link">${enuri_factory_url2nm}</a>`;
		}
		factoryhtml+=`</div></div>`;
	}
	html += factoryhtml;

	//설명서 안내
	 let enuri_manual_viewernm = json["enuri_manual_viewernm"];
	let enuri_manual_viewerlink = json["enuri_manual_viewerlink"];
	let enuri_manual = json["enuri_manual"];
	let enuri_manual_factory = json["enuri_manual_factory"];
	let enuri_manual_html = "";
	if((enuri_manual && enuri_manual.length>0) || (enuri_manual_factory && enuri_manual_factory.length>0)){
		enuri_manual_html += `<div class="partbox" id="desc_factory">
								<div class="partbox__inner">
									<p class="tx_tit">설명서</p>`;
		if(enuri_manual && enuri_manual.length>0){
			enuri_manual_html += `<a href="${enuri_manual}" targer="_blank" class="btn btn__link">설명서보기</a>`;
		}
		if(enuri_manual_factory && enuri_manual_factory.length>0){
			enuri_manual_html += `<a href="${enuri_manual_factory}" targer="_blank" class="btn btn__link">제조사 설명서 목록</a>`;
			
		}
		if(enuri_manual_viewernm && enuri_manual_viewernm.length>0 && enuri_manual_viewerlink && enuri_manual_viewerlink.length>0){
			enuri_manual_html += `	<span class="tx_alert">설명서가 안 보이시면 <a href="${enuri_manual_viewerlink}" targer="_blank" title="새 창에서 열립니다." class="btn btn__acrobat">${enuri_manual_viewernm}</a>를 설치해주세요</span>`;
		}
	}
	html += enuri_manual_html;

	html += `</div>`;
	$("#prodDetail").find(".specdetail .sd__container .sd__cont").html(html);
	
}
const prodExplainKnowcomGuideView = (json) => {
	let enuri_knowcom_guide = json.enuri_knowcom_guide;

	let html =``;
	let swiper_html = ``;
	let enuri_knowcom_guide_kbno = 0;
	if(enuri_knowcom_guide.length > 0){
		html += `<div class="inner">
					<div class="tx_wrap">
					<p class="tx_noti">
						본 제작 자료의 저작권은 에누리[㈜써머스플랫폼]에 있습니다. 무단 복제 및 가공, 사용시 법에 의한 처벌을 받을 수 있습니다.<br>
						Copyright ⓒ SummercePlatform Inc. All rights reserved.
					</p>`;
		html +=`	<div class="thum_wrap">`;
		html += enuri_knowcom_guide[0].kb_content;
		enuri_knowcom_guide_kbno = enuri_knowcom_guide[0].kb_no;
		html +=`	</div>`;
		html +=`</div>`;	

		$.each(enuri_knowcom_guide, (i,v) => {
			if(enuri_knowcom_guide_kbno==v.kb_no) return true;
			swiper_html  += `<div class="swiper-slide">
								<a href="/knowcom/detail.jsp?kbno=${v.kb_no}" target="_blank">
									<div class="buy_info_thumbsnail_img">`
			if(v.rp_thumbnail_img_url && i > 0){
				swiper_html += `<img src="${v.rp_thumbnail_img_url}" />`;
			}else if(v.mo_img){
				swiper_html += `<img src="${v.mo_img}" />`;
			}else if(v.rss_thumbnail){
				swiper_html += `<img src="${v.rss_thumbnail}" />`;
			}else if(v.kb_thumbnail_img){
				swiper_html += `<img src="${v.kb_thumbnail_img}" />`;
			}else if(v.mo_img2){
				swiper_html += `<img src="${v.mo_img2}" />`;
			}else if(v.kb_thumbnail){
				swiper_html += `<img src="${v.kb_thumbnail}" />`;
			}
			swiper_html  += 		`</div>
									<div class="buy_info_tit">${v.kb_title}</div>
								</a>
							</div>`;
		}); 
		if(swiper_html.length >0 ){
			if(enuri_knowcom_guide.length < 3){
				swiper_html += `<div class="swiper-slide">
									<div class="nolist">
										<img src="//img.enuri.info/images/sample/sample_nothing@s104x30.png">
										<span class="nolist_txt">준비중입니다.</span>
									</div>
								</div>`;
			}
			swiper_html = `<div class="swiper-wrapper">` + swiper_html + `</div>`;
			if(enuri_knowcom_guide.length > 2){
				swiper_html += `<button type="button" class="btn-swiper btn-swiper-prev">이전</button>
								<button type="button" class="btn-swiper btn-swiper-next">다음</button>`
			}
			$("#opt_knowcom_guide_swiper").find(".buy_info_swiper").html(swiper_html);
			$("#opt_knowcom_guide_swiper").show();
			$("#opt_knowcom_guide_swiper").find(".buy_info_swiper .swiper-slide").on("click",function(){
				ga('send','event','vip','Product_tab','Guide_list');
				insertLogCate(26228);
			});

		}
		$("#prodDetail").find(".specdetail .sd__container .sd__cont").html(html);
		var a = new Swiper('#opt_knowcom_guide_swiper .buy_info_swiper',{
			loop : false,
			slidesPerView : 2,
			initialSlide: 0,
			loopAdditionalSlides : 1,
			spaceBetween : 0,
			prevButton : '.buy_info_swiper .btn-swiper-prev',
			nextButton : '.buy_info_swiper .btn-swiper-next',
			paginationClickable : false,
			slideToClickedSlide:true
		});
	}else{
		$("#prodDetail").find(".specdetail .sd__container .sd__cont").empty();
	}
}
	