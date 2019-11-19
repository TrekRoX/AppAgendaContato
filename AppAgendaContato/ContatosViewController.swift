//
//  ContatosViewController.swift
//  AppAgendaContato
//
//  Created by murillo castro on 11/11/19.
//  Copyright © 2019 br.com.willtrkapp. All rights reserved.
//

import UIKit
import CoreData

class ContatosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var lstContatos:[String] = []
    
    var usuarioLogado:String = ""
    
    @IBOutlet weak var tableViewContatos: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let logado = UserDefaults.standard.value(forKey: "usrEmail") as? String {
            print("Logado como " + logado)
            
            usuarioLogado = logado
            
            tableViewContatos.dataSource = self
            tableViewContatos.delegate = self
        }
    
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        carregaContatos()
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
        lstContatos.removeAll()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Contato")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "nome", ascending: true)]
        
        if (usuarioLogado != "") {
            fetchRequest.predicate = NSPredicate(format: "userLogado == %@", usuarioLogado)
        }
        
        do{
            let results = try context.fetch(fetchRequest)
            
            if results.count > 0
            {
                for item in results as! [NSManagedObject] {
                    //print((item as AnyObject).value(forKey: "nome") ?? "Sem Nome")
                    
                    lstContatos.append((item as AnyObject).value(forKey: "nome") as! String)
                    //lstContatos.append(item.value(forKey: "nome") as! String)
                }
                tableViewContatos.reloadData()
            }
            
        }
        catch{
            fatalError("Erro ao retornar contatos")
        }
        
    }
    
}

