<div id="evt1" class="birthday">
	<div class="contents">
		<h2>특별한 생일 혜택</h2>
		<p class="blind">생일 축하드려요! 스탬프 참여시 e머니 500점 추가 적립</p>
		<div class="birth_img">Happy Birthday e머니 500포인트</div>
		<a  class="btn_join" id="bitrhdayStamp" >신청하기</a>
		
		
		<div class="birthday__cont">
                    <!-- 20190918 : 추가 -->
                    <div class="inner">
						<div class="txt_box">
							<ul>
                                <li><strong>이벤트 기간 <span class="point">:</span></strong> <%= dateFormatter.format(prevFormat.parse(startDate)) %> ~ <%= dateFormatter.format(prevFormat.parse(endDate)) %> </li>
								<li><strong>경품 지급일 <span class="point">:</span></strong> <%= dateFormatter.format(prevFormat.parse(dday)) %>  </li>
							</ul>
						</div>
                    </div>
                    <!-- // -->
                    
					<!-- 유의사항 WRAPPER -->
					<div class="caution-wrap">
						<a href="javascript:void(0);" class="btn_caution">꼭! 확인하세요</a>
						<!-- 생일이벤트 유의사항 -->
						<div class="moreview">
                            <!-- 20190918 : 유의사항 수정 -->
							<h4>생일이벤트 유의사항</h4>
							
							<div class="txt">
								<strong>이벤트 및 구매기간</strong>
								<ul class="txt_indent">
									<li><%= dateFormatter.format(prevFormat.parse(startDate)) %> ~ <%= dateFormatter.format(prevFormat.parse(endDate)) %></li>
								</ul>

								<strong>이벤트 대상 및 혜택</strong>
								<ul class="txt_indent">
									<li><b>이벤트 대상: 스탬프 1회 이상 참여자 중 4월 생일인 회원 대상</b></li>
									<li><b>이벤트 경품: e머니 500점</b></li>
									<li><b>경품 지급일: <%= dateFormatter.format(prevFormat.parse(dday)) %> </b></li>
									<li><b class="stress">e머니 유효기간 : 적립일로부터 15일</b>
										<br>※ 적립된 e머니는 e쿠폰 스토어에서 교환가능합니다.</li>
								</ul>

								<strong>참여방법 및 유의사항</strong>
								<ul class="txt_indent">
                                    <li>참여방법: 에누리 가격비교 로그인 → 적립대상 쇼핑몰 이동 → <span class="stress">1만원 이상 구매</span> → 스탬프 1회 이상 참여 → 이벤트 응모</li>
									<li>적립대상 쇼핑몰: G마켓, 옥션, 11번가, 인터파크, 티몬, 위메프, 쿠팡, GS SHOP, CJmall, SSG (신세계몰, 신세계백화점, 이마트몰, 트레이더스), SK스토아</li>
									<li>해당 이벤트는 본인인증 및 생년월일 정보 활용 동의 후 참여 가능합니다.</li>
									<li>생년월일은 본인인증시 수집된 생일을 기준으로 하며, 이후 임의 변경시 변경된 생일은 반영되지 않습니다. (부정참여로 간주)</li>
									<li>생일자 대상 이벤트는 연간 1회만 참여 가능합니다.</li>
									<li><b class="stress">경품지급 제외:</b> 참여한 스탬프가 아래 사유에 해당될 경우 경품 지급대상에서 제외됩니다.
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
								<strong>아래의 경우에는 구매 확인 및 적립이 불가합니다.</strong>
								<strong>유의사항</strong>
								<ul class="txt_indent">
									<li>부정 참여 시 적립이 취소될 수 있습니다.</li>
									<li>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</li>
								</ul>

								<a href="javascript:///" class="btn_caution_hide">확인</a>
							</div>
							
						</div>
						<!-- //생일이벤트 유의사항 -->
					</div>
					<!-- //유의사항 WRAPPER -->
				</div>
		
	</div>
