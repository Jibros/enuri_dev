// nCurrentPage : 현재 페이지, nRecordSize : 한 페이지에 있는 레코드 수, nBlockSize : 블록 수
// nTotalRecordSize : 전체 레코드 수, target : 타겟 ID 값, fName : 네비게이션 숫자 클릭시 실행되는 함수 명
function paging(nCurrentPage , nRecordSize, nBlockSize, nTotalRecordSize , target,fName){
	this.nRecordSize      = nRecordSize ? nRecordSize : 10;    
    this.nBlockSize       = nBlockSize  ? nBlockSize  : 10;
    this.nCurrentPage     = nCurrentPage? nCurrentPage: 1; 
    this.nTotalRecordSize = nTotalRecordSize ? nTotalRecordSize : 100;           
    
    this.nTotalPageSize   = 0;
    this.nBlockGrpSize    = 0;
    this.nCurrentGrp      = 0;
    this.startPage        = 0;
    this.endPage          = 0;
    
    this.setPage = function(nCurrentPage){
        this.nCurrentPage = nCurrentPage;
    }
    
    this.calcPage = function(){
        this.nTotalPageSize =  Math.round(Math.ceil(this.nTotalRecordSize/this.nRecordSize));    
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
        var html = "";
        var prev = (1 < nCurrentPage) ? nCurrentPage - 1 : 1;
        var next = (nCurrentPage + 1 > Math.ceil(nTotalRecordSize / nRecordSize)) ? nCurrentPage : nCurrentPage + 1;
        
        html += "<ul class='list'>";
        
        if(nTotalRecordSize > nRecordSize){
        	html += "<li><a class='btn prev' num='" + prev + "'></a></li>";
        }
        
        for(i=this.nStartPage; i<=this.nEndPage; i++){
            html += "<li><a " + (nCurrentPage == i ? "class='selected'" : "") + " num='" + i + "'>" + i + "</a></li>";
        }
        
        if(nTotalRecordSize > nRecordSize){
        	html += "<li><a class='btn next' num='" + next + "'></a></li>";
        }
        
        html += "</ul>";
        document.getElementById(target).innerHTML = html;   
        
        var obj = document.getElementById(target).getElementsByTagName('ul')[0]; // ul object
        
        // #. navigation 클릭시
        for(i=0;i<obj.getElementsByTagName('li').length;i++){
            obj.getElementsByTagName('a')[i].onclick = function(){
                eval(fName + '(' + this.getAttribute('num') +');');

                for(j=0;j<obj.getElementsByTagName("li").length;j++){
                    obj.getElementsByTagName("li")[j].className = "";
                }
                
                this.className = "on";
            }
        }
    }
};