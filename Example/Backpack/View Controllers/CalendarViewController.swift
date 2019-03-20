//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2019 Skyscanner Ltd
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import UIKit
import Backpack.Calendar

class CalendarViewController: UIViewController, CalendarDelegate {
    @IBOutlet weak var myView: Backpack.Calendar!
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    override func viewDidLoad() {
        myView.minDate = Date()
        myView.locale = Locale.current
        myView.delegate = self
    }

    @IBAction func valueChanged(_ sender: Any) {
        myView.selectionType = BPKCalendarSelection(rawValue: UInt(segmentedControl!.selectedSegmentIndex))!
        myView.reloadData()
    }

    func calendar(_ calendar: Backpack.Calendar!, didChangeDateSelection dateList: [Date]!) {
        print("calendar:", calendar, "didChangeDateSelection:", dateList)
    }

    func calendar(_ calendar: Backpack.Calendar!, didScroll contentOffset: CGPoint) {
        print("calendar:", calendar, "didScroll:", contentOffset, "isTracking:", calendar.isTracking)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        myView.reloadData()
    }
}
