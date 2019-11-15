//
//  LoginViewController.swift
//  AppAgendaContato
//
//  Created by murillo castro on 13/11/19.
//  Copyright © 2019 br.com.willtrkapp. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {

    
    @IBOutlet weak var txtUsr: UITextField!
    
    @IBOutlet weak var txtSenha: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnLoginClick(_ sender: Any) {
        let usrEmail = txtUsr.text;
        let usrPwd = txtSenha.text
        
        if verificaUsarioESenha(pUsrEmail: usrEmail!, pPwd: usrPwd!) {
            UserDefaults.standard.set(usrEmail, forKey:"usrEmail")
            UserDefaults.standard.synchronize()
            self.dismiss(animated:true, completion: nil)
        }
        else{
            displayAlert(pMessage: "Usuario ou senha incorretos")
        }
    }
    
    func verificaUsarioESenha(pUsrEmail : String, pPwd : String) ->Bool
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let requisicao = NSFetchRequest<NSFetchRequestResult>(entityName: "Usuario")
        requisicao.predicate = NSPredicate(format: "email = %@", pUsrEmail)
        
        do {
            let usuarios = try context.fetch(requisicao) as! [Usuario]
            if(usuarios.count > 0)
            {
                if usuarios[0].email == pUsrEmail && usuarios[0].senha == pPwd{
                    return true;
                }
            }
        } catch  {
            displayAlert(pMessage: "Ocorreu um erro inesperado ao consultar usuarios ja cadastrados.")
            return false
        }
        return false
    }
    
    func displayAlert(pMessage:String){
        let alert = UIAlertController(title: "Alerta", message: pMessage, preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:nil)
        
        alert.addAction(okAction)
        
        self.present(alert, animated:true, completion: nil);
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
