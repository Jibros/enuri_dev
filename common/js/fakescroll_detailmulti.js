function getBrowserName(){
	if (navigator.userAgent.toLowerCase().indexOf('msie')!=-1){
		return "msie";
	}
	if (navigator.userAgent.toLowerCase().indexOf('msie 6')!=-1){
		return "msie6";
	}	
	if (navigator.userAgent.toLowerCase().indexOf('msie 7')!=-1){
		return "msie7";
	}		
	if (navigator.userAgent.toLowerCase().indexOf('firefox')!=-1){
		return "firefox";
	}		
	if (navigator.userAgent.toLowerCase().indexOf('opera')!=-1){
		return "opera";
	}			
	if (navigator.userAgent.toLowerCase().indexOf('chrome')!=-1){
		return "chrome";
	}
}
function FakeScroll(tso,fso,sa,rh,rl,rt,mup){
	this.targetScroll = tso;//��¥ ��ũ�� ����� �Ǵ� ������Ʈ
	this.fakeScroll = fso;//��¥ ��ũ���� ���� �ܰ� ������Ʈ
	this.scrollArea = sa;//��¥ ��ũ���� �����̴� ����
	this.revisionHeight = rh; //��¥ ��ũ�� ������ ���� ������
	this.revisionLeft = rl; //��¥ ��ũ�� left ������
	this.revisionTop = rt; //��¥ ��ũ�� top ������
	this.show = function(){
		if (this.targetScroll){
			if (this.targetScroll.offsetHeight < this.targetScroll.scrollHeight){
				this.fakeScroll.style.display = "";
				if (this.targetScroll.offsetHeight + this.revisionHeight > 0 ){
					this.scrollArea.style.height = this.targetScroll.offsetHeight + this.revisionHeight+"px";
				}
				this.fakeScroll.style.left = (parseInt(this.targetScroll.style.width,10) + parseInt(this.revisionLeft))+"px";
				this.fakeScroll.style.top = (Position.cumulativeOffset(this.targetScroll)[1] + this.revisionTop)+"px";
			}
		}
	};
	this.resizeHeight = function(){
		if (this.targetScroll){
			if (this.targetScroll.offsetHeight + this.revisionHeight > 0 ){
				this.scrollArea.style.height = this.targetScroll.offsetHeight + this.revisionHeight+"px";
			}
		}
	}
	this.moveScroll = function(cmnt){
		this.targetScroll.scrollTop = cmnt*(this.targetScroll.scrollHeight - this.targetScroll.offsetHeight);
	}
	var timerScroll = null;
	this.AddUpDownEventListener = function (vscroll,up,down,fson){
		this.virScroll = vscroll;
		up.onmousedown = function(){
			timerScroll = setInterval(fson+".afterOverScrollUp()",80);
		}
		up.onmouseup = function(){
			clearTimeout(timerScroll);
		}		
		up.onmouseout = function(){
			clearTimeout(timerScroll);
		}
			
		down.onmousedown = function(){
			timerScroll = setInterval(fson+".afterOverScrollDown()",80);
		}
		down.onmouseup = function(){
			clearTimeout(timerScroll);
		}		
		down.onmouseout = function(){
			clearTimeout(timerScroll);
		}						
	}
	this.AddWheelEventListner = function(vscroll,ts){
		function fakeWheelEffect(){
			vscroll.setValue(ts.scrollTop/(ts.scrollHeight - ts.offsetHeight));
		}	
		if (ts.addEventListener && getBrowserName() !="chrome" ){/** DOMMouseScroll is for mozilla and don't support chrome */
			ts.addEventListener('DOMMouseScroll', fakeWheelEffect, false);
		}else{
			ts.onmousewheel = fakeWheelEffect;
		}
	}
	this.afterOverScrollUp = function(){
		if (this.virScroll.value > 0 ){
			var varScrollValue = this.virScroll.value
			this.virScroll.setValue(varScrollValue - 0.1);
		}
	}
	this.afterOverScrollDown = function(){
		if (this.virScroll.value < 1 ){
			var varScrollValue = this.virScroll.value
			this.virScroll.setValue(varScrollValue + 0.1);
		}
	}
	//�ܺο��� ��¥ ��ũ�ѹ��� ��ġ�� ���� �Ҷ�
	this.repositonFakeScrollBar = function(vscroll,ts){
		vscroll.setValue(ts.scrollTop/(ts.scrollHeight - ts.offsetHeight));
	}
	//������ â�� �������� ������ ��¥ ��ũ�� ���� ó��
	this.setScrollBarHeight = function (){
		if (this.virScroll){
			this.virScroll.trackLength = this.scrollArea.offsetHeight;
		}	
	}	
	this.setScrollBarHeightToZero = function (){
		if (this.virScroll){
			this.virScroll.trackLength = this.scrollArea.offsetHeight;
			this.virScroll.setValue(0);
		}	
	}		
}