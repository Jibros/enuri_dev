<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="org.apache.commons.lang3.StringUtils"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%

	String css = "";
	String cssType = StringUtils.defaultString(request.getParameter("cssType"));

	if(cssType.contains("mobiledepart")){
		css = "mobiledepart";
	}else if(cssType.contains("mobiledeal")){
		css = "mobiledeal";
	}else{
		css = "agreeWrap";
	}

	// 스마트쇼핑 from=st 처리
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

	<!-- 140805 수정 -->
	<div id="wrap">

		<!-- 타입D (닫기) -->
	    <header id="header" class="m_header head__type_d">
	        <div class="header_wrap">
	            <h1 class="m_txt">이전 방침 (수정일 : 2014.08.22)</h1>
	            <button class="btn_hd_back comm__sprite" onclick='history.go(-1)'>뒤로</button>
	            <button class="btn_hd_close comm__sprite" onclick='backButton()'>닫기</button>
	        </div>
	    </header>
	    <!-- // 헤더 -->

		<section id="container">
			<div class="policy_wrap">
				<div class="tab_policy_cnt">
					<div class="policy_inner" style="display: block !important">
						<p>에누리닷컴(주)(www.enuri.com 이하 "에누리"라 함)는 이용자들의 개인정보보호를 매우 중요시하며, 이용자가 회사의 서비스를 이용함과 동시에 온라인상에서 에누리에 제공한 개인정보가 보호 받을 수 있도록 최선을 다하고 있습니다.
						이에 에누리는 통신비밀보호법, 전기통신사업법, 정보통신망 이용촉진 및 정보보호 등에 관한 법률 등 정보통신서비스제공자가 준수하여야 할 관련 법규상의 개인정보보호 규정 및 정보통신부가 제정한 개인정보취급방침을 준수하고 있습니다.
						에누리는 개인정보 취급방침을 통하여 이용자들이 제공하는 개인정보가 어떠한 용도와 방식으로 이용되고 있으며 개인정보보호를 위해 어떠한 조치가 취해지고 있는지 알려드립니다.<br /><br />

						에누리는 개인정보 취급방침을 홈페이지 첫 화면에 공개함으로써 이용자들이 언제나 용이하게 보실 수 있도록 조치하고 있습니다.<br /><br />

						에누리의 개인정보 취급방침은 정부의 법률 및 지침 변경이나 에누리의 내부 방침 변경 등으로 인하여 수시로 변경될 수 있고, 이에 따른 개인정보 취급방침의 지속적인 개선을 위하여 필요한 절차를 정하고 있습니다.<br />
						그리고 개인정보 취급방침을 개정하는 경우 에누리는 개인정보 취급방침 변경 시행 7일전부터 회사 공지사항을 통하여 공지하고 개정일자 등을 부여하여 개정된 사항을 이용자들이 쉽게 알아볼 수 있도록 하고 있습니다.<br />

						에누리의 개인정보 취급방침은 아래와 같은 내용을 담고 있습니다.<br /><br />

						1. 개인정보의 수집목적 및 이용목적<br />
						2. 에누리가 수집하는 개인정보 항목 및 수집방법<br />
						3. 개인정보 수집에 대한 동의<br />
						4. 쿠키(cookie)의 운영 및 활용<br />
						5. 에누리가 수집한 개인정보의 공유 및 제공<br />
						6. 에누리가 수집하는 개인정보의 보유 및 이용기간<br />
						7. 개인정보 열람, 정정<br />
						8. 동의철회 및 파기<br />
						9. 개인정보보호를 위한 기술적-관리적 대책<br />
						10. 에누리 개인정보 관리책임자 및 담당자의 소속-성명 및 연락처<br />
						11. 개인정보관련 의견수렴 및 불만처리에 관한 사항<br />
						12. 고지의 의무<br />
						13. 개인정보 처리의 위탁에 관한 사항
						</p>

						<h2>1. 개인정보의 수집목적 및 이용목적</h2>
						<p>"개인정보"라 함은 생존하는 개인에 관한 정보로서 당해 정보에 포함되어 있는 성명 등의 사항에 의하여 당해 개인을 식별할 수 있는 정보(당해 정보만으로는 특정 개인을 식별할 수 없더라도 다른 정보와 용이하게 결합하여 식별할 수 있는 것을 포함)를 말합니다.<br /><br />
						에누리가 이용자 개인의 정보를 수집하는 목적은 에누리 사이트를 통하여 이용자들에게 최적의 맞춤화된 서비스를 제공해드리기 위한 것이며, 이용자들이 제공해주신 개인정보를 바탕으로 이용자들에게 보다 더 유용한 정보를 선택적으로 제공하기 위한 것입니다.<br /><br />
						에누리는 이용자의 사전 동의 없이는 이용자의 개인 정보를 공개하지 않습니다.</p>

						<h2>2. 에누리가 수집하는 개인정보 항목 및 수집방법</h2>
						<p>"개인정보"라 함은 생존하는 개인에 관한 정보로서 당해 정보에 포함되어 있는 성명 등의 사항에 의하여 당해 개인을 식별할 수 있는 정보(당해 정보만으로는 특정 개인을 식별할 수 없더라도 다른 정보와 용이하게 결합하여 식별할 수 있는 것을 포함)를 말합니다.<br /><br />
						에누리가 이용자 개인의 정보를 수집하는 목적은 에누리 사이트를 통하여 이용자들에게 최적의 맞춤화된 서비스를 제공해드리기 위한 것이며, 이용자들이 제공해주신 개인정보를 바탕으로 이용자들에게 보다 더 유용한 정보를 선택적으로 제공하기 위한 것입니다.<br /><br />
						에누리는 이용자의 사전 동의 없이는 이용자의 개인 정보를 공개하지 않습니다.<br /><br />

						[ 개인정보 항목별 수집목적 ] <br />
						1) 필수입력사항 : 성명, ID, 비밀번호, 휴대폰번호<br />
							-> 서비스이용에 따른 본인식별<br />
						2) 선택입력사항 : e-mail.전화번호, 주소, 직업, 닉네임, 결혼유무, 본인확인 인증값<br />
							-> 인구통계학적 분석 내지 개인맞춤서비스를 제공하기 위한 자료,<br />
								물품배송 시 정확한 배송지의 확보, 고지사항 전달 및 확인, 본인의사 확인 등<br />
								의사소통을 위한 절차에 이용 및 새로운 서비스, 이벤트 등 정보의 전달을 위한 절차에 이용
						</p>

						<h2>3. 개인정보 수집에 대한 동의</h2>
						<p>에누리는 이용자들이 회사의 개인정보취급방침 또는 이용약관의 내용에 대하여 「동의」버튼 또는 취소」버튼을 클릭할 수 있는 절차를 마련하여, 「동의」버튼을 클릭하면 개인정보 수집에 대해 동의한 것으로 봅니다.</p>

						<h2>4. 쿠키(cookie)의 운영 및 활용</h2>
						<p>
						이용자들에게 특화된 맞춤서비스를 제공하기 위해서 에누리는 이용자들의 정보를 저장하고 수시로 불러오는 '쿠키(cookie)'를 사용합니다. 쿠키는 웹사이트를 운영하는데 이용되는 서버(HTTP)가 이용자의 컴퓨터 브라우저에게 보내는 소량의 정보이며 이용자들의 PC 컴퓨터내의 하드디스크에 암호화되어 저장됩니다.<br /><br />

						이용자들이 에누리에 접속한 후 로그인(LOG-IN)하여 서비스를 이용하기 위해서는 쿠키를 허용하셔야 합니다.
						에누리는 이용자들에게 적합하고 보다 유용한 서비스를 제공하기 위해서 쿠키를 이용하여 아이디에 대한 정보를 찾아냅니다.
						쿠키는 이용자의 컴퓨터는 식별하지만 이용자를 개인적으로 식별하지는 않습니다.<br /><br />

						쿠키는 에누리에서 상품구매 시 인증을 위해서나 상품구매를 돕기 위해서, 기타 이벤트나 설문조사에서 이용자들의 참여 경력을 확인하기 위해서도 사용되며, 쿠키를 이용하여 이용자들이 방문한 에누리에 대한 방문 및 이용형태, 이용자 규모 등을 파악하여 더욱 더 편리한 서비스를 만들어 제공할 수 있고 이용자에게 최적화된 정보를 제공할 수 있습니다.
						웹 브라우저 상단의 도구 > 인터넷옵션 탭(option tab)에서 의 옵션을 조정함으로써 모든 쿠키를 다 받아들이거나, 쿠키가 설치될 때 통지를 보내도록 하거나, 아니면 모든 쿠키를 거부할 수 있는 선택권이 있습니다. 다만, 쿠키설정을 거부할 경우 쿠키허용 설정 이 필요한 로그인 서비스는 이용할 수 없습니다.
						</p>

						<h2>5. 에누리가 수집한 개인정보의 공유 및 제공</h2>
						<p>에누리는 이용자들의 동의가 있거나 법률의 규정에 의한 경우를 제외하고는 어떠한 경우에도 "2. 에누리가 수집하는 개인정보 항목 및 수집방법"에서 고지한 범위를 넘어서 이용자들의 개인정보를 이용하거나 타인 또는 타기업, 기관에게 제공하지 않습니다.</p>

						<h2>6. 에누리가 수집하는 개인정보의 보유 및 이용기간</h2>
						<p>이용자가 에누리의 회원으로서 에누리에 제공하는 서비스를 이용하는 동안 에누리는 이용자들의 개인정보를 계속적으로 보유하며 서비스 제공 등을 위해 이용합니다. 다만, 아래의 "7. 개인정보 열람, 정정 및 8. 동의철회 및 파기"에서 설명한 절차와 방법에 따라 회원 본인이 직접 삭제하거나 정보의 수정 등을 요청한 경우에는 재생할 수 없는 방법에 의하여 디스크에서 완전히 삭제하며 추후 열람이나 이용이 불가능한 상태로 처리됩니다.<br /><br />

						그리고 "2. 에누리가 수집하는 개인정보 항목 및 수집방법"에서와 같이 일시적인 목적(설문조사, 이벤트, 본인확인 등)으로 입력 받은 개인정보는 그 목적이 달성된 이후에는 동일한 방법으로 사후 재생이 불가능한 상태로 처리됩니다.<br /><br />

						이용자의 개인정보는 아래와 같이 개인정보의 수집목적 또는 제공받은 목적이 달성되면 파기하는 것을 원칙으로 합니다.
						다만 상법, 전자상거래등에서의 소비자보호에 관한 법률 등 관계법령의 규정에 의하여 보존할 필요가 있는 경우 에누리는 관계법령에서 정한 일정한 기간 동안 회원정보를 보관합니다.
						이 경우 에누리는 보관하는 정보를 그 보관의 목적으로만 이용하며 보존기간은 아래와 같습니다.<br /><br />

						- 계약 또는 청약철회 등에 관한 기록 : 5년<br />
					   - 대금결제 및 재화등의 공급에 관한 기록 : 5년<br />
					   - 소비자의 불만 또는 분쟁처리에 관한 기록 : 3년<br /><br />

						에누리는 귀중한 회원의 개인정보를 안전하게 처리하며, 유출 방지를 위하여 아래와 같은 방법으로 개인정보를 파기합니다.<br /><br />

						- 종이에 출력된 개인정보는 분쇄기로 분쇄하거나 소각을 통하여 파기합니다.<br />
						- 전자적 파일 형태로 저장된 개인정보는 기록을 재생할 수 없는 기술적 방법을 사용하여 삭제합니다.
						</p>

						<h2>7. 개인정보 열람, 정정</h2>
						<p>고객께서는 언제든지 등록되어 있는 개인정보를 열람하거나 정정하실 수 있습니다.
						고객의 개인정보에 대한 열람 또는 정정을 하고자 할 경우에는 에누리에 로그인 후 「변경」버튼을 클릭하여 직접 열람 또는정정하거나, 개인정보관리책임자에게 서면, E-mail, Fax로 연락하시면 지체없이 조치하겠습니다.
						고객의 개인정보의 오류에 대한 정정을 요청하신 경우에는 정정을 완료하기 전까지는 당해 개인정보를 이용 또는 제공하지 않습니다. 또한 잘못된 개인정보를 제3자에게 이미 제공한 경우에는 정정 처리결과를 제3자에게 지체없이 통지하여 정정이 이루어지도록 하겠습니다.</p>

						<h2>8. 동의철회 및 파기</h2>
						<p>고객은 회원가입시 개인정보의 수집, 이용 및 제공에 동의하신 내용을 언제든지 철회하실 수 있습니다.
						동의철회(회원탈퇴)는 에누리 홈페이지 첫화면에서 로그인 후 My회원정보에서「탈퇴」를 클릭하여 직접 동의철회(회원탈퇴)를 하시거나, 개인정보관리책임자에게 서면, 전화또는 E-mail 등으로 연락하시면 개인정보를 파기하는 등 필요한 조치를 하겠습니다.
						단, 회원ID에 한해서는, 서비스 이용의 혼선 방지, 불법적 사용자에 대한 수사기관 수사 협조, 기타 안정적인 서비스 제공을 위해, 회원탈퇴 후에도 15일간 보유하게 됩니다.</p>

						<h2>9. 개인정보보호를 위한 기술적-관리적 대책</h2>
						<p>이용자의 개인정보는 비밀번호에 의해 보호되고 있습니다.
						이용자 계정의 비밀번호는 오직 본인만이 알 수 있으며, 개인정보의 확인 및 변경도 비밀번호를 알고 있는 본인에 의해서만 가능합니다.
						따라서 이용자 자신의 비밀번호는 누구에게도 알려주면 안됩니다. 또한 작업을 마치신 후에는 로그아웃(log-out)하시고 웹브라우저를 종료하는 것이 바람직합니다. 특히 다른 사람과 컴퓨터를 공유하여 사용하거나 공공장소에서 이용한 경우 개인정보가 다른 사람에게 알려지는 것을 막기 위해서 이와 같은 절차가 더욱 필요하다고 하겠습니다.<br /><br />

						에누리는 개인정보 취급 직원을 최소한으로 제한하고 담당직원에 대한 수시 교육을 통하여 본 정책의 준수를 강조하고 있으며, 감사위원회의 감사를 통하여 본 정책의 이행사항 및 담당직원의 준수여부를 확인하여 문제가 발견될 경우 바로 시정조치하고 있습니다.<br /><br />

						에누리의 개인정보보호를 위한 기술적, 관리적 대책은 아래와 같습니다.<br /><br />

						1) 컴퓨터 바이러스에 의한 개인정보의 침해를 방지하기 위하여 백신프로그램을 이용하며 주기적인 업데이트를 통해 새로운 바이러스에 대비하고 있습니다.<br />
						2) 개인정보에 대한 직접적인 접근을 방지하기 위하여 데이터베이스의 보안기능을 이용하여 일부 정보는 열람할 수 없도록 하고 있습니다.<br />
						3) 인터넷망을 통한 해커의 불법적 침입에 대비하여 방화벽과 침입탐지 시스템을 사용하여 보안에 만전을 기하고 있습니다.<br />
						4) 개인정보에 대한 접근권한을 개인정보관리책임자 등 개인정보관리업무를 수행하는 자, 기타 업무상 개인정보의 취급이 불가피한 자로 제한하며, 그 이외의 인원이 개인정보에 접근하는 것을 허용하지 않습니다.<br />
						5) 개인정보와 일반 데이터를 혼합하여 탑재하지 않으며, 별도의 계정을 통하여 관리하고 있습니다.<br />
						6) 전산실은 출입통제 구역으로 지정하여 허락된 인원만의 출입을 허용하고 있습니다.
						</p>

						<h2>10. 에누리 개인정보 관리책임자 및 담당자의 소속-성명 및 연락처</h2>
						<p>에누리는 귀하가 좋은 정보를 안전하게 이용할 수 있도록 최선을 다하고 있습니다.<br />
						개인정보를 보호하는데 있어 이용자들께 고지한 사항들에 반하는 사고가 발생할 경우 개인정보관리책임자가 책임을 집니다.<br /><br />

						이용자 개인정보와 관련한 아이디(ID)의 비밀번호에 대한 보안유지책임은 해당 이용자 자신에게 있습니다.<br />
						에누리는 비밀번호에 대해 어떠한 방법으로도 이용자에게 직접적으로 질문하는 경우는 없으므로 타인에게 비밀번호가 유출되지 않도록 각별히 주의하시기 바랍니다.<br />
						특히 "9. 개인정보보호를 위한 기술적-관리적 대책"에서 명시한 것과 같이 공공장소에서 온라인상에서 접속해 있을 경우에는 더욱 유의하셔야 합니다.<br />
						에누리는 개인정보에 대한 의견수렴 및 불만처리를 담당하는 개인정보 관리책임자 및 담당자를 지정하고 있고, 연락처는 아래와 같습니다.<br /><br />

						개인정보관리 책임자<br />
						이름 이주현<br />
						직위 이사<br />
						전화번호 02-6354-3601<br />
						팩스 02-6354-3600<br />
						전자우편주소 nova23@enuri.com<br />
						<br />
						개인정보 고충처리 담당자<br />
						이름 김범일<br />
						직위 사원<br />
						전화번호 02-6354-3601<br />
						팩스 02-6354-3600<br />
						전자우편주소 powerkby3@enuri.com<br />
						</p>

						<h2>11. 개인정보관련 의견수렴 및 불만처리에 관한 사항</h2>
						<p>에누리는 개인정보보호와 관련하여 이용자 여러분들의 의견을 수렴하고 있으며 불만을 처리하기 위하여 모든 절차와 방법을 마련하고 있습니다.<br />
						이용자들은 상단에 명시한 "11. 에누리 개인정보 관리책임자 및 담당자의 소속-성명 및 연락처"를 참고하여 전화나 메일을 통하여 불만사항을 신고할 수 있고, 에누리는 이용자들의 신고사항에 대하여 신속하고도 충분한 답변을 해 드릴 것입니다.<br />
						또는 정부에서 설치하여 운영중인 아래의 기관에 불만처리를 신청할 수 있습니다.<br /><br />

						-  개인정보침해신고센터(한국인터넷진흥원,http://www.privacy.go.kr/wcp/inv/InvPttRegist.do, 전화 국번없이 118)<br />
						- 정보보호마크 인증위원회 (한국정보통신진흥협회, http://www.eprivacy.or.kr, 전화 02-550-9531~2)<br />
						- 경찰청 사이버테러대응센터(네탄, http://www.netan.go.kr, 전화 국번없이 182)
						</p>
						<h2>12. 개인정보 처리의 위탁에 관한 사항</h2>
						<p>
							에누리는 CJ 대한통운 배송 서비스 업체인 ㈜굿스플로에 위탁 동의를 받고 있으며
							이용자의 동의 없이 이용자의 개인정보를 외부 업체에 위탁하지 않습니다.
							하단의 업체는 이용자에게 사전 통지 또는 동의를 얻어 위탁 업무를 대행하고 있습니다.
							</br>
							- 제공목적: 배송정보, 안내서비스 제공<br>
							- 제공받는 자: ㈜굿스플로
						</p>
						<h2>13. 고지의 의무</h2>
						<p>
						이 개인정보취급방침은 2014년 8월 22일부터 적용되며, 법령, 정책 또는 보안기술의 변경에 따라 내용의<br/>
						추가,삭제 및 수정이 있을 시에는 변경사항의 시행일의 7일전부터	 에누리 사이트의 공지사항을 통하여 고지할 것 입니다
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
</script>