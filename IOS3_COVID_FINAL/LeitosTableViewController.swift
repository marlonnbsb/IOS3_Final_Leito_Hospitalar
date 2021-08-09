//
//  LeitosTableViewController.swift
//  IOS3_COVID_FINAL
//
//  Created by Marlon Machado on 09/08/21.
//

import UIKit

class LeitosTableViewController: UITableViewController {

    var listaUfSelecionada: [Hit] = []
    var listaUfFiltrada: [Hit] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Lista Leitos"
        self.listaUfFiltrada = self.listaUfSelecionada
        self.searchBarSetup()
    }
    
    func searchBarSetup() {
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: (UIScreen.main.bounds.width), height: 70))
        searchBar.showsScopeBar = true
        searchBar.placeholder = "Nome do Hospital"
        searchBar.delegate = self
        
        self.tableView.tableHeaderView = searchBar
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.listaUfFiltrada.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellLeitos", for: indexPath) as! LeitosTableViewCell

        cell.lblMunicipio.text = "\(String(describing: self.listaUfFiltrada[indexPath.row].source?.municipio ?? "")) - "
        cell.lblEstado.text = String(describing: self.listaUfFiltrada[indexPath.row].source?.estadoSigla ?? "").uppercased()
        cell.lblNomeCnes.text = String(describing: self.listaUfFiltrada[indexPath.row].source?.nomeCnes ?? "Hospital").uppercased()
        cell.lblQtdRespiradores.text = "Qtd Respiradores: \(String(describing: self.listaUfFiltrada[indexPath.row].source?.ofertaRespiradores ?? 0))"
        cell.lblQtdObtos.text = "Qtd Obtos: \(String(describing: self.listaUfFiltrada[indexPath.row].source?.obitos ?? 0))"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }

}

extension LeitosTableViewController: UISearchBarDelegate {
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
}
