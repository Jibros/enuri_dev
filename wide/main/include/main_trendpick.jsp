<%
	int intRandNum_trendpickup = (int) (Math.random() * 10);
%>
<div class="trendpickup">
    <div class="trendpickup__inner">
        <div class="trendtabs">
            <h1 class="trendtabs__tit"><em>트렌드픽업</em></h1>
            <!-- 트렌드픽업 탭 이동 화살표 -->
            <div class="arrows arrows--wihte">
                <button type="button" class="arr arr-prev" id="shopmenu__btn_prev">이전</button>
                <button type="button" class="arr arr-next" id="shopmenu__btn_next">다음</button>
            </div>
            <div class="trendtabs__mask">
                <ul class="trendtabs__list" style="top:0;"> <!-- 45px 단위로 (-)해주세요 -->
                    <!-- 탭 활성화 : "trendtab-item is-on" -->
                    <%@ include file="/wide/main/ajax/wtrendList_s.jsp"%>
                </ul>
            </div>
        </div>
		<div class="trendpickup__container">
			<% if (intRandNum_trendpickup==0) { %>
				<%@ include file="/wide/main/ajax/wTrendHtml0.jsp"%>
			<% } else if (intRandNum_trendpickup==1) { %>
				<%@ include file="/wide/main/ajax/wTrendHtml1.jsp"%>
			<% } else if (intRandNum_trendpickup==2) { %>
				<%@ include file="/wide/main/ajax/wTrendHtml2.jsp"%>
			<% } else if (intRandNum_trendpickup==3) { %>
				<%@ include file="/wide/main/ajax/wTrendHtml3.jsp"%>
			<% } else if (intRandNum_trendpickup==4) { %>
				<%@ include file="/wide/main/ajax/wTrendHtml4.jsp"%>
			<% } else if (intRandNum_trendpickup==5) { %>
				<%@ include file="/wide/main/ajax/wTrendHtml5.jsp"%>
			<% } else if (intRandNum_trendpickup==6) { %>
				<%@ include file="/wide/main/ajax/wTrendHtml6.jsp"%>
			<% } else if (intRandNum_trendpickup==7) { %>
				<%@ include file="/wide/main/ajax/wTrendHtml7.jsp"%>
			<% } else if (intRandNum_trendpickup==8) { %>
				<%@ include file="/wide/main/ajax/wTrendHtml8.jsp"%>
			<% } else if (intRandNum_trendpickup==9) { %>
				<%@ include file="/wide/main/ajax/wTrendHtml9.jsp"%>
			<% } %>
		</div>
    </div>
</div>
<script>
	var intRandNum_trendpickup = "<%=intRandNum_trendpickup%>";
	$(".trendtab-item").removeClass("is-on");
	$(".trendtab-item").eq(intRandNum_trendpickup).addClass("is-on");
</script>