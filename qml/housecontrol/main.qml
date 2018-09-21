import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1

Item {
    id:itemRoot
    x:50
    y:500
    width: 50
    height: 50
    smooth: true
    antialiasing: true

    MultiPointTouchArea {
        id: touchArea
        anchors.fill: parent
        maximumTouchPoints: 10
        mouseEnabled: true

        property point pressPos

        onPressed: {
            for (var i = 0; i < touchPoints.length; i++) {
                var point = touchPoints[i]
                pressPos  = Qt.point(point.x, point.y)
            }
           itemRoot.z = ++root.highestZ
        }

        onTouchUpdated: {
            for (var i = 0; i < touchPoints.length; i++) {
                var point = touchPoints[i]

                var delta = Qt.point(point.x - pressPos.x, point.y - pressPos.y)
                itemRoot.x += delta.x
                itemRoot.y += delta.y
            }
        }

        onReleased: {
            for (var i = 0; i < touchPoints.length; i++) {
                var point = touchPoints[i]
            }
            //itemRoot.z = 1;
        }
    }

    Image {
        id: houseimage;
        anchors.fill: parent
        width: 50;
        height: 50;
        source: "menu/home.png";
        MouseArea {
            anchors.fill: parent;
            drag.target: itemRoot;
            onReleased: {
                //点击弹出house ctrl List

                if(housectrllist.visible==false) {
                    housectrllist.visible = true;
                    console.log("open housectrllist")
                }
                else {
                    housectrllist.visible = false;
                    console.log("close housectrllist")
                }
            }
        }
    }

    HouseCtrlList {
        id:housectrllist;
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.top
        anchors.bottomMargin: 100
        width:200
        height:300
        visible: false;
    }
}

