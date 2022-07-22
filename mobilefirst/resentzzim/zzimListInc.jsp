<!-- 찜 했을때 잠시 나왓다 사라지는 레이어 -->
<div id="zzimInfoShow" style="display:none;position:absolute;width:248px;height:53px;background-size:248px 53px;background-image:url(http://img.enuri.info/images/mobile2/resentzzim/layer_ok2.png);z-index:200;">
	<div class="xBtn" style="position:absolute;margin:5px 0px 0px 227px;width:12px;height:14px;"><img style="width:12px;height:14px;" src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobile2/resentzzim/x_btn.png"></div>
	<div class="zzimInfoTitle" style="margin:8px 0px 5px 0px;text-align:center;"><span class="zzimInfoText" style="font-size:13px;color:#00a2e8;font-weight:bold;font-family:'맑은 고딕';">이미 찜 되었습니다.</span></div>
	<div class="zzimGoBtn" style="text-align:center;height:15px;line-height:14px;"><span style="font-size:12px;font-family:'맑은 고딕','돋움';border-bottom:1px solid #000000;line-height:14px;">찜 목록으로</span></div>
</div>
<script src="/mobilefirst/js/resentzzimStorage.js"></script>
<script language="JavaScript">

var goodsNumbers = "";
// 찜 여부 확인
function zzimCheckSet() {
	
	//$(".prodChoice button").unbind();
	
	if(IsLogin()) {
		var url = "/mobilefirst/ajax/resentZzim/IsZzimFind_ajax.jsp";
		var param = "modelnos="+goodsNumbers;

		$.ajax({
			type : "post",
			url : url,
			data : param, 
			dataType : "json",
			success : function(ajaxResult) {
				rtnValue = ajaxResult["rtnValue"];

				var goodsNumbersAry = goodsNumbers.split(",");
				var rtnValueAry = rtnValue.split(",");
				
				for(var i=0; i<goodsNumbersAry.length; i++) {
										
					var zzimCheckFlag = false;
					var zzimGoodsObj = $("#btn_zzim_"+goodsNumbersAry[i].replace(":", ""));
					
					if(rtnValueAry[i]=="1") zzimCheckFlag = true;
					
					if(zzimCheckFlag) {
						zzimGoodsObj.addClass("on");
					} else {
						zzimGoodsObj.removeClass("on");
					}
					
					// 찜버튼을 클릭했을때 이벤트 등록
			
					zzimGoodsObj.click(function (e) {					
					
						if(document.URL.indexOf("list.jsp") >= 0){
							ga('send', 'event', 'mf_lp', 'lp', 'lp_zzim');
						}
					
						var thisId = this.id;
						var idNum = thisId.replace("btn_zzim_", "");
						var zzimedCheck = false;
					
						if($(this).hasClass("on")) {
							zzimInfoShow(2);
							return false;
						} else {
							var goodsType = "";
							var goodsNo = "";
							if(idNum.indexOf("G")>-1) {
								goodsType = "G";
								goodsNo = idNum.substring(1);
							}
							if(idNum.indexOf("P")>-1) {
								goodsType = "P";
								goodsNo = idNum.substring(1);
							}
							addResentZzimItem(2, goodsType, goodsNo);
					
							$(this).addClass("on");
							
							zzimInfoShow(1);
							
							// resentzzimListMini.jsp에 선언되어있는 개수 세팅하는 함수
							//setTimeout("resentZzimMiniCntSet()", 500);
						}
					});
				
					
					
				}
				
			}
		});
	} else {
		// 찜버튼을 클릭했을때 이벤트 등록
		var btn_zzimObj = $(".prodChoice button");
		btn_zzimObj.click(function (e) {
			if(confirm("찜 하시려면 로그인이 필요합니다.\n로그인 하시겠습니까?")) {
				//goLoginZzim(resentZzimModelno);
				goLogin();
				return false;
			}else{
				return false;
			}
		});
	}
}


