import Foundation
@testable import TranslateChecker

extension Word {
    static func tenWords() -> [Word] {
        try! JSONDecoder().decode([Word].self, from: tenWordsData())
    }
    
    static func tenWordsData() -> Data {
        """
        [
            {
              "text_eng":"primary school",
              "text_spa":"escuela primaria"
            },
            {
              "text_eng":"teacher",
              "text_spa":"profesor / profesora"
            },
            {
              "text_eng":"pupil",
              "text_spa":"alumno / alumna"
            },
            {
              "text_eng":"holidays",
              "text_spa":"vacaciones "
            },
            {
              "text_eng":"class",
              "text_spa":"curso"
            },
            {
              "text_eng":"bell",
              "text_spa":"timbre"
            },
            {
              "text_eng":"group",
              "text_spa":"grupo"
            },
            {
              "text_eng":"exercise book",
              "text_spa":"cuaderno"
            },
            {
              "text_eng":"quiet",
              "text_spa":"quieto"
            },
            {
              "text_eng":"(to) answer",
              "text_spa":"responder"
            }
        ]
        """.data(using: .utf8)!
    }
}
