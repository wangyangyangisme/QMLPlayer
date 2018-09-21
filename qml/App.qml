import QtQuick 2.4
import QtQuick.Controls 1.1

import UartT 1.0
import "../js/Database.js" as Db
import QtQml 2.2
import QtQuick.Dialogs 1.0


ApplicationWindow
{
    visible: true
    width: 800
    height: 480
    //title: qsTr("测试QML于C++的交互")
    color: "#000000"

    Item {
        width: 600; height: 400
        anchors.fill: parent

        Column {
            //anchors.centerIn: parent
            //anchors.left: 100
            spacing: 20
            id:column_id

            //0:0x55 1:type 2:len 3 4 5:信息标签
            // 6:len 7:内容
            function parse_data_0xD2(dat){
                if(utA.getByte(dat, 1)==0x40)
                    console.log("ok")
                var totle_len = utA.getByte(dat, 2)//0f
                var start = 5
                var t_type
                var t_len = 0
                for (var i = 0; i < totle_len;) {
                    t_type = utA.getByte(dat, start)
                    t_len = utA.getByte(dat, start + 1)
                    utA.qmlDebug(t_type)//len
                    switch(t_type){
                    case 0x01://设备ID
                        break
                    case 0x03://设备类型
                        break
                    case 0x0f://ID激活码

                        break
                    }

                    start = start + 2 + t_len
                    i = i + 2 + t_len
                }
            }

            function parse_all(type,mac,dat){
                switch (type){
                case 0x96:
                    if (l >= 11){
                        local_mac.text = mac//utA.getString(qs,0,16)
                        local_panid.text = utA.getString(dat,0,2)
                        local_channel.text = utA.getString(dat,2,1)
                    }
                    //console.log("ok",qs,"   len ",l,"   type", type)
                    break;
                case 0xD2:
                    //
                    remote_unverify.visible=true
                    remote_verify.visible=true
                    remote_mac.text = mac//utA.getString(qs,0,16)
                    parse_data_0xD2(dat)
                    break;
                case 0x69:
                    Db.removeRecord(mac)
                    Db.insertRecord(mac)
                    column_id.updateRecords()

                    //console.log("ok",qs,"   len ",l,"   type", type)
                    break;
                }
            }

            Row{
                spacing: 20
                Text {
                    text:"received data:"
                    color: "#ffFFff"
                    font.family: "微软雅黑"
                    font.bold: true
                    font.pointSize: 12
                    visible:true
                }
                Text {
                    id:receiveD
                    text:" "
                    color: "#ffFFff"
                    font.family: "微软雅黑"
                    font.bold: true
                    font.pointSize: 12
                    visible:true
                }
            }

            TextField {
                id:sendD
                objectName:"sendfield"
                text:""
                //color: "#ffFFff"
                font.family: "微软雅黑"
                font.bold: true
                font.pointSize: 12
                placeholderText:"send data ..."
                visible:true
            }

            /*Button {
                text:"send"
                onClicked:utA.writeUart(sendD.text)
            }*/

            Row{
                spacing: 20
                /*Button {
                    text:"获取本机信息"
                    onClicked:utA.sendString(0x96,local_mac.text,null)
                }*/

                Text {
                    id:local_mac_tv
                    text:"mac:"
                    color: "#ffFFff"
                    font.family: "微软雅黑"
                    font.bold: true
                    font.pointSize: 12
                    visible:true
                }
                Text {
                    id:local_mac
                    text:""
                    color: "#ffFFff"
                    font.family: "微软雅黑"
                    font.bold: true
                    font.pointSize: 12
                    visible:true
                }
                Text {
                    id:local_panid_tv
                    text:"panid:"
                    color: "#ffFFff"
                    font.family: "微软雅黑"
                    font.bold: true
                    font.pointSize: 12
                    visible:true
                }
                Text {
                    id:local_panid
                    text:""
                    color: "#ffFFff"
                    font.family: "微软雅黑"
                    font.bold: true
                    font.pointSize: 12
                    visible:true
                }
                Text {
                    id:local_channel_tv
                    text:"channel:"
                    color: "#ffFFff"
                    font.family: "微软雅黑"
                    font.bold: true
                    font.pointSize: 12
                    visible:true
                }
                Text {
                    id:local_channel
                    text:""
                    color: "#ffFFff"
                    font.family: "微软雅黑"
                    font.bold: true
                    font.pointSize: 12
                    visible:true
                }
            }

            Row{
                spacing: 20

                Rectangle {
                    id:paird_setting
                    color: "red"
                    width: 100; height: 30
                    Text{
                        text:"信道匹配"
                        color: "#ffffff"
                        font.family: "微软雅黑"
                        font.bold: true
                        font.pointSize: 12
                    }
                    MouseArea{
                        onClicked:utA.sendString(0x87,local_mac.text,null)
                        anchors.fill: parent
                    }
                    visible:true
                }

                Rectangle {
                    id:paird_cancle
                    color: "red"
                    width: 100; height: 30
                    Text{
                        text:"取消匹配"
                        color: "#ffffff"
                        font.family: "微软雅黑"
                        font.bold: true
                        font.pointSize: 12
                    }
                    MouseArea{
                        onClicked:utA.sendString(0x78,local_mac.text,null)
                        anchors.fill: parent
                    }
                    visible:true
                }
                /*Button {
                    text:"设置信道可以匹配"
                    onClicked:utA.sendString(0x87,local_mac.text,null)
                }

                Button {
                    text:"取消匹配其他设备"
                    onClicked:utA.sendString(0x78,local_mac.text,null)
                }*/
            }

            Row{
                spacing: 20
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
                    text:""
                }

                Text {
                    id:remote_verify_info_tv
                    text:"verify:"
                }
                Text {
                    id:remote_verify_info
                    text:""
                }

                Rectangle {
                    id:remote_verify
                    color: "red"
                    width: 100; height: 30
                    Text{
                        text:"授权"
                        color: "#ffffff"
                        font.family: "微软雅黑"
                    }
                    MouseArea{
                        onClicked:utA.sendString(0x5A,remote_mac.text,null)
                        anchors.fill: parent
                    }
                    visible:false
                }

                Rectangle {
                    id:remote_unverify
                    color: "red"
                    width: 100; height: 30
                    Text{
                        color: "#ffffff"
                        text:"取消授权"
                        font.family: "微软雅黑"
                    }
                    MouseArea{
                        onClicked:utA.sendString(0xA5,remote_mac.text,"10")
                        anchors.fill: parent
                    }
                    visible:false
                }

                /*Button {
                    id:remote_verify
                    text:"授权"
                    onClicked:utA.sendString(0x5A,remote_mac.text,null)
                    visible:false
                }
                Button {
                    id:remote_unverify
                    text:"非授权"
                    onClicked:utA.sendString(0xA5,remote_mac.text,"10")
                    visible:false
                }*/
            }

            //            Row{
            //                spacing: 20
            //                Text {
            //                    id:light
            //                    text:""
            //                    visible:true
            //                }
            //                Button {
            //                    id:open_light
            //                    text:"开灯"
            //                    onClicked:utA.setRemoteInfo(light.text,1)
            //                    visible:false
            //                }
            //                Button {
            //                    id:close_light
            //                    text:"关灯"
            //                    onClicked:utA.setRemoteInfo(light.text,0)
            //                    visible:false
            //                }
            //            }

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
                        onClicked:utA.Scanning4Device()
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
                        onClicked:utA.StopScanning()
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
                        onClicked:utA.disconnect()
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
                        onClicked:utA.connect2device("80:EA:CA:00:03:02")
                        anchors.fill: parent
                    }
                    visible:true
                }
                Rectangle {
                    id:settings5
                    color: "red"
                    width: 80; height: 30
                    Text{
                        text:"sendData"
                        color: "#ffFFff"
                        font.family: "微软雅黑"
                    }
                    MouseArea{
                        onClicked:utA.sendData("1234567890abcdef")
                        anchors.fill: parent
                    }
                    visible:true
                }
            }

            /*Row{
                spacing: 20
                Button {
                    text:"还原本机信道"
                    //MouseArea {
                    onClicked:utA.setLocalInfo(local_mac.text,local_panid.text,local_channel.text)
                    //}
                }
            }*/
            /*Row{
                PieChart {
                    id: chartA
                    chartId: 100
                    width: 100; height: 100

                    pieSlice: PieSlice {
                        anchors.fill: parent
                        color: "red"
                        fromAngle: 0; angleSpan: 360
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: chartA.pieSlice.color = "red"
                    }

                    onChartCleared: console.log("aaaaa")
                    onToQml: console.log("aaaaaa!!!!!!!!!!!!!!!!!!!!")
                }

                PieChart {
                    id: chartB
                    chartId: 200
                    width: 200; height: 200

                    slices: [
                         PieSlice {
                        anchors.fill: parent
                        color: "red"
                        fromAngle: 0; angleSpan: 110
                    },
                    PieSlice {
                        anchors.fill: parent
                        color: "black"
                        fromAngle: 110; angleSpan: 50
                    },
                        PieSlice {
                            anchors.fill: parent
                            color: "blue"
                            fromAngle: 160; angleSpan: 100
                        }
                    ]

                    MouseArea {
                        anchors.fill: parent
                        onClicked: { chartA.pieSlice.color = Qt.rgba(Math.random(), Math.random(), Math.random(), 1) }
                    }
                    onChartCleared: console.log("bbbbb")
                    onToQml: console.log("bbbbbb!!!!!!!!!!!!!!!!!!!!")
                }
            }*/
            UartThread {
                id:utA
                //width: 100; height: 100
                onStarted:console.log("onStarted !!!!!!!!!!!!!!!!!!!")
                onUartQml:console.log("uart to qml !!!!!!!!!!!!!!!!!!!",qs),receiveD.text = qs
                //                onLocalMac:local_mac.text = qs
                //                onLocalPanid:local_panid.text = qs
                //                onLocalChannel:local_channel.text = qs
                //                onRemoteMac:remote_mac.text = qs
                //onVerifyOK:console.log("ok  ",qs),Db.removeRecord(qs),Db.insertRecord(qs,ds),column_id.updateRecords()
                //                onRemoteVerifyID:remote_verify_info.text = qs,remote_unverify.visible=true,remote_verify.visible=true
                onMessageToQml:column_id.parse_all(type,mac,dat)
                onScanDevRes:console.log("scan dev name: ",dev_name," dev addr: ",dev_addr)
                onScanDevEnd:console.log("scan end !!! ")
                onConnectedSuccess:console.log("Connect Success !!! ")
                onConnectedError:console.log("Connect Error !!! ")
                //onRemotePanid:remote_panid.text = qs
                //onRemoteChannel:remote_channel.text = qs
            }

            Component.onCompleted: utA.start(),Db.init(),column_id.updateRecords()//,console.log("The pie is colored " + chartA.pieSlice.color)

            ListModel {
                id: recordsListModel
                Component.onCompleted: {

                }
            }

            function updateRecords() {
                recordsListModel.clear()
                var records = Db.getRecords()
                for (var i = 0; i < records.length; i++) {
                    recordsListModel.append({ "recordId": records[i].id, "recordContent": records[i].content })
                }
            }


            Rectangle {
                width: 180; height: 240

                Component {
                    id: contactDelegate
                    Item {
                        width: 180; height: 60
                        Row {
                            spacing: 20
                            Text {
                                //id:"d"
                                text: model.recordId
                                color: "#ffFFff"
                                font.family: "微软雅黑"
                                font.bold: true
                                font.pointSize: 12
                            }

                            Rectangle {
                                //id:remote_verify
                                color: "red"
                                width: 50; height: 30
                                Text{
                                    text:"X"
                                    color: "#ffFFff"
                                    font.family: "微软雅黑"
                                    font.bold: true
                                    font.pointSize: 12
                                }
                                MouseArea{
                                    onClicked:Db.removeRecordi(model.recordId),
                                              column_id.updateRecords()
                                    anchors.fill: parent
                                }
                                //visible:false
                            }

                            //                            Button {
                            //                                text: "x"
                            //                                //color: "#00FF00"
                            //                                onClicked: {
                            //                                    //utA.removeDevice(model.recordId)
                            //                                    Db.removeRecordi(model.recordId)
                            //                                    column_id.updateRecords()
                            //                                }
                            //                            }
                            Text {
                                text: model.recordContent
                                color: "#ffFFff"
                                font.family: "微软雅黑"
                                font.bold: true
                                font.pointSize: 12
                            }
                            Rectangle {
                                //id:remote_verify
                                color: "red"
                                width: 50; height: 30
                                Text{
                                    text:"红"
                                    color: "#ffFFff"
                                    font.family: "微软雅黑"
                                    font.bold: true
                                    font.pointSize: 12
                                }
                                MouseArea{
                                    onClicked:utA.sendString(0xB4,model.recordContent,"55  21 07 00 00  04 05 14 ff 00 00 00 00 0e")
                                    //visible:true
                                    anchors.fill: parent
                                }
                                visible:true
                            }


                            //                            Button {
                            //                                text:"红"
                            //                                //color: "#00FF00"
                            //                                //Qt.rgba(Math.random(), Math.random(), Math.random(), 1)

                            //                                onClicked:utA.sendString(0xB4,model.recordContent,"55  21 07 00 00  04 05 14 ff 00 00 00 00 0e")
                            //                                visible:true
                            //                            }

                            Rectangle {
                                //id:remote_verify
                                color: "#00ff00"
                                width: 50; height: 30
                                Text{
                                    text:"绿"
                                    color: "#ffFFff"
                                    font.family: "微软雅黑"
                                    font.bold: true
                                    font.pointSize: 12
                                }
                                MouseArea{
                                    onClicked:utA.sendString(0xB4,model.recordContent,"55  21 07 00 00  04 05 14 00 FF 00 00 00 0e")
                                    //visible:true
                                    anchors.fill: parent
                                }
                                visible:true
                            }
                            //                            Button {
                            //                                text:"绿"
                            //                                //color: "#00FF00"
                            //                                //Qt.rgba(Math.random(), Math.random(), Math.random(), 1)

                            //                                onClicked:utA.sendString(0xB4,model.recordContent,"55  21 07 00 00  04 05 14 00 FF 00 00 00 0e")
                            //                                visible:true
                            //                            }

                            Rectangle {
                                //id:remote_verify
                                color: "#0000ff"
                                width: 50; height: 30
                                Text{
                                    text:"蓝"
                                    color: "#ffFFff"
                                    font.family: "微软雅黑"
                                    font.bold: true
                                    font.pointSize: 12
                                }
                                MouseArea{
                                    onClicked:utA.sendString(0xB4,model.recordContent,"55  21 07 00 00  04 05 14 00 00 FF 00 00 0e")
                                    //visible:true
                                    anchors.fill: parent
                                }
                                visible:true
                            }

                            //                            Button {
                            //                                text:"蓝"
                            //                                //bgcolor: "#00FF00"
                            //                                //Qt.rgba(Math.random(), Math.random(), Math.random(), 1)

                            //                                onClicked:utA.sendString(0xB4,model.recordContent,"55  21 07 00 00  04 05 14 00 00 FF 00 00 0e")
                            //                                visible:true
                            //                            }

                            Rectangle {
                                //id:remote_verify
                                color: "#ff00ff"
                                width: 50; height: 30
                                Text{
                                    text:"白"
                                    color: "#ffFFff"
                                    font.family: "微软雅黑"
                                    font.bold: true
                                    font.pointSize: 12
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked:utA.sendString(0xB4,model.recordContent,"55  21 07 00 00  04 05 14 00 00 00 FF 00 0e")
                                    //visible:true
                                }
                                visible:true
                            }

                            //                            Button {
                            //                                text:"白"
                            //                                //color: "#00FF00"
                            //                                //Qt.rgba(Math.random(), Math.random(), Math.random(), 1)

                            //                                onClicked:utA.sendString(0xB4,model.recordContent,"55  21 07 00 00  04 05 14 00 00 00 FF 00 0e")
                            //                                visible:true
                            //                            }
                            /*Button {
                                text:"颜色"
                                onClicked:dialog.visible = true
                                visible:true
                            }
                            ColorDialog {
                                id:dialog
                                onAccepted:d.color = color,console.debug(color)
                            }*/
                        }
                    }
                }

                ListView {
                    model: recordsListModel
                    anchors.fill: parent

                    //x: 16; y: 30
                    //width: display.width
                    //height: display.height - 50 - y
                    //color: "#ffFFff"
                    //highlight: Rectangle { color: "blue"; radius: 5 }
                    spacing: 5
                    delegate: contactDelegate
                }
            }
        }
    }
}
