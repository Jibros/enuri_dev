// nCurrentPage : 현재 페이지, nRecordSize : 한 페이지에 있는 레코드 수, nBlockSize : 블록 수
// nTotalRecordSize : 전체 레코드 수, target : 타겟 ID 값, fName : 네비게이션 숫자 클릭시 실행되는 함수 명
function paging(nCurrentPage , nRecordSize, nBlockSize, nTotalRecordSize , target,fName){
    this.nRecordSize      = nRecordSize ? nRecordSize : 8;    
    this.nBlockSize       = nBlockSize  ? nBlockSize  : 5;
    this.nCurrentPage     = nCurrentPage? nCurrentPage: 1; 
    this.nTotalRecordSize = nTotalRecordSize ? nTotalRecordSize : 100;           
    
    this.nTotalPageSize   = 0;
    this.nBlockGrpSize    = 0;
    this.nCurrentGrp      = 0;
    this.startPage        = 0;
    this.endPage          = 0;
    var tempTotalPageSize = 0;
    
    this.setPage = function(nCurrentPage){
        this.nCurrentPage = nCurrentPage;
    }
    
    this.calcPage = function(){
        this.nTotalPageSize =  Math.round(Math.ceil(this.nTotalRecordSize/this.nRecordSize));
        tempTotalPageSize = this.nTotalPageSize;
        
        this.nBlockGrpSize  =  Math.round(Math.ceil(this.nTotalRecordSize/(this.nRecordSize*this.nBlockSize)));
        this.nCurrentGrp    =  Math.round(Math.ceil(this.nCurrentPage/this.nBlockSize));
        
       if( this.nCurrentGrp == this.nBlockGrpSize ){
            this.nStartPage = (this.nCurrentGrp * this.nBlockSize) - (this.nBlockSize - 1);
            this.nEndPage   = this.nTotalPageSize;
       } else if(this.nCurrentGrp < this.nBlockGrpSize){
            this.nStartPage = (this.nCurrentGrp * this.nBlockSize) - (this.nBlockSize - 1);
            this.nEndPage   = this.nCurrentGrp * this.nBlockSize;
       }
    }
    
    this.getPaging = function(){
    	// #. navigation
        var html = "";
        html += "<ul class='paging' id='paging'>";
        html += "<li><a href='javascript:void(0);' id='first' class='btn fist'><em>맨 앞 페이지</em></a></li>";
        html += "<li><a href='javascript:void(0);' id='prev' class='btn prev'><em>앞 페이지</em></a></li>";
        
        for(i=this.nStartPage; i<=this.nEndPage; i++){
            html += "<li><a " + (nCurrentPage == i ? "class='selected'" : "") + ">" + i + "</a></li>";
        }
        
        html += "<li><a href='javascript:void(0);' id='next' class='btn next'><em>다음 페이지</em></a></li>";
        html += "<li><a href='javascript:void(0);' id='last' class='btn last'><em>맨 뒷 페이지</em></a></li>";
        html += "</ul>";
        document.getElementById(target).innerHTML = html;   
        var obj = document.getElementById(target); // ul object
        
        // #. navigation 클릭시
        for(i=0;i<obj.getElementsByTagName('li').length;i++) { 
            obj.getElementsByTagName('a')[i].onclick = function() {
            	
                var num_check=/^[0-9]*$/;
                if (num_check.test(this.innerHTML)) { // 숫자 클릭시
                	eval(fName + '(' + this.innerHTML +');');
                } else {   // '<<', '<', '>', '>>' 클릭시
                	console.log("tempTotalPageSize : " + tempTotalPageSize);
                	moveToEnd(this.id, nCurrentPage, tempTotalPageSize);
                }
            }
        }
    }
};

//'<<', '<', '>', '>>' 클릭시
function moveToEnd(id, nCurrentPage, nTotalPageSize) {
	if (id == "first") { // 맨 앞 페이지
		getEventList(1, 8);
	} else if (id == "prev" && nCurrentPage > 1) { // 앞 페이지
		getEventList(nCurrentPage - 1, 8);
	} else if (id == "next" && nCurrentPage < nTotalPageSize) { // 다음 페이지
		getEventList(nCurrentPage + 1, 8);
	} else if (id == "last") { // 맨 뒷 페이지
		getEventList(nTotalPageSize, 8);
	}
}

