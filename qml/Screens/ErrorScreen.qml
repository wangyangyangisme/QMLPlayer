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
    title: "Oops"

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10

        CLabel {
            Layout.fillWidth: true
            text: "Something went wrong:"
            wrapMode: Text.Wrap
        }

        CLabel {
            Layout.fillWidth: true
            text: projectManager.errorText()
            wrapMode: Text.Wrap
        }

        Item {
            Layout.fillHeight: true
        }
    }
}
