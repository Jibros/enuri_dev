<%@page import="org.json.JSONObject"%>
<%@page import="com.enuri.bean.event.Event_PlusRsv_Proc"%>
<%
	boolean eventViewYn = false;
	String promViewYn = "";
	String event_id = "";
	String title_img_url_nm = "";
	String emoney_img_nm = "";
	String event_start_dt = "";
	String event_start_dt_str = "";
	String event_end_dt = "";
	String event_end_dt_str = "";
	String plus_rsv_rt_cts = "";
	String wrok_note = "";
	String event_dtl_id = "";

	JSONObject jSONObject = new JSONObject();
	String server_type = request.getServerName().contains("dev") ? "dev" : "real";
	try{
		//jSONObject = new Event_PlusRsv_Proc().getPlusRsvData_v2(server_type, numSdt,"R");
		// 2월 정기 프로모션 임시 생성(이벤트코드 뒷자리가 10 -> 02로 변경되면서 예외 추가)
		//jSONObject = new Event_PlusRsv_Proc().getPlusRsvData_v2(server_type, numSdt,"E");
		//jSONObject = new Event_PlusRsv_Proc().getPlusRsvData_v2(server_type, numSdt,"E"); // 4월 정기
		// 3웡 정기 프로모션 임시 생성(이벤트 시작일 1일->2일로 변경되면서 예외 추가)
		//jSONObject = new Event_PlusRsv_Proc().getPlusRsvData_v2(server_type, numSdt,"N");
		jSONObject = new Event_PlusRsv_Proc().getPlusRsvData_v2(server_type, numSdt,"P"); // 5월 정기

		if( !jSONObject.isNull("event_id") ){
			event_id			= jSONObject.getString("event_id");
			promViewYn			= jSONObject.getString("view_yn");				//프로모션 노출여부
			title_img_url_nm	= jSONObject.getString("title_img_url_nm");		//이벤트 정보
			emoney_img_nm  		= jSONObject.getString("emoney_img_nm");
			event_dtl_id 		= jSONObject.getString("event_dtl_id");
			event_start_dt  	= jSONObject.getString("event_start_dt");
			event_end_dt  		= jSONObject.getString("event_end_dt");

			event_start_dt_str	= event_start_dt.substring(0, 4)+"년 "+event_start_dt.substring(4, 6)+"월 "+event_start_dt.substring(6, 8)+"일";
			event_end_dt_str  	= event_end_dt.substring(0, 4)+"년 "+event_end_dt.substring(4, 6)+"월 "+event_end_dt.substring(6, 8)+"일";

			plus_rsv_rt_cts  	= jSONObject.getString("plus_rsv_rt_cts");
			wrok_note  			= jSONObject.getString("wrok_note");

			eventViewYn = true;
		}
 	}catch(Exception e){
		System.out.println(e.getMessage());
	}
