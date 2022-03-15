<%
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
<!-- [LP/SRP] LP 우측 컨텐츠 -->
<div class="list-body-side">

	<!-- [LP/SRP] 미니VIP -->
	<div class="lay-minvip lay-comm"  id="miniVIP_AREA" style="display:none;">
    </div>
      <!-- // -->

      <!-- [LP/SRP] 우측 컨텐츠 Wrapper -->
      <div class="side__inner">
      	  <div class="side__ad_brand border-box" style="display:none;"></div>
      	  <!-- [SRP] HOT 키워드 -->
          <div class="hot-keyword" id="searchIngiKeywrdDiv" style="display:none;">
              <div class="hot-keyword__tit"><em>HOT</em> 키워드</div>
              <ul class="hot-keyword__list">
                  <li class="is--on">
                      <a href="#" class="hot-keyword__tab" onclick="insertLogLSV(14858);">급상승</a>
                      <!-- 급상승리스트 -->
                      <ol class="hot-keyword__list--hit">
                      </ol>
                  </li>
                  <li>
                      <a href="#" class="hot-keyword__tab" onclick="insertLogLSV(14860);">인기</a>
                      <!-- 인기리스트 -->
                      <ol class="hot-keyword__list--pop">
                      </ol>
                  </li>
              </ul>
          </div>
          <!-- // -->

          <!-- [LP/SRP] 우측 컨텐츠형 광고 -->
          <!-- 기존과 마크업은 동일하나 클래스명 전부 교체 -->
          <div class="knowcom-box" style="display:none;">
              <div class="knowcom-box--head">
                  트렌드를 한번에
                  <!-- 카테고리명 노출 / 글자수 제한 없음, 줄바꿈 노출-->
                  <span class="tx--cate"></span>
              </div>
              <div class="knowcom-box--body">
                  <!-- 뉴스 -->
                  <div class="knowcom-group wing_knowcom--group group--news">
                      <div class="knowcom-group--head">뉴스
                          <div class="knowcom-group__btn">
                              <button class="knowcom-group__btn--prev" onclick="moveButton('group--news','prev');">이전</button>
                              <button class="knowcom-group__btn--next" onclick="moveButton('group--news','next');">다음</button>
                          </div>
                      </div>
                      <div class="knowcom-group--body">
                          <!-- 뉴스 > 컨텐츠 : 리스트형 5개 고정-->
                          <ul class="knowcom-group__list">
                          </ul>
                      </div>
                      <div class="knowcom-group--body" style="display:none;">
                          <!-- 뉴스 > 컨텐츠 : 리스트형 5개 고정-->
                          <ul class="knowcom-group__list">
                          </ul>
                      </div>
                      <div class="knowcom-group--body" style="display:none;">
                          <!-- 뉴스 > 컨텐츠 : 리스트형 5개 고정-->
                          <ul class="knowcom-group__list">
                          </ul>
                      </div>					
                  </div>
                  <!-- 구매가이드 -->
                  <div class="knowcom-box--group wing_knowcom--group group--bguide">
                      <div class="knowcom-group--head">구매가이드
                          <div class="knowcom-group__btn">
                              <button class="knowcom-group__btn--prev" onclick="moveButton('group--bguide','prev');">이전</button>
                              <button class="knowcom-group__btn--next" onclick="moveButton('group--bguide','next');">다음</button>
                          </div>
                      </div>
                      <div class="knowcom-group--body">
                          <!-- 구매가이드 > 컨텐츠 : 썸네일형 1개 고정-->
                          <a href="javascript:void(0);" class="knwocom-group__thum">
                          </a>
                          <!-- 구매가이드 > 컨텐츠 : 리스트형 2개 고정-->
                          <ul class="knowcom-group__list">
                          </ul>
                      </div>	
                      <div class="knowcom-group--body" style="display:none;">
                          <!-- 구매가이드 > 컨텐츠 : 썸네일형 1개 고정-->
                          <a href="javascript:void(0);" class="knwocom-group__thum">
                          </a>
                          <!-- 구매가이드 > 컨텐츠 : 리스트형 2개 고정-->
                          <ul class="knowcom-group__list">
                          </ul>
                      </div>
                      <div class="knowcom-group--body" style="display:none;">
                          <!-- 구매가이드 > 컨텐츠 : 썸네일형 1개 고정-->
                          <a href="javascript:void(0);" class="knwocom-group__thum">
                          </a>
                          <!-- 구매가이드 > 컨텐츠 : 리스트형 2개 고정-->
                          <ul class="knowcom-group__list">
                          </ul>
                      </div>
                      				
                  </div>
                  <!-- 리뷰 -->
                  <div class="knowcom-box--group wing_knowcom--group group--review">
                      <div class="knowcom-group--head">리뷰
                          <div class="knowcom-group__btn">
                              <button class="knowcom-group__btn--prev" onclick="moveButton('group--review','prev');">이전</button>
                              <button class="knowcom-group__btn--next" onclick="moveButton('group--review','next');">다음</button>
                          </div>
                      </div>
                      <div class="knowcom-group--body">
                          <!-- 리뷰 > 컨텐츠 : 썸네일형 1개 고정-->
                          <a href="javascript:void(0);" class="knwocom-group__thum">
                          </a>
                          <!-- 구매가이드 > 컨텐츠 : 리스트형 2개 고정-->
                          <ul class="knowcom-group__list">
                          </ul>
                      </div>	
                      <div class="knowcom-group--body" style="display:none;">
                          <!-- 리뷰 > 컨텐츠 : 썸네일형 1개 고정-->
                          <a href="javascript:void(0);" class="knwocom-group__thum">
                          </a>
                          <!-- 구매가이드 > 컨텐츠 : 리스트형 2개 고정-->
                          <ul class="knowcom-group__list">
                          </ul>
                      </div>
                      <div class="knowcom-group--body" style="display:none;">
                          <!-- 리뷰 > 컨텐츠 : 썸네일형 1개 고정-->
                          <a href="javascript:void(0);" class="knwocom-group__thum">
                          </a>
                          <!-- 구매가이드 > 컨텐츠 : 리스트형 2개 고정-->
                          <ul class="knowcom-group__list">
                          </ul>
                      </div>				
                  </div>
              </div>
          </div>
          <!-- // -->

      </div>
      <!-- // -->
  </div>
  <script type="text/javascript" src="/wide/include/js/IncListRightContent.js?v=20210412"></script>
  <script>
  //미니vip ID
  var mini_sUserId = "<%=strViewID%>";
  var mini_SNSTYPE = "<%=mini_SNSTYPE%>";
</script>