function fn_paging(ulNm, pageNum, pageSize, pageCnt) {
	var pHtml = "";

	var startPage = parseInt(pageNum / 10) * 10;
	var totalPage = (pageCnt / pageSize);
	var endPage = 0;

	if (pageNum > 0 && parseInt(pageNum % 10) == 0) {
		startPage = startPage - 10;
	}
	
	pHtml += "<button class=\"paging__btn--prev";if (pageNum <= 10) { pHtml += " is--disabled";}pHtml += "\"><a href=\"javascript:;\" class=\"ico-paging-prev comm__sprite\">이전</a></button>";

	if (totalPage > (startPage + 10)) {
		endPage = (startPage + 10);
	} else {
		endPage = totalPage;
	}

	for ( i = startPage; i < endPage; i++ ) {
		if (pageNum == (i+1)) {
			pHtml += "<a href=\"javascript:;\" class=\"paging__item is--on\">" + (i+1) + "</a>";	
		} else {
			pHtml += "<a href=\"javascript:;\" class=\"paging__item\">" + (i+1) + "</a>";
		}
	}

	pHtml += "<button class=\"paging__btn--next";if (totalPage <= (startPage + 10)) { pHtml += " is--disabled";}pHtml += "\"><a href=\"javascript:;\" class=\"ico-paging-next comm__sprite\">다음</a></button>";

	$(ulNm).show();
	$(ulNm).html(pHtml);
}