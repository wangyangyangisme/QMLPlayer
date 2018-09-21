import QtQuick 2.4

Rectangle {
    width: 50
    height: parent.height
    anchors.margins: 10
    anchors.top: parent.top
    anchors.right: parent.right
    color: "black"

    Rectangle {
        id: rect1
        width: 50
        height: width
        radius: 10

        anchors.top: parent.top
        anchors.right: parent.right

        opacity: 0.6
        color: "lightblue"

        Text {
            id: addButtom1
            text: "计时"
            font.pixelSize: 20
            anchors.centerIn: parent
        }

        MouseArea {
            id: addArea1
            anchors.fill: parent

            onPressed: {
                var componentUrl = "qrc:/qml/timer.qml"
                var playComponent = Qt.createComponent(componentUrl, Component.PreferSynchronous, root)
                if (playComponent.status === Component.Ready) {
                    playComponent.createObject(playArea)
                } else {
                    errorLabel.text = playComponent.errorString()
                    errorLabel.visible = true
                }
            }
        }
    }

    Rectangle {
        id: rect2
        width: 50
        height: width
        anchors.topMargin: 20
        radius: 10

        anchors.top: rect1.bottom
        anchors.right: parent.right

        opacity: 0.6
        color: "lightpink"

        Text {
            id: addButtom2
            text: "音乐"
            font.pixelSize: 20
            anchors.centerIn: parent
        }

        MouseArea {
            id: addArea2
            anchors.fill: parent

            onPressed: {
                var componentUrl = "qrc:/qml/media.qml"
                var playComponent = Qt.createComponent(componentUrl, Component.PreferSynchronous, root)
                if (playComponent.status === Component.Ready) {
                    playComponent.createObject(playArea)
                } else {
                    errorLabel.text = playComponent.errorString()
                    errorLabel.visible = true
                }
            }
        }
    }

    Rectangle {
        id: rect3
        width: 50
        height: width
        anchors.topMargin: 20
        radius: 10

        anchors.top: rect2.bottom
        anchors.right: parent.right

        opacity: 0.6
        color: "lightgreen"

        Text {
            id: addButtom3
            text: "天气"
            font.pixelSize: 20
            anchors.centerIn: parent
        }

        MouseArea {
            id: addArea3
            anchors.fill: parent

            onPressed: {
                var componentUrl = "qrc:/qml/weather/weather.qml"   // 必须加/，否则会提示找不到其他组件。不能用qrc:qml/weather
                var playComponent = Qt.createComponent(componentUrl, Component.PreferSynchronous, root)
                if (playComponent.status === Component.Ready) {
                    playComponent.createObject(playArea)
                } else {
                    errorLabel.text = playComponent.errorString()
                    errorLabel.visible = true
                }
            }
        }
    }

    Rectangle {
        id: rect4
        width: 50
        height: width
        anchors.topMargin: 20
        radius: 10

        anchors.top: rect3.bottom
        anchors.right: parent.right

        opacity: 0.6
        color: "lightgray"

        Text {
            id: addButtom4
            text: "倒时"
            font.pixelSize: 20
            anchors.centerIn: parent
        }

        MouseArea {
            id: addArea4
            anchors.fill: parent

            onPressed: {
                var componentUrl = "qrc:/qml/countdown/main.qml" // 必须加/，否则会提示找不到其他组件。不能用qrc:qml/weather
                var playComponent = Qt.createComponent(componentUrl, Component.PreferSynchronous, root)
                if (playComponent.status === Component.Ready) {
                    playComponent.createObject(playArea)
                } else {
                    errorLabel.text = playComponent.errorString()
                    errorLabel.visible = true
                }
            }
        }
    }
    Rectangle {
        id: rect5
        width: 50
        height: width
        anchors.topMargin: 20
        radius: 10

        anchors.top: rect4.bottom
        anchors.right: parent.right

        opacity: 0.6
        color: "#FA8072"

        Text {
            id: addButtom5
            text: "日历"
            font.pixelSize: 20
            anchors.centerIn: parent
        }

        MouseArea {
            id: addArea5
            anchors.fill: parent

            onPressed: {
                var componentUrl = "qrc:/qml/calendar/main.qml" // 必须加/，否则会提示找不到其他组件。不能用qrc:qml/weather
                var playComponent = Qt.createComponent(componentUrl, Component.PreferSynchronous, root)
                if (playComponent.status === Component.Ready) {
                    playComponent.createObject(playArea)
                } else {
                    errorLabel.text = playComponent.errorString()
                    errorLabel.visible = true
                }
            }
        }
    }
    Rectangle {
        id: rect6
        width: 50
        height: width
        anchors.topMargin: 20
        radius: 10

        anchors.top: rect5.bottom
        anchors.right: parent.right

        opacity: 0.6
        color: "lightyellow"


        Text {
            id: addButtom6
            text: "台灯"
            font.pixelSize: 20
            anchors.centerIn: parent
        }

        MouseArea {
            id: addArea6
            anchors.fill: parent

            onPressed: {
                var componentUrl = "qrc:/qml/housecontrol/App.qml"
                var playComponent = Qt.createComponent(componentUrl, Component.PreferSynchronous, root)
                if (playComponent.status === Component.Ready) {
                    playComponent.createObject(playArea)
                } else {
                    errorLabel.text = playComponent.errorString()
                    errorLabel.visible = true
                }
            }
        }
    }

    Rectangle {
        id: rect7
        width: 50
        height: width
        anchors.topMargin: 20
        radius: 10

        anchors.top: rect6.bottom
        anchors.right: parent.right

        opacity: 0.6
        color: "#00C78C"

        Text {
            id: addButtom7
            text: "智控"
            font.pixelSize: 20
            anchors.centerIn: parent
        }

        MouseArea {
            id: addArea7
            anchors.fill: parent

            onPressed: {
                var componentUrl = "qrc:/qml/housecontrol/main.qml" // 必须加/，否则会提示找不到其他组件。不能用qrc:qml/weather
                var playComponent = Qt.createComponent(componentUrl, Component.PreferSynchronous, root)
                if (playComponent.status === Component.Ready) {
                    playComponent.createObject(playArea)
                } else {
                    errorLabel.text = playComponent.errorString()
                    errorLabel.visible = true
                }
            }
        }
    }

    Rectangle {
        id: rect8
        width: 50
        height: width
        anchors.topMargin: 20
        radius: 10

        anchors.top: rect7.bottom
        anchors.right: parent.right

        opacity: 0.6
        color: "#00C78C"

        Text {
            id: addButtom8
            text: "留言"
            font.pixelSize: 20
            anchors.centerIn: parent
        }

        MouseArea {
            id: addArea8
            anchors.fill: parent

            onPressed: {
                var componentUrl = "qrc:/qml/housecontrol/main.qml" // 必须加/，否则会提示找不到其他组件。不能用qrc:qml/weather
                var playComponent = Qt.createComponent(componentUrl, Component.PreferSynchronous, root)
                if (playComponent.status === Component.Ready) {
                    playComponent.createObject(playArea)
                } else {
                    errorLabel.text = playComponent.errorString()
                    errorLabel.visible = true
                }
            }
        }
    }

}
