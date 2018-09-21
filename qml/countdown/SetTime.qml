import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtGraphicalEffects 1.0

Canvas {
    id: setRoot;
    smooth: true;
    antialiasing: true;


    property date currentTime;
    property var min: "00";
    property var sec: "00";
    signal sigReleasedTimer();
    signal sigStartCountDown(var mm, var ss);
    signal sigPauseCountDown();
    signal sigTimeUp();

    property var r: 150;
    property var preAngle: -Math.PI/2;
    property var lasAngle: -Math.PI/2;
    property var prsAngle: 0.0;
    property var curAngle: 0.0;
    property var varAngle: 0.0;

    property var last : 0.0;
    property var start : 0.0;
    property var canvasGradientactive: false;

    function onSigSetTime() {
        releasedTimer.running = true;
    }

    FontLoader { id: fontName; source: "../Fonts/AgencyFB.ttf"; }

    Canvas {
        id: canvasGradient
        anchors.fill: parent;
        smooth: true;
        antialiasing: true;
        onPaint: {
            var ctx = getContext("2d");
            ctx.lineWidth = 6;
            //ctx.lineCap = "round";

            // Make canvas all white
            //ctx.beginPath();
            ctx.clearRect(0, 0, width, height);
            //ctx.fill();

            var len = 1000;
            //var last = 0, start = 0;
       /*
            while (Math.PI*last/len-Math.PI/2 <= lasAngle) {
                last += len/2000;

                ctx.strokeStyle = Qt.rgba((2*len-last)/(2*len), 1, last/(2*len), 1);
                ctx.beginPath();
                ctx.arc(150, 150, 135, Math.PI*start/len-Math.PI/2, Math.PI*last/len-Math.PI/2, false);
                ctx.stroke();

                start = last;
            }
            if (lasAngle == -Math.PI/2)
                ctx.clearRect(0, 0, width, height);
        */

            var gradient = ctx.createLinearGradient(0, 0, width, height);
            gradient.addColorStop(0.0, Qt.rgba(1, 1, 0, 1));
            gradient.addColorStop(1.0, Qt.rgba(0, 1, 1, 1));
            ctx.strokeStyle = gradient;
            ctx.beginPath();
            ctx.arc(150, 150, 135,  -Math.PI/2, lasAngle, false);
            ctx.stroke();

            canvasGradienttimer.running = false;
        }
    }
    Canvas {
        id: canvasDrag
        anchors.fill: parent;
        smooth: true;
        antialiasing: true;
        onPaint: {
            var ctx = getContext("2d");
            ctx.lineWidth = 2;
            ctx.beginPath();
            ctx.clearRect(0, 0, width, height);
            ctx.fill();
            ctx.strokeStyle = "white";
            ctx.beginPath();
            ctx.arc(r, r, r-1, -Math.PI/2, lasAngle, false);
            ctx.stroke();

            //canvasGradienttimer.running = true;
        }
    }

    Timer{
        id:canvasGradienttimer;
        interval: 200;
        repeat: true;
        onTriggered: {
            //if(canvasGradientactive==true)
            {
                canvasGradient.requestPaint();
            }
        }
    }
/*
    Timer{
        id:canvasDragtimer;
        interval: 100;
        repeat: true;
        onTriggered: {
            if(canvasDragactive==true)
            {
                canvasDrag.requestPaint();
            }
        }
    }
*/
    MouseArea {
        id: slideArea;
        anchors.fill: parent;

        onPressed: {
            countDown.running = false;
            releasedTimer.running = false;
            sigPauseCountDown();
            prsAngle = Math.atan(Math.abs(mouseX-r) / Math.abs(mouseY-r));
            //canvasDragtimer.running = true;
        }

        onPositionChanged: {
            curAngle = Math.atan(Math.abs(mouseX-r) / Math.abs(mouseY-r));

            // curAngle-prsAngle为角度变化量
            if ((mouseY-r < 0 && mouseX - r > 0) || (mouseY-r > 0 && mouseX - r < 0))   // 一、三象限
            {
                lasAngle = preAngle+curAngle-prsAngle;
                varAngle = curAngle-prsAngle;
            }
            if ((mouseY-r > 0 && mouseX - r > 0) || (mouseY-r < 0 && mouseX - r < 0))   // 二、四象限
            {
                lasAngle = preAngle+prsAngle-curAngle;
                varAngle = curAngle-prsAngle;
            }
            if ((mouseY-r == 0 && mouseX - r > 0) || (mouseY-r == 0 && mouseX - r < 0)) // X轴
            {
                lasAngle = preAngle+varAngle;
            }
            if ((mouseY-r > 0 && mouseX - r == 0) || (mouseY-r < 0 && mouseX - r == 0)) // Y轴
            {
                lasAngle = preAngle+varAngle;
            }

            //console.log("(lasAngle+Math.PI/2):", lasAngle+Math.PI/2);

            if((lasAngle+Math.PI/2)>Math.PI*2)
            {
                lasAngle = Math.PI*3/2;
            }
            else
            if((lasAngle+Math.PI/2)<0)
            {
               lasAngle = -Math.PI/2;
            }

            if (lasAngle+Math.PI/2 >= 0 && lasAngle+Math.PI/2 <= Math.PI*2)
            {
                dragCircle.x = Math.sin(lasAngle+Math.PI/2)*r + r - 10;
                dragCircle.y = r - Math.cos(lasAngle+Math.PI/2)*r - 10;

                canvasDrag.requestPaint();
                //canvasGradienttimer.running = false;
                canvasGradient.requestPaint();

                var temp,totalsec,secchange;
                temp = (lasAngle+Math.PI/2)/Math.PI * 180;
                //if(temp>=355)    temp = 360;

                //分四象限加快定时效果
                if(temp<90)
                {
                   secchange = 180/90;
                    totalsec = temp*secchange;
                }
                else
                if(temp<180)
                {
                    secchange = 300/90;
                    totalsec = 180+(temp-90)*secchange;
                }
                else
                if(temp<270)
                {
                    secchange = 600/90;
                    totalsec = 480+(temp-180)*secchange;
                }
                else
                {
                    secchange = 720/90;
                    totalsec = 1080+(temp-270)*secchange;
                }

                min = parseInt(totalsec/60);
                sec = parseInt(totalsec - min*60);

                if(min<10)  min = "0"+min;
                if(sec<10)  sec = "0"+sec;


                prsAngle = curAngle;
                preAngle = lasAngle;

            }
        }
        onReleased: {
            if (min > 0 || sec > 0) {
                sigStartCountDown(min, sec);
                countDown.running = true;
            }
            releasedTimer.running = true;
        }
    }

    Rectangle {
        id: showTime;
        anchors.centerIn: parent;
        width: 230;
        height: 230;
        radius: showTime.width/2;
        color: "gray";
        opacity: 0.1;
    }


    Text {
        id: setTime;
        x: 80;
        y: 90;
        color: "white";
        font { family: fontName.name; pixelSize: 70 }
        text:{ min+":"+sec }
        MouseArea {
            anchors.fill: parent;
            onClicked: {
                if (countDown.running == true) {
                    console.log("pause");
                    if (min > 0 || sec > 0) {
                        sigPauseCountDown();
                        countDown.running = false;
                        releasedTimer.running = true;
                    }
                }
                else {
                    console.log("continue");
                    if (min > 0 || sec > 0) {
                        sigStartCountDown(min, sec);
                        countDown.running = true;
                    }
                    releasedTimer.running = true;
                }
            }
        }
    }
    Timer {
        id: countDown;
        interval: 1000;
        repeat: true;
        onTriggered: {

            var temp = (lasAngle+Math.PI/2)/Math.PI * 180;
            //分四象限倒计时效果
            if(temp<90)
            {
               lasAngle -= Math.PI/180*(90/180);
            }
            else
            if(temp<180)
            {
                lasAngle -= Math.PI/180*(90/300);
            }
            else
            if(temp<270)
            {
                lasAngle -= Math.PI/180*(90/600);
            }
            else
            {
                lasAngle -= Math.PI/180*(90/720);
            }

            //lasAngle -= Math.PI/180;
            preAngle = lasAngle;
            dragCircle.x = Math.sin(lasAngle+Math.PI/2)*r + r - 10;
            dragCircle.y = r - Math.cos(lasAngle+Math.PI/2)*r - 10;
            canvasGradient.requestPaint();
            canvasDrag.requestPaint();
/*
            var totalsec = min*60 + sec;
            if(--totalsec<=0)
            {
                totalsec = 0;
                countDown.stop();
                sigTimeUp();
            }

            min = parseInt(totalsec/60);
            sec = parseInt(totalsec - min*60);

            if(min<10)  min = "0"+min;
            if(sec<10)  sec = "0"+sec;
*/


            sec -= 1;
            if (sec < 0 && min !=0) {
                sec = 59;
                min -= 1;
                if (min >= 0 && min <= 9)
                    min = "0"+min;
            }

            if (sec >= 0 && sec <= 9)
                sec = "0"+sec;

            if(min == 0 && sec == 0)
            {
                min = "00";
                sec = "00";
                countDown.stop();
                sigTimeUp();
            }
        }
    }
    Timer {
        id: releasedTimer;
        interval: 5000;
        onTriggered:{
            sigReleasedTimer();
        }
    }
    Text {
        anchors.left: setTime.right;
        anchors.leftMargin: 5;
        anchors.bottom: setTime.bottom;
        anchors.bottomMargin: 10;
        color: "white";
        font { family: fontName.name; pixelSize: 30 }
        text: "s";
    }
    Image {
        id: timeImage
        x: 110;
        y: 185;
        width: 25;
        height: 25;
        source: "images/nowtime.png"
    }
    Text {
        id: systemTime
        anchors.left: timeImage.right;
        anchors.verticalCenter: timeImage.verticalCenter;
        anchors.leftMargin: 10;
        color: "white";
        font { family: fontName.name; pixelSize: 25 }
        text: '';
    }
    Timer {
        id: refreshTime;
        interval: 1000;
        running: true;
        repeat: true;
        triggeredOnStart: true;
        onTriggered:{
            currentTime = new Date();
            systemTime.text = Qt.formatDateTime(currentTime, "hh:mm");
        }
    }
    Text {
        id: lable
        anchors.top: parent.bottom;
        anchors.horizontalCenter: parent.horizontalCenter;
        anchors.topMargin: 10;
        color: "white";
        font { family: "Microsoft Yahei"; pixelSize: 15 }
        text: "顺时针拖动至目标时间后，松手即可";
    }

    Rectangle {
        id: littleCircle;
        x: 144;
        y: -5;
        width: 12;
        height: 12;
        radius: littleCircle.width/2;
        color: "black";
        border.color: "white";
        border.width: 2;
    }
    Rectangle {
        id: dragCircle;
        x: 140;
        y: -10;
        width: 20;
        height: 20;
        radius: 10;
        color: "white";
    }
}
