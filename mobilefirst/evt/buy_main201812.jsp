<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%
	SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy년 M월 d일");
	SimpleDateFormat prevFormat = new SimpleDateFormat("yyyyMMdd");

	String chkId = request.getParameter("chk_id");
    String userArea = request.getParameter("userArea");
    String sdt = request.getParameter("sdt");

    String strUrl = request.getRequestURI();
    String tab = ChkNull.chkStr(request.getParameter("tab"));

    String eventCode1 = request.getParameter("eventCode1");
    String eventCode2 = request.getParameter("eventCode2");

    String startDate = request.getParameter("startDate");
    String endDate = request.getParameter("endDate");
    String inflowType = request.getParameter("inflowType");
    boolean isPush=false;
    //유입경로가 푸쉬메시지인 경우
    if(inflowType.equals("pmsg"))  isPush=true;
%>
<body>
  <!-- layer-->
<div class="layer_back" id="app_only" style="display: none;">
  <div class="appLayer">
    <h4>모바일 앱 전용 이벤트</h4>
    <a href="javascript:///" class="close" onclick="onoff('app_only')">창닫기</a>
    <p class="txt">
      <strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br />에누리앱을
      설치합니다.
    </p>
    <p class="btn_close">
      <button type="button" onclick="install_btt();">설치하기</button>
    </p>
  </div>
</div>

