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

    property bool bedroomPlug: false;      // 卧室插座
    property bool tablelampPlug: false;    // 台灯插座
    property bool televisionPlug: false;   // 电视插座
    property bool freezerPlug: false;      // 冰箱插座

    FontLoader { id: fontName; source: "../Fonts/方正兰亭纤黑简体.ttf"; }

    Text {
        id: smartText;
        text: "Smart Plug";
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
                    text: "卧室插座";
                    color: "white";
                    font { family: fontName.name; pixelSize: 16 }
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
                    source: "plug/plug_off.png";
                    anchors.horizontalCenter: parent.horizontalCenter;
                    anchors.bottom: parent.bottom;
                    anchors.bottomMargin: 5;
                    height: 80;
                    MouseArea {
                        anchors.fill: parent;
                        onReleased: {
                            if (bedroomPlug == false) {
                                bedroomPlug = true;
                                bedroomImage.source = "plug/plug_on.png"
                            }
                            else {
                                bedroomPlug = false;
                                bedroomImage.source = "plug/plug_off.png"
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
                    text: "台灯插座";
                    color: "white";
                    font { family: fontName.name; pixelSize: 16 }
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
                    source: "plug/plug_off.png";
                    anchors.horizontalCenter: parent.horizontalCenter;
                    anchors.bottom: parent.bottom;
                    anchors.bottomMargin: 5;
                    height: 80;
                    MouseArea {
                        anchors.fill: parent;
                        onReleased: {
                            if (tablelampPlug == false) {
                                tablelampPlug = true;
                                studyroomImage.source = "plug/plug_on.png"
                            }
                            else {
                                tablelampPlug = false;
                                studyroomImage.source = "plug/plug_off.png"
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
                    text: "电视插座";
                    color: "white";
                    font { family: fontName.name; pixelSize: 16 }
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
                    source: "plug/plug_off.png";
                    anchors.horizontalCenter: parent.horizontalCenter;
                    anchors.bottom: parent.bottom;
                    anchors.bottomMargin: 5;
                    height: 80;
                    MouseArea {
                        anchors.fill: parent;
                        onReleased: {
                            if (televisionPlug == false) {
                                televisionPlug = true;
                                doorImage.source = "plug/plug_on.png"
                            }
                            else {
                                televisionPlug = false;
                                doorImage.source = "plug/plug_off.png"
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
                    text: "冰箱插座";
                    color: "white";
                    font { family: fontName.name; pixelSize: 16 }
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
                    source: "plug/plug_off.png";
                    anchors.horizontalCenter: parent.horizontalCenter;
                    anchors.bottom: parent.bottom;
                    anchors.bottomMargin: 5;
                    height: 80;
                    MouseArea {
                        anchors.fill: parent;
                        onReleased: {
                            if (freezerPlug == false) {
                                freezerPlug = true;
                                childImage.source = "plug/plug_on.png"
                            }
                            else {
                                freezerPlug = false;
                                childImage.source = "plug/plug_off.png"
                            }
                        }
                    }
                }
            }
        }
    }
}
