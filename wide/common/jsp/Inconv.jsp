<%@ include file="/lsv2016/include/IncAjaxHeader.jsp"%>
<%@ page import="com.enuri.bean.main.Goods_Proc"%>
<%@ page import="com.enuri.bean.main.Goods_Data"%>
<%@ page import="com.enuri.bean.main.Shoplist_Proc"%>
<%@ page import="com.enuri.bean.lsv2016.Goods_Search_Lsv_Proc"%>
<jsp:useBean id="Goods_Proc" class="com.enuri.bean.main.Goods_Proc" scope="page" />
<jsp:useBean id="Shoplist_Proc" class="com.enuri.bean.main.Shoplist_Proc" scope="page" />
<%@ include file="/include/IncGroupTool_2010.jsp"%>
<%
	String strType = ConfigManager.RequestStr(request, "type", "");
	String strConvOrgCate = ConfigManager.RequestStr(request, "cate", "");
	String strIsDic = ConfigManager.RequestStr(request, "isdic", "");
	String strKbno = ConfigManager.RequestStr(request, "kbno", "0");
	String strTitle = ConfigManager.RequestStr(request, "title", "");
	String strModelNo = ConfigManager.RequestStr(request, "modelno", "0");
	String strShopCode = ConfigManager.RequestStr(request, "shop_code", "");
	String strPl_no = ConfigManager.RequestStr(request, "pl_no", "0");
	long lPlNo = Long.parseLong(strPl_no);
	String strTitle2 = "";
	
	int nModelno = ChkNull.chkInt(strModelNo);
	Goods_Data goods_data = null;

	HashMap<Integer, String> opationMap = new HashMap<Integer, String>();
	
	if(strType.equals("5")){
		strType = "1";
	}

	if (nModelno > 0) {
		Goods_Search_Lsv_Proc goods_Search_Lsv_Proc = new Goods_Search_Lsv_Proc();
		goods_data = goods_Search_Lsv_Proc.Goods_One(nModelno,0);
		
		String strCaCode = goods_data.getCa_code();
		String strModenm = goods_data.getModelnm();
		String strFactory = goods_data.getFactory();
		String strBrand = goods_data.getBrand();
		
		strModenm = ReplaceStr.replace(strModenm,"\"","&quot");
		strModenm = ReplaceStr.replace(strModenm,"[일반]","");
		strModenm = ReplaceStr.replace(strModenm,"["," [");
        
		strTitle2 = getModel_FBN(strCaCode,strModenm,strFactory,strBrand)[1] + " " + getModel_FBN(strCaCode,strModenm,strFactory,strBrand)[2] + " " + getModel_FBN(strCaCode,strModenm,strFactory,strBrand)[0];
	}
	
	if (strType.equals("1")) {		/* LP > 우측 윙 영역 */ 
		strTitle = "상품목록 전반";
		
		if (strConvOrgCate.length() >= 2 ) {
			strTitle2 = Category_Proc.getData_Name(strConvOrgCate.substring(0,2), 1);
		}

		if (strConvOrgCate.length() >= 4 ) {
			strTitle2 += " > " + Category_Proc.getData_Name(strConvOrgCate.substring(0,4), 2);
		}
		
		if (strConvOrgCate.length() >= 6 ) {
			strTitle2 += " > " + Category_Proc.getData_Name(strConvOrgCate.substring(0,6), 3);
		}
	}else if(strType.equals("2")){	/* LP > 모델 영역 */
		strTitle = "상품오류 신고";
		strTitle2 = goods_data.getModelnm();
		
		opationMap.put(10, "잘못된 가격정보,0802");
		opationMap.put(6, "잘못된 제조사/브랜드 정보,0500");
		opationMap.put(5, "잘못된 상품정보/이미지,1000");
		opationMap.put(7, "잘못된 카테고리,0100");
		opationMap.put(29, "기타,1100");
	}else if(strType.equals("3")){	/* VIP_기본정보 영역 */
		strTitle = "상품오류 신고";
		strTitle2 = goods_data.getModelnm();
		
		opationMap.put(10, "잘못된 가격정보,0802");
		opationMap.put(6, "잘못된 제조사/브랜드 정보,0500");
		opationMap.put(5, "잘못된 상품정보/이미지,1000");
		//opationMap.put(4, "페이지오류(이미지 매칭 /기능오류 등),0900");
		opationMap.put(7, "잘못된 카테고리,0100");
		opationMap.put(29, "기타,1100");
	}else if(strType.equals("4")){	/* VIP_가격비교 영역 */
		int iShopCode = Integer.parseInt(strShopCode);
		String strShopName = Shoplist_Proc.getShopname(iShopCode);
		
		strTitle = "쇼핑몰/상품정보";
		strTitle2 = goods_data.getModelnm() + "<br>" + strShopName;

		opationMap.put(8, "잘못된 상품(다른상품),0803");
		opationMap.put(9, "쇼핑몰 접속불가/다른 쇼핑몰,0800");
		opationMap.put(10, "잘못된 가격정보,0802");
		opationMap.put(11, "잘못된 배송비/혜택,0805");
		opationMap.put(12, "품절/재고없음,0801");
		opationMap.put(13, "추가비용/현금결제 요구,0804");
		opationMap.put(29, "기타,1100");
	}
	
	