<div class="wrap">
	<!-- 이벤트 상단 -->
	<div class="evt_head">
		<%@include file="/eventPlanZone/jsp/eventMovingTapMobile.jsp"%>

		<!-- tab_area -->
		<div class="tab_area">
			<div class="inner">
				<ul class="tabmenu" id="tabmenu">
					<li><a class="btn" href="javascript:///"><strong>출석체크</strong></a></li>
					<li><a class="btn" href="javascript:///"><strong>첫구매</strong></a></li>
					<li><a class="btn" href="javascript:///"><strong>스탬프</strong></a></li>
					<li><a class="btn" href="javascript:///"><strong>컴백혜택</strong></a></li>
				</ul>
			</div>
		</div>
		<!-- //tab_area -->
	</div>
	<!-- //이벤트 상단 -->
	<!-- 상단비주얼 -->
	<div class="evt_visual">
		<div class="blind">
			<h1>특별한 회원들을 위한 프리미엄 혜택</h1>
			<p>1천만원 이상 구매고객이라면 누구나!</p>
		</div>
	</div>
	<!-- //상단비주얼 -->
   <div class="evt_content">			
				<!-- 더블적립 -->
		<div id="evt1" class="evt-double">
			<div class="contents">
				<div class="double__head">
					<div class="blind">
						<h2>[앱전용] X2더블적립</h2>
						<p>카테고리 상관없이! 최대 200만점 추가적립! 100% 당첨</p>
					</div>

					<a href="javascript:///" class="btn btn-join"  id="doubleSaving" >더블적립 신청하기</a>
				</div>
				<div class="double__cont">
					<div class="inner">
						<div class="txt_box">
							<ul>
								<li><strong>구매금액별 추가 적립률 및 최대 적립액</strong>
									<ul class="ul-sub">
										<li>- 2억이상: 1% 추가적립 / 최대 200만점</li>
										<li>- 1억이상: 1% 추가적립 / 최대 100만점</li>
										<li>- 5천만원~1억미만: 0.7% 추가적립 / 최대 50만점</li>
										<li>- 3천만원~5천만원미만: 0.5% 추가적립 / 최대 20만점</li>
										<li>- 1천만원~3천만원미만: 0.4% 추가적립 / 최대 10만점</li>
									</ul>
								</li>
								<li><strong>상품권의 경우 아래의 적립률 적용</strong>
									<ul class="ul-sub">
										<li>- 2억이상: 0.3% 추가적립 / 최대 200만점</li>
										<li class="stress"><b>※ 대상쇼핑몰: 티몬, 위메프, G마켓, 옥션</b></li>
									</ul>
								</li>
							</ul>
						</div>
					</div>

					<!-- 유의사항 WRAPPER -->
					<div class="caution-wrap">
						<a href="javascript:///" class="btn stripe btn-caution btn_check">꼭! 확인하세요</a>

						<!-- 더블적립 유의사항 -->
						<div class="moreview">
							<h4>더블적립 유의사항</h4>
							<div class="txt">
								<strong>이벤트 및 구매기간</strong>
								<ul class="txt_indent">
									<!-- 180416 수정 -->
									<li><%= dateFormatter.format(prevFormat.parse(startDate)) %> ~ <%= dateFormatter.format(prevFormat.parse(endDate)) %></li>
								</ul>

								<strong>당첨자 혜택</strong>
								<ul class="txt_indent">
									<li>일반상품 구매금액 별 적립률 및 최대 적립액<br>
									- 일반상품으로 1천만원 이상 구매시 최대 200만점 추가적립<br>
									- <span class="stress"><b>※ 순금, 순은, 돌반지, 골드바, 실버바 구매시 추가적립 가능!</b></span><br>
									- 일반상품+상품권 함께 구매시 ‘일반상품‘에 대해서만 아래 적립률 적용<br>
									- 구매금액별 적립률 및 최대 적립액
										<div class="tb">
											<table cellpadding="0" cellspacing="0">
												<colgroup>
													<col width="42%" /><col width="28%" /><col width="30%" />
												</colgroup>
												<tbody>
													<tr>
														<th>구매금액</th>
														<th>추가적립률</th>
														<th>최대 적립액</th>
													</tr>
													<tr>
														<td>2억 이상</td>
														<td>1.0%</td>
														<td>2,000,000</td>
													</tr>
													<tr>
														<td>1억 이상</td>
														<td>1.0%</td>
														<td>1,000,000</td>
													</tr>
													<tr>
														<td>5천만원~1억미만</td>
														<td>0.7%</td>
														<td>500,000</td>
													</tr>
													<tr>
														<td>3천만원~5천만원 미만</td>
														<td>0.5%</td>
														<td>200,000</td>
													</tr>
													<tr>
														<td>1천만원~3천만원 미만</td>
														<td>0.4%</td>
														<td>100,000</td>
													</tr>
												</tbody>
											</table>
										</div>
									</li>
									<li>상품권 구매금액 별 적립률 및 최대적립액<br>
									- 상품권 구매로만 2억 이상시 적용 (2억 미만 구매시 추가적립 불가)<br>
									- 일반상품+상품권으로 2억 이상 구매시에도 상품권 구매금액 제외<br>
									- 구매금액별 적립률 및 최대 적립액<br>
									- 대상 쇼핑몰: 티몬, 위메프, G마켓, 옥션<br>
									- 대상 상품권: 문화상품권, 도서상품권, 백화점상품권, 영화예매권, 국민관광상품권<br>
										<div class="tb">
												<table cellpadding="0" cellspacing="0">
													<colgroup>
														<col width="42%" /><col width="28%" /><col width="30%" />
													</colgroup>
													<tbody>
														<tr>
															<th>구매금액</th>
															<th>추가적립률</th>
															<th>최대 적립액</th>
														</tr>
														<tr>
															<td>2억 이상</td>
															<td>0.3%</td>
															<td>2,000,000</td>
														</tr>
													</tbody>
												</table>
											</div>
									</li>
									<!-- 180416 수정 -->
									<li><b>당첨자 발표 및 적립일: 2019년 3월 25일</b><br />[에누리 가격비교 PC 사이트 &gt; 고객센터] 및 [에누리 가격비교 APP &gt; 당첨자 발표] </li>
									<li><b class="stress">e머니 유효기간: 적립일로부터 15일</b></li>
								</ul>

								<strong>더블적립 참여방법 및 유의사항</strong>
								<ul class="txt_indent">
									<li><span class="stress">에누리 가격비교 앱 로그인</span> &rarr; 적립대상 쇼핑몰 이동 &rarr; 구매하기 &rarr; 더블적립 이벤트 응모하기</li>
									<li>적립대상 쇼핑몰 : G마켓, 옥션, 11번가, 인터파크, 티몬, 위메프, GS SHOP, CJmall, SSG (신세계몰, 신세계백화점, 이마트몰, 트레이더스)</li>
									<li>구매금액은 배송비, 설치비, 할인, 쇼핑몰 포인트 등 제외한 상품 결제금액만 반영</li>
									<!-- 180416 수정 -->
									<li>이벤트 기간 내의 구매내역 중 2019년 1월 30일까지의 구매확정금액(배송완료) 기준으로 당첨자 선정</li>
									<li class="stress">일반상품과 상품권 적립률은 별도로 적용되며, 일반상품 또는 상품권을 제외한 구매금액이 1천만원 미만일 경우 지급대상에서 제외됩니다.</li>
									<li class="stress">구매취소 하였으나 적립된 e머니가 있을 경우 해당 적립액 제외 후 추가적립 됩니다.</li>
									<li class="stress">무제한 적립 혜택과 중복지급 불가</li>
								</ul>
								<strong>※ 이벤트 구매금액에서 제외되는 상품</strong>
								<ul class="txt_indent">
									<li style="background-image:none; padding-left:10px;">
									1) 더블적립 해당 상품권의 경우라도 상품 페이지 내 취소/환불기간이 최대 30일 이상으로 명시되어있거나, 명시되어있지 않은 상품<br>
									2) 1번의 사유 또는 상품 특성상 이벤트 기간 이후 취소/환불 가능한 상품<br>
									3) e머니 적립 제외 카테고리에 해당하는 상품<br>
									4) 구매 이후 취소/환불/교환/반품한 경우<br>
									→ 이 경우 구매적립이 되었더라도 제외되며, 해당 상품의 사용/교환여부와 상관없이 제외
									</li>
								</ul>

								<strong>아래의 경우에는 구매 확인 및 적립이 불가합니다.</strong>
								<ul class="txt_indent">
									<li>에누리 가격비교 앱이 아닌 다른 앱을 통해서 장바구니 또는 관심상품 등록 후 에누리 가격비교 앱으로 결제만 한 경우<br />(에누리 가격비교 앱을 통해 쇼핑몰로 이동 후 장바구니/관심상품 등록 후 구매 시에는 가능)</li>
									<li>구매 후 모바일 앱 적립내역 페이지에서 [적립받기]를 선택하지 않은 경우</li>
									<li>에누리 가격비교 앱 미 로그인 후 구매한 경우 또는 에누리 가격비교 PC, 모바일 웹에서 구매한 경우</li>
								</ul>

								<strong>적립대상쇼핑몰 중 e머니 적립 제외 카테고리/서비스 </strong>
								<!-- 181120 수정 -->
								<ul class="inner" style="margin-top:5px">
									<li>- 에누리 가격비교 앱에서 검색되지 않는 상품</li>
									<!-- <li>- 순금/돌반지, 중고상품, 지류상품권, e쿠폰 상품권, 지역쿠폰, e쿠폰 등 환금성 상품(일부 상품권 적립가능)</li> -->
									<li>- 인터파크: 에누리 특가상품(크레이지딜), 모바일쿠폰/상품권, 라이프 서비스(티켓, 투어, 아이마켓 등)</li>
									<li>- 11번가: 여행/숙박/항공, 모바일쿠폰/상품권 전체</li>
									<li>- G마켓: 중고장터, 실시간 여행, 항공권, 도서/음반, 모바일쿠폰/상품권(일부 상품권 적립가능)</li>
									<li>- 옥션: 중고장터, 실시간 여행, 항공권, 모바일쿠폰/상품권(일부 상품권 적립가능)</li>
									<li>- SSG: 도서/음반/문구/취미/여행, 모바일쿠폰/상품권/서비스 및 현금성 상품</li>
									<li>- 티몬: 슈퍼꿀딜, 슈퍼마트 등 특가 판매 상품, 모바일쿠폰/상품권(일부 상품권 적립가능)</li>
									<li>- 위메프: 모바일쿠폰/상품권 전체</li>
									<li>- CJ몰: 모바일쿠폰/상품권 전체</li>
									<li>- 모바일쿠폰/상품권: 상품권, 지역쿠폰, e교환권, e쿠폰 등 (문화상품권, 도서상품권, 백화점상품권, 영화예매권, 국민관광상품권은 적립 가능)</li>
									<li>- 이 외 쇼핑몰에 입점한 제휴 서비스(배달, 티켓, 해외직구 등) 및 일부 카테고리 제외</li>
								</ul>

								<strong>유의사항</strong>
								<ul class="txt_indent">
									<li>부정 참여 시 적립이 취소될 수 있습니다.</li>
									<li>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</li>
								</ul>

								<a href="javascript:///" class="btn_check_hide">확인</a>
							</div>
						</div>
						<!-- //더블적립 유의사항 -->
					</div>
					<!-- //유의사항 WRAPPER -->
				</div>
			</div>
		</div>
		<!-- //더블적립 -->
		<!-- 무제한 추가 적립 -->
		<div id="evt2" class="evt-added">
			<div class="contents">
				<div class="added__head">
					<div class="blind">
						<h2>[앱전용] 무제한 추가적립!</h2>
						<p>컴퓨터, 디지털, 카메라, 가전제품 구매했다면?</p>
					</div>

					<a href="javascript:///" class="btn btn-join" id="unlimitSaving">무제한추가적립 신청하기</a>
				</div>
				<div class="added__cont">
					<div class="inner">
						<div class="txt_box">
							<ul>
								<li><strong>무제한 추가적립 카테고리</strong>
									<ul class="ul-sub">
										<li>컴퓨터, 부품, 영상/디카, 디지털, 주방가전, 생활가전, 계절가전</li>
									</ul>
								</li>
								<li><strong>추가 적립률 및 최대 적립액</strong>
									<ul class="ul-sub">
										<!-- 180220 수정 -->
										<li>1천만원 이상 구매시 0.7% 추가적립 <span class="stress">(최대 적립금액 제한 없음!)</span></li>
									</ul>
								</li>
								<li class="stress"><b>더블적립 혜택과 중복지급 불가</b></li>
							</ul>
						</div>
					</div>

					<!-- 유의사항 WRAPPER -->
					<div class="caution-wrap">
						<a href="javascript:///" class="btn stripe btn-caution btn_check">꼭! 확인하세요</a>

						<!-- 무제한적립 유의사항 -->
						<div class="moreview">
							<h4>무제한 추가적립 유의사항</h4>
							<div class="txt">
								<strong>이벤트 기간</strong>
								<ul class="txt_indent">
									<!-- 180416 수정 -->
									<li><%= dateFormatter.format(prevFormat.parse(startDate)) %> ~ <%= dateFormatter.format(prevFormat.parse(endDate)) %></li>
								</ul>

								<strong>당첨자 혜택</strong>
								<ul class="txt_indent">
									<li>1천 만원 이상 구매시 구매금액의 0.7% 추가적립</li>
									<li><b>대상 카테고리</b><br />
										- 컴퓨터, 부품, 영상/디카, 디지털, 주방가전, 생활가전, 계절가전 (총 7개 카테고리 대상)<br />
										- 위 카테고리의 구매금액에 대해서만 추가적립되며, 다른 카테고리 상품은 추가적립되지 않습니다.
									</li>
									<li>추가적립률 및 최대 적립액<br />- 구매금액의 0.7% 추가적립 / 최대 적립금액 제한 없음</li>
									<!-- 180416 수정 -->
									<li><b>당첨자 발표 및 적립일: 2018년 2월 25일</b><br />[에누리 가격비교 PC 사이트 &gt; 고객센터] 및 [에누리 가격비교 APP &gt; 당첨자 발표] </li>
									<li><b class="stress">e머니 유효기간: 적립일로부터 15일</b></li>
									<li>적립된 e머니는 e쿠폰 스토어에서 다양한 e쿠폰 상품으로 교환 가능</li>
								</ul>

								<strong>무제한 추가적립 참여방법 및 유의사항</strong>
								<ul class="txt_indent">
									<li><span class="stress">에누리 가격비교 앱 로그인</span> &rarr; 적립대상 쇼핑몰 이동 &rarr; 해당 카테고리 상품 구매하기 &rarr; 이벤트 응모하기</li>
									<li>적립대상 쇼핑몰: G마켓, 옥션, 11번가, 인터파크, 티몬, 위메프, GS SHOP, CJmall, SSG (신세계몰, 신세계백화점, 이마트몰, 트레이더스)</li>
									<li>구매금액은 배송비, 설치비, 할인, 쇼핑몰 포인트 등 제외한 상품 결제금액만 반영</li>
									<!-- 180416 수정 -->
									<li>이벤트 기간 내의 구매내역 중 2019년 2월 28일까지의 구매확정금액(배송완료) 기준으로 추가적립</li>
									<li>결제 이후 취소/환불/교환/반품한 경우에는 구매 확정 금액에서 제외</li>
									<li class="stress">구매취소 하였으나 적립된 e머니가 있을 경우 해당 적립액 제외 후 추가적립 됩니다.</li>
									<li class="stress">더블적립 혜택과 중복지급 불가 (무제한 추가적립 우선 적용)</li>
								</ul>

								<strong>아래의 경우에는 구매 확인 및 적립이 불가합니다.</strong>
								 <ul class="txt_indent">
									<li>에누리 가격비교 앱이 아닌 다른 앱을 통해서 장바구니 또는 관심상품 등록 후 에누리 가격비교 앱으로 결제만 한 경우<br />(에누리 가격비교 앱을 통해 쇼핑몰로 이동 후 장바구니/관심상품 등록 후 구매 시에는 가능)</li>
									<li>구매 후 모바일 앱 적립내역 페이지에서 [적립받기]를 선택하지 않은 경우</li>
									<li>에누리 가격비교 앱 미 로그인 후 구매한 경우 또는 에누리 가격비교 PC, 모바일 웹에서 구매한 경우</li>
								 </ul>

								<strong>유의사항</strong>
								<ul class="txt_indent">
									<li>부정 참여 시 적립이 취소될 수 있습니다.</li>
									<li>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</li>
								 </ul>
								<a href="javascript:///" class="btn_check_hide">확인</a>
							</div>
						</div>
						<!-- //무제한적립 유의사항 -->
					</div>
					<!-- //유의사항 WRAPPER -->
				</div>
			</div>
		</div>
		<!-- //무제한 추가 적립 -->
		
		<!-- 모바일앱 구매혜택 안내 -->
		<div class="evt-appinfo">
			<div class="contents">
				<div class="appinfo__cont">
					<div class="inner">
						<h3 class="stripe tit">이벤트 유의사항</h3>
						<div class="txt_box">
							<ul>
								<li>구매 e머니는 적립대상 쇼핑몰에서 구매시 적립됩니다.</li>
								<li>구매 e머니는 카테고리에 따라 차등 적립됩니다.</li>
								<!-- 180416 수정 -->
								<li>적립내역 페이지에서 [적립받기] 선택시 e머니가 적립됩니다.</li>
								<li>일부 카테고리 및 서비스는 구매적립이 제외됩니다.</li>
							</ul>
						</div>
					</div>

					<!-- 유의사항 WRAPPER -->
					<div class="caution-wrap">
						<a href="javascript:///" class="btn stripe btn-caution btn_check">구매적립 유의사항 자세히보기</a>

						<!-- 구매적립 유의사항 -->
						<div class="moreview">
							<h4>구매적립 유의사항</h4>
							<div class="txt">
								<strong>구매 적립 기준 및 유의사항</strong>
								<ul class="txt_indent">
									<li>에누리 가격비교 앱 로그인 &rarr; 적립대상 쇼핑몰 이동 &rarr; 구매하기 &rarr; 구매확정(배송완료) 금액이 1,000원 이상 시 e머니 적립</li>
									<li>적립대상 쇼핑몰: G마켓, 옥션, 11번가, 인터파크, 티몬, 위메프, GS SHOP, CJmall, SSG (신세계몰, 신세계백화점, 이마트몰, 트레이더스)</li>
									<li>구매금액은 배송비, 설치비, 할인, 쇼핑몰 포인트 등 제외한 상품 결제금액만 반영</li>
									<!-- 180416 수정 -->
									<li>구매 e머니는 구매 확인완료 시점(구매 후 최대 30일)부터 모바일 앱 &rarr; 마이 에누리 &rarr; 적립내역 페이지에서 [적립받기] 선택시 적립(수동적립)</li>
									<li>적립내역 페이지에서 [적립받기]를 선택하지 않은 경우에는 구매적립불가</li>
									<li>구매 e머니는 카테고리에 따라 차등 적립
										<p>※ 카테고리별 적립률 상세</p>
										<div class="tb">
											<table cellpadding="0" cellspacing="0">
												<colgroup>
													<col width="70%" /><col width="30%" />
												</colgroup>
												
												<tbody>
													<tr>
														<th>카테고리</th>
														<th>적립률</th>
													</tr>
													<tr>
														<td>유아</td>
														<td>1.5%</td>
													</tr>
													<tr>
														<td>식품/스포츠/레저/자동차</td>
														<td>1.0%</td>
													</tr>
													<tr>
														<td>컴퓨터/도서/취미</td>
														<td>0.8%</td>
													</tr>
													<tr>
														<td>디지털/가전</td>
														<td rowspan="5">0.3%</td>
													</tr>
													<tr>
														<td>패션/화장품</td>
													</tr>
													<tr>
														<td>가구/생활/건강</td>
                                                    </tr>
                                                    <tr>
														<td>모바일쿠폰,상품권</td>
                                                    </tr>
                                                    <tr>
														<td>기타</td>
													</tr>
												</tbody>
												
											</table>
										</div>
									</li>
									<li>적립대상쇼핑몰에서 장바구니에 여러 상품을 담아 한 번에 결제 시 구매건수는 1건이며, 구매금액은 통합 결제한 금액의 e머니 적립</li>
									<li>결제일로부터 10~30일간 취소/반품여부 확인 후 적립</li>
									<li>e머니는 최소 10점부터 적립되며 (구매금액 1,000원 이상), 1원 단위 e머니는 적립되지 않습니다. (예: 1,200원 결제 시 e머니 10점 적립)</li>
									<!-- 180416 수정 -->
									<li>구매적립 e머니 유효기간: 적립가능 시점부터 최대 60일(기간경과 이후 적립불가)</li>
									<li>적립된 e머니는 e쿠폰 스토어에서 다양한 e쿠폰으로 교환 가능합니다.</li>
								</ul>
								
								<strong>상품권 및 e쿠폰 적립 상세</strong>
								<ul class="txt_indent">
									<li>적립가능 상품 (0.3% 적립): 문화상품권(해피머니, 컬쳐랜드), 도서상품권, 백화점상품권, 영화예매권, 국민관광 상품권
									</li><li>적립가능 상품을 제외한 상품권, 지역쿠폰, e교환권, e쿠폰은 적립불가</li>
									<li>상품권 적립가능 쇼핑몰: 티몬, G마켓, 옥션</li>
								</ul>
								<strong>아래의 경우에는 구매 확인 및 적립이 불가합니다.</strong>
								<ul class="txt_indent">
									<li>에누리 가격비교 앱이 아닌 다른 앱을 통해서 장바구니 또는 관심상품 등록 후 에누리 가격비교 앱으로 결제만 한 경우<br />(에누리 가격비교 앱을 통해 쇼핑몰로 이동 후 장바구니/관심상품 등록 후 구매 시에는 가능)</li>
									<li>에누리 가격비교 앱 미 로그인 후 구매한 경우 또는 에누리 가격비교 PC, 모바일 웹에서 구매한 경우</li>
								</ul>

								<strong>적립대상쇼핑몰 중 e머니 적립 제외 카테고리/서비스 </strong>
								<!-- 180322 수정 -->
								<ul class="inner" style="margin-top:5px">
									<li>- 에누리 가격비교 앱에서 검색되지 않는 상품</li>
									<!-- <li>- 순금/돌반지, 중고상품, 지류상품권, e쿠폰 상품권, 지역쿠폰, e쿠폰 등 환금성 상품(일부 상품권 적립가능)</li> -->
									<li>- 인터파크: 에누리 특가상품(크레이지딜), 모바일쿠폰/상품권, 라이프 서비스(티켓, 투어, 아이마켓 등)</li>
									<li>- 11번가: 여행/숙박/항공, 모바일쿠폰/상품권 전체</li>
									<li>- G마켓: 중고장터, 실시간 여행, 항공권, 도서/음반, 모바일쿠폰/상품권(일부 상품권 적립가능)</li>
									<li>- 옥션: 중고장터, 실시간 여행, 항공권, 모바일쿠폰/상품권(일부 상품권 적립가능)</li>
									<li>- SSG: 도서/음반/문구/취미/여행, 모바일쿠폰/상품권/서비스 및 현금성 상품</li>
									<li>- 티몬: 슈퍼꿀딜, 슈퍼마트 등 특가 판매 상품, 모바일쿠폰/상품권(일부 상품권 적립가능)</li>
									<li>- 위메프: 모바일쿠폰/상품권 전체</li>
									<li>- CJ몰: 모바일쿠폰/상품권 전체</li>
									<li>- 모바일쿠폰/상품권: 상품권, 지역쿠폰, e교환권, e쿠폰 등 (문화상품권, 도서상품권, 백화점상품권, 영화예매권, 국민관광상품권은 적립 가능)</li>
									<li>- 이 외 쇼핑몰에 입점한 제휴 서비스(배달, 티켓, 해외직구 등) 및 일부 카테고리 제외</li>
								</ul>
								<a href="javascript:///" class="btn_check_hide">확인</a>
							</div>
						</div>
						<!-- //더블적립 유의사항 -->
					</div>
					<!-- //유의사항 WRAPPER -->
				</div>
			</div>
		</div>
		<!-- //모바일앱 구매혜택 안내 -->
	</div>
   	<%@ include file="/mobilefirst/evt/emoney_guide.jsp"%>

	<!-- layer-->
	<div class="layer_back" id="benefit_layer" style="display: none;">
		<div class="appLayer">
			<h4>모바일 앱 전용 쇼핑 혜택</h4>
				<a href="javascript:///" class="close" onclick="onoff('benefit_layer')">창닫기</a>
			<p class="txt">
				에누리 앱(APP) 설치 후<br />e머니 적립내역 확인 및<br />다양한 e쿠폰 상품으로 교환할 수 있습니다.
			</p>
			<p class="btn_close">
				<button type="button" onclick="install_btt();">설치하기</button>
			</p>
		</div>
	</div>
		<span class="go_top"><a onclick="$(window).scrollTop(0);">TOP</a></span>  
    </div>

