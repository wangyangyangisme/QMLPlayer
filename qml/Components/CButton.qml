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

Button {
    id: cButton
    implicitHeight: 18.5 * appWindow.pixelDensity
    anchors.left: parent.left
    anchors.right: parent.right
    style: ButtonStyle {
        background: Item {
            Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                height: Math.max(1, Math.round(0.3 * appWindow.pixelDensity))
                color: "#caded5"
            }

            Rectangle {
                anchors.fill: parent
                color: "#80c342"
                visible: control.pressed
            }
        }
        label: CLabel {
            anchors.fill: parent
            anchors.leftMargin: 6 * appWindow.pixelDensity
            verticalAlignment: Text.AlignVCenter
            opacity: (control.enabled) ? 1 : 0.6
            text: control.text
        }
    }
}
