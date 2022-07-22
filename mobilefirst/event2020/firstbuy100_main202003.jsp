<%
String pd = ChkNull.chkStr(request.getParameter("pd"));
%>

<!-- 이벤트01 -->
	<div id="evt1" class="section evt_1st scroll">
		<div class="contents">
            <h2><img src="http://img.enuri.info/images/event/2019/w100deal/m_sec1_tit.png" alt="첫구매 전용! 100원딜"></h2>
			<ul class="deal_list"></ul>
			<!-- 페이백 신청하기 -->
			<!-- <a href="#" onclick="onoff('app_only');return false;" class="btn_payback">페이백 신청하기</a> -->
			<a href="javascript:///" id="firstbuyClk" class="btn_payback">페이백 신청하기</a>
			<!-- // -->
		</div>
		
		<div class="event_noti">
			<div class="noti_cnt">
				<ul>
					<li>
						· 대상자: 에누리 모바일 앱에서 구매이력 없는 회원 대상<br>
						<span class="noti_y">※ 구매한 기기와 ID 모두 '첫구매'일 경우만 해당</span>
					</li>
					<li>
						· 참여방법<br>
						1. 모바일 앱 &gt; 로그인 &gt; 100원딜 상품 구매 <br>&nbsp;&nbsp;&gt; [페이백 신청] 버튼 클릭<br>
						<span class="noti_y">&nbsp;&nbsp;※ 100원 딜 상품 외에도 앱에서 1만원 이상 구매시 신청가능</span><br>
						<!--  2. 마이 에누리 &gt; 적립내역에서 '적립받기' 버튼 클릭 <br>&nbsp;&nbsp;&gt; 구매적립 완료 <br>-->
						2. 구매일로부터 최대 30일 이내에 페이백 지급 
						<!-- <span class="noti_y">&nbsp;&nbsp;※ 구매한 날로부터 최대 30일이내에 적립받기 버튼생성</span> -->
					</li>
					<li>
						· 적립대상 쇼핑몰: G마켓, 옥션, 11번가, 인터파크, 티몬, 위메프,</br>쿠팡, GS SHOP, CJmall, SSG , SK스토아
					</li>
					<li>
						· 페이백 적립 : 구매일로부터 30일 이내에 9,900점 적립 <br>(유효기간: 적립일로부터 30일)<br>
						<span class="noti_y">※ 친구초대 첫구매 혜택과 중복 참여 및 지급불가</span>
					</li>
				</ul>
			</div>
		</div>
	</div>
	
	<div class="caution-wrap">
		<a href="javascript:///" class="btn-caution" onclick="$(this).toggleClass('on');return false;">
			<span class="txt-caution-wrap">
				<span class="txt-caution-tit">유의사항을 꼭! 확인하세요</span>
			</span>
		</a>
		
		<div class="moreview">
			<div class="txt">
				<dl class="txtlist">
					<dt>이벤트 대상자 및 혜택</dt>
					<dd><strong>이벤트 대상:</strong> 에누리 모바일 앱에서 구매이력 없는 회원 대상</dd>
					<dd class="emp"><strong class="emp">페이백 적립:</strong> 구매일로부터 30일 이내에 9,900점 적립 (해외직구 상품 구매시 최대 70일 소요)</dd>
					<dd><strong class="emp">E머니 유효기간: 적립일로부터 30일 (유효기간 만료 후 재적립 불가)</strong>※ 적립된 e머니는 e쿠폰 스토어에서 다양한 쿠폰으로 교환가능합니다.</dd>
				</dl>
				
				<dl class="txtlist">
					<dt>이벤트 참여방법</dt>
					<dd class="num">1. 에누리 모바일 앱 &gt; 로그인 &gt; 100원딜 상품 구매 &gt; [페이백 신청] 버튼 클릭<br>
						<span class="emp">※ 100원딜 상품 외에도 앱에서 1만원 이상 구매시 신청가능</span>
					</dd>
					<dd class="num">2. 구매일로부터 최대 30일 이내에 페이백 지급 <strong class="emp">(해외직구 상품 구매시 최대  70일 소요)</strong></dd>
					<!-- 191219 유의사항 수정 -->
					<dd>적립대상 쇼핑몰: G마켓, 옥션, 11번가, 인터파크, 티몬, 위메프,<br>쿠팡, GS SHOP, Cjmall, SSG (신세계몰, 신세계백화점, 이마트몰, 트레이더스), SK스토아</dd>
					<!-- // -->
					<dd>1만원 이상 구매금액은 배송비, 설치비, 할인, 쇼핑몰 포인트 등 제외한 상품의 실제 결제금액만 반영됨</dd>
				</dl>
	
				<dl class="txtlist">
					<dt>이벤트 유의사항</dt>					
					<dd>ID당 1회 참여가능</dd>
					<dd>모바일 앱에서 첫구매일 경우에만 참여 가능</dd>
					<dd>본인인증 및 이벤트 정보동의 후 참여가능</dd>
					<dd>본인인증, 첫구매, 이벤트 신청의 단계를 <span class="emp">모두 동일한 기기에서 진행시에만 참여가능</span> (1개의 ID로 각기 다른 기기에서 진행한 경우 참여 불가)</dd>
					<dd>인터파크 상품권의 경우 100원딜에 노출된 상품만 구매적립되며, 그 외 인터파크 상품권은 적립제외 상품으로 이벤트 대상에서 제외</dd>
					<dd><strong class="emp">100원딜 혜택은 ‘초대 첫구매‘ 혜택과 중복지급 불가 (초대 첫구매 혜택을 받으신 경우 100원딜 페이백 참여불가)</strong></dd>
				</dl>
				
				<dl class="txtlist">
					<dt><strong class="emp">※ 경품지급 제외: </strong>아래의 경우 경품 지급대상에서 제외됩니다.</dt>
					<dd>구매한 실제 결제금액이 1만원 미만의 구매일 경우</dd>
					<dd>e머니 적립 제외 카테고리의 상품 구매일 경우</dd>
					<dd>이벤트 참여 후 취소/환불/교환/반품한 경우 (취소 후 30일 이내에 재구매 및 90일 이내에 구매적립 받은 경우에는 지급가능)</dd>
					<dd>본인인증값이 동일할 경우</dd>
 				</dl>
	
				<dl class="txtlist">
					<dt>아래의 경우에는 구매 확인 및 적립이 불가합니다.</dt>
					<dd>에누리 가격비교 앱이 아닌 다른 앱을 통해서 장바구니 또는 관심상품 등록 후 에누리 가격비교 앱으로 결제만 한 경우<br>(에누리 가격비교 앱을 통해 쇼핑몰로 이동 후 장바구니/관심상품 등록 후 구매 시에는 가능)</dd>
					<dd>에누리 가격비교 앱 미 로그인 후 구매한 경우 또는 에누리 가격비교 PC, 모바일 웹에서 구매한 경우</dd>
				</dl>
				
					
					<div style="padding:15px 10px 5px">
						<strong>모바일쿠폰, 상품권 적립 상세</strong>
						<ul class="txt_indent">
							<li>적립가능 쇼핑몰 : 티몬, G마켓, 옥션</li>
							<li>적립가능 상품 (0.2% 적립): 문화상품권(해피머니, 컬쳐랜드), 도서상품권, 백화점상품권, 영화예매권, 국민관광 상품권</li>
							<li>적립가능 상품을 제외한 상품권, 지역쿠폰, e교환권, e쿠폰은 적립불가</li>
							<li style="background:none;">
								<strong class="stress">※ 백화점 상품권 적립기준</strong>
								<ul>
									<li>1) 상품명에 '백화점 상품권' 명시된 상품 또는 백화점에서만 사용할 수 있는 상품권만 적립</li>
									<li>2) 복합상품권 적립불가(삼성 상품권/신세계 기프트카드/롯데카드 상품권/이랜드 상품권/AK플라자 상품권/통합 상품권 등)</li>
									<li>3) 복합 상품권의 경우 사용처에 백화점이 기재되어 있는 경우에도 적립불가</li>
									<li>4) 백화점 상품권으로 전환 가능한 포인트 구매시 적립불가</li>
								</ul>
							</li>
						</ul>
						
						<strong>적립대상쇼핑몰 중 e머니 적립 제외 카테고리/서비스 </strong>
						<ul class="txt_indent">
							<li>에누리 가격비교 앱에서 검색되지 않는 상품</li>
							<li>인터파크: 모바일쿠폰/상품권, 라이프 서비스(티켓, 투어, 아이마켓 등)</li>
							<li>11번가: 여행/숙박/항공, 모바일쿠폰/상품권 전체</li>
							<li>G마켓: 중고장터, 실시간 여행, 항공권, 도서/음반, 모바일쿠폰/상품권(일부 상품권 적립가능)</li>
							<li>옥션: 중고장터, 실시간 여행, 항공권, 모바일쿠폰/상품권(일부 상품권 적립가능)</li>
							<li>SSG: 도서/음반/문구/취미/여행, 모바일쿠폰/상품권 전체</li>
							<li>티몬: 슈퍼꿀딜, 슈퍼마트 등 특가 판매 상품, 모바일쿠폰/상품권(일부 상품권 적립가능)</li>
							<li>위메프: 모바일쿠폰/상품권 전체</li>
							<li>CJ몰/GSSHOP: 모바일쿠폰/상품권 전체</li>
							<li>모바일쿠폰/상품권: 상품권, 지역쿠폰, e교환권, e쿠폰 등 (문화상품권, 도서상품권, 백화점상품권, 영화예매권, 국민관광상품권은 적립 가능)</li>
							<li>이 외 쇼핑몰에 입점한 제휴 서비스(배달, 티켓, 해외직구 등) 및 일부 카테고리 제외</li>
						</ul>	
					</div>			
					
				
				<dl class="txtlist">
					<dt>유의사항</dt>
					<dd>부정 참여 시 적립이 취소 및 사이트 사용이 제한될 수 있습니다.</dd>
					<dd>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</dd>
				</dl>

				<a href="javascript:///" class="btn_check_hide">확인</a>
			</div>
		</div>
		
	</div>
	<div class="event_join">
		<div class="contents">
			<h3><img src="http://img.enuri.info/images/event/2019/w100deal/m_event_tit.png" alt="100원딜 참여방법"></h3>
			<div class="swiper-wrap">
				<div class="swiper-container swiper-container-horizontal swiper-container-android">
					<div class="swiper-wrapper" style="transform: translate3d(-280px, 0px, 0px); transition-duration: 0ms;">
						<div class="swiper-slide"><img src="http://img.enuri.info/images/event/2019/w100deal/m_event_slide_01.jpg" alt=""></div>
						<div class="swiper-slide"><img src="http://img.enuri.info/images/event/2019/w100deal/m_event_slide_02.jpg" alt=""></div>
						<div class="swiper-slide"><img src="http://img.enuri.info/images/event/2019/w100deal/m_event_slide_04_0717.jpg" alt=""></div>
					</div>				
				</div>
				<!-- Add Arrows -->
				<div class="swiper-button-next btn_next swiper-button-white"></div>
				<div class="swiper-button-prev btn_prev swiper-button-white"></div>
			</div>
			<div class="swiper-pagination swiper-pagination-bullets"><span class="swiper-pagination-bullet"></span><span class="swiper-pagination-bullet swiper-pagination-bullet-active"></span><span class="swiper-pagination-bullet"></span><span class="swiper-pagination-bullet"></span></div>
			<script>
				var mySwiper = new Swiper(".event_join .swiper-container", {
					autoplay: 2800,
					speed : 800,
					loop : false,
					pagination : '.event_join .swiper-pagination',
					prevButton : '.event_join .swiper-button-prev',
					nextButton : '.event_join .swiper-button-next',
					slidesPerView : 'auto',
					watchActiveIndex: true,					
					spaceBetween : 0
				});
			</script>
		</div>
	</div>
	
	
	<div id="evt2" class="section evt_2nd scroll">				
		<div class="contents">
			<h3><img src="http://img.enuri.info/images/event/2020/w100deal/m_sec2_tit.png" alt="파워적립 - 첫구매 후 100일간 최대 6,000점"></h3>
			<div class="stamp_con">
				<ul id="powerList">
					<!-- 활성화 .on 붙여주세요 -->
					<li><span class="blind">500점 적립</span></li>
					<li><span class="blind">1,000점 적립</span></li>
					<li><span class="blind">1,000점 적립</span></li>
					<li><span class="blind">1,500점 적립</span></li>
					<li><span class="blind">2,000점 적립</span></li>
				</ul>
				<!-- <span class="txt_terms">나의 파워 적립 구매 기간 : <span class="txt_date">APP에서 확인하세요!</span></span> -->
				<span class="txt_terms">나의 파워 적립 구매 기간 : <span class="txt_date">**월 **일 까지</span></span>
			</div>
			<div class="event_noti">
				<div class="noti_cnt">
					<ul>
						<li>
							· 첫구매일로부터 100일간 앱에서 1만원 이상 구매시 추가적립
						</li>
						<li>
							· 대상자: 2020년 1월 1일 이후 100원딜 페이백 신청한 회원 대상
						</li>
						<li>
							· 참여방법<br>
							1. 에누리 모바일앱 &gt; 로그인 &gt; 적립대상 쇼핑몰 <br>&nbsp;&nbsp;&gt; 1만원 이상 구매하기<br>
							<!-- 
							2. 마이 에누리 &gt; 적립내역에서 [적립받기] 버튼 클릭 <br>&nbsp;&nbsp;&gt; 구매적립 완료 <br>
							<span class="noti_y">&nbsp;&nbsp;※ 구매한 날로부터 최대 30일이내에 적립받기 버튼생성</span><br>
							 -->
							2. 구매일로부터 최대 30일 이내에 파워적립 완료
						</li>
						<li>
							· 적립대상 쇼핑몰: G마켓, 옥션, 11번가, 인터파크, 티몬, 위메프,<br>쿠팡, GS SHOP, CJmall, SSG , SK스토아
						</li>
						<li>
							· 파워적립 : 구매적립 완료 다음날 파워적립 e머니 지급
						</li>
					</ul>
				</div>
			</div>
		</div>
		<!-- 이벤트 02 유의사항  -->
		<div class="caution-wrap">
			<a href="javascript:///" class="btn-caution" onclick="$(this).toggleClass('on');return false;">
				<span class="txt-caution-wrap">
					<span class="txt-caution-tit">유의사항을 꼭! 확인하세요</span>
				</span>
			</a>
			<!-- 유의사항 드롭다운 -->
			<div class="moreview">
				<div class="txt">
					<dl class="txtlist">
						<dt>이벤트 대상자 및 혜택</dt>
						<dd><strong>이벤트 대상:</strong> 에누리 모바일 앱에서 구매이력 없는 회원 대상</dd>
						<dd class="emp"><strong class="emp">페이백 적립:</strong> 구매일로부터 30일 이내에 9,900점 적립 (해외직구 상품 구매시 최대 70일 소요)</dd>
						<dd><strong class="emp">E머니 유효기간: 적립일로부터 30일 (유효기간 만료 후 재적립 불가)</strong>※ 적립된 e머니는 e쿠폰 스토어에서 다양한 쿠폰으로 교환가능합니다.</dd>
					</dl>
					
					<dl class="txtlist">
						<dt>이벤트 참여방법</dt>
						<dd class="num">1. 에누리 모바일 앱 &gt; 로그인 &gt; 100원딜 상품 구매 &gt; [페이백 신청] 버튼 클릭<br>
							<span class="emp">※ 100원딜 상품 외에도 앱에서 1만원 이상 구매시 신청가능</span>
						</dd>
						<dd class="num">2. 구매일로부터 최대 30일 이내에 페이백 지급 <strong class="emp">(해외직구 상품 구매시 최대  70일 소요)</strong></dd>
						<dd>적립대상 쇼핑몰: G마켓, 옥션, 11번가, 인터파크, 티몬, 위메프,<br>쿠팡, GS SHOP, Cjmall, SSG (신세계몰, 신세계백화점, 이마트몰, 트레이더스), SK스토아</dd>
						<dd>1만원 이상 구매금액은 배송비, 설치비, 할인, 쇼핑몰 포인트 등 제외한 상품의 실제 결제금액만 반영됨</dd>
					</dl>
		
					<dl class="txtlist">
						<dt>이벤트 유의사항</dt>					
						<dd>ID당 1회 참여가능</dd>
						<dd>모바일 앱에서 첫구매일 경우에만 참여 가능</dd>
						<dd>본인인증 및 이벤트 정보동의 후 참여가능</dd>
						<dd>본인인증, 첫구매, 이벤트 신청의 단계를 <span class="emp">모두 동일한 기기에서 진행시에만 참여가능</span> (1개의 ID로 각기 다른 기기에서 진행한 경우 참여 불가)</dd>
						<dd>인터파크 상품권의 경우 100원딜에 노출된 상품만 구매적립되며, 그 외 인터파크 상품권은 적립제외 상품으로 이벤트 대상에서 제외</dd>
						<dd><strong class="emp">100원딜 혜택은 ‘초대 첫구매‘ 혜택과 중복지급 불가 (초대 첫구매 혜택을 받으신 경우 100원딜 페이백 참여불가)</strong></dd>
					</dl>
					
					<dl class="txtlist">
						<dt><strong class="emp">※ 경품지급 제외: </strong>아래의 경우 경품 지급대상에서 제외됩니다.</dt>
						<dd>구매한 실제 결제금액이 1만원 미만의 구매일 경우</dd>
						<dd>e머니 적립 제외 카테고리의 상품 구매일 경우</dd>
						<dd>이벤트 참여 후 취소/환불/교환/반품한 경우 (취소 후 30일 이내에 재구매 및 90일 이내에 구매적립 받은 경우에는 지급가능)</dd>
						<dd>본인인증값이 동일할 경우</dd>
	 				</dl>
		
					<dl class="txtlist">
						<dt>아래의 경우에는 구매 확인 및 적립이 불가합니다.</dt>
						<dd>에누리 가격비교 앱이 아닌 다른 앱을 통해서 장바구니 또는 관심상품 등록 후 에누리 가격비교 앱으로 결제만 한 경우<br>(에누리 가격비교 앱을 통해 쇼핑몰로 이동 후 장바구니/관심상품 등록 후 구매 시에는 가능)</dd>
						<dd>에누리 가격비교 앱 미 로그인 후 구매한 경우 또는 에누리 가격비교 PC, 모바일 웹에서 구매한 경우</dd>
					</dl>
	
					<div style="padding:15px 10px 5px">
						<strong>모바일쿠폰, 상품권 적립 상세</strong>
						<ul class="txt_indent">
							<li>적립가능 쇼핑몰 : 티몬, G마켓, 옥션</li>
							<li>적립가능 상품 (0.2% 적립): 문화상품권(해피머니, 컬쳐랜드), 도서상품권, 백화점상품권, 영화예매권, 국민관광 상품권</li>
							<li>적립가능 상품을 제외한 상품권, 지역쿠폰, e교환권, e쿠폰은 적립불가</li>
							<li style="background:none;">
								<strong class="stress">※ 백화점 상품권 적립기준</strong>
								<ul>
									<li>1) 상품명에 '백화점 상품권' 명시된 상품 또는 백화점에서만 사용할 수 있는 상품권만 적립</li>
									<li>2) 복합상품권 적립불가(삼성 상품권/신세계 기프트카드/롯데카드 상품권/이랜드 상품권/AK플라자 상품권/통합 상품권 등)</li>
									<li>3) 복합 상품권의 경우 사용처에 백화점이 기재되어 있는 경우에도 적립불가</li>
									<li>4) 백화점 상품권으로 전환 가능한 포인트 구매시 적립불가</li>
								</ul>
							</li>
						</ul>
						
						<strong>적립대상쇼핑몰 중 e머니 적립 제외 카테고리/서비스 </strong>
						<ul class="txt_indent">
							<li>에누리 가격비교 앱에서 검색되지 않는 상품</li>
							<li>인터파크: 모바일쿠폰/상품권, 라이프 서비스(티켓, 투어, 아이마켓 등)</li>
							<li>11번가: 여행/숙박/항공, 모바일쿠폰/상품권 전체</li>
							<li>G마켓: 중고장터, 실시간 여행, 항공권, 도서/음반, 모바일쿠폰/상품권(일부 상품권 적립가능)</li>
							<li>옥션: 중고장터, 실시간 여행, 항공권, 모바일쿠폰/상품권(일부 상품권 적립가능)</li>
							<li>SSG: 도서/음반/문구/취미/여행, 모바일쿠폰/상품권 전체</li>
							<li>티몬: 슈퍼꿀딜, 슈퍼마트 등 특가 판매 상품, 모바일쿠폰/상품권(일부 상품권 적립가능)</li>
							<li>위메프: 모바일쿠폰/상품권 전체</li>
							<li>CJ몰/GSSHOP: 모바일쿠폰/상품권 전체</li>
							<li>모바일쿠폰/상품권: 상품권, 지역쿠폰, e교환권, e쿠폰 등 (문화상품권, 도서상품권, 백화점상품권, 영화예매권, 국민관광상품권은 적립 가능)</li>
							<li>이 외 쇼핑몰에 입점한 제휴 서비스(배달, 티켓, 해외직구 등) 및 일부 카테고리 제외</li>
						</ul>	
					</div>			
					
					<dl class="txtlist">
						<dt>유의사항</dt>
						<dd>부정 참여 시 적립이 취소 및 사이트 사용이 제한될 수 있습니다.</dd>
						<dd>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</dd>
					</dl>
	
					<a href="javascript:///" class="btn_check_hide">확인</a>
				</div>
			</div>
			<!-- //유의사항 -->
			
			<script>
			// 유의사항 드롭다운
			$(".btn_check_hide").click(function(e){
				e.preventDefault();
				var $btn = $(this).parents(".caution-wrap").find(".btn-caution");
				$btn.toggleClass("on");
				$("html,body").stop().animate({"scrollTop":$btn.offset().top - 40+"px"},"slow")
			})
			</script>
		</div>
		
	</div>
	
	<div class="otherbene">
		<div class="contents">
			<h2><img src="http://img.enuri.info/images/event/2019/w100deal/m_benefit_tit.png" alt="놓칠수 없는 특별한 혜택"></h2>
			<ul class="banlist">
				<li><a href="javascript:///" target="_blank" title="새창으로 이동"><img src="http://img.enuri.info/images/event/2019/w100deal/m_benefit_bn_01.jpg" alt="출석체크&amp;매일룰렛"></a></li>
				<li><a href="javascript:///" target="_blank" title="새창으로 이동"><img src="http://img.enuri.info/images/event/2019/w100deal/m_benefit_bn_02.jpg" alt="누리팡스탬프"></a></li>
			</ul>
			<a href="javascript:///" target="_blank" class="btn_more_evt">더 많은 이벤트 보기</a>
		</div>
	</div>

