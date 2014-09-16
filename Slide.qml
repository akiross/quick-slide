import QtQuick 2.0

Rectangle {
	property string slideTitle: "Title"
	property string slideContent: "Slide"
	width: 100
	height: 62
	color: 'white'
//	visible: false

	Text {
		id: titleText
		text: slideTitle
	}
	Text {
		anchors.centerIn: parent
		text: slideContent
	}

	MouseArea {
		anchors.fill: parent
		onClicked: parent.color = 'red'
	}
}
