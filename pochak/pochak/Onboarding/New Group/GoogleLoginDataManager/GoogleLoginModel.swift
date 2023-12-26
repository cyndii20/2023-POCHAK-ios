//
//  GoogleLoginModel.swift
//  pochak
//
//  Created by Seo Cindy on 12/26/23.
//

struct GoogleLoginResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: GoogleLoginModel
}

struct GoogleLoginModel : Codable {
    var id : String?
    var name : String?
    var email : String?
    var socialType : String?
    var accessToken : String?
    var refreshToken : String?
    var isNewMember : Bool?
}
