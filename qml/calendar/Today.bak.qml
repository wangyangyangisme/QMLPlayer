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
            weekdayE.text = Qt.formatDateTime(sysDate, "dddd");
            weekdayC.text = getWeek();
        }
    }
    Text {
        id: weekdayE;
        text: Qt.formatDateTime(sysDate, "dddd");
        color: "white";
        font { family: fontName.name; pixelSize: 18 }
        anchors.top: hour.top;
        anchors.right: parent.right;
        anchors.rightMargin: 30;
    }
    Text {
        id: weekdayC;
        text: getWeek();
        color: "white";
        font { family: fontName.name; pixelSize: 18 }
        anchors.bottom: hour.bottom;
        anchors.right: parent.right;
        anchors.rightMargin: 30;
    }
    function getWeek() {
        var week;
        switch(Qt.formatDateTime(sysDate, "dddd")) {
        case "Monday":    week = "星期一"; break;
        case "Tuesday":   week = "星期二"; break;
        case "Wednesday": week = "星期三"; break;
        case "Thursday":  week = "星期四"; break;
        case "Friday":    week = "星期五"; break;
        case "Saturday":  week = "星期六"; break;
        case "Sunday":    week = "星期日"; break;
        default: break;
        }
        return week;
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
