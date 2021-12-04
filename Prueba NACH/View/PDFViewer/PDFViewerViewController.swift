//
//  PDFViewerViewController.swift
//  Prueba NACH
//
//  Created by Joel Guerra on 03/12/21.
//

import UIKit
import PDFKit

class PDFViewerViewController: UIViewController {

    let pdfView = PDFView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Complemento PDF"
        setupPDFViewer()
    }
    
    func setupPDFViewer(){
        guard let path = Bundle.main.url(forResource: "Prueba-NACH", withExtension: "pdf"), let document =  PDFDocument(url: path) else { return }

        pdfView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pdfView)
        pdfView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        pdfView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        pdfView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        pdfView.autoScales = true
        pdfView.document = document

    }
}
