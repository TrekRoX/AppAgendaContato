//
//  TabBarViewController.swift
//  AppAgendaContato
//
//  Created by murillo castro on 11/11/19.
//  Copyright © 2019 br.com.willtrkapp. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Verificando se alguem esta logado, do contrario redireciona para login
        if let logado = UserDefaults.standard.value(forKey: "usrEmail") as? String {
            print("Logado como " + logado)
        }
        else {
            self.performSegue(withIdentifier: "loginView", sender: self)
        }
    }
  
}
