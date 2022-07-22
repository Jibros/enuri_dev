<%
	String strGTmpid    = cb.GetCookie("GATEP","TMP_ID");
	String strGkind     = cb.GetCookie("GATEP","GKIND");
	String strGno       = cb.GetCookie("GATEP","GNO");

	String strUserip = request.getRemoteAddr();

	//개발 서버 확인
    boolean bldevFlag = (request.getServerName().trim().indexOf("dev.enuri.com") > -1 );

	//서비스 점검 체크
    com.enuri.bean.lsv2016.Coupon_Layer_Proc coupon_proc = new com.enuri.bean.lsv2016.Coupon_Layer_Proc();
	org.json.JSONObject oSystemCheckAlert = coupon_proc.getSystemAlertList(bldevFlag);
%>
<div id="transferPop" class="layerPop transfer-popup" style="display:none;"></div>
<div id="openmarketPop" class="layerPop transfer-popup" style="display:none;">
	<div id="open_market_layer">
		<div class="layerPopInner" id="open_market_layer_inner">
			<div class="layerPopCont">
				<h1 id="layerPopCont_txt">PC 최저가 구매 알림</h1>
				<button class="btnClose">PC 최저가 구매 알림 창 닫기</button>
				<div class="contents">
					<p class="description" id="contents_description">해당 상품은 에누리 PC웹에서 ‘최저가’로 구매가능 합니다. ‘찜하기’ 후 PC웹으로 접속해 주세요.</p>
				</div>
				<div class="layerBtn">
					<button class="btnTxt" id="popup_btn_zzim" onclick="$('#noBuyClose').click();">찜하기</button>
					<button class="btnTxt" id="noBuyClose">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript" src="http://static.criteo.net/js/ld/ld.js" async="true"></script>
<script language="javascript">
var serviceChkAlert = <%=oSystemCheckAlert%>;
var today = new Date();
var month = (today.getMonth() + 1);
var date = today.getDate();

function cosemConvert( rn, amt, pc, pa, pp, pg, etc ){

	var cosemProtocol = ( location.protocol=="https:" )? "https:" :"http:";
	var image = new Image();
	var accountCode = "567";

	var imageURL = cosemProtocol + "//" + "tracking.icomas.co.kr";
		imageURL += "/Script/action3.php" + "?aid=" + accountCode + "&rn=" + encodeURI(rn) ;
		imageURL += "&amt=" + amt + "&pc=" + encodeURI(pc) + "&pa=" + pa + "&pp=" + pp + "&pg=" + encodeURI(pg) + "&etc=" + encodeURI(etc);

	image.src = imageURL;
}

Date.prototype.format = function(f) {
    if (!this.valueOf()) return " ";

    var weekName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
    var d = this;

    return f.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|a\/p)/gi, function($1) {
        switch ($1) {
            case "yyyy": return d.getFullYear();
            case "yy": return (d.getFullYear() % 1000).zf(2);
            case "MM": return (d.getMonth() + 1).zf(2);
            case "dd": return d.getDate().zf(2);
            case "E": return weekName[d.getDay()];
            case "HH": return d.getHours().zf(2);
            case "hh": return d.getHours().zf(2);
            case "mm": return d.getMinutes().zf(2);
            case "ss": return d.getSeconds().zf(2);
            case "a/p": return d.getHours() < 12 ? "오전" : "오후";
            default: return $1;
        }
    });
};

String.prototype.string = function(len){var s = '', i = 0; while (i++ < len) { s += this; } return s;};
String.prototype.zf = function(len){return "0".string(len - this.length) + this;};
Number.prototype.zf = function(len){return this.toString().zf(len);};

function insertLog(logNum){
    var url = "/view/Loginsert.jsp";
    var param = "kind="+logNum;

	$.ajax({
		type: "GET",
		url: url,
		data: param
	});

}

function insertLog_modelno(logNum, modelno){
    var url = "/view/Loginsert_2010.jsp";
    var param = "kind="+logNum+ "&modelno="+ modelno;

	$.ajax({
		type: "GET",
		url: url,
		data: param
	});

}

