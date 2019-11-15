//
//  Contato.swift
//  AppAgendaContato
//
//  Created by SDM on 15/11/19.
//  Copyright © 2019 br.com.willtrkapp. All rights reserved.
//

import UIKit

class Contatos {
    var userLogado : String
    var nome : String
    var email : String
    var telefone : String

    init(userLogado: String, nome: String, email: String, telefone: String) {
        self.userLogado = userLogado
        self.nome = nome
        self.email = email
        self.telefone = telefone
    }
    
}
