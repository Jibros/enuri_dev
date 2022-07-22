<%@ page contentType="text/html; charset=utf-8" %>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%
	//스마트쇼핑 from=st 처리
	String strfrom = ChkNull.chkStr(request.getParameter("from"),"");
	if(strfrom.equals("swt")){
		cb.setCookie_One("FROM",strfrom);
		cb.SetCookieExpire("FROM",-1);
		cb.responseAddCookie(response);
	}
%>
<!DOCTYPE html>
<html lang='ko'>
<head>
    <meta charset="utf-8"/>
	<meta http-equiv="x-ua-compatible" content="ie=edge"/>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no"/>
	<meta property="og:title" content="에누리 가격비교">
    <meta property="og:description" content="에누리 모바일 가격비교">
    <meta property="og:image" content="http://imgenuri.enuri.gscdn.com/images/mobilenew/images/logo_enuri.png">
	<meta name="format-detection" content="telephone=no"/>
	<link rel="stylesheet" type="text/css" href="/css/swiper.css"/>
	<link rel="stylesheet" type="text/css" href="/css/mobile_v2/common.css"/>
    <link rel="stylesheet" type="text/css" href="/css/mobile_v2/cs.css"/>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
    <script type="text/javascript" src="/js/swiper.min.js"></script>   <!-- <script type='text/javascript' src='/mobilefirst/js/gnbCurtCateMenu.js'></script> -->
 	<script type="text/javascript" src="/mobilefirst/js/lib/jquery.tmpl.min.js"></script>
</head>
<body>

