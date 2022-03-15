<%@page import="java.net.UnknownHostException"%>
<%@page import="java.net.InetAddress"%>
<%@page import="java.net.SocketException"%>
<%@page import="java.net.NetworkInterface"%>
<%@page import="java.util.Enumeration"%>
<%!
public String getClientIP(HttpServletRequest request) {
    String ip = request.getHeader("X-FORWARDED-FOR"); 
    if (ip == null || ip.length() == 0) {
        ip = request.getHeader("Proxy-Client-IP");
    }

    if (ip == null || ip.length() == 0) {
        ip = request.getHeader("WL-Proxy-Client-IP");  // 웹로직
    }

    if (ip == null || ip.length() == 0) {
        ip = request.getRemoteAddr() ;
    }
    
    return ip;
}
%>
<%
	String strPlKeyword = ConfigManager.RequestStr(request, "keyword", "");

	strPlKeyword = HtmlStr.removeHtml(strPlKeyword);
	strPlKeyword = HtmlStr.replaceHtmlTags(strPlKeyword);

	if (CutStr.cutStr(strPlKeyword,2).equals("%u")){
		strPlKeyword = CvtStr.unescape(strPlKeyword);
	}

	if (strPlKeyword.indexOf("%u") >= 0 || strPlKeyword.indexOf("%20") >= 0){
		strPlKeyword = CvtStr.unescape(strPlKeyword);
	}else if(strPlKeyword.indexOf("%25") >= 0){
		strPlKeyword = CvtStr.unescape(CvtStr.unescape(strPlKeyword));
	}

  	String mvShowModelno = ConfigManager.RequestStr(request, "mvShowModelno", "");
	// 1, 2, 3 첫번째 두번째 세번째 탭
	String miniVipTab = ConfigManager.RequestStr(request, "miniVipTab", "0");
	String userIP = getClientIP(request);
	String mini_USER_ID= cb.GetCookie("MEM_INFO","USER_ID");
    String mini_TMPUSER_ID= cb.GetCookie("MEM_INFO","TMP_ID");
	String mini_USER_NICK= cb.GetCookie("MEM_INFO","USER_NICK");
    String mini_SNSTYPE = cb.GetCookie("MEM_INFO","SNSTYPE");
	 //VIEW ID 
	String strViewID = "";
	if(mini_SNSTYPE.equals("K") || mini_SNSTYPE.equals("N")){
		strViewID = mini_USER_NICK;
	}else {
		if(!USER_NICK.equals("")){
			strViewID = mini_USER_NICK;
		}else{
			strViewID = mini_USER_ID;
		}
	}
%>
<div class="lay-comm--head">
	<strong class="lay-comm__tit">가격비교 요약보기</strong>
