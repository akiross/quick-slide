import QtQuick 2.2

Rectangle {
	id: root
	width: 400
	height: 300
	color: '#345'
	focus: true

	property int currentSlide: 0

	Keys.onPressed: {
		if (event.key === Qt.Key_Left) {
			currentSlide = Math.max(-1, currentSlide - 1);
			event.accepted = true;
		}
		else if (event.key === Qt.Key_Right) {
			currentSlide = Math.min(currentSlide + 1, slidesModel.count - 1);
			event.accepted = true;
		}
	}

	VisualDataModel {
		id: visualModel

		model: ListModel {
			id: slidesModel

			ListElement { title: 'First'; content: 'Foo'; background: 'images/coffee.jpg' }
			ListElement { title: 'Second'; content: 'Bar'; background: ''}
			ListElement { title: 'Third'; content: 'Baz'; background: '' }
			ListElement { title: 'Fourth'; content: 'Ban'; background: '' }
		}

		delegate: Slide { viewCont: root; width: root.width / 4 ; height: root.height / 4 }
	}

	GridView {
		id: gridView
		cellWidth: width / 4
		cellHeight: height / 4
		anchors.fill: parent
		model: visualModel

		onCurrentItemChanged: {
			console.log('current item changed in the view', 0);
		}
//		move: Transition { NumberAnimation { properties: "x,y"; duration: 400; easing.type: Easing.OutBounce } }
	}

	// A button to show all the slides
	Rectangle {
		id: overviewButton
		width: 50
		height: 50
		anchors.right: parent.right
		anchors.bottom: parent.bottom
		color: 'green'
		visible: false
		z: 100

		states: [
			State {
				when: root.currentSlide === -1
				name: "invisible"
				PropertyChanges { target: overviewButton; visible: false }
			},
			State {
				when: root.currentSlide !== -1
				name: 'visible'
				PropertyChanges { target: overviewButton; visible: true }
			}
		]

		MouseArea {
			anchors.fill: parent
			onClicked: currentSlide = -1
		}
	}

}

