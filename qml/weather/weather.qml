import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import "js/ajax.js" as Ajax

Item {
    id: weatherRoot;
    width: 200;
    height: 250;
    smooth: true;
    antialiasing: true;

    property var maxTemp: 0
    property var minTemp: 0
    property double average: 0.0

    MultiPointTouchArea {
        id: touchArea
        anchors.fill: parent
        maximumTouchPoints: 10
        mouseEnabled: true

        property point pressPos

        onPressed: {
            for (var i = 0; i < touchPoints.length; i++) {
                var point = touchPoints[i]
                pressPos  = Qt.point(point.x, point.y)
            }
            weatherRoot.z = ++root.highestZ
        }

        onTouchUpdated: {
            for (var i = 0; i < touchPoints.length; i++) {
                var point = touchPoints[i]

                var delta = Qt.point(point.x - pressPos.x, point.y - pressPos.y)
                weatherRoot.x += delta.x
                weatherRoot.y += delta.y
            }
        }

        onReleased: {
            for (var i = 0; i < touchPoints.length; i++) {
                var point = touchPoints[i]
            }
            //weather.z = 1;
        }
    }

    Item {
        id: todayWeather;
        width: 200;
        height: 250;
        x: 0; y: 0;
        visible: true;

        Timer {
            id: refreshTimer;
            interval: 600000;
            repeat: true;
            running: true;
            triggeredOnStart: true;
            onTriggered: refreshTemp();
        }

        Image {
            id: img;
            x: 5;
            y: 10;
            width: 90;
            height: 75
            source: " ";
            MouseArea {
                id: unfoldMouseAreaIamge;
                anchors.fill: parent;
                drag.target: weatherRoot;
                onReleased: {
                    refreshTemp();

                    if (unfold.text == ">") {
                        unfold.text = "<";
                        sigUnfold(">");
                    }
                    else {
                        unfold.text = ">";
                        sigUnfold("<");
                    }
                }
            }
        }

        Text {
            x: 107; y: 0;
            id: temp; text:' '; visible: true; color: "white"; font {family: "Microsoft Yahei"; pixelSize: 55}
            MouseArea {
                id: idTempToF;
                anchors.fill: parent;
                drag.target: weatherRoot;
                onReleased: {
                    temp.visible = false;
                    tempF.visible = true;
                    tempUnit.text = "℉";
                }
            }
        }
        Text {
            x: 110; y: 0;
            id: tempF; text:' '; visible: false; color: "white"; font {family: "Microsoft Yahei"; pixelSize: 55}
            MouseArea {
                id: idTempToC;
                anchors.fill: parent;
                drag.target: weatherRoot;
                onReleased: {
                    temp.visible = true;
                    tempF.visible = false;
                    tempUnit.text = "℃";
                }
            }
        }
        Text {
            y: 65;
            anchors.horizontalCenter: temp.horizontalCenter;
            id: weather; text:' '; color: "white"; font {family: "Microsoft Yahei"; pixelSize: 15}
        }
        Text {
            y: 5;
            id: tempUnit; text: "℃"; color: "white"; font {family: "Microsoft Yahei"; pixelSize: 15}
            anchors.left: temp.right;
        }
        Text {
            y: 25;
            anchors.left: temp.right;
            anchors.leftMargin: 10;
            id: unfold; text: ">"; color: "white"; font {family: "Microsoft Yahei"; pixelSize: 30}

            MouseArea {
                id: unfoldMouseAreaText;
                anchors.fill: parent;
                drag.target: weatherRoot;
                onReleased: {
                    if (unfold.text == ">") {
                        unfold.text = "<";
                        sigUnfold(">");
                    }
                    else {
                        unfold.text = ">";
                        sigUnfold("<");
                    }
                }
            }
        }

        Image {
            id: humidityImage;
            x: 10; y: 115;
            width: 20; height: 30; source: "images/humidity.png";
        }
        Text {
            anchors.left: humidityImage.right;
            anchors.verticalCenter: humidityImage.verticalCenter;
            anchors.leftMargin: 20;
            text: qsTr("湿度"); color: "white"; font {family: "Microsoft Yahei"; pixelSize: 15}
        }
        Text {
            anchors.top: humidityImage.bottom;
            anchors.left: humidityImage.right;
            anchors.topMargin: 10;
            id: humidity; text: ' '; color: "white"; font {family: "Microsoft Yahei"; pixelSize: 25}
        }

        Image {
            id: pmImage
            x: 115; y: 115;
            width: 30; height: 30; source: "images/pm2.5.png";
        }
        Text {
            anchors.left: pmImage.right;
            anchors.verticalCenter: pmImage.verticalCenter;
            anchors.leftMargin: 7;
            id: pmText; text: qsTr("PM2.5"); color: "white"; font {family: "Microsoft Yahei"; pixelSize: 15}
        }
        Text {
            anchors.top: pmImage.bottom;
            anchors.left: pmImage.horizontalCenter;
            anchors.topMargin: 10;
            id: pm25; text: ' '; color: "white"; font {family: "Microsoft Yahei"; pixelSize: 25}
        }
        Text {
            y: 163;
            anchors.left: pm25.right;
            anchors.leftMargin: 3;
            id: quality; text: ' '; color: "white"; font {family: "Microsoft Yahei"; pixelSize: 15}
        }

        Image {
            id: dressImage
            x: 5; y: 220;
            width: 30; height: 30; source: "images/dress.png";
        }
        Text {
            y: 215;
            anchors.right: pmText.right;
            id: brief; text: qsTr("舒适"); color: "white"; font {family: "Microsoft Yahei"; pixelSize: 14}
        }
        Text {
            y: 238;
            anchors.right: pmText.right;
            id: details; text: ''; color: "white"; font {family: "Microsoft Yahei"; pixelSize: 13}
        }
    }

    Item {
        id: futureWeather;
        visible: false;
        x: 200;

        Text {
            x: 30;
            id: city; text: ' '; color: "white"; font {family: "Microsoft Yahei"; pixelSize: 20}
        }
        Text {
            x: 440;
            text: "6日天气走势"; color: "white"; font {family: "Microsoft Yahei"; pixelSize: 20}
        }

        Rectangle { id: center0; x: 65; y: 40; width: 1; height: 1; color: "black"; }

        Column {
            y: 40;
            anchors.horizontalCenter: center0.horizontalCenter;
            spacing: 6;
            Text {
                text: '今天'; color: "white"; font {family: "Microsoft Yahei"; pixelSize: 15}
                anchors.horizontalCenter: parent.horizontalCenter;
            }
            Text {
                id: date0; text:' '; color: "white"; font {family: "Microsoft Yahei"; pixelSize: 15}
                anchors.horizontalCenter: parent.horizontalCenter;
            }
            Text {
                id: weather0; text:' '; color: "white"; font {family: "Microsoft Yahei"; pixelSize: 15}
                anchors.horizontalCenter: parent.horizontalCenter;
            }
            Image {id: img0; source: ''; anchors.horizontalCenter: parent.horizontalCenter;}
        }
        Column {
            anchors.horizontalCenter: center0.horizontalCenter;
            anchors.horizontalCenterOffset: 90;
            y: 40;
            spacing: 6;
            Text {
                id: week1; text: ' '; color: "white"; font {family: "Microsoft Yahei"; pixelSize: 15}
                anchors.horizontalCenter: parent.horizontalCenter;
            }
            Text {
                id: date1; text:' '; color: "white"; font {family: "Microsoft Yahei"; pixelSize: 15}
                anchors.horizontalCenter: parent.horizontalCenter;
            }
            Text {
                id: weather1; text:' '; color: "white"; font {family: "Microsoft Yahei"; pixelSize: 15}
                anchors.horizontalCenter: parent.horizontalCenter;
            }
            Image {id: img1; source: ''; anchors.horizontalCenter: parent.horizontalCenter;}
        }
        Column {
            anchors.horizontalCenter: center0.horizontalCenter;
            anchors.horizontalCenterOffset: 180;
            y: 40;
            spacing: 6;
            Text {
                id: week2; text: ' '; color: "white"; font {family: "Microsoft Yahei"; pixelSize: 15}
                anchors.horizontalCenter: parent.horizontalCenter;
            }
            Text {
                id: date2; text:' '; color: "white"; font {family: "Microsoft Yahei"; pixelSize: 15}
                anchors.horizontalCenter: parent.horizontalCenter;
            }
            Text {
                id: weather2; text:' '; color: "white"; font {family: "Microsoft Yahei"; pixelSize: 15}
                anchors.horizontalCenter: parent.horizontalCenter;
            }
            Image {id: img2; source: ''; anchors.horizontalCenter: parent.horizontalCenter;}
        }
        Column {
            anchors.horizontalCenter: center0.horizontalCenter;
            anchors.horizontalCenterOffset: 270;
            y: 40;
            spacing: 6;
            Text {
                id: week3; text: ' '; color: "white"; font {family: "Microsoft Yahei"; pixelSize: 15}
                anchors.horizontalCenter: parent.horizontalCenter;
            }
            Text {
                id: date3; text:' '; color: "white"; font {family: "Microsoft Yahei"; pixelSize: 15}
                anchors.horizontalCenter: parent.horizontalCenter;
            }
            Text {
                id: weather3; text:' '; color: "white"; font {family: "Microsoft Yahei"; pixelSize: 15}
                anchors.horizontalCenter: parent.horizontalCenter;
            }
            Image {id: img3; source: ''; anchors.horizontalCenter: parent.horizontalCenter;}
        }
        Column {
            anchors.horizontalCenter: center0.horizontalCenter;
            anchors.horizontalCenterOffset: 360;
            y: 40;
            spacing: 6;
            Text {
                id: week4; text: ' '; color: "white"; font {family: "Microsoft Yahei"; pixelSize: 15}
                anchors.horizontalCenter: parent.horizontalCenter;
            }
            Text {
                id: date4; text:' '; color: "white"; font {family: "Microsoft Yahei"; pixelSize: 15}
                anchors.horizontalCenter: parent.horizontalCenter;
            }
            Text {
                id: weather4; text:' '; color: "white"; font {family: "Microsoft Yahei"; pixelSize: 15}
                anchors.horizontalCenter: parent.horizontalCenter;
            }
            Image {id: img4; source: ''; anchors.horizontalCenter: parent.horizontalCenter;}
        }
        Column {
            anchors.horizontalCenter: center0.horizontalCenter;
            anchors.horizontalCenterOffset: 450;
            y: 40;
            spacing: 6;
            Text {
                id: week5; text: ' '; color: "white"; font {family: "Microsoft Yahei"; pixelSize: 15}
                anchors.horizontalCenter: parent.horizontalCenter;
            }
            Text {
                id: date5; text:' '; color: "white"; font {family: "Microsoft Yahei"; pixelSize: 15}
                anchors.horizontalCenter: parent.horizontalCenter;
            }
            Text {
                id: weather5; text:' '; color: "white"; font {family: "Microsoft Yahei"; pixelSize: 15}
                anchors.horizontalCenter: parent.horizontalCenter;
            }
            Image {id: img5; source: ''; anchors.horizontalCenter: parent.horizontalCenter;}
        }
    }

    Canvas {
        id: todaySeparatorLine;
        anchors.fill: parent;
        visible: true;

        Path {
            id: todayLine_1
            startX: 0; startY: 95;
            PathLine {x: 0;   y: 95;}
            PathLine {x: 200; y: 95;}
        }
        Path {
            id: todayLine_2
            startX: 100; startY: 110;
            PathLine {x: 100; y: 110;}
            PathLine {x: 100; y: 190;}
        }
        Path {
            id: todayLine_3
            startX: 0; startY: 200;
            PathLine {x: 0;   y: 200;}
            PathLine {x: 200; y: 200;}
        }

        onPaint: {
            var ctx = getContext("2d");
            ctx.lineWidth = 0.5;
            context.strokeStyle = Qt.rgba(1,1,1,0.9);

            context.path = todayLine_1;
            context.stroke();
            context.path = todayLine_2;
            context.stroke();
            context.path = todayLine_3;
            context.stroke();
        }
    }

    Canvas {
        id: futureSeparatorLine;
        visible: false;
        width: 735;
        height: 360;
        x: 200;

        Path {
            id: futureLine_1
            startX: 20; startY: 40;
            PathLine {x: 20; y: 350;}
            PathLine {x: 20; y: 350;}
        }
        Path {
            id: futureLine_2
            startX: 110; startY: 40;
            PathLine {x: 110; y: 350;}
            PathLine {x: 110; y: 350;}
        }
        Path {
            id: futureLine_3
            startX: 200; startY: 40;
            PathLine {x: 200; y: 350;}
            PathLine {x: 200; y: 350;}
        }
        Path {
            id: futureLine_4
            startX: 290; startY: 40;
            PathLine {x: 290; y: 350;}
            PathLine {x: 290; y: 350;}
        }
        Path {
            id: futureLine_5
            startX: 380; startY: 40;
            PathLine {x: 380; y: 350;}
            PathLine {x: 380; y: 350;}
        }
        Path {
            id: futureLine_6
            startX: 470; startY: 40;
            PathLine {x: 470; y: 350;}
            PathLine {x: 470; y: 350;}
        }
        Path {
            id: futureLine_7
            startX: 560; startY: 40;
            PathLine {x: 560; y: 350;}
            PathLine {x: 560; y: 350;}
        }

        onPaint: {
            var ctx = getContext("2d");
            ctx.lineWidth = 0.5;
            context.strokeStyle = Qt.rgba(1,1,1,0.9);

            context.path = futureLine_1;
            context.stroke();
            context.path = futureLine_2;
            context.stroke();
            context.path = futureLine_3;
            context.stroke();
            context.path = futureLine_4;
            context.stroke();
            context.path = futureLine_5;
            context.stroke();
            context.path = futureLine_6;
            context.stroke();
            context.path = futureLine_7;
            context.stroke();
        }
    }

    Canvas {
        id: futureTrendLine;
        visible: false;
        smooth: true;
        antialiasing: true;
        width: 735;
        height: 360;
        x: 200;

        Text {
            id: highTemp0; text: "0"; color: "white"; font {family: "Microsoft Yahei"; pixelSize: 15}
            x: 60; y: 305 - average*(parseInt(highTemp0.text)-minTemp);
        }
        Text {
            id: highTemp1; text: "0"; color: "white"; font {family: "Microsoft Yahei"; pixelSize: 15}
            x: 150; y: 305 - average*(parseInt(highTemp1.text)-minTemp);
        }
        Text {
            id: highTemp2; text: "0"; color: "white"; font {family: "Microsoft Yahei"; pixelSize: 15}
            x: 240; y: 305 - average*(parseInt(highTemp2.text)-minTemp);
        }
        Text {
            id: highTemp3; text: "0"; color: "white"; font {family: "Microsoft Yahei"; pixelSize: 15}
            x: 330; y: 305 - average*(parseInt(highTemp3.text)-minTemp);
        }
        Text {
            id: highTemp4; text: "0"; color: "white"; font {family: "Microsoft Yahei"; pixelSize: 15}
            x: 420; y: 305 - average*(parseInt(highTemp4.text)-minTemp);
        }
        Text {
            id: highTemp5; text: "0"; color: "white"; font {family: "Microsoft Yahei"; pixelSize: 15}
            x: 510; y: 305 - average*(parseInt(highTemp5.text)-minTemp);
        }

        Text {
            id: lowTemp0; text: "0"; color: "white"; font {family: "Microsoft Yahei"; pixelSize: 15}
            x: 60; y: 335 - average*(parseInt(lowTemp0.text)-minTemp);
        }
        Text {
            id: lowTemp1; text: "0"; color: "white"; font {family: "Microsoft Yahei"; pixelSize: 15}
            x: 150; y: 335 - average*(parseInt(lowTemp1.text)-minTemp);
        }
        Text {
            id: lowTemp2; text: "0"; color: "white"; font {family: "Microsoft Yahei"; pixelSize: 15}
            x: 240; y: 335 - average*(parseInt(lowTemp2.text)-minTemp);
        }
        Text {
            id: lowTemp3; text: "0"; color: "white"; font {family: "Microsoft Yahei"; pixelSize: 15}
            x: 330; y: 335 - average*(parseInt(lowTemp3.text)-minTemp);
        }
        Text {
            id: lowTemp4; text: "0"; color: "white"; font {family: "Microsoft Yahei"; pixelSize: 15}
            x: 420; y: 335 - average*(parseInt(lowTemp4.text)-minTemp);
        }
        Text {
            id: lowTemp5; text: "0"; color: "white"; font {family: "Microsoft Yahei"; pixelSize: 15}
            x: 510; y: 335 - average*(parseInt(lowTemp5.text)-minTemp);
        }

        Rectangle {
            id: highTempArc_0;
            x: 62;
            y:325 - average*(parseInt(highTemp0.text)-minTemp);
            width: 10;
            height: 10;
            color: "white";
            radius: 5;
            smooth: true;
            antialiasing: true;
        }
        Rectangle {
            id: highTempArc_1;
            x: 152;
            y:325 - average*(parseInt(highTemp1.text)-minTemp);
            width: 10;
            height: 10;
            color: "white";
            radius: 5;
            smooth: true;
            antialiasing: true;
        }
        Rectangle {
            id: highTempArc_2;
            x: 242;
            y:325 - average*(parseInt(highTemp2.text)-minTemp);
            width: 10;
            height: 10;
            color: "white";
            radius: 5;
            smooth: true;
            antialiasing: true;
        }
        Rectangle {
            id: highTempArc_3;
            x: 332;
            y:325 - average*(parseInt(highTemp3.text)-minTemp);
            width: 10;
            height: 10;
            color: "white";
            radius: 5;
            smooth: true;
            antialiasing: true;
        }
        Rectangle {
            id: highTempArc_4;
            x: 422;
            y:325 - average*(parseInt(highTemp4.text)-minTemp);
            width: 10;
            height: 10;
            color: "white";
            radius: 5;
            smooth: true;
            antialiasing: true;
        }
        Rectangle {
            id: highTempArc_5;
            x: 512;
            y:325 - average*(parseInt(highTemp5.text)-minTemp);
            width: 10;
            height: 10;
            color: "white";
            radius: 5;
            smooth: true;
            antialiasing: true;
        }

        Rectangle {
            id: lowTempArc_0;
            x: 62;
            y:325 - average*(parseInt(lowTemp0.text)-minTemp);
            width: 10;
            height: 10;
            color: "white";
            radius: 5;
            smooth: true;
            antialiasing: true;
        }
        Rectangle {
            id: lowTempArc_1;
            x: 152;
            y:325 - average*(parseInt(lowTemp1.text)-minTemp);
            width: 10;
            height: 10;
            color: "white";
            radius: 5;
            smooth: true;
            antialiasing: true;
        }
        Rectangle {
            id: lowTempArc_2;
            x: 242;
            y:325 - average*(parseInt(lowTemp2.text)-minTemp);
            width: 10;
            height: 10;
            color: "white";
            radius: 5;
            smooth: true;
            antialiasing: true;
        }
        Rectangle {
            id: lowTempArc_3;
            x: 332;
            y:325 - average*(parseInt(lowTemp3.text)-minTemp);
            width: 10;
            height: 10;
            color: "white";
            radius: 5;
            smooth: true;
            antialiasing: true;
        }
        Rectangle {
            id: lowTempArc_4;
            x: 422;
            y:325 - average*(parseInt(lowTemp4.text)-minTemp);
            width: 10;
            height: 10;
            color: "white";
            radius: 5;
            smooth: true;
            antialiasing: true;
        }
        Rectangle {
            id: lowTempArc_5;
            x: 512;
            y:325 - average*(parseInt(lowTemp5.text)-minTemp);
            width: 10;
            height: 10;
            color: "white";
            radius: 5;
            smooth: true;
            antialiasing: true;
        }

        Path {
            id: highLine
            startX: 67;  startY: 330 - average*(parseInt(highTemp0.text)-minTemp);
            PathLine {x: 67;  y: 330 - average*(parseInt(highTemp0.text)-minTemp);}
            PathLine {x: 157; y: 330 - average*(parseInt(highTemp1.text)-minTemp);}
            PathLine {x: 247; y: 330 - average*(parseInt(highTemp2.text)-minTemp);}
            PathLine {x: 337; y: 330 - average*(parseInt(highTemp3.text)-minTemp);}
            PathLine {x: 427; y: 330 - average*(parseInt(highTemp4.text)-minTemp);}
            PathLine {x: 517; y: 330 - average*(parseInt(highTemp5.text)-minTemp);}
        }

        Path {
            id: lowLine
            startX: 67;  startY: 330 - average*(parseInt(lowTemp0.text)-minTemp);
            PathLine {x: 67;  y: 330 - average*(parseInt(lowTemp0.text)-minTemp);}
            PathLine {x: 157; y: 330 - average*(parseInt(lowTemp1.text)-minTemp);}
            PathLine {x: 247; y: 330 - average*(parseInt(lowTemp2.text)-minTemp);}
            PathLine {x: 337; y: 330 - average*(parseInt(lowTemp3.text)-minTemp);}
            PathLine {x: 427; y: 330 - average*(parseInt(lowTemp4.text)-minTemp);}
            PathLine {x: 517; y: 330 - average*(parseInt(lowTemp5.text)-minTemp);}
        }

        Timer {
            interval: 1000; running: true; repeat: false;
            onTriggered: {
                findTempRange();
                //context.clearRect(0, 0, 800, 350);
                futureTrendLine.requestPaint();
            }
        }

        onPaint: {
            var ctx = getContext("2d");
            ctx.lineWidth = 1;
            context.strokeStyle = Qt.rgba(1,1,1,1);

            context.path = highLine;
            context.stroke();

            context.path = lowLine;
            context.stroke();
        }
    }

    function findTempRange() {
        maxTemp = parseInt(highTemp0.text)
        minTemp = parseInt(lowTemp0.text);

        if (maxTemp < parseInt(highTemp1.text))
            maxTemp = parseInt(highTemp1.text);
        if (maxTemp < parseInt(highTemp2.text))
            maxTemp = parseInt(highTemp2.text);
        if (maxTemp < parseInt(highTemp3.text))
            maxTemp = parseInt(highTemp3.text);
        if (maxTemp < parseInt(highTemp4.text))
            maxTemp = parseInt(highTemp4.text);
        if (maxTemp < parseInt(highTemp5.text))
            maxTemp = parseInt(highTemp5.text);

        if (minTemp > parseInt(lowTemp1.text))
            minTemp = parseInt(lowTemp1.text);
        if (minTemp > parseInt(lowTemp2.text))
            minTemp = parseInt(lowTemp2.text);
        if (minTemp > parseInt(lowTemp3.text))
            minTemp = parseInt(lowTemp3.text);
        if (minTemp > parseInt(lowTemp4.text))
            minTemp = parseInt(lowTemp4.text);
        if (minTemp > parseInt(lowTemp5.text))
            minTemp = parseInt(lowTemp5.text);

        average = 130/(maxTemp - minTemp);
    }

    // 摄氏与华氏转换
    function tempSwitch(ch) {
        if (ch == 'C') {
        }
        if (ch == 'F') {
        }
    }
    // 温度更新
    function refreshTemp() {
        Ajax.get("https://api.thinkpage.cn/v2/weather/all.json?city=Yubei&language=zh-chs&unit=c&aqi=city&key=YKO8M7XEHA",
                 function(result, json) {
                     if (json.status == "OK") {
                         temp.text = json.weather[0].now.temperature;
                         tempF.text = parseInt(parseInt(json.weather[0].now.temperature)*1.8+32);
                         weather.text = json.weather[0].now.text;
                         img.source = "images/3d_60/"+json.weather[0].now.code+".png";
                         humidity.text = json.weather[0].now.humidity+"％";
                         pm25.text = json.weather[0].now.air_quality.city.pm25;
                         quality.text = json.weather[0].now.air_quality.city.quality;
                         details.text = json.weather[0].today.suggestion.dressing.brief;

                         city.text = json.weather[0].city_name;
                         img0.source = "images/3d_60/"+json.weather[0].future[0].code1+".png";
                         weather0.text = json.weather[0].future[0].text;
                         date0.text = Qt.formatDate(json.weather[0].future[0].date, "MM/dd");

                         week1.text = json.weather[0].future[1].day;
                         img1.source = "images/3d_60/"+json.weather[0].future[1].code1+".png";
                         weather1.text = json.weather[0].future[1].text;
                         date1.text = Qt.formatDate(json.weather[0].future[1].date, "MM/dd");

                         week2.text = json.weather[0].future[2].day;
                         img2.source = "images/3d_60/"+json.weather[0].future[2].code1+".png";
                         weather2.text = json.weather[0].future[2].text;
                         date2.text = Qt.formatDate(json.weather[0].future[2].date, "MM/dd");

                         week3.text = json.weather[0].future[3].day;
                         img3.source = "images/3d_60/"+json.weather[0].future[3].code1+".png";
                         weather3.text = json.weather[0].future[3].text;
                         date3.text = Qt.formatDate(json.weather[0].future[3].date, "MM/dd");

                         week4.text = json.weather[0].future[4].day;
                         img4.source = "images/3d_60/"+json.weather[0].future[4].code1+".png";
                         weather4.text = json.weather[0].future[4].text;
                         date4.text = Qt.formatDate(json.weather[0].future[4].date, "MM/dd");

                         week5.text = json.weather[0].future[5].day;
                         img5.source = "images/3d_60/"+json.weather[0].future[5].code1+".png";
                         weather5.text = json.weather[0].future[5].text;
                         date5.text = Qt.formatDate(json.weather[0].future[5].date, "MM/dd");

                         highTemp0.text = json.weather[0].future[0].high+"°";
                         highTemp1.text = json.weather[0].future[1].high+"°";
                         highTemp2.text = json.weather[0].future[2].high+"°";
                         highTemp3.text = json.weather[0].future[3].high+"°";
                         highTemp4.text = json.weather[0].future[4].high+"°";
                         highTemp5.text = json.weather[0].future[5].high+"°";

                         lowTemp0.text = json.weather[0].future[0].low+"°";
                         lowTemp1.text = json.weather[0].future[1].low+"°";
                         lowTemp2.text = json.weather[0].future[2].low+"°";
                         lowTemp3.text = json.weather[0].future[3].low+"°";
                         lowTemp4.text = json.weather[0].future[4].low+"°";
                         lowTemp5.text = json.weather[0].future[5].low+"°";
                     }
                 }
                 );
        findTempRange();
    }

    function sigUnfold(ch) {
        if (ch == "<") {
            foldOpacity.running = true;
            clickedFold.running = true;
        }
        if (ch == ">") {
            unfoldOpacity.running = true;
            futureWeather.visible = true;
            futureSeparatorLine.visible = true;
            futureTrendLine.visible = true;
        }
    }

    PropertyAnimation {
        id: widthUnfold;
        targets: [futureTrendLine];
        property: "width";
        from: 0;
        to: 735;
        duration: 2000;
    }
    PropertyAnimation {
        id: heightUnfold;
        target: weatherRoot;
        property: "height";
        from: 250;
        to: 360;
        duration: 10;
    }
    PropertyAnimation {
        id: unfoldOpacity;
        targets: [futureWeather, futureSeparatorLine, futureTrendLine];
        property: "opacity";
        from: 0;
        to: 1;
        duration: 1000;
    }
    PropertyAnimation {
        id: foldOpacity;
        targets: [futureWeather, futureSeparatorLine, futureTrendLine];
        property: "opacity";
        from: 1;
        to: 0;
        duration: 1000;
    }

    Timer {
        id: clickedFold;
        interval: 1000;
        onTriggered:{
            weatherRoot.width = 200;
            weatherRoot.height = 250;
            futureWeather.visible = false;
            futureSeparatorLine.visible = false;
            futureTrendLine.visible = false;
        }
    }
    Timer {
        id: repeatTrendLine;
        interval: 3000;
        repeat: true;
        triggeredOnStart: true;
        running: futureWeather.visible ? true : false;
        onTriggered:{
            widthUnfold.running = true;
            heightUnfold.running = true;
        }
    }
    Timer {
        id: opacity;
        interval: 14000;
        repeat: true;
        running: futureWeather.visible ? true : false;
        onTriggered:{
            foldOpacity.running = true;
        }
    }
    Timer {
        id: foldFuture;
        interval: 15000;
        repeat: false;
        running: futureWeather.visible ? true : false;
        onTriggered:{
            weatherRoot.width = 200;
            weatherRoot.height = 250;
            futureWeather.visible = false;
            futureSeparatorLine.visible = false;
            futureTrendLine.visible = false;
            unfold.text = ">";
        }
    }
}
