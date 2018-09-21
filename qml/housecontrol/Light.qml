import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtGraphicalEffects 1.0

Item {
    id: lightRoot;
    smooth: true;
    antialiasing: true;
    width: 400;
    height: 500;
    x: 100;
    y: 200;

    property bool bedroomLight: false;      // 卧室灯
    property bool studyroomLight: false;    // 书房大灯
    property bool doorLight: false;         // 门厅灯
    property bool childLight: false;        // 儿童房灯
    property bool interestLight: false;     // 情趣灯
    property bool studyroomLamp: false;     // 书房台灯
    property bool bathroomLight: false;     // 浴室灯
    property bool livingLight: false;       // 客厅小灯

    FontLoader { id: fontName; source: "../Fonts/方正兰亭纤黑简体.ttf"; }

    Text {
        id: smartText;
        text: "Smart Light";
        color: "white";
        font { family: fontName.name; pixelSize: 20 }
    }
    Rectangle {
        id: smartRec;
        anchors.top: smartText.bottom;
        anchors.topMargin: 5;
        width: 450;
        height: 150;
        color: "transparent";
        border.color: "white";
        Row {
            x: 10;
            y: 10;
            width: 430;
            height: 130;
            spacing: 10;
            Rectangle{
                width: 100;
                height: 130;
                color: "#363636";
                Text {
                    text: "卧室灯";
                    color: "white";
                    font { family: fontName.name; pixelSize: 18 }
                    anchors.horizontalCenter: parent.horizontalCenter;
                    y: 10;
                }
                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter;
                    y: 40;
                    width: 80;
                    height: 1;
                    color: "gray";
                }
                Image {
                    id: bedroomImage;
                    source: "light/smartlight_off.png";
                    anchors.horizontalCenter: parent.horizontalCenter;
                    anchors.bottom: parent.bottom;
                    anchors.bottomMargin: 5;
                    MouseArea {
                        anchors.fill: parent;
                        onReleased: {
                            if (bedroomLight == false) {
                                bedroomLight = true;
                                bedroomImage.source = "light/smartlight_on.png"
                            }
                            else {
                                bedroomLight = false;
                                bedroomImage.source = "light/smartlight_off.png"
                            }
                        }
                    }
                }
            }
            Rectangle{
                width: 100;
                height: 130;
                color: "#363636";
                Text {
                    text: "书房大灯";
                    color: "white";
                    font { family: fontName.name; pixelSize: 18 }
                    anchors.horizontalCenter: parent.horizontalCenter;
                    y: 10;
                }
                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter;
                    y: 40;
                    width: 80;
                    height: 1;
                    color: "gray";
                }
                Image {
                    id: studyroomImage;
                    source: "light/smartlight_off.png";
                    anchors.horizontalCenter: parent.horizontalCenter;
                    anchors.bottom: parent.bottom;
                    anchors.bottomMargin: 5;
                    MouseArea {
                        anchors.fill: parent;
                        onReleased: {
                            if (studyroomLight == false) {
                                studyroomLight = true;
                                studyroomImage.source = "light/smartlight_on.png"
                            }
                            else {
                                studyroomLight = false;
                                studyroomImage.source = "light/smartlight_off.png"
                            }
                        }
                    }
                }
            }
            Rectangle{
                width: 100;
                height: 130;
                color: "#363636";
                Text {
                    text: "门厅灯";
                    color: "white";
                    font { family: fontName.name; pixelSize: 18 }
                    anchors.horizontalCenter: parent.horizontalCenter;
                    y: 10;
                }
                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter;
                    y: 40;
                    width: 80;
                    height: 1;
                    color: "gray";
                }
                Image {
                    id: doorImage;
                    source: "light/smartlight_off.png";
                    anchors.horizontalCenter: parent.horizontalCenter;
                    anchors.bottom: parent.bottom;
                    anchors.bottomMargin: 5;
                    MouseArea {
                        anchors.fill: parent;
                        onReleased: {
                            if (doorLight == false) {
                                doorLight = true;
                                doorImage.source = "light/smartlight_on.png"
                            }
                            else {
                                doorLight = false;
                                doorImage.source = "light/smartlight_off.png"
                            }
                        }
                    }
                }
            }
            Rectangle{
                width: 100;
                height: 130;
                color: "#363636";
                Text {
                    text: "儿童房灯";
                    color: "white";
                    font { family: fontName.name; pixelSize: 18 }
                    anchors.horizontalCenter: parent.horizontalCenter;
                    y: 10;
                }
                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter;
                    y: 40;
                    width: 80;
                    height: 1;
                    color: "gray";
                }
                Image {
                    id: childImage;
                    source: "light/smartlight_off.png";
                    anchors.horizontalCenter: parent.horizontalCenter;
                    anchors.bottom: parent.bottom;
                    anchors.bottomMargin: 5;
                    MouseArea {
                        anchors.fill: parent;
                        onReleased: {
                            if (childLight == false) {
                                childLight = true;
                                childImage.source = "light/smartlight_on.png"
                            }
                            else {
                                childLight = false;
                                childImage.source = "light/smartlight_off.png"
                            }
                        }
                    }
                }
            }
        }
    }

    Text {
        id: colourText;
        anchors.top: smartRec.bottom;
        anchors.topMargin: 20;
        text: "Colour Light";
        color: "white";
        font { family: fontName.name; pixelSize: 20 }
    }
    Rectangle {
        id: colourRec;
        anchors.top: colourText.bottom;
        anchors.topMargin: 5;
        width: 450;
        height: 150;
        color: "transparent";
        border.color: "white";
        Row {
            x: 10;
            y: 10;
            width: 430;
            height: 130;
            spacing: 10;
            Rectangle{
                width: 100;
                height: 130;
                color: "#363636";
                Text {
                    text: "情趣灯";
                    color: "white";
                    font { family: fontName.name; pixelSize: 18 }
                    anchors.horizontalCenter: parent.horizontalCenter;
                    y: 10;
                }
                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter;
                    y: 40;
                    width: 80;
                    height: 1;
                    color: "gray";
                }
                Image {
                    id: interestImage;
                    source: "light/colourlight_off.png";
                    anchors.horizontalCenter: parent.horizontalCenter;
                    anchors.bottom: parent.bottom;
                    anchors.bottomMargin: 5;
                    MouseArea {
                        anchors.fill: parent;
                        onReleased: {
                            if (interestLight == false) {
                                interestLight = true;
                                interestImage.source = "light/colourlight_on.png"
                            }
                            else {
                                interestLight = false;
                                interestImage.source = "light/colourlight_off.png"
                            }
                        }
                    }
                }
            }
            Rectangle{
                width: 100;
                height: 130;
                color: "#363636";
                Text {
                    text: "书房台灯";
                    color: "white";
                    font { family: fontName.name; pixelSize: 18 }
                    anchors.horizontalCenter: parent.horizontalCenter;
                    y: 10;
                }
                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter;
                    y: 40;
                    width: 80;
                    height: 1;
                    color: "gray";
                }
                Image {
                    id: studyroomLampImage;
                    source: "light/colourlight_off.png";
                    anchors.horizontalCenter: parent.horizontalCenter;
                    anchors.bottom: parent.bottom;
                    anchors.bottomMargin: 5;
                    MouseArea {
                        anchors.fill: parent;
                        onReleased: {
                            if (studyroomLamp == false) {
                                studyroomLamp = true;
                                studyroomLampImage.source = "light/colourlight_on.png"
                            }
                            else {
                                studyroomLamp = false;
                                studyroomLampImage.source = "light/colourlight_off.png"
                            }
                        }
                    }
                }
            }
            Rectangle{
                width: 100;
                height: 130;
                color: "#363636";
                Text {
                    text: "浴室灯";
                    color: "white";
                    font { family: fontName.name; pixelSize: 18 }
                    anchors.horizontalCenter: parent.horizontalCenter;
                    y: 10;
                }
                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter;
                    y: 40;
                    width: 80;
                    height: 1;
                    color: "gray";
                }
                Image {
                    id: bathroomImage;
                    source: "light/colourlight_off.png";
                    anchors.horizontalCenter: parent.horizontalCenter;
                    anchors.bottom: parent.bottom;
                    anchors.bottomMargin: 5;
                    MouseArea {
                        anchors.fill: parent;
                        onReleased: {
                            if (bathroomLight == false) {
                                bathroomLight = true;
                                bathroomImage.source = "light/colourlight_on.png"
                            }
                            else {
                                bathroomLight = false;
                                bathroomImage.source = "light/colourlight_off.png"
                            }
                        }
                    }
                }
            }
            Rectangle{
                width: 100;
                height: 130;
                color: "#363636";
                Text {
                    text: "客厅小灯";
                    color: "white";
                    font { family: fontName.name; pixelSize: 18 }
                    anchors.horizontalCenter: parent.horizontalCenter;
                    y: 10;
                }
                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter;
                    y: 40;
                    width: 80;
                    height: 1;
                    color: "gray";
                }
                Image {
                    id: livingImage;
                    source: "light/colourlight_off.png";
                    anchors.horizontalCenter: parent.horizontalCenter;
                    anchors.bottom: parent.bottom;
                    anchors.bottomMargin: 5;
                    MouseArea {
                        anchors.fill: parent;
                        onReleased: {
                            if (livingLight == false) {
                                livingLight = true;
                                livingImage.source = "light/colourlight_on.png"
                            }
                            else {
                                livingLight = false;
                                livingImage.source = "light/colourlight_off.png"
                            }
                        }
                    }
                }
            }
        }
    }
}
