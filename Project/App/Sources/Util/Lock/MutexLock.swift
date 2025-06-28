//
//  MutexLock.swift
//  Flifin
//
//  Created by Aiden.lee on 6/29/25.
//

import Foundation
import os

/// 동기화를 위한 Mutex Lock 클래스입니다.
///
///
/// ```swift
/// let count = Mutex<Int>(0)
///
/// // Get
/// let foo = count.withLock { $0 }
///
/// // Set
/// count.withLock { $0 = 123 }
/// ```
public final class MutexLock<Value> {

  private var value: Value
  private let lock = UnfairLock()

  public init(_ value: Value) {
    self.value = value
  }

  @discardableResult
  public func withLock<U>(_ mutation: (inout Value) throws -> U) rethrows -> U {
    try lock.around {
      try mutation(&self.value)
    }
  }
}

public struct UnfairLock {

  private let unfairLock = OSAllocatedUnfairLock()

  public init() {}

  public func lock() {
    unfairLock.lock()
  }

  public func unlock() {
    unfairLock.unlock()
  }

  public func around<T>(_ closure: () throws -> T) rethrows -> T {
    lock()
    defer { unlock() }
    return try closure()
  }

  public func around(_ closure: () throws -> Void) rethrows {
    lock()
    defer { unlock() }
    try closure()
  }
}
