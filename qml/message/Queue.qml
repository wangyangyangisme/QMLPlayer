import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1

Item {
    id: queueRoot;
    x: 50;
    y: 300;
    width: 200;
    height: 500;

    FontLoader { id: fontName; source: "../Fonts/方正兰亭纤黑简体.ttf"; }

    Rectangle {
        id: onlyUnread;
        width: 200;
        height: 50;
        color: "lightgray";
        Text {
            text: "Only Unread";
            color: "black";
            font { family: fontName.name; pixelSize: 20 }
            x: 10; y: 15;
        }
        Text {
            text: "12";
            color: "blue";
            font { family: fontName.name; pixelSize: 25 }
            x: 155; y: 10;
        }
    }

    ListView {
        id: messageView;
        anchors.top: onlyUnread.bottom;
        anchors.right: onlyUnread.right;
        width: 200;
        height: 450;
        z: -1;

        model: messageModel;
        delegate: messageDelegate;
    }
    ListModel {
        id: messageModel;
        ListElement {
            name: "Oliva";
            portrait: "portrait/pic.jpg";
            time: "18:30";
            date: "5月23日";
            bool: true;
        }
        ListElement {
            name: "Oliva";
            portrait: "portrait/pic.jpg";
            time: "18:30";
            date: "5月23日";
            bool: false;
        }
        ListElement {
            name: "Oliva";
            portrait: "portrait/pic.jpg";
            time: "18:30";
            date: "5月23日";
            bool: false;
        }
    }
    Component {
        id: messageDelegate;
        Rectangle {
            id: message;
            width: 200;
            height: 150;
            color: "gray";

            MouseArea {
                anchors.fill: parent;
                onClicked: {
                    if (yellowRec.visible == true || openMessage.visible == false) {
                        yellowRec.visible = false;
                        queueRoot.width = 600;
                        openMessage.visible = true;
                    }
                    else {
                        queueRoot.width = 200;
                        openMessage.visible = false;
                    }
                }
            }

            Image {
                id: portraitImage
                source: portrait;
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
                id: alias;
                text: name;
                color: "white";
                font { family: fontName.name; pixelSize: 20 }
                anchors.horizontalCenter: portraitImage.horizontalCenter;
                y: 105;
            }
            Text {
                id: hour;
                text: time;
                color: "white";
                font { family: fontName.name; pixelSize: 25 }
                x: 100;
                y: 40;
            }
            Text {
                id: monthday;
                text: date;
                color: "white";
                font { family: fontName.name; pixelSize: 14 }
                anchors.horizontalCenter: hour.horizontalCenter;
                anchors.top: hour.bottom;
            }
            Rectangle {
                id: yellowRec;
                x: 170;
                y: 10;
                width: 10;
                height: 10;
                radius: 5;
                color: "yellow";
                visible: bool;
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
            Canvas {
                anchors.fill: parent;
                Path {
                    id: underLine
                    startX: 10;  startY: 140;
                    PathLine {x: 10;  y: 140;}
                    PathLine {x: 190; y: 140;}
                }
                onPaint: {
                    var ctx = getContext("2d");
                    ctx.lineWidth = 0.6;
                    context.strokeStyle = Qt.rgba(1,1,1,1);

                    context.path = underLine;
                    context.stroke();
                }
            }
        }
    }
    Image {
        id: plus
        source: "portrait/plus.png"
        anchors.top: messageView.bottom;
        anchors.horizontalCenter: messageView.horizontalCenter;
        anchors.topMargin: 10;
    }


    Rectangle {
        id: openMessage;
        x: 220;
        y: 20;
        width: 400;
        height: 400;
        visible: false;
        color: "gray";

        Image {
            id: image
            source: "portrait/pic.jpg";
            x: 20;
            y: 10;
            width: 60;
            height: 60;
            Canvas {
                anchors.fill: parent
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
                    ctx.arc(30, 30, 40, 0, Math.PI*2, false);
                    ctx.stroke();
                }
            }
        }
        Text {
            id: alias;
            text: "Oliva";
            color: "white";
            font { family: fontName.name; pixelSize: 15 }
            anchors.horizontalCenter: image.horizontalCenter;
            anchors.top: image.bottom;
        }
        Text {
            id: hour;
            text: "18:30";
            color: "white";
            font { family: fontName.name; pixelSize: 15 }
            x: 330;
            y: 25;
        }
        Text {
            id: monthday;
            text: "5月23日";
            color: "white";
            font { family: fontName.name; pixelSize: 13 }
            anchors.horizontalCenter: hour.horizontalCenter;
            anchors.top: hour.bottom;
        }
        Canvas {
            anchors.fill: parent;
            Path {
                id: underLine
                startX: 100; startY: 40;
                PathLine {x: 100; y: 40;}
                PathLine {x: 300; y: 40;}
            }
            onPaint: {
                var ctx = getContext("2d");
                ctx.lineWidth = 0.6;
                context.strokeStyle = Qt.rgba(1,1,1,1);

                context.path = underLine;
                context.stroke();
            }
        }

        Image {
            id: happy;
            source: "portrait/happy.png";
            anchors.centerIn: parent;
        }

        Rectangle {
            id: messageTime;
            x: 170;
            y: 350;
            width: 200;
            height: 30;
            radius: 5;
            Text {
                id: timeText;
                text: "16";
                color: "black";
                font { family: fontName.name; pixelSize: 20 }
                x: 10;
                y: 5;
            }
            Text {
                text: "s";
                color: "black";
                font { family: fontName.name; pixelSize: 15 }
                anchors.left: timeText.right;
                anchors.leftMargin: 3;
                y: 9;
            }
            Text {
                text: "点击播放";
                color: "black";
                font { family: fontName.name; pixelSize: 15 }
                x: 130
                y: 6;
                opacity: 0.5;
            }
        }
    }
}
