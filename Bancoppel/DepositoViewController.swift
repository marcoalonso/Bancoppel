//
//  DepositoViewController.swift
//  Bancoppel
//
//  Created by Marco Alonso Rodriguez on 13/07/23.
//

import UIKit

class DepositoViewController: UIViewController {

    @IBOutlet weak var informacionLabel: UILabel!
    @IBOutlet weak var depositoTextField: UITextField!
    
    var saldoTotal: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        consultarSaldo()
        informacionLabel.text = "Ingresa la cantidad a depositar"
    }
    
    private func consultarSaldo(){
        if let saldoDB = UserDefaults.standard.double(forKey: "saldo") as Double? {
            self.saldoTotal = saldoDB
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    @IBAction func confirmarBtn(_ sender: UIButton) {
        if depositoTextField.text != "" {
            
            let cantidadDepositar = Double(depositoTextField.text ?? "0.0")
            self.saldoTotal = saldoTotal + cantidadDepositar!
            
            UserDefaults.standard.set(saldoTotal, forKey: "saldo")
            
            self.informacionLabel.isHidden = true
            //Animacion
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveLinear, animations: {
                self.informacionLabel.isHidden = false
                self.informacionLabel.text = "Se abonaron: $\(self.depositoTextField.text!) y tu saldo actual es de: $\(self.saldoTotal)"
            }, completion: nil)
            
            depositoTextField.text = ""
            
            
            let alerta = UIAlertController(title: "ATENCION", message: "¿Deseas realiar otro deposito?", preferredStyle: .alert)
            let accionAceptar = UIAlertAction(title: "Si", style: .default) { _ in
                self.depositoTextField.resignFirstResponder()
            }
            let accionCancelar = UIAlertAction(title: "No", style: .destructive) { _ in
                self.depositoTextField.resignFirstResponder()
                self.navigationController?.popToRootViewController(animated: true)
            }
            
            alerta.addAction(accionAceptar)
            alerta.addAction(accionCancelar)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.present(alerta, animated: true)
            }
        } else {
            informacionLabel.text = "Ingresa una cantidad a depositar"
        }
        
    }
    
}
