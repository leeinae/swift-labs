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

    /// 다른 actor (cross-actor reference)의 상태값을 포함하므로 비동기적 호출이 필요(asynchronously)
    /// 하지만 실제 메소드 내부 구현에서 async 하지 않으므로, async 키워드를 붙여서 구현할 필요가 없다.
    /// 별안간 synchronous하게 구현하는 것이 낫지만, cross-actor에서 접근 시 await 키워드 필요
    func deposit(amount: Double) {
        assert(amount >= 0)
        balance += amount
    }

    /// cross-actor reference가 아닌 경우 (actor의 self 접근)은 동기적으로 수행할 수 있다.
    /// other actor에서 호출할 경우만 await 키워드가 필요하다는 것
    func passGo() {
        /// self는 isloated 하기 때문에 동기 OK
        deposit(amount: 200.0)
    }

    /// cross-actor reference의 property는 async하게 read-only로만 접근 가능
    func checkBalance(account: BankAccount) async {
        print(await account.balance)
        print(account.accountNumber)

        /// complier: Actor-isolated property 'balance' can not be mutated on a non-isolated actor instance
//        await account.balance = 100.0
    }
}
