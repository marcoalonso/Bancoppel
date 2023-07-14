//
//  ViewController.swift
//  Bancoppel
//
//  Created by Marco Alonso Rodriguez on 13/07/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var saldoLabel: UILabel!
    var saldo: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saldoLabel.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        consultarSaldo()
    }
    
    private func consultarSaldo(){
        if let saldoDB = UserDefaults.standard.double(forKey: "saldo") as Double? {
            self.saldo = saldoDB
            saldoLabel.text = "Saldo: $\(saldoDB)"
        }
    }

    @IBAction func consultaSaldoBtn(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseInOut, animations: {
            self.saldoLabel.isHidden = false
        }, completion: nil)
        
        //Animacion
        DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
            UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseInOut, animations: {
                self.saldoLabel.isHidden = true
            }, completion: nil)
        }
    }
    @IBAction func depositarBtn(_ sender: UIButton) {
    }
    @IBAction func retirarBtn(_ sender: UIButton) {
    }
    @IBAction func salirBtn(_ sender: UIButton) {
        exit(0)
    }
    
}

