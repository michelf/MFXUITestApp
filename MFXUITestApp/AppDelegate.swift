import Foundation
#if os(macOS)
import AppKit
#else
import UIKit
#endif
import MFXUI

@main
class AppDelegate: NSObject, UXApplicationDelegate {

	var model = Model()

	lazy var mainViewController = ViewController(model: model)

	#if os(macOS)
	lazy var mainWindowController = NSWindowController {
		UXWindow(closable: true, miniaturizable: true, resizable: true) {
			mainViewController
		}
	}
	#else
	@IBOutlet var window: UIWindow?
	#endif

	#if os(macOS)
	// MARK: macOS

	func applicationDidFinishLaunching(_ aNotification: Notification) {
		// show window at launch
//		mainWindowController.showWindow(nil)
	}
	func applicationWillTerminate(_ aNotification: Notification) {
		// Insert code here to tear down your application
	}

	#else
	// MARK: iOS & tvOS

	func applicationDidFinishLaunching(_ application: UXApplication) {
		// show window at launch
//		window!.isHidden = false
		#if os(iOS)
		window?.backgroundColor = .systemBackground
		#endif

		mainViewController.navigationItem.title = "Hello World"
	}
	func applicationWillTerminate(_ application: UXApplication) {
		// Insert code here to tear down your application
	}

	#endif

	func applicationSupportsSecureRestorableState(_ app: UXApplication) -> Bool {
		return true
	}

}

