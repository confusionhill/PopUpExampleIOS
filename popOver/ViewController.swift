//
//  ViewController.swift
//  popOver
//
//  Created by Farhandika on 29/06/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
    }

    @IBAction func didTapPresent(_ sender: UIButton) {
        PopUpModalViewController.present(
            initialView: self,
            delegate: self)
    }
    
}

extension ViewController: PopUpModalDelegate {
    func didTapCancel() {
        self.dismiss(animated: true)
    }
    
    func didTapAccept(){
        
    }
}