</div>
<button class="lay-comm__btn--close comm__sprite" onclick="$(this).parent().hide()">레이어 닫기</button>     
<div class="lay-comm-body">
	<!-- 210311 LP > 미니VIP 구버전 마크업 -->
	
	<!-- minivip_wrap -->
	<div class="minivip_wrap">
		<!-- topprobox -->
		<div class="topprobox">
			<div class="infopro_area" id="mini_goodsInfo">
				<span class="thumb">
					<img id="thumb_img" src="" onerror="this.src='<%=ConfigManager.IMG_ENURI_COM%>/images/home/thum_none.gif'" alt="">
				</span>
				
				<!-- proinfo -->
				<div class="proinfo">
					<div class="modelname">
						<p class="proname"></p>
						<p class="subcon"></p>
					</div>
					<div class="fixbt_info">
						<p class="lowprice"></p>
						<p class="cashprice" style="display:none;"></p>
						<div class="starGraph" id="starGraph" style="display:none">
							<div class="point">
								<a href="javascript:///"><span style="width:0%">별점</span></a>
							</div>
							<em id="starGraphEm">()</em>
						</div>
						<div class="singoline">
							<!-- simcompair 유사상품 비교 툴팁 -->
							<span class="simcompair" id="simcompair" style="display:none;">
								비슷한 상품 비교
								<a href="#" class="badge">
									<img src="<%=ConfigManager.IMG_ENURI_COM%>/images/home/ico_quest2.gif" alt="">
									<div class="tooltip">
										<p class="txt">쇼핑몰 상품들 중에서 동일 상품으로 판단<br>되는 상품들을 자동으로 모았습니다.</p>
									</div>
								</a>
							</span>
							<!-- simcompair -->
							<a class="btn_singo2" href="javascript:///"><span>신고</span></a>
						</div>
					</div>
				</div>
				<!-- //proinfo -->
				
				<!-- 210127 : SR#44793 : 주의사항 안내 문구 추가  -->
				<div class="lawnotice">
					<div class="lawnotice__tx--main">
						<span class="icon-lawnotice">!</span> 쇼핑몰 이동 후 정확한 가격 및 상품정보를 꼭 확인 후 구매하세요. <a href="/etc/disclaimer.jsp" target="_blank">(법적고지 보기)</a>
					</div>
				</div>
				<!-- // -->
                                                
			</div>

			<div class="ad_banner">
				<a href="javascript:///" id="gourl"><img src="" alt=""></a>
			</div>

		</div>
		<!-- //topprobox -->

		<!-- mallprlist_area -->
		<div class="mallprlist_area" id="mini_mallprlist_area">
			<div class="tabarea" id="mini_tabarea">
				<ul class="tab">
					<li class="on"><a href="#tab01" id="tabarea_tab01">가격비교<em id="tab01_cnt"></em></a></li>
					<li><a href="#tab02">상품설명</a></li>
					<li><a href="#tab03">상품평<em id="tab03_cnt"></em></a></li>
					
				</ul>
			</div>
			<!-- cont_area : tab01 -->
			<div id="tab01" class="viewAreaWrap cont_area tb01">
				<div class="option_sel" id="option_sel">
					<ul>
						<li id="o_basic" class="on">판매가순</li><!-- 선택됨 li class="on" -->
						<li id="o_delivery">배송비포함순</li>
						<li id="o_card" style="display:none">카드할인가순</li>
					</ul>
				</div>
				
				<div class="pro select" id="mimi_option_sel">
					<a href="javascript:///">선택하세요.</a>
					<div class="pro sub_dp">
						<span>선택하세요</span>
						<ul>
							<li id="o_basic"><a href="javascript:///">판매가순</a></li>
							<li id="o_delivery"><a href="javascript:///">배송비포함순</a></li>
							<li id="o_card" style="display:none"><a href="javascript:///">카드할인가순</a></li>
							<li id="o_deliveryfree" style="display:none"><a href="javascript:///">무료배송</a></li>
							<li id="o_auth" style="display:none"><a href="javascript:///">제조사공식인증</a></li>
							<li id="o_cardfree" style="display:none"><a href="javascript:///">무이자</a></li>
						</ul>
					</div>
				</div>
				
				<!-- scroll_area -->
				<div class="scroll_area" id="scroll_area" style="height:650px;overflow-y:scroll;">
	
					<!-- mallprlist_zone -->
					<div class="mallprlist_zone" id="model_pricelist">
						
						<!-- tb_pack -->
						<div class="tb_pack" id="bisic_compare" style="display:none">
							
							<!-- fieldleft -->
							<div class="fieldleft">
								<div class="thead" id="lefttitle"></div>
								<div class="tbody">
									<ul class="proitemlist">
									</ul>
								</div>
							</div>
							<!-- //fieldleft -->
	
							<!-- fieldright -->
							<div class="fieldright">
								<div class="thead" id="righttitle"></div>
								<div class="tbody">
									<ul class="proitemlist">
										<%-- <li class="last"><!-- 마지막 li class="last" -->
											<div class="itembox">
												<p class="mallinfo">
													<a class="mallname" href="javascript:///"><strong>G마켓</strong></a>
												</p>
												<p class="priceline"><a href="javascript:///"><span class="pricepack"><strong>61,000</strong>원</span></a></p>
												<p class="delivery"><a href="javascript:///">배송비 2,500원</a></p>
											</div>
										</li> --%>
									</ul>
								</div>
							</div>
							<!-- //fieldright -->
							<!-- top 버튼, 8행 미만일 시 비노출 -->
							<a class="btn_packtop" id="btn_packtop" href="javascript:///" onclick="goTop(1);">TOP</a>
	
						</div>
						<!-- //tb_pack -->
						
						<!-- tb_pack 미니미니 -->
						<div class="tb_pack minix2" id="mimi_bisic_compare" style="display:none">
							<!-- fieldleft -->
							<div class="fieldleft">
								<div class="tbody">
									<ul class="proitemlist">
										<%-- <li>
											<div class="itembox">
												<p class="mallinfo">
													<a class="mallname" href="#">
														<strong>옥션</strong>
														<span class="icon sponser"><em>스폰서</em></span><span class="icon powerseller"><em>파워셀러</em></span>
													</a>
												</p>
												<p class="priceline pricelow"><a href="#"><span class="prlow">미니미니</span><span class="pricepack"><strong>8,612,000</strong>원</span></a></p><!-- 최저가 p class="pricelow" 추가 -->
												<p class="delivery"><a href="#">무료배송</a></p>
											</div>
										</li> --%>
									</ul>
								</div>
							</div>
							<!-- //fieldleft -->
							<!-- top 버튼, 8행 미만일 시 비노출 -->
							<a class="btn_packtop" id="btn_packtop" href="javascript:///" onclick="goTop(1);">TOP</a>
						</div>
						<!-- //tb_pack 미니미니 -->
						<div id="miniloadingDiv" style="display:none;position:fixed;z-index:1000;bottom:50%;right: 50%;margin-right:-665px;margin-bottom:-106px;width:50px;height:50px;"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/home/newLPSRP_loding.gif" border=0></div>
						
						<!-- tb_pack2 -->
						<div class="tb_pack2" id="similar_compare" style="display:none">
							
							<ul class="simitemlist">
								<li class="last"><!-- 마지막 li class="last" -->
									<div class="infopro_area">
										<span class="thumb">
											<img src="http://photo3.enuri.com/data/images/service/small/13471000/13471330.gif" alt="">
										</span>
										<div class="proinfo">
											<div class="modelname">
												LG 울트라PC 그램 14ZD 950-GX7BKLG 울트라PC
											</div>
											<div class="fixbt_info">
												<p class="lineprice"><a href="javascript:///"><strong>296,490</strong>원</a></p>
												<p class="etcinfo"><span>무료배송</span><span>G마켓</span></p>
											</div>
										</div>
									</div>
								</li>
							</ul>
							<a class="btn_packtop" id="btn_packtop" href="javascript:///" onclick="goTop(1); insertLog(15408);">TOP</a>
							<!-- top 버튼, 8행 미만일 시 비노출 -->
						</div>
						<!-- //tb_pack2 -->
						
						<!-- rental_zone -->
						<div class="rental_zone" id="rental_compare" style="display:none">
							<div class="guide">
								본 상품은 약정 기간 동안 매월 비용을 납부해야 하는 렌탈 상품입니다.<br>유지비가 포함되어 있어 정기적으로 필터 등의 점검을 받을 수 있습니다.
							</div>
							<p class="tit_caution">신청 전, 꼭 읽어주세요!</p>
							<div class="caution_list">
								<dl>
									<dt>렌탈신청</dt>
									<dd>렌탈 신청 양식을 작성하시면 해당 정보가 제조사 담당자에게 전달됩니다.</dd>
								</dl>
								<dl>
									<dt>계약진행</dt>
									<dd>렌탈 신청이 완료되면, 빠른 시일 내 전문상담원이 전화상품을 드립니다.</dd>
								</dl>
								<dl>
									<dt>배송/설치</dt>
									<dd>계약이 완료되면, 설치기사가 방문하여 설치 및 사용설명을 직접 드립니다.</dd>
								</dl>
							</div>
							<p class="cou_apply"><a class="btn_applygo" id="btn_rental" href="javascript:///" title="클릭 시 새창 이동">상담 신청하기</a></p>
							<a class="btn_packtop" id="btn_packtop" href="javascript:///" onclick="goTop(1);">TOP</a>
						</div>
						<!-- //rental_zone -->
						
						<!-- nodata_zone -->
						<div class="nodata_zone" id="nodata_compare" style="display:none">
					
							<div class="exclamark" id="plan_goods" style="display:none;">
								<p class="txt txt1">출시예정</p>
								<p class="txt txt2">출시예정 상품으로 아직 판매중인 쇼핑몰이 없습니다.</p>
							</div>
			
							<div class="exclamark" id="soldout_goods" style="display:none;">
								<p class="txt txt1">일시품절</p>
								<p class="txt txt2">일시품절 또는 단종되어 판매중인 쇼핑몰이 없습니다.</p>
							</div>
							<a class="btn_packtop" id="btn_packtop" href="javascript:///" onclick="goTop(1);">TOP</a>
						</div>
						<!-- //nodata_zone -->
	
						<a id="list_more" class="list_more" href="javascript:///" style="display:none">
							<span class="btn_more">더보기</span>
						</a>
						
					</div>
					<!-- //mallprlist_zone -->
					<!-- //mallprlist_area -->
					<div class="cashmallprlist_zone" id="mini_cashpricelist_area" style="display:none;">
						<!-- tb_pack -->
						<div class="tb_pack">
							<div class="field">
								<div class="thead">일반전문몰</div>
								<div class="tbody">
									<ul class="proitemlist">
									</ul>
								</div>
							</div>
							<!-- //fieldleft -->
			
						</div>
						<!-- //tb_pack -->
			
						<a class="list_more" href="javascript:void(0); " style="display:none;">
							<span class="btn_more">더보기</span>
						</a>
					</div>
					<!-- 파워링크 -->
					<%-- <%@ include file="/lsv2016/include/detail/IncMiniSponsorLink.jsp" %> --%>
					<!-- powerlink_zone -->
					<div class="powerlink_zone" style="display:none;">
						<div class="top_power">
							<a class="title" href="http://saedu.naver.com/adbiz/searchad/intro.nhn" title="새창 페이지 이동" target="_new">파워링크 <em>AD</em></a>
							<a class="applyad" href="http://saedu.naver.com/adbiz/searchad/intro.nhn" target="_new">신청하기</a>
						</div>
						<ol class="power_list"></ol>
					</div>
					<!-- //powerlink_zone -->
					<!-- //파워링크 -->
					<div id="scrollView" style="clear:both;display:block;position:relative;height:60px;"></div>
				</div>
				<!-- //scroll_area -->
				</div>
				<!-- //cont_area : tab01 -->
					
				<!-- cont_area : tab02 -->
				<div class="cont_area tb02" id="tab02" style="display: none;">
				
					<!-- scroll_area -->
					<div class="scroll_area" id="scroll_area" style="height:650px;overflow-y:scroll;">
						
						<!-- mallprlist_zone -->
						<div class="mallprlist_zone" id="basic_spec">
							<div class="exp_pack">
								<!-- 20180423 화장품 전성분 UI 개선 -->
								<div id="cosmetics" class="cosmetics" style="display:none;">
								</div>
								
								<div id="lpvip_fun_grade" class="lpvip_fun_grade" style="display:none;"></div>
								<dl class="offercon">
								
								<div id="mini_caution"></div>
									<dt><strong>요약설명</strong></dt>
									<dd>
										<table class="tbsum" cellpadding="0" cellspacing="0" id="spec_table">
											<colgroup>
												<col class="col1"><col class="col2">
											</colgroup>
											<tbody id="spec_tbody">
											</tbody>
										</table>
									</dd>
								</dl>
							</div>

							<!-- top 버튼-->
							<a class="btn_packtop" href="javascript:///" onclick="goTop(2);">TOP</a>

						</div>
						<!-- //mallprlist_zone -->

						<!-- mallprlist_zone -->
						<div class="mallprlist_zone not_attbu" id="book_spec" style="display:none"><!-- 상품설명 없을 때 class="not_attbu" 추가 -->
							<div class="exp_pack">
								<p class="array"></strong></p>
								<div class="nodata">
									<p>상품 상세설명은 쇼핑몰 또는 에누리 상품<br>상세페이지에서 확인하세요.</p>
									<a class="btn_sq" href="javascript:///">상세페이지</a>
								</div>
							</div>
						</div>
						<!-- //mallprlist_zone -->


						<!-- powerlink_zone -->
						<div class="powerlink_zone">
							<div class="top_power">
								<a class="title" href="http://saedu.naver.com/adbiz/searchad/intro.nhn" title="새창 페이지 이동" target="_new">파워링크 <em>AD</em></a>
								<a class="applyad" href="http://saedu.naver.com/adbiz/searchad/intro.nhn" target="_new">신청하기</a>
							</div>
							<ol class="power_list">
							</ol>
							
						</div>
						<!-- //powerlink_zone -->
						<div id="scrollView" style="clear:both;display:block;position:relative;height:60px;"></div>

					</div>
					<!-- //scroll_area -->
				</div>
				<!-- //cont_area : tab02 -->
				
				<!-- cont_area : tab03 -->
				<div class="cont_area tb03" id="tab03" style="display: none;">
					<!-- scroll_area -->
					<div class="scroll_area" id="scroll_area" style="height:650px;overflow-y:scroll;">
						
						<!-- mallprlist_zone -->
						<div class="mallprlist_zone">
							<div class="exp_pack">
								
								<!-- com_write -->
								<div class="com_write">
									<!-- 회원정보 레이어 -->
									<div id="membInfoLayer" class="smallbox membinfo">
										<h5>
											<strong>turby0426</strong>님
											<a href="javascript:///" class="btnclose">닫기</a>
										</h5>
											<ul class="list">
												<!--  <li><a href="/knowbox/MyList.jsp?menuno=2" target="_top">내가 쓴 글</a></li> -->
												<!-- <li><a href="javascript:fn_bbs_CmdJoin(3);">회원정보 변경</a></li> -->
												<li><a href="https://www.enuri.com/member/info/infoPwChk.jsp" target="_blank" >회원정보 변경</a></li>
												<li><a href="#" onclick="parent.logout();">로그아웃</a></li>
											</ul>
									</div>
									<!-- //회원정보 레이어 -->
									
									<div class="topspace">
										<strong class="tit">상품평쓰기</strong>
										<span class="logininfo">
											<a href="javascript:///" class="login" id="btn_login">로그인</a>
										</span>
									</div>
									<textarea cols="60" rows="5" id="gbContent" name="contents" placeholder="상품평을 작성해보세요."></textarea>
									<p class="ta_center"><a class="btn_register" id="gbBtnWrite" href="javascript:///">등록</a></p>
								</div>
								<!-- //com_write -->
	
								<!-- com_list -->
								<div class="com_list" id="com_list">
									
									<!-- 게시글 삭제 레이어 -->
									<div id="boardDelLayer" class="smallbox boarddel">
										<h5>
											비밀번호 입력 후 삭제해주세요
											<a href="javascript:///" class="btnclose delPassClose" id="bbs_delPassClose">닫기</a>
										</h5>
										<div class="inner">
											<p class="pw">비밀번호</p>
											<p>
												<input type="hidden" id="del_modelno" name="del_modelno" value="" />
												<input type="hidden" id="del_no" name="del_no" value="" />
												<input type="password" id="del_pass" name="del_pass" />
												<a href="javascript:;" class="btn_dis del" id="goodsBbsDel">삭제</a>
											</p>
										</div>
									</div>
									<!-- //게시글 삭제 레이어 -->
									
									<ul>
									</ul>
	
									<div class="nocom" id="bbs_nocom" style="display:none">등록된 상품평이 없습니다.</div>
	
								</div>
								<!-- //com_list -->
	
							</div>
							<a class="list_more bt" id="bbs_list_more" href="javascript:///" style="display:none"><span class="btn_more">더보기</span></a>
	
							<!-- top 버튼-->
							<a class="btn_packtop" href="javascript:///" onclick="goTop(3);">TOP</a>
	
						</div>
						<!-- //mallprlist_zone -->
	
						<!-- powerlink_zone -->
						<div class="powerlink_zone">
							<div class="top_power">
								<a class="title" href="http://saedu.naver.com/adbiz/searchad/intro.nhn" title="새창 페이지 이동" target="_new">파워링크 <em>AD</em></a>
								<a class="applyad" href="http://saedu.naver.com/adbiz/searchad/intro.nhn" target="_new">신청하기</a>
							</div>
							<ol class="power_list">
							</ol>
						</div>
						<!-- //powerlink_zone -->
						<div id="scrollView" style="clear:both;display:block;position:relative;height:60px;"></div>
	
					</div>
					<!-- //scroll_area -->
				</div>
				<!-- //cont_area : tab03 -->
	
			</div>
	
	</div>
	<!-- //minivip_wrap -->
</div>
<script>
var mvShowModelno = "<%= mvShowModelno %>";
var miniVipTab = <%= miniVipTab %>;
var strPlkeyword = "<%=strPlKeyword%>";
var mini_sUserId = "<%=strViewID%>";
var mini_sTmpUserId = "<%=mini_TMPUSER_ID%>";

var mini_SNSTYPE = "<%=mini_SNSTYPE%>";
</script>
<script src="/wide/script/product/IncMiniDetail.js?v=20210610"></script>