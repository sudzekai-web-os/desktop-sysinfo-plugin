import QtQuick
import QtQuick.Controls.Basic

Button {
    id: root

    required property url glyph
    required property color color

    enabled: false
    focusPolicy: Qt.NoFocus
    display: AbstractButton.IconOnly
    background: null
    padding: 0
    implicitWidth: 16
    implicitHeight: 16

    icon.source: root.glyph
    icon.color: root.color
    icon.width: 16
    icon.height: 16
}
