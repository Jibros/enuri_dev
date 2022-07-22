<!-- 스토어 인기브랜드 -->
<div class="benefit goos_zone">
    <h3>스토어 인기브랜드</h3>
        <ul class="bef_goos" id="benefit_list"></ul>         
</div>
<!-- 스토어 인기브랜드 -->
<script>
$(document).ready(function(){
	$.ajax({ 
		type: "POST",
		url: "/mobilefirst/emoney/emoney_get_random.jsp",
		async: false,
		data:{isShop:"Y", cnt:3},
		dataType:"JSON",
		success: function(data){
			var vTxt = "";
			var randomNum = new Array();
			randomNum[0]=data.store_seq0;
			randomNum[1]=data.store_seq1;
			randomNum[2]=data.store_seq2;
			
			for(var i=0;i<randomNum.length;i++){
				vTxt += "<li>";
				vTxt += "<a href=\"javascript:///\" onclick=\"goEmoneyStore("+randomNum[i]+");\">";
					vTxt += "<img src=\"http://imgenuri.enuri.gscdn.com/images/mobilefirst/emoney/store/@"+ randomNum[i] +".jpg\" alt=\"\">";
				vTxt += "</a>";
				vTxt += "</li>";		
			}			
			$("#benefit_list").html(vTxt);
		}
	});
});
</script>
