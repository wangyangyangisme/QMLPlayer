import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtMultimedia 5.0

Item {
    id: itemRoot
    width: 300
    height: 150
    smooth: true
    antialiasing: true

    property bool running: false

    Rectangle {
        anchors.fill: parent
        color: Qt.rgba(Math.random(), Math.random(), Math.random(), 1)
        opacity: 1
        radius: 5
        smooth: true
        antialiasing: true

        Rectangle {
            id: colose
            width: 60
            height: 60
            radius: width / 2
            color: "red"
            opacity: 1

            x: parent.width - width + (width / 3)
            y: - height / 3
            z: parent.z + 1

            Text {
                id: textClose
                anchors.centerIn: parent
                text: "X"
            }
            MouseArea {
                id: closeArea
                anchors.fill: colose
                onPressed: {
                    textClose.text = textClose.text == "X" ? "Y" : "X"
                    itemRoot.destroy();
                }
            }
        }

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
    }

    MediaPlayer {
        id: player
        //source: "qrc:qml/The Fox.mp3"               //qrc:qml/qml/The Fox.mp3
    }
    Component.onCompleted: {
        player.source = "qrc:qml/The Fox.mp3"
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: spacing

        Label {
            id: timeLabel
            Layout.fillWidth: true
            Layout.fillHeight: true
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            color: "#ffffff"
            font.pixelSize: 30
            text: "The Fox"
        }

        Button {
            Layout.minimumWidth: 280
            Layout.maximumWidth: 280
            Layout.minimumHeight: 50
            Layout.maximumHeight: 50
            text: running ? "Pause" : "Start"

            style: ButtonStyle {
                label: Text {
                    renderType: Text.NativeRendering
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.family: "Helvetica"
                    font.pixelSize: 20
                    color: "blue"
                    text: control.text
                }
            }

            onClicked: {
                console.log(player.source)
                running = !running
                if (running) {
                    player.play()
                } else {
                    player.pause()
                }
            }
        }
    }
}
