//
//  ViewController.swift
//  Bankey
//
//  Created by Jason Hung on 2024/5/11.
//

import UIKit

protocol LogoutDelegate: AnyObject {
    func didLogout()
}

protocol LoginViewControllerDelegate: AnyObject {
//    func didLogin(_ sender: LoginViewController) // to pass data back as part of our protocal delegate
    func didLogin()
}

class LoginViewController: UIViewController {
    
    let titleLabel = UILabel()
    let introLabel = UILabel()
    
    let loginView = LoginView()
    let signinButton = UIButton(type: .system)
    let errorMessageLabel = UILabel()
    
    weak var delegate: LoginViewControllerDelegate?
    
    var username: String? {
        return loginView.usernameTextField.text
    }
    var password: String? {
        return loginView.passwordTextField.text
    }
    
    // animation variables
    var leadingEdgeOnScreen: CGFloat = 16
    var leadingEdgeOffScreen: CGFloat = -1000
    
    var titleLeadingAnchor: NSLayoutConstraint?
    var subTitleLeadingAnchor: NSLayoutConstraint?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        signinButton.configuration?.showsActivityIndicator = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animate()
    }
}

extension LoginViewController {
    private func style() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Bankey"
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 50, weight: .semibold)
        titleLabel.alpha = 0
        
        
        introLabel.translatesAutoresizingMaskIntoConstraints = false
        introLabel.text = "Your premium source of all things banking!"
        introLabel.textAlignment = .center
        introLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        introLabel.numberOfLines = 0
        introLabel.alpha = 0
        
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        signinButton.translatesAutoresizingMaskIntoConstraints = false
        signinButton.configuration = .filled()
        signinButton.configuration?.imagePadding = 8 // for indicator spacing
        signinButton.setTitle("Sign In", for: [])
        signinButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.isHidden = true
    }
    
    private func layout() {
        view.addSubview(titleLabel)
        view.addSubview(introLabel)
        view.addSubview(loginView)
        view.addSubview(signinButton)
        view.addSubview(errorMessageLabel)
        
        // LoginView
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1)
        ])
        
        // SigninButton
        NSLayoutConstraint.activate([
            signinButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            signinButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 1),
            signinButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        
        // ErrorMessageLabel
        NSLayoutConstraint.activate([
            errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: signinButton.bottomAnchor, multiplier: 2),
            errorMessageLabel.leadingAnchor.constraint(equalTo: signinButton.leadingAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: signinButton.trailingAnchor)
        ])
        
        // IntroLabel
        NSLayoutConstraint.activate([
            introLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
            loginView.topAnchor.constraint(equalToSystemSpacingBelow: introLabel.bottomAnchor, multiplier: 2)
        ])
        
        subTitleLeadingAnchor = introLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
        subTitleLeadingAnchor?.isActive = true
        
        // TitleLabel
        NSLayoutConstraint.activate([
            introLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 2.5),
            titleLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
        ])
        
        titleLeadingAnchor = titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
        titleLeadingAnchor?.isActive = true
        
    }
}

// MARK: Actions
extension LoginViewController {
    @objc func signInTapped(sender: UIButton) {
        errorMessageLabel.isHidden = true
        login()
    }
    
    private func login() {
        guard let username = username, let password = password else {
            assertionFailure("Username / password should never be nil")
            return
        }
        
        #warning("Need to flip back")
//        if username.isEmpty || password.isEmpty {
//            configureView(withMessage: "Username / password cannot be blank")
//            return
//        }
//        
        if username == "" && password == "" {
            signinButton.configuration?.showsActivityIndicator = true
            delegate?.didLogin()
        } else {
            configureView(withMessage: "Incorrect username / password")
        }
    }
    
    private func configureView(withMessage message: String) {
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
        shakeButton()
    }
    
    private func shakeButton() {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0, 10, -10, 10, 0]
        animation.keyTimes = [0, 0.16, 0.5, 0.83, 1]
        animation.duration = 0.4
        
        animation.isAdditive = true
        signinButton.layer.add(animation, forKey: "shake")
    }
    
}

// MARK: - Animation
extension LoginViewController {
    
    private func animate() {
        let duration = 2.0
        
        let animator1 = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            self.titleLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        animator1.startAnimation()
        
        let animator2 = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            self.subTitleLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        animator2.startAnimation(afterDelay: 0.2)
        
        let animator3 = UIViewPropertyAnimator(duration: duration * 2, curve: .easeInOut) {
            self.titleLabel.alpha = 1
            self.introLabel.alpha = 1
            self.view.layoutIfNeeded()
        }
        animator3.startAnimation(afterDelay: 0.2)
    }
}

