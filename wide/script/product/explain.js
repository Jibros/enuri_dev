var load_ecatal_out = false;	//외부 카탈로그
var load_mall_desc = false;		//쇼핑몰 크롤링 정보
var load_enuri_desc = false;	//에누리 상세정보
/* 2019-03-21
(#32642) VIP > 상품설명 탭 개선으로 getGoods_explain1() 변경
최서진 선임
*/

$(window).load(function(){
	var $listShowImg = $('#area_ecatal_out .listShowImg');

	$listShowImg.attr('src',$listShowImg.attr('data-original'));
	$listShowImg.load(function(){
		setTimeout('fn_moreBtn()',1000);
	});
});

function getGoods_explain(proctype){
	$('#opt_ecatal_out span').get(0).className = 'unchk';
	$('#opt_mall_desc span').get(0).className = 'unchk';
	$('#opt_enuri_desc span').get(0).className = 'unchk';
	if(proctype==1){
		$('#opt_ecatal_out > span').get(0).className = 'chk';
	}else if(proctype==2){
		$('#opt_mall_desc > span').get(0).className = 'chk';
	}else if(proctype==3){
		$('#opt_enuri_desc > span').get(0).className = 'chk';
	}
	$('#area_ecatal_out').hide();
	$('#area_mall_desc').hide();
	$('#area_enuri_desc').hide();

	if((proctype==1 && !load_ecatal_out) || (proctype==2 && !load_mall_desc) || (proctype==3 && !load_enuri_desc)){
		var param = {
			"modelno" : gModelno,
			"procType" : proctype
		}
		$.ajax({
			type : "get",
			url : "/lsv2016/ajax/detail/getGoodsDesc_ajax.jsp",
			async: true,
			data : param,
			dataType : "json",
			success: function(json) {
				var ecatal_out_yn = json["ecatal_out_yn"];
				var mall_desc_yn = json["mall_desc_yn"];
				var enuri_desc_yn = json["enuri_desc_yn"];
				//console.log(ecatal_out_yn+","+mall_desc_yn+","+enuri_desc_yn);
				//라디오 선택 항목
				if(ecatal_out_yn=="Y"){
					$('#explain').show();
					//if(mall_desc_yn=="Y" || enuri_desc_yn=="Y"){
						$('#opt_ecatal_out').show();
					//}
				}else{
					$('#opt_ecatal_out').hide();
				}
				if(mall_desc_yn=="Y"){
					$('#explain').show();
					//if(ecatal_out_yn=="Y" || enuri_desc_yn=="Y"){
						$('#opt_mall_desc').show();
					//}
				}else{
					$('#opt_mall_desc').hide();
				}
				if(enuri_desc_yn=="Y"){
					$('#explain').show();
					//if(ecatal_out_yn=="Y" || mall_desc_yn=="Y"){
						$('#opt_enuri_desc').show();
					//}
				}else{
					$('#opt_enuri_desc').hide();
				}
				if(ecatal_out_yn=="N" && mall_desc_yn=="N" && enuri_desc_yn=="N"){ //상세설명이 아무것도 없음
					$('#explain').hide();
					return;
				}
				if(proctype==1){ //외부 카탈로그 호출
					if(ecatal_out_yn=="N"){
						if(mall_desc_yn=="Y"){
							getGoods_explain(2);
							return;
						}else if(enuri_desc_yn=="Y"){
							getGoods_explain(3);
							return;
						}
					}else if(ecatal_out_yn=="Y"){
						var ecatal_out_src = json["ecatal_out_src"]; //이미지url
						var ecatal_out_from = json["ecatal_out_from"]; //제공 업체명
						var ecatal_html = "";
						if(ecatal_out_src!=""){
							$('#opt_ecatal_out span em').html(ecatal_out_from);//.removeTag()
							$('#opt_ecatal_out span em a').click(function(event) {
							    event.preventDefault();
							 })

							$('#area_ecatal_out div.message span.txt em').html(ecatal_out_from);
							ecatal_html = "<img class=\"listShowImg lazy\" data-original=\""+ecatal_out_src+"\" src=\""+noImageStr+"\" />";
							$('#area_ecatal_out div.pro_intro div.pro_image').html(ecatal_html);
							$('#area_ecatal_out').show();
							$("img.lazy").lazyload({
								load  : function(){
									setTimeout('fn_moreBtn()',1000);
								}
							});

						}
					}
					load_ecatal_out = true;
				}else if(proctype==2){ //쇼핑몰 크롤링 정보 호출
					var mall_desc_plno = json["mall_desc_plno"];
					var mall_desc_shopnm = json["mall_desc_shopnm"];
					var mall_desc_contents = json["mall_desc_contents"].replace("<style","<!-- style").replace("/style>","/style -->");

					if(mall_desc_shopnm && mall_desc_shopnm.length>0 && mall_desc_contents && mall_desc_contents.length>0){
						$('#opt_mall_desc span em').html(mall_desc_shopnm);
						$('#area_mall_desc div.message span.txt em').html(mall_desc_shopnm);
						if(mall_desc_plno && parseInt(mall_desc_plno)>0){
							$('#area_mall_desc div.message a.btn_mallmove').click(function() {
								//해당 쇼핑몰 링크
								CmdGotoURL2(0,'move_link','','',gModelno,'','','','',mall_desc_plno);
								return false;
							});
						}
						$('#area_mall_desc div.pro_intro div.pro_image').html(mall_desc_contents);
						$('#area_mall_desc').show();
					}
					load_mall_desc = true;
				}else if(proctype==3){ //에누리 상세정보 호출
					$('#area_enuri_desc').show();
					load_enuri_desc = true;

					var enuri_under19_yn = json["enuri_under19_yn"]; //성인용품 19금 처리여부
					if(enuri_under19_yn=="Y") { //19금처리
						$('#adult_warnning').show();
						$('#adult_warnning').find('> div > p > a').click(function() {
							goAdultCheck('location.reload','');
							return false;
						});
					}else{
						//주의사항
						getGoods_caution();
						//요약설명 table형태
						var enuri_spec_table = json["enuri_spec_table"];
						var enuri_spec_text = json["enuri_spec_text"];
						enuri_spec_text = enuri_spec_text.replace("&nbsp;&nbsp;/&nbsp;&nbsp;","/");
						draw_enuri_spec_table(enuri_spec_table, enuri_spec_text);

						//사이즈 정보
						var enuri_size = json["enuri_size"];
						if(enuri_size) {
							var g_sizeStrAry = enuri_size.split("^");
							if(g_sizeStrAry.length>0) {
								for(var i=0; i<g_sizeStrAry.length; i++) {
									var g_sizeItem = g_sizeStrAry[i];

									if(g_sizeItem.length>0) {
										var g_sizeItemStr = "<li>"+g_sizeItem+"</li>";
										$('#detailProdSizesDiv').append(g_sizeItemStr);
									}
								}
							}
							$('#detailProdSizesDiv').show();
							$('#detailProdSpecDiv').show();
						}

						//크기정보 아이콘
						var enuri_cateicon = json["enuri_cateicon"];
						if(enuri_cateicon) {
							if(enuri_cateicon.length>0) {
								var html = "<img id=\"img_category_icon\" src=\""+enuri_cateicon+"\" border=\"0\" align=\"absmiddle\">";
								$('#detailProdSizesDiv').append(html);
							}
							$('#detailProdCateIconDiv').show();
							$('#detailProdSpecDiv').show();
						}

						//인증정보
						var goods_attribute_certi = json["goods_attribute_certi"];
						var goods_attribute_certi_cnt = 0;
						if(goods_attribute_certi){
							$.each(goods_attribute_certi, function(Index, listData) {
								var certi_attribute_id = listData["attribute_id"];
								var certi_attribute_element_id = listData["attribute_element_id"];
								var certi_iconno = listData["iconno"];
								var certi_attribute_element = listData["attribute_element"];
								var certi_ref_kb_no = listData["ref_kb_no"];
								if(certi_iconno) {
									var goods_attribute_certiStr = "<li>";if(certi_ref_kb_no>0){goods_attribute_certiStr +="<a href=\"javascript:///\" onclick=\"showTermDic("+certi_attribute_id+", "+certi_attribute_element_id+", this);\"><span class=\"brup\"></span>";}goods_attribute_certiStr +="<img src=\"http://img.enuri.info/images/f_icon/"+certi_iconno+"_b.gif\" alt=\""+certi_attribute_element+"\">";if(certi_ref_kb_no>0){goods_attribute_certiStr +="</a>";}goods_attribute_certiStr +="</li>";

									$('#mark_box_cermark').find(".marklist").append(goods_attribute_certiStr);

									goods_attribute_certi_cnt++;
								}
							});
						}
						if(goods_attribute_certi_cnt>0){
							$('#detailProdSpecDiv').show();
							$('#mark_box_cermark').show();
						}

						//알레르기성분
						var goods_attribute_allergy = json["goods_attribute_allergy"];
						var goods_attribute_allergy_cnt = 0;
						if(goods_attribute_allergy){
							$.each(goods_attribute_allergy, function(Index, listData) {
								var allergy_attribute_id = listData["attribute_id"];
								var allergy_attribute_element_id = listData["attribute_element_id"];
								var allergy_iconno = listData["iconno"];
								var allergy_attribute_element = listData["attribute_element"];
								var allergy_ref_kb_no = listData["ref_kb_no"];
								if(allergy_iconno) {
									var goods_attribute_allergyStr = "<li>";if(allergy_ref_kb_no>0){goods_attribute_allergyStr +="<a href=\"javascript:///\" onclick=\"showTermDic("+allergy_attribute_id+", "+allergy_attribute_element_id+", this);\"><span class=\"brup\"></span>";}goods_attribute_allergyStr +="<img src=\"http://img.enuri.info/images/f_icon/"+allergy_iconno+"_b.gif\" alt=\""+allergy_attribute_element+"\">";if(allergy_ref_kb_no>0){goods_attribute_allergyStr +="</a>";}goods_attribute_allergyStr +="</li>";

									$('#mark_box_algrmark').find(".marklist").append(goods_attribute_allergyStr);

									goods_attribute_allergy_cnt++;
								}
							});
						}
						if(goods_attribute_allergy_cnt>0){
							if(goods_attribute_certi_cnt<=0) $('#mark_box_algrmark').css("margin-left","0px");
							$('#detailProdSpecDiv').show();
							$('#mark_box_algrmark').show();
						}


						//스펙 아이콘
						var func_iconsStr = json["enuri_func_icon"];
						var func_iconsCnt = 0;
						if(func_iconsStr){
							$.each(func_iconsStr, function(Index, listData) {
								var func_iconsItem = listData["src"];

								if(func_iconsItem) {
									var func_iconsItemStr = "<li><img src=\""+func_iconsItem+"\" alt=\"\" /></li>";

									$('#detailProdIconsDiv').find("ul").append(func_iconsItemStr);

									func_iconsCnt++;
								}
							});
						}
						if(func_iconsCnt>0){
							$('#detailProdIconsDiv').show();
							$('#detailProdSpecDiv').show();
						}
						//큰이미지
						var bigImageUrlStr = json["bigimage"];
						var fImgChk = json["fImgChk"];

						var bigimage_webshopnm = json["bigimage_webshopnm"];
						var bigimage_webplno = json["bigimage_webplno"];

						var enuriPcViewYn = json["enuripc_view_yn"];
						var enuripcImgUrl = json["enuripc_img_url"];

						//PC견적 이미지 사용 시 이미지 경로 변경 함.
						if (enuriPcViewYn && enuriPcViewYn == "Y" && enuripcImgUrl && enuripcImgUrl.length > 0) {
							bigImageUrlStr = enuripcImgUrl;
						}

						if(bigImageUrlStr && bigImageUrlStr.length>0) {
							$('#detailProdBigImageDiv').show();
							$('#detailProdBigImageDiv')
								.find("img").attr("src", bigImageUrlStr)
								.error(function(){ //오류시 준비중 이미지 안내
									$('#detailProdBigImageDiv').hide();
									$('#detailProdBigImageReadyDiv').show();
								});
							//스폰서 처리
							if(isSponsor){
								$('#detailProdBigImageDiv div.sponserpd').show();
							}
							if(bigimage_webshopnm && bigimage_webshopnm.length>0){
								$('#detailProdBigImageDiv div.no_attbu p em').html(bigimage_webshopnm);
								$('#detailProdBigImageDiv div.no_attbu').show();
								$('#detailProdBigImageDiv div.pro_image').removeClass("pro_image");
								if(parseInt(bigimage_webplno)>0){
									$('#detailProdBigImageDiv').find("img").attr("style","cursor:pointer");
									$('#detailProdBigImageDiv').find("img").click(function(){
										CmdGotoURL2(0,'move_link','','',gModelno,'','','','',bigimage_webplno);
									});
								}
							}

						}else{ //준비중 이미지 안내
							$('#detailProdBigImageReadyDiv').show();
							if((parseInt(nMallCnt) <= 0 && parseInt(nMallCnt3) <=0) || fImgChk==5){
								$('#detailProdBigImageReadyDiv').hide();
							}
						}
					}
					//상세설명
					var enuri_func_title = json["enuri_func_title"];
					if(enuri_func_title && enuri_func_title.length>0){
						$('#spec_explain').show();
						$('#cm_news').html(enuri_func_title);
					}
					var enuri_func_1 = json["enuri_func_1"];
					var enuri_func_2 = json["enuri_func_2"];
					var enuri_func_3 = json["enuri_func_3"];

					if(enuri_func_1 || enuri_func_2 || enuri_func_3){
						$('#spec_explain').show();
					}

					if(enuri_func_1 && enuri_func_1.length>0){
						$('#spec_explain_col1').html("<pre>"+enuri_func_1+"</pre>");
					}else{
						$('#spec_explain_col1').html('');
					}
					if(enuri_func_2 && enuri_func_2.length>0){
						$('#spec_explain_col2').html("<pre>"+enuri_func_2+"</pre>");
					}else{
						$('#spec_explain_col2').html('');
					}
					if(enuri_func_3 && enuri_func_3.length>0){
						$('#spec_explain_col3').html("<pre>"+enuri_func_3+"</pre>");
					}else{
						$('#spec_explain_col3').html('');
					}

					var enuri_func_scrap = json["enuri_func_scrap"];
					if(enuri_func_scrap && enuri_func_scrap=="Y"){
						$('#enuri_func_scrap').show();
						$('#enuri_func_scrap').click(function() {
							insertLogCate(14524);
							$('#enuri_func_scrap_clause').get(0).className="unchkb";
							$('#enuri_func_ScrapLayer').toggle();
							return false;
						});
						$('#enuri_func_scrap_go').click(function() {
							if($('#enuri_func_scrap_clause').get(0).className=="unchkb"){
								alert("카탈로그 퍼가기 이용 약관에 동의하셔야 퍼가기가 가능합니다.");
							}else if($('#enuri_func_scrap_clause').get(0).className=="chkb"){
								var s_param = {
									"modelno" : gModelno,
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
										var varImgUrl = "http://storage.enuri.info/func_info/enuri/"+ImgFolder(gModelno)+"/"+gModelno+"_1.png";
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
						});
					}
					//용어사전
					var enuri_termdic1 = json["enuri_termdic1"];
					var enuri_termdic2 = json["enuri_termdic2"];
					var enuri_termdic3 = json["enuri_termdic3"];
					if(enuri_termdic1 || enuri_termdic2 || enuri_termdic3){
						$('#spec_termdic').show();
					}
					for(i=0; i<3; i++){
						var term_obj;
						var termdic_col;
						if(i==0){
							term_obj = enuri_termdic1;
							termdic_col = $('#spec_termdic_col1');
						}else if(i==1){
							term_obj = enuri_termdic2;
							termdic_col = $('#spec_termdic_col2');
						}else if(i==2){
							term_obj = enuri_termdic3;
							termdic_col = $('#spec_termdic_col3');
						}
						if(term_obj && term_obj.length>0){
							$.each(term_obj, function(Index, listData) {
								var term_html = "";
								var kbno = listData["kbno"];
								var title = listData["title"];
								var titmeimg = listData["titmeimg"];
								var img_width = listData["img_width"];
								var img_height = listData["img_height"];
								var func_content = listData["func_content"];
								var func_option = listData["func_option"];
								if(Index>0) term_html +="<br>";
								term_html += "<table width=264 cellspacing=0 cellpadding=0 border=0><tbody><tr><td style='padding-bottom:2px;padding-top:2px;'>";
								term_html += "<span style='ont-size:12px;background-color:#e6e6e6;color:#2f2f2f;padding:0px 2px 1px 2px;font-weight:bold;'>&nbsp;" + title + "&nbsp;</span>";
								if(func_option=="1"){
									//용어사전 레이어(자세히)
									term_html += "&nbsp;<img align='absmiddle' src='http://img.enuri.info/images/view/blue/btn_picture_0813.gif' onclick='showTermDicKb("+kbno+", this);' style='cursor:pointer;'>";
								}else if(func_option=="2"){
									//지식통 링크(더보기)
									//term_html += "&nbsp;<img align='right' src='http://img.enuri.info/images/detail/more_btn.gif' onclick='CmdGotoBeginnerDic("+kbno+");' style='cursor:pointer;'>";
								}
								term_html += "</td></tr></tbody></table>";
								term_html += "<pre style='margin:0 0 0 0;padding:0 0 0 0;font-size:8pt;color:#000000;line-height:16px;word-break:break-all;' width=268 align=left>";
								var kttFuncContent = func_content.split("<break>");
								if(kttFuncContent.length>1) {
									if(kttFuncContent[0].length>2 && kttFuncContent[0].substring(kttFuncContent[0].length-2)=="\r\n") {
										kttFuncContent[0] = kttFuncContent[0].substring(0, kttFuncContent[0].length-2) + "<br>";
									}
									term_html += kttFuncContent[0];
								}
								if(titmeimg.length>0) {
									// 플래쉬 일 경우
									if(titmeimg.length>4 && titmeimg.substring(titmeimg.length-4)==".swf") {
										term_html += "<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" codebase=\"http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0\" width=\""+img_width+"\" height=\""+img_height+"\" id=\"titleimg_"+kbno+"\" align=\"left\" style=\"margin-bottom:2;border:1 solid gray;\">";
										term_html += "<param name=\"allowScriptAccess\" value=\"always\" /><param name=\"allowFullScreen\" value=\"false\" /><param name=\"quality\" value=\"high\" /><param name=\"wmode\" value=\"transparent\" />";
										term_html += "<param name=\"bgcolor\" value=\"#ffffff\" /><param name=\"movie\" value=\"http://storage.enuri.info/pic_upload/termdictitle/"+titmeimg+"\" />";
										term_html += "<param name=\"FlashVars\" value=\"\" /><embed src=\"http://storage.enuri.info/pic_upload/termdictitle/"+titmeimg+"\" quality=\"high\" wmode=\"transparent\" bgcolor=\"#ffffff\" width=\""+img_width+"\" height=\""+img_height+"\" id=\"titleimg_"+kbno+"\" name=\"titleimg_"+kbno+"\" align=\"left\" swLiveConnect=true allowScriptAccess=\"always\" type=\"application/x-shockwave-flash\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\" /></embed>";
										term_html += "</object>";
									} else { // 일반 이미지 일 경우
										term_html += "<img align='left' src='http://storage.enuri.info/pic_upload/termdictitle/"+titmeimg+"' onload=\"resizeGuideHeaderImage(this)\" style=\"border:1px solid gray;margin:0 4px 2px 0;padding:0 0 0 0;\">";
									}
								}
								if(kttFuncContent.length>1) {
									term_html += kttFuncContent[1];
								} else {
									term_html += kttFuncContent[0].replace("<P ", "<span ").replace("</P>", "</span>");
								}
								term_html += "</pre>";
								termdic_col.append(term_html);
							});
						}else{
							termdic_col.html('');
						}
					}
					//제조사 안내
					var enuri_factory_tel = json["enuri_factory_tel"];
					var enuri_factory_telnm = json["enuri_factory_telnm"];
					var enuri_factory_url1 = json["enuri_factory_url1"];
					var enuri_factory_url1nm = json["enuri_factory_url1nm"];
					var enuri_factory_url2 = json["enuri_factory_url2"];
					var enuri_factory_url2nm = json["enuri_factory_url2nm"];
					var enuri_factory_html = "";
					if(enuri_factory_tel && enuri_factory_tel.length>0 && enuri_factory_telnm && enuri_factory_telnm.length>0){
						enuri_factory_html += "<em>" + enuri_factory_telnm + "</em><em>TEL. " + enuri_factory_tel + "</em>";
					}
					if(enuri_factory_url1 && enuri_factory_url1.length>0 && enuri_factory_url1nm && enuri_factory_url1nm.length>0){
						if(enuri_factory_url1.length>=7) {
							if(enuri_factory_url1.substring(0,7)!="http://") {
								enuri_factory_url1 = "http://" + enuri_factory_url1;
							}
						}
						enuri_factory_html += "<a class='homepg' href='" + enuri_factory_url1 + "' title='' target='_new'>" + enuri_factory_url1nm + "</a>";
					}
					if(enuri_factory_url2 && enuri_factory_url2.length>0 && enuri_factory_url2nm && enuri_factory_url2nm.length>0){
						if(enuri_factory_url2.length>=7) {
							if(enuri_factory_url2.substring(0,7)!="http://") {
								enuri_factory_url2 = "http://" + enuri_factory_url2;
							}
						}
						enuri_factory_html += "<a class='homepg' href='" + enuri_factory_url2 + "' title='' target='_new'>" + enuri_factory_url2nm + "</a>";
					}
					if(enuri_factory_html.length>0){
						if($('#spec_explain').css("display")=="none" && $('#spec_termdic').css("display")=="none"){
							$('#factory_tel').removeClass("maker");
							$('#factory_tel').addClass("makerb");
						}
						$('#factory_tel').show();
						$('#factory_tel > p').append(enuri_factory_html);
					}
					//설명서 안내
					var enuri_manual_viewernm = json["enuri_manual_viewernm"];
					var enuri_manual_viewerlink = json["enuri_manual_viewerlink"];
					var enuri_manual = json["enuri_manual"];
					var enuri_manual_factory = json["enuri_manual_factory"];
					var enuri_manual_html = "";
					if((enuri_manual && enuri_manual.length>0) || (enuri_manual_factory && enuri_manual_factory.length>0)){
						enuri_manual_html += "<em>설명서</em>";
						if(enuri_manual && enuri_manual.length>0){
							enuri_manual_html += "<a class='btn_sq4' href='" + enuri_manual + "' title='' target='_new'>설명서보기</a>";
						}
						if(enuri_manual_factory && enuri_manual_factory.length>0){
							enuri_manual_html += "<a class='btn_sq4' href='" + enuri_manual_factory + "' title='' target='_new'>제조사 설명서 목록</a>";
						}
						if(enuri_manual_viewernm && enuri_manual_viewernm.length>0 && enuri_manual_viewerlink && enuri_manual_viewerlink.length>0){
							enuri_manual_html += "<span class='txt'>설명서가 안 보이시면<a class='acrobat' href='" + enuri_manual_viewerlink + "' title='새 페이지 이동' target='_new'>" + enuri_manual_viewernm + "</a>를 설치해주세요</span>";
						}
					}
					if(enuri_manual_html.length>0){
						if($('#spec_explain').css("display")=="none" && $('#spec_termdic').css("display")=="none" && $('#factory_tel').css("display")=="none"){
							$('#factory_manual').removeClass("manual");
							$('#factory_manual').addClass("manualb");
						}
						$('#factory_manual').show();
						$('#factory_manual > p').append(enuri_manual_html);
					}
				}
			},
			error: function (xhr, ajaxOptions, thrownError) {
				//alert(xhr.status);
				//alert(thrownError);
			}
		});
	}else{
		if(proctype==1){ //외부 카탈로그 호출
			$('#area_ecatal_out').show();
		}else if(proctype==2){ //쇼핑몰 크롤링 정보 호출
			$('#area_mall_desc').show();
		}else if(proctype==3){ //에누리 상세정보 호출
			$('#area_enuri_desc').show();
		}
	}
}
function getGoods_caution(){ //주의사항
	var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi;
	var param = {
		"view_type" : 4,
		"ca_code" : szCategory,
		"modelnos" : gModelno,
		"modelnm" : szModelNm.replace(regExp, ''),
		"factory" : szFactory,
		"brand" : szBrand,
		"spec" : strCautionSpec
		//"spec" : spec
	}
	$.ajax({
		type : "get",
		url : "/lsv2016/ajax/detail/getCautionInfo_ajax.jsp",
		async: true,
		data : param,
		dataType : "json",
		success: function(json) {
			var title_type = json["title_type"];
			var title = json["title"];
			var content_list = json["content_list"];
			var content_type = json["content_type"];
			var img = json["img"];
			var imgmap_list = json["imgmap_list"];
			var caution_html = "";
			if(content_list && content_list.length>0) {
				if(content_type==1){
					if(title_type < 2){
						if(title_type==1){
							caution_html += "<dt class=\"txt\"><strong>"+title+"</strong></dt>";
						}else{
							caution_html += "<dt class=\"txt\"><strong>주의사항</strong></dt>";
						}
					}

					$.each(content_list, function(Index, listData) {
						var o_content = listData["content"];
						caution_html += "<dd>" + o_content + "</dd>";
					});

				}else if(content_type==2){
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
				}
				$('#enuri_caution > dl').append(caution_html);
				$('#enuri_caution').show();

			}
			load_explain_caution = true;
		},
		error: function (xhr, ajaxOptions, thrownError) {
			//alert(xhr.status);
			//alert(thrownError);
		}
	});
}


function draw_enuri_spec_table(enuri_spec_table, enuri_spec_text){

	if(enuri_spec_table) {
		var len_enuri_spec_table = enuri_spec_table.length;
		var spec_html = "";
		var itemCnt = 0;
		var cellCnt = 0; // 같은 타이틀의 셀내용이 두개 이상일 수 있음

		spec_html += " <div id=\"enuri_spec_table\">	";

		$.each(enuri_spec_table, function(indexI, listObj) {
			var specTitle = listObj["specTitle"];
			var specContent = listObj["specContent"];
			var specCellcnt = listObj["specCellcnt"];
			var specGroupnameStr = listObj["specGroupname"];
			var att_id = listObj["att_id"];
			var att_el_id = listObj["att_el_id"];
			var att_kbno = listObj["att_kbno"];
			var att_el_kbno = listObj["att_el_kbno"];
			var specCellcntInt = 0;
		/*
			console.log(" specGroupnameStr : " + specGroupnameStr + " specTitle : " + specTitle + " specContent : " + specContent + " specCellcnt : " + specCellcnt +  " att_id : " + att_id + " att_el_id : " + att_el_id
					 + " att_kbno : " + att_kbno + " att_el_kbno : " + att_el_kbno );
		*/
			if(specTitle != ""){

				try {
					specCellcntInt = parseInt(specCellcnt);
				} catch(e) {}

				if(specGroupnameStr && specGroupnameStr.length>0 || indexI == 0) {
					if(itemCnt%3==1) {
						itemCnt = itemCnt + 2;
						spec_html += "			<th scope=\"row\">&nbsp;</th>";
						spec_html += "			<td>&nbsp;</td>";
						spec_html += "			<th scope=\"row\">&nbsp;</th>";
						spec_html += "			<td>&nbsp;</td>";
					} else if (itemCnt%3==2) {
						itemCnt++;
						spec_html += "			<th scope=\"row\">&nbsp;</th>";
						spec_html += "			<td>&nbsp;</td>";
					}

					spec_html += "<table class=\"offerer__table\">";
					spec_html += "	<caption class=\"title\">"+specGroupnameStr+"</caption>";
					spec_html += "	<colgroup>";
					spec_html += "		<col class=\"col1\" />";
					spec_html += "		<col class=\"col2\" />";
					spec_html += "		<col class=\"col3\" />";
					spec_html += "		<col class=\"col2\" />";
					spec_html += "		<col class=\"col3\" />";
					spec_html += "		<col class=\"col2\" />";
					spec_html += "	</colgroup>";
					spec_html += "	<tbody>";
				}

				if(itemCnt%3==0) {
					spec_html += "		<tr>";
				}

				spec_html += "				<th scope=\"row\">";

				if(att_kbno>0){
					spec_html += "				<a class='attr' href='javascript:///' onclick='insertLogCate(14523);showTermDic("+att_kbno+", 0, this);return false;'>" + specTitle + "</a>";
				}else{
					spec_html += specTitle;
				}
				spec_html += "				</th>";
				spec_html += "				<td>";
				if(att_el_kbno>0){
					spec_html += "				<a class='attr' href='javascript:///' onclick='insertLogCate(14523);showTermDic("+att_id+", "+att_el_id+", this);return false;'>" + specContent + "</a>";
				}else{
					spec_html += specContent;
				}
				if(specCellcntInt>=2){
					for(j=1; j<specCellcntInt; j++){
						if(enuri_spec_table[indexI+j]){
							spec_html += ", ";
							if(enuri_spec_table[indexI+j]["att_el_kbno"]>0){
								spec_html += "	<a class='attr' href='javascript:///' onclick='insertLogCate(14523);showTermDic("+enuri_spec_table[indexI+j]["att_id"]+", "+enuri_spec_table[indexI+j]["att_el_id"]+", this);return false;'>" + enuri_spec_table[indexI+j]["specContent"] + "</a>";
							}else{
								spec_html += enuri_spec_table[indexI+j]["specContent"];
							}
						}else{
							break;
						}
					}
				}
				spec_html += "				</td>";

				if(itemCnt%3==2) {
					spec_html += "		</tr>";
				}

				if((specGroupnameStr && specGroupnameStr.length>0 && itemCnt%3==2) || indexI == len_enuri_spec_table) {
					spec_html += "	</tbody>";
					spec_html += "</table>";
				}

				itemCnt++;
			}
		});

		spec_html += " </div>	";

		$('#enuri_caution').after(spec_html);
		//$('#enuri_spec_table').show();

		// 상세 정보의 마지막 빈칸을 채워주기 위해 dom 검사 후 append 함.

		var emptyCnt = 3 - ($("#enuri_spec_table .offerer__table:last").find("tr:last th").length);
		var empSpecHtml = "";
		if (emptyCnt > 0) {
			for (var i=0; i<emptyCnt; i++) {
				empSpecHtml += "			<th scope=\"row\">&nbsp;</th>";
				empSpecHtml += "			<td>&nbsp;</td>";
			}

			$("#enuri_spec_table .offerer__table:last").find("tr:last").append(empSpecHtml);
		}

		//kc 인증마크 관련 함수 호출
		getVipKcMark();
	}else if(enuri_spec_text){
		if(enuri_spec_text.length>0) {
			$('#enuri_spec_text').show();
			$('#enuri_spec_text').find("span").html(enuri_spec_text);
		}
	}

	/**
	 * VIP VIDEO 노출
	 */
	var param = {
			"modelno" : gModelno
		}

	$.ajax({
		type : "get",
		url : "/lsv2016/ajax/detail/getVideoData_ajax.jsp",
		async: true,
		data : param,
		dataType : "json",
		success: function(json) {

			if(json.videoCnt != 0){

				if(json.videoList.length > 0){
					var video_html = "<div class=\"pro_movie\">";
					for(var i = 0 ; i < json.videoList.length; i++){

						video_html += "		<div class=\"div_addVideo\">";
						video_html += "			<div class=\"addVideo_title\">";
						video_html += "				<strong>&lt;"+json.videoList[i].video_tl+"&gt;</strong>";
						video_html += "			</div>";
						video_html += "			<div class=\"addVideo\">";
						video_html += "				<iframe src=\""+json.videoList[i].video_url+"\" frameborder=\"0\" allowfullscreen></iframe>";
						video_html += "			</div>";
						video_html += "			<div class=\"addVidel_tail\"><strong>제공 : "+json.videoList[i].ofr_bze_nm+"</strong></div>";
						video_html += "		</div>";

					}

					video_html += "</div>";
					$(".layer__video").css("display","");
					$("#enuri_caution").after(video_html);
				}

			}

		},
		error: function (xhr, ajaxOptions, thrownError) {
			//alert(xhr.status);
			//alert(thrownError);
		}
	});

}

/***********************************************
   KC 인증마크 관련 함수.
 ************************************************/
function getVipKcMark() {
	// 안전인증 및 적합성 인증 여부 데이터 호출 로직
	var param = {
			"cate" : szCategory,
			"modelno" : gModelno
		}

	$.ajax({
		type : "get",
		url : "/lsv2016/ajax/getKcInfo_ajax.jsp",
		async: true,
		data : param,
		dataType : "json",
		success: function(json) {
			var isViewCert = "N";

			if (json && json.kc_info != undefined) {
				var kcObj = json.kc_info;

				//전기용품 안전인증 검사 - 노출 카테고리 일 경우
				if (kcObj.cert_yn != "" && kcObj.cert_yn == "Y") {
					if (kcObj.cert_value != "T" && kcObj.cert_name != "" && kcObj.cert_key != "") {	// template 가 아닌 경우
						$("#cert_title_text_id").text(kcObj.cert_name);
						$("#cert_num_exist_id").find(".gopage").html(kcObj.cert_key);

						$("#cert_num_exist_id").find(".gopage").attr("href", "http://safetykorea.kr/search/searchPop?certNum=" + kcObj.cert_key + "&menu=search");

						$("#cert_template_id").hide();
						$("#cert_num_exist_id").show();


					} else {
						$("#cert_num_exist_id").hide();
						$("#cert_template_id").show();
					}
					isViewCert = "Y";
					$("#cert_view_tr_id").show();
				} else {
					$("#cert_num_exist_id").hide();
					$("#cert_template_id").show();
					$("#cert_view_tr_id").hide();
				}

				//적합성 평가 검사 - 노출 카테고리 일 경우
				if (kcObj.suit_yn != "" && kcObj.suit_yn == "Y") {
					if (kcObj.suit_value != "T" && kcObj.suit_key != "") {
						$("#suit_num_exist_id").find(".gopage").html(kcObj.suit_key);

						$("#suit_template_id").hide();
						$("#suit_num_exist_id").show();


					} else {
						$("#suit_num_exist_id").hide();
						$("#suit_template_id").show();
					}
					isViewCert = "Y";
					$("#suit_view_tr_id").show();
				} else {
					$("#suit_num_exist_id").hide();
					$("#suit_template_id").show();
					$("#suit_view_tr_id").hide();
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

function getGoods_explain1(){
	$(".offerer_wrap .offerer_tabs li").click(function(){
		var vThis = $(this);
		var vThisId= vThis.attr("id");
		$(".offerer_wrap .offerer_tabs li a").removeClass("on");
		$("#explain").find(".offerer_conts .offerer").hide();

		vThis.find("a").addClass("on");

		if(vThisId=="opt_ecatal_out"){
			$("#area_ecatal_out").show();
		}else if(vThisId=="opt_mall_desc"){
			$("#area_mall_desc").show();
		}else if(vThisId=="opt_enuri_desc"){
			$("#area_enuri_desc").show();
		}
		$("#explain").find(".btn_area").hide();
		setTimeout('fn_moreBtn()',1000);

	});
	$('#area_ecatal_out').hide();
	$('#area_mall_desc').hide();
	$('#area_enuri_desc').hide();

	var param = {
		"modelno" : gModelno
		//"procType" : proctype
	};
	$.ajax({
		type : "get",
		url : "/lsv2016/ajax/detail/getGoodsDesc_ajax.jsp",
		async: true,
		data : param,
		dataType : "json",
		success: function(json) {
			var ecatal_out_yn = json["ecatal_out_yn"];
			var mall_desc_yn = json["mall_desc_yn"];
			var enuri_desc_yn = json["enuri_desc_yn"];

			//주의사항
			getGoods_caution();
			//요약설명 table형태
			var enuri_spec_table = json["enuri_spec_table"];
			var enuri_spec_text = json["enuri_spec_text"];
			enuri_spec_text = enuri_spec_text.replace("&nbsp;&nbsp;/&nbsp;&nbsp;","/");
			draw_enuri_spec_table(enuri_spec_table, enuri_spec_text);

			if(ecatal_out_yn=="Y"){
				getGoods_explainEcatal(json);
				$('#explain').show();
				$('#opt_ecatal_out').show();
			}else{
				$('#opt_ecatal_out').hide();
			}
			if(mall_desc_yn=="Y"){
				getGoods_explainMall(json);
				$('#explain').show();
				$('#opt_mall_desc').show();
			}else{
				$('#opt_mall_desc').hide();
			}

			if(enuri_desc_yn=="Y"){
				getGoods_explainEnuri(json);
				$('#explain').show();
				$('#opt_enuri_desc').show();
			}else{
				$('#opt_mall_desc').hide();
			}

			if(ecatal_out_yn=="N" && mall_desc_yn=="N" && enuri_desc_yn=="N"){ //상세설명이 아무것도 없음
				$('#explain').hide();
				return;
			}

			if(ecatal_out_yn=="Y"){
				$('#opt_ecatal_out > a').get(0).className = 'on';
				$("#area_ecatal_out").show();
			}else if(ecatal_out_yn=="N"){
				if(mall_desc_yn=="Y"){
					$('#opt_mall_desc > a').get(0).className = 'on';
					$("#area_mall_desc").show();
				}else if(enuri_desc_yn=="Y"){
					$('#opt_enuri_desc > a').get(0).className = 'on';
					$("#area_enuri_desc").show();
				}
			}

		},
		complete : function(){
			setTimeout('fn_moreBtn()',1000);
		},
		error: function (xhr, ajaxOptions, thrownError) {
			//alert(xhr.status);
			//alert(thrownError);
		}
	});
}

function getGoods_explainEcatal(json){
	var ecatal_out_src = json["ecatal_out_src"]; //이미지url
	var ecatal_out_from = json["ecatal_out_from"]; //제공 업체명
	var ecatal_html = "";
	if(ecatal_out_src!=""){
		$('#opt_ecatal_out span em').html(ecatal_out_from);//.removeTag()
		$('#opt_ecatal_out span em a').click(function(event) {
		    event.preventDefault();
		 });

		$('#area_ecatal_out div.message span.txt em').html(ecatal_out_from);
		$('#area_ecatal_out div.message span.txt_source em').html(ecatal_out_from);
		ecatal_html = "<img class=\"listShowImg\" data-original=\""+ecatal_out_src+"\" src=\""+ecatal_out_src+"\" onerror=\"this.src='"+noImageStr+"'\"/>";
		$('#area_ecatal_out div.pro_intro div.pro_image').html(ecatal_html);
		//$('#area_ecatal_out').show();
		// $("img.lazy").lazyload({
		// 	load  : function(){
		// 		setTimeout('fn_moreBtn()',1000);
		// 	}
		// });
	}
}
function getGoods_explainMall(json){
	var mall_desc_plno = json["mall_desc_plno"];
	var mall_desc_shopnm = json["mall_desc_shopnm"];
	var mall_desc_contents = json["mall_desc_contents"].replace("<style","<!-- style").replace("/style>","/style -->");
	mall_desc_contents = mall_desc_contents.replace(/<STYLE/gi,"<!-- <style").replace(/STYLE>/gi,"style> -->");
	if(mall_desc_shopnm && mall_desc_shopnm.length>0 && mall_desc_contents && mall_desc_contents.length>0){
		$('#opt_mall_desc span em').html(mall_desc_shopnm);
		$('#area_mall_desc div.message span.txt_source em').html(mall_desc_shopnm);
		$('#area_mall_desc div.message span.txt em').html(mall_desc_shopnm);
		if(mall_desc_plno && parseInt(mall_desc_plno)>0){
			$('#area_mall_desc div.message a.btn_mallmove').click(function() {
				//해당 쇼핑몰 링크
				CmdGotoURL2(0,'move_link','','',gModelno,'','','','',mall_desc_plno);
				return false;
			});
		}
		try{
			$('#area_mall_desc div.pro_intro div.pro_image').html(mall_desc_contents);
		}catch(e) {	$('#area_mall_desc div.pro_intro div.pro_image').html("");}

		//$('#area_mall_desc').show();
	}
}
function getGoods_explainEnuri(json){

	//에누리 상세정보 호출

	//$('#area_enuri_desc').show();
	load_enuri_desc = true;

	var enuri_under19_yn = json["enuri_under19_yn"]; //성인용품 19금 처리여부
	if(enuri_under19_yn=="Y") { //19금처리
		$('#adult_warnning').show();
		$('#adult_warnning').find('> div > p > a').click(function() {
			goAdultCheck('location.reload','');
			return false;
		});
	}else{
		//사이즈 정보
		var enuri_size = json["enuri_size"];
		if(enuri_size) {
			var g_sizeStrAry = enuri_size.split("^");
			if(g_sizeStrAry.length>0) {
				for(var i=0; i<g_sizeStrAry.length; i++) {
					var g_sizeItem = g_sizeStrAry[i];

					if(g_sizeItem.length>0) {
						var g_sizeItemStr = "<li>"+g_sizeItem+"</li>";
						$('#detailProdSizesDiv').append(g_sizeItemStr);
					}
				}
			}
			$('#detailProdSizesDiv').show();
			$('#detailProdSpecDiv').show();
		}

		//크기정보 아이콘
		var enuri_cateicon = json["enuri_cateicon"];
		if(enuri_cateicon) {
			if(enuri_cateicon.length>0) {
				var html = "<img id=\"img_category_icon\" src=\""+enuri_cateicon+"\" border=\"0\" align=\"absmiddle\">";
				$('#detailProdSizesDiv').append(html);
			}
			$('#detailProdCateIconDiv').show();
			$('#detailProdSpecDiv').show();
		}

		//인증정보
		var goods_attribute_certi = json["goods_attribute_certi"];
		var goods_attribute_certi_cnt = 0;
		if(goods_attribute_certi){
			$.each(goods_attribute_certi, function(Index, listData) {
				var certi_attribute_id = listData["attribute_id"];
				var certi_attribute_element_id = listData["attribute_element_id"];
				var certi_iconno = listData["iconno"];
				var certi_attribute_element = listData["attribute_element"];
				var certi_ref_kb_no = listData["ref_kb_no"];
				if(certi_iconno) {
					var goods_attribute_certiStr = "<li>";if(certi_ref_kb_no>0){goods_attribute_certiStr +="<a href=\"javascript:///\" onclick=\"showTermDic("+certi_attribute_id+", "+certi_attribute_element_id+", this);\"><span class=\"brup\"></span>";}goods_attribute_certiStr +="<img src=\"http://img.enuri.info/images/f_icon/"+certi_iconno+"_b.gif\" alt=\""+certi_attribute_element+"\">";if(certi_ref_kb_no>0){goods_attribute_certiStr +="</a>";}goods_attribute_certiStr +="</li>";

					$('#mark_box_cermark').find(".marklist").append(goods_attribute_certiStr);

					goods_attribute_certi_cnt++;
				}
			});
		}
		if(goods_attribute_certi_cnt>0){
			$('#detailProdSpecDiv').show();
			$('#mark_box_cermark').show();
		}

		//알레르기성분
		var goods_attribute_allergy = json["goods_attribute_allergy"];
		var goods_attribute_allergy_cnt = 0;
		if(goods_attribute_allergy){
			$.each(goods_attribute_allergy, function(Index, listData) {
				var allergy_attribute_id = listData["attribute_id"];
				var allergy_attribute_element_id = listData["attribute_element_id"];
				var allergy_iconno = listData["iconno"];
				var allergy_attribute_element = listData["attribute_element"];
				var allergy_ref_kb_no = listData["ref_kb_no"];
				if(allergy_iconno) {
					var goods_attribute_allergyStr = "<li>";if(allergy_ref_kb_no>0){goods_attribute_allergyStr +="<a href=\"javascript:///\" onclick=\"showTermDic("+allergy_attribute_id+", "+allergy_attribute_element_id+", this);\"><span class=\"brup\"></span>";}goods_attribute_allergyStr +="<img src=\"http://img.enuri.info/images/f_icon/"+allergy_iconno+"_b.gif\" alt=\""+allergy_attribute_element+"\">";if(allergy_ref_kb_no>0){goods_attribute_allergyStr +="</a>";}goods_attribute_allergyStr +="</li>";

					$('#mark_box_algrmark').find(".marklist").append(goods_attribute_allergyStr);

					goods_attribute_allergy_cnt++;
				}
			});
		}
		if(goods_attribute_allergy_cnt>0){
			if(goods_attribute_certi_cnt<=0) $('#mark_box_algrmark').css("margin-left","0px");
			$('#detailProdSpecDiv').show();
			$('#mark_box_algrmark').show();
		}


		//스펙 아이콘
		var func_iconsStr = json["enuri_func_icon"];
		var func_iconsCnt = 0;
		if(func_iconsStr){
			$.each(func_iconsStr, function(Index, listData) {
				var func_iconsItem = listData["src"];

				if(func_iconsItem) {
					var func_iconsItemStr = "<li><img src=\""+func_iconsItem+"\" alt=\"\" /></li>";

					$('#detailProdIconsDiv').find("ul").append(func_iconsItemStr);

					func_iconsCnt++;
				}
			});
		}
		if(func_iconsCnt>0){
			$('#detailProdIconsDiv').show();
			$('#detailProdSpecDiv').show();
		}

		//동영상 정보
		var html = "";
		var enuri_out_movie = json["enuri_out_movie"];
		if(enuri_out_movie) {
			if(enuri_out_movie.length>0) {
				for(var i=0; i<enuri_out_movie.length; i++) {
					var g_movieTitle = enuri_out_movie[i].title;
					var g_movieSrc = enuri_out_movie[i].src;
					var g_movieFrom = enuri_out_movie[i].from;

					if(html!="")html +="<br>";
					html +="<div class=\"div_addVideo\" align=\"center\">";
					html +="	<div class=\"addVideo_title\"><strong>&lt;"+g_movieTitle+"&gt;</strong></div>";
					html +="	<div class=\"addVideo\">"+g_movieSrc+"</div>";
					html +="	<div class=\"addVideo_tail\"><strong>제공: "+g_movieFrom+"</strong></div>";
					html +="</div>";
					html +="<br>";
				}
				html +="<br>";
			}
			$('#detailProdBigImageDiv div.pro_movie').html(html);
		}

		//큰이미지
		var bigImageUrlStr = json["bigimage"];
		var fImgChk = json["fImgChk"];

		var bigimage_webshopnm = json["bigimage_webshopnm"];
		var bigimage_webplno = json["bigimage_webplno"];

		var enuriPcViewYn = json["enuripc_view_yn"];
		var enuripcImgUrl = json["enuripc_img_url"];

		//PC견적 이미지 사용 시 이미지 경로 변경 함.
		if (enuriPcViewYn && enuriPcViewYn == "Y" && enuripcImgUrl && enuripcImgUrl.length > 0) {
			bigImageUrlStr = enuripcImgUrl;
		}

		if(bigImageUrlStr && bigImageUrlStr.length>0) {
			$('#detailProdBigImageDiv').show();
			$('#detailProdBigImageDiv')
				.find("img").attr("src", bigImageUrlStr)
				.error(function(){ //오류시 준비중 이미지 안내
					$('#detailProdBigImageDiv').hide();
					$('#detailProdBigImageReadyDiv').hide();
				});

			if(bigimage_webshopnm && bigimage_webshopnm.length>0){
				$('#detailProdBigImageDiv div.no_attbu p em').html(bigimage_webshopnm);
				$('#detailProdBigImageDiv div.no_attbu').show();
				$('#detailProdBigImageDiv div.pro_image').removeClass("pro_image");
				if(parseInt(bigimage_webplno)>0){
					$('#detailProdBigImageDiv').find("img").attr("style","cursor:pointer");
					$('#detailProdBigImageDiv').find("img").click(function(){
						CmdGotoURL2(0,'move_link','','',gModelno,'','','','',bigimage_webplno);
					});
				}
			}

		}else{ //준비중 이미지 안내
			$('#detailProdBigImageReadyDiv').hide();
			/*if((parseInt(nMallCnt) <= 0 && parseInt(nMallCnt3) <=0) || fImgChk==5){
				$('#detailProdBigImageReadyDiv').hide();
			}*/
		}
	}
	//상세설명
	var enuri_func_title = json["enuri_func_title"];
	if(enuri_func_title && enuri_func_title.length>0){
		$('#spec_explain').show();
		$('#cm_news').html(enuri_func_title);
	}
	var enuri_func_1 = json["enuri_func_1"];
	var enuri_func_2 = json["enuri_func_2"];
	var enuri_func_3 = json["enuri_func_3"];

	if(enuri_func_1 || enuri_func_2 || enuri_func_3){
		$('#spec_explain').show();
	}

	if(enuri_func_1 && enuri_func_1.length>0){
		$('#spec_explain_col1').html("<pre>"+enuri_func_1+"</pre>");
	}else{
		$('#spec_explain_col1').html('');
	}
	if(enuri_func_2 && enuri_func_2.length>0){
		$('#spec_explain_col2').html("<pre>"+enuri_func_2+"</pre>");
	}else{
		$('#spec_explain_col2').html('');
	}
	if(enuri_func_3 && enuri_func_3.length>0){
		$('#spec_explain_col3').html("<pre>"+enuri_func_3+"</pre>");
	}else{
		$('#spec_explain_col3').html('');
	}

	var enuri_func_scrap = json["enuri_func_scrap"];
	if(enuri_func_scrap && enuri_func_scrap=="Y"){
		$('#enuri_func_scrap').show();
		$('#enuri_func_scrap').click(function() {
			insertLogCate(14524);
			$('#enuri_func_scrap_clause').get(0).className="unchkb";
			$('#enuri_func_ScrapLayer').toggle();
			return false;
		});
		$('#enuri_func_scrap_go').click(function() {
			if($('#enuri_func_scrap_clause').get(0).className=="unchkb"){
				alert("카탈로그 퍼가기 이용 약관에 동의하셔야 퍼가기가 가능합니다.");
			}else if($('#enuri_func_scrap_clause').get(0).className=="chkb"){
				var s_param = {
					"modelno" : gModelno,
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
						var varImgUrl = "http://storage.enuri.info/func_info/enuri/"+ImgFolder(gModelno)+"/"+gModelno+"_1.png";
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
		});
	}
	//용어사전
	var enuri_termdic1 = json["enuri_termdic1"];
	var enuri_termdic2 = json["enuri_termdic2"];
	var enuri_termdic3 = json["enuri_termdic3"];
	if(enuri_termdic1 || enuri_termdic2 || enuri_termdic3){
		$('#spec_termdic').show();
	}
	for(i=0; i<3; i++){
		var term_obj;
		var termdic_col;
		if(i==0){
			term_obj = enuri_termdic1;
			termdic_col = $('#spec_termdic_col1');
		}else if(i==1){
			term_obj = enuri_termdic2;
			termdic_col = $('#spec_termdic_col2');
		}else if(i==2){
			term_obj = enuri_termdic3;
			termdic_col = $('#spec_termdic_col3');
		}
		if(term_obj && term_obj.length>0){
			$.each(term_obj, function(Index, listData) {
				var term_html = "";
				var kbno = listData["kbno"];
				var title = listData["title"];
				var titmeimg = listData["titmeimg"];
				var img_width = listData["img_width"];
				var img_height = listData["img_height"];
				var func_content = listData["func_content"];
				var func_option = listData["func_option"];
				if(Index>0) term_html +="<br>";
				term_html += "<table width=264 cellspacing=0 cellpadding=0 border=0><tbody><tr><td style='padding-bottom:2px;padding-top:2px;'>";
				term_html += "<span style='ont-size:12px;background-color:#e6e6e6;color:#2f2f2f;padding:0px 2px 1px 2px;font-weight:bold;'>&nbsp;" + title + "&nbsp;</span>";
				if(func_option=="1"){
					//용어사전 레이어(자세히)
					term_html += "&nbsp;<img align='absmiddle' src='http://img.enuri.info/images/view/blue/btn_picture_0813.gif' onclick='showTermDicKb("+kbno+", this);' style='cursor:pointer;'>";
				}else if(func_option=="2"){
					//지식통 링크(더보기)
					//term_html += "&nbsp;<img align='right' src='http://img.enuri.info/images/detail/more_btn.gif' onclick='CmdGotoBeginnerDic("+kbno+");' style='cursor:pointer;'>";
				}
				term_html += "</td></tr></tbody></table>";
				term_html += "<pre style='margin:0 0 0 0;padding:0 0 0 0;font-size:8pt;color:#000000;line-height:16px;word-break:break-all;' width=268 align=left>";
				var kttFuncContent = func_content.split("<break>");
				if(kttFuncContent.length>1) {
					if(kttFuncContent[0].length>2 && kttFuncContent[0].substring(kttFuncContent[0].length-2)=="\r\n") {
						kttFuncContent[0] = kttFuncContent[0].substring(0, kttFuncContent[0].length-2) + "<br>";
					}
					term_html += kttFuncContent[0];
				}
				if(titmeimg.length>0) {
					// 플래쉬 일 경우
					if(titmeimg.length>4 && titmeimg.substring(titmeimg.length-4)==".swf") {
						term_html += "<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" codebase=\"http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0\" width=\""+img_width+"\" height=\""+img_height+"\" id=\"titleimg_"+kbno+"\" align=\"left\" style=\"margin-bottom:2;border:1 solid gray;\">";
						term_html += "<param name=\"allowScriptAccess\" value=\"always\" /><param name=\"allowFullScreen\" value=\"false\" /><param name=\"quality\" value=\"high\" /><param name=\"wmode\" value=\"transparent\" />";
						term_html += "<param name=\"bgcolor\" value=\"#ffffff\" /><param name=\"movie\" value=\"http://storage.enuri.info/pic_upload/termdictitle/"+titmeimg+"\" />";
						term_html += "<param name=\"FlashVars\" value=\"\" /><embed src=\"http://storage.enuri.info/pic_upload/termdictitle/"+titmeimg+"\" quality=\"high\" wmode=\"transparent\" bgcolor=\"#ffffff\" width=\""+img_width+"\" height=\""+img_height+"\" id=\"titleimg_"+kbno+"\" name=\"titleimg_"+kbno+"\" align=\"left\" swLiveConnect=true allowScriptAccess=\"always\" type=\"application/x-shockwave-flash\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\" /></embed>";
						term_html += "</object>";
					} else { // 일반 이미지 일 경우
						term_html += "<img align='left' src='http://storage.enuri.info/pic_upload/termdictitle/"+titmeimg+"' onload=\"resizeGuideHeaderImage(this)\" style=\"border:1px solid gray;margin:0 4px 2px 0;padding:0 0 0 0;\">";
					}
				}
				if(kttFuncContent.length>1) {
					term_html += kttFuncContent[1];
				} else {
					term_html += kttFuncContent[0].replace("<P ", "<span ").replace("</P>", "</span>");
				}
				term_html += "</pre>";
				termdic_col.append(term_html);
			});
		}else{
			termdic_col.html('');
		}
	}
	//제조사 안내
	var enuri_factory_tel = json["enuri_factory_tel"];
	var enuri_factory_telnm = json["enuri_factory_telnm"];
	var enuri_factory_url1 = json["enuri_factory_url1"];
	var enuri_factory_url1nm = json["enuri_factory_url1nm"];
	var enuri_factory_url2 = json["enuri_factory_url2"];
	var enuri_factory_url2nm = json["enuri_factory_url2nm"];
	var enuri_factory_html = "";
	if(enuri_factory_tel && enuri_factory_tel.length>0 && enuri_factory_telnm && enuri_factory_telnm.length>0){
		enuri_factory_html += "<em>" + enuri_factory_telnm + "</em><em>TEL. " + enuri_factory_tel + "</em>";
	}
	if(enuri_factory_url1 && enuri_factory_url1.length>0 && enuri_factory_url1nm && enuri_factory_url1nm.length>0){
		if(enuri_factory_url1.length>=7) {
			if(enuri_factory_url1.substring(0,7)!="http://") {
				enuri_factory_url1 = "http://" + enuri_factory_url1;
			}
		}
		enuri_factory_html += "<a class='homepg' href='" + enuri_factory_url1 + "' title='' target='_new'>" + enuri_factory_url1nm + "</a>";
	}
	if(enuri_factory_url2 && enuri_factory_url2.length>0 && enuri_factory_url2nm && enuri_factory_url2nm.length>0){
		if(enuri_factory_url2.length>=7) {
			if(enuri_factory_url2.substring(0,7)!="http://") {
				enuri_factory_url2 = "http://" + enuri_factory_url2;
			}
		}
		enuri_factory_html += "<a class='homepg' href='" + enuri_factory_url2 + "' title='' target='_new'>" + enuri_factory_url2nm + "</a>";
	}
	if(enuri_factory_html.length>0){
		if($('#spec_explain').css("display")=="none" && $('#spec_termdic').css("display")=="none"){
			$('#factory_tel').removeClass("maker");
			$('#factory_tel').addClass("makerb");
		}
		$('#factory_tel').show();
		$('#factory_tel > p').append(enuri_factory_html);
	}
	//설명서 안내
	var enuri_manual_viewernm = json["enuri_manual_viewernm"];
	var enuri_manual_viewerlink = json["enuri_manual_viewerlink"];
	var enuri_manual = json["enuri_manual"];
	var enuri_manual_factory = json["enuri_manual_factory"];
	var enuri_manual_html = "";
	if((enuri_manual && enuri_manual.length>0) || (enuri_manual_factory && enuri_manual_factory.length>0)){
		enuri_manual_html += "<em>설명서</em>";
		if(enuri_manual && enuri_manual.length>0){
			enuri_manual_html += "<a class='btn_sq4' href='" + enuri_manual + "' title='' target='_new'>설명서보기</a>";
		}
		if(enuri_manual_factory && enuri_manual_factory.length>0){
			enuri_manual_html += "<a class='btn_sq4' href='" + enuri_manual_factory + "' title='' target='_new'>제조사 설명서 목록</a>";
		}
		if(enuri_manual_viewernm && enuri_manual_viewernm.length>0 && enuri_manual_viewerlink && enuri_manual_viewerlink.length>0){
			enuri_manual_html += "<span class='txt'>설명서가 안 보이시면<a class='acrobat' href='" + enuri_manual_viewerlink + "' title='새 페이지 이동' target='_new'>" + enuri_manual_viewernm + "</a>를 설치해주세요</span>";
		}
	}
	if(enuri_manual_html.length>0){
		if($('#spec_explain').css("display")=="none" && $('#spec_termdic').css("display")=="none" && $('#factory_tel').css("display")=="none"){
			$('#factory_manual').removeClass("manual");
			$('#factory_manual').addClass("manualb");
		}
		$('#factory_manual').show();
		$('#factory_manual > p').append(enuri_manual_html);
	}

}



function goAdultCheck(func,url){
	OpenWindowDetail('/login/Adult_Check.jsp?func='+func+'&url='+url,'adultcheck','430','260','no','no','yes','no','no','100','100');
}
function CmdGotoBeginnerDic(kb_no){
	var kind = "2";
	var wWidth = 734+30+6;
	insertLogCate(2397);
	insertTermDicTitleLog('link', kb_no);
	if (typeof(kind)=="number" && kind==20) wWidth = wWidth+35;
	var wHeight = screen.availHeight;
	var win = window.open("/knowbox/List.jsp?kind="+kind+"&kbno="+((typeof(kb_no)=="number")?kb_no:0)+"&btnhits=yes");
	win.focus();
}
function insertLogCate(logNum){
	var url = "/view/Loginsert.jsp";
	var param = "kind="+logNum+"&modelno="+gModelno+"&cate="+szCategory;
	$.ajax({
		type: "GET",
		url: url,
		data: param
	});
}
function insertTermDicTitleLog(vmode, kb_no){
	var url = "/view/include/IncBeginnerDic_Loginsert.jsp";
	var param = "vmode="+vmode+"&kb_no="+kb_no+"&vtype=GOOD";
	$.ajax({
		type: "GET",
		url: url,
		data: param
	});
}
function ImgFolder(modelno){
    var output = "1";
    var input = parseInt(modelno,10) + "";

    if(modelno<1000){
        output = "1";
    }else{
        output = input.substr(0, input.length-3) + "000";
    }
	return output;
}
function callCDNImg(url){
	var cdn_url = "http://async.wisen.gscdn.com/rsync?id=1103&files=" + url;
	var cdn_if = document.createElement("iframe");
	cdn_if.style.width = "0px";
	cdn_if.style.height = "0px";
	cdn_if.style.display = "none";
	cdn_if.width = "0";
	cdn_if.height = "0";
	//cdn_if.src = cdn_url;
	cdn_if.setAttribute("src", cdn_url);

	document.body.appendChild(cdn_if);

	//코센CDN 추가
	callCDNImg_Cocen(url);
}

function callCDNImg_Cocen(url){
	var cdn_url = "/etc/cdnPurge.jsp?urls=" + encodeURI(url);
	var param = "urls="+url;
	$.ajax({
		type: "POST",
		url: cdn_url,
		data: param,
		async: false
	});
}

function resizeGuideHeaderImage(obj){
	if(obj.width>115){
	  obj.width = 115;
	}
}
//getGoods_explain(1);

var fn_moreBtn = function(){
	var vExplainTab = $("#explain .offerer_wrap .offerer_tabs");
	var vActiveTab = $(vExplainTab).find(".on").parent().index();
	var vActiveContent = $("#explain .offerer_conts div.offerer").get(vActiveTab);
	var vActiveHeight = $(vActiveContent).height();
	if(vActiveHeight > 1200){
		$("#explain").find(".btn_area").show();
		if($("#explain").hasClass("unfold")){
			$("#explain").removeClass("unfold");
			$("#explain").addClass("fold");
		}
		$(".btn_detail_unfold").unbind("click");
		$(".btn_detail_unfold").click(function(){
			$(this).closest('.explain').addClass('unfold');
		})
		$(".btn_detail_fold").unbind("click");
		$(".btn_detail_fold").click(function(){
			$(this).closest('.explain').removeClass('unfold');
			// 스크롤 이동
			var movPos = $(".offerer_tabs").offset().top + (1320 - $(window).height());
			$("html,body").stop(true,false).animate({"scrollTop":movPos},"slow");
		})

	}else{
		$("#explain").find(".btn_area").hide();
	}
}
