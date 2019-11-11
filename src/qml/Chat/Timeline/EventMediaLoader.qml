import QtQuick 2.12
import "../../Base"
import "../../utils.js" as Utils

HLoader {
    id: loader
    x: eventContent.spacing


    property QtObject singleMediaInfo
    property string mediaUrl
    property string showSender: ""
    property string showDate: ""
    property string showLocalEcho: ""

    readonly property var imageExtensions: [
		"bmp", "gif", "jpg", "jpeg", "png", "pbm", "pgm", "ppm", "xbm", "xpm",
		"tiff", "webp", "svg",
    ]

    readonly property var videoExtensions: [
        "3gp", "avi", "flv", "m4p", "m4v", "mkv", "mov", "mp4",
		"mpeg", "mpg", "ogv", "qt", "vob", "webm", "wmv", "yuv",
    ]

    readonly property var audioExtensions: [
        "pcm", "wav", "raw", "aiff", "flac", "m4a", "tta", "aac", "mp3",
        "ogg", "oga", "opus",
    ]

    readonly property int type: {
        let mainType = singleMediaInfo.media_mime.split("/")[0].toLowerCase()

        if (mainType === "image") return EventDelegate.Media.Image
        if (mainType === "video") return EventDelegate.Media.Video
        if (mainType === "audio") return EventDelegate.Media.Audio

        let fileEvents = ["RoomMessageFile", "RoomEncryptedFile"]

        if (fileEvents.includes(singleMediaInfo.event_type))
            return EventDelegate.Media.File

        // If this is a preview for a link in a normal message
        let ext = Utils.urlExtension(mediaUrl)

        if (imageExtensions.includes(ext)) return EventDelegate.Media.Image
        if (videoExtensions.includes(ext)) return EventDelegate.Media.Video
        if (audioExtensions.includes(ext)) return EventDelegate.Media.Audio

        return EventDelegate.Media.Page
    }

    readonly property string thumbnailMxc: singleMediaInfo.thumbnail_url
    Component.onCompleted: if (singleMediaInfo.media_title.includes("i3-gaps"))
        Utils.debug(this)


    onTypeChanged: {
        if (type === EventDelegate.Media.Image) {
            var file = "EventImage.qml"

        } else if (type !== EventDelegate.Media.Page) {
            var file  = "EventFile.qml"

        } else { return }

        loader.setSource(file, {loader})
    }
}