function goShop(url, shopcode, plno, goodscode, instanceprice, category, price, minprice,  obj, get_modelno, pricecard, coupon, deliveryinfo){
	//akmall
	//if(shopcode == 90 && month == 9 && date >= 20 ){
	//	alert("쇼핑몰 시스템 점검중입니다.");
	//	return false;
	//}
	if(shopcode == 7747){
		location.href = "/mobilefirst/rental.jsp?modelno="+get_modelno;
		return false;
	}
	//2020-02-12. shwoo. H몰(57) 예외조항 제거 후에도 수익코드 잡힘. 코어 예외처리 강제 변경으로 처리
	if(shopcode == 57){
		if(url.indexOf("s49") > -1){
			url = url.reaplce("s49","022");
		}
	}
	//2018-11-08. 위메프 URL 오류 처리. shwoo
	//if(shopcode == 6508 && url.indexOf("prodNo=0&") > -1 && goodscode.indexOf("_") > -1){
	//	var vGoodscode_cut = goodscode.substring(0,goodscode.indexOf("_"));
	//	url = url.replace("prodNo=0&","prodNo="+ vGoodscode_cut +"&");
	//}
	//쇼핑몰 시스템점검
	if(serviceChkAlert[shopcode] !== undefined){
        alert(serviceChkAlert[shopcode].contents);
        return false;
	}

	var d = new Date();

	var vMonth = d.getMonth()+1;
	var vDay = d.getDate();
	var vH = d.getHours();
	var vM = d.getMinutes();

	var modelno = 0;
	if(get_modelno){
		modelno = get_modelno;
		vModelno = modelno;
	}else{
		modelno = vModelno;
	}


	var cateBanner= localStorage.getItem("cateBanner");

	if(modelno == cateBanner){
		insertLog('11039');
		localStorage.setItem("cateBanner","");
	}

	if(modelno != "0"){
		$.ajax({
			type: "GET",
			url: "/mobilefirst/include/inc_gate.jsp",
			data: "modelno="+modelno
		});
	}
	//<%=strGTmpid %>
	//<%=strGno %>
	try{
<%
	if(!strGTmpid.equals("") && !strGno.equals("")){
		Date comasOrderId = new Date();
%>
	var vCatenm = "";

	$.ajax({
		type: "GET",
		url: "/mobilefirst/include/sendCatenm.jsp",
		async: false,
		data: "cate="+category,
		success: function(result){
			vCatenm = $.trim(result);
		}
	});

	setTimeout( function(){
		cosemConvert( "<%=comasOrderId%>", instanceprice, modelno, 1, instanceprice, vCatenm, "" );
	}, 10);
<%
	}
%>
	}catch(e){}


	//2015-05-18 zum 수익코드 추가
	var vZum = false;
	if(getCookie("FROM") == "zum"){
		vZum = true;

		//zum에서 왔고 11번가 일때만 개별로그 추가
		if(shopcode == "5910"){
			if(modelno != "0"){
				//모델상품
				insertLog('15772');
			}else{
				//일반상품
				insertLog('15774');
			}
		}
	}
	if(vZum){
		//alert("before="+url);
		url = code_to_zum(url, shopcode, plno, goodscode, instanceprice, category, price, minprice,  obj, get_modelno);
		//alert("after="+url);
	}
	//2015-11-11 dealbada 클릭아웃체크
	var vDealbada = false;
	if(getCookie("FROM") == "dealbada"){
		vDealbada = true;
	}
	var vStb = false;
	if(getCookie("FROM") == "stb"){
		vStb = true;
	}
	//2017-1-3 uplus 추가
	var vUplus = false;
	if(getCookie("FROM") == "uplus"){
		vUplus = true;
	}
	//2017-1-24 social 추가
	var vSocial = false;
	if(getCookie("FROM") == "social"){
		vSocial = true;
	}

	//2019-05-22 swt 수익코드 추가 (스마트택배:스마트쇼핑)
	var vSt = false;

	if(getCookie("FROM") == "swt"){
		vSt = true;

		if(get_modelno != ""){
			insertLog_modelno('19712', get_modelno);
		}else{
			insertLog('19712');
		}

		ga('send', 'event', 'mf_test', 'smartTB' ,  'stClick');

		if(getCookie("FROMST") == "main"){
			ga('send', 'event', 'mf_test', 'smartTB' ,  'main');
		}else if(getCookie("FROMST") == "cpp2"){
			ga('send', 'event', 'mf_test', 'smartTB' ,  'cpp2');
		}else if(getCookie("FROMST") == "cpp_m"){
			ga('send', 'event', 'mf_test', 'smartTB' ,  'cpp_m');
		}else if(getCookie("FROMST") == "planlist"){
			ga('send', 'event', 'mf_test', 'smartTB' ,  'planlist');
		}else{
			var link = document.referrer;

			ga('send', 'event', 'mf_test', 'smartTB' ,  link);

		}
	}

	var layerChk = false;
	var param = "pl_no="+plno;
	var check_w = jQuery(window).width();
	var check_h = jQuery(window).height();
	var layer_top = jQuery(window).scrollTop();

	if(price.indexOf("원")> -1){
		price = price.replace("원","").replace(/,/gi,"").trim();
	}

	if( (shopcode == 536 || shopcode == 4027 || shopcode == 55 ) && ( price == minprice) ){
	//	layerChk = true;
	}

	if( shopcode == 5910 ){
		//layerChk = true;
	}

	//2016-06-28 hitbrand click out
	var vHitbrand = false;

	if(getCookie("FROM") == "hitbrand"){
		vHitbrand = true;
	}
	if(vHitbrand){
		//alert("before="+url);
		hitbrand_clickout(get_modelno, getCookie("FROM_hitbrand"))
		//alert("after="+url);
	}

	try{
		if(layerChk){
			CmdSpinLoading();

			var rtn_price = 0;

			if(category.substring(0,4) == "0304"){
				//rtn_price = ctu_func(shopcode, goodscode, instanceprice, category);
				//alert(rtn_price);
				//11번가만 휴대폰일때 모바일가가 아닌 pc 가를 보여줌.
				instanceprice = price;
			}

			//if(rtn_price != null && rtn_price != ""){
			//	instanceprice = rtn_price;
			//}

			//if(instanceprice > price ){
				param = "pl_no="+plno+"&instanceprice="+instanceprice;

				var flag;

				if (typeof vListSort == 'undefined')
				  flag = false;
				else
				  flag = true;

				if(flag && vListSort == "tabyn_dminsort"){
					param += "&minsort=1";
				}

				$.ajax({
					type: "POST",
					url: "/mobilefirst/include/inc_ctu_info.jsp",
					data: param,
					success: function(result){
						$("#transferPop").html(null);
						$("#transferPop").html(result);
						$("#transferPop").show();

						var _this = $("#transferPop");
						layerPop2(_this);
						delivertyAlign = $($(this).attr('href')).find('.delivery').outerWidth()/2;
						$($(this).attr('href')).find('.delivery').css('margin-left','-'+delivertyAlign+'px');

						$("#cm_loading").hide();

						$('.layerPop .btnClose').click(function(){
							var _this = $(this);
							$('.dimmed').remove();
							$("#transferPop").hide();
							$('html, body').removeClass('dimdOn');
						});
					}
				});
			//}else{
			//	$("#cm_loading").hide();
			//	var newUrl = url;

			//	if( navigator.userAgent.indexOf("iPhone") > 0 || navigator.userAgent.indexOf("iPod") > 0 || navigator.userAgent.indexOf("iPad") > 0){
			//		newUrl = newUrl + "&DEVICE_BROWSER=Y";
			//	}

			//	var newWin = window.open(newUrl);

			//	insertMoveLog(category, plno, shopcode);
			//}
		}else if(shopcode == ""){
			var _this = $("#open_market_layer");
			layerPop3(_this,modelno);

			$('.layerPop .btnClose').click(function(){
				var _this = $(this);
				$('.dimmed').remove();
				$("#openmarketPop").hide();
				$('html, body').removeClass('dimdOn');
			});
		}else if(shopcode == "6378" || shopcode == "6368"){
			var _this = $("#openmarketPop");
			layerPop3(_this,modelno);
			fn_changeTxt(1);

			$('.btnClose').click(function(){
				var _this = $(this);
				$('.dimmed').remove();
				$("#openmarketPop").hide();
				$('html, body').removeClass('dimdOn');
			});
		}else{
			var newUrl = url;

			if( navigator.userAgent.indexOf("iPhone") > 0 || navigator.userAgent.indexOf("iPod") > 0 ||  navigator.userAgent.indexOf("iPad") > 0){
				if(newUrl.indexOf("?") > -1){
					if(newUrl.indexOf("#") > -1){
						newUrl = newUrl.replace("?", "?DEVICE_BROWSER=Y&");	//G9예외
					}else{
						newUrl = newUrl + "&DEVICE_BROWSER=Y";
					}
				}else{
					newUrl = newUrl + "?DEVICE_BROWSER=Y";
				}
			}

			var vAppyn = getCookie("appYN");
			var vVerios = getCookie("verios") + "";

			if(vVerios != null && vVerios != ""){
				vVerios = parseInt(vVerios.replace(/\./g,""));
			}else{
				vVerios = 0;
			}

			//console.log("vVerios=", vVerios);


			if(1==1 || vAppyn == "Y"){
				var d = new Date();
				var curr_hour = d.getHours();
				var curr_min = d.getMinutes();

				var curr_sec = d.getSeconds();
				var curr_msec = d.getMilliseconds();

				if(",8446,8447,8448,8826,8827,8828,8829,".indexOf(","+shopcode+",") > -1){
					var strOvsShopcode = "";
			    	if(shopcode == 8446)	strOvsShopcode = "1739";
			    	if(shopcode == 8447)	strOvsShopcode = "440";
			    	if(shopcode == 8448)	strOvsShopcode = "1270";
			    	if(shopcode == 8826)	strOvsShopcode = "9011";
			    	if(shopcode == 8827)	strOvsShopcode = "782";
			    	if(shopcode == 8828)	strOvsShopcode = "469";
			    	if(shopcode == 8829)	strOvsShopcode = "7714";

			    	//newUrl = "/global/m/portal.jsp?muid="+strOvsShopcode+"&url="+url +"&from=en&freetoken=outbrowser";

			    	if(newUrl.indexOf("/global/m/portal.jsp?") > -1){
						var newWin = window.open(newUrl);
		    		}else{
		    			newUrl = "/global/m/portal.jsp?muid="+strOvsShopcode+"&url="+url +"&from=en&freetoken=outbrowser";
						var newWin =  window.open(newUrl);
		    		}
				}else{
					if(newUrl.indexOf("/mobilefirst/move.jsp?") > -1){
						var newWin = window.open(newUrl);
					}else{
						if(vZum){		// zum에서 넘어 왔을 경우 팝업창 제한에 걸려 location.replace로 변경 함.
							location.replace("/mobilefirst/move.jsp?freetoken=outlink&from=zum&vcode="+shopcode+"&plno="+ plno +"&url="+encodeURIComponent(newUrl)+"&ch="+curr_hour+curr_min+curr_sec+curr_msec);
						} else {
							var newWin = window.open("/mobilefirst/move.jsp?freetoken=outlink&vcode="+shopcode+"&plno="+ plno +"&url="+encodeURIComponent(newUrl)+"&ch="+curr_hour+curr_min+curr_sec+curr_msec);
						}
					}
				}
			}else{
				if(vZum){
					location.replace(newUrl+"&from=zum");
				}else{
					var newWin = window.open(newUrl);
				}
			}

			//ctu api
			$.ajax({
				type: "GET",
				url: "/mobilefirst/include/inc_ctu_send.jsp",
				data: "plno="+plno,
				dataType: "JSON",
				success: function(json){
					var ctuShopcode = json.shopcode;
					var ctuUrl = json.url;
					var ctuMinprice = json.minprice;
					var ctuPricecard = json.pricecard;
					var ctuCoupon = json.coupon;
					var ctuCategory = json.category;
					var ctuModelno = json.modelno;
					var ctuDeliveryinfo = json.deliveryinfo;
					var ctuGoodscode = json.goodscode;
					var ctuInstanceprice = json.instanceprice;
					var openShopCheck = json.openShopCheck;
					var ctuShoptype = json.shoptype;
			
					//크리테오 -  전분류 적용 2015-05-29
					//크리테오 - 2022.01.05 instanceprice pl_no 기준으로 변경 
					var blCriteo_ctu = false;

					if("0201,0232,0234,0305,0503,0601,0602,0703,0508,0502,0550,0707,0235,0603".indexOf(ctuCategory.substring(0,4)) > -1){
						if(isiPhone() && vAppyn == "Y" && vVerios < 223){
						}else{
							blCriteo_ctu = true;
						}
					}

					if(blCriteo_ctu){
						var vDevicepart = "m";

						if(navigator.userAgent.indexOf("Android") > 0){
							if(navigator.userAgent.indexOf("Android 3") > 0 ){
								vDevicepart = "t";
							}else{
								vDevicepart = "m";
							}
						}else if(navigator.userAgent.indexOf("iPhone") > 0 || navigator.userAgent.indexOf("iPod")  > 0){
							vDevicepart = "m";
						}else if(navigator.userAgent.indexOf("iPad")  > 0){
							vDevicepart = "t";
						}
						window.criteo_q = window.criteo_q || [];

						window.criteo_q.push(
								{ event: "setAccount", account: 20451 },
								{ event: "setSiteType", type: vDevicepart },
								{ event: "trackTransaction" , id: d.getTime(), item:
									[
										{ id: ctuModelno, price: ctuInstanceprice ,quantity: 1}
									]
								}
						);
					}

					//와이드플래닛
					var blWide_ctu = false;

					if("0201,0203,0220,0232,0233,0236,0237,0241,0305,0359,0362,0363,0401,0404,0405,0408,0414,0418,0420,0502,0503,0507,0508,0510,0511,0513,0515,0521,0526,0527,0601,0602,0603,0605,0609,0611,0621,0702,0708,0713,0715,0809,0904,0905,0906,0908,0918,0930,1004,1005,1007,1012,1013,1020,1201,1202,1203,1204,1205,1207,1219,1230,1242,1501,1502,1503,1506,1511,1513,1602,1614,1620,1625,1636,1643,1647,1803,1808,2115,2131,2406,2407,2144".indexOf(ctuCategory.substring(0,4)) > -1){
						if(isiPhone()){
						}else{
							blWide_ctu = true;
						}
					}

					if(blWide_ctu){
						var vSrc = "/mobilefirst/include/inc_widerplanet.jsp?modelno="+ctuModelno+"&plno="+plno+"&instanceprice="+ctuInstanceprice;

						$('#hFrame').attr('src', vSrc);
					}
					/*
					 * 2016-01-05 ctu V2 오픈
					try{
						//2015-02-09 ctu 모바일 오픈.
						//ctu_func(ctuShopcode, ctuGoodscode, ctuInstanceprice, ctuCategory);
						new_ctu_func(ctuShopcode, ctuGoodscode, plno);
					}catch(e){}

					try{
						//2015-07-28 pc ctu도 실행
						//ctu_func_pc(ctuShopcode, ctuUrl, ctuMinprice, ctuPricecard, plno, ctuCoupon, ctuCategory, ctuModelno, ctuDeliveryinfo, ctuGoodscode);
						new_ctu_func_pc(ctuShopcode, ctuGoodscode, plno);
					}catch(e){}

					*/
					try{
						//2016-01-05 CTU V2 적용
						ctu_v2(ctuShopcode, ctuGoodscode, plno, openShopCheck,ctuShoptype);
					}catch(e){
						//alert(e);
					}

				}
			});

			insertMoveLog(category, plno, shopcode);

			//상위입찰업체클릭아웃로그
			if(shopcode == 536){
				insertLog_cate(12630,category);
			}

			var vHref = location.href;

			if(vZum){
				if(vHref.indexOf("detail.jsp") > -1 || vHref.indexOf("vip.jsp") > -1){
					ga('send', 'event', 'mf_buy', 'click_zum_비교' ,  'buy_'+shopcode);
				}else{
					ga('send', 'event', 'mf_buy', 'click_zum_일반' ,  'buy_'+shopcode);
				}
			}else if(vDealbada){
				if(vHref.indexOf("detail.jsp") > -1 || vHref.indexOf("vip.jsp") > -1){
					ga('send', 'event', 'mf_buy', 'click_dealbada_비교' ,  'buy_'+shopcode);
				}else{
					ga('send', 'event', 'mf_buy', 'click_dealbada_일반' ,  'buy_'+shopcode);
				}
			}else if(vStb){
				if(vHref.indexOf("detail.jsp") > -1 || vHref.indexOf("vip.jsp") > -1){
					ga('send', 'event', 'mf_buy', 'click_스마트택배_비교' ,  'buy_'+shopcode);
				}else{
					ga('send', 'event', 'mf_buy', 'click_스마트택배_일반' ,  'buy_'+shopcode);
				}
			}else if(vUplus){
				if(vHref.indexOf("detail.jsp") > -1 || vHref.indexOf("vip.jsp") > -1){
					ga('send', 'event', 'mf_buy', 'click_uplus_비교' ,  'buy_'+shopcode);
				}else{
					ga('send', 'event', 'mf_buy', 'click_uplus_일반' ,  'buy_'+shopcode);
				}
				//uplus일때 트래킹 코드 추가 (bigdata) clickout
				//fn_Enuri_PV('co', 'CO_VIP', shopcode, plno, modelno);
			}else if(vSocial){
				if(vHref.indexOf("detail.jsp") > -1 || vHref.indexOf("vip.jsp") > -1){
					ga('send', 'event', 'mf_buy', 'click_Social핫딜_비교' ,  'buy_'+shopcode);
				}else{
					ga('send', 'event', 'mf_buy', 'click_Social핫딜_일반' ,  'buy_'+shopcode);
				}
				//uplus일때 트래킹 코드 추가 (bigdata) clickout
				//fn_Enuri_PV('co', 'CO_VIP', shopcode, plno, modelno);

			}else{
				//app(aos,ios), web 구분
				var vTmp_Appyn = getCookie("appYN");

				if(vTmp_Appyn == "Y"){
					var ua = navigator.userAgent.toLowerCase();
					var isAndroid = ua.indexOf("android") > -1;

					if(isAndroid) {
						ga('send', 'event', 'mf_buy', 'click_AOS앱' ,  'buy_'+shopcode);
					}else{
						ga('send', 'event', 'mf_buy', 'click_IOS앱' ,  'buy_'+shopcode);
					}
				}else{
					ga('send', 'event', 'mf_buy', 'click_웹' ,  'buy_'+shopcode);
				}

				//InfoAD는 중복 체크
				try{
					if(vInfoad){
						ga('send', 'event', ' mf_buy_Info_Ad', 'click_'+modelno ,  'click_'+modelno);
					}
				}catch(e){}
			}
		}
	}catch(e){
		$("#cm_loading").hide();
	}
}

