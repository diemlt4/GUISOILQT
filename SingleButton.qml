import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.3


Item
{
    property alias text: button.text
    property var color: Material.Green
    property bool fillWidth: false
    property int preferWidth: 100
    Layout.fillWidth: fillWidth
    Layout.preferredWidth: preferWidth
    Layout.preferredHeight: 50
    signal clicked();

    Button
    {
        id: button
        anchors.fill: parent
        anchors.leftMargin: 5
        anchors.rightMargin: 5
        text: "Button"
        Material.background: Material.color(color)
        //onClicked: modelData.rightClicked();
        onClicked: {
            //Services.getTransactionData("abc");
            parent.clicked();
        }
    }
}

