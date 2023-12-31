//
//  DataStore.swift
//  letsPop (iOS)
//
//  Created by Randy Horman on 2023-12-27.
//

protocol DataEntity: Identifiable {}

protocol DataStoreController {
    var hasChanges: Bool { get }

    func performChanges(block: @escaping () -> Void)
    func save() throws
    func fetchObjects<Entity>(with request: DataEntityFetchRequest, completion: @escaping ([Entity]) -> Void) throws
}

struct DataEntityFetchRequest {
    let name: String
}

protocol DataEntityArrayAccess {
    associatedtype E: DataEntity

    var count: Int { get }
    var isEmpty: Bool { get }
    var values: [E] { get }

    subscript(index: Int) -> E { get set }
    func firstIndex(where predicate: (E) -> Bool) -> Int?
    mutating func append(_ element: E)
    mutating func removeValue(forID id: E.ID) -> E?
}

protocol DataEntityDictionaryAccess {
    associatedtype E: DataEntity
    associatedtype Keys: Collection where Keys.Element == E.ID
    associatedtype Values: Collection where Values.Element == E

    var count: Int { get }
    var isEmpty: Bool { get }
    var keys: Keys { get }
    var values: Values { get }

    subscript(id: E.ID) -> E? { get set }
    mutating func removeValue(forID id: E.ID) -> E?
}

struct DataEntityArray<E: DataEntity>: DataEntityArrayAccess {
    private var storage: [E] = []

    init() {}

    var count: Int {
        return storage.count
    }

    var isEmpty: Bool {
        return storage.isEmpty
    }

    subscript(index: Int) -> E {
        get { return storage[index] }
        set { storage[index] = newValue }
    }

    mutating func append(_ element: E) {
        storage.append(element)
    }

    func firstIndex(where predicate: (E) -> Bool) -> Int? {
        return storage.firstIndex(where: predicate)
    }

    mutating func removeValue(forID id: E.ID) -> E? {
        if let index = storage.firstIndex(where: { $0.id == id }) {
            return storage.remove(at: index)
        }
        return nil
    }

    var values: [E] {
        return storage
    }
}

struct DataEntityDictionary<E: DataEntity>: DataEntityDictionaryAccess {
    private var storage: [E.ID: E] = [:]

    init() {}

    subscript(id: E.ID) -> E? {
        get { return storage[id] }
        set { storage[id] = newValue }
    }

    var count: Int {
        return storage.count
    }

    var isEmpty: Bool {
        return storage.isEmpty
    }

    mutating func removeValue(forID id: E.ID) -> E? {
        return storage.removeValue(forKey: id)
    }

    var keys: Dictionary<E.ID, E>.Keys {
        return storage.keys
    }

    var values: Dictionary<E.ID, E>.Values {
        return storage.values
    }
}
