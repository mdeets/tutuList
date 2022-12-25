import QtQuick 2.15

Item
{
    property string get_entered_value : "";
    property string setLabel : "Default label:";
    property string setPlaceHolderInput: "Enter the " + setLabel;
    property string defaultValue: "";
    width: parent.width;
    height:40;
    Column
    {
        anchors.fill:parent;
        spacing:10;
        Text
        {
            id:lableText;
            text: setLabel;
        }

        Rectangle
        {
            width:parent.width;
            height:40;
            color:"white";
            TextInput
            {
                id:inputText;
                anchors.fill:parent;
                color:"black";
                text: defaultValue;
                onTextChanged:
                {
                    get_entered_value= text;
                }

                Text
                {
                    text: setPlaceHolderInput;
                    color: "#aaa"
                    visible: !inputText.text
                    anchors.centerIn:parent;
                }
            }
        }

    }

}
