import QtQuick
import QtQuick.Layouts
import linctrl

ColumnLayout {
    id: root

    required property string label
    property var value

    Layout.fillWidth: true
    spacing: 2

    AppText {
        text: root.label
        color: Theme.palette.muted
    }
    AppText {
        Layout.fillWidth: true
        text: String(root.value ?? "—")
        textFormat: Text.PlainText
        wrapMode: Text.Wrap
    }
}
