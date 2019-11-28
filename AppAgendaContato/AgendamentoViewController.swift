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
        //fetchRequest.sortDescriptors = [NSSortDescriptor(key: "nome", ascending: true)]
        //fetchRequest.predicate = NSPredicate(format: "usuario == %@", usrEmail!)
        //fetchRequest.predicate = NSPredicate(format: "data > %@", dtAgendamentos as NSDate)
        
        // Get the current calendar with local time zone
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local
        
        // Get today's beginning & end
        let dateFrom = calendar.startOfDay(for: dtAgendamentos) // eg. 2016-10-10 00:00:00
        let dateTo = calendar.date(byAdding: .day, value: 1, to: dateFrom)
        
        // Set predicate as date being today's date
        let fromPredicate = NSPredicate(format: "data >= %@", dateFrom as NSDate)
        let toPredicate = NSPredicate(format: "data < %@", dateTo! as NSDate)
        let datePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
        fetchRequest.predicate = datePredicate
        
        //let predicate1 = NSPredicate(format: "idade >= %@", "25")
        //let predicate2 = NSPredicate(format: "nome contains [c] %@", "Maria")
        //let composicao = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate1, predicate2])
        //requisicao.predicate = composicao
        
        
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

}
