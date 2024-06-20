import QtQuick
import Felgo
import "play.js" as Controlplay
EntityBase {
    id: player
    entityType: "player"
    scale: 2
    width: gameSprite.width * 2
    height: gameSprite.height * 2
    property alias collider: _collider
    property alias gamesprite:gameSprite
    property alias twoAxisController : _twoAxisController
    property var pressed_keys: new Set
    property int speedx: 400
    property int speedy: 400

    property bool isLeftPlayer: true
    property int status: 1
    property int timedelta: 10
    property bool lp: false
    property bool hp: false
    property bool ll: false
    property bool hl: false
    property var frameary:[0, 18, 10, 6, 15, 11, 9, 17, 15, 12, 16, 18, 16, 15, 11, 11, 12, 13]
    signal keysChange()
    GameAnimatedSprite{
        id:gameSprite
        mirrorX: !isLeftPlayer ? true : false

        interpolate:false
    }
    BoxCollider {
        id:_collider
        anchors.fill: player
        bodyType: Body.Dynamic
    }
    TwoAxisController {
        id: _twoAxisController
    }

    focus:true
    Keys.onPressed:
        (e)=>{pressed_keys.add(e.key);keysChange()}
    Keys.onReleased:
        (e)=>{pressed_keys.delete(e.key);keysChange()}
    Timer{
        running: true
        repeat: true
        interval: 50
        onTriggered: {
            Controlplay.update_move()
            Controlplay.update_control()
            Controlplay.render(frameary)
        }
    }


    Image{
        id:image
        source: Controlplay.update_image("kula")
        visible: false
    }




}