%>
	<div class="lay-singo lay-comm" id="divConvLayer<%=strType%>">
	    <div class="lay-comm--head">
	        <strong class="lay-comm__tit">불편 오류 신고</strong>
	    </div>
	    <div class="lay-comm--body">
	        <div class="lay-comm--inner">
	
	            <div class="error-report">
	                <dl class="error-report--target">
	                    <dt>목록 오류 신고</dt>
	                    <dd>
	                        <div class="error-report__box">
	                            <%=strTitle2 %>
	                        </div>
	                    </dd>
	                </dl>
	                <%
						if (!"1".equals(strType)){
					%>
	                <dl class="error-report--item">
	                    <dt>신고항목</dt>
	                    <dd>
	                        <ul class="list-form--radio">
	                        <%
							Iterator<Integer> oIterator = opationMap.keySet().iterator();
							while (oIterator.hasNext()) {
							    Integer key = oIterator.next();
							    String[] strConv = (opationMap.get(key)).split(",");
							%>
	                            <li>
	                            	<input type="hidden" id="ep<%=key%>" name="ep" value="<%=strConv[1]%>" />
	                                <input type="radio" id="epNew<%=key%>" name="epNew" class="input--radio-item" value="<%=key%>"><label for="epNew<%=key%>"><%=strConv[0]%></label>
	                            </li>
	                        <%
							}
							%>
	                        </ul>
	                    </dd>
	                </dl>
	                <%
						} else {
					%>
							<input type="hidden" id="ep" name="ep" value="3400" /> 
					<%
						}
					%>
	                <dl class="error-report--content">
	                    <dt>신고내용</dt>
	                    <dd>
	                        <textarea class="error-report__box" name="inconv_txt" id="inconv_txt" cols="30" rows="5" placeholder="항목에 없거나 추가하실 내용을 적어주세요.&#13;&#10;신고내용을 상세히 작성해주시면 담당자가 더욱 빠르게 &#13;&#10;처리할 수 있습니다."></textarea>
	                    </dd>
	                </dl>
	                <dl class="error-report--feedback">
	                    <dt>답변알림
	                        <input type="checkbox" id="chkEmail" name="chkEmail" class="input--checkbox-item"><label for="chkEmail">처리결과 받기</label>
	                    </dt>
	                    <dd>
	                        <input type="text" id="inconv_email" name="inconv_email" class="error-report__box" placeholder="이메일 주소를 입력해 주세요">
	                    </dd>
	                </dl>                
	            </div>
	
	            <div class="lay-comm__btn-group">
	                <button type="button" class="lay-comm__btn lay-btn--md epClose">취소</button>
	                <button type="button" class="lay-comm__btn lay-btn--md lay-btn--color--blue end">완료</button>
	            </div>
	        </div>
	    </div>
	    <!-- 버튼 : 레이어 닫기 -->
	    <button class="lay-comm__btn--close comm__sprite" onclick="$(this).parent().hide()">레이어 닫기</button>
	    <!-- // -->
	</div>
	<script>
		var strShopCode = "<%=strShopCode%>";
		var lPlNo = <%=lPlNo%>;
		
		$(document).ready(function() {
			var convLen = $(".conv_layer").length;

			$(".conv_layer").each(function() {
				if($(this).attr("id") != "divConvLayer<%=strType%>") {
					$(this).remove();	
				}
			});
		});
		
		$(".epClose").click(function() {
			$(".lay-comm--body").remove();
			$("#div_inconv").hide();
		});
		
		var ischeck = true;
	
		$(".lay-comm__btn-group .end").click(function(){
			if(ischeck){
				noticeInconvenionce('<%=strConvOrgCate%>',<%=strKbno%>,<%=strModelNo.trim().length() > 0 ? strModelNo: "''"%>,<%=strType%>);
			}
		})
		
		$(".radEpCh").click(function() {
			$(".radEpCh").removeClass("chk");
			$(".radEpCh").addClass("unchk");
			
			$(this).removeClass("unchk");
			$(this).addClass("chk");

			$(this).find("input:radio").prop("checked", true);
		});
		
		$(".chkEpMail").click(function() {
			if ($(this).hasClass("unchk")) {
				$(this).removeClass("unchk");
				$(this).addClass("chk");
				$("#chkEmail").prop("checked", true);
			} else {
				$(this).removeClass("chk");
				$(this).addClass("unchk");
				$("#chkEmail").prop("checked", false);
			}
		});
		
		function noticeInconvenionce(cate,kbno,modelno,errType){
			
			var url = "/include/layer/InsertInconvenience.jsp";
			/*var param = "cate="+cate+"&inconv_txt="+encodeURIComponent($("#inconv_txt").val().trim())+"<BR>"+navigator.userAgent+"<BR>"+getOSInfoStr();*/
			var param = "cate="+cate+"&inconv_txt="+encodeURIComponent($("#inconv_txt").val().trim());
			param += "&http_header=" + navigator.userAgent+"<BR>"+getOSInfoStr();
			
			if (typeof(kbno) != "undefined"){
				param += "&kbno="+kbno;
			}
			
			if (typeof(modelno) != "undefined"){
				param += "&modelno="+modelno;
			}

			if ($("#inconv_email").val().trim().length != 0){
				param += "&inconv_email="+$("#inconv_email").val();
			}
			
			var strEp_ch_new = "";
			
			if ($(':radio[name="epNew"]').length > 0) {
				if ($(':radio[name="epNew"]:checked').val()) {
					strEp_ch_new = $(':radio[name="epNew"]:checked').val();
				}
			} else {
				strEp_ch_new = "14";
			}
			
			if (strEp_ch_new != "") {
				param += "&ep_ch_new="+strEp_ch_new;
			} else {
				alert("신고항목을 선택해주세요");
				$("radio[name=epNew]").eq(0).focus();
				return;
			}
			
			var strEp = "3400"; 
				
			if (strEp_ch_new != "14") {
				strEp = $("#ep" + strEp_ch_new).val();
			} else {
				if ($("#inconv_txt").val().trim().length == 0 ){
					alert("오류내용을 입력해 주십시오.");
					$("#inconv_txt").focus();
					return;
				}
				if ($("#inconv_txt").val().trim().korlen() > 1000){
					alert("500자 이상 입력하실수 없습니다.")
					$("#inconv_txt").focus();
					return;
				}
			}
			ischeck = false;
			if (strEp != ""){ 
				//param += "&ep_ch=" + strEp.substring(2,4);
				param += "&epclass=" + strEp.substring(0,2);
			}
			
			param += "&ep_device=1&ep_site=1";
			
			if (strShopCode != "") {
				param += "&shop_code=" + strShopCode;
			}
			
			if (lPlNo > 0) {
				param += "&pl_no=" + lPlNo;
			}

			// 완료 클릭 로그 넣기
			// LP, SRP에서만 동작함
			if(errType==2) {
				insertLogLSV(14306);
			}

			$.ajax({
				url : url, 
				data : param, 
				dataType : "text", 
				type : "post",
				success : function(result){
					if(result.indexOf("ERROR_CNT_OVER") >= 0){
			        	alert("일일 신고 제한 건수인 20 건을 초과했습니다.\n내일 다시 신고 주시기 바랍니다.\n문의: (02)6354-3601(내선:206)");
			        }else{
			        	alert(result);
			        }
					$(".lay-comm--body").remove();
					$("#div_inconv").hide();
				},
				complete : function(){
					ischeck = true;					
				},
				error: function(request,status,error){
					//alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		      	}
			});
		}
		
		function getOSInfoStr(){
			var ua = navigator.userAgent;
			if(ua.indexOf("NT 6.0") != -1) return "Windows Vista/Server 2008";
			else if(ua.indexOf("NT 5.2") != -1) return "Windows Server 2003";
			else if(ua.indexOf("NT 5.1") != -1) return "Windows XP";
			else if(ua.indexOf("NT 5.0") != -1) return "Windows 2000";
			else if(ua.indexOf("NT") != -1) return "Windows NT";
			else if(ua.indexOf("9x 4.90") != -1) return "Windows Me";
			else if(ua.indexOf("98") != -1) return "Windows 98";
			else if(ua.indexOf("95") != -1) return "Windows 95";
			else if(ua.indexOf("Win16") != -1) return "Windows 3.x";
			else if(ua.indexOf("Windows") != -1) return "Windows";
			else if(ua.indexOf("Linux") != -1) return "Linux";
			else if(ua.indexOf("Macintosh") != -1) return "Macintosh";
			else return "";
		}
	</script>

