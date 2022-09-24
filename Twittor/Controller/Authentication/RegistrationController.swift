//
//  RegistrationController.swift
//  Twittor
//
//  Created by Simon Peter Ojok on 23/09/2022.
//

import UIKit
import Firebase

class RegistrationController: UIViewController {
    
    // MARK: - Properties
    private let imagePicker = UIImagePickerController()
    private var profileImage: UIImage? = nil
    
    private lazy var plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleAddProfilePhoto), for: .touchUpInside)
        return button
    }()
    
    private lazy var emailContainerView: UIView = {
        let view = Utilities.inputContainerView(
            withImage: UIImage(named: "ic_mail_outline_white_2x-1"),
            textField: emailTextField
        )
        
        return view
    }()
    
    private let emailTextField: UITextField = {
        let tf = Utilities.textField(withPlaceHolder: "Email")
        tf.keyboardType = .emailAddress
        tf.autocapitalizationType = .none
        return tf
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = Utilities.inputContainerView(
            withImage: UIImage(named: "ic_lock_outline_white_2x"),
            textField: passwordTextField
        )
        
        return view
    }()
    
    private let passwordTextField: UITextField = {
        let tf = Utilities.textField(withPlaceHolder: "Password")
        tf.isSecureTextEntry = true
        tf.autocapitalizationType = .none
        return tf
    }()
    
    private lazy var fullnameContainerView: UIView = {
        let view = Utilities.inputContainerView(
            withImage: UIImage(named: "ic_mail_outline_white_2x-1"),
            textField: fullnameTextField
        )
        
        return view
    }()
    
    private let fullnameTextField: UITextField = {
        let tf = Utilities.textField(withPlaceHolder: "Full Name")
        tf.autocapitalizationType = .none
        return tf
    }()
    
    private lazy var usernameContainerView: UIView = {
        let view = Utilities.inputContainerView(
            withImage: UIImage(named: "ic_mail_outline_white_2x-1"),
            textField: usernameTextField
        )
        
        return view
    }()
    
    private let usernameTextField: UITextField = {
        let tf = Utilities.textField(withPlaceHolder: "Username")
        tf.autocapitalizationType = .none
        return tf
    }()
    
    private lazy var alreadyHaveAccount: UIButton = {
        let button = Utilities.attributedButton("Already have account?", "\tLogin")
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()
    
    private lazy var registrationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.twitterBlue, for: .normal)
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Selectors
    @objc func handleShowLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleAddProfilePhoto() {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func handleRegistration() {
        guard let profileImage = profileImage else { return }
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let fullname = fullnameTextField.text else { return }
        guard let username = usernameTextField.text else { return }
        
        let credentials = AuthCredentials(
            email: email,
            password: password,
            fullname: fullname,
            username: username,
            profileImage: profileImage
        )
        
        AuthService.shared.registerUser(credentials: credentials) {(error, dataReference) in
            guard let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow}) else {
                return
            }
            guard let tab = window.rootViewController as? MainTabController
            else { return }
            tab.authenticateUserAndConfigureUI()
            self.dismiss(animated: true)
        }
    }
    
    // MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .twitterBlue
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        view.addSubview(plusPhotoButton)
        
        plusPhotoButton.centerX(
            inView: view,
            topAnchor: view.safeAreaLayoutGuide.topAnchor,
            paddingTop: 32
        )
        plusPhotoButton.setDimensions(width: 128, height: 128)
        
        let stack = UIStackView(arrangedSubviews: [
            fullnameContainerView,
            usernameContainerView,
            emailContainerView,
            passwordContainerView,
            registrationButton
        ])
        
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fillEqually
        
        view.addSubview(stack)
        
        stack.anchor(
            top: plusPhotoButton.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingLeft: 16,
            paddingRight: 16
        )
        
        
        view.addSubview(alreadyHaveAccount)
        alreadyHaveAccount.anchor(
            left: view.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.rightAnchor,
            paddingLeft: 40,
            paddingRight: 40
        )
    }
}

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else { return }
        self.profileImage = profileImage
        
        plusPhotoButton.layer.cornerRadius = 128 / 2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.imageView?.contentMode = .scaleAspectFit
        plusPhotoButton.imageView?.clipsToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.layer.borderWidth = 3
        
        self.plusPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        dismiss(animated: true, completion: nil)
    }
}
