<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.mobile.Faq_Data"%>
<%@ page import="com.enuri.bean.mobile.Faq_Proc"%>
<jsp:useBean id="Faq_Data" class="com.enuri.bean.mobile.Faq_Data" scope="page" />
<jsp:useBean id="Faq_Proc" class="com.enuri.bean.mobile.Faq_Proc" scope="page" />
<%
     String strQno = ChkNull.chkStr(request.getParameter("qno"),"");
     int intFaq_seq = ChkNull.chkInt(request.getParameter("faq_seq"),0);
     int intFaq_type = ChkNull.chkInt(request.getParameter("faq_type"),2);
     int intKind = ChkNull.chkInt(request.getParameter("kind"),8);

     String strKeyword = ChkNull.chkStr(request.getParameter("keyword"));
     String strNo_list = ChkNull.chkStr(request.getParameter("no_list"));
     String strService = ChkNull.chkStr(request.getParameter("service"));
     String strLoginId = cb.GetCookie("MEM_INFO","USER_ID");
     String requestUri = request.getRequestURI();

     int iPage = ChkNull.chkInt(request.getParameter("page"),1);
     int iPageSize = ChkNull.chkInt(request.getParameter("pagesize"),10); //페이지당 게시물수
     int iListSize = 10; //페이징단위
     int iPageCount = 0;
     int iTotalCnt= 0;

     String strUserip = request.getRemoteAddr();

     int intReply_seq = 0;
     Faq_Data[] faq_data = null;

     String strWriteMode = ChkNull.chkStr(request.getParameter("wm"));
     if(iPage<1){
           iPage = 1;
     }

     int input_int = 0;
     String input_str = "";
     if(intKind == 0 && strKeyword.length()==0){
           intKind = 1;
     }

     faq_data = Faq_Proc.Faq_Board_main_one(intFaq_type, strLoginId, intKind, iPageSize);

     iTotalCnt = Faq_Proc.getTotal();

     if(iTotalCnt>0){
            if( (iTotalCnt%iPageSize)!=0){
                iPageCount = (iTotalCnt/iPageSize) +1;
         }else{
          iPageCount = iTotalCnt/iPageSize;
         }
     }
     Cookie[] carr = request.getCookies();
     String strApp = ChkNull.chkStr(request.getParameter("app"),"");
     String strAppyn = "";
     String strVerios = "";
     String strAd_id = "";
     int intVerios = 0;

     try {
           for(int i=0;i<carr.length;i++){
               if(carr[i].getName().equals("appYN")){
                strAppyn = carr[i].getValue();
                break;
               }
           }
           for(int i=0;i<carr.length;i++){
               if(carr[i].getName().equals("verios")){
                strVerios = carr[i].getValue();
                break;
               }
           }
           for(int i=0;i<carr.length;i++){
               if(carr[i].getName().equals("adid")){
                strAd_id = carr[i].getValue();
                break;
               }
           }
     } catch(Exception e) {
     }

     String szRemoteHost = request.getRemoteHost().trim();
     if(!strAppyn.equals("Y") && szRemoteHost.indexOf("58.234.199.")<0){
           //response.sendRedirect("/mobilefirst/Index.jsp");
     }


%>
<!DOCTYPE html>
<html lang="ko">
<head>
     <meta charset="utf-8">
     <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
     <meta property="og:title" content="에누리 가격비교">
     <meta property="og:description" content="에누리 모바일 가격비교">
     <meta property="og:image" content="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilenew/images/logo_enuri.png">
     <meta name="format-detection" content="telephone=no" />
     <link rel="stylesheet" type="text/css" href="/css/mobile_v2/common.css"/>
     <link rel="stylesheet" type="text/css" href="/css/mobile_v2/cs.css"/>
     <script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
     <script type="text/javascript" src="/mobilefirst/js/utils.js"></script>
     <script>
     (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
           (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
          m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
          })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
           //런칭할때 UA-52658695-3 으로 변경
           ga('create', 'UA-52658695-3', 'auto');
     </script>
