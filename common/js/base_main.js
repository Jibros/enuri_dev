(function (context, $, undefined) {
  "use strict";

    var enuriUI = context.enuriUI || (context.enuriUI = {}),
        GUI = enuriUI.GUI || (enuriUI.GUI = {});

    var toString = Object.prototype.toString,
        hasOwn = Object.prototype.hasOwnProperty,
        doc = context.document,
        emptyFn = function () {};

    if (typeof Function.prototype.bind === 'undefined') {
        Function.prototype.bind = function () {
            var __method = this,
                args = Array.prototype.slice.call(arguments),
                object = args.shift();
            return function () {
                var local_args = args.concat(Array.prototype.slice.call(arguments));
                if (this !== window) { local_args.push(this); }
                return __method.apply(object, local_args);
            };
        };
    }

    GUI.namespace = function (name, obj) {
        if (typeof name !== 'string') {
            obj && (name = obj);
            return name;
        }
        var root = context,
            names = name.split('.'),
            isSet = arguments.length === 2;

        if(isSet) {
            for(var i = -1, item; item = names[++i]; ){
                root = root[item] || (root[item] = (i === names.length - 1 ? obj : {}));
            }
        } else {
            for(var i = -1, item; item = names[++i]; ){
                if(item in root) { root = root[item] }
                else { throw Error(name + '은(는) 정의되지 않은 네임스페이스입니다.'); }
            }
        }

        return root;
    };

    GUI.define = function (name, object, isExecFn) {
        if (typeof name !== 'string') {
            object = name; name = '';
        }

        var root = enuriUI,
            names = name ? name.replace(/^visor\.?/, '').split('.') : [],
            ln = names.length - 1,
            leaf = names[ln];

        if (isExecFn !== false && typeof object === 'function' && !hasOwn.call(object, 'classType')) {
            object = object.call(root);
        }

        for (var i = 0; i < ln; i++) {
            root = root[names[i]] || (root[names[i]] = {});
        }

        (leaf && (root[leaf] ? $.extend(root[leaf], object) : (root[leaf] = object))) || $.extend(root, object);
    };

    GUI._prefix = 'enuriUI.';
    GUI.use = function(name) {
        var obj = GUI.namespace(GUI._prefix + name);
        if(GUI.isFunction(obj) && !hasOwn.call(obj, 'classType')) {
            obj = obj();
        }
        return obj;
    };

    GUI.define('GUI',{
        $doc: $(document),
        $win: $(window),
        emptyFn: emptyFn,
        tmpNode: doc.createElement('div'),
        tmpInput: doc.createElement('input'),
        isTouch: !!('ontouchstart' in window),
        hasOwn: function (obj, name) {
            return hasOwn.call(obj, name);
        },
        isEmpty: function (value, allowEmptyString) {
            return (value === null) || (value === undefined) || (!allowEmptyString ? value === '' : false) || (this.isArray(value) && value.length === 0);
        },
        isArray: function (value) {
            return value && (value.constructor === Array || !!value.push);
        },
        isDate: function (value) {
            return toString.call(value) === '[object Date]';
        },
        isObject: (toString.call(null) === '[object Object]') ? function (value) {
            return value !== null && value !== undefined && toString.call(value) === '[object Object]' && value.ownerDocument === undefined;
        } : function (value) {
            return toString.call(value) === '[object Object]';
        },
        isFunction: (typeof document !== 'undefined' && typeof document.getElementsByTagName('body') === 'function') ? function (value) {
            return toString.call(value) === '[object Function]';
        } : function (value) {
            return typeof value === 'function';
        },
        isNumber: function (value) {
            return typeof value === 'number' && isFinite(value);
        },
        isNumeric: function (value) {
            return !isNaN(parseFloat(value)) && isFinite(value);
        },
        isString: function (value) {
            return typeof value === 'string';
        },
        isBoolean: function (value) {
            return typeof value === 'boolean';
        },
        isElement: function (value) {
            return value ? value.nodeType === 1 : false;
        },
        isTextNode: function (value) {
            return value ? value.nodeName === "#text" : false;
        },
        isDefined: function (value) {
            return typeof value !== 'undefined';
        },
        toArray: function (value) {
            return Array.prototype.slice.apply(value, Array.prototype.slice.call(arguments, 1));
        },
        getUniqId: function () {
            return Number(String(Math.random() * 10).replace(/\D/g, ''));
        },
        getUniqKey: (function() {
            var uniqKey = 1;
            return function() {
                return (uniqKey += 1);
            };
        }())
    });

    GUI.define('GUI.array',{
        map: function (obj, cb) {
            var results = [];
            if (!GUI.isArray(obj) || !GUI.isFunction(cb)) { return results; }

            for(var i =0, len = obj.length; i < len; i++) {
                results[results.length] = cb(obj[i], i, obj);
            }
            return results;
        },
        shuffle: function (obj) {
            var rand,
                index = 0,
                shuffled = [],
                number = GUI.number;

            $.each(obj, function (k, value) {
                rand = number.random(index++);
                shuffled[index - 1] = shuffled[rand], shuffled[rand] = value;
            });
            return shuffled;
        },
        filter: function (obj, cb) {
            var results = [];
            if (!GUI.isArray(obj) || !GUI.isFunction(cb)) { return results; }
            for(var i =0, len = obj.length; i < len; i++) {
                cb(obj[i], i, obj) && (results[results.length] = obj[i]);
            }
            return results;
        },
        include: function (arr, value, b) {
            return enuriUI.GUI.array.indexOf(arr, value, b) > -1;
        },
        indexOf: function (arr, value, b) {
            for (var i = 0, len = arr.length; i < len; i++) {
                if( (b !== false && arr[i] === value) || (b === false && arr[i] == value) ) { return i; }
            }
            return -1;
        },
        remove: function (value, index) {
            if (!enuriUI.GUI.isArray(value)) { return value; }
            return value.slice(index, 1);
        },
        max: function( array ){
            return Math.max.apply( Math, array );
        },
        min: function( array ){
            return Math.min.apply( Math, array );
        }
    });

    GUI.define('GUI.object', {

        keys: function (obj) {
            var results = [];
            $.each(obj, function (k) {
                results[results.length] = k;
            });
            return results;
        },
        values: function (obj) {
            var results = [];
            $.each(obj, function (k, v) {
                results[results.length] = v;
            });
            return results;
        },
        map: function(obj, cb) {
            if (!GUI.isObject(obj) || !GUI.isFunction(cb)){ return obj; }
            var results = {};
            for(var k in obj) {
                if (obj.hasOwnProperty(k)) {
                    results[k] = cb(obj[k], k, obj);
                }
            }
            return results;
        },
        hasItems: function (value) {
            if (!enuriUI.GUI.isObject(value)) {
                return false;
            }

            for (var key in value) {
                if (value.hasOwnProperty(key)) {
                    return true;
                }
            }
            return false;
        },
        toQueryString: function (params, isEncode) {
            if (typeof params === 'string') {
                return params;
            }
            var queryString = '',
                encode = isEncode === false ? function (v) {
                    return v;
                } : encodeURIComponent;

            $.each(params, function (key, value) {
                if (typeof (value) === 'object') {
                    $.each(value, function (innerKey, innerValue) {
                        if (queryString !== '') {
                            queryString += '&';
                        }
                        queryString += encode(key) + '[' + encode(innerKey) + ']=' + encode(innerValue);
                    });
                } else if (typeof (value) !== 'undefined') {
                    if (queryString !== '') {
                        queryString += '&';
                    }
                    queryString += encode(key) + '=' + encode(value);
                }
            });
            return queryString;
        },
        traverse: function (obj) {
            var result = {};
            $.each(obj, function (index, item) {
                result[item] = index;
            });
            return result;
        },
        remove: function (value, key) {
            if (!GUI.isObject(value)) { return value; }
            value[key] = null;
            delete value[key];
            return value;
        }
    });


    GUI.define('GUI.Class', function () {
        var isFn = enuriUI.GUI.isFunction,
            emptyFn = enuriUI.GUI.emptyFn,
            include = enuriUI.GUI.array.include,
            ignoreNames = ['superclass', 'members', 'statics'];

        function wrap(k, fn, supr) {
            return function () {
                var tmp = this.supr, undef, ret;

                this.supr = supr.prototype[k];
                ret = {}.fabricatedUndefined;
                try {
                    ret = fn.apply(this, arguments);
                } finally {
                    this.supr = tmp;
                }
                return ret;
            };
        }

        function process(what, o, supr) {
            for (var k in o) {
                if (o.hasOwnProperty(k)) {
                    what[k] = isFn(o[k]) && isFn(supr.prototype[k]) ? wrap(k, o[k], supr) : o[k];
                }
            }
        }

        return function (attr) {
            var supr, statics, mixins, singleton, Parent, instance;

            if (isFn(attr)) {
                attr = attr();
            }

            function constructor() {
                if (singleton) {
                    if (instance) {
                        return instance;
                    } else {
                        instance = this;
                    }
                }
                if(this.constructor.onClassCreate) {
                    this.constructor.onClassCreate();
                    delete this.constructor.onClassCreate;
                }

                if (this.initialize) {
                    this.initialize.apply(this, arguments);
                } else {
                    supr.prototype.initialize && supr.prototype.initialize.apply(this, arguments);
                }
            }

            function Class() {
                constructor.apply(this, arguments);
            }

            supr = attr.$extend || emptyFn;
            singleton = attr.$singleton || false;
            statics = attr.$statics || false;
            mixins = attr.$mixins || false;

            Parent = emptyFn;
            Parent.prototype = supr.prototype;

            Class.prototype = new Parent;
            Class.prototype.constructor = Class;
            Class.superclass = supr.prototype;
            Class.classType = Class;

            if (singleton) {
                Class.getInstance = function () {
                    if (!instance) {
                        instance = new Class();
                    }
                    return instance;
                };
            }

            Class.prototype.suprMethod = function(name) {
                var args = [].slice.call(arguments, 1);
                return supr.prototype[name].apply(this, args);
            };

            Class.prototype.proxy = function (func) {
                var _this = this;
                return function () {
                    func.apply(_this, [].slice.call(arguments));
                };
            };

            Class.mixins = function (o) {
                if (!o.push) { o = [o]; }
                $.each(o, function (index, value) {
                    $.each(value, function (key, item) {
                        Class.prototype[key] = item;
                    });
                });
            };
            mixins && Class.mixins.call(Class, mixins);

            Class.members = function (o) {
                process(Class.prototype, o, supr);
            };
            attr && Class.members.call(Class, attr);

            Class.statics = function (o) {
                o = o || {};
                for (var k in o) {
                    if (!include(ignoreNames, k)) {
                        Class[k] = o[k];
                    }
                }
                return Class;
            };
            Class.statics.call(Class, supr);
            statics && Class.statics.call(Class, statics);
            return Class;
        };
    });

})(window, jQuery);


