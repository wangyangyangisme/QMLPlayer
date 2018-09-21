import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1


Rectangle {
    id:housectrllistroot
    //width: 200
    //height: 300
    smooth: true;
    color: "black"
    property var lastCtrlType:"none";

    FontLoader { id: fontName; source: "../Fonts/方正兰亭纤黑简体.ttf"; }

    Column{
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 20;

        Loader{
            id: light;
            focus:true
            sourceComponent: ctrlunitComponent;
            property var imagesource_on: "menu/light_on.png";
             property var imagesource_off: "menu/light_off.png";
            property var imagesource: "";
            property var running: false;
            onLoaded: {
                imagesource = imagesource_off;
                item.unittype = "light";
                item.loader = light;
            }

            onFocusChanged: {
                item.focus = focus;
                imagesource = imagesource_off;
                running = false;
                console.log("close light")
            }

        }

        Loader{
            id: plug;
            sourceComponent: ctrlunitComponent;
            property var imagesource_on: "menu/plug_on.png";
             property var imagesource_off: "menu/plug_off.png";
            property var imagesource: "";
            property var running: false;
            onLoaded: {
                imagesource = imagesource_off;
                item.unittype = "plug";
                item.loader = plug;
            }

            onFocusChanged: {
                item.focus = focus;
                imagesource = imagesource_off;
                running = false;
                console.log("close plug")
            }

        }

        Loader{
            id:aircCnditioner;
            sourceComponent: ctrlunitComponent;
            property var imagesource_on: "menu/aircon_on.png";
             property var imagesource_off: "menu/aircon_off.png";
            property var imagesource: "";
            property var running: false;
            onLoaded: {
                imagesource = imagesource_off;
                item.unittype = "aircCnditioner";
                item.loader = aircCnditioner;
            }

            onFocusChanged: {
                item.focus = focus;
                imagesource = imagesource_off;
                running = false;
                console.log("close aircCnditioner")
            }

        }

        Loader{
            id:airCleaner;
            sourceComponent: ctrlunitComponent;
            property var imagesource_on: "menu/airclean_on.png";
             property var imagesource_off: "menu/airclean_off.png";
            property var imagesource: "";
            property var running: false;
            onLoaded: {
                imagesource = imagesource_off;
                item.unittype = "airCleaner";
                item.loader = airCleaner;
            }

            onFocusChanged: {
                item.focus = focus;
                imagesource = imagesource_off;
                running = false;
                console.log("close airCleaner")
            }

        }

    }



    //显示控制设备列表组件
    Component{
        id:ctrlunitComponent;

        Item{
            id:ctrlunit;
            //property var imagesource: " ";
            property var unittype: " ";
            property var running: false;
            property Item loader;
            width: 80;
            height: 80;
            smooth: true;
            Image {
                id: ctrlunitImage
                anchors.fill: parent;
                source: loader.imagesource;
            }

            Text {
                id: ctrlunitname;
                anchors.horizontalCenter: ctrlunitImage.horizontalCenter;
                y: parent.y + 70;
                color: "white";
                font { family: fontName.name; pixelSize: 16; bold: true; }
                text: unittype;
            }

            MouseArea{
                anchors.fill: parent;
                onClicked:  {
                    loader.focus = true;
                    if(lastCtrlType == unittype)
                    {
                        running = !running;
                    }
                    else
                    {

                        running = true;
                    }

                    if(running == true)
                    {
                        console.log("open ",unittype)
                        loader.imagesource = loader.imagesource_on;
                    }
                    else
                    {
                        console.log("close ",unittype)
                        loader.imagesource = loader.imagesource_off;
                    }
                    loader.running = running;
                    lastCtrlType = unittype;

                }
            }


        }
    }


    //设备
    //灯光控制设备
//    LightCtrl{
//        id: lightctrl;
//        x: light.x + 100;
//        y: light.y;
//        opacity: 0;
//    }

    Light{
        id: lightshow;
        x: light.x + 200;
        y: light.y-50;
        opacity: 0;
        visible:light.running;
        //显示动画效果
        PropertyAnimation {
            targets: lightshow;
            property: "opacity";
            from: 0;
            to: 1;
            duration: 1000;
            running: light.running;
        }
    }


    Plug{
        id: plugshow;
        x: plug.x + 200;
        y: plug.y-30;
        opacity: 0;
        visible:plug.running;
        //显示动画效果
        PropertyAnimation {
            targets: plugshow;
            property: "opacity";
            from: 0;
            to: 1;
            duration: 1000;
            running: plug.running;
        }
    }

    AircCnditioner{
        id: aircCnditionershow;
        x: plug.x + 200;
        y: plug.y+35;
        opacity: 0;
        visible:aircCnditioner.running;
        //显示动画效果
        PropertyAnimation {
            targets: aircCnditionershow;
            property: "opacity";
            from: 0;
            to: 1;
            duration: 1000;
            running: aircCnditioner.running;
        }
    }






}

