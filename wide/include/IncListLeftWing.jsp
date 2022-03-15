<%
	// LP : 0, VIP : 1, SRP : 2
	int viewFlag = 0;
	
	if (request.getServletPath().trim().indexOf("/detail.jsp")>=0) {
		viewFlag = 1;
	} else if(request.getServletPath().trim().indexOf("/search.jsp")>=0) {
		// 검색 페이지에서 보이는 실시간 급상승어
		viewFlag = 2;
	}
	
%>
<!-- [C] 좌측윙 -->
<div class="wing wing--left" id="mainLeftBanner">
	<div id="mainLeftDivHtml" class="wing-ad"></div>
	
</div>

<script>
var varLeftBannerCate = param_cate ;
var varViewFlag = "<%= viewFlag %>";
var varLeftBanHtml = "";
var varT2BanCnt = 0;
var gKeyword = param_keyword;

$(document).ready(function(){
	getLeftAd();
});

function getLeftAd() {
	
	varLeftBanHtml = "";
	var varLeftBanAdCate = varLeftBannerCate;
	
	if (varLeftBanAdCate != "") {
		if (varLeftBanAdCate.length > 4) {
			varLeftBanAdCate = varLeftBanAdCate.substring(0, 4);
		}
		varLeftBanAdCate = "?cate="+varLeftBanAdCate;
		// LP, VIP 광고 호출 ( SRP 제외 )
		getFirstLeftBanner(varLeftBanAdCate);	
	} else {
		getSecondLeftBanner("");
	}
	
	// 11번가 배너 
	get11stAd(varViewFlag, varLeftBannerCate, gKeyword);
	
}

// LP, SRP 좌측 첫번째 배너 호출
function getFirstLeftBanner(varLeftBanAdCate) {
	var varT2Url = "http://ad-api.enuri.info/enuri_PC/pc_lp/T3/req" + varLeftBanAdCate;		// LP
	$.get(varT2Url, function(bannerT2){
		if (bannerT2.length > 0 && bannerT2.indexOf("JURL1") < 0) {		// html로 내려 주는 영역 (구버젼)
			//varLeftBanHtml = varLeftBanHtml + bannerT2;
		} else {		// json 일 경우 
			var object = bannerT2;
			if (object != null && typeof object != "undefined" && object.JURL1.length > 0 && object.IMG1.length > 0 ) {
				varLeftBanHtml = varLeftBanHtml + "<a href=\"javascript:goLpLeftBannerLink('" + object.TARGET +"', '"+object.JURL1+"');\" class=\"wing-ad__bnr\">";
				varLeftBanHtml = varLeftBanHtml + "<img src=\""+ object.IMG1+"\" width=\""+ object.WIDTH+"\" height=\""+ object.HEIGHT+"\" border=\"0\">";
				varLeftBanHtml = varLeftBanHtml + "</a>";
			}
		}
		getSecondLeftBanner(varLeftBanAdCate);
	});
}

//LP, SRP 좌측 두번째 배너 호출
function getSecondLeftBanner(varLeftBanAdCate) {
	
	if (varViewFlag == "2") {
		var varBannerUrl = "http://ad-api.enuri.info/enuri_PC/pc_srp/S2/req";
	} else {
		if (varLeftBanAdCate.indexOf("?") > -1) {varLeftBanAdCate = varLeftBanAdCate.replace("?", "&");}
		var varBannerUrl = "http://ad-api.enuri.info/enuri_PC/pc_lp/T2/bundle?bundlenum=2"+varLeftBanAdCate;
	}
	if (varT2BanCnt == 0) {		// T2 배너를 어디선가 두번 호출하는 현상 발생하여 카운트로 이중 호출 방지
		$.get(varBannerUrl, function(bannerT2){
			var object = bannerT2;
			if (object.length > 0) {			//return data가 [] 만 올 경우 있음
				$.each(object,function(i,o){
					if (o["JURL1"].length > 0 && o["IMG1"].length > 0 ) {
						varLeftBanHtml = varLeftBanHtml + "<a href=\"javascript:goLpLeftBannerLink('" + o["TARGET"] +"', '"+o["JURL1"]+"');\" class=\"wing-ad__bnr\">";
						varLeftBanHtml = varLeftBanHtml + "<img src=\""+o["IMG1"]+"\" width=\""+o["WIDTH"]+"\" height=\""+o["HEIGHT"]+"\" border=\"0\">";
						varLeftBanHtml = varLeftBanHtml + "</a>";
					}
				});
			} else {
				if (object != null && typeof object != "undefined" && object["JURL1"]  && object["JURL1"].length > 0 && object["IMG1"] && object["IMG1"].length > 0 ) {
					varLeftBanHtml = varLeftBanHtml + "<a href=\"javascript:goLpLeftBannerLink('" + object["TARGET"] +"', '"+object["JURL1"]+"');\" class=\"wing-ad__bnr\">";
					varLeftBanHtml = varLeftBanHtml + "<img src=\""+object["IMG1"]+"\" width=\""+object["WIDTH"]+"\" height=\""+object["HEIGHT"]+"\" border=\"0\">";
					varLeftBanHtml = varLeftBanHtml + "</a>";
				}
			}
			
			var varSumLeftHtml = "";
			if (varLeftBanHtml.length > 0) {
				varSumLeftHtml = varSumLeftHtml + varLeftBanHtml;
				$("#mainLeftDivHtml").html(varLeftBanHtml);
				$("#mainLeftDivHtml").show();
				varT2BanCnt++;
			} else {
				$("#mainLeftDivHtml").hide();
			}
		});
	}
}

