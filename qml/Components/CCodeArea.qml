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
import QtQuick.Layouts 1.1
import SyntaxHighlighter 1.0

Item {
    id: cCodeArea
    implicitWidth: 320
    implicitHeight: 240
    clip: true
    property alias lineNumbers: lineColumn.visible
    property alias text: codeTextArea.text
    property alias readOnly: codeTextArea.readOnly

    function undo() { codeTextArea.undo() }
    function redo() { codeTextArea.redo() }
    function copy() { codeTextArea.copy() }
    function paste() { codeTextArea.paste() }
    function selectAll() { codeTextArea.selectAll() }

    // workaround
    onFocusChanged: if (focus) codeTextArea.forceActiveFocus()

    RowLayout {
        id: rowLayout
        anchors.fill: parent
        anchors.topMargin: -1
        anchors.bottomMargin: -1
        spacing: 0

        Rectangle {
            id: lineColumn
            Layout.minimumWidth: childrenRect.width * 1.2
            Layout.fillHeight: true
            clip: true
            color: "#e8e8e8"

            Column {
                id: column
                y: -codeTextArea.flickableItem.contentY + 5
                anchors.horizontalCenter: parent.horizontalCenter

                Repeater {
                    model: codeTextArea.lineCount
                    delegate: Text {
                        anchors.right: column.right
                        color: index + 1 === codeTextArea.currentLine ? "#1e1b18" : "#999999"
                        font.family: codeTextArea.font.family
                        font.pixelSize: codeTextArea.font.pixelSize
                        font.bold: index + 1 === codeTextArea.currentLine
                        text: index + 1
                    }
                }
            }
        }

        CTextArea {
            id: codeTextArea
            Layout.fillWidth: true
            Layout.fillHeight: true
            textFormat: Text.PlainText
            font.family: appWindow.font
            font.pixelSize: appWindow.fontSize
            inputMethodHints: Qt.ImhNoPredictiveText
            property int currentLine: cursorRectangle.y / cursorRectangle.height + 1

            SyntaxHighlighter {
                id: syntaxHighlighter
            }

            Component.onCompleted: {
                syntaxHighlighter.setHighlighter(codeTextArea)
                if (projectManager.currentProject() !== "") {
                    // custom types
                    var files = projectManager.getFiles()
                    for (var i = 0; i < files.length; i++) {
                        var filename = files[i].split(".")
                        if (filename[0] !== "main") {
                            if (filename[1] === "qml")
                                syntaxHighlighter.addQmlComponent(filename[0])
                            if (filename[1] === "js")
                                syntaxHighlighter.addJsComponent(filename[0])
                        }
                    }
                    syntaxHighlighter.rehighlight()
                }
            }
        }

        CVerticalScrollBar {
            Layout.fillHeight: true
            flickableItem: codeTextArea.flickableItem
            enabled: flickableItem.contentHeight > rowLayout.height
        }
    }
}