function isiPhone(){
    return (
        //Detect iPhone
        (navigator.platform.indexOf("iPhone") != -1) ||
        //Detect iPod
        (navigator.platform.indexOf("iPod") != -1) ||
        //Detect iPod
        (navigator.platform.indexOf("iPad") != -1)
    );
}

function fn_changeTxt(param){
	if(param == "1"){
		$("#layerPopCont_txt").text("PC 구매 알림");
		$("#contents_description").text("해당 쇼핑몰 상품은 에누리 PC웹에서만 구매 가능합니다. ‘찜하기’ 후 PC웹으로 접속해 주세요.");
	}else{
		$("#layerPopCont_txt").text("PC 최저가 구매 알림");
		$("#contents_description").text("해당 상품은 에누리 PC웹에서 ‘최저가’로 구매가능 합니다. ‘찜하기’ 후 PC웹으로 접속해 주세요.");
	}

}

function goShop_ctu(varResult, param_plno, param_url, param_gubun, param_cate, param_modelno, vcode){
	//akmall
	//if(vcode == 90 && month == 9 && date >= 20 ){
	//	alert("쇼핑몰 시스템 점검중입니다.");
	//	return false;
	//}
	var modelno = 0;
	try {
		modelno = param_modelno;
	} catch(e) {}

	var cateBanner = localStorage.getItem("cateBanner");

	if(modelno == cateBanner){
		insertLog('11039');
		localStorage.setItem("cateBanner","");
	}

	if(modelno != "0"){
		$.ajax({
			type: "GET",
			url: "/mobilenew/include/inc_gate.jsp",
			data: "modelno="+modelno
		});
	}

	var redirectUrl = "";
	var varApp = $("#app2").val();
	var redirect_time = 200;

	var newUrl = param_url;

	if( navigator.userAgent.indexOf("iPhone") > 0 || navigator.userAgent.indexOf("iPod") > 0 ||  navigator.userAgent.indexOf("iPad") > 0){
		if(newUrl.indexOf("?") > -1){
			newUrl = newUrl + "&DEVICE_BROWSER=Y";
		}else{
			newUrl = newUrl + "&DEVICE_BROWSER=Y";
		}
	}

	try{
		window.android.android_window_open(newUrl);
	}catch(e){
		redirectUrl= window.open(newUrl);
		redirectUrl.focus;
	}

	var rank = "";

 	//if(modelno != "0" && !isNaN(modelno)){

 		var logParam = "cate="+param_cate+"&modelno="+param_modelno+"&rank="+rank+"&pl_no="+param_plno+"&vcode="+vcode;

		setTimeout(function(){
			$.ajax({
				type: "POST",
				url: "/mobilefirst/include/m4_move_log.jsp",
				data: logParam,
				success: function(result){
				}
			});
		}, 200);
 	//}
}

