(function (global, factory) {
    if (typeof define === "function" && define.amd) {
        define(["exports"], factory);
    } else if (typeof exports !== "undefined") {
        factory(exports);
    } else {
        var mod = {
            exports: {}
        };
        factory(mod.exports);
        global.prod_graph = mod.exports;
    }
})(this, function (exports) {
    "use strict";

    Object.defineProperty(exports, "__esModule", {
        value: true
    });
    var param = {
        modelno: gModelData.gModelno,
        minprice: gModelData.gMinPrice,
        showType: 3
    };
    var paramHandler = exports.paramHandler = {
        set: function set(prop, value) {
            param[prop] = value;
            graphPromise().then(prodGraphView);
            return true;
        },
        init: function init() {
            param["modelno"] = gModelData.gModelno;
            param["minprice"] = gModelData.gMinPrice;
            param["showType"] = 3;
        }
    };

    var graphPromise = exports.graphPromise = function graphPromise() {
        return new Promise(function (resolve, reject) {
            $.ajax({
                type: "POST",
                url: "/wide/api/product/prodGraph.jsp",
                data: param,
                dataType: "JSON",
                success: function success(result) {
                    resolve(result);
                },
                error: function error(err) {
                    reject(err);
                }
            });
        });
    };

    var prodGraphView = exports.prodGraphView = function prodGraphView(json) {
        if (ie8Chk) {
            $("#vip_graph_container").addClass("no-data");
            $("#vip_graph_container").html("<p>\uC9C0\uC6D0\uD558\uC9C0 \uC54A\uB294 \uBE0C\uB77C\uC6B0\uC800\uC785\uB2C8\uB2E4.</p>");
            return false;
        }
        if (json.success) {
            if (json.total == 0) {
                $("#vip_graph_container").addClass("no-data");
                $("#vip_graph_container").html("<p>(\uCD5C\uC2E0\uBAA8\uB378\uB85C \uCD94\uC138 \uC815\uBCF4\uAC00 \uC5C6\uC2B5\uB2C8\uB2E4.)</p>");
            } else {
                var maxGraphTick = 2;
                var graphData = json.data;

                var graphDataCnt = graphData.graphDataCnt;
                var graphShowType = graphData.graphShowType;

                var graphCnt = graphData.showGraphCnt;
                var graphMaxPrice = graphData.showMaxPrice;
                var graphMinPrice = graphData.showMinPrice;
                var graphDataList = graphData.graphDataList;

                var exceptCase = false;

                if (graphDataCnt < 12 && graphShowType != "1") {
                    $("#prod_graph").find(".pgraph__filter").hide();
                } else {
                    $("#prod_graph").find(".pgraph__filter").show();
                }
                if (graphShowType == 1) {
                    maxGraphTick = 1;
                } else {
                    if (graphCnt > 6) {
                        maxGraphTick = 2;
                    } else {
                        maxGraphTick = 1;
                    }
                }
                if (graphDataList.length > 0) {
                    if (graphCnt > 0) {
                        var graphMinPriceDate = "";
                        var graphMaxPriceDate = "";

                        var graphCurPrice = 0;
                        var graphCurPriceDate = "";
                        var mallTotalData = [];
                        var mallXData = [];

                        $.each(graphDataList, function (index, listData) {
                            var date = listData.date;
                            var date_text = listData.date_text;
                            var labelLoc = listData.labelLoc;
                            var price = listData.price;

                            if (labelLoc == "h") {
                                graphMaxPriceDate = date_text;
                            } else if (labelLoc == "m") {
                                graphMinPriceDate = date_text;
                            } else if (labelLoc == "ne") {
                                if (graphCnt == 1 && index == 0) {
                                    graphCurPriceDate = "(최신모델로 추세 정보가 없음) (현재)";
                                } else {
                                    graphCurPriceDate = date_text;
                                }
                                graphCurPrice = price;
                            }

                            if (graphCnt == 1 && index == 0) {
                                mallXData.push("(최신모델로 추세 정보가 없음) (현재)");
                            } else {
                                mallXData.push(date_text);
                            }
                            if (graphDataList.length == index + 1) {
                                var tempLastPrice = "";
                                tempLastPrice = tempLastPrice + "{";
                                tempLastPrice = tempLastPrice + "\"y\": " + graphCurPrice + ",";
                                if (graphCurPrice == graphMinPrice) {
                                    //맨 마지막 데이터가 최저가일 때 
                                    tempLastPrice = tempLastPrice + "\"marker\": { \"fillColor\" : \"#d43031\" }, ";
                                } else {
                                    tempLastPrice = tempLastPrice + "\"marker\": { \"fillColor\" : \"#0073be\" }, ";
                                }
                                tempLastPrice = tempLastPrice + "\"dataLabels\": { ";

                                if (graphDataList.length == 1 && index + 1 == 1) {
                                    //    tempLastPrice = tempLastPrice + "\"x\": -140,"; // 최신모델로 가격정보 1개만 있을 경우 마커 위 가격 강제 이동
                                }
                                tempLastPrice = tempLastPrice + "\"style\": { ";
                                tempLastPrice = tempLastPrice + "\"color\": \"#0073be\" ";
                                tempLastPrice = tempLastPrice + "}";
                                tempLastPrice = tempLastPrice + "}";
                                tempLastPrice = tempLastPrice + "}";
                                mallTotalData.push(JSON.parse(tempLastPrice));
                            } else {
                                var tmpObj = new Object();
                                tmpObj.y = price;
                                tmpObj.marker = new Object();
                                tmpObj.dataLabels = new Object();
                                if (labelLoc == "h") {
                                    tmpObj.marker.fillColor = "#30a7f7";
                                } else if (labelLoc == "m") {
                                    tmpObj.marker.fillColor = "#d43031";
                                }
                                mallTotalData.push(tmpObj);
                            }
                        });
                        var chart = Highcharts.chart('vip_graph_container', {
                            chart: {
                                width: $("#prod_graph .monthpraph").outerWidth(),
                                height: $("#prod_graph .monthpraph").outerHeight() + 50,
                                backgroundColor: '#f9f9f9',
                                type: 'spline',
                                marginRight: 10
                            },
                            credits: { // 왼쪽 하단                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                라벨 제거
                                enabled: false
                            },
                            title: {
                                text: null
                            },
                            subtitle: {
                                text: ''
                            },
                            xAxis: {
                                tickWidth: 0,
                                categories: mallXData, // 하단 달짜 지정
                                labels: {
                                    step: maxGraphTick,
                                    style: {
                                        tickPixelInterval: 50,
                                        fontSize: "10px"
                                    }
                                }
                            },
                            plotOptions: {
                                series: {
                                    animation: {
                                        duration: 2000
                                    },
                                    marker: { // 점
                                        enabled: true,
                                        radius: 3

                                    }
                                },
                                spline: {
                                    color: '#cccccc'
                                }
                            },
                            yAxis: {
                                title: null,
                                opposite: true,
                                offset: 10,
                                gridLineWidth: 0.5
                            },
                            tooltip: {
                                style: {
                                    fontSize: "10px",
                                    fontWeight: ''
                                },
                                formatter: function formatter() {
                                    if (this.x.indexOf("(최신모델로 추세 정보가 없음)") > -1) {
                                        this.x = this.x.replace("(최신모델로 추세 정보가 없음)", "");
                                    }
                                    if (graphCnt == 1 || exceptCase) {
                                        return false;
                                    } else {
                                        return "<b>" + this.x + "</b> :" + this.y.format() + "원";
                                    }
                                }
                            },
                            series: [{
                                name: '',
                                data: mallTotalData,
                                lineWidth: 1,
                                dataLabels: {
                                    enabled: true,
                                    formatter: function formatter() {
                                        if (this.x === graphMaxPriceDate) {
                                            return "<span style=\"color : #30a7f7\">" + graphMaxPrice.format() + "</span>";
                                        } else if (this.x === graphMinPriceDate) {
                                            return "<span style=\"color : #d43031\">" + graphMinPrice.format() + "</span>";
                                        } else if (this.x === graphCurPriceDate) {
                                            return "<span style=\"color : " + (this.y == graphMinPrice ? "#d43031" : "#0073be") + " \">" + graphCurPrice.format() + "</span>";
                                        }
                                        return null;
                                    },
                                    style: {
                                        fontSize: '9px',
                                        fontWeight: ''
                                    }
                                }
                            }]

                        }); // End : Highcharts.chart

                        $(".highcharts-yaxis-labels").hide(); // y축 라벨 감추기
                        $(".highcharts-legend").hide(); // 하단 라벨 감추기
                        $(".highcharts-exporting-group").hide(); // 우측 상단 옵션 기능 감추기
                        $("#vip_graph_container").removeClass("no-data");
                    }
                    $("#prod_graph").find(".pgraph__filter li").unbind().click(function (e) {
                        e.preventDefault();
                        $("#vip_graph_container").empty();
                        $(this).find("input:radio").prop("checked", true);
                        paramHandler.set("showType", $(this).find("input:radio").val());
                    });
                }
            }
        }
    };
});