<!-- layer-->
<div class="notice_layer stamp_layer_open" id="stamp_complete" style="display:none;"  >
	<h4>스탬프 참여 완료!</h4>
	<div class="cont">
		<p class="txt"><strong>경품지급일을 기다려주세요!</strong>(구매 후 취소/반품시 제외)</p>
		<a href="javascript:void(0);" class="btn btn_layclose" onclick="javascript:location.reload();">확인</a>
	</div>
	<a class="btn layclose2" href="javascript:void(0);" onclick="onoff('stampComplete');return false"><em>팝업 닫기</em></a>
</div>

<!-- 누리팡! 스탬프 -->
<div id="tab2" class="nuripang_stamp">
	<div class="inner">
              <div class="top_area">
                  <strong class="evt01">이벤트01</strong>
                  <h2 class="evt01_tit">APP에서 1만원 이상 구매하고 스탬프 찍으면 e머니 쏜다. 누리팡스템프</h2>
              </div>
		<div class="view_cont">
			<h3>나의 스탬프 구매 현황</h3>
			<div class="state_stamp">
                      <div class="top">
                          <div class="stamp01"><span class="t">스탬프</span><em class="stamp" ><span id="myGetStemp">0</span>개</em></div>
                          <div class="stamp02"><em class="emoney" ><span id="myExpectedPoint" >0</span>적립예정</em></div>
                      </div>
				<div class="list" id="stampList">
					<ol>
						<li class="e100_1"><i>1회</i><span class="btn">100 추가적립 완료</span></li><!-- 완료 span class="stamp100"추가 -->
						<li class="e300_2"><i>2회</i><span class="btn">100 추가적립 완료</span></li><!-- 완료 span class="stamp100"추가 -->
						<li class="e200_3"><i>3회</i><span class="btn">200 추가적립 완료</span></li><!-- 선물1 span class="stamp200"추가 -->
						<li class="e200_4"><i>4회</i><span class="btn">스탬프 클릭</span></li><!-- 스탬프 클릭 span class="click"추가 -->
						<li class="e300_5"><i>5회</i><span class="btn">300 추가적립 완료</span></li><!-- 선물2 span class="stamp300"추가 -->
						<li class="e400_6"><i>6회</i><span class="btn">400 추가적립 완료</span></li><!-- 선물3 span class="stamp400"추가 -->
						<li class="e500_7"><i>7회</i><span class="btn">500 추가적립 완료</span></li><!-- 선물3 span class="stamp500"추가 -->
						<li class="e100_8"><i>8회</i><span class="btn">700 추가적립 완료</span></li><!-- 선물3 span class="stamp1000"추가 -->
					</ol>
				</div>
			</div>
			
			<ul class="info_list">
                <li><strong>· 이벤트 기간 :</strong> <%= dateFormatter.format(prevFormat.parse(startDate)) %> ~ <%= dateFormatter.format(prevFormat.parse(endDate)) %></li>
                <li><strong>· 경품 지급일 :</strong> <%= dateFormatter.format(prevFormat.parse(dday)) %></li>
            </ul>
			
			<!-- 스탬프 참여완료 레이어 -->
			<div class="notice stamplayer" id="stampComplete" style="display:none;">
				<div class="dim"></div>
				<div class="notice_layer stamp_layer_open">
					<h4>스탬프 참여 완료!</h4>
					<div class="cont">
						<p class="txt"><strong>경품지급일을 기다려주세요!</strong>(구매 후 취소/반품시 제외)</p>
						<a href="javascript:void(0);" class="btn btn_layclose" onclick="onoff('stampComplete');return false">확인</a>
					</div>
					<a class="btn layclose2" href="javascript:void(0);" onclick="onoff('stampComplete');return false"><em>팝업 닫기</em></a>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 유의사항 WRAPPER -->
	<div class="caution-wrap">
		<a href="javascript:///" class="btn_check">이벤트 유의사항</a>
		
		<!-- 누리팡 스탬프 유의사항 -->
		<div class="moreview">
			<h4>누리팡 스탬프 유의사항</h4>
			<div class="txt">
				<strong>이벤트 및 구매기간</strong>
				<ul class="txt_indent">
					<li><%= dateFormatter.format(prevFormat.parse(startDate)) %> ~ <%= dateFormatter.format(prevFormat.parse(endDate)) %></li>
				</ul>
				<strong>당첨자 혜택</strong>
				<ul class="txt_indent">
					<li><b>이벤트 경품: 참여 횟수에 따라 E머니 지급</b>
						<br />※ 적립된 e머니는 e쿠폰 스토어에서 교환가능합니다.</li>
					<li><b>경품 지급일:</b> <%= dateFormatter.format(prevFormat.parse(dday)) %></li>
					<li><strong class="stress">e머니 유효기간 : 적립일로부터 15일</strong></li>
				</ul>
				
				<strong>참여 방법 &amp; 유의사항</strong>
				<ul class="txt_indent">
					<li>참여방법: 에누리 가격비교 로그인 → 적립대상 쇼핑몰 이동 → <span class="stress">1만원 이상 구매</span> → 스탬프 참여</li>
					<li><b>적립대상 쇼핑몰: </b>G마켓, 옥션, 11번가, 인터파크, 티몬, 위메프, 쿠팡, GS SHOP, CJmall, SSG (신세계몰, 신세계백화점, 이마트몰, 트레이더스), 마이크로소프트 전문관(스마트스토어),SK스토아</li> 
					<li>적립대상 쇼핑몰에서 1건 구매시 1개의 스탬프 생성</li>
					<li>이벤트 기간 내에 <span class="stress">1만원 이상 구매한 횟수에 따라 경품 지급</span></li> 
					<li>1만원 이상 구매금액은 배송비, 설치비, 할인, 쇼핑몰 포인트 등 제외한 상품의 실제 결제금액만 반영됨</li>
					<li>여러 개의 상품을 쇼핑몰 장바구니에 담은 뒤 한 번에 결제한 경우 1개의 스탬프만 생성</li>
					<li>동일한 핸드폰번호로 가입한 ID의 경우 중복참여불가</li>
					<li><b class="stress">경품지급 제외</b>: 아래의 경우 이벤트 참여는 가능하나 경품 지급대상에서 제외됩니다.
						<ul class="txt_indent">
							<li>실제 결제금액이 1만원 미만의 구매일 경우</li>
							<li>e머니 적립 제외 카테고리의 상품 구매일 경우</li>
	                                 <li>스탬프 참여 후 취소/환불/교환/반품한 경우</li>
	                                 <li>해외직구 상품 구매 후 참여한 경우</li>
						</ul>
					</li>
                </ul>
				<strong>아래의 경우에는 구매 확인 및 적립이 불가합니다.</strong>
				<ul class="txt_indent">
					<li>에누리 가격비교 앱이 아닌 다른 앱을 통해서 장바구니 또는 관심상품 등록 후 에누리 가격비교 앱으로 결제만 한 경우<br>(에누리 가격비교 앱을 통해 쇼핑몰로 이동 후 장바구니/관심상품 등록 후 구매 시에는 가능)</li>
					<li>에누리 가격비교 앱 미 로그인 후 구매한 경우 또는 에누리 가격비교 PC, 모바일 웹에서 구매한 경우<br>
						<b class="stress">※ 티몬의 경우 PC 및 모바일 앱/웹에서 로그인 후 구매시 e머니 적립 가능 </b>
					</li>
				</ul>
				<strong>유의사항</strong>
				<ul class="txt_indent">
					<li>부정 참여 시 적립이 취소될 수 있습니다.</li>
					<li>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</li>
				</ul>
				
				<a href="javascript:///" class="btn_check_hide">확인</a>
			</div>
		</div>
		<!-- //누리팡 스탬프 유의사항 -->
	</div>
    <!-- //유의사항 WRAPPER -->
          