function insertMoveLog(cate, plno, vcode) {
	//쇼핑몰 이동통계
	var modelno = 0;
	try {
		modelno = vModelno;
	} catch(e) {}

	//alert("modelno="+modelno);
	//alert("cate="+cate);
	//alert("plno="+plno);
	//alert("vcode="+vcode);

	//if(modelno != "0" && !isNaN(modelno)){

	 	var logParam = "cate="+cate+"&modelno="+modelno+"&rank=&pl_no="+plno+"&vcode="+vcode;

		setTimeout(function(){
			$.ajax({
				type: "POST",
				url: "/mobilefirst/include/m4_move_log.jsp",
				data: logParam,
				success: function(result){
				}
			});
		}, 200);
	//}
}

function ctu_func(vcode, goodscode, mobile_price, cate){
	/*3월10일 오후 수정 -- 이주현*/
	//if(vcode == 6665 || vcode == 536 || vcode == 4027  || vcode == 663 || vcode == 57 || vcode == 75 || vcode == 806 || vcode == 1878 ||  vcode == 55 || vcode == 5910 || vcode == 49 || vcode == 47 || vcode == 90 ){

	//if(vcode == 536 || vcode == 4027  || vcode == 663 || vcode == 57 || vcode == 75 || vcode == 806 || vcode == 1878 || vcode == 5910 || vcode == 55 || vcode == 49 || vcode == 47 || vcode == 90 ){
	//H몰(57), GS샵(75), G마켓(536), 옥션(4027), 롯데i몰(663), CJ몰(806), 디앤샵(1878), 11번가(5910), 인터파크(55), 롯데닷컴(49), 신세계(47), ak(90)
		//mobile_price = mobile_price.replace(/,/gi,"");
		$.ajax({
			type: "POST",
			url: "/move/price_check_mobile.jsp",
			data: "shop_code="+vcode+"&goodscode="+goodscode+"&mobile_price="+mobile_price+"&ca_code="+cate,
			success: function(result){
				if(result > 0 && mobile_price != result){
					result = result.replace(/(\d)(?=(?:\d{3})+(?!\d))/g,'$1,');

					if(vcode != 5910 ){
						//$(".price5").html(result.trim());
						//rtn_price = result.replace(/,/gi,"").trim();
					}
				}
			}
		});
	//}
}

