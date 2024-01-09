import MFXUI

class Model {

	enum Role {
		case admin
		case user
		case guest
	}

	@MFObservable var userName: String = "Joe"
	@MFObservable var role: Role = .admin

}
