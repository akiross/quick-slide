import QtQuick 2.2

Rectangle {
	id: root
	width: 360
	height: 360
	color: '#345'
	focus: true
	/*
	property int currentSlide: 0

	Keys.onPressed: {
		if (event.key == Qt.Key_Left) {
			color = 'red';
			event.accepted = true;

			if (currentSlide == 0)
				children[children]
			children[currentSlide].visible = false;
		}
		else if (event.key == Qt.Key_Right) {
			color = 'blue';
			event.accepted = true;
			children[currentSlide].visible = true;
		}
	}
	*/

	property Component currentSlide: null

	Component {
		id: slidesDelegate

		Item {
			id: delegateItem

			Rectangle {
				id: slideRectangle
				width: 100
				height: 90
				color: 'white'

				Image {
					id: slideBgImg
					anchors.fill: parent
					source: '/home/akiross/Dropbox/Dottorato/Insegnamento/Images/brick-428585_1280.jpg'
					opacity: 0.2
				}

				Text {
					id: slideTitle
					anchors.horizontalCenter: parent.horizontalCenter
					text: title
				}

				Text {
					anchors.centerIn: parent
					anchors.top: slideTitle.bottom
					text: content
				}

				MouseArea {
					anchors.fill: parent
					onClicked: {
						console.log('ho clickato una qualche mouse area...');
						currentSlide = slidesDelegate
					}
				}

				states: [
					State {
						when: root.currentSlide === slidesDelegate
						name: "inDisplay"
						ParentChange { target: slideRectangle; parent: root ; width: root.width ; x: 0; y: 0}
//						PropertyChanges { target: slideRectangle;  z: 100 }
					},
					State {
						when: root.currentSlide !== slidesDelegate
						name: "inList"
						ParentChange { target: slideRectangle; parent: delegateItem }
//						PropertyChanges { target: slideRectangle;  z: 0 }
					}
				]

				onStateChanged: {
					console.log('cambiato lo stato in', state);
				}

				transitions: [
					Transition {
						from: "inDisplay"
					},
					Transition {
						from: "inList"
					}
				]
			}
		}
	}
/*
	onCurrentSlideChanged: {
		if (currentSlide == null) {
			console.log('nessuna slide selezionata');
			overviewButton.visible = false;
		}
		else {
			console.log('è stata selezionata una slide!');
			overviewButton.visible = true;
		}
	}
*/
	ListModel {
		id: slidesModel

		ListElement { title: 'First'; content: 'Foo' }
		ListElement { title: 'Second'; content: 'Bar' }
		ListElement { title: 'Third'; content: 'Baz' }
		ListElement { title: 'Fourth'; content: 'Ban' }
	}

	GridView {
		cellWidth: 110
		cellHeight: 100
		anchors.fill: parent
		model: slidesModel
		delegate: slidesDelegate
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

		states: [
			State {
				when: root.currentSlide === null
				name: "invisible"
				PropertyChanges { target: overviewButton; visible: false }
			},
			State {
				when: root.currentSlide !== null
				name: 'visible'
				PropertyChanges { target: overviewButton; visible: true }
			}
		]

		MouseArea {
			anchors.fill: parent
			onClicked: currentSlide = null
		}
	}

}

