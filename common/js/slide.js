function Slide(canvas,film,leftbtn,rightbtn,boxwidth,boxheight,pixelgap,timegap,direction,moveCnt){
	this.canvas 	= canvas;
	this.film 		= film;
	this.leftbtn 	= leftbtn;
	this.rightbtn 	= rightbtn;
	this.moveCnt	= (moveCnt == null ? 1 : moveCnt);
	this.boxwidth 	= boxwidth*this.moveCnt;
	this.boxheight 	= boxheight;
	this.pixelgap 	= pixelgap;
	this.timegap 	= timegap;
	this.direction 	= direction;	//0: left, 1: right, 2: up, 3: down
		
	this.canvaswidth = parseInt(this.canvas.style.width,10);
	this.canvasheight = parseInt(this.canvas.style.height,10);
	this.boxcnt = Math.ceil(film.childNodes.length/this.moveCnt);
	this.setTimeOut = null;
	this.lcurrent = null; //cursor for moveleft
	this.rcurrent = null; //cursor for moveright
	this.ucurrent = null; //cursor for moveup
	this.dcurrent = null; //cursor for movedown
}
Slide.prototype =
{
	Init: function () {
		for (var i = this.boxcnt; i >= 1; i--) {
			if (this.boxwidth * i <= this.canvaswidth){
				this.lcurrent = i;
				break;
			}
		}
		for (var i = this.boxcnt; i >= 1; i--) {
			if (this.boxheight * i <= this.canvasheight){
				this.ucurrent = i;
				break;
			}
		}
		this.rcurrent = 1;
		this.dcurrent = 1;
	},
	Run: function () {
		if (this.film == false) { return; }
		if (this.direction == 0) { this.MoveLeft(); }
		if (this.direction == 1) { this.MoveRight(); }
		if (this.direction == 2) { this.MoveUp(); }
		if (this.direction == 3) { this.MoveDown(); }
	},
	MoveQuick: function (movecnt) {
		if (this.direction==0 || this.direction==1){
			this.film.style.left = -this.boxwidth*movecnt;
			this.lcurrent = this.lcurrent + movecnt;
			this.rcurrent = this.rcurrent + movecnt;
			if (this.lcurrent >= this.boxcnt){
				this.rightbtn.style.cursor 	= "normal";
				this.rightbtn.style.display = "none";
			}else{
				this.rightbtn.style.display = "";
			}
			if (this.rcurrent <= 1){
				this.leftbtn.style.cursor  = "normal";
				this.leftbtn.style.display = "none";
				
			}else{
				this.leftbtn.style.display = "";
			}
		}else{
			this.film.style.top = -this.boxheight*movecnt;
			this.ucurrent = this.ucurrent + movecnt;
			this.dcurrent = this.dcurrent + movecnt;
			if (this.ucurrent >= this.boxcnt){
				this.rightbtn.style.cursor 	= "normal";
				this.rightbtn.style.display = "none";
			}else{
				this.rightbtn.style.display = "";
			}
			if (this.dcurrent <= 1){
				this.leftbtn.style.cursor  = "normal";
				this.leftbtn.style.display = "none";
			}else{
				this.leftbtn.style.display = "";
			}
		}
	},
	MoveLeft: function () {
		var This = this;
		window.clearTimeout(this.setTimeOut);

		if (this.lcurrent < this.boxcnt){
			this.film.style.left = this.film.offsetLeft - this.pixelgap;
		}
		if ((this.boxwidth * (this.lcurrent+1)) + this.film.offsetLeft <= this.canvaswidth){
			if (this.lcurrent + 1 >= this.boxcnt){
				this.lcurrent = this.boxcnt;
				this.rightbtn.style.cursor = "normal";				
				this.rightbtn.style.display = "none";

				if (this.lcurrent = this.boxcnt){
					this.leftbtn.style.cursor = "pointer";
					this.leftbtn.style.display = "";
				}
			}else{
				this.lcurrent = this.lcurrent + 1;
				this.leftbtn.style.cursor = "pointer";
				this.leftbtn.style.display = "";
			}
			this.rcurrent = this.rcurrent + 1;
		}else{
			if (this.lcurrent < this.boxcnt){
				this.setTimeOut = window.setTimeout(function () { This.Run(); },this.timegap);
			}
		}
	},
	MoveRight: function () {
		var This = this;
		window.clearTimeout(this.setTimeOut);

		if (this.rcurrent > 1) {
			this.film.style.left = this.film.offsetLeft + this.pixelgap;
		}
		if (this.boxwidth * (this.rcurrent - 2) >= Math.abs(this.film.offsetLeft)){
			if (this.rcurrent - 1 <= 1){
				this.rcurrent = 1;
				this.leftbtn.style.cursor  = "normal"; 
				this.leftbtn.style.display = "none";
				
				if (this.rcurrent <= 1){
					this.rightbtn.style.cursor = "pointer";
					this.rightbtn.style.display = "";
				}
			}else{
				this.rcurrent = this.rcurrent - 1;
				this.rightbtn.style.cursor = "pointer";
				this.rightbtn.style.display = "";
			}
			this.lcurrent = this.lcurrent - 1;
		}else{
			if (this.rcurrent > 1) {
				this.setTimeOut = window.setTimeout(function () { This.Run(); },this.timegap);
			}
		}
	},
	MoveUp: function () {
		var This = this;
		window.clearTimeout(this.setTimeOut);

		if (this.ucurrent < this.boxcnt){
			this.film.style.top = this.film.offsetTop - this.pixelgap;
		}
		if ((this.boxheight * (this.ucurrent+1)) + this.film.offsetTop <= this.canvasheight){
			if (this.ucurrent + 1 >= this.boxcnt){
				this.ucurrent = this.boxcnt;
				this.rightbtn.style.display = "none";
				document.body.style.cursor = "normal";
			}else{
				this.ucurrent = this.ucurrent + 1;
				this.leftbtn.style.display = "";
			}
			this.dcurrent = this.dcurrent + 1;
		}else{
			if (this.ucurrent < this.boxcnt){
				this.setTimeOut = window.setTimeout(function () { This.Run(); },this.timegap);
			}
		}
	},
	MoveDown: function () {
		var This = this;
		window.clearTimeout(this.setTimeOut);

		if (this.dcurrent > 1) {
			this.film.style.top = this.film.offsetTop + this.pixelgap;
		}
		if (this.boxheight * (this.dcurrent - 2) >= Math.abs(this.film.offsetTop)){
			if (this.dcurrent - 1 <= 1){
				this.dcurrent = 1;
				this.leftbtn.style.display = "none";
				document.body.style.cursor = "normal";
			}else{
				this.dcurrent = this.dcurrent - 1;
				this.rightbtn.style.display = "";
			}
			this.ucurrent = this.ucurrent - 1;
		}else{
			if (this.dcurrent > 1) {
				this.setTimeOut = window.setTimeout(function () { This.Run(); },this.timegap);
			}
		}
	}
}