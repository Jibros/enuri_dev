<div class="liveProduct">
	<div class="contents">
		<div class="top_area">
			<a href="javascript:///" onclick="bestMore()">more</a>
			<h2>지금 인기상품은?</h2>
		</div>
		<div class="inner">
			<div class="itemlist" id="itemlist"></div>
		</div>
	</div>
</div>
<script type="text/javascript" >
try{
		
	var bestGmarket   = "/mobilefirst/http/json/bestGmarket.json";
	var bestAuction   = "/mobilefirst/http/json/bestAuction.json";
	var bestInterPark = "/mobilefirst/http/json/bestInterPark.json";
	var best11st 	  = "/mobilefirst/http/json/best11st.json";
	
	$itemList = $("#itemlist");
	
	$.ajax({
    	type: "GET",
        url: bestGmarket,
        dataType: "JSON",
        success: function(result){
        	if(result.goodsList){
        		var bestGoodsTemplate  = "<div class=\"lpitem\" >";
    			bestGoodsTemplate += "<a href='javascript:///' onclick=\"goBestLink('"+result.goodsList[0].url+"')\"  title='새 탭에서 열립니다.'>";
    			bestGoodsTemplate +=	"<span class=\"thumb\">";
    			//bestGoodsTemplate +=		"<span class=\"soldout\"></span>";
    			bestGoodsTemplate +=		"<img src='"+result.goodsList[0].shopImageUrl+"' alt=''>";
    			bestGoodsTemplate +=	"</span>";
    			bestGoodsTemplate +=	"<span class=\"info\">";
    			bestGoodsTemplate +=		"<strong>"+result.goodsList[0].goodsnm+"</strong>";
    			bestGoodsTemplate +=		"<em><b>"+numberWithCommas(result.goodsList[0].price)+"</b>원</em>";
    			bestGoodsTemplate +=	"</span>";
    			bestGoodsTemplate +="</a>";
    			bestGoodsTemplate +="</div>";
    			
    			$itemList.append(bestGoodsTemplate);
        	}
        }
	});
	$.ajax({
    	type: "GET",
        url: bestAuction,
        dataType: "JSON",
        success: function(result){
       		
        	if(result.goodsList){
        		var bestGoodsTemplate  = "<div class=\"lpitem\"  >";
    			bestGoodsTemplate += "<a href='javascript:///' onclick=\"goBestLink('"+result.goodsList[0].url+"')\" title='새 탭에서 열립니다.'>";
    			bestGoodsTemplate +=	"<span class=\"thumb\">";
    			//bestGoodsTemplate +=		"<span class=\"soldout\"></span>";
    			bestGoodsTemplate +=		"<img src='"+result.goodsList[0].shopImageUrl+"' alt=''>";
    			bestGoodsTemplate +=	"</span>";
    			bestGoodsTemplate +=	"<span class=\"info\">";
    			bestGoodsTemplate +=		"<strong>"+result.goodsList[0].goodsnm+"</strong>";
    			bestGoodsTemplate +=		"<em><b>"+numberWithCommas(result.goodsList[0].price)+"</b>원</em>";
    			bestGoodsTemplate +=	"</span>";
    			bestGoodsTemplate +="</a>";
    			bestGoodsTemplate +="</div>";
    			
    			$itemList.append(bestGoodsTemplate);
        	}
        	
        }
	});
	
	$.ajax({
    	type: "GET",
        url: bestInterPark,
        dataType: "JSON",
        success: function(result){
       		
        	if(result.goodsList){
        		var bestGoodsTemplate  = "<div class=\"lpitem\"  >";
    			bestGoodsTemplate += "<a href='javascript:///'  onclick=\"goBestLink('"+result.goodsList[0].url+"')\"  >";
    			bestGoodsTemplate +=	"<span class=\"thumb\">";
    			//bestGoodsTemplate +=		"<span class=\"soldout\"></span>";
    			bestGoodsTemplate +=		"<img src='"+result.goodsList[0].shopImageUrl+"' alt=''>";
    			bestGoodsTemplate +=	"</span>";
    			bestGoodsTemplate +=	"<span class=\"info\">";
    			bestGoodsTemplate +=		"<strong>"+result.goodsList[0].goodsnm+"</strong>";
    			bestGoodsTemplate +=		"<em><b>"+numberWithCommas(result.goodsList[0].price)+"</b>원</em>";
    			bestGoodsTemplate +=	"</span>";
    			bestGoodsTemplate +="</a>";
    			bestGoodsTemplate +="</div>";
    			
    			$itemList.append(bestGoodsTemplate);
        	}
        	
        }
	});
	$.ajax({
    	type: "GET",
        url: best11st,
        dataType: "JSON",
        success: function(result){
       		
        	if(result.goodsList){
        		var bestGoodsTemplate  = "<div class=\"lpitem\"   >";
    			bestGoodsTemplate += "<a href='javascript:///' onclick=\"goBestLink('"+result.goodsList[0].url+"')\"   >";
    			bestGoodsTemplate +=	"<span class=\"thumb\">";
    			//bestGoodsTemplate +=		"<span class=\"soldout\"></span>";
    			bestGoodsTemplate +=		"<img src='"+result.goodsList[0].shopImageUrl+"' alt=''>";
    			bestGoodsTemplate +=	"</span>";
    			bestGoodsTemplate +=	"<span class=\"info\">";
    			bestGoodsTemplate +=		"<strong>"+result.goodsList[0].goodsnm+"</strong>";
    			bestGoodsTemplate +=		"<em><b>"+numberWithCommas(result.goodsList[0].price)+"</b>원</em>";
    			bestGoodsTemplate +=	"</span>";
    			bestGoodsTemplate +="</a>";
    			bestGoodsTemplate +="</div>";

    			$itemList.append(bestGoodsTemplate);
        	}
        }
	});

}catch(e){}
function goBestLink(url){

	var link = document.location.href;

	if(link.indexOf("smart_benefits.jsp") > -1 ){
		ga('send', 'event', 'mf_event', 'smart_page','인기상품_상품');
	}else if( link.indexOf("birthday_event.jsp") > -1 ){
		ga('send', 'event', 'mf_event', 'birthday_page','인기상품_상품');
	}

	window.open(url);
}
function bestMore(){

	var link = document.location.href;

	if(link.indexOf("smart_benefits.jsp") > -1 ){
		ga('send', 'event', 'mf_event', 'smart_page','인기상품_더보기');
	}else if( link.indexOf("birthday_event.jsp") > -1 ){
		ga('send', 'event', 'mf_event', 'birthday_page','인기상품_더보기');
	}

	if(APPYN == 'Y') {
		window.open("/m/index.jsp?freetoken=main_tab|bestdeal");
	} else {
		window.open("/m/index.jsp#hotdeal");
	}
}
function numberWithCommas(x) {    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");}
</script>