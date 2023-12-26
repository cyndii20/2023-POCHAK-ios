//
//  GoogleLoginDataManager.swift
//  pochak
//
//  Created by Seo Cindy on 12/26/23.
//

import Alamofire

struct GoogleLoginDataManager {
    
    static let shared = GoogleLoginDataManager()
    
    func googleLoginDataManager(_ accessToken : String, _ completion: @escaping (GoogleLoginModel) -> Void) {
        let url = "http://pochak.site/google/login/" + accessToken

        //APIConstants.baseURL 로 바꾸기
        AF.request(url, method: .get).validate().responseDecodable(of: GoogleLoginResponse.self) { response in
               switch response.result {
               case .success(let result):
                   var resultData = result.result
                   completion(resultData)
               case .failure(let error):
                   print(error.localizedDescription)
               }
           }
    }
}
