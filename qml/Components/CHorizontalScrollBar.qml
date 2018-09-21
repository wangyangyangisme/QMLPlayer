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
    id: cHorizontalScrollBar
    property var flickableItem
    implicitHeight: 12 * appWindow.pixelDensity
    clip: true
    visible: enabled

    Rectangle {
        id: handler
        x: flickableItem.contentX / flickableItem.contentWidth * cHorizontalScrollBar.width
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: (cHorizontalScrollBar.width / flickableItem.contentWidth >= 1) ?
                    cHorizontalScrollBar.width :
                    cHorizontalScrollBar.width / flickableItem.contentWidth * cHorizontalScrollBar.width
        color: "#cccccc"
    }

    MouseArea {
        anchors.fill: parent
        preventStealing: true

        onMouseXChanged:
            if (mouseX - handler.width / 2 <= 0) {
                flickableItem.contentX = 0
            }
            else if ((mouseX - handler.width / 2) * flickableItem.contentWidth / cHorizontalScrollBar.width >=
                     flickableItem.contentWidth - cHorizontalScrollBar.width) {
                flickableItem.contentX = flickableItem.contentWidth - cHorizontalScrollBar.width
            }
            else
                flickableItem.contentX = (mouseX - handler.width / 2) * flickableItem.contentWidth / cHorizontalScrollBar.width
    }
}
