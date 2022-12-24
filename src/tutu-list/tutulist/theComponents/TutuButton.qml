import QtQuick 2.15
import QtQuick.Window 2.15

Item {
    width: 200; height: 200

    Component {
        id: redSquare

        Rectangle {
            color: "red"
            width: 101
            height: 101
        }
    }

    Loader { sourceComponent: redSquare }
//    Loader { sourceComponent: redSquare; x: 20 }
}
