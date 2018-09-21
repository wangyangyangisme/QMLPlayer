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

    property bool bedroomSwitch: false;         // 卧室开关
    property bool bedroomRefrigeration: false;  // 卧室制冷
    property bool bedroomHeating: false;        // 卧室暖气
    property bool bedroomCirculation: false;    // 卧室循环风
    property bool livingSwitch: false;          // 客厅开关
    property bool livingRefrigeration: false;   // 客厅制冷
    property bool livingHeating: false;         // 客厅暖气
    property bool livingCirculation: false;     // 客厅循环风

    FontLoader { id: fontName; source: "../Fonts/方正兰亭纤黑简体.ttf"; }

    Text {
        id: bedroomText;
        text: "卧室空调";
        color: "white";
        font { family: fontName.name; pixelSize: 20 }
    }
    Rectangle {
        id: bedroomRec;
        anchors.top: bedroomText.bottom;
        anchors.topMargin: 5;
        width: 550;
        height: 150;
        color: "#363636";
        border.color: "white";

        Text {
            id: bedroomSwitchText;
            text: "off";
            color: "white";
            font { family: fontName.name; pixelSize: 15 }
            x: 50;
            y: 35;
        }
        Image {
            id: bedroomSwitchImage;
            source: "Aircon/off.png";
            anchors.horizontalCenter: bedroomSwitchText.horizontalCenter;
            anchors.top: bedroomSwitchText.bottom;
            anchors.topMargin: 10;
            MouseArea {
                anchors.fill: parent;
                onReleased: {
                    if (bedroomSwitch == false) {
                        bedroomSwitch = true;
                        bedroomSwitchText.text = "on";
                        bedroomSwitchImage.source = "Aircon/on.png"

                        bedroomTempAdd.color = "white"
                        bedroomTempText.color = "white"
                        bedroomTempSymbol.color = "white"
                        bedroomTempReduce.color = "white"
                    }
                    else {
                        bedroomSwitch = false;
                        bedroomSwitchText.text = "off";
                        bedroomSwitchImage.source = "Aircon/off.png"

                        bedroomRefrigerationImage.source = "Aircon/snow_off.png"
                        bedroomHeatingImage.source = "Aircon/sun_off.png"
                        bedroomCirculationImage.source = "Aircon/wind_off.png"
                        bedroomRefrigeration = false;
                        bedroomHeating = false;
                        bedroomCirculation = false;

                        bedroomTempAdd.color = "gray"
                        bedroomTempText.color = "black"
                        bedroomTempSymbol.color = "black"
                        bedroomTempReduce.color = "gray"
                    }
                }
            }
        }

        Rectangle {
            width: 1;
            height: 60;
            color: "gray";
            x: 120;
            y: 45;
        }

        Text {
            id: bedroomRefrigerationText;
            text: "制冷";
            color: "white";
            font { family: fontName.name; pixelSize: 15 }
            x: 170;
            y: 30;
        }
        Image {
            id: bedroomRefrigerationImage;
            source: "Aircon/snow_off.png";
            anchors.horizontalCenter: bedroomRefrigerationText.horizontalCenter;
            anchors.top: bedroomRefrigerationText.bottom;
            anchors.topMargin: 10;
            MouseArea {
                anchors.fill: parent;
                onReleased: {
                    if (bedroomSwitch == true) {
                        if (bedroomRefrigeration == false) {
                            bedroomRefrigeration = true;
                            bedroomRefrigerationImage.source = "Aircon/snow_on.png"
                            bedroomHeatingImage.source = "Aircon/sun_off.png"
                            bedroomCirculationImage.source = "Aircon/wind_off.png"
                            bedroomHeating = false;
                            bedroomCirculation = false;
                        }
                        else {
                            bedroomRefrigeration = false;
                            bedroomRefrigerationImage.source = "Aircon/snow_off.png"
                        }
                    }
                }
            }
        }

        Text {
            id: bedroomHeatingText;
            text: "暖气";
            color: "white";
            font { family: fontName.name; pixelSize: 15 }
            x: 250;
            y: 30;
        }
        Image {
            id: bedroomHeatingImage;
            source: "Aircon/sun_off.png";
            anchors.horizontalCenter: bedroomHeatingText.horizontalCenter;
            anchors.top: bedroomHeatingText.bottom;
            anchors.topMargin: 10;
            MouseArea {
                anchors.fill: parent;
                onReleased: {
                    if (bedroomSwitch == true) {
                        if (bedroomHeating == false) {
                            bedroomHeating = true;
                            bedroomHeatingImage.source = "Aircon/sun_on.png"
                            bedroomRefrigerationImage.source = "Aircon/snow_off.png"
                            bedroomCirculationImage.source = "Aircon/wind_off.png"
                            bedroomRefrigeration = false;
                            bedroomCirculation = false;
                        }
                        else {
                            bedroomHeating = false;
                            bedroomHeatingImage.source = "Aircon/sun_off.png"
                        }
                    }
                }
            }
        }

        Text {
            id: bedroomCirculationText;
            text: "循环风";
            color: "white";
            font { family: fontName.name; pixelSize: 15 }
            x: 330;
            y: 30;
        }
        Image {
            id: bedroomCirculationImage;
            source: "Aircon/wind_off.png";
            anchors.horizontalCenter: bedroomCirculationText.horizontalCenter;
            anchors.top: bedroomCirculationText.bottom;
            anchors.topMargin: 10;
            MouseArea {
                anchors.fill: parent;
                onReleased: {
                    if (bedroomSwitch == true) {
                        if (bedroomCirculation == false) {
                            bedroomCirculation = true;
                            bedroomCirculationImage.source = "Aircon/wind_on.png"
                            bedroomRefrigerationImage.source = "Aircon/snow_off.png"
                            bedroomHeatingImage.source = "Aircon/sun_off.png"
                            bedroomRefrigeration = false;
                            bedroomHeating = false;
                        }
                        else {
                            bedroomCirculation = false;
                            bedroomCirculationImage.source = "Aircon/wind_off.png"
                        }
                    }
                }
            }
        }

        Rectangle {
            width: 1;
            height: 60;
            color: "gray";
            x: 410;
            y: 45;
        }

        Text {
            id: bedroomTempAdd;
            text: "›";
            color: "gray";
            font { family: fontName.name; pixelSize: 30; bold: true; }
            anchors.bottom: bedroomTempText.top;
            anchors.bottomMargin: 5;
            x: 470;
            rotation: -90;
            MouseArea {
                anchors.fill: parent;
                onReleased: {
                    if (bedroomSwitch == true) {
                        bedroomTempText.text = parseInt(bedroomTempText.text) + 1;
                    }
                }
            }
        }
        Text {
            id: bedroomTempText;
            text: "21";
            color: "black";
            font { family: fontName.name; pixelSize: 50; bold: true; }
            anchors.right: parent.right;
            anchors.rightMargin: 45;
            y: 50;
        }
        Text {
            id: bedroomTempSymbol;
            text: "°";
            color: "black";
            font { family: fontName.name; pixelSize: 30; bold: true; }
            anchors.left: bedroomTempText.right;
            anchors.top: bedroomTempText.top;
        }
        Text {
            id: bedroomTempReduce;
            text: "›";
            color: "gray";
            font { family: fontName.name; pixelSize: 30; bold: true; }
            anchors.top: bedroomTempText.bottom;
            x: 470;
            rotation: 90;
            MouseArea {
                anchors.fill: parent;
                onReleased: {
                    if (bedroomSwitch == true) {
                        bedroomTempText.text = parseInt(bedroomTempText.text) - 1;
                    }
                }
            }
        }
    }

    Text {
        id: livingText;
        anchors.top: bedroomRec.bottom;
        anchors.topMargin: 20;
        text: "客厅空调";
        color: "white";
        font { family: fontName.name; pixelSize: 20 }
    }
    Rectangle {
        id: livingRec;
        anchors.top: livingText.bottom;
        anchors.topMargin: 5;
        width: 550;
        height: 150;
        color: "#363636";
        border.color: "white";
        Text {
            id: livingSwitchText;
            text: "off";
            color: "white";
            font { family: fontName.name; pixelSize: 15 }
            x: 50;
            y: 35;
        }
        Image {
            id: livingSwitchImage;
            source: "Aircon/off.png";
            anchors.horizontalCenter: livingSwitchText.horizontalCenter;
            anchors.top: livingSwitchText.bottom;
            anchors.topMargin: 10;
            MouseArea {
                anchors.fill: parent;
                onReleased: {
                    if (livingSwitch == false) {
                        livingSwitch = true;
                        livingSwitchText.text = "on";
                        livingSwitchImage.source = "Aircon/on.png"

                        livingTempAdd.color = "white"
                        livingTempText.color = "white"
                        livingTempSymbol.color = "white"
                        livingTempReduce.color = "white"
                    }
                    else {
                        livingSwitch = false;
                        livingSwitchText.text = "off";
                        livingSwitchImage.source = "Aircon/off.png"

                        livingRefrigerationImage.source = "Aircon/snow_off.png"
                        livingHeatingImage.source = "Aircon/sun_off.png"
                        livingCirculationImage.source = "Aircon/wind_off.png"
                        livingRefrigeration = false;
                        livingHeating = false;
                        livingCirculation = false;

                        livingTempAdd.color = "gray"
                        livingTempText.color = "black"
                        livingTempSymbol.color = "black"
                        livingTempReduce.color = "gray"
                    }
                }
            }
        }

        Rectangle {
            width: 1;
            height: 60;
            color: "gray";
            x: 120;
            y: 45;
        }

        Text {
            id: livingRefrigerationText;
            text: "制冷";
            color: "white";
            font { family: fontName.name; pixelSize: 15 }
            x: 170;
            y: 30;
        }
        Image {
            id: livingRefrigerationImage;
            source: "Aircon/snow_off.png";
            anchors.horizontalCenter: livingRefrigerationText.horizontalCenter;
            anchors.top: livingRefrigerationText.bottom;
            anchors.topMargin: 10;
            MouseArea {
                anchors.fill: parent;
                onReleased: {
                    if (livingSwitch == true) {
                        if (livingRefrigeration == false) {
                            livingRefrigeration = true;
                            livingRefrigerationImage.source = "Aircon/snow_on.png"
                            livingHeatingImage.source = "Aircon/sun_off.png"
                            livingCirculationImage.source = "Aircon/wind_off.png"
                            livingHeating = false;
                            livingCirculation = false;
                        }
                        else {
                            livingRefrigeration = false;
                            livingRefrigerationImage.source = "Aircon/snow_off.png"
                        }
                    }
                }
            }
        }

        Text {
            id: livingHeatingText;
            text: "暖气";
            color: "white";
            font { family: fontName.name; pixelSize: 15 }
            x: 250;
            y: 30;
        }
        Image {
            id: livingHeatingImage;
            source: "Aircon/sun_off.png";
            anchors.horizontalCenter: livingHeatingText.horizontalCenter;
            anchors.top: livingHeatingText.bottom;
            anchors.topMargin: 10;
            MouseArea {
                anchors.fill: parent;
                onReleased: {
                    if (livingSwitch == true) {
                        if (livingHeating == false) {
                            livingHeating = true;
                            livingHeatingImage.source = "Aircon/sun_on.png"
                            livingRefrigerationImage.source = "Aircon/snow_off.png"
                            livingCirculationImage.source = "Aircon/wind_off.png"
                            livingRefrigeration = false;
                            livingCirculation = false;
                        }
                        else {
                            livingHeating = false;
                            livingHeatingImage.source = "Aircon/sun_off.png"
                        }
                    }
                }
            }
        }

        Text {
            id: livingCirculationText;
            text: "循环风";
            color: "white";
            font { family: fontName.name; pixelSize: 15 }
            x: 330;
            y: 30;
        }
        Image {
            id: livingCirculationImage;
            source: "Aircon/wind_off.png";
            anchors.horizontalCenter: livingCirculationText.horizontalCenter;
            anchors.top: livingCirculationText.bottom;
            anchors.topMargin: 10;
            MouseArea {
                anchors.fill: parent;
                onReleased: {
                    if (livingSwitch == true) {
                        if (livingCirculation == false) {
                            livingCirculation = true;
                            livingCirculationImage.source = "Aircon/wind_on.png"
                            livingRefrigerationImage.source = "Aircon/snow_off.png"
                            livingHeatingImage.source = "Aircon/sun_off.png"
                            livingRefrigeration = false;
                            livingHeating = false;
                        }
                        else {
                            livingCirculation = false;
                            livingCirculationImage.source = "Aircon/wind_off.png"
                        }
                    }
                }
            }
        }

        Rectangle {
            width: 1;
            height: 60;
            color: "gray";
            x: 410;
            y: 45;
        }

        Text {
            id: livingTempAdd;
            text: "›";
            color: "gray";
            font { family: fontName.name; pixelSize: 30; bold: true; }
            anchors.bottom: livingTempText.top;
            anchors.bottomMargin: 5;
            x: 470;
            rotation: -90;
            MouseArea {
                anchors.fill: parent;
                onReleased: {
                    if (livingSwitch == true) {
                        livingTempText.text = parseInt(livingTempText.text) + 1;
                    }
                }
            }
        }
        Text {
            id: livingTempText;
            text: "21";
            color: "black";
            font { family: fontName.name; pixelSize: 50; bold: true; }
            anchors.right: parent.right;
            anchors.rightMargin: 45;
            y: 50;
        }
        Text {
            id: livingTempSymbol;
            text: "°";
            color: "black";
            font { family: fontName.name; pixelSize: 30; bold: true; }
            anchors.left: livingTempText.right;
            anchors.top: livingTempText.top;
        }
        Text {
            id: livingTempReduce;
            text: "›";
            color: "gray";
            font { family: fontName.name; pixelSize: 30; bold: true; }
            anchors.top: livingTempText.bottom;
            x: 470;
            rotation: 90;
            MouseArea {
                anchors.fill: parent;
                onReleased: {
                    if (livingSwitch == true) {
                        livingTempText.text = parseInt(livingTempText.text) - 1;
                    }
                }
            }
        }
    }

}
