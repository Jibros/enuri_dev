
<!-- [C] 동영상 광고구좌(HOME/LP/VIP) -->
<div class="advod" id="div_advod" style="display:none;">
	<div class="contents">
		<!-- 동영상 광고 확대 영역 -->
		<div id="bigVod" class="advod__all" style="display:none;">
			<div class="expand_vod">
				<div class="inner">
					<div class="big_vod_wrap">
						<!-- 동영상 프레임 -->
						<div id="bigPlayer" class="big_vod"></div>
						
						<!-- 광고 배너 -->
						<a href="" class="big_vod_link" target="_blank" id="a_advod_bnr">
							<img id="img_advod_bnr" src="" alt="" />
						</a>
					</div>
				</div>

				<!-- 닫기 -->
				<button type="button" class="btn_close" onclick="$(this).closest('#bigVod').removeClass('fadein'); bigPlayer.stopVideo(); bigState = false;">
					<span class="tx_info">광고 그만 보기</span>
				</button>
			</div>
		</div>
		<!-- // -->

		<!-- 동영상 광고 둥둥이배너 -->
		<div class="advod__bnr" >
			<div class="inner">
				<div class="bnr__btn">
					<!-- 210506 : SR#46450 : [PV] 동영상 광고 디자인 변경 -->
                    <div class="bnr__popup">
                        <p class="tx_info"><strong>마우스</strong>를 올려 HD동영상 감상</p>
                    </div>
                    <span class="bnr__play"><!-- 플레이버튼 --></span>
                    <!-- // -->
					<span class="bnr__thum"><img id="img_doong_bnr" src="" alt="" /></span>

					<div class="bnr__dimmed">
						<div class="bnr__gauge">
							<div class="gauge-wrap"></div>
							<div class="gauge-count"><!-- 3,2,1,0 --></div>
						</div>
					</div>
				</div>
				<div class="bnr__source">
					<button type="button" class="btn btn__cls">
						<span class="ico_cls">X</span>
						<span class="tx_today" onclick="javascript:closeWin();">오늘 하루 그만보기</span>
					</button>
					<p class="tx_info">동영상 보기 클릭</p>
				</div>
			</div>
		</div>
		<!-- // -->
	</div>
</div>
<!-- // -->
<script>

//<!-- 둥둥이배너 관련 스크립트 -->

$(document).ready(function(){
	// 동영상광고 둥둥이배너 호출
	fn_doong_bnr_check();
});


var vodId = '';
var timerVod;
var bigState = false;
var bigPlayer;
var doong_bnr_url;
var advod_bnr_url;
var doong_bnr_click_url;
var pathname = location.pathname;
var iid ;

function fn_doong_bnr_check(){
	//console.log("IncrightWing_2021.js fn_doong_bnr_check start");
	let name ;
	let cate = strCate_banner.substring(0,4);
	
	if(pathname == "/" || pathname == "/Index.jsp"){
		name = "doong_bnr_home";
		$("#div_advod").addClass('is--home')
	}else if(pathname == "/list.jsp"){
		name = "doong_bnr_lp";
		$("#div_advod").addClass('is--lp')
	}else if(pathname == "/detail.jsp"){
		name = "doong_bnr_vip";
		$("#div_advod").addClass('is--vip')
	}



	if(getCookie(name) !="Y"){
		fn_doong_bnr_info(cate);
	}
}

