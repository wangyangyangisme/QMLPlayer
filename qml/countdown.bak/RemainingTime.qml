import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1

Rectangle {
    id: remRoot;
    width: 300;
    height: 150;
    color: Qt.rgba(1,1,1,0);

    property var min: "00";
    property var sec: "00";
    signal sigSetTime();
    signal sigTimeUp();

    FontLoader { id: fontName; source: "../Fonts/AgencyFB.ttf"; }

    function onSigStartCountDown(mm, ss) {
        min = mm;
        sec = ss;
        countDown.running = true;
    }
    function onSigPauseCountDown() {
        countDown.running = false;
    }

    Image {
        id: hourglassImage;
        width: 35;
        height: 70;
        anchors.topMargin: 15;
        anchors.leftMargin: 5;
        anchors.top: parent.top;
        anchors.left: parent.left;
        source: "images/remainingtime.png";
    }

    Text {
        id: remainingTimeShow;
        anchors.verticalCenter: hourglassImage.verticalCenter;
        anchors.left: hourglassImage.right;
        anchors.leftMargin: 30;
        color: "white";
        font { family: fontName.name; pixelSize: 100 }
        text: min+":"+sec;

        MouseArea {
            id: remainingTimeText
            anchors.fill: parent;
            drag.target: remRoot;
            onReleased: {
                sigSetTime();
            }
        }
    }
    Text {
        x: 290; y: 25;
        opacity: 0.5;
        text: ">"; color: "white"; font { family: fontName.name; pixelSize: 40 }
    }
    Timer {
        id: countDown;
        interval: 1000;
        repeat: true;
        onTriggered: {
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
                countDown.stop();
                sigTimeUp();
            }
        }
    }

    Canvas {
        anchors.fill: parent;
        Path {
            id: underLine
            startX: 0; startY: 105;
            PathLine {x: 0;   y: 105;}
            PathLine {x: 300; y: 105;}
        }
        onPaint: {
            var ctx = getContext("2d");
            ctx.lineWidth = 0.6;
            context.strokeStyle = Qt.rgba(1,1,1,0.6);

            context.path = underLine;
            context.stroke();
        }
    }

    Text {
        id: remainingTimeTextE;
        anchors.bottomMargin: 12;
        anchors.bottom: parent.bottom;
        anchors.left: parent.left;
        color: "white";
        font { family: fontName.name; pixelSize: 20 }
        text: "Remaining Time";
    }
    Text {
        id: remainingTimeTextC;
        anchors.bottomMargin: 12;
        anchors.bottom: parent.bottom;
        anchors.right: parent.right;
        color: "white";
        font { family: fontName.name; pixelSize: 20 }
        text: "剩余时间";
    }
}
