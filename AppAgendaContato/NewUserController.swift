//
//  NewUserController.swift
//  AppAgendaContato
//
//  Created by murillo castro on 10/11/19.
//  Copyright © 2019 br.com.willtrkapp. All rights reserved.
//

import UIKit
import CoreData

class NewUserController: UIViewController {
    
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var txtSenha: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func btnJaTenhoContaClick(_ sender: Any) {
        self.dismiss(animated:true, completion: nil)
    }
    
    @IBAction func btnSalvarClick(_ sender: Any) {
        
        let email = txtEmail.text
        let senha = txtSenha.text
        if(email?.isEmpty)! || (senha?.isEmpty)!
        {
            displayAlert(pMessage: "Email ou Senha inválidos")
        }
        else
        {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            //Verifica se usuario ja existe
            let requisicao = NSFetchRequest<NSFetchRequestResult>(entityName: "Usuario")
            requisicao.predicate = NSPredicate(format: "email = %@", email!)
            
            do {
                let usuarios = try context.fetch(requisicao)
                
                if usuarios.count > 0
                {
                    displayAlert(pMessage: "Ja existe um usuario cadastrado com este email.")
                    return
                }
            } catch  {
                displayAlert(pMessage: "Ocorreu um erro inesperado ao cosultar usuarios ja cadastrados.")
                return
            }
            
            
            
            //Insere novo usuário
            let usuario = NSEntityDescription.insertNewObject(forEntityName: "Usuario", into: context)
            usuario.setValue(email, forKey: "email")
            usuario.setValue(senha, forKey: "senha")
            
            do {
                try context.save()
            } catch let error as NSError  {
                print ("Erro: " + error.localizedDescription)
                displayAlert(pMessage: "Ocorreu um erro inesperado ao salvar o usuário.")
                return
            }
            
            let alert = UIAlertController(title: "Alerta", message: "Sucesso", preferredStyle: UIAlertController.Style.alert)
            
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
