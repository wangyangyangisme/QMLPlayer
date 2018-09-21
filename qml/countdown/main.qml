import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1

Item {
    id: itemRoot;
    width: 300;
    height: 200;
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

    RemainingTime {
        id: remainingTime
        visible: true;
    }
    SetTime {
        id: setTime;
        //anchors.fill: parent;
        width: 300;
        height: 300;
        visible: false;
    }
    TimeUp {
        id: timeUp;
        //anchors.fill: parent;
        width: 400;
        height: 400;
        //radius: width/2;
        visible: false;
    }

    function onSigSetTime() {
        setTime.x = remainingTime.x;
        setTime.y = remainingTime.y;
        remainingTime.visible = false;
        setTime.visible = true;
    }
    function onSigReleasedTimer() {
        setTime.visible = false;
        if (timeUp.visible == false)
            remainingTime.visible = true;
    }
    function onSigTimeUp() {
        timeUp.x = remainingTime.x;
        timeUp.y = remainingTime.y;
        timeUp.radius = timeUp.width/2;
        setTime.visible = false;
        remainingTime.visible = false;
        timeUp.visible = true;
    }
    function onSigReturn() {
        timeUp.visible = false;
        remainingTime.visible = true;
    }

    Component.onCompleted: {
        remainingTime.sigSetTime.connect(itemRoot.onSigSetTime);
        remainingTime.sigSetTime.connect(setTime.onSigSetTime);
        setTime.sigReleasedTimer.connect(itemRoot.onSigReleasedTimer);
        setTime.sigStartCountDown.connect(remainingTime.onSigStartCountDown);
        setTime.sigPauseCountDown.connect(remainingTime.onSigPauseCountDown);

        remainingTime.sigTimeUp.connect(itemRoot.onSigTimeUp);
        setTime.sigTimeUp.connect(itemRoot.onSigTimeUp);
        remainingTime.sigTimeUp.connect(timeUp.onSigTimeUp);
        setTime.sigTimeUp.connect(timeUp.onSigTimeUp);

        timeUp.sigReturn.connect(itemRoot.onSigReturn);
    }
}
