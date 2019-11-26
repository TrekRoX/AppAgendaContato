//
//  NewAgendamentoViewController.swift
//  AppAgendaContato
//
//  Created by murillo castro on 25/11/19.
//  Copyright © 2019 br.com.willtrkapp. All rights reserved.
//

import UIKit
import CoreData

class NewAgendamentoViewController: UIViewController {

    @IBOutlet weak var txtDescricao: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func btnCancelarClick(_ sender: Any) {
        self.dismiss(animated:true, completion: nil)
    }
    
    @IBAction func btnSalvarClick(_ sender: Any) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
