<div class="benefit" id="event_bottom">
     <!-- e머니 적립 -->
	<div class="com_event_benefit">
		<div class="com_event__inner">
			<h3 class="blind">에누리에서 구매하고 현금같은 e머니 적립 받으세요!</h3>
			<div class="com_benefit_slide swiper-container">
				<div class="swiper-wrapper">
					<div class="swiper-slide">
						<img src="http://img.enuri.info/images/event/2020/common/m_com_evt_ben_slide_01.png" alt="STEP1. 에누리 앱에서 로그인 후 적립대상 쇼핑몰 이동하기">
					</div>
					<div class="swiper-slide">
						<img src="http://img.enuri.info/images/event/2020/common/m_com_evt_ben_slide_02.png" alt="STEP2. 상품 구매하기">
					</div>
					<div class="swiper-slide">
						<img src="http://img.enuri.info/images/event/2020/common/m_com_evt_ben_slide_03.png" alt="STEP3. 구매금액의 최대 1.5% E머니 적립!">
					</div>
					<div class="swiper-slide">
						<img src="http://img.enuri.info/images/event/2020/common/m_com_evt_ben_slide_04.png" alt="STEP4. e쿠폰 스토어에서 1,000여가지의 인기 e쿠폰으로 교환가능!">
					</div>
				</div>
				<div class="swiper-button-prev btn_prev"></div>
				<div class="swiper-button-next btn_prev"></div>
			</div>
			<div class="swiper-pagination"></div>
			<!-- 유의사항 버튼 -->
                  <a href="#appinfo" class="btn_com_benefit_noti btn__evt_notice on" data-laypop-id="appinfo">유의사항</a>        
		</div>
		<script>
			$(function(){
				var mySwiper = new Swiper('.com_benefit_slide',{
					prevButton : '.swiper-button-prev',
					nextButton : '.swiper-button-next',
					pagination : '.com_event__inner .swiper-pagination',
					speed : 1000,
					loop : true,
					paginationClickable : true
				});
				
				var el = {
						btnSlide: $(".btn__evt_notice"), // 열기 버튼
						btnSlideClose : $(".btn__evt_confirm") // 닫기 버튼
					}
					el.btnSlide.click(function(){ // 슬라이드 유의사항 열기
						$(this).toggleClass('on');
						$("#"+$(this).attr("data-laypop-id")).slideToggle();
					})
					el.btnSlideClose.click(function(){ // 슬라이드 유의사항 닫기
						var thisClosest = $(this).closest('.evt_notice--slide')
						$(thisClosest).slideToggle();
						$('html,body').stop(0).animate({scrollTop:$(thisClosest).siblings(".com__evt_notice").offset().top - 50});
					})
				
			});
			
		</script>
	</div>
	
	<div id="appinfo" class="evt_notice--slide">
		<div class="evt_notice--inner">
			<div class="evt_notice--head">유의사항</div>
			<!-- 200608 유의사항 문구 수정 -->
			<div class="evt_notice--cont">
				<div class="txt">
					<strong>e머니 구매적립 기준 및 유의사항</strong>
					<ul class="txt_indent">
						<li>적립 방법 : 에누리 가격비교 모바일 앱 로그인 &rarr; 적립대상 쇼핑몰 이동 &rarr; <span class="stress">1천원 이상 구매</span> &rarr; 구매확정(배송완료) 시 e머니 적립</li>
						<li>적립대상 쇼핑몰: G마켓, 옥션, 11번가, 인터파크, 티몬, 위메프, 쿠팡, GS SHOP, CJmall, SSG (신세계몰, 신세계백화점, 이마트몰, 트레이더스), 에누리 해외직구관, SK스토아, 홈플러스<br/>
							<span class="stress">※ 티몬 및 에누리 해외직구관의 경우 PC 및 모바일 앱/웹에서 로그인 후 구매시에도 구매적립 가능합니다.</span></li>
						<li>구매적립 e머니는 구매일로부터 10 ~ 30일간 취소/환불/교환/반품여부 확인 후 적립 됩니다.</li>
						<li><span class="stress">구매적립 e머니 유효기간 : 적립일로부터 60일 (유효기간 만료 후 재적립 불가)</span><br/>
							 ※ 적립된 e머니는 e쿠폰 스토어에서 다양한 쿠폰으로 교환가능합니다.</li>
						<li>구매적립 e머니는 최소 10점(구매금액 1천원 이상)부터 적립되며, 1원 단위 e머니는 적립되지 않습니다.</li>
						<li>구매적립 e머니는 구매확정(구매일로부터 최대 30일) 시점부터 MY 에누리 적립내역 페이지에서 확인 가능합니다.</li>
						<li>구매금액은 배송비, 설치비, 할인, 쇼핑몰 포인트 등 제외한 금액만 반영됩니다. </li>
						<li>적립대상 쇼핑몰에서 장바구니에 여러 상품을 담아 한 번에 결제하는 경우 구매건수는 1건이며 구매금액은 통합된 금액으로 e머니 적립 됩니다.</li>
						<li>구매적립 e머니는 카테고리별 차등 적립됩니다. <br/>※ 카테고리별 적립률 
							<div class="tb">
								<table>
									<colgroup>
										<col width="70%" /><col width="30%" />
									</colgroup>
									<tbody>
										<tr>
											<th>카테고리</th>
											<th>적립률</th>
										</tr>
										<tr>
											<td>유아,완구</td>
											<td>1.5%</td>
										</tr>
										<tr>
											<td>식품/스포츠,레저/자동차/화장품</td>
											<td>1.0%</td>
										</tr>
										<tr>
											<td>컴퓨터/도서/문구,사무/PC부품</td>
											<td>0.8%</td>
										</tr>
										<tr>
											<td>디지털/영상,디카</td>
											<td rowspan="4">0.3%</td>
										</tr>
										<tr>
											<td>가전(생활,주방,계절)</td>
										</tr>
										<tr>
											<td>패션/잡화</td>
										</tr>
										<tr>
											<td>가구,인테리어</td>
										</tr>
										<tr>
											<td>생활,취미</td>
											<td rowspan="2">0.2%</td>
										</tr>
										<tr>
											<td>모바일쿠폰,상품권<br/>
												<p style="font-size:10px;margin-top:4px;color:#e91030">*특정 상품에 한하여 적립되오니<br/>적립가능 상품은 하단에서 확인해주세요.</p>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</li>
					</ul>
	
					<strong class="stress">[모바일쿠폰,상품권 ] 구매적립 기준</strong>
					<ul class="txt_indent">
						<li>적립가능 쇼핑몰 : <%if(numSdt < 20201101){ %>티몬,<%} %> G마켓, 옥션 <%if(numSdt > 20201030){ %>,인터파크<%} %></li>
						<%if(numSdt < 20201101){ %><li><span class="stress">※ 2020년 11월 1일부터 티몬 상품권 e머니 구매적립이 종료될 예정입니다.</span></li><%} %>
						<li>적립가능 상품 (0.2% 적립) : 문화상품권(해피머니, 컬쳐랜드), 도서상품권, 백화점상품권, 영화예매권, 국민관광 상품권</li>
						<li>백화점상품권 기준 상세 
							<ul>
								<li>1) 상품명에 '백화점 상품권' 명시된 상품 또는 백화점에서만 사용할 수 있는 상품권만 적립가능</li>
								<li>2) 복합상품권 적립불가 (삼성 상품권, 신세계 기프트카드, 롯데카드 상품권, 이랜드 상품권, AK플라자 상품권, 통합 상품권 등)<br/>
									- 복합 상품권의 경우 사용처에 백화점이 기재되어 있는 경우에도 적립불가</li>
								<li>3) 백화점 상품권으로 전환 가능한 포인트 구매 시 적립불가</li>
							</ul>
						</li>
					</ul>
					
					<strong>적립대상 쇼핑몰 중 구매적립 제외 카테고리 및 서비스</strong>
					<ul class="txt_indent">
						<li>에누리 가격비교에서 검색되지 않는 상품</li>
						<li>모바일쿠폰,상품권 : 상품권, 지역쿠폰, e교환권, e쿠폰 등 </li>
						<li>쇼핑몰 제휴 서비스(배달, 티켓, 해외직구 등) 및 일부 카테고리<br/>
							<ul>
								<li>- G마켓 : 중고장터, 실시간 여행, 항공권, 도서/음반, 모바일쿠폰/상품권(일부 적립가능)</li>
								<li>- 옥션 : 중고장터, 실시간 여행, 항공권, 모바일쿠폰/상품권(일부 적립가능)</li>
								<li>- 11번가 : 여행/숙박/항공, 모바일쿠폰/상품권</li>
								<li>- 인터파크 : 라이프 서비스(티켓, 투어, 아이마켓 등), 모바일쿠폰/상품권<%if(numSdt > 20201030){ %>(일부 적립가능)<%} %> </li>
								<li>- 티몬 : 특가 판매 상품(슈퍼꿀딜, 슈퍼마트 등), 모바일쿠폰/상품권<%if(numSdt < 20201101){ %>(일부 적립가능 <span class="stress">※2020년 11월 1일부터 적립불가</span> )<%} %></li>
								<li>- 위메프 : 모바일쿠폰/상품권</li>
								<li>- GS SHOP, CJmall : 모바일쿠폰/상품권</li>
								<li>- SSG : 도서/음반/문구/취미/여행, 모바일쿠폰/상품권</li>
							</ul>
						</li>							
					</ul>
					<strong>공통 구매 유의사항</strong>
					<ul class="txt_indent">
						<li><b style="display:block;margin-bottom:4px">아래의 경우에는 구매 확인 및 구매적립이 불가합니다.</b>
							<ul>
								<li>- 에누리 가격비교 모바일 앱이 아닌 다른 모바일 앱을 통해서 장바구니 또는 관심상품 등록 후 에누리 가격비교 모바일 앱으로 결제만 한 경우</li>
								<li>- 에누리 가격비교 미 로그인 후 구매한 경우</li>
								<li>- 에누리 가격비교 PC 및 모바일 웹에서 구매한 경우 (※ 티몬 및 에누리 해외직구관은 PC 및 모바일 앱/웹 구매 시에도 가능)</li>
							</ul>
						</li>
					</ul>
				</div>
			</div>
			<!-- // -->
			<div class="evt_notice--foot">						
				<button class="btn__evt_confirm">확인</button> <!-- 닫기 : 유의사항 닫기 -->
			</div>
		</div>
	</div>
	

	<!-- e머니 스페셜 적립 이벤트 -->
	<%if( Integer.parseInt(sdt) > 20201005 &&  Integer.parseInt(sdt) < 20201229  ) {%>
	<div class="com_event_special">
		<div class="com_event__inner">
			<h3 class="blind">e머니 스페셜 적립 이벤트</h3>
			<div class="tab_event">
				<a href="javascript:void(0);" class="tab-item" data-tab-index="1">쿠팡</a>
				<!-- <a href="javascript:void(0);" class="tab-item" data-tab-index="2">티몬</a> -->
				<!-- <a href="javascript:void(0);" class="tab-item" data-tab-index="3">스토어팜</a> -->
			</div>
			<div class="tab_cnt swiper-container">
				<div class="swiper-wrapper">
					<div class="swiper-slide">
						<a href="http://m.enuri.com/mobilefirst/event2019/coupangevt.jsp" title="클릭시 새창이 열립니다." target="blank"><img src="http://img.enuri.info/images/event/2020/common/m_com_evt_special_coupang_oct.png" alt="에누리 앱을 경유하여 쿠팡에서 구매 시 e머니로 적립해 드립니다. 최대 5% 적립"></a>
					</div>							
				</div>						
			</div>
			<!-- 
			<div class="swiper-pagination"></div>
			 -->
		</div>
	</div>
	<!-- // -->
	<%} %>
     
      <!-- 스토어 인기브랜드 -->
	<div class="goos_zone" id="popular_store" style="display: none;">
        <h3>스토어 인기브랜드</h3>
    	<ul class="bef_goos" id="benefit_list"></ul>         
	</div>
    <!-- 스토어 인기브랜드 -->
	    
    <!--// 생활혜택 -->
    <!-- 인기 키워드 기획전 -->
    <div class="keyword" id="life_benefits" style="display: none;">
        <h2>e머니로 누리는 생활혜택</h2>
        <div class="innder_scroll">
            <ul class="swiper-wrapper thumb"></ul>
        </div>
    </div>
    <!--// 인기 키워드 기획전 -->
</div>
<script>
	$(function(){
		var url = window.location.href;
		var urlArr = ['visit_event','welcome_event','smart_benefits','birthday_event'];
		for(var i=0; i<urlArr.length; i++){
			if(url.indexOf(urlArr[i]) > -1){
				getPlanBanner(); // 기획전
				getBI_random();
				$("#popular_store").show();
				$("#life_benefits").show();
				
				break;
			}
		}
		
	});
</script>