%>
<%if(eventViewYn) {%>
<!-- 앱전용 최대5배 추가적립 -->
<div id="tab4" class="addsave_wrap">
	<!-- INNER -->
	<div class="inner">
		<div class="imgbox">

			<div class="top_area">
				<h2>구매혜택 02, 최대 5만점 추가 적립 - 받고 또 받는 카테고리 혜택!</h2>
			</div>

			<div class="addsave__cont">
				<img src="http://img.enuri.info/images/event/2020/buy_stamp/dec/evt2_cont.png" alt="e머니 50,000점">
			</div>

			<a href="javascript:///" id="plusRsvClk" >
				<img src="http://img.enuri.info/images/event/2019/buy_stamp/jul/m_btn_apply.png" alt="신청하기">
			</a>
			<div class="info_list">
				<!-- 201209 : 내용 수정 -->
				<ul>
					<li>· 이벤트 기간 : 2021년 5월 3일 ~ 2021년 5월 31일</li>
					<li>· 혜택 지급일 : 2021년 7월 22일</li>
					<li>· 카테고리별 적립률 및 적립액은 유의사항에서 확인하세요.</li>
				</ul>
				<!-- // -->
			</div>
            <a class="btn_cate" id="btnCategory" href="javascript:///" onclick="onoff('categoryLayer2'); return false;">
            	<img src="<%=ConfigManager.IMG_ENURI_COM%>/images/event/2020/buy_stamp/jul/btn_cate.png" alt="카테고리 확인하기" />
            </a>
            <div class="notice catelayer" id="categoryLayer2" style="display: none;">
				<div class="dim"></div>
				<div class="notice_layer cate_layer_open">
					<h4><span class="eico"> e머니</span>추가적립 카테고리</h4>
					<div class="cont">
						<ul id="targetCate">
						</ul>
					</div>
					<a class="btn layclose2" href="javascript:void(0);" onclick="onoff('categoryLayer2');return false"><em>팝업 닫기</em></a>
				</div>
			</div>
		</div>
	</div>
	<!-- //INNER -->
	<!-- 유의사항 WRAPPER -->
	<div class="com__evt_notice">
		<div class="evt_notice--btn_area"><button class="btn__evt_notice" data-laypop-id="slidePop2"><span>꼭! 확인하세요</span></button></div> <!-- 열기 : 유의사항 열기 -->
	</div>
	<div id="slidePop2" class="evt_notice--slide">
		<div class="evt_notice--inner"> <!-- .wide - 넓은 케이스 -->
			<div class="evt_notice--head">유의사항</div>
			<div class="evt_notice--cont">
				<!-- 201106 : 내용 수정 -->
				<div class="evt_notice--continner">
					<dl>
						<dt>이벤트 대상 및 혜택</dt>
						<dd>
							<ul>
								<li>이벤트 대상 : 이벤트 기간 내 1만원 이상 대상 카테고리 상품 구매 후 최대 5만점 추가적립 이벤트 신청한 고객 (※ 대상 카테고리 확인)</li>
								<li>이벤트 기간 : 2021년 5월 3일 ~ 2021년 5월 31일</li>
								<li>이벤트 혜택 : 카테고리별 차등 추가 적립(최대 e머니 50,000점)</li>
								<li>혜택 지급일 : 2021년 7월 22일<br/>
									- 에누리 가격비교 APP &gt; 이벤트/기획전탭 &gt; 이벤트혜택 &gt; 하단 [당첨자/공지]
								</li>
								<li>
									<span class="stress">e머니 유효기간 : 적립일로부터 15일 (유효기간 만료 후 재적립 불가)</span><br>
									※ 적립된 e머니는 e쿠폰 스토어에서 다양한 쿠폰으로 교환가능합니다.
								</li>

								<li>
									대상 카테고리별 추가 적립률 및 최대 적립액<br>
									<table class="evt_noti_tb">
										<colgroup>
											<col width="40%"><col width="20%"><col width="20%"><col width="20%">
										</colgroup>
										<tbody>
											<tr>
												<th>카테고리명</th>
												<th>기본 구매적립률</th>
												<th>e머니 추가적립률</th>
												<th>추가적립 한도</th>
											</tr>
											<!-- 210511 : SR#46664 : [PC/M] 21년 5월 카테고리추가적립 > 퍼블리싱 수정 -->
											<tr><td>데스크탑,미니PC</td><td>0.8%</td><td>1.0%</td><td>50,000</td></tr>
											<tr><td>노트북</td><td>0.8%</td><td>1.0%</td><td>50,000</td></tr>
											<tr><td>일체형PC</td><td>0.8%</td><td>1.0%</td><td>50,000</td></tr>
											<tr><td>스쿠터,오토바이</td><td>1.0%</td><td>1.0%</td><td>50,000</td></tr>
											<tr><td>에어컨,냉난방기</td><td>0.3%</td><td>1.0%</td><td>50,000</td></tr>
											<tr><td>TV</td><td>0.3%</td><td>0.7%</td><td>50,000</td></tr>
											<tr><td>미러리스</td><td>0.3%</td><td>0.7%</td><td>50,000</td></tr>
											<tr><td>렌즈</td><td>0.3%</td><td>0.7%</td><td>50,000</td></tr>
											<tr><td>휴대폰,스마트폰</td><td>0.3%</td><td>0.7%</td><td>50,000</td></tr>
											<tr><td>태블릿PC,전자책</td><td>0.3%</td><td>0.7%</td><td>50,000</td></tr>
											<tr><td>식기세척,살균기</td><td>0.3%</td><td>1.0%</td><td>50,000</td></tr>
											<tr><td>골프클럽</td><td>1.0%</td><td>1.0%</td><td>30,000</td></tr>
											<tr><td>램</td><td>0.8%</td><td>1.0%</td><td>30,000</td></tr>
											<tr><td>안마의자,안마기</td><td>0.3%</td><td>1.0%</td><td>30,000</td></tr>
											<tr><td>세탁기</td><td>0.3%</td><td>0.3%</td><td>30,000</td></tr>
											<tr><td>의류건조,관리기</td><td>0.3%</td><td>0.3%</td><td>30,000</td></tr>
											<tr><td>프로젝터</td><td>0.3%</td><td>0.7%</td><td>30,000</td></tr>
											<tr><td>가스,전기레인지</td><td>0.3%</td><td>1.0%</td><td>30,000</td></tr>
											<tr><td>모니터</td><td>0.8%</td><td>1.0%</td><td>20,000</td></tr>
											<tr><td>명품패션</td><td>0.3%</td><td>1.0%</td><td>20,000</td></tr>
											<tr><td>CPU</td><td>0.8%</td><td>1.0%</td><td>20,000</td></tr>
											<tr><td>그래픽카드</td><td>0.8%</td><td>0.7%</td><td>20,000</td></tr>
											<tr><td>전기밥솥</td><td>0.3%</td><td>1.0%</td><td>20,000</td></tr>
											<tr><td>게임기,게임SW</td><td>0.8%</td><td>1.0%</td><td>10,000</td></tr>
											<tr><td>자전거,킥보드</td><td>1.0%</td><td>1.0%</td><td>10,000</td></tr>
											<tr><td>시계</td><td>0.3%</td><td>1.0%</td><td>10,000</td></tr>
											<tr><td>메인보드</td><td>0.8%</td><td>0.7%</td><td>10,000</td></tr>
											<tr><td>파워서플라이</td><td>0.8%</td><td>0.7%</td><td>10,000</td></tr>
											<tr><td>디지털피아노</td><td>0.2%</td><td>1.0%</td><td>10,000</td></tr>
											<tr><td>청소기</td><td>0.3%</td><td>0.3%</td><td>10,000</td></tr>
											<tr><td>헤어기기,탈모관리기</td><td>0.3%</td><td>0.3%</td><td>10,000</td></tr>
											<tr><td>도어록,비디오폰,보안</td><td>0.3%</td><td>1.0%</td><td>10,000</td></tr>
											<tr><td>선풍기,서큘레이터</td><td>0.3%</td><td>1.0%</td><td>10,000</td></tr>
											<tr><td>이어폰,헤드폰</td><td>0.3%</td><td>0.7%</td><td>10,000</td></tr>
											<tr><td>오븐,전자레인지</td><td>0.3%</td><td>1.0%</td><td>10,000</td></tr>
											<tr><td>사무기기</td><td>0.8%</td><td>1.0%</td><td>10,000</td></tr>
											<tr><td>타이어,스노우체인</td><td>1.0%</td><td>1.0%</td><td>10,000</td></tr>
											<tr><td>복합기</td><td>0.8%</td><td>1.0%</td><td>5,000</td></tr>
											<tr><td>운동화,스니커즈</td><td>1.0%</td><td>1.0%</td><td>5,000</td></tr>
											<tr><td>등산화,등산용품</td><td>1.0%</td><td>1.0%</td><td>5,000</td></tr>
											<tr><td>가방</td><td>0.3%</td><td>1.0%</td><td>5,000</td></tr>
											<tr><td>명품뷰티</td><td>1.0%</td><td>1.0%</td><td>5,000</td></tr>
											<tr><td>SSD,HDD</td><td>0.8%</td><td>0.7%</td><td>5,000</td></tr>
											<tr><td>냄비,압력솥,프라이팬</td><td>0.2%</td><td>1.0%</td><td>5,000</td></tr>
											<tr><td>공기청정기,에어워셔</td><td>0.3%</td><td>0.3%</td><td>5,000</td></tr>
											<tr><td>전기포트,그릴,튀김기</td><td>0.3%</td><td>1.0%</td><td>5,000</td></tr>
											<tr><td>공구,전동드릴</td><td>1.0%</td><td>1.0%</td><td>5,000</td></tr>
											<tr><td>골프용품</td><td>1.0%</td><td>1.0%</td><td>3,000</td></tr>
											<tr><td>낚시</td><td>1.0%</td><td>1.0%</td><td>3,000</td></tr>
											<tr><td>라켓,구기용품</td><td>1.0%</td><td>1.0%</td><td>3,000</td></tr>
											<tr><td>캠핑가구,용품</td><td>1.0%</td><td>1.0%</td><td>3,000</td></tr>
											<tr><td>텐트,타프,침낭</td><td>1.0%</td><td>1.0%</td><td>3,000</td></tr>
											<tr><td>골프의류,잡화</td><td>1.0%</td><td>1.0%</td><td>3,000</td></tr>
											<tr><td>등산의류,잡화</td><td>1.0%</td><td>1.0%</td><td>3,000</td></tr>
											<tr><td>기저귀</td><td>1.5%</td><td>0.5%</td><td>3,000</td></tr>
											<tr><td>홍삼,건강식품</td><td>1.0%</td><td>1.0%</td><td>3,000</td></tr>
											<tr><td>커피,차</td><td>1.0%</td><td>1.0%</td><td>3,000</td></tr>
											<tr><td>쌀,배아미</td><td>1.0%</td><td>1.0%</td><td>3,000</td></tr>
											<tr><td>여성의류</td><td>0.3%</td><td>1.0%</td><td>3,000</td></tr>
											<tr><td>남성화장품</td><td>1.0%</td><td>1.0%</td><td>3,000</td></tr>
											<tr><td>마우스,타블렛</td><td>0.8%</td><td>0.7%</td><td>3,000</td></tr>
											<tr><td>화장지</td><td>0.2%</td><td>1.0%</td><td>3,000</td></tr>
											<tr><td>키보드,신디사이저</td><td>0.2%</td><td>1.0%</td><td>3,000</td></tr>
											<tr><td>주방수납,일회용품</td><td>0.2%</td><td>1.0%</td><td>3,000</td></tr>
											<tr><td>책상,책장</td><td>0.3%</td><td>1.0%</td><td>3,000</td></tr>
											<tr><td>수납가구,정리용품</td><td>0.3%</td><td>1.0%</td><td>3,000</td></tr>
											<tr><td>메모리카드,카드리더</td><td>0.3%</td><td>0.7%</td><td>3,000</td></tr>
											<tr><td>복사용지,사무용지</td><td>0.8%</td><td>1.0%</td><td>3,000</td></tr>
											<tr><td>카익스테리어</td><td>1.0%</td><td>1.0%</td><td>3,000</td></tr>
											<tr><td>공기청정기,안전용품</td><td>1.0%</td><td>1.0%</td><td>3,000</td></tr>
											<tr><td>시트,매트,인테리어</td><td>1.0%</td><td>1.0%</td><td>3,000</td></tr>
											<tr><td>배터리,멀티소켓</td><td>1.0%</td><td>1.0%</td><td>3,000</td></tr>
											<tr><td>오일,소스,양념</td><td>1.0%</td><td>1.0%</td><td>1,000</td></tr>
											<tr><td>생수,음료</td><td>1.0%</td><td>1.0%</td><td>1,000</td></tr>
											<tr><td>스킨케어</td><td>1.0%</td><td>1.0%</td><td>1,000</td></tr>
											<tr><td>선케어</td><td>1.0%</td><td>1.0%</td><td>1,000</td></tr>
											<tr><td>클렌징,바디케어</td><td>1.0%</td><td>1.0%</td><td>1,000</td></tr>
											<tr><td>세제,섬유유연제</td><td>0.2%</td><td>1.0%</td><td>1,000</td></tr>
											<tr><td>제습,방향,탈취</td><td>0.2%</td><td>1.0%</td><td>1,000</td></tr>
											<tr><td>샴푸,탈모,헤어케어</td><td>0.2%</td><td>1.0%</td><td>1,000</td></tr>
											<tr><td>홈가드닝,야외가구</td><td>0.3%</td><td>1.0%</td><td>1,000</td></tr>
											<tr><td>건강측정,의료기</td><td>0.3%</td><td>0.3%</td><td>1,000</td></tr>
											<tr><td>문구,사무용품</td><td>0.8%</td><td>1.0%</td><td>1,000</td></tr>
											<tr><td>다이어리,노트,팬시</td><td>0.8%</td><td>1.0%</td><td>1,000</td></tr>
											<tr><td>필기류,화방용품</td><td>0.8%</td><td>1.0%</td><td>1,000</td></tr>
											<tr><td>세차,광택,탈취제</td><td>1.0%</td><td>1.0%</td><td>1,000</td></tr>
											<tr><td>엔진오일,첨가제,필터</td><td>1.0%</td><td>1.0%</td><td>1,000</td></tr>
											<tr><td>건전지,소방,산업</td><td>1.0%</td><td>1.0%</td><td>1,000</td></tr>
											<!-- //210511 : SR#46664 : [PC/M] 21년 5월 카테고리추가적립 > 퍼블리싱 수정 -->
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
								<li>참여방법 : 에누리 가격비교 모바일 앱 로그인 → 적립대상 쇼핑몰 이동 →&nbsp;<span class="stress">1만원 이상 대상 카테고리 구매</span>&nbsp;→ 최대 5만점 추가적립 이벤트 신청<br>
									<span class="noti">※ 이벤트 신청의 경우 PC 및 모바일 앱/웹에서 로그인 후에도 가능합니다. </span>
								</li>
								<li>적립대상 쇼핑몰 : G마켓, 옥션, 11번가, 인터파크, 티몬, 위메프, 쿠팡, GS SHOP, CJmall, SSG (신세계몰, 신세계백화점, 이마트몰, 트레이더스), SK스토아, 홈플러스<br>
									<span class="stress">※ 구매 유의사항 및 구매적립 제외 카테고리는 이벤트 페이지 하단 'e머니 구매혜택' 유의사항을 꼭 확인하세요.</span>
								</li>
								<li>대상 카테고리는 에누리 가격비교 카테고리 기준 입니다.</li>
								<li>추가적립금이 100원 미만의 경우 혜택 지급되지 않습니다.</li>
								<li>구매금액은 배송비, 설치비, 할인, 쇼핑몰 포인트 등 제외한 금액만 반영됩니다.</li>
								<li>
									<span class="stress">이벤트 대상 제외 :</span> 아래의 경우에는 이벤트 대상 및 혜택 지급에서 제외됩니다. <br>
									<ul class="sub">
										<li>- 추가적립 이벤트 신청하지 않은 경우</li>
										<li>- 실제 구매금액이 1만원 미만의 구매일 경우</li>
										<li>- 구매적립 제외 카테고리 구매일 경우 </li>
										<li>- 구매 후 취소/환불/교환/반품한 경우</li>
										<li>- 동일한 본인인증으로 가입한 다수의 ID로 중복 참여한 경우</li>
										<li>- 해외직구 상품 구매일 경우</li>
										<li class="stress">- 동일한 이벤트 기간의 VIP맞춤적립, 트리플적립 이벤트 혜택받은 경우 (중복 지급 불가)</li>
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
				<!-- // -->
			</div>
			<div class="evt_notice--foot">
				<button class="btn__evt_confirm">확인</button> <!-- 닫기 : 유의사항 닫기 -->
			</div>
		</div>
	</div>
	<!-- //유의사항 WRAPPER -->
</div>

<script>
$(function() {
	var template = "";
	var template2 = "";

    $.post( "/mobilefirst/evt/ajax/ajax_plusrsv_promotion_v2.jsp" , { "deviceType" : "M", "sdt" : "<%=numSdt %>", "event_dtl_id" : "<%=event_dtl_id%>" } , function(json) {

    	var plusrsvExh = json.catePromotion;
    	var plusrsvCate = json.targetCate;

		$.each(plusrsvExh, function(i,v){
			template += "<li data-promtnId = \"" + v.MOBL_PROMTN_ID + "\">";
			template += "<a href=\"javascript:///\">";
			template += "<img src=\"http://img.enuri.gscdn.com/images/mobilefirst/planlist/B_" + v.MOBL_PROMTN_ID + "/B_" + v.MOBL_PROMTN_ID + "_main.png\" alt=\"\" />";
			template += "</a>";
			template += "</li>";
		});
		$.each(plusrsvCate, function(i,v){
			template2 +="<li data-cateno = \""+ v.cate_cd + "\" data-eventTagNm = \""+ v.event_tag_nm + "\">";
			template2 +="    <a href=\"javascript:///\">";
			template2 +="        <span>" + v.event_tag_nm + "</span>";
			//template2 +="        <img src=\"http://imgenuri.enuri.gscdn.com/images/event/2018/buy/june/arrow.png\" alt=\"바로가기\">";
			template2 +="    </a>";
			template2 +="</li>";
		});
    }, "json").done(function(){

    	if(template != "" && '<%=promViewYn%>' == 'Y') {

    		$("#planSlide").html(template).slick({
    			dots: false,infinite: true,speed: 200,slidesToShow: 1,adaptiveHeight: true,autoplay: true,autoplaySpeed: 2000
			}).find("li").click( function() {
				var promtnId = $(this).attr("data-promtnId");
				ga('send', 'event', 'mf_event', '구매 프로모션', '추가적립_' + promtnId );
				window.open("/mobilefirst/planlist.jsp?t=B_" + promtnId);
				return false;
			});
    		$(".cateplan_wrap").show();
		}else{
			$(".cateplan_wrap").hide();
		}
    	if(template2 != "") {
    		$("#targetCate").html(template2).find("li").click(function(){
    			ga('send', 'event', 'mf_event', '구매 프로모션', '추가적립_' + $(this).attr("data-eventTagNm") );
    			window.open("/mobilefirst/list.jsp?cate=" + $(this).attr("data-cateno") + "&freetoken=list");
    			return false;
    		});
    	}
    });
	var isClick = true;

	$("#plusRsvClk").click(function(e){
		//if(getCookie("appYN") != 'Y'){
//			onoff('app_only');
	//		return false;
		//}
		if(!islogin()){
			 alert("로그인 후 이용할 수 있습니다.");

			 goLogin();
			/*  if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
			 	location.href = "/mobilefirst/login/login.jsp";
			 }else if(navigator.userAgent.indexOf("Android") > -1){
				 location.href = "/mobilefirst/login/login.jsp?backUrl=/mobilefirst/evt/smart_benefits.jsp?freetoken=event&tab=4";
			 }else{
				 location.replace("/mobilefirst/index.jsp");
			 } */
			 return false;
		}

		var ostpcd = getOsType();

		var param = {
			"event_start_dt" : '<%=event_start_dt %>',
			"event_end_dt" : '<%=event_end_dt %>',
			"event_id" : '<%=event_id %>',
			"mobileyn" : 'Y',
			"ostpcd":ostpcd
		};
		if(!isClick){
			return false;
		}
		isClick = false;
		$.ajax({
			type: "GET",
			url: "/mobilefirst/evt/ajax/ajax_plusrsvchk.jsp",
			async: false,
			data: param,
			dataType:"JSON",
			success: function(json){
				var result = json.result;

				if(result == -1){
					alert("구매 후 참여 가능합니다!");
				}else if(result == 0){
					alert("이미 신청해주셨습니다!");
				}else if(result == 1){
					alert("신청완료 되었습니다! \n e머니 지급일을 기다려주세요~!");
				}else if(result == 2){
					alert("잘못된 접근입니다.");
				}else if(result == -4){
					alert("SDU 회원은 본인인증 후 참여 가능합니다.\n※ 본인인증은 ‘앱 설정 > 본인인증’ 또는 ‘PC >\n개인정보관리 화면’을 이용해주세요");

				}else if(result==-5){
					var r = confirm("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?");
					if(r){
						location.href = "https://m.enuri.com/mobilefirst/member/myAuth.jsp?cmdType=&f=m&freetoken=login_title";
					}

				}else{
					alert("신청이 불가능합니다.");
				}
			}, complete : function() {
				isClick=true;
			}
		});
	});
	// 카테고리 레이어 현재위치에서 열리도록 top 조정
	$("#btnCategory").on("click", function(e){
		var currTop = $(window).scrollTop()+800; // 현재 스크롤
		$("#app_only3 .notice_layer.cate_layer_open").css("top", currTop);
	})
});
</script>
<% } %>