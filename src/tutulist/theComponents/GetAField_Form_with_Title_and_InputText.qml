import QtQuick 2.15
import "../theScripts/config.js" as Configs

Item
{
    property string get_entered_value : "";
    property string setLabel : "Default label:";
    property string setPlaceHolderInput: "Enter the " + setLabel;
    property int setHeight: 40;
    property string defaultValue: "";
    width: parent.width;
    height:setHeight+50;
    Column
    {
        width:parent.width/1.25
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter;
        spacing:10;
        Text
        {
            id:lableText;
            text: setLabel;
            color:appColors.c_font_title;
        }

        Rectangle
        {
            width:parent.width;
            height:setHeight;
            color:appColors.c_input_background;
            radius:25;
            clip:true;
            border.color: appColors.c_bg_indicator;
            TextInput
            {
                id:inputText;
                anchors.fill:parent;
                color:appColors.c_input_text;
                font.pointSize: Configs.font_size_text;
                text: defaultValue;
                padding:28;
                wrapMode: TextInput.WrapAnywhere
                topPadding: setHeight>40 ? setHeight/3.50: 28;
                onTextChanged:
                {
                    get_entered_value= text;
                }

                Text
                {
                    text: setPlaceHolderInput;
                    color: appColors.c_input_placeholder
                    visible: !inputText.text
                    topPadding: setHeight/3.50;
                    leftPadding: 28;
                }
            }
        }

    }

}
