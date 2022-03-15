/*
*
* url : 링크 url
* total : 전체 글수
* scale : 한페이지에 보여질 글수
* pgScale : 보여질 페이지 수
* page : 현재 페이지 번호(1번 부터 시작됨)
* gryStr : Query String
* 사용 예제  
* <script language="JavaScript" src="/common/js/pager.js"></script>
* <td id='Pager'>&nbsp;</td> 출력되는 위치
* <script language="JavaScript">
* <--
*	firstImg = "<img src='./images/firstImg.gif' border=0>" 처음 이미지(값이 없으면 '처음')
*	endImg = "<img src='./images/endImg.gif' border=0>" 끝 이미지(값이 없으면 '끝')
*	prevImg = "<img src='./images/prevImg.gif' border=0>" 이전 이미지(값이 없으면 '이전')
*	nextImg = "<img src='./images/nextImg.gif' border=0>" 다음 이미지(값이 없으면 '다음')
*	pager('list.jsp', 46, 10, 10, 1, 'title=test&content=test');
* //-->
* </script>
*
*/

var firstImg = "처음";
var endImg = "끝";
var prevImg = "이전";
var nextImg = "다음";

function pager(url, total, scale, pgScale, page, qryStr) 
{
	var pgStr = "";
	var forvar = 0;
	var totalPg = 0;
	var pgClus = 0;
	
	var i=0;
	var next=0;

	if(total > scale) {
		forvar = Math.ceil(total / scale);
		totalPg = forvar;

		//shows till pageCount if page number is greater than pageCount
		if(forvar > pgScale) {
			forvar=pgScale;
		};

		pgClus = pgScale * Math.floor((page - 1) / pgScale);

		//first page
		if(pgClus > 0) {
			pgStr += "<a href='";
			pgStr += url + "?pg=1" + qryStr;
			pgStr += "'>" + firstImg + "</a>&nbsp;";
		} else {
			//pgStr += firstImg + "&nbsp;";
		};

		//shows previous page link if first page is passed
		if(page > (forvar)) {
			pgStr += "<a href='";
			pgStr += url+"?pg=" + pgClus + qryStr;
			pgStr += "'>" + prevImg + "</a>&nbsp;";
		}
		/*else {
			pgStr += "&nbsp;";
		};*/

		pgStr+="&nbsp;";

		for(i = 1 + pgClus; i <= forvar + pgClus ; i++) {
			if(i <= totalPg) {
				if(i==page) {
					pgStr += "<b><font size=2>["+i+"]</font></b>";
				} else {
					pgStr += "<a href='";
					pgStr += url+"?pg=" + i + qryStr;
					pgStr += "'>[" + i + "]</a>";
				};
				if(i < (forvar + pgClus)) {
					pgStr += "&nbsp;";
				};
			};
		};
		pgStr += "&nbsp;";

		//shows next page if exists
		if(totalPg > forvar + pgClus) {
			next = forvar + pgClus + 1;
			pgStr += "&nbsp;<a href='";
			pgStr += url + "?pg=" + next + qryStr;
			pgStr += "'>" + nextImg + "</a>";
		}
		/*else {
			pgStr += "&nbsp;" + nextImg;
		};*/

		//last page
		if((forvar + pgClus) < totalPg) {
			pgStr += "&nbsp;<a href='";
			pgStr += url + "?pg=" + totalPg + qryStr;
			pgStr += "'>" +  endImg + "</a>";
		} else {
			//pgStr += "&nbsp;" + endImg;
		};
	} else if(total > 0 && total <= scale) {
		pgStr += "<b><font size=2>[1]</font></b>";
	};

	document.getElementById("Pager").innerHTML=pgStr;
};