</div>
<div id="evt2" class="comeback">
	<div class="contents">
		<h2>컴백! 오랜만 이에요!</h2>
		<p class="blind">구매만 하면 무조건! 맥카페 아이스커피가 공짜!</p>
		<div class="comeback_img">맥카페 아이스커피 e머니 1,500포인트</div>
		<a class="btn_join" id="comebackbuyClk" >신청하기</a>
		
		<div class="comeback__cont">
			<div class="inner">
				<div class="txt_box">
					<ul>
						<li><strong>이벤트 대상 <span class="point">:</span></strong> 2020년 2월 1일 이후<br> 구매이력 없는 회원 대상</li>
						<li><strong>유 의 사 항 <span class="point">:</span></strong> 경품은 해당 e쿠폰으로 교환할 수 있는<br> e머니로 지급됩니다.</li>
					</ul>
				</div>
			</div>
			
			<!-- 유의사항 WRAPPER -->
			<div class="caution-wrap">
				<a href="javascript:///" class="btn btn_caution">꼭! 확인하세요</a>
				
				<!-- 컴백혜택 유의사항 -->
				<div class="moreview">
					<h4>컴백혜택 유의사항</h4>
					
					<div class="txt">
								<strong>당첨자 혜택</strong>
								<ul class="txt_indent">
									<li><b>이벤트 경품: 맥카페 프리미엄 로스트커피 Medium(e머니 1,500점)</b>
										<br>※ 적립된 e머니는 e쿠폰 스토어에서 교환가능합니다.</li>
									<li><b class="stress">e머니 유효기간 : 적립일로부터 15일</b></li>
								</ul>
								<strong>이벤트 대상</strong>
								<ul class="txt_indent">
									<li>2016년 2월 1일 이후 에누리 앱을 통하여 구매 및 적립이력 있으나, <span>2020년 2월 1일</span> 이후 구매이력 없는 회원 대상</li>
									<li>아래의 경우에는 이벤트 대상에 해당되지 않습니다<br>
										- 2016년 2월 1일~2020년 2월 29일 기간 내 구매이력 없는 회원<br>
										- <span>2020년 2월 1일</span> 이후 가입한 회원(신규가입자)<br>
										- <span>2020년 2월 1일</span> 이후 구매이력 있는 회원
									</li>
								</ul>
								<strong>참여방법 및 유의사항</strong>
								<ul class="txt_indent">
                                    <li>참여방법: 에누리 가격비교 로그인 → 적립대상 쇼핑몰 이동 → <span class="stress">1,000원 이상 구매</span> → 이벤트 참여</li>
									<li>ID당 1회 참여 가능.</li>
                                    <li>구매 후 30일 이내에만 신청할 수 있으며, 신청하면 최대 30일 이내에 자동적립됩니다.<br>
                                        ※ 해외직구 상품 구매시 최대 70일 소요됩니다.
                                    </li>
									<li>구매 및 신청 후 취소/환불/교환/반품한 경우 경품 지급 대상에서 제외됩니다.</li>
									<li>구매확정금액은 배송비, 설치비, 할인, 쇼핑몰 포인트 등 제외한 상품 결제금액만 반영됩니다.</li>
									<li>적립대상 쇼핑몰: G마켓, 옥션, 11번가, 인터파크, 티몬, 위메프, 쿠팡, GS SHOP, CJmall, SSG (신세계몰, 신세계백화점, 이마트몰, 트레이더스), SK스토아</li>
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
								<a href="javascript:///" class="btn_caution_hide">확인</a>
							</div>
				</div>
				<!-- //무제한적립 유의사항 -->
			</div>
			<!-- //유의사항 WRAPPER -->
		</div>
	</div>
</div>
<!-- 180417 생일이벤트 본인인증 레이어 --> 
<div class="birthday_layer" id="birthdayPrivacyComp" style="display:none">
	<div class="inner_layer">
		<a href="javascript:///" class="stripe_layer close" onclick="onoff('birthdayPrivacyComp')">창닫기</a>

		<div class="viewer">
			<p class="birthdayPrivacy__info">본인인증 후<br />신청하실 수 있습니다.
		</div>
		<button type="button" class="birthdayPrivacy__close" onclick="onoff('birthdayPrivacyComp');window.open('https://m.enuri.com/mobilefirst/member/myAuth.jsp?userid=<%=cUserId%>&freetoken=login_title');">본인 인증하기</button>
	</div>
