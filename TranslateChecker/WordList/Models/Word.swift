struct Word: Decodable, Equatable {
    let value: String
    let transaltionSpa: String
    
    enum CodingKeys: String, CodingKey {
        case value = "text_eng"
        case transaltionSpa = "text_spa"
    }
}
