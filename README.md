MluviiChatLibrary for iOS
=========================

`MluviiChatLibrary` is a feature-rich SDK for iOS that provides an interface for managing and displaying web-based chat functionality. Utilizing WebKit, it enables seamless interaction between your iOS application and web content, allowing you to integrate chat sessions effortlessly.

Features
--------

-   Web-based Chat Interface: Leverage WKWebView to display chat within your app.
-   Customizable Chat Sessions: Configure company GUID, tenant ID, language, preset name, and scope.
-   Event Handling: Receive callbacks for chat events, status updates, and termination.
-   Responsive Design: Automatically respond to orientation changes.
-   Add Custom Data: Inject custom data into your chat sessions.

Requirements
------------

-   iOS 11.0 or later
-   Xcode 10.0 or later

Installation
------------

### Manual Installation

1.  Clone or download the `MluviiChatLibrary` repository.
2.  Drag and drop the `MluviiChatLibrary.swift` file into your project.
3.  Ensure that `WebKit.framework` is added to your project.

Usage
-----

### Initialize the Library

swiftCopy code

`import MluviiChat

let chatLibrary = MluviiChatLibrary()`

### Configure Chat Parameters

swiftCopy code

`let webView = chatLibrary.createWebView(
    url: "your-url",
    companyGuid: "guid",
    tenantId: "tenant-id",
    presetName: "preset-name",
    language: "en",
    scope: "scope"
)`

### Handle Chat Events

swiftCopy code

`chatLibrary.setChatEnded {
    print("Chat ended")
}

chatLibrary.setStatusUpdater { status in
    print("Status update: \(status)")
}

chatLibrary.setMluviiEventCallbackFunc { event, sessionId in
    print("Event: \(event), Session ID: \(sessionId ?? 0)")
}`

### Open and Manage Chat

swiftCopy code

`chatLibrary.openChat()
chatLibrary.resetUrl()
chatLibrary.addCustomData(name: "name", value: "value")`

Support and Contribution
------------------------

For support, please contact [Mluvii Support](mailto:support@mluvii.com).

To contribute, please fork the repository and submit a pull request.

License
-------

`MluviiChatLibrary` is available under the MIT license. See the LICENSE file for more details.