function fn_doong_bnr_info(cate) {
	if(pathname == "/" || pathname == "/Index.jsp"){
		doong_bnr_url = "http://ad-api.enuri.info/enuri_PC/pc_home/HD1/req?cate="+cate;
		advod_bnr_url = "http://ad-api.enuri.info/enuri_PC/pc_home/HD2/bundle?bundlenum=10&cate="+cate;

	}else if(pathname == "/list.jsp"){
		doong_bnr_url = "http://ad-api.enuri.info/enuri_PC/pc_lp/LD1/req?cate="+cate;
		advod_bnr_url = "http://ad-api.enuri.info/enuri_PC/pc_lp/LD2/bundle?bundlenum=10&cate="+cate;

	}else if(pathname == "/detail.jsp"){
		doong_bnr_url = "http://ad-api.enuri.info/enuri_PC/pc_vip/VD1/req?cate="+cate;
		advod_bnr_url = "http://ad-api.enuri.info/enuri_PC/pc_vip/VD2/bundle?bundlenum=10&cate="+cate;
	}
	
	if(doong_bnr_url){
		$.ajax({
			type:"get",
			url: doong_bnr_url,
			data:"",
			dataType: "JSON",
			success:function(result) {
				//console.log("fn_doong_bnr_info 1 result : "+JSON.stringify(result));
				if(result.IMG1){
					let title = result.TITLE;
					let text = result.TEXT;
					let jurl1 = result.JURL1;
					let img1 = result.IMG1;
					let target = result.TARGET;
					let alt = result.ALT;
					iid = result.IID;
					let width = result.WIDTH;
					let height = result.HEIGHT;

					doong_bnr_click_url = jurl1;
					
					$("#img_doong_bnr").attr("src", img1);
					$("#img_doong_bnr").attr("alt", alt);

					$(".advod__bnr").on("click", function(){
						fn_advod_bnr_click();
					})

					if(img1){
						//console.log("fn_doong_bnr_info 2");
						
						$("#smallVod").show();
						$("#div_advod").show();
					}
				}
				
			},
			error: function(request,status,error){
				//console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	}
	
}


function fn_advod_bnr_click(){
	$.ajax({
		type:"get",
		url: doong_bnr_click_url,
		data:"",
		dataType: "JSON",
		success:function(result) {
		},
		error: function(request,status,error){
			//console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});

	fn_advod_bnr_info();
}


function fn_advod_bnr_info() {
	//console.log("fn_advod_bnr_info start");
	$.ajax({
		type:"get",
		url: advod_bnr_url,
		data:"",
		dataType: "JSON",
		success:function(result) {
			//console.log("fn_advod_bnr_info 1 result : "+JSON.stringify(result));

			result.forEach(function(data, idx){
				//console.log(idx+":"+data);
				//console.log("fn_advod_bnr_info 1 title : "+data.TITLE);
				//console.log("fn_advod_bnr_info 1 title : "+data.IID);

				if(data.IID == iid){
					//console.log("fn_advod_bnr_info 2 iid : "+iid);
					//console.log("fn_advod_bnr_info 2 data.iid : "+data.IID);

					let title = data.TITLE;
					let text = data.TEXT;
					let jurl1 = data.JURL1;
					let img1 = data.IMG1;
					let target = data.TARGET;
					let alt = data.ALT;
					let youtube = data.YOUTUBE;
					let width = data.WIDTH;
					let height = data.HEIGHT;

					vodId = youtube.replace('https://www.youtube.com/embed/', '');

					var tag = document.createElement('script');
						tag.src = "https://www.youtube.com/iframe_api";
					var firstScriptTag = document.getElementsByTagName('script')[0];
						firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

					$("#img_advod_bnr").attr("src", img1);
					$("#img_advod_bnr").attr("alt", alt);
					$("#a_advod_bnr").attr("href", jurl1)
					$('#a_advod_bnr').attr('target', '_blank');
				
					if(vodId){
						$("#bigVod").show();
					}
				}

			});


			
		},
		error: function(request,status,error){
			//console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
      	}
	});
}



function onYouTubeIframeAPIReady() {
	//console.log("onYouTubeIframeAPIReady start");
	bigPlayer = new YT.Player('bigPlayer', {
		videoId:vodId,
		playerVars:{'controls':1, 'rel':0},
		events:{
			'onReady':onPlayerReady
		}
	});
}

function onPlayerReady(event) {
	//console.log("onPlayerReady start");
	event.target.mute();
	event.target.playVideo();
}

function stopVideo() {
	player.stopVideo();
}		

function setTimerFunc(){ 
	timerVod = setTimeout(function(){
		try {
			$("#bigVod").addClass('fadein'); 
			bigPlayer.playVideo();

			bigState = true;
		} catch (e) {
			//console.log("/wide/main/include/main_advod.jsp setTimerFunc() e : "+e);
		} finally {
			setTimerFunc();
		}
		
	}, 1000);
}
function clearTimerFunc(){ 
	clearTimeout(timerVod) 
}

//쿠키설정    
function setCookie( name, value, expiredays ) {
	var todayDate = new Date();
	todayDate.setDate( todayDate.getDate() + expiredays );
	document.cookie = name + '=' + escape( value ) + '; path=/; expires=' + todayDate.toGMTString() + ';'
}

//쿠키 불러오기

function getCookie(cookieName){

    var cookieValue=null;
    if(document.cookie){
        var array=document.cookie.split((escape(cookieName)+'='));
        if(array.length >= 2){
            var arraySub=array[1].split(';');
            cookieValue=unescape(arraySub[0]);
        }
    }
    return cookieValue;
}

//닫기 버튼 클릭시
function closeWin()
{
	let name ;
	if(pathname == "/" || pathname == "/Index.jsp"){
		name = "doong_bnr_home";
	}else if(pathname == "/list.jsp"){
		name = "doong_bnr_lp";
	}else if(pathname == "/detail.jsp"){
		name = "doong_bnr_vip";
	}

	setCookie(name, 'Y' , 1 );
	$("#div_advod").hide();
}

$(".advod__bnr .bnr__btn").on("mouseenter", function(){
	if(!bigState){  
		$(this).closest(".advod__bnr").removeClass("fadeout").addClass("fadein")

		fn_advod_bnr_click();

		setTimerFunc();
	}
}).on("mouseleave", function(){
	$(this).closest(".advod__bnr").removeClass("fadein").addClass("fadeout")
	clearTimerFunc();
})   

// 클릭 : SHOW/PLAY
$(".bnr__dimmed").on("click", function(){
	clearTimerFunc();
	$("#bigVod").addClass('fadein'); 
	bigPlayer.playVideo();
})

$(".bnr__source .btn__cls").on("click", function(){
	$(this).closest(".advod__bnr").hide();
})

//<!-- // 둥둥이배너 관련 스크립트 -->
</script>
