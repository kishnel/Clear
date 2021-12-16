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
	case error(String)
}

class DashboardViewController: UIViewController {

	@IBOutlet var circleView: CircleView!
	@IBOutlet var boxTitleLabel: UILabel!
	@IBOutlet var boxValueLabel: UILabel!
	@IBOutlet var boxSubtitleLabel: UILabel!
	@IBOutlet var activityIndicator: UIActivityIndicatorView!
	@IBOutlet var errorContainer: UIView!
	@IBOutlet var errorLabel: UILabel!
	@IBOutlet var errorButton: UIButton!

	private let interactor: DashboardInteractorProtocol

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

	@IBAction func boxDidTap(_ sender: UITapGestureRecognizer) {

		interactor.boxDidTap()
	}

	@IBAction func retryButtonDidTap(_ sender: UIButton) {

		interactor.retryButtonDidTap()
	}
}

private extension DashboardViewController {

	func setup() {

		self.title = NSLocalizedString("Dashboard", comment: "Dashboard screen title")

		circleView.backgroundColor = .secondarySystemBackground
		boxTitleLabel.textColor = .label
		boxValueLabel.textColor = .systemYellow
		boxSubtitleLabel.textColor = .label
		errorButton.setTitle(NSLocalizedString("Retry", comment: "Retry button title"), for: .normal)
	}
}

extension DashboardViewController: DashboardViewProtocol {

	func update(state: DashboardState) {

		switch state {
		case .loading:
			circleView.isHidden = true
			errorContainer.isHidden = true
			activityIndicator.startAnimating()
		case .box(let viewModel):
			circleView.isHidden = false
			errorContainer.isHidden = true
			activityIndicator.stopAnimating()

			boxTitleLabel.text = viewModel.boxTitle
			boxValueLabel.text = viewModel.boxValue
			boxSubtitleLabel.text = viewModel.boxSubtitle
		case .error(let message):
			circleView.isHidden = true
			errorContainer.isHidden = false
			activityIndicator.stopAnimating()

			errorLabel.text = message
		}
	}
}
