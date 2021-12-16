//
//  HomeViewController.swift
//  Clear
//
//  Created by Marcello Mascia on 15/12/2021.
//

import UIKit
import NetworkModule

class HomeViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

		NetworkRequest.getCreditScore { result in

			switch result {
			case .success:
				print("Bravo")
			case .failure(let error):
				print(error)
			}
		}
	}
}
