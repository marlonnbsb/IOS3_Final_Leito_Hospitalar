//
//  LoginViewController.swift
//  IOS3_COVID_FINAL
//
//  Created by Marlon Machado on 09/08/21.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var btnCriarConta: UIButton!
    @IBOutlet weak var btnEntrar: UIButton!
    @IBOutlet weak var userTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configBotao()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    func configBotao() {
        self.btnEntrar.backgroundColor = .clear
        self.btnEntrar.layer.cornerRadius = 25
        self.btnEntrar.layer.borderWidth = 1
        self.btnEntrar.layer.borderColor = UIColor.black.cgColor
        self.btnEntrar.setTitleColor(UIColor.black, for: .normal)
    }
    
    
    @IBAction func criarContaFirebase(_ sender: Any) {
        guard let user = self.userTF.text, !user.isEmpty,
              let password = self.passwordTF.text, !password.isEmpty else {
            self.showAlert(titulo: "Atenção!", mensagem: "Informe o email e a senha.")
            return
        }
        self.criarContaFirebase(user: user, password: password)
    }
    

    @IBAction func logarFirebase(_ sender: Any) {
        guard let user = self.userTF.text, !user.isEmpty,
              let password = self.passwordTF.text, !password.isEmpty else {
            self.showAlert(titulo: "Atenção!", mensagem: "Informe o email e a senha.")
            return
        }
        
        FirebaseAuth.Auth.auth().signIn(withEmail: user, password: password, completion: {[weak self] results, error in
            guard let strongSelf = self else {
                return
            }
            guard error == nil else {
                strongSelf.showAlert(titulo: "Atenção!", mensagem: "Senha invalida ou usuario não possui conta ainda.")
                return
            }
            strongSelf.performSegue(withIdentifier: "telaInicial", sender: nil)
        })
        
        
    }
    
    func criarContaFirebase(user: String, password: String) {
        FirebaseAuth.Auth.auth().createUser(withEmail: user, password: password, completion: {[weak self] result, error in
            guard let strongSelf = self else {
                return
            }
            guard error == nil else {
                print("Falha ao criar a conta")
                strongSelf.showAlert(titulo: "Atenção!", mensagem: "Erro ao criar a conta! Insira um senha com no minimo 6 digitos.")
                return
            }
            strongSelf.performSegue(withIdentifier: "telaInicial", sender: nil)
        })
    }
    
    func showAlert(titulo: String, mensagem: String) {
        let alert = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
        }))
        
        present(alert, animated: true)
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
