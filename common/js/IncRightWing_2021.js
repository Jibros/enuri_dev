/* 불편오류신고 버튼 */
$("#singoButton").click(function() {
	var strType = "1";
	var modelno = "";
	if (rbViewFlag == 1) {
		strType = "3";
		modelno = gModelData.gModelno;
	}

	$.ajax({
		url : "/wide/common/jsp/Inconv.jsp",
		data : "cate=" + strCate_banner + "&type=" + strType + "&modelno=" + modelno + "&shop_code=0",
		dataType : "HTML",
		type:"get",
		success : function(result){
			$("#div_inconv").show();
			$("#div_inconv").html(result);

			var layerSize = 370;
			if (rbViewFlag == 1) {
				layerSize = 460;
			}

			var lStyle = "";
			lStyle += "position:fixed;";
			lStyle += "z-index:9999;";
			lStyle += "top:" + ($("#ulFixed").position().top - layerSize) + "px;";
			lStyle += "left:" + ($("#ulFixed").position().left - 382) + "px;";

			$("#div_inconv").attr("style", lStyle);
			insertLog(24285);
		},
		error: function(request,status,error){
			//alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
      	}
	});
});

/* Top 버튼 */
$("#grGoTop").click(function() {
	$('body,html').animate({
		scrollTop: 0
	}, 1);
	insertLog(24287);
});

function fn_banner_info(param) {
  	var newDate = new Date();
  	var vNewDate = newDate.getTime();

	$.ajax({
		type:"get",
		url: "/lsv2016/ajax/getRightBanner_ajax.jsp",
		data:"cate=" + strCate_banner + "&type=i&newdate="+vNewDate,
		dataType: "JSON",
		success:function(result) {
			newTotCnt = result.intMyTodayCnt;
			zzimTotCnt = result.intMySaveCnt;
			$("#wing_btn_recent_cnt").text(result.intMyTodayCnt);
			$("#wing_head_recent_cnt").text(result.intMyTodayCnt);
			if(result.intMySaveCnt2 > 10){
				$("#wing_head_zzim_cnt").text("10+");
			}else{
				$("#wing_head_zzim_cnt").text(result.intMySaveCnt);
			}

			if ($("#divRecent").css("display") != "none") {
				if(param != "" && typeof param != "undefined"){
					fn_banner_list(param);
				}else{
					fn_banner_list('r');
					fn_banner_list('z');
				}
			}

			if(vWingfrom =="main" && result.intMyTodayCnt > 0){	//메인에서 진입시 내용 보여줌. 단, 최근본상품이 있을때만.
				$(".tab__recentlist").hide();
				$(".tab__recentlist").siblings(".recentzzimbox").show();
			}

			$("#recent_title").unbind("click");
			$("#recent_title").click(function(){
				insertLog(17009);
	            resentZzimOpen(1);
			});

			$("#zzim_title").unbind("click");
			$("#zzim_title").click(function(){
				insertLog(17013);
	            resentZzimOpen(2);
			});

			function resentZzimOpen(listType) {
		         var openUrl = "/view/resentzzim/resentzzimList.jsp?listType="+listType;
		         var resentZzimWin = window.open(openUrl,"resentZzimWin","width=804,height="+window.screen.height+",left=0,top=0,toolbar=no,directories=no,status=no,scrollbars=yes,resizable=yes,menubar=no");

		         resentZzimWin.focus();
		    }
		},
		error: function(request,status,error){
			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
      	}
	});
}

