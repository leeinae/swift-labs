//
//  BackAccount.swift
//  actor-labs
//
//  Created by 이인애 on 2022/05/05.
//

import Foundation

actor BankAccount {
    let accountNumber: Int
    var balance: Double

    init(accountNumber: Int, initDeposit: Double) {
        self.accountNumber = accountNumber
        balance = initDeposit
    }
}

extension BankAccount {
    enum BankError: Error {
        case insufficientFunds
    }

    func transfer(amount: Double, to other: BankAccount) async throws {
        if amount > balance {
            throw BankError.insufficientFunds
        }

        balance = balance - amount
        await other.deposit(amount: amount)
    }

    func deposit(amount: Double) async {
        assert(amount >= 0)
        balance += amount
    }
}
