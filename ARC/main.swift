//
//  main.swift
//  ARC
//
//  Created by Myoung-Wan Koo on 2016. 5. 11..
//  Copyright © 2016년 Myoung-Wan Koo. All rights reserved.
//

import Foundation

print("Hello, World!")

/******************************* Case 1
 class Person {
 let name:String
 init(name:String) {
 self.name = name
 print(" \(name) is being initialized")
 }
 deinit {
 print(" \(name) is being deinitialized")
 }
 }
 
 class Apartment {
 let number: Int
 init(number:Int) {
 self.number = number
 }
 var tenant:Person?
 deinit {
 print(" Apartmetn #\(number) is being deinitialized")
 }
 }
 
 var reference1: Person?
 var reference2: Person?
 var reference3: Person?
 
 reference1 = Person(name: "John Appleseed")
 
 reference2 = reference1
 reference3 = reference1
 
 reference1 = nil
 reference2 = nil
 // Now deinitialized
 reference3 = nil
 
 *************************** End of Case 1    ********/

/******************************* Case 2
 
 // Strong Reference Cycles between Class Instances
 class Person {
 let name:String
 init(name:String) {
 self.name = name
 print(" \(name) is being initialized")
 }
 var aparment: Apartment?
 deinit {
 print(" \(name) is being deinitialized")
 }
 }
 class Apartment {
 let number: Int
 init(number:Int) {
 self.number = number
 }
 var tenant:Person?
 deinit {
 print(" Apartmetn #\(number) is being deinitialized")
 }
 }
 
 var john: Person?
 var  number73 : Apartment?
 
 john = Person(name: "John Appleseed")
 number73 = Apartment(number: 73)
 
 john!.aparment = number73
 number73!.tenant = john
 
 john = nil
 number73 = nil
 
 ************************** End of Case 2    ********/


/******************************* Case 3  
 
 // Resolving Strong References with weak reference
 
 class Person {
 let name:String
 init(name:String) {
 self.name = name
 print(" \(name) is being initialized")
 }
 var aparment: Apartment?
 deinit {
 print(" \(name) is being deinitialized")
 }
 }
 
 class Apartment {
 let number: Int
 init(number:Int) {
 self.number = number
 }
 weak var tenant:Person?
 deinit {
 print(" Apartmetn #\(number) is being deinitialized")
 }
 }
 
 var john: Person?
 var  number73 : Apartment?
 
 john = Person(name: "John Appleseed")
 number73 = Apartment(number: 73)
 
 john!.aparment = number73
 number73!.tenant = john
 
 john = nil
 number73 = nil
 
 *************************** End of Case 2    ********/


/******************************* Case 3 */
 
 // Resolving Strong References with Unowned reference
 
 class Customer {
 let name: String
 var card: CreditCard?
 init(name: String) {
 self.name = name
 print(" Customer is initialized")
 }
 deinit {
 print("\(name) is being deinitialized")
 }
 }
 
 class CreditCard {
 let number: UInt64
 unowned let customer: Customer
 init(number: UInt64, customer:Customer) {
 self.number = number
 self.customer = customer
 print(" CreditCart is initialized")
 }
 
 deinit {
 print(" Card #\(number) is being deinitialized")
 }
 }
 
 var john: Customer?
 john = Customer (name: "John Appleseed")
 john!.card = CreditCard(number:1234_5678_9012_3456, customer:john!)
 john = nil
 /************************** End of Case 3    ********/

/******************************* Case 4  */

//  Unowned reference and implicity Unwrapper Optional Properties

class Country {
    let name: String
    var capitalCity: City!
    init(name: String, capitalName:String) {
        self.name = name
        print(" County \(self.name) is initialized")
        self.capitalCity = City(name: capitalName, country:self)
    }
    deinit {
        print("\(self.name) is being deinitialized")
    }
}

class City {
    let name: String
    unowned let country: Country
    init(name: String, country:Country) {
        self.name = name
        self.country = country
        print(" City \(self.name) is initialized")
    }
    
    deinit {
        print(" City \(self.name) is being deinitialized")
    }
}

//var  country = Country(name: "Canada", capitalName: "Ottawa")

var country: Country?
country = Country(name: "Canada", capitalName: "Ottawa")

country = nil

/************************** End of Case 4    ********/
/*
/******************* Start of Case 5: Strong Ref. for Closure  */
/*
 class HTMLElement {
 let name:String
 let text:String?
 lazy var asHTML:()->String = {
 if let text = self.text {
 return "<\(self.name)>\(text)<\(self.name)>"
 } else {
 return "<\(self.name)>"
 }
 }
 init(name:String, text:String? = nil) {
 self.name = name
 self.text = text
 }
 deinit {
 println(" \(name) is being deinitialized ")
 }
 }
 
 var paragraph: HTMLElement? = HTMLElement(name:"p", text: "hello, world")
 
 println( paragraph!.asHTML())
 
 paragraph = nil
 
 */
/*
 class HTMLElement {
 let name:String
 let text:String?
 lazy var asHTML:()->String = {
 [unowned self] in
 if let text = self.text {
 return "<\(self.name)>\(text)</\(self.name)>"
 } else {
 return "<\(self.name) />"
 }
 }
 init(name:String, text:String? = nil) {
 self.name = name
 self.text = text
 }
 deinit {
 println(" \(name) is being deinitialized ")
 }
 }
 
 var paragraph: HTMLElement? = HTMLElement(name:"p", text: "hello, world")
 //var paragraph: HTMLElement? = HTMLElement(name:"p")
 
 println( paragraph!.asHTML())
 
 paragraph = nil
 
 */

