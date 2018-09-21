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
import "../Components"

BlankScreen {
    id: modulesScreen
    title: "Modules"

    RowLayout {
        id: rowLayout
        anchors.fill: parent
        spacing: 0

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true

            CTextArea {
                id: modulesTextArea
                anchors.fill: parent
                anchors.margins: -1
                readOnly: true
                text: "List of the modules which you can use in QML Creator:<br><br>
                       • Qt.WebSockets 1.0<br>
                       • Qt.labs.folderlistmodel 2.1<br>
                       • Qt.labs.settings 1.0<br>
                       • QtAudioEngine 1.0<br>
                       • QtBluetooth 5.2<br>
                       • QtGraphicalEffects 1.0<br>
                       • QtLocation 5.3<br>
                       • QtMultimedia 5.4<br>
                       • QtNfc 5.2<br>
                       • QtPositioning 5.2<br>
                       • QtQml 2.2<br>
                       • QtQml.Models 2.1<br>
                       • QtQuick 2.4<br>
                       • QtQuick.Controls 1.3<br>
                       • QtQuick.Controls.Styles 1.3<br>
                       • QtQuick.Dialogs 1.2<br>
                       • QtQuick.Layouts 1.1<br>
                       • QtQuick.LocalStorage 2.0<br>
                       • QtQuick.Particles 2.0<br>
                       • QtQuick.Window 2.2<br>
                       • QtQuick.XmlListModel 2.0<br>
                       • QtSensors 5.0<br>
                       • QtTest 1.1"
            }
        }

        CVerticalScrollBar {
            Layout.fillHeight: true
            flickableItem: modulesTextArea.flickableItem
            enabled: flickableItem.contentHeight > rowLayout.height
        }
    }
}
