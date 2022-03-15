const pages = {
    table: 1
    ,consumables: 1
    ,sameSeries: 1
    ,buyTogether: 1
}

let reviewTitle = gModelData.gModelNmView;

if (reviewTitle.lastIndexOf("(") > -1) {
    reviewTitle = reviewTitle.substring(0, reviewTitle.indexOf("("));
}

if(reviewTitle.lastIndexOf("[") > -1) {
    reviewTitle = reviewTitle.substring(0,reviewTitle.lastIndexOf("["));
}

export const reviewPromise = {
    param : {},
    knowcom : function () {
        this.param = {
            modelno : gModelData.gModelno,
            cate : gModelData.gCategory
        }

        return new Promise((res,rej) => {
            $.ajax({
                type:"get",
                url:"/wide/api/product/prodReviewKnow.jsp",
                data:this.param,
                dataType:"JSON",
                success: (result) => {
                    if(result.total > 0) res(result.data);
                },
                error: (err) => {
                    rej(err);
                }
            })
        });
    },
    zum : function () {
        return new Promise((res,rej) => {
            this.param = {
                modelno : gModelData.gModelno,
                cate : gModelData.gCategory,
                modelnm : gModelData.gModelNmView,
                keyword : encodeURIComponent(gModelData.gModelNm, "UTF-8")
            }

            $.ajax({
                type:"get",
                url:"/wide/api/product/prodReviewZum.jsp",
                data:this.param,
                dataType:"JSON",
                success: (result) => {
                    if(result.success) res(result.data);
                },
                error: (err) => {
                    rej(err);
                }
            })
        });
    }
}

export function prodReviewKnow(data){
    const knowArr = data.know_list;
    const $knowcom = $('#prodBlogReview .blogreview');
    let knowHtml = "";

    if(knowArr && knowArr.length > 0){
        knowArr.forEach(obj => {
            knowHtml += `<li>
                            <a href="/knowcom/detail.jsp?kbno=${obj.kb_no}" class="thum__link" target="_blank" onclick="insertLog(17550);">
                                <img data-original="${obj.thumbnail}" src="http://img.enuri.info/images/home/thum_none.jpg" onerror="http://img.enuri.info/images/home/thum_none.jpg" alt="">
                            </a>
                            <a href="/knowcom/detail.jsp?kbno=${obj.kb_no}" class="tx_info" target="_blank" onclick="insertLog(17550);">
                                <span class="tx_cate">${obj.kk_codeNm}</span>
                                <span class="tx_name">${obj.kb_title}</span>
                            </a>
                        </li>`
        });
        
        $knowcom.find('.blogreview__tit strong').text(`${reviewTitle} 관련`);
        $knowcom.find('.blogreview__list').html(knowHtml);
        $knowcom.show();
        $("#prodBlogReview").find(".blogreview__list .thum__link img").lazyload({
            placeholder : 'http://img.enuri.info/images/home/thum_none.jpg',
            effect : 'fadeIn',
            effectTime : 2000,
            threshold : 800
        });
    }
}

