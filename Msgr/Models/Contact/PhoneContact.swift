//
//  PhoneContact.swift
//  Msgr
//
//  Created by Aung Ko Min on 25/10/22.
//

import Foundation
import Contacts

class PhoneContact: ObservableObject, Identifiable {

    var id: String { phoneNumber.first ?? ""}
    var name: String?
    var avatarData: Data?
    var phoneNumber: [String] = [String]()
    var email: [String] = [String]()

    init(contact: CNContact) {
        name = contact.givenName + " " + contact.familyName
        avatarData = contact.thumbnailImageData
        for phone in contact.phoneNumbers {
            let numberValue = phone.value
            if
                //                    let countryCode = numberValue.value(forKey: "countryCode") as? String,
                let digits = numberValue.value(forKey: "digits") as? String {
                phoneNumber.append(digits)
            }
//            phoneNumber.append(phone.value.stringValue)
        }
        for mail in contact.emailAddresses {
            email.append(mail.value as String)
        }
    }

    func cContact() -> Contact {
        return Contact.fecthOrCreate(for: self)
    }
}