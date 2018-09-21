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
import "../Components"

BlankScreen {
    id: playgroundScreen
    title: "Playground"

    Rectangle {
        anchors.fill: parent
        color: "#ffffff"
    }

    Item {
        id: playArea
        anchors.fill: parent
    }

    CLabel {
        id: errorLabel
        anchors.fill: parent
        anchors.margins: 10
        wrapMode: Text.Wrap
        visible: false
    }

    Component.onCompleted: {
        var componentUrl = projectManager.projectMainPath()
        var playComponent = Qt.createComponent(componentUrl, Component.PreferSynchronous, playgroundScreen)
        if (playComponent.status === Component.Error) {
            errorLabel.text = playComponent.errorString()
            errorLabel.visible = true
        } else {
            playComponent.createObject(playArea)
        }
    }
}
