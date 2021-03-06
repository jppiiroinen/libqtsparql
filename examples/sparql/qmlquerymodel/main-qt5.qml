import QtQuick 2.0
import QtSparql 1.0

Rectangle {
    id: mainRectangle
    width: 800
    height: 400
    // This signal will be emitted, and caught on the c++ side
    // we someone enters a new contact
    signal addContact(string firstName, string familyName)

    Rectangle {
        id: contactsRect
        width: parent.width
        height : parent.height - 50
        anchors.top: controlRect.bottom
        ListView {
            id: contactsView
            width: parent.width
            height: parent.height
            // contactModel will be set from C++
            model: contactModel
            delegate: Item {  height: 50; Text { font.pixelSize: 40; text: secondName+","+firstName }  }
        }
    }
// The "NameInput" page,
    Rectangle {
        id: nameInput
        visible: false
        width: mainRectangle.width
        height: mainRectangle.height
        anchors.verticalCenter: parent.verticalCenter
        Rectangle {
            width: parent.width
            height: 300

            // This is the button that deals with inserting
            // a contact
            Rectangle {
                // When the button is clicked, emit the addContact signal with the input
                // we can catch and process this on the C++ side
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        addContact(firstNameInput.text ,familyNameInput.text)
                        firstNameInput.text = ""
                        familyNameInput.text = ""
                        nameInput.visible = false
                        contactsRect.visible = true
                        contactsView.visible = true
                        controlRect.visible = true
                    }
                }
                anchors.top: gridView.bottom
                anchors.topMargin: 20
                anchors.horizontalCenter: gridView.horizontalCenter
                color: "red"; width: 75; height: 75

                gradient: Gradient {
                    GradientStop {
                        position: 0.0
                        color: "dimgrey"
                    }
                    GradientStop {
                        position: 1.0
                        color: "darkgrey"
                    }
                }
                Text { anchors.centerIn: parent; font.pixelSize: 50; text: "+" }
            }

            Grid {
                id: gridView
                columns: 1
                spacing: 2
                width: parent.width - 50
                anchors.horizontalCenter : parent.horizontalCenter
                Rectangle {
                    width: parent.width; height: 50
                    Text { smooth: true; font.pixelSize: 50; text: "Firstname"; anchors.verticalCenter: parent.verticalCenter}
                }
                Rectangle {
                    border.width:5; radius:5; border.color:"black"; width: parent.width; height: 75
                    TextInput {
                        id: firstNameInput
                        smooth: true
                        font.pixelSize: 50
                        anchors.fill: parent
                        anchors.leftMargin: 10
                        anchors.topMargin: 10
                        anchors.verticalCenter: parent.verticalCenter
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                if (!firstNameInput.activeFocus) {
                                    firstNameInput.forceActiveFocus()
                                } else {
                                    firstNameInput.focus = false
                                }
                            }
                        }
                        onAccepted: { firstNameInput.closeSoftwareInputPanel() }
                    }
                }
                Rectangle {
                    width: parent.width; height: 50
                    Text { smooth: true; font.pixelSize: 50; text: "Surname"; anchors.verticalCenter: parent.verticalCenter}
                }
                Rectangle {
                    border.width:5; radius:5; border.color:"black"; width: parent.width; height: 75
                    TextInput {
                        id: familyNameInput
                        smooth: true
                        font.pixelSize: 50
                        anchors.fill: parent
                        anchors.leftMargin: 10
                        anchors.topMargin: 10
                        anchors.verticalCenter: parent.verticalCenter
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                               if (!familyNameInput.activeFocus) {
                                    familyNameInput.forceActiveFocus();
                               } else {
                                    familyNameInput.focus = false;
                               }
                            }
                        }
                        onAccepted: { familyNameInput.closeSoftwareInputPanel() }
                    }
                }
            }
        }
    }
// the menu bar
    Rectangle {
        id: controlRect
        width: parent.width
        height: 50

        color: "blue"
        gradient: Gradient {
            GradientStop {
                position: 0.0
                color: "dimgrey"
            }
            GradientStop {
                position: 1.0
                color: "darkgrey"
            }
        }

        Rectangle {
            id: addButton
            width: 50
            height: 50
            anchors.centerIn: parent
            color: "red"
            border.width: 1
            radius: 4
            smooth: true

            gradient: Gradient {
                GradientStop {
                    position: 0.0
                    color: !mouseArea.pressed ? activePalette.light : activePalette.button
                }
                GradientStop {
                    position: 1.0
                    color: !mouseArea.pressed ? activePalette.button : activePalette.dark
                }
            }
            SystemPalette { id: activePalette }
            MouseArea {
                id: mouseArea
                anchors.fill: parent
                onClicked:
                {
                    if (contactsRect.visible) {
                        controlRect.visible = false
                        contactsRect.visible = false
                        nameInput.visible = true
                    } else {
                        contactsRect.visible = true
                        nameInput.visible = false
                    }
                }
            }
            Text {
                id: text
                anchors.centerIn:parent
                font.pointSize: 50
                smooth: true
                text: "+"
                color: activePalette.buttonText
            }
        }
    }
}