function zzimCheckSetBest() {
	
	$(".prodChoice button").unbind();
	
	if(IsLogin()) {
		var url = "/mobilefirst/ajax/resentZzim/IsZzimFind_ajax.jsp";
		var param = "modelnos="+goodsNumbers;

		$.ajax({
			type : "post",
			url : url,
			data : param, 
			dataType : "json",
			success : function(ajaxResult) {
				rtnValue = ajaxResult["rtnValue"];

				var goodsNumbersAry = goodsNumbers.split(",");
				var rtnValueAry = rtnValue.split(",");
				
				for(var i=0; i<goodsNumbersAry.length; i++) {
										
					var zzimCheckFlag = false;
					var zzimGoodsObj = $("#btn_zzim_"+goodsNumbersAry[i].replace(":", ""));
					
					if(rtnValueAry[i]=="1") zzimCheckFlag = true;
					
					if(zzimCheckFlag) {
						zzimGoodsObj.addClass("on");
					} else {
						zzimGoodsObj.removeClass("on");
					}
					
					// 찜버튼을 클릭했을때 이벤트 등록
			
					zzimGoodsObj.click(function (e) {					
						
						var thisId = this.id;
						var idNum = thisId.replace("btn_zzim_", "");
						var zzimedCheck = false;
					
						if($(this).hasClass("on")) {
							zzimInfoShow(2);
							return false;
						} else {
							var goodsType = "";
							var goodsNo = "";
							if(idNum.indexOf("G")>-1) {
								goodsType = "G";
								goodsNo = idNum.substring(1);
							}
							if(idNum.indexOf("P")>-1) {
								goodsType = "P";
								goodsNo = idNum.substring(1);
							}
							addResentZzimItem(2, goodsType, goodsNo);
					
							$(this).addClass("on");
							
							zzimInfoShow(1);
							
							// resentzzimListMini.jsp에 선언되어있는 개수 세팅하는 함수
							//setTimeout("resentZzimMiniCntSet()", 500);
						}
					});
				
					
				}
				
			}
		});
	} else {
		// 찜버튼을 클릭했을때 이벤트 등록
		var btn_zzimObj = $(".prodChoice button");
		btn_zzimObj.click(function (e) {
			if(confirm("찜 하시려면 로그인이 필요합니다.\n로그인 하시겠습니까?")) {
				//goLoginZzim(resentZzimModelno);
				goLogin();
				return false;
			}else{
				return false;
			}
		});
	}
}

function setZzimImages() {
//	$("#btn_zzim").addClass("on");
}

function zzimInfoShowHide(hideType) {
	if(hideType==1) {
		$("#zzimInfoShow").css("display", "none");
	}
	if(hideType==2) {
		$("#zzimInfoShow").fadeOut("200");
	}
}

function zzimInfoShow(textType) {
	var zzimInfoTitleTxt = "";
	
	if(textType==1) zzimInfoTitleTxt = "찜 되었습니다.";
	if(textType==2) zzimInfoTitleTxt = "이미 찜 되었습니다.";
	
	if(textType==1) {
		//insertLog('11024');
	}
	
	alert(zzimInfoTitleTxt);
	
	//return false;
	/*
	$("#zzimInfoShow .zzimInfoTitle span").html(zzimInfoTitleTxt);
	

	var goodsListObj = $("#zzimInfoShow").parent();
	var zzimInfoShowObj = $("#zzimInfoShow");

	
	var topPos = 0;
	var leftPos = 0;

	topPos = $("body").scrollTop() + window.innerHeight/2 - 30;
	leftPos = $("body").width()/2 - zzimInfoShowObj.width()/2;

	zzimInfoShowObj.css("top", topPos+"px");
	zzimInfoShowObj.css("left", leftPos+"px");
	zzimInfoShowObj.fadeIn("200");

	setTimeout("zzimInfoShowHide(2)", 2000);
	*/
}

</script>
<!-- 찜 했을때 잠시 나왓다 사라지는 레이어 -->
