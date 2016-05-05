;(function() {
	if (window.SNNativeClient) { return }
	var messagingIframe
	var sendMessageQueue = []
	var receiveMessageQueue = []
	var messageHandlers = {}
	
	var CUSTOM_PROTOCOL_SCHEME = 'suningwvjbscheme'
	var QUEUE_HAS_MESSAGE = '__WVJB_QUEUE_MESSAGE__'
	
	var responseCallbacks = {}
	var uniqueId = 1

	var navButtonCallBacks = {}
	var navButtonId = 1

	function _createQueueReadyIframe(doc) {
		messagingIframe = doc.createElement('iframe')
		messagingIframe.style.display = 'none'
		messagingIframe.src = CUSTOM_PROTOCOL_SCHEME + '://' + QUEUE_HAS_MESSAGE
		doc.documentElement.appendChild(messagingIframe)
	}

	function init(messageHandler) {
		if (SNNativeClient._messageHandler) { throw new Error('SNNativeClient.init called twice') }
		SNNativeClient._messageHandler = messageHandler
		var receivedMessages = receiveMessageQueue
		receiveMessageQueue = null
		for (var i=0; i<receivedMessages.length; i++) {
			_dispatchMessageFromObjC(receivedMessages[i])
		}
	}

	function send(data, responseCallback) {
		_doSend({ data:data }, responseCallback)
	}
	
	function registerHandler(handlerName, handler) {
		messageHandlers[handlerName] = handler
	}
	
	function callHandler(handlerName, data, responseCallback) {
		_doSend({ handlerName:handlerName, data:data }, responseCallback)
	}
    
    function isBindToHander(handlerName) {
        if (messageHandlers[handlerName] != null) {
            return "1"
        } else {
            return "0"
        }
    }
	
	function _doSend(message, responseCallback) {
		if (responseCallback) {
			var callbackId = 'cb_'+(uniqueId++)+'_'+new Date().getTime()
			responseCallbacks[callbackId] = responseCallback
			message['callbackId'] = callbackId
		}
		sendMessageQueue.push(message)
		messagingIframe.src = CUSTOM_PROTOCOL_SCHEME + '://' + QUEUE_HAS_MESSAGE
	}

	function _fetchQueue() {
		var messageQueueString = JSON.stringify(sendMessageQueue)
		sendMessageQueue = []
		return messageQueueString
	}

	function _dispatchMessageFromObjC(messageJSON) {
		setTimeout(function _timeoutDispatchMessageFromObjC() {
			var message = JSON.parse(messageJSON)
			var messageHandler
			
			if (message.responseId) {
				var responseCallback = responseCallbacks[message.responseId]
				if (!responseCallback) { return; }
				responseCallback(message.responseData)
				delete responseCallbacks[message.responseId]
			} else {
				var responseCallback
				if (message.callbackId) {
					var callbackResponseId = message.callbackId
					responseCallback = function(responseData) {
						_doSend({ responseId:callbackResponseId, responseData:responseData })
					}
				}
				
				var handler = SNNativeClient._messageHandler
				if (message.handlerName) {
					handler = messageHandlers[message.handlerName]
				}
				
				try {
					handler(message.data, responseCallback)
				} catch(exception) {
					if (typeof console != 'undefined') {
						console.log("SNNativeClient: WARNING: javascript handler threw.", message, exception)
					}
				}
			}
		})
	}
	
	function _handleMessageFromObjC(messageJSON) {
		if (receiveMessageQueue) {
			receiveMessageQueue.push(messageJSON)
		} else {
			_dispatchMessageFromObjC(messageJSON)
		}
	}

	function addEventListener(eventName, responseCallback) {
		SNNativeClient.registerHandler(eventName, responseCallback)
	}

	function copyToClipboard(text, responseCallback) {
		SNNativeClient.callHandler("copyToClipboard", {"text": text}, responseCallback)
	}

	function callNativeShare(title, content, targetUrl, iconUrl, shareWays) {
		var data = {"title": title, "content": content, "targetUrl": targetUrl, "iconUrl":iconUrl, "shareWays":shareWays}
        SNNativeClient.callHandler("callNativeShare", data, null)
	}

	function goToProductDetail(productCode, shopCode) {
		var data = {"productCode": productCode, "shopCode": shopCode}
        SNNativeClient.callHandler("goToProductDetail", data, null)
	}

	function goToRushProductDetail(productCode, shopCode, rushPurId, rushChannel) {
		var data = {"productCode": productCode, "shopCode": shopCode, "rushPurId": rushPurId, "rushPurChannel": rushChannel, "promotionType": "1"}
        SNNativeClient.callHandler("goToProductDetail", data, null)
	}

	function goToGroupProductDetail(productCode, shopCode, groupPurId) {
		var data = {"productCode": productCode, "shopCode": shopCode, "groupPurId": groupPurId, "promotionType": "2"}
        SNNativeClient.callHandler("goToProductDetail", data, null)
	}

	function goToJuhuiProductDetail(productCode, shopCode) {
		var data = {"productCode": productCode, "shopCode": shopCode, "promotionType": "3"}
        SNNativeClient.callHandler("goToProductDetail", data, null)
	}

	function getClientInfo(responseCallback) {
		SNNativeClient.callHandler("getClientInfo", null, responseCallback)
	}
  
    function changeCity(cityId){
        var data = {"cityId": cityId}
        SNNativeClient.callHandler("changeCity", data, null)
    }
  
  //在线客服
  function gotoCustom(shopCode,shopName) {
  var data = {"shopCode": shopCode,"shopName": shopName}
  SNNativeClient.callHandler("gotoCustom", data, null)
  
  }
  
    function gotoCPA(){
        SNNativeClient.callHandler("gotoCPA", null)

    }
  
    function gotoActive(){
        SNNativeClient.callHandler("gotoActive", null)
    }
  
	function goToSearchResultWithKeyword(keyword) {
		SNNativeClient.callHandler("goToSearchResultWithKeyword", {"keyword": keyword})
	}

	function pushToNextPage(url) {
		SNNativeClient.callHandler("pushToNextPage", {"url": url})
	}

	function routeToClientPage(adTypeCode, adId) {
		SNNativeClient.callHandler("routeToClientPage", {"adTypeCode": adTypeCode, "adId": adId})
	}

	function showAlert(message, buttons, touchCallBack) {
		SNNativeClient.callHandler("showAlert", {"message": message, "buttons": buttons}, function (response) {
			touchCallBack(response["clickIndex"])
		})
	}

	function showTip(message) {
		SNNativeClient.callHandler("showTip", {"message": message})
	}

	function showRightButtons(buttons, touchCallBack) {

		var navId = "nav_button_"+(navButtonId++)
		if (touchCallBack) {
			navButtonCallBacks[navId] = touchCallBack
		}

		SNNativeClient.callHandler("showRightButtons", {"buttons": buttons, "id": navId})

		if (messageHandlers["navRightButtonClicked"] == null) {
			SNNativeClient.registerHandler("navRightButtonClicked", function (response) {
				var navbuttonresponseId = response["id"]
				block = navButtonCallBacks[navbuttonresponseId]
				if (block) {
					block(response["buttonIndex"])
				}
			})
		}
	}

	function addProductToShopCart(productId, shopCode, quantity, cityCode, completionCallback) {
		var data = {"productId": productId, "shopCode": shopCode, "quantity": quantity, "cityCode":cityCode}
		SNNativeClient.callHandler("addProductToShopCart", data, completionCallback)
	}
  
  	function setBarColor(color) {
  		SNNativeClient.callHandler("setBarColor", {"color": color})
  	}
  
    function openLinkInSafari(url) {
        SNNativeClient.callHandler("openLinkInSafari", {"url": url})
    }
  
    function gotoHomePage() {
        SNNativeClient.callHandler("gotoHomePage", null)
    }
	window.SNNativeClient = {
        init: init,
		send: send,
		registerHandler: registerHandler,
		callHandler: callHandler,
        isBindToHander: isBindToHander,
		_fetchQueue: _fetchQueue,
		_handleMessageFromObjC: _handleMessageFromObjC,
		addEventListener: addEventListener,
		copyToClipboard: copyToClipboard,
		callNativeShare: callNativeShare,
		goToProductDetail: goToProductDetail,
		goToRushProductDetail: goToRushProductDetail,
		goToGroupProductDetail: goToGroupProductDetail,
		goToJuhuiProductDetail: goToJuhuiProductDetail,
		getClientInfo: getClientInfo,
        changeCity: changeCity,
        gotoCustom:gotoCustom,
        gotoCPA:gotoCPA,
        gotoActive:gotoActive,
		goToSearchResultWithKeyword: goToSearchResultWithKeyword,
		pushToNextPage: pushToNextPage,
		routeToClientPage: routeToClientPage,
		showAlert: showAlert,
		showTip: showTip,
		showRightButtons: showRightButtons,
		addProductToShopCart: addProductToShopCart,
        setBarColor: setBarColor,
        openLinkInSafari: openLinkInSafari,
        gotoHomePage:gotoHomePage
	}

	var doc = document
	_createQueueReadyIframe(doc)

	var readyEvent = doc.createEvent('Events')
	readyEvent.initEvent('SNNativeClientReady')
	readyEvent.bridge = SNNativeClient
	doc.dispatchEvent(readyEvent)

	SNNativeClient.init()
})();
