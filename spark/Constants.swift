import Foundation

struct Constants {
    static let baseURL = "http://localhost:3000/"
    static let apiBaseURL = "\(baseURL)v1/"
    static let sessionURL = "\(apiBaseURL)session"
    static let accessToken = Secret.value
    static let headers = [
        "X-ACCESS-TOKEN": Constants.accessToken,
        "Content-Type": "application/json"
    ]
}
