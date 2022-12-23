import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

//configs
import "theScripts/config.js" as ConfigFile


Window
{
    id:mainWindow;
    width: ConfigFile.application_width;
    height: ConfigFile.application_height;
    visible: true;
    title: qsTr(ConfigFile.application_title);
    onClosing:
    {
        console.log("SAFE EXIT.");
    }


    Rectangle
    {
        id:root;
        anchors.fill:parent;
        color: ConfigFile.color_background;
        MouseArea
        {
            anchors.fill:parent;
            onClicked:
            {
                mainWindow.close();
            }
        }
    }
}
