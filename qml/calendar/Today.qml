import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import org.qtproject.examples.calendar 1.0

Item {
    id: todayRoot;
    width: 300;
    height: 100;

    property date sysDate;
    property var i: 6;  // 星期，手动设置

    signal sigSetEvent();

    FontLoader { id: fontName; source: "../Fonts/方正兰亭纤黑简体.ttf"; }

    SqlEventModel {
        id: eventModel;
    }

    Text {
        id: hour;
        text: Qt.formatDateTime(sysDate, "hh:mm");
        color: "white";
        font { family: fontName.name; pixelSize: 40 }
        x: 10;
        y: 10;

        MouseArea {
            id: hourText
            anchors.fill: parent;
            onPressed: {
                sigSetEvent();
            }
        }
    }
    Text {
        id: seconds;
        text: Qt.formatDateTime(sysDate, "ss");
        color: "white";
        font { family: fontName.name; pixelSize: 20 }
        x: 125;
        y: 30;
    }
    Timer {
        id: ssTimer;
        interval: 1000;
        running: true;
        repeat: true;
        triggeredOnStart: true;
        onTriggered: {
            sysDate =  new Date();
            seconds.text = Qt.formatDateTime(sysDate, "ss");
            hour.text = Qt.formatDateTime(sysDate, "hh:mm");
            weekdayE.text = getWeek();
            weekdayC.text = Qt.formatDateTime(sysDate, "dddd");
        }
    }
    Text {
        id: weekdayE;
        text: getWeek();
        color: "white";
        font { family: fontName.name; pixelSize: 18 }
        anchors.top: hour.top;
        anchors.right: parent.right;
        anchors.rightMargin: 30;
    }
    function getWeek() {
        var week;
        if (Qt.formatDateTime(sysDate, "hhmmss") == "235959")
        {
            i++;
            if (i == 7)
                i = 1;
        }
        switch(i) {
        case 1:  week = "Monday";    break;
        case 2:  week = "Tuesday";   break;
        case 3:  week = "Wednesday"; break;
        case 4:  week = "Thursday";  break;
        case 5:  week = "Friday";    break;
        case 6:  week = "Saturday";  break;
        case 7:  week = "Sunday";    break;
        default: break;
        }
        return week;
    }
    Text {
        id: weekdayC;
        text: Qt.formatDateTime(sysDate, "dddd");
        color: "white";
        font { family: fontName.name; pixelSize: 18 }
        anchors.bottom: hour.bottom;
        anchors.right: parent.right;
        anchors.rightMargin: 30;
    }
    Text {
        id: lable;
        text: ">";
        color: "white";
        font { family: fontName.name; pixelSize: 15 }
        anchors.verticalCenter: hour.verticalCenter;
        anchors.right: parent.right;
        anchors.rightMargin: 10;
    }
    Text {
        id: monthday;
        text: Qt.formatDateTime(sysDate, "M")+"月"+Qt.formatDateTime(sysDate, "dd")+"日";
        color: "white";
        font { family: fontName.name; pixelSize: 16 }
        anchors.left: parent.left;
        anchors.leftMargin: 10;
        y: 70;
    }

    function imageSource(num) {
        if (eventModel.eventsForDate(sysDate).length > 0)
            return "images/events/"+num+".png";
        else return "";
    }
    ListView {
        id: todayEvents
        x: 100;
        y: 65;
        width: 200;
        height: 40;
        orientation: ListView.Horizontal;
        layoutDirection: Qt.RightToLeft;

        model: eventModel.eventsForDate(sysDate);
        delegate:  Image {
            id: eventImage;
            width: 30;
            height: 30;

            visible: eventModel.eventsForDate(sysDate).length > 0;
            source: imageSource(modelData.num);
        }
    }

    Canvas {
        anchors.fill: todayRoot;
        Path {
            id: underLine
            startX: 10;  startY: 60;
            PathLine {x: 10;  y: 60;}
            PathLine {x: 290; y: 60;}
        }
        onPaint: {
            var ctx = getContext("2d");
            ctx.lineWidth = 0.6;
            context.strokeStyle = Qt.rgba(1,1,1,0.6);

            context.path = underLine;
            context.stroke();
        }
    }
}