</div>
<!-- //누리팡! 스탬프 -->
<script type="text/javascript">
(function() {
	//스탬프 이벤트 정보
	var stampInfo = {
		eventCode : "2020030101",
		startDate : "20200302", //이벤트 시작날짜 꼭 넣어준다
		endDate : 	"20200331", //이벤트 종료 날짜
		total_stampcnt : 8,
		stamptPoint: [ 100 , 300 , 200 , 200 , 300 , 400 , 500 , 500 ],
		addClassNm : [ "stamp", "stamp", "stamp", "stamp", "stamp", "stamp", "stamp", "stamp" ]
	};
	//테스트날짜
	
	if(location.host.indexOf("dev.enuri.com") > -1){
		stampInfo.startDate = "20200218";
	}
	
	//유저 정보
	var myStampCnt = 0,
		myPurchaseCnt = 0;

	//클릭가능여부
	var isClick = true;

	//스탬프 클릭영역
	var stampArea = $("#stampList > ol > li");

	if(islogin()){
		//스탬프 갯수 불러오기
		myStampCnt = getStampCnt();
		$(".mystamp .number").html("<em>" + myStampCnt + "</em>개");

 		//스탬프 갯수만큼 도장찍기
		if(myStampCnt > 0){
			var breakPoint = myStampCnt - 1;
			stampInfo.addClassNm.some(function(value, index){ 
				stampArea.eq(index).find("span").addClass(value);
				return (index == breakPoint);
			});
		}
		//앱에서 깜빡임 활성화
		//if(getCookie("appYN") == "Y"){
			myPurchaseCnt = getPurchaseCnt();
		
			//깜빡이는 스탬프 갯수
			var twinkleCnt = myPurchaseCnt - myStampCnt;
			if(twinkleCnt > stampInfo.total_stampcnt){
				twinkleCnt = stampInfo.total_stampcnt;
			}
			for(var i=0; i<twinkleCnt; i++){
				stampArea.eq( myStampCnt + i ).find("span").addClass("stamp click");
			}
		//}
		$("#myGetStemp").text(myStampCnt);
		$("#myExpectedPoint").text(numberWithCommas(getStempPoint(myStampCnt)));
	}
	//스탬프 클릭 이벤트
	stampArea.find("span").click(function(e){
		ga('send', 'event', vEvent_title+'_APP', 'button', '누리팡!스탬프_이벤트 참여하기');
		//날짜 똑바로 확인
		
		if(<%=sdt%> > stampInfo.endDate){
			alert('이벤트 종료!\n다음 이벤트는\n곧 오픈 예정입니다.');
		}else if(!islogin()){
			goLogin();
		//}else if(getCookie("appYN") != "Y"){
			//onoff('app_only');
		//}else if($(this).attr("class")=="btn"){
			//alert("구매 후 참여 가능합니다!");
		//}else if($(this).hasClass("click")){
		}else{
			if(!isClick)				return false;
			isClick = false;
			$.ajax({
				type: "POST",
				url: "/mobilefirst/evt/ajax/ajax_insertStamp_proc.jsp",
				data: { sdt : <%=sdt %> , ostpcd : getOsType() },
				async: false,
				dataType:"JSON",
				success: function(json){
					var result = json.result;
					
					if(result==1){
						//myStampCnt = getStampCnt();
						$(".mystamp .number").html("<em>" + (++myStampCnt) + "</em>개");
						stampArea.eq( myStampCnt-1 ).find("span").removeClass("click").addClass(stampInfo.addClassNm[myStampCnt-1]);
						onoff('stamp_complete');
					}else if(result==-2){
						alert("중복 핸드폰번호로 참여 불가능합니다.");
					}else if(result==-3){
						onoff('stamp_complete');
					}else if(result==-1){
						alert("구매 후 참여 가능합니다!");
					}else if(result==-4){
						alert("SDU 회원은 본인인증 후 참여 가능합니다.\n※ 본인인증은 ‘앱 설정 > 본인인증’ 또는 ‘PC >\n개인정보관리 화면’을 이용해주세요");
					}else if(result==-5){
						var r = confirm("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?");
						if(r){
							location.href = "https://m.enuri.com/mobilefirst/member/myAuth.jsp?cmdType=&f=m&freetoken=login_title";
						}
					}else{
						alert("잘못된 접근입니다.");
					}
				}, complete : function() {
					isClick=true;
				}
			});
		}
	});

	function getOsType(){
	    var osType = "";
	    if(app =='Y'){
	         if(navigator.userAgent.indexOf("Android") > -1)		        	 osType = "MAA";
	         else		        	 osType = "MAI";
	    }else {
	         if(navigator.userAgent.indexOf("Android") > -1)		        	 osType = "MWA";
	         else		        	 osType = "MWI";
	    }
	    return osType;
	}
	
	//구매건수
	function getPurchaseCnt(){
		var buyCnt=0;
		$.ajax({
			type: "POST",
			url: "/mobilefirst/evt/ajax/ajax_purchaseCount.jsp",
			async: false,
			data: {startDate:stampInfo.startDate},
			dataType:"JSON",
			success: function(json){
				buyCnt = parseInt(json.purchaseCnt);
			}
		});
		return buyCnt;
	}
	//스탬프갯수
	function getStampCnt(){
		var stampCnt = 0;
		$.ajax({
			type: "GET",
			url: "/event2016/getStamp.jsp?eventid=" + stampInfo.eventCode,
			async: false,
			dataType:"json",
			success: function(json){
				stampCnt = parseInt(json.result); 
			}
		});
		return stampCnt;
	}
	function getStempPoint(stempCnt){
		
		var returnPoint = 0;
		
		if(stempCnt > 0){
			$.each(stampInfo.stamptPoint,function(i,v){
				returnPoint += v;
				if (stempCnt-1 == i){
					return false;
				}
			});			
		}
		return returnPoint;
	}
	function numberWithCommas(x) {    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");}
}());
</script>
