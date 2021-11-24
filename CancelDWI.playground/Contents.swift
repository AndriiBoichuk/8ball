import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let backgroundQueue = DispatchQueue.global(qos: .background)

let dispatchWorkItem = DispatchWorkItem {
    while true {
        print("0")
    }
}

backgroundQueue.async(execute: dispatchWorkItem)
backgroundQueue.asyncAfter(deadline: DispatchTime.now() + 2) {
    dispatchWorkItem.cancel()
}




