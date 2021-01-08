import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

ListView
{
    id: root
    property bool isDeletable: false
    clip: true
    model: Services.myModel//Services.getTransactionData("sensor")
//        ListModel
//        {
//            ListElement{nodeID: "0x001"; type: "plasma"; group:"0x1234"}
//            ListElement{nodeID: "0x002"; Type: "plasma"; group:"0x1234"}
//        }
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
            id: headerNode;
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
            id: headerType
            property int headerWidth: parent.width*0.3
            property string headerName: "Type"
            sourceComponent: rectheader
            anchors{left: headerNode.right}
        }
        Loader
        {
            id: headerHum
            property int headerWidth: parent.width*0.3 - 5
            property string headerName: "Group"
            sourceComponent: rectheader
            anchors
            {
                left: headerType.right
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
            id: loadType
            property int loadWidth: del.width*0.3
            property string name: modelData.type
            property bool isShow: false
            sourceComponent: rectview
            anchors{left: loadNodeID.right}
        }
        Loader
        {
            id: loadGroup
            property int loadWidth: del.width*0.3 -5
            property string name: modelData.group
            property bool isShow: false
            sourceComponent: rectview
            anchors{left: loadType.right}
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
                id: btnImport
                Layout.fillHeight: true
                Layout.rightMargin: 5
                text: "<font color='#000'>" + "Import" + "</font>"
               // onClicked: Services.refreshList();
            }

        }

    }
}
