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
    id: filesScreen
    title: projectManager.currentProject()
    Stack.onStatusChanged: {
        if (Stack.status === Stack.Activating)
            updateScreen()
    }
    Component.onDestruction: {
        projectManager.closeProject()
    }

    function updateScreen() {
        filesListModel.clear()
        var files = projectManager.getFiles()
        for (var i = 0; i < files.length; i++) {
            filesListModel.append({ "fileName": files[i] })
        }
    }

    ListModel {
        id: filesListModel
    }

    CListView {
        anchors.fill: parent
        model: filesListModel
        delegate: CButton {
            anchors.left: parent.left
            anchors.right: parent.right
            text: model.fileName
            onClicked: {
                if (!stackView.busy) {
                    projectManager.openFile(model.fileName)
                    stackView.push(Qt.resolvedUrl("EditorScreen.qml"))
                }
            }

            CRemoveButton {
                visible: !projectManager.exampleMode && model.fileName !== "main.qml"
                onClicked: {
                    projectManager.removeFile(model.fileName)
                    filesListModel.remove(index)
                }
            }
        }
    }

    CAddButton {
        visible: !projectManager.exampleMode
        onClicked: {
            if (!stackView.busy) {
                stackView.push(Qt.resolvedUrl("NewFileScreen.qml"))
            }
        }
    }
}
