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
    id: cScrollView
    implicitWidth: 60 * appWindow.pixelDensity
    implicitHeight: 60 * appWindow.pixelDensity
    property alias contentItem: loader.sourceComponent
    property int scrollBarsSize: 12 * appWindow.pixelDensity

    Flickable {
        id: flickable
        anchors.top: parent.top
        anchors.bottom: (horizontalScrollBar.visible) ? horizontalScrollBar.top : parent.bottom
        anchors.left: parent.left
        anchors.right: (verticalScrollBar.visible) ? verticalScrollBar.left : parent.right
        contentWidth: (loader.item) ? loader.item.width : 0
        contentHeight: (loader.item) ? loader.item.height : 0
        clip: true
        pixelAligned: true
        interactive: false

        Loader {
            id: loader
        }
    }

    CVerticalScrollBar {
        id: verticalScrollBar
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.bottomMargin: (horizontalScrollBar.visible) ? width : 0
        anchors.right: parent.right
        flickableItem: flickable
        width: scrollBarsSize
        enabled: flickable.contentHeight > cScrollView.height
    }

    CHorizontalScrollBar {
        id: horizontalScrollBar
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.rightMargin: (verticalScrollBar.visible) ? height : 0
        anchors.bottom: parent.bottom
        flickableItem: flickable
        height: scrollBarsSize
        enabled: flickable.contentWidth > cScrollView.width
    }
}
