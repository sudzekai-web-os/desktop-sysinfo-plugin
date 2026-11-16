import QtQuick
import QtQuick.Layouts
import linctrl
import "../SystemPresentation.js" as Display

ColumnLayout {
    id: root

    property string label: ""
    required property var capacity
    readonly property real total: capacity?.totalBytes || 0
    readonly property real available: Math.min(total, Math.max(0, capacity?.availableBytes || 0))
    readonly property real used: total - available
    readonly property real fraction: total > 0 ? used / total : 0

    Layout.fillWidth: true
    spacing: 5

    RowLayout {
        Layout.fillWidth: true
        visible: root.label !== ""

        AppText {
            Layout.fillWidth: true
            text: root.label
            textFormat: Text.PlainText
            elide: Text.ElideRight
            font.bold: true
        }
        AppText {
            text: Math.round(root.fraction * 100) + " %"
            color: Theme.palette.muted
        }
    }

    Rectangle {
        id: track
        Layout.fillWidth: true
        implicitHeight: 10
        radius: height / 2
        color: Theme.palette.background
        border.color: Theme.palette.line

        Rectangle {
            x: 1
            y: 1
            width: Math.max(0, (track.width - 2) * root.fraction)
            height: track.height - 2
            radius: Math.min(width, height) / 2
            color: Theme.palette.accent
        }
    }
    RowLayout {
        Layout.fillWidth: true

        AppText { Layout.fillWidth: true; text: "Занято " + Display.bytes(root.used) }
        AppText { text: "Свободно " + Display.bytes(root.available); color: Theme.palette.muted }
    }
}
