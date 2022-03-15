var alarmObject = {
    param : {},
    pagename : "",
    promise : function(type,n_no,m_no,r_no){
        (typeof type != "undefined" && type>0) ? this.param.type=type : delete this.param.type;
        (typeof n_no != "undefined" && n_no>0) ?  this.param.n_no=n_no : delete this.param.n_no;
        (typeof m_no != "undefined" && m_no>0) ?  this.param.m_no=m_no : delete this.param.m_no;
        (typeof r_no != "undefined" && r_no>0) ?  this.param.r_no=r_no : delete this.param.r_no;
        return new Promise(function(resolve, reject) {
            $.ajax({
                type: "POST",
                url: "/my/api/getMyNotiList.jsp",
                data: alarmObject.param,
                dataType: "JSON",
                success: function(result)  {
                    resolve(result);
                },
                error: function(err) {
                    reject(err);
                }
            })
        });
    },
    alarmTabView : function(json){
        /**
         * n_no: 1
         * n_title: "e머니"
         * toast_cnt : 0
         * 
         */
        var html = "";
        var total_new = 0;
        if(json.length > 0){
            html += "<div class=\"swiper-slide is--on\" data-n_no=\"0\" ><button type=\"button\" class=\"btn btn-tab\">전체보기</button></div>";
            $.each(json,function(index,data){
                if(data.toast_cnt>0){
                    total_new += data.toast_cnt;
                }
                html += "<div data-n_no=\""+data.n_no+"\" class=\"swiper-slide "+(data.toast_cnt>0 ? 'is--new' : '') +" \"><button type=\"button\" class=\"btn btn-tab\">"+data.n_title+"</button></div>";

            });
            $("#alarmsheet").find(".alarmsheet__head .head_tabs .swiper-wrapper").html(html);
            if(total_new > 0){
                $("#alarmsheet").find(".alarmsheet__head .head_tabs .swiper-wrapper .swiper-slide").eq(0).addClass("is--new");
            }
        }else{

        }
    },
    alarmListView : function(json){
       /** n_no		    탭 번호
        * m_no		    메세지번호
        * r_no		    수신번호
        * m_title		메시지 제목
        * m_contents	메시지 내용
        * pc_url		PC 링크 URL
        * mobile_url	모바일 링크 URL
        * frw_dt		전송 일시 --> 알림 받은 시간
        * r_yn		    수신여부 -->  Y(읽음) / N(읽지 않음)
        * rcv_dt		수신일시 --> r_yn이 Y로 바뀐 시간
         */

        var html = "";
        if(json.length > 0){
            $.each(json,function(index,data){
                html +="<div class=\"card_item "+(data.r_yn=="N" ? 'is--new' : '')+"\" data-m_no=\""+data.m_no+"\" data-r_no=\""+data.r_no+"\" data-n_no=\""+data.n_no+"\">";
                if(data.pc_url.indexOf("zzim") > 0){
                    html +="    <a href=\"javascript:void(0);\" class=\"card_link\" onclick=\"resentZzimOpen(2);\"  >";
                }else{
                    if(data.n_no==4){
                        html +="    <a href=\"javascript:alert('자세한 배송조회는 APP에서 확인 가능합니다.');\" class=\"card_link\">";
                    }else{
                        html +="    <a href=\""+data.pc_url+"\" class=\"card_link\" target=\"_blank\" >";
                    }
                }
                html +="        <span class=\"tx_cate\">"+data.n_title+"</span>";
                if(data.frw_dt !=""){
                    html +="        <span class=\"tx_time\">"+alarmObject.alarmToDate(data.frw_dt)+"</span>";
                }
                html +="        <span class=\"tx_msg\">";
                html +="            <span class=\"tx_nm\">"+data.m_title+"</span>";
                html +="            <span>";
                html +=                 data.m_contents.replace(/\r\n/g,"<br>")
                html +="            </span>";
                html +="        </span>";
                html +="    </a>";
                html +="</div>";
            });
        }else{
            html +="<div class=\"card_item no-data\">";
            html +="<p class=\"tx_noti\">받은 알림이 없습니다</p>";
            html +="</div>";
        }
        $("#alarmsheet").find(".alarmsheet__body .card_box").html(html);
    },
    alarmToastView : function(json){
        /**
         * n_title          토스트 타이틀(e머니, 최저가알림)
         * m_no             메세지번호
         * r_no             수신번호
         * m_title          메시지 제목
         * m_contents       메시지 내용
         * r_yn             수신여부 -->  Y(읽음) / N(읽지 않음)
         * fwd_dt           전송 일시 --> 알림 받은 시간
         * allcnt           전체 메시지 갯수
         * beforecnt        읽지 않은 메시지 개수
         */
        var url = location.pathname;
        if( ( url.indexOf("/search") > -1) ) alarmObject.pagename = "search";
        else if( ( url.indexOf("/list") > -1) ) alarmObject.pagename = "list";
        else if( ( url.indexOf("/detail") > -1) ) alarmObject.pagename = "detail";
        else if( ( url.indexOf("/cpp") > -1) ) alarmObject.pagename = "cpp";
        else  alarmObject.pagename = "main";
        var toastCookie = getCookie("alarm_toast");
        var toastbool = false;
        if(json.length > 0){
            if(typeof toastCookie !="undefined"){
                var tmpArray = toastCookie.split("|");
                if(json[0].m_no > tmpArray[0]){
                    toastbool = true;
                    setCookieCommon("alarm_toast",json[0].m_no + "|" + alarmObject.pagename);
                }else{
                    if(json[0].m_no == tmpArray[0] && !tmpArray.includes(alarmObject.pagename) ){
                        tmpArray.push(alarmObject.pagename);
                        setCookieCommon("alarm_toast",tmpArray.join("|"));
                        toastbool = true;
                    }else{
                        toastbool = false;
                    }
                }
            }else{
                setCookieCommon("alarm_toast",json[0].m_no + "|" + alarmObject.pagename);
                toastbool = true;
            }
        }else{
            toastbool = false;
        }

        if(toastbool){
            $("#pop_alarm").find(".alarm__head .msg_line .tx_msg .tx_num").html(json[0].beforecnt+"건");
           // $("#pop_alarm").find(".alarm__head .msg_line .tx_all .tx_num").html(json[0].allcnt+"건");
    
            $("#pop_alarm").find(".alarm__body .recent_unit .tx_cate").html(json[0].m_title);
            //$("#pop_alarm").find(".alarm__body .recent_unit .tx_time").html(alarmObject.alarmToDate(json[0].frw_dt));
            
            $("#pop_alarm").find(".alarm__body .recent_msg .btn-msg").attr("title", json[0].m_contents.replace(/\r\n/g,"<br>"));
           // $("#pop_alarm").find(".alarm__body .recent_msg .btn-msg .tx_title").html(json[0].m_title);
            $("#pop_alarm").find(".alarm__body .recent_msg .btn-msg .tx_desc").html(json[0].m_contents.replace(/\r\n/g,"<br>"));
            
            $("#pop_alarm").find(".alarm__body .recent_msg .btn-msg").click(function(){
                ga('send','event','alarmbox','toast','message'); 
                insertLog(25392);
                alarmObject.promise(4,0,json[0].m_no,json[0].r_no);
                if(json[0].pc_url.indexOf("zzim") > 0){
                    resentZzimOpen(2);
                }else{
                    window.open(json[0].pc_url);
                }
              
            });
            $("#pop_alarm").show();
            setTimeout(function(){
                $("#pop_alarm").addClass("is-visible");
            },1000);

            // 알림함 스크롤 액션
            var lastScrollY = 0;
            var scrAlarmPop = function(){
                var standard = 30;
                if(window.scrollY > standard){ 
                    if(lastScrollY < window.scrollY){
                        $("#pop_alarm").removeClass("is-visible")    // 스크롤 아래로
                    }else{
                        $("#pop_alarm").addClass("is-visible") // 스크롤 위로
                    }
                }
                lastScrollY = window.scrollY;
            }

            $(window).on({
                "scroll" : scrAlarmPop
            });
        }else{
            $("#pop_alarm").hide();
            $("#pop_alarm").removeClass("is-visible")    // 스크롤 아래로
        }

    },
    alarmToDate : function(date){
        if(date){
            var frw_dt = new Date(date);
            var now_dt = new Date();
            var frw_dt_fm = parseInt(alarmObject.dateFormatter(frw_dt,1));
            var now_dt_fm = parseInt(alarmObject.dateFormatter(now_dt,1));
            var frw_dt_time = frw_dt.getTime();
            var now_dt_time = now_dt.getTime();
            var timeDiffer = (now_dt_time-frw_dt_time)/1000/60/60; //시간으로 체크 

            if(now_dt_fm === frw_dt_fm){
                if (timeDiffer > 12){
                    return "오늘 " + alarmObject.dateFormatter(frw_dt,3);
                }else if(timeDiffer > 1 && timeDiffer < 12) {
                    return parseInt(timeDiffer) +"시간 전";
                } else {
                    return parseInt(timeDiffer*60) +"분 전";
                }
            }else if((now_dt_fm - frw_dt_fm) === 1){
                return "어제 " + alarmObject.dateFormatter(frw_dt,3);
            }else{
                return alarmObject.dateFormatter(frw_dt,2);
            }
        }else{
            return "";
        }
        
    },
    dateFormatter : function(date,type){
        var year = date.getFullYear();
        var month = (1 + date.getMonth());
        var day = date.getDate();
        var hours = date.getHours();
        var minutes = date.getMinutes();
    
        month = month >= 10 ? month : '0' + month;
        day = day >= 10 ? day : '0' + day;
        hours = hours >= 10 ? hours : '0' + hours;
        minutes = minutes >= 10 ? minutes : '0' + minutes;
    
        if(type === 1){
            return year + month + day;
        }else if(type === 2){
            return year + "." + month + "." + day;
        }else if(type === 3){
            return hours + ":" +minutes;
        }
     
    }
}
$(function(){
   
    if(islogin()){
        alarmObject.promise(3).then(alarmObject.alarmToastView);
    }
    // 알림함 열기
    $("#utilMenuAlarm ").off().on("click", function(){ 
        ga('send','event','common','core_header','alarmbox'); 
        insertLog(25391);
        if(islogin()){
            alarmBoxOpen();
        }else{
            Cmd_Login('');
        }
        return false; 
    });

    var alarmBoxOpen = function(){
        
        var alarmTabSwiper;
        var alarmSheet = $("#alarmsheet"); // RIGHTSHEET 알림 목록
        var alarmSheetInner = $("#alarmsheet .alarmsheet__inner"); // RIGHTSHEET INNER
        
        
        $("body").addClass("is-overflow");
        $("#pop_alarm").removeClass("is-visible");
        
        alarmSheet.animate({
            "opacity":1
        }, 300, function(){
            alarmSheet.css("pointer-events","visible");
            alarmSheetInner.addClass("is-expand");

            alarmObject.promise(1).then(alarmObject.alarmTabView).finally(function(){
                 //토스트 쿠키체크
                ga('send', 'pageview',{
                    'title': 'alarmbox'
                });
                alarmObject.promise(2).then(alarmObject.alarmListView).finally(cardShowMotion);

                alarmTabSwiper = new Swiper(".alarmtabs", {
                    loop : false,
                    slidesPerView: "auto",
                    cssMode : true,
                    spaceBetween: 4,
                    freeMode: true,
                });

                alarmTabSwiper.on("click", function(swiper, index){
                    var selItem = swiper.clickedSlide; 
                    var selItemNo = $(selItem).data("n_no");
                    if(selItemNo == 0){
                        ga('send','event','alarmbox','tab','tab_all'); 
                        insertLog(25393);
                    }else if(selItemNo == 1) {
                        ga('send','event','alarmbox','tab','tab_emoney'); 
                        insertLog(25394);
                    }else if(selItemNo == 2) {
                        ga('send','event','alarmbox','tab','tab_minprice'); 
                        insertLog(25395);
                    }
                    else if(selItemNo == 3) {
                        ga('send','event','alarmbox','tab','tab_shopping'); 
                        insertLog(25396);
                    }
                    alarmObject.promise(2,selItemNo).then(alarmObject.alarmListView).finally(function(){
                        setTimeout(cardShowMotion, 200);   
                    });

                    $(selItem).addClass("is--on").siblings().removeClass("is--on"); 
                    alarmTabSwiper.slideTo(swiper.clickedIndex);                        
                    alarmSheetInner.find(".card_item").removeClass("is-shown");
                });
            });
            // 알림함 닫기
            alarmSheet.find(".btn-close, .dimmed").off().on("click", function(){
                alarmSheetInner.removeClass("is-expand");
                setTimeout(function(){
                    alarmSheet.animate({
                        "opacity":0
                    }, 300, function(){
                        $("body").removeClass("is-overflow");
                        alarmSheet.css("pointer-events","none");
                        alarmObject.promise(3).then(alarmObject.alarmToastView);
                        alarmSheetInner.find(".card_item").removeClass("is-shown");
                        alarmTabSwiper.slideTo(0); 
                    })
                }, 300)                        
            });
        });
    }
    // 알림함 카드 노출 모션
    var cardShowMotion = function(){
        var alarmSheetBody = $("#alarmsheet .alarmsheet__inner .alarmsheet__body"); // RIGHTSHEET INNER BODY
        var len =  $(".alarmsheet__inner").find(".card_item").length;
        var _idx = 0;         

        alarmSheetBody.animate({scrollTop:0},300);
          
        // 카드 순차 노출
        var cardVisible = setInterval(function(){
            if(_idx < len) {
                $(".alarmsheet__inner").find(".card_item").eq(_idx).addClass("is-shown");
                _idx++
            }   
            if( _idx === len) {
                clearInterval(cardVisible);
            }
        }, 100);
        alarmSheetBody.find(".card_item").off().on("click",function(){
            
            var vThis = $(this);
            var vThis_n_no = $("#alarmsheet .alarmsheet__head .alarmtabs").find(".swiper-slide.is--on").data("n_no");

            if(vThis_n_no == 0){
                ga('send','event','alarmbox','all','message'); 
                insertLog(25397);
            } else if(vThis_n_no == 1) {
                ga('send','event','alarmbox','emoney','message'); 
                insertLog(25398);
            }else if(vThis_n_no == 2) {
                ga('send','event','alarmbox','minprice','message');
                insertLog(25399);
            }else if(vThis_n_no == 3) {
                ga('send','event','alarmbox','shopping','message'); 
                insertLog(25400);
            }

            if(vThis.hasClass("is--new")){
                var vThis_m_no = vThis.data("m_no");
                var vThis_r_no = vThis.data("r_no");
                alarmObject.promise(4,0,vThis_m_no,vThis_r_no).then(function(data){
                    if(data==1) vThis.removeClass("is--new");
                });
            }
        });
    }
});

