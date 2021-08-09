//
//  LeitosTableViewCell.swift
//  IOS3_COVID_FINAL
//
//  Created by Marlon Machado on 09/08/21.
//

import UIKit

class LeitosTableViewCell: UITableViewCell {

    @IBOutlet weak var lblMunicipio: UILabel!
    @IBOutlet weak var lblEstado: UILabel!
    @IBOutlet weak var lblNomeCnes: UILabel!
    @IBOutlet weak var lblQtdRespiradores: UILabel!
    @IBOutlet weak var lblQtdObtos: UILabel!
    @IBOutlet weak var lblQtdOfertaUTI: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
