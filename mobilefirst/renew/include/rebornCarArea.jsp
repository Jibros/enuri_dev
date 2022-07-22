<!-- 191122 중고차 추가 -->
<div class="reborn_section con_box">
	<h3>프리미엄 중고차<a href="javascript:///" id="carMore" class="more" >더보기</a></h3>
	<div class="reborn_goods">
		<div class="swiper-container">
			<div class="swiper-wrapper" id="reborn_swiper">
				<!-- 배너 타입 -->
				<div class="swiper-slide type_bnr">
					<!-- 배너 타입은 a태그에 inline-style로 배경색 / 이미지 경로 넣어주세요 -->
					<a href="javascript:///" onclick="carMore()" style="background-color:#e9f0ff;background-image:url(http://img.enuri.info/images/home/reborncar/m_bnr_reborn_main.jpg)">
						상담신청만 해도 e머니 10,000점 지급!
					</a>
				</div>
				<!-- // -->
				<!-- 상품 타입 -->
			</div>
			<!-- 
			<div class="swiper-button-prev"></div>
			<div class="swiper-button-next"></div>
			 -->
		</div>
	</div>
</div>
<!-- // 중고차 -->
<script>
$(function(){
	loadCarGoods();
	$("#carMore").click(function(){
		carMore();	
	});
});

function carMore(){
	ga('send', 'event', 'mf_home', 'car', "click_more_web");

	window.open("/enuricar/m/list.jsp");
	
}

function loadCarGoods(){

	//var loadUrl = "http://stagedev.enuri.com/lsv2016/ajax/getCarSearch_ajax.jsp?pageNum=1&pageGap=10&sort=1";
	var loadUrl = "/main/main2018/ajax/mainCarData.json";
	
	$.ajax({
		type: "GET",
		url: loadUrl,
		dataType: "JSON",
		success: function(json){
			
			total = json.hits.total.value;
			
			$.each(json.hits.hits,function( i , d ){
				
				if(i > 9) return false;
				
				var v = d._source;
				var carHtml = "";
				
				carHtml += "<div class='swiper-slide type_goods car' data-url='"+v.mobl_url+"' data-cd='"+v.gd_cd+"' >";
				carHtml += "	<a href='javascript:///'>";
				
				var carImgurl = getResellCarImageUrl (v.spm_cd, v.gd_cd, v.img_url, v.img_st_cd);
				
				carHtml += "		<span class='thumb'><img src='"+carImgurl+"' alt=''  onerror=\"this.src='http://img.enuri.info/images/home/reborncar/img_default.gif';\" ></span>  ";
				carHtml += "		<span class='info'>";
				carHtml += "			<span class='txt_name'>";
				carHtml += "				<span class='name'>"+v.mkr_nm+" "+v.car_nm+"</span>";
				carHtml += "				<span class='model'>"+v.car_dtl_nm+"</span>";
				carHtml += "			</span>";
				carHtml += "			<span class='txt_spec'>";
				carHtml += "				<span class='item'>"+v.yridnw+"연식</span><span class='item'>"+numberWithCommas(v.drvng_dstnc)+"km</span><span class='item'>"+v.fuel_spec_nm+"</span>     ";
				carHtml += "			</span>";
				carHtml += "			<span class='txt_price'>";
				var opn_prc = numberWithCommas(v.opn_prc/10000);
				carHtml += "				<span class='org_price'><em>"+opn_prc+"</em>만원</span>";
				carHtml += "				<span class='sell_price'>";
				
				var sal_prc = numberWithCommas(v.sal_prc/10000);
				
				carHtml += "					<span class='txt'>판매가</span><em>"+sal_prc+"</em>만원";
				carHtml += "				</span>";
				carHtml += "			</span>";
				carHtml += "		</span>";
				carHtml += "	</a>";
				carHtml += "</div>";
				
				$("#reborn_swiper").append(carHtml);
			});
			
			/*
			var mySwiper = Swiper('.reborn_goods .swiper-container',{
				prevButton : '.reborn_goods .swiper-button-prev',
				nextButton : '.reborn_goods .swiper-button-next',
				slidesPerView : 2,
				breakpoints : {
					767 : {
						slidesPerView : 1
					}
				},
				loop : true
			});
			*/
			// 191211 스크립트 수정
			var mySwiper = Swiper('.reborn_goods .swiper-container',{
				spaceBetween : 10,
				slidesPerView : 2.2,
				breakpoints : {
					767 : {
						slidesPerView: 'auto'
					}
				},
				loop : true
			});
			
			$(".swiper-slide.type_goods.car").click(function(){
				
				var gd_cd = $(this).attr("data-cd");
				var url = $(this).attr("data-url");
				goResellCarItem(gd_cd, url);
				
			});
			
		}
	});

}
</script>