</head>
<body>
<!-- 모바일웹/앱 분기 : 앱일때 isApp클래스 붙여주세요 -->
<!-- 엡에서 모바일웹의 페이지 전환효과를 제거합니다. -->
<div id="wrap">
    <!-- <div id="wrap" class="isApp"> -->
	<%if(!strAppyn.equals("Y")) {%>
		<header id="header" class="page_header nomargin">
			<div class="header_top">
				<div class="wrap">
					<button class="btn__sr_back comm__sprite2"><i class="icon_arrow_back comm__sprite2">뒤로</i></button>
					<div class="header_top_page_name">자주 묻는 질문</div>
				</div>
			</div>
		</header>
    <%} %>

	<section id="container" class="m_faq_cont">
		<div class="my__cont_sub my__cs_cnt" id="wrap_1">
            <!-- 버튼 - 문의하기 -->
            <div class="cs_head">
                <span class="cs_head_txt"><span class="my__sprite ico_inquiry"></span>문의 전 FAQ를 확인해보세요</span>
                <a href="javascript:void(0);" class="btn_inquiry">문의하기</a>
            </div>
            <!-- // 버튼 - 문의하기 -->

            <!-- CS 탭 -->
            <div class="cs_tab tab_group">
                <ul>
                    <li class="on"><a data-id="#tab_faq" href="javascript:void(0);">자주묻는 질문</a></li>
                    <li ><a data-id="#tab_myq" href="javascript:void(0);">내 문의내역</a></li>
                </ul>
            </div>
            <!-- // CS 탭 -->

            <div class="cs_tab_cnt">

                <!-- 탭 - 자주 묻는 질문 -->
                <div id="tab_faq" class="tab_cs tab_cs_faq">
                    <ul>
                        <li class="btn_faq_item" data-id="q1">
                            <dl>
                                <!-- 질문 -->
                                <dt class="txt_q">
                                    <span class="txt_inner">에누리 가격비교 앱 e머니는 어떤 서비스 인가요?</span>
                                </dt>
                            </dl>
                        </li>
                        <li class="btn_faq_item" data-id="q2">
                            <dl>
                                <dt class="txt_q">
                                    <span class="txt_inner">e머니 적립은 어떻게 받을 수 있나요?</span>
                                </dt>
                            </dl>
                        </li>
                        <li class="btn_faq_item" data-id="q3">
                            <dl>
                                <dt class="txt_q">
                                    <span class="txt_inner">구매 후 적립 받는 e머니는 얼마나 되나요?</span>
                                </dt>
                            </dl>
                        </li>
                        <li class="btn_faq_item" data-id="q4">
                            <dl>
                                <dt class="txt_q">
                                    <span class="txt_inner">구매 후 30일이 지났는데 적립이 되지 않아요.</span>
                                </dt>
                            </dl>
                        </li>
                        <li class="btn_faq_item" data-id="q5">
                            <dl>
                                <dt class="txt_q">
                                    <span class="txt_inner">e머니 사용은 어떻게 하나요?</span>
                                </dt>
                            </dl>
                        </li>
                        <li class="btn_faq_item" data-id="q6">
                            <dl>
                                <dt class="txt_q">
                                    <span class="txt_inner">e머니로 교환한 e쿠폰 사용방법 알려 주세요.</span>
                                </dt>
                            </dl>
                        </li>
                        <li class="btn_faq_item" data-id="q7">
                            <dl>
                                <dt class="txt_q">
                                    <span class="txt_inner">적립된 e머니는 언제 소멸되나요?</span>
                                </dt>
                            </dl>
                        </li>
                        <li class="btn_faq_item" data-id="q8">
                            <dl>
                                <dt class="txt_q">
                                    <span class="txt_inner">교환한 e쿠폰 교환 및 환불 되나요?</span>
                                </dt>
                            </dl>
                        </li>
                        <li class="btn_faq_item" data-id="q9">
                            <dl>
                                <dt class="txt_q">
                                    <span class="txt_inner">교환한 e쿠폰 상품에 오류가 있어 사용이 안 됩니다.</span>
                                </dt>
                            </dl>
                        </li>
                    </ul>
                </div>
                <!-- // 탭 - 자주 묻는 질문 -->

                <!-- 탭 - 내 문의 내역 -->
                <div id="tab_myq" class="tab_cs tab_cs_myq" style="display:none">
                    <ul>
                    	<%
                           if(faq_data.length == 0){
                     	%>
		                        <!-- 결과 없음 -->
		                        <li class="no_result" class="no_result">
		                            <span class="comm__sprite ico_caution"></span>
		                            <span class="txt_tit">작성하신 문의 내역이 없습니다</span>
		                        </li>
		                        <!-- // 결과 없음 -->
                        <%
                           }else{
                                for(int i = 0; i < faq_data.length; i++){
                    	%>
                                	<li class="btn_myq_item" data-id="200">
                    	<%
                                     if(!faq_data[i].getReplyflag().equals("")){
                     	%>
				                            <span class="txt_a_compt">
                        <%
                                     }else{
                    	%>
				                            <span class="txt_a_ready">
                        <%
                                     }
                    	%>
			                                	<span class="txt_inner"><a href="javascript:void(0);" data-id="<%=faq_data[i].getFaq_seq()%>"><%=faq_data[i].getTitle()%></a></span>
				                            </span>
				                        </li>
                    	<%
                                }
                     	%>
                     	<%
                           }
                     	%>
                    </ul>
                </div>
                <!-- // 내 문의 내역 -->
            </div>
		</div>

		<div class="my__cont_sub my__cs_cnt" id="wrap_2" style="display:none;">
            <div class="cs_tab_cnt">
            	<div id="tab_faq" class="tab_cs tab_cs_faq">
            		<ul>
            			<li class="selected">
            				<dl>
				                <dt class="txt_q" id="q1" style="display:none;">
				                	<span class="txt_inner">
				                		에누리 가격비교 앱 e머니는 어떤 서비스 인가요?
				                	</span>
			                	</dt>
				                <dd id="a1" class="txt_a" style="display:none;">
				                	<span class="txt_inner">
						                <span class="mall">
						                	에누리 가격비교 앱(APP)을 이용하여,<br>상품구매 및 이벤트 참여 시 적립 받는 혜택입니다.
					                	</span><br>
						                <span class="mall">
						                	적립된 e머니는 My계정 내 쿠폰스토어에서 <br>e쿠폰으로 교환 가능합니다.
					                	</span><br>
				                	</span>
				                </dd>
				                <dt class="txt_q" id="q2" style="display:none;">
				                	<span class="txt_inner">
				                		e머니 적립은 어떻게 받을 수 있나요?
				                	</span>
			                	</dt>
				                <dd id="a2" class="txt_a" style="display:none;">
				                	<span class="txt_inner">
						                <span style="font-weight:bold;">▶ e머니 적립 방법</span><br>
						                <span class="mall">에누리 앱을 통해 적립대상 쇼핑몰에서 구매</span>
						                <span class="mall">에누리 이벤트 참여</span><br>
						                <span style="font-weight:bold;">▶ 구매 적립 유의사항</span><br>
						                <span class="mall">에누리 앱 로그인 > 적립대상쇼핑몰 이동 > 구매 > <br/>10~30일 후 e머니 적립</span>
						                <p class="faq_img">
						                     <img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/emoney/faq/faq02.png" alt=""/>
						                </p>
						                <span class="mall" style="font-weight:bold;">적립대상쇼핑몰</span>
						                <span>
						                	G마켓, 옥션, 11번가, 인터파크, 티몬, GS SHOP, CJmall, SSG.com (신세계몰, 신세계백화점, 이마트, 트레이더스), 위메프 <br />
						                	※ SSG.com은 2016년 8월 1일 구매부터 적용<br>※ 위메프는 2017년 6월 14일 구매부터 적용
						                </span><br /><br />
						                <span class="mall" style="font-weight:bold;">적립 불가한 경우</span>
											<ul class="indent">
												<li>- 에누리 앱에서 로그인하지 않고 구매한 경우</li>
												<li>- 다른 앱(11번가, 네이버 등)에서 장바구니 또는 관심상품 등록 후 에누리앱으로 결제만 한 경우</li>
												<li>- PC 또는 모바일WEB에서 구매한 경우</li>
												<li>- 구매 후 환불/취소/교환한 경우</li>
											</ul><br />
						                <span class="mall" style="font-weight:bold;">적립 제외 카테고리/서비스</span>
						                <ul class="indent">
						                	<li>1) 공통</li>
											<li>- 에누리 앱에서 검색되지 않는 상품</li>
											<li>- 지역쿠폰, 배달상품, 여행상품, 항공권, 중고상품, 해외직구</li>
											<li>2) 쇼핑몰 별 적립제외 상품</li>
											<li>- 옥션, G마켓: 중고장터, 여행상품, 항공권, 배달 및 지역쿠폰</li>
											<li>- 11번가 : 여행/숙박/항공, 모바일쿠폰 및 상품권, 배달 및 지역쿠폰</li>
											<li>- SSG: 도서/음반/문구/취미/여행, 모바일쿠폰 및 상품권</li>
											<li>- 위메프 : 모바일쿠폰 및 상품권</li>
											<li>- CJmall, GS SHOP : 모바일쿠폰 및 상품권</li>
											<li>- 인터파크 : 모바일쿠폰 및 상품권, 배달 및 지역쿠폰, 라이프 서비스 (티켓, 투어, 아이마켓 등)</li>
											<li>- 이 외 쇼핑몰에 입점한 제휴 서비스</li>
											<li>3) 일부 쇼핑몰 상품권 및 e쿠폰 적립 안내</li>
											<li>- 적립가능 상품 : 문화/도서/백화점상품권, 영화예매권, 국민관광상품권</li>
											<li>- 적립가능 쇼핑몰 : 티몬, 옥션, G마켓</li>
						                    <li style="margin-top:10px;">※ e머니가 적립되지 않을 경우 고객센터로 문의주세요.</li>
						                </ul>
					                </span>
				                </dd>
				                <dt class="txt_q" id="q3" style="display:none;">
				                	<span class="txt_inner">
				                		구매 후 적립 받는 e머니는 얼마나 되나요?
				                	</span>
			                	</dt>
				                <dd id="a3" class="txt_a" style="display:none;">
				                	<span class="txt_inner">
						                <span class="mall">e머니는 카테고리 별 적립률에 따라 적용됩니다. 구매하신 상품의 에누리 카테고리 기준으로 e머니가 적립 됩니다.</span><br />
						                <span class="mall">카테고리 별 적립률</span>
							            <ul class="indent">
											<li>- 1.5% 적립 : 유아 </li>
											<li>- 1.0% 적립 : 식품 / 스포츠 / 레저 / 자동차 </li>
											<li>- 0.8% 적립 : 컴퓨터 / 도서 / 여행 </li>
											<li>- 0.3% 적립 : 상품권, 위에 명시되지 않은 카테고리 (디지털 / 가전 / 패션 / 화장품 / 가구 / 생활 등)</li>
							            </ul>
						                <br>
						                <span class="mall">적립 가능 상품권은 문화/도서/백화점상품권, 영화예매권, 국민관광상품권 이며, 티몬, 옥션, G마켓에서 구매시에만 적립 가능합니다.<br>그 외 쇼핑몰에서 상품권 구매 시 적립 불가합니다.</span>
						                <span class="mall">구매금액에서 배송비, 설치비, 할인, 쇼핑몰 포인트 등 제외한 상품 결제금액 기준으로 해당 카테고리의 적립률이 계산됩니다.<br>최소 1,000원 이상 구매 시 적립되며 1점 단위는 적립되지 않습니다.</span>
					                </span>
				                </dd>
				                <dt class="txt_q" id="q4" style="display:none;">
				                	<span class="txt_inner">
				                		구매 후 30일이 지났는데 적립이 되지 않아요.
				                	</span>
			                	</dt>
				                <dd id="a4" class="txt_a" style="display:none;">
					                <span class="txt_inner">
										<span style="font-weight:bold;">▶ 적립 불가한 경우</span><br>
											<ul class="indent">
												<li>- 에누리 앱에서 로그인하지 않고 구매한 경우</li>
												<li>- 다른 앱(11번가, 네이버 등)에서 장바구니 또는 관심상품 등록 후 에누리앱으로 결제만 한 경우  </li>
												<li>- PC 또는 모바일WEB에서 구매한 경우  </li>
												<li>- 구매 후 환불/취소/교환한 경우</li>
												<li>- 적립제외 쇼핑몰에서 구매한 경우</li>
											</ul><br />
										<span style="font-weight:bold;">▶ 적립대상 쇼핑몰</span><br>
										G마켓, 옥션, 11번가, 인터파크, 티몬, GS SHOP, CJmalll, SSG.com (신세계몰, 신세계백화점, 이마트몰, 트레이더스), 위메프<br>
										※ SSG.com은 2016년 8월 1일 구매부터 적용<br>※ 위메프는 2017년 6월 14일 구매부터 적용<br><br>
										<span style="font-weight:bold;">▶ 적립 제외 카테고리/서비스</span>
					                	<span class="mall">공통</span>
					                	<ul class="indent">
						                	<li>- 에누리 앱에서 검색되지 않는 상품</li>
											<li>- 지역쿠폰, 배달상품, 여행상품, 항공권, 중고상품, 해외직구</li>
					                	</ul>
										<span class="mall" > 쇼핑몰 별 적립제외 상품</span>
										<ul class="indent">
											<li>- 옥션, G마켓: 중고장터, 여행상품, 항공권, 배달 및 지역쿠폰</li>
											<li>- 11번가 : 여행/숙박/항공, 모바일쿠폰 및 상품권, 배달 및 지역쿠폰</li>
											<li>- SSG: 도서/음반/문구/취미/여행, 모바일쿠폰 및 상품권</li>
											<li>- 위메프 : 모바일쿠폰 및 상품권</li>
											<li>- CJmall, GS SHOP : 모바일쿠폰 및 상품권</li>
											<li>- 인터파크 : 모바일쿠폰 및 상품권, 배달 및 지역쿠폰, 라이프 서비스 (티켓, 투어, 아이마켓 등)</li>
											<li>- 이 외 쇼핑몰에 입점한 제휴 서비스</li>
										</ul>
										<span class="mall"> 일부 쇼핑몰 상품권 및 e쿠폰 적립 안내</span>
										<ul class="indent">
											<li>- 적립가능 상품 : 문화/도서/백화점상품권, 영화예매권, 국민관광상품권</li>
											<li>- 적립가능 쇼핑몰 : 티몬, 옥션, G마켓</li>
											<li>  <span style="margin-top:10px;"><br>※ e머니가 적립되지 않을 경우 고객센터로 문의주세요.</span> </li>
										</ul>
									</span>
				                </dd>
				                <dt class="txt_q" id="q5" style="display:none;">
				                	<span class="txt_inner">
				                		e머니 사용은 어떻게 하나요?
				                	</span>
			                	</dt>
				                <dd id="a5" class="txt_a" style="display:none;">
				                	<span class="txt_inner">
					               		 적립된 e머니는 My페이지에서 e쿠폰으로 교환할 수 있습니다.<br><br>
						                <span style="font-weight:bold;">▶ e쿠폰 교환 방법</span><br>
						                <ul class="faq5">
						                     <li><p>1) 앱(APP) 우측 상단 My페이지</p><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/emoney/faq/faq05_01.png" alt=""/></li>
						                     <li><p>2) e쿠폰 스토어 메뉴 선택</p><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/emoney/faq/faq05_02.png" alt=""/></li>
						                     <li><p>3) 원하는 e쿠폰으로 교환</p><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/emoney/faq/faq05_03.png" alt=""/></li>
						                     <li><p>4) 쿠폰함에서 교환한 e쿠폰 확인</p><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/emoney/faq/faq05_04.png" alt=""/></li>
						                </ul>
					                </span>
				                </dd>
				                <dt class="txt_q" id="q6" style="display:none;">
				                	<span class="txt_inner">
				                		e머니로 교환한 e쿠폰 사용방법 알려 주세요.
				                	</span>
			                	</dt>
				                <dd id="a6" class="txt_a" style="display:none;">
				                	<span class="txt_inner">
						                <span class="mall">교환한 e쿠폰은 My페이지 쿠폰함에서 확인하세요.</span>
						                <p class="faq_img">
											<img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/emoney/faq/faq06.png" alt=""/>
						                </p>
						                <span class="mall">e쿠폰은 바코드형과 온라인쿠폰이 있습니다.</span>
						                <br>
						                <span style="font-weight:bold;">▶ 바코드형</span><br>
										오프라인 매장에서 상품 구매 시 쿠폰 제시<br><br>
						                <span style="font-weight:bold;">▶ 온라인 쿠폰</span><br>
										사용 웹사이트에서 쿠폰번호를 입력해서 사용<br><br>
										※ 상세한 쿠폰 사용방법은 쿠폰의 상세페이지를 확인하세요.<br>
									</span>
				                </dd>
				                <dt class="txt_q" id="q7" style="display:none;">
				                	<span class="txt_inner">
				                		적립된 e머니는 언제 소멸되나요?
				                	</span>
			                	</dt>
				                <dd id="a7" class="txt_a" style="display:none;">
				                	<span class="txt_inner">
										<span class="mall">유효기간이 지난 e머니는 자동 소멸되며, 소멸된 e머니는 재적립 불가합니다.</span>
										<span class="mall">e머니 소멸 7일 전, 소멸 안내 Push 알림 발송 (Push 알림 미 동의 시 예외)</span>
										<br>
										<span style="font-weight:bold;">▶ 유효기간 </span><br>
										<ul class="indent">
											<li>- 구매 적립 : 적립일로부터 60일</li>
											<li>- 이벤트 적립 : 이벤트페이지 내 별도 게재</li>
										</ul><br />
										<span style="font-weight:bold;">▶ 소멸 예정 e머니 확인 방법</span><br>
										<p class="faq_img">
											<img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/emoney/faq/faq07.png" alt=""/>
										</p>
									</span>
				                </dd>
				                <dt class="txt_q" id="q8" style="display:none;">
				                	<span class="txt_inner">
				                		교환한 e쿠폰 교환 및 환불 되나요?
				                	</span>
			                	</dt>
				                <dd id="a8" class="txt_a" style="display:none;">
				                	<span class="txt_inner">
						                <span style="font-weight:bold;">▶ 유효기간 만료 전</span><br>
						                <span class="mall">미사용 쿠폰은 100% e머니로 환불</span>
						                <span class="mall">환불방법 : 쿠폰 상세페이지 하단 ‘환불요청’</span>
						                <br>
						                <span>※최초 교환시 e머니 적립 시점에 따라 환불 e머니 유효기간이 다를 수 있습니다.</span><br>
						                <span>- 만료시점이 과거 : 유효기간 1일</span><br>
						                <span>- 오늘 만료예정 : 유효기간 1일</span><br>
						                <span>- 유효기간 남은 경우 : 유효기간 유지</span><br>
						                <br>
						                <span style="font-weight:bold;">▶ 유효기간 만료 후</span><br>
						                <span class="mall">사용여부에 관계없이 교환 및 환불 불가</span>
						                <br>
					                </span>
				                </dd>
				                <dt class="txt_q" id="q9" style="display:none;">
				                	<span class="txt_inner">
				                		교환한 e쿠폰 상품에 오류가 있어 사용이 안 됩니다.
				                	</span>
			                	</dt>
				                <dd id="a9" class="txt_a" style="display:none;">
				                	<span class="txt_inner">
										<span>▶ e쿠폰으로 교환했으나 쿠폰함에 없을 경우, 또는 사용할 수 없는 바코드로 확인될 경우</span>
										<span class="mall">에누리 고객센터로 문의주시면 100% e머니로 환불해 드립니다._</span><br />
										<span>▶ 교환한 e쿠폰 상품이 단종됐을 경우</span>
										<span class="mall">e쿠폰 유효기간 만료 전 에누리 고객센터로 문의주시면 100% e머니로 환불해 드립니다.</span><br />
										<span>▶ e쿠폰 환불 접수</span>
										<span class="mall">모바일 : 자주묻는질문> 문의하기 </span>
										<span class="mall">PC : 고객센터 > 문의하기</span>
									</span>
				                </dd>
				           </dl>
            			</li>
            		</ul>
            	</div>

            	<!-- 버튼 : 목록으로 -->
                <button class="btn_list">
                    <span class="btn__txt">목록으로</span>
                </button>
                <!-- // -->
            </div>
		</div>
		<% // @ include file="/my/include/m_appDownload.jsp"%>
	</section>
