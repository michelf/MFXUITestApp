import MFXUI
import Foundation
#if os(macOS)
import Cocoa
#else
import UIKit
#endif

class AuthDialog: MFViewController {

	let url: URL = URL(string: "https://host.org/path")!

	override func loadView() {
		view = MFFormView {
			MFFormRow {
				UXStackView(axis: .vertical, alignment: .leading, spacing: 6) {
					UXLabel(label: "Authenticate with “\(self.url.host ?? "*")”", font: .regular(weight: .bold))
					UXLabel(label: self.url.absoluteString, color: .secondaryLabel, font: .small())
				}
			}
			UXStackView(axis: .vertical, spacing: 8) {
				MFFormRow(label: "Username") {
					UXTextField()
					#if os(macOS)
						.constrainingMinSize(width: 300, height: nil)
					#endif
				}
				MFFormRow(label: "Password") {
					#if os(macOS)
					NSSecureTextField()
					#else
					UXTextField()
						.with { $0.isSecureTextEntry = true }
					#endif
				}
			}
			.insetBy(dx: 0, dy: 4)
			UXStackView(axis: .horizontal, spacing: 8) {
				UXView.spacer(axis: .horizontal)
				UXButton(title: "Cancel")
					.onClick(self, #selector(cancel))
				UXButton(title: "Authenticate", key: "\r")
					.onClick(self, #selector(authenticate))
			}
			#if !os(macOS)
			UXView.spacer(axis: .vertical)
			#endif
		}
		.insetBy(dx: 20, dy: 20)
		#if !os(macOS)
		.withBackground(color: .systemBackground)
		#endif
	}

	@IBAction func cancel(_ sender: Any?) {
		#if os(macOS)
		dismiss(nil)
		#else
		self.dismiss(animated: true)
		#endif
	}
	@IBAction func authenticate(_ sender: Any?) {
		/* authentification logic goes here */
		#if os(macOS)
		dismiss(nil)
		#else
		self.dismiss(animated: true)
		#endif
	}

}

@available(macOS 14, iOS 17, *)
#Preview("AuthDialog") {
	AuthDialog()
}
