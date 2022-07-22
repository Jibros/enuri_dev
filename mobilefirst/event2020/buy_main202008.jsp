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
    
    boolean isNext =true;  
    
    String strUrl = request.getRequestURI();
    String tab = ChkNull.chkStr(request.getParameter("tab"));

    String eventCode1 = request.getParameter("eventCode1");
    String eventCode2 = request.getParameter("eventCode2");

    String startDate = request.getParameter("startDate");
    String endDate = request.getParameter("endDate");
    String inflowType = request.getParameter("inflowType");
    String dday = request.getParameter("dday");
    
    String strFb_title = request.getParameter("strFb_title");
    String strFb_description = request.getParameter("strFb_description");
    String strFb_img = request.getParameter("strFb_img");
    boolean isPush=false;
    //유입경로가 푸쉬메시지인 경우
    if(inflowType.equals("pmsg"))  isPush=true;
%>
<body>

<div class="wrap">
	<!-- 이벤트 상단 -->
	<%@include file="/eventPlanZone/jsp/eventMovingTapMobile.jsp"%>
	<!-- //이벤트 상단 -->
		<!-- 상단비주얼 -->
		<div class="evt_visual visual intro end">
			<button class="com__btn_share" onclick="$('.com__share_wrap').show();">공유하기</button>
			<div class="inner">			
				<span class="txt_01">구매 혜택</span>
				<h2 class="tit1">특권에-누리다</h2>
				<!-- <h2 class="tit2">특별에-누리다</h2>
				<h2 class="tit3">무한에-누리다</h2> -->
	
				<span class="txt_02">천만원 이상 구매고객님께만 드리는 특별 혜택!</span>
				<span class="box_wrap">
					<span class="card1"><!-- 앞카드 --></span>
					<span class="card2"><!-- 뒷카드 --></span>
					<span class="ruby"><!-- 보석 --></span>
				</span>				
			</div>
			<div class="obj_flow_01"> <!-- 파랑색 flow object -->
				<div class="bg_flow flow_obj_01"></div>
				<div class="bg_flow flow_obj_02"></div>
			</div>
			<div class="obj_flow_02"> <!-- 분홍색 flow object -->
				<div class="bg_flow flow_obj_01"></div>
				<div class="bg_flow flow_obj_02"></div>
			</div>
			<div class="obj_flow_03"> <!-- 흰색 flow object -->
				<div class="bg_flow flow_obj_01"></div>
				<div class="bg_flow flow_obj_02"></div>
			</div>
			<div class="loader-box">
				<div class="visual-loader"></div>
			</div>
			<script>
				$(window).load(function(){
					var $visual = $(".evt_visual.visual");
					$visual.addClass("intro");
					setTimeout(function(){
						$visual.addClass("end");
					},2600)
				})
			</script>
			<!-- <div class="contents">
				<h1 class="blind">특별한 회원들을 위한 Special 혜택</h1>
				<p class="blind">천만원 이상 구매고객이라면 제한없는 추가적립 혜택을 누리세요.</p>
			</div> -->
		</div>
	<div class="evt_content contents">	
		<div class="section floattab">
			<div class="contents">
				<div class="inner">
					<ul class="floattab__list">
						<li class="tab1"><a href="javascript:///" class="floattab__item floattab__item--01">출석&룰렛</a></li>
						<li class="tab2"><a href="javascript:///" class="floattab__item floattab__item--02">100원딜</a></li>
						<li class="tab3"><a href="javascript:///" class="floattab__item floattab__item--03">구매혜택</a></li>
						<li class="tab4"><a href="javascript:///" class="floattab__item floattab__item--04">생일&amp;컴백</a></li>
						<li class="tab5"><a href="javascript:///" class="floattab__item floattab__item--05 is-on">VIP혜택</a></li>
					</ul>
				</div>
			</div>
		</div>
		<div id="evt1" class="evt-double">
			<div class="contents">
				<div class="double__head">
					<div class="blind">
						<h2>더블적립</h2>
						<p>카테고리 상관없이! 최대 e머니 200만점 추가적립!</p>
					</div>
					
					<a href="javascript:///" class="btn btn-join" id="doubleSaving">더블적립 신청하기</a>
				</div>
				<div class="double__cont">
					<div class="inner">
						<div class="txt_box">
							<ul>
								<li><strong>일반 상품 구매금액별 추가 적립률 및 최대 적립액</strong>
									<ul class="ul-sub">
										<li>- 2억이상: 1% 추가적립 / 최대 200만점</li>
										<li>- 1억이상: 1% 추가적립 / 최대 100만점</li>
										<li>- 5천만원~1억미만: 0.7% 추가적립 / 최대 50만점</li>
										<li>- 3천만원~5천만원미만: 0.5% 추가적립 / 최대 20만점</li>
										<li>- 1천만원~3천만원미만: 0.4% 추가적립 / 최대 10만점</li>
									</ul>
								</li>
								<li><strong>상품권 구매금액별 추가 적립률 및 최대 적립액</strong>
									<ul class="ul-sub">
										<li>- 2억이상: 0.6% 추가적립 / 최대 200만점</li>
										<li>- 1억이상: 0.5% 추가적립 / 최대 100만점</li>
										<li>- 5천만원~1억미만: 0.4% 추가적립 / 최대 30만점</li>
                                        <li>- 1천만원~5천만원미만: 0.3% 추가적립 / 최대 10만점</li>
                                        <li class="stress"><b>※ 상품권 대상 쇼핑몰: G마켓, 옥션, 위메프 (티몬제외)</b></li>
									</ul>
								</li>
							</ul>
                        </div>
                        <!-- // -->
					</div>
					
					<!-- 버튼 : 꼭 확인하세요 -->
					<div class="com__evt_notice">
						<div class="evt_notice--btn_area"><button class="btn__evt_notice" data-laypop-id="slidePop1"><span>꼭! 확인하세요</span></button></div> <!-- 열기 : 유의사항 열기 -->
					</div>
					<div id="slidePop1" class="evt_notice--slide">
						<div class="evt_notice--inner">
							<div class="evt_notice--head">유의사항</div>
							<div class="evt_notice--cont">
								<div class="evt_notice--continner">
									<dl>
										<dt>이벤트 대상 및 혜택</dt>
										<dd>
											<ul>
												<!-- 200717 : 날짜/문구 변경 -->
												<li>이벤트 대상 : 이벤트 기간 내 1천만원 이상 구매 후 더블적립 이벤트 신청한 고객</li>
												<li>이벤트 기간 : 2020년 8월 3일 ~ 8월 31일</li>
												<li>이벤트 혜택 : 구매금액별 일반상품, 상품권 차등 적립(최대 e머니 2,000,000점 / ※ 이벤트 혜택 상세 확인)</li>
												<li>혜택 지급일 :&nbsp;2020년 10월 22일<br>
													<ul class="sub">
														<li>- 에누리 가격비교 PC &gt; 고객센터 &gt; 공지사항 </li>
														<li>- 에누리 가격비교 APP &gt; 이벤트/기획전탭 &gt; 이벤트혜택 &gt; 하단 [당첨자/공지] </li>
													</ul>
												</li>
												<!-- // -->
												<li><span class="stress">e머니 유효기간 : 적립일로부터 15일 (유효기간 만료 후 재적립 불가)</span><br>
													<span class="noti">※ 적립된 e머니는 e쿠폰 스토어에서 다양한 쿠폰으로 교환가능합니다.</span>
												</li>
											</ul>
										</dd>
									</dl>
	
									<h1 class="htit">이벤트 혜택 상세</h1>
									<dl>
										<dt>일반상품</dt>
										<dd>
											<ul>
												<li>일반상품 1천만원 이상 구매 시 최대 200만점 추가적립<br><span class="stress">(※ 순금, 순은, 돌반지, 골드바, 실버바 구매시에도 가능)</span></li>
												<li>일반상품+상품권 함께 구매 시 '일반상품'에 대해서만 아래 적립률 적용 (※ 별도 적용)</li>
												<li>일반상품 구매금액별 추가 적립률 및 최대 적립액
													<table class="evt_noti_tb" style="width:300px;">
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
												</li>
											</ul>										
										</dd>
									</dl>
									<dl>
										<dt>상품권</dt>
										<dd>
											<ul>
												<li>상품권 1천만원 이상 구매 시 최대 200만점 추가적립</li>
												<li><span class="stress">대상 쇼핑몰 : 위메프, G마켓, 옥션 (티몬 제외)</span></li>
												<li><span class="stress">대상 상품권 : 문화상품권, 도서상품권, 백화점상품권, 영화예매권, 국민관광 상품권</span></li>
												<li>일반상품+상품권 함께 구매 시 ‘상품권’에 대해서만 아래 적립률 적용 (※ 별도 적용)</li>
												<li>상품권 구매금액별 추가 적립률 및 최대 적립액
													<table class="evt_noti_tb" style="width:300px;">
														<tbody>
															<tr>
																<th>구매금액</th>
																<th>추가적립률</th>
																<th>최대 적립액</th>
															</tr>
															<tr>
																<td>2억 이상</td>
																<td>0.6%</td>
																<td>2,000,000</td>
															</tr>
															<tr>
																<td>1억 이상</td>
																<td>0.5%</td>
																<td>1,000,000</td>
															</tr>
															<tr>
																<td>5천만원 ~ 1억 미만</td>
																<td>0.4%</td>
																<td>300,000</td>
															</tr>
															<tr>
																<td>1천만원 ~ 5천만원 미만</td>
																<td>0.3%</td>
																<td>100,000</td>
															</tr>
														</tbody>
													</table>
												</li>
											</ul>
										</dd>
									</dl>
									<dl>
										<dt>이벤트 참여방법 및 유의사항</dt>
										<dd>									
											<ul>
												<li>참여방법 : 에누리 가격비교 모바일 앱 로그인 → 적립대상 쇼핑몰 이동 →&nbsp;<span class="stress">1천만원 이상 구매</span>&nbsp;→ 더블적립 이벤트 신청<br>
													※ 이벤트 참여의 경우 PC 및 모바일 앱/웹에서 로그인 후에도 가능합니다.
												</li>
												<li>적립대상 쇼핑몰 : G마켓, 옥션, 11번가, 인터파크, 티몬, 위메프, 쿠팡, GS SHOP, CJmall, SSG (신세계몰, 신세계백화점, 이마트몰, 트레이더스), SK스토아, 홈플러스<br>
													<span class="stress" style="letter-spacing:-.5px;">※ 구매 유의사항 및 구매적립 제외 카테고리는 이벤트 페이지 하단 'e머니 구매혜택' 유의사항을 꼭 확인하세요.</span>
												</li>
												<li>구매금액은 배송비, 설치비, 할인, 쇼핑몰 포인트 등 제외한 금액만 반영됩니다.</li>
												<li>이벤트 기간 내 구매 건 중 2020년 9월 30일까지의 구매확정(배송완료)건 기준으로 이벤트 대상자 선정됩니다.</li>
												<li><span class="stress">구매 후 취소하였으나 적립된 e머니가 있을 경우 해당 적립액은 혜택 지급 제외됩니다.</span></li>
												<li><span class="stress">이벤트 대상 제외 :</span> 아래의 경우에는 이벤트 대상 및 혜택 지급에서 제외됩니다. <br>
													<ul class="sub">
														<li>- 이벤트 신청하지 않은 경우</li>
														<li>- 실제 구매금액이 1천만원 미만의 구매일 경우</li>
														<li>- 구매적립 제외 카테고리 구매일 경우 </li>
														<li>- 구매 후 취소/환불/교환/반품한 경우 </li>
														<li>- 해외직구 상품 구매일 경우</li>
														<li><span class="stress">- 동일한 이벤트 기간의 무제한 적립 이벤트 혜택 받은 경우 (중복 지급 불가)</span></li>
													</ul>
												</li>
												<li><span class="stress">[상품권] 이벤트 대상 제외 :</span> 아래의 경우에는 이벤트 대상 상품권이라도 혜택 지급에서 제외 됩니다. (사용/교환/등록/충전 여부 상관없음)<br>
													※ 상품권의 경우 판매자가 상품 페이지 내용 변경 시 취소/환불기간 내역 증빙이 어려운 관계로, 상품권 이벤트 대상자는 구매시점이 아닌 혜택 지급시점 기준으로 선정됩니다. 필요 시 해당 상품의 취소/환불 규정이 변동 가능성을 판매자와 확인하신 후 참여해주세요.<br>
													<ul class="sub">
														<li>- 상품 구매 페이지 내 취소/환불기간이 30일 이상으로 명시되어 있는 경우</li>
														<li>- 상품 구매 페이지 내 취소/환불기간이 명시되어 있지 않은 경우</li>
														<li>- 상품 구매 페이지 내 취소/환불기준이 여러가지로 명시된 경우, 한군데라도 취소/환불기간이 30일 이상으로 명시되어 있는 경우</li>
														<li>- 상품 특성상 이벤트 기간 이후 취소/환불 가능한 상품</li>
													</ul>
												</li>
											</ul>
										</dd>
									</dl>
									<dl>
										<dt>공통 이벤트 유의사항</dt>
										<dd>
											<ul>
												<li>부정 참여 시 본 이벤트 대상 제외 및 혜택 지급이 취소될 수 있습니다.</li>
												<li>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</li>
											</ul>
										</dd>
									</dl>
								</div>
							</div>
							<div class="evt_notice--foot">						
								<button class="btn__evt_confirm">확인</button> <!-- 닫기 : 유의사항 닫기 -->
							</div>
						</div>
					</div>
					<!-- // -->
				</div>
			</div>
		</div>
		
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
								<li><strong>대상 카테고리</strong>
									<ul class="ul-sub">
										<li>컴퓨터, 부품, 영상/디카, 디지털, 주방가전, 생활가전, 계절가전</li>
									</ul>
								</li>
								<li><strong>추가 적립률 및 최대 적립액</strong>
									<ul class="ul-sub">
                                        <li>1천만원 이상 구매시 : 0.7% 추가적립 / 최대 적립액 제한 없음</li>
                                        <li class="stress"><b>※ 무제한 추가적립 우선 적용되며, 더블적립 중복지급 불가합니다.</b></li>
									</ul>
								</li>
							</ul>
                        </div>
					</div>
					
					<!-- 버튼 : 꼭 확인하세요 -->
					<div class="com__evt_notice">
						<div class="evt_notice--btn_area"><button class="btn__evt_notice" data-laypop-id="slidePop2"><span>꼭! 확인하세요</span></button></div> <!-- 열기 : 유의사항 열기 -->
					</div>
					<div id="slidePop2" class="evt_notice--slide">
						<div class="evt_notice--inner">
							<div class="evt_notice--head">유의사항</div>
							<div class="evt_notice--cont">
								<div class="evt_notice--continner">
									<dl>
										<dt>이벤트 대상 및 혜택</dt>
										<dd>
											<ul>
												<!-- 200717 : 날짜/문구 변경 -->
												<li>이벤트 대상 : 이벤트 기간 내 대상 카테고리 1천만원 이상 구매 후 무제한 추가적립 이벤트 신청한 고객 (※ 대상 카테고리 상세 확인)</li>
												<li>이벤트 기간 : 2020년 8월 3일 ~ 8월 31일</li>
												<li>이벤트 혜택 : 구매금액별 대상 카테고리 0.7% 추가 적립 (최대 e머니 적립금액 제한없음)</li>
												<li>혜택 지급일 :&nbsp;2020년 10월 22일
													<ul class="sub">
														<li>- 에누리 가격비교 PC &gt; 고객센터 &gt; 공지사항 </li>
														<li>- 에누리 가격비교 APP &gt; 이벤트/기획전탭 &gt; 이벤트혜택 &gt; 하단 [당첨자/공지] </li>
													</ul>
												</li>
												<li><span class="stress">e머니 유효기간 : 적립일로부터 15일 (유효기간 만료 후 재적립 불가)</span><br>
													※ 적립된 e머니는 e쿠폰 스토어에서 다양한 쿠폰으로 교환가능합니다.
												</li>
											</ul>
										</dd>
									</dl>
									<dl>
										<dt>대상 카테고리 상세</dt>
										   <dd>
											<ul>
												<li>대상 카테고리 : 컴퓨터, 부품, 영상/디카, 디지털, 주방가전, 생활가전, 계절가전 (총 7개)</li>
											</ul>
										</dd>
									</dl>
									<dl>
										<dt>이벤트 참여방법 및 유의사항</dt>
										<dd>									
											<ul>
												<li>참여방법 : 에누리 가격비교 모바일 앱 로그인 → 적립대상 쇼핑몰 이동 →&nbsp;<span class="stress">대상 카테고리 1천만원 이상 구매</span>&nbsp;→ 무제한 추가적립 이벤트 신청<br>
													※ 이벤트 참여의 경우 PC 및 모바일 앱/웹에서 로그인 후에도 가능합니다.
												</li>
												<li>적립대상 쇼핑몰 : G마켓, 옥션, 11번가, 인터파크, 티몬, 위메프, 쿠팡, GS SHOP, CJmall, SSG (신세계몰, 신세계백화점, 이마트몰, 트레이더스), SK스토아, 홈플러스<br>
													<span class="stress" style="letter-spacing:-.5px;">※ 구매 유의사항 및 구매적립 제외 카테고리는 이벤트 페이지 하단 'e머니 구매혜택' 유의사항을 꼭 확인하세요.</span>
												</li>
												<li>구매금액은 배송비, 설치비, 할인, 쇼핑몰 포인트 등 제외한 금액만 반영됩니다.</li>
												<li>이벤트 기간 내 구매 건 중 2020년 9월 30일까지의 구매확정(배송완료)건 기준으로 이벤트 대상자 선정됩니다.</li>
												<li><span class="stress">구매 후 취소하였으나 적립된 e머니가 있을 경우 해당 적립액은 혜택 지급 제외됩니다.</span></li>
												<li><span class="stress">동일한 이벤트 기간의 무제한 추가적립 이벤트 우선 적용되며, 더블적립 이벤트 혜택과 중복 지급 불가합니다. </span></li>
												<li><span class="stress">이벤트 대상 제외 :</span> 아래의 경우에는 이벤트 대상 및 혜택 지급에서 제외됩니다. <br>
													<ul class="sub">
														<li>- 이벤트 신청하지 않은 경우</li>
														<li>- 실제 구매금액이 1천만원 미만의 구매일 경우</li>
														<li>- 구매적립 제외 카테고리 구매일 경우 </li>
														<li>- 구매 후 취소/환불/교환/반품한 경우 </li>
														<li>- 해외직구 상품 구매일 경우</li>
														<li><span class="stress">- 무제한 추가적립 대상 카테고리 외 다른 카테고리 구매일 경우</span></li>
													</ul>
												</li>
											</ul>
										</dd>
									</dl>
									<dl>
										<dt>공통 이벤트 유의사항</dt>
										<dd>
											<ul>
												<li>부정 참여 시 본 이벤트 대상 제외 및 혜택 지급이 취소될 수 있습니다.</li>
												<li>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</li>
											</ul>
										</dd>
									</dl>
								</div>
							</div>
							<div class="evt_notice--foot">						
								<button class="btn__evt_confirm">확인</button> <!-- 닫기 : 유의사항 닫기 -->
							</div>
						</div>
					</div>
					<!-- // -->
				</div>
			</div>
		</div>
		<div class="evt-bestcategory">
			<div class="contents">
				<div class="bestcategory__head">
					<div class="inner">
						<h2 class="tit">추가적립 인기 카테고리</h2>
					</div>
				</div>
				<div class="bestcategory__cont">
					<div class="inner">
						<ul class="catelist">
							<li><a href="http://m.enuri.com/mobilefirst/list.jsp?cate=1505" class="btn_round" target="_blank">커피,차</a></li>
							<li><a href="http://m.enuri.com/mobilefirst/list.jsp?cate=1647" class="btn_round" target="_blank">상품권</a></li>
							<li><a href="http://m.enuri.com/mobilefirst/list.jsp?cate=0404" class="btn_round" target="_blank">노트북</a></li>
							<li><a href="http://m.enuri.com/mobilefirst/list.jsp?cate=0707" class="btn_round" target="_blank">CPU,쿨러</a></li>
							<li><a href="http://m.enuri.com/mobilefirst/list.jsp?cate=0234" class="btn_round" target="_blank">DSLR 디카</a></li>
							<li><a href="http://m.enuri.com/mobilefirst/list.jsp?cate=0304" class="btn_round" target="_blank">스마트폰</a></li>
							<li><a href="http://m.enuri.com/mobilefirst/list.jsp?cate=0602" class="btn_round" target="_blank">냉장고</a></li>
							<li><a href="http://m.enuri.com/mobilefirst/list.jsp?cate=0502" class="btn_round" target="_blank">세탁기,건조기</a></li>
							<li><a href="http://m.enuri.com/mobilefirst/list.jsp?cate=2406" class="btn_round" target="_blank">공기청정기</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<%@ include file="/mobilefirst/evt/event_bottom.jsp"%><!-- 생활혜택 -->
	</div>
