//
//  NewContactViewController.swift
//  AppAgendaContato
//
//  Created by SDM on 15/11/19.
//  Copyright © 2019 br.com.willtrkapp. All rights reserved.
//

import UIKit
import CoreData

class NewContactViewController: UIViewController {

    
    @IBOutlet weak var txtContactName: UITextField!
    @IBOutlet weak var txtContactEmail: UITextField!
    @IBOutlet weak var txtContactFone: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnCancelarClick(_ sender: Any) {
        print("Fechando")
        self.dismiss(animated:true, completion: nil)
    }
    
    @IBAction func btnSalvarContatoClick(_ sender: Any) {
        
        let nome = txtContactName.text
        let email = txtContactEmail.text
        let telefone = txtContactFone.text
        
        if (nome?.isEmpty)!
        {
            displayAlert(pMessage: "Campo de nome não pode ser vazio")
            return
        }
        else
        {
            // print("Salvando Contato")
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let requisicao = NSFetchRequest<NSFetchRequestResult>(entityName: "Contato")
            requisicao.predicate = NSPredicate(format: "nome = %@", email!)
            
            do {
                let contato = try context.fetch(requisicao)
                
                if contato.count > 0
                {
                    displayAlert(pMessage: "Ja existe um usuario cadastrado com este nome.")
                    return
                }
            } catch  {
                displayAlert(pMessage: "Ocorreu um erro inesperado ao consultar contatos.")
                return
            }
            
            // Inserindo novo Contato
            let newContato = NSEntityDescription.insertNewObject(forEntityName: "Contato", into: context)
            newContato.setValue(nome, forKey: "nome")
            newContato.setValue(email, forKey: "email")
            newContato.setValue(telefone, forKey: "telefone")
            
            do{
                try context.save()
            } catch let error as NSError{
                print ("Erro: " + error.localizedDescription)
                displayAlert(pMessage: "Ocorreu um erro inesperado ao salvar o contato.")
                return
            }
            
            let alert = UIAlertController(title: "Sucesso", message: "Contato Salvo", preferredStyle: UIAlertController.Style.alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ action in
                self.dismiss(animated:true, completion: nil)
            }

            alert.addAction(okAction)
            self.present(alert, animated:true, completion: nil);
            
        }
        
        
    }
    
    func displayAlert(pMessage:String){
        let alert = UIAlertController(title: "Alerta", message: pMessage, preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:nil)
        
        alert.addAction(okAction)
        
        self.present(alert, animated:true, completion: nil);
    }

}
