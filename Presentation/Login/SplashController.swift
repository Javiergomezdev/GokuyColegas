//
//  SplashController.swift
//  GokuYColegas
//
//  Created by Javier Gomez on 9/4/25.
//

import UIKit

class SplashController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let loginController = LoginController()
        self.navigationController?.pushViewController(loginController, animated: true)
        
        
       
        }
    }
    