(function (context, $, GUI) {
    "use strict";

    var $win = GUI.$win,
        $doc = GUI.$doc,
        Class = GUI.Class,
        dateUtil = GUI.date,
        stringUtil = GUI.string,
        numberUtil = GUI.number,
        View;

    GUI.define('GUI.EVENTS', {
        ON_BEFORE_SHOW: 'beforeshow',
        ON_SHOW: 'show',
        ON_BEFORE_HIDE: 'beforehide',
        ON_HIDE: 'hide'
    });


    GUI.define('GUI', {
        bindjQuery: function (Klass, name) {
            var old = $.fn[name];

            $.fn[name] = function (options) {
                var a = arguments,
                    args = [].slice.call(a, 1),
                    me = this,
                    returnValue = this;

                this.each(function() {
                    var $this = $(this),
                        methodValue,
                        instance;

                    if( !(instance = $this.data(name)) || (a.length === 1 && typeof options !== 'string')) {
                        instance && (instance.destroy(), instance = null);
                        $this.data(name, (instance = new Klass(this, $.extend({}, $this.data(), options), me)));
                    }

                    if (typeof options === 'string' && GUI.isFunction(instance[options])) {
                        try {
                            methodValue = instance[options].apply(instance, args);
                        } catch(e) {}

                        if (methodValue !== undefined) {
                            returnValue = methodValue;
                            return false;
                        }
                    }
                });
                return returnValue;
            };

            $.fn[name].noConflict = function() {
                $.fn[name] = old;
                return this;
            };
        }
    });


    GUI.define('GUI.Listener', function () {
        var Listener = Class({
            initialize: function () {
                this._listeners = $({});
            },
            on: function () {
                var lsn = this._listeners;
                lsn.on.apply(lsn, arguments);
                return this;
            },
            once: function () {
                var lsn = this._listeners;
                lsn.once.apply(lsn, arguments);
                return this;
            },
            off: function () {
                var lsn = this._listeners;
                lsn.off.apply(lsn, arguments);
                return this;
            },
            trigger: function () {
                var lsn = this._listeners;
                lsn.trigger.apply(lsn, arguments);
                return this;
            }
        });

        return Listener;
    });


    GUI.define('GUI.PubSub', function () {

        var PubSub = new GUI.Listener();
        PubSub.attach = PubSub.on;
        PubSub.unattach = PubSub.off;

        return PubSub;
    });


    GUI.define('GF.View', function () {
        var isFn = enuriUI.GUI.isFunction,
            execObject = function(obj, ctx) {
                return isFn(obj) ? obj.call(ctx) : obj;
            };

        var View = Class({
            $statics: {
                _instances: []
            },
            initialize: function (el, options) {
                options || (options = {});

                var me = this,
                    eventPattern = /^([a-z]+) ?([^$]*)$/i,
                    moduleName;

                if (!me.name){
                    throw new Error('클래스의 이름이 없습니다');
                }

                moduleName = me.moduleName = me.name.replace(/^[A-Z]/, function(s) { return s.toLowerCase(); });
                me.$el = el instanceof jQuery ? el : $(el);
                if(options.rebuild === true) {
                    try { me.$el.data(moduleName).destroy(); } catch(e){}
                    me.$el.removeData(moduleName);
                } else {
                    if (me.$el.data(moduleName) ) {
                        return false;
                    }
                }

                if (me.$el.hasClass('disabled') || me.$el.attr('data-readony') === 'true' || me.$el.attr('data-disabled') === 'true') {
                    return false;
                }

                View._instances.push(me);
                var superClass = me.constructor.superclass;

                me.el = me.$el[0];
                me.options = $.extend({}, superClass.defaults, me.defaults, options);
                me._uid = enuriUI.GUI.getUniqKey();
                me._eventNamespace = '.' + me.name + '_' + me._uid;
                me.subviews = {};

                me.options.selectors = $.extend({},  execObject(superClass.selectors, me), execObject(me.selectors, me), execObject(me.options.selectors, me));
                $.each(me.options.selectors, function (key, value) {
                    if (typeof value === 'string') {
                        me['$' + key] = me.$el.find(value);
                    } else if (value instanceof jQuery) {
                        me['$' + key] = value;
                    } else {
                        me['$' + key] = $(value);
                    }
                });

                me.options.events = $.extend({}, execObject(me.events, me), execObject(me.options.events, me));
                $.each(me.options.events, function (key, value) {
                    if (!eventPattern.test(key)) { return false; }

                    var name = RegExp.$1,
                        selector = RegExp.$2,
                        args = [name],
                        func = isFn(value) ? value : (isFn(me[value]) ? me[value] : enuriUI.GUI.emptyFn);

                    if (selector) { args[args.length] = $.trim(selector); }

                    args[args.length] = function () {
                        func.apply(me, arguments);
                    };

                    me.on.apply(me, args);
                });

                $.each(me.options.on || {}, function (key, value) {
                    me.on(key, value);
                });

                $.each(me.options, function (key, value) {
                    if (!isFn(value)) { return; }

                    var m = key.match(/^on([a-z]+)$/i);
                    if (m) {
                        me.on((m[1] + "").toLowerCase(), value);
                    }
                });
            },

            destroy: function () {
                var me = this;

                me.$el.removeData(me.moduleName);
                me.$el.off();
                $.each(me.subviews, function(key, item) {
                    item.destroy && item.destroy();
                });
            },
            setOption: function(name, value) {
                this.options[name] = value;
            },
            getOption: function(name, def) {
                return (name in this.options && this.options[name]) || def;
            },
            option: function(name, value) {
                if (typeof value === 'undefined') {
                    return this.getOption(name);
                } else {
                    this.setOption(name, value);
                    this.on('optionchange', [name, value]);
                }
            },
            _generateEventNamespace: function(eventNames) {
                if (eventNames instanceof $.Event) {
                    return eventNames;
                }

                var me = this,
                    m = (eventNames || "").match( /^(\w+)\s*$/ );
                if(!m) {
                    return eventNames;
                }

                var name, tmp = [];
                for(var i = 1, len = m.length; i < len; i++) { name = m[i];
                    if (!name) { continue; }
                    if (name.indexOf('.') === -1) {
                        tmp[tmp.length] = name + me._eventNamespace;
                    } else {
                        tmp[tmp.length] = name;
                    }
                }
                return tmp.join(' ');
            },
            getEventNamespace: function() {
                return this._eventNamespace;
            },
            offEvents: function(){
                this.$el.off(this.getEventNamespace());
            },
            on: function() {
                var args = [].slice.call(arguments);
                args[0] = this._generateEventNamespace(args[0]);

                this.$el.on.apply(this.$el, args);
                return this;
            },
            off: function() {
                var args = [].slice.call(arguments);
                this.$el.off.apply(this.$el, args);
                return this;
            },
            one: function() {
                var args = [].slice.call(arguments);
                args[0] = this._generateEventNamespace(args[0]);

                this.$el.one.apply(this.$el, args);
                return this;
            },
            trigger: function() {
                var args = [].slice.call(arguments);
                this.$el.trigger.apply(this.$el, args);
                return this;
            },
            triggerHandler: function() {
                var args = [].slice.call(arguments);
                this.$el.triggerHandler.apply(this.$el, args);
                return this;
            },
            instance: function() {
                return this;
            },
            getElement: function(){
                return this.$el;
            }
        });
        return View;
    });
	GUI.define('GUI', {
        bindjQuery: function (Klass, name) {
            var old = $.fn[name];

            $.fn[name] = function (options) {
                var a = arguments,
                    args = [].slice.call(a, 1),
                    me = this,
                    returnValue = this;

                this.each(function() {
                    var $this = $(this),
                        methodValue,
                        instance;

                    if( !(instance = $this.data(name)) || (a.length === 1 && typeof options !== 'string')) {
                        instance && (instance.destroy(), instance = null);
                        $this.data(name, (instance = new Klass(this, $.extend({}, $this.data(), options), me)));
                    }

                    if (typeof options === 'string' && GUI.isFunction(instance[options])) {
                        try {
                            methodValue = instance[options].apply(instance, args);
                        } catch(e) {}

                        if (methodValue !== undefined) {
                            returnValue = methodValue;
                            return false;
                        }
                    }
                });
                return returnValue;
            };
        }
    });

})(window, jQuery, enuriUI.GUI);
