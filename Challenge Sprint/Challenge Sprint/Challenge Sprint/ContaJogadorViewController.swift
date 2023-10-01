//
//  ContaJogadorViewController.swift
//  Challenge Sprint
//
//  Created by Usuário Convidado on 11/09/23.
//

import UIKit
import CoreData

class ContaJogadorViewController: UIViewController {

    @IBOutlet weak var txtNome: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtSenha: UITextField!
    @IBOutlet weak var txtGenero: UITextField!
    @IBOutlet weak var txtIdade: UITextField!
    @IBOutlet weak var txtCep: UITextField!
    
    var contaJogador:NSManagedObject?=nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if contaJogador != nil{
            txtNome.text = contaJogador?.value(forKey: "nome") as? String
            txtEmail.text = contaJogador?.value(forKey: "email") as? String
            txtSenha.text = contaJogador?.value(forKey: "senha") as? String
            
            txtGenero.text = contaJogador?.value(forKey: "genero") as? String
            let idade = contaJogador?.value(forKey: "idade") as? Int
            
            let cep = contaJogador?.value(forKey: "cep") as? Int
            
            txtIdade.text = "\(idade!)"
            txtCep.text = "\(cep!)"
        }
        // Do any additional setup after loading the view.
    }
    @IBAction func Salvar(_ sender: Any) {
        self.save(nome: txtNome.text!, email: txtEmail.text!, senha: txtSenha.text!, genero: txtGenero.text!, idade: txtIdade.text!, cep: txtCep.text!)
        self.navigationController?.popViewController(animated: true)
    }
    
    func save(nome:String, email:String, senha:String, genero:String, idade:String, cep:String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entidade = NSEntityDescription.entity(forEntityName: "Jogador", in: managedContext)!
        
        let jogador = NSManagedObject(entity: entidade, insertInto: managedContext)
        
        if(contaJogador == nil){
            jogador.setValue(nome, forKeyPath: "nome")
            jogador.setValue(email, forKeyPath: "email")
            jogador.setValue(senha, forKeyPath: "senha")
            jogador.setValue(genero, forKeyPath: "genero")
            jogador.setValue(Int(idade), forKeyPath: "idade")
            jogador.setValue(Int(cep), forKeyPath: "cep")
        }else{
            let objectUpdate = contaJogador
            objectUpdate!.setValue(nome, forKeyPath: "nome")
            objectUpdate!.setValue(email, forKeyPath: "email")
            objectUpdate!.setValue(senha, forKeyPath: "senha")
            objectUpdate!.setValue(genero, forKeyPath: "genero")
            objectUpdate!.setValue(Int(idade), forKeyPath: "idade")
            objectUpdate!.setValue(Int(cep), forKey: "cep")
        }
        
        do{
            try managedContext.save()
        }
            catch let error as NSError{
                print("Não foi possível salvar a sua conta! Por causa do erro: \(error); \(error.userInfo)")
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