function fn_banner_list(param) {
	var typeStr = param;
  	var newDate = new Date();
  	var vNewDate = newDate.getTime();
  	var rbPageSize = 3;
  	if(typeStr == 'z') rbPageSize = 1;

	var vNowpage = "";
	if(typeStr == "r"){
		vNowpage = "recent";
		rbPage = rbPage_recent;
	}
	if(typeStr == "z"){
		vNowpage = "zzim";
		rbPage = rbPage_zzim;
	}

	$.ajax({
		url : "/lsv2016/ajax/getRightBanner_ajax.jsp",
		data : "from=main&type="+typeStr+"&page="+rbPage+"&size="+rbPageSize+"&newdate="+vNewDate,
		dataType : "JSON",
		type:"get",
		success : function(result){
			var rList = result.goodslist;
			var rHtml = "";
			/* 최근, 찜 목록 조회 */
			if (typeStr == "r"){
				$("#wing_recent_list").html("");
			}else if (typeStr == "z"){
				$("#wing_zzim_list").html("");
			}

			if (typeStr == "r" && newTotCnt == 0) {
				$("#wing_recent_list").html("<div class=\"wing-summ__prod--none\"> 최근 본 상품이<br/>없습니다. </div>");
			} else if (typeStr == "z" && zzimTotCnt == 0) {
				$("#wing_zzim_list").html("<div class=\"wing-summ__prod--none\"> 찜한 상품이<br/>없습니다. </div>");
			} else if (rList != null && rList.length > 0) {
				for(i = 0; i < rList.length; i++) {
					var rObj = rList[i];
					if (rObj.typeCode == "P") {
						var prodno = rObj.typeCode + rObj.pl_no;
						var org_price = rObj.price != "" ? rObj.price.replace(/,/g, ""): price;
						var instance_price = rObj.instance_price != "" ? rObj.instance_price.replace(/,/g, "") : instance_price;
						var org_instance_price = rObj.instance_price;

						rHtml += "<li class=\"wing-summ__prod__item\">";
						rHtml += "<!-- 상품선택 / 상품비교 -->";
						rHtml += "	<div class=\"wing-summ__prod__compare \">";
						rHtml += "    	<input type=\"checkbox\" class=\"input--checkbox-item\" value=\"P:" + rObj.pl_no + "\" name=\"chkNo\" id=\"chk"+typeStr+rObj.typeCode+"_"+(i+1)+"\">";
						rHtml += "    	<label for=\"chk"+typeStr+rObj.typeCode+"_"+(i+1)+"\" class=\"rbGoodsChk_"+ vNowpage + " groupItemCheck \"></label>";
						rHtml += "    	<!-- 버튼 : 비교 -->";
						rHtml += "    	<div class=\"wing-summ__btn--compare\">상품비교</div>";
						rHtml += "	</div>";
						rHtml += "	<!-- 썸네일 -->";
						rHtml += "	<div class=\"wing-summ__prod__thumb\">";
						rHtml += "    	<a href=\"javascript:;\" class=\"recentzzim__click\"><img src=\"" + rObj.imgUrl + "\" alt=\"\"></a>";                                            
						rHtml += "	</div>";
						rHtml += "	<!-- 오버시 확장 레이어 -->";
						rHtml += "	<div class=\"wing-summ__prod__extend\">";
						rHtml += "    	<a href=\"javascript:;\">";
						rHtml += "        	<span class=\"wing-summ__prod__name\">" + rObj.goodsName + "</span>";
						var strPrice = rObj.price;
						if ( org_price > instance_price && instance_price>0) {
							strPrice = org_instance_price;
						}
						rHtml += "        	<span class=\"wing-summ__prod__price\"><em>"+ strPrice +"</em>원</span>";
						rHtml += "    	</a>";
						rHtml += "    	<!-- 버튼 : 삭제 -->";
						rHtml += "    	<button class=\"wing-summ__btn--delete comm__sprite rbGoodsDel_"+ vNowpage +"\" >삭제</button>";
						rHtml += "    	<!-- // -->";
						rHtml += "	</div>";
						rHtml += "</li>";

					} else if (rObj.typeCode == "G" || rObj.typeCode == "GI") {
						var prodno = rObj.typeCode + rObj.nModelNo;
						var onclickClass = "";
						var displayClass = "";
						if(rObj.typeCode == "GI"){
							displayClass = " display:none ";
							insertLogLSV('20443',rObj.ca_code.substring(0,4),rObj.nModelNo);

							// 슈퍼탑 노출로그
							if(rObj.infoAdImpUrl && rObj.infoAdImpUrl.length>0){
								infoadLogExe(rObj.infoAdImpUrl);
							}

							// 슈퍼탑 클릭로그 20190930
							if(rObj.infoAdClickUrl && rObj.infoAdClickUrl.length>0){
								onclickClass = " onclick = \"infoadLogExe('"+rObj.infoAdClickUrl+"');\" "
							}
						}
						/* 모바일 전용 */
						var strMPrice = rObj.mPrice;
						if ($.isNumeric(rObj.mPrice.replace(/,/g, ""))) strMPrice = rObj.mPrice;

						var strMPrice3 = rObj.mPrice3;
						if ($.isNumeric(rObj.mPrice3.replace(/,/g, ""))) strMPrice3 = rObj.mPrice3;
						
						rHtml += "<li class=\"wing-summ__prod__item\">";
						rHtml += "<!-- 상품선택 / 상품비교 -->";
						rHtml += "	<div class=\"wing-summ__prod__compare\" style='"+displayClass+"'>";
						rHtml += "    	<input type=\"checkbox\" class=\"input--checkbox-item\" value=\"G:" + rObj.nModelNo + "\" name=\"chkNo\" id=\"chk"+typeStr+rObj.typeCode+"_"+(i+1)+"\">";
						rHtml += "    	<label for=\"chk"+typeStr+rObj.typeCode+"_"+(i+1)+"\" class=\"rbGoodsChk_"+ vNowpage + " groupItemCheck \"></label>";
						rHtml += "    	<!-- 버튼 : 비교 -->";
						rHtml += "    	<div class=\"wing-summ__btn--compare\">상품비교</div>";
						rHtml += "	</div>";
						rHtml += "	<!-- 썸네일 -->";
						rHtml += "	<div class=\"wing-summ__prod__thumb\">";
						rHtml += "    	<a href=\"javascript:;\" class=\"recentzzim__click\"><img src=\"" + rObj.modelImage + "\" alt=\"\"></a>";                                            
						rHtml += "	</div>";
						rHtml += "	<!-- 오버시 확장 레이어 -->";
						rHtml += "	<div class=\"wing-summ__prod__extend\">";
						rHtml += "    	<a href=\"javascript:;\">";
						rHtml += "        	<span class=\"wing-summ__prod__name\">" + rObj.goodsName + "</span>";
						if ( org_price > instance_price && instance_price>0) {
							rHtml += "        	<span class=\"wing-summ__prod__price\"><em>"+ org_instance_price +"</em>원</span>";
						}else{
							var strPrice = rObj.price;
							/*if(typeof rObj.cashMinPrcYn != "undefined" && rObj.cashMinPrcYn != null && rObj.cashMinPrcYn == "Y" && typeof rObj.cashMinPrcStr != "undefined" && rObj.cashMinPrcStr != null){
								strPrice = rObj.cashMinPrcStr;
							}else if(typeof rObj.tlcMinPrc != "undefined" && rObj.tlcMinPrc != null && rObj.tlcMinPrc > 0) {
								strPrice = rObj.tlcMinPrcStr;
							}else{
								if ( rObj.mMinPrice > rObj.mMinPrice3 && rObj.mMinPrice3>0) {
									strPrice = strMPrice3;
								} else if ( rObj.mallcnt < 1 && rObj.mallcnt3 > 0) {
									strPrice = strMPrice3;
								}else{
									strPrice = strMPrice;
								}
							}*/
							if(parseInt(rObj.mallcnt3) > 0 && parseInt(rObj.mPrice3)==0 && typeof rObj.cashMinPrcYn != "undefined" && rObj.cashMinPrcYn != null && rObj.cashMinPrcYn == "Y" && typeof rObj.cashMinPrcStr != "undefined" && rObj.cashMinPrcStr != null){
								rHtml += "						<span class=\"wing-summ__prod__price\"><em>";
								rHtml += rObj.cashMinPrcStr + "</em>원" + "</span>";
							}else if(typeof rObj.tlcMinPrc != "undefined" && rObj.tlcMinPrc != null && rObj.tlcMinPrc > 0) {
								rHtml += "						<span class=\"wing-summ__prod__price\"><em>";
								rHtml += rObj.tlcMinPrcStr + "</em>원" + "</span>";
							}else{
								if ( rObj.mMinPrice > rObj.mMinPrice3 && rObj.mMinPrice3>0) {
									rHtml += "						<span class=\"wing-summ__prod__price\"><span class=\"mobile\"><em class=\"mobileSendLayer m_price\">모바일</em></span><em> ";
									rHtml += strMPrice3 + "</em>원</span>";
								} else if ( rObj.mallcnt < 1 && rObj.mallcnt3 > 0) {
									rHtml += "						<span class=\"wing-summ__prod__price\"><em><span class=\"icon onlymobile\"><em>모바일전용</em></span><em> ";
									rHtml += strMPrice3 + "</em>원</span>";
								}else{
									rHtml += "						<span class=\"wing-summ__prod__price\"><em>";
									rHtml += strMPrice + "</em>원</span>";
								}
							}
							//rHtml += "        	<span class=\"wing-summ__prod__price\"><em>"+ strPrice +"</em>원</span>";
						}
						rHtml += "    	</a>";
						rHtml += "    	<!-- 버튼 : 삭제 -->";
						rHtml += "    	<button class=\"wing-summ__btn--delete comm__sprite rbGoodsDel_"+ vNowpage +"\">삭제</button>";
						rHtml += "    	<!-- // -->";
						rHtml += "	</div>";
						rHtml += "</li>";

					}else{
						if(rbPage > 1){
							rHtml += "<li>&nbsp;</li>";
						}
					}
				}

				$("#wing_"+ vNowpage +"_list").show();

				$("#wing_"+ vNowpage +"_list").html(rHtml);
			}
			
			$("#wing_"+ vNowpage +"_list .recentzzim__click").mousedown(function() {
				var varDeleteSvModel = $(this).parent().parent().find("input:checkbox[name=chkNo]").val();
				var svType = (varDeleteSvModel.split(":"))[0];
				var svModel = (varDeleteSvModel.split(":"))[1];

				if(typeStr == "r") insertLog(24281);
				if(typeStr == "z") insertLog(24283);

				var url = "";

				if(typeStr == "r" && $(this).parent().find("span").hasClass("ico_ad")){
					insertLogLSV('20509', '', svModel);
				}

				if (svType == "P") {
					url = "/move/Redirect.jsp?type=ex&cmd=move_"+svModel+"&pl_no="+svModel;
				} else {
					url = "/detail.jsp?modelno=" + svModel;
				}

				window.open(url, '_blank');
			});

			/* 페이징 */
			$("#wing_"+ vNowpage +"_page").html("");
			$("#wing_"+ vNowpage +"_page").html("");
			if (result.page > 0) {
				if(typeStr == "r"){
					rbPage_recent = result.page;
				}
				if(typeStr == "z"){
					rbPage_zzim = result.page;
				}

				var nowPage = result.page;
				var endPage = Math.ceil(result.totalCnt / rbPageSize);

				if(typeStr == "z"){
					if(endPage > 10){
						endPage = 10;
					}
				}

				var pHtml = "";
				if (nowPage > 1) {
					pHtml += "<span class=\"paging-arr paging-arr--prev comm__sprite\" id=\"wing_"+ vNowpage +"_page_prev\">이전</span>";
				}
				pHtml += "<em>" + (endPage > 0 ? nowPage : 0) + "</em>/" + endPage;

				if (nowPage < endPage) {
					pHtml += "<span class=\"paging-arr paging-arr--next comm__sprite\" id=\"wing_"+ vNowpage +"_page_next\">다음</span>";
				}
				$("#wing_"+ vNowpage +"_page").html(pHtml);

				$("#wing_"+ vNowpage +"_page_prev").click(function() {
					nowPage = parseInt(nowPage) - 1;

					if(typeStr == "r"){
						rbPage_recent =  nowPage;
					}
					if(typeStr == "z"){
						rbPage_zzim = nowPage;
					}

					if(typeStr == "r") insertLog(24282);
					if(typeStr == "z") insertLog(24284);

					fn_banner_info(typeStr);
				});

				$("#wing_"+ vNowpage +"_page_next").click(function() {
					nowPage = parseInt(nowPage) + 1;

					if(typeStr == "r"){
						rbPage_recent =  nowPage;
					}
					if(typeStr == "z"){
						rbPage_zzim = nowPage;
					}

					if(typeStr == "r") insertLog(24282);
					if(typeStr == "z") insertLog(24284);

					fn_banner_info(typeStr);
				});
			}

			/* 체크박스 체크 */
			$(".rbGoodsChk_"+vNowpage).unbind();
			$(".rbGoodsChk_"+vNowpage).click(function() {
				var checked = false;
				var obj = $(this).parent().find("input").attr("id");
				if (!$("#"+obj).is(":checked")) {
					checked = true;
				} else {
					checked = false;

				}
				
				var checkInputObj = $(this).parent().parent().find("input");
				var prodNo = checkInputObj.val().replace(":", "");

				if (typeStr == "r") insertLog(17010);
				if (typeStr == "s") insertLog(17014);

				//메인과 분리
				if(vWingfrom == "main"){
					var prodType = prodNo.substring(0,1);
					var prodNum = prodNo.substring(1);
					if(checked) {
						//compareProdInput(prodNo);
						svCheck(prodNum,prodType);
						if(svCheck.addModelNos){
							if(ArrayIndexOf(svCheck.addModelNos, prodNum) < 0){
								svCheck(prodNum,prodType);
							}
						}
						goSvResentBigyo();

					} else {
						svCheck(prodNum,prodType);
					}
				}else{
					if(checked) {
						compareProdInput(prodNo);
					} else {
						compareProdDelete(prodNo);
					}

					//compareProdBoxDivOpen();
				}
			});

			/* 삭제버튼 클릭 */
			$(".rbGoodsDel_"+vNowpage).click(function() {
				fn_Goods_del($(this), vNowpage);
			});
		},
		error: function(request,status,error){
			//console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
      	}
	});
}

