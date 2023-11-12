struct Word: Decodable {
    let value: String
    let transaltionSpa: String
    
    enum CodingKeys: String, CodingKey {
        case value = "text_eng"
        case transaltionSpa = "text_spa"
    }
}
