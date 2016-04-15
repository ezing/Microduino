//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var button :UIButton?



print(str,1,2)

var tem = ["1",2,"swift"]

print(tem[1])

var arr2 = [Int](count: 10, repeatedValue: 0)

var dict2 = [String:Int](minimumCapacity:4)

var profile = (age: 30, weight: 10.5, male: true)
let age = profile.age
let weight = profile.weight
let isMale = profile.male

var a: String? = "hello"
print(a)
var str1 = a!
print(str1)

var dict :[String:String?] = [:]
dict = ["key":"value"]
func justReturnNil() -> String? {
    return nil
}
dict["key"] = justReturnNil()
dict

func addTo(adder: Int) -> Int -> Int {
    return {
        num in
        return num + adder
    }
}

let result = addTo(2)
let addTwo = result(6)

func greaterThan(comparer: Int) -> Int -> Bool {
    return { $0 > comparer }
}

let greaterThan10 = greaterThan(10);

greaterThan10(13)    // => true
greaterThan10(9)

protocol TargetAction {
    func performAction()
}

struct TargetActionWrapper<T: AnyObject>:
TargetAction {
    weak var target: T?
    let action: (T) -> () -> ()
    
    func performAction() -> () {
        if let t = target {
            action(t)()
        }
    }
}

enum ControlEvent {
    case TouchUpInside
    case ValueChanged
    // ...
}


class Control {
    var actions = [ControlEvent: TargetAction]()
    
    func setTarget<T: AnyObject>(target: T,
                   action: (T) -> () -> (),
                   controlEvent: ControlEvent) {
        
        actions[controlEvent] = TargetActionWrapper(
            target: target, action: action)
    }
    
    func removeTargetForControlEvent(controlEvent: ControlEvent) {
        actions[controlEvent] = nil
    }
    
    func performActionForControlEvent(controlEvent: ControlEvent) {
        actions[controlEvent]?.performAction()
    }
}

