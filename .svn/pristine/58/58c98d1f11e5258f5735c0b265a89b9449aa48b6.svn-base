(function(angular) {
  'use strict';
angular.module('dragModule', [])
  .directive('mainDraggable', ['$document', function($document) {
    return {
      link: function(scope, element, attr) {
        var startX = 0, startY = 0, x = 0, y = 0;

        element.css({
         position: 'relative',
         border: '1px solid red',
         backgroundColor: 'lightgrey',
         cursor: 'pointer'
        });

        element.on('mousedown', function(event) {
          // Prevent default dragging of selected content
          event.preventDefault();
          startX = event.pageX - x;
          startY = event.pageY - y;
          $document.on('mousemove', mousemove);
          $document.on('mouseup', mouseup);
        });

        function mousemove(event) {
          y = event.pageY - startY;
          x = event.pageX - startX;
          element.css({
            top: y + 'px',
            left:  x + 'px'
          });
        }

        function mouseup() {
          $document.off('mousemove', mousemove);
          $document.off('mouseup', mouseup);
        }
      }
    };
  }])
  
  
  .directive('subDraggable', ['$document', function($document) {
    return {
      link: function(scope, element, attr) {
        var startX = 0, startY = 0, x = 0, y = 0;

        element.css({
         position: 'relative',
         border: '1px solid red',
         backgroundColor: 'lightgrey',
         cursor: 'pointer'
        });

        element.on('mousedown', function(event) {
          // Prevent default dragging of selected content
          event.preventDefault();
          startX = event.pageX - x;
          startY = event.pageY - y;
          $document.on('mousemove', mousemove);
          $document.on('mouseup', mouseup);
        });

        function mousemove(event) {
          y = event.pageY - startY;
          x = event.pageX - startX;
          element.css({
            top: y + 'px',
            left:  x + 'px'
          });
        }

        function mouseup() {
          $document.off('mousemove', mousemove);
          $document.off('mouseup', mouseup);
        }
      }
    };
  }]);


})(window.angular);






function getRandom() {
    return Math.floor(Math.random() * 100);
}

function getData(count) {
    var data = [];

    for(var i = 0; i < count; i++) {
        data[i] = {
            value1: getRandom(),
            value2: getRandom(),
            value3: getRandom(),
            value4: getRandom(),
            value5: getRandom()
        };
    }

    return data;
}

jui.ready([ "chart.builder" ], function(builder) {
    // return;
    var data1 = [];
        data2 = getData(150);

    var chart1 = builder("#chart1", {
        width: 800,
        height : 200,
        axis : {
            x : {
                type : "date",
                domain : [ new Date() - 1000 * 60 * 5, new Date() ],
                interval : 1,				// 단위 시간에 대한 간격 설정
                realtime : "minutes",		// 단위 시간 설정
                format : "hh:mm",
                key : "time",
                line : 'solid'
            },
            y : {
                type : "range",
                domain : [ 0, 100 ]
            }
        },
        brush : {
            type : "scatter",
            target : [ "value1", "value2", "value3" ],
            useEvent : false
        },
        event : {
            click : function(obj, e) {
                alert("click");
            }
        },
        render : false
    });

    var chart2 = builder("#chart2", {
        width: 800,
        height : 200,
        axis : {
            x : {
                type : "dateblock",
                domain : [ new Date() - 1000 * 60 * 5, new Date() ],
                interval : 1,				// 단위 시간에 대한 간격 설정
                realtime : "minutes",		// 단위 시간 설정
                format : "hh:mm"
            },
            y : {
                type : "range",
                domain : [ 0, 100 ]
            }
        },
        brush : {
            type : "line",
            target : [ "value1", "value2", "value3", "value4", "value5" ],
            useEvent : false
        },
        render : false
    });

    setInterval(function() {
        var end = new Date(),
            start = new Date() - 1000 * 60 * 5,
            domain = [ start, end ];

        if(data1.length > 300) {
            data1.shift();
            console.log("remove data: " + data1.length);
        }

        data1.push({
            value1: getRandom(),
            value2: getRandom(),
            value3: getRandom(),
            time: end
        });

        chart1.axis(0).updateGrid("x", { domain : domain });
        chart1.axis(0).update(data1);
        chart1.render();

        data2.shift();
        data2.push({
            value1: getRandom(),
            value2: getRandom(),
            value3: getRandom(),
            value4: getRandom(),
            value5: getRandom()
        });

        chart2.axis(0).updateGrid("x", { domain : domain });
        chart2.axis(0).update(data2);
        chart2.render();
    }, 1000);
});