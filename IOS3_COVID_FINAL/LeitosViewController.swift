//
//  LeitosViewController.swift
//  IOS3_COVID_FINAL
//
//  Created by Marlon Machado on 09/08/21.
//

import UIKit

class LeitosViewController: UIViewController {

    var listaUfSelecionada: [Hit] = []
    var listaUfFiltrada: [Hit] = []
    
    @IBOutlet weak var searchController: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.navigationItem.title = "Lista Leitos"
        self.listaUfSelecionada = self.listaUfSelecionada.sorted(by: {$0.source?.ofertaHospUti ?? 0 > $1.source?.ofertaHospUti ?? 0})
        self.listaUfFiltrada = self.listaUfSelecionada
        self.searchBarSetup()
    }
    
    func searchBarSetup() {
//        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: (UIScreen.main.bounds.width), height: 70))
        searchController.delegate = self
        searchController.showsScopeBar = true
        searchController.showsCancelButton = true
        searchController.placeholder = "Nome do Hospital"
        
    }
}

extension LeitosViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.listaUfFiltrada.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellLeitos", for: indexPath) as! LeitosTableViewCell

        cell.lblMunicipio.text = "\(String(describing: self.listaUfFiltrada[indexPath.row].source?.municipio ?? "")) - "
        cell.lblEstado.text = String(describing: self.listaUfFiltrada[indexPath.row].source?.estadoSigla ?? "").uppercased()
        cell.lblNomeCnes.text = String(describing: self.listaUfFiltrada[indexPath.row].source?.nomeCnes ?? "Hospital").uppercased()
        cell.lblQtdRespiradores.text = "Qtd Respiradores: \(String(describing: self.listaUfFiltrada[indexPath.row].source?.ofertaRespiradores ?? 0))"
        cell.lblQtdObtos.text = "Qtd Obtos: \(String(describing: self.listaUfFiltrada[indexPath.row].source?.obitos ?? 0))"
        cell.lblQtdOfertaUTI.text = "Qtd Vagas UTI: \(String(describing: self.listaUfFiltrada[indexPath.row].source?.ofertaHospUti ?? 0))"
        cell.lblQtdOfertaUTI.font = UIFont.boldSystemFont(ofSize: cell.lblQtdOfertaUTI.font.pointSize)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

extension LeitosViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if (searchText.isEmpty) {
            self.listaUfFiltrada = self.listaUfSelecionada
        } else {
            self.listaUfFiltrada = self.listaUfSelecionada.filter { dados in
                return dados.source?.nomeCnes?.contains(searchText.uppercased()) ?? false
            }
        }
        self.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        self.listaUfFiltrada = self.listaUfSelecionada
        self.tableView.reloadData()
    }
}