function ctu_func_pc(szVcode, szRedirect, mPrice, PriceCard, iPlno, szCoupon,ca_code, modelno, deliveryinfo, goodscode){
    $.ajax({
		type: "POST",
		url: "/move/price_check.jsp",
		data: "szVcode="+ szVcode +"&szRedirect="+ encodeURIComponent(szRedirect) +"&mPrice="+ mPrice +"&PriceCard="+ PriceCard +"&iPlno="+ iPlno +"&szCoupon="+ szCoupon +"&cate="+ ca_code +"&modelno="+ modelno +"&deliveryinfo="+ encodeURI(deliveryinfo) +"&goodscode="+ goodscode,
		success: function(result){
		}
	});
}

function new_ctu_func(vcode, goodscode,pl_no){
	$.ajax({
		type: "POST",
		url: "/move/ctuSyncAction.jsp",
		data: "ctuActionType=1&shop_code="+vcode+"&goods_code="+goodscode+"&pl_no="+pl_no,
		success: function(result){
		}
	});
}

function new_ctu_func_pc(vcode,goodscode,pl_no){
    $.ajax({
		type: "POST",
		url: "/move/ctuSyncAction.jsp",
		data: "ctuActionType=2&shop_code="+vcode+"&goods_code="+goodscode+"&pl_no="+pl_no,
		success: function(result){
		}
	});
}

function ctu_v2(vcode, goodscode, pl_no, openShopCheck_val, ctuShop_type){
	var vIp = "<%=strUserip %>";

	var vData_M = {ctu_test: "N", system_type : "4" , device : "2", service: "1", shop_code: vcode, goods_code: goodscode, pl_no: pl_no, user_ip: vIp, openShopCheck : openShopCheck_val, shop_type : ctuShop_type};
	var vData_P = {ctu_test: "N", system_type : "4" , device : "1", service: "1", shop_code: vcode, goods_code: goodscode, pl_no: pl_no, user_ip: vIp, openShopCheck : openShopCheck_val, shop_type : ctuShop_type};

	$.ajax({
		type: "POST",
		url: "/move/ctuV2.jsp",
		data: vData_M,
		success: function(result){
			//result = jQuery.parseJSON(result);
			//alert("mobile="+result.resultMsg);
		}
	});

	$.ajax({
		type: "POST",
		url: "/move/ctuV2.jsp",
		data: vData_P,
		success: function(result){
			//result = jQuery.parseJSON(result);
			//alert("pc="+result.resultMsg);
		}
	});
}

function layer_close(){
	$("#transferPop").hide();
}

function layerPop2(_this){
	$('#transferPop').show();
	var layerPopHeight = $('#ctu_inner_layer').height();
	$('#ctu_inner_layer').css('margin-top','-'+ layerPopHeight / 2 + 'px' )
	$('body').append('<div class="dimmed"></div>');
	$('html, body').addClass('dimdOn');

	$('#noBuyClose').click(function(){
		var _this = $(this);
		$('.dimmed').remove();
		$('html, body').removeClass('dimdOn');
		_this.parent().parent().parent().parent().hide();
	});
}

function layerPop3(_this,modelno){
	$("#openmarketPop").html($('#open_market_layer').html());
	$("#openmarketPop").show();
	var layerPopHeight = $('#open_market_layer_inner').height();

	$('#open_market_layer_inner').css('margin-top','-'+ layerPopHeight / 2 + 'px' )
	$('body').append('<div class="dimmed"></div>');
	$('html, body').addClass('dimdOn');

	$("#popup_btn_zzim").unbind("click");
	$("#popup_btn_zzim").click(function(){

		var nowUrl = $(location).attr('href');

		if(nowUrl.indexOf("detail.jsp")>-1 || nowUrl.indexOf("vip.jsp")>-1){
			$('#btn_zzim').click();
		}else{
			$('#btn_zzim_G'+modelno).click();
		}

		$('#noBuyClose').click();
	});
	$('#noBuyClose').click(function(){
		$('.dimmed').remove();
		$('html, body').removeClass('dimdOn');
		$("#openmarketPop").hide();
	});
}

