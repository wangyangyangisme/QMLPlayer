import QtQuick 2.4
import QtQuick.Window 2.2

Window {
    id: root
    width: 800
    height: 800
    title: Qt.application.name
    color: "#000000"
    property bool debugMode: true
    visibility: debugMode ? "Windowed" : "FullScreen"

    property int highestZ: 0

    Item {
        id: playArea
        anchors.fill: parent

        Component.onCompleted: {
            var componentUrl = "qrc:qml/settings.qml"
            var playComponent = Qt.createComponent(componentUrl, Component.PreferSynchronous, root)
            if (playComponent.status === Component.Ready) {
                playComponent.createObject(playArea)
            } else {
                errorLabel.text = playComponent.errorString()
                errorLabel.visible = true
            }
        }
    }

    Text {
        id: errorLabel
        anchors.bottom: parent.bottom
        anchors.margins: 10
        wrapMode: Text.Wrap
        color: "#ffffff"
        visible: false
    }

    DropArea {
        anchors.fill: parent
        keys: ["text/uri-list"]

        onDropped: {
            if (drop.hasUrls) {
                if (drop.proposedAction == Qt.MoveAction || drop.proposedAction == Qt.CopyAction) {
                    errorLabel.text = drop.urls[0]
                    errorLabel.visible = true

                    var componentUrl = drop.urls[0]
                    var playComponent = Qt.createComponent(componentUrl, Component.PreferSynchronous, root)
                    if (playComponent.status === Component.Ready) {
                        playComponent.createObject(playArea)
                    } else {
                        errorLabel.text = playComponent.errorString()
                        errorLabel.visible = true
                    }

                    drop.acceptProposedAction()
                }
            }
        }
    }

    Rectangle {
        id: exit
        width: 50
        height: width
        anchors.margins: 10
        radius: 10

        anchors.bottom: parent.bottom
        anchors.right: parent.right

        opacity: 0.6
        color: "yellow"


        Text {
            id: addButtom2
            text: "X"
            font.pixelSize: 20
            anchors.centerIn: parent
        }

        MouseArea {
            id: addArea2
            anchors.fill: parent

            onPressed: {
                Qt.quit()
            }
        }
    }
}
