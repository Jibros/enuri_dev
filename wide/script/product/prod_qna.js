const param = {
    modelno : gModelData.gModelno,
    ca_code : gModelData.gCategory,
    page : 1,
    type : "CL",
    title : "",
    content : ""
}
export const paramHandler =  {
    set: (prop, value) => {
        if (prop != "page") {
            param["page"] = 1;
        }
        param[prop] = value;
        qnaPromise.qnaList().then(qnaView);
        return true;
    },
    get: (prop) => {
        return param[prop];
    }
};
export const qnaPromise = {
    qnaList: function () {
        param.type = "CL";
        param.modelno = gModelData.gModelno;

        return new Promise((resolve, reject) => {
            $.ajax({
                type: "POST",
                url: "/wide/api/product/prodQna.jsp",
                data: param,
                dataType: "JSON",
                success: (result) => {
                    resolve(result);
                },
                error: (err) => {
                    reject(err);
                }
            })
        });
    },
    qnaInsert: function(title = "", content = ""){
        if(title=="" || content==""){
            alert("제목 또는 내용을 입력 후 등록해주시기 바랍니다.");
            return;
        }else if(title.length>50){
            alert("제목은 최대 50자까지 가능합니다.");
            return;
        }
        
        param.type = "CI";
        param.title = title;
        param.content = content;
        
        return new Promise((resolve, reject) => {
            $.ajax({
                type : "POST",
                data : param,
                url : "/wide/api/product/prodQna.jsp",
                dataType: "JSON",
                success : function(result){
                    resolve(result);
                    $('#inputCMQNA_01,#inputCMQNA_02').val("");
                    $('#QNAWRITELAYER').hide();
                },
                error: function(err){
                    reject(err);
                }
            });
        });
    }
}

