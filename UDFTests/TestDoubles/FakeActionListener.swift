//  Copyright 2021  Suol Innovations Ltd.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import UDF
import Foundation

class FakeActionListener: ActionListener {

    typealias Props = (Int, Action)

    var queue: DispatchQueue { .main }

    var propsHistory = [(Int, Action)]()

    var props: (Int, Action) = (0, DefaultAction()) {
        didSet {
            propsHistory.append(props)
            propsDidSet(propsHistory)
        }
    }

    var disposer = Disposer()

    let onDeinit: () -> Void
    let propsDidSet: ([(Int, Action)]) -> Void

    init(onDeinit: @escaping () -> Void = { }, propsDidSet: @escaping ([(Int, Action)]) -> Void = { _ in }) {
        self.onDeinit = onDeinit
        self.propsDidSet = propsDidSet
    }

    deinit {
        onDeinit()
    }

    class DefaultAction: Action {}
}

