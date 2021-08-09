//
//  ViewController.swift
//  IOS3_COVID_FINAL
//
//  Created by Marlon Machado on 08/08/21.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    var resultApi: [Hit]?
    var listaUfEscolhida: [Hit]?
    let listaUf = ["Acre - AC", "Alagoas - AL", "Amapá - AP", "Amazonas - AM", "Bahia - BA", "Ceará - CE", "Distrito Federal - DF", "Espírito Santo - ES", "Goiás - GO", "Maranhão - MA", "Mato Grosso - MT", "Mato Grosso do Sul - MS", "Minas Gerais - MG", "Pará - PA", "Paraíba - PB", "Paraná - PR", "Pernambuco - PE", "Piauí - PI", "Roraima - RR", "Rondônia - RO", "Rio de Janeiro - RJ", "Rio Grande do Norte - RN", "Rio Grande do Sul - RS", "Santa Catarina - SC", "São Paulo - SP", "Sergipe - SE", "Tocantins - TO"]
    var UfEscolhida: String = "AC"

    @IBOutlet weak var pickerViewUFs: UIPickerView!
    @IBOutlet weak var btnEscolher: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.configNavigationBar()
        self.configBotao()
        self.pickerViewUFs.dataSource = self
        self.pickerViewUFs.delegate = self
        self.callAPI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.setHidesBackButton(false, animated: true)
    }
    
    func configBotao() {
        self.btnEscolher.backgroundColor = .clear
        self.btnEscolher.layer.cornerRadius = 5
        self.btnEscolher.layer.borderWidth = 1
        self.btnEscolher.layer.borderColor = UIColor.black.cgColor
        self.btnEscolher.setTitleColor(UIColor.black, for: .normal)
    }
    
    func configNavigationBar() {
        self.navigationItem.title = "Leitos"
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 217.0/255.0, green: 247.0/255.0, blue: 254.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    func callAPI() {
        APIManager.callAPI { result in
            if (result != nil) {
                self.resultApi = result?.hits?.hits
            } else {
                //apresenta modal de erro
            }
        }
    }

    @IBAction func escolherUF(_ sender: Any) {
        let listaUfs: [Hit]? = resultApi?.filter {
            $0.source?.estadoSigla?.range(of: self.UfEscolhida, options: .caseInsensitive) != nil
        }
        self.listaUfEscolhida = listaUfs
        if (self.listaUfEscolhida!.count > 0) {
            performSegue(withIdentifier: "showLeitos", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let leitosViewController = segue.destination as! LeitosViewController
        leitosViewController.listaUfSelecionada = self.listaUfEscolhida!
    }
    
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.listaUf.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.listaUf[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.UfEscolhida = String(describing: self.listaUf[row].suffix(2)) 
    }
    
}
