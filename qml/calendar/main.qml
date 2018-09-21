import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1

Item {
    id: itemRoot;
    width: 700;
    height: 900;
    smooth: true;
    antialiasing: true;

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

    Today {
        id: today
        visible: true;
    }
    Events {
        id: events;
        anchors.fill: parent;
        visible: true;
    }
}
