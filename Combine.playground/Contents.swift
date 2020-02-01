import Combine

var str = "Hello, playground"


 public func example(of disc:String,action: ()->Void){
     
     print("\n----------Example OF:",disc,"--------")
     action()
     
     
     
 }

/*THIS'S A REWRITE FOR SOME OBERATORS SINCE I LOST THE FILES*/


//🎉COLLECT, BY3ML ARRAYS MN ELDATA ELLY GAYA MN PUBLISHER

var publisher = (1...30).publisher

publisher
    .collect(10)
    .sink { (array) in
      // print(array)
        /*
         [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
         [11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
         [21, 22, 23, 24, 25, 26, 27, 28, 29, 30]

         */
}
 publisher = (1...20).publisher


//🎉MAP, BY3ML Function on each element
publisher
    .map{$0 / 2 }
    .collect(10)
    //.sink{print($0)}
/*
 [0, 1, 1, 2, 2, 3, 3, 4, 4, 5]
 [5, 6, 6, 7, 7, 8, 8, 9, 9, 10]
 */


//🎉MAP keypath, bygen 7agat mo7dda fe structs for example

struct coordinate {
    let x: Int
    let y: Int
    let name: String
}

let z = coordinate(x: 20, y: 12, name: "Mostfa")
let publisherZ = PassthroughSubject<coordinate,Never>()

publisherZ
    .map(\.x , \.name)
    .sink { (x,name) in
        /*
         at this point we have only have the x and name and we dont know anything about the y
         */
//print(x,name)
}

publisherZ.send(z)

//Can't use 🎉flat map here since it need some files to be imported, will solve it in the downloaded files


//🎉MAP keypath, bygen 7agat mo7dda fe structs for example

//🎉replaceNil, will replace any nil value of a value of the same type, for example will need to replace the values from this publisher to a value with type string

let nilPublisher = ["A","ME",nil,"D"].publisher

nilPublisher
    .replaceNil(with: "-Nil-")
    .map{$0!} // this was added after we are sure that there's no any nil value coming from our publisher
    .sink { (value) in
      //  print(value)
}


//🎉replaceEmpty , will replace empty value coming from the publisher with a specified value from its type

let emptyPublisher = Empty<Int,Never>()
emptyPublisher
    .replaceEmpty(with: 12)
    .sink { (value) in
    //    print(value)
}
////🎉scan, start with a value *50* in this example, and take each value from the publisher and adds it to the 50


var dailyGainLoss: Int {.random(in: -10...10)} //creates a range from -10 to 10
let augaust2020 = (0..<22)
    .map{_ in dailyGainLoss}
    .publisher

augaust2020.scan(50) {lastest, current in max(lastest+current,0)}
    //.sink { (x) in print(x)}
// I HAVE COMPLETED THE TASK OF PHONE CALL IN ITS FILE


//✳️CHAPTER 4

//🎉filter, filters the upstream based on a prsedure if it returns true data will pass, otherwisre it won't pass
let publisherFilter = (0...120).publisher
    publisherFilter
        .filter{$0.isMultiple(of: 3)}
        .collect(20)
        //.sink(receiveValue: {print($0)})
/*
 [0, 3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 33, 36, 39, 42, 45, 48, 51, 54, 57]
 [60, 63, 66, 69, 72, 75, 78, 81, 84, 87, 90, 93, 96, 99, 102, 105, 108, 111, 114, 117]
 [120]
 */

//🎉removeDublicate, remove the dublicates from the upstream

let dublicatePublisher = (0...20).publisher
    dublicatePublisher
    .map{$0/2}
        .removeDuplicates()
        .collect(10)
     //   .sink(receiveValue: {print($0)})

/*
 [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
 [10]
 */


//🎉compactMap, remove any nil after applying the opeation specified in its block

let string = ["293.1","m","2"].publisher
string
    .compactMap{Float($0)}
.collect(2)
//.sink(receiveValue: {  print($0)})
/*
 [293.1, 2.0]
 */
        

//🎉firstWhere, first item whish make the clousre equal to true, it cancels the subsceiption after receiveng the wanted value
let numbers = (1...9).publisher
numbers.first(where: {$0 % 2 == 0})
   // .sink { (x) in print(x)}
/*
 2
 */

//🎉dropValues, drop values until the predicate == true, so it contuntues the upstream
let dropValues = (1...9).publisher
numbers.drop(while: {$0 / 5 == 0})
    //.sink { (x) in print (x)}
/*
 2
 */

//✳️chapter 5
//🎉prepend some elements before the publisher emitts anything
let prependPublisher = (1...20).publisher
    prependPublisher
        .prepend(50000,1202022)
//        .sink { (x) in
//            print(x)
//}

//🎉switchToLastest: switch between publishers, once a publisher was sent to the main publisher, the main publisher will start to emit the values of that publisher, GAMED !


let publisher1 = PassthroughSubject<Int,Never>()
let publisher2 = PassthroughSubject<Int,Never>()
let publisher3 = PassthroughSubject<Int,Never>()

let publishers = PassthroughSubject<PassthroughSubject<Int,Never>,Never>()

publishers
    .switchToLatest()
    .sink { (n) in
    print(n)
}

example(of: "switchToLastest") {
    publishers.send(publisher1)
    publisher1.send(12) //will be recieved and print
    publisher1.send(132)   //will be recieved and print
    publisher1.send(1322)  //will be recieved and print
    publisher1.send(20)  //will be recieved and print
    publishers.send(publisher2)
    publisher1.send(2)  //won't be recieved and print
    publisher2.send(33333333)  //will be recieved and print
     /*
     12
     132
     1322
     20
     33333333

     */


}
import Foundation
import UIKit
var k = Set<AnyCancellable>() //THIS'S NEEDED TO BE SURE THAT SUBSCRIBTIONS WONT BE CANCELED
example(of: "real example of switchToLastest") {
    var supscription: AnyCancellable?
    let url = URL(string: "https://source.unsplash.com/random")!
    
    func getImage() -> AnyPublisher<UIImage?,Never> {
        return URLSession
        .shared
        .dataTaskPublisher(for: url)
        .map{data, _ in UIImage(data: data)}
        .print("image")
        .replaceError(with: nil)
        .eraseToAnyPublisher()
        
    }
        
    let taps = PassthroughSubject<Void,Never>()
    taps
        .map{_ in getImage()} //PULISHER DA EACH TIME IS CALLED, IT START TO EMIT PUBLISHER OF  AnyPublisher<UIImage?,Never> , OKAY ?
        .switchToLatest()
        .sink(receiveValue: {_ in})
        .store(in: &k)
    
    taps.send()
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        taps.send()
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
        taps.send()
    }

        
    
}






