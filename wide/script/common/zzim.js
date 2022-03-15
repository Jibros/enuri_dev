var zzimTimer;
function showLayZzim(obj,modelno,plno){
    clearTimeout(zzimTimer);
    var $layZzim = $(".lay-zzim");        
    var $this = $(obj);
    $layZzim.show();
    if ( !$(obj).hasClass("is--on") ){
        // 찜하기
        if(zzimInsert(modelno,plno)){
            $this.addClass("is--on");
            setTimeout(function(){
                $layZzim.removeClass("is--off").addClass("is--show").show();
            },1);
        }
    }else{
        // 찜해제
        if(zzimDelete(modelno,plno)){
            $this.removeClass("is--on");
            setTimeout(function(){
                $layZzim.addClass("is--off is--show").show();
            },1);
        }
    }
    // 2초후 자동 닫기    
    zzimTimer = setTimeout(function(){
        $layZzim.removeClass('is--show');
    },2000);
}

function zzimInsert(modelno, plno) {
    if (!islogin()){
        Cmd_Login('detailinputzzim');
    } else {
        var zzimYn = false;

        if(modelno == 0 && plno > 0) modelno = "P:"+modelno;

        $.ajax({
            type: "post",
            url: "/view/include/insertSaveGoodsProc.jsp",
            data: "modelnos=" + modelno,
            dataType: "json",
            async: false,
            success: function(result) {
                var varCount = parseInt(result.count);
                if (varCount > 0) {
                    zzimYn = true;
                    fn_banner_info('');
                }
            },
            error: function(request, status, error) {}
        });

        return zzimYn;
    }
}

function zzimDelete(modelno, plno) {
    if (!islogin()){
        Cmd_Login('detailinputzzim');
    }else{
        var zzimYn = false;

        if(modelno == 0 && plno > 0) modelno = "P:"+modelno;

        $.ajax({
            type: "post",
            url: "/lsv2016/ajax/deleteSaveGoodsProc.jsp",
            data: "modelnos=" + modelno + "&tbln=save",
            dataType: "json",
            async: false,
            success: function(result) {
                if (result.count > 0) {
                    zzimYn = true;
                    fn_banner_info('');
                }
            },
            error: function(request, status, error) {}
        });

        return zzimYn;
    }
}