<!-- layer--> 
<div class="layer_back" id="app_only" style="display:none;">
	<div class="appLayer">
		<h4>모바일 앱 전용 이벤트</h4>
		<a href="javascript:///" class="close" onclick="$('#app_only').hide();">창닫기</a>
		<p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br />에누리앱을 설치합니다.</p>
		<p class="btn_close"><button type="button">설치하기</button></p>
	</div>
</div>

<!-- 개인정보 수집 및 이용동의 -->
<div class="layer_back" id="myInvitedetail" style="display:none">
	<div class="agree_layer">
		<div class="inner">
			<div class="txt_tit">개인정보 수집 및 이용동의</div>			
			<div class="txt_cnt">
				<div class="agree_tit">
					본인인증 정보는 이벤트 종료 시까지<br/>
					저장하며 이벤트 종료 후 파기됩니다.
				</div>
				<div class="agree_txt">
					<label><input type="checkbox" class="chkbox" id="">이벤트 참여를 위한 개인정보 활용에 동의합니다.</label>
					<a href="" onclick="onoff('pop_agree_noti');return false;" class="btn_view_detail">자세히보기&gt;</a>
				</div>
			</div>			
			<p class="btn_apply"><button type="button" id="couponIns">응모완료 &gt;</button></p>
		</div>
		<!-- 닫기 -->
		<a href="javascript:///" onclick="onoff('myInvitedetail');return false;" class="btn_close">닫기</a>
		<!-- // 닫기 -->
	</div>
