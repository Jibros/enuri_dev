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
        html += "<div class='pagingMain'>";
        
        for(i=this.nStartPage; i<=this.nEndPage; i++){
            html += "<span " + (nCurrentPage == i ? "class='on'" : "") + ">" + i + "</span>";
        }

        html += "<select id='pagingNaviSel'>";
        
        for(i=0;i<this.nBlockGrpSize;i++){
            html += "<option " + (this.nCurrentGrp-1 == i ? "selected" : "") + " value='" + (1+(i*this.nBlockSize)).toString() + "'>" + (1+(i*this.nBlockSize)).toString() + "~" + (this.nBlockGrpSize-1 == i ? this.nTotalPageSize : nBlockSize + (i*this.nBlockSize)).toString() + "</option>";
        }
        
        html += "</select>";
        html += "</div>";
        document.getElementById(target).innerHTML = html;   
        
        var obj = document.getElementById(target).getElementsByTagName('div')[0];
        
        for(i=0;i<obj.getElementsByTagName('span').length;i++){
            obj.getElementsByTagName('span')[i].onclick = function(){
                eval(fName + '(' + this.innerHTML +');');

                for(j=0;j<obj.getElementsByTagName("span").length;j++){
                    obj.getElementsByTagName("span")[j].className = "";
                }
                
                this.className = "on";
            }
        }
        
        var s = document.getElementById(target).getElementsByTagName('select')[0];
        
        s.onchange = function(){
            eval(fName + '(' + this.options[this.selectedIndex].value +');');
        }
    }
};