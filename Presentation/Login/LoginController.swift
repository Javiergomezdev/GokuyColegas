import UIKit

class LoginController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    let viewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Aquí puedes agregar cualquier configuración extra de UI si es necesario
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Agregar validación de login cuando se ingrese el correo y la contraseña
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
    }

    @objc func loginTapped() {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Por favor ingresa tu correo y contraseña.")
            return
        }

        viewModel.validateLogin(email: email, password: password) { result in
            switch result {
            case .success(let heroes):
                // Aquí puedes hacer algo con los héroes obtenidos
                print(heroes.map({$0.name}))
                // Navegar a la pantalla de héroes o algo similar
                let heroesVC = HeroesController()
                self.navigationController?.pushViewController(heroesVC, animated: true)
            case .failure(let error):
                self.showAlert(message: "Error al obtener héroes: \(error.localizedDescription)")
            }
        }
    }

    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
}
