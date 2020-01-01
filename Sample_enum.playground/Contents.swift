import UIKit

    //https://academy.realm.io/jp/posts/david-east-simplifying-login-swift-enums/

// ただのenumです
enum LoginProviderBasic {
  case Email
  case Facebook
  case Google
  case Twitter
}

// String型のenumです
enum LoginProviderStr: String {
  case Email = "email"
  case Facebook = "facebook"
  case Google = "google"
  case Twitter = "twitter"
}

// LoginProviderAssociatedValueで使います
struct LoginUser {
  let email: String
  let password: String
  func isValid() -> Bool {
    return email != "" && password != ""
  }
}

// 色んな型のenumです
enum LoginProviderAssociatedValue {
  case Email (String, String) // サンプルソースでは型宣言に「:」があったが必要なし
  case Facebook (LoginUser) // structもいけます、これがオススメ。
  case Google
  case Twitter (Int) // Intだっていい
}

let myUser = LoginUser(email: "mymailaddress@yahoo.co.jp", password: "pass") // ユーザー情報元データの作成
let facebookUser = LoginProviderAssociatedValue.Facebook(myUser) // Facebookアカウント用データセット化

switch facebookUser { // このデータセットは何アカウントですか？
case let .Facebook(userData) where userData.isValid(): // Facebookアカウントで、ログイン可能状態の時
    print("login") // ログインの実施処理
    print("email:\(userData.email),password:\(userData.password)") // case let .Facebook(userData) とすることで、userDataから更に使える
    break
case let .Facebook(userData) where !userData.isValid(): // Facebookアカウントで、ログイン不可能状態の時
    print("error") // エラーメッセージを出す処理
    break
case .Facebook(_):
    break
case .Email(_, _):
    break
case .Google:
    break
case .Twitter(_):
    break
}



// enum内にfunctionを作成する
enum LoginProviderInFunction {
    case Email (String, String)
    case Facebook (LoginUser)
    case Google
    case Twitter (Int)
    
    // ログイン可能か判定する処理を中に入れる
    func login() -> Bool {
        switch self { // このデータセットは何アカウントですか？
        case let .Facebook(userData) where userData.isValid():
            print("email:\(userData.email),password:\(userData.password)")
            return true
        case let .Facebook(userData) where !userData.isValid():
            print("error")
            return false
        case .Facebook(_):
            return false
        case .Email(_, _):
            return false
        case .Google:
            return false
        case .Twitter(_):
            return false
        }
    }
}
let myProvider = LoginProviderInFunction.Facebook(myUser).login()

