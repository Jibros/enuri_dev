$(function(){

    var heightNode = 6, // 사다리 세로 갯수		
		widthNode =  4, // 사다리 가로 갯수
		heightNum = 30, // 각 사다리 높이
		widthNum = 74, // 각 사다리 너비
		borderThick = 7; // 보더 두께

    var LADDER = {};
    var row = 0;
    var ladder = $('#ladder');
    var ladder_canvas = $('#ladder_canvas');
    var GLOBAL_FOOT_PRINT= {};
    var GLOBAL_CHECK_FOOT_PRINT= {};
    var working = false;

	var lineSpeed = 80;

	// init
	init();
	
    function init(){
        canvasDraw();
    }

    function canvasDraw(){
        ladder.css({
            'width' :( widthNode-1) * widthNum + borderThick,
            'height' : (heightNode ) * heightNum,
            'background' : 'transparent'
        });
       ladder_canvas
       .attr('width' , ( widthNode-1) * widthNum + borderThick)
       .attr('height' , ( heightNode) * heightNum);

        setDefaultFootPrint();
        reSetCheckFootPrint();
        setDefaultRowLine();
        setRandomNodeData();
        drawDefaultLine();
        drawNodeLine();
        userSetting();
        resultSetting();        
    }
    var userName = ""; // 클릭된 node split
	var userSelectNode, // 선택된 노드
		userColor; // 선택된 색상 

	$(document).on('click', 'button.ladder-start', function(e){
		if(working){
			return false;
		}
		//$('.dim').remove();
		working = true;
		reSetCheckFootPrint();
		var _this = $(e.target);
		_this.attr('disabled' ,  true).addClass("on");
		userSelectNode = _this.attr('data-node');
		userColor =  _this.attr('data-color');
		userName =  userSelectNode.split('-')[0]*1; 		
		if(userName === 0){
			userName++;
		}
	});

	$(document).on('click', '.start_ladder', function(e){
		console.log("userName " + userName);
		if(!userName){// 선택 안할 경우 alert
			alert("세뱃돈 줄 사람을 선택하세요.");
		}else{
			$(this).animate({'opacity': 0, 'top': 90}, 300, 'linear', function(){
				$(this).hide();
				startLineDrawing(userSelectNode, userColor);
			});
			$(document).off('click', 'button.ladder-start');
		}
	});
	    
    function startLineDrawing(node , color){
        var node = node;
        var color = color;
        
        var x = node.split('-')[0]*1;
        var y = node.split('-')[1]*1;
        var nodeInfo = GLOBAL_FOOT_PRINT[node];

        GLOBAL_CHECK_FOOT_PRINT[node] = true;
        
        var dir = 'r'
        if(y ==heightNode ){ // 사다리 결과 
            reSetCheckFootPrint();
            
			console.log("도착 " +node)
			$('#' + node + "-user").animate({opacity:0}, 300, function(){
				$(this).stop().animate(
					{opacity:1}, 500)
					.addClass("open")
					.animate({bottom: '-30px'}, 400)
					.animate({bottom: '-40px'}, 400)					
					//.attr("onclick","onoff('prizes"+(x+1)+"')");
					.attr("onclick","onoff('prizes')");
			});			

            working = false;
            return false;
        }
        if(nodeInfo["change"] ){
            var leftNode = (x-1) + "-" +y;
            var rightNode = (x+1) + "-" +y;
            var downNode = x +"-"+ (y + 1);
            var leftNodeInfo = GLOBAL_FOOT_PRINT[leftNode];
            var rightNodeInfo = GLOBAL_FOOT_PRINT[rightNode];
                
            if(GLOBAL_FOOT_PRINT.hasOwnProperty(leftNode) && GLOBAL_FOOT_PRINT.hasOwnProperty(rightNode)){      
                var leftNodeInfo = GLOBAL_FOOT_PRINT[leftNode];
                var rightNodeInfo = GLOBAL_FOOT_PRINT[rightNode];
                if(  (leftNodeInfo["change"] &&  leftNodeInfo["draw"] && !!!GLOBAL_CHECK_FOOT_PRINT[leftNode] ) && (rightNodeInfo["change"])&&  leftNodeInfo["draw"]  && !!!GLOBAL_CHECK_FOOT_PRINT[rightNode] ){
                    //Left우선 
                    //console.log("중복일때  LEFT 우선");
                    stokeLine(x, y, 'w' , 'l' , color, borderThick)
                     setTimeout(function(){ 
                         return startLineDrawing(leftNode, color)
                     }, lineSpeed);
                }
                else if(  (leftNodeInfo["change"] &&  !!!leftNodeInfo["draw"] && !!!GLOBAL_CHECK_FOOT_PRINT[leftNode] ) && (rightNodeInfo["change"]) && !!!GLOBAL_CHECK_FOOT_PRINT[rightNode] ){
                    //console.log('RIGHT 우선')
                    stokeLine(x, y, 'w' , 'r' , color ,borderThick)
                    //console.log("right")
                    setTimeout(function(){ 
                        return startLineDrawing(rightNode, color)
                     }, lineSpeed);
                }
                else if(  (leftNodeInfo["change"] &&  leftNodeInfo["draw"] && !!!GLOBAL_CHECK_FOOT_PRINT[leftNode] ) && (!!!rightNodeInfo["change"]) ){
                    //Left우선 
                    //console.log("LEFT 우선");
                    stokeLine(x, y, 'w' , 'l' , color ,borderThick)
                     setTimeout(function(){ 
                         return startLineDrawing(leftNode, color)
                     }, lineSpeed);
                }
                 else if(  !!!leftNodeInfo["change"]  &&  (rightNodeInfo["change"]) && !!!GLOBAL_CHECK_FOOT_PRINT[rightNode] ){
                    //Right우선 
                    //console.log("RIGHT 우선");
                    stokeLine(x, y, 'w' , 'r' , color ,borderThick)
                     setTimeout(function(){ 
                         return startLineDrawing(rightNode, color)
                     }, lineSpeed);
                }
                else{
                    //console.log('DOWN 우선')
                    stokeLine(x, y, 'h' , 'd' , color ,borderThick)
                    setTimeout(function(){ 
                       return startLineDrawing(downNode, color)
                    }, lineSpeed);
                }
            }else{
                //console.log('else')
               if(!!!GLOBAL_FOOT_PRINT.hasOwnProperty(leftNode) && GLOBAL_FOOT_PRINT.hasOwnProperty(rightNode)){      
                    /// 좌측라인
                    //console.log('좌측라인')
                    if(  (rightNodeInfo["change"] && !!!rightNodeInfo["draw"] ) && !!!GLOBAL_CHECK_FOOT_PRINT[rightNode] ){
                        //Right우선 
                        //console.log("RIGHT 우선");
                        stokeLine(x, y, 'w', 'r', color, borderThick)
                        setTimeout(function(){ 
                            return startLineDrawing(rightNode, color)
                        }, lineSpeed);
                    }else{
                        //console.log('DOWN')
                        stokeLine(x, y, 'h', 'd', color ,borderThick)
                        setTimeout(function(){ 
                           return startLineDrawing(downNode, color)
                        }, lineSpeed);
                    }
                    
               }else if(GLOBAL_FOOT_PRINT.hasOwnProperty(leftNode) && !!!GLOBAL_FOOT_PRINT.hasOwnProperty(rightNode)){      
                    /// 우측라인
                    //console.log('우측라인')
                    if(  (leftNodeInfo["change"] && leftNodeInfo["draw"] ) && !!!GLOBAL_CHECK_FOOT_PRINT[leftNode] ){
                        //Right우선 
                        //console.log("LEFT 우선");
                        stokeLine(x, y, 'w' , 'l' , color ,borderThick)
                        setTimeout(function(){ 
                            return startLineDrawing(leftNode, color)
                        }, lineSpeed);
                    }else{
                        //console.log('DOWN')
                        stokeLine(x, y, 'h' , 'd' , color ,borderThick)
                        setTimeout(function(){ 
                           return startLineDrawing(downNode, color)
                        }, lineSpeed);
                    }
               }
            }

        }else{
            var downNode = x +"-"+ (y + 1);
            stokeLine(x, y, 'h' , 'd' , color ,borderThick)
            setTimeout(function(){ 
                return startLineDrawing(downNode, color)
             }, lineSpeed);
        }
    }



    function userSetting(){
        var userList = LADDER[0];
        var html = '';
        for(var i=0; i <  userList.length; i++){
            //var color = '#'+(function lol(m,s,c){return s[m.floor(m.random() * s.length)] + (c && lol(m,s,c-1));})(Math,'0123456789ABCDEF',4);
			var color = '#ce4700';

            var x = userList[i].split('-')[0]*1;
            var y = userList[i].split('-')[1]*1;
            var left = x * widthNum - (widthNum/2);
            html += '<div class="user-wrap user-'+(x+1)+'" style="left:'+left+'px"><button class="ladder-start stripe" style="background-color:transparent" data-color="'+color+'" data-node="'+userList[i]+'"></button>';
            html +='</div>'
        }
        ladder.append(html);
    }
    function resultSetting(){
         var resultList = LADDER[heightNode-1];

        var html = '';
        for(var i=0; i <  resultList.length; i++){
            
            var x = resultList[i].split('-')[0]*1;
            var y = resultList[i].split('-')[1]*1 + 1;
            var node = x + "-" + y;
            var left = x * widthNum - (widthNum/2)
			// 사다리 선물 default class="answer-wrap"
			// 사다리 도착 후 선물 열릴 때  class="open" 추가 후 레이어 팝업 오픈
			// 피자 class="prizes1" 추가
			// 아이스크림 class="prizes2" 추가
			// 10 e머니 class="prizes3" 추가
			// 꽝! class="prizes4" 추가
            // html += '<div  id="'+node+'-user" class="answer-wrap prizes'+(x+1)+' open" style="left:'+left+'px">';
            
			html += '<div  id="'+node+'-user" class="answer-wrap" style="left:'+left+'px">';
            html +='<p class="stripe"></p>';
            html +='</div>';
        }
        ladder.append(html);
    }

    function drawNodeLine(){
        for(var y=0; y < heightNode; y++){
            for(var x =0; x <widthNode; x++){
                var node = x + '-' + y;
                var nodeInfo  = GLOBAL_FOOT_PRINT[node];
                if(nodeInfo["change"] && nodeInfo["draw"] ){
                     stokeLine(x, y ,'w' , 'r' , '#d5c7af' , borderThick)
                }else{
					
                }
            }
        }
    }

    function stokeLine(x, y, flag, dir, color, width){
        var canvas = document.getElementById('ladder_canvas');
        var ctx = canvas.getContext('2d');
        var moveToStart =0, moveToEnd =0, lineToStart =0 ,lineToEnd =0; 
        var eachWidth = widthNum; 
        var eachHeight = heightNum;
        
        if(flag == "w"){
            //가로줄          
            if(dir == "r"){
                ctx.beginPath();
                moveToStart = x * eachWidth ;
                moveToEnd = y * eachHeight ;
                lineToStart = (x+ 1) * eachWidth;
                lineToEnd = y * eachHeight;
                
            }else{
                // dir "l"
                ctx.beginPath();
                moveToStart = x * eachWidth;
                moveToEnd = y * eachHeight;
                lineToStart = (x- 1) * eachWidth;
                lineToEnd = y * eachHeight;
            }
        }else{
            ctx.beginPath();
            moveToStart = x * eachWidth ;
            moveToEnd = y * eachHeight;
            lineToStart = x * eachWidth ;
            lineToEnd = (y+1) * eachHeight;
        }

        ctx.moveTo(moveToStart + (borderThick/2), moveToEnd  + (borderThick/2));
        ctx.lineTo(lineToStart + (borderThick/2), lineToEnd  + (borderThick/2));
        ctx.strokeStyle = color;
        ctx.lineWidth = width;
		ctx.lineCap = 'round';
        ctx.stroke();
        ctx.closePath();
    }

    function drawDefaultLine(){
        var html = '';
        html += '<table>'
         for(var y =0; y < heightNode; y++){
            html += '<tr>';
            for(var x =0; x <widthNode-1 ; x++){
                html += '<td style="width:' + widthNum + 'px; height:' + heightNum + 'px; border-left:'+borderThick+'px solid #d5c7af; border-right:'+borderThick+'px solid #d5c7af;"></td>';
            }
            html += '</tr>';
        }
        html += '</table>'
        ladder.append(html);
    }

    function setRandomNodeData(){
         for(var y =0; y < heightNode; y++){
            for(var x =0; x <widthNode ; x++){
                var loopNode = x + "-" + y;
                var rand = Math.floor(Math.random() * 2);
				if(y == 0){
					rand = 0;
				}
                if(rand == 0){
                    GLOBAL_FOOT_PRINT[loopNode] = {"change" : false , "draw" : false}
                }else{
                    if(x == (widthNode - 1)){
                        GLOBAL_FOOT_PRINT[loopNode] = {"change" : false , "draw" : false} ;    
                    }else{
                        GLOBAL_FOOT_PRINT[loopNode] =  {"change" : true , "draw" : true} ;  ;
                        x = x + 1;
                        loopNode = x + "-" + y;
                        GLOBAL_FOOT_PRINT[loopNode] =  {"change" : true , "draw" : false} ;  ;
                    }
                }
            }
        }
    }

    function setDefaultFootPrint(){
      
        for(var r = 1; r < heightNode; r++){
            for(var column =0; column < widthNode; column++){
                GLOBAL_FOOT_PRINT[column + "-" + r] = false;
            }
        }
    }
    function reSetCheckFootPrint(){

        for(var r = 1; r < heightNode; r++){
            for(var column =0; column < widthNode; column++){
                GLOBAL_CHECK_FOOT_PRINT[column + "-" + r] = false;
            }
        }

    }

    function setDefaultRowLine(){
        for(var y =0; y < heightNode; y++){
            var rowArr = [];
            for(var x =0; x <widthNode ; x++){
                var node = x + "-"+ row;
                rowArr.push(node);
                // 노드그리기
                var left = x * widthNum+1;
                var top = row * heightNum;
                var node = $('<div></div>')
                .attr('class' ,'node')
                .attr('id' , node)
                .attr('data-left' , left)
                .attr('data-top' , top)
                .css({
                    'position' : 'absolute',
                    'left' : left,
                    'top' : top
                });
                ladder.append(node);
             }
             LADDER[row] =  rowArr;
             row++;
        }
    }



});
