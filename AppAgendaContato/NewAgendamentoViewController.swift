//
//  NewAgendamentoViewController.swift
//  AppAgendaContato
//
//  Created by murillo castro on 25/11/19.
//  Copyright © 2019 br.com.willtrkapp. All rights reserved.
//

import UIKit
import CoreData

class NewAgendamentoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var dataPicker: UIDatePicker!
    @IBOutlet weak var contatoPicker: UIPickerView!
    @IBOutlet weak var txtDescricao: UITextField!
    var contatos = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        carregaContatos()
        self.contatoPicker.delegate = self
        self.contatoPicker.dataSource = self
        
    }
    func carregaContatos() {
        let usrEmail = UserDefaults.standard.value(forKey: "usrEmail") as? String
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Contato")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "nome", ascending: true)]
        fetchRequest.predicate = NSPredicate(format: "userLogado == %@", usrEmail!)
        
        do{
            let results = try context.fetch(fetchRequest)
            
            if results.count > 0
            {
                for item in results as! [NSManagedObject]{
                    contatos.append((item as AnyObject).value(forKey: "nome") as! String)
                }
            }
        }
        catch{
            fatalError("Erro ao retornar contatos")
        }
        
    }

    @IBAction func btnCancelarClick(_ sender: Any) {
        self.dismiss(animated:true, completion: nil)
    }
    
    @IBAction func btnSalvarClick(_ sender: Any) {
        if (contatos.count <= 0) {
            displayAlert(pMessage: "Erro, você não cadastrou nenhum contato ainda")
            return
        }
        
        let contato = contatos[contatoPicker.selectedRow(inComponent: 0)]
        let data = dataPicker.date
        let descricao = txtDescricao.text
        let usrEmail = UserDefaults.standard.value(forKey: "usrEmail") as? String
        
        if (descricao?.isEmpty)! {
            displayAlert(pMessage: "Erro, você não está logado")
            return
        }
        
        // Inserindo novo Agendamento
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let nvAgendamento = NSEntityDescription.insertNewObject(forEntityName: "Agendamento", into: context)
        nvAgendamento.setValue(contato, forKey: "contato")
        nvAgendamento.setValue(data, forKey: "data")
        nvAgendamento.setValue(descricao, forKey: "descricao")
        nvAgendamento.setValue(usrEmail, forKey: "usuario")
        
        do{
            try context.save()
        } catch let error as NSError{
            print ("Erro: " + error.localizedDescription)
            displayAlert(pMessage: "Ocorreu um erro inesperado ao salvar o agendamento.")
            return
        }
        
        let alert = UIAlertController(title: "Sucesso", message: "Agendamento Salvo", preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ action in
            self.dismiss(animated:true, completion: nil)
        }
        
        alert.addAction(okAction)
        self.present(alert, animated:true, completion: nil);
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return contatos.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return contatos[row]
    }
    
    func displayAlert(pMessage:String){
        let alert = UIAlertController(title: "Alerta", message: pMessage, preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:nil)
        
        alert.addAction(okAction)
        
        self.present(alert, animated:true, completion: nil);
    }

}
