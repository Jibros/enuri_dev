<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.mobile.Faq_Data"%>
<%@ page import="com.enuri.bean.mobile.Faq_Proc"%>
<%@ page import="com.enuri.bean.mobile.Reply_Data"%>
<%@ page import="com.enuri.bean.mobile.Reply_Proc"%>
<jsp:useBean id="Faq_Data" class="com.enuri.bean.mobile.Faq_Data" scope="page" />
<jsp:useBean id="Faq_Proc" class="com.enuri.bean.mobile.Faq_Proc" scope="page" />
<jsp:useBean id="Reply_Data" class="com.enuri.bean.mobile.Reply_Data" scope="page" />
<jsp:useBean id="Reply_Proc" class="com.enuri.bean.mobile.Reply_Proc" scope="page" />
<%

	int intFaq_seq = ChkNull.chkInt(request.getParameter("faq_seq"),0);
	int intFaq_type = ChkNull.chkInt(request.getParameter("faq_type"),2);
	int intKind = ChkNull.chkInt(request.getParameter("kind"),8);

	String strKeyword = ChkNull.chkStr(request.getParameter("keyword"));
	String strNo_list = ChkNull.chkStr(request.getParameter("no_list"));
	String strService = ChkNull.chkStr(request.getParameter("service"));
	String strLoginId = cb.GetCookie("MEM_INFO","USER_ID");
	String requestUri = request.getRequestURI();

	String strUserip = request.getRemoteAddr();

	Faq_Data faq_data = null;
	Reply_Data[] reply_data = null;

	String strWriteMode = ChkNull.chkStr(request.getParameter("wm"));

	int input_int = 0;
	String input_str = "";
	if(intKind == 0 && strKeyword.length()==0){
		intKind = 1;
	}

if(intFaq_seq > 0){

	faq_data = Faq_Proc.Faq_View_One(intFaq_type, intFaq_seq, intKind);

	reply_data = Reply_Proc.Faq_Reply_List(intFaq_seq, intFaq_type);

	String cUserId = cb.GetCookie("MEM_INFO","USER_ID");
	String cUserNick = cb.GetCookie("MEM_INFO","USER_NICK");

	Cookie[] carr = request.getCookies();
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

	String faqType = "";
	String newType = "";
%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
	<meta property="og:title" content="에누리 가격비교">
	<meta property="og:description" content="에누리 모바일 가격비교">
	<meta property="og:image" content="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/images/logo_enuri.png">
	<meta name="format-detection" content="telephone=no" />
	<link rel="stylesheet" type="text/css" href="/css/mobile_v3/common.css"/>
	<link rel="stylesheet" type="text/css" href="/css/mobile_v3/cs.css"/>
	<link rel="stylesheet" type="text/css" href="/css/swiper.css"/>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="/js/swiper.min.js"></script>
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
<div id="wrap">
	<%if(!strAppyn.equals("Y")) {%>
		<header id="header" class="page_header">
			<div class="header_top">
				<div class="wrap">
					<button class="btn__sr_back comm__sprite2"><i class="icon_arrow_back comm__sprite2">뒤로</i></button>
					<div class="header_top_page_name">문의내역</div>
				</div>
			</div>
		</header>
    <%} %>

	<section id="container" class="m_faq_cont">

        <div class="my__cont_sub my__cs_cnt">

            <!-- 문의내역 - 보기 -->
            <div class="cs_inquiry_view">
                <div class="box_inner">
                    <!-- 제목 -->
                    <div class="txt_tit"><%=faq_data.getTitle()%></div>
                    <!-- 구매정보 -->
                    <div class="view_tb">
                        <table>
                            <tbody>
                                <tr>
                                    <th>문의유형</th>
                                    <%
									faqType = faq_data.getTitle();

									if(faqType.indexOf("[") > -1){
										newType = faqType.substring(faqType.indexOf("[")+1, faqType.indexOf("]"));
									}else{
										newType = faqType;
									}
									%>
                                    <td><%=newType%></td>
                                </tr>
                                <tr>
                                    <th>구매날짜</th>
                                    <%
										String yyyy = "";
										String mm = "";
										String dd = "";
										String ordDate = "";

										if(faq_data.getOrd_date().length() >= 8){
											yyyy = faq_data.getOrd_date().substring(0,4);
											mm = faq_data.getOrd_date().substring(4,6);
											dd = faq_data.getOrd_date().substring(6,8);
											ordDate = yyyy+"-"+mm+"-"+dd;
										}
									%>
                                    <td><%=ordDate%></td>
                                </tr>
                                <tr>
                                    <th>쇼핑몰</th>
                                    <td><%=faq_data.getOrd_shop_name()%></td>
                                </tr>
                                <tr>
                                    <th>주문번호</th>
                                    <td><%=faq_data.getOrd_id()%></td>
                                </tr>
                                <tr>
                                    <th>상품번호</th>
                                    <td><%=faq_data.getOrd_shop_goods_no()%></td>
                                </tr>
                            </tbody>
                        </table>
                        <!-- // -->
                        <dl>
                            <!-- 질문 -->
                            <dt>
                                <span class="txt_inquiry"><%=faq_data.getContent()%></span>
                                <div class="bot_inquiry">
                                	<% if(!faq_data.getTel().equals("")){ %>
										<span class="txt_tel">Tel. <%=faq_data.getTel()%></span>
									<% } %>
									<% if(!faq_data.getFile1().equals("")){ %>
										<a href="javascript://///" class="btn_view_image">이미지 보기</a>
									<% } %>
                                </div>
                            </dt>
                            <!-- 답변 -->
                            <%
								if(!faq_data.getReplyflag().equals("0")){
									for(int i = 0; i < reply_data.length; i++){
							%>
									<dd>
										<span class="txt_inner">
											<%= reply_data[i].getContent() %>
										</span>
									</dd>
							<%
									}
								}
							%>
                        </dl>
                    </div>
                </div>
            </div>
            <!-- // 문의내역 - 보기 -->

            <!-- 버튼 : 목록으로 -->
            <button class="btn_list">
                <span class="btn__txt" onclick="history.back(-1)">목록으로</span>
            </button>
            <!-- // -->

        </div>

        <script>
            $(window).load(function(){ // 페이지 로드후 fadeIn
                var $view = $(".cs_inquiry_view");
                $view.addClass("loaded");
            })
        </script>

		<%@ include file="/my/include/m_appDownload.jsp"%>
	</section>
</div>
<%@ include file="/my/include/m_footer.jsp"%>
<script>
	var vApp = "<%=strAppyn%>";
	var vTitle = "문의내역";

	$(document).ready(function() {
		$(".btn_view_image").click(function(){
			var url = "my_faq_image.jsp?param=<%=faq_data.getFile1()%>";
            window.open(url, "_blank");
		});

		//title생성
		try{
			window.android.getEmoneyTitle("문의내역");
		}catch(e){}

		//헤더 뒤로가기
		$(".btn__sr_back, .btn_list").click(function(){
			if(vApp != 'Y' ){	// 웹에서 호출
				location.href = "/mobilefirst/emoney/emoney_faq.jsp";
			}else{
				// 앱에서 호출
				if(window.android){		// 안드로이드
					window.location.href = "close://";
				}else{					// 아이폰에서 호출
					window.location.href = "close://";
				}
			}
		});
	});
</script>
</body>
</html>
<script language="JavaScript" src="<%=ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
<%
}else{
	response.sendRedirect("/mobilefirst/IndexNew.jsp");
}
%>