export const qnaView = (json) => {
    if(json.success){
        let html =``;
        if(json.total > 0){
            let qnaList = json.data.cm_qna_list;
            if(qnaList.length > 0){
                $("#prodQnA").find(".cmqna .cmqna__cont .no-data").hide();
                $.each(qnaList, (index,listData) => {
                    let userid = listData.userid;
                    let kb_nickname = listData.kb_nickname;
                    let kb_content = listData.kb_content;
                    let kb_no = listData.kb_no;
                    let kb_parent_no = listData.kb_parent_no;
                    let sns_dcd = listData.sns_dcd;
                    let kb_regdate = listData.kb_regdate;
                    let kb_title = listData.kb_title;
                    let kb_rownum = listData.kb_rownum;
                    let pro_reply = listData.pro_reply;
                    let pro_replyYN = listData.pro_replyYN;
                    let useridView = userid;

                    if (sns_dcd != "" && kb_nickname != "" && (sns_dcd == "N" || sns_dcd == "K")) {
                        if (kb_nickname.length > 2) {
                            useridView = kb_nickname.substring(0,2) + "****";
                        } else {
                            useridView = kb_nickname + "****";
                        }
                    }

                    html +=`    <tr>
                                    <td>${kb_rownum}</td>
                                    <td class="tx_stat">
                                    ${pro_replyYN =="Y" ? `<span class="badge badge--complete">답변완료</span>` : `<span class="badge">답변대기</span>`}
                                    </td>
                                    <td class="tx_cont" data-idx="${index}"><button type="button">${kb_title}</button></td>
                                    <td>${useridView}</td>
                                    <td>${kb_regdate}</td>
                                </tr>`;
                });
                $('#tabQna em').text(`(${json.total})`);
            }
            
            $("#prodQnA").find(".cmqna .cmqna__cont .cmqna__table tbody").html(html);
            $("#prodQnA").find(".cmqna .cmqna__cont .cmqna__table").show();
            $("#prodQnA").find(".cmqna .cmqna__cont .cmqna__table .tx_cont").click(function(){
                insertLog(18636);
                qnaContentsView(qnaList[$(this).data("idx")]);
            });
            fn_paging(paramHandler.get("page"), 10 , json.total);
            
            $("#prodQnA").find(".comm__paging ul li").unbind().click(function () {
                let page = $(this).data("page");
                paramHandler.set("page",page);
            });
        }else{
            $('#tabQna em').text(``);
            $("#prodQnA").find(".cmqna .cmqna__cont .no-data").show();
            $("#prodQnA").find(".cmqna .cmqna__cont .cmqna__table").hide();
        }

        $('#prodQnA .btn__question').click(function(){
            if(!islogin()){
                alert("로그인을 하시면 글을 작성할 수 있습니다.");
                Cmd_Login('');
                return;
            }else{
                insertLog(18635);
                $('#QNAWRITELAYER').show();
            }
        });

        $('#QNAWRITELAYER .lay-comm__btn-group .lay-btn--color--blue').unbind().click(function(){
            fn_qnaInsert();
        });
    }

}
const qnaContentsView = (json) => {
    console.log(json);
    let html =``;
    let userid = json.userid;
    let kb_nickname = json.kb_nickname;
    let kb_content = json.kb_content;
    let kb_no = json.kb_no;
    let kb_parent_no = json.kb_parent_no;
    let sns_dcd = json.sns_dcd;
    let kb_regdate = json.kb_regdate;
    let kb_title = json.kb_title;
    let kb_rownum = json.kb_rownum;
    let pro_reply = json.pro_reply;
    let pro_replyYN = json.pro_replyYN;

    let useridView = userid;

    if (sns_dcd != "" && kb_nickname != "" && (sns_dcd == "N" || sns_dcd == "K")) {
        if (kb_nickname.length > 2) {
            useridView = kb_nickname.substring(0,2) + "****";
        } else {
            useridView = kb_nickname + "****";
        }
    }
    html +=`<div class="dimmed"></div>
            <div class="lay-cmqna lay-comm">
                <div class="lay-comm--head">
                    <strong class="lay-comm__tit">CM Q&amp;A</strong>
                </div>
                <div class="lay-comm--body">
                    <div class="lay-comm--inner">
                        <div class="line__question">
                            <p class="tx_tit">${kb_title}</p>
                            <p class="tx_source">
                                ${pro_replyYN =="Y" ? `<span class="badge badge--complete">답변완료</span>` : `<span class="badge">답변대기</span>`}
                                <span class="user">${useridView}</span>
                                <span>${kb_regdate}</span>
                            </p>

                            <p class="tx_sub">${kb_content}</p>
                        </div>

                        <div class="line__answer">
                        ${pro_replyYN =="Y" ? ` ${pro_reply.kb_content}` : `<p class="tx_wait">답변 대기중입니다.</p>`}
                        </div>
                    </div>
                </div>
                <!-- 버튼 : 레이어 닫기 -->
                <button class="lay-comm__btn--close comm__sprite" onclick="$(this).closest('.lay--dimm-wrap').hide()">레이어 닫기</button>
            </div>`;
    $('#QNAVIEWLAYER').html(html);
    $('#QNAVIEWLAYER').show();
}
/* 페이징 처리 */
const fn_paging = (pageNum, pageSize, pageCnt) => {
    var pHtml = "";
    var startPage = parseInt(pageNum / 10) * 10;
    var totalPage = (pageCnt / pageSize);
    var endPage = 0;

    if (pageNum > 0 && parseInt(pageNum % 10) == 0) {
        startPage = startPage - 10;
    }

    if (pageNum > 10) {
        pHtml += "<li data-page=\"" + (startPage - 1) + "<a href=\"javascript:;\" class=\"btn btn__prev\">이전</a></li>";
    }

    if (totalPage > (startPage + 10)) {
        endPage = (startPage + 10);
    } else {
        endPage = totalPage;
    }
    let i = startPage;
    for (i = startPage; i < endPage; i++) {
        if (pageNum == (i + 1)) {
            pHtml += "<li data-page=\"" + (i + 1) + "\" class=\"is-on\"><a href=\"javascript:;\" class=\"p_num\">" + (i + 1) + "</a></li>";
        } else {
            pHtml += "<li data-page=\"" + (i + 1) + "\"><a href=\"javascript:;\" class=\"p_num\">" + (i + 1) + "</a></li>";
        }
    }

    if (totalPage > (startPage + 10)) {
        pHtml += "<li data-page=\"" + (i + 1) + "\"><a href=\"javascript:;\" class=\"btn btn__next\">다음</a></li>";
    }
    $("#prodQnA").find(".comm__paging ul").html(pHtml);
    $("#prodQnA").find(".comm__paging").show();
}

const fn_qnaInsert = async function(){
    await qnaPromise.qnaInsert($('#inputCMQNA_01').val(),$('#inputCMQNA_02').val());
    await qnaPromise.qnaList().then(qnaView);
}