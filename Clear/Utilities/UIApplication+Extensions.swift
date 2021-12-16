//
//  UIApplication+Extensions.swift
//  Clear
//
//  Created by Marcello Mascia on 16/12/2021.
//

import UIKit

extension UIApplication {

	public static var isRunningTests: Bool {
		getenv("runningTests") != nil
	}
}
