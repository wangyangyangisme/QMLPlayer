import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1

Rectangle {
    id: unreadRoot;
    width: 200;
    height: 200;
    color: "gray";

    property date sysDate;
    property var i: 2;  // 星期，手动设置

    signal sigSetEvent();

    FontLoader { id: fontName; source: "../Fonts/方正兰亭纤黑简体.ttf"; }

    Image {
        id: portrait;
        source: "portrait/pic.jpg";
        x: 10;
        y: 20;
        width: 80;
        height: 80;
    }
    Canvas {
        x: 10; y: 20;
        width: 80; height: 80;
        smooth: true;
        antialiasing: true;
        onPaint: {
            var ctx = getContext("2d");
            ctx.lineWidth = 30;
            ctx.beginPath();
            ctx.clearRect(0, 0, width, height);
            ctx.fill();
            ctx.strokeStyle = "gray";
            ctx.beginPath();
            ctx.arc(40, 40, 55, 0, Math.PI*2, false);
            ctx.stroke();
        }
    }

    Text {
        id: name;
        text: "Oliva";
        color: "white";
        font { family: fontName.name; pixelSize: 20 }
        anchors.horizontalCenter: portrait.horizontalCenter;
        y: 105;
    }

    Timer {
        id: ssTimer;
        interval: 1000;
        running: true;
        repeat: true;
        triggeredOnStart: true;
        onTriggered: {
            sysDate =  new Date();
            hour.text = Qt.formatDateTime(sysDate, "hh:mm");
        }
    }
    Text {
        id: hour;
        text: Qt.formatDateTime(sysDate, "hh:mm");
        color: "white";
        font { family: fontName.name; pixelSize: 25 }
        x: 100;
        y: 40;
    }
    Text {
        id: monthday;
        text: Qt.formatDateTime(sysDate, "M")+"月"+Qt.formatDateTime(sysDate, "dd")+"日";
        color: "white";
        font { family: fontName.name; pixelSize: 14 }
        anchors.horizontalCenter: hour.horizontalCenter;
        anchors.top: hour.bottom;
    }
    Text {
        id: lable;
        text: ">";
        color: "white";
        font { family: fontName.name; pixelSize: 15 }
        anchors.left: hour.right;
        anchors.leftMargin: 10;
        y: 55;
    }
    Text {
        id: unreadMessages;
        text: "Unread Messages";
        color: "white";
        font { family: fontName.name; pixelSize: 13 }
        x: 10;
        y: 150;
    }
    Text {
        text: "未读";
        color: "white";
        font { family: fontName.name; pixelSize: 13 }
        x: 10;
        y: 170;
    }
    Text {
        id: unreadNum
        text: "12";
        color: "white";
        font { family: fontName.name; pixelSize: 25 }
        x: 150;
        y: 155;
        MouseArea {
            anchors.fill: parent;
            onClicked: {
                console.log("open messages");
            }
        }
    }

    Canvas {
        anchors.fill: unreadRoot;
        Path {
            id: underLine
            startX: 10;  startY: 140;
            PathLine {x: 10;  y: 140;}
            PathLine {x: 190; y: 140;}
        }
        onPaint: {
            var ctx = getContext("2d");
            ctx.lineWidth = 0.6;
            context.strokeStyle = Qt.rgba(1,1,1,0.6);

            context.path = underLine;
            context.stroke();
        }
    }
}
