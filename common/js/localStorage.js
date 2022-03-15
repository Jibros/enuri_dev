function setLocalStorage(key, value){
    if(key.length > 0 && value.length > 0){
        var now = new Date();
        var date = getFormatDate(now);
        // var date = getFormatDate(new Date(now.getFullYear(), now.getMonth(), now.getDate() + 1));
        var goodsArr = [];
        var goodsObj = {};
        var recentCnt = 0;
        
        if(localStorage.getItem(key) !== null && localStorage.getItem(key).length > 0){
            var keys = [];

            goodsObj = JSON.parse(localStorage.getItem(key));
            keys = Object.keys(goodsObj);

            keys.forEach(function(v){
                var jsonArray = goodsObj[v];
                var jsonArrayNew = [];
                
                jsonArray.forEach(function(a){
                    if(recentCnt < 50){
                        recentCnt++;
                        if(value !== a) jsonArrayNew.push(a);
                    }
                });
                
                goodsObj[v] = jsonArrayNew;
            });
        }

        if(goodsObj[date] !== undefined) goodsArr = goodsObj[date];

        goodsArr.push(value);
        goodsObj[date] = goodsArr;

        console.log(goodsArr);
        console.log(goodsObj);
        console.log(JSON.stringify(goodsObj));

        localStorage.setItem(key,JSON.stringify(goodsObj));
    }
}

function removeLocalStorage(key,value){
    var vValueArray = new Array();
    var vObject = null;

    if(typeof key != "undefined"  && typeof value != "undefined"){
        if(localStorage.getItem(key) != null) {
            vValueArray = value.split(",");
            vObject = JSON.parse(localStorage.getItem(key)) // 날짜 : {[]} 들어있는거
            $.each(vObject,function(i,v){
                $.each(vValueArray,function(ii,vv){
                    if(v.indexOf(vv)>-1) v.splice(v.indexOf(vv), 1);
                });
            });
            localStorage.setItem(key,vObject.toString());
        }
    }
}

function getFormatDate(date){
    var year = date.getFullYear();
    var month = (1 + date.getMonth());
    var day = date.getDate();
    var hours = date.getHours();
    var minutes = date.getMinutes();

    month = month >= 10 ? month : '0' + month;
    day = day >= 10 ? day : '0' + day;
    hours = hours >= 10 ? hours : '0' + hours;
    minutes = minutes >= 10 ? minutes : '0' + minutes;

    return year.toString() + "." + month.toString() + "." + day.toString();
}