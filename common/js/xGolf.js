var xGolfItemRoller;

$(document).ready(function(){
	loadXGolf();
});

function loadXGolf(){
	//골프라운딩 시작
	function XGolfItem(jsonGoodsList){
		this.jsonGoodsList 	= jsonGoodsList;
		this._currPage 		= 1;
		this._totPage 		= jsonGoodsList.length;

		this.setCurrPage = function(_currPage){this._currPage = _currPage;}
		this.getCurrPage = function(){ return this._currPage;}
		this.setTotPage  = function(_totPage){this._totPage = _totPage;}
		this.getTotPage  = function(){ return this._totPage;}
		this.getList  	 = function(){ return this.jsonGoodsList;}
	}

	var xGolfItem = new Array();
	var _currSection = 0;
	var _totSection;

    var loadUrl = "/main/main1003/ajax/getSohoStyle_json.jsp";
    var arrParam = ['F'];
    
    var param = {
    		sohoType : arrParam.join(),
    		shopCode : 7728,
    		orderBy  : "ORDER BY RANK"
    }

    $.getJSON(loadUrl, param, function(data) {
    	for(i=0;i<arrParam.length;i++)
    		xGolfItem.push(new XGolfItem(data[arrParam[i]]));

    	_totSection  = xGolfItem.length;
    	_currSection = Math.floor(Math.random()*(_totSection-1));

    	xGolfItem[_currSection].setCurrPage(Math.floor(Math.random()*(xGolfItem[_currSection].getTotPage()-1))+1);
/*
    	$titleList = $("#divXgolf > .tab_list > ul > li");
    	$titleList.eq(_currSection).addClass('selected').siblings().removeClass('selected');

    	$titleList.each(function(idx,e){
    		$(this).click(function(){
    			$(this).addClass('selected').siblings().removeClass('selected');

    			switch(idx){
	    			case 0 : {insertLog(12490);break;}
	    			case 1 : {insertLog(12491);break;}
	    			case 2 : {insertLog(12492);break;}
	    			case 3 : {insertLog(12493);break;}
    			}
    			
    			_currSection = idx;

    			xGolfItem[_currSection].setCurrPage(1);

    			fnRenderSohoStylePage();
    		});
    	});*/
    	
    	$("#pop1").click(function(){
    		fnPageCalc('prev');
    	});

    	$("#pop2").click(function(){
    		fnPageCalc('next');
    	});
    	
    	sohoStyleItemRollerStarter();
    	
    	fnRenderSohoStylePage();
    });

    function sohoStyleItemRollerStarter(){
    	sohoStyleItemRollerStopper();

    	xGolfItemRoller = setInterval(function(){
    		fnPageCalc('next');
    	},5000);
    }

    function sohoStyleItemRollerStopper(){
    	clearInterval(xGolfItemRoller);
    }

    function fnRenderSohoStylePage(){
        	var data = xGolfItem[_currSection].jsonGoodsList[xGolfItem[_currSection].getCurrPage()-1];
        	var html = "";
        	
        	html += "    <a href=\"/view/golf.jsp?rtn_url=" + data["url"] + "\" title=\"" + data["item_name"] + "\" target=\"_blank\">";
        	html += "        <span class=\"thumb\">";
        	
        	if(parseInt(data["price_org"]) != parseInt(data["price"]) && parseInt(data["price_org"]) != 0 && parseInt(data["discount"]) != 0)
        		html += "            <strong class=\"flag\">" + (100-data["discount"]) + "%</strong>";
        	
        	html += "            <img src=\"http://storage.enuri.gscdn.com/main/soho/" + data["regdate"] + "/" + data["soho_no"] + ".jpg\" alt=\"\"/>";
        	html += "        </span>";
        	html += "        <div class=\"info\">";
        	html += "            <p class=\"type\">" + data["item_name"] + "</p>";
        	html += "            <div class=\"price\">";
        	
        	if(parseInt(data["price_org"]) != parseInt(data["price"]) && parseInt(data["price_org"]) != 0)
        		html += "                <p class=\"p1\"><em>" + numberFormat(data["price_org"]) + "</em>원</p>";
        	
        	html += "                <p class=\"p2\"><strong>" + numberFormat(data["price"]) + "</strong>원</p>";
        	html += "            </div>";
        	html += "        </div>";
        	html += "    </a>";

        	$("#xGold_banner_main").html(html);

    }

    function fnPageCalc(direction){
    	if(direction == 'prev'){
    		if(xGolfItem[_currSection].getCurrPage() - 1 == 0){
    			if(_currSection -1 < 0)
    				_currSection = --_totSection;
    			else
    				_currSection-=1;

/*    	    	$("#divXgolf > .tab_list > ul > li").eq(_currSection).addClass('selected').siblings().removeClass('selected');*/

    	    	xGolfItem[_currSection].setCurrPage(xGolfItem[_currSection].getTotPage());
    		} else {
    			xGolfItem[_currSection].setCurrPage(xGolfItem[_currSection].getCurrPage()-1)
    		}
    	} else if(direction == 'next'){
    		if(xGolfItem[_currSection].getCurrPage() + 1 > xGolfItem[_currSection].getTotPage()){
    			if(_currSection + 1 == _totSection)
    				_currSection = 0;
    			else
    				_currSection+=1;

    			xGolfItem[_currSection].setCurrPage(1);

    	    	/*$("#divXgolf > .tab_list > ul > li").eq(_currSection).addClass('selected').siblings().removeClass('selected');*/
    		}else{
    			xGolfItem[_currSection].setCurrPage(xGolfItem[_currSection].getCurrPage()+1);
    		}
    	}

    	fnRenderSohoStylePage();
    }
}

function numberFormat(num) {
    var pattern = /(-?[0-9]+)([0-9]{3})/;
    while(pattern.test(num)) {
        num = num.replace(pattern,"$1,$2");
    }
    return num;
}