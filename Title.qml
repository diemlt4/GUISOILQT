import QtQuick 2.0
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.3
Rectangle
{
    //Layout.fillWidth: true
    height: 32
    property alias text: lable.text
    //property color userColor: '#ccc'
    color: '#ccc'

    Label
    {
        id: lable
        anchors.fill: parent
        verticalAlignment: "AlignVCenter"
        font.bold: true
        leftPadding: 10
        font.capitalization: Font.AllUppercase
        font.pixelSize: 13
        color: Material.color(Material.Pink)
        text: "Lable"
    }
}