function zzim_set(modelno){
	var nowUrl = $(location).attr('href');

	if(nowUrl.indexOf("detail.jsp")>-1 || nowUrl.indexOf("vip.jsp")>-1){
		$('#btn_zzim').click();
	}else{
		$('#btn_zzim_G'+modelno).click();
	}
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

function code_to_zum(url, shopcode, plno, goodscode, instanceprice, category, price, minprice,  obj, get_modelno){
	var szRedirect = url;
	// 쇼핑몰 수익코드 변경
	// G마켓	536
	if(shopcode == "536"){
		 szRedirect = szRedirect.replace("&jaehuid=200002673", "&jaehuid=200006443");	//pc url 경우
		 szRedirect = szRedirect.replace("&jaehuid=200006254", "&jaehuid=200006443"); //모바일 url 경우
	}
	// 옥션	4027
	if(shopcode == "4027"){
		szRedirect = szRedirect.replace("&pc=589", "&pc=968");
		szRedirect = szRedirect.replace("&pc=805", "&pc=968");
	}
	// 11번가	5910
	// 11번가 예외처리 제외 2017-05-22 shwoo
	//if(shopcode == "5910") szRedirect = szRedirect.replace("&tid=1000993624", "&tid=1001007652");
	// 인터파크	55
	if(shopcode == "55"){
		var vGoodsno =  szRedirect.substring(szRedirect.indexOf("goods_no=")+9, szRedirect.indexOf("&biz_cd="));
		szRedirect = "http://m.interpark.com/mobileGW.html?svc=Shop&bizCode=P14328&url=http://m.shop.interpark.com/product/"+ vGoodsno +"/0000100000";
	}
	// 현대Hmall	57
	if(shopcode == "57"){
		 szRedirect = szRedirect.replace("ReferCode=022", "ReferCode=a88");
		 szRedirect = szRedirect.replace("ReferCode=s49", "ReferCode=a88");
	}
	// GS SHOP	75
	if(shopcode == "75") szRedirect = szRedirect.replace("media=Pg&", "media=LK&");
	// 롯데i몰	663
	if(shopcode == "663") szRedirect = szRedirect.replace("chl_no=140764&chl_dtl_no=2540376", "chl_no=148172&chl_dtl_no=2546380");
	// 신세계몰	47
	if(shopcode == "47") szRedirect = szRedirect.replace("&ckwhere=s_enuri", "&ckwhere=enuri_zum_sm");
	// SSG닷컴	6665
	if(shopcode == "6665") szRedirect = szRedirect.replace("&ckwhere=ssg_enuri", "&ckwhere=enuri_zum_ssgm");
	// 엘롯데	6547
	if(shopcode == "6547"){
		szRedirect = szRedirect.replace("chl_no=153329&chl_dtl_no=2942662", "chl_no=166826&chl_dtl_no=3049694");

		//2018-11-01 변경됨
		szRedirect = szRedirect.replace("chnlNo=100023","chnlNo=100035");
		szRedirect = szRedirect.replace("chnlDtlNo=1000023","chnlDtlNo=1000035");

		//롯데ON 통합. 2020-04-27 shwoo
		szRedirect = szRedirect.replace("ch_no=100078&ch_dtl_no=1000236","ch_no=100251&ch_dtl_no=1000702");
	}
	// 위메프	6508	△(5월중) -- 150706수정
	if(shopcode == "6508"){
		var x = szRedirect;
		var pos = x.lastIndexOf('/enuri');
		var pos_ex = x.lastIndexOf('/enuri/');

		if(pos != pos_ex){	//제일 뒷쪽 /enuri가 없을때 앞쪽 /enuri/ 가 zum으로 바뀜 방지.
			x = x.substring(0,pos);
			szRedirect = x  + "/zum";
		}else{
			szRedirect += "/zum";	//뒤에 /enuri가 안넘어올때 강제로 붙혀줌.
		}
		//2018-03-09 새로운 URL 추가
		szRedirect = szRedirect.replace("affiliateExtraNo=enuri", "affiliateExtraNo=zum");
	}

	// 롯데닷컴	49
	if(shopcode == "49"){
		//기존 로직 삭제 2020-07-20
		//var vGoodsno =  szRedirect.substring(szRedirect.indexOf("goods_no=")+9, szRedirect.length+1);
		//szRedirect = "http://www.lotte.com/coop/affilGate.lotte?chl_no=166824&chl_dtl_no=3049696&returnUrl=%2Fgoods%2FviewGoodsDetail.lotte%3Fgoods_no%3D"+ vGoodsno;

		//롯데ON 통합. 2020-04-27 shwoo
		szRedirect = szRedirect.replace("ch_no=100077&ch_dtl_no=1000235", "ch_no=100304&ch_dtl_no=1000811");
	}
	// nsmall	974
	if(shopcode == "974") szRedirect = szRedirect.replace("co_cd=190", "co_cd=191");
	// 홈플러스	6361
	// pc: PartnerID=ENURI_56010, pc: PartnerID=ENURI_56030
	// service_cd%3D56030, service_cd%3D56150
	//
	if(shopcode == "6361") {
		szRedirect = szRedirect.replace("extends_id=enuri&service_cd=56010", "extends_id=enuri&service_cd=56030");
		szRedirect = szRedirect.replace("PartnerID=ENURI_56010", "PartnerID=ENURI_56030");
		szRedirect = szRedirect.replace("3D56010", "3D56030");
	}
	// CJmall	806
	if(shopcode == "806"){
		if(szRedirect.indexOf("app_cd=") > -1){
			szRedirect = szRedirect.replace("app_cd=ENURI&", "app_cd=ENURIZUM&");
		}else if(szRedirect.indexOf("infl_cd=I0647") > -1){		//형식 추가 2017-05-30 shwoo 1.pc수익코드일경우
			szRedirect = szRedirect.replace("infl_cd=I0647", "infl_cd=I0958");
		}else if(szRedirect.indexOf("infl_cd=I0580") > -1){		//형식 추가 2017-05-30 shwoo 2.모바일수익코드일경우
			szRedirect = szRedirect.replace("infl_cd=I0580", "infl_cd=I0958");
		}
	}

	// 티몬	6641
	if(shopcode == "6641") {
		szRedirect = szRedirect.replace("jp=80024", "jp=80030");
		szRedirect = szRedirect.replace("ln=205013", "ln=248945");
	}
	// AKmall	90
	if(shopcode == "90") szRedirect = szRedirect.replace("assc_comp_id=12189", "assc_comp_id=101267");
	// 이마트몰	374
	if(shopcode == "374") szRedirect = szRedirect.replace("&ckwhere=enuri&pid=enuri&sid=en001", "&ckwhere=enuri_zum_m");
	// 홈&쇼핑	6588
	if(shopcode == "6588"){
		var vGoodsno =  szRedirect.substring(szRedirect.indexOf("goods_code=")+11, szRedirect.length+1);
		szRedirect = "http://m.hnsmall.com/channel/gate?channel_code=20381&goods_code="+ vGoodsno;
	}
	// 갤러리아몰	6620
	if(shopcode == "6620"){
		if(szRedirect.indexOf("channel_id=2764") > -1){
			szRedirect = szRedirect.replace("channel_id=2764", "channel_id=2993");
		}else if(szRedirect.indexOf("channel_id=2763") > -1){
			szRedirect = szRedirect.replace("channel_id=2763", "channel_id=2993");
		}else if(szRedirect.indexOf("chnl_no=2763") > -1){
			szRedirect = szRedirect.replace("chnl_no=2763", "chnl_no=2993");
		}else if(szRedirect.indexOf("chnl_no=2764") > -1){
			szRedirect = szRedirect.replace("chnl_no=2764", "chnl_no=2993");
		}
	}
	// 디앤샵	1878
	if(shopcode == "1878") szRedirect = szRedirect.replace("chnl_no=CH15020046", "chnl_no=CH15040287");
	// 롯데마트	7455
	if(shopcode == "7455"){
		szRedirect = szRedirect.replace("&AFFILIATE_ID=01030001&CHANNEL_CD=00056", "&AFFILIATE_ID=01030002&CHANNEL_CD=00059");

		//롯데ON 통합. 2020-04-27 shwoo
		szRedirect = szRedirect.replace("ch_no=100220&ch_dtl_no=1000660", "ch_no=100306&ch_dtl_no=1000814");
	}
	// 아이마켓	7396
	if(shopcode == "7396") szRedirect = szRedirect.replace("BIZ_CD=1010179", "BIZ_CD=1010190");
	// CJ오클락	6688
	if(shopcode == "6688") szRedirect = "http://www.oclock.co.kr/joinmall/gate.jsp?gate_code=3110&wacode=000200111223&" + szRedirect.substring(szRedirect.indexOf("&url="));
	// 토이저러스	7695
	if(shopcode == "7695") szRedirect = szRedirect.replace("AFFILIATE_ID=01030003&CHANNEL_CD=00058", "AFFILIATE_ID=01030004&CHANNEL_CD=00061");
	// 알라딘	4861
	if(shopcode == "4861") szRedirect = szRedirect.replace("&partner=enuri2007", "&partner=zum");
	// 도서11번가	6378
	// tid=1000993966 -> tid=1001007559
	//if(shopcode == "6378") szRedirect = szRedirect.replace("tid=1000993966", "tid=1001007559");
	// 교보문고	6367
	if(shopcode == "6367") {
		var vGoodsno =  szRedirect.substring(szRedirect.indexOf("barcode%3D")+10, szRedirect.length+1);
		szRedirect = "http://click.linkprice.com/click.php?m=mkbbook&a=A100035949&l=9999&l_cd1=3&l_cd2=0&tu=http%3A%2F%2Fm.kyobobook.com%2Fshowcase%2Fbook%2FKOR%2F" + vGoodsno + "?partnerCode=LPM&u_id=zumKB02";
	}
	// 영풍문고	6368
	//if(shopcode == "6368") {
	//	szRedirect = szRedirect + "&u_id=zumYP01";
	//}
	// 보리보리	6603
	if(shopcode == "6603") szRedirect = szRedirect.replace("enuri", "enuri_zum");
	// 패션플러스	6389
	if(shopcode == "6389") szRedirect = szRedirect.replace("enuri", "enuri_zum");
	// 하프클럽	6644
	if(shopcode == "6644") szRedirect = "http://www.halfclub.com/Partner/zumdb?http://www.halfclub.com/" + szRedirect.replace("http://www.halfclub.com/joins/enuri.asp?/", "");
	// LF MALL	6634
	if(shopcode == "6634") szRedirect = szRedirect.replace("&af=EN01", "&af=EN02");
	//위즈위드  7910 2016-12-29 shwoo
	if(shopcode == "7910"){
		szRedirect = szRedirect.replace("&adfrom=enuri_goods_pc", "&adfrom=enuri_zum_mo");
	}
	//이랜드몰 7908
	if(shopcode == "7908"){
		szRedirect = szRedirect.replace("chnl_no=ENW", "chnl_no=ENZ");
		szRedirect = szRedirect.replace("chnl_no=ENM", "chnl_no=ENZ");
	}
	//쿠팡 7861 추가. 2019-03-07. shwoo
	if(shopcode == "7861"){
		szRedirect = szRedirect.replace("src=1032001", "src=1033095");
		szRedirect = szRedirect.replace("src=1033035", "src=1033095");

    	//2019-10-07 쿠팡 URL 뒤 줌 예외처리
    	szRedirect += "&publisher=Enuri_Zum";
	}
	//skstoa #37753
	if(shopcode == "9011"){
		szRedirect = szRedirect.replace("mediaCode=EP15", "mediaCode=EP19");
	}
	//쇼핑엔티 #42322
	if(shopcode == "20883"){
		szRedirect = szRedirect.replace("mediaCode=MC29", "mediaCode=MC32");
	}
	return szRedirect;
}
function goDealShop(url, shopcode, goods_seq ){
	//에누리딜용 품절처리 및 Move(브릿지)페이지 이동
	var vNowtime = new Date().format("yyyyMMddhhmm");
	vNowtime = vNowtime * 1;
	//var minCheck = 201512190800;
	//var maxCheck = 201512210930;
	//if(shopcode == "6508"  && (vNowtime >= minCheck) && (vNowtime <= maxCheck)){
	//	alert("쇼핑몰 시스템 점검 중입니다.\n12/19일(토) ~ 12/21일(월)");
	//	return false;
	//}
	var d = new Date();
	var vMonth = d.getMonth()+1;
	var vDay = d.getDate();
	var vH = d.getHours();
	var vM = d.getMinutes();
	var newUrl = "";
	//url get
	$.ajax({
		type: "POST",
		url: "/mobilefirst/ajax/getEalurl.jsp",
		data: "seq="+goods_seq,
		dataType:"JSON",
		async: false,
		success: function(json){

			if(json.resultMsg == "SUCCESS"){
				if(json.soldout == "Y"){
					alert("품절 되었습니다.");
					location.reload();
					return false;
				}else{
					newUrl = json.resultUrl;
				}
			}else if(typeof json.msg != "undefined" && json.msg != "") {
				alert(json.msg);
				return false;
			}
		}
	});

	if(newUrl != ""){
		if( navigator.userAgent.indexOf("iPhone") > 0 || navigator.userAgent.indexOf("iPod") > 0 ||  navigator.userAgent.indexOf("iPad") > 0){
			if(newUrl.indexOf("?") > -1){
				if(newUrl.indexOf("#") > -1)	newUrl = newUrl.replace("?", "?DEVICE_BROWSER=Y&");	//G9예외
				else					newUrl = newUrl + "&DEVICE_BROWSER=Y";
			}else{
				newUrl = newUrl + "?DEVICE_BROWSER=Y";
			}
		}

		var vAppyn = getCookie("appYN");
		var vVerios = getCookie("verios") + "";

		if(vVerios != null && vVerios != "")			vVerios = parseInt(vVerios.replace(/\./g,""));
		else			vVerios = 0;

		//if(vAppyn == "Y"){
			var d = new Date();
			var curr_hour = d.getHours();
			var curr_min = d.getMinutes();

			var curr_sec = d.getSeconds();
			var curr_msec = d.getMilliseconds();

			var newWin = window.open("/mobilefirst/move.jsp?freetoken=outlink&vcode="+shopcode+"&url="+encodeURIComponent(newUrl)+"&goods_seq="+ goods_seq +"&ch="+curr_hour+curr_min+curr_sec+curr_msec);
		//}
		try{
			//2016-01-05 CTU V2 적용
			ctu_v2_forDeal(shopcode, goods_seq);
		}catch(e){}
	}

	var ua = navigator.userAgent.toLowerCase();
	var isAndroid = ua.indexOf("android") > -1;

	if(isAndroid) ga('send', 'event', 'mf_buy', 'click_Deal_AOS앱' ,  'buy_'+shopcode+'_'+goods_seq);
	else		  ga('send', 'event', 'mf_buy', 'click_Deal_IOS앱' ,  'buy_'+shopcode+'_'+goods_seq);

	$("#cm_loading").hide();
}
function ctu_v2_forDeal(vcode, goods_seq ){
	var vIp = "<%=strUserip %>";
	var vDevice = "1"; //pc 관리자에서 pc URL 을 넣기 때문에 device 를 pc flag 로 호출함
	//var vDevice = "2"; // 모바일
	if(vcode == "7885")		vDevice = "1";

	vDevice = 1; //무조건 pc 로 ctu 확인하기로함
	var vData_M = { shop_code: vcode, goods_seq: goods_seq };
	var goUrl = "/mobilefirst/include/inc_enurideal.jsp";

	$.ajax({
		type: "GET",
		url: "/mobilefirst/evt/ajax/ctuCrazyDeal.jsp",
		data: vData_M,
		dataType:"JSON",
		success: function(json){
			if(json.resultMsg == "SUCCESS"){
				if(json.resultData.SoldOut == "1"){
					//품절처리
					$.ajax({
						type: "POST",
						url: goUrl,
						data: "seq="+ goods_seq,
						dataType:"JSON",
						success: function(result){

						}
					});
				}
			}
		}
	});
}
function goFridayDealShop(url, shopcode, goods_seq ){
	//에누리딜용 품절처리 및 Move(브릿지)페이지 이동
	var vNowtime = new Date().format("yyyyMMddhhmm");
	vNowtime = vNowtime * 1;

	var d = new Date();
	var vMonth = d.getMonth()+1;
	var vDay = d.getDate();
	var vH = d.getHours();
	var vM = d.getMinutes();
	var newUrl = "";

	var vData_M = { seq: goods_seq, type:"F" };

	//url get
	$.ajax({
		type: "POST",
		url: "/mobilefirst/ajax/getEalurl.jsp",
		data: vData_M,
		dataType:"JSON",
		async: false,
		success: function(json){
			//품절인지 아닌지만 체크한다
			if(json.resultMsg == "SUCCESS"){
				if(json.soldout == "Y"){
					alert("품절 되었습니다.");
					location.reload();
					return false;
				}else{
					newUrl = json.resultUrl;
				}
			}else if(typeof json.msg != "undefined" && json.msg != "") {
				alert(json.msg);
				return false;
			}
		}
	});

	if(newUrl != ""){
		if( navigator.userAgent.indexOf("iPhone") > 0 || navigator.userAgent.indexOf("iPod") > 0 ||  navigator.userAgent.indexOf("iPad") > 0){
			if(newUrl.indexOf("?") > -1){
				if(newUrl.indexOf("#") > -1)	newUrl = newUrl.replace("?", "?DEVICE_BROWSER=Y&");	//G9예외
				else					newUrl = newUrl + "&DEVICE_BROWSER=Y";
			}else{
				newUrl = newUrl + "?DEVICE_BROWSER=Y";
			}
		}

		var vAppyn = getCookie("appYN");
		var vVerios = getCookie("verios") + "";

		if(vVerios != null && vVerios != "")			vVerios = parseInt(vVerios.replace(/\./g,""));
		else			vVerios = 0;

		var d = new Date();
		var curr_hour = d.getHours();
		var curr_min = d.getMinutes();

		var curr_sec = d.getSeconds();
		var curr_msec = d.getMilliseconds();

		var newWin = window.open("/mobilefirst/move.jsp?freetoken=outlink&vcode="+shopcode+"&url="+encodeURIComponent(newUrl)+"&goods_seq="+ goods_seq +"&ch="+curr_hour+curr_min+curr_sec+curr_msec);

		try{
			ctu_v2_forFridayDeal(shopcode, goods_seq);
		}catch(e){}
	}

	var ua = navigator.userAgent.toLowerCase();
	var isAndroid = ua.indexOf("android") > -1;

	if(isAndroid) ga('send', 'event', 'mf_buy', 'click_Deal_AOS앱' ,  'buy_'+shopcode+'_'+goods_seq);
	else		  ga('send', 'event', 'mf_buy', 'click_Deal_IOS앱' ,  'buy_'+shopcode+'_'+goods_seq);

	$("#cm_loading").hide();
}

function ctu_v2_forFridayDeal(vcode, goods_seq ){
	var vIp = "<%=strUserip %>";
	var vDevice = "1"; //pc 관리자에서 pc URL 을 넣기 때문에 device 를 pc flag 로 호출함
	//var vDevice = "2"; // 모바일
	if(vcode == "7885")		vDevice = "1";

	vDevice = 1; //무조건 pc 로 ctu 확인하기로함
	var vData_M = { shop_code: vcode, goods_seq: goods_seq };
	$.ajax({
		type: "GET",
		url: "/mobilefirst/evt/ajax/ctuCrazyFridayDeal.jsp", //사이트 품절여부 체크
		data: vData_M,
		dataType:"JSON",
		success: function(json){
			if(json.resultMsg == "SUCCESS"){
				if(json.resultData.SoldOut == "1"){
					//품절처리
					//품절이면 db 업데이트
					var goUrl = "/mobilefirst/include/inc_enurideal_friday.jsp";
					$.ajax({
						type: "POST",
						url: goUrl,
						data: "seq="+ goods_seq,
						dataType:"JSON",
						success: function(result){

						}
					});
				}
			}
		}
	});
}
function hitbrand_clickout(modelno, hitbrandno){
	var vIp = "<%=strUserip %>";

	var url = "/eventPlanZone/jsp/hitBrand2016_setlist.jsp";
	var param = "modelno="+modelno+"&ip="+vIp+"&hitBrandNo="+hitbrandno+"&osType=MO&click_out=Y";

	$.ajax({
		type: "POST",
		url: url,
		data: param,
		dataType: "JSON",
		success: function(result){

		}
	});

}

//uplus 용 트래킹코드
function fn_Enuri_PV(part, page_type, shop_code, pl_no, modelno){
	//"melog04":pageview, "melog05":click out
	/*
	 MOBILE : PV - Page_type info  (U+ 메인, 쇼핑, 일반상품, VIP 의 PAGE view)
	 =============
	 PV_MAIN : 메인 페이지 PV
	 PV_POPULAR : 인기상품 페이지 PV
	 PV_PL : 일반상품 쇼핑몰 이동시 PV
	 PV_VIP : VIP PV
	 =============

	 MOBILE : Click out - Page_type info  (vip이동, 일반상품에 대한 쇼핑몰이동)
	 =============
	 CO_VIP : enuri vip로 이동시 click out
	 CO_PL : 일반상품 쇼핑몰 이동시 click out
	 =============
	 *
	 */
	var logCode = "";

	if(part == "pv"){
		logCode = "melog04";
	}else if(part == "co"){
		logCode = "melog05";
	}
	var vUserip = "<%=strUserip %>";
	//$.get('http://jsonip.com/', function(r){
	//	vUserip = r.ip;
	//});

	var strUrl = "http://mymelog.enuri.com/MYMELOG/setLog.enr";
	var strParam = "logAuthCode="+ logCode +"&cpCode=CP0001&pageType="+ page_type +"&shopCode="+ shop_code +"&plNo="+ pl_no +"&modelno="+ modelno +"&userIp="+ vUserip;
	var strUrllink = strUrl + "?" + strParam;

	 $.ajax({
        url: strUrllink,
        dataType: 'jsonp',
        jsonpCallback: "callback",
        success: function(data) {
          //console.log('성공 - ', data);
        },
        error: function(xhr) {
          //console.log('실패 - ', xhr);
        }
      });
}
</script>
<iframe id="hFrame" name="hFrame" frameborder="0" style="margin:0px;padding:0px;height:0px;width:0px;"></iframe>