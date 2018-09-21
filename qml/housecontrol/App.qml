import QtQuick 2.4
import QtQml 2.2
import QtQuick.Controls 1.1
import QtQuick.Dialogs 1.0
import UartT 1.0
import "../../js/Database.js" as Db

Rectangle {
    id: itemRoot;
    width: 650;
    height: 300;
    color: "lightyellow";

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
            itemRoot.z = ++root.highestZ
        }

        onTouchUpdated: {
            for (var i = 0; i < touchPoints.length; i++) {
                var point = touchPoints[i]

                var delta = Qt.point(point.x - pressPos.x, point.y - pressPos.y)
                itemRoot.x += delta.x
                itemRoot.y += delta.y
            }
        }

        onReleased: {
            for (var i = 0; i < touchPoints.length; i++) {
                var point = touchPoints[i]
            }
            //itemRoot.z = 1;
        }
    }

    /*
    Rectangle {
        id: colose
        width: 60
        height: 60
        radius: width / 2
        color: "red"
        opacity: 1

        x: parent.width - width + (width / 3)
        y: - height / 3
        z: parent.z + 1

        Text {
            id: textClose
            anchors.centerIn: parent
            text: "X"
        }
        MouseArea {
            id: closeArea
            anchors.fill: colose
            onPressed: {
                textClose.text = textClose.text == "X" ? "Y" : "X"
                itemRoot.destroy();
            }
        }
    }
*/

    property string localMac: ' '
    property string remoteMac: ' '
    property string localPanid: ' '
    property string localChannel: ' '

    Column {
        id: idColumn;
        spacing: 20;

        function parse_all(type, mac, dat)
        {
            switch (type)
            {
            case 0x96:
                if (l >= 11)
                {
                    localMac = mac    // utA.getString(qs, 0, 16)
                    localPanid = utA.getString(dat, 0, 2)
                    localChannel = utA.getString(dat, 2, 1)
                }
                break;

            case 0xD2:
                unpowerButton.visible = true
                empowerButton.visible = true

                remoteMac = mac     // utA.getString(qs, 0, 16)
                parse_data_0xD2(dat)
                break;

            case 0x69:
                Db.removeRecord(mac)
                Db.insertRecord(mac)
                idColumn.updateRecords()
                break;
            }
        }

        // 0:0x55 1:type 2:len 3 4 5:信息标签
        // 6:len  7:内容
        function parse_data_0xD2(dat)
        {
            if(utA.getByte(dat, 1)==0x40)
                console.log("ok")
            var totle_len = utA.getByte(dat, 2)
            var start = 5
            var t_type
            var t_len = 0
            for (var i = 0; i < totle_len;)
            {
                t_type = utA.getByte(dat, start)
                t_len = utA.getByte(dat, start + 1)
                utA.qmlDebug(t_type)    //len
                switch(t_type)
                {
                case 0x01:  //设备ID
                    break;

                case 0x03:  //设备类型
                    break;

                case 0x0f:  //ID激活码
                    break;
                }

                start = start + 2 + t_len
                i = i + 2 + t_len
            }
        }

        function updateRecords()
        {
            recordsListModel.clear()
            var records = Db.getRecords()
            for (var i = 0; i < records.length; i++)
            {
                recordsListModel.append({ "recordId": records[i].id, "recordContent": records[i].content })
            }
        }

        ListModel {
            id: recordsListModel
        }

        UartThread {
            id: utA;
            onStarted: console.log("onStarted !");
            onUartQml: console.log("uart to qml !", qs);
            onMessageToQml: idColumn.parse_all(type, mac, dat);
            onScanDevRes: console.log("scan dev name: ",dev_name," dev addr: ",dev_addr);
            onScanDevEnd: console.log("scan end !!! ");
            onConnectedSuccess: console.log("Connect Success !!! ");
            onConnectedError: console.log("Connect Error !!! ");
        }

        /*
        Row{
            spacing: 20
            Text {
                text: "received data:"
                color: "#ffFFff"
                font { family: "微软雅黑"; bold: true; pointSize: 20}
            }
            Text {
                id: receivedText
                text: ' '
                color: "#ffFFff"
                font { family: "微软雅黑"; bold: true; pointSize: 15}
            }
        }
*/

        Row{
            spacing: 20

            Button {
                id:pairdSettingButton
                width: 100; height: 50
                Text {
                    anchors.centerIn: parent;
                    text: "信道匹配"
                    color: "red"
                    font { family: "微软雅黑"; bold: true; pointSize: 20}
                }
                onClicked: {
                    utA.sendString(0x87, localMac, null)
                }
            }

            Button {
                id:pairdCancleButton
                width: 100; height: 50
                Text {
                    anchors.centerIn: parent;
                    text: "取消匹配"
                    color: "red"
                    font { family: "微软雅黑"; bold: true; pointSize: 20}
                }
                onClicked: {
                    utA.sendString(0x78, localMac, null)
                }
            }
        }

        Row{
            spacing: 20

            Button {
                id:empowerButton
                width: 100; height: 50
                Text{
                    anchors.centerIn: parent;
                    text: "授权"
                    color: "red"
                    font { family: "微软雅黑"; bold: true; pointSize: 20}
                }
                onClicked: {
                    utA.sendString(0x5A, remoteMac, null)
                }
            }

            Button {
                id:unpowerButton
                width: 100; height: 50
                Text {
                    anchors.centerIn: parent;
                    color: "red"
                    text: "取消授权"
                    font { family: "微软雅黑"; bold: true; pointSize: 20}
                }
                onClicked: {
                    utA.sendString(0xA5, remoteMac, "10")
                }
            }
        }

        Row{
            spacing: 20
            Rectangle {
                id:settings
                color: "red"
                width: 80; height: 30
                Text{
                    text:"Settings"
                    color: "#ffFFff"
                    font.family: "微软雅黑"
                }
                MouseArea{
                    onClicked:utA.settings()
                    anchors.fill: parent
                }
                visible:true
            }
            Rectangle {
                id:settings1
                color: "red"
                width: 80; height: 30
                Text{
                    text:"scan"
                    color: "#ffFFff"
                    font.family: "微软雅黑"
                }
                MouseArea{
                    onClicked: {
                        utA.scanning4Device();
                        console.log("scan");
                    }
                    anchors.fill: parent

                }
                visible:true
            }
            Rectangle {
                id:settings2
                color: "red"
                width: 80; height: 30
                Text{
                    text:"stop scan"
                    color: "#ffFFff"
                    font.family: "微软雅黑"
                }
                MouseArea{
                    onClicked:{
                        utA.stopScanning()
                        console.log("stop scan");
                    }
                    anchors.fill: parent
                }
                visible:true
            }
            Rectangle {
                id:settings3
                color: "red"
                width: 100; height: 30
                Text{
                    text:"disconnect"
                    color: "#ffFFff"
                    font.family: "微软雅黑"
                }
                MouseArea{
                    onClicked:{
                        utA.disconnect()
                        console.log("disconnect");
                    }
                    anchors.fill: parent
                }
                visible:true
            }
            Rectangle {
                id:settings4
                color: "red"
                width: 80; height: 30
                Text{
                    text:"connect"
                    color: "#ffFFff"
                    font.family: "微软雅黑"
                }
                MouseArea{
                    onClicked:{
                        utA.connect2device("80:EA:CA:00:03:02")
                        console.log("connect");
                    }
                    anchors.fill: parent
                }
                visible:true
            }
            Rectangle {
                id:settings5
                color: "red"
                width: 80; height: 30
                Text{
                    text:"sendData1"
                    color: "#ffFFff"
                    font.family: "微软雅黑"
                }
                MouseArea{
                    onClicked:{
                        utA.sendData("LIGHT:10")
                        console.log("connect");
                    }
                    anchors.fill: parent
                }
            }
            Rectangle {
                id:settings6
                color: "red"
                width: 80; height: 30
                Text{
                    text:"sendData2"
                    color: "#ffFFff"
                    font.family: "微软雅黑"
                }
                MouseArea{
                    onClicked:{
                        utA.sendData("LIGHT:300")
                        console.log("connect");
                    }
                    anchors.fill: parent
                }
            }
        }
        Item {
            y: 140;
            Component {
                id: contactDelegate
                Item {
                    width: 180; height: 60
                    Row {
                        spacing: 20
                        Text {
                            text: model.recordId
                            color: "lightpink"
                            font { family: "微软雅黑"; bold: true; pointSize: 30}
                        }

                        Button {
                            width: 50; height: 50
                            Text {
                                anchors.centerIn: parent;
                                text:"X"
                                color: "white"
                                font { family: "微软雅黑"; bold: true; pointSize: 20}
                            }
                            onClicked: {
                                Db.removeRecordi(model.recordId)
                                idColumn.updateRecords()
                            }
                        }

                        /*
                        Text {
                            text: model.recordContent
                            color: "yellow"
                            font { family: "微软雅黑"; bold: true; pointSize: 20}
                        }
*/

                        Rectangle {
                            color: "red"
                            width: 50; height: 50
                            Text {
                                anchors.centerIn: parent;
                                text:"红"
                                color: "#ffFFff"
                                font { family: "微软雅黑"; bold: true; pointSize: 20}
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    utA.sendString(0xB4, model.recordContent, "55  21 07 00 00  04 05 14 ff 00 00 00 00 0e")
                                }
                            }
                        }
                        Rectangle {
                            color: "#00ff00"
                            width: 50; height: 50
                            Text {
                                anchors.centerIn: parent;
                                text:"绿"
                                color: "#ffFFff"
                                font { family: "微软雅黑"; bold: true; pointSize: 20}
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    utA.sendString(0xB4, model.recordContent, "55  21 07 00 00  04 05 14 00 FF 00 00 00 0e")
                                }
                            }
                        }
                        Rectangle {
                            color: "#0000ff"
                            width: 50; height: 50
                            Text{
                                anchors.centerIn: parent;
                                text:"蓝"
                                color: "#ffFFff"
                                font { family: "微软雅黑"; bold: true; pointSize: 20}
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked:{
                                    utA.sendString(0xB4, model.recordContent, "55  21 07 00 00  04 05 14 00 00 FF 00 00 0e")
                                }
                            }
                        }
                        Rectangle {
                            color: "lightpink"
                            width: 50; height: 50
                            Text {
                                anchors.centerIn: parent;
                                text:"白"
                                color: "#ffFFff"
                                font { family: "微软雅黑"; bold: true; pointSize: 20}
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked:{
                                    utA.sendString(0xB4, model.recordContent, "55  21 07 00 00  04 05 14 00 00 00 FF 00 0e")
                                }
                            }
                        }
                    }
                }
            }

            ListView {
                anchors.fill: parent
                spacing: 5
                model: recordsListModel
                delegate: contactDelegate
            }
        }
    }

    Component.onCompleted: {
        utA.start()
        Db.init()
        idColumn.updateRecords()
    }
}