<%@ include file="/my/include/m_footer.jsp"%>
</div>
<script>
	var vQno = "<%=strQno%>";
	var vApp = "<%=strAppyn%>";
	var idx = 0;
	var vHash = window.location.hash;
	var vTitle = "자주묻는 질문";

	ga('send', 'pageview', {
		'page': '/mobilefirst/emoney/emoney_faq.jsp',
		'title': 'mf_emoney_'+vTitle
	});

	 //title생성
	try{
		window.android.getEmoneyTitle(vTitle);
	}catch(e){}

	$(document).ready(function() {
		//탭 선택
		$('.tab_group li').click(function(){
		    var idx = $(this).index();
		    var attr = $(this).find("a").attr("data-id");

		    $(this).addClass("on").siblings().removeClass("on");
            $(attr).show().siblings().hide();

		    if (idx == 1){
				if(IsLogin()){
				}else{
					if(vApp == "Y"){
						if(window.android){        // 안드로이드
							window.android.goLogin(true);
						}else{                                     // 아이폰에서 호출
							window.location.href = "enuriappcall://goLogin";
						}
					}
				}
		    }
		});

		//자주묻는 질문 상세 이동
		$("#tab_faq li").click(function() {
		    var qno = $(this).index() + 1;
		    ga('send', 'event', 'mf_emoney', 'faq', 'click_faq');

		    if(vApp == "N"){
		        setTimeout(function(){ // 페이지 전환 효과 뒤 이동(웹)
		        	location.href = "/mobilefirst/emoney/emoney_faq_ans.jsp?qno="+qno+"";
				},600);
		    }else{
	        	location.href = "/mobilefirst/emoney/emoney_faq_ans.jsp?qno="+qno+"&freetoken=faq";
		    }
		});

		//내 문의내역 상세 이동
		$("#tab_myq li:not(.no_result)").click(function() {
			var faq_seq = $(this).find('a').attr('data-id');

		    if(vApp == "N"){
            	setTimeout(function(){ // 페이지 전환 효과 뒤 이동(웹)
            		location.href='/mobilefirst/emoney/my_faq_view.jsp?faq_seq='+faq_seq+'&faq_type=2&kine=8';
				},600);
		    }else{
		    	location.href='/mobilefirst/emoney/my_faq_view.jsp?faq_seq='+faq_seq+'&faq_type=2&kine=8&freetoken=emoney_sub';
		    }
		});

		//헤더 뒤로가기
		$("#header .btn__sr_back").click(function(){
			if(vApp != 'Y' ){	// 웹에서 호출
				history.back(-1);
			}else{
				// 앱에서 호출
				if(window.android){		// 안드로이드
					window.location.href = "close://";
				}else{					// 아이폰에서 호출
					window.location.href = "close://";
				}
			}
		});

		/* if(vQno.length > 0){
            $('#a'+vQno+', #q'+vQno+'').show();
            $("#wrap_2").show();
        }else{
            $("#wrap_1").show();
        } */

		if(vHash == "#1"){
		    $("#tab_faq").click();
		}

		if(vApp == "Y"){
			$('#wrap').addClass("isApp");
		}
	});

	$(".btn_inquiry").click(function() {
		if(IsLogin()){
		    setTimeout(function(){location.href = "/mobilefirst/emoney/my_faq_write.jsp?faq_type=2&kind=8&freetoken=emoney_sub"},600);
		    ga('send', 'event', 'mf_emoney', 'faq', 'click_문의하기');
		}else{
		    if(vApp == "Y"){
			    if(window.android){        // 안드로이드
					window.android.goLogin(true);
			    }else{                                     // 아이폰에서 호출
					window.location.href = "enuriappcall://goLogin";
			    }
		    }else{
		    	goLogin();
		    }
		}
	});
</script>

<script>
	$(function(){
	 	// 리스트 선택시 페이지 전환 효과 (모바일웹 only)
        var isApp = $("#wrap").hasClass("isApp"); // 모바일앱/웹 분기
        var $content = $('.m_faq_cont');
        var $list = $(".tab_cs"); // 탭 컨텐츠 영역
        var $btnFaq = $list.find(".btn_faq_item, .btn_myq_item"); // 리스트 아이템
        $btnFaq.on("click",function(){
            var $this = $(this);
            if ( !isApp ){ // 모바일웹일때
                var _distance = ( $this.offset().top - $content.offset().top - $(window).scrollTop() ) * -1;
                var _id = $this.attr('data-id'); // 게시글 번호
                $content.css("transform","translateY("+_distance+"px)")
                $this.closest('.tab_cs').stop(true,false).animate({height:$(window).height() * 2},500);
                $this.addClass("selected").siblings().css("opacity",0);
                $(".btn_list_more").fadeOut(100); // 더보기 버튼
            }else{ // 앱일때
            }
        });
    });

    function goFooterTop(){
		$('html,body').scrollTop(0);
	}
</script>
</body>
</html>
<script language="JavaScript" src="<%=ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