/* 삭제 */
function fn_Goods_del(obj, nowpage) {
	var varDeleteSvModel = obj.parents("li").find("input:checkbox[name=chkNo]").val();
	var typeStr = "r";

	if(nowpage == "zzim"){
		typeStr = "z";
	}

	var varTbln = "save";
	if (typeStr == "r") {
		varTbln = "today";
	}

	$.ajax({
		url : "/lsv2016/ajax/deleteSaveGoodsProc.jsp",
		data : "modelnos="+varDeleteSvModel+"&tbln="+varTbln,
		type:"get",
		success : function(result){
			if (typeStr == "r") {
				insertLog(14361);
			} else if (typeStr == "z") {
				insertLog(14367);
				if (rbViewFlag == 0 || rbViewFlag == 2) {
					if(vWingfrom != "main") {
						setProdItemZzimCheck(varDeleteSvModel, "false");
					}
				}
			}

			fn_banner_info(typeStr);
		},
		error: function(request,status,error){
			//alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
      	}
	});
}

// 찜과 최근본에서 비교하기 시작
var reloadFlag = false;
var svCheck;
function svCheck(modelno,tp) {
    // modelno 와 plno는 겹치지 않기 때문에
    // modelno항목에는 plno가 들어올수있음
    if(svCheck.addModelNos) {
        //var varSameModelNo = svCheck.addModelNos.indexOf(modelno);
        var varSameModelNo = ArrayIndexOf(svCheck.addModelNos, modelno);

        if(varSameModelNo >= 0) {
            svCheck.addModelNos.splice(varSameModelNo,1);
            svCheck.addModelType.splice(varSameModelNo,1);
        } else {
            svCheck.addModelNos[svCheck.addModelNos.length] = modelno;
            svCheck.addModelType[svCheck.addModelType.length] = tp;
        }
    } else {
        svCheck.addModelNos = new Array();
        svCheck.addModelType = new Array();
        svCheck.addModelNos[0] = modelno;
        svCheck.addModelType[0] = tp;
    }
}

