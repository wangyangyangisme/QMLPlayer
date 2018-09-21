import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1

Rectangle {
    id:lightctrl;
    width: 400
    height: 500
    smooth: true;
    color: "gray";
    radius: 5;

    property double lred:0.0;
    property double lgreen: 0.0;
    property double lblue: 0.0;

    signal isActivePaint(var IsActive,var x,var y);
    signal paintCircle(var x,var y);

    FontLoader { id: fontName; source: "../Fonts/方正兰亭纤黑简体.ttf"; }

    function onSendbodercolor(red,green,blue)
    {
        lred = red;
        lgreen = green;
        lblue = blue;
    }

    Slider{
        id:lightbrightslider;
        x:50
        y:100
        width:300;
        height:20;
        maximumValue: 100.0;
        stepSize:1.0;
        value:0.0;
        orientation: Qt.Horizontal;
        style:SliderStyle{
            groove: Rectangle{
                implicitWidth: 300;
                implicitHeight: 20;
                color:"black";
                radius:8;
            }

            handle: Rectangle{
                anchors.centerIn: parent;
                color:"white";
                width: 50;
                height: 25;
                radius: 12;
            }
        }

        onValueChanged: {
            console.log("lightbright:",value);
            //台灯亮度调节值

        }


    }

    Text {
                text: "off";
                color: "white";
                font { family: fontName.name; pixelSize: 30; bold: true;  }
                x: lightbrightslider.x;
                y: lightbrightslider.y-35;
          }

    Text {
        text: "on";
        color: "white";
        font { family: fontName.name; pixelSize: 30; bold: true;  }
        x: lightbrightslider.x+265;
        y: lightbrightslider.y-35;
    }


    /*
      RGB:
      red:    255   0   0
      yellow: 255 255   0
      green:    0 255   0
      blue:     0   0 255
    */

    Canvas {
        id: canvasGradient
        width: 300;
        height: 300;
        y: 150;
        anchors.horizontalCenter: parent.horizontalCenter;
        smooth: true;
        antialiasing: true;

        onPaint: {
            var ctx = getContext("2d");
            ctx.lineWidth = 5;

            // Make canvas all white
            ctx.beginPath();
            ctx.clearRect(0, 0, width, height);
            ctx.fill();

            var len = 1000;
            var last = 0, start = 0;
            while (last <= len*2) {
                last += len/2000;


                if (last <= len/2)  // 四象限red->yellow
                    ctx.strokeStyle = Qt.rgba(1, last/(len/2), 0, 1);
                if (last > len/2 && last <= len)    // 三象限yellow->green
                    ctx.strokeStyle = Qt.rgba((len-last)/(len/2), 1, 0, 1);
                if (last > len && last <= len*3/2)  // 二象限green->blue
                    ctx.strokeStyle = Qt.rgba(0, (len*3/2-last)/(len/2), (last-len)/(len/2), 1);
                if (last > len*3/2 && last <= len*2)// 一象限blue->red
                    ctx.strokeStyle = Qt.rgba((last-len*3/2)/(len/2), 0, (len*2-last)/(len/2), 1);

                ctx.beginPath();
                ctx.arc(150, 150, 135, Math.PI*start/len, Math.PI*last/len, false);
                ctx.stroke();

                start = last;
            }
        }

        DynamicPaintCircle{
           id:lightcolorslider;
           anchors.fill: parent
           r:150;
           dragcirclewidth:30;
           dragcircleheight:30;
           dragcirclecolor:"white";
           paintvisible: false;

           Component.onCompleted: {
               //连接信号
               lightctrl.isActivePaint.connect(lightcolorslider.onIsActivePaint);
               lightctrl.paintCircle.connect(lightcolorslider.onPaintCircle);
               lightcolorslider.sendbodercolor.connect(lightctrl.onSendbodercolor);
           }
        }
    }

    //200ms定时器采样
    Timer{
        id:sampleRGBForlight;
        interval: 200;
        repeat: true;
        onTriggered: {
            //console.log("r=",lightctrl.lred,"g=",lightctrl.lgreen,"b=",lightctrl.lblue);
            //台灯颜色rgb
        }
    }

    MouseArea{
        id: slideArea;
        anchors.fill: canvasGradient;

        onPressed: {
           isActivePaint(true,mouseX,mouseY);
            sampleRGBForlight.running = true;
        }

        onPositionChanged: {
            paintCircle(mouseX,mouseY);
        }

        onReleased: {
            isActivePaint(false,mouseX,mouseY);
            sampleRGBForlight.running = false;
        }

    }
}

