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

Item {
    id: cVerticalScrollBar
    property var flickableItem
    implicitWidth: 12 * appWindow.pixelDensity
    clip: true
    visible: enabled

    Rectangle {
        id: handler
        y: flickableItem.contentY / flickableItem.contentHeight * cVerticalScrollBar.height
        anchors.left: parent.left
        anchors.right: parent.right
        height: (cVerticalScrollBar.height / flickableItem.contentHeight >= 1) ?
                    cVerticalScrollBar.height :
                    cVerticalScrollBar.height / flickableItem.contentHeight * cVerticalScrollBar.height
        color: "#cccccc"
    }

    MouseArea {
        anchors.fill: parent
        preventStealing: true

        onMouseYChanged:
            if (mouseY - handler.height / 2 <= 0) {
                flickableItem.contentY = 0
            }
            else if ((mouseY - handler.height / 2) * flickableItem.contentHeight / cVerticalScrollBar.height >=
                     flickableItem.contentHeight - cVerticalScrollBar.height) {
                flickableItem.contentY = flickableItem.contentHeight - cVerticalScrollBar.height
            }
            else
                flickableItem.contentY = (mouseY - handler.height / 2) * flickableItem.contentHeight / cVerticalScrollBar.height
    }
}
