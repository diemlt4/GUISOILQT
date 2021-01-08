import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.3

Window {
    visible: true
    width: 1000
    height: 600
    title: qsTr("Hello World")
    RowLayout
    {
        anchors.fill: parent
        spacing: 0
        Rectangle
        {
            Layout.preferredWidth: 250
            Layout.fillHeight: true
            //color: '#ccb'
            ColumnLayout
            {
                anchors.fill: parent
                spacing: 0
                SingleButton
                {
                    fillWidth: true
                    text: "Connect Database"
                    color: Material.Orange
                }
                Title
                {
                    text: "Control Sensor"
                    color: '#ccc'
                    anchors.leftMargin: 5
                    Layout.fillWidth: true
                }

                SingleButton
                {
                    text: "Manual Data"
                    fillWidth: true
                    onClicked:
                    {
                        //Services.getTransactionData("sensor");
                        Services.refreshList();
                    }

                }

                Rectangle
                {
                    height: 1
                    Layout.fillWidth: true
                    color: '#ccc'
                }
                DoubleButton
                {
                    titleLeft: "Auto"
                    titleRight: "Stop"

                }

                Title
                {
                    text: "Control Plasma"
                    color: '#ccc'
                    Layout.fillWidth: true
                }
                RowLayout
                {
                    Layout.fillWidth: true
                    Layout.maximumHeight: 40
                    Label
                    {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        verticalAlignment: "AlignVCenter"
                        font.bold: true
                        leftPadding: 10
                        font.pixelSize: 13
                        font.capitalization: Font.AllUppercase
                        text: "Node Address"
                    }
                    Rectangle
                    {
                        Layout.preferredWidth: 1
                        Layout.fillHeight: true
                        color: '#ccc'
                    }

                    TextField
                    {
                        Layout.preferredWidth: 120
                        Layout.fillHeight: true
                        id: plsAddr
                        horizontalAlignment: "AlignRight"
                        bottomPadding: 8
                        background: Rectangle{color: 'transparent'}
                        leftPadding: 8
                        rightPadding: 10
                        placeholderText: "Node Address"
                    }

                }
                Rectangle
                {
                    height: 1
                    Layout.fillWidth: true
                    color: '#ccc'
                }
                DoubleButton
                {
                    titleLeft: "ON"
                    titleRight: "OFF"
                }
                Rectangle
                {
                    height: 1
                    Layout.fillWidth: true
                    color: '#ccc'
                }
                SingleButton
                {
                    text: "Status"
                    fillWidth: true
                    color: Material.Green
                }
                Rectangle
                {
                    height: 1
                    Layout.fillWidth: true
                    color: '#ccc'
                }
                RowLayout
                {
                    Layout.maximumHeight: 50
                    Layout.fillWidth: true
                    spacing: 0
                    SingleButton
                    {
                        fillWidth: true
                        text: "Dimming"
                        color: Material.LightBlue
                    }
                    Rectangle
                    {
                        Layout.fillHeight: true
                        Layout.preferredWidth: 1
                        color: '#ccc'
                    }
                    TextField
                    {
                        Layout.preferredWidth: 120
                        Layout.fillHeight: true
                        id: plsDimm
                        horizontalAlignment: "AlignRight"
                        bottomPadding: 8
                        background: Rectangle{color: 'transparent'}
                        leftPadding: 8
                        rightPadding: 10
                        placeholderText: "Dimming Light"
                    }
                }
                Rectangle
                {
                    height: 1
                    Layout.fillWidth: true
                    color: '#ccc'
                }
                RowLayout
                {
                    Layout.maximumHeight: 50
                    Layout.fillWidth: true
                    spacing: 0
                    SingleButton
                    {
                        fillWidth: true
                        text: "Set Addr"
                        color: Material.LightBlue
                    }
                    Rectangle
                    {
                        Layout.fillHeight: true
                        Layout.preferredWidth: 1
                        color: '#ccc'
                    }
                    TextField
                    {
                        Layout.preferredWidth: 120
                        Layout.fillHeight: true
                        id: plsRS485
                        horizontalAlignment: "AlignRight"
                        bottomPadding: 8
                        background: Rectangle{color: 'transparent'}
                        leftPadding: 8
                        rightPadding: 10
                        placeholderText: "RS485 Addr"
                    }
                }
                Rectangle
                {
                    height: 1
                    Layout.fillWidth: true
                    color: '#ccc'
                }
                Item {
                    Layout.fillHeight: true
                }
            }
        }

        Rectangle
        {
            Layout.preferredWidth: 500
            Layout.fillHeight: true
            color: '#ccc'
            ColumnLayout
            {
                anchors.fill: parent
                spacing: 0
                RowLayout
                {
                    Layout.preferredHeight: 32
                    Layout.fillWidth: true

                    Title
                    {
                        Layout.fillWidth: true
                        text: "Database Table : "

                        id: tit
                    }

                    ComboBox
                    {
                        model: ["sensor", "second"]
//                        onCurrentTextChanged: {
//                            console.log(currentText);
//                            Services.setTable(currentText);
//                            pageLoader.source = "DTBDelegate.qml"
//                        }
                        onCurrentIndexChanged:
                        {
                            console.log(currentIndex);
                            if(currentIndex == 0)
                            {
                                Services.setTable("sensor");
                                pageLoader.source = "DTBDelegate.qml"
                            }
                            else
                            {
                                Services.setTable("mesh");
                                pageLoader.source = "DTBMesh.qml"
                            }
                        }
                    }

                    Item {
                        //Layout.fillHeight: true
                        Layout.fillWidth: true
                    }

                }
                Loader {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    id: pageLoader
                }
//                DTBDelegate
//                {
//                    Layout.fillHeight: true
//                    Layout.fillWidth: true
//                }
            }


        }

        ColumnLayout
        {
            spacing: 0
            Layout.fillHeight: true
            Layout.fillWidth: true
            Title
            {
                text: "Console"
                color: '#ccb'
            }
            Rectangle
            {
                Layout.fillHeight: true
                Layout.fillWidth: true
                color: '#444'
                ListView
                {
                    id: listView
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    spacing: 5
                    model: ListModel{id: model}
                    clip: true

                    delegate: RowLayout
                    {
                        spacing: 2
                        width: parent.width
                        Label
                        {
                            Layout.fillWidth: true
                            color: 'white'
                            text: model.text
                            wrapMode: Text.Wrap
                            font.pixelSize: 15
                        }
                        Label
                        {
                            //Layout.preferredHeight: 12
                            Layout.alignment: Qt.AlignBottom
                            color: '#777'
                            text: model.time
                            font.bold: true
                            font.pixelSize: 11
                        }
                    }

                    //                Connections
                    //                {
                    //                    target: Console
                    //                    onPrintMessage:
                    //                    {
                    //                        model.append({"time": time, "text": text})
                    //                        if (model.count > 100) model.remove(0, model.count - 50);
                    //                        listView.positionViewAtEnd()
                    //                    }
                    //                }
                }
            }


        }
        //        Rectangle
        //        {
        //            Layout.fillHeight: true
        //            Layout.fillWidth: true
        ////            color: '#444'



        //        }

    }
}