<div id="wrap">

		<!-- 타입D (닫기) -->
	    <header id="header" class="m_header head__type_d">
	        <div class="header_wrap">
	            <h1 class="m_txt">이전 방침 (수정일 : 2019.02.12)</h1>
	            <button class="btn_hd_back comm__sprite" onclick='history.go(-1)'>뒤로</button>
	            <button class="btn_hd_close comm__sprite" onclick='backButton()'>닫기</button>
	        </div>
	    </header>
	    <!-- // 헤더 -->

		<section id="container">
			<div class="policy_wrap">
				<div class="tab_policy_cnt">
					<div class="policy_inner" style="display: block !important">
                    <!-- 개인정보취급방침 -->
                            <p>주식회사 써머스플랫폼(이하 “회사”라 함)에서 운영하는 서비스인 에누리가격비교(이하 “에누리”라 함)는 이용자들의 개인정보보호를 매우 중요시하며, 정보통신서비스 제공자가 준수하여야 하는 관련 법령 및 규정을 준수하고 있습니다.</br>
                            회사는 개인정보처리방침을 홈페이지 첫 화면에 공개함으로써 이용자들이 언제나 용이하게 보실 수 있도록 조치하고 있습니다.<br>
                            회사의 개인정보처리방침은 정부의 법률 및 지침 변경이나 회사의 내부 방침 변경 등으로 인하여 수시로 변경될 수 있고, 이에 따른 개인정보처리방침의 지속적인 개선을 위하여 필요한 절차를 정하고 있습니다.<br>
                            그리고 개인정보처리방침을 개정하는 경우 회사는 개인정보처리방침 변경 시행 7일 전부터 회사 공지사항을 통하여 공지하고 개정 일자 등을 부여하여 개정된 사항을 이용자들이 쉽게 알아볼 수 있도록 하고 있습니다.<br>
                            회사의 개인정보처리방침은 아래와 같은 내용을 담고 있습니다.
                            <br/><br/>
                             개인정보의 수집목적 및 이용목적<br>
                             회사가 수집하는 개인정보 항목 및 수집방법<br>
                             개인정보 수집에 대한 동의<br>
                             개인정보 자동수집 장치의 설치-운영 및 그 거부에 관한 사항<br>
                             회사가 수집한 개인정보의 공유 및 제공<br>
                             회사가 수집하는 개인정보의 보유 및 이용기간<br>
							 이용자 권리와 그 행사방법<br>
                             동의철회 및 개인정보 파기절차와 그 방법<br>
                             개인정보보호를 위한 기술적-관리적 대책<br>
                             회사 개인정보 관리보호 책임자 및 담당자의 소속-성명 및 연락처<br>
                             개인정보 관련 의견수렴 및 불만처리에 관한 사항<br>
                             개인정보 처리의 위탁에 관한 사항<br>
                             개인정보처리방침의 적용범위<br>
                             고지의 의무<br>
                            </p>
                            <h2>1. 개인정보의 수집목적 및 이용목적</h2>
                            <p>
                            	회사는 아래와 같은 목적으로 서비스 제공을 위한 최소한의 개인정보만을 수집하며, 수집하는 정보를 목적 외로 사용하거나, 이용자의 동의 없이 외부에 공개하지 않습니다.<br><br>

							[회원관리]<br>
                             - 회원제 서비스 이용에 따른 본인 식별 절차에 이용<br>
                             - 고지사항 전달, 본인의사 확인, 불만처리 등의 원활한 의사소통 경로의 확보<br>
							 - 개인정보 유효기간제 준수<br>
                             - 분쟁조정을 위한 기록보존<br>
							 - 불만처리 등 민원처리<br>
							 - 성인컨텐츠 제공을 위한 미성년자 여부 확인<br><br>

							 [서비스제공에 관한 계약의 이행 및 서비스 제공에 따른 요금 정산]<br>
                             - 경품과 쇼핑 물품 배송에 대한 정확한 배송지의 확보<br>
                             - 각종 이벤트 관련 정보안내 및 당첨자 발표를 위한 ID 사용<br>
                             - 주문 상품의 상담, 결제, 배송, 반품, 환불을 위한 정확한 정보의 확인 및 처리<br>
							 - 부정/불법이용 여부 판단 및 부정사용 방지<br><br>

							 [신규 서비스 개발과 마케팅 및 광고에 활용]<br>
                             - 개인맞춤 서비스의 제공 및 리워드 등 부가서비스 제공을 위한 이용<br>
                             - 에누리 모바일앱 설치 및 구매활동에 따른 이벤트 등 전용 서비스 제공을 위한 사용<br>
							 - 신규서비스 및 신상품 정보안내<br><br>

							 [에누리 이용에 대한 상담에 활용]<br>
                             - 회원의 에누리 이용 전반에 대한 상담 및 안내<br>
                             - 비회원의 에누리 이용 전반에 대한 상담 및 안내<br><br>

							 또한 회사는 회원가입을 만14세 이상인 경우에 가능하도록 하며, 법정대리인의 동의가 필요한 만14세 미만 아동의 개인정보는 수집 및 이용하지 않습니다.
                            </p>

                            <h2>2. 회사가 수집하는 개인정보 항목 및 수집방법</h2>
                            <p>
                            	회사는 이용자에게 다양하고 편리한 서비스를 제공하기 위하여 아래와 같은 개인정보를 수집하고 있습니다.<br><br>

                            1) 필수항목<br>
                            - 필수항목으로 수집한 개인정보는 회원탈퇴 즉시 파기합니다.<br>
							- 단, 부정이용 방지를 위해 회원ID, IP, 로그기록은 3년까지, 상품의 주문/결제 처리를 위해
							  회원ID, 성명, 휴대폰번호, 일반전화번호, 주소는 5년까지 보관할 수 있습니다.<br>

							<table class="tb_box">
								<colgroup>
									<col width="22%">
									<col width="25%">
									<col width="25%">
									<col width="">
								</colgroup>
								<tbody>
										<tr>
											<th>구분</th>
											<th>수집 항목</th>
											<th>수집 목적</th>
											<th>수집 방법</th>
										</tr>
										<tr>
											<td rowspan="4">일반/SDU/SDUL 회원</td>
											<td>성명, ID, 비밀번호, 휴대폰번호, 이메일주소</td>
											<td>이용자 본인 식별, 클레임처리, 고지사항 안내, 서비스 상품 파악 및 관리, 대금 결제 확인등에 사용</td>
											<td>웹사이트 또는 모바일웹/모바일앱에서 회원가입 시</td>
										</tr>
										<tr>
											<td>성명, ID, 비밀번호, 휴대폰번호, 이메일주소</td>
											<td>에누리 조립PC 서비스 이용에 따른 주문, 배송, 고객상담, 반품, 환불 등의 서비스</td>
											<td>웹사이트 또는 모바일웹에서 상품 주문/결제 시</td>
										</tr>
										<tr>
											<td>쇼핑몰 결제정보(주문일자, 주문액, 주문ID, 주문품번, 배송상태)</td>
											<td>이벤트 등 전용 서비스 제공을 위한 사용</td>
											<td>모바일앱을 통한 주문(구매) 시</td>
										</tr>
										<tr>
											<td>디바이스 정보(기기 식별번호, Android/iOS ID), 광고ID, 에누리 모바일앱 설치 정보</td>
											<td>모바일앱 설치 및 구매 활동에 따른 이벤트 등 전용 서비스 제공을 위한 사용</td>
											<td>모바일앱을 통한 서비스 이용 시</td>
										</tr>

										<tr>
											<td rowspan="2">SDU/SDUL 회원</td>
											<td>판매자닉네임, 미니샵주소</td>
											<td>이용자 본인 식별, 클레임처리, 고지사항 안내, 서비스 상품 파악 및 관리, 대금 결제 확인 등에 사용</td>
											<td>웹사이트에서 SDUL 회원 가입 시</td>
										</tr>
										<tr>
											<td>회사명, 사업자등록번호, 쇼핑몰명, 쇼핑몰URL, 담당자명, 담당자전화번호, 담당자이메일, 정산담당자명, 정산담당자 전화, 정산담당자 이메일, 입금자명</td>
											<td>이용에 본인 식별, 클레임처리, 고지사항 안내, 서비스 상품 파악 및 관리, 대금 결제 확인 등에 사용</td>
											<td>웹사이트에서 SDU 회원 가입 시</td>
										</tr>

									</tbody>
							</table>
							<br/>

                            2) 선택항목<br>
                            - 선택항목으로 수집한 개인정보는 회원탈퇴 즉시 파기합니다.<br>
                            - 선택 정보를 입력하지 않은 경우에도 서비스 이용 제한은 없습니다.

							<table class="tb_box">
								<colgroup>
									<col width=""><col width="25%"><col width="25%"><col width="25%">
								</colgroup>
									<tbody>
										<tr>
											<th>구분</th>
											<th>수집 항목</th>
											<th>수집 목적</th>
											<th>수집 방법</th>
										</tr>
										<tr>
											<td>일반/SDU/SDUL 회원</td>
											<td>성별, 생년월일, 주소, 닉네임, 휴대폰본인인증결과값(CI,DI,휴대폰번호,성별,생년월일), 일반전화번호</td>
											<td>신규 서비스 개발과 마케팅 및 광고에 활용, 본인식별 절차에 이용, 성인컨텐츠 이용시 성인인증, 부정사용 방지, 에누리 조립PC 서비스 이용에 따른 주문, 배송업무를 위해 사용</td>
											<td>웹사이트 또는 모바일웹/모바일앱에서 회원가입 시</td>
										</tr>
										<tr>
											<td>SDU/SDUL 회원</td>
											<td>주문전화번호, FAX, 주문이메일, 주요취급상품, 서비스희망상품수, 배송조건</td>
											<td>에누리 SDU 서비스 이용에 따른 관리를 위해 사용</td>
											<td>웹사이트에서 SDU 회원 가입 시</td>
										</tr>
									</tbody>
							</table>
							<br>

                            3) 자동수집항목<br>
                            - 자동수집항목은 이용목적 달성 즉시 파기합니다.<br>

							<table class="tb_box">
								<colgroup><col width=""><col width="25%"><col width="25%"><col width="25%"></colgroup>
									<tbody>
										<tr>
											<th>구분</th>
											<th>수집 항목</th>
											<th>수집 목적</th>
											<th>수집 방법</th>
										</tr>
										<tr>
											<td>일반/SDU/SDUL 회원</td>
											<td>접속IP, 쿠키(Cookie), 로그인 일자, 이용정지/해지 기록</td>
											<td>서비스 이용 통계, 부정이용기록 확인</td>
											<td>웹사이트 또는 모바일웹/모바일앱을 통한 서비스 이용 시</td>
										</tr>
									</tbody>
							</table>
							<br>
                            </p>
                            <h2>3. 개인정보 수집에 대한 동의</h2>
                            <p>회사는 이용자들이 회사의 개인정보처리방침 또는 이용약관의 내용에 대하여 「동의」버튼 또는 「취소」버튼을 클릭할 수 있는 절차를 마련하여, 「동의」버튼을 클릭하면 개인정보 수집에 대해 동의한 것으로 봅니다.</p>

                            <h2>4. 개인정보 자동수집 장치의 설치-운영 및 그 거부에 관한 사항</h2>
                            <p>
							[쿠키(cookie)의 운영 및 활용]<p>
							이용자들에게 특화된 맞춤서비스를 제공하기 위해서 회사는 이용자들의 정보를 저장하고 수시로 불러오는 '쿠키(cookie)'를 사용합니다.<p> 쿠키는 웹사이트를 운영하는데 이용되는 서버(HTTP)가 이용자의 컴퓨터 브라우저에게 보내는 소량의 정보이며 이용자들의 PC 컴퓨터내의 하드디스크에 암호화되어 저장됩니다.<p>

							이용자들이 에누리에 접속한 후 로그인(LOG-IN)하여 서비스를 이용하기 위해서는 쿠키를 허용하셔야 합니다.<p>
							회사는 이용자들에게 적합하고 보다 유용한 서비스를 제공하기 위해서 쿠키를 이용하여 아이디에 대한 정보를 찾아냅니다.<p>
							쿠키는 이용자의 컴퓨터는 식별하지만 이용자를 개인적으로 식별하지는 않습니다.<p>

							쿠키는 상품구매를 돕기 위해서, 기타 이벤트나 설문조사에서 이용자들의 참여 경력을 확인하기 위해서도 사용되며, 쿠키를 이용하여 이용자들이 방문한 에누리에 대한 방문 및 이용형태, 이용자 규모 등을 파악하여 더욱 더 편리한 서비스를 만들어 제공할 수 있고 이용자에게 최적화된 정보를 제공할 수 있습니다.<p>

							이용자는 아래와 같은 방법으로 쿠키가 수집되지 않도록 거부할 수 있습니다. 다만, 쿠키설정을 거부할 경우 일부 서비스이용이 어려울 수 있습니다.<p>
							- Internet Explorer: 인터넷 옵션 > 개인정보 > 고급 > 쿠키의 차단 또는 허용<p>
							- Chrome: 설정 > 고급 설정 표시 > 개인정보의 콘텐츠 설정 버튼 > 쿠키<p>

							[로그 분석 활용]<p>
							회사는 PC 또는 모바일 웹/앱상에서 이용자의 서비스 이용 형태에 대한 분석을 위해 로그 분석 도구를 이용하고 있으며, 이 경우 이용자 개인을 식별할 수 있는 정보는 이용하지 않습니다.<p>
							* 로그 분석 도구: Google Analytics, Firebase, logger, 애널리언스<p>

							[앱 오류 분석 활용]<p>
							회사는 이용자에 대한 양질의 서비스제공을 위해 앱 내 오류 분석도구를 이용하고 있으며, 이 경우 앱 오류 정보 외 개인을 식별할 수 있는 정보는 이용하지 않습니다. <p>
							* 앱 오류 분석 도구: Crashlytics<p>

							[맞춤형 광고 제공]<p>
							회사는 온라인 맞춤형 광고 사업자가 행태정보를 수집하도록 허용하고 있습니다.<p>
							* 행태정보를 수집하는 광고사업자: Facebook, IGAWorks, criteo<p>
							* 행태정보의 수집 방법: 이용자가 사이트를 방문하거나 앱을 실행할떄 자동 수집<p>
							이용자는 아래와 같은 방법으로 행태정보가 수집되지 않도록 거부할 수 있습니다. 다만, 설정하시더라도 일반적인 상품 광고는 노출될 수 있습니다.<p>
							&lt;WEB&gt;
							<p>
							- Internet Explorer: 인터넷 옵션 > 개인정보 > 고급 > 쿠키의 차단 또는 허용<p>
							- Chrome: 설정 > 고급 설정 표시 > 개인정보의 콘텐츠 설정 버튼 > 쿠키<p>
							&lt;APP&gt;
							<p>
							- Android : 설정 > Google > 광고 > 광고 맞춤 설정 선택 해제<p>
							- iOS : 설정 > 개인정보보호 > 광고 > 광고 추적 제한 ON<p>
                            </p>

                            <h2>5. 회사가 수집한 개인정보의 공유 및 제공</h2>
                            <p>
                            회사는 이용자들의 개인정보를 "2. 회사가 수집하는 개인정보 항목 및 수집방법"에서 고지한 범위에서 사용하며, 이용자들의 개인정보를 이용하거나 타인 또는 타기업, 기관에게 제공하지 않습니다.

							다만, 아래의 경우에는 예외로 합니다.<p>
							- 이용자가 사전에 동의한 경우<p>
							- 법령에 의하여 수사목적으로 관계기관으로부터의 요구가 있을 경우
                            </p>

                            <h2>6. 회사가 수집하는 개인정보의 보유 및 이용기간</h2>
                            <p>
                            회사는 원칙적으로 이용자의 개인정보 수집 및 이용 목적이 달성되면 개인정보를 지체 없이 파기합니다.<p>
                            또한 1년 이상 로그인하지 않은 미사용 계정의 경우 개인정보를 접속권한이 제한되어 있는 별도의 서버에 안전하게 분리 저장합니다.<br>
                            <br>
                            단, 다음의 경우는 예외로 합니다.<br><br>

							<table class="tb_box">
								<colgroup>
									<col width="25%">
									<col width="50%">
									<col width="25%">
								</colgroup>
								<tbody>
								<tr>
									<th>보존근거</th>
									<th>보존하는 개인정보 항목</th>
									<th>보유 및 이용기간</th>
								</tr>
								<tr>
									<td rowspan="3">전자상거래 등에서 소비자보호에 관한 법률</td>
									<td>소비자불만 또는 분쟁처리에 관한 기록</td>
									<td>최대 3년</td>
								</tr>
								<tr>
									<td>계약 또는 청약철회 등에 관한 기록</td>
									<td rowspan="2">최대 5년</td>
								</tr>
								<tr><td>대금결제 및 재화 등의 공급에 관한 기록</td></tr>
								<tr>
									<td>통신비밀보호법</td>
									<td>웹사이트 방문기록</td>
									<td>최대 3개월</td>
								</tr>
								<tr>
									<td rowspan="3">회사 내부 방침</td>
									<td>회원탈퇴, 회원에서 제명된 경우의 회원 식별정보<br>: 재가입방지를 위함</td>
									<td rowspan="2">최대 3년</td>
								</tr>
								<tr><td>부정거래기록(IP주소, 쿠키, 기기정보)<br>: 부정거래 방지 및 다른 선량한 이용자의 보호를 위함</td></tr>
								<tr>
									<td>회원ID와 게시물 기록<br>: 서비스이용의 혼선 방지를 위함</td>
									<td>영구보관</td>
								</tr>
								</tbody>
							</table>
							<br>

                            다만 이용자에게 개인정보 보관기간에 대해 별도의 동의를 얻은 경우, 또는 관련법령에서 일정 기간 정보보관 의무를 부과하는 경우에는 해당기간 동안 개인정보를 안전하게 보관합니다.
                            </p>

                            <h2>7. 이용자 권리와 그 행사방법</h2>
                            <p>이용자는 언제든지 회사에 등록되어 있는 본인의 개인정보를 열람하거나 정정할 수 있습니다.<br>
                            이용자의 본인의 개인정보에 대한 열람 또는 정정을 하고자 할 경우에는 에누리에 로그인 후 「변경」버튼을 클릭하여 직접 열람 또는 정정하거나, 개인정보보호책임자에게 서면, E-mail, Fax로 연락하시면 지체 없이 조치하겠습니다.<br>
                            이용자의 개인정보의 오류에 대한 정정을 요청하신 경우에는 정정을 완료하기 전까지는 당해 개인정보를 이용 또는 제공하지 않습니다. 또한 잘못된 개인정보를 제3자에게 이미 제공한 경우에는 정정 처리결과를 제3자에게 지체 없이 통지하여 정정이 이루어지도록 하겠습니다.<br>
                            또한, 이용자는 언제든지 '회원탈퇴' 등을 통해 개인정보의 수집 및 이용 동의를 철회할 수 있습니다.<br><br>
							회사는 이용자의 요청에 의해 해지 또는 삭제된 개인정보는 '6. 회사가 수집하는 개인정보의 보유 및 이용기간'에 명시된 바에 따라 처리하고 그 외의 용도로 열람 또는 이용할 수 없도록 처리하고 있습니다.<br><br>
							회사는 회원가입을 만14세 이상인 경우에 가능하도록 하며, 만14세 미만 아동의 개인정보는 수집 및 이용하지 않습니다.
                            </p>

                            <h2>8. 동의철회 및 개인정보 파기절차와 그 방법</h2>
                            <p>
                            이용자는 회원가입 시 개인정보의 수집, 이용 및 제공에 동의하신 내용을 언제든지 철회하실 수 있습니다.<br>개인정보수집 동의철회 및 개인정보 파기절차와 그 방법은 아래와 같습니다.<br><br>

							1. 동의철회<br>
                            동의철회(회원탈퇴)는 에누리 홈페이지 첫 화면에서 로그인 후 My회원정보에서「탈퇴」를 클릭하여 직접 동의철회(회원탈퇴)를 하시거나, 개인정보보호책임자에게 서면, 전화 또는 E-mail 등으로 연락하시면 개인정보를 파기하는 등 필요한 조치를 하겠습니다.<br><br>

							2. 파기절차<br>
                            이용자가 회원가입 등을 위해 입력한 정보는 수집 목적이 달성된 후 별도의 DB에 옮겨져(종이의 경우 별도의 서류)내부 방침 및 기타 관련 법령에 따라 일정기간 저장된 후 혹은 즉시 파기됩니다.
							이때, 별도의 DB로 옮겨진 개인정보는 법률에 의한 경우 외에는 다른 목적으로 이용되지 않습니다.<br><br>

							3. 파기방법<br>
                            - 전자적 파일 형태의 정보는 기록을 재생할 수 없는 기술적 방법을 사용하여 삭제합니다.<br>
							- 종이에 출력된 개인 정보는 분쇄기로 분쇄하거나 소각을 통하여 파기합니다.<br>
                            </p>

                            <h2>9. 개인정보보호를 위한 기술적-관리적 대책</h2>
                            <p>
                            이용자의 개인정보는 비밀번호에 의해 보호되고 있습니다.<br>
                            이용자 계정의 비밀번호는 오직 본인만이 알 수 있으며, 개인정보의 확인 및 변경도 비밀번호를 알고 있는 본인에 의해서만 가능합니다.<br>
                            따라서 이용자 자신의 비밀번호는 누구에게도 알리면 안됩니다. 또한 작업을 마친 후에는 로그아웃(log-out)하시고 웹브라우저를 종료하는 것이 바람직합니다. 특히 다른 사람과 컴퓨터를 공유하여 사용하거나 공공장소에서 이용한 경우 개인정보가 다른 사람에게 알려지는 것을 막기 위해서 이와 같은 절차가 더욱 필요합니다.<br>
                            <br>
                            회사는 개인정보취급 직원을 최소한으로 제한하고 담당직원에 대한 수시 교육을 통하여 본 정책의 준수를 강조하고 있으며, 감사위원회의 감사를 통하여 본 정책의 이행사항 및 담당직원의 준수여부를 확인하여 문제가 발견될 경우 바로 시정조치하고 있습니다.<br>
                            <br>
                            회사의 개인정보보호를 위한 기술적, 관리적 대책은 아래와 같습니다.<br><br>
                            1. 컴퓨터 바이러스에 의한 개인정보의 침해를 방지하기 위하여 백신프로그램을 이용하며 주기적인 업데이트를 통해 새로운 바이러스에 대비<br>
                            2. 개인정보에 대한 직접적인 접근을 방지하기 위하여 데이터베이스의 보안기능을 이용하여 일부 정보는 열람할 수 없음<br>
                            3. 인터넷망을 통한 해커의 불법적 침입에 대비하여 방화벽과 침입탐지 시스템을 사용하여 보안에 만전을 기함<br>
                            4. 개인정보에 대한 접근권한을 개인정보보호책임자 등 개인정보보호업무를 수행하는 자, 기타 업무상 개인정보의 취급이 불가피한 자로 제한하며, 그 이외의 인원이 개인정보에 접근하는 것을 허용하지 않음<br>
                            5. 개인정보와 일반 데이터를 혼합하여 탑재하지 않으며, 별도의 계정을 통하여 관리<br>
                            6. 전산실은 출입통제 구역으로 지정하여 허락된 인원만의 출입을 허용
                            </p>

                            <h2>10. 회사 개인정보 보호책임자 및 담당자의 소속-성명 및 연락처</h2>
                            <p>회사는 이용자가 좋은 정보를 안전하게 이용할 수 있도록 최선을 다하고 있습니다.<br>
                            개인정보를 보호하는데 있어 이용자에게 고지한 사항에 반하는 사고가 발생할 경우 개인정보 보호책임자가 책임을 집니다.<br><br>

                            이용자 개인정보와 관련한 아이디(ID)의 비밀번호에 대한 보안유지책임은 해당 이용자 자신에게 있습니다.<br>
                            회사는 비밀번호에 대해 어떠한 방법으로도 이용자에게 직접적으로 질문하는 경우는 없으므로 타인에게 비밀번호가 유출되지 않도록 각별히 주의하시기 바랍니다.<br>
                            특히 "9. 개인정보보호를 위한 기술적-관리적 대책"에서 명시한 것과 같이 공공장소에서 온라인상에서 접속해 있을 경우에는 더욱 유의하셔야 합니다.<br>
                            에누리는 개인정보에 대한 의견수렴 및 불만처리를 담당하는 개인정보 보호책임자 및 담당자를 지정하고 있고, 연락처는 아래와 같습니다.<br><br>

                            개인정보보호 책임자<br>
                            성명 이주현<br>
                            직위 상무<br>
                            전화번호 02-6354-3601<br>
                            팩스 02-6354-3600<br>
                            전자우편주소 nova23@enuri.com<br>
                            <br>
                            개인정보 고충처리 담당자<br>
                            성명 김범일<br>
                            직위 대리<br>
                            전화번호 02-6354-3601<br>
                            팩스 02-6354-3600<br>
                            전자우편주소 powerkby3@enuri.com<br>
                            </p>

                            <h2>11. 개인정보관련 의견수렴 및 불만처리에 관한 사항</h2>
                            <p>
                            회사는 개인정보보호와 관련하여 이용자 여러분들의 의견을 수렴하고 있으며 불만을 처리하기 위하여 모든 절차와 방법을 마련하고 있습니다.<br>
                            이용자들은 상단에 명시한 "10. 회사 개인정보 보호책임자 및 담당자의 소속-성명 및 연락처"를 참고하여 전화나 메일을 통하여 불만사항을 신고할 수 있고, 회사는 이용자들의 신고사항에 대하여 신속하고도 충분한 답변을 해 드릴 것입니다.<br>
                            <br>
                            또는 정부에서 설치하여 운영 중인 아래의 기관에 불만처리를 신청할 수 있습니다.<br>
                            *경찰청 사이버안전국 <br>
                            - 홈페이지 : http://cyberbureau.police.go.kr<br>
                            - 전화 : (국번없이) 182<br>
                            <br>
                            *대검찰청 사이버수사과<br>
                            - 홈페이지 : http://www.spo.go.kr<br>
                            - 전화 : (국번없이) 1301<br>
                            <br>
                            *개인정보 침해신고센터(한국인터넷 진흥원 운영)<br>
                            - 홈페이지 : http://privacy.kisa.or.kr<br>
                            - 전화: (국번없이) 118<br>
                            <br>
                            *개인정보 분쟁조정위원회(개인정보보호위원회 운영)<br>
                            - 홈페이지 : http://www.kopico.go.kr<br>
                            - 전화: 02-1833-6972<br>
                            </p>

                            <h2>12. 개인정보 처리의 위탁에 관한 사항</h2>
                            <p>회사는 원활하고 향상된 서비스를 위하여 개인정보 처리를 타인에게 위탁할 수 있습니다. 이 경우 회사는 사전에 다음 각 호의 사항을 모두 이용자에게 미리 알리고 동의를 받습니다.<br>
                            1) 개인정보 처리 위탁을 받는 자<br>
                            2) 개인정보 처리 위탁을 하는 업무의 내용<br><br>
                            또한, 회사는 개인정보의 처리와 관련하여 아래와 같이 업무를 각 수탁업체에게 위탁하고 있으며, 관계법령에 따라 위탁계약 체결시 개인정보가 안전하게 관리될 수 있도록 필요한 조치를 하고 있습니다.<br> 하단의 수탁업체는 이용자에게 사전 통지 또는 동의를 얻어 위탁 업무를 대행하고 있습니다.
                            </p>

                                <!-- 레이어 -->
                                <div class="dim" id="prv_layer" style="display:none;">
                                    <div class="privacy_layer" style="">
                                        <a href="javascript:///" onclick="onoff('prv_layer')" class="close">창닫기</a>
                                        <h4>개인정보취급 위탁업체 내역보기</h4>
                                        <div class="pr_layercon">
                                            <span class="update">*업데이트 : 2017.04.07</span>
                                            <p class="box">
                                                (주)그레이스씨앤씨, 스카이디지탈, SK매직, 썬포토, (주)마이씨앤에스, 퀴스, ㈜에이알커머스, 와이제이컴퍼, 엑스에너지, (주)아이실리콘, (주)아임커머스, 피타소프트, (주)솔로몬닷컴, (주)맥스이노션, 맥스퍼, (주)인터아이넷, (주)파트론, (주)타이탄플랫폼, 요이치
                                            </p>
                                            <div class="btncnt"><a href="javascript:///" onclick="onoff('prv_layer')">닫기</a></div>
                                        </div>
                                    </div>
                                </div>
                                <!--// 레이어 -->

                                <table class="tb_box">
                                    <colgroup>
                                        <col width="40%">
                                        <col width="60%">
                                    </colgroup>
                                    <tbody>
                                    <tr>
                                        <th>수탁업체명</th>
                                        <th>위탁업무 내용</th>
                                    </tr>
                                    <tr>
                                        <td>㈜쿠프마케팅</td>
                                        <td>- 목적: 프로모션 진행에 따른 당첨자 경품제공<br>
                                        - 취급정보: 전화번호<br>
                                        - 개인정보 보유 및 이용기간: 경품배송 완료 후 7일
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>체험단 진행 업체<span class="pvlayer_go" onclick="onoff('prv_layer')">[위탁업체 내역보기]</span></td>
                                        <td>- 목적 : 체험단 진행에 따른 당첨자 경품배송<br>
                                        - 취급정보 : 전화번호, 메일주소, 경품배송 주소<br>
                                        - 개인정보 보유 및 이용기간 : 체험단 완료 후 1개월
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>NICE 아이디</td>
                                        <td>- 목적 : 회원관리를 위한 본인인증<br>
										- 취급정보 : 휴대폰번호, 성별, 생년월일, CI, DI<br>
										- 개인정보 보유 및 이용기간 : 회원탈퇴 즉시 삭제
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>(주)스윗트래커</td>
                                        <td>- 목적: 이용자가 인지할 필요성이 있는 회사 및 에누리에 관련된 정보를 이용자에게 카카오 비즈메세지로 발송<br>
										- 취급정보: 휴대폰번호, 이름, 회원아이디<br>
										- 개인정보 보유 및 이용기간: 카카오 비즈메세지 발송 후 3일
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>(주)윈윈소프트</td>
                                        <td>- 목적: 에누리 조립PC 서비스 이용(주문, 배송, 고객상담, 반품, 환불 등)<br>
											- 취급정보: 주소, 휴대폰번호, 일반전화번호, 이름, 이메일, 회원ID<br>
											- 개인정보 보유 및 이용기간: 서비스 제공 기간
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <!--// 160810 -->
							<br>
						<p>
						개인정보 처리 위탁계약 체결시 회사는 수탁업체에 대하여 회사의 개인정보보호 관련 지시의 엄수, 개인정보에 관한 비밀유지, 개인정보의 제3자 제공 금지 및 사고시의 책임부담, 위탁기간, 위탁계약 종료 후의 개인정보파기 등을 규정하고, 당해 계약내용을 서면 또는 전자적으로 보관합니다.
						</p>
						<h2>13. 개인정보처리방침의 적용범위</h2>
						<p>
						본 개인정보처리방침은 회사가 운영하는 브랜드 중 하나인 ‘에누리(www.enuri.com)’ 및 관련 제반 서비스(모바일웹/모바일앱 포함)에 적용되며, 에누리 이외 회사의 다른 브랜드로 제공되는 서비스에 대해서는 별개의 개인정보처리방침이 적용될 수 있습니다. 에누리에 링크되어 있는 다른 회사의 웹사이트에서 개인정보를 수집하는 경우 이용자 동의 하에 개인정보가 제공된 이후에는 본 개인정보처리방침이 적용되지 않습니다.
						</p>
						<h2>14. 고지의 의무</h2>
						<p>
						본 개인정보처리방침은 2019년 02월 12일부터 적용되며, 법령, 정책 또는 보안기술의 변경에 따라 내용의 추가, 삭제 및 수정이 있을 시에는 변경사항 시행일의 7일 전부터 에누리 웹 사이트의 공지사항을 통하여 고지할 것 입니다.
						</p>
						<br><br>
						<p>
						- 공고일자: 2019년 02월 01일<br>
						- 시행일자: 2019년 02월 12일
						</p>
						</div>
				</div>
			</div>
		</section>

		<!-- 푸터 -->
		<%@ include file="/m/include/footer.jsp"%>
		<!-- //푸터 -->

	</div>
<!-- //140805 수정 -->
</body>
</html>
<script language="javascript">

function getCookie(cname) {
    var name = cname + "=";
    var ca = document.cookie.split(';');
    for(var i=0; i<ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1);
        if (c.indexOf(name) == 0) return c.substring(name.length,c.length);
    }
    return "";
}

function backButton(){

	var iOS = /(iPad|iPhone|iPod)/g.test( navigator.userAgent );

	if(getCookie("appYN") == 'Y' ){
		location.href = "close://"
	}else{
		window.close();
	}

}
//layer
function onoff(id) {
    var mid=document.getElementById(id);
    if(mid.style.display=='')     mid.style.display='none';
    else    mid.style.display='';
}
</script>