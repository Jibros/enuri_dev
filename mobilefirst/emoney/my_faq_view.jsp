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
	<meta property="og:title" content="????????? ????????????">
	<meta property="og:description" content="????????? ????????? ????????????">
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
           //???????????? UA-52658695-3 ?????? ??????
           ga('create', 'UA-52658695-3', 'auto');
     </script>
</head>
<body>
<div id="wrap">
	<%if(!strAppyn.equals("Y")) {%>
		<header id="header" class="page_header">
			<div class="header_top">
				<div class="wrap">
					<button class="btn__sr_back comm__sprite2"><i class="icon_arrow_back comm__sprite2">??????</i></button>
					<div class="header_top_page_name">????????????</div>
				</div>
			</div>
		</header>
    <%} %>

	<section id="container" class="m_faq_cont">

        <div class="my__cont_sub my__cs_cnt">

            <!-- ???????????? - ?????? -->
            <div class="cs_inquiry_view">
                <div class="box_inner">
                    <!-- ?????? -->
                    <div class="txt_tit"><%=faq_data.getTitle()%></div>
                    <!-- ???????????? -->
                    <div class="view_tb">
                        <table>
                            <tbody>
                                <tr>
                                    <th>????????????</th>
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
                                    <th>????????????</th>
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
                                    <th>?????????</th>
                                    <td><%=faq_data.getOrd_shop_name()%></td>
                                </tr>
                                <tr>
                                    <th>????????????</th>
                                    <td><%=faq_data.getOrd_id()%></td>
                                </tr>
                                <tr>
                                    <th>????????????</th>
                                    <td><%=faq_data.getOrd_shop_goods_no()%></td>
                                </tr>
                            </tbody>
                        </table>
                        <!-- // -->
                        <dl>
                            <!-- ?????? -->
                            <dt>
                                <span class="txt_inquiry"><%=faq_data.getContent()%></span>
                                <div class="bot_inquiry">
                                	<% if(!faq_data.getTel().equals("")){ %>
										<span class="txt_tel">Tel. <%=faq_data.getTel()%></span>
									<% } %>
									<% if(!faq_data.getFile1().equals("")){ %>
										<a href="javascript://///" class="btn_view_image">????????? ??????</a>
									<% } %>
                                </div>
                            </dt>
                            <!-- ?????? -->
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
            <!-- // ???????????? - ?????? -->

            <!-- ?????? : ???????????? -->
            <button class="btn_list">
                <span class="btn__txt" onclick="history.back(-1)">????????????</span>
            </button>
            <!-- // -->

        </div>

        <script>
            $(window).load(function(){ // ????????? ????????? fadeIn
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
	var vTitle = "????????????";

	$(document).ready(function() {
		$(".btn_view_image").click(function(){
			var url = "my_faq_image.jsp?param=<%=faq_data.getFile1()%>";
            window.open(url, "_blank");
		});

		//title??????
		try{
			window.android.getEmoneyTitle("????????????");
		}catch(e){}

		//?????? ????????????
		$(".btn__sr_back, .btn_list").click(function(){
			if(vApp != 'Y' ){	// ????????? ??????
				location.href = "/mobilefirst/emoney/emoney_faq.jsp";
			}else{
				// ????????? ??????
				if(window.android){		// ???????????????
					window.location.href = "close://";
				}else{					// ??????????????? ??????
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