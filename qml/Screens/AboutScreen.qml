/****************************************************************************
**
** Copyright (C) 2013-2015 Oleg Yadrov.
** Contact: wearyinside@gmail.com
**
** This file is part of QML Creator.
**
** QML Creator is free software: you can redistribute it and/or modify
** it under the terms of the GNU General Public License as published by
** the Free Software Foundation, either version 3 of the License, or
** (at your option) any later version.
**
** QML Creator is distributed in the hope that it will be useful,
** but WITHOUT ANY WARRANTY; without even the implied warranty of
** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
** GNU General Public License for more details.
**
** You should have received a copy of the GNU General Public License
** along with QML Creator. If not, see http://www.gnu.org/licenses/.
**
****************************************************************************/

import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.3
import QtQuick.Layouts 1.1
import "../Components"

BlankScreen {
    id: aboutScreen
    title: "About"

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        RowLayout {
            id: rowLayout
            spacing: 0

            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true

                CTextArea {
                    id: aboutTextArea
                    anchors.fill: parent
                    anchors.margins: -1
                    readOnly: true
                    onLinkActivated: Qt.openUrlExternally(link)
                    text: Qt.application.name + " " + Qt.application.version + "<br>
                           Based on Qt Quick 2.4 (Qt 5.4.0)<br>
                           Built on Jan 19 2015<br><br>
                           Copyright (C) 2013-2015 Oleg Yadrov.<br>
                           wearyinside@gmail.com<br><br>

                           You can support me by donating bitcoins to
                           1weary24fY4PqH542yGEgwZcYksGv7zLB<br><br>

                           This program is free software: you can redistribute it and/or modify
                           it under the terms of the GNU General Public License as published by
                           the Free Software Foundation, either version 3 of the License, or
                           (at your option) any later version.<br><br>

                           This program is distributed in the hope that it will be useful,
                           but WITHOUT ANY WARRANTY; without even the implied warranty of
                           MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                           GNU General Public License for more details.<br><br>

                           Qt is a registered trade mark of Digia Plc and/or its subsidiaries."
                }
            }

            CVerticalScrollBar {
                Layout.fillHeight: true
                flickableItem: aboutTextArea.flickableItem
                enabled: flickableItem.contentHeight > rowLayout.height
            }
        }

        CBottomBar {
            Layout.minimumHeight: 20 * appWindow.pixelDensity
            Layout.preferredHeight: 20 * appWindow.pixelDensity
            Layout.fillWidth: true

            Flickable {
                anchors.fill: parent
                flickableDirection: Flickable.HorizontalFlick
                boundsBehavior: Flickable.StopAtBounds
                pixelAligned: true
                contentWidth: row.width

                Row {
                    id: row
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    spacing: 0

                    CToolButton {
                        text: ""
                        tooltip: "Google Play"
                        onClicked: Qt.openUrlExternally("https://play.google.com/store/apps/details?id=com.wearyinside.qmlcreator")
                    }

                    CToolButton {
                        text: ""
                        tooltip: "App Store"
                        onClicked: Qt.openUrlExternally("https://itunes.apple.com/us/app/qml-creator/id944301984")
                    }

                    CToolButton {
                        text: ""
                        tooltip: "Source Code"
                        onClicked: Qt.openUrlExternally("https://bitbucket.org/wearyinside/qml-creator")
                    }

                    CToolButton {
                        text: ""
                        tooltip: "E-Mail"
                        onClicked: Qt.openUrlExternally("mailto:wearyinside@gmail.com")
                    }

                    CToolButton {
                        text: ""
                        tooltip: "Donate"
                        onClicked: Qt.openUrlExternally("https://blockchain.info/address/1weary24fY4PqH542yGEgwZcYksGv7zLB")
                    }

                    CToolButton {
                        text: ""
                        tooltip: "Linkedin"
                        onClicked: Qt.openUrlExternally("https://linkedin.com/in/olegyadrov/")
                    }
                }
            }
        }
    }
}
