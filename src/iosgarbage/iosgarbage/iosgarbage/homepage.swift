import UIKit
import SwiftUI

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    private func setupViews() {
        // Set the background color of the view
        view.backgroundColor = .white

        // Create logo ImageView
        let logoImageView = UIImageView()
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.image = UIImage(named: "logo") // Ensure you have an image set named 'logo' in your assets
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoImageView)

        // Create the Sign Up button
        let signUpButton = UIButton(type: .system)
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.backgroundColor = UIColor.green
        signUpButton.layer.cornerRadius = 5
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(signUpButton)

        // Create the Log In button
        let logInButton = UIButton(type: .system)
        logInButton.setTitle("Log In", for: .normal)
        logInButton.backgroundColor = UIColor.lightGray
        logInButton.layer.cornerRadius = 5
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logInButton)

        // Constraints for logoImageView
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 150),
            logoImageView.widthAnchor.constraint(equalToConstant: 150)
        ])

        // Constraints for signUpButton
        NSLayoutConstraint.activate([
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.bottomAnchor.constraint(equalTo: logInButton.topAnchor, constant: -20),
            signUpButton.widthAnchor.constraint(equalToConstant: 200),
            signUpButton.heightAnchor.constraint(equalToConstant: 50)
        ])

        // Constraints for logInButton
        NSLayoutConstraint.activate([
            logInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logInButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            logInButton.widthAnchor.constraint(equalToConstant: 200),
            logInButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

// In your AppDelegate or SceneDelegate, set HomeViewController as the rootViewController.
// window?.rootViewController = HomeViewController()