/******************* End of Case 5: Strong Ref. for Closure  */


/************* Optional Chaining ***********************/
/*
 class Person {
 var residence: Residence?
 }
 class Residence {
 var numberOfRooms = 1
 }
 let john = Person()
 
 // Yield runtime error
 //let roomCount = john.residence!.numberOfRooms
 
 if let roomCount = john.residence?.numberOfRooms {
 print(" John's residence has \(roomCount) rooms")
 } else {
 print(" Unable to retrieve the number of rooms")
 }
 
 john.residence = Residence()
 if let roomCount = john.residence?.numberOfRooms {
 print(" John's residence has \(roomCount) rooms")
 } else {
 print(" Unable to retrieve the number of rooms")
 }
 */


/******************* Four Clasee Optional Chaining *************/
//Defining Model Classed for Optional Chaining;;  Four Classes

class Person {
    var residence: Residence?
}
class Residence {
    var rooms = [Room]()
    var numberOfRooms :Int {
        return rooms.count
    }
    subscript(i:Int) -> Room {
        get { return rooms[i] }
        set {  rooms[i] = newValue }
    }
    func printNumberOfRooms() {
        print(" The number of rooms is \(numberOfRooms)")
    }
    var address: Address?
}

class Room {
    let name:String
    init(name: String) {
        self.name = name
    }
}
class Address{
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {  // Optional Return
        if buildingName != nil {
            return buildingName
        } else if buildingNumber != nil {
            return buildingNumber
        } else {
            return nil
        }
    }
}

// Accessing Properties through Optional Chaining

let john = Person()
if let roomCount = john.residence?.numberOfRooms {
    print(" in Accessing Propertied through Optional Chaining: John's residence has \(roomCount) rooms")
} else {
    print(" in Accessing Propertied through Optional Chaining: Unable to retrieve the number of rooms")
}


// Set a properties' value through optional chaining
let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
john.residence?.address = someAddress
if let buildingNumber = john.residence?.address?.buildingNumber {
    print(" in Accessing Propertied through Optional Chaining: John's residence has \(buildingNumber) rooms")
} else {
    print(" in Accessing Propertied through Optional Chaining: Unable to retrieve the number of rooms")
}

func createAddress() -> Address {
    print(" Function was called")
    let someAddress = Address()
    someAddress.buildingNumber = "29"
    someAddress.street = "Acacia Road"
    return someAddress
}
john.residence?.address = createAddress()

// Calling Methods Through Optional Chaining
if john.residence?.printNumberOfRooms() != nil {
    print(" in Calling Method through Optional Chaining: John's residence has \(john.residence?.numberOfRooms) rooms")
} else {
    print(" in Calling Method through Optional Chaining: Unable to retrieve the number of rooms")
}
// Compare nil against nil to see if the property was successful
if (john.residence?.address = someAddress) != nil {
    print(" It was possible to set the address")
} else {
    print(" It was not possible to set the address")
}


// Accessing Subscripts through Optional Chaining
john.residence?[0] = Room(name: "Bathroom" )
if let firstRoomName = john.residence?[0].name{
    print(" The first room name is \(firstRoomName)")
} else {
    print(" Unable to retrieve the first room name")
}
john.residence?[0] = Room(name: "Bathroom" )
// assign an actual Residence instance to john.residence

let johnsHouse = Residence()
johnsHouse.rooms.append(Room(name: "Living Room"))
johnsHouse.rooms.append(Room(name: "Kitchen"))
john.residence = johnsHouse

if let firstRoomName = john.residence?[0].name{
    print(" After assigning actual Residence instance to john.residence: The first room name is \(firstRoomName)")
} else {
    print(" Unable to retrieve the first room name")
}

// accssing Subscripts of Optionl Type
print(" \n accssing Subscripts of Optionl Type")
var testScores = ["Dave":[86,82,84], "Bev":[79,94,81]]
testScores["Dave"]?[0] = 91
testScores["Bev"]?[0]+=1
testScores["Brian"]?[0] = 72

for (key, contents) in testScores {
    print(key)
    print(contents)
}

// Linking Multiple Levels of Chaining
print(" \n Linking Multiple Levels of Chaining ")
if let johnsStreet = john.residence?.address?.street {
    print(" John's street name is \(johnsStreet).")
} else  {
    print(" Unable to retrieve the address")
}

let johnsAddress = Address()
johnsAddress.buildingName = "The Larches"
johnsAddress.street = "Laurel Street"
john.residence?.address = johnsAddress

if let johnsStreet = john.residence?.address?.street {
    print(" After assigning Address : John's street name is \(johnsStreet).")
} else  {
    print(" Unable to retrieve the address")
}

// Chaining on Methods with Optional Return Values
print("\n Chaining on Methods with Optional Return Values")

if let buildingIdentifier = john.residence?.address?.buildingIdentifier() {
    print(" John's building identifier is \(buildingIdentifier)")
}

if let beginsWithThe = john.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
    if beginsWithThe {
        print(" John's building identifier begins with \"The\". ")
    } else {
        print(" John's building identifier does not begin with \"The\".")
    }
}
/******************** Four Clasee Optional Chaining *************/

 */
