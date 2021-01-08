import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

ListView
{
    id: root
    property bool isDeletable: false
    clip: true
    model: Services.myModel//Services.getTransactionData("sensor")
    //    ListModel
    //    {
    //        ListElement{nodeID: "0x001"; temperature: "25"; humidity:"67"}
    //        ListElement{nodeID: "0x002"; temperature: "25"; humidity:"67"}
    //        ListElement{nodeID: "0x003"; temperature: "25"; humidity:"67"}
    //        ListElement{nodeID: "0x004"; temperature: "25"; humidity:"67"}
    //        ListElement{nodeID: "0x005"; temperature: "25"; humidity:"67"}
    //        ListElement{nodeID: "0x006"; temperature: "25"; humidity:"67"}
    //    }
    boundsBehavior: Flickable.StopAtBounds
    footerPositioning: ListView.OverlayFooter
    header: Item
    {
        width: root.width
        height: 20
        Component
        {
            id: rectheader
            Rectangle
            {
                width: headerWidth
                height: 20
                color: "grey"
                Text {
                    id: nameText
                    text: qsTr(headerName)
                    anchors.centerIn: parent
                    wrapMode: Text.Wrap
                }
            }
        }
        Loader
        {
            id: headerID;
            property int headerWidth: parent.width*0.4-5
            property string headerName: "Node ID"
            sourceComponent: rectheader
            anchors
            {
                left: parent.left
                leftMargin: 5
            }
        }
        Loader
        {
            id: headerTemp
            property int headerWidth: parent.width*0.3
            property string headerName: "Temperature"
            sourceComponent: rectheader
            anchors{left: headerID.right}
        }
        Loader
        {
            id: headerHum
            property int headerWidth: parent.width*0.3 - 5
            property string headerName: "Humidity"
            sourceComponent: rectheader
            anchors
            {
                left: headerTemp.right
            }
        }
    }
    delegate: Item
    {
        id: del
        width: root.width
        height: 20
        Component
        {
            id: rectview
            Rectangle
            {
                Text
                {
                    text: "X"
                    font.bold: true
                    color: "red"
                    anchors
                    {
                        left: parent.left
                        leftMargin: 5
                        verticalCenter: parent.verticalCenter
                    }
                    visible: isShow

                }
                width: loadWidth
                height: del.height
                color: "lightgrey"
                border.color: "grey"
                Text {
                    id: nameText
                    color: "grey"
                    text: name
                    anchors.centerIn: parent
                    wrapMode: Text.Wrap
                }
            }
        }
        Loader
        {
            id: loadNodeID
            property int loadWidth: del.width*0.4-5
            property string name: modelData.nodeID
            property bool isShow: false
            sourceComponent: rectview
            anchors{left: parent.left; leftMargin: 5}
        }
        Loader
        {
            id: loadTemp
            property int loadWidth: del.width*0.3
            property string name: modelData.temperature
            property bool isShow: false
            sourceComponent: rectview
            anchors{left: loadNodeID.right}
        }
        Loader
        {
            id: loadHum
            property int loadWidth: del.width*0.3 -5
            property string name: modelData.humidity
            property bool isShow: false
            sourceComponent: rectview
            anchors{left: loadTemp.right}
        }
    }
    footer: ToolBar
    {
        width: root.width
        height: 30
        RowLayout
        {
            anchors.fill: parent
            Item {
                Layout.fillHeight: true
                Layout.fillWidth: true
            }
            Button
            {
                id: btnRefresh
                Layout.fillHeight: true
                text: "<font color='#000'>" + "Refresh" + "</font>"
                onClicked: Services.refreshList();
            }
            Button
            {
                id: btnFirst
                Layout.fillHeight: true
                text: "<font color='#000'>" + "First" + "</font>"
                onClicked:
                {
                    Services.getFirstPage();
                    btnFirst.enabled = false;
                    btnPrev.enabled = false;
                    btnNext.enabled = true;
                    btnLast.enabled = true;
                }

            }
            Button
            {
                id: btnPrev
                Layout.fillHeight: true
                text: "<font color='#000'>" + "Prev" + "</font>"
                onClicked:
                {
                    var a = Services.getPrevPage();
                    if(a == 1)
                    {
                        btnFirst.enabled = false;
                        btnPrev.enabled = false;
                    }

                    btnNext.enabled = true;
                    btnLast.enabled = true;
                }
            }
            Button
            {
                id: btnNext
                Layout.fillHeight: true
                text: "<font color='#000'>" + "Next" + "</font>"
                onClicked:
                {
                    var a = Services.getNextPage();
                    if(a == 1)
                    {
                        btnNext.enabled = false;
                        btnLast.enabled = false;
                    }
                    btnFirst.enabled = true;
                    btnPrev.enabled = true;
                }
            }

            Button
            {
                id: btnLast
                Layout.fillHeight: true
                Layout.rightMargin: 5
                text: "<font color='#000'>" + "Last" + "</font>"
                onClicked: {
                    Services.getLastPage();
                    btnLast.enabled = false;
                    btnNext.enabled = false
                    btnFirst.enabled = true;
                    btnPrev.enabled = true;
                }
            }
        }

    }
}