</div>
<!-- //180417 생일이벤트 본인인증 레이어 --> 
<!-- 180417 생일이벤트 신청하기 레이어 --> 
<div class="birthday_layer" id="birthdayPrivacy" style="display:none">
	<div class="inner_layer">
		<h3 class="tit">생일 이벤트 신청하기!</h3>
		<a href="javascript:///" class="stripe_layer close" onclick="onoff('birthdayPrivacy')">창닫기</a>

		<div class="viewer">
			<!-- 개인정보 -->
			<div class="birthdayPrivacy__area">
				<p class="u">개인정보 수집·이용안내</p>
				<dl>
					<dt>1. 개인정보 수집 및 이용 목적</dt>
					<dd>- 생일 이벤트 대상 확인을 위해 수집되며, <br />&nbsp;&nbsp; 이 외의 목적으로 활용되지 않습니다.</dd>
					<dt>2. 개인정보 수집 항목</dt>
					<dd>- 생년월일</dd>
					<dt>3. 개인정보 보유 및 이용 기간</dt>
					<dd>- 회원탈퇴 또는 동의철회 시 파기</dd> 
   					<dd>- 이벤트 참여일로부터 종료시까지 보관 후 파기</dd>
				</dl>
			</div>
			<!-- //개인정보 -->
			
			<p class="birthdayPrivacy__ipt"><label><input type="checkbox" class="chkbox" name ="bitrhdayChk" id="" checked>이벤트 참여를 위한 개인정보 활용에 동의합니다.</label></p>
		</div>
		<button type="button" class="birthdayPrivacy__close"  id="bitrhdayStamp_ins">신청 완료</button>
	</div>
