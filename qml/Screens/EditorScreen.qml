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
    id: editorScreen
    title: projectManager.currentFile()
    Component.onDestruction: {
        if (!projectManager.exampleMode)
            projectManager.saveFileContent(codeArea.text)
    }

    // workaround
    Stack.onStatusChanged: {
        if (Stack.status === Stack.Activating) {
            codeArea.forceActiveFocus()
        }
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        CCodeArea {
            id: codeArea
            Layout.fillWidth: true
            Layout.fillHeight: true
            readOnly: projectManager.exampleMode
            text: projectManager.getFileContent()
        }

        CBottomBar {
            Layout.minimumHeight: 20 * appWindow.pixelDensity
            Layout.preferredHeight: 20 * appWindow.pixelDensity
            Layout.fillWidth: true

            Flickable {
                anchors.fill: parent
                flickableDirection: Flickable.HorizontalFlick
                boundsBehavior: Flickable.StopAtBounds
                pixelAligned: true
                contentWidth: row.width

                Row {
                    id: row
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    spacing: 0

                    CToolButton {
                        width: height * 1.5
                        text: ""
                        tooltip: "Run"
                        onClicked: {
                            if (!stackView.busy) {
                                if (!projectManager.exampleMode)
                                    projectManager.saveFileContent(codeArea.text)
                                projectManager.clearComponentCache()
                                Qt.inputMethod.hide()
                                stackView.push(Qt.resolvedUrl("PlaygroundScreen.qml"))
                            }
                        }
                    }

                    CToolButton {
                        text: ""
                        tooltip: "Save"
                        visible: !projectManager.exampleMode
                        onClicked: projectManager.saveFileContent(codeArea.text)
                    }

                    CToolButton {
                        text: ""
                        tooltip: "Reload"
                        visible: !projectManager.exampleMode
                        onClicked: codeArea.text = projectManager.getFileContent()
                    }

                    CToolButton {
                        text: ""
                        tooltip: "Select All"
                        onClicked: codeArea.selectAll()
                    }

                    CToolButton {
                        text: ""
                        tooltip: "Copy"
                        onClicked: codeArea.copy()
                    }

                    CToolButton {
                        text: ""
                        tooltip: "Paste"
                        visible: !projectManager.exampleMode
                        onClicked: codeArea.paste()
                    }

                    CToolButton {
                        text: ""
                        tooltip: "Undo"
                        visible: !projectManager.exampleMode
                        onClicked: codeArea.undo()
                    }

                    CToolButton {
                        text: ""
                        tooltip: "Redo"
                        visible: !projectManager.exampleMode
                        onClicked: codeArea.redo()
                    }
                }
            }
        }
    }
}
