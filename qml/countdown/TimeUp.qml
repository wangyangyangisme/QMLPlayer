import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1

Rectangle {
    id: upRoot;
    color: "transparent";
    smooth: true;
    antialiasing: true;

    property date currentTime;
    signal sigReturn();

    function onSigTimeUp() {
        circleTimer1.running = true;
        circleTimer2.running = true;
    }

    FontLoader { id: fontName; source: "../Fonts/AgencyFB.ttf"; }

    Timer {
        id: circleTimer1;
        interval: 10;
        repeat: false;
        triggeredOnStart: false;
        onTriggered: {
            circleAnimation1.running = true;
        }
    }
    Timer {
        id: circleTimer2;
        interval: 1000;
        repeat: false;
        triggeredOnStart: false;
        onTriggered: {
            circleAnimation2.running = true;
        }
    }

    Rectangle {
        id: circle;
        color: "transparent";
        border.width: 1;
        border.color: "white";
        anchors.centerIn: parent;
        width: 220;
        height: 220;
        radius: circle.width/2;
        opacity: 1;
    }
    Rectangle {
        id: circle1;
        color: "transparent";
        border.width: 1;
        border.color: "white";
        anchors.centerIn: parent;
        width: 220;
        height: 220;
        radius: circle1.width/2;
        opacity: 0;
    }
    Rectangle {
        id: circle2;
        color: "transparent";
        border.width: 1;
        border.color: "white";
        anchors.centerIn: parent;
        width: 220;
        height: 220;
        radius: circle1.width/2;
        opacity: 0;
    }

    ParallelAnimation {
        id: circleAnimation1
        loops: Animation.Infinite
        PropertyAnimation {
            target: circle1;
            property: "scale";
            from: 1;
            to: 2;
            duration: 2000;
        }
        PropertyAnimation {
            target: circle1;
            property: "opacity";
            from: 1;
            to: 0;
            duration: 2000;
        }
    }




    ParallelAnimation {
        id: circleAnimation2
        loops: Animation.Infinite
        PropertyAnimation {
            target: circle2;
            property: "scale";
            from: 1;
            to: 2;
            duration: 2000;
        }
        PropertyAnimation {
            target: circle2;
            property: "opacity";
            from: 1;
            to: 0;
            duration: 2000;
        }
    }

    Rectangle {
        id: background;
        anchors.centerIn: parent;
        width: 200;
        height: 200;
        radius: background.width/2;
        color: "gray";
        opacity: 0.1;

        MouseArea {
            anchors.fill: parent;
            onReleased: {
                circleTimer1.running = false;
                circleTimer2.running = false;
                sigReturn();
            }
        }
    }

    Text {
        id: setTime;
        x: 125;
        y: 150;
        color: "white";
        font { family: fontName.name; pixelSize: 50 }
        text: "Time's up";
    }
    Image {
        id: timeImage
        x: 170;
        y: 220;
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
        id: lable;
        anchors.top: background.bottom;
        anchors.topMargin: 15;
        anchors.horizontalCenter: background.horizontalCenter;
        color: "white";
        font { family: "Microsoft Yahei"; pixelSize: 15 }
        text: "时间到啦";
    }
}
