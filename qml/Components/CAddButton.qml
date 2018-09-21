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
import QtGraphicalEffects 1.0

ToolButton {
    id: cAddButton
    implicitWidth: 22 * appWindow.pixelDensity
    implicitHeight: 22 * appWindow.pixelDensity
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    anchors.margins: 8 * appWindow.pixelDensity

    style: ButtonStyle {
        background: Item {
            Rectangle {
                anchors.fill: parent
                radius: width / 2
                color: control.pressed ? "#006325" : "#80c342"

                Rectangle {
                    id: backRect
                    width: parent.width
                    height: parent.height
                    radius: parent.radius
                    y: Math.max(1, Math.round(0.3 * appWindow.pixelDensity))
                    z: -1
                    color: "#006325"
                }

                DropShadow {
                    z: -1
                    anchors.fill: backRect
                    verticalOffset: Math.max(3, Math.round(appWindow.pixelDensity))
                    radius: Math.round(3 * appWindow.pixelDensity)
                    samples: 8
                    color: "#999999"
                    source: backRect
                    transparentBorder: true
                    fast: true
                }
            }
        }

        label: CLabel {
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: "+"
            font.pixelSize: 12 * appWindow.pixelDensity
            color: "#ffffff"
        }
    }
}
