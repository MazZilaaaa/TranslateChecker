protocol WordListService {
    func getList(offset: Int, size: Int, completion: @escaping (Result<WordListResponse, Error>) -> Void)
}
