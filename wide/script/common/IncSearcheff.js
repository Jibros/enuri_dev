
if (window.location.pathname == "/list.jsp"){

	if (param_cate != ""){
		var varData = "";
		varData = "ca_code=" + param_cate;
		if(Synonym_From=="search" && (Synonym_From_Keyword.length>0 || Synonym_Keyword.length>0)) {
			if(Synonym_From_Keyword.length>0) {
				varData += "&keyword=" + Synonym_From_Keyword;
			} else if(Synonym_Keyword.length>0) {
				varData += "&keyword=" + Synonym_Keyword;
			}
			varData += "&lp_type=K";
		} else {
			varData += "&lp_type=C";
		}
		varData += "&logType=1";
		$.ajax({
			type:"GET",
			url: "/lsv2016/include/insertSearchEff.jsp",
			data:varData
		});		
	}
}

function insertListSearchEffViewInsert(param){
	
	if (window.location.pathname != "/list.jsp") return;

	if (param_cate != ""){
		var varData = "";
		varData = "ca_code=" + param_cate;
		if (typeof(param.modelno) != "undefined" && param.modelno > 0){
			varData += "&modelno=" + param.modelno;
		}
		if (typeof(param.pl_no) != "undefined" && param.pl_no > 0){
			varData += "&pl_no=" + param.pl_no;
		}		
		if (typeof(param.view_type) != "undefined" ){
			varData += "&view_type=" + param.view_type;
		}
		if(Synonym_From=="search" && Synonym_From_Keyword.length>0) {
			varData += "&keyword=" + Synonym_From_Keyword;
			varData += "&lp_type=K";
		}else{
			varData += "&lp_type=C";
		}
		varData += "&logType=2";
		$.ajax({
			type:"GET",
			url: "/lsv2016/include/insertSearchEff.jsp",
			data:varData
		});		
	}	
}
/*상세검색 클릭현황 로그*/
function insertDetailAttLog_Wide(param){
	
	if (window.location.pathname != "/list.jsp") return;

	if (param_cate != ""){
		var varData = "";
		varData = "ca_code=" + param_cate;

		if(Synonym_From=="search" && Synonym_From_Keyword.length>0) {
			varData += "&keyword=" + Synonym_From_Keyword;
			varData += "&lp_type=K";
		}else{
			varData += "&lp_type=C";
		}
		
		// 상세검색 클릭
		if (typeof(param.attType) != "undefined"   && param.attType != ""){
			if (param.attType == "spec"){
				if (typeof(param.specno) != "undefined" && param.specno > 0){
					varData += "&attType=S";
					varData += "&specNo=" + param.specno;
				}				
			}else if(param.attType == "factory" || param.attType == "brand" || param.attType == "discount" || param.attType == "bbsscore"){
				if (typeof(param.fbName) != "undefined" && param.fbName != ""){
					if (param.attType == "factory"){
						varData += "&attType=F";
					}else if(param.attType == "brand"){
						varData += "&attType=B";
					}else if(param.attType == "discount"){
						varData += "&attType=D";
					}else if(param.attType == "bbsscore"){
						varData += "&attType=C";
					}
					varData += "&fbName=" + param.fbName; 
				}								
			}
			varData += "&logType=3";
		}
		
		// 상품클릭
		if (typeof(param.click) != "undefined" && param.click == "click"){
			
			// 모델상품
			if (typeof(param.modelno) != "undefined" && param.modelno > 0){
				varData += "&view_type=1";
				varData += "&modelno=" + param.modelno;
			}
			
			// 일반상품
			if (typeof(param.plno) != "undefined" && param.plno > 0){
				varData += "&view_type=2";
				varData += "&pl_no=" + param.plno;
			}
			
			varData += "&logType=2&from=enuri_PC&device_type=P";
			
			if(typeof(param.rank) != "undefined") {
				varData += "&rank="+param.rank;
			}  
		}
		
		if(varData.length>0) {
			$.ajax({
				type:"GET",
				url: "/lsv2016/include/insertSearchEff.jsp",
				data:varData
			});
		}
	}	
}

