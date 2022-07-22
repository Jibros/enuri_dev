<!-- 찜 했을때 잠시 나왓다 사라지는 레이어 -->
<div id="zzimInfoShow" style="display:none;position:absolute;width:248px;height:53px;background-size:248px 53px;background-image:url(http://img.enuri.info/images/mobile2/resentzzim/layer_ok2.png);z-index:1000;">
	<div class="xBtn" style="position:absolute;margin:5px 0px 0px 227px;width:12px;height:14px;"><img style="width:12px;height:14px;" src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobile2/resentzzim/x_btn.png"></div>
	<div class="zzimInfoTitle" style="margin:8px 0px 5px 0px;text-align:center;"><span class="zzimInfoText" style="font-size:13px;color:#00a2e8;font-weight:bold;font-family:'맑은 고딕';">이미 찜 되었습니다.</span></div>
	<div class="zzimGoBtn" style="text-align:center;height:15px;line-height:14px;"><span style="font-size:12px;font-family:'맑은 고딕','돋움';border-bottom:1px solid #000000;line-height:14px;">찜 목록으로</span></div>
</div>
<script src="/mobilefirst/js/resentzzimStorage.js"></script>
<script language="JavaScript">

function setZzim() {		
	if(IsLogin()==true) {
		var btn_zzimObj = $("#btn_zzim");
		var modelno = resentZzimModelno;

		var zzimedCheck = false;
		if($("#btn_zzim").hasClass("on")) {
			zzimedCheck = true;
		}

		if(zzimedCheck) {
			zzimInfoShow(2);
		} else {
			addResentZzimItem(2, "G", modelno);
			btn_zzimObj.addClass("on");

			zzimInfoShow(1);
		}	
	} else {
		goLoginZzim(resentZzimModelno);
	}
}

function setZzimImg() {
	if(IsLogin()==true) {
		var zzimModels = resentZzimModelno;
		var url = "/mobilefirst/ajax/resentZzim/IsZzimFind_ajax.jsp";
		var param = "modelnos="+zzimModels;

		$.ajax({
			type : "post",
			url : url, 
			data : param, 
			dataType : "json",
			success : function(ajaxResult) {
				var ReturnZzim = ajaxResult["rtnValue"];
				var btn_zzimObj = $("#btn_zzim");

				if(ReturnZzim=="1,"){
					btn_zzimObj.addClass("on");
				} else {
					btn_zzimObj.removeClass("on");
				}

				// 찜버튼을 클릭했을때 이벤트 등록
				btn_zzimObj.unbind();
				btn_zzimObj.click(function (e) {
					var modelno = resentZzimModelno;
					var zzimedCheck = false;
					if($("#btn_zzim").hasClass("on")) {
						zzimedCheck = true;
					}

					if(zzimedCheck) {
						zzimInfoShow(2);
					} else {
						addResentZzimItem(2, "G", modelno);

						zzimInfoShow(1);

						// resentzzimListMini.jsp에 선언되어있는 개수 세팅하는 함수
						//setTimeout("resentZzimMiniCntSet()", 500);

						ga('send', 'event', 'button', 'click', '상품상세_찜');
					}
				});

			}
		}); 
	} else { // 비로그인시에도 찜버튼 노출
	
		// 찜버튼을 클릭했을때 이벤트 등록
		var btn_zzimObj = $("#btn_zzim");
		btn_zzimObj.unbind();
		btn_zzimObj.click(function (e) {
			if(confirm("찜 하시려면 로그인이 필요합니다.\n로그인 하시겠습니까?")) {

				goLoginZzim(resentZzimModelno);
				//document.location.href = "/mobile2/login/login.jsp?listType=1";
			}
		});
 
	}
}

function setZzimImages() { 
	$("#btn_zzim").addClass("on");
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
	
	if(textType==1){
		$(".zzimarea").addClass("on");
		//insertLog('11028');
	}
	if(textType==2){
		zzimedCheck = false;
		zzimDelete(resentZzimModelno);
	}
	
	return false;
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

//찜삭제
function zzimDelete(modelno){
    var url = "/view/deleteSaveGoodsProc.jsp";
    var param = "modelnos="+modelno+"&tbln=save";
    $.ajax({
        type : "post",
        url : url,
        data : param, 
        dataType : "html",
        success : function(ajaxResult) {
        	$(".zzimarea").removeClass("on");
        	$("#btn_zzim").removeClass("on");
        }
    }); 
}

setZzimImg();

// 최근본 추가
addResentZzimItem(1, "G", resentZzimModelno);

//setZzim();
</script>
