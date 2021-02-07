//
//  BaseView.swift
//  iOSVerifyExample
//
//  Created by Hawer Alberto Torres Castañeda on 6/02/21.
//

import UIKit

class BaseView: UIView {
    // MARK: - Methods
    public override init(frame: CGRect) {
      super.init(frame: frame)
    }

    @available(*, unavailable,
      message: "Loading view from a nib is unsupported"
    )
    public required init?(coder aDecoder: NSCoder) {
      fatalError("Loading view from a nib is unsupported")
    }
}
