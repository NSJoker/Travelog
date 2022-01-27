//
//  Coordinator.swift
//  RecordOfLocations
//
//  Created by Chandrachudh K on 27/01/22.
//

import UIKit

protocol Coordinator {
    var parentCoordinator:Coordinator? {get set}
    var navigationContoller:UINavigationController! {get set}
    func start(navigationController:UINavigationController, parent:Coordinator?)
}