</div>
<!-- // -->

<!-- 개인정보 수집 이용안내 레이어 -->
<div class="layer_back" id="pop_agree_noti" style="display:none">
	<div class="agree_noti_layer">
		<div class="inner">
			<div class="txt_tit">개인정보 수집 &middot; 이용안내</div>
			<div class="txt_cnt">
				<strong>에누리 가격비교는 이벤트 참여확인을 위하여 <br/>아래와 같이 개인 정보를 수집하고 있습니다.</strong><br/>
				<dl>
					<dt>1. 개인정보 수집 항목</dt>
					<dd>- 휴대폰번호, 참여일시, 참여자ID, 본인인증확인(CI,DI)</dd>
					<dt>2. 개인정보 수집 목적</dt>
					<dd>- 이벤트를 위해 수집된 개인정보는 이벤트 참여확인을 위한 본인확인 이외의 목적으로 활용되지 않습니다.</dd>
					<dt>3. 개인정보 보유 및 이용기간</dt>
					<dd>- 개인정보 수집자 (에누리 가격비교)는 이벤트 기간 동안 개인정보를 수집하며, 이벤트가 종료되면 개인정보를 즉시 파기합니다.</dd>
				</dl>
			</div>
			<p class="btn_close"><button type="button" onclick="onoff('pop_agree_noti');">닫기</button></p>
		</div>
	</div>
