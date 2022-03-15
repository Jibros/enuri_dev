var randomKeyword = new Ajax.Request("/search/getRandomSearchKeyword.jsp",{
		method:'get',onComplete:searchRandomKeyword
	}
);

function searchRandomKeyword(originalRequest){
	var arrRandomSearchKeyword = originalRequest.responseText.split(",");
	function showResult(searchResult){
		//showLog(searchResult.responseText)
	}
	for (var i=0;i<5;i++){
		var param = "keyword="+arrRandomSearchKeyword[i];
		var randomSearch = new Ajax.Request("/search_api",{
			method:'get',parameters:param,onComplete:showResult
		});
	}
}
