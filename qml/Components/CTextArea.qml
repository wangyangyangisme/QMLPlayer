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

TextArea {
    id: cTextArea
    font.pixelSize: 6 * appWindow.pixelDensity
    font.family: "Roboto"
    textFormat: Text.RichText
    wrapMode: Text.Wrap
    style: TextAreaStyle {
        backgroundColor: "#f2f2f2"
        selectionColor: "#80c342"
        textColor: "#1e1b18"
        selectedTextColor: "#ffffff"
        renderType: Text.QtRendering
        corner: Item { }
        decrementControl: Item { }
        frame: Item { }
        handle: Item { }
        incrementControl: Item { }
        scrollBarBackground: Item { }
    }
    Keys.onReleased: {
        if (event.key === Qt.Key_Back || event.key === Qt.Key_Escape) {
            if (Qt.inputMethod.visible) {
                Qt.inputMethod.hide()
            } else {
                if (!stackView.busy) {
                    if (stackView.depth > 1) {
                        stackView.pop()
                        stackView.forceActiveFocus()
                        event.accepted = true
                    } else {
                        Qt.quit()
                    }
                }
            }
        }
    }
}
