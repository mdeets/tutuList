import QtQuick 2.15
import "../theScripts/config.js" as Configs

Item
{
    width:parent.width;
    height: Configs.topTitleBar_height;
    Rectangle
    {
        id:local_root;
        anchors.fill:parent;
        color:"orange";
    }
}
