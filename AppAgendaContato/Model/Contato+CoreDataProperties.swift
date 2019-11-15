//
//  Contato+CoreDataProperties.swift
//  AppAgendaContato
//
//  Created by SDM on 15/11/19.
//  Copyright © 2019 br.com.willtrkapp. All rights reserved.
//
//

import Foundation
import CoreData


extension Contato {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contato> {
        return NSFetchRequest<Contato>(entityName: "Contato")
    }

    @NSManaged public var nome: String?
    @NSManaged public var email: String?
    @NSManaged public var telefone: String?

}
