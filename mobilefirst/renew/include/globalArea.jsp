<!-- 191107 해외직구 가격비교 수정 -->
<div class="global_section con_box">
	<h3>해외직구 가격비교<a href="javascript:///" id="globalMore" class="more">더보기</a></h3>
	<div class="global_goods">
		<div class="swiper-container">
			<div class="swiper-wrapper" id="mglobalgoods">
				<!-- 가격비교 타입 -->
				<!-- // -->
			</div>
			<div class="swiper-button-prev"></div>
			<div class="swiper-button-next"></div>
		</div>
	</div>
	<div class="global_bnrlist">
		<div class="swiper-container">
			<div class="swiper-wrapper" id="globalBanner" >
				<!-- 반복 -->
			</div>
			<div class="swiper-button-prev"></div>
			<div class="swiper-button-next"></div>
		</div>
	</div>
</div>
<!-- // 해외쇼핑 -->
<script>

$(function(){
	
	loadGlobalBanner();
	loadGlobalGoods();
	
	$("#globalMore").click(function(){
		ga('send', 'event', 'mf_home', 'global', "click_more_web");
		location.href = "/global/m/Index.jsp";
	});
});

function loadGlobalBanner(){

	var loadUrl = "/main/main2018/ajax/globalBannerS.json";
	$.ajax({
		type: "GET",
		url: loadUrl,
		dataType: "JSON",
		success: function(data){

			var bhtml = "";
			
			$.each( data.shop , function(i,v){
				
				if(i == 21) return false;
				
				if( i%3 == 0 ) {
					bhtml += "<div class='swiper-slide' >";
					bhtml += "<ul>";
				}
				bhtml += "		<li class='globalLogo' data-url='"+v.mlink+"' data-id='"+v.muid+"' >";
				bhtml += "			<a href='javascript:///' >";
				bhtml += "				<span class=\"mglobal__item_thumb\"><img src='"+v.img_icon+"' alt=''></span>";
				bhtml += "				<span class=\"mglobal__item_txt\">";
				bhtml += "					<span class=\"mglobal__ico_emoney\">E</span>머니 <em>"+v.rate+"%</em>적립";
				bhtml += "				</span>";
				bhtml += "			</a>";
				bhtml += "		</li>";
				
				if( i!=0 && (i+1)%3 == 0 ){
					bhtml += "</ul>"; 
					bhtml += "</div>";
				}
				
			});
			
			$("#globalBanner").html(bhtml);
			
			var mySwiper = Swiper('.global_bnrlist .swiper-container',{
				prevButton : '.global_bnrlist .swiper-button-prev',
				nextButton : '.global_bnrlist .swiper-button-next',
				loop : true
			});
			
			$(".globalLogo").click(function(){
				var url = $(this).attr("data-url");
				var mid = $(this).attr("data-id");
				ga('send', 'event', 'mf_home', 'global', "click_compare_"+mid+"_web");
				location.href = url;
			});
			
		}
	});
}

