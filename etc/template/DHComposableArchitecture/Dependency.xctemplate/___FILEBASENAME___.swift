//___FILEHEADER___

import ComposableArchitecture

@DependencyClient
struct ___FILEBASENAMEASIDENTIFIER___: Sendable {
  
}

extension ___FILEBASENAMEASIDENTIFIER___: DependencyKey {
  static var liveValue: ___FILEBASENAMEASIDENTIFIER___ {
    return ___FILEBASENAMEASIDENTIFIER___()
  }
  
  static var previewValue: ___FILEBASENAMEASIDENTIFIER___ {
    return ___FILEBASENAMEASIDENTIFIER___()
  }
  
  static var testValue: ___FILEBASENAMEASIDENTIFIER___ {
    return ___FILEBASENAMEASIDENTIFIER___()
  }
}

extension DependencyValues {
  var ___FILEBASENAMEASIDENTIFIER___/*소문자로 바꾸기*/: ___FILEBASENAMEASIDENTIFIER___ {
    get { self[___FILEBASENAMEASIDENTIFIER___.self] }
    set { self[___FILEBASENAMEASIDENTIFIER___.self] = newValue }
  }
}
