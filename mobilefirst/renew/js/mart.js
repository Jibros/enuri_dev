var json_list = null;

var arrGroup = new Array();
var arrGroupNum = new Array();  //random 시킬 배열 번호

function getMartGoodsLoading(){
	if(json_list == null){
		getJsonRandom();//shop 별 random	
	}
}
function getCateAndBanner(){
    //배너
    var json = martBannerAndCate.top;
    var martBannerCnt = 0;
    if(json.banner){
        var template = "";
        for(var i=0;i<json.banner.length;i++){
            if(getToday() >= json.banner[i].sdate && getToday() <= json.banner[i].edate){
                var mType = agentCheck();
                if( (mType == "I" && json.banner[i].ios == "Y") || 
                        (mType == "A" && json.banner[i].aos == "Y") ){
                    template += "<li class=\"swiper-slide\"><a href='javascript:///' onclick=\"goBLink('"+json.banner[i].link+"','"+json.banner[i].txt+"');\"><img src=\""+json.banner[i].img+"\" alt=\"\"  /></li>";
                    martBannerCnt++;
                }
            }
        }
        $("#martBanner").html(template);
        
        if(martBannerCnt > 1){
        	setTimeout(function(){
                //상단배너
        		var swiperMartBanner = new Swiper('#mart_bnr', {
                    pagination: '.pagination',
                    nextButton: '.btn_next',
                    prevButton: '.btn_prev',
                    paginationClickable: true,
                    spaceBetween: 30,
                    centeredSlides: true,
                    autoplay: 3500,
                    autoplayDisableOnInteraction: false,
                    loop: true,
                    lazyLoading: true
                });
                
            },500);
        }else{
        	$("#mart_bnr").find(".btn_prev.swbtn").remove();
        	$("#mart_bnr").find(".btn_next.swbtn").remove();
        }
        
    }
    //카테고리
    json = martBannerAndCate.icon;
    if(json.cateIcon){
        var template = "";
        for(var i=0;i<json.cateIcon.length;i++){
            var classOn = "";
            if(i == 0)              classOn = "on";
            template += "<li class=\"cate_li "+classOn+"\" data-cate='"+json.cateIcon[i].cateCode+"' data-excate='"+json.cateIcon[i].ex_cateCode+"' onClick=\"onList(this,'"+json.cateIcon[i].cateCode+"','"+json.cateIcon[i].ex_cateCode+"','"+json.cateIcon[i].txt+"',"+(i+1)+");\"><img src=\""+json.cateIcon[i].iconImg+"\"/><span>"+json.cateIcon[i].txt+"</span></li>";
        }
        $(".mart_cate").html(template);
    }
    
}
function getMartList(strCate,strExCate,strTxt){
    var totalCnt = 0;
    var template = "";
    //BEST 카테고리별 개수
    var cateNum = new Array();
    for(var m=0; m<$(".mart_cate").find("li").length; m++){
        cateNum[m] = 0;
    }
    for(var i=0; i<arrGroupNum.length; i++){    
        var goodsInfo = new Object();
        goodsInfo.goodsList = arrGroup[i];
        var jsonInfo = JSON.stringify(goodsInfo);
        var jsondata =  JSON.parse(jsonInfo);
        
        for(var l=0; l<arrGroupNum[i].length; l++){
            var goodArr = jsondata.goodsList[arrGroupNum[i][l]];

            //카테고리 검사
            var bCate = false;
            if(strCate == ""){//BEST
                //카테고리별 5개씩 충족되었을 시 break;
                var bNum = 0;
                var cateLen = $(".mart_cate").find("li").length;
                for(var m=0; m<cateLen; m++){
                    if(cateNum[m] >= 5){
                        bNum = bNum + 1;
                    }
                }
                if(bNum == cateLen-1){
                    break;
                }
                
                //카테고리별 5개씩 선정
                for(var m=0; m<cateLen; m++){
                    var cate = $(".mart_cate").find("li").eq(m).data("cate");
                    var exCate = $(".mart_cate").find("li").eq(m).data("excate");
                    if(cate != ""){
                        bCate = checkCate(goodArr,cate.toString(),exCate.toString());
                        if(bCate){
                            if(cateNum[m] < 5){
                                cateNum[m] = cateNum[m] + 1;
                            }else{
                                bCate = false;
                            }
                            break;
                        }
                    }
                }
            }else{
                bCate = checkCate(goodArr,strCate,strExCate);
            }
            
            if(bCate){
                var tmp = writeTemplate(goodArr);
                template = template + tmp;
                totalCnt = totalCnt + 1;
            }
        }
    }
    $(".mart_list").html(template);
    $(".mart_tit").html("<strong>"+strTxt+"</strong>"+numberWithCommas(totalCnt)+"개");
    zzimCheckSet();
    if(strCate == "")       randomBest();
}
//BEST random
function randomBest(){
    var len = $(".mart_list li").length;
    $(".mart_list").each(function(){
        var ul = $(this);
        var liArr = ul.children('li');
        liArr.sort(function() {
            var temp = parseInt(Math.random()*len);
            var temp1 = parseInt(Math.random()*len);
            return temp1-temp;
        }).appendTo(ul);
    });
}
//category 체크
function checkCate(goodArr,strCate,strExCate){
    var arrStrCate = strCate.split(',');
    var arrStrExCate = strExCate.split(',');
    
    var bCate = false;
    for(var m=0; m<arrStrCate.length; m++){
        //카테고리 검사
        var prodCate = goodArr.ca_code.substr(0,arrStrCate[m].length);
        if(arrStrCate[m] != "" && prodCate == arrStrCate[m]){
            bCate = true;
            //제외 카테고리 검사
            for(var n=0; n<arrStrExCate.length; n++){
                var prodExCate = goodArr.ca_code.substr(0,arrStrExCate[n].length);
                if(arrStrExCate[n] != "" && prodExCate == arrStrExCate[n]){
                    bCate = false;
                }
            }
            if(bCate){
                break;
            }
        }
    }
    return bCate;
}
 function getToday(){
   
        var date = new Date();
   
        var year  = date.getFullYear();
        var month = date.getMonth() + 1; // 0부터 시작하므로 1더함 더함
        var day   = date.getDate();
    
        if (("" + month).length == 1) { month = "0" + month; }
        if (("" + day).length   == 1) { day   = "0" + day;   }
        
        return   year+""+month+""+day;
}
function getJsonRandom(){
    
    var loadUrl = "/mobilefirst/http/json/allMart.json";
    
    $.ajax({
        url: loadUrl,
        dataType: 'json',
        success: function(data){
            
        	json_list = data; 
        	
            if(json_list.shoplist){
                /**************category별 제품 랜덤 ******************/
                //group max값 구하기
                var maxGroupNo = 1;
                for(var i=0; i<json_list.shoplist.length; i++){
                    if(json_list.shoplist[i].group >= maxGroupNo){
                        maxGroupNo = json_list.shoplist[i].group;
                    }
                }
                //max 배열 생성
                for(var i=0; i<maxGroupNo; i++){
                    arrGroup[i] = new Array();
                    arrGroupNum[i] = new Array();
                }
                for(var l=0; l<maxGroupNo; l++){
                    var num = 0;
                    for(var i=0; i<json_list.shoplist.length; i++){
                        if(json_list.shoplist[i].group == (l+1)){
                            var goodsList = eval("json_list['"+json_list.shoplist[i].shop+"'].goodsList");
                            if(goodsList){
                                var goodsListLen = eval("json_list['"+json_list.shoplist[i].shop+"'].goodsList.length");
                                for(var j=0; j<goodsListLen; j++){
                                    var goodArr = eval("json_list['"+json_list.shoplist[i].shop+"'].goodsList"+"["+j+"]");
                                    arrGroup[l].push(goodArr);
                                    arrGroupNum[l].push(num);
                                    num = num + 1;
                                }
                            }
                        }
                    }
                }
                for(var i=0; i<arrGroupNum.length; i++){                    arrGroupNum[i].shuffle();                }
                /**************category별 제품 랜덤 끝******************/
            }
            
            var firstCate = $(".mart_cate li:first").data("cate");
            var firstExCate = $(".mart_cate li:first").data("excate");
            var firstTxt = $(".mart_cate li:first span").html();
    
            getMartList(firstCate,firstExCate,firstTxt);
            swiperAll.onResize();
        }
    });
}
//category 클릭
function onList(doc,strCate,strExCate,strTxt,num){
    nowCate = num;
    ga('send', 'event', 'mf_mart', 'cate', 'cate_'+nowCate+"_"+strTxt);
    $(".cate_li").removeClass("on");
    $(doc).addClass("on");
    getMartList(strCate,strExCate,strTxt);
}
function goLinkBuy(url,scode,txt){
    
    var nowCate = $(".mart_cate li.on").index()+1;
    
    ga('send', 'event', 'mf_mart', 'buy', 'buy_'+scode+"_cate_"+nowCate+"_"+txt);
    location.href = url;
}
function goBLink(url,txt){
    ga('send', 'event', 'mf_mart', 'banner', 'banner_'+txt);
    location.href = url;
}
function writeTemplate(goodArr){
    var template = "";
    template += "<li>";
    template += "<a href='javascript:///' onClick=\"goLinkBuy('"+goodArr.url+"','"+goodArr.shopCode+"','"+goodArr.goodsnm+"');\">";
    template += "   <span class='thum'>";
    template += "   <img class='swiper-lazy' src=\""+goodArr.imgurl+"\" />";
    //template += "	<div class='swiper-lazy-preloader swiper-lazy-preloader-black'></div>";
    template += "   </span>";
    template += "   <div class=\"info\">";
    template += "       <span class=\"mall\">";
    template += "       <img src=\"http://imgenuri.enuri.gscdn.com/images/view/ls_logo/2013/Ap_logo_"+goodArr.shopCode+".png\" alt=\""+goodArr.shopName+"\" onerror=\"this.style.visibility='hidden';\" />";
    template += "       </span>";
    template += "       <strong>"+goodArr.goodsnm+"</strong>";
    template += "       <div class=\"price\">";
    
    if(goodArr.discount_rate)       template += "           <span class=\"sale\"><b>"+goodArr.discount_rate+"</b>%</span>";
    
    template += "           <span class=\"prc\">";
    if(goodArr.orgPrice && goodArr.orgPrice != ""){
        template += "       <del>"+numberWithCommas(goodArr.orgPrice)+"원</del>";
    }
    template += "           <b>"+numberWithCommas(goodArr.price)+"</b>원";
    template += "           </span>";
    template += "       </div>";
    //찜 
    template += "       <div class=\"zzimarea\" onclick=\"event.cancelBubble=true;\">";
    template += "           <button type=\"button\" class=\"heart\" onclick=\"zzimSet('"+goodArr.modelno+"' , '"+goodArr.pl_no+"' ,this , '"+goodArr.shopCode+"');\" id=\"P_"+goodArr.pl_no+"\">찜</button>";
    template += "       </div>";
    //찜끝
    template += "   </div>";
    template += "</a>";
    
    if(goodArr.pCnt || goodArr.option != ""){
        template += "<div class=\"option_area\">";
        if(goodArr.pCnt)            template += numberWithCommas(goodArr.pCnt)+"개 구매";
        //옵션 (ex:무료배송, 카드할인 ..)
        if(1==2 && goodArr.option != ""){
            var optionStr = goodArr.option.split(',');
            for(var k=0; k<optionStr.length; k++){
                template += "<em>"+optionStr[k]+"</em>";
            }
        }
        template += "</div>";
    }
    template += "</li>";
    return template;
}

Array.prototype.shuffle = function(){ 
    var num = this.length; 
    var temp, rnd; 
    var i; 
    for(i=0; i<num; i++) { 
        rnd = Math.floor(Math.random()*num); 
        temp = this[i]; 
        this[i] = this[rnd]; 
        this[rnd] = temp; 
    } 
}; 