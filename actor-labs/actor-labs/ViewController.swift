//
//  ViewController.swift
//  actor-labs
//
//  Created by 이인애 on 2022/05/05.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            await simulateTransfer()
        }
    }
    
    func simulateTransfer() async {
        let accountA = BankAccount(accountNumber: 123, initDeposit: 100.0)
        let accountB = BankAccount(accountNumber: 456, initDeposit: 150.0)
        
        print(await accountA.balance)
        print(await accountB.balance)
        
        await accountB.checkBalance(account: accountA)
    }
}
