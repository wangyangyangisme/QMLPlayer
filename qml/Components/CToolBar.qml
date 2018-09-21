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

ToolBar {
    id: cToolBar
    implicitHeight: 22 * appWindow.pixelDensity
    style: ToolBarStyle {
        padding { left: 0; right: 0; top: 0; bottom: 0 }
        background: Rectangle {
            color: "#ffffff"

            Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                height: Math.max(1, Math.round(0.8 * appWindow.pixelDensity))
                color: "#80c342"
            }

            Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.bottom
                height: 1.8 * appWindow.pixelDensity
                gradient: Gradient {
                    GradientStop { position: 0; color: Qt.rgba(0, 0, 0, 0.1) }
                    GradientStop { position: 1; color: Qt.rgba(0, 0, 0, 0) }
                }
            }
        }
    }

    Row {
        id: titleRow
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.leftMargin: 5 * appWindow.pixelDensity
        spacing: 5 * appWindow.pixelDensity
        z: 2

        CLabel {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            text: ""
            verticalAlignment: Text.AlignVCenter
            font.family: "FontAwesome"
            font.pixelSize: 10 * appWindow.pixelDensity
            visible: stackView.depth > 1
        }

        CLabel {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            text: (stackView.currentItem) ? stackView.currentItem.title : ""
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 10 * appWindow.pixelDensity
        }
    }

    MouseArea {
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: titleRow.right
        anchors.rightMargin: -5 * appWindow.pixelDensity
        enabled: stackView.depth > 1
        onClicked: {
            if (!stackView.busy) {
                stackView.forceActiveFocus()
                stackView.pop()
            }
        }

        Rectangle {
            anchors.fill: parent
            visible: parent.pressed
            color: "#80c342"
        }
    }
}
