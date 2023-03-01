import QtQuick 2.15

Item
{
    anchors.fill: parent;
    property string emptyTextForAll: "";
    property string textAPick: emptyTextForAll;
    property string textBPick: emptyTextForAll;
    property string textCPick: emptyTextForAll;
    property string textDPick: emptyTextForAll;
    property string textEPick: emptyTextForAll;
    property string textFPick: emptyTextForAll;
    property string textGPick: emptyTextForAll;
    property bool setAPicked: false;
    property bool setBPicked: false;
    property bool setCPicked: false;
    property bool setDPicked: false;
    property bool setEPicked: false;
    property bool setFPicked: false;
    property bool setGPicked: false;


    property variant outputPickedDays: [];


    //setpicmode changes
    property int setPickMode: 2; //idk, problem.
    /*
        1 -> only one pick
        2 -> mutiple pick
    */
    property bool setMonthDayPicker: false;





    property color setColorPicked: appColors.c_button_background;
    property color setColorNotPicked: setMonthDayPicker? "transparent" : "transparent"    ;
    property color setColorTextPicked: "white";//"white";
    property color setColorTextNotPicked: appColors.c_font_text;//color exception 5

    property int setTextFontSize: 9;
    property bool setTextBold: true;
    property int setBaseRadius:150;
    property int setBaseWidth: theRow.width/8;
    property int setBaseHeight:theRow.height/1.20;
    property int setLimitForTexts: 50;
    property bool setViewOnly:false;


    signal aPicked;
    signal bPicked;
    signal cPicked;
    signal dPicked;
    signal ePicked;
    signal fPicked;
    signal gPicked;

    signal aUnpicked;
    signal bUnpicked;
    signal cUnpicked;
    signal dUnpicked;
    signal eUnpicked;
    signal fUnpicked;
    signal gUnpicked;

    signal clearAll;
    onClearAll:
    {
        setAPicked=false;
        setBPicked=false;
        setCPicked=false;
        setDPicked=false;
        setEPicked=false;
        setFPicked=false;
        setAPicked=false;
    }

    Row
    {
        id:theRow;
        anchors.fill: parent;
        spacing:parent.width/50;

        Rectangle
        {
            height:setBaseHeight;
            width:setBaseWidth;
            color:setAPicked<=0? setColorNotPicked:setColorPicked;
            radius:setBaseRadius;
            enabled: textAPick!=emptyTextForAll? true:false;
            opacity: textAPick!=emptyTextForAll? 1.0:0;

            Text
            {
                text: (parent.width>setLimitForTexts) ? textAPick : textAPick.slice(0,3);
                anchors.centerIn: parent;
                font.pointSize: setTextFontSize;
                color:setAPicked<=0? setColorTextNotPicked: setColorTextPicked;
                font.bold: setTextBold;
            }
            MouseArea
            {
                anchors.fill: parent;
                onClicked:
                {
                    if(!setViewOnly)
                    {
                        if(setAPicked)
                        {
                            setAPicked=false;
                            const index = outputPickedDays.indexOf(textAPick);
                            if (index > -1)
                                 outputPickedDays.splice(index, 1); // 2nd parameter means remove one item only
                            aUnpicked();
                        }
                        else
                        {
                            if(setPickMode==2)
                            {
                                setAPicked=true;
                                aPicked();
                            }
                            else
                            {
                                setAPicked=true;
                                setBPicked=false;
                                setCPicked=false;
                                setDPicked=false;
                                setEPicked=false;
                                setFPicked=false;
                                setGPicked=false;
                            }
                            outputPickedDays.push(textAPick);
                        }

                    }

                }
            }
        }//end of a

        Rectangle
        {
            height:setBaseHeight;
            width:setBaseWidth;
            color:setBPicked<=0? setColorNotPicked:setColorPicked;
            radius:setBaseRadius;
            enabled: textBPick!=emptyTextForAll? true:false;
            opacity: textBPick!=emptyTextForAll? 1.0:0;
            Text
            {
                text: parent.width>setLimitForTexts? textBPick : textBPick.slice(0,3);
                anchors.centerIn: parent;
                font.pointSize: setTextFontSize;
                color:setBPicked<=0? setColorTextNotPicked: setColorTextPicked;
                font.bold: setTextBold;
            }
            MouseArea
            {
                anchors.fill: parent;
                onClicked:
                {
                    if(!setViewOnly)
                    {
                        if(setBPicked)
                        {
                            setBPicked=false;
                            const index = outputPickedDays.indexOf(textBPick);
                            if (index > -1)
                                 outputPickedDays.splice(index, 1); // 2nd parameter means remove one item only
                            bUnpicked();
                        }
                        else
                        {
                            if(setPickMode==2)
                            {
                                setBPicked=true;
                                bPicked();
                            }
                            else
                            {
                                setBPicked=true;
                                setBPicked=false;
                                setCPicked=false;
                                setDPicked=false;
                                setEPicked=false;
                                setFPicked=false;
                                setGPicked=false;
                            }
                            outputPickedDays.push(textBPick);
                        }
                    }




                }
            }
        }//end of b


        Rectangle
        {
            height:setBaseHeight;
            width:setBaseWidth;
            color:setCPicked<=0? setColorNotPicked:setColorPicked;
            radius:setBaseRadius;
            enabled: textCPick!=emptyTextForAll? true:false;
            opacity: textCPick!=emptyTextForAll? 1.0:0;
            Text
            {
                text: parent.width>setLimitForTexts? textCPick : textCPick.slice(0,3);
                anchors.centerIn: parent;
                font.pointSize: setTextFontSize;
                color:setCPicked<=0? setColorTextNotPicked: setColorTextPicked;
                font.bold: setTextBold;
            }
            MouseArea
            {
                anchors.fill: parent;
                onClicked:
                {
                    if(!setViewOnly)
                    {
                        if(setCPicked)
                        {
                            setCPicked=false;
                            const index = outputPickedDays.indexOf(textCPick);
                            if (index > -1)
                                 outputPickedDays.splice(index, 1); // 2nd parameter means remove one item only
                            cUnpicked();
                        }
                        else
                        {
                            if(setPickMode==2)
                            {
                                setCPicked=true;
                                cPicked();

                            }
                            else
                            {
                                setCPicked=true;
                                setBPicked=false;
                                setAPicked=false;
                                setDPicked=false;
                                setEPicked=false;
                                setFPicked=false;
                                setGPicked=false;
                            }
                            outputPickedDays.push(textCPick);
                        }
                    }


                }
            }
        }//end of c

        Rectangle
        {
            height:setBaseHeight;
            width:setBaseWidth;
            color:setDPicked<=0? setColorNotPicked:setColorPicked;
            radius:setBaseRadius;
            enabled: textDPick!=emptyTextForAll? true:false;
            opacity: textDPick!=emptyTextForAll? 1.0:0;
            Text
            {
                text: parent.width>setLimitForTexts? textDPick : textDPick.slice(0,3);
                anchors.centerIn: parent;
                font.pointSize: setTextFontSize;
                color:setDPicked<=0? setColorTextNotPicked: setColorTextPicked;
                font.bold: setTextBold;
            }
            MouseArea
            {
                anchors.fill: parent;
                onClicked:
                {
                    if(!setViewOnly)
                    {
                        if(setDPicked)
                        {
                            setDPicked=false;
                            const index = outputPickedDays.indexOf(textDPick);
                            if (index > -1)
                                 outputPickedDays.splice(index, 1); // 2nd parameter means remove one item only
                            dUnpicked();
                        }
                        else
                        {
                            if(setPickMode==2)
                            {
                                setDPicked=true;
                                dPicked();
                            }
                            else
                            {
                                setDPicked=true;
                                setBPicked=false;
                                setCPicked=false;
                                setAPicked=false;
                                setEPicked=false;
                                setFPicked=false;
                                setGPicked=false;
                            }
                            outputPickedDays.push(textDPick);
                        }
                    }

                }
            }
        }//end of d





        Rectangle
        {
            height:setBaseHeight;
            width:setBaseWidth;
            color:setEPicked<=0? setColorNotPicked:setColorPicked;
            radius:setBaseRadius;
            enabled: textEPick!=emptyTextForAll? true:false;
            opacity: textEPick!=emptyTextForAll? 1.0:0;
            Text
            {
                text: parent.width>setLimitForTexts? textEPick : textEPick.slice(0,3);
                anchors.centerIn: parent;
                font.pointSize: setTextFontSize;
                color:setEPicked<=0? setColorTextNotPicked: setColorTextPicked;
                font.bold: setTextBold;
            }
            MouseArea
            {
                anchors.fill: parent;
                onClicked:
                {
                    if(!setViewOnly)
                    {
                        if(setEPicked)
                        {
                            setEPicked=false;
                            const index = outputPickedDays.indexOf(textEPick);
                            if (index > -1)
                                 outputPickedDays.splice(index, 1); // 2nd parameter means remove one item only
                            eUnpicked();
                        }
                        else
                        {
                            if(setPickMode==2)
                            {
                                setEPicked=true;
                                ePicked();
                            }
                            else
                            {
                                setEPicked=true;
                                setBPicked=false;
                                setCPicked=false;
                                setDPicked=false;
                                setAPicked=false;
                                setFPicked=false;
                                setGPicked=false;
                            }
                            outputPickedDays.push(textEPick);
                        }
                    }

                }
            }
        }//end of e



        Rectangle
        {
            height:setBaseHeight;
            width:setBaseWidth;
            color:setFPicked<=0? setColorNotPicked:setColorPicked;
            radius:setBaseRadius;
            enabled: textFPick!=emptyTextForAll? true:false;
            opacity: textFPick!=emptyTextForAll? 1.0:0;
            Text
            {
                text: parent.width>setLimitForTexts? textFPick : textFPick.slice(0,3);
                anchors.centerIn: parent;
                font.pointSize: setTextFontSize;
                color:setFPicked<=0? setColorTextNotPicked: setColorTextPicked;
                font.bold: setTextBold;
            }
            MouseArea
            {
                anchors.fill: parent;
                onClicked:
                {
                    if(!setViewOnly)
                    {
                        if(setFPicked)
                        {
                            setFPicked=false;
                            const index = outputPickedDays.indexOf(textFPick);
                            if (index > -1)
                                 outputPickedDays.splice(index, 1); // 2nd parameter means remove one item only
                            fUnpicked();
                        }
                        else
                        {
                            if(setPickMode==2)
                            {
                                setFPicked=true;
                                fPicked();
                            }
                            else
                            {
                                setFPicked=true;
                                setBPicked=false;
                                setCPicked=false;
                                setDPicked=false;
                                setEPicked=false;
                                setAPicked=false;
                                setGPicked=false;
                            }
                            outputPickedDays.push(textFPick);
                        }
                    }

                }
            }
        }//end of f



        Rectangle
        {
            id:gSection;
            height:setBaseHeight;
            width:setBaseWidth;
            color:setGPicked<=0? setColorNotPicked:setColorPicked;
            radius:setBaseRadius;
            enabled: textGPick!=emptyTextForAll? true:false;
            opacity: textGPick!=emptyTextForAll? 1.0:0;
            Text
            {
                text: parent.width>setLimitForTexts? textGPick : textGPick.slice(0,3);
                anchors.centerIn: parent;
                font.pointSize: setTextFontSize;
                color:setGPicked<=0? setColorTextNotPicked: setColorTextPicked;
                font.bold: setTextBold;
            }
            MouseArea
            {
                anchors.fill: parent;
                onClicked:
                {
                    if(!setViewOnly)
                    {
                        if(setGPicked)
                        {
                            setGPicked=false;
                            const index = outputPickedDays.indexOf(textGPick);
                            if (index > -1)
                                 outputPickedDays.splice(index, 1); // 2nd parameter means remove one item only
                            gUnpicked();
                        }
                        else
                        {
                            if(setPickMode==2)
                            {
                                setGPicked=true;
                                gPicked();
                            }
                            else
                            {
                                setGPicked=true;
                                setBPicked=false;
                                setCPicked=false;
                                setDPicked=false;
                                setEPicked=false;
                                setFPicked=false;
                                setAPicked=false;
                            }
                            outputPickedDays.push(textGPick);
                        }

                    }

                }
            }
        }//end of g

    }
}