</div>
<span class="go_top"><a href="#">TOP</a></span>
	<!-- 상단비주얼 -->
<div class="layer_back" id="app_only" style="display:none;">
	<div class="appLayer">
		<h4>모바일 앱 전용 이벤트</h4>
		<a href="javascript:///" class="close" onclick="onoff('app_only')">창닫기</a>
		<p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br>에누리앱을 설치합니다.</p>
		<p class="btn_close"><button type="button">설치하기</button></p>
	</div>
</div>
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
<div class="com__share_wrap dim" style="z-index:10000;display:none">
	<div class="com__layer share_layer">
		<div class="lay_head">공유하기</div>
		<a href="#close" class="lay_close" onclick="$(this).closest('.dim').fadeOut(200);return false;">닫기</a>
		<div class="lay_inner">
			<ul id="eventShr">
				<li class="share_fb" id="fbShare">페이스북 공유하기</li>
				<li class="share_kakao" id="kakao-link-btn">카카오톡 공유하기</li>				
				<li class="share_tw" id="twShare">트위터 공유하기</li>
				<!-- <li class="share_line">라인 공유하기</li> -->
				<!-- 메일아이콘 클릭시 활성화(.on) -->
				<!-- <li class="share_mail" onclick="$(this).toggleClass('on');$(this).parents('.share_layer').find('.btn_wrap').toggleClass('mail_on');">메일로 공유하기</li> -->
				<!-- <li class="share_story">카카오스토리 공유하기</li> -->
				<!-- <li class="share_band">밴드 공유하기</li> -->
			</ul>
			<!-- 메일보내기 버튼클릭시 .mail_on 추가해 주세요 -->
			<div class="btn_wrap">
				<div class="btn_group">
					<!-- 주소복사하기 -->
					<div class="btn_item">
						<span id="txtURL" class="txt__share_url">http://www.enuri.com/event/chuseok.jsp</span>
						<button class="btn__share_copy" data-clipboard-target="#txtURL">복사</button>
					</div>
					<!-- 이메일주소 입력하기 -->
					<div class="btn_item">
						<input type="text" class="txt__share_mail" placeholder="이메일 주소 입력해 주세요">
						<button class="btn__share_mail">보내기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript" src="/js/clipboard.min.js"></script>
	<script>
		$(function(){
			var clipboard = new ClipboardJS('.com__share_wrap .btn__share_copy');
			clipboard.on('success', function(e) {
				alert('주소가 복사되었습니다');
			});
			clipboard.on('error', function(e) {
				console.log(e);
			});
		});
	</script>
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
	        if(app == 'Y')  window.location.href = "close://";
			else			window.location.replace("/m/index.jsp");
	});
	$(".keyword").hide();
})();
$(function(){
	
	$("#eventShr > li").click(function(){
		var sel = $(this).attr("id");
		var shareTitle = "[에누리 가격비교] 에누리 VIP 혜택! 특별한 회원들을 위한 Special 혜택! 제한없는 추가적립 혜택을 누리세요.";
		if(sel == "fbShare"){
			try{
				window.android.android_window_open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(shareTitle)+"&u="+shareUrl);
			}catch(e){
				window.open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(shareTitle)+"&u="+shareUrl);
			}	
		}else if(sel == "twShare"){
			try {
				window.android
						.android_window_open("http://twitter.com/intent/tweet?text="
								+ encodeURIComponent(shareTitle)
								+ "&url=" + shareUrl);
			} catch (e) {
				window.open("http://twitter.com/intent/tweet?text="
						+ encodeURIComponent(shareTitle) + "&url="
						+ shareUrl);
			}
		}
	});
	
	var vEvent_title = Number("<%=startDate%>".substring(4,6)) + "월_구매" ,
		share_title = "[에누리 가격비교]\n스마트한 쇼핑혜택!\n앱에서 구매하고 무제한 추가적립 받자!";

	if(<%=isPush%>){
		ga('send', 'event', 'mf_event', vEvent_title, 'push클릭');
	}
	//트래픽체크
    if(app =='Y' )     ga('send', 'pageview', {'page': vEvent_page,'title': vEvent_title+'_APP'});
    else 		       ga('send', 'pageview', {'page': vEvent_page,'title': vEvent_title+'_WEB'});

    $(".catelist > li").click(function(){
		var inx = $(this).index();
		if(inx == 0){
			ga('send', 'event', 'mf_event', 'VIP 프로모션','cate_커피,차');
			window.open("/mobilefirst/list.jsp?cate=1505");
		}else if(inx == 1){
			ga('send', 'event', 'mf_event', 'VIP 프로모션','cate_상품권');
			window.open("/mobilefirst/list.jsp?cate=1647");
		}else if(inx == 2){
			ga('send', 'event', 'mf_event', 'VIP 프로모션','cate_노트북');
			window.open("/mobilefirst/list.jsp?cate=0404");
		}else if(inx == 3){
			ga('send', 'event', 'mf_event', 'VIP 프로모션','cate_CPU,쿨러');
			window.open("/mobilefirst/list.jsp?cate=0707");
		}else if(inx == 4){
			ga('send', 'event', 'mf_event', 'VIP 프로모션','cate_DSLR 디카');
			window.open("/mobilefirst/list.jsp?cate=0234");
		}else if(inx == 5){
			ga('send', 'event', 'mf_event', 'VIP 프로모션','cate_스마트폰');
			window.open("/mobilefirst/list.jsp?cate=0304");
		}else if(inx == 6){
			ga('send', 'event', 'mf_event', 'VIP 프로모션','cate_냉장고');
			window.open("/mobilefirst/list.jsp?cate=0602");
		}else if(inx == 7){
			ga('send', 'event', 'mf_event', 'VIP 프로모션','cate_세탁기,건조기');
			window.open("/mobilefirst/list.jsp?cate=0502");
		}else if(inx == 8){
			ga('send', 'event', 'mf_event', 'VIP 프로모션','cate_공기청정기');
			window.open("/mobilefirst/list.jsp?cate=2406");
		}
	});
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

    $("#doubleSaving").click(function(){	eventCall( { eventName : "더블적립", eventCode : "<%=eventCode1%>" } );    });
    $("#unlimitSaving").click(function(){    	eventCall( { eventName : "무제한적립", eventCode : "<%=eventCode2%>" } );    });
    
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
	
	$(".floattab__list > li").click(function(e){
		
		var idx = $(this).index();
    	var vUrl = "";
    	var vLabel = "";
    	
		if(idx == 0){//출석
			vLabel = "출석텝";
			window.open("/mobilefirst/evt/visit_event.jsp?freetoken=event");
		}else if(idx == 1){//첫구매
			vLabel = "첫구매";
			window.open("/mobilefirst/evt/firstbuy_event.jsp?freetoken=event");			
		}else if(idx == 2){
			vLabel = "누구나구매혜택";
			window.open("/mobilefirst/evt/smart_benefits.jsp?freetoken=event");
		}else if(idx == 3){
			vLabel = "생일&컴백";
			window.open("/mobilefirst/evt/birthday_event.jsp?freetoken=event");
		}else if(idx == 4){
			vLabel = "더블적립";
			window.open("/mobilefirst/evt/buy_event.jsp?freetoken=event");
		}
	    ga('send', 'event', 'mf_event', 'VIP 프로모션', vLabel);
    	//window.open(vUrl);
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
		if($(this).scrollTop() >= $(".evt_visual").offset().top)	$(".myarea").addClass("f-nav");
		else														$(".myarea").removeClass("f-nav");
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
		}

		if(!islogin()){
			goLogin();
			return false;
		}
		if(!isClick)			return false;
		
		$.post("/mobilefirst/event2016/ajax/ajax_event_buy.jsp" , {"osType" : getOsType(), eventCode : eventObj.eventCode , kind : "Y"  } ,
				function(json){	
		
			if(json.payYN == 0){
			
				var r = confirm("본 프로모션은 유의사항 확인 후 신청이 가능하십니다.");
				if (r == false){
					alert("유의사항 확인 후 참여가 가능합니다.");
					return false;
				}else{
					gogo();
				}
				
			}else{
				gogo();
			}
		
			}, "json").fail( function(xhr, textStatus, errorThrown) {
			
	    });
		
		function gogo(){
			
			isClick = false;
			$.post("/mobilefirst/event2016/ajax/ajax_event_buy.jsp" , {"osType" : getOsType(), eventCode : eventObj.eventCode } ,
				function(json){
					if(json.result == "chk1"){
						alert("이미 참여해주셨습니다!\n한 번만 응모해도 구매금액 자동 누적됩니다.");
					}else if(json.result == -4){
						alert("SDU 회원은 본인인증 후 참여 가능합니다.\n※ 본인인증은 ‘앱 설정 > 본인인증’ 또는 ‘PC >\n개인정보관리 화면’을 이용해주세요");
					}else if(json.result == -5){
						var r = confirm("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?");
						if(r){
							location.href = "https://m.enuri.com/mobilefirst/member/myAuth.jsp?cmdType=&f=m&freetoken=login_title";
						}
					}else{
						alert("응모 완료!\n" + eventObj.eventName + " 지급일을 기다려주세요~");
					}
					isClick = true;
					return false;
				}, "json").fail( function(xhr, textStatus, errorThrown) {
					isClick = true;
			    });
		}

	}

	$(window).scroll(function(){
		// 윈도우 닫기버튼
		if($(this).scrollTop() >= $(".evt_visual").offset().top){
			$(".myarea").addClass("f-nav");
		}else{
			$(".myarea").removeClass("f-nav");
		}
	});

});
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
			$(".myarea").addClass("f-nav");
		} else {
			$nav.removeClass("is-fixed");
			$(".visual").css("margin-bottom", 0);
			$(".myarea").removeClass("f-nav");
		}
	});
}(window, window.jQuery));
// onoff 레이어
function onoff(id) {
	var mid=document.getElementById(id);
	if(mid.style.display=='') {
		mid.style.display='none';
	}else{
		mid.style.display='';
	}
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
CmdShare();
function CmdShare(){
	Kakao.Link.createDefaultButton({
		  container: '#kakao-link-btn',
	      objectType: 'feed',
	      content: {
	        title: '<%=strFb_title%>',
	        description: '<%=strFb_description%>',
	        imageUrl: "<%=strFb_img%>",
	        imageWidth: 380,
	        imageHeight: 198,
	        link: {
	          webUrl: shareUrl,
	          mobileWebUrl: shareUrl
	        }
	      },
		buttons: [{
	          title: '에누리 가격비교',
	          link: {
	            mobileWebUrl: shareUrl,
	            webUrl: shareUrl
	          }
		}]
    });
}
</script>
<script language="JavaScript" src="<%=ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
</body>
</html>