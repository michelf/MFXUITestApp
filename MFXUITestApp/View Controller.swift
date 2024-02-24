import MFXUI

class ViewController: MFViewController {

	var model: Model = Model()

	init(model: Model) {
		self.model = model
		super.init(nibName: nil, bundle: nil)
	}
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}

	override func loadView() {
		view = UXScrollView {
			MFFormView {
				UXLabel(label: "Hello World!")
					.binding(\.text, to: "Hello World, \(model.userName)!")
				UXLabel(label: "Role")
					.binding(\.text, to: "Your role is \(model.role)")

				MFFormSection(title: "Section") {
					UXStackView(spacing: 8) {
						MFFormRow(label: "User Name") {
							MFTextField()
								.editing(\.userName, of: model)
								.constrainingMinSize(width: 150, height: nil)
						}
						if #available(tvOS 17, *) {
							MFFormRow(label: "Role") {
								MFPopUpPicker.popUpMenu(MFEditableAccessor(\.role, of: model)) {
									MFOption(title: "Admin", value: .admin)
									MFOption(title: "User", value: .user)
									MFOption(title: "Guest", value: .guest)
								}
							}
						} else {

						}
					}.inset(by: 4)
				}

				UXView.separator(axis: .horizontal)
				UXButton(title: "Authenticate", style: .large)
					.onClick { [weak self] _ in
						#if os(macOS)
						self?.presentAsSheet(AuthDialog())
						#else
						self?.present(AuthDialog(), animated: true)
						#endif
					}
			}
			.inset(by: 20)
		}
		.withFlexibility(horizontal: false, vertical: false)
	}

}

#if os(macOS)
import AppKit
#else
import UIKit
#endif
@available(macOS 14, iOS 17, tvOS 17, *)
#Preview {
	ViewController(model: Model())
}
