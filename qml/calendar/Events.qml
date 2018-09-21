import QtQuick 2.2
import QtQuick.Window 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Private 1.0
import QtQuick.Controls.Styles 1.1
import org.qtproject.examples.calendar 1.0

Item {
    id: eventsRoot;

    property var zValue: -1
    property date sysDate;
    property var m: parseInt(Qt.formatDate(sysDate, "M"));
    property var yy: parseInt(Qt.formatDate(sysDate, "yyyy"));

    FontLoader { id: fontName; source: "../Fonts/方正兰亭纤黑简体.ttf"; }

    SqlEventModel {
        id: eventModel;
    }

    Timer {
        id: ssTimer;
        interval: 600000;
        running: true;
        repeat: true;
        triggeredOnStart: true;
        onTriggered: {
            sysDate =  new Date();
            month.text = Qt.formatDate(sysDate, "M") + "/" + getMonth(Qt.formatDate(sysDate, "M"));
            today.text = Qt.formatDate(sysDate, "yy.MM.dd");
        }
    }
    Text {
        id:month;
        text: Qt.formatDate(sysDate, "M") + "/" + getMonth(Qt.formatDate(sysDate, "M"));
        color: "white";
        font { family: fontName.name; pixelSize: 30 }
        anchors.horizontalCenter: calendar.horizontalCenter;
        y: 150;
        MouseArea {
            id: monthArea;
            anchors.fill: parent;
        }
    }
    function getMonth(M) {
        var month;
        switch(parseInt(M)) {
        case 1:  month = "JAN"; break;
        case 2:  month = "FEB"; break;
        case 3:  month = "MAR"; break;
        case 4:  month = "APR"; break;
        case 5:  month = "MAY"; break;
        case 6:  month = "JUN"; break;
        case 7:  month = "JUL"; break;
        case 8:  month = "AUG"; break;
        case 9:  month = "SEP"; break;
        case 10: month = "OCT"; break;
        case 11: month = "NOV"; break;
        case 12: month = "DEC"; break;
        default: break;
        }
        return month;
    }

    Text {
        id: todayText
        text: "Today";
        color: "white";
        font { family: fontName.name; pixelSize: 13 }
        anchors.top: month.top;
        anchors.right: calendar.right;
        anchors.rightMargin: 3;
        MouseArea {
            id: todayTextArea;
            anchors.fill: parent;
        }
    }
    Text {
        id: today
        text: Qt.formatDate(sysDate, "yy.MM.dd");
        color: "white";
        font { family: fontName.name; pixelSize: 14 }
        anchors.bottom: month.bottom;
        anchors.right: calendar.right;
        anchors.rightMargin: 3;
        MouseArea {
            id: todayArea;
            anchors.fill: parent;
        }
    }

    Rectangle {
        width: 400-3;
        height: 35;
        x: 150;
        y: 190;
        z: -1;
        color: "#363636";
    }

    Text {
        id: sunday
        text: "日";
        color: "white";
        font { family: fontName.name; pixelSize: 14; bold: true; }
        x: 173;
        y: 192;
    }
    Text {
        text: "Sun";
        color: "white";
        font { family: fontName.name; pixelSize: 12; bold: true; }
        y: 210;
        anchors.horizontalCenter: sunday.horizontalCenter;
    }

    Text {
        id: monday
        text: "一";
        color: "white";
        font { family: fontName.name; pixelSize: 14; bold: true; }
        x: 228;
        y: 192;
    }
    Text {
        text: "Mon";
        color: "white";
        font { family: fontName.name; pixelSize: 12; bold: true; }
        y: 210;
        anchors.horizontalCenter: monday.horizontalCenter;
    }

    Text {
        id: tuseday
        text: "二";
        color: "white";
        font { family: fontName.name; pixelSize: 14; bold: true; }
        x: 283;
        y: 192;
    }
    Text {
        text: "Tuse";
        color: "white";
        font { family: fontName.name; pixelSize: 12; bold: true; }
        y: 210;
        anchors.horizontalCenter: tuseday.horizontalCenter;
    }

    Text {
        id: wednesday
        text: "三";
        color: "white";
        font { family: fontName.name; pixelSize: 14; bold: true; }
        x: 343;
        y: 192;
    }
    Text {
        text: "Wed";
        color: "white";
        font { family: fontName.name; pixelSize: 12; bold: true; }
        y: 210;
        anchors.horizontalCenter: wednesday.horizontalCenter;
    }

    Text {
        id: thursday
        text: "四";
        color: "white";
        font { family: fontName.name; pixelSize: 14; bold: true; }
        x: 398;
        y: 192;
    }
    Text {
        text: "Thur";
        color: "white";
        font { family: fontName.name; pixelSize: 12; bold: true; }
        y: 210;
        anchors.horizontalCenter: thursday.horizontalCenter;
    }

    Text {
        id: friday
        text: "五";
        color: "white";
        font { family: fontName.name; pixelSize: 14; bold: true; }
        x: 453;
        y: 192;
    }
    Text {
        text: "Fri";
        color: "white";
        font { family: fontName.name; pixelSize: 12; bold: true; }
        y: 210;
        anchors.horizontalCenter: friday.horizontalCenter;
    }

    Text {
        id: saturday
        text: "六";
        color: "white";
        font { family: fontName.name; pixelSize: 14; bold: true; }
        x: 510;
        y: 192;
    }
    Text {
        text: "Sat";
        color: "white";
        font { family: fontName.name; pixelSize: 12; bold: true; }
        y: 210;
        anchors.horizontalCenter: saturday.horizontalCenter;
    }

    Text {
        id: lastMonth
        text: "‹";
        color: "white";
        font { family: fontName.name; pixelSize: 25 }
        anchors.verticalCenter: calendar.verticalCenter;
        x: 120;
        MouseArea {
            id: lastMonthArea;
            anchors.fill: parent;
            onClicked: {
                if (m <= 0) {
                    m = 12;
                    yy--;
                }
                calendar.visibleMonth =  --m;
                calendar.visibleYear = yy;
                month.text = m+1 + "/" + getMonth(m+1);
                today.text = yy;
            }
        }
    }
    Text {
        id: nextMonth
        text: "›";
        color: "white";
        font { family: fontName.name; pixelSize: 25 }
        anchors.verticalCenter: calendar.verticalCenter;
        x: 570-3;
        MouseArea {
            id: nextMonthArea;
            anchors.fill: parent;
            onClicked: {
                if (m >= 11) {
                    m = -1;
                    yy++;
                }
                calendar.visibleMonth = ++m;
                calendar.visibleYear = yy;
                month.text = m+1 + "/" + getMonth(m+1);
                today.text = yy;
            }
        }
    }

    Rectangle {
        x: 150-1; y: 230
        width: 400; height: 1;
        color: "black";
    }

    Calendar {
        id: calendar;
        x: 150-1;
        y: 230;
        z: -2;
        width: 400;
        height: 450;
        frameVisible: false;
        weekNumbersVisible: false;
        navigationBarVisible: false;
        //focus: true;

        onHovered: {
            //console.log("onHovered: "+ Qt.formatDate(sysDate, "yyyy-MM-dd"));
        }

        style: CalendarStyle {
            gridVisible: false;

            dayOfWeekDelegate: Item {
                id:weekItem
            }

            dayDelegate: Item {
                id: dayItem
                readonly property color sameMonthDateTextColor: "white";
                readonly property color selectedDateTextColor: "black";
                readonly property color differentMonthDateTextColor: "gray";
                readonly property color invalidDatecolor: "red";

                Rectangle {
                    id: dayRec;
                    anchors.fill: parent;
                    color: styleData.selected ? "#696969":"#363636";
                    border.width: 2;
                    border.color: "black";
                }

                function imageSource(num) {
                    if (eventModel.eventsForDate(styleData.date).length > 0)
                        return "images/events/"+num+".png";
                    else return "";
                }
                Image {
                    id: event_1;
                    visible: eventModel.eventsForDate(styleData.date).length == 1;
                    anchors.centerIn: parent;
                    width: 35;
                    height: 35;
                    source: imageSource(eventModel.getImageNum(styleData.date));
                }
//                Image {
//                    id: event_2;
//                    width: 30;
//                    height: 30;
//                    visible: eventModel.eventsForDate(styleData.date).length > 1;
//                    source: imageSource(eventModel.getImageNum(styleData.date));
//                }
//                Image {
//                    id: event_3;
//                    width: 30;
//                    height: 30;
//                    anchors.left: event_2.right;
//                    anchors.leftMargin: -4;
//                    visible: eventModel.eventsForDate(styleData.date).length > 1;
//                    source: imageSource(eventModel.getImageNum(styleData.date));
//                }
                GridView {
                    id: eventsGridView;
                    anchors.fill: parent;
                    cellWidth: 27;
                    cellHeight: 25;

                    model: eventModel.eventsForDate(styleData.date);
                    delegate:  Image {
                        width: 27;
                        height: 25;

                        visible: eventModel.eventsForDate(styleData.date).length > 1;
                        source: imageSource(modelData.num);
                    }
                }

                Label {
                    id: dayText;
                    text: styleData.date.getDate();
                    font { family: fontName.name; pixelSize: 15; bold: true; }
                    anchors.bottom: parent.bottom;
                    anchors.right: parent.right;
                    anchors.bottomMargin: 2;
                    anchors.rightMargin: 5;
                    color: {
                        var color = invalidDatecolor;
                        if (styleData.valid) {
                            // Date is within the valid range.
                            color = styleData.visibleMonth ? sameMonthDateTextColor : differentMonthDateTextColor;
                            if (styleData.selected) {
                                color = selectedDateTextColor;
                            }
                        }
                        color;
                    }
                }


                Connections {
                    target: ssTimer;
                    onTriggered: {
                        dayRec.color = styleData.today ? "#696969":"#363636";
                        calendar.visibleMonth = Qt.formatDate(sysDate, "M")-1;
                        calendar.visibleYear = Qt.formatDate(sysDate, "yyyy");
                        m = parseInt(Qt.formatDate(sysDate, "M"))-1;
                        yy = parseInt(Qt.formatDate(sysDate, "yyyy"));
                        month.text = m+1 + "/" + getMonth(m+1);
                        if (styleData.today)
                            today.text = Qt.formatDate(styleData.date, "yy.MM.dd");
                    }
                }
                Connections {
                    target: todayTextArea;
                    onReleased: {
                        dayRec.color = styleData.today ? "#696969":"#363636";
                        calendar.visibleMonth = Qt.formatDate(sysDate, "M")-1;
                        calendar.visibleYear = Qt.formatDate(sysDate, "yyyy");
                        m = parseInt(Qt.formatDate(sysDate, "M"))-1;
                        yy = parseInt(Qt.formatDate(sysDate, "yyyy"));
                        month.text = m+1 + "/" + getMonth(m+1);
                        if (styleData.today)
                            today.text = Qt.formatDate(styleData.date, "yy.MM.dd");
                    }
                }
                Connections {
                    target: todayArea;
                    onReleased: {
                        dayRec.color = styleData.today ? "#696969":"#363636";
                        calendar.visibleMonth = Qt.formatDate(sysDate, "M")-1;
                        calendar.visibleYear = Qt.formatDate(sysDate, "yyyy");
                        m = parseInt(Qt.formatDate(sysDate, "M"))-1;
                        yy = parseInt(Qt.formatDate(sysDate, "yyyy"));
                        month.text = m+1 + "/" + getMonth(m+1);
                        if (styleData.today)
                            today.text = Qt.formatDate(styleData.date, "yy.MM.dd");
                    }
                }
                Connections {
                    target: monthArea;
                    onReleased: {
                        dayRec.color = styleData.today ? "#696969":"#363636";
                        calendar.visibleMonth = Qt.formatDate(sysDate, "M")-1;
                        calendar.visibleYear = Qt.formatDate(sysDate, "yyyy");
                        m = parseInt(Qt.formatDate(sysDate, "M"))-1;
                        yy = parseInt(Qt.formatDate(sysDate, "yyyy"));
                        month.text = m+1 + "/" + getMonth(m+1);
                    }
                }
                Connections {
                    target: calendar;
                    onReleased: {
                        dayRec.color = styleData.selected ? "#696969":"#363636";
                        if (styleData.selected) {
                            today.text = Qt.formatDate(styleData.date, "yy.MM.dd");
/*
                            if (parseInt(Qt.formatDate(styleData.date, "M")) < m)
                            {
                                if (m <= 0) {
                                    m = 12;
                                    yy--;
                                }
                                calendar.visibleMonth =  --m;
                                calendar.visibleYear = yy;
                                month.text = m+1 + "/" + getMonth(m+1);
                                today.text = yy;
                            }
                            else if (parseInt(Qt.formatDate(styleData.date, "M")) > m)
                            {
                                if (m >= 11) {
                                    m = -1;
                                    yy++;
                                }
                                calendar.visibleMonth = ++m;
                                calendar.visibleYear = yy;
                                month.text = m+1 + "/" + getMonth(m+1);
                                today.text = yy;
                            }
*/
                        }
                    }
                }
            }
        }
    }

    Rectangle {
        width: 400-3;
        height: 150;
        color: "#363636";
        x: 150;
        y: 700;
        z: -1;
    }

    Grid {
        id: dragSource;
        columns: 5;
        spacing: 25;
        width: 400-3;
        height: 150;
        x: 210;
        y: 700;
        z: -1
        Loader {
            width: 35;
            height: 35;

            sourceComponent: dragItem;
            onLoaded: item.source = "images/events/1.png";
        }
        Loader {
            width: 35;
            height: 35;
            sourceComponent: dragItem;
            onLoaded: item.source = "images/events/2.png";
        }
        Loader {
            width: 35;
            height: 35;
            sourceComponent: dragItem;
            onLoaded: item.source = "images/events/3.png";
        }
        Loader {
            width: 35;
            height: 35;
            sourceComponent: dragItem;
            onLoaded: item.source = "images/events/4.png";
        }
        Loader {
            width: 35;
            height: 35;
            sourceComponent: dragItem;
            onLoaded: item.source = "images/events/5.png";
        }
        Loader {
            width: 35;
            height: 35;
            sourceComponent: dragItem;
            onLoaded: item.source = "images/events/6.png";
        }
        Loader {
            width: 35;
            height: 35;
            sourceComponent: dragItem;
            onLoaded: item.source = "images/events/7.png";
        }
        Loader {
            width: 35;
            height: 35;
            sourceComponent: dragItem;
            onLoaded: item.source = "images/events/8.png";
        }
        Loader {
            width: 35;
            height: 35;
            sourceComponent: dragItem;
            onLoaded: item.source = "images/events/9.png";
        }
        Loader {
            width: 35;
            height: 35;
            sourceComponent: dragItem;
            onLoaded: item.source = "images/events/10.png";
        }
        Loader {
            width: 35;
            height: 35;
            sourceComponent: dragItem;
            onLoaded: item.source = "images/events/11.png";
        }
        Loader {
            width: 35;
            height: 35;
            sourceComponent: dragItem;
            onLoaded: item.source = "images/events/12.png";
        }
        Loader {
            width: 35;
            height: 35;
            sourceComponent: dragItem;
            onLoaded: item.source = "images/events/13.png";
        }
        Loader {
            width: 35;
            height: 35;
            sourceComponent: dragItem;
            onLoaded: item.source = "images/events/14.png";
        }
        Loader {
            width: 35;
            height: 35;
            sourceComponent: dragItem;
            onLoaded: item.source = "images/events/15.png";
        }
    }

    //drag source item should not use anchors to layout! or drag will failed
    Component {
        id: dragItem;
        Image {
            id: dragImage;
            x: 0;
            y: 0;
            width: 30;
            height: 30;
            Drag.active: dragArea.drag.active;
            Drag.supportedActions: Qt.CopyAction;
            Drag.dragType: Drag.Automatic;
            Drag.mimeData: {"source": source};

            MouseArea {
                id: dragArea;
                anchors.fill: parent;
                drag.target: parent;

                onPressed: {
                    //cellRec.color = dropContainer.containsDrag ? "lightgray" : "gray";
                }

                onReleased: {
                    if(parent.Drag.supportedActions == Qt.CopyAction){
                        dragImage.x = 0;
                        dragImage.y = 0;
                    }
                }
            }
        }
    }

    signal sigImagePosition(var x, var y);
    DropArea {
        id: dropContainer;
        anchors.fill: parent
        z: -1;

        onEntered: {
            drag.accepted = true;
            followImage.source = drag.getDataAsString("source");
            //console.log("onEntered, formats:", drag.formats, "; action:", drag.action);
        }

        onPositionChanged: {
            drag.accepted = true;
            followImage.x = drag.x - 25;
            followImage.y = drag.y - 100;
            sigImagePosition(drag.x, drag.y);
        }

        onDropped: {
//            console.log("onDropped:", drop.proposedAction);
//            console.log("source:", drop.getDataAsString("source"));
//            console.log("event.x:", drop.x, "; y:", drop.y);
//            console.log("event class = ", drop);
            if(drop.supportedActions == Qt.CopyAction) {
                var obj = dragItem.createObject(eventsRoot, {
                                                    "x": drop.x - 25,
                                                    "y": drop.y - 100,
                                                    "source": drop.getDataAsString("source"),
                                                    "Drag.supportedActions": Qt.MoveAction,
                                                    "Drag.dragType": Drag.Internal
                                                });
            }
            else if(drop.supportedActions == Qt.MoveAction) {
                console.log("move action, drop.sourc:", drop.source, "; drop.source.source:", drop.source.source);
            }
            drop.acceptProposedAction();
            drop.accepted = true;
        }

        Image {
            id: followImage;
            width: 50;
            height: 50;
            z: 2;

            visible: parent.containsDrag;
        }
    }

    Component.onCompleted: {
        console.log("onCompleted");
    }
    Component.onDestruction: {
        console.log("onDestruction");
    }
}

