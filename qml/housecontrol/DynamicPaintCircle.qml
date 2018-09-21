import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtGraphicalEffects 1.0

Item {
    id:paintcircleroot;
    width:r*2;
    height:r*2;
    smooth: true;
    antialiasing: true;

    //画圆属性值
    property var r: 150;
    property var preAngle: -Math.PI/2;
    property var lasAngle: -Math.PI/2;
    property var prsAngle: 0.0;
    property var curAngle: 0.0;
    property var varAngle: 0.0;

    property var running: false;
    property var paintx: 0.0;
    property var painty: 0.0;

    property var dragcirclewidth: 0;
    property var dragcircleheight: 0;
    property var dragcirclecolor: "white";

    property var red:0.0;
    property var green: 0.0;
    property var blue: 0.0;

    property var paintvisible: true;    //是否需要画线

    signal sendbodercolor(var red,var green,var blue);

    function onIsActivePaint(IsActive,x,y)
    {
        running = IsActive;
        if(running == true)
        {
           paintx = x;
           painty = y;
            prsAngle = Math.atan(Math.abs(paintx-r) / Math.abs(painty-r));
        }
        else
        {
            paintx = 0.0;
            painty = 0.0;
        }
    }

    function onPaintCircle(x,y)
    {
        if(running == true)
        {
            paintx = x;
            painty = y;
            curAngle = Math.atan(Math.abs(paintx-r) / Math.abs(painty-r));

            // curAngle-prsAngle为角度变化量
            if ((painty-r < 0 && paintx - r > 0) || (painty-r > 0 && paintx - r < 0))   // 一、三象限
            {
                lasAngle = preAngle+curAngle-prsAngle;
                varAngle = curAngle-prsAngle;
            }
            if ((painty-r > 0 && paintx - r > 0) || (painty-r < 0 && paintx - r < 0))   // 二、四象限
            {
                lasAngle = preAngle+prsAngle-curAngle;
                varAngle = curAngle-prsAngle;
            }
            if ((painty-r == 0 && paintx - r > 0) || (painty-r == 0 && paintx - r < 0)) // X轴
            {
                lasAngle = preAngle+varAngle;
            }
            if ((painty-r > 0 && paintx - r == 0) || (painty-r < 0 && paintx - r == 0)) // Y轴
            {
                lasAngle = preAngle+varAngle;
            }

            if(lasAngle+Math.PI/2 >= Math.PI*2) lasAngle =  -Math.PI/2;

            if (lasAngle+Math.PI/2 >= 0 && lasAngle+Math.PI/2 <= Math.PI*2)
            {
                dragCircle.x = Math.sin(lasAngle+Math.PI/2)*r + r - 10;
                dragCircle.y = r - Math.cos(lasAngle+Math.PI/2)*r - 10;

                canvasGradient.requestPaint();

                prsAngle = curAngle;
                preAngle = lasAngle;
            }

        }
    }

    Canvas {
        id: canvasGradient
        anchors.fill: parent;
        smooth: true;
        antialiasing: true;
        onPaint: {
            var ctx = getContext("2d");
            ctx.lineWidth = 5;
            //ctx.lineCap = "round";

            // Make canvas all white
            ctx.beginPath();
            ctx.clearRect(0, 0, width, height);
            ctx.fill();

            var len = 1000;
            var start = 0;
            var last = 0;
            while ((Math.PI*last/len <= lasAngle+Math.PI/2)&&(last <= len*2)){
                last += len/2000;

                if (last <= len/2)  // 四象限red->yellow
                {
                    red = 1;green=last/(len/2);blue=0;
                }
                else
                if (last > len/2 && last <= len)    // 三象限yellow->green
                {
                    red = (len-last)/(len/2);green=1;blue=0;

                }
                else
                if (last > len && last <= len*3/2)  // 二象限green->blue
                {
                    red = 0;green=(len*3/2-last)/(len/2);blue=(last-len)/(len/2);

                }
                else
                if (last > len*3/2 && last <= len*2)// 一象限blue->red
                {
                    red = (last-len*3/2)/(len/2);green=0;blue=(len*2-last)/(len/2);

                }

                //sendbodercolor(red, green, blue);
                if(paintvisible == true)
                {
                    ctx.strokeStyle = Qt.rgba(red, green, blue, 1);
                    ctx.beginPath();
                    ctx.arc(150, 150, 135, Math.PI*start/len-Math.PI/2, Math.PI*last/len-Math.PI/2, false);
                    ctx.stroke();
                }

                start = last;
            }


        }
    }


    Rectangle {
        id: dragCircle;
        //x: parent.x+r-width/2-5;
        //y: parent.y-width/2+5;
        x:r-width/2
        y:0-width/2
        width: dragcirclewidth;
        height: dragcircleheight;
        radius: width/2;
        color: dragcirclecolor;
    }
}

