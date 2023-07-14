//
//  RetiroViewController.swift
//  Bancoppel
//
//  Created by Marco Alonso Rodriguez on 13/07/23.
//

import UIKit

class RetiroViewController: UIViewController {

    @IBOutlet weak var cantidadRetirarLabel: UILabel!
    @IBOutlet weak var cantidadRetirar: UITextField!
    @IBOutlet weak var saldoLabel: UILabel!
    
    var saldoTotal: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        consultarSaldo()
        cantidadRetirarLabel.isHidden = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    private func consultarSaldo(){
        if let saldoDB = UserDefaults.standard.double(forKey: "saldo") as Double? {
            self.saldoTotal = saldoDB
            saldoLabel.text = "Saldo: $\(self.saldoTotal)"
        }
    }
    
    @IBAction func confirmarBtn(_ sender: UIButton) {
        if cantidadRetirar.text != "" {
            let cantidadRetirar = Double(cantidadRetirar.text!) ?? 0.0
            if cantidadRetirar <= saldoTotal {
                ///Actualizar saldo
                self.saldoTotal = saldoTotal - cantidadRetirar
                ///Guardar el saldo en BD
                UserDefaults.standard.set(saldoTotal, forKey: "saldo")
                
                
                UIView.animate(withDuration: 0.6, delay: 0.0, options: .curveEaseInOut, animations: {
                    self.cantidadRetirarLabel.text = "Retiro exitoso por: $\(cantidadRetirar)"
                    self.saldoLabel.text = "Saldo: $\(self.saldoTotal)"
                    
                }, completion: nil)
                
                self.cantidadRetirar.text = ""
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    let alerta = UIAlertController(title: "¿Desea realizar otro retiro?", message: "", preferredStyle: .alert)
                    let accionAceptar = UIAlertAction(title: "Si", style: .default) { _ in
                        //Do something
                    }
                    let accionCancelar = UIAlertAction(title: "No", style: .destructive) { _ in
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                    alerta.addAction(accionAceptar)
                    alerta.addAction(accionCancelar)
                    self.present(alerta, animated: true)
                }
                
            } else {
                mostrarAlerta(titulo: "Atención", mensaje: "La cantidad a retirar excede el saldo total de la cuenta, por favor digita una cantidad menor")
            }
        } else {
            saldoLabel.text = "Escribe la cantidad a retirar"
        }
    }
    
    func mostrarAlerta(titulo: String, mensaje: String) {
        let alerta = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        let accionAceptar = UIAlertAction(title: "Aceptar", style: .default) { _ in
        }
        alerta.addAction(accionAceptar)
        present(alerta, animated: true)
    }

}
