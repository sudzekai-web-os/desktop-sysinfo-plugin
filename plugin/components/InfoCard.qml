import QtQuick
import QtQuick.Layouts
import linctrl

AppCard {
    id: root

    required property string title
    required property url glyph
    default property alias content: body.data

    implicitHeight: column.implicitHeight + 24

    data: ColumnLayout {
        id: column

        anchors.fill: parent
        anchors.margins: 12
        spacing: 12

        RowLayout {
            Layout.fillWidth: true
            spacing: 8

            SystemIcon {
                glyph: root.glyph
                color: Theme.palette.accent
            }
            AppText {
                Layout.fillWidth: true
                text: root.title
                textFormat: Text.PlainText
                font.bold: true
            }
        }
        ColumnLayout {
            id: body
            Layout.fillWidth: true
            spacing: 9
        }
    }
}
