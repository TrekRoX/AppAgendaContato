//
//  ContatosViewController.swift
//  AppAgendaContato
//
//  Created by murillo castro on 11/11/19.
//  Copyright © 2019 br.com.willtrkapp. All rights reserved.
//

import UIKit

class ContatosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var lstContatos: [String] = []
    
    @IBOutlet weak var tableViewContatos: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let logado = UserDefaults.standard.value(forKey: "usrEmail") as? String {
            print("Logado como " + logado)
            
            tableViewContatos.dataSource = self
            tableViewContatos.delegate = self
            
            carregaContatos()
        }
    
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lstContatos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContatoCell", for: indexPath)
        
        cell.textLabel!.text = lstContatos[indexPath.row]
        return cell
    }
    
    func carregaContatos(){
        var lst = ["Teste1", "Teste2", "Teste 3", "Teste 4", "Teste 5"]
        
        for item in lst {
            lstContatos.append(item)
        }
        
        
    }
    
}

