//
//  BaseViewController.swift
//  presentation
//
//  Created by Karim Karimov on 30.07.22.
//

import Foundation
import UIKit

public class BaseViewController<VM>: UIViewController {
    
    var vm: VM? = nil
    var router: RouterProtocol? = nil
}
