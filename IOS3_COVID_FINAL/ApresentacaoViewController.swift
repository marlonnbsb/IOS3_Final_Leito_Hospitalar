//
//  ApresentacaoViewController.swift
//  IOS3_COVID_FINAL
//
//  Created by Marlon Machado on 09/08/21.
//

import UIKit

class ApresentacaoViewController: UIViewController {

    @IBOutlet weak var lblBemVindo: UILabel!
    @IBOutlet weak var btnComecar: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.lblBemVindo.text = "Bem-vindo,\n\nNeste app você encontrará de forma simples e rapida os leitos de UTI e respiradores do seu estado.\n\nDesta forma podendo se direcinar ao Hospital que melhor te suporte.\n\nVamos começar?"
        self.configBotao()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    func configBotao() {
        self.btnComecar.backgroundColor = .clear
        self.btnComecar.layer.cornerRadius = 5
        self.btnComecar.layer.borderWidth = 1
        self.btnComecar.layer.borderColor = UIColor.black.cgColor
        self.btnComecar.setTitleColor(UIColor.black, for: .normal)
    }
}
