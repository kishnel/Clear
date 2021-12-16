//
//  DashboardViewController.swift
//  Clear
//
//  Created by Marcello Mascia on 15/12/2021.
//

import UIKit

protocol DashboardViewProtocol: AnyObject {

	func update(state: DashboardState)
}

struct DashboardViewModel: Equatable {
	let boxTitle: String
	let boxValue: String
	let boxSubtitle: String
}

enum DashboardState: Equatable {
	case loading
	case box(DashboardViewModel)
	case error
}

class DashboardViewController: UIViewController {

	@IBOutlet weak var circleView: CircleView!
	@IBOutlet weak var boxTitleLabel: UILabel!
	@IBOutlet weak var boxValueLabel: UILabel!
	@IBOutlet weak var boxSubtitleLabel: UILabel!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	
	private let interactor: DashboardInteractorProtocol

	deinit {
		print("DEINIT \(self)")
	}

	init(interactor: DashboardInteractorProtocol) {

		self.interactor = interactor

		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		setup()
		interactor.viewDidLoad()
	}
}

private extension DashboardViewController {

	func setup() {

		self.title = NSLocalizedString("Dashboard", comment: "Dashboard screen title")

		circleView.backgroundColor = .secondarySystemBackground
		boxTitleLabel.textColor = .label
		boxValueLabel.textColor = .systemYellow
		boxSubtitleLabel.textColor = .label
	}
}

extension DashboardViewController: DashboardViewProtocol {

	func update(state: DashboardState) {

		switch state {
		case .loading:
			circleView.isHidden = true
			activityIndicator.startAnimating()
		case .box(let viewModel):
			circleView.isHidden = false
			activityIndicator.stopAnimating()

			boxTitleLabel.text = viewModel.boxTitle
			boxValueLabel.text = viewModel.boxValue
			boxSubtitleLabel.text = viewModel.boxSubtitle
		case .error:
			circleView.isHidden = false
			activityIndicator.stopAnimating()

			print("Show error")
		}
	}
}
