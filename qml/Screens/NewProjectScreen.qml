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
import QtQuick.Layouts 1.1
import "../Components"

BlankScreen {
    id: newProjectScreen
    title: "New Project"

    Flickable {
        anchors.fill: parent
        flickableDirection: Flickable.VerticalFlick
        pixelAligned: true
        contentHeight: column.height

        Column {
            id: column
            anchors.left: parent.left
            anchors.right: parent.right

            CTextField {
                id: projectNameTextField
                placeholderText: "Enter the name of the project"
                validator: RegExpValidator {
                    regExp: new RegExp("[a-zA-Z0-9 ]*")
                }
            }

            CButton {
                text: "Create"
                enabled: projectNameTextField.length > 0
                onClicked: {
                    if (!stackView.busy) {
                        var projectName = projectNameTextField.text
                        if (projectManager.createProject(projectName)) {
                            projectManager.openProject(projectName)
                            stackView.push(Qt.resolvedUrl("FilesScreen.qml"))
                        } else {
                            stackView.push(Qt.resolvedUrl("ErrorScreen.qml"))
                        }
                    }
                }
            }
        }
    }
}
