import QtQuick 2.0

Item {
	id: delegateItem
	property Item viewCont: null
	property int slideIndex: index

//	signal prevSlide
//	signal nextSlide

//	Keys.onPressed: {
//		if (event.key === Qt.Key_Left) {
//			prevSlide()
//		}
//		else if (event.key === Qt.Key_Right) {
//			nextSlide()
//		}
//	}

	Rectangle {
		id: slideRectangle
		color: 'white'
		width: parent.width - 10
		height: parent.height - 10
		anchors.centerIn: parent // usare questo per debuggare e capire bene cosa sta succedendo

		Image {
			id: slideBgImg
			anchors.fill: parent
			source: background
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
				root.currentSlide = index
//				console.log(delegateItem.parent.parent.model.count);
			}
		}

		states: [
			State {
				when: root.currentSlide === index
				name: "inDisplay"
				ParentChange { target: slideRectangle; parent: root ; width: viewCont.width; height: viewCont.height; x: 0; y: 0}
//				PropertyChanges { target: slideRectangle;  z: 2 }
			},
			State {
				when: root.currentSlide !== index
				name: "inList"
				ParentChange { target: slideRectangle; parent: delegateItem }
//				PropertyChanges { target: slideRectangle;  z: 2 }
			}
		]

		onStateChanged: {
			console.log('cambiato lo stato in', state, 'e la mia z è', z);
		}

		transitions: [
			Transition {
				from: "inList"
				SequentialAnimation {
					PropertyAction { target: delegateItem; property: "VisualDataModel.inPersistedItems"; value: true }
//					PropertyAction { target: slideRectangle; property: "z"; value: 2 }
					ParentAnimation {
						target: slideRectangle;
						via: root
						NumberAnimation { target: slideRectangle; properties: "x,y,width,height"; duration: 500 ; easing.type: Easing.InOutQuart}
					}
//					PropertyAction { target: slideRectangle; property: "z"; value: 0 }
				}
			},
			Transition {
				from: "inDisplay"
				SequentialAnimation {
					ParentAnimation {
						target: slideRectangle
						NumberAnimation { target: slideRectangle; properties: "x,y,width,height"; duration: 500 ;easing.type: Easing.InOutQuart}
					}
					PropertyAction { target: delegateItem; property: "VisualDataModel.inPersistedItems"; value: false }
//					PropertyAction { target: slideRectangle; property: "z"; value: 0 }
				}
			}
		]
	}
}
