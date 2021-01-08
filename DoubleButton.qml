import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.3

RowLayout
{
    property alias titleLeft: btLeft.text
    property alias titleRight: btRight.text
    Layout.fillWidth: true
    Layout.maximumHeight: 50
    property var leftColor: Material.Green
    Item
    {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Button
        {
            id: btLeft
            anchors.fill: parent
            anchors.leftMargin: 5
            //text: modelData.leftName()
            text: "Left"
            Material.background: Material.Teal
            //onClicked: modelData.leftClicked();
        }
    }

    Item
    {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Button
        {
            id: btRight
            anchors.fill: parent
            anchors.rightMargin: 5
            text: "Right"
            Material.background: Material.Teal
            //onClicked: modelData.rightClicked();
        }
    }
}
