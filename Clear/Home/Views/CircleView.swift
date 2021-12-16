//
//  CircleView.swift
//  Clear
//
//  Created by Marcello Mascia on 16/12/2021.
//

import UIKit

class CircleView: UIView {

	override func layoutSubviews() {
		super.layoutSubviews()

		layer.borderColor = UIColor.label.cgColor
		layer.borderWidth = 2
		layer.cornerRadius = bounds.width / 2
	}
}