/*

    GridView {
        id: calendar;
        x: 150;
        y: 230;
        z: -2;
        width: 400;
        height: 450;
        cellWidth: 57;
        cellHeight: 75;
        currentIndex: 26;

        model:calendarModel;
        delegate: calendarDelegate;
    }
    ListModel {
        id: calendarModel;
        ListElement {
            index: "0";
        }
        ListElement {
            index: "1";
        }
        ListElement {
            index: "2";
        }
        ListElement {
            index: "3";
        }
        ListElement {
            index: "4";
        }
        ListElement {
            index: "5";
        }
        ListElement {
            index: "6";
        }
        ListElement {
            index: "7";
        }
        ListElement {
            index: "8";
        }
        ListElement {
            index: "9";
        }
        ListElement {
            index: "10";
        }
        ListElement {
            index: "11";
        }
        ListElement {
            index: "12";
        }
        ListElement {
            index: "13";
        }
        ListElement {
            index: "14";
        }
        ListElement {
            index: "15";
        }
        ListElement {
            index: "16";
        }
        ListElement {
            index: "17";
        }
        ListElement {
            index: "18";
        }
        ListElement {
            index: "19";
        }
        ListElement {
            index: "20";
        }
        ListElement {
            index: "21";
        }
        ListElement {
            index: "22";
        }
        ListElement {
            index: "23";
        }
        ListElement {
            index: "24";
        }
        ListElement {
            index: "25";
        }
        ListElement {
            index: "26";
        }
        ListElement {
            index: "27";
        }
        ListElement {
            index: "28";
        }
        ListElement {
            index: "29";
        }
        ListElement {
            index: "30";
        }
        ListElement {
            index: "31";
        }
        ListElement {
            index: "32";
        }
        ListElement {
            index: "33";
        }
        ListElement {
            index: "34";
        }
        ListElement {
            index: "35";
        }
        ListElement {
            index: "36";
        }
        ListElement {
            index: "37";
        }
        ListElement {
            index: "38";
        }
        ListElement {
            index: "39";
        }
        ListElement {
            index: "40";
        }
        ListElement {
            index: "41";
        }
    }
    Component {
        id: calendarDelegate
        Rectangle {
            id: cellRec
            color: {
                cellText.color = GridView.isCurrentItem ? "black" : "white";
                return GridView.isCurrentItem ? "lightgray" : "gray";
            }
            width: calendar.cellWidth-3;
            height: calendar.cellHeight-3;

            Text {
                id: cellText
                text: index;
                font { family: fontName.name; pixelSize: 15 }
                anchors.bottom: parent.bottom;
                anchors.right: parent.right;
                anchors.bottomMargin: 2;
                anchors.rightMargin: 3;
            }
            Image {
                id: eventImage
                width: 30;
                height: 30;
                source: "";
                anchors.centerIn: parent;
            }
            MouseArea {
                anchors.fill: parent;
                onClicked: {
                    for (var i = 0; i < calendarModel.count; i++) {
                        calendar.currentIndex = cellText.text;
                    }
                    console.log(cellText.text);
                }
            }
        }
    }


*/