</div>
<!-- //180417 생일이벤트 신청하기 레이어 --> 
<script type="text/javascript">
(function() {
	var stampInfo = {
			startDate : "20200401",
			endDate : 	"20200503"		
			};
	var isClick = true;
	$("#bitrhdayStamp").click(function(e){
		
		if(<%=sdt%> > stampInfo.endDate){
			alert('이벤트 종료!\n다음 이벤트는\n곧 오픈 예정입니다.');
		}else if(!islogin()){
			goLogin();
		}else{
			if(!isClick)				return false;
			isClick = false;
			
			$.post("/mobilefirst/evt/ajax/ajax_birthdayStamp_proc.jsp",{procCode : 1,  sdt : <%= sdt %> , osType:"M" ,  ostpcd : getOsType() }, function(json){
				var result = json.chkValue;
				
			    switch(result) {
			        case 1 :
			        	onoff('birthdayPrivacy');
			            break;
			        case -1 :
			            alert("이미 신청해주셨습니다!");
			            break;
			        case -2 :
			            alert("구매 스탬프에 1회 이상 참여 후 신청 가능합니다!");
			            break;
			        case -3 :
			    		onoff('birthdayPrivacyComp');
			            break;
			        case -4 :
			            alert("아쉽지만, 이벤트 대상에 해당하지 않습니다!");
			            break;
			        case -5 :
			        	alert("SDU 회원은 본인인증 후 참여 가능합니다.\n※ 본인인증은 ‘앱 설정 > 본인인증’ 또는 ‘PC >\n개인정보관리 화면’을 이용해주세요");
			            break;
			        case -6 :
			        	var r = confirm("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?");
						if(r){
							location.href = "https://m.enuri.com/mobilefirst/member/myAuth.jsp?cmdType=&f=m&freetoken=login_title";
						}
			            break;
			        case -99 :
			        	alert("임직원은 참여 불가합니다.");
			            break;
			        
			        default :
			            alert("아쉽지만, 이벤트 대상에 해당하지 않습니다!");
			            break;
			    }
			},"json")
			.done(function(){
				isClick = true;
			});
		}
	});
	$("#bitrhdayStamp_ins").click(function(e){
		if(!$("input:checkbox[name=bitrhdayChk]").prop("checked")) {
			alert("개인정보 활용에 동의해주세요.");
			return false;
		}
		$.post("/mobilefirst/evt/ajax/ajax_birthdayStamp_proc.jsp",{ procCode : 2,  sdt : <%= sdt %>  , osType:"M" ,  ostpcd : getOsType()  }, function(json){
			var result = json.insertResult;
			
			if(json.chkValue == -99){
				alert("임직원은 참여 불가합니다.");
				return false;
			}
			
			if(result) {
				alert("신청완료!\n이번 달 생일을 축하드립니다^^");
			} else {
				alert("잘못된 접근입니다.");
			}
			onoff('birthdayPrivacy');
		},"json");
	});
	
	var itemNm = "맥카페 프리미엄 로스트커피(e머니 1,500점)";
	//컴백구매 버튼클릭
	$("#comebackbuyClk").click(function(e){
		//if(getCookie("appYN")!='Y'){
		//	onoff('app_only');
		//	return false;
		//}
		if(!islogin()) {
		    alert("로그인 후 참여할 수 있습니다.");
		    goLogin();
		    return false;
		}
		if(!isClick){
			return false;
		}
		isClick = false;
		var result=0; //대상자 체크
		$.ajax({
			type: "POST",
			url: "/mobilefirst/evt/ajax/ajax_welcomechk_v2.jsp?ostpcd="+getOsType(),
			dataType: "JSON",
			success:function(json){
				result = json.result;
				if(result==0 || result>5){
					alert("아쉽지만 이벤트 대상이 아닙니다!");
				}else if(result==-1){
					alert("잘못된 접근입니다.");
				}else if(result==-2){
					alert("아쉽지만 이벤트 대상이 아닙니다!");
				}else if(result==1){
					alert('이미 참여하셨습니다!');
				}else if(result==2){
					alert("구매 후 신청해주세요!");
				}else if(result==3){
					alert('구매해주셔서 감사합니다. \n\n아쉽지만 구매금액이 1천원 미만이면\n혜택을 받을 수 없습니다.');
				}else if(result==4){
					alert('신청완료! \n\n구매적립 후 e머니가 지급됩니다!\n(취소/반품/환불시 제외)');
				}else if(result==5){
					alert('축하드립니다! \n\n E머니가 지급되었습니다!\nMy 적립된 E머니는 My 적립 내역에서 확인해주세요');
					getPoint();
				}else if(result==-3){
					alert("중복 휴대폰번호로 참여 불가능합니다.");
				}else if(result==-4){
					alert("SDU 회원은 본인인증 후 참여 가능합니다.\n※ 본인인증은 ‘앱 설정 > 본인인증’ 또는 ‘PC >\n개인정보관리 화면’을 이용해주세요");
				}else if(result==-5){
					var r = confirm("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?");
					if(r){
						location.href = "https://m.enuri.com/mobilefirst/member/myAuth.jsp?cmdType=&f=m&freetoken=login_title";
					}
				}else if(result==-99){
					alert("임직원은 참여 불가합니다.");
				}
			}, complete : function() {
				isClick=true;
			}
		});
	});
}());
(function (global, $) {
	// 상단 메뉴 스크롤 시, 고정
	var $nav = $('.floattab'),
		$menu = $('.floattab__list li'),
		$contents = $('.scroll'),
		$navheight = $nav.outerHeight(), // 상단 메뉴 높이
		$navtop = Math.ceil($nav.offset().top); // floattab 현재 위치; 

	// menu class 추가 
	$(window).scroll(function () {
		var $scltop = Math.ceil($(window).scrollTop());	// 현재 scroll

		if ($scltop > $navtop) {
			$nav.addClass("is-fixed");
			$(".visual").css("margin-bottom", $navheight);
		} else {
			$nav.removeClass("is-fixed");
			$(".visual").css("margin-bottom", 0);
		}
	});
}(window, window.jQuery));
// 유의사항 드롭다운
$('.btn_caution').click(function(){
	var _this = $(this);
	_this.siblings(".moreview").toggle();
	
	$(".btn_caution_hide").click(function(){
		$(this).parents(".moreview").slideUp();
		$('html,body').stop().animate({scrollTop:_this.offset().top - 71});
		return false;
	})
});
//레이어
function onoff(id) {
	var mid=document.getElementById(id);
	if(mid.style.display=='') 		mid.style.display='none';
	else		mid.style.display='';
}
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
</script>