<script type="text/javascript">
var vChkId = "<%=chkId%>"; //user-data
var app = getCookie("appYN"); //app인지 여부
var username = "<%=userArea%>"; //개인화영역 이름
var	vEvent_page = "<%=strUrl%>";

(function(){
	if(islogin()){ //로그인상태인 경우 개인e머니 내역 노출
		getPoint();
	}
	
	//닫기버튼
	 $( ".win_close" ).click(function(){
	        if(app == 'Y')            window.location.href = "close://";
	        else            window.location.replace("/mobilefirst/index.jsp");
	});
})();
$(function(){
	var vEvent_title = Number("<%=startDate%>".substring(4,6)) + "월_구매" ,
		share_title = "[에누리 가격비교]\n스마트한 쇼핑혜택!\n앱에서 구매하고 무제한 추가적립 받자!";

	if(<%=isPush%>){
		ga('send', 'event', 'mf_event', vEvent_title, 'push클릭');
	}
	//트래픽체크
    if(app =='Y' ){
        ga('send', 'pageview', {
            'page': vEvent_page,
            'title': vEvent_title+'_APP'
        });
    }else{
        ga('send', 'pageview', {
            'page': vEvent_page,
            'title': vEvent_title+'_WEB'
        });
    }

    //앵커이동
    var tab = "<%=tab%>";
    var head = $(".nav").outerHeight();

    if(tab == "1"){
        var offset = $("#evt1").offset();
        $("html,body").stop(true).animate({scrollTop:offset.top - head - 30},500,"swing");
    }else if(tab == "2"){
        var offset = $("#evt2").offset();
        $("html,body").stop(true).animate({scrollTop:offset.top - head - 30},500,"swing");
    }else if(tab == "3"){
        var offset = $(".benefit").offset();
        $("html,body").stop(true).animate({scrollTop:offset.top - head - 30},500,"swing");
    }else if(tab == "4"){
        var offset = $("#evt3").offset();
        $("html,body").stop(true).animate({scrollTop:offset.top - head - 30},500,"swing");
    }

    $("#doubleSaving").click(function(){
    	eventCall( { eventName : "더블적립", eventCode : "<%=eventCode1%>" } );
    });

    $("#unlimitSaving").click(function(){
    	eventCall( { eventName : "무제한적립", eventCode : "<%=eventCode2%>" } );
    });
    
	//상단탭
    $("#tabmenu > li").click(function(e){
    	var idx = $(this).index();
    	var vUrl = "";
    	var vLabel = "";
    	
    	if(idx == 0){
    		vUrl = "/mobilefirst/evt/visit_event.jsp?tab=1&freetoken=eventclone";
    		vLabel = "출석체크";
    	}else if(idx == 1){
    		vUrl = "/mobilefirst/evt/welcome_event.jsp?tab=1&freetoken=eventclone";
    		vLabel = "첫구매";
    	}else if(idx == 2){
    		vUrl = "/mobilefirst/evt/welcome_event.jsp?tab=2&freetoken=eventclone";
    		vLabel = "스탬프";
    	}else if(idx == 3){
    		vUrl = "/mobilefirst/evt/welcome_event.jsp?tab=3&freetoken=eventclone";
    		vLabel = "컴백혜택";
    	}
	    ga('send', 'event', 'mf_event', 'VIP 프로모션', vLabel);
    	window.open(vUrl);
    	return false;
    });

	// 유의사항 드롭다운
	$('.btn_check').click(function(){
		var _this = $(this);
		if(_this.siblings(".moreview").toggle().hasClass("buysaving")){
		    ga('send', 'event', 'mf_event', 'VIP 프로모션', '구매적립 유의사항');
		}
		$(".btn_check_hide").click(function(){
			$(this).parents(".moreview").slideUp();
			$('html,body').stop().animate({scrollTop:_this.offset().top - 71});
			return false;
		})
	});

	$(window).scroll(function(){
		// 윈도우 닫기버튼
		if($(this).scrollTop() >= $(".evt_visual").offset().top){
			$(".myarea").addClass("f-nav");
		}else{
			$(".myarea").removeClass("f-nav");
		}
	});
	//클릭가능여부
	var isClick = true;
	
	function eventCall ( eventObj ){
		var sdt = "<%=sdt%>";
		var endDate = "<%=endDate%>";

		if(sdt > endDate){
	    	alert('이벤트 종료!\n다음 이벤트는\n곧 오픈 예정입니다.');
	    	return false;
	    }
		if( getCookie("appYN") == 'Y' ){
		    ga('send', 'event', vEvent_title+'_APP', 'button', eventObj.eventName + '_이벤트 참여하기');
		} else {
		    ga('send', 'event', vEvent_title+'_WEB', 'button', eventObj.eventName + '_이벤트 참여하기');
		    onoff("app_only");
		    return false;
		}

		if(!islogin()){
			goLogin();
			return false;
		}
		
		if(!isClick){
			return false;
		}
		isClick = false;
		$.post("/mobilefirst/event2016/ajax/ajax_event_buy.jsp" , {"osType" : getOsType(), eventCode : eventObj.eventCode } ,
			function(json){
				if(json.result == "chk1"){
					alert("이미 참여해주셨습니다!\n한 번만 응모해도 구매금액 자동 누적됩니다.");
				}else if(json.result == -4){
					alert("SDU 회원은 본인인증 후 참여 가능합니다.\n※ 본인인증은 ‘앱 설정 > 본인인증’ 또는 ‘PC >\n개인정보관리 화면’을 이용해주세요");
				}else{
					alert("응모 완료!\n" + eventObj.eventName + " 지급일을 기다려주세요~");
				}
				isClick = true;
				return false;
			}, "json");

		function getOsType(){
		    var osType = "";
		    if(app =='Y'){
		         if(navigator.userAgent.indexOf("Android") > -1)
		        	 osType = "MAA";
		         else
		        	 osType = "MAI";
		    }else {
		         if(navigator.userAgent.indexOf("Android") > -1)
		        	 osType = "MWA";
		         else
		        	 osType = "MWI";
		    }
		    return osType;
		}
	}
});
</script>
<script language="JavaScript" src="http://imgenuri.enuri.gscdn.com/common/js/Log_Tail_Mobile.js"></script>
</body>
</html>