export function prodReviewZum(data){
    const blogArr = data.blog.response;
    const videoArr = data.video.response;
    const $srchResult = $('#prodBlogReview .srchresult');
    const $blog = $("#prodBlogReview .srchresult[data-about='blog']");
    const $blogSrchCnt = $("#prodBlogReview .srchresult[data-about='blog'] .srchresult__cont .srchcnt");
    const $video = $("#prodBlogReview .srchresult[data-about='video']");
    const $videoSrchCnt = $("#prodBlogReview .srchresult[data-about='video'] .srchresult__cont .srchcnt");
    let blogHtml = "";
    let videoHtml = "";
    let blogCnt = 0;
    let blogNoShow = false;
	
    //블로그
    if(blogArr && blogArr.docs.length > 0){
        const totalNum = blogArr.numFound;

        blogArr.docs.forEach(obj => {
            let createTime = "";

            if(obj.createTime) createTime = obj.createTime.substring(0, 10).replace(/-/g, ".");
			if(obj.channelLink == "http://blog.naver.com/jayulo007" || obj.channelLink == "http://blog.naver.com/walnutbaum" || obj.channelLink == "http://blog.naver.com/sarangmom11" || obj.channelLink == "https://brunch.co.kr/@nimathebride"){
				blogNoShow = true; 
			}
            if(blogCnt < 10 && !blogNoShow){
           		 blogHtml += `<li>
                            <a href="${obj.wClickLink}" class="thum__link" target="_blank" onclick="insertLog(14535);">
                                <img data-original="${obj.imageThumbnail78x78}" src="http://img.enuri.info/images/home/thum_none.jpg" onerror="http://img.enuri.info/images/home/thumb_subst.jpg" alt="">
                            </a>
                            <div class="tx_info">
                                <a href="${obj.wClickLink}" class="tx_link" target="_blank"  onclick="insertLog(14535);">
                                    <span class="tx_name">${obj.title[0]}</span> 
                                    <span class="tx_detail">${(obj.body) ? obj.body[0] : ``}</span>
                                </a>                                                    
                                <ul class="tx_util">
                                    <li><a href="${obj.key}" class="tx_url"  target="_blank">${obj.key}</a></li>
                                    <li>${createTime}</li>
                                </ul>
                            </div>
                        </li>`;
				blogCnt++;
			}
			blogNoShow = false;
        });
        $blogSrchCnt.find('.btn__more').attr("href", `http://search.zum.com/search.zum?method=blog&option=accu&query=${data.keyword}&cm=tab&co=4`);
        $blogSrchCnt.find('.tx_cnt').text(`(${totalNum.format()})`);
        $srchResult.find('.srchresult__tit strong').eq(0).text(`${reviewTitle} 관련`);
        $srchResult.find('.vodresult__list').html(blogHtml);
        $blog.show();
        $("#prodBlogReview").find(".srchresult .thum__link img").lazyload({
            placeholder : 'http://img.enuri.info/images/home/thum_none.jpg',
            effect : 'fadeIn',
            effectTime : 2000,
            threshold : 800
        });
    }
    
    //동영상
    if(videoArr && videoArr.docs.length > 0){
        const totalNum = videoArr.numFound;
        
        videoArr.docs.forEach(obj => {
            let createTime = "";
            
            if(obj.createTime) createTime = obj.createTime.substring(0, 10).replace(/-/g, ".");
            
            videoHtml += `<li>
                            <a href="${obj.webLink}" class="thum__link" target="_blank" onclick="insertLog(14537);">
                                <img data-original="${obj.imageThumbnail220x124}" src="http://img.enuri.info/images/home/thum_none.jpg" onerror="http://img.enuri.info/images/home/thumb_subst.jpg" alt="">
                            </a>
                            <a href="${obj.webLink}" class="tx_info" target="_blank" onclick="insertLog(14537);">
                                <span class="tx_name">${obj.title[0]}</span>
                            </a>
                            <ul class="tx_util">
                                <li>${createTime}</li>
                                <li>Youtube</li>
                            </ul>
                        </li>`;
        });
        
        $videoSrchCnt.find('.btn__more').attr("href", `http://search.zum.com/search.zum?method=video&option=accu&query=${data.keyword}&cm=tab&co=4`);
        $videoSrchCnt.find('.tx_cnt').text(`(${totalNum.format()})`);
        $srchResult.find('.srchresult__tit strong').eq(1).text(`${reviewTitle} 관련`);
        $srchResult.find('.blogresult__list').html(videoHtml);
        $video.show();
        $("#prodBlogReview").find(".srchresult .thum__link img").lazyload({
            placeholder : 'http://img.enuri.info/images/home/thum_none.jpg',
            effect : 'fadeIn',
            effectTime : 2000,
            threshold : 800
        });
    }
}