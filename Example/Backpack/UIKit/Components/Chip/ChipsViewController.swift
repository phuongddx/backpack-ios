/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018 Skyscanner Ltd
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
import Backpack

struct ChipConfig {
    let title: String
    let icon: BPKSmallIconName?
    let type: BPKChipType
}

class ChipsViewController: UIViewController {
    private var style: BPKChipStyle
    private var titleColor: UIColor

    init(style: BPKChipStyle, titleColor: UIColor) {
        self.style = style
        self.titleColor = titleColor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let stackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.spacing = BPKSpacingSm
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    private let chips: [ChipConfig] = [
        ChipConfig(
            title: "Option",
            icon: nil,
            type: .option
        ),
        ChipConfig(
            title: "Dropdown",
            icon: nil,
            type: .dropdown
        ),
        ChipConfig(
            title: "Dismiss",
            icon: nil,
            type: .dismiss
        ),
        ChipConfig(
            title: "With icon",
            icon: .deals,
            type: .option
        )
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UINavigationBarAppearance()
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        
        view.backgroundColor = BPKColor.surfaceDefaultColor
        
        setupDemo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateStackViewOrientation()
    }
    
    private func setupDemo() {
        if style == .onImage {
            let backgroundImageView = UIImageView(image: UIImage(named: "canadian_rockies_canada"))
            backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
            backgroundImageView.contentMode = .scaleAspectFit
            backgroundImageView.clipsToBounds = true
            
            view.addSubview(backgroundImageView)
            
            NSLayoutConstraint.activate([
                backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                backgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        }
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: BPKSpacingBase),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: BPKSpacingMd),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -BPKSpacingMd),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -BPKSpacingBase)
        ])
        
        stackView.addArrangedSubview(createColumn(title: "Off", selected: false, enabled: true))
        stackView.addArrangedSubview(createColumn(title: "On", selected: true, enabled: true))
        stackView.addArrangedSubview(createColumn(title: "Disabled", selected: false, enabled: false))
    }
    
    private func createColumn(title: String, selected: Bool, enabled: Bool) -> UIView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = BPKSpacingMd
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = BPKLabel(fontStyle: .textHeading5)
        titleLabel.text = title
        titleLabel.textColor = titleColor
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        stack.addArrangedSubview(titleLabel)
        
        chips.map {
            let chip = BPKChip(title: $0.title, icon: $0.icon)
            chip.isEnabled = enabled
            chip.style = style
            chip.type = $0.type
            chip.isSelected = selected
            
            chip.accessibilityIdentifier = "chip_\($0.title.lowercased())_enabled_\(enabled)_selected_\(selected)"
            
            // This chip version should not exist
            // But we still want it to occupy the space
            if $0.type == .dismiss && !selected {
                chip.alpha = 0
                chip.isUserInteractionEnabled  = false
            }

            return chip
        }.forEach(stack.addArrangedSubview)
        
        return stack
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if traitCollection.preferredContentSizeCategory == previousTraitCollection?.preferredContentSizeCategory {
            return
        }
        
        updateStackViewOrientation()
    }
    
    private func updateStackViewOrientation() {
        if traitCollection.preferredContentSizeCategory > .large {
            stackView.axis = .vertical
        } else {
            stackView.axis = .horizontal
        }
    }
}
