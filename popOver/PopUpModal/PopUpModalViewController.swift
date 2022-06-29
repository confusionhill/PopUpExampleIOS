//
//  PopUpModalViewController.swift
//  popOver
//
//  Created by Farhandika on 29/06/22.
//

import UIKit

public protocol PopUpModalDelegate: AnyObject {
    func didTapCancel()
    func didTapAccept()
}

public final class PopUpModalViewController: UIViewController {
    
    private static func create(
        delegate: PopUpModalDelegate
    ) -> PopUpModalViewController {
        let view = PopUpModalViewController(delegate: delegate)
        return view
    }
    
    @discardableResult
    static public func present(
        initialView: UIViewController,
        delegate: PopUpModalDelegate
    ) -> PopUpModalViewController {
        let view = PopUpModalViewController.create(delegate: delegate)
        view.modalPresentationStyle = .overFullScreen
        view.modalTransitionStyle = .coverVertical
        initialView.present(view, animated: true)
        return view
    }
    
    public init(delegate: PopUpModalDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public weak var delegate: PopUpModalDelegate?
    
    private lazy var canvas: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var cancelButton: UIButton = {
        let b: UIButton = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = .systemRed
        b.setTitle("Cancel", for: .normal)
        b.addTarget(self, action: #selector(self.didTapCancel(_:)), for: .touchUpInside)
        return b
    }()

    public override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
    }
    
    @objc func didTapCancel(_ btn: UIButton) {
        self.delegate?.didTapCancel()
    }
    
    private func setupViews() {
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        self.view.addSubview(canvas)
        self.canvas.addSubview(cancelButton)
        NSLayoutConstraint.activate([
            self.canvas.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.canvas.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.canvas.widthAnchor.constraint(equalToConstant: self.view.bounds.width * 0.8),
            self.canvas.heightAnchor.constraint(equalToConstant: self.view.bounds.height * 0.5),
            self.cancelButton.heightAnchor.constraint(equalToConstant: 20),
            self.cancelButton.widthAnchor.constraint(equalToConstant: 60),
            self.cancelButton.centerXAnchor.constraint(equalTo: self.canvas.centerXAnchor),
            self.cancelButton.centerYAnchor.constraint(equalTo: self.canvas.centerYAnchor)
        ])
    }
}
