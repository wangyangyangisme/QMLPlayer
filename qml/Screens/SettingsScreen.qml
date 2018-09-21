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
    id: settingsScreen
    title: "Settings"

    Flickable {
        anchors.fill: parent
        flickableDirection: Flickable.VerticalFlick
        pixelAligned: true
        contentHeight: column.height

        Column {
            id: column
            anchors.left: parent.left
            anchors.right: parent.right

            CComboBox {
                text: "Font Family"
                model: ListModel {
                    id: fontItems
                    ListElement { text: "Ubuntu Mono" }
                    ListElement { text: "Liberation Mono" }
                    ListElement { text: "DejaVu Sans Mono" }
                    ListElement { text: "Droid Sans Mono" }
                    ListElement { text: "Fira Mono" }
                    ListElement { text: "Source Code Pro" }
                }
                currentIndex:
                    if (appWindow.font === "Ubuntu Mono") 0; else
                    if (appWindow.font === "Liberation Mono") 1; else
                    if (appWindow.font === "DejaVu Sans Mono") 2; else
                    if (appWindow.font === "Droid Sans Mono") 3; else
                    if (appWindow.font === "Fira Mono") 4; else
                    if (appWindow.font === "Source Code Pro") 5
                onCurrentIndexChanged: appWindow.font = fontItems.get(currentIndex).text
            }

            CComboBox {
                text: "Font Size"
                currentIndex:
                    if (appWindow.fontSize === 20) 0; else
                    if (appWindow.fontSize === 25) 1; else
                    if (appWindow.fontSize === 30) 2; else
                    if (appWindow.fontSize === 35) 3; else
                    if (appWindow.fontSize === 40) 4; else
                    if (appWindow.fontSize === 45) 5; else
                    if (appWindow.fontSize === 50) 6; else
                    if (appWindow.fontSize === 55) 7; else
                    if (appWindow.fontSize === 60) 8; else
                    if (appWindow.fontSize === 65) 9; else
                    if (appWindow.fontSize === 70) 10; else
                    if (appWindow.fontSize === 75) 11; else
                    if (appWindow.fontSize === 80) 12

                model: ListModel {
                    id: fontSizeItems
                    ListElement { text: "20 px"; fontSize: 20 }
                    ListElement { text: "25 px"; fontSize: 25 }
                    ListElement { text: "30 px"; fontSize: 30 }
                    ListElement { text: "35 px"; fontSize: 35 }
                    ListElement { text: "40 px"; fontSize: 40 }
                    ListElement { text: "45 px"; fontSize: 45 }
                    ListElement { text: "50 px"; fontSize: 50 }
                    ListElement { text: "55 px"; fontSize: 55 }
                    ListElement { text: "60 px"; fontSize: 60 }
                    ListElement { text: "65 px"; fontSize: 65 }
                    ListElement { text: "70 px"; fontSize: 70 }
                    ListElement { text: "75 px"; fontSize: 75 }
                    ListElement { text: "80 px"; fontSize: 80 }
                }
                onCurrentIndexChanged: appWindow.fontSize = fontSizeItems.get(currentIndex).fontSize
            }

            CCodeArea {
                anchors.left: parent.left
                anchors.right: parent.right
                focus: true
                implicitHeight: 140 * appWindow.pixelDensity
                text: "import QtQuick 2.3\n\nText {\n  text: \"Preview\"\n}"
            }
        }
    }
}
