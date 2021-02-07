//
//  BaseViewController.swift
//  iOSVerifyExample
//
//  Created by Hawer Alberto Torres Castañeda on 6/02/21.
//

import UIKit

public class BaseViewController: UIViewController {
    // MARK: - Methods
    public init() {
      super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable,
      message: "Loading view controller from a nib is unsupported"
    )
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
      super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    @available(*, unavailable,
      message: "Loading view controller from a nib is unsupported"
    )
    public required init?(coder aDecoder: NSCoder) {
      fatalError("Loading view controller from a nib is unsupported")
    }
}
