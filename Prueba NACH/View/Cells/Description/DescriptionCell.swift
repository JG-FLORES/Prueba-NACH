//
//  DescriptionCell.swift
//  Prueba NACH
//
//  Created by Joel Guerra on 03/12/21.
//

import UIKit

class DescriptionCell: UITableViewCell {
    
//    MARK: Var
    @IBOutlet weak var lblDescription: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        lblDescription.text = "Una gráfica o representación gráfica es un tipo de representación de datos, generalmente numéricos, mediante recursos visuales (líneas, vectores, superficies o símbolos), para que se manifieste visualmente la relación matemática o correlación estadística que guardan entre sí. También es el nombre de un conjunto de puntos que se plasman en coordenadas cartesianas y sirven para analizar el comportamiento de un proceso o un conjunto de elementos o signos que permiten la interpretación de un fenómeno. La representación gráfica permite establecer valores que no se han obtenido experimentalmente sino mediante la interpolación (lectura entre puntos) y la extrapolación (valores fuera del intervalo experimental)."
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