function goLpLeftBannerLink(type, link) {
	if(type=="1") {
		window.open(link);
	}else if(type=="2") {
		top.location.href=link;
	}else if(type=="3") {
		window.detailWin = window.open(link,"detailMultiWin","width=804,height="+window.screen.height+",left=0,top=0,toolbar=no,directories=no,status=no,scrollbars=yes,resizable=yes,menubar=no");
		window.detailWin.focus();
	}
}

// 11번가 배너 호출
function get11stAd(viewType, cate, keyword) {
	
	var page = "";
	if(viewType!=null) {
		if(viewType==0) {
			page = "lp";
		} else if(viewType==1) {
			page = "vip";
		} else if(viewType==2) {
			page = "srp";
		}
	}
	
	var dstParam = "device=web";
	dstParam += "&type="+page+"&size=1";
	if(page=="lp" || page=="vip") {
		dstParam += "&cate="+cate;
	} else {
		dstParam += "&keyword="+encodeURIComponent(keyword);
	}
	
	var ajaxObj = $.ajax({
		type : "get", 
		url : "/lsv2016/ajax/getSponsor11st_ajax.jsp?" + dstParam,
		dataType : "json", 
		success: function(ret) {
			if(ret.success && ret.data.length>0) {
				
				var item = ret.data[0];
				if($(".wing_cpc").length==0) {
					var ad11stHtml = "";
					ad11stHtml += "	<div class=\"wing-cpc wingbnr\">";
					ad11stHtml += "		<div class=\"wing-cpc--head\">";
					ad11stHtml += "		    <span class=\"wing-cpc__logo\"><i class=\"ico-shop--11st\">11번가</i></span>";
					ad11stHtml += "		    <span class=\"wing-cpc__tag--ad\">AD</span>";
					ad11stHtml += "		</div>";
					ad11stHtml += "		<a href=\""+item.curl+"\" target=\"_blank\" class=\"wing-cpc--prod\">";
					ad11stHtml += "		    <!-- 썸네일 -->";
					ad11stHtml += "		    <span class=\"wing-cpc__thumb\">";
					ad11stHtml += "			<img src=\""+item.img+"\" alt=\"11번가 윙배너\" width=\"82\" height=\"82\"></span>";
					ad11stHtml += "		    <span class=\"wing-cpc__info\">";
					ad11stHtml += "		        <!-- 상품명 -->";
					ad11stHtml += "		        <span class=\"wing-cpc__tx--name\">"+item.title+"</span>";
					if(typeof item.discount=="number") {
						// 할인율이 0 이면 보여주지 않는다.
						if(item.discount>0) {
							ad11stHtml += "		<!-- 할인율 -->";
							ad11stHtml += "		<span class=\"wing-cpc__tx--salerate\">"+item.discount+"%</span>";
						}
					}
					ad11stHtml += "		        <!-- 가격 -->";
					ad11stHtml += "		        <span class=\"wing-cpc__tx--price\"><em>"+numberWithCommas(item.price)+"</em>원</span>";
					ad11stHtml += "		    </span>";
					ad11stHtml += "		</a>";
					ad11stHtml += " </div>";
					
					if(page=="lp" || page=="vip") {
						$("#mainLeftBanner").append(ad11stHtml);
					} else {
						$("#mainLeftDivHtml").after(ad11stHtml);
					}
					
					$(".wing-cpc a").on("click", function() {
						if(page=="lp") {
							insertLogLSV(23319);
						} else if(page=="srp") {
							insertLogLSV(23320);
						} else if(page=="vip") {
							insertLogLSV(23321);
						}
					});
					
					// impression
					impCall(item.impt);
				}
			}
		},
		error: function (xhr, ajaxOptions, thrownError) {
			//alert(xhr.status);
			//alert(thrownError);
		}
	});
}

// include 파일 내에서 다른 파일을 참조하지 못하므로 함수 재생성
function numberWithCommas(x) {
	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

//impression call
function impCall(impUrl) {
	if(impUrl && impUrl.length>0) {
		$.ajax({
			type: "GET",
			url: impUrl
		});
	}
}
</script>