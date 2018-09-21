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
import QtQuick.Window 2.2
import Qt.labs.settings 1.0

ApplicationWindow {
    id: cApplicationWindow
    width: 960
    height: 600
    visible: true
    title: "QML Player"
    color: "#f2f2f2"
    toolBar: CToolBar { }

    // Settings
    property string font: "Ubuntu Mono"
    property int fontSize: 30

    // Debug
    property bool debugMode: false
    property double pixelDensity: debugMode ? 6.0 : Screen.logicalPixelDensity
    visibility: debugMode ? "FullScreen" : "Windowed"

    Settings {
        category: "root"
        property alias font: cApplicationWindow.font
        property alias fontSize: cApplicationWindow.fontSize

        property alias x: cApplicationWindow.x
        property alias y: cApplicationWindow.y
        property alias width: cApplicationWindow.width
        property alias height: cApplicationWindow.height
    }

    // UI Fonts
    FontLoader {
        source: "../Fonts/Roboto-Regular.ttf"
    }

    FontLoader {
        source: "../Fonts/Roboto-Italic.ttf"
    }

    FontLoader {
        source: "../Fonts/Roboto-Bold.ttf"
    }

    FontLoader {
        source: "../Fonts/Roboto-BoldItalic.ttf"
    }

    FontLoader {
        source: "../Fonts/fontawesome-webfont.ttf"
    }

    // Editor Fonts
    FontLoader {
        source: "../Fonts/ubuntumono.ttf"
    }

    FontLoader {
        source: "../Fonts/dejavusansmono.ttf"
    }

    FontLoader {
        source: "../Fonts/liberationmono.ttf"
    }

    FontLoader {
        source: "../Fonts/droidsansmono.ttf"
    }

    FontLoader {
        source: "../Fonts/firamono.ttf"
    }

    FontLoader {
        source: "../Fonts/sourcecodepro.ttf"
    }
}
