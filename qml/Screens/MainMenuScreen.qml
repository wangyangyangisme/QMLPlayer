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
import QtQuick.Layouts 1.1
import "../Components"

BlankScreen {
    id: mainMenuScreen
    title: "QML Creator"

    Flickable {
        anchors.fill: parent
        flickableDirection: Flickable.VerticalFlick
        pixelAligned: true
        contentHeight: column.height
        clip: true

        Column {
            id: column
            anchors.left: parent.left
            anchors.right: parent.right

            CIconButton {
                text: "PROJECTS"
                icon: ""
                onClicked: {
                    if (!stackView.busy) {
                        projectManager.exampleMode = false
                        stackView.push(Qt.resolvedUrl("ProjectsScreen.qml"))
                    }
                }
            }

            CIconButton {
                text: "EXAMPLES"
                icon: ""
                onClicked: {
                    if (!stackView.busy) {
                        projectManager.exampleMode = true
                        stackView.push(Qt.resolvedUrl("ExamplesScreen.qml"))
                    }
                }
            }

            CIconButton {
                text: "SETTINGS"
                icon: ""
                onClicked: if (!stackView.busy) stackView.push(Qt.resolvedUrl("SettingsScreen.qml"))
            }

            CIconButton {
                text: "MODULES"
                icon: ""
                onClicked: if (!stackView.busy) stackView.push(Qt.resolvedUrl("ModulesScreen.qml"))
            }

            CIconButton {
                text: "ABOUT"
                icon: ""
                onClicked: if (!stackView.busy) stackView.push(Qt.resolvedUrl("AboutScreen.qml"))
            }
        }
    }
}
