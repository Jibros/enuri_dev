function Rolling(canvas,width,height,direction,pixelgap,timegap,idlegap)
{
	this.canvas = canvas;
	this.width = width;
	this.height = height;
	this.direction = direction;	//0: left, 1: right, 2: up, 3: down
	this.pixelgap = pixelgap;
	this.timegap = timegap;
	this.idlegap = idlegap;
	this.box = document.createElement("DIV");
	this.box.style.width = this.width + "px";
	this.box.style.height = this.height + "px";
	this.box.style.overflow = "hidden";
	this.setTimeOut = null;
	this.current = null;
	this.next = null;
}

Rolling.prototype =
{
	Init: function () {
		var This = this;
		this.box.onmouseover = function () { window.clearTimeout(This.setTimeOut); }
		this.box.onmouseout = function () { This.setTimeOut = window.setTimeout(function () { This.Run(); },This.timegap); }
		this.canvas.appendChild(this.box);
		this.box.style.position = "absolute";
		for (var i = 0; i < this.box.childNodes.length; i++) {
			this.box.childNodes[i].style.position = "absolute";
			if (i > 0) {
				if (this.direction == 0 || this.direction == 1) {
					this.box.childNodes[i].style.left = (this.box.childNodes[i - 1].offsetLeft + this.box.childNodes[i - 1].offsetWidth) + "px";
				} else if (this.direction == 2 || this.direction == 3) {
					this.box.childNodes[i].style.top = (this.box.childNodes[i - 1].offsetTop + this.box.childNodes[i - 1].offsetHeight) + "px";
				}
			}
			if (i == this.box.childNodes.length - 1) {
				if (this.direction == 1) {
					this.box.childNodes[i].style.left = -this.box.childNodes[i].offsetWidth + "px";
				} else if (this.direction == 3) {
					this.box.childNodes[i].style.top = -this.box.childNodes[i].offsetHeight + "px";
				}
			}
		}
	},
	Run: function () {
		if (this.box.hasChildNodes() == false) { return; }
		if (this.direction == 0) { this.moveLeft(); }
		if (this.direction == 1) { this.moveRight(); }
		if (this.direction == 2) { this.moveUp(); }
		if (this.direction == 3) { this.moveDown(); }
	},
	moveLeft: function () {
		var This = this;
		if (this.current == null) { this.current = 0; }
		window.clearTimeout(this.setTimeOut);
		for (var i = 0; i < this.box.childNodes.length; i++) {
			this.box.childNodes[i].style.left = (this.box.childNodes[i].offsetLeft - this.pixelgap) + "px";
		}
		this.next = (this.current + 1 >= this.box.childNodes.length) ? 0 : this.current + 1;
		if (this.box.childNodes[this.next].offsetLeft <= 0) {
			var nextPosition = 0;
			for (var i = 1; i < this.box.childNodes.length; i++) { nextPosition += this.box.childNodes[i].offsetWidth; }
			this.box.childNodes[this.current].style.left = nextPosition + "px";
			this.current = (this.current + 1 >= this.box.childNodes.length) ? 0 : this.current + 1;
			this.setTimeOut = window.setTimeout(function () { This.Run(); },this.idlegap);
		} else {
			this.setTimeOut = window.setTimeout(function () { This.Run(); },this.timegap);
		}
	},
	moveRight: function () {
		var This = this;
		if (this.current == null) { this.current = this.box.childNodes.length - 1; }
		window.clearTimeout(this.setTimeOut);
		for (var i = 0; i < this.box.childNodes.length; i++) {
			this.box.childNodes[i].style.left = (this.box.childNodes[i].offsetLeft + this.pixelgap) + "px";
		}
		this.next = (this.current - 1 < 0) ? this.box.childNodes.length - 1 : this.current - 1;
		if (this.box.childNodes[this.current].offsetLeft >= 0) {
			this.box.childNodes[this.next].style.left = -this.box.childNodes[this.next].offsetWidth + "px";
			this.current = (this.current - 1 < 0) ? this.box.childNodes.length - 1 : this.current - 1;
			this.setTimeOut = window.setTimeout(function () { This.Run(); },this.idlegap);
		} else {
			this.setTimeOut = window.setTimeout(function () { This.Run(); },this.timegap);
		}
	},
	moveUp: function () {
		var This = this;
		if (this.current == null) { this.current = 0; }
		window.clearTimeout(this.setTimeOut);
		for (var i = 0; i < this.box.childNodes.length; i++) {
			this.box.childNodes[i].style.top = (this.box.childNodes[i].offsetTop - this.pixelgap) + "px";
		}
		this.next = (this.current + 1 >= this.box.childNodes.length) ? 0 : this.current + 1;
		if (this.box.childNodes[this.next].offsetTop <= 0) {
			var nextPosition = 0;
			for (var i = 1; i < this.box.childNodes.length; i++) { nextPosition += this.box.childNodes[i].offsetHeight; }
			this.box.childNodes[this.current].style.top = nextPosition + "px";
			this.current = (this.current + 1 >= this.box.childNodes.length) ? 0 : this.current + 1;
			this.setTimeOut = window.setTimeout(function () { This.Run(); },this.idlegap);
		} else {
			this.setTimeOut = window.setTimeout(function () { This.Run(); },this.timegap);
		}
	},
	moveDown: function () {
		var This = this;
		if (this.current == null) { this.current = this.box.childNodes.length - 1; }
		window.clearTimeout(this.setTimeOut);
		for (var i = 0; i < this.box.childNodes.length; i++) {
			this.box.childNodes[i].style.top = (this.box.childNodes[i].offsetTop + this.pixelgap) + "px";
		}
		this.next = (this.current - 1 < 0) ? this.box.childNodes.length - 1 : this.current - 1;
		if (this.box.childNodes[this.current].offsetTop >= 0) {
			this.box.childNodes[this.next].style.top = -this.box.childNodes[this.next].offsetHeight + "px";
			this.current = (this.current - 1 < 0) ? this.box.childNodes.length - 1 : this.current - 1;
			this.setTimeOut = window.setTimeout(function () { This.Run(); },this.idlegap);
		} else {
			this.setTimeOut = window.setTimeout(function () { This.Run(); },this.timegap);
		}
	}
}