function loadGlobalGoods(){
	
	var loadUrl = "/global/ajax/getDetailShoplist_ajax.jsp";

	$.ajax({
		type: "GET",
		url: loadUrl,
		dataType: "JSON",
		success: function(data){
			
			var goodsCnt = 0;
			
			if(data[0].global_model_list){
				
				var goodsHtml = "";
				
				$.each( data[0].global_model_list , function(i,v){
					
					goodsHtml += "<div class='swiper-slide type_compare'>";
					goodsHtml += "	<div class='list_inner' data-modelno='"+v.modelno+"' data-type='M' >";
					goodsHtml += "		<span class='thumb'>";
					goodsHtml += "			<span class='thumb_img' style=\"background-image:url('"+v.strImageUrl+"')\"></span>";
					goodsHtml += "		</span>";
					goodsHtml += "		<div class='info'>";
					goodsHtml += "			<span class='txt_prd_nm'>"+v.szModelNm+"</span>";
					goodsHtml += "			<div class='area_price'>";
					
					if( v.price_list ) {
					
						$.each( v.price_list , function(s,o){
							if(s == 0){
								goodsHtml += "	<span class='ico_brand'><img src='http://img.enuri.info/images/home/malllogo/"+o.shop_code+"_m.jpg' alt=''></span>";
								goodsHtml += "	<span class='txt_price'>";
								goodsHtml += "	<span class='txt_lowest'>최저가</span><strong>"+o.price_text+"</strong>원";
								
							}else{
								return false;
							}
						});
					
					}
					goodsHtml += "				</span>";
					goodsHtml += "			</div>";                                                                 
					goodsHtml += "		</div>";
					goodsHtml += "		<a href='javascript:///' data-modelno='"+v.modelno+"' class='btn_purchases' data-type='M'>최저가 구매하기</a>";  
					goodsHtml += "	</div>";
					goodsHtml += "</div>";
					
					goodsCnt++;
				});
			}
			if(data[1].global_item_list){
				
				if(goodsCnt < 10){
					var itemCnt = 10-goodsCnt;
					
					$.each( data[1].global_item_list , function(i , v){
						if(i < itemCnt ){
							             
							goodsHtml += "<div class='swiper-slide type_single'>";
							goodsHtml += "	<div class='list_inner' data-url='"+v.global_link_url+"' data-type='P' data-plno='"+v.global_pl_no+"' data-shopcode='"+v.global_shop_code+"' >";
							goodsHtml += "		<span class='thumb'>                                                                                                     ";
							goodsHtml += "			<span class='thumb_img' style=\"background-image:url('"+v.global_img_large+"')\"></span>";
							goodsHtml += "		</span>";
							goodsHtml += "		<div class='info'>";
							goodsHtml += "			<span class='txt_prd_nm'>"+v.global_name+"</span>";
							goodsHtml += "			<div class='area_price'>";
							goodsHtml += "				<span class='ico_brand'><img src='http://img.enuri.info/images/home/malllogo/"+v.global_shop_code+"_m.jpg'  alt='"+v.global_merchant_name+"'></span>";
							goodsHtml += "				<span class='txt_price'>                                                                                         ";
							goodsHtml += "					<strong>"+numberWithCommas(v.global_price)+"</strong>원                                                                                   ";
							goodsHtml += "				</span>                                                                                                          ";
							goodsHtml += "				<span class='txt_earn'>                                                                                          ";
							goodsHtml += "					<span class='mglobal__ico_emoney'>E</span>머니 "+numberWithCommas(v.global_emoney_rsv)+"점 <span class='txt_sub'>(예상적립)</span>               ";
							goodsHtml += "				</span>                                                                                                          ";
							goodsHtml += "			</div>                                                                                                               ";
							goodsHtml += "		</div>                                                                                                                   ";
							goodsHtml += "		<a href='javascript:///' data-type='P' data-url='"+v.global_link_url+"' class='btn_purchases'>바로 구매하기</a>";
							goodsHtml += "	</div>                                                                                                                       ";
							goodsHtml += "</div>																														 ";
							
						}else{
							return false;
						}
					});	
				}
			}
			$("#mglobalgoods").html(goodsHtml);
			/*
			$(".btn_purchases").click(function(){
				
				var type = $(this).attr("data-type");
				if(type=="M"){
					var modelno = $(this).attr("data-modelno");
					location.href = "detail.jsp?modelno="+modelno;
				}else{
					var url = $(this).attr("data-url");
					
					var shopcode = $(this).attr("data-shopcode");
					var plno = $(this).attr("data-plno");
					
					url = "/mobilefirst/move.jsp?vcode="+shopcode+"&plno="+plno+"&url="+encodeURIComponent(url);
					window.open(url);
				}
			});
			*/
			var mySwiper = Swiper('.global_goods .swiper-container',{
				prevButton : '.global_goods .swiper-button-prev',
				nextButton : '.global_goods .swiper-button-next',
				slidesPerView : 2,
				breakpoints : {
					767 : {	slidesPerView : 1	}
				},
				loop : true
			});
			setTimeout(function(){
		    	
				$(".list_inner").click(function(){
					
					var type = $(this).attr("data-type");
					
					ga('send', 'event', 'mf_home', 'global', "click_product_web");
					
					if(type=="M"){
						var modelno = $(this).attr("data-modelno");
						location.href = "detail.jsp?modelno="+modelno;
					}else{
						var url = $(this).attr("data-url");
						
	 					var shopcode = $(this).attr("data-shopcode");
						var plno = $(this).attr("data-plno");
						
						url = "/mobilefirst/move.jsp?vcode="+shopcode+"&plno="+plno+"&url="+encodeURIComponent(url);
						window.open(url);
					}
				});
		    },500);
		}
	});
}
</script>