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
    id: newFileScreen
    title: "New File"

    Flickable {
        anchors.fill: parent
        flickableDirection: Flickable.VerticalFlick
        pixelAligned: true
        contentHeight: column.height

        Column {
            id: column
            anchors.left: parent.left
            anchors.right: parent.right

            CLabel {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.margins: 10
                text: "Note: the component name must beginning with an uppercase letter"
                wrapMode: Text.Wrap
            }

            CTextField {
                id: fileNameTextField
                placeholderText: "Enter the filename"
                validator: RegExpValidator {
                    regExp: new RegExp("^[A-Z][a-zA-Z0-9]*")
                }
            }

            CComboBox {
                id: fileExtensionComboBox
                text: "File Extension"
                model: ListModel {
                    id: fileExtensionModel
                    ListElement { text: "qml" }
                    ListElement { text: "js" }
                }
            }

            CButton {
                text: "Create"
                enabled: fileNameTextField.length > 0
                onClicked: {
                    if (!stackView.busy) {
                        var fileExtension = fileExtensionModel.get(fileExtensionComboBox.currentIndex).text
                        var fileName = fileNameTextField.text
                        if (projectManager.createFile(fileName, fileExtension)) {
                            stackView.pop()
                        } else {
                            stackView.push(Qt.resolvedUrl("ErrorScreen.qml"))
                        }
                    }
                }
            }
        }
    }
}
