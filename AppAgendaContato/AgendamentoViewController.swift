//
//  AgendamentoViewController.swift
//  AppAgendaContato
//
//  Created by murillo castro on 27/11/19.
//  Copyright © 2019 br.com.willtrkapp. All rights reserved.
//

import UIKit
import CoreData

class AgendamentoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var tblAgendamento: UITableView!
    var lstAgendamentos = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblAgendamento.dataSource = self
        tblAgendamento.delegate = self
    }
    
    
    func carregaAgendamentos() {
        let usrEmail = UserDefaults.standard.value(forKey: "usrEmail") as? String
        let dtAgendamentos = datePicker.date
        lstAgendamentos.removeAll()
        


        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Agendamento")
        //Usuario logado
        let usrEmailPredicate = NSPredicate(format: "usuario == %@", usrEmail!)
        
        // Pega calendario com data atual
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local
        
        // Cria a data inicial a partir do datepicker porem com horario zerado
        let dateFrom = calendar.startOfDay(for: dtAgendamentos) // 00:00:00
        let dateTo = calendar.date(byAdding: .day, value: 1, to: dateFrom)
        
        // Dois predicates de até
        let fromPredicate = NSPredicate(format: "data >= %@", dateFrom as NSDate)
        let toPredicate = NSPredicate(format: "data < %@", dateTo! as NSDate)
        let composicao = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate, usrEmailPredicate])
        
        fetchRequest.predicate = composicao
        
        do{
            let results = try context.fetch(fetchRequest)
            
            if results.count > 0
            {
                for item in results as! [NSManagedObject]{
                    let descr = (
                        ((item as AnyObject).value(forKey: "contato") as! String) + " - " +
                        ((item as AnyObject).value(forKey: "descricao") as! String)
                    )
                    //print(descr)
                    lstAgendamentos.append(descr)
                }
            }
        }
        catch{
            fatalError("Erro ao retornar agendamentos")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        carregaAgendamentos()
        tblAgendamento.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lstAgendamentos.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AgendamentoCell", for: indexPath)
        cell.textLabel!.text = lstAgendamentos[indexPath.row]
        
        return cell
    }

    @IBAction func btnBuscarClick(_ sender: Any) {
        carregaAgendamentos()
        tblAgendamento.reloadData()
    }
}