</div>
<!-- // -->

<!-- 페이백 신청완료 -->
<div class="layer_back" id="pop_payback" style="display:none">
	<div class="payback_noti_layer">
		<div class="inner">
			<div class="txt_tit blind">페이백 신청 완료!</div>
			<div class="txt_cnt blind">구매에 대한 적립이 완료된 <em>다음날 e머니 9,900점 적립됩니다.</em></div>
			<span class="blind">자세한 내용은 참여방법을 확인해 주세요!</span>
			<p class="btn_close"><button type="button" onclick="onoff('pop_payback');">닫기</button></p>
		</div>
	</div>
</div>
<!-- // -->

<script>
(function() {
	
	var isClick = true;
	var point = 9900; //지급포인트
	var chkPrice =10000; //구매값
	
	getEvtGoods(); 
	getPowerReward();
	
	//첫구매 버튼클릭
	$("#firstbuyClk").click(function(e){
		
		//alert("chkid:"+vChkId);
		point = commaNum(point);
		chkPrice = commaNum(chkPrice);

		adClickGa();
		welcomeGa("evt_firstbuy100_click");
		
		//첫구매변수
		if(getCookie("appYN") == 'Y'){
			ga('send', 'event', 'mf_event', vEvent_title ,  '페이백 신청하기');
		}else{
			onoff('app_only');
			
			if(gkind == "42"){
				ga('send','event', 'mf_event','첫구매이벤트_버튼클릭','SA 42 M_Naver');
			}else if(gkind == "43"){
				ga('send','event', 'mf_event','첫구매이벤트_버튼클릭','SA 43 M_Daum');
			}else if(gkind == "44"){
				ga('send','event', 'mf_event','첫구매이벤트_버튼클릭','SA 44 M_google');
			}else if(gkind=="72"){
				ga('send','event', 'mf_event','첫구매이벤트_버튼클릭','DA 72 M_icover');	
			}else if(gkind=="71" && gno == "3100367"){
				ga('send','event', 'mf_event','첫구매이벤트_버튼클릭','망고_첫구매CU');
			}else if(gkind=="75" && gno == "3120469"){
				ga('send','event', 'mf_event','첫구매이벤트_버튼클릭','버즈빌_첫구매CU');
			}else if(gkind=="74" && gno == "3120470"){
				ga('send','event', 'mf_event','첫구매이벤트_버튼클릭','페이스북_첫구매CU');
			}else if(gkind=="76" && gno == "3139542"){
				ga('send','event', 'mf_event','첫구매이벤트_버튼클릭','애드립_첫구매CU');
			}else{
				ga('send', 'event','mf_event', vEvent_title ,'신청하기');
			}
			return false;
		}
		if(!islogin()){
			alert("로그인 후 이용할 수 있습니다.");
			if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
				location.href = "/mobilefirst/login/login.jsp";
			}else if(navigator.userAgent.indexOf("Android") > -1){
				location.href = "/mobilefirst/login/login.jsp?backUrl=/mobilefirst/evt/firstbuy100_event.jsp?freetoken=event&chk_id="+vChkId;
			}
			return false;
		}
		
		if(!isClick){
			return false;
		}
		isClick = false;
	
		$.ajax({
			type: "POST",
			url: "/mobilefirst/evt/ajax/ajax_firstbuychk.jsp",
			async: false,
			data: { chkid: vChkId, procCode: 1 },
			dataType:"JSON",
			success: function(json){
				var result = json.result;
				
				if ( result== -77 ) {
					alert("이미 첫구매 혜택을 받았습니다.");
				}else if (result==-22) {//이전 첫구매 신청자
					//alert("아쉽지만\n첫구매 대상자가 아닙니다. (" + result + ")");
					alert("아쉽지만\n첫구매 대상자가 아닙니다. ");
				
				}else if (result==1) {//100원딜 신청자
					alert("이미 신청하셨습니다.");
					
				} else if(result==-5){
					alert("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?");
					location.href = "https://m.enuri.com/mobilefirst/member/myAuth.jsp?cmdType=&f=m&freetoken=login_title";
						
				} else if(result==6) {
					alert("구매 후 신청하세요.");
						
				} else if(result==-1 || result>5) {
					//alert("아쉽네요^^;\n첫구매 대상자가 아닙니다. (" + result + ")" );
					alert("아쉽네요^^;\n첫구매 대상자가 아닙니다." );
				} else if(result==-2) {
					var isFriend = confirm("초대코드가 있습니다.\n초대 첫구매 혜택 신청해주세요.");
					if(isFriend){
					 goFriendPurchase();
					}
				}  else if(result==3) {
					alert("구매해주셔서 감사합니다.\n아쉽게도 첫구매액이 "+chkPrice+"원 미만이면 혜택을 받을 수 없습니다.");
				} else if(result==4 || result == 5) {
					welcomeGa("myInvitedetail");
					onoff('myInvitedetail');
				} else if(result==-99) {
					alert("휴대폰번호 본인인증 후\n 참여할 수 있습니다.");
						
						var pd = "<%=pd%>";
						
						if(getCookie("appYN") == "Y"){
							window.open("https://m.enuri.com/mobilefirst/member/myAuth.jsp?userid=<%=cUserId%>&app=Y&freetoken=login_title&pd="+pd);
						}else{
							window.open("https://m.enuri.com/mobilefirst/member/myAuth.jsp?userid=<%=cUserId%>&freetoken=login_title");	
						}
					return false;
				} else if(result==-98) {
					alert("이미 첫구매 혜택을 받았습니다.");
				} else {
					alert("아쉽네요^^;\n첫구매 대상자가 아닙니다." ); //0
				}
				
			}, complete : function() {	isClick=true;	}
		});
	});
	$("#couponIns").click(function(e){
		
		if(!$(".chkbox").prop("checked")){
			alert("정보 수집 동의 후 신청하세요!");
			return false;
		}
		if(!isClick){
			return false;
		}
		isClick = false;
		
		welcomeGa("evt_firstbuy100_complete");
		
		$.ajax({
			type: "POST",
			url: "/mobilefirst/evt/ajax/ajax_firstbuychk.jsp",
			async: false,
			data: { chkid: vChkId, procCode: 2 },
			dataType:"JSON",
			success: function(json){
				var result = json.result;
				
				if (result==1) {
					alert("이미 신청하셨습니다.\n구매일로부터 약 10일 후(최대 30일)\nmy>적립내역에서 적립받기 클릭해주세요.\n구매적립 다음날 적립됩니다.");
				} else if(result==-1 || result>5) {
					//alert("아쉽네요^^;\n첫구매 대상자가 아닙니다.(" + result + ")" );
					alert("아쉽네요^^;\n첫구매 대상자가 아닙니다." );
				} else if(result==-2) {
					//var isFriend = confirm("초대코드가 있습니다.\n초대 첫구매 혜택 신청해주세요.");
					//if(isFriend){
					 alert("초대코드가 있습니다.\n초대 첫구매 혜택 신청해주세요.");
					 goFriendPurchase();
					//}
				} else if(result==2) {
					alert("구매 후 적립 신청하세요.");
				} else if(result==3) {
					alert("구매해주셔서 감사합니다.\n아쉽게도 첫구매액이 "+chkPrice+"원 미만이면 혜택을 받을 수 없습니다.");
				} else if(result==4) {
					//welcomeGa("evt_welcome_combo1_complete");		
					//alert("참여완료!\n구매일로부터 약 10일 후(최대 30일)\nmy>적립내역에서 적립받기 클릭해주세요.\n구매적립 다음날 적립됩니다.");
					onoff('pop_payback');
				} else if(result==5) {
					welcomeGa("evt_welcome_combo1_complete");
					alert("축하드립니다!!\n첫 구매혜택 e머니 "+point+"점이 지급되었습니다.");
					getPoint();
				} else if(result==-99) {
		            alert("휴대폰번호 본인인증 후\n 참여할 수 있습니다.");
		    		location.href = "https://m.enuri.com/mobilefirst/member/myAuth.jsp?userid=<%=cUserId%>&freetoken=login_title";
	    		
				} else if(result==-5){
						//var r = confirm("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?");
						//if(r){
							alert("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?");
							location.href = "https://m.enuri.com/mobilefirst/member/myAuth.jsp?cmdType=&f=m&freetoken=login_title";
						//}
				} else {
					//alert("아쉽네요^^;\n첫구매 대상자가 아닙니다.(" + result + ")" );
					alert("아쉽네요^^;\n첫구매 대상자가 아닙니다." );
				}
				
			}, complete : function() {
				isClick=true;
				onoff('myInvitedetail');
			}
		});
	});
	function getEvtGoods(){
		
		/*
		var imgArr = [
      		'http://img.enuri.info/images/event/2019/w100deal/deal_item_01.jpg',
      		'http://img.enuri.info/images/event/2019/w100deal/deal_item_02.jpg',
      		'http://img.enuri.info/images/event/2019/w100deal/deal_item_03.jpg',
      		'http://img.enuri.info/images/event/2019/w100deal/deal_item_04.jpg',
      		'http://img.enuri.info/images/event/2019/w100deal/deal_item_05.jpg',
      		'http://img.enuri.info/images/event/2019/w100deal/deal_item_06.jpg',
      		'http://img.enuri.info/images/event/2019/w100deal/deal_item_07.jpg',
      		'http://img.enuri.info/images/event/2019/w100deal/deal_item_08.jpg'		
      	];
		*/
		
		$.ajax({
			type: "POST",
			url: "/event/ajax/evt_100deal_goods_ajax.jsp?p=list",
			async: false,
			dataType:"JSON",
			success: function(json){
				
				$.each(json.data,function(i,v){
					
					var html = "";
					
					html += "<li data-id='"+v.gd_lnk_url+"' data-soldout='"+v.so_yn+"' data-gnm='"+v.evnt_gd_nm+"' >";
					
					if(v.so_yn == "Y"){
						html +=	"<span class=\"ico_soldout\">Soldout</span>";	
					}
					
					html +=	"<span class=\"deal_item\">";
					html +=		"<img src='<%="http://storage.enuri.gscdn.com"%>/Web_Storage"+v.gd_img_url+"' alt=''>";
					//html +=		"<img src='"+imgArr[i]+"' alt=''>";
					
					html +=	"</span>";
					html +=	"<a href=\"javascript:///\" class=\"btn_deal\">구매하기</a>";
					html += "</li>";
					
					$(".deal_list").append(html);
					
				});
				$(".deal_list > li").click(function(){
					
					if(getCookie("appYN") == 'Y'){
						
						var soldout = $(this).attr("data-soldout");
						
						if(soldout == "N"){
							var gnm = $(this).attr("data-gnm");
							ga('send', 'event', 'mf_event', vEvent_title ,'상품'+gnm);
							var moveUrl = $(this).attr("data-id");
							
							firstBuyCheck(moveUrl)
							return false;
						}
						
					}else{
						onoff('app_only');
						return false;
					}
					
					/*
					if(!islogin()) {
						
						alert("로그인 후 구매 가능합니다!"); 
						
						if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
							location.href = "/mobilefirst/login/login.jsp";
						}else if(navigator.userAgent.indexOf("Android") > -1){
							location.href = "/mobilefirst/login/login.jsp?backUrl=/mobilefirst/evt/firstbuy100_event.jsp?freetoken=event&chk_id="+vChkId;
						}
						
						return;
					}
					*/

				});
				
			}
		});
	}
	function firstBuyCheck(moveUrl){
		
		if(!islogin()){
			alert("로그인 후 이용할 수 있습니다.");
			if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
				location.href = "/mobilefirst/login/login.jsp";
			}else if(navigator.userAgent.indexOf("Android") > -1){
				location.href = "/mobilefirst/login/login.jsp?backUrl=/mobilefirst/evt/firstbuy100_event.jsp?freetoken=event&chk_id="+vChkId;
			}
			return false;
		}
		
		$.ajax({
			type: "POST",
			url: "/mobilefirst/evt/ajax/ajax_firstbuychk.jsp",
			async: false,
			data: { chkid: vChkId, procCode: 3 },
			dataType:"JSON",
			success: function(json){
				
				var result = json.result;
				
				if ( result== -77 ) {
					alert("이미 첫구매 혜택을 받았습니다.");
				}else if (result==-22) {//이전 첫구매 신청자
					//alert("아쉽지만\n첫구매 대상자가 아닙니다. (" + result + ")");
					alert("아쉽지만\n첫구매 대상자가 아닙니다. ");
				
				}else if (result==1) {//100원딜 신청자
					alert("이미 신청하셨습니다.");
					
				} else if(result==-5){
						//var r = confirm("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?");
						//if(r){
							alert("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동합니다");
							location.href = "https://m.enuri.com/mobilefirst/member/myAuth.jsp?cmdType=&f=m&freetoken=login_title";
						//}
				} else if(result==6) {
					//if(navigator.userAgent.indexOf("Android") > -1){
					alert("페이백은 구매일로부터 최대 30일 소요됩니다.\n구매하시겠습니까?");
					//}
					//window.open(moveUrl);
					location.href=moveUrl+"&outlink";
					return false;
						
				} else if(result==-1 || result>5) {
					//alert("아쉽네요^^;\n첫구매 대상자가 아닙니다. (" + result + ")" );
					alert("아쉽네요^^;\n첫구매 대상자가 아닙니다. " );
				} else if(result==-2) {
					//var isFriend = confirm("초대코드가 있습니다.\n초대 첫구매 혜택 신청해주세요.");
					alert("초대코드가 있습니다.\n초대 첫구매 혜택 신청해주세요.");
					//if(isFriend){
					goFriendPurchase();
					//}
				}  else if(result==3) {
					alert("구매해주셔서 감사합니다.\n아쉽게도 첫구매액이 "+chkPrice+"원 미만이면 혜택을 받을 수 없습니다.");
				} else if(result==4 || result == 5) {
					//welcomeGa("myInvitedetail");
					//onoff('myInvitedetail');
					//if(navigator.userAgent.indexOf("Android") > -1){
					alert("페이백은 구매일로부터 최대 30일 소요됩니다.\n구매하시겠습니까?");	
					//}
					//window.open(moveUrl);
					location.href=moveUrl+"&outlink";
					return false;
					
				} else if(result==-99) {
					
					//var r = confirm("휴대폰번호 본인인증 후\n 참여할 수 있습니다.");
					//if(r){
						alert("휴대폰번호 본인인증 후\n 참여할 수 있습니다.");
						var pd = "<%=pd%>";
						
						if(getCookie("appYN") == "Y"){
							window.open("https://m.enuri.com/mobilefirst/member/myAuth.jsp?userid=<%=cUserId%>&app=Y&freetoken=login_title&pd="+pd);
						}else{
							window.open("https://m.enuri.com/mobilefirst/member/myAuth.jsp?userid=<%=cUserId%>&freetoken=login_title");	
						}
						
					//}
					return false;
		            
				} else if(result==-98) {
					alert("이미 첫구매 혜택을 받았습니다.");
				} else {
					//alert("아쉽네요^^;\n첫구매 대상자가 아닙니다.(" + result + ")" ); //0
					alert("아쉽네요^^;\n첫구매 대상자가 아닙니다." ); //0
				}
				
			}
		});
		
	}
	
	function getPowerReward(){
		
		if(!islogin()){
			$(".txt_date").text("로그인 후 확인하세요!");  
			return; 
		}
		
		$.ajax({
			type: "POST",
			url: "/mobilefirst/evt/ajax/ajax_power_reward.jsp",
			async: false,
			dataType:"JSON",
			success: function(json){
					
					for( i=0 ; i < json.cnt ; i++){
						$("#powerList > li").eq(i).addClass("on"); 	
					}
					
					if(getCookie("appYN") == 'Y'){
						
						//첫구매 신청내역 없음
						if ( json.isApply == -2 || json.isApply == -3 || json.isApply == -1  ) {
							
							$(".txt_date").text("아쉽게도 대상자가 아닙니다.");
						} else if ( json.isApply == 1  ) {
							if( typeof json.power_date != 'undefined' || typeof json.power_date != 'undefined' ){
								
								var yy = json.power_date.substring(0,4);
								var mm = json.power_date.substring(4,6);
								var dd = json.power_date.substring(6,8);
								
								$(".txt_date").text(mm+"월 "+dd+"일 까지");	
								
							}else{
								$(".txt_date").text("첫 구매 후 확인하세요!");	
							}
							
						} else if( typeof json.power_date != 'undefined' || typeof json.power_date != 'undefined') {
							var yy = json.power_date.substring(0,4);
							var mm = json.power_date.substring(4,6);
							var dd = json.power_date.substring(6,8);
							
							$(".txt_date").text(mm+"월 "+dd+"일 까지");	
						}
						
					}else{
						$(".txt_date").text("APP에서 확인하세요!");					
					}
					
			}
		});
	}
	
	function goFriendPurchase(){		location.href="/mobilefirst/evt/new_friend_20179.jsp?freetoken=eventclone&tab=3";	}
	
	//에누리혜택
	$(".banlist > li").click(function(){

		var idx = $(this).index();
		var evtUrl = [
			"/mobilefirst/evt/visit_event.jsp?tab=1&freetoken=event",
			//"/mobilefirst/evt/visit_event.jsp?tab=2&freetoken=event",
			"/mobilefirst/evt/smart_benefits.jsp?tab=1&freetoken=event",
			"/mobilefirst/evt/mobile_deal.jsp?freetoken=event",
			//"/mobilefirst/evt/officeworker_2018.jsp?event_id=2019031900&freetoken=event",
			(getCookie("appYN") != "Y" ? "/mobilefirst/index.jsp#evt" : "/mobilefirst/renew/plan.jsp?freetoken=main_tab|event"),
		];
		if(idx == 0){
			ga('send', 'event', 'mf_event', vEvent_title ,'하단배너_출석체크');	
		}else if(idx == 1){
			//ga('send', 'event', 'mf_event', vEvent_title ,'하단배너_매일룰넷');
			ga('send', 'event', 'mf_event', vEvent_title ,'하단배너_누리팡! 스템프');
		}else if(idx == 2){
			//ga('send', 'event', 'mf_event', vEvent_title ,'하단배너_누리팡! 스템프');
			ga('send', 'event', 'mf_event', vEvent_title ,'하단배너_크레이지딜');
		}else if(idx == 3){
			ga('send', 'event', 'mf_event', vEvent_title ,'하단배너_크레이지딜');
		}else if(idx == 4){
			ga('send', 'event', 'mf_event', vEvent_title ,'하단배너_직장공감');
		}else if(idx == 5){
			ga('send', 'event', 'mf_event', vEvent_title ,'하단배너_더많은 이벤트');
		}
		
		window.open(evtUrl[idx]);
	});
	
	$(".btn_more_evt").click(function(){
		var url = (getCookie("appYN") != "Y" ? "/mobilefirst/index.jsp#evt" : "/mobilefirst/renew/plan.jsp?freetoken=main_tab|event")
		window.open(url);
	});
	
}());
</script>