function goSvResentBigyo() {
    var varCompareModelNo = "";
    var varCompareModelCnt = 0;
    if(svCheck.addModelNos) {
        for(var i=0;i<svCheck.addModelNos.length;i++) {
            varCompareModelNo += svCheck.addModelType[i] + ":" + svCheck.addModelNos[i]+",";
            varCompareModelCnt++;
        }
    }
    if(varCompareModelCnt > 1) {
        varCompareModelNo = varCompareModelNo.substring(0,varCompareModelNo.length-1);
        varCompareModelNo = varCompareModelNo.split("G:").join("");
        var compareMultiWin = window.open("/view/Comparemulti.jsp?chkNo="+varCompareModelNo,"Comparemulti","width=700,height=600,left=0,top=0,toolbar=no,directories=no,status=yes,scrollbars=yes,resizable=yes,menubar=no");
        compareMultiWin.focus();
    } else {
        alert("2개 이상 선택하셔야 비교할 수 있습니다.")
    }
}

//슈퍼탑 트래킹
function infoadLogExe(logUrl) {
	document.getElementById("adFrame").src = logUrl;
}

function open_pc_alert(){
	insertLog(24286);
	OpenWindow_Inc('https://www.enuri.com/mobilefirst/messaging/index.html','584','720');
	return false;
}

function OpenWindow_Inc(url,intWidth,intHeight) {
	  window.open(url, "_blank", "width="+intWidth+",height="+intHeight+",resizable=1,scrollbars=1");
	  return false;
}

function ArrayIndexOf(arrayObj, arrayItem) {
	var rtnValue = -1;
	
	for(var i=0; i<arrayObj.length; i++) {
		if(arrayObj[i]==arrayItem) {
			rtnValue = i;

			break;
		}
	}
	
	return rtnValue;
}










