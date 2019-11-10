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
    
    @IBAction func btnSalvarClick(_ sender: Any) {
        
        let email = txtEmail.text
        let senha = txtSenha.text
        if(email?.isEmpty)! || (senha?.isEmpty)!
        {
            lblStatus.text = "Email ou Senha inválidos"
        }
        else
        {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            //Verifica se usuario ja existe
            let requisicao = NSFetchRequest<NSFetchRequestResult>(entityName: "Usuario")
            let predicate = NSPredicate(format: "email = %@", email!)
            
            do {
                let usuarios = try context.fetch(requisicao)
                
                if usuarios.count > 0
                {
                    lblStatus.text = "Ja existe um usuario cadastrado com este email."
                    return
                }
            } catch  {
                lblStatus.text = "Ocorreu um erro inesperado."
                return
            }
            
            
            
            //Insere novo usuário
            let usuario = NSEntityDescription.insertNewObject(forEntityName: "Usuario", into: context)
            usuario.setValue(email, forKey: "email")
            usuario.setValue(senha, forKey: "senha")
            
            do {
                try context.save()
                lblStatus.text = "Usuario inserido com sucesso."
            } catch  {
               lblStatus.text = "Ocorreu um erro inesperado."
            }
        }
    }
}
