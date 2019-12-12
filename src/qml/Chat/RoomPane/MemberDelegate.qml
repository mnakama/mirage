import QtQuick 2.12
import "../../Base"
import "../../utils.js" as Utils

HTileDelegate {
    id: memberDelegate
    backgroundColor: theme.chat.roomPane.member.background

    image: HUserAvatar {
        userId: model.user_id
        displayName: model.display_name
        mxc: model.avatar_url
        powerLevel: model.power_level
        shiftPowerIconPosition: ! roomPane.collapsed
    }

    title.text: model.display_name || model.user_id
    title.color:
        memberDelegate.hovered ?
        Utils.nameColor(model.display_name || model.user_id.substring(1)) :
        theme.chat.roomPane.member.name

    subtitle.text: model.display_name ? model.user_id : ""
    subtitle.color: theme.chat.roomPane.member.subtitle

    contextMenu: HMenu {
        HMenuItem {
            icon.name: "copy-user-id"
            text: qsTr("Copy user ID")
            onTriggered: Clipboard.text = model.user_id
        }
    }


    Behavior on title.color { HColorAnimation {} }
}