/*

        Row{
            spacing: 20

            Rectangle {
                id:settings
                color: "red"
                width: 80; height: 30
                Text{
                    text:"Settings"
                    color: "#ffFFff"
                    font { family: "微软雅黑"; bold: true; pointSize: 20}
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        utA.settings()
                    }
                }
            }
        }


            Text {
                id:remote
                text:"远程从机信息"
            }

            Text {
                id:remote_mac_tv
                text:"mac:"
            }
            Text {
                id:remote_mac
                text:"111"
            }

            Text {
                id:remote_verify_info_tv
                text:"verify:"
            }
            Text {
                id:remote_verify_info
                text:""
            }

        TextField {
            id: sendD
            objectName: "sendfield"
            text: ' '
            placeholderText: "send data ..."
            font { family: "微软雅黑"; bold: true; pointSize: 20}
        }

        Row{
            spacing: 20
            Text {
                id:local_mac_tv
                text: "mac:"
                color: "#ffFFff"
                font { family: "微软雅黑"; bold: true; pointSize: 20}
            }
            Text {
                id:local_mac
                text:""
                color: "#ffFFff"
                font { family: "微软雅黑"; bold: true; pointSize: 20}
            }
            Text {
                id:local_panid_tv
                text:"panid:"
                color: "#ffFFff"
                font { family: "微软雅黑"; bold: true; pointSize: 20}
            }
            Text {
                id:local_panid
                text:""
                color: "#ffFFff"
                font { family: "微软雅黑"; bold: true; pointSize: 20}
            }
            Text {
                id:local_channel_tv
                text:"channel:"
                color: "#ffFFff"
                font { family: "微软雅黑"; bold: true; pointSize: 20}
            }
            Text {
                id:local_channel
                text:""
                color: "#ffFFff"
                font { family: "微软雅黑"; bold: true; pointSize: 20}
            }
        }
*/
