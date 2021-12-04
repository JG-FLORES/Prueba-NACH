//
//  GraphViewController.swift
//  Prueba NACH
//
//  Created by Joel Guerra on 03/12/21.
//

import UIKit
import MTCircleChart

class GraphViewController: UIViewController {
    
//    MARK: Var
    var circleChart = MTCircleChart()
    var questions: Result?
    
    let titleGraph: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 22)
        lbl.numberOfLines = 0
        lbl.textColor = .black
        return lbl
    }()
    
    func configureGraph(){
        let tracks = addMTTrack()
        let textColor = UIColor(red: 75/255, green: 118/255, blue: 176/255, alpha: 1.0)
        circleChart = MTCircleChart(tracks: tracks, MTConfig(textColor: textColor))
        circleChart.translatesAutoresizingMaskIntoConstraints = false
        circleChart.backgroundColor = .white
        view.addSubview(circleChart)
    }
    
    func addMTTrack() -> [MTTrack]{
        if let charData = questions?.chartData{
            if !charData.isEmpty{
                self.titleGraph.text = questions?.text
                let mainColor = UIColor(red: 185/255, green: 212/255, blue: 235/255, alpha: 1.0)
                return charData.map { MTTrack(value: CGFloat($0.percetnage), total: 100, color: mainColor, text: $0.text)}
            }
        }
        return []
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureGraph()
        layout()
    }
    
    // MARK: Layout
    private func layout() {
        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: [], metrics: nil, views: ["view": circleChart])
        )
        NSLayoutConstraint.activate(
             NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: [], metrics: nil, views: ["view": circleChart])
        )
        
        view.addSubview(titleGraph)

        titleGraph.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        titleGraph.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        titleGraph.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        titleGraph.translatesAutoresizingMaskIntoConstraints = false
    }
}

